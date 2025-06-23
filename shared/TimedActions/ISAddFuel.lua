--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddFuel = ISBaseTimedAction:derive("ISAddFuel");

function ISAddFuel:isValid()
	if self.generator:getFuel() >= 100 then ISBaseTimedAction.stop(self) end
	return self.generator:getObjectIndex() ~= -1 and
		self.character:isPrimaryHandItem(self.petrol) or self.character:isSecondaryHandItem(self.petrol)
end

function ISAddFuel:waitToStart()
	self.character:faceThisObject(self.generator)
	return self.character:shouldBeTurning()
end

function ISAddFuel:update()
	self.petrol:setJobDelta(self:getJobDelta())
	self.character:faceThisObject(self.generator)

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISAddFuel:start()
	self:setActionAnim("refuelgascan")
	-- Don't call setOverrideHandModels() with self.petrol, the right-hand mask
	-- will bork the animation.
	self.petrol:setJobType(getText("ContextMenu_GeneratorAddFuel"))
	self.petrol:setJobDelta(0.0)
	self:setOverrideHandModels(self.petrol:getStaticModel(), nil)
	self.sound = self.character:playSound("GeneratorAddFuel")
end

function ISAddFuel:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.petrol:setJobDelta(0.0)
    ISBaseTimedAction.stop(self);
end

function ISAddFuel:perform()
	self.character:stopOrTriggerSound(self.sound)
    self.petrol:setJobDelta(0.0)
		
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISAddFuel:complete()
	local endFuel = 0;
	while self.fluidCont and self.fluidCont:getAmount() >= 0.098 and self.generator:getFuel() + endFuel < 100 do
		local amount = self.fluidCont:getAmount() - 0.1;
		self.fluidCont:adjustAmount(amount);
		endFuel = endFuel + 1;
	end

	self.petrol:syncItemFields()
	self.generator:setFuel(self.generator:getFuel() + endFuel)
	self.generator:sync()

	return true;
end

function ISAddFuel:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 70 + (self.fluidCont:getAmount() * 50)
end

function ISAddFuel:new(character, generator, petrol, maxTime)
	local o = ISBaseTimedAction.new(self, character);
    o.petrol = petrol;
	o.fluidCont = o.petrol:getFluidContainer();
	o.generator = generator;
	o.maxTime = o:getDuration();
	return o;
end