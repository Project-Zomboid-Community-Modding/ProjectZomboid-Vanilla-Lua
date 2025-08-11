--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require 'ISUI/Maps/Editor/WorldMapEditorMode'

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

WorldMapEditorMode_Annotations = WorldMapEditorMode:derive("WorldMapEditorMode_Annotations")

-----

function WorldMapEditorMode_Annotations:createChildren()
	local symbolsWidth = ISWorldMapSymbols.RequiredWidth()
	self.symbolsUI = ISWorldMapSymbols:new(UI_BORDER_SPACING, UI_BORDER_SPACING*2+BUTTON_HGT, symbolsWidth, 200, self.editor)
	self.symbolsUI.showTranslationOption = true
	self:addChild(self.symbolsUI)

    local listWidth = 200
	self.listbox = ISScrollingListBox:new(self.width - UI_BORDER_SPACING - listWidth, UI_BORDER_SPACING*2+BUTTON_HGT, listWidth, 200)
	self.listbox:setFont(UIFont.Small, 6)
	self:addChild(self.listbox)

	local button = ISButton:new(self.listbox.x, self.listbox:getBottom() + UI_BORDER_SPACING, 100, BUTTON_HGT, getText("IGUI_DebugMenu_Load"), self, self.onLoadMap)
	button:setWidthToTitle()
	button.tooltip = "Load worldmap-annotations.lua from the selected map directory.\nNOTE: This clears all annotations already in the editor."
	self:addChild(button)

	button = ISButton:new(button:getRight() + UI_BORDER_SPACING, button.y, 100, BUTTON_HGT, getText("IGUI_DebugMenu_Save"), self, self.onSaveMap)
	button:setWidthToTitle()
	button.tooltip = "Save worldmap-annotations.lua to the selected map directory."
	self:addChild(button)

    local dirs = getLotDirectories()
	for i=1,dirs:size() do
		self.listbox:addItem(dirs:get(i-1))
	end

    self.filter = ISTextEntryBox:new("", self.width - UI_BORDER_SPACING - listWidth, button:getBottom() + UI_BORDER_SPACING * 2, listWidth, FONT_HGT_SMALL + 2 * 2);
    self.filter:initialise()
    self.filter:instantiate()
    self.filter.onTextChange = function() self:onFilterTextChange() end
    self.filter:setClearButton(true)
    self:addChild(self.filter)

	self.annotationsList = ISScrollingListBox:new(self.width - UI_BORDER_SPACING - listWidth, self.filter:getBottom() + 2, listWidth, FONT_HGT_SMALL * 10)
	self.annotationsList:setFont(UIFont.Small, 6)
	self.annotationsList:setOnMouseDownFunction(self, self.onAnnotationListItemSelected)
	self:addChild(self.annotationsList)
end

function WorldMapEditorMode_Annotations:onMouseDown(x, y)
	if self.symbolsUI:onMouseDownMap(x, y) then
		return true
	end
	self.dragging = true
	self.dragMoved = false
	self.dragStartX = x
	self.dragStartY = y
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Annotations:onMouseUp(x, y)
	if self.dragging then
		self.dragging = false
	end
	if self.symbolsUI:onMouseUpMap(x, y) then
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Annotations:onMouseUpOutside(x, y)
	self.dragging = false
	if self.symbolsUI:onMouseUpMap(x, y) then
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Annotations:onMouseMove(dx, dy)
	if self.symbolsUI:onMouseMoveMap(dx, dy) then
		return true
	end
	if self.dragging then
		local mouseX = self:getMouseX()
		local mouseY = self:getMouseY()
		if not self.dragMoved and math.abs(mouseX - self.dragStartX) <= 4 and math.abs(mouseY - self.dragStartY) <= 4 then
			return false
		end
		self.dragMoved = true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Annotations:onRightMouseDown(x, y)
    if self.symbolsUI:onRightMouseDownMap(x, y) then
        return true
    end
    return false
end

function WorldMapEditorMode_Annotations:prerender()
	ISPanel.prerender(self)
	self.symbolsUI:prerenderMap()
	if self.symbolCount ~= self.symbolsAPI:getSymbolCount() then
        self.symbolCount = self.symbolsAPI:getSymbolCount()
        self:fillAnnotationsList()
    end
end

function WorldMapEditorMode_Annotations:render()
	ISPanel.render(self)
end

