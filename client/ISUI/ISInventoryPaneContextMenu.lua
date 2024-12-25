 --***********************************************************
--**                LEMMY/ROBERT JOHNSON                   **
--***********************************************************

require "ISUI/ISToolTip"

ISInventoryPaneContextMenu = {}
ISInventoryPaneContextMenu.tooltipPool = {}
ISInventoryPaneContextMenu.tooltipsUsed = {}
ISInventoryPaneContextMenu.ghs = "<GHC>"
ISInventoryPaneContextMenu.bhs = "<BHC>"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local MAXIMUM_RENAME_LENGTH = 28

local function predicateNotBroken(item)
	return not item:isBroken()
end

local function predicateNotEmpty(item)
	return item:getCurrentUsesFloat() > 0
end

-- MAIN METHOD FOR CREATING RIGHT CLICK CONTEXT MENU FOR INVENTORY ITEMS
ISInventoryPaneContextMenu.createMenu = function(player, isInPlayerInventory, items, x, y, origin)
    if getCore():getGameMode() == "Tutorial" then
        Tutorial1.createInventoryContextMenu(player, isInPlayerInventory, items ,x ,y);
        return;
    end
    if ISInventoryPaneContextMenu.dontCreateMenu then return; end

	-- if the game is paused, we don't show the item context menu
	if UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return;
	end

    -- items is a list that could container either InventoryItem objects, OR a table with a list of InventoryItem objects in .items
    -- Also there is a duplicate entry first in the list, so ignore that.

    --print("Context menu for player "..player);
    --print("Creating context menu for inventory items");
    local context = ISContextMenu.get(player, x, y);
    -- avoid doing action while trading (you could eat half an apple and still trade it...)
--    if ISTradingUI.instance and ISTradingUI.instance:isVisible() then
--        context:addOption(getText("IGUI_TradingUI_CantRightClick"), nil, nil);
--        return;
--    end

    context.origin = origin;
	local itemsCraft = {};
    local c = 0;
    local tests = {}
    tests.isAllFood = true;
	tests.isWeapon = nil;
	tests.isSeed = nil;
	tests.equippable = nil;
	tests.isBleach = nil;
	tests.isHandWeapon = nil;
	tests.isAllPills = true;
    tests.clothing = nil;
    tests.canBeEquippedOther = nil;
    tests.recipe = nil;
    tests.evorecipe = nil;
    tests.baseItem = nil;
	tests.isAllLiterature = true;
	tests.canBeActivated = nil;
	tests.isAllBandage = true;
	tests.unequip = nil;
	tests.waterContainer = nil;
	tests.fluidContainer = nil;
    tests.canBeDry = nil;
	tests.canBeEquippedBack = nil;
	tests.canBeEquippedContainer = nil;
	tests.twoHandsItem = nil;
    tests.brokenObject = nil;
    tests.canBeRenamed = nil;
    tests.canBeRenamedFood = nil;
    tests.pourOnGround = nil
    tests.canBeWrite = nil;
    tests.force2Hands = nil;
    tests.remoteController = nil;
    tests.remoteControllable = nil;
    tests.generator = nil;
    tests.corpse = nil;
    tests.corpseAnimal = nil;
    tests.alarmClock = nil;
    tests.inPlayerInv = nil;
    tests.drainable = nil;
    tests.map = nil;
    tests.carBattery = nil;
    tests.carBatteryCharger = nil;
    tests.clothingItemExtra = nil;
    tests.magazine = nil;
    tests.bullet = nil;
    tests.hairDye = nil;
    tests.makeup = nil;
    tests.fishingRod = nil;
    tests.isTrap = nil;
    tests.haveLure = false;
    tests.animalCorpse = nil;

    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

	ISInventoryPaneContextMenu.removeToolTip();

	getCell():setDrag(nil, player);

    for _,tooltip in ipairs(ISInventoryPaneContextMenu.tooltipsUsed) do
        table.insert(ISInventoryPaneContextMenu.tooltipPool, tooltip);
    end
