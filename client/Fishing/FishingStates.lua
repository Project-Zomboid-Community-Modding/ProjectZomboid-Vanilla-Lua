Fishing = Fishing or {}
Fishing.States = {}

Fishing.States.None = {}
function Fishing.States.None:new(manager)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.manager = manager
    return o
end

function Fishing.States.None:start()
    self.manager:disable()
end

function Fishing.States.None:update()
    local primaryHandItem = self.manager.player:getPrimaryHandItem()
    if not (primaryHandItem ~= nil and primaryHandItem:hasTag("FishingRod")) then
        self.manager:disable()
    end

    if Fishing.Utils.isPlayerAimOnWater(self.manager.player) then
        self.manager:changeState("Idle")
    end
end

function Fishing.States.None:stop()
end

Fishing.States.Idle = {}
function Fishing.States.Idle:new(manager)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.manager = manager
    return o
end

function Fishing.States.Idle:start()
    local primaryHandItem = self.manager.player:getPrimaryHandItem()
    if not (primaryHandItem ~= nil and primaryHandItem:hasTag("FishingRod")) then
        self.manager:changeState("None")
        return
    end
    if self.manager.fishingRod == nil then
        self.manager.fishingRod = Fishing.FishingRod:new(self.manager.player)
    end
    self.manager.player:setFishingStage("Idle")
    self.manager.player:reportEvent("EventFishing")
end

function Fishing.States.Idle:update()
    if Fishing.Utils.isPlayerAimOnWater(self.manager.player) then
        Fishing.Utils.facePlayerToAim(self.manager.player)

        if Fishing.Utils.isCastButtonPressed(self.manager.joypad) and Fishing.Utils.isAccessibleAimDist(self.manager.player) then
            self.manager:changeState("Cast")
        end
    else
        self.manager:changeState("None")
    end
end

function Fishing.States.Idle:stop()
end



Fishing.States.Cast = {}
function Fishing.States.Cast:new(manager)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.manager = manager
    return o
end

function Fishing.States.Cast:start()
    self.manager.fishingRod:cast()
    self.manager.player:setFishingStage("Cast")
    self.sound = self.manager.player:playSound("CastFishingLine")
end

function Fishing.States.Cast:update()
    if self.manager.fishingRod.bobber ~= nil then
        self.manager:changeState("Wait")
        return
    end
    self.manager.fishingRod:update()
end

function Fishing.States.Cast:stop()
    self.manager.player:stopOrTriggerSound(self.sound)
end



Fishing.States.Wait = {}
function Fishing.States.Wait:new(manager)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.reelSoundStarted = false
    o.manager = manager
    return o
end

function Fishing.States.Wait:start()
    self.manager.player:setFishingStage("Idle")
    self.manager.tensionUI:setVisible(true)
end

function Fishing.States.Wait:update()
    self.manager.player:setIsAiming(true)
    if self.manager.fishingRod.bobber ~= nil then
        Fishing.Utils.FacePlayerToBobber(self.manager.player, self.manager.fishingRod.bobber:getX(), self.manager.fishingRod.bobber:getY())
    end
    self.manager:updateTensionUI()

    if self.manager.fishingRod.bobber.fish ~= nil and not self.reelSoundStarted then
        print("SOUND STARTED")
        self.sound = self.manager.player:playSound("ReelFishingLineSlow")
        self.reelSoundStarted = true
    elseif self.manager.fishingRod.bobber.fish == nil and self.reelSoundStarted then
        print("SOUND STOPPED")
        self.manager.player:stopOrTriggerSound(self.sound)
        self.reelSoundStarted = false
    end

    if self.manager.fishingRod:isReel() then self.manager:changeState("ReelIn") end
    if self.manager.fishingRod:isReleaseLine() then self.manager:changeState("ReelOut") end
    self.manager:updateAnim()

    if self.manager.fishingRod:isPickupBobber() then
        self.manager:changeState("PickupFish")
        return
    end

    self.manager:updateAnim()
    self.manager.fishingRod:update()
