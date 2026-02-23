require "TimedActions/ISBaseTimedAction"

ISRepairEngine = ISBaseTimedAction:derive("ISRepairEngine")

function ISRepairEngine:isValid()
--	return self.vehicle:isInArea(self.part:getArea(), self.character)
	return true;
end

function ISRepairEngine:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISRepairEngine:update()
	self.character:faceThisObject(self.vehicle)
	self.item:setJobDelta(self:getJobDelta())

    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISRepairEngine:start()
	self.item:setJobType(getText("IGUI_RepairEngine"))
	self:setActionAnim("VehicleWorkOnMid")
end

function ISRepairEngine:stop()
	self.item:setJobDelta(0)
	ISBaseTimedAction.stop(self)
end

function ISRepairEngine:perform()
    self.item:setJobDelta(0)
	ISBaseTimedAction.perform(self)
end

function ISRepairEngine:complete()

	local skill = self.character:getPerkLevel(Perks.Mechanics) - self.vehicle:getScript():getEngineRepairLevel();
	local numberOfParts = self.character:getInventory():getNumberOfItem("EngineParts", false, true);
	local giveXP = self.character:getMechanicsItem(self.part:getVehicle():getMechanicalID() .. "2") == nil
    if self.vehicle then
    	if not self.part then
    		noise('no such part Engine')
    		return false
    	end
    	local condPerPart = 1 + (skill / 2)
    	if condPerPart > 5 then condPerPart = 5 end
    	local done = 0
    	for i=1,numberOfParts do
    		self.part:setCondition(self.part:getCondition() + condPerPart)
    		done = done + 1
    		if self.part:getCondition() >= 100 then
    			self.part:setCondition(100)
    			break
    		end
    	end
    	if done > 0 then
    		if giveXP then
    			addXp(self.character, Perks.Mechanics, done);
    		end
            local itemsToRemove = self.character:getInventory():getSomeTypeRecurse("EngineParts", done)
            for i = 0, itemsToRemove:size() - 1 do
                local item = itemsToRemove:get(i)
                local container = item:getContainer()
                if item and container then
                    container:DoRemoveItem(item)
                    sendRemoveItemFromContainer(container, item)
                end
            end
    		self.vehicle:transmitPartCondition(self.part)
    	else
    	    addXp(self.character, Perks.Mechanics, 1);
    	end
    	self.character:sendObjectChange(IsoObjectChange.MECHANIC_ACTION_DONE, { success = (done > 0)})
    	if done > 0 then
            self.character:addMechanicsItem(self.item:getID() .. self.vehicle:getMechanicalID() .. "1", self.part, getGameTime():getCalender():getTimeInMillis());
        else
            addXp(self.character, Perks.Mechanics, 1);
        end
    else
    	print('no such vehicle id=',self.vehicle)
    end
	self.character:addMechanicsItem(self.part:getVehicle():getMechanicalID() .. "2", self.part, getGameTime():getCalender():getTimeInMillis());

	return true
end

function ISRepairEngine:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return self.maxTime;
end

function ISRepairEngine:new(character, part, item, maxTimeInit)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.item = item
	o.maxTimeInit = maxTimeInit
	o.maxTime = maxTimeInit
	o.jobType = getText("IGUI_RepairEngine")
	return o
end

