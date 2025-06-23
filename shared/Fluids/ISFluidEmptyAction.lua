--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFluidEmptyAction = ISBaseTimedAction:derive("ISFluidEmptyAction")

function ISFluidEmptyAction:isValid()
    if self.container then
        return ISFluidUtil.validateContainer(self.container) and (not self.container:getFluidContainer():isEmpty()) and (self.container:getFluidContainer():canPlayerEmpty());
    end
end

function ISFluidEmptyAction:update()
	local isoObj = nil;
	if instanceof(self.container:getOwner(), "IsoObject") then
		isoObj = self.container:getOwner();
	end

	if isoObj then
		self.character:faceThisObject(isoObj);
	end
	
	if self.amount < 1.0 then
		self.character:setMetabolicTarget(Metabolics.LightDomestic)
	elseif self.amount < 5.0 then
		self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
	else
		self.character:setMetabolicTarget(Metabolics.MediumWork)
	end
	
	-- do partial empty
	if not isClient() then
		if self.container:getFluidContainer() then
			local targetFillAmount = self.amount * (1 - self:getJobDelta())
			self.container:getFluidContainer():adjustAmount(targetFillAmount);
			self.container:sync();
		end
	end
end

function ISFluidEmptyAction:start()
	self:setActionAnim(CharacterActionAnims.Pour)
	local item;
	if ISFluidUtil.validateContainer(self.container) and instanceof(self.container:getOwner(), "InventoryItem") then
		item = self.container:getOwner();
		item:setJobType(getText("IGUI_JobType_PourOut"));
	    item:setJobDelta(0.0);
		self:setActionAnim(CharacterActionAnims.Pour);
		self:setAnimVariable("PourType", item:getPourType());
		self.sound = self.character:playSound(item:getPourLiquidOnGroundSound())
	elseif instanceof(self.containerObject:getOwner(), "IsoFeedingTrough") then
		self.sound = self.character:playSound("AnimalFeederEmptyWater")
	end
	self:setOverrideHandModels(item, nil);
end

function ISFluidEmptyAction:stop()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
	
	ISBaseTimedAction.stop(self)
end

function ISFluidEmptyAction:perform()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISFluidEmptyAction:complete()
	if self.container:getFluidResource() then
		self.container:getFluidResource():clear();
	else
		self.container:getFluidContainer():Empty();
	end

	self.container:sync();
	return true
end

function ISFluidEmptyAction:new(character, containerObject)
	local o = ISBaseTimedAction.new(self, character)
	--o.containerOwner = containerOwner;
	o.containerObject = containerObject;
	o.container = ISFluidContainer:new(containerObject); --o.containerOwner:getComponent(ComponentType.FluidContainer));

	if not ISFluidUtil.validateContainer(o.container) then
		print("ISFluidEmptyAction not a valid (ISFluidContainer) container?")
	end

    o.amount = o.container:getFluidContainer():getAmount();
	o.maxTime = o.amount * ISFluidUtil.getTransferActionTimePerLiter();
    if o.maxTime < ISFluidUtil.getMinTransferActionTime() then
        o.maxTime = ISFluidUtil.getMinTransferActionTime();
    end
	if o.character:isTimedActionInstant() then o.maxTime = 1; end
	return o
end