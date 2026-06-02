require "ISUI/ISToolTip"
require "TimedActions/ISInventoryTransferUtil"

ISInventoryPaneContextMenu = {}
ISInventoryPaneContextMenu.tooltipPool = {}
ISInventoryPaneContextMenu.tooltipsUsed = {}
ISInventoryPaneContextMenu.ghs = "<GHC>"
ISInventoryPaneContextMenu.bhs = "<BHC>"

local MAXIMUM_RENAME_LENGTH = 28

local function predicateNotBroken(item)
	return not item:isBroken()
end

local function predicateNotEmpty(item)
	return item:getCurrentUsesFloat() > 0
end

local sortRecipes = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
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

    local context = ISContextMenu.get(player, x, y);

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
	tests.isPrintMedia = true;
	tests.canBeActivated = nil;
	tests.isAllBandage = true;
	tests.unequip = nil;
	tests.waterContainer = nil;
	tests.fluidContainer = nil;
    tests.canBeDry = nil;
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
    tests.moveable = nil;
    tests.haveLure = false;
    tests.animalCorpse = nil;
    tests.keyOrigin = nil;
    tests.scriptChecks = nil;
    tests.unwanted = nil;
    tests.researchableRecipes = nil;
    tests.usedInRecipes = nil;
    tests.inventoryItem = nil;
    tests.mediaText = nil;
    tests.radio = nil;

	-- For dropping stuff out of vehicle doors/windows.
	local vehicleTest = {}
	vehicleTest.inVehicle = nil;
	vehicleTest.hasDoor = nil;
	vehicleTest.doorOpen = nil;
	vehicleTest.hasWindow = nil;
	vehicleTest.windowOpen = nil;

    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

	ISInventoryPaneContextMenu.removeToolTip();

	getCell():setDrag(nil, player);

    for _,tooltip in ipairs(ISInventoryPaneContextMenu.tooltipsUsed) do
        table.insert(ISInventoryPaneContextMenu.tooltipPool, tooltip);
    end
    table.wipe(ISInventoryPaneContextMenu.tooltipsUsed);

    local containerList = ISInventoryPaneContextMenu.getContainers(playerObj)
    local testItem = nil;
    local editItem = nil;
    for i,v in ipairs(items) do
        testItem = v;
        if not instanceof(v, "InventoryItem") then
            if #v.items == 2 then
                editItem = v.items[1];
            end
            testItem = v.items[1];
        else
            editItem = v
        end
        if instanceof(testItem, "Key") or testItem:isItemType(ItemType.KEY_RING) or testItem:hasTag(ItemTag.KEY_RING) then
            tests.canBeRenamed = testItem;
        end
        if instanceof(testItem, "AnimalInventoryItem") then
            return AnimalContextMenu.doInventoryMenu(player, context, testItem)
        end
        if testItem:getClothingItemExtraOption() then
            tests.clothingItemExtra = testItem;
        end
        if testItem:getType() == "CorpseAnimal" then
            tests.animalCorpse = testItem;
        end
        if (isDebugEnabled() or isAdmin()) and testItem:hasOrigin() then
            tests.keyOrigin = testItem;
        end
        if testItem and testItem:getScriptItem() then tests.isUnwanted = testItem end
        local scriptItem = testItem:getScriptItem()
        if scriptItem then
            -- this is used to seeing if an item can be crafted, foraged, found as loot or not for debug purposes
            tests.scriptChecks = scriptItem
            if scriptItem:hasResearchableRecipes() then
                tests.researchableRecipes = testItem
            end
        end
        if testItem:getMediaData() and testItem:getMediaData():getTranslatedExtra() then
            tests.mediaText = testItem:getMediaData():getTranslatedExtra();
        end
        if instanceof(testItem, "InventoryItem") then
            tests.inventoryItem = testItem
        end

		if not testItem:isCanBandage() then
			tests.isAllBandage = false;
		end
        if testItem:getCategory() ~= "Food" or (testItem:getScriptItem():isCantEat() and not testItem:getScriptItem():getOpeningRecipe()) then
            tests.isAllFood = false;
        end
        if testItem:hasTag(ItemTag.IS_SEED) then
            tests.isSeed = testItem;
        end
        if testItem:hasTag(ItemTag.EQUIPPABLE) then
            tests.equippable = testItem;
        end
        if testItem:getType() == "Bleach" then
            tests.isBleach = testItem;
        end
		if testItem:getCategory() == "Clothing" then
            tests.clothing = testItem;
        end
		if testItem:hasTag(ItemTag.WEARABLE) then
            tests.canBeEquippedOther = testItem;
        end
		if (testItem:getType() == "DishCloth" or testItem:getType() == "BathTowel") and playerObj:getStats():get(CharacterStat.WETNESS) > 0 then
			tests.canBeDry = true;
        end
		if testItem:getFluidContainer() and testItem:getFluidContainer():getPrimaryFluid() and ISInventoryPaneContextMenu.startWith(testItem:getFluidContainer():getPrimaryFluid():getFluidTypeString(), "HairDye") and testItem:getFluidContainer():getAmount() >= 0.5 then
            tests.hairDye = testItem;
        end
        if testItem:getMakeUpType() then
            tests.makeup = testItem;
        end
        if testItem:getScriptItem():isItemType(ItemType.RADIO) and testItem:getDeviceData() and testItem:getDeviceData():getIsPortable() then
            tests.radio = testItem;
        end
        -- weapons cannot be fixed unless they aren't broken; broken objects needs to be reclaimed or reforged as part of crafting rework.
        if (not testItem:isBroken()) and testItem:getCondition() < testItem:getConditionMax() then
            tests.brokenObject = testItem;
        end
        if instanceof(testItem, "DrainableComboItem") then
            tests.drainable = testItem;
        end
        if testItem:isTrap() then
            tests.isTrap = testItem;
        end
        if instanceof(testItem, "Moveable") then
            tests.moveable = testItem;
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
        if testItem:hasComponent(ComponentType.ContextMenuConfig) then
            tests.componentOption = testItem;
        end
        if testItem:IsMap() then
            tests.map = testItem;
        end
        if testItem:getAnimalTracks() then
            tests.trackItem = testItem;
        end
		if not testItem:hasModData() or not testItem:getModData().printMedia then
            tests.isPrintMedia = false;
        end
		if testItem:getCategory() ~= "Literature" or testItem:canBeWrite() or testItem:hasModData() and testItem:getModData().printMedia then
            tests.isAllLiterature = false;
        end
        if testItem:getCategory() == "Literature" and testItem:canBeWrite() then
            tests.canBeWrite = testItem;
        end
		if testItem:canBeActivated() and (playerObj:isHandItem(testItem) or (playerObj:isAttachedItem(testItem) and not instanceof(testItem, "HandWeapon"))) and not testItem:hasTag(ItemTag.SCBA) then
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
		if instanceof(testItem, "InventoryContainer") and testItem:canBeEquipped() and not playerObj:isEquippedClothing(testItem) and not testItem:getClothingExtraSubmenu() then
			tests.canBeEquippedContainer = testItem;
        end
        if instanceof(testItem, "InventoryContainer") then
            tests.canBeRenamed = testItem;
        end
        if testItem:getType() == "Generator" or testItem:hasTag(ItemTag.GENERATOR) then
            tests.generator = testItem;
        end
        if testItem:getType() == "CorpseMale" or testItem:getType() == "CorpseFemale" then
            tests.corpse = testItem;
        end
        if testItem:hasTag(ItemTag.ANIMAL_CORPSE) then
            tests.corpseAnimal = testItem;
        end
        if instanceof(testItem, "AlarmClock") or instanceof(testItem, "AlarmClockClothing") then
            tests.alarmClock = testItem;
        end
        if instanceof(testItem, "Food") then -- Check if it's a recipe from the evolved recipe and have at least 3 ingredient, so we can name them
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
		if not testItem:hasTag(ItemTag.CONSUMABLE) then
            tests.isAllPills = false;
        elseif  not instanceof(testItem, "DrainableComboItem") then
            tests.isAllPills = false;
        end
        if testItem:isWaterSource() then
            tests.waterContainer = testItem;
		elseif testItem:getFluidContainer() and not testItem:getFluidContainer():isMultiTileMoveable() then
            tests.fluidContainer = testItem;
        end

        -- IsoWorldInventoryObject
        local worldItem = testItem:getWorldItem()
        if worldItem ~= nil and worldItem:getFluidContainer() ~= nil and not worldItem:getFluidContainer():isMultiTileMoveable() then
            if worldItem:getFluidContainer():isWaterSource() then
                tests.waterContainer = worldItem;
            else
                tests.fluidContainer = worldItem;
            end
        end
        
        if testItem:hasTag(ItemTag.FISHING_ROD) then
            tests.fishingRod = testItem
            tests.haveLure = tests.fishingRod:getModData().fishing_Lure ~= nil
        end
        if not instanceof(testItem, "Literature") and ISInventoryPaneContextMenu.canReplaceStoreWater(testItem) then
            tests.pourOnGround = testItem
        end
        if not testItem:isNoRecipes(playerObj) then tests.evorecipe = RecipeManager.getEvolvedRecipe(testItem, playerObj, containerList, true) end;
        if tests.evorecipe then
            tests.baseItem = testItem;
        end
        itemsCraft[c + 1] = testItem;

        c = c + 1;
        -- you can equip only 1 weapon
        if c > 1 then
            tests.isHandWeapon = nil
            tests.canBeActivated = nil;
            tests.unequip = nil;
            tests.canBeEquippedContainer = nil;
            tests.brokenObject = nil;
            tests.isPrintMedia = false;
        end

    end

	-- If a player is in a vehicle, the door or window needs to be open for them to drop items on the floor outside.
	if playerObj:getVehicle() then
		vehicleTest.inVehicle = true
		local vehicle = playerObj:getVehicle()
		local seatPart = vehicle:getSeat(playerObj)
		local doorPart = vehicle:getPassengerDoor(seatPart)
		local windowPart = VehicleUtils.getChildWindow(doorPart)
		if doorPart and doorPart:getDoor() then
			vehicleTest.hasDoor = true
			local door = doorPart:getDoor()
			if door:isOpen() then
				vehicleTest.doorOpen = true
			end
		end
		if windowPart and windowPart:getWindow() then
			vehicleTest.hasWindow = true
			window = windowPart:getWindow()
			if window:isOpen() or window:isDestroyed() then
				vehicleTest.windowOpen = true
			end
		end
	end

    triggerEvent("OnPreFillInventoryObjectContextMenu", player, context, items);

    context.blinkOption = ISInventoryPaneContextMenu.blinkOption;

    ISInventoryPaneContextMenu.doDebugContextMenu(context, items, editItem, testItem, player, playerObj, tests, c);

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

    if ((tests.clothing and not tests.clothing:isBroken()) or (tests.canBeEquippedContainer or tests.canBeEquippedOther)) and not tests.unequip then
        ISInventoryPaneContextMenu.doWearClothingMenu(player, tests.clothing or tests.canBeEquippedContainer or tests.canBeEquippedOther, items, context);
    end
    if tests.clothingItemExtra and not tests.clothingItemExtra:isBroken() then
        ISInventoryPaneContextMenu.doClothingItemExtraMenu(context, tests.clothingItemExtra, playerObj);
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
            local option = context:addOption(getText("ContextMenu_Grab_Corpse"), playerObj, ISInventoryPaneContextMenu.grabCorpseItem, tests.corpse);
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
    if tests.isWeapon and not tests.isAllFood and not tests.force2Hands and not tests.clothing then
        ISInventoryPaneContextMenu.doEquipOption(context, playerObj, tests.isWeapon, items, player);
    elseif tests.isSeed or tests.isBleach or tests.equippable then
        ISInventoryPaneContextMenu.doEquipOption(context, playerObj, tests.isSeed or tests.isBleach or tests.equippable, items, player);
    end

    if tests.waterContainer and (playerObj:getStats():get(CharacterStat.THIRST) > 0.1) then
        ISInventoryPaneContextMenu.doDrinkFluidMenu(playerObj, tests.waterContainer, context)
    elseif tests.fluidContainer and (not tests.fluidContainer:getFluidContainer():isEmpty()) then
        local fluid = tests.fluidContainer:getFluidContainer():getPrimaryFluid();
        if fluid:isCategory(FluidCategory.Beverage) or fluid:getFluidType() == FluidType.Bleach then
            ISInventoryPaneContextMenu.doDrinkFluidMenu(playerObj, tests.fluidContainer, context)
        end
    end

    local pourInto = {}

    if c == 1 then
        ISInventoryPaneContextMenu.checkConsolidate(tests.drainable, playerObj, context, pourInto);
    end

    if c == 1 and tests.pourOnGround and not tests.waterContainer then
        context:addOption(getText("ContextMenu_Pour_on_Ground"), items, ISInventoryPaneContextMenu.onDumpContents, tests.pourOnGround, player);
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
        for _,k in ipairs(foodItems) do
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
            local openingRecipe
            if foodItems[1]:getOpeningRecipe() then openingRecipe = foodItems[1]:getOpeningRecipe() end
            if openingRecipe and getScriptManager():getCraftRecipe(openingRecipe) then
                openingRecipe = getScriptManager():getCraftRecipe(openingRecipe)
            else
                openingRecipe = nil
            end
            if openingRecipe then
                local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
                local logic = HandcraftLogic.new(playerObj, nil, nil);

                logic:setContainers(containers);
                logic:setRecipeFromContextClick(openingRecipe, foodItems[1]);
                if not logic:canPerformCurrentRecipe() then
                    openingRecipe = nil
                end
            end
            if hungerNotZero > 0 or openingRecipe then
                if openingRecipe then cmd = getText("ContextMenu_OpenAndEat") end
                local eatOption = context:addOption(cmd, items, nil)
                if #foodItems >= 1 then
                    eatOption.itemForTexture = foodItems[1]
                end
                if playerObj:getMoodles():getMoodleLevel(MoodleType.FOOD_EATEN) >= 3 then
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    eatOption.notAvailable = true;
                    tooltip.description = getText("Tooltip_CantEatMore");
                    eatOption.toolTip = tooltip;
                else
                    local subMenuEat = context:getNew(context)
                    context:addSubMenu(eatOption, subMenuEat)
                    local option = subMenuEat:addOption(getText("ContextMenu_Eat_All"), items, ISInventoryPaneContextMenu.onEatItems, 1, player, openingRecipe, 100)
                    -- this it to prevent eating smaller portions of food then their hunger value allows
                    local baseHunger = (math.abs(( foodItems[1]:getBaseHunger() * 100 ) )) +.001
                    local hungerChange = (math.abs(( foodItems[1]:getHungerChange() * 100 ) )) +.001
                    if ((hungerChange >= 2 ) and ( hungerChange >= baseHunger/2 )) or openingRecipe  then
                        option = subMenuEat:addOption(getText("ContextMenu_Eat_Half"), items, ISInventoryPaneContextMenu.onEatItems, 0.5, player, openingRecipe, 50)
                    end
                    if ((hungerChange >= 4) and (hungerChange >= baseHunger/4)) or openingRecipe  then
                        option = subMenuEat:addOption(getText("ContextMenu_Eat_Quarter"), items, ISInventoryPaneContextMenu.onEatItems, 0.25, player, openingRecipe, 25)
                    end
                end
            elseif cmd ~= getText("ContextMenu_Eat") then
                ISInventoryPaneContextMenu.doEatOption(context, cmd, items, player, playerObj, foodItems);
            end
        end
    end

    if tests.isAllPills then
        local pillsItems = ISInventoryPane.getActualItems(items)
        local cmd = getText("ContextMenu_Take_pills")
        for i,k in ipairs( pillsItems) do
            if k:getCustomMenuOption() then cmd = k:getCustomMenuOption() end
        end
        ISInventoryPaneContextMenu.doPillsMenu(context, items, player, cmd)
    end

    ISHotbar.doMenuFromInventory(player, testItem, context);

    if tests.isPrintMedia then
        ISInventoryPaneContextMenu.doPrintMediaMenu(context, items, player)
    end
    if tests.isAllLiterature then
        ISInventoryPaneContextMenu.doLiteratureMenu(context, items, player)
    end

    if c == 1 and tests.mediaText then
        local option = context:addOption(getText("IGUI_media_readLabel"), player, ISInventoryPaneContextMenu.onMediaText, tests.mediaText)
        if playerObj:tooDarkToRead() then
            option.notAvailable = true
            option.toolTip = ISInventoryPaneContextMenu.addToolTip();
            option.toolTip.description = getText("ContextMenu_TooDark");
        elseif playerObj:hasTrait(CharacterTrait.ILLITERATE) then
            option.notAvailable = true
            option.toolTip = ISInventoryPaneContextMenu.addToolTip();
            option.toolTip.description = getText("ContextMenu_Illiterate");
        end
    end

    if c == 1 and tests.researchableRecipes and tests.researchableRecipes:getScriptItem() and tests.researchableRecipes:getScriptItem():getResearchableRecipes(playerObj, true):size() > 0 then
        local option = context:addOption(getText("ContextMenu_ResearchCraft"), tests.researchableRecipes, ISInventoryPaneContextMenu.onResearchRecipe, playerObj)
        option.iconTexture = getTexture("media/ui/Properties/InventoryProperty_Research.png");
        if playerObj:tooDarkToRead() then
            option.notAvailable = true
            option.toolTip = ISInventoryPaneContextMenu.addToolTip();
            option.toolTip.description = getText("IGUI_CraftingWindow_RequiresLight");
        end
    end

    if tests.canBeWrite then
        local editable = playerInv:containsTagRecurse(ItemTag.WRITE) or playerInv:containsTagRecurse(ItemTag.BLUE_PEN) or playerInv:containsTagRecurse(ItemTag.PEN) or playerInv:containsTagRecurse(ItemTag.PENCIL) or playerInv:containsTagRecurse(ItemTag.RED_PEN) or playerInv:containsTagRecurse(ItemTag.GREEN_PEN)
        if tests.canBeWrite:getLockedBy() and tests.canBeWrite:getLockedBy() ~= playerObj:getUsername() then
            editable = false
        end
        local note
        if not editable then
            note = context:addOption(getText("ContextMenu_Read_Note", tests.canBeWrite:getName()), tests.canBeWrite, ISInventoryPaneContextMenu.onWriteSomething, false, player);
        else
            note = context:addOption(getText("ContextMenu_Write_Note", tests.canBeWrite:getName()), tests.canBeWrite, ISInventoryPaneContextMenu.onWriteSomething, true, player);
        end
        note.itemForTexture = tests.canBeWrite

        -- if it's too dark you can't read or write notes
        if playerObj:tooDarkToRead() then
            note.notAvailable = true
            note.toolTip = ISInventoryPaneContextMenu.addToolTip();
            note.toolTip.description = getText("ContextMenu_TooDark");
        elseif not editable and tests.canBeWrite:isEmptyPages() then
            note.notAvailable = true;
            note.toolTip = ISInventoryPaneContextMenu.addToolTip();
            note.toolTip.description = getText("ContextMenu_EmptyNotebook");
        elseif playerObj:hasTrait(CharacterTrait.ILLITERATE) then
            note.notAvailable = true
            note.toolTip = ISInventoryPaneContextMenu.addToolTip();
            note.toolTip.description = getText("ContextMenu_Illiterate");
        end
    end
    if tests.map then
        local readMap = context:addOption(getText("ContextMenu_CheckMap"), tests.map, ISInventoryPaneContextMenu.onCheckMap, player);
        readMap.itemForTexture = tests.map
        if playerObj:tooDarkToRead() then
            readMap.notAvailable = true
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_TooDark");
            readMap.toolTip = tooltip;
        end
        local option = context:addOption(getText("ContextMenu_RenameMap"), tests.map, ISInventoryPaneContextMenu.onRenameMap, player);
        option.iconTexture = getTexture("Item_Pencil")
    end

    -- recipe dynamic context menu
    if tests.recipe ~= nil then
        ISInventoryPaneContextMenu.addNewCraftingDynamicalContextMenu(itemsCraft[1], context, tests.recipe, player, containerList);
    end

    if c == 1 and tests.scriptChecks and tests.scriptChecks:getUsedInRecipes(playerObj):size() > 0 then
        ISInventoryPaneContextMenu.doRecipeListForItem(context, getText("ContextMenu_ShowCraftRecipesUsed"), tests.scriptChecks, playerObj)
    end

    if tests.clothing and tests.clothing:getCoveredParts():size() > 0 then
        context:addOption(getText("IGUI_invpanel_Inspect"), playerObj, ISInventoryPaneContextMenu.onInspectClothing, tests.clothing);
    end

    if tests.fluidContainer or tests.waterContainer then
        ISFluidContainerMenu.createMenu(context, tests.fluidContainer, tests.waterContainer, playerObj)
    end

    local loot = getPlayerLoot(player);
	if not isInPlayerInventory then
        ISInventoryPaneContextMenu.doGrabMenu(context, items, player);
    end
    if tests.evorecipe then
        ISInventoryPaneContextMenu.doEvorecipeMenu(context, items, player, tests.evorecipe, tests.baseItem, containerList);
    end

    local addDropOption = true
    if tests.unequip and isForceDropHeavyItem(tests.unequip) then
        context:addOption(getText("ContextMenu_Drop"), items, ISInventoryPaneContextMenu.onDropItems, player);
        addDropOption = false
    elseif tests.unequip then
        context:addOption(getText("ContextMenu_Unequip"), items, ISInventoryPaneContextMenu.onUnEquip, player);
    end

    -- Modified to block the option if a player is in a vehicle with closed doors & windows.
    if isInPlayerInventory and addDropOption and playerObj:getJoypadBind() == -1 and not ISInventoryPaneContextMenu.isAllFav(items) then
        local drop = context:addOption(getText("ContextMenu_Drop"), items, ISInventoryPaneContextMenu.onDropItems, player);
        if vehicleTest.inVehicle then
            if vehicleTest.hasDoor and not vehicleTest.doorOpen then
                if vehicleTest.hasWindow and not vehicleTest.windowOpen then
                    drop.notAvailable = true
                    local tooltip = ISInventoryPaneContextMenu.addToolTip();
                    tooltip.description = getText("ContextMenu_DropFromVehicle");
                    drop.toolTip = tooltip;
                end
            end
        end
    end

    -- Move To
    local moveItems = ISInventoryPane.getActualItems(items)
    if #moveItems > 0 and playerObj:getJoypadBind() ~= -1 then
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
        local moveTo4 = ISInventoryPaneContextMenu.canMoveTo(moveItems, ISInventoryPage.GetFloorContainer(player), player)
        local keyRings = {}
        local inventoryItems = playerObj:getInventory():getItems()
        for i=1,inventoryItems:size() do
            local item = inventoryItems:get(i-1)
            if (item:getType() == "KeyRing" or item:hasTag(ItemTag.KEY_RING)) and ISInventoryPaneContextMenu.canMoveTo(moveItems, item, player) then
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

    if not tests.inPlayerInv and playerObj:getJoypadBind() ~= -1 then
        if loot.controlsUI then
            loot.controlsUI:handleJoypadContextMenu(context)
        end
    end

    if tests.trackItem then
        context:addOption(getText("ContextMenu_InspectTrack"), playerObj, ISInventoryPaneContextMenu.onInspectTrack, tests.trackItem);
    end
    -- weapon upgrades
    tests.isWeapon = tests.isHandWeapon -- to allow upgrading broken weapons
    if tests.isWeapon and instanceof(tests.isWeapon, "HandWeapon") then
        local isWeapon = tests.isWeapon
        -- add parts
        local weaponParts = getSpecificPlayer(player):getInventory():getItemsFromCategory("WeaponPart");
        if weaponParts and not weaponParts:isEmpty() then
            local subMenuUp = context:getNew(context);
            local doIt = false;
            local alreadyDoneList = {};
            for i=0, weaponParts:size() - 1 do
                local part = weaponParts:get(i);
                if not part:isBroken() and not alreadyDoneList[part:getName()] and part:canAttach(getSpecificPlayer(player), isWeapon) and not isWeapon:getWeaponPart(part:getPartType()) then
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
        weaponParts = isWeapon:getDetachableWeaponParts(getSpecificPlayer(player)) -- checks canDetach for all parts
        if weaponParts:size() > 0 then
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
        local option = context:addOption(getText("ContextMenu_Place_Trap"), tests.isTrap, ISTrapMenu.onPlaceTrap, tests.isTrap, playerObj);
        option.iconTexture = tests.isTrap:getTex();
    end

    if tests.moveable then
        ISMoveableContextMenu.createMenu(context, tests.moveable, playerObj);
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
    
    if tests.clothing and tests.clothing:getWetness() > 15 then
        context:addOption(getText("ContextMenu_WringClothes"), items, ISInventoryPaneContextMenu.onWringClothing, player)    
    end

    if tests.fishingRod ~= nil then
        ISInventoryPaneContextMenu.addFishRodOptions(tests.fishingRod, tests.haveLure, context, player)
    end

	if tests.canBeActivated ~= nil and (not instanceof(tests.canBeActivated, "Drainable") or tests.canBeActivated:getCurrentUsesFloat() > 0) then
        if (tests.canBeActivated:getType() ~= "CandleLit") and (tests.canBeActivated:getType() ~= "Lantern_HurricaneLit") and not tests.canBeActivated:hasTag(ItemTag.LIT_LANTERN) then
            local txt = getText("ContextMenu_Turn_On");
            if tests.canBeActivated:isActivated() then
                txt = getText("ContextMenu_Turn_Off");
            end
            local option = context:addOption(txt, tests.canBeActivated, ISInventoryPaneContextMenu.onActivateItem, player);
            if instanceof(tests.canBeActivated, "Clothing") and tests.canBeActivated:getUsedDelta() == 0 then
                option.notAvailable = true;
                option.toolTip = ISInventoryPaneContextMenu.addToolTip();
                option.toolTip.description = getText("Tooltip_IsEmpty");
            end
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
    if tests.radio and (playerObj:getPrimaryHandItem() == tests.radio or playerObj:getSecondaryHandItem() == tests.radio or playerObj:getClothingItem_Back() == tests.radio) then
        local option = context:addOption(getText("IGUI_DeviceOptions"), playerObj, ISRadioAndTvMenu.openRadioPanel, tests.radio);
        option.itemForTexture = tests.radio;
    end

    ISInventoryPaneContextMenu.doPlace3DItemOption(items, playerObj, context)

    if tests.brokenObject then
        local fixingList = FixingManager.getFixes(tests.brokenObject);
        if not fixingList:isEmpty() then
            local fixOption = context:addOption(getText("ContextMenu_Repair") .. (" ") .. getItemNameFromFullType(tests.brokenObject:getFullType()), items, nil);
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

	if tests.componentOption then
		ISInventoryPaneContextMenu.doContextConfigOptions(context, tests.componentOption, playerObj);
    end

    if(isInPlayerInventory and loot.inventory ~= nil and loot.inventory:getType() ~= "floor" ) and playerObj:getJoypadBind() == -1 then
        if ISInventoryPaneContextMenu.isAnyAllowed(loot.inventory, items) and not ISInventoryPaneContextMenu.isAllFav(items) then
            local label = loot.title and getText("ContextMenu_PutInContainer", loot.title) or getText("ContextMenu_Put_in_Container")
            context:addOption(label, items, ISInventoryPaneContextMenu.onPutItems, player);
        end
    end

    ISInventoryPaneContextMenu.doMoreContextMenu(context, tests, moveItems, playerObj, items, c);

    -- use the event (as you would 'OnTick' etc) to add items to context menu without mod conflicts.
    triggerEvent("OnFillInventoryObjectContextMenu", player, context, items);

    return context;
