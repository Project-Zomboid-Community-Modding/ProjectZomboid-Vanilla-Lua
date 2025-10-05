require "TimedActions/ISBaseTimedAction"

AIAttachLureAction = ISBaseTimedAction:derive("AIAttachLureAction");

function AIAttachLureAction:isValid()
    if isClient() and self.lure and self.rod then
        return self.character:getInventory():containsID(self.lure:getID()) and self.character:getInventory():containsID(self.rod:getID())
    else
        return self.character:getInventory():contains(self.lure);
    end
end

function AIAttachLureAction:update()
    self.rod:setJobDelta(self:getJobDelta());
    self.lure:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function AIAttachLureAction:start()
    if isClient() then
        if self.lure then
            self.lure = self.character:getInventory():getItemById(self.lure:getID())
        end
        if self.rod then
            self.rod = self.character:getInventory():getItemById(self.rod:getID())
        end
    end
    self.rod:setJobType(getText("ContextMenu_Add_Bait"));
    self.rod:setJobDelta(0.0);
    self.lure:setJobType(getText("ContextMenu_Add_Bait"));
    self.lure:setJobDelta(0.0);

    if not self.character:isSitOnGround() then
        self:setActionAnim("changeBait")
    else
        self:setActionAnim("Craft")
    end
    self.sound = self.character:playSound("AddBaitToFishingLine")
end

function AIAttachLureAction:stop()
    self:stopSound()
    self.rod:setJobDelta(0.0);
    self.lure:setJobDelta(0.0);
    ISBaseTimedAction.stop(self);
end

function AIAttachLureAction:perform()
    self:stopSound()
    self.rod:setJobDelta(0.0);
    self.lure:setJobDelta(0.0);

    self.character:setPrimaryHandItem(self.rod);
    self.character:setSecondaryHandItem(nil);

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function AIAttachLureAction:complete()

    local defaultName = self.rod:getScriptItem():getDisplayName()

    self.rod:setName(Translator.getText(defaultName) .. " " .. getText("UI_AttachLure_With") .. " " .. self.lure:getDisplayName())

    self.rod:getModData().fishing_Lure = self.lure:getFullType()

    local doRemove = false
    if Fishing.lure.All[self.lure:getFullType()].amountOfFoodHunger == -1 then
        self.character:getInventory():Remove(self.lure);
        doRemove = true
    else
        self.lure:setHungChange(self.lure:getHungChange() + Fishing.lure.All[self.lure:getFullType()].amountOfFoodHunger / 100)
        if self.lure:getHungChange() >= 0 then
            self.character:getInventory():Remove(self.lure);
            doRemove = true
        end
    end

    if isServer() then
        local args = { rodId=self.rod:getID(), lureFullType=self.lure:getFullType(), lureId=self.lure:getID() }
        sendServerCommand(self.character, 'fishing', 'attachLure', args)

        if doRemove then
            sendRemoveItemFromContainer(self.character:getInventory(), self.lure)
        end

    end

    return true;
end

function AIAttachLureAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 160
end

function AIAttachLureAction:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound)
    end
end

function AIAttachLureAction:new(character, rod, lure)
    local o = ISBaseTimedAction.new(self, character);
    o.rod = rod;
    o.lure = lure;
    o.maxTime = o:getDuration();
    return o;
end
