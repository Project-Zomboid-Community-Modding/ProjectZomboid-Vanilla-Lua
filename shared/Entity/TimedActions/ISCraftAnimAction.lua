--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
	TODO DEPRECATED
--]]

require "TimedActions/ISBaseTimedAction"

ISCraftAnimAction = ISBaseTimedAction:derive("ISCraftAnimAction");

function ISCraftAnimAction:isValid()
	--[[
	if (not self.entity) or (not self.entity:isUsingPlayer(self.character)) then
		return false;
	end
	if (not self.craftProcessor:getCurrentRecipe()) or (not self.craftProcessor:getCurrentRecipe()==self.recipe) then
		return false;
	end
	if (not self.actionScript) then
		return false;
	end
	return true;
	--]]
	return false;
end

function ISCraftAnimAction:update()
	--[[
	self.character:setMetabolicTarget(self.actionScript:getMetabolics());

	if self.actionScript:isFaceObject() then
		self.character:faceThisObject(self.entity);
	end
	--]]
end

function ISCraftAnimAction:start()
	--[[
	self.craftProcessor:getCraftCacheData():setTimedAction(self.action);

	self:setActionAnim(self.actionScript:getActionAnim());
	if self.actionScript:getAnimVarKey() then
		self:setAnimVariable(self.actionScript:getAnimVarKey(), self.actionScript:getAnimVarVal());
	end

	local cacheData = self.craftProcessor:getCraftCacheData();
	if cacheData then
		self:setOverrideHandModels(cacheData:getModelHandOne(), cacheData:getModelHandTwo());
	end
	--]]
end

function ISCraftAnimAction:stop()
    ISBaseTimedAction.stop(self);
	--[[
	self.craftProcessor:getCraftCacheData():setTimedAction(nil);
	if self.craftProcessor then
		self.craftProcessor:stop(nil, true);
	end
	--]]
end

function ISCraftAnimAction:perform()
	ISBaseTimedAction.perform(self);
	--[[
	self.craftProcessor:getCraftCacheData():setTimedAction(nil);
	--]]
end

--[[
function ISCraftProcessorAction:complete()
	return true
end
--]]

function ISCraftAnimAction:getCustomDelta()
	--[[
	if self.craftProcessor then
		return self.craftProcessor:getProgress();
	end
	--]]
	return 1.0;
end

function ISCraftAnimAction:getDuration()
	--[[
	if not self.recipe then
		return -1;
	end
	return self.recipe:getTime()*6*2;
	--]]
	return -1;
end

function ISCraftAnimAction:new(character, entity, component, craftProcessor, recipe)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	--[[
	o.entity = entity
	o.component = component;
	o.craftProcessor = craftProcessor;
	o.recipe = recipe;
	o.actionScript = recipe:getTimedActionScript();
	o.usesCustomDelta = true;
	--]]
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = o:getDuration();
	return o
end