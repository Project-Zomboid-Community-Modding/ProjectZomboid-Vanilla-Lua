--***********************************************************
--**                    SOUL FILCHER                       **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDrinkFluidAction = ISBaseTimedAction:derive("ISDrinkFluidAction");

function ISDrinkFluidAction:isValidStart()
	return self.character:getMoodles():getMoodleLevel(MoodleType.FoodEaten) < 3 or self.character:getNutrition():getCalories() < 1000
end

function ISDrinkFluidAction:waitToStart()
	return false
end

function ISDrinkFluidAction:isValid()
    if isClient() and self.item and ISFluidUtil.validateContainer(self.item) then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISDrinkFluidAction:update()
	self.item:setJobDelta(self:getJobDelta());
    if self.eatSound ~= "" and self.eatAudio ~= 0 and not self.character:getEmitter():isPlaying(self.eatAudio) then
        self.eatAudio = self.character:getEmitter():playSound(self.eatSound);
    end
end

function ISDrinkFluidAction:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

	if self.eatSound ~= '' then
        self.eatAudio = self.character:getEmitter():playSound(self.eatSound);
    end
	if self.item:getCustomMenuOption() then
		self.item:setJobType(self.item:getCustomMenuOption())
	else
		self.item:setJobType(getText("ContextMenu_Drink"));
	end
	self.item:setJobDelta(0.0);
    if self.item:getEatType() then
        self:setAnimVariable("FoodType", self.item:getEatType());
        if self.item:getEatType() == "Pot" then
            self:setOverrideHandModels(self.item, nil);
        end
    else
        self:setAnimVariable("FoodType", "bottle");
    end
	self:setActionAnim(CharacterActionAnims.Drink);
	self:setOverrideHandModels(nil, self.item);
	self.character:reportEvent("EventEating");
end

function ISDrinkFluidAction:stop()
    ISBaseTimedAction.stop(self);
	if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
		self.character:stopOrTriggerSound(self.eatAudio);
	end
    self.item:setJobDelta(0.0);
end

function ISDrinkFluidAction:serverStop()
	local applyEat = true;
	local hungerChange = math.abs(self.item:getFluidContainer():getProperties():getHungerChange() * 100)
	if (hungerChange or self.item:getBaseHunger()) and hungerChange <= 1 then
		applyEat = false; -- dont consume 1 hunger food items when action cancelled.
	end
	if applyEat and self.character:getInventory():contains(self.item) then
		self:eat(self.item, self:getJobDelta());
	end
end

function ISDrinkFluidAction:perform()
    if self.eatAudio ~= 0 and self.character:getEmitter():isPlaying(self.eatAudio) then
        self.character:stopOrTriggerSound(self.eatAudio);
    end
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDrinkFluidAction:complete()
	self.character:DrinkFluid(self.item, self.percentage, self.useUtensil);
	self.item:syncItemFields();
	return true;
end

function ISDrinkFluidAction:eat(food, percentage)
    -- calcul the percentage ate
    if percentage > 0.95 then
        percentage = 1.0;
    end
    percentage = self.percentage * percentage;
    self.character:DrinkFluid(self.item, percentage, self.useUtensil);

	if isServer() then
		self.item:syncItemFields();
	end
end

function ISDrinkFluidAction:getDuration()
	return self.maxTime;
end

function ISDrinkFluidAction:new (character, item, percentage)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.item = item;
	o.stopOnWalk = false;
	o.stopOnRun = true;
    o.percentage = percentage;

    if not o.percentage then
        o.percentage = 1;
    end

	o.maxTime = math.abs(item:getFluidContainer():getProperties():getHungerChange() * 150 * o.percentage) * 8;

    if o.maxTime > math.abs(item:getFluidContainer():getProperties():getHungerChange() * 150 * 8) then
        o.maxTime = math.abs(item:getFluidContainer():getProperties():getHungerChange() * 150 * 8);
    end

	local hungerConsumed = math.abs(item:getFluidContainer():getProperties():getHungerChange() * o.percentage * 100);
	local eatingLoop = 1;
	if hungerConsumed >= 30 then
		eatingLoop = 2;
	end
	if hungerConsumed >= 80 then
		eatingLoop = 3;
	end
	
	local timerForOne = 232;

	o.maxTime = timerForOne * eatingLoop;
	o.stopOnAim = false;
	o.useUtensil = false;
	
	-- Cigarettes don't reduce hunger
	if hungerConsumed == 0 then o.maxTime = 460 end
	if item:getEatType() == "popcan" then
		o.maxTime = 160;
	end

    o.eatSound = item:getFluidContainer():getCustomDrinkSound();
    o.eatAudio = 0

    o.ignoreHandsWounds = true;
	return o
end
