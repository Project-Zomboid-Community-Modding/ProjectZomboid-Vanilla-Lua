CFarming_Interact = {}

local function predicateGoodSeed(item)
	if not item then return false end
	if not instanceof(item, "Food") then return true end

	if item:isRotten() or item:isCooked() or item:isBurnt() then return false end
	-- herbs ("cutings") have to be fresh
	if item:hasTag(ItemTag.IS_CUTTING) and not item:isFresh() then return false end

	-- check for a whole item
	local baseHunger = math.abs(item:getBaseHunger())
	local hungerChange = math.abs(item:getHungerChange())
    if item:isFresh() and hungerChange < baseHunger then return false end
    if not item:isFresh() and hungerChange < (baseHunger * 0.75) then return false end
	return true
end

local function predicateGoodSeedNotHeld(item)
	if not item then return false end
	if item == getSpecificPlayer(0):getPrimaryHandItem() then return end
	return predicateGoodSeed(item)
end

CFarming_Interact.SawOnContextKeyEvent = false

CFarming_Interact.onKeyStartPressed = function(key)
	if not getCore():isKey("Interact", key) then return end
	CFarming_Interact.SawOnContextKeyEvent = false
end

CFarming_Interact.onContextKey = function(player, timePressedContext)
	if CFarming_Interact.SawOnContextKeyEvent then return end
	CFarming_Interact.SawOnContextKeyEvent = true

	if player:getVehicle() then return end
	if not player:isAiming() then return end
	if player:hasTimedActions() then return end
	local dir = player:getDir()
	local square = player:getSquare():getAdjacentSquare(dir)
	if not square:getCanSee(player:getPlayerNum()) then return end
	if square:getMovingObjects():size() > 0 then return end
    if not ISFarmingMenu.walkToPlant(player, square) then return end
	local item = player:getPrimaryHandItem()

	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(square)
    local canHarvest = plant and plant:canHarvest()
    local plow = plant and plant.state == "plow"

    -- interactions that don't need an item should go first
    -- if there's a harvestable plant in the square we harvest it
    if canHarvest then
        if not ISFarmingMenu.walkToPlant(player, square) then return end
		player:setIsFarming(true)
        ISTimedActionQueue.add(ISHarvestPlantAction:new(player, plant, 100))
        return
    end
	-- interactions that need an item should be below this
	if not item or item:isBroken() then
        player:setIsFarming(false)
        return
    end


    player:setIsFarming(true)
	local chopTree = item:hasTag(ItemTag.CHOP_TREE)
    local digPlow = item:hasTag(ItemTag.DIG_PLOW)
    local hasCuttingTool = item:hasTag(ItemTag.CUT_PLANT)
    local pickaxe = item:hasTag(ItemTag.PICK_AXE)
    local removeStump = item:hasTag(ItemTag.REMOVE_STUMP)
    local stoneMaul = item:hasTag(ItemTag.STONE_MAUL)
    local sledge = item:hasTag(ItemTag.SLEDGEHAMMER)
    local clubHammer = item:hasTag(ItemTag.CLUB_HAMMER)
    local hammer = item:hasTag(ItemTag.HAMMER)
    local scythe = item:hasTag(ItemTag.SCYTHE)
    local seed = item:hasTag(ItemTag.IS_SEED) and predicateGoodSeed(item)
    local water = item:isWaterSource() and item:getCurrentUses() > 0
    local fertilizer = item:hasTag(ItemTag.FERTILIZER) and item:getCurrentUses() > 0
    local compost = item:hasTag(ItemTag.COMPOST) and item:getCurrentUses() > 0

    -- if you have an axe and there's a tree you chop it
	if chopTree and square:HasTree() then
		player:setIsFarming(true)
		ISTimedActionQueue.add(ISChopTreeAction:new(player, square:getTree()))
		return
	end
    -- if you have an cutting tool and there's a bush you remove it it
    local rmc = ISRemovePlantCursor:new(player, "bush")
	if hasCuttingTool and rmc:getRemovableObject(square) then
		player:setIsFarming(true)
        ISTimedActionQueue.add(ISRemoveBush:new(player, square, false))
        return
	end
    if removeStump and square:getStump() then
        ISTimedActionQueue.add(ISPickAxeGroundCoverItem:new(player, square:getStump()));
		return
    end
    if (pickaxe or stoneMaul or sledge or clubHammer) and square:getOre() then
        ISTimedActionQueue.add(ISPickAxeGroundCoverItem:new(player, square:getOre()));
		return
    end

	-- if you have a tool to dig a furrow and you can dig one you dig one
	if digPlow and ISFarmingMenu.canDigHereSquare(square) then
		player:setIsFarming(true)
		ISTimedActionQueue.add(ISPlowAction:new(player, square, item))
		return
	end

	if plow and seed then
        local typeOfSeedList = {}
        for typeOfSeed,props in pairs(farming_vegetableconf.props) do
            table.insert(typeOfSeedList, { typeOfSeed = typeOfSeed, props = props, text = getText("Farming_" .. typeOfSeed) })
        end
        table.sort(typeOfSeedList, function(a,b) return not string.sort(a.text, b.text) end)
        for _,tos in ipairs(typeOfSeedList) do
            local typeOfSeed = tos.typeOfSeed
            local seedTypes = tos.props.seedTypes or { tos.props.seedName }
            for i = 1, #seedTypes do
                if item:getFullType() == seedTypes[i] then-- 		                getPlayer():Say("Match")
                    local reEquip = player:getInventory():getFirstTypeEvalRecurse(item:getFullType(), predicateGoodSeedNotHeld)
                    ISTimedActionQueue.add(ISSeedActionNew:new(player, item, typeOfSeed, plant))
                    player:setPrimaryHandItem(nil);
                    if reEquip then
                        ISInventoryPaneContextMenu.transferIfNeeded(player, reEquip)
		                player:setIsFarming(true)
                        ISTimedActionQueue.add(ISEquipWeaponAction:new( player, reEquip, 20, true, false))
                    end
                    return
                end
            end
        end
	end
    -- if you have the tool unused furrows are removed
    -- dead plants are now restored to furrows, earlier
    if plow and digPlow then
		player:setIsFarming(true)
        ISTimedActionQueue.add(ISShovelAction:new(player, item, plant, 110))
        return
    end
    -- scythe the grass
    if scythe then
        local radius = 3
        if item:getType() == "HandScythe" or item:hasTag(ItemTag.HAND_SCYTHE) then
            radius = 1
        end
		player:setIsFarming(true)
        ISTimedActionQueue.add(ISScything:new(player, item, square, radius))
        return
    end
    -- water plants that can be watered
    if water
    and plant
    and plant.state == "seeded"
    and plant:isAlive()
    and plant.waterLvl < 100 then
        local prop = farming_vegetableconf.props[plant.typeOfSeed]
        local use = item:getCurrentUses()
        local max = 100
        if prop.waterLvlMax and prop[typeOfSeed].seasonRecipe and (player:isRecipeActuallyKnown(prop[typeOfSeed].seasonRecipe) or CFarmingSystem.instance:getXp(player) >= 6) then
            max = prop.waterLvlMax
        end
        local missingWaterUse = math.ceil((max - plant.waterLvl) / 10)
        if missingWaterUse < use then
        use = missingWaterUse;
        end
        if use > 10 then
        use = 10
        end

		player:setIsFarming(true)
        ISTimedActionQueue.add(ISWaterPlantAction:new(player, item, use, square, 20 + (6 * use)))
        return
    end
    -- fertilize plants that can be fertilized
    if fertilizer
    and plant
    and plant.state == "seeded"
    and plant:isAlive() then
		player:setIsFarming(true)
	    ISTimedActionQueue.add(ISFertilizeAction:new(player, item, plant, 100))
	    return
    end
    if compost
    and plant
    and plant.state == "seeded"
    and plant:isAlive() then
		player:setIsFarming(true)
	    ISTimedActionQueue.add(ISFertilizeAction:new(player, item, plant, 100))
	    return
    end

    if plant
    and plant.state == "seeded"
    and plant:isAlive() then
        local fliesCure
        local mildewCure
        local slugsCure
        local aphidsCure

        if item:getType() == "GardeningSprayMilk" and item:getCurrentUses() > 0 then
             mildewCure = item
        elseif item:getType() == "GardeningSprayCigarettes" and item:getCurrentUses() > 0 then
             fliesCure = item
        elseif item:getType() == "SlugRepellent" and item:getCurrentUses() > 0 then
             slugsCure = item
        elseif item:getType() == "GardeningSprayAphids" and item:getCurrentUses() > 0 then
             aphidsCure = item
        end

        if fliesCure or mildewCure or slugsCure or aphidsCure then
        local cure = "Flies"
        if mildewCure then cure = "Mildew" elseif slugsCure then cure = "Slugs" elseif aphidsCure then cure = "Aphids" end
            player:setIsFarming(true)
            ISTimedActionQueue.add(ISCurePlantAction:new(player, item, 1, plant, 100, cure))
            return
        end
    end

    -- cleaning interactions
    if item:hasTag(ItemTag.CLEAN_STAINS) then
        local square2 = player:getSquare()
        if square2 then
            if ISWorldObjectContextMenu.canCleanBlood(player, square2)  then
                player:setIsFarming(true)
                ISWorldObjectContextMenu.doCleanBlood(player,square2)
                return
            end
            if ISWorldObjectContextMenu.canCleanGraffiti(player, square2)  then
                player:setIsFarming(true)
                ISWorldObjectContextMenu.doCleanGraffiti(player,square2)
                return
            end
        end

        if ISWorldObjectContextMenu.canCleanBlood(player, square)  then
		    player:setIsFarming(true)
            ISWorldObjectContextMenu.doCleanBlood(player,square)
            return
        end
        if ISWorldObjectContextMenu.canCleanGraffiti(player, square)  then
		    player:setIsFarming(true)
            ISWorldObjectContextMenu.doCleanGraffiti(player,square)
            return
        end
    end
    player:setIsFarming(false)
