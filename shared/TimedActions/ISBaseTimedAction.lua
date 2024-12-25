require "ISBaseObject"

ISBaseTimedAction = ISBaseObject:derive("ISBaseTimedAction");

ISBaseTimedAction.IDMax = 1;


function ISBaseTimedAction:isValidStart()
	return true;
end

function ISBaseTimedAction:isValid()

end

function ISBaseTimedAction:isUsingTimeout()
	return true;
end

function ISBaseTimedAction:update()

end

function ISBaseTimedAction:forceComplete()
    self.action:forceComplete();
end

function ISBaseTimedAction:forceStop()
    self.action:forceStop();
end

function ISBaseTimedAction:forceCancel()
	-- called when action is deleted action queue without being started
end

function ISBaseTimedAction:getJobDelta()
	return self.action:getJobDelta();
end

function ISBaseTimedAction:resetJobDelta()
	return self.action:resetJobDelta();
end

function ISBaseTimedAction:waitToStart()
	return false
end

function ISBaseTimedAction:start()

end

function ISBaseTimedAction:isStarted()
	return self.action and self.action:isStarted()
end

function ISBaseTimedAction:stop()
    ISTimedActionQueue.getTimedActionQueue(self.character):resetQueue();
    self.character:setIsFarming(false);
end

function ISBaseTimedAction:perform()
	ISTimedActionQueue.getTimedActionQueue(self.character):onCompleted(self);
	ISLogSystem.logAction(self);
    self.character:setIsFarming(false);
end

function ISBaseTimedAction:getDuration()
	return self.maxTime;
end

function ISBaseTimedAction:create()
	self.maxTime = self:adjustMaxTime(self.maxTime);
	self.action = LuaTimedActionNew.new(self, self.character);
end

function ISBaseTimedAction:begin()
	self:create();
	self.character:StartAction(self.action);
end

function ISBaseTimedAction:setCurrentTime(time)
	self.action:setCurrentTime(time);
end

function ISBaseTimedAction:setTime(time)
	self.maxTime = time;
end

function ISBaseTimedAction:adjustMaxTime(maxTime)
	if maxTime > 1 then
		-- add a slight maxtime if the character is unhappy
		maxTime = maxTime * (1 + (self.character:getMoodles():getMoodleLevel(MoodleType.Unhappy) / 50))

		-- add time if the character is drunk
		maxTime = maxTime * (1 + (self.character:getMoodles():getMoodleLevel(MoodleType.Drunk) / 50))

		-- add more time if the character have his hands wounded
		local maxPain = 0;
		if not self.ignoreHandsWounds then
			for i=BodyPartType.ToIndex(BodyPartType.Hand_L), BodyPartType.ToIndex(BodyPartType.ForeArm_R) do
				local part = self.character:getBodyDamage():getBodyPart(BodyPartType.FromIndex(i));
				maxPain = maxPain + part:getPain();
			end
		end

		maxTime = maxTime * (1 + (maxPain/300));


		-- Apply a multiplier based on body temperature.
		maxTime = maxTime * self.character:getTimedActionTimeModifier();
	end
	return maxTime;
end

function ISBaseTimedAction:setActionAnim(_action, _displayItemModels)
    if _displayItemModels~=nil then
        self.action:setActionAnim(_action, _displayItemModels);
    else
        self.action:setActionAnim(_action);
    end
end

function ISBaseTimedAction:setOverrideHandModels(_primaryHand, _secondaryHand, _resetModel)
	self.action:setOverrideHandModelsObject(_primaryHand, _secondaryHand, _resetModel or true)
end

function ISBaseTimedAction:setOverrideHandModelsString(_primaryHand, _secondaryHand, _resetModel)
	self.action:setOverrideHandModelsString(_primaryHand, _secondaryHand, _resetModel or true)
end

function ISBaseTimedAction:overrideWeaponType()
	self.action:overrideWeaponType()
end

function ISBaseTimedAction:restoreWeaponType()
	self.action:restoreWeaponType()
end

function ISBaseTimedAction:setAnimVariable(_key, _val)
    self.action:setAnimVariable(_key, _val);
end

function ISBaseTimedAction:addAfter(action)
	local queue,action1 = ISTimedActionQueue.addAfter(self, action)
	return action1
end

function ISBaseTimedAction:beginAddingActions()
	self._isAddingActions = true
	self._numAddedActions = 0
end

function ISBaseTimedAction:endAddingActions()
	local added = self._numAddedActions or 0
	self._isAddingActions = nil
	self._numAddedActions = nil
	return added > 0
end

function ISBaseTimedAction:getDeltaModifiers(deltas)
end

function ISBaseTimedAction:new (character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.stopOnAim = true;
    o.caloriesModifier = 1;
	o.maxTime = -1;
	return o
end