end

ISInventoryPaneContextMenu.createMenuNoItems = function(playerNum, isLoot, x, y)
    if ISInventoryPaneContextMenu.dontCreateMenu then return end

    if isGamePaused() then return end

    local playerObj = getSpecificPlayer(playerNum)
    
    local loot = getPlayerLoot(playerNum)

    local context = ISContextMenu.get(playerNum, x, y)

    triggerEvent("OnPreFillInventoryContextMenuNoItems", playerNum, context, isLoot)

    if isLoot and playerObj:getJoypadBind() ~= -1 then
        if loot.controlsUI then
            loot.controlsUI:handleJoypadContextMenu(context)
        end
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

function ISInventoryPaneContextMenu.doPrintMediaMenu(context, items, player)
	local playerObj = getSpecificPlayer(player)
    if playerObj:tooDarkToRead() then
        local nope = context:addOption(getText("ContextMenu_Inspect"))
        nope.notAvailable = true
        local tooltip = ISInventoryPaneContextMenu.addToolTip()
        tooltip.description = getText("ContextMenu_TooDarkToInspect")
        nope.toolTip = tooltip
        return
    end
    local readOption = context:addOption(getText("ContextMenu_Inspect"), items, ISInventoryPaneContextMenu.onLiteratureItems, player)
	local actualItems = ISInventoryPane.getActualItems(items)
    if #actualItems == 1 then
        readOption.itemForTexture = actualItems[1]
    end
    if playerObj:isAsleep() then
        readOption.notAvailable = true;
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("ContextMenu_NoOptionSleeping");
        readOption.toolTip = tooltip;
    end
