--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISClothingExtraAction = ISBaseTimedAction:derive("ISClothingExtraAction")

function ISClothingExtraAction:isValid()
	if isClient() and self.started then return true end
    if not self.item or self.item:isBroken() then return false end
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID())
    else
        return self.character:getInventory():contains(self.item)
    end
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

	if isClient() then
		if isItemTransactionDone(self.transactionId) then
			self:forceComplete();
		elseif isItemTransactionRejected(self.transactionId) then
			self:forceStop();
		end
	end

    if isClient() and self.maxTime == -1 then
        local duration = getItemTransactionDuration(self.transactionId)
        if duration > 0 then
            self.maxTime = duration
            self.action:setTime(self.maxTime)
        end
    end
end

function ISClothingExtraAction:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

	if not self.character:isEquippedClothing(self.item) then
		-- Same time as ISWearClothing
		self.maxTime = 50
		self.action:setTime(self.maxTime)
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
	self.started = true;
	self.transactionId = changeItemTypeTransaction(self.character, self.item, self.extra);
end

function ISClothingExtraAction:stop()
	self:stopSound()
	self.item:setJobDelta(0.0);
	ISBaseTimedAction.stop(self)
end

function ISClothingExtraAction:perform()
	self:stopSound()

	self.item:setJobDelta(0.0);
	local playerObj = self.character
	if isClient() then
		if self.item:IsInventoryContainer() and self.item:canBeEquipped() ~= "" then
			getPlayerInventory(playerObj:getPlayerNum()):refreshBackpacks();
		end
		ISBaseTimedAction.perform(self)
    else
        ISClothingExtraAction:performNew(playerObj, self.item, self.extra)
--         playerObj:removeFromHands(self.item)
--         playerObj:removeWornItem(self.item)
--         playerObj:getInventory():Remove(self.item)
--         local newItem = self:createItem(self.item, self.extra)
--         playerObj:getInventory():AddItem(newItem)
--         if newItem:IsInventoryContainer() and newItem:canBeEquipped() ~= "" then
--             playerObj:setWornItem(newItem:canBeEquipped(), newItem)
--             getPlayerInventory(self.character:getPlayerNum()):refreshBackpacks();
--         elseif newItem:IsClothing() then
--             playerObj:setWornItem(newItem:getBodyLocation(), newItem)
--         end
--         if newItem:hasTag("ReplacePrimary") then
--             if playerObj:getPrimaryHandItem() then
--                 playerObj:removeFromHands(playerObj:getPrimaryHandItem())
--             end
--             playerObj:setPrimaryHandItem(newItem)
--         end
--         triggerEvent("OnClothingUpdated", playerObj)

        ISBaseTimedAction.perform(self)
	end
end

function ISClothingExtraAction:performNew(playerObj, item, extra)
        playerObj:removeFromHands(item)
        playerObj:removeWornItem(item)
        playerObj:getInventory():Remove(item)
        local newItem = self:createItem(item, extra)
        playerObj:getInventory():AddItem(newItem)
        if newItem:IsInventoryContainer() and newItem:canBeEquipped() ~= "" then
            playerObj:setWornItem(newItem:canBeEquipped(), newItem)
            getPlayerInventory(playerObj:getPlayerNum()):refreshBackpacks();
        elseif newItem:IsClothing() then
            playerObj:setWornItem(newItem:getBodyLocation(), newItem)
        end
        if newItem:hasTag("ReplacePrimary") then
            if playerObj:getPrimaryHandItem() then
                playerObj:removeFromHands(playerObj:getPrimaryHandItem())
            end
            playerObj:setPrimaryHandItem(newItem)
        end
        triggerEvent("OnClothingUpdated", playerObj)
end

function ISClothingExtraAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISClothingExtraAction:createItem(item, itemType)
-- 	local visual = item:getVisual()

-- 	local newItem = InventoryItemFactory.CreateItem(itemType)
	local newItem = instanceItem(itemType)
	return self:createItemNew(item, newItem)
-- 	local newVisual = newItem:getVisual()
-- 	newVisual:setTint(visual:getTint(item:getClothingItem()))
-- 	newVisual:setBaseTexture(visual:getBaseTexture())
-- 	newVisual:setTextureChoice(visual:getTextureChoice())
-- 	newVisual:setDecal(visual:getDecal(item:getClothingItem()))
-- 	if newItem:IsInventoryContainer() and item:IsInventoryContainer() then
-- 		newItem:getItemContainer():setItems(item:getItemContainer():getItems())
-- 		-- Handle renamed bag
-- 		if item:getName() ~= item:getScriptItem():getDisplayName() then
-- 			newItem:setName(item:getName())
-- 		end
-- 	end
-- --    newItem:setDirtyness(item:getDirtyness())
-- --    newItem:setTexture(item:getTexture())
-- 	newItem:setColor(item:getColor())
-- 	newVisual:copyDirt(visual)
-- 	newVisual:copyBlood(visual)
-- 	newVisual:copyHoles(visual)
-- 	newVisual:copyPatches(visual)
-- 	if newItem:IsClothing() then
-- 		item:copyPatchesTo(newItem)
-- 		newItem:setWetness(item:getWetness())
-- 	end
-- 	if instanceof(newItem, "AlarmClockClothing") and instanceof(item, "AlarmClockClothing") then
-- 		newItem:setAlarmSet(item:isAlarmSet())
-- 		newItem:setHour(item:getHour())
-- 		newItem:setMinute(item:getMinute())
-- 		newItem:syncAlarmClock()
-- 		-- Network stuff
-- 		-- FIXME: is this done when dropping the watch?
-- 		item:setAlarmSet(false)
-- 		item:syncAlarmClock()
-- 	end
-- 	newItem:setCondition(item:getCondition())
-- 	newItem:setFavorite(item:isFavorite())
-- 	if item:hasModData() then
-- 		newItem:copyModData(item:getModData())
-- 	end
-- 	newItem:synchWithVisual()
-- 	return newItem
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
		newItem:getItemContainer():setItems(item:getItemContainer():getItems())
		-- Handle renamed bag
		if item:getName() ~= item:getScriptItem():getDisplayName() then
			newItem:setName(item:getName())
		end
	end
--    newItem:setDirtyness(item:getDirtyness())
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

function ISClothingExtraAction:new(character, item, extra)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = 1
	o.item = item
	o.extra = extra
	o.transactionId = 0
	if character:isTimedActionInstant() then
		o.maxTime = 1
	end
	if isClient() then
	    o.maxTime = -1
    end
	return o
end
