--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPutOutCampfireAction = ISBaseTimedAction:derive("ISPutOutCampfireAction");

function ISPutOutCampfireAction:isValid()
	self.campfire:updateFromIsoObject()
	return self.campfire:getObject() ~= nil
end

function ISPutOutCampfireAction:waitToStart()
	self.character:faceThisObject(self.campfire:getObject())
	return self.character:shouldBeTurning()
end

function ISPutOutCampfireAction:update()
	self.character:faceThisObject(self.campfire:getObject())
end

function ISPutOutCampfireAction:start()
end

function ISPutOutCampfireAction:stop()
	ISBaseTimedAction.stop(self);
end

function ISPutOutCampfireAction:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPutOutCampfireAction:complete()
	local campfire = SCampfireSystem.instance:getLuaObjectAt(self.campfire.x, self.campfire.y, self.campfire.z)
	if campfire then
		campfire:putOut()
	end
	return true
end

function ISPutOutCampfireAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 60;
end

function ISPutOutCampfireAction:new (character, campfire)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	-- custom fields
	o.campfire = campfire
	return o
end
