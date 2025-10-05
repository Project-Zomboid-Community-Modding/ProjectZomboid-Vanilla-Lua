require "TimedActions/ISBaseTimedAction"

AIRemoveLureAction = ISBaseTimedAction:derive("AIRemoveLureAction");

function AIRemoveLureAction:isValid()
    if isClient() and self.rod then
        return self.character:getInventory():containsID(self.rod:getID());
    else
        return self.character:getInventory():contains(self.rod);
    end
end

function AIRemoveLureAction:update()
    self.rod:setJobDelta(self:getJobDelta());
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function AIRemoveLureAction:start()
    if isClient() and self.rod then
        self.rod = self.character:getInventory():getItemById(self.rod:getID())
    end
    self.rod:setJobType(getText("ContextMenu_Remove_Bait"));
    self.rod:setJobDelta(0.0);

    if not self.character:isSitOnGround() then
        self:setActionAnim("changeBait")
    else
        self:setActionAnim("Craft")
    end
    self.sound = self.character:playSound("RemoveBaitToFishingLine")
end

function AIRemoveLureAction:stop()
    ISBaseTimedAction.stop(self);
    self.rod:setJobDelta(0.0);
end

function AIRemoveLureAction:perform()
    self.rod:setJobDelta(0.0);

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function AIRemoveLureAction:complete()
    log(DebugType.Action, '[ClientCommands.fishing.removeLure] '..tostring(self.character)..' rod '..tostring(self.rod))

    local defaultName = self.rod:getScriptItem():getDisplayName()
    self.rod:setName(Translator.getText(defaultName))

    local lure = nil
    local lureId = -1
    if Fishing.IsArtificalLure(self.rod:getModData().fishing_Lure) then
        lure = self.character:getInventory():AddItem(self.rod:getModData().fishing_Lure)
        lureId = lure:getID()
    end
    self.rod:getModData().fishing_Lure = nil

    if lure then
        sendAddItemToContainer(self.character:getInventory(), lure)
    end
    if isServer() then
        if lure then
            local args = { rodId=self.rod:getID(), lureId = lure:getID() }
            sendServerCommand(self.character, 'fishing', 'removeLure', args)
        else
            local args = { rodId=self.rod:getID(), lureId = -1 }
            sendServerCommand(self.character, 'fishing', 'removeLure', args)
        end
    end

    return true;
end

function AIRemoveLureAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 160
end

function AIRemoveLureAction:new(character, rod)
    local o = ISBaseTimedAction.new(self, character);
    o.rod = rod;
    o.maxTime = o:getDuration()
    return o;
end
