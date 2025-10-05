--***********************************************************
--**                    ROBERT JOHNSON                     **
--**      Contextual inventory menu for farming stuff      **
--***********************************************************

ISFarmingMenu = {};
ISFarmingMenu.info = {};
ISFarmingMenu.GardeningSprayMilk = nil;
ISFarmingMenu.GardeningSprayCigarettes = nil;
ISFarmingMenu.SlugRepellent = nil;
ISFarmingMenu.cheat = false


local function isJoypadPlayer(_player)
	return JoypadState.players[_player + 1];
end

local function isJoypadCharacter(_character)
	return isJoypadPlayer(_character:getPlayerNum());
end

local function predicateDrainableUsesInt(item, count)
	return item:getCurrentUses() >= count
end

local function predicateDigPlow(item)
	return not item:isBroken() and item:hasTag("DigPlow")
end

local function predicateGoodSeed(item) --, isHerb)
	if not item then return false end
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

local function getEffectiveFarmingLevel(playerObj)
	local farmingLevel = CFarmingSystem.instance:getXp(playerObj);
	local magnifierFactor = 0
	if playerObj:getPrimaryHandItem() and playerObj:getPrimaryHandItem():hasTag("Magnifier") then
		magnifierFactor = 2;
	elseif playerObj:getSecondaryHandItem() and playerObj:getSecondaryHandItem():hasTag("Magnifier") then
		magnifierFactor = 2;
	end;

	return farmingLevel + magnifierFactor;
end

function ISFarmingMenu.getFluidContainerMillilitresPerUse()
	-- Soul Filcher : "Water bottles had 10 uses and I set them to have 2L".
	return 200
end

function ISFarmingMenu.getWaterUsesFloat(item)
	if not item then return 0 end
	if item:hasComponent(ComponentType.FluidContainer) then
		local fluidContainer = item:getFluidContainer()
		if not fluidContainer:getPrimaryFluid() then return 0 end
		local fluidTypeString = fluidContainer:getPrimaryFluid():getFluidTypeString()
		if fluidTypeString == "Water" or fluidTypeString == "TaintedWater" then
			local millilitres = fluidContainer:getAmount() * 1000
			return math.floor(millilitres / ZomboidGlobals.farmingFluidContainerMillilitresPerUse)
		end
	end
	if item:IsDrainable() and item:isWaterSource() then
		return item:getDrainableUsesFloat()
	end
	return 0
end

function ISFarmingMenu.getWaterUsesInteger(item)
	if not item then return 0 end
	if item:hasComponent(ComponentType.FluidContainer) then
		local fluidContainer = item:getFluidContainer()
		if not fluidContainer:getPrimaryFluid() then return 0 end
		local fluidTypeString = fluidContainer:getPrimaryFluid():getFluidTypeString()
		if fluidTypeString == "Water" or fluidTypeString == "TaintedWater" then
			local millilitres = fluidContainer:getAmount() * 1000
			return math.floor(millilitres / ZomboidGlobals.farmingFluidContainerMillilitresPerUse)
		end
	end
	if item:IsDrainable() and item:isWaterSource() then
		return item:getCurrentUses()
	end
	return 0
end

