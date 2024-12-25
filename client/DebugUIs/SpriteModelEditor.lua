--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require('ISUI/ISScrollingListBox')
require('Vehicles/ISUI/ISUI3DScene')

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local Z_SCALE = 0.8164966666666666

local SCALE = 1.0

-- UI3DScene doesn't draw models scaled by 1.5 like it does for character models.
-- When a model is attached to a character model, it gets scaled by the character's 1.5 scale (in the attachment editor)
local ONE_POINT_FIVE = 1.0

SpriteModelEditor = ISPanel:derive("SpriteModelEditor")

-----

SpriteModelEditor_ListBox = ISScrollingListBox:derive("SpriteModelEditor_ListBox")
local ListBox = SpriteModelEditor_ListBox

function ListBox:prerender()
	ISScrollingListBox.prerender(self)
end

function ListBox:doDrawItem(y, item, alt)
	local text = item.text
	if item.text == "translate" then
		local translate = self.editor.scene:java1("getObjectTranslation", self.editor.scene.sceneModelName)
		text = string.format("translate %.3f,%.3f,%.3f", translate:x(), translate:y(), translate:z())
	end
	if item.text == "rotate" then
		local rotate = self.editor.scene:java1("getObjectRotation", self.editor.scene.sceneModelName)
		text = string.format("rotate %.3f,%.3f,%.3f", rotate:x(), rotate:y(), rotate:z())
	end
	if item.text == "scale" then
		local scale = self.editor.scene:java1("getObjectScale", self.editor.scene.sceneModelName)
		text = string.format("scale %.3f,%.3f,%.3f", scale:x() / ONE_POINT_FIVE, scale:y() / ONE_POINT_FIVE, scale:z() / ONE_POINT_FIVE)
	end
	if not item.height then item.height = self.itemheight end
	if self.selected == item.index then
		self:drawRect(0, y, self:getWidth(), item.height - 1, 0.3, 0.7, 0.35, 0.15);
	end
	self:drawRectBorder(0, y, self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	local itemPadY = self.itemPadY or (item.height - self.fontHgt) / 2
	self:drawText(text, 15, y + itemPadY, 0.9, 0.9, 0.9, 0.9, self.font);
	y = y + item.height;
	return y;
end

function ListBox:onMouseDown(x, y)
	ISScrollingListBox.onMouseDown(self, x, y)
end

function ListBox:indexOf(text)
	for i,item in ipairs(self.items) do
		if item.text == text then
			return i
		end
	end
	return -1
end

function ListBox:new(x, y, width, height)
	local o = ISScrollingListBox.new(self, x, y, width, height)
	return o
end

-----

SpriteModelEditor_OptionsPanel = ISPanel:derive("SpriteModelEditor_OptionsPanel")
local OptionsPanel = SpriteModelEditor_OptionsPanel

function OptionsPanel:createChildren()
	local tickBox = ISTickBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, "", self, self.onTickBox, option)
	tickBox:initialise()
	self:addChild(tickBox)
	local gameState = getSpriteModelEditorState()
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
		self.parent.scene:java1("setDrawGrid", selected)
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

SpriteModelEditor_Scene = ISUI3DScene:derive("SpriteModelEditor_Scene")
local Scene = SpriteModelEditor_Scene

function Scene:prerenderEditor()
	self:java1("setGizmoVisible", self.editPoints and "none" or self.gizmo)
	self:java1("setGizmoOrigin", "none")
	self:java1("setTransformMode", "Global")
	if not self.zeroVector then self.zeroVector = Vector3f.new() end
	self:java1("setGizmoPos", self.zeroVector)
	self:java1("setGizmoRotate", self.zeroVector)
	self:java0("clearAABBs")
	self:java0("clearAxes")
	self:java0("clearBox3Ds")
	self:java1("setDrawAttachments", true)
--[[
	self:java2("setGizmoAxisVisible", "X", true)
	self:java2("setGizmoAxisVisible", "Y", true)
	self:java2("setGizmoAxisVisible", "Z", true)
--]]
--	self.javaObject:fromLua1("setSelectedAttachment", nil)
end

function Scene:prerender()
	ISUI3DScene.prerender(self)
end

function Scene:render()
	ISUI3DScene.render(self)
	local picker = self.editor.tilePicker.listBox
	if not picker.selected then return end
	local tileName = string.format("%s_%d", picker.tileset, (picker.selected.col - 1) + (picker.selected.row - 1) * 8)
	local texture = getTexture(tileName)
	if not texture then return end
	local sx = self.javaObject:sceneToUIX(0.0, 0.0, 0.0)
	local sy = self.javaObject:sceneToUIY(0.0, 0.0, 0.0)
	local sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
	local sy2 = self.javaObject:sceneToUIY(1.0, 0.0, 0.0)
	local scale = math.sqrt((sx2 - sx) * (sx2 - sx) + (sy2 - sy) * (sy2 - sy)) / math.sqrt(32 * 32 + 64 * 64)
