--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveAnimalFromTrailer = ISBaseTimedAction:derive("ISRemoveAnimalFromTrailer");

function ISRemoveAnimalFromTrailer:isValid()
	return true
end

function ISRemoveAnimalFromTrailer:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISRemoveAnimalFromTrailer:update()
	self.character:faceThisObject(self.vehicle)
end

function ISRemoveAnimalFromTrailer:start()

end

function ISRemoveAnimalFromTrailer:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveAnimalFromTrailer:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);

	if self.grab then
		if not animal then return; end
	end
end

function ISRemoveAnimalFromTrailer:complete()
	local animal = self.vehicle:removeAnimalFromTrailer(self.animal)
	if self.grab then
		if not animal then return; end

		local invItem;
		if instanceof(animal, "IsoAnimal") then
			invItem = instanceItem("Base.Animal")
			invItem:setAnimal(animal);
			self.character:getInventory():AddItem(invItem)

			animal:removeFromWorld();
			animal:removeFromSquare();
			animal:setSquare(nil);
		end

		if instanceof(animal, "IsoDeadBody") then
			invItem = animal:getItem();
			self.character:getInventory():AddItem(invItem)

			animal:getSquare():removeCorpse(animal, false);
			animal:invalidateCorpse();
		end


		if invItem then
			forceDropHeavyItems(self.character)
			self.character:setPrimaryHandItem(nil);
			self.character:setSecondaryHandItem(nil);
			self.character:setPrimaryHandItem(invItem);
			self.character:setSecondaryHandItem(invItem);
		end

		--print("animal?", animal)
		--sendRemoveAndGrabAnimalFromTrailer(animal, self.character, self.vehicle, invItem)
	else
		if instanceof(animal, "IsoAnimal") then
			animal:addToWorld();
		end
		sendRemoveAnimalFromTrailer(self.animal, self.character, self.vehicle)
	end

	return true
end

function ISRemoveAnimalFromTrailer:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	if self.grab then
		return 80
	end
	return 80
end

function ISRemoveAnimalFromTrailer:new(character, vehicle, animal, grab)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = vehicle;
	o.animal = animal;
	o.grab = grab;
	o.maxTime = o:getDuration()
	return o;
end
