--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

DebugContextMenu = {};
DebugContextMenu.staggerBacking = false;
DebugContextMenu.stagTime = 0;
DebugContextMenu.ticked = false;

local function removeDuplicates(list)
	local result = {}
	local seen = {}
	for _,item in ipairs(list) do
		if not seen[item] then
			seen[item] = true
			table.insert(result, item)
		end
	end
	return result
end

DebugContextMenu.doDebugMenu = function(player, context, worldobjects, test)
	if not isDebugEnabled() then return true; end
	if test and ISWorldObjectContextMenu.Test then return true end

	local square = nil;
	for i,v in ipairs(worldobjects) do
		square = v:getSquare();
		break;
	end

	for i=1,square:getObjects():size() do
		table.insert(worldobjects, square:getObjects():get(i-1))
	end
	worldobjects = removeDuplicates(worldobjects)

	if getCore():getGameMode()=="LastStand" then
		return;
	end

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	local building = square:getBuilding();
	--	if building then
	--		context:addOption("RBBASIC", building:getDef(), DebugContextMenu.doRandomizedBuilding, getWorld():getRBBasic());
	--	end

	--		for i = 0, getWorld():getRandomizedVehicleStoryList():size()-1 do
	--			local rvs = getWorld():getRandomizedVehicleStoryList():get(i);

	--	local rbOption = context:addOption("Remove All Vehicles on Zone", square:getZone(), DebugContextMenu.onRemoveVehicles);
	--	for i = 0, getWorld():getRandomizedVehicleStoryList():size()-1 do
	--		local rvs = getWorld():getRandomizedVehicleStoryList():get(i);
	--
	--		if rvs:getName() == "Basic Car Crash" then
	--			local rbOption = context:addOption("ADD BURNT CAR CRASHED", square, DebugContextMenu.doRandomizedVehicleStory, rvs);
	--			if not square:getZone() or not rvs:isValid(square:getZone(), square:getChunk(), true) then
	--				rbOption.notAvailable = true;
	--				local tooltip = ISWorldObjectContextMenu.addToolTip()
	--				tooltip:setName("Zone not valid");
	--				tooltip.description = rvs:getDebugLine();
	--				rbOption.toolTip = tooltip;
	--			end
	--			break;
	--		end
	--	end
	local debugOption1 = context:addDebugOption(getText("IGUI_DebugContext_Title"), worldobjects, nil);
	local debugMenu = ISContextMenu:getNew(context);
	context:addSubMenu(debugOption1, debugMenu);

	local mainOption = debugMenu:addDebugOption(getText("IGUI_DebugContext_Main"), worldobjects, nil);
	local mainMenu = ISContextMenu:getNew(debugMenu);
	debugMenu:addSubMenu(mainOption, mainMenu);

	mainMenu:addDebugOption(getText("IGUI_GameStats_Teleport"), playerObj, DebugContextMenu.onTeleportUI);
	mainMenu:addDebugOption(getText("IGUI_DebugContext_RemoveItemTool"), playerObj, DebugContextMenu.onRemoveItemTool)
	mainMenu:addDebugOption(getText("IGUI_DebugContext_SpawnVehicle"), playerObj, DebugContextMenu.onSpawnVehicle);
	mainMenu:addDebugOption(getText("IGUI_DebugContext_HordeManager"), square, DebugContextMenu.onHordeManager, playerObj);
	local text = getText("IGUI_DebugContext_PlayerModelHide");
	if not getCore():isDisplayPlayerModel() then
		text = getText("IGUI_DebugContext_PlayerModelShow");
	end
	mainMenu:addDebugOption(text, playerObj, DebugContextMenu.onShowPlayerModel);

	local text = getText("IGUI_DebugContext_CursorHide");
	if not getCore():isDisplayCursor() then
		text = getText("IGUI_DebugContext_CursorShow");
	end
	mainMenu:addDebugOption(text, playerObj, DebugContextMenu.onShowCursor);


	local uiOption = debugMenu:addDebugOption(getText("IGUI_DebugContext_UIs"), worldobjects, nil);
	local uiMenu = ISContextMenu:getNew(debugMenu);
	debugMenu:addSubMenu(uiOption, uiMenu);

	uiMenu:addOption(getText("IGUI_DebugContext_Missing3D"), nil, DebugContextMenu.do3DItem);
	uiMenu:addOption(getText("IGUI_DebugContext_MissingClothing"), nil, DebugContextMenu.doMissingClothingItems);
	uiMenu:addOption(getText("IGUI_DebugContext_MissingNonClothing"), nil, DebugContextMenu.doMissingItems);
	uiMenu:addOption(getText("IGUI_DebugContext_DebugInterpolation"), square, DebugContextMenu.onDebugInterpolationUI);
	uiMenu:addOption(getText("IGUI_DebugContext_DebugPlayer"), square, DebugContextMenu.onDebugPlayerInterpolationUI);
	uiMenu:addOption(getText("IGUI_DebugContext_TilePicker"), playerObj, DebugContextMenu.onTilesPicker);
	uiMenu:addOption(getText("IGUI_DebugContext_GenerateLootUI"), playerObj, DebugContextMenu.onGenerateLootUI);
	uiMenu:addOption(getText("IGUI_DebugContext_RunningUI"), playerObj, DebugContextMenu.onRunningUI);
	uiMenu:addOption(getText("IGUI_DebugContext_SpawnSurvivorHorde"), playerObj, DebugContextMenu.onSpawnSurvivorHorde);
	uiMenu:addOption(getText("IGUI_DebugContext_AttachedItems"), playerObj, DebugContextMenu.onAttachedItems);
	uiMenu:addOption(getText("IGUI_DebugContext_ExtendedAnimsList"), playerObj, DebugContextMenu.onExtList);

	local x = getMouseX()
	local y = getMouseY()
	local square,sqX,sqY,sqZ = DebugContextMenu.pickSquare(x, y)
	for dy=-1,1 do
		for dx=-1,1 do
			local l_square = getCell():getGridSquare(sqX+dx, sqY+dy, sqZ)
			if l_square then
				for i=1, l_square:getMovingObjects():size() do
					local obj = l_square:getMovingObjects():get(i - 1)
					if instanceof(obj, "IsoGameCharacter") then
						debugMenu:addDebugOption(string.format("Animation Text (%s)", obj:getClass():getSimpleName()), obj, DebugContextMenu.onShowAnimationText)
						if (obj:isAnimRecorderActive()) then
							context:addDebugOption(string.format("%s - Stop Anim Recording", obj:getClass():getSimpleName()), obj, DebugContextMenu.onSetAnimRecorderActive, false)
						else
							context:addDebugOption(string.format("%s - Start Anim Recording", obj:getClass():getSimpleName()), obj, DebugContextMenu.onSetAnimRecorderActive, true)
						end
						break
					end
				end
			end
		end
	end

	if square == nil then
		print("[DebugContextMenu][doDebugMenu] returned, square is null")
		return;
	end;

	if square:getBuilding() then
		DebugContextMenu.addRBDebugMenu(debugMenu, square:getBuilding());
		local def = square:getBuilding():getDef();
		local alarm = "(Off)";
		if def:isAlarmed() then
			alarm = "(On)";
		end
		uiMenu:addDebugOption("Set Alarm " .. alarm, def, DebugContextMenu.onSetAlarm);
	end

	if square:getZone() then
		DebugContextMenu.addRVSDebugMenu(mainMenu, square, playerObj);
	end

	DebugContextMenu.addRZSDebugMenu(mainMenu, square, playerObj);


	local noiseOption = mainMenu:addOption(getText("IGUI_DebugContext_MakeNoise"), worldobjects, nil);
	local noiseSubMenu = mainMenu:getNew(mainMenu);
	mainMenu:addSubMenu(noiseOption, noiseSubMenu);

	local noiseRadius = {10, 20, 50, 100, 200, 500}
	for _,r in ipairs(noiseRadius) do
		noiseSubMenu:addOption(getText("IGUI_DebugContext_Radius")..": " .. r, square, DebugContextMenu.onMakeNoise, playerObj, r, 100);
	end
	--DebugContextMenu.doCheatMenu(subMenu, playerObj);

	mainMenu:addDebugOption(getText("IGUI_DebugContext_SpawnPoints"), square, DebugContextMenu.onSpawnPoints, playerObj);

	DebugContextMenu.doDebugObjectMenu(player, debugMenu, worldobjects, test)
	DebugContextMenu.doDebugCorpseMenu(player, debugMenu, worldobjects, test)
	DebugContextMenu.doDebugZombieMenu(player, debugMenu, worldobjects, test, square)
	DebugContextMenu.doDebugAnimalMenu(playerObj, debugMenu, worldobjects, test, square)
	if isClient() then
		DebugContextMenu.doDebugPlayerMenu(playerObj, debugMenu, worldobjects)
		DebugContextMenu.doDebugVehicleMenu(playerObj, debugMenu, worldobjects)
	end
	DebugContextMenu.doSurvivorSwapMenu(player, debugMenu, worldobjects, test)

	DebugContextMenu.doForageMenu(player, debugMenu, worldobjects, test)
	--	if not DebugContextMenu.staggerBacking then
	--		subMenu:addOption("Start Stagger Back", playerObj, DebugContextMenu.stagger, true);
	--	else
	--		subMenu:addOption("Stop Stagger Back", playerObj, DebugContextMenu.stagger, false);
	--	end