end

function ISInventoryPaneContextMenu.doLiteratureMenu(context, items, player)
	local playerObj = getSpecificPlayer(player)
	local actualItems = ISInventoryPane.getActualUniqueItems(items)
	local picture =  false
	local picturebook = false
	local recentlyRead = false
	local uninteresting = false
	local recipeItem = false
    local canBeRead = true
	for i,k in ipairs(actualItems) do
        if playerObj:tooDarkToRead() then
            local nopeText = getText("ContextMenu_Read")
            local darkText = getText("ContextMenu_TooDark")
            if (playerObj:hasTrait(CharacterTrait.ILLITERATE) and (k:hasTag(ItemTag.PICTUREBOOK)) or k:hasTag(ItemTag.PICTURE)) then
                nopeText = getText("ContextMenu_Look_at_pictures")
                darkText = getText("ContextMenu_TooDarkToSee")
            end
            local nope = context:addOption(nopeText)
            nope.notAvailable = true
            local tooltip = ISInventoryPaneContextMenu.addToolTip()
            tooltip.description = darkText
            nope.toolTip = tooltip
            return
        end
        if playerObj:hasTrait(CharacterTrait.ILLITERATE) and (not k:hasTag(ItemTag.PICTUREBOOK) and not k:hasTag(ItemTag.PICTURE)) then
            local nope = context:addOption(getText("ContextMenu_Read"));
            nope.notAvailable = true
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_Illiterate");
            nope.toolTip = tooltip;
            canBeRead = false
		elseif k:getLvlSkillTrained() ~= -1 and SkillBook[k:getSkillTrained()].perk and	k:getLvlSkillTrained() > playerObj:getPerkLevel(SkillBook[k:getSkillTrained()].perk) + 1 then
			local nope = context:addOption(getText("ContextMenu_Read"));	
			nope.notAvailable = true
			local tooltip = ISInventoryPaneContextMenu.addToolTip();
			tooltip.description = getText("ContextMenu_TooComplicated");
			nope.toolTip = tooltip;
            canBeRead = false
		elseif k:getMaxLevelTrained() ~= -1 and SkillBook[k:getSkillTrained()].perk and	k:getMaxLevelTrained() <= playerObj:getPerkLevel(SkillBook[k:getSkillTrained()].perk) then
			local nope = context:addOption(getText("ContextMenu_Read"));
			nope.notAvailable = true
			local tooltip = ISInventoryPaneContextMenu.addToolTip();
			tooltip.description = getText("ContextMenu_TooSimple");
			nope.toolTip = tooltip;
            canBeRead = false
		end
		if k:hasTag(ItemTag.PICTURE) then picture = true end
		if k:hasTag(ItemTag.PICTUREBOOK) then picturebook = true end
		if k:hasTag(ItemTag.UNINTERESTING) then uninteresting = true end
		if k:getModData().literatureTitle and playerObj:isLiteratureRead(k:getModData().literatureTitle) then recentlyRead = true end

        if #actualItems == 1 and k:getLearnedRecipes() and k:getLearnedRecipes():size() > 0 then
            recipeItem = k
        end
    end
    local readOption
    if canBeRead then
        if playerObj:hasTrait(CharacterTrait.ILLITERATE) and picturebook and not recentlyRead then
            readOption = context:addOption(getText("ContextMenu_Look_at_pictures"), items, ISInventoryPaneContextMenu.onLiteratureItems, player);
        elseif playerObj:hasTrait(CharacterTrait.ILLITERATE) and picturebook and recentlyRead then
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
            if #actualItems == 1 then
                readOption.itemForTexture = actualItems[1]
            end
            if uninteresting then
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                tooltip.description = getText("ContextMenu_EmptyNotebook");
                readOption.toolTip = tooltip;
                readOption.notAvailable = true;
            end
        end
    end
    if playerObj:isAsleep() then
        readOption.notAvailable = true;
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("ContextMenu_NoOptionSleeping");
        readOption.toolTip = tooltip;
    end
    if recipeItem then
        local canRead = (recipeItem:hasTag(ItemTag.PICTUREBOOK) or recipeItem:hasTag(ItemTag.PICTURE) or not playerObj:hasTrait(CharacterTrait.ILLITERATE))
        local SeeARecipe = getSandboxOptions():getOptionByName("SeeNotLearntRecipe"):getValue() == true or recipeItem:getKnownRecipes(playerObj):size() > 0
        if canRead and SeeARecipe then
            local text = getText("ContextMenu_ShowKnownRecipes")
            local recipeList
            if getSandboxOptions():getOptionByName("SeeNotLearntRecipe"):getValue() == true then
                recipeList = recipeItem:getLearnedRecipes()
                text = getText("ContextMenu_ShowRecipes")
            else recipeList = recipeItem:getKnownRecipes(playerObj) end
            ISInventoryPaneContextMenu.doRecipeList(context, text, recipeItem, recipeList, playerObj, true)
        end
    end
end

function ISInventoryPaneContextMenu.doPillsMenu(context, items, player, cmd)
	local playerObj = getSpecificPlayer(player)
	local actualItems = ISInventoryPane.getActualItems(items)

	local pillsOption = context:addOption(cmd, items, ISInventoryPaneContextMenu.onPillsItems, player);
	if actualItems[1] then
        pillsOption.itemForTexture = actualItems[1]
    end
    if actualItems[1] and actualItems[1]:getRequireInHandOrInventory() then
        local list = actualItems[1]:getRequireInHandOrInventory();
        local found = false;
        local required = "";
        if actualItems[1]:hasTag(ItemTag.SMOKABLE) and playerObj:getVehicle() and playerObj:getVehicle():canLightSmoke(playerObj) then found = true end
        if actualItems[1]:hasTag(ItemTag.SMOKABLE) and not found then
           found = ISInventoryPaneContextMenu.hasOpenFlame(playerObj)
        end
        if not found then
            for i=0,list:size()-1 do
                local fullType = moduleDotType(actualItems[1]:getModule(), list:get(i))
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
            pillsOption.notAvailable = true
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_Require", required);
            pillsOption.toolTip = tooltip;
        end
    end
end

function ISInventoryPaneContextMenu.showGrowingSeasons(playerObj)
    ISPlayerData[playerObj:getPlayerNum()+1].characterInfo.charScreen:onShowLiterature()
    ISPlayerData[playerObj:getPlayerNum()+1].characterInfo.charScreen.literatureUI.tabs:activateView("Agriculture")
end

function ISInventoryPaneContextMenu.doRecipeList(context, text, recipeItem, recipes, playerObj, isLiterature)
    local usedOption = context:addOption(text, recipeItem, nil);
    if isLiterature and playerObj:tooDarkToRead() then
        usedOption.notAvailable = true
        local tooltip = ISInventoryPaneContextMenu.addToolTip();
        tooltip.description = getText("ContextMenu_TooDark");
        usedOption.toolTip = tooltip;
        return;
    end
    local usedMenu =  ISContextMenu:getNew(context)
    context:addSubMenu(usedOption, usedMenu)
    local favRecipeList = {}
    local otherRecipeList = {}
    local badRecipeList = {}
    for i=0, recipes:size()-1 do
        local recipe = recipes:get(i)
        local craftRecipe = getScriptManager():getCraftRecipe(recipe)
        local buildRecipe = getScriptManager():getBuildableRecipe(recipe)
        if craftRecipe then
            if craftRecipe:isFavourite(playerObj) then
                table.insert(favRecipeList, recipe)
            elseif (craftRecipe:characterHasRequiredSkills(playerObj) or craftRecipe:couldBenefitFromRecipeAtHand(playerObj))
            and (playerObj:isRecipeActuallyKnown(craftRecipe) or not craftRecipe:needToBeLearn()) then
                table.insert(otherRecipeList, recipe)
            else
                table.insert(badRecipeList, recipe)
            end
        elseif buildRecipe then
            if buildRecipe:isFavourite(playerObj) then
                table.insert(favRecipeList, recipe)
            elseif (buildRecipe:characterHasRequiredSkills(playerObj) or buildRecipe:couldBenefitFromRecipeAtHand(playerObj))
            and (playerObj:isRecipeActuallyKnown(buildRecipe) or not buildRecipe:needToBeLearn()) then
                table.insert(otherRecipeList, recipe)
            else
                table.insert(badRecipeList, recipe)
            end
        else
            if playerObj:isRecipeActuallyKnown(recipes:get(i)) then
                table.insert(otherRecipeList, recipes:get(i))
            else
                table.insert(badRecipeList, recipe)
            end
        end
    end
    table.sort(favRecipeList, function(a, b) return string.sort(Translator.getRecipeName(b), Translator.getRecipeName(a)) end);
    table.sort(otherRecipeList, function(a, b) return string.sort(Translator.getRecipeName(b), Translator.getRecipeName(a)) end);
    table.sort(badRecipeList, function(a, b) return string.sort(Translator.getRecipeName(b), Translator.getRecipeName(a)) end);

    for i, v in pairs(favRecipeList) do
        local subOption
        local buildRecipe = getScriptManager():getBuildableRecipe(v)
        local craftRecipe = getScriptManager():getCraftRecipe(v)
        if buildRecipe then
            subOption = usedMenu:addOption(Translator.getRecipeName(v), playerObj, ISEntityUI.OpenBuildWindow, nil, "*", false, buildRecipe )
        elseif craftRecipe then
            subOption = usedMenu:addOption(Translator.getRecipeName(v), playerObj, ISEntityUI.OpenHandcraftWindow, nil, "*", false, craftRecipe )
        end
        if subOption and getRecipeIcon(v) then
             subOption.iconTexture = getRecipeIcon(v)
        end
        subOption.goodColor = true
    end

    for i, v in pairs(otherRecipeList) do
        local subOption
        local buildRecipe = getScriptManager():getBuildableRecipe(v)
        local craftRecipe = getScriptManager():getCraftRecipe(v)
        if buildRecipe then
            subOption = usedMenu:addOption(Translator.getRecipeName(v), playerObj, ISEntityUI.OpenBuildWindow, nil, "*", false, buildRecipe )
        elseif craftRecipe then
            subOption = usedMenu:addOption(Translator.getRecipeName(v), playerObj, ISEntityUI.OpenHandcraftWindow, nil, "*", false, craftRecipe )
        elseif doesSeasonRecipeExist(v) then
            subOption = usedMenu:addOption(Translator.getRecipeName(v), playerObj, ISInventoryPaneContextMenu.showGrowingSeasons)
        elseif doesMiscRecipeExist(v) then
            subOption =  usedMenu:addOption(getText(Translator.getRecipeName(v)))
            if ISLiteratureUI.miscRecipes[v] and ISLiteratureUI.miscRecipes[v].tooltip then
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                tooltip.description = getText(ISLiteratureUI.miscRecipes[v].tooltip);
                subOption.toolTip = tooltip;
            end
        end
        if subOption and getRecipeIcon(v) then
             subOption.iconTexture = getRecipeIcon(v)
        end
    end

    for i, v in pairs(badRecipeList) do
        local subOption
        local buildRecipe = getScriptManager():getBuildableRecipe(v)
        local craftRecipe = getScriptManager():getCraftRecipe(v)
        if buildRecipe then
            subOption = usedMenu:addOption(Translator.getRecipeName(v), playerObj, ISEntityUI.OpenBuildWindow, nil, "*", false, buildRecipe )
            subOption.badColor = true
        elseif craftRecipe then
            subOption = usedMenu:addOption(Translator.getRecipeName(v), playerObj, ISEntityUI.OpenHandcraftWindow, nil, "*", false, craftRecipe )
            subOption.badColor = true
        elseif doesSeasonRecipeExist(v) then
            subOption = usedMenu:addOption(Translator.getRecipeName(v), playerObj, ISInventoryPaneContextMenu.showGrowingSeasons)
            subOption.badColor = true
        elseif doesMiscRecipeExist(v) then
            subOption =  usedMenu:addOption(getText(Translator.getRecipeName(v)))
            if ISLiteratureUI.miscRecipes[v] and ISLiteratureUI.miscRecipes[v].tooltip then
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                tooltip.description = getText(ISLiteratureUI.miscRecipes[v].tooltip);
                subOption.toolTip = tooltip;
            end
            subOption.badColor = true
        end
        if subOption and getRecipeIcon(v) then
             subOption.iconTexture = getRecipeIcon(v)
        end
    end
