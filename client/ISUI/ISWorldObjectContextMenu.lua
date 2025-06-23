ISWorldObjectContextMenu = {}
ISWorldObjectContextMenu.fetchVars = {}
ISWorldObjectContextMenu.fetchSquares = {}
ISWorldObjectContextMenu.tooltipPool = {}
ISWorldObjectContextMenu.tooltipsUsed = {}

ISWorldObjectContextMenu.useJavaFetchLogic = true;
ISWorldObjectContextMenu.useJavaCreateMenuLogic = true;

local function predicateBleach(item)
	if not item then return false end
	return item:hasComponent(ComponentType.FluidContainer) and	item:getFluidContainer():contains(Fluid.Bleach) and (item:getFluidContainer():getAmount() >= ZomboidGlobals.CleanBloodBleachAmount)
end

local function predicateCleaningLiquid(item)
	if not item then return false end
	return item:hasComponent(ComponentType.FluidContainer) and (item:getFluidContainer():contains(Fluid.Bleach) or item:getFluidContainer():contains(Fluid.CleaningLiquid)) and (item:getFluidContainer():getAmount() >= ZomboidGlobals.CleanBloodBleachAmount)
end

local function predicatePetrolHalfLitre(item)
	return item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) and (item:getFluidContainer():getAmount() >= 0.5)
end

local function predicatePetrol(item)
	return item:getFluidContainer() and item:getFluidContainer():contains(Fluid.Petrol) and (item:getFluidContainer():getAmount() >= 0.099)
end

local function predicateEmptyPetrol(item)
	return item:hasTag("Petrol") and item:hasComponent(ComponentType.FluidContainer) and item:getFluidContainer():isEmpty()
end

local function predicatePetrolNotFull(item)
	return item:hasTag("Petrol") and item:hasComponent(ComponentType.FluidContainer) and (item:getFluidContainer():getAmount() < item:getFluidContainer():getCapacity())
end

local function predicateStoreFuel(item)
	local fluidContainer = item:getFluidContainer()
	if not fluidContainer then return false end
	-- our item can store fluids and is empty
	if fluidContainer:isEmpty() then --and not item:isBroken()
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

local function predicateUseRemaining(item)
	return item:getCurrentUses() > 0
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

local function predicateDigGrave(item)
    return not item:isBroken() and item:hasTag("DigGrave")
end

local function predicateScythe(item)
	return not item:isBroken() and item:hasTag("Scythe")
end

local function predicatePickDung(item)
	return not item:isBroken() and item:hasTag("TakeDung")
end

local function predicateFishingLure(item)
	return item:isFishingLure()
end

local function predicatePickAxe(item)
	return not item:isBroken() and item:hasTag("PickAxe")
end

local function predicateHammer(item)
	return not item:isBroken() and item:hasTag("Hammer")
end

local function predicateSledgehammer(item)
	return not item:isBroken() and item:hasTag("Sledgehammer")
end

local function predicateClubhammer(item)
	return not item:isBroken() and item:hasTag("ClubHammer")
end

local function predicateHammerOrPickAxe(item)
	return not item:isBroken() and (item:hasTag("Hammer") or item:hasTag("Sledgehammer") or item:hasTag("ClubHammer") or item:hasTag("PickAxe"))
end

local function predicateMaulOrPickAxe(item)
	return not item:isBroken() and (item:hasTag("Maul") or item:hasTag("StoneMaul") or item:hasTag("Sledgehammer") or item:hasTag("ClubHammer") or item:hasTag("PickAxe"))
end

local function predicateFishingRodOrSpear(item, playerObj)
	if item:isBroken() then return false end
	if not item:hasTag("FishingRod") and not item:hasTag("FishingSpear") then return false end
	return ISWorldObjectContextMenu.getFishingLure(playerObj, item)
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

local function isPuddleOrRiver(object)
	if not object or not object:getSprite() then return false end
	if not object:hasWater() then return false end
	return object:getSprite():getProperties():Is(IsoFlagType.solidfloor)
end

ISWorldObjectContextMenu.fetch = function(v, player, doSquare)
	local fetch = ISWorldObjectContextMenu.fetchVars

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	local props = v:getSprite() and v:getSprite():getProperties() or nil
	
	if doSquare then
		if v:getSquare() then
			local worldItems = v:getSquare():getWorldObjects();
			if worldItems and not worldItems:isEmpty() then
				fetch.worldItem = worldItems:get(0);
			end
		end
		if v:getSquare() then
			fetch.building = v:getSquare():getBuilding();
		end		
	end
	
	if v:hasFluid() then -- v:hasWater() then
		if not luautils.tableContains(fetch.storeWater, v) then
			table.insert(fetch.storeWater, #fetch.storeWater+1, v);
		end
	end
	fetch.c = fetch.c + 1;
	if instanceof(v, "IsoWindow") then
		fetch.window = v;
	elseif instanceof(v, "IsoCurtain") then
		fetch.curtain = v;
	end
	if instanceof(v, "IsoDoor") or (instanceof(v, "IsoThumpable") and v:isDoor()) then
		fetch.door = v;
        if instanceof(v, "IsoDoor") then
            fetch.doorKeyId = v:checkKeyId()
            if fetch.doorKeyId == -1 then fetch.doorKeyId = nil end
        end
        if instanceof(v, "IsoThumpable") then
           if v:getKeyId() ~= -1 then
                fetch.doorKeyId = v:getKeyId();
           end
        end
	end
	if instanceof(v, "IsoAnimalTrack") then
		fetch.animaltrack = v;
	end
	if doSquare then
		local animalTrack = v:getSquare():getAnimalTrack();
		if animalTrack then
			fetch.animaltrack = v:getSquare():getAnimalTrack();
		end
	end
	if instanceof(v, "IsoObject") then
		fetch.item = v;
		if v:getProperties() ~= nil and (v:getProperties():Val("GroupName") == "Water" or v:getProperties():Val("GroupName") == "Empty Water") and v:getProperties():Val("CustomName") == "Dispenser" then
			fetch.waterdispenser = v
		end
	end
	if instanceof(v, "IsoButcherHook") then
		--if v:getSprite() and v:getSprite():getName() == "crafted_04_120" then
			fetch.butcherHook = v
		--end
	end
	if instanceof(v, "IsoObject") and v:getSprite() and v:getSprite():getName() then
		fetch.tilename = v:getSprite():getName()
		if v:getContainer() and v:getContainer():getType() then
            fetch.tilename = fetch.tilename .. " / Container Report: " .. v:getContainer():getType()
        end
		fetch.tileObj = v
	end
	if instanceof(v, "IsoSurvivor") then
		fetch.survivor = v;
    end
    if instanceof(v, "IsoCompost") then
        fetch.compost = v;
    end
	if v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.HoppableN) then
		if not fetch.hoppableN then
			fetch.hoppableN = v;
		elseif fetch.hoppableN ~= v and fetch.hoppableN_2 ~= v then
			fetch.hoppableN_2 = v;
		end;
	end
	if v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.HoppableW) then
		if not fetch.hoppableW then
			fetch.hoppableW = v;
		elseif fetch.hoppableW ~= v and fetch.hoppableW_2 ~= v then
			fetch.hoppableW_2 = v;
		end;
	end
	if instanceof(v, "IsoThumpable") and not v:isDoor() then
		fetch.thump = v;
        if v:canBeLockByPadlock() and not v:isLockedByPadlock() and v:getLockedByCode() == 0 then
            fetch.padlockThump = v;
        end
        if v:isLockedByPadlock() then
            fetch.padlockedThump = v;
        end
        if v:getLockedByCode() > 0 then
            fetch.digitalPadlockedThump = v;
        end
		if v:isWindow() then
			fetch.thumpableWindow = v
		end
		if v:isWindowN() then
			if not fetch.thumpableWindowN then
				fetch.thumpableWindowN = v;
			elseif fetch.thumpableWindowN ~= v and fetch.thumpableWindowN_2 ~= v then
				fetch.thumpableWindowN_2 = v;
			end;
		end
		if v:isWindowW() then
			if not fetch.thumpableWindowW then
				fetch.thumpableWindowW = v;
			elseif fetch.thumpableWindowW ~= v and fetch.thumpableWindowW_2 ~= v then
				fetch.thumpableWindowW_2 = v;
			end;
		end
		if CRainBarrelSystem.instance:isValidIsoObject(v) then
			fetch.rainCollectorBarrel = v
		end
	end
	if instanceof(v, "IsoTree") then
		fetch.tree = v
	end
	if instanceof(v, "IsoTree") or (v:getProperties() and v:getProperties():Is("CanAttachAnimal")) then
		fetch.attachAnimalTo = v
	end
	if instanceof(v, "IsoClothingDryer") then
		fetch.clothingDryer = v
	end
	if instanceof(v, "IsoClothingWasher") then
		fetch.clothingWasher = v
	end
	if instanceof(v, "IsoCombinationWasherDryer") then
		fetch.comboWasherDryer = v
	end
    if instanceof(v, "IsoStove") and v:getContainer() then
		-- A burnt-out stove has no container.  FIXME: It would be better to remove the burnt stove object
        fetch.stove = v;
    end
	if instanceof(v, "IsoDeadBody") and not v:isAnimal() then
		if not fetch.body or (fetch.body:DistToSquared(playerObj) > v:DistToSquared(playerObj)) then
			fetch.body = v;
		end
	end
	if instanceof(v, "IsoDeadBody") and v:isAnimal() then
		fetch.animalbody = v;
	end
    if instanceof(v, "IsoCarBatteryCharger") then
        fetch.carBatteryCharger = v;
    end
    if instanceof(v, "IsoGenerator") then
        fetch.generator = v;
    end

	if doSquare then
		local deadBody = v:getSquare() and v:getSquare():getDeadBody();
		if deadBody and not fetch.body and deadBody:isAnimal() then
			fetch.body = deadBody;
		end
		if deadBody and not fetch.animalbody and deadBody:isAnimal() then
			fetch.animalbody = deadBody;
		end
	end
	if instanceof(v, "IsoObject") and v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.bed) then
		fetch.bed = v;
    end
    if instanceof(v, "IsoObject") and v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.makeWindowInvincible) then
        fetch.invincibleWindow = true;
    end
    if instanceof(v, "IsoWindowFrame") then
        fetch.windowFrame = v
    end
    if instanceof(v,"IsoBrokenGlass") then
        fetch.brokenGlass = v
    end
	if instanceof(v, "IsoTrap") then
		fetch.trap = v;
	end
	if v:getName() == "EmptyGraves" and not ISEmptyGraves.isGraveFilledIn(v) then
		fetch.graves = v;
	end
	if instanceof(v, "IsoLightSwitch") and v:getSquare() and (v:getSquare():getRoom() or v:getCanBeModified()) then
		fetch.lightSwitch = v
	end
	if doSquare then
		if v:getSquare() and (v:getSquare():getProperties():Is(IsoFlagType.HoppableW) or v:getSquare():getProperties():Is(IsoFlagType.HoppableN)) then
			fetch.canClimbThrough = true;
		end
	end
    local rod = ISWorldObjectContextMenu.getFishingRode(playerObj)
    if instanceof(v, "IsoObject") and v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.water) and v:getSquare():DistToProper(playerObj:getSquare()) < 20 and (not playerObj:isSitOnGround()) then
        fetch.canFish = true;
		if(v:getSquare():getWater() and v:getSquare():getWater():isShore()) then
			fetch.canFish = false;
		end
		if v:getSquare():DistToProper(playerObj:getSquare()) < 8 and ISWorldObjectContextMenu.getChum(playerObj):size() ~= 0 then
			fetch.canAddChum = true
		end
    end
	if doSquare then
		fetch.groundType = ISShovelGroundCursor.GetDirtGravelSand(v:getSquare())
		if fetch.groundType ~= nil then
			fetch.groundSquare = v:getSquare()
		end
	end
    local hasCuttingTool = playerInv:containsEvalRecurse(predicateCutPlant)
    if v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.canBeCut) and hasCuttingTool then
        fetch.canBeCut = v:getSquare();
    end
    if v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.canBeRemoved) then
        fetch.canBeRemoved = v:getSquare();
    end
    local attached = v:getAttachedAnimSprite()
    if hasCuttingTool and attached then
        for n=1,attached:size() do
            local sprite = attached:get(n-1)
