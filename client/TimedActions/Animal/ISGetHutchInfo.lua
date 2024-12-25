--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGetHutchInfo = ISBaseTimedAction:derive("ISGetHutchInfo");

function ISGetHutchInfo:isValid()
	return true;
end

function ISGetHutchInfo:update()
	self.character:setIsAiming(false);
	self.character:faceThisObject(self.hutch)
end

function ISGetHutchInfo:start()
end

function ISGetHutchInfo:stop()
    ISBaseTimedAction.stop(self);
end

function ISGetHutchInfo:perform()
	local ui = ISHutchUI:new(100, 100, 600, 500, self.hutch, self.character)
	ui:initialise();
	ui:addToUIManager();
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISGetHutchInfo:new(character, hutch)
	local o = ISBaseTimedAction.new(self, character)
	o.hutch = hutch;
	o.maxTime = 1
	o.stopOnAim = false;
	return o;
end
