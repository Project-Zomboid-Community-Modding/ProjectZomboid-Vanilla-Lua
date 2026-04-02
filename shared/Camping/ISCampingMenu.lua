require 'Camping/CCampfireSystem'

ISCampingMenu = {};
local DefaultBurnRatio = 2/3
local fuelItemList = ArrayList.new() -- used when adding fuel

local function itemCompare(a, b) return not string.sort(a:getDisplayName(), b:getDisplayName()) end

function ISCampingMenu.timeString(timeInMinutes)
	if not timeInMinutes then timeInMinutes = 5 end
	local hours = round(math.floor(timeInMinutes / 60),2)
	local minutes = round(timeInMinutes % 60,2)
	local hourStr = tostring(hours) .. ' ' .. (hours == 1 and getText("IGUI_Gametime_hour") or getText("IGUI_Gametime_hours"))
	local minuteStr = tostring(minutes) .. ' ' .. (minutes <= 1 and getText("IGUI_Gametime_minute") or getText("IGUI_Gametime_minutes"))
	if hours > 0 and minutes > 0 then
		return hourStr .. ', ' .. minuteStr
	elseif minutes > 0 then
		return minuteStr
	else
		return hourStr
	end
end

function ISCampingMenu.isValidCampfire(campfire)
	if not campfire then return false end
	campfire:updateFromIsoObject()
	return campfire:getIsoObject() ~= nil
end

function ISCampingMenu.shouldBurn(item, includeEquipped)
	if not item then return false end
	-- it might not always be the case that the player may want the item to burn, but it might still burn regardless
	if not includeEquipped and (item:isFavorite() or item:isEquipped()) then return false end
	-- This prevents jewelry, shoes, etc from being used.
	if item:IsClothing() and (not item:getFabricType() or item:getFabricType() == "Leather" or item:getWetness() > 0) then return false end
	if instanceof(item, "InventoryContainer") and not item:getInventory():isEmpty() then return false end
	if item:getFluidContainer() and item:getFluidContainer():getAmount() > 0 then return false end
	--TODO: check for appropriate moveables
	--     if instanceof(item, "Moveable") then
	--
	--     end
	return true
end

function ISCampingMenu.isPetrol(item)
	return item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) and (item:getFluidContainer():getAmount() >= ZomboidGlobals.LightFromPetrolAmount)
end

function ISCampingMenu.isValidFuel(item)
	return (item and ISCampingMenu.shouldBurn(item) and
			((item:hasTag(ItemTag.IS_FIRE_FUEL) or item:getFireFuelRatio() > 0) or
					(campingFuelCategory[item:getCategory()] and campingFuelCategory[item:getCategory()] ~= 0) or
					(campingFuelType[item:getType()] and campingFuelType[item:getType()] ~= 0)))
end

function ISCampingMenu.isValidTinder(item)
	return (item and ISCampingMenu.shouldBurn(item) and
			(item:hasTag(ItemTag.IS_FIRE_TINDER) or
					(campingLightFireType[item:getType()] and campingLightFireType[item:getType()] ~= 0) or
					(campingLightFireCategory[item:getCategory()] and campingLightFireCategory[item:getCategory()] ~= 0)))
end

function ISCampingMenu.getFuelDurationForItemInHours(item)
	if not item then return 0 end
	local value = campingLightFireCategory[item:getCategory()] or campingFuelCategory[item:getCategory()] or
			campingLightFireType[item:getType()] or campingFuelType[item:getType()]

	local burnRatio = DefaultBurnRatio
	if item:getFireFuelRatio() > 0 then
		burnRatio = item:getFireFuelRatio()
	elseif item:IsClothing() or item:IsInventoryContainer() or item:IsLiterature() or item:IsMap() then
		burnRatio = 0.25
	end

	if value then
		return math.min(value, item:getActualWeight() * burnRatio)
	end

	return item:getActualWeight() * burnRatio
end

