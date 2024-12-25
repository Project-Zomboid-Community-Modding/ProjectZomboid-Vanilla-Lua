--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local entryWidth = getTextManager():MeasureStringX(UIFont.Small, "-999.9999") + UI_BORDER_SPACING*2

local TEXTURE_OFFSET_X = 1
local Z_SCALE = 0.8164966666666666

-----

TileGeometryEditor_ListBox = ISScrollingListBox:derive("TileGeometryEditor_ListBox")
local ListBox = TileGeometryEditor_ListBox

function ListBox:prerender()
	ISScrollingListBox.prerender(self)
end

function ListBox:doDrawItem(y, item, alt)
    return ISScrollingListBox.doDrawItem(self, y, item, alt)
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

TileGeometryEditor_GeometryListBox = ListBox:derive("TileGeometryEditor_GeometryListBox")
local GeometryListBox = TileGeometryEditor_GeometryListBox

function GeometryListBox:onRightMouseDown(x, y)
	local row = self:rowAt(x, y)
	local item = self.items[row]
	if not item then return end
	local objectName = item.item
	if objectName == "character1" then return end
	local player = 0
	local context = ISContextMenu.get(player, self:getAbsoluteX() + x, self:getAbsoluteY() + y + self:getYScroll())
	context:removeFromUIManager()
	context:addToUIManager()
	if self.scene:java1("getGeometryType", objectName) == "polygon" then
		context:addOption("Polygon To Pixels", self.editor, self.editor.onPolygonToPixels, objectName)
	elseif self.scene:java1("getGeometryType", objectName) ~= nil then
		context:addOption("Geometry To Pixels", self.editor, self.editor.onGeometryToPixels, objectName)
	end
	if self.scene:java1("getGeometryType", objectName) ~= nil then
		context:addOption("Duplicate Object", self.editor, self.editor.onDuplicateObject, objectName)
	end
--	context:addOption("XXX", self, self.onXXX)
--	context:addOption("XXX", self, self.onXXX)
end

function GeometryListBox:new(x, y, width, height, editor)
	local o = ListBox.new(self, x, y, width, height)
	o.editor = editor
	o.scene = editor.scene
	return o
end

-----

TileGeometryEditor_BoxPanel = ISPanel:derive("TileGeometryEditor_BoxPanel")
local BoxPanel = TileGeometryEditor_BoxPanel

function BoxPanel:createChildren()
	self.extentBoxes = {}

	local entry = self:createEntry(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, entryWidth, BUTTON_HGT, "xMin")
	entry = self:createEntry(entry:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING+1, entryWidth, BUTTON_HGT, "xMax")

	entry = self:createEntry(UI_BORDER_SPACING+1, entry:getBottom() + UI_BORDER_SPACING, entryWidth, BUTTON_HGT, "yMin")
	entry = self:createEntry(entry:getRight() + UI_BORDER_SPACING, entry:getY(), entryWidth, BUTTON_HGT, "yMax")

	entry = self:createEntry(UI_BORDER_SPACING+1, entry:getBottom() + UI_BORDER_SPACING, entryWidth, BUTTON_HGT, "zMin")
	entry = self:createEntry(entry:getRight() + UI_BORDER_SPACING, entry:getY(), entryWidth, BUTTON_HGT, "zMax")

	self:shrinkWrap(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, nil)
end

function BoxPanel:createEntry(x, y, w, h, id)
	local entry = ISTextEntryBox:new("", x, y, w, h)
	entry:initialise()
	entry:instantiate()
	entry.min = 0
	entry:setOnlyNumbers(true)
	entry.onCommandEntered = function(self) self.parent:onTextEntered(self, id) end
	self:addChild(entry)
	self.extentBoxes[id] = entry
	return entry
end

function BoxPanel:onTextEntered(entry, id)
	local objectName = self.scene.selectedObjectName
	if id == "xMin" then
		self.scene:java1("getBoxMinExtents", objectName):setComponent(0, tonumber(entry:getText()))
	elseif id == "xMax" then
		self.scene:java1("getBoxMaxExtents", objectName):setComponent(0, tonumber(entry:getText()))
	elseif id == "yMin" then
		self.scene:java1("getBoxMinExtents", objectName):setComponent(1, tonumber(entry:getText()))
	elseif id == "yMax" then
		self.scene:java1("getBoxMaxExtents", objectName):setComponent(1, tonumber(entry:getText()))
	elseif id == "zMin" then
		self.scene:java1("getBoxMinExtents", objectName):setComponent(2, tonumber(entry:getText()))
	elseif id == "zMax" then
		self.scene:java1("getBoxMaxExtents", objectName):setComponent(2, tonumber(entry:getText()))
	end
	self.editor:updateGeometryFile()
end

function BoxPanel:render()
	ISPanel.render(self)
	local objectName = self.scene.selectedObjectName
	if not self.scene:java1("getObjectExists", objectName) then
		return
	end
	if self.scene:java1("getGeometryType", objectName) ~= "box" then
		return
	end
	local xyz = self.scene:java1("getObjectTranslation", objectName)
	local min = self.scene:java1("getBoxMinExtents", objectName)
	local max = self.scene:java1("getBoxMaxExtents", objectName)
	local text = string.format("%.4f", xyz:x())
	if self.extentBoxes.xMin:isFocused() then
		text = string.format("%.4f", xyz:x() + min:x())
	end
	if self.extentBoxes.xMax:isFocused() then
		text = string.format("%.4f", xyz:x() + max:x())
	end
	local x = self.x + self.width + UI_BORDER_SPACING
	local y = self.y + self.extentBoxes.xMax.y
	local r,g,b,a = 1.0,1.0,1.0,1.0
	local font = UIFont.Small
	self.editor:drawText(text, x, y, r, g, b, a, font)

	text = string.format("%.4f", xyz:y())
	if self.extentBoxes.yMin:isFocused() then
		text = string.format("%.4f", xyz:y() + min:y())
	end
	if self.extentBoxes.yMax:isFocused() then
		text = string.format("%.4f", xyz:y() + max:y())
	end
	y = self.y + self.extentBoxes.yMax.y
	self.editor:drawText(text, x, y, r, g, b, a, font)

	text = string.format("%.4f", xyz:z())
	if self.extentBoxes.zMin:isFocused() then
		text = string.format("%.4f", xyz:z() + min:z())
	end
	if self.extentBoxes.zMax:isFocused() then
		text = string.format("%.4f", xyz:z() + max:z())
	end
	y = self.y + self.extentBoxes.zMax.y
	self.editor:drawText(text, x, y, r, g, b, a, font)
end

function BoxPanel:toUI()
	local objectName = self.scene.selectedObjectName
	local min = self.scene:java1("getBoxMinExtents", objectName)
	local max = self.scene:java1("getBoxMaxExtents", objectName)
	if not self.extentBoxes.xMin:isFocused() then
		self.extentBoxes.xMin:setText(tostring(round(min:x(), 4)))
	end
	if not self.extentBoxes.xMax:isFocused() then
		self.extentBoxes.xMax:setText(tostring(round(max:x(), 4)))
	end

	if not self.extentBoxes.yMin:isFocused() then
		self.extentBoxes.yMin:setText(tostring(round(min:y(), 4)))
	end
	if not self.extentBoxes.yMax:isFocused() then
		self.extentBoxes.yMax:setText(tostring(round(max:y(), 4)))
	end

	if not self.extentBoxes.zMin:isFocused() then
		self.extentBoxes.zMin:setText(tostring(round(min:z(), 4)))
	end
	if not self.extentBoxes.zMax:isFocused() then
		self.extentBoxes.zMax:setText(tostring(round(max:z(), 4)))
	end
end

function BoxPanel:configGizmo()
	local objectName = self.scene.selectedObjectName
	if not luautils.stringStarts(objectName, "box") then
		return false
	end
	if not self.scene:java1("getObjectExists", objectName) then
		return false
	end
	local min = self.scene:java1("getBoxMinExtents", objectName)
	local max = self.scene:java1("getBoxMaxExtents", objectName)
	if self.scene.currentTool == self.scene.tools.resizeBox then
		self.extentBoxes[self.movingFace]:focus()
		if self.movingFace == "xMin" then
			self:configGizmoAux(self.movingFace, min:x(), 0, 0)
		elseif self.movingFace == "xMax" then
			self:configGizmoAux(self.movingFace, max:x(), 0, 0)
		elseif self.movingFace == "yMin" then
			self:configGizmoAux(self.movingFace, 0, min:y(), 0)
		elseif self.movingFace == "yMax" then
			self:configGizmoAux(self.movingFace, 0, max:y(), 0)
		elseif self.movingFace == "zMin" then
			self:configGizmoAux(self.movingFace, 0, 0, min:z())
		elseif self.movingFace == "zMax" then
			self:configGizmoAux(self.movingFace, 0, 0, max:z())
		end
		return true
	end
	self.movingFace = nil
	if self.extentBoxes.xMin:isFocused() then
		self:configGizmoAux("xMin", min:x(), 0, 0)
		return true
	end
	if self.extentBoxes.xMax:isFocused() then
		self:configGizmoAux("xMax", max:x(), 0, 0)
		return true
	end
	if self.extentBoxes.yMin:isFocused() then
		self:configGizmoAux("yMin", 0, min:y(), 0)
		return true
	end
	if self.extentBoxes.yMax:isFocused() then
		self:configGizmoAux("yMax", 0, max:y(), 0)
		return true
	end
	if self.extentBoxes.zMin:isFocused() then
		self:configGizmoAux("zMin", 0, 0, min:z())
		return true
	end
	if self.extentBoxes.zMax:isFocused() then
		self:configGizmoAux("zMax", 0, 0, max:z())
		return true
	end
	return false
