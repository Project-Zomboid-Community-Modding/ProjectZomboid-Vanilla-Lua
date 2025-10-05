--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISEquipWeaponAction = ISBaseTimedAction:derive("ISEquipWeaponAction");

function ISEquipWeaponAction:isValid()
    local invItem = self.character:getInventory():getItemWithID(self.item:getID())
    if invItem then
        self.item = invItem
        return true;
    else 
        return false
    end
end

function ISEquipWeaponAction:update()
	self.item:setJobDelta(self:getJobDelta());
end

function ISEquipWeaponAction:start()
	if self:isAlreadyEquipped(self.item) then
		self:forceComplete()
		return
	end
    if self.primary then
	    self.item:setJobType(getText("ContextMenu_Equip_Primary") .. " " .. self.item:getName());
    else
        self.item:setJobType(getText("ContextMenu_Equip_Secondary") .. " " .. self.item:getName());
    end
    if self.twoHands then
        self.item:setJobType(getText("ContextMenu_Equip_Two_Hands") .. " " .. self.item:getName());
    end
	self.item:setJobDelta(0.0);
	
	if self.fromHotbar then
		self.character:setVariable("AttachItemSpeed", self.animSpeed)
		self.hotbar:setAttachAnim(self.item);
		self:setActionAnim("DetachItem")
		self.character:reportEvent("EventAttachItem");
	else
		self:setActionAnim("EquipItem");
		self.character:reportEvent("EventAttachItem");
	end
	if self.item:getEquipSound() then
		self.sound = self.character:getEmitter():playSound(self.item:getEquipSound())
	end
end

function ISEquipWeaponAction:animEvent(event, parameter)
	if event == 'detachConnect' then
		local hotbar = getPlayerHotbar(self.character:getPlayerNum());
		hotbar.chr:removeAttachedItem(self.item);
		self:setOverrideHandModels(self.item, self.twoHands and self.item or nil)
		-- Change the player's "Weapon" animation variable to match our item.
		-- This fixes the 2-hand equip animation blending with the 1-hand idle animation, before the correct "Weapon" value is set.
		self:overrideWeaponType()
		if self.maxTime == -1 then
			self:forceComplete()
		end
	end
end

function ISEquipWeaponAction:stop()
	if self.sound then
		self.character:getEmitter():stopSound(self.sound)
	end
    self.item:setJobDelta(0.0);
    self:restoreWeaponType()
    ISBaseTimedAction.stop(self);
end

function isForceDropHeavyItem(item)
    return (item ~= nil) and (item:isForceDropHeavyItem())
end

function forceDropHeavyItems(character)
    if not character or not character:getCurrentSquare() then return end
    local primary = character:getPrimaryHandItem()
    if isForceDropHeavyItem(primary) then
        character:getInventory():Remove(primary)
		sendRemoveItemFromContainer(character:getInventory(), primary)
        local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(character, character:getCurrentSquare(), primary)
        character:getCurrentSquare():AddWorldInventoryItem(primary, dropX, dropY, dropZ)
        character:removeFromHands(primary)
		if not isServer() then
			ISInventoryPage.renderDirty = true -- for corpses
		end
    end
    local secondary = character:getSecondaryHandItem()
    if isForceDropHeavyItem(secondary) then
        character:getInventory():Remove(secondary)
		sendRemoveItemFromContainer(character:getInventory(), secondary)
        local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(character, character:getCurrentSquare(), primary)
        character:getCurrentSquare():AddWorldInventoryItem(secondary, dropX, dropY, dropZ)
        character:setSecondaryHandItem(nil)
		if not isServer() then
			ISInventoryPage.renderDirty = true -- for corpses
		end
    end
end

function ISEquipWeaponAction:isAlreadyEquipped()
	local primaryItem = self.character:getPrimaryHandItem()
	local secondaryItem = self.character:getSecondaryHandItem()
	if self.twoHands then
		return (primaryItem == self.item) and (secondaryItem == self.item)
	end
	if self.primary then
		return (primaryItem == self.item) and (secondaryItem ~= self.item)
	end
	return (secondaryItem == self.item) and (primaryItem ~= self.item)
end

