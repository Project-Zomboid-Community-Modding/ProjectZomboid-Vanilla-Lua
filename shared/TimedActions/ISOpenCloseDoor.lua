--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenCloseDoor = ISBaseTimedAction:derive("ISOpenCloseDoor");

function ISOpenCloseDoor:isValid()
	return true;
end

function ISOpenCloseDoor:update()
	if not self.character:isAiming() then
		self.character:faceThisObject(self.item)
	end
end

function ISOpenCloseDoor:start()
	if not self.character:isAiming() then
		self.character:faceThisObject(self.item)
	end
end

function ISOpenCloseDoor:stop()
    ISBaseTimedAction.stop(self);
end

function ISOpenCloseDoor:perform()
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISOpenCloseDoor:complete()
	self.item:ToggleDoor(self.character);
	return true;
end

function ISOpenCloseDoor:getDuration()
	return 0;
end

function ISOpenCloseDoor:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.stopOnWalk = false;
	o.stopOnRun = false;
	o.stopOnAim = false;
	o.ignoreHandsWounds = true;
	o.retriggerLastAction = true; -- this is used when we for example eat something and open a door, the eat action is removed, but we store it in IsoPlayer.getTimedActionToRetrigger(), here we say to the queue "relaunch the previous action (eat)", it'll be relaunched at the delta it was saved
	o.maxTime = o:getDuration();
	return o;
end
