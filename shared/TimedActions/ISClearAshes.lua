--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISClearAshes = ISBaseTimedAction:derive("ISClearAshes")

function ISClearAshes:isValid()
	return (self.weapon and self.weapon:getCondition() > 0) or not self.weapon;
end

function ISClearAshes:waitToStart()
	self.character:faceThisObject(self.ashes)
	return self.character:shouldBeTurning()
end

function ISClearAshes:update()
	self.character:faceThisObject(self.ashes)
    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISClearAshes:start()
	local handItem = self.character:getPrimaryHandItem()
	if handItem then
		local anim = BuildingHelper.getShovelAnim(handItem)
		if handItem:getType() == "Broom" or handItem:getType() == "Mop" then
			anim = "Rake"
		end
		self:setActionAnim(anim)
	else
		self:setActionAnim("Loot")
		self.character:SetVariable("LootPosition", "Low")
	end
end

function ISClearAshes:stop()
    ISBaseTimedAction.stop(self)
end

function ISClearAshes:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISClearAshes:complete()
	self.ashes:getSquare():transmitRemoveItemFromSquare(self.ashes);
	self.ashes:getSquare():getObjects():remove(self.ashes);
	return true;
end

function ISClearAshes:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 60
end

function ISClearAshes:new(character, ashes)
	local o = ISBaseTimedAction.new(self, character)
	o.character = character
	o.maxTime = o:getDuration();
	o.spriteFrame = 0
	o.ashes = ashes
	return o
end
