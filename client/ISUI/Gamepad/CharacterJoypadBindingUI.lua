require "ISBaseObject"
require "ISUI/ISLine"
require "ISUI/Gamepad/CharacterJoypadBindingUIEntry"

CharacterJoypadBindingUI = ISBaseObject:derive("CharacterJoypadBindingUI")
CharacterJoypadBindingUI.BevelDirection = {
        Auto = "Auto",
        Left = "Left",
        Right = "Right",
    }
CharacterJoypadBindingUI.BindingPanel = {
    TopLeft = "TopLeft",
    TopRight = "TopRight",
    BottomLeft = "BottomLeft",
    BottomRight = "BottomRight",
}

function CharacterJoypadBindingUI:new(controllerBindingsEditorPanel)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.bindingKeys = {}
    o.controllerBindingsEditorPanel = controllerBindingsEditorPanel
    return o
end

function CharacterJoypadBindingUI:getStyle()
    return self.controllerBindingsEditorPanel:getStyle()
end

function CharacterJoypadBindingUI:createGamepadUIBinding(containerPanel, bindingKey)
    self[bindingKey] = CharacterJoypadBindingUIEntry:new(self, containerPanel, bindingKey)
    table.insert(self.bindingKeys, bindingKey)
end

function CharacterJoypadBindingUI:onBindingEntryLayoutChanged()
    self.controllerBindingsEditorPanel:onBindingUILayoutChanged()
end

function CharacterJoypadBindingUI:onJoypadButtonBindingEdited()
    self.controllerBindingsEditorPanel:onJoypadButtonBindingEdited()
end

function CharacterJoypadBindingUI:onJoypadAxisBindingValueEdited(uiBinding, uiRow, charBinding)
    self.controllerBindingsEditorPanel:onJoypadAxisBindingValueEdited(uiBinding, uiRow, charBinding)
end

function CharacterJoypadBindingUI:onBindingUIPanelEditingActivated(uiBinding)
    self.controllerBindingsEditorPanel:onBindingUIPanelEditingActivated(uiBinding)
end

function CharacterJoypadBindingUI:getAllEntries()
    local allEntries = {}
    for _,entry in pairs(self) do
        if (CharacterJoypadBindingUIEntry:instanceof(entry)) then
            table.insert(allEntries, entry)
        end
    end
    return allEntries
end

function CharacterJoypadBindingUI.getAllPhysicalJoypadElements()
    local allElements = {}
    for _, button in ipairs(JoypadButton.getButtons()) do
        table.insert(allElements, button)
    end
    for _, axis1d in ipairs(JoypadAxis1d.getAxes()) do
        table.insert(allElements, axis1d)
    end
    for _, axis2d in ipairs(JoypadAxis2d.getAxes()) do
        table.insert(allElements, axis2d)
    end
    return allElements
end

function CharacterJoypadBindingUI:getSprite()
    return self.controllerBindingsEditorPanel.content.controllerBackgroundSprite
end

function CharacterJoypadBindingUI.performLayoutRows(containerPanel)
    local panelWidth = 10
    local panelHeight = 10
    for _,rowPanel in ipairs(containerPanel.bindingRows) do
        rowPanel:setX(0)
        rowPanel:setY(panelHeight)
        panelHeight = rowPanel:getBottom()
        panelWidth = math.max(panelWidth, rowPanel:getWidth())
    end

    for _,rowPanel in ipairs(containerPanel.bindingRows) do
        rowPanel:setWidth(panelWidth)
    end

    containerPanel:setWidth(panelWidth)
    containerPanel:setHeight(panelHeight)
end
