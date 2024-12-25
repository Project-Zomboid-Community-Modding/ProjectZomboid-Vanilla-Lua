--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISHotwireVehicle = ISBaseTimedAction:derive("ISHotwireVehicle")

function ISHotwireVehicle:isValid()
	local vehicle = self.character:getVehicle()
	return vehicle ~= nil and
--		vehicle:isEngineWorking() and
		vehicle:isDriver(self.character)
end

function ISHotwireVehicle:update()
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISHotwireVehicle:start()
	self.sound = self.character:getEmitter():playSound("VehicleHotwireStart")
end

function ISHotwireVehicle:stop()
	self:stopSound()
	ISBaseTimedAction.stop(self)
end

function ISHotwireVehicle:perform()
	self:stopSound()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISHotwireVehicle:complete()
    self.character:getVehicle():tryHotwire(self.character:getPerkLevel(Perks.Electricity));
    return true
end

function ISHotwireVehicle:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISHotwireVehicle:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 200 - (self.character:getPerkLevel(Perks.Electricity) * 3);
end

function ISHotwireVehicle:new(character)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

