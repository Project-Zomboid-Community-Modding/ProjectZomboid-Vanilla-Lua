--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

SeamEditorUI_TileList = ISPanel:derive("SeamEditorUI_TileList")
local TileList = SeamEditorUI_TileList
local ROWS = 64

-- from ISMoveableSpriteProps.lua
local function lastIndexOf( _string, _needle)
	local i=_string:match(".*".._needle.."()")
	if i==nil then return nil else return i end
end

function TileList:onMouseDown(x, y)
	if not self.tileset then return end
	local col,row = self:getColRowAt(x, y)
	if self:isValidColRow(col, row) then
		if isCtrlKeyDown() then
			self:selectionToggle(col, row)
		elseif isShiftKeyDown() then
			local selectedTile = self:getSingleSelectedTile()
			if selectedTile then
				local colMin = math.min(selectedTile.col, col)
				local colMax = math.max(selectedTile.col, col)
				local rowMin = math.min(selectedTile.row, row)
				local rowMax = math.max(selectedTile.row, row)
				for row1=rowMin,rowMax do
					for col1=colMin,colMax do
						self:selectionAdd(col1, row1)
					end
				end
			else
				self:selectionClear()
				self:selectionAdd(col, row)
			end
		else
			self:selectionClear()
			self:selectionAdd(col, row)
		end
	else
		self:selectionClear()
	end
end

function TileList:onRightMouseUp(x, y)
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
		local master = SeamManager.getInstance():getMasterTileName(self.editor.modID, self.tileset, col - 1, row - 1)
		if master then
			context:addOption("Select Master", self, self.onSelectMaster, master)
			context:addOption("Clear Master", self, self.onClearMaster)
		end
		local selectedTile = self:getSingleSelectedTile()
		if selectedTile then
			context:addOption("Select In Other List", self, self.onSelectInOtherList, selectedTile.tileName)
		end
	end
end

function TileList:onSwapTilesets(tileName)
	local picker1 = self.editor.tilePicker
	local picker2 = self.editor.tilePicker2
	local tileset1 = picker1.listBox.tileset
	local tileset2 = picker2.listBox.tileset
	picker1.comboTileset:select(tileset2)
	picker1.listBox:setTileset(tileset2)
	picker2.comboTileset:select(tileset1)
	picker2.listBox:setTileset(tileset1)
end

function TileList:onSelectMaster(tileName)
	self.picker:selectTileByName(tileName)
end

function TileList:onClearMaster()
	local selection = self:getSelection()
	for _,e in ipairs(selection.elements) do
		SeamManager.getInstance():setTileProperty(self.editor.modID, self.tileset, e.col - 1, e.row - 1, "master", nil)
	end
end

function TileList:onSelectInOtherList(tileName)
	local picker = self.editor.tilePicker2
	picker:selectTileByName(tileName)
end

function TileList:getColRowAt(x, y)
	local xIndent = 0
	local yIndent = 0
	local texW = 32
	local texH = texW * 2
	local col = math.floor((x - xIndent) / texW) + 1
	local row = math.floor((y - yIndent) / texH) + 1
	return col,row
end

function TileList:isValidColRow(col, row)
	return col >= 1 and col <= 8 and row >= 1 and row <= ROWS
end

function TileList:selectionAdd(col, row)
	local selection = self.selection
	local tileIndex = (col - 1) + (row - 1) * 8
	local tileName = string.format("%s_%d", self.tileset, tileIndex)
	table.insert(selection.elements, { col = col, row = row, index = tileIndex, tileName = tileName })
	selection.minCol = math.min(selection.minCol, col)
	selection.minRow = math.min(selection.minRow, row)
	selection.maxCol = math.max(selection.maxCol, col)
	selection.maxRow = math.max(selection.maxRow, row)
end

function TileList:selectionRemove(col, row)
	local selection = self.selection
	local index = self:selectionIndexOf(col, row)
	if index ~= -1 then
		table.remove(selection.elements, index)
		self:calculateSelectionBounds()
	end
end

function TileList:selectionToggle(col, row)
	if self:selectionIndexOf(col, row) == -1 then
		self:selectionAdd(col, row)
	else
		self:selectionRemove(col, row)
	end
end

function TileList:selectionIndexOf(col, row)
	for index,e in ipairs(self.selection.elements) do
		if col == e.col and row == e.row then
			return index
		end
	end
	return -1
end

function TileList:selectionClear()
	table.wipe(self.selection.elements)
	self:calculateSelectionBounds()
end

function TileList:isSelectionEmpty()
	return #self.selection.elements == 0
end

function TileList:getSelection()
	return self.selection
end

function TileList:getSingleSelectedTile()
	if #self.selection.elements == 1 then
		return self.selection.elements[1]
	end
	return nil
end

function TileList:getFirstSelectedTile()
	if #self.selection.elements > 0 then
		return self.selection.elements[1]
	end
	return nil
end

function TileList:calculateSelectionBounds()
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

function TileList:onMouseWheel(del)
	self:setYScroll(self:getYScroll() - del * 64)
end

function TileList:render()
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
				if SeamManager.getInstance():getMasterTileName(self.editor.modID, tilesetName, col - 1, row - 1) then
					self:drawRect(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, 0.0, 0.2, 0.2)
				elseif SeamManager.getInstance():isMasterTile(self.editor.modID, tilesetName, col - 1, row - 1) then
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
--	self.vscroll:setX(self.width - self.vscroll.width)

	if self:isMouseOver() then
		local col,row = self:getColRowAt(self:getMouseX(), self:getMouseY())
		if col >= 0 and col <= 8 and row >= 0 then
			col = col - 1
			row = row - 1
			self:drawRectBorder(xIndent + col * texW, yIndent + row * texH, texW, texH, 1.0, 0.5, 0.5, 0.5)
		end
	end

	for _,e in ipairs(self.selection.elements) do
		local col = e.col - 1
		local row = e.row - 1
		self:drawRectBorder(xIndent + col * texW, yIndent + row * texH, texW, texH, 0.5, 1, 1, 1)
	end

	self:clearStencilRect()
end

function TileList:renderGrid(xIndent, yIndent, texW, texH)
	for col=1,8 do
		self:drawRect(xIndent + col * texW, yIndent, 1, ROWS * texH, 1.0, 0.3, 0.3, 0.3)
	end
	for row=1,ROWS do
		self:drawRect(xIndent, yIndent + row * texH, 8 * texW, 1, 1.0, 0.3, 0.3, 0.3)
	end
end

function TileList:setTileset(tilesetName)
	self.tileset = tilesetName
	self:selectionClear()
end

function TileList:new(x, y, width, height, picker)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.a = 0.9
	o.picker = picker
	o.editor = picker.editor
	o.selection = {}
	o.selection.elements = {}
	o:calculateSelectionBounds()
	return o
end

