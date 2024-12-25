--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISEmptyRainBarrelAction = ISBaseTimedAction:derive("ISEmptyRainBarrelAction")

function ISEmptyRainBarrelAction:isValid()
	return self.object:getObjectIndex() ~= -1
end

function ISEmptyRainBarrelAction:waitToStart()
	self.character:faceThisObject(self.object)
	return self.character:shouldBeTurning()
end

function ISEmptyRainBarrelAction:start()
	self.sound = self.character:playSound("GetWaterFromLake")
	self.startAmount = self.object:getWaterAmount()
end

function ISEmptyRainBarrelAction:update()
	self.character:faceThisObject(self.object)
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
    self.object:setWaterAmount(self.startAmount * (1 - self:getJobDelta()))
end

function ISEmptyRainBarrelAction:stop()
	self:stopSound()

	ISBaseTimedAction.stop(self)
end

function ISEmptyRainBarrelAction:perform()
	self:stopSound()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISEmptyRainBarrelAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISEmptyRainBarrelAction:serverStop()
	self.object:setWaterAmount(self.object:getWaterAmount() * (1 - self.netAction:getProgress()))
	self.object:transmitModData()
end

function ISEmptyRainBarrelAction:complete()
	self.object:setWaterAmount(0)
	self.object:transmitModData()

	return true
end

function ISEmptyRainBarrelAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return math.max(self.object:getWaterAmount(), 100)
end

function ISEmptyRainBarrelAction:new(character, object)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.maxTime = o:getDuration()
	return o
end    	
