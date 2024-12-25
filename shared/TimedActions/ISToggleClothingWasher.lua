--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISToggleClothingWasher = ISBaseTimedAction:derive("ISToggleClothingWasher");

function ISToggleClothingWasher:isValid()
	return self.object:getObjectIndex() ~= -1
end

function ISToggleClothingWasher:update()
	self.character:faceThisObject(self.object)
end

function ISToggleClothingWasher:start()
end

function ISToggleClothingWasher:stop()
	ISBaseTimedAction.stop(self)
end

function ISToggleClothingWasher:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISToggleClothingWasher:complete()
	if not self.object then return false end
	self.object:setActivated(not self.object:isActivated())
	self.object:sendObjectChange("washer.state")
	return true
end

function ISToggleClothingWasher:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 1
end

function ISToggleClothingWasher:new(character, object)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.maxTime = o:getDuration()
	return o
end

