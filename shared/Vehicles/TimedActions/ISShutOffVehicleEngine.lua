--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISShutOffVehicleEngine = ISBaseTimedAction:derive("ISShutOffVehicleEngine")

function ISShutOffVehicleEngine:isValid()
	local vehicle = self.character:getVehicle()
	return vehicle ~= nil and vehicle:isDriver(self.character)
end

function ISShutOffVehicleEngine:update()
	-- self:forceComplete()
end

function ISShutOffVehicleEngine:start()
end

function ISShutOffVehicleEngine:stop()
	ISBaseTimedAction.stop(self)
end

function ISShutOffVehicleEngine:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISShutOffVehicleEngine:complete()
	local vehicle = self.character:getVehicle()
    if vehicle then
        if vehicle:isDriver(self.character) then
            vehicle:shutOff()
        else
            print('player not driver')
            return false
        end
    else
        print('player not in vehicle')
        return false
    end
    return true
end

function ISShutOffVehicleEngine:getDuration()
    return 0
end

function ISShutOffVehicleEngine:new(character)
	local o = ISBaseTimedAction.new(self, character)
    o.stopOnWalk = false
    o.stopOnRun = false
	o.maxTime = o.getDuration()
	return o
end

