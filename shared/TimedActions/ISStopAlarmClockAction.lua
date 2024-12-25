--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISStopAlarmClockAction = ISBaseTimedAction:derive("ISStopAlarmClockAction");

function ISStopAlarmClockAction:isValid()
    return true;
end

function ISStopAlarmClockAction:update()
end

function ISStopAlarmClockAction:start()
end

function ISStopAlarmClockAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISStopAlarmClockAction:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISStopAlarmClockAction:complete()
	local item = self.alarm
	if instanceof(self.alarm, "IsoWorldInventoryObject") then
		item = self.alarm:getItem()
	end
	item:stopRinging()
	item:syncStopRinging()
	return true;
end

function ISStopAlarmClockAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 20
end

function ISStopAlarmClockAction:new(character, alarm)
	local o = ISBaseTimedAction.new(self, character);
	o.alarm = alarm;
	o.stopOnWalk = instanceof(alarm, "IsoWorldInventoryObject");
	o.stopOnRun = true;
	o.maxTime = o:getDuration();
	return o;
end
