--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGenericCraftStart = ISBaseTimedAction:derive("ISGenericCraftStart");

function ISGenericCraftStart:isValid()
	if (not self.entity) or (not self.entity:isUsingPlayer(self.character)) then
		return false;
	end
	if not self.funcCanStart(self.character, self.entity, self.component) then
		return false;
	end
	return true;
end

function ISGenericCraftStart:update()
	self.character:faceThisObject(self.entity)
end

function ISGenericCraftStart:start()
end

function ISGenericCraftStart:stop()
    ISBaseTimedAction.stop(self);
end

function ISGenericCraftStart:perform()
	ISBaseTimedAction.perform(self);

	if self.funcCanStart(self.character, self.entity, self.component) then
        self.funcStart(self.character, self.entity, self.component);
	end
end

--[[
function ISGenericCraftStart:complete()
	return true
end
--]]


function ISGenericCraftStart:getDuration()
	return 5;
end

function ISGenericCraftStart:new(character, entity, component, funcCanStart, funcStart)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.entity = entity
	o.component = component;
	o.funcCanStart = funcCanStart;
	o.funcStart = funcStart;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = o:getDuration();
	return o
end