--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveAnimalFromHook = ISBaseTimedAction:derive("ISRemoveAnimalFromHook");

function ISRemoveAnimalFromHook:isValid()
	if isClient() and not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	return self.body ~= nil;
end

function ISRemoveAnimalFromHook:waitToStart()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
	return self.character:shouldBeTurning()
end

function ISRemoveAnimalFromHook:update()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
end

function ISRemoveAnimalFromHook:start()
	self:setActionAnim("Loot")
	--self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	self.sound = self.character:playSound("ButcheringRemoveCorpse")
end

function ISRemoveAnimalFromHook:stop()
	self:stopSound();
    ISBaseTimedAction.stop(self);
end

function ISRemoveAnimalFromHook:serverStart()
	if not self.hook:getUsingPlayer() then
		ButcheringUtil.setUsingPlayerForHook(self.hook, self.character);
	end
end

function ISRemoveAnimalFromHook:serverStop()
	if ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		ButcheringUtil.setUsingPlayerForHook(self.hook, nil);
	end
end

function ISRemoveAnimalFromHook:perform()
	-- Stop rendering the animal locally so we don't have to wait for the removeAnimal packet to trigger the actual removal.
	self.body:setDoRender(false);
	self:stopSound();
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveAnimalFromHook:complete()
	if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	if self.luaHook then
		self.luaHook:onClickRemoveCorpse(self.body);
	else
		ButcheringUtil.onRemoveCorpseFromHook(self.hook, self.body)
	end

	ButcheringUtil.setUsingPlayerForHook(self.hook, nil);

	return true
end

function ISRemoveAnimalFromHook:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 250 - (self.perkLevel * 10);
end

function ISRemoveAnimalFromHook:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISRemoveAnimalFromHook:new(character, body, hook, luaHookUI)
	local o = ISBaseTimedAction.new(self, character)
	if not body then
		return o;
	end

	o.body = body;
	o.hook = hook;
	o.luaHook = luaHookUI;
	o.animalDef = ButcheringUtil.getAnimalDef(body:getTypeAndBreed())
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.xp = o.animalDef.xpPerItem;
	o.maxTime = o:getDuration()
	return o;
end
