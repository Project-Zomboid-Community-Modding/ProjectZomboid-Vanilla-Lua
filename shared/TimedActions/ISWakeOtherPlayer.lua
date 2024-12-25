--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISWakeOtherPlayer = ISBaseTimedAction:derive("ISWakeOtherPlayer");

function ISWakeOtherPlayer:isValid()
	return self.otherPlayer:isAlive() and self.otherPlayer:isAsleep()
end

function ISWakeOtherPlayer:start()
end

function ISWakeOtherPlayer:update()
	self.character:faceThisObject(self.otherPlayer)
end

function ISWakeOtherPlayer:stop()
	ISBaseTimedAction.stop(self)
end

function ISWakeOtherPlayer:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISWakeOtherPlayer:complete()
	self.otherPlayer:sendObjectChange("wakeUp")
end

function ISWakeOtherPlayer:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 30
end

function ISWakeOtherPlayer:new(character, otherPlayer)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.otherPlayer = otherPlayer
	return o
end
