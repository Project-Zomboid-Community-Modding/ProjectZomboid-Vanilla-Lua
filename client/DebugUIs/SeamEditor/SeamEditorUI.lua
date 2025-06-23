--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISScrollingListBox"
require "DebugUIs/SeamEditor/SeamEditorUI_SeamTileList"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local Z_SCALE = 0.8164966666666666
local TEXTURE_OFFSET_X = 1
local ONE_STAIRCASE_STEP = Z_SCALE * 3 / 12 -- 0.20412416666666666

SeamEditorUI = ISPanel:derive("SeamEditorUI")

-- from ISMoveableSpriteProps.lua
local function lastIndexOf( _string, _needle)
	local i=_string:match(".*".._needle.."()")
	if i==nil then return nil else return i end
end

-----

SeamEditorUI_OptionsPanel = ISPanel:derive("SeamEditorUI_OptionsPanel")
local OptionsPanel = SeamEditorUI_OptionsPanel

function OptionsPanel:createChildren()
	local tickBox = ISTickBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, "", self, self.onTickBox)
	tickBox:initialise()
	self:addChild(tickBox)
	local gameState = getSeamEditorState()
	for i=1,gameState:getOptionCount() do
		local option = gameState:getOptionByIndex(i-1)
		tickBox:addOption(option:getName(), option)
		tickBox:setSelected(i, option:getValue())
	end
	tickBox:setWidthToFit()
	self.tickBox = tickBox
	self:shrinkWrap(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, nil)
end

function OptionsPanel:onTickBox(index, selected)
	local option = self.tickBox.optionData[index]
	option:setValue(selected)
	if option:getName() == "DrawGrid" then
		self.parent.scene.javaObject:fromLua1("setDrawGrid", selected)
	end
end

function OptionsPanel:onMouseDownOutside(x, y)
	if self:isMouseOver() then return end
	self:setVisible(false)
--	self:removeFromUIManager()
end

function OptionsPanel:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.a = 0.8
	return o
end

-----

SeamEditorUI_Scene = ISPanel:derive("SeamEditorUI_Scene")
local Scene = SeamEditorUI_Scene

function Scene:prerenderEditor()
end

function Scene:prerender()
	ISPanel.prerender(self)
end

function Scene:render()
	ISPanel.render(self)
	self:renderTileName()
	local picker = self.editor.tilePicker.listBox
	local selectedTile = picker:getSingleSelectedTile()
	if not selectedTile then
		if self.selectedTileName ~= nil then
			self.selectedTileName = nil
		end
		return
	end
	local tileIndex = selectedTile.index
	local tileName = selectedTile.tileName
	local texture = getTexture(tileName)
	if not texture then
		if self.selectedTileName ~= nil then
			self.selectedTileName = nil
		end
		return
	end

	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	if true then
		self:renderSelectedTile(tileName, texture)
		self:renderPixelGrid(tileName)
		self:renderTextureOutline(sx, sy, sx2, sy2, pixelSize, texture)
	end

	-- floor bounds
	self:renderFloorBounds(0.0, 0.0, 0.0, 1.0, 1.0, 1.0)