ISFarmingMenu.doFarmingMenu = function(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end

	local playerObj = getSpecificPlayer(player)

	if playerObj:getVehicle() then return false end

	return ISFarmingMenu.doFarmingMenu2(player, context, worldobjects, test)
end

ISFarmingMenu.getShovel = function(player)
	local playerInv = player:getInventory();
	-- first check if we have a shovel equipped
	local handItem = player:getPrimaryHandItem()
	if handItem and predicateDigPlow(handItem) then
		return handItem
	end
	-- if not, check if there's a shovel in inventory
	return playerInv:getFirstEvalRecurse(predicateDigPlow)
end

ISFarmingMenu.itemSortByName = function(a,b)
    return not string.sort(a:getName(), b:getName());
end

ISFarmingMenu.doFarmingMenu2 = function(player, context, worldobjects, test)
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	ISFarmingMenu.GardeningSprayMilk = nil;
	ISFarmingMenu.GardeningSprayCigarettes = nil;
	ISFarmingMenu.SlugRepellent = nil;
	ISFarmingMenu.GardeningSprayAphids = nil;

	local fertilizer = false;
	local compost = false;
	local shovel = ISFarmingMenu.getShovel(playerObj)
	local primaryHandItem = playerObj:getPrimaryHandItem();
	local canSeed = false;
	local canWater = false;
	local cureMildew = false;
	local cureFlies = false;
	local info = false;
	local canHarvest = false;
    local sq = nil;
	local currentPlant = nil;
	local deadPlant = false;
	for _,v in ipairs(worldobjects) do
	    if v and v:getSquare() then
            local plant = CFarmingSystem.instance:getLuaObjectOnSquare(v:getSquare())
            if plant then
                if plant.state == "dead" or plant.state == "rotten" or plant.state == "destroyed" or plant.state == "harvested" then deadPlant = true end
                if plant.state ~= "plow" and playerInv:containsTagRecurse("Fertilizer") or playerInv:containsTypeRecurse("Fertilizer") then -- fertilizer
                    fertilizer = true;
                end
                if plant.state ~= "plow" and playerInv:containsTagRecurse("Compost") or playerInv:containsTypeRecurse("CompostBag") then -- fertilizer
                    compost = true
                end
                if plant.state == "plow" and playerObj:getInventory():containsTagRecurse("IsSeed") then -- sow seed
                    canSeed = true;
                end
                if plant.state == "seeded" then -- water the plant
                    canWater = true;
                end
                if plant.state ~= "plow" then -- info
                    info = true;
                end
                -- disease
                if plant.mildewLvl > 0 then -- mildew
                    cureMildew = true;
                end
                if plant.fliesLvl > 0 then -- flies
                    cureFlies = true;
                end
                -- harvest
                if plant:canHarvest() then
                    canHarvest = true;
                end
                currentPlant = plant
                sq = v:getSquare();
                break
            end
        end
	end

    if ISFarmingMenu.canDigHere(worldobjects) then
        if shovel then
            if test then return ISWorldObjectContextMenu.setTest() end
            context:addOption(getText("ContextMenu_Dig"), worldobjects, ISFarmingMenu.onPlow, playerObj, shovel);
        else
            if(not playerObj:getBodyDamage():getBodyPart(BodyPartType.Hand_L):HasInjury() and not playerObj:getBodyDamage():getBodyPart(BodyPartType.Hand_R):HasInjury()) then
                if test then return ISWorldObjectContextMenu.setTest() end
                local option = context:addOption(getText("ContextMenu_DigWithHands"), worldobjects, ISFarmingMenu.onPlow, playerObj, nil)
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                tooltip.description = getText("ContextMenu_DigWithHandsTT");
                option.toolTip = tooltip;
            else
                if test then return ISWorldObjectContextMenu.setTest() end
                local option = context:addOption(getText("ContextMenu_DigWithHands"), worldobjects, ISFarmingMenu.onPlow, playerObj, nil)
                option.notAvailable = true;
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                tooltip.description = getText("ContextMenu_DamagedHands");
                option.toolTip = tooltip;
            end
        end

    elseif shovel and (not ISFarmingMenu.canDigHere(worldobjects)) and not currentPlant then
        local option = context:addOption(getText("ContextMenu_no_soil"))
        option.notAvailable = true;
    end

	local cropsMenu = nil
	if currentPlant or canSeed then
		if test then return ISWorldObjectContextMenu.setTest() end;
		local cropsOption = context:addOption(getText("ContextMenu_Crops"), worldobjects, nil)
		cropsMenu = ISContextMenu:getNew(context)
		context:addSubMenu(cropsOption, cropsMenu)
	end

	if info then
		if test then return ISWorldObjectContextMenu.setTest() end
		cropsMenu:addOption(getText("ContextMenu_Info"), worldobjects, ISFarmingMenu.onInfo, currentPlant, sq, playerObj);
	end
	if fertilizer then
		if test then return ISWorldObjectContextMenu.setTest() end
		cropsMenu:addOption(getText("ContextMenu_Fertilize"), worldobjects, ISFarmingMenu.onFertilize, primaryHandItem, currentPlant, sq, playerObj);
	end
	if compost then
		if test then return ISWorldObjectContextMenu.setTest() end
		cropsMenu:addOption(getText("ContextMenu_Compost"), worldobjects, ISFarmingMenu.onCompost, primaryHandItem, currentPlant, sq, playerObj);
	end
	if canHarvest then
		if test then return ISWorldObjectContextMenu.setTest() end
		cropsMenu:addOption(getText("ContextMenu_Harvest"), worldobjects, ISFarmingMenu.onHarvest, currentPlant, sq, playerObj);
	end
	-- plant seed subMenu
	if canSeed then
		if test then return ISWorldObjectContextMenu.setTest() end
		ISFarmingMenu:doSeedMenu(cropsMenu, currentPlant, sq, playerObj)
	end
	-- water your plant
	if canWater and currentPlant.waterLvl < 100 then
		local waterSources = {}
		if primaryHandItem and ISFarmingMenu.getWaterUsesInteger(primaryHandItem) > 0 then
			table.insert(waterSources, primaryHandItem)
		else
			for i = 0, playerInv:getItems():size() - 1 do
				local item = playerInv:getItems():get(i);
				if ISFarmingMenu.getWaterUsesInteger(item) > 0 then
					table.insert(waterSources, item)
				end
			end
		end

		if #waterSources > 0 then
			if test then return ISWorldObjectContextMenu.setTest() end
			local waterOption = cropsMenu:addOption(getText("ContextMenu_Water"), worldobjects, nil);
			local subMenuWater = ISContextMenu:getNew(cropsMenu);

			cropsMenu:addSubMenu(waterOption, subMenuWater);

			table.sort(waterSources, ISFarmingMenu.itemSortByName)

			for _, waterSource in ipairs(waterSources) do
				local waterSourceOption = subMenuWater:addOption(waterSource:getName(), worldobjects, nil);
				local waterSourceSubMenu = ISContextMenu:getNew(subMenuWater);
				subMenuWater:addSubMenu(waterSourceOption, waterSourceSubMenu);

				-- if waterLvl missing is below the max use of the water plant (so we can't have the option for 40 water if the plant have 80)
				local use = ISFarmingMenu.getWaterUsesInteger(waterSource);
				local missingWaterUse = math.ceil((100 - currentPlant.waterLvl) / 10);
				if missingWaterUse < use then
					use = missingWaterUse;
				end
				waterSourceSubMenu:addOption(getText("ContextMenu_Full", use * 10), worldobjects, ISFarmingMenu.onWater, use, waterSource, playerObj, currentPlant, sq, context);
				if use > 10 then
					use = 10
				else
					use = use - 1
				end
				for i=use,1,-1 do
					waterSourceSubMenu:addOption(tostring(i * 10), worldobjects, ISFarmingMenu.onWater, i, waterSource, playerObj, currentPlant, sq, context);
				end
			end
		end
	end

	-- disease
    if canWater then
		-- we try to get the cure for mildew
		if not primaryHandItem or primaryHandItem:getType() ~= "GardeningSprayMilk" or (primaryHandItem:getCurrentUses() == 0) then
			ISFarmingMenu.GardeningSprayMilk = playerInv:getFirstTypeEvalArgRecurse("GardeningSprayMilk", predicateDrainableUsesInt, 1)
		else
			ISFarmingMenu.GardeningSprayMilk = primaryHandItem;
		end
		-- we try to get the cure for flies
		if not primaryHandItem or primaryHandItem:getType() ~= "GardeningSprayCigarettes" or (primaryHandItem:getCurrentUses() == 0) then
			ISFarmingMenu.GardeningSprayCigarettes = playerInv:getFirstTypeEvalArgRecurse("GardeningSprayCigarettes", predicateDrainableUsesInt, 1)
		else
			ISFarmingMenu.GardeningSprayCigarettes = primaryHandItem;
		end
		if not primaryHandItem or primaryHandItem:getType() ~= "SlugRepellent" or (primaryHandItem:getCurrentUses() == 0) then
			ISFarmingMenu.SlugRepellent = playerInv:getFirstTypeEvalArgRecurse("SlugRepellent", predicateDrainableUsesInt, 1)
		else
			ISFarmingMenu.SlugRepellent = primaryHandItem;
		end
		if not primaryHandItem or primaryHandItem:getType() ~= "GardeningSprayAphids" or (primaryHandItem:getCurrentUses() == 0) then
			ISFarmingMenu.GardeningSprayAphids = playerInv:getFirstTypeEvalArgRecurse("GardeningSprayAphids", predicateDrainableUsesInt, 1)
		else
			ISFarmingMenu.GardeningSprayAphids = primaryHandItem;
		end

		if ISFarmingMenu.GardeningSprayMilk or ISFarmingMenu.GardeningSprayCigarettes or ISFarmingMenu.SlugRepellent or ISFarmingMenu.GardeningSprayAphids then
			if test then return ISWorldObjectContextMenu.setTest() end
            local diseaseOption = cropsMenu:addOption(getText("ContextMenu_Treat_Problem"), worldobjects, nil);
            local subMenuCure = cropsMenu:getNew(cropsMenu);
			cropsMenu:addSubMenu(diseaseOption, subMenuCure);

			if ISFarmingMenu.GardeningSprayMilk then
-- 				-- we get how many use we can do on our item
				local use = ISFarmingMenu.GardeningSprayMilk:getCurrentUses()
				if use > 0 then
					-- prepare subMenu for mildew
					subMenuCure:addOption(getText("Farming_Mildew"), worldobjects, ISFarmingMenu.onMildewCure, 1, sq, playerObj);
				end
			end
			if ISFarmingMenu.GardeningSprayCigarettes then
				-- we get how many use we can do on our item
				local use = ISFarmingMenu.GardeningSprayCigarettes:getCurrentUses()
				if use > 0 then
					-- prepare subMenu for mildew
					subMenuCure:addOption(getText("Farming_Pest_Flies"), worldobjects, ISFarmingMenu.onFliesCure, 1, sq, playerObj);
				end
			end
			if ISFarmingMenu.SlugRepellent then
				-- we get how many use we can do on our item
				local use = ISFarmingMenu.SlugRepellent:getCurrentUses()
				if use > 0 then
					-- prepare subMenu for mildew
					subMenuCure:addOption(getText("Farming_Slugs"), worldobjects, ISFarmingMenu.onSlugsCure, 1, sq, playerObj);
				end
			end
			if ISFarmingMenu.GardeningSprayAphids then
				-- we get how many use we can do on our item
				local use = ISFarmingMenu.GardeningSprayAphids:getCurrentUses()
				if use > 0 then
					-- prepare subMenu for mildew
					local flieMenu = subMenuCure:addOption(getText("Farming_Aphids"), worldobjects, ISFarmingMenu.onAphidsCure, 1, sq, playerObj, context);
					-- now submenu for lvl of flies you want to cure (5 by 5)
					local subMenuFlie = context:getNew(subMenuCure);
					if use > 10 then
						use = 10;
					end
					for i=1, use do
						subMenuFlie:addOption(i .. "", worldobjects, ISFarmingMenu.onAphidsCure, i, sq, playerObj);
					end
					context:addSubMenu(flieMenu, subMenuFlie);
				end
			end
	    end
    end

	if currentPlant then
		if test then return ISWorldObjectContextMenu.setTest() end
		local opt = cropsMenu:addOption(getText("ContextMenu_Remove"), worldobjects, ISFarmingMenu.onShovel, currentPlant, playerObj, sq);
		if not shovel then
			opt.notAvailable = true
		end
	end

	if ISFarmingMenu.cheat and currentPlant then
		if test then return ISWorldObjectContextMenu.setTest() end
		local option = context:addOption("Cheat", worldobjects, nil);
	    option.iconTexture = getTexture("media/textures/Item_Insect_Aphid.png");
		local subMenu = context:getNew(context);
		context:addSubMenu(option, subMenu);
		subMenu:addOption("Grow", worldobjects, ISFarmingMenu.onCheatGrow, currentPlant);
		subMenu:addOption("Water To Max", worldobjects, ISFarmingMenu.onCheatWater, currentPlant);
		subMenu:addOption("Zero Water", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'waterLvl', count = -currentPlant.waterLvl });
		local option2 = subMenu:addOption("Aphids +5", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'aphidLvl', count = 5 });
	    option2.iconTexture = getTexture("media/textures/Item_Insect_Aphid.png");
		option2 = subMenu:addOption("Aphids -5", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'aphidLvl', count = -5 });
	    option2.iconTexture = getTexture("media/textures/Item_Insect_Aphid.png");
		option2 = subMenu:addOption("Mildew +5", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'mildewLvl', count = 5 });
	    option2.iconTexture = getTexture("media/textures/Item_Mildew.png");
		option2 = subMenu:addOption("Mildew -5", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'mildewLvl', count = -5 });
	    option2.iconTexture = getTexture("media/textures/Item_Mildew.png");
		option2 = subMenu:addOption("Pest Flies +5", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'fliesLvl', count = 5 });
	    option2.iconTexture = getTexture("media/textures/Item_Insect_Fly.png");
		option2 = subMenu:addOption("Pest Flies -5", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'fliesLvl', count = -5 });
	    option2.iconTexture = getTexture("media/textures/Item_Insect_Fly.png");
		option2 = subMenu:addOption("Slugs +5", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'slugsLvl', count = 5 });
	    option2.iconTexture = getTexture("media/textures/Item_Snail.png");
		option2 = subMenu:addOption("Slugs -5", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'slugsLvl', count = -5 });
	    option2.iconTexture = getTexture("media/textures/Item_Snail.png");
		subMenu:addOption("Health +10", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'health', count = 10 });
		subMenu:addOption("Health -10", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'health', count = -10 });
		subMenu:addOption("Water +10", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'waterLvl', count = 10 });
		subMenu:addOption("Water -10", worldobjects, ISFarmingMenu.onCheat, currentPlant, { var = 'waterLvl', count = -10 });
	end