end

function DebugContextMenu.onShowPlayerModel(playerObj)
	getCore():setDisplayPlayerModel(not getCore():isDisplayPlayerModel());
end

function DebugContextMenu.onShowCursor(playerObj)
	getCore():setDisplayCursor(not getCore():isDisplayCursor());
	Mouse.setCursorVisible(getCore():isDisplayCursor())
end

function DebugContextMenu.onAddDesignationZone(playerObj)
	local ui = ISDesignationZonePanel:new(50,50, 600, 800, playerObj);
	ui:initialise()
	ui:addToUIManager()
end

function DebugContextMenu.doDebugAnimalMenu(playerObj, context, worldobjects, test, square)
	local debugOption = context:addDebugOption(getText("IGUI_DebugContext_Animals"), worldobjects, nil);
	local subMenu = ISContextMenu:getNew(context);
	context:addSubMenu(debugOption, subMenu);

	--	subMenu:addOption("Designation Zone", playerObj, DebugContextMenu.onAddDesignationZone);
	if isClient() then
		subMenu:addOption(getText("IGUI_DebugContext_RemoveAll"), nil, DebugContextMenu.OnRemoveAllAnimalsClient)
	else
		subMenu:addOption(getText("IGUI_DebugContext_RemoveAll"), nil, DebugContextMenu.OnRemoveAllAnimals)
	end
	local text = getText("IGUI_DebugContext_AnimalCheatEnable");
	if AnimalContextMenu.cheat then
		text = getText("IGUI_DebugContext_AnimalCheatDisable");
	end
	subMenu:addOption(text, playerObj, DebugContextMenu.onToggleAnimalCheat);
	subMenu:addOption(getText("IGUI_DebugContext_AddEnclosure"), playerObj, DebugContextMenu.onAddEnclosure);
	subMenu:addOption(getText("IGUI_DebugContext_AvatarUI"), playerObj, DebugContextMenu.onAvatarUI);

	local groups = {};
	local animals = {};
	local defs = getAllAnimalsDefinitions();
	for i=0, defs:size()-1 do
		local def = defs:get(i);
		if not animals[def:getGroup()] then
			animals[def:getGroup()] = {};
			table.insert(groups, def:getGroup());
		end
		table.insert(animals[def:getGroup()], def);
	end

	table.sort(groups, function(a,b)
		local name1 = getText("IGUI_Animal_Group_" .. a)
		local name2 = getText("IGUI_Animal_Group_" .. b)
		return not string.sort(name1, name2)
	end)

	for _,group in ipairs(groups) do
		local animalOption = subMenu:addOption(getText("IGUI_Animal_Group_" .. group), nil, nil);
		local animalSubMenu = ISContextMenu:getNew(subMenu);
		subMenu:addSubMenu(animalOption, animalSubMenu);
		local defs = animals[group]
		for j, def in ipairs(defs) do
			local animalBreedOption = animalSubMenu:addOption("Add " .. getText("IGUI_AnimalType_" .. def:getAnimalType()), nil, nil);
			local animalBreedSubMenu = ISContextMenu:getNew(animalSubMenu);
			subMenu:addSubMenu(animalBreedOption, animalBreedSubMenu);
			local canBeSkeleton = def:canBeSkeleton();

			local breeds = def:getBreeds();
			for i=0,breeds:size()-1 do
				local breed = breeds:get(i);
				animalBreedSubMenu:addOption(getText("IGUI_Breed_" .. breed:getName()), def:getAnimalType(), DebugContextMenu.AddAnimal, breed, square, false, playerObj);
				-- add the skeleton version
				if canBeSkeleton and i == breeds:size()-1 then
					animalBreedSubMenu:addOption("Skeleton", def:getAnimalType(), DebugContextMenu.AddAnimal, breed, square, true, playerObj);
				end
			end
		end
	end
end

function DebugContextMenu.doDebugPlayerMenu(playerObj, context, worldobjects)
	local playerOption = context:addDebugOption(getText("IGUI_DebugContext_Players"), worldobjects, nil);
	local playerMenu = ISContextMenu:getNew(context);
	context:addSubMenu(playerOption, playerMenu);
	playerMenu:addDebugOption(getText("IGUI_GameStats_Teleport"), playerObj, DebugContextMenu.onTeleportUI);
	playerMenu:addDebugOption(getText("IGUI_DebugContext_TeleportPlayers"), playerObj, DebugContextMenu.onTeleportPlayers);
end

function DebugContextMenu.doDebugVehicleMenu(playerObj, context, worldobjects)
	local vehicleOption = context:addDebugOption(getText("IGUI_DebugContext_Vehicles"), worldobjects, nil);
	local vehicleMenu = ISContextMenu:getNew(context);
	context:addSubMenu(vehicleOption, vehicleMenu);
	vehicleMenu:addDebugOption(getText("IGUI_DebugContext_SpawnVehicle"), playerObj, DebugContextMenu.onSpawnVehicle);
	vehicleMenu:addDebugOption(getText("IGUI_DebugContext_AddVehicle"), playerObj, DebugContextMenu.onAddVehicle);
	local square = DebugContextMenu.pickSquare(getMouseX(), getMouseY())
	if square and square:getVehicleContainer() then
		vehicleMenu:addDebugOption(getText("IGUI_DebugContext_RemoveVehicle"), playerObj, DebugContextMenu.onRemoveVehicle, square:getVehicleContainer())
	end
	vehicleMenu:addDebugOption(getText("IGUI_DebugContext_RemoveAll"), playerObj, DebugContextMenu.onRemoveAllVehicles);
end

function DebugContextMenu.onToggleAnimalCheat()
	AnimalContextMenu.cheat = not AnimalContextMenu.cheat;
	getCore():setAnimalCheat(AnimalContextMenu.cheat);
end

function DebugContextMenu.do3DItem()
	getCore():countMissing3DItems();
end

function DebugContextMenu.doMissingClothingItems()
	getCore():debugOutputMissingCLothingSpawn();
end

function DebugContextMenu.doMissingItems()
	getCore():debugOutputMissingItemSpawn();
end

function DebugContextMenu.onGenerateLootUI(playerObj)
	local ui = ISLootStreetTestUI:new(0, 0, playerObj);
	ui:initialise();
	ui:addToUIManager();
end

function DebugContextMenu.stagger(player, stag)
	DebugContextMenu.staggerBacking = stag;
	if stag and not DebugContextMenu.ticked then
		DebugContextMenu.ticked = true;
		Events.OnTick.Add(DebugContextMenu.onTick);
	end
end