function ISEquipWeaponAction:perform()
	if self.sound then
		self.character:getEmitter():stopSound(self.sound)
	end

    self.item:setJobDelta(0.0);

    if self.fromHotbar then
        local hotbar = getPlayerHotbar(self.character:getPlayerNum());
        hotbar.chr:removeAttachedItem(self.item);
        self:setOverrideHandModels(self.item, self.twoHands and self.item or nil)
    end

	self.item:getContainer():setDrawDirty(true);

	if self.item:IsInventoryContainer() or self.item:hasTag("Wearable") then
		getPlayerInventory(self.character:getPlayerNum()):refreshBackpacks();
	end

    self:restoreWeaponType()

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISEquipWeaponAction:complete()

	if self:isAlreadyEquipped(self.item) then
		return false
	end
	-- kludge for knapsack sprayers
	-- TODO: fix this!
	if self.character:getClothingItem_Back() and self.character:getClothingItem_Back():hasTag("ReplacePrimary") and self.character:getClothingItem_Back():getClothingItemExtra() and self.character:getClothingItem_Back():getClothingItemExtra():get(0) then
        ISClothingExtraAction:performNew(self.character, self.character:getClothingItem_Back(), self.character:getClothingItem_Back():getClothingItemExtra():get(0))
	end

	if self.character:isEquippedClothing(self.item) then
		self.character:removeWornItem(self.item)
		triggerEvent("OnClothingUpdated", self.character)
	end
	
	forceDropHeavyItems(self.character)

	if self.character:isEquippedClothing(self.item) then
		self.character:removeWornItem(self.item)
		triggerEvent("OnClothingUpdated", self.character)
	end

	if not self.twoHands then
		-- equip primary weapon
		if(self.primary) then
			-- if the previous weapon need to be equipped in both hands, we then remove it
			if self.character:getSecondaryHandItem() and self.character:getSecondaryHandItem():isRequiresEquippedBothHands() then
				self.character:setSecondaryHandItem(nil);
			end
			-- if this weapon is already equipped in the 2nd hand, we remove it
			if(self.character:getSecondaryHandItem() == self.item or self.character:getSecondaryHandItem() == self.character:getPrimaryHandItem()) then
				self.character:setSecondaryHandItem(nil);
			end
			-- if we are equipping a handgun and there is a weapon in the secondary hand we remove it
			if instanceof(self.item, "HandWeapon") and self.item:getSwingAnim() and self.item:getSwingAnim() == "Handgun" then
				if self.character:getSecondaryHandItem() and instanceof(self.character:getSecondaryHandItem(), "HandWeapon") then
					self.character:setSecondaryHandItem(nil);
				end
			end
			if not self.character:getPrimaryHandItem() or self.character:getPrimaryHandItem() ~= self.item then
				self.character:setPrimaryHandItem(nil);
				self.character:setPrimaryHandItem(self.item);
			end
		else -- second hand weapon
			-- if the previous weapon need to be equipped in both hands, we then remove it
			if self.character:getPrimaryHandItem() and self.character:getPrimaryHandItem():isRequiresEquippedBothHands() then
				self.character:setPrimaryHandItem(nil);
			end
			-- if this weapon is already equipped in the 1st hand, we remove it
			if(self.character:getPrimaryHandItem() == self.item or self.character:getSecondaryHandItem() == self.character:getPrimaryHandItem()) then
				self.character:setPrimaryHandItem(nil);
			end
			-- if we are equipping a weapon and there is a handgun in the primary hand we remove it
			if instanceof(self.item, "HandWeapon") and self.character:getPrimaryHandItem() then
				local primary = self.character:getPrimaryHandItem()
				if instanceof(primary, "HandWeapon") and primary:getSwingAnim() and primary:getSwingAnim() == "Handgun"  then
					self.character:setPrimaryHandItem(nil);
				end
			end
			if not self.character:getSecondaryHandItem() or self.character:getSecondaryHandItem() ~= self.item then
				self.character:setSecondaryHandItem(nil);
				self.character:setSecondaryHandItem(self.item);
			end
		end
	else
		self.character:setPrimaryHandItem(nil);
		self.character:setSecondaryHandItem(nil);

		self.character:setPrimaryHandItem(self.item);
		self.character:setSecondaryHandItem(self.item);
	end

	--if self.item:canBeActivated() and ((instanceof("Drainable", self.item) and self.item:getCurrentUsesFloat() > 0) or not instanceof("Drainable", self.item)) then
	if self.item:canBeActivated() and not self.item:hasTag("Lighter") and not instanceof(self.item, "HandWeapon") then
		self.item:setActivated(true);
		self.item:playActivateSound();
	end

	if not isServer() then
		getPlayerInventory(self.character:getPlayerNum()):refreshBackpacks()
	else
		sendEquip(self.character)
	end

	return true;
end

function ISEquipWeaponAction:getDuration()
    if self.character:getSecondaryHandItem() and self.character:getSecondaryHandItem() == self.item then
        return 0;
    end
    if self.character:getPrimaryHandItem() and self.character:getPrimaryHandItem() == self.item then
        return 0;
    end
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

function ISEquipWeaponAction:new (character, item, maxTime, primary, twoHands)
	local o = ISBaseTimedAction.new(self, character);
	o.item = item;
	o.stopOnAim = false;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.maxTime = maxTime;
	o.primary = primary;
	o.twoHands = twoHands;
	o.ignoreHandsWounds = true;

	if isServer() then
		o.hotbar = nil
	else
		o.hotbar = getPlayerHotbar(character:getPlayerNum());
	end
	o.fromHotbar = o.hotbar and o.hotbar:isItemAttached(item);
	o.useProgressBar = not o.fromHotbar;

    if instanceof(item, "HandWeapon") and not item:isTwoHandWeapon() then
        o.twoHands = false;
		if character:getSecondaryHandItem() and instanceof(item, "HandWeapon") then
		end
    end
    if item:isRequiresEquippedBothHands() then
        o.twoHands = true;
    end
	if o.twoHands then
		o.jobType = getText("ContextMenu_Equip_Two_Hands") .. " " .. item:getName()
	elseif o.primary then
		o.jobType = getText("ContextMenu_Equip_Primary") .. " " .. item:getName()
	else
		o.jobType = getText("ContextMenu_Equip_Secondary") .. " " .. item:getName()
	end
	if o.maxTime > 1 and o.fromHotbar then
		o.animSpeed = o.maxTime / o:adjustMaxTime(o.maxTime)
	else
		o.animSpeed = 1.0
	end
	return o
end