--[[
	local floorHgt = 64
	local shiftX = -1 * pixelSize
	self:drawLine2(sx + shiftX, sy2 - floorHgt / 2 * pixelSize, sx + 128 / 2 * pixelSize + shiftX, sy2 - floorHgt * pixelSize, 1.0, 1.0, 1.0, 1.0)
	self:drawLine2(sx + 128 / 2 * pixelSize + shiftX, sy2 - floorHgt * pixelSize, sx2 + shiftX, sy2 - floorHgt / 2 * pixelSize, 1.0, 1.0, 1.0, 1.0)
	self:drawLine2(sx2 + shiftX, sy2 - floorHgt / 2 * pixelSize, sx + 128 / 2 * pixelSize + shiftX, sy2, 1.0, 1.0, 1.0, 1.0)
	self:drawLine2(sx + 128 / 2 * pixelSize + shiftX, sy2, sx + shiftX, sy2 - floorHgt / 2 * pixelSize, 1.0, 1.0, 1.0, 1.0)
--]]
	local renderDraggedTile = self.editor.tilePicker2.listBox:getDraggedTileName() ~= nil
	if true then -- east square
		local r,g,b = 0.2,0.2,0.2
		local worldX,worldY = self:uiToWorld(self:getMouseX(), self:getMouseY(), 0)
		if renderDraggedTile and worldX >= 1 and worldX < 2 and worldY >= 0 and worldY < 1 then
			r,g,b = 0.0,1.0,0.0
			renderDraggedTile = false
			self:renderTileEast()
		elseif self.editor.currentSeamTile == "east" then
			r,g,b = 0.0,1.0,0.0
		end
		self:renderFloorBounds(1.0, 0.0, 0.0, r, g, b)
	end
	if true then -- south square
		local r,g,b = 0.2,0.2,0.2
		local worldX,worldY = self:uiToWorld(self:getMouseX(), self:getMouseY(), 0)
		if renderDraggedTile and worldX >= 0 and worldX < 1 and worldY >= 1 and worldY < 2 then
			r,g,b = 0.0,1.0,0.0
			renderDraggedTile = false
			self:renderTileSouth()
		elseif self.editor.currentSeamTile == "south" then
			r,g,b = 0.0,1.0,0.0
		end
		self:renderFloorBounds(0.0, 1.0, 0.0, r, g, b)
	end
	if true then -- below east square
		local r,g,b = 0.2,0.2,0.2
		local worldX,worldY = self:uiToWorld(self:getMouseX(), self:getMouseY(), -1)
		if renderDraggedTile and worldX >= 1 and worldX < 2 and worldY >= 0 and worldY < 1 then
			r,g,b = 0.0,1.0,0.0
			renderDraggedTile = false
			self:renderTileBelowEast()
		elseif self.editor.currentSeamTile == "belowEast" then
			r,g,b = 0.0,1.0,0.0
		end
		self:renderFloorBounds(1.0, 0.0, -1.0, r, g, b)
	end
	if true then -- below south square
		local r,g,b = 0.2,0.2,0.2
		local worldX,worldY = self:uiToWorld(self:getMouseX(), self:getMouseY(), -1)
		if renderDraggedTile and worldX >= 0 and worldX < 1 and worldY >= 1 and worldY < 2 then
			r,g,b = 0.0,1.0,0.0
			renderDraggedTile = false
			self:renderTileBelowSouth()
		elseif self.editor.currentSeamTile == "belowSouth" then
			r,g,b = 0.0,1.0,0.0
		end
		self:renderFloorBounds(0.0, 1.0, -1.0, r, g, b)
	end

	if true then
		-- Bounding box around the tile
		local tileX = sx
		local tileY = sy
		self:drawRectBorder(tileX, tileY, 128 * pixelSize, 256 * pixelSize, 1.0, 1.0, 1.0, 1.0)
	end

	if renderDraggedTile then
		self:renderDraggedTile()
	end

	self.editor.seamTileList.east:renderMouseOverTile()
	self.editor.seamTileList.south:renderMouseOverTile()
	self.editor.seamTileList.belowEast:renderMouseOverTile()
	self.editor.seamTileList.belowSouth:renderMouseOverTile()

	if tileName ~= self.selectedTileName then
		self.selectedTileName = tileName
	end
end

function Scene:renderTileAt(texture, x, y, z)
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	local floorHgt = 64
	local shiftX = (x * 128 / 2 * pixelSize) - (y * 128 / 2 * pixelSize)
	local shiftY = (x * floorHgt / 2 * pixelSize) + (y * floorHgt / 2 * pixelSize)
	shiftY = shiftY - z * 192 * pixelSize
	local alpha = 1.0
	self:drawTextureScaled(texture,
		sx + shiftX + texture:getOffsetX() * pixelSize,
		sy + shiftY + texture:getOffsetY() * pixelSize,
		texture:getWidth() * pixelSize,
		texture:getHeight() * pixelSize,
		alpha, 1.0, 1.0, 1.0)

--	self:drawRectBorder(sx + shiftX, sy + shiftY, 128 * pixelSize, 256 * pixelSize, 1.0, 1.0, 1.0, 1.0)
end

function Scene:renderSelectedTile(tileName, texture)
	self:renderTileAt(texture, 0, 0, 0)
end

