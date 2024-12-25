--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************
local max_total = 3
local max_base = max_total
-- local max_spice = max_total
-- local max_length = 28

require "TimedActions/ISBaseTimedAction"

ISAddItemInRecipe = ISBaseTimedAction:derive("ISAddItemInRecipe");

function ISAddItemInRecipe:isValid()
	if isServer() then
		return true
	end
    if isClient() and self.baseItem then
	    return self.character:getInventory():containsID(self.baseItem:getID()) and self.recipe:getItemsCanBeUse(self.character, self.baseItem, nil):contains(self.usedItem)
	else
	    return self.character:getInventory():contains(self.baseItem) and self.recipe:getItemsCanBeUse(self.character, self.baseItem, nil):contains(self.usedItem)
	end
end

function ISAddItemInRecipe:update()
    self.baseItem:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISAddItemInRecipe:start()
    if isClient() and self.baseItem then
        self.baseItem = self.character:getInventory():getItemById(self.baseItem:getID())
    end
    self.baseItem:setJobType(getText("IGUI_JobType_AddingIngredient", self.usedItem:getDisplayName(), self.baseItem:getDisplayName()));
    local soundName = self.recipe:getAddIngredientSound() or "AddItemInRecipe"
    self.sound = self.character:getEmitter():playSoundImpl(soundName, nil)
end

function ISAddItemInRecipe:stop()
    self.baseItem:setJobDelta(0.0);
    if self.sound and self.sound ~= 0 then
        self.character:getEmitter():stopOrTriggerSound(self.sound)
    end
    ISBaseTimedAction.stop(self);
end

function ISAddItemInRecipe:perform()
    self.baseItem:setJobDelta(0.0);

    if self.sound and self.sound ~= 0 then
        self.character:getEmitter():stopOrTriggerSound(self.sound)
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISAddItemInRecipe:complete()

	self.character:removeFromHands(self.baseItem)

	self.baseItem = self.recipe:addItem(self.baseItem, self.usedItem, self.character);

	ISAddItemInRecipe.checkName(self.baseItem, self.recipe);

	if not self.baseItem:isCustomName() and self.baseItem:getFoodType() == "Beer" then
		baseItem:setName(getText("ContextMenu_FoodType_Beer"))
	end

	ISAddItemInRecipe.checkTemperature(self.baseItem, self.usedItem, self.recipe);

	if isServer() then
		sendItemStats(self.baseItem)
	end

	return true;
end

-- update the item temperature
ISAddItemInRecipe.checkTemperature = function(baseItem, usedItem, recipe)
    if baseItem and instanceof(baseItem, "Food") and usedItem and instanceof(usedItem, "Food") then
        --average the temperatures (adding cooked food to a recipe raises the heat)
        baseItem:setHeat((baseItem:getHeat() + usedItem:getHeat()) / 2);
    end;
end

