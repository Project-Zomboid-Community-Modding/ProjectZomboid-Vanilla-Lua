require "TimedActions/ISBaseTimedAction"

ISTakeFuel = ISBaseTimedAction:derive("ISTakeFuel");

function ISTakeFuel:isValid()
	local pumpCurrent = self.fuelStation:getPipedFuelAmount()
	return pumpCurrent > 0 and not self.character:hasFullInventory()
end

function ISTakeFuel:waitToStart()
	self.character:faceLocation(self.square:getX(), self.square:getY())
	return self.character:shouldBeTurning()
end

function ISTakeFuel:update()
	self.character:faceLocation(self.square:getX(), self.square:getY());
    if not isClient() then
	    self.petrolCan:setJobDelta(self:getJobDelta());
	    self:updateUse(self:getJobDelta());
	end
end

function ISTakeFuel:updateUse(delta)
    local actionCurrent = math.floor(self.amount * delta + 0.001 + self.itemStart);
	local itemCurrent = self.petrolCan:getFluidContainer():getAmount();
	if actionCurrent > itemCurrent then
        local pumpCurrent = tonumber(self.fuelStation:getPipedFuelAmount())
		self.fuelStation:setPipedFuelAmount(pumpCurrent - (actionCurrent - itemCurrent))
		self.petrolCan:getFluidContainer():addFluid(Fluid.Petrol, actionCurrent - itemCurrent);
        self.petrolCan:syncItemFields();
        sendItemStats(self.petrolCan)
	end
    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISTakeFuel:start()
	self.petrolCan:setJobType(getText("ContextMenu_TakeGasFromPump"))
	self.petrolCan:setJobDelta(0.0)

	self:setOverrideHandModels(nil, self.petrolCan:getStaticModel())
	self:setActionAnim("TakeGasFromPump")

	self.sound = self.character:playSound("CanisterAddFuelFromGasPump")
end

function ISTakeFuel:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.petrolCan:setJobDelta(0.0)
    ISBaseTimedAction.stop(self);
end

function ISTakeFuel:perform()
	self.character:stopOrTriggerSound(self.sound)
	self.petrolCan:setJobDelta(0.0)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISTakeFuel:complete()
    if self.petrolCan == nil then
        return false
    end
	local itemCurrent = self.petrolCan:getFluidContainer():getAmount();
	if self.itemTarget > itemCurrent then
		self.petrolCan:getFluidContainer():addFluid(Fluid.Petrol, self.itemTarget - itemCurrent);
		syncItemFields(self.character, self.petrolCan);
		local pumpCurrent = self.fuelStation:getPipedFuelAmount();
		self.fuelStation:setPipedFuelAmount(pumpCurrent + (self.itemTarget - itemCurrent));
	end

	return true;
end

function ISTakeFuel:serverStart()
    emulateAnimEvent(self.netAction, 100, "takeFuel", nil);
end

function ISTakeFuel:animEvent(event, parameter)
    if isServer() then
        if event == "takeFuel" then
		    self:updateUse(self.netAction:getProgress());
        end
    end
end

function ISTakeFuel:getDuration()
    if self.petrolCan == nil then
        return 0
    end
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return self.amount * 50
end

function ISTakeFuel:new(character, fuelStation, petrolCan)
	local o = ISBaseTimedAction.new(self, character)
	o.fuelStation = fuelStation;
	o.square = fuelStation:getSquare();
	o.petrolCan = petrolCan;
	if petrolCan ~= nil then
        local freeCapacity = petrolCan:getFluidContainer():getFreeCapacity();
        local pumpCurrent = tonumber(o.fuelStation:getPipedFuelAmount());
        local freeInventoryCapacity = character:getFreeInventoryCapacity()/ZomboidGlobals.EquippedOrWornEncumbranceMultiplier;
        o.amount = math.min(math.min(pumpCurrent, freeCapacity), freeInventoryCapacity);
        o.itemStart = petrolCan:getFluidContainer():getAmount();
        o.itemTarget = o.itemStart + o.amount;
    end
    o.maxTime = o:getDuration();
	return o;
end
