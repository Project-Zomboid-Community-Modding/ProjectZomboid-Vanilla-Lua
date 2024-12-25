--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGiveWaterToAnimal = ISBaseTimedAction:derive("ISGiveWaterToAnimal");

function ISGiveWaterToAnimal:isValid()
	return self.character:getInventory():contains(self.item) and not self.item:getFluidContainer():isEmpty()
end

function ISGiveWaterToAnimal:waitToStart()
	if self.animal:isExistInTheWorld() then
		self.character:faceThisObject(self.animal)
	end
	if self.animal:getVehicle() then
		self.character:faceThisObject(self.animal:getVehicle())
	end
	return self.character:shouldBeTurning()
end

function ISGiveWaterToAnimal:update()
	if self.animal:isExistInTheWorld() then
		self.character:faceThisObject(self.animal)
	end
	if self.animal:getVehicle() then
		self.character:faceThisObject(self.animal:getVehicle())
	end
	self.timer = self.timer + getGameTime():getMultiplier();
	--	self.bucket:setJobDelta(self:getJobDelta());

	if not isClient() then
		--	print(math.floor(self.timer / 20))
		if math.floor(self.timer / self.timePerUse) > self.lastTimer then
			self.lastTimer = math.floor(self.timer / self.timePerUse);
			self.animal:getStats():setThirst(self.animal:getStats():getThirst() - (0.05 * self.animal:getThirstBoost()));
			self.item:getFluidContainer():removeFluid(0.05, false);

			addXp(self.character, Perks.Husbandry, 2);

			if self.animal:getStats():getThirst() <= 0 or self.item:getFluidContainer():isEmpty() then
				self.animal:getStats():setThirst(0);
				self:forceStop();
			end
		end
	end
end

function ISGiveWaterToAnimal:start()
	self.animal:getBehavior():setBlockMovement(true);

	self:setAnimVariable("FoodType", self.item:getEatType());
	self:setActionAnim("fill_container_tap");
	if not self.item:getEatType() then
		self:setOverrideHandModels(nil, self.item:getStaticModel())
	else
		self:setOverrideHandModels(self.item:getStaticModel(), nil)
	end
	self.sound = self.character:playSound("GiveWaterAnimal")
end

function ISGiveWaterToAnimal:forceStop()
	self.animal:getBehavior():setBlockMovement(false);
	self.action:forceStop();
end

function ISGiveWaterToAnimal:stop()
	self.animal:getBehavior():setBlockMovement(false);
	self:stopSound()
    ISBaseTimedAction.stop(self);
end

function ISGiveWaterToAnimal:perform()
	self.animal:getBehavior():setBlockMovement(false);
	self:stopSound()

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISGiveWaterToAnimal:complete()
	sendServerCommandV("animal", "setThirst",
			"id", self.animal:getOnlineID(),
			"value", self.animal:getThirst())
	return true
end

function ISGiveWaterToAnimal:animEvent(event, parameter)
	if isServer() then
		if event == "update" then
			self.animal:getStats():setThirst(self.animal:getStats():getThirst() - (0.05 * self.animal:getThirstBoost()));
			self.item:getFluidContainer():removeFluid(0.05, false);
			self.item:sendSyncEntity(nil)
            addXp(self.character, Perks.Husbandry, 2);

			if self.animal:getStats():getThirst() <= 0 or self.item:getFluidContainer():isEmpty() then
				self.animal:getStats():setThirst(0);
				self.netAction:forceComplete();
			end
		end
	end
end

function ISGiveWaterToAnimal:serverStart()
	local period = self.timePerUse * 20
	emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISGiveWaterToAnimal:getDuration()
	if isServer() then
		return -1
	end
	--if self.character:isTimedActionInstant() then
	--	return 1
	--end
	local maxWater = self.animal:getStats():getThirst() * 20;
-- 	local maxUse = item:getCurrentUsesFloat() / item:getUseDelta();
	local maxUse = self.item:getFluidContainer():getCapacity() / 0.05;
	local maxTime = (maxWater * self.timePerUse) + 5;
	if maxWater > maxUse then
		maxTime = (maxUse * self.timePerUse) + 5;
	end
	return maxTime
end

function ISGiveWaterToAnimal:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISGiveWaterToAnimal:new(character, animal, item)
	local o = ISBaseTimedAction.new(self, character);
	o.animal = animal;
	o.item = item;
	o.timePerUse = 20;
	o.maxTime = o:getDuration()
	o.timer = 0;
	o.lastTimer = 0;
	return o;
end
