--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveSheetAction = ISBaseTimedAction:derive("ISRemoveSheetAction");

function ISRemoveSheetAction:isValid()
	if self.item:getObjectIndex() == -1 then return false end
	return instanceof(self.item, "IsoCurtain") or (self.item:HasCurtains() ~= nil)
end

function ISRemoveSheetAction:waitToStart()
	self.character:faceThisObjectAlt(self.item)
	return self.character:shouldBeTurning()
end

function ISRemoveSheetAction:update()
	self.character:faceThisObjectAlt(self.item)

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISRemoveSheetAction:start()
	self:setActionAnim("RemoveCurtain")
	self:setOverrideHandModels(nil, nil)
	self.character:playSound("CurtainSheetRemove")
end

function ISRemoveSheetAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveSheetAction:perform()
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveSheetAction:complete()

	if instanceof(self.item, 'IsoCurtain') or instanceof(self.item, 'IsoDoor') then
		self.item:removeSheet(self.character)
	else
		noise('expected curtain/door got '..tostring(self.item))
	end

	return true;
end

function ISRemoveSheetAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISRemoveSheetAction:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.maxTime = o:getDuration();
	return o;
end
