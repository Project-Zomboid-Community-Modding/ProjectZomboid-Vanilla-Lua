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
	self.startAmount = self.object:getFluidAmount()
end

function ISEmptyRainBarrelAction:update()
	self.character:faceThisObject(self.object)
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
end

function ISEmptyRainBarrelAction:stop()
	self:stopSound()

	if not isClient() and not isServer() then
		self:serverStop()
	end
	
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
	local progress = self.netAction and self.netAction:getProgress() or self:getJobDelta();
	local used = self.object:getFluidAmount() * progress;
	self.object:useFluid(used)
end

function ISEmptyRainBarrelAction:complete()
	self.object:emptyFluid()
	return true
end

function ISEmptyRainBarrelAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return math.max(self.object:getFluidAmount(), 100)
end

function ISEmptyRainBarrelAction:new(character, object)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.maxTime = o:getDuration()
	return o
end    	
