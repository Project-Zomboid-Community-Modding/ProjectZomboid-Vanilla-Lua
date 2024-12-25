CFarming_Interact = {}
local function predicateFreshEnough(item) --, isHerb)
	if not item then return false end
	if not instanceof(item, "Food") then return true end
	-- if not item:isFood() then return true end
	if item:isRotten() then return false end
	if item:hasTag("isCutting") and not item:isFresh() then return false end
	return true
end

local function predicateFreshEnoughNotHeld(item) --, isHerb)
	if not item then return false end
	if item == getSpecificPlayer(0):getPrimaryHandItem() then return end
	if not instanceof(item, "Food") then return true end
	-- if not item:isFood() then return true end
	if item:isRotten() then return false end
	if item:hasTag("isCutting") and not item:isFresh() then return false end
	return true
end

local function predicateGoodSeed(item) --, isHerb)
	if not item then return false end
	-- if not item:isFood() then return true end
	if not instanceof(item, "Food") then return true end

	if item:isRotten() or item:isCooked() or item:isBurnt() then return false end
	-- herbs ("cutings") have to be fresh
	if item:hasTag("isCutting") and not item:isFresh() then return false end

	-- check for a whole item
	local baseHunger = math.abs(item:getBaseHunger())
	local hungerChange = math.abs(item:getHungerChange())
    if item:isFresh() and hungerChange < baseHunger then return false end
    if not item:isFresh() and hungerChange < (baseHunger * 0.75) then return false end
	return true
end

local function predicateGoodSeedNotHeld(item) --, isHerb)
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
	-- local index = player:getPlayerNum()
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
	local chopTree = item:hasTag("ChopTree")
    local digPlow = item:hasTag("DigPlow")
    local hasCuttingTool = item:hasTag("CutPlant")
    local pickaxe = item:hasTag("PickAxe")
    local stoneMaul = item:hasTag("stoneMaul")
    local sledge = item:hasTag("Sledgehammer")
    local hammer = item:hasTag("Hammer")
    local scythe = item:hasTag("Scythe")
    local seed = item:hasTag("isSeed") and predicateGoodSeed(item)
    local water = item:isWaterSource() and item:getCurrentUses() > 0
    local fertilizer = item:hasTag("Fertilizer") and item:getCurrentUses() > 0
    local compost = item:hasTag("Compost") and item:getCurrentUses() > 0
--     local corpse = item:getType() == "CorpseFemale" or item:getType() == "CorpseMale"

    local fliesCure = item:getType() == "GardeningSprayMilk" and item:getCurrentUses() > 0
    local mildewCure = item:getType() == "GardeningSprayCigarettes" and item:getCurrentUses() > 0 
    local slugsCure = item:getType() == "SlugRepellent" and item:getCurrentUses() > 0
    local aphidsCure = item:getType() == "GardeningSprayAphids" and item:getCurrentUses() > 0

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
    if pickaxe then
-- 	    if pickaxe or hasCuttingTool then
        local objects = square:getWorldObjects()
        -- if you have the proper tool then ground cover gets pickaxed or cut
        if objects  and objects:size() > 0 then
            for i=0, i< objects:size() do
                local v = objects:get(i)
                if instanceof(v, "IsoObject") and v:getSprite()  then
                    local spriteName = v:getSprite():getName() or v:getSpriteName()
                    if not spriteName then
                        spriteName = v:getSpriteName()
                    end

                    local props = sprite:getProperties()
                    local customName = props:Is("CustomName") and props:Val("CustomName") or nil
                    if pickaxe and customName == "Small Stump" then
                        player:setIsFarming(true)
                        ISTimedActionQueue.add(ISPickAxeGroundCoverItem:new(player, v));
                        return
                    end

                end
            end
        end
    end
--     print("MINING CHECK")
-- TODO: Doesn't work anymore, fix
    if pickaxe or stoneMaul or sledge then
        local objects = square:getWorldObjects()
--         print("SQUARE " .. tostring(square))
--         print("OBJECTS " .. tostring(square:getWorldObjects()))
--         print("OBJECTS " .. tostring(square:getWorldObjects():size()))
        -- if you have the proper tool then ground cover gets pickaxed or cut
        if objects and objects:size() > 0 then
            for i=0, i< objects:size() do
                local v = objects:get(i)
