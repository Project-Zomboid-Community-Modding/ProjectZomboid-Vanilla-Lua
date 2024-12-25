--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISHurricaneLanternExtinguish = ISBaseTimedAction:derive("ISHurricaneLanternExtinguish");

function ISHurricaneLanternExtinguish:isValid()
    if isClient() and self.started then
        return true;
    end

    return self.item ~= nil and self.item:getType() == "Lantern_HurricaneLit";
end

function ISHurricaneLanternExtinguish:update()
end

function ISHurricaneLanternExtinguish:start()
    self.started = true;
end

function ISHurricaneLanternExtinguish:stop()
    self.started = false;
    ISBaseTimedAction.stop(self);
end

function ISHurricaneLanternExtinguish:perform()
    self.started = false;
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISHurricaneLanternExtinguish:complete()
    local candle = instanceItem("Base.Lantern_Hurricane")
    self.character:getInventory():AddItem(candle);
    candle:setUsedDelta(self.item:getCurrentUsesFloat());
    candle:setCondition(self.item:getCondition());
    candle:setFavorite(self.item:isFavorite());
    if self.item == self.character:getPrimaryHandItem() then
        self.character:setPrimaryHandItem(candle);
    else
        self.character:setSecondaryHandItem(candle);
    end
    self.character:getInventory():Remove(self.item);

    sendReplaceItemInContainer(self.character:getInventory(), self.item, candle)
    replaceItemInContainer(self.character:getInventory(), self.item, candle)

    return true;
end

function ISHurricaneLanternExtinguish:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 1
end

function ISHurricaneLanternExtinguish:new(character, item)
    local o = ISBaseTimedAction.new(self, character);
    o.item = item;
    o.stopOnWalk = false;
    o.stopOnRun = false;
    o.maxTime = o:getDuration();
    return o;
end
