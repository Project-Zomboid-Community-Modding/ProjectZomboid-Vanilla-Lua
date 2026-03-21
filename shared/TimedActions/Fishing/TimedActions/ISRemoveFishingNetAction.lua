require "TimedActions/ISBaseTimedAction"

ISRemoveFishingNetAction = ISBaseTimedAction:derive("ISRemoveFishingNetAction");

function ISRemoveFishingNetAction:isValid()
    return self.trap ~= nil and self.trap:getSquare() ~= nil
end

function ISRemoveFishingNetAction:waitToStart()
    self.character:faceThisObject(self.trap)
    return self.character:isTurning() or self.character:shouldBeTurning()
end

function ISRemoveFishingNetAction:update()
    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISRemoveFishingNetAction:start()
    self.character:getSquare():playSound("CheckFishingNet");
    addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 1)
    self.character:playSound("CheckFishingNet");
end

function ISRemoveFishingNetAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveFishingNetAction:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISRemoveFishingNetAction:complete()
    fishingNet.remove(self.trap, self.character);

    return true;
end

function ISRemoveFishingNetAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 150;
end

function ISRemoveFishingNetAction:new(character, trap)
    local o = ISBaseTimedAction.new(self, character);
    o.trap = trap;
    o.maxTime = o:getDuration()
    return o;
end
