ISWorldObjectContextMenu = {}
ISWorldObjectContextMenu.fetchVars = {}
ISWorldObjectContextMenu.fetchSquares = {}
ISWorldObjectContextMenu.tooltipPool = {}
ISWorldObjectContextMenu.tooltipsUsed = {}

local function predicateCleaningLiquid(item)
	if not item then return false end
	return item:hasComponent(ComponentType.FluidContainer) and (item:getFluidContainer():contains(Fluid.Bleach) or item:getFluidContainer():contains(Fluid.CleaningLiquid)) and (item:getFluidContainer():getAmount() >= ZomboidGlobals.CleanBloodBleachAmount)
end

local function predicatePetrol(item)
	return item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) and (item:getFluidContainer():getAmount() >= 0.099)
end

local function predicateStoreFuel(item)
	local fluidContainer = item:getFluidContainer()
	if not fluidContainer then return false end
	-- our item can store fluids and is empty
	if fluidContainer:isEmpty() and not fluidContainer:isInputLocked() then --and not item:isBroken()
		return true
	end
	-- or our item is already storing fuel but is not full
	if fluidContainer:contains(Fluid.Petrol) and (fluidContainer:getAmount() < fluidContainer:getCapacity()) and not item:isBroken() then
		return true
	end
	return false
end

ISWorldObjectContextMenu.clearFetch = function()
	local fetch = ISWorldObjectContextMenu.fetchVars
	table.wipe(fetch)
	fetch.c = 0
	fetch.canClimbThrough = false
	fetch.invincibleWindow = false
	fetch.canFish = false
	fetch.canAddChum = false
	fetch.canTrapFish = false
	fetch.clickedAnimals = {}
	fetch.storeWater = {}
	fetch.fluidcontainer = {}
	table.wipe(ISWorldObjectContextMenu.fetchSquares)
end

local function predicateNotBroken(item)
	return not item:isBroken()
end

local function predicateFluidRemaining(item)
	return item:getFluidContainer():getAmount() >= 1.25
end

local function predicateNotEmpty(item)
	return item:getCurrentUsesFloat() > 0
end

local function predicateNotFull(item)
	return item:getCurrentUsesFloat() < 1
end

local function predicateNotFullModItem(item)
	return item:getCurrentUsesFloat() < 1 and item:getType() ~= "CarBattery1" and item:getType() ~= "CarBattery2" and item:getType() ~= "CarBattery3"
end

local function predicateEmptySandbag(item)
	return item:hasTag("HoldCompost") and item:getInventory():isEmpty();
end

local function predicateCutPlant(item)
    return not item:isBroken() and item:hasTag("CutPlant")
end

local function predicateClearAshes(item)
	return not item:isBroken() and item:hasTag("ClearAshes")
end

local function predicateFishingLure(item)
	return item:isFishingLure()
end

local function predicatePickAxe(item)
	return not item:isBroken() and item:hasTag("PickAxe")
end

local function predicateHammerOrPickAxe(item)
	return not item:isBroken() and (item:hasTag("Hammer") or item:hasTag("Sledgehammer") or item:hasTag("ClubHammer") or item:hasTag("PickAxe"))
end

local function getMoveableDisplayName(obj)
	if not obj then return nil end
	if not obj:getSprite() then return nil end
	local props = obj:getSprite():getProperties()
	if props:Is("CustomName") then
		local name = props:Val("CustomName")
		if props:Is("GroupName") then
			name = props:Val("GroupName") .. " " .. name
		end
		return Translator.getMoveableDisplayName(name)
	end
	return nil
end

ISWorldObjectContextMenu.isSomethingTo = function(item, player)
	if not item or not item:getSquare() then
		return false
	end
	local playerObj = getSpecificPlayer(player)
	local playerSq = playerObj:getCurrentSquare()
	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerSq, item:getSquare()) then
		playerSq = AdjacentFreeTileFinder.Find(item:getSquare(), playerObj)
	end
	if playerSq and item:getSquare():isSomethingTo(playerSq) then
		return true
	end
	return false
end

-- This is for controller users.  Functions bound to OnFillWorldObjectContextMenu should
-- call this if they have any commands to add to the context menu, but only when the 'test'
-- argument to those functions is true.
function ISWorldObjectContextMenu.setTest()
	ISWorldObjectContextMenu.Test = true
	return true
end

local function predicateChopTree(item)
	return not item:isBroken() and item:hasTag("ChopTree")
end

local function predicateBlowTorch(item)
	return item:getType() == "BlowTorch" and item:getCurrentUses() >= 1
end

local function predicateRemoveBarricade(item)
	return item:hasTag("RemoveBarricade") and not item:isBroken()
end

-- MAIN METHOD FOR CREATING RIGHT CLICK CONTEXT MENU FOR WORLD ITEMS
ISWorldObjectContextMenu.createMenu = function(player, worldobjects, x, y, test)
	local timeStamp = getTimestampMs();
	
	if ISWorldObjectContextMenu.disableWorldMenu then
		return;
	end
	if getCore():getGameMode() == "Tutorial" then
		local context = Tutorial1.createWorldContextMenu(player, worldobjects, x ,y);
		return context;
	end
	-- if the game is paused, we don't show the world context menu
	if UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return;
	end

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	if playerObj:isAsleep() then return end

--    x = x + getPlayerData(player).x1left;
--    y = y + getPlayerData(player).y1top;

    local context = ISContextMenu.get(player, x, y);
	context.troughSubmenu = nil;
	context.dontShowLiquidOption = false;

    -- avoid doing action while trading (you could eat half an apple and still trade it...)
    if ISTradingUI.instance and ISTradingUI.instance:isVisible() then
        context:addOption(getText("IGUI_TradingUI_CantRightClick"), nil, nil);
        return;
	end

    context.blinkOption = ISWorldObjectContextMenu.blinkOption;

    if test then context:setVisible(false) end
    ISWorldObjectContextMenu.Test = false

	getCell():setDrag(nil, player);

	ISWorldObjectContextMenu.clearFetch()
	local fetch = ISWorldObjectContextMenu.fetchVars

	local fetchStartTime = getTimestampMs();
    for i,v in ipairs(worldobjects) do
		ISWorldObjectContextMenuLogic.fetch(fetch, v, player, true);
	end
	
	local fetchElapsedTime = getTimestampMs() - fetchStartTime;
	--print("Fetch duration: " .. fetchElapsedTime);
	
	triggerEvent("OnPreFillWorldObjectContextMenu", player, context, worldobjects, test);

    if fetch.c == 0 then
        return;
    end

    for _,tooltip in ipairs(ISWorldObjectContextMenu.tooltipsUsed) do
        table.insert(ISWorldObjectContextMenu.tooltipPool, tooltip);
    end
--    print('reused ',#ISWorldObjectContextMenu.tooltipsUsed,' world tooltips')
    table.wipe(ISWorldObjectContextMenu.tooltipsUsed);

    local pickedCorpse = IsoObjectPicker.Instance:PickCorpse(x, y)
    fetch.body = pickedCorpse or fetch.body

	--------------------------
	if ISWorldObjectContextMenuLogic.createMenuEntries(fetch, context, player, worldobjects, x, y, test or false) then return true end
	--------------------------
	
	if BrushToolManager.cheat then
		ISWorldObjectContextMenu.doBrushToolOptions(context, worldobjects, player)
	end

    if fetch.safehouseAllowInteract then
        -- use the event (as you would 'OnTick' etc) to add items to context menu without mod conflicts.
        triggerEvent("OnFillWorldObjectContextMenu", player, context, worldobjects, test);
    end

    if test then return ISWorldObjectContextMenu.Test end

    if context.numOptions == 1 then
        context:setVisible(false);
    end

	local duration = getTimestampMs() - timeStamp;
	--print("CreateMenu time taken = " .. tostring(duration) .. "ms");
	
    return context;
end

function ISWorldObjectContextMenu.activateRadio(pl, obj)
	ISRadioWindow.activate(pl, obj, true) 
end

function ISWorldObjectContextMenu.addTileDebugInfo(context, fetch)
	local option = context:addDebugOption(getText("Tile Report") .. ": " .. tostring(fetch.tilename));
	option.toolTip = ISToolTip:new()
	option.toolTip:initialise()
	option.toolTip:setVisible(false)
	option.toolTip:setName("Tile params:")
	local params = "Properties:\n"
	local props = fetch.tileObj:getProperties()
	local names = props:getPropertyNames()
	for i = 0, names:size()-1 do
		params = params .. names:get(i) .. " = " .. tostring(props:Val(names:get(i))) .. "\n"
	end
	params = params .. "\nFlags:\n"
	local flags = props:getFlagsList()
	for i = 0, flags:size()-1 do
		params = params .. tostring(flags:get(i)) .. "\n"
	end
	option.toolTip.description = params
end

function ISWorldObjectContextMenu.handleGrabWorldItem_onDropCorpse(playerObj)
	
	playerObj:setDoContinueGrapple(false)
end

function ISWorldObjectContextMenu.handleGrabWorldItem_onHighlightMultiple(_option, _menu, _isHighlighted, _objects)
	for _,object in ipairs(_objects) do
		object:setHighlighted(_menu.player, _isHighlighted, false)
		ISInventoryPage.OnObjectHighlighted(_menu.player, object, _isHighlighted)
	end
end

function ISWorldObjectContextMenu.handleGrabWorldItem_onHighlight(_option, _menu, _isHighlighted, _object)
	_object:setHighlighted(_menu.player, _isHighlighted, false)
	ISInventoryPage.OnObjectHighlighted(_menu.player, _object, _isHighlighted)
end

function ISWorldObjectContextMenu.addGrabCorpseSubmenuOption(player, worldobjects, subMenuGrab, corpse)
	local opt = subMenuGrab:addGetUpOption(getText("IGUI_ItemCat_Corpse"), worldobjects, ISWorldObjectContextMenu.onGrabCorpseItem, corpse, player);
	if ContainerButtonIcons then
		opt.iconTexture = corpse:isFemale() and ContainerButtonIcons.inventoryfemale or ContainerButtonIcons.inventorymale
	end
	local toolTip = ISWorldObjectContextMenu.addToolTip()
	toolTip.description = getText("Tooltip_GrappleCorpse")
	opt.toolTip = toolTip
	if corpse:getSquare():haveFire() then
		opt.notAvailable = true
		toolTip.description = getText("Tooltip_GrappleCorpseFire")
	end
	ISWorldObjectContextMenu.initWorldItemHighlightOption(opt, corpse)
end

local function onHighlightWorldItem(_option, _menu, _isHighlighted, _object)
	local color = getCore():getWorldItemHighlightColor()
	_object:setHighlighted(_menu.player, _isHighlighted, false)
	_object:setHighlightColor(_menu.player, color)
	_object:setOutlineHighlight(_menu.player, _isHighlighted)
	_object:setOutlineHighlightCol(_menu.player, color)
	ISInventoryPage.OnObjectHighlighted(_menu.player, _object, _isHighlighted)
end

function ISWorldObjectContextMenu.initWorldItemHighlightOption(option, object)
	option.onHighlightParams = { object }
	option.onHighlight = onHighlightWorldItem
end

function ISWorldObjectContextMenu.handleGrabCorpseSubmenu(playerObj, worldobjects, subMenuGrab)
	local fetch = ISWorldObjectContextMenu.fetchVars
	if not fetch.body then return false end
	if fetch.body:isAnimal() then return false end
	if playerObj:getVehicle() then return false end
	local playerInv = playerObj:getInventory()
	if playerInv:getItemCount("Base.CorpseMale") > 0 then return false end
	if test == true then return true; end

    local player = playerObj:getPlayerNum()
	local square = fetch.body:getSquare()
	local corpses = {}
	local corpses2 = square:getStaticMovingObjects()
	for i=1,corpses2:size() do
		table.insert(corpses, corpses2:get(i-1))
	end
	for d=1,8 do
		local square2 = square:getAdjacentSquare(IsoDirections.fromIndex(d-1))
		if square2 then
			local corpses2 = square2:getStaticMovingObjects()
			for i=1,corpses2:size() do
				table.insert(corpses, corpses2:get(i-1))
			end
		end
	end
	if #corpses > 1 then
        table.sort(corpses, function(a, b) return a:DistToSquared(playerObj) < b:DistToSquared(playerObj) end)
		for _,corpse in ipairs(corpses) do
			ISWorldObjectContextMenu.addGrabCorpseSubmenuOption(player, worldobjects, subMenuGrab, corpse)
		end
		return false
	end
	ISWorldObjectContextMenu.addGrabCorpseSubmenuOption(player, worldobjects, subMenuGrab, fetch.body)
	return false
end

function ISWorldObjectContextMenu.onExtendedPlacement(item, char)
	if luautils.walkAdj(char, item:getSquare()) then
		ISTimedActionQueue.add(ISExtendedPlacementAction:new(char, item))
	end
end

function ISWorldObjectContextMenu.openFishWindow()
	if PZAPI.UI.instances.fishWindow == nil then
		PZAPI.UI.instances.fishWindow = PZAPI.UI.FishWindow{
			y = getCore():getScreenHeight()/2
		}
		PZAPI.UI.instances.fishWindow.x = getCore():getScreenWidth()
		PZAPI.UI.instances.fishWindow:instantiate()
	else
		PZAPI.UI.instances.fishWindow:setVisible(true)
	end
end

function ISWorldObjectContextMenu.doCreateChumOptions_makeChum(pl, square)
	if luautils.walkAdj(pl, square) then
		ISTimedActionQueue.add(CreateChumFromGroundSandAction:new(pl, square))
	end
end

function ISWorldObjectContextMenu.handleCompost(test, context, worldobjects, playerObj, playerInv)
	local fetch = ISWorldObjectContextMenu.fetchVars
	local compost = fetch.compost
	if test == true then return true; end
	local option = context:addOption(getText("ContextMenu_GetCompost") .. " (" .. round(compost:getCompost(),1) .. getText("ContextMenu_FullPercent") .. ")")
	option.toolTip = ISWorldObjectContextMenu.addToolTip()
	option.toolTip:setVisible(false)
	option.toolTip:setName(getText("ContextMenu_Compost"))
	local percent = round(compost:getCompost(), 1)
	option.toolTip.description = percent .. getText("ContextMenu_FullPercent")
	local COMPOST_PER_BAG = 10
	local compostBagScriptItem = ScriptManager.instance:FindItem("Base.CompostBag")
	local USES_PER_BAG = 1.0 / compostBagScriptItem:getUseDelta()
	local COMPOST_PER_USE = COMPOST_PER_BAG / USES_PER_BAG
	if percent < COMPOST_PER_USE then
		option.toolTip.description = "<RGB:1,0,0> " .. getText("ContextMenu_CompostPercentRequired", percent, COMPOST_PER_USE)
		option.notAvailable = true
	end
	local compostBags = playerInv:getAllTypeEvalRecurse("CompostBag", predicateNotFull)
	local sandBags = playerInv:getAllEvalRecurse(predicateEmptySandbag)
	if compostBags:isEmpty() and sandBags:isEmpty() then
		option.toolTip.description = option.toolTip.description .. " <LINE> <RGB:1,0,0> " .. getText("ContextMenu_EmptySandbagRequired")
		option.notAvailable = true
	elseif not option.notAvailable then
		local subMenu = context:getNew(context)
		for i=1,compostBags:size() do
			local compostBag = compostBags:get(i-1)
			local availableUses = USES_PER_BAG - compostBag:getCurrentUses()
			subMenu:addGetUpOption(getText("ContextMenu_GetCompostItem", compostBag:getDisplayName(), math.min(percent, availableUses * COMPOST_PER_USE)), compost, ISWorldObjectContextMenu.onGetCompost, compostBag, playerObj)
		end
		for i=1,sandBags:size() do
			local sandBag = sandBags:get(i-1)
			subMenu:addGetUpOption(getText("ContextMenu_GetCompostItem", sandBag:getDisplayName(), math.min(percent, COMPOST_PER_BAG)), compost, ISWorldObjectContextMenu.onGetCompost, sandBag, playerObj)
			break -- only 1 empty sandbag listed
		end
		option.subOption = subMenu.subOptionNums
	end
	if compost:getCompost() + COMPOST_PER_USE <= 100 then
		local compostBags = playerInv:getAllTypeRecurse("CompostBag")
		if not compostBags:isEmpty() then
			local subMenu = context:getNew(context)
			for i=1,compostBags:size() do
				local compostBag = compostBags:get(i-1)
				subMenu:addGetUpOption(getText("ContextMenu_AddCompostItem", compostBag:getDisplayName(), math.min(100 - percent, compostBag:getCurrentUses() * COMPOST_PER_USE)), compost, ISWorldObjectContextMenu.onAddCompost, compostBag, playerObj)
			end
			local subMenuOption = context:addOption(getText("ContextMenu_AddCompost"))
			context:addSubMenu(subMenuOption, subMenu)
		end
	end
	return false
end

function ISWorldObjectContextMenu.emptyRainCollector(barrel, playerObj)
	if luautils.walkAdj(playerObj, barrel:getSquare()) then
		ISTimedActionQueue.add(ISEmptyRainBarrelAction:new(playerObj, barrel))
	end
end

local function onCarBatteryCharger_Activate(carBatteryCharger, playerObj)
	if luautils.walkAdj(playerObj, carBatteryCharger:getSquare()) then
		ISTimedActionQueue.add(ISActivateCarBatteryChargerAction:new(playerObj, carBatteryCharger, true))
	end
end

local function onCarBatteryCharger_Deactivate(carBatteryCharger, playerObj)
	if luautils.walkAdj(playerObj, carBatteryCharger:getSquare()) then
		ISTimedActionQueue.add(ISActivateCarBatteryChargerAction:new(playerObj, carBatteryCharger, false))
	end
end

local function onCarBatteryCharger_ConnectBattery(carBatteryCharger, playerObj, battery)
	if luautils.walkAdj(playerObj, carBatteryCharger:getSquare()) then
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, battery)
		ISTimedActionQueue.add(ISConnectCarBatteryToChargerAction:new(playerObj, carBatteryCharger, battery))
	end
end

local function onCarBatteryCharger_RemoveBattery(carBatteryCharger, playerObj)
	if luautils.walkAdj(playerObj, carBatteryCharger:getSquare()) then
		ISTimedActionQueue.add(ISRemoveCarBatteryFromChargerAction:new(playerObj, carBatteryCharger))
	end
end

local function onCarBatteryCharger_Take(carBatteryCharger, playerObj)
	if luautils.walkAdj(playerObj, carBatteryCharger:getSquare()) then
		ISTimedActionQueue.add(ISTakeCarBatteryChargerAction:new(playerObj, carBatteryCharger))
	end
end

function ISWorldObjectContextMenu.handleCarBatteryCharger(test, context, worldobjects, playerObj, playerInv)
	local fetch = ISWorldObjectContextMenu.fetchVars
	local carBatteryCharger = fetch.carBatteryCharger
	if test == true then return true end
	if carBatteryCharger:getBattery() then
		if carBatteryCharger:isActivated() then
			context:addGetUpOption(getText("ContextMenu_Turn_Off"), carBatteryCharger, onCarBatteryCharger_Deactivate, playerObj)
		else
			local option = context:addGetUpOption(getText("ContextMenu_Turn_On"), carBatteryCharger, onCarBatteryCharger_Activate, playerObj)
			if not (carBatteryCharger:getSquare():haveElectricity() or
                (  carBatteryCharger:getSquare():hasGridPower() and carBatteryCharger:getSquare():getRoom()))
