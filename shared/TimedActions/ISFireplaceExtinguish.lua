--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFireplaceExtinguish = ISBaseTimedAction:derive("ISFireplaceExtinguish");

function ISFireplaceExtinguish:isValid()
	return self.fireplace:getObjectIndex() ~= -1 and self.fireplace:isLit()
end

function ISFireplaceExtinguish:waitToStart()
	self.character:faceThisObject(self.fireplace)
	return self.character:shouldBeTurning()
end

function ISFireplaceExtinguish:update()
	self.character:faceThisObject(self.fireplace)
end

function ISFireplaceExtinguish:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISFireplaceExtinguish:stop()
    ISBaseTimedAction.stop(self);
end

function ISFireplaceExtinguish:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISFireplaceExtinguish:complete()
	if self.fireplace and self.fireplace:isLit() then
		self.fireplace:extinguish()
		self.fireplace:sendObjectChange('state')
	end
	return true;
end

function ISFireplaceExtinguish:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 60
end

function ISFireplaceExtinguish:new (character, fireplace)
	local o = ISBaseTimedAction.new(self, character);
	o.maxTime = o:getDuration()
	-- custom fields
	o.fireplace = fireplace
	return o
end
