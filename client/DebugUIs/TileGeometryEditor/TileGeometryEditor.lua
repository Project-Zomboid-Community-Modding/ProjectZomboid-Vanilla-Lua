--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISScrollingListBox"
require "Vehicles/ISUI/ISUI3DScene"
require "DebugUIs/TileGeometryEditor/TileGeometryEditor_EditMode"
require "DebugUIs/TileGeometryEditor/TileGeometryEditor_SceneTiles"
require "DebugUIs/TileGeometryEditor/TileGeometryEditor_Tools"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local Z_SCALE = 0.8164966666666666
local TEXTURE_OFFSET_X = 1
local ONE_STAIRCASE_STEP = Z_SCALE * 3 / 12 -- 0.20412416666666666

TileGeometryEditor = ISPanel:derive("TileGeometryEditor")

-----

TileGeometryEditor_SwitchView = ISUI3DScene:derive("TileGeometryEditor_SwitchView")
local SwitchView = TileGeometryEditor_SwitchView

function SwitchView:prerender()
	if self:isMouseOver() or (self:getView() == self.editor.scene:getView()) then
		self.borderColor.r = 0.8
		self.borderColor.g = 0.8
		self.borderColor.b = 0.8
	else
		self.borderColor.r = 0.4
		self.borderColor.g = 0.4
		self.borderColor.b = 0.4
	end
	ISUI3DScene.prerender(self)
end

function SwitchView:onMouseDown(x, y)
	self.editor.prevView = self:getView()
	self.editor.scene:setView(self:getView())
end

function SwitchView:onMouseMove(dx, dy)
	if self.editor.mouseOverView ~= self then
		if self.editor.mouseOverView then
			self.editor.mouseOverView:onMouseMoveOutside(-1, -1)
		end
		self.editor.mouseOverView = self
		self.editor.prevView = self.editor.scene:getView()
		self.editor.scene:setView(self:getView())
	end
end

function SwitchView:onMouseMoveOutside(dx, dy)
	if self.editor.mouseOverView == self then
		self.editor.mouseOverView = nil
		self.editor.scene:setView(self.editor.prevView)
		self.editor.prevView = nil
	end
end

function SwitchView:onMouseWheel(del)
	return true
end

function SwitchView:new(editor, x, y, width, height)
	local o = ISUI3DScene.new(self, x, y, width, height)
	o.editor = editor
	return o
end

-----

TileGeometryEditor_OptionsPanel = ISPanel:derive("TileGeometryEditor_OptionsPanel")
local OptionsPanel = TileGeometryEditor_OptionsPanel

function OptionsPanel:createChildren()
	local tickBox = ISTickBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, "", self, self.onTickBox)
	tickBox:initialise()
	self:addChild(tickBox)
	local gameState = getTileGeometryState()
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

TileGeometryEditor_Scene = ISUI3DScene:derive("TileGeometryEditor_Scene")
local Scene = TileGeometryEditor_Scene

function Scene:prerenderEditor()
	self:java1("setGizmoVisible", self.editPoints and "none" or self.gizmo)
	self:java1("setGizmoOrigin", "none")
	self:java1("setTransformMode", "Local")
	self.tools.gizmo.translate.snapFunc = nil
	if not self.zeroVector then self.zeroVector = Vector3f.new() end
	self:java1("setGizmoPos", self.zeroVector)
	self:java1("setGizmoRotate", self.zeroVector)
	self:java1("setRotateGizmoSnap", false)
	self:java1("setScaleGizmoSnap", false)
	self:java0("clearAABBs")
	self:java0("clearAxes")
	self:java0("clearBox3Ds")
	self:java2("setGizmoAxisVisible", "X", true)
	self:java2("setGizmoAxisVisible", "Y", true)
	self:java2("setGizmoAxisVisible", "Z", true)
--	self.javaObject:fromLua1("setSelectedAttachment", nil)
--[[
	if self:isPolygonObject(self.selectedObjectName) then
		local gridPlane = self:java1("getPolygonPlane", self.selectedObjectName)
		if gridPlane == "XY" then
			self:java2("setGizmoAxisVisible", "X", false)
			self:java2("setGizmoAxisVisible", "Y", false)
		end
		if gridPlane == "XZ" then
			self:java2("setGizmoAxisVisible", "X", false)
			self:java2("setGizmoAxisVisible", "Z", false)
		end
		if gridPlane == "YZ" then
			self:java2("setGizmoAxisVisible", "Y", false)
			self:java2("setGizmoAxisVisible", "Z", false)
		end
	end
--]]
	self:java2("setObjectVisible", "depthTexture", false)
end

function Scene:prerender()
	ISUI3DScene.prerender(self)
end

