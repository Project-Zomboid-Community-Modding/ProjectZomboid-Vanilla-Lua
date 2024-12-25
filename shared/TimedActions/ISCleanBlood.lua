--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCleanBlood = ISBaseTimedAction:derive("ISCleanBlood");

local function predicateBleach(item)
	return item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Bleach) and (item:getFluidContainer():getAmount() >= ZomboidGlobals.CleanBloodBleachAmount)
end

local function predicateCleaningLiquid(item)
	return item:getFluidContainer() and item:getFluidContainer():contains(Fluid.CleaningLiquid) and (item:getFluidContainer():getAmount() >= ZomboidGlobals.CleanBloodBleachAmount)
end

local function predicateNotBroken(item)
	return not item:isBroken()
end

function ISCleanBlood:isValid()
	local playerInv = self.character:getInventory()
	return (playerInv:containsEvalRecurse(predicateBleach) or playerInv:containsEvalRecurse(predicateCleaningLiquid)) and (playerInv:containsTagEval("CleanStains", predicateNotBroken));
-- 	return playerInv:contains("Bleach") and (playerInv:contains("BathTowel") or playerInv:contains("DishCloth") or playerInv:contains("Broom") or playerInv:contains("Mop"));
end

function ISCleanBlood:waitToStart()
	self.character:faceLocation(self.square:getX(), self.square:getY())
	return self.character:shouldBeTurning()
end

function ISCleanBlood:update()
	self.character:faceLocation(self.square:getX(), self.square:getY())
    self.character:setMetabolicTarget(Metabolics.LightWork);end

function ISCleanBlood:start()
	-- if we have dish clothes, play low animation & show bleach
	-- TODO: check to see whether, if there's blood, if the blood is on the wall and not the floor, then to use the wall scrubbing animations from cleaning graffiti
	-- Similarly, if somehow there is only grime, and it's on the wall and not the floor, use wall scrubbing
	-- If we wanted to be fancy we could switch between stances in cases where stains are on both floor and wall midway, but that might result in jank
	local primaryItem = self.character:getPrimaryHandItem()
	local twoHanded = false
	local toiletBrush = false
	-- Added it as there are cases when an item is not equipped, so it returns nil
	if primaryItem then
		twoHanded = primaryItem:hasTag("TwoHandItem") or (instanceof(primaryItem, "HandWeapon") and primaryItem:isTwoHandWeapon())
		toiletBrush = primaryItem:hasTag("ToiletBrush")
	end
	local wall = false
	local square = self.square
	if square:haveBloodWall()
	or (square:haveGrimeWall()
	and not square:haveGrimeFloor()
	and not square:haveBloodFloor()) then wall = true end
    if wall then
        if twoHanded then
    --  if primaryItem:getType() == "Broom" or primaryItem:getType() == "Mop" then
            self:setActionAnim("ScrubWall_Mop");
            self:setOverrideHandModels(primaryItem, nil);
            self.sound = self.character:playSound("CleanBloodScrub")
        elseif toiletBrush then
            self:setActionAnim("ScrubWall_ToiletBrush");
            self:setOverrideHandModels(primaryItem, nil);
            self.sound = self.character:playSound("CleanBloodScrub")
        else
            self:setActionAnim("Scrubwall");
            --self.character:SetVariable("LootPosition", "High");
            self:setOverrideHandModels(primaryItem, self.cleaner);
            self.sound = self.character:playSound("CleanBloodBleach")
        end
    else
        if twoHanded then
--      if primaryItem:getType() == "Broom" or primaryItem:getType() == "Mop" then
            self:setActionAnim("ScrubFloor_Mop");
            self:setOverrideHandModels(primaryItem, nil);
            self.sound = self.character:playSound("CleanBloodScrub")
        elseif toiletBrush then
            self:setActionAnim("ScrubFloor_ToiletBrush");
            self:setOverrideHandModels(primaryItem, nil);
            self.sound = self.character:playSound("CleanBloodScrub")
        else
            self:setActionAnim("ScrubFloor");
            --self.character:SetVariable("LootPosition", "Low");
            self:setOverrideHandModels(primaryItem, self.cleaner);
    -- 		self:setOverrideHandModels(nil, self.cleaner);
            self.sound = self.character:playSound("CleanBloodBleach")
        end
    end
	self.character:reportEvent("EventCleanBlood");
end

function ISCleanBlood:stop()
	self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISCleanBlood:perform()
	self.character:stopOrTriggerSound(self.sound)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISCleanBlood:complete()
    local cleaner = self.cleaner;
    if cleaner then
		cleaner:getFluidContainer():adjustAmount(cleaner:getFluidContainer():getAmount() - ZomboidGlobals.CleanBloodBleachAmount);
    end
    self.square:removeBlood(false, false);
    self.square:removeGrime();
	return true;
end

function ISCleanBlood:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
	return 150
end

function ISCleanBlood:new(character, square, cleaner)
	local o = ISBaseTimedAction.new(self, character)
	o.square = square;
	o.maxTime = o:getDuration();
    o.caloriesModifier = 5;
    o.cleaner = cleaner;
	return o;
end