function DebugContextMenu.doDebugObjectMenu(player, context, worldobjects, test)
	local x = getMouseX()
	local y = getMouseY()

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	local debugOption = context:addDebugOption(getText("IGUI_DebugContext_Objects"), worldobjects, nil);
	local subMenu = ISContextMenu:getNew(context);
	context:addSubMenu(debugOption, subMenu);

	local sq = getSpecificPlayer(player):getCurrentSquare()
	if sq and sq:getBuilding() then
		if test then return ISWorldObjectContextMenu.setTest() end
		subMenu:addOption(getText("IGUI_DebugContext_GetBuildingKey"), worldobjects, DebugContextMenu.OnGetBuildingKey, player)
	end

	local window = IsoObjectPicker.Instance:PickWindow(x, y)
	if instanceof(window, "IsoWindow") then
		if test then return ISWorldObjectContextMenu.setTest() end
		subMenu:addOption(window:isLocked() and "Window Unlock" or "Window Lock", worldobjects, DebugContextMenu.OnWindowLock, window)
		subMenu:addOption(window:isPermaLocked() and "Window Perm Unlock" or "Window Perm Lock", worldobjects, DebugContextMenu.OnWindowPermLock, window)
		subMenu:addOption("Window ~Smashed", worldobjects, DebugContextMenu.OnWindowSmash, window)
		subMenu:addOption("Window ~GlassRemoved", worldobjects, DebugContextMenu.OnWindowGlassRemoved, window)
		local barricade = window:getBarricadeForCharacter(playerObj)
		if (barricade == nil) then
			subMenu:addOption("Window Barricade +Metal Bars", playerObj, DebugContextMenu.OnWindowAddMetalBar, window)
			subMenu:addOption("Window Barricade +Metal Panel", playerObj, DebugContextMenu.OnWindowAddMetal, window)
		end
		if (barricade ~= nil) and (barricade:isMetalBar()) then
			subMenu:addOption("Window Barricade -Metal Bars", playerObj, DebugContextMenu.OnWindowRemoveMetalBar, window)
		end
		if (barricade ~= nil) and (barricade:isMetal()) then
			subMenu:addOption("Window Barricade -Metal Panel", playerObj, DebugContextMenu.OnWindowRemoveMetal, window)
		end
		if (barricade == nil) or ((not barricade:isMetal()) and (not barricade:isMetalBar()) and (barricade:getNumPlanks() < 4)) then
			subMenu:addOption("Window Barricade +Plank", playerObj, DebugContextMenu.OnWindowAddPlank, window)
		end
		if (barricade ~= nil) and (barricade:getNumPlanks() > 0) then
			subMenu:addOption("Window Barricade -Plank", playerObj, DebugContextMenu.OnWindowRemovePlank, window)
		end
	end

	local windowFrame = IsoObjectPicker.Instance:PickWindowFrame(x, y)
	if instanceof(windowFrame, "IsoWindowFrame") and not windowFrame:hasWindow() then
		if test then return ISWorldObjectContextMenu.setTest() end
		local barricade = windowFrame:getBarricadeForCharacter(playerObj)
		if barricade == nil then
			if windowFrame:isBarricadeAllowed() then -- no sheet rope present
				subMenu:addOption("WindowFrame Barricade +Metal Bars", playerObj, DebugContextMenu.OnWindowAddMetalBar, windowFrame)
				subMenu:addOption("WindowFrame Barricade +Metal Panel", playerObj, DebugContextMenu.OnWindowAddMetal, windowFrame)
				subMenu:addOption("WindowFrame Barricade +Plank", playerObj, DebugContextMenu.OnWindowAddPlank, windowFrame)
			end
		else
			if barricade:canAddPlank() then
				subMenu:addOption("WindowFrame Barricade +Plank", playerObj, DebugContextMenu.OnWindowAddPlank, windowFrame)
			end
			if barricade:isMetalBar() then
				subMenu:addOption("WindowFrame Barricade -Metal Bars", playerObj, DebugContextMenu.OnWindowRemoveMetalBar, windowFrame)
			elseif barricade:isMetal() then
				subMenu:addOption("WindowFrame Barricade -Metal Panel", playerObj, DebugContextMenu.OnWindowRemoveMetal, windowFrame)
			elseif barricade:getNumPlanks() > 0 then -- must be true
				subMenu:addOption("WindowFrame Barricade -Plank", playerObj, DebugContextMenu.OnWindowRemovePlank, windowFrame)
			end
		end
	end

	local rainBarrel = nil

	for _,obj in ipairs(worldobjects) do
		if instanceof(obj, "IsoDoor") or (instanceof(obj, "IsoThumpable") and obj:isDoor()) then
			subMenu:addOption("Get Door Key", worldobjects, DebugContextMenu.OnGetDoorKey, obj, player)
			subMenu:addOption(obj:isLocked() and "Door Unlock" or "Door Lock", worldobjects, DebugContextMenu.OnDoorLock, obj)
			subMenu:addOption(string.format("Set Door Key ID (%d)", obj:getKeyId()), worldobjects, DebugContextMenu.OnSetDoorKeyID, obj)
			subMenu:addOption("Set Door Building Key ID", worldobjects, DebugContextMenu.OnSetDoorKeyIDBuilding, obj)
			subMenu:addOption("Set Door Random Key ID", worldobjects, DebugContextMenu.OnSetDoorKeyIDRandom, obj)
			subMenu:addOption(string.format("Set force lock (%s)", tostring(not obj:getModData().CustomLock)), worldobjects, DebugContextMenu.setForceLockDoor, obj, player)
		end
		if instanceof(obj, "IsoGenerator") then
			subMenu:addOption("Generator: Set Fuel", obj, DebugContextMenu.OnGeneratorSetFuel)
		end
		if instanceof(obj, "IsoBarbecue") then
			subMenu:addOption("BBQ: Zero Fuel", obj, DebugContextMenu.OnBBQZeroFuel)
			subMenu:addOption("BBQ: Set Fuel", obj, DebugContextMenu.OnBBQSetFuel)
		end
		if instanceof(obj, "IsoFireplace") then
			subMenu:addOption("Fireplace: Zero Fuel", obj, DebugContextMenu.OnFireplaceZeroFuel)
			subMenu:addOption("Fireplace: Set Fuel", obj, DebugContextMenu.OnFireplaceSetFuel)
		end
		if instanceof(obj, "IsoMannequin") then
			local scriptOption = subMenu:addOption("Mannequin: Set Script", nil)
			local scriptMenu = ISContextMenu:getNew(subMenu)
			context:addSubMenu(scriptOption, scriptMenu)
			local scripts = getScriptManager():getAllMannequinScripts()
			for i=1,scripts:size() do
				local script = scripts:get(i-1)
				scriptMenu:addOption(script:getName(), obj, DebugContextMenu.OnMannequinSetScript, script)
			end
			----
			scriptOption = subMenu:addOption("Mannequin: Create Item", nil)
			scriptMenu = ISContextMenu:getNew(subMenu)
			context:addSubMenu(scriptOption, scriptMenu)
			for i=1,scripts:size() do
				local script = scripts:get(i-1)
				scriptMenu:addOption(script:getName(), script, DebugContextMenu.OnMannequinCreateItem)
			end
		end
		if CCampfireSystem.instance:isValidIsoObject(obj) then
			subMenu:addOption("Campfire: Zero Fuel", obj, DebugContextMenu.OnCampfireZeroFuel)
			subMenu:addOption("Campfire: Set Fuel", obj, DebugContextMenu.OnCampfireSetFuel)
		end
	end

	local square = DebugContextMenu.pickSquare(x, y)
	if square then
		for i=1,square:getObjects():size() do
			local obj = square:getObjects():get(i-1)
			if BentFences.getInstance():isBentObject(obj) then
				subMenu:addOption("Un-bend Fence", worldobjects, DebugContextMenu.OnUnbendFence, obj)
				subMenu:addOption("Reset Fence", worldobjects, DebugContextMenu.OnResetFence, obj)
			end
			if BentFences.getInstance():isUnbentObject(obj) then
				subMenu:addOption("Bend Fence", worldobjects, DebugContextMenu.OnBendFence, obj)
				subMenu:addOption("Bend Fence Towards Player", worldobjects, DebugContextMenu.OnBendFence, obj, true)
			end
			if BrokenFences.getInstance():isBreakableObject(obj) then
				subMenu:addOption("Break Fence", worldobjects, DebugContextMenu.OnBreakFence, obj)
			end
			if instanceof(obj, "IsoCompost") then
				subMenu:addOption("Set Compost", worldobjects, DebugContextMenu.OnSetCompost, obj)
			end
		end
	end

	if #subMenu.options == 0 then
		context:removeLastOption()
	end
end

function DebugContextMenu.doDebugCorpseMenu(player, context, worldobjects, test)
	local x = getMouseX()
	local y = getMouseY()

	local body = IsoObjectPicker.Instance:PickCorpse(x, y)
	if not body then return end

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	if test then return ISWorldObjectContextMenu.setTest() end

	local option = context:addDebugOption("DeadBody", worldobjects, nil);
	local subMenu = ISContextMenu:getNew(context);
	context:addSubMenu(option, subMenu);

	if body:isAnimal() then
		local text = "Reanimate (Animal)"
		subMenu:addOption(text, body, DebugContextMenu.OnReanimateCorpse)
		subMenu:addOption("Remove", body, DebugContextMenu.OnDeadBodyRemove)
		return
	end

	local text = body:isFakeDead() and "Reanimate (Zombie)" or "Reanimate (Player)"
	subMenu:addOption(text, body, DebugContextMenu.OnReanimateCorpse)

	option = subMenu:addOption("~Crawling", body, DebugContextMenu.OnDeadBodyToggleCrawling)
	subMenu:setOptionChecked(option, body:isCrawling())

	option = subMenu:addOption("~FakeDead", body, DebugContextMenu.OnDeadBodyToggleFakeDead)
	subMenu:setOptionChecked(option, body:isFakeDead())

	subMenu:addOption("Remove", body, DebugContextMenu.OnDeadBodyRemove)

	if #subMenu.options == 0 then
		context:removeLastOption()
	end
