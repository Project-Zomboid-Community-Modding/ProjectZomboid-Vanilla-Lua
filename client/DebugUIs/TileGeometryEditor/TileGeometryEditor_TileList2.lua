--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

TileGeometryEditor_TileList2 = ISPanel:derive("TileGeometryEditor_TileList2")
local TileList2 = TileGeometryEditor_TileList2
local ROWS = 64

-- from ISMoveableSpriteProps.lua
local function lastIndexOf( _string, _needle)
	local i=_string:match(".*".._needle.."()")
	if i==nil then return nil else return i end
end

function TileList2:onMouseDown(x, y)
	if not self.tileset then return end
	self.mouseDown = true
	local col,row = self:getColRowAt(x, y)
	if self:isValidColRow(col, row) then
		if (self.editor.editMode.current == self.editor.editMode.geometry) and (not self.editor.tilePicker.listBox:isSelectionEmpty()) then
			self.mouseDownParams = {}
			self.mouseDownParams.time = getTimestampMs()
			self.mouseDownParams.col = col
			self.mouseDownParams.row = row
--			self:assignDepthTextures(col, row)
			return
		end
		if isCtrlKeyDown() then
			self:selectionToggle(col, row)
		else
			self:selectionClear()
			self:selectionAdd(col, row)
		end
	else
		self:selectionClear()
	end
end

function TileList2:onMouseUp(x, y)
	self.mouseDown = false
end

function TileList2:onMouseUpOutside(x, y)
	self.mouseDown = false
end

function TileList2:onRightMouseDown(x, y)
	if not self.tileset then return end
	local col,row = self:getColRowAt(x, y)
	if not self:isValidColRow(col, row) then return end
	if self:selectionIndexOf(col, row) == -1 then
		self:selectionClear()
		self:selectionAdd(col, row)
	end
	local player = 0
	local context = ISContextMenu.get(player, self:getAbsoluteX() + x, self:getAbsoluteY() + y + self:getYScroll())
	context:removeFromUIManager()
	context:addToUIManager()
	context:addOption("Swap Tilesets", self, self.onSwapTilesets)
	if not self:isSelectionEmpty() then
		context:addOption("Clear Assiged Depth Textures", self, self.onClearAssignedDepthTextures)
		local selectedTile = self:getSingleSelectedTile()
		if selectedTile then
			local picker = self.editor.tilePicker
			local selectedTileRight = picker.listBox:getSingleSelectedTile()
			if selectedTileRight ~= nil and selectedTileRight.tileName ~= selectedTile.tileName then
				context:addOption("Copy Geometry From Right", self, self.onCopyGeometryFromRight, selectedTile.tileName, selectedTileRight.tileName)
			end
			local sprite = getSprite(selectedTile.tileName)
			if sprite and sprite:getSpriteGrid() then
				context:addOption("Copy Geometry From Sprite Grid", self, self.onCopyGeometryFromSpriteGrid, selectedTile.tileName)
			end
			context:addOption("Select In Other List", self, self.onSelectInOtherList, selectedTile.tileName)
			local otherTile = TileDepthTextureAssignmentManager.getInstance():getAssignedTileName(self.editor.modID, selectedTile.tileName)
			if otherTile then
				context:addOption("Select Assigned Depth Texture", self, self.onSelectAssignedDepthTexture, otherTile)
			end
		end
	end
end

function TileList2:onCopyGeometryFromSpriteGrid(tileName)
	self.editor.scene:java2("copyGeometryFromSpriteGrid", self.editor.modID, tileName)
	self.editor.scene.selectedTileName = nil
end

function TileList2:onCopyGeometryFromRight(tileName, tileNameRight)
	self.editor.scene:java3("copyGeometryFrom", self.editor.modID, tileName, tileNameRight)
	self.editor.scene.selectedTileName = nil
end

function TileList2:onClearAssignedDepthTextures()
	for _,e in ipairs(self.selection.elements) do
		TileDepthTextureAssignmentManager.getInstance():clearAssignedTileName(self.editor.modID, e.tileName)
	end
end

function TileList2:onSwapTilesets(tileName)
	local picker1 = self.editor.tilePicker
	local picker2 = self.editor.tilePicker2
	local tileset1 = picker1.listBox.tileset
	local tileset2 = picker2.listBox.tileset
	picker1.comboTileset:select(tileset2)
	picker1.listBox:setTileset(tileset2)
	picker2.comboTileset:select(tileset1)
	picker2.listBox:setTileset(tileset1)
end

function TileList2:onSelectInOtherList(tileName)
	local tileset,tileIndex = self:parseTileName(tileName)
	if not tileset then return end
	local picker = self.editor.tilePicker
	picker.comboTileset:select(tileset)
	picker.listBox:setTileset(tileset)
	picker.listBox:selectionAdd(tileIndex % 8 + 1, math.floor(tileIndex / 8) + 1)
