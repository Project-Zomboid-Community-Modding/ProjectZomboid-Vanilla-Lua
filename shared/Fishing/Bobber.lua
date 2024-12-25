Fishing = Fishing or {}

Fishing.Bobber = {}
local Bobber = Fishing.Bobber

Fishing.ServerBobberManager = { }

function Bobber:new(player, fishingRod, x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.player = player
    o.fishingRod = fishingRod

    o.sq = getCell():getGridSquare(x, y, 0)
    o.dx = x - o.sq:getX()
    o.dy = y - o.sq:getY()
    o.z = 0
    ---
    if not isClient() then
        o.item = o.sq:AddWorldInventoryItem("Base.Bobber", o.dx, o.dy, o.z)
        print("Bobber:new at " .. x .. " " .. y);
        o.item:setWorldZRotation(0)
        if isServer() then
            Fishing.ServerBobberManager[o.player:getOnlineID()] = o;
        end
    else
        o.id = startFishingAction(o.player, o.fishingRod.rodItem, o.sq, o)
        print("Bobber:new")
    end

    o.player:playSound("LureHitWater");

    o.attractTimer = o:getNibbleTime()
    if o.player:isFishingCheat() then
        o.attractTimer = 100
    end
    o.nibbleTimer = 0

    o.lure = o.fishingRod.rodItem:getModData().fishing_Lure
    o.fishingLvl = player:getPerkLevel(Perks.Fishing)

    return o
end

function Bobber:getX()
    return self.sq:getX() + self.dx
end

function Bobber:getY()
    return self.sq:getY() + self.dy
end

function Bobber:getZ()
    return self.z
end

function Bobber:getNibbleTime()
    local x = self:getX()
    local y = self:getY()

    local fishAbundance = FishSchoolManager.getInstance():getFishAbundance(x, y)

    local numberOfFishCoeff = 1
    if fishAbundance == 0 then
        numberOfFishCoeff = 0
    elseif fishAbundance < 10 then
        numberOfFishCoeff = 0.5
    elseif fishAbundance <= 25 then
        numberOfFishCoeff = 1.0
    else
        numberOfFishCoeff = 1.5
    end

    local temperature = getClimateManager():getAirTemperatureForCharacter(self.player, false)
    local temperatureCoeff = 1
    if temperature >= 30 and temperature < 40 or temperature >= 0 and temperature < 15 then
        temperatureCoeff = 0.75
    elseif temperature >= 40 or temperature > -10 and temperature < 0 then
        temperatureCoeff = 0.5
    elseif temperature <= -10 then
        temperatureCoeff = 0.25
    end

    local weatherCoeff = 1
    if getClimateManager():getFogIntensity() >= 0.4 or getClimateManager():getWindPower() >= 0.5 then
        weatherCoeff = 0.8
    elseif RainManager.isRaining() then
        weatherCoeff = 1.2
    end

    local currentHour = math.floor(math.floor(GameTime.getInstance():getTimeOfDay() * 3600) / 3600);
    local timeCoeff = 1
    if (currentHour >= 4 and currentHour <= 6) or (currentHour >= 18 and currentHour <= 20) then
        timeCoeff = 1.2
    end

    local nibbleChance = 1 * numberOfFishCoeff * temperatureCoeff * weatherCoeff * timeCoeff * 100
    if nibbleChance == 0 then
        return 2000
    elseif nibbleChance < 40 then
        return 1500
    elseif nibbleChance < 65 then
        return 1000
    elseif nibbleChance < 80 then
        return 650
    else
        return 500
    end
end

function Bobber:update()
    if isClient() and self.item == nil then
        return;
    end
    local playerX = self.player:getX()
    local playerY = self.player:getY()
    local bobberX = self:getX()
    local bobberY = self:getY()
    local distToPlayer = IsoUtils.DistanceTo(playerX, playerY, bobberX, bobberY)

    if not isClient() then
        if self.attractTimer > 0 and self.fish == nil then
            self.attractTimer = self.attractTimer - getGameTime():getMultiplier()
            if self.attractTimer <= 0 then
                if self:attractFish() then
                    self.fish = Fishing.Fish:new(self.player, self.lure, self:getX(), self:getY())
                    self.nibbleTimer = 360
                end
                self.attractTimer = self:getNibbleTime() * 0.8
                if self.player:isFishingCheat() then
                    self.attractTimer = 60
                end
                if Fishing.Utils.isNearShore(self:getX(), self:getY()) then
                    self.attractTimer = self.attractTimer * 2
                end
                if distToPlayer < 3 then
                    self.attractTimer = self.attractTimer * 3
                end
            end
        end

        if self.nibbleTimer > 0 then
            self.nibbleTimer = self.nibbleTimer - getGameTime():getMultiplier()
            if self.nibbleTimer <= 0 and not self.catchFishStarted then
                if self.fish and not self.fish.isTrash then
                    self.fishingRod.rodItem:getModData().fishing_Lure = nil
                    self.fishingRod.rodItem:setName(getText(self.fishingRod.rodItem:getScriptItem():getDisplayName()))
                end
                self.fish = nil
            end
            if self.catchFishStarted then
                self.nibbleTimer = -1
            end
        end
    end
    ---------------
    local tension = self.fishingRod:getTension()
    local rodEndX, rodEndY = self.fishingRod:getRodEndXY()

    local fishForceX = 0
    local fishForceY = 0
    if self.fish ~= nil then
        self.fish:update(self:getX(), self:getY())
        fishForceX = self.fish.dx
        fishForceY = self.fish.dy
    end

    local tensionForceX = 0
    local tensionForceY = 0
    if tension > 0 then
        tensionForceX = (rodEndX - self:getX()) * tension
        tensionForceY = (rodEndY - self:getY()) * tension
    end

    if IsoUtils.DistanceTo(playerX, playerY, bobberX + fishForceX * 2.5, bobberY) < distToPlayer then
        fishForceX = -fishForceX
    end

    if IsoUtils.DistanceTo(playerX, playerY, bobberX, bobberY + fishForceY * 2.5) < distToPlayer then
        fishForceY = -fishForceY
    end

    -- Not move to ground
    if not Fishing.Utils.isWaterCoords(self:getX() + fishForceX * 2.5, self:getY() + fishForceY * 2.5) then
        fishForceX, fishForceY = self:getFreeWaterDirection()
    end

    if self.player:isLocalPlayer() then
        self:move(tensionForceX * 0.025 + fishForceX * 2.5, tensionForceY * 0.025 + fishForceY * 2.5)
    end
end

function Bobber:getFreeWaterDirection()
    local x = self:getX()
    local y = self:getY()

    local results = {}
    for i = -1, 1 do
        for j = -1, 1 do
            if (not (i == 0 and j == 0)) and Fishing.Utils.isWaterCoords(x+i, y+j) then
                table.insert(results, { dx = i, dy = j})
            end
        end
    end
    if #results == 0 then
        return 0, 0
    end
    local res = results[ZombRand(#results)+1]
    return res.dx * 0.0015, res.dy * 0.0015
end

function Bobber:move(dx, dy)
    self.dx = self.dx + dx * getGameTime():getMultiplier()
    self.dy = self.dy + dy * getGameTime():getMultiplier()

    if self.item then
        local selfX = self:getX()
        local selfY = self:getY()
        local squareX = fastfloor(selfX)
        local squareY = fastfloor(selfY)
        if (squareX ~= self.sq:getX()) or (squareY ~= self.sq:getY()) then
            self.sq:RemoveTileObject(self.item:getWorldItem())
            self.sq = getCell():getGridSquare(squareX, squareY, self.z)
            self.dx = selfX - squareX
            self.dy = selfY - squareY
            self.sq:AddWorldInventoryItem(self.item, self.dx, self.dy, 0, false)
        else
            self.item:getWorldItem():setOffset(self.dx, self.dy, self.z)
        end
    end
end

function Bobber:attractFish()
    local temperatureData = Fishing.Utils.getTemperatureParams(self.player)
    local weatherData = Fishing.Utils.getWeatherParams()
    local timeData = Fishing.Utils.getTimeParams()
    local hookData = Fishing.Utils.getHookParams(self.fishingRod.rodItem:getModData().fishing_HookType)
    local fishNumberData = Fishing.Utils.getFishNumParams(self:getX(), self:getY())

    local chance = 0.8 * temperatureData.coeff * weatherData.coeff * timeData.coeff * hookData.coeff * fishNumberData.coeff

    if ZombRand(100) < chance * 100 or self.player:isFishingCheat() then
        return true
    end
    return false
end

function Bobber:grabFish()
    if self.fish == nil then
        return nil
    end
    return self.fish.fishItem
end

function Bobber:isOnGround()
    return not Fishing.Utils.isWaterCoords(self:getX(), self:getY())
end

function Bobber:destroy()
    if not isClient() then
        if isServer() then
            if self.fish then
                -- TODO check if PickupFish action was cancelled on client
                if true then
                    log(DebugType.Action, '[Bobber:destroy] '..tostring(self.player)..' add inventory item '..tostring(self.fish.fishItem))

                    self.player:getInventory():AddItem(self.fish.fishItem)
                    sendAddItemToContainer(self.player:getInventory(), self.fish.fishItem);
                    self.player:getModData()["fishing_CatchDone_" .. self.fish.fishItem:getFullType()] = true
                    local fishSize = self.fish.fishItem:getModData().fishing_FishSize
                    local xpToGain = 1;
                    if fishSize then
                        xpToGain = 2 * fishSize
                    end
                    addXp(self.player, Perks.Fishing, xpToGain);
                    self.player:getModData().Fishing_IsFirstFishing = true

                    Fishing.ServerBobberManager[self.player:getOnlineID()] = nil;
                else
                    log(DebugType.Action, '[Bobber:destroy] '..tostring(self.player)..' add world inventory item '..tostring(self.fish.fishItem))

                    local square = self.player:getCurrentSquare()
                    local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(self.player, square, self.fish.fishItem)
                    self.player:getCurrentSquare():AddWorldInventoryItem(self.fish.fishItem, dropX, dropY, dropZ);
                    self.player:getModData().Fishing_IsFirstFishing = true
                end
            end
        end

        self.item:getWorldItem():getSquare():transmitRemoveItemFromSquare(self.item:getWorldItem());
        self.item:getWorldItem():removeFromWorld()
        self.item:getWorldItem():removeFromSquare()
        self.item:getWorldItem():setSquare(nil)
    else
        removeAction(self.id, true)
    end
end

Bobber.onFishingActionMPUpdate = function(data)
    local bobber
    if isServer() then
        bobber = Fishing.ServerBobberManager[data.player:getOnlineID()];
    else
        local manager = Fishing.ManagerInstances[data.player:getPlayerNum()]
        bobber = manager.fishingRod.bobber
    end
    if data.UpdateFish then
        if data.fish then
            local fish = {}
            setmetatable(fish, Fishing.Fish)
            for k,v in pairs(data.fish) do
                fish[k] = v
            end
            fish.fishItem = data.fishItem

            bobber.fish = fish
        else
            print("Bobber.onFishingActionMPUpdate bobber.fish = nil")
            bobber.fish = nil
        end
    end
    if data.CreateBobber then
        bobber.item = data.bobberItem
        bobber.sq = bobber.item:getWorldItem():getSquare()
    end
    if isServer() and data.UpdateBobberParameters then
        if not bobber then
            print("Can't find bobber")
            return
        end
        -- Offset will sync in syncIsoObject, just replace the square and send it to clients
        local _bobberX = tonumber(data.bobberX)
        local _bobberY = tonumber(data.bobberY)

        local args = { oldSqX = bobber.sq:getX(), oldSqY = bobber.sq:getY(),
                       bobberX = _bobberX, bobberY = _bobberY,
                       bobberID = bobber.item:getID(),
                       rodID = bobber.fishingRod.rodItem:getID() }
        sendServerCommand('fishing', 'changeBobberSquare', args);

        local squareX = fastfloor(_bobberX)
        local squareY = fastfloor(_bobberY)

        bobber.sq:RemoveTileObject(bobber.item:getWorldItem())
        bobber.sq = getCell():getGridSquare(squareX, squareY, bobber.z)
        bobber.sq:AddWorldInventoryItem(bobber.item, _bobberX, _bobberY, 0, false)
    end
    if data.DestroyBobber and self.item then
        bobber.item:getWorldItem():removeFromWorld()
        bobber.item:getWorldItem():removeFromSquare()
        bobber.item:getWorldItem():setSquare(nil)
    end
end

Events.OnFishingActionMPUpdate.Add(Bobber.onFishingActionMPUpdate);
