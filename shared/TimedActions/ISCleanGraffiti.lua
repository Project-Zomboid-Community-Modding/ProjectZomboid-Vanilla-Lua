--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCleanGraffiti = ISBaseTimedAction:derive("ISCleanGraffiti");

local function predicateNotBroken(item)
	return not item:isBroken()
end

local function predicateUseRemaining(item)
	return item:getFluidContainer():getAmount() >= ZomboidGlobals.CleanGraffitiPetrolAmount
end

function ISCleanGraffiti:isValid()
	local playerInv = self.character:getInventory()
	return playerInv:containsTagEval("Petrol", predicateUseRemaining) and playerInv:containsTagEval("CleanStains", predicateNotBroken);
-- 	return playerInv:contains("Bleach") and (playerInv:contains("BathTowel") or playerInv:contains("DishCloth") or playerInv:contains("Broom") or playerInv:contains("Mop"));
end

function ISCleanGraffiti:waitToStart()
	self.character:faceLocation(self.square:getX(), self.square:getY())
	return self.character:shouldBeTurning()
end

function ISCleanGraffiti:update()
    self.character:faceThisObject(self.object)
-- 	self.character:faceLocation(self.square:getX(), self.square:getY())
    self.character:setMetabolicTarget(Metabolics.LightWork);end

function ISCleanGraffiti:start()
	local primaryItem = self.character:getPrimaryHandItem()
	local twoHanded
	local toiletBrush
	if primaryItem then
        twoHanded = (primaryItem:hasTag("TwoHandItem") or (instanceof(primaryItem, "HandWeapon") and primaryItem:isTwoHandWeapon()))
        toiletBrush = primaryItem:hasTag("ToiletBrush")
    end
    if twoHanded then
-- 	if primaryItem:getType() == "Broom" or primaryItem:getType() == "Mop" then
		self:setActionAnim("ScrubWall_Mop");
		self:setOverrideHandModels(primaryItem, nil);
		self.sound = self.character:playSound("CleanBloodScrub")
    elseif toiletBrush then
        self:setActionAnim("ScrubWall_ToiletBrush");
        self:setOverrideHandModels(primaryItem, nil);
        self.sound = self.character:playSound("CleanBloodScrub")
	else
		self:setActionAnim("ScrubWall");
		--self.character:SetVariable("LootPosition", "High");
		self:setOverrideHandModels(primaryItem, self.cleaner);
		self.sound = self.character:playSound("CleanBloodBleach")
	end
	self.character:reportEvent("EventCleanGraffiti");
end

function ISCleanGraffiti:stop()
	self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISCleanGraffiti:perform()
	self.character:stopOrTriggerSound(self.sound)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISCleanGraffiti:complete()
	if self.cleaner then
		self.cleaner:getFluidContainer():adjustAmount(self.cleaner:getFluidContainer():getAmount() - ZomboidGlobals.CleanGraffitiPetrolAmount);
	end
	self.square:removeGraffiti();

	return true;
end

function ISCleanGraffiti:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 150
end

function ISCleanGraffiti:new(character, square, cleaner)
	local o = ISBaseTimedAction.new(self, character)
	o.square = square;
	o.maxTime = o:getDuration();
    o.caloriesModifier = 5;
    o.cleaner = cleaner;
    o.object = square:getGraffitiObject()
	return o;
end
