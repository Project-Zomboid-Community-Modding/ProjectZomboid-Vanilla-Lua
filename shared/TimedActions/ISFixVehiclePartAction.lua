--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFixVehiclePartAction = ISBaseTimedAction:derive("ISFixVehiclePartAction");

function ISFixVehiclePartAction:isValid()
	return self.character:getInventory():contains(self.fixer:getFixerName());
end

function ISFixVehiclePartAction:update()
	self.item:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISFixVehiclePartAction:start()
	self.item:setJobType(getText("IGUI_JobType_Repair"));
	self.item:setJobDelta(0.0);
end

function ISFixVehiclePartAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISFixVehiclePartAction:perform()
	if self.item:getContainer() then
    	self.item:getContainer():setDrawDirty(true);
	end
    self.item:setJobDelta(0.0);
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISFixVehiclePartAction:complete()
    FixingManager.fixItem(self.item, self.character, self.fixing, self.fixer);
    self.vehiclePart:setCondition(self.item:getCondition())
    self.vehiclePart:doInventoryItemStats(self.item, self.vehiclePart:getMechanicSkillInstaller())
    if self.vehiclePart:isContainer() and not self.vehiclePart:getItemContainer() then
    -- Changing condition might change capacity.
    -- This limits content amount to max capacity.
    self.vehiclePart:setContainerContentAmount(part:getContainerContentAmount())
    end
    self.vehiclePart:getVehicle():updatePartStats()
    self.vehiclePart:getVehicle():updateBulletStats()
    self.vehiclePart:getVehicle():transmitPartItem(self.vehiclePart)
    return true
end

function ISFixVehiclePartAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 60
end

function ISFixVehiclePartAction:new(character, vehiclePart, fixingNum, fixerNum)
	local o = ISBaseTimedAction.new(self, character)
	o.vehiclePart = vehiclePart;
	o.item = o.vehiclePart:getInventoryItem();
    o.fixingNum = fixingNum
    o.fixerNum = fixerNum
	o.fixing = FixingManager.getFixes(o.item):get(fixingNum);
	o.fixer = o.fixing:getFixers():get(fixerNum);
	o.maxTime = o:getDuration();
    o.caloriesModifier = 4;
	o.jobType = getText("IGUI_Vehicle_Repairing", o.item:getName());
	return o;
end
