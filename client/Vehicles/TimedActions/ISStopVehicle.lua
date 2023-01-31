--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISStopVehicle = ISBaseTimedAction:derive("ISStopVehicle")

function ISStopVehicle:isValid()
	local vehicle = self.character:getVehicle()
	return vehicle ~= nil and vehicle:getSeat(self.character) == 0
end

function ISStopVehicle:update()
	local vehicle = self.character:getVehicle()
	if math.abs(vehicle:getCurrentSpeedKmHour()) < 0.8 then
		self:forceComplete()
	else 
		vehicle:setForceBrake()
	end
end

function ISStopVehicle:start()
	local vehicle = self.character:getVehicle()
	vehicle:setForceBrake()
end

function ISStopVehicle:stop()
	local vehicle = self.character:getVehicle()
	ISBaseTimedAction.stop(self)
end

function ISStopVehicle:perform()
	local vehicle = self.character:getVehicle()
	ISBaseTimedAction.perform(self)
end

function ISStopVehicle:new(character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.maxTime = -1
	return o
end

