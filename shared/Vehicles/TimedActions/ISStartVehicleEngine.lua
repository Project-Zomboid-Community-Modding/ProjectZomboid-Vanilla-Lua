--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISStartVehicleEngine = ISBaseTimedAction:derive("ISStartVehicleEngine")

function ISStartVehicleEngine:isValid()
	local vehicle = self.character:getVehicle()
	return vehicle ~= nil and vehicle:isDriver(self.character)
end

function ISStartVehicleEngine:update()
	-- self:forceComplete()
end

function ISStartVehicleEngine:start()
end

function ISStartVehicleEngine:stop()
	ISBaseTimedAction.stop(self)
end

function ISStartVehicleEngine:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISStartVehicleEngine:complete()
    local vehicle = self.character:getVehicle()
	local haveKey = false;
	if self.character:getInventory():haveThisKeyId(vehicle:getKeyId()) then
		haveKey = true;
	end
    if vehicle then
        if vehicle:isDriver(self.character) then
            vehicle:tryStartEngine(haveKey)
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

function ISStartVehicleEngine:getDuration()
    return 0
end

function ISStartVehicleEngine:new(character)
	local o = ISBaseTimedAction.new(self, character)
    o.stopOnWalk = false
    o.stopOnRun = false
    o.maxTime = o.getDuration()
	return o
end