--                 ( (getGameTime():getWorldAgeHours() / 24 + (getSandboxOptions():getTimeSinceApo() - 1) * 30) < getSandboxOptions():getElecShutModifier() and carBatteryCharger:getSquare():getRoom()))
                then
				option.notAvailable = true
				option.toolTip = ISWorldObjectContextMenu.addToolTip()
				option.toolTip:setVisible(false)
				option.toolTip.description = getText("IGUI_RadioRequiresPowerNearby")
			end
		end
		local label = getText("ContextMenu_CarBatteryCharger_RemoveBattery").." (" ..  math.floor(carBatteryCharger:getBattery():getCurrentUsesFloat() * 100) .. "%)"
		context:addGetUpOption(label, carBatteryCharger, onCarBatteryCharger_RemoveBattery, playerObj)
	else
		local batteryList = playerInv:getAllTypeEvalRecurse("Base.CarBattery1", predicateNotFull)
		playerInv:getAllTypeEvalRecurse("Base.CarBattery2", predicateNotFull, batteryList)
		playerInv:getAllTypeEvalRecurse("Base.CarBattery3", predicateNotFull, batteryList)
		playerInv:getAllTagEvalRecurse("Base.CarBattery", predicateNotFullModItem, batteryList)
		if not batteryList:isEmpty() then
			local chargeOption = context:addOption(getText("ContextMenu_CarBatteryCharger_ConnectBattery"))
			local subMenuCharge = context:getNew(context)
			context:addSubMenu(chargeOption, subMenuCharge)
			local done = false
			for i=1,batteryList:size() do
				local battery = batteryList:get(i-1)
				if battery:getCurrentUsesFloat() < 1 then
					local label = battery:getName() .. " (" ..  math.floor(battery:getCurrentUsesFloat() * 100) .. "%)"
					subMenuCharge:addGetUpOption(label, carBatteryCharger, onCarBatteryCharger_ConnectBattery, playerObj, battery)
					done = true
				end
			end
			if not done then context:removeLastOption() end
		end
		context:addGetUpOption(getText("ContextMenu_CarBatteryCharger_Take"), carBatteryCharger, onCarBatteryCharger_Take, playerObj)
	end
end

ISWorldObjectContextMenu.onGetCompost = function(compost, item, playerObj)
    if luautils.walkAdj(playerObj, compost:getSquare()) then
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), item, true, false)
        ISTimedActionQueue.add(ISGetCompost:new(playerObj, compost, item));
    end
end

ISWorldObjectContextMenu.onAddCompost = function(compost, item, playerObj)
    if luautils.walkAdj(playerObj, compost:getSquare()) then
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), item, true, false)
        ISTimedActionQueue.add(ISAddCompost:new(playerObj, compost, item))
    end
end

ISWorldObjectContextMenu.onRemoveFire = function(worldobjects, firetile, extinguisher, player)
    local bo = ISExtinguishCursor:new(player, extinguisher)
    getCell():setDrag(bo, bo.player)
end

ISWorldObjectContextMenu.onTakeSafeHouse = function(worldobjects, square, player)
	local playerObj = getSpecificPlayer(player)
	sendSafehouseClaim(square, playerObj, playerObj:getUsername())
end

ISWorldObjectContextMenu.onClaimWar = function(worldobjects, safehouse, attacker)
    sendWarManagerUpdate(safehouse, attacker, State.Claimed);
end

ISWorldObjectContextMenu.onViewSafeHouse = function(worldobjects, safehouse, player)
    local safehouseUI = ISSafehouseUI:new(getCore():getScreenWidth() / 2 - 250,getCore():getScreenHeight() / 2 - 225, 500, 450, safehouse, player);
    safehouseUI:initialise()
    safehouseUI:addToUIManager()
end

ISWorldObjectContextMenu.onInfoGenerator = function(worldobjects, generator, player)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, generator:getSquare()) then
		ISTimedActionQueue.add(ISGeneratorInfoAction:new(playerObj, generator))
	end
end

ISWorldObjectContextMenu.onPlugGenerator = function(worldobjects, generator, player, plug)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, generator:getSquare()) then
		ISTimedActionQueue.add(ISPlugGenerator:new(playerObj, generator, plug));
	end
end

ISWorldObjectContextMenu.onActivateGenerator = function(worldobjects, enable, generator, player)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, generator:getSquare()) then
		ISTimedActionQueue.add(ISActivateGenerator:new(playerObj, generator, enable));
	end
end

ISWorldObjectContextMenu.onFixGenerator = function(worldobjects, generator, player)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, generator:getSquare()) then
		local scrapItem = playerObj:getInventory():getFirstTypeRecurse("ElectronicsScrap");
		if scrapItem then
			ISInventoryPaneContextMenu.transferIfNeeded(playerObj, scrapItem);
			ISTimedActionQueue.add(ISFixGenerator:new(playerObj, generator));
		end;
	end
end

ISWorldObjectContextMenu.onAddFuelGenerator = function(worldobjects, petrolCan, generator, player, context)
	local playerObj = getSpecificPlayer(player)
	local playerNum = playerObj:getPlayerNum()
	local playerInv = playerObj:getInventory()
	local allContainers = {}
	local allContainerTypes = {}
	local allContainersOfType = {}
	local pourOut = playerInv:getAllEvalRecurse(function(item)

		-- our item can store fuel and is not empty
		if item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) then
			return true
		end
		return false
	end)

	if pourOut:isEmpty() then
		return
	end

	local fillOption = context:addOption(getText("ContextMenu_GeneratorAddFuel"), worldobjects, nil);
	
	
	-- if not luautils.walkAdj(playerObj, generator:getSquare()) then
		-- fillOption.notAvailable = true;
		-- --if the player can reach the tile, populate the submenu, otherwise don't bother
		-- return;
	-- end
	
	if not generator:getSquare() or not AdjacentFreeTileFinder.Find(generator:getSquare(), playerObj) then
		fillOption.notAvailable = true;
		-- if the player can reach the tile, populate the submenu, otherwise don't bother
		return;
	end
	--make a table of all containers
	for i=0, pourOut:size() - 1 do
		local container = pourOut:get(i)
		table.insert(allContainers, container)
	end

	--the table can have small groups of identical containers		eg: 1, 1, 2, 3, 1, 3, 2
	--so it needs sorting to group them all together correctly		eg: 1, 1, 1, 2, 2, 3, 3
	table.sort(allContainers, function(a,b) return not string.sort(a:getName(), b:getName()) end)

	--once sorted, we can use it to make smaller tables for each item type
	local previousContainer = nil;
	for _,container in pairs(allContainers) do
		if previousContainer ~= nil and container:getName() ~= previousContainer:getName() then
			table.insert(allContainerTypes, allContainersOfType)
			allContainersOfType = {}
		end
		table.insert(allContainersOfType, container)
		previousContainer = container
	end
	table.insert(allContainerTypes, allContainersOfType)

	--add the fill menu
	local containerMenu = ISContextMenu:getNew(context)
	local containerOption
	context:addSubMenu(fillOption, containerMenu) 
	if pourOut:size() > 1 then
		containerOption = containerMenu:addGetUpOption(getText("ContextMenu_AddAll"), worldobjects, ISWorldObjectContextMenu.doAddFuelGenerator, generator, allContainers, nil, playerNum);
	end
	--add the fill container of type menu
	for _,containerType in pairs(allContainerTypes) do
		local destItem = containerType[1]
		if #containerType > 1 then --#containerType gets the length of the table.
			containerOption = containerMenu:addOption(destItem:getName() .. " (" .. #containerType ..")", worldobjects, nil);
			containerOption.itemForTexture = destItem
			local containerTypeMenu = ISContextMenu:getNew(containerMenu)
			containerMenu:addSubMenu(containerOption, containerTypeMenu)
			local containerTypeOption
			containerTypeOption = containerTypeMenu:addGetUpOption(getText("ContextMenu_AddOne"), worldobjects, ISWorldObjectContextMenu.doAddFuelGenerator, generator, {}, destItem, playerNum);
			if containerType[2] ~= nil then
				containerTypeOption = containerTypeMenu:addGetUpOption(getText("ContextMenu_AddAll"), worldobjects, ISWorldObjectContextMenu.doAddFuelGenerator, generator, containerType, nil, playerNum);
			end
		else
			containerOption = containerMenu:addGetUpOption(destItem:getName(), worldobjects, ISWorldObjectContextMenu.doAddFuelGenerator, generator, {}, destItem, playerNum);
			containerOption.itemForTexture = destItem
			if instanceof(destItem, "DrainableComboItem") then
				local t = ISWorldObjectContextMenu.addToolTip()
				t.maxLineWidth = 512
				-- Each drainable unit adds 10% to a generator.  FIXME: A partial unit also adds 10% to a generator.
				t.description = getText("ContextMenu_FuelCapacity") .. "+" .. math.ceil(destItem:getFluidContainer():getAmount() * 10) .. "%"
				containerOption.toolTip = t
			end
		end
	end
end

ISWorldObjectContextMenu.doAddFuelGenerator = function(worldobjects, generator, fuelContainerList, fuelContainer, player)
	-- print("Size : " .. tostring(fuelContainerList))
	local playerObj = getSpecificPlayer(player)
	if not fuelContainerList or #fuelContainerList == 0 then
		fuelContainerList = {};
		table.insert(fuelContainerList, fuelContainer);
	end
	if luautils.walkAdj(playerObj, generator:getSquare()) then
		for i,item in ipairs(fuelContainerList) do
			if generator:getFuel() < 100 then
				ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), item, true, false);
				ISTimedActionQueue.add(ISAddFuel:new(playerObj, generator, item, 70 + (item:getFluidContainer():getAmount() * 40)));
			end
		end
	end
end


ISWorldObjectContextMenu.onTakeGenerator = function(worldobjects, generator, player)
	local playerObj = getSpecificPlayer(player)
	if playerObj:getVehicle() then return end
	if luautils.walkAdj(playerObj, generator:getSquare()) then
		if playerObj:getPrimaryHandItem() then
			ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
		end
		if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
			ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
		end
		ISTimedActionQueue.add(ISTakeGenerator:new(playerObj, generator));
	end
end

ISWorldObjectContextMenu.onFishingNet = function(_, player, fishNet)
    getCell():setDrag(fishingNet:new(player, fishNet), player:getPlayerNum());
end

ISWorldObjectContextMenu.onCheckFishingNet = function(worldobjects, player, trap, hours)
    ISTimedActionQueue.add(ISCheckFishingNetAction:new(player, trap, hours));
end

local function getNearestToWaterSquare(playerObj, square)
	if playerObj:getZ() ~= 0 then return nil end

	local dx = (square:getX() - playerObj:getX())/100.0
	local dy = (square:getY() - playerObj:getY())/100.0
	local x = playerObj:getX()
	local y = playerObj:getY()
	local cell = getCell()
	for i = 0, 100 do
		local sq = cell:getGridSquare(x, y, 0)
		if sq and sq:getProperties() and sq:getProperties():Is(IsoFlagType.water) then
			return sq
		end
		x = x + dx
		y = y + dy
	end
end

ISWorldObjectContextMenu.onAddBaitToWater = function(playerObj, chum, square)
	local sq = getNearestToWaterSquare(playerObj, square)
	if sq == nil then return end
	if luautils.walkAdj(playerObj, sq) then
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, chum)
		ISTimedActionQueue.add(AddChumToWaterAction:new(playerObj, chum, square));
	end
end

ISWorldObjectContextMenu.onRemoveFishingNet = function(worldobjects, player, trap)
    fishingNet.remove(trap, player);
end

ISWorldObjectContextMenu.onAddBaitToFishingNet = function(worldobjects, playerObj, trap, bait)
	if luautils.walkAdj(playerObj, getNearestToWaterSquare(playerObj, trap:getSquare())) then
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, bait)

		ISTimedActionQueue.add(ISAddBaitToFishNetAction:new(playerObj, trap, bait));
	end
end

ISWorldObjectContextMenu.getFishingLure = function(player, rod)
    if not rod then
        return nil
    end
    if WeaponType.getWeaponType(rod) == WeaponType.spear then
        return true
    end
    if player:getSecondaryHandItem() and predicateFishingLure(player:getSecondaryHandItem()) then
        return player:getSecondaryHandItem();
    end
    return player:getInventory():getFirstEvalRecurse(predicateFishingLure)
end

ISWorldObjectContextMenu.onDestroy = function(worldobjects, player, sledgehammer)
	local bo = ISDestroyCursor:new(player, false, sledgehammer)
	getCell():setDrag(bo, bo.player)
end

ISWorldObjectContextMenu.onAttachAnimalToTree = function(animal, player, tree)
	if luautils.walkAdj(player, tree:getSquare()) then
		ISTimedActionQueue.add(ISAttachAnimalToTree:new(player, animal, tree, false))
	end
end

ISWorldObjectContextMenu.onChopTree = function(worldobjects, playerObj, tree)
	local bo = ISChopTreeCursor:new("", "", playerObj)
	getCell():setDrag(bo, playerObj:getPlayerNum())
end

ISWorldObjectContextMenu.doChopTree = function(playerObj, tree)
	if not tree or tree:getObjectIndex() == -1 then return end
	if luautils.walkAdj(playerObj, tree:getSquare(), true) then
		local handItem = playerObj:getPrimaryHandItem()
		if not handItem or not predicateChopTree(handItem) then
			local handItem;
			local axes = playerObj:getInventory():getAllEvalRecurse(predicateChopTree);
			for i=0, axes:size()-1 do
				if not handItem or handItem:getTreeDamage() < axes:get(i):getTreeDamage() then
					handItem = axes:get(i);
				end
			end

			if not handItem then return end
			local primary = true
			local twoHands = not playerObj:getSecondaryHandItem()
			ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), handItem, primary, twoHands)
		end
		ISTimedActionQueue.add(ISChopTreeAction:new(playerObj, tree))
	end
end

ISWorldObjectContextMenu.onTrade = function(worldobjects, player, otherPlayer)
    local ui = ISTradingUI:new(50,50,500,500, player, otherPlayer)
    ui:initialise();
    ui:addToUIManager();
    ui.pendingRequest = true;
    ui.blockingMessage = getText("IGUI_TradingUI_WaitingAnswer", otherPlayer:getDisplayName());
    requestTrading(player, otherPlayer);
end

ISWorldObjectContextMenu.onCheckStats = function(worldobjects, player, otherPlayer)
	if ISPlayerStatsUI.instance then
		ISPlayerStatsUI.instance:close()
	end
	local ui = ISPlayerStatsUI:new(50,50,800,800, otherPlayer, player)
	ui:initialise();
	ui:addToUIManager();
	ui:setVisible(true);
end

ISWorldObjectContextMenu.onMedicalCheck = function(worldobjects, player, otherPlayer)
    if player:getRole():hasCapability(Capability.CanMedicalCheat) then
        ISTimedActionQueue.add(ISMedicalCheckAction:new(player, otherPlayer))
    else
        if luautils.walkAdj(player, otherPlayer:getCurrentSquare()) or
				(player:isSeatedInVehicle() and otherPlayer:isSeatedInVehicle() and player:getVehicle() == otherPlayer:getVehicle()) then
            ISTimedActionQueue.add(ISMedicalCheckAction:new(player, otherPlayer))
        end
    end
end

ISWorldObjectContextMenu.onWakeOther = function(worldobjects, player, otherPlayer)
    if luautils.walkAdj(player, otherPlayer:getCurrentSquare()) then
        ISTimedActionQueue.add(ISWakeOtherPlayer:new(player, otherPlayer))
    end
end

ISWorldObjectContextMenu.checkWeapon = function(chr)
    local weapon = chr:getPrimaryHandItem()
    if not weapon or weapon:getCondition() <= 0 then
        chr:removeFromHands(weapon)
        weapon = chr:getInventory():getBestWeapon(chr:getDescriptor())
        if weapon and weapon ~= chr:getPrimaryHandItem() and weapon:getCondition() > 0 then
            chr:setPrimaryHandItem(weapon)
            if weapon:isTwoHandWeapon() and not chr:getSecondaryHandItem() then
                chr:setSecondaryHandItem(weapon)
            end
        end

		if isServer() then
			sendServerCommand(chr, 'ui', 'dirtyUI', { });
		else
			ISInventoryPage.dirtyUI();
		end
    end
end

ISWorldObjectContextMenu.onToggleThumpableLight = function(lightSource, player)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, lightSource:getSquare()) then
		ISTimedActionQueue.add(ISToggleLightSourceAction:new(playerObj, lightSource))
	end
end

ISWorldObjectContextMenu.onInsertFuel = function(lightSource, fuel, playerObj)
	if luautils.walkAdj(playerObj, lightSource:getSquare()) then
		ISTimedActionQueue.add(ISInsertLightSourceFuelAction:new(playerObj, lightSource, fuel))
    end
end

ISWorldObjectContextMenu.onRemoveFuel = function(lightSource, player)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, lightSource:getSquare()) then
		ISTimedActionQueue.add(ISRemoveLightSourceFuelAction:new(playerObj, lightSource))
    end
end

ISWorldObjectContextMenu.onRest = function(bed, player)
	local playerObj = getSpecificPlayer(player)
	local bAnySpriteGridObject = true
	local action = ISPathFindAction:pathToSitOnFurniture(playerObj, bed, bAnySpriteGridObject)
	action:setOnComplete(ISWorldObjectContextMenu.onRestPathFound, playerObj, action)
	action:setOnFail(ISWorldObjectContextMenu.onRestPathFailed, playerObj, bed, action)
	ISTimedActionQueue.add(action)
end

ISWorldObjectContextMenu.onRestPathFound = function(playerObj, action)
	-- When the selected object is part of a sprite grid, the actual object the player found a path to
	-- may be different than the selected one.  We need to get it from ISPathFindAction, which got it from
	-- PathFindBehavior2.
	local after = ISRestAction:new(playerObj, action.goalFurnitureObject, true)
	if action:addAfter(after) == nil then
		ISTimedActionQueue.add(after)
	end
end

ISWorldObjectContextMenu.onRestPathFailed = function(playerObj, bed, action)
	-- The object has no seat data, or all positions are blocked.
	-- Move next to the object and then sit on the ground.
	local adjacent = AdjacentFreeTileFinder.Find(bed:getSquare(), playerObj, nil)
	if adjacent ~= nil then
		action:setRunActionsAfterFailing(true)
--		action:addAfter(ISRestAction:new(playerObj, bed, false)) -- 2nd
		action:addAfter(ISSitOnGround:new(playerObj)) -- 2nd
		if adjacent ~= playerObj:getCurrentSquare() then
			action:addAfter(ISWalkToTimedAction:new(playerObj, adjacent)) -- 1st
		end
	end
end

ISWorldObjectContextMenu.sleepDialog = nil;

ISWorldObjectContextMenu.onSleep = function(bed, player)
	if ISWorldObjectContextMenu.sleepDialog then
		return;
	end
	ISWorldObjectContextMenu.sleepDialog = ISModalDialog:new(0,0, 250, 150, getText("IGUI_ConfirmSleep"), true, nil, ISWorldObjectContextMenu.onConfirmSleep, player, player, bed);
	ISWorldObjectContextMenu.sleepDialog:initialise()
	ISWorldObjectContextMenu.sleepDialog:addToUIManager()
    if JoypadState.players[player+1] then
        setJoypadFocus(player, ISWorldObjectContextMenu.sleepDialog)
    end
