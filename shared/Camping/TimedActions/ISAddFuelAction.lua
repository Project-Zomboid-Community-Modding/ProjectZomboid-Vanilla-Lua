--***********************************************************
--**                    TIM BAKER                          **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddFuelAction = ISBaseTimedAction:derive("ISAddFuelAction");

function ISAddFuelAction:isValid()
	self.campfire:updateFromIsoObject()
	if isClient() and self.item then
        return self.campfire:getObject() and
            self.character:getInventory():containsID(self.item:getID())
	else
        return self.campfire:getObject() and
            self.character:getInventory():contains(self.item)
	end
end

function ISAddFuelAction:waitToStart()
	self.character:faceThisObject(self.campfire:getObject())
	return self.character:shouldBeTurning()
end

function ISAddFuelAction:update()
	self.item:setJobDelta(self:getJobDelta());
	self.character:faceThisObject(self.campfire:getObject())
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISAddFuelAction:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self.item:setJobType(campingText.addFuel);
	self.item:setJobDelta(0.0);
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem");
	self.sound = self.character:playSound("CampfireAddFuel")
end

function ISAddFuelAction:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.item:setJobDelta(0.0);
	ISBaseTimedAction.stop(self);
end

function ISAddFuelAction:perform()
	self.character:stopOrTriggerSound(self.sound)

	self.item:setJobDelta(0.0);

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISAddFuelAction:complete()
	if self.item:IsDrainable() then
		self.item:UseAndSync()
	else
		self.character:removeFromHands(self.item)
		self.character:getInventory():Remove(self.item)
        sendRemoveItemFromContainer(self.character:getInventory(),self.item)
	end
	local campfire = SCampfireSystem.instance:getLuaObjectAt(self.campfire.x, self.campfire.y, self.campfire.z)
    if campfire then
        campfire:addFuel(self.fuelAmt)
    end
    return true
end

function ISAddFuelAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 100;
end

function ISAddFuelAction:new(character, campfire, item, fuelAmt)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = o:getDuration();
	-- custom fields
	o.campfire = campfire
	o.fuelAmt = fuelAmt
	o.item = item;
	return o;
end