end

ISFarmingMenu.canDigHere = function(worldObjects)
	local squares = {}
	local didSquare = {}
	for _,worldObj in ipairs(worldObjects) do
	    if worldObj:isGrave() then return false end
		if not didSquare[worldObj:getSquare()] then
			table.insert(squares, worldObj:getSquare())
			didSquare[worldObj:getSquare()] = true
		end
	end
	for _,square in ipairs(squares) do
	    if ISFarmingMenu.canDigHereSquare(square) then return true end
	end
	return false
end

ISFarmingMenu.canDigHereSquare = function(square)
    if square:hasGrave() then return false end
    local plant = CFarmingSystem.instance:getLuaObjectOnSquare(square)
    if plant and plant.state ~= "plow" and not plant:isAlive() then plant = false end
    if plant then
        return false
    end

    local groundFloor = getSandboxOptions():getOptionByName("PlaceDirtAboveground"):getValue() == true or square:getZ() == 0
    if not groundFloor then return false end;
    if ISShovelGroundCursor.GetDirtGravelSand(square) == "dirt" then return true end
    return false
end

ISFarmingMenu.canPlow = function(seedAvailable, typeOfSeed, option, seedName, playerObj)
	local tooltip = ISToolTip:new();
    local cheat = ISFarmingMenu.cheat;
	local result = true;
	if seedAvailable < 1 then
		result = false;
	end
    if cheat or playerObj:isRecipeActuallyKnown(farming_vegetableconf.props[typeOfSeed].seasonRecipe) or CFarmingSystem.instance:getXp(playerObj) >= 6 then
        local prop = farming_vegetableconf.props[typeOfSeed]
        tooltip:initialise();
        tooltip:setVisible(false);
        option.toolTip = tooltip;
        tooltip:setName(getText("Farming_" .. typeOfSeed));
        tooltip.description = ISFarmingMenu.plantInfo(prop)

        local rgb = "";
        if result == false then
            rgb = "<RGB:1,0,0>";
        end
        local scriptItem = ScriptManager.instance:getItem(seedName)
        local seedText = scriptItem:getDisplayName()
        tooltip.description = tooltip.description .. " <LINE> " .. rgb .. getText(seedText) .. ": " .. seedAvailable .. "/" .. "1";
        tooltip:setTexture(farming_vegetableconf.props[typeOfSeed].texture);
        tooltip:setWidth(170);
    end
	if not result then
		option.onSelect = nil;
		option.notAvailable = true;
    end
end