-- this should return minutes
function ISCampingMenu.getFuelDurationForItem(item)
	return ISCampingMenu.getFuelDurationForItemInHours(item) * 60
end

function ISCampingMenu.getFuelItemUses(item)
	if not item:IsDrainable() or item:hasTag(ItemTag.IS_FIRE_FUEL_SINGLE_USE) then return 1 end
	return item:getCurrentUses()
end

function ISCampingMenu.getNearbyFuelInfo(playerObj)
	local fuel = {
		starters = {}, -- startFireList
		fuelList = {}, -- fuelList
		tinder = {}, -- lightFireList
		itemCount = {},

		petrol = nil,
		percedWood = nil,
		branch = nil,
		stick = nil,
	}

	local starterTypes = {} -- startFireTypes
	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	local isTinder = false
	local isFuel = false
	local item = nil
	local type = nil
	for i=1,containers:size() do
		local container = containers:get(i-1)
		for j=1,container:getItems():size() do
			item = container:getItems():get(j-1)
			type = item:getType()
			local uses = item:getCurrentUses()
			if (item:hasTag(ItemTag.START_FIRE) or type == "Lighter" or type == "Matches") and (item:getCurrentUses() > 0) then
				if not starterTypes[type] then
					table.insert(fuel.starters, item)
					starterTypes[type] = true
				end
			elseif ISCampingMenu.isPetrol(item) then
				fuel.petrol = item
			elseif type == "PercedWood" then
				fuel.percedWood = item
			elseif type == "TreeBranch" or type == "TreeBranch2" then
				fuel.branch = item
			elseif type == "WoodenStick" or type == "WoodenStick2" then
				fuel.stick = item
			end

			-- check the player inventory to add some fuel (logs, planks, books..)
			isFuel = ISCampingMenu.isValidFuel(item)
			isTinder = ISCampingMenu.isValidTinder(item)
			if isFuel or isTinder then
				if not fuel.itemCount[item:getName()] then
					if isFuel then
						table.insert(fuel.fuelList, item)
					end
					if isTinder then
						table.insert(fuel.tinder, item)
					end
					fuel.itemCount[item:getName()] = ISCampingMenu.getFuelItemUses(item)
				else
					fuel.itemCount[item:getName()] = fuel.itemCount[item:getName()] + ISCampingMenu.getFuelItemUses(item)
				end
			end
		end
	end
	return fuel
end

function ISCampingMenu.doAddFuelOption(context, worldobjects, currentFuel, fuelInfo, target, timedAction, playerObj)

	local option = context:addOption(campingText.addFuel, worldobjects, nil)
	if currentFuel >= getCampingFuelMax() then
		option.notAvailable = true;
		option.toolTip = ISWorldObjectContextMenu.addToolTip();
		option.toolTip.description = getText("ContextMenu_Fuel_Full");
		return false
	end

	if table.isempty(fuelInfo.fuelList) then
		option.notAvailable = true;
		option.toolTip = ISWorldObjectContextMenu.addToolTip();
		option.toolTip.description = getText("ContextMenu_No_Fuel");
