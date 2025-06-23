--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPickupAnimal = ISBaseTimedAction:derive("ISPickupAnimal");

function ISPickupAnimal:isValid()
	return self.animal:isExistInTheWorld() and self.character:getSquare():DistTo(self.animal:getSquare()) < 3;
end

function ISPickupAnimal:waitToStart()
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISPickupAnimal:update()
	self.character:faceThisObject(self.animal)
end

function ISPickupAnimal:start()
	self.animal:getBehavior():setBlockMovement(true);
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	self.sound = self.animal:playBreedSound("pick_up")
end

function ISPickupAnimal:stop()
    self.character:stopOrTriggerSound(self.sound)
	self.animal:getBehavior():setBlockMovement(false);
    ISBaseTimedAction.stop(self);
end

function ISPickupAnimal:perform()
    self.character:stopOrTriggerSound(self.sound)

	self.animal:getBehavior():setBlockMovement(false);

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPickupAnimal:complete()
	local invItem = instanceItem("Base.Animal");
	invItem:setAnimal(self.animal);
	self.character:getInventory():AddItem(invItem);

	self.character:getAttachedAnimals():remove(self.animal);
	self.animal:getData():setAttachedPlayer(nil);
	self.animal:setWild(false);

	self.animal:removeFromWorld();
	self.animal:removeFromSquare();
	self.animal:setSquare(nil);

	forceDropHeavyItems(self.character)
	self.character:setPrimaryHandItem(nil);
	self.character:setSecondaryHandItem(nil);
	self.character:setPrimaryHandItem(invItem);
	self.character:setSecondaryHandItem(invItem);

	sendPickupAnimal(self.animal, self.character, invItem)

	return true
end

function ISPickupAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 30
end

function ISPickupAnimal:new(character, animal, remove)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.remove = remove;
	o.maxTime = o:getDuration();
	return o;
end