ISFarmingMenu.plantInfo = function(prop)
	local text = ""
	text = text .. getText("Farming_Tooltip_MinWater") .. " " .. prop.waterLvl
	text = text .. " <LINE>" .. getText("Farming_Tooltip_TimeOfGrow") .. math.floor((prop.timeToGrow * prop.harvestLevel) / 24 * calcNextTimeFactor()) .. " " .. getText("IGUI_Gametime_days")
	if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == true and prop.sowMonth then
		text = text .. " <LINE>" .. getText("Farming_Tooltip_InSeason") .. ": "
		for i, monthNum in ipairs(prop.sowMonth) do
			text = text .. getText("Farming_Month_" .. monthNum) .. ((i ~= #prop.sowMonth and ", ") or "")
		end

		if prop.bestMonth then
			text = text .. " <LINE>" .. getText("Farming_Tooltip_BestMonth2") .. ": "
			for i, monthNum in ipairs(prop.bestMonth) do
				text = text .. getText("Farming_Month_" .. monthNum) .. ((i ~= #prop.bestMonth and ", ") or "")
			end
		else
			text = text .. " <LINE>" .. getText("Farming_Tooltip_BestMonth2") .. ": " .. getText("Farming_Tooltip_None");
		end
		if prop.riskMonth then
			text = text .. " <LINE>" .. getText("Farming_Tooltip_RiskMonth2") .. ": "
			for i, monthNum in ipairs(prop.riskMonth) do
				text = text .. getText("Farming_Month_" .. monthNum) .. ((i ~= #prop.riskMonth and ", ") or "")
			end
		else
			text = text .. " <LINE>" .. getText("Farming_Tooltip_RiskMonth2") .. ": " .. getText("Farming_Tooltip_None");
		end
	end
	if ISFarmingMenu.cheat then
		local pestInfo = {}
		for i, v in pairs(prop) do
			local thisProp = tostring(i)
			if string.contains(thisProp, "Food") or string.contains(thisProp, "Bane") or string.contains(thisProp, "Proof") then
				table.insert(pestInfo, i)
			end
		end
		if #pestInfo > 0 then
			text = text .. " <LINE>" .. getText("Farming_Tooltip_PestInfo").. ": "
			for i=1, #pestInfo do
				local thisProp = pestInfo[i]
				local propString = "Farming_"..string.upper(string.sub(thisProp, 1,1))..string.sub(thisProp, 2,-1)
				text = text .. getText(propString) .. ((i ~= #pestInfo and ", ") or "")
			end
		end
	end
	return text
end


function ISFarmingMenu.isValidPlant(plant)
	if not plant then return false end
	plant:updateFromIsoObject()
	return plant:getIsoObject() ~= nil
end

function ISFarmingMenu.walkToPlant(playerObj, square)
	if ISFarmingMenu.cheat or playerObj:isTimedActionInstant() then
		return true;
	end
	if AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), square) then
		return true
	end
	local adjacent = AdjacentFreeTileFinder.Find(square, playerObj)
	if adjacent == nil then return false end
	ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
	return true
end

ISFarmingMenu.onHarvest = function(worldobjects, plantToharvest, sq, playerObj)
	if ISFarmingMenu.walkToPlant(playerObj, sq) then
		if not isJoypadCharacter(playerObj) then
			ISTimedActionQueue.add(ISHarvestPlantAction:new(playerObj, plantToharvest, 100));
		end
	end
	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onHarvestSquareSelected, ISFarmingMenu.isHarvestValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
end

function ISFarmingMenu:onHarvestSquareSelected()
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)

	if not ISFarmingMenu.walkToPlant(cursor.character, cursor.sq) then
		return;
	end

	ISTimedActionQueue.add(ISHarvestPlantAction:new(cursor.character, plant, 100));
end

function ISFarmingMenu:isHarvestValid()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local plantName = ISFarmingMenu.getPlantName(plant);
	cursor.tooltipTxt = plantName .. " ";

	if not ISFarmingMenu.isValidPlant(plant) or (plant.state ~= "seeded") then
		cursor.tooltipTxt = "<RGB:1,0,0> " .. getText("Farming_Tooltip_NotAPlant");
		return false;
	end
	
	if not plant:canHarvest() then
		cursor.tooltipTxt = plantName .. " <LINE> <RGB:1,0,0> " .. getText("Farming_Tooltip_NotReadyToHarvest");
		return false;
	end
	
	return true;
end

ISFarmingMenu.isMildewCureValid = function()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	if plant == nil or plant.state ~= "seeded" then return; end;
	cursor.tooltipTxt = ISFarmingMenu.getPlantName(plant) .. " <LINE> ";
	local farmingLevel = getEffectiveFarmingLevel(cursor.character);
	if farmingLevel >= 3 then
		cursor.tooltipTxt = cursor.tooltipTxt .. getText("Farming_Mildew")..': '..ISFarmingInfo.getDiseaseString(plant.mildewLvl, farmingLevel);
	end;
	return true;
end

ISFarmingMenu.onMildewCureSquareSelected = function()
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)

	if not ISFarmingMenu.walkToPlant(cursor.character, cursor.sq) then
		return;
	end

	local primaryHandItem = cursor.character:getPrimaryHandItem();

	if not primaryHandItem or primaryHandItem:getType() ~= "GardeningSprayMilk" or (primaryHandItem:getCurrentUses() == 0) then
		ISFarmingMenu.GardeningSprayMilk = cursor.character:getInventory():getFirstTypeEvalArgRecurse("GardeningSprayMilk", predicateDrainableUsesInt, 1)
	else
		ISFarmingMenu.GardeningSprayMilk = primaryHandItem;
	end

	if ISWorldObjectContextMenu.equip(cursor.character, cursor.character:getPrimaryHandItem(), ISFarmingMenu.GardeningSprayMilk, true) == nil then
		if ISFarmingMenu.GardeningSprayMilk ~= primaryHandItem then
			return;
		end
	end

	ISTimedActionQueue.add(ISCurePlantAction:new(cursor.character, ISFarmingMenu.GardeningSprayMilk, cursor.uses, plant, 10 * (cursor.uses * 10), "Flies"))
end

ISFarmingMenu.onMildewCure = function(worldobjects, uses, sq, playerObj)
	if not ISFarmingMenu.walkToPlant(playerObj, sq) then
		return;
	end
	if not isJoypadCharacter(playerObj) then
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), ISFarmingMenu.GardeningSprayMilk, true)
		ISTimedActionQueue.add(ISCurePlantAction:new(playerObj, ISFarmingMenu.GardeningSprayMilk, uses, CFarmingSystem.instance:getLuaObjectOnSquare(sq), 10 * (uses * 10), "Mildew"))
	end

	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onMildewCureSquareSelected, ISFarmingMenu.isMildewCureValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
	ISFarmingMenu.cursor.handItem = ISFarmingMenu.GardeningSprayMilk;
	ISFarmingMenu.cursor.uses = uses;
end

ISFarmingMenu.isFliesCureValid = function()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	if plant == nil or plant.state ~= "seeded" then return; end;
	cursor.tooltipTxt = ISFarmingMenu.getPlantName(plant) .. " <LINE> ";
	local farmingLevel = getEffectiveFarmingLevel(cursor.character);
	if farmingLevel >= 3 then
		cursor.tooltipTxt = cursor.tooltipTxt .. getText("Farming_Pest_Flies")..': '..ISFarmingInfo.getDiseaseString(plant.fliesLvl, farmingLevel);
	end;
	return true;
end

ISFarmingMenu.onFliesCureSquareSelected = function()
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)

	if not ISFarmingMenu.walkToPlant(cursor.character, cursor.sq) then
		return;
	end
	local primaryHandItem = cursor.character:getPrimaryHandItem();

	if not primaryHandItem or primaryHandItem:getType() ~= "GardeningSprayCigarettes" or (primaryHandItem:getCurrentUses() == 0) then
		ISFarmingMenu.GardeningSprayCigarettes = cursor.character:getInventory():getFirstTypeEvalArgRecurse("GardeningSprayCigarettes", predicateDrainableUsesInt, 1)
	else
		ISFarmingMenu.GardeningSprayCigarettes = primaryHandItem;
	end

	if ISWorldObjectContextMenu.equip(cursor.character, cursor.character:getPrimaryHandItem(), ISFarmingMenu.GardeningSprayCigarettes, true) == nil then
		if ISFarmingMenu.GardeningSprayCigarettes ~= primaryHandItem then
			return;
		end
	end

	ISTimedActionQueue.add(ISCurePlantAction:new(cursor.character, ISFarmingMenu.GardeningSprayCigarettes, cursor.uses, plant, 10 * (cursor.uses * 10), "Flies"))
end

ISFarmingMenu.onFliesCure = function(worldobjects, uses, sq, playerObj)
	if not ISFarmingMenu.walkToPlant(playerObj, sq) then
		return;
	end
	if not isJoypadCharacter(playerObj) then
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), ISFarmingMenu.GardeningSprayCigarettes, true)
		ISTimedActionQueue.add(ISCurePlantAction:new(playerObj, ISFarmingMenu.GardeningSprayCigarettes, uses, CFarmingSystem.instance:getLuaObjectOnSquare(sq), 10 * (uses * 10), "Flies"));
	end

	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onFliesCureSquareSelected, ISFarmingMenu.isFliesCureValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
	ISFarmingMenu.cursor.handItem = ISFarmingMenu.GardeningSprayCigarettes;
	ISFarmingMenu.cursor.uses = uses;
