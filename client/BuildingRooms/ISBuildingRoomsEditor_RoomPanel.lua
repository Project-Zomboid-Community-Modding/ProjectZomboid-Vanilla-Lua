--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISButton"
require "ISUI/ISPanelJoypad"
require "ISUI/ISScrollingListBox"

ISBuildingRoomsEditor_RoomPanel = ISPanelJoypad:derive("ISBuildingRoomsEditor_RoomPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISBuildingRoomsEditor_RoomPanel:createChildren()
    self.listBox = ISScrollingListBox:new(UI_BORDER_SPACING, UI_BORDER_SPACING, 200, 200)
    self.listBox.drawBorder = true
    self.listBox.disableJoypadNavigation = true
    self.listBox:setFont(UIFont.Small, 4)
    self:addChild(self.listBox)

    local buttonWid = 150
    local button1 = ISButton:new(self.listBox:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING, buttonWid, BUTTON_HGT,
        getText("IGUI_BuildingRoomsEditor_ButtonAddRoom"), self, self.onButton1)
    self:addChild(button1)
    self.button1 = button1

    local button2 = ISButton:new(button1.x, button1:getBottom() + UI_BORDER_SPACING, buttonWid, BUTTON_HGT,
       getText("IGUI_BuildingRoomsEditor_ButtonRemoveRoom"), self, self.onButton2)
    self:addChild(button2)
    self.button2 = button2

    local button3 = ISButton:new(button2.x, button2:getBottom() + UI_BORDER_SPACING, buttonWid, BUTTON_HGT,
        getText("IGUI_BuildingRoomsEditor_ButtonAddRectangle"), self, self.onButton3)
    self:addChild(button3)
    self.button3 = button3

    local button4 = ISButton:new(button3.x, button3:getBottom() + UI_BORDER_SPACING, buttonWid, BUTTON_HGT,
        getText("IGUI_BuildingRoomsEditor_ButtonRemoveRectangle"), self, self.onButton4)
    self:addChild(button4)
    self.button4 = button4

    self.nameEntry = ISTextEntryBox:new("", button4.x, button4:getBottom() + UI_BORDER_SPACING, buttonWid, FONT_HGT_SMALL + 2 * 2)
    self.nameEntry.onCommandEntered = function(_self) _self.parent:onNameEntered() end
    self.nameEntry.onTextChange = function(_self) _self.parent:onNameChange() end
    self:addChild(self.nameEntry)
    self.nameEntry:setTextRGBA(0.66, 0.66, 0.66, 1.0)

    local rightWid = math.max(button1.width, button2.width, button3.width, button4.width, self.nameEntry.width)
    button1:setWidth(rightWid)
    button2:setWidth(rightWid)
    button3:setWidth(rightWid)
    button4:setWidth(rightWid)
    self.nameEntry:setWidth(rightWid)

    self:shrinkWrap(UI_BORDER_SPACING, UI_BORDER_SPACING, nil)
end

function ISBuildingRoomsEditor_RoomPanel:onNameEntered()
end

function ISBuildingRoomsEditor_RoomPanel:onNameChange()
    local room = self:getSelectedRoom()
    if not room then return end
    room:setName(self.nameEntry:getInternalText())
end

function ISBuildingRoomsEditor_RoomPanel:update()
    self:trackPlayerRoom()
    local room = self:getSelectedRoom()
    self.javaEditor:setCurrentRoom(room)
    if self.listBox:isMouseOver() then
        local item = self.listBox.items[self.listBox.mouseoverselected]
        if item then
            local room1 = self.building:getRoomByIndex(self.listBox.mouseoverselected-1)
            self.javaEditor:setCurrentRoom(room1)
        end
    end

    self:setDefaultButtonColor(self.button1)
    self:setDefaultButtonColor(self.button2)
    self:setDefaultButtonColor(self.button3)
    self:setDefaultButtonColor(self.button4)

    local modalVisible = self.modalInProgress ~= nil
    self.button1:setEnable(self.building ~= nil and not modalVisible)
    self.button2:setEnable(room ~= nil and not modalVisible)
    self.button3:setEnable(room ~= nil and not modalVisible)
    self.button4:setEnable(room ~= nil and not modalVisible)

	local r,g,b = 0.0, 162/255, 232/255
    if self.editor.currentTool == self.editor.toolAddRoom then
        self:setButtonColor(self.button1, r, g, b)
    end
    if self.editor.currentTool == self.editor.toolAddRect then
        self:setButtonColor(self.button3, r, g, b)
    end
    if self.editor.currentTool == self.editor.toolRemoveRect then
        self:setButtonColor(self.button4, r, g, b)
    end

    if room ~= self.selectedRoom then
        self.selectedRoom = room
        if room then
            self.nameEntry:setEditable(true)
            self.nameEntry:setText(room:getName())
        else
            self.nameEntry:clear()
            self.nameEntry:setEditable(false)
        end
    end

    self:updateItemColors()
end

function ISBuildingRoomsEditor_RoomPanel:trackPlayerRoom()
    if not self.building then return end
    local playerObj = getSpecificPlayer(self.playerNum)
    local roomIndex = self.building:getRoomIndexAt(playerObj:getX(), playerObj:getY(), playerObj:getZ())
    if roomIndex ~= self.playerRoomIndex then
        self.playerRoomIndex = roomIndex
        if roomIndex ~= -1 then
            self.listBox.selected = roomIndex + 1
        end
    end
end

function ISBuildingRoomsEditor_RoomPanel:setButtonColor(button, r, g, b)
	button:setBackgroundRGBA(r, g, b, 0.25)
	button:setBackgroundColorMouseOverRGBA(r, g, b, 0.50)
	button:setBorderRGBA(r, g, b, 1)
end

function ISBuildingRoomsEditor_RoomPanel:setDefaultButtonColor(button)
	button:setBackgroundRGBA(0.0, 0.0, 0.0, 1.0)
	button:setBackgroundColorMouseOverRGBA(0.3, 0.3, 0.3, 1.0)
	button:setBorderRGBA(0.7, 0.7, 0.7, 1.0)
end

function ISBuildingRoomsEditor_RoomPanel:fillList()
    self.listBox:clear()
    local building = self.editor:getSelectedBuilding()
    self.building = building
    if not building then return end
    for i=1,building:getRoomCount() do
        local room = building:getRoomByIndex(i-1)
        local listItem = self.listBox:addItem("Room #"..i)
        if room:getLevel() ~= self.editor.currentLevel then
            listItem.height = 0
        end
    end
    self.listBox.selected = self.listBox:nextVisibleIndex(0)
end

function ISBuildingRoomsEditor_RoomPanel:updateItemColors()
    local badHC = getCore():getBadHighlitedColor()
    local badR = badHC:getR()
    local badG = badHC:getG()
    local badB = badHC:getB()
    local building = self.editor:getSelectedBuilding()
    self.building = building
    if not self.building then return end
    for i=1,self.building:getRoomCount() do
        local room = self.building:getRoomByIndex(i-1)
        if room:getName() ~= nil and room:getName() ~= "" then
            self.listBox.items[i].text = room:getName()
        else
            self.listBox.items[i].text = "Room "..i
        end
        if room:isValid() then
            self.listBox:setItemTextColorToDefault(i)
            self.listBox:setItemSelectedTextColorToDefault(i)
        else
            self.listBox:setItemTextColorRGBA(i, badR, badG, badB, 1.0)
            self.listBox:setItemSelectedTextColorRGBA(i, badR, badG, badB, 1.0)
        end
    end
end

function ISBuildingRoomsEditor_RoomPanel:getSelectedRoom()
    local index = self.listBox.selected
    if not self.listBox.items[index] then return nil end
    return self.building:getRoomByIndex(index-1)
end

function ISBuildingRoomsEditor_RoomPanel:onButton1()
    if self.editor.currentTool == self.editor.toolAddRoom then
        self.editor:setCurrentTool(nil)
        return
    end
    self.editor:setCurrentTool(self.editor.toolAddRoom)
end

function ISBuildingRoomsEditor_RoomPanel:onButton2()
    self.editor:setCurrentTool(nil)
    self:askRemoveRoom()
end

function ISBuildingRoomsEditor_RoomPanel:onButton3()
    if self.editor.currentTool == self.editor.toolAddRect then
        self.editor:setCurrentTool(nil)
        return
    end
    self.editor:setCurrentTool(self.editor.toolAddRect)
end

function ISBuildingRoomsEditor_RoomPanel:onButton4()
    if self.editor.currentTool == self.editor.toolRemoveRect then
        self.editor:setCurrentTool(nil)
        return
    end
    self.editor:setCurrentTool(self.editor.toolRemoveRect)
end

function ISBuildingRoomsEditor_RoomPanel:askRemoveRoom()
    local roomName = self.listBox.items[self.listBox.selected].text
    local text = getText("IGUI_BuildingRoomsEditor_AskRemoveRoom") .. "\n" .. roomName
    local modal = ISModalDialog:new(0, 0, 350, 150, text, true, self, self.confirmRemoveRoom)
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

function ISBuildingRoomsEditor_RoomPanel:confirmRemoveRoom(button)
    self.modalInProgress = nil
    if button.internal == "YES" then
        local room = self:getSelectedRoom()
        self.building:removeRoom(room)
        self.editor.hasChanges = true
    end
end

function ISBuildingRoomsEditor_RoomPanel:OnEvent(event, arg1, arg2, arg3, arg4)
    if event == "BeforeAddBuilding" then
        return
    end
    if event == "AfterAddBuilding" then
        return
    end
    if event == "BeforeRemoveBuilding" then
        return
    end
    if event == "AfterRemoveBuilding" then
        if arg1 == self.building then
            self:fillList()
        end
        return
    end
    if event == "BeforeAddRoom" then
        return
    end
    if event == "AfterAddRoom" then
        if arg1 == self.building then
            self:fillList()
            self.listBox.selected = self.listBox:size()
        end
        return
    end
    if event == "BeforeRemoveRoom" then
        return
    end
    if event == "AfterRemoveRoom" then
        if arg1 == self.building then
            self:fillList()
        end
        return
    end
    if event == "AfterSelectBuilding" then
        self:fillList()
        return
    end
    if event == "CurrentLevelChanged" then
        self:fillList()
        return
    end
    if event == "AfterClear" then
        self:fillList()
        return
    end
end

function ISBuildingRoomsEditor_RoomPanel:onGainJoypadFocus(joypadData)
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
        self:insertNewLineOfButtons(self.button3)
        self:insertNewLineOfButtons(self.button4)
        self:insertNewLineOfButtons(self.nameEntry)
        if self.editor.previousFocusTool == self.editor.toolAddRoom then
            self.joypadIndex = 2
        elseif self.editor.previousFocusTool == self.editor.toolAddRect then
            self.joypadIndexY = 3
        elseif self.editor.previousFocusTool == self.editor.toolRemoveRect then
            self.joypadIndexY = 4
        end
        self:restoreJoypadFocus(joypadData)
    end
end

function ISBuildingRoomsEditor_RoomPanel:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus(joypadData)
end

function ISBuildingRoomsEditor_RoomPanel:onJoypadDirLeft(joypadData)
    -- Focus is on right-side buttons
    if self.joypadIndexY > 1 then
        self:clearJoypadFocus()
        self.joypadIndex = 2
        self.joypadIndexY = 1
    end
    ISPanelJoypad.onJoypadDirLeft(self, joypadData)
end

function ISBuildingRoomsEditor_RoomPanel:onJoypadDirRight_Descendant(descendant, joypadData)
    if descendant == self.listBox then
        joypadData.focus = self
        updateJoypadFocus(joypadData)
        self:onJoypadDirRight(joypadData)
    end
end

function ISBuildingRoomsEditor_RoomPanel:hasConflictWithJoypadNavigateStart()
	return true
end

function ISBuildingRoomsEditor_RoomPanel:new(x, y, w, h, editor)
    local o = ISPanelJoypad.new(self, x, y, w, h)
    o.editor = editor
    o.javaEditor = editor.javaEditor
    o.playerNum = editor.playerNum
    o.playerRoomIndex = -1
    return o
end
