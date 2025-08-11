--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require 'ISUI/Maps/Editor/WorldMapEditorMode'

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

WorldMapEditorMode_Stashes = WorldMapEditorMode:derive("WorldMapEditorMode_Stashes")

-----

function WorldMapEditorMode_Stashes:createChildren()
	self.listbox = ISScrollingListBox:new(UI_BORDER_SPACING, UI_BORDER_SPACING*2+BUTTON_HGT, 400, 200)
	self.listbox:setFont(UIFont.Small, 6)
	self:addChild(self.listbox)

	local button = ISButton:new(UI_BORDER_SPACING, self.listbox:getBottom() + UI_BORDER_SPACING, UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(self.font, getText("IGUI_DebugMenu_Load")), BUTTON_HGT, getText("IGUI_DebugMenu_Load"), self, function(self) self:onLoadStash() end)
	button:setWidth(UI_BORDER_SPACING*2+getTextManager():MeasureStringX(UIFont.Small, button.title))
	self:addChild(button)

	local maxLabelWidth = UI_BORDER_SPACING*2+1+math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_WorldMapEditor_BuildingX")..":"),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_WorldMapEditor_BuildingY")..":")
	)

	local label = ISLabel:new(button.x, button:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_WorldMapEditor_BuildingX")..":", 0, 0, 0, 1, UIFont.Small, true)
	self:addChild(label)
	self.buildingXEntry = ISTextEntryBox:new("", maxLabelWidth, label.y, 100, BUTTON_HGT)
	self.buildingXEntry.onCommandEntered = function(entry) self:onBuildingXEntered() end
	self:addChild(self.buildingXEntry)
	self.buildingXEntry:setOnlyNumbers(true)

	label = ISLabel:new(label.x, label:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_WorldMapEditor_BuildingY")..":", 0, 0, 0, 1, UIFont.Small, true)
	self:addChild(label)
	self.buildingYEntry = ISTextEntryBox:new("", maxLabelWidth, label.y, 100, BUTTON_HGT)
	self.buildingYEntry.onCommandEntered = function(entry) self:onBuildingYEntered() end
	self:addChild(self.buildingYEntry)
	self.buildingYEntry:setOnlyNumbers(true)

	local height = UI_BORDER_SPACING+BUTTON_HGT*2
	button = ISButton:new(UI_BORDER_SPACING, self.buildingYEntry:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_Place"), self, function(self) self:onBuildingSet() end)
	button:setWidth(UI_BORDER_SPACING*2+getTextManager():MeasureStringX(UIFont.Small, button.title))
	self:addChild(button)

	button = ISButton:new(button:getRight() + UI_BORDER_SPACING, button.y, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_Clear"), self, function(self) self:onBuildingClear() end)
	button:setWidth(UI_BORDER_SPACING*2+getTextManager():MeasureStringX(UIFont.Small, button.title))
	self:addChild(button)
end

function WorldMapEditorMode_Stashes:onMouseDown(x, y)
	if self.mode == "SetBuildingXY" then
		self.mode = nil
		self.loadedStash = self.loadedStash or {}
		self.loadedStash.buildingX = self.locationControl.x
		self.loadedStash.buildingY = self.locationControl.y
		return true
	end
	if self.locationControl:hitTest(x, y) then
		self.mode = "DragBuildingXY"
		self.locationControl:startDrag()
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Stashes:onMouseUp(x, y)
	if self.mode == "DragBuildingXY" then
		self.mode = nil
		self.loadedStash = self.loadedStash or {}
		self.loadedStash.buildingX = self.locationControl.x
		self.loadedStash.buildingY = self.locationControl.y
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Stashes:onMouseUpOutside(x, y)
	return self:onMouseUp(x, y)
end

function WorldMapEditorMode_Stashes:onMouseMove(dx, dy)
	if self.mode == "DragBuildingXY" or self.mode == "SetBuildingXY" then
		self.locationControl:onMouseMove(self.mapUI:getMouseX(), self.mapUI:getMouseY())
		self.buildingXEntry:setText(tostring(self.locationControl.x))
		self.buildingYEntry:setText(tostring(self.locationControl.y))
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Stashes:onRightMouseDown(x, y)
	if self.mode == "DragBuildingXY" or self.mode == "SetBuildingXY" then
		self:cancelMode()
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Stashes:prerender()
	ISPanel.prerender(self)
end

function WorldMapEditorMode_Stashes:render()
	ISPanel.render(self)
	if self.loadedStash then
		self.locationControl:render()
	end
end

function WorldMapEditorMode_Stashes:display()
	WorldMapEditorMode.display(self)
	local index = self.listbox.selected
	self.listbox:clear()
	if not StashDescriptions then return end
	for _,stash1 in ipairs(StashDescriptions) do
		if stash1.type == "Map" then
			self.listbox:addItem(stash1.name, stash1)
		end
	end
	self.listbox:sort()
	if index >= 1 and index <= self.listbox:size() then
		self.listbox.selected = index
	end
end

function WorldMapEditorMode_Stashes:undisplay()
	WorldMapEditorMode.undisplay(self)
end

function WorldMapEditorMode_Stashes:isKeyConsumed(key)
	if key == Keyboard.KEY_ESCAPE then
		return self.mode == "DragBuildingXY" or self.mode == "SetBuildingXY"
	end
	return false
end

function WorldMapEditorMode_Stashes:onKeyPress(key)
	if key == Keyboard.KEY_ESCAPE then
		return self:cancelMode()
	end
	return false
end

function WorldMapEditorMode_Stashes:onKeyRelease(key)
	return false
end

function WorldMapEditorMode_Stashes:onBuildingXEntered()
	self.loadedStash = self.loadedStash or {}
	self.loadedStash.buildingX = tonumber(self.buildingXEntry:getText()) or ""
	self.locationControl:setLocation(self.loadedStash.buildingX or 0, self.loadedStash.buildingY or 0)
end

function WorldMapEditorMode_Stashes:onBuildingYEntered()
	self.loadedStash = self.loadedStash or {}
	self.loadedStash.buildingY = tonumber(self.buildingYEntry:getText()) or ""
	self.locationControl:setLocation(self.loadedStash.buildingX or 0, self.loadedStash.buildingY or 0)
end

function WorldMapEditorMode_Stashes:onBuildingSet()
	self:cancelMode()
	self.mode = "SetBuildingXY"
	if self.loadedStash and tonumber(self.loadedStash.buildingX) and tonumber(self.loadedStash.buildingY) then
		self.locationControl:setLocation(self.loadedStash.buildingX, self.loadedStash.buildingY)
	else
		self.locationControl:setLocation(0, 0)
	end
	self.locationControl:startDrag()
end

function WorldMapEditorMode_Stashes:onBuildingClear()
	self:cancelMode()
	if not self.loadedStash then return end
	self.loadedStash.buildingX = nil
	self.loadedStash.buildingY = nil
	self.locationControl:setLocation(0, 0)
	self.buildingXEntry:setText("0")
	self.buildingYEntry:setText("0")
end

function WorldMapEditorMode_Stashes:cancelMode()
	if self.mode == "DragBuildingXY" then
		self.mode = nil
		self.locationControl:cancelDrag()
		self.buildingXEntry:setText(tostring(self.locationControl.x))
		self.buildingYEntry:setText(tostring(self.locationControl.y))
		return true
	end
	if self.mode == "SetBuildingXY" then
		self.mode = nil
		self.locationControl:cancelDrag()
		self.buildingXEntry:setText(tostring(self.loadedStash.buildingX or 0))
		self.buildingYEntry:setText(tostring(self.loadedStash.buildingY or 0))
		return true
	end
	return false
end

function WorldMapEditorMode_Stashes:onLoadStash()
	local item = self.listbox.items[self.listbox.selected]
	if not item then return end
	self.symbolsAPI:clear()
	local stash1 = item.item
	local scriptItem = getScriptManager():FindItem(stash1.item)
	if not scriptItem then return end
	local mapID = scriptItem:getMapID()
	if LootMaps.Init[stash1.name] then
		mapID = stash1.name
	end
	if not LootMaps.Init[mapID] then return end
	self.editor.mapItem:setMapID(mapID)
	LootMaps.callLua("Init", self.mapUI)
	if stash1.annotations then
		for _,annotation in ipairs(stash1.annotations) do
			if annotation.symbol then
				local symbol = self.symbolsAPI:addTexture(annotation.symbol, annotation.x, annotation.y)
				symbol:setRGBA(annotation.r, annotation.g, annotation.b, 1.0)
				symbol:setAnchor(0.5, 0.5)
				symbol:setScale(ISMap.SCALE)
			end
			if annotation.text then
				local symbol = self.symbolsAPI:addUntranslatedText(annotation.text, self.symbolsAPI:getDefaultLayerID(), annotation.x, annotation.y)
				symbol:setRGBA(annotation.r, annotation.g, annotation.b, 1.0)
				symbol:setAnchor(0.0, 0.0)
				symbol:setScale(ISMap.SCALE)
			end
		end
	end
	self.editor:loadSettingsFromMap()
	self.loadedStash = copyTable(stash1)
	self.buildingXEntry:setText(tostring(self.loadedStash.buildingX or 0))
	self.buildingYEntry:setText(tostring(self.loadedStash.buildingY or 0))
	self.locationControl:setLocation(self.loadedStash.buildingX or 0, self.loadedStash.buildingY or 0)
end

function WorldMapEditorMode_Stashes:generateLuaScript()
	local symbolsAPI = self.symbolsAPI
	local stash1 = self.loadedStash
	local script = string.format("local stashMap = StashUtil.newStash(\"%s\", \"Map\", \"%s\", \"Stash_AnnotedMap\")\n", stash1.name, stash1.item)
	if stash1.buildingX and stash1.buildingY then
		script = string.format("%sstashMap.buildingX = %d\n", script, stash1.buildingX)
		script = string.format("%sstashMap.buildingY = %d\n", script, stash1.buildingY)
	end
	for i=1,symbolsAPI:getSymbolCount() do
		local symbol = symbolsAPI:getSymbolByIndex(i-1)
		local worldX = symbol:getWorldX()
		local worldY = symbol:getWorldY()
		local r = symbol:getRed()
		local g = symbol:getGreen()
		local b = symbol:getBlue()
		if symbol:isText() then
			local text = symbol:getUntranslatedText()
			script = string.format("%sstashMap:addStamp(nil, \"%s\", %d, %d, %d, %d, %d)\n", script, text or "", worldX, worldY, r, g, b)
		end
		if symbol:isTexture() then
			local symbolID = symbol:getSymbolID()
			script = string.format("%sstashMap:addStamp(\"%s\", nil, %d, %d, %d, %d, %d)\n", script, symbolID, worldX, worldY, r, g, b)
		end
	end
	return script
end

function WorldMapEditorMode_Stashes:new(editor)
	local o = WorldMapEditorMode.new(self, editor)
	o.loadedStash = nil
	o.locationControl = WorldMapEditorLocationControl:new(editor)
	return o
end

