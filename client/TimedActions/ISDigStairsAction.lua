--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDigStairsAction = ISBaseTimedAction:derive("ISDigStairsAction");

function ISDigStairsAction:isValid()
	return self.character:getInventory():contains(self.item);
end

function ISDigStairsAction:update()
	self.item:setJobDelta(self:getJobDelta());
	self:setActionAnim(CharacterActionAnims.DigShovel);
	--self.character:setDir(self.dir);
end

function ISDigStairsAction:start()
	self.item:setJobType(getText("DiggingStairs"));
	self.item:setJobDelta(0.0);
	self:setOverrideHandModels(nil, self.item);
end

function ISDigStairsAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISDigStairsAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDigStairsAction:new (character, item, sq, dir, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.dir = dir;
	o.square = sq;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.maxTime = time;
	return o
end
