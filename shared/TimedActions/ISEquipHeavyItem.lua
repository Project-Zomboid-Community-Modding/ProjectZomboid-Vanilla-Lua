--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISEquipHeavyItem = ISBaseTimedAction:derive("ISEquipHeavyItem")

function ISEquipHeavyItem:isValid()
	if not self.item:getContainer() or not self.item:getContainer():contains(self.item) then
		return false
	end
	if self.character:isItemInBothHands(self.item) then
		return false
	end

	local part = self.item:getContainer():getVehiclePart()
	if part and not part:getVehicle():canAccessContainer(part:getIndex(), self.character) then
		return false
	end

	return true
end

function ISEquipHeavyItem:waitToStart()
	return self.character:shouldBeTurning()
end

function ISEquipHeavyItem:update()
	self.item:setJobDelta(self:getJobDelta())

	if self.item:getContainer():getParent() then
		self.character:faceThisObject(self.item:getContainer():getParent())
	end

	self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
end

function ISEquipHeavyItem:start()
	self.item:setJobType(getText("ContextMenu_Equip_Two_Hands"))
	self.item:setJobDelta(0.0)
	self:setActionAnim("Loot")
	self:setAnimVariable("LootPosition", "")
	self.character:clearVariable("LootPosition")
end

function ISEquipHeavyItem:stop()
	self.item:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISEquipHeavyItem:perform()
	self.item:setJobDelta(0.0)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISEquipHeavyItem:isAlreadyTransferred(item)
	return item:getContainer() == self.character:getInventory()
end

function ISEquipHeavyItem:complete()
	forceDropHeavyItems(self.character)

	local srcContainer = self.item:getContainer()
	srcContainer:DoRemoveItem(self.item)
	sendRemoveItemFromContainer(srcContainer, self.item)

	if srcContainer:getParent() and instanceof(srcContainer:getParent(), "BaseVehicle") and srcContainer:getParent():getPartById(srcContainer:getType()) then
		local part = srcContainer:getParent():getPartById(srcContainer:getType());
		part:setContainerContentAmount(part:getItemContainer():getCapacityWeight());
	end

	self.character:getInventory():AddItem(self.item)
	sendAddItemToContainer(self.character:getInventory(), self.item);

	self.character:setPrimaryHandItem(self.item)
	self.character:setSecondaryHandItem(self.item)

	if isClient() then
		ISInventoryPage.renderDirty = true
	end

	if isServer() then
		sendEquip(self.character)
	end

	return true
end

function ISEquipHeavyItem:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function ISEquipHeavyItem:new(character, item)
	local o = ISBaseTimedAction.new(self, character);
	o.maxTime = o:getDuration()
	o.item = item
	return o
end	
