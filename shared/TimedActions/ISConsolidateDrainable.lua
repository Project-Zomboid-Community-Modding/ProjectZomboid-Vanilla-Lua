--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISConsolidateDrainable = ISBaseTimedAction:derive("ISConsolidateDrainable");

function ISConsolidateDrainable:isValid()
    if isClient() and self.intoItem and self.drainable then
        return self.character:getInventory():containsID(self.intoItem:getID()) and (self.character:getInventory():containsID(self.drainable:getID() or (self.otherItems and #self.otherItems > 0)))
    else
        return self.character:getInventory():contains(self.intoItem) and (self.character:getInventory():contains(self.drainable) or (self.otherItems and #self.otherItems > 0));
    end
end

function ISConsolidateDrainable:update()
	if self.drainable:getCurrentUsesFloat() <= 0 then
		self:forceComplete()
	end
	self.drainable:setJobDelta(self:getJobDelta());
	self.intoItem:setJobDelta(self:getJobDelta());
	local fromDelta = self.fromStart + (self.fromTarget - self.fromStart) * self:getJobDelta()
	self.drainable:setUsedDelta(fromDelta)
	local intoDelta = self.intoStart + (self.intoTarget - self.intoStart) * self:getJobDelta()
	self.intoItem:setUsedDelta(intoDelta)
end

function ISConsolidateDrainable:start()
    if isClient() and self.intoItem and self.drainable then
        self.intoItem = self.character:getInventory():getItemById(self.intoItem:getID())
        self.drainable = self.character:getInventory():getItemById(self.drainable:getID())
    end
	local jobType = getText("IGUI_JobType_PourIn");
	if self.intoItem:canConsolidate() and self.intoItem:getConsolidateOption() then
		jobType = getText(self.intoItem:getConsolidateOption());
	end
	self.drainable:setJobType(jobType);
	self.intoItem:setJobType(jobType);
end

function ISConsolidateDrainable:stop()
	self.drainable:setJobDelta(0.0);
	self.intoItem:setJobDelta(0.0);
    ISBaseTimedAction.stop(self);
end

function ISConsolidateDrainable:perform()
	self.drainable:setJobDelta(0.0);
	self.intoItem:setJobDelta(0.0);

	local item1 = self:nextItem()
	if item1 then
		if self.intoItem:getCurrentUsesFloat() < 1 then
			self:runAgain(item1, self.intoItem)
		elseif self.drainable then
			self:runAgain(item1, self.drainable)
		else
			local item2 = self:nextItem()
			self:runAgain(item2, item1)
		end
	end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISConsolidateDrainable:runAgain(drainable, intoItem)
	if not drainable or not intoItem then return end
	local action = ISConsolidateDrainable:new(self.character, drainable, intoItem, self.otherItems)
	ISTimedActionQueue.addAfter(self, action)
end

function ISConsolidateDrainable:nextItem()
	if not self.otherItems then return nil end
	while #self.otherItems > 0 do
		local item = table.remove(self.otherItems, 1)
		if (item:getCurrentUsesFloat() > 0) and self.character:getInventory():contains(item) then
			return item
		end
	end
	return nil
end

function ISConsolidateDrainable:serverStop()
	--self.item:setUsedDelta(self.startUsedDelta + self.netAction:getProgress()*(self.endUsedDelta - self.startUsedDelta));
	--sendItemStats(self.item)
	local fromDelta = self.fromStart + (self.fromTarget - self.fromStart) * self.netAction:getProgress()
	self.drainable:setUsedDelta(fromDelta)
	sendItemStats(self.drainable)
	local intoDelta = self.intoStart + (self.intoTarget - self.intoStart) * self.netAction:getProgress()
	self.intoItem:setUsedDelta(intoDelta)
	sendItemStats(self.intoItem)
end

function ISConsolidateDrainable:complete()
	local fromDelta = self.fromStart + (self.fromTarget - self.fromStart)
	self.drainable:setUsedDelta(fromDelta)
	sendItemStats(self.drainable)
	local intoDelta = self.intoStart + (self.intoTarget - self.intoStart)
	self.intoItem:setUsedDelta(intoDelta)
	sendItemStats(self.intoItem)
--[[
	if self.intoItem:getCurrentUsesFloat() > self.intoStart and self.drainable:isTaintedWater() then
		self.intoItem:setTaintedWater(true);
		self.intoItem:syncItemFields();
	end
]]--
	if self.drainable:getCurrentUsesFloat() <= 0.0001 then
		self.drainable:UseAndSync()
		self.drainable = nil
	end

	return true;
end

function ISConsolidateDrainable:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 90
end

function ISConsolidateDrainable:new(character, drainable, intoItem, otherItems)
	local o = ISBaseTimedAction.new(self, character)
	o.drainable = drainable;
	o.intoItem = intoItem;
	o.otherItems = otherItems;
	o.maxTime = o:getDuration();

	o.fromStart = o.drainable:getCurrentUsesFloat()
	o.intoStart = o.intoItem:getCurrentUsesFloat()
	local maxAdd = 1 - o.intoItem:getCurrentUsesFloat()
	local maxTake = o.drainable:getCurrentUsesFloat()
	local amount = math.min(maxAdd, maxTake)
	o.fromTarget = o.fromStart - amount
	o.intoTarget = o.intoStart + amount
	return o;
end
