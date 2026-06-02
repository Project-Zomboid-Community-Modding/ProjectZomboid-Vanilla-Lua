
require "ISUI/ISPanel"

CharacterJoypadBindingUIRow = {}
CharacterJoypadBindingUIRow = ISPanel:derive("CharacterJoypadBindingUIRow")

function CharacterJoypadBindingUIRow:new(x, y, width, height, uiBinding, bindingKey)
    local newInstance = ISPanel:new(x, y, width, height)
    setmetatable(newInstance, self)
    self.__index = self
    self.SuperType = ISPanel

    newInstance.uiBinding = uiBinding
    newInstance.bindingKey = bindingKey
    newInstance.name = newInstance.Type .. "_" .. typeof(newInstance.bindingKey) .. "." .. tostring(newInstance.bindingKey)
    newInstance.isEditSelected = false
    newInstance.selectButton = newInstance:addChild(ISButton:new(0, 0, 100, 100, "", newInstance, newInstance.onSelectButtonClicked));
    newInstance.selectButton:noBackground()
    newInstance.selectButton.backgroundColor.a = 0.25
    newInstance.selectButton.backgroundColorMouseOver.a = 0.35
    newInstance.selectButton.dock = ISDock.Fill
    newInstance.spinBoxOptionsZeroToOne = {}
    for i = 1,100 do
        newInstance.spinBoxOptionsZeroToOne[i] = string.format("%.2f", i / 100)
    end
    newInstance:noBackground()
    return newInstance
end

function CharacterJoypadBindingUIRow:populate()
    if (self.isEditSelected) then
        self:populateWithEditableElements()
    else
        self:populateWithReadOnlyLabels()
    end
end

function CharacterJoypadBindingUIRow:rePopulate()
    self:populate()
    self.uiBinding:onBindingRowPanelLayoutChanged()
end

