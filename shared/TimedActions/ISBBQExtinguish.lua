--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISBBQExtinguish = ISBaseTimedAction:derive("ISBBQExtinguish");

function ISBBQExtinguish:isValid()
	return self.bbq:getObjectIndex() ~= -1 and self.bbq:isLit()
end

function ISBBQExtinguish:waitToStart()
	self.character:faceThisObject(self.bbq)
	return self.character:shouldBeTurning()
end

function ISBBQExtinguish:update()
	self.character:faceThisObject(self.bbq)
end

function ISBBQExtinguish:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Mid")
end

function ISBBQExtinguish:stop()
    ISBaseTimedAction.stop(self);
end

function ISBBQExtinguish:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISBBQExtinguish:complete()

	if self.bbq and self.bbq:isLit() then
		self.bbq:extinguish()
		self.bbq:sendObjectChange('state')
	end

	return true;
end

function ISBBQExtinguish:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 60
end

function ISBBQExtinguish:new (character, bbq)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration();
	o.bbq = bbq
	return o
end
