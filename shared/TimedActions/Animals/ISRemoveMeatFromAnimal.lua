--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveMeatFromAnimal = ISBaseTimedAction:derive("ISRemoveMeatFromAnimal");

function ISRemoveMeatFromAnimal:isValid()
	if isClient() then
		if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
			return false;
		end

		if self.started then
			return true;
		end
	end

	return self.body ~= nil and self.body:getModData()["parts"];
end

function ISRemoveMeatFromAnimal:waitToStart()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
	return self.character:shouldBeTurning()
end

function ISRemoveMeatFromAnimal:update()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end

	-- update the hook UI
	if self.luaHook then
		self.luaHook.doingAction = true;
		self.luaHook.actionText = getText("IGUI_Animal_GatheringMeat");
		self.luaHook:updateProgressBar(self:getJobDelta());
	end
end

function ISRemoveMeatFromAnimal:start()
	self:setActionAnim("Loot")
	--self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")

	self.started = true;
	if self.hook ~= nil then
		self.sound = self.character:playSound("ButcheringGatherMeatLarge")
	elseif self.body and self:isLargeAnimal(self.body) then
		self.sound = self.character:playSound("ButcheringGatherMeatLarge")
	else
		self.sound = self.character:playSound("ButcheringGatherMeatSmall")
	end
end

function ISRemoveMeatFromAnimal:stop()
	if self.luaHook then
		self.luaHook.doingAction = false;
	end

	self:stopSound();

    ISBaseTimedAction.stop(self);
end

function ISRemoveMeatFromAnimal:serverStart()
	if not self.hook:getUsingPlayer() then
		ButcheringUtil.setUsingPlayerForHook(self.hook, self.character);
	end
end

function ISRemoveMeatFromAnimal:serverStop()
	if ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		ButcheringUtil.setUsingPlayerForHook(self.hook, nil);
	end
end

function ISRemoveMeatFromAnimal:perform()
	if self.luaHook then
		self.luaHook.doingAction = false;
		self.luaHook:updateCorpseDatas();
	end

	self:stopSound();

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveMeatFromAnimal:complete()
	if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	local parts = ButcheringUtil.getAllPartsDef(self.body:getTypeAndBreed());
	for i,v in pairs(parts) do
		ButcheringUtil.addAnimalPart(v, self.character, self.body, false);
	end

	-- add possible blood on character
	local bloodNb = ZombRand(22 - (self.perkLevel * 2));

	-- if animal still had blood in it, add lots more
	local bloodGround = 0;
	if self.body:getModData()["BloodQty"] > 0 then
		bloodNb = bloodNb + self.body:getModData()["BloodQty"] * 2
		bloodGround = self.body:getModData()["BloodQty"] * 2;
	end

	for i=0,bloodNb do
		self.character:addBlood(nil, true, false, false);
	end

	syncVisuals(self.character);

	for i=0,bloodGround do
		addBloodSplat(self.hook:getSquare(), 2, ZombRandFloat(-0.3, 0.3), ZombRandFloat(-0.3, 0.3))
	end

	-- xp for this is done in the addAnimalPart as it'll depend on quantity/quality
	self.body:getModData()["BloodQty"] = 0;
	self.body:getModData()["parts"] = nil;
	self.body:transmitModData();

	if self.luaHook then
		self.luaHook:updateCorpseDatas();
	else
		ButcheringUtil.updateCorpseDatas({ }, self.body, self.hook);
	end

	ButcheringUtil.setUsingPlayerForHook(self.hook, nil);

	return true
end

function ISRemoveMeatFromAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 450 - (self.perkLevel * 15);
end

function ISRemoveMeatFromAnimal:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISRemoveMeatFromAnimal:isLargeAnimal(corpse)
	-- See ISButcherHookUI:isCorpseValid()
	local modData = corpse:getModData();
	if not modData then return false; end
--    if instanceof(corpse, "Food") and corpse:isFrozen() then return false; end
	if not AnimalAvatarDefinition[modData["AnimalType"]] or not AnimalAvatarDefinition[modData["AnimalType"]].hook then return false; end
	if modData["animalSize"] < 0.4 then return false; end
	-- no skeleton on the hook!
	return not modData["skeleton"];
end

function ISRemoveMeatFromAnimal:new(character, body, hook, luaHookUI)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHookUI;
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.maxTime = o:getDuration()
	return o;
end
