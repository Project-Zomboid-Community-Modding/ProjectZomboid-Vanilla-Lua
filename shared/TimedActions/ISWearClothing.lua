--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISWearClothing = ISBaseTimedAction:derive("ISWearClothing");

function ISWearClothing:isValid()
    if not self.item or self.item:isBroken() then return false end

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
WearClothingAnimations.Belt = "Waist"
WearClothingAnimations.BeltExtra = "Waist"
WearClothingAnimations.Dress = "Legs"
WearClothingAnimations.Ears = "Face"
WearClothingAnimations.EarTop = "Face"
WearClothingAnimations.Eyes = "Face"
WearClothingAnimations.FannyPackBack = "Waist"
WearClothingAnimations.FannyPackFront = "Waist"
WearClothingAnimations.FullHat = "Face"
WearClothingAnimations.Hat = "Face"
WearClothingAnimations.Jacket = "Jacket"
WearClothingAnimations.JacketHat = "Jacket"
WearClothingAnimations.Legs1 = "Legs"
WearClothingAnimations.Mask = "Face"
WearClothingAnimations.MaskEyes = "Face"
WearClothingAnimations.Nose = "Face"
WearClothingAnimations.Pants = "Legs"
WearClothingAnimations.Shoes = "Feet"
WearClothingAnimations.Skirt = "Legs"
WearClothingAnimations.Socks = "Feet"
WearClothingAnimations.Shirt = "Jacket"
WearClothingAnimations.ShortSleeveShirt = "Jacket"
WearClothingAnimations.TankTop = "Pullover"
WearClothingAnimations.Tshirt = "Pullover"

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
	if (self.item:IsInventoryContainer() or self.item:hasTag("Wearable")) and self.item:canBeEquipped() ~= "" then
		getPlayerInventory(self.character:getPlayerNum()):refreshBackpacks();
	end

	triggerEvent("OnClothingUpdated", self.character)
--~ 	self.character:SetClothing(self.item:getBodyLocation(), self.item:getSpriteName(), self.item:getPalette());
    -- needed to remove from queue / start next.

	ISInventoryPage.renderDirty = true

	ISBaseTimedAction.perform(self);
end

function ISWearClothing:complete()
	if self:isAlreadyEquipped(self.item) then
		return false;
	end

	-- kludge for knapsack sprayers
	if self.item:hasTag("ReplacePrimary") then
		if self.character:getPrimaryHandItem() then
			self.character:removeFromHands(self.character:getPrimaryHandItem())
		end
		self.character:setPrimaryHandItem(self.item)
	end

	if (instanceof(self.item, "InventoryContainer") or self.item:hasTag("Wearable")) and self.item:canBeEquipped() ~= "" then
		self.character:removeFromHands(self.item);
		self.character:setWornItem(self.item:canBeEquipped(), self.item);
	elseif self.item:getCategory() == "Clothing" then
		if self.item:getBodyLocation() ~= "" then
			self.character:setWornItem(self.item:getBodyLocation(), self.item);

			-- here we handle flating the mohawk!
			if self.character:getHumanVisual():getHairModel():contains("Mohawk") and (self.item:getBodyLocation() == "Hat" or self.item:getBodyLocation() == "FullHat") then
				self.character:getHumanVisual():setHairModel("MohawkFlat");
				self.character:resetModel();
			end
		end
	end
	return true;
end

function ISWearClothing:isAlreadyEquipped(item)
	if (instanceof(self.item, "InventoryContainer") or self.item:hasTag("Wearable")) and self.item:canBeEquipped() ~= "" then
		return self.character:getWornItem(self.item:canBeEquipped()) == self.item;
	end
	if self.item:getCategory() == "Clothing" and self.item:getBodyLocation() ~= "" then
		return self.character:getWornItem(self.item:getBodyLocation()) == self.item;
	end
	return false;
end

function ISWearClothing:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 50;
end

function ISWearClothing:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISWearClothing:new(character, item)
	local o = ISBaseTimedAction.new(self, character);
	o.item = item;
	o.maxTime = o:getDuration();
	o.fromHotbar = true; -- just to disable hotbar:update() during the wearing
	o.clothingAction = true;
	return o;
end
