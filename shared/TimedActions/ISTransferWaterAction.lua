--***********************************************************
--**                    Erasmus Crowley                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTransferWaterAction = ISBaseTimedAction:derive("ISTransferWaterAction");

function ISTransferWaterAction:isValid()
	return true;
end

function ISTransferWaterAction:update()
    if self.itemFrom ~= nil and self.itemTo ~= nil and instanceof(self.itemFrom, "DrainableComboItem") then
        self.itemFrom:setJobDelta(self:getJobDelta());
        self.itemFrom:setUsedDelta(self.itemFromBeginDelta + ((self.itemFromEndingDelta - self.itemFromBeginDelta) * self:getJobDelta()))
		if self.itemTo:isWaterSource() then
			self.itemTo:setJobDelta(self:getJobDelta());
			self.itemTo:setUsedDelta(self.itemToBeginDelta + ((self.itemToEndingDelta - self.itemToBeginDelta) * self:getJobDelta()))
		end
    end
end

function ISTransferWaterAction:serverStart()
	if not self.itemTo:isWaterSource() then
		local newItemType = self.itemTo:getReplaceType("WaterSource");
		local newItem = instanceItem(newItemType,0);
		newItem:setFavorite(self.itemTo:isFavorite());
		newItem:setCondition(self.itemTo:getCondition());
		newItem:setColorRed(self.itemTo:getColorRed());
		newItem:setColorGreen(self.itemTo:getColorGreen());
		newItem:setColorBlue(self.itemTo:getColorBlue());
		newItem:setColor(Color.new(self.itemTo:getColorRed(), self.itemTo:getColorGreen(), self.itemTo:getColorBlue()));
		newItem:setCustomColor(true);
		self.character:getInventory():AddItem(newItem);
		if self.character:getPrimaryHandItem() == itemTo then
			self.character:setPrimaryHandItem(newItem)
		end
		if self.character:getSecondaryHandItem() == itemTo then
			self.character:setSecondaryHandItem(newItem)
		end
		self.character:getInventory():Remove(self.itemTo);
		sendReplaceItemInContainer(self.character:getInventory(), self.itemTo, newItem)
		self.itemTo = newItem;
	end
end

function ISTransferWaterAction:start()
	if not isClient() then
		self:serverStart()
	end
    if self.itemFrom ~= nil and self.itemTo ~= nil then
		if self.itemFrom:isTaintedWater() then
			self.itemTo:setTaintedWater(true);
		end
	    self.itemFrom:setJobType(getText("IGUI_JobType_PourOut"));
	    self.itemTo:setJobType(getText("IGUI_JobType_PourIn"));
	    
	    self.itemFrom:setJobDelta(0.0);
	    self.itemTo:setJobDelta(0.0);
	
		self:setAnimVariable("PourType", self.itemTo:getPourType());
		self:setActionAnim("Pour");
-- 		if not self.itemTo:getEatType() then
			self:setOverrideHandModels(self.itemTo:getStaticModel(), nil)
-- 		else
-- 			self:setOverrideHandModels(nil, self.itemTo:getStaticModel())
-- 		end
	
		self.character:reportEvent("EventTakeWater");
    end
end

function ISTransferWaterAction:stop()
    ISBaseTimedAction.stop(self);
    if self.itemFrom ~= nil then
        self.itemFrom:setJobDelta(0.0);
	end
	if self.itemTo ~= nil then
		self.itemTo:setJobDelta(0.0);
	end
end

function ISTransferWaterAction:perform()
    if self.itemFrom ~= nil and self.itemTo ~= nil then
		if self.itemFrom:getContainer() then
			self.itemFrom:getContainer():setDrawDirty(true);
		end
        self.itemFrom:setJobDelta(0.0);
        self.itemTo:setJobDelta(0.0);
		if self.itemTo:getContainer() then
			self.itemTo:getContainer():setDrawDirty(true);
		end
    end
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISTransferWaterAction:complete()
	if self.itemFromEndingDelta == 0 then
		self.itemFrom:setUsedDelta(0);
		self.itemFrom:UseAndSync();
		if self.itemFrom:getContainer() then
			sendItemStats(self.itemFrom)
		end
	else
		self.itemFrom:setUsedDelta(self.itemFromEndingDelta);
		sendItemStats(self.itemFrom)
	end

	self.itemTo:setUsedDelta(self.itemToEndingDelta);
	self.itemTo:updateWeight();
	sendItemStats(self.itemTo)

	return true;
end

function ISTransferWaterAction:serverStop()
	self.itemFromEndingDelta = self.itemFromBeginDelta - (self.netAction:getProgress() * (self.itemFromBeginDelta - self.itemFromEndingDelta));
	self:complete()
end

function ISTransferWaterAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return ((self.itemFrom:getCurrentUsesFloat() - self.itemFromEndingDelta) / self.itemFrom:getUseDelta()) * 30;
end


function ISTransferWaterAction:new (character, itemFrom, itemTo, itemFromEndingDelta, itemToEndingDelta)
	local o = ISBaseTimedAction.new(self, character)
	o.itemFrom = itemFrom;
	o.itemFromBeginDelta = itemFrom:getCurrentUsesFloat();
	o.itemFromEndingDelta = itemFromEndingDelta;
	o.itemTo = itemTo;
	if itemTo:isWaterSource() then
		o.itemToBeginDelta = itemTo:getCurrentUsesFloat();
	else
		o.itemToBeginDelta = 0;
	end
	o.itemToEndingDelta = itemToEndingDelta;
	o.maxTime = o:getDuration();
	return o
end
