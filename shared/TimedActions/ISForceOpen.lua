require "TimedActions/ISBaseTimedAction"

ISForceOpen = ISBaseTimedAction:derive("ISForceOpen");

ISForceOpen.FAIL_CHANCE = 10;
ISForceOpen.FAIL_CHANCE_BURGLAR = 5;

function ISForceOpen:isValid()
    return not self.object:isNotValidForForcing();
end

function ISForceOpen:waitToStart()
    self.character:faceThisObject(self.object)
    return self.character:shouldBeTurning() or not self.character:isCurrentState(IdleState.instance())
end

function ISForceOpen:update()
    if self.character:isCurrentState(ForceOpenState.instance()) then
        self.isForcing = true
    elseif self.isForcing then
        self:forceStop()
    end
end

function ISForceOpen:start()
    self.character:forceOpenWindowOrDoor(self.object)
end

function ISForceOpen:stop()
    ForceOpenState.instance():forceStopped(self.character)
    ISBaseTimedAction.stop(self);
end

function ISForceOpen:perform()
    ForceOpenState.instance():forceSucceeded(self.character)

    ISBaseTimedAction.perform(self);
end

function ISForceOpen:complete()
    return self.outcome == "success";
end

function ISForceOpen:getDuration()
    return -1;
end

function ISForceOpen:attempt()
    if not instanceof(self.object, "IForceablePortal") then
        return "fail"
    end
    local tool = self.character:getPrimaryHandItem()
    if not tool or not tool:hasTag(ItemTag.CROWBAR) or tool:isBroken() or self.object:isNotValidForForcing()
            or not IsoGridSquare.isWithinReachOfCharacter(self.character, self.object) then
        return "fail"
    end
    if not self.object:isLocked() then
        return "success"
    end

    self.character:exertForForcing()
    self.object:forceStruggleDamage(self.character)
    if self.object:isNotValidForForcing() then
        return "fail"
    end

    local failChance = self.character:hasTrait(CharacterTrait.BURGLAR) and ISForceOpen.FAIL_CHANCE_BURGLAR or ISForceOpen.FAIL_CHANCE
    if ZombRand(100) < failChance then
        self.object:failForceOpen(self.character)
        return "fail"
    end
    local minimumChance = math.max(1, self.character:getPerkLevel(Perks.Strength))
    if ZombRand(100) < math.max(minimumChance, self.character:getBaseForceOpenChance() + self.object:getBaseForceOpenChance(self.character)) then
        return "success"
    end
    return "struggle"
end

function ISForceOpen:animEvent(event, parameter)
    if isServer() and event == "ForceOpenStarted" then
        emulateAnimEvent(self.netAction, 1040, "ForceOpenAttempt", nil)
    end
    if not isClient() and event == "ForceOpenAttempt" then
        self.outcome = self:attempt()
        if self.outcome == "success" then
            if isServer() then
                self.object:forceOpen(self.character)
                self.object:sync()
                self.netAction:forceComplete()
            else
                ForceOpenState.instance():forceSucceeded(self.character)
                self:forceComplete()
            end
        elseif self.outcome == "fail" then
            if isServer() then
                self.netAction:forceComplete()
            else
                ForceOpenState.instance():forceStopped(self.character)
                self:forceStop()
            end
        end
    end
end

function ISForceOpen:serverStart()
    emulateAnimEventOnce(self.netAction, 400, "ForceOpenStarted", nil)
end

function ISForceOpen:new(character, object)
    local o = ISBaseTimedAction.new(self, character)
    o.object = object;
    o.maxTime = o:getDuration();
    o.useProgressBar = false;
    o.ignoreHandsWounds = true;
    o.retriggerLastAction = true;
    return o;
end
