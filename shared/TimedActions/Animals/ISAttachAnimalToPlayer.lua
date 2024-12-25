--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAttachAnimalToPlayer = ISBaseTimedAction:derive("ISAttachAnimalToPlayer");

function ISAttachAnimalToPlayer:isValid()
	return self.character:getSquare():DistTo(self.animal:getSquare()) < 3;
end

function ISAttachAnimalToPlayer:waitToStart()
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISAttachAnimalToPlayer:update()
	self.character:faceThisObject(self.animal)
end

function ISAttachAnimalToPlayer:start()
	self:setActionAnim("Loot")
	self.character:reportEvent("EventLootItem")
	if self.remove then
		self.sound = self.character:playSound("DetachRopeAnimal")
	else
		self.sound = self.character:playSound("AttachRopeAnimal")
	end
end

function ISAttachAnimalToPlayer:stop()
    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISAttachAnimalToPlayer:perform()
	self.character:stopOrTriggerSound(self.sound)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISAttachAnimalToPlayer:complete()
	if not self.remove then
		self.character:getAttachedAnimals():add(self.animal);
		self.animal:getData():setAttachedTree(nil);
		self.animal:getData():setAttachedPlayer(self.character);
	else
		self.character:getAttachedAnimals():remove(self.animal);
		self.animal:getData():setAttachedPlayer(nil);
	end
	sendAttachAnimalToPlayer(self.animal, self.character, nil, self.remove)
	return true
end

function ISAttachAnimalToPlayer:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 30
end

function ISAttachAnimalToPlayer:new(character, animal, remove)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.remove = remove;
	o.maxTime = o:getDuration();
	return o;
end
