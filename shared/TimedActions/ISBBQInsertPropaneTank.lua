--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISBBQInsertPropaneTank = ISBaseTimedAction:derive("ISBBQInsertPropaneTank");

function ISBBQInsertPropaneTank:isValid()
	if instanceof(self.tank, "IsoWorldInventoryObject") then
		return self.bbq:getObjectIndex() ~= -1 and self.tank:getWorldObjectIndex() ~= -1
	end
	if isClient() and self.tank then
        return self.bbq:getObjectIndex() ~= -1 and
            self.character:getInventory():containsID(self.tank:getID())
    else
        return self.bbq:getObjectIndex() ~= -1 and
            self.character:getInventory():contains(self.tank)
    end
end

function ISBBQInsertPropaneTank:waitToStart()
	self.character:faceThisObject(self.bbq)
	return self.character:shouldBeTurning()
end

function ISBBQInsertPropaneTank:update()
	self.character:faceThisObject(self.bbq)
    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISBBQInsertPropaneTank:start()
	if not instanceof(self.tank, "IsoWorldInventoryObject") then
		if isClient() and self.tank then
			self.tank = self.character:getInventory():getItemById(self.tank:getID())
		end
	end
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
	self.sound = self.character:playSound("BBQPropaneTankInsert")
end

function ISBBQInsertPropaneTank:stop()
	self.character:stopOrTriggerSound(self.sound)
	ISBaseTimedAction.stop(self);
end

function ISBBQInsertPropaneTank:perform()
	self.character:stopOrTriggerSound(self.sound)


	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISBBQInsertPropaneTank:complete()
	local tank = self.tank
	if instanceof(self.tank, "IsoWorldInventoryObject") then
		tank = self.tank:getItem()
		self.tank:getSquare():transmitRemoveItemFromSquare(self.tank)
	else
		self.character:removeFromHands(self.tank)
		self.character:getInventory():Remove(self.tank) -- TODO: server controls inventory
		sendRemoveItemFromContainer(self.character:getInventory(), self.tank);
	end
	local delta = tank:getCurrentUsesFloat()
	if self.bbq then
		local tank = self.bbq:removePropaneTank()
		if tank then
			self.character:getSquare():AddWorldInventoryItem(tank, 0.5, 0.5, 0)
		end
		tank = instanceItem("Base.PropaneTank")
		tank:setUsedDelta(delta)
		self.bbq:setPropaneTank(tank)
		self.bbq:sendObjectChange('state')
	end

	return true;
end

function ISBBQInsertPropaneTank:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 100
end

function ISBBQInsertPropaneTank:new (character, bbq, tank)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	-- custom fields
	o.bbq = bbq
	o.tank = tank
	return o
end
