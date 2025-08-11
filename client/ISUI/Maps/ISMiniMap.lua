--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISUIElement"

ISMiniMapOuter = ISPanelJoypad:derive("ISMiniMapOuter")
ISMiniMapInner = ISUIElement:derive("ISMiniMapInner")
ISMiniMapTitleBar = ISPanel:derive("ISMiniMapTitleBar")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local TERRAIN_IMAGE = false

-----

ISMiniMapOptionsPanel = ISCollapsableWindowJoypad:derive("ISMiniMapOptionsPanel")

function ISMiniMapOptionsPanel:onTickBox(index, selected, option)
	if option:getName() == "ColorblindPatterns" then
		getCore():setOptionColorblindPatterns(selected)
		return
	end
	option:setValue(selected)
end

function ISMiniMapOptionsPanel:onCommandEntered(entry, option)
	option:parse(entry:getText())
end

function ISMiniMapOptionsPanel:createChildren()
	local entryHgt = BUTTON_HGT

	local x = UI_BORDER_SPACING+1
	local y = self:titleBarHeight() + 6

	self.doubleBoxes = {}
	self.tickBoxes = {}

	self.showAllOptions = false
	if getDebug() or (isClient() and (getAccessLevel() == "admin")) then
--		self.showAllOptions = true
	end

	local maxHeight = getCore():getScreenHeight() - 100

	self.joypadButtonsY = {}
	self.joypadIndex = 1
	self.joypadIndexY = 1

	local maxWidth = 0

	local visibleOptions = self:getVisibleOptions()
	for i,option in ipairs(visibleOptions) do
		if option:getType() == "boolean" then
			local tickBox = ISTickBox:new(x, y, self.width, entryHgt, "", self, self.onTickBox, option)
			tickBox:initialise()
			local text = getTextOrNull("IGUI_MapOption_" .. option:getName()) or option:getName()
			tickBox:addOption(text, option)
			tickBox:setSelected(1, option:getValue())
			tickBox:setWidthToFit()
			self:addChild(tickBox)
			maxWidth = math.max(maxWidth, tickBox:getRight())
			table.insert(self.tickBoxes, i, tickBox)
			self:insertNewLineOfButtons(tickBox)
			y = y + entryHgt + 6
		end
		if option:getType() == "double" then
			local text = getTextOrNull("IGUI_MapOption_" .. option:getName()) or option:getName()
			local label = ISLabel:new(x, y, entryHgt, text, 1, 1, 1, 1, UIFont.Small, true)
			self:addChild(label)
			local entry = ISTextEntryBox:new("", label:getRight()+4, y, 100, entryHgt)
			entry.onCommandEntered = function(self) self.parent:onCommandEntered(entry, option) end
			self:addChild(entry)
			entry:setOnlyNumbers(true)
			maxWidth = math.max(maxWidth, entry:getRight())
			table.insert(self.doubleBoxes, i, entry)
			self:insertNewLineOfButtons(entry)
			y = y + entryHgt + 6
		end
		if y + entryHgt + 6 >= maxHeight then
			x = x + maxWidth
			y = self:titleBarHeight() + 6
			maxWidth = 0
		end
	end

	local width = 0
	local height = 0
	for _,child in pairs(self:getChildren()) do
		width = math.max(width, child:getRight())
		height = math.max(height, child:getBottom())
	end
	self:setWidth(width + UI_BORDER_SPACING + 1)
	self:setHeight(height + self:resizeWidgetHeight())

	self.screenHeight = getCore():getScreenHeight()
end

function ISMiniMapOptionsPanel:getVisibleOptions()
	local result = {}
	if self.showAllOptions then
		for i=1,self.map.mapAPI:getOptionCount() do
			local option = self.map.mapAPI:getOptionByIndex(i-1)
			if isClient() or not self:isMultiplayerOption(option:getName()) then
				table.insert(result, option)
			end
		end
		return result;
	end
	local optionNames = {}
	table.insert(optionNames, "Isometric")
	table.insert(optionNames, "Symbols")
	if TERRAIN_IMAGE then
	    table.insert(optionNames, "TerrainImage")
	end
	for _,optionName in ipairs(optionNames) do
		for i=1,self.map.mapAPI:getOptionCount() do
			local option = self.map.mapAPI:getOptionByIndex(i-1)
			if optionName == option:getName() then
				table.insert(result, option)
				break
			end
		end
	end
	return result
