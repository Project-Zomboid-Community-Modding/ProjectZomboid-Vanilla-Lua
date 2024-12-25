--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/AdminPanel/ZoneEditor/MultiplayerZoneEditorMode"
require('ISUI/Maps/Editor/WorldMapEditorResizer')

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

-- Offset WorldMapEditorResizer bounds by this amount.
local function DXY() return 0 end

MultiplayerZoneEditorMode_NonPVP = MultiplayerZoneEditorMode:derive("MultiplayerZoneEditorMode_NonPVP")

function MultiplayerZoneEditorMode_NonPVP:createChildren()
	local ROWS = 6
	self.listbox = ISScrollingListBox:new(UI_BORDER_SPACING, self.editor.modeCombo:getBottom() + UI_BORDER_SPACING, 300, (FONT_HGT_SMALL + 3 * 2) * ROWS)
	self.listbox:setFont(UIFont.Small, 3)
	self:addChild(self.listbox)

	local buttonPadding = UI_BORDER_SPACING * 2
	local button = ISButton:new(UI_BORDER_SPACING, self.listbox:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_MultiplayerZoneEditor_Button_AddZone"), self, function(self) self:onAddZone() end)
	button:setWidthToTitle()
	self:addChild(button)

	button = ISButton:new(UI_BORDER_SPACING, button:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_MultiplayerZoneEditor_Button_RenameZone"), self, function(self) self:onRenameZone() end)
	button:setWidthToTitle()
	self:addChild(button)
	self.renameButton = button

	button = ISButton:new(UI_BORDER_SPACING, button:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_MultiplayerZoneEditor_Button_RemoveZone"), self, function(self) self:onRemoveZone() end)
	button:setWidthToTitle()
	self:addChild(button)
	self.removeButton = button
end

function MultiplayerZoneEditorMode_NonPVP:prerender()
	self:fillList()
	local zone = self:getSelectedZone()
	local zoneName = zone and zone:getTitle() or nil
	if zoneName ~= self.selectedZone then
		self:selectedZoneChanged() -- another user might remove the zone being resized
		self.selectedZone = zoneName
		if zone then
			self.resizer:setBounds(zone:getX(), zone:getY(), zone:getX2() + DXY(), zone:getY2() + DXY())
			self.mapAPI:centerOn(zone:getX(), zone:getY())
		else
			self.resizer:setBounds(0, 0, 0, 0)
		end
	end
	self.renameButton:setEnable(zone ~= nil)
	self.removeButton:setEnable(zone ~= nil)
end

function MultiplayerZoneEditorMode_NonPVP:render()
	local r,g,b,a = 0.0, 0.0, 1.0, 0.5
	local zones = NonPvpZone.getAllZones()
	for i=1,zones:size() do
		local zone = zones:get(i-1)
		self:renderRect(zone:getX(), zone:getY(), zone:getX2(), zone:getY2(), r, g, b, a)
		local uiX = self.mapAPI:worldToUIX(zone:getX(), zone:getY())
		local uiY = self.mapAPI:worldToUIY(zone:getX(), zone:getY())
		self:drawText(zone:getTitle(), uiX + 4, uiY + 2, 0, 0, 0, 1, UIFont.Small)
	end
	self:renderResizer()
	if self.mode == "StartDrawingBounds" then
		local mx = self.mapUI:getMouseX()
		local my = self.mapUI:getMouseY()
		local worldX = self.mapAPI:uiToWorldX(mx, my)
		local worldY = self.mapAPI:uiToWorldY(mx, my)
		worldX = self.resizer:snap(worldX)
		worldY = self.resizer:snap(worldY)
		mx = self.mapAPI:worldToUIX(worldX, worldY)
		my = self.mapAPI:worldToUIY(worldX, worldY)
		self.mapUI:drawRectBorder(mx - 10, my - 10, 20, 20, 1, 0, 0, 1)
		self.mapUI:drawRectBorder(mx - 10 - 1, my - 10 - 1, 20 + 2, 20 + 2, 1, 0, 0, 1)
	end
end

function MultiplayerZoneEditorMode_NonPVP:renderResizer()
	local r,g,b,a = 0,0,0,1
	if self.mode == "DrawBounds" then
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2 - DXY(), self.resizer.y2 - DXY()
		if not self:isNewZoneValid(x1, y1, x2, y2) then
			r = 1
		end
	end
	if self.mode == "Resize" then
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2 - DXY(), self.resizer.y2 - DXY()
		local ignoreZone = self:getSelectedZone()
		if x1 == x2 or y1 == y2 then
			r = 1
		end
	end
	self.resizer:render(r, g, b, a)
end

function MultiplayerZoneEditorMode_NonPVP:renderRect(x1, y1, x2, y2, r, g, b, a)
	local worldX1 = x1
	local worldY1 = y1
	local worldX2 = x2
	local worldY2 = y2
	local uiX1 = self.mapAPI:worldToUIX(worldX1, worldY1)
	local uiY1 = self.mapAPI:worldToUIY(worldX1, worldY1)
	local uiX2 = self.mapAPI:worldToUIX(worldX2, worldY1)
	local uiY2 = self.mapAPI:worldToUIY(worldX2, worldY1)
	local uiX3 = self.mapAPI:worldToUIX(worldX2, worldY2)
	local uiY3 = self.mapAPI:worldToUIY(worldX2, worldY2)
	local uiX4 = self.mapAPI:worldToUIX(worldX1, worldY2)
	local uiY4 = self.mapAPI:worldToUIY(worldX1, worldY2)
	local THICK = 1
	self.mapUI.javaObject:DrawLine(Texture:getWhite(), uiX1, uiY1, uiX2, uiY2, THICK, r, g, b, a)
	self.mapUI.javaObject:DrawLine(Texture:getWhite(), uiX2, uiY2, uiX3, uiY3, THICK, r, g, b, a)
	self.mapUI.javaObject:DrawLine(Texture:getWhite(), uiX3, uiY3, uiX4, uiY4, THICK, r, g, b, a)
	self.mapUI.javaObject:DrawLine(Texture:getWhite(), uiX4, uiY4, uiX1, uiY1, THICK, r, g, b, a)
	--[[
	self.mapUI:drawRect(uiX1 - THICK, uiY1 - THICK, uiX2 - uiX1 + THICK * 2, THICK, a, r, g, b)
	self.mapUI:drawRect(uiX2, uiY2 - THICK, THICK, uiY3 - uiY2 + THICK * 2, a, r, g, b)
	self.mapUI:drawRect(uiX4 - THICK, uiY4, uiX3 - uiX4 + THICK * 2, THICK, a, r, g, b)
	self.mapUI:drawRect(uiX1 - THICK, uiY1 - THICK, THICK, uiY4 - uiY1 + THICK * 2, a, r, g, b)
	--]]
end

function MultiplayerZoneEditorMode_NonPVP:fillList()
	local selectedZone = self:getSelectedZone()
	local selectedTitle = selectedZone and selectedZone:getTitle() or nil
	if self.delaySelectTitle then
		selectedTitle = self.delaySelectTitle
		self.delaySelectTitle = nil
	end
	self.listbox:clear()
	local zones = NonPvpZone.getAllZones()
	for i=1,zones:size() do
		local zone = zones:get(i-1)
		self.listbox:addItem(zone:getTitle(), zone)
	end
	self.listbox:sort()
	for i=1,zones:size() do
		local zone = self.listbox.items[i].item
		if zone:getTitle() == selectedTitle then
			self.listbox.selected = i
		end
	end
end

function MultiplayerZoneEditorMode_NonPVP:getSelectedZone()
	local selected = self.listbox.selected
	local item = self.listbox.items[selected]
	return item and item.item or nil
end

function MultiplayerZoneEditorMode_NonPVP:undisplay()
	if self.modalUI then
		self.modalUI:close()
		self.modalUI:setVisible(false)
		self.modalUI:removeFromUIManager()
		self.modalUI = nil
	end
	self.selectedZone = nil
	self:cancelResize()
	MultiplayerZoneEditorMode.undisplay(self)
end

function MultiplayerZoneEditorMode_NonPVP:onMouseDown(x, y)
	if self.mode == "StartDrawingBounds" then
		self.mode = "DrawBounds"
		local worldX = self.mapAPI:uiToWorldX(x, y)
		local worldY = self.mapAPI:uiToWorldY(x, y)
		worldX = self.resizer:snap(worldX)
		worldY = self.resizer:snap(worldY)
		self.resizer:setBounds(worldX, worldY, worldX, worldY)
		self.resizer:startResizing()
		return true
	end
	if self:getSelectedZone() then
		local resizeMode = self.resizer:hitTest(x, y)
		if not resizeMode then return false end
		self.resizer:startResizing()
		self.mode = "Resize"
		self.resizeMode = resizeMode
		return true
	end
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode_NonPVP:onMouseUp(x, y)
	if self.mode == "DrawBounds" then
		self.mode = nil
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2 - DXY(), self.resizer.y2 - DXY()
		if self:isNewZoneValid(x1, y1, x2, y2) then
			self:createNewZone(x1, y1, x2, y2)
		else
			self.selectedZone = nil -- set resizer bounds
		end
		self.resizer:endResizing()
		return true
	end
	if self.mode == "Resize" then
		self.mode = nil
		self.resizeMode = nil
		local x1,y1,x2,y2 = self.resizer.x1, self.resizer.y1, self.resizer.x2 - DXY(), self.resizer.y2 - DXY()
		if self:isZoneSizeValid(x1, y1, x2, y2) then
			self:setZoneBounds(x1, y1, x2, y2)
		else
			self.selectedZone = nil -- set resizer bounds
		end
		self.resizer:endResizing()
		return true
	end
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode_NonPVP:onMouseUpOutside(x, y)
	return self:onMouseUp(x, y)
end

function MultiplayerZoneEditorMode_NonPVP:onMouseMove(dx, dy)
	if self.mode == "DrawBounds" then
		local mx = self:getMouseX()
		local my = self:getMouseY()
		self.resizer:onMouseMove(mx, my, "BottomRight")
		return true
	end
	if self.mode == "Resize" then
		local mx = self:getMouseX()
		local my = self:getMouseY()
		self.resizer:onMouseMove(mx, my, self.resizeMode)
		return true
	end
	if self.mode then
		return true
	end
	return false -- allow clicks in the map
end

function MultiplayerZoneEditorMode_NonPVP:onRightMouseDown(x, y)
	return self:cancelResize()
end

function MultiplayerZoneEditorMode_NonPVP:onKeyRelease(key)
	if key == Keyboard.KEY_ESCAPE then
		return self:cancelResize()
	end
	return false
end

function MultiplayerZoneEditorMode_NonPVP:selectedZoneChanged()
	if self.modalUI then
		self.modalUI:close()
		self.modalUI:setVisible(false)
		self.modalUI:removeFromUIManager()
		self.modalUI = nil
	end
	self:cancelResize()
end

function MultiplayerZoneEditorMode_NonPVP:cancelResize()
	if self.mode == "DrawBounds" then
		self.mode = nil
		self.resizer:endResizing()
		self.selectedZone = nil -- set resizer bounds
		return true
	end
	if self.mode == "Resize" then
		self.mode = nil
		self.resizeMode = nil
		self.resizer:cancelResize()
		return true
	end
	if self.mode == "StartDrawingBounds" then
		self.mode = nil
		self.selectedZone = nil -- set resizer bounds
		return true
	end
	return false
end

function MultiplayerZoneEditorMode_NonPVP:isNewZoneValid(x1, y1, x2, y2)
	if not self:isZoneSizeValid(x1, y1, x2, y2) then return false end
	return true
end

function MultiplayerZoneEditorMode_NonPVP:isZoneSizeValid(x1, y1, x2, y2)
	return x1 < x2 and y1 < y2
end

function MultiplayerZoneEditorMode_NonPVP:createNewZone(x1, y1, x2, y2)
	local player = nil
	local modal = ISTextBox:new(0, 0, 280, 180, getText("IGUI_PvpZone_RenamePrompt"), "", self, self.onNewZoneNameEntered, player)
	modal:initialise()
	modal:addToUIManager()
	self.modalUI = modal
end

function MultiplayerZoneEditorMode_NonPVP:onNewZoneNameEntered(button)
	self.selectedZone = nil
	if button.internal == "OK" then
		local title = button.parent.entry:getText()
		NonPvpZone.addNonPvpZone(title, self.resizer.x1, self.resizer.y1, self.resizer.x2, self.resizer.y2)
		self.delaySelectTitle = title
	end
end

function MultiplayerZoneEditorMode_NonPVP:setZoneBounds(x1, y1, x2, y2)
	local zone = self:getSelectedZone()
	local title = zone:getTitle()
	NonPvpZone.removeNonPvpZone(title)
	NonPvpZone.addNonPvpZone(title, x1, y1, x2, y2)
end

function MultiplayerZoneEditorMode_NonPVP:onAddZone()
	if self.mode == "StartDrawingBounds" then
		self.mode = nil
		self.selectedZone = nil -- set resizer bounds
		return
	end
	self.mode = "StartDrawingBounds"
	self.resizer:setBounds(0, 0, 0, 0)
end

function MultiplayerZoneEditorMode_NonPVP:onRenameZone()
	local zone = self:getSelectedZone()
	local player = nil
	local modal = ISTextBox:new(self.renameButton:getRight() + 20, self.renameButton:getY(), 280, 180, getText("IGUI_PvpZone_RenamePrompt"), zone:getTitle(), self, self.onExistingZoneNameEntered, player)
	modal:initialise()
	modal:addToUIManager()
	modal:setAlwaysOnTop(true)
	modal.zone = zone
	self.modalUI = modal
end

function MultiplayerZoneEditorMode_NonPVP:onExistingZoneNameEntered(button)
	local modal = button.parent
	if button.internal == "OK" then
		local zone = modal.zone
		local x1,y1,x2,y2 = zone:getX(), zone:getY(), zone:getX2(), zone:getY2()
		local title = zone:getTitle()
		NonPvpZone.removeNonPvpZone(title)
		title = button.parent.entry:getText()
		NonPvpZone.addNonPvpZone(title, x1, y1, x2, y2)
		self.delaySelectTitle = title
	end
end

function MultiplayerZoneEditorMode_NonPVP:onRemoveZone()
	local zone = self:getSelectedZone()
	local modal = ISModalDialog:new(self.removeButton:getRight() + 20, self.removeButton:getY(), 350, 150, getText("IGUI_PvpZone_RemoveConfirm", zone:getTitle()), true, self, self.onConfirmRemoveZone)
	modal:initialise()
	modal:addToUIManager()
	modal.ui = self
	modal.zone = zone
	modal.moveWithMouse = true
	modal:setAlwaysOnTop(true)
	self.modalUI = modal
end

function MultiplayerZoneEditorMode_NonPVP:onConfirmRemoveZone(button)
	local modal = button.parent
	if button.internal == "YES" then
		local title = modal.zone:getTitle()
		NonPvpZone.removeNonPvpZone(title)
	end
end

function MultiplayerZoneEditorMode_NonPVP:new(editor)
	local o = MultiplayerZoneEditorMode.new(self, editor)
	o.snapMode = "square" -- "cell" or "chunk" or "square"
	o.resizer = WorldMapEditorResizer:new(editor)
	o.resizer.snapMode = o.snapMode
	return o
end
