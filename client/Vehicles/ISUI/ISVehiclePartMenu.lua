--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISVehiclePartMenu = {}

local function predicateNotBroken(item)
	return not item:isBroken()
end

local function predicatePetrol(item)
	return item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol)
end

local function predicateEmptyContainer(item)
	return item:getFluidContainer() and item:getFluidContainer():isEmpty()
end

local function predicateEmptyPetrol(item)
	return item:getFluidContainer() and item:hasTag("Petrol") and item:getFluidContainer():isEmpty()
end

local function predicatePetrolNotFull(item)
	return item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) and item:getFluidContainer():getFreeCapacity() > 0
end

function ISVehiclePartMenu.getNearbyFuelPump(vehicle)
	local part = vehicle:getPartById("GasTank")
	if not part then return nil end
	local areaCenter = vehicle:getAreaCenter(part:getArea())
	if not areaCenter then return nil end
	local square = getCell():getGridSquare(areaCenter:getX(), areaCenter:getY(), vehicle:getZ())
	if not square then return nil end
	for dy=-2,2 do
		for dx=-2,2 do
			-- TODO: check line-of-sight between 2 squares
			local square2 = getCell():getGridSquare(square:getX() + dx, square:getY() + dy, square:getZ())
			if not square2 or not square2:getObjects() then
				return nil;
			end
			for i=0, square2:getObjects():size()-1 do
				local obj = square2:getObjects():get(i);
				if obj:getPipedFuelAmount() > 0 then
					return obj
				end
			end
		end
	end
end

function ISVehiclePartMenu.getGasCanNotEmpty(playerObj, typeToItem)
	-- Prefer an equipped PetrolCan, then the emptiest PetrolCan.
	local equipped = playerObj:getPrimaryHandItem()
	if equipped and predicatePetrol(equipped) then
		return equipped
	end
	local inv = playerObj:getInventory()
	if inv:containsEvalRecurse(predicatePetrol) then
		local allPetrol = inv:getAllEvalRecurse(predicatePetrol)
		local gasCan = nil
		local amount = - 1
        for j=1,allPetrol:size() do
            local item = allPetrol:get(j-1)
			if item:getFluidContainer():getAmount() > 0 and ( item:getFluidContainer():getAmount() > amount ) then
				gasCan = item
				amount = gasCan:getFluidContainer():getAmount();
			end
		end
		if gasCan then return gasCan end
	end
	return nil
end

function ISVehiclePartMenu.getGasCanNotFull(playerObj, typeToItem)
	-- Prefer an equipped PetrolCanEmpty/PetrolCan, then the fullest PetrolCan, then any PetrolCanEmpty.
	local equipped = playerObj:getPrimaryHandItem()
	if equipped and predicatePetrolNotFull(equipped) then
		return equipped
	end
	if equipped and predicateEmptyPetrol(equipped) then
		return equipped
	end
	local inv = playerObj:getInventory()
	if inv:containsEvalRecurse(predicatePetrolNotFull) then
		local allPetrol = inv:getAllEvalRecurse(predicatePetrolNotFull)
		local gasCan = nil
		-- local usedDelta = -1
		local amount = -1
		for j=1,allPetrol:size() do
			local item = allPetrol:get(j-1)
			if item:getFluidContainer():getAmount() > amount then
				gasCan = item
				amount = gasCan:getFluidContainer():getAmount();
			end
		end
		if gasCan then return gasCan end
	end
	if inv:containsEvalRecurse(predicateEmptyPetrol) then
		return inv:getFirstEvalRecurse(predicateEmptyPetrol)
	end
	if inv:containsEvalRecurse(predicateEmptyContainer) then
    	return inv:getFirstEvalRecurse(predicateEmptyContainer)
    end
	return nil
end

function ISVehiclePartMenu.toPlayerInventory(playerObj, item)
	if item and item:getContainer() and item:getContainer() ~= playerObj:getInventory() then
		local action = ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory())
		ISTimedActionQueue.add(action)
	end
end

function ISVehiclePartMenu.toPlayerInventoryTag(playerObj, tag)
	local item = playerObj:getInventory():getFirstTagEvalRecurse(tag, predicateNotBroken)
	if item and item:getContainer() and item:getContainer() ~= playerObj:getInventory() then
		local action = ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory())
		ISTimedActionQueue.add(action)
	end
end

