--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISEatFoodAction = ISBaseTimedAction:derive("ISEatFoodAction");

local function predicateNotEmpty(item)
	return item:getCurrentUsesFloat() > 0
end

local function predicateNotBroken(item)
	return not item:isBroken()
end

function ISEatFoodAction:isValidStart()
	return self.character:getMoodles():getMoodleLevel(MoodleType.FoodEaten) < 3 -- or self.character:getNutrition():getCalories() < 1000
end

function ISEatFoodAction:waitToStart()
    if not self.openFlame then return false end
	self.character:faceThisObject(self.openFlame)
	return self.character:shouldBeTurning()
end

function ISEatFoodAction:isValid()
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISEatFoodAction:update()
	self.item:setJobDelta(self:getJobDelta());
    if self.eatSound ~= "" and self.eatAudio ~= 0 and not self.character:getEmitter():isPlaying(self.eatAudio) then
        self.eatAudio = self.character:getEmitter():playSound(self.eatSound);
--        self.eatAudio = getSoundManager():PlayWorldSoundWav( self.eatSound, self.character:getCurrentSquare(), 0.5, 2, 0.5, true);
    end
	local eatType = self.item:getEatType()
	if self.useUtensil and (eatType == "can" or eatType == "candrink") and self:isEatingRemaining(self.item) then
		if not self.playedScrapeSound and (self:getJobDelta() >= 0.7) then
			self.scrapeSound = self.character:playSound("ScrapeCannedFood")
			self.playedScrapeSound = true
		end
	end
end

function ISEatFoodAction:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

	-- fromRelaunch is added in ISTimedAction to not consume stuff again when we relaunch the action
	if not self.fromRelaunch and self.item:getRequireInHandOrInventory() and not (self.carLighter or self.openFlame) then
        local lighter = self:getRequiredItem()
        lighter:setUsedDelta(lighter:getCurrentUsesFloat() - lighter:getUseDelta())
	end

	if self.eatSound ~= '' then
        self.eatAudio = self.character:getEmitter():playSound(self.eatSound);
--		self.eatAudio = getSoundManager():PlayWorldSoundWav( self.eatSound, self.character:getCurrentSquare(), 0.5, 2, 0.5, true);
    end
	if self.item:getCustomMenuOption() then
		self.item:setJobType(self.item:getCustomMenuOption())
	else
		self.item:setJobType(getText("ContextMenu_Eat"));
	end
	self.item:setJobDelta(0.0);

	local secondItem = nil;
	if self.item:getEatType() and self.item:getEatType() ~= "" then
		-- for can or 2handed, add a fork or a spoon if we have them otherwise we'll use default eat action
		-- use 2handforced if you don't want this to happen (like eating a burger..)
		if self.item:getEatType() == "can" or self.item:getEatType() == "candrink" or self.item:getEatType() == "2hand" or self.item:getEatType() == "plate" or self.item:getEatType() == "2handbowl" then
-- 			local playerInv = self.character:getInventory()
-- 			local spoon = playerInv:getFirstTagEvalRecurse("Spoon", predicateNotBroken) or playerInv:getFirstTypeEvalRecurse("Base.Spoon", predicateNotBroken);
-- 			local fork = playerInv:getFirstTagEvalRecurse("Fork", predicateNotBroken) or playerInv:getFirstTypeEvalRecurse("Base.Fork", predicateNotBroken);

			if self.item:getEatType() == "2handbowl" and self.spoon then
				self:setAnimVariable("FoodType", "2handbowl");
				secondItem = self.spoon;
			elseif self.item:getEatType() == "2handbowl" then
				self:setAnimVariable("FoodType", "bowl");
			else
				secondItem = self.fork or self.spoon;
				if self.item:getEatType() == "plate" then
				    if secondItem then
						self:setAnimVariable("FoodType", "plate");
					else
						self:setAnimVariable("FoodType", "NoSpoon");
					end
				elseif self.item:getEatType() == "2hand" then
					self:setAnimVariable("FoodType", "2hand");
				elseif self.item:getEatType() == "plate" then
					self:setAnimVariable("FoodType", "plate");
				elseif self.item:getEatType() == "candrink" then
				    if secondItem then
						self:setAnimVariable("FoodType", "can"); 
					else
						self:setAnimVariable("FoodType", "drink");
					end
				elseif self.item:getEatType() == "popcan" then
					self:setAnimVariable("FoodType", "drink");
				elseif self.item:getEatType() == "eatsmall" then
					self:setAnimVariable("FoodType", "EatSmall");
				elseif self.item:getEatType() == "eatbox"  then
					self:setAnimVariable("FoodType", "eatBox");
				end
			end
		else
			self:setAnimVariable("FoodType", self.item:getEatType());
		end
	end
