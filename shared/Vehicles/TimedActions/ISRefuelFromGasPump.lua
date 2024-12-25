--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRefuelFromGasPump = ISBaseTimedAction:derive("ISRefuelFromGasPump")

function ISRefuelFromGasPump:isValid()
	return self.vehicle:isInArea(self.part:getArea(), self.character)
end

function ISRefuelFromGasPump:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISRefuelFromGasPump:update()
	local litres = self.tankStart + (self.tankTarget - self.tankStart) * self:getJobDelta()
	litres = math.floor(litres)
	if litres ~= self.amountSent then
        if self.vehicle then
            if not self.part then
                print('no such part ',self.part)
                return
            end
            self.part:setContainerContentAmount(litres)
            self.vehicle:transmitPartModData(self.part)
        else
            print('no such vehicle id=', self.vehicle)
        end
		self.amountSent = litres
	end
--[[
	if isClient() then
		if math.floor(litres) ~= self.amountSent then
			local args = { vehicle = self.vehicle:getId(), part = self.part:getId(), amount = litres }
			sendClientCommand(self.character, 'vehicle', 'setContainerContentAmount', args)
			self.amountSent = math.floor(litres)
		end
	else
		self.part:setContainerContentAmount(litres)
	end
--]]
	local pumpUnits = self.pumpStart + (self.pumpTarget - self.pumpStart) * self:getJobDelta()
	pumpUnits = math.ceil(pumpUnits)
	self.fuelStation:setPipedFuelAmount(pumpUnits);

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISRefuelFromGasPump:start()
	self:setActionAnim("fill_container_tap")
	self:setOverrideHandModels(nil, nil)

	self.character:reportEvent("EventTakeWater");

	self.sound = self.character:playSound("VehicleAddFuelFromGasPump")
end

function ISRefuelFromGasPump:stop()
	self.character:stopOrTriggerSound(self.sound)
	ISBaseTimedAction.stop(self)
end

function ISRefuelFromGasPump:serverStop()
    local pumpUnits = self.pumpStart + (self.pumpTarget - self.pumpStart) * self.netAction:getProgress()
    self.fuelStation:setPipedFuelAmount(math.ceil(pumpUnits));
    local litres = self.tankStart + (self.tankTarget - self.tankStart) * self.netAction:getProgress()
    self.part:setContainerContentAmount(math.floor(litres))
    self.vehicle:transmitPartModData(self.part)
end

function ISRefuelFromGasPump:perform()
	self.character:stopOrTriggerSound(self.sound)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISRefuelFromGasPump:complete()
    if self.vehicle then
        if not self.part then
            print('no such part ',self.part)
            return false
        end
        self.part:setContainerContentAmount(self.tankTarget)
        self.vehicle:transmitPartModData(self.part)
    else
        print('no such vehicle id=', self.vehicle)
    end
	return true
end

function ISRefuelFromGasPump:getDuration()
    self.tankStart = self.part:getContainerContentAmount()
	-- Pumps start with 100 units of fuel.  8 pump units = 1 PetrolCan according to ISTakeFuel.
	self.pumpStart = self.fuelStation:getPipedFuelAmount();
	local pumpLitresAvail = self.pumpStart * (Vehicles.JerryCanLitres / 8)
	local tankLitresFree = self.part:getContainerCapacity() - self.tankStart
	local takeLitres = math.min(tankLitresFree, pumpLitresAvail)
	self.tankTarget = self.tankStart + takeLitres
	self.pumpTarget = self.pumpStart - takeLitres / (Vehicles.JerryCanLitres / 8)
	self.amountSent = self.tankStart

	return takeLitres * 50
end

function ISRefuelFromGasPump:new(character, part, fuelStation)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.fuelStation = fuelStation;
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

