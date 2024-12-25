require "TimedActions/ISBaseTimedAction"

ISChangeFishingRodEquip = ISBaseTimedAction:derive("ISChangeFishingRodEquip");

function ISChangeFishingRodEquip:isValid()
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISChangeFishingRodEquip:update()
    self.rod:setJobDelta(self:getJobDelta());
    self.item:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISChangeFishingRodEquip:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
    self.rod:setJobType(getText("UI_ChangeFishingRodEquip"));
    self.rod:setJobDelta(0.0);
    self.item:setJobType(getText("UI_ChangeFishingRodEquip"));
    self.item:setJobDelta(0.0);

    if not self.character:isSitOnGround() then
        self:setActionAnim("changeBait")
    else
        self:setActionAnim("Craft")
    end
end

function ISChangeFishingRodEquip:stop()
    ISBaseTimedAction.stop(self);
    self.rod:setJobDelta(0.0);
    self.item:setJobDelta(0.0);
end

function ISChangeFishingRodEquip:perform()
    self.rod:setJobDelta(0.0);
    self.item:setJobDelta(0.0);



    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISChangeFishingRodEquip:complete()
    if self.item:hasTag("FishingLine") then
        self.rod:getModData().fishing_LineType = self.item:getFullType()
        syncItemModData(self.character, self.rod)
        self.item:setUsedDelta(self.item:getCurrentUsesFloat() - 0.125)
        syncItemFields(self.character, self.item)
        if self.item:getCurrentUsesFloat() <= 0 then
            self.character:getInventory():Remove(self.item);
            sendRemoveItemFromContainer(self.character:getInventory(), self.item)
        end
        self.rod:getModData().fishing_LineCondition = 1.0
    else
        self.rod:getModData().fishing_HookType = self.item:getFullType()
        self.character:getInventory():Remove(self.item);
        sendRemoveItemFromContainer(self.character:getInventory(), self.item)
    end
    self.rod:syncItemFields()

    self.character:setSecondaryHandItem(self.rod);

    return true;
end

function ISChangeFishingRodEquip:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 160
end

function ISChangeFishingRodEquip:new(character, rod, item)
    local o = ISBaseTimedAction.new(self, character);
    o.character = character;
    o.rod = rod;
    o.item = item;
    o.maxTime = o:getDuration();
    return o;
end
