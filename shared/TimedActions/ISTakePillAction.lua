--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakePillAction = ISBaseTimedAction:derive("ISTakePillAction");

local function predicateNotEmpty(item)
	return item:getCurrentUsesFloat() > 0
end

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

	-- fromRelaunch is added in ISTimedAction to not consume stuff again when we relaunch the action
	if not self.fromRelaunch and self.item:getRequireInHandOrInventory() and not (self.carLighter or self.openFlame) then
        local lighter = self:getRequiredItem()
        lighter:setUsedDelta(lighter:getCurrentUsesFloat() - lighter:getUseDelta())
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

function ISTakePillAction:getRequiredItem()
	if not self.item:getRequireInHandOrInventory() then
		return
	end
	local types = self.item:getRequireInHandOrInventory()
	for i=1,types:size() do
		local fullType = moduleDotType(self.item:getModule(), types:get(i-1))
		local item2 = self.character:getInventory():getFirstTypeEvalRecurse(fullType, predicateNotEmpty)
		if item2 then
			return item2
		end
	end
	return nil
end

function ISTakePillAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	if self.item:getEatTime() and self.item:getEatTime() > 0 then return self.item:getEatTime() end
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
    o.carLighter = item:hasTag("Smokable") and character:getVehicle() and character:getVehicle():canLightSmoke(character)
    o.openFlame = false;
    if item:hasTag("Smokable") then o.openFlame = ISInventoryPaneContextMenu.hasOpenFlame(character) end
	return o
end
