--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISSetComboWasherDryerMode = ISBaseTimedAction:derive("ISSetComboWasherDryerMode");

function ISSetComboWasherDryerMode:isValid()
	if (self.mode == "washer") ~= self.object:isModeDryer() then return false end
	return self.object:getObjectIndex() ~= -1
end

function ISSetComboWasherDryerMode:update()
	self.character:faceThisObject(self.object)
end

function ISSetComboWasherDryerMode:start()
end

function ISSetComboWasherDryerMode:stop()
	ISBaseTimedAction.stop(self)
end

function ISSetComboWasherDryerMode:perform()
	local obj = self.object
	local args = { x = obj:getX(), y = obj:getY(), z = obj:getZ(), mode = self.mode }
	sendClientCommand(self.character, 'comboWasherDryer', 'setMode', args)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISSetComboWasherDryerMode:new(character, object, mode)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.stopOnWalk = true
	o.stopOnRun = true
	o.maxTime = 0
	o.mode = mode
	return o
end

