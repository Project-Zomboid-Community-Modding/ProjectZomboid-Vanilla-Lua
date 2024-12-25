--************************************************************************************
--**                        ROBERT JOHNSON  &  FOX CHAOTICA                         **
--**       Contextual menu for building when clicking somewhere on the ground       **
--************************************************************************************

ISBuildMenu = {};
ISBuildMenu.cheat = false or getDebug();
ISBuildMenu.woodWorkXp = 0;
ISBuildMenu.ghs = "<GHC>"
ISBuildMenu.bhs = "<BHC>"

local function predicateNotBroken(item)
	return not item:isBroken()
end

local function predicateSledgehammer(item)
	if item:isBroken() then return false end
	local type = item:getType()
	return item:hasTag("Sledgehammer") or type == "Sledgehammer" or type == "Sledgehammer2"
end

ISBuildMenu.doBuildMenu = function(player, context, worldobjects, test)

	if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode()=="LastStand" then
        return;
    end
	
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

	if playerObj:getVehicle() then return; end

	ISBuildMenu.woodWorkXp = playerObj:getPerkLevel(Perks.Woodwork);
	local thump = nil;

	local square = nil;

	if isDebugEnabled() then
		if test then return ISWorldObjectContextMenu.setTest() end
		local rampsOption = context:addDebugOption("Ramps", nil, nil)
		local subMenuRamps = context:getNew(context)
		context:addSubMenu(rampsOption, subMenuRamps)
		ISBuildMenu.buildRampsMenu(subMenuRamps, rampsOption, player)
	end
			
	-- dismantle stuff
    -- TODO: RJ: removed it for now need to see exactly how it works as now we have a proper right click to dismantle items...
	if playerInv:contains("Saw") and playerInv:contains("Screwdriver") and isDebugEnabled() then
        if test then return ISWorldObjectContextMenu.setTest() end
		context:addOption(getText("ContextMenu_Dismantle"), worldobjects, ISBuildMenu.onDismantle, playerObj);
	end

	-- destroy item with sledgehammer
    if not isClient() or getServerOptions():getBoolean("AllowDestructionBySledgehammer") then
        local sledgehammer = playerInv:getFirstEvalRecurse(predicateSledgehammer)
        if sledgehammer and not sledgehammer:isBroken() or ISBuildMenu.cheat then
            if test then return ISWorldObjectContextMenu.setTest() end
            context:addOption(getText("ContextMenu_Destroy"), worldobjects, ISWorldObjectContextMenu.onDestroy, playerObj, sledgehammer)
        end
    end
end

-- **********************************************
-- **                DISMANTLE                 **
-- **********************************************

ISBuildMenu.onDismantle = function(worldobjects, player)
	local bo = ISDestroyCursor:new(player, true)
	getCell():setDrag(bo, bo.player)
end

function ISBuildMenu.buildRampsMenu(subMenu, option, playerNum)
	local option2 = subMenu:addOption("20 North", playerNum, ISBuildMenu.onCreateRamp, "north20")
	local option2 = subMenu:addOption("20 South", playerNum, ISBuildMenu.onCreateRamp, "south20")
	local option2 = subMenu:addOption("20 West", playerNum, ISBuildMenu.onCreateRamp, "west20")
	local option2 = subMenu:addOption("20 East", playerNum, ISBuildMenu.onCreateRamp, "east20")
end

function ISBuildMenu.onCreateRamp(playerNum, which)
	local bo = ISBuildRampCursor:new(getSpecificPlayer(playerNum), which)
	getCell():setDrag(bo, playerNum)
end

Events.OnFillWorldObjectContextMenu.Add(ISBuildMenu.doBuildMenu);
