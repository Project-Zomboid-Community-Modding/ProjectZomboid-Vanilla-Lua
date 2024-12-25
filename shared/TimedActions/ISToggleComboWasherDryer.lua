--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISToggleComboWasherDryer = ISBaseTimedAction:derive("ISToggleComboWasherDryer");

function ISToggleComboWasherDryer:isValid()
	return self.object:getObjectIndex() ~= -1
end

function ISToggleComboWasherDryer:update()
	self.character:faceThisObject(self.object)
end

function ISToggleComboWasherDryer:start()
end

function ISToggleComboWasherDryer:stop()
	ISBaseTimedAction.stop(self)
end

function ISToggleComboWasherDryer:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISToggleComboWasherDryer:complete()
	if not self.object then return end
	self.object:setActivated(not self.object:isActivated())
	self.object:sendObjectChange(self.object:isModeWasher() and "washer.state" or "dryer.state")
	return true
end

function ISToggleComboWasherDryer:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 1
end

function ISToggleComboWasherDryer:new(character, object)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.maxTime = o:getDuration()
	return o
end

