require "TimedActions/ISBaseTimedAction"

ISAddBaitToFishNetAction = ISBaseTimedAction:derive("ISAddBaitToFishNetAction");

function ISAddBaitToFishNetAction:isValid()
    if isClient() and self.bait then
        return self.character:getInventory():containsID(self.bait:getID())
    else
        return self.character:getInventory():contains(self.bait);
    end
end

function ISAddBaitToFishNetAction:update()
    self.bait:setJobDelta(self:getJobDelta());
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISAddBaitToFishNetAction:start()
    if isClient() then
        if self.bait then
            self.bait = self.character:getInventory():getItemById(self.bait:getID())
        end
    end

    self.bait:setJobType(getText("ContextMenu_Add_Bait"));
    self.bait:setJobDelta(0.0);

    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Low")
end

function ISAddBaitToFishNetAction:stop()
    ISBaseTimedAction.stop(self);
    self.bait:setJobDelta(0.0);
end

function ISAddBaitToFishNetAction:perform()
    self.bait:setJobDelta(0.0);

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISAddBaitToFishNetAction:complete()
    fishingNet.setBait(self.fishNet, self.bait:getHungChange() * -100);

    self.character:getInventory():Remove(self.bait);
    sendRemoveItemFromContainer(self.character:getInventory(), self.bait);

    return true;
end

function ISAddBaitToFishNetAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 200
end

function ISAddBaitToFishNetAction:new(character, fishNet, bait)
    local o = ISBaseTimedAction.new(self, character);
    o.fishNet = fishNet
    o.bait = bait
    o.maxTime = o:getDuration()
    return o;
end
