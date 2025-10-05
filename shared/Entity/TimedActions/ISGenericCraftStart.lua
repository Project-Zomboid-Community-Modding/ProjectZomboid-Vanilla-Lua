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
    local craftBenchSounds = self.entity:getComponent(ComponentType.CraftBenchSounds)
    if craftBenchSounds ~= nil then
        local soundName = craftBenchSounds:getSoundName("StartCraft", nil)
        if soundName ~= nil and soundName ~= "" then
            self.sound = self.character:playSound(soundName)
        end
    end
end

function ISGenericCraftStart:stop()
    self:stopSound()
    ISBaseTimedAction.stop(self);
end

function ISGenericCraftStart:perform()
    self:stopSound()
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

function ISGenericCraftStart:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
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