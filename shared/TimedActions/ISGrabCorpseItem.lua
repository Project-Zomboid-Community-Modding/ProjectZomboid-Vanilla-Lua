--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGrabCorpseItem = ISBaseTimedAction:derive("ISGrabCorpseItem")

function ISGrabCorpseItem:isValid()
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

function ISGrabCorpseItem:waitToStart()
	return self.character:shouldBeTurning()
end

function ISGrabCorpseItem:update()
	self.item:setJobDelta(self:getJobDelta())

	if self.item:getContainer():getParent() then
		self.character:faceThisObject(self.item:getContainer():getParent())
	end

	self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
end

function ISGrabCorpseItem:start()
	self.item:setJobType(getText("ContextMenu_Equip_Two_Hands"))
	self.item:setJobDelta(0.0)
	self:setActionAnim("Loot")
	self:setAnimVariable("LootPosition", "")
	self.character:clearVariable("LootPosition")
end

function ISGrabCorpseItem:stop()
	self.item:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISGrabCorpseItem:perform()
	self.item:setJobDelta(0.0)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISGrabCorpseItem:isAlreadyTransferred(item)
	return item:getContainer() == self.character:getInventory()
end

function ISGrabCorpseItem:complete()
	forceDropHeavyItems(self.character)

	local srcContainer = self.item:getContainer()
	srcContainer:DoRemoveItem(self.item)
	sendRemoveItemFromContainer(srcContainer, self.item)

	if srcContainer:getParent() and instanceof(srcContainer:getParent(), "BaseVehicle") and srcContainer:getParent():getPartById(srcContainer:getType()) then
		local part = srcContainer:getParent():getPartById(srcContainer:getType());
		part:setContainerContentAmount(part:getItemContainer():getCapacityWeight());
	end

	self.character:pickUpCorpseItem(self.item)

	if isClient() then
		ISInventoryPage.renderDirty = true
	end

	return true
end

function ISGrabCorpseItem:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function ISGrabCorpseItem:new(character, item)
	local o = ISBaseTimedAction.new(self, character);
	o.maxTime = o:getDuration()
	o.item = item
	return o
end	