end

ISFarmingMenu.isSlugsCureValid = function()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	if plant == nil or plant.state ~= "seeded" then return; end;
	cursor.tooltipTxt = ISFarmingMenu.getPlantName(plant) .. " <LINE> ";
	local farmingLevel = getEffectiveFarmingLevel(cursor.character);
	if farmingLevel >= 3 then
		cursor.tooltipTxt = cursor.tooltipTxt .. getText("Farming_Slugs")..': '..ISFarmingInfo.getDiseaseString(plant.slugsLvl, farmingLevel);
	end;
	return true;
end

ISFarmingMenu.onSlugsCureSquareSelected = function()
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)

	if not ISFarmingMenu.walkToPlant(cursor.character, cursor.sq) then
		return;
	end

	local primaryHandItem = cursor.character:getPrimaryHandItem();

	if not primaryHandItem or primaryHandItem:getType() ~= "SlugRepellent" or (primaryHandItem:getCurrentUses() == 0) then
		ISFarmingMenu.SlugRepellent = cursor.character:getInventory():getFirstTypeEvalArgRecurse("SlugRepellent", predicateDrainableUsesInt, 1)
	else
		ISFarmingMenu.SlugRepellent = primaryHandItem;
	end

	if ISWorldObjectContextMenu.equip(cursor.character, cursor.character:getPrimaryHandItem(), ISFarmingMenu.SlugRepellent, true) == nil then
		if ISFarmingMenu.SlugRepellent ~= primaryHandItem then
			return;
		end
	end

	ISTimedActionQueue.add(ISCurePlantAction:new(cursor.character, ISFarmingMenu.SlugRepellent, cursor.uses, plant, 10 * (cursor.uses * 10), "Slugs"))
end

ISFarmingMenu.onSlugsCure = function(worldobjects, uses, sq, playerObj)
	if not ISFarmingMenu.walkToPlant(playerObj, sq) then
		return;
	end
	if not isJoypadCharacter(playerObj) then
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), ISFarmingMenu.SlugRepellent, true)
		ISTimedActionQueue.add(ISCurePlantAction:new(playerObj, ISFarmingMenu.SlugRepellent, uses, CFarmingSystem.instance:getLuaObjectOnSquare(sq), 10 * (uses * 10), "Slugs"));
	end

	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onSlugsCureSquareSelected, ISFarmingMenu.isSlugsCureValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
	ISFarmingMenu.cursor.handItem = ISFarmingMenu.SlugRepellent;
	ISFarmingMenu.cursor.uses = uses;
end

ISFarmingMenu.isAphidCureValid = function()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	if plant == nil or plant.state ~= "seeded" then return; end;
	cursor.tooltipTxt = ISFarmingMenu.getPlantName(plant) .. " <LINE> ";
	local farmingLevel = getEffectiveFarmingLevel(cursor.character);
	if farmingLevel >= 3 then
		cursor.tooltipTxt = cursor.tooltipTxt .. getText("Farming_Aphid")..': '..ISFarmingInfo.getDiseaseString(plant.aphidLvl, farmingLevel);
	end;
	return true;
end

ISFarmingMenu.onAphidsCureSquareSelected = function()
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)

	if not ISFarmingMenu.walkToPlant(cursor.character, cursor.sq) then
		return;
	end

	local primaryHandItem = cursor.character:getPrimaryHandItem();

	if not primaryHandItem or primaryHandItem:getType() ~= "GardeningSprayAphids" or (primaryHandItem:getCurrentUses() == 0) then
		ISFarmingMenu.GardeningSprayAphids = cursor.character:getInventory():getFirstTypeEvalArgRecurse("GardeningSprayAphids", predicateDrainableUsesInt, 1)
	else
		ISFarmingMenu.GardeningSprayAphids = primaryHandItem;
	end

	if ISWorldObjectContextMenu.equip(cursor.character, cursor.character:getPrimaryHandItem(), ISFarmingMenu.GardeningSprayAphids, true) == nil then
		if ISFarmingMenu.GardeningSprayAphids ~= primaryHandItem then
			return;
		end
	end

	ISTimedActionQueue.add(ISCurePlantAction:new(cursor.character, ISFarmingMenu.GardeningSprayAphids, cursor.uses, plant, 10 * (cursor.uses * 10), "Aphids"))
end