end

function ISInventoryPaneContextMenu.doRecipeListForItem(context, text, recipeItem, playerObj)
    local option = context:addOption(text, playerObj, ISEntityUI.OpenHandcraftWindow, nil, "*", false, nil, "!" .. recipeItem:getFullName());
    option.iconTexture = getTexture("media/ui/Sidebar/80/Carpentry_Off_80.png"):splitIcon();
end

function ISInventoryPaneContextMenu.doBuildRecipeListForItem(context, text, recipeItem, playerObj)
    context:addOption(text, playerObj, ISEntityUI.OpenBuildWindow, nil, "*", false, nil, "!" .. recipeItem:getFullName());
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
    if Fishing.ManagerInstances ~= nil and Fishing.ManagerInstances[player] ~= nil then
        if Fishing.ManagerInstances[player].state ~= Fishing.ManagerInstances[player].states["None"] then
            return
        end
    end

    local rodOption = context:addOption(fishingRod:getDisplayName());
    rodOption.itemForTexture = fishingRod;
    local subMenuRod = ISContextMenu:getNew(context);
    context:addSubMenu(rodOption, subMenuRod);

    local invItems = getSpecificPlayer(player):getInventory():getAllEvalRecurse(function(_item) return true end, ArrayList.new())

    if haveLure then
        subMenuRod:addOption(getText("ContextMenu_Remove_Bait"), player, ISInventoryPaneContextMenu.removeLure, fishingRod)
    else
        local lureItems = {}
        for i = 0, invItems:size()-1 do
            local item = invItems:get(i);
            if Fishing.IsLure(item:getFullType()) and (not instanceof(item, "Food") or not item:isCooked()) then
                table.insert(lureItems, item)
            end
        end
        if #lureItems ~= 0 then
            local option = subMenuRod:addOption(getText("ContextMenu_Add_Bait"))
            option.iconTexture = getTexture("Item_Worm")
            local subMenu = subMenuRod:getNew(subMenuRod);
            subMenuRod:addSubMenu(option, subMenu);

            local checkedLures = {}
            for _, item in ipairs(lureItems) do
                if not checkedLures[item:getFullType()] then
                    option = subMenu:addOption(item:getName(), player, ISInventoryPaneContextMenu.addLure, fishingRod, item)
                    option.itemForTexture = item;
                    checkedLures[item:getFullType()] = true
                end
            end
        end
    end

    local hooks = {}
    local lines = {}
    for i = 0, invItems:size()-1 do
        local item = invItems:get(i);
        if item:hasTag(ItemTag.FISHING_HOOK) then
            table.insert(hooks, item)
        end
        if item:hasTag(ItemTag.FISHING_LINE) then
            table.insert(lines, item)
        end
    end
    if #hooks ~= 0 then
        local option = subMenuRod:addOption(getText("ContextMenu_Change_Fishing_Hook"))
        option.iconTexture = getTexture("Item_FishHook")
        local subMenu = subMenuRod:getNew(subMenuRod);
        subMenuRod:addSubMenu(option, subMenu);

        local checkedHooks = {}
        for i, item in ipairs(hooks) do
            if not checkedHooks[item:getFullType()] then
                option = subMenu:addOption(item:getName(), player, ISInventoryPaneContextMenu.changeHook, fishingRod, item)
                option.itemForTexture = item;
                checkedHooks[item:getFullType()] = true
            end
        end
    end
    if #lines ~= 0 then
        local option = subMenuRod:addOption(getText("ContextMenu_Change_Fishing_Line"))
        option.iconTexture = getTexture("Item_FishingLine")
        local subMenu = subMenuRod:getNew(subMenuRod);
        subMenuRod:addSubMenu(option, subMenu);

        local checkedLines = {}
        for i, item in ipairs(lines) do
            if not checkedLines[item:getFullType()] then
                option = subMenu:addOption(item:getName(), player, ISInventoryPaneContextMenu.changeLine, fishingRod, item)
                option.itemForTexture = item;
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

    if not clothing:getFabricType() then
        return;
    end

    -- you need thread and needle
    local thread = playerObj:getInventory():getItemFromType("Thread", true, true) or playerObj:getInventory():getItemFromTag(ItemTag.THREAD, true, true);
    local needle = playerObj:getInventory():getItemFromType("Needle", true, true) or playerObj:getInventory():getFirstTagRecurse(ItemTag.SEWING_NEEDLE);
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
                    tooltip.description = getText("IGUI_perks_Tailoring") .. ": " .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE> <RGB:0,1,0> " .. getText("Tooltip_FullyRestore");
                else
                    tooltip.description = getText("IGUI_perks_Tailoring") .. ": " .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE> <RGB:0,1,0> " .. getText("Tooltip_ScratchDefense")  .. " +" .. Clothing.getScratchDefenseFromItem(playerObj, fabric1) .. " <LINE> " .. getText("Tooltip_BiteDefense") .. " +" .. Clothing.getBiteDefenseFromItem(playerObj, fabric1);
                end
                option.toolTip = tooltip;
            end
            if fabric2 then
                local option = subMenuPart:addOption(fabric2:getDisplayName(), playerObj, ISInventoryPaneContextMenu.repairClothing, clothing, part, fabric2, thread, needle)
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                if clothing:canFullyRestore(playerObj, part, fabric2) then
                    tooltip.description = getText("IGUI_perks_Tailoring") .. ": " .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE> <RGB:0,1,0> " .. getText("Tooltip_FullyRestore");
                else
                    tooltip.description = getText("IGUI_perks_Tailoring") .. ": " .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE>  <RGB:0,1,0> " .. getText("Tooltip_ScratchDefense")  .. " +" .. Clothing.getScratchDefenseFromItem(playerObj, fabric2) .. " <LINE> " .. getText("Tooltip_BiteDefense") .. " +" .. Clothing.getBiteDefenseFromItem(playerObj, fabric2);
                end
                option.toolTip = tooltip;
            end
            if fabric3 then
                local option = subMenuPart:addOption(fabric3:getDisplayName(), playerObj, ISInventoryPaneContextMenu.repairClothing, clothing, part, fabric3, thread, needle)
                local tooltip = ISInventoryPaneContextMenu.addToolTip();
                if clothing:canFullyRestore(playerObj, part, fabric3) then
                    tooltip.description = getText("IGUI_perks_Tailoring") .. ": " .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE> <RGB:0,1,0> " .. getText("Tooltip_FullyRestore");
                else
                    tooltip.description = getText("IGUI_perks_Tailoring") .. ": " .. playerObj:getPerkLevel(Perks.Tailoring) .. " <LINE>  <RGB:0,1,0> " .. getText("Tooltip_ScratchDefense")  .. " +" .. Clothing.getScratchDefenseFromItem(playerObj, fabric3) .. " <LINE> " .. getText("Tooltip_BiteDefense") .. " +" .. Clothing.getBiteDefenseFromItem(playerObj, fabric3);
                end
                option.toolTip = tooltip;
            end
        end
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

		if (newItem:getBodyLocation() and newItem:getBodyLocation() == wornItem:getLocation()) or (newItem:canBeEquipped() and newItem:canBeEquipped() == wornItem:getLocation()) or (location ~= nil and bodyLocationGroup:isExclusive(location, wornItem:getLocation())) then
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
    local item = ISInventoryPane.getActualItems(items)[1];
    if item then
        option.iconTexture = item:getTex():splitIcon();
        option.color = { r = item:getColor():getR(), g = item:getColor():getG(), b = item:getColor():getB()}
    end
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
    if "Burst" == newfiremode then
        weapon:setAmmoPerShoot(3);
    end
end

ISInventoryPaneContextMenu.doReloadMenuForBullets = function(playerObj, bullet, context)
    for i=0, playerObj:getInventory():getItems():size()-1 do
        -- test magazines
        local item = playerObj:getInventory():getItems():get(i);
        local ammoType = item:getAmmoType();
        if ammoType then
            local itemKey = ammoType:getItemKey();
            if not instanceof(item, "HandWeapon") and itemKey == bullet:getFullType() then
            if item:getCurrentAmmoCount() < item:getMaxAmmo() then
                local ammoCount = playerObj:getInventory():getItemCountRecurse(itemKey)
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
                        getText("ContextMenu_GunType") .. ": " .. item:getGunTypeString() .. "\n" ..
                        getText("Tooltip_weapon_AmmoCount") .. ": " .. item:getCurrentAmmoCount() .. "/" .. item:getMaxAmmo());
                insertOption.toolTip = tooltip;
            end
            elseif instanceof(item, "HandWeapon") and not item:getMagazineType() and itemKey == bullet:getFullType() then
                ISInventoryPaneContextMenu.doBulletMenu(playerObj, item, context)
        end
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
    local itemKey = weapon:getAmmoType():getItemKey();
    local bulletAvail = playerObj:getInventory():getItemCountRecurse(itemKey);
    local bulletNeeded = weapon:getMaxAmmo() - weapon:getCurrentAmmoCount();
    local bulletName = getScriptManager():FindItem(itemKey):getDisplayName();

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
    local ammoType = weapon:getAmmoType();
    if not ammoType then
        return
    end
    local itemKey = ammoType:getItemKey();
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
    elseif itemKey then
        ISInventoryPaneContextMenu.doBulletMenu(playerObj, weapon, context)
    end
    if weapon:isJammed() then -- unjam
        context:addOption(getText("ContextMenu_Unjam", weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onRackGun, weapon);
    elseif ISReloadWeaponAction.canRack(weapon) then
        local text = weapon:haveChamber() and "ContextMenu_Rack" or "ContextMenu_UnloadRoundFrom"
        context:addOption(getText(text, weapon:getDisplayName()), playerObj, ISInventoryPaneContextMenu.onRackGun, weapon);
    end
end

function ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item, preventTransferWorldObjects)
	if instanceof(item, "InventoryItem") then
		if luautils.haveToBeTransfered(playerObj, item) then
			ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, item:getContainer(), playerObj:getInventory()))
		end
    elseif instanceof(item, "IsoWorldInventoryObject") then
        if luautils.walkAdj(playerObj, item:getSquare()) then
            if not preventTransferWorldObjects then
			    ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item:getItem(), item:getItem():getContainer(), playerObj:getInventory()))
            end
        end
	elseif instanceof(item, "ArrayList") then
		local items = item
		for i=1,items:size() do
			local item = items:get(i-1)
			if luautils.haveToBeTransfered(playerObj, item) then
				ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, item:getContainer(), playerObj:getInventory()))
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
    local itemKey = weapon:getAmmoType():getItemKey();
    ISInventoryPaneContextMenu.transferBullets(playerObj, itemKey, weapon:getCurrentAmmoCount(), weapon:getMaxAmmo())
    ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISReloadWeaponAction:new(playerObj, weapon));