end


CFarming_Interact.FastDropItem = function(key)
    if not getCore():isKey("DropBothHeldItems", key)
    and not getCore():isKey("DropPrimaryHeldItem", key)
    and not getCore():isKey("DropSecondaryHeldItem", key)
    and not getCore():isKey("DropWornBag", key)
    and not getCore():isKey("DropBothHeldItemsAndWornBag", key)
    and not getCore():isKey("GrabCorpse", key)
    then return end

	local player = getSpecificPlayer(0)
    if not player then return end

    if player:getClothingItem_Back() and (not player:getClothingItem_Back():isFavorite()) and (getCore():isKey("DropWornBag", key) or getCore():isKey("DropBothHeldItemsAndWornBag", key)) then
        ISInventoryPaneContextMenu.dropItem(player:getClothingItem_Back(), player:getPlayerNum())
    end

    if player:getSecondaryHandItem() and (not player:getSecondaryHandItem():isFavorite()) and (getCore():isKey("DropSecondaryHeldItem", key) or getCore():isKey("DropBothHeldItems", key) or getCore():isKey("DropBothHeldItemsAndWornBag", key)) then
        ISInventoryPaneContextMenu.dropItem(player:getSecondaryHandItem(), player:getPlayerNum())
    end

    if player:getPrimaryHandItem() and (not player:getPrimaryHandItem():isFavorite()) and (getCore():isKey("DropPrimaryHeldItem", key) or getCore():isKey("DropBothHeldItems", key) or getCore():isKey("DropBothHeldItemsAndWornBag", key)) then
        ISInventoryPaneContextMenu.dropItem(player:getPrimaryHandItem(), player:getPlayerNum())
    end

    local square = player:getSquare()
    if not square then return end
    local body = square:getDeadBody()
    if getCore():isKey("GrabCorpse", key) and square and body and body:getWeight() <= 60 + (player:getPerkLevel(Perks.Strength) * 7) then
		if player:getPrimaryHandItem() then
			ISTimedActionQueue.add(ISUnequipAction:new(player, player:getPrimaryHandItem(), 50));
		end
		if player:getSecondaryHandItem() and player:getSecondaryHandItem() ~= player:getPrimaryHandItem() then
			ISTimedActionQueue.add(ISUnequipAction:new(player, player:getSecondaryHandItem(), 50));
		end
		ISTimedActionQueue.add(ISGrabCorpseAction:new(player, body));

    end
