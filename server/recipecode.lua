--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

Recipe = {}
Recipe.GetItemTypes = {}
Recipe.OnCanPerform = {}
Recipe.OnCreate = {}
Recipe.OnGiveXP = {}
Recipe.OnTest = {}

local function addExistingItemType(scriptItems, type)
	local all = getScriptManager():getItemsByType(type)
	for i=1,all:size() do
		local scriptItem = all:get(i-1)
		if not scriptItems:contains(scriptItem) then
			scriptItems:add(scriptItem)
		end
	end
end

function Recipe.OnCreate.HotCuppa(craftRecipeData, character)
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setCooked(true);
    result:setHeat(2.5);
end

function Recipe.GetItemTypes.AnimalBrain(scriptItems)
	scriptItems:addAll(getScriptManager():getItemsTag("AnimalBrain"))
end

function Recipe.GetItemTypes.MeatCleaver(scriptItems)
	scriptItems:addAll(getScriptManager():getItemsTag("MeatCleaver"))
end

function Recipe.GetItemTypes.MixingUtensil(scriptItems)
	scriptItems:addAll(getScriptManager():getItemsTag("MixingUtensil"))
end

function Recipe.GetItemTypes.AnimalHead(scriptItems)
	scriptItems:addAll(getScriptManager():getItemsTag("AnimalHead"))
end

function Recipe.OnTest.BottleNotOpened(item)
	if not item:getFluidContainer() then return true end
	return not item:getFluidContainer():canPlayerEmpty();
end

function Recipe.OnTest.BottleNotOpenedNotTainted(item)
    if not Recipe.OnTest.NotTainted(item) then return false end
	if item:getFluidContainer() then
		return not item:getFluidContainer():canPlayerEmpty();
	end
	return true
end

function Recipe.OnTest.BreakGlass(item)
	if item:getFluidContainer() then
		return item:getFluidContainer():isEmpty();
	end
	return true
end

function Recipe.OnTest.HotFluidContainer(item)
	if instanceof(item, "InventoryItem") and item:hasComponent(ComponentType.FluidContainer) then
		return item:getItemHeat() > 1.6;
	end
	return true;
end

function Recipe.OnTest.TaintedFood(item)
	if instanceof(item, "Food") then
		return item:isTainted();
	end
	return true
end

-- checks to make sure items using the bread slices tag in recipes are whole and not partially-eaten bread slices as appropriate
function Recipe.OnTest.WholeBreadSlices(item)
	if not item:hasTag("BreadSlices") then return true end
	local baseHunger = math.abs(item:getBaseHunger())
	local hungerChange = math.abs(item:getHungerChange())
    if item:isFresh() then return not (math.floor(baseHunger*10000) > math.floor(hungerChange*10000)) end --floating point issues, so multiply then floor.
    if item:isRotten() then return not (math.floor((baseHunger / 2.2)*10000) > math.floor(hungerChange*10000)) end
    return not (math.floor((baseHunger / 1.3)*10000) > math.floor(hungerChange*10000))
end

function Recipe.OnTest.FullPetrolBottle(item)
	if not item:hasTag("Petrol") then return true; end
    return item:getCurrentUsesFloat() == 1; -- only return true if the bottle is full
end

-- Default function to award XP when using a recipe.
function Recipe.OnGiveXP.Default(recipe, ingredients, result, player)
	for i=1,ingredients:size() do
		if ingredients:get(i-1):getType() == "Plank" or ingredients:get(i-1):getType() == "Log" then
		    addXp(player, Perks.Woodwork, 1);
		end
	end
	if instanceof(result, "Food") then
	    addXp(player, Perks.Cooking, 3);
	elseif result:getType() == "Plank" then
	    addXp(player, Perks.Woodwork, 3);
    end
end

function Recipe.OnGiveXP.DismantleElectronics(recipe, ingredients, result, player)
    addXp(player, Perks.Electricity, 3);
end

function Recipe.OnGiveXP.SawLogs(recipe, ingredients, result, player)
    if player:getPerkLevel(Perks.Woodwork) <= 3 then
        addXp(player, Perks.Woodwork, 3)
    else
        addXp(player, Perks.Woodwork, 1)
    end
end			

-- check that the water isn't tainted when used in a recipe
function Recipe.OnTest.NotTaintedWater(item)
--   if item:isWaterSource() then
--        if item:isTaintedWater() then return false; end
--    end
    return true;
end