--         local option = subMenuFuel:addOption(getText("ContextMenu_No_LightingMethod"), worldobjects, nil);
        option.notAvailable = true;
    end

	local subMenuFuel = ISContextMenu:getNew(context)
	context:addSubMenu(option, subMenuFuel)

	if #fuelInfo.fuelList > 1 then
		local numItems = 0
		local duration = 0
		local allCanFit = true
		for _,item in ipairs(fuelInfo.fuelList) do
			local count = fuelInfo.itemCount[item:getName()]
			duration = duration + (ISCampingMenu.getFuelDurationForItem(item) or 0.0) * count
			numItems = numItems + count
		end
		if numItems > 1 then
			option = subMenuFuel:addActionsOption(getText("ContextMenu_AllWithCount", numItems), ISCampingMenu.onAddAllFuel, target, timedAction, currentFuel)
			option.toolTip = ISWorldObjectContextMenu.addToolTip()
			option.toolTip.description = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(duration))
            if ( currentFuel + duration ) > getCampingFuelMax() then
                option.notAvailable = true;
                option.toolTip = ISWorldObjectContextMenu.addToolTip();
                option.toolTip.description = getText("ContextMenu_Fuel_Full3");
            end
		end
	end

	table.sort(fuelInfo.fuelList, itemCompare)
	for _, item in ipairs(fuelInfo.fuelList) do
		local label = item:getName()
		local count = fuelInfo.itemCount[item:getName()]
		local originalCount = count
		local allReallyFits = true
		while ( currentFuel + (ISCampingMenu.getFuelDurationForItem(item) * count) ) > getCampingFuelMax() and count > 1 do
            count = count - 1
            allReallyFits = false
        end

		if count > 1 then
			label = label..' ('..originalCount..')'
			local subMenu = context:getNew(subMenuFuel)
			option = subMenuFuel:addOption(label)
			option.itemForTexture = item
			subMenuFuel:addSubMenu(option, subMenu)

			option = subMenu:addActionsOption(getText("ContextMenu_One"), ISCampingMenu.onAddFuel, target, item:getFullType(), timedAction, currentFuel)
			option.toolTip = ISWorldObjectContextMenu.addToolTip()
			option.toolTip.description = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(ISCampingMenu.getFuelDurationForItem(item)))
            if ( currentFuel + ISCampingMenu.getFuelDurationForItem(item) ) > getCampingFuelMax() then
                option.notAvailable = true;
                option.toolTip = ISWorldObjectContextMenu.addToolTip();
                option.toolTip.description = getText("ContextMenu_Fuel_Full3");
            end

            if allReallyFits then
			    option = subMenu:addActionsOption(getText("ContextMenu_AllWithCount", count), ISCampingMenu.onAddMultipleFuel, target, item:getFullType(), timedAction, currentFuel)
            else
			    option = subMenu:addActionsOption(getText("ContextMenu_AllThatFitsWithCount", count), ISCampingMenu.onAddMultipleFuel, target, item:getFullType(), timedAction, currentFuel, count)
            end
			option.toolTip = ISWorldObjectContextMenu.addToolTip()
			option.toolTip.description = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(ISCampingMenu.getFuelDurationForItem(item) * count))
            if ( currentFuel + (ISCampingMenu.getFuelDurationForItem(item) * count) ) > getCampingFuelMax() then
                option.notAvailable = true;
                option.toolTip = ISWorldObjectContextMenu.addToolTip();
                option.toolTip.description = getText("ContextMenu_Fuel_Full3");
            end
		else
			option = subMenuFuel:addActionsOption(label, ISCampingMenu.onAddFuel, target, item:getFullType(), timedAction, currentFuel)
			option.itemForTexture = item
			option.toolTip = ISWorldObjectContextMenu.addToolTip()
			option.toolTip.description = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(ISCampingMenu.getFuelDurationForItem(item)))
            if ( currentFuel + ISCampingMenu.getFuelDurationForItem(item) ) > getCampingFuelMax() then
                option.notAvailable = true;
                option.toolTip = ISWorldObjectContextMenu.addToolTip();
                option.toolTip.description = getText("ContextMenu_Fuel_Full3");
            end
		end
	end
	return true
end