--    print('reused ',#ISInventoryPaneContextMenu.tooltipsUsed,' inventory tooltips')
    table.wipe(ISInventoryPaneContextMenu.tooltipsUsed);

    local containerList = ISInventoryPaneContextMenu.getContainers(playerObj)
    local testItem = nil;
    local editItem = nil;
    for i,v in ipairs(items) do
        testItem = v;
        if not instanceof(v, "InventoryItem") then
            --print(#v.items);
            if #v.items == 2 then
                editItem = v.items[1];
            end
            testItem = v.items[1];
        else
            editItem = v
        end
        if instanceof(testItem, "Key") or testItem:getType() == "KeyRing" or testItem:hasTag( "KeyRing") then
            tests.canBeRenamed = testItem;
        end
        if instanceof(testItem, "AnimalInventoryItem") then
            AnimalContextMenu.doInventoryMenu(player, context, testItem)
            return;
        end
        if testItem:getClothingItemExtraOption() then
            tests.clothingItemExtra = testItem;
        end
        if testItem:getType() == "CorpseAnimal" then
            tests.animalCorpse = testItem;
        end
		if not testItem:isCanBandage() then
			tests.isAllBandage = false;
		end
        if testItem:getCategory() ~= "Food" or testItem:getScriptItem():isCantEat() then
            tests.isAllFood = false;
        end
        if testItem:hasTag("isSeed") then
            tests.isSeed = testItem;
        end
        if testItem:hasTag("Equippable") then
            tests.equippable = testItem;
        end
        if testItem:getType() == "Bleach" then
            tests.isBleach = testItem;
        end
		if testItem:getCategory() == "Clothing" then
            tests.clothing = testItem;
        end
		if testItem:hasTag("Wearable") then
            tests.canBeEquippedOther = testItem;
        end
		if (testItem:getType() == "DishCloth" or testItem:getType() == "BathTowel") and playerObj:getBodyDamage():getWetness() > 0 then
			tests.canBeDry = true;
        end
		if testItem:getFluidContainer() and testItem:getFluidContainer():getPrimaryFluid() and ISInventoryPaneContextMenu.startWith(testItem:getFluidContainer():getPrimaryFluid():getFluidTypeString(), "HairDye") and testItem:getFluidContainer():getAmount() >= 0.5 then
            tests.hairDye = testItem;
        end
        if testItem:getMakeUpType() then
            tests.makeup = testItem;
        end
        -- weapons cannot be fixed unless they aren't broken; broken objects needs to be reclaimed or reforged as part of crafting rework.
        if (not testItem:isBroken()) and testItem:getCondition() < testItem:getConditionMax() then
--         if testItem:isBroken() or testItem:getCondition() < testItem:getConditionMax() then
            tests.brokenObject = testItem;
        end
        if instanceof(testItem, "DrainableComboItem") then
            tests.drainable = testItem;
        end
        if testItem:isTrap() then
            tests.isTrap = testItem;
        end
        if testItem:getContainer() and testItem:getContainer():isInCharacterInventory(playerObj) then
            tests.inPlayerInv = testItem;
        end
        if testItem:getMaxAmmo() > 0 and not instanceof(testItem, "HandWeapon") then
            tests.magazine = testItem;
        end
        if testItem:getDisplayCategory() == "Ammo" then
            tests.bullet = testItem;
        end
        if playerObj:isEquipped(testItem) then
			tests.unequip = testItem;
        end
        if ISInventoryPaneContextMenu.startWith(testItem:getType(), "CarBattery") and testItem:getType() ~= "CarBatteryCharger" then
            tests.carBattery = testItem;
        end
        if testItem:getType() == "CarBatteryCharger" then
            tests.carBatteryCharger = testItem;
        end
        if testItem:IsMap() then
            tests.map = testItem;
        end
        if testItem:getAnimalTracks() then
            tests.trackItem = testItem;
        end
		if testItem:getCategory() ~= "Literature" or testItem:canBeWrite() then
            tests.isAllLiterature = false;
        end
        if testItem:getCategory() == "Literature" and testItem:canBeWrite() then
            tests.canBeWrite = testItem;
        end
		if testItem:canBeActivated() and (playerObj:isHandItem(testItem) or (playerObj:isAttachedItem(testItem) and not instanceof(testItem, "HandWeapon"))) and not testItem:hasTag("SCBA") then
            tests.canBeActivated = testItem;
        end
		if testItem:canBeActivated() and (testItem:isWorn() and testItem:getCurrentUsesFloat() > 0) then
            tests.canBeActivated = testItem;
        end
		-- all items can be equiped
		if (instanceof(testItem, "HandWeapon") and testItem:getCondition() > 0) or (instanceof(testItem, "InventoryItem") and not instanceof(testItem, "HandWeapon")) then
            tests.isWeapon = testItem;
        end
        if instanceof(testItem, "HandWeapon") then
            tests.isHandWeapon = testItem
        end
        -- remote controller
        if testItem:isRemoteController() then
            tests.remoteController = testItem;
        end
        if tests.isHandWeapon and tests.isHandWeapon:canBeRemote() then
            tests.remoteControllable = tests.isHandWeapon;
        end
		if instanceof(testItem, "InventoryContainer") and testItem:canBeEquipped() == "Back" and not playerObj:isEquippedClothing(testItem) then
			tests.canBeEquippedBack = testItem;
		elseif instanceof(testItem, "InventoryContainer") and testItem:getBodyLocation() ~= nil and testItem:getBodyLocation() ~= "" and not playerObj:isEquippedClothing(testItem) and not testItem:getClothingExtraSubmenu() then
			tests.canBeEquippedContainer = testItem;
        end
        if instanceof(testItem, "InventoryContainer") then
            tests.canBeRenamed = testItem;
        end
        if testItem:getType() == "Generator" or testItem:hasTag("Generator") then
            tests.generator = testItem;
        end
        if testItem:getType() == "CorpseMale" or testItem:getType() == "CorpseFemale" then
            tests.corpse = testItem;
        end
        if testItem:hasTag("AnimalCorpse") then
            tests.corpseAnimal = testItem;
        end
        if instanceof(testItem, "AlarmClock") or instanceof(testItem, "AlarmClockClothing") then
            tests.alarmClock = testItem;
        end
        if instanceof(testItem, "Food")  then -- Check if it's a recipe from the evolved recipe and have at least 3 ingredient, so we can name them
            for i=0,getEvolvedRecipes():size()-1 do
                local evoRecipeTest = getEvolvedRecipes():get(i);
                if evoRecipeTest:isResultItem(testItem) and testItem:haveExtraItems() and testItem:getExtraItems():size() >= 3 then
                    tests.canBeRenamedFood = testItem;
                end
            end
        end
		if testItem:isTwoHandWeapon() and testItem:getCondition() > 0 then
			tests.twoHandsItem = testItem;
        end
        if testItem:isRequiresEquippedBothHands() and testItem:getCondition() > 0 then
            tests.force2Hands = testItem;
        end

		-- if not ISInventoryPaneContextMenu.startWith(testItem:getType(), "Pills") then
		-- Pills used to be determined by the script name starting with "Pills"; we added the Pills tag as well, but included the requirement to be drainable so they don't throw errors.
		-- If a food item needs to be Pills, then it just needs to use the food stuff and not the Pill/drainable stuff.
		if not ISInventoryPaneContextMenu.startWith(testItem:getType(), "Pills") and not testItem:hasTag("Pills")  and not testItem:hasTag("Consumable") then
            tests.isAllPills = false;
        elseif  not instanceof(testItem, "DrainableComboItem") then
            tests.isAllPills = false;
        end
        if testItem:isWaterSource() or (testItem:getFluidContainer() and testItem:getFluidContainer():getPrimaryFluid() and (testItem:getFluidContainer():getPrimaryFluid():getFluidTypeString() == "Water" or testItem:getFluidContainer():getPrimaryFluid():getFluidTypeString() == "CarbonatedWater")) then
            tests.waterContainer = testItem;
		elseif testItem:getFluidContainer() then
            tests.fluidContainer = testItem;		
        end
        if testItem:hasTag("FishingRod") then
            tests.fishingRod = testItem
            tests.haveLure = tests.fishingRod:getModData().fishing_Lure ~= nil
        end
        if not instanceof(testItem, "Literature") and ISInventoryPaneContextMenu.canReplaceStoreWater(testItem) then
            tests.pourOnGround = testItem
        end
        tests.evorecipe = RecipeManager.getEvolvedRecipe(testItem, playerObj, containerList, true);
        if tests.evorecipe then
            tests.baseItem = testItem;
        end
        itemsCraft[c + 1] = testItem;

        c = c + 1;
        -- you can equip only 1 weapon
        if c > 1 then
            --~ 			isWeapon = false;
            tests.isHandWeapon = nil
            tests.isAllLiterature = false;
            tests.canBeActivated = nil;
            tests.unequip = nil;
            tests.canBeEquippedBack = nil;
            tests.canBeEquippedContainer = nil;
            tests.brokenObject = nil;
        end
    end

    triggerEvent("OnPreFillInventoryObjectContextMenu", player, context, items);

    context.blinkOption = ISInventoryPaneContextMenu.blinkOption;

    if editItem and c == 1 and ((isClient() and playerObj:getRole():haveCapability(Capability.EditItem)) and playerObj:getInventory():contains(editItem, true) or isDebugEnabled()) then
        local option = context:addDebugOption(getText("ContextMenu_EditItem"), items, ISInventoryPaneContextMenu.onEditItem, playerObj, testItem);
    end

    -- check the recipe
    if #itemsCraft > 0 then
        local sameType = true
        for i=2,#itemsCraft do
            if itemsCraft[i]:getFullType() ~= itemsCraft[1]:getFullType() then
                sameType = false
                break
            end
        end
        if sameType then
            tests.recipe = CraftRecipeManager.getUniqueRecipeItems(itemsCraft[1], playerObj, containerList);
        end
    end


    if c == 0 then
        context:setVisible(false);
        return;
    end

    local loot = getPlayerLoot(player);
--~ 	context:addOption("Information", items, ISInventoryPaneContextMenu.onInformationItems);
	if not isInPlayerInventory then
        ISInventoryPaneContextMenu.doGrabMenu(context, items, player);
    end
    if tests.evorecipe then
        ISInventoryPaneContextMenu.doEvorecipeMenu(context, items, player, tests.evorecipe, tests.baseItem, containerList);
    end
    
    if(isInPlayerInventory and loot.inventory ~= nil and loot.inventory:getType() ~= "floor" ) and playerObj:getJoypadBind() == -1 then
        if ISInventoryPaneContextMenu.isAnyAllowed(loot.inventory, items) and not ISInventoryPaneContextMenu.isAllFav(items) then
            local label = loot.title and getText("ContextMenu_PutInContainer", loot.title) or getText("ContextMenu_Put_in_Container")
            context:addOption(label, items, ISInventoryPaneContextMenu.onPutItems, player);
        end
    end

    -- Move To
    local moveItems = ISInventoryPane.getActualItems(items)
    if #moveItems > 0 and playerObj:getJoypadBind() ~= -1 then
        local subMenu = nil
        local moveTo0 = ISInventoryPaneContextMenu.canUnpack(moveItems, player)
        local moveToWorn = {}
        local wornItems = playerObj:getWornItems()
        for i=1,wornItems:size() do
            local item = wornItems:get(i-1):getItem()
            local moveTo1 = ISInventoryPaneContextMenu.canMoveTo(moveItems, item, player)
            if moveTo1 then
                table.insert(moveToWorn, moveTo1)
            end
        end
        local moveTo2 = ISInventoryPaneContextMenu.canMoveTo(moveItems, playerObj:getPrimaryHandItem(), player)
        local moveTo3 = ISInventoryPaneContextMenu.canMoveTo(moveItems, playerObj:getSecondaryHandItem(), player)
        local moveTo4 = ISInventoryPaneContextMenu.canMoveTo(moveItems, ISInventoryPage.floorContainer[player+1], player)
        local keyRings = {}
        local inventoryItems = playerObj:getInventory():getItems()
        for i=1,inventoryItems:size() do
            local item = inventoryItems:get(i-1)
            if (item:getType() == "KeyRing" or item:hasTag( "KeyRing")) and ISInventoryPaneContextMenu.canMoveTo(moveItems, item, player) then
                table.insert(keyRings, item)
            end
        end
        local putIn = isInPlayerInventory and
                        loot.inventory and loot.inventory:getType() ~= "floor" and
                        ISInventoryPaneContextMenu.isAnyAllowed(loot.inventory, items) and
                        not ISInventoryPaneContextMenu.isAllFav(moveItems)
        if moveTo0 or (#moveToWorn > 0) or moveTo2 or moveTo3 or moveTo4 or (#keyRings > 0) or putIn then
            local option = context:addOption(getText("ContextMenu_Move_To"))
            local subMenu = context:getNew(context)
            context:addSubMenu(option, subMenu)
            local subOption
            if moveTo0 then
                subOption = subMenu:addOption(getText("ContextMenu_MoveToInventory"), moveItems, ISInventoryPaneContextMenu.onMoveItemsTo, playerInv, player)
                if not ISInventoryPaneContextMenu.hasRoomForAny(playerObj, playerInv, moveItems) then
                    subOption.notAvailable = true
                end
            end
            for _,moveTo in ipairs(moveToWorn) do
                subOption = subMenu:addOption(moveTo:getName(), moveItems, ISInventoryPaneContextMenu.onMoveItemsTo, moveTo:getInventory(), player)
                if not ISInventoryPaneContextMenu.hasRoomForAny(playerObj, moveTo, moveItems) then
                    subOption.notAvailable = true
                end
            end
            if moveTo2 then
                subOption = subMenu:addOption(moveTo2:getName(), moveItems, ISInventoryPaneContextMenu.onMoveItemsTo, moveTo2:getInventory(), player)
                if not ISInventoryPaneContextMenu.hasRoomForAny(playerObj, moveTo2, moveItems) then
                    subOption.notAvailable = true
                end
            end
            if moveTo3 then
                subOption = subMenu:addOption(moveTo3:getName(), moveItems, ISInventoryPaneContextMenu.onMoveItemsTo, moveTo3:getInventory(), player)
                if not ISInventoryPaneContextMenu.hasRoomForAny(playerObj, moveTo3, moveItems) then
                    subOption.notAvailable = true
                end
            end
            for _,moveTo in ipairs(keyRings) do
                subOption = subMenu:addOption(moveTo:getName(), moveItems, ISInventoryPaneContextMenu.onMoveItemsTo, moveTo:getInventory(), player)
                if not ISInventoryPaneContextMenu.hasRoomForAny(playerObj, moveTo, moveItems) then
                    subOption.notAvailable = true
                end
            end
            if putIn then
                subOption = subMenu:addOption(loot.title and loot.title or getText("ContextMenu_MoveToContainer"), moveItems, ISInventoryPaneContextMenu.onPutItems, player)
                if not ISInventoryPaneContextMenu.hasRoomForAny(playerObj, loot.inventory, moveItems) then
                    subOption.notAvailable = true
                end
            end
            if moveTo4 then
                subOption = subMenu:addOption(getText("ContextMenu_Floor"), moveItems, ISInventoryPaneContextMenu.onMoveItemsTo, moveTo4, player)
                if not ISInventoryPaneContextMenu.hasRoomForAny(playerObj, moveTo4, moveItems) then
                    subOption.notAvailable = true
                end
            end
        end

        if isInPlayerInventory then
            context:addOption(getText("IGUI_invpage_Transfer_all"), getPlayerInventory(player), ISInventoryPage.transferAll)
        else
            context:addOption(getText("IGUI_invpage_Loot_all"), loot, ISInventoryPage.lootAll)
        end
    end

    if #moveItems and playerObj:getJoypadBind() == -1 then
        if ISInventoryPaneContextMenu.canUnpack(moveItems, player) then
            context:addOption(getText("ContextMenu_Unpack"), moveItems, ISInventoryPaneContextMenu.onMoveItemsTo, playerObj:getInventory(), player)
        end
    end

    if tests.animalCorpse then
        AnimalContextMenu.doAnimalBodyMenuFromInv(context, playerObj, tests.animalCorpse);
    end

    if tests.inPlayerInv then
       if tests.inPlayerInv:isFavorite() then
           context:addOption(getText("ContextMenu_Unfavorite"), moveItems, ISInventoryPaneContextMenu.onFavorite, tests.inPlayerInv, false)
       else
           context:addOption(getText("IGUI_CraftUI_Favorite"), moveItems, ISInventoryPaneContextMenu.onFavorite, tests.inPlayerInv, true)
       end
    end

    if not tests.inPlayerInv and playerObj:getJoypadBind() ~= -1 then
        ISInventoryPaneContextMenu.doStoveMenu(context, player)
        ISInventoryPaneContextMenu.doTrashCanMenu(context, player)
    end

    if tests.canBeEquippedBack then
        local option = context:addOption(getText("ContextMenu_Equip_on_your_Back"), items, ISInventoryPaneContextMenu.onWearItems, player);
        if playerObj:getClothingItem_Back() then
            local tooltip = ISInventoryPaneContextMenu.addToolTip()
            tooltip.description = getText("Tooltip_ReplaceWornItems") .. " <LINE> <INDENT:20> "
            tooltip.description = tooltip.description .. playerObj:getClothingItem_Back():getDisplayName()
            option.toolTip = tooltip
        end
--     elseif tests.canBeEquippedContainer then
--         local option = context:addOption(getText("ContextMenu_Wear"), items, ISInventoryPaneContextMenu.onWearItems, player);
--         if tests.canBeEquippedContainer:getBodyLocation() and playerObj:getWornItem(tests.canBeEquippedContainer:getBodyLocation()) then
--             local tooltip = ISInventoryPaneContextMenu.addToolTip()
--             tooltip.description = getText("Tooltip_ReplaceWornItems") .. " <LINE> <INDENT:20> "
--             tooltip.description = tooltip.description .. playerObj:getWornItem(tests.canBeEquippedContainer:getBodyLocation()):getDisplayName()
--             option.toolTip = tooltip
--         end
    end

    if tests.isAllFood then
        -- Some items have a custom menu option, such as "Smoke" or "Drink" instead of "Eat".
        -- If the selected items have different menu options, don't add any eat option.
        -- If a food item has no hunger reduction (like Cigarettes) it is impossible to eat
        -- some percentage, so we shouldn't show the submenu in such cases.
        local foodItems = ISInventoryPane.getActualItems(items)
        local foodByCmd = {}
        local cmd = nil
        local hungerNotZero = 0
        for i,k in ipairs(foodItems) do
            cmd = k:getCustomMenuOption() or getText("ContextMenu_Eat")
            foodByCmd[cmd] = true
            if k:getHungChange() < 0 then
                hungerNotZero = hungerNotZero + 1
            end
        end
        local cmdCount = 0
        for k,v in pairs(foodByCmd) do
            cmdCount = cmdCount + 1
        end
        if cmdCount == 1 then
            if hungerNotZero > 0 then
                local eatOption = context:addOption(cmd, items, nil)
--                 if playerObj:getMoodles():getMoodleLevel(MoodleType.FoodEaten) >= 3 or playerObj:getNutrition():getCalories() >= 1000 then
                if playerObj:getMoodles():getMoodleLevel(MoodleType.FoodEaten) >= 3 then
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    eatOption.notAvailable = true;
                    tooltip.description = getText("Tooltip_CantEatMore");
                    eatOption.toolTip = tooltip;
                else
                    local subMenuEat = context:getNew(context)
                    context:addSubMenu(eatOption, subMenuEat)
                    local option = subMenuEat:addOption(getText("ContextMenu_Eat_All"), items, ISInventoryPaneContextMenu.onEatItems, 1, player)
                    -- ISInventoryPaneContextMenu.addEatTooltip(option, foodItems, 1.0) -- commented out as the information provided can be confusing
					-- this it to prevent eating smaller portions of food then their hunger value allows
					local baseHunger = (math.abs(( foodItems[1]:getBaseHunger() * 100 ) )) +.001
					local hungerChange = (math.abs(( foodItems[1]:getHungerChange() * 100 ) )) +.001
					--print("Base Hunger" .. tostring(baseHunger))
					--print("Hunger Change" .. tostring(hungerChange))
					if (hungerChange >= 2 ) and ( hungerChange >= baseHunger/2 ) then
						--print(tostring(baseHunger >= 2))
						--print(tostring(hungerChange >= baseHunger/2))
						option = subMenuEat:addOption(getText("ContextMenu_Eat_Half"), items, ISInventoryPaneContextMenu.onEatItems, 0.5, player)
						-- ISInventoryPaneContextMenu.addEatTooltip(option, foodItems, 0.5) -- commented out as the information provided can be confusing
					end
					-- if baseHunger >= 4 and ( hungerChange >= baseHunger/4 ) then
					if (hungerChange >= 4) and (hungerChange >= baseHunger/4) then
						--print(tostring(baseHunger >= 4))
						--print(tostring(hungerChange >= baseHunger/4))
						option = subMenuEat:addOption(getText("ContextMenu_Eat_Quarter"), items, ISInventoryPaneContextMenu.onEatItems, 0.25, player)
						-- ISInventoryPaneContextMenu.addEatTooltip(option, foodItems, 0.25) -- commented out as the information provided can be confusing
					end
                end
            elseif cmd ~= getText("ContextMenu_Eat") then
                ISInventoryPaneContextMenu.doEatOption(context, cmd, items, player, playerObj, foodItems);
            end
        end
    end
    if tests.generator then
        if not playerObj:isHandItem(tests.generator) then
            local option = context:addOption(getText("ContextMenu_GeneratorTake"), playerObj, ISInventoryPaneContextMenu.equipHeavyItem, tests.generator);
            if playerObj:getVehicle() then
                option.notAvailable = true
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                tooltip.description = getText("ContextMenu_NoTakeInVehicle");
                option.toolTip = tooltip;
            end
        end
    elseif tests.corpse then
        if not playerObj:isHandItem(tests.corpse) then
            local option = context:addOption(getText("ContextMenu_Grab_Corpse"), playerObj, ISInventoryPaneContextMenu.equipHeavyItem, tests.corpse);
            if playerObj:getVehicle() then
                option.notAvailable = true
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                tooltip.description = getText("ContextMenu_NoTakeInVehicle");
                option.toolTip = tooltip;
            end
        end
    elseif tests.twoHandsItem and not playerObj:isItemInBothHands(tests.twoHandsItem) then
        context:addOption(getText("ContextMenu_Equip_Two_Hands"), items, ISInventoryPaneContextMenu.OnTwoHandsEquip, player);
    elseif tests.force2Hands and not playerObj:isItemInBothHands(tests.force2Hands) then
        context:addOption(getText("ContextMenu_Equip_Two_Hands"), items, ISInventoryPaneContextMenu.OnTwoHandsEquip, player);
    end
    if tests.corpseAnimal then
        if getDebug() then
            context:addDebugOption("Turn into skeleton", tests.corpseAnimal, ISInventoryPaneContextMenu.onTurnIntoSkeleton);
        end
    end
    if tests.isWeapon and not tests.isAllFood and not tests.force2Hands and not tests.clothing then
        ISInventoryPaneContextMenu.doEquipOption(context, playerObj, tests.isWeapon, items, player);
    elseif tests.isSeed or tests.isBleach or tests.equippable then
        ISInventoryPaneContextMenu.doEquipOption(context, playerObj, tests.isSeed or tests.isBleach or tests.equippable, items, player);
    end
    if tests.trackItem then
        local option = context:addOption(getText("ContextMenu_InspectTrack"), playerObj, ISInventoryPaneContextMenu.onInspectTrack, tests.trackItem);
    end
    -- weapon upgrades
    tests.isWeapon = tests.isHandWeapon -- to allow upgrading broken weapons
    local hasScrewdriver = playerInv:containsTagEvalRecurse("Screwdriver", predicateNotBroken)
    if tests.isWeapon and instanceof(tests.isWeapon, "HandWeapon") and hasScrewdriver then
        local isWeapon = tests.isWeapon
        -- add parts
        local weaponParts = getSpecificPlayer(player):getInventory():getItemsFromCategory("WeaponPart");
        if weaponParts and not weaponParts:isEmpty() then
            local subMenuUp = context:getNew(context);
            local doIt = false;
            local alreadyDoneList = {};
            for i=0, weaponParts:size() - 1 do
                local part = weaponParts:get(i);
                if not alreadyDoneList[part:getName()] and part:canAttach(getSpecificPlayer(player), isWeapon) and not isWeapon:getWeaponPart(part:getPartType()) then
                    subMenuUp:addOption(weaponParts:get(i):getName(), isWeapon, ISInventoryPaneContextMenu.onUpgradeWeapon, part, getSpecificPlayer(player));
                    alreadyDoneList[part:getName()] = true;
                    doIt = true;
                end
            end
            if doIt then
                local upgradeOption = context:addOption(getText("ContextMenu_Add_Weapon_Upgrade"), items, nil);
                context:addSubMenu(upgradeOption, subMenuUp);
            end
        end
        -- remove parts
        weaponParts = isWeapon:getAllWeaponParts()
        if hasScrewdriver and weaponParts:size() > 0 then
            local removeUpgradeOption = context:addOption(getText("ContextMenu_Remove_Weapon_Upgrade"), items, nil);
            local subMenuRemove = context:getNew(context);
            context:addSubMenu(removeUpgradeOption, subMenuRemove);
            for i = 0, weaponParts:size() -1 do
                subMenuRemove:addOption(weaponParts:get(i):getName(), isWeapon, ISInventoryPaneContextMenu.onRemoveUpgradeWeapon, weaponParts:get(i), getSpecificPlayer(player));
            end
        end
    end

    if tests.isHandWeapon and tests.isHandWeapon:getExplosionTimer() > 0 then
        if tests.isHandWeapon:getSensorRange() == 0 then
            context:addOption(getText("ContextMenu_TrapSetTimerExplosion"), tests.isHandWeapon, ISInventoryPaneContextMenu.onSetBombTimer, player);
        else
            context:addOption(getText("ContextMenu_TrapSetTimerActivation"), tests.isHandWeapon, ISInventoryPaneContextMenu.onSetBombTimer, player);
        end
    end
    -- place trap/bomb
    if tests.isHandWeapon and tests.isHandWeapon:canBePlaced() then
        context:addOption(getText("ContextMenu_TrapPlace", tests.isHandWeapon:getName()), tests.isHandWeapon, ISInventoryPaneContextMenu.onPlaceTrap, getSpecificPlayer(player));
    end
    -- link remote controller
    if tests.remoteControllable then
        for i = 0, playerObj:getInventory():getItems():size() -1 do
            local item = playerObj:getInventory():getItems():get(i);
            if item:isRemoteController() and (item:getRemoteControlID() == -1 or item:getRemoteControlID() ~= tests.remoteControllable:getRemoteControlID()) then
                context:addOption(getText("ContextMenu_TrapControllerLinkTo", item:getName()), tests.remoteControllable, ISInventoryPaneContextMenu.OnLinkRemoteController, item, player);
            end
        end
        if tests.remoteControllable:getRemoteControlID() ~= -1 then
            context:addOption(getText("ContextMenu_TrapControllerReset"), tests.remoteControllable, ISInventoryPaneContextMenu.OnResetRemoteControlID, player);
        end
    end
    -- remote controller
    if tests.remoteController then
        for i = 0, playerObj:getInventory():getItems():size() -1 do
            local item = playerObj:getInventory():getItems():get(i);
            if instanceof(item, "HandWeapon") and item:canBeRemote() and (item:getRemoteControlID() == -1 or item:getRemoteControlID() ~= tests.remoteController:getRemoteControlID()) then
                context:addOption(getText("ContextMenu_TrapControllerLinkTo", item:getName()), item, ISInventoryPaneContextMenu.OnLinkRemoteController, tests.remoteController, player);
            end
        end
        if tests.remoteController:getRemoteControlID() ~= -1 then
            context:addOption(getText("ContextMenu_TrapControllerTrigger"), tests.remoteController, ISInventoryPaneContextMenu.OnTriggerRemoteController, player);
            context:addOption(getText("ContextMenu_TrapControllerReset"), tests.remoteController, ISInventoryPaneContextMenu.OnResetRemoteControlID, player);
        end
    end

    if tests.isTrap then
        context:addOption(getText("ContextMenu_Place_Trap"), tests.isTrap, ISTrapMenu.onPlaceTrap, tests.isTrap, playerObj);
    end
    
    if tests.isHandWeapon and instanceof(tests.isHandWeapon, "HandWeapon") and tests.isHandWeapon:getFireModePossibilities() and tests.isHandWeapon:getFireModePossibilities():size() > 1 then
        ISInventoryPaneContextMenu.doChangeFireModeMenu(playerObj, tests.isHandWeapon, context);
    end

    if tests.isHandWeapon and instanceof(tests.isHandWeapon, "HandWeapon") then
        ISInventoryPaneContextMenu.doReloadMenuForWeapon(playerObj, tests.isHandWeapon, context);
        tests.magazine = nil
        tests.bullet = nil
    end
    
    if tests.magazine and isInPlayerInventory then
        ISInventoryPaneContextMenu.doReloadMenuForMagazine(playerObj, tests.magazine, context);
        ISInventoryPaneContextMenu.doMagazineMenu(playerObj, tests.magazine, context);
        tests.bullet = nil
    end
    if tests.bullet and isInPlayerInventory then
        ISInventoryPaneContextMenu.doReloadMenuForBullets(playerObj, tests.bullet, context);
    end

    if tests.waterContainer and (playerObj:getStats():getThirst() > 0.1) then
        ISInventoryPaneContextMenu.doDrinkForThirstMenu(context, playerObj, tests.waterContainer)
	elseif tests.fluidContainer and (not tests.fluidContainer:getFluidContainer():isEmpty()) then
		local fluid = tests.fluidContainer:getFluidContainer():getPrimaryFluid();
		if fluid:isCategory(FluidCategory.Beverage) or fluid:getFluidTypeString() == "Bleach" then
	        ISInventoryPaneContextMenu.doDrinkFluidMenu(playerObj, tests.fluidContainer, context)	
		end
    end
	if tests.waterContainer and getCore():getOptionAutoDrink() and getSpecificPlayer(player):getInventory():contains(tests.waterContainer) then
		context:addOption(getText("ContextMenu_DisableAutodrink") , tests.waterContainer, ISInventoryPaneContextMenu.AutoDrinkOff );
	elseif tests.waterContainer  and getSpecificPlayer(player):getInventory():contains(tests.waterContainer) then
		context:addOption(getText("ContextMenu_EnableAutodrink") , tests.waterContainer, ISInventoryPaneContextMenu.AutoDrinkOn );
	end

	local pourInto = {}
	--[[
	if c == 1 and tests.waterContainer ~= nil then
		for i = 0, getSpecificPlayer(player):getInventory():getItems():size() -1 do
			local item = getSpecificPlayer(player):getInventory():getItems():get(i);
			if item ~= tests.waterContainer and item:canStoreWater() and not item:isWaterSource() then
				table.insert(pourInto, item)
			elseif item ~= tests.waterContainer and item:canStoreWater() and item:isWaterSource() and instanceof(item, "DrainableComboItem") and (1 - item:getCurrentUsesFloat()) >= item:getUseDelta() then
				table.insert(pourInto, item)
			end
		end
		if #pourInto > 0 then
			local subMenuOption = context:addOption(getText("ContextMenu_Pour_into"), items, nil);
			local subMenu = context:getNew(context)
			context:addSubMenu(subMenuOption, subMenu)
			for _,item in ipairs(pourInto) do
                if instanceof(item, "DrainableComboItem") then
					local subOption = subMenu:addOption(item:getName(), items, ISInventoryPaneContextMenu.onTransferWater, tests.waterContainer, item, player);
					local tooltip = ISInventoryPaneContextMenu.addToolTip()
					local tx = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
					tooltip.description = string.format("%s: <SETX:%d> %d / %d",
						getText("ContextMenu_WaterName"), tx, item:getCurrentUses(), 1.0 / item:getUseDelta() + 0.0001)
                    if item:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
						tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
					end
					subOption.toolTip = tooltip
                else
                    subMenu:addOption(item:getName(), items, ISInventoryPaneContextMenu.onTransferWater, tests.waterContainer, item, player);
                end
			end
		end

		context:addOption(getText("ContextMenu_Pour_on_Ground"), items, ISInventoryPaneContextMenu.onEmptyWaterContainer, tests.waterContainer, player);
	end
	]]--

	if c == 1 then
		ISInventoryPaneContextMenu.checkConsolidate(tests.drainable, playerObj, context, pourInto);
	end

	if c == 1 and tests.pourOnGround and not tests.waterContainer then
		context:addOption(getText("ContextMenu_Pour_on_Ground"), items, ISInventoryPaneContextMenu.onDumpContents, tests.pourOnGround, player);
	end

	if tests.isAllPills then
        local pillsItems = ISInventoryPane.getActualItems(items)
        local cmd = getText("ContextMenu_Take_pills")
        for i,k in ipairs( pillsItems) do
			if k:getCustomMenuOption() then cmd = k:getCustomMenuOption() end
        end
		context:addOption(cmd, items, ISInventoryPaneContextMenu.onPillsItems, player);
    end
	-- if tests.isAllLiterature and not getSpecificPlayer(player):getTraits():isIlliterate() then
	if tests.isAllLiterature then
        ISInventoryPaneContextMenu.doLiteratureMenu(context, items, player)
    end
    if tests.clothing and tests.clothing:getCoveredParts():size() > 0 then
        context:addOption(getText("IGUI_invpanel_Inspect"), playerObj, ISInventoryPaneContextMenu.onInspectClothing, tests.clothing);
--        ISInventoryPaneContextMenu.doClothingPatchMenu(player, clothing, context);
    end

-- 	if (tests.clothing) and not tests.unequip then
--         print("tests.clothing" .. tests.clothing:getDisplayName())
-- 	end
--
-- 	if (tests.canBeEquippedContainer) and not tests.unequip then
--         print("tests.canBeEquippedContainer" .. tests.canBeEquippedContainer:getDisplayName())
-- 	end
--
-- 	if (tests.canBeEquippedOther) and not tests.unequip then
--         print("tests.canBeEquippedOther" .. tests.canBeEquippedOther:getDisplayName())
-- 	end

	if ((tests.clothing and not tests.clothing:isBroken()) or (tests.canBeEquippedContainer or tests.canBeEquippedOther)) and not tests.unequip then
        ISInventoryPaneContextMenu.doWearClothingMenu(player, tests.clothing or tests.canBeEquippedContainer or tests.canBeEquippedOther, items, context);
	end
    if tests.clothing and tests.clothing:getWetness() > 15 then
        context:addOption(getText("ContextMenu_WringClothes"), items, ISInventoryPaneContextMenu.onWringClothing, player)    
    end

	local addDropOption = true
	if tests.unequip and isForceDropHeavyItem(tests.unequip) then
		if isClient() then
			context:addOption(getText("ContextMenu_Drop"), items, ISInventoryPaneContextMenu.onDropItems, player);
		else
			context:addOption(getText("ContextMenu_Drop"), items, ISInventoryPaneContextMenu.onUnEquip, player);
		end
		addDropOption = false
	elseif tests.unequip then
		context:addOption(getText("ContextMenu_Unequip"), items, ISInventoryPaneContextMenu.onUnEquip, player);
	end

    if tests.fishingRod ~= nil then
        ISInventoryPaneContextMenu.addFishRodOptions(tests.fishingRod, tests.haveLure, context, player)
    end

	-- recipe dynamic context menu
	if tests.recipe ~= nil then
		ISInventoryPaneContextMenu.addNewCraftingDynamicalContextMenu(itemsCraft[1], context, tests.recipe, player, containerList);
    end
	if tests.canBeActivated ~= nil and (not instanceof(tests.canBeActivated, "Drainable") or tests.canBeActivated:getCurrentUsesFloat() > 0) then
        if (tests.canBeActivated:getType() ~= "CandleLit") and (tests.canBeActivated:getType() ~= "Lantern_HurricaneLit") then
            local txt = getText("ContextMenu_Turn_On");
            if tests.canBeActivated:isActivated() then
                txt = getText("ContextMenu_Turn_Off");
            end
            context:addOption(txt, tests.canBeActivated, ISInventoryPaneContextMenu.onActivateItem, player);
        end
	end
	if tests.isAllBandage then
        ISInventoryPaneContextMenu.doBandageMenu(context, items, player);
	end
	-- dry yourself with a towel
	if tests.canBeDry then
		context:addOption(getText("ContextMenu_Dry_myself"), items, ISInventoryPaneContextMenu.onDryMyself, player);
    end
    if tests.hairDye and playerObj:getHumanVisual():getHairModel() and playerObj:getHumanVisual():getHairModel() ~= "Bald" then
        context:addOption(getText("ContextMenu_DyeHair"), tests.hairDye, ISInventoryPaneContextMenu.onDyeHair, playerObj, false);
    end
    if tests.hairDye and playerObj:getHumanVisual():getBeardModel() and playerObj:getHumanVisual():getBeardModel() ~= "" then
        context:addOption(getText("ContextMenu_DyeBeard"), tests.hairDye, ISInventoryPaneContextMenu.onDyeHair, playerObj, true);
    end
    if tests.makeup then
        ISInventoryPaneContextMenu.doMakeUpMenu(context, tests.makeup, playerObj)
    end
    if isInPlayerInventory and addDropOption and playerObj:getJoypadBind() == -1 and
            not ISInventoryPaneContextMenu.isAllFav(items) and
            not ISInventoryPaneContextMenu.isAllNoDropMoveable(items) then
        context:addOption(getText("ContextMenu_Drop"), items, ISInventoryPaneContextMenu.onDropItems, player);
    end

    ISInventoryPaneContextMenu.doPlace3DItemOption(items, playerObj, context)

    if tests.brokenObject then
        local fixingList = FixingManager.getFixes(tests.brokenObject);
        if not fixingList:isEmpty() then
            local fixOption = context:addOption(getText("ContextMenu_Repair") .. getItemNameFromFullType(tests.brokenObject:getFullType()), items, nil);
            local subMenuFix = ISContextMenu:getNew(context);
            context:addSubMenu(fixOption, subMenuFix);
            for i=0,fixingList:size()-1 do
                ISInventoryPaneContextMenu.buildFixingMenu(tests.brokenObject, player, fixingList:get(i), i, fixOption, subMenuFix)
            end
        end
    end
    if tests.alarmClock and tests.alarmClock:isDigital() then
        if tests.alarmClock:isRinging() then
            context:addOption(getText("ContextMenu_StopAlarm"), tests.alarmClock, ISInventoryPaneContextMenu.onStopAlarm, player);
        end
        context:addOption(getText("ContextMenu_SetAlarm"), tests.alarmClock, ISInventoryPaneContextMenu.onSetAlarm, player);
    end
    if tests.clothingItemExtra and not tests.clothingItemExtra:isBroken() then
        ISInventoryPaneContextMenu.doClothingItemExtraMenu(context, tests.clothingItemExtra, playerObj);
    end
    if tests.canBeRenamed then
        context:addOption(getText("ContextMenu_RenameBag"), tests.canBeRenamed, ISInventoryPaneContextMenu.onRenameBag, player);
    end
    if tests.canBeRenamedFood then
        context:addOption(getText("ContextMenu_RenameFood") .. tests.canBeRenamedFood:getName(), tests.canBeRenamedFood, ISInventoryPaneContextMenu.onRenameFood, player);
    end
    if tests.canBeWrite then
		local editable = playerInv:containsTagRecurse("Write") or playerInv:containsTagRecurse("BluePen") or playerInv:containsTagRecurse("Pen") or playerInv:containsTagRecurse("Pencil") or playerInv:containsTagRecurse("RedPen") or playerInv:containsTagRecurse("GreenPen")
		-- illiterate  characters cannot write notes
		-- if playerObj:getTraits():isIlliterate() then 
			-- editable = false
		-- end
		if tests.canBeWrite:getLockedBy() and tests.canBeWrite:getLockedBy() ~= playerObj:getUsername() then
			editable = false
		end
		local note
		if not editable then
			note = context:addOption(getText("ContextMenu_Read_Note", tests.canBeWrite:getName()), tests.canBeWrite, ISInventoryPaneContextMenu.onWriteSomething, false, player);
		else
			note = context:addOption(getText("ContextMenu_Write_Note", tests.canBeWrite:getName()), tests.canBeWrite, ISInventoryPaneContextMenu.onWriteSomething, true, player);
		end
		-- if it's too dark you can't read or write notes

		if playerObj:tooDarkToRead() then
-- 		if playerObj:getSquare():getLightLevel(player) < 0.43 then
			note.notAvailable = true
			note.toolTip = ISInventoryPaneContextMenu.addToolTip();
            note.toolTip.description = getText("ContextMenu_TooDark");
        elseif not editable and tests.canBeWrite:isEmptyPages() then
            note.notAvailable = true;
            note.toolTip = ISInventoryPaneContextMenu.addToolTip();
            note.toolTip.description = getText("ContextMenu_EmptyNotebook");
		-- illiterate  characters cannot read or write notes
		elseif playerObj:getTraits():isIlliterate() then 			
			note.notAvailable = true
            note.toolTip = ISInventoryPaneContextMenu.addToolTip();
			note.toolTip.description = getText("ContextMenu_Illiterate");
		end
    end
    if tests.map then
        local readMap = context:addOption(getText("ContextMenu_CheckMap"), tests.map, ISInventoryPaneContextMenu.onCheckMap, player);
		if playerObj:tooDarkToRead() then
-- 		if playerObj:getSquare():getLightLevel(player) < 0.43 then
			readMap.notAvailable = true
			local tooltip = ISInventoryPaneContextMenu.addToolTip();
			tooltip.description = getText("ContextMenu_TooDark");
			readMap.toolTip = tooltip;	
		end
        context:addOption(getText("ContextMenu_RenameMap"), tests.map, ISInventoryPaneContextMenu.onRenameMap, player);
    end

--	local tests.carBatteryCharger = playerObj:getInventory():getItemFromType("CarBatteryCharger")
	if tests.carBatteryCharger then
		context:addOption(getText("ContextMenu_CarBatteryCharger_Place"), playerObj, ISInventoryPaneContextMenu.onPlaceCarBatteryCharger, tests.carBatteryCharger)
    end
    
    ISHotbar.doMenuFromInventory(player, testItem, context);

    -- use the event (as you would 'OnTick' etc) to add items to context menu without mod conflicts.
    triggerEvent("OnFillInventoryObjectContextMenu", player, context, items);

    return context;
end

ISInventoryPaneContextMenu.createMenuNoItems = function(playerNum, isLoot, x, y)

    if ISInventoryPaneContextMenu.dontCreateMenu then return end

    if UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then return end

    local playerObj = getSpecificPlayer(playerNum)
    
    local loot = getPlayerLoot(playerNum)

    local context = ISContextMenu.get(playerNum, x, y)

    triggerEvent("OnPreFillInventoryContextMenuNoItems", playerNum, context, isLoot)

    if isLoot and playerObj:getJoypadBind() ~= -1 then
        ISInventoryPaneContextMenu.doStoveMenu(context, playerNum)
        ISInventoryPaneContextMenu.doTrashCanMenu(context, playerNum)
    end

    triggerEvent("OnFillInventoryContextMenuNoItems", playerNum, context, isLoot)

    if context.numOptions == 1 then
        context:setVisible(false)
        return nil
    end

    return context
end

function ISInventoryPaneContextMenu.doStoveMenu(context, playerNum)
    local playerObj = getSpecificPlayer(playerNum)
    local loot = getPlayerLoot(playerNum)

    if loot.inventoryPane.inventory and getCore():getGameMode() ~= "LastStand" then
        local object = loot.inventoryPane.inventory:getParent()
        if instanceof(object, "IsoCombinationWasherDryer") then
            ISWorldObjectContextMenu.toggleComboWasherDryer(context, playerObj, object)
            return
        end
    end

    -- Microwave, Stove, ClothingWasher, ClothingDryer
    if loot.toggleStove:isVisible() then
        context:addOption(loot.toggleStove.title, loot, ISInventoryPage.toggleStove)
    end

    if loot.inventoryPane.inventory and getCore():getGameMode() ~= "LastStand" then
        local stove = loot.inventoryPane.inventory:getParent()
        if instanceof(stove, "IsoStove") and stove:getContainer() and stove:getContainer():isPowered() then
            if stove:getContainer():getType() == "microwave" then
                context:addOption(getText("ContextMenu_StoveSetting"), nil, ISWorldObjectContextMenu.onMicrowaveSetting, stove, playerNum)
            elseif stove:getContainer():isStove() then
--             elseif stove:getContainer():getType() == "stove" then
                context:addOption(getText("ContextMenu_StoveSetting"), nil, ISWorldObjectContextMenu.onStoveSetting, stove, playerNum)
            end
        end
    end
end

function ISInventoryPaneContextMenu.doTrashCanMenu(context, playerNum)
    local loot = getPlayerLoot(playerNum)

    if loot.removeAll:isVisible() then
        context:addOption(loot.removeAll.title, loot, ISInventoryPage.removeAll)
    end
end

function ISInventoryPaneContextMenu.doLiteratureMenu(context, items, player)
	local playerObj = getSpecificPlayer(player)
	local actualItems = ISInventoryPane.getActualItems(items)
	local picture =  false
	local picturebook = false
	local recentlyRead = false
	local uninteresting = false
	for i,k in ipairs(actualItems) do
        if playerObj:getTraits():isIlliterate() and (k:hasTag("Picturebook") and not k:hasTag("Picture")) and playerObj:tooDarkToRead() then
--         if playerObj:getTraits():isIlliterate() and (k:hasTag("Picturebook") and not k:hasTag("Picture")) and playerObj:getSquare():getLightLevel(player) < 0.43 then
			local nope = context:addOption(getText("ContextMenu_Look_at_pictures"));
            nope.notAvailable = true -- this is how you make context options red
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_TooDarkToSee");
            nope.toolTip = tooltip;
            return
        elseif playerObj:getTraits():isIlliterate() and (not k:hasTag("Picturebook") and not k:hasTag("Picture")) then
            local nope = context:addOption(getText("ContextMenu_Read"));
            nope.notAvailable = true
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_Illiterate");
            nope.toolTip = tooltip;
            return
		elseif playerObj:tooDarkToRead() then
			local nope = context:addOption(getText("ContextMenu_Read"));
			nope.notAvailable = true
			local tooltip = ISInventoryPaneContextMenu.addToolTip();
			tooltip.description = getText("ContextMenu_TooDark");
			nope.toolTip = tooltip;	
			return
-- 		elseif k:getModData().literatureTitle and playerObj:isLiteratureRead(k:getModData().literatureTitle) then
-- 			local nope = context:addOption(getText("ContextMenu_Read"));
-- 			nope.notAvailable = true -- this is how you make context options red
-- 			local tooltip = ISInventoryPaneContextMenu.addToolTip();
-- 			tooltip.description = getText("ContextMenu_RecentlyRead");
-- 			nope.toolTip = tooltip;
-- 			return
		elseif k:getLvlSkillTrained() ~= -1 and SkillBook[k:getSkillTrained()].perk and	k:getLvlSkillTrained() > playerObj:getPerkLevel(SkillBook[k:getSkillTrained()].perk) + 1 then
			local nope = context:addOption(getText("ContextMenu_Read"));	
			nope.notAvailable = true
			local tooltip = ISInventoryPaneContextMenu.addToolTip();
			tooltip.description = getText("ContextMenu_TooComplicated");
			nope.toolTip = tooltip;	
			return
		end
		if k:hasTag("Picture") then picture = true end
		if k:hasTag("Picturebook") then picturebook = true end
		if k:hasTag("Uninteresting") then uninteresting = true end
		if k:getModData().literatureTitle and playerObj:isLiteratureRead(k:getModData().literatureTitle) then recentlyRead = true end
		break
    end
    local readOption
    if playerObj:getTraits():isIlliterate() and picturebook and not recentlyRead then
        readOption = context:addOption(getText("ContextMenu_Look_at_pictures"), items, ISInventoryPaneContextMenu.onLiteratureItems, player);
    elseif playerObj:getTraits():isIlliterate() and picturebook and recentlyRead then
        readOption = context:addOption(getText("ContextMenu_ReLook_at_pictures"), items, ISInventoryPaneContextMenu.onLiteratureItems, player);
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("ContextMenu_RecentlyRead");
        readOption.toolTip = tooltip;
    elseif picture and recentlyRead then
        readOption = context:addOption(getText("ContextMenu_ReLook_at_picture"), items, ISInventoryPaneContextMenu.onLiteratureItems, player);
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("ContextMenu_RecentlyRead");
        readOption.toolTip = tooltip;
    elseif picture then
        readOption = context:addOption(getText("ContextMenu_Look_at_picture"), items, ISInventoryPaneContextMenu.onLiteratureItems, player);
    elseif recentlyRead then
        readOption = context:addOption(getText("ContextMenu_ReRead"), items, ISInventoryPaneContextMenu.onLiteratureItems, player);
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("ContextMenu_RecentlyRead");
        readOption.toolTip = tooltip;
    else
        readOption = context:addOption(getText("ContextMenu_Read"), items, ISInventoryPaneContextMenu.onLiteratureItems, player);
        if uninteresting then
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_EmptyNotebook");
            readOption.toolTip = tooltip;
            readOption.notAvailable = true;
        end
    end
    if playerObj:isAsleep() then
        readOption.notAvailable = true;
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("ContextMenu_NoOptionSleeping");
        readOption.toolTip = tooltip;
    end
end
    
function ISInventoryPaneContextMenu.doBandageMenu(context, items, player)
    -- we get all the damaged body part
    local bodyPartDamaged = ISInventoryPaneContextMenu.haveDamagePart(player);
    -- if any part is damaged, we gonna create a sub menu with them
    if #bodyPartDamaged > 0 then
        local bandageOption = context:addOption(getText("ContextMenu_Apply_Bandage"), bodyPartDamaged, nil);
        -- create a new contextual menu
        local subMenuBandage = context:getNew(context);
        -- we add our new menu to the option we want (here bandage)
        context:addSubMenu(bandageOption, subMenuBandage);
        for i,v in ipairs(bodyPartDamaged) do
            subMenuBandage:addOption(BodyPartType.getDisplayName(v:getType()), items, ISInventoryPaneContextMenu.onApplyBandage, v, player);
        end
    end
end

function ISInventoryPaneContextMenu.canRipItem(playerObj, item)
    if playerObj:isEquippedClothing(item) or item:isFavorite() then
        return false
    end
    if item:getFabricType() and instanceof(item, "Clothing") then
        local fabricType = ClothingRecipesDefinitions["FabricType"][item:getFabricType()]
        if not fabricType then
            return false
        end
        if fabricType.tools and not playerObj:getInventory():getItemFromType(fabricType.tools, true, true) then
            return false
        end
        return true
    end
    if ClothingRecipesDefinitions[item:getType()] then
        return true
    end
    return false
end

ISInventoryPaneContextMenu.addFishRodOptions = function(fishingRod, haveLure, context, player)
    if fishingRod:isBroken() then return end

    local invItems = getSpecificPlayer(player):getInventory():getAllEvalRecurse(function(_item) return true end, ArrayList.new())
--[[
    context:addOption(getText("ContextMenu_Fishing"), player, function()
        local window = PZAPI.UI.fishWindow{
            x = 730, y = 100,
        }
        window:init()
    end)
]]
    if haveLure then
        context:addOption(getText("ContextMenu_Remove_Bait"), player, ISInventoryPaneContextMenu.removeLure, fishingRod)
    else
        local lureItems = {}
        for i = 0, invItems:size()-1 do
            local item = invItems:get(i);
            if Fishing.IsLure(item:getFullType()) and (not instanceof(item, "Food") or not item:isCooked()) then
                table.insert(lureItems, item)
            end
        end
        if #lureItems ~= 0 then
            local option = context:addOption(getText("ContextMenu_Add_Bait"))
            local subMenu = context:getNew(context);
            context:addSubMenu(option, subMenu);

            local checkedLures = {}
            for i, item in ipairs(lureItems) do
                if not checkedLures[item:getFullType()] then
                    subMenu:addOption(item:getName(), player, ISInventoryPaneContextMenu.addLure, fishingRod, item)
                    checkedLures[item:getFullType()] = true
                end
            end
        end
    end

    local hooks = {}
    local lines = {}
    for i = 0, invItems:size()-1 do
        local item = invItems:get(i);
        if item:hasTag("FishingHook") and item:getType() ~= fishingRod:getModData().fishing_HookType then
            table.insert(hooks, item)
        end
        if item:hasTag("FishingLine") and item:getType() ~= fishingRod:getModData().fishing_LineType then
            table.insert(lines, item)
        end
    end
    if #hooks ~= 0 then
        local option = context:addOption(getText("ContextMenu_Change_Fishing_Hook") .. ":")
        local subMenu = context:getNew(context);
        context:addSubMenu(option, subMenu);

        local checkedHooks = {}
        for i, item in ipairs(hooks) do
            if not checkedHooks[item:getFullType()] then
                subMenu:addOption(item:getName(), player, ISInventoryPaneContextMenu.changeHook, fishingRod, item)
                checkedHooks[item:getFullType()] = true
            end
        end
    end
    if #lines ~= 0 then
        local option = context:addOption(getText("ContextMenu_Change_Fishing_Line"))
        local subMenu = context:getNew(context);
        context:addSubMenu(option, subMenu);

        local checkedLines = {}
        for i, item in ipairs(lines) do
            if not checkedLines[item:getFullType()] then
                subMenu:addOption(item:getName(), player, ISInventoryPaneContextMenu.changeLine, fishingRod, item)
                checkedLines[item:getFullType()] = true
            end
        end
    end
end

ISInventoryPaneContextMenu.removeLure = function(player, fishingRod)
    if getSpecificPlayer(player):getSecondaryHandItem() ~= nil then
        ISTimedActionQueue.add(ISUnequipAction:new(getSpecificPlayer(player), getSpecificPlayer(player):getSecondaryHandItem(), 50));
    end
    ISInventoryPaneContextMenu.equipWeapon(fishingRod, true, false, player);
    ISTimedActionQueue.add(AIRemoveLureAction:new(getSpecificPlayer(player), fishingRod));
end

ISInventoryPaneContextMenu.addLure = function(player, fishingRod, lure)
    ISInventoryPaneContextMenu.transferIfNeeded(getSpecificPlayer(player), lure)
    ISInventoryPaneContextMenu.equipWeapon(lure, false, false, player);
    ISInventoryPaneContextMenu.equipWeapon(fishingRod, true, false, player);
    ISTimedActionQueue.add(AIAttachLureAction:new(getSpecificPlayer(player), fishingRod, lure));
end

ISInventoryPaneContextMenu.changeHook = function(player, fishingRod, hook)
    ISInventoryPaneContextMenu.transferIfNeeded(getSpecificPlayer(player), hook)
    ISInventoryPaneContextMenu.equipWeapon(hook, false, false, player);
    ISInventoryPaneContextMenu.equipWeapon(fishingRod, true, false, player);
    ISTimedActionQueue.add(ISChangeFishingRodEquip:new(getSpecificPlayer(player), fishingRod, hook));
end

ISInventoryPaneContextMenu.changeLine = function(player, fishingRod, line)
    ISInventoryPaneContextMenu.transferIfNeeded(getSpecificPlayer(player), line)
    ISInventoryPaneContextMenu.equipWeapon(line, false, false, player);
    ISInventoryPaneContextMenu.equipWeapon(fishingRod, true, false, player);
    ISTimedActionQueue.add(ISChangeFishingRodEquip:new(getSpecificPlayer(player), fishingRod, line));
end

ISInventoryPaneContextMenu.onInspectClothing = function(playerObj, clothing)
	if luautils.haveToBeTransfered(playerObj, clothing) then
		local action = ISInventoryTransferAction:new(playerObj, clothing, clothing:getContainer(), playerObj:getInventory())
		action:setOnComplete(ISInventoryPaneContextMenu.onInspectClothingUI, playerObj, clothing)
		ISTimedActionQueue.add(action)
	else
		ISInventoryPaneContextMenu.onInspectClothingUI(playerObj, clothing)
	end
end

ISInventoryPaneContextMenu.onInspectClothingUI = function(player, clothing)
    local playerNum = player:getPlayerNum()
    if ISGarmentUI.windows[playerNum] then
        ISGarmentUI.windows[playerNum]:close();
    end
    local window = ISGarmentUI:new(-1, 500, player, clothing);
    window:initialise();
    window:addToUIManager();
    ISGarmentUI.windows[playerNum] = window
    if JoypadState.players[playerNum+1] then
        window.prevFocus = JoypadState.players[playerNum+1].focus
        setJoypadFocus(playerNum, window)
    end
end

ISInventoryPaneContextMenu.doClothingPatchMenu = function(player, clothing, context)
    local playerObj = getSpecificPlayer(player);

--    if clothing:getHolesNumber() == 0 then
--        return;
--    end

    if not clothing:getFabricType() then
        return;
    end
    

    -- you need thread and needle
    local thread = playerObj:getInventory():getItemFromType("Thread", true, true);
    local needle = playerObj:getInventory():getItemFromType("Needle", true, true) or playerObj:getInventory():getFirstTagRecurse("SewingNeedle");
    local fabric1 = playerObj:getInventory():getItemFromType("RippedSheets", true, true);
    local fabric2 = playerObj:getInventory():getItemFromType("DenimStrips", true, true);
    local fabric3 = playerObj:getInventory():getItemFromType("LeatherStrips", true, true);
    if not thread or not needle or (not fabric1 and not fabric2 and not fabric3) then
        local patchOption = context:addOption(getText("ContextMenu_Patch"));
        patchOption.notAvailable = true;
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("ContextMenu_CantRepair");
        patchOption.toolTip = tooltip;
        return;
    end

    local patchOption = context:addOption(getText("ContextMenu_Patch"));
    local subMenuPatch = context:getNew(context);
    context:addSubMenu(patchOption, subMenuPatch);
    
    -- we first gonna display repair, then upgrade then remove patches
    local repairOption = subMenuPatch:addOption(getText("ContextMenu_PatchHole"));
    local subMenuRepair = context:getNew(subMenuPatch);
    subMenuPatch:addSubMenu(repairOption, subMenuRepair);

    local upgradeOption = subMenuPatch:addOption(getText("ContextMenu_AddPadding"));
    local subMenuUpgrade = context:getNew(subMenuPatch);
    subMenuPatch:addSubMenu(upgradeOption, subMenuUpgrade);
    
    local removeOption = subMenuPatch:addOption(getText("ContextMenu_RemovePatch"));
    local subMenuRemove = context:getNew(subMenuPatch);
    subMenuPatch:addSubMenu(removeOption, subMenuRemove);
    
    local coveredParts = clothing:getCoveredParts();
    for i=0, coveredParts:size() - 1 do
        local part = coveredParts:get(i);
        local hole = clothing:getVisual():getHole(part);
        local subMenuToUse = subMenuUpgrade;
--        if hole and hole > 0 then
        local text = part:getDisplayName();
        if hole and hole > 0 then
            subMenuToUse = subMenuRepair;
        end
    
        -- removing patch
        local removePatch;
        local patch = clothing:getPatchType(part);
        if patch then
            removePatch = true;
            local option = subMenuRemove:addOption(patch:getFabricTypeName(), playerObj, ISInventoryPaneContextMenu.removePatch, clothing, part, thread, needle)
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("Tooltip_GetPatchBack", ISRemovePatch.chanceToGetPatchBack(playerObj)) .. " <RGB:1,0,0> " .. getText("Tooltip_ScratchDefense")  .. " -" .. patch:getScratchDefense() .. " <LINE> " .. getText("Tooltip_BiteDefense") .. " -" .. patch:getBiteDefense();
            option.toolTip = tooltip;
        else -- adding patch
            local partOption = subMenuToUse:addOption(text);
            local subMenuPart = context:getNew(subMenuToUse);
            subMenuToUse:addSubMenu(partOption, subMenuPart);
        
            if fabric1 then
                local option = subMenuPart:addOption(fabric1:getDisplayName(), playerObj, ISInventoryPaneContextMenu.repairClothing, clothing, part, fabric1, thread, needle)
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                if clothing:canFullyRestore(playerObj, part, fabric1) then
                    tooltip.description = getText("IGUI_perks_Tailoring") .. " :" .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE> <RGB:0,1,0> " .. getText("Tooltip_FullyRestore");
                else
                    tooltip.description = getText("IGUI_perks_Tailoring") .. " :" .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE> <RGB:0,1,0> " .. getText("Tooltip_ScratchDefense")  .. " +" .. Clothing.getScratchDefenseFromItem(playerObj, fabric1) .. " <LINE> " .. getText("Tooltip_BiteDefense") .. " +" .. Clothing.getBiteDefenseFromItem(playerObj, fabric1);
                end
                option.toolTip = tooltip;
            end
            if fabric2 then
                local option = subMenuPart:addOption(fabric2:getDisplayName(), playerObj, ISInventoryPaneContextMenu.repairClothing, clothing, part, fabric2, thread, needle)
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                if clothing:canFullyRestore(playerObj, part, fabric2) then
                    tooltip.description = getText("IGUI_perks_Tailoring") .. " :" .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE> <RGB:0,1,0> " .. getText("Tooltip_FullyRestore");
                else
                    tooltip.description = getText("IGUI_perks_Tailoring") .. " :" .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE>  <RGB:0,1,0> " .. getText("Tooltip_ScratchDefense")  .. " +" .. Clothing.getScratchDefenseFromItem(playerObj, fabric2) .. " <LINE> " .. getText("Tooltip_BiteDefense") .. " +" .. Clothing.getBiteDefenseFromItem(playerObj, fabric2);
                end
                option.toolTip = tooltip;
            end
            if fabric3 then
                local option = subMenuPart:addOption(fabric3:getDisplayName(), playerObj, ISInventoryPaneContextMenu.repairClothing, clothing, part, fabric3, thread, needle)
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                if clothing:canFullyRestore(playerObj, part, fabric3) then
                    tooltip.description = getText("IGUI_perks_Tailoring") .. " :" .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE> <RGB:0,1,0> " .. getText("Tooltip_FullyRestore");
                else
                    tooltip.description = getText("IGUI_perks_Tailoring") .. " :" .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE>  <RGB:0,1,0> " .. getText("Tooltip_ScratchDefense")  .. " +" .. Clothing.getScratchDefenseFromItem(playerObj, fabric3) .. " <LINE> " .. getText("Tooltip_BiteDefense") .. " +" .. Clothing.getBiteDefenseFromItem(playerObj, fabric3);
                end
                option.toolTip = tooltip;
            end
        end
--        end
    end

    if #subMenuRepair.options == 0 then
        repairOption.subOption = nil;
        repairOption.notAvailable = true;
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("Tooltip_NothingToRepair");
        repairOption.toolTip = tooltip;
    end
    
    if #subMenuRemove.options == 0 then
        removeOption.subOption = nil;
        removeOption.notAvailable = true;
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("Tooltip_NothingToRemove");
        removeOption.toolTip = tooltip;
    end
    
    if #subMenuUpgrade.options == 0 then
        upgradeOption.subOption = nil;
        upgradeOption.notAvailable = true;
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("Tooltip_NothingToUpgrade");
        upgradeOption.toolTip = tooltip;
    end
end

ISInventoryPaneContextMenu.removePatch = function(player, clothing, part, needle)
    if luautils.haveToBeTransfered(player, needle) then
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player, needle, needle:getContainer(), player:getInventory()))
        ISGarmentUI.setBodyPartForLastAction(player, part)
    end
    if luautils.haveToBeTransfered(player, clothing) then
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player, clothing, clothing:getContainer(), player:getInventory()))
        ISGarmentUI.setBodyPartForLastAction(player, part)
    end
    
    ISTimedActionQueue.add(ISRemovePatch:new(player, clothing, part, needle));
