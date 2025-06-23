--***********************************************************
--**                    SOUL FILCHER                       **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDrinkFluidAction = ISBaseTimedAction:derive("ISDrinkFluidAction");

function ISDrinkFluidAction:isValidStart()
	return self.character:getMoodles():getMoodleLevel(MoodleType.FoodEaten) < 3 -- or self.character:getNutrition():getCalories() < 1000
end

function ISDrinkFluidAction:waitToStart()
	return false
end

function ISDrinkFluidAction:isValid()
	if self.item:getWorldItem() ~= nil and self.item:getWorldItem():getFluidContainer() == self.fluidContainer then
		return true;
	end
    if isClient() and self.item and ISFluidUtil.validateContainer(self.item) then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISDrinkFluidAction:update()
	-- live update 
	if not isClient() then
		self:updateEat(self:getJobDelta());
	end	
	
	self.item:setJobDelta(self:getJobDelta());
    if self.eatSound ~= "" and self.eatAudio ~= 0 and not self.character:getEmitter():isPlaying(self.eatAudio) then
        self.eatAudio = self.character:getEmitter():playSound(self.eatSound);
    end
end

function ISDrinkFluidAction:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

	if self.item ~= nil and self.eatSound == "DrinkingFromMug" then
		local heat = (self.item:IsFood() or self.item:IsDrainable()) and self.item:getHeat() or 1.0
		if not (self.item:IsFood() or self.item:IsDrainable()) then heat = self.item:getItemHeat() end
		if heat > 1 then
			self.eatSound = "DrinkingFromHotTeaCup"
		end
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
	self:updateEat(1);
	return true;
end

function ISDrinkFluidAction:updateEat(delta)
	if self.character:getInventory():contains(self.item) and self.fluidContainer:getFilledRatio() > 0 then
		local targetRatio = delta * self.targetConsumedRatio;
		local consumedRatio = self.startRatio - self.fluidContainer:getFilledRatio();
		local ratioToConsume = targetRatio - consumedRatio;
		local deltaToConsume = ratioToConsume / self.fluidContainer:getFilledRatio();
		
		self.character:DrinkFluid(self.item, deltaToConsume, self.useUtensil);
		self.item:syncItemFields();
	end
	self.consumedRatio = self.startRatio - self.fluidContainer:getFilledRatio();
end

function ISDrinkFluidAction:getDuration()
	return self.maxTime;
end

function ISDrinkFluidAction:new (character, item, percentage)
--     character:Say("Percentage - " .. tostring(percentage))
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.item = instanceof(item, "IsoWorldInventoryObject") and item:getItem() or item;
	o.fluidContainer = item:getFluidContainer();
	o.stopOnWalk = false;
	o.stopOnRun = true;
    o.percentage = percentage;
	
	o.startRatio = o.fluidContainer:getFilledRatio();
	o.endRatio = o.fluidContainer:getFilledRatio() * (1.0 - percentage);
	o.targetConsumedRatio = o.startRatio - o.endRatio;
	o.consumedRatio = 0;

    if not o.percentage then
        o.percentage = 1;
    end

	o.maxTime = math.abs(o.fluidContainer:getProperties():getHungerChange() * 150 * o.percentage) * 8;

    if o.maxTime > math.abs(o.fluidContainer:getProperties():getHungerChange() * 150 * 8) then
        o.maxTime = math.abs(o.fluidContainer:getProperties():getHungerChange() * 150 * 8);
    end

	local hungerConsumed = math.abs(o.fluidContainer:getProperties():getHungerChange() * o.percentage * 100);
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
	if o.item:getEatType() == "popcan" then
		o.maxTime = 160;
	end

    o.eatSound = o.fluidContainer:getCustomDrinkSound();
    o.eatAudio = 0

    o.ignoreHandsWounds = true;
	return o
end
