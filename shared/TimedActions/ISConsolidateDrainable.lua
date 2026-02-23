require "TimedActions/ISBaseTimedAction"

ISConsolidateDrainable = ISBaseTimedAction:derive("ISConsolidateDrainable");

function ISConsolidateDrainable:isValid()
    if isClient() and self.intoItem and self.drainable then
        return self.character:getInventory():containsID(self.intoItem:getID()) and (self.character:getInventory():containsID(self.drainable:getID()) or (self.otherItems and #self.otherItems > 0))
    else
        return self.character:getInventory():contains(self.intoItem) and (self.character:getInventory():contains(self.drainable) or (self.otherItems and #self.otherItems > 0));
    end
end

function ISConsolidateDrainable:update()
	local progress
	if isServer() then
		progress = self.netAction:getProgress();
	else
		progress = self:getJobDelta();
	end
    if not isServer() then
	    self.drainable:setJobDelta(progress);
	    self.intoItem:setJobDelta(progress);
    end
    if not isClient() then
	    if self.drainable:getCurrentUsesFloat() <= 0 then
		    self:forceComplete();
	    end
	    local fromDelta = self.fromStart + (self.fromTarget - self.fromStart) * progress;
	    self.drainable:setUsedDelta(fromDelta);
	    local intoDelta = self.intoStart + (self.intoTarget - self.intoStart) * progress;
	    self.intoItem:setUsedDelta(intoDelta);
	    if isServer() then
	        sendItemStats(self.intoItem);
	        sendItemStats(self.drainable);
        end
    end
end

function ISConsolidateDrainable:animEvent(event, parameter)
	if isServer() then
		if event == "update" then
			self:update();
		end
	end
end

function ISConsolidateDrainable:serverStart()
	emulateAnimEvent(self.netAction, self:getDuration(), "update", nil);
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

function ISConsolidateDrainable:complete()
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
