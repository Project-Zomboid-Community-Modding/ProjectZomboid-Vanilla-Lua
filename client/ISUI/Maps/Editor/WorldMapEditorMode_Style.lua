--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require 'ISUI/Maps/Editor/WorldMapEditorMode'
require 'ISUI/Maps/Editor/WorldMapEditorListBox'

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

WorldMapEditorMode_Style = WorldMapEditorMode:derive("WorldMapEditorMode_Style")

-----

-- Base class for a panel displayed when a WorldMapStyleLayer is selected.
WorldMapStyleEditor = ISPanel:derive("WorldMapStyleEditor")

function WorldMapStyleEditor:shrinkWrap()
	local xMax = 0
	local yMax = 0
	local children = self:getChildren()
	for _,child in pairs(children) do
		xMax = math.max(xMax, child:getRight())
		yMax = math.max(yMax, child:getBottom())
	end
	self:setWidth(xMax)
	self:setHeight(yMax)
end

function WorldMapStyleEditor:display(layer)
	self:setVisible(true)
	self.layer = layer
end

function WorldMapStyleEditor:undisplay()
	self.layer = nil
	local children = self:getChildren()
	for _,child in pairs(children) do
		if child.Type == "ISTextEntryBox" then
			child:unfocus()
		end
	end
	self:setVisible(false)
end

function WorldMapStyleEditor:onKeyPress(key)
	return false
end

function WorldMapStyleEditor:new(editorMode)
	local o = ISPanel.new(self, 0, 0, 100, 100)
	o.editorMode = editorMode
	o.mapUI = editorMode.mapUI
	o.mapAPI = editorMode.mapAPI
	o.styleAPI = editorMode.styleAPI
	return o
end

-----

-- Base class for one panel in an ISTabPanel to edit a WorldMapStyleLayer
WorldMapStyleEditor_TabPanel = ISPanel:derive("WorldMapStyleEditor_TabPanel")

function WorldMapStyleEditor_TabPanel:undisplay()
end

function WorldMapStyleEditor_TabPanel:onMouseDownMap(x, y)
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TabPanel:onMouseUpMap(x, y)
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TabPanel:onMouseUpOutsideMap(x, y)
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TabPanel:onMouseMoveMap(dx, dy)
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TabPanel:onRightMouseDownMap(x, y)
	return false
end

function WorldMapStyleEditor_TabPanel:onKeyPress(key)
	return false
end

function WorldMapStyleEditor_TabPanel:populateList(layer)
	self.layer = layer
end

function WorldMapStyleEditor_TabPanel:getEntryClamped(entry, min, max)
	local value = tonumber(entry:getText())
	if not value or value > max then
		entry:setText(tostring(max))
		return max
	end
	if value < min then
		entry:setText(tostring(min))
		return min
	end
	return value
end

function WorldMapStyleEditor_TabPanel:new(width, editorMode)
	local o = ISPanel.new(self, 0, 0, width, 100)
	o:noBackground()
	o.editorMode = editorMode -- WorldMapStyleEditor_Style
	o.mapUI = editorMode.mapUI
	o.mapAPI = editorMode.mapAPI
	o.styleAPI = editorMode.styleAPI
	return o
end

-----

-- Panel that displays WorldMapBaseStyleLayer filter
WorldMapStyleEditor_FilterPanel = WorldMapStyleEditor_TabPanel:derive("WorldMapStyleEditor_FilterPanel")