function Scene:renderTileName()
	local picker = self.editor.tilePicker.listBox
	local selectedTile = picker:getSingleSelectedTile()
	local tileName = selectedTile and selectedTile.tileName or nil

	local picker2 = self.editor.tilePicker2.listBox
	if picker2.tileset and picker2:isMouseOver() then
		local col,row = picker2:getColRowAt(picker2:getMouseX(), picker2:getMouseY())
		if col >= 1 and col <= 8 and row >= 1 then
			local tileIndex = (col - 1) + (row - 1) * 8
			tileName = string.format("%s_%d", picker2.tileset, tileIndex)
		end
	end

	if picker.tileset and picker:isMouseOver() then
		local col,row = picker:getColRowAt(picker:getMouseX(), picker:getMouseY())
		if col >= 1 and col <= 8 and row >= 1 then
			local tileIndex = (col - 1) + (row - 1) * 8
			tileName = string.format("%s_%d", picker.tileset, tileIndex)
		end
	end
	if not tileName then return end
	self:drawTextCentre(tileName, self.width / 2, self.height - 10 - FONT_HGT_MEDIUM, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)
end

function Scene:renderDraggedTile()
	self.editor.tilePicker2.listBox:renderDraggedTile()
end

function Scene:renderTileEast()
	local params = self.editor.tilePicker2.listBox.mouseDownParams
	local texture = self.editor.tilePicker2.listBox:getTextureAt(params.col, params.row)
	self:renderTileAt(texture, 1, 0, 0)
end

function Scene:renderTileSouth()
	local params = self.editor.tilePicker2.listBox.mouseDownParams
	local texture = self.editor.tilePicker2.listBox:getTextureAt(params.col, params.row)
	self:renderTileAt(texture, 0, 1, 0)
end

function Scene:renderTileBelowEast()
	local params = self.editor.tilePicker2.listBox.mouseDownParams
	local texture = self.editor.tilePicker2.listBox:getTextureAt(params.col, params.row)
	self:renderTileAt(texture, 1, 0, -1)
end

function Scene:renderTileBelowSouth()
	local params = self.editor.tilePicker2.listBox.mouseDownParams
	local texture = self.editor.tilePicker2.listBox:getTextureAt(params.col, params.row)
	self:renderTileAt(texture, 0, 1, -1)
end

function Scene:renderFloorBounds(x, y, z, r, g, b)
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	local floorHgt = 64
	local shiftX = (x * 128 / 2 * pixelSize) - (y * 128 / 2 * pixelSize)
	local shiftY = (x * floorHgt / 2 * pixelSize) + (y * floorHgt / 2 * pixelSize)
	shiftY = shiftY - z * 192 * pixelSize
	self:drawLine2(sx + shiftX, sy2 - floorHgt / 2 * pixelSize + shiftY, sx + 128 / 2 * pixelSize + shiftX, sy2 - floorHgt * pixelSize + shiftY, 1.0, r, g, b)
	self:drawLine2(sx + 128 / 2 * pixelSize + shiftX, sy2 - floorHgt * pixelSize + shiftY, sx2 + shiftX, sy2 - floorHgt / 2 * pixelSize + shiftY, 1.0, r, g, b)
	self:drawLine2(sx2 + shiftX, sy2 - floorHgt / 2 * pixelSize + shiftY, sx + 128 / 2 * pixelSize + shiftX, sy2 + shiftY, 1.0, r, g, b)
	self:drawLine2(sx + 128 / 2 * pixelSize + shiftX, sy2 + shiftY, sx + shiftX, sy2 - floorHgt / 2 * pixelSize + shiftY, 1.0, r, g, b)
end

function Scene:uiToWorld(screenX, screenY, z)
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	local floorHgt = 64
	local originX = sx + 128 / 2 * pixelSize
	local originY = sy2 - floorHgt * pixelSize
	originY = originY - z * 192 * pixelSize
	screenX = (screenX - originX) / pixelSize
	screenY = (screenY - originY) / pixelSize
	local worldX = (screenX + 2 * screenY) / 128
	local worldY = (screenX - 2 * screenY) / -128
	return worldX,worldY
end

function Scene:onMouseDown(x, y)
	ISPanel.onMouseDown(self, x, y)
	local worldX,worldY = self:uiToWorld(x, y, 0)
	if worldX >= 1 and worldX < 2 and worldY >= 0 and worldY < 1 then
		self.editor.currentSeamTile = "east"
		return
	end
	if worldX >= 0 and worldX < 1 and worldY >= 1 and worldY < 2 then
		self.editor.currentSeamTile = "south"
		return
	end
	worldX,worldY = self:uiToWorld(x, y, -1)
	if worldX >= 1 and worldX < 2 and worldY >= 0 and worldY < 1 then
		self.editor.currentSeamTile = "belowEast"
		return
	end
	if worldX >= 0 and worldX < 1 and worldY >= 1 and worldY < 2 then
		self.editor.currentSeamTile = "belowSouth"
		return
	end
	self.editor.currentSeamTile = nil