end

ISInventoryPaneContextMenu.removeAllPatches = function(player, clothing, parts, needle)
    for i=1, #parts do
        local part = parts[i];
        local patch = clothing:getPatchType(part);
        if patch then
            ISInventoryPaneContextMenu.removePatch(player, clothing, part, needle);
        end
    end
end

ISInventoryPaneContextMenu.repairClothing = function(player, clothing, part, fabric, thread, needle)
    -- if you piled up tailor job we ensure we get a correct fabric
    if fabric == nil then fabric = player:getInventory():getItemFromType(fabric:getType(), true, true); end
    if thread == nil then thread = player:getInventory():getItemFromType(thread:getType(), true, true); end

    if fabric == nil or thread == nil then return end
    if luautils.haveToBeTransfered(player, fabric) then
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player, fabric, fabric:getContainer(), player:getInventory()))
        ISGarmentUI.setBodyPartForLastAction(player, part)
    end
    if luautils.haveToBeTransfered(player, thread) then
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player, thread, thread:getContainer(), player:getInventory()))
        ISGarmentUI.setBodyPartForLastAction(player, part)
    end
    if luautils.haveToBeTransfered(player, needle) then
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player, needle, needle:getContainer(), player:getInventory()))
        ISGarmentUI.setBodyPartForLastAction(player, part)
    end
    if luautils.haveToBeTransfered(player, clothing) then
        ISTimedActionQueue.add(ISInventoryTransferAction:new(player, clothing, clothing:getContainer(), player:getInventory()))
        ISGarmentUI.setBodyPartForLastAction(player, part)
    end
    
    ISTimedActionQueue.add(ISRepairClothing:new(player, clothing, part, fabric, thread, needle));
end

ISInventoryPaneContextMenu.repairAllClothing = function(player, clothing, parts, fabric, thread, needle, onlyHoles)

    local fabricArray = player:getInventory():getItemsFromType(fabric:getType(), true);
    local fabricCount = player:getInventory():getItemCount(fabric:getType(), true);
    local threadArray = player:getInventory():getItemsFromType(thread:getType(), true);
    local threadCount = player:getInventory():getItemCount(thread:getType(), true);

    local successfulActionsAdded = 0;
    local currentThreadUsed = 0;

    for i=1, #parts do

        local part = parts[i];
        local hole = clothing:getVisual():getHole(part) > 0;
        local patch = clothing:getPatchType(part);

        -- Amendment to avoid error when the thread's uses are over
        if (successfulActionsAdded > 0) and ((threadArray:get(currentThreadUsed):getCurrentUsesFloat() - (successfulActionsAdded * 0.1)) < 0.1) then
            currentThreadUsed = currentThreadUsed + 1;
            if(currentThreadUsed >= threadCount) then return; end
        end

        if hole and onlyHoles then -- Patch all holes
            ISInventoryPaneContextMenu.repairClothing(player, clothing, part, fabricArray:get(successfulActionsAdded), threadArray:get(currentThreadUsed), needle);
            successfulActionsAdded = successfulActionsAdded + 1;
        elseif (not patch) and (not hole) and (not onlyHoles) then -- Pad every non-hole
            ISInventoryPaneContextMenu.repairClothing(player, clothing, part, fabricArray:get(successfulActionsAdded), threadArray:get(currentThreadUsed), needle);
            successfulActionsAdded = successfulActionsAdded + 1;
        end

        if(successfulActionsAdded >= fabricCount) then return; end
    end

end

ISInventoryPaneContextMenu.doWearClothingTooltip = function(playerObj, newItem, currentItem, option)
	local replaceItems = {};
	local previousBiteDefense = 0;
	local previousScratchDefense = 0;
	local previousCombatModifier = 0;
	local wornItems = playerObj:getWornItems()
	local bodyLocationGroup = wornItems:getBodyLocationGroup()
	local location = (newItem:IsClothing() or newItem:IsInventoryContainer()) and newItem:getBodyLocation() or newItem:canBeEquipped()

	for i=1,wornItems:size() do
		local wornItem = wornItems:get(i-1)
		local item = wornItem:getItem()

		if (newItem:getBodyLocation() == wornItem:getLocation()) or	(location ~= ""	and bodyLocationGroup:isExclusive(location,	wornItem:getLocation())) then
			if item ~= newItem and item ~= currentItem then
				table.insert(replaceItems, item);
			end
			if item:IsClothing() then
				previousBiteDefense = previousBiteDefense + item:getBiteDefense();
				previousScratchDefense = previousScratchDefense + item:getScratchDefense();
				previousCombatModifier = previousCombatModifier + item:getCombatSpeedModifier();
			end
		end
	end

	local newBiteDefense = 0;
	local newScratchDefense = 0;
	local newCombatModifier = 0;

	if newItem:IsClothing() then
		newBiteDefense = newItem:getBiteDefense();
		newScratchDefense = newItem:getScratchDefense();
		newCombatModifier = newItem:getCombatSpeedModifier();
	end

	if #replaceItems == 0 and newBiteDefense == 0 and newScratchDefense == 0 and previousBiteDefense == 0 and previousScratchDefense == 0 then
		return nil
	end
	
	local tooltip = ISInventoryPaneContextMenu.addToolTip();
	tooltip.maxLineWidth = 1000

	if #replaceItems > 0 then
		tooltip.description = tooltip.description .. getText("Tooltip_ReplaceWornItems") .. " <LINE> <INDENT:20> ";
		for _,item in ipairs(replaceItems) do
			tooltip.description = tooltip.description .. item:getDisplayName() .. " <LINE> ";
		end
		tooltip.description = tooltip.description .. " <INDENT:0> ";
	end

	local font = ISToolTip.GetFont()

	local labelWidth = 0
	labelWidth = math.max(labelWidth, getTextManager():MeasureStringX(font, getText("Tooltip_BiteDefense") .. ":"));
	labelWidth = math.max(labelWidth, getTextManager():MeasureStringX(font, getText("Tooltip_ScratchDefense") .. ":"));
--	labelWidth = math.max(labelWidth, getTextManager():MeasureStringX(font, getText("Tooltip_CombatSpeed") .. ":"));

	local text;

	-- bite defense
	if newBiteDefense > 0 or previousBiteDefense > 0 then
        local hc = getCore():getGoodHighlitedColor()
		local plus = "+";
		if previousBiteDefense > 0 and previousBiteDefense > newBiteDefense then
            hc = getCore():getBadHighlitedColor()
			plus = "";
		end
		text = string.format(" <RGB:%.2f,%.2f,%.2f> %s: <SETX:%d> %d (%s%d) <LINE> ",
            hc:getR(), hc:getG(), hc:getB(), getText("Tooltip_BiteDefense"), labelWidth + 10,
			newBiteDefense,
			plus,
			newBiteDefense - previousBiteDefense);
		tooltip.description = tooltip.description .. text;
	end
	
	-- scratch defense
	if newScratchDefense > 0 or previousScratchDefense > 0 then
        local hc = getCore():getGoodHighlitedColor()
		local plus = "+";
		if previousScratchDefense > 0 and previousScratchDefense > newScratchDefense then
            hc = getCore():getBadHighlitedColor()
			plus = "";
		end
		text = string.format(" <RGB:%.2f,%.2f,%.2f> %s: <SETX:%d> %d (%s%d) <LINE> ",
            hc:getR(), hc:getG(), hc:getB(), getText("Tooltip_ScratchDefense"), labelWidth + 10,
			newScratchDefense,
			plus,
			newScratchDefense - previousScratchDefense);
		tooltip.description = tooltip.description .. text;
	end