ISFarmingMenu.onAphidsCure = function(worldobjects, uses, sq, playerObj, context)
	if context then context:hideAndChildren(); end;
	if not ISFarmingMenu.walkToPlant(playerObj, sq) then
		return;
	end

	if not isJoypadCharacter(playerObj) then
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), ISFarmingMenu.GardeningSprayAphids, true)
		ISTimedActionQueue.add(ISCurePlantAction:new(playerObj, ISFarmingMenu.GardeningSprayAphids, uses, CFarmingSystem.instance:getLuaObjectOnSquare(sq), 10 * (uses * 10), "Aphids"));
	end

	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onAphidsCureSquareSelected, ISFarmingMenu.isAphidCureValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
	ISFarmingMenu.cursor.handItem = ISFarmingMenu.GardeningSprayAphids;
	ISFarmingMenu.cursor.uses = uses;
end

ISFarmingMenu.onInfo = function(worldobjects, plant, sq, playerObj)
	if ISFarmingMenu.walkToPlant(playerObj, sq) then
		if not isJoypadCharacter(playerObj) then
			ISTimedActionQueue.add(ISPlantInfoAction:new(playerObj, plant))
		end
	end
	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onInfoSquareSelected, ISFarmingMenu.isInfoValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
end

function ISFarmingMenu:onInfoSquareSelected()
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)

	if not ISFarmingMenu.walkToPlant(cursor.character, cursor.sq) then
		return;
	end
	
	ISTimedActionQueue.add(ISPlantInfoAction:new(cursor.character, plant))
end

function ISFarmingMenu:isInfoValid()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	return plant ~= nil and plant.typeOfSeed ~= "none"
end

