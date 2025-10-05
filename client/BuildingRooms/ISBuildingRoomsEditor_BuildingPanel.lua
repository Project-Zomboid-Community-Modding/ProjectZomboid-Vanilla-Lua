--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISButton"
require "ISUI/ISPanelJoypad"
require "ISUI/ISScrollingListBox"

ISBuildingRoomsEditor_BuildingPanel = ISPanelJoypad:derive("ISBuildingRoomsEditor_BuildingPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISBuildingRoomsEditor_BuildingPanel:createChildren()
    self.listBox = ISScrollingListBox:new(UI_BORDER_SPACING, UI_BORDER_SPACING, 200, 200)
    self.listBox.drawBorder = true
    self.listBox.disableJoypadNavigation = true
    self.listBox:setFont(UIFont.Small, 4)
    self:addChild(self.listBox)

    local buttonWid = 150
    local button1 = ISButton:new(self.listBox:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING, buttonWid, BUTTON_HGT,
        getText("IGUI_BuildingRoomsEditor_ButtonAddBuilding"), self, self.onButton1)
    self:addChild(button1)
    self.button1 = button1

    local button2 = ISButton:new(button1.x, button1:getBottom() + UI_BORDER_SPACING, buttonWid, BUTTON_HGT,
        getText("IGUI_BuildingRoomsEditor_ButtonRemoveBuilding"), self, self.onButton2)
    self:addChild(button2)
    self.button2 = button2

    local buttonWid = math.max(button1.width, button2.width)
    button1:setWidth(buttonWid)
    button2:setWidth(buttonWid)

    self:shrinkWrap(UI_BORDER_SPACING, UI_BORDER_SPACING, nil)
end

function ISBuildingRoomsEditor_BuildingPanel:update()
    if self.selectedBuilding ~= self:getSelectedBuilding() then
        self.selectedBuilding = self:getSelectedBuilding()
        self.javaEditor:setCurrentBuilding(self.selectedBuilding)
        self.editor:OnEvent("AfterSelectBuilding", self.selectedBuilding)
    end
    local modalVisible = self.modalInProgress ~= nil
    self.button1:setEnable(not modalVisible)
    self.button2:setEnable(self.selectedBuilding ~= nil and not modalVisible)

    self:setDefaultButtonColor(self.button1)
	local r,g,b = 0.0, 162/255, 232/255
    if self.editor.currentTool == self.editor.toolAddBuilding then
        self:setButtonColor(self.button1, r, g, b)
    end

    self:updateItemColors()
end

function ISBuildingRoomsEditor_BuildingPanel:fillList()
    self.listBox:clear()
    for i=1,self.javaEditor:getBuildingCount() do
        self.listBox:addItem("Building #"..i)
    end
end

function ISBuildingRoomsEditor_BuildingPanel:updateItemColors()
    local badHC = getCore():getBadHighlitedColor()
    local badR = badHC:getR()
    local badG = badHC:getG()
    local badB = badHC:getB()
    for i=1,self.javaEditor:getBuildingCount() do
        local building = self.javaEditor:getBuildingByIndex(i-1)
        if building:isValid() then
            self.listBox:setItemTextColorToDefault(i)
            self.listBox:setItemSelectedTextColorToDefault(i)
        else
            self.listBox:setItemTextColorRGBA(i, badR, badG, badB, 1.0)
            self.listBox:setItemSelectedTextColorRGBA(i, badR, badG, badB, 1.0)
        end
    end
end

function ISBuildingRoomsEditor_BuildingPanel:getSelectedBuilding()
    if self.editor.currentTool == self.editor.toolAddBuilding then return nil end
    local index = self.listBox.selected
    if not self.listBox.items[index] then return nil end
    return self.javaEditor:getBuildingByIndex(index-1)
end

function ISBuildingRoomsEditor_BuildingPanel:onButton1()
    if self.editor.currentTool == self.editor.toolAddBuilding then
        self.editor:setCurrentTool(nil)
        return
    end
    self.editor:setCurrentTool(self.editor.toolAddBuilding)
end

function ISBuildingRoomsEditor_BuildingPanel:onButton2()
    local building = self:getSelectedBuilding()
    if building == nil then return end
    self:askRemoveBuilding()
end

function ISBuildingRoomsEditor_BuildingPanel:setButtonColor(button, r, g, b)
	button:setBackgroundRGBA(r, g, b, 0.25)
	button:setBackgroundColorMouseOverRGBA(r, g, b, 0.50)
	button:setBorderRGBA(r, g, b, 1)
end

function ISBuildingRoomsEditor_BuildingPanel:setDefaultButtonColor(button)
	button:setBackgroundRGBA(0.0, 0.0, 0.0, 1.0)
	button:setBackgroundColorMouseOverRGBA(0.3, 0.3, 0.3, 1.0)
	button:setBorderRGBA(0.7, 0.7, 0.7, 1.0)
end

function ISBuildingRoomsEditor_BuildingPanel:askRemoveBuilding()
    local buildingName = self.listBox.items[self.listBox.selected].text
    local building = self:getSelectedBuilding()
    local text = getText("IGUI_BuildingRoomsEditor_AskRemoveBuilding") .. "\n" .. getText("IGUI_BuildingRoomsEditor_AskRemoveBuilding2", buildingName, building:getRoomCount())
    local modal = ISModalDialog:new(0, 0, 350, 150, text, true, self, self.confirmRemoveBuilding)
    modal:initialise()
    modal:addToUIManager()
    modal.moveWithMouse = true
    modal:centerOnScreen(self.playerNum)
    if getJoypadData(self.playerNum) then
        modal.prevFocus = self
        setJoypadFocus(self.playerNum, modal)
    end
    self.modalInProgress = modal
end

function ISBuildingRoomsEditor_BuildingPanel:confirmRemoveBuilding(button)
    self.modalInProgress = nil
    if button.internal == "YES" then
        local building = self:getSelectedBuilding()
        self.javaEditor:removeBuilding(building)
        self.editor.hasChanges = true
    end
end

function ISBuildingRoomsEditor_BuildingPanel:selectPlayerBuilding()
    local playerObj = getSpecificPlayer(self.playerNum)
    for i=1,self.listBox:size() do
        local building = self.javaEditor:getBuildingByIndex(i-1)
        local roomIndex = building:getRoomIndexAt(playerObj:getX(), playerObj:getY(), playerObj:getZ())
        if roomIndex ~= -1 then
            self.listBox.selected = i
            break
        end
    end
end

function ISBuildingRoomsEditor_BuildingPanel:OnEvent(event, arg1, arg2, arg3, arg4)
    if event == "BeforeAddBuilding" then
        return
    end
    if event == "AfterAddBuilding" then
        self:fillList()
        self.listBox.selected = self.listBox:size()
        return
    end
    if event == "BeforeRemoveBuilding" then
        return
    end
    if event == "AfterRemoveBuilding" then
        self:fillList()
        return
    end
    if event == "AfterClear" then
        self:fillList()
        return
    end
end

function ISBuildingRoomsEditor_BuildingPanel:onGainJoypadFocus(joypadData)
    if self:isDescendant(joypadData.switchingFocusFrom) then
        -- nothing
    else
        ISPanelJoypad.onGainJoypadFocus(self, joypadData)
        self.joypadIndex = 1
        self.joypadIndexY = 1
        self.joypadButtons = {}
        self.joypadButtonsY = {}
        self:insertNewLineOfButtons(self.listBox, self.button1)
        self:insertNewLineOfButtons(self.button2)
        self:restoreJoypadFocus(joypadData)
    end
end

function ISBuildingRoomsEditor_BuildingPanel:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus(joypadData)
end

function ISBuildingRoomsEditor_BuildingPanel:onJoypadDirLeft(joypadData)
    if self.joypadIndexY > 1 then
        self:clearJoypadFocus()
        self.joypadIndex = 2
        self.joypadIndexY = 1
    end
    ISPanelJoypad.onJoypadDirLeft(self, joypadData)
end

function ISBuildingRoomsEditor_BuildingPanel:onJoypadDirRight_Descendant(descendant, joypadData)
    if descendant == self.listBox then
        joypadData.focus = self
        updateJoypadFocus(joypadData)
        self:onJoypadDirRight(joypadData)
    end
end

function ISBuildingRoomsEditor_BuildingPanel:hasConflictWithJoypadNavigateStart()
	return true
end

function ISBuildingRoomsEditor_BuildingPanel:new(x, y, w, h, editor)
    local o = ISPanelJoypad.new(self, x, y, w, h)
    o.playerNum = editor.playerNum
    o.editor = editor
    o.javaEditor = editor.javaEditor
    return o
end