end

local function tryAddLocationAdjacentToBed(bedSquare, direction, added, locations)
    local adjacent = bedSquare:getAdjacentSquare(direction)
    if adjacent == nil then return end
    if luautils.tableContains(added, adjacent) then
        return
    end
    table.insert(added, adjacent)
    if AdjacentFreeTileFinder.isTileOrAdjacent(bedSquare, adjacent) then
        table.insert(locations, adjacent:getX() + 0.5)
        table.insert(locations, adjacent:getY() + 0.5)
        table.insert(locations, adjacent:getZ())
    end
end

local function tryAddLocationsAdjacentToBed(bedSquare, added, locations)
    tryAddLocationAdjacentToBed(bedSquare, IsoDirections.N, added, locations)
    tryAddLocationAdjacentToBed(bedSquare, IsoDirections.S, added, locations)
    tryAddLocationAdjacentToBed(bedSquare, IsoDirections.W, added, locations)
    tryAddLocationAdjacentToBed(bedSquare, IsoDirections.E, added, locations)
end

local function isSquareOnDiagonal(square, adjacent)
    if square == nil or adjacent == nil then return false end
    return (square:getX() - adjacent:getX() ~= 0) and (square:getY() - adjacent:getY() ~= 0)
end

function ISWorldObjectContextMenu.onConfirmSleep(this, button, player, bed)
	ISWorldObjectContextMenu.sleepDialog = nil;
	if button.internal == "YES" then
		local playerObj = getSpecificPlayer(player)
		playerObj:setVariable("ExerciseStarted", false);
		playerObj:setVariable("ExerciseEnded", true);
		ISTimedActionQueue.clear(playerObj)
		if bed then
			if bed:hasSpriteGrid() then
				local objects = ArrayList.new()
				bed:getSpriteGridObjectsIncludingSelf(objects)
				if playerObj:isSittingOnFurniture() and objects:contains(playerObj:getSitOnFurnitureObject()) then
					ISWorldObjectContextMenu.onSleepWalkToComplete(player, playerObj:getSitOnFurnitureObject())
					return
				end
				local added = {}
				local locations = {}
				for i=1,objects:size() do
					local object = objects:get(i-1)
					if not isSquareOnDiagonal(object:getSquare(), playerObj:getCurrentSquare()) and AdjacentFreeTileFinder.isTileOrAdjacent(object:getSquare(), playerObj:getCurrentSquare()) then
						ISWorldObjectContextMenu.onSleepWalkToComplete(player, object)
						return
					end
					tryAddLocationsAdjacentToBed(object:getSquare(), added, locations)
				end
				local action = ISPathFindAction:pathToNearest(playerObj, locations)
				-- NOTE: 'bed' may not be the nearest IsoSpriteGrid object the player ends up adjacent to.
				action:setOnComplete(ISWorldObjectContextMenu.onSleepWalkToComplete, player, bed)
				ISTimedActionQueue.add(action)
				return
			end
			if AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), bed:getSquare()) then
				ISWorldObjectContextMenu.onSleepWalkToComplete(player, bed)
			else
				local adjacent = AdjacentFreeTileFinder.Find(bed:getSquare(), playerObj)
				if adjacent ~= nil then
					local action = ISWalkToTimedAction:new(playerObj, adjacent)
					action:setOnComplete(ISWorldObjectContextMenu.onSleepWalkToComplete, player, bed)
					ISTimedActionQueue.add(action)
				end
			end
		else
			ISWorldObjectContextMenu.onSleepWalkToComplete(player, bed)
		end
    end
end

function ISWorldObjectContextMenu.onSleepWalkToComplete(player, bed)
	local playerObj = getSpecificPlayer(player)
	local isZombies = playerObj:getStats():getNumVisibleZombies() > 0 or playerObj:getStats():getNumChasingZombies() > 0 or playerObj:getStats():getNumVeryCloseZombies() > 0
    if isZombies then
		-- playerObj:Say(getText("IGUI_Sleep_NotSafe"))
			HaloTextHelper.addBadText(playerObj, getText("IGUI_Sleep_NotSafe"));
-- 			HaloTextHelper.addText(playerObj, getText("IGUI_Sleep_NotSafe"), getCore():getGoodHighlitedColor());
		return
    end
	if playerObj:getSleepingTabletEffect() < 2000 then
        if playerObj:getMoodles():getMoodleLevel(MoodleType.Pain) >= 2 and playerObj:getStats():getFatigue() <= 0.85 then
			-- playerObj:Say(getText("ContextMenu_PainNoSleep"))
			HaloTextHelper.addBadText(playerObj, getText("ContextMenu_PainNoSleep"));
-- 			HaloTextHelper.addText(playerObj, getText("ContextMenu_PainNoSleep"), getCore():getGoodHighlitedColor());
			return
		end
		if playerObj:getMoodles():getMoodleLevel(MoodleType.Panic) >= 1 then
			-- playerObj:Say(getText("ContextMenu_PanicNoSleep"))
			HaloTextHelper.addBadText(playerObj, getText("ContextMenu_PanicNoSleep"));
-- 			HaloTextHelper.addText(playerObj, getText("ContextMenu_PanicNoSleep"), getCore():getGoodHighlitedColor());
			return
		end
	end

	if (playerObj:getVariableBoolean("ExerciseEnded") == false) then
		return
	end

	ISTimedActionQueue.clear(playerObj)
	local bedType = ISWorldObjectContextMenu.getBedQuality(playerObj, bed)
    playerObj:setBed(bed);
    playerObj:setBedType(bedType);
	if isClient() and getServerOptions():getBoolean("SleepAllowed") then
		if playerObj:getVehicle() then
			playerObj:playSound("VehicleGoToSleep")
		end
		playerObj:setAsleepTime(0.0)
		playerObj:setAsleep(true)
		UIManager.setFadeBeforeUI(player, true)
		UIManager.FadeOut(player, 1)
		return
    end
	local modal = nil;
    local sleepFor = ZombRand(playerObj:getStats():getFatigue() * 10, playerObj:getStats():getFatigue() * 13) + 1;
    if bedType == "goodBed" or bedType:contains("goodBedPillow") then
        sleepFor = sleepFor -1;
    end
    if bedType == "badBed" or bedType:contains("badBedPillow") then
        sleepFor = sleepFor +1;
    end
	if bedType == "floor" or bedType:contains("floorPillow") then
		sleepFor = sleepFor * 0.7;
	end
    if playerObj:HasTrait("Insomniac") then
        sleepFor = sleepFor * 0.5;
    end
    if playerObj:HasTrait("NeedsLessSleep") then
        sleepFor = sleepFor * 0.75;
    end
    if playerObj:HasTrait("NeedsMoreSleep") then
        sleepFor = sleepFor * 1.18;
    end

    if sleepFor > 16 then sleepFor = 16; end
    if sleepFor < 3 then sleepFor = 3; end
        --print("GONNA SLEEP " .. sleepFor .. " HOURS" .. " AND ITS " .. GameTime.getInstance():getTimeOfDay())
    local sleepHours = sleepFor + GameTime.getInstance():getTimeOfDay()
    if sleepHours >= 24 then
        sleepHours = sleepHours - 24
    end

    if playerObj:getVehicle() then
        playerObj:playSound("VehicleGoToSleep")
    end

    playerObj:setForceWakeUpTime(tonumber(sleepHours))
    playerObj:setAsleepTime(0.0)
    playerObj:setAsleep(true)
    getSleepingEvent():setPlayerFallAsleep(playerObj, sleepFor);

    UIManager.setFadeBeforeUI(playerObj:getPlayerNum(), true)
    UIManager.FadeOut(playerObj:getPlayerNum(), 1)

    if IsoPlayer.allPlayersAsleep() then
        UIManager.getSpeedControls():SetCurrentGameSpeed(3)
        save(true)
    end
end

function ISWorldObjectContextMenu.onToggleClothingDryer(worldobjects, object, playerId)
	local playerObj = getSpecificPlayer(playerId)
	if object:getSquare() and luautils.walkAdj(playerObj, object:getSquare()) then
		ISTimedActionQueue.add(ISToggleClothingDryer:new(playerObj, object))
	end
end

function ISWorldObjectContextMenu.onToggleClothingWasher(worldobjects, object, playerId)
	local playerObj = getSpecificPlayer(playerId)
	if object:getSquare() and luautils.walkAdj(playerObj, object:getSquare()) then
		ISTimedActionQueue.add(ISToggleClothingWasher:new(playerObj, object))
	end
end

function ISWorldObjectContextMenu.toggleComboWasherDryer(context, playerObj, object)
	local playerNum = playerObj:getPlayerNum()

	if not object then return end
	if not object:getContainer() then return end
	if ISWorldObjectContextMenu.isSomethingTo(object, playerNum) then return end
	if getCore():getGameMode() == "LastStand" then return end

	local objectName = object:getName() or "Combo Washer/Dryer"
	local props = object:getProperties()
	if props then
		local groupName = props:Is("GroupName") and props:Val("GroupName") or nil
		local customName = props:Is("CustomName") and props:Val("CustomName") or nil
		if groupName and customName then
			objectName = Translator.getMoveableDisplayName(groupName .. " " .. customName)
		elseif customName then
			objectName = Translator.getMoveableDisplayName(customName)
		end
	end

	local subOption = context:addOption(objectName)
	local subMenu = ISContextMenu:getNew(context)
	context:addSubMenu(subOption, subMenu)

	local option = nil
	if object:isActivated() then
		option = subMenu:addGetUpOption(getText("ContextMenu_Turn_Off"), playerObj, ISWorldObjectContextMenu.onToggleComboWasherDryer, object)
	else
		option = subMenu:addGetUpOption(getText("ContextMenu_Turn_On"), playerObj, ISWorldObjectContextMenu.onToggleComboWasherDryer, object)
	end
	local label = object:isModeWasher() and getText("ContextMenu_ComboWasherDryer_SetModeDryer") or getText("ContextMenu_ComboWasherDryer_SetModeWasher")
	if not object:getContainer():isPowered() or (object:isModeWasher() and (object:getFluidAmount() <= 0)) then
		option.notAvailable = true
		option.toolTip = ISWorldObjectContextMenu.addToolTip()
		option.toolTip:setVisible(false)
		option.toolTip:setName(getMoveableDisplayName(object))
		if not object:getContainer():isPowered() then
			option.toolTip.description = getText("IGUI_RadioRequiresPowerNearby")
		end
		if object:isModeWasher() and (object:getFluidAmount() <= 0) then
			if option.toolTip.description ~= "" then
				option.toolTip.description = option.toolTip.description .. "\n" .. getText("IGUI_RequiresWaterSupply")
			else
				option.toolTip.description = getText("IGUI_RequiresWaterSupply")
			end
		end
	end
	option = subMenu:addGetUpOption(label, playerObj, ISWorldObjectContextMenu.onSetComboWasherDryerMode, object, object:isModeWasher() and "dryer" or "washer")
end

function ISWorldObjectContextMenu.onToggleComboWasherDryer(playerObj, object)
	if object:getSquare() and luautils.walkAdj(playerObj, object:getSquare()) then
		ISTimedActionQueue.add(ISToggleComboWasherDryer:new(playerObj, object))
	end
end

function ISWorldObjectContextMenu.onSetComboWasherDryerMode(playerObj, object, mode)
	if object:getSquare() and luautils.walkAdj(playerObj, object:getSquare()) then
		ISTimedActionQueue.add(ISSetComboWasherDryerMode:new(playerObj, object, mode))
	end
end

ISWorldObjectContextMenu.onToggleStove = function(worldobjects, stove, player)
	local playerObj = getSpecificPlayer(player)
	if stove:getSquare() and luautils.walkAdj(playerObj, stove:getSquare()) then
		ISTimedActionQueue.add(ISToggleStoveAction:new(playerObj, stove))
	end
end

ISWorldObjectContextMenu.onMicrowaveSetting = function(worldobjects, stove, player)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdj(playerObj, stove:getSquare()) then
        ISTimedActionQueue.add(ISOvenUITimedAction:new(playerObj, nil, stove))
    end
end

ISWorldObjectContextMenu.onStoveSetting = function(worldobjects, stove, player)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdj(playerObj, stove:getSquare()) then
        ISTimedActionQueue.add(ISOvenUITimedAction:new(playerObj, stove, nil))
    end
end

function ISWorldObjectContextMenu.doLightSwitchOption(test, context, player)
    local fetch = ISWorldObjectContextMenu.fetchVars
    local worldobjects = nil
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	local option = nil
    if fetch.lightSwitch ~= nil and not ISWorldObjectContextMenu.isSomethingTo(fetch.lightSwitch, player) then
        local canSwitch = fetch.lightSwitch:canSwitchLight();
        if canSwitch then --(SandboxVars.ElecShutModifier > -1 and GameTime.getInstance():getNightsSurvived() < SandboxVars.ElecShutModifier) or fetch.lightSwitch:getSquare():haveElectricity() then
            if test == true then return true; end
            if fetch.lightSwitch:isActivated() then
                option = context:addGetUpOption(getText("ContextMenu_Turn_Off"), worldobjects, ISWorldObjectContextMenu.onToggleLight, fetch.lightSwitch, player);
            else
                option = context:addGetUpOption(getText("ContextMenu_Turn_On"), worldobjects, ISWorldObjectContextMenu.onToggleLight, fetch.lightSwitch, player);
            end
            option.iconTexture = getTexture("Item_LightBulb")
        end

        if fetch.lightSwitch:getCanBeModified() then
            if test == true then return true; end

            -- if not modified yet, give option to modify this lamp so it uses battery instead of power
            if not fetch.lightSwitch:getUseBattery() then
                if playerObj:getPerkLevel(Perks.Electricity) >= ISLightActions.perkLevel then
                    if playerInv:containsTagEvalRecurse("Screwdriver", predicateNotBroken) and playerInv:containsTypeRecurse("ElectronicsScrap") then
                        context:addGetUpOption(getText("ContextMenu_CraftBatConnector"), worldobjects, ISWorldObjectContextMenu.onLightModify, fetch.lightSwitch, player);
                    end
                end
            end

            -- if its modified add the battery options
            if fetch.lightSwitch:getUseBattery() then
                if fetch.lightSwitch:getHasBattery() then
                    local removeOption = context:addGetUpOption(getText("ContextMenu_Remove_Battery"), worldobjects, ISWorldObjectContextMenu.onLightBattery, fetch.lightSwitch, player, true);
                    if playerObj:DistToSquared(fetch.lightSwitch:getX() + 0.5, fetch.lightSwitch:getY() + 0.5) < 2 * 2 then
                        local item = ScriptManager.instance:getItem("Base.Battery")
                        local tooltip = ISWorldObjectContextMenu.addToolTip()
                        tooltip:setName(item and item:getDisplayName() or "???")
                        tooltip.description = getText("IGUI_RemainingPercent", luautils.round(math.ceil(fetch.lightSwitch:getPower()*100),0))
                        removeOption.toolTip = tooltip
                    end
                elseif playerInv:containsTypeRecurse("Battery") then
                    local batteryOption = context:addOption(getText("ContextMenu_AddBattery"), worldobjects, nil);
                    local subMenuBattery = ISContextMenu:getNew(context);
                    context:addSubMenu(batteryOption, subMenuBattery);

                    local batteries = playerInv:getAllTypeEvalRecurse("Battery", predicateNotEmpty)
                    for n = 0,batteries:size()-1 do
                        local battery = batteries:get(n)
                        if instanceof(battery, 'DrainableComboItem') and battery:getCurrentUsesFloat() > 0 then
                            local insertOption = subMenuBattery:addGetUpOption(battery:getName(), worldobjects, ISWorldObjectContextMenu.onLightBattery, fetch.lightSwitch, player, false, battery);
                            local tooltip = ISWorldObjectContextMenu.addToolTip()
                            tooltip:setName(battery:getName())
                            tooltip.description = getText("IGUI_RemainingPercent", luautils.round(math.ceil(battery:getCurrentUsesFloat()*100),0))
                            insertOption.toolTip = tooltip
                        end
                    end

                end
            end

            -- lightbulbs can be changed regardless, as long as the lamp can be modified (which are all isolightswitches that are movable, see IsoLightSwitch constructor)
            if fetch.lightSwitch:hasLightBulb() then
                context:addGetUpOption(getText("ContextMenu_RemoveLightbulb"), worldobjects, ISWorldObjectContextMenu.onLightBulb, fetch.lightSwitch, player, true);
            else
                local items = playerInv:getAllEvalRecurse(function(item) return luautils.stringStarts(item:getType(), "LightBulb") end)

                local cache = {};
                local found = false;
                for i=0, items:size()-1 do
                    local testitem = items:get(i);
                    if cache[testitem:getType()]==nil then
                        cache[testitem:getType()]=testitem;
                        found = true;
                    end
                end

                if found then
                    local bulbOption = context:addOption(getText("ContextMenu_AddLightbulb"), worldobjects, nil);
                    local subMenuBulb = ISContextMenu:getNew(context);
                    context:addSubMenu(bulbOption, subMenuBulb);

                    for _,bulb in pairs(cache) do
                        subMenuBulb:addGetUpOption(bulb:getName(), worldobjects, ISWorldObjectContextMenu.onLightBulb, fetch.lightSwitch, player, false, bulb);
                    end
                end
            end

        end
        if false then
            print("can switch = ",canSwitch);
            print("has bulb = ",fetch.lightSwitch:hasLightBulb());
            print("used battery = ", fetch.lightSwitch:getUseBattery());
            print("is modable = ",fetch.lightSwitch:getCanBeModified());
        end
    end
    return false
end

ISWorldObjectContextMenu.onToggleLight = function(worldobjects, light, player)
	local playerObj = getSpecificPlayer(player)
	if light:getObjectIndex() == -1 then return end
	local dir = nil
	local props = light:getSprite() and light:getSprite():getProperties()
	if props and props:Is(IsoFlagType.attachedN) then dir = IsoDirections.N
	elseif props and props:Is(IsoFlagType.attachedS) then dir = IsoDirections.S
	elseif props and props:Is(IsoFlagType.attachedW) then dir = IsoDirections.W
	elseif props and props:Is(IsoFlagType.attachedE) then dir = IsoDirections.E
	end
	if dir then
		local adjacent = AdjacentFreeTileFinder.FindEdge(light:getSquare(), dir, playerObj, true)
		if adjacent then
			if adjacent ~= playerObj:getCurrentSquare() then
				ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
			end
			ISTimedActionQueue.add(ISToggleLightAction:new(playerObj, light))
			return
		end
	end
	if light:getSquare() and luautils.walkAdj(playerObj, light:getSquare()) then
		ISTimedActionQueue.add(ISToggleLightAction:new(playerObj, light))
	end
end

ISWorldObjectContextMenu.onLightBulb = function(worldobjects, light, player, remove, bulbitem)
    local playerObj = getSpecificPlayer(player)
    if light:getSquare() and luautils.walkAdj(playerObj, light:getSquare()) then
        if remove then
            ISTimedActionQueue.add(ISLightActions:new("RemoveLightBulb",playerObj, light));
        else
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, bulbitem)
            ISTimedActionQueue.add(ISLightActions:new("AddLightBulb",playerObj, light, bulbitem));
        end
    end
