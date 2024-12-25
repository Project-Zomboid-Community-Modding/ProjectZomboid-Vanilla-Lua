--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--todo deprecated
require "TimedActions/ISBaseTimedAction"

ISStartCraftProcessorAction = ISBaseTimedAction:derive("ISStartCraftProcessorAction");

function ISStartCraftProcessorAction:isValid()
	if (not self.entity) or (not self.entity:isUsingPlayer(self.character)) then
		return false;
	end
	if (not self.craftProcessor) or (not self.craftProcessor:getStartMode()==StartMode.Manual) then
		return false;
	end
	if not self.craftProcessor:canStart(self.character) then
		return false;
	end
	return true;
end

function ISStartCraftProcessorAction:update()
	self.character:faceThisObject(self.entity)
end

function ISStartCraftProcessorAction:start()
end

function ISStartCraftProcessorAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISStartCraftProcessorAction:perform()
	ISBaseTimedAction.perform(self);

	if self.craftProcessor:canStart(self.character) then
        self.craftProcessor:start(self.character);

		--[[
        local recipe = self.craftProcessor:getCurrentRecipe();
        if not recipe then return end
        local actionScript = recipe:getTimedActionScript();

        if actionScript then
            ISTimedActionQueue.clear(self.character);
            local action = ISCraftAnimAction:new(self.character, self.entity, self.component, self.craftProcessor, recipe);
            self.craftProcessor:getCraftCacheData():setTimedAction(action.action);
            ISTimedActionQueue.add(action);
        end
		--]]
	end
end

--[[
function ISCraftProcessorAction:complete()
	return true
end
--]]


function ISStartCraftProcessorAction:getDuration()
	return 5;
end

function ISStartCraftProcessorAction:new(character, entity, component, craftProcessor)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.entity = entity
	o.component = component;
	o.craftProcessor = craftProcessor;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = o:getDuration();
	return o
end