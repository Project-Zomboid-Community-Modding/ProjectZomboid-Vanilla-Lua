require "TimedActions/ISBaseTimedAction"

ISClimbThroughWindow = ISBaseTimedAction:derive("ISClimbThroughWindow");

function ISClimbThroughWindow:isValid()
    if instanceof(self.item, 'IsoWindow') and not self.item:canClimbThrough(self.character) then
        return false
    end
    if instanceof(self.item, 'IsoThumpable') and not self.item:canClimbThrough(self.character) then
        return false
    end
    if instanceof(self.item, 'IsoWindowFrame') and not self.item:canClimbThrough(self.character) then
        return false
    end
    return true;
end

function ISClimbThroughWindow:waitToStart()
    local dir = self:getFacingDirection()
    self.character:faceDirection(dir)
    return self.character:shouldBeTurning()
end

function ISClimbThroughWindow:update()
    self.character:setMetabolicTarget(Metabolics.JumpFence);
end

function ISClimbThroughWindow:start()
end

function ISClimbThroughWindow:stop()
    ISBaseTimedAction.stop(self);
end

function ISClimbThroughWindow:perform()
    --self.item:ToggleWindow(self.character);
    if instanceof(self.item, "IsoWindowFrame") then
        self.character:climbThroughWindowFrame(self.item)
    else
        self.character:climbThroughWindow(self.item);
    end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISClimbThroughWindow:getNorth(object)
    return object:getNorth()
end

function ISClimbThroughWindow:getFacingDirection()
    local square = self.item:getSquare()
    if self:getNorth(self.item) then
        if self.character:getY() < square:getY() then
            return IsoDirections.S
        end
        return IsoDirections.N
    end
    if self.character:getX() < square:getX() then
        return IsoDirections.E
    end
    return IsoDirections.W
end

function ISClimbThroughWindow:getDeltaModifiers(deltas)
    if not self:isStarted() then
        deltas:setMaxTurnDelta(2)
    end
end

function ISClimbThroughWindow:new(character, item, time)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item;
    o.maxTime = time;
    o.retriggerLastAction = true; -- this is used when we for example eat something and climb through, the eat action is removed, but we store it in IsoPlayer.getTimedActionToRetrigger(), here we say to the queue "relaunch the previous action (eat)", it'll be relaunched at the delta it was saved
    return o;
end