end

ISWorldObjectContextMenu.onLightModify = function(worldobjects, light, player, scrapitem)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if light:getSquare() and luautils.walkAdj(playerObj, light:getSquare()) then
        local screwdriver = playerInv:getFirstTagEvalRecurse("Screwdriver", predicateNotBroken)
        local scrapItem = playerInv:getFirstTypeRecurse("ElectronicsScrap")
        if not screwdriver or not scrapItem then return end
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), screwdriver, true, false)
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), scrapItem, false, false)
        ISTimedActionQueue.add(ISLightActions:new("ModifyLamp",playerObj, light, scrapItem));
    end
end

ISWorldObjectContextMenu.onLightBattery = function(worldobjects, light, player, remove, battery)
    local playerObj = getSpecificPlayer(player)
    if light:getSquare() and luautils.walkAdj(playerObj, light:getSquare()) then
        if remove then
            ISTimedActionQueue.add(ISLightActions:new("RemoveBattery",playerObj, light));
        else
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, battery)
            ISTimedActionQueue.add(ISLightActions:new("AddBattery",playerObj, light, battery));
        end
    end
end

function ISWorldObjectContextMenu.doThumpableWindowOption(test, context, player)
    local fetch = ISWorldObjectContextMenu.fetchVars
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    local worldobjects = nil
    if fetch.thumpableWindow then
        local addCurtains = fetch.thumpableWindow:HasCurtains();
        local movedWindow = fetch.thumpableWindow:getSquare():getWindow(fetch.thumpableWindow:getNorth())
        -- barricade, addsheet, etc...
        -- you can do action only inside a house
        -- add sheet (curtains) to window (sheet on 1st hand)
        if not addCurtains and not movedWindow and playerInv:containsTypeRecurse("Sheet") then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_Add_sheet"), worldobjects, ISWorldObjectContextMenu.onAddSheet, fetch.thumpableWindow, player);
        end
        if not movedWindow and fetch.thumpableWindow:canClimbThrough(playerObj) then
            if test == true then return true; end
            local climboption = context:addGetUpOption(getText("ContextMenu_Climb_through"), worldobjects, ISWorldObjectContextMenu.onClimbThroughWindow, fetch.thumpableWindow, player);
            if not JoypadState.players[player+1] then
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_Info"))
                tooltip.description = getText("Tooltip_TapKey", getKeyName(getCore():getKey("Interact")));
                climboption.toolTip = tooltip;
            end
        end
	elseif fetch.thump and fetch.thump:isHoppable() and fetch.thump:canClimbOver(playerObj) then
		if test == true then return true; end
		local climbDir = nil
		local climboption = context:addGetUpOption(getText("ContextMenu_Climb_over"), worldobjects, ISWorldObjectContextMenu.onClimbOverFence, fetch.thump, climbDir, player);
		if not JoypadState.players[player+1] then
			local tooltip = ISWorldObjectContextMenu.addToolTip()
			tooltip:setName(getText("ContextMenu_Info"))
			tooltip.description = getText("Tooltip_Climb", getKeyName(getCore():getKey("Interact")));
			climboption.toolTip = tooltip;
		end
	end
    return false
end

ISWorldObjectContextMenu.onWaterDispenserBottle = function(playerObj, waterdispenser, bottle)
	if luautils.walkAdj(playerObj, waterdispenser:getSquare(), false) then
		ISTimedActionQueue.add(ISAddTakeDispenserBottle:new(playerObj, waterdispenser, bottle));
	end	
end

ISWorldObjectContextMenu.onButcherHook = function(hook, playerObj)
	if luautils.walkAdj(playerObj, hook:getSquare(), false) then
		ISTimedActionQueue.add(ISOpenButcherHookUI:new(playerObj, hook));
	end
end

-- This should return the same value as ISInventoryTransferAction
ISWorldObjectContextMenu.grabItemTime = function(playerObj, witem)
	local maxTime = 120;
	-- increase time for bigger objects or when backpack is more full.
	local destCapacityDelta = 1.0;
	local inv = playerObj:getInventory();
	destCapacityDelta = inv:getCapacityWeight() / inv:getMaxWeight();

	if destCapacityDelta < 0.4 then
		destCapacityDelta = 0.4;
	end

	local w = witem:getItem():getActualWeight();
	if w > 3 then w = 3; end;
	maxTime = maxTime * (w) * destCapacityDelta;

	if getCore():getGameMode()=="LastStand" then
		maxTime = maxTime * 0.3;
	end

	if playerObj:HasTrait("Dextrous") then
		maxTime = maxTime * 0.5
	end
	if playerObj:HasTrait("AllThumbs") or playerObj:isWearingAwkwardGloves() then
		maxTime = maxTime * 2.0
	end

	if playerObj:isTimedActionInstant() then
		maxTime = 1;
	end

	return maxTime;
--    local w = witem:getItem():getActualWeight()
--    if w > 3 then w = 3 end
--    local dest = playerObj:getInventory()
--    local destCapacityDelta = dest:getCapacityWeight() / dest:getMaxWeight()
--
--	return 50 * w * destCapacityDelta
end

ISWorldObjectContextMenu.onGrabWItem = function(worldobjects, WItem, player)
	local playerObj = getSpecificPlayer(player)
    if WItem:getSquare() and luautils.walkAdj(playerObj, WItem:getSquare()) then
		local time = ISWorldObjectContextMenu.grabItemTime(playerObj, WItem)
		if isClient() then
			ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, WItem:getItem(), WItem:getItem():getContainer(), playerObj:getInventory()));
		else
			ISTimedActionQueue.add(ISGrabItemAction:new(playerObj, WItem, time))
		end
	end
end

ISWorldObjectContextMenu.onGrabHalfWItems = function(worldobjects, WItems, player)
	WItem = WItems[1]
	local playerObj = getSpecificPlayer(player)
	if WItem:getSquare() and luautils.walkAdj(playerObj, WItem:getSquare()) then
		local time = ISWorldObjectContextMenu.grabItemTime(playerObj, WItem)
		local count = 0
		for _,WItem in ipairs(WItems) do
			if isClient() then
				ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, WItem:getItem(), WItem:getItem():getContainer(), playerObj:getInventory()));
			else
				ISTimedActionQueue.add(ISGrabItemAction:new(playerObj, WItem, time))
			end
			count = count + 1
			if count >= #WItems / 2 then return end
		end
    end
end

ISWorldObjectContextMenu.onGrabAllWItems = function(worldobjects, WItems, player)
	WItem = WItems[1]
	local playerObj = getSpecificPlayer(player)
	if WItem:getSquare() and luautils.walkAdj(playerObj, WItem:getSquare()) then
		local time = ISWorldObjectContextMenu.grabItemTime(playerObj, WItem)
		for _,WItem in ipairs(WItems) do
			if isClient() then
				ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, WItem:getItem(), WItem:getItem():getContainer(), playerObj:getInventory()));
			else
				ISTimedActionQueue.add(ISGrabItemAction:new(playerObj, WItem, time))
			end
		end
	end
end

ISWorldObjectContextMenu.onTakeTrap = function(worldobjects, trap, player)
	local playerObj = getSpecificPlayer(player)
	if trap:getObjectIndex() ~= -1 and luautils.walkAdj(playerObj, trap:getSquare(), false) then
		ISTimedActionQueue.add(ISTakeTrap:new(playerObj, trap));
	end
end

ISWorldObjectContextMenu.onGrabCorpseItem = function(worldobjects, WItem, player)
	local playerObj = getSpecificPlayer(player)
	local locations = {}
	local pos = WItem:getGrabHeadPosition(Vector2f.new())
	table.insert(locations, pos:x())
	table.insert(locations, pos:y())
	table.insert(locations, WItem:getZ())
	pos = WItem:getGrabLegsPosition(pos)
	table.insert(locations, pos:x())
	table.insert(locations, pos:y())
	table.insert(locations, WItem:getZ())
	if playerObj:isSitOnGround() then
		playerObj:setVariable("forceGetUp", true)
	end
	ISTimedActionQueue.add(ISPathFindAction:pathToNearest(playerObj, locations))
	if playerObj:getPrimaryHandItem() then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
	end
	if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
		ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
	end
	ISTimedActionQueue.add(ISGrabCorpseAction:new(playerObj, WItem));
--[[
	if WItem:getSquare() and luautils.walkAdj(playerObj, WItem:getSquare()) then
		if playerObj:getPrimaryHandItem() then
			ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getPrimaryHandItem(), 50));
		end
		if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem() ~= playerObj:getPrimaryHandItem() then
			ISTimedActionQueue.add(ISUnequipAction:new(playerObj, playerObj:getSecondaryHandItem(), 50));
		end
		ISTimedActionQueue.add(ISGrabCorpseAction:new(playerObj, WItem));
	end
--]]
end

ISWorldObjectContextMenu.onGetDoorKey = function(worldobjects, player, door, doorKeyId)
	if isClient() then
		SendCommandToServer("/addkey \"" .. getSpecificPlayer(player):getDisplayName() .. "\" \"" .. luautils.trim(tostring(doorKeyId)) .. "\"")
	else
		local newKey = instanceItem("Base.Key1")
		getSpecificPlayer(player):getInventory():AddItem(newKey);
		newKey:setKeyId(doorKeyId);
		door:setHaveKey(false);
	end
end

ISWorldObjectContextMenu.onLockDoor = function(worldobjects, player, door)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdjWindowOrDoor(getSpecificPlayer(player), door:getSquare(), door) then
        ISTimedActionQueue.add(ISLockDoor:new(playerObj, door, true));
    end
end

ISWorldObjectContextMenu.onUnLockDoor = function(worldobjects, player, door, doorKeyId)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdjWindowOrDoor(getSpecificPlayer(player), door:getSquare(), door) then
        ISTimedActionQueue.add(ISLockDoor:new(playerObj, door, false));
    end
end

ISWorldObjectContextMenu.onPlumbItem = function(worldobjects, player, itemToPipe)
	local playerObj = getSpecificPlayer(player)
	local wrench = playerObj:getInventory():getFirstTypeEvalRecurse("PipeWrench", predicateNotBroken) or playerObj:getInventory():getFirstTagEvalRecurse("PipeWrench", predicateNotBroken);
	ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), wrench, true)
	ISTimedActionQueue.add(ISPlumbItem:new(playerObj, itemToPipe, wrench));
end

ISWorldObjectContextMenu.onRemoveDigitalPadlockWalkToComplete = function(player, thump)
    local modal = ISDigitalCode:new(0, 0, 230, 120, nil, ISWorldObjectContextMenu.onCheckDigitalCode, player, nil, thump, true);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
end

ISWorldObjectContextMenu.onRemoveDigitalPadlock = function(worldobjects, player, thump)
    local playerObj = getSpecificPlayer(player)
    ISTimedActionQueue.clear(playerObj)

	if AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), thump:getSquare()) then
		ISWorldObjectContextMenu.onRemoveDigitalPadlockWalkToComplete(player, thump)
	else
		local adjacent = AdjacentFreeTileFinder.Find(thump:getSquare(), playerObj)
		if adjacent ~= nil then
			local action = ISWalkToTimedAction:new(playerObj, adjacent)
			action:setOnComplete(ISWorldObjectContextMenu.onRemoveDigitalPadlockWalkToComplete, player, thump)
			ISTimedActionQueue.add(action)
		end
	end
end

ISWorldObjectContextMenu.onPutDigitalPadlockWalkToComplete = function(player, thump, padlock)
    local modal = ISDigitalCode:new(0, 0, 230, 120, nil, ISWorldObjectContextMenu.onSetDigitalCode, player, padlock, thump, true);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
end

ISWorldObjectContextMenu.onPutDigitalPadlock = function(worldobjects, player, thump, padlock)

    local playerObj = getSpecificPlayer(player)
    ISTimedActionQueue.clear(playerObj)

	if AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), thump:getSquare()) then
		ISWorldObjectContextMenu.onPutDigitalPadlockWalkToComplete(player, thump, padlock)
	else
		local adjacent = AdjacentFreeTileFinder.Find(thump:getSquare(), playerObj)
		if adjacent ~= nil then
			local action = ISWalkToTimedAction:new(playerObj, adjacent)
			action:setOnComplete(ISWorldObjectContextMenu.onPutDigitalPadlockWalkToComplete, player, thump, padlock)
			ISTimedActionQueue.add(action)
		end
	end
end

function ISWorldObjectContextMenu:onSetDigitalCode(button, playerObj, padlock, thump)
    local dialog = button.parent
    if button.internal == "OK" and dialog:getCode() ~= 0 then
		if luautils.walkAdj(playerObj, thump:getSquare()) then
			ISTimedActionQueue.add(ISPadlockByCodeAction:new(playerObj, thump, padlock, true, dialog:getCode()));
		end
    end
end

function ISWorldObjectContextMenu:onCheckDigitalCode(button, playerObj, padlock, thump)
    local dialog = button.parent
    if button.internal == "OK" then
        if thump:getLockedByCode() == dialog:getCode() then
			if luautils.walkAdj(playerObj, thump:getSquare()) then
				ISTimedActionQueue.add(ISPadlockByCodeAction:new(playerObj, thump, padlock, false, dialog:getCode()));
			end
        end
    end
end

ISWorldObjectContextMenu.onExcavateStairs = function(worldobjects, player, excavatableFloor)
    DiggingUtil.excavatingStairs = true;

end

ISWorldObjectContextMenu.onPutPadlock = function(worldobjects, player, thump, padlock)
    local playerObj = getSpecificPlayer(player)

    if luautils.walkAdj(playerObj, thump:getSquare()) then
        ISTimedActionQueue.add(ISPadlockAction:new(playerObj, thump, padlock, true));
    end
end

ISWorldObjectContextMenu.onRemovePadlock = function(worldobjects, player, thump)
    local playerObj = getSpecificPlayer(player)

    if luautils.walkAdj(playerObj, thump:getSquare()) then
        ISTimedActionQueue.add(ISPadlockAction:new(playerObj, thump, nil, false));
    end
end

ISWorldObjectContextMenu.onClearAshes = function(worldobjects, player, ashes)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if ashes:getSquare() and luautils.walkAdj(playerObj, ashes:getSquare()) then
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateClearAshes, true)
        ISTimedActionQueue.add(ISClearAshes:new(playerObj, ashes));
    end
end

ISWorldObjectContextMenu.onBurnCorpse = function(worldobjects, player, corpse)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if corpse:getSquare() and luautils.walkAdj(playerObj, corpse:getSquare()) then
        if playerInv:containsTagRecurse("StartFire") then
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), playerInv:getFirstTagRecurse("StartFire"), true, false)
        elseif playerInv:containsTypeRecurse("Lighter") then
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), playerInv:getFirstTypeRecurse("Lighter"), true, false)
        elseif playerObj:getInventory():containsTypeRecurse("Matches") then
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), playerInv:getFirstTypeRecurse("Matches"), true, false)
        end
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), playerInv:getFirstEvalRecurse(predicatePetrol), false, false)
        ISTimedActionQueue.add(ISBurnCorpseAction:new(playerObj, corpse));
    end
end

function ISWorldObjectContextMenu.compareClothingBlood(item1, item2)
	return ISWashClothing.GetRequiredSoap(item1) < ISWashClothing.GetRequiredSoap(item2)
end

local function createWaterSourceTooltip(sink)
	local tooltip = ISWorldObjectContextMenu.addToolTip()
	local source = nil
	if instanceof(sink, "IsoWorldInventoryObject") then
		source = sink:getItem():getName()
	else
		source = tostring(getMoveableDisplayName(sink))
		if source == "nil" then
			source = getText("ContextMenu_NaturalWaterSource")
		end
	end
	if sink:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
		if tooltip.description ~= "" then
			tooltip.description = tooltip.description .. "\n" .. "<RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
		else
			tooltip.description = "<RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
		end
	end
	tooltip.maxLineWidth = 512
	if tooltip.description == "" then
		return nil
	end
	return tooltip
end

