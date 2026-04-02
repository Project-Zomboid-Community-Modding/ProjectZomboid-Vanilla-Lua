require "TimedActions/ISBaseTimedAction"

ISThrowCorpseOverFence = ISBaseTimedAction:derive("ISThrowCorpseOverFence")

function ISThrowCorpseOverFence:isValid()
    if not self.character:canThrowCorpseOver(self.dir) then
        return false
    end
    return self.character:isDraggingCorpse()
end

function ISThrowCorpseOverFence:waitToStart()
    self.character:faceDirection(self.dir:Rot180())
    return self.character:shouldBeTurning()
end

function ISThrowCorpseOverFence:update()
end

function ISThrowCorpseOverFence:start()
end

function ISThrowCorpseOverFence:stop()
    ISBaseTimedAction.stop(self)
end

function ISThrowCorpseOverFence:perform()
    self.character:throwGrappledOverFence(self.fence, self.dir)

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISThrowCorpseOverFence:complete()
    return true
end

function ISThrowCorpseOverFence:getDuration()
    return 1
end

function ISThrowCorpseOverFence:new(character, fence, dir)
    local o = ISBaseTimedAction.new(self, character)
    o.stopOnWalk = true
    o.stopOnRun = true
    o.fence = fence
    o.dir = dir
    o.maxTime = o:getDuration()
    o.allowedWhileDraggingCorpses = true
    return o
end
