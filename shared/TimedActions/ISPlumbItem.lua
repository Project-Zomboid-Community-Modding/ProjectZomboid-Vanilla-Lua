--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPlumbItem = ISBaseTimedAction:derive("ISPlumbItem");

function ISPlumbItem:isValid()
	return self.character:isEquipped(self.wrench);
--	return true;
end

function ISPlumbItem:update()
	self.character:faceThisObject(self.itemToPipe)

    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISPlumbItem:start()
	self.sound = self.character:playSound("RepairWithWrench")
end

function ISPlumbItem:stop()
	self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISPlumbItem:perform()
	self.character:stopOrTriggerSound(self.sound)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPlumbItem:complete()
	if self.itemToPipe then
		self.itemToPipe:getModData().canBeWaterPiped = false
		self.itemToPipe:setUsesExternalWaterSource(true)
		self.itemToPipe:transmitModData()
		self.itemToPipe:sendObjectChange('usesExternalWaterSource', { value = true })
		buildUtil.setHaveConstruction(self.itemToPipe:getSquare(), true);
	else
		noise('sq is null or index is invalid')
	end

	return true;
end

function ISPlumbItem:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 100
end

function ISPlumbItem:new(character, itemToPipe, wrench)
	local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.itemToPipe = itemToPipe;
	o.wrench = wrench;
	o.maxTime = o:getDuration();
	return o;
end
