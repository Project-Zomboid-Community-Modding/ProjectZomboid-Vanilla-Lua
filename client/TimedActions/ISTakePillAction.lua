--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakePillAction = ISBaseTimedAction:derive("ISTakePillAction");

function ISTakePillAction:isValid()
	return self.character:getInventory():contains(self.item);
end

function ISTakePillAction:update()
	self.item:setJobDelta(self:getJobDelta());
	self:setActionAnim(CharacterActionAnims.TakePills);
end

function ISTakePillAction:start()
	self.item:setJobType(getText("ContextMenu_Take_pills"));
	self.item:setJobDelta(0.0);
	self:setOverrideHandModels(nil, self.item);
end

function ISTakePillAction:stop()
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISTakePillAction:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
	self.character:getBodyDamage():JustTookPill(self.item);
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISTakePillAction:new (character, item, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.maxTime = time;
	return o
end
