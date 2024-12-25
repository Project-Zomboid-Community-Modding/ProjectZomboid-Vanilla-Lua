--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenCloseWindow = ISBaseTimedAction:derive("ISOpenCloseWindow");

function ISOpenCloseWindow:isValid()
	return true;
end

function ISOpenCloseWindow:waitToStart()
	self.character:faceThisObject(self.object)
	return self.character:shouldBeTurning()
end

function ISOpenCloseWindow:update()
end

function ISOpenCloseWindow:start()
end

function ISOpenCloseWindow:stop()
    ISBaseTimedAction.stop(self);
end

function ISOpenCloseWindow:perform()
    -- needed to remove from queue / start next.
	if self.object:IsOpen() then
		self.character:closeWindow(self.object)
	else
		self.character:openWindow(self.object)
	end

	ISBaseTimedAction.perform(self);
end

function ISOpenCloseWindow:complete()
--     self.item:ToggleWindow(self.character)
	return true;
end

function ISOpenCloseWindow:getDuration()
	return 1;
end

function ISOpenCloseWindow:new(character, object)
    local o = ISBaseTimedAction.new(self, character)
	o.object = object;
	o.maxTime = o:getDuration();
	o.useProgressBar = false;
	o.ignoreHandsWounds = true;
	return o;
end
