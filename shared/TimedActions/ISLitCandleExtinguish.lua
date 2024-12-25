--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISLitCandleExtinguish = ISBaseTimedAction:derive("ISLitCandleExtinguish");

function ISLitCandleExtinguish:isValid()
    if isClient() and self.started then
        return true;
    end

    return self.item ~= nil and self.item:getType() == "CandleLit";
end

function ISLitCandleExtinguish:update()
end

function ISLitCandleExtinguish:start()
    self.started = true;
end

function ISLitCandleExtinguish:stop()
    self.started = false;
    ISBaseTimedAction.stop(self);
end

function ISLitCandleExtinguish:perform()
    self.started = false;
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISLitCandleExtinguish:complete()
    local candle = instanceItem("Base.Candle")
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

function ISLitCandleExtinguish:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 1
end

function ISLitCandleExtinguish:new(character, item)
    local o = ISBaseTimedAction.new(self, character);
    o.item = item;
    o.stopOnWalk = false;
    o.stopOnRun = false;
    o.maxTime = o:getDuration();
    return o;
end