end

ISInventoryPaneContextMenu.onUnloadBulletsFromFirearm = function(playerObj, weapon)
    ISInventoryPaneContextMenu.equipWeapon(weapon, true, false, playerObj:getPlayerNum())
    ISTimedActionQueue.add(ISUnloadBulletsFromFirearm:new(playerObj, weapon))
end

ISInventoryPaneContextMenu.doMagazineMenu = function(playerObj, magazine, context)
    if magazine:getCurrentAmmoCount() < magazine:getMaxAmmo() then
        local itemKey = magazine:getAmmoType():getItemKey();
        local ammoCount = playerObj:getInventory():getItemCountRecurse(itemKey);
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
    local itemKey = magazine:getAmmoType():getItemKey();
    local items = playerObj:getInventory():getSomeTypeRecurse(itemKey, ammoCount)
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
    if instanceof(evoItem,"Food") and evoItem:isFrozen() and not evorecipe2:isAllowFrozenItem() then
        option.notAvailable = true;
        tooltip.description = getText("ContextMenu_CantAddFrozenFood");
        option.toolTip = tooltip;
    end
    if not evorecipe2:needToBeCooked(evoItem) then
        option.notAvailable = true;
        if string.len(tooltip.description) > 0 then
            tooltip.description = tooltip.description .. " <BR> ";
        end
        tooltip.description = tooltip.description .. getText("ContextMenu_NeedCooked");
        option.toolTip = tooltip;
    end
    option.itemForTexture = evoItem
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
        if foodItems[1]:hasTag(ItemTag.SMOKABLE) and playerObj:getVehicle() and playerObj:getVehicle():canLightSmoke(playerObj) then found = true end
        if foodItems[1]:hasTag(ItemTag.SMOKABLE) and not found then
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
end

ISInventoryPaneContextMenu.OnLinkRemoteController = function(itemToLink, remoteController, player)
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
    for _,k in ipairs(items) do
        if not k:isFavorite() then
            return false
        end
    end
    return true
end

function ISInventoryPaneContextMenu.isAnyAllowed(container, items)
    items = ISInventoryPane.getActualItems(items)
    for _,k in ipairs(items) do
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
    item:setRemoteControlID(-1)
    item:syncItemFields();
end

ISInventoryPaneContextMenu.onDrinkFluid = function(item, percent, playerObj, openingRecipe, realItem)
	-- if food isn't in main inventory, put it there first.
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
	if openingRecipe then
        ISInventoryPaneContextMenu.OnNewCraft(realItem, openingRecipe, playerObj:getPlayerNum(), false)
    end

	-- now remove a mask
	local mask = ISInventoryPaneContextMenu.getEatingMask(playerObj, true)
	
	-- drink
	ISTimedActionQueue.add(ISDrinkFluidAction:new(playerObj, item, percent))
	-- wear mask
	if mask then ISTimedActionQueue.add(ISWearClothing:new(playerObj, mask, 50)) end
    -- return item to original container if applicable
    ISCraftingUI.ReturnItemToOriginalContainer(playerObj, item)
end

ISInventoryPaneContextMenu.doDrinkFluidMenu = function(playerObj, fluidContainer, context)
    if not fluidContainer or not fluidContainer:getFluidContainer() then return end
    local item = instanceof(fluidContainer, "IsoWorldInventoryObject") and fluidContainer:getItem() or fluidContainer;
    if item:getJobDelta() > 0.0 and (item:getJobType() == getText("ContextMenu_Drink") or (item:getCustomMenuOption() and item:getJobType() == item:getCustomMenuOption())) then
        return
    end
    if (instanceof(fluidContainer, "IsoWorldInventoryObject") and item:getJobDelta() ~= 0.0) then return end
    local openingRecipe = item:getOpeningRecipe()
    if not item:isSealed() then openingRecipe = nil end
    if openingRecipe and getScriptManager():getCraftRecipe(openingRecipe) then
        openingRecipe = getScriptManager():getCraftRecipe(openingRecipe)
    else
        openingRecipe = nil
    end
    if openingRecipe then
        local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
        local logic = HandcraftLogic.new(playerObj, nil, nil);

        logic:setContainers(containers);
        logic:setRecipeFromContextClick(openingRecipe, item);
        if not logic:canPerformCurrentRecipe() then
            openingRecipe = nil
        end
    end

    local cmd = fluidContainer:getCustomMenuOption() or getText("ContextMenu_Drink");
    if openingRecipe then
        cmd = fluidContainer:getCustomMenuOption() or getText("ContextMenu_OpenAndDrink");
    end
    local eatOption = context:addOption(cmd, fluidContainer, nil);
    eatOption.itemForTexture = item
	
	if not fluidContainer:getFluidContainer():canPlayerEmpty() and not openingRecipe then
		local tooltip = ISInventoryPaneContextMenu.addToolTip();
		eatOption.notAvailable = true;
		tooltip.description = getText("Tooltip_item_sealed");
		eatOption.toolTip = tooltip;	
	elseif playerObj:getMoodles():getMoodleLevel(MoodleType.FOOD_EATEN) >= 3 and fluidContainer:getFluidContainer():getProperties():getHungerChange() ~= 0 then
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
		local option = subMenuEat:addOption(getText("ContextMenu_Eat_All"), fluidContainer, ISInventoryPaneContextMenu.onDrinkFluid, 1, playerObj, openingRecipe, item)
		
        local capacity = fluidContainer:getFluidContainer():getCapacity()
        local amount = fluidContainer:getFluidContainer():getAmount()
        local baseThirst = amount/capacity
		if (baseThirst >= 0.5 ) then
			option = subMenuEat:addOption(getText("ContextMenu_Eat_Half"), fluidContainer, ISInventoryPaneContextMenu.onDrinkFluid, 0.5, playerObj, openingRecipe, item)
		end
		if (baseThirst >= 0.25) then
			option = subMenuEat:addOption(getText("ContextMenu_Eat_Quarter"), fluidContainer, ISInventoryPaneContextMenu.onDrinkFluid, 0.25, playerObj, openingRecipe, item)
		end
	end
end

ISInventoryPaneContextMenu.doDrinkForThirstMenu = function(context, playerObj, waterContainer)
    local thirst = playerObj:getStats():get(CharacterStat.THIRST)
	local units = math.min((thirst * 2), waterContainer:getFluidContainer():getFluidAmount())
	local percent = units / waterContainer:getFluidContainer():getFluidAmount();
    local option = context:addOption(getText("ContextMenu_Drink"), waterContainer, ISInventoryPaneContextMenu.onDrinkForThirst, playerObj, percent)
    local tooltip = ISInventoryPaneContextMenu.addToolTip()
    local tx1 = getTextManager():MeasureStringX(tooltip.font, getText("Tooltip_food_Thirst") .. ":") + 20
    local tx2 = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
    local tx = math.max(tx1, tx2)
    --TODO: verify uses and delta are appropriate to be replaced by units and percent here (these were nil, before). Remove this comment when checked.
    tooltip.description = string.format("%s: <SETX:%d> -%d / %d <LINE> %s: <SETX:%d> %d / %d",
        getText("Tooltip_food_Thirst"), tx, math.min(units * 10, thirst * 100), thirst * 100,
        getText("ContextMenu_WaterName"), tx, units, percent)
    if waterContainer:getFluidContainer():contains(Fluid.TaintedWater) and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
        tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
    end
    option.toolTip = tooltip
end

ISInventoryPaneContextMenu.onDrinkForThirst = function(waterContainer, playerObj, percent, openingRecipe)
	if openingRecipe then
        ISInventoryPaneContextMenu.OnNewCraft(item, openingRecipe, playerObj:getPlayerNum(), false)
    end
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, waterContainer)
	-- now remove a mask
	local mask = ISInventoryPaneContextMenu.getEatingMask(playerObj, true)
    ISTimedActionQueue.add(ISDrinkFromBottle:new(playerObj, waterContainer, percent))
    if mask then ISTimedActionQueue.add(ISWearClothing:new(playerObj, mask, 50)) end
    -- return item to original container if applicable
    ISCraftingUI.ReturnItemToOriginalContainer(playerObj, item)
end

ISInventoryPaneContextMenu.onAddItemInEvoRecipe = function(recipe, baseItem, usedItem, player)
    local playerObj = getSpecificPlayer(player);
    local returnToContainer = {};
    if not playerObj:getInventory():contains(usedItem) then -- take the item if it's not in our inventory
        ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, usedItem,usedItem:getContainer(), playerObj:getInventory(), nil));
        table.insert(returnToContainer, usedItem);
        if (instanceof(usedItem, "Food")) then
            usedItem:setChef(playerObj:getUsername())
        end
    end
    if not playerObj:getInventory():contains(baseItem) then -- take the base item if it's not in our inventory
        ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, baseItem, baseItem:getContainer(), playerObj:getInventory(), nil));
        table.insert(returnToContainer, baseItem);
        if (instanceof(baseItem, "Food")) then
            baseItem:setChef(playerObj:getUsername())
        end
    end
    ISTimedActionQueue.add(ISAddItemInRecipe:new(playerObj, recipe, baseItem, usedItem));
    ISCraftingUI.ReturnItemsToOriginalContainer(playerObj, returnToContainer)
end

ISInventoryPaneContextMenu.buildFixingMenu = function(brokenObject, player, fixing, fixingNum, fixOption, subMenuFix, vehiclePart)
    local tooltip = ISInventoryPaneContextMenu.addToolTip();
    tooltip.description = "";
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
        if instanceof(parent, "IsoThumpable") then
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
    local fixOption;
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
            if getItem(fixing:getGlobalItem():getFixerName()) then
               	name = getItemName(fixing:getGlobalItem():getFixerName());
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
	if playerObj:getWornItem(ItemBodyLocation.FULL_HAT) then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem(ItemBodyLocation.FULL_HAT), 50));
	end
	if playerObj:getWornItem(ItemBodyLocation.HAT) and not beard then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem(ItemBodyLocation.HAT), 50));
	end
	if beard and playerObj:getWornItem(ItemBodyLocation.MASK) then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem(ItemBodyLocation.MASK), 50));
	end
	if beard and playerObj:getWornItem(ItemBodyLocation.MASK_EYES) then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem(ItemBodyLocation.MASK_EYES), 50));
	end
	if beard and playerObj:getWornItem(ItemBodyLocation.MASK_FULL) then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getWornItem(ItemBodyLocation.MASK_FULL), 50));
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
            ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, alarm, alarm:getContainer(), playerObj:getInventory()))
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
        local action = ISInventoryTransferUtil.newInventoryTransferAction(playerObj, alarm, alarm:getContainer(), playerObj:getInventory())
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
        local action = ISInventoryTransferUtil.newInventoryTransferAction(playerObj, map, map:getContainer(), playerObj:getInventory())
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
    map:doBuildingStash();
    wrap:setVisible(true);
    wrap:addToUIManager();
	if JoypadState.players[player+1] then
        setJoypadFocus(player, mapUI)
    end
    playerObj:addReadMap(map)
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
                item:syncItemFields();
				local pdata = getPlayerData(playerNum);
				pdata.playerInventory:refreshBackpacks();
				pdata.lootInventory:refreshBackpacks();
			else
				HaloTextHelper.addBadText(player, getText("IGUI_PlayerText_ItemNameTooLong", MAXIMUM_RENAME_LENGTH));
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
                item:setCustomName(true);
                item:syncItemFields();
				local pdata = getPlayerData(playerNum);
				pdata.playerInventory:refreshBackpacks();
				pdata.lootInventory:refreshBackpacks();
			else
				HaloTextHelper.addBadText(player, getText("IGUI_PlayerText_ItemNameTooLong", MAXIMUM_RENAME_LENGTH));
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
	local playerObj = getSpecificPlayer(player)
	items = ISInventoryPane.getActualUniqueItems(items)
	local readableItems = {}
	for i,k in ipairs(items) do
        local invalid = false
        if (playerObj:hasTrait(CharacterTrait.ILLITERATE) and not k:hasTag(ItemTag.PICTUREBOOK) and not k:hasTag(ItemTag.PICTURE))
        or (k:getLvlSkillTrained() ~= -1 and SkillBook[k:getSkillTrained()].perk and k:getLvlSkillTrained() > playerObj:getPerkLevel(SkillBook[k:getSkillTrained()].perk) + 1)
        or k:hasTag(ItemTag.UNINTERESTING) then
            invalid = true
        end
        if not invalid then
            table.insert(readableItems, k)
        end
    end
	for i,k in ipairs(readableItems) do
		ISInventoryPaneContextMenu.readItem(k, player)
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
    -- return item to original container if applicable
    ISCraftingUI.ReturnItemToOriginalContainer(playerObj, item)
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
    if item ~= nil and (item:getType() == "Lantern_HurricaneLit" or item:hasTag(ItemTag.LIT_LANTERN)) then ISInventoryPaneContextMenu.hurricaneLanternExtinguish(item, player) end
    ISTimedActionQueue.add(ISUnequipAction:new(getSpecificPlayer(player), item, 50));
