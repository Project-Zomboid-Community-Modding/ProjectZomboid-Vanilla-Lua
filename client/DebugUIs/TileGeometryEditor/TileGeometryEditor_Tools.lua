--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISBaseObject"
require "DebugUIs/TileGeometryEditor/TileGeometryEditor_SceneTiles"

local Z_SCALE = 0.8164966666666666
local TEXTURE_OFFSET_X = 1

TileGeometryEditor_Tool = ISBaseObject:derive("TileGeometryEditor_Tool")
local Tool = TileGeometryEditor_Tool

function Tool:onMouseDown(x, y)
end

function Tool:onMouseMove(dx, dy)
end

function Tool:onMouseUp(x, y)
end

function Tool:onRightMouseDown(x, y)
end

function Tool:onGizmoChanged(delta)
end

function Tool:renderScene()
end

function Tool:java0(func)
	return self.scene:java0(func)
end

function Tool:java1(func, arg0)
	return self.scene:java1(func, arg0)
end

function Tool:java2(func, arg0, arg1)
	return self.scene:java2(func, arg0, arg1)
end

function Tool:java3(func, arg0, arg1, arg2)
	return self.scene:java3(func, arg0, arg1, arg2)
end

function Tool:java4(func, arg0, arg1, arg2, arg3)
	return self.scene:java4(func, arg0, arg1, arg2, arg3)
end

function Tool:java5(func, arg0, arg1, arg2, arg3, arg4)
	return self.scene:java5(func, arg0, arg1, arg2, arg3, arg4)
end

function Tool:java6(func, arg0, arg1, arg2, arg3, arg4, arg5)
	return self.scene:java5(func, arg0, arg1, arg2, arg3, arg4, arg5)
end

