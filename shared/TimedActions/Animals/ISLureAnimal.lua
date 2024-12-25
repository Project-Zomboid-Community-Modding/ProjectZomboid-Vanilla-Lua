--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISLureAnimal = ISBaseTimedAction:derive("ISLureAnimal");

function ISLureAnimal:isValid()
	return self.character:getPrimaryHandItem() == self.item;
end

function ISLureAnimal:waitToStart()
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISLureAnimal:update()
--	self.character:faceThisObject(self.animal)

	if self.timerCheck > 0 then
		self.timerCheck = self.timerCheck - getGameTime():getThirtyFPSMultiplier();
		return;
	end

	self.character:lureAnimal(self.item)

	local closestAnimal = nil;
	local closestDist = 0;
	for i=0, self.character:getLuredAnimals():size()-1 do
		local animal = self.character:getLuredAnimals():get(i);
		if animal ~= closestAnimal and (closestAnimal == nil or animal:DistTo(self.character) < closestDist) then
			closestDist = animal:DistTo(self.character);
			closestAnimal = animal;
		end
	end

	if closestAnimal then
		local currentDist = closestAnimal:DistTo(self.character);
		self.character:faceThisObject(closestAnimal)
		self.timerCheck = 20
		if currentDist <= 12 then
			if not self.saidLine then
				local txt = "";
				if closestAnimal:getCustomName() then
					txt = closestAnimal:getCustomName();
				end
				if(ZombRand(3)==0) then
					self.character:Say(getText("IGUI_LureAnimal", txt));
					self.character:playerVoiceSound("LureCmon")
				else
					self.character:Say(getText("IGUI_LureAnimal1", txt));
					self.character:playerVoiceSound("LureTsk")
				end
				self.saidLine = true;
			end
			self:setActionAnim("AnimalLure");
			if currentDist <= 4 then
				if not self.saidLine2 then
					self.saidLine2 = true;
					self.character:Say(getText("IGUI_LureAnimal2"));
					self.character:playerVoiceSound("LureCmon")
				end
				self:setActionAnim("AnimalLureLow");
			end
		end
		if not isClient() then
			if currentDist <= 2 then
				self:luredAnimal(closestAnimal);
				self:forceStop();
				return;
			end
		end
	else
		self.timerCheck = ZombRand(2*30, 4*30)
		if(ZombRand(3)==0) then
			self.character:Say(getText("IGUI_LureAnimal2"));
			self.character:playerVoiceSound("LureCmon")
		else
			self.character:Say(getText("IGUI_LureAnimal1"));
			self.character:playerVoiceSound("LureTsk")
		end
	end

	if not isClient() then
		self.timer = self.timer + getGameTime():getMultiplier();
		if math.floor(self.timer / self.luringTick) > self.lastTimer then
			self.lastTimer = math.floor(self.timer / self.luringTick);
			self.character:lureAnimal(self.item)
		end
	end
end

function ISLureAnimal:luredAnimal(animal)
--	animal:successLure(self.character);
	self.character:stopLuringAnimals(true);
	self:stop();
end

function ISLureAnimal:start()
--	self.sound = self.character:getEmitter():playSound("LureAnimal");
	self.character:setIsLuringAnimals(true);
	self.character:getLuredAnimals():clear();
	self.character:lureAnimal(self.item)
	self:setActionAnim("AnimalLureHigh");
	self:setOverrideHandModels(self.item:getStaticModel());
	self.character:Say(getText("IGUI_LureAnimal1"));
	self.character:playerVoiceSound("LureTsk")
end

function ISLureAnimal:stopSound()
	self.character:stopPlayerVoiceSound("LureCmon")
	self.character:stopPlayerVoiceSound("LureTsk")
	if self.sound and self.sound ~= 0 and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopSound(self.sound);
	end
end

function ISLureAnimal:stop()
--	print("dbga: stop")
	self:stopSound();
	self.character:stopLuringAnimals(false);
    ISBaseTimedAction.stop(self);
end

function ISLureAnimal:perform()
--	print("dbga: perform")
	self:stopSound();
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISLureAnimal:serverStop()
	self:stopSound();
	self.character:stopLuringAnimals(false)
end

function ISLureAnimal:complete()
	self:stopSound();
	self.character:stopLuringAnimals(true)
	return true
end

function ISLureAnimal:animEvent(event, parameter)
	if isServer() then
		if event == "update" then

			local closestAnimal = nil;
			local closestDist = 0;

			for i=0, self.character:getLuredAnimals():size()-1 do
				local animal = self.character:getLuredAnimals():get(i);
				if animal ~= closestAnimal and (closestAnimal == nil or animal:DistTo(self.character) < closestDist) then
					closestDist = animal:DistTo(self.character);
					closestAnimal = animal;
				end
			end

			if closestAnimal then
				local currentDist = closestAnimal:DistTo(self.character);
				if currentDist <= 2 then
					self.character:stopLuringAnimals(true);
					self.netAction:forceComplete()
					return
				end
			end

			self.character:lureAnimal(self.item)
		end
	end
end

function ISLureAnimal:serverStart()
	local period = self.luringTick * 20
	emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISLureAnimal:getDuration()
	return -1
end

function ISLureAnimal:new(character, animal, item)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.maxTime = o:getDuration();
	o.item = item;
	o.useProgressBar = false;
	o.luringTick = 100;
	o.timer = 0;
	o.lastTimer = 0;
	o.timerCheck = 200;
	return o;
end
