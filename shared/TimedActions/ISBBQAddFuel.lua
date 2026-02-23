require "TimedActions/ISBaseTimedAction"

ISBBQAddFuel = ISBaseTimedAction:derive("ISBBQAddFuel");

function ISBBQAddFuel:isValid()
    if self.fireplace:getFuelAmount() + self.fuelAmt > getCampingFuelMax() then return end
    if isClient() then
        if self.item == nil or self.fireplace:getObjectIndex() == -1 then return false end
        if self.character:getInventory():containsID(self.item:getID()) then
            return true
        else
            self:forceComplete()
            return false
        end
    else
        return self.fireplace:getObjectIndex() ~= -1 and
            self.character:getInventory():contains(self.item)
    end
end

function ISBBQAddFuel:waitToStart()
	self.character:faceThisObject(self.fireplace)
	return self.character:shouldBeTurning()
end

function ISBBQAddFuel:update()
	self.character:faceThisObject(self.fireplace)
	self.item:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISBBQAddFuel:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self.item:setJobType(campingText.addFuel);
	self.item:setJobDelta(0.0);
	self:setActionAnim("Loot")
	local lootPosition = "Mid"
	local soundName = "BBQRegularAddFuel"
	if instanceof(self.fireplace, "IsoFireplace") then
        soundName = "FireplaceAddFuel"
        lootPosition = "Low"
    end
	self.character:SetVariable("LootPosition", lootPosition)
    local craftBenchSounds = self.fireplace:getComponent(ComponentType.CraftBenchSounds)
    if craftBenchSounds ~= nil then
        local soundName2 = craftBenchSounds:getSoundName("AddFuel", nil)
        if soundName2 ~= nil and soundName2 ~= "" then
            soundName = soundName2
        end
    end
	self.sound = self.character:playSound(soundName)
end

function ISBBQAddFuel:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.item:setJobDelta(0.0);
	ISBaseTimedAction.stop(self);
end

function ISBBQAddFuel:perform()
	self.character:stopOrTriggerSound(self.sound)

	self.item:setJobDelta(0.0);

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISBBQAddFuel:complete()
	if self.item:IsDrainable() and not self.item:hasTag(ItemTag.IS_FIRE_FUEL_SINGLE_USE) then
		self.item:Use(false, false, true)
	else
		self.character:removeFromHands(self.item)
		self.character:getInventory():Remove(self.item)
		sendRemoveItemFromContainer(self.character:getInventory(), self.item);
	end

	if self.fireplace then
		self.fireplace:addFuel(self.fuelAmt)
		self.fireplace:sendObjectChange(IsoObjectChange.STATE)
	end

	return true;
end

function ISBBQAddFuel:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 100
end

function ISBBQAddFuel:new(character, fireplace, item, fuelAmt)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration();
	-- custom fields
	o.fireplace = fireplace
	o.fuelAmt = fuelAmt
	o.item = item;
	return o;
end
