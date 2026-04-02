require "TimedActions/ISBaseTimedAction"

ISThrowCorpseThroughWindow = ISBaseTimedAction:derive("ISThrowCorpseThroughWindow")

function ISThrowCorpseThroughWindow:isValid()
    if not self.window:canClimbThrough(self.character) then
        return false
    end
    return self.character:isDraggingCorpse()
end

function ISThrowCorpseThroughWindow:waitToStart()
    local direction = IsoDirections.S
    if self.window:getNorth() then
        direction = self.character:getSquare() == self.window:getSquare() and IsoDirections.S or IsoDirections.N
    else
        direction = self.character:getSquare() == self.window:getSquare() and IsoDirections.E or IsoDirections.W
    end
    self.character:faceDirection(direction)
    return self.character:shouldBeTurning()
end

function ISThrowCorpseThroughWindow:update()
end

function ISThrowCorpseThroughWindow:start()
end

function ISThrowCorpseThroughWindow:stop()
    ISBaseTimedAction.stop(self)
end

function ISThrowCorpseThroughWindow:perform()
    self.character:throwGrappledTargetOutWindow(self.window)

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISThrowCorpseThroughWindow:complete()
    return true
end

function ISThrowCorpseThroughWindow:getDuration()
    return 1
end

function ISThrowCorpseThroughWindow:new(character, window)
    local o = ISBaseTimedAction.new(self, character)
    o.stopOnWalk = true
    o.stopOnRun = true
    o.window = window
    o.maxTime = o:getDuration()
    o.allowedWhileDraggingCorpses = true
    return o
end