function Scene:render()
	ISUI3DScene.render(self)
	self:renderSurfaceOffset()
	self:renderTileName()
	local picker = self.editor.tilePicker.listBox
	local selectedTile = picker:getSingleSelectedTile()
	if not selectedTile then
		if self.selectedTileName ~= nil then
			self.selectedTileName = nil
			self:removeAllGeometryObjects()
			self.editor:setGeometryList()
		end
		return
	end
	local tileIndex = selectedTile.index
	local tileName = selectedTile.tileName
	local texture = getTexture(tileName)
	if not texture then
		if self.selectedTileName ~= nil then
			self.selectedTileName = nil
			self:removeAllGeometryObjects()
			self.editor:setGeometryList()
		end
		return
	end

	local picker = self.editor.tilePicker.listBox
	if picker.tileset then
		local mgr = TileDepthTextureManager.getInstance()
		mgr:loadTilesetPixelsIfNeeded(self.editor.modID, picker.tileset)
	end

	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	if self:isViewUserDefined() then
		self.editor.editMode.current:renderSceneTiles()
		self:renderUnderlyingTile(tileName)
		self:renderSelectedTile(tileName, texture)
		self:renderPixelGrid(tileName)
		self:renderTextureMask(sx, sy, sx2, sy2, pixelSize, texture)
		self:renderSpriteGridTextureMask(sx, sy, sx2, sy2, pixelSize, tileName)
		self:renderTextureOutline(sx, sy, sx2, sy2, pixelSize, texture)
	end

	if self.currentTool then
		self.currentTool:renderScene()
	end

	if self:isViewUserDefined() then
		-- Bounding box around the tile
		local tileX = sx
		local tileY = sy
		self:drawRectBorder(tileX, tileY, 128 * pixelSize, 256 * pixelSize, 1.0, 1.0, 1.0, 1.0)

		if self:java1("getGeometryType", self.selectedObjectName) ~= nil then
			local x,y = self:getMouseX(),self:getMouseY()
			local pixelX = math.floor((x - tileX) / pixelSize + TEXTURE_OFFSET_X) -- 0 - 128
			local pixelY = math.floor((y - tileY) / pixelSize) -- 0 - 256
			local depth = self:java3("getGeometryDepthAt", self.selectedObjectName, pixelX + 0.5, pixelY + 0.5)
			local depth2 = self:java3("getGeometryDepthAt", self.selectedObjectName, (x - tileX) / pixelSize + TEXTURE_OFFSET_X, (y - tileY) / pixelSize)
			-- math.floor() should match TileDepthTexture.setBufferedImage()
			self:drawText(string.format("%d,%d, %.4f / %.4f / %d", pixelX, pixelY, depth, depth2, math.floor(depth * 255)), x, y + 24, 0, 0, 0, 1, UIFont.Small)
		end
	end

	if self.editor.editMode.current == self.editor.editMode.geometry then
		self:renderNorthWall()
		self:renderWestWall()
		self:renderSquareBox()
		self:renderSolidSquareBox()
	end

	if tileName ~= self.selectedTileName then
		self.selectedTileName = tileName
		self:removeAllGeometryObjects()
		self:java4("loadFromGeometryFile", self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1)
		self.editor:setGeometryList()
	end

	if self:isViewUserDefined() then
		local depthTexture = TileDepthTextureManager.getInstance():getTexture(self.editor.modID, picker.tileset, tileIndex)
		local otherTile = TileDepthTextureAssignmentManager.getInstance():getAssignedTileName(self.editor.modID, tileName)
		if otherTile then
			depthTexture = TileDepthTextureManager.getInstance():getTextureFromTileName(self.editor.modID, otherTile)
		end
		if depthTexture then
			if depthTexture:fileExists() then
				local texture = depthTexture:getTexture()
				self:java1("getObjectTranslation", "depthTexture"):setComponent(0.0, 0.0)
				self:java2("configDepthTexture", "depthTexture", texture)
				self:java2("setObjectVisible", "depthTexture", true)
			end
		end
	end
	
	if not self.editPoints and self.gizmo ~= nil and
			self.parent.editMode.geometry.boxPanel.movingFace == nil and
			self.parent.editMode.geometry.cylinderPanel.movingFace == nil then
		if self:java1("getGeometryType", self.selectedObjectName) ~= nil then
			local translate = self:java1("getObjectTranslation", self.selectedObjectName)
			local rotate = self:java1("getObjectRotation", self.selectedObjectName)
			self:java6("addAxis", translate:x(), translate:y(), translate:z(),
				rotate:x(), rotate:y(), rotate:z())
		end
	end
end

function Scene:isViewUserDefined()
	return self:java0("getView") == "UserDefined"
end

function Scene:renderSelectedTile(tileName, texture)
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	local gameState = getTileGeometryState()
	if gameState:getBoolean("DrawSpriteGrid") then
		local sprite = getSprite(tileName)
		if not sprite then return end
		local spriteGrid = sprite:getSpriteGrid()
		if spriteGrid then
			local gridPosX = spriteGrid:getSpriteGridPosX(sprite)
			local gridPosY = spriteGrid:getSpriteGridPosY(sprite)
			local gridPosZ = spriteGrid:getSpriteGridPosZ(sprite)
			for gz=1,spriteGrid:getLevels() do
                for gy=1,spriteGrid:getHeight() do
                    for gx=1,spriteGrid:getWidth() do
                        local sprite2 = spriteGrid:getSprite(gx - 1, gy - 1, gz - 1)
                        if sprite2 ~= nil then
                            self:renderSpriteGridTile(sprite2, gx-1-gridPosX, gy-1-gridPosY, gz-1-gridPosZ)
                        end
                    end
                end
            end
			return
		end
	end
---[[
	self:drawTextureScaled(texture,
		sx + texture:getOffsetX() * pixelSize,
		sy + texture:getOffsetY() * pixelSize,
		texture:getWidth() * pixelSize,
		texture:getHeight() * pixelSize,
		1.0, 1.0, 1.0, 1.0)
--]]
end

function Scene:renderSpriteGridTile(sprite, dx, dy, dz)
	local sx,sy,sx2,sy2,pixelSize = self:getTileBounds2(dx, dy, dz)
	local texture = getTexture(sprite:getName())
	if not texture then return end
	self:drawTextureScaled(texture,
		sx + texture:getOffsetX() * pixelSize,
		sy + texture:getOffsetY() * pixelSize,
		texture:getWidth() * pixelSize,
		texture:getHeight() * pixelSize,
		1.0, 1.0, 1.0, 1.0)
--	self:drawRectBorder(sx, sy, 128 * pixelSize, 256 * pixelSize, 1.0, 1.0, 1.0, 1.0)
end