---[[
	self:drawTextureScaled(texture,
		sx - (64 - texture:getOffsetX()) * scale,
		sy - (256 - 32 - texture:getOffsetY()) * scale,
		texture:getWidth() * scale,
		texture:getHeight() * scale,
		1.0, 1.0, 1.0, 1.0)
--]]
	-- Bounding box around the tile
	self:drawRectBorder(sx - 64 * scale, sy - 256 * scale + 32 * scale, 128 * scale, 256 * scale, 1.0, 1.0, 1.0, 1.0)

	if tileName ~= self.selectedTileName then
		self.selectedTileName = tileName
--		self:java3("loadFromGeometryFile", picker.tileset, picker.selected.col - 1, picker.selected.row - 1)
--		self.editor:setGeometryList()
	end

	self:renderNorthWall()
	self:renderWestWall()
	self:renderTileName()
end

function Scene:onMouseDown(x, y)
	ISUI3DScene.onMouseDown(self, x, y)
	self.gizmoAxis = self.javaObject:fromLua2("testGizmoAxis", x, y)
	if self.gizmoAxis ~= "None" then
		local scenePos = self.javaObject:fromLua0("getGizmoPos")
		self.gizmoStartScenePos = Vector3f.new(scenePos)
		self.gizmoClickScenePos = self.javaObject:uiToScene(x, y, 0, Vector3f.new())
		self.javaObject:fromLua3("startGizmoTracking", x, y, self.gizmoAxis)
		self:onGizmoStart()
	end
	self.rotate = false -- not isKeyDown(Keyboard.KEY_LSHIFT)
end

function Scene:snapToFurniturePixel(x, y)
	local sx = self.javaObject:sceneToUIX(0.0, 0.0, 0.0)
	local sy = self.javaObject:sceneToUIY(0.0, 0.0, 0.0)
	local sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
	local sy2 = self.javaObject:sceneToUIY(1.0, 0.0, 0.0)
	local scale = math.sqrt((sx2 - sx) * (sx2 - sx) + (sy2 - sy) * (sy2 - sy)) / math.sqrt(32 * 32 + 64 * 64)
	local pixelSize = scale
	x = math.floor((x - sx) / pixelSize) * pixelSize + sx
	y = math.floor((y - sy) / pixelSize) * pixelSize + sy
	return x,y
end

function Scene:onMouseMove(dx, dy)
	if self.gizmoAxis ~= "None" then
		local x,y = self:getMouseX(),self:getMouseY()
		local newPos = self.javaObject:uiToScene(x, y, 0, Vector3f.new())
		newPos:sub(self.gizmoClickScenePos)
		newPos:add(self.gizmoStartScenePos)
		self:java2("dragGizmo", x, y)
		return
	end
	ISUI3DScene.onMouseMove(self, dx, dy)
end

function Scene:onMouseUp(x, y)
	ISUI3DScene.onMouseUp(self, x, y)
	if self.gizmoAxis ~= "None" then
		self.gizmoAxis = "None"
		self.javaObject:fromLua0("stopGizmoTracking")
		self:onGizmoAccept()
	end
	self.dragPointIndex = -1
	self.rotate = false
end

function Scene:onMouseUpOutside(x, y)
	self:onMouseUp()
end

function Scene:onRightMouseDown(x, y)
	if self.gizmoAxis ~= "None" then
		self.gizmoAxis = "None"
		self.javaObject:fromLua0("stopGizmoTracking")
--		self.mouseDown = false
		self:java1("setGizmoPos", self.gizmoStartScenePos)
		self:onGizmoCancel()
	end
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

function Scene:renderNorthWall()
	if not getSpriteModelEditorState():getBoolean("DrawNorthWall") then return end
	local r,g,b = 1,1,1
	self:renderBox3D(
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		-0.5, 0.0, -0.5,
		0.5, 3.0 * Z_SCALE, -0.5 + 0.0311 * 1.5,
		r, g, b)
end

function Scene:renderWestWall()
	if not getSpriteModelEditorState():getBoolean("DrawWestWall") then return end
	local r,g,b = 1,1,1
	self:renderBox3D(
		0.0, 0.0, 0.0,
		0.0, 0.0, 0.0,
		-0.5, 0.0, -0.5,
		-0.5 + 0.0311 * 1.5, 3.0 * Z_SCALE, 0.5,
		r, g, b)
end

function Scene:renderTileName()
	local picker = self.editor.tilePicker.listBox
	local tileName = string.format("%s_%d", picker.tileset, (picker.selected.col - 1) + (picker.selected.row - 1) * 8)
	if picker.tileset and picker:isMouseOver() then
		local col,row = picker:getColRowAt(picker:getMouseX(), picker:getMouseY())
		if col >= 1 and col <= 8 and row >= 1 then
			local tileIndex = (col - 1) + (row - 1) * 8
			tileName = string.format("%s_%d", picker.tileset, tileIndex)
		end
	end
	if not tileName then return end
	self:drawTextCentre(tileName, self.width / 2, self.height - UI_BORDER_SPACING - FONT_HGT_MEDIUM, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)
end

function Scene:onGizmoStart()
	self.originalTranslate = {}
	self.originalRotate = {}
	self.originalScale = {}
	local objectName = self.sceneModelName
	if self.gizmo == "translate" then
		local trans = Vector3f.new(self:java1("getObjectTranslation", objectName))
		self.originalTranslate[objectName] = trans
	end
	if self.gizmo == "rotate" then
		self.originalRotate[objectName] = Vector3f.new(self:java1("getObjectRotation", objectName))
	end
	if self.gizmo == "scale" then
		self.originalScale[objectName] = Vector3f.new(self:java1("getObjectScale", objectName)):mul(1 / ONE_POINT_FIVE)
	end
