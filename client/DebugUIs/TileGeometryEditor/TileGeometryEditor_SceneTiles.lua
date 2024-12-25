--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

-- This class manages additional tiles (not the one being edited) displayed in the editor.

require "ISBaseObject"

TileGeometryEditor_SceneTiles = ISBaseObject:derive("TileGeometryEditor_SceneTiles")
local SceneTiles = TileGeometryEditor_SceneTiles

function SceneTiles:index(dx, dy)
	return dx + dy * 100
end

function SceneTiles:addTile(dx, dy, tileName)
	local tile = {}
	tile.dx = dx
	tile.dy = dy
	tile.tileName = tileName
	self.tiles[self:index(dx, dy)] = tile
end

function SceneTiles:removeTile(dx, dy)
	self.tiles[self:index(dx, dy)] = nil
end

function SceneTiles:getTile(dx, dy)
	return self.tiles[self:index(dx, dy)]
end

function SceneTiles:render()
	for dy=-5,5 do
		for dx=-5,5 do
			local tile = self:getTile(dx, dy)
			if tile then
				self:renderTile(tile.dx, tile.dy, tile.tileName)
			end
		end
	end
end

function SceneTiles:renderTile(dx, dy, tileName)
	local texture = getTexture(tileName)
	if not texture then return end
	local dz = 0
	local sx,sy,sx2,sy2,pixelSize = self.scene:getTileBounds2(dx, dy, dz)
	self.scene:drawTextureScaled(texture,
		sx + texture:getOffsetX() * pixelSize,
		sy + texture:getOffsetY() * pixelSize,
		texture:getWidth() * pixelSize,
		texture:getHeight() * pixelSize,
		1.0, 1.0, 1.0, 1.0)
end

function SceneTiles:renderBox3D(tx, ty, tz, rx, ry, rz, minX, minY, minZ, maxX, maxY, maxZ, r, g, b)
	---
	self.tempTranslate = self.tempTranslate or Vector3f.new()
	self.tempRotate = self.tempRotate or Vector3f.new()
	self.tempExtentsMin = self.tempExtentsMin or Vector3f.new()
	self.tempExtentsMax = self.tempExtentsMax or Vector3f.new()
	---
	self.tempTranslate:set(tx, ty, tz)
	self.tempRotate:set(rx, ry, rz)
	self.tempExtentsMin:set(minX, minY, minZ)
	self.tempExtentsMax:set(maxX, maxY, maxZ)
	self.scene:java7("addBox3D",
		self.tempTranslate,
		self.tempRotate,
		self.tempExtentsMin,
		self.tempExtentsMax,
		r, g, b)
end

function SceneTiles:uiToTileLocation(x, y)
	self.vector3f_1 = self.vector3f_1 or Vector3f.new()
	local scenePos = self.javaObject:uiToScene(x, y, 0, self.vector3f_1)
	scenePos:setComponent(0, Math.round(scenePos:x()))
	scenePos:setComponent(2, Math.round(scenePos:z()))
	return scenePos
end

function SceneTiles:new(editor)
	local o = ISBaseObject.new(self)
	o.editor = editor
	o.scene = editor.scene
	o.javaObject = editor.scene.javaObject
	o.tiles = {}
	return o
end

