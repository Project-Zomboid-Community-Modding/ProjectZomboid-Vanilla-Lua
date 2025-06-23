--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISEnterVehicle = ISBaseTimedAction:derive("ISEnterVehicle")

function ISEnterVehicle:isValid()
	if self.started then
		return self.vehicle:getCharacter(self.seat) == self.character
	end
	return self.character:getVehicle() == nil and
		not self.vehicle:isSeatOccupied(self.seat)
end

function ISEnterVehicle:update()
	self.vehicle:playPassengerAnim(self.seat, "enter")
	if self.character:GetVariable("EnterAnimationFinished") == "true" then
		self.character:ClearVariable("EnterAnimationFinished")
		self.character:ClearVariable("bEnteringVehicle")
		self:forceComplete()
	end
end

function ISEnterVehicle:start()
	if not isServer() then
		local playerNum = self.character:getPlayerNum()
		getCell():setDrag(nil, playerNum)
		local contextMenu = getPlayerContextMenu(playerNum)
		if contextMenu and contextMenu:isAnyVisible() then
			contextMenu:hideAndChildren()
		end
	end
	self.action:setBlockMovementEtc(true) -- ignore 'E' while entering
	self.vehicle:enter(self.seat, self.character)
	self.vehicle:playPassengerSound(self.seat, "enter")
	self.character:SetVariable("bEnteringVehicle", "true")
	self.character:triggerMusicIntensityEvent("VehicleEnter")
	self.started = true
	local heavyItem = (self.character:getPrimaryHandItem() and self.character:getPrimaryHandItem():hasTag("HeavyItem")) or (self.character:getSecondaryHandItem() and self.character:getSecondaryHandItem():hasTag("HeavyItem"))
    if heavyItem then forceDropHeavyItems(self.character) end
end

function ISEnterVehicle:stop()
	self.character:ClearVariable("EnterAnimationFinished")
	self.character:ClearVariable("bEnteringVehicle")
	self.vehicle:exit(self.character)
    ISBaseTimedAction.stop(self)
end

function ISEnterVehicle:perform()
	self.vehicle:setCharacterPosition(self.character, self.seat, "inside")
	self.vehicle:transmitCharacterPosition(self.seat, "inside")
	self.vehicle:playPassengerAnim(self.seat, "idle")
--	if self.vehicle:isDriver(self.character) and self.vehicle:isEngineWorking() then
--		self.vehicle:startEngine()
--	end
	triggerEvent("OnEnterVehicle", self.character)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
	--ISBaseTimedAction.stop(self)
end

function ISEnterVehicle:getExtraLogData()
	if self.vehicle then
		return {
			self.vehicle:getScript():getName(),
		};
	end;
end

function ISEnterVehicle:new(character, vehicle, seat)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.stopOnWalk = false
	o.stopOnRun = false
	o.character = character
	o.vehicle = vehicle
	o.seat = seat
	o.maxTime = -1
	o.started = false
	o.ignoreHandsWounds = true;
	return o
end

