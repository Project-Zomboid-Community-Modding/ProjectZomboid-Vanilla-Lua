require "TimedActions/ISBaseTimedAction"

ISPickupFishAction = ISBaseTimedAction:derive("ISPickupFishAction");

function ISPickupFishAction:isValid()
    return true
end

function ISPickupFishAction:animEvent(event, parameter)
    if event == 'PickupFishUpdate' then
        self.netAction:getProgress()
        self:PickupFishUpdate()
    end
end

function ISPickupFishAction:PickupFishUpdate()
    if not isServer() and self:getJobDelta() >= self.startShowModel and not self.fishInArm then
        if self.item:getModData().fishing_FishHandItem ~= nil then
            self:setOverrideHandModels(self.rod, self.item:getModData().fishing_FishHandItem);
        else
            self:setOverrideHandModels(self.rod:getStaticModel(), getItemStaticModel("Base.FishingTrash"));
        end

        self.fishInArm = true
    end
    local jobDelta
    if isServer() then
        jobDelta = self.netAction:getProgress()
    else
        jobDelta = self:getJobDelta()
    end
    if jobDelta >= self.finishShowModel and not self.fishInInv then
        if not isServer() then
            self:setOverrideHandModels(self.rod, nil);
        end
        self.fishInInv = true
        if not isServer() then
            self.character:Say("+1 " .. self.item:getName())
        end
        if not isClient() then
            self.character:getInventory():AddItem(self.item)
            self.character:getModData()["fishing_CatchDone_" .. self.item:getFullType()] = true

            self.character:getModData().Fishing_IsFirstFishing = true
        end
    end
    if not isServer() then
        self.character:setMetabolicTarget(Metabolics.LightDomestic);
    end
end

function ISPickupFishAction:update()
    self:PickupFishUpdate()
end

function ISPickupFishAction:serverStart()
	emulateAnimEvent(self.netAction, 100, "PickupFishUpdate", nil)
end

function ISPickupFishAction:start()
    if self.isFish then
        self.character:setFishingStage("PickUp")
    else
        self.character:setFishingStage("PickUpTrash")
    end
    self.character:playSound("PickUpFish");
    if not isClient() then
        local fishSize = self.item:getModData().fishing_FishSize
        if fishSize == nil then
            addXp(self.character, Perks.Fishing, 1)
        else
            addXp(self.character, Perks.Fishing, 2 * fishSize)
        end
    end
    if not isServer() then
        if self.character:getModData().fishing_catchedFish == nil then
            self.character:getModData().fishing_catchedFish = {}
        end
        self.character:getModData().fishing_catchedFish[self.item:getFullType()] = true
    end
end

function ISPickupFishAction:stop()
    ISBaseTimedAction.stop(self);

    self.character:PlayAnim("Idle")

    if not self.fishInInv then
        if not isClient() then
            local square = self.character:getCurrentSquare()
            local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(self.character, square, self.item)
            self.character:getCurrentSquare():AddWorldInventoryItem(self.item, dropX, dropY, dropZ);
            self.character:getModData().Fishing_IsFirstFishing = true
        end

        ISInventoryPage.renderDirty = true
    end
end

function ISPickupFishAction:perform()
    self.character:PlayAnim("Idle")

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISPickupFishAction:complete()
    return true;
end

function ISPickupFishAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    if self.isFish then
        return 267
    else
        return 187
    end
end

function ISPickupFishAction:new(character, rod, fish)
    local o = ISBaseTimedAction.new(self, character);
    o.rod = rod;
    if isServer() then
        o.item = getPickedUpFish(character)
    else
        o.item = fish
    end
    o.isFish = o.item:getModData().fishing_FishHandItem ~= nil
    o.startShowModel = 0.12
    o.finishShowModel = 0.8
    if not o.isFish then
        o.startShowModel = 0.17
        o.finishShowModel = 0.7
    end

    o.maxTime = o:getDuration()

    o.fishInArm = false
    o.fishInInv = false

    return o;
end