--            if sprite and sprite:getParentSprite() and sprite:getParentSprite():getProperties():Is(IsoFlagType.canBeCut) then
            if sprite and sprite:getParentSprite() and sprite:getParentSprite():getName() and luautils.stringStarts(sprite:getParentSprite():getName(), "f_wallvines_") then
                fetch.wallVine = v:getSquare()
                break
            end
        end
    end
    if instanceof(v, "IsoObject") and v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.water) and playerInv:containsTypeRecurse("FishingNet") then
        fetch.canTrapFish = true;
    end
    if instanceof(v, "IsoObject") and v:getName() == "FishingNet" and v:getSquare() then
        fetch.trapFish = v;
    end

	if doSquare then
		if v:getSquare() and (v:getSquare():getProperties():Is(IsoFlagType.climbSheetN) or v:getSquare():getProperties():Is(IsoFlagType.climbSheetW) or
				v:getSquare():getProperties():Is(IsoFlagType.climbSheetS) or v:getSquare():getProperties():Is(IsoFlagType.climbSheetE)) then
			fetch.sheetRopeSquare = v:getSquare()
		end
		if FireFighting.getSquareToExtinguish(v:getSquare()) then
			fetch.extinguisher = FireFighting.getExtinguisher(playerObj);
			fetch.firetile = v:getSquare();
		end
		fetch.clickedSquare = v:getSquare();
	end
    if doSquare and playerInv:containsEvalRecurse(predicateClearAshes) and instanceof(v, "IsoObject") and v:getSprite() then
        local spriteName = v:getSprite():getName()
        if not spriteName then
            spriteName = v:getSpriteName()
        end
        if spriteName == 'floors_burnt_01_1' or spriteName == 'floors_burnt_01_2' then
            if not fetch.ashes or (fetch.ashes:getTargetAlpha() <= v:getTargetAlpha()) then
                fetch.ashes = v
            end
        end
	end
	if doSquare then
		local sledgehammer = playerInv:getFirstTypeEvalRecurse("Sledgehammer", predicateNotBroken)
		if not sledgehammer then
			sledgehammer = playerInv:getFirstTypeEvalRecurse("Sledgehammer2", predicateNotBroken)
		end
		if sledgehammer and sledgehammer:getCondition() > 0 and instanceof(v, "IsoObject") and v:getSprite() and v:getSprite():getProperties() and
			(v:getSprite():getProperties():Is(IsoFlagType.solidtrans) or v:getSprite():getProperties():Is(IsoFlagType.collideW) or
			v:getSprite():getProperties():Is(IsoFlagType.collideN) or v:getSprite():getProperties():Is(IsoFlagType.bed) or
			instanceof(v, "IsoThumpable") or v:getSprite():getProperties():Is(IsoFlagType.windowN) or v:getSprite():getProperties():Is(IsoFlagType.windowW)
			or v:getType() == IsoObjectType.stairsBN or v:getType() == IsoObjectType.stairsMN or v:getType() == IsoObjectType.stairsTN
			or v:getType() == IsoObjectType.stairsBW or v:getType() == IsoObjectType.stairsMW or v:getType() == IsoObjectType.stairsTW
			or ((v:getProperties():Is("DoorWallN") or v:getProperties():Is("DoorWallW")) and not v:getSquare():haveDoor()) or v:getSprite():getProperties():Is(IsoFlagType.waterPiped)) then
			if not (v:getSprite():getName() and luautils.stringStarts(v:getSprite():getName(), 'blends_natural_02') and luautils.stringStarts(v:getSprite():getName(), 'floors_burnt_01_')) then -- don't destroy water tiles and ashes
				if not fetch.destroy or (fetch.destroy:getTargetAlpha() <= v:getTargetAlpha()) then
					fetch.destroy = v
				end
			end
		end
		if ISWorldObjectContextMenu.canCleanBlood(playerObj, v:getSquare()) then
			fetch.haveBlood = v:getSquare();
		end
		if ISWorldObjectContextMenu.canCleanGraffiti(playerObj, v:getSquare()) then
			fetch.haveGraffiti = v:getSquare();
		end
	end
    if instanceof(v, "IsoPlayer") and (v ~= playerObj) then
        fetch.clickedPlayer = v;
    end
	if instanceof(v, "IsoAnimal") then
		if luautils.tableContains(fetch.clickedAnimals, v) == false then
			table.insert(fetch.clickedAnimals, v);
		end
	end

	if v:getPipedFuelAmount() > 0 and playerInv:containsEvalRecurse(predicateStoreFuel) then
		fetch.haveFuel = v;
	end
	if v:getPipedFuelAmount() > 0  then
		fetch.haveFuelDebug = v;
	end

    if v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is("fuelAmount") then
        fetch.fuelPump = v;
    end
	
	if v:hasComponent(ComponentType.FluidContainer) then
		if not luautils.tableContains(fetch.fluidcontainer, v) then
			table.insert(fetch.fluidcontainer, #fetch.fluidcontainer+1, v);
		end
	end
	if spriteName == 'carpentry_02_60' or spriteName == 'carpentry_02_61' or spriteName == 'carpentry_02_62' or spriteName == 'carpentry_02_59' then
        fetch.thumpableLightSource = v;
    end
	if instanceof(v, "IsoThumpable") and v:getLightSourceRadius() > 0 then
		fetch.thumpableLightSource = v;
	end

--	if v:getSquare():getProperties():Is("fuelAmount") and tonumber(v:getSquare():getProperties():Val("fuelAmount")) > 0 then
--		if playerInv:containsTypeRecurse("PetrolCanEmpty") or playerInv:containsTypeEvalRecurse("PetrolCan", predicateNotFull) then
--			fetch.haveFuel = v;
--		end
--	end

    -- safehouse
	if doSquare then
		fetch.safehouse = SafeHouse.getSafeHouse(v:getSquare());
		fetch.safehouseAllowInteract = SafeHouse.isSafehouseAllowInteract(v:getSquare(), playerObj);
		fetch.safehouseAllowLoot = SafeHouse.isSafehouseAllowLoot(v:getSquare(), playerObj);
	end

	local preWaterShutoff = getGameTime():getWorldAgeHours() / 24 + (getSandboxOptions():getTimeSinceApo() - 1) * 30 < getSandboxOptions():getOptionByName("WaterShutModifier"):getValue();

	if v:hasModData() and v:getModData().canBeWaterPiped and v:getSquare() and v:getSquare():isInARoom() and v:FindExternalWaterSource() then
		fetch.canBeWaterPiped = v;
	end

	if props and props:Is(IsoFlagType.waterPiped)
		and	(not v:getUsesExternalWaterSource())
		and	v:getSquare()
		and
				((v:getSquare():isInARoom() and v:FindExternalWaterSource())
			or	(v:getSquare():getRoom() and preWaterShutoff and v:hasModData() and v:getModData().canBeWaterPiped))
	then
		fetch.canBeWaterPiped = v;
	end

	-- pickaxing stumps, picking up ground items, etc.
    if props then
        ISWorldObjectContextMenu.fetchPickupItems(v, props, playerInv)
    end

	-- get objects that have health
	if v.getHealth and v.getMaxHealth and not instanceof(v, "IsoAnimal") then
        fetch.health = v
	end

	fetch.item = v;
	if v:getSquare() and doSquare and not ISWorldObjectContextMenu.fetchSquares[v:getSquare()] then
		for i = 0,v:getSquare():getObjects():size()-1 do
			ISWorldObjectContextMenu.fetch(v:getSquare():getObjects():get(i), player, false);
		end
		for i=0,v:getSquare():getStaticMovingObjects():size()-1 do
			ISWorldObjectContextMenu.fetch(v:getSquare():getStaticMovingObjects():get(i), player, false);
		end
		-- help detecting a player by checking nearby squares
		for x=v:getSquare():getX()-1,v:getSquare():getX()+1 do
			for y=v:getSquare():getY()-1,v:getSquare():getY()+1 do
				local sq = getCell():getGridSquare(x,y,v:getSquare():getZ());
				if sq then
					for i=0,sq:getMovingObjects():size()-1 do
						local o = sq:getMovingObjects():get(i)
						if instanceof(o, "IsoPlayer") and (o ~= playerObj) then
							fetch.clickedPlayer = o
						end
						if instanceof(o, "IsoAnimal") then
							if luautils.tableContains(fetch.clickedAnimals, o) == false then
								table.insert(fetch.clickedAnimals, o);
							end
						end
					end
				end
			end
		end
	end
	
	if doSquare then
		fetch.animalZone = DesignationZoneAnimal.getZone(v:getSquare():getX(), v:getSquare():getY(), v:getSquare():getZ())

		ISWorldObjectContextMenu.fetchSquares[v:getSquare()] = true
	end
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
		if ISWorldObjectContextMenu.useJavaFetchLogic == true then
			ISWorldObjectContextMenuLogic.fetch(fetch, v, player, true);
		else
		ISWorldObjectContextMenu.fetch(v, player, true);
    end
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
	if ISWorldObjectContextMenu.useJavaCreateMenuLogic == true then
		if ISWorldObjectContextMenuLogic.createMenuEntries(fetch, context, player, worldobjects, x, y, test or false) then return true end
	else
		if ISWorldObjectContextMenu.createMenuEntries(fetch, context, player, playerObj, playerInv, pickedCorpse, worldobjects, x, y, test) then return true end
	end
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

function ISWorldObjectContextMenu.createMenuEntries(fetch, context, player, playerObj, playerInv, pickedCorpse, worldobjects, x, y, test)
    -- warmanager condition
    if fetch.safehouseAllowInteract then

        local heavyItem = playerObj:getPrimaryHandItem()
        if isForceDropHeavyItem(heavyItem) then
            context:addOption(getText("ContextMenu_DropNamedItem", heavyItem:getDisplayName()), {heavyItem}, ISInventoryPaneContextMenu.onUnEquip, player)
        end

        ISWorldObjectContextMenu.handleInteraction(x, y, test, context, worldobjects, playerObj, playerInv)

        -- Grab a world item
        if ISWorldObjectContextMenu.handleGrabWorldItem(x, y, test, context, worldobjects, playerObj, playerInv) then
            return true
        end

        -- show the health of objects with health in debug
        if fetch.health and isDebugEnabled() then
--             local text = getText("ContextMenu_ObjectHealth") .. ": " .. health:getHealth() .. "/" .. health:getMaxHealth()
            context:addDebugOption(getText("ContextMenu_ObjectHealth") .. ": " .. fetch.health:getHealth() .. "/" .. fetch.health:getMaxHealth());
        end
        -- show the names of tiles in debug
        if fetch.tilename and (getCore():getDebug() or getSandboxOptions():isUnstableScriptNameSpam()) then
			ISWorldObjectContextMenu.addTileDebugInfo(context, fetch)
        end

        if fetch.clickedSquare and (getCore():getDebug() or getSandboxOptions():isUnstableScriptNameSpam()) and fetch.clickedSquare:getRoom() and fetch.clickedSquare:getRoom():getRoomDef() then
--             local text = getText("Roomdef") .. " : " .. tostring(clickedSquare:getRoom())
            context:addDebugOption(getText("Room Report") .. ": " .. tostring(fetch.clickedSquare:getRoom():getRoomDef():getName()) .. ", x: " .. fetch.clickedSquare:getX() .. ", y: " .. fetch.clickedSquare:getY() ..", z: " .. fetch.clickedSquare:getZ());
        elseif fetch.clickedSquare and (getCore():getDebug() or getSandboxOptions():isUnstableScriptNameSpam()) then
            context:addDebugOption("Coordinates Report x: " .. fetch.clickedSquare:getX() .. ", y: " .. fetch.clickedSquare:getY() ..", z: " .. fetch.clickedSquare:getZ());
        end

        -- show the contents of fuel pumps in debug
        if fetch.haveFuelDebug and getCore():getDebug() then
--             local text = getText("ContextMenu_PumpFuelAmount") .. ": " .. tostring(fetch.haveFuelDebug:getPipedFuelAmount())
            context:addDebugOption(getText("ContextMenu_PumpFuelAmount") .. ": " .. tostring(fetch.haveFuelDebug:getPipedFuelAmount()));
        end

		if fetch.butcherHook then
			if test == true then return true; end
			context:addGetUpOption(getText("ContextMenu_ButcherHook"), fetch.butcherHook, ISWorldObjectContextMenu.onButcherHook, playerObj);
		end

        if fetch.ashes then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_Clear_Ashes"), worldobjects, ISWorldObjectContextMenu.onClearAshes, player, fetch.ashes);
        end

        -- pickaxing stump
        if fetch.stump and not playerObj:getVehicle() then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_Remove_Stump"), worldobjects, ISWorldObjectContextMenu.onRemoveGroundCoverItemPickAxe, player, fetch.stump);
        end
        if fetch.ore and not playerObj:getVehicle() then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_Remove_Ore"), worldobjects, ISWorldObjectContextMenu.onRemoveGroundCoverItemHammerOrPickAxe, player, fetch.ore);
        end
        if fetch.pickupItem and not playerObj:getVehicle() then
            if test == true then return true; end
    --         print("worldobjects " .. tostring(worldobjects))
    --         print("player " .. tostring(player))
    --         print("pickupItem " .. tostring(pickupItem))
            ISWorldObjectContextMenu.prePickupGroundCoverItem (context, worldobjects, player, fetch.pickupItem)
        end

		local rakedung = playerInv:getFirstEvalRecurse(predicatePickDung);
		if playerObj:getPrimaryHandItem() and predicatePickDung(playerObj:getPrimaryHandItem()) then rakedung = playerObj:getPrimaryHandItem() end

        local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave);
        if playerObj:getPrimaryHandItem() and predicateDigGrave(playerObj:getPrimaryHandItem()) then shovel = playerObj:getPrimaryHandItem() end
		if shovel then
			local shovelOption = context:addOption(getText("ContextMenu_Shovel"), worldobjects, nil)
			local shovelMenu = ISContextMenu:getNew(context)
			context:addSubMenu(shovelOption, shovelMenu)

            --shovelMenu:addOption(getText("ContextMenu_Dig"), worldobjects, ISFarmingMenu.onPlow, playerObj, shovel)

			if rakedung and not playerObj:getVehicle() and shovel then
				if test == true then return true; end
				shovelMenu:addGetUpOption(getText("ContextMenu_RakeDung"), playerObj, ISWorldObjectContextMenu.onRakeDung, rakedung);
			end

			if (JoypadState.players[player+1] or ISEmptyGraves.canDigHere(worldobjects)) and not playerObj:getVehicle() and shovel then
				if test == true then return true; end
				shovelMenu:addGetUpOption(getText("ContextMenu_DigGraves"), worldobjects, ISWorldObjectContextMenu.onDigGraves, player, shovel);
			end
			if fetch.graves and shovel then
				if test == true then return true; end
				shovelMenu:addGetUpOption(getText("ContextMenu_FillGrave", fetch.graves:getModData()["corpses"]), fetch.graves, ISWorldObjectContextMenu.onFillGrave, player, shovel)
			end

			--ISWorldObjectContextMenu.addGarderingOptions(shovelMenu, worldobjects, player)
		end
		if fetch.graves and not ISEmptyGraves.isGraveFullOfCorpses(fetch.graves) and (playerObj:isGrappling() or (playerObj:getPrimaryHandItem() and playerObj:getPrimaryHandItem():hasTag("AnimalCorpse"))) then
			if test == true then return true; end
			local option = context:addGetUpOption(getText("ContextMenu_BuryCorpse", fetch.graves:getModData()["corpses"]), fetch.graves, ISWorldObjectContextMenu.onBuryCorpse, player, playerObj:getPrimaryHandItem());
			if playerObj:DistToSquared(fetch.graves:getX() + 0.5, fetch.graves:getY() + 0.5) > 1.5 then
				option.notAvailable = true
				option.toolTip = ISToolTip:new()
				option.toolTip:initialise()
				option.toolTip:setVisible(false)
				option.toolTip:setName(getText("ContextMenu_BuryCorpse", fetch.graves:getModData()["corpses"]))
				option.toolTip.description = getText("Tooltip_grave_addcorpse_far")
			end
		end

		if rakedung and not playerObj:getVehicle() and rakedung ~= shovel then
			local rakeOption = context:addOption(getText("ContextMenu_Rake"), worldobjects, nil)
			local rakeMenu = ISContextMenu:getNew(context)
			context:addSubMenu(rakeOption, rakeMenu)
			if test == true then return true; end
			rakeMenu:addGetUpOption(getText("ContextMenu_RakeDung"), playerObj, ISWorldObjectContextMenu.onRakeDung, rakedung);
		end


        if fetch.trap and fetch.trap:getItem() then
            if test == true then return true end
            local doneSquare = {}
            for i,v in ipairs(worldobjects) do
                if v:getSquare() and not doneSquare[v:getSquare()] then
                    doneSquare[v:getSquare()] = true
                    for n = 1,v:getSquare():getObjects():size() do
                        local trap = v:getSquare():getObjects():get(n-1)
                        if instanceof(trap, "IsoTrap") and trap:getItem() and not trap:isExploding() then
                            context:addGetUpOption(getText("ContextMenu_TrapTake", trap:getItem():getName()), worldobjects, ISWorldObjectContextMenu.onTakeTrap, trap, player)
                        end
                    end
                end
            end
        end

        if fetch.body and not fetch.body:isAnimal() and not playerObj:getVehicle() then
            --if playerInv:getItemCount("Base.CorpseMale") == 0 then
            --    if test == true then return true; end
            --    context:addGetUpOption(getText("ContextMenu_Grab_Corpse"), worldobjects, ISWorldObjectContextMenu.onGrabCorpseItem, fetch.body, player);
            --end
            if playerInv:containsEvalRecurse(predicatePetrolHalfLitre) and (playerInv:containsTagRecurse("StartFire") or playerInv:containsTypeRecurse("Lighter") or playerInv:containsTypeRecurse("Matches")) then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Burn_Corpse"), worldobjects, ISWorldObjectContextMenu.onBurnCorpse, player, fetch.body);
            end
        end

        if pickedCorpse and pickedCorpse:isAnimal() then
            fetch.animalbody = pickedCorpse
        end
        if fetch.animalbody then
            AnimalContextMenu.doAnimalBodyMenu(context, player, fetch.animalbody);
        end

        if fetch.door and not fetch.door:IsOpen() and fetch.doorKeyId then
            if playerInv:haveThisKeyId(fetch.doorKeyId) or not playerObj:getCurrentSquare():Is(IsoFlagType.exterior) then
                if test == true then return true; end
                if not fetch.door:isLockedByKey() then
                    context:addGetUpOption(getText("ContextMenu_LockDoor"), worldobjects, ISWorldObjectContextMenu.onLockDoor, player, fetch.door);
                else
                    context:addGetUpOption(getText("ContextMenu_UnlockDoor"), worldobjects, ISWorldObjectContextMenu.onUnLockDoor, player, fetch.door, fetch.doorKeyId);
                end
            end
        end

        if excavatableFloor and shovel then

              context:addGetUpOption(getText("ContextMenu_ExcavateStairs"), worldobjects, ISWorldObjectContextMenu.onExcavateStairs, player, excavatableFloor);

        end

        -- if the player have a padlock with a key on it
        if fetch.padlockThump then
            local padlock = playerInv:FindAndReturn("Padlock");
            if padlock and padlock:getNumberOfKey() > 0 then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_PutPadlock"), worldobjects, ISWorldObjectContextMenu.onPutPadlock, player, fetch.padlockThump, padlock);
            end
            local digitalPadlock = playerInv:FindAndReturn("CombinationPadlock");
            if digitalPadlock then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_PutCombinationPadlock"), worldobjects, ISWorldObjectContextMenu.onPutDigitalPadlock, player, fetch.padlockThump, digitalPadlock);
            end
        end

        if fetch.padlockedThump and playerInv:haveThisKeyId(fetch.padlockedThump:getKeyId()) then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_RemovePadlock"), worldobjects, ISWorldObjectContextMenu.onRemovePadlock, player, fetch.padlockedThump);
        end

        if fetch.digitalPadlockedThump then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_RemoveCombinationPadlock"), worldobjects, ISWorldObjectContextMenu.onRemoveDigitalPadlock, player, fetch.digitalPadlockedThump);
        end

        if fetch.canBeWaterPiped then
            if test == true then return true; end
            local name = getMoveableDisplayName(fetch.canBeWaterPiped) or "";
            local option = context:addGetUpOption(getText("ContextMenu_PlumbItem", name), worldobjects, ISWorldObjectContextMenu.onPlumbItem, player, fetch.canBeWaterPiped);
            if not playerInv:containsTypeEvalRecurse("PipeWrench", predicateNotBroken) and not playerInv:containsTagEvalRecurse("PipeWrench", predicateNotBroken) then
                option.notAvailable = true;
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_PlumbItem", name));
                tooltip.description = getText("Tooltip_NeedWrench", getItemName("Base.PipeWrench"));
                option.toolTip = tooltip;
            end
        end


        -- get back the key on the lock
    --    if door and doorKeyId and door:haveKey() and not playerObj:getSquare():Is(IsoFlagType.exterior) then
    --        context:addOption("Get the key", worldobjects, ISWorldObjectContextMenu.onGetDoorKey, player, door, doorKeyId);
    --    end

        -- For fishing with the joypad, look around the player to find some water.
        local fishObject = worldobjects[1]
        if JoypadState.players[player+1] then
            local px = playerObj:getX()
            local py = playerObj:getY()
            local pz = playerObj:getZ()
            local rod = ISWorldObjectContextMenu.getFishingRode(playerObj)
            local lure = ISWorldObjectContextMenu.getFishingLure(playerObj, rod)
            local net = playerInv:getFirstTypeRecurse("FishingNet")
            if (rod and lure) or net then
                for dy = -5,5 do
                    for dx = -5,5 do
                        local square = getCell():getGridSquare(px + dx, py + dy, pz)
                        -- FIXME: is there a wall in between?
                        -- TODO: pick a square in the direction the player is facing.
                        if square and square:Is(IsoFlagType.water) and square:getObjects():size() > 0 then
                            if rod and lure then fetch.canFish = true end
                            if net then fetch.canTrapFish = true end
                            fishObject = square:getObjects():get(0)
                            break
                        end
                    end
                    if fetch.canFish or fetch.canTrapFish then break end
                end
            end
            for dy = -5,5 do
                for dx = -5,5 do
                    local square = getCell():getGridSquare(px + dx, py + dy, pz)
                    -- FIXME: is there a wall in between?
                    -- TODO: pick a square in the direction the player is facing.
                    if square and square:Is(IsoFlagType.water) and square:getObjects():size() > 0 then
                        for i = 0,square:getObjects():size()-1 do
                            local v = square:getObjects():get(i)
                            if instanceof(v, "IsoObject") and v:getName() == "FishingNet" then
                                fetch.trapFish = v
                                break
                            end
                        end
                        if fetch.trapFish then break end
                    end
                end
            end
        end

        -- Fishing
        if fetch.canTrapFish and fetch.clickedSquare then
            if test == true then return true; end
			ISWorldObjectContextMenu.doFishNetOptions(context, playerObj, fetch.clickedSquare)
        end

        if fetch.trapFish and fetch.clickedSquare and not Fishing.isNoFishZone(fetch.clickedSquare:getX(), fetch.clickedSquare:getY()) then
            if test == true then return true; end
            ISWorldObjectContextMenu.doPlacedFishNetOptions(context, playerObj, fetch.trapFish)
        end

        if fetch.canFish and fetch.clickedSquare and not Fishing.isNoFishZone(fetch.clickedSquare:getX(), fetch.clickedSquare:getY()) then
            local opt = context:addOption(getText("ContextMenu_Fishing"), worldobjects, ISWorldObjectContextMenu.openFishWindow)
            --opt.toolTip = ISWorldObjectContextMenu.getFishCheckTooltip(x, y, fetch.storeWater:getSquare(), playerObj)
			--opt.toolTip = ISWorldObjectContextMenu.addToolTip()
			--opt.toolTip:setName(getText("ContextMenu_Fishing"))
			--opt.toolTip.description = getText("Tooltip_FishingTip")
        end

        if fetch.canAddChum and fetch.clickedSquare and not Fishing.isNoFishZone(fetch.clickedSquare:getX(), fetch.clickedSquare:getY()) then
			ISWorldObjectContextMenu.doChumOptions(context, playerObj, fetch.clickedSquare)
        end

    --	print(fetch.groundType)
        if fetch.groundType == "sand" and playerObj:isRecipeActuallyKnown("MakeChum") then
            ISWorldObjectContextMenu.doCreateChumOptions(context, playerObj, fetch.groundSquare)
        end

        -- climb a sheet rope
        if fetch.sheetRopeSquare and playerObj:canClimbSheetRope(fetch.sheetRopeSquare) and playerObj:getPerkLevel(Perks.Strength) >= 0 then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_Climb_Sheet_Rope"), worldobjects, ISWorldObjectContextMenu.onClimbSheetRope, fetch.sheetRopeSquare, false, player)
        end

        -- iso thumpable light source interaction
        if fetch.thumpableLightSource then
                if (fetch.thumpableLightSource:getLightSourceFuel() and fetch.thumpableLightSource:haveFuel()) or not fetch.thumpableLightSource:getLightSourceFuel() then
                    if fetch.thumpableLightSource:isLightSourceOn() then
                        if test == true then return true; end
                        context:addGetUpOption(getText("ContextMenu_Turn_Off"), fetch.thumpableLightSource, ISWorldObjectContextMenu.onToggleThumpableLight, player);
                    elseif fetch.thumpableLightSource:getLifeLeft() > 0 then
                        if test == true then return true; end
                        context:addGetUpOption(getText("ContextMenu_Turn_On"), fetch.thumpableLightSource, ISWorldObjectContextMenu.onToggleThumpableLight, player);
                    end
                end
                if fetch.thumpableLightSource:getLightSourceFuel() and playerInv:containsWithModule(fetch.thumpableLightSource:getLightSourceFuel(), true) then
                    if test == true then return true; end
                    local fuelOption = context:addOption(getText("ContextMenu_Insert_Fuel"), worldobjects, nil)
                    local subMenuFuel = ISContextMenu:getNew(context)
                    context:addSubMenu(fuelOption, subMenuFuel)
                    local fuelList = playerInv:FindAll(fetch.thumpableLightSource:getLightSourceFuel())
                    for n = 0,fuelList:size()-1 do
                        local fuel = fuelList:get(n)
                        if instanceof(fuel, 'DrainableComboItem') and fuel:getCurrentUsesFloat() > 0 then
                            local fuelOption2 = subMenuFuel:addGetUpOption(fuel:getName(), fetch.thumpableLightSource, ISWorldObjectContextMenu.onInsertFuel, fuel, playerObj)
                            local tooltip = ISWorldObjectContextMenu.addToolTip()
                            tooltip:setName(fuel:getName())
                            tooltip.description = getText("IGUI_RemainingPercent", luautils.round(math.ceil(fuel:getCurrentUsesFloat()*100),0))
                            fuelOption2.toolTip = tooltip
                        end
                    end
                end
                if fetch.thumpableLightSource:getLightSourceFuel() and fetch.thumpableLightSource:haveFuel() then
                    if test == true then return true; end
                    local removeOption = context:addGetUpOption(getText("ContextMenu_Remove_Battery"), fetch.thumpableLightSource, ISWorldObjectContextMenu.onRemoveFuel, player);
                    if playerObj:DistToSquared(fetch.thumpableLightSource:getX() + 0.5, fetch.thumpableLightSource:getY() + 0.5) < 2 * 2 then
                        local item = ScriptManager.instance:getItem(fetch.thumpableLightSource:getLightSourceFuel())
                        local tooltip = ISWorldObjectContextMenu.addToolTip()
                        tooltip:setName(item and item:getDisplayName() or "???")
                        tooltip.description = getText("IGUI_RemainingPercent", luautils.round(math.ceil(fetch.thumpableLightSource:getLifeLeft()*100),0))
                        removeOption.toolTip = tooltip
                    end
                end
        end

        -- sleep into a bed

        --commented out the tent stuff as it's better to handle all of the sleeping and resting interactions in one place, here, vs having a separate duplicate interaction in ISCampingMenu.lua
    -- 	local tent = nil
    -- 	for i,v in ipairs(worldobjects) do
    -- 		tent = camping.getCurrentTent(v:getSquare())
    -- 		if tent then break end
    -- 	end

    -- 	if tent then
    -- 		-- See ISCampingMenu.  Avoid duplicate Rest option when clicking on a tent.
    -- 	elseif bed and not ISWorldObjectContextMenu.isSomethingTo(bed, player) and (playerObj:getStats():getEndurance() < 1) then

        if fetch.bed and not ISWorldObjectContextMenu.isSomethingTo(fetch.bed, player) and not playerObj:isSitOnFurnitureObject(fetch.bed) then
            if test == true then return true; end
            if (fetch.bed:getSquare():getRoom() == playerObj:getSquare():getRoom()) or fetch.bed:getSquare():isCanSee(player) then
                context:addGetUpOption(getText("ContextMenu_Rest"), fetch.bed, ISWorldObjectContextMenu.onRest, player);
            end
        end

        -- checks to disallow sleeping in silly chair
        if fetch.bed then fetch.bed = ISWorldObjectContextMenu.chairCheck(fetch.bed) end

    -- 	if tent then
    -- 		-- See ISCampingMenu.  Avoid duplicate Sleep option when clicking on a tent.
    -- 	elseif (bed and not ISWorldObjectContextMenu.isSomethingTo(bed, player)) or playerObj:getStats():getFatigue() > 0.90 then

        if (fetch.bed and not ISWorldObjectContextMenu.isSomethingTo(fetch.bed, player)) or playerObj:getStats():getFatigue() > 0.90 then
            if not isClient() or getServerOptions():getBoolean("SleepAllowed") then
                if test == true then return true; end
                ISWorldObjectContextMenu.doSleepOption(context, fetch.bed, player, playerObj);
            end
        end

	if false and fetch.bed then
		if test == true then return true; end
		ISWorldObjectContextMenu.doBedOption(context, playerObj, fetch.bed)
	end

        --if ISWorldObjectContextMenu.handleRainCollector(test, context, worldobjects, playerObj, playerInv) then
        --    return true
        --end

        --Handling fluid container tiles here
        -- distance test removed as per group discussion [SPIF-2281] - spurcival
		for k, fluidcontainer in pairs(fetch.fluidcontainer) do
			local submenu = ISWorldObjectContextMenu.doFluidContainerMenu(context, fluidcontainer, player);
			if fluidcontainer == fetch.waterdispenser then
				submenu:addGetUpOption(getText("ContextMenu_Take_Bottle"), worldobjects, ISWorldObjectContextMenu.onWaterDispenserBottle, playerObj, fluidcontainer, nil);
			end
			ISWorldObjectContextMenu.addFluidFromItem(test, submenu, fluidcontainer, worldobjects, playerObj, playerInv)
		end
			
        -- wash clothing/yourself
		for k, storeWater in pairs(fetch.storeWater) do
			if not luautils.tableContains(fetch.fluidcontainer, storeWater) then
				local source = getMoveableDisplayName(storeWater);
				if source == nil and instanceof(storeWater, "IsoWorldInventoryObject") and storeWater:getItem() then
					source = storeWater:getFluidUiName();
				end
				if source == nil then
					source = getText("ContextMenu_NaturalWaterSource")
				end

				local mainOption = context:addOption(source, nil, nil);
				local mainSubMenu = ISContextMenu:getNew(context)
				context:addSubMenu(mainOption, mainSubMenu)

				if storeWater:hasWater() and not fetch.clothingDryer and not fetch.clothingWasher and not fetch.comboWasherDryer then --Stops being able to wash clothes in washing machines and dryers
					ISWorldObjectContextMenu.doWashClothingMenu(storeWater, player, mainSubMenu);
					ISWorldObjectContextMenu.doRecipeUsingWaterMenu(storeWater, player, mainSubMenu);
				end

				if getCore():getGameMode() ~= "LastStand"  then
					ISWorldObjectContextMenu.doDrinkWaterMenu(storeWater, player, mainSubMenu);
				end

				if getCore():getGameMode()~="LastStand"  then
					ISWorldObjectContextMenu.doFillFluidMenu(storeWater, player, mainSubMenu);
				end

				if ISWorldObjectContextMenu.toggleClothingWasher(mainSubMenu, worldobjects, player, fetch.clothingWasher) then
					return true
				end

				if ISWorldObjectContextMenu.toggleComboWasherDryer(mainSubMenu, playerObj, fetch.comboWasherDryer) then
					return true
				end
			end
		end

		-- calling this here as it uses the fluid option so it's always at the same position (trough can have 2 parts, one will be a dummy and not have its fluid container)
		ISFeedingTroughMenu.OnFillWorldObjectContextMenu(player, context, worldobjects, test)
		
		--take bottle from water dispensers
        if fetch.waterdispenser and playerInv:contains("WaterDispenserBottle") and not luautils.tableContains(fetch.fluidcontainer, fetch.waterdispenser) then
            if test == true then return true; end
            ISWorldObjectContextMenu.doWaterDispenserMenu(fetch.waterdispenser, playerObj, context);
        end

		if fetch.rainCollectorBarrel and not luautils.tableContains(fetch.fluidcontainer, fetch.rainCollectorBarrel) then
			ISWorldObjectContextMenu.addFluidFromItem(test, context, fetch.rainCollectorBarrel, worldobjects, playerObj, playerInv)
		end
		if fetch.waterDispenser and not luautils.tableContains(fetch.fluidcontainer, fetch.waterDispenser) then
			ISWorldObjectContextMenu.addFluidFromItem(test, context, fetch.waterDispenser, worldobjects, playerObj, playerInv)
		end
		if fetch.worldItem and fetch.worldItem:getItem() and fetch.worldItem:getFluidCapacity() > 0 and not luautils.tableContains(fetch.fluidcontainer, fetch.worldItem) then
			ISWorldObjectContextMenu.addFluidFromItem(test, context, fetch.worldItem, worldobjects, playerObj, playerInv)
		end

		if fetch.clothingDryer then
			ISWorldObjectContextMenu.onWashingDryer(getMoveableDisplayName(fetch.clothingDryer), context, fetch.clothingDryer, player)
		end

        if ISWorldObjectContextMenu.doStoveOption(test, context, player) then
            return true
        end

        if ISWorldObjectContextMenu.doLightSwitchOption(test, context, player) then
            return true
        end

        if ISWorldObjectContextMenu.doThumpableWindowOption(test, context, player) then
            return true
        end

        local hasHammer = playerInv:containsTagEvalRecurse("Hammer", predicateNotBroken)
        local hasRemoveBarricadeTool = playerInv:containsTagEvalRecurse("RemoveBarricade", predicateNotBroken)

		local sheetRopeCandidates = {
			window = fetch.window,
			hoppableN = fetch.hoppableN,
			hoppableN_2 = fetch.hoppableN_2,
			hoppableW = fetch.hoppableW,
			hoppableW_2 = fetch.hoppableW_2,
			thumpableWindowN = fetch.thumpableWindowN,
			thumpableWindowN_2 = fetch.thumpableWindowN_2,
			thumpableWindowW = fetch.thumpableWindowW,
			thumpableWindowW_2 = fetch.thumpableWindowW_2,
		};

		for _, object in pairs(sheetRopeCandidates) do
			if object ~= nil and not fetch.invincibleWindow then
				ISWorldObjectContextMenu.doSheetRopeOptions(context, object, worldobjects, player, playerObj, playerInv, hasHammer, test);
			end
		end

        -- created thumpable item interaction
        if fetch.thump ~= nil and not fetch.invincibleWindow and not fetch.window then
            if fetch.thump:isBarricadeAllowed() then
                local ignoreObject = false;
                for k,v in ipairs(worldobjects) do
                    if instanceof(v,"IsoWindow") and fetch.thump~=v then
                        ignoreObject = true;
                    end
                end
                if not ignoreObject then
                    -- unbarricade (hammer on 1st hand and window barricaded)
                    -- barricade (hammer on 1st hand, plank on 2nd hand) and need nails
                    local barricade = fetch.thump:getBarricadeForCharacter(playerObj)
                    if not fetch.thump:haveSheetRope() and (not barricade or barricade:canAddPlank()) and hasHammer and
                            playerInv:containsTypeRecurse("Plank") and playerInv:getItemCountRecurse("Base.Nails") >= 2  then
                        if test == true then return true; end
                        context:addGetUpOption(getText("ContextMenu_Barricade"), worldobjects, ISWorldObjectContextMenu.onBarricade, fetch.thump, player);
                    end
                    if (barricade and barricade:getNumPlanks() > 0) and hasRemoveBarricadeTool then
                        if test == true then return true; end
                        context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricade, fetch.thump, player);
                    end
                    if not fetch.thump:haveSheetRope() and not barricade and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) and playerInv:containsTypeRecurse("SheetMetal") then
                        if test == true then return true; end
                        context:addGetUpOption(getText("ContextMenu_MetalBarricade"), worldobjects, ISWorldObjectContextMenu.onMetalBarricade, fetch.thump, player);
                    end
                    if not fetch.thump:haveSheetRope() and not barricade and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) and playerInv:getItemCountRecurse("Base.MetalBar") >= 3 then
                        if test == true then return true; end
                        context:addGetUpOption(getText("ContextMenu_MetalBarBarricade"), worldobjects, ISWorldObjectContextMenu.onMetalBarBarricade, fetch.thump, player);
                    end
                    if (barricade and barricade:isMetal()) and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) then
                        if test == true then return true; end
                        context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricadeMetal, fetch.thump, player);
                    end
                    if (barricade and barricade:isMetalBar()) and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) then
                        if test == true then return true; end
                        context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricadeMetalBar, fetch.thump, player);
                    end
                end
            end
        end

	    -- window interaction
        if fetch.window ~= nil and not fetch.invincibleWindow then
            local curtain2 = fetch.window:HasCurtains();
            fetch.curtain = fetch.curtain or curtain2
            -- barricade, addsheet, etc...
            -- you can do action only inside a house
            -- add sheet (curtains) to window (sheet on 1st hand)
            if not curtain2 and playerInv:containsTypeRecurse("Sheet") then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Add_sheet"), worldobjects, ISWorldObjectContextMenu.onAddSheet, fetch.window, player);
            end
            -- barricade (hammer on 1st hand, plank on 2nd hand) and need nails
            local barricade = fetch.window:getBarricadeForCharacter(playerObj)
            if fetch.window:isBarricadeAllowed() and not fetch.window:haveSheetRope() and (not barricade or barricade:canAddPlank()) and hasHammer and
                    playerInv:containsTypeRecurse("Plank") and playerInv:getItemCountRecurse("Base.Nails") >= 2 then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Barricade"), worldobjects, ISWorldObjectContextMenu.onBarricade, fetch.window, player);
            end
            -- unbarricade (hammer on 1st hand and window barricaded)
            if (barricade and barricade:getNumPlanks() > 0) and hasRemoveBarricadeTool then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricade, fetch.window, player);
            end
            if not fetch.window:haveSheetRope() and not barricade and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) and playerInv:containsTypeRecurse("SheetMetal") then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_MetalBarricade"), worldobjects, ISWorldObjectContextMenu.onMetalBarricade, fetch.window, player);
            end
            if not fetch.window:haveSheetRope() and not barricade and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) and playerInv:getItemCountRecurse("Base.MetalBar") >= 3 then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_MetalBarBarricade"), worldobjects, ISWorldObjectContextMenu.onMetalBarBarricade, fetch.window, player);
            end
            if (barricade and barricade:isMetal()) and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricadeMetal, fetch.window, player);
            end
            if (barricade and barricade:isMetalBar()) and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricadeMetalBar, fetch.window, player);
            end

            -- open window if no barricade on the player's side
            if fetch.window:IsOpen() and not fetch.window:isSmashed() and not barricade then
                if test == true then return true; end
                local opencloseoption = context:addGetUpOption(getText("ContextMenu_Close_window"), worldobjects, ISWorldObjectContextMenu.onOpenCloseWindow, fetch.window, player);
                if not JoypadState.players[player+1] then
                    local tooltip = ISWorldObjectContextMenu.addToolTip()
                    tooltip:setName(getText("ContextMenu_Info"))
                    tooltip.description = getText("Tooltip_OpenClose", getKeyName(getCore():getKey("Interact")));
                    opencloseoption.toolTip = tooltip;
                end
            end
            -- close & smash window if no barricade on the player's side
            if not fetch.window:IsOpen() and not fetch.window:isSmashed() and not barricade then
                if test == true then return true; end
                if not fetch.window:getSprite() or not fetch.window:getSprite():getProperties():Is("WindowLocked") then
                    local opencloseoption = context:addGetUpOption(getText("ContextMenu_Open_window"), worldobjects, ISWorldObjectContextMenu.onOpenCloseWindow, fetch.window, player);
                    if not JoypadState.players[player+1] then
                        local tooltip = ISWorldObjectContextMenu.addToolTip()
                        tooltip:setName(getText("ContextMenu_Info"))
                        tooltip.description = getText("Tooltip_OpenClose", getKeyName(getCore():getKey("Interact")));
                        opencloseoption.toolTip = tooltip;
                    end
                end
                context:addGetUpOption(getText("ContextMenu_Smash_window"), worldobjects, ISWorldObjectContextMenu.onSmashWindow, fetch.window, player);
            end
            if fetch.window:canClimbThrough(playerObj) then
                if test == true then return true; end
                local climboption = context:addGetUpOption(getText("ContextMenu_Climb_through"), worldobjects, ISWorldObjectContextMenu.onClimbThroughWindow, fetch.window, player);
                if not JoypadState.players[player+1] then
                    local tooltip = ISWorldObjectContextMenu.addToolTip()
                    tooltip:setName(getText("ContextMenu_Info"))
                    if fetch.window:isGlassRemoved() then
                        tooltip.description = getText("Tooltip_TapKey", getKeyName(getCore():getKey("Interact")));
                    else
                        tooltip.description = getText("Tooltip_Climb", getKeyName(getCore():getKey("Interact")));
                    end
                    climboption.toolTip = tooltip;
                end
            end
            -- remove glass if no barricade on player's side
            if fetch.window:isSmashed() and not fetch.window:isGlassRemoved() and not barricade then
                if test == true then return true; end
                local option = context:addGetUpOption(getText("ContextMenu_RemoveBrokenGlass"), worldobjects, ISWorldObjectContextMenu.onRemoveBrokenGlass, fetch.window, player);
                if not playerObj:getPrimaryHandItem() then
                    option.notAvailable = true
                    local tooltip = ISWorldObjectContextMenu.addToolTip()
                    tooltip.description = getText("Tooltip_RemoveBrokenGlassNoItem")
                    option.toolTip = tooltip
                end
            end
        end

        if fetch.curtain == nil and fetch.windowFrame ~= nil then
            local curtain2 = fetch.windowFrame:HasCurtains();
            fetch.curtain = fetch.curtain or curtain2
        end
        if fetch.curtain == nil and fetch.thumpableWindow ~= nil then
            local curtain2 = fetch.thumpableWindow:HasCurtains();
            fetch.curtain = fetch.curtain or curtain2
        end

	-- curtain interaction
        if fetch.curtain ~= nil and not fetch.invincibleWindow then
                local text = getText("ContextMenu_Open_curtains");
                if fetch.curtain:IsOpen() then
                    text = getText("ContextMenu_Close_curtains");
                end
                --Check if we are in same room as curtain.
                if test == true then return true; end
            --Players unable to open/remove curtains? These lines are probably why.
            if not fetch.curtain:getSquare():getProperties():Is(IsoFlagType.exterior) then
                if not playerObj:getCurrentSquare():Is(IsoFlagType.exterior) then
                    local option = context:addGetUpOption(text, worldobjects, ISWorldObjectContextMenu.onOpenCloseCurtain, fetch.curtain, player);
                    if not JoypadState.players[player+1] then
                        local tooltip = ISWorldObjectContextMenu.addToolTip()
                        tooltip:setName(getText("ContextMenu_Info"))
                        tooltip.description = getText("Tooltip_OpenCloseCurtains", getKeyName(getCore():getKey("Interact")));
                        option.toolTip = tooltip;
                    end
                    ISWorldObjectContextMenu.addRemoveCurtainOption(context, worldobjects, fetch.curtain, player)
                end
            else
                context:addGetUpOption(text, worldobjects, ISWorldObjectContextMenu.onOpenCloseCurtain, fetch.curtain, player);
                ISWorldObjectContextMenu.addRemoveCurtainOption(context, worldobjects, fetch.curtain, player)
            end
        end

        -- window frame without window
        if fetch.windowFrame and not fetch.window and not fetch.thumpableWindow then
            if fetch.windowFrame:getCurtain() == nil and playerInv:containsTypeRecurse("Sheet") then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Add_sheet"), worldobjects, ISWorldObjectContextMenu.onAddSheet, fetch.windowFrame, player);
            end
            local numSheetRope = fetch.windowFrame:countAddSheetRope()
            if fetch.windowFrame:canAddSheetRope() and not fetch.windowFrame:isBarricaded() and playerObj:getCurrentSquare():getZ() > 0 and
                    playerInv:containsTypeRecurse("Nails") then
                if (playerInv:getItemCountRecurse("SheetRope") >= fetch.windowFrame:countAddSheetRope()) then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_Add_escape_rope_sheet"), worldobjects, ISWorldObjectContextMenu.onAddSheetRope, fetch.windowFrame, player, true);
                elseif (playerInv:getItemCountRecurse("Rope") >= fetch.windowFrame:countAddSheetRope()) then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_Add_escape_rope"), worldobjects, ISWorldObjectContextMenu.onAddSheetRope, fetch.windowFrame, player, false);
                end
            end
            if fetch.windowFrame:haveSheetRope() then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Remove_escape_rope"), worldobjects, ISWorldObjectContextMenu.onRemoveSheetRope, fetch.windowFrame, player);
            end
            if test == true then return true end
            if fetch.windowFrame:canClimbThrough(playerObj) and not fetch.windowFrame:hasWindow() then
                local climboption = context:addGetUpOption(getText("ContextMenu_Climb_through"), worldobjects, ISWorldObjectContextMenu.onClimbThroughWindow, fetch.windowFrame, player)
                if not JoypadState.players[player+1] then
                    local tooltip = ISWorldObjectContextMenu.addToolTip()
                    tooltip:setName(getText("ContextMenu_Info"))
                    tooltip.description = getText("Tooltip_TapKey", getKeyName(getCore():getKey("Interact")))
                    climboption.toolTip = tooltip
                end
            end
            if fetch.windowFrame:isBarricadeAllowed() then
                local barricade = fetch.windowFrame:getBarricadeForCharacter(playerObj)
                if not fetch.windowFrame:haveSheetRope() and (not barricade or barricade:canAddPlank()) and hasHammer and
                        playerInv:containsTypeRecurse("Plank") and playerInv:getItemCountRecurse("Base.Nails") >= 2  then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_Barricade"), worldobjects, ISWorldObjectContextMenu.onBarricade, fetch.windowFrame, player);
                end
                if (barricade and barricade:getNumPlanks() > 0) and hasRemoveBarricadeTool then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricade, fetch.windowFrame, player);
                end
                if not fetch.windowFrame:haveSheetRope() and not barricade and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) and playerInv:containsTypeRecurse("SheetMetal") then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_MetalBarricade"), worldobjects, ISWorldObjectContextMenu.onMetalBarricade, fetch.windowFrame, player);
                end
                if not fetch.windowFrame:haveSheetRope() and not barricade and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) and playerInv:getItemCountRecurse("Base.MetalBar") >= 3 then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_MetalBarBarricade"), worldobjects, ISWorldObjectContextMenu.onMetalBarBarricade, fetch.windowFrame, player);
                end
                if (barricade and barricade:isMetal()) and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricadeMetal, fetch.windowFrame, player);
                end
                if (barricade and barricade:isMetalBar()) and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricadeMetalBar, fetch.windowFrame, player);
                end
            end
        end
    
        -- broken glass interaction
    --    if brokenGlass and playerObj:getClothingItem_Hands() then
        if fetch.brokenGlass then
    --        local itemName = playerObj:getClothingItem_Hands():getName()
    --        if itemName ~= "Fingerless Gloves" then
                context:addGetUpOption(getText("ContextMenu_PickupBrokenGlass"), worldObjects, ISWorldObjectContextMenu.onPickupBrokenGlass, fetch.brokenGlass, player)
    --        end
        end

        -- door interaction
        if fetch.door ~= nil then
            local text = getText("ContextMenu_Open_door");
            if fetch.door:IsOpen() then
                text = getText("ContextMenu_Close_door");
            end
            -- a door can be opened/close only if it not barricaded
            if not fetch.door:isBarricaded() then
                if test == true then return true; end
                local opendooroption = context:addGetUpOption(text, worldobjects, ISWorldObjectContextMenu.onOpenCloseDoor, fetch.door, player);
                if not JoypadState.players[player+1] then
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("ContextMenu_Info"))
                tooltip.description = getText("Tooltip_OpenClose", getKeyName(getCore():getKey("Interact")));
                opendooroption.toolTip = tooltip;
                end
            end
            -- Double-doors cannot be barricaded
            local canBarricade = fetch.door:isBarricadeAllowed()
            local barricade = fetch.door:getBarricadeForCharacter(playerObj)
            -- barricade (hammer on 1st hand, plank on 2nd hand)
            if canBarricade and (not barricade or barricade:canAddPlank()) and hasHammer and
                    playerInv:containsTypeRecurse("Plank") and playerInv:getItemCountRecurse("Base.Nails") >= 2 then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Barricade"), worldobjects, ISWorldObjectContextMenu.onBarricade, fetch.door, player);
            end
            if (barricade and barricade:getNumPlanks() > 0) and hasRemoveBarricadeTool then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricade, fetch.door, player);
            end
            if canBarricade and not barricade and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) and playerInv:containsTypeRecurse("SheetMetal") then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_MetalBarricade"), worldobjects, ISWorldObjectContextMenu.onMetalBarricade, fetch.door, player);
            end
            if canBarricade and not barricade and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) and playerInv:getItemCountRecurse("Base.MetalBar") >= 3 then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_MetalBarBarricade"), worldobjects, ISWorldObjectContextMenu.onMetalBarBarricade, fetch.door, player);
            end
            if (barricade and barricade:isMetal()) and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricadeMetal, fetch.door, player);
            end
            if (barricade and barricade:isMetalBar()) and ISWorldObjectContextMenu.checkBlowTorchForBarricade(playerObj) then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Unbarricade"), worldobjects, ISWorldObjectContextMenu.onUnbarricadeMetalBar, fetch.door, player);
            end
            if instanceof(fetch.door, "IsoDoor") and fetch.door:HasCurtains() then
                if test == true then return true; end
                local text = getText(fetch.door:isCurtainOpen() and "ContextMenu_Close_curtains" or "ContextMenu_Open_curtains")
                context:addGetUpOption(text, worldobjects, ISWorldObjectContextMenu.onOpenCloseCurtain, fetch.door, player);
                ISWorldObjectContextMenu.addRemoveCurtainOption(context, worldobjects, fetch.door, player)
            elseif instanceof(fetch.door, "IsoDoor") and fetch.door:canAddCurtain() then
                if playerInv:containsTypeRecurse("Sheet") then
                    if test == true then return true; end
                    context:addGetUpOption(getText("ContextMenu_Add_sheet"), worldobjects, ISWorldObjectContextMenu.onAddSheet, fetch.door, player);
                end
            end
            if fetch.door:isHoppable() and fetch.door:canClimbOver(playerObj) then
                local climbDir = nil
                local option = context:addGetUpOption(getText("ContextMenu_Climb_over"), worldobjects, ISWorldObjectContextMenu.onClimbOverFence, fetch.door, climbDir, player);
                if not JoypadState.players[player+1] then
                    local tooltip = ISWorldObjectContextMenu.addToolTip()
                    tooltip:setName(getText("ContextMenu_Info"))
                    tooltip.description = getText("Tooltip_Climb", getKeyName(getCore():getKey("Interact")));
                    option.toolTip = tooltip;
                end
            end
        end

        -- survivor interaction
        if fetch.survivor ~= nil then
            if test == true then return true; end
            -- if the player is teamed up with the survivor
            if(playerObj:getDescriptor():InGroupWith(fetch.survivor)) then
                local orderOption = context:addOption(getText("ContextMenu_Orders"), worldobjects, nil);
                -- create our future subMenu
                local subMenu = context:getNew(context);
                -- create the option in our subMenu
                subMenu:addOption(getText("ContextMenu_Follow_me"), worldobjects, ISWorldObjectContextMenu.onFollow, fetch.survivor);
                subMenu:addOption(getText("ContextMenu_Guard"), worldobjects, ISWorldObjectContextMenu.onGuard, fetch.survivor);
                subMenu:addOption(getText("ContextMenu_Stay"), worldobjects, ISWorldObjectContextMenu.onStay, fetch.survivor);
                -- we add the subMenu to our current option (Orders)
                context:addSubMenu(orderOption, context.subOptionNums);
            else
                context:addOption(getText("ContextMenu_Team_up"), worldobjects, ISWorldObjectContextMenu.onTeamUp, fetch.survivor);
            end
            -- TODO : TalkTo
            --context:addOption("Talk to", worldobjects, ISWorldObjectContextMenu.onTalkTo, fetch.survivor);
        end
        -- attach animal to a tree/picket
        AnimalContextMenu.attachAnimalToObject(fetch.attachAnimalTo, playerObj, worldobjects, context)

        if fetch.tree then
            local axe = playerInv:getFirstEvalRecurse(predicateChopTree)
            if axe then
                if test == true then return true; end
                context:addGetUpOption(getText("ContextMenu_Chop_Tree"), worldobjects, ISWorldObjectContextMenu.onChopTree, playerObj, fetch.tree)
            end
        end

        -- take fuel
        local fuelPower =  (SandboxVars.AllowExteriorGenerator and fetch.fuelPump and fetch.fuelPump:getSquare():haveElectricity()) or (fetch.fuelPump and fetch.fuelPump:getSquare():hasGridPower())