function ISVehiclePartMenu.transferRequiredItems(playerObj, part, tbl)
	if not tbl or not tbl.items then return end
	local typeToItem,tagToItem = VehicleUtils.getItems(playerObj:getPlayerNum())
	local itemScripts = VehicleUtils.getItemScripts(tbl.items)
	for _,itemTable in ipairs(itemScripts) do
		local count = 0
		for _,thing in ipairs(itemTable.scripts) do
			local fullType = thing.script:getFullName()
			-- FIXME: handle drainables
			if typeToItem[fullType] ~= nil and #typeToItem[fullType] > 0 then
				local invItem = table.remove(typeToItem[fullType], 1)
				 ISVehiclePartMenu.toPlayerInventory(playerObj, invItem)
				 count = count + 1
			end
			if count >= tonumber(itemTable.item.count) then
				break
			end
		end
	end
end

function ISVehiclePartMenu.equipRequiredItems(playerObj, part, tbl)
	if not tbl or not tbl.items then return end
	local typeToItem,tagToItem = VehicleUtils.getItems(playerObj:getPlayerNum())
	local itemScripts = VehicleUtils.getItemScripts(tbl.items)
	for _,itemTable in ipairs(itemScripts) do
		local item = itemTable.item
		for _,thing in ipairs(itemTable.scripts) do
			local type = thing.script:getFullName()
			if typeToItem[type] then
				if item.equip == "primary" then
					ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), typeToItem[type][1], true)
				elseif item.equip == "secondary" then
					ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), typeToItem[type][1], false)
				elseif item.equip == "both" then
					ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), typeToItem[type][1], false, true)
				end
				break
			end
		end
	end
end

function ISVehiclePartMenu.onInstallPart(playerObj, part, item)
	if not ISVehicleMechanics.cheat then
		if playerObj:getVehicle() then
			ISVehicleMenu.onExit(playerObj)
		end
		
		ISVehiclePartMenu.toPlayerInventory(playerObj, item)
		
		local tbl = part:getTable("install")
		ISVehiclePartMenu.transferRequiredItems(playerObj, part, tbl)

		local area = tbl.area or part:getArea()
		ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), area))
		
		ISVehiclePartMenu.equipRequiredItems(playerObj, part, tbl)
	end
	
	-- Open the engine cover if needed
	-- TODO: pop hood inside vehicle?
	local engineCover = nil
	local keyvalues = part:getTable("install")
	if keyvalues.door then
		local doorPart = part:getVehicle():getPartById(keyvalues.door)
		if doorPart and doorPart:getDoor() and doorPart:getInventoryItem() and not doorPart:getDoor():isOpen() then
			engineCover = doorPart
		end
	end
	
	local time = tonumber(keyvalues.time) or 50
	if engineCover and not ISVehicleMechanics.cheat then
		ISTimedActionQueue.add(ISOpenVehicleDoor:new(playerObj, part:getVehicle(), engineCover))
		ISTimedActionQueue.add(ISInstallVehiclePart:new(playerObj, part, item, time - (playerObj:getPerkLevel(Perks.Mechanics) * (time/15))))
		ISTimedActionQueue.add(ISCloseVehicleDoor:new(playerObj, part:getVehicle(), engineCover))
	else
		ISTimedActionQueue.add(ISInstallVehiclePart:new(playerObj, part, item, time - (playerObj:getPerkLevel(Perks.Mechanics) * (time/15))))
	end
end

function ISVehiclePartMenu.onUninstallPart(playerObj, part)
	if not ISVehicleMechanics.cheat then
		if playerObj:getVehicle() then
			ISVehicleMenu.onExit(playerObj)
		end
		local tbl = part:getTable("uninstall")
		ISVehiclePartMenu.transferRequiredItems(playerObj, part, tbl)
	
		local area = tbl.area or part:getArea()
		ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), area))
	
		ISVehiclePartMenu.equipRequiredItems(playerObj, part, tbl)
	end
	-- Open the engine cover if needed
	-- TODO: pop hood inside vehicle?
	local engineCover = nil;
	local keyvalues = part:getTable("install")
	if keyvalues.door then
		local doorPart = part:getVehicle():getPartById(keyvalues.door)
		if doorPart and doorPart:getDoor() and doorPart:getInventoryItem() and not doorPart:getDoor():isOpen() then
			engineCover = doorPart
		end
	end
	local time = tonumber(keyvalues.time) or 50
	if engineCover and not ISVehicleMechanics.cheat then
		ISTimedActionQueue.add(ISOpenVehicleDoor:new(playerObj, part:getVehicle(), engineCover))
		ISTimedActionQueue.add(ISUninstallVehiclePart:new(playerObj, part, time))
		ISTimedActionQueue.add(ISCloseVehicleDoor:new(playerObj, part:getVehicle(), engineCover))
	else
		ISTimedActionQueue.add(ISUninstallVehiclePart:new(playerObj, part, time))
	end
