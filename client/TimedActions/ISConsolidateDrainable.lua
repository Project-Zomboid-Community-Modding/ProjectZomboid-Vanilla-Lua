--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISConsolidateDrainable = ISBaseTimedAction:derive("ISConsolidateDrainable");

function ISConsolidateDrainable:isValid()
    return self.character:getInventory():contains(self.intoItem) and self.character:getInventory():contains(self.drainable);
end

function ISConsolidateDrainable:update()
	self.drainable:setJobDelta(self:getJobDelta());
	self.intoItem:setJobDelta(self:getJobDelta());
	local fromDelta = self.fromStart + (self.fromTarget - self.fromStart) * self:getJobDelta()
	self.drainable:setUsedDelta(fromDelta)
	local intoDelta = self.intoStart + (self.intoTarget - self.intoStart) * self:getJobDelta()
	self.intoItem:setUsedDelta(intoDelta)
end

function ISConsolidateDrainable:start()
	local jobType = getText("IGUI_JobType_PourIn");
	if self.intoItem:canConsolidate() and self.intoItem:getConsolidateOption() then
		jobType = getText(self.intoItem:getConsolidateOption());
	end
	self.drainable:setJobType(jobType);
	self.intoItem:setJobType(jobType);
	self.fromStart = self.drainable:getUsedDelta()
	self.intoStart = self.intoItem:getUsedDelta()
	local maxAdd = 1 - self.intoItem:getUsedDelta()
	local maxTake = self.drainable:getUsedDelta()
	local amount = math.min(maxAdd, maxTake)
	self.fromTarget = self.fromStart - amount
	self.intoTarget = self.intoStart + amount
end

function ISConsolidateDrainable:stop()
	self.drainable:setJobDelta(0.0);
	self.intoItem:setJobDelta(0.0);
    ISBaseTimedAction.stop(self);
end

function ISConsolidateDrainable:perform()
	self.drainable:setJobDelta(0.0);
	self.intoItem:setJobDelta(0.0);
    if self.intoItem:getUsedDelta() > self.intoStart and self.drainable:isTaintedWater() then
        self.intoItem:setTaintedWater(true);
    end
	if self.drainable:getUsedDelta() <= 0.0001 then
		self.drainable:Use()
		self.drainable = nil
	end
	local item1 = self:nextItem()
	if item1 then
		if self.intoItem:getUsedDelta() < 1 then
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
	local action = ISConsolidateDrainable:new(self.playerNum, drainable, intoItem, self.maxTime, self.otherItems)
	ISTimedActionQueue.addAfter(self, action)
end

function ISConsolidateDrainable:nextItem()
	if not self.otherItems then return nil end
	while #self.otherItems > 0 do
		local item = table.remove(self.otherItems, 1)
		if (item:getUsedDelta() > 0) and self.character:getInventory():contains(item) then
			return item
		end
	end
	return nil
end

function ISConsolidateDrainable:new(character, drainable, intoItem, time, otherItems)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.playerNum = character
	o.character = getSpecificPlayer(character);
	o.drainable = drainable;
	o.intoItem = intoItem;
	o.otherItems = otherItems;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = time;
	return o;
end
