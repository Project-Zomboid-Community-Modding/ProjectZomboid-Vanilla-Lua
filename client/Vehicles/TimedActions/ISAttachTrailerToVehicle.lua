require "TimedActions/ISBaseTimedAction"

ISAttachTrailerToVehicle = ISBaseTimedAction:derive("ISAttachTrailerToVehicle")

function ISAttachTrailerToVehicle:isValid()
	return self.vehicleA:getVehicleTowing() == nil or self.vehicleA:getVehicleTowing() == self.vehicleB
end

function ISAttachTrailerToVehicle:waitToStart()
	self.vehicleA:getTowingWorldPos(self.attachmentA, self.hitchPos) 
	self.character:faceLocationF(self.hitchPos:x(), self.hitchPos:y())
	return self.character:shouldBeTurning()
end

function ISAttachTrailerToVehicle:update()
	self.vehicleA:getTowingWorldPos(self.attachmentA, self.hitchPos) 
	self.character:faceLocationF(self.hitchPos:x(), self.hitchPos:y())
	self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISAttachTrailerToVehicle:start()
	self:setActionAnim("VehicleTrailer")
	self.sound = self.character:getEmitter():playSound("VehicleTowAttach")
	self.vehicleA:beginAttachingTrailer()
	self:attachTrailer()
end

function ISAttachTrailerToVehicle:stop()
	self.vehicleA:stopAttachingTrailer()
	self:detachTrailer()
	self:stopSound()
	ISBaseTimedAction.stop(self)
end

function ISAttachTrailerToVehicle:perform()
	self.vehicleA:stopAttachingTrailer()
	self:stopSound()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISAttachTrailerToVehicle:attachTrailer()
	local square = self.vehicleA:getCurrentSquare()
	local vehicleB = ISVehicleTrailerUtils.getTowableVehicleNear(square, self.vehicleA, self.attachmentA, self.attachmentB)
	if vehicleB == self.vehicleB then
		local args = { vehicleA = self.vehicleA:getId(), vehicleB = self.vehicleB:getId(), attachmentA = self.attachmentA, attachmentB = self.attachmentB }
		sendClientCommand(self.character, 'vehicle', 'attachTrailer', args)
	end
end

function ISAttachTrailerToVehicle:detachTrailer()
	self.vehicleA:stopAttachingTrailer()
	local args = { vehicle = self.vehicleA:getId() }
	sendClientCommand(self.character, 'vehicle', 'detachTrailer', args)
end

function ISAttachTrailerToVehicle:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISAttachTrailerToVehicle:new(character, vehicleA, vehicleB, attachmentA, attachmentB)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = 100
	o.vehicleA = vehicleA
	o.vehicleB = vehicleB
	o.attachmentA = attachmentA
	o.attachmentB = attachmentB
	o.hitchPos = Vector3f.new()
	if character:isTimedActionInstant() then
		o.maxTime = 1
	end
	return o
end