function ISCampingMenu.doLightFireOption(playerObj, context, worldobjects, hasFuel, fuelInfo, target, petrolAction, tinderAction, kindleAction)
	table.sort(fuelInfo.starters, itemCompare)

	local subMenu = ISContextMenu:getNew(context);

    local canLight = false
    if (not table.isempty(fuelInfo.starters)) and hasFuel and fuelInfo.petrol then canLight = true end
    if (not table.isempty(fuelInfo.starters)) and (not table.isempty(fuelInfo.tinder)) then canLight = true end
    if fuelInfo.percedWood then canLight = true end


	if not canLight then
        local option = subMenu:addOption(getText("ContextMenu_No_LightingMethod"), worldobjects, nil);
        option.notAvailable = true;
    end


	if not table.isempty(fuelInfo.starters) and hasFuel and fuelInfo.petrol then
		for _,item in ipairs(fuelInfo.starters) do
			local option = subMenu:addActionsOption(fuelInfo.petrol:getName()..' + '..item:getName(), ISCampingMenu.onLightFromPetrol, item, fuelInfo.petrol, target, petrolAction)
			option.itemForTexture = fuelInfo.petrol
		end
	end

	if not table.isempty(fuelInfo.tinder) then
		table.sort(fuelInfo.tinder, itemCompare)
		for _,v in ipairs(fuelInfo.tinder) do
			local label = v:getName()
			local count = fuelInfo.itemCount[v:getName()]

			local fuelAmt = ISCampingMenu.getFuelDurationForItem(v)
			if count > 1 then
				label = label..' ('..count..')'
			end
			for _,item in ipairs(fuelInfo.starters) do
				option = subMenu:addActionsOption(label..' + '..item:getName(), ISCampingMenu.onLightFromLiterature, v:getFullType(), item, target, tinderAction)
			    option.itemForTexture = v
				option.toolTip = ISWorldObjectContextMenu.addToolTip()
				option.toolTip.description = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(round(fuelAmt,2)))
			end
		end
	end

	if fuelInfo.percedWood then
		if (fuelInfo.stick or fuelInfo.branch) and hasFuel and playerObj:getStats():get(CharacterStat.ENDURANCE) > 0 then
			local item = fuelInfo.stick or fuelInfo.branch
			local option = subMenu:addActionsOption(fuelInfo.percedWood:getName()..' + '..item:getName(), ISCampingMenu.onLightFromKindle, fuelInfo.percedWood, item, target, kindleAction);
			option.itemForTexture = fuelInfo.percedWood
        else
			local option = subMenu:addOption(fuelInfo.percedWood:getName(), worldobjects, nil);
			option.itemForTexture = fuelInfo.percedWood
			option.notAvailable = true;
			local tooltip = ""

			if playerObj:getStats():get(CharacterStat.ENDURANCE) <= 0 then
                if string.len(tooltip) > 0 then tooltip = tooltip .. " <LINE> " end
                tooltip = tooltip ..getText("Tooltip_lightFireNoEndurance")
            end

			if (not fuelInfo.stick) and (not fuelInfo.branch) then
                if string.len(tooltip) > 0 then tooltip = tooltip .. " <LINE> " end
                tooltip = tooltip ..getText("Tooltip_lightFireNoStick")
            end

			if (not hasFuel) then
                if string.len(tooltip) > 0 then tooltip = tooltip .. " <LINE> " end
                tooltip = tooltip ..getText("Tooltip_lightFireNoFuel")
            end
			option.toolTip = ISWorldObjectContextMenu.addToolTip()
			option.toolTip:setName(fuelInfo.percedWood:getName())
			option.toolTip.description = tooltip
        end
	end

	if #(subMenu.options) > 0 then
		local option = context:addOption(campingText.lightCampfire, worldobjects, nil);
		context:addSubMenu(option, subMenu);
	end

end