-- Fill entirely the blowtorch with the remaining propane
function Recipe.OnCreate.RefillBlowTorch(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local previousBT = nil;
    local propaneTank = nil;
--     local oxygenTank = nil;
    for i=0, items:size()-1 do
       if items:get(i):getType() == "BlowTorch" then
           previousBT = items:get(i);
       elseif items:get(i):getType() == "PropaneTank" then
           propaneTank = items:get(i);
--        elseif items:get(i):hasTag("OxygenTank") then
--            oxygenTank = items:get(i);
       end
    end
    result:setUsedDelta(previousBT:getCurrentUsesFloat() + result:getUseDelta() * 30);

    while result:getCurrentUsesFloat() < 1 and propaneTank:getCurrentUsesFloat() > 0 do
--     while result:getCurrentUsesFloat() < 1 and propaneTank:getCurrentUsesFloat() > 0 and oxygenTank:getCurrentUsesFloat() > 0 do
        result:setUsedDelta(result:getCurrentUsesFloat() + result:getUseDelta() * 10);
        propaneTank:Use();
--         if oxygenTank then oxygenTank:Use(); end
    end

    if result:getCurrentUsesFloat() > 1 then
        result:setUsedDelta(1);
    end
end

-- check when refilling the lighter that lighter is not full and lighter fluid not empty
function Recipe.OnTest.RefillLighter(item)
    if item:getType() == "Lighter" then
        if item:getCurrentUsesFloat() == 1 then return false; end
    elseif item:getType() == "LighterFluid" then
        if item:getCurrentUsesFloat() == 0 then return false; end
    end
    return true;
end

-- Fill entirely the lighter with the remaining lighter fluid
function Recipe.OnCreate.RefillLighter(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local oldLighter = nil;
    local lighterFluid = nil;
    for i=0, items:size()-1 do
       if items:get(i):getType() == "Lighter" then
           oldLighter = items:get(i);
       elseif items:get(i):getType() == "LighterFluid" then
           lighterFluid = items:get(i);
       end
    end
    result:setUsedDelta(lighterFluid:getCurrentUsesFloat() + result:getUseDelta() * 30);

    while result:getCurrentUsesFloat() < 1 and lighterFluid:getCurrentUsesFloat() > 0 do
        result:setUsedDelta(result:getCurrentUsesFloat() + result:getUseDelta() * 30);
        lighterFluid:Use();
    end

    if result:getCurrentUsesFloat() > 1 then
        result:setUsedDelta(1);
    end
end

-- change result quality depending on your BS skill and the tools used
function BSItem_OnCreate(items, result, player)
    local ballPeen = player:getInventory():contains("BallPeenHammer");

    if instanceof(result, "HandWeapon") then
        local condPerc = ZombRand(5 + (player:getPerkLevel(Perks.Blacksmith) * 5), 10 + (player:getPerkLevel(Perks.Blacksmith) * 10));
        if not ballPeen then
            condPerc = condPerc - 20;
        end
        if condPerc < 5 then
            condPerc = 5;
        elseif condPerc > 100 then
            condPerc = 100;
        end
        result:setCondition(round(result:getConditionMax() * (condPerc/100)));
    end
end

function Recipe.OnCreate.SetEcruColor(craftRecipeData, character)
-- 	local items = craftRecipeData:getAllKeepInputItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local r= 0.76
    local g = 0.7
    local b = 0.5
	result:setColorRed(r);
	result:setColorGreen(g);
	result:setColorBlue(b);
	result:setColor(Color.new(r, g, b));
	result:setCustomColor(true);
end

-- When creating item in result box of crafting panel.
function Recipe.OnCreate.TorchBatteryRemoval(craftRecipeData, character)
	local items = craftRecipeData:getAllKeepInputItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	for i=0, items:size()-1 do
		local item = items:get(i)
		-- we found the battery, we change his used delta according to the battery
		if item:hasTag("Flashlight") or item:getType() == "Torch" or item:getType() == "HandTorch" or item:getType() == "PenLight" or item:getType() == "Rubberducky2" or item:getType() == "SheepElectricShears" then
			result:setUsedDelta(item:getCurrentUsesFloat());
			-- then we empty the torch used delta (his energy)
			item:setUsedDelta(0);
			item:syncItemFields();
		end
	end
end

-- You can't dismantle favorite item
function Recipe.OnTest.DismantleElectronics(sourceItem, result)
-- 	if sourceItem:hasTag("Screwdriver") then return true end
    return not sourceItem:isFavorite()
end

-- When creating item in result box of crafting panel.
function Recipe.OnCreate.TorchBatteryInsert(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
  for i=0, items:size()-1 do
	-- we found the battery, we change his used delta according to the battery
	if items:get(i):getType() == "Battery" then
		result:setUsedDelta(items:get(i):getCurrentUsesFloat());
	end
  end
end

function Recipe.OnCreate.DismantleFlashlight(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	for i=1,items:size() do
		local item = items:get(i-1)
		if item:getType() == "Torch" or item:getType() == "HandTorch" then
			if item:getCurrentUsesFloat() > 0 then
				local battery = character:getInventory():AddItem("Base.Battery")
				if battery then
					battery:setUsedDelta(item:getCurrentUsesFloat())
				end
			end
			break
		end
	end
end

function Recipe.OnCreate.InheritColorFromMaterial(craftRecipeData, character)
	local material = craftRecipeData:getFirstInputItemWithFlag("InheritColor");
	local color = material:getColor();
	local results = craftRecipeData:getAllCreatedItems();

	for j=0,results:size() - 1 do
		local result = results:get(j)
		result:setColor(color);
		if instanceof(result, "Clothing") or instanceof(result, "InventoryContainer") then
			local visual = result:getVisual();
			if visual then
				local immuColor = ImmutableColor.new(color);
				visual:setTint(immuColor);
			end
		end
    end
end

function Recipe.OnCreate.InheritTextureVariation(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
	local clothing = nil;
	
	for i=1,items:size() do
		local item = items:get(i-1)
		if instanceof(item, "Clothing") or instanceof(result, "InventoryContainer") then
			clothing = item;
		end
	end
	for j=0,results:size() - 1 do
		local result = results:get(j)
		if instanceof(result, "Clothing") or instanceof(result, "InventoryContainer") then
			result:setModelIndex(clothing:getModelIndex());
		end		
	end
end

-- Sawn-off recipe callback, copies modData to the new sawn-off.
local function tryAttachPart(weapon, part, player)
	--if part:getMountOn():contains(weapon:getFullType()) then
	if part:canAttach(player, weapon) then
		weapon:attachWeaponPart(player, part)
	elseif player then
		player:getInventory():AddItem(part)
	end
end

function Recipe.OnCreate.ShotgunSawnoff(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	for i=0,items:size()-1 do
		local item = items:get(i)
		if item:getType() == "Shotgun"or item:getType() == "DoubleBarrelShotgun" then
            -- these should now be handled by the InheritAmmunition inputFlag
-- 			result:setCurrentAmmoCount(item:getCurrentAmmoCount())
-- 			if result:haveChamber() and item:haveChamber() and item:isRoundChambered() then
-- 				result:setRoundChambered(true)
-- 			end
			local modData = result:getModData()
			for k,v in pairs(item:getModData()) do
				modData[k] = v
			end
			local parts = item:getAllWeaponParts()
			for i=1,parts:size() do
				tryAttachPart(result, parts:get(i-1), character)
			end
			return
		end
	end
end

function Recipe.OnCreate.CleanTaintedFood(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	--result:setTainted(not item:isTainted());
end

function Recipe.OnCreate.AddBaseIngredientToCookingVessel(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "Saucepan" or item:getType() == "Pot" then
            result:setCondition(item:getCondition());
        end
    end
end

function Recipe.OnCreate.Make4Bowls(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
	local condition = 10;
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if instanceof(item, "Food") then
			condition = item:getCondition()
			for j=0,results:size() - 1 do
				local result = results:get(j)
				if instanceof(result, "Food") then
					result:setBaseHunger(item:getBaseHunger() / 4);
					result:setHungChange(item:getHungChange() / 4);
					result:setThirstChange(item:getThirstChangeUnmodified() / 4);
					result:setBoredomChange(item:getBoredomChangeUnmodified() / 4);
					result:setUnhappyChange(item:getUnhappyChangeUnmodified() / 4);
					result:setCarbohydrates(item:getCarbohydrates() / 4);
					result:setLipids(item:getLipids() / 4);
					result:setProteins(item:getProteins() / 4);
					result:setCalories(item:getCalories() / 4);
					result:setTainted(item:isTainted())
					if item:haveExtraItems() then
						for i=0,item:getExtraItems():size() - 1 do
							local extraItem = item:getExtraItems():get(i);
							result:addExtraItem(extraItem);
						end
					end
					if item:getDisplayName() then
						result:setName(getText("Tooltip_food_Bowl", item:getDisplayName()));
						result:setCustomName(true);
					end
				else
					result:setCondition(condition)
				end
			end
        end
    end
end

function LightCandle_OnCreate(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "Candle" then
            result:setUsedDelta(item:getCurrentUsesFloat());
            result:setCondition(item:getCondition());
            result:setFavorite(item:isFavorite());
            if character:getPrimaryHandItem() == character:getSecondaryHandItem() then
                character:setPrimaryHandItem(nil)
            end
            character:setSecondaryHandItem(result);
            result:setActivated(true); --ensure the candle emits light upon creation
        end
    end
end

function ExtinguishCandle_OnCreate(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "CandleLit" then
            result:setUsedDelta(item:getCurrentUsesFloat());
            result:setCondition(item:getCondition());
            result:setFavorite(item:isFavorite());
        end
    end
end

function Recipe.OnCreate.Make2Bowls(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
	local condition = 10;
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if instanceof(item, "Food") then
			condition = item:getCondition()
			for j=0,results:size() - 1 do
				local result = results:get(j)
				if instanceof(result, "Food") then
					result:setBaseHunger(item:getBaseHunger() / 2);
					result:setHungChange(item:getBaseHunger() / 2);
					result:setThirstChange(item:getThirstChangeUnmodified() / 2);
					result:setBoredomChange(item:getBoredomChangeUnmodified() / 2);
					result:setUnhappyChange(item:getUnhappyChangeUnmodified() / 2);
					result:setCarbohydrates(item:getCarbohydrates() / 2);
					result:setLipids(item:getLipids() / 2);
					result:setProteins(item:getProteins() / 2);
					result:setCalories(item:getCalories() / 2);
					result:setTainted(item:isTainted())
					if item:haveExtraItems() then
						for i=0,item:getExtraItems():size() - 1 do
							local extraItem = item:getExtraItems():get(i);
							result:addExtraItem(extraItem);
						end
					end
					if item:getDisplayName() then
						result:setName(getText("Tooltip_food_Bowl", item:getDisplayName()));
						result:setCustomName(true);
					end
				else
					result:setCondition(condition)
				end
			end
        end
    end
end

function Recipe.OnTest.SliceBreadDough(sourceItem, result)
    if sourceItem:getFullType() == "Base.BreadDough" then
        return sourceItem:isCooked()
    end
    return true
end

function Recipe.OnCreate.Slice3(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if instanceof(item, "Food") then
			for j=0,results:size() - 1 do
				local result = results:get(j)
				if instanceof(result, "Food") then
					if item:isBurnt() then result:setBurnt(true) end
					result:setBaseHunger(item:getBaseHunger() / 3);
					result:setHungChange(item:getBaseHunger() / 3);
					result:setThirstChange(item:getThirstChangeUnmodified() / 3);
					result:setBoredomChange(item:getBoredomChangeUnmodified() / 3);
					result:setUnhappyChange(item:getUnhappyChangeUnmodified() / 3);
					result:setCarbohydrates(item:getCarbohydrates() / 3);
					result:setLipids(item:getLipids() / 3);
					result:setProteins(item:getProteins() / 3);
					result:setCalories(item:getCalories() / 3);
					result:setTainted(item:isTainted())
				end
			end
        end
    end
end

-- for testing if food items are cooked or burnt
function Recipe.OnCanPerform.Uncooked(recipe, playerObj, item)
	if item and not instanceof(item, "Food") then return true end
    return item and not (item:isCooked() or item:isBurnt())
end

function Recipe.OnCanPerform.HalloweenPumpkin(recipe, playerObj, item)
	if item and not instanceof(item, "Food") then return true end
    return item and not (item:isCooked() or item:isBurnt())
end

function Recipe.OnCanPerform.SliceCooked(recipe, playerObj, item)
	if item and not instanceof(item, "Food") then return true end
    return item and (item:isCooked() or item:isBurnt())
end

function Recipe.OnCreate.Slice5(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
	local wholeItem;
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if instanceof(item, "Food") then
			wholeItem = item;
			break
        end
    end
	if not wholeItem then return end
	for j=0,results:size() - 1 do
		local result = results:get(j)
		if instanceof(result, "Food") then
			if wholeItem:isBurnt() then result:setBurnt(true) end
			result:setBaseHunger(wholeItem:getBaseHunger() / 5);
			result:setHungChange(wholeItem:getHungChange() / 5);
			result:setThirstChange(wholeItem:getThirstChangeUnmodified() / 5)
			result:setBoredomChange(wholeItem:getBoredomChangeUnmodified() / 5)
			result:setUnhappyChange(wholeItem:getUnhappyChangeUnmodified() / 5)
			result:setCalories(wholeItem:getCalories() / 5)
			result:setCarbohydrates(wholeItem:getCarbohydrates() / 5)
			result:setLipids(wholeItem:getLipids() / 5)
			result:setProteins(wholeItem:getProteins() / 5)
			if wholeItem:haveExtraItems() then
				for i=0,wholeItem:getExtraItems():size() - 1 do
					local extraItem = wholeItem:getExtraItems():get(i);
					result:addExtraItem(extraItem);
				end
			end
			if wholeItem:getDisplayName() then
				result:setName(getText("Tooltip_food_Slice", wholeItem:getDisplayName()));
				result:setCustomName(true);
			end
		end
	end
end

function Recipe.OnTest.CutFish(sourceItem, result)
    if instanceof(sourceItem, "Food") then
        return sourceItem:getActualWeight() > 0.6
    end
    return true
end

function Recipe.OnCreate.CutFish(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    local fish = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            fish = items:get(i);
            break;
        end
    end
    if fish then
		for j=0,results:size() - 1 do
			local result = results:get(j)	
			local hunger = math.max(fish:getBaseHunger(), fish:getHungChange())
			result:setBaseHunger(hunger / 2);
			result:setHungChange(hunger / 2);
			result:setActualWeight((fish:getActualWeight() * 0.9) / 2)
			result:setWeight(result:getActualWeight());
			result:setCustomWeight(true)
			result:setCarbohydrates(fish:getCarbohydrates() / 2);
			result:setLipids(fish:getLipids() / 2);
			result:setProteins(fish:getProteins() / 2);
			result:setCalories(fish:getCalories() / 2);
			result:setCooked(fish:isCooked());
		end
    end
end

function Recipe.OnTest.CutFillet(sourceItem, result)
    if instanceof(sourceItem, "Food") then
        return sourceItem:getActualWeight() > 1.0
    end
    return true
end

function Recipe.OnCreate.CutFillet(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    local fillet = nil
    for i=0,items:size() - 1 do
        if items:get(i):getType() == "FishFillet" then
            fillet = items:get(i)
            break
        end
    end
    if fillet then
        local hunger = math.max(fillet:getBaseHunger(), fillet:getHungChange())
        fillet:setBaseHunger(hunger * 0.5)
        fillet:setHungChange(fillet:getBaseHunger())
        fillet:setActualWeight(fillet:getActualWeight() * 0.5)

		for j=0,results:size() - 1 do
			local result = results:get(j)	
			result:setBaseHunger(fillet:getBaseHunger())
			result:setHungChange(fillet:getBaseHunger())
			result:setActualWeight(fillet:getActualWeight())
			result:setWeight(result:getActualWeight())
			result:setCustomWeight(true)
			result:setCarbohydrates(fillet:getCarbohydrates());
			result:setLipids(fillet:getLipids());
			result:setProteins(fillet:getProteins());
			result:setCalories(fillet:getCalories());
		end
    end
end

function Recipe.OnCreate.CutAnimal(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    local anim = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            anim = items:get(i);
            break;
        end
    end
    if anim then
        local new_hunger = anim:getHungChange() * 1.05;
        if(new_hunger < -100) then
            new_hunger = -100;
        end
		
		for j=0,results:size() - 1 do
			local result = results:get(j)	
			result:setBaseHunger(new_hunger);
			result:setHungChange(new_hunger);

			result:setCustomWeight(true);
			result:setWeight(anim:getWeight() * 0.7);
			result:setActualWeight(anim:getActualWeight() * 0.7);

			result:setLipids(anim:getLipids() * 0.75);
			result:setProteins(anim:getProteins() * 0.75);
			result:setCalories(anim:getCalories() * 0.75);
			result:setCarbohydrates(anim:getCarbohydrates() * 0.75);
			result:setUnhappyChange(anim:getUnhappyChange() * 0.75);
		end
    end
end

-- set the age of the food to the can, you need to cook it to have a 2-3 months preservation
function Recipe.OnCreate.CannedFood(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setBaseHunger(0)
    result:setHungChange(0)
    result:setActualWeight(0)
    result:setCarbohydrates(0)
    result:setLipids(0)
    result:setProteins(0)
    result:setCalories(0)
    local food = nil;
    local age = 0;
    local offAgeMax = 0;
    local offAge = 0;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
--             if not food or (food:getAge() < items:get(i):getAge()) then
                food = items:get(i);
--                print("got food with age " .. food:getAge())
                if not food:hasTag("Vinegar") and not food:hasTag("Sugar") then
                    result:setBaseHunger(result:getBaseHunger() + food:getBaseHunger())
                    result:setHungChange(result:getBaseHunger() + food:getBaseHunger())
                    result:setCarbohydrates(result:getCarbohydrates() + food:getCarbohydrates())
                    result:setLipids(result:getLipids() + food:getLipids())
                    result:setProteins(result:getProteins() + food:getProteins())
                    result:setCalories(result:getCalories() + food:getCalories())
                    if food:getAge() > age then age = food:getAge() end
                    offAgeMax = food:getOffAgeMax()
                    offAge = food:getOffAge()
                end
--             end
        elseif items:get(i):getType() == "JarLid" then
            local lid = items:get(i)
            local mData = result:getModData()
            local skill = character:getPerkLevel(Perks.Cooking)
            if ZombRand(11) >= skill then
                mData.LidCondition = (lid:getCondition() - 1)
            else
                mData.LidCondition = lid:getCondition()
            end
        end
    end
--    print("new jared food age " .. food:getAge() .. " and max age " .. food:getOffAgeMax());
    result:setAge(age);
    result:setOffAgeMax(offAgeMax);
    result:setOffAge(offAge);
end

-- set back the age of the food and give the jar back
function Recipe.OnCreate.OpenCannedFood(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local jar = items:get(0);
    local aged = jar:getAge() / jar:getOffAgeMax();
    result:setBaseHunger(jar:getBaseHunger())
    result:setHungChange(jar:getHungChange())
    result:setCarbohydrates(jar:getCarbohydrates())
    result:setLipids(jar:getLipids())
    result:setProteins(jar:getProteins())
    result:setCalories(jar:getCalories())

    result:setAge(result:getOffAgeMax() * aged);
    result:setCooked(jar:isCooked())
    result:setBurnt(jar:isBurnt())

    -- character:getInventory():AddItem("Base.EmptyJar");
    local lid = instanceItem("Base.JarLid");
    local mData = jar:getModData()
    local cond = mData.LidCondition or 9
    lid:setCondition(cond)
    character:getInventory():AddItem(lid);

--    print("you're new food have age " .. result:getAge());
end

----- CannedFood_OnCooked IS NOT RECIPE CODE. IT IS CALLED BY Food.update() -----
-- you cook your can, now set the correct food age/max age
function CannedFood_OnCooked(cannedFood)
    local aged = cannedFood:getAge() / cannedFood:getOffAgeMax();
    cannedFood:setOffAgeMax(90);
    cannedFood:setOffAge(60);
    cannedFood:setAge(cannedFood:getOffAgeMax() * aged);
--    print("new jared food age " .. cannedFood:getAge() .. " and max age " .. cannedFood:getOffAgeMax());
end

function Recipe.GetItemTypes.CraftLogStack(scriptItems)
    scriptItems:addAll(getScriptManager():getItemsTag("Rope"));
end

-- save the ropes used
function Recipe.OnCreate.CreateLogStack(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local item, itemType;
    local ropeItems = {};
    for i = 0, items:size() - 1 do
        item = items:get(i);
        if item then
            itemType = item:getFullType();
            if itemType ~= "Base.Log" then
                table.insert(ropeItems, itemType);
            end;
        end;
    end;
    result:getModData().ropeItems = ropeItems;
end

-- give back the ropes used
function Recipe.OnCreate.SplitLogStack(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
    local ropeItems = items:get(0):getModData().ropeItems;
    if ropeItems == nil then
        character:getInventory():AddItem("Base.Rope");
        character:getInventory():AddItem("Base.Rope");
    else
        for i = 1, #ropeItems do
            character:getInventory():AddItem(ropeItems[i]);
        end;
    end
end

function Recipe.OnCreate.Dismantle2(craftRecipeData, character)
    character:getInventory():AddItem("Base.ElectronicsScrap");
    character:getInventory():AddItem("Base.ElectronicsScrap");
end

function Recipe.OnCreate.DismantleMiscElectronics(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	for i=1,items:size() do
		local item = items:get(i-1)
		if item:getType() == "Remote" then
			local success = 60;
			if (ZombRand(0,100) < success) then
				local battery = instanceItem("Base.Battery");
				if(battery ~= nil)then
					battery:setUsedDelta(ZombRandFloat(0.01,1.0));
					character:getInventory():AddItem(battery);
				end
			end
		end
	end
end

function Recipe.OnCreate.SpikedBat(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    for i=1,items:size() do
        local item = items:get(i-1)
        if item:getType() == "BaseballBat" or item:getType() == "Plank" or item:getType() == "LongHandle" or item:getType() == "Handle"  or item:getType() == "ShortBat" or item:getType() == "LargeBranch" or item:getType() == "TreeBranch2"  then
            result:setCondition(item:getCondition())
            break
        end
    end
end

function Recipe.OnCreate.FixFishingRod(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    for i=1,items:size() do
        local item = items:get(i-1)
        if item:hasTag("FishingLine") then
            result:getModData().fishing_LineType = item:getFullType()
        end
        if item:hasTag("FishingHook") then
            result:getModData().fishing_HookType = item:getFullType()
        end
    end
end

function Recipe.OnCreate.CreateFishingRod(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    for i=1,items:size() do
        local item = items:get(i-1)
        if item:hasTag("FishingLine") then
            result:getModData().fishing_LineType = item:getFullType()
        end
        if item:hasTag("FishingHook") then
            result:getModData().fishing_HookType = item:getFullType()
        end
    end
end

function Recipe.GetItemTypes.FishingLine(scriptItems)
	scriptItems:addAll(getScriptManager():getItemsTag("FishingLine"))
end


function Recipe.OnCreate.OpenEggCarton(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setAge(items:get(0):getAge());
end

--[[ ############# Radio stuff ############## --]]

function Recipe.OnCreate.DismantleRadioSpecial(craftRecipeData, character)
    local success = 50 + (character:getPerkLevel(Perks.Electricity)*5);
    if ZombRand(0,100)<success then
        character:getInventory():AddItem("Base.ScannerModule");
    end
    DismantleRadioTwoWay_OnCreate(craftRecipeData, character);
end

function Recipe.OnCreate.DismantleRadioTwoWay(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
    local success = 50 + (character:getPerkLevel(Perks.Electricity)*5);
    if ZombRand(0,100)<success then
        character:getInventory():AddItem("Base.RadioTransmitter");
    end
    if ZombRand(0,100)<success then
        character:getInventory():AddItem("Base.LightBulbGreen");
    end
    DismantleRadio_OnCreate(craftRecipeData, character);
end

function Recipe.OnCreate.DismantleRadio(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
    --TODO adding return items/chance based on selectedItem value
    local success = 50 + (character:getPerkLevel(Perks.Electricity)*5);
    for i=1,ZombRand(1,4) do
        local r = ZombRand(1,4);
        if r==1 then
            character:getInventory():AddItem("Base.ElectronicsScrap");
        elseif r==2 then
            character:getInventory():AddItem("Base.ElectricWire");
        elseif r==3 then
            character:getInventory():AddItem("Base.AluminumFragments");
        end
    end
    if ZombRand(0,100)<success then
        character:getInventory():AddItem("Base.Amplifier");
    end
    if ZombRand(0,100)<success then
        character:getInventory():AddItem("Base.LightBulb");
    end
    if ZombRand(0,100)<success then
        character:getInventory():AddItem("Base.RadioReceiver");
    end
    --if selectedItem then
        --print("Main item "..selectedItem:getName());
    --end
    for i=1,items:size() do
        local item = items:get(i-1)
        if instanceof(item, "Radio") then
            item:getDeviceData():getBattery(character:getInventory())
            item:getDeviceData():getHeadphones(character:getInventory())
            break
        end
    end
end

function Recipe.OnCreate.DismantleRadioTV(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local success = 50 + (character:getPerkLevel(Perks.Electricity)*5);
    for i=1,ZombRand(1,6) do
        local r = ZombRand(1,4);
        if r==1 then
            character:getInventory():AddItem("Base.ElectronicsScrap");
        elseif r==2 then
            character:getInventory():AddItem("Base.ElectricWire");
        elseif r==3 then
            character:getInventory():AddItem("Base.AluminumFragments");
        end
    end
    if ZombRand(0,100)<success then
        character:getInventory():AddItem("Base.Amplifier");
    end
    if ZombRand(0,100)<success then
        character:getInventory():AddItem("Base.LightBulb");
    end
    if selectedItem then
        --print("Main item "..selectedItem:getName());
        if selectedItem:getType()~="TvAntique" then
            if ZombRand(0,100)<success then
                character:getInventory():AddItem("Base.LightBulbRed");
            end
            if ZombRand(0,100)<success then
                character:getInventory():AddItem("Base.LightBulbGreen");
            end
        end
    end
end

function Recipe.OnGiveXP.DismantleRadio(recipe, ingredients, result, player)
    addXp(player, Perks.Electricity, 2)
end

local function getRandomValue(valmin, valmax, perkLevel)
    local range = valmax-valmin;
    local r = ZombRandFloat(range*((perkLevel-1)/10),range*(perkLevel/10));
    return valmin+r;
end

function Recipe.OnCreate.RadioCraft(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    --TransmitRange		= 5000,
    if result and result:getDeviceData() then
        local data = result:getDeviceData();
        local perk = character:getPerkLevel(Perks.Electricity);
        local perkInvert = 10-perk+1;
        local actualWeight = result:getScriptItem():getActualWeight()
        if actualWeight <= 3.0 then
            result:setActualWeight(getRandomValue(1.5,3.0,perk));
        else
            result:setActualWeight(actualWeight);
        end
        result:setWeight(result:getActualWeight())
        result:setCustomWeight(true)
        data:setUseDelta(getRandomValue(0.007,0.030,perkInvert));
        data:setBaseVolumeRange(getRandomValue(8,16,perk));
        data:setMinChannelRange(getRandomValue(200,88000,perkInvert));
        data:setMaxChannelRange(getRandomValue(108000,1000000,perk));
        data:setTransmitRange(getRandomValue(500,5000,perk));
        data:setHasBattery(false);
        data:setPower(0);
        data:transmitBattryChange();
        if perk == 10 then
            if ZombRand(0,100)<25 then --on max level 25% chance to craft a hightier device. Superior range, very low power consumption.
                data:setIsHighTier(true);
                data:setTransmitRange(ZombRand(5500,7500));
                data:setUseDelta(ZombRand(0.002,0.007));
            end
        end
    end
end

function Recipe.OnGiveXP.RadioCraft(recipe, ingredients, result, player)
    addXp(player, Perks.Electricity, player:getPerkLevel(Perks.Electricity)*5)
end

----- OnEat_Cigarettes IS NOT RECIPE CODE.  IT IS CALLED BY IsoGameCharacter.Eat() -----
-- smoking cigarettes gives more bonus to a smoker
function OnEat_Cigarettes(food, character, percent)
--     local script = food:getScriptItem()
--     percent = percent * (food:getStressChange() * 100) / script:getStressChange()
    local bodyDamage = character:getBodyDamage()
    local stats = character:getStats()
    if character:HasTrait("Smoker") then
        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() - 10 * percent);
        if bodyDamage:getUnhappynessLevel() < 0 then
            bodyDamage:setUnhappynessLevel(0);
        end
        stats:setStress(stats:getStress() - 10 * percent);
        if stats:getStress() < 0 then
            stats:setStress(0);
        end
        local reduceSFC = stats:getMaxStressFromCigarettes()
        stats:setStressFromCigarettes(stats:getStressFromCigarettes() - reduceSFC * percent);
        character:setTimeSinceLastSmoke(stats:getStressFromCigarettes() / stats:getMaxStressFromCigarettes());
        if ZombRand(10) == 0 then
            -- make the character cough
            character:triggerCough()
--             character:setVariable("Ext", "Cough")
--             character:reportEvent("EventDoExt")
        end
    else
        if ZombRand(2)  == 0 then
            -- make the character cough
            character:triggerCough()
--             character:setVariable("Ext", "Cough")
--             character:reportEvent("EventDoExt")
        end
--        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() + 5);
--        if bodyDamage:getUnhappynessLevel() > 100 then
--            bodyDamage:setUnhappynessLevel(100);
--        end
        bodyDamage:setFoodSicknessLevel(bodyDamage:getFoodSicknessLevel() + 14 * percent);
        if bodyDamage:getFoodSicknessLevel() > 100 then
            bodyDamage:setFoodSicknessLevel(100);
        end
    end
end


function OnEat_Cigarillo(food, character, percent)
    local script = food:getScriptItem()
    percent = percent * (food:getStressChange() * 100) / script:getStressChange()
    local bodyDamage = character:getBodyDamage()
    local stats = character:getStats()
    if character:HasTrait("Smoker") then
        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() - 15 * percent);
        if bodyDamage:getUnhappynessLevel() < 0 then
            bodyDamage:setUnhappynessLevel(0);
        end
        stats:setStress(stats:getStress() - 15 * percent);
        if stats:getStress() < 0 then
            stats:setStress(0);
        end
        local reduceSFC = stats:getMaxStressFromCigarettes()
        stats:setStressFromCigarettes(stats:getStressFromCigarettes() - reduceSFC * percent);
        character:setTimeSinceLastSmoke(stats:getStressFromCigarettes() / stats:getMaxStressFromCigarettes());
        if ZombRand(5)  == 0 then
            -- make the character cough
            character:triggerCough()
--             character:setVariable("Ext", "Cough")
--             character:reportEvent("EventDoExt")
        end
    else
--        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() + 5);
--        if bodyDamage:getUnhappynessLevel() > 100 then
--            bodyDamage:setUnhappynessLevel(100);
--        end
        if ZombRand(2)  == 0 then
            -- make the character cough
            character:triggerCough()
--             character:setVariable("Ext", "Cough")
--             character:reportEvent("EventDoExt")
        end
        bodyDamage:setFoodSicknessLevel(bodyDamage:getFoodSicknessLevel() + 21 * percent);
        if bodyDamage:getFoodSicknessLevel() > 100 then
            bodyDamage:setFoodSicknessLevel(100);
        end
    end
end


function OnEat_Cigar(food, character, percent)
    local script = food:getScriptItem()
    percent = percent * (food:getStressChange() * 100) / script:getStressChange()
    local bodyDamage = character:getBodyDamage()
    local stats = character:getStats()
    if character:HasTrait("Smoker") then
        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() - 40 * percent);
        if bodyDamage:getUnhappynessLevel() < 0 then
            bodyDamage:setUnhappynessLevel(0);
        end
        stats:setStress(stats:getStress() - 40 * percent);
        if stats:getStress() < 0 then
            stats:setStress(0);
        end
        local reduceSFC = stats:getMaxStressFromCigarettes()
        stats:setStressFromCigarettes(stats:getStressFromCigarettes() - reduceSFC * percent);
        character:setTimeSinceLastSmoke(stats:getStressFromCigarettes() / stats:getMaxStressFromCigarettes());
        if ZombRand(5)  == 0 then
            -- make the character cough
            character:triggerCough()
--             character:setVariable("Ext", "Cough")
--             character:reportEvent("EventDoExt")
        end
    else
--        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() + 5);
--        if bodyDamage:getUnhappynessLevel() > 100 then
--            bodyDamage:setUnhappynessLevel(100);
--        end
        -- make the character cough
        if ZombRand(3) ~= 0 then
            -- make the character cough
            character:triggerCough()
--             character:setVariable("Ext", "Cough")
--             character:reportEvent("EventDoExt")
        end
        bodyDamage:setFoodSicknessLevel(bodyDamage:getFoodSicknessLevel() + 28 * percent);
        if bodyDamage:getFoodSicknessLevel() > 100 then
            bodyDamage:setFoodSicknessLevel(100);
        end
    end
end

function OnEat_ChewingTobacco(food, character)
    local percent = 1
    local bodyDamage = character:getBodyDamage()
    local stats = character:getStats()
    if character:HasTrait("Smoker") then

        bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() - 10 * percent);
        if bodyDamage:getUnhappynessLevel() < 0 then
            bodyDamage:setUnhappynessLevel(0);
        end
        stats:setStress(stats:getStress() - 10 * percent);
        if stats:getStress() < 0 then
            stats:setStress(0);
        end
        local reduceSFC = stats:getMaxStressFromCigarettes()
        stats:setStressFromCigarettes(stats:getStressFromCigarettes() - reduceSFC * percent);
        character:setTimeSinceLastSmoke(stats:getStressFromCigarettes() / stats:getMaxStressFromCigarettes());
    else
        bodyDamage:setFoodSicknessLevel(bodyDamage:getFoodSicknessLevel() + 14 * percent);
        if bodyDamage:getFoodSicknessLevel() > 100 then
            bodyDamage:setFoodSicknessLevel(100);
        end
    end
end

function OnEat_CorrectionFluid(food, character)
    local percent = 1
    local bodyDamage = character:getBodyDamage()

    bodyDamage:setUnhappynessLevel(bodyDamage:getUnhappynessLevel() - 5 * percent);
    if bodyDamage:getUnhappynessLevel() < 0 then
        bodyDamage:setUnhappynessLevel(0);
    end
    bodyDamage:setBoredomLevel(bodyDamage:getBoredomLevel() - 5 * percent);
    if bodyDamage:getBoredomLevel() < 0 then
        bodyDamage:setBoredomLevel(0);
    end

    bodyDamage:setFoodSicknessLevel(bodyDamage:getFoodSicknessLevel() + 10 * percent);
    if bodyDamage:getFoodSicknessLevel() > 100 then
        bodyDamage:setFoodSicknessLevel(100);
    end
end


function OnEat_RatPoison(food, character)
    local bodyDamage = character:getBodyDamage()
    bodyDamage:setPoisonLevel(100)
	bodyDamage:setFoodSicknessLevel(100)
	character:getStats():setThirst(100)
end

----- OnEat_WildFoodGeneric IS NOT RECIPE CODE.  IT IS CALLED BY IsoGameCharacter.Eat() -----
-- if item is poisoned, apply the rest of its negative effects here
function OnEat_WildFoodGeneric(food, character, percent)
    local script = food:getScriptItem();
    local bodyDamage = character:getBodyDamage();
    local stats = character:getStats();
    if food:getPoisonPower() > 0 then
        bodyDamage:setFoodSicknessLevel(bodyDamage:getFoodSicknessLevel() + (50 * percent));
        if bodyDamage:getFoodSicknessLevel() > 100 then
            bodyDamage:setFoodSicknessLevel(100);
        end;
    end;
end

function Recipe.GetItemTypes.CraftSheetRope(scriptItems)
    local allScriptItems = getScriptManager():getAllItems()
    for i=1,allScriptItems:size() do
        local scriptItem = allScriptItems:get(i-1)
        if (scriptItem:getType() == Type.Clothing) and scriptItem:getFabricType() then
            local crd = ClothingRecipesDefinitions["FabricType"][scriptItem:getFabricType()]
            if (not scriptItem:hasTag("noRope")) and crd and not crd.noSheetRope then
                scriptItems:add(scriptItem)
            end
        elseif (not scriptItem:hasTag("noRope")) and ClothingRecipesDefinitions[scriptItem:getName()] then
            scriptItems:add(scriptItem) -- Base.Sheet
        end
    end
end

local function RipClothing_GetItemTypes_XXX(scriptItems, fabricType)
    if not ClothingRecipesDefinitions["FabricType"][fabricType] then
        return
    end
    local allScriptItems = getScriptManager():getAllItems()
    for i=1,allScriptItems:size() do
        local scriptItem = allScriptItems:get(i-1)
        if (scriptItem:getType() == Type.Clothing) and (scriptItem:getFabricType() == fabricType) then
            if ClothingRecipesDefinitions[scriptItem:getName()] then
                -- ignore
            else
                scriptItems:add(scriptItem)
            end
        end
    end
end

-- Code copied from TimedActions/ISRipClothing.lua
function Recipe.OnCreate.RipClothing(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local item = items:get(0) -- assumes any tool comes after this in recipes.txt

    -- either we come from clothingrecipesdefinitions or we simply check number of covered parts by the clothing and add
    local materials = nil
    local nbrOfCoveredParts = nil
    local maxTime = 0 -- TODO: possibly allow recipe to call Lua function to get maxTime for actions
    if ClothingRecipesDefinitions[item:getType()] then
        local recipe = ClothingRecipesDefinitions[item:getType()]
        materials = luautils.split(recipe.materials, ":");
        maxTime = tonumber(materials[2]) * 20;
    elseif ClothingRecipesDefinitions["FabricType"][item:getFabricType()] then
        materials = {};
        materials[1] = ClothingRecipesDefinitions["FabricType"][item:getFabricType()].material;
        -- we change this so the number of holes etc impact the yield
        nbrOfCoveredParts = item:getNbrOfCoveredParts() - (item:getHolesNumber() + item:getPatchesNumber());
--         nbrOfCoveredParts = item:getNbrOfCoveredParts();
        if nbrOfCoveredParts == 0 then nbrOfCoveredParts = 1 end
        local minMaterial = 2;
        local maxMaterial = nbrOfCoveredParts;
        if nbrOfCoveredParts == 1 then
            minMaterial = 1;
        end

        local nbr = ZombRand(minMaterial, maxMaterial + 1);
        nbr = nbr + (character:getPerkLevel(Perks.Tailoring) / 2);
        if nbr > nbrOfCoveredParts then
            nbr = nbrOfCoveredParts;
        end
        materials[2] = nbr;
    
        maxTime = nbrOfCoveredParts * 20;
    else
        error "Recipe.OnCreate.RipClothing"
    end

    for i=1,tonumber(materials[2]) do
        local item2;
        local dirty = false;
        if instanceof(item, "Clothing") then
            dirty = (ZombRand(100) <= item:getDirtyness() + item:getBloodlevel());
--             dirty = (ZombRand(100) <= item:getDirtyness()) or (ZombRand(100) <= item:getBloodlevel());
        end
        if not dirty then
            item2 = instanceItem(materials[1]);
        elseif getScriptManager():FindItem(materials[1] .. "Dirty") then
            item2 = instanceItem(materials[1] .. "Dirty");
        else
            item2 = instanceItem(materials[1])
        end
        character:getInventory():AddItem(item2);
    end

    -- no more thread or tailoring xp, players will properly grind those as part of crafting

    -- add thread sometimes, depending on tailoring level
--     if ZombRand(7) < player:getPerkLevel(Perks.Tailoring) + 1 then
--         local max = 2;
--         if nbrOfCoveredParts then
--             max = nbrOfCoveredParts;
--             if max > 6 then
--                 max = 6;
--             end
--         end
--         max = ZombRand(2, max);
--         local thread = instanceItem("Base.Thread");
--         for i=1,10-max do
--             thread:Use();
--         end
--         player:getInventory():AddItem(thread);
        -- no more xp for ripping clothes, as we want players making things for crafting xp
--         if player:getPerkLevel(Perks.Tailoring) < (SandboxVars.LevelForDismantleXPCutoff) then
--             player:getXp():AddXP(Perks.Tailoring, 1);
--         end
--     end

    if item:hasTag("Buckles") then character:getInventory():AddItems("Base.Buckle", 2)
    elseif item:hasTag("Buckle") then character:getInventory():AddItem("Base.Buckle") end
end

function Recipe.OnCreate.PickThread(craftRecipeData, character)
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setCurrentUses(1)
end

function Recipe.OnCreate.GatherGunpowder(craftRecipeData, character)
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setCurrentUses(1)
end

-- check clothings are dirty or bloody
function Recipe.OnTest.WashClothing(sourceItem, result)
    if instanceof(sourceItem, "Clothing") then
        return sourceItem:isDirty() or sourceItem:isBloody();
    else
        return true;
    end
end

-- wash the clothing!
function Recipe.OnCreate.WashClothing(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
    for i=0,items:size() - 1 do
        if instanceof (items:get(i), "Clothing") then
            items:get(i):setDirtyness(0);
            items:get(i):setBloodLevel(0);
            return;
        end
    end
end

-- get the spear, lower its condition according to woodwork perk level
-- also lower the used knife condition
function Recipe.OnCreate.CreateSpear(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	-- removed this spear crafting nerf because is was misinterpreted as a bug; the spears now have a greater chance of being damaged on stiking
	local skill = character:getPerkLevel(Perks.Woodwork)
    local conditionMax = 2 + skill
    conditionMax = ZombRand(conditionMax, conditionMax + 2)
    conditionMax = math.min(conditionMax, result:getConditionMax())
    conditionMax = math.max(conditionMax, 2)
    -- if conditionMax > result:getConditionMax() then
        -- conditionMax = result:getConditionMax();
    -- end
    -- if conditionMax < 2 then
        -- conditionMax = 2;
    -- end
    result:setCondition(conditionMax)

	local item, itemCategories;
    for i=0,items:size() - 1 do
		item = items:get(i);
		if item then
			itemCategories = item:getCategories();
			if (instanceof(item, "HandWeapon") and (itemCategories:contains("SmallBlade") or itemCategories:contains("LongBlade") or itemCategories:contains("Axe") ) )
			or item:hasTag("SharpKnife") then
				item:damageCheck(skill, 1, false)
	-- 		    if ZombRand(item:getConditionLowerChance() + skill) == 0 then items:get(i):setCondition(items:get(i):getCondition() - 1) end
			end
		end
--         if items:get(i):getType() == "SharpedStone" and ZombRand(3) == 0 then
--             player:getInventory():Remove(items:get(i))
--         end
    end
end
function Recipe.OnCreate.FireHardenSpear(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	-- removed this spear crafting nerf because is was misinterpreted as a bug; the spears now have a greater chance of being damaged on stiking
	local skill = character:getPerkLevel(Perks.Woodwork)
    local spear = nil

    for i=0,items:size() - 1 do
        if  instanceof (items:get(i), "HandWeapon")	and  items:get(i):getCategories():contains("Spear")  then
		    spear = items:get(i)
        end
    end

    local conditionMax = 2 + skill
    conditionMax = ZombRand(conditionMax, conditionMax + 2)
    conditionMax = math.min(conditionMax, result:getConditionMax())
    if spear then conditionMax = math.max(conditionMax, spear:getCondition()) end
    conditionMax = math.max(conditionMax, 2)
    -- if conditionMax > result:getConditionMax() then
        -- conditionMax = result:getConditionMax();
    -- end
    -- if conditionMax < 2 then
        -- conditionMax = 2;
    -- end
    result:setCondition(conditionMax)
end

-- get a mix of spear & upgrade item to do a correct condition of the result
-- we take the craftedSpear condition and substract the attached weapon condition
function Recipe.OnCreate.UpgradeSpear(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local conditionMax = 0;
    local handle
    local head
    for i=0,items:size() - 1 do
        if items:get(i):hasTag("LongStick") then
            handle = items:get(i)
        end
    end
    for i=0,items:size() - 1 do
        if instanceof (items:get(i), "HandWeapon") or items:get(i):hasTag("SpearHead") and items:get(i):getType() ~= "SpearCrafted" then
            head = items:get(i)
        end
    end

    if handle then result:setConditionFrom(handle) end
    if result:getCondition() < 2 then result:setCondition(2) end

    if head then result:setHeadConditionFromCondition(head) end
--     if conditionMax > result:getConditionMax() then
--         conditionMax = result:getConditionMax();
--     end
--     if conditionMax < 2 then
--         conditionMax = 2;
--     end
--
--     result:setCondition(conditionMax);
--
--     local conditionMax = 0;
--     for i=0,items:size() - 1 do
--         if items:get(i):getType() == "SpearCrafted" then
--             conditionMax = items:get(i):getCondition()
--         end
--     end
--
--     for i=0,items:size() - 1 do
--         if instanceof (items:get(i), "HandWeapon") and items:get(i):getType() ~= "SpearCrafted" then
--             conditionMax = conditionMax - ((items:get(i):getConditionMax() - items:get(i):getCondition())/2)
--         end
--     end
--
--     if conditionMax > result:getConditionMax() then
--         conditionMax = result:getConditionMax();
--     end
--     if conditionMax < 2 then
--         conditionMax = 2;
--     end
--
--     result:setCondition(conditionMax);
end

-- when we reclaim the weapon from a spear we get the weapon back
-- we also want to return the spear with appropriate condition
function Recipe.OnCreate.DismantleSpear(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems()
	--todo: check if this is actually the spear
	local spear = items:get(0);
	local results = craftRecipeData:getAllCreatedItems()
    for i=0,results:size() - 1 do
        local result = results:get(i)
        if result:getType() == "LongStick" then
            result:setConditionFrom(spear)
        elseif result:getType() ~= "LongStick_Broken" then
            result:setConditionFromHeadCondition(spear)
        end
    end
end

function Recipe.OnCreate.SliceWatermelon(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "Watermelon" then
		    for i=0,results:size() - 1 do
				local result = results:get(i)
				result:setBaseHunger(item:getBaseHunger() / 10);
				result:setHungChange(item:getHungChange() / 10);
				result:setBoredomChange(item:getBoredomChangeUnmodified() / 10)
				result:setUnhappyChange(item:getUnhappyChangeUnmodified() / 10)
				result:setCalories(item:getCalories() / 10)
				result:setCarbohydrates(item:getCarbohydrates() / 10)
				result:setLipids(item:getLipids() / 10)
				result:setProteins(item:getProteins() / 10)
			end
        end
    end
end

function Recipe.OnCreate.SliceHam(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "Ham" or item:getType() == "Baloney" then
			for i=0,results:size() - 1 do
				local result = results:get(i)
				result:setBaseHunger(item:getBaseHunger() / 6);
				result:setHungChange(item:getHungChange() / 6);
				result:setBoredomChange(item:getBoredomChangeUnmodified() / 6)
				result:setUnhappyChange(item:getUnhappyChangeUnmodified() / 6)
				result:setCalories(item:getCalories() / 6)
				result:setCarbohydrates(item:getCarbohydrates() / 6)
				result:setLipids(item:getLipids() / 6)
				result:setProteins(item:getProteins() / 6)
			end
        end
    end
end

function Recipe.OnCreate.SliceSalami(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "Salami" then
			for i=0,results:size() - 1 do
				local result = results:get(i)
				result:setBaseHunger(item:getBaseHunger() / 5);
				result:setHungChange(item:getHungChange() / 5);
				result:setBoredomChange(item:getBoredomChangeUnmodified() / 5)
				result:setUnhappyChange(item:getUnhappyChangeUnmodified() / 5)
				result:setCalories(item:getCalories() / 5)
				result:setCarbohydrates(item:getCarbohydrates() / 5)
				result:setLipids(item:getLipids() / 5)
				result:setProteins(item:getProteins() / 5)
			end
        end
    end
end

function Recipe.OnCreate.OpenCan(craftRecipeData, character)
	if not character then return end
	local items = craftRecipeData:getAllConsumedItems();
	local canOpener = false
-- 	local smallBlade = false
	local chippedStone = false
	local opener = nil
    for i=0,items:size() - 1 do
		item = items:get(i)
		if items:get(i):getType() == "SharpedStone" then
				chippedStone = true
	    end
        if item:hasTag("CanOpener") then
			canOpener = true
--         elseif items:get(i):getType() == "SharpedStone" then
-- 			if ZombRand(3) == 0 then
-- 				player:getInventory():Remove(items:get(i))
-- 			end
        elseif instanceof (items:get(i), "HandWeapon") or items:get(i):hasTag("SharpKnife")  or items:get(i):getType() == "SharpedStone" then
            opener = items:get(i)
            opener:damageCheck()
--             if ZombRand(opener:getConditionLowerChance()) == 0 then opener:setCondition(opener:getCondition() - 1) end
            if opener:getCategories():contains("SmallBlade") then
                --smallBlade = true
            end
        end
    end
	if not canOpener then
		local woundChance = 3
		if chippedStone then woundChance = woundChance + 1 end
		if character:getTraits():contains("Lucky") then woundChance = woundChance - 2
		elseif character:getTraits():contains("Unlucky") then woundChance = woundChance + 2 end
		if character:getTraits():contains("Dextrous") then woundChance = woundChance - 2
		elseif character:getTraits():contains("Clumsy") then woundChance = woundChance + 2 end
        -- not a bug, knife skills are relevant here
		if character:getPerkLevel(Perks.SmallBlade) > 5 then
		     woundChance = woundChance  - 2
		elseif character:getPerkLevel(Perks.SmallBlade) > 3 then
		     woundChance = woundChance  - 1
		elseif
		    character:getPerkLevel(Perks.SmallBlade) < 1 then woundChance = woundChance  + 1
		end
		if character:getPerkLevel(Perks.Cooking) > 5 then
		     woundChance = woundChance  - 2
		elseif character:getPerkLevel(Perks.Cooking) > 3 then
		     woundChance = woundChance  - 1
		elseif
		     character:getPerkLevel(Perks.Cooking) < 1 then woundChance = woundChance  + 1
		end
		local roll = 20
		if woundChance < 1 then
		    woundChance = 1
		    roll = 30
		end

		if ZombRand(roll) <= woundChance then
		    local weapon = opener
		    if not instanceof(weapon, "HandWeapon") then
	            weapon = instanceItem("Base.KitchenKnife")

            end
			character:getBodyDamage():DamageFromWeapon(weapon, BodyPartType.ToIndex(BodyPartType.Hand_L));
		end
	end
end

Recipe.MysteryCans = {
    "Base.CannedBologneseOpen",
    "Base.CannedCarrotsOpen",
    "Base.CannedChiliOpen",
    "Base.CannedCornOpen",
    "Base.CannedFruitCocktailOpen",

    "Base.CannedPeachesOpen",
    "Base.CannedPeasOpen",
    "Base.CannedPineappleOpen",
    "Base.CannedPotatoOpen",
    "Base.CannedTomatoOpen",

    "Base.DogfoodOpen",
    "Base.OpenBeans",
}

function Recipe.OnCreate.OpenMysteryCan(craftRecipeData, character)
	local list = Recipe.MysteryCans
	local emptyType = list[ZombRand(#list)+1]
    local result = character:getInventory():AddItem(emptyType)
    result:setTexture(getTexture("Item_CannedUnlabeled_Open"))
--     result:setTexture(getTexture("media/textures/Item_CannedUnlabeled_Open.png"))
    result:setWorldStaticModel("TinCanEmpty_Ground")
    result:setStaticModel("MysteryCan_Open")
    result:getModData().NoLabel = "true"
end

function Recipe.OnCreate.OpenMysteryCanKnife(craftRecipeData, character)
    Recipe.OnCreate.OpenCan(craftRecipeData, character)
    Recipe.OnCreate.OpenMysteryCan(craftRecipeData, character)
end

function Recipe.OnCreate.OpenWaterCan(craftRecipeData, character)
	if not character then return end
    local item = character:getInventory():AddItem("Base.WaterRationCanEmpty")
--     local item = character:getInventory():AddItem("Base.TinCanEmpty")

--     item:setTexture(getTexture("Item_CannedWater_Open"))
--     item:setWorldStaticModel("WaterRationCan_Open")
--     item:setStaticModel("WaterRationCan_Open")
--     item:getFluidContainer():addFluid(FluidType.Water, 0.3)
    item:getFluidContainer():addFluid(FluidType.Water, 0.3)
end

function Recipe.OnCreate.OpenWaterCanKnife(craftRecipeData, character)
    Recipe.OnCreate.OpenCan(craftRecipeData, character)
    Recipe.OnCreate.OpenWaterCan(craftRecipeData, character)
end

function Recipe.OnCreate.OpenDentedCan(craftRecipeData, character)
	local list = Recipe.MysteryCans
	local emptyType = list[ZombRand(#list)+1]
    local result = character:getInventory():AddItem(emptyType)
    result:setTexture(getTexture("Item_CannedUnlabeled_Open_Gross"))
--     result:setTexture(getTexture("media/textures/Item_CannedUnlabeled_Open_Gross.png"))
    result:setWorldStaticModel("DentedCan_Open")
    result:setStaticModel("DentedCan_Open")
    if ZombRand(10) == 4 then
        result:setAge(result:getOffAgeMax())
        result:setRotten(true)
        result:setTexture(getTexture("Item_CannedUnlabeled_Open_Gross2"))
        result:setWorldStaticModel("DentedCan_Open_Gross")
        result:setStaticModel("DentedCan_Open_Gross")
    elseif ZombRand(10) ~= 4 then
        result:setAge(ZombRand(result:getOffAge(), result:getOffAgeMax()))
    end
    result:getModData().NoLabel = "true"
    if (not result:isFresh()) and ZombRand(4) == 0 then
        result:setPoisonPower(ZombRand(10))
        result:setPoisonDetectionLevel(ZombRand(5))
    end
end

function Recipe.OnCreate.OpenDentedCanKnife(items, result, player, selectedItem)
    Recipe.OnCreate.OpenCan(items, result, player, selectedItem)
    Recipe.OnCreate.OpenDentedCan(items, result, player, selectedItem)
end

function Recipe.OnCreate.CloseUmbrella(craftRecipeData, character)
	local item = craftRecipeData:getAllConsumedItems():get(0);
	local result = craftRecipeData:getAllCreatedItems():get(0);
	result:setCondition(item:getCondition());
end

function Recipe.GetItemTypes.DismantleDigitalWatch(scriptItems)
    local allScriptItems = getScriptManager():getAllItems();
    for i=1,allScriptItems:size() do
        local scriptItem = allScriptItems:get(i-1);
        if (scriptItem:getType() == Type.AlarmClockClothing) and string.contains(scriptItem:getName(), "Digital") then
            scriptItems:add(scriptItem);
        end
    end
end

-- Example OnCanPeform function.
function Recipe.OnCanPerform.HockeyMaskSmashBottle(recipe, playerObj)
	local wornItem = playerObj:getWornItem("MaskEyes")
	return (wornItem ~= nil) and (wornItem:getType() == "Hat_HockeyMask")
end

-- only clean if not cooked, to avoid mistake instead of clicking "get muffins"
function Recipe.OnCanPerform.CleanMuffin(recipe, playerObj, item)
    return item and not item:isCooked();
end

-- Muffins need to be cooked first
function Recipe.OnCanPerform.GetMuffin(recipe, playerObj, item)
    return item and (item:isCooked() or item:isBurnt());
end

function Recipe.OnCreate.GetMuffin(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
	local muffins = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            muffins = items:get(i);
            break;
        end
    end
	if not muffins then return end
	for i=0,results:size() - 1 do
		local result = results:get(i)
		result:setBaseHunger(muffins:getBaseHunger() / 6);
		result:setHungChange(muffins:getHungChange() / 6);
		result:setCalories(muffins:getCalories() / 6);
		result:setProteins(muffins:getProteins() / 6);
		result:setLipids(muffins:getLipids() / 6);
		result:setCarbohydrates(muffins:getCarbohydrates() / 6);

		-- This gives a bonus. See Food.getHungerChange().
		result:setCooked(true);

		result:setName(muffins:getDisplayName());
		result:setCustomName(true);
	end
	if not character then return end
    character:getInventory():Remove(muffins);
end

function Recipe.OnCanPerform.GetBiscuit(recipe, playerObj, item)
    return item and (item:isCooked() or item:isBurnt());
end

function Recipe.OnCreate.GetBiscuit(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	local cookie = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            cookie = items:get(i);
            break;
        end
    end
	if not cookie then return end
	if cookie:isBurnt() then result:setBurnt(true) end
    -- result:setBaseHunger(selectedItem:getBaseHunger() / 6);
    -- result:setHungChange(selectedItem:getHungChange() / 6);
    -- result:setCalories(selectedItem:getCalories() / 6);
    -- result:setProteins(selectedItem:getProteins() / 6);
    -- result:setLipids(selectedItem:getLipids() / 6);
    -- result:setCarbohydrates(selectedItem:getCarbohydrates() / 6);
	if not character then return end
    character:getInventory():Remove(cookie);
end


function Recipe.OnCreate.GetCookies(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	local cookie = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            cookie = items:get(i);
            break;
        end
    end
	if not cookie then return end
	if cookie:isBurnt() then result:setBurnt(true) end
    -- result:setBaseHunger((selectedItem:getBaseHunger() / 6)+1);
    -- result:setBaseHunger(selectedItem:getHungChange() / 6);
    -- result:setHungChange(selectedItem:getHungChange() / 6);
    -- result:setCalories(selectedItem:getCalories() / 6);
    -- result:setProteins(selectedItem:getProteins() / 6);
    -- result:setLipids(selectedItem:getLipids() / 6);
    -- result:setCarbohydrates(selectedItem:getCarbohydrates() / 6);
	if not character then return end
    character:getInventory():Remove(selectedItem);
end

function Recipe.OnCanPerform.SlicePizza(recipe, playerObj, item)
	if item and (item:getType() == "PizzaWhole" or item:getType() == "PizzaRecipe") then return true end;
    return item and (item:isCooked() or item:isBurnt());
end

function Recipe.OnCreate.SlicePizza(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
	local pizza = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            pizza = items:get(i);
            break;
        end
    end
	for i=0,results:size() - 1 do
		local result = results:get(i);
		if not pizza then return end
		if pizza:isBurnt() then result:setBurnt(true) end
		if pizza:isCooked() then result:setCooked(true) end
		result:setBaseHunger(pizza:getBaseHunger() / 6);
		result:setHungChange(pizza:getHungChange() / 6);
		-- result:setUnhappyChange(pizza:getUnhappyChange() / 6);
		-- result:setBoredomChange(pizza:getBoredomChange() / 6);
		result:setUnhappyChange(pizza:getUnhappyChange() );
		result:setBoredomChange(pizza:getBoredomChange() );
		result:setCalories(pizza:getCalories() / 6);
		result:setProteins(pizza:getProteins() / 6);
		result:setLipids(pizza:getLipids() / 6);
		result:setCarbohydrates(pizza:getCarbohydrates() / 6);
		if pizza:haveExtraItems() then
			for i=0,pizza:getExtraItems():size() - 1 do
				local extraItem = pizza:getExtraItems():get(i);
				result:addExtraItem(extraItem);
			end
		end
		if pizza:getDisplayName() then
			result:setName(getText("Tooltip_food_Slice", pizza:getDisplayName()));
			result:setCustomName(true);
		end
	end
	if not character then return end
    character:getInventory():Remove(pizza);
end

function Recipe.OnCreate.DynamicMovable(items, result, player, selectedItem)
    if instanceof(selectedItem, "Moveable") then
        local sprite = selectedItem:getWorldSprite();
        --print("onCreate sprite = "..tostring(sprite));
        local props = ISMoveableSpriteProps.new( sprite );

        local items = props:getScrapItemsList(player);

        local added = 0;

        for k,v in ipairs(items.usable) do
            --print(" - adding usable = "..tostring(v));
            local item 	= instanceItem( v );
            if item then
                if props.keyId and props.keyId ~= -1 then
                    if item:getType() == "Doorknob" then
                        item:setKeyId(props.keyId)
                    end
                end
                player:getInventory():AddItem(item);
                added = added +1;
            end
        end
        for k,v in ipairs(items.unusable) do
            --print(" - adding unusable = "..tostring(v));
            if v then
                player:getInventory():AddItem(v);
            end
        end

        props:scrapHaloNoteCheck(player, added)
    else
        print("Recipe.OnCreate.DynamicMovable, this isnt a movable item?")
    end
end
function Recipe.OnGiveXP.DynamicMovable(recipe, ingredients, result, player)
    if instanceof(recipe, "MovableRecipe") then
        local sprite = recipe:getWorldSprite();
        --print("onXp sprite = "..tostring(sprite));
        local props = ISMoveableSpriteProps.new( sprite );
        props:scrapGiveXp(player, false);
    else
        print("Recipe.OnGiveXP.DynamicMovable, this isnt a Movable recipe?")
    end
end

--Open sealed bag of produce to get contents + empty sack.
function Recipe.OnCreate.OpenSackProduce(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setAge(items:get(0):getAge());
end

function Recipe.OnCreate.BeanBowl(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    for i=0,items:size() - 1 do
        local item = items:get(i);
        if (item:getType() == "OpenBeans") then
			for i=0,results:size() - 1 do
				local result = results:get(i)
				result:setAge(item:getAge());
				result:setBaseHunger(item:getBaseHunger());
				result:setHungChange(item:getHungChange());
				result:setCarbohydrates(item:getCarbohydrates());
				result:setLipids(item:getLipids());
				result:setProteins(item:getProteins());
				result:setCalories(item:getCalories());
			end
        end;
    end;
end

function Recipe.OnCreate.MakeOatmeal(craftRecipeData, character)
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setHeat(2.5);
	result:setCooked(true);
end

function Recipe.OnCreate.MakeCooked(craftRecipeData, character)
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setHeat(2.5);
	result:setCooked(true);
end

function Recipe.OnCreate.CarvePumpkin(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	local pumpkin = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            pumpkin = items:get(i);
            break;
        end
    end
	if not pumpkin then return end
    result:setBaseHunger(pumpkin:getBaseHunger() );
    result:setHungChange(pumpkin:getHungChange() );
    result:setCalories(pumpkin:getCalories() );
    result:setProteins(pumpkin:getProteins() );
    result:setLipids(pumpkin:getLipids() );
    result:setCarbohydrates(pumpkin:getCarbohydrates());
end

function Recipe.OnCreate.SliceOnion(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local onion = nil;
    for i=0,items:size() - 1 do
        if instanceof(items:get(i), "Food") then
            onion = items:get(i);
            break;
        end
    end
    if onion then
        local hunger = math.max(onion:getBaseHunger(),onion:getHungChange())
        result:setBaseHunger(hunger / 2);
        result:setHungChange(hunger / 2);
        result:setCarbohydrates(onion:getCarbohydrates() / 2);
        result:setLipids(onion:getLipids() / 2);
        result:setProteins(onion:getProteins() / 2);
        result:setCalories(onion:getCalories() / 2);
        result:setCooked(onion:isCooked());
		result:setAge(onion:getAge() * ( result:getDaysFresh()/ onion:getDaysFresh()) );
    end
end

function Recipe.OnCreate.OpenBeer(craftRecipeData, character)
	local items = craftRecipeData:getAllKeepInputItems();
    for i=0,items:size() - 1 do
        if items:get(i):getFluidContainer() then
            items:get(i):getFluidContainer():setCanPlayerEmpty(true);
			local copy = items:get(i):getFluidContainer():copy();
			items:get(i):getFluidContainer():copyFluidsFrom(copy);
			FluidContainer.DisposeContainer(copy);
            break;
        end
    end
end

function Recipe.OnCreate.OpenChampagne(craftRecipeData, character)
	local result = craftRecipeData:getAllCreatedItems():get(0);
	result:setAge(0);
	if not character then return end
    character:getInventory():AddItem("Base.Cork");
end

function Recipe.OnCreate.OpenBagFrozenFood(craftRecipeData, character)
	local item = craftRecipeData:getAllConsumedItems():get(0);
	local results = craftRecipeData:getAllCreatedItems();
	
	for i=0,results:size() - 1 do
        if instanceof(results:get(i), "Food") then
            result = results:get(i);
			result:setAge(item:getAge())
			result:setFrozen(item:isFrozen())
			result:setFreezingTime(item:getFreezingTime())
        end
    end
end

function Recipe.OnTest.CanAddToPack(item)
	if not instanceof(item, "DrainableComboItem") then return true end
    if item:hasTag("Packed") then return item:getCurrentUsesFloat() < 1 end
	return true;
end

function Recipe.OnTest.IsFull(sourceItem)
	if not instanceof(item, "DrainableComboItem") then return true end
    if sourceItem:hasTag("Packed") then return sourceItem:getCurrentUsesFloat() >= 1 end
	return true;
end

function Recipe.OnCreate.AddToPack(craftRecipeData, character)
	local items = craftRecipeData:getAllKeepInputItems();
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:hasTag("Packed") then
            item:setCurrentUses(item:getUses() + 1)
            break;
        end
    end
end

function Recipe.OnCreate.PurifyWaterContainer(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	for i=0, items:size()-1 do
		local item = items:get(i)
		if item:isWaterSource() then
			item:setTaintedWater(false)
		end
	end
end

function Recipe.OnCreate.DrawRandomCard(craftRecipeData, character)
	if not character then return end
	local card  = getText(ServerOptions.getRandomCard())
	if isClient() then
		local text  = "* " .. character:getUsername().. " " .. getText("IGUI_Draws") .." " .. card .. " *"
		character:Say(text)
	else
		HaloTextHelper.addGoodText(character, card);
	end
end

function Recipe.OnCreate.RollOneDice(craftRecipeData, character)
	if not character then return end
	local item = craftRecipeData:getAllKeepInputItems():get(0);
	local dieName = getText(item:getDisplayName())
	local roll = tostring(ZombRand(6) + 1)
	if isClient() or isServer() then
		local text  = "* " .. character:getUsername().. " " .. getText("IGUI_Rolls") .. " " .. roll .. " " .. getText("IGUI_With") .. " " .. getText("IGUI_One") .. " " .. dieName .. " *"
		character:Say(text)
	else
		HaloTextHelper.addGoodText(character, roll);
-- 		HaloTextHelper.addText(character, roll, getCore():getGoodHighlitedColor());
	end
end

function Recipe.OnCreate.RollDice(craftRecipeData, character)
	if not character then return end
	local item = craftRecipeData:getAllKeepInputItems():get(0);
	local dieName = getText("IGUI_With") .. " " .. getText("IGUI_A") .. " " .. getText(item:getDisplayName())
	local roll --= tostring(ZombRand(6) + 1)
	if item:hasTag("2d6") then
		roll = ZombRand(6) + ZombRand(6) + 2
		dieName = getText("IGUI_With") .. " " .. getText("IGUI_One") .. " " .. getText(item:getDisplayName()) 
	elseif item:hasTag("d4") then
		roll = ZombRand(4) + 1
	elseif item:hasTag("d6") then
		roll = ZombRand(6) + 1
	elseif item:hasTag("d8") then
		roll = ZombRand(8) + 1
	elseif item:hasTag("d10") then
		roll = ZombRand(10) + 1
	elseif item:hasTag("d12") then
		roll = ZombRand(12) + 1
	elseif item:hasTag("d20") then
		roll = ZombRand(20) + 1
	elseif item:hasTag("d00") then
		roll = (ZombRand(10) ) * 10
		if roll < 10 then roll = 0 + tostring(roll) end
	end
	roll= tostring(roll)
	if isClient() or isServer() then
		local text  = "* " .. character:getUsername().. " " .. getText("IGUI_Rolls") .. " " .. roll .. " " .. dieName .. " *"
		character:Say(text)
	else
		HaloTextHelper.addGoodText(character, roll);
-- 		HaloTextHelper.addText(character, roll, getCore():getGoodHighlitedColor());
	end
end

function Recipe.OnCreate.Roll3d6(craftRecipeData, character)
	if not character then return end
	local item = craftRecipeData:getAllKeepInputItems():get(0);
	local dieName = getText("IGUI_With") .. " " .. getText("IGUI_Three") .. " " .. getText(item:getDisplayName())
	local roll = ZombRand(6) + ZombRand(6) + ZombRand(6) + 4
	roll= tostring(roll)
	if isClient() or isServer() then
		local text  = "* " .. character:getUsername().. " " .. getText("IGUI_Rolls") .. " " .. roll .. " " .. dieName .. " *"
		character:Say(text)
	else
		HaloTextHelper.addGoodText(character, roll);
-- 		HaloTextHelper.addText(character, roll, getCore():getGoodHighlitedColor());
	end
end

function Recipe.OnCreate.Rolld100(craftRecipeData, character)
	if not character then return end
	local item = craftRecipeData:getAllKeepInputItems():get(0);
	local dieName = getText("IGUI_With") .. " " .. getText("IGUI_Three") .. " " .. getText(item:getDisplayName())
	local roll = ZombRand(100) + 4
	roll= tostring(roll)
	if isClient() or isServer() then
		local text  = "* " .. character:getUsername().. " " .. getText("IGUI_Rolls") .. " " .. roll .. " " .. getText("IGUI_With") .. " " .. getText("IGUI_PercentileDice") .. " *"
		character:Say(text)
	else
		HaloTextHelper.addGoodText(character, roll);
-- 		HaloTextHelper.addText(character, roll, getCore():getGoodHighlitedColor());
	end
end


-- Return true if recipe is valid, false otherwise
function Recipe.OnTest.Propane_RefillRemoval (item)
	if not instanceof(item, "DrainableComboItem") then return true end
	return item:getCurrentUsesFloat() > 0;
end

function Recipe.OnCreate.Propane_RefillRemoval(craftRecipeData, character)
	local items = craftRecipeData:getAllKeepInputItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	for i=0, items:size()-1 do
		local item = items:get(i)
		-- we found the refill we change his used delta according to the refill
		if item:getType() == "Lantern_Propane" then
			result:setUsedDelta(item:getCurrentUsesFloat());
			-- then we empty the torch used delta (his energy)
			item:setUsedDelta(0);
		end
	end
end

-- Return true if recipe is valid, false otherwise
function Recipe.OnTest.Propane_RefillInsert(sourceItem, result)
	if sourceItem:getType() == "Lantern_Propane" then
		return sourceItem:getCurrentUsesFloat() == 0; -- Only allow the refill inserting if the lantern has no refill left in it.
	end
	return true -- the battery
end

function Recipe.OnCreate.Propane_RefillInsert(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
  for i=0, items:size()-1 do
	-- we found the refill, we change his used delta according to the battery
	if items:get(i):getType() == "Propane_Refill" then
		result:setUsedDelta(items:get(i):getCurrentUsesFloat());
	end
  end
end

function Recipe.OnCreate.LightHurricaneLantern(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "Lantern_Hurricane" then
            result:setUsedDelta(item:getCurrentUsesFloat());
            result:setCondition(item:getCondition());
            result:setFavorite(item:isFavorite());
            if character:getPrimaryHandItem() == character:getSecondaryHandItem() then
                character:setPrimaryHandItem(nil)
            end
            character:setSecondaryHandItem(result);
            result:setActivated(true); --ensure the lantern emits light upon creation
        end
    end
end

function Recipe.OnCreate.ExtinguishHurricaneLantern(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    for i=0,items:size() - 1 do
        local item = items:get(i)
        if item:getType() == "Lantern_HurricaneLit" then
            result:setUsedDelta(item:getCurrentUsesFloat());
            result:setCondition(item:getCondition());
            result:setFavorite(item:isFavorite());
        end
    end
end



-- check when refilling the lantern that lantern is not full and petrol not empty
function Recipe.OnTest.RefillHurricaneLantern(item)
    if item:getType() == "Lantern_Hurricane" then
        if item:getCurrentUsesFloat() == 1 then return false; end
    elseif item:getFluidContainer() then
        if item:getFluidContainer():isEmpty() then return false; end
    end
    return true;
end

-- Fill entirely the lantern with the remaining petrol
function Recipe.OnCreate.RefillHurricaneLantern(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	items:addAll(craftRecipeData:getAllKeepInputItems())
	local result = craftRecipeData:getAllCreatedItems():get(0);
	local lantern, petrol, item;
    for i=0, items:size()-1 do
		item = items:get(i);
		if item then
			if item:getType() == "Lantern_Hurricane" then
			   lantern = item;
			elseif item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) then
			   petrol = item;
		   end
	   end
    end
    result:setUsedDelta(lantern:getCurrentUsesFloat() + result:getUseDelta() * 30);

    while result:getCurrentUsesFloat() < 1 and petrol:getFluidContainer():getAmount() >= 1.0 do
        result:setUsedDelta(result:getCurrentUsesFloat() + result:getUseDelta() * 10);
        petrol:getFluidContainer():adjustAmount(petrol:getFluidContainer():getAmount() - 1.0)
    end

    if result:getCurrentUsesFloat() > 1 then
        result:setUsedDelta(1);
    end
end

function Recipe.OnTest.ScratchTicket (sourceItem, result)
    local mData = sourceItem:getModData()
	return not mData.Scratched
end
Recipe.ScratchTicketWinnings =  {
    "$1",
    "$2",
    "$5",
    "$10",
    "$20",
    "$50",
    "$100",
    "$500",
    "$1000",
    "$5000",
    "$10000",
}
function Recipe.OnCreate.ScratchTicket(craftRecipeData, character)
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local mData = result:getModData();
    mData.Scratched = true
    local loser = getText("IGUI_Loser")
    local winner = getText("IGUI_Winner")
    local name = getText(result:getDisplayName())
    if ZombRand(5) == 0 then
        local rollMax = #Recipe.ScratchTicketWinnings
        local roll = ZombRand(rollMax)
        local roll2 = ZombRand(rollMax)
        if roll2 < roll then roll = roll2 end
        local roll2 = ZombRand(rollMax)
        if roll2 < roll then roll = roll2 end
        local roll2 = ZombRand(rollMax)
        if roll2 < roll then roll = roll2 end
        local roll2 = ZombRand(rollMax)
        if roll2 < roll then roll = roll2 end
        local roll2 = ZombRand(rollMax)
        if roll2 < roll then roll = roll2 end
        roll = roll + 1
        local sum = Recipe.ScratchTicketWinnings[roll]
        HaloTextHelper.addGoodText(character, sum)
        result:setName(name .. " - " .. winner .. " " .. sum)
        result:setTexture(getTexture("Item_ScratchTicket_Winner"))
        result:setWorldStaticModel("ScratchTicket_Winner")
    else
        result:setName(name .. " - " .. loser)
        result:setTexture(getTexture("Item_ScratchTicket_Loser"))
        result:setWorldStaticModel("ScratchTicket_Loser")
    end
end

-- check for clothing condition, to avoid conditional statement in RecipeManager.getUniqueRecipeItems
function Recipe.OnCanPerform.RipClothing(recipe, playerObj, item)
    if instanceof(item, "Clothing") then
        return item:getCondition()>0;
    else
        return true;
    end
end

function Recipe.OnCreate.MeatPatty(craftRecipeData, character)
	local item = craftRecipeData:getAllConsumedItems():get(0);
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setCooked(item:getCooked())
end


-- for eliminating empty cigarette packs and garbage bag boxes
function Recipe.OnCreate.CreateUnpack(craftRecipeData, character)
	if not character then return end
	local item = craftRecipeData:getAllConsumedItems():get(0);
    if item:getCurrentUses() <= 0 then
        character:getInventory():Remove(item)
    end
end
function Recipe.OnTest.EmptyBag (sourceItem, result)
	return sourceItem:getInventory():isEmpty();
end

function Recipe.OnCreate.MakeWireFromBarbedWire(craftRecipeData, character)
	local result = craftRecipeData:getAllCreatedItems():get(0);
    result:setUsedDelta(0.5)
end
function Recipe.OnTest.FullRoll (sourceItem, result)
    if sourceItem:getType() ~= "Wire" then return true end
	return sourceItem:getCurrentUsesFloat() == 1
end

-- Return true if recipe is valid, false otherwise
function Recipe.OnTest.GasmaskFilterRemoval (sourceItem, result)
	return sourceItem:hasFilter() and sourceItem:getFilterType() == "Base.GasmaskFilter";
-- 	return sourceItem:getCurrentUsesFloat() > 0 and sourceItem:hasFilter() and sourceItem:getFilterType() == "Base.GasmaskFilter";
end
function Recipe.OnTest.GasmaskFilterCraftedRemoval (sourceItem, result)
	return sourceItem:hasFilter() and sourceItem:getFilterType() == "Base.GasmaskFilterCrafted";
-- 	return sourceItem:getCurrentUsesFloat() > 0 and sourceItem:hasFilter() and sourceItem:getFilterType() == "Base.GasmaskFilterCrafted";
end
function Recipe.OnTest.RespiratorFilterRemoval (item)
	return item:hasFilter() and item:getFilterType() == "Base.RespiratorFilters";
-- 	return sourceItem:getCurrentUsesFloat() > 0 and sourceItem:hasFilter() and sourceItem:getFilterType() == "Base.GasmaskFilter";
end
function Recipe.OnTest.RespiratorFilterRechargedRemoval (sourceItem, result)
	return sourceItem:hasFilter() and sourceItem:getFilterType() == "Base.RespiratorFiltersRecharged";
-- 	return sourceItem:getCurrentUsesFloat() > 0 and sourceItem:hasFilter() and sourceItem:getFilterType() == "Base.GasmaskFilter";
end
--
-- When creating item in result box of crafting panel.
function Recipe.OnCreate.GasmaskFilterRemoval(craftRecipeData, character)
	if not character then return end
	local items = craftRecipeData:getAllKeepInputItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	for i=0, items:size()-1 do
		local item = items:get(i)
		-- we found the filter, we change his used delta according to the filter
		if item:hasTag("GasMask") then
		    if item:getWithoutDrainable() then
                result:setUsedDelta(item:getCurrentUsesFloat())
                local isWorn = item:isWorn()
                if isWorn then character:removeWornItem(item) end
                character:getInventory():Remove(item)
                local newItem =  ISClothingExtraAction:createItem(items:get(i), item:getWithoutDrainable())
                character:getInventory():AddItem(newItem)
                if isWorn then
                    character:setWornItem(newItem:getBodyLocation(), newItem)
                    triggerEvent("OnClothingUpdated", character)

                end
		    else
                item:setNoFilter()
                result:setUsedDelta(item:getCurrentUsesFloat());
                -- then we empty the mask used delta (his energy)
                item:setUsedDelta(0);
            end
		end
	end
end

-- Return true if recipe is valid, false otherwise
function Recipe.OnTest.GasmaskFilterInsert(sourceItem, result)
	if sourceItem:hasTag("GasMask")  or sourceItem:hasTag("GasMaskNoFilter") then
		return (not sourceItem:hasFilter()) and not sourceItem:isWorn(); -- Only allow the filter inserting if the mask has no filter left in it.
	end
	if sourceItem:hasTag("GasmaskFilter") or sourceItem:hasTag("RespiratorFilter") then
		return sourceItem:getCurrentUsesFloat() > 0
	end
	return true -- the filter
end
function Recipe.OnTest.WornGasmaskFilterInsert(sourceItem, result)
	if sourceItem:hasTag("GasMask") or sourceItem:hasTag("GasMaskNoFilter") then
		return (not sourceItem:hasFilter()) and sourceItem:isWorn(); -- Only allow the filter inserting if the mask has no filter left in it.
	end
	if sourceItem:hasTag("GasmaskFilter") or sourceItem:hasTag("RespiratorFilter") then
		return sourceItem:getCurrentUsesFloat() > 0
	end
	return true -- the filter
end

-- When creating item in result box of crafting panel.
function Recipe.OnCreate.GasmaskFilterInsert(craftRecipeData, character)
	if not character then return end
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
  for i=0, items:size()-1 do
	-- we found the filter we change his used delta according to the filter
	if items:get(i):hasTag("GasmaskFilter") or items:get(i):hasTag("RespiratorFilter") then
		result:setUsedDelta(items:get(i):getCurrentUsesFloat());
		result:setFilterType(items:get(i):getFullType())
	end
	if items:get(i):hasTag("GasMask") or items:get(i):hasTag("GasMaskNoFilter") then
	    ISClothingExtraAction:createItemNew(items:get(i), result)
	    if items:get(i):isWorn() then

            character:setWornItem(result:getBodyLocation() or result:canBeEquipped(), result);
            triggerEvent("OnClothingUpdated", character)

	    end
	end
  end
end

function Recipe.OnCreate.WornGasmaskFilterInsert(craftRecipeData, character)
	if not character then return end
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
  for i=0, items:size()-1 do
	-- we found the filter we change his used delta according to the filter
	if items:get(i):hasTag("GasmaskFilter") or items:get(i):hasTag("RespiratorFilter") then
		result:setUsedDelta(items:get(i):getCurrentUsesFloat());
		result:setFilterType(items:get(i):getFullType())
	end
-- 	if items:get(i):hasTag("GasMask") and items:get(i):isWorn() then
	if items:get(i):hasTag("GasMask") or items:get(i):hasTag("GasMaskNoFilter") then
        local item = items:get(i)
	    ISClothingExtraAction:createItemNew(item, result)
        character:setWornItem(result:getBodyLocation() or result:canBeEquipped(), result);
        triggerEvent("OnClothingUpdated", character)
	end
  end
end
function Recipe.OnTest.GasmaskFilterNotFull(sourceItem, result)
	if sourceItem:hasTag("GasmaskFilter") then
		return sourceItem:getCurrentUsesFloat() < 1.0
	end
	return true
end
function Recipe.OnTest.RespiratorFilterNotFull(sourceItem, result)
	if sourceItem:hasTag("RespiratorFilter") then
		return sourceItem:getCurrentUsesFloat() < 1.0
	end
	return true
end
function Recipe.OnTest.OxygenTankRemoval(sourceItem, result)
	if sourceItem:hasTag("SCBA") then
-- 	    print("has Tank " .. tostring(sourceItem:hasTank()))
-- 	    print("not worn " .. tostring(not sourceItem:isWorn()))
		return sourceItem:hasTank() and not sourceItem:isWorn()
	end
	return true
end
function Recipe.OnTest.OxygenTankAttach(sourceItem, result)
	if sourceItem:hasTag("SCBA") then
		return (not sourceItem:hasTank()) and not sourceItem:isWorn()
	end
	return true
end
function Recipe.OnCreate.OxygenTankRemoval(craftRecipeData, character)
	if not character then return end
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);

	for i=0, items:size()-1 do
		local item = items:get(i)
		-- we found the filter, we change his used delta according to the filter
		if item:hasTag("SCBA") then
		    if item:getWithoutDrainable() then
                local isWorn = item:isWorn()
                if isWorn then character:removeWornItem(item) end
                character:getInventory():Remove(item)
                local newItem =  ISClothingExtraAction:createItem(items:get(i), item:getWithoutDrainable())
                character:getInventory():AddItem(newItem)
                if isWorn then
                    character:setWornItem(newItem:getBodyLocation(), newItem)
                    triggerEvent("OnClothingUpdated", character)
                end
		    else
                item:setNoTank()
                result:setUsedDelta(item:getCurrentUsesFloat());
                -- then we empty the mask used delta (his energy)
                item:setUsedDelta(0);
            end
		end
	end
end

function Recipe.OnCreate.OxygenTankAttach(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
	local tank;
	local scba;
	for i=0, items:size()-1 do
		-- we found the filter we change his used delta according to the filter
		if items:get(i):hasTag("OxygenTank") then
			tank = items:get(i);
		elseif items:get(i):hasTag("SCBA") or items:get(i):hasTag("SCBANoTank") then
			scba = items:get(i);
		end
	end
 	if tank then
		result:setUsedDelta(tank:getCurrentUsesFloat());
		result:setTankType(tank:getFullType());
	end
	if scba then
		ISClothingExtraAction:createItemNew(scba, result);
	end
end

-- These functions are defined to avoid breaking mods.
DefaultRecipe_OnGiveXP = Recipe.OnGiveXP.Default
NoXP_OnGiveXP = Recipe.OnGiveXP.None
CannedFood_OnCreate = Recipe.OnCreate.CannedFood
CheckTaintedWater_OnTest = Recipe.OnTest.NotTaintedWater
CloseUmbrella = Recipe.OnCreate.CloseUmbrella
CreateSpear_OnCreate = Recipe.OnCreate.CreateSpear
CutAnimal_OnCreate = Recipe.OnCreate.CutAnimal
CutFillet_OnCreate = Recipe.OnCreate.CutFillet
CutFillet_TestIsValid = Recipe.OnTest.CutFillet
CutFish_OnCreate = Recipe.OnCreate.CutFish
CutFish_TestIsValid = Recipe.OnTest.CutFish
Dismantle_OnCreate = Recipe.OnCreate.Dismantle
Dismantle2_OnCreate = Recipe.OnCreate.Dismantle2
DismantleRadio_OnCreate = Recipe.OnCreate.DismantleRadio
DismantleRadio_OnGiveXP = Recipe.OnGiveXP.DismantleRadio
DismantleElectronics_OnGiveXP = Recipe.OnGiveXP.DismantleElectronics
DismantleRadioHAM_OnCreate = Recipe.OnCreate.DismantleRadioHAM
DismantleRadioSpecial_OnCreate = Recipe.OnCreate.DismantleRadioSpecial
DismantleRadioTV_OnCreate = Recipe.OnCreate.DismantleRadioTV
DismantleRadioTwoWay_OnCreate = Recipe.OnCreate.DismantleRadioTwoWay
DismantleSpear_OnCreate = Recipe.OnCreate.DismantleSpear
Give10BSXP = Recipe.OnGiveXP.Blacksmith10
Give15BSXP = Recipe.OnGiveXP.Blacksmith15
Give20BSXP = Recipe.OnGiveXP.Blacksmith20
Give25BSXP = Recipe.OnGiveXP.Blacksmith25
Give3CookingXP = Recipe.OnGiveXP.Cooking3
Give10CookingXP = Recipe.OnGiveXP.Cooking10
Give10MWXP = Recipe.OnGiveXP.MetalWelding10
Give15MWXP = Recipe.OnGiveXP.MetalWelding15
Give20MWXP = Recipe.OnGiveXP.MetalWelding20
Give25MWXP = Recipe.OnGiveXP.MetalWelding25
Give5WoodworkXP = Recipe.OnGiveXP.WoodWork5
GiveSawLogsXP = Recipe.OnGiveXP.SawLogs
MakeBowlOfSoup2_OnCreate = Recipe.OnCreate.MakeBowlOfSoup2
MakeBowlOfSoup4_OnCreate = Recipe.OnCreate.MakeBowlOfSoup4
MakeBowlOfStew4_OnCreate = Recipe.OnCreate.MakeBowlOfStew4
OnOpenBoxOfJars = Recipe.OnCreate.OpenBoxOfJars
OnPutCakeBatterInBaking = Recipe.OnCreate.PutCakeBatterInBakingPan
OpenCandyPackage_OnCreate = Recipe.OnCreate.OpenCandyPackage
OpenCannedFood_OnCreate = Recipe.OnCreate.OpenCannedFood
OpenEggCarton_OnCreate = Recipe.OnCreate.OpenEggCarton
OpenUmbrella = Recipe.OnCreate.OpenUmbrella
RadioCraft_OnCreate = Recipe.OnCreate.RadioCraft
RadioCraft_OnGiveXP = Recipe.OnGiveXP.RadioCraft
RefillBlowTorch_OnCreate = Recipe.OnCreate.RefillBlowTorch
RefillBlowTorch_OnTest = Recipe.OnTest.RefillBlowTorch
RipClothing_OnCreate = Recipe.OnCreate.RipClothing
SliceBread_OnCreate = Recipe.OnCreate.SliceBread
SliceBreadDough_TestIsValid = Recipe.OnTest.SliceBreadDough
SliceHam_OnCreate = Recipe.OnCreate.SliceHam
SlicePie_OnCreate = Recipe.OnCreate.SlicePie
SliceWatermelon_OnCreate = Recipe.OnCreate.SliceWatermelon
SpikedBat_OnCreate = Recipe.OnCreate.SpikedBat
SplitLogsStack2_OnCreate = Recipe.OnCreate.SplitLogStack2
SplitLogsStack3_OnCreate = Recipe.OnCreate.SplitLogStack3
SplitLogsStack4_OnCreate = Recipe.OnCreate.SplitLogStack4
TorchBatteryInsert_OnCreate = Recipe.OnCreate.TorchBatteryInsert
TorchBatteryInsert_TestIsValid = Recipe.OnTest.TorchBatteryInsert
TorchBatteryRemoval_OnCreate = Recipe.OnCreate.TorchBatteryRemoval
TorchBatteryRemoval_TestIsValid = Recipe.OnTest.TorchBatteryRemoval
TorchDismantle_OnCreate = Recipe.OnCreate.DismantleFlashlight
UpgradeSpear_OnCreate = Recipe.OnCreate.UpgradeSpear
WashClothing_OnCreate = Recipe.OnCreate.WashClothing
WashClothing_TestIsValid = Recipe.OnTest.WashClothing

function Recipe.OnCreate.Blacksmith1(entity)
    --print("Entity " .. tostring(entity))
    local player = entity:getPlayer()
    if not player then return end
    addXp(player, Perks.Blacksmith, 1)
    Recipe.OnCreate.BlacksmithGeneral(entity)
end
function Recipe.OnCreate.Blacksmith10(entity)
    --print("Entity " .. tostring(entity))
    local player = entity:getPlayer()
    if not player then return end
    addXp(player, Perks.Blacksmith, 10)
    Recipe.OnCreate.BlacksmithGeneral(entity)
end
function Recipe.OnCreate.Blacksmith20(entity)
    --print("Entity " .. tostring(entity))
    local player = entity:getPlayer()
    if not player then return end
    addXp(player, Perks.Blacksmith, 20)
    Recipe.OnCreate.BlacksmithGeneral(entity)
end
function Recipe.OnCreate.Blacksmith25(entity)
    local player = entity:getPlayer()
    if not player then return end
    addXp(player, Perks.Blacksmith, 25)
    Recipe.OnCreate.BlacksmithGeneral(entity)
end
function Recipe.OnCreate.Blacksmith1_NoProductCondition(entity)
    local player = entity:getPlayer()
    if not player then return end
    addXp(player, Perks.Blacksmith, 25)
    Recipe.OnCreate.BreakOnSmith(entity)
end
function Recipe.OnCreate.Blacksmith10_NoProductCondition(entity)
    local player = entity:getPlayer()
    if not player then return end
    addXp(player, Perks.Blacksmith, 10)
    Recipe.OnCreate.BreakOnSmith(entity)
end
function Recipe.OnCreate.Blacksmith20_NoProductCondition(entity)
    local player = entity:getPlayer()
    if not player then return end
    addXp(player, Perks.Blacksmith, 20)
    Recipe.OnCreate.BreakOnSmith(entity)
end
function Recipe.OnCreate.Blacksmith25_NoProductCondition(entity)
    local player = entity:getPlayer()
    if not player then return end
    addXp(player, Perks.Blacksmith, 25)
    Recipe.OnCreate.BreakOnSmith(entity)
end

function Recipe.OnCreate.BlacksmithGeneral(entity)
    local player = entity:getPlayer()
    if not player then return end
    local skill = player:getPerkLevel(Perks.Blacksmith)
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local item = entity:getResources():getInputResources():get(i):peekItem()
--         if item and item:hasTag("BreakOnSmith") then item:setCondition(0) end

                if item and item:getType() == "CrudeWoodenTongsSoaked" then
                    item:setFullType("CrudeWoodenTongs")
                    item:setCondition(0)
                elseif item and item:hasTag("BreakOnSmith") then item:Use() end
    end
    for i = 0,entity:getResources():getOutputResources():size()-1 do
        local result = entity:getResources():getOutputResources():get(i):peekItem()
        if result then
            --print(tostring(i) .. "Result " .. tostring(result))
            local condPerc = ZombRand(5 + (skill * 5), 10 + (skill * 10));
            condPerc = math.max(condPerc, 5)
            condPerc = math.min(condPerc, 100)
            local maxResult = result:getConditionMax();
            local cond = math.max(result:getConditionMax() * (condPerc/100),1)
            --print(tostring(i) .."cond " .. tostring(cond))
            result:setCondition(cond)
        end
   end
end

function Recipe.OnCreate.BreakOnSmith(entity)
    --print("BOS")
    local player = entity:getPlayer()
    if not player then return end
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local item = entity:getResources():getInputResources():get(i):peekItem()
        --print("item " .. tostring(item))
        if item and item:hasTag("BreakOnSmith") then
            --print("BOS 2!!!!")
--             item:Use()
            item:setCondition(0)
            item:setBroken(true)
        end
    end
end

-- Only allow handles to break
function Recipe.OnTest.OnlyBrokenHandle (sourceItem, result)
    if sourceItem:hasTag("WoodHandle") then return true end
	return not sourceItem:isBroken()
end

function Recipe.OnTest.OnlyBrokenSaw (sourceItem, result)
    if sourceItem:hasTag("Saw") then return true end
	return not sourceItem:isBroken()
end

function Recipe.OnCreate.ChangeSawblade(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local result = craftRecipeData:getAllCreatedItems():get(0);
    local tool = nil
    local blade = nil
    for i=0,items:size() - 1 do
        local item = items:get(i)

        if item:hasTag("SmallSaw") or item:hasTag("Saw") or item:hasTag("MetalSaw") then
            tool = item
        elseif item:hasTag("SawBlade") then
            blade = item
        end
    end
    if blade then
        result:setConditionFrom(blade)
--         if blade:getConditionMax() == result:getConditionMax() then
--             result:setCondition(result:getCondition())
--         else
--         local perc = blade:getCondition()/blade:getConditionMax()
--             result:setCondition(result:getConditionMax() * perc)
--         end
    end
    if not blade or not tool then return end
    local item = character:getInventory():AddItem(blade:getFullType())
    item:setConditionFrom(tool)
--         if blade:getConditionMax() == item:getConditionMax() then
--             item:setCondition(blade:getCondition())
--         else
--         local perc = blade:getCondition()/blade:getConditionMax()
--             item:setCondition(item:getConditionMax() * perc)
--             if item:getCondition() == 0 then item:setBroken(true) end
--         end
end

function Recipe.OnCreate.BasicCarveWood(craftRecipeData, character)
    local carving = character:getPerkLevel(Perks.Carving)
    Recipe.OnCreate.BasicCondition(craftRecipeData, carving)
end

function Recipe.OnCreate.MinorCarving(craftRecipeData, character)
    local carving = character:getPerkLevel(Perks.Carving)
    Recipe.OnCreate.MinorCondition(craftRecipeData, carving)
end

function Recipe.OnCreate.BasicKnapping(craftRecipeData, character)
    local carving = character:getPerkLevel(Perks.FlintKnapping)
    Recipe.OnCreate.BasicCondition(craftRecipeData, carving)
end

function Recipe.OnCreate.MinorKnapping(craftRecipeData, character)
    local carving = character:getPerkLevel(Perks.FlintKnapping)
    Recipe.OnCreate.MinorCondition(craftRecipeData, carving)
end

function Recipe.OnCreate.BasicCondition(craftRecipeData, characterSkill)
    local results = craftRecipeData:getAllCreatedItems()
    for i=0,results:size() - 1 do
        local result = results:get(i)
        local condPerc = ZombRand(5 + (characterSkill * 10), 10 + (characterSkill * 20));
        condPerc = math.max(condPerc, 5)
        condPerc = math.min(condPerc, 100)
        local cond = math.max(result:getConditionMax() * (condPerc/100),1)

        if characterSkill >= 10 then cond = result:getConditionMax() end

        result:setCondition(cond)
    end
end

function Recipe.OnCreate.MinorCondition(craftRecipeData, characterSkill)
    local results = craftRecipeData:getAllCreatedItems()
    for i=0,results:size() - 1 do
        local result = results:get(i)
        local condPerc = ZombRand(5 + (characterSkill * 10), 10 + (characterSkill * 20));
        condPerc = math.max(condPerc, 5)
        condPerc = math.min(condPerc, 100)
        local cond = math.max(result:getConditionMax() * (condPerc/100),result:getConditionMax()/2)
        local cond = math.max(cond,1)

        if characterSkill >= 10 then cond = result:getConditionMax() end

        result:setCondition(cond)
    end
end

function Recipe.OnCreate.MakeBlunt(craftRecipeData, character)
    local results = craftRecipeData:getAllCreatedItems()
    for i=0,results:size() - 1 do
        local result = results:get(i)
        if result:hasSharpness() then result:setSharpness(0) end
    end
end

-- need open flame
function Recipe.OnCanPerform.OpenFire(recipe)
--     print("Test")
--     print("Recipe " .. tostring(recipe))
-- --     playerObj = recipe:getPlayer()
--     print("two " .. tostring(two))
    local playerObj = getSpecificPlayer(0)

    if not playerObj then return end


--     print("Going")
    local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
    for i=1,containers:size() do
        local container = containers:get(i-1)
        local parent = container:getParent()
        if parent then
--             print("pARENT")
            local campfire
            local square = parent:getSquare()
            if square then campfire = CCampfireSystem.instance:getLuaObjectOnSquare(parent:getSquare()) end
            if campfire then
                --print("fIRE")
                if campfire.isLit then return true end
            end
            if (instanceof(parent,'IsoFireplace') or instanceof(parent,'IsoBarbecue')) and parent:isLit() then
                return true
            end
        end
    end
    return playerObj:getSquare():hasAdjacentFireObject()
end

function Recipe.OnCreate.BasicSawMetal(craftRecipeData, character)
-- 	local items = craftRecipeData:getAllConsumedItems();
--     local skill = math.max(character:getPerkLevel(Perks.MetalWelding),character:getPerkLevel(Perks.Smithing))
--     for i=0,items:size() - 1 do
--         local item = items:get(i)
--         -- chance to reduce condition of the cutting tool
--         if item:hasTag("MetalSaw") or item:hasTag("SmallSaw") then
--             item:damageCheck(skill)
--         end
--     end
end

function Recipe.OnCreate.BasicGrindMetal(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
    local skill = math.max(character:getPerkLevel(Perks.MetalWelding),character:getPerkLevel(Perks.Smithing))
    for i=0,items:size() - 1 do
        local item = items:get(i)
        -- chance to reduce condition of the cutting tool
        if item:hasTag("MetalSaw") or item:hasTag("SmallSaw") or item:hasTag("MetalFile") or item:hasTag("Whetstone") or item:hasTag("File") then
            item:damageCheck(skill)
        end
    end
end

function Recipe.OnCreate.SharpenBlade(craftRecipeData, player)
    local item = craftRecipeData:getFirstInputItemWithFlag("IsSharpenable")
    local skill  = math.max(craftRecipeData:getRecipe():getHighestRelevantSkillLevel(player), item:getMaintenanceMod(false, player)/2)
    Recipe.OnCreate.GenericSharpen(player, item, skill, 1)
end

function Recipe.OnCreate.SharpenBladePoor(craftRecipeData, player)
    local item = craftRecipeData:getFirstInputItemWithFlag("IsSharpenable")
    local skill  = math.max(craftRecipeData:getRecipe():getHighestRelevantSkillLevel(player), item:getMaintenanceMod(false, player)/2)
    skill = math.max(skill/2 - 1, 0)
    skill = math.floor(skill)
    Recipe.OnCreate.GenericSharpen(player, item, skill, 0.5)
end

function Recipe.OnCreate.SharpenBladeWithGrindstone(craftRecipeData, player)
    local item = craftRecipeData:getFirstInputItemWithFlag("IsSharpenable")
    local skill  = math.max(craftRecipeData:getRecipe():getHighestRelevantSkillLevel(player), item:getMaintenanceMod(false, player)/2)
    Recipe.OnCreate.GenericSharpen(player, item, skill, 2)
end

function Recipe.OnCreate.RepairBladeWithGrindstone(craftRecipeData, player)
    local item = craftRecipeData:getFirstInputItemWithFlag("IsSharpenable")
    if item:hasHeadCondition() then
        if item:getHeadCondition() < item:getHeadConditionMax() then
           CraftRecipeCode.GenericFixer(craftRecipeData, player, 1, item, nil, true)
        end
    elseif item:getCondition() < item:getConditionMax() then
        CraftRecipeCode.GenericFixer(craftRecipeData, player, 1, item)
    end
    if item:getSharpness() < item:getMaxSharpness() then
        Recipe.OnCreate.GenericSharpen(player, item, skill, 2)
    end
end

function Recipe.OnCreate.GenericSharpen(player, item, skill, factor)
    skill = math.max(skill, player:getPerkLevel(Perks.Blacksmith))
    skill = math.max(skill, player:getPerkLevel(Perks.Maintenance))
    if not factor then factor = 1 end
    local failChance = 25 - (factor * 5)
    if skill > 0 then
        failChance = failChance - (skill * 5)
    else
        failChance = failChance + 10
--         failChance = failChance + 30
    end
    local timesRepaired = item:getHaveBeenRepaired()
    if item:hasHeadCondition() then timesRepaired = item:getTimesHeadRepaired() end
    failChance = failChance + (timesRepaired * 2)
    if player:getTraits():contains("Lucky") then failChance = failChance - 5
    elseif player:getTraits():contains("Lucky") then failChance = failChance + 5 end

    failChance = math.min(failChance, 95)
    failChance = math.max(failChance, 0)
    local increment = item:getSharpnessIncrement()
    if ZombRand(100) <= failChance then
        item:setSharpness(item:getSharpness() - increment)
        item:syncItemFields()
        return
    end
    local percentFixed = (factor * 10 * (1/timesRepaired) + math.min(skill * 5, 25))/100
    local amountFixed = ( 1 - item:getSharpness() ) * percentFixed
    amountFixed = math.max(increment, amountFixed)
    item:setSharpness(item:getSharpness() + amountFixed)

--     item:setSharpness(item:getSharpness() + ( ( ZombRand(factor) + 1 ) * increment ) )
--     if ZombRand(11) < skill then
--         item:setSharpness(item:getSharpness() + ( ( ZombRand(factor) + 1 ) * increment ) )
--     end

--     if item:hasSharpness() then item:applyMaxSharpness() end
    item:syncItemFields()
end

-- function Recipe.OnTest.EntityRepairFull(entity)
function Recipe.OnTest.EntityRepairFull(entity)
    local item
    for i = 0,entity:getResources():getInputResources():size()-1 do
        item = entity:getResources():getInputResources():get(i):peekItem()
        if item and item:hasTag("Sharpenable") then
            --print("Result " .. tostring(item))
        end
    end
    if not item then return end
    --print("item:hasSharpness() " .. tostring(item:hasSharpness()))
    --print("item:getSharpness() " .. tostring(item:getSharpness()))
    --print("item:getMaxSharpness() " .. tostring(item:getMaxSharpness()))
    if item:hasSharpness() and item:getSharpness() < item:getMaxSharpness() then return true end
--     return false
    if item:hasHeadCondition() then
        --print("item:getHeadCondition() < item:getHeadConditionMax() " .. tostring(item:getHeadCondition() < item:getHeadConditionMax()))
        --print("item:getHeadCondition() >= item:getHeadConditionMax()/3 " .. tostring(item:getHeadCondition() >= item:getHeadConditionMax()/3))
        return item:getHeadCondition() < item:getHeadConditionMax() and item:getHeadCondition() >= item:getHeadConditionMax()/3
    else
        --print("item:getCondition() < item:getConditionMax() " .. tostring( item:getCondition() < item:getConditionMax()))
        --print("item:getCondition() >= item:getConditionMax()/3 " .. tostring(item:getCondition() >= item:getConditionMax()/3))
        return item:getCondition() < item:getConditionMax() and item:getCondition() >= item:getConditionMax()/3
    end
end

function Recipe.OnCreate.DismantleBlade(entity)
    local player = entity:getPlayer()
    local skill = player:getPerkLevel(Perks.Smithing)
--     print("TEST!")
    local blade
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local item = entity:getResources():getInputResources():get(i):peekItem()
        if item and item:hasTag("Sharpenable") then blade = item end
    end
    if not blade then return end
    local result = entity:getResources():getOutputResources():get(0):peekItem()
    result:setConditionFrom(blade);
--     if blade:getConditionMax() == result:getConditionMax() then
--         result:setCondition(result:getCondition())
--         return
--     end
--     local perc = blade:getCondition()/blade:getConditionMax()
--     result:setCondition(result:getConditionMax() * perc)
--     if ZombRand(blade:getCondition() + skill) then result:setCondition(result:getCondition()-1) end

    result:damageCheck(skill, 2)
end

function Recipe.OnCreate.RemoveGem(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
    local jewel
    for i=0,items:size() - 1 do
        if items:get(i):hasTag("DiamondJewellery") or items:get(i):hasTag("EmeraldJewellery") or items:get(i):hasTag("RubyJewellery") or items:get(i):hasTag("SapphireJewellery") then
            jewel = items:get(i)
        end
    end
    local jewelTable
    if Recipe.JewelTable[jewel:getType()] then jewelTable = Recipe.JewelTable[jewel:getType()] end
    if not jewelTable then return end
	if not character then return end
    if jewelTable.bonusGems then
			character:getInventory():AddItem(result:getFullType())
    end
    if jewelTable.bonusItem then character:getInventory():AddItem(jewelTable.bonusItem) end
end

function Recipe.OnCreate.SliceAnimalHead(craftRecipeData, character)
	if not character then return end
	character:getInventory():AddItem("Base.Animal_Brain");
end

function Recipe.OnTest.NotTainted(item)
    -- not sure why this one is always throwing mystery errors but added this test for them
    if not item or not instanceof(item, "InventoryItem") then return false end

    if instanceof(item, "Food") then
        return not item:isTainted()
    end
    return true;
end

function Recipe.OnTest.GenericPacking(item, result)

	if item:IsFood() and not Recipe.OnTest.NormalGoodFullFood(item, result) then return false end

    if item:getBloodLevel() > 0 then return end
	if (item:IsInventoryContainer() or item:IsClothing()) and item:getDirtyness() > 0  then return false end
	--if item:IsDrainable() and item:getCurrentUsesFloat() ~= 1.0 then return false end
	if item:IsInventoryContainer() and not item:isEmpty() then return false end
	if item:getCondition() ~= item:getConditionMax() then return false end

	local scriptItem = item:getScriptItem()
	if item:getColorRed() ~= scriptItem:getColorRed() then return end
	if item:getColorGreen() ~= scriptItem:getColorGreen() then return end
	if item:getColorBlue() ~= scriptItem:getColorBlue() then return end
	return true
end

function Recipe.OnTest.NormalGoodFullFood(item, result)
    if not item:IsFood() then return false end
    return item:isNormalAndFullFood()
end


function Recipe.OnCreate.HollowBook(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
    local item
    for i=0, items:size()-1 do
        if items:get(i):hasTag("Hardcover") then
            item = items:get(i)
        end
    end
    if item then
	    for i=0, results:size()-1 do
			result = results:get(i)
			result:setName(item:getDisplayName())
		end
    end
end


function Recipe.OnCreate.CutChicken(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems();
	local chicken = nil;
	for i=0,items:size() - 1 do
		if instanceof(items:get(i), "Food") then
			chicken = items:get(i);
			break;
		end
	end
	if chicken then
		-- we do a first pass to calculate what's the total hunger reduction we should have
		-- as each animals will give more or less meat, i need to calculate the ratio i need to apply to the result meat
		local totalHunger = 0;
		local wholeChickenHunger = math.max(chicken:getBaseHunger(), chicken:getHungChange());
		for j=0,results:size() - 1 do
			local result = results:get(j)
			totalHunger = totalHunger + math.max(result:getBaseHunger(), result:getHungChange());
		end
		local ratio = wholeChickenHunger/totalHunger;

		-- now apply the ratio
		for j=0,results:size() - 1 do
			local result = results:get(j)
			result:setBaseHunger(result:getBaseHunger() * ratio);
			result:setHungChange(result:getHungChange() * ratio);
			result:setActualWeight((result:getActualWeight() * 0.9) * ratio)
			result:setWeight(result:getActualWeight());
			result:setCustomWeight(true)
			result:setCarbohydrates(result:getCarbohydrates() * ratio);
			result:setLipids(result:getLipids() * ratio);
			result:setProteins(result:getProteins() * ratio);
			result:setCalories(result:getCalories() * ratio);
			result:setCooked(chicken:isCooked());
		end
	end
end

Recipe.LowerBodyClothing = {
    "Underwear",
    "UnderwearBottom",
    "UnderwearTop",
    "UnderwearExtra1",
    "UnderwearExtra2",
    "Torso1Legs1",
    "Calf_Left_Texture",
    "Calf_Right_Texture",
    "Socks",
    "Legs1",
    "Shoes",
    "Codpiece",
    "ShortsShort",
    "ShortPants",
    "Pants",
    "Skirt",
    "Dress",
    "LongSkirt",
    "LongDress",
    "BodyCostume",
    "FullSuit",
    "Boilersuit",
    "FullSuitHead",
    "FullSuitHeadSCBA",
    "Knee_Left",
    "Knee_Right",
    "Calf_Left",
    "Calf_Right",
    "Thigh_Left",
    "Thigh_Right",
}

function Recipe.OnTest.NotWornLowerBody(item, result)
    if not item then return false end
    if not instanceof(item, "InventoryItem") then return false end
    if not instanceof(item, "Clothing") then return true end
    local location = item:getBodyLocation()
    if not location then return false end

    for i=1,#Recipe.LowerBodyClothing do
        if Recipe.LowerBodyClothing[i] == location then
            return false
        end
    end
	return true
end

Recipe.JewelTable = {
    Necklace_GoldRuby = { bonusItem = "Base.Necklace_Gold"},
    Necklace_GoldDiamond = { bonusItem = "Base.Necklace_Gold"},
    Necklace_SilverSapphire = { bonusItem = "Base.Necklace_Silver"},
    Necklace_SilverDiamond = { bonusItem = "Base.Necklace_Silver"},
    NecklaceLong_GoldDiamond = { bonusItem = "Base.NecklaceLong_Gold"},
    NecklaceLong_SilverEmerald = { bonusItem = "Base.NecklaceLong_Silver"},
    NecklaceLong_SilverSapphire = { bonusItem = "Base.NecklaceLong_Silver"},
    NecklaceLong_SilverDiamond = { bonusItem = "Base.NecklaceLong_Silver"},
    Necklace_Choker_Sapphire = { bonusItem = "Base.Necklace_Choker"},
    Necklace_Choker_Diamond = { bonusItem = "Base.Necklace_Choker"},
    Earring_Stone_Sapphire = { bonusGems = true},
    Earring_Stone_Emerald = { bonusGems = true},
    Earring_Stone_Ruby = { bonusGems = true},
    Earring_Dangly_Sapphire = { bonusGems = true},
    Earring_Dangly_Emerald = { bonusGems = true},
    Earring_Dangly_Ruby = { bonusGems = true},
    Earring_Dangly_Diamond = { bonusGems = true},
    Ring_Right_MiddleFinger_SilverDiamond = { bonusItem = "Base.Ring_Left_RingFinger_Silver"},
    Ring_Left_MiddleFinger_SilverDiamond = { bonusItem = "Base.Ring_Left_RingFinger_Silver"},
    Ring_Right_RingFinger_SilverDiamond = { bonusItem = "Base.Ring_Left_RingFinger_Silver"},
    Ring_Left_RingFinger_SilverDiamond = { bonusItem = "Base.Ring_Left_RingFinger_Silver"},
    Ring_Right_MiddleFinger_GoldRuby = { bonusItem = "Base.Ring_Left_RingFinger_Gold"},
    Ring_Left_MiddleFinger_GoldRuby = { bonusItem = "Base.Ring_Left_RingFinger_Gold"},
    Ring_Right_RingFinger_GoldRuby = { bonusItem = "Base.Ring_Left_RingFinger_Gold"},
    Ring_Left_RingFinger_GoldRuby = { bonusItem = "Base.Ring_Left_RingFinger_Gold"},
    Ring_Right_MiddleFinger_GoldDiamond = { bonusItem = "Base.Ring_Left_RingFinger_Gold"},
    Ring_Left_MiddleFinger_GoldDiamond = { bonusItem = "Base.Ring_Left_RingFinger_Gold"},
    Ring_Right_RingFinger_GoldDiamond = { bonusItem = "Base.Ring_Left_RingFinger_Gold"},
    Ring_Left_RingFinger_GoldDiamond = { bonusItem = "Base.Ring_Left_RingFinger_Gold"},
    BellyButton_DangleGoldRuby = { bonusItem = "Base.BellyButton_DangleGold"},
    BellyButton_DangleSilverDiamond = { bonusItem = "Base.BellyButton_DangleSilver"},
    BellyButton_RingGoldDiamond = { bonusItem = "Base.BellyButton_RingGold"},
    BellyButton_RingGoldRuby = { bonusItem = "Base.BellyButton_RingGold"},
    BellyButton_SilverDiamond = { bonusItem = "Base.BellyButton_RingSilver"},
    BellyButton_SilverRuby = { bonusItem = "Base.BellyButton_RingSilver"},
    BellyButton_StudGoldDiamond = { bonusItem = "Base.BellyButton_StudGold"},
    BellyButton_StudSilverDiamond = { bonusItem = "Base.BellyButton_StudSilver"},
}

function Recipe.OnCreate.EmptyDrainable(craftRecipeData, character)
	local results = craftRecipeData:getAllCreatedItems()
	for i=0,results:size() - 1 do
		if result:getCurrentUses() > 0 then result:setCurrentUses(0) end
	end
end

-- keep some info in the moddata of the box so we can pack used stuff
function Recipe.OnCreate.PlaceInBox(craftRecipeData, character)
	local results = craftRecipeData:getAllCreatedItems()
	local items = craftRecipeData:getAllConsumedItems();

	local box = results:get(0);
	for i=0,items:size()-1 do
		local item = items:get(i);
		if item:IsDrainable() then
			box:getModData()["drainable" .. i] = item:getCurrentUsesFloat();
		end
	end
end

function Recipe.OnCreate.UnpackBox(craftRecipeData, character)
	local items = craftRecipeData:getAllConsumedItems();
	local results = craftRecipeData:getAllCreatedItems()
	local box = items:get(0);

	for i=0, results:size() - 1 do
		local resultItem = results:get(i);
		if resultItem:IsDrainable() then
			resultItem:setCurrentUsesFloat(box:getModData()["drainable" .. i])
		end
	end
end