function WorldMapStyleEditor_FilterPanel:createChildren()

	local label = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("IGUI_WorldMapEditor_Key")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.keyEntry = ISTextEntryBox:new("", label:getRight() + UI_BORDER_SPACING, label.y, self.width - label:getRight() - UI_BORDER_SPACING*2-1, BUTTON_HGT)
	self.keyEntry.onCommandEntered = function(entry) self:onKeyEntered() end
	self:addChild(self.keyEntry)

	label = ISLabel:new(UI_BORDER_SPACING+1, self.keyEntry:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_WorldMapEditor_Value")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.valueEntry = ISTextEntryBox:new("", label:getRight() + UI_BORDER_SPACING, label.y, self.width - label:getRight() - UI_BORDER_SPACING*2-1, BUTTON_HGT)
	self.valueEntry.onCommandEntered = function(entry) self:onValueEntered() end
	self:addChild(self.valueEntry)

	self:setHeight(self.valueEntry:getBottom())
end

function WorldMapStyleEditor_FilterPanel:populateList(layer)
	WorldMapStyleEditor_TabPanel.populateList(self, layer)
	self.keyEntry:setText(layer:getFilterKey())
	self.valueEntry:setText(layer:getFilterValue())
end

function WorldMapStyleEditor_FilterPanel:onKeyEntered()
	self.layer:setFilter(self.keyEntry:getText(), self.valueEntry:getText())
end

function WorldMapStyleEditor_FilterPanel:onValueEntered()
	self.layer:setFilter(self.keyEntry:getText(), self.valueEntry:getText())
end

function WorldMapStyleEditor_FilterPanel:new(width, editorMode)
	local o = WorldMapStyleEditor_TabPanel.new(self, width, editorMode)
	return o
end

-----

-- Panel that displays a list of ColorStop
WorldMapStyleEditor_ColorStopsPanel = WorldMapStyleEditor_TabPanel:derive("WorldMapStyleEditor_ColorStopsPanel")

function WorldMapStyleEditor_ColorStopsPanel:createChildren()
	self.listbox = WorldMapEditorListBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, self.width-(UI_BORDER_SPACING+1)*2, BUTTON_HGT * 6, self.onListboxEvent, self)
	self:addChild(self.listbox)
	self:setHeight(self.listbox:getBottom())

	local maxLabelWidth = UI_BORDER_SPACING*2+1+math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_WorldMapEditor_Zoom")..":"),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_BulletTracerEffect_Red")..":"),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_BulletTracerEffect_Green")..":"),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_BulletTracerEffect_Blue")..":"),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_BulletTracerEffect_Alpha")..":")
	)

	local label = ISLabel:new(UI_BORDER_SPACING+1, self.listbox:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_WorldMapEditor_Zoom")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.zoomEntry = ISTextEntryBox:new("0.00", maxLabelWidth, label.y, 100, BUTTON_HGT)
	self.zoomEntry.onCommandEntered = function(entry) self:onZoomEntered() end
	self:addChild(self.zoomEntry)
	self.zoomEntry:setOnlyNumbers(true)

	label = ISLabel:new(label.x, label:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_BulletTracerEffect_Red")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.redEntry = ISTextEntryBox:new("255", maxLabelWidth, label.y, 100, BUTTON_HGT)
	self.redEntry.onCommandEntered = function(entry) self:onRedEntered() end
	self:addChild(self.redEntry)
	self.redEntry:setOnlyNumbers(true)

	label = ISLabel:new(label.x, label:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_BulletTracerEffect_Green")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.greenEntry = ISTextEntryBox:new("255", maxLabelWidth, label.y, 100, BUTTON_HGT)
	self.greenEntry.onCommandEntered = function(entry) self:onGreenEntered() end
	self:addChild(self.greenEntry)
	self.greenEntry:setOnlyNumbers(true)

	label = ISLabel:new(label.x, label:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_BulletTracerEffect_Blue")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.blueEntry = ISTextEntryBox:new("255", maxLabelWidth, label.y, 100, BUTTON_HGT)
	self.blueEntry.onCommandEntered = function(entry) self:onBlueEntered() end
	self:addChild(self.blueEntry)
	self.blueEntry:setOnlyNumbers(true)

	label = ISLabel:new(label.x, label:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_BulletTracerEffect_Alpha")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.alphaEntry = ISTextEntryBox:new("255", maxLabelWidth, label.y, 100, BUTTON_HGT)
	self.alphaEntry.onCommandEntered = function(entry) self:onAlphaEntered() end
	self:addChild(self.alphaEntry)
	self.alphaEntry:setOnlyNumbers(true)

	self:setHeight(self.alphaEntry:getBottom()+UI_BORDER_SPACING+1)
end

function WorldMapStyleEditor_ColorStopsPanel:onListboxEvent(action)
	if action == "add" then
		self:onAdd()
	elseif action == "remove" then
		self:onRemove()
	elseif action == "up" then
		self:onMoveUp()
	elseif action == "down" then
		self:onMoveDown()
	elseif action == "select" then
		self:onSelect()
	end
end

function WorldMapStyleEditor_ColorStopsPanel:onAdd()
	local zoom = self:getEntryClamped(self.zoomEntry, 0, 24)
	local r = self:getEntryClamped(self.redEntry, 0, 255)
	local g = self:getEntryClamped(self.greenEntry, 0, 255)
	local b = self:getEntryClamped(self.blueEntry, 0, 255)
	local a = self:getEntryClamped(self.alphaEntry, 0, 255)
	self.layer:addFill(zoom, r, g, b, a)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_ColorStopsPanel:onRemove()
	local index = self.listbox:getSelectedIndex()
	if index == -1 then return end
	self.layer:removeFill(index-1)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_ColorStopsPanel:onMoveUp()
	local index = self.listbox:getSelectedIndex()
	if index == -1 then return end
	index = index - 1
	self.layer:moveFill(index, index-1)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_ColorStopsPanel:onMoveDown()
	local index = self.listbox:getSelectedIndex()
	if index == -1 then return end
	index = index - 1
	self.layer:moveFill(index, index+1)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_ColorStopsPanel:onSelect()
	local index = self:getSelectedIndex()
	self.zoomEntry:setText(tostring(round(self:getSelectedZoom() or 0.0,2)))
	self.redEntry:setText(tostring(self:getSelectedRed() or 255))
	self.greenEntry:setText(tostring(self:getSelectedGreen() or 255))
	self.blueEntry:setText(tostring(self:getSelectedBlue() or 255))
	self.alphaEntry:setText(tostring(self:getSelectedAlpha() or 255))
end

function WorldMapStyleEditor_ColorStopsPanel:populateList(layer)
	WorldMapStyleEditor_TabPanel.populateList(self, layer)
	local index = self:getSelectedIndex()
	self.listbox:clear()
	for i=1,layer:getFillStops() do
		local zoom = layer:getFillZoom(i-1)
		local r = layer:getFillRed(i-1)
		local g = layer:getFillGreen(i-1)
		local b = layer:getFillBlue(i-1)
		local a = layer:getFillAlpha(i-1)
		self.listbox:addItem(string.format("zoom=%.2f rgba=%d,%d,%d,%d", zoom, r, g, b, a))
	end
	if index >= 1 and index <= self.listbox:size() then
		self.listbox:setSelectedIndex(index)
	end
end

function WorldMapStyleEditor_ColorStopsPanel:onZoomEntered()
	local item = self.listbox:getSelectedItem()
	local index = self.listbox:getSelectedIndex()
	if index == -1 then return end
	local value = self:getEntryClamped(self.zoomEntry, 0, 24)
	self.layer:setFillZoom(index-1, value)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_ColorStopsPanel:onRedEntered()
	local value = self:getEntryClamped(self.redEntry, 0, 255)
	self:setRGBA(value, -1, -1, -1)
end

function WorldMapStyleEditor_ColorStopsPanel:onGreenEntered()
	local value = self:getEntryClamped(self.greenEntry, 0, 255)
	self:setRGBA(-1, value, -1, -1)
end

function WorldMapStyleEditor_ColorStopsPanel:onBlueEntered()
	local value = self:getEntryClamped(self.blueEntry, 0, 255)
	self:setRGBA(-1, -1, value, -1)
end

function WorldMapStyleEditor_ColorStopsPanel:onAlphaEntered()
	local value = self:getEntryClamped(self.alphaEntry, 0, 255)
	self:setRGBA(-1, -1, -1, value)
end

function WorldMapStyleEditor_ColorStopsPanel:getSelectedIndex()
	return self.listbox:getSelectedIndex()
end

function WorldMapStyleEditor_ColorStopsPanel:getSelectedZoom()
	local index = self:getSelectedIndex()
	if index == -1 then return nil end
	return self.layer:getFillZoom(index-1)
end

function WorldMapStyleEditor_ColorStopsPanel:getSelectedRed()
	local index = self:getSelectedIndex()
	if index == -1 then return nil end
	return self.layer:getFillRed(index-1)
end

function WorldMapStyleEditor_ColorStopsPanel:getSelectedGreen()
	local index = self:getSelectedIndex()
	if index == -1 then return nil end
	return self.layer:getFillGreen(index-1)
end

function WorldMapStyleEditor_ColorStopsPanel:getSelectedBlue()
	local index = self:getSelectedIndex()
	if index == -1 then return nil end
	return self.layer:getFillBlue(index-1)
end

function WorldMapStyleEditor_ColorStopsPanel:getSelectedAlpha()
	local index = self:getSelectedIndex()
	if index == -1 then return nil end
	return self.layer:getFillAlpha(index-1)
end

function WorldMapStyleEditor_ColorStopsPanel:setRGBA(r, g, b, a)
	local index = self.listbox:getSelectedIndex()
	if index == -1 then return end
	local layer = self.layer
	local r = (r == -1) and layer:getFillRed(index-1) or r
	local g = (g == -1) and layer:getFillGreen(index-1) or g
	local b = (b == -1) and layer:getFillBlue(index-1) or b
	local a = (a == -1) and layer:getFillAlpha(index-1) or a
	layer:setFillRGBA(index-1, r, g, b, a)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_ColorStopsPanel:new(width, editorMode)
	local o = WorldMapStyleEditor_TabPanel.new(self, width, editorMode)
	return o
end

-----

-- Panel that displays a list of TextureStop
WorldMapStyleEditor_TextureStopsPanel = WorldMapStyleEditor_TabPanel:derive("WorldMapStyleEditor_TextureStopsPanel")

function WorldMapStyleEditor_TextureStopsPanel:createChildren()
	self.listbox = WorldMapEditorListBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, self.width-(UI_BORDER_SPACING+1)*2, BUTTON_HGT * 6, self.onListboxEvent, self)
	self:addChild(self.listbox)
	self:setHeight(self.listbox:getBottom())

	local label = ISLabel:new(UI_BORDER_SPACING+1, self.listbox:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_WorldMapEditor_Zoom")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.zoomEntry = ISTextEntryBox:new("0.00", label:getRight() + UI_BORDER_SPACING, label.y, 100, BUTTON_HGT)
	self.zoomEntry.onCommandEntered = function(entry) self:onZoomEntered() end
	self:addChild(self.zoomEntry)
	self.zoomEntry:setOnlyNumbers(true)

	self.texturePathEntry = ISTextEntryBox:new("", UI_BORDER_SPACING+1, self.zoomEntry:getBottom() + UI_BORDER_SPACING, self.width - UI_BORDER_SPACING*2-2, BUTTON_HGT)
	self.texturePathEntry.onCommandEntered = function(entry) self:onTexturePathEntered() end
	self:addChild(self.texturePathEntry)

	self:setHeight(self.texturePathEntry:getBottom())
end

function WorldMapStyleEditor_TextureStopsPanel:render()
	ISPanel.render(self)
end

function WorldMapStyleEditor_TextureStopsPanel:onMouseDownMap(x, y)
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TextureStopsPanel:onMouseUpMap(x, y)
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TextureStopsPanel:onMouseUpOutsideMap(x, y)
	return self:onMouseUp(x, y)
end

function WorldMapStyleEditor_TextureStopsPanel:onMouseMoveMap(dx, dy)
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TextureStopsPanel:onListboxEvent(action)
	if action == "add" then
		self:onAdd()
	elseif action == "remove" then
		self:onRemove()
	elseif action == "up" then
		self:onMoveUp()
	elseif action == "down" then
		self:onMoveDown()
	elseif action == "select" then
		self:onSelect()
	end
end

function WorldMapStyleEditor_TextureStopsPanel:onAdd()
	local zoom = self:getEntryClamped(self.zoomEntry, 0, 24)
	local texturePath = self.texturePathEntry:getText()
	self.layer:addTexture(zoom, texturePath)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_TextureStopsPanel:onRemove()
	local index = self:getSelectedIndex()
	if index == -1 then return end
	self.layer:removeTexture(index-1)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_TextureStopsPanel:onMoveUp()
	local index = self:getSelectedIndex()
	if index == -1 then return end
	index = index - 1
	self.layer:moveTexture(index, index-1)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_TextureStopsPanel:onMoveDown()
	local index = self:getSelectedIndex()
	if index == -1 then return end
	index = index - 1
	self.layer:moveTexture(index, index+1)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_TextureStopsPanel:onSelect()
	local index = self:getSelectedIndex()
	self.zoomEntry:setText(tostring(round(self:getSelectedZoom() or 0.0,2)))
	self.texturePathEntry:setText(self:getSelectedTexturePath() or "")
end

function WorldMapStyleEditor_TextureStopsPanel:populateList(layer)
	WorldMapStyleEditor_TabPanel.populateList(self, layer)
	local index = self:getSelectedIndex()
	self.listbox:clear()
	for i=1,layer:getTextureStops() do
		local zoom = layer:getTextureZoom(i-1)
		local texturePath = layer:getTexturePath(i-1)
		self.listbox:addItem(string.format("zoom=%.2f %s", zoom, texturePath))
	end
	if index >= 1 and index <= self.listbox:size() then
		self.listbox:setSelectedIndex(index)
	end
	self.texturePathEntry:setText(self:getSelectedTexturePath() or "")
end

function WorldMapStyleEditor_TextureStopsPanel:getSelectedIndex()
	return self.listbox:getSelectedIndex()
end

function WorldMapStyleEditor_TextureStopsPanel:getSelectedZoom()
	local index = self:getSelectedIndex()
	if index == -1 then return nil end
	return self.layer:getTextureZoom(index-1)
end

function WorldMapStyleEditor_TextureStopsPanel:getSelectedTexturePath()
	local index = self:getSelectedIndex()
	if index == -1 then return end
	return self.layer:getTexturePath(index-1)
end

function WorldMapStyleEditor_TextureStopsPanel:getSelectedTexture()
	local index = self:getSelectedIndex()
	if index == -1 then return end
	return self.layer:getTexture(index-1)
end

function WorldMapStyleEditor_TextureStopsPanel:onTexturePathEntered()
	local index = self.listbox:getSelectedIndex()
	if index == -1 then return end
	local texturePath = self.texturePathEntry:getText()
	self.layer:setTexturePath(index-1, texturePath)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_TextureStopsPanel:onZoomEntered()
	local index = self.listbox:getSelectedIndex()
	if index == -1 then return end
	local value = self:getEntryClamped(self.zoomEntry, 0, 24)
	self.layer:setTextureZoom(index-1, value)
	self:populateList(self.layer)
end

function WorldMapStyleEditor_TextureStopsPanel:new(width, editorMode)
	local o = WorldMapStyleEditor_TabPanel.new(self, width, editorMode)
	return o
end

-----

-- Panel that displays a list of TextureStop and other controls for WorldMapTextureStyle
WorldMapStyleEditor_TexturePanel = WorldMapStyleEditor_TextureStopsPanel:derive("WorldMapStyleEditor_TexturePanel")

function WorldMapStyleEditor_TexturePanel:createChildren()
	WorldMapStyleEditor_TextureStopsPanel.createChildren(self)

	local buttonPadding = UI_BORDER_SPACING*2
	local button = ISButton:new(UI_BORDER_SPACING+1, self.texturePathEntry:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_ResizeToTexture"), self, self.onResizeToTexture)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
	self:addChild(button)

	button = ISButton:new(UI_BORDER_SPACING+1, button:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_WorldBoundsFromTexture"), self, self.onBoundsFromTexture)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
	self:addChild(button)

	local label = ISLabel:new(button.x, button:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_WorldMapEditor_Scale")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.scaleEntry = ISTextEntryBox:new("1.0", label:getRight() + UI_BORDER_SPACING, label.y, 100, BUTTON_HGT)
	self.scaleEntry.onCommandEntered = function(entry) self:onScaleEntered() end
	self:addChild(self.scaleEntry)
	self.scaleEntry:setOnlyNumbers(true)

	self.lockSize = ISTickBox:new(label.x, label:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "", self, self.onChangeSizeLocked)
	self.lockSize.choicesColor = { r = 1, g = 1, b = 1, a = 1 }
	self:addChild(self.lockSize)
	self.lockSize:addOption(getText("IGUI_WorldMapEditor_SizeLocked"))
	self.lockSize:setWidthToFit()

	self.useWorldBounds = ISTickBox:new(self.lockSize.x, self.lockSize:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "", self, self.onChangeUseWorldBounds)
	self.useWorldBounds.choicesColor = { r = 1, g = 1, b = 1, a = 1 }
	self:addChild(self.useWorldBounds)
	self.useWorldBounds:addOption(getText("IGUI_WorldMapEditor_UseWorldBounds"))
	self.useWorldBounds:setWidthToFit()

	self.textureMode = ISComboBox:new(UI_BORDER_SPACING+1, self.useWorldBounds:getBottom() + UI_BORDER_SPACING, 200, FONT_HGT_SMALL + 4, self, self.onChangeTextureMode)
	self:addChild(self.textureMode)
	self.textureMode:addOption(getText("IGUI_WorldMapEditor_Stretch"))
	self.textureMode:addOption(getText("IGUI_WorldMapEditor_Repeat"))

	self.snapButtons = {}

	button = ISButton:new(UI_BORDER_SPACING+1, self.textureMode:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_SnapCell"), self, self.onChangeSnapMode)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
	button.internal = "cell"
	button.textColor.a = 0.5
	self:addChild(button)
	self.snapButtons.cell = button

	button = ISButton:new(UI_BORDER_SPACING+1, button:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_SnapChunk"), self, self.onChangeSnapMode)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
	button.internal = "chunk"
	button.textColor.a = 0.5
	self:addChild(button)
	self.snapButtons.chunk = button

	button = ISButton:new(UI_BORDER_SPACING+1, button:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_SnapSquare"), self, self.onChangeSnapMode)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
	button.internal = "square"
--	button.textColor.a = 0.5
	self:addChild(button)
	self.snapButtons.square = button

	self:setHeight(button:getBottom()+UI_BORDER_SPACING+1)
end

function WorldMapStyleEditor_TexturePanel:render()
	WorldMapStyleEditor_TextureStopsPanel.render(self)
	if self.mode == nil then
		local layer = self.layer
		self.resizer:setBounds(layer:getMinXInSquares(), layer:getMinYInSquares(), layer:getMaxXInSquares(), layer:getMaxYInSquares())
	end
	self.resizer:render()
end

function WorldMapStyleEditor_TexturePanel:undisplay()
	self:cancelResize()
end

function WorldMapStyleEditor_TexturePanel:populateList(layer)
	WorldMapStyleEditor_TextureStopsPanel.populateList(self, layer)
	local scaleX,scaleY = self:getSelectedTextureScale()
	self.scaleEntry:setText(tostring(round(scaleX,3)))
end

function WorldMapStyleEditor_TexturePanel:onMouseDownMap(x, y)
	local resizeMode = self.resizer:hitTest(x, y)
	if not resizeMode then return false end
	self.resizer:startResizing()
	self.resizer.fixedSize = self.sizeLocked
	self.mode = "Resize"
	self.resizeMode = resizeMode
	return true
end

function WorldMapStyleEditor_TexturePanel:onMouseUpMap(x, y)
	if self.mode == "Resize" then
		self.mode = nil
		self.resizeMode = nil
		self.layer:setBoundsInSquares(self.resizer.x1, self.resizer.y1, self.resizer.x2, self.resizer.y2)
		self.resizer:endResizing()
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TexturePanel:onMouseUpOutsideMap(x, y)
	return self:onMouseUp(x, y)
end

function WorldMapStyleEditor_TexturePanel:onMouseMoveMap(dx, dy)
	if self.mode == "Resize" then
		local mx = self.mapUI:getMouseX()
		local my = self.mapUI:getMouseY()
		self.resizer:onMouseMove(mx, my, self.resizeMode)
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapStyleEditor_TexturePanel:onRightMouseDownMap(x, y)
	self:cancelResize()
end

function WorldMapStyleEditor_TexturePanel:onKeyPress(key)
	if key == Keyboard.KEY_ESCAPE then
		return self:cancelResize()
	end
	return false
end

function WorldMapStyleEditor_TexturePanel:cancelResize()
	if self.mode == "Resize" then
		self.mode = nil
		self.resizeMode = nil
		self.resizer:cancelResize()
		return true
	end
	return false
end

function WorldMapStyleEditor_TexturePanel:onSelect()
	WorldMapStyleEditor_TextureStopsPanel.onSelect(self)
	local index = self:getSelectedIndex()
	local scaleX,scaleY = self:getSelectedTextureScale()
	self.useWorldBounds:setSelected(1, self.layer:isUseWorldBounds() or false)
	self.scaleEntry:setText(tostring(round(scaleX,3)))
	self.textureMode.selected = self.layer:isTile() and 2 or 1
end

function WorldMapStyleEditor_TexturePanel:getSelectedTextureScale()
	local texture = self:getSelectedTexture()
	if not texture then return 1.0,1.0 end
	local width = self.layer:getWidthInSquares()
	local height = self.layer:getHeightInSquares()
	return width/texture:getWidth(),height/texture:getHeight()
end

-- Set WorldMapTextureStyle bounds to match the selected texture's size.
function WorldMapStyleEditor_TexturePanel:onResizeToTexture()
	local texture = self:getSelectedTexture()
	if texture == nil then return end
	local scale = tonumber(self.scaleEntry:getText())
	if not scale or scale <= 0 then return end
	local x1 = self.layer:getMinXInSquares()
	local y1 = self.layer:getMinYInSquares()
	local x2 = x1 + texture:getWidth() * scale
	local y2 = y1 + texture:getHeight() * scale
	self.layer:setBoundsInSquares(x1, y1, x2, y2)
end

-- Set WorldMap bounds to match WorldMapTextureStyle bounds.
function WorldMapStyleEditor_TexturePanel:onBoundsFromTexture()
	local x1 = self.layer:getMinXInSquares()
	local y1 = self.layer:getMinYInSquares()
	local x2 = self.layer:getMaxXInSquares()
	local y2 = self.layer:getMaxYInSquares()
	self.editorMode.editor.mode.Bounds:setBounds(x1, y1, x2, y2)
end

function WorldMapStyleEditor_TexturePanel:onChangeSnapMode(button)
	self.snapButtons[self.snapMode].textColor.a = 0.5
	button.textColor.a = 1.0
	self.snapMode = button.internal
	self.resizer.snapMode = button.internal
end

function WorldMapStyleEditor_TexturePanel:onScaleEntered()
	self:onResizeToTexture()
end

function WorldMapStyleEditor_TexturePanel:onChangeSizeLocked()
	self.sizeLocked = self.lockSize:isSelected(1)
	self.resizer.fixedSize = self.sizeLocked
end

function WorldMapStyleEditor_TexturePanel:onChangeUseWorldBounds()
	local useWorldBounds = self.useWorldBounds:isSelected(1)
	self.layer:setUseWorldBounds(useWorldBounds)
end

function WorldMapStyleEditor_TexturePanel:onChangeTextureMode()
	self.layer:setTile(self.textureMode.selected == 2)
end

function WorldMapStyleEditor_TexturePanel:new(width, editorMode)
	local o = WorldMapStyleEditor_TabPanel.new(self, width, editorMode)
	o.snapMode = "square"
	o.resizer = WorldMapEditorResizer:new(editorMode.editor)
	o.resizer.snapMode = o.snapMode
	o.sizeLocked = false
	return o
end

-----

-- A panel displayed when a WorldMapPolygonStyleLayer is selected.
WorldMapStyleEditor_PolygonLayerPanel = WorldMapStyleEditor:derive("WorldMapStyleEditor_PolygonLayerPanel")

function WorldMapStyleEditor_PolygonLayerPanel:createChildren()
	self.tabs = ISTabPanel:new(0, 0, 250+(getCore():getOptionFontSizeReal()*50), 100)
	self.tabs:setEqualTabWidth(false)
	self:addChild(self.tabs)

	self.filterPanel = WorldMapStyleEditor_FilterPanel:new(self.tabs.width, self.editorMode)
	self.filterPanel:initialise()
	self.filterPanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Filter"), self.filterPanel)

	self.fillPanel = WorldMapStyleEditor_ColorStopsPanel:new(self.tabs.width, self.editorMode)
	self.fillPanel:initialise()
	self.fillPanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Fill"), self.fillPanel)

	self.texturePanel = WorldMapStyleEditor_TextureStopsPanel:new(self.tabs.width, self.editorMode)
	self.texturePanel:initialise()
	self.texturePanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Texture"), self.texturePanel)

	self.tabs:setHeight(math.max(self.filterPanel:getBottom(), self.fillPanel:getBottom(), self.texturePanel:getBottom()))

	self:shrinkWrap()
	self:setAnchorLeft(false)
	self:setAnchorRight(true)
	self:setX(getCore():getScreenWidth() - UI_BORDER_SPACING - self.width)
	self:setY(UI_BORDER_SPACING)
end

function WorldMapStyleEditor_PolygonLayerPanel:display(layer)
	WorldMapStyleEditor.display(self, layer)
	self.filterPanel:populateList(layer)
	self.fillPanel:populateList(layer)
	self.texturePanel:populateList(layer)
end

function WorldMapStyleEditor_PolygonLayerPanel:undisplay()
	WorldMapStyleEditor.undisplay(self)
end

function WorldMapStyleEditor_PolygonLayerPanel:render()
end

function WorldMapStyleEditor_PolygonLayerPanel:onMouseDownMap(x, y)
	return self.tabs:getActiveView():onMouseDownMap(x, y)
end

function WorldMapStyleEditor_PolygonLayerPanel:onMouseUpMap(x, y)
	return self.tabs:getActiveView():onMouseUpMap(x, y)
end

function WorldMapStyleEditor_PolygonLayerPanel:onMouseUpOutsideMap(x, y)
	return self.tabs:getActiveView():onMouseUpOutsideMap(x, y)
end

function WorldMapStyleEditor_PolygonLayerPanel:onMouseMoveMap(dx, dy)
	return self.tabs:getActiveView():onMouseMoveMap(dx, dy)
end

function WorldMapStyleEditor_PolygonLayerPanel:onRightMouseDownMap(x, y)
	return self.tabs:getActiveView():onRightMouseDownMap(x, y)
end

function WorldMapStyleEditor_PolygonLayerPanel:new(editorMode)
	local o = WorldMapStyleEditor.new(self, editorMode)
	return o
end

-----

-- Panel for editing WorldMapPyramidStyleLayer properties
WorldMapStyleEditor_PyramidPanel = WorldMapStyleEditor_TabPanel:derive("WorldMapStyleEditor_PyramidPanel")

function WorldMapStyleEditor_PyramidPanel:createChildren()
	local label = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("IGUI_WorldMapEditor_FileName")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.fileEntry = ISTextEntryBox:new("", label:getRight() + UI_BORDER_SPACING, label.y, self.width - label:getRight() - UI_BORDER_SPACING*2-1, BUTTON_HGT)
	self.fileEntry.onCommandEntered = function(entry) self:onFileEntered() end
	self:addChild(self.fileEntry)

	self:setHeight(self.fileEntry:getBottom())
end

function WorldMapStyleEditor_PyramidPanel:populateList(layer)
	WorldMapStyleEditor_TabPanel.populateList(self, layer)
	self.fileEntry:setText(layer:getPyramidFileName())
end

function WorldMapStyleEditor_PyramidPanel:onFileEntered()
	self.layer:setPyramidFileName(self.fileEntry:getText())
end

function WorldMapStyleEditor_PyramidPanel:new(width, editorMode)
	local o = WorldMapStyleEditor_TabPanel.new(self, width, editorMode)
	return o
end

-----

-- A panel displayed when a WorldMapPyramidStyleLayer is selected.
WorldMapStyleEditor_PyramidLayerPanel = WorldMapStyleEditor:derive("WorldMapStyleEditor_PyramidLayerPanel")

function WorldMapStyleEditor_PyramidLayerPanel:createChildren()
	self.tabs = ISTabPanel:new(0, 0, 250+(getCore():getOptionFontSizeReal()*50), 100)
	self.tabs:setEqualTabWidth(false)
	self:addChild(self.tabs)

	self.pyramidPanel = WorldMapStyleEditor_PyramidPanel:new(self.tabs.width, self.editorMode)
	self.pyramidPanel:initialise()
	self.pyramidPanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Pyramid"), self.pyramidPanel)

	self.fillPanel = WorldMapStyleEditor_ColorStopsPanel:new(self.tabs.width, self.editorMode)
	self.fillPanel:initialise()
	self.fillPanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Fill"), self.fillPanel)

	self.tabs:setHeight(math.max(self.pyramidPanel:getBottom(), self.fillPanel:getBottom()))

	self:shrinkWrap()
	self:setAnchorLeft(false)
	self:setAnchorRight(true)
	self:setX(getCore():getScreenWidth() - UI_BORDER_SPACING - self.width)
	self:setY(UI_BORDER_SPACING)
end

function WorldMapStyleEditor_PyramidLayerPanel:display(layer)
	WorldMapStyleEditor.display(self, layer)
	self.pyramidPanel:populateList(layer)
	self.fillPanel:populateList(layer)
end

function WorldMapStyleEditor_PyramidLayerPanel:undisplay()
	WorldMapStyleEditor.undisplay(self)
end

function WorldMapStyleEditor_PyramidLayerPanel:render()
end

function WorldMapStyleEditor_PyramidLayerPanel:onMouseDownMap(x, y)
	return self.tabs:getActiveView():onMouseDownMap(x, y)
end

function WorldMapStyleEditor_PyramidLayerPanel:onMouseUpMap(x, y)
	return self.tabs:getActiveView():onMouseUpMap(x, y)
end

function WorldMapStyleEditor_PyramidLayerPanel:onMouseUpOutsideMap(x, y)
	return self.tabs:getActiveView():onMouseUpOutsideMap(x, y)
end

function WorldMapStyleEditor_PyramidLayerPanel:onMouseMoveMap(dx, dy)
	return self.tabs:getActiveView():onMouseMoveMap(dx, dy)
end

function WorldMapStyleEditor_PyramidLayerPanel:onRightMouseDownMap(x, y)
	return self.tabs:getActiveView():onRightMouseDownMap(x, y)
end

function WorldMapStyleEditor_PyramidLayerPanel:new(editorMode)
	local o = WorldMapStyleEditor.new(self, editorMode)
	return o
end

-----

-- Panel for editing WorldMapTextStyleLayer properties
WorldMapStyleEditor_TextPanel = WorldMapStyleEditor_TabPanel:derive("WorldMapStyleEditor_TextPanel")

function WorldMapStyleEditor_TextPanel:createChildren()
	local label = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("IGUI_WorldMapEditor_Font")..":", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.fontCombo = ISComboBox:new(label:getRight() + UI_BORDER_SPACING, label.y, self.width - label:getRight() - UI_BORDER_SPACING*2-1, FONT_HGT_SMALL + 2 * 2, self, self.onFontSelected)
	self:addChild(self.fontCombo)

	self:setHeight(self.fontCombo:getBottom())
end

function WorldMapStyleEditor_TextPanel:populateList(layer)
	WorldMapStyleEditor_TabPanel.populateList(self, layer)
	self.fontCombo:clear()
	local fontList = getTextManager():getAllFonts(ArrayList.new())
	for i=1,fontList:size() do
        local font = fontList:get(i-1)
        self.fontCombo:addOptionWithData(font:name(), font)
        if font == layer:getFont() then
            self.fontCombo.selected = i
        end
    end
end

function WorldMapStyleEditor_TextPanel:onFontSelected()
    self.layer:setFont(self.fontCombo:getOptionData(self.fontCombo.selected))
end

function WorldMapStyleEditor_TextPanel:new(width, editorMode)
	local o = WorldMapStyleEditor_TabPanel.new(self, width, editorMode)
	return o
end

-----

-- A panel displayed when a WorldMapTextStyleLayer is selected.
WorldMapStyleEditor_TextLayerPanel = WorldMapStyleEditor:derive("WorldMapStyleEditor_TextLayerPanel")

function WorldMapStyleEditor_TextLayerPanel:createChildren()
	self.tabs = ISTabPanel:new(0, 0, 250+(getCore():getOptionFontSizeReal()*50), 100)
	self.tabs:setEqualTabWidth(false)
	self:addChild(self.tabs)

	self.textPanel = WorldMapStyleEditor_TextPanel:new(self.tabs.width, self.editorMode)
	self.textPanel:initialise()
	self.textPanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Text"), self.textPanel)

	self.fillPanel = WorldMapStyleEditor_ColorStopsPanel:new(self.tabs.width, self.editorMode)
	self.fillPanel:initialise()
	self.fillPanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Fill"), self.fillPanel)

	self.tabs:setHeight(math.max(self.fillPanel:getBottom()))

	self:shrinkWrap()
	self:setAnchorLeft(false)
	self:setAnchorRight(true)
	self:setX(getCore():getScreenWidth() - UI_BORDER_SPACING - self.width)
	self:setY(UI_BORDER_SPACING)
end

function WorldMapStyleEditor_TextLayerPanel:display(layer)
	WorldMapStyleEditor.display(self, layer)
	self.textPanel:populateList(layer)
	self.fillPanel:populateList(layer)
end

function WorldMapStyleEditor_TextLayerPanel:undisplay()
	WorldMapStyleEditor.undisplay(self)
end

function WorldMapStyleEditor_TextLayerPanel:render()
end

function WorldMapStyleEditor_TextLayerPanel:onMouseDownMap(x, y)
	return self.tabs:getActiveView():onMouseDownMap(x, y)
end

function WorldMapStyleEditor_TextLayerPanel:onMouseUpMap(x, y)
	return self.tabs:getActiveView():onMouseUpMap(x, y)
end

function WorldMapStyleEditor_TextLayerPanel:onMouseUpOutsideMap(x, y)
	return self.tabs:getActiveView():onMouseUpOutsideMap(x, y)
end

function WorldMapStyleEditor_TextLayerPanel:onMouseMoveMap(dx, dy)
	return self.tabs:getActiveView():onMouseMoveMap(dx, dy)
end

function WorldMapStyleEditor_TextLayerPanel:onRightMouseDownMap(x, y)
	return self.tabs:getActiveView():onRightMouseDownMap(x, y)
end

function WorldMapStyleEditor_TextLayerPanel:new(editorMode)
	local o = WorldMapStyleEditor.new(self, editorMode)
	return o
end

-----

-- A panel displayed when a WorldMapTextureStyleLayer is selected.
WorldMapStyleEditor_TextureLayerPanel = WorldMapStyleEditor:derive("WorldMapStyleEditor_TextureLayerPanel")

function WorldMapStyleEditor_TextureLayerPanel:createChildren()
	self.tabs = ISTabPanel:new(0, 0, 250+(getCore():getOptionFontSizeReal()*50), 100)
	self.tabs:setEqualTabWidth(false)
	self:addChild(self.tabs)

	self.fillPanel = WorldMapStyleEditor_ColorStopsPanel:new(self.tabs.width, self.editorMode)
	self.fillPanel:initialise()
	self.fillPanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Fill"), self.fillPanel)

	self.texturePanel = WorldMapStyleEditor_TexturePanel:new(self.tabs.width, self.editorMode)
	self.texturePanel:initialise()
	self.texturePanel:instantiate()
	self.tabs:addView(getText("IGUI_WorldMapEditor_Texture"), self.texturePanel)

	self.tabs:setHeight(math.max(self.fillPanel:getBottom(), self.texturePanel:getBottom()))

	self:shrinkWrap()
	self:setAnchorLeft(false)
	self:setAnchorRight(true)
	self:setX(getCore():getScreenWidth() - UI_BORDER_SPACING - self.width)
	self:setY(UI_BORDER_SPACING)
end

function WorldMapStyleEditor_TextureLayerPanel:display(layer)
	WorldMapStyleEditor.display(self, layer)
	self.fillPanel:populateList(layer)
	self.texturePanel:populateList(layer)
end

function WorldMapStyleEditor_TextureLayerPanel:undisplay()
	WorldMapStyleEditor.undisplay(self)
	self.texturePanel:undisplay()
end

function WorldMapStyleEditor_TextureLayerPanel:render()
end

function WorldMapStyleEditor_TextureLayerPanel:onMouseDownMap(x, y)
	return self.tabs:getActiveView():onMouseDownMap(x, y)
end

function WorldMapStyleEditor_TextureLayerPanel:onMouseUpMap(x, y)
	return self.tabs:getActiveView():onMouseUpMap(x, y)
end

function WorldMapStyleEditor_TextureLayerPanel:onMouseUpOutsideMap(x, y)
	return self.tabs:getActiveView():onMouseUpOutsideMap(x, y)
end

function WorldMapStyleEditor_TextureLayerPanel:onMouseMoveMap(dx, dy)
	return self.tabs:getActiveView():onMouseMoveMap(dx, dy)
end

function WorldMapStyleEditor_TextureLayerPanel:onRightMouseDownMap(x, y)
	return self.tabs:getActiveView():onRightMouseDownMap(x, y)
end

function WorldMapStyleEditor_TextureLayerPanel:onKeyPress(key)
	return self.tabs:getActiveView():onKeyPress(key)
end

function WorldMapStyleEditor_TextureLayerPanel:new(editorMode)
	local o = WorldMapStyleEditor.new(self, editorMode)
	return o
end

-----

function WorldMapEditorMode_Style:createChildren()
	self.listbox = WorldMapEditorListBox:new(UI_BORDER_SPACING, UI_BORDER_SPACING*2+BUTTON_HGT, 400, 200, self.onListboxEvent, self)
	self:addChild(self.listbox)

	self.layerNameEntry = ISTextEntryBox:new("", self.listbox.x, self.listbox:getBottom() + UI_BORDER_SPACING, self.listbox.width, BUTTON_HGT)
	self.layerNameEntry.onCommandEntered = function(entry) self:onLayerNameEntered() end
	self:addChild(self.layerNameEntry)

	self.layerType = ISComboBox:new(UI_BORDER_SPACING, self.layerNameEntry:getBottom() + UI_BORDER_SPACING, 200, BUTTON_HGT, self, self.onChangeLayerType)
	self:addChild(self.layerType)
	self.layerType:addOptionWithData(getText("IGUI_WorldMapEditor_None"), nil)
	self.layerType:addOptionWithData(getText("IGUI_WorldMapEditor_Pyramid"), "Pyramid")
	self.layerType:addOptionWithData(getText("IGUI_WorldMapEditor_Line"), "Line")
	self.layerType:addOptionWithData(getText("IGUI_WorldMapEditor_Polygon"), "Polygon")
	self.layerType:addOptionWithData(getText("IGUI_WorldMapEditor_Texture"), "Text")
	self.layerType:addOptionWithData(getText("IGUI_WorldMapEditor_Texture"), "Texture")

	local label = ISLabel:new(self.listbox.x, self.layerType:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_WorldMapEditor_MinZoom") .. ":", 0, 0, 0, 1, UIFont.Small, true)
	self:addChild(label)
	self.zoomEntry = ISTextEntryBox:new("0.00", label:getRight() + UI_BORDER_SPACING, label.y, 80, BUTTON_HGT)
	self.zoomEntry.onCommandEntered = function(entry) self:onMinZoomEntered() end
	self:addChild(self.zoomEntry)
	self.zoomEntry:setOnlyNumbers(true)

	self.editors = {}
	self.currentEditor = nil

	for _,type in ipairs({'Polygon', 'Pyramid', 'Text', 'Texture'}) do
		self.editors[type] = _G["WorldMapStyleEditor_" .. type .. "LayerPanel"]:new(self)
		self:addChild(self.editors[type])
		self.editors[type]:setVisible(false)
	end
end

function WorldMapEditorMode_Style:render()
end

function WorldMapEditorMode_Style:onMouseDown(x, y)
	if self.currentEditor and self.currentEditor:onMouseDownMap(x, y) then
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Style:onMouseUp(x, y)
	if self.currentEditor and self.currentEditor:onMouseUpMap(x, y) then
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Style:onMouseUpOutside(x, y)
	if self.currentEditor and self.currentEditor:onMouseUpOutsideMap(x, y) then
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Style:onMouseMove(dx, dy)
	if self.currentEditor and self.currentEditor:onMouseMoveMap(dx, dy) then
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Style:onRightMouseDown(x, y)
	if self.currentEditor and self.currentEditor:onRightMouseDownMap(x, y) then
		return true
	end
	return false
end

function WorldMapEditorMode_Style:onKeyPress(key)
	if self.currentEditor and self.currentEditor:onKeyPress(key) then
		return true
	end
	return false
end

function WorldMapEditorMode_Style:display()
	WorldMapEditorMode.display(self)
end

function WorldMapEditorMode_Style:undisplay()
	WorldMapEditorMode.undisplay(self)
	self.layerNameEntry:unfocus()
	if self.currentEditor then
		self.currentEditor:undisplay()
	end
	self.listbox.selectedItem = nil -- redisplay the current editor later
end

function WorldMapEditorMode_Style:loadSettingsFromMap()
	self:fillList()
end

function WorldMapEditorMode_Style:fillList()
	self.listbox:clear()
	local api = self.styleAPI
	for i=1,api:getLayerCount() do
		local layer = api:getLayerByIndex(i-1)
		self.listbox:addItem(string.format("%s     [%s]", layer:getId(), layer:getTypeString()), layer)
	end
end

function WorldMapEditorMode_Style:onListboxEvent(action)
	if action == "add" then
		self:onAdd()
	elseif action == "remove" then
		self:onRemove()
	elseif action == "up" then
		self:onMoveUp()
	elseif action == "down" then
		self:onMoveDown()
	elseif action == "select" then
		self:onSelect()
	end
end

function WorldMapEditorMode_Style:onAdd()
	local layerId = self.layerNameEntry:getText()
	local typeStr = self.layerType:getOptionData(self.layerType.selected)
	local layer = nil
	if typeStr == "Line" then
		layer = self.styleAPI:newLineLayer(layerId)
	elseif typeStr == "Polygon" then
		layer = self.styleAPI:newPolygonLayer(layerId)
	elseif typeStr == "Pyramid" then
		layer = self.styleAPI:newPyramidLayer(layerId)
	elseif typeStr == "Text" then
        layer = self.styleAPI:newTextLayer(layerId)
	elseif typeStr == "Texture" then
		layer = self.styleAPI:newTextureLayer(layerId)
		local x1 = self.mapAPI:getCenterWorldX() - 100
		local y1 = self.mapAPI:getCenterWorldY() - 100
		local x2 = x1 + 200
		local y2 = y1 + 200
		layer:setBoundsInSquares(x1, y1, x2, y2)
	else
		return
	end
	self:fillList()
	self.listbox:setSelectedIndex(self.listbox:size())
end

function WorldMapEditorMode_Style:onRemove()
	local index = self.listbox:getSelectedIndex()
	self.styleAPI:removeLayerByIndex(index - 1)
	self:fillList()
end

function WorldMapEditorMode_Style:onMoveUp()
	local index = self.listbox:getSelectedIndex()
	index = index - 1
	self.styleAPI:moveLayer(index, index - 1)
	self:fillList()
	self.listbox:setSelectedIndex(index)
end

function WorldMapEditorMode_Style:onMoveDown()
	local index = self.listbox:getSelectedIndex()
	index = index - 1
	self.styleAPI:moveLayer(index, index + 1)
	self:fillList()
	self.listbox:setSelectedIndex(index + 2)
end

function WorldMapEditorMode_Style:onSelect()
	local item = self.listbox:getSelectedItem()
	local layer = item and item.item or nil
	local text = layer and layer:getId() or ""
	self.layerNameEntry:setText(text)
	if layer then
		local typeStr = layer:getTypeString()
		self.layerType:selectData(typeStr)
		self.zoomEntry:setText(tostring(layer:getMinZoom()))
		self:setCurrentEditor(layer)
	else
		self.layerType.selected = 1
		self.zoomEntry:setText("0.0")
		self:setCurrentEditor(nil)
	end
end

function WorldMapEditorMode_Style:onLayerNameEntered()
	local item = self.listbox:getSelectedItem()
	if not item then return end
	local layer = item.item
	layer:setId(self.layerNameEntry:getText())
	item.text = string.format("%s     [%s]", layer:getId(), layer:getTypeString())
end

function WorldMapEditorMode_Style:onChangeLayerType()
	
end

function WorldMapEditorMode_Style:onMinZoomEntered()
	local item = self.listbox:getSelectedItem()
	if not item then return end
	local layer = item.item
	layer:setMinZoom(tonumber(self.zoomEntry:getText()) or 0.0)
end

function WorldMapEditorMode_Style:setCurrentEditor(layer)
	if self.currentEditor then
		self.currentEditor:undisplay()
	end
	self.currentEditor = layer and self.editors[layer:getTypeString()] or nil
	if self.currentEditor then
		self.currentEditor:display(layer)
	end
end

function WorldMapEditorMode_Style:generateLuaScript()
	local script = "local mapAPI = mapUI.javaObject:getAPIv1()\nlocal styleAPI = mapAPI:getStyleAPI()\nlocal layer = nil\n\n"
	local styleAPI = self.styleAPI
	for i=1,styleAPI:getLayerCount() do
		local layer = styleAPI:getLayerByIndex(i-1)
		script = string.format("%slayer = styleAPI:new%sLayer(\"%s\")\n", script, layer:getTypeString(), layer:getId())
		script = string.format("%slayer:setMinZoom(%.2f)\n", script, layer:getMinZoom())
		if layer:getTypeString() == "Line" then
			script = string.format("%slayer:setFilter(\"%s\", \"%s\")\n", script, layer:getFilterKey(), layer:getFilterValue())
		    script = string.format("%s%s", script, self:generateLuaScript_FillStops(layer))
		    script = string.format("%s%s", script, self:generateLuaScript_TextureStops(layer))
		elseif layer:getTypeString() == "Polygon" then
			script = string.format("%slayer:setFilter(\"%s\", \"%s\")\n", script, layer:getFilterKey(), layer:getFilterValue())
		    script = string.format("%s%s", script, self:generateLuaScript_FillStops(layer))
		    script = string.format("%s%s", script, self:generateLuaScript_TextureStops(layer))
		elseif layer:getTypeString() == "Pyramid" then
			script = string.format("%slayer:setPyramidFileName(\"%s\")\n", script, layer:getPyramidFileName())
		    script = string.format("%s%s", script, self:generateLuaScript_FillStops(layer))
		elseif layer:getTypeString() == "Text" then
		    script = string.format("%s%s", script, self:generateLuaScript_FillStops(layer))
		    -- TODO: scale stops
		elseif layer:getTypeString() == "Texture" then
			local x1 = layer:getMinXInSquares()
			local y1 = layer:getMinYInSquares()
			local x2 = layer:getMaxXInSquares()
			local y2 = layer:getMaxYInSquares()
			script = string.format("%slayer:setBoundsInSquares(%d, %d, %d, %d)\n", script, x1, y1, x2, y2)
			script = string.format("%slayer:setTile(%s)\n", script, layer:isTile() and "true" or "false")
			script = string.format("%slayer:setUseWorldBounds(%s)\n", script, layer:isUseWorldBounds() and "true" or "false")
		    script = string.format("%s%s", script, self:generateLuaScript_FillStops(layer))
		    script = string.format("%s%s", script, self:generateLuaScript_TextureStops(layer))
		end
		script = script .. "\n"
	end
	return script
end

function WorldMapEditorMode_Style:generateLuaScript_FillStops(layer)
	local script = ""
	for i=1,layer:getFillStops() do
		local zoom = layer:getFillZoom(i-1)
		local r = layer:getFillRed(i-1)
		local g = layer:getFillGreen(i-1)
		local b = layer:getFillBlue(i-1)
		local a = layer:getFillAlpha(i-1)
		script = string.format("%slayer:addFill(%.2f, %d, %d, %d, %d)\n", script, zoom, r, g, b, a)
	end
	return script
end

function WorldMapEditorMode_Style:generateLuaScript_TextureStops(layer)
	local script = ""
	for i=1,layer:getTextureStops() do
		local zoom = layer:getTextureZoom(i-1)
		local texturePath = layer:getTexturePath(i-1)
		script = string.format("%slayer:addTexture(%.2f, \"%s\")\n", script, zoom, texturePath)
	end
	return script
end

function WorldMapEditorMode_Style:new(editor)
	local o = WorldMapEditorMode.new(self, editor)
	return o
end

