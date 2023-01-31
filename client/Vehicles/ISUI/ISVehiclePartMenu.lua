--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISVehiclePartMenu = {}

local function predicatePetrol(item)
	return (item:hasTag("Petrol") or item:getType() == "PetrolCan") and item:getUsedDelta() > 0
end

local function predicateEmptyPetrol(item)
	return item:hasTag("EmptyPetrol") or item:getType() == "EmptyPetrolCan"
end

local function predicatePetrolNotFull(item)
	return (item:hasTag("Petrol") or item:getType() == "PetrolCan") and item:getUsedDelta() < 1 
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
		-- local usedDelta = 1.1
		local drainableUses = - 1
        for j=1,allPetrol:size() do
            local item = allPetrol:get(j-1)
			-- if item:getUsedDelta() > 0 and item:getUsedDelta() < usedDelta then
			if item:getUsedDelta() > 0 and ( drainableUses == -1 or ( item:getDrainableUsesInt() > drainableUses ) ) then
				gasCan = item
				-- usedDelta = gasCan:getUsedDelta()
				drainableUses = gasCan:getDrainableUsesInt()
			end
		end
		if gasCan then return gasCan end
	end
	return nil
end

function ISVehiclePartMenu.getGasCanNotFull(playerObj, typeToItem)
	-- Prefer an equipped EmptyPetrolCan/PetrolCan, then the fullest PetrolCan, then any EmptyPetrolCan.
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
		local drainableUses = -1
		for j=1,allPetrol:size() do
			local item = allPetrol:get(j-1)
			-- if item:getUsedDelta() > usedDelta then
			if item:getDrainableUsesInt() > drainableUses then
				gasCan = item
				-- usedDelta = gasCan:getUsedDelta()
				drainableUses = gasCan:getDrainableUsesInt()
			end
		end
		if gasCan then return gasCan end
	end
	if inv:containsEvalRecurse(predicateEmptyPetrol) then
		return inv:getFirstEvalRecurse(predicateEmptyPetrol)
	end
	return nil
end

function ISVehiclePartMenu.toPlayerInventory(playerObj, item)
	if item and item:getContainer() and item:getContainer() ~= playerObj:getInventory() then
		local action = ISInventoryTransferAction:new(playerObj, item, item:getContainer(), playerObj:getInventory())
		ISTimedActionQueue.add(action)
	end
end

function ISVehiclePartMenu.transferRequiredItems(playerObj, part, tbl)
	if tbl and tbl.items then
		local typeToItem = VehicleUtils.getItems(playerObj:getPlayerNum())
		for _,item in pairs(tbl.items) do
			-- FIXME: handle drainables
			for i=1,tonumber(item.count) do
				ISVehiclePartMenu.toPlayerInventory(playerObj, typeToItem[item.type][i])
			end
		end
	end
end

function ISVehiclePartMenu.equipRequiredItems(playerObj, part, tbl)
	if tbl and tbl.items then
		for _,item in pairs(tbl.items) do
			local module,type = VehicleUtils.split(item.type, "\\.")
			type = type or item.type -- in case item.type has no '.'
			if item.equip == "primary" then
				ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), type, true)
			elseif item.equip == "secondary" then
				ISWorldObjectContextMenu.equip(playerObj, playerObj:getSecondaryHandItem(), type, false)
			elseif item.equip == "both" then
				ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), type, false, true)
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
		ISTimedActionQueue.add(ISInstallVehiclePart:new(playerObj, part, item, time))
		ISTimedActionQueue.add(ISCloseVehicleDoor:new(playerObj, part:getVehicle(), engineCover))
	else
		ISTimedActionQueue.add(ISInstallVehiclePart:new(playerObj, part, item, time))
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
			ISTimedActionQueue.add(ISRefuelFromGasPump:new(playerObj, part, fuelStation, 100))
		end
	end
end

function ISVehiclePartMenu.onPumpGasolinePathFail(playerObj)
	playerObj:Say(getText("IGUI_PlayerText_NoWayToFuelTankInlet"));
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
		ISTimedActionQueue.add(ISAddGasolineToVehicle:new(playerObj, part, item, 50))
	end
end