-- If this is an overlay sprite, render one of the underlying sprites.
function Scene:renderUnderlyingTile(overlayName)
	local gameState = getTileGeometryState()
	if not gameState:getBoolean("DrawUnderlyingSprite") then return end
	local spriteNames = TileOverlays.instance:getUnderlyingSpriteNames(overlayName)
	if not spriteNames then
		spriteNames = ContainerOverlays.instance:getUnderlyingSpriteNames(overlayName)
	end
	if not spriteNames then return end
	local texture = getTexture(spriteNames:get(0))
	if not texture then return end
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	self:drawTextureScaled(texture,
		sx + texture:getOffsetX() * pixelSize,
		sy + texture:getOffsetY() * pixelSize,
		texture:getWidth() * pixelSize,
		texture:getHeight() * pixelSize,
		1.0, 1.0, 1.0, 1.0)
end

function Scene:renderSurfaceOffset()
	if not self.editor.editMode.geometry.propertiesPanel:shouldShowInScene() then return end
	local picker = self.editor.tilePicker.listBox
	local selectedTile = picker:getFirstSelectedTile()
	if not selectedTile then return end
	local tileName = selectedTile.tileName
	local sprite = getSprite(tileName)
	if not sprite then return end
	local props = sprite:getProperties()
--	if not props:isTable() then return end
	local ItemHeight = props:getItemHeight()
	local Surface = props:getSurface()
	if props:isSurfaceOffset() then
		self:renderSurfaceOffsetAux(Surface, 0.0, 1.0, 0.0)
		self:renderSurfaceOffsetAux(Surface + ItemHeight, 0.0, 1.0, 0.0)
	else
		-- Surface should be zero, but some use ItemHeight/Surface interchangeably
		self:renderSurfaceOffsetAux(Surface + ItemHeight, 0.0, 1.0, 0.0)
	end
end

function Scene:renderSurfaceOffsetAux(value, r, g, b)
	self:renderBox3D(0.0, (value * Core.getTileScale() / 96) / Z_SCALE, 0.0,
		90.0, 0.0, 0.0,
		-0.5, -0.5, 0.0,
		0.5, 0.5, 0.0,
		r, g, b)
end

function Scene:renderBox3D(tx, ty, tz, rx, ry, rz, minX, minY, minZ, maxX, maxY, maxZ, r, g, b)
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
	self:java7("addBox3D",
		self.tempTranslate,
		self.tempRotate,
		self.tempExtentsMin,
		self.tempExtentsMax,
		r, g, b)
end

function Scene:renderSolidBox3D(tx, ty, tz, rx, ry, rz, minX, minY, minZ, maxX, maxY, maxZ, r, g, b, a)
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
	self:java9("addBox3D",
		self.tempTranslate,
		self.tempRotate,
		self.tempExtentsMin,
		self.tempExtentsMax,
		r, g, b, a,
		true)
end

function Scene:renderTileName()
	self.editor.editMode.current:renderTileName()
end

function Scene:removeAllGeometryObjects()
	local objects = self:java0("getObjectNames")
	for i=1,objects:size() do
		local objectName = objects:get(i-1)
		if self:java1("getGeometryType", objectName) ~= nil then
			self:java1("removeObject", objectName)
		end
	end
end

function Scene:onMouseDown(x, y)
	ISUI3DScene.onMouseDown(self, x, y)
	if self.currentTool then
		self.currentTool:onMouseDown(x, y)
		return
	end
	self.mouseAction = nil
	if self.editor.editMode.current:onMouseDownScene(x, y) then
		return
	end
end

function Scene:onMouseMove(dx, dy)
	if self.currentTool then
		self.currentTool:onMouseMove(dx, dy)
		return
	end
	if isKeyDown(Keyboard.KEY_SPACE) then
		self.javaObject:fromLua2("dragView", dx, dy)
		return
	end
	ISUI3DScene.onMouseMove(self, dx, dy)
end

function Scene:onMouseUp(x, y)
	ISUI3DScene.onMouseUp(self, x, y)
	if self.currentTool then
		self.currentTool:onMouseUp(x, y)
		return
	end
	if self.mouseAction == "depth" then
	end
	self.dragPointIndex = -1
	self.mouseAction = nil
end

function Scene:onMouseUpOutside(x, y)
	self:onMouseUp(x, y)
end

function Scene:onRightMouseDown(x, y)
	if self.currentTool then
		self.currentTool:onRightMouseDown(x, y)
		return
	end
end

function Scene:getTileBoundsEtc()
	local sx = self.javaObject:sceneToUIX(0.0, 0.0, 0.0)
	local sy = self.javaObject:sceneToUIY(0.0, 0.0, 0.0)
	local sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
	local sy2 = self.javaObject:sceneToUIY(1.0, 0.0, 0.0)
	local pixelSize = math.sqrt((sx2 - sx) * (sx2 - sx) + (sy2 - sy) * (sy2 - sy)) / math.sqrt(32 * 32 + 64 * 64)
	local tileX1 = sx - (128 / 2) * pixelSize
	local tileY1 = sy - (256 - 32) * pixelSize
	local tileX2 = tileX1 + 128 * pixelSize
	local tileY2 = tileY1 + 256 * pixelSize
	tileX1 = tileX1 + TEXTURE_OFFSET_X * pixelSize
	tileX2 = tileX2 + TEXTURE_OFFSET_X * pixelSize
	return tileX1,tileY1,tileX2,tileY2,pixelSize
end

