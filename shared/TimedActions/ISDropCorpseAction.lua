require "TimedActions/ISBaseTimedAction"

ISDropCorpseAction = ISBaseTimedAction:derive("ISDropCorpseAction");

function ISDropCorpseAction:isValid()
    return self.character:isDraggingCorpse();
end

function ISDropCorpseAction:waitToStart()
    return false
end

function ISDropCorpseAction:update()
    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISDropCorpseAction:start()
    self.action:setAllowedWhileDraggingCorpses(true)
    -- Let go of dragged corpse
    self.character:setDoGrappleLetGo();
end

function ISDropCorpseAction:stop()
    self:stopSound();

    ISBaseTimedAction.stop(self);
end

function ISDropCorpseAction:perform()
    self:stopSound();

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISDropCorpseAction:complete()
    return true;
end

function ISDropCorpseAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    --return 50
    return 5
end

function ISDropCorpseAction:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound);
    end
end

function ISDropCorpseAction:new (character, targetSquare)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration();
    o.forceProgressBar = true;
    return o
end
