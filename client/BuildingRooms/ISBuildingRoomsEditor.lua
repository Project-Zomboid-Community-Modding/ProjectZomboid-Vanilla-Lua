--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "BuildingRooms/ISBuildingRoomsEditor_BuildingPanel"
require "BuildingRooms/ISBuildingRoomsEditor_RoomPanel"
--require "BuildingRooms/ISBuildingRoomsEditor_ToolAddBuilding"
--require "BuildingRooms/ISBuildingRoomsEditor_ToolAddRect"
--require "BuildingRooms/ISBuildingRoomsEditor_ToolAddRoom"
--require "BuildingRooms/ISBuildingRoomsEditor_ToolRemoveRect"
require "ISUI/ISCollapsableWindowJoypad"
require "ISUI/ISPanelJoypad"
require "ISUI/ISScrollingListBox"
require "ISUI/ISTabPanel"

ISBuildingRoomsEditor = ISCollapsableWindowJoypad:derive("ISBuildingRoomsEditor")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISBuildingRoomsEditor:createChildren()
    ISCollapsableWindowJoypad.createChildren(self)

    local ignoreChildren = self.javaObject:getControls():size()

    self.contents = ISPanelJoypad:new(0, 0, self.width, self.height - self:titleBarHeight())
    self.contents.anchorRight = true
    self.contents.anchorBottom = true
    self:addView(self.contents)

    local belowTabsHgt = BUTTON_HGT + UI_BORDER_SPACING * 2

    self.tabPanel = ISTabPanel:new(0, 0, self.contents.width, self.contents.height - belowTabsHgt);
    self.tabPanel.anchorRight = true
    self.tabPanel.anchorBottom = true
    self.contents:addChild(self.tabPanel)

    self.buildingPanel = ISBuildingRoomsEditor_BuildingPanel:new(0, 0, self.tabPanel.width, self.tabPanel.height - self.tabPanel.tabHeight, self)
    self.buildingPanel.anchorRight = true
    self.buildingPanel.anchorBottom = true
    self.tabPanel:addView(getText("IGUI_BuildingRoomsEditor_TabBuildings"), self.buildingPanel)

    self.roomPanel = ISBuildingRoomsEditor_RoomPanel:new(0, 0, self.tabPanel.width, self.tabPanel.height - self.tabPanel.tabHeight, self)
    self.roomPanel.anchorRight = true
    self.roomPanel.anchorBottom = true
    self.tabPanel:addView(getText("IGUI_BuildingRoomsEditor_TabRooms"), self.roomPanel)

    self.buildingPanel:setWidth(math.max(self.buildingPanel.width, self.roomPanel.width))
    self.buildingPanel:setHeight(math.max(self.buildingPanel.height, self.roomPanel.height))
    self.roomPanel:setWidth(self.buildingPanel.width)
    self.roomPanel:setHeight(self.buildingPanel.height)
    self.tabPanel:shrinkWrap(0, 0, nil)
    self.tabPanel:ignoreWidthChange()
    self.tabPanel:ignoreHeightChange()

    local buttonWid = 120
    local buttonApply = ISButton:new(UI_BORDER_SPACING, self.tabPanel:getBottom() + UI_BORDER_SPACING, buttonWid, BUTTON_HGT,
        getText("IGUI_BuildingRoomsEditor_ButtonApply"), self, self.onButtonApply)
    buttonApply:enableAcceptColor()
    self.buttonApply = buttonApply
    self.contents:addChild(buttonApply)

    -- This is the ISCollapsableWindow title-bar close button.
    self.closeButton.onclick = self.onButtonClose

    local buttonClose = ISButton:new(buttonApply:getRight() + UI_BORDER_SPACING, buttonApply.y, buttonWid, BUTTON_HGT, getText("UI_Close"), self, self.onButtonClose)
    buttonClose:enableCancelColor()
    self.buttonClose = buttonClose
    self.contents:addChild(buttonClose)

    self.contents:shrinkWrap(0, UI_BORDER_SPACING, nil)
    self.contents:ignoreWidthChange()
    self.contents:ignoreHeightChange()
    self:shrinkWrap(0, 0, function(_child)
--        if _child == self.resizeWidget or _child == self.resizeWidget2 then return false end
        return self.javaObject:getControls():indexOf(_child.javaObject) >= ignoreChildren
    end)
    self:ignoreWidthChange()
    self:ignoreHeightChange()

    local maxButtonWidth = math.max(buttonApply.width, buttonClose.width)
    local buttonsWidth = maxButtonWidth + UI_BORDER_SPACING + maxButtonWidth
    buttonApply:setWidth(maxButtonWidth)
    buttonClose:setWidth(maxButtonWidth)
    buttonApply:setX(self.width / 2 - buttonsWidth / 2)
    buttonClose:setX(buttonApply:getRight() + UI_BORDER_SPACING)
end

function ISBuildingRoomsEditor:onButtonApply()
    self:setCurrentTool(nil)
    self:askApplyChanges(false)
end