function WorldMapEditorMode_Annotations:undisplay()
	WorldMapEditorMode.undisplay(self)
	self.symbolsUI:undisplay()
end

function WorldMapEditorMode_Annotations:isKeyConsumed(key)
	if self.symbolsUI:isKeyConsumed(key) then
		return true
	end
	return false
end

function WorldMapEditorMode_Annotations:onKeyPress(key)
	if self.symbolsUI:onKeyPress(key) then
		return true
	end
	return false
end

function WorldMapEditorMode_Annotations:onKeyRelease(key)
	if self.symbolsUI:onKeyRelease(key) then
		return true
	end
	return false
end

function WorldMapEditorMode_Annotations:onFilterTextChange()
    self:fillAnnotationsList()
end

function WorldMapEditorMode_Annotations:fillAnnotationsList()
    local filterText = string.lower(self.filter:getInternalText())
    self.annotationsList:clear()
    for i=1,self.symbolsAPI:getSymbolCount() do
        local symbol = self.symbolsAPI:getSymbolByIndex(i-1)
        if symbol:isText() then
            local symbolText = string.lower(symbol:getTranslatedText())
            if ((searchText == "") or string.contains(symbolText, filterText)) then
                local text = symbol:getTranslatedText()
                text = text:gsub("\n", " "):gsub("<br>", " "):gsub("<BR>", " ")
                self.annotationsList:addItem(text, symbol)
            end
        end
    end
end

function WorldMapEditorMode_Annotations:onAnnotationListItemSelected(symbol)
    self.mapAPI:centerOn(symbol:getWorldX(), symbol:getWorldY())
end

function WorldMapEditorMode_Annotations:onLoadMap()
	local item = self.listbox.items[self.listbox.selected]
	if not item then return end
	local dirName = item.text

	MapUtils.initDefaultMapData(self.mapUI)
	self.mapAPI:setBoundsFromData()
	MapUtils.initDefaultStyleV3(self.mapUI)
	MapUtils.overlayPaper(self.mapUI)
	self.mapAPI:resetView()
	self.mapAPI:setBoolean("HighlightStreet", false)
	self.mapAPI:setBoolean("OutlineStreets", false)
	self.mapAPI:setBoolean("ShowStreetNames", true)
	self.mapAPI:getStreetsAPI():clearStreetData()
--	self.streetsAPI:addStreetData('media/maps/'..dirName..'/streets.xml')
--	self.streetsAPI:getEditorAPI():setStreetData('media/maps/'..dirName..'/streets.xml')

    self.symbolsAPI:clear()
	MapUtils.initDirectoryAnnotations(self.mapUI, 'media/maps/'..dirName)
	self:fillAnnotationsList()

	self.editor:loadSettingsFromMap()
end

function WorldMapEditorMode_Annotations:onSaveMap()
	local item = self.listbox.items[self.listbox.selected]
	if not item then return end
	local dirName = item.text
    local script = self:generateLuaScript2()
    self.editor.state:fromLua2("writeAnnotationsLua", 'media/maps/'..dirName..'/'..'worldmap-annotations.lua', script)
    self.symbolsAPI:reinitDefaultAnnotations() -- update the in-game map so we can see the results
end

function WorldMapEditorMode_Annotations:generateLuaScript()
	local symbolsAPI = self.symbolsAPI
	local script = ""
	for i=1,symbolsAPI:getSymbolCount() do
		local symbol = symbolsAPI:getSymbolByIndex(i-1)
		local worldX = symbol:getWorldX()
		local worldY = symbol:getWorldY()
		local r = symbol:getRed()
		local g = symbol:getGreen()
		local b = symbol:getBlue()
		local anchorX = symbol:getAnchorX()
		local anchorY = symbol:getAnchorY()
		local rotation = symbol:getRotation()
		if symbol:isText() then
			local text = symbol:getUntranslatedText()
			script = string.format("%sstashMap:addStampV2(nil, \"%s\", %d, %d, %.2f, %.2f, %.1f, %.3f, %.3f, %.3f)\n",
                script, text or "", worldX, worldY, anchorX, anchorY, rotation, r, g, b)
		end
		if symbol:isTexture() then
			local symbolID = symbol:getSymbolID()
			script = string.format("%sstashMap:addStampV2(\"%s\", nil, %d, %d, %.2f, %.2f, %.1f, %.3f, %.3f, %.3f)\n",
                script, symbolID, worldX, worldY, anchorX, anchorY, rotation, r, g, b)
		end
	end
	return script
