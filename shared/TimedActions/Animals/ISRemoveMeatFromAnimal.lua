--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveMeatFromAnimal = ISBaseTimedAction:derive("ISRemoveMeatFromAnimal");

function ISRemoveMeatFromAnimal:isValid()
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
end

function ISRemoveMeatFromAnimal:stop()
	self.luaHook.doingAction = false;

    ISBaseTimedAction.stop(self);
end

function ISRemoveMeatFromAnimal:perform()
	self.luaHook.doingAction = false;

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveMeatFromAnimal:complete()
	self.luaHook.doingAction = false;

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

	for i=0,bloodGround do
		addBloodSplat(self.hook:getSquare(), 2, ZombRandFloat(-0.3, 0.3), ZombRandFloat(-0.3, 0.3))
	end

	-- xp for this is done in the addAnimalPart as it'll depend on quantity/quality
	self.body:getModData()["BloodQty"] = 0;
	self.body:getModData()["parts"] = nil;
	self.luaHook:updateCorpseDatas();

	return true
end

function ISRemoveMeatFromAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 450 - (self.perkLevel * 15);
end

function ISRemoveMeatFromAnimal:new(character, body, hook, luaHook)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHook;
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.maxTime = o:getDuration()
	return o;
end