end

function Scene:onMouseMove(dx, dy)
end

function Scene:onMouseUp(x, y)
end

function Scene:onMouseUpOutside(x, y)
	self:onMouseUp(x, y)
end

function Scene:onRightMouseDown(x, y)
end

function Scene:getTileBoundsEtc()
	local floorHgt = self.height / 8.5
	local sx = self.width / 2
	local sy = floorHgt * 4
	local sx2 = sx + floorHgt / 2
	local sy2 = sy + floorHgt
	local pixelSize = math.sqrt((sx2 - sx) * (sx2 - sx) + (sy2 - sy) * (sy2 - sy)) / math.sqrt(32 * 32 + 64 * 64)
	local tileX1 = sx - (128 / 2) * pixelSize
	local tileY1 = sy - (256 - 32) * pixelSize
	local tileX2 = tileX1 + 128 * pixelSize
	local tileY2 = tileY1 + 256 * pixelSize
	tileX1 = tileX1 + TEXTURE_OFFSET_X * pixelSize
	tileX2 = tileX2 + TEXTURE_OFFSET_X * pixelSize
	return tileX1,tileY1,tileX2,tileY2,pixelSize
end

function Scene:uiToPixel(x, y)
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	x = math.floor((x - sx) / pixelSize)
	y = math.floor((y - sy) / pixelSize)
	return x,y
end

function Scene:snapToTilePixel(x, y)
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	x = Math.round((x - sx) / pixelSize) * pixelSize + sx
	y = Math.round((y - sy) / pixelSize) * pixelSize + sy
	return x,y
end

function Scene:getSelectedTileName()
	local picker = self.editor.tilePicker.listBox
	local selectedTile = picker:getSingleSelectedTile()
	if not selectedTile then return nil end
	return string.format("%s_%d", picker.tileset, (selectedTile.col - 1) + (selectedTile.row - 1) * 8)
end

function Scene:getSelectedTile()
	local picker = self.editor.tilePicker.listBox
	local selectedTile = picker:getSingleSelectedTile()
	if not selectedTile then return nil end
	return picker.tileset,selectedTile.index
end

function Scene:renderPixelGrid(tileName)
	if not getSeamEditorState():getBoolean("DrawPixelGrid") then return end
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	if pixelSize < 5 then return end
	for x=1,127 do
		self:drawRect(sx + x * pixelSize, sy, 1, sy2 - sy, 0.5, 0, 162/255, 232/255)
	end
	for y=1,255 do
		self:drawRect(sx, sy + y * pixelSize, sx2 - sx, 1, 0.5, 0, 162/255, 232/255)
	end
end

function Scene:renderTextureOutline(sx, sy, sx2, sy2, pixelSize, texture)
	if not getSeamEditorState():getBoolean("DrawTextureOutline") then return end
	self:drawRectBorder(sx + texture:getOffsetX() * pixelSize,
		sy + texture:getOffsetY() * pixelSize,
		texture:getWidth() * pixelSize,
		texture:getHeight() * pixelSize,
		1, 0, 162 / 255, 232 / 255)
end

function Scene:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor = {r=0.5, g=0.5, b=0.5, a=1.0}
	o.editor = editor
	return o
end

-----

require "DebugUIs/SeamEditor/SeamEditorUI_TileList"
local TileList = SeamEditorUI_TileList

-----

SeamEditorUI_TilePicker = ISPanel:derive("SeamEditorUI_TilePicker")
local TilePicker = SeamEditorUI_TilePicker

