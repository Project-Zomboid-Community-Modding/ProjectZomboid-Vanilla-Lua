--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISToggleClothingDryer = ISBaseTimedAction:derive("ISToggleClothingDryer");

function ISToggleClothingDryer:isValid()
	return self.object:getObjectIndex() ~= -1
end

function ISToggleClothingDryer:update()
	self.character:faceThisObject(self.object)
end

function ISToggleClothingDryer:start()
end

function ISToggleClothingDryer:stop()
	ISBaseTimedAction.stop(self)
end

function ISToggleClothingDryer:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISToggleClothingDryer:complete()
	if not self.object then return false end
	self.object:setActivated(not self.object:isActivated())
	self.object:sendObjectChange("dryer.state")
	return true
end

function ISToggleClothingDryer:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 1
end

function ISToggleClothingDryer:new(character, object)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.maxTime = o:getDuration()
	return o
end

