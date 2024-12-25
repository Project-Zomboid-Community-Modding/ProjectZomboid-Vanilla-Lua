--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISToggleHutchEggHatchDoor = ISBaseTimedAction:derive("ISToggleHutchEggHatchDoor");

function ISToggleHutchEggHatchDoor:isValid()
	return true;
end

function ISToggleHutchEggHatchDoor:update()
	self.character:faceThisObject(self.hutch)
end

function ISToggleHutchEggHatchDoor:start()
	self:setActionAnim("Loot")
	self.character:reportEvent("EventLootItem")
	if self.hutch:isEggHatchDoorOpen() then
		self.sound = self.character:playSound("ChickenCoopMetalClose")
	else
		self.sound = self.character:playSound("ChickenCoopMetalOpen")
	end
end

function ISToggleHutchEggHatchDoor:stop()
    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISToggleHutchEggHatchDoor:perform()
    self.character:stopOrTriggerSound(self.sound)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISToggleHutchEggHatchDoor:complete()
	self.hutch:toggleEggHatchDoor();
	self.hutch:sync()
	return true
end

function ISToggleHutchEggHatchDoor:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 30
end

function ISToggleHutchEggHatchDoor:new(character, hutch)
	local o = ISBaseTimedAction.new(self, character)
	o.hutch = hutch;
	o.maxTime = o:getDuration()
	return o;
end
