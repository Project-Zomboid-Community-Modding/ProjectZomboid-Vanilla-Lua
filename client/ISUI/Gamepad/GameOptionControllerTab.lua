require "ISBaseObject"
require "ISUI/ISPanel"
require "ISUI/ISPanelJoypad"
require "ISUI/ISButton"
require "ISUI/ISUISprite"
require "ISUI/Gamepad/ISControllerTestPanel"
require "ISUI/Gamepad/CharacterJoypadBindingUI"
require "OptionScreens/GameOption"
require "gamepadBinding"

require "defines"

GameOptionControllerTab = {}
GameOptionControllerTab = ISBaseObject:derive("GameOptionControllerTab")

function GameOptionControllerTab:new(mainOptions, contentTab)
    local newInstance = ISBaseObject:new()
    setmetatable(newInstance, self)
    self.__index = self

    newInstance.contentTab = contentTab
    newInstance.contentPanel = contentTab
    newInstance.mainOptions = mainOptions

    newInstance:addContent()
end

function GameOptionControllerTab:getStyle()
    return self.mainOptions:getStyle()
end

function GameOptionControllerTab:addContent()
    self.mainOptions.gameOptions:removeAllFromUIElement(self.contentPanel)
    self.contentPanel:clearChildren()
    self.contentPanel.midPanel = self.contentPanel:addChild(ISPanel:new(0, 0, 100, 100):noBackground())
    self.contentPanel.rightPanel = self.contentPanel:addChild(ISPanel:new(0, 0, 100, 100):noBackground())
    self.contentPanel.onDoLayout = function(self)
        local width = self:getWidth()
        local height = self:getHeight()

        self.midPanel:setX(0)
        self.midPanel:setWidth(width * 3 / 4)
        self.midPanel:setY(0)
        self.midPanel:setHeight(height)

        self.rightPanel:setX(self.midPanel:getRight())
        self.rightPanel:setWidth(width - self.rightPanel:getX())
        self.rightPanel:setY(0)
        self.rightPanel:setHeight(height)
    end
    self.contentPanel:doLayout()

    self:addControllerPanelMidPanel(self.contentPanel.midPanel)
    self:addControllerPanelRightPanel(self.contentPanel.rightPanel)

    self.contentPanel:autoGenerateJoypadButtonsLists()
    self.mainOptions.gameOptions:addAllFromUIElement(self.contentPanel)
end

function GameOptionControllerTab:onContentChanged()
    self.contentPanel:autoGenerateJoypadButtonsLists()
end

function GameOptionControllerTab:addControllerPanelMidPanel(contentPanel)
    contentPanel:clearChildren()
    contentPanel.onDoLayout = function(self)
        self.midPanel:setX(0)
        self.midPanel:setWidth(self:getWidth())
        self.midPanel:setY(0)
        self.midPanel:setHeight(self:getHeight() - self.midPanel:getY())
    end

    local controllerCustomizationContainerPanel = self:initControllerCustomizationPanel(0, 0, contentPanel:getWidth(), contentPanel:getHeight())
    contentPanel:addChild(controllerCustomizationContainerPanel)
    contentPanel.midPanel = controllerCustomizationContainerPanel

    contentPanel:doLayout()
end

