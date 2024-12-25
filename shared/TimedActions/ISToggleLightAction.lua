--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISToggleLightAction = ISBaseTimedAction:derive("ISToggleLightAction");

function ISToggleLightAction:isValid()
	return true
end

function ISToggleLightAction:update()
end

function ISToggleLightAction:start()
	self.character:faceThisObject(self.object)
end

function ISToggleLightAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISToggleLightAction:perform()
	-- needed to remove from queue / start next.
	self.object:getSquare():playSound("LightSwitch");
	ISBaseTimedAction.perform(self)
end

function ISToggleLightAction:complete()
	self.object:toggle()
	return true
end

function ISToggleLightAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 1
end

function ISToggleLightAction:new(character, object)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	o.object = object
	o.useProgressBar = false;
	return o
end
