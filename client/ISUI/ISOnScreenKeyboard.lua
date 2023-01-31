--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISOnScreenKeyboard = ISPanelJoypad:derive("ISOnScreenKeyboard")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)

-----

-- The text-entry box at the top of the keyboard
OnScreenKeyboardEntry = ISPanelJoypad:derive("OnScreenKeyboardEntry")

function OnScreenKeyboardEntry:instantiate()
	self.javaObject = UITextBox2.new(UIFont.Large, self.x, self.y, self.width, self.height, "", false)
	self.javaObject:setTable(self)
	self.javaObject:setX(self.x)
	self.javaObject:setY(self.y)
	self.javaObject:setWidth(self.width)
	self.javaObject:setHeight(self.height)
	self.javaObject:setAnchorLeft(self.anchorLeft)
	self.javaObject:setAnchorRight(self.anchorRight)
	self.javaObject:setAnchorTop(self.anchorTop)
	self.javaObject:setAnchorBottom(self.anchorBottom)
	self.javaObject:setEditable(true)
end

function OnScreenKeyboardEntry:render()
	ISPanelJoypad.render(self)
	if self.joyfocus then
		self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
		self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
	end
	self:drawTextureScaled(Joypad.Texture.LBumper, self.width - 32, 2, FONT_HGT_SMALL * 1.5, FONT_HGT_SMALL * 1.5, 1, 1, 1, 1)
end

function OnScreenKeyboardEntry:update()
	if self.joyfocus then
		self.parent:checkRightTrigger(self.joyfocus)
	end
end

function OnScreenKeyboardEntry:focus()
	return self.javaObject:focus()
end

function OnScreenKeyboardEntry:unfocus()
	return self.javaObject:unfocus()
end

function OnScreenKeyboardEntry:isFocused()
	return self.javaObject:isFocused()
end

function OnScreenKeyboardEntry:getText()
	return self.javaObject:getText()
end

function OnScreenKeyboardEntry:getInternalText()
	return self.javaObject:getInternalText()
end

function OnScreenKeyboardEntry:setText(str)
	str = str or ""
	self.javaObject:SetText(str)
end

function OnScreenKeyboardEntry:getCursorLine()
	return self.javaObject:getCursorLine()
end

function OnScreenKeyboardEntry:setCursorLine(line)
	self.javaObject:setCursorLine(line)
end

function OnScreenKeyboardEntry:isMasked()
	return self.javaObject:isMasked()
end

function OnScreenKeyboardEntry:setMasked(masked)
	self.javaObject:setMasked(masked)
end

function OnScreenKeyboardEntry:setMultipleLine(multipleLine)
	self.javaObject:setMultipleLine(multipleLine)
end

function OnScreenKeyboardEntry:isMultipleLine()
	return self.javaObject:isMultipleLine()
end

function OnScreenKeyboardEntry:setMaxLines(max)
	self.javaObject:setMaxLines(max)
end

function OnScreenKeyboardEntry:setCursorPos(charIndex)
	self.javaObject:setCursorPos(charIndex)
end

function OnScreenKeyboardEntry:getCursorPos()
	return self.javaObject:getCursorPos()
end

function OnScreenKeyboardEntry:onJoypadDirLeft(joypadData)
	queueKeyEvent(Keyboard.KEY_LEFT)
end

function OnScreenKeyboardEntry:onJoypadDirRight(joypadData)
	queueKeyEvent(Keyboard.KEY_RIGHT)
end

function OnScreenKeyboardEntry:onJoypadDirUp(joypadData)
	if self:isMultipleLine() then
		queueKeyEvent(Keyboard.KEY_UP)
	end
end

function OnScreenKeyboardEntry:onJoypadDirDown(joypadData)
	if self:isMultipleLine() then
		queueKeyEvent(Keyboard.KEY_DOWN)
	else
		joypadData.focus = self.parent.keyPanel
	end
end

function OnScreenKeyboardEntry:onJoypadDown(button, joypadData)
	if button == Joypad.BButton or button == Joypad.XButton then
		self.parent.keyPanel:onJoypadDown(button, joypadData)
		return
	end
	if button == Joypad.LBumper then
		joypadData.focus = self.parent.keyPanel
		return
	end
	if button == Joypad.LStickButton then
		self.parent.capsLock = not self.parent.capsLock
		return
	end
end