end

function DebugContextMenu.doDebugZombieMenu(player, context, worldobjects, test, square)
	local x = getMouseX()
	local y = getMouseY()
	local playerObj = getSpecificPlayer(player)

	local debugOption = context:addDebugOption(getText("IGUI_DebugContext_Zombies"), worldobjects, nil);
	local subMenu = ISContextMenu:getNew(context);
	context:addSubMenu(debugOption, subMenu);

	if isClient() then
		subMenu:addOption(getText("IGUI_DebugContext_RemoveAll"), nil, DebugContextMenu.OnRemoveAllZombiesClient)
		subMenu:addOption("Add Zombie", player, DebugContextMenu.OnAddZombieClient, player)
        subMenu:addOption("Horde Manager", square, AdminContextMenu.onHordeManager, playerObj)
	else
        subMenu:addOption("Horde Manager", square, AdminContextMenu.onHordeManager, playerObj)
		subMenu:addOption(getText("IGUI_DebugContext_RemoveAll"), nil, DebugContextMenu.OnRemoveAllZombies)
	end

	local square,sqX,sqY,sqZ = DebugContextMenu.pickSquare(x, y)
	if square then
		for i=1,square:getMovingObjects():size() do
			local obj = square:getMovingObjects():get(i - 1)
			if instanceof(obj, "IsoZombie") then
				subMenu:addOption("Select Zombie", obj, DebugContextMenu.OnSelectZombie)
				subMenu:addOption("Set On Fire", obj, DebugContextMenu.OnSetZombieOnFire)
				break
			end
		end
		if DebugContextMenu.selectedZombie and DebugContextMenu.selectedZombie:getCurrentSquare() == nil then
			DebugContextMenu.selectedZombie = nil
		end
		if DebugContextMenu.selectedZombie then
			local option
			subMenu:addOption("Selected: Walk Here", square, DebugContextMenu.OnSelectedZombieWalk)

			option = subMenu:addOption("Selected: ~Crawling", nil, DebugContextMenu.OnSelectedZombieToggleCrawling)
			subMenu:setOptionChecked(option, DebugContextMenu.selectedZombie:isCrawling())

			option = subMenu:addOption("Selected: ~CanWalk", nil, DebugContextMenu.OnSelectedZombieToggleCanWalk)
			subMenu:setOptionChecked(option, DebugContextMenu.selectedZombie:isCanWalk())

			option = subMenu:addOption("Selected: ~CanCrawlUnderVehicle", nil, DebugContextMenu.OnSelectedZombieToggleCanCrawlUnderVehicle)
			subMenu:setOptionChecked(option, DebugContextMenu.selectedZombie:isCanCrawlUnderVehicle())

			option = subMenu:addOption("Selected: ~FakeDead", nil, DebugContextMenu.OnSelectedZombieToggleFakeDead)
			subMenu:setOptionChecked(option, DebugContextMenu.selectedZombie:isFakeDead())

			option = subMenu:addOption("Selected: Knock Backward", false, DebugContextMenu.OnSelectedZombieKnockDown)
			option = subMenu:addOption("Selected: Knock Forward", true, DebugContextMenu.OnSelectedZombieKnockDown)

			option = subMenu:addOption("Selected: ~Useless", nil, DebugContextMenu.OnSelectedZombieToggleUseless)
			subMenu:setOptionChecked(option, DebugContextMenu.selectedZombie:isUseless())
		end
	end
end

DebugContextMenu.onSetAnimRecorderActive = function(character, isActive)
	character:setAnimRecorderActive(isActive, true)
end

function DebugContextMenu.OnRemoveAllZombies(zombie)
	local zombies = getCell():getObjectList()
	for i=zombies:size(),1,-1 do
		local zombie = zombies:get(i-1)
		if instanceof(zombie, "IsoZombie") then
			zombie:removeFromWorld()
			zombie:removeFromSquare()
		end
	end
end

function DebugContextMenu.OnRemoveAllZombiesClient(zombie)
	SendCommandToServer(string.format("/removezombies -remove true"))
end

function DebugContextMenu.OnRemoveAllAnimals(zombie)
	local animals = getCell():getObjectList()
	for i=animals:size(),1,-1 do
		local animal = animals:get(i-1)
		if instanceof(animal, "IsoAnimal") then
			animal:remove()
		end
	end
end

function DebugContextMenu.OnRemoveAllAnimalsClient(zombie)
	SendCommandToServer(string.format("/remove animals"))
end

function DebugContextMenu.OnAddZombieClient(player)
	local p = getSpecificPlayer(player)
	SendCommandToServer(string.format("/createhorde2 -x %d -y %d -z %d -count %d -radius %d -crawler %s -isFallOnFront %s -isFakeDead %s -knockedDown %s -health %s -outfit %s",
			math.floor(p:getX()), math.floor(p:getY()), math.floor(p:getZ()), 1, 1, "false", "false", "false", "false", "1", ""));
end

function DebugContextMenu.OnSelectZombie(zombie)
	DebugContextMenu.selectedZombie = zombie
end

function DebugContextMenu.OnSelectedZombieWalk(square)
	DebugContextMenu.selectedZombie:pathToLocation(square:getX(), square:getY(), square:getZ())
	if not square:TreatAsSolidFloor() and square:getZ() == DebugContextMenu.selectedZombie:getSquare():getZ() then
		DebugContextMenu.selectedZombie:setVariable("bPathfind", false)
		DebugContextMenu.selectedZombie:setVariable("bMoving", true)
	end
end

function DebugContextMenu.OnSelectedZombieToggleCrawling()
	DebugContextMenu.selectedZombie:toggleCrawling()
end

function DebugContextMenu.OnSelectedZombieToggleCanWalk()
	local zombie = DebugContextMenu.selectedZombie
	zombie:setCanWalk(not zombie:isCanWalk())
end

function DebugContextMenu.OnSelectedZombieToggleCanCrawlUnderVehicle()
	local zombie = DebugContextMenu.selectedZombie
	zombie:setCanCrawlUnderVehicle(not zombie:isCanCrawlUnderVehicle())
end

function DebugContextMenu.OnSelectedZombieToggleFakeDead()
	local zombie = DebugContextMenu.selectedZombie
	zombie:setFakeDead(not zombie:isFakeDead())
end

function DebugContextMenu.OnSelectedZombieKnockDown(hitFromBehind)
	local zombie = DebugContextMenu.selectedZombie
	zombie:knockDown(hitFromBehind)
end

function DebugContextMenu.OnSelectedZombieToggleUseless()
	local zombie = DebugContextMenu.selectedZombie
	zombie:setUseless(not zombie:isUseless())
end

function DebugContextMenu.OnSetZombieOnFire(zombie)
	zombie:SetOnFire()
end

function DebugContextMenu.OnReanimateCorpse(body)
	body:reanimateNow()
end

function DebugContextMenu.OnDeadBodyToggleCrawling(body)
	body:setCrawling(not body:isCrawling())
end

function DebugContextMenu.OnDeadBodyToggleFakeDead(body)
	body:setFakeDead(not body:isFakeDead())
end

function DebugContextMenu.OnDeadBodyRemove(body)
	body:getSquare():removeCorpse(body, false)

end

function DebugContextMenu.OnGetBuildingKey(worldobjects, player)
	if isClient() then
		sendClientCommand(getSpecificPlayer(player), 'debugAction', 'getBuildingKey', {})
		return
	end

	local sq = getSpecificPlayer(player):getCurrentSquare()
	if sq and sq:getBuilding() then
		if isClient() then
			SendCommandToServer("/addkey \"" .. getSpecificPlayer(player):getDisplayName() .. "\" \"" .. luautils.trim(tostring(keyID)) .. "\" \""..luautils.trim(tostring(ItemPickerJava.KeyNamer.getName(sq))).."\"")
		else
			local key = instanceItem("Base.Key1")
			key:setKeyId(sq:getBuilding():getDef():getKeyId())
			ItemPickerJava.keyNamerBuilding(key, sq)
			getSpecificPlayer(player):getInventory():AddItem(key)
		end
	end
end

