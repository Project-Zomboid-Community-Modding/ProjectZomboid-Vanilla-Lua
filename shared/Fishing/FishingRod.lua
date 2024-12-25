Fishing = Fishing or {}

Fishing.FishingRod = {}

local FishingRod = Fishing.FishingRod

function FishingRod:new(player)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.player = player
    o.skillLevel = player:getPerkLevel(Perks.Fishing)
    o.strengthSkill = player:getPerkLevel(Perks.Strength)
    o.isFirstFishing = player:getModData().Fishing_IsFirstFishing == nil

    o.rodItem = player:getPrimaryHandItem()
    o.rodItemType = o.rodItem:getScriptItem():getWeaponSprite()
    o.rodItemTypeBend = o.rodItem:getScriptItem():getWeaponSprite() .. "Bend"

    o.bobber = nil
    o.spawnBobberDelayTimer = 0

    o.lineLen = nil
    o.rodCoeff = Fishing.rods[o.rodItem:getFullType()]
    if o.rodCoeff == nil then
        o.rodCoeff = 1
    end

    o.highTensionTimer = 0
    o.lowTensionTimer = 0
    o.tensionLimit = -1

    o.currentLineStatus = nil
    o.lineMoveCoeff = 0

    o.mpAimX = 0
    o.mpAimY = 0

    --o.wheelTimer = 0
    --o.wheelVal = 0
    --o.wheelFunc = function(val)
    --    o:onMouseWheel(val)
    --end
    --Events.OnMouseWheel.Add(o.wheelFunc)

    return o
end
--[[
function FishingRod:onMouseWheel(val)
    self.wheelTimer = 1
    self.wheelVal = val
    print(val)
end
--]]
function FishingRod:cast()
    self.spawnBobberDelayTimer = 85
    self.spawnBobberX, self.spawnBobberY = self:getSpawnBobberCoords()
end

function FishingRod:getSpawnBobberCoords()
    local dx = (ZombRand(3) - 1.5) / (self.skillLevel + 1)
    local dy = (ZombRand(3) - 1.5) / (self.skillLevel + 1)
    if isServer() then
        local x = self.mpAimX
        local y = self.mpAimY
        return x+dx, y+dy
    end
    local x, y = Fishing.Utils.getAimCoords(self.player, Fishing.actionProperties.defaultLineLen)
    return x+dx, y+dy
end

function FishingRod:update()
    --if self.wheelTimer > 0 then
    --    self.wheelTimer = self.wheelTimer - (UIManager.getMillisSinceLastRender() / 33.3) / 35
    --end

    if self.spawnBobberDelayTimer > 0 then
        self.spawnBobberDelayTimer = self.spawnBobberDelayTimer - getGameTime():getMultiplier()
        if self.spawnBobberDelayTimer <= 0 then
            self.bobber = Fishing.Bobber:new(self.player, self, self.spawnBobberX, self.spawnBobberY)
            local rodEndX, rodEndY = self:getRodEndXY()
            self.lineLen = IsoUtils.DistanceTo(rodEndX, rodEndY, self.bobber:getX(), self.bobber:getY())
        end
    end

    if self.bobber ~= nil then
        if self:updateLine() then
            self.bobber:update()
        else
            return false
        end
    end
    return true
end

function FishingRod:updateLine()
    self:updateLineMoveCoeff()

    local tension = self:getTension()
    self.tensionLimit = (120 + self.skillLevel * 10)*self.rodCoeff
    if self.isFirstFishing then
        self.tensionLimit = self.tensionLimit * 3
    end

    if tension > 0.8 then
        self.highTensionTimer = self.highTensionTimer + getGameTime():getMultiplier()

        if ZombRand(10) == 0 then
            self:damageLine()
            if self.rodItem:getModData().fishing_LineCondition <= 0 then
                self:brokeLine()
                Fishing.ManagerInstances[self.player:getPlayerNum()]:destroy()
                return false
            end
        end

        if self.highTensionTimer > self.tensionLimit then
            if ZombRand(4) == 0 then
                self:brokeLine()
                Fishing.ManagerInstances[self.player:getPlayerNum()]:destroy()
                return false
            else
                self:missFish()
            end
        end
    else
        self.highTensionTimer = 0
    end

    if tension < -0.8 and self.bobber.fish ~= nil then
        self.lowTensionTimer = self.lowTensionTimer + getGameTime():getMultiplier()

        if self.lowTensionTimer > self.tensionLimit then
            self:missFish()
        end
    else
        self.lowTensionTimer = 0
    end
    return true