function Scene:getTileBounds2(dx, dy, dz)
	local sx = self.javaObject:sceneToUIX(dx, dz * 3 * Z_SCALE, dy)
	local sy = self.javaObject:sceneToUIY(dx, dz * 3 * Z_SCALE, dy)
	local sx2 = self.javaObject:sceneToUIX(dx + 1, dz * 3 * Z_SCALE, dy)
	local sy2 = self.javaObject:sceneToUIY(dx + 1, dz * 3 * Z_SCALE, dy)
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
	if not getTileGeometryState():getBoolean("DrawPixelGrid") then return end
	local sx,sy,sx2,sy2,pixelSize = self:getTileBoundsEtc()
	if pixelSize < 5 then return end
	local texture = getTexture(tileName)
	local mask = texture and texture:getMask() or nil
	local gameState = getTileGeometryState()
	if gameState:getBoolean("DrawSpriteGrid") then
		local sprite = getSprite(tileName)
		if not sprite then
			self:renderPixelGrid2(sx, sy, sx2, sy2, pixelSize, texture, mask)
			return
		end
		local spriteGrid = sprite:getSpriteGrid()
		if not spriteGrid then
			self:renderPixelGrid2(sx, sy, sx2, sy2, pixelSize, texture, mask)
			return
		end
		local gridWidth = spriteGrid:getWidth()
		local gridHeight = spriteGrid:getHeight()
		local gridPosX = spriteGrid:getSpriteGridPosX(sprite)
		local gridPosY = spriteGrid:getSpriteGridPosY(sprite)
		local gridPosZ = spriteGrid:getSpriteGridPosZ(sprite)
		local minX = 100000
		local minY = 100000
		local maxX = -100000
		local maxY = -100000
		for gz=1,spriteGrid:getLevels() do
			for gy=1,spriteGrid:getHeight() do
				for gx=1,spriteGrid:getWidth() do
					sx,sy,sx2,sy2,pixelSize = self:getTileBounds2(gx-1-gridPosX, gy-1-gridPosY, gz-1-gridPosZ)
					minX = math.min(minX, sx)
					minY = math.min(minY, sy)
					maxX = math.max(maxX, sx2)
					maxY = math.max(maxY, sy2)
				end
			end
		end
		local x2 = math.ceil((maxX - minX) / pixelSize - 0.1) - 1
		for x=1,x2 do
			self:drawRect(minX + x * pixelSize, minY, 1, maxY - minY, 0.5, 0, 162/255, 232/255)
		end
		local y2 = math.ceil((maxY - minY) / pixelSize - 0.1) - 1
		for y=1,y2 do
			self:drawRect(minX, minY + y * pixelSize, maxX - minX, 1, 0.5, 0, 162/255, 232/255)
		end
		self:drawRectBorder(minX, minY, maxX - minX, maxY - minY, 0.5, 1.0, 1.0, 1.0)
		return
	end
	self:renderPixelGrid2(sx, sy, sx2, sy2, pixelSize)
end

function Scene:renderPixelGrid2(sx, sy, sx2, sy2, pixelSize)
	for x=1,127 do
		self:drawRect(sx + x * pixelSize, sy, 1, sy2 - sy, 0.5, 0, 162/255, 232/255)
	end
	for y=1,255 do
		self:drawRect(sx, sy + y * pixelSize, sx2 - sx, 1, 0.5, 0, 162/255, 232/255)
	end
end

function Scene:renderNorthWall()
	if not getTileGeometryState():getBoolean("DrawNorthWall") then return end
	local r,g,b = 1,1,1
	self:renderBox3D(
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		-0.5, 0.0, -0.5,
		0.5, 3.0 * Z_SCALE, -0.5 + 0.0311 * 1.5,
		r, g, b)
end

function Scene:renderWestWall()
	if not getTileGeometryState():getBoolean("DrawWestWall") then return end
	local r,g,b = 1,1,1
	self:renderBox3D(
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		-0.5, 0.0, -0.5,
		-0.5 + 0.0311 * 1.5, 3.0 * Z_SCALE, 0.5,
		r, g, b)
end

function Scene:renderSquareBox()
	if not getTileGeometryState():getBoolean("DrawSquareBox") then return end
	local r,g,b = 1,1,1
	self:renderBox3D(
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		-0.5, 0.0, -0.5,
		0.5, 3.0 * Z_SCALE, 0.5,
		r, g, b)
end

function Scene:renderSolidSquareBox()
	if not getTileGeometryState():getBoolean("DrawSolidSquareBox") then return end
	local r,g,b = 1,1,1
	self:renderSolidBox3D(
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		-0.5, 0.0, -0.5,
		0.5, 3.0 * Z_SCALE, 0.5,
		r, g, b, 0.9)
end

function Scene:renderTextureOutline(sx, sy, sx2, sy2, pixelSize, texture)
	if not getTileGeometryState():getBoolean("DrawTextureOutline") then return end
	self:drawRectBorder(sx + texture:getOffsetX() * pixelSize,
		sy + texture:getOffsetY() * pixelSize,
		texture:getWidth() * pixelSize,
		texture:getHeight() * pixelSize,
		1, 0, 162 / 255, 232 / 255)
end

function Scene:renderTextureMask(sx, sy, sx2, sy2, pixelSize, texture)
	if not getTileGeometryState():getBoolean("DrawTextureMask") then return end
	self:java6("renderTextureMask", sx, sy, sx2, sy2, pixelSize, texture)
end

function Scene:renderSpriteGridTextureMask(sx, sy, sx2, sy2, pixelSize, tileName)
	if not getTileGeometryState():getBoolean("DrawSpriteGridTextureMask") then return end
	local sprite = getSprite(tileName)
	if not sprite then return end
	if not sprite:getSpriteGrid() then return end
	self:java6("renderSpriteGridTextureMask", sx, sy, sx2, sy2, pixelSize, sprite)
end

-- Called from Java
function Scene:onGizmoChanged(delta)
	if self.currentTool then
		self.currentTool:onGizmoChanged(delta)
	end
end

