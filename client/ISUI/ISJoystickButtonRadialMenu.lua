--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISJoystickButtonRadialMenu = {}
local STATE = {}
STATE[1] = {}
STATE[2] = {}
STATE[3] = {}
STATE[4] = {}

function ISJoystickButtonRadialMenu.onJoypadDown(button, joypadData)
	local playerNum = joypadData.player
	local playerObj = getSpecificPlayer(playerNum)
	if playerObj:getVehicle() then
		return
	end
	if button == Joypad.LStickButton then
		STATE[playerNum+1].leftPressedMS = getTimestampMs()
		-- Disable auto-walk while the radial menu is displayed
		STATE[playerNum+1].wasAutoWalk = playerObj:isAutoWalk()
		if playerObj:isAutoWalk() then
			playerObj:setAutoWalk(false)
		end
	end
end

function ISJoystickButtonRadialMenu.onJoypadButtonReleased(button, joypadData)
	local playerNum = joypadData.player
	local playerObj = getSpecificPlayer(playerNum)
	if playerObj:getVehicle() then
		return
	end
	if button == Joypad.LStickButton then
		if STATE[playerNum+1].leftPressedMS == nil then
			return
		end
		if getTimestampMs() - STATE[playerNum+1].leftPressedMS < 250 then
			-- Quick click/release without displaying the radial menu.
			-- TODO: Add an Accesibility option to choose the action.
			ISJoystickButtonRadialMenu.onToggleCrouch(playerObj)
		end
		STATE[playerNum+1].leftPressedMS = nil
		if STATE[playerNum+1].wasAutoWalk then
			STATE[playerNum+1].wasAutoWalk = false
			playerObj:setAutoWalk(true)
		end
	end
end

-- Called by ISButtonPrompt.update()
function ISJoystickButtonRadialMenu.onRepeatLeftStickButton(joypadData)
	local playerNum = joypadData.player
	local playerObj = getSpecificPlayer(playerNum)
	if playerObj:getVehicle() then
		return
	end
	local menu = getPlayerRadialMenu(playerNum)
	if menu:isReallyVisible() then
		return
	end
	if not getCore():getOptionEnableLeftJoystickRadialMenu() then
		return
	end
	if not STATE[playerNum+1].leftPressedMS then
		return
	end
	local delay = 250
	if getTimestampMs() - STATE[playerNum+1].leftPressedMS >= delay then
		ISJoystickButtonRadialMenu.displayLeft(joypadData)
	end
end

function ISJoystickButtonRadialMenu.displayLeft(joypadData)
	if isGamePaused() then return end

	local playerNum = joypadData.player
	local playerObj = getSpecificPlayer(playerNum)

	local menu = getPlayerRadialMenu(playerNum)
	menu:clear()

	local texSneak = playerObj:isSneaking() and getTexture("media/ui/emotes/crouch_off.png") or getTexture("media/ui/emotes/crouch_on.png")
	menu:addSlice(getText("IGUI_LeftStickButtonRadial_ToggleCrouch"), texSneak, ISJoystickButtonRadialMenu.onToggleCrouch, playerObj)

	local texSit = playerObj:isSitOnGround() and getTexture("media/ui/emotes/sit_off.png") or getTexture("media/ui/emotes/sit_on.png")
	menu:addSlice(getText("IGUI_LeftStickButtonRadial_ToggleSitOnGround"), texSit, ISJoystickButtonRadialMenu.onToggleSit, playerObj)

	local texAutoWalk = STATE[playerNum+1].wasAutoWalk and getTexture("media/ui/emotes/autowalk_off.png") or getTexture("media/ui/emotes/autowalk_on.png")
	menu:addSlice(getText("IGUI_LeftStickButtonRadial_ToggleAutoWalk"), texAutoWalk, ISJoystickButtonRadialMenu.onToggleAutoWalk, playerObj)

	menu:setX(getPlayerScreenLeft(playerNum) + getPlayerScreenWidth(playerNum) / 2 - menu:getWidth() / 2)
	menu:setY(getPlayerScreenTop(playerNum) + getPlayerScreenHeight(playerNum) / 2 - menu:getHeight() / 2)
	menu:addToUIManager()
	menu:setHideWhenButtonReleased(Joypad.LStickButton)
	setJoypadFocus(playerNum, menu)
	playerObj:setJoypadIgnoreAimUntilCentered(true)
	setPlayerMovementActive(playerNum, false)
end

function ISJoystickButtonRadialMenu.onToggleCrouch(playerObj)
	playerObj:setSneaking(not playerObj:isSneaking())
end

function ISJoystickButtonRadialMenu.onToggleSit(playerObj)
	local playerNum = playerObj:getPlayerNum()
	if playerObj:isCurrentState(PlayerSitOnGroundState.instance()) then
		playerObj:StopAllActionQueue()
		playerObj:setVariable("forceGetUp", true)
	else
		playerObj:setAutoWalk(false)
		STATE[playerNum+1].wasAutoWalk = false
		playerObj:reportEvent("EventSitOnGround")
	end
end

function ISJoystickButtonRadialMenu.onToggleAutoWalk(playerObj)
	local playerNum = playerObj:getPlayerNum()
	local isAutoWalk = STATE[playerNum+1].wasAutoWalk
	playerObj:setAutoWalk(not isAutoWalk)
	if playerObj:isAutoWalk() then
		playerObj:setAutoWalkDirection(playerObj:getForwardDirection())
		playerObj:getAutoWalkDirection():rotate(45 * math.pi / 180)
	end
	STATE[playerNum+1].wasAutoWalk = playerObj:isAutoWalk()
end