ISFarmingMenu.onWater = function(worldobjects, uses, handItem, playerObj, plant, sq, context)
	if context then context:hideAndChildren(); end;
    local use = ISFarmingMenu.getWaterUsesInteger(handItem)

	-- if waterLvl missing is below the max use of the water plant (so we can't have the option for 40 water if the plant have 80)
	local missingWaterUse = math.ceil((100 - plant.waterLvl) / 10);
	if missingWaterUse < use then
		use = missingWaterUse;
	end
	if use > 10 then
		use = 10
	end
	
	if use > uses then
		use = uses;
	end

	if playerObj:getPrimaryHandItem() ~= handItem then
		ISTimedActionQueue.add(ISEquipWeaponAction:new(playerObj, handItem, 50, true));
	end

	if not ISFarmingMenu.walkToPlant(playerObj, sq) then
		return;
	end

	if not isJoypadCharacter(playerObj) then
		ISTimedActionQueue.add(ISWaterPlantAction:new(playerObj, handItem, use, sq, 20 + (6 * use)));
	end

	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onWaterSquareSelected, ISFarmingMenu.isWaterValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
	ISFarmingMenu.cursor.handItem = handItem;
	ISFarmingMenu.cursor.uses = uses;
end

function ISFarmingMenu:onWaterSquareSelected()
	local cursor = ISFarmingMenu.cursor;
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
    local use = ISFarmingMenu.getWaterUsesInteger(cursor.handItem)

	-- if waterLvl missing is below the max use of the water plant (so we can't have the option for 40 water if the plant have 80)
	local missingWaterUse = math.ceil((100 - plant.waterLvl) / 10);
	if missingWaterUse < use then
		use = missingWaterUse;
	end
	if use > 10 then
		use = 10
	end
	
	if use > cursor.uses then
		use = cursor.uses;
	end

	if cursor.character:getPrimaryHandItem() ~= cursor.handItem then
		ISTimedActionQueue.add(ISEquipWeaponAction:new(cursor.character, cursor.handItem, 50, true));
	end

	if not ISFarmingMenu.walkToPlant(cursor.character, cursor.sq) then
		return;
	end

	ISTimedActionQueue.add(ISWaterPlantAction:new(cursor.character, cursor.handItem, use, cursor.sq, 20 + (6 * use)));
end

ISFarmingMenu.getPlantName = function(plant)
	if not plant then
		return "";
	end
	
	if plant:getObject() then
		ISFarmingMenu.TEMP_PLANT = copyTable(ISFarmingMenu.TEMP_PLANT, plant)
		ISFarmingMenu.TEMP_PLANT.nbOfGrow = ISFarmingMenu.TEMP_PLANT.nbOfGrow - 1
		return farming_vegetableconf.getObjectName(ISFarmingMenu.TEMP_PLANT)
	else
		return "Dead " .. getText("Farming_" .. plant.typeOfSeed);
	end
end

function ISFarmingMenu:isWaterValid()
	if not ISFarmingMenu.cursor then return false; end
	local valid = true;
	local cursor = ISFarmingMenu.cursor;
	cursor.tooltipTxt = "";
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local plantName = ISFarmingMenu.getPlantName(plant);
	
	if not ISFarmingMenu.isValidPlant(plant) then
		cursor.tooltipTxt = "<RGB:1,0,0> " .. getText("Farming_Tooltip_NotAPlant");
		return false;
	end
	
	if plant and plant.state ~= "seeded" then
		cursor.tooltipTxt = "<RGB:1,0,0> " .. getText("Farming_Tooltip_FurrowNeedsSeed");
		return false;
	end
	
	cursor.tooltipTxt = plantName .. " <LINE> ";
	local use = 0;
	if cursor.handItem then
		use = ISFarmingMenu.getWaterUsesInteger(cursor.handItem);
	end
	
	-- if waterLvl missing is below the max use of the water plant (so we can't have the option for 40 water if the plant have 80)
	local missingWaterUse = math.ceil((100 - plant.waterLvl) / 10);
	if missingWaterUse < use then
		use = missingWaterUse;
	end
	if use > 10 then
		use = 10
	end
	
	if missingWaterUse <= 0 then
		cursor.tooltipTxt = plantName .. " <LINE> <RGB:1,0,0> " .. getText("Farming_Tooltip_PlantHasEnoughWater");
		return false;
	end

	if use > cursor.uses then
		use = cursor.uses;
	end
	
	if use <= 0 then
		-- try to reselect another water source
		local playerInv = cursor.character:getInventory();
		local waterSources = {};
		cursor.handItem = nil;
		for i = 0, playerInv:getItems():size() - 1 do
			local item = playerInv:getItems():get(i);
			if ISFarmingMenu.getWaterUsesInteger(item) > 0 then
				table.insert(waterSources, item)
			end
		end
		-- we'll select the best water source available, one with required water we want, otherwise the best next one
		if #waterSources > 0 then
			for _, waterSource in ipairs(waterSources) do
				use = ISFarmingMenu.getWaterUsesInteger(waterSource)
				if use >= cursor.uses then
					cursor.handItem = waterSource;
				else
					if not cursor.handItem or use > waterSource:getCurrentUses() then
						cursor.handItem = waterSource;
					end
				end
			end
			return true;
		end
			
		cursor.tooltipTxt = "<RGB:1,0,0> " .. getText("Farming_Tooltip_NotEnoughWaterInInventory");
		return false;
	end

	local farmingLevel = CFarmingSystem.instance:getXp(cursor.character)
	local water_rgb = ISFarmingInfo.getWaterLvlColor(plant, farmingLevel)
	water_rgb = string.format(" <RGB:%.2f,%.2f,%.2f> <SPACE> ", water_rgb.r, water_rgb.g, water_rgb.b)

	cursor.tooltipTxt = cursor.tooltipTxt .. getText("Farming_Water_levels") .. ": " .. water_rgb .. ISFarmingInfo.getWaterLvl(plant, farmingLevel) .. " <LINE> ";
	cursor.tooltipTxt = cursor.tooltipTxt .. " <RGB:1,1,1> " .. getText("Farming_Tooltip_ItemUsed") .. ": " .. cursor.handItem:getDisplayName() .. " (" ..  tostring(use * 10) .. " / " .. tostring(ISFarmingMenu.getWaterUsesInteger(cursor.handItem) * 10) .. ")";

	return valid;
end

function ISFarmingMenu:doSeedMenu(context, plant, sq, playerObj)

    local seasons = getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == true
    local cheat = ISFarmingMenu.cheat

	local seedOption = context:addOption(getText("ContextMenu_Sow_Seed"), nil, nil)
	local subMenu = context:getNew(context)
	context:addSubMenu(seedOption, subMenu)

	if cheat then
        subMenu:addOption("Farming Cheat Enabled")
        subMenu:addOption("Farming Seasons Enabled: " .. tostring(seasons))
	end

	-- Sort seed types by display name.
	local seedPropertyInfo = {}
	for typeOfSeed, props in pairs(farming_vegetableconf.props) do
		table.insert(seedPropertyInfo, { typeOfSeed = typeOfSeed, props = props, text = getText("Farming_" .. typeOfSeed) })
	end
	table.sort(seedPropertyInfo, function(a, b) return not string.sort(a.text, b.text) end)

	for _, seedProperties in ipairs(seedPropertyInfo) do
		local typeOfSeed = seedProperties.typeOfSeed
		local seedTypes = seedProperties.props.seedTypes or { seedProperties.props.seedName }
        for i = 1, #seedTypes do
            local seedName = seedTypes[i]
            local nbOfSeed = playerObj:getInventory():getCountTypeEvalRecurse(seedName, predicateGoodSeed)
            if nbOfSeed > 0 or cheat then
                local inSeason = false
                local bestMonth = false
                local riskMonth = false
                local scriptItem = ScriptManager.instance:getItem(seedName)
                local text = scriptItem:getDisplayName()
                if seasons and cheat then
                    for j = 1, #seedProperties.props.sowMonth do
                        if getGameTime():getMonth() + 1 == seedProperties.props.sowMonth[j] then
                            inSeason = true
                            break
                        end
                    end
                    if inSeason then
                        if seedProperties.props.bestMonth then
                            for j = 1, #seedProperties.props.bestMonth do
                                if getGameTime():getMonth() + 1 == seedProperties.props.bestMonth[j] then
                                    bestMonth = true
                                    break
                                end
                            end
                        end
                        if not bestMonth and seedProperties.props.riskMonth then
                            for j = 1, #seedProperties.props.riskMonth do
                                if getGameTime():getMonth() + 1 == seedProperties.props.riskMonth[j] then
                                    riskMonth = true
                                    break
                                end
                            end
                        end
                    end
                    if bestMonth then text = text .. " (" .. getText("Farming_Tooltip_BestMonth") .. ")"
                    elseif riskMonth then text = text .. " (" .. getText("Farming_Tooltip_RiskMonth") .. ")"
                    elseif inSeason then text = text .. " (" .. getText("Farming_Tooltip_InSeason") .. ")"
                    else text = text .. " (" .. getText("Farming_Tooltip_BadMonth") .. ")"
                    end
                end
                text = text .. " : " .. tostring(nbOfSeed)
                local option = subMenu:addOption(text, playerObj, ISFarmingMenu.onSeed, typeOfSeed, plant, sq, seedName)
                option.iconTexture = getTexture("media/textures/Item_" .. scriptItem:getIcon())
                ISFarmingMenu.canPlow(nbOfSeed, typeOfSeed, option, seedName, playerObj)
            end
        end
	end
end

function ISFarmingMenu.onSeed(playerObj, typeOfSeed, plant, sq, seedName)
	if ISFarmingMenu.walkToPlant(playerObj, sq) then
		if not isJoypadCharacter(playerObj) then
			local playerInv = playerObj:getInventory()
			local seed = playerInv:getFirstTypeEvalRecurse(seedName, predicateGoodSeed)
			ISInventoryPaneContextMenu.transferIfNeeded(playerObj, seed)
			ISTimedActionQueue.add(ISSeedActionNew:new(playerObj, seed, typeOfSeed, plant))
		end
	end
	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onSeedSquareSelected, ISFarmingMenu.isSeedValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
	ISFarmingMenu.cursor.typeOfSeed = typeOfSeed;
	ISFarmingMenu.cursor.seedName = seedName;
end

function ISFarmingMenu:onSeedSquareSelected()
	local cursor = ISFarmingMenu.cursor;
	if not ISFarmingMenu.walkToPlant(cursor.character, cursor.sq) then
		return
	end
	
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local playerInv = cursor.character:getInventory()
	local seed = playerInv:getFirstTypeEvalRecurse(cursor.seedName, predicateGoodSeed)
	if seed then
        ISInventoryPaneContextMenu.transferIfNeeded(cursor.character, seed)
        ISTimedActionQueue.add(ISSeedActionNew:new(cursor.character, seed, cursor.typeOfSeed, plant))
    end
end

function ISFarmingMenu:isSeedValid()
	local valid = true;
	local cursor = ISFarmingMenu.cursor;
	
	local playerInv = cursor.character:getInventory()
    local nbOfSeed = playerInv:getCountTypeEvalRecurse(cursor.seedName, predicateGoodSeed)
	cursor.tooltipTxt = getText("ContextMenu_Sow_Seed") .. ": "
	local color = " <RGB:1,1,1> "
	local scriptItem = getScriptManager():FindItem(cursor.seedName)
	local seedText = scriptItem:getDisplayName()
	if nbOfSeed < 1 then
		color = " <RGB:1,0,0> "
		valid = false;
	end

	cursor.tooltipTxt = cursor.tooltipTxt .. color .. seedText

	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local plantName = ISFarmingMenu.getPlantName(plant);

	if not ISFarmingMenu.isValidPlant(plant) then
		cursor.tooltipTxt = cursor.tooltipTxt .. " <LINE> <RGB:1,0,0> " .. getText("Farming_Tooltip_NotAFurrow");
		valid = false;
	end
	
	if plant and plant.state ~= "plow" then
		cursor.tooltipTxt = " <RGB:1,1,1> " .. plantName .. " <LINE> " ..  cursor.tooltipTxt .. " <LINE> <RGB:1,0,0> " .. getText("Farming_Tooltip_FurrowHasSeeds");
		valid = false;
    elseif plant and plant.state == "plow" then
		cursor.tooltipTxt = " <RGB:1,1,1> " .. plantName .. " <LINE> " ..  cursor.tooltipTxt .. " <LINE> <RGB:1,1,1> " .. getText(seedText) .. " : " .. nbOfSeed;
	end

	return valid;
end

ISFarmingMenu.onPlow = function(worldobjects, playerObj, handItem)
	local bo = farmingPlot:new(handItem, playerObj);
	bo.player = playerObj:getPlayerNum()
	getCell():setDrag(bo, bo.player)
end

function ISFarmingMenu:isShovelValid()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor
	local playerObj = cursor.character
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local plantName = ISFarmingMenu.getPlantName(plant)

	if not ISFarmingMenu.isValidPlant(plant) then
		cursor.tooltipTxt = "<RGB:1,0,0> " .. getText("Farming_Tooltip_NotAPlant")
		return false
	end

	cursor.tooltipTxt = plantName

	if ISFarmingMenu.getShovel(playerObj) ~= nil then
		return true
	end

	return false
end

function ISFarmingMenu:onShovelSquareSelected()
	local cursor = ISFarmingMenu.cursor
	local playerObj = cursor.character

	if not ISFarmingMenu.walkToPlant(playerObj, cursor.sq) then
		return
	end

	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)

	local handItem = ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), ISFarmingMenu.getShovel(playerObj), true);

	ISTimedActionQueue.add(ISShovelAction:new(playerObj, handItem, plant, 40));