end

function ISMiniMapOptionsPanel:isMultiplayerOption(optionName)
	return optionName == "RemotePlayers" or optionName == "PlayerNames"
end

function ISMiniMapOptionsPanel:synchUI()
	local showAllOptions = false
	if getDebug() or (isClient() and (getAccessLevel() == "admin")) then
		showAllOptions = true
	end
	if showAllOptions ~= self.showAllOptions or self.screenHeight ~= getCore():getScreenHeight() then
		local children = {}
		for k,v in pairs(self:getChildren()) do
			table.insert(children, v)
		end
		for _,child in ipairs(children) do
			self:removeChild(child)
		end
		self:createChildren()
	end

	local visibleOptions = self:getVisibleOptions()
	for i,option in ipairs(visibleOptions) do
		if option:getType() == "boolean" then
			self.tickBoxes[i]:setSelected(1, option:getValue())
		end
		if option:getType() == "double" then
			self.doubleBoxes[i]:setText(option:getValueAsString())
		end
	end
end

function ISMiniMapOptionsPanel:onMouseDownOutside(x, y)
	if self:isMouseOver() then
		return -- click in ISTextEntryBox
	end
	if self.parent.parent.bottomPanel:isMouseOver() then
		return
	end
	self:setVisible(false)
	if self.joyfocus then
		setJoypadFocus(joypadData.player, self.parent.parent)
	end
end

function ISMiniMapOptionsPanel:onGainJoypadFocus(joypadData)
	ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
	self:restoreJoypadFocus()
end

function ISMiniMapOptionsPanel:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self:setVisible(false)
		setJoypadFocus(joypadData.player, self.parent.parent)
		return
	end
	ISCollapsableWindowJoypad.onJoypadDown(self, button, joypadData)
end

function ISMiniMapOptionsPanel:new(x, y, width, height, map)
	local o = ISCollapsableWindowJoypad.new(self, x, y, width, height)
	o.backgroundColor = {r=0, g=0, b=0, a=1.0}
	o.resizable = false
	o.map = map
	return o
end

-----

function ISMiniMapInner:instantiate()
	self.javaObject = UIWorldMap.new(self)
	self.mapAPI = self.javaObject:getAPIv3()
	self.mapAPI:setMapItem(MapItem.getSingleton())
	self.mapAPI:setMaxZoom(20)
	self.javaObject:setX(self.x)
	self.javaObject:setY(self.y)
	self.javaObject:setWidth(self.width)
	self.javaObject:setHeight(self.height)
	self.javaObject:setAnchorLeft(self.anchorLeft)
	self.javaObject:setAnchorRight(self.anchorRight)
	self.javaObject:setAnchorTop(self.anchorTop)
	self.javaObject:setAnchorBottom(self.anchorBottom)
	self:createChildren()
end

function ISMiniMapInner:prerender()
	MapUtils.renderDarkModeOverlay(self)
	if TERRAIN_IMAGE then
	    self:checkTerrainImage()
	end
    self.mapAPI:getSymbolsAPIv2():initDefaultAnnotations() -- only needed when the map editor changed things
end

function ISMiniMapInner:prerenderHack()
	if self.dragging then return end
	local playerObj = getSpecificPlayer(self.playerNum)
	if not playerObj then return end
	local vehicle = playerObj:getVehicle()
	if vehicle then
		self.mapAPI:centerOn(vehicle:getX(), vehicle:getY())
	else
		self.mapAPI:centerOn(playerObj:getX(), playerObj:getY())
	end
end

function ISMiniMapInner:onMouseDown(x, y)
	self.dragging = true
	self.dragMoved = false
	self.dragStartX = x
	self.dragStartY = y
	self.dragStartCX = self.mapAPI:getCenterWorldX()
	self.dragStartCY = self.mapAPI:getCenterWorldY()
	self.dragStartZoomF = self.mapAPI:getZoomF()
	self.dragStartWorldX = self.mapAPI:uiToWorldX(x, y)
	self.dragStartWorldY = self.mapAPI:uiToWorldY(x, y)
	return true
