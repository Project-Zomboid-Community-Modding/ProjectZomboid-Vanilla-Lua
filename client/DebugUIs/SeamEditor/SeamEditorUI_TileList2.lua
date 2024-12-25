--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

SeamEditorUI_TileList2 = ISPanel:derive("SeamEditorUI_TileList2")
local TileList2 = SeamEditorUI_TileList2
local ROWS = 64

function TileList2:onMouseDown(x, y)
	if not self.tileset then return end
	self.mouseDown = true
	local col,row = self:getColRowAt(x, y)
	self.mouseDownParams = {}
	if self:isValidColRow(col, row) then
		if self:getTextureAt(col, row) ~= nil then
			self.mouseDownParams.time = getTimestampMs()
			self.mouseDownParams.col = col
			self.mouseDownParams.row = row
			self.mouseDownParams.pressX = x
			self.mouseDownParams.pressY = y
			self.mouseDownParams.dragStarted = false
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
	local tileName = self:getDraggedTileName()
	self.mouseDown = false
	if tileName then
		local worldX,worldY = self.editor.scene:uiToWorld(getMouseX(), getMouseY(), 0)
		if worldX >= 1 and worldX < 2 and worldY >= 0 and worldY < 1 then
			self.editor:assignEastTile(tileName)
		end
		if worldX >= 0 and worldX < 1 and worldY >= 1 and worldY < 2 then
			self.editor:assignSouthTile(tileName)
		end
		worldX,worldY = self.editor.scene:uiToWorld(getMouseX(), getMouseY(), -1)
		if worldX >= 1 and worldX < 2 and worldY >= 0 and worldY < 1 then
			self.editor:assignBelowEastTile(tileName)
		end
		if worldX >= 0 and worldX < 1 and worldY >= 1 and worldY < 2 then
			self.editor:assignBelowSouthTile(tileName)
		end
	end
end

function TileList2:onMouseUpOutside(x, y)
	return self:onMouseUp(x, y)
end

function TileList2:onMouseMove(dx, dy)
	if self.mouseDown and self.mouseDownParams and self.mouseDownParams.pressX then
		if not self.mouseDownParams.dragStarted then
			dx = self:getMouseX() - self.mouseDownParams.pressX
			dy = self:getMouseY() - self.mouseDownParams.pressY
			if math.abs(dx) > 4 or math.abs(dy) > 4 then
				self.mouseDownParams.dragStarted = true
			end
		end
	end
end

function TileList2:onMouseMoveOutside(dx, dy)
	return self:onMouseMove(dx, dy)
end

function TileList2:getDraggedTileName()
	if (not self.mouseDown) or (self.mouseDownParams == nil) or (not self.mouseDownParams.dragStarted) then return nil end
	return self:getTextureNameAt(self.mouseDownParams.col, self.mouseDownParams.row)
end

function TileList2:renderDraggedTile()
	local tileName = self:getDraggedTileName()
	if not tileName then return end
	local texture = self:getTextureAt(self.mouseDownParams.col, self.mouseDownParams.row)
	if not texture then return end
	local mx,my = getMouseX(),getMouseY()
	local tileW,tileH = 128,256
	local scale = tileW / 128
	local left = mx - tileW / 2
	local top = my - tileH / 2
	self.editor.scene:drawRectBorder(left, top, tileW, tileH, 1.0, 1.0, 1.0, 1.0)
	self.editor.scene:drawTextureScaled(texture,
		left + texture:getOffsetX() * scale,
		top + texture:getOffsetY() * scale,
		texture:getWidth() * scale, texture:getHeight() * scale,
		1.0, 1.0, 1.0, 1.0)
end