function GameOptionControllerTab:addControllerPanelRightPanel(contentPanel)
    local style = self:getStyle()
    local FONT_SMALL = style:getFont("Small")
    local FONT_HGT_SMALL = style:getFontHeight("Small")
    local UI_BORDER_SPACING = style.borderSpacing
    local BUTTON_HGT = style.buttonHeight
    local INITIAL_Y = style.initialY

    local x = UI_BORDER_SPACING+1
    local y = INITIAL_Y;

    contentPanel:clearChildren()
    contentPanel.topPanel = contentPanel:addChild(ISPanel:new(0, 0, 100, 100):noBackground())
    contentPanel.midPanel = contentPanel:addChild(ISPanel:new(0, 0, 100, 100):noBackground())
    contentPanel.onDoLayout = function(self)
        self.topPanel:setX(0)
        self.topPanel:setWidth(self:getWidth())

        self.midPanel:setX(0)
        self.midPanel:setWidth(self:getWidth())
        self.midPanel:setY(self.topPanel:getBottom())
        self.midPanel:setHeight(self:getHeight() - self.midPanel:getY())
    end

    -- CONTROLLER BUTTON STYLE
    local label = ISLabel:new(x, y, BUTTON_HGT, getText("UI_optionscreen_ControllerButtonStyle"), 1, 1, 1, 1, FONT_SMALL, true);
    label:initialise();
    contentPanel:addChild(label);
    local controllerButtonStyle = ISComboBox:new(label:getRight()+UI_BORDER_SPACING, y, 200, BUTTON_HGT);
    controllerButtonStyle:initialise();
    controllerButtonStyle:addOption(getText("UI_optionscreen_ControllerButtonStyle1"));
    controllerButtonStyle:addOption(getText("UI_optionscreen_ControllerButtonStyle2"));
    controllerButtonStyle:addOption(getText("UI_optionscreen_ControllerButtonStyle3"));
    contentPanel.topPanel:addChild(controllerButtonStyle);

    controllerButtonStyle.gameOption = GameOption:new('UI_optionscreen_ControllerButtonStyle', controllerButtonStyle)
    function controllerButtonStyle.gameOption.toUI(self)
        local box = self.control
        box.selected = getCore():getOptionControllerButtonStyle()
    end
    function controllerButtonStyle.gameOption.apply(self)
        local box = self.control
        if box.options[box.selected] and (getCore():getOptionControllerButtonStyle() ~= box.selected) then
            getCore():setOptionControllerButtonStyle(box.selected)
        end
    end
    function controllerButtonStyle.gameOption.onChange(self)
        getCore():setOptionControllerButtonStyle(self.control.selected)
        DebugType.ISUI:debugln("onControllerButtonStyleChanged to: '" .. getCore():getOptionControllerButtonStyleString() .. "'")
    end
    y = y + BUTTON_HGT + UI_BORDER_SPACING

    label = ISLabel:new(x, y, FONT_HGT_SMALL, getText("UI_optionscreen_controller_tip"), 1, 1, 1, 1, FONT_SMALL, true)
    label:initialise()
    contentPanel.topPanel:addChild(label)

    local controllerTickBox = ISTickBox:new(x + UI_BORDER_SPACING, label:getY() + label:getHeight() + UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "HELLO?")
    controllerTickBox.choicesColor = {r=1, g=1, b=1, a=1}
    controllerTickBox:initialise();
    contentPanel.topPanel:addChild(controllerTickBox)

    for i = 0, getControllerCount()-1 do
        if isControllerConnected(i) then
            local name = getControllerName(i)
            controllerTickBox:addOption(name, nil)
        end
    end

    controllerTickBox.gameOption = GameOption:new('controllers', controllerTickBox)
    function controllerTickBox.gameOption.toUI(self)
        local box = self.control
        box:clearOptions()
        for i = 1,getControllerCount() do
            if isControllerConnected(i-1) then
                local name = getControllerName(i-1)
                local guid = getControllerGUID(i-1)
                local index = box:addOption(name, i-1)
                local active = getCore():getOptionActiveController(guid)
                box:setSelected(index, active)
            end
        end
    end
    function controllerTickBox.gameOption.apply(self)
        local box = self.control
        for i = 1,box:getOptionCount() do
            local controllerIndex = box:getOptionData(i)
            getCore():setOptionActiveController(controllerIndex, box:isSelected(i))
        end
    end

    -- If any controller connected, must work at least one
    local haveActiveController = false
    for i = 1,getControllerCount() do
        if isControllerConnected(i-1) then
            local guid = getControllerGUID(i-1)
            local active = getCore():getOptionActiveController(guid)
            if active then
                haveActiveController = true
            end
        end
    end
    if not haveActiveController and getControllerCount() > 0 then
        getCore():setOptionActiveController(0, true)
    end

    y = controllerTickBox:getBottom() + UI_BORDER_SPACING

    -- Reload Controller
    local reloadControllerButton = ISButton:new(0, y, 120, BUTTON_HGT, getText("UI_optionscreen_controller_reload"), self, GameOptionControllerTab.ControllerReload)
    reloadControllerButton:initialise()
    reloadControllerButton:instantiate()
    contentPanel.topPanel:addChild(reloadControllerButton)
    y = reloadControllerButton:getBottom() + UI_BORDER_SPACING

    -- Sensitivity Settings
    local gamepadSensitivityLabel = ISLabel:new(0, y, FONT_HGT_SMALL, getText("UI_optionscreen_gamepad_deadzone"), 1, 1, 1, 1, FONT_SMALL, true)
    gamepadSensitivityLabel:initialise()
    contentPanel.topPanel:addChild(gamepadSensitivityLabel)
    y = gamepadSensitivityLabel:getBottom() + UI_BORDER_SPACING

    local btnJoypadSensitivityM = ISButton:new(0, y, BUTTON_HGT, BUTTON_HGT, "-", self, GameOptionControllerTab.joypadSensitivityM)
    btnJoypadSensitivityM:initialise()
    btnJoypadSensitivityM:instantiate()
    btnJoypadSensitivityM:setEnable(false)
    self.btnJoypadSensitivityM = btnJoypadSensitivityM
    contentPanel.topPanel:addChild(btnJoypadSensitivityM)

    local sensitivityText = getText("UI_optionscreen_select_gamepad")
    local labelJoypadSensitivity = ISLabel:new(btnJoypadSensitivityM:getX() + btnJoypadSensitivityM:getWidth() + UI_BORDER_SPACING + getTextManager():MeasureStringX(FONT_SMALL, sensitivityText) / 2, y, BUTTON_HGT, sensitivityText, 1, 1, 1, 1, FONT_SMALL, true)
    labelJoypadSensitivity.center = true
    labelJoypadSensitivity:initialise()
    self.labelJoypadSensitivity = labelJoypadSensitivity
    contentPanel.topPanel:addChild(labelJoypadSensitivity)

    local btnJoypadSensitivityP = ISButton:new(labelJoypadSensitivity:getX() + labelJoypadSensitivity:getWidth() / 2 + UI_BORDER_SPACING, y, BUTTON_HGT, BUTTON_HGT, "+", self, GameOptionControllerTab.joypadSensitivityP)
    btnJoypadSensitivityP:initialise()
    btnJoypadSensitivityP:instantiate()
    btnJoypadSensitivityP:setEnable(false)
    self.btnJoypadSensitivityP = btnJoypadSensitivityP
    contentPanel.topPanel:addChild(btnJoypadSensitivityP)

    y = btnJoypadSensitivityP:getBottom() + UI_BORDER_SPACING
    contentPanel.topPanel:setHeight(y)

    -- Controller Test Panel, showing Raw Values
    self.controllerTestPanel = ISControllerTestPanel:new(self, 0, 0, contentPanel:getWidth(), 100)
    self.controllerTestPanel:setAnchorRight(true)
    self.controllerTestPanel:setAnchorBottom(true)
    self.controllerTestPanel.drawBorder = true
    self.controllerTestPanel.mainOptions = self
    self.controllerTestPanel:initialise()
    contentPanel.midPanel:addChild(self.controllerTestPanel)

    contentPanel:doLayout()