end

function Scene:onGizmoChanged(delta)
	if self.gizmoAxis == "None" then return end -- cancelled via onRightMouseDown
	local objectName = self.sceneModelName
	if self.gizmo == "translate" then
		local translation = self:java1("getObjectTranslation", objectName)
		translation:set(self.originalTranslate[objectName])
		translation:add(delta)
		local sx = self.javaObject:sceneToUIX(0.0, 0.0, 0.0)
		local sy = self.javaObject:sceneToUIY(0.0, 0.0, 0.0)
		local sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
		local sy2 = self.javaObject:sceneToUIY(1.0, 0.0, 0.0)
		local pixelScreenSize = math.sqrt((sx2 - sx) * (sx2 - sx) + (sy2 - sy) * (sy2 - sy)) / math.sqrt(64 * 64 + 32 * 32)
		if self.gizmoAxis == "X" then
			sx2 = self.javaObject:sceneToUIX(1.0, 0.0, 0.0)
			local xEqualsOnePixels = math.abs(sx2 - sx)
			xEqualsOnePixels = xEqualsOnePixels * 2
			local sceneDX = (pixelScreenSize / xEqualsOnePixels)
			translation:setComponent(0, math.floor(translation:x() / sceneDX) * sceneDX)
		elseif self.gizmoAxis == "Y" then
			sy2 = self.javaObject:sceneToUIY(0.0, 1.0, 0.0)
			local yEqualsOnePixels = math.abs(sy2 - sy)
			yEqualsOnePixels = yEqualsOnePixels * 2
			local sceneDY = (pixelScreenSize / yEqualsOnePixels)
			translation:setComponent(1, math.floor(translation:y() / sceneDY) * sceneDY)
		elseif self.gizmoAxis == "Z" then
			sx2 = self.javaObject:sceneToUIX(0.0, 0.0, 1.0)
			local zEqualsOnePixels = math.abs(sx2 - sx)
			zEqualsOnePixels = zEqualsOnePixels * 2
			local sceneDZ = (pixelScreenSize / zEqualsOnePixels)
			translation:setComponent(2, math.floor(translation:z() / sceneDZ) * sceneDZ)
		end
	end
	if self.gizmo == "rotate" then
		local rotation = self:java1("getObjectRotation", objectName)
		rotation:set(self.originalRotate[objectName])
		self:java2("applyDeltaRotation", rotation, delta)
	end
	if self.gizmo == "scale" then
		local scale = self:java1("getObjectScale", objectName)
		scale:set(self.originalScale[objectName])
		local xyz = math.max(delta:x(), delta:y(), delta:z())
		if delta:x() < 0 or delta:y() < 0 or delta:z() < 0 then
			xyz = math.min(delta:x(), delta:y(), delta:z())
		end
--		xyz = xyz * SCALE * ONE_POINT_FIVE
		scale:add(xyz, xyz, xyz)
		scale:mul(SCALE * ONE_POINT_FIVE)
	end
end

function Scene:onGizmoAccept()
	local objectName = self.sceneModelName
	local tileProperties = self.editor:getOrCreateTileProperties()
	if tileProperties then
		if self.gizmo == "translate" then
			tileProperties:getTranslate():set(self:java1("getObjectTranslation", objectName))
		end
		if self.gizmo == "rotate" then
			tileProperties:getRotate():set(self:java1("getObjectRotation", objectName))
		end
		if self.gizmo == "scale" then
			tileProperties:setScale(self:java1("getObjectScale", objectName):x() / ONE_POINT_FIVE)
		end
	end
end

function Scene:onGizmoCancel()
	local objectName = self.sceneModelName
	if self.gizmo == "translate" then
		local translate = self:java1("getObjectTranslation", objectName)
		translate:set(self.originalTranslate[objectName])
	end
	if self.gizmo == "rotate" then
		local rotation = self:java1("getObjectRotation", objectName)
		rotation:set(self.originalRotate[objectName])
	end
	if self.gizmo == "scale" then
		local scale = self:java1("getObjectScale", objectName)
		scale:set(self.originalScale[objectName]):mul(ONE_POINT_FIVE)
	end
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
	o.sceneModelName = "theModel"
	return o
end

-----

SpriteModelEditor_TileList = ISPanel:derive("SpriteModelEditor_TileList")
local TileList = SpriteModelEditor_TileList
local ROWS = 64

function TileList:onMouseDown(x, y)
	if not self.tileset then return end
	local col,row = self:getColRowAt(x, y)
	if self:isValidColRow(col, row) then
		self.selected = { col = col, row = row }
	else
		self.selected = nil
	end
end

function TileList:onRightMouseDown(x, y)
	if not self.tileset then return end
	local col,row = self:getColRowAt(x, y)
	if not self:isValidColRow(col, row) then return end
	self.selected = { col = col, row = row }
	local player = 0
	local context = ISContextMenu.get(player, self:getAbsoluteX() + x, self:getAbsoluteY() + y + self:getYScroll())
	context:removeFromUIManager()
	context:addToUIManager()
	context:addOption("Clear Selected Tile", self, self.onClearSelectedTiles)
