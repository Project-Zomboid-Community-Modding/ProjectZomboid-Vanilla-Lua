--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeFuel = ISBaseTimedAction:derive("ISTakeFuel");

function ISTakeFuel:isValid()
	local pumpCurrent = self.fuelStation:getPipedFuelAmount()
	return pumpCurrent > 0
end

function ISTakeFuel:waitToStart()
	self.character:faceLocation(self.square:getX(), self.square:getY())
	return self.character:shouldBeTurning()
end

function ISTakeFuel:update()
	self.petrolCan:setJobDelta(self:getJobDelta())
	self.character:faceLocation(self.square:getX(), self.square:getY())
	if not isClient() then
		local actionCurrent = math.floor(self.amount * self:getJobDelta() + 0.001);
		local itemCurrent = self.petrolCan:getFluidContainer():getAmount();
	-- 	local itemCurrent = math.floor(self.petrolCan:getCurrentUsesFloat() / self.petrolCan:getUseDelta() + 0.001)
		if actionCurrent > itemCurrent then
			-- FIXME: sync in multiplayer
			local pumpCurrent = tonumber(self.fuelStation:getPipedFuelAmount())
			self.fuelStation:setPipedFuelAmount(pumpCurrent - (actionCurrent - itemCurrent))

			self.petrolCan:getFluidContainer():addFluid(Fluid.Petrol, actionCurrent - itemCurrent);
		end
	end
    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISTakeFuel:start()
	if not isClient() then
		self:init()
	end
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

end

function ISTakeFuel:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return self.amount * 50
end

function ISTakeFuel:init()

end

function ISTakeFuel:new(character, fuelStation, petrolCan)
	local o = ISBaseTimedAction.new(self, character)
	o.fuelStation = fuelStation;
	o.square = fuelStation:getSquare();
	o.petrolCan = petrolCan;
	local freeCapacity = petrolCan:getFluidContainer():getFreeCapacity();
	local pumpCurrent = tonumber(o.fuelStation:getPipedFuelAmount());
	o.amount = math.min(pumpCurrent, freeCapacity);
	o.itemStart = petrolCan:getFluidContainer():getAmount();
	o.itemTarget = o.itemStart + o.amount;
	o.maxTime = o:getDuration();
	return o;
end