function TilePicker:createChildren()
	local comboHeight = FONT_HGT_MEDIUM + 3 * 2
	local combo = ISComboBox:new(0, 0, self.width, comboHeight, self, self.onSelectTileset)
	combo.noSelectionText = "TILESET"
	combo:setEditable(true)
	self:addChild(combo)
	self.comboTileset = combo

	local tilesetNames = getWorld():getAllTilesName()
	for i=1,tilesetNames:size() do
		local tilesetName = tilesetNames:get(i-1)
		local tileNames = getWorld():getAllTiles(tilesetName)
		local hasBed = false
		for j=1,tileNames:size() do
			local sprite = getSprite(tileNames:get(j-1))
			if sprite then -- and sprite:getProperties():Is(IsoFlagType.bed) then
				hasBed = true
				break
			end
		end
		if hasBed then
			self.comboTileset:addOption(tilesetName)
		end
	end

	local listY = combo:getBottom() + 10
	local listBox = TileList:new(0, listY, self.width, self.height - listY, self)
	listBox:setAnchorBottom(true)
	self:addChild(listBox)
	listBox:addScrollBars()
	self.listBox = listBox
end

function TilePicker:onMouseWheel(del)
	self.listBox:onMouseWheel(del)
	return true
end

function TilePicker:onSelectTileset()
	local tilesetName = self.comboTileset:getOptionText(self.comboTileset.selected)
	self.listBox:setTileset(tilesetName)
end

function TilePicker:selectTileByName(tileName)
	local tileset,tileIndex = self:parseTileName(tileName)
	if not tileset then return end
	self.comboTileset:select(tileset)
	self.listBox:setTileset(tileset)
	self.listBox:selectionAdd(tileIndex % 8 + 1, math.floor(tileIndex / 8) + 1)
end

function TilePicker:parseTileName(tileName)
	local index = lastIndexOf(tileName, "_")
	if index then
		local tileset = tileName:sub(1, index-1-1)
		local tileIndex = tonumber(tileName:sub(index))
		return tileset,tileIndex
	end
	return nil
end

function TilePicker:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

require "DebugUIs/SeamEditor/SeamEditorUI_TileList2"
local TileList2 = SeamEditorUI_TileList2

-----

SeamEditorUI_TilePicker2 = ISPanel:derive("SeamEditorUI_TilePicker2")
local TilePicker2 = SeamEditorUI_TilePicker2

function TilePicker2:createChildren()
	local comboHeight = FONT_HGT_MEDIUM + 3 * 2
	local combo = ISComboBox:new(0, 0, self.width, comboHeight, self, self.onSelectTileset)
	combo.noSelectionText = "TILESET"
	combo:setEditable(true)
	self:addChild(combo)
	self.comboTileset = combo

	local tilesetNames = getWorld():getAllTilesName()
	for i=1,tilesetNames:size() do
		local tilesetName = tilesetNames:get(i-1)
		local tileNames = getWorld():getAllTiles(tilesetName)
		local hasBed = false
		for j=1,tileNames:size() do
			local sprite = getSprite(tileNames:get(j-1))
			if sprite then -- and sprite:getProperties():Is(IsoFlagType.bed) then
				hasBed = true
				break
			end
		end
		if hasBed then
			self.comboTileset:addOption(tilesetName)
		end
	end

	local listY = combo:getBottom() + 10
	local listBox = TileList2:new(0, listY, self.width, self.height - listY, self)
	listBox:setAnchorBottom(true)
	self:addChild(listBox)
	listBox:addScrollBars()
	self.listBox = listBox
end

function TilePicker2:onMouseWheel(del)
	self.listBox:onMouseWheel(del)
	return true
end

function TilePicker2:onSelectTileset()
	local tilesetName = self.comboTileset:getOptionText(self.comboTileset.selected)
	self.listBox:setTileset(tilesetName)
end

function TilePicker2:selectTileByName(tileName)
	local tileset,tileIndex = self:parseTileName(tileName)
	if not tileset then return end
	self.comboTileset:select(tileset)
	self.listBox:setTileset(tileset)
	self.listBox:selectionAdd(tileIndex % 8 + 1, math.floor(tileIndex / 8) + 1)
end

function TilePicker2:parseTileName(tileName)
	local index = lastIndexOf(tileName, "_")
	if index then
		local tileset = tileName:sub(1, index-1-1)
		local tileIndex = tonumber(tileName:sub(index))
		return tileset,tileIndex
	end
	return nil
end

function TilePicker2:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

