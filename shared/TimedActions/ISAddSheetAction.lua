--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddSheetAction = ISBaseTimedAction:derive("ISAddSheetAction");

function ISAddSheetAction:isValid()
	if self.item:HasCurtains() then return false end
	return self.character:getInventory():contains("Sheet");
end

function ISAddSheetAction:waitToStart()
	self.character:faceThisObjectAlt(self.item)
	return self.character:shouldBeTurning()
end

function ISAddSheetAction:update()
	self.character:faceThisObjectAlt(self.item)
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISAddSheetAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "High")
	self:setOverrideHandModels(nil, nil)
	self.character:playSound("CurtainSheetAdd")
end

function ISAddSheetAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISAddSheetAction:perform()
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISAddSheetAction:complete()
	if self.item and (self.item:getObjectIndex() ~= -1) then
		self.item:addSheet(self.character)
	else
		noise('sq is null or index is invalid')
	end

	buildUtil.setHaveConstruction(self.item:getSquare(), true);

	return true;
end

function ISAddSheetAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISAddSheetAction:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.maxTime = o:getDuration();
	return o;
end
