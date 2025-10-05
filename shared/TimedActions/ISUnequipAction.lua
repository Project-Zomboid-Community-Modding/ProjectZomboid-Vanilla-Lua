--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISUnequipAction = ISBaseTimedAction:derive("ISUnequipAction");

function ISUnequipAction:isValid()
	if isClient() and self.item then
	    return true
	else
	    return self.character:getPrimaryHandItem() == self.item or self.character:getSecondaryHandItem() == self.item or self.character:getWornItems():contains(self.item)
	end
end

function ISUnequipAction:update()
	self.item:setJobDelta(self:getJobDelta());
end

function ISUnequipAction:start()
	self.item:setJobType(getText("ContextMenu_Unequip") .. " " .. self.item:getName());
	self.item:setJobDelta(0.0);
	if self.fromHotbar then
		self.character:setVariable("AttachItemSpeed", self.animSpeed)
		self.hotbar:setAttachAnim(self.item);
		self:setActionAnim("AttachItem")
		self:setOverrideHandModels(self.item, nil)
		self.character:reportEvent("EventAttachItem");
	elseif self.item:IsClothing() then
		self:setActionAnim("WearClothing");
		local location = self.item:getBodyLocation()
		self:setAnimVariable("WearClothingLocation", WearClothingAnimations[location] or "")
		self.character:reportEvent("EventWearClothing");
		if not self.item:getUnequipSound() then
			self.sound = self.character:playSound("RummageInInventory")
			-- FIXME: RummageInInventory uses ActionProgressPercent but doesn't stop playing when it is set to 100.
			self.soundNoTrigger = true
		end
	elseif self.item:IsInventoryContainer() and self.item:canBeEquipped() ~= "" then
		self:setActionAnim("WearClothing");
		local location = self.item:canBeEquipped()
		self:setAnimVariable("WearClothingLocation", WearClothingAnimations[location] or "")
	else
		self:setActionAnim("UnequipItem");
	end
	if self.item:getUnequipSound() then
		self.sound = self.character:getEmitter():playSound(self.item:getUnequipSound())
	end
end

function ISUnequipAction:stop()
	if self.sound then
        if self.soundNoTrigger then
            self.character:stopSound(self.sound)
        else
		    self.character:stopOrTriggerSound(self.sound)
        end
	end
    self.item:setJobDelta(0.0);
    ISBaseTimedAction.stop(self);
end

function ISUnequipAction:animEvent(event, parameter)
	if event == 'attachConnect' then
		local hotbar = getPlayerHotbar(self.character:getPlayerNum());
		hotbar.chr:setAttachedItem(self.item:getAttachedToModel(), self.item);
		self:setOverrideHandModels(nil, nil)
		if self.maxTime == -1 then
			self:forceComplete()
		end
	end
end

function ISUnequipAction:perform()
	if self.sound then
		if self.item:getUnequipSound() == "CorpseDrop" then
		elseif self.soundNoTrigger then
            self.character:getEmitter():stopSound(self.sound)
        else
			self.character:stopOrTriggerSound(self.sound)
		end
	end

	if self.item:getContainer() ~= nil then -- for heavy items
		self.item:getContainer():setDrawDirty(true);
	end
    self.item:setJobDelta(0.0);

	if self.item:IsInventoryContainer() or self.item:hasTag("Wearable") then
		getPlayerInventory(self.character:getPlayerNum()):refreshBackpacks();
	end

	triggerEvent("OnClothingUpdated", self.character)

	if self.fromHotbar then
		local hotbar = getPlayerHotbar(self.character:getPlayerNum());
		hotbar.chr:setAttachedItem(self.item:getAttachedToModel(), self.item);
		self:setOverrideHandModels(nil, nil)
	end


	-- if it was an animal corpse, drop it
	if self.item:getType() == "CorpseAnimal" and self.character:getCurrentSquare() then
		if self.item:getContainer() then
			self.item:getContainer():Remove(self.item);
		end
		self.character:getCurrentSquare():AddWorldInventoryItem(self.item, 0,0,0, true);
	end

	ISInventoryPage.renderDirty = true

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISUnequipAction:complete()
	self.character:removeWornItem(self.item)
	if instanceof(self.item, "HandWeapon") and self.item:canBeActivated() then
		self.item:setActivated(false)
	end

	if self.item == self.character:getPrimaryHandItem() then
		if (self.item:isTwoHandWeapon() or self.item:isRequiresEquippedBothHands()) and self.item == self.character:getSecondaryHandItem() then
			self.character:setSecondaryHandItem(nil);
		end
		self.character:setPrimaryHandItem(nil);
	end
	if self.item == self.character:getSecondaryHandItem() then
		if (self.item:isTwoHandWeapon() or self.item:isRequiresEquippedBothHands()) and self.item == self.character:getPrimaryHandItem() then
			self.character:setPrimaryHandItem(nil);
		end
		self.character:setSecondaryHandItem(nil);
	end

	sendEquip(self.character)

	triggerEvent("OnClothingUpdated", self.character)
	if isForceDropHeavyItem(self.item) then
		self.character:getInventory():Remove(self.item);
		sendRemoveItemFromContainer(self.character:getInventory(), self.item)
		local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(self.character, self.character:getCurrentSquare(), self.item)
		self.character:getCurrentSquare():AddWorldInventoryItem(self.item, dropX, dropY, dropZ)
	end

	if isClient() then
		ISInventoryPage.renderDirty = true
	end

	return true
end

function ISUnequipAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    if isServer() then
        return self.maxTime
    else
        if self.fromHotbar then
            return -1
        else
            return self.maxTime
        end
    end
end

function ISUnequipAction:new(character, item, maxTime)
	local o = ISBaseTimedAction.new(self, character);
	o.item = item;
	o.stopOnAim = false;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.maxTime = maxTime;
	o.ignoreHandsWounds = true;
	o.clothingAction = true;

	if not isServer() then
		o.hotbar = getPlayerHotbar(character:getPlayerNum());
		if o.hotbar then
			o.fromHotbar = o.hotbar:isItemAttached(item);
		else
			o.fromHotbar = false;
		end
		o.useProgressBar = not o.fromHotbar;
		if o.maxTime > 1 and o.fromHotbar then
			o.animSpeed = o.maxTime / o:adjustMaxTime(o.maxTime)
		else
			o.animSpeed = 1.0
		end
	end
	return o;
end