function SeamEditorUI:createChildren()
	local gameState = getSeamEditorState()

	local buttonPadY = 4
	local buttonHgt = FONT_HGT_MEDIUM + 8
	local bottomH = 10 + buttonHgt + buttonPadY

	self.scene = Scene:new(0, 0, self.width, self.height, self)
	self.scene:initialise()
	self.scene:instantiate()
	self.scene:setAnchorRight(true)
	self.scene:setAnchorBottom(true)
	self:addChild(self.scene)

	self:createToolbar()

	self.seamTileList = {}
	self.seamTileList.east = SeamEditorUI_SeamTileList:new(10, 40, 32, self.height - 10 - buttonHgt - 10 - 40, self, "east")
	self:addChild(self.seamTileList.east)
	local prev = self.seamTileList.east
	self.seamTileList.south = SeamEditorUI_SeamTileList:new(prev:getRight() + 10, 40, 32, self.height - 10 - buttonHgt - 10 - 40, self, "south")
	self:addChild(self.seamTileList.south)
	prev = self.seamTileList.south
	self.seamTileList.belowEast = SeamEditorUI_SeamTileList:new(prev:getRight() + 10, 40, 32, self.height - 10 - buttonHgt - 10 - 40, self, "belowEast")
	self:addChild(self.seamTileList.belowEast)
	prev = self.seamTileList.belowEast
	self.seamTileList.belowSouth = SeamEditorUI_SeamTileList:new(prev:getRight() + 10, 40, 32, self.height - 10 - buttonHgt - 10 - 40, self, "belowSouth")
	self:addChild(self.seamTileList.belowSouth)

	local scrollbarWidth = 13
	self.tilePicker = TilePicker:new(self.width - 10 - (8 * 32 + scrollbarWidth), 40, 8 * 32 + scrollbarWidth, self.height - 10 - 40, self)
	self.tilePicker:setAnchorBottom(true)
	self:addChild(self.tilePicker)

	self.tilePicker2 = TilePicker2:new(self.tilePicker.x - 10 - (8 * 32 + scrollbarWidth), 40, 8 * 32 + scrollbarWidth, self.height - 10 - 40, self)
	self.tilePicker2:setAnchorBottom(true)
	self:addChild(self.tilePicker2)

	self.bottomPanel = ISPanel:new(0, self.height - bottomH, 200, bottomH)
	self.bottomPanel:setAnchorTop(false)
	self.bottomPanel:setAnchorLeft(false)
	self.bottomPanel:setAnchorRight(false)
	self.bottomPanel:setAnchorBottom(true)
	self.bottomPanel:noBackground()
	self:addChild(self.bottomPanel)

	local button2 = ISButton:new(10, self.bottomPanel.height - 10 - buttonHgt, 80, buttonHgt, "EXIT", self, self.onExit)
	self.bottomPanel:addChild(button2)
	button2:enableCancelColor()

	local button3 = ISButton:new(button2:getRight() + 10, button2.y, 80, buttonHgt, "SAVE", self, self.onSave)
	self.bottomPanel:addChild(button3)
	button3:enableAcceptColor()
end

function SeamEditorUI:createToolbar()
	local toolHgt = 30
	self.toolBar = ISPanel:new(0, 10, 300, toolHgt)
	self.toolBar:noBackground()
	self:addChild(self.toolBar)

	local comboHeight = FONT_HGT_MEDIUM + 3 * 2
	comboHeight = math.max(comboHeight, toolHgt)
	self.comboModID = ISComboBox:new(0, 0, 200, comboHeight, self, self.onSelectModID)
	self.toolBar:addChild(self.comboModID)
	local modIDs = TileGeometryManager.getInstance():getModIDs()
	for i=1,modIDs:size() do
		self.comboModID:addOption(modIDs:get(i-1))
	end
	self.comboModID:setWidthToOptions()

	local button = ISButton:new(self.comboModID:getRight() + 20, 0, 60, toolHgt, "OPTIONS", self, self.onOptions)
	self.toolBar:addChild(button)
	self.buttonOptions = button

	self.toolBar:shrinkWrap(0, 0, nil)
	self.toolBar:setX(self.width / 2 - self.toolBar.width / 2)

	self.optionsPanel = OptionsPanel:new(0, 0, 300, 400)
	self.optionsPanel:setVisible(false)
	self:addChild(self.optionsPanel)
end

function SeamEditorUI:indexOf(tbl, element)
	for index,element2 in ipairs(tbl) do
		if element2 == element then
			return index
		end
	end
	return -1
end

function SeamEditorUI:onResolutionChange(oldw, oldh, neww, newh)
	self:setWidth(neww)
	self:setHeight(newh)
	self.tilePicker:setX(self.width - 10 - self.tilePicker.width)
