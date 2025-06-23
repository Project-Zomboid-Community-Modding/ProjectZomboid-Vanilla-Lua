--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCutAnimalOnHook = ISBaseTimedAction:derive("ISCutAnimalOnHook");

function ISCutAnimalOnHook:isValid()
	if isClient() and not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

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

function ISCutAnimalOnHook:serverStart()
	if not self.hook:getUsingPlayer() then
		ButcheringUtil.setUsingPlayerForHook(self.hook, self.character);
	end
end

function ISCutAnimalOnHook:serverStop()
	if ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		ButcheringUtil.setUsingPlayerForHook(self.hook, nil);
	end
end

function ISCutAnimalOnHook:start()
	self:setActionAnim("Loot")
	--self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	self.luaHook.hook:setPlayRemovingBloodSound(true)
	self.hook:setLuaHook(self.luaHook);
end

function ISCutAnimalOnHook:stop()
    self.luaHook.hook:setPlayRemovingBloodSound(false)
    ISBaseTimedAction.stop(self);
end

function ISCutAnimalOnHook:perform()
	self.luaHook.hook:setPlayRemovingBloodSound(false)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISCutAnimalOnHook:complete()
	if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	-- if we had a bucket we gonna start ISGatherBloodFromAnimal, otherwise after a cut we need to make the animal bleed
	if not self.bucket then
		self.hook:startRemovingBlood(self.luaHook);
	end

	ButcheringUtil.setUsingPlayerForHook(self.hook, nil);

	return true
end

function ISCutAnimalOnHook:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 150 - (self.perkLevel * 10);
end

function ISCutAnimalOnHook:new(character, body, hook, luaHookUI, bucket)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHookUI;
	o.bucket = bucket;
	o.animalDef = ButcheringUtil.getAnimalDef(body:getTypeAndBreed())
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.xp = o.animalDef.xpPerItem;
	o.maxTime = o:getDuration()
	return o;
end