function ISBuildingRoomsEditor:onButtonClose()
    if self.hasChanges then
        self:setCurrentTool(nil)
        self:askApplyChanges(true)
    else
        self:close()
    end
end

function ISBuildingRoomsEditor:render()
    ISCollapsableWindowJoypad.render(self)
    self:renderJoypadNavigateOverlay(self.playerNum)
end

function ISBuildingRoomsEditor:update()
    ISCollapsableWindowJoypad.update(self)
    if not getSpecificPlayer(self.playerNum) then
        self:close()
        return
    end

    self.title = getText("IGUI_BuildingRoomsEditor_Title")
    if self.hasChanges then
        self.title = self.title .. " *"
    end

    local z = math.floor(getSpecificPlayer(self.playerNum):getZ())
    if z ~= self.currentLevel then
        self.currentLevel = z
        self.javaEditor:setCurrentLevel(z)
        self:OnEvent("CurrentLevelChanged", z)
    end
    local modalVisible = self.buildingPanel.modalInProgress ~= nil or self.roomPanel.modalInProgress ~= nil
    if self.javaEditor:isValid() then
        self.buttonApply:setEnable(not modalVisible and self.currentTool == nil)
        self.buttonApply:setTooltip(nil)
    else
        self.buttonApply:setEnable(false)
        self.buttonApply:setTooltip(self.javaEditor:getInvalidString())
    end
end

local function isMouseOverUI()
	local uis = UIManager.getUI()
	for i=1,uis:size() do
		local ui = uis:get(i-1)
		if ui:isMouseOver() then
			return true
		end
	end
	return false
end

function ISBuildingRoomsEditor:setCurrentTool(tool)
    if self.currentTool == tool then return end
    if self.currentTool then
--        self.currentTool:deactivate()
        getCell():setDrag(nil, self.playerNum) -- calls tool:deactivate()
    end
    self.currentTool = tool
    if self.currentTool then
        self.currentTool:activate()
        getCell():setDrag(self.currentTool, self.playerNum)
        setJoypadFocus(self.playerNum, nil) -- focus on ISBuildingObject
    end
end

function ISBuildingRoomsEditor:getSelectedBuilding()
    return self.buildingPanel:getSelectedBuilding()
end

function ISBuildingRoomsEditor:getSelectedRoom()
    return self.roomPanel:getSelectedRoom()
end

function ISBuildingRoomsEditor:OnEvent(event, arg1, arg2, arg3, arg4)
    self.buildingPanel:OnEvent(event, arg1, arg2, arg3, arg4)
    self.roomPanel:OnEvent(event, arg1, arg2, arg3, arg4)
end

function ISBuildingRoomsEditor:display()
    self:setInfo(getText("IGUI_BuildingRoomsEditor_Info"))
    local playerObj = getSpecificPlayer(self.playerNum)
    self.currentLevel = math.floor(playerObj:getZ())
    self.javaEditor:setCurrentLevel(self.currentLevel)
    self.javaEditor:init(playerObj:getX(), playerObj:getY())
    self.buildingPanel:fillList()
    self.buildingPanel:selectPlayerBuilding()
    self.roomPanel.playerRoomIndex = -1
    self.roomPanel:fillList()
    self:setVisible(true)
    self:addToUIManager()
    if getJoypadData(self.playerNum) then
        setJoypadFocus(self.playerNum, self)
    end
end

function ISBuildingRoomsEditor:askApplyChanges(closeAfterApply)
    local modal = ISModalDialog:new(0, 0, 350, 150, getText("IGUI_BuildingRoomsEditor_AskApplyChanges"), true, self, self.confirmApplyChanges)
    modal:initialise()
    modal:addToUIManager()
    modal.moveWithMouse = true
    modal:centerOnScreen(self.playerNum)
    modal.closeAfterApply = closeAfterApply
    if getJoypadData(self.playerNum) then
        modal.prevFocus = self
        setJoypadFocus(self.playerNum, modal)
    end
    self:setVisible(false)
end

function ISBuildingRoomsEditor:confirmApplyChanges(button)
    self:setVisible(true)
    if button.internal == "YES" then
        self:applyChanges()
        self.hasChanges = false
    end
    if button.parent.closeAfterApply then
        self:close()
    end
end

function ISBuildingRoomsEditor:applyChanges()
    self:setCurrentTool(nil)
    self.javaEditor:applyChanges(false)
    local playerObj = getSpecificPlayer(self.playerNum)
    self.currentLevel = math.floor(playerObj:getZ())
    self.javaEditor:setCurrentLevel(self.currentLevel)
    self.javaEditor:init(playerObj:getX(), playerObj:getY())
    self.buildingPanel:fillList()
    self.buildingPanel:selectPlayerBuilding()
    self.roomPanel.playerRoomIndex = -1
    self.roomPanel:fillList()
end

