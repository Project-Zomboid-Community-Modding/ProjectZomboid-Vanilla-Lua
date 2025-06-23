--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveLeatherFromAnimal = ISBaseTimedAction:derive("ISRemoveLeatherFromAnimal");

function ISRemoveLeatherFromAnimal:isValid()
	if isClient() then
		if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
			return false;
		end

		if self.started then
			return true;
		end
	end

	return self.body ~= nil and self.body:getModData()["leather"];
end

function ISRemoveLeatherFromAnimal:waitToStart()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
	return self.character:shouldBeTurning()
end

function ISRemoveLeatherFromAnimal:update()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end

	-- update the hook UI
	if self.luaHook then
		self.luaHook.doingAction = true;
		self.luaHook.actionText = getText("IGUI_Animal_RemovingLeather");
		self.luaHook:updateProgressBar(self:getJobDelta());
	end
end

function ISRemoveLeatherFromAnimal:start()
	self:setActionAnim("Loot")
	--self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	self.started = true;
	self.sound = self.character:playSound("ButcheringSkinCorpse")
end

function ISRemoveLeatherFromAnimal:stop()
	self:stopSound();
	self.luaHook.doingAction = false;

    ISBaseTimedAction.stop(self);
end

function ISRemoveLeatherFromAnimal:serverStart()
	if not self.hook:getUsingPlayer() then
		ButcheringUtil.setUsingPlayerForHook(self.hook, self.character);
	end
end

function ISRemoveLeatherFromAnimal:serverStop()
	if self.hook:getUsingPlayer() == self.character then
		ButcheringUtil.setUsingPlayerForHook(self.hook, nil);
	end
end

function ISRemoveLeatherFromAnimal:updateCorpse()
	if self.luaHook then
		self.luaHook.doingAction = false;
		-- don't try and change the model on the fly it makes things weiiiird, so i'm recreating stuff
		self.luaHook:resetCorpse();
		self.luaHook:updateCorpseDatas();
	else
		ButcheringUtil.updateCorpseDatas({ }, self.body, self.hook);
	end
end

function ISRemoveLeatherFromAnimal:perform()
	if self.luaHook then
		self.luaHook.doingAction = false;
	end

	self:updateCorpse();
	self:stopSound();

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveLeatherFromAnimal:complete()
	if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	local leather = ButcheringUtil.getLeather(self.body:getTypeAndBreed());
	-- TODO Leather quality maybe? (this gonna be screwed by the craftProcessor for now anyway)
	if leather then
		local leatherItem = self.character:getInventory():AddItem(leather);
		sendAddItemToContainer(self.character:getInventory(), leatherItem);
	end

    addXp(self.character, Perks.Butchering, self.xp * 3);
	self.body:getModData()["leather"] = nil;
	self.body:getModData()["skinned"] = true;

	self.hook:getAnimal():getModData()["skinned"] = true;

	self.body:transmitModData();
	self.hook:getAnimal():transmitModData();

	self:updateCorpse();

	ButcheringUtil.setUsingPlayerForHook(self.hook, nil);

	return true
end

function ISRemoveLeatherFromAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 400 - (self.perkLevel * 15);
end

function ISRemoveLeatherFromAnimal:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISRemoveLeatherFromAnimal:new(character, body, hook, luaHookUI)
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