function OnScreenKeyboardEntry:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.backgroundColor = {r=0, g=0, b=0, a=0.5}
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	return o
end

-----

-- The panel that contains all the keyboard buttons
OnScreenKeyboardPanel = ISPanelJoypad:derive("OnScreenKeyboardPanel")

function OnScreenKeyboardPanel:createChildren()
	local mult = 2
	self.buttonX = 0
	self.buttonY = 0
	self.buttonW = 40 * mult
	self.buttonH = 32 * mult
	self.buttonPadX = 4 * mult
	self.buttonPadY = 4 * mult

	local button
	
	self.rowOfButtons = {}
	self.buttonX = 0
	self.buttonY = 0
	self:createButton_Char("`", "~")
	self:createButton_Char("1", "!")
	self:createButton_Char("2", "@")
	self:createButton_Char("3", "#")
	self:createButton_Char("4", "$")
	self:createButton_Char("5", "%")
	self:createButton_Char("6", "^")
	self:createButton_Char("7", "&")
	self:createButton_Char("8", "*")
	self:createButton_Char("9", "(")
	self:createButton_Char("0", ")")
	self:createButton_Char("-", "_")
	self:createButton_Char("=", "+")
	button = self:createButton2(self.buttonX, self.buttonY, self.buttonW * 1.5 + self.buttonPadX / 2, self.buttonH, "DELETE", ISOnScreenKeyboard.KeyFunction_KeyCode, Keyboard.KEY_BACK)
	button:setFont(UIFont.Medium)
	button:setJoypadButton(Joypad.Texture.XButton)
	self:insertNewListOfButtons(self.rowOfButtons)

	self.rowOfButtons = {}
	self.buttonX = self.buttonW + self.buttonPadX + self.buttonW / 2 + self.buttonPadX / 2
	self.buttonY = self.buttonY + self.buttonH + self.buttonPadY
	local rowX = self.buttonX
	self:createButton_Char("q", "Q")
	self:createButton_Char("w", "W")
	self:createButton_Char("e", "E")
	self:createButton_Char("r", "R")
	self:createButton_Char("t", "T")
	self:createButton_Char("y", "Y")
	self:createButton_Char("u", "U")
	self:createButton_Char("i", "I")
	self:createButton_Char("o", "O")
	self:createButton_Char("p", "P")
	self:createButton_Char("[", "{")
	self:createButton_Char("]", "}")
	self:createButton_Char("\\", "|")
	self:insertNewListOfButtons(self.rowOfButtons)

	self.rowOfButtons = {}
	self.buttonX = rowX + self.buttonW / 2 + self.buttonPadX / 2
	self.buttonY = self.buttonY + self.buttonH + self.buttonPadY
	rowX = self.buttonX
	button = self:createButton2(0, self.buttonY, rowX - self.buttonPadX, self.buttonH, "CAPS", ISOnScreenKeyboard.KeyFunction_CapsLock)
	button:setFont(UIFont.Medium)
	button:setJoypadButton(Joypad.Texture.LStick)
	self.parent.buttonCapsLock = button
	self:createButton_Char("a", "A")
	self:createButton_Char("s", "S")
	self:createButton_Char("d", "D")
	self:createButton_Char("f", "F")
	self.defaultButton = self:createButton_Char("g", "G")
	self:createButton_Char("h", "H")
	self:createButton_Char("j", "J")
	self:createButton_Char("k", "K")
	self:createButton_Char("l", "L")
	self:createButton_Char(";", ":")
	self:createButton_Char("'", "\"")
	self.parent.buttonEnter = self:createButton2(self.buttonX, self.buttonY, self.buttonW * 1.5 + self.buttonPadX / 2, self.buttonH, "ACCEPT", ISOnScreenKeyboard.KeyFunction_Enter)
	self.parent.buttonEnter:setFont(UIFont.Medium)
	self.parent.buttonEnter:setJoypadButton(Joypad.Texture.RTrigger)
	self.parent.buttonEnter.chLower = "ACCEPT"
	self.parent.buttonEnter.chUpper = "ENTER"
	self:insertNewListOfButtons(self.rowOfButtons)

	self.rowOfButtons = {}
	self.buttonX = rowX + self.buttonW / 2 + self.buttonPadX / 2
	self.buttonY = self.buttonY + self.buttonH + self.buttonPadY
	rowX = self.buttonX
	button = self:createButton2(0, self.buttonY, rowX - self.buttonPadX, self.buttonH, "SHIFT", ISOnScreenKeyboard.KeyFunction_KeyCode, Keyboard.KEY_LSHIFT)
	button:setFont(UIFont.Medium)
	button:setJoypadButton(Joypad.Texture.LTrigger)
	self.parent.buttonLShift = button
	self:createButton_Char("z", "Z")
	self:createButton_Char("x", "X")
	self:createButton_Char("c", "C")
	self:createButton_Char("v", "V")
	self:createButton_Char("b", "B")
	self:createButton_Char("n", "N")
	self:createButton_Char("m", "M")
	self:createButton_Char(",", "<")
	self:createButton_Char(".", ">")
	self:createButton_Char("/", "?")
	button = self:createButton2(self.buttonX, self.buttonY, self.buttonW * 2.0 + self.buttonPadX, self.buttonH, "SHIFT", ISOnScreenKeyboard.KeyFunction_KeyCode, Keyboard.KEY_LSHIFT)
	button:setFont(UIFont.Medium)
	button:setJoypadButton(Joypad.Texture.LTrigger)
	self.parent.buttonRShift = button
	self:insertNewListOfButtons(self.rowOfButtons)

	self.rowOfButtons = {}
	self.buttonX = rowX + self.buttonW * 2 + self.buttonPadX * 2
	self.buttonY = self.buttonY + self.buttonH + self.buttonPadY

	button = self:createButton2(0, self.buttonY, self.buttonW, self.buttonH, "", ISOnScreenKeyboard.KeyFunction_TogglePassword)
	button:setImage(getTexture("media/textures/Foraging/eyeconOn_Shade_UI.png"))
	self.parent.buttonPassword = button

	button = self:createButton2(self.buttonX, self.buttonY, self.buttonW * 5 + self.buttonPadX * 4, self.buttonH, "SPACE", ISOnScreenKeyboard.KeyFunction_Char, " ", " ")
	button:setFont(UIFont.Medium)
	button:setJoypadButton(Joypad.Texture.YButton)
	self.buttonX = self.buttonX + self.buttonW * 5 + self.buttonPadX * 4 + self.buttonPadX + self.buttonW + self.buttonPadX
	self:createButton2(self.buttonX, self.buttonY, self.buttonW, self.buttonH, "<", ISOnScreenKeyboard.KeyFunction_KeyCode, Keyboard.KEY_LEFT)
	self.buttonX = self.buttonX + self.buttonW + self.buttonPadX
	self:createButton2(self.buttonX, self.buttonY, self.buttonW, self.buttonH, ">", ISOnScreenKeyboard.KeyFunction_KeyCode, Keyboard.KEY_RIGHT)
	self.buttonX = self.buttonX + self.buttonW + self.buttonPadX
	button = self:createButton2(self.buttonX, self.buttonY, self.buttonW * 2.0 + self.buttonPadX, self.buttonH, "CANCEL", ISOnScreenKeyboard.KeyFunction_Hide)
	button:setFont(UIFont.Medium)
	button:setJoypadButton(Joypad.Texture.BButton)
	self:insertNewListOfButtons(self.rowOfButtons)

	self.joypadIndexY = 1
	self.joypadIndex = 1