--	self.tilePicker:setHeight(self.height - 10 - 40)
	self.tilePicker2:setX(self.tilePicker.x - 10 - self.tilePicker2.width)
--	self.tilePicker2:setHeight(self.height - 10 - 40)
end

function SeamEditorUI:update()
	ISPanel.update(self)
	if self.width ~= getCore():getScreenWidth() or self.height ~= getCore():getScreenHeight() then
		self:onResolutionChange(self.width, self.height, getCore():getScreenWidth(), getCore():getScreenHeight())
	end
end

function SeamEditorUI:prerender()
	ISPanel.prerender(self)
	self.scene:prerenderEditor()
end

function SeamEditorUI:render()
	ISPanel.render(self)
end

function SeamEditorUI:onKeyPress(key)
	if key == Keyboard.KEY_LEFT then
		self.scene.shiftX = (self.scene.shiftX or 0) - 1
	end
	if key == Keyboard.KEY_RIGHT then
		self.scene.shiftX = (self.scene.shiftX or 0) + 1
	end
	if key == Keyboard.KEY_UP then
		self.scene.shiftY = (self.scene.shiftY or 0) - 1
	end
	if key == Keyboard.KEY_DOWN then
		self.scene.shiftY = (self.scene.shiftY or 0) + 1
	end
	if key == Keyboard.KEY_Z then
		self.scene.shiftX = 0
		self.scene.shiftY = 0
	end
end

function SeamEditorUI:onSelectModID()
	self.modID = self.comboModID:getOptionText(self.comboModID.selected)
	self.scene.selectedTileName = nil
end

function SeamEditorUI:onOptions()
	self.optionsPanel:setX(self.buttonOptions:getAbsoluteX())
	self.optionsPanel:setY(self.buttonOptions:getAbsoluteY() + self.buttonOptions:getHeight())
	self.optionsPanel:setVisible(true)
end

function SeamEditorUI:assignEastTile(tileName)
	local tilesetName,tileIndex = self.scene:getSelectedTile()
	local tileNames = SeamManager.getInstance():getTileJoinE(self.modID, tilesetName, tileIndex % 8, tileIndex / 8, true)
	if not tileNames:contains(tileName) then
		tileNames:add(tileName)
	end
	self.currentSeamTile = "east"
end

function SeamEditorUI:assignSouthTile(tileName)
	local tilesetName,tileIndex = self.scene:getSelectedTile()
	local tileNames = SeamManager.getInstance():getTileJoinS(self.modID, tilesetName, tileIndex % 8, tileIndex / 8, true)
	if not tileNames:contains(tileName) then
		tileNames:add(tileName)
	end
	self.currentSeamTile = "south"
end

function SeamEditorUI:assignBelowEastTile(tileName)
	local tilesetName,tileIndex = self.scene:getSelectedTile()
	local tileNames = SeamManager.getInstance():getTileJoinBelowE(self.modID, tilesetName, tileIndex % 8, tileIndex / 8, true)
	if not tileNames:contains(tileName) then
		tileNames:add(tileName)
	end
	self.currentSeamTile = "belowEast"
end

function SeamEditorUI:assignBelowSouthTile(tileName)
	local tilesetName,tileIndex = self.scene:getSelectedTile()
	local tileNames = SeamManager.getInstance():getTileJoinBelowS(self.modID, tilesetName, tileIndex % 8, tileIndex / 8, true)
	if not tileNames:contains(tileName) then
		tileNames:add(tileName)
	end
	self.currentSeamTile = "belowSouth"
end

function SeamEditorUI:onExit(button, x, y)
	getSeamEditorState():fromLua0("exit")
end

function SeamEditorUI:onSave(button, x, y)
	SeamManager.getInstance():write(self.modID)
end

-- Called from Java
function SeamEditorUI:showUI()
end

function SeamEditorUI:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o:setAnchorRight(true)
	o:setAnchorBottom(true)
	o:noBackground()
	o:setWantKeyEvents(true)
	o.animate = true
	o.modID = "game"
	o.currentSeamTile = nil -- east | south | belowEast | belowSouth
	getSeamEditorState():setTable(o)
	return o
end

-- Called from Java
function SeamEditorUI_InitUI()
	local UI = SeamEditorUI:new(0, 0, getCore():getScreenWidth(), getCore():getScreenHeight())
	SeamEditorUI_UI = UI
	UI:setVisible(true)
	UI:addToUIManager()
end

