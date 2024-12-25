--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISWashVehicle = ISBaseTimedAction:derive("ISWashVehicle")

-----

local function predicateHasWater(item)
    return item:getFluidContainer() and (item:getFluidContainer():contains(Fluid.Water) or item:getFluidContainer():contains(Fluid.TaintedWater)) and item:getFluidContainer():getAmount() >= 0.1
end

local ITEMS = ArrayList.new()

local function getWaterItems(character)
	local inventory = character:getInventory()
	ITEMS:clear()
	return inventory:getAllEvalRecurse(predicateHasWater, ITEMS)
end

local AREAS = {
	{ id = "Front", area = "Engine" },
	{ id = "Rear", area = "TruckBed" },
	{ id = "Left", area = "SeatLeft" },
	{ id = "Left", area = "SeatFrontLeft" },
	{ id = "Right", area = "SeatRight" },
	{ id = "Right", area = "SeatFrontRight" }
}

local function getWaterAmountForItems(items)
	local total = 0
	for i=1,items:size() do
		local item = items:get(i-1)
		total = total + item:getFluidContainer():getAmount()
	end
	return total
end

function ISWashVehicle.getWaterAmountForPlayer(character)
	local items = getWaterItems(character)
	return getWaterAmountForItems(items)
end

ISWashVehicle.BLOOD_PER_WATER = 5

function ISWashVehicle.getWaterAmountForArea(vehicle, id)
	local intensity = vehicle:getBloodIntensity(id)
	return round(intensity * 100 / ISWashVehicle.BLOOD_PER_WATER)
end

function ISWashVehicle.chooseArea(character, vehicle)
	local waterTotal = ISWashVehicle.getWaterAmountForPlayer(character)
	for _,area in ipairs(AREAS) do
		if vehicle:getScript():getAreaById(area.area) and vehicle:getBloodIntensity(area.id) > 0 then
			if waterTotal >= 1 then
				return area
			end
		end
	end
	return nil
end

function ISWashVehicle.hasBlood(vehicle)
	for _,area in ipairs(AREAS) do
		if vehicle:getScript():getAreaById(area.area) and (vehicle:getBloodIntensity(area.id) > 0) then
			return true
		end
	end
	return false
end

-----

function ISWashVehicle:isValid()
	return self.vehicle:isInArea(self.area, self.character)
end

function ISWashVehicle:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISWashVehicle:update()
    if isClient() then
        return
    end
    self:updateWashing()
end

function ISWashVehicle:updateWashing()
    if self.vehicle:getBloodIntensity(self.id) <= 0 then
        if isServer() then
            self.netAction:forceComplete()
        else
            self:forceComplete()
        end
        return
    end

    if self.character:isTimedActionInstant() then
        local waterAvailable = ISWashVehicle.getWaterAmountForPlayer(self.character)
        if waterAvailable < 0.1 then
            if not isServer() then
                self:forceStop()
            else
                self.netAction:forceComplete()
            end
            return
        end
        local waterUsed = math.ceil(self.vehicle:getBloodIntensity(self.id) * 100 / ISWashVehicle.BLOOD_PER_WATER)
        waterUsed = math.min(waterUsed, waterAvailable)
        local bloodRemoved = waterUsed * ISWashVehicle.BLOOD_PER_WATER
        if not isClient() then
            self:removeBlood(bloodRemoved, waterUsed)
        end
        -- Don't forceComplete(); there is a delay before the client command is processed (even in singleplayer).
        return
    end

    self.character:faceThisObject(self.vehicle)
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic)

    self.accumulator = self.accumulator + getGameTime():getMultiplier()
    local TICKS = 15
    if self.accumulator < TICKS then return end
    local bloodRemoved = math.floor(self.accumulator / (TICKS/3))

    self.waterAccumulator = self.waterAccumulator + bloodRemoved
    local waterUsed = math.floor(self.waterAccumulator / ISWashVehicle.BLOOD_PER_WATER)
    if waterUsed < 1 then
        return
    end

    local waterAvailable = ISWashVehicle.getWaterAmountForPlayer(self.character)
    if waterAvailable < 1 then
        if not isServer() then
            self:forceStop()
        else
            self.netAction:forceComplete()
        end
        return
    end

    waterUsed = math.min(waterUsed, waterAvailable)
    self.waterAccumulator = math.max(self.waterAccumulator - waterUsed * ISWashVehicle.BLOOD_PER_WATER, 0.0)

    bloodRemoved = waterUsed * ISWashVehicle.BLOOD_PER_WATER
    self.accumulator = math.max(self.accumulator - bloodRemoved * TICKS, 0.0)
    self:removeBlood(bloodRemoved, waterUsed)
end

function ISWashVehicle:removeBlood(bloodRemoved, waterUsed)
	local intensity = self.vehicle:getBloodIntensity(self.id) - bloodRemoved * 0.01
	local intensity2 = round(intensity * 100)
	if intensity2 == self.amountSent then
		return
	end

	self:useWater(waterUsed)

    if self.vehicle then
        self.vehicle:setBloodIntensity(self.id, intensity)
    else
        print('no such vehicle id=',self.vehicle)
    end
	self.amountSent = intensity2
end

function ISWashVehicle:useWater(units)
	local waterItems = getWaterItems(self.character)
	for i=1,waterItems:size() do
		local item = waterItems:get(i-1)
		local used = math.min(units, item:getFluidContainer():getAmount())
		item:getFluidContainer():adjustAmount(item:getFluidContainer():getAmount() - used)
		sendItemStats(item) --not sure this line is needed anymore
		units = units - used
	end
end

function ISWashVehicle:start()
	self:setActionAnim("VehicleWash")
	self:setOverrideHandModels(nil, nil)
	self.accumulator = 0.0
	self.waterAccumulator = 0.0
	self.sound = self.character:playSound("CleanBloodVehicle")
end

function ISWashVehicle:stop()
	self.character:stopOrTriggerSound(self.sound)
	ISBaseTimedAction.stop(self)
end

function ISWashVehicle:animEvent(event, parameter)
	if isServer() then
		if event == 'WashUpdate' then
			self:updateWashing()
		end
	end
end

function ISWashVehicle:serverStart()
    self.accumulator = 0.0
    self.waterAccumulator = 0.0
	emulateAnimEvent(self.netAction, 100, "WashUpdate", nil)
end

function ISWashVehicle:perform()
	self.character:stopOrTriggerSound(self.sound)
    local area = ISWashVehicle.chooseArea(self.character, self.vehicle)
    if area then
        -- Add in reverse order
        ISTimedActionQueue.addAfter(self, ISWashVehicle:new(self.character, self.vehicle, area.id, area.area))
        ISTimedActionQueue.addAfter(self, ISPathFindAction:pathToVehicleArea(self.character, self.vehicle, area.area))
    end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISWashVehicle:complete()
    if not isServer() then
        return true
    end
    local waterAvailable = ISWashVehicle.getWaterAmountForPlayer(self.character)
    local waterUsed = math.ceil(self.vehicle:getBloodIntensity(self.id) * 100 / ISWashVehicle.BLOOD_PER_WATER)
    waterUsed = math.min(waterUsed, waterAvailable)
    if waterUsed < 1 and self.vehicle:getBloodIntensity(self.id) > 0 then
        return false
    end
    local bloodRemoved = waterUsed * ISWashVehicle.BLOOD_PER_WATER
    self:removeBlood(bloodRemoved, waterUsed)
	return true
end

function ISWashVehicle:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
	return -1
end

function ISWashVehicle:new(character, vehicle, id, area)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = vehicle
	o.id = id
	o.area = area
    o.stopOnWalk = false
    o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

