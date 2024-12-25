--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFixAction = ISBaseTimedAction:derive("ISFixAction");

function ISFixAction:isValid()
    return self.character:getInventory():contains(self.fixer:getFixerName());
end

function ISFixAction:update()
	self.item:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISFixAction:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self.item:setJobType(getText("IGUI_JobType_Repair"));
	self.item:setJobDelta(0.0);
end

function ISFixAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISFixAction:perform()
	if self.item:getContainer() then
    	self.item:getContainer():setDrawDirty(true);
	end
    self.item:setJobDelta(0.0);
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISFixAction:complete()
    FixingManager.fixItem(self.item, self.character, self.fixing, self.fixer);
    return true
end

function ISFixAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 60
end

function ISFixAction:new(character, item, fixingNum, fixerNum)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
    o.fixingNum = fixingNum
    o.fixerNum = fixerNum
	o.fixing = FixingManager.getFixes(o.item):get(fixingNum);
	o.fixer = o.fixing:getFixers():get(fixerNum);
	o.maxTime = o:getDuration();
    o.caloriesModifier = 4;
	o.jobType = getText("IGUI_Vehicle_Repairing", item:getName());
	return o;
end
