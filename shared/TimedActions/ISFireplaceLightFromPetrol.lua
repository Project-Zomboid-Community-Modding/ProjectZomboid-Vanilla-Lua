--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFireplaceLightFromPetrol = ISBaseTimedAction:derive("ISFireplaceLightFromPetrol")

function ISFireplaceLightFromPetrol:isValid()
	local playerInv = self.character:getInventory()
	return playerInv:contains(self.petrol) and playerInv:contains(self.lighter) and
			self.lighter:getCurrentUsesFloat() > 0 and
			self.petrol:getCurrentUsesFloat() > 0 and
			self.fireplace:getObjectIndex() ~= -1 and
			not self.fireplace:isLit() and
			self.fireplace:hasFuel()
end

function ISFireplaceLightFromPetrol:waitToStart()
	self.character:faceThisObject(self.fireplace)
	return self.character:shouldBeTurning()
end

function ISFireplaceLightFromPetrol:update()
	self.petrol:setJobDelta(self:getJobDelta())
	self.character:faceThisObject(self.fireplace)
end

function ISFireplaceLightFromPetrol:start()
	self.petrol:setJobType(campingText.lightCampfire)
	self.petrol:setJobDelta(0.0)
	self.lighter:setJobType(campingText.lightCampfire)
	self.lighter:setJobDelta(0.0)
	self:setActionAnim("Pour")
	-- Don't call setOverrideHandModels() with self.petrol, the right-hand mask
	-- will bork the animation.
	self:setOverrideHandModels(self.petrol:getStaticModel(), nil)
	self.sound = self.character:playSound("FireplaceLight")
end

function ISFireplaceLightFromPetrol:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.petrol:setJobDelta(0.0)
	self.lighter:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISFireplaceLightFromPetrol:perform()
	self.character:stopOrTriggerSound(self.sound)
	self.petrol:getContainer():setDrawDirty(true)
    self.petrol:setJobDelta(0.0)
	self.lighter:setJobDelta(0.0)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISFireplaceLightFromPetrol:complete()
	self.petrol:getFluidContainer():adjustAmount(self.petrol:getFluidContainer():getAmount() - ZomboidGlobals.LightFromPetrolAmount);
	self.lighter:UseAndSync()

	if self.fireplace then
		if not self.fireplace:isLit() and self.fireplace:hasFuel() then
			self.fireplace:setLit(true)
			if self.fireplace:getContainer() then
				self.fireplace:getContainer():addItemsToProcessItems()
			end
		end
		self.fireplace:sendObjectChange('state')
	end
	return true
end

function ISFireplaceLightFromPetrol:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 20
end

function ISFireplaceLightFromPetrol:new(character, fireplace, lighter, petrol)
	local o = ISBaseTimedAction.new(self, character);
	o.maxTime = o:getDuration()
	-- custom fields
	o.fireplace = fireplace
	o.lighter = lighter
	o.petrol = petrol
	return o
end
