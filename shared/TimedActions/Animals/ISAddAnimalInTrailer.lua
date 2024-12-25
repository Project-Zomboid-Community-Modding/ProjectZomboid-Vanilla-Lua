--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddAnimalInTrailer = ISBaseTimedAction:derive("ISAddAnimalInTrailer");

function ISAddAnimalInTrailer:isValid()
	return true
end

function ISAddAnimalInTrailer:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISAddAnimalInTrailer:update()
	self.character:faceThisObject(self.vehicle)
end

function ISAddAnimalInTrailer:start()
	if self.animal and instanceof(self.animal, "IsoAnimal") and self.animal:isExistInTheWorld() then
		self.animal:getBehavior():setBlockMovement(true);
	end
end

function ISAddAnimalInTrailer:stop()
    ISBaseTimedAction.stop(self);

	if self.animal and instanceof(self.animal, "IsoAnimal") and self.animal:isExistInTheWorld() then
		self.animal:getBehavior():setBlockMovement(false);
	end
end

function ISAddAnimalInTrailer:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);

	--if self.fromHand then
	--	self.character:setPrimaryHandItem(nil);
	--	self.character:setSecondaryHandItem(nil);
	--end

	if self.animal and instanceof(self.animal, "IsoAnimal") and self.animal:isExistInTheWorld() then
		self.animal:getBehavior():setBlockMovement(false);
	end

	if ISVehicleAnimalUI.ui then
		ISVehicleAnimalUI.ui:reset(ISVehicleAnimalUI.ui.scrollPanel);
	end
end

function ISAddAnimalInTrailer:complete()
	if self.fromHand then
		self.vehicle:addAnimalFromHandsInTrailer(self.animal, self.character)
		sendAddAnimalFromHandsInTrailer(self.animal, self.character, self.vehicle)
	else
		local distCheck = 3;
		if instanceof(self.animal, "IsoAnimal") then
			-- more range if the animal is attached to the player, i'm nice like that.
			if self.animal:getData():getAttachedPlayer() == self.character then
				distCheck = 5;
			end
		end
		if self.vehicle:getAreaDist("AnimalEntry", self.animal:getSquare():getX(), self.animal:getSquare():getY(), self.animal:getSquare():getZ()) <= distCheck then
			self.vehicle:addAnimalInTrailer(self.animal)
			sendAddAnimalInTrailer(self.animal, self.character, self.vehicle)
		end
	end

	return true
end

function ISAddAnimalInTrailer:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 80
end

function ISAddAnimalInTrailer:new(character, vehicle, animal, fromHand)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = vehicle;
	o.animal = animal;
	o.maxTime = o:getDuration()
	o.fromHand = fromHand;
	return o;
end