end

function BoxPanel:configGizmoAux(face, extentX, extentY, extentZ)
	local objectName = self.scene.selectedObjectName
	self.scene.gizmo = "translate"
	self.scene:java3("setGizmoOrigin", "geometry", objectName, face)
--	self.scene:java1("setGizmoPos", Vector3f.new(extentX, extentY, extentZ))
	self.scene:java2("setGizmoAxisVisible", "X", face == "xMin" or face == "xMax")
	self.scene:java2("setGizmoAxisVisible", "Y", face == "yMin" or face == "yMax")
	self.scene:java2("setGizmoAxisVisible", "Z", face == "zMin" or face == "zMax")
	self.movingFace = face
end

function BoxPanel:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o.editor = editor
	o.scene = editor.scene
	o.movingFace = nil
	return o
end

-----

TileGeometryEditor_CylinderPanel = ISPanel:derive("TileGeometryEditor_CylinderPanel")
local CylinderPanel = TileGeometryEditor_CylinderPanel

function CylinderPanel:createChildren()
	self.radiusEntry = self:createEntry(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, entryWidth, BUTTON_HGT, "radius")
	self.zMinEntry = self:createEntry(UI_BORDER_SPACING+1, self.radiusEntry:getBottom() + UI_BORDER_SPACING, entryWidth, BUTTON_HGT, "zMin")
	self.zMaxEntry = self:createEntry(self.zMinEntry:getRight() + UI_BORDER_SPACING, self.zMinEntry.y, entryWidth, BUTTON_HGT, "zMax")
	self:shrinkWrap(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, nil)
end

function CylinderPanel:createEntry(x, y, w, h, id)
	local entry = ISTextEntryBox:new("", x, y, w, h)
	entry:initialise()
	entry:instantiate()
	entry.min = 0
	entry:setOnlyNumbers(true)
	entry.onCommandEntered = function(self) self.parent:onTextEntered(self, id) end
	self:addChild(entry)
	return entry
end

function CylinderPanel:onTextEntered(entry, id)
	local objectName = self.scene.selectedObjectName
	if id == "radius" then
		self.scene:java2("setCylinderRadius", objectName, tonumber(entry:getText()))
	end
	if id == "zMax" then
--		self.scene:java2("setCylinderHeight", objectName, tonumber(entry:getText()))
		self.scene:java3("changeCylinderHeight", objectName, id, tonumber(entry:getText()))
	end
	self.editor:updateGeometryFile()
end

function CylinderPanel:render()
	ISPanel.render(self)
end

function CylinderPanel:toUI()
	local objectName = self.scene.selectedObjectName
	local toolActive = self.scene.currentTool == self.scene.tools.resizeCylinder
	if not self.radiusEntry:isFocused() or toolActive then
		self.radiusEntry:setText(tostring(round(self.scene:java1("getCylinderRadius", objectName), 3)))
	end
	if not self.zMinEntry:isFocused() or toolActive then
		self.zMinEntry:setText(tostring(round(0.0, 3)))
	end
	if not self.zMaxEntry:isFocused() or toolActive then
		self.zMaxEntry:setText(tostring(round(self.scene:java1("getCylinderHeight", objectName), 3)))
	end
end

function CylinderPanel:configGizmo()
	local objectName = self.scene.selectedObjectName
	if not self.scene:java1("getObjectExists", objectName) then
		return false
	end
	if self.scene:java1("getGeometryType", objectName) ~= "cylinder" then
		return false
	end
	local radius = self.scene:java1("getCylinderRadius", objectName)
	local height = self.scene:java1("getCylinderHeight", objectName)
	if self.scene.currentTool == self.scene.tools.resizeCylinder then
		if self.movingFace == "xMax" then
			self.radiusEntry:focus()
			self:configGizmoAux(self.movingFace)
		elseif self.movingFace == "zMin" then
			self.zMinEntry:focus()
			self:configGizmoAux(self.movingFace)
		elseif self.movingFace == "zMax" then
			self.zMaxEntry:focus()
			self:configGizmoAux(self.movingFace)
		end
		return true
	end
	self.movingFace = nil
	if self.radiusEntry:isFocused() then
		self:configGizmoAux("xMax")
		return true
	end
	if self.zMinEntry:isFocused() then
		self:configGizmoAux("zMin")
		return true
	end
	if self.zMaxEntry:isFocused() then
		self:configGizmoAux("zMax")
		return true
	end
	return false
end

function CylinderPanel:configGizmoAux(face)
	local objectName = self.scene.selectedObjectName
	self.scene.gizmo = "translate"
	self.scene:java3("setGizmoOrigin", "geometry", objectName, face)
--	self.scene:java1("setGizmoPos", Vector3f.new(extentX, extentY, extentZ))
	self.scene:java2("setGizmoAxisVisible", "X", face == "xMin" or face == "xMax")
	self.scene:java2("setGizmoAxisVisible", "Y", face == "yMin" or face == "yMax")
	self.scene:java2("setGizmoAxisVisible", "Z", face == "zMin" or face == "zMax")
	self.movingFace = face
end

function CylinderPanel:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o.editor = editor
	o.scene = editor.scene
	return o
end

-----

TileGeometryEditor_PropertiesPanel = ISPanel:derive("TileGeometryEditor_PropertiesPanel")
local PropertiesPanel = TileGeometryEditor_PropertiesPanel

function PropertiesPanel:createChildren()
	local label = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, FONT_HGT_SMALL, "Surface Property", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.surfaceEntry = self:createEntry(label:getRight() + UI_BORDER_SPACING, label.y, 64, BUTTON_HGT, "Surface")

	label = ISLabel:new(UI_BORDER_SPACING+1, self.surfaceEntry:getBottom() + UI_BORDER_SPACING, FONT_HGT_SMALL, "ItemHeight Property", 1, 1, 1, 1, UIFont.Small, true)
	self:addChild(label)
	self.itemHeightEntry = self:createEntry(label:getRight() + UI_BORDER_SPACING, label.y, 64, BUTTON_HGT, "ItemHeight")

	local tickBox = ISTickBox:new(UI_BORDER_SPACING+1, self.itemHeightEntry:getBottom() + UI_BORDER_SPACING, 120, BUTTON_HGT, "", self, self.onTickBox)
	tickBox:initialise()
	tickBox:instantiate()
	self:addChild(tickBox)
	tickBox:addOption("Opaque Pixels Only", "OpaquePixelsOnly")
	tickBox:addOption("Translucent", "Translucent")
	tickBox:addOption("Use Object Depth Texture", "UseObjectDepthTexture")
	tickBox:setWidthToFit()
	self.tickBox = tickBox

	self:shrinkWrap(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, nil)
end

function PropertiesPanel:createEntry(x, y, w, h, id)
	local entry = ISTextEntryBox:new("", x, y, w, h)
	entry:initialise()
	entry:instantiate()
	entry.min = 0
	entry:setOnlyNumbers(true)
--	entry.onCommandEntered = function(self) self.parent:onTextEntered(self, id) end
	self:addChild(entry)
	return entry
end

function PropertiesPanel:onTickBox(index, selected, tickBox)
	local propertyName = self.tickBox:getOptionData(index)
	local value = selected and "true" or nil
	local picker = self.editor.tilePicker.listBox
	local selection = picker:getSelection()
	for _,e in ipairs(selection.elements) do
		TileGeometryManager.getInstance():setTileProperty(self.editor.modID, picker.tileset, e.col - 1, e.row - 1, propertyName, value)
	end
end

function PropertiesPanel:toUI()
	local picker = self.editor.tilePicker.listBox
	local selectedTile = picker:getFirstSelectedTile()
	local toolActive = self.scene.currentTool == self.scene.tools.setSurface
	if not self.itemHeightEntry:isFocused() or (toolActive and (self.movingFace == "ItemHeight")) then
		local tileName = selectedTile.tileName
		local props = getSprite(tileName):getProperties()
		self.itemHeightEntry:setText(tostring(props:getItemHeight()))
	end
	if not self.surfaceEntry:isFocused() or (toolActive and (self.movingFace == "Surface")) then
		local tileName = selectedTile.tileName
		local props = getSprite(tileName):getProperties()
		self.surfaceEntry:setText(tostring(props:getSurface()))
	end
	for i=1,self.tickBox:getOptionCount() do
		local propertyName = self.tickBox:getOptionData(i)
		local value = TileGeometryManager.getInstance():getTileProperty(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1, propertyName)
		self.tickBox:setSelected(i, value == "true")
	end
end

function PropertiesPanel:configGizmo()
	if self.scene.currentTool == self.scene.tools.setSurface then
		if self.movingFace == "ItemHeight" then
			self.itemHeightEntry:focus()
			self:configGizmoAux(self.movingFace)
		elseif self.movingFace == "Surface" then
			self.surfaceEntry:focus()
			self:configGizmoAux(self.movingFace)
		end
		return true
	end
	self.movingFace = nil
	if self.itemHeightEntry:isFocused() then
		self:configGizmoAux("ItemHeight")
		return true
	end
	if self.surfaceEntry:isFocused() then
		self:configGizmoAux("Surface")
		return true
	end
	return false
