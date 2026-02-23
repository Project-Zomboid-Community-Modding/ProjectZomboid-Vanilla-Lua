require "TimedActions/ISBaseTimedAction"

ISClothingExtraAction = ISBaseTimedAction:derive("ISClothingExtraAction")

function ISClothingExtraAction:isValid()
    if not self.item or self.item:isBroken() then return false end
	return isClient() or self.character:getInventory():contains(self.item)
--	return self.character:isEquippedClothing(self.item)
end

function ISClothingExtraAction:waitToStart()
	return false
end

function ISClothingExtraAction:update()
	self.item:setJobDelta(self:getJobDelta());

	if not self.equipSound and self:getJobDelta() > 0.7 and self.item and self.item:getEquipSound() then
		self.equipSound = self.character:playSound(self.item:getEquipSound())
	end
end

function ISClothingExtraAction:start()
	if isClient() then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end
	self.item:setJobType(getText("ContextMenu_Wear"));
	self.item:setJobDelta(0.0);
	self:setActionAnim("WearClothing");
	if self.item:IsClothing() then
		local location = self.item:getBodyLocation()
		self:setAnimVariable("WearClothingLocation", WearClothingAnimations[location] or "")
	elseif self.item:IsInventoryContainer() and self.item:canBeEquipped() ~= "" then
		local location = self.item:canBeEquipped()
		self:setAnimVariable("WearClothingLocation", WearClothingAnimations[location] or "")
	end
	self.character:reportEvent("EventWearClothing");
end

function ISClothingExtraAction:stop()
	self:stopSound()
	self.item:setJobDelta(0.0);
	ISBaseTimedAction.stop(self)
end

function ISClothingExtraAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISClothingExtraAction:createItem(item, itemType)
	local newItem = instanceItem(itemType)
	return self:createItemNew(item, newItem)
end

function copyClothingItem(item, newItem)
    ISClothingExtraAction:createItemNew(item, newItem)
end

function ISClothingExtraAction:createItemNew(item, newItem)
	local visual = item:getVisual()
--	local newItem = instanceItem(itemType)
	local newVisual = newItem:getVisual()
	newVisual:setTint(visual:getTint(item:getClothingItem()))
	newVisual:setBaseTexture(visual:getBaseTexture())
	newVisual:setTextureChoice(visual:getTextureChoice())
	newVisual:setDecal(visual:getDecal(item:getClothingItem()))
	if newItem:IsInventoryContainer() and item:IsInventoryContainer() then
		newItem:getItemContainer():takeItemsFrom(item:getItemContainer())
		-- Handle renamed bag
		if item:getName() ~= item:getScriptItem():getDisplayName() then
			newItem:setName(item:getName())
		end
	end
--    newItem:setDirtiness(item:getDirtiness())
--    newItem:setTexture(item:getTexture())
	newItem:setColor(item:getColor())
	newVisual:copyDirt(visual)
	newVisual:copyBlood(visual)
	newVisual:copyHoles(visual)
	newVisual:copyPatches(visual)
	if newItem:IsClothing() then
		item:copyPatchesTo(newItem)
		newItem:setWetness(item:getWetness())
	end
	if instanceof(newItem, "AlarmClockClothing") and instanceof(item, "AlarmClockClothing") then
		newItem:setAlarmSet(item:isAlarmSet())
		newItem:setHour(item:getHour())
		newItem:setMinute(item:getMinute())
		newItem:syncAlarmClock()
		-- Network stuff
		-- FIXME: is this done when dropping the watch?
		item:setAlarmSet(false)
		item:syncAlarmClock()
	end
	if newItem:getFluidContainer() and item:getFluidContainer() then
       newItem:getFluidContainer():copyFluidsFrom(item:getFluidContainer())
	end
	newItem:setCondition(item:getCondition())
	newItem:setFavorite(item:isFavorite())
	if item:hasModData() then
		newItem:copyModData(item:getModData())
	end
	newItem:synchWithVisual()
	return newItem
end

function ISClothingExtraAction:perform()
	self:stopSound()
	self.item:setJobDelta(0.0);

	ISBaseTimedAction.perform(self)
end

function ISClothingExtraAction:complete()
	self.character:removeFromHands(self.item)
	self.character:removeWornItem(self.item, false)
	self.character:getInventory():Remove(self.item)
	sendRemoveItemFromContainer(self.character:getInventory(), self.item);

	local newItem = self:createItem(self.item, self.extra)
	self.character:getInventory():AddItem(newItem)
	sendAddItemToContainer(self.character:getInventory(), newItem);

	if newItem:IsInventoryContainer() and newItem:canBeEquipped() ~= "" then
		self.character:setWornItem(newItem:canBeEquipped(), newItem)
		sendClothing(self.character, newItem:canBeEquipped(), newItem);
	elseif newItem:IsClothing() then
		self.character:setWornItem(newItem:getBodyLocation(), newItem)
		sendClothing(self.character, newItem:getBodyLocation(), newItem);
	end
	syncVisuals(self.character)

	if newItem:hasTag(ItemTag.REPLACE_PRIMARY) then
		if self.character:getPrimaryHandItem() then
			self.character:removeFromHands(self.character:getPrimaryHandItem())
		end
		self.character:setPrimaryHandItem(newItem)
		sendEquip(self.character)
	end

    triggerEvent("OnClothingUpdated", self.character)

	return true
end

function ISClothingExtraAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end

	if not self.character:isEquippedClothing(self.item) then
		return 50
	end

	return 1
end

function ISClothingExtraAction:new(character, item, extra)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item
	o.extra = extra
	o.maxTime = o:getDuration();
	o.stopOnWalk = ISWearClothing.isStopOnWalk(item);
	return o
end
