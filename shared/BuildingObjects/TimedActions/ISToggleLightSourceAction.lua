--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISToggleLightSourceAction = ISBaseTimedAction:derive("ISToggleLightSourceAction");

function ISToggleLightSourceAction:isValid()
	return self.lightSource:haveFuel()
end

function ISToggleLightSourceAction:start()
end

function ISToggleLightSourceAction:update()
end

function ISToggleLightSourceAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISToggleLightSourceAction:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISToggleLightSourceAction:complete()
	if self.lightSource then
		self.lightSource:toggleLightSource(not self.lightSource:isLightSourceOn())
		self.lightSource:sendObjectChange('lightSource')
		return true
	end
	return false
end

function ISToggleLightSourceAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 5
end

function ISToggleLightSourceAction:new(character, lightSource)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.lightSource = lightSource
	o.ignoreHandsWounds = true;
	return o
end