--         local fuelPower =  ((SandboxVars.AllowExteriorGenerator and fetch.fuelPump and fetch.fuelPump:getSquare():haveElectricity()) or (getSandboxOptions():getElecShutModifier() > -1 and getGameTime():getWorldAgeHours() / 24 + (getSandboxOptions():getTimeSinceApo() - 1) * 30 < getSandboxOptions():getElecShutModifier()))
        if fetch.haveFuel and fuelPower then
            if test == true then return true; end
            -- context:addGetUpOption(getText("ContextMenu_TakeGasFromPump"), worldobjects, ISWorldObjectContextMenu.onTakeFuel, playerObj, fetch.haveFuel);

            ISWorldObjectContextMenu.doFillFuelMenu(fetch.haveFuel, player, context);
        elseif fetch.fuelPump and not fuelPower then
            local option = context:addOption(getText("ContextMenu_FuelPumpNoPower"));
            option.notAvailable = true;
        elseif fetch.fuelPump and fuelPower and fetch.fuelPump:getPipedFuelAmount() <= 0 then
            local option = context:addOption(getText("ContextMenu_FuelPumpEmpty"));
            option.notAvailable = true;
        elseif fetch.fuelPump and fuelPower and fetch.fuelPump:getPipedFuelAmount() > 0 then
            local option = context:addOption(getText("ContextMenu_FuelPumpNoContainer"));
            option.notAvailable = true;
        end

        -- clicked on a player, medical check
        if fetch.clickedPlayer and fetch.clickedPlayer ~= playerObj and not playerObj:HasTrait("Hemophobic") and not instanceof(fetch.clickedPlayer, "IsoAnimal") then
            if test == true then return true; end
            local option = context:addGetUpOption(getText("ContextMenu_Medical_Check"), worldobjects, ISWorldObjectContextMenu.onMedicalCheck, playerObj, fetch.clickedPlayer)
            if math.abs(playerObj:getX() - fetch.clickedPlayer:getX()) > 2 or math.abs(playerObj:getY() - fetch.clickedPlayer:getY()) > 2 then
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                option.notAvailable = true;
                tooltip.description = getText("ContextMenu_GetCloser", fetch.clickedPlayer:getDisplayName());
                option.toolTip = tooltip;
            end
        end

        -- clicked on a player, wakeUp
        if fetch.clickedPlayer and fetch.clickedPlayer ~= playerObj and fetch.clickedPlayer:isAsleep() and isDebugEnabled() then
            if test == true then return true; end
            local option = context:addGetUpOption(getText("ContextMenu_Wake_Other", fetch.clickedPlayer:getDisplayName()), worldobjects, ISWorldObjectContextMenu.onWakeOther, playerObj, fetch.clickedPlayer)
        end


    --    if fetch.clickedPlayer and playerObj:canSeePlayerStats() then
    --    context:addGetUpOption("Check Stats2", worldobjects, ISWorldObjectContextMenu.onCheckStats, playerObj, playerObj)
        if fetch.clickedPlayer and fetch.clickedPlayer ~= playerObj and not instanceof(fetch.clickedPlayer, "IsoAnimal") and isClient() and canSeePlayerStats() then
            if test == true then return true; end
            context:addGetUpOption("Check Stats", worldobjects, ISWorldObjectContextMenu.onCheckStats, playerObj, fetch.clickedPlayer)
        end

        if fetch.clickedPlayer and fetch.clickedPlayer ~= playerObj and not fetch.clickedPlayer:isAsleep() and not fetch.clickedPlayer:isAnimal() and isClient() then
            if (not ISTradingUI.instance or not ISTradingUI.instance:isVisible()) then
                local option = context:addGetUpOption(getText("ContextMenu_Trade", fetch.clickedPlayer:getDisplayName()), worldobjects, ISWorldObjectContextMenu.onTrade, playerObj, fetch.clickedPlayer)
                if math.abs(playerObj:getX() - fetch.clickedPlayer:getX()) > 2 or math.abs(playerObj:getY() - fetch.clickedPlayer:getY()) > 2 then
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    option.notAvailable = true;
                    tooltip.description = getText("ContextMenu_GetCloserToTrade", fetch.clickedPlayer:getDisplayName());
                    option.toolTip = tooltip;
                end
            end
        end

        -- cleaning blood
        if fetch.haveBlood and not playerObj:getVehicle()  then
            if test == true then return true; end
            local option = context:addGetUpOption(getText("ContextMenu_CleanStains"), worldobjects, ISWorldObjectContextMenu.onCleanBlood, fetch.haveBlood, player);
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("Tooltip_CleanStains")
            option.toolTip = tooltip;

        end
        if fetch.haveGraffiti and not playerObj:getVehicle()  then
            if test == true then return true; end
            local option = context:addGetUpOption(getText("ContextMenu_CleanGraffiti"), worldobjects, ISWorldObjectContextMenu.onCleanGraffiti, fetch.haveGraffiti, player);
            local tooltip = ISInventoryPaneContextMenu.addToolTip();
            tooltip.description = getText("Tooltip_CleanGraffiti")
            option.toolTip = tooltip;
        end

        -- cut little trees
        if fetch.canBeCut and not playerObj:getVehicle() then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_RemoveBush"), worldobjects, ISWorldObjectContextMenu.onRemovePlant, fetch.canBeCut, false, player);
        end
        -- remove grass
        if fetch.canBeRemoved and not playerObj:getVehicle() then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_RemoveGrass"), worldobjects, ISWorldObjectContextMenu.onRemoveGrass, fetch.canBeRemoved, player);
        end
        -- remove wall vine
        if fetch.wallVine and not playerObj:getVehicle() then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_RemoveWallVine"), worldobjects, ISWorldObjectContextMenu.onRemovePlant, fetch.wallVine, true, player);
        end

        if fetch.carBatteryCharger and ISWorldObjectContextMenu.handleCarBatteryCharger(test, context, worldobjects, playerObj, playerInv) then
            return true
        end

        -- generator interaction
        if fetch.generator and not playerObj:getVehicle() then
            local canDo = playerObj:getPerkLevel(Perks.Electricity) >=3 or playerObj:isRecipeActuallyKnown("Generator")
            if test == true then return true; end
            local option = context:addGetUpOption(getText("ContextMenu_GeneratorInfo"), worldobjects, ISWorldObjectContextMenu.onInfoGenerator, fetch.generator, player);
            if playerObj:DistToSquared(fetch.generator:getX() + 0.5, fetch.generator:getY() + 0.5) < 2 * 2 then
                local tooltip = ISWorldObjectContextMenu.addToolTip()
                tooltip:setName(getText("IGUI_Generator_TypeGas"))
                tooltip.description = ISGeneratorInfoWindow.getRichText(fetch.generator, true)
                option.toolTip = tooltip
            end
            if fetch.generator:isConnected() then
                if fetch.generator:isActivated() then
                    context:addGetUpOption(getText("ContextMenu_Turn_Off"), worldobjects, ISWorldObjectContextMenu.onActivateGenerator, false, fetch.generator, player);
                else
                    local option = context:addGetUpOption(getText("ContextMenu_GeneratorUnplug"), worldobjects, ISWorldObjectContextMenu.onPlugGenerator, fetch.generator, player, false);
                    if fetch.generator:getFuel() > 0 then
                        option = context:addGetUpOption(getText("ContextMenu_Turn_On"), worldobjects, ISWorldObjectContextMenu.onActivateGenerator, true, fetch.generator, player);
                        local doStats = playerObj:DistToSquared(fetch.generator:getX() + 0.5, fetch.generator:getY() + 0.5) < 2 * 2
                        local description = ISGeneratorInfoWindow.getRichText(fetch.generator, doStats)
                        if description ~= "" then
                            local tooltip = ISWorldObjectContextMenu.addToolTip()
                            tooltip:setName(getText("IGUI_Generator_TypeGas"))
                            tooltip.description = description
                            option.toolTip = tooltip
                        end
                    end
                end
            else
                -- print("Logic " .. tostring( playerObj:isRecipeKnown( playerObj:getPerkLevel(Perks.Electricity) >= 3 and not playerObj:isRecipeKnown("Generator") )))
                local option = context:addGetUpOption(getText("ContextMenu_GeneratorPlug"), worldobjects, ISWorldObjectContextMenu.onPlugGenerator, fetch.generator, player, true);
                if not canDo then
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    option.notAvailable = true;
                    tooltip.description = getText("ContextMenu_GeneratorPlugTT");
                    option.toolTip = tooltip;
                end
            end
            if not fetch.generator:isActivated() and fetch.generator:getFuel() < 100 and playerInv:containsEvalRecurse(predicatePetrol) then
                local petrolCan = playerInv:getFirstEvalRecurse(predicatePetrol);
                -- context:addGetUpOption(getText("ContextMenu_GeneratorAddFuel"), worldobjects, ISWorldObjectContextMenu.onAddFuelGenerator, petrolCan, fetch.generator, player, context);
                ISWorldObjectContextMenu.onAddFuelGenerator(worldobjects, petrolCan, fetch.generator, player, context)
            end
            if not fetch.generator:isActivated() and fetch.generator:getCondition() < 100 then
                local option = context:addGetUpOption(getText("ContextMenu_GeneratorFix"), worldobjects, ISWorldObjectContextMenu.onFixGenerator, fetch.generator, player);
                if not canDo then
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    option.notAvailable = true;
                    tooltip.description = getText("ContextMenu_GeneratorPlugTT");
                    option.toolTip = tooltip;
                end
                if not playerInv:containsTypeRecurse("ElectronicsScrap") then
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    option.notAvailable = true;
                    tooltip.description = getText("ContextMenu_GeneratorFixTT");
                    option.toolTip = tooltip;
                end
            end
            if not fetch.generator:isConnected() then
                context:addGetUpOption(getText("ContextMenu_GeneratorTake"), worldobjects, ISWorldObjectContextMenu.onTakeGenerator, fetch.generator, player);
            end
        end
    end

    -- safehouse
    if fetch.safehouse and fetch.safehouse:playerAllowed(playerObj) then
        if test == true then return true; end
        context:addOption(getText("ContextMenu_ViewSafehouse"), worldobjects, ISWorldObjectContextMenu.onViewSafeHouse, fetch.safehouse, playerObj);
    end
	-- add a note if the player is unable to interact with the safehouse