function ISBuildingRoomsEditor:close()
    self.hasChanges = false
    if self.buildingPanel.modalInProgress then
        self.buildingPanel.modalInProgress:destroy()
        self.buildingPanel.modalInProgress = nil
    end
    if self.roomPanel.modalInProgress then
        self.roomPanel.modalInProgress:destroy()
        self.roomPanel.modalInProgress = nil
    end
    self:setVisible(false)
    self:removeFromUIManager()
    self:setCurrentTool(nil)
    self.javaEditor:setCurrentBuilding(nil)
    self.javaEditor:setCurrentRoom(nil)
    self.javaEditor:setCurrentLevel(0)
    if getJoypadData(self.playerNum) then
        setJoypadFocus(self.playerNum, nil)
    end
end

function ISBuildingRoomsEditor:onGainJoypadFocus(joypadData)
    if self:isDescendant(joypadData.switchingFocusFrom) then
        ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
        self:setISButtonForA(self.buttonApply);
        self:setISButtonForB(self.buttonClose);
        self.drawJoypadFocus = true
    else
        joypadData.focus = self.tabPanel:getActiveView()
        updateJoypadFocus(joypadData)
	end
    self.previousFocusTool = nil
end

function ISBuildingRoomsEditor:onLoseJoypadFocus(joypadData)
    ISCollapsableWindowJoypad.onLoseJoypadFocus(self, joypadData)
    self.drawJoypadFocus = false
    self:clearISButtons()
end

function ISBuildingRoomsEditor:onJoypadDown(button, joypadData)
    if button == Joypad.BButton then
        self:close()
        return
    end
    ISCollapsableWindowJoypad.onJoypadDown(self, button, joypadData)
end

function ISBuildingRoomsEditor:onJoypadButtonReleased(button, joypadData)
    if button == Joypad.LBumper or button == Joypad.RBumper then
        self:handleBumpers(button, joypadData)
        return
    end
    ISCollapsableWindowJoypad.onJoypadButtonReleased(self, button, joypadData)
end

function ISBuildingRoomsEditor:onJoypadDown_Descendant(descendant, button, joypadData)
    if button == Joypad.LBumper or button == Joypad.RBumper then
        self:handleBumpers(button, joypadData)
        return
    end
    if button == Joypad.BButton then
        joypadData.focus = self
        updateJoypadFocus(joypadData)
        return
    end
--    ISCollapsableWindowJoypad.onJoypadDown_Descendant(self, descendant, button, joypadData)
end

function ISBuildingRoomsEditor:onJoypadButtonReleased_Descendant(descendant, button, joypadData)
    if button == Joypad.LBumper or button == Joypad.RBumper then
        return
    end
--    ISCollapsableWindowJoypad.onJoypadDown_Descendant(self, descendant, button, joypadData)
end

function ISBuildingRoomsEditor:onJoypadDirUp(joypadData)
    joypadData.focus = self.tabPanel:getActiveView()
    updateJoypadFocus(joypadData)
end

function ISBuildingRoomsEditor:hasConflictWithJoypadNavigateStart()
	return true -- RBumper activates tabs
end

function ISBuildingRoomsEditor:onJoypadNavigateStart(joypadData)
	self.joypadNavigate = { up = self.tabPanel:getActiveView() }
end

function ISBuildingRoomsEditor:handleBumpers(button, joypadData)
    local viewIndex = self.tabPanel:getActiveViewIndex()
    if button == Joypad.LBumper then
        if viewIndex == 1 then
            viewIndex = #self.tabPanel.viewList
        else
            viewIndex = viewIndex - 1
        end
    elseif button == Joypad.RBumper then
        if viewIndex == #self.tabPanel.viewList then
            viewIndex = 1
        else
            viewIndex = viewIndex + 1
        end
    end
    getSoundManager():playUISound("UIActivateTab")
    self.tabPanel:activateView(self.tabPanel.viewList[viewIndex].name)
    joypadData.focus = self.tabPanel:getActiveView()
    updateJoypadFocus(joypadData)
end

function ISBuildingRoomsEditor:new(x, y, w, h)
    local o = ISCollapsableWindowJoypad.new(self, x, y, w, h)
    o:setResizable(false)
    o.title = getText("IGUI_BuildingRoomsEditor_Title")
    o.playerNum = 0
    o.javaEditor = BuildingRoomsEditor.getInstance()
    o.javaEditor:setLuaEditor(o)
    o.currentLevel = 0
    o.toolAddBuilding = ISBuildingRoomsEditor_ToolAddBuilding:new(o)
    o.toolAddRect = ISBuildingRoomsEditor_ToolAddRect:new(o)
    o.toolAddRoom = ISBuildingRoomsEditor_ToolAddRoom:new(o)
    o.toolRemoveRect = ISBuildingRoomsEditor_ToolRemoveRect:new(o)
    o.currentTool = nil
    return o
end

function ISBuildingRoomsEditor.Show()
    if ISBuildingRoomsEditor.instance == nil then
        ISBuildingRoomsEditor.instance = ISBuildingRoomsEditor:new(100, 100, 500, 500)
        ISBuildingRoomsEditor.instance:initialise()
        ISBuildingRoomsEditor.instance:instantiate()
    end
    ISBuildingRoomsEditor.instance:display()
end