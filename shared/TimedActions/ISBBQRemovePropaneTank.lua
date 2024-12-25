--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISBBQRemovePropaneTank = ISBaseTimedAction:derive("ISBBQRemovePropaneTank");

function ISBBQRemovePropaneTank:isValid()
	return self.bbq:getObjectIndex() ~= -1 and self.bbq:hasPropaneTank()
end

function ISBBQRemovePropaneTank:waitToStart()
	self.character:faceThisObject(self.bbq)
	return self.character:shouldBeTurning()
end

function ISBBQRemovePropaneTank:update()
	self.character:faceThisObject(self.bbq)

    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISBBQRemovePropaneTank:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
	self.sound = self.character:playSound("BBQPropaneTankRemove")
end

function ISBBQRemovePropaneTank:stop()
	self.character:stopOrTriggerSound(self.sound)
	ISBaseTimedAction.stop(self);
end

function ISBBQRemovePropaneTank:perform()
	self.character:stopOrTriggerSound(self.sound)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISBBQRemovePropaneTank:complete()

	local bbq = self.bbq
	if bbq and bbq:hasPropaneTank() then
		local tank = bbq:removePropaneTank()
		bbq:sendObjectChange('state')
		self.character:getSquare():AddWorldInventoryItem(tank, 0.5, 0.5, 0)

	end

	return true;
end

function ISBBQRemovePropaneTank:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 100
end

function ISBBQRemovePropaneTank:new (character, bbq)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	-- custom fields
	o.bbq = bbq
	return o
end