end

function ISVehiclePartMenu.onPumpGasoline(playerObj, part)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	local fuelStation = ISVehiclePartMenu.getNearbyFuelPump(part:getVehicle())
	if fuelStation then
		local square = fuelStation:getSquare();
		if square then
			local action = ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea())
			action:setOnFail(ISVehiclePartMenu.onPumpGasolinePathFail, playerObj)
			ISTimedActionQueue.add(action)
			ISTimedActionQueue.add(ISRefuelFromGasPump:new(playerObj, part, fuelStation))
		end
	end
end

function ISVehiclePartMenu.onPumpGasolinePathFail(playerObj)
	-- playerObj:Say(getText("IGUI_PlayerText_NoWayToFuelTankInlet"));
	HaloTextHelper.addBadText(playerObj, getText("IGUI_PlayerText_NoWayToFuelTankInlet"));
-- 	HaloTextHelper.addText(playerObj, getText("IGUI_PlayerText_NoWayToFuelTankInlet"), getCore():getGoodHighlitedColor());
end

function ISVehiclePartMenu.onAddGasoline(playerObj, part)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	local typeToItem = VehicleUtils.getItems(playerObj:getPlayerNum())
	local item = ISVehiclePartMenu.getGasCanNotEmpty(playerObj, typeToItem)
	if item then
		ISVehiclePartMenu.toPlayerInventory(playerObj, item)
		ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
		ISInventoryPaneContextMenu.equipWeapon(item, true, false, playerObj:getPlayerNum())
		ISTimedActionQueue.add(ISAddGasolineToVehicle:new(playerObj, part, item))
	end
end

function ISVehiclePartMenu.onTakeGasoline(playerObj, part)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	local typeToItem,tagToItem = VehicleUtils.getItems(playerObj:getPlayerNum())
	local item = ISVehiclePartMenu.getGasCanNotFull(playerObj, typeToItem)
	local hose = tagToItem["SiphonGas"] and tagToItem["SiphonGas"][1]
	if item and hose then
		ISVehiclePartMenu.toPlayerInventory(playerObj, item)
		ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
		ISInventoryPaneContextMenu.equipWeapon(item, false, false, playerObj:getPlayerNum())
		ISInventoryPaneContextMenu.equipWeapon(hose, true, false, playerObj:getPlayerNum())
		ISTimedActionQueue.add(ISTakeGasolineFromVehicle:new(playerObj, part, item))
	end
end

function ISVehiclePartMenu.onDebugFill(playerObj, part)
	part:setContainerContentAmount(part:getContainerCapacity())
end

function ISVehiclePartMenu.onInflateTire(playerObj, part)
	if not playerObj:getInventory():contains("TirePump", true) then return end
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	-- TODO: choose desired tire pressure (underinflated - recommended - max)
	ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
	local pump = ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), "TirePump", true)
	local psiTarget = part:getContainerCapacity() + 5
	if round(part:getContainerContentAmount(), 2) < part:getContainerCapacity() then
		psiTarget = part:getContainerCapacity()
	end
	ISTimedActionQueue.add(ISInflateTire:new(playerObj, part, pump, psiTarget))
end

function ISVehiclePartMenu.onDeflateTire(playerObj, part)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	-- TODO: choose desired tire pressure (underinflated - recommended - max)
	ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
	ISTimedActionQueue.add(ISDeflateTire:new(playerObj, part, 0))
end

function ISVehiclePartMenu.onDeviceOptions(playerObj, part)
	if playerObj:getVehicle() ~= part:getVehicle() then
		if playerObj:getVehicle() then
			ISVehicleMenu.onExit(playerObj)
		end
		-- TODO: walk to vehicle and enter it
	end
	ISRadioWindow.activate(playerObj, part)
end

function ISVehiclePartMenu.onLockDoor(playerObj, part)
	if playerObj:getVehicle() ~= part:getVehicle() then
		if playerObj:getVehicle() then
			ISVehicleMenu.onExit(playerObj)
		end
	end
	-- TODO: check key
	-- TODO: walk to door
	ISTimedActionQueue.add(ISLockVehicleDoor:new(playerObj, part))
