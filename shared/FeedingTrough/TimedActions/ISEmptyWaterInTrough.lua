--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISEmptyWaterInTrough = ISBaseTimedAction:derive("ISEmptyWaterInTrough")

function ISEmptyWaterInTrough:isValid()
    return true;
end

function ISEmptyWaterInTrough:waitToStart()
	self.character:faceThisObject(self.objectTo)
	return self.character:shouldBeTurning()
end

function ISEmptyWaterInTrough:update()

end

function ISEmptyWaterInTrough:start()
	self.sound = self.character:playSound("AnimalFeederEmptyWater")
end

function ISEmptyWaterInTrough:stop()
	self:stopSound()
	ISBaseTimedAction.stop(self)
end

function ISEmptyWaterInTrough:perform()
	self:stopSound()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISEmptyWaterInTrough:complete()
    local luaObject = SFeedingTroughSystem.instance:getLuaObjectAt(self.objectTo:getX(), self.objectTo:getY(), self.objectTo:getZ())
	if luaObject then
        luaObject:emptyWater()
    end
	return true;
end

function ISEmptyWaterInTrough:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISEmptyWaterInTrough:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return self.maxTime;
end

function ISEmptyWaterInTrough:new(character, objectTo)
	local o = ISBaseTimedAction.new(self, character)
	o.objectTo = objectTo
	o.stopOnWalk = true
	o.stopOnRun = true
	o.maxTime = objectTo:getWater() * 4;
	if o.character:isTimedActionInstant() then
		o.maxTime = 1
	end
	return o
end    	
