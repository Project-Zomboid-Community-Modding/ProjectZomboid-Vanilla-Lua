Fishing = Fishing or {}
Fishing.FishingManager = {}
local FishingManager = Fishing.FishingManager

function FishingManager:new(player, joypad)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.player = player
    o.joypad = joypad

    o:initTensionUI()
    o:eventHooks()

    o.state = nil
    o.states = {}
    o:initStates()

    if getCore():getDebug() and getDebugOptions():getBoolean("DebugDraw.FishingZones") then
        --self.fishingDebugWindow = FishingDebugWindow:new(player)
        --self.fishingDebugWindow:initialise();
        --self.fishingDebugWindow:instantiate();
        --self.fishingDebugWindow:addToUIManager()
    end

    return o
end

function FishingManager:initStates()
    self.states["None"] = Fishing.States.None:new(self)
    self.states["Idle"] = Fishing.States.Idle:new(self)
    self.states["Cast"] = Fishing.States.Cast:new(self)
    self.states["Wait"] = Fishing.States.Wait:new(self)
    self.states["ReelIn"] = Fishing.States.ReelIn:new(self)
    self.states["ReelOut"] = Fishing.States.ReelOut:new(self)
    self.states["PickupFish"] = Fishing.States.PickupFish:new(self)

    self.state = self.states["None"]
    self.state:start()
end

function FishingManager:initTensionUI()
    self.tensionUI = Fishing.ISTensionUI:new(self.player)
    self.tensionUI:initialise();
    self.tensionUI:instantiate();
    self.tensionUI:setVisible(false)
    self.tensionUI:backMost()
    self.tensionUI:addToUIManager()
end

function FishingManager:eventHooks()
    self.onTickFunc = function()
        self:update()
    end
    Events.OnTick.Add(self.onTickFunc)

    self.onSave = function()
        self:destroy()
    end
    Events.OnSave.Add(self.onSave)
end

function FishingManager:removeEventHooks()
    Events.OnTick.Remove(self.onTickFunc)
    Events.OnSave.Remove(self.onSave)
end

function FishingManager:update()
    if self.state == self.states["None"] and not Fishing.Utils.isPlayerAimOnWater(self.player, true) then
        self.player:setVariable("FishingFinished", true)
    end
    if self.state ~= self.states["None"] and (Fishing.Utils.isStopFishingButtonPressed(self.joypad)) then
        if self.state ~= self.states["Idle"] and self.fishingRod ~= nil then
            self.fishingRod:damageLine()
        end
        self:changeState("None")
        self.player:setVariable("FishingFinished", true)
    else
        self.state:update()
    end
end

function FishingManager:changeState(stateName)
    self.state:stop()
    self.state = self.states[stateName]
    self.state:start()
end

function FishingManager:disable()
    self.player:setVariable("FishingFinished", true)

    if self.fishingRod ~= nil then
        if self.fishingRod.bobber ~= nil and self.fishingRod.bobber.fish ~= nil and self.fishingRod.rodItem ~= nil then
            self.fishingRod:consumeLure()
        end

        self.fishingRod:resetItemModel()
        self.fishingRod:destroy()
        self.fishingRod = nil
    end
    self.tensionUI:setVisible(false)

    if self.states["ReelIn"].sound ~= nil then
        self.player:stopOrTriggerSound(self.states["ReelIn"].sound)
    end
end

function FishingManager:destroy()
    self:disable()
    self:removeEventHooks()
    self.tensionUI:removeFromUIManager()

    --if self.fishingDebugWindow ~= nil then
        --self.fishingDebugWindow:destroy()
    --end
    --getCore():setZoomEnalbed(true)
end

FishingManager.onFishingActionMPUpdate = function(data)
    if data.Reject then
        Fishing.FishingManager:destroy()
    end
end

Events.OnFishingActionMPUpdate.Add(FishingManager.onFishingActionMPUpdate);

function FishingManager:updateAnim()
    if self.fishingRod.bobber ~= nil and self.fishingRod.bobber.fish ~= nil then
        if self.fishingRod.bobber.fish.fishSizeLen <= 15 then
            self.player:setFishingStage("Strike")
        elseif self.fishingRod.bobber.fish.fishSizeLen <= 30 then
            self.player:setFishingStage("StrikeMedium")
        else
            self.player:setFishingStage("StrikeHard")
        end
    else
        if self.fishingRod:isReel() then
            self.player:setFishingStage("Strike")
        else
            self.player:setFishingStage("Idle")
        end

        self.fishingRod.rodItem:setWeaponSprite(self.fishingRod.rodItemType)
        self.player:resetEquippedHandsModels()
        return
    end

    local dx, dy = self.fishingRod:getRodDxDy()
    self.player:setVariable("FishingX", tostring(dx))
    self.player:setVariable("FishingY", tostring(dy))

    self.fishingRod.rodItem:setWeaponSprite(self.fishingRod.rodItemTypeBend)
    self.player:resetEquippedHandsModels()
end

function FishingManager:updateTensionUI()
    self.tensionUI:updateValue(self.fishingRod:getTension())
end