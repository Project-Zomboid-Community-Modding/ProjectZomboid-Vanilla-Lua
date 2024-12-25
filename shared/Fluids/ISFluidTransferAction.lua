--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFluidTransferAction = ISBaseTimedAction:derive("ISFluidTransferAction")

function ISFluidTransferAction:isValid()
    if ISFluidUtil.validateContainer(self.source) and ISFluidUtil.validateContainer(self.target) then
        return FluidContainer.CanTransfer(self.source:getFluidContainer(), self.target:getFluidContainer());
    end
	return false;
end

function ISFluidTransferAction:update()
	local isoObj = nil;
	if instanceof(self.source:getOwner(), "IsoObject") then
		isoObj = self.sourceOwner;
	elseif instanceof(self.target:getOwner(), "IsoObject") then
		isoObj = self.targetOwner;
	end

	if isoObj then
		self.character:faceThisObject(isoObj);
	end

	if self.amount<1.0 then
		self.character:setMetabolicTarget(Metabolics.LightDomestic)
	elseif self.amount < 5.0 then
		self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
	else
		self.character:setMetabolicTarget(Metabolics.MediumWork)
	end
end

function ISFluidTransferAction:start()
	self:setActionAnim(CharacterActionAnims.Pour)
	local itemA, itemB;
	if ISFluidUtil.validateContainer(self.source) and instanceof(self.source:getOwner(), "InventoryItem") then
		itemA = self.source:getOwner();
	end
	if ISFluidUtil.validateContainer(self.target) and instanceof(self.target:getOwner(), "InventoryItem") then
		itemB = self.target:getOwner();
		if itemB:getItemHeat() > 1.0 then
			itemB:setItemHeat(1.0);
		end
	end
	self:setOverrideHandModels(itemA, itemB);
	self.sound = self.character:playSound("TransferLiquid");
end

function ISFluidTransferAction:stop()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
	ISBaseTimedAction.stop(self)
end

function ISFluidTransferAction:complete()
	FluidContainer.Transfer(self.source:getFluidContainer(), self.target:getFluidContainer(), self.amount);

	self.source:sync()
	self.target:sync()

	return true
end

function ISFluidTransferAction:perform()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
	--todo sync mp, may be handled differently depending on if its: InventoryItem, IsoObject or ResourceFluid
	--if isClient() then
	--end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISFluidTransferAction:new(character, sourceContainer, sourceFluidObject, targetContainer, targetFluidObject, amount)
	local o = ISBaseTimedAction.new(self, character)

	-- note: changed source and target back to using ISFluidContainer instances.
	-- the commented out code below fails when source or target is ResourceFluid
	-- as ResourceFluid is not a component.
	--o.source = ISFluidContainer:new(o.sourceOwner:getComponent(ComponentType.FluidContainer));
	--o.target = ISFluidContainer:new(o.targetOwner:getComponent(ComponentType.FluidContainer));

	-- we need these two objects because we want send them to server
	o.sourceFluidObject = sourceFluidObject;
	o.targetFluidObject = targetFluidObject;

	if isServer() then
		o.source = ISFluidContainer:new(sourceFluidObject);
		o.target = ISFluidContainer:new(targetFluidObject);
	else
		o.source = sourceContainer;
		o.target = targetContainer;
	end

    if not ISFluidUtil.validateContainer(o.source) then
        print("ISFluidTransferAction source not a valid (ISFluidContainer) container?")
    end
    if not ISFluidUtil.validateContainer(o.target) then
        print("ISFluidTransferAction target not a valid (ISFluidContainer) container?")
    end

	o.sourceOwner = o.source:getOwner();
	o.targetOwner = o.target:getOwner();

	--[[
	o.sourceFluidContainer = _source:getFluidContainer();
	o.sourceResource = _source:getFluidResource();
	o.sourceOwner = _source:getOwner();

    o.targetFluidContainer = _target:getFluidContainer();
	o.targetResource = _target:getFluidResource();
    o.targetOwner = _target:getOwner();
	--]]

	o.amount = amount;
	o.maxTime = amount * ISFluidUtil.getTransferActionTimePerLiter();
    if o.maxTime < ISFluidUtil.getMinTransferActionTime() then
        o.maxTime = ISFluidUtil.getMinTransferActionTime();
    end
	if o.character:isTimedActionInstant() then o.maxTime = 1; end
	return o
end