end

function GameOptionControllerTab:setJoypadSelected(isSelected)
    self.btnJoypadSensitivityP:setEnable(isSelected)
    self.btnJoypadSensitivityM:setEnable(isSelected)
end

function GameOptionControllerTab:setJoypadSensitivityName(joypadSensitivityName)
    self.labelJoypadSensitivity.name=joypadSensitivityName
end

function GameOptionControllerTab:initControllerCustomizationPanel(x, y, width, height)
    local FONT_MEDIUM = self:getStyle():getFont("Medium")
    local FONT_HGT_MEDIUM = self:getStyle():getFontHeight("Medium")
    local UI_BORDER_SPACING = self:getStyle().borderSpacing

    local containerPanel = ISPanel:new(x, y, width, height):noBackground()
    containerPanel.onDoLayout = function(self)
        DebugType.ISUI:trace("controllerCustomizationPanel.onDoLayout. Width: " .. self:getWidth())
        self.controllerBindingsEditorPanel:setWidth(self:getWidth())
        self.controllerBindingsEditorPanel:setY(self.topPanel:getBottom())
        self.controllerBindingsEditorPanel:setHeight(self:getHeight() - self.controllerBindingsEditorPanel:getY())
    end

    local topPanel = containerPanel:addChild(ISPanel:new(0, 0, containerPanel:getWidth(), 100))
    topPanel.backgroundColor.a = 1.0
    containerPanel.topPanel = topPanel
    local topPanelHeight = UI_BORDER_SPACING

    -- Select Presets
    local selectPresetsLabel = ISLabel:new(UI_BORDER_SPACING * 2, topPanelHeight, FONT_HGT_MEDIUM, getText("UI_optionscreen_gamepad_selectPreset"), 1, 1, 1, 1, FONT_MEDIUM, true)
    selectPresetsLabel:initialise()
    topPanel:addChild(selectPresetsLabel)

    local gamepadPresetsCBox = self:createGamepadBindingPresetsCBox(selectPresetsLabel:getRight() + UI_BORDER_SPACING, selectPresetsLabel:getY())
    topPanel:addChild(gamepadPresetsCBox)
    topPanelHeight = topPanelHeight + gamepadPresetsCBox:getHeight() + UI_BORDER_SPACING
    topPanel:setHeight(topPanelHeight)

    -- Controller bindings Editor Panel
    local controllerBindingsEditorPanel = ISControllerBindingsEditorPanel:new(self, containerPanel, 0, topPanel:getHeight(), containerPanel:getWidth(), 100)
    containerPanel.controllerBindingsEditorPanel = controllerBindingsEditorPanel
    containerPanel:addChild(controllerBindingsEditorPanel)

    topPanel:bringToTop()

    return containerPanel