function CharacterJoypadBindingUIRow:populateWithEditableElements()
    self:clearChildren()

    local bindingKey = self.bindingKey
    DebugType.ISUI:trace(self:toTypeNameString() .. "> Populating panel for bindingKey: " .. typeof(bindingKey) .. "." .. tostring(bindingKey))

    local style = self:getStyle()
    local FONT_LABEL = style:getFont("Small")
    local FONT_HGT_LABEL = style:getFontHeight("Small") * 0.8
    local FONT_HGT_ENTRY = style:getFontHeight("Small") * 0.6
    local UI_BORDER_SPACING = style.borderSpacing
    local BUTTON_HGT = FONT_HGT_LABEL * 1.1
    local UI_ENTRY_SPACING = FONT_HGT_ENTRY / 15
    local INDENT_WIDTH = FONT_HGT_LABEL / 2

    local containerWidth = BUTTON_HGT
    local containerHeight = BUTTON_HGT

    local bindingLabel = ISLabel:new(UI_BORDER_SPACING, 0, FONT_HGT_LABEL, getText(bindingKey:getNameTranslationKey()), 1, 1, 1, 1, FONT_LABEL, true)
    bindingLabel:initialise()
    self:addChild(bindingLabel)

    local entriesRight = bindingLabel:getRight()
    local entriesWidth = 0
    containerHeight = bindingLabel:getBottom()

    local bindingCBoxX = bindingLabel:getLeft() + INDENT_WIDTH
    local bindingCBoxY = bindingLabel:getBottom() + UI_ENTRY_SPACING

    local entries = {}
    if (instanceof(bindingKey, "JoypadButton")) then
        local charBindings = CharacterJoypadButtonBinding.findBindings(bindingKey) or {}
        for _,charBinding in ipairs(charBindings) do
            local bindingCBox = self:createJoypadButtonBindingCBox(bindingKey, charBinding, charBindings, bindingCBoxX, bindingCBoxY, BUTTON_HGT, BUTTON_HGT)
            bindingCBox:initialise()
            self:addChild(bindingCBox)
            bindingCBox:populate()
            bindingCBox:setOnChange(self, self.onJoypadButtonBindingChanged, bindingKey, charBinding)
            table.insert(entries, bindingCBox)
            entriesRight = math.max(entriesRight, bindingCBox:getRight())
            entriesWidth = math.max(entriesWidth, bindingCBox:getWidth())
            bindingCBoxY = bindingCBox:getBottom() + UI_ENTRY_SPACING
            containerHeight = bindingCBox:getBottom() + UI_BORDER_SPACING
        end

        local addNewBindingCBox = self:createJoypadButtonBindingCBox(bindingKey, "!AddNewEntry!", charBindings, bindingCBoxX, bindingCBoxY + UI_ENTRY_SPACING * 2, BUTTON_HGT, BUTTON_HGT)
        addNewBindingCBox:initialise()
        self:addChild(addNewBindingCBox)
        addNewBindingCBox:populate()
        addNewBindingCBox:setOnChange(self, self.onAddNewJoypadBindingChanged, bindingKey)
        table.insert(entries, addNewBindingCBox)
        entriesRight = math.max(entriesRight, addNewBindingCBox:getRight())
        entriesWidth = math.max(entriesWidth, addNewBindingCBox:getWidth())
        bindingCBoxY = addNewBindingCBox:getBottom() + UI_BORDER_SPACING
        containerHeight = addNewBindingCBox:getBottom() + UI_BORDER_SPACING
    elseif (instanceof(bindingKey, "JoypadAxis1d")) then
        local axisBindings = CharacterJoypadButtonBinding.findBindings(bindingKey) or {}
        for _,charBinding in ipairs(axisBindings) do
            local bindingCBox = self:createJoypadButtonBindingCBox(bindingKey, charBinding, axisBindings, bindingCBoxX, bindingCBoxY, BUTTON_HGT, BUTTON_HGT)
            bindingCBox:initialise()
            self:addChild(bindingCBox)
            bindingCBox:populate()
            bindingCBox:setOnChange(self, self.onJoypadButtonAxis1dBindingChanged, bindingKey, charBinding)

            local bindingMinValueBox = ISSpinBox:new(bindingCBox:getRight() + UI_BORDER_SPACING, bindingCBoxY, BUTTON_HGT * 4, BUTTON_HGT
                , self, self.onJoypadAxisMinThresholdEdited)
            bindingMinValueBox:addOptions(self.spinBoxOptionsZeroToOne)
            bindingMinValueBox:setSelectedOption(string.format("%.2f", charBinding:getAxisMinThreshold()))
            bindingMinValueBox.charBinding = charBinding
            bindingMinValueBox.bindingKey = bindingKey
            bindingMinValueBox:initialise()
            self:addChild(bindingMinValueBox)
            entriesRight = math.max(entriesRight, bindingMinValueBox:getRight())
            entriesWidth = math.max(entriesWidth, bindingMinValueBox:getRight() - bindingCBox:getX())
            bindingCBoxY = bindingMinValueBox:getBottom() + UI_ENTRY_SPACING
            containerHeight = bindingMinValueBox:getBottom() + UI_BORDER_SPACING

            local entryHandler = {}
            entryHandler.bindingXBox = bindingCBox
            entryHandler.bindingMinValueBox = bindingMinValueBox
            function entryHandler:setWidth(width)
                entryHandler.bindingXBox:setWidth(width - entryHandler.bindingMinValueBox:getWidth())
                entryHandler.bindingMinValueBox:setX(entryHandler.bindingXBox:getRight() + UI_BORDER_SPACING)
            end

            table.insert(entries, entryHandler)
        end

        local addNewBindingCBox = self:createJoypadButtonBindingCBox(bindingKey, "!AddNewEntry!", axisBindings, bindingCBoxX, bindingCBoxY + UI_ENTRY_SPACING * 2, BUTTON_HGT, BUTTON_HGT)
        addNewBindingCBox:initialise()
        self:addChild(addNewBindingCBox)
        addNewBindingCBox:populate()
        addNewBindingCBox:setOnChange(self, self.onAddNewJoypadBindingChanged, bindingKey)
        table.insert(entries, addNewBindingCBox)
        entriesRight = math.max(entriesRight, addNewBindingCBox:getRight())
        entriesWidth = math.max(entriesWidth, addNewBindingCBox:getWidth())
        bindingCBoxY = addNewBindingCBox:getBottom() + UI_BORDER_SPACING
        containerHeight = addNewBindingCBox:getBottom() + UI_BORDER_SPACING
    elseif (instanceof(bindingKey, "JoypadAxis2d")) then
        local axisBindings = CharacterJoypadAxis2dBinding.findBindings(bindingKey) or {}
        for _,charBinding in ipairs(axisBindings) do
            local bindingCBox = self:createJoypadButtonBindingCBox(bindingKey, charBinding, axisBindings, bindingCBoxX, bindingCBoxY, BUTTON_HGT, BUTTON_HGT)
            bindingCBox:initialise()
            self:addChild(bindingCBox)
            bindingCBox:populate()
            bindingCBox:setOnChange(self, self.onJoypadButtonAxis2dBindingChanged, bindingKey, charBinding)
            table.insert(entries, bindingCBox)
            entriesRight = math.max(entriesRight, bindingCBox:getRight())
            entriesWidth = math.max(entriesWidth, bindingCBox:getWidth())
            bindingCBoxY = bindingCBox:getBottom() + UI_ENTRY_SPACING
            containerHeight = bindingCBox:getBottom() + UI_BORDER_SPACING
        end

        local charBindings = CharacterJoypadButtonBinding.findBindings(bindingKey) or {}
        for _,charBinding in ipairs(charBindings) do
            local bindingCBox = self:createJoypadButtonBindingCBox(bindingKey, charBinding, charBindings, bindingCBoxX, bindingCBoxY, BUTTON_HGT, BUTTON_HGT)
            bindingCBox:initialise()
            self:addChild(bindingCBox)
            bindingCBox:populate()
            bindingCBox:setOnChange(self, self.onJoypadButtonAxis2dBindingChanged, bindingKey, charBinding)
            table.insert(entries, bindingCBox)

            local bindingMinValueBox = ISSpinBox:new(bindingCBox:getRight() + UI_BORDER_SPACING, bindingCBoxY, BUTTON_HGT * 4, BUTTON_HGT
                , self, self.onJoypadAxisMinThresholdEdited)
            bindingMinValueBox:addOptions(self.spinBoxOptionsZeroToOne)
            bindingMinValueBox:setSelectedOption(string.format("%.2f", charBinding:getAxisMinThreshold()))
            bindingMinValueBox.charBinding = charBinding
            bindingMinValueBox.bindingKey = bindingKey
            bindingMinValueBox:initialise()
            self:addChild(bindingMinValueBox)
            entriesRight = math.max(entriesRight, bindingMinValueBox:getRight())
            entriesWidth = math.max(entriesWidth, bindingMinValueBox:getRight() - bindingCBox:getX())
            bindingCBoxY = bindingMinValueBox:getBottom() + UI_ENTRY_SPACING
            containerHeight = bindingMinValueBox:getBottom() + UI_BORDER_SPACING

            local entryHandler = {}
            entryHandler.bindingXBox = bindingCBox
            entryHandler.bindingMinValueBox = bindingMinValueBox
            function entryHandler:setWidth(width)
                entryHandler.bindingXBox:setWidth(width - entryHandler.bindingMinValueBox:getWidth())
                entryHandler.bindingMinValueBox:setX(entryHandler.bindingXBox:getRight() + UI_BORDER_SPACING)
            end

            table.insert(entries, entryHandler)
        end

        local addNewBindingCBox = self:createJoypadButtonBindingCBox(bindingKey, "!AddNewEntry!", luautils.concatenateArrays(axisBindings, charBindings), bindingCBoxX, bindingCBoxY + UI_ENTRY_SPACING * 2, BUTTON_HGT, BUTTON_HGT)
        addNewBindingCBox:initialise()
        self:addChild(addNewBindingCBox)
        addNewBindingCBox:populate()
        addNewBindingCBox:setOnChange(self, self.onAddNewJoypadBindingChanged, bindingKey)
        table.insert(entries, addNewBindingCBox)
        entriesRight = math.max(entriesRight, addNewBindingCBox:getRight())
        entriesWidth = math.max(entriesWidth, addNewBindingCBox:getWidth())
        bindingCBoxY = addNewBindingCBox:getBottom() + UI_BORDER_SPACING
        containerHeight = addNewBindingCBox:getBottom() + UI_BORDER_SPACING
    end

    for _,entry in ipairs(entries) do
        entry:setWidth(entriesWidth)
    end

    containerWidth = entriesRight + UI_BORDER_SPACING

    self.bindingLabel = bindingLabel

    self:setWidth(containerWidth)
    self:setHeight(containerHeight + UI_BORDER_SPACING)
