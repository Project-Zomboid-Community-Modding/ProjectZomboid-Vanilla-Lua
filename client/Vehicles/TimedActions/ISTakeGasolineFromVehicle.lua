--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeGasolineFromVehicle = ISBaseTimedAction:derive("ISTakeGasolineFromVehicle")

local function predicateEmptyPetrol(item)
	return item:hasTag("EmptyPetrol") or item:getType() == "EmptyPetrolCan"
end

function ISTakeGasolineFromVehicle:isValid()
--	return self.vehicle:isInArea(self.part:getArea(), self.character)
	return true;
end

function ISTakeGasolineFromVehicle:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISTakeGasolineFromVehicle:update()
	self.character:faceThisObject(self.vehicle)
	self.item:setJobDelta(self:getJobDelta())
	self.item:setJobType(getText("ContextMenu_VehicleSiphonGas"))
	local litres = self.tankStart + (self.tankTarget - self.tankStart) * self:getJobDelta()
	litres = math.ceil(litres)
	if litres ~= self.amountSent then
		local args = { vehicle = self.vehicle:getId(), part = self.part:getId(), amount = litres }
		sendClientCommand(self.character, 'vehicle', 'setContainerContentAmount', args)
		self.amountSent = litres
	end
	local litresTaken = self.tankStart - litres
	local usedDelta = self.itemStart + litresTaken / self.JerryCanLitres
	self.item:setUsedDelta(usedDelta)

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISTakeGasolineFromVehicle:start()
	local unitsPerCan = 0
	if predicateEmptyPetrol(self.item) then
		local wasPrimary = self.character:getPrimaryHandItem() == self.item
		local wasSecondary = self.character:getSecondaryHandItem() == self.item
		self.character:getInventory():DoRemoveItem(self.item)
		local newType = self.item:getReplaceType("PetrolSource") or "Base.PetrolCan"
		self.item = self.character:getInventory():AddItem(newType)
		self.item:setUsedDelta(0)
		if wasPrimary then
			self.character:setPrimaryHandItem(self.item)
		end
		if wasSecondary then
			self.character:setSecondaryHandItem(self.item)
		end
	end
	
	-- adjust for units in container and Vehicles.JerryCanLitres
	local unitsPerCan = math.floor(1/self.item:getUseDelta())
	self.JerryCanLitres = Vehicles.JerryCanLitres * (unitsPerCan/8)
	
	self.tankStart = self.part:getContainerContentAmount()
	self.itemStart = self.item:getUsedDelta()
	local add = (1.0 - self.itemStart) * self.JerryCanLitres
	local take = math.min(add, self.tankStart)
	self.tankTarget = self.tankStart - take
	self.itemTarget = self.itemStart + take / self.JerryCanLitres
	self.amountSent = math.ceil(self.tankStart)

	self.action:setTime(take * 50)

	self:setActionAnim("TakeGasFromVehicle")
	self:setOverrideHandModels(nil, self.item:getStaticModel())

	self.sound = self.character:playSound("CanisterAddFuelSiphon")
end

function ISTakeGasolineFromVehicle:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.item:setJobDelta(0)
	ISBaseTimedAction.stop(self)
end

function ISTakeGasolineFromVehicle:perform()
	self.character:stopOrTriggerSound(self.sound)
	self.item:setJobDelta(0)
	self.item:setUsedDelta(self.itemTarget)
	local args = { vehicle = self.vehicle:getId(), part = self.part:getId(), amount = self.tankTarget }
	sendClientCommand(self.character, 'vehicle', 'setContainerContentAmount', args)
--	print('take fluid level=' .. self.part:getContainerContentAmount() .. ' usedDelta=' .. self.item:getUsedDelta())
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISTakeGasolineFromVehicle:new(character, part, item, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.vehicle = part:getVehicle()
	o.part = part
	o.item = item
	o.maxTime = time
	return o
end

