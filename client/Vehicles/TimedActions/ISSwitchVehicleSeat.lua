--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISSwitchVehicleSeat = ISBaseTimedAction:derive("ISSwitchVehicleSeat")

function ISSwitchVehicleSeat:isValid()
	local vehicle = self.character:getVehicle()
	--print(vehicle, vehicle:getSeat(self.character), vehicle:isSeatOccupied(self.seatTo), self.seatFrom, self.character:getVehicle():getSeat(self.character))
	return vehicle ~= nil and
		vehicle:getSeat(self.character) ~= -1 and
		not vehicle:isSeatOccupied(self.seatTo) and
		self.seatFrom == self.character:getVehicle():getSeat(self.character)
end

function ISSwitchVehicleSeat:update()
	local vehicle = self.character:getVehicle()
	local seatFrom = vehicle:getSeat(self.character)
	vehicle:playSwitchSeatAnim(seatFrom, self.seatTo)
	if self.character:GetVariable("SwitchSeatAnimationFinished") == "true" then
		self.character:ClearVariable("SwitchSeatAnimationFinished")
		self.character:ClearVariable("bSwitchingSeat")
		self:forceComplete()
	end
end

function ISSwitchVehicleSeat:start()
	local vehicle = self.character:getVehicle()
	local seat = vehicle:getSeat(self.character)
--[[
	if vehicle:isDriver(self.character) and vehicle:isEngineRunning() then
		vehicle:shutOff()
	end
--]]
	self.character:SetVariable("bSwitchingSeat", "true")
	local sound = vehicle:getSwitchSeatSound(seat, self.seatTo)
	if sound then
		vehicle:playSound(sound)
	end
end

function ISSwitchVehicleSeat:stop()
	self.character:ClearVariable("SwitchSeatAnimationFinished")
	self.character:ClearVariable("bSwitchingSeat")
	local vehicle = self.character:getVehicle()
	if vehicle then
		local seat = vehicle:getSeat(self.character)
		vehicle:playPassengerAnim(seat, "idle")
	end
	ISBaseTimedAction.stop(self)
end

function ISSwitchVehicleSeat:perform()
	local vehicle = self.character:getVehicle()
	local seatFrom = vehicle:getSeat(self.character)
	vehicle:switchSeat(self.character, self.seatTo)
	sendSwitchSeat(vehicle, self.character, seatFrom, self.seatTo)
	vehicle:playPassengerAnim(self.seatTo, "idle")
	triggerEvent("OnSwitchVehicleSeat", self.character)
	-- needed to remove from queue / start next.
	local pdata = getPlayerData(self.character:getPlayerNum());
	if pdata ~= nil then
		pdata.playerInventory:refreshBackpacks();
		pdata.lootInventory:refreshBackpacks();
	end
	if not vehicle:getDriver() then vehicle:onHornStop() end
	ISBaseTimedAction.perform(self)
end

function ISSwitchVehicleSeat:new(character, seatTo, seatFrom)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.seatTo = seatTo
	local veh = character:getVehicle()
	if seatFrom == nil and veh ~= nil then
		o.seatFrom = veh:getSeat(character)
	else
		o.seatFrom = seatFrom
	end
	o.maxTime = -1
	return o
end