end

function FishingRod:updateLineMoveCoeff()
    if self:isReel() then
        if self.currentLineStatus ~= "REEL" then
            self.lineMoveCoeff = 0.2
        end
        self.currentLineStatus = "REEL"
        if self.bobber.nibbleTimer > 0 and not self.bobber.catchFishStarted then
            self.bobber.catchFishStarted = true
        end
    elseif self:isReleaseLine() then
        self.currentLineStatus = "RELEASE"
        if self.currentLineStatus ~= "RELEASE" then
            self.lineMoveCoeff = 0.2
        end
        self.currentLineStatus = "RELEASE"
    else
        self.currentLineStatus = nil
    end

    if self.lineMoveCoeff > 1 then
        self.lineMoveCoeff = 1
    else
        self.lineMoveCoeff = self.lineMoveCoeff + 0.01*getGameTime():getMultiplier()*((self.strengthSkill+2.5)/5.0)
    end
end

function FishingRod:isPickupBobber()
    if self.bobber:isOnGround() then
        return true
    end
    local rodEndX, rodEndY = self:getRodEndXY()
    return IsoUtils.DistanceTo(rodEndX, rodEndY, self.bobber:getX(), self.bobber:getY()) < 0.6
end

function FishingRod:getTension()
    local rodEndX, rodEndY = self:getRodEndXY()
    local distToBobber = IsoUtils.DistanceTo(rodEndX, rodEndY, self.bobber:getX(), self.bobber:getY())

    if self.lineLen > distToBobber then
        local diff = distToBobber - self.lineLen
        if diff < -1 then return -1 end
        return diff
    else
        return distToBobber - self.lineLen
    end
end

function FishingRod:isReel()
    -- TODO: add controller support
    return (isMouseButtonDown(0) and not isMouseButtonDown(1)) --or (self.wheelTimer > 0 and self.wheelVal < 0)
end

function FishingRod:reel()
    if self:getTension() < 1 then
        self.lineLen = self.lineLen - 0.04 * getGameTime():getMultiplier() * (self.lineMoveCoeff * self.lineMoveCoeff)
    end
end

function FishingRod:isReleaseLine()
    -- TODO: add controller support
    return isMouseButtonDown(1) --or (self.wheelTimer > 0 and self.wheelVal > 0)
end

function FishingRod:releaseLine()
    if self:getTension() > -1 then
        self.lineLen = self.lineLen + 0.04 * getGameTime():getMultiplier() * (self.lineMoveCoeff * self.lineMoveCoeff)
    end
end

function FishingRod:isRodMove()
    local aimX, aimY = Fishing.Utils.getAimCoords(self.player, Fishing.actionProperties.defaultLineLen)
    return IsoUtils.DistanceTo(aimX, aimY, self.bobber:getX(), self.bobber:getY()) > 0.3
end

function FishingRod:getRodDxDy()
    if self.bobber == nil then return 0, 0 end

    local bobberX = self.bobber:getX()
    local bobberY = self.bobber:getY()
    local aimX, aimY = Fishing.Utils.getAimCoords(self.player, Fishing.actionProperties.defaultLineLen)
    local charX = self.player:getX()
    local charY = self.player:getY()
    ---------
    local vecToBobberX = bobberX - charX
    local vecToBobberY = bobberY - charY
    local vecToBobberLen = IsoUtils.DistanceTo(0, 0, vecToBobberX, vecToBobberY)

    local vecToBobberPerpendicularX = 1
    local vecToBobberPerpendicularY = -(vecToBobberX/vecToBobberY)
    local vecToBobberPerpendicularLen = IsoUtils.DistanceTo(0, 0, vecToBobberPerpendicularX, vecToBobberPerpendicularY)

    local vecToAimX = aimX - bobberX
    local vecToAimY = aimY - bobberY
    local vecToAimLen = IsoUtils.DistanceTo(0, 0, vecToAimX, vecToAimY)

    local dx = (vecToAimX*vecToBobberPerpendicularX + vecToAimY*vecToBobberPerpendicularY)/vecToBobberPerpendicularLen
    local dy = (vecToAimX*vecToBobberX + vecToAimY*vecToBobberY)/vecToBobberLen
    local dLen = IsoUtils.DistanceTo(0, 0, dx, dy)
    if dLen ~= 0 then
        dx = dx / dLen
        dy = dy / dLen
    end

    if bobberY < charY then
        dx = -dx
    end

    local coeff = 1
    if vecToAimLen < 3 then
        coeff = vecToAimLen / 3.0
    end

    return -dx*coeff, -dy*coeff