end


CFarming_Interact.ChangeClimbDirection = function(key)
    local player = getSpecificPlayer(0)
    if not player or not player:isClimbingRope() then return end
    if not getCore():isKey("Forward", key)
    and not getCore():isKey("Backward", key)
    and not getCore():isKey("ReleaseRope", key)
    then return end
    local doUp = getCore():isKey("Forward", key)
    local isUp = player:getCurrentState() == ClimbSheetRopeState.instance()

    if getCore():isKey("ReleaseRope", key) then
        player:fallFromRope()
    elseif isUp and not doUp then
        player:getStateMachineParams(ClimbDownSheetRopeState:instance()):clear()
        player:reportEvent("EventClimbDownRope")
    elseif doUp and not isUp then
        player:getStateMachineParams(ClimbSheetRopeState:instance()):clear()
        player:reportEvent("EventClimbRope")
    end
end

CFarming_Interact.getObjectClutterType = function(v)
    if instanceof(v, "IsoObject") and v:getSprite()  then
        local spriteName = v:getSprite():getName() or v:getSpriteName()
        if not spriteName then
            spriteName = v:getSpriteName()
        end
        if spriteName then
            local clutter = GroundCoverItems[spriteName]
            if clutter then return clutter end
        end
    end
    return nil
end

local function OnGameStart()
	Events.OnKeyStartPressed.Add(CFarming_Interact.onKeyStartPressed);
	Events.OnContextKey.Add(CFarming_Interact.onContextKey);
	Events.OnKeyPressed.Add(CFarming_Interact.FastDropItem);
	Events.OnKeyPressed.Add(CFarming_Interact.ChangeClimbDirection);
end

Events.OnGameStart.Add(OnGameStart)
