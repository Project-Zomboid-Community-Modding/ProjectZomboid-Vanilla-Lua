require "TimedActions/ISBaseTimedAction"

ISTakeEngineParts = ISBaseTimedAction:derive("ISTakeEngineParts")

function ISTakeEngineParts:isValid()
--	return self.vehicle:isInArea(self.part:getArea(), self.character)
	return true;
end

function ISTakeEngineParts:update()
	self.character:faceThisObject(self.vehicle)
	self.item:setJobDelta(self:getJobDelta())

    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISTakeEngineParts:start()
	self.item:setJobType(getText("IGUI_TakeEngineParts"))
end

function ISTakeEngineParts:stop()
	self.item:setJobDelta(0)
	ISBaseTimedAction.stop(self)
end

function ISTakeEngineParts:perform()
    self.item:setJobDelta(0)
	ISBaseTimedAction.perform(self)
end

function ISTakeEngineParts:complete()
    if self.item == nil then
        return false
    end
  	if self.vehicle then
   		if not self.part then
   			print('no such part Engine')
    		return false
   		end

	    local cond = self.part:getCondition();
	    local skill = self.character:getPerkLevel(Perks.Mechanics) - self.vehicle:getScript():getEngineRepairLevel();
    	local condForPart = math.max(20 - skill, 5)
    	condForPart = ZombRand(condForPart / 3, condForPart)
    	local numParts = math.floor(cond / condForPart)
    	if numParts > 0 then
    		local items = self.character:getInventory():AddItems('Base.EngineParts', tonumber(numParts));
    		sendAddItemsToContainer(self.character:getInventory(), items);
    	else
    	    addXp(self.character, Perks.Mechanics, 1);
    	end
    	self.part:setCondition(0)
    	self.vehicle:transmitPartCondition(self.part)
    	self.character:sendObjectChange(IsoObjectChange.MECHANIC_ACTION_DONE, { success = (numParts > 0)})
    	if numParts > 0 then
    	    self.character:addMechanicsItem(self.item:getID() .. self.vehicle:getMechanicalID() .. "1", self.part, getGameTime():getCalender():getTimeInMillis());
    	else
    	    addXp(self.character, Perks.Mechanics, 1);
    	end

        if not self.character:getMechanicsItem(self.vehicle:getMechanicalID() .. "3") then
            addXp(self.character, Perks.Mechanics, math.floor(cond / condForPart)/2);
        end
        self.character:addMechanicsItem(self.vehicle:getMechanicalID() .. "3", self.part, getGameTime():getCalender():getTimeInMillis());
    else
    	print('no such vehicle id=',self.vehicle)
        return false
    end

	return true
end

function ISTakeEngineParts:getExtraLogData()
	if self.vehicle then
		return {
			self.vehicle:getScript():getName(),
		};
	end;
end

function ISTakeEngineParts:getDuration()
    if self.part == nil or self.item == nil then
        return 0
    end
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return self.maxTime;
end

function ISTakeEngineParts:new(character, part, item, maxTimeInit)
	local o = ISBaseTimedAction.new(self, character)
	o.part = part
	if part ~= nil then
	    o.vehicle = part:getVehicle()
	end
	o.item = item
	o.maxTimeInit = maxTimeInit
	o.maxTime = maxTimeInit
	o.jobType = getText("IGUI_TakeEngineParts")
	return o
end