end

function TileList:onClearSelectedTiles()
	if not self.selected then return end
	local scene = self.editor.scene
--	scene:java2("setModelScript", scene.sceneModelName, nil)
--	scene:java2("setModelSpriteModel", scene.sceneModelName, nil)
	getSpriteModelEditorState():fromLua4("clearTileProperties", self.editor.modID, self.tileset, self.selected.col - 1, self.selected.row - 1)
end

function TileList:onMouseWheel(del)
	self:setYScroll(self:getYScroll() - del * 64)
end

function TileList:render()
	if not self.tileset then return end

	local stencilX = 0
	local stencilY = 0
	local stencilX2 = self.width
	local stencilY2 = self.height

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
			local tileName = string.format("%s_%d", tilesetName, (col - 1) + (row - 1) * 8)
			local texture = getTexture(tileName)
			if texture then
				local tileProperties = getSpriteModelEditorState():fromLua4("getTileProperties", self.editor.modID, tilesetName, col - 1, row - 1)
				if tileProperties then
					self:drawRect(xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 0.2, 1.0, 1.0, 1.0)
				end
--				self:drawTextureScaledAspect(texture, xIndent + (col - 1) * texW, yIndent + (row - 1) * texH, texW, texH, 1.0, 1.0, 1.0, 1.0)
				self:drawTextureScaled(texture, xIndent + (col - 1) * texW + texture:getOffsetX() * scale, yIndent + (row - 1) * texH + texture:getOffsetY() * scale, texture:getWidth() * scale, texture:getHeight() * scale, 1.0, 1.0, 1.0, 1.0)
				maxRow = math.max(maxRow, row)
			end
		end
	end

	self:setScrollHeight(yIndent + maxRow * texH + yIndent)
--	self.vscroll:setX(self.width - self.vscroll.width)

	col = math.floor((self:getMouseX() - xIndent) / texW)
	row = math.floor((self:getMouseY() - yIndent) / texH)
	if col >= 0 and col < 8 and row >= 0 then
		self:drawRectBorder(xIndent + col * texW, yIndent + row * texH, texW, texH, 0.25, 1, 1, 1)
	end

	if self.selected then
		local col = self.selected.col - 1
		local row = self.selected.row - 1
		self:drawRectBorder(xIndent + col * texW, yIndent + row * texH, texW, texH, 0.5, 1, 1, 1)
	end

	self:clearStencilRect()
end

function TileList:setTileset(tilesetName)
	self.tileset = tilesetName
	self.selected = nil
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

function TileList:new(x, y, width, height, picker)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.a = 0.9
	o.picker = picker
	o.editor = picker.editor
	return o
end

-----

SpriteModelEditor_TilePicker = ISPanel:derive("SpriteModelEditor_TilePicker")
local TilePicker = SpriteModelEditor_TilePicker

function TilePicker:createChildren()
	local combo = ISComboBox:new(0, 0, self.width, BUTTON_HGT, self, self.onSelectTileset)
	combo.noSelectionText = "TILESET"
	combo:setEditable(true)
	self:addChild(combo)
	self.comboTileset = combo

	local tilesetNames = getWorld():getAllTilesName()
	for i=1,tilesetNames:size() do
		local tilesetName = tilesetNames:get(i-1)
		local tileNames = getWorld():getAllTiles(tilesetName)
--[[
		local hasBed = false
		for j=1,tileNames:size() do
			local sprite = getSprite(tileNames:get(j-1))
			if sprite and sprite:getProperties():Is(IsoFlagType.bed) then
				hasBed = true
				break
			end
		end
--]]
		hasBed = true
		if hasBed then
			self.comboTileset:addOption(tilesetName)
		end
	end

	local listY = combo:getBottom() + UI_BORDER_SPACING
	local listBox = TileList:new(0, listY, self.width, self.height - listY, self)
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

function TilePicker:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