function ISVehiclePartMenu.onTakeGasoline(playerObj, part)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	local typeToItem = VehicleUtils.getItems(playerObj:getPlayerNum()) --BleachEmpty
	-- kludge to get the biggest empty vanilla containers first
	local item = playerObj:getInventory():getFirstTypeRecurse("Base.EmptyPetrolCan") or playerObj:getInventory():getFirstTypeRecurse("Base.BleachEmpty")	
	--if not item then item = ISVehiclePartMenu.getGasCanNotEmpty(playerObj, typeToItem) or ISVehiclePartMenu.getGasCanNotFull(playerObj, typeToItem) end	
	if not item then item = ISVehiclePartMenu.getGasCanNotFull(playerObj, typeToItem) end
	if item then
		ISVehiclePartMenu.toPlayerInventory(playerObj, item)
		ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
		ISInventoryPaneContextMenu.equipWeapon(item, false, false, playerObj:getPlayerNum())
		ISTimedActionQueue.add(ISTakeGasolineFromVehicle:new(playerObj, part, item, 50))
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
	local maxTime = math.ceil(psiTarget - part:getContainerContentAmount()) * 100
	ISTimedActionQueue.add(ISInflateTire:new(playerObj, part, pump, psiTarget, maxTime))
end

function ISVehiclePartMenu.onDeflateTire(playerObj, part)
	if playerObj:getVehicle() then
		ISVehicleMenu.onExit(playerObj)
	end
	-- TODO: choose desired tire pressure (underinflated - recommended - max)
	ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
	ISTimedActionQueue.add(ISDeflateTire:new(playerObj, part, 0, (part:getContainerContentAmount() - 0) * 50))
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
	ISTimedActionQueue.add(ISOpenCloseVehicleWindow:new(playerObj, part, open, 50))
end


function ISVehiclePartMenu.onLockDoors(playerObj, vehicle, lock)
--	if playerObj:getInventory():haveThisKeyId(vehicle:getKeyId()) or vehicle:isEngineRunning() then
	if playerObj:getVehicle() == vehicle then
		ISTimedActionQueue.add(ISLockDoors:new(playerObj, vehicle, lock, 10))
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

	ISTimedActionQueue.add(ISSmashVehicleWindow:new(playerObj, part))
end

ISVehiclePartMenu.doSiphonFuelMenu = function(playerObj, part, context)
	local source = part:getVehicle()
	local playerNum = playerObj:getPlayerNum()
	local playerInv = playerObj:getInventory()
	local allContainers = {}
	local allContainerTypes = {}
	local allContainersOfType = {}
	local pourInto = playerInv:getAllEvalRecurse(function(item)
		-- our item can store fue, but doesn't have fuel right now
		if item:hasTag("EmptyPetrol") and not item:isBroken() then
			return true
		end
		-- or our item can store fuel and is not full
		if item:hasTag("Petrol") and not item:isBroken() and instanceof(item, "DrainableComboItem") and item:getUsedDelta() < 1 then
			return true
		end
		return false
	end)
	if pourInto:isEmpty() then
		return
	end
	local fillOption = context:addOption(getText("ContextMenu_VehicleSiphonGas"), worldobjects, nil);
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
			if instanceof(destItem, "DrainableComboItem") then
				local t = ISWorldObjectContextMenu.addToolTip()
				t.maxLineWidth = 512
				local unitsPerCan = math.floor(1 / destItem:getUseDelta() + 0.001)
				local JerryCanLitres = Vehicles.JerryCanLitres * (unitsPerCan / 8)
				t.description = getText("ContextMenu_FuelCapacity") .. string.format("%s / %s", round(destItem:getUsedDelta() * JerryCanLitres, 3), round(JerryCanLitres, 3))
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
			ISTimedActionQueue.add(ISTakeGasolineFromVehicle:new(playerObj, part, item, 50))
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
		if item:hasTag("Petrol") and not item:isBroken() and instanceof(item, "DrainableComboItem") and item:getUsedDelta() > 0 then
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
			if instanceof(destItem, "DrainableComboItem") then
				local t = ISWorldObjectContextMenu.addToolTip()
				t.maxLineWidth = 512
				local unitsPerCan = math.floor(1 / destItem:getUseDelta() + 0.001)
				local JerryCanLitres = Vehicles.JerryCanLitres * (unitsPerCan / 8)
				t.description = getText("ContextMenu_FuelCapacity") .. string.format("%s / %s", round(destItem:getUsedDelta() * JerryCanLitres, 3), round(JerryCanLitres, 3))
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
			ISTimedActionQueue.add(ISAddGasolineToVehicle:new(playerObj, part, item, 50))			
		end
	end
end
