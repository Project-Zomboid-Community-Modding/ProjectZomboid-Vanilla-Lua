require "TimedActions/ISBaseTimedAction"

AddChumToWaterAction = ISBaseTimedAction:derive("AddChumToWaterAction");

function AddChumToWaterAction:isValid()
    if isClient() and self.chum then
        return self.character:getInventory():containsID(self.chum:getID())
    else
        return self.character:getInventory():contains(self.chum);
    end
end

function AddChumToWaterAction:update()
    self.chum:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function AddChumToWaterAction:start()
    self.chum:setJobType(getText("ContextMenu_Add_Bait"));
    self.chum:setJobDelta(0.0);

    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Low")
end

function AddChumToWaterAction:stop()
    ISBaseTimedAction.stop(self);
    self.chum:setJobDelta(0.0);
end

function AddChumToWaterAction:perform()
    self.chum:setJobDelta(0.0);

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function AddChumToWaterAction:complete()
    if self.chum:getHungChange() ~= 0 then
        FishSchoolManager.getInstance():addChum(self.square:getX(), self.square:getY(), -400*self.chum:getHungChange())

        local args = { x=self.square:getX(), y=self.square:getY(), force=-400*self.chum:getHungChange() }
        sendServerCommand(self.character, 'fishing', 'addChumToWater', args)
    end
    self.character:getInventory():Remove(self.chum);
    sendRemoveItemFromContainer(self.character:getInventory(), self.chum);

    return true;
end

function AddChumToWaterAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 200
end

function AddChumToWaterAction:new(character, chum, square)
    local o = ISBaseTimedAction.new(self, character);
    o.chum = chum
    o.square = square
    o.maxTime = o:getDuration();
    o.character = character;
    return o;
end
