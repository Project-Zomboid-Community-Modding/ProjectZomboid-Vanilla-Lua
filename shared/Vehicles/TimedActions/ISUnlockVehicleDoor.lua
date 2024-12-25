--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISUnlockVehicleDoor = ISBaseTimedAction:derive("ISUnlockVehicleDoor")

function ISUnlockVehicleDoor:isValid()
	--print("ISUnlockVehicleDoor:isValid()")
	--print(self.part:getDoor() and self.part:getDoor():isLocked())
	if isClient() then
	   return true
	end
	return self.part:getDoor() and (self.forceValid or self.part:getDoor():isLocked())
end

function ISUnlockVehicleDoor:update()
	if not self.character:getVehicle() then
		self.character:faceThisObject(self.vehicle)
	end
	--print("ISUnlockVehicleDoor:update()")
	-- TODO: drunk/panic = fumble
end

function ISUnlockVehicleDoor:start()
	if not self.character:getVehicle() then
		self.character:faceThisObject(self.vehicle)
	end
	if not isClient() and not isServer() then
        self.vehicle:toggleLockedDoor(self.part, self.character, false)
        if self.part:getDoor():isLocked() then
            self:forceStop();
            return;
        end
        -- isValid() will return false since the door isn't locked now
        self.forceValid = true
        self:forceComplete()
    end
end

function ISUnlockVehicleDoor:stop()
    if self.part:getDoor():isLockBroken() then
        -- self.character:Say(getText("IGUI_PlayerText_VehicleLockIsBroken"))
        HaloTextHelper.addBadText(self.character, getText("IGUI_PlayerText_VehicleLockIsBroken"));
--         HaloTextHelper.addText(self.character, getText("IGUI_PlayerText_VehicleLockIsBroken"), getCore():getGoodHighlitedColor());
    end
    self.vehicle:playPartSound(self.part, self.character, "IsLocked");
	ISBaseTimedAction.stop(self)
end

function ISUnlockVehicleDoor:perform()

    self.vehicle:playPartSound(self.part, self.character, "Unlock")
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISUnlockVehicleDoor:complete()
    if self.vehicle then
    	if not self.part then
    		print('no such part '..tostring(self.part))
    		return
    	end
    	if not self.part:getDoor() then
    		print('part ' .. self.part .. ' has no door')
    		return
    	end
    	self.vehicle:toggleLockedDoor(self.part, self.character, false)
    	self.vehicle:transmitPartDoor(self.part)
    	if self.part:getDoor():isLocked() then
    	    return false
    	end
    else
    	print('no such vehicle id='..tostring(self.vehicle))
    end

	return true;
end

function ISUnlockVehicleDoor:getDuration()
	return 1;
end

function ISUnlockVehicleDoor:new(character, part)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.forceValid = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

