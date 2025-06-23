--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveHeadFromAnimal = ISBaseTimedAction:derive("ISRemoveHeadFromAnimal");

function ISRemoveHeadFromAnimal:isValid()
	if isClient() and not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	-- If we received a moddata packet, this function will return false and cause perform not to be called.
	-- Hack this out.
	if isClient() and self.started then
		return true;
	end

	return self.body ~= nil and not self.body:getModData()["headless"];
end

function ISRemoveHeadFromAnimal:waitToStart()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end
	return self.character:shouldBeTurning()
end

function ISRemoveHeadFromAnimal:update()
	if self.hook then
		self.character:faceThisObject(self.hook)
	elseif self.body and self.body:isExistInTheWorld() then
		self.character:faceThisObject(self.body)
	end

	-- update the hook UI
	if self.luaHook then
		self.luaHook.doingAction = true;
		self.luaHook.actionText = getText("IGUI_Animal_RemovingHead");
		self.luaHook:updateProgressBar(self:getJobDelta());
	end
end

function ISRemoveHeadFromAnimal:start()
	self:setActionAnim("Loot")
	--self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	if self.luaHook then
		self.hook:setLuaHook(self.luaHook);
	end

	self.started = true;
	self.sound = self.character:playSound("ButcheringRemoveHead")
end

function ISRemoveHeadFromAnimal:stop()
	self:stopSound();
	self.luaHook.doingAction = false;

    ISBaseTimedAction.stop(self);
end

function ISRemoveHeadFromAnimal:serverStart()
	if not self.hook:getUsingPlayer() then
		ButcheringUtil.setUsingPlayerForHook(self.hook, self.character);
	end
end

function ISRemoveHeadFromAnimal:serverStop()
	if ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		ButcheringUtil.setUsingPlayerForHook(self.hook, nil);
	end
end

function ISRemoveHeadFromAnimal:updateCorpse()
	if self.luaHook then
		self.luaHook.doingAction = false;
		-- don't try and change the model on the fly it makes things weiiiird, so i'm recreating stuff
		self.luaHook:resetCorpse();
		self.luaHook:updateCorpseDatas();
	else
		ButcheringUtil.updateCorpseDatas({ }, self.body, self.hook);
	end
end

function ISRemoveHeadFromAnimal:perform()
	if self.luaHook then
		self.luaHook.doingAction = false;
	end

	self:updateCorpse();
	self:stopSound();

	local bloodGround = 0;
	if self.body:getModData()["BloodQty"] > 0 then
		bloodGround = self.body:getModData()["BloodQty"] * 2;
	end

	for i=0,bloodGround do
		addBloodSplat(self.hook:getSquare(), 2, ZombRandFloat(-0.3, 0.3), ZombRandFloat(-0.3, 0.3))
	end

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveHeadFromAnimal:complete()
	if not ButcheringUtil.isHookUsingSameCharacter(self.hook, self.character) then
		return false;
	end

	-- add possible blood on character
	local bloodNb = ZombRand(22 - (self.perkLevel * 2));

	-- if animal still had blood in it, add lots more
	if self.body:getModData()["BloodQty"] > 0 then
		bloodNb = bloodNb + self.body:getModData()["BloodQty"] * 2
	end

	for i=0,bloodNb do
		self.character:addBlood(nil, true, false, false);
	end
	syncVisuals(self.character);

	-- if the animal is rotten you don't get a head but a skull
	local head = ButcheringUtil.getHead(self.body:getTypeAndBreed());
	local skull = ButcheringUtil.getSkull(self.body:getTypeAndBreed());
	if head and self.body:getModData()["head"] then
		local headItem = instanceItem(head);
		local animalRotStage = self.body:getModData()["animalRotStage"] or 0
		if animalRotStage > 0 then
			headItem:setAge(ZombRand(headItem:getOffAgeMax() + 3, headItem:getOffAgeMax() * 1.5));
		end
		self.character:getInventory():AddItem(headItem);
		sendAddItemToContainer(self.character:getInventory(), headItem);
	elseif skull then
		local skullItem = self.character:getInventory():AddItem(skull);
		sendAddItemToContainer(self.character:getInventory(), skullItem);
	end

	addXp(self.character, Perks.Butchering, self.xp);
	self.body:getModData()["head"] = nil;
	self.body:getModData()["headless"] = true;
	self.hook:getAnimal():getModData()["headless"] = true;

	self.body:transmitModData();
	self.hook:getAnimal():transmitModData();

	self:updateCorpse();

	ButcheringUtil.setUsingPlayerForHook(self.hook, nil);

	return true
end

function ISRemoveHeadFromAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 250 - (self.perkLevel * 10);
end


function ISRemoveHeadFromAnimal:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:getEmitter():stopOrTriggerSound(self.sound);
	end
end

function ISRemoveHeadFromAnimal:new(character, body, hook, luaHookUI)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHookUI;
	o.animalDef = ButcheringUtil.getAnimalDef(body:getTypeAndBreed())
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.xp = o.animalDef.xpPerItem;
	o.maxTime = o:getDuration()
	return o;
end