end

function PropertiesPanel:configGizmoAux(face)
	local picker = self.editor.tilePicker.listBox
	local selectedTile = picker:getFirstSelectedTile()
	local tileName = selectedTile.tileName
	local props = getSprite(tileName):getProperties()
	local value = (face == "ItemHeight") and props:getItemHeight() or props:getSurface()
	if (face == "ItemHeight") and props:isSurfaceOffset() then
		value = value + props:getSurface()
	end
	local y = value * Core.getTileScale() / 96 / Z_SCALE
	self.vector3f = self.vector3f or Vector3f.new()
	self.scene:java1("setGizmoOrigin", "none")
	self.scene:java1("setGizmoPos", self.vector3f:set(0.0, y, 0.0))
	self.scene:java2("setGizmoAxisVisible", "X", false)
	self.scene:java2("setGizmoAxisVisible", "Y", true)
	self.scene:java2("setGizmoAxisVisible", "Z", false)
	self.movingFace = face
end

function PropertiesPanel:shouldShowInScene()
	return self.itemHeightEntry:isFocused() or self.surfaceEntry:isFocused() or self:isMouseOver()
end

function PropertiesPanel:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o.editor = editor
	o.scene = editor.scene
	return o
end

-----

TileGeometryEditor_DepthTexturePanel = ISPanel:derive("TileGeometryEditor_DepthTexturePanel")
local DepthTexturePanel = TileGeometryEditor_DepthTexturePanel

function DepthTexturePanel:render()
	ISPanel.render(self)
	local picker = self.tilePicker.listBox
	local selectedTile = picker:getSingleSelectedTile()
	if not selectedTile then return end
	local depthTexture = TileDepthTextureManager.getInstance():getTexture(self.editor.modID, picker.tileset, selectedTile.index)
	local otherTile = TileDepthTextureAssignmentManager.getInstance():getAssignedTileName(self.editor.modID, selectedTile.tileName)
	if otherTile then
		depthTexture = TileDepthTextureManager.getInstance():getTextureFromTileName(self.editor.modID, otherTile)
	end
	if not depthTexture then return end
	if not depthTexture:fileExists() then return end
	local texture = depthTexture:getTexture()
	local texX = 0
	local texY = 0
	local texW,texH = 128,256
--	self:drawRect(texX, texY, texW, texH, 1.0, 0.0, 0.0, 0.0)
	self:drawTextureScaled(texture, texX, texY, texW, texH, 1.0, 1.0, 1.0, 1.0)
--	self:drawRectBorder(texX - 1, texY - 1, texW + 2, texH + 2, 1.0, 1.0, 1.0, 1.0)
end

function DepthTexturePanel:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.a = 1.0
	o.borderColor = { r=1.0, g=1.0, b=1.0, a=1.0 }
	o.editor = editor
	o.tilePicker = editor.tilePicker
	return o
end

-----

TileGeometryEditor_SeatingPropertiesPanel = ISPanel:derive("TileGeometryEditor_SeatingPropertiesPanel")
local SeatingPropertiesPanel = TileGeometryEditor_SeatingPropertiesPanel

function SeatingPropertiesPanel:createChildren()
	local tickBox = ISTickBox:new(UI_BORDER_SPACING, UI_BORDER_SPACING, 120, 20, "", self, self.onTickBox)
	tickBox:initialise()
	tickBox:instantiate()
	self:addChild(tickBox)
	tickBox:addOption("Block Left", "BlockLeft")
	tickBox:addOption("Block Right", "BlockRight")
	tickBox:setWidthToFit()
	self.tickBox = tickBox

	self:shrinkWrap(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, nil)
end

function SeatingPropertiesPanel:onTickBox(index, selected, tickBox)
	local propertyName = self.tickBox:getOptionData(index)
	local value = selected and "true" or nil
	local editMode = self.editor.editMode.seating
	local positionIndex = editMode:getSelectedPositionIndex()
	local picker = editMode.tilePicker3.listBox
	local selection = picker:getSelection()
	for _,e in ipairs(selection.elements) do
		-- FIXME: find position with the same ID as the selected position
		SeatingManager.getInstance():setTilePositionProperty(self.editor.modID, picker.tileset, e.col - 1, e.row - 1, positionIndex, propertyName, value)
	end
end

function SeatingPropertiesPanel:toUI()
	local positionIndex = self.editor.editMode.seating:getSelectedPositionIndex()
	local editMode = self.editor.editMode.seating
	local picker = editMode.tilePicker3.listBox
	local selectedTile = picker:getFirstSelectedTile()
	for i=1,self.tickBox:getOptionCount() do
		local propertyName = self.tickBox:getOptionData(i)
		local value = SeatingManager.getInstance():getTilePositionProperty(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1, positionIndex, propertyName)
		self.tickBox:setSelected(i, value == "true")
	end
end

function SeatingPropertiesPanel:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o.editor = editor
	o.scene = editor.scene
	return o
end

-----

TileGeometryEditor_EditMode = ISBaseObject:derive("TileGeometryEditor_EditMode")
local EditMode = TileGeometryEditor_EditMode

function EditMode:java0(func)
	return self.scene:java0(func)
end

function EditMode:java1(func, arg0)
	return self.scene:java1(func, arg0)
end

function EditMode:java2(func, arg0, arg1)
	return self.scene:java2(func, arg0, arg1)
end

function EditMode:java3(func, arg0, arg1, arg2)
	return self.scene:java3(func, arg0, arg1, arg2)
end

function EditMode:java4(func, arg0, arg1, arg2, arg3)
	return self.scene:java4(func, arg0, arg1, arg2, arg3)
end

function EditMode:java5(func, arg0, arg1, arg2, arg3, arg4)
	return self.scene:java5(func, arg0, arg1, arg2, arg3, arg4)
end

function EditMode:java6(func, arg0, arg1, arg2, arg3, arg4, arg5)
	return self.scene:java6(func, arg0, arg1, arg2, arg3, arg4, arg5)
end