-- 	if fetch.safehouse  and (not fetch.safehouse:playerAllowed(playerObj)) and (not getServerOptions():getBoolean("SafehouseAllowLoot")) and (not isAdmin()) then
	if not fetch.safehouseAllowLoot then
        local nope = context:addOption(getText("ContextMenu_NoSafehousePermissionObjects"));
		nope.notAvailable = true;
        HaloTextHelper.addBadText(playerObj, getText("ContextMenu_NoSafehousePermissionObjects"));
--         HaloTextHelper.addText(playerObj, getText("ContextMenu_NoSafehousePermissionObjects"), getCore():getBadHighlitedColor());
    end
	
    if not fetch.safehouse and fetch.clickedSquare:getBuilding() and fetch.clickedSquare:getBuilding():getDef() then
        local reason = SafeHouse.canBeSafehouse(fetch.clickedSquare, playerObj);
        if reason then
            if test == true then return true; end
            local option = context:addOption(getText("ContextMenu_SafehouseClaim"), worldobjects, ISWorldObjectContextMenu.onTakeSafeHouse, fetch.clickedSquare, player);
            if reason ~= "" then
                local toolTip = ISWorldObjectContextMenu.addToolTip();
                toolTip:setVisible(false);
                toolTip.description = reason;
                option.notAvailable = true;
                option.toolTip = toolTip;
            end
        end
    end