--[[
	-- combat speed -- TODO: Better calcul!
	if previousCombatModifier > 0 and previousCombatModifier > newCombatModifier then
		text = " <RGB:0,1,0> " .. getText("Tooltip_CombatSpeed") .. ": +";
		text = " <RGB:1,0,0> " .. getText("Tooltip_CombatSpeed") .. ": ";
	end
	tooltip.description = tooltip.description ..  text .. newCombatModifier-previousCombatModifier;
--]]

	option.toolTip = tooltip;

	return replaceItems;
end

ISInventoryPaneContextMenu.doWearClothingMenu = function(player, clothing, items, context)
    -- extra submenu generate the "Wear" submenu in doClothingItemExtraMenu
    if clothing:getClothingExtraSubmenu() then
        return
    end
    local playerObj = getSpecificPlayer(player);

    local option = context:addOption(getText("ContextMenu_Wear"), items, ISInventoryPaneContextMenu.onWearItems, player);
    ISInventoryPaneContextMenu.doWearClothingTooltip(playerObj, clothing, clothing, option);
end

ISInventoryPaneContextMenu.doChangeFireModeMenu = function(playerObj, weapon, context)
    local firemodeOption = context:addOption(getText("ContextMenu_ChangeFireMode"))
    local subMenuFiremode = context:getNew(context)
    context:addSubMenu(firemodeOption, subMenuFiremode)
    for i=0, weapon:getFireModePossibilities():size() - 1 do
        local firemode = weapon:getFireModePossibilities():get(i);
        if firemode ~= weapon:getFireMode() then
            subMenuFiremode:addOption(getText("ContextMenu_FireMode_" .. firemode), playerObj, ISInventoryPaneContextMenu.onChangefiremode, weapon, firemode);
        end
    end
end

ISInventoryPaneContextMenu.onChangefiremode = function(playerObj, weapon, newfiremode)
    weapon:setFireMode(newfiremode);
    playerObj:setFireMode(newfiremode)
    --playerObj:setVariable("FireMode", newfiremode);
    if "Burst" == newfiremode then
        weapon:setAmmoPerShoot(3);
    end
end

ISInventoryPaneContextMenu.doReloadMenuForBullets = function(playerObj, bullet, context)
    for i=0, playerObj:getInventory():getItems():size()-1 do
        -- test magazines
        local item = playerObj:getInventory():getItems():get(i);
        if not instanceof(item, "HandWeapon") and item:getAmmoType() == bullet:getFullType() then
            if item:getCurrentAmmoCount() < item:getMaxAmmo() then
                local ammoCount = playerObj:getInventory():getItemCountRecurse(item:getAmmoType())
                if ammoCount > item:getMaxAmmo() then
                    ammoCount = item:getMaxAmmo()
                end
                if ammoCount > item:getMaxAmmo() - item:getCurrentAmmoCount() then
                    ammoCount = item:getMaxAmmo() - item:getCurrentAmmoCount()
                end
                local insertOption = context:addOption(getText("ContextMenu_InsertBulletsInMagazine", ammoCount), playerObj, ISInventoryPaneContextMenu.onLoadBulletsInMagazine, item, ammoCount)
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                tooltip.description =
                        (getText("ContextMenu_Magazine") .. ": " .. getText(item:getDisplayName()) .. "\n"..
                        getText("ContextMenu_GunType") .. ": " .. getText(getItemDisplayName(item:getGunType())) .. "\n" ..
                        getText("Tooltip_weapon_AmmoCount") .. ": " .. item:getCurrentAmmoCount() .. "/" .. item:getMaxAmmo());
                insertOption.toolTip = tooltip;
            end
        elseif instanceof(item, "HandWeapon") and not item:getMagazineType() and item:getAmmoType() == bullet:getFullType() then
            ISInventoryPaneContextMenu.doBulletMenu(playerObj, item, context)
        end
    end
end

ISInventoryPaneContextMenu.doReloadMenuForMagazine = function(playerObj, magazine, context)
    local weapons = playerObj:getInventory():getItemsFromCategory("Weapon");
    for i=1,weapons:size() do
        local weapon = weapons:get(i-1)
        if weapon:getMagazineType() == magazine:getFullType() and not weapon:isContainsClip() then
            local insertOption = context:addOption(getText("ContextMenu_InsertMagazine"), playerObj, ISInventoryPaneContextMenu.onInsertMagazine, weapon, magazine);
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = (getText("ContextMenu_GunType") .. ": " .. getText(weapon:getDisplayName()));
            insertOption.toolTip = tooltip;
        end
    end
end

ISInventoryPaneContextMenu.doBulletMenu = function(playerObj, weapon, context)
    local bulletAvail = playerObj:getInventory():getItemCountRecurse(weapon:getAmmoType());
    local bulletNeeded = weapon:getMaxAmmo() - weapon:getCurrentAmmoCount();
    local bulletName = getScriptManager():FindItem(weapon:getAmmoType()):getDisplayName();
    if bullets == 0 then
        bulletNeeded = 0;
    end
    if bulletNeeded > bulletAvail then
        bulletNeeded = bulletAvail;
    end
    local insertOption = context:addOption(getText("ContextMenu_InsertBullets", bulletNeeded, bulletName, weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onLoadBulletsIntoFirearm, weapon);
    if bulletNeeded <= 0 then
        insertOption.notAvailable = true;
    end

    if weapon:getCurrentAmmoCount() > 0 then
        context:addOption(getText("ContextMenu_UnloadRounds", weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onUnloadBulletsFromFirearm, weapon);
    end
end

ISInventoryPaneContextMenu.doReloadMenuForWeapon = function(playerObj, weapon, context)
    if weapon:getMagazineType() then
        if weapon:isContainsClip() then -- eject current clip
            context:addOption(getText("ContextMenu_EjectMagazine"), playerObj, ISInventoryPaneContextMenu.onEjectMagazine, weapon);
        else -- insert a new clip
            local clip = weapon:getBestMagazine(playerObj);
            local insertOption = context:addOption(getText("ContextMenu_InsertMagazine"), playerObj, ISInventoryPaneContextMenu.onInsertMagazine, weapon, clip);
            if not clip then
                insertOption.notAvailable = true;
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                tooltip.description = getText("ContextMenu_NoMagazineFound", getItemDisplayName(weapon:getMagazineType()));
                insertOption.toolTip = tooltip;
            else
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                tooltip.description = (getText("ContextMenu_Magazine") .. ": " .. getText(clip:getDisplayName()));
                insertOption.toolTip = tooltip
            end
        end
    elseif weapon:getAmmoType() then
        ISInventoryPaneContextMenu.doBulletMenu(playerObj, weapon, context)
    end
    if weapon:isJammed() then -- unjam
        context:addOption(getText("ContextMenu_Unjam", weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onRackGun, weapon);
    elseif ISReloadWeaponAction.canRack(weapon) then
        local text = weapon:haveChamber() and "ContextMenu_Rack" or "ContextMenu_UnloadRoundFrom"
        context:addOption(getText(text, weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onRackGun, weapon);
    end
end

function ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
	if instanceof(item, "InventoryItem") then
		if luautils.haveToBeTransfered(playerObj, item) then
			ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory()))
		end
	elseif instanceof(item, "ArrayList") then
		local items = item
		for i=1,items:size() do
			local item = items:get(i-1)
			if luautils.haveToBeTransfered(playerObj, item) then
				ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory()))
			end
		end
	end
end

ISInventoryPaneContextMenu.onEjectMagazine = function(playerObj, weapon)
    ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISEjectMagazine:new(playerObj, weapon));
end

ISInventoryPaneContextMenu.transferBullets = function(playerObj, ammoType, currentAmmo, maxAmmo)
    local inventory = playerObj:getInventory()
    local ammoCount = inventory:getItemCountRecurse(ammoType)
    ammoCount = math.min(ammoCount, maxAmmo - currentAmmo)
    if ammoCount <= 0 then return 0 end
    local items = inventory:getSomeTypeRecurse(ammoType, ammoCount)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, items)
    return ammoCount
end

ISInventoryPaneContextMenu.onInsertMagazine = function(playerObj, weapon, magazine)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, magazine)
    ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISInsertMagazine:new(playerObj, weapon, magazine));
end

ISInventoryPaneContextMenu.onRackGun = function(playerObj, weapon)
    ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISRackFirearm:new(playerObj, weapon));
end

ISInventoryPaneContextMenu.onLoadBulletsIntoFirearm = function(playerObj, weapon)
    ISInventoryPaneContextMenu.transferBullets(playerObj, weapon:getAmmoType(), weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
    ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISReloadWeaponAction:new(playerObj, weapon));
end

ISInventoryPaneContextMenu.onUnloadBulletsFromFirearm = function(playerObj, weapon)
    ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISUnloadBulletsFromFirearm:new(playerObj, weapon))
end

ISInventoryPaneContextMenu.doMagazineMenu = function(playerObj, magazine, context)
    if magazine:getCurrentAmmoCount() < magazine:getMaxAmmo() then
        local ammoCount = playerObj:getInventory():getItemCountRecurse(magazine:getAmmoType());
        if ammoCount > magazine:getMaxAmmo() then
            ammoCount = magazine:getMaxAmmo();
        end
        if ammoCount > magazine:getMaxAmmo() - magazine:getCurrentAmmoCount() then
            ammoCount = magazine:getMaxAmmo() - magazine:getCurrentAmmoCount();
        end
        if ammoCount == 0 then
            local option = context:addOption(getText("ContextMenu_NoBullets", ammoCount));
            option.notAvailable = true;
        else
            context:addOption(getText("ContextMenu_InsertBulletsInMagazine", ammoCount), playerObj, ISInventoryPaneContextMenu.onLoadBulletsInMagazine, magazine, ammoCount);
        end
    end
    
    if magazine:getCurrentAmmoCount() > 0 then
        context:addOption(getText("ContextMenu_UnloadMagazine"), playerObj, ISInventoryPaneContextMenu.onUnloadBulletsFromMagazine, magazine);
    end
end

ISInventoryPaneContextMenu.onLoadBulletsInMagazine = function(playerObj, magazine, ammoCount)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, magazine)
    local items = playerObj:getInventory():getSomeTypeRecurse(magazine:getAmmoType(), ammoCount)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, items)
    if ammoCount > 0 then
        ISTimedActionQueue.add(ISLoadBulletsInMagazine:new(playerObj, magazine, ammoCount))
    end
end

ISInventoryPaneContextMenu.onUnloadBulletsFromMagazine = function(playerObj, magazine)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, magazine)
    ISTimedActionQueue.add(ISUnloadBulletsFromMagazine:new(playerObj, magazine))
end

ISInventoryPaneContextMenu.getEvoItemCategories = function(items, evorecipe)
    local catList = {};
    for i=0,items:size() -1 do
        local evoItem = items:get(i);
        if instanceof(evoItem, "Food") then
			local foodType = evoItem:getFoodType();
			if foodType and evorecipe:needToBeCooked(evoItem) then
				if not catList[foodType] then catList[foodType] = {}; end
				table.insert(catList[foodType], evoItem);
			end
		end
    end
    return catList;
end

ISInventoryPaneContextMenu.onPlaceCarBatteryCharger = function(playerObj, carBatteryCharger)
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, carBatteryCharger)
	ISTimedActionQueue.add(ISPlaceCarBatteryChargerAction:new(playerObj, carBatteryCharger))
end

ISInventoryPaneContextMenu.addItemInEvoRecipe = function(subMenuRecipe, baseItem, evoItem, extraInfo, evorecipe2, player)
    local txt = getText("ContextMenu_From_Ingredient", evoItem:getName(), extraInfo);
    if evorecipe2:isResultItem(baseItem) then
        txt = getText("ContextMenu_Add_Ingredient", evoItem:getName(), extraInfo);
    end
    txt = string.trim(txt)
    local option = subMenuRecipe:addOption(txt, evorecipe2, ISInventoryPaneContextMenu.onAddItemInEvoRecipe, baseItem, evoItem, player);
    local tooltip = ISInventoryPaneContextMenu.addToolTip();
    if instanceof(evoItem,"Food") and evoItem:getFreezingTime() > 0 and (not evorecipe2:isAllowFrozenItem()) then
        option.notAvailable = true;
        tooltip.description = getText("ContextMenu_CantAddFrozenFood");
        option.toolTip = tooltip;
    end
    if not evorecipe2:needToBeCooked(evoItem) then
        option.notAvailable = true;
        tooltip.description = tooltip.description .. getText("ContextMenu_NeedCooked");
        option.toolTip = tooltip;
    end
end

local function formatFoodValue(f)
	return string.format("%+.2f", f)
end

ISInventoryPaneContextMenu.addEatTooltip = function(option, items, percent)
	local item = items[1]

	-- Figure out the fraction of the *remaining amount* that is used.
	-- If we already ate 1/4, and are eating 1/4 this time, then percentage=0.33.
	-- If we already ate 1/2 and are eating 1/2 this time, then percentage=1.0.
	if (item:getBaseHunger() ~= 0.0) and (item:getHungChange() ~= 0.0) then
		local hungChange = item:getBaseHunger() * percent
		local usedPercent = hungChange / item:getHungChange()
		percent = PZMath.clamp_01(usedPercent)
	end

	local texts = {}
	if item:getHungerChange() ~= 0.0 then
		table.insert(texts, getText("Tooltip_food_Hunger"))
		table.insert(texts, (-1 * math.floor(-1 * formatFoodValue(item:getHungerChange() * 100.0 * percent))))
		table.insert(texts, true)
	end
	if item:getThirstChange() ~= 0.0 then
		table.insert(texts, getText("Tooltip_food_Thirst"))
		table.insert(texts, formatFoodValue(item:getThirstChange() * 100.0 * percent))
		table.insert(texts, item:getThirstChange() < 0)
	end
	if item:getUnhappyChange() ~= 0.0 then
		table.insert(texts, getText("Tooltip_food_Unhappiness"))
		table.insert(texts, formatFoodValue(item:getUnhappyChange() * percent))
		table.insert(texts, item:getUnhappyChange() < 0)
	end

	local notes = {}
	if item:isbDangerousUncooked() and not item:isCooked() and not item:isBurnt() then
		table.insert(notes, getText("Tooltip_food_Dangerous_uncooked"))
		table.insert(notes, false)
	end
	if (item:isGoodHot() or item:isBadCold()) and (item:getHeat() < 1.3) then
		table.insert(notes, getText("Tooltip_food_BetterHot"))
		table.insert(notes, true)
	end
	if item:isCookedInMicrowave() then
		table.insert(notes, getText("Tooltip_food_CookedInMicrowave"))
		table.insert(notes, true)
	end

	if #texts == 0 and #notes == 0 then return end
	local font = ISToolTip.GetFont()
	local maxLabelWidth = 0
	for i=1,#texts,3 do
		local label = texts[(i-1)+1]
		maxLabelWidth = math.max(maxLabelWidth, getTextManager():MeasureStringX(font, label))
	end
	local tooltip = ISInventoryPaneContextMenu.addToolTip();
	for i=1,#texts,3 do
		local label = texts[(i-1)+1]
		local value = texts[(i-1)+2]
		local good = texts[(i-1)+3]
		tooltip.description = string.format("%s <RGB:1,1,1> %s: <SETX:%d> <%s> %s <LINE> ", tooltip.description, label, maxLabelWidth + 10, good and "GREEN" or "RED", value)
	end
	for i=1,#notes,2 do
		local label = notes[(i-1)+1]
		local good = notes[(i-1)+2]
		tooltip.description = string.format("%s <%s> %s <LINE> ", tooltip.description, good and "RGB:1,1,1" or "RED", label)
	end
	option.toolTip = tooltip;
end

ISInventoryPaneContextMenu.doEatOption = function(context, cmd, items, player, playerObj, foodItems)
    local eatOption = context:addOption(cmd, items, ISInventoryPaneContextMenu.onEatItems, 1, player)
    if foodItems[1] and foodItems[1]:getRequireInHandOrInventory() then
        local list = foodItems[1]:getRequireInHandOrInventory();
        local found = false;
        local required = "";
        if foodItems[1]:hasTag("Smokable") and playerObj:getVehicle() and playerObj:getVehicle():canLightSmoke(playerObj) then found = true end
        if foodItems[1]:hasTag("Smokable") and not found then
           found = ISInventoryPaneContextMenu.hasOpenFlame(playerObj)
        end
        if not found then
            for i=0,list:size()-1 do
                local fullType = moduleDotType(foodItems[1]:getModule(), list:get(i))
                if playerObj:getInventory():getFirstTypeEvalRecurse(fullType, predicateNotEmpty) then
                    found = true;
                    break;
                end
                required = required .. getItemNameFromFullType(fullType);
                if i < list:size()-1 then
                    required = required .. "/";
                end
            end
        end
        if not found then
            eatOption.notAvailable = true
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_Require", required);
            eatOption.toolTip = tooltip;
        end
    end
end

ISInventoryPaneContextMenu.checkConsolidate = function(drainable, playerObj, context, previousPourInto)
    -- Check if we could consolidate drainable
    local consolidateList = {};
    if drainable and drainable:canConsolidate() then
        local otherDrainables = playerObj:getInventory():getItemsFromType(drainable:getType());
        for i=0,otherDrainables:size() - 1 do
            local otherDrain = otherDrainables:get(i);
            if otherDrain ~= drainable and otherDrain:getCurrentUsesFloat() < 1 then
				local addIt = true;
				for i,v in ipairs(previousPourInto) do
					if v == otherDrain then
						addIt = false;
						break;
					end
				end
				if addIt then
                	table.insert(consolidateList, otherDrain);
				end
            end
        end
    end

    if #consolidateList > 0 then
        local optionName = getText("ContextMenu_Pour_into");
        if drainable:getConsolidateOption() then
            optionName = getText(drainable:getConsolidateOption());
        end
        local consolidateOption = context:addOption(optionName, nil, nil)
        local subMenuConsolidate = context:getNew(context)
        context:addSubMenu(consolidateOption, subMenuConsolidate)
        if #consolidateList > 1 then
            subMenuConsolidate:addOption(getText("ContextMenu_MergeAll"), drainable, ISInventoryPaneContextMenu.onConsolidateAll, consolidateList, playerObj)
        end
        for _,intoItem in ipairs(consolidateList) do
            subMenuConsolidate:addOption(intoItem:getName() .. " (" .. math.floor(intoItem:getCurrentUsesFloat() * 100) .. getText("ContextMenu_FullPercent") .. ")", drainable, ISInventoryPaneContextMenu.onConsolidate, intoItem, playerObj)
        end
    end
end

ISInventoryPaneContextMenu.onConsolidate = function(drainable, intoItem, playerObj)
    ISTimedActionQueue.add(ISConsolidateDrainable:new(playerObj, drainable, intoItem, nil));
end

ISInventoryPaneContextMenu.onConsolidateAll = function(drainable, consolidateList, playerObj)
	if drainable:getCurrentUsesFloat() < 1 then
		local intoItem = table.remove(consolidateList, 1)
		ISTimedActionQueue.add(ISConsolidateDrainable:new(playerObj, drainable, intoItem, consolidateList))
	else
		drainable = table.remove(consolidateList, 1)
		local intoItem = table.remove(consolidateList, 1)
		ISTimedActionQueue.add(ISConsolidateDrainable:new(playerObj, drainable, intoItem, consolidateList))
	end
end

ISInventoryPaneContextMenu.OnTriggerRemoteController = function(remoteController, player)
    local playerObj = getSpecificPlayer(player);
    local args = { id=remoteController:getRemoteControlID(), range=remoteController:getRemoteRange() }
    sendClientCommand(playerObj, 'object', 'triggerRemote', args)
--[[
    if isClient() then
        local args = { id=remoteController:getRemoteControlID(), range=remoteController:getRemoteRange() }
        sendClientCommand(playerObj, 'object', 'triggerRemote', args)
    else
        IsoTrap.triggerRemote(playerObj, remoteController:getRemoteControlID(), remoteController:getRemoteRange())
    end
--]]
end

ISInventoryPaneContextMenu.OnLinkRemoteController = function(itemToLink, remoteController, player)
    local playerObj = getSpecificPlayer(player)
    if remoteController:getRemoteControlID() == -1 then
        remoteController:setRemoteControlID(ZombRand(100000));
        remoteController:syncItemFields();
    end
    itemToLink:setRemoteControlID(remoteController:getRemoteControlID());
    itemToLink:syncItemFields();
    ISInventoryPage.dirtyUI();
end

ISInventoryPaneContextMenu.isAllFav = function (items)
    items = ISInventoryPane.getActualItems(items)
    for i,k in ipairs(items) do
        if not k:isFavorite() then
            return false
        end
    end
    return true
end

function ISInventoryPaneContextMenu.isAnyAllowed(container, items)
    items = ISInventoryPane.getActualItems(items)
    for i,k in ipairs(items) do
        if container:isItemAllowed(k) then
            return true
        end
    end
    return false
end

function ISInventoryPaneContextMenu.isAllNoDropMoveable(items)
    items = ISInventoryPane.getActualItems(items)
    for _,item in ipairs(items) do
        if not instanceof(item, "Moveable") or item:CanBeDroppedOnFloor() then
            return false
        end
    end
    return true
end

ISInventoryPaneContextMenu.OnResetRemoteControlID = function(item, player)
    local playerObj = getSpecificPlayer(player)
    item:setRemoteControlID(-1)
    item:syncItemFields();
end

ISInventoryPaneContextMenu.onDrinkFluid = function(item, percent, playerObj)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
	ISTimedActionQueue.add(ISDrinkFluidAction:new(playerObj, item, percent))
end

ISInventoryPaneContextMenu.doDrinkFluidMenu = function(playerObj, fluidContainer, context)
    local cmd = fluidContainer:getCustomMenuOption() or getText("ContextMenu_Drink");
    local eatOption = context:addOption(cmd, fluidContainer, nil);
	
	if not fluidContainer:getFluidContainer():canPlayerEmpty() then
		local tooltip = ISInventoryPaneContextMenu.addToolTip();
		eatOption.notAvailable = true;
		tooltip.description = getText("Tooltip_item_sealed");
		eatOption.toolTip = tooltip;	
	elseif playerObj:getMoodles():getMoodleLevel(MoodleType.FoodEaten) >= 3 and playerObj:getNutrition():getCalories() >= 1000 then
		local tooltip = ISInventoryPaneContextMenu.addToolTip();
		eatOption.notAvailable = true;
		tooltip.description = getText("Tooltip_CantEatMore");
		eatOption.toolTip = tooltip;
	elseif fluidContainer:getFluidContainer():getCapacity() > 3.0 then
		local tooltip = ISInventoryPaneContextMenu.addToolTip();
		eatOption.notAvailable = true;
		tooltip.description = getText("Tooltip_CantDrinkFrom");
		eatOption.toolTip = tooltip;
	else
		local subMenuEat = context:getNew(context)
		context:addSubMenu(eatOption, subMenuEat)
		local option = subMenuEat:addOption(getText("ContextMenu_Eat_All"), fluidContainer, ISInventoryPaneContextMenu.onDrinkFluid, 1, playerObj)
		

		local baseThirst = (math.abs(( fluidContainer:getFluidContainer():getProperties():getThirstChange() * 100 ) ));
					--print("Base tHIRST" .. tostring(baseThirst))
		if (baseThirst >= 2 ) then
						--print(tostring(baseHunger >= 2))
						--print(tostring(hungerChange >= baseHunger/2))
			option = subMenuEat:addOption(getText("ContextMenu_Eat_Half"), fluidContainer, ISInventoryPaneContextMenu.onDrinkFluid, 0.5, playerObj)
						-- ISInventoryPaneContextMenu.addEatTooltip(option, foodItems, 0.5) -- commented out as the information provided can be confusing
		end
		if (baseThirst >= 4) then
						--print(tostring(baseHunger >= 4))
						--print(tostring(hungerChange >= baseHunger/4))
			option = subMenuEat:addOption(getText("ContextMenu_Eat_Quarter"), fluidContainer, ISInventoryPaneContextMenu.onDrinkFluid, 0.25, playerObj)
						-- ISInventoryPaneContextMenu.addEatTooltip(option, foodItems, 0.25) -- commented out as the information provided can be confusing
		end
	end
end

ISInventoryPaneContextMenu.doDrinkForThirstMenu = function(context, playerObj, waterContainer)
    local thirst = playerObj:getStats():getThirst()
    local units = math.min(math.ceil(thirst / 0.1), 10)
	local uses = 1;
	local delta = 10.0;
	if waterContainer:getFluidContainer() then
		uses = waterContainer:getFluidContainer():getAmount() / 0.12;
		delta = waterContainer:getFluidContainer():getAmount();
	end
    units = math.min(units, uses)
    local option = context:addOption(getText("ContextMenu_Drink"), waterContainer, ISInventoryPaneContextMenu.onDrinkForThirst, playerObj, units)
    local tooltip = ISInventoryPaneContextMenu.addToolTip()
    local tx1 = getTextManager():MeasureStringX(tooltip.font, getText("Tooltip_food_Thirst") .. ":") + 20
    local tx2 = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
    local tx = math.max(tx1, tx2)
    tooltip.description = string.format("%s: <SETX:%d> -%d / %d <LINE> %s: <SETX:%d> %d / %d",
        getText("Tooltip_food_Thirst"), tx, math.min(units * 10, thirst * 100), thirst * 100,
        getText("ContextMenu_WaterName"), tx, uses, 1.0 / delta)
    if waterContainer:getFluidContainer():contains(Fluid.TaintedWater) and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
        tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
    end
    option.toolTip = tooltip