end

function TileList2:onSelectAssignedDepthTexture(tileName)
	local tileset,tileIndex = self:parseTileName(tileName)
	if not tileset then return end
	local picker = self.editor.tilePicker
	picker.comboTileset:select(tileset)
	picker.listBox:setTileset(tileset)
	picker.listBox:selectionAdd(tileIndex % 8 + 1, math.floor(tileIndex / 8) + 1)
end

function TileList2:parseTileName(tileName)
	local index = lastIndexOf(tileName, "_")
	if index then
		local tileset = tileName:sub(1, index-1-1)
		local tileIndex = tonumber(tileName:sub(index))
		return tileset,tileIndex
	end
	return nil
end

function TileList2:getColRowAt(x, y)
	local xIndent = 0
	local yIndent = 0
	local texW = 32
	local texH = texW * 2
	local col = math.floor((x - xIndent) / texW) + 1
	local row = math.floor((y - yIndent) / texH) + 1
	return col,row
end

function TileList2:isValidColRow(col, row)
	return col >= 1 and col <= 8 and row >= 1 and row <= ROWS
end

function TileList2:assignDepthTextures(col, row)
	local selection = self.editor.tilePicker.listBox:getSelection()
	for _,e in ipairs(selection.elements) do
		local tileIndex = (col - 1 + e.col - selection.minCol) + (row - 1 + e.row - selection.minRow) * 8
		local tileName = string.format("%s_%d", self.tileset, tileIndex)
		-- The selected tile in TileList #1 could have it's own depth texture, or an assigned one
		local otherTile = e.tileName
		local depthTexture = TileDepthTextureManager.getInstance():getTextureFromTileName(self.editor.modID, e.tileName)
		if not depthTexture or depthTexture:isEmpty() then
			otherTile = TileDepthTextureAssignmentManager.getInstance():getAssignedTileName(self.editor.modID, e.tileName)
		end
		TileDepthTextureAssignmentManager.getInstance():assignTileName(self.editor.modID, tileName, otherTile)
		TileDepthTextureAssignmentManager.getInstance():assignDepthTextureToSprite(self.editor.modID, tileName)
	end
end

function TileList2:selectionAdd(col, row)
	local selection = self.selection
	local tileIndex = (col - 1) + (row - 1) * 8
	local tileName = string.format("%s_%d", self.tileset, tileIndex)
	table.insert(selection.elements, { col = col, row = row, index = tileIndex, tileName = tileName })
	selection.minCol = math.min(selection.minCol, col)
	selection.minRow = math.min(selection.minRow, row)
	selection.maxCol = math.max(selection.maxCol, col)
	selection.maxRow = math.max(selection.maxRow, row)
end

function TileList2:selectionRemove(col, row)
	local selection = self.selection
	local index = self:selectionIndexOf(col, row)
	if index ~= -1 then
		table.remove(selection.elements, index)
		self:calculateSelectionBounds()
	end
end

function TileList2:selectionToggle(col, row)
	if self:selectionIndexOf(col, row) == -1 then
		self:selectionAdd(col, row)
	else
		self:selectionRemove(col, row)
	end
end

function TileList2:selectionIndexOf(col, row)
	for index,e in ipairs(self.selection.elements) do
		if col == e.col and row == e.row then
			return index
		end
	end
	return -1
end

function TileList2:selectionClear()
	table.wipe(self.selection.elements)
	self:calculateSelectionBounds()
end

function TileList2:isSelectionEmpty()
	return #self.selection.elements == 0
end

function TileList2:getSelection()
	return self.selection
end

function TileList2:getSingleSelectedTile()
	if #self.selection.elements == 1 then
		return self.selection.elements[1]
	end
	return nil
end

function TileList2:calculateSelectionBounds()
	local selection = self.selection
	selection.minCol = 100
	selection.minRow = 100
	selection.maxCol = -1
	selection.maxRow = -1
	for _,e in ipairs(selection.elements) do
		selection.minCol = math.min(selection.minCol, e.col)
		selection.minRow = math.min(selection.minRow, e.row)
		selection.maxCol = math.max(selection.maxCol, e.col)
		selection.maxRow = math.max(selection.maxRow, e.row)
	end
end

function TileList2:onMouseWheel(del)
	self:setYScroll(self:getYScroll() - del * 64)
end

