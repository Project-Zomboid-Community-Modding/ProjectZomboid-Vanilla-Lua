--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISConsolidateDrainableAll = ISBaseTimedAction:derive("ISConsolidateDrainableAll");

function ISConsolidateDrainableAll:isValid()
    if not self.character:getInventory():contains(self.drainable) then return false end;
    for _,i in pairs(self.consolidateList) do
        if not self.character:getInventory():contains(i) then return false end;
    end
    return true;
end

function ISConsolidateDrainableAll:update()
    self.drainable:setJobDelta(self:getJobDelta());
    for _,i in pairs(self.consolidateList) do
        i:setJobDelta(self:getJobDelta());
    end
end

function ISConsolidateDrainableAll:start()
    local jobType = getText("IGUI_JobType_PourIn");
    if(self.consolidateList[1]:canConsolidate() and self.consolidateList[1]:getConsolidateOption()) then
        jobType = getText(self.consolidateList[1]:getConsolidateOption());
    end
    self.drainable:setJobType(jobType);
    for _,i in pairs(self.consolidateList) do
        i:setJobType(jobType);
    end
    --self.fromStart = self.drainable:getUsedDelta()
    --self.intoStart = self.intoItem:getUsedDelta()
    --local maxAdd = 1 - self.intoItem:getUsedDelta()
    --local maxTake = self.drainable:getUsedDelta()
    --local amount = math.min(maxAdd, maxTake)
    --self.fromTarget = self.fromStart - amount
    --self.intoTarget = self.intoStart + amount
end

function ISConsolidateDrainableAll:stop()
    self.drainable:setJobDelta(0.0);
    for _,i in pairs(self.consolidateList) do
        i:setJobDelta(0.0);
    end
    ISBaseTimedAction.stop(self);
end

function ISConsolidateDrainableAll:perform()
    local totalDelta = self.drainable:getUsedDelta();
    local isTaintedWater = false;
    if self.drainable:isTaintedWater() then
        isTaintedWater = true;
    end
    -- get combined useDelta of items
    self.drainable:setJobDelta(0.0);
    for _,i in pairs(self.consolidateList) do
        totalDelta = totalDelta + i:getUsedDelta();
        if i:isTaintedWater() then
            isTaintedWater = true;
        end
        i:setJobDelta(0.0);
    end
    -- set useDelta of items, and use up items which are at zero
    self.drainable:setTaintedWater(isTaintedWater)
    self.drainable:setUsedDelta(math.min(1, totalDelta))
    totalDelta = totalDelta - math.min(1, totalDelta)
    for _,i in pairs(self.consolidateList) do
        self.drainable:setTaintedWater(isTaintedWater)
        i:setUsedDelta(math.min(1, totalDelta))
        totalDelta = totalDelta - math.min(1, totalDelta)
        if i:getUsedDelta() <= 0.0001 then
            i:Use()
        end
    end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISConsolidateDrainableAll:new(character, drainable, consolidateList, time)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = getSpecificPlayer(character);
    o.drainable = drainable;
    o.consolidateList = consolidateList;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = time;
    return o;
end
