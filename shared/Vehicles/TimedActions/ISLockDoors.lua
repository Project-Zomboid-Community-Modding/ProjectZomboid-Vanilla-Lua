--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISLockDoors = ISBaseTimedAction:derive("ISLockDoors")

function ISLockDoors:isValid()
	return self.character:getVehicle() == self.vehicle;
end

function ISLockDoors:update()
	
end

function ISLockDoors:start()
	for seat=1,self.vehicle:getMaxPassengers() do
		local part = self.vehicle:getPassengerDoor(seat-1)
		if part then
			self.vehicle:playPartSound(part, self.character, self.locked and "Lock" or "Unlock")
			break
		end
	end
end

function ISLockDoors:stop()
	ISBaseTimedAction.stop(self)
end

function ISLockDoors:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISLockDoors:complete()
    for seat=1,self.vehicle:getMaxPassengers() do
    	local part = self.vehicle:getPassengerDoor(seat-1)
    	if part then
    		if self.vehicle then
                if not part then
                	print('no such part '..tostring(part))
                	return
                end
                if not part:getDoor() then
                	print('part ' .. part .. ' has no door')
                	return
                end
                if not part:getDoor():isLockBroken() then
                	part:getDoor():setLocked(self.locked)
                end
                self.vehicle:transmitPartDoor(part)
            else
                print('no such vehicle id='..tostring(self.vehicle))
            end
    	end
    end
    if not isServer() and JoypadState.players[self.character:getPlayerNum()+1] then
    	-- Hack: Mouse players click the trunk icon in the dashboard.
        if self.vehicle then
        	self.vehicle:setTrunkLocked(self.locked)
        else
        	print('player not in vehicle')
        end
    end

	return true;
end

function ISLockDoors:getDuration()
     if self.character:isTimedActionInstant() then
        return 1;
     end
	return 10;
end

function ISLockDoors:new(character, vehicle, locked)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = vehicle
	o.locked = locked
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

