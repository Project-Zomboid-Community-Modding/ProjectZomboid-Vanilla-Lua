--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPutAnimalOnHook = ISBaseTimedAction:derive("ISPutAnimalOnHook");

function ISPutAnimalOnHook:isValid()
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
end

function ISPutAnimalOnHook:stop()
    ISBaseTimedAction.stop(self);
end

function ISPutAnimalOnHook:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPutAnimalOnHook:complete()
	self.luaHook:onAddedCorpse(self.body);

	return true
end

function ISPutAnimalOnHook:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 250 - (self.perkLevel * 10);
end

function ISPutAnimalOnHook:new(character, body, hook, luaHook)
	local o = ISBaseTimedAction.new(self, character)
	o.body = body;
	o.hook = hook;
	o.luaHook = luaHook;
	o.perkLevel = character:getPerkLevel(Perks.Butchering);
	o.maxTime = o:getDuration()
	return o;
end
