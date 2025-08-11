--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require 'ISUI/Maps/Editor/WorldMapEditorMode'

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local CELL_SIZE_SQUARES = getCellSizeInSquares()
local CHUNK_SIZE_SQUARES = getChunkSizeInSquares()

WorldMapEditorMode_Streets = WorldMapEditorMode:derive("WorldMapEditorMode_Streets")

local function roundToPoint5(value)
    return round(value * 2) / 2
end

function WorldMapEditorMode_Streets:createChildren()
	local buttonPadding = UI_BORDER_SPACING*2
	local button = ISButton:new(UI_BORDER_SPACING, UI_BORDER_SPACING*2+BUTTON_HGT, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_CreateStreet"), self, self.onCreateStreet)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
    button.tooltip = getText("IGUI_WorldMapEditor_CreateStreet_tt")
    self:addChild(button)
	self.buttonCreateStreet = button

	button = ISButton:new(UI_BORDER_SPACING, button:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_EditStreet"), self, self.onSelectStreet)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
	button.tooltip = getText("IGUI_WorldMapEditor_EditStreet_tt")
	self:addChild(button)
	self.buttonEditStreet = button

	button = ISButton:new(UI_BORDER_SPACING, button:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_RemoveStreet"), self, self.onRemoveStreet)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
	button.tooltip = getText("IGUI_WorldMapEditor_RemoveStreet_tt")
	self:addChild(button)
	self.buttonRemoveStreet = button

    local entryHgt = BUTTON_HGT
    local label = ISLabel:new(UI_BORDER_SPACING, button:getBottom() + UI_BORDER_SPACING, entryHgt, getText("IGUI_WorldMapEditor_StreetName"), 0, 0, 0, 1, UIFont.Small, true)
    self:addChild(label)
	self.streetNameEntry = ISTextEntryBox:new("", label:getRight() + UI_BORDER_SPACING, button:getBottom() + UI_BORDER_SPACING, 200, entryHgt)
	self.streetNameEntry.onCommandEntered = function(entry) self:onStreetNameEntered() end
	self:addChild(self.streetNameEntry)

    local label = ISLabel:new(UI_BORDER_SPACING, self.streetNameEntry:getBottom() + UI_BORDER_SPACING, entryHgt, getText("IGUI_WorldMapEditor_StreetWidth"), 0, 0, 0, 1, UIFont.Small, true)
    self:addChild(label)
	self.widthEntry = ISTextEntryBox:new("", label:getRight() + UI_BORDER_SPACING, self.streetNameEntry:getBottom() + UI_BORDER_SPACING, 100, entryHgt)
	self.widthEntry.onCommandEntered = function(entry) self:onWidthEntered() end
	self:addChild(self.widthEntry)
	self.widthEntry:setOnlyNumbers(true)
	self.widthEntry.onMouseWheel = function(_self, _delta)
        self:onMouseWheel_Width(_delta)
    end

    self.mapDirList = ISScrollingListBox:new(UI_BORDER_SPACING, self.widthEntry:getBottom() + UI_BORDER_SPACING, 200, FONT_HGT_SMALL * 5);
    self.mapDirList.selected = 0
    self.mapDirList:setFont(UIFont.Small)
    self:addChild(self.mapDirList)

    local dirs = getLotDirectories()
	for i=1,dirs:size() do
		self.mapDirList:addItem(dirs:get(i-1))
	end

	button = ISButton:new(UI_BORDER_SPACING, self.mapDirList:getBottom() + UI_BORDER_SPACING, 80, BUTTON_HGT, getText("IGUI_WorldMapEditor_SaveStreets"), self, self.onSaveStreets)
	button:setWidth(buttonPadding+getTextManager():MeasureStringX(UIFont.Small, button.title))
	button.tooltip = getText("IGUI_WorldMapEditor_SaveStreets_tt")
	self:addChild(button)
end

function WorldMapEditorMode_Streets:render()
    local r,g,b,a = 1.0, 1.0, 1.0, 0.25
    local thickness = 1
    local pickedStreet = self:pickMouseOverStreet()
    self.editorAPI:renderStreetLines(r, g, b, a, thickness)
    if self.selectedStreet then
        self:renderStreetLines(self.selectedStreet)
        self:renderStreetPoints(self.selectedStreet)
    end
    if pickedStreet then
        self:renderStreetLines(pickedStreet)
    end
--[[
    for i=1,self.streetsAPI:getStreetCount() do
        local street = self.streetsAPI:getStreetByIndex(i-1)
        self:renderStreetLines(street)
        if street == self.selectedStreet then
            self:renderStreetPoints(street)
        end
    end
--]]
    local mx = self:getMouseX()
    local my = self:getMouseY()
	if self.mode == "Create" then
		local worldX = self.mapAPI:uiToWorldX(mx, my)
		local worldY = self.mapAPI:uiToWorldY(mx, my)
		worldX = roundToPoint5(worldX)
		worldY = roundToPoint5(worldY)
		local snapX = self.mapAPI:worldToUIX(worldX, worldY)
		local snapY = self.mapAPI:worldToUIY(worldX, worldY)
		self.editor:drawRect(snapX - 5, snapY - 5, 10, 10, 1.0, 0.0, 0.0, 1.0)
		if self.editorStreet then
            self:renderStreetLines(self.editorStreet)
            local numPoints = self.editorStreet:getNumPoints()
            if numPoints > 0 then
                local worldX1 = self.editorStreet:getPointX(numPoints-1)
                local worldY1 = self.editorStreet:getPointY(numPoints-1)
                self:renderStreetLine(worldX1, worldY1, worldX, worldY, 1.0, 1.0, 1.0, 1.0)
            end
            self:renderStreetPoints(self.editorStreet)
        end
    end
    if self.mode == "Select" then
        self.vector2f = self.vector2f or Vector2f.new()
        self.addPointWorldPos = nil
        if self.selectedStreet and (self.selectedStreet == self:pickStreet(mx, my)) and (self:pickStreetPoint(self.selectedStreet, mx, my) == -1) then
            local worldPos = self.selectedStreet:getAddPointLocation(mx, my, self.vector2f)
            if worldPos then
                local uiX = self.mapAPI:worldToUIX(worldPos:x(), worldPos:y())
                local uiY = self.mapAPI:worldToUIY(worldPos:x(), worldPos:y())
                self.editor:drawRect(uiX - 5, uiY - 5, 10, 10, 1.0, 0.0, 0.5, 0.0)
                self.addPointWorldPos = { x=worldPos:x(), y=worldPos:y() }
            end
        end
    end
    self.buttonCreateStreet.textColor.a = (self.mode == "Create") and 1.0 or 0.5
    self.buttonEditStreet.textColor.a = (self.mode == "Select") and 1.0 or 0.5
    self.buttonRemoveStreet.textColor.a = (self.selectedStreet ~= nil) and 1.0 or 0.5

    self.mapAPI:setBoolean("LargeStreetLabel", self.mapAPI:getZoomF() <= 16.0)

    if self.mapDirList.selected ~= self.selectedMapDirectory then
        self:cancelNewStreet()
        self.selectedStreet = nil
        self.selectedMapDirectory = self.mapDirList.selected
        local dirName = self.mapDirList.items[self.mapDirList.selected].text
        local streetData = self.streetsAPI:getStreetDataByRelativeFileName('media/maps/'..dirName..'/streets.xml')
        if not streetData then
            -- This creates the new empty WorldMapStreets object, but does not create the file.
            self.streetsAPI:addStreetData('media/maps/'..dirName..'/streets.xml')
        end
        self.editorAPI:setStreetData('media/maps/'..dirName..'/streets.xml')
    end
end

function WorldMapEditorMode_Streets:renderStreetPoints(street)
    local r,g,b,a = 0.0, 0.0, 0.0, 0.5
    local mx = self:getMouseX()
    local my = self:getMouseY()
    for i=1,street:getNumPoints() do
        local worldX = street:getPointX(i-1)
        local worldY = street:getPointY(i-1)
        local uiX = self.mapAPI:worldToUIX(worldX, worldY)
        local uiY = self.mapAPI:worldToUIY(worldX, worldY)
        if i-1 == self:pickStreetPoint(street, mx, my) then
            if isCtrlKeyDown() and (i > 1) and (i < street:getNumPoints()) then
                self.editor:drawRect(uiX - 5, uiY - 5, 10, 10, 1.0, 1.0, 0.0, 0.0) -- split street
            else
                self.editor:drawRect(uiX - 5, uiY - 5, 10, 10, 1.0, 0.0, 255/255, 244/255)
            end
        elseif i==1 then
            self.editor:drawRect(uiX - 5, uiY - 5, 10, 10, 1.0, 0.0, 0.0, 1.0)
        else
            self.editor:drawRect(uiX - 5, uiY - 5, 10, 10, a, r, g, b)
        end
    end
end

function WorldMapEditorMode_Streets:renderStreetLines(street)
    local r,g,b,a = 1.0, 1.0, 1.0, 0.25
    if street == self.selectedStreet then
        r,g,b,a = 0.0, 162/255, 232/255, 1.0
    end
    if street == self:pickStreet(self:getMouseX(), self:getMouseY()) then
        r,g,b,a = 0.0, 255/255, 244/255, 1.0
    end
    for i=1,street:getNumPoints()-1 do
        local worldX1 = street:getPointX(i-1)
        local worldY1 = street:getPointY(i-1)
        local worldX2 = street:getPointX(i)
        local worldY2 = street:getPointY(i)
        self:renderStreetLine(worldX1, worldY1, worldX2, worldY2, r, g, b, a)
    end
end

function WorldMapEditorMode_Streets:renderStreetLine(worldX1, worldY1, worldX2, worldY2, r, g, b, a)
    local uiX1 = self.mapAPI:worldToUIX(worldX1, worldY1)
    local uiY1 = self.mapAPI:worldToUIY(worldX1, worldY1)
    local uiX2 = self.mapAPI:worldToUIX(worldX2, worldY2)
    local uiY2 = self.mapAPI:worldToUIY(worldX2, worldY2)
    local thickness = 1
    self.editor.javaObject:DrawLine(nil, uiX1, uiY1, uiX2, uiY2, thickness, r, g, b, a)
end

function WorldMapEditorMode_Streets:pickMouseOverStreet()
    local streetsAPI = self.streetsAPI
    streetsAPI:setMouseOverStreet(nil, 0.0, 0.0)
    if self:isMouseOverChild() then return end -- mouse is over UI
    if not self.mapAPI:getBoolean("ShowStreetNames") then return end
    local mx,my = self:getMouseX(), self:getMouseY()
    if not self.editorAPI:canPickStreet(mx, my) then return end
    local mouseOverStreet = self.editorAPI:pickStreet(mx, my)
    if not mouseOverStreet then return end
    local worldX = self.mapAPI:uiToWorldX(mx, my)
    local worldY = self.mapAPI:uiToWorldY(mx, my)
    self.editorAPI:setMouseOverStreet(mouseOverStreet, worldX, worldY)
    return mouseOverStreet
end

function WorldMapEditorMode_Streets:display()
	WorldMapEditorMode.display(self)
	MapUtils.initDefaultMapData(self.mapUI)
	self.mapAPI:setBoundsFromData()
	MapUtils.initDefaultStyleV3(self.mapUI)
	MapUtils.overlayPaper(self.mapUI)
	self.mapAPI:resetView()
	self.mapAPI:setBoolean("HighlightStreet", true)
	self.mapAPI:setBoolean("OutlineStreets", true)
	self.mapAPI:setBoolean("ShowStreetNames", true)
	self.streetsAPI:clearStreetData()
	local dirs = getLotDirectories()
	local dirName = dirs:get(dirs:size()-1)
	self.streetsAPI:addStreetData('media/maps/'..dirName..'/streets.xml')
	self.editorAPI:setStreetData('media/maps/'..dirName..'/streets.xml')
	self.mapDirList.selected = dirs:size()
	self.selectedMapDirectory = dirs:size()
end

function WorldMapEditorMode_Streets:undisplay()
	self.mapAPI:setBoolean("ShowStreetNames", false)
	self.mapAPI:setBoolean("OutlineStreets", false)
	WorldMapEditorMode.undisplay(self)
end

function WorldMapEditorMode_Streets:onMouseDown(x, y)
    self.mouseDown = true
    self.mouseMoved = false
    self.pressX = x
    self.pressY = y
	if self.mode == "Create" then
		if self.editorStreet == nil then
            self.editorStreet = self.editorAPI:createEditorStreet()
        end
		return true
	end
	if self.mode == "Select" then
        self.dragPoint = -1
		if self.selectedStreet and (self.addPointWorldPos == nil) then
            self.dragPoint = self:pickStreetPoint(self.selectedStreet, x, y)
        end
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Streets:onMouseUp(x, y)
    if not self.mouseDown then return false end
    self.mouseDown = false
	if self.mode == "Create" then
        if self.mouseMoved then return false end -- dragged the view
        local worldX = self.mapAPI:uiToWorldX(x, y)
        local worldY = self.mapAPI:uiToWorldY(x, y)
		worldX = roundToPoint5(worldX)
		worldY = roundToPoint5(worldY)
		if not self:streetContainsPoint(self.editorStreet, worldX, worldY) then
            self.editorStreet:addPoint(worldX, worldY)
        end
		return true
	end
	if self.mode == "Select" then
        if self.mouseMoved then return false end -- dragged the view
        if self.selectedStreet and (self.addPointWorldPos ~= nil) then
            self.selectedStreet:insertPoint(self.addPointWorldPos.x, self.addPointWorldPos.y)
            return true
        end
        if isCtrlKeyDown() and self.selectedStreet ~= nil and self.dragPoint ~= -1 then
            self.editorAPI:splitStreet(self.selectedStreet, self.dragPoint)
            return true
        end
        self.selectedStreet = self:pickStreet(x, y)
        if self.selectedStreet then
            self.streetNameEntry:setText(self.selectedStreet:getTranslatedText())
            self.widthEntry:setText(tostring(self.selectedStreet:getWidth()))
        else
            self.streetNameEntry:clear()
        end
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Streets:onMouseUpOutside(x, y)
	return self:onMouseUp(x, y)
end

function WorldMapEditorMode_Streets:onMouseMove(dx, dy)
    local mx = self:getMouseX()
    local my = self:getMouseY()
    if self.mouseDown then
        if math.abs(mx - self.pressX) > 4 or math.abs(my - self.pressY) > 4 then
            if not self.mouseMoved then
                if self.mode ~= "Select" or self.dragPoint == -1 then
                    self.editor:onMouseDown(self.pressX, self.pressY) -- start dragging the view
                end
                self.mouseMoved = true
            end
        end
    end
	if self.mode == "Create" then
        if self.mouseDown and self.mouseMoved then
            return false -- drag the view
        end
		return true
	end
	if self.mode == "Select" then
        if self.mouseDown and (self.dragPoint ~= -1) then
            local worldX = self.mapAPI:uiToWorldX(mx, my)
            local worldY = self.mapAPI:uiToWorldY(mx, my)
            worldX = roundToPoint5(worldX)
            worldY = roundToPoint5(worldY)
            self.selectedStreet:setPoint(self.dragPoint, worldX, worldY)
        end
		return true
	end
	if self.mode then
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Streets:onRightMouseDown(x, y)
	if self.mode == "Create" then
		if self.editorStreet then
            if self.editorStreet:getNumPoints() > 1 then
                self.editorAPI:addStreet(self.editorStreet)
            end
            self.editorStreet = nil
        end
		return true
	end
	return false -- allow clicks in the map
end

function WorldMapEditorMode_Streets:onKeyPress(key)
	if key == Keyboard.KEY_DELETE then
        local mx,my = self:getMouseX(), self:getMouseY()
        if self.mode == "Select" and self.selectedStreet then
            local point = self:pickStreetPoint(self.selectedStreet, mx, my)
            if point ~= -1 and self.selectedStreet:getNumPoints() > 2 then
                self.selectedStreet:removePoint(point)
            end
        end
        return true
	end
    if key == Keyboard.KEY_R then
        if self.selectedStreet then
            self.selectedStreet:reverseDirection()
        end
    end
	if key == Keyboard.KEY_ESCAPE then
        if self:cancelNewStreet() then
            return true
        end
	end
	return false
end

function WorldMapEditorMode_Streets:pickStreet(x, y)
    return self.editorAPI:pickStreet(x, y)
end

function WorldMapEditorMode_Streets:pickStreetPoint(street, x, y)
    return street:pickPoint(x, y)
end

function WorldMapEditorMode_Streets:streetContainsPoint(street, x, y)
    for i=1,street:getNumPoints() do
        if x == street:getPointX(i-1) and y == street:getPointY(i-1) then
            return true
        end
    end
    return false
end

function WorldMapEditorMode_Streets:onCreateStreet()
    self.mode = "Create"
end

function WorldMapEditorMode_Streets:onSelectStreet()
    self.mode = "Select"
end

function WorldMapEditorMode_Streets:onRemoveStreet()
    if self.selectedStreet == nil then return end
    self.editorAPI:removeStreet(self.selectedStreet)
    self.selectedStreet = nil
end

function WorldMapEditorMode_Streets:onStreetNameEntered()
	if not self.selectedStreet then return end
	local text = self.streetNameEntry:getText()
	self.selectedStreet:setTranslatedText(text)
end

function WorldMapEditorMode_Streets:onWidthEntered()
	if not self.selectedStreet then return end
	local width = tonumber(self.widthEntry:getText())
    self.selectedStreet:setWidth(width)
end

function WorldMapEditorMode_Streets:onMouseWheel_Width(delta)
	if not self.selectedStreet then return end
	if delta > 0 then delta = -1 else delta = 1 end
	local width = self.selectedStreet:getWidth() + delta
    self.selectedStreet:setWidth(width)
    self.widthEntry:setText(tostring(width))
end

function WorldMapEditorMode_Streets:onSaveStreets()
	self.editorAPI:save()
end

function WorldMapEditorMode_Streets:cancelNewStreet()
    if self.editorStreet then
        self.editorAPI:freeEditorStreet(self.editorStreet)
        self.editorStreet = nil
        return true
    end
    return false
end

function WorldMapEditorMode_Streets:new(editor)
	local o = WorldMapEditorMode.new(self, editor)
	o.streetsAPI = o.mapAPI:getStreetsAPI()
	o.editorAPI = o.streetsAPI:getEditorAPI()
	o.selectedStreet = nil
	return o
end

