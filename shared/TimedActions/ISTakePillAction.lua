--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakePillAction = ISBaseTimedAction:derive("ISTakePillAction");

function ISTakePillAction:isValid()
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISTakePillAction:update()
	self.item:setJobDelta(self:getJobDelta());
-- 	if self.item:hasTag("eatBox") then
-- 	    self:setAnimVariable("FoodType", "eatBox");
	if self.item:getEatType() then
	    self:setAnimVariable("FoodType", self.item:getEatType());
		self:setActionAnim(CharacterActionAnims.Eat);
	else
	    self:setActionAnim(CharacterActionAnims.TakePills);
	end
end

function ISTakePillAction:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end
	if self.item:getCustomMenuOption() then
		self.item:setJobType(self.item:getCustomMenuOption())
	else
	    self.item:setJobType(getText("ContextMenu_Take_pills"));
	end

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
	-- check to see if it's a drainable before using
-- 	if instanceof(self.item, "DrainableComboItem") then
-- 		self.item:Use()
--     end
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISTakePillAction:complete()
	self.character:getBodyDamage():JustTookPill(self.item);
	if isServer() then
		sendPlayerEffects(self.character)
	end
	return true
end

function ISTakePillAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 165
end

function ISTakePillAction:new (character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.stopOnAim = false;
	o.maxTime = o:getDuration();
    o.isEating = true;
	return o
end
