--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenVehicleDoor = ISBaseTimedAction:derive("ISOpenVehicleDoor")

function ISOpenVehicleDoor:isValid()
    if not isClient() and not isServer() then
        return self.part ~= nil and self.part:getDoor() ~= nil and not self.part:getDoor():isOpen()
    end
	return self.part ~= nil
end

function ISOpenVehicleDoor:waitToStart()
	if self.part and self.part:getId() == "EngineDoor" then
		self.character:faceThisObject(self.vehicle)
		return self.character:shouldBeTurning()
	end
	return false
end

function ISOpenVehicleDoor:update()
	self.character:PlayAnim("Idle")
	if self.character:getSpriteDef():isFinished() then
--	if self.door:isAnimationFinished() then
		self:forceComplete()
	end
end

function ISOpenVehicleDoor:start()
	-- TODO: sync part animation + sound
	self.vehicle:playPartAnim(self.part, "Open")
	self.vehicle:playPartSound(self.part, self.character, "Open")
	self.action:setOverrideAnimation(true)
	if self.seat then
		self.vehicle:playPassengerAnim(self.seat, "openDoor", self.character)
	else
		-- TODO: move player to exact position so player/door animations line up
		self.vehicle:playActorAnim(self.part, "Open", self.character)
	end
	-- Set this here to negate the effects of injuries, negative moodles, etc.
	self.action:setTime(5)
end

function ISOpenVehicleDoor:stop()
	-- TODO: interrupted, close door again?
	ISBaseTimedAction.stop(self)
end

function ISOpenVehicleDoor:perform()

	if self.character:getVehicle() then
		self.vehicle:playPassengerAnim(self.seat, "idle")
	else
		self.character:PlayAnim("Idle")
	end

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISOpenVehicleDoor:complete()
	if self.vehicle then
    	if not self.part then
    		print('no such part '..tostring(self.part))
    		return
    	end
    	if not self.part:getDoor() then
    		print('part ' .. self.part .. ' has no door')
    		return
    	end
    	if not self.part:getDoor():isLocked() then
    	    self.part:getDoor():setOpen(true)
    	    self.vehicle:transmitPartDoor(self.part)
    	end
    else
    	print('no such vehicle id='..tostring(self.vehicle))
    end
	triggerEvent("OnContainerUpdate")

	--Opening a door or the boot/trunk has a chance of setting the alarm off if the vehicle is alarmed
	if not self.vehicle:isPreviouslyEntered() then
		-- if self.part:getId() ~= "EngineDoor" and not self.vehicle:isPreviouslyEntered() then -- need to comment out this line as it made it so that opening hoods doesn't trigger alarms
		if not self.vehicle:isPreviouslyEntered() then
			if not (self.character:getInventory():haveThisKeyId(self.vehicle:getKeyId()) or self.vehicle:isKeysInIgnition())  then
				-- if self.vehicle:isAlarmed() and ZombRand(100) <= 20 then -- need to remove the RNG check as it's undesired
				if self.vehicle:isAlarmed() then
					self.vehicle:triggerAlarm();
				end
			end
			self.vehicle:setPreviouslyEntered(true);
		end
	end

    return true
end

function ISOpenVehicleDoor:getDuration()
	return 0;
end

function ISOpenVehicleDoor:new(character, vehicle, part)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = vehicle
	o.part = part
	o.seat = part:getContainerSeatNumber()
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	o.ignoreHandsWounds = true;
	return o
end

