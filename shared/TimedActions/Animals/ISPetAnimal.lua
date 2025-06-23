--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPetAnimal = ISBaseTimedAction:derive("ISPetAnimal");

function ISPetAnimal:isValid()
	return self.character:getSquare():DistTo(self.animal:getSquare()) < 3;
end

function ISPetAnimal:waitToStart()
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISPetAnimal:update()
	self.character:setIsAiming(false);
	self.character:faceThisObject(self.animal)
	self.animal:faceThisObject(self.character);
end

function ISPetAnimal:start()
	forceDropHeavyItems(self.character)
	self:setOverrideHandModels(nil, nil)
	self.character:setVariable("AnimalSizeX", 0.01);
	local range = self.animal:getData():getMaxSize() - self.animal:getData():getMinSize()
	local current = self.animal:getData():getSize() - self.animal:getData():getMinSize()
	if current <= 0.001 then
		current = 0.001;
	end
	self.character:setVariable("AnimalSizeY", current/range);

--	print("range", range, "current", current, "total", current/range)

	self.animal:getBehavior():setBlockMovement(true);
	self.character:setVariable("petanimal", true)
	--print("set animal pet! ", self.animal:getAnimalType())
	self.character:setVariable("animal", self.animal:getAnimalType())
	if self.animal:hasGeneticDisorder("dwarf") and not self.animal:isBaby() then
		self.character:setVariable("animal", self.animal:getBabyType())
	end
	self.animal:setVariable("idleAction", "petting")
end

function ISPetAnimal:forceStop()
	self.character:setVariable("petanimal", false)
	self.animal:clearVariable("idleAction");
	self.animal:getBehavior():setBlockMovement(false);
	self.action:forceStop();
end

function ISPetAnimal:stop()
	self.character:setVariable("petanimal", false)
	self.animal:clearVariable("idleAction");
	self.animal:getBehavior():setBlockMovement(false);
    ISBaseTimedAction.stop(self);
end

function ISPetAnimal:perform()
	self.character:setVariable("petanimal", false)
	self.animal:clearVariable("idleAction");
	self.animal:getBehavior():setBlockMovement(false);

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPetAnimal:complete()
	self.animal:petAnimal(self.character);
	return true
end

function ISPetAnimal:getDuration()
	--if self.character:isTimedActionInstant() then
	--	return 1
	--end
	return 400
end

function ISPetAnimal:serverStart()
	emulateAnimEventOnce(self.netAction, 3000, "pettingFinished", nil)
end

function ISPetAnimal:animEvent(event, parameter)
	if event == "pettingFinished" then
		self.animal:petAnimal(self.character);
		if not isServer() then
			self:forceStop()
		end
	end
end

function ISPetAnimal:new(character, animal)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.maxTime = o:getDuration()
	o.useProgressBar = false;
	o.stopOnAim = false;
	return o;
end
