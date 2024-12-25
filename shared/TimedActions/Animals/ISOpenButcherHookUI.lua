--***********************************************************
--**                    THE INDIE STONE                    **
--** this is just needed because of a walkto prior to that **
--***********************************************************



require "TimedActions/ISBaseTimedAction"

ISOpenButcherHookUI = ISBaseTimedAction:derive("ISOpenButcherHookUI");

function ISOpenButcherHookUI:isValid()
	return self.character:getSquare():DistToProper(self.hook:getSquare()) < 2;
end

function ISOpenButcherHookUI:waitToStart()
	self.character:faceThisObject(self.hook)
	return self.character:shouldBeTurning()
end

function ISOpenButcherHookUI:update()
	self.character:faceThisObject(self.hook)
	--self.animal:faceThisObject(self.character);
end

function ISOpenButcherHookUI:start()

end

function ISOpenButcherHookUI:forceStop()
	self.action:forceStop();
end

function ISOpenButcherHookUI:stop()
    ISBaseTimedAction.stop(self);
end

function ISOpenButcherHookUI:perform()

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISOpenButcherHookUI:complete()
	local ui = ISButcherHookUI:new(100, 100, 650, 500, self.hook, self.player)
	ui:initialise();
	ui:addToUIManager();
	return true
end

function ISOpenButcherHookUI:getDuration()
	--if self.character:isTimedActionInstant() then
	--	return 1
	--end
	return 1
end

function ISOpenButcherHookUI:serverStart()
end

function ISOpenButcherHookUI:animEvent(event, parameter)
end

function ISOpenButcherHookUI:new(character, hook)
	local o = ISBaseTimedAction.new(self, character)
	o.hook = hook;
	o.player = character;
	o.maxTime = o:getDuration()
	o.useProgressBar = false;
	return o;
end
