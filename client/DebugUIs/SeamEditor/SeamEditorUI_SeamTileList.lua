--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

SeamEditorUI_SeamTileList = ISPanel:derive("SeamEditorUI_SeamTileList")
local SeamTileList = SeamEditorUI_SeamTileList

function SeamTileList:render()
	ISPanel.render(self)

	local tiles = self:getTileNameList()
	if not tiles then
		return
	end

	local stencilX = 1
	local stencilY = 1
	local stencilX2 = self.width - 2
	local stencilY2 = self.height - 2
	self:setStencilRect(stencilX, stencilY, stencilX2 - stencilX, stencilY2 - stencilY)

	local xIndent = 0
	local yIndent = 0
	local texW = 32
	local texH = texW * 2
	local scale = texW / 128
	local maxRow = 1
	local col = 1

    local mouseOverRow = self:isMouseOver() and self:getRowAt(self:getMouseX(), self:getMouseY()) or -1

	for row=1,tiles:size() do
		local texture = getTexture(tiles:get(row-1))
		if texture then
			if mouseOverRow + 1 == row then
				local color = self.backgroundColor
				self:drawRect(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, color.r * 1.1, color.g * 1.1, color.b * 1.1)
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
	if tiles:isEmpty() == false then
		for row=1,maxRow do
			self:drawRect(xIndent, yIndent + row * texH, 8 * texW, 1, 1.0, 0.1, 0.1, 0.1)
		end
	end

	self:setScrollHeight(yIndent + maxRow * texH + yIndent)

	self:clearStencilRect()
end

function SeamTileList:onMouseDown(x, y)
	self.editor.currentSeamTile = self.seamTile
end

function SeamTileList:onRightMouseUp(x, y)
	local tiles = self:getTileNameList()
	if not tiles or tiles:isEmpty() then return end
	local row = self:getRowAt(self:getMouseX(), self:getMouseY())
	if row < 0 or row >= tiles:size() then return end
	local tileName = tiles:get(row)
	local player = 0
	local context = ISContextMenu.get(player, self:getAbsoluteX() + x, self:getAbsoluteY() + y + self:getYScroll())
	context:removeFromUIManager()
	context:addToUIManager()
	context:addOption("Remove Tile", self, self.onRemoveTile, tiles, row)
end

function SeamTileList:onRemoveTile(tiles, index)
	javaListRemoveAt(tiles, index)
end

function SeamTileList:renderMouseOverTile()
	if not self:isMouseOver() then return end
	local tiles = self:getTileNameList()
	if not tiles or tiles:isEmpty() then return end
	local row = self:getRowAt(self:getMouseX(), self:getMouseY())
	if row < 0 or row >= tiles:size() then return end
	local tileName = tiles:get(row)
	local texture = getTexture(tileName)
	if not texture then return end
	if self.seamTile == "east" then
		self.editor.scene:renderTileAt(texture, 1, 0, 0)
	end
	if self.seamTile == "south" then
		self.editor.scene:renderTileAt(texture, 0, 1, 0)
	end
	if self.seamTile == "belowEast" then
		self.editor.scene:renderTileAt(texture, 1, 0, -1)
	end
	if self.seamTile == "belowSouth" then
		self.editor.scene:renderTileAt(texture, 0, 1, -1)
	end
end

function SeamTileList:getRowAt(x, y)
	local texW = 32
	local texH = texW * 2
	return math.floor(y / texH)
end

function SeamTileList:getTileNameList()
	local tilesetName,tileIndex = self.editor.scene:getSelectedTile()
	if not tilesetName then return end
	local tiles = nil
	if self.seamTile == "east" then
		return SeamManager.getInstance():getTileJoinE(self.editor.modID, tilesetName, tileIndex % 8, tileIndex / 8, false)
	end
	if self.seamTile == "south" then
		return SeamManager.getInstance():getTileJoinS(self.editor.modID, tilesetName, tileIndex % 8, tileIndex / 8, false)
	end
	if self.seamTile == "belowEast" then
		return SeamManager.getInstance():getTileJoinBelowE(self.editor.modID, tilesetName, tileIndex % 8, tileIndex / 8, false)
	end
	if self.seamTile == "belowSouth" then
		return SeamManager.getInstance():getTileJoinBelowS(self.editor.modID, tilesetName, tileIndex % 8, tileIndex / 8, false)
	end
	return nil
end

function SeamTileList:new(x, y, width, height, editor, seamTile)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.r = 0.33
	o.backgroundColor.g = 0.33
	o.backgroundColor.b = 0.33
	o.editor = editor
	o.selection = nil
	o.seamTile = seamTile -- east | south | belowEast | belowSouth
	return o
end