end

function Fishing.States.Wait:stop()
    if self.sound ~= nil then
        self.manager.player:stopOrTriggerSound(self.sound)
        self.reelSoundStarted = false
    end
end



Fishing.States.ReelIn = {}
function Fishing.States.ReelIn:new(manager)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.isHighTensionSound = false
    o.manager = manager

    return o
end

function Fishing.States.ReelIn:start()
    self.sound = self.manager.player:playSound("ReelFishingLineMedium")
end

function Fishing.States.ReelIn:update()
    self.manager.player:setIsAiming(true)
    if self.manager.fishingRod.bobber ~= nil then
        Fishing.Utils.FacePlayerToBobber(self.manager.player, self.manager.fishingRod.bobber:getX(), self.manager.fishingRod.bobber:getY())
    end
    self.manager:updateTensionUI()

    if self.manager.fishingRod:isReel() then
        self.manager.fishingRod:reel()
    else
        self.manager:changeState("Wait")
        return
    end

    if self.manager.fishingRod:isPickupBobber() then
        self.manager:changeState("PickupFish")
        return
    end

    self.manager:updateAnim()
    if not self.manager.fishingRod:update() then
        return
    end

    if self.manager.fishingRod:getTension() > 0.6 and not self.isHighTensionSound then
        self.manager.player:stopOrTriggerSound(self.sound)
        self.sound = self.manager.player:playSound("ReelFishingLineFast")
        self.isHighTensionSound = true
    elseif self.manager.fishingRod:getTension() <= 0.6 and self.isHighTensionSound then
        self.manager.player:stopOrTriggerSound(self.sound)
        self.sound = self.manager.player:playSound("ReelFishingLineMedium")
        self.isHighTensionSound = false
    end
end

function Fishing.States.ReelIn:stop()
    self.manager.player:stopOrTriggerSound(self.sound)
end



Fishing.States.ReelOut = {}
function Fishing.States.ReelOut:new(manager)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.manager = manager

    return o
end

function Fishing.States.ReelOut:start()
end

function Fishing.States.ReelOut:update()
    self.manager.player:setIsAiming(true)
    if self.manager.fishingRod.bobber ~= nil then
        Fishing.Utils.FacePlayerToBobber(self.manager.player, self.manager.fishingRod.bobber:getX(), self.manager.fishingRod.bobber:getY())
    end
    self.manager:updateTensionUI()

    if self.manager.fishingRod:isReleaseLine() then
        self.manager.fishingRod:releaseLine()
    else
        self.manager:changeState("Wait")
        return
    end

    if self.manager.fishingRod:isPickupBobber() then
        self.manager:changeState("PickupFish")
        return
    end

    self.manager:updateAnim()
    self.manager.fishingRod:update()
end

function Fishing.States.ReelOut:stop()
end



Fishing.States.PickupFish = {}
function Fishing.States.PickupFish:new(manager)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.manager = manager
    return o
end

function Fishing.States.PickupFish:start()
    self.manager.tensionUI:setVisible(false)

    local fishItem = self.manager.fishingRod.bobber:grabFish()
    if fishItem ~= nil then
        self.manager.fishingRod:consumeLure(self.manager.fishingRod.bobber.fish.isTrash)
        self.manager.fishingRod.bobber:destroy()
        self.manager.fishingRod.bobber = nil

        self.action = ISPickupFishAction:new(self.manager.player, self.manager.fishingRod.rodItem, fishItem)
        ISTimedActionQueue.add(self.action)
    else
        self.manager.player:Say(getText("IGUI_Fishing_NoCatch"))
        self.manager:changeState("None")
    end
end

function Fishing.States.PickupFish:update()
    local actionQueue = ISTimedActionQueue.getTimedActionQueue(self.manager.player)
    local lastAction = actionQueue.queue[#actionQueue.queue]
    if lastAction == nil or lastAction ~= self.action then
        self.manager:changeState("None")
    end
end

function Fishing.States.PickupFish:stop()
end
