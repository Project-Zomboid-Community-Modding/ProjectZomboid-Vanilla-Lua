--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISSitOnGround = ISBaseTimedAction:derive("ISSitOnGround")

function ISSitOnGround:isValid()
    return true
end

function ISSitOnGround:waitToStart()
	return self.character:getCurrentActionContextStateName() ~= "idle"
end

function ISSitOnGround:update()
	if self.character:getVariableBoolean("SitGroundStarted") or not self.character:isSitOnGround() then
		self:forceComplete()
	end
end

function ISSitOnGround:start()
	self.character:reportEvent("EventSitOnGround")
end

function ISSitOnGround:stop()
    ISBaseTimedAction.stop(self)
end

function ISSitOnGround:perform()
	ISBaseTimedAction.perform(self)
end

function ISSitOnGround:complete()
	return true
end

function ISSitOnGround:getDuration()
	return -1
end

function ISSitOnGround:new(character)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.useProgressBar = false
	return o
end