ISWorldObjectContextMenu.doFillFluidMenu = function(sink, playerNum, context)
	local playerObj = getSpecificPlayer(playerNum)
	if sink:getSquare():getBuilding() ~= playerObj:getBuilding() then return end;
	local playerInv = playerObj:getInventory()
	local allContainers = {}
	local allContainerTypes = {}
	local allContainersOfType = {}
	local pourInto = playerInv:getAllEvalRecurse(function(item)
		if item:getFluidContainer() and (not item:getFluidContainer():isFull()) and item:getFluidContainer():canAddFluid(Fluid.Water) then
			return true;
		end
		return false
	end)

	if pourInto:isEmpty() then
		return
	end

	local fillOption = context:addOption(getText("ContextMenu_Fill"), worldobjects, nil);
	if not sink:getSquare() then --or not AdjacentFreeTileFinder.Find(sink:getSquare(), playerObj)
		fillOption.notAvailable = true;
		--if the player can reach the tile, populate the submenu, otherwise don't bother
		return;
	end

	--make a table of all containers
	for i=0, pourInto:size() - 1 do
		local container = pourInto:get(i)
		if sink:canTransferFluidTo(container:getFluidContainer()) then
			table.insert(allContainers, container)
		end
	end

	--the table can have small groups of identical containers		eg: 1, 1, 2, 3, 1, 3, 2
	--so it needs sorting to group them all together correctly		eg: 1, 1, 1, 2, 2, 3, 3
	table.sort(allContainers, function(a,b) return not string.sort(a:getName(), b:getName()) end)

	--once sorted, we can use it to make smaller tables for each item type
	local previousContainer = nil;
	for _,container in pairs(allContainers) do
		if previousContainer ~= nil and container:getName() ~= previousContainer:getName() then
			table.insert(allContainerTypes, allContainersOfType)
			allContainersOfType = {}
		end
		table.insert(allContainersOfType, container)
		previousContainer = container
	end
	table.insert(allContainerTypes, allContainersOfType)

	--add the fill menu
	local containerMenu = ISContextMenu:getNew(context)
	local containerOption
	context:addSubMenu(fillOption, containerMenu)
	local tooltip = createWaterSourceTooltip(sink)
	if #allContainers > 1 then
		containerOption = containerMenu:addGetUpOption(getText("ContextMenu_FillAll"), worldobjects, ISWorldObjectContextMenu.onTakeWater, sink, allContainers, nil, playerNum);
		containerOption.toolTip = tooltip
	end

	--add the fill container of type menu
	for _,containerType in pairs(allContainerTypes) do
		if #containerType > 0 then
			local destItem = containerType[1]
			if #containerType > 1 then --#containerType gets the length of the table.
				containerOption = containerMenu:addOption(destItem:getName() .. " (" .. #containerType ..")", worldobjects, nil);
				containerOption.itemForTexture = destItem
				local containerTypeMenu = ISContextMenu:getNew(containerMenu)
				containerMenu:addSubMenu(containerOption, containerTypeMenu)
				local containerTypeOption
				containerTypeOption = containerTypeMenu:addGetUpOption(getText("ContextMenu_FillOne"), worldobjects, ISWorldObjectContextMenu.onTakeWater, sink, {}, destItem, playerNum);
				containerTypeOption.toolTip = tooltip
				if containerType[2] ~= nil then
					containerTypeOption = containerTypeMenu:addGetUpOption(getText("ContextMenu_FillAll"), worldobjects, ISWorldObjectContextMenu.onTakeWater, sink, containerType, nil, playerNum);
					containerTypeOption.toolTip = tooltip
				end
			else
				containerOption = containerMenu:addOption(destItem:getName(), worldobjects, ISWorldObjectContextMenu.onTakeWater, sink, nil, destItem, playerNum);
				containerOption.itemForTexture = destItem
				local t = createWaterSourceTooltip(sink)
				if instanceof(destItem, "DrainableComboItem") then
					t.description = t.description .. " <LINE> " .. getText("ContextMenu_ItemWaterCapacity") .. ": " .. math.floor(destItem:getCurrentUsesFloat()*10) .. "/10"
				end
				containerOption.toolTip = t
			end
		end
	end
end

ISWorldObjectContextMenu.doFillFuelMenu = function(source, playerNum, context)
	local playerObj = getSpecificPlayer(playerNum)
	if source:getSquare():getBuilding() ~= playerObj:getBuilding() then return end;
    local playerInv = playerObj:getInventory()
    local allContainers = {}
    local allContainerTypes = {}
    local allContainersOfType = {}
    local pourInto = playerInv:getAllEvalRecurse(predicateStoreFuel)

    if pourInto:isEmpty() then
        return
    end

    local fillOption = context:addOption(getText("ContextMenu_TakeGasFromPump"), worldobjects, nil);
    if not source:getSquare() or not AdjacentFreeTileFinder.Find(source:getSquare(), playerObj) then
        fillOption.notAvailable = true;
        --if the player can reach the tile, populate the submenu, otherwise don't bother
        return;
    end

    --make a table of all containers
    for i=0, pourInto:size() - 1 do
        local container = pourInto:get(i)
        table.insert(allContainers, container)
    end

    --the table can have small groups of identical containers		eg: 1, 1, 2, 3, 1, 3, 2
    --so it needs sorting to group them all together correctly		eg: 1, 1, 1, 2, 2, 3, 3
    table.sort(allContainers, function(a,b) return not string.sort(a:getName(), b:getName()) end)

    --once sorted, we can use it to make smaller tables for each item type
    local previousContainer = nil;
    for _,container in pairs(allContainers) do
        if previousContainer ~= nil and container:getName() ~= previousContainer:getName() then
            table.insert(allContainerTypes, allContainersOfType)
            allContainersOfType = {}
        end
        table.insert(allContainersOfType, container)
        previousContainer = container
    end
    table.insert(allContainerTypes, allContainersOfType)

    --add the fill menu
    local containerMenu = ISContextMenu:getNew(context)
    local containerOption
    context:addSubMenu(fillOption, containerMenu)
    if pourInto:size() > 1 then
        containerOption = containerMenu:addGetUpOption(getText("ContextMenu_FillAll"), worldobjects, ISWorldObjectContextMenu.onTakeFuelNew, source, allContainers, nil, playerNum);
    end
    --add the fill container of type menu
    for _,containerType in pairs(allContainerTypes) do
        local destItem = containerType[1]
        if #containerType > 1 then --#containerType gets the length of the table.
            containerOption = containerMenu:addOption(destItem:getName() .. " (" .. #containerType ..")", worldobjects, nil);
            containerOption.itemForTexture = destItem
            local containerTypeMenu = ISContextMenu:getNew(containerMenu)
            containerMenu:addSubMenu(containerOption, containerTypeMenu)
            local containerTypeOption
            containerTypeOption = containerTypeMenu:addGetUpOption(getText("ContextMenu_FillOne"), worldobjects, ISWorldObjectContextMenu.onTakeFuelNew, source, nil, destItem, playerNum);
            if containerType[2] ~= nil then
                containerTypeOption = containerTypeMenu:addGetUpOption(getText("ContextMenu_FillAll"), worldobjects, ISWorldObjectContextMenu.onTakeFuelNew, source, containerType, nil, playerNum);
            end
        else
            containerOption = containerMenu:addGetUpOption(destItem:getName(), worldobjects, ISWorldObjectContextMenu.onTakeFuelNew, source, nil, destItem, playerNum);
            containerOption.itemForTexture = destItem
            if destItem:getFluidContainer() then
                local t = ISWorldObjectContextMenu.addToolTip()
                t.maxLineWidth = 512
                t.description = getText("ContextMenu_FuelCapacity") .. string.format("%d / %d", destItem:getFluidContainer():getFreeCapacity(), destItem:getFluidContainer():getCapacity())
                containerOption.toolTip = t
            end
        end
    end
end

local function formatWaterAmount(object, setX, amount, max)
	-- Water tiles have waterAmount=9999
	-- Piped water has waterAmount=10000
	if max >= 9999 then
		return string.format("%s: <SETX:%d> %s", object:getFluidUiName(), setX, getText("Tooltip_WaterUnlimited"))
	end
	return string.format("%s: <SETX:%d> %s / %s", object:getFluidUiName(), setX, luautils.round(amount, 2) .. "L", luautils.round(max, 2) .. "L")
end

ISWorldObjectContextMenu.doDrinkWaterMenu = function(object, player, context)
	local playerObj = getSpecificPlayer(player)
	local thirst = playerObj:getStats():getThirst()
	--if thirst <= 0 then
	--	return;
	--end
	if object:getSquare():getBuilding() ~= playerObj:getBuilding() then return end;
	if instanceof(object, "IsoClothingDryer") then return end
	if instanceof(object, "IsoClothingWasher") then return end
	local option = context:addGetUpOption(getText("ContextMenu_Drink"), worldobjects, ISWorldObjectContextMenu.onDrink, object, player);
	local units = math.min(math.ceil(thirst / 0.1), 10)
	units = math.min(units, object:getFluidAmount())
	local tooltip = ISWorldObjectContextMenu.addToolTip()
	local tx1 = getTextManager():MeasureStringX(tooltip.font, getText("Tooltip_food_Thirst") .. ":") + 20
	local tx2 = getTextManager():MeasureStringX(tooltip.font, object:getFluidUiName() .. ":") + 20
	local tx = math.max(tx1, tx2)
	local waterAmount = object:getFluidAmount();
	local waterMax = object:getFluidCapacity();
	tooltip.description = tooltip.description ..formatWaterAmount(object, tx, waterAmount, waterMax);
		--	tooltip.description = tooltip.description .. string.format("%s: <SETX:%d> -%d / %d <LINE> %s",
		--getText("Tooltip_food_Thirst"), tx, math.min(units * 10, thirst * 100), thirst * 100,
		--formatWaterAmount(tx, waterAmount, waterMax))
	if object:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
		tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
	end
	option.toolTip = tooltip;
	option.iconTexture = getTexture("Item_WaterDrop");
end

ISWorldObjectContextMenu.calculateSoapAndWaterRequired = function(washList)
	local soapRequired = 0
	local waterRequired = 0
	for _,item in ipairs(washList) do
		soapRequired = soapRequired + ISWashClothing.GetRequiredSoap(item)
		waterRequired = waterRequired + ISWashClothing.GetRequiredWater(item)
	end
	return soapRequired, waterRequired
end

ISWorldObjectContextMenu.setWashClothingTooltip = function(soapRemaining, waterRemaining, washList, option)
    local tooltip = ISWorldObjectContextMenu.addToolTip()
    local soapRequired, waterRequired = ISWorldObjectContextMenu.calculateSoapAndWaterRequired(washList)
    if soapRemaining < soapRequired then
        tooltip.description = tooltip.description .. getText("IGUI_Washing_WithoutSoap") .. " <LINE> "
    else
        tooltip.description = tooltip.description .. getText("IGUI_Washing_Soap") .. ": " .. round(math.min(soapRemaining, soapRequired), 2) .. " / " .. tostring(soapRequired) .. " <LINE> "
    end
    tooltip.description = tooltip.description .. getText("ContextMenu_WaterName") .. ": " .. round(math.min(waterRemaining, waterRequired), 2) .. " / " .. tostring(waterRequired)
    option.toolTip = tooltip
    if waterRemaining < waterRequired then
        option.notAvailable = true
    end
end


ISWorldObjectContextMenu.doWashClothingMenu = function(sink, player, context)
	local playerObj = getSpecificPlayer(player)
	if sink:getSquare():getBuilding() ~= playerObj:getBuilding() then return end;
	local playerInv = playerObj:getInventory()
	local washYourself = false
	local washEquipment = false
	local washList = {}
	local soapList = {}
	local noSoap = true

	washYourself = ISWashYourself.GetRequiredWater(playerObj) > 0

	local barList = playerInv:getItemsFromType("Soap2", true)
	for i=0, barList:size() - 1 do
		local item = barList:get(i)
		table.insert(soapList, item)
	end

	local bottleList = playerInv:getAllEvalRecurse(predicateCleaningLiquid)
	for i=0, bottleList:size() - 1 do
		local item = bottleList:get(i)
		table.insert(soapList, item)
	end

	local washClothing = {}
	local clothingInventory = playerInv:getItemsFromCategory("Clothing")
	for i=0, clothingInventory:size() - 1 do
		local item = clothingInventory:get(i)
		-- Wasn't able to reproduce the wash 'Blooo' bug, don't know the exact cause so here's a fix...
		if not item:isHidden() and (item:hasBlood() or item:hasDirt()) and not item:hasTag("BreakWhenWet") then
			if washEquipment == false then
				washEquipment = true
			end
			table.insert(washList, item)
			table.insert(washClothing, item)
		end
	end

	local washOther = {}
	local dirtyRagInventory = playerInv:getAllTag("CanBeWashed", ArrayList.new())
	for i=0, dirtyRagInventory:size() - 1 do
		local item = dirtyRagInventory:get(i)
		if item:getJobDelta() == 0 then
			if washEquipment == false then
				washEquipment = true
			end
			table.insert(washList, item)
			table.insert(washOther, item)
		end
	end

	local washWeapon = {}
	local weaponInventory = playerInv:getItemsFromCategory("Weapon")
	for i=0, weaponInventory:size() - 1 do
		local item = weaponInventory:get(i)
		if item:hasBlood() then
			if washEquipment == false then
				washEquipment = true
			end
			table.insert(washList, item)
			table.insert(washWeapon, item)
		end
	end

	local washContainer = {}
	local containerInventory = playerInv:getItemsFromCategory("Container")
	for i=0, containerInventory:size() - 1 do
		local item = containerInventory:get(i)
		if not item:isHidden() and (item:hasBlood() or item:hasDirt()) then
			washEquipment = true
			table.insert(washList, item)
			table.insert(washContainer, item)
		end
	end

	-- Sort items from least-bloody to most-bloody.
	table.sort(washList, ISWorldObjectContextMenu.compareClothingBlood)
	table.sort(washClothing, ISWorldObjectContextMenu.compareClothingBlood)
	table.sort(washOther, ISWorldObjectContextMenu.compareClothingBlood)
	table.sort(washWeapon, ISWorldObjectContextMenu.compareClothingBlood)
	table.sort(washContainer, ISWorldObjectContextMenu.compareClothingBlood)

	if washYourself or washEquipment then
		local mainOption = context:addOption(getText("ContextMenu_Wash"), nil, nil);
		local mainSubMenu = ISContextMenu:getNew(context)
		context:addSubMenu(mainOption, mainSubMenu)
	
--		if #soapList < 1 then
--			mainOption.notAvailable = true;
--			local tooltip = ISWorldObjectContextMenu.addToolTip();
--			tooltip:setName("Need soap.");
--			mainOption.toolTip = tooltip;
--			return;
--		end
		local soapRemaining = 0;
		if soapList and #soapList >= 1 then
			soapRemaining = ISWashClothing.GetSoapRemaining(soapList)
		end
		local waterRemaining = sink:getFluidAmount()
	
		if washYourself then
			local soapRequired = ISWashYourself.GetRequiredSoap(playerObj)
			local waterRequired = ISWashYourself.GetRequiredWater(playerObj)
			local option = mainSubMenu:addGetUpOption(getText("ContextMenu_Yourself"), playerObj, ISWorldObjectContextMenu.onWashYourself, sink, soapList)
			local tooltip = ISWorldObjectContextMenu.addToolTip()
			if soapRemaining < soapRequired then
				tooltip.description = tooltip.description .. getText("IGUI_Washing_WithoutSoap") .. " <LINE> "
			else
				tooltip.description = tooltip.description .. getText("IGUI_Washing_Soap") .. ": " .. round(math.min(soapRemaining, soapRequired), 2) .. " / " .. tostring(soapRequired) .. " <LINE> "
			end
			tooltip.description = tooltip.description .. getText("ContextMenu_WaterName") .. ": " .. round(math.min(waterRemaining, waterRequired), 2) .. " / " .. tostring(waterRequired)
			local visual = playerObj:getHumanVisual()
			local bodyBlood = 0
			local bodyDirt = 0
			for i=1,BloodBodyPartType.MAX:index() do
				local part = BloodBodyPartType.FromIndex(i-1)
				bodyBlood = bodyBlood + visual:getBlood(part)
				bodyDirt = bodyDirt + visual:getDirt(part)
			end
			if bodyBlood > 0 then
				tooltip.description = tooltip.description .. " <LINE> " .. getText("Tooltip_clothing_bloody") .. ": " .. math.ceil(bodyBlood / BloodBodyPartType.MAX:index() * 100) .. " / 100"
			end
			if bodyDirt > 0 then
				tooltip.description = tooltip.description .. " <LINE> " .. getText("Tooltip_clothing_dirty") .. ": " .. math.ceil(bodyDirt / BloodBodyPartType.MAX:index() * 100) .. " / 100"
			end
			option.toolTip = tooltip
			if waterRemaining < 1 then
				option.notAvailable = true
			end
		end
		
		if washEquipment then
			if #washList > 0 then
				local soapRequired = 0
				local waterRequired = 0
				local option = nil
				if #washClothing > 0 then
					soapRequired, waterRequired = ISWorldObjectContextMenu.calculateSoapAndWaterRequired(washClothing)
					noSoap = soapRequired < soapRemaining
					option = mainSubMenu:addGetUpOption(getText("ContextMenu_WashAllClothing"), playerObj, ISWorldObjectContextMenu.onWashClothing, sink, soapList, washClothing, nil, noSoap);
					ISWorldObjectContextMenu.setWashClothingTooltip(soapRemaining, waterRemaining, washClothing, option)
				end
				if #washContainer > 0 then
					soapRequired, waterRequired = ISWorldObjectContextMenu.calculateSoapAndWaterRequired(washContainer)
					noSoap = soapRequired < soapRemaining
					option = mainSubMenu:addGetUpOption(getText("ContextMenu_WashAllContainer"), playerObj, ISWorldObjectContextMenu.onWashClothing, sink, soapList, washContainer, nil, noSoap);
					ISWorldObjectContextMenu.setWashClothingTooltip(soapRemaining, waterRemaining, washContainer, option)
				end
				if #washWeapon > 0 then
					soapRequired, waterRequired = ISWorldObjectContextMenu.calculateSoapAndWaterRequired(washWeapon)
					noSoap = soapRequired < soapRemaining
					option = mainSubMenu:addGetUpOption(getText("ContextMenu_WashAllWeapon"), playerObj, ISWorldObjectContextMenu.onWashClothing, sink, soapList, washWeapon, nil, noSoap);
					ISWorldObjectContextMenu.setWashClothingTooltip(soapRemaining, waterRemaining, washWeapon, option)
				end
				if #washOther > 0 then
					soapRequired, waterRequired = ISWorldObjectContextMenu.calculateSoapAndWaterRequired(washOther)
					noSoap = soapRequired < soapRemaining
					option = mainSubMenu:addGetUpOption(getText("ContextMenu_WashAllOther"), playerObj, ISWorldObjectContextMenu.onWashClothing, sink, soapList, washOther, nil, noSoap);
					ISWorldObjectContextMenu.setWashClothingTooltip(soapRemaining, waterRemaining, washOther, option)
				end
			end
			for i,item in ipairs(washList) do
				local soapRequired = ISWashClothing.GetRequiredSoap(item)
				local waterRequired = ISWashClothing.GetRequiredWater(item)
				local tooltip = ISWorldObjectContextMenu.addToolTip();
				if (soapRemaining < soapRequired) then
					tooltip.description = tooltip.description .. getText("IGUI_Washing_WithoutSoap") .. " <LINE> "
					noSoap = true;
				else
					tooltip.description = tooltip.description .. getText("IGUI_Washing_Soap") .. ": " .. tostring(math.min(soapRemaining, soapRequired)) .. " / " .. tostring(soapRequired) .. " <LINE> "
					noSoap = false;
				end
				tooltip.description = tooltip.description .. getText("ContextMenu_WaterName") .. ": " .. string.format("%.2f", math.min(waterRemaining, waterRequired)) .. " / " .. tostring(waterRequired)
				if (item:IsClothing() or item:IsInventoryContainer()) and (item:getBloodLevel() > 0) then
					tooltip.description = tooltip.description .. " <LINE> " .. getText("Tooltip_clothing_bloody") .. ": " .. math.ceil(item:getBloodLevel()) .. " / 100"
				end
				if item:IsWeapon() and (item:getBloodLevel() > 0) then
					tooltip.description = tooltip.description .. " <LINE> " .. getText("Tooltip_clothing_bloody") .. ": " .. math.ceil(item:getBloodLevel() * 100) .. " / 100"
				end
				if item:IsClothing() and item:getDirtyness() > 0 then
					tooltip.description = tooltip.description .. " <LINE> " .. getText("Tooltip_clothing_dirty") .. ": " .. math.ceil(item:getDirtyness()) .. " / 100"
				end
				local option = mainSubMenu:addGetUpOption(getText("ContextMenu_WashClothing", item:getDisplayName()), playerObj, ISWorldObjectContextMenu.onWashClothing, sink, soapList, nil, item, noSoap);
				option.toolTip = tooltip;
				option.itemForTexture = item
				if (waterRemaining < waterRequired) then
					option.notAvailable = true;
				end
			end
		end
	end
end

ISWorldObjectContextMenu.onWashClothing = function(playerObj, sink, soapList, washList, singleClothing, noSoap)
	if not sink:getSquare() or not luautils.walkAdj(playerObj, sink:getSquare(), true) then
		return
	end

	if not washList then
		washList = {};
		table.insert(washList, singleClothing);
	end
    
	for i,item in ipairs(washList) do
		local bloodAmount = 0
		local dirtAmount = 0
		if instanceof(item, "Clothing") then
			if BloodClothingType.getCoveredParts(item:getBloodClothingType()) then
				local coveredParts = BloodClothingType.getCoveredParts(item:getBloodClothingType())
				for j=0, coveredParts:size()-1 do
					local thisPart = coveredParts:get(j)
					bloodAmount = bloodAmount + item:getBlood(thisPart)
				end
			end
			if item:getDirtyness() > 0 then
				dirtAmount = dirtAmount + item:getDirtyness()
			end
		else
			bloodAmount = bloodAmount + item:getBloodLevel()
		end
		ISTimedActionQueue.add(ISWashClothing:new(playerObj, sink, soapList, item, bloodAmount, dirtAmount, noSoap))
	end
end

ISWorldObjectContextMenu.onWashYourself = function(playerObj, sink, soapList)
	if not sink:getSquare() or not luautils.walkAdj(playerObj, sink:getSquare(), true) then
		return
	end
	
	ISTimedActionQueue.add(ISWashYourself:new(playerObj, sink, soapList));
end

-----

local CleanBandages = {}

function CleanBandages.onCleanOne(playerObj, type, waterObject, recipe)
	local playerInv = playerObj:getInventory()
	local item = playerInv:getFirstTypeRecurse(type)
	if not item then return end
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
	if not luautils.walkAdj(playerObj, waterObject:getSquare(), true) then return end
	ISTimedActionQueue.add(ISCleanBandage:new(playerObj, item, waterObject, recipe))
end

function CleanBandages.onCleanMultiple(playerObj, type, waterObject, recipe)
	local playerInv = playerObj:getInventory()
	local items = playerInv:getSomeTypeRecurse(type, waterObject:getFluidAmount())
	if items:isEmpty() then return end
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, items)
	if not luautils.walkAdj(playerObj, waterObject:getSquare(), true) then return end
	for i=1,items:size() do
		local item = items:get(i-1)
		ISTimedActionQueue.add(ISCleanBandage:new(playerObj, item, waterObject, recipe))
	end
end

function CleanBandages.onCleanAll(playerObj, waterObject, itemData)
	local waterRemaining = waterObject:getFluidAmount()
	if waterRemaining < 1 then return end
	local playerInv = playerObj:getInventory()
	local items = ArrayList.new()
	local itemToRecipe = {}
	for _,data in ipairs(itemData) do
		local first = items:size()
		playerInv:getSomeTypeRecurse(data.itemType, waterRemaining - items:size(), items)
		for i=first,items:size()-1 do
			itemToRecipe[items:get(i)] = data.recipe
		end
		if waterRemaining <= items:size() then
			break
		end
	end
	if items:isEmpty() then return end
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, items)
	if not luautils.walkAdj(playerObj, waterObject:getSquare(), true) then return end
	for i=1,items:size() do
		local item = items:get(i-1)
		local recipe = itemToRecipe[item]
		ISTimedActionQueue.add(ISCleanBandage:new(playerObj, item, waterObject, recipe))
	end
