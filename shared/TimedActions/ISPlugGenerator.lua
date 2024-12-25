--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPlugGenerator = ISBaseTimedAction:derive("ISPlugGenerator");

function ISPlugGenerator:isValid()
	return self.generator:getObjectIndex() ~= -1 and
		self.generator:isConnected() ~= self.plug
end

function ISPlugGenerator:waitToStart()
	self.character:faceThisObject(self.generator)
	return self.character:shouldBeTurning()
end

function ISPlugGenerator:update()
	self.character:faceThisObject(self.generator)
end

function ISPlugGenerator:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	self.sound = self.character:playSound("GeneratorConnect")
end

function ISPlugGenerator:stop()
	self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISPlugGenerator:perform()
	self.character:stopOrTriggerSound(self.sound)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPlugGenerator:complete()
	self.generator:setConnected(self.plug);
	return true;
end

function ISPlugGenerator:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 300
end

function ISPlugGenerator:new(character, generator, plug)
	local o = ISBaseTimedAction.new(self, character);
    o.plug = plug;
	o.generator = generator;
	o.maxTime = o:getDuration()
	return o;
end