end

function ISVehiclePartMenu.onUnlockDoor(playerObj, part)
	if playerObj:getVehicle() ~= part:getVehicle() then
		if playerObj:getVehicle() then
			ISVehicleMenu.onExit(playerObj)
		end
	end
	-- TODO: check key
	-- TODO: walk to door
	ISTimedActionQueue.add(ISUnlockVehicleDoor:new(playerObj, part))
end

function ISVehiclePartMenu.onOpenCloseWindow(playerObj, part, open)
	-- get seat to sit in to operate this window
	-- if seat occupied, fail
	-- if entrace blocked, find another seat we can sit it that can switch to the desired seat
	-- possibly allow operting window from outside, by opening the door first
	if playerObj:getVehicle() ~= part:getVehicle() then
		if playerObj:getVehicle() then
			ISVehicleMenu.onExit(playerObj)
		end
	end
	ISTimedActionQueue.add(ISOpenCloseVehicleWindow:new(playerObj, part, open))
end


function ISVehiclePartMenu.onLockDoors(playerObj, vehicle, lock)
--	if playerObj:getInventory():haveThisKeyId(vehicle:getKeyId()) or vehicle:isEngineRunning() then
	if playerObj:getVehicle() == vehicle then
		ISTimedActionQueue.add(ISLockDoors:new(playerObj, vehicle, lock))
	end
end

function ISVehiclePartMenu.onSmashWindow(playerObj, part, open)
	if playerObj:getVehicle() == part:getVehicle() then
	-- if in vehicle, must be in the seat
	else
		if playerObj:getVehicle() then
			ISVehicleMenu.onExit(playerObj)
		end
		ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
	end

	ISTimedActionQueue.add(ISSmashWindow:new(playerObj, part:getWindow(), part));
	--playerObj:smashCarWindow(part)
end