function TileList2:render()
	if not self.tileset then return end

	local stencilX = 1
	local stencilY = 1
	local stencilX2 = self.width - 2
	local stencilY2 = self.height - 2

	self:setStencilRect(stencilX, stencilY, stencilX2 - stencilX, stencilY2 - stencilY)

	local xIndent = 0
	local yIndent = 0
	local texW = 32
	local texH = texW * 2

	local maxRow = 1
	local tilesetName = self.tileset
	local scale = texW / 128
	for row=1,ROWS do
		for col=1,8 do
			local tileIndex = (col - 1) + (row - 1) * 8
			local tileName = string.format("%s_%d", tilesetName, tileIndex)
			local texture = getTexture(tileName)
			if texture then
				local depthTexture = TileDepthTextureManager.getInstance():getTexture(self.editor.modID, tilesetName, tileIndex)
				if depthTexture and not depthTexture:isEmpty() then
					self:drawRect(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, 0.0, 12/255, 123/255)
				end
				local otherTile = TileDepthTextureAssignmentManager.getInstance():getAssignedTileName(self.editor.modID, tileName)
				if otherTile then
					self:drawRect(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, 0.2, 0.2, 0.2)
				end
				self:drawTextureScaled(texture, xIndent + (col - 1) * texW + texture:getOffsetX() * scale, yIndent + (row - 1) * texH + texture:getOffsetY() * scale, texture:getWidth() * scale, texture:getHeight() * scale, 1.0, 1.0, 1.0, 1.0)
				maxRow = math.max(maxRow, row)
			else
				self:drawRect(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, 0.2, 0.0, 0.0)
			end
		end
	end
	
	self:renderGrid(xIndent, yIndent, texW, texH)

	self:setScrollHeight(yIndent + maxRow * texH + yIndent)

	if self:isMouseOver() then
		local col,row = self:getColRowAt(self:getMouseX(), self:getMouseY())
		if self:isValidColRow(col, row) then
			local selection = self.editor.tilePicker.listBox:getSelection()
			self:drawRectBorder(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, 0.5, 0.5, 0.5)
			self:renderTilesToAssign(xIndent, yIndent, texW, texH, col, row)
		end
	end

	if self.mouseDown and self.mouseDownParams then
		local timestampMS = getTimestampMs()
		if timestampMS - self.mouseDownParams.time >= 1000 then
			local col = self.mouseDownParams.col
			local row = self.mouseDownParams.row
			self.mouseDownParams = nil
			self:assignDepthTextures(col, row)
		end
	elseif self.mouseDownParams then
		self.mouseDownParams = nil
	end

	for _,e in ipairs(self.selection.elements) do
		local col = e.col - 1
		local row = e.row - 1
		self:drawRectBorder(xIndent + col * texW, yIndent + row * texH, texW, texH, 0.5, 1, 1, 1)
	end

	self:clearStencilRect()
end

function TileList2:renderGrid(xIndent, yIndent, texW, texH)
	for col=1,8 do
		self:drawRect(xIndent + col * texW, yIndent, 1, ROWS * texH, 1.0, 0.3, 0.3, 0.3)
	end
	for row=1,ROWS do
		self:drawRect(xIndent, yIndent + row * texH, 8 * texW, 1, 1.0, 0.3, 0.3, 0.3)
	end
end

function TileList2:renderTilesToAssign(xIndent, yIndent, texW, texH, col, row)
	local otherPicker = self.editor.tilePicker
	local otherSelection = otherPicker.listBox:getSelection()
	if otherPicker.listBox:isSelectionEmpty() then return end
	local timestampMS = getTimestampMs()
	for _,e in ipairs(otherSelection.elements) do
		if self.mouseDown and self.mouseDownParams then
			if timestampMS - self.mouseDownParams.time < 1000 then
				local f = (timestampMS - self.mouseDownParams.time) / 1000
				self:drawRect(xIndent + (col - 1 + e.col - otherSelection.minCol) * texW,
					yIndent + (row - 1 + e.row - otherSelection.minRow) * texH,
					texW * f, texH, 1.0, 0.0, 1.0, 1.0)
			end
		end
		local texture = getTexture(e.tileName)
		if texture then
			local scale = texW / 128
			self:drawTextureScaled(texture,
				xIndent + (col - 1 + e.col - otherSelection.minCol) * texW + texture:getOffsetX() * scale,
				yIndent + (row - 1 + e.row - otherSelection.minRow) * texH + texture:getOffsetY() * scale,
				texture:getWidth() * scale,
				texture:getHeight() * scale,
				1.0, 1.0, 1.0, 1.0)
		end
		self:drawRectBorder(
			xIndent + (col - 1 + e.col - otherSelection.minCol) * texW,
			yIndent + (row - 1 + e.row - otherSelection.minRow) * texH,
			texW, texH, 1.0, 0.0, 1.0, 1.0)
	end
end

function TileList2:setTileset(tilesetName)
	self.tileset = tilesetName
	self:selectionClear()
end

function TileList2:new(x, y, width, height, picker)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.a = 0.9
	o.picker = picker
	o.editor = picker.editor
	o.selection = {}
	o.selection.elements = {}
	o:calculateSelectionBounds()
	return o
end

