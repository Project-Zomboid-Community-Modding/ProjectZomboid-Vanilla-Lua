--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanelJoypad"
require('ISUI/Maps/Editor/WorldMapEditorMode')

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local FONT_HGT_HANDWRITTEN = getTextManager():getFontHeight(UIFont.Handwritten)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISMultiplayerZoneEditor = ISPanelJoypad:derive("ISMultiplayerZoneEditor")

-----

ISMultiplayerZoneEditor_ButtonPanel = ISPanelJoypad:derive("ISMultiplayerZoneEditor_ButtonPanel")

function ISMultiplayerZoneEditor_ButtonPanel:createChildren()
	local btnSize = self.texViewIsometric and self.texViewIsometric:getWidth() or 48

	local buttons = {}
--[[
	self.optionBtn = ISButton:new(0, 0, btnSize, btnSize, getText("UI_mainscreen_option"), self, self.onChangeOptions)
	self:addChild(self.optionBtn)
	table.insert(buttons, self.optionBtn)
--]]
	self.zoomInButton = ISButton:new(0, 0, btnSize, btnSize, "+", self.editor, self.editor.onZoomInButton)
	self:addChild(self.zoomInButton)
	table.insert(buttons, self.zoomInButton)

	self.zoomOutButton = ISButton:new(buttons[#buttons]:getRight() + UI_BORDER_SPACING, 0, btnSize, btnSize, "-", self.editor, self.editor.onZoomOutButton)
	self:addChild(self.zoomOutButton)
	table.insert(buttons, self.zoomOutButton)

--	if getDebug() then
		self.pyramidBtn = ISButton:new(buttons[#buttons]:getRight() + UI_BORDER_SPACING, 0, btnSize, btnSize, "", self.editor, self.editor.onTogglePyramid)
		self.pyramidBtn:setImage(self.editor.texViewPyramid)
		self:addChild(self.pyramidBtn)
		table.insert(buttons, self.pyramidBtn)
--	end

--[[
	-- Isometric view doesn't work with WorldMapEditorResizer
	self.perspectiveBtn = ISButton:new(buttons[#buttons]:getRight() + UI_BORDER_SPACING, 0, btnSize, btnSize, "", self.editor, self.editor.onChangePerspective)
	self.perspectiveBtn:setImage(self.isometric and self.editor.texViewIsometric or self.editor.texViewOrthographic)
	self:addChild(self.perspectiveBtn)
	table.insert(buttons, self.perspectiveBtn)

	self.centerBtn = ISButton:new(buttons[#buttons]:getRight() + UI_BORDER_SPACING, 0, btnSize, btnSize, "C", self.editor, self.editor.onCenterOnPlayer)
	self:addChild(self.centerBtn)
	table.insert(buttons, self.centerBtn)

	self.symbolsBtn = ISButton:new(buttons[#buttons]:getRight() + UI_BORDER_SPACING, 0, btnSize, btnSize, "S", self.editor, self.editor.onToggleSymbols)
	self:addChild(self.symbolsBtn)
	table.insert(buttons, self.symbolsBtn)

	self.forgetBtn = ISButton:new(buttons[#buttons]:getRight() + UI_BORDER_SPACING, 0, btnSize, btnSize, "?", self.editor, function(self, button) self.editor:onForget(button) end)
	self.buttonPanel:addChild(self.forgetBtn)
	table.insert(buttons, self.forgetBtn)
--]]
	self.closeBtn = ISButton:new(buttons[#buttons]:getRight() + UI_BORDER_SPACING, 0, btnSize, btnSize, getText("UI_btn_close"), self.editor, self.editor.close)
	self:addChild(self.closeBtn)
	table.insert(buttons, self.closeBtn)

	self:shrinkWrap(0, 0, nil)
	self:setX(self.editor.width - UI_BORDER_SPACING - self.width)

	self:insertNewListOfButtons(buttons)
	self.joypadIndex = 1
	self.joypadIndexY = 1
end

function ISMultiplayerZoneEditor_ButtonPanel:render()
	if self.perspectiveBtn then
		self.perspectiveBtn:setImage(self.editor.isometric and self.editor.texViewIsometric or self.editor.texViewOrthographic)
	end
	ISPanelJoypad.render(self)
	if self.joyfocus then
		local children = self:getVisibleChildren(self.joypadIndexY)
		local child = children[self.joypadIndex]
		if child then
			self:drawRectBorder(child.x, child.y, child.width, child.height, 0.4, 0.2, 1.0, 1.0);
			self:drawRectBorder(child.x-1, child.y-1, child.width+2, child.height+2, 0.4, 0.2, 1.0, 1.0);
		end
	end
end

function ISMultiplayerZoneEditor_ButtonPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self:restoreJoypadFocus()
end

function ISMultiplayerZoneEditor_ButtonPanel:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	self:clearJoypadFocus()
end

function ISMultiplayerZoneEditor_ButtonPanel:onJoypadDown(button, joypadData)
	if button == Joypad.BButton or button == Joypad.YButton then
		setJoypadFocus(joypadData.player, self.parent)
		return
	end
	ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISMultiplayerZoneEditor_ButtonPanel:new(x, y, width, height, editor)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

function ISMultiplayerZoneEditor:instantiate()
	self.javaObject = UIWorldMap.new(self)
	self.mapAPI = self.javaObject:getAPIv3()
--	self.mapAPI:setMapItem(MapItem.getSingleton())
	self.javaObject:setX(self.x)
	self.javaObject:setY(self.y)
	self.javaObject:setWidth(self.width)
	self.javaObject:setHeight(self.height)
	self.javaObject:setAnchorLeft(self.anchorLeft)
	self.javaObject:setAnchorRight(self.anchorRight)
	self.javaObject:setAnchorTop(self.anchorTop)
	self.javaObject:setAnchorBottom(self.anchorBottom)
	self.javaObject:setWantKeyEvents(true)
	self:createChildren()
end

function ISMultiplayerZoneEditor:createChildren()
	self.modeCombo = ISComboBox:new(UI_BORDER_SPACING, UI_BORDER_SPACING, 200, FONT_HGT_SMALL + 4, self, self.onComboChangeMode)
	self:addChild(self.modeCombo)
	self.modeCombo:addOptionWithData(getText("IGUI_MultiplayerZoneEditor_Mode_NonPVP"), "NonPVP")
	self.modeCombo:addOptionWithData(getText("IGUI_MultiplayerZoneEditor_Mode_Safehouse"), "Safehouse")

	self.mode = {}
	for _,mode in ipairs({'NonPVP', 'Safehouse'}) do
		self.mode[mode] = _G["MultiplayerZoneEditorMode_" .. mode]:new(self)
		self:addChild(self.mode[mode])
		self.mode[mode]:setVisible(false)
	end

	local btnSize = self.texViewIsometric and self.texViewIsometric:getWidth() or 48

	self.buttonPanel = ISMultiplayerZoneEditor_ButtonPanel:new(self.width - 200, self.height - UI_BORDER_SPACING - btnSize, 200, btnSize, self)
	self.buttonPanel.anchorLeft = false
	self.buttonPanel.anchorRight = true
	self.buttonPanel.anchorTop = false
	self.buttonPanel.anchorBottom = true
	self:addChild(self.buttonPanel)

	self:onSwitchMode('NonPVP')
end

function ISMultiplayerZoneEditor:prerender()
	ISPanelJoypad.prerender(self)
end

function ISMultiplayerZoneEditor:render()
	getWorld():setDrawWorld(false)

	local INSET = 0
	local w = getCore():getScreenWidth() - INSET * 2
	local h = getCore():getScreenHeight() - INSET * 2
	if self.width ~= w or self.height ~= h then
		self:setWidth(w)
		self:setHeight(h)
	end

	ISPanelJoypad.render(self)
end

function ISMultiplayerZoneEditor:onMouseDown(x, y)
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

function ISMultiplayerZoneEditor:onMouseMove(dx, dy)
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
	end
	return true
end

function ISMultiplayerZoneEditor:onMouseMoveOutside(dx, dy)
	return self:onMouseMove(dx, dy)
end

function ISMultiplayerZoneEditor:onMouseUp(x, y)
	self.dragging = false
	return true
end

function ISMultiplayerZoneEditor:onMouseUpOutside(x, y)
	self.dragging = false
	return true
end

function ISMultiplayerZoneEditor:onMouseWheel(del)
	self.mapAPI:zoomAt(self:getMouseX(), self:getMouseY(), del)
	return true
end

function ISMultiplayerZoneEditor:onChangePerspective()
	self:setIsometric(not self.isometric)
end

function ISMultiplayerZoneEditor:onCenterOnPlayer()
	if not self.character then
		self.mapAPI:resetView()
		return
	end
	self.mapAPI:centerOn(self.character:getX(), self.character:getY())
end

function ISMultiplayerZoneEditor:onTogglePyramid()
	if self.mapAPI:getBoolean("ImagePyramid") then
		self.mapAPI:setBoolean("ImagePyramid", false)
		self.mapAPI:setBoolean("Features", true)
	else
		self.mapAPI:setBoolean("ImagePyramid", true)
		self.mapAPI:setBoolean("Features", false)
	end
end

function ISMultiplayerZoneEditor:onZoomInButton()
	self.mapAPI:zoomAt(self.width / 2, self.height / 2, -2)
end

function ISMultiplayerZoneEditor:onZoomOutButton()
	self.mapAPI:zoomAt(self.width / 2, self.height / 2, 2)
end

function ISMultiplayerZoneEditor:onChangeOptions(button)
end

function ISMultiplayerZoneEditor:setHideUnvisitedAreas(hide)
	self.hideUnvisitedAreas = hide
	self.mapAPI:setBoolean("HideUnvisited", hide)
end

function ISMultiplayerZoneEditor:setIsometric(iso)
	self.isometric = iso
	self.mapAPI:setBoolean("Isometric", iso)
end

function ISMultiplayerZoneEditor:setShowCellGrid(show)
	self.showCellGrid = show
	self.mapAPI:setBoolean("CellGrid", show)
end

function ISMultiplayerZoneEditor:setShowTileGrid(show)
	self.showTileGrid = show
	self.mapAPI:setBoolean("TileGrid", show)
end

function ISMultiplayerZoneEditor:setShowPlayers(show)
	self.showPlayers = show
	self.mapAPI:setBoolean("Players", show)
end

function ISMultiplayerZoneEditor:setShowRemotePlayers(show)
	self.showRemotePlayers = show
	self.mapAPI:setBoolean("RemotePlayers", show)
end

function ISMultiplayerZoneEditor:setShowPlayerNames(show)
	self.showPlayerNames = show
	self.mapAPI:setBoolean("PlayerNames", show)
end

function ISMultiplayerZoneEditor:close()
	self.mode[self.currentMode]:undisplay()
	self:setVisible(false)
	self:removeFromUIManager()
	getWorld():setDrawWorld(true)
end

function ISMultiplayerZoneEditor:onComboChangeMode()
	local mode = self.modeCombo:getOptionData(self.modeCombo:getSelected())
	self:onSwitchMode(mode)
end

function ISMultiplayerZoneEditor:onSwitchMode(mode)
--	local mode = button.mode
	if self.currentMode then
--		self.modeButton[self.currentMode].textColor.a = 0.5
		self.mode[self.currentMode]:undisplay()
	end
	self.currentMode = mode
--	self.modeButton[mode].textColor.a = 1.0
	self.mode[mode]:display()
end

function ISMultiplayerZoneEditor:isKeyConsumed(key)
	if key == Keyboard.KEY_ESCAPE or getCore():isKey("Toggle UI", key) then
		return true
	end
	return true
end

function ISMultiplayerZoneEditor:onKeyPress(key)
	if self.mode[self.currentMode]:onKeyPress(key) then
		return
	end
end

function ISMultiplayerZoneEditor:onKeyRelease(key)
	if self:isVisible() then
		if self.mode[self.currentMode]:onKeyRelease(key) then
			return
		end
		if key == Keyboard.KEY_ESCAPE or getCore():isKey("Toggle UI", key) then
			self:close()
		end
	end
end

function ISMultiplayerZoneEditor:initDirectoryMapData(directory)
	local mapUI = self
	local mapAPI = mapUI.javaObject:getAPIv1()
	local file = directory..'/worldmap-forest.xml'
	if fileExists(file) then
--		mapAPI:addData(file)
	end
	file = directory..'/worldmap.xml'
	if fileExists(file) then
		mapAPI:addData(file)
	end

	-- This call indicates the end of XML data files for the directory.
	-- If map features exist for a particular cell in this directory,
	-- then no data added afterwards will be used for that same cell.
	mapAPI:endDirectoryData()

	mapAPI:addImages(directory)
end

function ISMultiplayerZoneEditor:initDefaultStyle()
	local MINZ = 0
	local MAXZ = 24
	local MINZ_BUILDINGS = 13

	local mapUI = self
	local mapAPI = mapUI.javaObject:getAPIv1()
	local styleAPI = mapAPI:getStyleAPI()

	mapAPI:setBoolean("ColorblindPatterns", false)

	local r,g,b = 219/255, 215/255, 192/255
	mapAPI:setBackgroundRGBA(r, g, b, 1.0)
	mapAPI:setUnvisitedRGBA(r * 0.915, g * 0.915, b * 0.915, 1.0)
	mapAPI:setUnvisitedGridRGBA(r * 0.777, g * 0.777, b * 0.777, 1.0)

	styleAPI:clear()

	local r,g,b,a = 171, 158, 143, 255

	local layer = styleAPI:newPolygonLayer("forest")
	layer:setMinZoom(13.5)
	layer:setFilter("natural", "forest")
	layer:addFill(MINZ, r, g, b, 0)
	layer:addFill(13.5, r, g, b, 0)
	layer:addFill(14, r, g, b, a)
	layer:addFill(MAXZ, r, g, b, a)
	
	layer = styleAPI:newPolygonLayer("water")
	layer:setMinZoom(MINZ)
	layer:setFilter("water", "*")
	layer:addFill(MINZ, 164, 164, 164, a)
	layer:addFill(MAXZ, 164, 164, 164, a)

	layer = styleAPI:newPolygonLayer("road-trail")
	layer:setMinZoom(12.0)
	layer:setFilter("highway", "trail")
	layer:addFill(12.25, r, g, b, 0)
	layer:addFill(13, r, g, b, a)
	layer:addFill(MAXZ, r, g, b, a)

	layer = styleAPI:newPolygonLayer("road-tertiary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "tertiary")
	layer:addFill(11.5, r, g, b, 0)
	layer:addFill(13, r, g, b, a)
	layer:addFill(MAXZ, r, g, b, a)

	layer = styleAPI:newPolygonLayer("road-secondary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "secondary")
	layer:addFill(MINZ, r, g, b, a)
	layer:addFill(MAXZ, r, g, b, a)

	layer = styleAPI:newPolygonLayer("road-primary")
	layer:setMinZoom(11.0)
	layer:setFilter("highway", "primary")
	layer:addFill(MINZ, r, g, b, a)
	layer:addFill(MAXZ, r, g, b, a)

	layer = styleAPI:newPolygonLayer("railway")
	layer:setMinZoom(13.0)
	layer:setFilter("railway", "*")
	layer:addFill(13.0, r, g, b, 0)
	layer:addFill(13.5, r, g, b, a)
	layer:addFill(MAXZ, r, g, b, a)

	-- Default, same as building-Residential
	layer = styleAPI:newPolygonLayer("building")
	layer:setMinZoom(MINZ_BUILDINGS)
	layer:setFilter("building", "*")
	layer:addFill(MINZ_BUILDINGS, r, g, b, 0)
	layer:addFill(MINZ_BUILDINGS + 0.5, r, g, b, a)
	layer:addFill(MAXZ, r, g, b, a)
end

function ISMultiplayerZoneEditor:initDefaultMapData()
	local mapUI = self
	local mapAPI = mapUI.javaObject:getAPIv1()
	mapAPI:clearData()
	-- Add data from highest priority (mods) to lowest priority (vanilla)
	local dirs = getLotDirectories()
	for i=1,dirs:size() do
		self:initDirectoryMapData('media/maps/'..dirs:get(i-1))
	end
end

function ISMultiplayerZoneEditor:initDataAndStyle()
	local mapAPI = self.mapAPI
	self:initDefaultMapData()
	mapAPI:setBoundsFromWorld()
	self:initDefaultStyle()
	MapUtils.overlayPaper(self)
end

function ISMultiplayerZoneEditor:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o:noBackground()
	o.anchorRight = true
	o.anchorBottom = true
	o.showCellGrid = false
	o.showTileGrid = false
	o.showPlayers = true
	o.showRemotePlayers = true
	o.showPlayerNames = true
	o.hideUnvisitedAreas = false
	o.isometric = false
	o.character = nil
	o.playerNum = character and character:getPlayerNum() or 0
	o.cross = getTexture("media/ui/LootableMaps/mapCross.png")
	o.texViewIsometric = getTexture("media/textures/worldMap/ViewIsometric.png")
	o.texViewOrthographic = getTexture("media/textures/worldMap/ViewOrtho.png")
	o.texViewPyramid = getTexture("media/textures/worldMap/ViewPyramid.png")
	return o
end

function ISMultiplayerZoneEditor.ShowEditor()
	if not ISMultiplayerZoneEditor_instance then
		local INSET = 0
		ISMultiplayerZoneEditor_instance = ISMultiplayerZoneEditor:new(INSET, INSET, getCore():getScreenWidth() - INSET * 2, getCore():getScreenHeight() - INSET * 2)
		local instance = ISMultiplayerZoneEditor_instance
		instance:initialise()
		instance:instantiate()
		instance:initDataAndStyle()
		instance:setHideUnvisitedAreas(instance.hideUnvisitedAreas)
		instance:setShowPlayers(instance.showPlayers)
		instance:setShowRemotePlayers(instance.showRemotePlayers)
		instance:setShowPlayerNames(instance.showPlayerNames)
		instance:setShowCellGrid(instance.showCellGrid)
		instance:setShowTileGrid(instance.showTileGrid)
		instance:setIsometric(instance.isometric)
		instance.mapAPI:setBoolean("Animals", false)
		instance.mapAPI:resetView()
		instance:addToUIManager()
		instance.getJoypadFocus = true
		return
	end
	local instance = ISMultiplayerZoneEditor_instance
	instance.mode[instance.currentMode]:display()
	instance:setVisible(true)
	instance:addToUIManager()
	instance.getJoypadFocus = true
end

function ISMultiplayerZoneEditor.ToggleEditor()
	local instance = ISMultiplayerZoneEditor_instance
	if instance and instance:isVisible() then
		instance:close()
		return
	end
	ISMultiplayerZoneEditor.ShowEditor()
end

