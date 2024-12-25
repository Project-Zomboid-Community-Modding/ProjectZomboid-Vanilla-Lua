--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISApplyMakeUp = ISBaseTimedAction:derive("ISApplyMakeUp");

function ISApplyMakeUp:isValid()
    return true
end

function ISApplyMakeUp:start()
end

function ISApplyMakeUp:update()
end

function ISApplyMakeUp:stop()
    ISBaseTimedAction.stop(self)
end

function ISApplyMakeUp:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISApplyMakeUp:complete()
    -- checking
    local canUse = false
    for i,v in ipairs(MakeUpDefinitions.makeup) do
        if v.makeuptypes[self.item:getMakeUpType()] then
            if self.type == v.item  then
                canUse = true
                break
            end
        end
    end
    if not canUse then
        return false
    end

    local makeUpSelected = instanceItem(self.type)
    local previousMakeUp = self.character:getWornItem(makeUpSelected:getBodyLocation());

    self.character:getInventory():AddItem(makeUpSelected);
    sendAddItemToContainer(self.character:getInventory(), self.item);

    if previousMakeUp and self.character:getInventory():contains(previousMakeUp) then
        sendRemoveItemFromContainer(self.character:getInventory(), previousMakeUp);
        self.character:getInventory():Remove(previousMakeUp);
    end

    self.character:setWornItem(makeUpSelected:getBodyLocation(), makeUpSelected);
    sendClothing(self.character,makeUpSelected:getBodyLocation(), makeUpSelected);

    self.item:Use()
    sendItemStats(self.item)
    return true
end

function ISApplyMakeUp:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 1
end

function ISApplyMakeUp:new(character, item, type)
    local o = ISBaseTimedAction.new(self, character)
    o.stopOnWalk = false
    o.stopOnRun = true
    o.maxTime = o:getDuration()
    o.item = item
    o.type = type
    return o
end