end

function OnScreenKeyboardPanel:createButton_Char(chLower, chUpper)
	local button = self:createButton(chLower, chUpper, ISOnScreenKeyboard.KeyFunction_Char, chLower, chUpper)
	button.chLower = chLower
	button.chUpper = chUpper
	return button
end

function OnScreenKeyboardPanel:createButton(textLower, textUpper, keyFunction, arg1, arg2)
	local x,y = self.buttonX,self.buttonY
	local w,h = self.buttonW,self.buttonH
	local text = textLower
	local button = self:createButton2(x, y, w, h, text, keyFunction, arg1, arg2)
	self.buttonX = x + w + self.buttonPadX
	return button
end

function OnScreenKeyboardPanel:createButton2(x, y, w, h, text, keyFunction, arg1, arg2)
	local button = ISButton:new(x, y, w, h, text, self, self.onButtonPressed)
	button.render = OnScreenKeyboardPanel.renderButton
--	button:setRepeatWhilePressed(function(self, button) keyFunction(self, arg1, arg2) end)
	button.keyFunction = function(self) keyFunction(self.parent, arg1, arg2) end
	button:setFont(UIFont.Large)
	button.joypadTextureWH = 22
	self:addChild(button)
	table.insert(self.rowOfButtons, button)
	return button