end

function CleanBandages.getAvailableItems(items, playerObj, recipeName, itemType)
	local recipe = getScriptManager():getRecipe(recipeName)
	if not recipe then return nil end
	local playerInv = playerObj:getInventory()
	local count = playerInv:getCountTypeRecurse(itemType)
	if count == 0 then return end
	table.insert(items, { itemType = itemType, count = count, recipe = recipe })
end

function CleanBandages.setSubmenu(subMenu, item, waterObject)
	local itemType = item.itemType
	local count = item.count
	local recipe = item.recipe
	local waterRemaining = waterObject:getFluidAmount()

	local tooltip = nil
	local notAvailable = false
	if waterObject:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
		tooltip = ISWorldObjectContextMenu.addToolTip()
		tooltip.description =  " <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
		tooltip.maxLineWidth = 512
		notAvailable = true
	else
		tooltip = ISRecipeTooltip.addToolTip()
		tooltip.character = getSpecificPlayer(subMenu.player)
		tooltip.recipe = recipe
		tooltip:setName(recipe:getName())
		local resultItem = getScriptManager():FindItem(recipe:getResult():getFullType())
		if resultItem and resultItem:getNormalTexture() and resultItem:getNormalTexture():getName() ~= "Question_On" then
			tooltip:setTexture(resultItem:getNormalTexture():getName())
		end
	end

	if count > 1 then
		local subOption = subMenu:addOption(recipe:getName())
		local subMenu2 = ISContextMenu:getNew(subMenu)
		subMenu:addSubMenu(subOption, subMenu2)

		local option1 = subMenu2:addActionsOption(getText("ContextMenu_One"), CleanBandages.onCleanOne, itemType, waterObject, recipe)
		option1.toolTip = tooltip
		option1.notAvailable = notAvailable

		local option2 = subMenu2:addActionsOption(getText("ContextMenu_AllWithCount", math.min(count, waterRemaining)), CleanBandages.onCleanMultiple, itemType, waterObject, recipe)
		option2.toolTip = tooltip
		option2.notAvailable = notAvailable
	else
		local option = subMenu:addActionsOption(recipe:getName(), CleanBandages.onCleanOne, itemType, waterObject, recipe)
		option.toolTip = tooltip
		option.notAvailable = notAvailable
	end
end

local function setTileCursor(tilename, playerObj)
	local cursor = ISBrushToolTileCursor:new(tilename, tilename, playerObj)
	getCell():setDrag(cursor, playerObj:getPlayerNum())
end

local function destroyTile(obj)
	if isClient() then
		sledgeDestroy(obj)
	else
		obj:getSquare():transmitRemoveItemFromSquare(obj)
	end
end

ISWorldObjectContextMenu.doBrushToolOptions = function(context, worldobjects, player)
	local addTooltip = function(option, spriteName)
		local tooltip = ISToolTip:new();
		tooltip:initialise();
		tooltip:setName("");
		tooltip:setTexture(spriteName);
		option.toolTip = tooltip
	end

	local playerObj = getSpecificPlayer(player)

	context:addOption("Brush Tool Manager", playerObj, BrushToolManager.openPanel)

	local copyOption = context:addOption("Copy tile", worldobjects)
	local copySubMenu = context:getNew(context)
	context:addSubMenu(copyOption, copySubMenu)

	local destoyOption = context:addOption("Destroy tile", worldobjects)
	local destoySubMenu = context:getNew(context)
	context:addSubMenu(destoyOption, destoySubMenu)

	local opt = nil
	for _, obj in ipairs(worldobjects) do
		if obj:getSprite() ~= nil and obj:getSprite():getName() ~= nil then
			opt = copySubMenu:addOption("[MAIN] " .. obj:getSprite():getName(), obj:getSprite():getName(), setTileCursor, playerObj)
			addTooltip(opt, obj:getSprite():getName())
			opt = destoySubMenu:addOption(obj:getSprite():getName(), obj, destroyTile)
			addTooltip(opt, obj:getSprite():getName())
		end

		if obj:getOverlaySprite() ~= nil and obj:getOverlaySprite():getName() ~= nil then
			opt = copySubMenu:addOption("[OVERLAY] " .. obj:getOverlaySprite():getName(), obj:getOverlaySprite():getName(), nil, playerObj, setTileCursor, playerObj)
			addTooltip(opt, obj:getOverlaySprite():getName())
		end

		local attachedSprites = obj:getAttachedAnimSprite()
		if attachedSprites ~= nil then
			for i = 0, attachedSprites:size()-1 do
				local sprite = attachedSprites:get(i):getParentSprite()
				if sprite and sprite:getName() ~= nil then
					opt = copySubMenu:addOption("[ATTACHED] " .. sprite:getName(), sprite:getName(), setTileCursor, playerObj)
					addTooltip(opt, sprite:getName())
				end
			end
		end
	end
end

ISWorldObjectContextMenu.doRecipeUsingWaterMenu = function(waterObject, playerNum, context)
	local playerObj = getSpecificPlayer(playerNum)
	local playerInv = playerObj:getInventory()

	local waterRemaining = waterObject:getFluidAmount()
	if waterRemaining < 1 then return end

	-- It would perhaps be better to allow *any* recipes that require water to take water from a clicked-on
	-- water-containing object.  This would be similar to how RecipeManager.isNearItem() works.
	-- We would need to pass the water-containing object to RecipeManager, or pick one in isNearItem().

	local items = {}
	CleanBandages.getAvailableItems(items, playerObj, "Base.Clean Bandage", "Base.BandageDirty")
	CleanBandages.getAvailableItems(items, playerObj, "Base.Clean Denim Strips", "Base.DenimStripsDirty")
	CleanBandages.getAvailableItems(items, playerObj, "Base.Clean Leather Strips", "Base.LeatherStripsDirty")
	CleanBandages.getAvailableItems(items, playerObj, "Base.Clean Rag", "Base.RippedSheetsDirty")

	if #items == 0 then return end

	ISRecipeTooltip.releaseAll()

	-- If there's a single item type, don't display the extra submenu.
	if #items == 1 then
		CleanBandages.setSubmenu(context, items[1], waterObject)
		return
	end

	local subMenu = ISContextMenu:getNew(context)
	local subOption = context:addOption(getText("ContextMenu_CleanBandageEtc"))
	context:addSubMenu(subOption, subMenu)

	local numItems = 0
	for _,item in ipairs(items) do
		numItems = numItems + item.count
	end
	local option = subMenu:addActionsOption(getText("ContextMenu_AllWithCount", math.min(numItems, waterRemaining)), CleanBandages.onCleanAll, waterObject, items)
	if waterObject:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
		tooltip = ISWorldObjectContextMenu.addToolTip()
		tooltip.description =  " <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
		tooltip.maxLineWidth = 512
		option.toolTip = tooltip
		option.notAvailable = true
	end

	for _,item in ipairs(items) do
		CleanBandages.setSubmenu(subMenu, item, waterObject)
	end
end

ISWorldObjectContextMenu.onDrink = function(worldobjects, waterObject, player)
    local playerObj = getSpecificPlayer(player)
	if not waterObject:getSquare() or not luautils.walkAdj(playerObj, waterObject:getSquare(), true) then
		return
	end
	local mask = ISInventoryPaneContextMenu.getEatingMask(playerObj, true)
	ISTimedActionQueue.add(ISTakeWaterAction:new(playerObj, nil, waterObject, waterObject:isTaintedWater()));
    if mask then
        ISTimedActionQueue.add(ISWearClothing:new(playerObj, mask, 50))
    end
end

ISWorldObjectContextMenu.onTakeWater = function(worldobjects, waterObject, waterContainerList, waterContainer, player)
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	local waterAvailable = waterObject:getFluidAmount()

	if not waterContainerList or #waterContainerList == 0 then
		waterContainerList = {};
		table.insert(waterContainerList, waterContainer);
	end

	local didWalk = false

	for i,item in ipairs(waterContainerList) do
		-- first case, fill an empty bottle
		if item:canStoreWater() and not item:isWaterSource() then
			if not didWalk and (not waterObject:getSquare() or not luautils.walkAdj(playerObj, waterObject:getSquare(), true)) then
				return
			end
			didWalk = true
			local returnToContainer = item:getContainer():isInCharacterInventory(playerObj) and item:getContainer()
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
			ISTimedActionQueue.add(ISTakeWaterAction:new(playerObj, item, waterObject, waterObject:isTaintedWater()));
			if returnToContainer and (returnToContainer ~= playerInv) then
				ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, playerInv, returnToContainer))
			end
		elseif item:canStoreWater() and item:isWaterSource() then -- second case, a bottle contain some water, we just fill it
			if not didWalk and (not waterObject:getSquare() or not luautils.walkAdj(playerObj, waterObject:getSquare(), true)) then
				return
			end
			didWalk = true
			local returnToContainer = item:getContainer():isInCharacterInventory(playerObj) and item:getContainer()
			if playerObj:getPrimaryHandItem() ~= item and playerObj:getSecondaryHandItem() ~= item then
			end
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
			ISTimedActionQueue.add(ISTakeWaterAction:new(playerObj, item, waterObject, waterObject:isTaintedWater()));
			if returnToContainer then
				ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, playerInv, returnToContainer))
			end
		elseif item:getFluidContainer() then --Fluid item
			if not didWalk and (not waterObject:getSquare() or not luautils.walkAdj(playerObj, waterObject:getSquare(), true)) then
				return
			end
			didWalk = true
			local returnToContainer = item:getContainer():isInCharacterInventory(playerObj) and item:getContainer()
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
			ISTimedActionQueue.add(ISTakeWaterAction:new(playerObj, item, waterObject, waterObject:isTaintedWater()));
			if returnToContainer and (returnToContainer ~= playerInv) then
				ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, playerInv, returnToContainer))
			end			
		end
	end
end

ISWorldObjectContextMenu.onTakeFuelNew = function(worldobjects, fuelObject, fuelContainerList, fuelContainer, player)
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	local fuelAvailable = fuelObject:getPipedFuelAmount()

	if not fuelContainerList or #fuelContainerList == 0 then
		fuelContainerList = {};
		table.insert(fuelContainerList, fuelContainer);
	end
	
	local didWalk = false

	for i,item in ipairs(fuelContainerList) do
		if not didWalk and (not fuelObject:getSquare() or not luautils.walkAdj(playerObj, fuelObject:getSquare(), true)) then
			return
		end
		didWalk = true
		local returnToContainer = item:getContainer():isInCharacterInventory(playerObj) and item:getContainer()
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
		ISInventoryPaneContextMenu.equipWeapon(item, false, false, playerObj:getPlayerNum())
		ISTimedActionQueue.add(ISTakeFuel:new(playerObj, fuelObject, item))
		if returnToContainer and (returnToContainer ~= playerInv) then
			ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, playerInv, returnToContainer))
		end
	end
end

ISWorldObjectContextMenu.onAddFluidFromItem = function(worldobjects, fluidObject, fluidItem, playerObj)
	if not luautils.walkAdj(playerObj, fluidObject:getSquare(), true) then return end
	if fluidItem:canStoreWater() and fluidObject:canTransferFluidFrom(fluidItem:getFluidContainer()) then
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), fluidItem, true)
		ISTimedActionQueue.add(ISAddFluidFromItemAction:new(playerObj, fluidItem, fluidObject))
	end
end

ISWorldObjectContextMenu.onUnbarricade = function(worldobjects, window, player)
    local playerObj = getSpecificPlayer(player)
	if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
		if ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateRemoveBarricade, true) then
			ISTimedActionQueue.add(ISUnbarricadeAction:new(playerObj, window))
		end
	end
end

ISWorldObjectContextMenu.onUnbarricadeMetal = function(worldobjects, window, player)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateBlowTorch, true);
        ISTimedActionQueue.add(ISUnbarricadeAction:new(playerObj, window));
    end
end

ISWorldObjectContextMenu.onUnbarricadeMetalBar = function(worldobjects, window, player)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateBlowTorch, true);
        ISTimedActionQueue.add(ISUnbarricadeAction:new(playerObj, window));
    end
end

ISWorldObjectContextMenu.isThumpDoor = function(thumpable)
	local isDoor = false;
	if instanceof(thumpable, "IsoThumpable") then
		if thumpable:isDoor() or thumpable:isWindow() then
			isDoor = true;
		end
	end
	if instanceof(thumpable, "IsoWindow") or instanceof(thumpable, "IsoDoor") then
		isDoor = true;
	end
	if instanceof(thumpable, "IsoWindowFrame") then
		isDoor = true;
	end
	return isDoor;
end

ISWorldObjectContextMenu.onClimbSheetRope = function(worldobjects, square, down, player)
	if square then
		local playerObj = getSpecificPlayer(player)
		ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, square))
		ISTimedActionQueue.add(ISClimbSheetRopeAction:new(playerObj, down))
	end
end

ISWorldObjectContextMenu.onMetalBarBarricade = function(worldobjects, window, player)
    local playerObj = getSpecificPlayer(player)
    -- we must check these otherwise ISEquipWeaponAction will get a null item
    if playerObj:getInventory():getItemCountRecurse("Base.MetalBar") < 3 then return end
    local parent = window:getSquare();
    if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), parent) then
        local adjacent = nil;
        if ISWorldObjectContextMenu.isThumpDoor(window) then
            adjacent = AdjacentFreeTileFinder.FindWindowOrDoor(parent, window, playerObj);
        else
            adjacent = AdjacentFreeTileFinder.Find(parent, playerObj);
        end
        if adjacent ~= nil then
            ISTimedActionQueue.clear(playerObj);
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateBlowTorch, true);
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), "MetalBar", false);

            ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
            ISTimedActionQueue.add(ISBarricadeAction:new(playerObj, window, false, true));
            return;
        else
            return;
        end
    else
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateBlowTorch, true);
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), "MetalBar", false);
        ISTimedActionQueue.add(ISBarricadeAction:new(playerObj, window, false, true));
    end
end

ISWorldObjectContextMenu.onMetalBarricade = function(worldobjects, window, player)
    local playerObj = getSpecificPlayer(player)
    -- we must check these otherwise ISEquipWeaponAction will get a null item
    if not playerObj:getInventory():containsTypeRecurse("SheetMetal") then return end
    local parent = window:getSquare();
    if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), parent) then
        local adjacent = nil;
        if ISWorldObjectContextMenu.isThumpDoor(window) then
            adjacent = AdjacentFreeTileFinder.FindWindowOrDoor(parent, window, playerObj);
        else
            adjacent = AdjacentFreeTileFinder.Find(parent, playerObj);
        end
        if adjacent ~= nil then
            ISTimedActionQueue.clear(playerObj);
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateBlowTorch, true);
            ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), "SheetMetal", false);

            ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
            ISTimedActionQueue.add(ISBarricadeAction:new(playerObj, window, true, false));
            return;
        else
            return;
        end
    else
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateBlowTorch, true);
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), "SheetMetal", false);
        ISTimedActionQueue.add(ISBarricadeAction:new(playerObj, window, true, false));
    end
end

ISWorldObjectContextMenu.onBarricade = function(worldobjects, window, player)
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	-- we must check these otherwise ISEquipWeaponAction will get a null item
	local hammer = playerInv:getFirstTagEvalRecurse("Hammer", predicateNotBroken)
	if not hammer then return end
	if not playerInv:containsTypeRecurse("Plank") then return end
	if playerInv:getItemCountRecurse("Base.Nails") < 2 then return end
	local nails = playerInv:getSomeTypeRecurse("Nails", 2);
	local parent = window:getSquare();
	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), parent) then
		local adjacent = nil;
		if ISWorldObjectContextMenu.isThumpDoor(window) then
			adjacent = AdjacentFreeTileFinder.FindWindowOrDoor(parent, window, playerObj);
		else
			adjacent = AdjacentFreeTileFinder.Find(parent, playerObj);
        end
		if adjacent ~= nil then
			ISTimedActionQueue.clear(playerObj);
			ISInventoryPaneContextMenu.transferIfNeeded(playerObj, nails);
			ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), hammer, true);
			ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), "Plank", false);
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
			ISTimedActionQueue.add(ISBarricadeAction:new(playerObj, window, false, false));
			return;
		else
			return;
		end
    else
		ISInventoryPaneContextMenu.transferIfNeeded(playerObj, nails);
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), hammer, true);
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), "Plank", false);
		ISTimedActionQueue.add(ISBarricadeAction:new(playerObj, window, false, false));
	end
end

ISWorldObjectContextMenu.restoreDoor = function(playerObj, door, isOpen)
	if door:IsOpen() ~= isOpen then
		door:ToggleDoor(playerObj)
	end
end

ISWorldObjectContextMenu.onAddSheet = function(worldobjects, window, player)
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	local square = window:getAddSheetSquare(playerObj)
	local sheet = playerInv:getFirstTypeRecurse("Sheet")
	if not sheet then return end
	if square and square:isFree(false) then
		local action = ISWalkToTimedAction:new(playerObj, square)
		if instanceof(window, "IsoDoor") then
			action:setOnComplete(ISWorldObjectContextMenu.restoreDoor, playerObj, window, window:IsOpen())
		end
		ISTimedActionQueue.add(action)
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, sheet)
		ISTimedActionQueue.add(ISAddSheetAction:new(playerObj, window));
	elseif luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
		if instanceof(window, "IsoDoor") then return end
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, sheet)
		ISTimedActionQueue.add(ISAddSheetAction:new(playerObj, window));
	end
