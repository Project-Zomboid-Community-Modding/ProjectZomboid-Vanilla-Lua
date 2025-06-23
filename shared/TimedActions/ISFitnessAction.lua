--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFitnessAction = ISBaseTimedAction:derive("ISFitnessAction");

function ISFitnessAction:isValidStart()
	return self.character:getMoodles():getMoodleLevel(MoodleType.Endurance) <= ISFitnessUI.enduranceLevelTreshold
end

function ISFitnessAction:isValid()
	return self.character:getVehicle() == nil;
end

function ISFitnessAction:waitToStart()
	if self.character:isAiming() then
		self.character:nullifyAiming()
	end
	if self.character:isSneaking() then
		self.character:setSneaking(false)
	end
	if not self.character:isCurrentState(IdleState.instance()) then
		-- Only the player.idle state has a transition to the player.fitness state.
		return true
	end
	return false
end

function ISFitnessAction:update()
	if self.character:isClimbing() or self.character:isAiming() then
		self:forceStop();
	end
	if self.character:isSneaking() then
		self.character:setSneaking(false)
	end
	if self.character:pressedMovement(true) or self.character:getMoodles():getMoodleLevel(MoodleType.Endurance) > ISFitnessUI.enduranceLevelTreshold then
		self.character:setVariable("ExerciseStarted", false);
		self.character:setVariable("ExerciseEnded", true);
	end
	
	if getGameTime():getCalender():getTimeInMillis() > self.endMS then
		self.character:setVariable("ExerciseStarted", false);
		self.character:setVariable("ExerciseEnded", true);
		self:forceStop();
	end
	
	self.character:setMetabolicTarget(self.exeData.metabolics);
end


function ISFitnessAction:start()
	self.action:setUseProgressBar(false)
	if self.character:getCurrentState() ~= FitnessState.instance() then
		self.character:setVariable("ExerciseType", self.exercise);
		self.character:reportEvent("EventFitness");
		self.character:clearVariable("ExerciseStarted");
		self.character:clearVariable("ExerciseEnded");
		
		self.character:reportEvent("EventUpdateFitness");
	end

--	self:showHandModel();
end

function ISFitnessAction:showHandModel()
	if self.exeData.item then
		if self.character:getPrimaryHandItem() and self.character:getPrimaryHandItem():getType() == self.exeData.item then
			self:setOverrideHandModels(self.character:getPrimaryHandItem():getStaticModel(), nil);
		elseif self.character:getSecondaryHandItem() and self.character:getSecondaryHandItem():getType() == self.exeData.item then
			self:setOverrideHandModels(nil, self.character:getSecondaryHandItem():getStaticModel());
		end
	else
		self:setOverrideHandModels(nil, nil);
	end
end

function ISFitnessAction:stop()
	self.character:PlayAnim("Idle");

	if not isClient() and not isServer() then
		self.character:SetVariable("FitnessFinished","true");
	end

	self.character:setVariable("ExerciseEnded", true);
	setGameSpeed(1);
	ISBaseTimedAction.stop(self);
end

function ISFitnessAction:complete()
	if not isClient() and not isServer() then
		self.character:SetVariable("FitnessFinished","true");
	end
	emulateAnimEventOnce(self.netAction, 100, nil, "FitnessFinished=TRUE")
	return true;
end

function ISFitnessAction:perform()
	self.character:PlayAnim("Idle");
	
--	if self.fitnessUI then
--		self.fitnessUI:updateExercises();
--	end
	
	self.character:setVariable("ExerciseEnded", true);
--	print("REP NBR!:", self.repnb)
	setGameSpeed(1);
	ISBaseTimedAction.perform(self);
end

-- handle endurance loss, regularity, stats boosts, etc.
function ISFitnessAction:exeLooped()
	self.repnb = self.repnb + 1;
	self.fitness:exerciseRepeat();
	self:setFitnessSpeed();
end

function ISFitnessAction:serverStart()
	self.fitness = self.character:getFitness();
	self.fitness:init();
	self.fitness:setCurrentExercise(self.exeDataType);

	local period = 0;
	if self.exeDataType == "squats" then
		period = 3000;
	elseif self.exeDataType == "pushups" then
		period = 1300;
	elseif self.exeDataType == "burpees" then
		period = 2400;
	elseif self.exeDataType == "barbellcull" then
		period = 2200;
	elseif self.exeDataType == "dumbbellpress" then
		period = 1500;
	elseif self.exeDataType == "bicepscurl" then
		period = 1900;
	end

	emulateAnimEvent(self.netAction, period, "ActiveAnimLooped", nil)
	end

function ISFitnessAction:serverStop()
	emulateAnimEventOnce(self.netAction, 100, nil, "FitnessFinished=TRUE")
end

function ISFitnessAction:animEvent(event, parameter)
	local isSinglePlayerMode = (not isClient() and not isServer());

	if isServer() or isSinglePlayerMode then
		if parameter == "FitnessFinished=TRUE" then
			self:forceStop();
		end

		if event == "ActiveAnimLooped" then
			self:exeLooped();
		end
	else
		if event == "ActiveAnimLooped" then
			if self.exeData.prop == "switch" then -- switch hand used every X times
				self.switchTime = self.switchTime -1;
				if self.switchTime == 1 then
					self.switchTime = 5;
					if self.switchHandUsed == "right" then
						self.switchHandUsed = "left";
						self.character:setVariable("ExerciseHand", "left");
						self.character:setSecondaryHandItem(self.character:getPrimaryHandItem());
						self.character:setPrimaryHandItem(nil);
					else
						self.switchHandUsed = "right";
						self.character:clearVariable("ExerciseHand");
						self.character:setPrimaryHandItem(self.character:getSecondaryHandItem());
						self.character:setSecondaryHandItem(nil);
					end
				end
			end
			self.character:reportEvent("EventUpdateFitness");
	end

--		print("loopityloop", self.exeData.prop)
	end
end

function ISFitnessAction:setFitnessSpeed()
	self.character:setFitnessSpeed()
end

function ISFitnessAction:getDuration()
	return 5000000;
end

function ISFitnessAction:new(character, exercise, timeToExe, exeData, exeDataType)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.exercise = exercise;
	o.timeToExe = timeToExe;
	o.exeData = exeData;
	o.exeDataType = exeDataType;
	o.switchTime = 5;
	o.switchHandUsed = "right";
	-- calcul time we need in ingame minutes
	o.startMS = getGameTime():getCalender():getTimeInMillis();
	o.endMS = o.startMS + (timeToExe * 60000)
	o.maxTime = o:getDuration();
	o.fitness = character:getFitness();
	o.repnb = 0;

	o:setFitnessSpeed();
	o.fitness:setCurrentExercise(exeDataType);
	
	o.caloriesModifier = 3;
	
	return o;
end