-- Generate the recipe's name
ISAddItemInRecipe.checkName = function(baseItem, recipe)
    local foodTypeList = {};
    local finalName = "";
    local spicesName = "";
	local name = "";
    local count = 0;
    if not baseItem:getExtraItems() and not baseItem:getSpices() then
        return;
    end
    if instanceof(baseItem, "Food") and not baseItem:isCustomName() then -- Don't do anything if it's custom (unique recipe or changed by the player)
		if baseItem:getExtraItems() then 
			for i=0,baseItem:getExtraItems():size()-1 do
				for i,v in pairs(foodTypeList) do
					if v ~= "" then count = count + 1 end
				end
				local food = baseItem:getExtraItems():get(i);
				local name = getItemEvolvedRecipeName(food) or getItemDisplayName(food);
				if isItemFood(food) then
					if getItemFoodType(food) == "NoExplicit" or not getItemFoodType(food) then -- no explicit appear only if there's no other ingredient inside the recipe
						if count == 0 then
							foodTypeList["NoExplicit"] = getItemDisplayName(food);
						end
					else
						foodTypeList["NoExplicit"] = "";
						if not foodTypeList[getText("ContextMenu_FoodType_" .. getItemFoodType(food))] then -- first we show the name of food, if there's more than 1 time this type of food, we show the food type
							foodTypeList[getText("ContextMenu_FoodType_" .. getItemFoodType(food))] = name;
						elseif foodTypeList[getText("ContextMenu_FoodType_" .. getItemFoodType(food))] ~= getItemDisplayName(food) then -- only if the name is different (you can add 4x tomato, it'll stay as Tomato and not "vegetables")
							foodTypeList[getText("ContextMenu_FoodType_" .. getItemFoodType(food))] = getText("ContextMenu_FoodType_" .. getItemFoodType(food));
						end
					end
				end
			end
		end		
        count = 0;
        for i,v in pairs(foodTypeList) do
            if v ~= "" then count = count + 1 end
        end
        if count > max_base then -- avoid too big name
			count = 0
			name = getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName())
			baseItem:setName(getText(name))
        else -- do the name
			local index = 0
            for i,v in pairs(foodTypeList) do
                if v ~= "" and (not ((v == "Fruit" or v == "Fruits") and baseItem:getType() == "FruitSalad") ) then -- kludge for fruit salads until better naming is implemented
                    if finalName ~= "" then
						if index == count then
							finalName = finalName .. " " .. getText("ContextMenu_EvolvedRecipe_and") .. " ";
						else
							finalName = finalName .. getText("ContextMenu_EvolvedRecipe_comma") .. " ";
						end
                    end
                    finalName = finalName .. v;
                end
				index = index + 1
            end
			name = getText("ContextMenu_EvolvedRecipe_RecipeName", finalName , getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName()))
			baseItem:setName(getText(name))
        end
    end
    if count > max_total then -- if there's the maximum amount of food elements, don't wast time on spices
		if not isServer() then
			ISInventoryPage.dirtyUI();
		end
		return
	end
	local previousCount = count
	if baseItem:getSpices() then 		
		count = 0;
		foodTypeList = {};
		for i=0,baseItem:getSpices():size()-1 do
			for i,v in pairs(foodTypeList) do
				if v ~= "" then count = count + 1 end
			end
			local food = baseItem:getSpices():get(i);
			local name = getItemEvolvedRecipeName(food) or getItemDisplayName(food);
			if isItemFood(food) and not hasItemTag(food, "MinorIngredient") then
				if getItemFoodType(food) == "NoExplicit" or not getItemFoodType(food) then -- no explicit appear only if there's no other ingredient inside the recipe
					if count == 0 then
						foodTypeList["NoExplicit"] = getItemDisplayName(food);
					end
				else
					foodTypeList["NoExplicit"] = "";
					if not foodTypeList[getText("ContextMenu_FoodType_" .. getItemFoodType(food))] then -- first we show the name of food, if there's more than 1 time this type of food, we show the food type
						foodTypeList[getText("ContextMenu_FoodType_" .. getItemFoodType(food))] = name;
					elseif foodTypeList[getText("ContextMenu_FoodType_" .. getItemFoodType(food))] ~= getItemDisplayName(food) then -- only if the name is different (you can add 4x tomato, it'll stay as Tomato and not "vegetables")
						foodTypeList[getText("ContextMenu_FoodType_" .. getItemFoodType(food))] = getText("ContextMenu_FoodType_" .. getItemFoodType(food));
					end
				end
			end
		end
		count = 0;
        for i,v in pairs(foodTypeList) do
            if v ~= "" then count = count + 1 end
        end
        if (count + previousCount ) <= max_base then -- avoid too big name
			local index = 0
            for i,v in pairs(foodTypeList) do
                if v ~= "" and (not ((v == "Fruit" or v == "Fruits") and baseItem:getType() == "FruitSalad") ) then -- kludge for fruit salads until better naming is implemented
                    if spicesName ~= "" then
						if index == count then
							spicesName = spicesName .. " " .. getText("ContextMenu_EvolvedRecipe_and") .. " ";
						else
							spicesName = spicesName .. getText("ContextMenu_EvolvedRecipe_comma") .. " ";
						end
                    end
                    spicesName = spicesName .. v;
                end
				index = index + 1
            end
			if spicesName:len() > 0 and baseItem:getExtraItems() and baseItem:getExtraItems():size() > 0 then
				name = getText("ContextMenu_EvolvedRecipe_RecipeNameNew", finalName , getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName()) , spicesName)
				baseItem:setName(getText(name));
			elseif spicesName:len() > 0 then
				--name = getText("ContextMenu_EvolvedRecipe_RecipeNameNew2", getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName()) , getText("ContextMenu_EvolvedRecipe_with"), spicesName)
				name = getText("ContextMenu_EvolvedRecipe_RecipeName", spicesName , getText("ContextMenu_EvolvedRecipe_" .. recipe:getUntranslatedName()))
				baseItem:setName(getText(name));
			end
        end
	end
	if not isServer() then
		ISInventoryPage.dirtyUI();
	end
end

function ISAddItemInRecipe:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 100 - (self.character:getPerkLevel(Perks.Cooking) * 2.5)
end

function ISAddItemInRecipe:new(character, recipe, baseItem, usedItem)
	local o = ISBaseTimedAction.new(self, character)
	o.recipe = recipe;
    o.baseItem = baseItem;
    o.usedItem = usedItem;
	o.maxTime = o:getDuration()
	if not isServer() then
		o.jobType = getText("IGUI_JobType_AddingIngredient", usedItem:getDisplayName(), baseItem:getDisplayName());
	end
	return o;
end
