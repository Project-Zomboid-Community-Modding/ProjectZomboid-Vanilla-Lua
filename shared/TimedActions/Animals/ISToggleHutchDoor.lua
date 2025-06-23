--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISToggleHutchDoor = ISBaseTimedAction:derive("ISToggleHutchDoor");

function ISToggleHutchDoor:isValid()
	return true;
end

function ISToggleHutchDoor:update()
	self.character:setIsAiming(false);
	self.character:faceThisObject(self.hutch)
end

function ISToggleHutchDoor:start()
	self:setActionAnim("Loot")
	self.character:reportEvent("EventLootItem")
	if self.hutch:isDoorClosed() then
		self.sound = self.character:playSound("ChickenCoopWoodOpen")
	else
		self.sound = self.character:playSound("ChickenCoopWoodClose")
	end
end

function ISToggleHutchDoor:stop()
    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISToggleHutchDoor:perform()
    self.character:stopOrTriggerSound(self.sound)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISToggleHutchDoor:complete()
	self.hutch:toggleDoor();
	self.hutch:sync()
	return true
end

function ISToggleHutchDoor:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 20
end

function ISToggleHutchDoor:new(character, hutch)
	local o = ISBaseTimedAction.new(self, character)
	o.hutch = hutch;
	o.maxTime = o:getDuration()
	o.stopOnAim = false;
	o.ignoreHandsWounds = true;
	o.retriggerLastAction = true;
	return o;
end