function SpriteModelEditor:createChildren()
	local gameState = getSpriteModelEditorState()

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
	
	self.scene:java2("createModel", self.scene.sceneModelName, "RadioBlue_Ground")
	self.scene:java2("setModelSpriteModelEditor", self.scene.sceneModelName, true)
	self.scene:java1("getObjectScale", self.scene.sceneModelName):set(SCALE * ONE_POINT_FIVE)

	self:createToolbar()

	local belowHgt = BUTTON_HGT * 1 + UI_BORDER_SPACING * 6
	local bottomH = BUTTON_HGT + UI_BORDER_SPACING*2

	local listY = UI_BORDER_SPACING+1
	local listBox = ListBox:new(UI_BORDER_SPACING+1, listY, 300, math.min(self.height - bottomH - belowHgt - UI_BORDER_SPACING - listY, BUTTON_HGT * 8))
	listBox.editor = self
	listBox:setAnchorBottom(true)
	self:addChild(listBox)
	listBox:setFont(UIFont.Small, 3)
	self.listBox = listBox

	self.belowList = ISPanel:new(listBox:getX(), self.listBox:getBottom() + UI_BORDER_SPACING, self.listBox.width, belowHgt)
	self.belowList:noBackground()
	self:addChild(self.belowList)

	local button1 = ISButton:new(0, 0, self.belowList.width, BUTTON_HGT, "TRANSLATE", self, self.onToggleGizmo)
	self.belowList:addChild(button1)
	self.button1 = button1

	-----

	local combo = ISComboBox:new(UI_BORDER_SPACING+1, self.belowList:getBottom() + UI_BORDER_SPACING, self.listBox.width, BUTTON_HGT, self, self.onComboChooseModel)
	combo.noSelectionText = "CHOOSE MODEL"
	combo:setEditable(true)
	self:addChild(combo)
	self.comboChooseModel = combo 

	local scripts = getScriptManager():getAllModelScripts()
	local sorted = {}
	for i=1,scripts:size() do
		local script = scripts:get(i-1)
		table.insert(sorted, script:getFullType())
	end
	table.sort(sorted)
	for _,scriptName in ipairs(sorted) do
		combo:addOption(scriptName)
	end
	combo.selected = 0 -- CHOOSE MODEL

	-----

	combo = ISComboBox:new(UI_BORDER_SPACING+1, self.comboChooseModel:getBottom() + UI_BORDER_SPACING, self.listBox.width, BUTTON_HGT, self, self.onComboChooseAnimation)
	combo.noSelectionText = "NO ANIMATIONS"
	combo:setEditable(false)
	self:addChild(combo)
	self.comboChooseAnimation = combo 
	combo.selected = 0 -- CHOOSE MODEL
	combo:setEnabled(false)

	-----

	self.sliderAnimationTime = ISSliderPanel:new(UI_BORDER_SPACING+1, self.comboChooseAnimation:getBottom() + UI_BORDER_SPACING, self.listBox.width, BUTTON_HGT, self, self.onAnimationTimeChanged)
	self.sliderAnimationTime:setValues(0.0, 1.0, 0.01, 0.1)
	self.sliderAnimationTime:setCurrentValue(0.0, true)
	self:addChild(self.sliderAnimationTime)

	-----

	self.runtimeEntry = ISTextEntryBox:new("", UI_BORDER_SPACING+1, self.sliderAnimationTime:getBottom() + UI_BORDER_SPACING, self.listBox.width, BUTTON_HGT)
	self.runtimeEntry.font = UIFont.Medium
	self.runtimeEntry.onCommandEntered = function(self) self.parent:onRuntimeEntered() end
	self:addChild(self.runtimeEntry)

	-----

	local scrollbarWidth = 13
	local tilePickerWidth = 8 * 32 + scrollbarWidth
	local tilePickerTop = BUTTON_HGT+UI_BORDER_SPACING
	self.tilePicker = TilePicker:new(self.width - UI_BORDER_SPACING - tilePickerWidth-1, UI_BORDER_SPACING+tilePickerTop, tilePickerWidth, self.height - UI_BORDER_SPACING*2-2-tilePickerTop, self)
	self:addChild(self.tilePicker)

	self.bottomPanel = ISPanel:new(0, self.height - bottomH, 200, bottomH)
	self.bottomPanel:setAnchorTop(false)
	self.bottomPanel:setAnchorLeft(false)
	self.bottomPanel:setAnchorRight(false)
	self.bottomPanel:setAnchorBottom(true)
	self.bottomPanel:noBackground()
	self:addChild(self.bottomPanel)

	local button1 = ISButton:new(UI_BORDER_SPACING+1, self.bottomPanel.height - UI_BORDER_SPACING - BUTTON_HGT - 1, 80, BUTTON_HGT, "EXIT", self, self.onExit)
	self.bottomPanel:addChild(button1)

	local button2 = ISButton:new(button1:getRight() + UI_BORDER_SPACING, button1.y, 80, BUTTON_HGT, "SAVE", self, self.onSave)
	self.bottomPanel:addChild(button2)
	
	local button3 = ISButton:new(button2:getRight() + UI_BORDER_SPACING, button2.y, 80, BUTTON_HGT, "CREATE TILESET IMAGE", self, self.onCreateTilesetImage)
	self.buttonCreateTilesetImage = button3
	self.bottomPanel:addChild(button3)

	self.bottomPanel:shrinkWrap(0, 0, nil)

	self.listBox:addItem("translate")
	self.listBox:addItem("rotate")
	self.listBox:addItem("scale")
end

function SpriteModelEditor:createToolbar()
	self.toolBar = ISPanel:new(0, UI_BORDER_SPACING+1, 300, BUTTON_HGT)
	self.toolBar:noBackground()
	self:addChild(self.toolBar)

	self.comboModID = ISComboBox:new(0, 0, 200, BUTTON_HGT, self, self.onSelectModID)
	self.toolBar:addChild(self.comboModID)
	local modIDs = SpriteModelManager.getInstance():getModIDs()
	for i=1,modIDs:size() do
		self.comboModID:addOption(modIDs:get(i-1))
	end
	self.comboModID:setWidthToOptions()

	local button = ISButton:new(self.comboModID:getRight() + UI_BORDER_SPACING, 0, 60, BUTTON_HGT, "OPTIONS", self, self.onOptions)
	self.toolBar:addChild(button)
	self.buttonOptions = button

	self.toolBar:shrinkWrap(0, 0, nil)
	self.toolBar:setX(self.width / 2 - self.toolBar.width / 2)

	self.optionsPanel = OptionsPanel:new(0, 0, 300, 400)
	self.optionsPanel:setVisible(false)
	self:addChild(self.optionsPanel)
