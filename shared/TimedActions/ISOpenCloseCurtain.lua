--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenCloseCurtain = ISBaseTimedAction:derive("ISOpenCloseCurtain");

function ISOpenCloseCurtain:isValid()
	return true;
end

function ISOpenCloseCurtain:waitToStart()
	self.character:faceThisObjectAlt(self.item)
	return self.character:shouldBeTurning()
end

function ISOpenCloseCurtain:update()
	self.character:faceThisObjectAlt(self.item)
end

function ISOpenCloseCurtain:start()
end

function ISOpenCloseCurtain:stop()
    ISBaseTimedAction.stop(self);
end

function ISOpenCloseCurtain:perform()
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISOpenCloseCurtain:complete()
	if instanceof(self.item, "IsoDoor") then
    		self.item:toggleCurtain()
    	else
    		self.item:ToggleDoor(self.character);
   	end

	return true;
end

function ISOpenCloseCurtain:getDuration()
	return 0;
end

function ISOpenCloseCurtain:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.ignoreHandsWounds = true;
	o.maxTime = o:getDuration();
	o.retriggerLastAction = true;
	return o;
end