end

ISInventoryPaneContextMenu.onWearItems = function(items, player)
    items = ISInventoryPane.getActualItems(items)
    local typeDone = {}; -- we keep track of what type of clothes we already wear to avoid wearing 2 times the same type (click on a stack of socks, select wear and you'll wear them 1 by 1 otherwise)
    for i,k in pairs(items) do
        if not (k:getBodyLocation() and typeDone[k:getBodyLocation()]) and not (k:canBeEquipped() and typeDone[k:canBeEquipped()]) then
            if k:getBodyLocation() == ItemBodyLocation.HAT or k:getBodyLocation() == ItemBodyLocation.FULL_HAT then
                local playerObj = getSpecificPlayer(player);
                local wornItems = playerObj:getWornItems()
                for j=1,wornItems:size() do
                    local wornItem = wornItems:get(j-1)
                    if (wornItem:getLocation() == ItemBodyLocation.SWEATER_HAT or wornItem:getLocation() == ItemBodyLocation.JACKET_HAT) then
                        for i=0, wornItem:getItem():getClothingItemExtraOption():size()-1 do
                            if wornItem:getItem():getClothingItemExtraOption():get(i) == "DownHoodie" then
                                ISInventoryPaneContextMenu.onClothingItemExtra(wornItem:getItem(), wornItem:getItem():getClothingItemExtra():get(i), playerObj);
                            end
                        end
                    end
                end
            end
            ISInventoryPaneContextMenu.wearItem(k, player)
            if k:getBodyLocation() then
                typeDone[k:getBodyLocation()] = true;
            end
            if k:canBeEquipped() then
                typeDone[k:canBeEquipped()] = true;
            end
        end
    end
end

ISInventoryPaneContextMenu.onActivateItem = function(light, player)
	local playerObj = getSpecificPlayer(player);
	light:setActivated(not light:isActivated());
	syncItemActivated(playerObj, light)
	light:playActivateDeactivateSound()
end

-- Wear a clothe, loot it first if it's not in the player's inventory
ISInventoryPaneContextMenu.wearItem = function(item, player)
	-- if clothing isn't in main inventory, put it there first.
	local playerObj = getSpecificPlayer(player);
	-- This stuff was removed in that it forced the first optional clothing option when trying to wear clothing items with multiple options.
	-- It seems to work fine as intended without it.
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item);
    ISTimedActionQueue.add(ISWearClothing:new(playerObj, item, 50));
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
			ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, k, k:getContainer(), playerLoot))
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
    end
    return true
end

ISInventoryPaneContextMenu.onFavorite = function(items, item2, fav)
    for i,item in ipairs(items) do
        item:setFavorite(fav, true);
    end
end

ISInventoryPaneContextMenu.onMediaText = function(playerNum, text)
    ISMediaInfo.openPanel(playerNum , text);
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
        ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, item:getContainer(), dest))
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
    return true;
end

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

	self.contents = {}
	local marginLeft = 20
	local marginTop = 10
	local marginBottom = 10
	local y1 = y + marginTop
	local lineHeight = math.max(FONT_HGT_SMALL, 20 + 2)
	local textDY = (lineHeight - FONT_HGT_SMALL) / 2
	local imageDY = (lineHeight - IMAGE_SIZE) / 2

    local items = self.logic:getRecipeData():getAllInputItems()
    local x1 = x + marginLeft

    for i=0,items:size()-1 do
        local item = items:get(i)
        if item then
            local x2 = x1
            self:addImage(x2, y1 + imageDY, item:getTex():getName(), 1.0, 1.0, 1.0)
            x2 = x2 + IMAGE_SIZE + 6
            self:addText(x2, y1 + textDY, item:getName())
            y1 = y1 + lineHeight
        end
    end

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
	table.wipe(CraftTooltip.tooltipsUsed)
end

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
                if (item:getType() == "Lantern_HurricaneLit" and selectedItem:getType() == "Lantern_Hurricane")
                or (item:hasTag(ItemTag.LIT_LANTERN) and selectedItem:hasTag(ItemTag.UNLIT_LANTERN))
                then
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
    if recipeList:size() > 1 then
        local option = context:addOption(selectedItem:getDisplayName());
        option.iconTexture = selectedItem:getIcon():splitIcon();
        local subMenu = context:getNew(context);
        context:addSubMenu(option, subMenu);
        context = subMenu;
    end
	for i=0,recipeList:size() -1 do
        local recipe = recipeList:get(i)

        local logic = HandcraftLogic.new(playerObj, nil, nil);

        logic:setContainers(containers);
        logic:setRecipeFromContextClick(recipe, selectedItem);

        local recipeName = getText(recipe:getTranslationName())
        local recipeTexture = logic:getResultTexture() or selectedItem:getTexture() or nil
        if selectedItem and not recipeTexture then
            recipeTexture = selectedItem:getTexture()
        end
        local text = recipeName
        if isDebugEnabled() or getSandboxOptions():isUnstableScriptNameSpam() then
            text = text
        end
        local option = context:addOption(text , selectedItem, ISInventoryPaneContextMenu.OnNewCraft, recipe, player, false);
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
        tooltip.character = playerObj
        tooltip.recipe = recipe
        tooltip.logic = logic
        -- add it to our current option
        tooltip:setName(recipe:getTranslationName());
        if recipeTexture then
            tooltip:setTextureDirectly(recipeTexture);
        end
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

ISInventoryPaneContextMenu.OnNewCraft = function(selectedItem, recipe, player, all, eatPercentage)
 	local playerObj = getSpecificPlayer(player)
 	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	local logic = HandcraftLogic.new(playerObj, nil, nil);
    logic:setIsoObject(logic:findCraftSurface(playerObj, 2));

    logic:setContainers(containers);
    logic:setRecipeFromContextClick(recipe, selectedItem);
    
    if logic:canPerformCurrentRecipe() then

        local items = logic:getRecipeData():getAllInputItems()
        local itemsToReturn = logic:getRecipeData():getAllPutBackInputItems()

        if logic:isUsingRecipeAtHandBenefit() then
            local recipeAtHandItem = logic:getUsingRecipeAtHandItem()
            if recipeAtHandItem then
                items:add(recipeAtHandItem)
                itemsToReturn:add(recipeAtHandItem)
            end
        end

        local returnToContainer = {};
        if not recipe:isCanBeDoneFromFloor() then
            local itemsWereMoved = false;
            for i=1,items:size() do
                local item = items:get(i-1)
                if item:getContainer() ~= playerObj:getInventory() then
		            ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
                    if itemsToReturn:contains(item) then
                        table.insert(returnToContainer, item)
                    end
                    itemsWereMoved = true;
                end
            end
            if itemsWereMoved then
                logic:setRecipeFromContextClick(recipe, selectedItem);
            end
        end

        local action = ISEntityUI.HandcraftStart( playerObj, logic, false, true, eatPercentage);
        if action then
            if not all then action:setOnComplete(ISInventoryPaneContextMenu.OnNewCraftComplete, logic); end
            logic:startCraftAction(action);
        end

        ISCraftingUI.ReturnItemsToOriginalContainer(playerObj, returnToContainer)
    end
end

ISInventoryPaneContextMenu.OnNewCraftComplete = function(logic)
    logic:stopCraftAction();
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
				ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, item:getContainer(), playerObj:getInventory(), nil))
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
				local action = ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, item:getContainer(), playerObj:getInventory(), nil)
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

ISInventoryPaneContextMenu.eatItem = function(item, percentage, player, openingRecipe, eatPercentage)
    local playerObj = getSpecificPlayer(player);
	-- if food isn't in main inventory, put it there first.
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)

	-- now remove a mask
	local mask = ISInventoryPaneContextMenu.getEatingMask(playerObj, true)

	-- Transfer required items.
    local itemRequired = nil
    local itemRequiredCont = nil
	if item:getRequireInHandOrInventory() then
		local types = item:getRequireInHandOrInventory()
        local typesTable = {}
        for i=1,types:size() do
            typesTable[moduleDotType(item:getModule(), types:get(i-1))] = true
        end
        -- check for car lighters for smokables

        if item:hasTag(ItemTag.SMOKABLE) and playerObj:getVehicle() and playerObj:getVehicle():canLightSmoke(playerObj) then
            itemRequired = true
        end
        if item:hasTag(ItemTag.SMOKABLE) and not itemRequired then
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
                    itemRequiredCont = itemRequired:getContainer()
                    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, itemRequired)
                    break
                end
            end
        end

		if not itemRequired then return end
	end
    -- do the opening recipe if needed
    if eatPercentage and openingRecipe then
        ISInventoryPaneContextMenu.OnNewCraft(item, openingRecipe, playerObj:getPlayerNum(), false, eatPercentage)
    else
        -- Then eat it.
        ISTimedActionQueue.add(ISEatFoodAction:new(playerObj, item, percentage));
    end

    if mask then ISTimedActionQueue.add(ISWearClothing:new(playerObj, mask, 50)) end
    if itemRequired and instanceof(itemRequired, "InventoryItem") then
        -- return required item to original container if applicable
        ISCraftingUI.ReturnItemToContainer(playerObj, itemRequired, itemRequiredCont)
    end
    if not (eatPercentage and openingRecipe) then
        -- return item to original container if applicable
        ISCraftingUI.ReturnItemToOriginalContainer(playerObj, item)
    end
end

-- Function that unequip primary weapon and equip the selected weapon
ISInventoryPaneContextMenu.OnPrimaryWeapon = function(items, player)
    local playerObj = getSpecificPlayer(player)
    if playerObj:getPrimaryHandItem() ~= nil and playerObj:getPrimaryHandItem():getType() == "CandleLit" then
        ISInventoryPaneContextMenu.litCandleExtinguish(playerObj:getPrimaryHandItem(), player)
    end
    if playerObj:getPrimaryHandItem() ~= nil and (playerObj:getPrimaryHandItem():getType() == "Lantern_HurricaneLit" or playerObj:getPrimaryHandItem():hasTag(ItemTag.LIT_LANTERN)) then
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
    -- return item to original container if applicable
    ISCraftingUI.ReturnItemToOriginalContainer(playerObj, item)
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
    if playerObj:getPrimaryHandItem() ~= nil and (playerObj:getPrimaryHandItem():getType() == "Lantern_HurricaneLit" or playerObj:getPrimaryHandItem():hasTag(ItemTag.LIT_LANTERN)) then
        ISInventoryPaneContextMenu.hurricaneLanternExtinguish(playerObj:getPrimaryHandItem(), player)
    end
    if playerObj:getSecondaryHandItem() ~= nil and (playerObj:getSecondaryHandItem():getType() == "Lantern_HurricaneLit" or playerObj:getSecondaryHandItem():hasTag(ItemTag.LIT_LANTERN)) then
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
    if playerObj:getSecondaryHandItem() ~= nil and (playerObj:getSecondaryHandItem():getType() == "Lantern_HurricaneLit" or playerObj:getSecondaryHandItem():hasTag(ItemTag.LIT_LANTERN)) then
        ISInventoryPaneContextMenu.hurricaneLanternExtinguish(playerObj:getSecondaryHandItem(), player)
    end
	items = ISInventoryPane.getActualItems(items)
	for _,item in ipairs(items) do
		ISInventoryPaneContextMenu.equipWeapon(item, false, false, player)
		break
	end
end

-- Function that equip the selected weapon
ISInventoryPaneContextMenu.equipWeapon = function(weapon, primary, twoHands, player, alwaysTurnOn)
	local playerObj = getSpecificPlayer(player)
	-- Drop corpse or generator
	if isForceDropHeavyItem(playerObj:getPrimaryHandItem()) then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
	end
	if weapon:getWorldItem() then
        local action = ISInventoryTransferUtil.newInventoryTransferAction(playerObj, weapon, weapon:getContainer(), playerObj:getInventory())
        -- Equipping an item from the ground to the hands is faster than putting it into the player's inventory.
        action.maxTime = 20
        ISTimedActionQueue.add(action)
        -- Then equip it.
        ISTimedActionQueue.add(ISEquipWeaponAction:new(playerObj, weapon, 1, primary, twoHands, alwaysTurnOn));
        return
	end
	-- if weapon isn't in main inventory, put it there first.
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, weapon)
    -- Then equip it.
    ISTimedActionQueue.add(ISEquipWeaponAction:new(playerObj, weapon, 50, primary, twoHands, alwaysTurnOn));
end

ISInventoryPaneContextMenu.onInformationItems = function(items)
	items = ISInventoryPane.getActualItems(items)
	for i,k in pairs(items) do
		ISInventoryPaneContextMenu.information(k)
		break
	end
end

ISInventoryPaneContextMenu.information = function(item)
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
ISInventoryPaneContextMenu.onEatItems = function(items, percentage, player, openingRecipe, eatPercentage)
	items = ISInventoryPane.getActualItems(items)
	for i,k in ipairs(items) do
		ISInventoryPaneContextMenu.eatItem(k, percentage, player, openingRecipe, eatPercentage)
		break
    end
