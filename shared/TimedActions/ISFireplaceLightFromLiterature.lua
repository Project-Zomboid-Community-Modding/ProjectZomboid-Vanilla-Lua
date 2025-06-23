--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFireplaceLightFromLiterature = ISBaseTimedAction:derive("ISFireplaceLightFromLiterature")

function ISFireplaceLightFromLiterature:isValid()
    if isClient() and self.item and self.lighter then
        return self.fireplace:getObjectIndex() ~= -1  and
            self.character:getInventory():containsID(self.lighter:getID()) and
            self.character:getInventory():containsID(self.item:getID()) and
            not self.fireplace:isLit()
    else
        return self.fireplace:getObjectIndex() ~= -1  and
            self.character:getInventory():contains(self.lighter) and
            self.character:getInventory():contains(self.item) and
            not self.fireplace:isLit()
    end
end

function ISFireplaceLightFromLiterature:waitToStart()
	self.character:faceThisObject(self.fireplace)
	return self.character:shouldBeTurning()
end

function ISFireplaceLightFromLiterature:update()
	self.character:faceThisObject(self.fireplace)
	self.item:setJobDelta(self:getJobDelta())
	self.lighter:setJobDelta(self:getJobDelta())
end

function ISFireplaceLightFromLiterature:start()
    if isClient() and self.item and self.lighter then
        self.item = self.character:getInventory():getItemById(self.item:getID())
        self.lighter = self.character:getInventory():getItemById(self.lighter:getID())
    end
	self.item:setJobType(campingText.lightCampfire)
	self.item:setJobDelta(0.0)
	self.lighter:setJobType(campingText.lightCampfire)
	self.lighter:setJobDelta(0.0)
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.sound = self.character:playSound("FireplaceLight")
end

function ISFireplaceLightFromLiterature:stop()
	self.character:stopOrTriggerSound(self.sound)
	self.item:setJobDelta(0.0)
	self.lighter:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISFireplaceLightFromLiterature:perform()
	self.character:stopOrTriggerSound(self.sound)
	self.item:getContainer():setDrawDirty(true)
    self.item:setJobDelta(0.0)
	self.lighter:setJobDelta(0.0)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISFireplaceLightFromLiterature:complete()
	self.character:getInventory():Remove(self.item)
	sendRemoveItemFromContainer(self.character:getInventory(), self.item);
	self.lighter:Use(false, false, true)

	if self.fireplace then
		if self.fuelAmt then
			self.fireplace:addFuel(self.fuelAmt)
		end
		if not self.fireplace:isLit() and self.fireplace:hasFuel() then
			self.fireplace:setLit(true)
			if self.fireplace:getContainer() then
				self.fireplace:getContainer():addItemsToProcessItems()
			end
		end
		self.fireplace:sendObjectChange('state')
	end
	return true
end

function ISFireplaceLightFromLiterature:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 100
end

function ISFireplaceLightFromLiterature:new(character, item, lighter, fireplace)
	local o = ISBaseTimedAction.new(self, character);
	o.maxTime = o:getDuration()
	-- custom fields
	o.fireplace = fireplace
	o.item = item
	o.lighter = lighter
-- 	o.fuelAmt = fuelAmt
    o.fuelAmt = ISCampingMenu.getFuelDurationForItem(item);
	return o
end