end

function CharacterJoypadBindingUIRow:onJoypadButtonBindingChanged(senderBox, bindingKey, charBinding)
    local newCharBinding = senderBox:getSelectedData()
    if (newCharBinding == "!RemoveEntry!") then
        charBinding:removeBinding(bindingKey)
        self.uiBinding:onJoypadButtonBindingEdited()
        return
    end

    DebugType.ISUI:debugln("Changing " .. typeof(bindingKey) .. "." .. tostring(bindingKey) .. " " .. tostring(charBinding) .. " to " .. tostring(newCharBinding))
    newCharBinding:moveBindingFrom(charBinding)
    self.uiBinding:onJoypadButtonBindingEdited(self)
end

function CharacterJoypadBindingUIRow:onAddNewJoypadBindingChanged(senderBox, bindingKey)
    local newCharBinding = senderBox:getSelectedData()
    if (newCharBinding == "!AddNewEntry!") then
        return
    end

    DebugType.ISUI:debugln("Adding new binding entry to " .. typeof(bindingKey) .. "." .. tostring(bindingKey) .. " to: " .. tostring(newCharBinding))
    if (instanceof(newCharBinding, "CharacterJoypadButtonBinding")) then
        newCharBinding:addBinding(bindingKey)
    elseif (instanceof(newCharBinding, "CharacterJoypadAxis2dBinding")) then
        newCharBinding:setBinding(bindingKey)
    end
    self.uiBinding:onJoypadButtonBindingEdited(self)