function DebugContextMenu.OnGetDoorKey(worldobjects, door, player)
	if isClient() then
		local args = { x = door:getX(), y = door:getY(), z = door:getZ(), index = door:getObjectIndex() }
		sendClientCommand(getSpecificPlayer(player), 'debugAction', 'getDoorKey', args)
		return
	end

	local keyID = -1
	if instanceof(door, "IsoDoor") then
		keyID = door:checkKeyId()
	elseif instanceof(door, "IsoThumpable") then
		keyID = door:getKeyId()
	end

	if keyID == -1 then
		keyID = ZombRand(100000000)
	end
	door:setKeyId(keyID)

	local doubleDoorObjects = buildUtil.getDoubleDoorObjects(door)
	for i=1,#doubleDoorObjects do
		local object = doubleDoorObjects[i]
		object:setKeyId(keyID)
	end

	local garageDoorObjects = buildUtil.getGarageDoorObjects(door)
	for i=1,#garageDoorObjects do
		local object = garageDoorObjects[i]
		object:setKeyId(keyID)
	end

	if isClient() then
		SendCommandToServer("/addkey \"" .. getSpecificPlayer(player):getDisplayName() .. "\" \"" .. luautils.trim(tostring(keyID)) .. "\"")
	else
		local item = instanceItem("Base.Key1")
		item:setKeyId(keyID)
		getSpecificPlayer(player):getInventory():AddItem(item);
	end
end

function DebugContextMenu.OnDoorLock(worldobjects, door)
	door:setIsLocked(not door:isLocked())
	if instanceof(door, "IsoDoor") and door:checkKeyId() ~= -1 then
		door:setLockedByKey(door:isLocked())
	end
	if instanceof(door, "IsoThumpable") and door:getKeyId() ~= -1 then
		door:setLockedByKey(door:isLocked())
	end
	getPlayer():getMapKnowledge():setKnownBlockedDoor(door, door:isLocked())

	local doubleDoorObjects = buildUtil.getDoubleDoorObjects(door)
	for i=1,#doubleDoorObjects do
		local object = doubleDoorObjects[i]
		object:setLockedByKey(door:isLocked())
	end

	local garageDoorObjects = buildUtil.getGarageDoorObjects(door)
	for i=1,#garageDoorObjects do
		local object = garageDoorObjects[i]
		object:setLockedByKey(door:isLocked())
	end
end

local function OnDoorSetKeyID2(target, button, obj)
	if button.internal == "OK" then
		local text = button.parent.entry:getText()
		local keyId = tonumber(text)
		if not keyId then return end
		obj:setKeyId(keyId)

		local doubleDoorObjects = buildUtil.getDoubleDoorObjects(obj)
		for i=1,#doubleDoorObjects do
			local object = doubleDoorObjects[i]
			object:setKeyId(keyId)
		end

		local garageDoorObjects = buildUtil.getGarageDoorObjects(obj)
		for i=1,#garageDoorObjects do
			local object = garageDoorObjects[i]
			object:setKeyId(keyId)
		end
	end
end

function DebugContextMenu.OnSetDoorKeyID(worldobjects, door)
	local modal = ISTextBox:new(0, 0, 280, 180, "Key ID:", tostring(door:getKeyId()), nil, OnDoorSetKeyID2, nil, door)
	modal:initialise()
	modal:addToUIManager()
end

function DebugContextMenu.OnSetDoorKeyIDBuilding(worldobjects, door)
	local sq = door:getSquare()
	local sq2 = door:getOppositeSquare()
	if sq == nil or sq2 == nil then return end
	local building = sq:getBuilding()
	local building2 = sq2:getBuilding()
	local bDef = nil
	local bDef2 = nil
	if building ~= nil then
		bDef = building:getDef()
	end
	if building2 ~= nil then
		bDef2 = building2:getDef()
	end
	if bDef ~= nil then
		door:setKeyId(bDef:getKeyId())
	elseif bDef2 ~= nil then
		door:setKeyId(bDef2:getKeyId())
	end
end

function DebugContextMenu.OnSetDoorKeyIDRandom(worldobjects, door)
	local keyId = ZombRand(100000000)
	door:setKeyId(keyId)

	local doubleDoorObjects = buildUtil.getDoubleDoorObjects(door)
	for i=1,#doubleDoorObjects do
		local object = doubleDoorObjects[i]
		object:setKeyId(keyId)
	end

	local garageDoorObjects = buildUtil.getGarageDoorObjects(door)
	for i=1,#garageDoorObjects do
		local object = garageDoorObjects[i]
		object:setKeyId(keyId)
	end
end

function DebugContextMenu.setForceLockDoor(worldobjects, door, player)
	if not door:getModData().CustomLock then
		door:getModData().CustomLock = true
	else
		door:getModData().CustomLock = false
	end
	door:transmitModData()
end

function DebugContextMenu.OnWindowLock(worldobjects, window)
	window:setIsLocked(not window:isLocked())
end

function DebugContextMenu.OnWindowPermLock(worldobjects, window)
	window:setPermaLocked(not window:isPermaLocked())
end

function DebugContextMenu.OnWindowSmash(worldobjects, window)
	window:setSmashed(not window:isSmashed())
end

function DebugContextMenu.OnWindowGlassRemoved(worldobjects, window)
	window:setGlassRemoved(not window:isGlassRemoved())
end

function DebugContextMenu.OnWindowAddMetal(playerObj, window)
	local barricade = IsoBarricade.AddBarricadeToObject(window, playerObj)
	barricade:addMetal(nil, nil)
end

function DebugContextMenu.OnWindowRemoveMetal(playerObj, window)
	local barricade = IsoBarricade.AddBarricadeToObject(window, playerObj)
	barricade:removeMetal(nil)
end

function DebugContextMenu.OnWindowAddMetalBar(playerObj, window)
	local barricade = IsoBarricade.AddBarricadeToObject(window, playerObj)
	barricade:addMetalBar(nil, nil)
end

function DebugContextMenu.OnWindowRemoveMetalBar(playerObj, window)
	local barricade = IsoBarricade.AddBarricadeToObject(window, playerObj)
	barricade:removeMetalBar(nil)
end

function DebugContextMenu.OnWindowAddPlank(playerObj, window)
	local barricade = IsoBarricade.AddBarricadeToObject(window, playerObj)
	barricade:addPlank(nil, nil)
end

function DebugContextMenu.OnWindowRemovePlank(playerObj, window)
	local barricade = IsoBarricade.AddBarricadeToObject(window, playerObj)
	barricade:removePlank(nil)
end

function DebugContextMenu.pickSquare(x, y)
	local zoom = getCore():getZoom(0)
	local z = getSpecificPlayer(0):getSquare():getZ()
	local worldX = IsoUtils.XToIso(x * zoom, y * zoom, z)
	local worldY = IsoUtils.YToIso(x * zoom, y * zoom, z)
	return getCell():getGridSquare(worldX, worldY, z), worldX, worldY, z
end

function DebugContextMenu.OnBendFence(worldobjects, fence, towards)
	local playerObj = getSpecificPlayer(0)
	local props = fence:getProperties()
	local dir = nil
	if props:Is(IsoFlagType.collideN) and props:Is(IsoFlagType.collideW) then
		dir = (playerObj:getY() >= fence:getY()) and IsoDirections.N or IsoDirections.S
	elseif props:Is(IsoFlagType.collideN) then
		dir = (playerObj:getY() >= fence:getY()) and IsoDirections.N or IsoDirections.S
	else
		dir = (playerObj:getX() >= fence:getX()) and IsoDirections.W or IsoDirections.E
	end
	if towards then dir = IsoDirections.reverse(dir); end;
	BentFences.getInstance():bendFence(fence, dir)
end

function DebugContextMenu.OnUnbendFence(worldobjects, fence)
	BentFences.getInstance():unbendFence(fence)
end

function DebugContextMenu.OnResetFence(worldobjects, fence)
	BentFences.getInstance():resetFence(fence)
end

function DebugContextMenu.OnBreakFence(worldobjects, fence)
	local playerObj = getSpecificPlayer(0)
	local props = fence:getProperties()
	local dir = nil
	if props:Is(IsoFlagType.collideN) and props:Is(IsoFlagType.collideW) then
		dir = (playerObj:getY() >= fence:getY()) and IsoDirections.N or IsoDirections.S
	elseif props:Is(IsoFlagType.collideN) then
		dir = (playerObj:getY() >= fence:getY()) and IsoDirections.N or IsoDirections.S
	else
		dir = (playerObj:getX() >= fence:getX()) and IsoDirections.W or IsoDirections.E
	end
	fence:destroyFence(dir)
end

