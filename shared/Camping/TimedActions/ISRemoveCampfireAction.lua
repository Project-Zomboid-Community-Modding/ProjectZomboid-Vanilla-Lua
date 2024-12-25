--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveCampfireAction = ISBaseTimedAction:derive("ISRemoveCampfireAction");

function ISRemoveCampfireAction:isValid()
	self.campfire:updateFromIsoObject()
	return self.campfire:getObject() ~= nil
end

function ISRemoveCampfireAction:waitToStart()
	self.character:faceThisObject(self.campfire:getObject())
	return self.character:shouldBeTurning()
end

function ISRemoveCampfireAction:update()
	self.character:faceThisObject(self.campfire:getObject())
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISRemoveCampfireAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
	self.character:reportEvent("EventLootItem");
end

function ISRemoveCampfireAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveCampfireAction:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRemoveCampfireAction:complete()
    local campfire = SCampfireSystem.instance:getLuaObjectAt(self.campfire.x, self.campfire.y, self.campfire.z)
    if campfire then
        SCampfireSystem:removeCampfire(campfire)
        local items = self.character:getInventory():AddItems("Base.Stone2", 3);
        sendAddItemsToContainer(self.character:getInventory(), items);
    end
	return true
end

function ISRemoveCampfireAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return self.maxTime;
end

function ISRemoveCampfireAction:new (character, campfire, maxTime)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = maxTime;
	-- custom fields
	o.campfire = campfire
	return o
end
