--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISShearAnimal = ISBaseTimedAction:derive("ISShearAnimal");

function ISShearAnimal:isValid()
	return self.character:getSquare():DistTo(self.animal:getSquare()) < 3 and self.character:getInventory():contains(self.shear);
end

function ISShearAnimal:waitToStart()
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISShearAnimal:stress()
	-- stress can make the animal break from the shearing
	if self.animal:getStress() > 40 and self.character:getPerkLevel(Perks.Husbandry) <= 7 then
		local chance = self.animal:getStress();
		chance = chance - (self.character:getPerkLevel(Perks.Husbandry) * 5); -- skill make it happen less often

		-- acceptance lower this possibility
		chance = chance - (self.animal:getAcceptanceLevel(self.character) * 5);

		if ZombRand(100) < chance then
			if isServer() then
				self.netAction:forceComplete()
			else
				self:forceStop();
			end
			self.animal:changeStress((ZombRand(3, 8) / 5)); -- extra stress the animal!
			local sq;
			-- make the animal flee somewhere
			if self.animal:getDZone() then
				sq = self.animal:getRandomSquareInZone();
			end
			if not sq then
				sq = getSquare(ZombRand(self.animal:getSquare():getX() - 5, self.animal:getSquare():getX() + 5), ZombRand(self.animal:getSquare():getY() - 5, self.animal:getSquare():getY() + 5), self.animal:getSquare():getZ());
			end
			self.animal:fleeTo(sq);
		end
	end
end

function ISShearAnimal:update()
	self.character:setIsAiming(false);
	self.character:faceThisObject(self.animal)
	self.shear:setJobDelta(self:getJobDelta());

	if not isClient() then
		--	print(math.floor(self.timer / 20))
		self.timer = self.timer + getGameTime():getMultiplier();
		if math.floor(self.timer / self.timePerLiter) > self.lastTimer then
			self.lastTimer = math.floor(self.timer / self.timePerLiter);
			self:stress();
			if not self.animal:shearAnimal(self.character, self.shear) then
				self:forceStop();
				return;
			end
		end
	end
end

function ISShearAnimal:start()
	self.character:setVariable("shearanimal", true)
	self.animal:getBehavior():setBlockMovement(true);
	self:setOverrideHandModels("SheepShears_Electric");
	self.shear:setJobType(getText("ContextMenu_Shear"));
	self.shear:setJobDelta(0.0);

	self.character:setVariable("AnimalSizeX", 0.01); -- not used, but i need it to make a triangle
	local range = self.animal:getData():getMaxSize() - self.animal:getData():getMinSize()
	local current = self.animal:getData():getSize() - self.animal:getData():getMinSize()
	if current <= 0.001 then
		current = 0.001;
	end
	self.character:setVariable("AnimalSizeY", current/range);
	sendEvent(self.character, "ShearAnimal")
end

function ISShearAnimal:forceStop()
	self.character:setVariable("shearanimal", false)
	self.animal:getBehavior():setBlockMovement(false);
	self.shear:setJobDelta(0.0);
	ISBaseTimedAction.stop(self);
end

function ISShearAnimal:stop()
	self.character:setVariable("shearanimal", false)
	self.animal:getBehavior():setBlockMovement(false);
	self.shear:setJobDelta(0.0);
    ISBaseTimedAction.stop(self);
end

function ISShearAnimal:perform()
	self.character:setVariable("shearanimal", false)
	self.animal:getBehavior():setBlockMovement(false);
	self.shear:setJobDelta(0.0);

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISShearAnimal:complete()
	return true
end

function ISShearAnimal:animEvent(event, parameter)
	if isServer() then
		if event == "update" then

			local result = self.animal:shearAnimal(self.character, self.shear)

			if not result then
				self.netAction:forceComplete()
			else
				self:stress()
			end
		end
	end
end

function ISShearAnimal:serverStart()
	local period = self.timePerLiter * 20
	emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISShearAnimal:getDuration()
	--if self.character:isTimedActionInstant() then
	--	return 1
	--end
	return (self.animal:getData():getWoolQuantity() * self.timePerLiter) + 1
end

function ISShearAnimal:new(character, animal, shear)
	local o = ISBaseTimedAction.new(self, character);
	o.animal = animal;
	o.shear = shear;
	o.timePerLiter = 100;
	if shear:getType() == "SheepElectricShears" then
		o.timePerLiter = 60;
	end
	o.timePerLiter = o.timePerLiter - (character:getPerkLevel(Perks.Husbandry) * 2)
	o.maxTime = o:getDuration()
	o.timer = 0;
	o.lastTimer = 0;
	o.stopOnAim = false;
	return o;
end
