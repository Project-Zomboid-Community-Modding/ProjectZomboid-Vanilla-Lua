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
	local obj = self.object
	local args = { x = obj:getX(), y = obj:getY(), z = obj:getZ() }
	sendClientCommand(self.character, 'comboWasherDryer', 'toggle', args)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISToggleComboWasherDryer:new(character, object)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.stopOnWalk = true
	o.stopOnRun = true
	o.maxTime = 0
	return o
end