end

ISInventoryPaneContextMenu.onPlaceTrap = function(weapon, player)
    ISTimedActionQueue.add(ISPlaceTrap:new(player, weapon));
end

ISInventoryPaneContextMenu.onRemoveUpgradeWeapon = function(weapon, part, playerObj)
    ISInventoryPaneContextMenu.transferIfNeeded(playerObj, weapon)
    local screwdriver = playerObj:getInventory():getFirstTagEvalRecurse(ItemTag.SCREWDRIVER, predicateNotBroken)
    if screwdriver then
        ISInventoryPaneContextMenu.equipWeapon(screwdriver, true, false, playerObj:getPlayerNum());
    end
    ISTimedActionQueue.add(ISRemoveWeaponUpgrade:new(playerObj, weapon, part:getPartType()));
end

ISInventoryPaneContextMenu.onUpgradeWeapon = function(weapon, part, player)
    ISInventoryPaneContextMenu.transferIfNeeded(player, weapon)
    ISInventoryPaneContextMenu.transferIfNeeded(player, part)
    ISInventoryPaneContextMenu.equipWeapon(part, false, false, player:getPlayerNum());
    local screwdriver = player:getInventory():getFirstTagEvalRecurse(ItemTag.SCREWDRIVER, predicateNotBroken)
    if screwdriver then
        ISInventoryPaneContextMenu.equipWeapon(screwdriver, true, false, player:getPlayerNum());
    end
    ISTimedActionQueue.add(ISUpgradeWeapon:new(player, weapon, part));
end

-- Rewrote to skip vehicle checks since that's being done above - Baph
ISInventoryPaneContextMenu.onDropItems = function(items, player)
	local playerObj = getSpecificPlayer(player)
	items = ISInventoryPane.getActualItems(items)
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
    if (item:getType() == "Lantern_HurricaneLit" or item:hasTag(ItemTag.LIT_LANTERN)) and item:isEquipped() then
        ISInventoryPaneContextMenu.hurricaneLanternExtinguish(item, player)
    end

    playerObj:removeAttachedItem(item)
    if playerObj:isHandItem(item) then
        ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 1, "drop"))
    else
        ISInventoryPaneContextMenu.unequipItem(item, player)
    end

	-- Special action for dropping items outside of vehicles. If not in vehicle then do normal transfer action.
	if playerObj:getVehicle() then
		local vehicle = playerObj:getVehicle()
		local seatPart = vehicle:getSeat(playerObj)
		if vehicle:getPassengerDoor(seatPart) then
			local door = vehicle:getPassengerDoor(seatPart)
			local dropSquare = vehicle:getSquareForArea(door:getArea())
			ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
			ISTimedActionQueue.add(ISDropVehicleItemAction:new(playerObj, item, vehicle, door, dropSquare))
		end
	else
		ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, item:getContainer(), ISInventoryPage.GetFloorContainer(player)))
	end
end

 ISInventoryPaneContextMenu.transferItemToPlayer = function(item, player, dontWalk)
     local playerObj = getSpecificPlayer(player)
     local playerInv = getPlayerInventory(playerObj:getIndex()).inventory;
     if item:getContainer() ~= playerInv and item:getContainer() ~= nil then
         if not dontWalk then
             if not luautils.walkToContainer(item:getContainer(), player) then
                 return
             end
             dontWalk = true
         end

         if (item:isHumanCorpse()) then
             ISInventoryPaneContextMenu.grabCorpseItem(playerObj, item)
             return
         end

         if item:isForceDropHeavyItem() then
             ISInventoryPaneContextMenu.equipHeavyItem(playerObj, item)
             return
         end

         ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, item:getContainer(), playerInv))
     end
 end

 ISInventoryPaneContextMenu.onGrabItems = function(items, player)
     items = ISInventoryPane.getActualItems(items)
     local playerObj = getSpecificPlayer(player)
     local playerInv = getPlayerInventory(player).inventory;
     local doWalk = true
     for i,k in ipairs(items) do
         if not instanceof(k, "InventoryItem") then
             local count = #k.items
             for i2=2,count do
                 local k2 = k.items[i2]
                 if k2:getContainer() ~= playerInv then
                     if doWalk then
                         if not luautils.walkToContainer(k2:getContainer(), player) then
                             return
                         end
                         doWalk = false
                     end

                     if k:isHumanCorpse() then
                         ISTimedActionQueue.add(ISGrabCorpseItem:new(playerObj, k))
                         return;
                     end

                     ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, k2, k2:getContainer(), playerInv))
                 end
             end
         elseif k:getContainer() ~= playerInv then
             if doWalk then
                 if not luautils.walkToContainer(k:getContainer(), player) then
                     return
                 end
                 doWalk = false
             end

             if k:isHumanCorpse() then
                 ISTimedActionQueue.add(ISGrabCorpseItem:new(playerObj, k))
                 return;
             end

             ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, k, k:getContainer(), playerInv))
         end
     end
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

             if k:isHumanCorpse() then
                 ISTimedActionQueue.add(ISGrabCorpseItem:new(playerObj, k))
                 return;
             end

             ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, k, k:getContainer(), playerInv));
             return;
         end
     end
 end

ISInventoryPaneContextMenu.onGrabHalfItems = function(items, player)
    items = ISInventoryPane.getActualItems(items)
	local playerObj = getSpecificPlayer(player)
	local playerInv = getPlayerInventory(player).inventory;
	local doWalk = true
    local count = math.floor((#items) / 2)
	for i=1,count do
        local k = items[i]
		if not instanceof(k, "InventoryItem") then
			local count2 = math.floor((#k.items) / 2)
			-- first in a list is a dummy duplicate, so ignore it.
			for i2=1,count2 do
				local k2 = k.items[i2+1]
				if k2:getContainer() ~= playerInv then
					if doWalk then
						if not luautils.walkToContainer(k2:getContainer(), player) then
							return
						end
						doWalk = false
					end

                    if k:isHumanCorpse() then
                        ISTimedActionQueue.add(ISGrabCorpseItem:new(playerObj, k))
                        return;
                    end

					ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, k2, k2:getContainer(), playerInv))
				end
			end
		elseif k:getContainer() ~= playerInv then
			if doWalk then
				if not luautils.walkToContainer(k:getContainer(), player) then
					return
				end
				doWalk = false
			end

            if k:isHumanCorpse() then
                ISTimedActionQueue.add(ISGrabCorpseItem:new(playerObj, k))
                return;
            end

			ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, k, k:getContainer(), playerInv))
		end
	end
end

ISInventoryPaneContextMenu.onEditItem = function(items, player, item)
    ISItemEditorUI.OpenPanel(player, item);
end

-- Crowley
-- Pours water from one container into another.
ISInventoryPaneContextMenu.onTransferWater = function(items, itemFrom, itemTo, player)
	local playerObj = getSpecificPlayer(player)
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

	local itemFromEndingDelta = 0;
--
	if waterStorageAvailable >= waterStorageNeeded then
		--Transfer all water to the the second container.
		itemFromEndingDelta = 0;
	end

	if waterStorageAvailable < waterStorageNeeded then
		--Transfer what we can. Leave the rest in the container.
		local waterInB = itemFrom:getCurrentUses();
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

-- Empties a water container
ISInventoryPaneContextMenu.onEmptyWaterContainer = function(items, waterSource, player)
	if waterSource ~= nil then
		local playerObj = getSpecificPlayer(player)
		ISInventoryPaneContextMenu.transferIfNeeded(playerObj, waterSource)
		ISTimedActionQueue.add(ISDumpWaterAction:new(playerObj, waterSource));
	end
end

-- Return true if the given item's ReplaceOnUse type can hold water.
-- The check is recursive to handle RemouladeFull -> RemouladeHalf -> RemouladeEmpty.
ISInventoryPaneContextMenu.canReplaceStoreWater = function(item)
    if item:hasTag(ItemTag.NO_POUR) then return false end

    if item:getReplaceOnUse() then
        return true
    end
    if instanceof(item, "DrainableComboItem") and item:getReplaceOnDeplete() then
        local itemType = moduleDotType(item:getModule(), item:getReplaceOnDeplete())
        return ISInventoryPaneContextMenu.canReplaceStoreWater2(itemType)
    end
    return false
end

ISInventoryPaneContextMenu.canReplaceStoreWater2 = function(itemType)
	local item = ScriptManager.instance:FindItem(itemType)
	if item == nil then return false end
	if item:getIconFluidMask() then return true end
    if item:getReplaceOnUse() then
        itemType = moduleDotType(item:getModuleName(), item:getReplaceOnUse())
        return ISInventoryPaneContextMenu.canReplaceStoreWater2(itemType)
    end
    if item:isItemType(ItemType.Drainable) and item:getReplaceOnDeplete() then
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
    if item:isHumanCorpse() then
        ISInventoryPaneContextMenu.grabCorpseItem(playerObj, item)
        return
    end

    if not luautils.walkToContainer(item:getContainer(), playerObj:getPlayerNum()) then
        return
    end
    if playerObj:getPrimaryHandItem() then
        ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
    end
    if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
        ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
    end

    ISTimedActionQueue.add(ISEquipHeavyItem:new(playerObj, item))
end

 ISInventoryPaneContextMenu.grabCorpseItem = function(playerObj, item)
     if not luautils.walkToContainer(item:getContainer(), playerObj:getPlayerNum()) then
         return
     end
     if playerObj:getPrimaryHandItem() then
         ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
     end
     if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
         ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
     end
     ISTimedActionQueue.add(ISGrabCorpseItem:new(playerObj, item));
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
    local destContainer = getPlayerInventory(player).inventory;
    for i,k in pairs(items) do
        if not instanceof(k, "InventoryItem") then
            if isForceDropHeavyItem(k.items[1]) then
                -- corpse or generator
            elseif not destContainer:isItemAllowed(k.items[1]) then
                -- item is forbidden in the destination container
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
        elseif not destContainer:isItemAllowed(k) then
            -- item is forbidden in the destination container
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
                else
                    local use = ISInventoryPaneContextMenu.getRealEvolvedItemUse(evoItem, evorecipe2, cookingLvl);
                    if use then
                        extraInfo = "(" .. use .. ")";
                    end
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
            elseif evoItem:getScriptItem():isSpice() then
                    extraInfo = getText("ContextMenu_EvolvedRecipe_Spice");
            end
            if evoItem and evoItem ~= baseItem then
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
                        if not sq:isWallTo(playerObj:getCurrentSquare()) and sprite:getProperties():has("IsMirror") then
                            mirror = true;
                            break;
                        end
                        if object:getAttachedAnimSprite() then
                            for j=0,object:getAttachedAnimSprite():size() - 1 do
                                local sprite = object:getAttachedAnimSprite():get(j):getParentSprite();
                                if not sq:isWallTo(playerObj:getCurrentSquare()) and sprite:getProperties():has("IsMirror") then
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
        option.iconTexture = clothingItemExtra:getTex():splitIcon();
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
    if item:getBodyLocation() == ItemBodyLocation.HAT or item:getBodyLocation() == ItemBodyLocation.FULL_HAT then
        local wornItems = playerObj:getWornItems()
        for j=1,wornItems:size() do
            local wornItem = wornItems:get(j-1)
            if (wornItem:getLocation() == ItemBodyLocation.SWEATER_HAT or wornItem:getLocation() == ItemBodyLocation.JACKET_HAT) then
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

ISInventoryPaneContextMenu.AutoDrinkOn = function(waterContainer, playerObj)
    getCore():setOptionAutoDrink(true)
    getCore():saveOptions()
    if isClient() then
        playerObj:setAutoDrink(true)
    end
end

ISInventoryPaneContextMenu.AutoDrinkOff = function(waterContainer, playerObj)
    getCore():setOptionAutoDrink(false)
    getCore():saveOptions()
    if isClient() then
        playerObj:setAutoDrink(false)
    end
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
            and not (parent:getProperties():get("GroupName") == "Coffee") and not (parent:getProperties():get("GroupName") == "Espresso") and not (parent:getProperties():get("GroupName") == "Fryers Club") then
                return parent
            end
        end
    end
    return playerObj:getSquare():hasAdjacentFireObject()
end