ISCampingMenu.doCampingMenu = function(player, context, worldobjects, test)

	if test and ISWorldObjectContextMenu.Test then return true end

	local playerObj = getSpecificPlayer(player)
	if playerObj:getVehicle() then return end

	local campfire = nil

	for _,v in ipairs(worldobjects) do
		campfire = CCampfireSystem.instance:getLuaObjectOnSquare(v:getSquare())
	end

	if not campfire then return end
	if test then return ISWorldObjectContextMenu.setTest() end

	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(playerObj)

	local isoCampfireObject = campfire:getIsoObject();
    local campfireOption = context:addOption(isoCampfireObject:getTileName(), worldobjects, nil)
    local tile = isoCampfireObject:getSpriteName();
    if tile then
        campfireOption.iconTexture = getTexture(tile):splitIcon();
    end
    local campfireMenu = ISContextMenu:getNew(context);
    context:addSubMenu(campfireOption, campfireMenu);

	local distance = playerObj:DistToSquared(isoCampfireObject:getX() + 0.5, isoCampfireObject:getY() + 0.5)
	if distance < 4 then -- distance < 2 * 2
		local text = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(luautils.round(campfire.fuelAmt))) ..
				" (" .. (campfire.isLit and getText("IGUI_Fireplace_Burning") or getText("IGUI_Fireplace_Unlit")) .. ")"
        local option = campfireMenu:addOption(text, worldobjects, ISCampingMenu.onDisplayInfo, player, campfire)
	end

	-- Add corpse to fire
	if playerObj:isGrappling() then
		option = campfireMenu:addOption(getText("ContextMenu_CampfireCorpse"), worldobjects, ISCampingMenu.onDropCorpse, playerObj, isoCampfireObject, campfire)
		if campfire.isLit then
			option.notAvailable = true
			option.toolTip = ISToolTip:new()
			option.toolTip:initialise()
			option.toolTip:setVisible(false)
			option.toolTip:setName(getText("ContextMenu_CampfireCorpse"))
			option.toolTip.description = getText("Tooltip_campfire_addcorpse")
		elseif distance > 1.5 then
			option.notAvailable = true
			option.toolTip = ISToolTip:new()
			option.toolTip:initialise()
			option.toolTip:setVisible(false)
			option.toolTip:setName(getText("ContextMenu_CampfireCorpse"))
			option.toolTip.description = getText("Tooltip_campfire_addcorpse_far")
		end
	end

	ISCampingMenu.doAddFuelOption(campfireMenu, worldobjects, campfire.fuelAmt or 0, fuelInfo, campfire, ISAddFuelAction)

	if campfire.isLit then
		campfireMenu:addOption(campingText.putOutCampfire, worldobjects, ISCampingMenu.onPutOutCampfire, playerObj, campfire)
	else
		ISCampingMenu.doLightFireOption(playerObj, campfireMenu, worldobjects, campfire.fuelAmt and campfire.fuelAmt > 0,
				fuelInfo, campfire, ISLightFromPetrol, ISLightFromLiterature, ISLightFromKindle)
	end
	campfireMenu:addOption(campingText.removeCampfire, worldobjects, ISCampingMenu.onRemoveCampfire, playerObj, campfire);
end

function ISCampingMenu.toPlayerInventory(playerObj, item)
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
end

function ISCampingMenu.onDisplayInfo(worldobjects, playerObj, isoCampfireObject, campfire)
	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), isoCampfireObject:getSquare()) then
		local adjacent = AdjacentFreeTileFinder.Find(isoCampfireObject:getSquare(), playerObj)
		if adjacent then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
			ISTimedActionQueue.add(ISCampingInfoAction:new(playerObj, isoCampfireObject, campfire))
			return
		end
	else
		ISTimedActionQueue.add(ISCampingInfoAction:new(playerObj, isoCampfireObject, campfire))
	end
end

function ISCampingMenu.onDropCorpse(worldobjects, playerObj, isoCampfireObject, campfire)
	playerObj:faceThisObject(isoCampfireObject)
	local func = nil
	func = function()
		playerObj:faceThisObject(isoCampfireObject)
		if not playerObj:shouldBeTurning() then
			playerObj:getGrapplingTarget():setCurrent(isoCampfireObject:getSquare())
			playerObj:setDoGrappleLetGo();
			Events.OnTick.Remove(func)
		end
	end
	Events.OnTick.Add(func)
end