function Scene:isPolygonObject(objectId)
	return luautils.stringStarts(objectId, "polygon")
end

function Scene:java0(func)
	return self.javaObject:fromLua0(func)
end

function Scene:java1(func, arg0)
	return self.javaObject:fromLua1(func, arg0)
end

function Scene:java2(func, arg0, arg1)
	return self.javaObject:fromLua2(func, arg0, arg1)
end

function Scene:java3(func, arg0, arg1, arg2)
	return self.javaObject:fromLua3(func, arg0, arg1, arg2)
end

function Scene:java4(func, arg0, arg1, arg2, arg3)
	return self.javaObject:fromLua4(func, arg0, arg1, arg2, arg3)
end

function Scene:java5(func, arg0, arg1, arg2, arg3, arg4)
	return self.javaObject:fromLua5(func, arg0, arg1, arg2, arg3, arg4)
end

function Scene:java6(func, arg0, arg1, arg2, arg3, arg4, arg5)
	return self.javaObject:fromLua6(func, arg0, arg1, arg2, arg3, arg4, arg5)
end

function Scene:java7(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
	return self.javaObject:fromLua7(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
end

function Scene:java9(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
	return self.javaObject:fromLua9(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
end

function Scene:new(x, y, width, height, editor)
	local o = ISUI3DScene.new(self, x, y, width, height)
	o.editor = editor
	o.gizmo = "translate"
	o.gizmoAxis = "None"
	o.animation = "Bob_Idle"
	return o
end

-----

require "DebugUIs/TileGeometryEditor/TileGeometryEditor_TileList"
local TileList = TileGeometryEditor_TileList

-----

TileGeometryEditor_TilePicker = ISPanel:derive("TileGeometryEditor_TilePicker")
local TilePicker = TileGeometryEditor_TilePicker

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

	local listY = combo:getBottom() + UI_BORDER_SPACING
	local listBox = TileList:new(0, listY, self.width, self.height - listY, self)
	listBox:setAnchorBottom(true)
	self:addChild(listBox)
	listBox:addScrollBars()
	self.listBox = listBox
end

function TilePicker:setTileset(tilesetName)
	self.comboTileset:select(tilesetName)
	self.listBox:setTileset(tilesetName)
end

function TilePicker:onMouseWheel(del)
	self.listBox:onMouseWheel(del)
	return true
end

function TilePicker:onSelectTileset()
	local tilesetName = self.comboTileset:getOptionText(self.comboTileset.selected)
	self.listBox:setTileset(tilesetName)
end

function TilePicker:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

require "DebugUIs/TileGeometryEditor/TileGeometryEditor_TileList2"
local TileList2 = TileGeometryEditor_TileList2

-----

TileGeometryEditor_TilePicker2 = ISPanel:derive("TileGeometryEditor_TilePicker2")
local TilePicker2 = TileGeometryEditor_TilePicker2

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

	local listY = combo:getBottom() + UI_BORDER_SPACING
	local listBox = TileList2:new(0, listY, self.width, self.height - listY, self)
	listBox:setAnchorBottom(true)
	self:addChild(listBox)
	listBox:addScrollBars()
	self.listBox = listBox
end


function TilePicker2:setTileset(tilesetName)
	self.comboTileset:select(tilesetName)
	self.listBox:setTileset(tilesetName)
end

function TilePicker2:onMouseWheel(del)
	self.listBox:onMouseWheel(del)
	return true
end

function TilePicker2:onSelectTileset()
	local tilesetName = self.comboTileset:getOptionText(self.comboTileset.selected)
	self.listBox:setTileset(tilesetName)
end

function TilePicker2:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

function TileGeometryEditor:createChildren()
	local gameState = getTileGeometryState()

	self.scene = Scene:new(0, 0, self.width, self.height, self)
	self.scene:initialise()
	self.scene:instantiate()
	self.scene:setAnchorRight(true)
	self.scene:setAnchorBottom(true)
	self:addChild(self.scene)

	self:resetView()

	self.scene:java2("dragView", 0, self.height / 4)

	self.scene:java1("setMaxZoom", 20)
	self.scene:java1("setZoom", 7)
	self.scene:java1("setGizmoScale", 1.0 / 5.0)

	self.scene:java1("setDrawGrid", gameState:getBoolean("DrawGrid"))
	self.scene:java1("setDrawGridAxes", true)
	self.scene:java1("setGridMult", 10)
	self.scene:java1("setGridPlane", "XZ")

	-- Depth textures must come before the character so depth buffering works
	self.scene:java7("createDepthTexture",
		"depthTexture",
		getTexture("media/white.png"),
		0,
		0,
		64,
		128,
		0.0)
	self.scene:java2("setObjectVisible", "depthTexture", false)

	-- Geometry must come before the character so depth buffering works
	self.scene:java1("createCharacter", "character1")
	self.scene:java2("setCharacterAlpha", "character1", 1.0)
	self.scene:java2("setCharacterAnimate", "character1", self.animate)
	self.scene:java2("setCharacterAnimSet", "character1", "player-editor")
	self.scene:java2("setCharacterState", "character1", "runtime")
	self.scene:java2("setCharacterClearDepthBuffer", "character1", false)
	self.scene:java2("setCharacterShowBones", "character1", false)
	self.scene:java2("setCharacterShowBip01", "character1", false)
	self.scene:java2("setCharacterUseDeferredMovement", "character1", gameState:getBoolean("UseDeferredMovement"))
	self.scene:java2("setObjectVisible", "character1", true)

	self.scene.javaObject:fromLua2("createModel", "curtain", "SheetDoorClosed")
	local spriteModel = getScriptManager():getSpriteModel("fixtures_windows_curtains_01_16")
--	self.scene:java2("setModelSpriteModel", "curtain", spriteModel)
	self.scene.javaObject:fromLua1("getObjectTranslation", "curtain"):set(spriteModel:getTranslate())
	self.scene.javaObject:fromLua1("getObjectRotation", "curtain"):set(spriteModel:getRotate())
	self.scene.javaObject:fromLua1("getObjectScale", "curtain"):set(spriteModel:getScale() * 1.5)
	self.scene:java2("setObjectVisible", "curtain", false)

	self:createToolbar()

	local scrollbarWidth = 13
	local tilePickerWidth = 8 * 32 + scrollbarWidth
	local tilePickerTop = BUTTON_HGT+UI_BORDER_SPACING
	self.tilePicker = TilePicker:new(self.width - UI_BORDER_SPACING - tilePickerWidth-1, UI_BORDER_SPACING+tilePickerTop, tilePickerWidth, self.height - UI_BORDER_SPACING*2-2-tilePickerTop, self)
	self.tilePicker:setAnchorBottom(true)
	self:addChild(self.tilePicker)

	self.tilePicker2 = TilePicker2:new(self.tilePicker.x - UI_BORDER_SPACING - tilePickerWidth, self.tilePicker.y, self.tilePicker.width, self.tilePicker.height, self)
	self.tilePicker2:setAnchorBottom(true)
	self:addChild(self.tilePicker2)

	self.bottomPanel = ISPanel:new(0, self.height - UI_BORDER_SPACING - BUTTON_HGT-1, 200, BUTTON_HGT)
	self.bottomPanel:setAnchorTop(false)
	self.bottomPanel:setAnchorLeft(true)
	self.bottomPanel:setAnchorRight(false)
	self.bottomPanel:setAnchorBottom(true)
	self.bottomPanel:noBackground()
	self:addChild(self.bottomPanel)

	local button2 = ISButton:new(UI_BORDER_SPACING+1, 0, 80, BUTTON_HGT, "EXIT", self, self.onExit)
	self.bottomPanel:addChild(button2)
	button2:enableCancelColor()

	local button3 = ISButton:new(button2:getRight() + UI_BORDER_SPACING, button2.y, 80, BUTTON_HGT, "SAVE", self, self.onSave)
	self.bottomPanel:addChild(button3)
	button3:enableAcceptColor()

	local button4 = ISButton:new(button3:getRight() + UI_BORDER_SPACING, button3.y, 80, BUTTON_HGT, "RELOAD TEXTURE", self, self.onReloadTexture)
	self.bottomPanel:addChild(button4)

	self.bottomPanel:shrinkWrap(0, 0, nil)

	local viewNames = {'UserDefined', 'Left', 'Right', 'Top', 'Bottom', 'Front', 'Back'}
	local viewW = 150
	local viewH = 100
	local viewPadX = UI_BORDER_SPACING
	local viewPanelW = #viewNames * viewW + (#viewNames - 1) * viewPadX
	self.switchViewPanel = ISPanel:new((self.width - viewPanelW) / 2, self.bottomPanel.y - viewH, viewPanelW, viewH)
	self.switchViewPanel:setAnchorTop(false)
	self.switchViewPanel:setAnchorLeft(false)
	self.switchViewPanel:setAnchorRight(false)
	self.switchViewPanel:setAnchorBottom(true)
	self.switchViewPanel:noBackground()
	self:addChild(self.switchViewPanel)

	local viewX = 0
	local viewY = 0
	self.views = {}
	for _,viewName in ipairs(viewNames) do
		local view = SwitchView:new(self, viewX, viewY, viewW, viewH)
		view:initialise()
		view:instantiate()
		view:setAnchorTop(false)
		view:setAnchorRight(false)
		view:setView(viewName)
		if viewName == 'UserDefined' then
			view.javaObject:fromLua3("setViewRotation", 30.0, 45.0 + 270, 0.0)
		end
		view.javaObject:fromLua1("setMaxZoom", 14)
		view.javaObject:fromLua1("setZoom", 14)
		view.javaObject:fromLua1("setDrawGrid", false)
		view.javaObject:fromLua1("createCharacter", "character1")
		view.javaObject:fromLua2("setCharacterAnimSet", "character1", "player-editor")
		view.javaObject:fromLua2("setCharacterAlpha", "character1", 1.0)
		if viewName == 'UserDefined' then
			view.javaObject:fromLua2("dragView", 0, viewH * 1.75)
		elseif viewName ~= "Top" and viewName ~= "Bottom" then
			view.javaObject:fromLua2("dragView", 0, viewH * 2)
		end
		self.switchViewPanel:addChild(view)
		table.insert(self.views, view)
		viewX = viewX + viewW + viewPadX
	end

	self.scene.tools = {}
	-- mode=Geometry
	self.scene.tools.depthRect = TileGeometryEditor_DepthRectTool:new(self)
	self.scene.tools.editPolygon = TileGeometryEditor_EditPolygonTool:new(self)
	self.scene.tools.gizmo = {}
	self.scene.tools.gizmo.translate = TileGeometryEditor_GizmoTool_Translate:new(self)
	self.scene.tools.gizmo.rotate = TileGeometryEditor_GizmoTool_Rotate:new(self)
	self.scene.tools.gizmo.scale = TileGeometryEditor_GizmoTool_Scale:new(self)
	self.scene.tools.resizeBox = TileGeometryEditor_GizmoTool_ResizeBox:new(self)
	self.scene.tools.resizeCylinder = TileGeometryEditor_GizmoTool_ResizeCylinder:new(self)
	self.scene.tools.setSurface = TileGeometryEditor_GizmoTool_SetSurface:new(self)
	-- mode=SceneTiles
	self.scene.tools.addTile = TileGeometryEditor_AddTileTool:new(self)
	self.scene.tools.removeTile = TileGeometryEditor_AddTileTool:new(self)
	self.scene.tools.removeTile.bRemoveTile = true
	self.scene.tools.moveTile = TileGeometryEditor_MoveTileTool:new(self)

	self.sceneTiles = TileGeometryEditor_SceneTiles:new(self)

	self.editMode = {}
	self.editMode.current = nil

	local mode = TileGeometryEditor_EditMode_Geometry:new(self)
	self.editMode.geometry = mode
	
	mode = TileGeometryEditor_EditMode_SceneTiles:new(self)
	self.editMode.sceneTiles = mode

	mode = TileGeometryEditor_EditMode_Seating:new(self)
	self.editMode.seating = mode

	mode = TileGeometryEditor_EditMode_Curtain:new(self)
	self.editMode.curtain = mode

	self:setEditMode(self.editMode.geometry)

	self:setGeometryList()
end

function TileGeometryEditor:createToolbar()
	self.toolBar = ISPanel:new(0, UI_BORDER_SPACING+1, 300, BUTTON_HGT)
	self.toolBar:noBackground()
	self:addChild(self.toolBar)

	self.comboModID = ISComboBox:new(0, 0, 300, BUTTON_HGT, self, self.onSelectModID)
	self.toolBar:addChild(self.comboModID)
	local modIDs = TileGeometryManager.getInstance():getModIDs()
	for i=1,modIDs:size() do
		self.comboModID:addOption(modIDs:get(i-1))
	end
	self.comboModID:setWidthToOptions()

	self.comboMode = ISComboBox:new(self.comboModID:getRight() + UI_BORDER_SPACING, 0, 300, BUTTON_HGT, self, self.onSelectMode)
	self.toolBar:addChild(self.comboMode)
	self.comboMode:addOptionWithData("Geometry", "geometry")
	self.comboMode:addOptionWithData("Seating", "seating")
	self.comboMode:addOptionWithData("Curtains", "curtain")
	self.comboMode:addOptionWithData("Other Tiles", "sceneTiles")
	self.comboMode:setWidthToOptions()

	local button = ISButton:new(self.comboMode:getRight() + UI_BORDER_SPACING, 0, 60, BUTTON_HGT, "OPTIONS", self, self.onOptions)
	self.toolBar:addChild(button)
	self.buttonOptions = button

	self.toolBar:shrinkWrap(0, 0, nil)
	self.toolBar:setX(self.width / 2 - self.toolBar.width / 2)

	self.optionsPanel = OptionsPanel:new(0, 0, 300, 400)
	self.optionsPanel:setVisible(false)
	self:addChild(self.optionsPanel)
end

function TileGeometryEditor:setEditMode(mode)
	if self.editMode.current then
		self.editMode.current:deactivate()
	end
	self.editMode.current = mode
	if mode then
		mode:activate()
	end
end

function TileGeometryEditor:setGeometryList()
	self.editMode.geometry:setGeometryList()
end

function TileGeometryEditor:getValidGizmos()
	return self.editMode.current:getValidGizmos()
end

function TileGeometryEditor:indexOf(tbl, element)
	for index,element2 in ipairs(tbl) do
		if element2 == element then
			return index
		end
	end
	return -1
end

function TileGeometryEditor:resetView()
	self.scene:setView("UserDefined")
	self.scene:java3("setViewRotation", 30.0, 45.0 + 270, 0.0)
	self.scene:java1("setGridPlane", "XZ")
end

function TileGeometryEditor:onResolutionChange(oldw, oldh, neww, newh)
	self:setWidth(neww)
	self:setHeight(newh)
	self.tilePicker:setX(self.width - UI_BORDER_SPACING - self.tilePicker.width)
	self.tilePicker2:setX(self.tilePicker.x - UI_BORDER_SPACING - self.tilePicker2.width)
	self.switchViewPanel:setX(self.width / 2 - self.switchViewPanel.width / 2)
end

function TileGeometryEditor:update()
	ISPanel.update(self)
	if self.width ~= getCore():getScreenWidth() or self.height ~= getCore():getScreenHeight() then
		self:onResolutionChange(self.width, self.height, getCore():getScreenWidth(), getCore():getScreenHeight())
	end
end

function TileGeometryEditor:prerender()
	ISPanel.prerender(self)
	local gizmos = self:getValidGizmos()
	if self:indexOf(gizmos, self.scene.gizmo) == -1 then
		self:onToggleGizmo()
	end
	self.scene.selectedObjectName = self.editMode.geometry.listBox.items[self.editMode.geometry.listBox.selected].item
	self.scene:prerenderEditor()

	local translate = self.scene:java1("getObjectTranslation", self.scene.selectedObjectName)
	local rotate = self.scene:java1("getObjectRotation", self.scene.selectedObjectName)
	-- FIXME: axes are always rendered relative to the gizmo transform, this should be in world space.
--	self.scene:java6("addAxis", translate:x(), translate:y(), translate:z(), rotate:x(), rotate:y(), rotate:z())

	self:configGizmo()

	self.editMode.current:prerenderEditor()
end

function TileGeometryEditor:configGizmo()
	if self.editMode.current:configGizmo() then
		return
	end

	if not self.zeroVector then self.zeroVector = Vector3f.new() end

	if self.scene.selectedObjectName == "character1" then
		if self.scene.gizmo == "rotate" then
			-- FIXME: This is required for the rotate gizmo to work correctly.
			self.scene:java2("setGizmoOrigin", "character", self.scene.selectedObjectName)
			self.scene:java1("setGizmoPos", self.zeroVector)
			self.scene:java1("setGizmoRotate", self.zeroVector)
			return
		end
		if self.scene.gizmo == "translate" then
			self.scene:java2("setGizmoOrigin", "character", self.scene.selectedObjectName)
--			self.scene:java1("setGizmoPos", self.scene:java1("getObjectTranslation", self.scene.selectedObjectName))
--			self.scene:java1("setGizmoRotate", self.scene:java1("getObjectRotation", self.scene.selectedObjectName))
			return
		end
	end
--[[
	if self.listBox.selected == 1 then
		self.scene:java2("setGizmoOrigin", "character", self.scene.selectedObjectName)
	else
		self.scene:java2("setGizmoOrigin", "polygon", self.scene.selectedObjectName)
	end
--]]
	self.scene:java1("setGizmoPos", self.scene:java1("getObjectTranslation", self.scene.selectedObjectName))
	self.scene:java1("setGizmoRotate", self.scene:java1("getObjectRotation", self.scene.selectedObjectName))
--	self.scene.javaObject:fromLua1("setGizmoVisible", "rotate")
--	self.scene.javaObject:fromLua3("setGizmoXYZ", 1.0, 0.0, 0.0)
end

function TileGeometryEditor:render()
	ISPanel.render(self)
	local isPolygonSelected = false
	for i=2,self.editMode.geometry.listBox:size() do
		local objectName = self.editMode.geometry.listBox.items[i].item
		if self.scene:isPolygonObject(objectName) then
			self.scene:java2("setPolygonEditing", objectName, false)
			if i == self.editMode.geometry.listBox.selected then
				isPolygonSelected = true
			end
		end
	end
	self.scene.editPoints = self.scene.editPoints and self.scene:java0("getDrawGeometry") and isPolygonSelected
	if self.scene.editPoints then
		local objectName = self.editMode.geometry.listBox.items[self.editMode.geometry.listBox.selected].item
		self.scene:java2("setPolygonEditing", objectName, true)
		local pointIndex = self.scene:java4("pickPolygonPoint", objectName, getMouseX(), getMouseY(), 20)
		self.scene:java2("setPolygonHighlightPoint", objectName, pointIndex)
		if pointIndex == -1 and self.scene:isMouseOver() then
			self.polygonPoint2D = self.polygonPoint2D or Vector2f.new()
			local mouseX,mouseY = getMouseX(),getMouseY()
			if self.scene:isViewUserDefined() then
				mouseX,mouseY = self.scene:snapToTilePixel(mouseX, mouseY)
			end
			self.scene:java4("uiToPolygonPoint", objectName, mouseX, mouseY, self.polygonPoint2D)
			self.uiPoint = self.uiPoint or Vector2f.new()
			self.scene:java3("polygonToUI", objectName, self.polygonPoint2D, self.uiPoint)
			self:drawRect(self.uiPoint:x() - 5, self.uiPoint:y() - 5, 10, 10, 1.0, 1.0, 1.0, 1.0)
		end
	end
end

function TileGeometryEditor:onKeyPress(key)
	if key == Keyboard.KEY_TAB then
		if self.editMode.current == self.editMode.geometry then
			self:setEditMode(self.editMode.seating)
			self.comboMode:selectData("seating")
		elseif self.editMode.current == self.editMode.seating then
			self:setEditMode(self.editMode.curtain)
			self.comboMode:selectData("curtain")
		elseif self.editMode.current == self.editMode.curtain then
			self:setEditMode(self.editMode.sceneTiles)
			self.comboMode:selectData("sceneTiles")
		else
			self:setEditMode(self.editMode.geometry)
			self.comboMode:selectData("geometry")
		end
		return
	end
	self.editMode.current:onKeyPress(key)
end

function TileGeometryEditor:onSelectModID()
	self.modID = self.comboModID:getOptionText(self.comboModID.selected)
	self.scene.selectedTileName = nil
end

function TileGeometryEditor:onSelectMode()
	local modeName = self.comboMode:getOptionData(self.comboMode.selected)
	self:setEditMode(self.editMode[modeName])
end

function TileGeometryEditor:onOptions()
	self.optionsPanel:setX(self.buttonOptions:getAbsoluteX())
	self.optionsPanel:setY(self.buttonOptions:getAbsoluteY() + self.buttonOptions:getHeight())
	self.optionsPanel:setVisible(true)
end

function TileGeometryEditor:onExit(button, x, y)
	getTileGeometryState():fromLua0("exit")
end

function TileGeometryEditor:onSave(button, x, y)
	self.editMode.current:onSave()
end

function TileGeometryEditor:onReloadTexture(button, x, y)
	local picker = self.tilePicker.listBox
	if picker.tileset then
		getTileGeometryState():fromLua2("reloadTilesetTexture", self.modID, picker.tileset)
	end
end

function TileGeometryEditor:updateGeometryFile()
	local picker = self.tilePicker.listBox
	local selectedTile = picker:getSingleSelectedTile()
	if selectedTile then
		self.scene:java4("updateGeometryFile", self.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1)
	end
end

function TileGeometryEditor:updateGeometryFile2(selectedTile)
	local picker = self.tilePicker.listBox
	if selectedTile then
		self.scene:java4("updateGeometryFile", self.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1)
	end
end

-- Called from Java
function TileGeometryEditor:showUI()
end

function TileGeometryEditor:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o:setAnchorRight(true)
	o:setAnchorBottom(true)
	o:noBackground()
	o:setWantKeyEvents(true)
	o.animate = true
	o.modID = "game"
	getTileGeometryState():setTable(o)
	return o
end

-- Called from Java
function TileGeometryEditor_InitUI()
	local UI = TileGeometryEditor:new(0, 0, getCore():getScreenWidth(), getCore():getScreenHeight())
	TileGeometryEditor_UI = UI
	UI:setVisible(true)
	UI:addToUIManager()
end

