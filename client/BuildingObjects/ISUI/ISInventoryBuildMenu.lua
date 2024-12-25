--***********************************************************
--**                    ROBERT JOHNSON                     **
--**       Contextual menu for building stuff when clicking in the inventory        **
--***********************************************************

ISInventoryBuildMenu = {};

local function predicateNotBroken(item)
	return not item:isBroken()
end

local function predicateTakeDirt(item)
	return not item:isBroken() and item:hasTag("TakeDirt")
end

ISInventoryBuildMenu.doBuildMenu = function(player, context, worldobjects, test)

	if test and ISWorldObjectContextMenu.Test then return true end

    local gravelBag = {};
	local sandBag = {};
    local dirtBag = {};
    local shovel = nil;
    local fillWithGravel = nil;
    local fillWithSand = nil;
    local fillWithDirt = nil;
    local nothingToTake = nil;

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory();

    -- do the spill things menu
    shovel = playerInv:getFirstEvalRecurse(predicateTakeDirt)

	local shovelSubMenu = context;

	-- do the fill bags with thing menu
    if shovel then
		--shovel submenu exists, grab it
		local shovelOption = nil;
		for i,v in ipairs(context.options) do
			if v.name == getText("ContextMenu_Shovel") then
				shovelOption = v;
				shovelSubMenu = context:getSubMenu(shovelOption.subOption);
			end
		end

		local squares = {}
        for j=#worldobjects,1,-1 do
			local v = worldobjects[j]
			if v:getSquare() then
				local dup = false
				for i=1,#squares do
					if squares[i] == v:getSquare() then dup = true; break end
				end
				if not dup then table.insert(squares, v:getSquare()) end
			end
		end
		local itemCounts = ISShovelGroundCursor.GetEmptyItemCounts(playerObj)
		for i=1,#squares do
			local groundType,object = ISShovelGroundCursor.GetDirtGravelSand(squares[i])
			if groundType == "dirt" then
				if itemCounts[groundType] + itemCounts.empty > 0 then
					fillWithDirt = object
				end
			elseif groundType == "gravel" then
				if itemCounts[groundType] + itemCounts.empty > 0 then
					fillWithGravel = object
				end
			elseif groundType == "sand" then
				if itemCounts[groundType] + itemCounts.empty > 0 then
					fillWithSand = object
				end
		    else
-- 		        print("Nothing 1")
				nothingToTake = true
			end
        end
    end
	--[[
	if playerInv:containsTypeRecurse("Gravelbag") then
		if test then return ISWorldObjectContextMenu.setTest() end
		local option = context:addOption(getText("ContextMenu_Spill_Gravel"), playerObj, ISInventoryBuildMenu.onSpillGravel);
--         local groundFloor = playerObj:getZ() <= 0
-- 		if not groundFloor then
-- 		    option.notAvailable = true;
--             local tooltip = ISWorldObjectContextMenu.addToolTip();
--             tooltip:setName(getText("ContextMenu_NotAboveGroundFloor"));
--             option.toolTip = tooltip;
-- 		end
    end
	if playerInv:containsTypeRecurse("Sandbag") then
		if test then return ISWorldObjectContextMenu.setTest() end
		local option = context:addOption(getText("ContextMenu_Spill_Sand"), playerObj, ISInventoryBuildMenu.onSpillSand);
--         local groundFloor = playerObj:getZ() <= 0
-- 		if not groundFloor then
-- 		    option.notAvailable = true;
--             local tooltip = ISWorldObjectContextMenu.addToolTip();
--             tooltip:setName(getText("ContextMenu_NotAboveGroundFloor"));
--             option.toolTip = tooltip;
-- 		end
    end
	if playerInv:containsTypeRecurse("Dirtbag") then
		if test then return ISWorldObjectContextMenu.setTest() end
		local option = context:addOption(getText("ContextMenu_Spill_Dirt"), playerObj, ISInventoryBuildMenu.onSpillDirt);
        local groundFloor = getSandboxOptions():getOptionByName("PlaceDirtAboveground"):getValue() == true or playerObj:getZ() == 0
		if not groundFloor then
		    option.notAvailable = true;
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("ContextMenu_NotAboveGroundFloor"));
            option.toolTip = tooltip;
		end
    end
	]]--
    if fillWithSand then
		if test then return ISWorldObjectContextMenu.setTest() end
		local option = shovelSubMenu:addOption(getText("ContextMenu_Take_some_sands"), playerObj, ISInventoryBuildMenu.onTakeThing, "sand");
    end
    if fillWithGravel then
		if test then return ISWorldObjectContextMenu.setTest() end
		local option = shovelSubMenu:addOption(getText("ContextMenu_Take_some_gravel"), playerObj, ISInventoryBuildMenu.onTakeThing, "gravel");
    end
    if fillWithDirt then
		if test then return ISWorldObjectContextMenu.setTest() end
		local option = shovelSubMenu:addOption(getText("ContextMenu_Take_some_dirt"), playerObj, ISInventoryBuildMenu.onTakeThing, "dirt");
    end
    if nothingToTake and playerInv:containsTypeRecurse("EmptySandbag") then
		if test then return ISWorldObjectContextMenu.setTest() end
		local option = shovelSubMenu:addOption(getText("ContextMenu_Take_nothing"));
		option.notAvailable = true;
    end
end

ISInventoryBuildMenu.onTakeThing = function(playerObj, groundType)
	local bo = ISShovelGroundCursor:new("floors_exterior_natural_01_13", "floors_exterior_natural_01_13", playerObj, groundType)
	getCell():setDrag(bo, playerObj:getPlayerNum());
end

ISInventoryBuildMenu.onSpillGravel = function(playerObj)
    -- sprite, northSprite, item to use
	local gravelBag = playerObj:getInventory():getFirstTypeRecurse("Base.Gravelbag")
	getCell():setDrag(ISNaturalFloor:new("blends_street_01_55", "blends_street_01_55", gravelBag, playerObj), playerObj:getPlayerNum());
end

ISInventoryBuildMenu.onSpillSand = function(playerObj)
    -- sprite, northSprite, item to use
	local sandBag = playerObj:getInventory():getFirstTypeRecurse("Base.Sandbag")
	getCell():setDrag(ISNaturalFloor:new("blends_natural_01_5", "blends_natural_01_5", sandBag, playerObj), playerObj:getPlayerNum());
end

ISInventoryBuildMenu.onSpillDirt = function(playerObj)
	-- sprite, northSprite, item to use
	local dirtBag = playerObj:getInventory():getFirstTypeRecurse("Base.Dirtbag")
    getCell():setDrag(ISNaturalFloor:new("blends_natural_01_64", "blends_natural_01_64", dirtBag, playerObj), playerObj:getPlayerNum());
end


Events.OnFillWorldObjectContextMenu.Add(ISInventoryBuildMenu.doBuildMenu);
