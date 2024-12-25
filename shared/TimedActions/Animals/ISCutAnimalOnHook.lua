--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCutAnimalOnHook = ISBaseTimedAction:derive("ISCutAnimalOnHook");

function ISCutAnimalOnHook:isValid()
	return self.body ~= nil;
end

function ISCutAnimalOnHook:waitToStart()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
	return self.character:shouldBeTurning()
end

function ISCutAnimalOnHook:update()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
end

function ISCutAnimalOnHook:start()
	self:setActionAnim("Loot")
	--self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
end

function ISCutAnimalOnHook:stop()
    ISBaseTimedAction.stop(self);
end

function ISCutAnimalOnHook:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISCutAnimalOnHook:complete()
	-- if we had a bucket we gonna start ISGatherBloodFromAnimal, otherwise after a cut we need to make the animal bleed
	if not self.bucket then
		self.luaHook:onCutCorpse();
	end

	return true
end

function ISCutAnimalOnHook:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 150 - (self.perkLevel * 10);
end

function ISCutAnimalOnHook:new(character, body, hook, luaHook, bucket)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHook;
	o.bucket = bucket;
	o.animalDef = ButcheringUtil.getAnimalDef(body:getTypeAndBreed())
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.xp = o.animalDef.xpPerItem;
	o.maxTime = o:getDuration()
	return o;
end