-- 	if secondItem then self.useUtensil = true end
	self:setOverrideHandModels(secondItem, self.item);
	if self.item:getEatType() == "Pot" then
		self:setOverrideHandModels(self.item, nil);
	end
	if self.item:getCustomMenuOption() == getText("ContextMenu_Drink") and self.item:getEatType() ~= "2handbowl" then
		self:setActionAnim(CharacterActionAnims.Drink);
	else
		self:setActionAnim(CharacterActionAnims.Eat);
	end
	self.character:reportEvent("EventEating");
end

function ISEatFoodAction:stop()
    ISBaseTimedAction.stop(self);
	if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
		self.character:stopOrTriggerSound(self.eatAudio);
	end
	if self.scrapeSound and self.character:getEmitter():isPlaying(self.scrapeSound) then
		self.character:stopOrTriggerSound(self.scrapeSound)
	end
	self.item:setJobDelta(0.0);

	if not isClient() and not isServer() then
		self:serverStop();
	end
end

function ISEatFoodAction:serverStop()
	local applyEat = true;
	if self.item and self.item:getFullType()=="Base.Cigarettes" then
		applyEat = false; -- dont apply cigarette effects when action cancelled.
	end
	local hungerChange = math.abs(self.item:getHungerChange() * 100)
	if (hungerChange or self.item:getBaseHunger()) and hungerChange <= 1 then
		applyEat = false; -- dont consume 1 hunger food items when action cancelled.
	end
	if applyEat and self.character:getInventory():contains(self.item) then
		self:eat(self.item, self:getJobDelta());
	end
end

function ISEatFoodAction:perform()
    if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
        self.character:stopOrTriggerSound(self.eatAudio);
    end
    if self.scrapeSound and self.character:getEmitter():isPlaying(self.scrapeSound) then
        self.character:stopOrTriggerSound(self.scrapeSound)
    end
    if self.item:getHungChange() ~= 0 then
        -- This is now a looping sound, don't play it here
--        self.character:getEmitter():playSound("Swallowing");
    end
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
--     self.character:Eat(self.item, self.percentage);
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISEatFoodAction:complete()
	self.character:Eat(self.item, self.percentage, self.useUtensil);
	return true;
end

function ISEatFoodAction:getRequiredItem()
	if not self.item:getRequireInHandOrInventory() then
		return
	end
	local types = self.item:getRequireInHandOrInventory()
	for i=1,types:size() do
		local fullType = moduleDotType(self.item:getModule(), types:get(i-1))
		local item2 = self.character:getInventory():getFirstTypeEvalRecurse(fullType, predicateNotEmpty)
		if item2 then
			return item2
		end
	end
	return nil
end

function ISEatFoodAction:eat(food, percentage)
    -- calcul the percentage ate
    if percentage > 0.95 then
        percentage = 1.0;
    end
    percentage = self.percentage * percentage;
    self.character:Eat(self.item, percentage, self.useUtensil);
--     self.character:Eat(self.item, percentage);
end

function ISEatFoodAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	local maxTime = math.abs(self.item:getBaseHunger() * 150 * self.percentage) * 8;

    if maxTime > math.abs(self.item:getHungerChange() * 150 * 8) then
        maxTime = math.abs(self.item:getHungerChange() * 150 * 8);
    end

	local hungerConsumed = math.abs(self.item:getBaseHunger() * self.percentage * 100);
	local eatingLoop = 1;
	if hungerConsumed >= 30 then
		eatingLoop = 2;
	end
	if hungerConsumed >= 80 then
		eatingLoop = 3;
	end

	-- people requested benefits from spoons and forks so they make you eat faster; this is really the only practical means with the animations we have to work with
	if self.useUtensil and eatingLoop >= 2 then
        if isDebugEnabled() then
            print("IMPORTANT: player is eating with a utensil and will benefit from faster eating times if the time for eating is long enough to be reduced.")
        end
	    eatingLoop = eatingLoop - 1
	end

	local timerForOne = 232;
	if self.item:getCustomMenuOption() == getText("ContextMenu_Drink") then
		hungerConsumed = math.abs(self.item:getThirstChange() * self.percentage * 100);
		timerForOne = 171;
		if hungerConsumed >= 3 then
			eatingLoop = 2;
		end
		if hungerConsumed >= 6 then
			eatingLoop = 3;
		end
	end

	maxTime = timerForOne * eatingLoop;

	-- Cigarettes don't reduce hunger
	if hungerConsumed == 0 then maxTime = 460 end
	if self.item:getEatTime() and self.item:getEatTime() > 0 then maxTime = self.item:getEatTime() end


	if self.item:getEatType() == "popcan" then
		maxTime = 160;
	end
	return maxTime;
