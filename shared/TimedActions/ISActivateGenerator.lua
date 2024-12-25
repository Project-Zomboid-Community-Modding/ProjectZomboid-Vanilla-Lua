--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISActivateGenerator = ISBaseTimedAction:derive("ISActivateGenerator");

function ISActivateGenerator:isValid()
	if self.activate == self.generator:isActivated() then return false end
	if self.activate and not self.generator:isConnected() or
			self.generator:getFuel() <= 0 or
			self.generator:getCondition() <= 0 then
		return false
	end
	return self.generator:getObjectIndex() ~= -1
end

function ISActivateGenerator:waitToStart()
	self.character:faceThisObject(self.generator)
	return self.character:shouldBeTurning()
end

function ISActivateGenerator:update()
	self.character:faceThisObject(self.generator)
end

function ISActivateGenerator:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
end

function ISActivateGenerator:stop()
    ISBaseTimedAction.stop(self);
end

function ISActivateGenerator:perform()

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISActivateGenerator:complete()
	if not self.generator then return end
	if self.activate and self.generator:getCondition() <= 50 and ZombRand(2) == 0 then
		self.generator:failToStart()
	else
		self.generator:setActivated(self.activate)
	end
	self.generator:sync()

	return true;
end

function ISActivateGenerator:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 30
end

function ISActivateGenerator:new(character, generator, activate)
	local o = ISBaseTimedAction.new(self, character);
	o.activate = activate;
	o.generator = generator;
	o.maxTime = o:getDuration()
	return o;
end
