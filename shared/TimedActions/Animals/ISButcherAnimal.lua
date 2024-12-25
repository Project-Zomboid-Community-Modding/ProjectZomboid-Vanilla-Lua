--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISButcherAnimal = ISBaseTimedAction:derive("ISButcherAnimal");

function ISButcherAnimal:isValid()
	return self.body ~= nil and self.body:getModData()["parts"] ~= nil;
end

function ISButcherAnimal:waitToStart()
	self.character:faceThisObject(self.body)
	return self.character:shouldBeTurning()
end

function ISButcherAnimal:update()
	self.character:faceThisObject(self.animal)
end

function ISButcherAnimal:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
end

function ISButcherAnimal:stop()
    ISBaseTimedAction.stop(self);
end

function ISButcherAnimal:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISButcherAnimal:complete()
	ButcheringUtil.butcherAnimalFromGround(self.body, self.character);

	sendButcherAnimal(self.body, self.character)

	return true
end

function ISButcherAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 900 - (self.perkLevel * 20);
end

function ISButcherAnimal:new(character, body)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.maxTime = o:getDuration()
	return o;
end