end

ISWorldObjectContextMenu.addRemoveCurtainOption = function(context, worldobjects, curtain, player)
	local scriptItem = getScriptManager():FindItem("Base.Sheet")
	if not scriptItem then return end

	local option = context:addGetUpOption(getText("ContextMenu_Remove_curtains"), worldobjects, ISWorldObjectContextMenu.onRemoveCurtain, curtain, player)
	option.toolTip = ISWorldObjectContextMenu.addToolTip()
	option.toolTip:setTexture("Item_Sheet")
	option.toolTip.description = getText("Tooltip_RemoveCurtains", scriptItem:getDisplayName())
	if instanceof(curtain, "IsoDoor") then
		curtain = curtain:HasCurtains()
	end
	if curtain:getSprite() and curtain:getSprite():getProperties():Is("IsMoveAble") then
		option.toolTip.description = option.toolTip.description .. " <LINE> <LINE> " .. getText("Tooltip_PickUpCurtains")
	end
	return option
end

ISWorldObjectContextMenu.onRemoveCurtain = function(worldobjects, curtain, player)
	local playerObj = getSpecificPlayer(player)
	if instanceof(curtain, "IsoDoor") then
		local square = curtain:getSheetSquare()
		if square and square:isFree(false) then
--			local userData = {playerObj = playerObj, door = curtain, open = curtain:IsOpen()}
--			local action = ISWalkToTimedAction:new(playerObj, square, ISWorldObjectContextMenu.doorCurtainCheck, userData)
--			userData.action = action
			local action = ISWalkToTimedAction:new(playerObj, square)
			action:setOnComplete(ISWorldObjectContextMenu.restoreDoor, playerObj, curtain, curtain:IsOpen())
			ISTimedActionQueue.add(action)
			ISTimedActionQueue.add(ISRemoveSheetAction:new(playerObj, curtain));
		end
		return
	end
	if curtain:getSquare() and curtain:getSquare():isFree(false) then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, curtain:getSquare()))
		ISTimedActionQueue.add(ISRemoveSheetAction:new(playerObj, curtain));
	elseif luautils.walkAdjWindowOrDoor(playerObj, curtain:getSquare(), curtain) then
		ISTimedActionQueue.add(ISRemoveSheetAction:new(playerObj, curtain));
	end
end

ISWorldObjectContextMenu.onOpenCloseCurtain = function(worldobjects, curtain, player)
	local playerObj = getSpecificPlayer(player)
	if instanceof(curtain, "IsoDoor") then
		local square = curtain:getSheetSquare()
		if square and square:isFree(false) then
			if square ~= playerObj:getSquare() then
				local action = ISWalkToTimedAction:new(playerObj, square)
				action:setOnComplete(ISWorldObjectContextMenu.restoreDoor, playerObj, curtain, curtain:IsOpen())
				ISTimedActionQueue.add(action)
			end
			ISTimedActionQueue.add(ISOpenCloseCurtain:new(playerObj, curtain));
		end
		return
	end
	if curtain:getSquare() and curtain:getSquare():isFree(false) then
		if curtain:getSquare() ~= playerObj:getSquare() then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, curtain:getSquare()))
		end
		ISTimedActionQueue.add(ISOpenCloseCurtain:new(playerObj, curtain));
	elseif luautils.walkAdjWindowOrDoor(playerObj, curtain:getSquare(), curtain) then
		ISTimedActionQueue.add(ISOpenCloseCurtain:new(playerObj, curtain));
	end
end

ISWorldObjectContextMenu.onOpenCloseWindow = function(worldobjects, window, player)
	local playerObj = getSpecificPlayer(player)
	local square = window:getSquare()
--[[
	-- If there is a counter in front of the window, don't walk outside the room to open it
	local square = window:getIndoorSquare()
	if not (square and square:getRoom() == playerObj:getCurrentSquare():getRoom()) then
--		square = window:getSquare()
	end
--]]
    if (not playerObj:isBlockMovement()) then
        if luautils.walkAdjWindowOrDoor(playerObj, square, window) then
            ISTimedActionQueue.add(ISOpenCloseWindow:new(playerObj, window))
        end
    end
end

ISWorldObjectContextMenu.onAddSheetRope = function(worldobjects, window, player, sheetRope)

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
		local numRequired = 0
		numRequired = window:countAddSheetRope()
		local items
		if sheetRope then
			items = playerInv:getSomeTypeRecurse("SheetRope", numRequired)
			if items:size() < numRequired then
				items = playerInv:getSomeTypeRecurse("Rope", numRequired)
			end
		else
			items = playerInv:getSomeTypeRecurse("Rope", numRequired)
			if items:size() < numRequired then
				items = playerInv:getSomeTypeRecurse("SheetRope", numRequired)
			end
		end
		if items:size() < numRequired then return end
		if not window:getSprite():getProperties():Is("TieSheetRope") then
			local hammer = playerInv:getFirstTagEvalRecurse("Hammer", predicateNotBroken)
			if not hammer then return end
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, hammer)
			local nail = playerInv:getFirstTypeRecurse("Nails")
			if not nail then return end
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, nail)
		end
		for i=1,numRequired do
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, items:get(i-1))
		end
		ISTimedActionQueue.add(ISAddSheetRope:new(playerObj, window, sheetRope));
	end
end

ISWorldObjectContextMenu.onRemoveSheetRope = function(worldobjects, window, player)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
		ISTimedActionQueue.add(ISRemoveSheetRope:new(playerObj, window));
	end
end

ISWorldObjectContextMenu.isTrappedAdjacentToWindow = function(player, window)
	if not player or not window then return false end
	local sq = player:getCurrentSquare()
	local sq2 = window:getSquare()
	if not sq or not sq2 or sq:getZ() ~= sq2:getZ() then return false end
	if not (sq:Is(IsoFlagType.solid) or sq:Is(IsoFlagType.solidtrans)) then return false end
	local north = false
	north = window:getNorth()
	if north and sq:getX() == sq:getX() and (sq:getY() == sq2:getY()-1 or sq:getY() == sq2:getY()) then
		return true
	end
	if not north and sq:getY() == sq:getY() and (sq:getX() == sq2:getX()-1 or sq:getX() == sq2:getX()) then
		return true
	end
	return false
end

ISWorldObjectContextMenu.onClimbOverFence = function(worldobjects, fence, direction, player)
	local playerObj = getSpecificPlayer(player)
	local square = fence:getSquare()
	if luautils.walkAdjFence(playerObj, square, fence) then
		ISTimedActionQueue.add(ISClimbOverFence:new(playerObj, fence, direction))
	end
end

ISWorldObjectContextMenu.onClimbThroughWindow = function(worldobjects, window, player)
	local playerObj = getSpecificPlayer(player)
	if ISWorldObjectContextMenu.isTrappedAdjacentToWindow(playerObj, window) then
		ISTimedActionQueue.add(ISClimbThroughWindow:new(playerObj, window, 0))
		return
	end
	local square = window:getSquare()
--[[
	-- If there is a counter in front of the window, don't walk outside the room to climb through it.
	-- This is for windows on the south or east wall of a room.
	if instanceof(window, 'IsoWindow') then
		if square:getRoom() ~= playerObj:getCurrentSquare():getRoom() then
			if window:getIndoorSquare() and window:getIndoorSquare():Is(IsoFlagType.solidtrans) then
				square = window:getIndoorSquare()
			end
		end
	end
--]]
	if luautils.walkAdjWindowOrDoor(playerObj, square, window) then
		ISTimedActionQueue.add(ISClimbThroughWindow:new(playerObj, window, 0));
	end
end
ISWorldObjectContextMenu.onSmashWindow = function(worldobjects, window, player)
	local playerObj = getSpecificPlayer(player)
    if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
		ISTimedActionQueue.add(ISSmashWindow:new(playerObj, window));
        --playerObj:smashWindow(window);
    end
end
ISWorldObjectContextMenu.onRemoveBrokenGlass = function(worldobjects, window, player)
	local playerObj = getSpecificPlayer(player)
    if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
        ISTimedActionQueue.add(ISRemoveBrokenGlass:new(playerObj, window));
    end
end
ISWorldObjectContextMenu.onPickupBrokenGlass = function(worldobjects, brokenGlass, player)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdj(playerObj, brokenGlass:getSquare()) then
        ISTimedActionQueue.add(ISPickupBrokenGlass:new(playerObj, brokenGlass));
    end
end

ISWorldObjectContextMenu.onOpenCloseDoor = function(worldobjects, door, player)
	local playerObj = getSpecificPlayer(player)
	CancelAction(player, true);
	if luautils.walkAdjWindowOrDoor(playerObj, door:getSquare(), door) then
		ISTimedActionQueue.add(ISOpenCloseDoor:new(playerObj, door));
	end
end

function ISWorldObjectContextMenu.canCleanBlood(playerObj, square)
	local playerInv = playerObj:getInventory()
	local bleach = playerInv:containsEvalRecurse(predicateCleaningLiquid)
	local mop = playerInv:containsTagEvalRecurse("CleanStains", predicateNotBroken)
	return square ~= nil and square:haveStains() and bleach and mop
-- 			(playerInv:containsTypeRecurse("BathTowel") or playerInv:containsTypeRecurse("DishCloth") or
-- 			playerInv:containsTypeRecurse("Mop") or playerInv:containsTypeEvalRecurse("Broom", predicateNotBroken))
end

function ISWorldObjectContextMenu.onCleanBlood(worldobjects, square, player)
	local playerObj = getSpecificPlayer(player)
	local bo = ISCleanBloodCursor:new("", "", playerObj)
	getCell():setDrag(bo, playerObj:getPlayerNum())
end

function ISWorldObjectContextMenu.doCleanBlood(playerObj, square)
	local player = playerObj:getPlayerNum()
	local playerInv = playerObj:getInventory()
	if luautils.walkAdj(playerObj, square) then
		local bleach
		local item
		if playerObj:getSecondaryHandItem() and predicateCleaningLiquid(playerObj:getSecondaryHandItem()) then
		    bleach = playerObj:getSecondaryHandItem()
		else
		    bleach = playerInv:getFirstEvalRecurse(predicateCleaningLiquid);
		    ISWorldObjectContextMenu.transferIfNeeded(playerObj, bleach)
	    end
		if playerObj:getPrimaryHandItem() and playerObj:getPrimaryHandItem():hasTag("CleanStains") then
		    item = playerObj:getPrimaryHandItem()
		else
            item = playerInv:getFirstTagEvalRecurse("CleanStains", predicateNotBroken)
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
	    end
	    local twoHanded = item:hasTag("TwoHandItem") or (instanceof(item, "HandWeapon") and item:isTwoHandWeapon())
		-- dish clothes will be doing a low animation
		if not twoHanded then
-- 		if item:getType() == "DishCloth" or item:getType() == "BathTowel" or item:getType() == "Sponge" then
			ISInventoryPaneContextMenu.equipWeapon(item, true, false, player)
			ISInventoryPaneContextMenu.equipWeapon(bleach, false, false, player)
		else -- broom/mop equipped in both hands
			ISInventoryPaneContextMenu.equipWeapon(item, true, true, player)
		end

		ISTimedActionQueue.add(ISCleanBlood:new(playerObj, square, bleach));
	end
end

function ISWorldObjectContextMenu.canCleanGraffiti(playerObj, square)
	local playerInv = playerObj:getInventory()
	local cleaner = playerInv:containsTagEvalRecurse("Petrol", predicateFluidRemaining)
	local mop = playerInv:containsTagEvalRecurse("CleanStains", predicateNotBroken)
	return square ~= nil and square:haveGraffiti() and cleaner and mop
-- 			(playerInv:containsTypeRecurse("BathTowel") or playerInv:containsTypeRecurse("DishCloth") or
-- 			playerInv:containsTypeRecurse("Mop") or playerInv:containsTypeEvalRecurse("Broom", predicateNotBroken))
end

function ISWorldObjectContextMenu.onCleanGraffiti(worldobjects, square, player)
	local playerObj = getSpecificPlayer(player)
	local bo = ISCleanGraffitiCursor:new("", "", playerObj)
	getCell():setDrag(bo, playerObj:getPlayerNum())
end

function ISWorldObjectContextMenu.doCleanGraffiti(playerObj, square)
	local player = playerObj:getPlayerNum()
	local playerInv = playerObj:getInventory()
	if luautils.walkAdj(playerObj, square) then
		local cleaner
		local item
		if playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem():hasTag("Petrol") then
		    cleaner = playerObj:getSecondaryHandItem()
		else
            cleaner = playerInv:getFirstTagEvalRecurse("Petrol", predicateFluidRemaining)
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, cleaner)
	    end
		if playerObj:getPrimaryHandItem() and playerObj:getPrimaryHandItem():hasTag("CleanStains") then
		    item = playerObj:getPrimaryHandItem()
		else
            item = playerInv:getFirstTagEvalRecurse("CleanStains", predicateNotBroken)
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
	    end
	    local twoHanded = item:hasTag("TwoHandItem") or (instanceof(item, "HandWeapon") and item:isTwoHandWeapon())
		-- dish clothes will be doing a low animation
		if not twoHanded then
-- 		if item:getType() == "DishCloth" or item:getType() == "BathTowel" or item:getType() == "Sponge" then
			ISInventoryPaneContextMenu.equipWeapon(item, true, false, player)
			ISInventoryPaneContextMenu.equipWeapon(cleaner, false, false, player)
		else -- broom/mop equipped in both hands
			ISInventoryPaneContextMenu.equipWeapon(item, true, true, player)
		end
		ISTimedActionQueue.add(ISCleanGraffiti:new(playerObj, square, cleaner));
	end
end

ISWorldObjectContextMenu.onRemovePlant = function(worldobjects, square, wallVine, player)
	local playerObj = getSpecificPlayer(player)
	local bo = ISRemovePlantCursor:new(playerObj, wallVine and "wallVine" or "bush")
	getCell():setDrag(bo, player)
end

ISWorldObjectContextMenu.doRemovePlant = function(playerObj, square, wallVine)
    local playerInv = playerObj:getInventory()
    if wallVine then
        ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, square))
    else
        if not luautils.walkAdj(playerObj, square, true) then return end
    end
    local handItem = playerObj:getPrimaryHandItem()
    if not handItem or not predicateCutPlant(handItem) then
		handItem = playerInv:getFirstEvalRecurse(predicateCutPlant)
		if not handItem then return end
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), handItem, true)
    end
    ISTimedActionQueue.add(ISRemoveBush:new(playerObj, square, wallVine));
end

ISWorldObjectContextMenu.onRemoveGrass = function(worldobjects, square, player)
	local playerObj = getSpecificPlayer(player)
	local bo = ISRemovePlantCursor:new(playerObj, "grass")
	getCell():setDrag(bo, player)
end

ISWorldObjectContextMenu.doRemoveGrass = function(playerObj, square)
    if luautils.walkAdj(playerObj, square, true) then
        ISTimedActionQueue.add(ISRemoveGrass:new(playerObj, square))
    end
end

ISWorldObjectContextMenu.onWalkTo = function(worldobjects, item, player)
	local playerObj = getSpecificPlayer(player)
	local parent = item:getSquare()
	local adjacent = AdjacentFreeTileFinder.Find(parent, playerObj)
	if instanceof(item, "IsoWindow") or instanceof(item, "IsoDoor") then
		adjacent = AdjacentFreeTileFinder.FindWindowOrDoor(parent, item, playerObj)
	end
	if adjacent ~= nil then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(getSpecificPlayer(player), adjacent))
	end
end

ISWorldObjectContextMenu.onWalkTo = function(worldobjects, item, playerNum)
	local playerObj = getSpecificPlayer(playerNum)
	local bo = ISWalkToCursor:new("", "", playerObj)
	getCell():setDrag(bo, playerNum)
end

function ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
	if luautils.haveToBeTransfered(playerObj, item) then
		ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory()))
	end
end

-- we equip the item before if it's not equiped before using it
ISWorldObjectContextMenu.equip = function(playerObj, handItem, item, primary, twoHands)
	if type(item) == "function" then
		local predicate = item
		if not handItem or not predicate(handItem) then
			handItem = playerObj:getInventory():getFirstEvalRecurse(predicate)
			if handItem then
				ISWorldObjectContextMenu.transferIfNeeded(playerObj, handItem)
				ISTimedActionQueue.add(ISEquipWeaponAction:new(playerObj, handItem, 50, primary, twoHands))
			end
		end
		return handItem
	end
	if instanceof(item, "InventoryItem") then
		if handItem ~= item then
			handItem = item
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, handItem)
			ISTimedActionQueue.add(ISEquipWeaponAction:new(playerObj, handItem, 50, primary, twoHands))
		end
		return handItem
	end
	if not handItem or handItem:getType() ~= item then
		handItem = playerObj:getInventory():getFirstTypeEvalRecurse(item, predicateNotBroken);
		if handItem then
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, handItem)
			ISTimedActionQueue.add(ISEquipWeaponAction:new(playerObj, handItem, 50, primary, twoHands))
		end
	end
	return handItem;
end

ISWorldObjectContextMenu.equip2 = function(player, handItem, item, primary)
    if not handItem or handItem ~= item then
        ISTimedActionQueue.add(ISEquipWeaponAction:new(player, item, 50, primary))
    end
    return handItem;
end