end

ISInventoryPaneContextMenu.onDrinkForThirst = function(waterContainer, playerObj, units)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, waterContainer)
	-- now remove a mask
	local mask = ISInventoryPaneContextMenu.getEatingMask(playerObj, true)
    ISTimedActionQueue.add(ISDrinkFromBottle:new(playerObj, waterContainer, units))
    if mask then ISTimedActionQueue.add(ISWearClothing:new(playerObj, mask, 50)) end
end

ISInventoryPaneContextMenu.onDrink = function(items, waterContainer, percentage, player)
	local playerObj = getSpecificPlayer(player)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, waterContainer)
	-- now remove a mask
	local mask = ISInventoryPaneContextMenu.getEatingMask(playerObj, true)
-- how much use we have in the bottle
    local useLeft = waterContainer:getCurrentUses();
--     local useLeft = waterContainer:getCurrentUsesFloat() / waterContainer:getUseDelta();
    ISTimedActionQueue.add(ISDrinkFromBottle:new(getSpecificPlayer(player), waterContainer, useLeft * percentage));
    if mask then ISTimedActionQueue.add(ISWearClothing:new(playerObj, mask, 50)) end
end

ISInventoryPaneContextMenu.onAddItemInEvoRecipe = function(recipe, baseItem, usedItem, player)
    local playerObj = getSpecificPlayer(player);
    local returnToContainer = {};
    if not playerObj:getInventory():contains(usedItem) then -- take the item if it's not in our inventory
        ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, usedItem,usedItem:getContainer(), playerObj:getInventory(), nil));
        table.insert(returnToContainer, usedItem);
    end
    if not playerObj:getInventory():contains(baseItem) then -- take the base item if it's not in our inventory
        ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, baseItem, baseItem:getContainer(), playerObj:getInventory(), nil));
        table.insert(returnToContainer, baseItem);
    end
    ISTimedActionQueue.add(ISAddItemInRecipe:new(playerObj, recipe, baseItem, usedItem));
    ISCraftingUI.ReturnItemsToOriginalContainer(playerObj, returnToContainer)
end

ISInventoryPaneContextMenu.buildFixingMenu = function(brokenObject, player, fixing, fixingNum, fixOption, subMenuFix, vehiclePart)
    local tooltip = ISInventoryPaneContextMenu.addToolTip();
    tooltip.description = "";
--    fixOption.toolTip = tooltip;
    tooltip.texture = brokenObject:getTex();
    tooltip:setName(brokenObject:getName());
    -- fetch all the fixer item to build the sub menu and tooltip
    for i=0,fixing:getFixers():size()-1 do
        local fixer = fixing:getFixers():get(i);
        -- if you have this item in your main inventory
        local fixerItem = fixing:haveThisFixer(getSpecificPlayer(player), fixer, brokenObject);
        -- now test the required skill if needed
        local skillDescription = " ";
        if fixer:getFixerSkills() then
            for j=0,fixer:getFixerSkills():size()-1 do
                skillDescription = skillDescription .. PerkFactory.getPerk(Perks.FromString(fixer:getFixerSkills():get(j):getSkillName())):getName() .. "=" .. fixer:getFixerSkills():get(j):getSkillLevel() .. ",";
            end
        end
        local subOption = ISInventoryPaneContextMenu.addFixerSubOption(brokenObject, player, fixing, fixingNum, fixer, i, subMenuFix, vehiclePart);
        local add = "";
    
        if fixer:getNumberOfUse() > 1 then
            add = "="..fixer:getNumberOfUse();
        end
        if fixerItem then
            tooltip.description = tooltip.description .. " <LINE>" .. ISInventoryPaneContextMenu.ghs .. fixerItem:getName() .. add .. skillDescription;
        else
            tooltip.description = tooltip.description .. " <LINE>" .. ISInventoryPaneContextMenu.bhs .. fixer:getFixerName() .. add .. skillDescription;
            subOption.notAvailable = true
        end
    end
end

ISInventoryPaneContextMenu.getContainers = function(character)
    if not character then return end
    local playerNum = character and character:getPlayerNum() or -1;
    -- get all the surrounding inventory of the player, gonna check for the item in them too
    local containerList = ArrayList.new();
    for i,v in ipairs(getPlayerInventory(playerNum).inventoryPane.inventoryPage.backpacks) do
        containerList:add(v.inventory);
    end
    for i,v in ipairs(getPlayerLoot(playerNum).inventoryPane.inventoryPage.backpacks) do
        local parent = v.inventory:getParent()
        if instanceof(object, "IsoThumpable") and object:isLockedToCharacter(playerObj) then
            return
        end
        if parent and instanceof(parent, "IsoThumpable") then
            if not parent:isLockedToCharacter(character) then
                containerList:add(v.inventory);
            end
        else
            containerList:add(v.inventory);
        end
    end
    return containerList;
end

ISInventoryPaneContextMenu.addFixerSubOption = function(brokenObject, player, fixing, fixingNum, fixer, fixerNum, subMenuFix, vehiclePart)
    local usedItemType = fixing:getModule():getName() .. "." .. fixer:getFixerName();
    local fixOption = null;
    local tooltip = ISInventoryPaneContextMenu.addToolTip();
    local itemName
    local itemTex = getItemTex(usedItemType)
    if itemTex then
        tooltip.texture = itemTex;
        itemName = getItemNameFromFullType(usedItemType)
        fixOption = subMenuFix:addOption(fixer:getNumberOfUse() .. " " .. itemName, brokenObject, ISInventoryPaneContextMenu.onFix, player, fixingNum, fixerNum, vehiclePart);
    else
        fixOption = subMenuFix:addOption(fixer:getNumberOfUse() .. " " .. fixer:getFixerName(), brokenObject, ISInventoryPaneContextMenu.onFix, player, fixingNum, fixerNum, vehiclePart);
        itemName = fixer:getFixerName()
    end
	tooltip:setName(itemName);
    local condPercentRepaired = FixingManager.getCondRepaired(brokenObject, getSpecificPlayer(player), fixing, fixer);
    local chanceOfSuccess = 100 - FixingManager.getChanceOfFail(brokenObject, getSpecificPlayer(player), fixing, fixer);
    local repairedCol = ColorInfo.new(0, 0, 0, 1)
    local successCol = ColorInfo.new(0, 0, 0, 1)
    getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), condPercentRepaired/100, repairedCol);
    getCore():getBadHighlitedColor():interp(getCore():getGoodHighlitedColor(), chanceOfSuccess/100, successCol);
    local color1 = "<RGB:".. repairedCol:getR() ..",".. repairedCol:getG() ..",".. repairedCol:getB()..">";
    local color2 = "<RGB:".. successCol:getR() ..",".. successCol:getG() ..",".. successCol:getB()..">";

    tooltip.description = " " .. color1 .. " " .. getText("Tooltip_potentialRepair") .. " " .. math.ceil(condPercentRepaired) .. "%";
    tooltip.description = tooltip.description .. " <LINE> " .. color2 .. " " .. getText("Tooltip_chanceSuccess") .. " " .. math.ceil(chanceOfSuccess) .. "%";
	tooltip.description = tooltip.description .. " <LINE> <LINE> <RGB:1,1,1> " .. getText("Tooltip_craft_Needs") .. ": <LINE> "
    -- do you have the global item
    local add = "";
    if fixing:getGlobalItem() then
        local globalItem = fixing:haveGlobalItem(getSpecificPlayer(player));
        local uses = fixing:countUses(getSpecificPlayer(player), fixing:getGlobalItem(), nil)
        if globalItem then
            tooltip.description = tooltip.description .. " <LINE>" .. ISInventoryPaneContextMenu.ghs .. globalItem:getName() .. " " .. uses .. "/" .. fixing:getGlobalItem():getNumberOfUse() .. " <LINE> ";
        else
            local name = fixing:getGlobalItem():getFixerName();
            if getItem(fixing:getModule():getName() .. "." .. fixing:getGlobalItem():getFixerName()) then
                name = getItemName(fixing:getModule():getName() .. "." .. fixing:getGlobalItem():getFixerName());
            end
            tooltip.description = tooltip.description .. " <LINE>" .. ISInventoryPaneContextMenu.bhs .. name .. " " .. uses .. "/" .. fixing:getGlobalItem():getNumberOfUse() .. " <LINE> ";
            fixOption.notAvailable = true
        end
    end
	local uses = fixing:countUses(getSpecificPlayer(player), fixer, brokenObject)
    if uses >= fixer:getNumberOfUse() then color1 = ISInventoryPaneContextMenu.ghs else color1 = ISInventoryPaneContextMenu.bhs end
	tooltip.description = tooltip.description .. color1 .. itemName .. " " .. uses .. "/" .. fixer:getNumberOfUse()
	if fixer:getFixerSkills() then
		local skills = fixer:getFixerSkills()
		for j=0,skills:size()-1 do
			local skill = skills:get(j)
			local perk = Perks.FromString(skill:getSkillName())
			local perkLvl = getSpecificPlayer(player):getPerkLevel(perk)
			if perkLvl >= skill:getSkillLevel() then
                color1 = ISInventoryPaneContextMenu.ghs
            else
                color1 = ISInventoryPaneContextMenu.bhs
                fixOption.notAvailable = true
            end
			tooltip.description = tooltip.description .. " <LINE> " .. color1 .. PerkFactory.getPerk(perk):getName() .. " " .. perkLvl .. "/" .. skill:getSkillLevel()
		end
	end

    fixOption.toolTip = tooltip;
    return fixOption
end

ISInventoryPaneContextMenu.onFix = function(brokenObject, player, fixingNum, fixerNum, vehiclePart)
    local playerObj = getSpecificPlayer(player);
    local playerInv = playerObj:getInventory();

    if not vehiclePart then
        ISInventoryPaneContextMenu.transferIfNeeded(playerObj, brokenObject);
    end
    local fixing = FixingManager.getFixes(brokenObject):get(fixingNum);
    local fixer = fixing:getFixers():get(fixerNum)
    local items = fixing:getRequiredItems(playerObj, fixer, brokenObject);
    if not items then return end;
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, items);
    if vehiclePart then
        ISTimedActionQueue.add(ISFixVehiclePartAction:new(playerObj, vehiclePart, fixingNum, fixerNum));
    else
        ISTimedActionQueue.add(ISFixAction:new(playerObj, brokenObject, fixingNum, fixerNum));
    end
end

ISInventoryPaneContextMenu.onDyeHair = function(hairDye, playerObj, beard)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, hairDye)
	if playerObj:getWornItem("FullHat") then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem("FullHat"), 50));
	end
	if playerObj:getWornItem("Hat") and not beard then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem("Hat"), 50));
	end
	if beard and playerObj:getWornItem("Mask") then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem("Mask"), 50));	
	end
	if beard and playerObj:getWornItem("MaskEyes") then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem("MaskEyes"), 50));	
	end
	if beard and playerObj:getWornItem("MaskFull") then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem("MaskFull"), 50));	
	end
    ISTimedActionQueue.add(ISDyeHair:new(playerObj, hairDye, beard));
end

ISInventoryPaneContextMenu.onDryMyself = function(towels, player)
    towels = ISInventoryPane.getActualItems(towels)
    for i,k in ipairs(towels) do
        ISInventoryPaneContextMenu.dryMyself(k, player)
        break
    end
end

ISInventoryPaneContextMenu.onWringClothing = function(items, player)
	local playerObj = getSpecificPlayer(player)
    items = ISInventoryPane.getActualItems(items)
    for _, item in ipairs(items) do repeat
        if not instanceof(item, "Clothing") then break end
        ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
        if playerObj:isEquipped(item) then
            ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 50))
        end
        ISTimedActionQueue.add(ISWringClothing:new(playerObj, item))
    until true end
end

ISInventoryPaneContextMenu.onSetBombTimer = function(trap, player)
    local text = getText("IGUI_TimerSecondsBeforeExplosion");
    if trap:getSensorRange() > 0 then
        text = getText("IGUI_TimerSecondsBeforeActivation");
    end
    local modal = ISBombTimerDialog:new(0, 0, 280, 180, text, trap:getExplosionTimer(), getSpecificPlayer(player), nil, ISInventoryPaneContextMenu.onSetBombTimerClick, getSpecificPlayer(player), trap);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[player+1] then
        modal.prevFocus = JoypadState.players[player+1].focus
        JoypadState.players[player+1].focus = modal;
    end
end

function ISInventoryPaneContextMenu:onSetBombTimerClick(button, player, item)
    if button.internal == "OK" then
        local seconds = button.parent:getTime()
        if seconds > 0 then
            item:setExplosionTimer(seconds)
            if isClient() then
                sendClientCommand(player, "object", "setBombTimer", { itemID = item:getID(), time = seconds })
            end
        end
    end
end

ISInventoryPaneContextMenu.onStopAlarm = function(alarm, player)
    local playerObj = getSpecificPlayer(player);
    local sq = alarm:getAlarmSquare()
	if playerObj == nil or sq == nil then
		alarm:stopRinging()
		return
	end
    if alarm:isInPlayerInventory() or luautils.walkAdj(playerObj, sq) then
        if not alarm:getWorldItem() and (alarm:getContainer() ~= playerObj:getInventory()) then
            ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, alarm, alarm:getContainer(), playerObj:getInventory()))
        end
        if (alarm:getWorldItem()) then
            ISTimedActionQueue.add(ISStopAlarmClockAction:new(playerObj, alarm:getWorldItem()));
        else
            ISTimedActionQueue.add(ISStopAlarmClockAction:new(playerObj, alarm));
        end
    end
end

ISInventoryPaneContextMenu.onSetAlarm = function(alarm, player)
    local playerObj = getSpecificPlayer(player);
    if not alarm:getWorldItem() and (alarm:getContainer() ~= playerObj:getInventory()) then
        local action = ISInventoryTransferAction:new(playerObj, alarm, alarm:getContainer(), playerObj:getInventory())
        action:setOnComplete(ISInventoryPaneContextMenu.onSetAlarm, alarm, player)
        ISTimedActionQueue.add(action)
        return
    end
    local modal = ISAlarmClockDialog:new(0, 0, 230, 160, player, alarm);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[player+1] then
        modal.prevFocus = getPlayerInventory(player)
        setJoypadFocus(player, modal)
    end
end

ISInventoryPaneContextMenu.onRenameMap = function(map, player)
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_NameThisBag"), map:getName(), nil, ISInventoryPaneContextMenu.onRenameBagClick, player, getSpecificPlayer(player), map);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
end

ISInventoryPaneContextMenu.onRenameBag = function(bag, player)
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_NameThisBag"), bag:getName(), nil, ISInventoryPaneContextMenu.onRenameBagClick, player, getSpecificPlayer(player), bag);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
end

ISInventoryPaneContextMenu.onRenameFood = function(food, player)
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_RenameFood") .. food:getName(), food:getDisplayName(), nil, ISInventoryPaneContextMenu.onRenameFoodClick, player, getSpecificPlayer(player), food);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
end

ISInventoryPaneContextMenu.onCheckMap = function(map, player)
    local playerObj = getSpecificPlayer(player)
    if luautils.haveToBeTransfered(playerObj, map) then
        local action = ISInventoryTransferAction:new(playerObj, map, map:getContainer(), playerObj:getInventory())
        action:setOnComplete(ISInventoryPaneContextMenu.onCheckMap, map, player)
        ISTimedActionQueue.add(action)
        return
    end

    if JoypadState.players[player+1] then
        local inv = getPlayerInventory(player)
        local loot = getPlayerLoot(player)
        inv:setVisible(false)
        loot:setVisible(false)
    end

    local titleBarHgt = ISCollapsableWindow.TitleBarHeight()
    local x = getPlayerScreenLeft(player) + 20
    local y = getPlayerScreenTop(player) + 20
    local width = getPlayerScreenWidth(player) - 20 * 2
    local height = getPlayerScreenHeight(player) - 20 * 2 - titleBarHgt

    local mapUI = ISMap:new(x, y, width, height, map, player);
    mapUI:initialise();
    local wrap = mapUI:wrapInCollapsableWindow(map:getName(), false, ISMapWrapper);
    wrap:setInfo(getText("IGUI_Map_Info"));
    wrap:setWantKeyEvents(true);
    mapUI.wrap = wrap;
    wrap.mapUI = mapUI;
--    mapUI.render = ISMap.noRender;
--    mapUI.prerender = ISMap.noRender;
    map:doBuildingStash();
    wrap:setVisible(true);
    wrap:addToUIManager();
	if JoypadState.players[player+1] then
        setJoypadFocus(player, mapUI)
    end
end

ISInventoryPaneContextMenu.onWriteSomething = function(notebook, editable, player)
    local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
    local height = 110 + (15 * fontHgt);
    local modal = ISUIWriteJournal:new(0, 0, 350, height, nil, ISInventoryPaneContextMenu.onWriteSomethingClick, getSpecificPlayer(player), notebook, notebook:seePage(1), notebook:getName(), 15, editable, notebook:getPageToWrite());
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
    local action = ISWriteSomething:new(getSpecificPlayer(player), notebook)
    action.modal = modal
    ISTimedActionQueue.add(action)
end

function ISInventoryPaneContextMenu:onWriteSomethingClick(button)
    if button.internal == "OK" then
        for i,v in ipairs(button.parent.newPage) do
            button.parent.notebook:addPage(i,v);
        end
        button.parent.notebook:setName(button.parent.title:getText());
        button.parent.notebook:setCustomName(true);
    end
    ISTimedActionQueue.clear(getPlayer())
end

function ISInventoryPaneContextMenu:onRenameFoodClick(button, player, item)
    local playerNum = player:getPlayerNum()
    if button.internal == "OK" then
		local length = button.parent.entry:getInternalText():len()
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
			if length <= MAXIMUM_RENAME_LENGTH then 
				item:setName(button.parent.entry:getText());				
				item:setCustomName(true);
				local pdata = getPlayerData(playerNum);
				pdata.playerInventory:refreshBackpacks();
				pdata.lootInventory:refreshBackpacks();
			else
				-- player:Say(getText("IGUI_PlayerText_ItemNameTooLong", MAXIMUM_RENAME_LENGTH));
				HaloTextHelper.addBadText(player, getText("IGUI_PlayerText_ItemNameTooLong", MAXIMUM_RENAME_LENGTH));
-- 				HaloTextHelper.addText(player, getText("IGUI_PlayerText_ItemNameTooLong", MAXIMUM_RENAME_LENGTH), getCore():getGoodHighlitedColor());
			end
        end
    end
    if JoypadState.players[playerNum+1] then
        setJoypadFocus(playerNum, getPlayerInventory(playerNum))
    end
end

function ISInventoryPaneContextMenu:onRenameBagClick(button, player, item)
    local playerNum = player:getPlayerNum()
    if button.internal == "OK" then
		local length = button.parent.entry:getInternalText():len()
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
			if length <= MAXIMUM_RENAME_LENGTH then 
				item:setName(button.parent.entry:getText());
				local pdata = getPlayerData(playerNum);
				pdata.playerInventory:refreshBackpacks();
				pdata.lootInventory:refreshBackpacks();
			else
				-- player:Say(getText("IGUI_PlayerText_ItemNameTooLong", MAXIMUM_RENAME_LENGTH));
				HaloTextHelper.addBadText(player, getText("IGUI_PlayerText_ItemNameTooLong", MAXIMUM_RENAME_LENGTH));
-- 				HaloTextHelper.addText(player, getText("IGUI_PlayerText_ItemNameTooLong", MAXIMUM_RENAME_LENGTH), getCore():getGoodHighlitedColor());
			end
        end
    end
    if JoypadState.players[playerNum+1] then
        setJoypadFocus(playerNum, getPlayerInventory(playerNum))
    end
end

ISInventoryPaneContextMenu.dryMyself = function(item, player)
	-- if towel isn't in main inventory, put it there first.
	local playerObj = getSpecificPlayer(player)
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
	-- dry yourself
	-- how many use left on the towel
	ISTimedActionQueue.add(ISDryMyself:new(playerObj, item));
end

ISInventoryPaneContextMenu.onApplyBandage = function(bandages, bodyPart, player)
	bandages = ISInventoryPane.getActualItems(bandages)
	for i,k in ipairs(bandages) do
		ISInventoryPaneContextMenu.applyBandage(k, bodyPart, player)
		break
	end
end

-- apply a bandage on a body part, loot it first if it's not in the player's inventory
ISInventoryPaneContextMenu.applyBandage = function(item, bodyPart, player)
	-- if bandage isn't in main inventory, put it there first.
	local playerObj = getSpecificPlayer(player)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
	-- apply bandage
	ISTimedActionQueue.add(ISApplyBandage:new(playerObj, playerObj, item, bodyPart, true));
end

-- look for any damaged body part on the player
ISInventoryPaneContextMenu.haveDamagePart = function(playerId)
	local result = {};
	local bodyParts = getSpecificPlayer(playerId):getBodyDamage():getBodyParts();
	-- fetch all the body part
	for i=0,BodyPartType.ToIndex(BodyPartType.MAX) - 1 do
		local bodyPart = bodyParts:get(i);
		-- if it's damaged
		if bodyPart:scratched() or bodyPart:deepWounded() or bodyPart:bitten() or bodyPart:stitched() or bodyPart:bleeding() or bodyPart:isBurnt() and not bodyPart:bandaged() then
			table.insert(result, bodyPart);
		end
	end
	return result;
end

ISInventoryPaneContextMenu.onLiteratureItems = function(items, player)
	items = ISInventoryPane.getActualItems(items)
	for i,k in ipairs(items) do
		ISInventoryPaneContextMenu.readItem(k, player)
		break;
    end
end

-- read a book, loot it first if it's not in the player's inventory
ISInventoryPaneContextMenu.readItem = function(item, player)
	local playerObj = getSpecificPlayer(player)
	if item:getContainer() == nil then
		return
	end
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
    ISTimedActionQueue.add(ISReadABook:new(playerObj, item, 150))
end

ISInventoryPaneContextMenu.onUnEquip = function(items, player)
	items = ISInventoryPane.getActualItems(items)
	for i,k in ipairs(items) do
		ISInventoryPaneContextMenu.unequipItem(k, player)
    end
end

ISInventoryPaneContextMenu.unequipItem = function(item, player)
    if not getSpecificPlayer(player):isEquipped(item) then return end
    if item ~= nil and item:getType() == "CandleLit" then ISInventoryPaneContextMenu.litCandleExtinguish(item, player) end
    if item ~= nil and item:getType() == "Lantern_HurricaneLit" then ISInventoryPaneContextMenu.hurricaneLanternExtinguish(item, player) end
    ISTimedActionQueue.add(ISUnequipAction:new(getSpecificPlayer(player), item, 50));
end

ISInventoryPaneContextMenu.onWearItems = function(items, player)
    items = ISInventoryPane.getActualItems(items)
    local typeDone = {}; -- we keep track of what type of clothes we already wear to avoid wearing 2 times the same type (click on a stack of socks, select wear and you'll wear them 1 by 1 otherwise)
    for i,k in pairs(items) do
        if not typeDone[k:getBodyLocation()] then
            if k:getBodyLocation() == "Hat" or k:getBodyLocation() == "FullHat" then
                local playerObj = getSpecificPlayer(player);
                local wornItems = playerObj:getWornItems()
                for j=1,wornItems:size() do
                    local wornItem = wornItems:get(j-1)
                    if (wornItem:getLocation() == "SweaterHat" or wornItem:getLocation() == "JacketHat") then
                        for i=0, wornItem:getItem():getClothingItemExtraOption():size()-1 do
                            if wornItem:getItem():getClothingItemExtraOption():get(i) == "DownHoodie" then
                                ISInventoryPaneContextMenu.onClothingItemExtra(wornItem:getItem(), wornItem:getItem():getClothingItemExtra():get(i), playerObj);
                            end
                        end
                    end
                end
            end
            ISInventoryPaneContextMenu.wearItem(k, player)
            typeDone[k:getBodyLocation()] = true;
        end
    end
end

ISInventoryPaneContextMenu.onActivateItem = function(light, player)
	light:setActivated(not light:isActivated());
	light:playActivateDeactivateSound()
end

-- Wear a clothe, loot it first if it's not in the player's inventory
ISInventoryPaneContextMenu.wearItem = function(item, player)
	-- if clothing isn't in main inventory, put it there first.
	local playerObj = getSpecificPlayer(player);
	-- This stuff was removed in that it forced the first optional clothing option when trying to wear clothing items with multiple options.
	-- It seems to work fine as intended without it.
	-- wear the clothe
    -- if item:getClothingItemExtraOption() and item:getClothingItemExtra() and item:getClothingItemExtra():get(0) then
        -- ISInventoryPaneContextMenu.onClothingItemExtra(item, item:getClothingItemExtra():get(0), playerObj);
    -- else
        ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item);
        ISTimedActionQueue.add(ISWearClothing:new(playerObj, item, 50));
    -- end
end

