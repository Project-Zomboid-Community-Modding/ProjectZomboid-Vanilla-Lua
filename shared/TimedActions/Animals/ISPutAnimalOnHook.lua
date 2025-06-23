--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPutAnimalOnHook = ISBaseTimedAction:derive("ISPutAnimalOnHook");

function ISPutAnimalOnHook:isValid()
	if isClient() and not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	return self.body ~= nil;
end

function ISPutAnimalOnHook:waitToStart()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
	return self.character:shouldBeTurning()
end

function ISPutAnimalOnHook:update()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
end

function ISPutAnimalOnHook:start()
	self:setActionAnim("Loot")
	--self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")

	if self.luaHook then
		self.hook:setLuaHook(self.luaHook);
	end

	self.sound = self.character:playSound("ButcheringAddCorpse")
end

function ISPutAnimalOnHook:serverStart()
	if not self.hook:getUsingPlayer() then
		ButcheringUtil.setUsingPlayerForHook(self.hook, self.character);
	end
end

function ISPutAnimalOnHook:serverStop()
	if ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		ButcheringUtil.setUsingPlayerForHook(self.hook, nil);
	end
end

function ISPutAnimalOnHook:stop()
	self:stopSound();
	ISBaseTimedAction.stop(self);
end

function ISPutAnimalOnHook:perform()
	self:stopSound();
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPutAnimalOnHook:complete()
	if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	if not self.body then
		ButcheringUtil.setUsingPlayerForHook(self.hook, nil);
		return false;
	end

	-- Prevent multiple players hooking the same body on multiple hooks
	if instanceof(self.body, "IsoDeadBody") then
		if self.body:isOnHook() then
			ButcheringUtil.setUsingPlayerForHook(self.hook, nil);
			return false;
		end

		self.body:setOnHook(true);
	end

	if self.luaHook then
		self.luaHook:onAddedCorpse(self.body);
	else
		ButcheringUtil.onAddedCorpseOnHook(self.hook, self.body, self.character);
	end

	ButcheringUtil.setUsingPlayerForHook(self.hook, nil);

	return true
end

function ISPutAnimalOnHook:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 250 - (self.perkLevel * 10);
end

function ISPutAnimalOnHook:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISPutAnimalOnHook:new(character, body, hook, luaHookUI)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHookUI;
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.maxTime = o:getDuration()
	return o;
end