ISWorldObjectContextMenu.addToolTip = function()
    local pool = ISWorldObjectContextMenu.tooltipPool
    if #pool == 0 then
        table.insert(pool, ISToolTip:new())
    end
    local tooltip = table.remove(pool, #pool)
    tooltip:reset()
    table.insert(ISWorldObjectContextMenu.tooltipsUsed, tooltip)
    return tooltip;
end

ISWorldObjectContextMenu.doBedOption = function(context, playerObj, bed)
	local playerNum = playerObj:getPlayerNum()
	if not playerObj:isOnBed() and bed:getSprite() and bed:getSprite():getSpriteGrid() then
		local option1 = context:addOption("Get On Bed", playerObj, ISWorldObjectContextMenu.onGetOnBed, bed)
	end
	if playerObj:isOnBed() and playerObj:getVariableBoolean("OnBedStarted") then
		if playerObj:getVariableString("OnBedAnim") == "Awake" then
			local option2 = context:addOption("Bed: Awake To Asleep", playerObj, ISWorldObjectContextMenu.onBedAnim, "Asleep")
		else
			local option2 = context:addOption("Bed: Asleep To Awake", playerObj, ISWorldObjectContextMenu.onBedAnim, "Awake")
		end
	end
end

ISWorldObjectContextMenu.onGetOnBed = function(playerObj, bed)
	local locations = {}
	local overlap = 0.3
	local facing = SeatingManager.getInstance():getFacingDirection(bed)
	local spriteGrid = bed:getSprite():getSpriteGrid()

	local getBedObject = function(bed, dir)
		local square = bed:getSquare():getAdjacentSquare(dir)
		for i=1,square:getObjects():size() do
			local obj = square:getObjects():get(i-1)
			if obj:getSprite() and obj:getProperties():Is(IsoFlagType.bed) then
				return obj
			end
		end
		return nil
	end

	if facing == "N" then
		if spriteGrid:getSpriteGridPosY(bed:getSprite()) == 0 then
			bed = getBedObject(bed, IsoDirections.S)
		end
	elseif facing == "S" then
		if spriteGrid:getSpriteGridPosY(bed:getSprite()) == 1 then
			bed = getBedObject(bed, IsoDirections.N)
		end
	elseif facing == "W" then
		if spriteGrid:getSpriteGridPosX(bed:getSprite()) == 0 then
			bed = getBedObject(bed, IsoDirections.E)
		end
	elseif facing == "E" then
		if spriteGrid:getSpriteGridPosX(bed:getSprite()) == 1 then
			bed = getBedObject(bed, IsoDirections.W)
		end
	end
	if facing == "N" then
		-- W head
		table.insert(locations, bed:getX() - overlap)
		table.insert(locations, bed:getY() + 0.5)
		table.insert(locations, bed:getZ())
		-- E head
		table.insert(locations, bed:getX() + 1.0 + overlap)
		table.insert(locations, bed:getY() + 0.5)
		table.insert(locations, bed:getZ())
		-- W foot
		table.insert(locations, bed:getX() - overlap)
		table.insert(locations, bed:getY() - 0.5)
		table.insert(locations, bed:getZ())
		-- E foot
		table.insert(locations, bed:getX() + 1.0 + overlap)
		table.insert(locations, bed:getY() - 0.5)
		table.insert(locations, bed:getZ())
		-- Foot
		table.insert(locations, bed:getX() + 0.5)
		table.insert(locations, bed:getY() - 1.0 - overlap)
		table.insert(locations, bed:getZ())
	elseif facing == "S" then
		-- W head
		table.insert(locations, bed:getX() - overlap)
		table.insert(locations, bed:getY() + 0.5)
		table.insert(locations, bed:getZ())
		-- E head
		table.insert(locations, bed:getX() + 1.0 + overlap)
		table.insert(locations, bed:getY() + 0.5)
		table.insert(locations, bed:getZ())
		-- W foot
		table.insert(locations, bed:getX() - overlap)
		table.insert(locations, bed:getY() + 1.5)
		table.insert(locations, bed:getZ())
		-- E foot
		table.insert(locations, bed:getX() + 1.0 + overlap)
		table.insert(locations, bed:getY() + 1.5)
		table.insert(locations, bed:getZ())
		-- Foot
		table.insert(locations, bed:getX() + 0.5)
		table.insert(locations, bed:getY() + 2.0 + overlap)
		table.insert(locations, bed:getZ())
	elseif facing == "W" then
		-- N head
		table.insert(locations, bed:getX() + 0.5)
		table.insert(locations, bed:getY() - overlap)
		table.insert(locations, bed:getZ())
		-- S head
		table.insert(locations, bed:getX() + 0.5)
		table.insert(locations, bed:getY() + 1.0 + overlap)
		table.insert(locations, bed:getZ())
		-- N foot
		table.insert(locations, bed:getX() - 0.5)
		table.insert(locations, bed:getY() - overlap)
		table.insert(locations, bed:getZ())
		-- S foot
		table.insert(locations, bed:getX() - 0.5)
		table.insert(locations, bed:getY() + 1.0 + overlap)
		table.insert(locations, bed:getZ())
		-- Foot
		table.insert(locations, bed:getX() - 1.0 - overlap)
		table.insert(locations, bed:getY() + 0.5)
		table.insert(locations, bed:getZ())
	elseif facing == "E" then
		-- N head
		table.insert(locations, bed:getX() + 0.5)
		table.insert(locations, bed:getY() - overlap)
		table.insert(locations, bed:getZ())
		-- S head
		table.insert(locations, bed:getX() + 0.5)
		table.insert(locations, bed:getY() + 1.0 + overlap)
		table.insert(locations, bed:getZ())
		-- N foot
		table.insert(locations, bed:getX() + 1.5)
		table.insert(locations, bed:getY() - overlap)
		table.insert(locations, bed:getZ())
		-- S foot
		table.insert(locations, bed:getX() + 1.5)
		table.insert(locations, bed:getY() + 1.0 + overlap)
		table.insert(locations, bed:getZ())
		-- Foot
		table.insert(locations, bed:getX() + 2.0 + overlap)
		table.insert(locations, bed:getY() + 0.5)
		table.insert(locations, bed:getZ())
	end
	local action = ISPathFindAction:pathToNearest(playerObj, locations)
	ISTimedActionQueue.add(action)
	ISTimedActionQueue.add(ISGetOnBedAction:new(playerObj, bed))
end

ISWorldObjectContextMenu.onBedAnim = function(playerObj, anim)
	playerObj:setVariable("OnBedAnim", anim)
end

ISWorldObjectContextMenu.onDigGraves = function(worldobjects, player, shovel)
	local bo = ISEmptyGraves:new("location_community_cemetary_01_33", "location_community_cemetary_01_32", "location_community_cemetary_01_34", "location_community_cemetary_01_35", shovel);
	bo.player = player;
	bo.character = getSpecificPlayer(player)
	getCell():setDrag(bo, bo.player);
end

ISWorldObjectContextMenu.onBuryCorpse = function(grave, player, primaryHandItem)
	local playerObj = getSpecificPlayer(player)

	if primaryHandItem and primaryHandItem:hasTag("AnimalCorpse") then
		ISTimedActionQueue.add(ISBuryCorpse:new(playerObj, grave, primaryHandItem, nil))
		return;
	end

	playerObj:setDoGrappleLetGo();

	local func = nil
	func = function(body)
		ISTimedActionQueue.add(ISBuryCorpse:new(playerObj, grave, primaryHandItem, body:getSquare()))
		Events.OnDeadBodySpawn.Remove(func)
	end
	Events.OnDeadBodySpawn.Add(func)
end

ISWorldObjectContextMenu.onFillGrave = function(grave, player, shovel)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, grave:getSquare()) then
		ISInventoryPaneContextMenu.equipWeapon(shovel, true, true, player)
		ISTimedActionQueue.add(ISFillGrave:new(playerObj, grave, shovel));
	end
end

ISWorldObjectContextMenu.onFluidTransfer = function(player, fluidcontainer)
	local playerObj = getSpecificPlayer(player)
	local square = fluidcontainer:getGameEntity():getSquare();
	if not square or luautils.walkAdj(playerObj, square) then
		local c = ISFluidContainer:new(fluidcontainer);
		--ISFluidInfoUI.OpenPanel(playerObj, c)
		ISTimedActionQueue.add(ISFluidPanelAction:new(playerObj, c, ISFluidTransferUI, true));
	end
end

ISWorldObjectContextMenu.onFluidInfo = function(player, fluidcontainer)
	local playerObj = getSpecificPlayer(player)
	local square = fluidcontainer:getGameEntity():getSquare();
	if not square or luautils.walkAdj(playerObj, square) then
		local c = ISFluidContainer:new(fluidcontainer);
		ISTimedActionQueue.add(ISFluidPanelAction:new(playerObj, c, ISFluidInfoUI));
	end
end

ISWorldObjectContextMenu.onFluidEmpty = function(player, fluidcontainer)
	local playerObj = getSpecificPlayer(player)
	local square = fluidcontainer:getGameEntity():getSquare();
	if not square or luautils.walkAdj(playerObj, square) then
		ISTimedActionQueue.add(ISFluidEmptyAction:new(playerObj, fluidcontainer));
	end
end

ISWorldObjectContextMenu.onSitOnGround = function(player)
	getSpecificPlayer(player):reportEvent("EventSitOnGround");
end

ISWorldObjectContextMenu.onScytheGrass = function(player, scythe)
	--ISInventoryPaneContextMenu.equipWeapon(scythe, true, true, player:getPlayerNum())
	--ISTimedActionQueue.add(ISScything:new(player, scythe));
	local bo = ISScytheGrassCursor:new(player, scythe)
	getCell():setDrag(bo, bo.player)
end

ISWorldObjectContextMenu.onRakeDung = function(player, scythe)
	--ISInventoryPaneContextMenu.equipWeapon(scythe, true, true, player:getPlayerNum())
	--ISTimedActionQueue.add(ISScything:new(player, scythe));
	local bo = ISPickDungCursor:new(player, scythe)
	getCell():setDrag(bo, bo.player)
end

ISWorldObjectContextMenu.onPickupGroundCoverItem = function(worldobjects, player, object)
    if object:getSquare()
    and luautils.walkAdj(getSpecificPlayer(player), object:getSquare())
    then
        ISTimedActionQueue.add(ISPickUpGroundCoverItem:new(getSpecificPlayer(player), object:getSquare(), object));
    end
end

ISWorldObjectContextMenu.onRemoveGroundCoverItemPickAxe = function(worldobjects, player, object)
    local playerObj = getSpecificPlayer(player)
    if object:getSquare() and luautils.walkAdj(playerObj, object:getSquare()) then
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicatePickAxe, true, true)
        ISTimedActionQueue.add(ISPickAxeGroundCoverItem:new(playerObj, object));
    end
end

ISWorldObjectContextMenu.onRemoveGroundCoverItemHammerOrPickAxe = function(worldobjects, player, object)
    local playerObj = getSpecificPlayer(player)
    if object:getSquare() and luautils.walkAdj(playerObj, object:getSquare()) then
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateHammerOrPickAxe, true, true)
        ISTimedActionQueue.add(ISPickAxeGroundCoverItem:new(playerObj, object));
    end
end


ISWorldObjectContextMenu.chairCheckList = {}
ISWorldObjectContextMenu.chairCheckList.badList = { "Barstool", "Chair", "Chairs", "Ottoman", "Stool", "Stump", "Block", "Table"} --Futon",
ISWorldObjectContextMenu.chairCheckList.goodList = { "Beach", "Black Fancy", "Comfy", "Dentist Patient", "Fancy White", "Lazy", "Light Blue", "Modern White", "Rattan", "Salon", "Victorian", "Yellow Modern"} -- , "Plastic"

ISWorldObjectContextMenu.chairCheck = function(bed)
    local chairCheckList = ISWorldObjectContextMenu.chairCheckList
    if bed:getProperties() then
        local props = bed:getProperties()
        local sillyChair = false
        if props:Is("CustomName") then
            local customName = props:Val("CustomName")
            local badList = chairCheckList.badList
--             getPlayer():Say(customName)
            for i = 1, #badList  do
                local badWord = badList[i]
--                 print("Bad Word " .. tostring(badWord))
                if badWord and customName:contains(badWord) then
                    sillyChair = true
                end
            end
        end
        if sillyChair and props:Is("GroupName") then
            local groupName = props:Val("GroupName")
            local goodList = chairCheckList.goodList
--             getPlayer():Say(groupName)
            for i = 1, #goodList  do
                local goodWord = goodList[i]
--                 print("Good Word " .. tostring(goodWord))
                if goodWord and groupName:contains(goodWord) then
                    sillyChair = false
                end
            end
        end
        if sillyChair then return nil end
    end
    return bed
end

ISWorldObjectContextMenu.getBedQuality = function(playerObj, bed)
    local bedType = "averageBed"
    local playerHasPillow = false
    -- added pillows equipped in-hand to the circumstances where a player can benefit from sleeping with a pillow
    if (playerObj:getPrimaryHandItem() and playerObj:getPrimaryHandItem():hasTag("Pillow")) or
            (playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem():hasTag("Pillow")) then
        playerHasPillow = true
    end
    if playerObj:getVehicle() then
        bedType = "badBed"
        if playerHasPillow then
            return (bedType .. "Pillow")
        end
        local vehicle = playerObj:getVehicle()
        local seat = vehicle:getPartForSeatContainer(vehicle:getSeat(playerObj))
        local cont = seat:getItemContainer()
        if cont:containsTag("Pillow") then
            return (bedType .. "Pillow")
        end
        return bedType
    end
    if not bed then
        bedType = "floor"
        if playerHasPillow then
            return (bedType .. "Pillow")
        end
        local square = playerObj:getSquare()
        local worldObjects = square:getWorldObjects()
        for i=1,worldObjects:size() do
            local item = worldObjects:get(i-1):getItem()
            if item and item:hasTag("Pillow") then
                return (bedType .. "Pillow")
            end
        end
        return bedType
    end
    local bedType = bed:getProperties():Val("BedType") or "averageBed"
    -- check for sleeping bags in tents
    if bed:getProperties() and bed:getProperties():Is("CustomName") and
            (bed:getProperties():Val("CustomName") == "Tent" or bed:getProperties():Val("CustomName") == "Shelter") then
        if bed:getContainer() then
            local cont = bed:getContainer()
            if cont:containsTag("TentBed") then bedType = "averageBed" end
            if cont:containsTag("Pillow") then return (bedType .. "Pillow") end
        end
        if playerHasPillow then
            return (bedType .. "Pillow")
        end
        return bedType
    end
    if playerHasPillow then
        return (bedType .. "Pillow")
    end
    if bed:getSquare() then
        local objects = ArrayList.new()
        bed:getSpriteGridObjectsIncludingSelf(objects)
        for n=1,objects:size() do
            local square = objects:get(n-1):getSquare()
            local worldObjects = square:getWorldObjects()
            for i=0, worldObjects:size()-1 do
                local item = worldObjects:get(i):getItem()
                if item and item:hasTag("Pillow") then
                    return (bedType .. "Pillow")
                end
            end
        end
    end
   return bedType
end

ISWorldObjectContextMenu.doSheetRopeOptions = function(_context, _object, _worldobjects, _player, _playerObj, _playerInv, _hasHammer, _test)
	local object = _object;
	if object ~= nil then
		local playerAboveGround = _playerObj:getCurrentSquare():getZ() > 0;
		local objectAboveGround = object:getSquare():getZ() > 0;
		local hasCorrectTools = object:getSprite():getProperties():Is("TieSheetRope") or (_playerInv:containsTypeRecurse("Nails") and _hasHammer);
		local sheetRopeCountIsValid = object:countAddSheetRope() > 0;
		if object:canAddSheetRope()
			and playerAboveGround
			and objectAboveGround
			and hasCorrectTools
			and sheetRopeCountIsValid
		then
			local isBarricadeableType = instanceof(object, "IsoThumpable") or instanceof(object, "IsoDoor") or instanceof(object, "IsoWindow");
			if isBarricadeableType and object:isBarricadeAllowed() and object:isBarricaded() then
				return;
			end;

			if (_playerInv:getItemCountRecurse("SheetRope") >= object:countAddSheetRope()) then
				if _test == true then return true; end
				if object:getSprite():getProperties():Is("TieSheetRope") then
					_context:addGetUpOption(getText("ContextMenu_Tie_escape_rope_sheet"), _worldobjects, ISWorldObjectContextMenu.onAddSheetRope, object, _player, true);
				else
					_context:addGetUpOption(getText("ContextMenu_Nail_escape_rope_sheet"), _worldobjects, ISWorldObjectContextMenu.onAddSheetRope, object, _player, true);
				end
			end
			if (_playerInv:getItemCountRecurse("Rope") >= object:countAddSheetRope()) then
				if _test == true then return true; end
				if object:getSprite():getProperties():Is("TieSheetRope") then
					_context:addGetUpOption(getText("ContextMenu_Tie_escape_rope"), _worldobjects, ISWorldObjectContextMenu.onAddSheetRope, object, _player, false);
				else
					_context:addGetUpOption(getText("ContextMenu_Nail_escape_rope"), _worldobjects, ISWorldObjectContextMenu.onAddSheetRope, object, _player, false);
				end
			end
		else
			if object:haveSheetRope() then
				if _test == true then return true; end
				_context:addGetUpOption(getText("ContextMenu_Remove_escape_rope"), _worldobjects, ISWorldObjectContextMenu.onRemoveSheetRope, object, _player);
			end
		end
	end
end

function ISWorldObjectContextMenu.doFluidContainerMenu(context, object, player)
	local playerObj = getSpecificPlayer(player)
	local containerName = getMoveableDisplayName(object) or object:getFluidUiName();
	local option = context:addOption(containerName, nil, nil)

	local mainSubMenu = ISContextMenu:getNew(context)
	context:addSubMenu(option, mainSubMenu)

	local isTrough = false;
	-- so i can add my specifics thing for feeding trough (as it can have food too) in this context option.
	if instanceof(object, "IsoFeedingTrough") then
		context.troughSubmenu = mainSubMenu;
		context.dontShowLiquidOption = true;
		isTrough = true;
	end

	--[[
    local tooltip = ISWorldObjectContextMenu.addToolTip()
    tooltip:setName(fetch.fluidcontainer:getFluidContainer():getContainerName())
    local amountString = getText("Fluid_Amount") .. ":";
    local tx = getTextManager():MeasureStringX(tooltip.font, amountString) + 20
    tooltip.description = string.format("%s: <SETX:%d> %d / %s", amountString, tx, fetch.fluidcontainer:getFluidContainer():getAmount() * 1000, (tostring(fetch.fluidcontainer:getFluidContainer():getCapacity() * 1000) .. " mL"))
     if fetch.fluidcontainer:getFluidContainer():isHiddenAmount() then
        tooltip.description = "Unknown";
    end
    tooltip.maxLineWidth = 512
    option.toolTip = tooltip
    ]]--
	
	-- distance test removed as per team meeting [SPIF-2281] - spurcival
	--if playerObj:DistToSquared(object:getX() + 0.5, object:getY() + 0.5) < 2 * 2 then
		if not isTrough then
			mainSubMenu:addOption(getText("Fluid_Show_Info"), player, ISWorldObjectContextMenu.onFluidInfo, object:getFluidContainer());
		end
		mainSubMenu:addOption(getText("Fluid_Transfer_Fluids"), player, ISWorldObjectContextMenu.onFluidTransfer, object:getFluidContainer());
	--end

	if object:hasFluid() then
		ISWorldObjectContextMenu.doDrinkWaterMenu(object, player, mainSubMenu);
		ISWorldObjectContextMenu.doFillFluidMenu(object, player, mainSubMenu);
	end
	if object:hasWater() then
		ISWorldObjectContextMenu.doWashClothingMenu(object, player, mainSubMenu);
	end

	if object:hasFluid() and object:getFluidCapacity() < 9999 then	-- capacity >= 9999 means infinite water.
		mainSubMenu:addOption(getText("Fluid_Empty"), player, ISWorldObjectContextMenu.onFluidEmpty, object:getFluidContainer());
	end

	return mainSubMenu;
end

function ISWorldObjectContextMenu.getUpAndThen(playerObj, function1, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	local action = ISWaitWhileGettingUp:new(playerObj)
	action:setOnComplete(function1, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10)
	ISTimedActionQueue.add(action)
end

function ISWorldObjectContextMenu.getMoveableDisplayName(obj)
	return getMoveableDisplayName(obj);
end

function ISWorldObjectContextMenu.onCustomFunction(context, object, playerObj, customFunction, param)
	assert(loadstring('return '..customFunction..'(...)'))(context, object, playerObj, param);
end

function ISWorldObjectContextMenu.onTimedAction(timedAction, object, playerObj, param)
    if luautils.walkAdj(playerObj, object:getSquare(), false) then
    	ISTimedActionQueue.add(assert(loadstring(timedAction..':new(...)'))(playerObj, object, object:getSquare(), param));
    end
end
Events.OnPressWalkTo.Add(ISWorldObjectContextMenu.onWalkTo);