end

function ISMiniMapInner:onMouseUp(x, y)
	if self.dragging then
		self.dragging = false
		if self.dragMoved then return end
		ISWorldMap.ToggleWorldMap(self.playerNum)
	end
end

function ISMiniMapInner:onMouseUpOutside(x, y)
	self:onMouseUp(x, y)
end

function ISMiniMapInner:onMouseMove(dx, dy)
	if self.dragging then
		local mouseX = self:getMouseX()
		local mouseY = self:getMouseY()
		if not self.dragMoved and math.abs(mouseX - self.dragStartX) <= 4 and math.abs(mouseY - self.dragStartY) <= 4 then
			return
		end
		self.dragMoved = true
		local worldX = self.mapAPI:uiToWorldX(mouseX, mouseY, self.dragStartZoomF, self.dragStartCX, self.dragStartCY)
		local worldY = self.mapAPI:uiToWorldY(mouseX, mouseY, self.dragStartZoomF, self.dragStartCX, self.dragStartCY)
		self.mapAPI:centerOn(self.dragStartCX + self.dragStartWorldX - worldX, self.dragStartCY + self.dragStartWorldY - worldY)
		return true
	end
	return false
end

function ISMiniMapInner:onMouseMoveOutside(dx, dy)
	return self:onMouseMove(dx, dy)
end

function ISMiniMapInner:onMouseWheel(del)
	self.mapAPI:zoomAt(self.width / 2, self.height / 2, del)
	return true
end

function ISMiniMapInner:onRightMouseDown(x, y)
	self.rightMouseDown = true
end

function ISMiniMapInner:onRightMouseUp(x, y)
	if not self.rightMouseDown then return end
	self.rightMouseDown = false

	local playerNum = 0
	local playerObj = getSpecificPlayer(0)
	if not playerObj then return end
	local context = ISContextMenu.get(playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY())

	local worldX = self.mapAPI:uiToWorldX(x, y)
	local worldY = self.mapAPI:uiToWorldY(x, y)
	if getDebug() and getWorld():getMetaGrid():isValidChunk(worldX / 10, worldY / 10) then
		local option = context:addOption(getText("IGUI_ZombiePopulation_TeleportHere"), self, self.onTeleport, worldX, worldY)
	end

	if context.numOptions == 1 then
		context:setVisible(false)
	end
end

function ISMiniMapInner:onRightMouseUpOutside(x, y)
	self.rightMouseDown = false
end

if TERRAIN_IMAGE then

function ISMiniMapInner:checkTerrainImage()
    if self.isTerrainImage ~= self.mapAPI:getBoolean("TerrainImage") then
        self:onToggleTerrainImage()
    end
end

function ISMiniMapInner:onToggleTerrainImage()
    self.isTerrainImage = not self.isTerrainImage
    if self.isTerrainImage then
	    self:showTerrainImage()
    else
	    MapUtils.initDefaultStyleV1(self)
    end
    self.mapAPI:setBoolean("TerrainImage", self.isTerrainImage)
end

function ISMiniMapInner:showTerrainImage()
    self.mapAPI:setBoolean("ImagePyramid", true)
    local styleAPI = self.mapAPI:getStyleAPI()
    styleAPI:clear()
    local pyramidLayer = styleAPI:newPyramidLayer("pyramid")
    pyramidLayer:setPyramidFileName("pyramid.zip")
    pyramidLayer:addFill(0.0, 255.0, 255.0, 255.0, 255.0)
    MapUtils.initDefaultTextLayersV3(self)
end

end -- TERRAIN_IMAGE

function ISMiniMapInner:onTeleport(worldX, worldY)
	local playerObj = getSpecificPlayer(0)
	if not playerObj then return end
	if isClient() then
		SendCommandToServer("/teleportto " .. tostring(worldX) .. "," .. tostring(worldY) .. ",0");
	else
		playerObj:teleportTo(worldX, worldY, 0.0)
	end
end

function ISMiniMapInner:new(x, y, width, height, playerNum)
	local o = ISUIElement.new(self, x, y, width, height)
	o.playerNum = playerNum
	return o
