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
	if self.body then
		if self:isLargeAnimal(self.body) then
			self.sound = self.character:playSound("ButcheringGatherMeatLarge")
		else
			self.sound = self.character:playSound("ButcheringGatherMeatSmall")
		end
	end
end

function ISButcherAnimal:stop()
	self:stopSound();
    ISBaseTimedAction.stop(self);
end

function ISButcherAnimal:perform()
	self:stopSound();
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISButcherAnimal:complete()
	-- case if another player picked up the body
	if not self.body then
		return false;
	end

	ButcheringUtil.butcherAnimalFromGround(self.body, self.character);

	--sendButcherAnimal(self.body, self.character)

	return true
end

function ISButcherAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 900 - (self.perkLevel * 20);
end

function ISButcherAnimal:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISButcherAnimal:isLargeAnimal(corpse)
	-- See ISButcherHookUI:isCorpseValid()
	local modData = corpse:getModData();
	if not modData then return false; end
--    if instanceof(corpse, "Food") and corpse:isFrozen() then return false; end
	if not AnimalAvatarDefinition[modData["AnimalType"]] or not AnimalAvatarDefinition[modData["AnimalType"]].hook then return false; end
	if modData["animalSize"] < 0.4 then return false; end
	-- no skeleton on the hook!
	return not modData["skeleton"];
end

function ISButcherAnimal:new(character, body)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.maxTime = o:getDuration()
	return o;
end