ISInventoryPaneContextMenu.onPutItems = function(items, player)
	local playerObj = getSpecificPlayer(player)
	local playerLoot = getPlayerLoot(player).inventory
	items = ISInventoryPane.getActualItems(items)
	local doWalk = true
	for i,k in ipairs(items) do
		if playerLoot:isItemAllowed(k) and not k:isFavorite() then
			if doWalk then
				if not luautils.walkToContainer(playerLoot, player) then
					break
				end
				doWalk = false
			end
			ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, k, k:getContainer(), playerLoot))
		end
	end
end

ISInventoryPaneContextMenu.canMoveTo = function(items, dest, player)
    local playerObj = getSpecificPlayer(player)
    if instanceof(dest, "InventoryContainer") then
        local container = dest:getInventory()
        for i,item in ipairs(items) do
            if item == dest then return nil end
            if container:contains(item) then return nil end
            if not container:isItemAllowed(item) then return nil end
            if item:isFavorite() and not container:isInCharacterInventory(playerObj) then return nil end
        end
        return dest
    end
    if instanceof(dest, "ItemContainer") and dest:getType() == "floor" then
        for i,item in ipairs(items) do
            if item == dest then return nil end
            if dest:getItems():contains(item) then return nil end
            if item:isFavorite() and not dest:isInCharacterInventory(playerObj) then return nil end
        end
        return dest
    end
    return nil
end

ISInventoryPaneContextMenu.hasRoomForAny = function(playerObj, container, items)
    if instanceof(container, "InventoryContainer") then
        container = container:getInventory()
    end
    if container == nil then
        return false
    end
    if container:getType() == "floor" then
        -- TODO: All checks that ISInventoryTransferAction:getNotFullFloorSquare() does.
        return true
    end
    if #items == 1 then
        return container:hasRoomFor(playerObj, items[1])
    end
    local minWeight = 100000
    for _,item in ipairs(items) do
        minWeight = math.min(minWeight, item:getUnequippedWeight())
    end
    return container:hasRoomFor(playerObj, minWeight)
end

ISInventoryPaneContextMenu.canUnpack = function(items, player)
    local playerObj = getSpecificPlayer(player)
    for i,item in ipairs(items) do
        if playerObj:getInventory():contains(item) then return false end
        if not playerObj:getInventory():contains(item, true) then return false end
--        if not item:getContainer():isInCharacterInventory(playerObj) then return false end
--        if item:isFavorite() then return false; end
    end
    return true
end

ISInventoryPaneContextMenu.onFavorite = function(items, item2, fav)
    for i,item in ipairs(items) do
        item:setFavorite(fav);
    end
end

ISInventoryPaneContextMenu.onMoveItemsTo = function(items, dest, player)
    if dest:getType() == "floor" then
        return ISInventoryPaneContextMenu.onDropItems(items, player)
    end
    local playerObj = getSpecificPlayer(player)
	if not luautils.walkToContainer(dest, player) then
		return
	end
    for i,item in ipairs(items) do
        if playerObj:isEquipped(item) then
            ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 50));
        end
        ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), dest))
    end
end

ISInventoryPaneContextMenu.canAddManyItems = function(recipe, selectedItem, playerObj)
    local container = selectedItem:getContainer();
    if not recipe:isCanBeDoneFromFloor() then
        container = playerObj:getInventory()
    end
    if isClient() and not instanceof(container:getParent(), "IsoGameCharacter") and getServerOptions():getInteger("ItemNumbersLimitPerContainer") > 0 and selectedItem:getContainer() then
        if getItem(recipe:getResult():getFullType()) then
            local totalCount = getItemCount(recipe:getResult():getFullType()) * recipe:getResult():getCount()
            if totalCount + container:getItems():size()+1 > getServerOptions():getInteger("ItemNumbersLimitPerContainer") then
                return false;
            end
        end
    end
    --        end
    return true;
end

----- ----- ----- ----- -----

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local IMAGE_SIZE = 20

local CraftTooltip = ISToolTip:derive("CraftTooltip")
CraftTooltip.tooltipPool = {}
CraftTooltip.tooltipsUsed = {}

ISRecipeTooltip = CraftTooltip

function CraftTooltip:addText(x, y, text, r, g, b)
	r = r or 1
	g = g or 1
	b = b or 1

	local numLines = 1
	local p = string.find(text, "\n")
	while p do
		numLines = numLines + 1
		p = string.find(text, "\n", p + 4)
	end

	local width = getTextManager():MeasureStringX(UIFont.Small, text)
	table.insert(self.contents, { type = "text", x = x, y = y, width = width, height = FONT_HGT_SMALL * numLines, text = text, r = r, g = g, b = b })
end

function CraftTooltip:addImage(x, y, textureName, r, g, b)
	local r2 = r or 1;
	local g2 = g or 1;
	local b2 = b or 1;
	table.insert(self.contents, { type = "image", x = x, y = y, width = IMAGE_SIZE, height = IMAGE_SIZE, texture = getTexture(textureName), r = r2, g = g2, b = b2 })
end

function CraftTooltip:addImageDirect(x, y, texture, r, g, b)
	local r2 = r or 1;
	local g2 = g or 1;
	local b2 = b or 1;
	table.insert(self.contents, { type = "image", x = x, y = y, width = IMAGE_SIZE, height = IMAGE_SIZE, texture, r = r2, g = g2, b = b2 })
end

function CraftTooltip:getSingleSourceText(source)
	local txt = ""
	if source:isDestroy() then
		txt = getText("IGUI_CraftUI_SourceDestroy")
		-- Hack for "Refill Propane Torch" and similar
		local itemFullType = source:getItems():get(0)
		local resultFullType = self.recipe:getResult():getFullType()
		if itemFullType == resultFullType then
			txt = getText("IGUI_CraftUI_SourceKeep")
		end
		-- Hack for "Clean Bandage" / "Sterilize Bandage"
		if string.contains(itemFullType, "Bandage") and string.contains(resultFullType, "Bandage") then
			txt = getText("IGUI_CraftUI_SourceUse")
		end
		-- Hack for "Clean Rag" / "Sterilize Rag"
		if string.contains(itemFullType, "RippedSheets") and string.contains(resultFullType, "RippedSheets") then
			txt = getText("IGUI_CraftUI_SourceUse")
        end
        -- Hack for "Clean Denim/Leather Strips" / "Sterilize Denim/Leather Strips"
        if string.contains(itemFullType, "LeatherStrips") and string.contains(resultFullType, "LeatherStrips") or (string.contains(itemFullType, "DenimStrips") and string.contains(resultFullType, "DenimStrips")) then
            txt = getText("IGUI_CraftUI_SourceUse")
        end
	elseif source:isKeep() then
		txt = getText("IGUI_CraftUI_SourceKeep")
	else
		txt = getText("IGUI_CraftUI_SourceUse")
	end
	return txt
end

-- Return true if item2's type is in item1's getClothingExtraItem() list.
function CraftTooltip:isExtraClothingItemOf(item1, item2)
	local scriptItem = getScriptManager():FindItem(item1.fullType)
	if not scriptItem then
		return false
	end
	local extras = scriptItem:getClothingItemExtra()
	if not extras then
		return false
	end
	local moduleName = scriptItem:getModule():getName()
	for i=1,extras:size() do
		local extra = extras:get(i-1)
		local fullType = moduleDotType(moduleName, extra)
		if item2.fullType == fullType then
			return true
		end
	end
	return false
end

function CraftTooltip:isFluidSource(item, fluid, amount)
    return item:hasComponent(ComponentType.FluidContainer) and item:getFluidContainer():contains(fluid) and (not item:getFluidContainer():isMixture()) and item:getFluidContainer():getAmount() >= amount
end

function CraftTooltip:isWaterSource(item, count)
	return instanceof(item, "DrainableComboItem") and item:isWaterSource() and item:getCurrentUses() >= count
end

-- Duplicate of ISCraftingUI:getContainers()
function CraftTooltip:getContainers()
	if not self.character then return end
	self.playerNum = self.character:getPlayerNum()
	-- get all the surrounding inventory of the player, gonna check for the item in them too
	self.containerList = self.containerList or ArrayList.new()
	self.containerList:clear()
	for i,v in ipairs(getPlayerInventory(self.playerNum).inventoryPane.inventoryPage.backpacks) do
		self.containerList:add(v.inventory)
	end
	for i,v in ipairs(getPlayerLoot(self.playerNum).inventoryPane.inventoryPage.backpacks) do
		self.containerList:add(v.inventory)
	end
end

-- Duplicate of ISCraftingUI:getAvailableItemsType()
function CraftTooltip:getAvailableItemsType()
	local result = self.typesAvailable or {}
	table.wipe(result)
	local recipe = self.recipe
	local items = RecipeManager.getAvailableItemsAll(recipe, self.character, self.containerList, nil, nil)
	for i=0, recipe:getSource():size()-1 do
		local source = recipe:getSource():get(i)
		local sourceItemTypes = {}
		for k=1,source:getItems():size() do
			local sourceFullType = source:getItems():get(k-1)
			sourceItemTypes[sourceFullType] = true
		end
		for x=0,items:size()-1 do
			local item = items:get(x)
			local fluidType = nil;
			local fluidTypeStr = nil;
			if item:getFluidContainer() and (not item:getFluidContainer():isEmpty()) and (not item:getFluidContainer():isMixture()) then
				fluidType = item:getFluidContainer():getPrimaryFluid();
				fluidTypeStr = item:getFluidContainer():getPrimaryFluid():getFluidTypeString();
			end
			if sourceItemTypes["Water"] and self:isWaterSource(item, source:getCount()) then
				result["Water"] = (result["Water"] or 0) + item:getCurrentUses()
			elseif fluidType and sourceItemTypes["Fluid." .. fluidTypeStr] and self:isFluidSource(item, fluidType, source:getCount()) then
				result["Fluid." .. fluidTypeStr] = (result["Fluid." .. fluidTypeStr] or 0) + item:getFluidContainer():getAmount()			
			elseif sourceItemTypes[item:getFullType()] then
				local count = 1
				if not source:isDestroy() and item:IsDrainable() then
					count = item:getCurrentUses()
				end
				if not source:isDestroy() and instanceof(item, "Food") then
					if source:getUse() > 0 then
						count = -item:getHungerChange() * 100
					end
				end
				result[item:getFullType()] = (result[item:getFullType()] or 0) + count
			end
		end
	end
	self.typesAvailable = result
end

function CraftTooltip:layoutContents(x, y)
	if self.contents then
		return self.contentsWidth, self.contentsHeight
	end

-- 	self:getContainers()
-- 	self:getAvailableItemsType()
	
	self.contents = {}
	local marginLeft = 20
	local marginTop = 10
	local marginBottom = 10
	local y1 = y + marginTop
	local lineHeight = math.max(FONT_HGT_SMALL, 20 + 2)
	local textDY = (lineHeight - FONT_HGT_SMALL) / 2
	local imageDY = (lineHeight - IMAGE_SIZE) / 2
-- 	local singleSources = {}
-- 	local multiSources = {}
-- 	local allSources = {}


-- 	for j=1,self.recipe:getSource():size() do
-- 		local source = self.recipe:getSource():get(j-1)
-- 		if source:getItems():size() == 1 then
-- 			table.insert(singleSources, source)
-- 		else
-- 			table.insert(multiSources, source)
-- 		end
-- 	end
--
-- 	-- Display singleSources before multiSources
-- 	for _,source in ipairs(singleSources) do
-- 		table.insert(allSources, source)
-- 	end
--
-- 	for _,source in ipairs(multiSources) do
-- 		table.insert(allSources, source)
-- 	end
--
-- 	local maxSingleSourceLabelWidth = 0
-- 	for _,source in ipairs(singleSources) do
-- 		local txt = self:getSingleSourceText(source)
-- 		local width = getTextManager():MeasureStringX(UIFont.Small, txt)
-- 		maxSingleSourceLabelWidth = math.max(maxSingleSourceLabelWidth, width)
-- 	end
--
-- 	for _,source in ipairs(allSources) do
-- 		local txt = ""
-- 		local x1 = x + marginLeft
-- 		if source:getItems():size() > 1 then
-- 			if source:isDestroy() then
-- 				txt = getText("IGUI_CraftUI_SourceDestroyOneOf")
-- 			elseif source:isKeep() then
-- 				txt = getText("IGUI_CraftUI_SourceKeepOneOf")
-- 			else
-- 				txt = getText("IGUI_CraftUI_SourceUseOneOf")
-- 			end
-- 			self:addText(x1, y1 + textDY, txt)
-- 			y1 = y1 + lineHeight
-- 		else
-- 			txt = self:getSingleSourceText(source)
-- 			self:addText(x1, y1 + textDY, txt)
-- 			x1 = x1 + maxSingleSourceLabelWidth + 10
-- 		end
--
-- 		local itemDataList = {}
--
-- 		for k=1,source:getItems():size() do
-- 			local itemData = {}
-- 			itemData.fullType = source:getItems():get(k-1)
-- 			itemData.available = true
-- 			local item = nil
-- 			if itemData.fullType == "Water" then
-- 				item = ISInventoryPaneContextMenu.getItemInstance("Base.WaterDrop")
-- 			elseif luautils.stringStarts(itemData.fullType, "Fluid.") then
-- 				item = ISInventoryPaneContextMenu.getItemInstance("Base.WaterDrop")
-- 			else
-- 				if instanceof(self.recipe, "MovableRecipe") and (itemData.fullType == "Base."..self.recipe:getWorldSprite()) then
-- 					item = ISInventoryPaneContextMenu.getItemInstance("Moveables.Moveable")
-- 				else
-- 					item = ISInventoryPaneContextMenu.getItemInstance(itemData.fullType)
-- 				end
--                 --this reads the worldsprite so the generated item will have correct icon
--                 if instanceof(item, "Moveable") and instanceof(self.recipe, "MovableRecipe") then
--                     item:ReadFromWorldSprite(self.recipe:getWorldSprite());
--                 end
-- 			end
-- 			itemData.texture = ""
-- 			if item then
-- 				itemData.texture = item:getTex():getName()
-- 				if itemData.fullType == "Water" then
-- 					if source:getCount() == 1 then
-- 						itemData.name = getText("IGUI_CraftUI_CountOneUnit", getText("ContextMenu_WaterName"))
-- 					else
-- 						itemData.name = getText("IGUI_CraftUI_CountUnits", getText("ContextMenu_WaterName"), source:getCount())
-- 					end
-- 				elseif luautils.stringStarts(itemData.fullType, "Fluid.") then
-- 					itemData.fluidFullType = itemData.fullType;
-- 					local fluidType = luautils.split(itemData.fullType, ".")[2];
-- 					local fluid = Fluid.Get(fluidType);
-- 					local color = fluid:getColor();
-- 					itemData.r2 = color:getRedFloat();
-- 					itemData.g2 = color:getGreenFloat();
-- 					itemData.b2 = color:getBlueFloat();
-- 					if source:getCount() <= 1 then
-- 						itemData.name = getText("IGUI_CraftUI_CountOneLitre", getText("Fluid_Name_" .. fluidType), (math.floor(source:getCount() * 1000) / 1000))
-- 					else
-- 						itemData.name = getText("IGUI_CraftUI_CountOneLitre", getText("Fluid_Name_" .. fluidType), (math.floor(source:getCount() * 1000) / 1000))
-- 					end
-- 				elseif source:getItems():size() > 1 then -- no units
-- 					itemData.name = item:getDisplayName()
-- 				elseif not source:isDestroy() and item:IsDrainable() then
-- 					if source:getCount() == 1 then
-- 						itemData.name = getText("IGUI_CraftUI_CountOneUnit", item:getDisplayName())
-- 					else
-- 						itemData.name = getText("IGUI_CraftUI_CountUnits", item:getDisplayName(), source:getCount())
-- 					end
-- 				elseif not source:isDestroy() and source:getUse() > 0 then -- food
-- 					if source:getUse() == 1 then
-- 						itemData.name = getText("IGUI_CraftUI_CountOneUnit", item:getDisplayName())
-- 					else
-- 						itemData.name = getText("IGUI_CraftUI_CountUnits", item:getDisplayName(), source:getUse())
-- 					end
-- 				elseif source:getCount() > 1 then
-- 					itemData.name = getText("IGUI_CraftUI_CountNumber", item:getDisplayName(), source:getCount())
-- 				else
-- 					itemData.name = item:getDisplayName()
-- 				end
-- 			else
-- 				itemData.name = itemData.fullType
-- 			end
-- 			local countAvailable = self.typesAvailable[itemData.fullType] or 0
-- 			if self.typesAvailable[itemData.fluidFullType] then
-- 				countAvailable = self.typesAvailable[itemData.fluidFullType] or 0
-- 			end
--
-- 			if countAvailable < source:getCount() then
-- 				itemData.available = false
-- 				itemData.r = 0.54
-- 				itemData.g = 0.54
-- 				itemData.b = 0.54
-- 			end
-- 			table.insert(itemDataList, itemData)
-- 		end
--
-- 		table.sort(itemDataList, function(a,b)
-- 			if a.available and not b.available then return true end
-- 			if not a.available and b.available then return false end
-- 			return not string.sort(a.name, b.name)
-- 		end)
--
-- 		-- Hack for "Dismantle Digital Watch" and similar recipes.
-- 		-- Recipe sources include both left-hand and right-hand versions of the same item.
-- 		-- We only want to display one of them.
-- 		---[[
-- 		for j=1,#itemDataList do
-- 			local item = itemDataList[j]
-- 			for k=#itemDataList,j+1,-1 do
-- 				local item2 = itemDataList[k]
-- 				if self:isExtraClothingItemOf(item, item2) then
-- 					table.remove(itemDataList, k)
-- 				end
-- 			end
-- 		end
-- 		--]]

	    local items = self.logic:getRecipeData():getAllInputItems()
		local x1 = x + marginLeft


		for i=0,items:size()-1 do
		    local item = items:get(i)
	        if item then
			    local x2 = x1
-- 				self:addImageDirect(x2, y1 + imageDY, item:getTexture())
				self:addImage(x2, y1 + imageDY, item:getTex():getName(), 1.0, 1.0, 1.0)
				x2 = x2 + IMAGE_SIZE + 6
                self:addText(x2, y1 + textDY, item:getName())
--                 self:addText(x2, y1 + textDY, item:getName(), 1.0, 1.0, 1.0)
                y1 = y1 + lineHeight
            end
        end