--    elseif fetch.safehouse and fetch.safehouse:isOwner(playerObj) then
--        -- add players to the fetch.safehouse, check the other players around the chef
--        local playersList = {};
--        for x=playerObj:getX()-7,playerObj:getX()+7 do
--            for y=playerObj:getY()-7,playerObj:getY()+7 do
--                local square = getCell():getGridSquare(x,y,playerObj:getZ());
--                if square then
--                    for i=0,square:getMovingObjects():size()-1 do
--                        local moving = square:getMovingObjects():get(i);
--                        if instanceof(moving, "IsoPlayer") and moving ~= playerObj and not fetch.safehouse:getPlayers():contains(moving:getUsername()) then
--                            table.insert(playersList, moving);
--                        end
--                    end
--                end
--            end
--        end
--
--        if #playersList > 0 then
--            local addPlayerOption = context:addOption(getText("ContextMenu_SafehouseAddPlayer"), worldobjects, nil)
--            local subMenu = ISContextMenu:getNew(context)
--            context:addSubMenu(addPlayerOption, subMenu)
--            for i,v in ipairs(playersList) do
--                subMenu:addOption(v:getUsername(), worldobjects, ISWorldObjectContextMenu.onAddPlayerToSafehouse, fetch.safehouse, v);
--            end
--        end
--
--        if fetch.safehouse:getPlayers():size() > 1 then
--            local removePlayerOption = context:addOption(getText("ContextMenu_SafehouseRemovePlayer"), worldobjects, nil)
--            local subMenu2 = ISContextMenu:getNew(context)
--            context:addSubMenu(removePlayerOption, subMenu2)
--            for i=0,fetch.safehouse:getPlayers():size()-1 do
--                local playerName = fetch.safehouse:getPlayers():get(i)
--                if fetch.safehouse:getPlayers():get(i) ~= fetch.safehouse:getOwner() then
--                    subMenu2:addOption(playerName, worldobjects, ISWorldObjectContextMenu.onRemovePlayerFromSafehouse, fetch.safehouse, playerName, player);
--                end
--            end
--        end


--        context:addOption(getText("ContextMenu_SafehouseRelease"), worldobjects, ISWorldObjectContextMenu.onReleaseSafeHouse, fetch.safehouse, player);
--    end

    if fetch.safehouseAllowInteract then

        if #fetch.clickedAnimals > 0 then
            triggerEvent("OnClickedAnimalForContext", player, context, fetch.clickedAnimals, test);
            --		return;
        end

        if fetch.firetile and fetch.extinguisher then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_ExtinguishFire"), worldobjects, ISWorldObjectContextMenu.onRemoveFire, fetch.firetile, fetch.extinguisher, playerObj);
        end

        if fetch.compost and ISWorldObjectContextMenu.handleCompost(test, context, worldobjects, playerObj, playerInv) then
            return true
        end

        if fetch.animaltrack then
            ISAnimalTracksMenu.handleIsoTracks(context, fetch.animaltrack, playerObj);
        end

        -- walk to
        if JoypadState.players[player+1] == nil and not playerObj:getVehicle() then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_Walk_to"), worldobjects, ISWorldObjectContextMenu.onWalkTo, fetch.item, player);
        end

        local scythe = playerInv:getFirstEvalRecurse(predicateScythe);
        if scythe and not playerObj:getVehicle() then
            if test == true then return true; end
            context:addGetUpOption(getText("ContextMenu_ScytheGrass"), playerObj, ISWorldObjectContextMenu.onScytheGrass, scythe);
        end
    end

	if SafeHouse.isSafehouseAllowClaim(fetch.safehouse, playerObj) then
		context:addOption(getText("ContextMenu_WarClaim"), worldobjects, ISWorldObjectContextMenu.onClaimWar, fetch.safehouse:getOnlineID(), playerObj:getUsername());
	end

	if fetch.animalZone then
		AnimalContextMenu.doDesignationZoneMenu(context, fetch.animalZone, playerObj);
	end
	
	-- RJ: Moved to health panel
--	local doFitness = true;
--	if ISFitnessUI.instance and ISFitnessUI.instance[player+1] and ISFitnessUI.instance[player+1]:isVisible() then
--		doFitness = false;
--	end
--	if doFitness then
--		local option = context:addOption(getText("ContextMenu_Fitness"), worldobjects, ISWorldObjectContextMenu.onFitness, playerObj);
--	end
    
    if not playerObj:getVehicle() and not playerObj:isSitOnGround() and not playerObj:isSittingOnFurniture() then
        if test == true then return true; end
        if fetch.safehouseAllowInteract then
			context:addOption(getText("ContextMenu_SitGround"), player, ISWorldObjectContextMenu.onSitOnGround);
        end
    end

	return false;
    end