end

function SpriteModelEditor:onToggleGizmo()
    if self.scene.gizmo == "translate" then
        self.listBox.selected = 2
    elseif self.scene.gizmo == "rotate" then
        self.listBox.selected = 3
    else
        self.listBox.selected = 1
    end
end

function SpriteModelEditor:onComboChooseModel()
	local scriptName = self.comboChooseModel:getOptionText(self.comboChooseModel.selected)
--	self.comboAddModel.selected = 0 -- CHOOSE MODEL
	self.scene:java2("setModelScript", self.scene.sceneModelName, scriptName)
	self.scene:java1("getObjectScale", self.scene.sceneModelName):set(SCALE * ONE_POINT_FIVE)

	local tileProperties = self:getOrCreateTileProperties()
	if tileProperties then
		tileProperties:setModelScriptName(scriptName)
		local picker = self.tilePicker.listBox
		if picker.selected then
			self.scene:java2("setModelSpriteModel", self.scene.sceneModelName, tileProperties)
		end
	end
end

function SpriteModelEditor:onComboChooseAnimation()
	local combo = self.comboChooseAnimation
	local animationName = combo:getOptionText(combo.selected)
	local tileProperties = self:getTileProperties()
	if tileProperties == nil then
		return
	end
	tileProperties:setAnimationName(animationName)
end

function SpriteModelEditor:onAnimationTimeChanged(time, slider)
	if self.tilePicker == nil then return end -- in createChildren()
	local tileProperties = self:getTileProperties()
	if tileProperties == nil then
		return
	end
	if tileProperties:getAnimationName() == nil then
		return
	end
	tileProperties:setAnimationTime(time)
end

function SpriteModelEditor:syncChooseModelCombo()
	local tileProperties = self:getTileProperties()
	if tileProperties then
		local modelScriptName = tileProperties:getModelScriptName()
		if modelScriptName and (self.comboChooseModel:getOptionText(self.comboChooseModel.selected) ~= modelScriptName) then
			self.comboChooseModel:select(modelScriptName)
		elseif not modelScriptName then
			self.comboChooseModel.selected = 0 -- CHOOSE MODEL
		end
		if modelScriptName and (self.currentModelScriptName ~= modelScriptName) then
			self.currentModelScriptName = modelScriptName
			if getScriptManager():getModelScript(modelScriptName) == nil then
				modelScriptName = nil
			end
			self.scene:java2("setModelScript", self.scene.sceneModelName, modelScriptName or "Base.PiePumpkin")
			if modelScriptName then
				local clipNames = getSpriteModelEditorState():fromLua1("getClipNames", modelScriptName)
				if clipNames ~= nil and not clipNames:isEmpty() then
					if not clipNames:contains(tileProperties:getAnimationName()) then
						tileProperties:setAnimationName(clipNames:get(0))
					end
				end
			end
		end

		local picker = self.tilePicker.listBox
		if picker.selected then
			self.scene:java2("setModelSpriteModel", self.scene.sceneModelName, tileProperties)
		end
	else
		self.currentModelScriptName = nil
		self.comboChooseModel.selected = 0 -- CHOOSE MODEL
		self.scene:java2("setModelSpriteModel", self.scene.sceneModelName, nil)
	end
end

function SpriteModelEditor:syncChooseAnimationCombo()
	local tileProperties = self:getTileProperties()
	if tileProperties == nil then
		self.animationComboModelScriptName = nil
		self.animationComboTileProperties = nil
		self:setSelectedAnimation(nil)
		return
	end
	local modelScriptName = tileProperties:getModelScriptName()
	if tileProperties == self.animationComboTileProperties and modelScriptName == self.animationComboModelScriptName then
		return
	end
	self.animationComboTileProperties = tileProperties
	self.animationComboModelScriptName = modelScriptName
	if modelScriptName == nil then
		self:setSelectedAnimation(nil)
		return
	end
	local modelScript = getScriptManager():getModelScript(modelScriptName)
	if modelScript == nil then
		self:setSelectedAnimation(nil)
		return
	end
	if modelScript:isStatic() then
		self:setSelectedAnimation(nil)
		return
	end
	local clipNames = getSpriteModelEditorState():fromLua1("getClipNames", modelScriptName)
	self.comboChooseAnimation:clear()
	for i=1,clipNames:size() do
		local clipName = clipNames:get(i-1)
		self.comboChooseAnimation:addOption(clipName)
	end
	local animationName = tileProperties:getAnimationName()
	self:setSelectedAnimation(animationName)
end

function SpriteModelEditor:setSelectedAnimation(animationName)
	local combo = self.comboChooseAnimation
	if animationName then
		combo.noSelectionText = "CHOOSE ANIMATION"
		combo:setEnabled(true)
		if combo:getOptionText(combo.selected) ~= animationName then
			combo:select(animationName)
		end
	else
		if not combo:isEmpty() then
			combo:clear()
			combo.noSelectionText = "NO ANIMATIONS"
			combo.selected = 0 -- CHOOSE ANIMATION
			combo:setEnabled(false)
		end
	end
