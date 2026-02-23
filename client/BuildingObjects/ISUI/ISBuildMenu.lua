ISBuildMenu = {};
ISBuildMenu.cheat = false or getDebug();

function ISBuildMenu.buildRampsMenu(subMenu, option, playerNum)
	subMenu:addOption("20 North", playerNum, ISBuildMenu.onCreateRamp, "north20")
	subMenu:addOption("20 South", playerNum, ISBuildMenu.onCreateRamp, "south20")
	subMenu:addOption("20 West", playerNum, ISBuildMenu.onCreateRamp, "west20")
	subMenu:addOption("20 East", playerNum, ISBuildMenu.onCreateRamp, "east20")
end

function ISBuildMenu.onCreateRamp(playerNum, which)
	local bo = ISBuildRampCursor:new(getSpecificPlayer(playerNum), which)
	getCell():setDrag(bo, playerNum)
end
