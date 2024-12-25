--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddWaterFromItemAction = ISBaseTimedAction:derive("ISAddWaterFromItemAction")

function ISAddWaterFromItemAction:isValid()
    if isClient() and self.itemFrom then
        return true
    else
        return self.itemFrom:isWaterSource() and self.character:getInventory():contains(self.itemFrom) and
            self.objectTo:getObjectIndex() ~= -1 and
            self.objectTo:getWaterAmount() < self.objectTo:getWaterMax()
    end
end

function ISAddWaterFromItemAction:waitToStart()
	self.character:faceThisObject(self.objectTo)
	return self.character:shouldBeTurning()
end

function ISAddWaterFromItemAction:update()
	self.character:faceThisObject(self.objectTo)
	self.itemFrom:setJobDelta(self:getJobDelta())
	local unitsSoFar = math.floor(self.addUnits * self:getJobDelta())
	if self.itemFrom:isWaterSource() then
		self.itemFrom:setUsedDelta(self.itemFromStartDelta - unitsSoFar * self.itemFrom:getUseDelta())
	end

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISAddWaterFromItemAction:start()
	self.itemFrom:setJobType(getText("IGUI_JobType_PourOut"))
	self.itemFrom:setJobDelta(0.0)

	self:setAnimVariable("PourType", self.itemFrom:getPourType());
	self:setActionAnim("fill_container_tap");
	self:setOverrideHandModels(self.itemFrom:getStaticModel(), nil)

	self.sound = self.character:playSound("PourWaterIntoObject")

	self.character:reportEvent("EventTakeWater");
end

function ISAddWaterFromItemAction:stop()
	self:stopSound()
	self.itemFrom:setJobDelta(0.0)
	-- Possibly start() wasn't called yet (because isValid() returned false)
	if self.addUnits and self.addUnits > 0 then
		local unitsSoFar = math.floor(self.addUnits * self:getJobDelta())
		self.itemFrom:setUsedDelta(self.itemFromStartDelta - unitsSoFar * self.itemFrom:getUseDelta())
		if self.itemFrom:getCurrentUsesFloat() < 0.0001 then
			self.itemFrom:Use()
		end
		self.objectTo:setWaterAmount(self.objectTo:getWaterAmount() + unitsSoFar)
		if self.itemFrom:isTaintedWater() then
			self.objectTo:setTaintedWater(true)
		end
		self.objectTo:transmitModData()
	end
	ISBaseTimedAction.stop(self)
end

function ISAddWaterFromItemAction:perform()
	self:stopSound()
	self.itemFrom:getContainer():setDrawDirty(true)
	self.itemFrom:setJobDelta(0.0)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISAddWaterFromItemAction:serverStop()
	self.addUnits = self.netAction:getProgress() * self.addUnits
	self.itemFromEndingDelta = math.floor((self.itemFromStartDelta - self.addUnits * self.itemFrom:getUseDelta()) * 100.0) / 100.0
	self:complete()
end

function ISAddWaterFromItemAction:complete()
	self.itemFrom:setUsedDelta(self.itemFromEndingDelta)

	if self.itemFrom:isTaintedWater() then
		self.objectTo:setTaintedWater(true)
	end
	self.objectTo:setWaterAmount(self.objectTo:getWaterAmount() +self.addUnits)
	self.objectTo:sync()
	if not instanceof(self.objectTo, "IsoWorldInventoryObject") then
		self.objectTo:transmitModData()
	end

	if (self.itemFrom:getCurrentUsesFloat() / self.itemFrom:getUseDelta()) < 1.0 then
		self.itemFrom:UseAndSync()
	end

	return true;
end

function ISAddWaterFromItemAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return math.max(6, self.addUnits) * 7;
end

function ISAddWaterFromItemAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISAddWaterFromItemAction:new(character, itemFrom, objectTo)
	local o = ISBaseTimedAction.new(self, character)
	o.itemFrom = itemFrom
	o.objectTo = objectTo

	o.itemFromStartDelta = o.itemFrom:getCurrentUsesFloat()
	local waterAvailable = o.itemFrom:getCurrentUses()
	local destCapacity = o.objectTo:getWaterMax() - o.objectTo:getWaterAmount()
	o.addUnits = math.min(destCapacity, waterAvailable)
	o.itemFromEndingDelta = math.floor((o.itemFromStartDelta - o.addUnits * o.itemFrom:getUseDelta()) * 100.0) / 100.0

	o.maxTime = o:getDuration()
	return o
end    	