-- 		for i,itemData in ipairs(itemDataList) do
-- 			local x2 = x1
-- -- 			if source:getItems():size() > 1 then
-- -- 				x2 = x2 + 20
-- --                 if source:getCount() > 1 then
-- --                     itemData.name = getText("IGUI_CraftUI_CountNumber", itemData.name, source:getCount())
-- --                 end
-- -- 			end
-- 			if itemData.texture ~= "" then
-- 				self:addImage(x2, y1 + imageDY, itemData.texture, itemData.r2, itemData.g2, itemData.b2)
-- 				x2 = x2 + IMAGE_SIZE + 6
-- 			end
-- 			self:addText(x2, y1 + textDY, itemData.name, itemData.r, itemData.g, itemData.b)
-- 			y1 = y1 + lineHeight
--
-- -- 			if i == 10 and i < #itemDataList then
-- -- 				self:addText(x2, y1 + textDY, getText("Tooltip_AndNMore", #itemDataList - i))
-- -- 				y1 = y1 + lineHeight
-- -- 				break
-- -- 			end
-- 		end
-- 	end

	if self.recipe:getTooltip() then
		local x1 = x + marginLeft
		local tooltip = getText(self.recipe:getTooltip())
		self:addText(x1, y1 + 8, tooltip)
	end

	self.contentsX = x
	self.contentsY = y
	self.contentsWidth = 0
	self.contentsHeight = 0
	for _,v in ipairs(self.contents) do
		self.contentsWidth = math.max(self.contentsWidth, v.x + v.width - x)
		self.contentsHeight = math.max(self.contentsHeight, v.y + v.height + marginBottom - y)
	end
	return self.contentsWidth, self.contentsHeight
end

function CraftTooltip:renderContents()
	for _,v in ipairs(self.contents) do
		if v.type == "image" then
			self:drawTextureScaledAspect(v.texture, v.x, v.y, v.width, v.height, 1, v.r, v.g, v.b)
		elseif v.type == "text" then
			self:drawText(v.text, v.x, v.y, v.r, v.g, v.b, 1, UIFont.Small)
		end
	end
	if false then
		self:drawRectBorder(self.contentsX, self.contentsY, self.contentsWidth, self.contentsHeight, self.height, 0.5, 0.9, 0.9, 1)
	end
end

function CraftTooltip:reset()
	ISToolTip.reset(self)
	self.contents = nil
end

function CraftTooltip:new()
	local o = ISToolTip.new(self)
	return o
end

function CraftTooltip.addToolTip()
	local pool = CraftTooltip.tooltipPool
	if #pool == 0 then
		table.insert(pool, CraftTooltip:new())
	end
	local tooltip = table.remove(pool, #pool)
	tooltip:reset()
	table.insert(CraftTooltip.tooltipsUsed, tooltip)
	return tooltip;
end

function CraftTooltip.releaseAll()
	for _,tooltip in ipairs(CraftTooltip.tooltipsUsed) do
		table.insert(CraftTooltip.tooltipPool, tooltip)
	end
--    print('reused ',#CraftTooltip.tooltipsUsed,' craft tooltips')
	table.wipe(CraftTooltip.tooltipsUsed)
end

----- ----- ----- ----- -----

ISInventoryPaneContextMenu.addDynamicalContextMenu = function(selectedItem, context, recipeList, player, containerList)
    CraftTooltip.releaseAll()
    local playerObj = getSpecificPlayer(player)
	for i=0,recipeList:size() -1 do
        local recipe = recipeList:get(i)
        -- check if we have multiple item like this
        local numberOfTimes = RecipeManager.getNumberOfTimesRecipeCanBeDone(recipe, playerObj, containerList, selectedItem)
		local resultItem = instanceItem(recipe:getResult():getFullType());
        local option = nil;
        local subMenuCraft = nil;
        -- kludge to prevent infinite water purification tablets being dumped into one bottle, TODO: need a recipe flag for this
        if (selectedItem:getType() == "Candle" or (recipe:getName() == "Purify Water" or recipe:isOnlyOne())) and numberOfTimes >= 2 then
            numberOfTimes = 1; --prevent players from lighting more than one candle at a time
        end
        if numberOfTimes ~= 1 then
            subMenuCraft = context:getNew(context);
            option = context:addOption(recipe:getName(), selectedItem, nil);
            context:addSubMenu(option, subMenuCraft);
            if playerObj:isDriving() then
                option.notAvailable = true;
            else
                local subOption = subMenuCraft:addOption(getText("ContextMenu_One"), selectedItem, ISInventoryPaneContextMenu.OnCraft, recipe, player, false);
                local tooltip = CraftTooltip.addToolTip();
                tooltip.character = playerObj
                tooltip.recipe = recipe
                -- add it to our current option
                tooltip:setName(recipe:getName());
                if resultItem:getTexture() and resultItem:getTexture():getName() ~= "Question_On" then
                    tooltip:setTexture(resultItem:getTexture():getName());
                end
                subOption.toolTip = tooltip;
                -- kludges to prevent infinite water purification tablets being dumped into one bottle, TODO: need a recipe flag for this
                if numberOfTimes > 1 and not recipe:isOnlyOne() then
                    subOption = subMenuCraft:addOption(getText("ContextMenu_AllWithCount", numberOfTimes), selectedItem, ISInventoryPaneContextMenu.OnCraft, recipe, player, true);
                elseif not recipe:isOnlyOne() then
                    subOption = subMenuCraft:addOption(getText("ContextMenu_All"), selectedItem, ISInventoryPaneContextMenu.OnCraft, recipe, player, true);
                end
                subOption.toolTip = tooltip;
            end
        else
            option = context:addOption(recipe:getName(), selectedItem, ISInventoryPaneContextMenu.OnCraft, recipe, player, false);

            -- special handling for if the player already has a lit candle in their inventory
            local inventoryItems = playerObj:getInventory():getItems()
            for j=1,inventoryItems:size() do
                local item = inventoryItems:get(j-1)
                if item:getType() == "CandleLit" and selectedItem:getType() == "Candle" then
                    option.notAvailable = true;
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    tooltip.description = getText("Tooltip_CantCraftSecondLitCandle");
                    option.toolTip = tooltip;
                    return
                end
                if item:getType() == "Lantern_HurricaneLit" and selectedItem:getType() == "Lantern_Hurricane" then
                    option.notAvailable = true;
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    tooltip.description = getText("Tooltip_CantCraftSecondLitLantern");
                    option.toolTip = tooltip;
                    return
                end
            end

        end
        -- limit doing a recipe that add multiple items if the dest container has an item limit
        if not ISInventoryPaneContextMenu.canAddManyItems(recipe, selectedItem, playerObj) then
            option.notAvailable = true;
            if subMenuCraft then
                for i,v in ipairs(subMenuCraft.options) do
                    v.notAvailable = true;
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    tooltip.description = getText("Tooltip_CantCraftContainerFull");
                    v.toolTip = tooltip;
                end
            end
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("Tooltip_CantCraftContainerFull");
            option.toolTip = tooltip;
            return;
        end
        if playerObj:isDriving() then
            option.notAvailable = true;
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("Tooltip_CantCraftDriving");
            option.toolTip = tooltip;
            return
        end
        if subMenuCraft == nil and recipe:getNumberOfNeededItem() > 0 then
			local tooltip = CraftTooltip.addToolTip();
			tooltip.character = playerObj
			tooltip.recipe = recipe
			-- add it to our current option
			tooltip:setName(recipe:getName());
			if resultItem:getTexture() and resultItem:getTexture():getName() ~= "Question_On" then
				tooltip:setTexture(resultItem:getTexture():getName());
			end
			option.toolTip = tooltip;
		end
	end
end

ISInventoryPaneContextMenu.addNewCraftingDynamicalContextMenu = function(selectedItem, context, recipeList, player, containerList)
    CraftTooltip.releaseAll()
    local playerObj = getSpecificPlayer(player)
 	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	for i=0,recipeList:size() -1 do
        local recipe = recipeList:get(i)

        local logic = HandcraftLogic.new(playerObj, nil, nil);



        logic:setRecipe(recipe);
        logic:setContainers(containers);
        logic:setManualSelectInputs(true)
        logic:selectionSpam()

        local data = logic:getRecipeData()
        data:offerInputItem(selectedItem)




        local recipeName = getText(recipe:getTranslationName())
        local scriptName = recipe:getName()
        local recipeTexture
        if logic then
            recipeTexture = logic:getResultTexture() or selectedItem:getTexture() or nil
        end
        if selectedItem and not recipeTexture then
            recipeTexture = selectedItem:getTexture()
        end
        local text = recipeName
        if isDebugEnabled() or getSandboxOptions():isUnstableScriptNameSpam() then
            text = text .. " - (DEBUG) Script Name: " .. scriptName
--                 text = text .. " - (DEBUG) Script Name: " .. scriptName .. " - NOTE: Recipes do not have spaces in their names yet"
        end
        option = context:addOption(text , selectedItem, ISInventoryPaneContextMenu.OnNewCraft, recipe, player, false);
        if recipeTexture then
            option.iconTexture = recipeTexture
            if selectedItem:getColor() then
                option.color = {};
                option.color.b = selectedItem:getColorBlue();
                option.color.r = selectedItem:getColorRed();
                option.color.g = selectedItem:getColorGreen();
            end
        end


        local tooltip = CraftTooltip.addToolTip();
        local iconName = recipe:getIconName()
        tooltip.character = playerObj
        tooltip.recipe = recipe
        tooltip.logic = logic
        -- add it to our current option
        tooltip:setName(recipe:getTranslationName());
-- 			if resultItem:getTexture() and resultItem:getTexture():getName() ~= "Question_On" then
        if recipeTexture then
            tooltip:setTextureDirectly(recipeTexture);
        end
-- 			end
        option.toolTip = tooltip;
	end
end

ISInventoryPaneContextMenu.addToolTip = function()
	local pool = ISInventoryPaneContextMenu.tooltipPool
	if #pool == 0 then
		table.insert(pool, ISToolTip:new())
	end
	local tooltip = table.remove(pool, #pool)
	tooltip:reset()
	table.insert(ISInventoryPaneContextMenu.tooltipsUsed, tooltip)
	return tooltip;
end

ISInventoryPaneContextMenu.OnNewCraft = function(selectedItem, recipe, player, all)
 	local playerObj = getSpecificPlayer(player)
 	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	local logic = HandcraftLogic.new(playerObj, nil, nil);
	logic:setRecipe(recipe);
	logic:setContainers(containers);
    logic:setManualSelectInputs(true)
    logic:selectionSpam()

    local data = logic:getRecipeData()
    data:offerInputItem(selectedItem)
--     if logic:getRecipeData():canOfferInputItem(selectedItem) then
        if logic:canPerformCurrentRecipe() then


            local items = logic:getRecipeData():getAllInputItems()
            local itemsToReturn = logic:getRecipeData():getAllPutBackInputItems()
            local returnToContainer = {}; -- keep track of items we moved to put them back to their original container
            if not recipe:isCanBeDoneFromFloor() then
                for i=1,items:size() do
                    local item = items:get(i-1)
                    if item:getContainer() ~= playerObj:getInventory() then
                        ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory(), nil))
                        if itemsToReturn:contains(item) then
                            table.insert(returnToContainer, item)
                        end
                    end
                end
            end


            logic:setManualSelectInputs(true)
            logic:selectionSpam()
            logic:getRecipeData():offerInputItem(selectedItem)
            local action = ISEntityUI.HandcraftStart( playerObj, logic, false, true);
            if action then
                print("=========== starting craft ===========")
                if not all then action:setOnComplete(ISInventoryPaneContextMenu.OnNewCraftComplete, logic); end
                logic:startCraftAction(action);
                --self:triggerEvent(ISWidgetHandCraftControl.startHandcraft, self, self.player, self.logic);
            else
                --self.logic:stopCraftAction();
            end

            ISCraftingUI.ReturnItemsToOriginalContainer(playerObj, returnToContainer)
--             if all then
--                 action:setOnComplete(ISInventoryPaneContextMenu.OnNewCraftCompleteAll,  action, recipe, playerObj, containers, logic:getRecipeData():getAllInputItems())
--             end
        end
--     end
end

ISInventoryPaneContextMenu.OnNewCraftComplete = function(logic)
    print("ISInventoryPaneContextMenu.OnNewCraftComplete -> Craft action completed")
    logic:stopCraftAction();
end

ISInventoryPaneContextMenu.OnNewCraftCompleteAll = function(completedAction, recipe, playerObj, containers, usedItems)
    local logic = HandcraftLogic.new(playerObj, nil, nil);
    logic:setRecipe(recipe);
    logic:setContainers(containers);

    if not logic:canPerformCurrentRecipe()  then
        return;
    end
    logic:setManualSelectInputs(true)
    logic:selectionSpamWithout(usedItems)
    local action = ISEntityUI.HandcraftStart( playerObj, logic, false, true);
    if action then
        print("=========== starting craft ===========")
        logic:startCraftAction(action);
        local newItems = logic:getRecipeData():getAllInputItems()

		for i=0,items:size()-1 do
		    local item = newItems:get(i)
	        if item then
	            usedItems:add(item)
            end
        end
        action:setOnComplete(ISInventoryPaneContextMenu.OnNewCraftCompleteAll,  action, recipe, playerObj, container, usedItems)
--         ISTimedActionQueue.addAfter(completedAction, action)
    else
        ISInventoryPaneContextMenu.OnNewCraftComplete(logic)
    end
end

ISInventoryPaneContextMenu.OnCraft = function(selectedItem, recipe, player, all)
	local playerObj = getSpecificPlayer(player)
	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	local container = selectedItem:getContainer()
    local selectedItemContainer = selectedItem:getContainer()
	if not recipe:isCanBeDoneFromFloor() then
		container = playerObj:getInventory()
	end
	local items = RecipeManager.getAvailableItemsNeeded(recipe, playerObj, containers, selectedItem, nil)
	local returnToContainer = {}; -- keep track of items we moved to put them back to their original container
	if not recipe:isCanBeDoneFromFloor() then
		for i=1,items:size() do
			local item = items:get(i-1)
			if item:getContainer() ~= playerObj:getInventory() then
				ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory(), nil))
				table.insert(returnToContainer, item)
			end
		end
	end

    -- in case of movable dismantling equip tools:
    if instanceof(recipe, "MovableRecipe") then
        local primaryTool = RecipeManager.GetMovableRecipeTool(true, recipe, selectedItem, playerObj, containers);
        if primaryTool then
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), primaryTool, true)
        end

        local secondaryTool = RecipeManager.GetMovableRecipeTool(false, recipe, selectedItem, playerObj, containers);
        if secondaryTool then
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), secondaryTool, false)
        end
    end

	local action = ISCraftAction:new(playerObj, selectedItem, recipe, container, containers)
	if all then
		action:setOnComplete(ISInventoryPaneContextMenu.OnCraftComplete, action, recipe, playerObj, container, containers, selectedItem:getFullType(), selectedItemContainer)
	end

	ISTimedActionQueue.add(action)

    -- add back their item to their original container
    ISCraftingUI.ReturnItemsToOriginalContainer(playerObj, returnToContainer)
end

ISInventoryPaneContextMenu.OnCraftComplete = function(completedAction, recipe, playerObj, container, containers, selectedItemType, selectedItemContainer)
	if not RecipeManager.IsRecipeValid(recipe, playerObj, nil, containers) then return end
    local items = nil
    if recipe:isInSameInventory() then
        local tItems = selectedItemContainer:getItems()
        local tSelectedItem = nil
        for i=0, tItems:size()-1 do
            local v = recipe:getSource():get(0):getItems()
            for j=0, v:size()-1 do
                if tItems:get(i):getFullType() == v:get(j) then
                    tSelectedItem = tItems:get(i)
                    break
                end
            end
            if tSelectedItem ~= nil then
                break
            end
        end

        if tSelectedItem ~= nil then
            items = RecipeManager.getAvailableItemsNeeded(recipe, playerObj, containers, tSelectedItem, nil)
        end
    else
        items = RecipeManager.getAvailableItemsNeeded(recipe, playerObj, containers, nil, nil)
    end

    if items == nil or items:isEmpty() then return end
    if not ISInventoryPaneContextMenu.canAddManyItems(recipe, items:get(0), playerObj) then
        return;
    end

	local previousAction = completedAction
	local returnToContainer = {}
	if not recipe:isCanBeDoneFromFloor() then
		for i=1,items:size() do
			local item = items:get(i-1)
			if item:getContainer() ~= playerObj:getInventory() then
				local action = ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory(), nil)
				if not action.ignoreAction then
					ISTimedActionQueue.addAfter(previousAction, action)
					previousAction = action
				end
				table.insert(returnToContainer, item)
			end
		end
	end

	local action = ISCraftAction:new(playerObj, items:get(0), recipe, container, containers)
	action:setOnComplete(ISInventoryPaneContextMenu.OnCraftComplete, action, recipe, playerObj, container, containers, items:get(0):getFullType(), selectedItemContainer)
    ISTimedActionQueue.addAfter(previousAction, action)
    ISCraftingUI.ReturnItemsToOriginalContainer(playerObj, returnToContainer)
end

ISInventoryPaneContextMenu.eatItem = function(item, percentage, player)
--	if not player then
    local playerObj = getSpecificPlayer(player);
--	end
	-- if food isn't in main inventory, put it there first.
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)

	-- now remove a mask
	local mask = ISInventoryPaneContextMenu.getEatingMask(playerObj, true)

	-- Transfer required items.
	if item:getRequireInHandOrInventory() then
		local itemRequired = nil
		local types = item:getRequireInHandOrInventory()
        local typesTable = {}
        for i=1,types:size() do
            typesTable[moduleDotType(item:getModule(), types:get(i-1))] = true
        end
        -- check for car lighters for smokables

        if item:hasTag("Smokable") and playerObj:getVehicle() and playerObj:getVehicle():canLightSmoke(playerObj) then itemRequired = true end
        if item:hasTag("Smokable") and not itemRequired then
           itemRequired = ISInventoryPaneContextMenu.hasOpenFlame(playerObj)
        end
        -- Check first in inventory
        if not itemRequired then
            local items = playerObj:getInventory():getItems()
            for j=1, items:size() do
                if typesTable[items:get(j-1):getFullType()] and predicateNotEmpty(items:get(j-1))then
                    itemRequired = items:get(j-1)
                    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, itemRequired)
                    break
                end
            end
        end
        -- Then check recurse in other containers
        if not itemRequired then
            for v, _ in pairs(typesTable) do
                itemRequired = playerObj:getInventory():getFirstTypeRecurse(v)
                if itemRequired then
                    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, itemRequired)
                    break
                end
            end
        end

		if not itemRequired then return end
	end
    -- Then eat it.
    ISTimedActionQueue.add(ISEatFoodAction:new(playerObj, item, percentage));

    if mask then ISTimedActionQueue.add(ISWearClothing:new(playerObj, mask, 50)) end
end

-- Function that unequip primary weapon and equip the selected weapon
ISInventoryPaneContextMenu.OnPrimaryWeapon = function(items, player)
    local playerObj = getSpecificPlayer(player)
    if playerObj:getPrimaryHandItem() ~= nil and playerObj:getPrimaryHandItem():getType() == "CandleLit" then
        ISInventoryPaneContextMenu.litCandleExtinguish(playerObj:getPrimaryHandItem(), player)
    end
    if playerObj:getPrimaryHandItem() ~= nil and playerObj:getPrimaryHandItem():getType() == "Lantern_HurricaneLit" then
        ISInventoryPaneContextMenu.hurricaneLanternExtinguish(playerObj:getPrimaryHandItem(), player)
    end
	items = ISInventoryPane.getActualItems(items)
	for i,k in ipairs(items) do
		if (instanceof(k, "HandWeapon") and k:getCondition() > 0) or (instanceof(k, "InventoryItem") and not instanceof(k, "HandWeapon")) then
			ISInventoryPaneContextMenu.equipWeapon(k, true, false, player)
			break
		end
	end
end

-- Function that goes through all pills selected and take them.
ISInventoryPaneContextMenu.onPillsItems = function(items, player)
	items = ISInventoryPane.getActualItems(items)
	for i,k in ipairs(items) do
		ISInventoryPaneContextMenu.takePill(k, player)
		break
    end
end

-- Take a pill, loot it first if it's not in the player's inventory
ISInventoryPaneContextMenu.takePill = function(item, player)
	local playerObj = getSpecificPlayer(player);
	-- if pill isn't in main inventory, put it there first.
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
	-- now remove a mask
	local mask = ISInventoryPaneContextMenu.getEatingMask(playerObj, true)
	-- take the pill
	ISTimedActionQueue.add(ISTakePillAction:new(playerObj, item));
    if mask then ISTimedActionQueue.add(ISWearClothing:new(playerObj, mask, 50)) end
end

ISInventoryPaneContextMenu.onInspectTrack = function(player, track)
    ISTimedActionQueue.add(ISInspectAnimalTrackAction:new(player, track));
end

ISInventoryPaneContextMenu.OnTwoHandsEquip = function(items, player)
    local playerObj = getSpecificPlayer(player)
    if playerObj:getPrimaryHandItem() ~= nil and playerObj:getPrimaryHandItem():getType() == "CandleLit" then
        ISInventoryPaneContextMenu.litCandleExtinguish(playerObj:getPrimaryHandItem(), player)
    end
    if playerObj:getSecondaryHandItem() ~= nil and playerObj:getSecondaryHandItem():getType() == "CandleLit" then
        ISInventoryPaneContextMenu.litCandleExtinguish(playerObj:getSecondaryHandItem(), player)
    end
    if playerObj:getPrimaryHandItem() ~= nil and playerObj:getPrimaryHandItem():getType() == "Lantern_HurricaneLit" then
        ISInventoryPaneContextMenu.hurricaneLanternExtinguish(playerObj:getPrimaryHandItem(), player)
    end
    if playerObj:getSecondaryHandItem() ~= nil and playerObj:getSecondaryHandItem():getType() == "Lantern_HurricaneLit" then
        ISInventoryPaneContextMenu.hurricaneLanternExtinguish(playerObj:getSecondaryHandItem(), player)
    end
	items = ISInventoryPane.getActualItems(items)
	for _,item in ipairs(items) do
		ISInventoryPaneContextMenu.equipWeapon(item, false, true, player)
		break
	end
end

-- Function that unequip second weapon and equip the selected weapon
ISInventoryPaneContextMenu.OnSecondWeapon = function(items, player)
    local playerObj = getSpecificPlayer(player)
    if playerObj:getSecondaryHandItem() ~= nil and playerObj:getSecondaryHandItem():getType() == "CandleLit" then
        ISInventoryPaneContextMenu.litCandleExtinguish(playerObj:getSecondaryHandItem(), player)
    end
    if playerObj:getSecondaryHandItem() ~= nil and playerObj:getSecondaryHandItem():getType() == "Lantern_HurricaneLit" then
        ISInventoryPaneContextMenu.hurricaneLanternExtinguish(playerObj:getSecondaryHandItem(), player)
    end
	items = ISInventoryPane.getActualItems(items)
	for _,item in ipairs(items) do
		ISInventoryPaneContextMenu.equipWeapon(item, false, false, player)
		break
	end
end

-- Function that equip the selected weapon
ISInventoryPaneContextMenu.equipWeapon = function(weapon, primary, twoHands, player)
	local playerObj = getSpecificPlayer(player)
	-- Drop corpse or generator
	if isForceDropHeavyItem(playerObj:getPrimaryHandItem()) then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
	end
	-- if weapon isn't in main inventory, put it there first.
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, weapon)
    -- Then equip it.
    ISTimedActionQueue.add(ISEquipWeaponAction:new(playerObj, weapon, 50, primary, twoHands));
end

ISInventoryPaneContextMenu.onInformationItems = function(items)
	items = ISInventoryPane.getActualItems(items)
	for i,k in pairs(items) do
		ISInventoryPaneContextMenu.information(k)
		break
	end
end

ISInventoryPaneContextMenu.information = function(item)
--~ 	local tooltip = ObjectTooltip.new();
--~ 	item:DoTooltip(tooltip);
	ISInventoryPaneContextMenu.removeToolTip();
	ISInventoryPaneContextMenu.toolRender = ISToolTipInv:new(item);
	ISInventoryPaneContextMenu.toolRender:initialise();
	ISInventoryPaneContextMenu.toolRender:addToUIManager();
	ISInventoryPaneContextMenu.toolRender:setVisible(true);
end

ISInventoryPaneContextMenu.removeToolTip = function()
	if ISInventoryPaneContextMenu.toolRender then
		ISInventoryPaneContextMenu.toolRender:removeFromUIManager();
		ISInventoryPaneContextMenu.toolRender:setVisible(false);
	end
end

-- Function that goes through all items selected and eats them.
-- eat only 1 of the item list
ISInventoryPaneContextMenu.onEatItems = function(items, percentage, player)
	items = ISInventoryPane.getActualItems(items)
	for i,k in ipairs(items) do
		ISInventoryPaneContextMenu.eatItem(k, percentage, player)
		break
    end
end

ISInventoryPaneContextMenu.onPlaceTrap = function(weapon, player)
    ISTimedActionQueue.add(ISPlaceTrap:new(player, weapon));
end

ISInventoryPaneContextMenu.onRemoveUpgradeWeapon = function(weapon, part, playerObj)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, weapon)
    local screwdriver = playerObj:getInventory():getFirstTagEvalRecurse("Screwdriver", predicateNotBroken)
    if screwdriver then
        ISInventoryPaneContextMenu.equipWeapon(screwdriver, true, false, playerObj:getPlayerNum());
        ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(playerObj, weapon, part:getPartType()));
    end
end

ISInventoryPaneContextMenu.onUpgradeWeapon = function(weapon, part, player)
    ISInventoryPaneContextMenu.transferIfNeeded(player, weapon)
    ISInventoryPaneContextMenu.transferIfNeeded(player, part)
    local screwdriver = player:getInventory():getFirstTagEvalRecurse("Screwdriver", predicateNotBroken)
    if screwdriver then
        ISInventoryPaneContextMenu.equipWeapon(part, false, false, player:getPlayerNum());
        ISInventoryPaneContextMenu.equipWeapon(screwdriver, true, false, player:getPlayerNum());
        ISTimedActionQueue.add(ISUpgradeWeapon:new(player, weapon, part));
    end
end

ISInventoryPaneContextMenu.onDropItems = function(items, player)
	local playerObj = getSpecificPlayer(player)

    local noVehicle = true
    local vehicleNoWindow = true
    local vehicleWindowOpen = true

    local vehicle = playerObj:getVehicle()

    if vehicle ~= nil then
        noVehicle = false
        local seat = vehicle:getSeat(playerObj)
        local door = vehicle:getPassengerDoor(seat)
        local windowPart = VehicleUtils.getChildWindow(door)
        if windowPart and (not windowPart:getItemType() or windowPart:getInventoryItem()) then
            vehicleNoWindow = false
            local window = windowPart:getWindow()
            if window:isOpenable() and not window:isOpen() then
                vehicleWindowOpen = false
            end
        end
    end

    if not (noVehicle or vehicleNoWindow or vehicleWindowOpen) then return end

	items = ISInventoryPane.getActualItems(items)
--	ISInventoryPaneContextMenu.transferItems(items, playerObj:getInventory(), player, true)
	for _,item in ipairs(items) do
		if not item:isFavorite() then
			ISInventoryPaneContextMenu.dropItem(item, player)
		end
	end
end

ISInventoryPaneContextMenu.litCandleExtinguish = function(item, player)
    local playerObj = getSpecificPlayer(player)
    ISTimedActionQueue.add(ISLitCandleExtinguish:new(playerObj, item));
end

ISInventoryPaneContextMenu.hurricaneLanternExtinguish = function(item, player)
    local playerObj = getSpecificPlayer(player)

    ISTimedActionQueue.add(ISHurricaneLanternExtinguish:new(playerObj, item));
end

ISInventoryPaneContextMenu.dropItem = function(item, player)
    if "Tutorial" == getCore():getGameMode() then
        return;
    end
	local playerObj = getSpecificPlayer(player)

    --lit candles need special handling if they're dropped.
    --this unequips the lit candle and extinguish it, then prepares the new unlit candle to be dropped
    if item:getType() == "CandleLit" and item:isEquipped() then
        ISInventoryPaneContextMenu.litCandleExtinguish(item, player)
    end
    if item:getType() == "Lantern_HurricaneLit" and item:isEquipped() then
        ISInventoryPaneContextMenu.hurricaneLanternExtinguish(item, player)
    end

	if not playerObj:isHandItem(item) then
		local hotbar = getPlayerHotbar(player)
		if hotbar and hotbar:isItemAttached(item) then
			hotbar:removeItem(item, true)
		else
			ISInventoryPaneContextMenu.unequipItem(item, player)
		end
	end
	
	if true then
		-- Don't transfer items to the player's inventory first, since doing so
		-- breaks ISInventoryTransferAction's multi-item transfer thing.
		ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), ISInventoryPage.floorContainer[player + 1]))
		return
	end
	-- if item isn't in main inventory, put it there first.
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
    ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, playerObj:getInventory(), ISInventoryPage.floorContainer[player + 1]));
end

ISInventoryPaneContextMenu.onGrabItems = function(items, player)
	local playerInv = getPlayerInventory(player).inventory;
	ISInventoryPaneContextMenu.transferItems(items, playerInv, player)
end

ISInventoryPaneContextMenu.transferItems = function(items, playerInv, player, dontWalk)
	local playerObj = getSpecificPlayer(player)
	items = ISInventoryPane.getActualItems(items)
	for i,k in ipairs(items) do
		if k:getContainer() ~= playerInv and k:getContainer() ~= nil then
			if not dontWalk then
				if not luautils.walkToContainer(k:getContainer(), player) then
					return
				end
				dontWalk = true
			end
			ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, k, k:getContainer(), playerInv))
		end
	end
end

ISInventoryPaneContextMenu.onGrabHalfItems = function(items, player)
	local playerObj = getSpecificPlayer(player)
	local playerInv = getPlayerInventory(player).inventory;
	local doWalk = true
	for i,k in ipairs(items) do
		if not instanceof(k, "InventoryItem") then
			local count = math.floor((#k.items - 1) / 2)
			-- first in a list is a dummy duplicate, so ignore it.
			for i2=1,count do
				local k2 = k.items[i2+1]
				if k2:getContainer() ~= playerInv then
					if doWalk then
						if not luautils.walkToContainer(k2:getContainer(), player) then
							return
						end
						doWalk = false
					end
					ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, k2, k2:getContainer(), playerInv))
				end
			end
		elseif k:getContainer() ~= playerInv then
			if doWalk then
				if not luautils.walkToContainer(k2:getContainer(), player) then
					return
				end
				doWalk = false
			end
			ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, k, k:getContainer(), playerInv))
		end
	end
end

ISInventoryPaneContextMenu.onEditItem = function(items, player, item)
    --local ui = ISItemEditorUI:new(50,50,600,600, player, item);
    --ui:initialise();
    --ui:addToUIManager();
    ISItemEditorUI.OpenPanel(player, item);
end

ISInventoryPaneContextMenu.onGrabOneItems = function(items, player)
	items = ISInventoryPane.getActualItems(items)
    local playerObj = getSpecificPlayer(player);
    local playerInv = getPlayerInventory(player).inventory;
	for i,k in ipairs(items) do
		if k:getContainer() ~= playerInv then
			if not luautils.walkToContainer(k:getContainer(), player) then
				return
			end
			ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, k, k:getContainer(), playerInv));
			return;
		end
	end
end