--                     print("Objects " .. tostring(v))
                    if v:getSprite() and v:getSprite():getProperties() then
                        local props = v:getSprite():getProperties()
                        print("props " .. tostring(props))
                        local customName = props:Is("CustomName") and props:Val("CustomName") or nil
                        print("customName " .. tostring(customName))
    --                         if not customName then customName = CFarming_Interact.getObjectClutterType(v) end
                        if customName and (string.find(tostring(customName), "ironOre") ~= nil) then
                           ISTimedActionQueue.add(ISPickAxeGroundCoverItem:new(player, v));
                           return
                        elseif customName and (string.find(tostring(customName), "copperOre") ~= nil) then
                           ISTimedActionQueue.add(ISPickAxeGroundCoverItem:new(player, v));
                           return
                        elseif customName and (customName == "FlintBoulder" or customName == "LimestoneBoulder") then
                           ISTimedActionQueue.add(ISPickAxeGroundCoverItem:new(player, v));
                           return
                        end
                    end
            end
        end
    end

	-- if you have a tool to dig a furrow and you can dig one you dig one
	if digPlow and ISFarmingMenu.canDigHereSquare(square) then
		-- square:setHighlighted(true)
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
--     if (plow or (plant and (plant.state == "destroyed" or  plant.state == "dead" or plant.state == "rotten"  or plant.state == "harvested"))) and digPlow then
		player:setIsFarming(true)
        ISTimedActionQueue.add(ISShovelAction:new(player, item, plant, 110))
        return
    end
    -- scythe the grass
    if scythe then
        local radius = 3
        if item:getType() == "HandScythe" or item:hasTag("HandScythe") then
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
--         player:Say("Water")
        local prop = farming_vegetableconf.props[plant.typeOfSeed]
        local use = item:getCurrentUses()
--         local use = math.floor(item:getCurrentUsesFloat()/item:getUseDelta())
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
    if item:hasTag("CleanStains") then
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



--     if corpse and CCampfireSystem.instance:getLuaObjectOnSquare(square) then
--         ISTimedActionQueue.add(ISDropWorldItemAction:new(player, item, square, 0.5, 0.5, 0.0, 0, false));
--         return
--     elseif corpse and CCampfireSystem.instance:getLuaObjectOnSquare(player:getSquare()) then
--         ISTimedActionQueue.add(ISInventoryTransferAction:new(player, item, player:getInventory(), ISInventoryPage.floorContainer[player:getPlayerNum()+1]))
--         return
--     end
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
--         if testItem:getType() == "CorpseMale" or testItem:getType() == "CorpseFemale" then
--             tests.corpse = testItem;
--         end

end


CFarming_Interact.ChangeClimbDirection = function(key)
    local player = getSpecificPlayer(0)
    if not player or not player:isClimbingRope() then return end
--     local climbing = player:getCurrentState():equals(ClimbSheetRopeState.instance()) or player:getCurrentState():equals(ClimbDownSheetRopeState.instance())
--     if not player or not climbing then return end
--     if not player or not player:isClimbing() then return end
    if not getCore():isKey("Forward", key)
    and not getCore():isKey("Backward", key)
    and not getCore():isKey("ReleaseRope", key)--DropBothHeldItemsAndWornBag
    then return end
    local doUp = getCore():isKey("Forward", key)
    local isUp = player:getCurrentState():equals(ClimbSheetRopeState.instance())

--     print("climbing up " .. tostring(player:getCurrentState():equals(ClimbSheetRopeState.instance())))
--     print("climbing down " .. tostring(player:getCurrentState():equals(ClimbDownSheetRopeState.instance())))
--
--     print("doUp " .. tostring(doUp))
--     print("isUp " .. tostring(isUp))
    if getCore():isKey("ReleaseRope", key) then
        print("Should Release Rope and Fall")
        player:fallFromRope()
--         player:setCollidable(true);
--         player:setbClimbing(false);
--         player:setbFalling(true);
--         player:clearVariable("ClimbRope");
    elseif isUp and not doUp then
--         print("Should climb down")
        player:getStateMachineParams(ClimbDownSheetRopeState:instance()):clear()
        player:reportEvent("EventClimbDownRope")
    elseif doUp and not isUp then
--         print("Should climb up")
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