end

function CharacterJoypadBindingUIRow:onJoypadButtonAxis1dBindingChanged(senderBox, bindingKey, charBinding)
    local newCharBinding = senderBox:getSelectedData()
    if (newCharBinding == "!RemoveEntry!") then
        charBinding:removeBinding(bindingKey)
        self.uiBinding:onJoypadButtonBindingEdited()
        return
    end

    DebugType.ISUI:debugln("Changing " .. typeof(bindingKey) .. "." .. tostring(bindingKey) .. " " .. tostring(charBinding) .. " to " .. tostring(newCharBinding))
    newCharBinding:moveBindingFrom(charBinding)
    self.uiBinding:onJoypadButtonBindingEdited(self)
end

function CharacterJoypadBindingUIRow:onJoypadButtonAxis2dBindingChanged(senderBox, bindingKey, charBinding)
    local newCharBinding = senderBox:getSelectedData()
    if (newCharBinding == "!RemoveEntry!") then
        charBinding:removeBinding(bindingKey)
        self.uiBinding:onJoypadButtonBindingEdited()
        return
    end

    DebugType.ISUI:debugln("Changing " .. typeof(bindingKey) .. "." .. tostring(bindingKey) .. " " .. tostring(charBinding) .. " to " .. tostring(newCharBinding))
    newCharBinding:moveBindingFrom(charBinding)
    self.uiBinding:onJoypadButtonBindingEdited(self)
end

function CharacterJoypadBindingUIRow:onJoypadAxisMinThresholdEdited(sender)
    local newValue = sender.options[sender.selected]
    if (newValue == nil) then return end

    local charBinding = sender.charBinding
    charBinding:setBinding(sender.bindingKey, tonumber(newValue))
    self.uiBinding:onJoypadAxisBindingValueEdited(self, charBinding)
end

