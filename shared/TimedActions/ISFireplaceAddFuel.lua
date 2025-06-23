--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFireplaceAddFuel = ISBaseTimedAction:derive("ISFireplaceAddFuel");

function ISFireplaceAddFuel:isValid()
    if self.fireplace:getFuelAmount() + self.fuelAmt > getCampingFuelMax() then return end
    if isClient() and self.item then
        return self.fireplace:getObjectIndex() ~= -1 and
            self.character:getInventory():containsID(self.item:getID())
    else
        return self.fireplace:getObjectIndex() ~= -1 and
            self.character:getInventory():contains(self.item)
    end
end

function ISFireplaceAddFuel:waitToStart()
	self.character:faceThisObject(self.fireplace)
	return self.character:shouldBeTurning()
end

function ISFireplaceAddFuel:update()
	self.character:faceThisObject(self.fireplace)
	self.item:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISFireplaceAddFuel:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self.item:setJobType(campingText.addFuel);
	self.item:setJobDelta(0.0);
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.sound = self.character:playSound("FireplaceAddFuel")
end

function ISFireplaceAddFuel:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.item:setJobDelta(0.0);
	ISBaseTimedAction.stop(self);
end

function ISFireplaceAddFuel:perform()
	self.character:stopOrTriggerSound(self.sound)

	self.item:setJobDelta(0.0);

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISFireplaceAddFuel:complete()
	if self.item:IsDrainable() then
		self.item:Use(false, false, true)
	else
		self.character:removeFromHands(self.item)
		self.character:getInventory():Remove(self.item)
		sendRemoveItemFromContainer(self.character:getInventory(), self.item);
	end

	if self.fireplace then
		self.fireplace:addFuel(self.fuelAmt)
		self.fireplace:sendObjectChange('state')
	end

	return true;
end

function ISFireplaceAddFuel:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 100
end

function ISFireplaceAddFuel:new(character, fireplace, item, fuelAmt)
	local o = ISBaseTimedAction.new(self, character);
	o.maxTime = o:getDuration();
	-- custom fields
	o.fireplace = fireplace
	o.fuelAmt = fuelAmt
	o.item = item;
	return o;
end