function ISWorldObjectContextMenu.getSquaresInRadius(worldX, worldY, worldZ, radius, doneSquares, squares)
	local minX = math.floor(worldX - radius)
	local maxX = math.ceil(worldX + radius)
	local minY = math.floor(worldY - radius)
	local maxY = math.ceil(worldY + radius)
	for y = minY,maxY do
		for x = minX,maxX do
			local square = getCell():getGridSquare(x, y, worldZ)
			if square and not doneSquares[square] then
				doneSquares[square] = true
				table.insert(squares, square)
			end
		end
	end
end

function ISWorldObjectContextMenu.getWorldObjectsInRadius(playerNum, screenX, screenY, squares, radius, worldObjects)
	radius = 48 / getCore():getZoom(playerNum)
	for _,square in ipairs(squares) do
		local squareObjects = square:getWorldObjects()
		for i=1,squareObjects:size() do
			local worldObject = squareObjects:get(i-1)
			local dist = IsoUtils.DistanceToSquared(screenX, screenY,
				worldObject:getScreenPosX(playerNum), worldObject:getScreenPosY(playerNum))
			if dist <= radius * radius then
				table.insert(worldObjects, worldObject)
			end
		end
	end
end

function ISWorldObjectContextMenu.handleInteraction(x, y, test, context, worldobjects, playerObj, playerInv)
	if getCore():getGameMode() == "LastStand" then return false end -- FIXME: Why?
	if test == true then return true; end

	local playerNum = playerObj:getPlayerNum()
	local player = playerNum

	local squares = {}
	local doneSquare = {}
	for i,v in ipairs(worldobjects) do
		if v:getSquare() and not doneSquare[v:getSquare()] then
			doneSquare[v:getSquare()] = true
			table.insert(squares, v:getSquare())
		end
	end

	if #squares == 0 then return false end

	local worldObjects = {}
	if JoypadState.players[playerNum+1] then
		for _,square in ipairs(squares) do
			for i=1,square:getWorldObjects():size() do
				local worldObject = square:getWorldObjects():get(i-1)
				table.insert(worldObjects, worldObject)
			end
		end
	else
		local squares2 = {}
		for k,v in pairs(squares) do
			squares2[k] = v
		end
		local radius = 1
		for _,square in ipairs(squares2) do
			local worldX = screenToIsoX(playerNum, x, y, square:getZ())
			local worldY = screenToIsoY(playerNum, x, y, square:getZ())
			ISWorldObjectContextMenu.getSquaresInRadius(worldX, worldY, square:getZ(), radius, doneSquare, squares)
		end
		ISWorldObjectContextMenu.getWorldObjectsInRadius(playerNum, x, y, squares, radius, worldObjects)
	end

	if #worldObjects == 0 then return false end

	local itemList = {}
	for _,worldObject in ipairs(worldObjects) do
		local itemName = worldObject:getName() or (worldObject:getItem():getName() or "???")
		if not itemList[itemName] then itemList[itemName] = {} end
		table.insert(itemList[itemName], worldObject)
	end

	for name,items in pairs(itemList) do
		local _item = items[1]:getItem()
		local square = items[1]:getSquare()
		if instanceof(_item, "Radio")  then
			local _obj = nil
			for i=0, square:getObjects():size()-1 do
				local tObj = square:getObjects():get(i)
				if instanceof(tObj, "IsoRadio") then
					if tObj:getModData().RadioItemID == _item:getID() then
						_obj = tObj
						break
					end
				end
			end
			if _obj ~= nil then
				context:addGetUpOption(getText("IGUI_DeviceOptions"), playerObj, function(pl, obj) ISRadioWindow.activate(pl, obj, true) end, _obj );
			end
		end
	end
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

function ISWorldObjectContextMenu.handleGrabWorldItem(x, y, test, context, worldobjects, playerObj, playerInv)
	local fetch = ISWorldObjectContextMenu.fetchVars
--	if not worldItem then return false end
	if playerObj:getVehicle() ~= nil then return end --prevent the player from picking world objects up if they're in a vehicle
	if getCore():getGameMode() == "LastStand" then return false end -- FIXME: Why?
	if test == true then return true; end
	local playerNum = playerObj:getPlayerNum()
	local player = playerNum

	if playerObj:isGrappling() then
		local dropCorpseOption = context:addOption(getText("ContextMenu_Drop_Corpse"), worldobjects, function()
			playerObj:setDoContinueGrapple(false)
		end)
		local toolTip = ISWorldObjectContextMenu.addToolTip()
		toolTip.description = getText("Tooltip_GrappleCorpse")
		dropCorpseOption.toolTip = toolTip
	end

	local squares = {}
	local doneSquare = {}
	for i,v in ipairs(worldobjects) do
		if v:getSquare() and not doneSquare[v:getSquare()] then
			doneSquare[v:getSquare()] = true
			table.insert(squares, v:getSquare())
		end
	end

	if #squares == 0 then return false end

	local worldObjects = {}
	if JoypadState.players[playerNum+1] then
		for _,square in ipairs(squares) do
			for i=1,square:getWorldObjects():size() do
				local worldObject = square:getWorldObjects():get(i-1)
				table.insert(worldObjects, worldObject)
			end
		end
	else
		local squares2 = {}
		for k,v in pairs(squares) do
			squares2[k] = v
		end
		local radius = 1
		for _,square in ipairs(squares2) do
			local worldX = screenToIsoX(playerNum, x, y, square:getZ())
			local worldY = screenToIsoY(playerNum, x, y, square:getZ())
			ISWorldObjectContextMenu.getSquaresInRadius(worldX, worldY, square:getZ(), radius, doneSquare, squares)
		end
		ISWorldObjectContextMenu.getWorldObjectsInRadius(playerNum, x, y, squares, radius, worldObjects)
	end

	local bodyItem = fetch.body and not fetch.body:isAnimal() and not playerObj:getVehicle() and playerInv:getItemCount("Base.CorpseMale") == 0
	if #worldObjects == 0 and not bodyItem then return false end

	local itemList = {}
	for _,worldObject in ipairs(worldObjects) do
		local itemName = worldObject:getName() or (worldObject:getItem():getName() or "???")
		if instanceof(worldObject, "IsoWorldInventoryObject") then
			itemName = worldObject:getItem():getName();
		end
		if not itemList[itemName] then itemList[itemName] = {} end
		table.insert(itemList[itemName], worldObject)
	end

	local expendedPlacementItems = {};
	local addedExpended = false;

	local grabOption = context:addOption(getText("ContextMenu_Grab"), worldobjects, nil)
	local subMenuGrab = ISContextMenu:getNew(context)
	context:addSubMenu(grabOption, subMenuGrab)
	for name,items in pairs(itemList) do
		if items[1] and items[1]:getSquare() and items[1]:getSquare():isWallTo(playerObj:getSquare()) then
			context:removeLastOption();
			break;
		end
		if items[1] and items[1]:getItem() and (items[1]:getItem():getWorldStaticItem() or items[1]:getItem():getClothingItem() or items[1]:getItem():getWorldStaticItem() or instanceof(items[1]:getItem(), "HandWeapon")) then
			expendedPlacementItems[name] = items;
			addedExpended = true;
		end
		if #items > 1 then
			name = name..' ('..#items..')'
		end
		if #items > 2 then
			local itemOption = subMenuGrab:addOption(name, worldobjects, nil)
			itemOption.onHighlightParams = { items }
			itemOption.onHighlight = function(_option, _menu, _isHighlighted, _objects)
				for _,object in ipairs(_objects) do
					object:setHighlighted(_menu.player, _isHighlighted, false)
					ISInventoryPage.OnObjectHighlighted(_menu.player, object, _isHighlighted)
				end
			end
			local subMenuItem = ISContextMenu:getNew(subMenuGrab)
			subMenuGrab:addSubMenu(itemOption, subMenuItem)
			subMenuItem:addOption(getText("ContextMenu_Grab_one"), worldobjects, ISWorldObjectContextMenu.onGrabWItem, items[1], player);
			subMenuItem:addOption(getText("ContextMenu_Grab_half"), worldobjects, ISWorldObjectContextMenu.onGrabHalfWItems, items, player);
			subMenuItem:addOption(getText("ContextMenu_Grab_all"), worldobjects, ISWorldObjectContextMenu.onGrabAllWItems, items, player);
		elseif #items > 1 and items[1]:getItem():getActualWeight() >= 3 then
			local itemOption = subMenuGrab:addOption(name, worldobjects, nil)
			local subMenuItem = ISContextMenu:getNew(subMenuGrab)
			subMenuGrab:addSubMenu(itemOption, subMenuItem)
			subMenuItem:addOption(getText("ContextMenu_Grab_one"), worldobjects, ISWorldObjectContextMenu.onGrabWItem, items[1], player);
			subMenuItem:addOption(getText("ContextMenu_Grab_all"), worldobjects, ISWorldObjectContextMenu.onGrabAllWItems, items, player);
		else
			local option = subMenuGrab:addOption(name, worldobjects, ISWorldObjectContextMenu.onGrabAllWItems, items, player)
			option.itemForTexture = items[1]:getItem()
            option.onHighlightParams = { items[1] }
            option.onHighlight = function(_option, _menu, _isHighlighted, _object)
                _object:setHighlighted(_menu.player, _isHighlighted, false)
                ISInventoryPage.OnObjectHighlighted(_menu.player, _object, _isHighlighted)
            end
		end
	end
    if getJoypadData(playerNum) then addedExpended = false end -- TODO
	if addedExpended then
		local extendedPlacementOption = context:addOption(getText("ContextMenu_ExtendedPlacement"))
		local subMenuPlacement = ISContextMenu:getNew(context)
		context:addSubMenu(extendedPlacementOption, subMenuPlacement)
		local namesSorted = {}
		for name,items in pairs(expendedPlacementItems) do
			table.insert(namesSorted, name)
		end
		table.sort(namesSorted, function(a, b) return not string.sort(a, b) end)
		for _,name in ipairs(namesSorted) do
			local items = expendedPlacementItems[name]
			local subMenu = subMenuPlacement
			if #items > 2 and #namesSorted > 1 then
				local subMenuOption = subMenuPlacement:addOption(name, worldobjects, nil)
				subMenuOption.itemForTexture = items[1]:getItem()
				subMenuOption.onHighlightParams = { items }
				subMenuOption.onHighlight = function(_option, _menu, _isHighlighted, _objects)
					for _,object in ipairs(_objects) do
						object:setHighlighted(_menu.player, _isHighlighted, false)
						ISInventoryPage.OnObjectHighlighted(_menu.player, object, _isHighlighted)
					end
				end
				subMenu = ISContextMenu:getNew(subMenuPlacement)
				subMenuPlacement:addSubMenu(subMenuOption, subMenu)
			end
			for _,item in ipairs(items) do
				local option = subMenu:addOption(name, item, ISWorldObjectContextMenu.onExtendedPlacement, playerObj)
				option.itemForTexture = item:getItem()
				option.onHighlightParams = { item }
				option.onHighlight = function(_option, _menu, _isHighlighted, _object)
					_object:setHighlighted(_menu.player, _isHighlighted, false)
					ISInventoryPage.OnObjectHighlighted(_menu.player, _object, _isHighlighted)
				end
			end
		end
	end
	if ISWorldObjectContextMenu.handleGrabCorpseSubmenu(playerObj, worldobjects, subMenuGrab) then
		return true
	end
	return false
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

-- Pour water from an item in inventory into an IsoObject
function ISWorldObjectContextMenu.addFluidFromItem(test, context, pourFluidInto, worldobjects, playerObj, playerInv)
	local fetch = ISWorldObjectContextMenu.fetchVars
	if not pourFluidInto then
		return
	end

	if pourFluidInto:isFluidInputLocked() then
		return
	end
	
	local pourOut = {}
	for i = 1,playerInv:getItems():size() do
		local item = playerInv:getItems():get(i-1)
		if item:canStoreWater() and pourFluidInto:canTransferFluidFrom(item:getFluidContainer()) and item:getFluidContainer():canPlayerEmpty() then
			table.insert(pourOut, item)
		end
	end

	if #pourOut > 0 and not test then
		if pourFluidInto:getFluidAmount() < pourFluidInto:getFluidCapacity() then
			local subMenuOption = context:addOption(getText("ContextMenu_AddFluidFromItem"), worldobjects, nil);
			local subMenu = context:getNew(context)
			context:addSubMenu(subMenuOption, subMenu)
			for _,item in ipairs(pourOut) do
				local subOption = subMenu:addOption(item:getName(), worldobjects, ISWorldObjectContextMenu.onAddFluidFromItem, pourFluidInto, item, playerObj);
				if item:IsDrainable() then
					local tooltip = ISWorldObjectContextMenu.addToolTip()
					local tx = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
					tooltip.description = string.format("%s: <SETX:%d> %d / %d",
							getText("ContextMenu_WaterName"), tx, item:getCurrentUses(), 1.0 / item:getUseDelta() + 0.0001)
					if item:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
						tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
					end
					subOption.toolTip = tooltip
				end
			end
		end
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

function ISWorldObjectContextMenu.getFishCheckTooltip(mx, my, square, player)
	local x = screenToIsoX(player:getPlayerNum(), mx, my, square:getZ())
	local y = screenToIsoY(player:getPlayerNum(), mx, my, square:getZ())

	local description = ""

	local abundanceText = ""
	local trashAbundance = FishSchoolManager.getInstance():getTrashAbundance(x, y)
	if trashAbundance < 0.1 then
		abundanceText = getText("Tooltip_fish_abundance_Low")
	elseif trashAbundance < 0.4 then
		abundanceText = getText("Tooltip_fish_abundance_Normal")
	else
		abundanceText = getText("Tooltip_fish_abundance_High")
	end
	description = description .. getText("Tooltip_trash_abundance") .. ": " .. abundanceText .. " \n "

	local fishAbundance = FishSchoolManager.getInstance():getFishAbundance(x, y)

	if fishAbundance == 0 then
		abundanceText = getText("Tooltip_fish_abundance_None")
	elseif fishAbundance <= 5 then
		abundanceText = getText("Tooltip_fish_abundance_Low")
	elseif fishAbundance <= 10 then
		abundanceText = getText("Tooltip_fish_abundance_Normal")
	elseif fishAbundance <= 15 then
		abundanceText = getText("Tooltip_fish_abundance_High")
	elseif fishAbundance <= 25 then
		abundanceText = getText("Tooltip_fish_abundance_VeryHigh")
	else
		abundanceText = getText("Tooltip_fish_abundance_Insane")
	end
	description = description .. getText("Tooltip_fish_abundance") .. ": " .. abundanceText .. " \n "

	------
	local numberOfFishCoeff = 1
	if fishAbundance == 0 then
		numberOfFishCoeff = 0
	elseif fishAbundance < 10 then
		numberOfFishCoeff = 0.5
	elseif fishAbundance <= 25 then
		numberOfFishCoeff = 1.0
	else
		numberOfFishCoeff = 1.5
	end

	local temperature = getClimateManager():getAirTemperatureForCharacter(player, false)
	local temperatureCoeff = 1
	if temperature >= 30 and temperature < 40 or temperature >= 0 and temperature < 15 then
		temperatureCoeff = 0.75
	elseif temperature >= 40 or temperature > -10 and temperature < 0 then
		temperatureCoeff = 0.5
	elseif temperature <= -10 then
		temperatureCoeff = 0.25
	end

	local weatherCoeff = 1
	if getClimateManager():getFogIntensity() >= 0.4 or getClimateManager():getWindPower() >= 0.5 then
		weatherCoeff = 0.8
	elseif RainManager.isRaining() then
		weatherCoeff = 1.2
	end

	local currentHour = math.floor(math.floor(GameTime.getInstance():getTimeOfDay() * 3600) / 3600);
	local timeCoeff = 1
	if (currentHour >= 4 and currentHour <= 6) or (currentHour >= 18 and currentHour <= 20) then
		timeCoeff = 1.2
	end

	local nibbleChance = 1 * numberOfFishCoeff * temperatureCoeff * weatherCoeff * timeCoeff * 100
	if nibbleChance == 0 then
		abundanceText = getText("Tooltip_fish_abundance_None")
	elseif nibbleChance < 40 then
		abundanceText = getText("Tooltip_fish_abundance_Low")
	elseif nibbleChance < 65 then
		abundanceText = getText("Tooltip_fish_abundance_Normal")
	elseif nibbleChance < 80 then
		abundanceText = getText("Tooltip_fish_abundance_High")
	else
		abundanceText = getText("Tooltip_fish_abundance_VeryHigh")
	end


	description = description .. getText("Tooltip_fish_nibbleChance") .. ": " .. abundanceText .. " \n "
	------
	if getCore():getDebug() then
		description = description .. "\nDEBUG: \n"
		description = description .. "Fish num: " .. fishAbundance .. " \n "
		description = description .. "Trash abundance: " .. math.floor(trashAbundance*100) .. "% \n "
		description = description .. "Time coeff: " .. timeCoeff .. " \n "
		description = description .. "Weather coeff: " .. weatherCoeff .. " \n "
		description = description .. "Temperature coeff: " .. temperatureCoeff .. " \n "
	end

	------
	local tooltip = ISWorldObjectContextMenu.addToolTip()
	tooltip:setName(getText("Tooltip_fishing_info"))
	tooltip.description = description
	return tooltip