end

function OnScreenKeyboardPanel:renderButton()
	self.fade:setFadeIn((self.mouseOver and self:isMouseOver()) and self.enable or self.joypadFocused or false)
	self.fade:update()
	local f = self.fade:fraction()
	local fill = self.backgroundColorMouseOver
	if self.pressed then
		self.backgroundColorPressed = self.backgroundColorPressed or {}
		self.backgroundColorPressed.r = self.backgroundColorMouseOver.r * 0.5
		self.backgroundColorPressed.g = self.backgroundColorMouseOver.g * 0.5
		self.backgroundColorPressed.b = self.backgroundColorMouseOver.b * 0.5
		self.backgroundColorPressed.a = self.backgroundColorMouseOver.a
		fill = self.backgroundColorPressed
	end
	self:drawRect(0, 0, self.width, self.height,
		fill.a * f + self.backgroundColor.a * (1 - f),
		fill.r * f + self.backgroundColor.r * (1 - f),
		fill.g * f + self.backgroundColor.g * (1 - f),
		fill.b * f + self.backgroundColor.b * (1 - f))
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	ISButton.render(self)
end

function OnScreenKeyboardPanel:onButtonPressed(button)
	button.keyFunction(self)
end

function OnScreenKeyboardPanel:render()
	ISPanelJoypad.render(self)
--[[
	if self.joyfocus then
		self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
		self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
	end
--]]
end

function OnScreenKeyboardPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	if self.defaultButton and self.parent.bSelectDefaultKey then
		self.parent.bSelectDefaultKey = false
		self:setJoypadFocus(self.defaultButton, joypadData)
	end
	self:restoreJoypadFocus(joypadData)
end

function OnScreenKeyboardPanel:onJoypadDirUp(joypadData)
	if self.joypadIndexY == 1 then
		self.parent:focusOnEntry(joypadData)
		return
	end
	ISPanelJoypad.onJoypadDirUp(self, joypadData)
end

function OnScreenKeyboardPanel:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self.parent:hide()
		return
	end
	if button == Joypad.XButton then
		queueKeyEvent(Keyboard.KEY_BACK)
		return
	end
	if button == Joypad.YButton then
		queueCharEvent(" ")
		return
	end
	if button == Joypad.LBumper then
		self.parent:focusOnEntry(joypadData)
		return
	end
	if button == Joypad.LStickButton then
		self.parent.capsLock = not self.parent.capsLock
		return
	end
	ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function OnScreenKeyboardPanel:new(x, y, parent)
	local o = ISPanelJoypad.new(self, x, y, 100, 100)
	o.parent = parent -- hack for createChildren()
	o:noBackground()
	return o
end

-----

function ISOnScreenKeyboard:createChildren()
	self.toggleButtonBG = { r = 0.5, g = 0.75, b = 1.0, a = 1 }

	self.entry = OnScreenKeyboardEntry:new(0, 0, 100, FONT_HGT_LARGE + 2 * 2)
	self:addChild(self.entry)

	local mult = 2
	self.buttonPadY = 4 * mult
	self.keyPanel = OnScreenKeyboardPanel:new(0, self.entry:getBottom() + self.buttonPadY, self)
	self:addChild(self.keyPanel)

	self:shrinkWrap(self.keyPanel)
	self.keyPanel:setHeight(self.keyPanel.height + self.buttonPadY)
	self:shrinkWrap(self)

	self.entry:setWidth(self.width)
end

function ISOnScreenKeyboard:KeyFunction_Char(chLower, chUpper)
	if not self.entry:isFocused() then
		self.entry:focus()
	end
	queueCharEvent(self.shiftDown and chUpper or chLower)
end

function ISOnScreenKeyboard:KeyFunction_KeyCode(keyCode)
	if not self.entry:isFocused() then
		self.entry:focus()
	end
	queueKeyEvent(keyCode)
end

function ISOnScreenKeyboard:KeyFunction_CapsLock()
	self.capsLock = not self.capsLock
end

function ISOnScreenKeyboard:KeyFunction_Enter()
	if self.entry:isMultipleLine() and (self.shiftDown or self.capsLock) then
		self:accept()
		return
	end
	if not self.entry:isMultipleLine() then
		self:accept()
	end
	queueKeyEvent(Keyboard.KEY_RETURN)