end

function SpriteModelEditor:syncAnimationTimeSlider()
	if self.sliderAnimationTime.dragInside then return end
	local tileProperties = self:getTileProperties()
	if tileProperties == nil then
		self.sliderAnimationTime:setCurrentValue(0.0, true)
		return
	end
	if tileProperties:getAnimationName() == nil then
		self.sliderAnimationTime:setCurrentValue(0.0, true)
		return
	end
	self.sliderAnimationTime:setCurrentValue(tileProperties:getAnimationTime(), true)
end

function SpriteModelEditor:syncRuntimeEntry()
	local tileProperties = self:getTileProperties()
--	self.runtimeEntry:setEditable(tileProperties ~= nil)
	if self.runtimeEntryProperties == tileProperties then return end
	self.runtimeEntryProperties = tileProperties
	if (tileProperties == nil) or (tileProperties:getRuntimeString() == nil) then
		self.runtimeEntry:clear()
		return
	end
	self.runtimeEntry:setText(tileProperties:getRuntimeString())
end

function SpriteModelEditor:onRuntimeEntered()
	local tileProperties = self:getOrCreateTileProperties()
	local runtimeString = self.runtimeEntry:getText()
	if tileProperties then
		tileProperties:setRuntimeString(runtimeString)
		local picker = self.tilePicker.listBox
		tileProperties:parseRuntimeString(picker.tileset, picker.selected.col - 1, picker.selected.row - 1, runtimeString)
		self.selectedTileProperties = nil
		self.currentModelScriptName = nil
		self.animationComboModelScriptName = nil
	end
end

function SpriteModelEditor:resetView()
	self.scene:setView("UserDefined")
	local gameState = getSpriteModelEditorState()
	self.scene:java3("setViewRotation", 30.0, 45.0 + 270, 0.0)
	self.scene:java1("setGridPlane", "XZ")
end

function SpriteModelEditor:onResolutionChange(oldw, oldh, neww, newh)
	self:setWidth(neww)
	self:setHeight(newh)
	self.bottomPanel:setX(self.width / 2 - self.bottomPanel.width / 2)
end

function SpriteModelEditor:update()
	ISPanel.update(self)
	if self.width ~= getCore():getScreenWidth() or self.height ~= getCore():getScreenHeight() then
		self:onResolutionChange(self.width, self.height, getCore():getScreenWidth(), getCore():getScreenHeight())
	end
end

function SpriteModelEditor:prerender()
	ISPanel.prerender(self)

	if self.listBox.selected == 1 then
		self.scene.gizmo = "translate"
		self.button1.title = "TRANSLATE"
	end
	if self.listBox.selected == 2 then
		self.scene.gizmo = "rotate"
		self.button1.title = "ROTATE"
	end
	if self.listBox.selected == 3 then
		self.scene.gizmo = "scale"
		self.button1.title = "SCALE"
	end

	self.scene:prerenderEditor()
	
	self:syncChooseModelCombo()
	self:syncChooseAnimationCombo()
	self:syncAnimationTimeSlider()
	self:syncRuntimeEntry()
	self.buttonCreateTilesetImage:setEnable(self.tilePicker.listBox.selected ~= nil)
	
	local tileProperties = self:getTileProperties()
	if tileProperties ~= self.selectedTileProperties then
		self.selectedTileProperties = tileProperties
		if tileProperties then
			local modelScriptName = tileProperties:getModelScriptName()
			if getScriptManager():getModelScript(modelScriptName) == nil then
				modelScriptName = "Base.PiePumpkin"
			end
			self.scene:java2("setModelScript", self.scene.sceneModelName, modelScriptName)
			self.scene:java1("getObjectTranslation", self.scene.sceneModelName):set(tileProperties:getTranslate())
			self.scene:java1("getObjectRotation", self.scene.sceneModelName):set(tileProperties:getRotate())
			self.scene:java1("getObjectScale", self.scene.sceneModelName):set(tileProperties:getScale() * ONE_POINT_FIVE)
		else
			self.scene:java2("setModelScript", self.scene.sceneModelName, "Base.PiePumpkin")
			self.scene:java1("getObjectTranslation", self.scene.sceneModelName):set(0.0)
			self.scene:java1("getObjectRotation", self.scene.sceneModelName):set(0.0)
			self.scene:java1("getObjectScale", self.scene.sceneModelName):set(SCALE * ONE_POINT_FIVE)
		end
	end

	local translate = self.scene:java1("getObjectTranslation", self.scene.sceneModelName)
	local rotate = self.scene:java1("getObjectRotation", self.scene.sceneModelName)
	self.scene:java6("addAxis", translate:x(), translate:y(), translate:z(), rotate:x(), rotate:y(), rotate:z())

	local ZSCALE = 2.45 -- Magic number, how's this calculated?
	local rgb = 0.66
	self.scene:java9("addAABB", 0.0, ZSCALE / 2, 0.0, 1.0, ZSCALE, 1.0, rgb, rgb, rgb)
	self.scene:java9("addAABB", 0.0, ZSCALE / 3, 0.0, 1.0, 0.0, 1.0, rgb, rgb, rgb)
	self.scene:java9("addAABB", 0.0, (ZSCALE / 3) * 2, 0.0, 1.0, 0.0, 1.0, rgb, rgb, rgb)

	self.scene:java6("addAABB", translate:x(), translate:y(), translate:z(), 1.0, 0.0, 1.0)

	self.tempTranslate = self.tempTranslate or Vector3f.new()
	self.tempExtents = self.tempExtents or Vector3f.new()

	self.scene:java1("setGizmoPos", self.scene:java1("getObjectTranslation", self.scene.sceneModelName))
	self.scene:java1("setGizmoRotate", self.scene:java1("getObjectRotation", self.scene.sceneModelName))
