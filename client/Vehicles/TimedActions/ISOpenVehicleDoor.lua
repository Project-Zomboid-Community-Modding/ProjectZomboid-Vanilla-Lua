--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenVehicleDoor = ISBaseTimedAction:derive("ISOpenVehicleDoor")

function ISOpenVehicleDoor:isValid()
	return self.part and self.part:getDoor() and not self.part:getDoor():isOpen() and self.vehicle:isStopped()
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
	local args = { vehicle = self.vehicle:getId(), part = self.part:getId(), open = true }
	sendClientCommand(self.character, 'vehicle', 'setDoorOpen', args)
	-- FIXME: due to network delay, we should wait until the server tells the client the door is open before finishing
	self.part:getDoor():setOpen(true)
	triggerEvent("OnContainerUpdate")

	if self.character:getVehicle() then
		self.vehicle:playPassengerAnim(self.seat, "idle")
	else
		self.character:PlayAnim("Idle")
	end

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

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISOpenVehicleDoor:new(character, vehicle, partOrSeat)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.vehicle = vehicle
	if instanceof(partOrSeat, "VehiclePart") then
		o.part = partOrSeat
	else
		o.seat = partOrSeat
		o.part = vehicle:getPassengerDoor(partOrSeat)
	end
	o.maxTime = -1
	return o
end

