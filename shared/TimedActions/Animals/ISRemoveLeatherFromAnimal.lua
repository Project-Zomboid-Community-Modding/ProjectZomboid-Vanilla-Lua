--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveLeatherFromAnimal = ISBaseTimedAction:derive("ISRemoveLeatherFromAnimal");

function ISRemoveLeatherFromAnimal:isValid()
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
end

function ISRemoveLeatherFromAnimal:stop()
	self.luaHook.doingAction = false;

    ISBaseTimedAction.stop(self);
end

function ISRemoveLeatherFromAnimal:perform()
	self.luaHook.doingAction = false;

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveLeatherFromAnimal:complete()
	self.luaHook.doingAction = false;

	local leather = ButcheringUtil.getLeather(self.body:getTypeAndBreed());
	-- TODO Leather quality maybe? (this gonna be screwed by the craftProcessor for now anyway)
	if leather then
		local leatherItem = self.character:getInventory():AddItem(leather);
	end

    addXp(self.character, Perks.Butchering, self.xp * 3);
	self.body:getModData()["leather"] = nil;
	self.body:getModData()["skinned"] = true;
	self.hook:getAnimal():getModData()["skinned"] = true;
	-- don't try and change the model on the fly it makes things weiiiird, so i'm recreating stuff
	self.luaHook:resetCorpse();
	self.luaHook:updateCorpseDatas();

	return true
end

function ISRemoveLeatherFromAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 400 - (self.perkLevel * 15);
end

function ISRemoveLeatherFromAnimal:new(character, body, hook, luaHook)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHook;
	o.animalDef = ButcheringUtil.getAnimalDef(body:getTypeAndBreed())
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.xp = o.animalDef.xpPerItem;
	o.maxTime = o:getDuration()
	return o;
end