end

function ISWorldObjectContextMenu.getChum(playerObj)
	return playerObj:getInventory():getAllTypeRecurse("Base.Chum")
end

function ISWorldObjectContextMenu.doChumOptions(context, playerObj, square)
	local option = context:addOption(getText("ContextMenu_AddChum"))
	local submenu = context:getNew(context)
	context:addSubMenu(option, submenu)

	local chumItems = ISWorldObjectContextMenu.getChum(playerObj)
	for i = 0, chumItems:size()-1 do
		local item = chumItems:get(i)
		submenu:addGetUpOption(item:getDisplayName(), playerObj, ISWorldObjectContextMenu.onAddBaitToWater, item, square)
	end
end

function ISWorldObjectContextMenu.doCreateChumOptions_makeChum(pl, square)
	if luautils.walkAdj(pl, square) then
		ISTimedActionQueue.add(CreateChumFromGroundSandAction:new(pl, square))
	end
end

function ISWorldObjectContextMenu.doCreateChumOptions(context, playerObj, square)
	context:addGetUpOption(getText("ContextMenu_MakeChum"), playerObj, function(pl, square)
		if luautils.walkAdj(playerObj, square) then
			ISTimedActionQueue.add(CreateChumFromGroundSandAction:new(pl, square))
		end
	end, square)
end

function ISWorldObjectContextMenu.doFishNetOptions(context, playerObj, square)
	local fishNetOption = context:addOption(getText("ContextMenu_Place_Fishing_Net"))
	local isNotAvailable = false
	if square:DistToProper(playerObj:getCurrentSquare()) >= 5 then
		isNotAvailable = true;
	end

	local subMenuFishNet = ISContextMenu:getNew(context)
	context:addSubMenu(fishNetOption, subMenuFishNet)
	local nets = playerObj:getInventory():getAllTypeEval("Base.FishingNet", function(_) return true end)
	for k = 0, nets:size()-1 do
		local option = subMenuFishNet:addGetUpOption(nets:get(k):getDisplayName(), nil, ISWorldObjectContextMenu.onFishingNet, playerObj, nets:get(k))
		option.notAvailable = isNotAvailable
	end
end

function ISWorldObjectContextMenu.doPlacedFishNetOptions(context, playerObj, trapFish)
	if trapFish:getSquare():getModData()["fishingNetTS"] then
		local hourElapsed = math.floor(((getGameTime():getCalender():getTimeInMillis() - trapFish:getSquare():getModData()["fishingNetTS"]) / 60000) / 60);
		if hourElapsed > 0 then
			local suboption = context:addGetUpOption(getText("ContextMenu_Check_Trap"), nil, ISWorldObjectContextMenu.onCheckFishingNet, playerObj, trapFish, hourElapsed);
			if trapFish:getSquare():DistToProper(playerObj:getSquare()) >= 5 then
				suboption.notAvailable = true;
			end
		end
	end

	local suboption = context:addGetUpOption(getText("ContextMenu_Remove_Trap"), nil, ISWorldObjectContextMenu.onRemoveFishingNet, playerObj, trapFish);
	if trapFish:getSquare():DistToProper(playerObj:getSquare()) >= 5 then
		suboption.notAvailable = true;
	end

	if trapFish:getSquare():getModData()["fishingNetBait"] == nil then
		local isNotAvailable = false
		if trapFish:getSquare():DistToProper(playerObj:getSquare()) >= 5 then
			isNotAvailable = true;
		end
		suboption = context:addOption(getText("ContextMenu_Add_Bait"))
		local subMenu = context:getNew(context)
		context:addSubMenu(suboption, subMenu)

		local items = playerObj:getInventory():getAllEvalRecurse(function(_item) return _item:getFullType() == "Base.Chum" end, ArrayList.new())
		for i = 0, items:size()-1 do
			local item = items:get(i)
			local opt2 = subMenu:addGetUpOption(item:getName(), nil, ISWorldObjectContextMenu.onAddBaitToFishingNet, playerObj, trapFish, item)
			opt2.notAvailable = isNotAvailable
		end
		if items:size() == 0 then
			suboption.notAvailable = true
			suboption.toolTip = ISWorldObjectContextMenu.addToolTip()
			suboption.toolTip.description = getText("Tooltip_NeedChumForAddToFishingNet")
		end
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

function ISWorldObjectContextMenu.handleRainCollector(test, context, worldobjects, playerObj, playerInv)
	local rainCollectorBarrel = ISWorldObjectContextMenu.fetchVars.rainCollectorBarrel
	if rainCollectorBarrel and rainCollectorBarrel:getSquare():getBuilding() ~= playerObj:getBuilding() then return end;
	if rainCollectorBarrel and playerObj:DistToSquared(rainCollectorBarrel:getX() + 0.5, rainCollectorBarrel:getY() + 0.5) < 2 * 2 then
		if test == true then return true; end
		local option = nil
		if rainCollectorBarrel:hasFluid() then
			local subMenu = context:getNew(context)
			local subOption = context:addGetUpOption(getText("ContextMenu_Rain_Collector_Barrel"))
			context:addSubMenu(subOption, subMenu)
			local option2 = subMenu:addGetUpOption(getText("ContextMenu_Pour_on_Ground"), rainCollectorBarrel, ISWorldObjectContextMenu.emptyRainCollector, playerObj)
			option = subOption
		else
			option = context:addOption(getText("ContextMenu_Rain_Collector_Barrel"), worldobjects, nil)
		end
		local tooltip = ISWorldObjectContextMenu.addToolTip()
		tooltip:setName(getText("ContextMenu_Rain_Collector_Barrel"))
		local tx = getTextManager():MeasureStringX(tooltip.font, getText("ContextMenu_WaterName") .. ":") + 20
		tooltip.description = string.format("%s: <SETX:%d> %d / %d", getText("ContextMenu_WaterName"), tx, rainCollectorBarrel:getFluidAmount(), rainCollectorBarrel:getFluidCapacity())
		if rainCollectorBarrel:isTaintedWater() and getSandboxOptions():getOptionByName("EnableTaintedWaterText"):getValue() then
			tooltip.description = tooltip.description .. " <BR> <RGB:1,0.5,0.5> " .. getText("Tooltip_item_TaintedWater")
		end
		tooltip.maxLineWidth = 512
		option.toolTip = tooltip
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

ISWorldObjectContextMenu.onTeleport = function()
	if isClient() then
		SendCommandToServer("/teleportto " .. tostring(2727) .. "," .. tostring(13257) .. ",0");
	else
		getPlayer():teleportTo(2727, 13257, 0.0)
	end
end

ISWorldObjectContextMenu.onAddPlayerToSafehouse = function(worldobjects, safehouse, player)
    safehouse:addPlayer(player:getUsername());
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

ISWorldObjectContextMenu.onRemovePlayerFromSafehouse = function(worldobjects, safehouse, playerName, playerNum)
    -- Don't remove players close to the safehouse, they'll get trapped inside.
    local players = getOnlinePlayers()
    for i=1,players:size() do
        local player = players:get(i-1)
        if player:getUsername() == playerName then
            if player:getX() >= safehouse:getX() - 10 and player:getX() < safehouse:getX2() + 10 and
                    player:getY() >= safehouse:getY() - 10 and player:getY() < safehouse:getY2() + 10 then
                local modal = ISModalRichText:new(0, 0, 230, 90, getText("ContextMenu_RemovePlayerFailed"), false, nil, nil, playerNum)
                modal:initialise()
                modal:addToUIManager()
                if JoypadState.players[playerNum+1] then
                    JoypadState.players[playerNum+1].focus = modal
                end
                return
            end
        end
    end
    safehouse:removePlayer(playerName)
end

ISWorldObjectContextMenu.onReleaseSafeHouse = function(worldobjects, safehouse, player)
	sendSafehouseRelease(safehouse)
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

ISWorldObjectContextMenu.onTakeFuel = function(worldobjects, playerObj, fuelStation)
	-- Prefer an equipped PetrolCanEmpty/PetrolCan, then the fullest PetrolCan, then any PetrolCanEmpty.
	local petrolCan = nil
	local equipped = playerObj:getPrimaryHandItem()
	if equipped and predicatePetrolNotFull(equipped) then
		petrolCan = equipped
	elseif equipped and predicateEmptyPetrol(equipped) then
		petrolCan = equipped
	end
	if not petrolCan then
		local cans = playerObj:getInventory():getAllEvalRecurse(predicatePetrolNotFull)
		local usedDelta = -1
		for i=1,cans:size() do
			local petrolCan2 = cans:get(i-1)
			if petrolCan2:getCurrentUsesFloat() < 1 and petrolCan2:getCurrentUsesFloat() > usedDelta then
				petrolCan = petrolCan2
				usedDelta = petrolCan:getCurrentUsesFloat()
			end
		end
	end
	if not petrolCan then
		petrolCan = playerObj:getInventory():getFirstEvalRecurse(predicateEmptyPetrol)
	end
	if petrolCan and luautils.walkAdj(playerObj, fuelStation:getSquare()) then
		ISInventoryPaneContextMenu.equipWeapon(petrolCan, false, false, playerObj:getPlayerNum())
		ISTimedActionQueue.add(ISTakeFuel:new(playerObj, fuelStation, petrolCan))
	end
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

ISWorldObjectContextMenu.onAddFuel = function(worldobjects, petrolCan, generator, player)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, generator:getSquare()) then
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), petrolCan, true, false);
		ISTimedActionQueue.add(ISAddFuel:new(playerObj, generator, petrolCan));
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

ISWorldObjectContextMenu.onFishing = function(worldobjects, player)
	if ISFishingUI.instance and ISFishingUI.instance[player:getPlayerNum()+1] then
		ISFishingUI.instance[player:getPlayerNum()+1]:removeFromUIManager();
	end
	local modal = ISFishingUI:new(0,0, 450, 270, player, worldobjects[1]);
	modal:initialise()
	modal:addToUIManager()
	if JoypadState.players[player:getPlayerNum()+1] then
		setJoypadFocus(player:getPlayerNum(), modal)
	end
end

--[[
ISWorldObjectContextMenu.onFitness = function(worldobjects, player)
	if ISFitnessUI.instance and ISFitnessUI.instance[player:getPlayerNum()+1] then
		ISFitnessUI.instance[player:getPlayerNum()+1]:removeFromUIManager();
	end
	if ISFitnessUI.instance and ISFitnessUI.instance[player:getPlayerNum()+1] and ISFitnessUI.instance[player:getPlayerNum()+1]:isVisible() then
		return;
	end
	local modal = ISFitnessUI:new(0,0, 600, 350, player);
	modal:initialise()
	modal:addToUIManager()
	if JoypadState.players[player:getPlayerNum()+1] then
		setJoypadFocus(player:getPlayerNum(), modal)
	end
end
--]]

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

ISWorldObjectContextMenu.getFishingRode = function(playerObj)
    local handItem = playerObj:getPrimaryHandItem()
    if handItem and predicateFishingRodOrSpear(handItem, playerObj) then
        return handItem
    end
    return playerObj:getInventory():getFirstEvalArgRecurse(predicateFishingRodOrSpear, playerObj)
end

ISWorldObjectContextMenu.onDestroy = function(worldobjects, player, sledgehammer)
	local bo = ISDestroyCursor:new(player, false, sledgehammer)
	getCell():setDrag(bo, bo.player)
end

-- maps object:getName() -> translated label
local ThumpableNameToLabel = {
	["Bar"] = "ContextMenu_Bar",
	["Barbed Fence"] = "ContextMenu_Barbed_Fence",
	["Bed"] = "ContextMenu_Bed",
	["Bookcase"] = "ContextMenu_Bookcase",
	["Double Shelves"] = "ContextMenu_DoubleShelves",
	["Gravel Bag Wall"] = "ContextMenu_Gravel_Bag_Wall",
	["Lamp on Pillar"] = "ContextMenu_Lamp_on_Pillar",
	["Large Table"] = "ContextMenu_Large_Table",
	["Log Wall"] = "ContextMenu_Log_Wall",
	["Rain Collector Barrel"] = "ContextMenu_Rain_Collector_Barrel",
	["Sand Bag Wall"] = "ContextMenu_Sang_Bag_Wall",
	["Shelves"] = "ContextMenu_Shelves",
	["Small Bookcase"] = "ContextMenu_SmallBookcase",
	["Small Table"] = "ContextMenu_Small_Table",
	["Small Table with Drawer"] = "ContextMenu_Table_with_Drawer",
	["Window Frame"] = "ContextMenu_Windows_Frame",
	["Wooden Crate"] = "ContextMenu_Wooden_Crate",
	["Wooden Door"] = "ContextMenu_Door",
	["Wooden Fence"] = "ContextMenu_Wooden_Fence",
	["Wooden Stairs"] = "ContextMenu_Stairs",
	["Wooden Stake"] = "ContextMenu_Wooden_Stake",
	["Wooden Wall"] = "ContextMenu_Wooden_Wall",
	["Wooden Pillar"] = "ContextMenu_Wooden_Pillar",
	["Wooden Chair"] = "ContextMenu_Wooden_Chair",
	["Wooden Stairs"] = "ContextMenu_Stairs",
	["Wooden Sign"] = "ContextMenu_Sign",
	["Wooden Door Frame"] = "ContextMenu_Door_Frame",
}

function ISWorldObjectContextMenu.getThumpableName(thump)
	if ThumpableNameToLabel[thump:getName()] then
		return getText(ThumpableNameToLabel[thump:getName()])
	end
	return thump:getName()
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

function ISWorldObjectContextMenu:onSleepModalClick(button)
--	if JoypadState.players[ISContextMenu.globalPlayerContext+1] then
--		JoypadState.players[ISContextMenu.globalPlayerContext+1].focus = nil;
--		updateJoypadFocus(JoypadState.players[ISContextMenu.globalPlayerContext+1]);
--	end
	if JoypadState.players[1] then
		JoypadState.players[1].focus = nil
		updateJoypadFocus(JoypadState.players[1])
	end
end

ISWorldObjectContextMenu.canStoreWater = function(object)
	-- check water shut off sandbox option
	-- if it's -1, the water have been shuted instant
	if SandboxVars.WaterShutModifier < 0 and (object:getSprite() and object:getSprite():getProperties() and object:getSprite():getProperties():Is(IsoFlagType.waterPiped)) then
		return nil;
    end
	if object ~= nil and instanceof(object, "IsoObject") and object:getSprite() and object:getSprite():getProperties() and
	(((object:getSprite():getProperties():Is(IsoFlagType.waterPiped)) and (getGameTime():getWorldAgeHours() / 24 + (getSandboxOptions():getTimeSinceApo() - 1) * 30) < SandboxVars.WaterShutModifier) or object:hasFluid()) and not instanceof(object, "IsoRaindrop") then
		return object;
    end
	-- we also check the square properties
	if object ~= nil and instanceof(object, "IsoObject") and object:getSquare() and object:getSquare():getProperties() and
	(((object:getSquare():getProperties():Is(IsoFlagType.waterPiped)) and (getGameTime():getWorldAgeHours() / 24 + (getSandboxOptions():getTimeSinceApo() - 1) * 30) < SandboxVars.WaterShutModifier) or object:getSquare():hasWater()) and not instanceof(object, "IsoRaindrop") then
		return object;
    end
end

ISWorldObjectContextMenu.haveWaterContainer = function(playerId)
	for i = 0, getSpecificPlayer(playerId):getInventory():getItems():size() -1 do
		local item = getSpecificPlayer(playerId):getInventory():getItems():get(i);
		-- our item can store water, but doesn't have water right now
		if item:canStoreWater() and not item:isWaterSource() then
			return item;
		end
		-- or our item can store water and is not full
		if item:canStoreWater() and item:isWaterSource() and instanceof(item, "DrainableComboItem") and item:getCurrentUsesFloat() < 1 then
			return item;
		end
	end
	return nil;
end

