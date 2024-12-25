--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISBBQToggle = ISBaseTimedAction:derive("ISBBQToggle");

function ISBBQToggle:isValid()
	return self.bbq:isPropaneBBQ() and self.bbq:hasFuel()
end

function ISBBQToggle:waitToStart()
	self.character:faceThisObject(self.bbq)
	return self.character:shouldBeTurning()
end

function ISBBQToggle:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Mid")
end

function ISBBQToggle:update()
	self.character:faceThisObject(self.bbq)
end

function ISBBQToggle:stop()
	ISBaseTimedAction.stop(self)
end

function ISBBQToggle:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISBBQToggle:complete()
	if self.bbq and self.bbq:hasFuel() then
		self.bbq:toggle()
		self.bbq:sendObjectChange('state')
	end

	return true;
end

function ISBBQToggle:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISBBQToggle:new(character, bbq)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.bbq = bbq
	return o
end