function ISCampingMenu.walkToCampfire(playerObj, square)
    for i=1,square:getObjects():size() do
        local object = square:getObjects():get(i-1)
        if instanceof(object, 'IsoFireplace') and not square:isSolid() and not square:isSolidTrans() then
            local x = square:getX()
            local y = square:getY()
            local z = square:getZ()
            if object:getProperties():has(IsoFlagType.collideW) then
                x = x + 0.8
                y = y + 0.5
            else
                x = x + 0.5
                y = y + 0.8
            end
            if (square:getZ() == playerObj:getCurrentSquare():getZ()) and
                    (playerObj:DistToSquared(x, y) < 0.2 * 0.2) then
                return true
            end
            ISTimedActionQueue.add(ISPathFindAction:pathToLocationF(playerObj, x, y, z))
            return true
        end
    end
	local adjacent = AdjacentFreeTileFinder.FindClosest(square, playerObj)
	if adjacent == nil then return false end
	local x = adjacent:getX()
	local y = adjacent:getY()
	local z = adjacent:getZ()
	if adjacent == square:getAdjacentSquare(IsoDirections.NW) then
		x = x + 0.8
		y = y + 0.8
	elseif adjacent == square:getAdjacentSquare(IsoDirections.NE) then
		x = x + 0.2
		y = y + 0.8
	elseif adjacent == square:getAdjacentSquare(IsoDirections.SE) then
		x = x + 0.2
		y = y + 0.2
	elseif adjacent == square:getAdjacentSquare(IsoDirections.SW) then
		x = x + 0.8
		y = y + 0.2
	else
		x = x + 0.5
		y = y + 0.5
	end
	if (square:getZ() == playerObj:getCurrentSquare():getZ()) and
			(playerObj:DistToSquared(x, y) < 0.2 * 0.2) then
		return true
	end
	ISTimedActionQueue.add(ISPathFindAction:pathToLocationF(playerObj, x, y, z))
	return true
end

ISCampingMenu.onAddFuel = function(playerObj, target, fuelType, timedAction, currentFuel)
	--if not ISCampingMenu.isValidCampfire(campfire) then return end
	local fuelItem = nil
	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	for i=1,containers:size() do
		fuelItem = containers:get(i-1):getFirstTypeEvalRecurse(fuelType, ISCampingMenu.isValidFuel)
		if fuelItem then break end
	end
	if not fuelItem then return end
	local fuelAmt = ISCampingMenu.getFuelDurationForItem(fuelItem)
	--if not fuelAmt or fuelAmt <= 0 then return end
	ISCampingMenu.toPlayerInventory(playerObj, fuelItem)
	if not ISCampingMenu.walkToCampfire(playerObj, target:getSquare()) then return end
	--if playerObj:isEquipped(fuelItem) then
	--	ISTimedActionQueue.add(ISUnequipAction:new(playerObj, fuelItem, 50))
	--end
	ISTimedActionQueue.add(timedAction:new(playerObj, target, fuelItem, fuelAmt))
end

local function addFuel(playerObj, target, fuel, timedAction, currentFuel, count)
	if fuel:isEmpty() then return end
	local max = fuel:size()
	if count then max = count end

    local fuelItems = ArrayList.new();
	for i=1,max do
        fuelItems:add(fuel:get(i-1))
    end

	ISCampingMenu.toPlayerInventory(playerObj, fuelItems)
	if not ISCampingMenu.walkToCampfire(playerObj, target:getSquare()) then return end
	for i=1,max do
		local fuelItem = fuelItems:get(i-1)
		if playerObj:isEquipped(fuelItem) then
			ISTimedActionQueue.add(ISUnequipAction:new(playerObj, fuelItem, 50))
		end
		local fuelAmt = ISCampingMenu.getFuelDurationForItem(fuelItem)
		for j=1, ISCampingMenu.getFuelItemUses(fuelItem) do
			if (currentFuel + (fuelAmt*j) > getCampingFuelMax()) then return end
			ISTimedActionQueue.add(timedAction:new(playerObj, target, fuelItem, fuelAmt))
		end
	end
end

