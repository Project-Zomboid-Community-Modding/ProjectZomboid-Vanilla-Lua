--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddGasolineToVehicle = ISBaseTimedAction:derive("ISAddGasolineToVehicle")

local function predicateEmptyPetrol(item)
	return item:getFluidContainer() and item:getFluidContainer():isEmpty()
end

function ISAddGasolineToVehicle:isValid()
--	return self.vehicle:isInArea(self.part:getArea(), self.character)
	return true;
end

function ISAddGasolineToVehicle:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISAddGasolineToVehicle:update()
    local progress
    if isServer() then
        progress = self.netAction:getProgress()
    else
        progress = self:getJobDelta()
    end

    if not isServer() then
        self.character:faceThisObject(self.vehicle)
        self.item:setJobDelta(self:getJobDelta())
        self.item:setJobType(getText("ContextMenu_VehicleAddGas"))
    end

    if not isClient() then
	    local litres = self.tankStart + (self.tankTarget - self.tankStart) * progress
	    litres = math.floor(litres)
	    if litres ~= self.amountSent then
            if self.vehicle then
                if not self.part then
                    print('no such part ', self.part)
                    return
                end
                self.part:setContainerContentAmount(litres)
                self.vehicle:transmitPartModData(self.part)
            else
                print('no such vehicle id=', self.vehicle)
            end
	    	self.amountSent = litres
	    end
	    local litresTaken = litres - self.tankStart
	    if not predicateEmptyPetrol(self.item) then
            self.fluidCont:adjustAmount(self.itemStart - litresTaken)
            self.item:syncItemFields();
        end
    end

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISAddGasolineToVehicle:animEvent(event, parameter)
    if isServer() then
        if event == "update" then
            self:update();
        end
    end
end

function ISAddGasolineToVehicle:serverStart()
    local period = 1000; -- basically 50 * 20
    emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISAddGasolineToVehicle:start()
	self:setActionAnim("refuelgascan")
	self:setOverrideHandModels(self.item:getStaticModel(), nil)
	self.sound = self.character:playSound("VehicleAddFuelFromCanister")
end

function ISAddGasolineToVehicle:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.item:setJobDelta(0)
	ISBaseTimedAction.stop(self)
end

function ISAddGasolineToVehicle:perform()
	self.character:stopOrTriggerSound(self.sound)
	self.item:setJobDelta(0)
    local item = self:nextItem()
    if item then
        self:runAgain(item)
    end

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISAddGasolineToVehicle:runAgain(intoItem)
    if not intoItem then return end
    -- add the actions after self, in the reverse order
    ISTimedActionQueue.addAfter(self, ISAddGasolineToVehicle:new(self.character, self.part, intoItem, self.otherItems))
    ISTimedActionQueue.addAfter(self, ISEquipWeaponAction:new(self.character, intoItem, 50, true, false));
    if (intoItem:getContainer() ~= self.character:getInventory()) then
        ISTimedActionQueue.addAfter(self, ISInventoryTransferAction:new(self.character, intoItem, intoItem:getContainer(), self.character:getInventory()))
    end
end

function ISAddGasolineToVehicle:nextItem()
    if not self.otherItems then return nil end
    while #self.otherItems > 0 do
        local item = table.remove(self.otherItems, 1)
        if (item and item:getFluidContainer():getAmount() > 0) and self.character:getInventory():contains(item, true) then
            return item
        end
    end
    return nil
end

function ISAddGasolineToVehicle:complete()
	self.fluidCont:adjustAmount(self.itemTarget)
    if self.vehicle then
        if not self.part then
            print('no such part ', self.part)
            return false
        end
        self.part:setContainerContentAmount(self.tankTarget)
        self.vehicle:transmitPartModData(self.part)
    else
        print('no such vehicle id=', self.vehicle)
    end

    self.item:syncItemFields();
	return true
end

function ISAddGasolineToVehicle:serverStop()
    --self.fluidCont:adjustAmount(self.itemStart + self.netAction:getProgress()*(self.itemTarget - self.itemStart));
    --self:setContainerContentAmount(self.tankStart + self.netAction:getProgress()*(self.tankTarget - self.tankStart));
    self.item:syncItemFields();
    self.vehicle:transmitPartModData(self.part)
end

function ISAddGasolineToVehicle:getDuration()
    self.tankStart = self.part:getContainerContentAmount();
    self.itemStart = self.fluidCont:getAmount();
    local add = self.part:getContainerCapacity() - self.tankStart;
    local take = math.min(add, self.itemStart);
    self.tankTarget = self.tankStart + take;
    self.itemTarget = self.itemStart - take;
    self.amountSent = self.tankStart
    return take * 50
end

function ISAddGasolineToVehicle:new(character, part, item, otherItems)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.item = item
    o.otherItems = otherItems
	o.fluidCont = o.item:getFluidContainer();
	o.maxTime = o:getDuration();
	return o
end