function Tool:java7(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
	return self.scene:java7(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
end

function Tool:getMouseX()
	return self.scene:getMouseX()
end

function Tool:getMouseY()
	return self.scene:getMouseY()
end

function Tool:new(editor)
	local o = ISBaseObject.new(self)
	o.editor = editor
	o.scene = editor.scene
	o.javaObject = editor.scene.javaObject
	return o
end

-----

TileGeometryEditor_GizmoTool = Tool:derive("TileGeometryEditor_GizmoTool")
local GizmoTool = TileGeometryEditor_GizmoTool

function GizmoTool:onMouseDown(x, y)
	self.gizmoAxis = self:java2("testGizmoAxis", x, y)
	local scenePos = self:java0("getGizmoPos")
	self.gizmoStartScenePos = Vector3f.new(scenePos)
--	self.gizmoClickScenePos = self.javaObject:uiToScene(x, y, 0, Vector3f.new())
	self.javaObject:fromLua3("startGizmoTracking", x, y, self.gizmoAxis)
	self:onGizmoStart()
end

function GizmoTool:onMouseMove(dx, dy)
	if self.gizmoAxis ~= "None" then
		local x,y = self:getMouseX(),self:getMouseY()
--		local newPos = self.javaObject:uiToScene(x, y, 0, Vector3f.new())
--		newPos:sub(self.gizmoClickScenePos)
--		newPos:add(self.gizmoStartScenePos)
		self:java2("dragGizmo", x, y)
	end
end

function GizmoTool:onMouseUp(x, y)
	if self.gizmoAxis ~= "None" then
		self.gizmoAxis = "None"
		self.scene.gizmoAxis = "None"
		self:java0("stopGizmoTracking")
		self:onGizmoAccept()
		self.scene.currentTool = nil
	end
end

function GizmoTool:onRightMouseDown(x, y)
	if self.gizmoAxis ~= "None" then
		self.gizmoAxis = "None"
		self.scene.gizmoAxis = "None"
		self:java0("stopGizmoTracking")
--		self.mouseDown = false
		self:java1("setGizmoPos", self.gizmoStartScenePos)
		self:onGizmoCancel()
		self.scene.currentTool = nil
	end
end

function GizmoTool:onGizmoStart()
end

function GizmoTool:onGizmoChanged(delta)
end

function GizmoTool:onGizmoAccept()
end

function GizmoTool:onGizmoCancel()
end

function GizmoTool:new(editor)
	local o = Tool.new(self, editor)
	return o
end

-----

TileGeometryEditor_GizmoTool_Translate = GizmoTool:derive("TileGeometryEditor_GizmoTool_Translate")
local GizmoToolTranslate = TileGeometryEditor_GizmoTool_Translate

function GizmoToolTranslate:onGizmoStart()
	self.originalOffset = {}
	local objectName = self.scene.selectedObjectName
	local trans = Vector3f.new(self:java1("getObjectTranslation", objectName))
	self.originalOffset[objectName] = trans
end

function GizmoToolTranslate:onGizmoChanged(delta)
	if self.gizmoAxis == "None" then return end -- cancelled via onRightMouseDown
	local objectName = self.scene.selectedObjectName
	local translation = self:java1("getObjectTranslation", objectName)
	translation:set(self.originalOffset[objectName])
	translation:add(delta)
	if self.snapFunc == nil then return end
	self:snapFunc()
end

function GizmoToolTranslate:snap()
	local objectName = self.scene.selectedObjectName
	local translation = self:java1("getObjectTranslation", objectName)
	local sx = self.javaObject:sceneToUIX(0.0, 0.0, 0.0)
	local sy = self.javaObject:sceneToUIY(0.0, 0.0, 0.0)
	local sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
	local sy2 = self.javaObject:sceneToUIY(1.0, 0.0, 0.0)
	local pixelScreenSize = math.sqrt((sx2 - sx) * (sx2 - sx) + (sy2 - sy) * (sy2 - sy)) / math.sqrt(64 * 64 + 32 * 32)
	if self.gizmoAxis == "X" then
		sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
		local xEqualsOnePixels = math.abs(sx2 - sx)
		local sceneDX = (pixelScreenSize / xEqualsOnePixels)
		sceneDX = 1 / 64
		translation:setComponent(0, math.floor(translation:x() / sceneDX) * sceneDX)
	elseif self.gizmoAxis == "Y" then
		sy2 = self.javaObject:sceneToUIY(0.0, 1.0, 0.0)
		local yEqualsOnePixels = math.abs(sy2 - sy)
		local sceneDY = (pixelScreenSize / yEqualsOnePixels)
		sceneDY = 1 / 96
		translation:setComponent(1, math.floor(translation:y() / sceneDY) * sceneDY)
	elseif self.gizmoAxis == "Z" then
		sx2 = self.javaObject:sceneToUIX(0.0, 0.0, 1.0)
		local zEqualsOnePixels = math.abs(sx2 - sx)
		local sceneDZ = (pixelScreenSize / zEqualsOnePixels)
		sceneDZ = 1 / 64
		translation:setComponent(2, math.floor(translation:z() / sceneDZ) * sceneDZ)
	end
end

function GizmoToolTranslate:onGizmoAccept()
	local objectName = self.scene.selectedObjectName
	if self:java1("getGeometryType", objectName) ~= nil then
		self.editor:updateGeometryFile()
	end
end

function GizmoToolTranslate:onGizmoCancel()
	local objectName = self.scene.selectedObjectName
	self:java1("getObjectTranslation", objectName):set(self.originalOffset[objectName])
end

function GizmoToolTranslate:new(editor)
	local o = GizmoTool.new(self, editor)
	return o
end

-----

TileGeometryEditor_GizmoTool_Rotate = GizmoTool:derive("TileGeometryEditor_GizmoTool_Rotate")
local GizmoToolRotate = TileGeometryEditor_GizmoTool_Rotate

function GizmoToolRotate:onGizmoStart()
	self.originalRotate = {}
	local objectName = self.scene.selectedObjectName
	self.originalRotate[objectName] = Vector3f.new(self:java1("getObjectRotation", objectName))
	if isCtrlKeyDown() then
		local rotate = self.originalRotate[objectName]
		if self.gizmoAxis == "X" then
			self.originalRotate[objectName]:setComponent(0, self:clampAngle(rotate:x()))
		elseif self.gizmoAxis == "Y" then
			self.originalRotate[objectName]:setComponent(1, self:clampAngle(rotate:y()))
		elseif self.gizmoAxis == "Z" then
			self.originalRotate[objectName]:setComponent(2, self:clampAngle(rotate:z()))
		end
	end
end

function GizmoToolRotate:onGizmoChanged(delta)
	if self.gizmoAxis == "None" then return end -- cancelled via onRightMouseDown
	local objectName = self.scene.selectedObjectName
	local rotation = self:java1("getObjectRotation", objectName)
	rotation:set(self.originalRotate[objectName])
	self:java2("applyDeltaRotation", rotation, delta)
end

function GizmoToolRotate:onGizmoAccept()
	local objectName = self.scene.selectedObjectName
	if self:java1("getGeometryType", objectName) ~= nil then
		self.editor:updateGeometryFile()
	end
end

function GizmoToolRotate:onGizmoCancel()
	local objectName = self.scene.selectedObjectName
	local rotation = self:java1("getObjectRotation", objectName)
	rotation:set(self.originalRotate[objectName])
end

function GizmoToolRotate:clampAngle(degrees)
	if degrees < 0 then
		return Math.round(-degrees / 5) * -5
	end
	return math.floor(degrees / 5) * 5
end

function GizmoToolRotate:new(editor)
	local o = GizmoTool.new(self, editor)
	return o
end

-----

TileGeometryEditor_GizmoTool_Scale = GizmoTool:derive("TileGeometryEditor_GizmoTool_Scale")
local GizmoToolScale = TileGeometryEditor_GizmoTool_Scale

function GizmoToolScale:onGizmoStart()
	self.originalScale = {}
	local objectName = self.scene.selectedObjectName
	if luautils.stringStarts(objectName, "box") then
		self.originalScale[objectName] = Vector3f.new(self:java1("getBoxExtents", objectName))
	end
	if self.scene:isPolygonObject(objectName) then
		self.originalScale[objectName] = Vector3f.new(self:java1("getPolygonExtents", objectName))
	end
end

function GizmoToolScale:onGizmoChanged(delta)
	if self.gizmoAxis == "None" then return end -- cancelled via onRightMouseDown
	local objectName = self.scene.selectedObjectName
	if luautils.stringStarts(objectName, "box") then
		local sx = self.javaObject:sceneToUIX(0.0, 0.0, 0.0)
		local sy = self.javaObject:sceneToUIY(0.0, 0.0, 0.0)
		local sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
		local sy2 = self.javaObject:sceneToUIY(1.0, 0.0, 0.0)
		local pixelScreenSize = math.sqrt((sx2 - sx) * (sx2 - sx) + (sy2 - sy) * (sy2 - sy)) / math.sqrt(64 * 64 + 32 * 32)
		local yEqualsOnePixels = math.abs(sy2 - sy)
		local sceneDY = (pixelScreenSize / yEqualsOnePixels)
		local original = self.originalScale[objectName]
		local extents = Vector3f.new(original:x() * 2, original:y() * 2, original:z() * 2)
		extents:add(delta)
		if self.gizmoAxis == "Y" then
			extents:setComponent(1, extents:y() / Z_SCALE)
		end
		if extents:x() < 0.1 then extents:setComponent(0, 0.1) end
		if extents:y() < sceneDY * Z_SCALE * 2 then extents:setComponent(1, sceneDY * Z_SCALE * 2) end
		if extents:z() < 0.1 then extents:setComponent(2, 0.1) end
		if self.gizmoAxis == "Y" then
			extents:setComponent(1, math.floor(extents:y() / sceneDY) * sceneDY * Z_SCALE)
		end
		self:java1("getBoxExtents", objectName):set(extents:mul(0.5))
	end
	if self.scene:isPolygonObject(objectName) then
		local extents = Vector3f.new(delta)
		extents:mul(2)
		extents:add(self.originalScale[objectName])
		if extents:x() < 0.1 then extents:setComponent(0, 0.1) end
		if extents:y() < 0.1 then extents:setComponent(1, 0.1) end
		if extents:z() < 0.1 then extents:setComponent(2, 0.1) end
		self:java2("setPolygonExtents", objectName, extents)
	end
end

function GizmoToolScale:onGizmoAccept()
end

function GizmoToolScale:onGizmoCancel()
	local objectName = self.scene.selectedObjectName
	if luautils.stringStarts(objectName, "box") then
		self:java1("getBoxExtents", objectName):set(self.originalScale[objectName])
	end
	if self.scene:isPolygonObject(objectName) then
		self:java2("setPolygonExtents", objectName, self.originalScale[objectName])
	end
end

function GizmoToolScale:new(editor)
	local o = GizmoTool.new(self, editor)
	return o
end

-----

TileGeometryEditor_GizmoTool_ResizeBox = GizmoTool:derive("TileGeometryEditor_GizmoTool_ResizeBox")
local GizmoToolResizeBox = TileGeometryEditor_GizmoTool_ResizeBox

function GizmoToolResizeBox:onGizmoStart()
	local objectName = self.scene.selectedObjectName
	self.originalMin = Vector3f.new(self:java1("getBoxMinExtents", objectName))
	self.originalMax = Vector3f.new(self:java1("getBoxMaxExtents", objectName))
end

function GizmoToolResizeBox:onGizmoChanged(delta)
	if self.gizmoAxis == "None" then return end -- cancelled via onRightMouseDown
	local objectName = self.scene.selectedObjectName
	local min = self:java1("getBoxMinExtents", objectName)
	local max = self:java1("getBoxMaxExtents", objectName)
	local extents = max
	local original = self.originalMax
	if self.movingFace == "xMin" or self.movingFace == "yMin" or self.movingFace == "zMin" then
		extents = min
		original = self.originalMin
	end
	extents:set(original)
	extents:add(delta)
--[[
	local sx = self.javaObject:sceneToUIX(0.0, 0.0, 0.0)
	local sy = self.javaObject:sceneToUIY(0.0, 0.0, 0.0)
	local sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
	local sy2 = self.javaObject:sceneToUIY(1.0, 0.0, 0.0)
	local pixelScreenSize = math.sqrt((sx2 - sx) * (sx2 - sx) + (sy2 - sy) * (sy2 - sy)) / math.sqrt(64 * 64 + 32 * 32)
	if self.gizmoAxis == "X" then
		sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
		local xEqualsOnePixels = math.abs(sx2 - sx)
		local sceneDX = (pixelScreenSize / xEqualsOnePixels)
--		extents:setComponent(0, math.floor(extents:x() / sceneDX) * sceneDX)
	elseif self.gizmoAxis == "Y" then
		sy2 = self.javaObject:sceneToUIY(0.0, 1.0, 0.0)
		local yEqualsOnePixels = math.abs(sy2 - sy)
		local sceneDY = (pixelScreenSize / yEqualsOnePixels)
--		extents:setComponent(1, math.floor(extents:y() / sceneDY) * sceneDY)
	elseif self.gizmoAxis == "Z" then
		sx2 = self.javaObject:sceneToUIX(0.0, 0.0, 1.0)
		local zEqualsOnePixels = math.abs(sx2 - sx)
		local sceneDZ = (pixelScreenSize / zEqualsOnePixels)
--		extents:setComponent(2, math.floor(extents:z() / sceneDZ) * sceneDZ)
	end
--]]
end

function GizmoToolResizeBox:onGizmoAccept()
	local objectName = self.scene.selectedObjectName
	self:java1("recalculateBoxCenter", objectName)
	self.editor:updateGeometryFile()
end

function GizmoToolResizeBox:onGizmoCancel()
	local objectName = self.scene.selectedObjectName
	self:java1("getBoxMinExtents", objectName):set(self.originalMin)
	self:java1("getBoxMaxExtents", objectName):set(self.originalMax)
end

function GizmoToolResizeBox:new(editor)
	local o = GizmoTool.new(self, editor)
	return o
end

-----

TileGeometryEditor_GizmoTool_ResizeCylinder = GizmoTool:derive("TileGeometryEditor_GizmoTool_ResizeCylinder")
local GizmoToolResizeCylinder = TileGeometryEditor_GizmoTool_ResizeCylinder

function GizmoToolResizeCylinder:onGizmoStart()
	local objectName = self.scene.selectedObjectName
	self.originalHeight = self:java1("getCylinderHeight", objectName)
	self.originalTranslation = Vector3f.new(self:java1("getObjectTranslation", objectName))
	self.originalRadius = self:java1("getCylinderRadius", objectName)
end

function GizmoToolResizeCylinder:onGizmoChanged(delta)
	if self.gizmoAxis == "None" then return end -- cancelled via onRightMouseDown
	local objectName = self.scene.selectedObjectName
	local radius = self:java1("getCylinderRadius", objectName)
	if self.movingFace == "xMax" then
		self:java2("setCylinderRadius", objectName, self.originalRadius + delta:x())
	end
	if self.movingFace == "zMin" then
		self:java3("changeCylinderHeight", objectName, self.movingFace, self.originalHeight - delta:z())
	end
	if self.movingFace == "zMax" then
--		self:java2("setCylinderHeight", objectName, self.originalHeight + delta:z() * 2)
		self:java3("changeCylinderHeight", objectName, self.movingFace, self.originalHeight + delta:z())
	end
end

function GizmoToolResizeCylinder:onGizmoAccept()
	self.editor:updateGeometryFile()
end

function GizmoToolResizeCylinder:onGizmoCancel()
	local objectName = self.scene.selectedObjectName
	self:java2("setCylinderHeight", objectName, self.originalHeight)
	self:java1("getObjectTranslation", objectName):set(self.originalTranslation)
	self:java2("setCylinderRadius", objectName, self.originalRadius)
	self.editor.editMode.geometry.cylinderPanel:toUI()
end

function GizmoToolResizeCylinder:new(editor)
	local o = GizmoTool.new(self, editor)
	return o
end

-----

TileGeometryEditor_GizmoTool_SetSurface = GizmoTool:derive("TileGeometryEditor_GizmoTool_SetSurface")
local GizmoToolSetSurface = TileGeometryEditor_GizmoTool_SetSurface

function GizmoToolSetSurface:onGizmoStart()
	self.selection = {}
	local picker = self.editor.tilePicker.listBox
	local selection = picker:getSelection()
	for _,e in ipairs(selection.elements) do
		local sprite = getSprite(e.tileName)
		if sprite then
			local props = sprite:getProperties()
			local value = (self.movingFace == "ItemHeight") and props:getItemHeight() or props:getSurface()
			table.insert(self.selection, { col = e.col, row = e.row, tileName = e.tileName, sprite = sprite, props = props, originalValue = value })
		end
	end
end

function GizmoToolSetSurface:onGizmoChanged(delta)
	if self.gizmoAxis == "None" then return end -- cancelled via onRightMouseDown
	local propertyName = self.movingFace
	local e = self.selection[1]
	local newValue = e.originalValue + ((delta:y() * 96 * Z_SCALE) / Core.getTileScale())
	newValue = math.floor(newValue)
	newValue = math.max(newValue, 0)
	newValue = math.min(newValue, 96)
	for _,e in ipairs(self.selection) do
		e.props:Set(propertyName, tostring(newValue), false)
	end
end

function GizmoToolSetSurface:onGizmoAccept()
	local propertyName = self.movingFace
	local picker = self.editor.tilePicker.listBox
	local e = self.selection[1]
	local value = (self.movingFace == "ItemHeight") and e.props:getItemHeight() or e.props:getSurface()
	if value > 0 then value = tostring(value) else value = nil end
	for _,e in ipairs(self.selection) do
		TileGeometryManager.getInstance():setTileProperty(self.editor.modID, picker.tileset, e.col - 1, e.row - 1, propertyName, value)
	end
end

function GizmoToolSetSurface:onGizmoCancel()
	local propertyName = self.movingFace
	for _,e in ipairs(self.selection) do
		e.props:Set(propertyName, tostring(e.originalValue), false)
	end
	self.editor.editMode.geometry.propertiesPanel:toUI()
end

function GizmoToolSetSurface:new(editor)
	local o = GizmoTool.new(self, editor)
	return o
end

-----

TileGeometryEditor_EditPolygonTool = Tool:derive("TileGeometryEditor_EditPolygonTool")
local EditPolygonTool = TileGeometryEditor_EditPolygonTool

function EditPolygonTool:onMouseDown(x, y)
	local objectName = self.scene.selectedObjectName
	self.dragPointIndex = self:java4("pickPolygonPoint", objectName, x, y, 20)
	if self.dragPointIndex == -1 then
		self.polygonPoint2D = self.polygonPoint2D or Vector2f.new()
		local pointX,pointY = x,y
		if self.scene:isViewUserDefined() then
			pointX,pointY = self.scene:snapToTilePixel(pointX, pointY)
		end
		self:java5("addPolygonPointOnEdge", objectName, x, y, pointX, pointY)
		self.editor:updateGeometryFile()
	else
		self.dragPointOriginalPos = self.dragPointOriginalPos or Vector2f.new()
		self:java3("getPolygonPoint", objectName, self.dragPointIndex, self.dragPointOriginalPos)
	end
end

function EditPolygonTool:onMouseMove(dx, dy)
	local objectName = self.scene.selectedObjectName
	if self.dragPointIndex ~= -1 then
		self.polygonPoint2D = self.polygonPoint2D or Vector2f.new()
		local mouseX,mouseY = getMouseX(), getMouseY()
		if self.scene:isViewUserDefined() then
			mouseX,mouseY = self.scene:snapToTilePixel(mouseX, mouseY)
		end
		local pointIndex = self:java4("pickPolygonPoint", objectName, mouseX, mouseY, 10)
		self:java4("uiToPolygonPoint", objectName, mouseX, mouseY, self.polygonPoint2D)
		self:java3("setPolygonPoint", objectName, self.dragPointIndex, self.polygonPoint2D)
	end
end

function EditPolygonTool:onMouseUp(x, y)
	local objectName = self.scene.selectedObjectName
	if self.dragPointIndex ~= -1 then
		local mouseX,mouseY = getMouseX(), getMouseY()
		if self.scene:isViewUserDefined() then
			mouseX,mouseY = self.scene:snapToTilePixel(mouseX, mouseY)
		end
		-- Move the point back temporarily, so pickPolygonPoint() doesn't see it
		self.polygonPoint2D = self.polygonPoint2D or Vector2f.new()
		self:java3("getPolygonPoint", objectName, self.dragPointIndex, self.polygonPoint2D)
		self:java3("setPolygonPoint", objectName, self.dragPointIndex, self.dragPointOriginalPos)
		local pointIndex = self:java4("pickPolygonPoint", objectName, mouseX, mouseY, 10)
		if pointIndex ~= -1 and pointIndex ~= self.dragPointIndex then
			self:java2("removePolygonPoint", objectName, self.dragPointIndex)
		else
			self:java3("setPolygonPoint", objectName, self.dragPointIndex, self.polygonPoint2D)
		end
		self.editor:updateGeometryFile()
	end
	self.scene.currentTool = nil
end

function EditPolygonTool:onRightMouseDown(x, y)
	local objectName = self.scene.selectedObjectName
	if self.dragPointIndex ~= -1 and objectName ~= "character1" then
		self:java3("setPolygonPoint", objectName, self.dragPointIndex, self.dragPointOriginalPos)
		self.dragPointIndex = -1
		self.scene.currentTool = nil
	end
end

function EditPolygonTool:new(editor)
	local o = Tool.new(self, editor)
	return o
end

-----

TileGeometryEditor_DepthRectTool = Tool:derive("TileGeometryEditor_DepthRectTool")
local DepthRectTool = TileGeometryEditor_DepthRectTool

function DepthRectTool:onMouseDown(x, y)
	self.clickPixelX,self.clickPixelY = self.scene:uiToPixel(x, y)
end

function DepthRectTool:onMouseMove(dx, dy)
end

function DepthRectTool:onMouseUp(x, y)
	self.scene.currentTool = nil
	local x,y = self:getMouseX(),self:getMouseY()
	local sx,sy,sx2,sy2,pixelSize = self.scene:getTileBoundsEtc()
	if x < sx or x >= sx2 or y < sy or y >= sy2 then return end
	local tilesetName,tileIndex = self.scene:getSelectedTile()
	if not tilesetName then return end
	local depthTexture = TileDepthTextureManager.getInstance():getTexture(self.editor.modID, tilesetName, tileIndex)
	local texture = getTexture(self.scene:getSelectedTileName())
	local mask = texture and texture:getMask() or nil
	local px1,py1,px2,py2 = self:getMarqueeBounds(x, y)
	depthTexture:setPixels(px1, py1, px2 - px1 + 1, py2 - py1 + 1, 1000)
	self:addDefaultFloorPlane()
	local objectNames = self:java0("getGeometryNames")
	for i=1,objectNames:size() do
		local objectName = objectNames:get(i-1)
		if self:java1("getGeometryType", objectName) == "polygon" then
			local args = {}
			args.tool = self
			args.objectName = objectName
			args.depthTexture = depthTexture
			args.texture = texture
			args.mask = mask
			args.bounds = { x1=px1, y1=py1, x2=px2, y2=py2 }
			self:java3("rasterizePolygon", objectName, DepthRectTool.RasterizePolygonCallback, args)
		else
			for py=py1,py2 do
				for px=px1,px2 do
					local depth = self:java3("getGeometryDepthAt", objectName, px + 0.5 + TEXTURE_OFFSET_X, py + 0.5)
					if depth < 0 then
						-- erase
					elseif isCtrlKeyDown() then
						-- erase
					elseif (not isAltKeyDown()) and (mask ~= nil) and (not texture:isMaskSet(px, py)) then
						-- erase
					else
						depthTexture:setMinPixel(px, py, depth)
					end
				end
			end
		end
	end
	self:removeDefaultFloorPlane()
	depthTexture:replacePixels(px1, py1, px2 - px1 + 1, py2 - py1 + 1, 1000, -1.0)
	depthTexture:updateGPUTexture()
end

function DepthRectTool:onRightMouseDown(x, y)
	self.scene.currentTool = nil
end

function DepthRectTool.RasterizePolygonCallback(args, x, y)
	if x >= args.bounds.x1 and y >= args.bounds.y1 and x <= args.bounds.x2 and y <= args.bounds.y2 then
		local depth = args.tool:java3("getGeometryDepthAt", args.objectName, x + 0.5, y + 0.5)
		if args.mask and not args.texture:isMaskSet(x, y) then
			return
		end
		if isCtrlKeyDown() then
			return -- erase
		end
		args.depthTexture:setMinPixel(x, y, depth)
	end
end

-- Add a plane on the floor to catch shadows that aren't part of other geometry.
function DepthRectTool:addDefaultFloorPlane()
	local objectName = "defaultFloorPlane"
	self:java1("createPolygon", objectName)
	self:java2("setPolygonPlane", objectName, "XZ")
	local fudge = 0.001
	self:java3("setPolygonPoint", objectName, 0, Vector2f.new(-1 + fudge, -1 + fudge))
	self:java3("setPolygonPoint", objectName, 1, Vector2f.new(1 - fudge, -1 + fudge))
	self:java3("setPolygonPoint", objectName, 2, Vector2f.new(1 - fudge, 1 - fudge))
	self:java3("setPolygonPoint", objectName, 3, Vector2f.new(-1 + fudge, 1 - fudge))
	-- Reduce the depth slightly to fix an observed clipping issue on the edge of a bed shadow.
	-- Bed was okay, but Large Plastic Table lost a row of shadow pixels between tiles.
--	self:java1("getObjectTranslation", objectName):setComponent(1, 0.0125)
end

function DepthRectTool:removeDefaultFloorPlane()
	local objectName = "defaultFloorPlane"
	self:java1("removeObject", objectName)
end

function DepthRectTool:renderScene()
	local x,y = self:getMouseX(),self:getMouseY()
	local sx,sy,sx2,sy2,pixelSize = self.scene:getTileBoundsEtc()
	if x >= sx and x < sx2 and y >= sy and y < sy2 then
		local px1,py1,px2,py2 = self:getMarqueeBounds(x, y)
		local x1 = sx + px1 * pixelSize
		local y1 = sy + py1 * pixelSize
		local x2 = sx + (px2 + 1) * pixelSize
		local y2 = sy + (py2 + 1) * pixelSize
		self.scene:drawRect(x1, y1, x2 - x1, y2 - y1, 0.5, 1, 1, 1)
	end
end

function DepthRectTool:getMarqueeBounds(x, y)
	local px1,py1 = self.clickPixelX,self.clickPixelY
	local px2,py2 = self.scene:uiToPixel(x, y)
	if px1 > px2 then
		local swap = px1
		px1 = px2
		px2 = swap
	end
	if py1 > py2 then
		local swap = py1
		py1 = py2
		py2 = swap
	end
	return px1,py1,px2,py2
end

function DepthRectTool:new(editor)
	local o = Tool.new(self, editor)
	return o
end

-----

TileGeometryEditor_AddTileTool = Tool:derive("TileGeometryEditor_AddTileTool")
local AddTileTool = TileGeometryEditor_AddTileTool

function AddTileTool:onMouseDown(x, y)
	self.mouseDown = true
	self.mouseDownX = x
	self.mouseDownY = y
end

function AddTileTool:onMouseUp(x, y)
	if not self.mouseDown then return end
	self.mouseDown = false
	if not self.scene:isMouseOver() then return end
	if math.abs(x - self.mouseDownX) > 4 or math.abs(y - self.mouseDownY) > 4 then return end
	local scenePos = self:uiToTileLocation(x, y)
	local dx = scenePos:x()
	local dy = scenePos:z()
	if dx < -5 or dx > 5 or dy < -5 or dy > 5 then return end
	if dx == 0 and dy == 0 then return end
	if self.bRemoveTile then
		self.editor.sceneTiles:removeTile(dx, dy)
		return
	end
	local selectedTile = self:getFirstSelectedTile()
	if not selectedTile then return end
	local texture = getTexture(selectedTile.tileName)
	if not texture then return end
	self.editor.sceneTiles:addTile(dx, dy, selectedTile.tileName)
end

function AddTileTool:renderScene()
	if not self.scene:isMouseOver() then return end
	local x,y = self:getMouseX(),self:getMouseY()
	local scenePos = self:uiToTileLocation(x, y)
	local dx = scenePos:x()
	local dy = scenePos:z()
	if dx < -5 or dx > 5 or dy < -5 or dy > 5 then return end
	if dx == 0 and dy == 0 then return end
	if not self.bRemoveTile then
		local selectedTile = self:getFirstSelectedTile()
		if selectedTile ~= nil then
			self.editor.sceneTiles:renderTile(dx, dy, selectedTile.tileName)
		end
	end
	local r,g,b = 1,1,1
	if self.bRemoveTile then
		g = 0
		b = 0
	end
	self:renderBox3D(
		scenePos:x(), scenePos:y(), scenePos:z(),
		0.0, 0.0, 0.0,
		-0.5, 0.0, -0.5,
		0.5, 0.0, 0.5,
		r, g, b)
end

function AddTileTool:getFirstSelectedTile()
	local picker = self.editor.editMode.sceneTiles.tilePicker3.listBox
	return picker:getSingleSelectedTile()
end

function AddTileTool:uiToTileLocation(x, y)
	local scenePos = self.javaObject:uiToScene(x, y, 0, self.vector3f_1)
	scenePos:setComponent(0, Math.round(scenePos:x()))
	scenePos:setComponent(2, Math.round(scenePos:z()))
	return scenePos
end

function AddTileTool:mouseToTileLocation()
	local x,y = self:getMouseX(),self:getMouseY()
	local scenePos = self:uiToTileLocation(x, y)
	return scenePos:x(),scenePos:z()
end

function AddTileTool:renderBox3D(tx, ty, tz, rx, ry, rz, minX, minY, minZ, maxX, maxY, maxZ, r, g, b)
	self.editor.sceneTiles:renderBox3D(tx, ty, tz, rx, ry, rz, minX, minY, minZ, maxX, maxY, maxZ, r, g, b)
end

function AddTileTool:renderSceneTiles()
	local dx,dy = self:mouseToTileLocation()
	for dy1=-5,5 do
		for dx1=-5,5 do
			local tile = self.editor.sceneTiles:getTile(dx1, dy1)
			if tile then
				if dx1 == dx and dy1 == dy then
					-- see renderScene()
				else
					self:renderBox3D(tile.dx, 0, tile.dy, 0, 0, 0, -0.5, 0, -0.5, 0.5, 0, 0.5, 0.66, 0.66, 0.66)
					self.editor.sceneTiles:renderTile(tile.dx, tile.dy, tile.tileName)
				end
			end
		end
	end
end

function AddTileTool:new(editor)
	local o = Tool.new(self, editor)
	o.bRemoveTile = false
	o.vector3f_1 = Vector3f.new()
	return o
end

-----

TileGeometryEditor_MoveTileTool = Tool:derive("TileGeometryEditor_MoveTileTool")
local MoveTileTool = TileGeometryEditor_MoveTileTool

function MoveTileTool:onMouseDown(x, y)
	if not self.scene:isMouseOver() then return end
	local scenePos = self:uiToTileLocation(x, y)
	local dx = scenePos:x()
	local dy = scenePos:z()
	if dx < -5 or dx > 5 or dy < -5 or dy > 5 then return end
	local tile = self.editor.sceneTiles:getTile(dx, dy)
	if not tile then return end
	self.draggedTile = tile
	self.mouseDownX = x
	self.mouseDownY = y
end

function MoveTileTool:onMouseUp(x, y)
	if not self.draggedTile then return end
	local tile = self.draggedTile
	self.draggedTile = nil
	if not self.scene:isMouseOver() then return end
	local scenePos = self:uiToTileLocation(x, y)
	local dx = scenePos:x()
	local dy = scenePos:z()
	if dx < -5 or dx > 5 or dy < -5 or dy > 5 then return end
	self.editor.sceneTiles:removeTile(tile.dx, tile.dy)
	self.editor.sceneTiles:addTile(dx, dy, tile.tileName)
end

function MoveTileTool:uiToTileLocation(x, y)
	local scenePos = self.javaObject:uiToScene(x, y, 0, self.vector3f_1)
	scenePos:setComponent(0, Math.round(scenePos:x()))
	scenePos:setComponent(2, Math.round(scenePos:z()))
	return scenePos
end

function MoveTileTool:mouseToTileLocation()
	local x,y = self:getMouseX(),self:getMouseY()
	local scenePos = self:uiToTileLocation(x, y)
	return scenePos:x(),scenePos:z()
end

function MoveTileTool:renderScene()
	if not self.draggedTile then return end
	if not self.scene:isMouseOver() then return end
	local dx,dy = self:mouseToTileLocation()
	if dx < -5 or dx > 5 or dy < -5 or dy > 5 then return end
	if dx == 0 and dy == 0 then return end
	local tile = self.draggedTile
	self:renderBox3D(dx, 0, dy, 0, 0, 0, -0.5, 0, -0.5, 0.5, 0, 0.5, 0.66, 0.66, 0.66)
	self.editor.sceneTiles:renderTile(dx, dy, tile.tileName)
end

function MoveTileTool:renderSceneTiles()
	local dx,dy = self:mouseToTileLocation()
	for dy1=-5,5 do
		for dx1=-5,5 do
			local tile = self.editor.sceneTiles:getTile(dx1, dy1)
			if self.draggedTile ~= nil then
				if tile == self.draggedTile then
					tile = nil
				end
				if dx == dx1 and dy == dy1 then
					tile = nil
				end
			end
			if tile ~= nil then
				self:renderBox3D(tile.dx, 0, tile.dy, 0, 0, 0, -0.5, 0, -0.5, 0.5, 0, 0.5, 0.66, 0.66, 0.66)
				self.editor.sceneTiles:renderTile(tile.dx, tile.dy, tile.tileName)
			end
		end
	end
end

function MoveTileTool:renderBox3D(tx, ty, tz, rx, ry, rz, minX, minY, minZ, maxX, maxY, maxZ, r, g, b)
	self.editor.sceneTiles:renderBox3D(tx, ty, tz, rx, ry, rz, minX, minY, minZ, maxX, maxY, maxZ, r, g, b)
end

function MoveTileTool:new(editor)
	local o = Tool.new(self, editor)
	o.vector3f_1 = Vector3f.new()
	return o
end


