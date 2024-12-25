--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPutAnimalInHutch = ISBaseTimedAction:derive("ISPutAnimalInHutch");

function ISPutAnimalInHutch:isValid()
	return self.character:getPrimaryHandItem() and instanceof(self.character:getPrimaryHandItem(), "AnimalInventoryItem");
end

function ISPutAnimalInHutch:waitToStart()
	self.character:faceThisObject(self.hutch)
	return self.character:shouldBeTurning()
end

function ISPutAnimalInHutch:update()
	self.character:faceThisObject(self.hutch)
end

function ISPutAnimalInHutch:start()
end

function ISPutAnimalInHutch:stop()
    ISBaseTimedAction.stop(self);

end

function ISPutAnimalInHutch:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);

end

function ISPutAnimalInHutch:complete()
	local animal = self.character:getPrimaryHandItem();
	animal:getAnimal():getBehavior():setHourBeforeLeavingHutch(1);
	self.hutch:addAnimalInside(animal:getAnimal());
	self.character:getInventory():Remove(animal);
	self.character:setPrimaryHandItem(nil);
	self.character:setSecondaryHandItem(nil);
	return true
end

function ISPutAnimalInHutch:getDuration()
	if self.character:isTimedActionInstant() then
		return 40
	end
	return 40
end

function ISPutAnimalInHutch:new(character, hutch)
	local o = ISBaseTimedAction.new(self, character)
	o.hutch = hutch;
	o.maxTime = o:getDuration()
	return o;
end