function CharacterJoypadBindingUIRow:populateWithReadOnlyLabels()
    self:clearChildren()

    local bindingKey = self.bindingKey
    DebugType.ISUI:trace(self:toTypeNameString() .. "> Populating panel for bindingKey: " .. typeof(bindingKey) .. "." .. tostring(bindingKey))

    local style = self:getStyle()
    local FONT_LABEL = style:getFont("Small")
    local FONT_HGT_LABEL = style:getFontHeight("Small") * 0.8
    local FONT_HGT_ENTRY = style:getFontHeight("Small") * 0.6
    local UI_BORDER_SPACING = style.borderSpacing
    local BUTTON_HGT = style.buttonHeight
    local UI_ENTRY_SPACING = FONT_HGT_ENTRY / 20
    local INDENT_WIDTH = FONT_HGT_LABEL / 2

    local containerWidth = BUTTON_HGT
    local containerHeight = BUTTON_HGT

    local bindingLabel = ISLabel:new(UI_BORDER_SPACING, 0, FONT_HGT_LABEL, getText(bindingKey:getNameTranslationKey()), 1, 1, 1, 1, FONT_LABEL, true)
    bindingLabel:initialise()
    self:addChild(bindingLabel)

    local entriesWidth = bindingLabel:getRight()
    local entries = {}
    containerHeight = bindingLabel:getBottom()

    local bindingCBoxX = bindingLabel:getLeft() + INDENT_WIDTH
    local bindingCBoxY = bindingLabel:getBottom() + UI_ENTRY_SPACING

    local charBindings = CharacterJoypadButtonBinding.findBindings(bindingKey)
    for _,charBinding in ipairs(charBindings) do
        local labelText = getText(charBinding:getNameTranslationKey())
        if (instanceof(bindingKey, "JoypadAxis1d") or instanceof(bindingKey, "JoypadAxis2d")) then
            if (charBinding:isAxisMaxThresholdInfinity()) then
                labelText =  labelText .. " > " .. string.format("%.2f", charBinding:getAxisMinThreshold())
            else
                labelText =  string.format("%.2f", charBinding:getAxisMinThreshold()) .. " > " .. labelText .. " < " .. string.format("%.2f", charBinding:getAxisMaxThreshold())
            end
        end

        local bindingLabel = ISLabel:new(bindingCBoxX, bindingCBoxY, FONT_HGT_LABEL, labelText, 0.5, 0.5, 0.5, 1, FONT_LABEL, true)
        bindingLabel:initialise()
        self:addChild(bindingLabel)
        table.insert(entries, bindingLabel)
        entriesWidth = math.max(entriesWidth, bindingLabel:getRight())
        bindingCBoxY = bindingLabel:getBottom() + UI_ENTRY_SPACING
        containerHeight = bindingLabel:getBottom() + UI_BORDER_SPACING
    end

    if (instanceof(bindingKey, "JoypadAxis2d")) then
        local charAxisBindings = CharacterJoypadAxis2dBinding.findBindings(bindingKey)
        for _,charAxisBinding in ipairs(charAxisBindings) do
           local labelText = getText(charAxisBinding:getNameTranslationKey())
           local bindingLabel = ISLabel:new(bindingCBoxX, bindingCBoxY, FONT_HGT_LABEL, labelText, 0.5, 0.5, 0.5, 1, FONT_LABEL, true)
           bindingLabel:initialise()
           self:addChild(bindingLabel)
           table.insert(entries, bindingLabel)
           entriesWidth = math.max(entriesWidth, bindingLabel:getRight())
           bindingCBoxY = bindingLabel:getBottom() + UI_ENTRY_SPACING
           containerHeight = bindingLabel:getBottom() + UI_BORDER_SPACING
        end
    end

    containerWidth = entriesWidth + UI_BORDER_SPACING

    self.bindingLabel = bindingLabel
    self.entries = entries
    self.borderSpacing = UI_BORDER_SPACING
    self.indentWidth = INDENT_WIDTH

    self:addChild(self.selectButton)

    self:setWidth(containerWidth)
    self:setHeight(containerHeight)
end

function CharacterJoypadBindingUIRow:onDoLayout()
    local containerWidth = self:getWidth()
    local bindingLabel = self.bindingLabel
    local labelWidth = bindingLabel:getWidth()
    local entries = self.entries
    if (self.contentHorizontalAlignment == UIHorizontalAlignment.Right) then
        bindingLabel:setX(containerWidth - self.borderSpacing - labelWidth)
        for _,entry in ipairs(entries) do
            entry:setX(bindingLabel:getRight() - self.indentWidth - entry:getWidth())
        end
    elseif (self.contentHorizontalAlignment == UIHorizontalAlignment.Left) then
        bindingLabel:setX(self.borderSpacing)
        for _,entry in ipairs(entries) do
            entry:setX(bindingLabel:getLeft() + self.indentWidth)
        end
    end
end

function CharacterJoypadBindingUIRow:setEditSelected(isSelected)
    if (self.isEditSelected == isSelected) then
        return
    end

    self.isEditSelected = isSelected
    self:rePopulate()
    if (self.isEditSelected) then
        self.uiBinding:onBindingRowPanelEditingActivated(self)
    end
end

