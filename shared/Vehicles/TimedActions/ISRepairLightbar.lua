require "TimedActions/ISBaseTimedAction"

ISRepairLightbar = ISBaseTimedAction:derive("ISRepairLightbar")

function ISRepairLightbar:isValid()
--	return self.vehicle:isInArea(self.part:getArea(), self.character)
	return true;
end

function ISRepairLightbar:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISRepairLightbar:update()
	self.character:faceThisObject(self.vehicle)
	self.item:setJobDelta(self:getJobDelta())

    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISRepairLightbar:start()
	self.item:setJobType(self.jobType)
	self:setActionAnim("VehicleWorkOnMid")
end

function ISRepairLightbar:stop()
	self.item:setJobDelta(0)
	ISBaseTimedAction.stop(self)
end

function ISRepairLightbar:perform()
    self.item:setJobDelta(0)
	ISBaseTimedAction.perform(self)
end

function ISRepairLightbar:complete()
    if self.item == nil then
        return false
    end
    if self.vehicle then
    	if not self.part then
    		noise('no such part Ligthbar')
    		return false
    	end
	    local skill = self.character:getPerkLevel(Perks.Mechanics) - self.vehicle:getScript():getEngineRepairLevel();
	    local giveXP = self.character:getMechanicsItem(self.part:getVehicle():getMechanicalID() .. "2") == nil
    	local condPerPart = 15 + (skill)

    	self.part:setCondition(self.part:getCondition() + condPerPart)
    	if self.part:getCondition() >= 100 then
    		self.part:setCondition(100)
    	end

    	if giveXP then
    	    addXp(self.character, Perks.Mechanics, 5);
    	end
    	local item = self.character:getInventory():Remove(self.item);
        if isServer() then
            sendRemoveItemFromContainer(self.character:getInventory(), self.item);
        end
    	self.vehicle:transmitPartCondition(self.part)

    	self.character:sendObjectChange(IsoObjectChange.MECHANIC_ACTION_DONE, { success = true})
    	self.character:addMechanicsItem(self.item:getID() .. self.vehicle:getMechanicalID() .. "1", self.part, getGameTime():getCalender():getTimeInMillis());
	    self.character:addMechanicsItem(self.part:getVehicle():getMechanicalID() .. "2", self.part, getGameTime():getCalender():getTimeInMillis());
    else
    	print('no such vehicle id=',self.vehicle)
    	return false
    end

	return true
end

function ISRepairLightbar:getDuration()
    if self.part == nil or self.item == nil then
        return 0
    end
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return self.maxTime;
end

function ISRepairLightbar:new(character, part, item, maxTimeInit)
	print("ISRepairLightbar")
	local o = ISBaseTimedAction.new(self, character)
	o.part = part
	if part ~= nil then
	    o.vehicle = part:getVehicle()
	end
	o.item = item
	o.maxTimeInit = maxTimeInit
	o.maxTime = maxTimeInit
	o.jobType = getText("ContextMenu_Repair")
	return o
end