function TileList2:onRightMouseUp(x, y)
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
		local selectedTile = self:getSingleSelectedTile()
		if selectedTile then
			local master = SeamManager.getInstance():getMasterTileName(self.editor.modID, self.tileset, selectedTile.col - 1, selectedTile.row - 1)
			if master then
				context:addOption("Select Master", self, self.onSelectInOtherList, master)
			end
			context:addOption("Select In Other List", self, self.onSelectInOtherList, selectedTile.tileName)
		end
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
	local picker = self.editor.tilePicker
	picker:selectTileByName(tileName)
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

function TileList2:getTextureNameAt(col, row)
	local tileIndex = (col - 1) + (row - 1) * 8
	return string.format("%s_%d", self.tileset, tileIndex)
end

function TileList2:getTextureAt(col, row)
	return getTexture(self:getTextureNameAt(col, row))
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

	local tilesetName,tileIndex = self.editor.scene:getSelectedTile() -- not this TileList
	local tileNames = nil
	if tilesetName then
		if self.editor.currentSeamTile == "east" then
			tileNames = SeamManager.getInstance():getTileJoinE(self.editor.modID, tilesetName, tileIndex % 8, tileIndex / 8, false)
		elseif self.editor.currentSeamTile == "south" then
			tileNames = SeamManager.getInstance():getTileJoinS(self.editor.modID, tilesetName, tileIndex % 8, tileIndex / 8, false)
		elseif self.editor.currentSeamTile == "belowEast" then
			tileNames = SeamManager.getInstance():getTileJoinBelowE(self.editor.modID, tilesetName, tileIndex % 8, tileIndex / 8, false)
		elseif self.editor.currentSeamTile == "belowSouth" then
			tileNames = SeamManager.getInstance():getTileJoinBelowS(self.editor.modID, tilesetName, tileIndex % 8, tileIndex / 8, false)
		end
	end

	local maxRow = 1
	local tilesetName = self.tileset
	local scale = texW / 128
	for row=1,ROWS do
		for col=1,8 do
			local texture = self:getTextureAt(col, row)
			if texture then
				if SeamManager.getInstance():getMasterTileName(self.editor.modID, tilesetName, col - 1, row - 1) then
					self:drawRect(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, 0.0, 0.2, 0.2)
--                if tileNames ~= nil and tileNames:contains(texture:getName()) then
--				    self:drawRect(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, 0.2, 0.2, 0.2)
				end
				self:drawTextureScaled(texture,
					xIndent + (col - 1) * texW + texture:getOffsetX() * scale,
					yIndent + (row - 1) * texH + texture:getOffsetY() * scale,
					texture:getWidth() * scale, texture:getHeight() * scale,
					1.0, 1.0, 1.0, 1.0)
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
		if self.mouseDown and self.mouseDownParams then
			local timestampMS = getTimestampMs()
			if timestampMS - self.mouseDownParams.time >= 1000 then
				local col = self.mouseDownParams.col
				local row = self.mouseDownParams.row
				self.mouseDownParams = nil
				self:assignMasterSprites(col, row)
			end
		end
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

function TileList2:assignMasterSprites(col, row)
	local selection = self.editor.tilePicker.listBox:getSelection()
	local tilesetOther = self.editor.tilePicker.listBox.tileset
	for _,e in ipairs(selection.elements) do
		local colSelf = (col - 1 + e.col - selection.minCol)
		local rowSelf = (row - 1 + e.row - selection.minRow)
		local tileIndex = colSelf + rowSelf * 8
		local tileName = string.format("%s_%d", self.tileset, tileIndex)
		if not SeamManager.getInstance():isMasterTile(self.editor.modID, self.tileset, colSelf, rowSelf) then
			-- The selected tile in TileList #1 could have it's own seam data, or a master sprite
			local otherTile = e.tileName
			local master = SeamManager.getInstance():getMasterTileName(self.editor.modID, tilesetOther, e.col - 1, e.row - 1)
			if master then
				otherTile = master
			end
			SeamManager.getInstance():setTileProperty(self.editor.modID, self.tileset, colSelf, rowSelf, "master", otherTile)
		end
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