end

function ISOnScreenKeyboard:KeyFunction_Hide()
	self:hide()
end

function ISOnScreenKeyboard:KeyFunction_TogglePassword()
	self.entry:setMasked(not self.entry:isMasked())
end

function ISOnScreenKeyboard:accept()
	if self.textEntryBox then
		self.textEntryBox:setText(self.entry:getInternalText())
	end
	self:hide()
end

function ISOnScreenKeyboard:hide()
	if MainScreen.instance.inGame and self.setBlockMovement then
		local playerObj = self.playerNum and getSpecificPlayer(self.playerNum) or nil
		if playerObj then
			playerObj:setBlockMovement(false)
		end
	end
	self.entry:unfocus()
	self:setVisible(false)
	self:removeFromUIManager()
	if self.textEntryBox then
		self.textEntryBox:focus()
	end
	local joypadData = self.joyfocus or self.entry.joyfocus
	if joypadData then
		joypadData.focus = self.prevFocus or self.textEntryBox
	end
end

function ISOnScreenKeyboard:shrinkWrap(panel)
	local xMax = 0
	local yMax = 0
	local children = panel:getChildren()
	for _,child in pairs(children) do
		xMax = math.max(xMax, child:getRight())
		yMax = math.max(yMax, child:getBottom())
	end
	panel:setWidth(xMax)
	panel:setHeight(yMax)
end

function ISOnScreenKeyboard:prerender()
	OnScreenKeyboard.instance = self

	if self.textEntryBox and not self.textEntryBox:isReallyVisible() then
		self:hide()
		return
	end

	local DURATION = 100
	self.transition = math.min(self.transition + UIManager.getMillisSinceLastRender(), DURATION)
	self:setY(getCore():getScreenHeight() - self.height * 0.5 - self.height * 0.5 * (self.transition / DURATION))

	if self.textEntryBox then
--		self.entry:setText(self.textEntryBox:getInternalText())
--		self.entry:setCursorPos(self.textEntryBox:getCursorPos())
		self.entry.javaObject:focus() -- show the cursor, but don't actually take the focus
	end
--[[
	if self.textEntryBox then -- and not self.textEntryBox.javaObject:isFocused() then
		self.textEntryBox:focus() -- user could be clicking buttons with the mouse
	end
--]]
	self:bringToTop()

	self:setX((getCore():getScreenWidth() - self.width) / 2)
--	self:setY(getCore():getScreenHeight() - self.height)

	if self.capsLock then
		self.buttonCapsLock.backgroundColor = self.toggleButtonBG
	else
		self.buttonCapsLock.backgroundColor = { r = 0, g = 0, b = 0, a = 1 }
	end

	if self.joyfocus and isJoypadLTPressed(self.joyfocus.id) then
		self.buttonLShift.backgroundColor = self.toggleButtonBG
	else
		self.buttonLShift.backgroundColor = { r = 0, g = 0, b = 0, a = 1 }
	end
	self.buttonRShift.backgroundColor = self.buttonLShift.backgroundColor

	if self.entry:isMasked() then
		self.buttonPassword.backgroundColor = { r = 0, g = 0, b = 0, a = 1 }
	else
		self.buttonPassword.backgroundColor = self.toggleButtonBG
	end

	ISPanelJoypad.prerender(self)
end

function ISOnScreenKeyboard:update()
	if not self.joyfocus then return end

	if JoypadState.controllers[self.joyfocus.id] and not JoypadState.controllers[self.joyfocus.id].connected then
		self:hide()
		return
	end

	-- Left Trigger is "Shift"
	if self.capsLock or isJoypadLTPressed(self.joyfocus.id) then
		if not self.shiftDown then
			self.shiftDown = true
			self:setButtonNames()
		end
	else
		if self.shiftDown then
			self.shiftDown = false
			self:setButtonNames()
		end
	end

	self:checkRightTrigger(self.joyfocus)
end

function ISOnScreenKeyboard:setButtonNames()
	local children = self.keyPanel:getChildren()
	for _,child in pairs(children) do
		if child.Type == "ISButton" and child.chLower then
			child:setTitle(self.shiftDown and child.chUpper or child.chLower)
		end
	end
end

function ISOnScreenKeyboard:onMouseDownOutside(x, y)
	return true -- consume mouseclicks outside the keyboard
end

