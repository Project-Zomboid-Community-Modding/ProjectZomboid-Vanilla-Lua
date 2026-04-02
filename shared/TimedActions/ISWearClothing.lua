require "TimedActions/ISBaseTimedAction"

ISWearClothing = ISBaseTimedAction:derive("ISWearClothing");

function ISWearClothing:isValid()
    if not self.item or self.item:isBroken() then
        return false
    end

    if isClient() and self.item then
        return true
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISWearClothing:update()
	self.item:setJobDelta(self:getJobDelta());

	if not self.equipSound and self:getJobDelta() > 0.7 and self.item and self.item:getEquipSound() then
		self.equipSound = self.character:playSound(self.item:getEquipSound())
	end
end

-- BodyLocation -> String used by AnimSets
WearClothingAnimations = {}
WearClothingAnimations[ItemBodyLocation.BELT] = "Waist"
WearClothingAnimations[ItemBodyLocation.BELT_EXTRA] = "Waist"
WearClothingAnimations[ItemBodyLocation.DRESS] = "Legs"
WearClothingAnimations[ItemBodyLocation.EARS] = "Face"
WearClothingAnimations[ItemBodyLocation.EAR_TOP] = "Face"
WearClothingAnimations[ItemBodyLocation.EYES] = "Face"
WearClothingAnimations[ItemBodyLocation.FANNY_PACK_BACK] = "Waist"
WearClothingAnimations[ItemBodyLocation.FANNY_PACK_FRONT] = "Waist"
WearClothingAnimations[ItemBodyLocation.FULL_HAT] = "Face"
WearClothingAnimations[ItemBodyLocation.HAT] = "Face"
WearClothingAnimations[ItemBodyLocation.JACKET] = "Jacket"
WearClothingAnimations[ItemBodyLocation.JACKET_HAT] = "Jacket"
WearClothingAnimations[ItemBodyLocation.LEGS1] = "Legs"
WearClothingAnimations[ItemBodyLocation.MASK] = "Face"
WearClothingAnimations[ItemBodyLocation.MASK_EYES] = "Face"
WearClothingAnimations[ItemBodyLocation.NOSE] = "Face"
WearClothingAnimations[ItemBodyLocation.PANTS] = "Legs"
WearClothingAnimations[ItemBodyLocation.SHOES] = "Feet"
WearClothingAnimations[ItemBodyLocation.SKIRT] = "Legs"
WearClothingAnimations[ItemBodyLocation.SOCKS] = "Feet"
WearClothingAnimations[ItemBodyLocation.SHIRT] = "Jacket"
WearClothingAnimations[ItemBodyLocation.SHORT_SLEEVE_SHIRT] = "Jacket"
WearClothingAnimations[ItemBodyLocation.TANK_TOP] = "Pullover"
WearClothingAnimations[ItemBodyLocation.TSHIRT] = "Pullover"

function ISWearClothing:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

	if self:isAlreadyEquipped(self.item) then
		self:forceComplete()
		return
	end
	self.item:setJobType(getText("ContextMenu_Wear") .. ' ' .. self.item:getName());
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
	self.sound = self.character:playSound("RummageInInventory")
	self.soundNoTrigger = true
end

function ISWearClothing:stop()
    self.item:setJobDelta(0.0);
    self:stopSound()
    ISBaseTimedAction.stop(self);
end

function ISWearClothing:perform()
	self:stopSound()

    self.item:setJobDelta(0.0);

	self.item:getContainer():setDrawDirty(true);
	if (self.item:IsInventoryContainer() or self.item:hasTag(ItemTag.WEARABLE)) and self.item:canBeEquipped() ~= "" then
		getPlayerInventory(self.character:getPlayerNum()):refreshBackpacks();
	end

	triggerEvent("OnClothingUpdated", self.character)
--~ 	self.character:SetClothing(self.item:getBodyLocation(), self.item:getSpriteName(), self.item:getPalette());
    -- needed to remove from queue / start next.

	ISInventoryPage.renderDirty = true

	ISBaseTimedAction.perform(self);
end

