require "TimedActions/ISBaseTimedAction"

ISPlaceFishingNetAction = ISBaseTimedAction:derive("ISPlaceFishingNetAction");

function ISPlaceFishingNetAction:isValid()
    return self.item ~= nil and self.character:getInventory():contains(self.item)
end

function ISPlaceFishingNetAction:waitToStart()
    self.character:facePosition(self.square:getX(), self.square:getY())
    return self.character:isTurning() or self.character:shouldBeTurning()
end

function ISPlaceFishingNetAction:start()
end


function ISPlaceFishingNetAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISPlaceFishingNetAction:perform()
    ISBaseTimedAction.perform(self);
end

function ISPlaceFishingNetAction:complete()
    local net = IsoObject.new(self.square, self.sprite, "FishingNet");
    self.square:AddTileObject(net)
    net:transmitCompleteItemToClients();
    fishingNet.doTimestamp(net);

    self.character:getInventory():Remove(self.item)
    sendRemoveItemFromContainer(self.character:getInventory(), self.item);

    self.character:playSound("PlaceFishingNet");

    return true;
end

function ISPlaceFishingNetAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 150;
end

function ISPlaceFishingNetAction:new(character, item, square, sprite)
    local o = ISBaseTimedAction.new(self, character);
    o.item = item;
    o.character = character;
    o.square = square;
    o.sprite = sprite;
    o.maxTime = o:getDuration();
    return o;
end