function DebugContextMenu.OnBBQZeroFuel(obj)
	local playerObj = getSpecificPlayer(0)
	local args = { x = obj:getX(), y = obj:getY(), z = obj:getZ(), fuelAmt = 0 }
	sendClientCommand(playerObj, 'bbq', 'setFuel', args)
end

local function OnBBQSetFuel2(target, button, obj)
	if button.internal == "OK" then
		local playerObj = getSpecificPlayer(0)
		local text = button.parent.entry:getText()
		if tonumber(text) then
			local fuelAmt = math.min(tonumber(text), 100.0)
			fuelAmt = math.max(fuelAmt, 0.0)
			local args = { x = obj:getX(), y = obj:getY(), z = obj:getZ(), fuelAmt = fuelAmt }
			sendClientCommand(playerObj, 'bbq', 'setFuel', args)
		end
	end
end

function DebugContextMenu.OnBBQSetFuel(obj)
	local modal = ISTextBox:new(0, 0, 280, 180, "Fuel (Minutes):", tostring(obj:getFuelAmount()), nil, OnBBQSetFuel2, nil, obj)
	modal:initialise()
	modal:addToUIManager()
end

function DebugContextMenu.OnCampfireZeroFuel(obj)
	local playerObj = getSpecificPlayer(0)
	local args = { x = obj:getX(), y = obj:getY(), z = obj:getZ(), fuelAmt = 0 }
	CCampfireSystem.instance:sendCommand(playerObj, 'setFuel', args)
end

local function OnCampfireSetFuel2(target, button, obj)
	if button.internal == "OK" then
		local playerObj = getSpecificPlayer(0)
		local text = button.parent.entry:getText()
		if tonumber(text) then
			local fuelAmt = math.min(tonumber(text), 100.0)
			fuelAmt = math.max(fuelAmt, 0.0)
			local args = { x = obj:getX(), y = obj:getY(), z = obj:getZ(), fuelAmt = fuelAmt }
			CCampfireSystem.instance:sendCommand(playerObj, 'setFuel', args)
		end
	end
end

function DebugContextMenu.OnCampfireSetFuel(obj)
	local luaObject = CCampfireSystem.instance:getLuaObjectOnSquare(obj:getSquare())
	if not luaObject then return end
	local modal = ISTextBox:new(0, 0, 280, 180, "Fuel (Minutes):", tostring(luaObject.fuelAmt), nil, OnCampfireSetFuel2, nil, obj)
	modal:initialise()
	modal:addToUIManager()
end

function DebugContextMenu.OnFireplaceZeroFuel(obj)
	local playerObj = getSpecificPlayer(0)
	local args = { x = obj:getX(), y = obj:getY(), z = obj:getZ(), fuelAmt = 0 }
	sendClientCommand(playerObj, 'fireplace', 'setFuel', args)
end

local function OnFireplaceSetFuel2(target, button, obj)
	if button.internal == "OK" then
		local playerObj = getSpecificPlayer(0)
		local text = button.parent.entry:getText()
		if tonumber(text) then
			local fuelAmt = math.min(tonumber(text), 100.0)
			fuelAmt = math.max(fuelAmt, 0.0)
			local args = { x = obj:getX(), y = obj:getY(), z = obj:getZ(), fuelAmt = fuelAmt }
			sendClientCommand(playerObj, 'fireplace', 'setFuel', args)
		end
	end
end

function DebugContextMenu.OnFireplaceSetFuel(obj)
	local modal = ISTextBox:new(0, 0, 280, 180, "Fuel (Minutes):", tostring(obj:getFuelAmount()), nil, OnFireplaceSetFuel2, nil, obj)
	modal:initialise()
	modal:addToUIManager()
end


local function OnSetCompost2(target, button, obj)
	if button.internal == "OK" then
		local text = button.parent.entry:getText()
		if tonumber(text) then
			local compost = math.min(tonumber(text), 100.0)
			compost = math.max(compost, 0.0)
			obj:setCompost(compost)
		end
	end
end

function DebugContextMenu.OnSetCompost(worldobjects, obj)
	local modal = ISTextBox:new(0, 0, 280, 180, "Compost (0-100):", tostring(obj:getCompost()), nil, OnSetCompost2, nil, obj)
	modal:initialise()
	modal:addToUIManager()
end

local function OnGeneratorSetFuel2(target, button, obj)
	if button.internal == "OK" then
		local text = button.parent.entry:getText()
		if tonumber(text) then
			local compost = math.min(tonumber(text), obj:getMaxFuel())
			compost = math.max(compost, 0.0)
			obj:setFuel(compost)
		end
	end
end

function DebugContextMenu.OnGeneratorSetFuel(obj)
	local max = luautils.round(obj:getMaxFuel(), 2)
	local modal = ISTextBox:new(0, 0, 280, 180, "Fuel (0-".. max .. "):", tostring(obj:getFuel()), nil, OnGeneratorSetFuel2, nil, obj)
	modal:initialise()
	modal:addToUIManager()
end

function DebugContextMenu.OnMannequinSetScript(obj, script)
	obj:setMannequinScriptName(script:getName())
end

function DebugContextMenu.OnMannequinCreateItem(script)
	local spriteName = script:isFemale() and "location_shop_mall_01_65" or "location_shop_mall_01_68"
	local obj = IsoMannequin.new(getCell(), nil, getSprite(spriteName))
	obj:setMannequinScriptName(script:getName())
	local item = instanceItem("Moveables.Moveable")
	item:ReadFromWorldSprite(spriteName)
	obj:setCustomSettingsToItem(item)
	getSpecificPlayer(0):getInventory():AddItem(item)
end

DebugContextMenu.onHordeManager = function(square, player)
	local ui = ISSpawnHordeUI:new(0, 0, player, square);
	ui:initialise();
	ui:addToUIManager();
end

DebugContextMenu.onSpawnPoints = function(square, player)
	local ui = ISSpawnPointsEditor:new()
	ui:initialise()
	ui:instantiate()
	ui:addToUIManager()
end

DebugContextMenu.doCheatMenu = function(context, playerObj)
	local cheatOption = context:addOption("Cheat", nil, nil);
	local cheatSubMenu = ISContextMenu:getNew(context)
	context:addSubMenu(cheatOption, cheatSubMenu)

	local text = "(Off)";
	if playerObj:isGhostMode() then
		text = "(On)";
	end
	cheatSubMenu:addOption("Set Invisible " .. text, playerObj, DebugContextMenu.onCheat, "INVISIBLE");
	text = "(Off)";
	if playerObj:isInvincible() then
		text = "(On)";
	end
	cheatSubMenu:addOption("Invincible " .. text, playerObj, DebugContextMenu.onCheat, "INVINCIBLE");
end

DebugContextMenu.onCheat = function(player, cheat)
	if cheat == "INVISIBLE" then
		player:setGhostMode(not player:isGhostMode());
	end
	if cheat == "INVINCIBLE" then
		player:setInvincible(not player:isInvincible());
	end
end

DebugContextMenu.onSetAlarm = function(def)
	def:setAlarmed(not def:isAlarmed());
end

DebugContextMenu.onMakeNoise = function(square, playerObj, radius, volume)
	addSound(playerObj, square:getX(), square:getY(), square:getZ(), radius, volume)
end

DebugContextMenu.onAttachedItems = function(playerObj)
	local ui = ISAttachedItemsUI:new(0, 0, playerObj);
	ui:initialise();
	ui:addToUIManager();
end

DebugContextMenu.onTeleportUI = function(playerObj)
	local ui = ISTeleportDebugUI:new(0, 0, 300, 200, playerObj, nil, DebugContextMenu.onTeleportValid);
	ui:initialise();
	ui:addToUIManager();
end

DebugContextMenu.onTeleportPlayers = function(playerObj)
	teleportPlayers(playerObj)
end

DebugContextMenu.onRemoveItemTool = function(playerObj)
	local ui = ISRemoveItemTool:new(0, 0, playerObj);
	ui:initialise();
	ui:addToUIManager();
end

DebugContextMenu.onSpawnVehicle = function(playerObj)
	local ui = ISSpawnVehicleUI:new(0, 0, 200, 300, playerObj);
	ui:initialise();
	ui:addToUIManager();
end

DebugContextMenu.onRemoveAllVehicles = function(playerObj)
	removeAllVehicles(playerObj)
end

DebugContextMenu.onRemoveVehicle = function(playerObj, vehicle)
	removeVehicle(playerObj, vehicle)
end

DebugContextMenu.onAddVehicle = function(playerObj)
	addVehicle(getScriptManager():getRandomVehicleScript():getName(), playerObj:getX(), playerObj:getY(), playerObj:getZ())