ISCampingMenu.onAddAllFuel = function(playerObj, target, timedAction, currentFuel)
	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	for i=1,containers:size() do
		local container = containers:get(i-1)
		container:getAllEval(ISCampingMenu.isValidFuel, fuelItemList)
	end
	addFuel(playerObj, target, fuelItemList, timedAction, currentFuel)
	fuelItemList:clear() -- dont forget to clear!
end

ISCampingMenu.onAddMultipleFuel = function(playerObj, target, fuelType, timedAction, currentFuel, count)
	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	for i=1,containers:size() do
		local container = containers:get(i-1)
		container:getAllTypeEval(fuelType, ISCampingMenu.isValidFuel, fuelItemList)
	end
	addFuel(playerObj, target, fuelItemList, timedAction, currentFuel, count)
	fuelItemList:clear() -- dont forget to clear!
end

ISCampingMenu.onPutOutCampfire = function(worldobjects, playerObj, campfire)
	if ISCampingMenu.walkToCampfire(playerObj, campfire:getSquare()) then
		ISTimedActionQueue.add(ISPutOutCampfireAction:new(playerObj, campfire));
	end
end

ISCampingMenu.onRemoveCampfire = function(worldobjects, playerObj, campfire)
	if ISCampingMenu.walkToCampfire(playerObj, campfire:getSquare()) then
		ISTimedActionQueue.add(ISRemoveCampfireAction:new(playerObj, campfire, 60));
	end
end

ISCampingMenu.onLightFromLiterature = function(playerObj, itemType, lighter, target, timedAction)
	timedAction = timedAction or ISLightFromLiterature
	local lighterCont = lighter:getContainer()
	local fuelItem = nil
	local containers = ISInventoryPaneContextMenu.getContainers(playerObj)
	for i=1,containers:size() do
		fuelItem = containers:get(i-1):getFirstTypeEvalRecurse(itemType, ISCampingMenu.isValidTinder)
		if fuelItem then break end
	end
	ISCampingMenu.toPlayerInventory(playerObj, fuelItem)
	ISCampingMenu.toPlayerInventory(playerObj, lighter)
	if ISCampingMenu.walkToCampfire(playerObj, target:getSquare()) then
		local fuelAmt = ISCampingMenu.getFuelDurationForItem(fuelItem)
		ISTimedActionQueue.add(timedAction:new(playerObj, fuelItem, lighter, target, fuelAmt));
	end
	ISCraftingUI.ReturnItemToContainer(playerObj, lighter, lighterCont)
end

ISCampingMenu.onLightFromKindle = function(playerObj, percedWood, stickOrBranch, target, timedAction)
	timedAction = timedAction or ISLightFromKindle
	local stickCont = stickOrBranch:getContainer()
	local percCont = percedWood:getContainer()
	ISCampingMenu.toPlayerInventory(playerObj, percedWood)
	ISCampingMenu.toPlayerInventory(playerObj, stickOrBranch)
	if ISCampingMenu.walkToCampfire(playerObj, target:getSquare()) then
		ISTimedActionQueue.add(timedAction:new(playerObj, percedWood, stickOrBranch, target));
	end
	ISCraftingUI.ReturnItemToContainer(playerObj, stickOrBranch, stickCont)
	ISCraftingUI.ReturnItemToContainer(playerObj, percedWood, percCont)
end

ISCampingMenu.onLightFromPetrol = function(playerObj, lighter, petrol, target, timedAction)
	timedAction = timedAction or ISLightFromPetrol
	local lighterCont = lighter:getContainer()
	ISCampingMenu.toPlayerInventory(playerObj, lighter)
	ISCampingMenu.toPlayerInventory(playerObj, petrol)
	if ISCampingMenu.walkToCampfire(playerObj, target:getSquare()) then
		ISTimedActionQueue.add(timedAction:new(playerObj, target, lighter, petrol, 20));
	end
	ISCraftingUI.ReturnItemToContainer(playerObj, lighter, lighterCont)
end
