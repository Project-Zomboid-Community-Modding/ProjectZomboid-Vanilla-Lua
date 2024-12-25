--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISLockVehicleDoor = ISBaseTimedAction:derive("ISLockVehicleDoor")

function ISLockVehicleDoor:isValid()
	return self.part:getDoor() and not self.part:getDoor():isLocked()
end

function ISLockVehicleDoor:update()
	if not self.character:getVehicle() then
		self.character:faceThisObject(self.vehicle)
	end
end

function ISLockVehicleDoor:start()
	self.vehicle:playPartSound(self.part, self.character, "Lock")
end

function ISLockVehicleDoor:stop()
	ISBaseTimedAction.stop(self)
end

function ISLockVehicleDoor:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISLockVehicleDoor:complete()
    if self.vehicle then
    	if not self.part then
    		print('no such part '..tostring(self.part))
    		return
    	end
    	if not self.part:getDoor() then
    		print('part ' .. self.part .. ' has no door')
    		return
    	end
    	if not self.part:getDoor():isLockBroken() then
    		self.part:getDoor():setLocked(true)
    	end
    	self.vehicle:transmitPartDoor(self.part)
    else
    	print('no such vehicle id='..tostring(self.vehicle))
    end

	return true;
end

function ISLockVehicleDoor:getDuration()
	return 0;
end

function ISLockVehicleDoor:new(character, part)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