function ISWearClothing:complete()
    if self.item == nil then
        return false
    end
	if self:isAlreadyEquipped(self.item) then
		return false;
	end

	-- kludge for knapsack sprayers
	if self.item:hasTag(ItemTag.REPLACE_PRIMARY) then
		if self.character:getPrimaryHandItem() then
			self.character:removeFromHands(self.character:getPrimaryHandItem())
		end
		self.character:setPrimaryHandItem(self.item)
	end
	if (instanceof(self.item, "InventoryContainer") or self.item:hasTag(ItemTag.WEARABLE)) and self.item:canBeEquipped() ~= "" then
		self.character:removeFromHands(self.item);
		self.character:setWornItem(self.item:canBeEquipped(), self.item);
	elseif self.item:getCategory() == "Clothing" or self.item:getCategory() == "AlarmClock" then
		if self.item:getBodyLocation() ~= "" then
			self.character:setWornItem(self.item:getBodyLocation(), self.item);

			-- here we handle flating the mohawk!
			if self.character:getHumanVisual():getHairModel():contains("Mohawk") and (self.item:getBodyLocation() == ItemBodyLocation.HAT or self.item:getBodyLocation() == ItemBodyLocation.FULL_HAT) then
				self.character:getHumanVisual():setHairModel("MohawkFlat");
				self.character:resetModel();
			end
		end
	end
	return true;
end

function ISWearClothing:isAlreadyEquipped(item)
	if (instanceof(self.item, "InventoryContainer") or self.item:hasTag(ItemTag.WEARABLE)) and self.item:canBeEquipped() ~= "" then
		return self.character:getWornItem(self.item:canBeEquipped()) == self.item;
	end
	if self.item:getCategory() == "Clothing" and self.item:getBodyLocation() ~= "" then
		return self.character:getWornItem(self.item:getBodyLocation()) == self.item;
	end
	return false;
end

function ISWearClothing:getDuration()
    if self.item == nil then
        return 0
    end
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 50;
end

function ISWearClothing:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        if self.soundNoTrigger then
            self.character:getEmitter():stopSound(self.sound)
        else
		    self.character:stopOrTriggerSound(self.sound)
        end
	end
end

function ISWearClothing:new(character, item)
	local o = ISBaseTimedAction.new(self, character);
	o.item = item;
	o.maxTime = o:getDuration();
	o.fromHotbar = true; -- just to disable hotbar:update() during the wearing
	o.clothingAction = true;
	o.stopOnWalk = ISWearClothing.isStopOnWalk(item);
	o.stopOnRun = true;
	return o;
end


ISWearClothing.WalkBodyLocations = {
    ItemBodyLocation.AMMO_STRAP,
    ItemBodyLocation.BACK,
    ItemBodyLocation.ELBOW_LEFT,
    ItemBodyLocation.ELBOW_RIGHT,
    ItemBodyLocation.EYES,
    ItemBodyLocation.FULL_HAT,
    ItemBodyLocation.HANDS,
    ItemBodyLocation.HANDS_LEFT,
    ItemBodyLocation.HANDS_RIGHT,
    ItemBodyLocation.HAT,
    ItemBodyLocation.LEFT_MIDDLE_FINGER,
    ItemBodyLocation.LEFT_RING_FINGER,
    ItemBodyLocation.LEFT_EYE,
    ItemBodyLocation.LEFT_WRIST,
    ItemBodyLocation.MASK,
    ItemBodyLocation.MASK_EYES,
    ItemBodyLocation.MASK_FULL,
    ItemBodyLocation.NECKLACE,
    ItemBodyLocation.NECKLACE_LONG,
    ItemBodyLocation.NECK,
    ItemBodyLocation.RIGHT_MIDDLE_FINGER,
    ItemBodyLocation.RIGHT_RING_FINGER,
    ItemBodyLocation.RIGHT_EYE,
    ItemBodyLocation.RIGHT_WRIST,
    ItemBodyLocation.SATCHEL,
    ItemBodyLocation.SCARF,
    }

ISWearClothing.isStopOnWalk = function(item)
    if item == nil or not item:getClothingItem() then return false end
    for i,bodyLocation in ipairs(ISWearClothing.WalkBodyLocations) do
        if (item:getBodyLocation() and item:getBodyLocation() == bodyLocation) or (item:canBeEquipped() and item:canBeEquipped() == bodyLocation) then
            return false
        end
    end
    return true
end