function ISWorldObjectContextMenu.toggleClothingDryer(context, playerId, object)
	local playerObj = getSpecificPlayer(playerId)

	if not object then return end
	if not object:getContainer() then return end
	if ISWorldObjectContextMenu.isSomethingTo(object, playerId) then return end
	if getCore():getGameMode() == "LastStand" then return end

	local option = nil
	if object:isActivated() then
		option = context:addGetUpOption(getText("ContextMenu_Turn_Off"), worldobjects, ISWorldObjectContextMenu.onToggleClothingDryer, object, playerId)
	else
		option = context:addGetUpOption(getText("ContextMenu_Turn_On"), worldobjects, ISWorldObjectContextMenu.onToggleClothingDryer, object, playerId)
	end
	if not object:getContainer():isPowered() then
		option.notAvailable = true
		option.toolTip = ISWorldObjectContextMenu.addToolTip()
		option.toolTip:setVisible(false)
		option.toolTip:setName(getMoveableDisplayName(object))
		option.toolTip.description = getText("IGUI_RadioRequiresPowerNearby")
	end
end

function ISWorldObjectContextMenu.onToggleClothingDryer(worldobjects, object, playerId)
	local playerObj = getSpecificPlayer(playerId)
	if object:getSquare() and luautils.walkAdj(playerObj, object:getSquare()) then
		ISTimedActionQueue.add(ISToggleClothingDryer:new(playerObj, object))
	end
end

function ISWorldObjectContextMenu.toggleClothingWasher(context, worldobjects, playerId, object)
	local playerObj = getSpecificPlayer(playerId)

	if not object then return end
	if not object:getContainer() then return end
	if ISWorldObjectContextMenu.isSomethingTo(object, playerId) then return end
	if getCore():getGameMode() == "LastStand" then return end

	local option = nil
	if object:isActivated() then
		option = context:addGetUpOption(getText("ContextMenu_Turn_Off"), worldobjects, ISWorldObjectContextMenu.onToggleClothingWasher, object, playerId)
	else
		option = context:addGetUpOption(getText("ContextMenu_Turn_On"), worldobjects, ISWorldObjectContextMenu.onToggleClothingWasher, object, playerId)
	end
	if not object:getContainer():isPowered() or (object:getFluidAmount() <= 0) then
		option.notAvailable = true
		option.toolTip = ISWorldObjectContextMenu.addToolTip()
		option.toolTip:setVisible(false)
		option.toolTip:setName(getMoveableDisplayName(object))
		if not object:getContainer():isPowered() then
			option.toolTip.description = getText("IGUI_RadioRequiresPowerNearby")
		end
		if object:getFluidAmount() <= 0 then
			if option.toolTip.description ~= "" then
				option.toolTip.description = option.toolTip.description .. "\n" .. getText("IGUI_RequiresWaterSupply")
			else
				option.toolTip.description = getText("IGUI_RequiresWaterSupply")
			end
		end
	end
end

function ISWorldObjectContextMenu.onToggleClothingWasher(worldobjects, object, playerId)
	local playerObj = getSpecificPlayer(playerId)
	if object:getSquare() and luautils.walkAdj(playerObj, object:getSquare()) then
		ISTimedActionQueue.add(ISToggleClothingWasher:new(playerObj, object))
	end
end

function ISWorldObjectContextMenu.onWashingDryer(source, context, object, player)
	local mainOption = context:addOption(source, nil, nil);
	local mainSubMenu = ISContextMenu:getNew(context)
	context:addSubMenu(mainOption, mainSubMenu)
	if ISWorldObjectContextMenu.toggleClothingDryer(mainSubMenu, player, object) then
		return true
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

function ISWorldObjectContextMenu.doStoveOption(test, context, player)
	local fetch = ISWorldObjectContextMenu.fetchVars
	local worldobjects = nil
	if fetch.stove ~= nil and not ISWorldObjectContextMenu.isSomethingTo(fetch.stove, player) and getCore():getGameMode()~="LastStand" then
		-- check sandbox for electricity shutoff
		if fetch.stove:getContainer() and fetch.stove:getContainer():isPowered() then
			if test == true then return true; end
	        local options = nil
			if fetch.stove:Activated() then
				option = context:addGetUpOption(getText("ContextMenu_Turn_Off"), worldobjects, ISWorldObjectContextMenu.onToggleStove, fetch.stove, player);
			else
				option = context:addGetUpOption(getText("ContextMenu_Turn_On"), worldobjects, ISWorldObjectContextMenu.onToggleStove, fetch.stove, player);
			end
			if ContainerButtonIcons then
				option.iconTexture = fetch.stove:isMicrowave() and ContainerButtonIcons.microwave or ContainerButtonIcons.stove
			end
			if fetch.stove:getContainer() and fetch.stove:getContainer():getType() == "microwave" then
				option = context:addGetUpOption(getText("ContextMenu_StoveSetting"), worldobjects, ISWorldObjectContextMenu.onMicrowaveSetting, fetch.stove, player);
				option.iconTexture = ContainerButtonIcons and ContainerButtonIcons.microwave
			elseif fetch.stove:getContainer() and fetch.stove:getContainer():isStove() then
--                 elseif fetch.stove:getContainer() and fetch.stove:getContainer():getType() == "stove" then
				option = context:addGetUpOption(getText("ContextMenu_StoveSetting"), worldobjects, ISWorldObjectContextMenu.onStoveSetting, fetch.stove, player);
				option.iconTexture = ContainerButtonIcons and ContainerButtonIcons.stove
			end
		end
	end
	return false
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

ISWorldObjectContextMenu.doWaterDispenserMenu = function(waterdispenser, playerObj, context)
	local addBottleOption = context:addOption(getText("ContextMenu_Add_Bottle"), worldobjects, nil);
	local subMenuBottle = ISContextMenu:getNew(context)
	context:addSubMenu(addBottleOption, subMenuBottle)
	local bottlesList = playerObj:getInventory():getAllTypeRecurse("WaterDispenserBottle");
	for n = 0,bottlesList:size()-1 do
		local bottle = bottlesList:get(n)
		subMenuBottle:addGetUpOption(bottle:getName(), worldobjects, ISWorldObjectContextMenu.onWaterDispenserBottle, playerObj, waterdispenser, bottle);
	end
end

ISWorldObjectContextMenu.onButcherHook = function(hook, playerObj)
	if luautils.walkAdj(playerObj, hook:getSquare(), false) then
		ISTimedActionQueue.add(ISOpenButcherHookUI:new(playerObj, hook));
	end
end

ISWorldObjectContextMenu.onWaterDispenserBottle = function(worldobjects, playerObj, waterdispenser, bottle)
	if luautils.walkAdj(playerObj, waterdispenser:getSquare(), false) then
		ISTimedActionQueue.add(ISAddTakeDispenserBottle:new(playerObj, waterdispenser, bottle));
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

ISWorldObjectContextMenu.onDropCorpseItem = function(worldobjects, player)
	local playerObj = getSpecificPlayer(player)
	ISTimedActionQueue.add(ISDropCorpseAction:new(playerObj));
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
	option.toolTip = tooltip
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

ISWorldObjectContextMenu.onChooseSafehouse = function(worldobjects, building)
	getSpecificPlayer(ISContextMenu.globalPlayerContext):setSafehouse(building);
end

ISWorldObjectContextMenu.onTalkTo = function(worldobjects, survivor)
end

ISWorldObjectContextMenu.onStay = function(worldobjects, survivor)
	survivor:StayHere(getSpecificPlayer(ISContextMenu.globalPlayerContext));
end

ISWorldObjectContextMenu.onGuard = function(worldobjects, survivor)
	survivor:Guard(getSpecificPlayer(ISContextMenu.globalPlayerContext));
end

ISWorldObjectContextMenu.onFollow = function(worldobjects, survivor)
	survivor:FollowMe(getSpecificPlayer(ISContextMenu.globalPlayerContext));
end

ISWorldObjectContextMenu.onTeamUp = function(worldobjects, survivor)
	survivor:MeetFirstTime(getSpecificPlayer(ISContextMenu.globalPlayerContext), true, false);
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

ISWorldObjectContextMenu.doorCurtainCheck = function(argTable)
	if argTable.door:IsOpen() ~= argTable.open then
		local square = argTable.door:getSheetSquare()
		if not square or not square:isFree(false) then return true end -- stop
		argTable.action.pathfindBehaviour:reset()
		argTable.action.pathfindBehaviour:setData(argTable.playerObj, square:getX(), square:getY(), square:getZ())
		argTable.open = argTable.door:IsOpen()
	end
	return false
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

ISWorldObjectContextMenu.onRemoveWallVine = function(worldobjects, square, player)

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

ISWorldObjectContextMenu.getZone = function(x,y,z)
    local zones = getZones(x, y, z);
    -- get the zone without name, the one with name are custom ones (for fishing, plant scavenging..)
    if zones then
        for i=0,zones:size()-1 do
            if not zones:get(i):getName() or zones:get(i):getName() == "" then
                return zones:get(i);
            end
        end
    end
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

ISWorldObjectContextMenu.checkBlowTorchForBarricade = function(chr)
	return chr:getInventory():containsEvalRecurse(predicateBlowTorch)
end

ISWorldObjectContextMenu.doSleepOption = function(context, bed, player, playerObj)
	-- Avoid player sleeping inside a car from the context menu, new radial menu does that now
	if(playerObj:getVehicle() ~= nil) then return end
	if(bed and bed:getSquare():getRoom() ~= playerObj:getSquare():getRoom()) then return end
    local text = getText(bed and "ContextMenu_Sleep" or "ContextMenu_SleepOnGround")
    local bedType = ISWorldObjectContextMenu.getBedQuality(playerObj, bed)
    if bedType == "floorPillow" then
        text = getText("ContextMenu_SleepOnGroundPillow")
    end
    local isOnBed = playerObj:getSitOnFurnitureObject() == bed
    if bed ~= nil and not isOnBed then
        local objects = ArrayList.new()
        bed:getSpriteGridObjectsIncludingSelf(objects)
        isOnBed = objects:contains(playerObj:getSitOnFurnitureObject())
    end
    local sleepOption = isOnBed and context:addOption(text, bed, ISWorldObjectContextMenu.onSleep, player) or context:addGetUpOption(text, bed, ISWorldObjectContextMenu.onSleep, player);
    local tooltipText = nil
    -- Not tired enough
    local sleepNeeded = not isClient() or getServerOptions():getBoolean("SleepNeeded")
    if sleepNeeded and playerObj:getStats():getFatigue() <= 0.3 then
        sleepOption.notAvailable = true;
        tooltipText = getText("IGUI_Sleep_NotTiredEnough");
--[[
    --Player outside.
    elseif bed and (playerObj:isOutside()) and RainManager:isRaining() then
        local square = getCell():getGridSquare(bed:getX(), bed:getY(), bed:getZ() + 1);
        if square == nil or square:getFloor() == nil then
            if bed:getName() ~= "Tent" then
                sleepOption.notAvailable = true;
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                tooltip:setName(getText("ContextMenu_Sleeping"));
                tooltip.description = getText("IGUI_Sleep_OutsideRain");
                sleepOption.toolTip = tooltip;
            end
        end
--]]
    end
	
	local isZombies = playerObj:getStats():getNumVisibleZombies() > 0 or playerObj:getStats():getNumChasingZombies() > 0 or playerObj:getStats():getNumVeryCloseZombies() > 0

    if sleepNeeded and isZombies then
        sleepOption.notAvailable = true;
        tooltipText = getText("IGUI_Sleep_NotSafe");
    end

	if sleepNeeded and (playerObj:getHoursSurvived() - playerObj:getLastHourSleeped()) <= 1 then
		-- cant go right back to sleep even with pills (sleeping pill exploit)
		sleepOption.notAvailable = true;
		tooltipText = getText("ContextMenu_NoSleepTooEarly");
    -- Sleeping pills counter those sleeping problems
	elseif playerObj:getSleepingTabletEffect() < 2000 then
        -- In pain, can still sleep if really tired
        if playerObj:getMoodles():getMoodleLevel(MoodleType.Pain) >= 2 and playerObj:getStats():getFatigue() <= 0.85 then
            sleepOption.notAvailable = true;
            tooltipText = getText("ContextMenu_PainNoSleep");
        -- In panic
        elseif playerObj:getMoodles():getMoodleLevel(MoodleType.Panic) >= 1 then
            sleepOption.notAvailable = true;
            tooltipText = getText("ContextMenu_PanicNoSleep");
        -- tried to sleep not so long ago
        end
    end

    if bed then
        local bedTypeXln = getTextOrNull("Tooltip_BedType_" .. bedType)
        if bedTypeXln then
            if tooltipText then
                tooltipText = tooltipText .. " <BR> " .. getText("Tooltip_BedType", bedTypeXln)
            else
                tooltipText = getText("Tooltip_BedType", bedTypeXln)
            end
        end
    end

    if tooltipText then
        local sleepTooltip = ISWorldObjectContextMenu.addToolTip();
        sleepTooltip:setName(getText("ContextMenu_Sleeping"));
        sleepTooltip.description = tooltipText;
        sleepOption.toolTip = sleepTooltip;
    end
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

ISWorldObjectContextMenu.addGarderingOptions = function(context, wobjs, player)
	local playerObj = getSpecificPlayer(player)
	if playerObj:getVehicle() then return end
	local garden_item = playerObj:getInventory():getFirstEvalRecurse(function(item)
		return not item:isBroken() and item:hasTag("DigPlow")
	end)
	if garden_item then
		context:addGetUpOption(getText("ContextMenu_Dig"), wobjs, ISFarmingMenu.onPlow, playerObj, garden_item)
	end
end

ISWorldObjectContextMenu.onRakeDung = function(player, scythe)
	--ISInventoryPaneContextMenu.equipWeapon(scythe, true, true, player:getPlayerNum())
	--ISTimedActionQueue.add(ISScything:new(player, scythe));
	local bo = ISPickDungCursor:new(player, scythe)
	getCell():setDrag(bo, bo.player)
end

ISWorldObjectContextMenu.prePickupGroundCoverItem = function(context, worldobjects, player, pickupItem)

	if pickupItem:getSprite():getName():contains("vegetation_farming_") or pickupItem:getSprite():getName():contains("vegetation_gardening_") then
		return
	end

	if (not pickupItem:getSprite():getName():contains("d_generic")) and (not pickupItem:getSprite():getName():contains("crafting_ore")) then
		return
	end

	local props = pickupItem:getProperties();
	local customName = props:Is("CustomName") and props:Val("CustomName") or nil

	customName = customName or pickupItem:getSprite():getProperties():Is("CustomName") and pickupItem:getSprite():getProperties():Val("CustomName") or nil

	local itemName;

	if customName and ScriptManager.instance:getItem(customName) then
		itemName = getText(ScriptManager.instance:getItem(customName):getDisplayName())
	elseif customName and GroundCoverItems[customName] and ScriptManager.instance:getItem(GroundCoverItems[customName]) then
		itemName = getText(ScriptManager.instance:getItem(GroundCoverItems[customName]):getDisplayName())
	end

	if not itemName then return; end;

	local text = getText("ContextMenu_Remove") .. " ".. itemName;

	context:addGetUpOption(text, worldobjects, ISWorldObjectContextMenu.onPickupGroundCoverItem, player, pickupItem);

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

ISWorldObjectContextMenu.fetchPickupItems = function(v, props, playerInv)
    local fetch = ISWorldObjectContextMenu.fetchVars
    local customName = props:Is("CustomName") and props:Val("CustomName") or nil
    if not customName then return end

    if props and not props:Is("IsMoveAble") then
		if not fetch.pickupItem then
			if ScriptManager.instance:getItem(customName) then
				fetch.pickupItem = v
			elseif GroundCoverItems[customName] and ScriptManager.instance:getItem(GroundCoverItems[customName]) then
				fetch.pickupItem = v
			end
		end
    end
    if playerInv:containsEvalRecurse(predicatePickAxe) and not fetch.stump and customName and customName == "Small Stump" then
        fetch.stump = v
    end
    if playerInv:containsEvalRecurse(predicateMaulOrPickAxe) and customName and (string.find(tostring(customName), "ironOre") ~= nil) then
        fetch.ore = v
    end
    if playerInv:containsEvalRecurse(predicateMaulOrPickAxe) and customName and (string.find(tostring(customName), "copperOre") ~= nil) then
        fetch.ore = v
    end
    if playerInv:containsEvalRecurse(predicateMaulOrPickAxe) and customName and customName == "FlintBoulder" then
        fetch.ore = v
    end
    if playerInv:containsEvalRecurse(predicateMaulOrPickAxe) and customName and customName == "LimestoneBoulder" then
        fetch.ore = v
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

Events.OnPressWalkTo.Add(ISWorldObjectContextMenu.onWalkTo);