end

function WorldMapEditorMode_Annotations:generateLuaScript2()
	local symbolsAPI = self.symbolsAPI
	local script2 = "return function(mapUI)\n"
    script2 = script2 .. "\tlocal mapAPI = mapUI.javaObject:getAPIv3()\n"
    script2 = script2 .. "\tlocal symbolsAPI = mapAPI:getSymbolsAPIv2()\n"
    script2 = script2 .. "\tlocal symbol\n"
	for i=1,symbolsAPI:getSymbolCount() do
		local symbol = symbolsAPI:getSymbolByIndex(i-1)
		local worldX = symbol:getWorldX()
		local worldY = symbol:getWorldY()
		local r = symbol:getRed()
		local g = symbol:getGreen()
		local b = symbol:getBlue()
		local a = symbol:getAlpha()
		local scale = symbol:getScale()
		local anchorX = symbol:getAnchorX()
		local anchorY = symbol:getAnchorY()
		local rotation = symbol:getRotation()
		local matchPerspective = symbol:isMatchPerspective()
		local applyZoom = symbol:isApplyZoom()
		local minZoom = symbol:getMinZoom()
		local maxZoom = symbol:getMaxZoom()
		if symbol:isText() then
			local text = symbol:getUntranslatedText()
			local layerID = symbol:getLayerID()
            if text then
                script2 = string.format("%s\tsymbol = symbolsAPI:addUntranslatedText(\"%s\", \"%s\", %d, %d)\n",
                    script2, text, layerID, worldX, worldY)
            else
                text = symbol:getTranslatedText()
                script2 = string.format("%s\tsymbol = symbolsAPI:addTranslatedText(\"%s\", \"%s\", %d, %d)\n",
                    script2, text, layerID, worldX, worldY)
            end
            script2 = string.format("%s\tsymbol:setRGBA(%.3f, %.3f, %.3f, %.3f)\n", script2, r, g, b, a)
            script2 = string.format("%s\tsymbol:setScale(%.3f)\n", script2, scale)
            script2 = string.format("%s\tsymbol:setAnchor(%.2f, %.2f)\n", script2, anchorX, anchorY)
            script2 = string.format("%s\tsymbol:setRotation(%.1f)\n", script2, rotation)
            script2 = string.format("%s\tsymbol:setMatchPerspective(%s)\n", script2, matchPerspective and "true" or "false")
            script2 = string.format("%s\tsymbol:setApplyZoom(%s)\n", script2, applyZoom and "true" or "false")
            script2 = string.format("%s\tsymbol:setMinZoom(%.2f)\n", script2, minZoom)
            script2 = string.format("%s\tsymbol:setMaxZoom(%.2f)\n", script2, maxZoom)
            script2 = string.format("%s\tsymbol:setUserDefined(false)\n", script2)
		end
		if symbol:isTexture() then
			local symbolID = symbol:getSymbolID()
            script2 = string.format("%s\tsymbol = symbolsAPI:addTexture(\"%s\", %d, %d)\n",
                script2, symbolID, worldX, worldY)
            script2 = string.format("%s\tsymbol:setRGBA(%.3f, %.3f, %.3f, %.3f)\n", script2, r, g, b, a)
            script2 = string.format("%s\tsymbol:setScale(%.3f)\n", script2, scale)
            script2 = string.format("%s\tsymbol:setAnchor(%.2f, %.2f)\n", script2, anchorX, anchorY)
            script2 = string.format("%s\tsymbol:setRotation(%.1f)\n", script2, rotation)
            script2 = string.format("%s\tsymbol:setMatchPerspective(%s)\n", script2, matchPerspective and "true" or "false")
            script2 = string.format("%s\tsymbol:setApplyZoom(%s)\n", script2, applyZoom and "true" or "false")
            script2 = string.format("%s\tsymbol:setMinZoom(%.2f)\n", script2, minZoom)
            script2 = string.format("%s\tsymbol:setMaxZoom(%.2f)\n", script2, maxZoom)
            script2 = string.format("%s\tsymbol:setUserDefined(false)\n", script2)
		end
        if i < symbolsAPI:getSymbolCount() then
            script2 = script2 .. "\n"
        end
	end
    script2 = script2 .. "end\n"
	return script2
end

function WorldMapEditorMode_Annotations:new(editor)
	local o = WorldMapEditorMode.new(self, editor)
	return o
end