end

DebugContextMenu.onTilesPicker = function(playerObj)
	local ui = ISTilesPickerDebugUI:new(0, 0, playerObj);
	ui:initialise();
	ui:addToUIManager();
end

DebugContextMenu.onTeleportValid = function(button, x, y, z)
	if isClient() then
		SendCommandToServer("/teleportto " .. x .. "," .. y .. "," .. z);
	else
	    getPlayer():teleportTo(tonumber(x), tonumber(y), tonumber(z))
	end
end

DebugContextMenu.onExtList = function(playerObj)
	local ui = ISExtAnimListDebugUI:new(0, 0, playerObj);
	ui:initialise();
	ui:addToUIManager();
end

DebugContextMenu.onShowAnimationText = function(chr)
	local ui = ISDebugAnimationTextUI:new(0, 0, 350, 200, chr)
	ui:initialise()
	ui:addToUIManager()
end

DebugContextMenu.onDebugInterpolationUI = function(square)
	local zombie = square:getZombie()
	if zombie ~= nil then
		InterpolationPeriodDebug.OnOpenPanel(zombie)
	end
end

DebugContextMenu.onDebugPlayerInterpolationUI = function(square)
	local player = square:getPlayer()
	if player ~= nil then
		InterpolationPlayerPeriodDebug.OnOpenPanel(player)
	end
end

DebugContextMenu.onRunningUI = function(playerObj)
	local ui = ISRunningDebugUI:new(0, 0, playerObj);
	ui:initialise();
	ui:addToUIManager();
end

DebugContextMenu.onSpawnSurvivorHorde = function(playerObj)
	playerObj:getCurrentSquare():getChunk():addSurvivorInHorde(true);
end

DebugContextMenu.addRVSDebugMenu = function(context, square, playerObj)
	if isClient() and not playerObj:getRole():hasCapability(Capability.CreateStory) then
		return;
	end
	local mainOption = context:addOption(getText("IGUI_DebugContext_RandomizedRoadStory"), nil, nil);
	local mainSubMenu = ISContextMenu:getNew(context)
	context:addSubMenu(mainOption, mainSubMenu)

	local rbOption = mainSubMenu:addOption(getText("IGUI_DebugContext_RemoveVehicles"), square:getZone(), DebugContextMenu.onRemoveVehicles);

	for i = 0, getWorld():getRandomizedVehicleStoryList():size()-1 do
		local rvs = getWorld():getRandomizedVehicleStoryList():get(i);

		local rbOption = mainSubMenu:addOption(rvs:getName(), square, DebugContextMenu.doRandomizedVehicleStory, rvs);
		local zones = getWorld():getMetaGrid():getZonesAt(square:getX(), square:getY(), square:getZ());
		local valid = false;
		for j=0,zones:size()-1 do
			local zone = zones:get(j);
			if (zone:getType() == "Nav") and rvs:isValid(zone, square:getChunk(), true) then
				valid = true;
				break;
			end
		end
		if not valid then
			rbOption.notAvailable = true;
			local tooltip = ISWorldObjectContextMenu.addToolTip()
			tooltip:setName("Zone not valid");
			tooltip.description = rvs:getDebugLine();
			rbOption.toolTip = tooltip;
		end
	end
end

DebugContextMenu.addRZSDebugMenu = function(context, square, playerObj)
	if isClient() and not playerObj:getRole():hasCapability(Capability.CreateStory) then
		return;
	end
    -- Fixed for using the debug zone spawning story on fences inappropriately
    if square:hasFenceInVicinity()  then
	    local mainOption = context:addOption(getText("IGUI_DebugContext_RandomizedZoneStoryFenceVicinity"), nil, nil);
        mainOption.notAvailable = true;
	    return;
    end
	local mainOption = context:addOption(getText("IGUI_DebugContext_RandomizedZoneStory"), nil, nil);
	local mainSubMenu = ISContextMenu:getNew(context)
	context:addSubMenu(mainOption, mainSubMenu)

	for i = 0, getWorld():getRandomizedZoneList():size()-1 do
		local rzs = getWorld():getRandomizedZoneList():get(i);

		local rbOption = mainSubMenu:addOption(rzs:getName(), square, DebugContextMenu.doRandomizedZoneStory, rzs);
		if not rzs:isValid() then
			rbOption.notAvailable = true;
			local tooltip = ISWorldObjectContextMenu.addToolTip()
			tooltip:setName("Zone not valid");
			tooltip.description = rzs:getDebugLine();
			rbOption.toolTip = tooltip;
		end
	end
end

DebugContextMenu.onRemoveVehicles = function(zone)
	RandomizedVehicleStoryBase.removeAllVehiclesOnZone(zone);
end

DebugContextMenu.doRandomizedZoneStory = function(square, rzs)
	if isClient() then
		sendDebugStory(square, 1, rzs:getName())
	else
		local zone = Zone.new("debugstoryzone", "debugstoryzone", square:getX() - 20, square:getY() - 20, square:getZ(), square:getX() + 20, square:getX() + 20);
		zone:setPickedXForZoneStory(square:getX())
		zone:setPickedYForZoneStory(square:getY())
		zone:setX(square:getX() - (rzs:getMinimumWidth() / 2));
		zone:setY(square:getY() - (rzs:getMinimumHeight() / 2));
		zone:setW(rzs:getMinimumWidth() + 2);
		zone:setH(rzs:getMinimumHeight() + 2);
		rzs:randomizeZoneStory(zone);
	end
end

DebugContextMenu.doRandomizedVehicleStory = function(square, rvs)
	if isClient() then
		sendDebugStory(square, 0, rvs:getName())
	else
		rvs:randomizeVehicleStory(square:getZone(), square:getChunk());
	end
end