end

function GameOptionControllerTab:createGamepadBindingPresetsCBox(x, y)
    local style = self:getStyle()
    local BUTTON_HGT = style.buttonHeight

    local gamepadPresetsCBox = ISComboBox:new(x, y, BUTTON_HGT, BUTTON_HGT)
    gamepadPresetsCBox.choicesColor = {r=1, g=1, b=1, a=1}
    gamepadPresetsCBox.autoWidth = true
    gamepadPresetsCBox:initialise();

    function gamepadPresetsCBox:populate()
        local style = self:getStyle()
        local FONT_MEDIUM = style:getFont("Medium")
        local UI_BORDER_SPACING = style.borderSpacing
        local BUTTON_HGT = style.buttonHeight

        self:clear()

        DebugType.ISUI:trace("Populating gamepadBinding presets...")
        local selectedPresetsTickBoxWidth = BUTTON_HGT
        for presetKey, preset in pairs(gamepadBinding.presets) do
            DebugType.ISUI:trace("  Adding Gamepad preset to UI: " .. presetKey)

            local labelText = getText(preset.labelText)
            local descriptionText = getText(preset.descriptionText or "")
            self:addOptionWithData(labelText, presetKey, descriptionText)

            local labelTextWidth = getTextManager():MeasureStringX(FONT_MEDIUM, labelText)
            selectedPresetsTickBoxWidth = math.max(labelTextWidth, selectedPresetsTickBoxWidth)
        end

        local createNewLabelText = "< Create New >"
        local createNewDescriptionText = "Create a new preset."
        self:addOptionWithData(createNewLabelText, "CreateNew", createNewDescriptionText)
        selectedPresetsTickBoxWidth = math.max(getTextManager():MeasureStringX(FONT_MEDIUM, createNewLabelText), selectedPresetsTickBoxWidth)

        self:setWidth(selectedPresetsTickBoxWidth + UI_BORDER_SPACING * 2 + BUTTON_HGT)
        self:setSelectedData(gamepadBinding:getCurrentActivePresetName())
    end

    gamepadPresetsCBox.gameOption = GameOption:new('gamepadBindingPresets', gamepadPresetsCBox)
    function gamepadPresetsCBox.gameOption.toUI(self)
        self.control:populate()
    end
    function gamepadPresetsCBox.gameOption.apply(self)
        local selectedData = self.control:getSelectedData()
        if (selectedData ~= "CreateNew") then
            gamepadBinding:set(selectedData)
            gamepadBinding:saveAll()
        end
    end
	function gamepadPresetsCBox.gameOption.onChange(self)
        local selectedData = self.control:getSelectedData()
        if (selectedData ~= "CreateNew") then
            gamepadBinding:set(selectedData)
        else
            local newEntry = gamepadBinding:createNewFromCurrent()
            gamepadBinding:set(newEntry.key)
            self.control:populate()
        end
	end

    self.gamepadPresetsCBox = gamepadPresetsCBox
    return gamepadPresetsCBox
end

function GameOptionControllerTab:onJoypadButtonBindingEdited()
    if (gamepadBinding:isCurrentPresetEditable() == false) then
        DebugType.ISUI:debugln("Current preset '" .. gamepadBinding:getCurrentActivePresetName() .. "' is not editable. Spawning new...")
        local newEntry = gamepadBinding:createNewFromCurrent()
        gamepadBinding:set(newEntry.key)
        self.gamepadPresetsCBox:populate()
        return
    end

    gamepadBinding:onCurrentSetEdited()
    self.gamepadPresetsCBox.gameOption:invokeOnChangeEvent()
end

function GameOptionControllerTab:joypadSensitivityM()
	self.controllerTestPanel:joypadSensitivityM()
end

function GameOptionControllerTab:joypadSensitivityP()
	self.controllerTestPanel:joypadSensitivityP()
end

function GameOptionControllerTab:ControllerReload()
	reloadControllerConfigFiles()
end
