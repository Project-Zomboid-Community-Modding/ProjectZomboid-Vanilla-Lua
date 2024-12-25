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
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISSetComboWasherDryerMode:complete()
	if not self.object then return end
	if self.mode == "washer" then
		self.object:setModeWasher()
	else
		self.object:setModeDryer()
	end
	self.object:sendObjectChange("mode")
	return true
end

function ISSetComboWasherDryerMode:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 1
end

function ISSetComboWasherDryerMode:new(character, object, mode)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.maxTime = o:getDuration()
	o.mode = mode
	return o
end