end

ISFarmingMenu.onShovel = function(worldobjects, plant, playerObj, sq)
    if not ISFarmingMenu.walkToPlant(playerObj, sq) then
        return;
    end

	local handItem = ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), ISFarmingMenu.getShovel(playerObj), true);

	if not isJoypadCharacter(playerObj) then
		ISTimedActionQueue.add(ISShovelAction:new(playerObj, handItem, plant, 40));
	end

	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onShovelSquareSelected, ISFarmingMenu.isShovelValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
end

ISFarmingMenu.onFertilize = function(worldobjects, handItem, plant, sq, playerObj)
    -- close the farming info window to avoid concurrent gorwing phase problem
    if not ISFarmingMenu.walkToPlant(playerObj, sq) then
        return;
    end

	if not isJoypadCharacter(playerObj) then
		if playerObj:getInventory():containsTypeRecurse("Fertilizer") then
			handItem = ISWorldObjectContextMenu.equip(playerObj, handItem, "Fertilizer", true);
		end

		ISTimedActionQueue.add(ISFertilizeAction:new(playerObj, handItem, plant, 100));
	end

	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onFertilizeSquareSelected, ISFarmingMenu.isFertilizeValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
end

ISFarmingMenu.onCompost = function(worldobjects, handItem, plant, sq, playerObj)
	if not ISFarmingMenu.walkToPlant(playerObj, sq) then
		return;
	end

	if not isJoypadCharacter(playerObj) then
		if playerObj:getInventory():containsTypeRecurse("CompostBag") then
			handItem = ISWorldObjectContextMenu.equip(playerObj, handItem, "CompostBag", true);
		end

		ISTimedActionQueue.add(ISFertilizeAction:new(playerObj, handItem, plant, 100));
	end

	ISFarmingMenu.cursor = ISFarmingCursorMouse:new(playerObj, ISFarmingMenu.onCompostSquareSelected, ISFarmingMenu.isCompostValid)
	getCell():setDrag(ISFarmingMenu.cursor, playerObj:getPlayerNum())
end

function ISFarmingMenu:isFertilizeValid()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor
	local playerObj = cursor.character
	local playerInv = playerObj:getInventory()
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local plantName = ISFarmingMenu.getPlantName(plant)
	
	if not ISFarmingMenu.isValidPlant(plant) then
		cursor.tooltipTxt = "<RGB:1,0,0> " .. getText("Farming_Tooltip_NotAPlant")
		return false
	end

	cursor.tooltipTxt = plantName

	if playerInv:containsTagRecurse("Fertilizer") or playerInv:containsTypeRecurse("Fertilizer") or playerInv:containsTypeRecurse("CompostBag") then
		return true
	end

	return false
end

function ISFarmingMenu:isCompostValid()
	if not ISFarmingMenu.cursor then return false; end
	local cursor = ISFarmingMenu.cursor
	local playerObj = cursor.character
	local playerInv = playerObj:getInventory()
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local plantName = ISFarmingMenu.getPlantName(plant)

	if not ISFarmingMenu.isValidPlant(plant) then
		cursor.tooltipTxt = "<RGB:1,0,0> " .. getText("Farming_Tooltip_NotAPlant")
		return false
	end

	cursor.tooltipTxt = plantName

	if playerInv:containsTypeRecurse("CompostBag") then
		return true
	end

	return false
end

function ISFarmingMenu:onFertilizeSquareSelected()
	local cursor = ISFarmingMenu.cursor
	local playerObj = cursor.character
	if not ISFarmingMenu.walkToPlant(playerObj, cursor.sq) then
		return
	end
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local handItem = playerObj:getPrimaryHandItem()

    if playerObj:getInventory():containsTypeRecurse("Fertilizer") then
        handItem = ISWorldObjectContextMenu.equip(playerObj, handItem, "Fertilizer", true);
    end

	ISTimedActionQueue.add(ISFertilizeAction:new(playerObj, handItem, plant, 100))
end

function ISFarmingMenu:onCompostSquareSelected()
	local cursor = ISFarmingMenu.cursor
	local playerObj = cursor.character
	if not ISFarmingMenu.walkToPlant(playerObj, cursor.sq) then
		return
	end
	local plant = CFarmingSystem.instance:getLuaObjectOnSquare(cursor.sq)
	local handItem = playerObj:getPrimaryHandItem()

    if playerObj:getInventory():containsTypeRecurse("CompostBag") then
        handItem = ISWorldObjectContextMenu.equip(playerObj, handItem, "CompostBag", true);
    end

	ISTimedActionQueue.add(ISFertilizeAction:new(playerObj, handItem, plant, 100))
end

ISFarmingMenu.onCheatGrow = function(worldobjects, plant)
	local hours = CFarmingSystem.instance.hoursElapsed - plant.nextGrowing
	local args = { var = 'nextGrowing', count = hours }
	ISFarmingMenu.onCheat(worldobjects, plant, args)
end

function ISFarmingMenu.onCheatWater(worldobjects, plant)
	local diff = 100 - plant.waterLvl
	if plant.waterNeededMax then
		diff = plant.waterNeededMax - plant.waterLvl
	end
	local args = { var = 'waterLvl', count = diff }
	ISFarmingMenu.onCheat(worldobjects, plant, args)
end

ISFarmingMenu.onCheat = function(worldobjects, plant, args)
	args.x = plant.x
	args.y = plant.y
	args.z = plant.z
	CFarmingSystem.instance:sendCommand(getSpecificPlayer(0), 'cheat', args)
end

Events.OnFillWorldObjectContextMenu.Add(ISFarmingMenu.doFarmingMenu);