DebugContextMenu.addRBDebugMenu = function(context, building)
	local RBBasic = getWorld():getRBBasic();

	local mainOption = context:addOption("Randomized Building", nil, nil);
	local mainSubMenu = ISContextMenu:getNew(context)
	context:addSubMenu(mainOption, mainSubMenu)

	-- Do survivor stories
	local survivorStoriesOption = mainSubMenu:addOption("Survivor Stories", nil, nil);
	local survivorStoriesSubMenu = ISContextMenu:getNew(mainSubMenu)
	mainSubMenu:addSubMenu(survivorStoriesOption, survivorStoriesSubMenu)

	for i=0,RBBasic:getSurvivorStories():size()-1 do
		if RBBasic:getSurvivorStories():get(i):getName() then
			local storyOption = survivorStoriesSubMenu:addOption(RBBasic:getSurvivorStories():get(i):getName(), building:getDef(), DebugContextMenu.doRandomizedBuilding, RBBasic:getSurvivorStories():get(i));
			if not RBBasic:getSurvivorStories():get(i):isValid(building:getDef(), true) then
				storyOption.notAvailable = true;
				local tooltip = ISWorldObjectContextMenu.addToolTip()
				tooltip:setName("Building not valid");
				tooltip.description = RBBasic:getSurvivorStories():get(i):getDebugLine();
				storyOption.toolTip = tooltip;
			end
		end
	end

	-- Profession (spawn container with profession-related stuff)
	local professionOption = mainSubMenu:addOption("Profession", nil, nil);
	local professionSubMenu = ISContextMenu:getNew(mainSubMenu)
	mainSubMenu:addSubMenu(professionOption, professionSubMenu)
	for i=0, RBBasic:getSurvivorProfession():size()-1 do
		professionSubMenu:addOption(RBBasic:getSurvivorProfession():get(i), building:getDef(), DebugContextMenu.doRandomizedBuilding, RBBasic:getSurvivorProfession():get(i));
	end

	mainSubMenu:addOption("Basic Randomized Building (including table stories)", building:getDef(), DebugContextMenu.doRandomizedBuilding, getWorld():getRBBasic());

	-- now do randomized building stories (ignore RBBasic as it's done on top)
	for i = 0, getWorld():getRandomizedBuildingList():size()-1 do
		local rb = getWorld():getRandomizedBuildingList():get(i);
		if not instanceof(rb, "RBBasic") and rb and rb:getName() then
			local name = rb:getName() or "NAME NOT FOUND";
			local rbOption = mainSubMenu:addOption(name, building:getDef(), DebugContextMenu.doRandomizedBuilding, rb);
			if not rb:isValid(building:getDef(), true) then
				rbOption.notAvailable = true;
				local tooltip = ISWorldObjectContextMenu.addToolTip()
				tooltip:setName("Building not valid");
				tooltip.description = RBBasic:getSurvivorStories():get(i):getDebugLine();
				rbOption.toolTip = tooltip;
			end
		end
	end
end

DebugContextMenu.doRandomizedBuilding = function(building, RBdef)
	if instanceof(RBdef, "RandomizedDeadSurvivorBase") then
		local RBBasic = getWorld():getRBBasic();
		RBBasic:doRandomDeadSurvivorStory(building, RBdef);
	elseif instanceof(RBdef, "RandomizedBuildingBase") then
		RBdef:randomizeBuilding(building);
	else
		local RBBasic = getWorld():getRBBasic();
		RBBasic:doProfessionStory(building, RBdef);
	end
end

DebugContextMenu.doSurvivorSwapMenu = function(player, context, worldobjects, test)
	--if not SurvivorSwap then return end
	if not SurvivorSwap or (table.isempty(SurvivorSwap.Survivors) and table.isempty(SurvivorSwap.Loadouts)) then return end
	local playerObj = getSpecificPlayer(player)
	local menu = ISContextMenu:getNew(context)
	context:addSubMenu(context:addOption("Survivor Swap"), menu)

	local submenu = ISContextMenu:getNew(menu)
	context:addSubMenu(menu:addOption("Survivors (replaces current)"), submenu)
	for id, data in pairs(SurvivorSwap.Survivors) do
		submenu:addOption(id, playerObj, SurvivorSwap.applyCharacter, data)
	end

	submenu = ISContextMenu:getNew(menu)
	context:addSubMenu(menu:addOption("Inventory (replaces current)"), submenu)
	for id, data in pairs(SurvivorSwap.Loadouts) do
		submenu:addOption(id, playerObj, SurvivorSwap.applyLoadout, data)
	end
end

DebugContextMenu.onTick = function()
	if DebugContextMenu.staggerBacking then
		DebugContextMenu.stagTime = DebugContextMenu.stagTime - 1;
		if DebugContextMenu.stagTime < 0 then
			local chr = IsoPlayer.getInstance();
			DebugContextMenu.stagTime = 300;
			chr:setBumpType("stagger");
			chr:setVariable("BumpDone", false);
			chr:setVariable("BumpFall", true);
			chr:setVariable("BumpFallType", "pushedFront");
		end
	end
end

DebugContextMenu.doForageMenu = function(player, context, worldobjects, test)
	local character = getSpecificPlayer(player);
	local manager = ISSearchManager.getManager(character);
	local clickedX = screenToIsoX(player, context.x, context.y, character:getZ());
	local clickedY = screenToIsoY(player, context.x, context.y, character:getZ());
	local square = getCell():getGridSquare(clickedX, clickedY, character:getZ());
	ISSearchManager.createDebugContextMenu(player, context, manager, square)
end

DebugContextMenu.onTick = function()
	if DebugContextMenu.staggerBacking then
		DebugContextMenu.stagTime = DebugContextMenu.stagTime - 1;
		if DebugContextMenu.stagTime < 0 then
			local chr = IsoPlayer.getInstance();
			DebugContextMenu.stagTime = 300;
			chr:setBumpType("stagger");
			chr:setVariable("BumpDone", false);
			chr:setVariable("BumpFall", true);
			chr:setVariable("BumpFallType", "pushedFront");
		end
	end
end

function DebugContextMenu.onAvatarUI(player)
	local ui = ISDebugAvatarUI:new(player);
	ui:initialise();
	ui:addToUIManager();
end

function DebugContextMenu.onAddEnclosure(playerObj)
	local size = 10;
	DesignationZoneAnimal.new("NewZone", playerObj:getCurrentSquare():getX() - size, playerObj:getCurrentSquare():getY() - size,playerObj:getCurrentSquare():getZ(),playerObj:getCurrentSquare():getX() + size,playerObj:getCurrentSquare():getY() + size)

	for x=playerObj:getCurrentSquare():getX()-9, playerObj:getCurrentSquare():getX()-4 do
		for y=playerObj:getCurrentSquare():getY()-9, playerObj:getCurrentSquare():getY()-4 do
			if (x == playerObj:getCurrentSquare():getX()-4 and y == playerObj:getCurrentSquare():getY()-4) or (x == playerObj:getCurrentSquare():getX()-9 and y == playerObj:getCurrentSquare():getY()-9) or (x == playerObj:getCurrentSquare():getX()-9 and y == playerObj:getCurrentSquare():getY()-4) or (x == playerObj:getCurrentSquare():getX()-4 and y == playerObj:getCurrentSquare():getY()-9) then
				local sq = getSquare(x, y, 0);
				local obj = IsoObject.getNew(sq, "walls_exterior_wooden_01_27", nil, false);
				sq:AddTileObject(obj);
			end
			local sq =  IsoGridSquare.new(getCell(), nil, x, y, 1);
			getCell():ConnectNewSquare(sq, false);
			sq:addFloor("carpentry_02_56");
		end
	end

	for x=playerObj:getCurrentSquare():getX() - size, playerObj:getCurrentSquare():getX()+(size-1) do
		local sq = getSquare(x, playerObj:getCurrentSquare():getY() - size, playerObj:getCurrentSquare():getZ());
		local fence = IsoThumpable.new(getCell(), sq, "carpentry_02_41", false, ISSimpleFurniture:new("Fence", "carpentry_02_41", "carpentry_02_41"));
		sq:AddTileObject(fence);
		sq = getSquare(x, playerObj:getCurrentSquare():getY() + size, playerObj:getCurrentSquare():getZ());
		local fence = IsoThumpable.new(getCell(), sq, "carpentry_02_41", false, ISSimpleFurniture:new("Fence", "carpentry_02_41", "carpentry_02_41"));
		sq:AddTileObject(fence);
	end
	for y=playerObj:getCurrentSquare():getY() - size, playerObj:getCurrentSquare():getY()+(size-1) do
		local sq = getSquare(playerObj:getCurrentSquare():getX() - size, y, playerObj:getCurrentSquare():getZ());

		local fence = IsoThumpable.new(getCell(), sq, "carpentry_02_40", false, ISSimpleFurniture:new("Fence", "carpentry_02_40", "carpentry_02_40"));
		sq:AddTileObject(fence);

		local sq = getSquare(playerObj:getCurrentSquare():getX() + size, y, playerObj:getCurrentSquare():getZ());
		local fence = IsoThumpable.new(getCell(), sq, "carpentry_02_40", false, ISSimpleFurniture:new("Fence", "carpentry_02_40", "carpentry_02_40"));
		sq:AddTileObject(fence);

	end

	--local sq = getSquare(playerObj:getCurrentSquare():getX() - 3, playerObj:getCurrentSquare():getY() + 2, playerObj:getCurrentSquare():getZ())
	--local trough = IsoFeedingTrough.new(sq, "location_farm_accesories_01_14", nil)
	--local def = FeedingTroughDef["simple"];
	--trough:setName("FeedingTrough")
	--trough:setMaxWater(def.maxWater)
	--trough:setDef(def);
	--sq:AddSpecialObject(trough)
	--trough:transmitCompleteItemToClients()
	--trough:updateLuaObject();
	--ISFeedingTroughMenu.onAddFoodDebug(nil, trough);
	--
	--local sq = getSquare(playerObj:getCurrentSquare():getX() - 3, playerObj:getCurrentSquare():getY(), playerObj:getCurrentSquare():getZ())
	--local trough = IsoFeedingTrough.new(sq, "location_farm_accesories_01_14", nil)
	--local def = FeedingTroughDef["simple"];
	--trough:setName("FeedingTrough")
	--trough:setMaxWater(def.maxWater)
	--trough:setDef(def);
	--sq:AddSpecialObject(trough)
	--trough:transmitCompleteItemToClients()
	--trough:updateLuaObject();
	--ISFeedingTroughMenu.onAddWaterDebug(nil, trough);
end

function DebugContextMenu.AddAnimal(type, breed, square, skeleton, playerObj)
	if isClient() then
		sendClientCommandV(playerObj, "animal", "add",
				"type", type,
				"breed", breed:getName(),
				"x", square:getX(),
				"y", square:getY(),
				"z", square:getZ(),
				"skeleton", skeleton)
	else
		local animal = addAnimal(getCell(),
				getPlayer():getCurrentSquare():getX(),
				getPlayer():getCurrentSquare():getY(),
				getPlayer():getCurrentSquare():getZ(),
				type,
				breed,
				skeleton)
		animal:addToWorld()
	end
end

Events.OnFillWorldObjectContextMenu.Add(DebugContextMenu.doDebugMenu);
