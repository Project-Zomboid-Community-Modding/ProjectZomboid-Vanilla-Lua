--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFeedAnimalFromHand = ISBaseTimedAction:derive("ISFeedAnimalFromHand");

function ISFeedAnimalFromHand:isValid()
	return self.character:getInventory():contains(self.food);
	--return true;
end

function ISFeedAnimalFromHand:update()
end

function ISFeedAnimalFromHand:start()
	self.animal:getBehavior():setBlockMovement(true);
	if self.food:getFluidContainer() then
		self.sound = self.character:playSound("GiveWaterAnimal")
	else
		self.sound = self.character:playSound("GiveFoodAnimal")
	end
end

function ISFeedAnimalFromHand:forceStop()
	self.animal:getBehavior():setBlockMovement(false);
	ISBaseTimedAction.forceStop(self);
end

function ISFeedAnimalFromHand:stop()
	self.animal:getBehavior():setBlockMovement(false);
	self:stopSound()
    ISBaseTimedAction.stop(self);
end

function ISFeedAnimalFromHand:perform()
	self.animal:getBehavior():setBlockMovement(false);
	self:stopSound()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISFeedAnimalFromHand:complete()
	self.animal:getBehavior():setBlockMovement(false);
	self.animal:feedFromHand(self.character, self.food)
	--self.character:getInventory():Remove(self.food)
	sendFeedAnimalFromHand(self.animal, self.character, self.food)
	return true
end

function ISFeedAnimalFromHand:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 150
end

function ISFeedAnimalFromHand:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISFeedAnimalFromHand:new(character, animal, food)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.food = food;
	o.maxTime = o:getDuration()
	o.stopOnWalk = true;
	o.stopOnRun = true;
	return o;
end
