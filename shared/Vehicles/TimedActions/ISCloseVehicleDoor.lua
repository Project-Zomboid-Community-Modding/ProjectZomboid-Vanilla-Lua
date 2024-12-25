--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCloseVehicleDoor = ISBaseTimedAction:derive("ISCloseVehicleDoor")

function ISCloseVehicleDoor:isValid()
    if not isClient() and not isServer() then
        return self.part ~= nil and self.part:getDoor() ~= nil and self.part:getDoor():isOpen()
    end
    return self.part ~= nil and self.part:getDoor() ~= nil
end

function ISCloseVehicleDoor:update()
--	if self.door:isAnimationFinished() then
	self.character:PlayAnim("Idle")
	if self.character:getSpriteDef():isFinished() then
		self:forceComplete()
	end
end

function ISCloseVehicleDoor:start()
	-- TODO: sync part animation + sound
	self.vehicle:playPartAnim(self.part, "Close")
	self.vehicle:playPartSound(self.part, self.character, "Close")
	self.action:setOverrideAnimation(true)
	if self.seat then
		self.vehicle:playPassengerAnim(self.seat, "closeDoor", self.character)
	else
		-- TODO: move player to exact position so player/door animations line up
		self.vehicle:playActorAnim(self.part, "Close", self.character)
	end
	-- Set this here to negate the effects of injuries, negative moodles, etc.
	self.action:setTime(4)
end

function ISCloseVehicleDoor:stop()
	-- TODO: interrupted, close door again?
	ISBaseTimedAction.stop(self)
end

function ISCloseVehicleDoor:perform()

	if self.character:getVehicle() and self.seat then
		self.vehicle:playPassengerAnim(self.seat, "idle")
	else
		self.character:PlayAnim("Idle")
	end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISCloseVehicleDoor:complete()
	if self.vehicle then
        if not self.part then
        	print('no such part '..tostring(self.part))
        	return
        end
        if not self.part:getDoor() then
        	print('part ' .. self.part .. ' has no door')
        	return
        end
        self.part:getDoor():setOpen(false)
        self.vehicle:transmitPartDoor(self.part)
    else
       	print('no such vehicle id='..tostring(self.vehicle))
    end
	triggerEvent("OnContainerUpdate")

	return true
end

function ISCloseVehicleDoor:getDuration()
	return 0;
end

function ISCloseVehicleDoor:new(character, vehicle, part)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = vehicle
	o.part = part
	o.seat = part:getContainerSeatNumber()
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

