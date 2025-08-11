--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPlaceTrap = ISBaseTimedAction:derive("ISPlaceTrap");

function ISPlaceTrap:isValid()
    if isClient() and self.weapon then
	    return self.character:getInventory():containsID(self.weapon:getID())
	else
	    return self.character:getInventory():contains(self.weapon);
	end
end

function ISPlaceTrap:update()
	self.weapon:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISPlaceTrap:start()
    if isClient() and self.weapon then
        self.weapon = self.character:getInventory():getItemById(self.weapon:getID())
    end
	self.weapon:setJobType(getText("ContextMenu_TrapPlace", self.weapon:getName()));
	self.weapon:setJobDelta(0.0);
	self:setOverrideHandModels(nil, nil)
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISPlaceTrap:stop()
	self.weapon:setJobDelta(0.0);
    ISBaseTimedAction.stop(self);
end

function ISPlaceTrap:perform()
	self.weapon:setJobDelta(0.0);

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPlaceTrap:complete()
	local trap = IsoTrap.new(self.character, self.weapon, self.square:getCell(), self.square);
	self.square:AddTileObject(trap);
	trap:transmitCompleteItemToClients();

	self.character:removeFromHands(self.weapon)
	self.character:getInventory():Remove(self.weapon);
	sendRemoveItemFromContainer(self.character:getInventory(), self.weapon);

	buildUtil.setHaveConstruction(self.square, true);
	return true;
end

function ISPlaceTrap:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISPlaceTrap:new(character, weapon)
	local o = ISBaseTimedAction.new(self, character);
    o.square = character:getCurrentSquare();
	o.weapon = weapon;
	o.maxTime = o:getDuration();
	return o;
end
