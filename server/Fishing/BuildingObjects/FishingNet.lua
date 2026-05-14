require "BuildingObjects/ISBuildingObject"

fishingNet = ISBuildingObject:derive("fishingNet");

function fishingNet:create(x, y, z, north, sprite)
    local grid = getCell():getGridSquare(x, y, z);
    ISInventoryPaneContextMenu.transferIfNeeded(self.character, self.item)
	ISTimedActionQueue.add(ISPlaceFishingNetAction:new(self.character, self.item, grid, sprite))
    if not isServer() then
        getCell():setDrag(nil, self.player);
    end
end

function fishingNet:new(character, item)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o:init();
    o:setNorthSprite("constructedobjects_01_14");
    o:setSprite("constructedobjects_01_15");
    o.character = character
    o.player = character:getPlayerNum();
    o.item = item
	o.skipBuildAction = true
    o.skipWalk = true;
    return o;
end

function fishingNet:isValid(square, north)
    if not self.character:getInventory():containsRecursive(self.item) then return false end
    return square:DistToProper(self.character:getCurrentSquare()) < 5 and square:getProperties():has(IsoFlagType.water);
--    return true;
end

function fishingNet:render(x, y, z, square)
    ISBuildingObject.render(self, x, y, z, square)
end

fishingNet.doTimestamp = function(net)
    net:getSquare():getModData()["fishingNetTS"] = getGameTime():getCalender():getTimeInMillis();
    net:getSquare():transmitModdata();
end

fishingNet.setBait = function(net, baitForce)
    if baitForce == nil then
        net:getSquare():getModData()["fishingNetBait"] = nil
    else
        if baitForce > 200 then baitForce = 200 end
        net:getSquare():getModData()["fishingNetBait"] = baitForce
    end

    net:getSquare():transmitModdata();
end

fishingNet.updateBait = function(net)
    local bait = net:getSquare():getModData()["fishingNetBait"]
    if bait ~= nil then
        local delta = ((getGameTime():getCalender():getTimeInMillis() - net:getSquare():getModData()["fishingNetTS"])/60000)/60
        bait = bait - delta * 10
        if bait <= 0 then
            bait = nil
        end
        net:getSquare():getModData()["fishingNetBait"] = bait
        net:getSquare():transmitModdata()
    end
end

fishingNet.remove = function(net, player)
    if isClient() then
        return
    end
    net:getSquare():transmitRemoveItemFromSquare(net);
    local item = player:getInventory():AddItem("Base.FishingNet");
    sendAddItemToContainer(player:getInventory(), item);
    player:playSound("RemoveFishingNet");
end

fishingNet.checkTrap = function(player, trap, hours)
    if isClient() then
        return
    end
    -- the fishnet can broke !
    local fishCaught = false;
    if hours > 15 and ZombRand(5) == 0 then
        player:playSound("CheckFishingNet");
        sendPlaySound("CheckFishingNet", false, player)
        trap:getSquare():transmitRemoveItemFromSquare(trap);

        local item = player:getInventory():AddItem("Base.BrokenFishingNet");
        sendAddItemToContainer(player:getInventory(), item);
        return;
    end
    if hours > 20 then
        hours = 20;
    end

    local isBait = false
    local baitChance = 0
    local baitAmount = trap:getSquare():getModData()["fishingNetBait"]
    if baitAmount ~= nil then
        isBait = true
        baitChance = 4 + (200 - baitAmount) / 25
    end

    for i=1,hours do
        if ZombRand(8) == 0 then
            local item = player:getInventory():AddItem(Fishing.fishNet[ZombRand(#Fishing.fishNet)+1])
            sendAddItemToContainer(player:getInventory(), item);
            fishCaught = true;
        end
        if isBait and ZombRand(baitChance) == 0 then
            local catchType = Fishing.fishNetWithBait[ZombRand(#Fishing.fishNet)+1]

            local fishConfig = nil
            for _, config in ipairs(Fishing.fishes) do
                if config.itemType == catchType then
                    fishConfig = config
                    break
                end
            end

            if fishConfig then
                local fishSizeData = fishConfig:getFishSizeData(70, 30, 0)

                local item = instanceItem(fishConfig.itemType);
                local nutritionFactor = 2.2 * fishSizeData.weight / item:getActualWeight()
                item:setCalories(item:getCalories() * nutritionFactor)
                item:setLipids(item:getLipids() * nutritionFactor)
                item:setCarbohydrates(item:getCarbohydrates() * nutritionFactor)
                item:setProteins(item:getProteins() * nutritionFactor)
                item:setWorldScale(fishSizeData.length / 100.0)

				local hungerFactor = fishSizeData.weight / fishConfig.weightFactor
				-- If fish is not bait, then min hunger should be 5 regardless of size. Same as in Fish.lua
				if fishConfig.itemType ~= "BaitFish" then
					if hungerFactor > 0.05 then
						item:setBaseHunger(-hungerFactor)
					else
						item:setBaseHunger(-0.05)
					end
				else
					item:setBaseHunger(-hungerFactor)
				end
                item:setHungChange(item:getBaseHunger())
                item:setActualWeight(fishSizeData.weight * 2.2)   -- weight is kg * 2.2 (in pound)
                item:setCustomWeight(true)

                if not RecipeCodeOnTest.cutFish(item, nil) then
                    item:setTooltip(getText("Tooltip_Fishing_TooSmallForSlicing"))
                end

                player:getInventory():AddItem(item)
                sendAddItemToContainer(player:getInventory(), item);
            else
                local item = player:getInventory():AddItem(catchType)
                sendAddItemToContainer(player:getInventory(), item);
            end

            fishCaught = true;
        end
    end
    if fishCaught then
        fishCaught = false;
        addXp(player, Perks.Fishing, 1)
    end
    fishingNet.updateBait(trap)
    fishingNet.doTimestamp(trap);
end