function EditMode:java7(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
	return self.scene:java7(func, arg0, arg1, arg2, arg3, arg4, arg5, arg6)
end

function EditMode:activate()
end

function EditMode:deactivate()
end

function EditMode:prerenderEditor()
end

function EditMode:renderTileName()
end

function EditMode:renderSceneTiles()
	self.editor.sceneTiles:render()
end

function EditMode:onMouseDown(x, y)
	return false
end

function EditMode:onMouseUp(x, y)
	return false
end

function EditMode:onRightMouseDown(x, y)
	return false
end

function EditMode:onRightMouseUp(x, y)
	return false
end

function EditMode:onMouseDownScene(x, y)
end

function EditMode:getValidGizmos()
	return { "translate", "rotate", "scale" }
end

function EditMode:configGizmo()
	return false
end

function EditMode:onKeyPress(key)
end

function EditMode:onSave()
end

function EditMode:new(editor)
	local o = ISBaseObject.new(self)
	o.width = editor.width
	o.height = editor.height
	o.editor = editor
	o.tilePicker = editor.tilePicker
	o.tilePicker2 = editor.tilePicker2
	o.scene = editor.scene
	return o
end

-----

TileGeometryEditor_EditMode_Geometry = TileGeometryEditor_EditMode:derive("TileGeometryEditor_EditMode_Geometry")

function TileGeometryEditor_EditMode_Geometry:createChildren()
	local belowHgt = BUTTON_HGT * 9 + UI_BORDER_SPACING * 8
	local bottomH = UI_BORDER_SPACING*2 + BUTTON_HGT

	local listY = UI_BORDER_SPACING+1
	local listBox = GeometryListBox:new(UI_BORDER_SPACING+1, listY, 300, math.min(self.height - bottomH - belowHgt - UI_BORDER_SPACING - listY, BUTTON_HGT * 8), self)
	listBox:setAnchorBottom(true)
	self.editor:addChild(listBox)
	listBox:setFont(UIFont.Small, 3)
	self.listBox = listBox

	self.belowList = ISPanel:new(listBox:getX(), self.listBox:getBottom() + UI_BORDER_SPACING, self.listBox.width, belowHgt)
	self.belowList:noBackground()
	self.editor:addChild(self.belowList)

	local button1 = ISButton:new(0, 0, self.belowList.width, BUTTON_HGT, "TRANSLATE", self, self.onToggleGizmo)
	self.belowList:addChild(button1)
	self.button1 = button1

	local button2 = ISButton:new(0, button1:getBottom() + UI_BORDER_SPACING, self.belowList.width, BUTTON_HGT, "HIDE GEOMETRY", self, self.onToggleGeometryVisible)
	self.belowList:addChild(button2)
	self.button2 = button2

	local button3 = ISButton:new(0, button2:getBottom() + UI_BORDER_SPACING, self.belowList.width, BUTTON_HGT, "ADD XY", self, self.onAddPolygonXY)
	self.belowList:addChild(button3)
	self.button3 = button3

	local button4 = ISButton:new(0, button3:getBottom() + UI_BORDER_SPACING, self.belowList.width, BUTTON_HGT, "ADD XZ", self, self.onAddPolygonXZ)
	self.belowList:addChild(button4)
	self.button4 = button4

	local button5 = ISButton:new(0, button4:getBottom() + UI_BORDER_SPACING, self.belowList.width, BUTTON_HGT, "ADD YZ", self, self.onAddPolygonYZ)
	self.belowList:addChild(button5)
	self.button5 = button5

	local button5_1 = ISButton:new(0, button5:getBottom() + UI_BORDER_SPACING, self.belowList.width, BUTTON_HGT, "ADD BOX", self, self.onAddBox)
	self.belowList:addChild(button5_1)
	self.button5_1 = button5_1

	local button5_2 = ISButton:new(0, button5_1:getBottom() + UI_BORDER_SPACING, self.belowList.width, BUTTON_HGT, "ADD CYLINDER", self, self.onAddCylinder)
	self.belowList:addChild(button5_2)
	self.button5_2 = button5_2

	local button6 = ISButton:new(0, button5_2:getBottom() + UI_BORDER_SPACING, self.belowList.width, BUTTON_HGT, "EDIT POINTS", self, self.onEditPoints)
	self.belowList:addChild(button6)
	self.button6 = button6

	local button7 = ISButton:new(0, button6:getBottom() + UI_BORDER_SPACING, self.belowList.width, BUTTON_HGT, "REMOVE SELECTED", self, self.onRemoveGeometry)
	self.belowList:addChild(button7)
	self.button7 = button7

	self.boxPanel = BoxPanel:new(self.listBox:getRight() + UI_BORDER_SPACING, self.listBox:getY(), 10, 10, self.editor)
	self.editor:addChild(self.boxPanel)

	self.cylinderPanel = CylinderPanel:new(self.listBox:getRight() + UI_BORDER_SPACING, self.listBox:getY(), 10, 10, self.editor)
	self.editor:addChild(self.cylinderPanel)

	self.propertiesPanel = PropertiesPanel:new(self.listBox.x, self.belowList:getBottom() + 256 + UI_BORDER_SPACING*2, 100, 100, self.editor)
	self.editor:addChild(self.propertiesPanel)

	self.depthTexturePanel = DepthTexturePanel:new(self.listBox.x, self.belowList:getBottom() + UI_BORDER_SPACING, 128, 256, self.editor)
	self.editor:addChild(self.depthTexturePanel)
end

function TileGeometryEditor_EditMode_Geometry:activate()
	TileGeometryEditor_EditMode.activate(self)
	self.listBox:setVisible(true)
	self.belowList:setVisible(true)
	self.depthTexturePanel:setVisible(true)
	self.tilePicker:setVisible(true)
	self.tilePicker2:setVisible(true)
end

function TileGeometryEditor_EditMode_Geometry:deactivate()
	TileGeometryEditor_EditMode.deactivate(self)
	self.listBox:setVisible(false)
	self.belowList:setVisible(false)
	self.depthTexturePanel:setVisible(false)
	self.boxPanel:setVisible(false)
	self.cylinderPanel:setVisible(false)
	self.propertiesPanel:setVisible(false)
	self.tilePicker:setVisible(false)
	self.tilePicker2:setVisible(false)
end

function TileGeometryEditor_EditMode_Geometry:prerenderEditor()
	self:java2("setObjectVisible", "character1", true)

	self:prerenderGeometry()
	self:prerenderBox()
	self:prerenderCylinder()
	self:prerenderProperties()
	self:prerenderDepthTexturePanel()

	if self.scene.gizmo == "translate" then
		self.button1.title = "TRANSLATE"
	elseif self.scene.gizmo == "rotate" then
		self.button1.title = "ROTATE"
	elseif self.scene.gizmo == "scale" then
		self.button1.title = "SCALE"
	end

	self.button2:setTitle(self:java0("getDrawGeometry") and "HIDE GEOMETRY" or "SHOW GEOMETRY")

	local selectedTile = self.tilePicker.listBox:getSingleSelectedTile()
	local canEdit = selectedTile ~= nil
	if canEdit and (TileDepthTextureAssignmentManager.getInstance():getAssignedTileName(self.editor.modID, selectedTile.tileName) ~= nil) then
		canEdit = false
	end

	self.button3:setEnable(canEdit)
	self.button4:setEnable(canEdit)
	self.button5:setEnable(canEdit)
	self.button5_1:setEnable(canEdit)
	self.button5_2:setEnable(canEdit)

	local isGeometry = self.scene:isPolygonObject(self.scene.selectedObjectName)
	self.button6:setEnable(isGeometry and self:java0("getDrawGeometry"))
	self.button7:setEnable(self.listBox.selected > 1)
end

function TileGeometryEditor_EditMode_Geometry:renderTileName()
	local picker = self.tilePicker.listBox
	local selectedTile = picker:getSingleSelectedTile()
	local tileName = selectedTile and selectedTile.tileName or nil
	local picker2 = self.tilePicker2.listBox
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
	self.scene:drawTextCentre(tileName, self.scene.width / 2, self.scene.height - UI_BORDER_SPACING - FONT_HGT_MEDIUM, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)
end

function TileGeometryEditor_EditMode_Geometry:prerenderGeometry()
	self.tempTranslate = self.tempTranslate or Vector3f.new()
	self.tempExtentsMin = self.tempExtentsMin or Vector3f.new()
	self.tempExtentsMax = self.tempExtentsMax or Vector3f.new()
	-- Draw bounds of geometry objects
	if self:java0("getDrawGeometry") then
		for i=2,self.listBox:size() do
			local objectName = self.listBox.items[i].item
			self.scene:java2("setGeometrySelected", objectName, i == self.listBox.selected)
			if i == self.listBox.selected and (self.scene:java1("getGeometryType", objectName) == "cylinder") then
				self:java1("addCylinderAABB", objectName)
			end
			if i == self.listBox.selected and self.scene:isPolygonObject(self.listBox.items[i].item) then
				local plane = self:java1("getPolygonPlane", objectName)
				self.tempTranslate:set(self:java1("getObjectTranslation", objectName))
	--			self.tempTranslate:setComponent(1, 0.0)
--				self.tempExtents:set(self.scene:java1("getPolygonExtents", objectName))
				if plane == "XY" then
					self.tempExtentsMin:set(-0.5, 0.0, 0.0)
					self.tempExtentsMax:set(0.5, 3.0 * Z_SCALE, 0.0)
					self:java7("addBox3D",
						self.tempTranslate,
						self.scene:java1("getObjectRotation", objectName),
						self.tempExtentsMin,
						self.tempExtentsMax,
						0, 0, 1)
				end
				if plane == "XZ" then
					self.tempExtentsMin:set(-0.5, -0.5, 0.0)
					self.tempExtentsMax:set(0.5, 0.5, 0.0)
					self:java7("addBox3D",
						self.tempTranslate,
						self.scene:java1("getObjectRotation", objectName),
						self.tempExtentsMin,
						self.tempExtentsMax,
						0, 1, 0)
				end
				if plane == "YZ" then
					self.tempExtentsMin:set(-0.5, 0.0, 0.0)
					self.tempExtentsMax:set(0.5, 3.0 * Z_SCALE, 0.0)
					self:java7("addBox3D",
						self.tempTranslate,
						self.scene:java1("getObjectRotation", objectName),
						self.tempExtentsMin,
						self.tempExtentsMax,
						1, 0, 0)
				end
			end
		end
	end
end

function TileGeometryEditor_EditMode_Geometry:prerenderBox()
	local objectName = self.scene.selectedObjectName
	if luautils.stringStarts(objectName, "box") then
		if not self.boxPanel:isVisible() then
			self.boxPanel:setVisible(true)
		end
		self.boxPanel:toUI()
	else
		if self.boxPanel:isVisible() then
			self.boxPanel.movingFace = nil
			self.boxPanel:setVisible(false)
		end
	end
end

function TileGeometryEditor_EditMode_Geometry:prerenderCylinder()
	local objectName = self.scene.selectedObjectName
	if luautils.stringStarts(objectName, "cylinder") then
		if not self.cylinderPanel:isVisible() then
			self.cylinderPanel:setVisible(true)
		end
		self.cylinderPanel:toUI()
	else
		if self.cylinderPanel:isVisible() then
			self.cylinderPanel.movingFace = nil
			self.cylinderPanel:setVisible(false)
		end
	end
end

function TileGeometryEditor_EditMode_Geometry:prerenderProperties()
	if not self.tilePicker.listBox:isSelectionEmpty() then
		if not self.propertiesPanel:isVisible() then
			self.propertiesPanel:setVisible(true)
		end
		self.propertiesPanel:toUI()
	else
		if self.propertiesPanel:isVisible() then
			self.propertiesPanel.movingFace = nil
			self.propertiesPanel:setVisible(false)
		end
	end
end

function TileGeometryEditor_EditMode_Geometry:prerenderDepthTexturePanel()
	if not self.tilePicker.listBox:isSelectionEmpty() then
		if not self.depthTexturePanel:isVisible() then
			self.depthTexturePanel:setVisible(true)
		end
	else
		if self.depthTexturePanel:isVisible() then
			self.depthTexturePanel:setVisible(false)
		end
	end
end

function TileGeometryEditor_EditMode_Geometry:onMouseDownScene(x, y)
	self.scene.gizmoAxis = self:java2("testGizmoAxis", x, y)
	if self.scene.gizmoAxis ~= "None" then
		if self.boxPanel:isVisible() and self.boxPanel.movingFace ~= nil then
			self.scene.currentTool = self.scene.tools.resizeBox
			self.scene.currentTool.movingFace = self.boxPanel.movingFace
			self.scene.currentTool:onMouseDown(x, y)
			return
		end
		if self.cylinderPanel:isVisible() and self.cylinderPanel.movingFace ~= nil then
			self.scene.currentTool = self.scene.tools.resizeCylinder
			self.scene.currentTool.movingFace = self.cylinderPanel.movingFace
			self.scene.currentTool:onMouseDown(x, y)
			return
		end
		if self.propertiesPanel:isVisible() and self.propertiesPanel.movingFace ~= nil then
			self.scene.currentTool = self.scene.tools.setSurface
			self.scene.currentTool.movingFace = self.propertiesPanel.movingFace
			self.scene.currentTool:onMouseDown(x, y)
			return
		end
		self.scene.currentTool = self.scene.tools.gizmo[self.scene.gizmo]
		self.scene.currentTool:onMouseDown(x, y)
		return
	end
	local objectName = self.scene.selectedObjectName
	if self.scene.editPoints and self.scene:isPolygonObject(objectName) then
		local pointIndex = self:java4("pickPolygonPoint", objectName, x, y, 20)
		local edgeIndex = self:java4("pickPolygonEdge", objectName, x, y, 10)
		if pointIndex ~= -1 or edgeIndex ~= -1 then
			self.scene.currentTool = self.scene.tools.editPolygon
			self.scene.currentTool:onMouseDown(x, y)
			return
		end
	end
	if not self.scene.editPoints and self:java1("getGeometryType", objectName) ~= nil then
		local sx,sy,sx2,sy2,pixelSize = self.scene:getTileBoundsEtc()
		if x >= sx and x < sx2 and y >= sy and y < sy2 then
			self.scene.currentTool = self.scene.tools.depthRect
			self.scene.currentTool:onMouseDown(x, y)
			return
		end
	end
end

function TileGeometryEditor_EditMode_Geometry:getValidGizmos()
	if self.boxPanel:isVisible() and self.boxPanel.movingFace ~= nil then
		return { "translate" }
	end
	if self.cylinderPanel:isVisible() and self.cylinderPanel.movingFace ~= nil then
		return { "translate" }
	end
	if self.propertiesPanel:isVisible() and self.propertiesPanel.movingFace ~= nil then
		return { "translate" }
	end
	return { "translate", "rotate" }
end

function TileGeometryEditor_EditMode_Geometry:configGizmo()
	if self.boxPanel:isVisible() and self.boxPanel:configGizmo() then
		return true
	end
	if self.cylinderPanel:isVisible() and self.cylinderPanel:configGizmo() then
		return true
	end
	if self.propertiesPanel:isVisible() and self.propertiesPanel:configGizmo() then
		return true
	end
	return false
end

function TileGeometryEditor_EditMode_Geometry:setGeometryList()
	self.listBox:clear()
	local names = self:java0("getObjectNames")
	self.listBox:addItem("Player", "character1") -- other code assumes this is first
	for i=1,names:size() do
		local objectName = names:get(i-1)
		if objectName == "character1" then
--			self.listBox:addItem("Player", objectName)
		end
		if luautils.stringStarts(objectName, "box") or luautils.stringStarts(objectName, "cylinder") then
			self.listBox:addItem(objectName, objectName)
		end
		if self.scene:isPolygonObject(objectName) then
			local plane = self:java1("getPolygonPlane", objectName)
			self.listBox:addItem(string.format("%s [%s]", objectName, plane), objectName)
		end
	end
end

function TileGeometryEditor_EditMode_Geometry:onToggleGizmo()
	local gizmos = self.editor:getValidGizmos()
	local index = self.editor:indexOf(gizmos, self.scene.gizmo)
	if index == -1 then
		index = 1
	else
		local index2 = index - 1
		index = (index2 + 1) % #gizmos + 1
	end
	self.scene.gizmo = gizmos[index]
end

function TileGeometryEditor_EditMode_Geometry:onToggleGeometryVisible()
	local visible = not self:java0("getDrawGeometry")
	self:java1("setDrawGeometry", visible)
end

function TileGeometryEditor_EditMode_Geometry:onAddPolygonXY()
	return self:onAddPolygon("XY")
end

function TileGeometryEditor_EditMode_Geometry:onAddPolygonXZ()
	return self:onAddPolygon("XZ")
end

function TileGeometryEditor_EditMode_Geometry:onAddPolygonYZ()
	return self:onAddPolygon("YZ")
end

function TileGeometryEditor_EditMode_Geometry:pickUniqueName(prefix)
	local names = self:java0("getObjectNames")
	local i = 1
	while true do
		local exist = false
		for j=1,names:size() do
			if names:get(j-1) == prefix..i then
				exist = true
				i = i + 1
				break
			end
		end
		if not exist then
			break
		end
	end
	return prefix..i
end

function TileGeometryEditor_EditMode_Geometry:onAddPolygon(plane)
	local objectName = self:pickUniqueName("polygon")
	self:java1("createPolygon", objectName)
	self:java2("setPolygonPlane", objectName, plane)
	self:setGeometryList()
	self.listBox.selected = self.listBox:size()
	self:updateGeometryFile()
end

function TileGeometryEditor_EditMode_Geometry:onAddBox()
	local objectName = self:pickUniqueName("box")
	self:java1("createBox", objectName)
--	self:java1("getObjectTranslation", objectName):set(0.0, 3 * Z_SCALE * 0.5, 0.0)
--	self:java1("getObjectRotation", objectName):set(0.0, 0.0, 0.0)
	self:setGeometryList()
	self.listBox.selected = self.listBox:size()
	self:updateGeometryFile()
end

function TileGeometryEditor_EditMode_Geometry:onAddCylinder()
	local objectName = self:pickUniqueName("cylinder")
	self:java1("createCylinder", objectName)
	self:java2("setCylinderHeight", objectName, 3 * Z_SCALE)
	self:java1("getObjectTranslation", objectName):set(0.0, 3 * Z_SCALE * 0.5, 0.0)
	self:java1("getObjectRotation", objectName):set(270.0, 0.0, 0.0)
	self:setGeometryList()
	self.listBox.selected = self.listBox:size()
	self:updateGeometryFile()
end

function TileGeometryEditor_EditMode_Geometry:onEditPoints()
	self.scene.editPoints = not self.scene.editPoints
end

function TileGeometryEditor_EditMode_Geometry:onRemoveGeometry()
	if self.listBox.selected == 1 then return end
	local item = self.listBox.items[self.listBox.selected]
	if not item then return end
	local objectId = item.item
	self:java1("removeObject", objectId)
	local selected = math.min(self.listBox.selected, self.listBox:size() - 1)
	self:setGeometryList()
	self.listBox.selected = selected
	self:updateGeometryFile()
end

function TileGeometryEditor_EditMode_Geometry:onGeometryToPixels(objectName)
	local selectedTile = self.tilePicker.listBox:getSingleSelectedTile()
	local depthTexture = TileDepthTextureManager.getInstance():getTexture(self.editor.modID, self.tilePicker.listBox.tileset, selectedTile.index)
	for py=1,256 do
		for px=1,128 do
			local depth = self:java3("getGeometryDepthAt", objectName, px - 1 + 0.5 + TEXTURE_OFFSET_X, py - 1 + 0.5)
			if depth >= 0 then
				depthTexture:setPixel(px - 1, py - 1, depth)
			end
		end
	end
	depthTexture:updateGPUTexture()
end

function TileGeometryEditor_EditMode_Geometry:onDuplicateObject(objectName)
	local objectName2 = self:pickUniqueName(self:java1("getGeometryType", objectName))
	self:java2("cloneObject", objectName, objectName2)
	self:setGeometryList()
	self.listBox.selected = self.listBox:size()
	self:updateGeometryFile()
end

function TileGeometryEditor_EditMode_Geometry:onPolygonToPixels(objectName)
	local args = {}
	args.editor = self
	args.scene = self.scene
	args.objectName = objectName
	local selectedTile = self.tilePicker.listBox:getSingleSelectedTile()
	args.depthTexture = TileDepthTextureManager.getInstance():getTexture(self.editor.modID, self.tilePicker.listBox.tileset, selectedTile.index)
	self:java3("rasterizePolygon", objectName, self.RasterizePolygonCallback, args)
	args.depthTexture:updateGPUTexture()
end

function TileGeometryEditor_EditMode_Geometry.RasterizePolygonCallback(args, x, y)
	if x >= 0 and x < 128 and y >= 0 and y < 256 then
		local depth = args.scene:java3("getGeometryDepthAt", args.objectName, x + 0.5, y + 0.5)
		args.depthTexture:setPixel(x, y, depth)
	end
end

function TileGeometryEditor_EditMode_Geometry:onKeyPress(key)
	if key == Keyboard.KEY_A then
		if self.animation == "Bob_SatChair" then
			self.animation = "Bob_GetInBed_Left"
		elseif self.animation == "Bob_GetInBed_Left" then
			self.animation = "Bob_GetInBed_LeftBottomHIGH"
		elseif self.animation == "Bob_GetInBed_LeftBottomHIGH" then
			self.animation = "Bob_Idle"
		else
			self.animation = "Bob_SatChair"
		end
		self:java2("setCharacterAnimationClip", "character1", self.animation)
	end

	if key == Keyboard.KEY_E then
		self.button6:forceClick()
	end

	if key == Keyboard.KEY_G then
		-- TODO: geometry to pixels
	end

	if key == Keyboard.KEY_R then
		if self.scene.gizmo ~= "rotate" then
			self.scene.gizmo = "rotate"
		end
	end

	if key == Keyboard.KEY_T then
		if self.scene.gizmo ~= "translate" then
			self.scene.gizmo = "translate"
		end
	end
	
	if key == Keyboard.KEY_Z and not isCtrlKeyDown() then
		if self.listBox.items[self.listBox.selected] then
			local objectName = self.listBox.items[self.listBox.selected].item
			if self.scene.gizmo == "translate" then
				if self:java1("getGeometryType", objectName) == "cylinder" then
					-- To handle rotated cylinders, the bounding box is used when moving
					-- the cylinder to the ground.
--					if not self.scene:java1("moveCylinderToGround", objectName) then
						self.scene:java2("moveCylinderToOrigin", objectName, self.scene.gizmoAxis)
--					end
				else
					self:zeroTranslation(objectName, self.scene.gizmoAxis)
--					self.scene:java4("setObjectPosition", objectName, 0.0, 0.0, 0.0)
				end
			end
			if self.scene.gizmo == "rotate" then
				self:zeroRotation(objectName, self.scene.gizmoAxis)
--				self.scene:java1("getObjectRotation", objectName):set(0.0, 0.0, 0.0)
			end
			if self:java1("getGeometryType", objectName) ~= nil then
				self:updateGeometryFile()
			end
		end
	end
end

function TileGeometryEditor_EditMode_Geometry:onSave()
	getTileGeometryState():fromLua1("writeGeometryFile", self.editor.modID)
	TileDepthTextureAssignmentManager.getInstance():save(self.editor.modID)

	local picker = self.editor.tilePicker.listBox
	if picker.tileset then
		TileDepthTextureManager.getInstance():saveTileset(self.editor.modID, picker.tileset)
		TileDepthTextureManager.getInstance():mergeAfterEditing(picker.tileset)
		TileDepthTextureManager.getInstance():initSprites()
		TileDepthTextureAssignmentManager.getInstance():initSprites()
		TileGeometryManager.getInstance():initSpriteProperties()
	end
--[[
	local selectedTile = picker:getFirstSelectedTile()
	if selectedTile then
		local depthTexture = TileDepthTextureManager.getInstance():getTexture(self.editor.modID, picker.tileset, selectedTile.index)
		if depthTexture then
			depthTexture:save()
		end
	end
--]]
end

function TileGeometryEditor_EditMode_Geometry:zeroTranslation(objectName, axis)
	local xln = self:java1("getObjectTranslation", objectName)
	if axis == "None" then
		xln:set(0.0)
	elseif axis == "X" then
		xln:setComponent(0, 0.0)
	elseif axis == "Y" then
		xln:setComponent(1, 0.0)
	elseif axis == "Z" then
		xln:setComponent(2, 0.0)
	end
end

function TileGeometryEditor_EditMode_Geometry:zeroRotation(objectName, axis)
	local rot = self:java1("getObjectRotation", objectName)
	if axis == "None" then
		rot:set(0.0)
	elseif axis == "X" then
		rot:setComponent(0, 0.0)
	elseif axis == "Y" then
		rot:setComponent(1, 0.0)
	elseif axis == "Z" then
		rot:setComponent(2, 0.0)
	end
end

function TileGeometryEditor_EditMode_Geometry:updateGeometryFile()
	self.editor:updateGeometryFile()
end

function TileGeometryEditor_EditMode_Geometry:new(x, y, w, h, editor)
	local o = TileGeometryEditor_EditMode.new(self, x, y, w, h, editor)
	o:createChildren() -- this is not a ISUIElement
	return o
end

-----

require "DebugUIs/TileGeometryEditor/TileGeometryEditor_TileList3"
TileGeometryEditor_TilePicker3 = ISPanel:derive("TileGeometryEditor_TilePicker3")

function TileGeometryEditor_TilePicker3:createChildren()
	local comboHeight = FONT_HGT_MEDIUM + 3 * 2
	local combo = ISComboBox:new(0, 0, self.width, comboHeight, self, self.onSelectTileset)
	combo.noSelectionText = "TILESET"
	combo:setEditable(true)
	self:addChild(combo)
	self.comboTileset = combo

	local tilesetNames = getWorld():getAllTilesName()
	for i=1,tilesetNames:size() do
		local tilesetName = tilesetNames:get(i-1)
		self.comboTileset:addOption(tilesetName)
	end

	local listY = combo:getBottom() + 10
	local listBox = TileGeometryEditor_TileList3:new(0, listY, self.width, self.height - listY, self)
	listBox:setAnchorBottom(true)
	self:addChild(listBox)
	listBox:addScrollBars()
	self.listBox = listBox
end

function TileGeometryEditor_TilePicker3:onMouseWheel(del)
	self.listBox:onMouseWheel(del)
	return true
end

function TileGeometryEditor_TilePicker3:onSelectTileset()
	local tilesetName = self.comboTileset:getOptionText(self.comboTileset.selected)
	self.listBox:setTileset(tilesetName)
end

function TileGeometryEditor_TilePicker3:new(x, y, width, height, editor)
	local o = ISPanel.new(self, x, y, width, height)
	o:noBackground()
	o.editor = editor
	return o
end

-----

TileGeometryEditor_SeatingListBox = ListBox:derive("TileGeometryEditor_SeatingListBox")
local SeatingListBox = TileGeometryEditor_SeatingListBox

function SeatingListBox:onRightMouseDown(x, y)
	local row = self:rowAt(x, y)
	local item = self.items[row]
	if not item then return end
end

function SeatingListBox:new(x, y, width, height, editor)
	local o = ListBox.new(self, x, y, width, height)
	o.editor = editor
	o.scene = editor.scene
	return o
end

-----

TileGeometryEditor_EditMode_SceneTiles = TileGeometryEditor_EditMode:derive("TileGeometryEditor_EditMode_SceneTiles")

function TileGeometryEditor_EditMode_SceneTiles:createChildren()
	local buttonPadY = 4
	local buttonHgt = FONT_HGT_MEDIUM + 8

	self.buttonPanel = ISPanel:new(10, 10, 250, 200)
	self.buttonPanel:noBackground()
	self.editor:addChild(self.buttonPanel)
	local button1 = ISButton:new(0, 0, self.buttonPanel.width, buttonHgt, "PLACE", self, self.onButtonPlace)
	self.buttonPanel:addChild(button1)
	self.button1 = button1

	local button2 = ISButton:new(0, button1:getBottom() + buttonPadY, self.buttonPanel.width, buttonHgt, "REMOVE", self, self.onButtonRemove)
	self.buttonPanel:addChild(button2)
	self.button2 = button2
--[[
	local button3 = ISButton:new(0, button2:getBottom() + buttonPadY, self.buttonPanel.width, buttonHgt, "SELECT", self, self.onButtonSelect)
	self.buttonPanel:addChild(button3)
	self.button3 = button3
--]]
	local button4 = ISButton:new(0, button2:getBottom() + buttonPadY, self.buttonPanel.width, buttonHgt, "MOVE", self, self.onButtonMove)
	self.buttonPanel:addChild(button4)
	self.button4 = button4

	self.buttonPanel:shrinkWrap(0, 0)
	self.buttonPanel:setVisible(false)

	local scrollbarWidth = 13
	self.tilePicker3 = TileGeometryEditor_TilePicker3:new(self.width - 10 - (8 * 32 + scrollbarWidth), 40, 8 * 32 + scrollbarWidth, self.height - 10 - 40, self.editor)
	self.tilePicker3:setAnchorBottom(true)
	self.editor:addChild(self.tilePicker3)
	self.tilePicker3:setVisible(false)
end

function TileGeometryEditor_EditMode_SceneTiles:onButtonPlace()
	if self.editor.scene.currentTool == self.editor.scene.tools.addTile then
		self.editor.scene.currentTool = nil
	else
		self.editor.scene.currentTool = self.editor.scene.tools.addTile
	end
end

function TileGeometryEditor_EditMode_SceneTiles:onButtonRemove()
	if self.editor.scene.currentTool == self.editor.scene.tools.removeTile then
		self.editor.scene.currentTool = nil
	else
		self.editor.scene.currentTool = self.editor.scene.tools.removeTile
	end
end

function TileGeometryEditor_EditMode_SceneTiles:onButtonSelect()
	self.editor.scene.currentTool = nil
end

function TileGeometryEditor_EditMode_SceneTiles:onButtonMove()
	if self.editor.scene.currentTool == self.editor.scene.tools.moveTile then
		self.editor.scene.currentTool = nil
	else
		self.editor.scene.currentTool = self.editor.scene.tools.moveTile
	end
end

function TileGeometryEditor_EditMode_SceneTiles:activate()
	TileGeometryEditor_EditMode.activate(self)
	self.buttonPanel:setVisible(true)
	self.tilePicker3:setVisible(true)
	self.previousGeometryVisible = self:java0("getDrawGeometry")
	self:java1("setDrawGeometry", false)
	self.previousTool = self.editor.scene.currentTool
	self.editor.scene.currentTool = nil
end

function TileGeometryEditor_EditMode_SceneTiles:deactivate()
	TileGeometryEditor_EditMode.deactivate(self)
	self.buttonPanel:setVisible(false)
	self.tilePicker3:setVisible(false)
	self:java1("setDrawGeometry", self.previousGeometryVisible)
	self.editor.scene.currentTool = self.previousTool
end

function TileGeometryEditor_EditMode_SceneTiles:prerenderEditor()
	self:java2("setObjectVisible", "character1", false)
    self:java1("setGizmoVisible", "none")
	self.button1.textColor = self.textColorDisabled
	self.button2.textColor = self.textColorDisabled
	self.button4.textColor = self.textColorDisabled
	if self.scene.currentTool == self.scene.tools.addTile then
		self.button1.textColor = self.textColorEnabled
	end
	if self.scene.currentTool == self.scene.tools.removeTile then
		self.button2.textColor = self.textColorEnabled
	end
	if self.scene.currentTool == self.scene.tools.moveTile then
		self.button4.textColor = self.textColorEnabled
	end
end

function TileGeometryEditor_EditMode_SceneTiles:renderTileName()
	local picker = self.tilePicker3.listBox
	local selectedTile = picker:getSingleSelectedTile()
	local tileName = selectedTile and selectedTile.tileName or nil
	if picker.tileset and picker:isMouseOver() then
		local col,row = picker:getColRowAt(picker:getMouseX(), picker:getMouseY())
		if col >= 1 and col <= 8 and row >= 1 then
			local tileIndex = (col - 1) + (row - 1) * 8
			tileName = string.format("%s_%d", picker.tileset, tileIndex)
		end
	end
	if not tileName then return end
	self.scene:drawTextCentre(tileName, self.scene.width / 2, self.scene.height - UI_BORDER_SPACING - FONT_HGT_MEDIUM, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)
end

function TileGeometryEditor_EditMode_SceneTiles:renderSceneTiles()
	if self.scene.currentTool then
		self.scene.currentTool:renderSceneTiles()
	else
		self.editor.sceneTiles:render()
	end
end

function TileGeometryEditor_EditMode_SceneTiles:new(editor)
	local o = TileGeometryEditor_EditMode.new(self, editor)
	o.textColorEnabled = { r=1.0, g=1.0, b=1.0, a=1.0 }
	o.textColorDisabled = { r=0.5, g=0.5, b=0.5, a=1.0 }
	o:createChildren() -- this is not a ISUIElement
	return o
end

-----

TileGeometryEditor_EditMode_Seating = TileGeometryEditor_EditMode:derive("TileGeometryEditor_EditMode_Seating")

function TileGeometryEditor_EditMode_Seating:createChildren()
	local buttonPadY = 4
	local buttonHgt = FONT_HGT_MEDIUM + 8

	local itemHgt = FONT_HGT_SMALL + 2 * 3
	local listY = UI_BORDER_SPACING
	local listBox = SeatingListBox:new(UI_BORDER_SPACING, listY, 300, itemHgt * 4, self)
	self.editor:addChild(listBox)
	listBox:setFont(UIFont.Small, 3)
	listBox:setVisible(false)
	self.listBox = listBox

	self.buttonPanel = ISPanel:new(UI_BORDER_SPACING, self.listBox:getBottom() + UI_BORDER_SPACING, 250, 200)
	self.buttonPanel:noBackground()
	self.editor:addChild(self.buttonPanel)

	local button1 = ISButton:new(0, 0, self.buttonPanel.width, buttonHgt, "toggle geometry", self, self.onButtonToggleGeometry)
	self.buttonPanel:addChild(button1)
	self.button1 = button1

	local button2 = ISButton:new(0, button1:getBottom() + UI_BORDER_SPACING, button1.width, buttonHgt, "APPLY POSITION", self, self.onButtonApply)
	self.buttonPanel:addChild(button2)
	self.button2 = button2

	local button3 = ISButton:new(0, button2:getBottom() + UI_BORDER_SPACING, button1.width, buttonHgt, "ADD NORTH", self, function(self) self:onButtonAddPosition("N") end)
	self.buttonPanel:addChild(button3)
	self.button3 = button3

	local button4 = ISButton:new(0, button3:getBottom() + UI_BORDER_SPACING, button1.width, buttonHgt, "ADD SOUTH", self, function(self) self:onButtonAddPosition("S") end)
	self.buttonPanel:addChild(button4)
	self.button4 = button4

	local button5 = ISButton:new(0, button4:getBottom() + UI_BORDER_SPACING, button1.width, buttonHgt, "ADD WEST", self, function(self) self:onButtonAddPosition("W") end)
	self.buttonPanel:addChild(button5)
	self.button5 = button5

	local button6 = ISButton:new(0, button5:getBottom() + UI_BORDER_SPACING, button1.width, buttonHgt, "ADD EAST", self, function(self) self:onButtonAddPosition("E") end)
	self.buttonPanel:addChild(button6)
	self.button6 = button6

	local button7 = ISButton:new(0, button6:getBottom() + UI_BORDER_SPACING, button1.width, buttonHgt, "REMOVE POSITION", self, self.onButtonRemovePosition)
	self.buttonPanel:addChild(button7)
	self.button7 = button7

	self.buttonPanel:shrinkWrap(0, 0)
	self.buttonPanel:setVisible(false)

	local scrollbarWidth = 13
	self.tilePicker3 = TileGeometryEditor_TilePicker3:new(self.width - UI_BORDER_SPACING - (8 * 32 + scrollbarWidth), 40, 8 * 32 + scrollbarWidth, self.height - UI_BORDER_SPACING - 40, self.editor)
	self.tilePicker3:setAnchorBottom(true)
	self.editor:addChild(self.tilePicker3)
	self.tilePicker3:setVisible(false)

	self.tilePicker3.listBox.renderItemBackground = TileGeometryEditor_EditMode_Seating.renderItemBackground

	self.propertiesPanel = SeatingPropertiesPanel:new(UI_BORDER_SPACING, self.buttonPanel:getBottom() + UI_BORDER_SPACING, 100, 100, self.editor)
	self.editor:addChild(self.propertiesPanel)
	self.propertiesPanel:setVisible(false)
end

-- 'self' is tilePicker3.listBox
function TileGeometryEditor_EditMode_Seating:renderItemBackground(tilesetName, col, row, x, y, w, h)
	local picker = self.parent
	local editor = picker.parent
	local count = SeatingManager.getInstance():getTilePositionCount(editor.modID, tilesetName, col, row)
	if count > 0 then
		self:drawRect(x, y, w, h, 1.0, 0.2, 0.2, 0.2)
	end
end

function TileGeometryEditor_EditMode_Seating:onButtonToggleGeometry()
	local visible = not self:java0("getDrawGeometry")
	self:java1("setDrawGeometry", visible)
end

function TileGeometryEditor_EditMode_Seating:getSelectedPositionIndex()
	if self.listBox:size() == 0 then return -1 end
	return self.listBox.selected - 1
end

local function coordStr(coord)
	return string.format("%.4f", coord)
end

function TileGeometryEditor_EditMode_Seating:onButtonApply()
	local picker = self.tilePicker3.listBox
	local selectedTile = picker:getFirstSelectedTile()
	local positionIndex = self:getSelectedPositionIndex()
	local translate1 = self:java1("getObjectTranslation", "character1")
	local translate2 = SeatingManager.getInstance():getTilePositionTranslate(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1, positionIndex)
	translate2:set(translate1)
end

function TileGeometryEditor_EditMode_Seating:onButtonAddPosition(positionID)
	local picker = self.tilePicker3.listBox
	local selectedTile = picker:getFirstSelectedTile()
	local count = SeatingManager.getInstance():getTilePositionCount(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1)
	SeatingManager.getInstance():addTilePosition(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1, positionID)
	self:populateListBox()
	self.listBox.selected = self.listBox:indexOf(positionID)
end

function TileGeometryEditor_EditMode_Seating:onButtonRemovePosition()
	local picker = self.tilePicker3.listBox
	local selectedTile = picker:getFirstSelectedTile()
	local positionIndex = self:getSelectedPositionIndex()
	SeatingManager.getInstance():removeTilePosition(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1, positionIndex)
	self:populateListBox()
end

function TileGeometryEditor_EditMode_Seating:activate()
--	SeatingManager.getInstance():fixDefaultPositions()
	TileGeometryEditor_EditMode.activate(self)
	self.buttonPanel:setVisible(true)
	self.tilePicker3:setVisible(true)
	self.listBox:setVisible(true)
	self.propertiesPanel:setVisible(true)
	local picker = self.editor.tilePicker.listBox
	local picker3 = self.tilePicker3.listBox
	local selectedTile = picker:getFirstSelectedTile()
	if selectedTile ~= nil then
		picker3:setTileset(picker.tileset)
		picker3:selectionClear()
		picker3:selectionAdd(selectedTile.col, selectedTile.row)
	end
	self.editor.editMode.geometry.listBox.selected = 1 -- character1
	self.previousTool = self.editor.scene.currentTool
	self.scene.gizmo = "translate"
	self.editor.scene.currentTool = nil
	self.previousAnimation = self.editor.editMode.geometry.animation
	self:java2("setCharacterAnimationClip", "character1", "Bob_SatChair")
	self.selectedTile.tileset = nil
end

function TileGeometryEditor_EditMode_Seating:deactivate()
	TileGeometryEditor_EditMode.deactivate(self)
	self.buttonPanel:setVisible(false)
	self.tilePicker3:setVisible(false)
	self.listBox:setVisible(false)
	self.propertiesPanel:setVisible(false)
	self.editor.scene.currentTool = self.previousTool
	self:java2("setCharacterAnimationClip", "character1", self.previousAnimation)
end

function TileGeometryEditor_EditMode_Seating:prerenderEditor()
	self:java2("setObjectVisible", "character1", true)
	self:setGeometryModeSelection()
	local picker = self.tilePicker3.listBox
	local selectedTile = picker:getFirstSelectedTile()
	if selectedTile then
		if self:checkSelectedTile(picker.tileset, selectedTile.col, selectedTile.row) then
--			local xln = SeatingManager.getInstance():getTranslation(self.editor.modID, picker.tileset, selectedTile.index, Vector3f.new())
--			self:java1("getObjectTranslation", "character1"):set(xln:x(), xln:z(), xln:y()) // Y/Z swapped
			self:populateListBox()
		end
		if self:checkSelectedPosition(picker.tileset, selectedTile.col, selectedTile.row) then
			local positionIndex = self:getSelectedPositionIndex()
			if positionIndex == -1 then
				self:java1("getObjectTranslation", "character1"):set(0.0)
			else
				local xln = SeatingManager.getInstance():getTilePositionTranslate(self.editor.modID, picker.tileset, selectedTile.col -1, selectedTile.row - 1, positionIndex)
				self:java1("getObjectTranslation", "character1"):set(xln)
			end
		end

		local facing = "S"
		local positionIndex = self:getSelectedPositionIndex()
		if positionIndex == -1 then
			facing = SeatingManager.getInstance():getFacingDirection(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1)
		else
			facing = SeatingManager.getInstance():getTilePositionID(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1, positionIndex)
		end
		if facing == "N" then
			self:java1("getObjectRotation", "character1"):set(0.0, 180.0, 0.0)
		elseif facing == "S" then
			self:java1("getObjectRotation", "character1"):set(0.0, 0.0, 0.0)
		elseif facing == "W" then
			self:java1("getObjectRotation", "character1"):set(0.0, 90.0, 0.0)
		elseif facing == "E" then
			self:java1("getObjectRotation", "character1"):set(0.0, 270.0, 0.0)
		end

		local playerPos = self:java1("getObjectTranslation", "character1")
		local vector2f = Vector2f.new()
		local valid = self:java6("getAdjacentSeatingPosition", self.editor.modID, "character1", selectedTile.tileName, facing, "Front", vector2f)
		self:java6("addAxisRelativeToOrigin", vector2f:x(), 0.0, vector2f:y(), 0.0, 0.0, 0.0)
		if positionIndex ~= -1 then
			valid = self:java6("getAdjacentSeatingPosition", self.editor.modID, "character1", selectedTile.tileName, facing, "Left", vector2f)
			if valid then
				self:java6("addAxisRelativeToOrigin", vector2f:x(), 0.0, vector2f:y(), 0.0, 0.0, 0.0)
			end
			valid = self:java6("getAdjacentSeatingPosition", self.editor.modID, "character1", selectedTile.tileName, facing, "Right", vector2f)
			if valid then
				self:java6("addAxisRelativeToOrigin", vector2f:x(), 0.0, vector2f:y(), 0.0, 0.0, 0.0)
			end
		end
	end
	self.button1:setEnable(selectedTile ~= nil)
	self.button2:setEnable(self:canApplyChange())
	self.button3:setEnable(selectedTile ~= nil and not self:hasPositionID("N"))
	self.button4:setEnable(selectedTile ~= nil and not self:hasPositionID("S"))
	self.button5:setEnable(selectedTile ~= nil and not self:hasPositionID("W"))
	self.button6:setEnable(selectedTile ~= nil and not self:hasPositionID("E"))
	self.button7:setEnable(self:getSelectedPositionIndex() ~= -1)
	self.button1:setTitle(self:java0("getDrawGeometry") and "HIDE GEOMETRY" or "SHOW GEOMETRY")
	self:prerenderProperties()
end

function TileGeometryEditor_EditMode_Seating:checkSelectedTile(tilesetName, col, row)
	if (self.selectedTile.tileset == tilesetName) and (self.selectedTile.col == col) and (self.selectedTile.row == row) then return false end
	self.selectedTile.tileset = tilesetName
	self.selectedTile.index = (col - 1) + (row - 1) * 8
	self.selectedTile.col = col
	self.selectedTile.row = row
	self.selectedPositionIndex = nil
	return true
end

function TileGeometryEditor_EditMode_Seating:hasPositionID(positionID)
	local picker = self.tilePicker3.listBox
	local selectedTile = picker:getFirstSelectedTile()
	if not selectedTile then return false end
	return SeatingManager.getInstance():hasTilePositionWithID(self.editor.modID, self.selectedTile.tileset, self.selectedTile.col - 1, self.selectedTile.row - 1, positionID)
end

function TileGeometryEditor_EditMode_Seating:checkSelectedPosition()
	local positionIndex = self:getSelectedPositionIndex()
	if positionIndex == -1 then
		self:java1("getObjectTranslation", "character1"):set(0.0)
		return false
	end
	if positionIndex ~= self.selectedPositionIndex then
		self.selectedPositionIndex = positionIndex
		return true
	end
	return false
end

function TileGeometryEditor_EditMode_Seating:populateListBox()
	self.listBox:clear()
	local count = SeatingManager.getInstance():getTilePositionCount(self.editor.modID, self.selectedTile.tileset, self.selectedTile.col - 1, self.selectedTile.row - 1)
	for i=1,count do
		local id = SeatingManager.getInstance():getTilePositionID(self.editor.modID, self.selectedTile.tileset, self.selectedTile.col - 1, self.selectedTile.row - 1, i - 1)
		self.listBox:addItem(id)
	end
end

function TileGeometryEditor_EditMode_Seating:canApplyChange()
	local picker = self.tilePicker3.listBox
	local selectedTile = picker:getFirstSelectedTile()
	if not selectedTile then return false end
	local positionIndex = self:getSelectedPositionIndex()
	if positionIndex == -1 then return false end
	local translate1 = SeatingManager.getInstance():getTilePositionTranslate(self.editor.modID, picker.tileset, selectedTile.col - 1, selectedTile.row - 1, positionIndex)
	local translate2 = self:java1("getObjectTranslation", "character1")
	return not translate1:equals(translate2, 0.00001)
end

function TileGeometryEditor_EditMode_Seating:renderTileName()
	local picker = self.tilePicker3.listBox
	local selectedTile = picker:getSingleSelectedTile()
	local tileName = selectedTile and selectedTile.tileName or nil
	if picker.tileset and picker:isMouseOver() then
		local col,row = picker:getColRowAt(picker:getMouseX(), picker:getMouseY())
		if col >= 1 and col <= 8 and row >= 1 then
			local tileIndex = (col - 1) + (row - 1) * 8
			tileName = string.format("%s_%d", picker.tileset, tileIndex)
		end
	end
	if not tileName then return end
	self.scene:drawTextCentre(tileName, self.scene.width / 2, self.scene.height - UI_BORDER_SPACING - FONT_HGT_MEDIUM, 1.0, 1.0, 1.0, 1.0, UIFont.Medium)
end

function TileGeometryEditor_EditMode_Seating:renderSceneTiles()
	self.editor.sceneTiles:render()
end

function TileGeometryEditor_EditMode_Seating:onMouseDownScene(x, y)
	self.scene.gizmoAxis = self:java2("testGizmoAxis", x, y)
	if self.scene.gizmoAxis ~= "None" then
		self.scene.currentTool = self.scene.tools.gizmo[self.scene.gizmo]
		self.scene.currentTool:onMouseDown(x, y)
		return
	end
end

function TileGeometryEditor_EditMode_Seating:prerenderProperties()
	if not self.tilePicker3.listBox:isSelectionEmpty() then
		if not self.propertiesPanel:isVisible() then
			self.propertiesPanel:setVisible(true)
		end
		self.propertiesPanel:toUI()
	else
		if self.propertiesPanel:isVisible() then
			self.propertiesPanel:setVisible(false)
		end
	end
end

function TileGeometryEditor_EditMode_Seating:onSave()
	SeatingManager.getInstance():write(self.editor.modID)
	SeatingManager.getInstance():mergeAfterEditing()
end

function TileGeometryEditor_EditMode_Seating:setGeometryModeSelection()
	local picker = self.editor.tilePicker.listBox
	local picker3 = self.tilePicker3.listBox
	local selectedTile = picker3:getFirstSelectedTile()
	if selectedTile ~= nil then
		picker:setTileset(picker3.tileset)
		picker:selectionClear()
		picker:selectionAdd(selectedTile.col, selectedTile.row)
	end
end

function TileGeometryEditor_EditMode_Seating:new(editor)
	local o = TileGeometryEditor_EditMode.new(self, editor)
	o.textColorEnabled = { r=1.0, g=1.0, b=1.0, a=1.0 }
	o.textColorDisabled = { r=0.5, g=0.5, b=0.5, a=1.0 }
	o.selectedTile = {}
	o:createChildren() -- this is not a ISUIElement
	return o
end