end

function ISEatFoodAction:getSecondItem()
    local secondItem = nil;
    if self.item:getEatType() and self.item:getEatType() ~= "" then
        -- for can or 2handed, add a fork or a spoon if we have them otherwise we'll use default eat action
        -- use 2handforced if you don't want this to happen (like eating a burger..)
        if self.item:getEatType() == "can" or self.item:getEatType() == "candrink" or self.item:getEatType() == "2hand" or self.item:getEatType() == "plate" or self.item:getEatType() == "2handbowl" then
--             local playerInv = self.character:getInventory()
--             local spoon = playerInv:getFirstTagEvalRecurse("Spoon", predicateNotBroken) or playerInv:getFirstTypeEvalRecurse("Base.Spoon", predicateNotBroken);
--             local fork = playerInv:getFirstTagEvalRecurse("Fork", predicateNotBroken) or playerInv:getFirstTypeEvalRecurse("Base.Fork", predicateNotBroken);

            if self.item:getEatType() == "2handbowl" and self.spoon then
                secondItem = self.spoon;
            elseif self.item:getEatType() == "2handbowl" then
                --
            else
                secondItem = self.fork or self.spoon;
            end
            if secondItem and isDebugEnabled() then
                print("IMPORTANT: player is eating with a utensil and will benefit better unhappiness/boredom values.")
                print("IMPORTANT: however if the food being eaten has no boredom or unhappiness effects then eating with a utensil will have no effect on that")
            end
        end
    end
    return secondItem
end

function ISEatFoodAction:isEatingRemaining(item)
	-- Figure out the fraction of the *remaining amount* that is used.
	-- If we already ate 1/4, and are eating 1/4 this time, then percentage=0.33.
	-- If we already ate 1/2 and are eating 1/2 this time, then percentage=1.0.
	local percent = PZMath.clamp_01(self.percentage)
	if (item:getBaseHunger() ~= 0.0) and (item:getHungChange() ~= 0.0) then
		local hungChange = item:getBaseHunger() * percent
		local usedPercent = hungChange / item:getHungChange()
		percent = PZMath.clamp_01(usedPercent)
	end
	if (item:getHungChange() < 0.0) and (item:getHungChange() * (1.0 - percent) > -0.01) then
		percent = 1.0;
	end
	if (item:getHungChange() == 0.0) and (item:getThirstChange() < 0.0) and (item:getThirstChange() * (1 - percent) > -0.01) then
		percent = 1.0;
	end
	return percent == 1.0
end

function ISEatFoodAction:new (character, item, percentage)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.item = item;
	o.stopOnWalk = false;
	o.stopOnRun = true;
	o.stopOnAim = false;
    o.percentage = percentage;
    o.carLighter = item:hasTag("Smokable") and character:getVehicle() and character:getVehicle():canLightSmoke(character)
    o.openFlame = false;
    if item:hasTag("Smokable") then o.openFlame = ISInventoryPaneContextMenu.hasOpenFlame(character) end
    o.useUtensil = false;
    o.isEating = true;
    local playerInv = o.character:getInventory()
    o.spoon = playerInv:getFirstTagEvalRecurse("Spoon", predicateNotBroken) or playerInv:getFirstTypeEvalRecurse("Base.Spoon", predicateNotBroken);
    o.fork = playerInv:getFirstTagEvalRecurse("Fork", predicateNotBroken) or playerInv:getFirstTypeEvalRecurse("Base.Fork", predicateNotBroken);
    if ISEatFoodAction.getSecondItem(o) then
        o.useUtensil = true
    end

    if not o.percentage then
        o.percentage = 1;
    end

    o.maxTime = ISEatFoodAction.getDuration(o)

    o.eatSound = item:getCustomEatSound() or "Eating";
    o.eatAudio = 0

--	local w = item:getActualWeight();
--    if w > 3 then w = 3; end;
--
--    o.maxTime = o.maxTime * w;

    o.ignoreHandsWounds = true;
	return o
end