end

-----

function ISMiniMapTitleBar.TitleBarHeight()
	return math.max(16, FONT_HGT_SMALL + 1)
end

function ISMiniMapTitleBar:prerender()
	local th = self:titleBarHeight()
--	self:drawRect(0, 0, self:getWidth(), th - 1, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
	self:drawTextureScaled(self.titlebarbkg, 1, 1, self:getWidth() - 2, th - 2, 1, 1, 1, 1)
--	self:drawRectBorder(0, 0, self:getWidth(), 0, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
end

function ISMiniMapTitleBar:titleBarHeight()
	return ISMiniMapTitleBar.TitleBarHeight()
end

function ISMiniMapTitleBar:onMouseDown(x, y)
	self.downX = self:getMouseX()
	self.downY = self:getMouseY()
	self.dragging = true
	self:setCapture(true)
	return true
end

function ISMiniMapTitleBar:onMouseUp(x, y)
	self.dragging = false
	self:setCapture(false)
	return true
end

function ISMiniMapTitleBar:onMouseUpOutside(x, y)
	self.dragging = false
	self:setCapture(false)
	return true
end

function ISMiniMapTitleBar:onMouseMove(dx, dy)
	if self.dragging then
		local dx = self:getMouseX() - self.downX
		local dy = self:getMouseY() - self.downY
		self.miniMap.userPosition = true
		self.miniMap:setX(self.miniMap.x + dx)
		self.miniMap:setY(self.miniMap.y + dy)
	end
end

function ISMiniMapTitleBar:onMouseMoveOutside(dx, dy)
	self:onMouseMove(dx, dy)
end

function ISMiniMapTitleBar:new(miniMap)
	local th = ISMiniMapTitleBar.TitleBarHeight()
	local o = ISPanel.new(self, 0, 0, miniMap.width, th)
	o.miniMap = miniMap
	o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png")
	o.dragging = false
	return o
end

-----

function ISMiniMapOuter:createChildren()
	self.inner = ISMiniMapInner:new(self.borderSize, self.borderSize, self.width - self.borderSize * 2,
		self.height - self.borderSize * 2, self.playerNum)
	self:addChild(self.inner)

	self.titleBar = ISMiniMapTitleBar:new(self)
	self:addChild(self.titleBar)
	self.titleBar:setVisible(false)

	local btnWid = BUTTON_HGT
	local btnHgt = BUTTON_HGT
	local btnX = (self.inner.width - btnWid * 5 - UI_BORDER_SPACING * 4) / 2

	self.bottomPanel = ISPanel:new(self.borderSize, self.inner:getBottom() + 1, self.inner.width, btnHgt+UI_BORDER_SPACING*2+2)
	self:addChild(self.bottomPanel)
	self.bottomPanel:setVisible(false)

	self.button1 = ISButton:new(btnX, UI_BORDER_SPACING+1, btnWid, btnHgt, "M", self, ISMiniMapOuter.onButton1)
	self.button1.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	self.bottomPanel:addChild(self.button1)

	self.button2 = ISButton:new(self.button1:getRight() + UI_BORDER_SPACING, self.button1.y, btnWid, btnHgt, "-", self, function(self) end)
	self.button2.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	self.button2:setRepeatWhilePressed(ISMiniMapOuter.onButton2)
	self.bottomPanel:addChild(self.button2)

	self.button3 = ISButton:new(self.button2:getRight() + UI_BORDER_SPACING, self.button1.y, btnWid, btnHgt, "+", self, function(self) end)
	self.button3.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	self.button3:setRepeatWhilePressed(ISMiniMapOuter.onButton3)
	self.bottomPanel:addChild(self.button3)

	self.button4 = ISButton:new(self.button3:getRight() + UI_BORDER_SPACING, self.button1.y, btnWid, btnHgt, "", self, ISMiniMapOuter.onButton4)
	self.button4:setImage(getTexture("media/ui/inventoryPanes/Button_Settings.png"))
	self.button4:forceImageSize(FONT_HGT_SMALL, FONT_HGT_SMALL)
	self.button4.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	self.bottomPanel:addChild(self.button4)

	self.button6 = ISButton:new(self.button4:getRight() + UI_BORDER_SPACING, self.button1.y, btnWid, btnHgt, "X", self, ISMiniMapOuter.onButton6)
	self.button6.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	self.bottomPanel:addChild(self.button6)

	self:insertNewLineOfButtons(self.button1, self.button2, self.button3, self.button4, self.button5, self.button6)
	self.joypadIndex = 1
	self.joypadIndexY = 1
end

function ISMiniMapOuter:prerender()
--	ISPanelJoypad.prerender(self)
	self:setPosition()

	if self.joyfocus or (not (self.inner.dragging and self.inner.dragMoved) and self:isMouseOver()) or self.titleBar:isMouseOver() or self.titleBar.dragging then
		self:setAdornmentsVisible(true)
	else
		self:setAdornmentsVisible(false)
	end

	self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
	self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)

	-- This centers on the player position, but prerender() is called after
	-- the map is rendered.
	self.inner:prerenderHack()
end

function ISMiniMapOuter:render()
	ISPanelJoypad.render(self)

	if self.joyfocus then
		self:drawRectBorder(0, 0, self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
		self:drawRectBorder(1, 1, self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
	end
end

function ISMiniMapOuter:setAdornmentsVisible(visible)
	if visible then
		if self.titleBar:isVisible() then return end
		self.titleBar:setVisible(true)
		self.bottomPanel:setVisible(true)
		self.titleBar:setY(0)
		self.inner:setY(self.titleBar:getBottom() + self.borderSize)
		self.bottomPanel:setY(self.inner:getBottom() + 1)
		self:setY(self.y - self.titleBar.height)
		self:setHeight(self.bottomPanel:getBottom() + self.borderSize)
	else
		if not self.titleBar:isVisible() then return end
		self.titleBar:setVisible(false)
		self.bottomPanel:setVisible(false)
		self.inner:setY(self.borderSize)
		self:setHeight(self.inner.height + self.borderSize * 2)
		self:setY(self.y + self.titleBar.height)
	end
end

function ISMiniMapOuter:setPosition()
	if JoypadState.players[self.playerNum+1] then
		local inventory = getPlayerInventory(self.playerNum)
		if inventory and inventory:isReallyVisible() then
			if not self.hideInventoryX then
				self.hideInventoryX = self.x
			end
			if self.javaObject then
				self.javaObject:setX(getCore():getScreenWidth() + 100)
			end
			return
		end
		if self.hideInventoryX then
			self.javaObject:setX(self.hideInventoryX)
			self.hideInventoryX = nil
		end
	end

	local sx = getPlayerScreenLeft(self.playerNum)
	local sy = getPlayerScreenTop(self.playerNum)
	local sw = getPlayerScreenWidth(self.playerNum)
	local sh = getPlayerScreenHeight(self.playerNum)
	if self.userPosition then
		if self.x < sx then
			self:setX(sx)
		end
		if self:getRight() > sx + sw then
			self:setX(sx + sw - self.width)
		end
		if self.titleBar:isVisible() then
			if self.y < sy then
				self:setY(sy)
			end
			if self:getBottom() > sy + sh then
				self:setY(sy + sh - self.height)
			end
		else
			if self.y < sy + self.titleBar.height then
				self:setY(sy + self.titleBar.height)
			end
			if self:getBottom() + 1 + self.bottomPanel.height > sy + sh then
				self:setY(sy + sh - (self.height + self.bottomPanel.height + 1))
			end
		end
	elseif JoypadState.players[self.playerNum+1] then
		local buttonPrompt = getButtonPrompts(self.playerNum)
		self:setX(sx + sw - 10 - self.width)
		local y = sy + sh - 100
		if buttonPrompt then
			y = buttonPrompt:getTopOf() - 8
		end
		if self.titleBar:isVisible() then
			self:setY(y - (self.height - self.titleBar.height + 1))
		else
			self:setY(y - self.height)
		end
	else
		self:setX(sx + sw - 10 - self.width)
		if self.titleBar:isVisible() then
			self:setY(sy + sh - 100 - (self.height - self.titleBar.height + 1))
		else
			self:setY(sy + sh - 100 - self.height)
		end
	end
end

function ISMiniMapOuter:onButton1()
	ISWorldMap.ToggleWorldMap(self.playerNum)
end

function ISMiniMapOuter:onButton2()
	self.inner.mapAPI:zoomAt(self.inner.width / 2, self.inner.height/ 2, 1)
end

function ISMiniMapOuter:onButton3()
	self.inner.mapAPI:zoomAt(self.inner.width / 2, self.inner.height/ 2, -1)
end

function ISMiniMapOuter:onButton4()
    self:onToggleOptionsPanel()
end

function ISMiniMapOuter:onToggleOptionsPanel()
--	self.inner.mapAPI:setBoolean("Isometric", not self.inner.mapAPI:getBoolean("Isometric"))
	if self.optionsUI == nil then
		local ui = ISMiniMapOptionsPanel:new(0, self.y, 200, 200, self.inner)
		self.inner:addChild(ui)
		ui:setVisible(false)
		self.optionsUI = ui
	end
	if self.optionsUI:isVisible() then
		self.optionsUI:setVisible(false)
		return
	end
	self.optionsUI:synchUI()
	self.optionsUI:setX(0)
	self.optionsUI:setY(self.inner:getHeight() - self.optionsUI.height)
	self.optionsUI:setVisible(true)
	if JoypadState.players[self.playerNum+1] then
		setJoypadFocus(self.playerNum, self.optionsUI)
	end
end

function ISMiniMapOuter:onButton6()
	ISMiniMap.ToggleMiniMap(self.playerNum)
end

function ISMiniMapOuter:saveSettings()
	if self.playerNum ~= 0 then return end
	local settings = WorldMapSettings.getInstance()
	local mapAPI = self.inner.mapAPI
	settings:setDouble("MiniMap.Zoom", mapAPI:getZoomF())
	settings:setBoolean("MiniMap.Isometric", mapAPI:getBoolean("Isometric"))
	settings:setBoolean("MiniMap.ShowSymbols", mapAPI:getBoolean("Symbols"))
	if TERRAIN_IMAGE then
	    settings:setBoolean("MiniMap.TerrainImage", mapAPI:getBoolean("TerrainImage"))
	end
	settings:save()
end

function ISMiniMapOuter:restoreSettings()
	if self.playerNum ~= 0 then return end
	local settings = WorldMapSettings.getInstance()
	if settings:getFileVersion() ~= 1 then return end
	local mapAPI = self.inner.mapAPI
	local zoom = settings:getDouble("MiniMap.Zoom", 0.0)
	local isometric = settings:getBoolean("MiniMap.Isometric")
	local showSymbols = settings:getBoolean("MiniMap.ShowSymbols")
	if TERRAIN_IMAGE then
	    local terrainImage = settings:getBoolean("MiniMap.TerrainImage")
	end
	self.inner.isTerrainImage = terrainImage
	mapAPI:setZoom(zoom)
	mapAPI:setBoolean("Isometric", isometric)
	mapAPI:setBoolean("Symbols", showSymbols)
	if TERRAIN_IMAGE then
	    mapAPI:setBoolean("TerrainImage", terrainImage)
        if terrainImage then
            self.inner:showTerrainImage()
        end
	end
end

function ISMiniMapOuter:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self:restoreJoypadFocus(joypadData)
end

function ISMiniMapOuter:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	self:clearJoypadFocus(joypadData)
end

function ISMiniMapOuter:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
--		self:clearJoypadFocus(joypadData)
		setJoypadFocus(self.playerNum, nil)
		return
	end
	ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISMiniMapOuter:RestoreLayout(name, layout)
    ISLayoutManager.DefaultRestoreWindow(self, layout)
    self.userPosition = layout.userPosition == 'true'
end

function ISMiniMapOuter:SaveLayout(name, layout)
    ISLayoutManager.DefaultSaveWindow(self, layout)
    layout.width = nil
    layout.height = nil
    if self.userPosition then layout.userPosition = 'true' else layout.userPosition = 'false' end
end

function ISMiniMapOuter:new(x, y, width, height, playerNum)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.playerNum = playerNum
	o.backgroundColor = {r=0, g=0, b=0, a=0.8}
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.borderSize = 2
	o.bottomHeight = getTextManager():getFontHeight(UIFont.Small)
	return o
end

-----

ISMiniMap = {}

function ISMiniMap.IsAllowed()
	if getCore():getGameMode() == "Tutorial" then return false end
	if not ISWorldMap.IsAllowed() then return end
	return SandboxVars.Map and (SandboxVars.Map.AllowMiniMap == true) or false
end

function ISMiniMap.NeedsLight()
	if getCore():getGameMode() == "Tutorial" then return false end
	if not ISWorldMap.IsAllowed() then return end
	return SandboxVars.Map and (SandboxVars.Map.MapNeedsLight == true) or false
end

function ISMiniMap.InitPlayer(playerNum)
	local width = BUTTON_HGT*6+UI_BORDER_SPACING*7+6
	local height = width
	local sx = getPlayerScreenLeft(playerNum)
	local sy = getPlayerScreenTop(playerNum)
	local sw = getPlayerScreenWidth(playerNum)
	local sh = getPlayerScreenHeight(playerNum)
	local MINIMAP = ISMiniMapOuter:new(sx + sw - 10 - width, sy + sh - 10 - height, width, height, playerNum)
	MINIMAP:initialise()
	MINIMAP:instantiate()

	local INNER = MINIMAP.inner

	local dirs = getLotDirectories()
	for i=1,dirs:size() do
--[[
		local file = 'media/maps/'..dirs:get(i-1)..'/worldmap-forest.xml'
		if fileExists(file) then
			INNER.mapAPI:addData(file)
		end
--]]
		local file = 'media/maps/'..dirs:get(i-1)..'/worldmap.xml'
		if fileExists(file) then
			INNER.mapAPI:addData(file)
		end

		-- This call indicates the end of XML data files for the directory.
		-- If map features exist for a particular cell in this directory,
		-- then no data added afterwards will be used for that same cell.
		INNER.mapAPI:endDirectoryData()

		INNER.mapAPI:addImages('media/maps/'..dirs:get(i-1))
	end
	INNER.mapAPI:setBoundsFromWorld()
	INNER.mapAPI:setZoom(19)

	INNER.mapAPI:setBoolean("HideUnvisited", true)
	INNER.mapAPI:setBoolean("Players", true)
	if isClient() then
		INNER.mapAPI:setBoolean("RemotePlayers", true)
		INNER.mapAPI:setBoolean("PlayerNames", true)
	end
	INNER.mapAPI:setBoolean("Symbols", false)
	INNER.mapAPI:setBoolean("MiniMapSymbols", true)
	INNER.mapAPI:setBoolean("ImagePyramid", false)

	MapUtils.initDefaultStyleV1(INNER)

	MINIMAP:restoreSettings()

	local settings = WorldMapSettings.getInstance()
	if settings:getBoolean("MiniMap.StartVisible") then
		MINIMAP:addToUIManager()
	end

	return MINIMAP
end

function ISMiniMap.ToggleMiniMap(playerNum)
	local mm = getPlayerMiniMap(playerNum)
	if not mm then return end
	local startVisible = false
	if mm:isReallyVisible() then
		if mm.joyfocus then
			mm:clearJoypadFocus(mm.joyfocus)
			setJoypadFocus(playerNum, nil)
		end
		mm:removeFromUIManager()
		startVisible = false
	else
		mm:addToUIManager()
		startVisible = true
	end
	if playerNum == 0 then
		local settings = WorldMapSettings.getInstance()
		settings:setBoolean("MiniMap.StartVisible", startVisible)
	end
end

function ISMiniMap.FocusMiniMap(playerNum)
	local mm = getPlayerMiniMap(playerNum)
	if not mm then return end
	if not mm:isReallyVisible() then
		ISMiniMap.ToggleMiniMap(playerNum)
	end
	setJoypadFocus(playerNum, mm)
end

function ISMiniMap.Recreate(playerNum)
	getPlayerMiniMap(playerNum):removeFromUIManager()
	getPlayerData(playerNum).miniMap = ISMiniMap.InitPlayer(playerNum)
end