-- Crowley
-- Pours water from one container into another.
ISInventoryPaneContextMenu.onTransferWater = function(items, itemFrom, itemTo, player)
	--print("Moving water from " .. itemFrom:getName() .. " to " .. itemTo:getName());
	local playerObj = getSpecificPlayer(player)
	--if not itemTo:isWaterSource() then
	--	local newItemType = itemTo:getReplaceType("WaterSource");
    --    local newItem = instanceItem(newItemType,0);
    --    newItem:setFavorite(itemTo:isFavorite());
    --    newItem:setCondition(itemTo:getCondition());
    --    playerObj:getInventory():AddItem(newItem);
	--	if playerObj:getPrimaryHandItem() == itemTo then
	--		playerObj:setPrimaryHandItem(newItem)
	--	end
	--	if playerObj:getSecondaryHandItem() == itemTo then
	--		playerObj:setSecondaryHandItem(newItem)
	--	end
	--	playerObj:getInventory():Remove(itemTo);
    --
    --    itemTo = newItem;
    --end
--
	local waterStorageAvailable = 1;
	local waterConversionRate;
	local waterInToContainer;
    if itemTo:isWaterSource() then
        waterStorageAvailable = (1 - itemTo:getCurrentUsesFloat()) / itemTo:getUseDelta();
        waterInToContainer = itemTo:getCurrentUsesFloat();
        waterConversionRate = itemTo:getUseDelta();
    else
        local newItemType = itemTo:getReplaceType("WaterSource");
        local newItemScript = getItem(newItemType)

        waterStorageAvailable = 1 / newItemScript:getUseDelta();
        waterInToContainer = 0;
        waterConversionRate = newItemScript:getUseDelta();
    end
	local waterStorageNeeded = itemFrom:getCurrentUses();
-- 	local waterStorageNeeded = itemFrom:getCurrentUsesFloat() / itemFrom:getUseDelta();

	local itemFromEndingDelta = 0;
--
	if waterStorageAvailable >= waterStorageNeeded then
		--Transfer all water to the the second container.
		itemFromEndingDelta = 0;
	end

	if waterStorageAvailable < waterStorageNeeded then
		--Transfer what we can. Leave the rest in the container.
		local waterInB = itemFrom:getCurrentUses();
-- 		local waterInB = itemFrom:getCurrentUsesFloat() / itemFrom:getUseDelta();
		local waterRemainInB = waterInB - waterStorageAvailable;

		itemFromEndingDelta = waterRemainInB * itemFrom:getUseDelta();
	end
	waterConversionRate = waterConversionRate/itemFrom:getUseDelta();
	local itemToEndingDelta = waterInToContainer+(itemFrom:getCurrentUsesFloat()-itemFromEndingDelta)*waterConversionRate;
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, itemFrom)
    -- disable autodrink so we dont drink from the container we're transfering from
    local hookAutoDrink
    hookAutoDrink = function(character)
        if not ISTimedActionQueue.hasActionType(character, "ISTransferWaterAction") then
            Hook.AutoDrink.Remove(hookAutoDrink)
        end
    end
    if getCore():getOptionAutoDrink() then
        Hook.AutoDrink.Add(hookAutoDrink)
    end
	ISTimedActionQueue.add(ISTransferWaterAction:new(getSpecificPlayer(player), itemFrom, itemTo, itemFromEndingDelta, itemToEndingDelta));
end
--/Crowley

-- Crowley
-- Empties a water container
ISInventoryPaneContextMenu.onEmptyWaterContainer = function(items, waterSource, player)
	if waterSource ~= nil then
		local playerObj = getSpecificPlayer(player)
		ISInventoryPaneContextMenu.transferIfNeeded(playerObj, waterSource)
		ISTimedActionQueue.add(ISDumpWaterAction:new(playerObj, waterSource));
	end
end
--/Crowley

-- Return true if the given item's ReplaceOnUse type can hold water.
-- The check is recursive to handle RemouladeFull -> RemouladeHalf -> RemouladeEmpty.
ISInventoryPaneContextMenu.canReplaceStoreWater = function(item)
    --	print('testing ' .. item:getFullType())
    if item:hasTag("NoPour") then return false end

    if item:getReplaceOnUse() then
        itemType = moduleDotType(item:getModule(), item:getReplaceOnUse())
        return true
    end
    if instanceof(item, "DrainableComboItem") and item:getReplaceOnDeplete() then
        itemType = moduleDotType(item:getModule(), item:getReplaceOnDeplete())
        return ISInventoryPaneContextMenu.canReplaceStoreWater2(itemType)
    end
    return false
end

ISInventoryPaneContextMenu.canReplaceStoreWater2 = function(itemType)
--	print('testing ' .. itemType)
	local item = ScriptManager.instance:FindItem(itemType)
	if item == nil then return false end
    if item:getReplaceOnUse() then
        itemType = moduleDotType(item:getModuleName(), item:getReplaceOnUse())
        return ISInventoryPaneContextMenu.canReplaceStoreWater2(itemType)
    end
    if (item:getType() == Type.Drainable) and item:getReplaceOnDeplete() then
        itemType = moduleDotType(item:getModuleName(), item:getReplaceOnDeplete())
        return ISInventoryPaneContextMenu.canReplaceStoreWater2(itemType)
    end
    return false
end


ISInventoryPaneContextMenu.onDumpContents = function(items, item, player)
	if item ~= nil then
		local playerObj = getSpecificPlayer(player)
		ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
		ISTimedActionQueue.add(ISDumpContentsAction:new(playerObj, item));
	end
end

ISInventoryPaneContextMenu.startWith = function(String,Start)
	return string.sub(String, 1, string.len(Start)) == Start;
end

ISInventoryPaneContextMenu.getRealEvolvedItemUse = function(evoItem, evorecipe2, cookingLvl)
    if not evoItem or not evorecipe2 or not evorecipe2:getItemRecipe(evoItem) then return; end
    local use = evorecipe2:getItemRecipe(evoItem):getUse();
    if use > math.abs(evoItem:getHungerChange() * 100) then
        use = math.floor(math.abs(evoItem:getHungerChange() * 100));
    end
    if evoItem:isRotten() then
        local baseHunger = evoItem:getBaseHunger() * 100
        if cookingLvl == 7 or cookingLvl == 8 then
            use = math.abs(round(baseHunger - (baseHunger - ((5/100) * baseHunger)), 1));
        else
            use = math.abs(round(baseHunger - (baseHunger - ((10/100) * baseHunger)), 1));
        end
    end
    return use;
end

ISInventoryPaneContextMenu.doEquipOption = function(context, playerObj, isWeapon, items, player)
    -- check if hands if not heavy damaged
    if (not playerObj:isPrimaryHandItem(isWeapon) or (playerObj:isPrimaryHandItem(isWeapon) and playerObj:isSecondaryHandItem(isWeapon))) and not getSpecificPlayer(player):getBodyDamage():getBodyPart(BodyPartType.Hand_R):isDeepWounded() and (getSpecificPlayer(player):getBodyDamage():getBodyPart(BodyPartType.Hand_R):getFractureTime() == 0 or getSpecificPlayer(player):getBodyDamage():getBodyPart(BodyPartType.Hand_R):getSplintFactor() > 0) then
        -- forbid reequipping skinned items to avoid multiple problems for now
        local add = true;
        if isWeapon and playerObj:getSecondaryHandItem() == isWeapon and isWeapon:getScriptItem():getReplaceWhenUnequip() then
            add = false;
        end
        if add then
            context:addOption(getText("ContextMenu_Equip_Primary"), items, ISInventoryPaneContextMenu.OnPrimaryWeapon, player);
        end
    end
    if (not playerObj:isSecondaryHandItem(isWeapon) or (playerObj:isPrimaryHandItem(isWeapon) and playerObj:isSecondaryHandItem(isWeapon))) and not getSpecificPlayer(player):getBodyDamage():getBodyPart(BodyPartType.Hand_L):isDeepWounded() and (getSpecificPlayer(player):getBodyDamage():getBodyPart(BodyPartType.Hand_L):getFractureTime() == 0 or getSpecificPlayer(player):getBodyDamage():getBodyPart(BodyPartType.Hand_L):getSplintFactor() > 0) then
        -- forbid reequipping skinned items to avoid multiple problems for now
        local add = true;
        if isWeapon and playerObj:getPrimaryHandItem() == isWeapon and isWeapon:getScriptItem():getReplaceWhenUnequip() then
            add = false;
        end
        if add then
            context:addOption(getText("ContextMenu_Equip_Secondary"), items, ISInventoryPaneContextMenu.OnSecondWeapon, player);
        end
    end
end

 ISInventoryPaneContextMenu.onTurnIntoSkeleton = function(animal)
     animal:getModData()["skeleton"] = "true";
 end

ISInventoryPaneContextMenu.equipHeavyItem = function(playerObj, item)
    if not luautils.walkToContainer(item:getContainer(), playerObj:getPlayerNum()) then
        return
    end
    if playerObj:getPrimaryHandItem() then
        ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
    end
    if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
        ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
    end
    ISTimedActionQueue.add(ISEquipHeavyItem:new(playerObj, item));
end

ISInventoryPaneContextMenu.onMakeUp = function(makeup, playerObj)
    local playerNum = playerObj:getPlayerNum()
    if ISMakeUpUI.windows[playerNum+1] then
        ISMakeUpUI.windows[playerNum+1]:setVisible(true);
        ISMakeUpUI.windows[playerNum+1].item = makeup;
        ISMakeUpUI.windows[playerNum+1]:reinit();
    else
        ISMakeUpUI.windows[playerNum+1] = ISMakeUpUI:new(0, 0, makeup, playerObj);
        ISMakeUpUI.windows[playerNum+1]:initialise();
        ISMakeUpUI.windows[playerNum+1]:addToUIManager();
    end
    if JoypadState.players[playerNum+1] then
        ISMakeUpUI.windows[playerNum+1].prevFocus = JoypadState.players[playerNum+1].focus
        JoypadState.players[playerNum+1].focus = ISMakeUpUI.windows[playerNum+1]
    end
end

function ISInventoryPaneContextMenu.doGrabMenu(context, items, player)
    for i,k in pairs(items) do
        if not instanceof(k, "InventoryItem") then
            if isForceDropHeavyItem(k.items[1]) then
                -- corpse or generator
            elseif #k.items > 2 then
                context:addOption(getText("ContextMenu_Grab_one"), items, ISInventoryPaneContextMenu.onGrabOneItems, player);
                context:addOption(getText("ContextMenu_Grab_half"), items, ISInventoryPaneContextMenu.onGrabHalfItems, player);
                context:addOption(getText("ContextMenu_Grab_all"), items, ISInventoryPaneContextMenu.onGrabItems, player);
            else
                context:addOption(getText("ContextMenu_Grab"), items, ISInventoryPaneContextMenu.onGrabItems, player);
            end
            break;
        elseif isForceDropHeavyItem(k) then
            -- corpse or generator
        else
            context:addOption(getText("ContextMenu_Grab"), items, ISInventoryPaneContextMenu.onGrabItems, player);
            break;
        end
    end
end

function ISInventoryPaneContextMenu.doEvorecipeMenu(context, items, player, evorecipe, baseItem, containerList)
    for i=0,evorecipe:size()-1 do
        local listOfAddedItems = {};
        local evorecipe2 = evorecipe:get(i);
        local items = evorecipe2:getItemsCanBeUse(getSpecificPlayer(player), baseItem, containerList);
        if items:size() == 0 then
            break;
        end
        -- check for every item category to add a "add random category" in top of the list
        local catList = ISInventoryPaneContextMenu.getEvoItemCategories(items, evorecipe2);
        local cookingLvl = getSpecificPlayer(player):getPerkLevel(Perks.Cooking);
        local subOption = nil;
        local fromName = getText("ContextMenu_EvolvedRecipe_" .. evorecipe2:getUntranslatedName())
        if evorecipe2:isResultItem(baseItem) then
            subOption = context:addOption(fromName, nil);
        else
            subOption = context:addOption(getText("ContextMenu_Create_From_Ingredient", fromName), nil);
        end
        local subMenuRecipe = context:getNew(context);
        context:addSubMenu(subOption, subMenuRecipe);
        
        for i,v in pairs(catList) do
            if getText("ContextMenu_FoodType_"..i) ~= "ContextMenu_FoodType_"..i then
                local txt = getText("ContextMenu_FromRandom", getText("ContextMenu_FoodType_"..i));
                if evorecipe2:isResultItem(baseItem) then
                    txt = getText("ContextMenu_AddRandom", getText("ContextMenu_FoodType_"..i));
                end
                subMenuRecipe:addOption(txt, evorecipe2, ISInventoryPaneContextMenu.onAddItemInEvoRecipe, baseItem, catList[i][ZombRand(1, #catList[i]+1)], player);
            end
        end
        for i=0,items:size() -1 do
            local evoItem = items:get(i);
            local extraInfo = "";
			-- for disabling poison for servers
			if SandboxVars.EnablePoisoning == 2 then disablePoison = true end;
            if instanceof(evoItem, "Food") then
                if evoItem:isSpice() then
                    extraInfo = getText("ContextMenu_EvolvedRecipe_Spice");
                elseif evoItem:getPoisonLevelForRecipe() then
                    if evoItem:getHerbalistType() and evoItem:getHerbalistType() ~= "" and getSpecificPlayer(player):isRecipeActuallyKnown("Herbalist") then
                        extraInfo = getText("ContextMenu_EvolvedRecipe_Poison");
                    end
                    local use = ISInventoryPaneContextMenu.getRealEvolvedItemUse(evoItem, evorecipe2, cookingLvl);
                    if use then
                        extraInfo = extraInfo .. "(" .. use .. ")";
                    end
                elseif not evoItem:isPoison() then
                    local use = ISInventoryPaneContextMenu.getRealEvolvedItemUse(evoItem, evorecipe2, cookingLvl);
                    extraInfo = "(" .. use .. ")";
                    if listOfAddedItems[evoItem:getType()] and listOfAddedItems[evoItem:getType()] == use then
                        evoItem = nil;
                    else
                        listOfAddedItems[evoItem:getType()] = use;
                    end
                end				
				-- addition to disable bleach griefing in MP
				if SandboxVars.EnablePoisoning == 3 and evoItem and evoItem:getType() == "Bleach" then
					disablePoison = true;
				end
				-- for disabling poison for servers
				if evoItem and evoItem:isPoison() and disablePoison then
					evoItem = nil;
				end
            end
            if evoItem then
                if baseItem:getFullType() == "Base.Chum" then
                    extraInfo = ""
                end
                ISInventoryPaneContextMenu.addItemInEvoRecipe(subMenuRecipe, baseItem, evoItem, extraInfo, evorecipe2, player);
            end
        end
    end
end

ISInventoryPaneContextMenu.doMakeUpMenu = function(context, makeup, playerObj)
    local option = context:addOption(getText("IGUI_MakeUp"), makeup, ISInventoryPaneContextMenu.onMakeUp, playerObj);
    local mirror = false;

    -- check for mirror in inventory
    if playerObj:getInventory():contains("Mirror") or (playerObj:getVehicle() ~= nil) or playerObj:getInventory():contains("Base.MakeupFoundation") or makeup:getFullType() == "Base.MakeupFoundation" then
        mirror = true;
    end
     
    -- check for world mirror
    if not mirror then
        for x=playerObj:getCurrentSquare():getX() - 1, playerObj:getCurrentSquare():getX() + 2 do
            for y=playerObj:getCurrentSquare():getY() - 1, playerObj:getCurrentSquare():getY() + 2 do
                local sq = getCell():getGridSquare(x, y, playerObj:getCurrentSquare():getZ())
                if sq then
                    for i=0, sq:getObjects():size() - 1 do
                        local object = sq:getObjects():get(i);
                        local sprite = object:getSprite();
                        if not sq:isWallTo(playerObj:getCurrentSquare()) and sprite:getProperties():Is("IsMirror") then
                            mirror = true;
                            break;
                        end
                        if object:getAttachedAnimSprite() then
                            for j=0,object:getAttachedAnimSprite():size() - 1 do
                                local sprite = object:getAttachedAnimSprite():get(j):getParentSprite();
                                if not sq:isWallTo(playerObj:getCurrentSquare()) and sprite:getProperties():Is("IsMirror") then
                                    mirror = true;
                                    break;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    
    if not mirror then
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        option.notAvailable = true;
        tooltip.description = getText("Tooltip_NeedMirror");
        option.toolTip = tooltip;
    end
end

local function getWornItemInLocation(playerObj, location)
    local wornItems = playerObj:getWornItems()
    local bodyLocationGroup = wornItems:getBodyLocationGroup()
    for i=1,wornItems:size() do
        local wornItem = wornItems:get(i-1)
        if (wornItem:getLocation() == location) or bodyLocationGroup:isExclusive(wornItem:getLocation(), location) then
            return wornItem:getItem()
        end
    end
    return nil
end

function ISInventoryPaneContextMenu.getItemInstance(type)
    local self = ISInventoryPaneContextMenu
    if not self.ItemInstances then self.ItemInstances = {} end
    local item = self.ItemInstances[type]
    if not item then
        item = instanceItem(type)
        if item then
            self.ItemInstances[type] = item
            self.ItemInstances[item:getFullType()] = item
        end
    end
    return item
end

ISInventoryPaneContextMenu.doClothingItemExtraMenu = function(context, clothingItemExtra, playerObj)
    if (clothingItemExtra:IsClothing() or clothingItemExtra:IsInventoryContainer()) and clothingItemExtra:getClothingExtraSubmenu() then
        local option = context:addOption(getText("ContextMenu_Wear"));
        local subMenu = context:getNew(context);
        context:addSubMenu(option, subMenu);
        context = subMenu;

        local location = clothingItemExtra:IsClothing() and clothingItemExtra:getBodyLocation() or clothingItemExtra:canBeEquipped()
        local existingItem = getWornItemInLocation(playerObj, location)
        if existingItem ~= clothingItemExtra then
            local text = getText("ContextMenu_" .. clothingItemExtra:getClothingExtraSubmenu());
            local option = context:addOption(text, clothingItemExtra, ISInventoryPaneContextMenu.onClothingItemExtra, clothingItemExtra:getFullType(), playerObj);
            ISInventoryPaneContextMenu.doWearClothingTooltip(playerObj, clothingItemExtra, clothingItemExtra, option);
        end
    end

    for i=0,clothingItemExtra:getClothingItemExtraOption():size()-1 do
        local text = getText("ContextMenu_" .. clothingItemExtra:getClothingItemExtraOption():get(i));
        local itemType = moduleDotType(clothingItemExtra:getModule(), clothingItemExtra:getClothingItemExtra():get(i));
        local item = ISInventoryPaneContextMenu.getItemInstance(itemType);
        local option = context:addOption(text, clothingItemExtra, ISInventoryPaneContextMenu.onClothingItemExtra, itemType, playerObj);
        ISInventoryPaneContextMenu.doWearClothingTooltip(playerObj, item, clothingItemExtra, option);
    end
end

ISInventoryPaneContextMenu.onClothingItemExtra = function(item, extra, playerObj)
    if item:getBodyLocation() == "Hat" or item:getBodyLocation() == "FullHat" then
        local wornItems = playerObj:getWornItems()
        for j=1,wornItems:size() do
            local wornItem = wornItems:get(j-1)
            if (wornItem:getLocation() == "SweaterHat" or wornItem:getLocation() == "JacketHat") then
                for i=0, wornItem:getItem():getClothingItemExtraOption():size()-1 do
                    if wornItem:getItem():getClothingItemExtraOption():get(i) == "DownHoodie" then
                        ISInventoryPaneContextMenu.onClothingItemExtra(wornItem:getItem(), wornItem:getItem():getClothingItemExtra():get(i), playerObj);
                    end
                end
            end
        end
    end
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
    ISTimedActionQueue.add(ISClothingExtraAction:new(playerObj, item, extra))
end

ISInventoryPaneContextMenu.doPlace3DItemOption = function(items, player, context)
    if player:getVehicle() then return end
    local all3D = true;
    local noFavourites = true;
    items = ISInventoryPane.getActualItems(items)
    for _,item in ipairs(items) do
        if not item:getWorldStaticItem() and not instanceof(item, "HandWeapon") and not instanceof(item, "Clothing") then
            all3D = false;
        end

		if item:getType() == "CarBatteryCharger" then
			all3D = false
		end
		
        if all3D and instanceof(item, "Clothing") then
            all3D = item:canBe3DRender();
        end
        if(item:isFavorite()) then
            noFavourites = false;
        end
    end
    if all3D then
             local placeOption = context:addOption(getText("ContextMenu_PlaceItemOnGround"), items, ISInventoryPaneContextMenu.onPlaceItemOnGround, player);
              if (noFavourites == false) then
                  placeOption.notAvailable = true;
                  local tooltip = ISInventoryPaneContextMenu.addToolTip();
                  tooltip.description = getText("Tooltip_CantPlaceFavoriteItems");
                  placeOption.toolTip = tooltip;
              end
        local testItem = items[1];
        if testItem and #items > 1 and (testItem:getContainer() ~= player:getInventory()) then
            placeOption.onSelect = nil
            local subMenu = context:getNew(context);
            context:addSubMenu(placeOption, subMenu);
            subMenu:addOption(getText("ContextMenu_PlaceOne"), {items[1]}, ISInventoryPaneContextMenu.onPlaceItemOnGround, player);
            if #items > 2 then
                subMenu:addOption(getText("ContextMenu_PlaceHalf"), {unpack(items, 1, math.ceil(#items / 2))}, ISInventoryPaneContextMenu.onPlaceItemOnGround, player);
            end;
            subMenu:addOption(getText("ContextMenu_PlaceAll"), items, ISInventoryPaneContextMenu.onPlaceItemOnGround, player);
        end;
    end
end

ISInventoryPaneContextMenu.onPlaceItemOnGround = function(items, playerObj)
    local playerNum = playerObj:getPlayerNum()
    local inventoryUI = getPlayerInventory(playerNum)
    local lootUI = getPlayerLoot(playerNum)
    if playerObj:getJoypadBind() ~= -1 and inventoryUI:isVisible() then
        updateJoypadFocus(JoypadState.players[playerNum+1])
        setJoypadFocus(playerNum, nil)
    end
    if inventoryUI:isVisible() and not inventoryUI.isCollapsed and not inventoryUI.pin then
        inventoryUI.isCollapsed = true
        inventoryUI:setMaxDrawHeight(inventoryUI:titleBarHeight())
    end
    if lootUI:isVisible() and not lootUI.isCollapsed and not lootUI.pin then
        lootUI.isCollapsed = true
        lootUI:setMaxDrawHeight(lootUI:titleBarHeight())
    end
    ISInventoryPaneContextMenu.placeItemCursor = ISPlace3DItemCursor:new(playerObj, items)
    getCell():setDrag(ISInventoryPaneContextMenu.placeItemCursor, playerNum)
end

ISInventoryPaneContextMenu.AutoDrinkOn = function( waterContainer )
	getCore():setOptionAutoDrink(true)
	getCore():saveOptions()
end

ISInventoryPaneContextMenu.AutoDrinkOff = function( waterContainer )
	getCore():setOptionAutoDrink(false)
	getCore():saveOptions()
end

ISInventoryPaneContextMenu.hasOpenFlame = function( playerObj )
    local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
    for i=1,containers:size() do
        local container = containers:get(i-1)
        local parent = container:getParent()
        if parent then
            local campfire
            local square = parent:getSquare()
            if square then campfire = CCampfireSystem.instance:getLuaObjectOnSquare(parent:getSquare()) end
            if campfire then
                if campfire.isLit then return parent end
            end
            if (instanceof(parent,'IsoFireplace') or instanceof(parent,'IsoBarbecue')) and parent:isLit() then
                return parent
            end
            if instanceof(parent,'IsoStove') and parent:Activated() and not parent:isMicrowave()
            and not (parent:getProperties():Val("GroupName") == "Coffee") and not (parent:getProperties():Val("GroupName") == "Espresso") and not (parent:getProperties():Val("GroupName") == "Fryers Club") then
                return parent
            end
        end
    end
    return playerObj:getSquare():hasAdjacentFireObject()
end

ISInventoryPaneContextMenu.getEatingMask = function( playerObj, removeMask )
    local mask = false
    if playerObj:getWornItem("Mask") and not playerObj:getWornItem("Mask"):hasTag("CanEat") then
        mask = playerObj:getWornItem("Mask")
    elseif  playerObj:getWornItem("MaskEyes") and not playerObj:getWornItem("MaskEyes"):hasTag("CanEat") then
        mask = playerObj:getWornItem("MaskEyes")
    elseif  playerObj:getWornItem("MaskFull") and not playerObj:getWornItem("MaskFull"):hasTag("CanEat") then
        mask = playerObj:getWornItem("MaskFull")
    elseif  playerObj:getWornItem("FullHat") and not playerObj:getWornItem("FullHat"):hasTag("CanEat") then
        mask = playerObj:getWornItem("FullHat")
    elseif  playerObj:getWornItem("FullSuitHead") and not playerObj:getWornItem("FullSuitHead"):hasTag("CanEat") then
        mask = playerObj:getWornItem("FullSuitHead")
    elseif  playerObj:getWornItem("SCBA") and not playerObj:getWornItem("SCBA"):hasTag("CanEat") then
        mask = playerObj:getWornItem("SCBA")
    elseif  playerObj:getWornItem("SCBAnotank") and not playerObj:getWornItem("SCBAnotank"):hasTag("CanEat") then
        mask = playerObj:getWornItem("SCBAnotank")
    end
    if mask and removeMask then ISTimedActionQueue.add(ISUnequipAction:new(playerObj, mask, 50)) end
    return mask
end