ISInventoryPaneContextMenu.getEatingMask = function( playerObj, removeMask )
    local mask = false
    if playerObj:getWornItem(ItemBodyLocation.MASK) and not playerObj:getWornItem(ItemBodyLocation.MASK):hasTag(ItemTag.CAN_EAT) then
        mask = playerObj:getWornItem(ItemBodyLocation.MASK)
    elseif  playerObj:getWornItem(ItemBodyLocation.MASK_EYES) and not playerObj:getWornItem(ItemBodyLocation.MASK_EYES):hasTag(ItemTag.CAN_EAT) then
        mask = playerObj:getWornItem(ItemBodyLocation.MASK_EYES)
    elseif  playerObj:getWornItem(ItemBodyLocation.MASK_FULL) and not playerObj:getWornItem(ItemBodyLocation.MASK_FULL):hasTag(ItemTag.CAN_EAT) then
        mask = playerObj:getWornItem(ItemBodyLocation.MASK_FULL)
    elseif  playerObj:getWornItem(ItemBodyLocation.FULL_HAT) and not playerObj:getWornItem(ItemBodyLocation.FULL_HAT):hasTag(ItemTag.CAN_EAT) then
        mask = playerObj:getWornItem(ItemBodyLocation.FULL_HAT)
    elseif  playerObj:getWornItem(ItemBodyLocation.FULL_SUIT_HEAD) and not playerObj:getWornItem(ItemBodyLocation.FULL_SUIT_HEAD):hasTag(ItemTag.CAN_EAT) then
        mask = playerObj:getWornItem(ItemBodyLocation.FULL_SUIT_HEAD)
    elseif  playerObj:getWornItem(ItemBodyLocation.SCBA) and not playerObj:getWornItem(ItemBodyLocation.SCBA):hasTag(ItemTag.CAN_EAT) then
        mask = playerObj:getWornItem(ItemBodyLocation.SCBA)
    elseif  playerObj:getWornItem(ItemBodyLocation.SCBANOTANK) and not playerObj:getWornItem(ItemBodyLocation.SCBANOTANK):hasTag(ItemTag.CAN_EAT) then
        mask = playerObj:getWornItem(ItemBodyLocation.SCBANOTANK)
    end
    if mask and removeMask then ISTimedActionQueue.add(ISUnequipAction:new(playerObj, mask, 50)) end
    return mask
end

ISInventoryPaneContextMenu.onTeleportToKeyOrigin = function(item, player)
    if not isDebugEnabled and not isAdmin then return end
    local mData = item:getModData()
    if (item:hasOrigin()) then
        if isClient() then
            SendCommandToServer("/teleportto " .. tostring(item:getOriginX()) .. "," .. tostring(item:getOriginY()) .. "," .. tostring(item:getOriginZ()));
        else
            getSpecificPlayer(player):teleportTo(item:getOriginX(), item:getOriginY(), item:getOriginZ())
        end
    end
end

ISInventoryPaneContextMenu.onDebugCloneItem = function(item, player)
    if not getDebug() then return; end;
    local cloneItem = item:createCloneItem();
    local itemDestination = item:getContainer();
    local playerObj = getSpecificPlayer(player);
    if playerObj and itemDestination and itemDestination:hasRoomFor(playerObj, cloneItem) then
        playerObj:getInventory():addItem(cloneItem);
        ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, cloneItem, playerObj:getInventory(), itemDestination, 1));
    end;
end

ISInventoryPaneContextMenu.onResearchRecipe = function(item, playerObj)
    local recipes = item:getScriptItem():getResearchableRecipes(playerObj, true)
    if recipes then
        ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
        ISTimedActionQueue.add(ISResearchRecipe:new(playerObj, item))
        ISCraftingUI.ReturnItemToOriginalContainer(playerObj, item)
    end -- the player will research all researchable recipes in one-go
end

ISInventoryPaneContextMenu.doContextConfigOptions = function(context, item, playerObj)
	local contextConfig = item:getComponent(ComponentType.ContextMenuConfig);
	if instanceof(item, "Moveable") then return end;
    if not contextConfig then return self end;
    local entries = contextConfig:getEntries();

    if entries and entries:size() > 0 then
        for i = 0, entries:size()-1 do
            local entry = entries:get(i);
            local textRef = getText("ContextMenu_" .. entry:getMenu());
            local customFunction = entry:getCustomFunction();
            local option = nil;
            if customFunction then
            	option = context:addOption(textRef, customFunction, ISInventoryPaneContextMenu.onCustomFunction, item, playerObj, entry:getExtraParam());
            end
            local timedAction = entry:getTimedAction();
            if timedAction then
            	option = context:addOption(textRef, timedAction, ISWorldObjectContextMenu.onTimedAction, item, playerObj, entry:getExtraParam());
            end
            if option and entry:getIcon() and getTexture(entry:getIcon()) then
            	option.iconTexture = getTexture(entry:getIcon());
            end
        end
    end
end

function ISInventoryPaneContextMenu.onCustomFunction(customFunction, item, playerObj, param)
	assert(loadstring('return '..customFunction..'(...)'))(item, playerObj, param);
end

ISInventoryPaneContextMenu.onNoRecipes = function(items, item2, boolean, player)
    for i,item in ipairs(items) do
        item:setNoRecipes(player, boolean);
    end
end

ISInventoryPaneContextMenu.onWanted = function(items, player)
    for i,item in ipairs(items) do
        item:setUnwanted(player, false)
    end
end

ISInventoryPaneContextMenu.onUnwanted = function(items, player)
    for i,item in ipairs(items) do
        item:setUnwanted(player, true)
    end
end

ISInventoryPaneContextMenu.doMoreContextMenu = function(context, tests, moveItems, playerObj, items, c)
    local moreContext = context:getNew(context)
    local added = false;

    if tests.inPlayerInv then
        if tests.inPlayerInv:isFavorite() then
            local option = moreContext:addOption(getText("ContextMenu_Unfavorite"), moveItems, ISInventoryPaneContextMenu.onFavorite, tests.inPlayerInv, false)
            option.iconTexture = getTexture("media/ui/FavoriteStarUnchecked.png")
        else
            local option = moreContext:addOption(getText("IGUI_CraftUI_Favorite"), moveItems, ISInventoryPaneContextMenu.onFavorite, tests.inPlayerInv, true)
            option.iconTexture = getTexture("media/ui/FavoriteStarChecked.png")
        end
    end

    if tests.isUnwanted then
        added = true;
        if tests.isUnwanted:isUnwanted(playerObj) then
            local option = moreContext:addOption(getText("ContextMenu_Wanted"), ISInventoryPane.getActualItems(items), ISInventoryPaneContextMenu.onWanted, playerObj)
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_Wanted_tooltip");
            option.toolTip = tooltip;
        else
            local option = moreContext:addOption(getText("ContextMenu_Unwanted"), ISInventoryPane.getActualItems(items), ISInventoryPaneContextMenu.onUnwanted, playerObj)
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_Unwanted_tooltip");
            option.toolTip = tooltip;
        end
    end

    if tests.inventoryItem then
        added = true;
        if tests.inventoryItem:isNoRecipes(playerObj) then
            local option = moreContext:addOption(getText("ContextMenu_UnsetNoRecipes"), moveItems, ISInventoryPaneContextMenu.onNoRecipes, tests.inventoryItem, false, playerObj)
            option.iconTexture = getTexture("media/ui/inventoryPanes/craft.png")
        else
            local option = moreContext:addOption(getText("ContextMenu_SetNoRecipes"), moveItems, ISInventoryPaneContextMenu.onNoRecipes, tests.inventoryItem, true, playerObj)
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("ContextMenu_SetNoRecipes_tooltip");
            option.toolTip = tooltip;
            option.iconTexture = getTexture("media/ui/inventoryPanes/nocraft.png")
        end
    end

    if c == 1 and tests.scriptChecks and tests.scriptChecks:isUsedInBuildRecipes(playerObj) then
        added = true;
        ISInventoryPaneContextMenu.doBuildRecipeListForItem(moreContext, getText("ContextMenu_ShowBuildRecipesUsed"), tests.scriptChecks, playerObj)
    end

    if tests.canBeRenamed then
        added = true;
        player = playerObj:getPlayerNum()
        moreContext:addOption(getText("ContextMenu_RenameBag"), tests.canBeRenamed, ISInventoryPaneContextMenu.onRenameBag, player);
    end
    if tests.canBeRenamedFood then
        added = true;
        player = playerObj:getPlayerNum()
        moreContext:addOption(getText("ContextMenu_RenameFood") .. tests.canBeRenamedFood:getName(), tests.canBeRenamedFood, ISInventoryPaneContextMenu.onRenameFood, player);
    end

    if added then
        local moreOption = context:addOption(getText("ContextMenu_More"))
        context:addSubMenu(moreOption, moreContext)
    end
end

ISInventoryPaneContextMenu.doDebugContextMenu = function(context, items, editItem, testItem, player, playerObj, tests, c)
    local debugContext = context:getNew(context)
    local added = false;
    local debug = isDebugEnabled() or (isClient() and playerObj:getRole():hasCapability(Capability.EditItem))
    if editItem and c == 1 and debug then
        added = true;
        debugContext:addOption(getText("ContextMenu_EditItem"), items, ISInventoryPaneContextMenu.onEditItem, playerObj, testItem);
    end

    if debug and tests.keyOrigin then
        added = true;
        debugContext:addOption(getText("ContextMenu_TeleportToOrigin"), tests.keyOrigin, ISInventoryPaneContextMenu.onTeleportToKeyOrigin, player)
    end

    if not debug then
        return;
    end

    added = true;

    if tests.corpseAnimal then
        debugContext:addOption("Turn into skeleton", tests.corpseAnimal, ISInventoryPaneContextMenu.onTurnIntoSkeleton);
    end

    debugContext:addOption(getText("ContextMenu_CloneItem"), testItem, ISInventoryPaneContextMenu.onDebugCloneItem, player)

    if getDebugOptions():getBoolean("UI.UIShowResearchableEtc") then
        -- debug information regarding basic information on how anitem can be sourced
        if c == 1 and tests.scriptChecks then
            local option
            if tests.scriptChecks:isCraftRecipeProduct() then
                debugContext:addOption(getText("ContextMenu_RecipeProducedByCraft"))
            else
                option = debugContext:addOption(getText("ContextMenu_RecipeCannotProducedByCraft"));
                option.notAvailable = true;
            end
            if tests.scriptChecks:canBeForaged() then
                debugContext:addOption(getText("ContextMenu_CanBeForaged"))
            else
                option = debugContext:addOption(getText("ContextMenu_CannotBeForaged"));
                option.notAvailable = true;
            end
            if tests.scriptChecks:canSpawnAsLoot() then
                debugContext:addOption(getText("ContextMenu_CanSpawnAsLoot"))
            else
                option = debugContext:addOption(getText("ContextMenu_CannotSpawnAsLoot"));
                option.notAvailable = true;
            end
        end
        -- debug information about recipe(s), if any, that can be researched from an item
        if c == 1 and tests.scriptChecks and tests.scriptChecks:hasResearchableRecipes() then
            local recipes = tests.scriptChecks:getResearchableRecipes()
            for i=0, recipes:size()-1 do
                if getScriptManager():getCraftRecipe(recipes:get(i)) then
                    local known = playerObj:isRecipeActuallyKnown(getScriptManager():getCraftRecipe(recipes:get(i)))
                    local canLearn = (not known) and getScriptManager():getCraftRecipe(recipes:get(i)):canResearch(playerObj, true)
                    local text = getText("ContextMenu_ResearchableRecipe")
                    if known then
                        text = text .. getText("ContextMenu_Known");
                    end
                    if canLearn then
                        text = text .. getText("ContextMenu_CanLearn");
                    end
                    local postText = ""
                    if getScriptManager():getCraftRecipe(recipes:get(i)):getResearchSkillLevel() > 0 then
                        postText = getScriptManager():getCraftRecipe(recipes:get(i)):generateDebugText(playerObj)
                    end
                    debugContext:addOption(text .. ": " .. getRecipeDisplayName(recipes:get(i)) .. postText)
                end
            end
        end

        -- debug information about what recipes it can be used in
        if c == 1 and tests.scriptChecks and tests.scriptChecks:isUsedInRecipes() then
            local number = tests.scriptChecks:getUsedInRecipes():size();
            local text = getText("ContextMenu_ShowRecipesUsedIn", tostring(number));
            local usedOption = debugContext:addOption(text , tests.scriptChecks, nil);
            local usedMenu =  ISContextMenu:getNew(context)
            debugContext:addSubMenu(usedOption, usedMenu)
            local recipes = tests.scriptChecks:getUsedInRecipes()
            for i=0, recipes:size()-1 do
                local recipe2 = recipes:get(i)
                local craftRecipe = getScriptManager():getCraftRecipe(recipe2)
                local buildRecipe
                if craftRecipe then
                    local known = recipe2 and playerObj:isRecipeActuallyKnown(craftRecipe)
                    text = ""
                    if known then
                        text = getText("ContextMenu_Known");
                    end
                    usedMenu:addOption(text .. getRecipeDisplayName(recipe2))
                end
                if not craftRecipe then buildRecipe = getScriptManager():getBuildableRecipe(recipe2) end
                if buildRecipe then
                    local known = recipe2 and playerObj:isRecipeActuallyKnown(buildRecipe)
                    text = ""
                    if known then
                        text = getText("ContextMenu_Known");
                    end
                    usedMenu:addOption(text .. getRecipeDisplayName(recipe2))
                end
            end
        end
    end

    if added then
        local debugOption = context:addDebugOption(getText("ContextMenu_Debug"))
        context:addSubMenu(debugOption, debugContext)
        ISInventoryPaneContextMenu.debugContextNum = debugContext.subOptionNums;
    end
end

function ISInventoryPaneContextMenu.addFluidDebug(cont, fluid)
    cont:removeFluid();
    cont:addFluid(fluid, cont:getCapacity());
end
