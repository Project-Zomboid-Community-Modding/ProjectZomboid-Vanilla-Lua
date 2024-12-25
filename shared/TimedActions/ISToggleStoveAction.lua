--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISToggleStoveAction = ISBaseTimedAction:derive("ISToggleStoveAction");

function ISToggleStoveAction:isValid()
	return self.object:getObjectIndex() ~= -1
end

function ISToggleStoveAction:update()
	self.character:faceThisObject(self.object)
end

function ISToggleStoveAction:start()
end

function ISToggleStoveAction:stop()
    ISBaseTimedAction.stop(self)
end

function ISToggleStoveAction:perform()
	self.object:PlayToggleSound();
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISToggleStoveAction:complete()
	self.object:Toggle()
	return true;
end

function ISToggleStoveAction:getDuration()
	return 1
end

function ISToggleStoveAction:new(character, object)
	local o = ISBaseTimedAction.new(self, character)
	o.object = object
	o.maxTime = o:getDuration()
	return o
end
