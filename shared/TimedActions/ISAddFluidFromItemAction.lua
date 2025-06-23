--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddFluidFromItemAction = ISBaseTimedAction:derive("ISAddFluidFromItemAction")

function ISAddFluidFromItemAction:isValid()
    if isClient() and self.itemFrom then
        return true
    else
        return self.objectTo:canTransferFluidFrom(self.itemFrom:getFluidContainer()) and 
			--self.itemFrom:isWaterSource() and -- replaced this with the test above to enable all manner of fluids to be transferred - spurcival
			self.character:getInventory():contains(self.itemFrom) and
            self.objectTo:getObjectIndex() ~= -1 and
            self.objectTo:getFluidAmount() < self.objectTo:getFluidCapacity()
    end
end

function ISAddFluidFromItemAction:waitToStart()
	self.character:faceThisObject(self.objectTo)
	return self.character:shouldBeTurning()
end

function ISAddFluidFromItemAction:update()
	self.character:faceThisObject(self.objectTo)
	self.itemFrom:setJobDelta(self:getJobDelta())
	self.character:setMetabolicTarget(Metabolics.LightDomestic);

	if not isClient() then
		-- transfer per update
		local progressAmount = self.addUnits * self:getJobDelta();
		local sourceAmountTarget = self.itemFromStartAmount - progressAmount;
		local amountToTransfer = math.max(0, self.itemFrom:getFluidContainer():getAmount() - sourceAmountTarget);
		self.objectTo:transferFluidFrom(self.itemFrom:getFluidContainer(), amountToTransfer);
		self.itemFrom:syncItemFields();
	end
end

function ISAddFluidFromItemAction:start()
	self.itemFrom:setJobType(getText("IGUI_JobType_PourOut"))
	self.itemFrom:setJobDelta(0.0)

	self:setAnimVariable("PourType", self.itemFrom:getPourType());
	self:setActionAnim("fill_container_tap");
	self:setOverrideHandModels(self.itemFrom:getStaticModel(), nil)

	if instanceof(self.objectTo, "IsoFeedingTrough") then
		self.sound = self.character:playSound("AnimalFeederAddWater")
	else
		self.sound = self.character:playSound("PourWaterIntoObject")
	end

	self.character:reportEvent("EventTakeWater");
end

function ISAddFluidFromItemAction:stop()
	self:stopSound()
	self.itemFrom:setJobDelta(0.0)

	ISBaseTimedAction.stop(self)
end

function ISAddFluidFromItemAction:perform()
	self:stopSound()
	self.itemFrom:getContainer():setDrawDirty(true)
	self.itemFrom:setJobDelta(0.0)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISAddFluidFromItemAction:complete()
	if self.addUnits and self.addUnits > 0 then
		local sourceAmountTarget = self.itemFromStartAmount - self.addUnits;
		local amountToTransfer = math.max(0, self.itemFrom:getFluidContainer():getAmount() - sourceAmountTarget);
		self.objectTo:transferFluidFrom(self.itemFrom:getFluidContainer(), amountToTransfer);
		self.itemFrom:syncItemFields();
	end

	return true;
end

function ISAddFluidFromItemAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return math.max(6, self.addUnits) * 7;
end

function ISAddFluidFromItemAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISAddFluidFromItemAction:new(character, itemFrom, objectTo)
	local o = ISBaseTimedAction.new(self, character)
	o.itemFrom = itemFrom
	o.objectTo = objectTo

	o.itemFromStartAmount = o.itemFrom:getFluidContainer():getAmount()
	local destCapacity = math.max(0, o.objectTo:getFluidCapacity() - o.objectTo:getFluidAmount());
	o.addUnits = math.min(destCapacity, o.itemFromStartAmount)
	o.itemFromEndingAmount = o.itemFromStartAmount - o.addUnits

	o.maxTime = o:getDuration()
	return o
end    	