--	self.scene:java1("setGizmoVisible", "rotate")
--	self.scene:java3("setGizmoXYZ", 1.0, 0.0, 0.0)
end

function SpriteModelEditor:render()
	ISPanel.render(self)
end

function SpriteModelEditor:getTileProperties()
	local picker = self.tilePicker.listBox
	if not picker.selected then return nil end
	local tileName = string.format("%s_%d", picker.tileset, (picker.selected.col - 1) + (picker.selected.row - 1) * 8)
	local texture = getTexture(tileName)
	if not texture then return nil end
	return getSpriteModelEditorState():fromLua4("getTileProperties", self.modID, picker.tileset, picker.selected.col - 1, picker.selected.row - 1)
end

function SpriteModelEditor:getOrCreateTileProperties()
	local picker = self.tilePicker.listBox
	if not picker.selected then return nil end
	local tileName = string.format("%s_%d", picker.tileset, (picker.selected.col - 1) + (picker.selected.row - 1) * 8)
	local texture = getTexture(tileName)
	if not texture then return nil end
	return getSpriteModelEditorState():fromLua4("getOrCreateTileProperties", self.modID, picker.tileset, picker.selected.col - 1, picker.selected.row - 1)
end

function SpriteModelEditor:onKeyPress(key)
	if key == Keyboard.KEY_Z then
		local tileProperties = self:getTileProperties()
		local axis = self.scene.gizmoAxis
		if self.scene.gizmo == "translate" then
			local xln = self.scene:java1("getObjectTranslation", self.scene.sceneModelName)
			if axis == "None" then
				xln:set(0.0)
			elseif axis == "X" then
				xln:setComponent(0, 0.0)
			elseif axis == "Y" then
				xln:setComponent(1, 0.0)
			elseif axis == "Z" then
				xln:setComponent(2, 0.0)
			end
			if tileProperties then
				tileProperties:getTranslate():set(xln)
			end
		end
		if self.scene.gizmo == "rotate" then
			self.scene:java1("getObjectRotation", self.scene.sceneModelName):set(0.0)
			if tileProperties then
				tileProperties:getRotate():set(0.0)
			end
		end
		if self.scene.gizmo == "scale" then
			self.scene:java1("getObjectScale", self.scene.sceneModelName):set(1.0 * ONE_POINT_FIVE)
			if tileProperties then
				tileProperties:setScale(1.0)
			end
		end
	end
end

function SpriteModelEditor:onOptions()
	self.optionsPanel:setX(self.buttonOptions:getAbsoluteX())
	self.optionsPanel:setY(self.buttonOptions:getAbsoluteY() + self.buttonOptions:getHeight())
	self.optionsPanel:setVisible(true)
end

function SpriteModelEditor:onExit(button, x, y)
	getSpriteModelEditorState():fromLua0("exit")
end

function SpriteModelEditor:onSave(button, x, y)
	getSpriteModelEditorState():fromLua1("writeSpriteModelsFile", self.modID)
	SpriteModelManager.getInstance():initSprites()
end

function SpriteModelEditor:onCreateTilesetImage(button, x, y)
	local picker = self.tilePicker.listBox

	local x = (getCore():getScreenWidth() - 400) / 2
	local y = (getCore():getScreenHeight() - 180) / 2
	local modal = ISTextBox:new(x, y, 400, 180, "PNG File Path:", string.format("C:\\%s.png", picker.tileset), self, self.onCreateTilesetImage2, nil)
	modal:initialise()
	modal:addToUIManager()
	modal:setAlwaysOnTop(true)
end

function SpriteModelEditor:onCreateTilesetImage2(button)
	if button.internal ~= "OK" then return end
	local picker = self.tilePicker.listBox
	local filePath = button.parent.entry:getText()
	getSpriteModelEditorState():fromLua3("saveTilesetImage", self.modID, picker.tileset, filePath)
end

-- Called from Java
function SpriteModelEditor:showUI()
end

function SpriteModelEditor:new(x, y, width, height)
	local o = ISPanel.new(self, x, y, width, height)
	o:setAnchorRight(true)
	o:setAnchorBottom(true)
	o:noBackground()
	o:setWantKeyEvents(true)
	o.modID = "game"
	getSpriteModelEditorState():setTable(o)
	return o
end

-- Called from Java
function SpriteModelEditor_InitUI()
	local UI = SpriteModelEditor:new(0, 0, getCore():getScreenWidth(), getCore():getScreenHeight())
	SpriteModelEditor_UI = UI
	UI:setVisible(true)
	UI:addToUIManager()
end