end

function FishingRod:getRodEndXY()
    local deg = math.deg(self.player:getForwardDirection():getDirection() + math.pi / 2)
    if deg < 0 then deg = math.abs(360 + deg) end

    local dx, dy = self:getRodDxDy()
    local x = self.player:getX() + math.sin(math.rad(180 - (deg + 30*dx)))*(1-dy*0.5) * 0.5
    local y = self.player:getY() + math.cos(math.rad(180 - (deg + 30*dx)))*(1-dy*0.5) * 0.5
    return x, y
end

function FishingRod:getLineTypeCoeff()
    if self.rodItem:getModData().fishing_LineType == nil then
        return Fishing.line["Base.FishingLine"]
    else
        return Fishing.line[self.rodItem:getModData().fishing_LineType]
    end
end

function FishingRod:damageLine()
    --print("self.rodItem ", self.rodItem)
    --print("self.rodItem:getModData() ", self.rodItem:getModData())
    --print("self.rodItem:getModData().fishing_LineCondition ", self.rodItem:getModData().fishing_LineCondition)
    --print("getLineTypeCoeff ", self:getLineTypeCoeff())
    if self.rodItem:getModData().fishing_LineCondition == nil then
        self.rodItem:getModData().fishing_LineCondition = 1.0
    end
    self.rodItem:getModData().fishing_LineCondition = self.rodItem:getModData().fishing_LineCondition - self:getLineTypeCoeff()
end

function FishingRod:brokeLine() -- TODO : move result of broke to fishing file
    Fishing.ManagerInstances[self.player:getPlayerNum()]:changeState("None")

    local breakRod = nil
    local replacement = Fishing.breakRodReplacement[self.rodItem:getFullType()]
    if replacement ~= nil then
        breakRod = self.player:getInventory():AddItem(replacement)
    end

    self.player:playSound("BreakFishingLine")
    addSound(self.player, self.player:getX(), self.player:getY(), self.player:getZ(), 20, 1)

    self.player:getInventory():Remove(self.rodItem);
    self.player:setPrimaryHandItem(breakRod)
    self.player:setSecondaryHandItem(breakRod)
    self.rodItem = nil
end

function FishingRod:missFish()
    self.rodItem:getModData().fishing_Lure = nil
    self.rodItem:setName(getText(self.rodItem:getScriptItem():getDisplayName()))
    self.bobber.fish = nil
end

function FishingRod:consumeLure(isTrash)
    local lure = self.rodItem:getModData().fishing_Lure
    if lure ~= nil then
        if Fishing.lure.ArtificalLure[lure] then
            local chance = ZombRand(30 * (self.skillLevel + 1))
            if chance == 0 and not isTrash then
                self.rodItem:getModData().fishing_Lure = nil
                self.rodItem:setName(getText(self.rodItem:getScriptItem():getDisplayName()))
            end
        else
            local chance = ZombRand(20)
            if chance > self.skillLevel and not isTrash then
                self.rodItem:getModData().fishing_Lure = nil
                self.rodItem:setName(getText(self.rodItem:getScriptItem():getDisplayName()))
            end
        end
    end
end

function FishingRod:resetItemModel()
    if self.rodItem ~= nil then
        self.rodItem:setWeaponSprite(self.rodItemType)
        self.player:resetEquippedHandsModels()
    end
end

function FishingRod:destroy()
    if self.bobber ~= nil then
        self.bobber:destroy()
        self.bobber = nil
    end
    Events.OnMouseWheel.Remove(self.wheelFunc)
end