function CharacterJoypadBindingUIRow:onSelectButtonClicked()
   self:setEditSelected(true)
end

function CharacterJoypadBindingUIRow:createJoypadButtonBindingCBox(bindingKey, selectedCharBinding, excludingCharBindings, x, y, width, height)
    local buttonBindingCBox = ISComboBox:new(x, y, width, height)
    buttonBindingCBox.choicesColor = {r=1, g=1, b=1, a=1}
    buttonBindingCBox.autoWidth = true
    buttonBindingCBox.bindingKey = bindingKey
    buttonBindingCBox.excludingCharBindings = excludingCharBindings
    buttonBindingCBox.selectedCharBinding = selectedCharBinding
    buttonBindingCBox:initialise();

    function buttonBindingCBox:populate()
        local style = self:getStyle()
        local FONT_MEDIUM = style:getFont("Medium")
        local UI_BORDER_SPACING = style.borderSpacing
        local BUTTON_HGT = style.buttonHeight

        self:clear()

        local cboxWidth = BUTTON_HGT
        if (instanceof(selectedCharBinding, "CharacterJoypadButtonBinding")) then
            for _, charBinding in ipairs(CharacterJoypadButtonBinding:allBindings()) do
                if (self.selectedCharBinding == charBinding or luautils.tableContains(self.excludingCharBindings, charBinding) == false) then
                    local labelText = getText(charBinding:getNameTranslationKey())
                    self:addOptionWithData(labelText, charBinding)
                    cboxWidth = math.max(getTextManager():MeasureStringX(FONT_MEDIUM, labelText), cboxWidth)
                end
            end
        elseif instanceof(selectedCharBinding, "CharacterJoypadAxis2dBinding") then
            for _, charBinding in ipairs(CharacterJoypadAxis2dBinding:allBindings()) do
                if (self.selectedCharBinding == charBinding or luautils.tableContains(self.excludingCharBindings, charBinding) == false) then
                    local labelText = getText(charBinding:getNameTranslationKey())
                    self:addOptionWithData(labelText, charBinding)
                    cboxWidth = math.max(getTextManager():MeasureStringX(FONT_MEDIUM, labelText), cboxWidth)
                end
            end
        elseif (self.selectedCharBinding == "!AddNewEntry!") then
            if (instanceof(self.bindingKey, "JoypadAxis2d")) then
                local combinedAllBindings = luautils.concatenateArrays(CharacterJoypadButtonBinding:allBindings(), CharacterJoypadAxis2dBinding:allBindings())
                for _, charBinding in ipairs(combinedAllBindings) do
                    if (luautils.tableContains(self.excludingCharBindings, charBinding) == false) then
                        local labelText = getText(charBinding:getNameTranslationKey())
                        self:addOptionWithData(labelText, charBinding)
                        cboxWidth = math.max(getTextManager():MeasureStringX(FONT_MEDIUM, labelText), cboxWidth)
                    end
                end
            else
                for _, charBinding in ipairs(CharacterJoypadButtonBinding:allBindings()) do
                    if (luautils.tableContains(self.excludingCharBindings, charBinding) == false) then
                        local labelText = getText(charBinding:getNameTranslationKey())
                        self:addOptionWithData(labelText, charBinding)
                        cboxWidth = math.max(getTextManager():MeasureStringX(FONT_MEDIUM, labelText), cboxWidth)
                    end
                end
            end
        end

        if (self.selectedCharBinding == "!AddNewEntry!") then
            local addEntryText = "< Add New >"
            local addEntryDescription = "Add new entry"
            self:addOptionWithData(addEntryText, "!AddNewEntry!", addEntryDescription)
            cboxWidth = math.max(getTextManager():MeasureStringX(FONT_MEDIUM, addEntryText), cboxWidth)
        else
            local removeEntryText = "< Remove >"
            local removeEntryDescription = "Remove this entry"
            self:addOptionWithData(removeEntryText, "!RemoveEntry!", removeEntryDescription)
            cboxWidth = math.max(getTextManager():MeasureStringX(FONT_MEDIUM, removeEntryText), cboxWidth)
        end

        self:setWidth(cboxWidth + UI_BORDER_SPACING * 2 + BUTTON_HGT)
        self:setSelectedData(self.selectedCharBinding)
    end

    return buttonBindingCBox
end