ISVehiclePartMenu.doSiphonFuelMenu = function(playerObj, part, context)
	local source = part:getVehicle()
	local playerNum = playerObj:getPlayerNum()
	local playerInv = playerObj:getInventory()
	local hose = playerObj:getInventory():getFirstTagRecurse("SiphonGas")
	local allContainers = {}
	local allContainerTypes = {}
	local allContainersOfType = {}
	local pourInto = playerInv:getAllEvalRecurse(function(item)
		-- our item can store fuel, but doesn't have fuel right now
		if item:getFluidContainer() and item:getFluidContainer():isEmpty() then
			return true
		end
		-- or our item can store fuel and is not full
		if item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) and item:getFluidContainer():getFreeCapacity() > 0 then
			return true
		end
		return false
	end)
	if pourInto:isEmpty() then
		return
	end
	local fillOption = context:addOption(getText("ContextMenu_VehicleSiphonGas"), worldobjects, nil);
	if not hose then
		fillOption.notAvailable = true;
		local tooltip = ISInventoryPaneContextMenu.addToolTip();
		tooltip.description = getText("ContextMenu_VehicleNeedHose");
		fillOption.toolTip = tooltip;	
		return false
	end
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
		containerOption = containerMenu:addOption(getText("ContextMenu_FillAll"), worldobjects, ISVehiclePartMenu.onTakeFuelNew, part, allContainers, nil, playerNum);
	end
	--add the fill container of type menu
	for _,containerType in pairs(allContainerTypes) do
		local destItem = containerType[1]
		if #containerType > 1 then --#containerType gets the length of the table.
			containerOption = containerMenu:addOption(destItem:getName() .. " (" .. #containerType ..")", worldobjects, nil);
			local containerTypeMenu = ISContextMenu:getNew(containerMenu)
			containerMenu:addSubMenu(containerOption, containerTypeMenu)
			local containerTypeOption
			containerTypeOption = containerTypeMenu:addOption(getText("ContextMenu_FillOne"), worldobjects, ISVehiclePartMenu.onTakeFuelNew, part, nil, destItem, playerNum);
			if containerType[2] ~= nil then
				containerTypeOption = containerTypeMenu:addOption(getText("ContextMenu_FillAll"), worldobjects, ISVehiclePartMenu.onTakeFuelNew, part, containerType, nil, playerNum);
			end
		else
			containerOption = containerMenu:addOption(destItem:getName(), worldobjects, ISVehiclePartMenu.onTakeFuelNew, part, nil, destItem, playerNum);
			if destItem:getFluidContainer() then
				local t = ISWorldObjectContextMenu.addToolTip()
				t.maxLineWidth = 512
				t.description = getText("ContextMenu_FuelCapacity") .. string.format("%s / %s", (math.floor(destItem:getFluidContainer():getFreeCapacity() * 1000) / 1000), (math.floor(destItem:getFluidContainer():getCapacity() * 1000) / 1000))
				containerOption.toolTip = t
			end
		end
	end
end

ISVehiclePartMenu.onTakeFuelNew = function(worldobjects, part, fuelContainerList, fuelContainer, player)
	local playerObj = getSpecificPlayer(player)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	if not fuelContainerList then
		fuelContainerList = {};
		table.insert(fuelContainerList, fuelContainer);
	end	
	ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
	for i,item in ipairs(fuelContainerList) do
		if item and part:getContainerContentAmount() > 0 then
			ISVehiclePartMenu.toPlayerInventory(playerObj, item)
			ISInventoryPaneContextMenu.equipWeapon(item, false, false, playerObj:getPlayerNum())
			ISTimedActionQueue.add(ISTakeGasolineFromVehicle:new(playerObj, part, item))
		end
	end
end

ISVehiclePartMenu.doAddFuelMenu = function(playerObj, part, context)
	local source = part:getVehicle()
	local playerNum = playerObj:getPlayerNum()
	local playerInv = playerObj:getInventory()
	local allContainers = {}
	local allContainerTypes = {}
	local allContainersOfType = {}
	local pourOut = playerInv:getAllEvalRecurse(function(item)
		-- or our item can store fuel and is not empty
		if item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) then
			return true
		end
		return false
	end)
	if pourOut:isEmpty() then
		return
	end
	local fillOption = context:addOption(getText("ContextMenu_VehicleAddGas"), worldobjects, nil);
	if not source:getSquare() or not AdjacentFreeTileFinder.Find(source:getSquare(), playerObj) then
		fillOption.notAvailable = true;
		--if the player can reach the tile, populate the submenu, otherwise don't bother
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
		containerOption = containerMenu:addOption(getText("ContextMenu_AddAll"), worldobjects, ISVehiclePartMenu.onAddFuelNew, part, allContainers, nil, playerNum);
	end
	--add the fill container of type menu
	for _,containerType in pairs(allContainerTypes) do
		local destItem = containerType[1]
		if #containerType > 1 then --#containerType gets the length of the table.
			containerOption = containerMenu:addOption(destItem:getName() .. " (" .. #containerType ..")", worldobjects, nil);
			local containerTypeMenu = ISContextMenu:getNew(containerMenu)
			containerMenu:addSubMenu(containerOption, containerTypeMenu)
			local containerTypeOption
			containerTypeOption = containerTypeMenu:addOption(getText("ContextMenu_AddOne"), worldobjects, ISVehiclePartMenu.onAddFuelNew, part, nil, destItem, playerNum);
			if containerType[2] ~= nil then
				containerTypeOption = containerTypeMenu:addOption(getText("ContextMenu_AddAll"), worldobjects, ISVehiclePartMenu.onAddFuelNew, part, containerType, nil, playerNum);
			end
		else
			containerOption = containerMenu:addOption(destItem:getName(), worldobjects, ISVehiclePartMenu.onAddFuelNew, part, nil, destItem, playerNum);
			if destItem:getFluidContainer() then
				local t = ISWorldObjectContextMenu.addToolTip()
				t.maxLineWidth = 512
				t.description = getText("ContextMenu_FuelCapacity") .. string.format("%s / %s", destItem:getFluidContainer():getFreeCapacity(), destItem:getFluidContainer():getCapacity())
				containerOption.toolTip = t
			end
		end
	end
end

ISVehiclePartMenu.onAddFuelNew = function(worldobjects, part, fuelContainerList, fuelContainer, player)
	local playerObj = getSpecificPlayer(player)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	if not fuelContainerList then
		fuelContainerList = {};
		table.insert(fuelContainerList, fuelContainer);
	end	
	ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
	for i,item in ipairs(fuelContainerList) do
		if item and part:getContainerContentAmount() < part:getContainerCapacity() then
			ISVehiclePartMenu.toPlayerInventory(playerObj, item)
			ISInventoryPaneContextMenu.equipWeapon(item, true, false, playerObj:getPlayerNum())
			ISTimedActionQueue.add(ISAddGasolineToVehicle:new(playerObj, part, item))
		end
	end
end