function ISOnScreenKeyboard:checkRightTrigger(joypadData)
	if isJoypadRTPressed(joypadData.id) then
		if not self.isRTPressed then
			self.isRTPressed = true
			if self.entry:isMultipleLine() then
				self:KeyFunction_Enter()
			end
		end
	else
		if self.isRTPressed then
			self.isRTPressed = false
			if not self.entry:isMultipleLine() then
				self:KeyFunction_Enter()
			end
		end
	end
end

function ISOnScreenKeyboard:show(playerNum, textEntryBox, joypadData)
	self.playerNum = playerNum
	self.textEntryBox = textEntryBox
	self.entry:setMasked(textEntryBox and textEntryBox.javaObject:isMasked() or false)
	self.buttonPassword:setVisible(self.entry:isMasked())
	if textEntryBox then
		textEntryBox:unfocus()
		self.entry:setText(textEntryBox:getInternalText())
	else
		self.entry:setText("")
	end
	self:setY(getCore():getScreenHeight())
	self.transition = 0
	self.bSelectDefaultKey = true
	self:setMultipleLine(textEntryBox and textEntryBox.javaObject:isMultipleLine() or false)
--	self:setVisible(true, joypadData)
	self:setVisible(true, nil)
	self:addToUIManager()

	self.isRTPressed = joypadData and isJoypadRTPressed(joypadData.id) or false

	self.setBlockMovement = false
	if MainScreen.instance.inGame then
		local playerObj = self.playerNum and getSpecificPlayer(playerNum) or nil
		if playerObj and not playerObj:isBlockMovement() then
			self.setBlockMovement = true
			playerObj:setBlockMovement(true)
		end
	end
end

function ISOnScreenKeyboard:setMultipleLine(multipleLine)
--multipleLine = true
	self.entry:setMultipleLine(multipleLine)
	if multipleLine then
		self.buttonEnter:setTitle("ENTER")
		self.buttonEnter.chLower = "ENTER"
		self.buttonEnter.chUpper = "ACCEPT"
		self.entry:setMaxLines(self.textEntryBox and self.textEntryBox:getMaxLines() or 10)
--self.entry:setMaxLines(10)
		self.entry:setHeight(FONT_HGT_LARGE * 8 + 2 * 2)
	else
		self.buttonEnter:setTitle("ACCEPT")
		self.buttonEnter.chLower = nil
		self.buttonEnter.chUpper = nil
		self.entry:setMaxLines(1)
		self.entry:setHeight(FONT_HGT_LARGE + 2 * 2)
	end
	self.keyPanel:setY(self.entry:getBottom() + self.buttonPadY)
	self:setHeight(self.keyPanel:getBottom())
end

function ISOnScreenKeyboard:getCurrentText()
	return self.entry:getInternalText()
end

function ISOnScreenKeyboard:focusOnEntry(joypadData)
	self.keyPanel:clearJoypadFocus(joypadData)
	joypadData.focus = self.entry
end

function ISOnScreenKeyboard:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	joypadData.focus = self.keyPanel
	updateJoypadFocus(joypadData)
end

function ISOnScreenKeyboard:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.backgroundColor.a = 0.9
	o.keepOnScreen = false
	o.transition = 0
	OnScreenKeyboard.instance = o
	return o
end

-----

OnScreenKeyboard = {}

function OnScreenKeyboard.IsVisible()
	return OnScreenKeyboard.instance ~= nil and OnScreenKeyboard.instance:isReallyVisible()
end

function OnScreenKeyboard.Hide()
	if not OnScreenKeyboard.IsVisible() then return end
	OnScreenKeyboard.instance:hide()
end

function OnScreenKeyboard.Show(playerNum, textEntryBox, joypadData)
	if OnScreenKeyboard.IsVisible() then
		return OnScreenKeyboard.instance
	end
	if not OnScreenKeyboard.instance then
		OnScreenKeyboard.instance = ISOnScreenKeyboard:new(0, 0, 100, 100)
		OnScreenKeyboard.instance:initialise()
		OnScreenKeyboard.instance:instantiate()
		OnScreenKeyboard.instance:setAlwaysOnTop(true)
	end
	OnScreenKeyboard.instance:show(playerNum, textEntryBox, joypadData)
	return OnScreenKeyboard.instance
end

function OnScreenKeyboard.GetCurrentText()
	return OnScreenKeyboard.IsVisible() and OnScreenKeyboard.instance:getCurrentText() or ""
end

