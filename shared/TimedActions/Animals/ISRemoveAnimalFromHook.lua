--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveAnimalFromHook = ISBaseTimedAction:derive("ISRemoveAnimalFromHook");

function ISRemoveAnimalFromHook:isValid()
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
end

function ISRemoveAnimalFromHook:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveAnimalFromHook:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveAnimalFromHook:complete()
	self.luaHook:onClickRemoveCorpse(self.body);

	return true
end

function ISRemoveAnimalFromHook:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 250 - (self.perkLevel * 10);
end

function ISRemoveAnimalFromHook:new(character, body, hook, luaHook)
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
