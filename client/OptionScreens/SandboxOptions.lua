require "ISUI/ISPanelJoypad"

SandboxOptionsScreen = ISPanelJoypad:derive("SandboxOptionsScreen")
local SandboxOptionsScreenListBox = ISScrollingListBox:derive("SandboxOptionsScreenListBox")
local SandboxOptionsScreenPanel = ISPanelJoypad:derive("SandboxOptionsScreenPanel")
local SandboxOptionsScreenPresetPanel = ISPanelJoypad:derive("SandboxOptionsScreenPresetPanel")
local SandboxAdvancedControl = ISPanel:derive("SandboxAdvancedControl")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_TITLE = getTextManager():getFontFromEnum(UIFont.Title):getLineHeight()
local FONT_HGT_MEDIUM = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight()
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local ENTRY_HGT = FONT_HGT_MEDIUM + 6
local JOYPAD_TEX_SIZE = 32
local CONTROL_WIDTH = 150 +((getCore():getOptionFontSizeReal()-1)*50)

function SandboxOptionsScreenListBox:doDrawItem(y, item, alt)
    self:drawRectBorder(0, y, self:getWidth(), self.itemheight - 1, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)

    if item.item.category then
        self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.5, 0.5, 0.5)
        local tex = getTexture("media/ui/ArrowDown.png")
        self:drawTexture(tex, 4, y + (item.height - tex:getHeight()) / 2, 1, 1, 1, 1)
    elseif self.selected == item.index then
        self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15)
    elseif self.mouseoverselected == item.index and not self:isMouseOverScrollBar() then
        self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 4, 0.95, 0.05, 0.05, 0.05);
    end

    local dx = UI_BORDER_SPACING
    local dy = (self.itemheight - getTextManager():getFontFromEnum(self.font):getLineHeight()) / 2
    if item.searchFound then
        self:drawText(item.text, dx, y + dy, 0.0, 0.9, 0.0, 0.9, self.font)
    else
        self:drawText(item.text, dx, y + dy, 0.9, 0.9, 0.9, 0.9, self.font)
    end


    return y + item.height
end

function SandboxOptionsScreenListBox:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function SandboxOptionsScreenListBox:onJoypadDown(button, joypadData)
    if button == Joypad.BButton then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
    elseif button == Joypad.YButton then
        joypadData.focus = self.parent.searchEntry
        updateJoypadFocus(joypadData)
    end
end

function SandboxOptionsScreenListBox:onJoypadDirLeft(joypadData)
    joypadData.focus = self.parent.presetPanel
    updateJoypadFocus(joypadData)
end

function SandboxOptionsScreenListBox:onJoypadDirRight(joypadData)
    joypadData.focus = self.parent.currentPanel
    updateJoypadFocus(joypadData)
end

-- -- -- -- --

local _multiplers = {"Aiming", "Axe", "Blacksmith", "Blunt", "Butchering", "Carving", "Cooking", "Doctor", "Electricity", "Farming", "Fishing", "Fitness", "FlintKnapping", "Glassmaking", "Husbandry", "Lightfoot", "LongBlade", "Maintenance", "Masonry", "Mechanics", "MetalWelding", "Nimble", "PlantScavenging", "Pottery", "Reloading", "SmallBlade", "SmallBlunt", "Sneak", "Spear", "Sprinting", "Strength", "Tailoring", "Tracking", "Trapping", "Woodwork"}
local multiplers = {}
for _, v in ipairs(_multiplers) do
    multiplers["MultiplierConfig." .. v] = true
end

local _maps = {"AllowMiniMap", "MapAllKnown"}
local maps = {}
for _, v in ipairs(_maps) do
    maps["Map." .. v] = true
end

function SandboxOptionsScreenPanel:prerender()
    self:doRightJoystickScrolling(20, 20)
    ISPanelJoypad.prerender(self)
    if not self.entryText then
        self.entryText = {}
    end
    local nonDefaultOptions = self._instance.nonDefaultOptions
    for _,settingName in ipairs(self.settingNames) do
        local label = self.labels[settingName]
        local control = self.controls[settingName]
        if label and control then
            label:setColor(1, 1, 1)

            local option = nonDefaultOptions:getOptionByName(settingName)
            if option and (option:getValue() ~= option:getDefaultValue()) then
                label:setColor(1, 1, 0)
            end

            if
                (maps[settingName] and not self.controls["Map.AllowWorldMap"]:isSelected(1)) or
                (multiplers[settingName] and self.controls["MultiplierConfig.GlobalToggle"]:isSelected(1)) or
                (settingName == "MultiplierConfig.Global" and not self.controls["MultiplierConfig.GlobalToggle"]:isSelected(1))
            then
                label:setColor(0.4, 0.4, 0.4)
                if control.Type == "ISTextEntryBox" then
                    control:getJavaObject():setTextColor(ColorInfo.new(0.4, 0.4, 0.4, 1)) --grey out specific options
                end
            elseif maps[settingName] or multiplers[settingName] or settingName == "MultiplierConfig.Global" then
                if control.Type == "ISTextEntryBox" then
                    control:getJavaObject():setTextColor(ColorInfo.new(1, 1, 1, 1)) --ungrey specific options
                end
            end

            if label.searchFound then
                label:setColor(0, 1, 0)
            end

            if control:isMouseOver() then
                self:drawRect(label:getX() - UI_BORDER_SPACING, label:getY(), (control:getX() + control:getWidth()) * 2 - self.width + UI_BORDER_SPACING, label:getHeight(), 0.3, 0.5, 0.5, 0.5)
            end
        end
        if control and control.Type == "ISTextEntryBox" then
            local text = control:getText()
            if text ~= self.entryText[settingName] then
                self.entryText[settingName] = text
                local option = getSandboxOptions():getOptionByName(settingName)
                if option then
                    if option:isValidString(text) then
                        control.borderColor.a = 1
                        control.borderColor.g = 0.4
                        control.borderColor.b = 0.4
                    else
                        control.borderColor.a = 0.9
                        control.borderColor.g = 0.0
                        control.borderColor.b = 0.0
                    end
                end
            end
        end
    end
    local x1,y1,x2,y2 = 1,1,self.width-1,self.height-1
    if self.isGroupBoxContentsPanel then
        y1 = self.parent.tickBox:getHeight() / 2
        y2 = self.height-6

        local options = self.parent.settings
        for _,settingName in ipairs(self.parent.settingNames) do
            local option = options:getOptionByName(settingName)
            local control = self.parent.controls[settingName]
            local label = self.parent.labels[settingName]
            label:setColor(1, 1, 1)
            if control.Type == "ISComboBox" then
                if control.selected ~= option:getDefaultValue() then
                    label:setColor(1, 1, 0)
                end
            elseif control.Type == "ISTickBox" then
                if control.selected[1] ~= option:getDefaultValue() then
                    label:setColor(1, 1, 0)
                end
            end
        end
    end
    self:setStencilRect(x1, y1, x2 - x1 + 1, y2 - y1 + 1)
end

function SandboxOptionsScreenPanel:render()
    self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    ISPanelJoypad.render(self)
    self:clearStencilRect()
    if self.isGroupBoxContentsPanel then
        self:repaintStencilRect(0, 0, self.width, self.height)
    end
end

function SandboxOptionsScreenPanel:onMouseWheel(del)
    if self:getScrollHeight() > 0 then
        self:setYScroll(self:getYScroll() - (del * 40))
        return true
    end
end

function SandboxOptionsScreenPanel:onJoypadDirUp(joypadData)
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]
    if child and child.isCombobox and child.expanded then
        child:onJoypadDirUp(joypadData)
    elseif child and (child.Type == "SandboxAdvancedControl") and child.combo:isVisible() and child.combo.expanded then
        child:onJoypadDirUp(joypadData)
    elseif child and child.isRadioButtons and child.joypadIndex > 1 then
        child:onJoypadDirUp(joypadData)
    elseif child and child.isTickBox and child.joypadIndex > 1 then
        child:onJoypadDirUp(joypadData)
    elseif child and child.isKnob then
        child:onJoypadDirUp(joypadData)
    else
        if (#self.joypadButtonsY > 0) and (self.joypadIndexY > 1) and (self.joypadIndexY <= #self.joypadButtonsY) then
            child:setJoypadFocused(false, joypadData);
            self.joypadIndexY = self.joypadIndexY - 1;
            self.joypadButtons = self.joypadButtonsY[self.joypadIndexY];
            children = self:getVisibleChildren(self.joypadIndexY)
            self.joypadIndex = self:getClosestChild(children, child.x + child.width / 2)
            if self.joypadIndex > #children then
                self.joypadIndex = #children;
            end
            children[self.joypadIndex]:setJoypadFocused(true, joypadData);
        end
    end
    self:ensureVisible()
end


function SandboxOptionsScreenPanel:onJoypadDirDown(joypadData)
    local children = self:getVisibleChildren(self.joypadIndexY)
    local child = children[self.joypadIndex]
    if child and child.isCombobox and child.expanded then
        child:onJoypadDirDown(joypadData)
    elseif child and (child.Type == "SandboxAdvancedControl") and child.combo:isVisible() and child.combo.expanded then
        child:onJoypadDirDown(joypadData)
    elseif child and child.isRadioButtons and child.joypadIndex < #child.options then
        child:onJoypadDirDown(joypadData)
    elseif child and child.isTickBox and child.joypadIndex < #child.options then
        child:onJoypadDirDown(joypadData)
    elseif child and child.isKnob then
        child:onJoypadDirDown(joypadData)
    else
        if (#self.joypadButtonsY > 0) and (self.joypadIndexY < #self.joypadButtonsY) then
            child:setJoypadFocused(false, joypadData);
            self.joypadIndexY = self.joypadIndexY + 1;
            self.joypadButtons = self.joypadButtonsY[self.joypadIndexY];
            children = self:getVisibleChildren(self.joypadIndexY)
            self.joypadIndex = self:getClosestChild(children, child.x + child.width / 2)
            if self.joypadIndex > #children then
                self.joypadIndex = #children;
            end
            children[self.joypadIndex]:setJoypadFocused(true, joypadData);
        end
    end
    self:ensureVisible()
end

function SandboxOptionsScreenPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self.joypadButtons[self.joypadIndex] then
        self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

function SandboxOptionsScreenPanel:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus(joypadData)
end

function SandboxOptionsScreenPanel:onJoypadDown(button, joypadData)
    if button == Joypad.BButton and not self:isFocusOnControl() then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
    elseif button == Joypad.YButton then
        joypadData.focus = self.parent.searchEntry
        updateJoypadFocus(joypadData)
    else
        local children = self:getVisibleChildren(self.joypadIndexY)
        local child = children[self.joypadIndex]
        if button == Joypad.AButton and child and (child.Type == "SandboxAdvancedControl") then
            child:onJoypadDown(button, joypadData);
        end

        ISPanelJoypad.onJoypadDown(self, button, joypadData)
    end
end

function SandboxOptionsScreenPanel:onJoypadDirLeft(joypadData)
    if not self:isFocusOnControl() then
        joypadData.focus = self.parent.listbox
        updateJoypadFocus(joypadData)
    end
end

function SandboxOptionsScreenPanel:onJoypadDirRight(joypadData)
    if not self:isFocusOnControl() then
        joypadData.focus = self.parent.presetPanel
        updateJoypadFocus(joypadData)
    end
end

-- -- -- -- --

function SandboxAdvancedControl:createChildren()
    self.entry = ISTextEntryBox:new(self.setting.text, 0, 0, CONTROL_WIDTH, ENTRY_HGT)
    self.entry.font = UIFont.Medium
    self.entry.tooltip = self.tooltip
    self.entry:initialise()
    self.entry:instantiate()
    self.entry:setOnlyNumbers(self.setting.onlyNumbers or false)
    self.entry:setVisible(false)
    self:addChild(self.entry)

    self.combo = ISComboBox:new(0, 0, CONTROL_WIDTH, ENTRY_HGT, self, self.onComboBoxSelected, self, self.setting)
    if self.tooltip then
        self.combo.tooltip = { defaultTooltip = self.tooltip }
    end
    self.combo:initialise()
    for index, value in ipairs(self.setting.advancedCombo.values) do
        self.combo:addOption(getText(value.name))
        if index == self.setting.advancedCombo.default then
            self.combo.selected = index
        end
    end
    -- TODO: talk to Aitereon to find what this does?
    self.combo:addOption(getText("Sandbox_Custom"))
    self:addChild(self.combo)
end

function SandboxAdvancedControl:onComboBoxSelected(combo, control, setting)
    if combo.selected ~= #combo.options then
        control.entry:setText(tostring(setting.advancedCombo.values[combo.selected].text))
    end
    if setting.name == "ZombieConfig.PopulationMultiplier" and combo.selected ~= #combo.options then
        self.parent.parent.controls["Zombies"].selected = combo.selected
    end
end

function SandboxAdvancedControl:advancedCheckboxChanged(bool)
    self.combo:setVisible(not bool)
    self.entry:setVisible(bool)

    if self.combo:isVisible() then
        self.combo.selected = #self.combo.options
        for index, v in ipairs(self.setting.advancedCombo.values) do
            if tostring(v.text) == self.entry:getInternalText() then
                self.combo.selected = index
            end
        end
    end
end

function SandboxAdvancedControl:getText()
    return self.entry:getText()
end

function SandboxAdvancedControl:setJoypadFocused(focused)
    if self.combo:isVisible() then
        self.combo.joypadFocused = focused
    else
        self.entry.joypadFocused = focused
    end
end

function SandboxAdvancedControl:onJoypadDown(button, joypadData)
    if self.combo:isVisible() then
        if button == Joypad.AButton then
            self.combo:forceClick();
            return;
        end
        if button == Joypad.BButton and self.combo.expanded then
            self.combo.expanded = false;
            self.combo:hidePopup();
            return;
        end
    else
        self.entry:onJoypadDown(button, joypadData)
    end
end

function SandboxAdvancedControl:onJoypadDirUp(joypadData)
    if self.combo:isVisible() then
        self.combo:onJoypadDirUp(joypadData)
    else
        self.entry:onJoypadDirUp(joypadData)
    end
end

function SandboxAdvancedControl:onJoypadDirDown(joypadData)
    if self.combo:isVisible() then
        self.combo:onJoypadDirDown(joypadData)
    else
        self.entry:onJoypadDirDown(joypadData)
    end
end

function SandboxAdvancedControl:setText(value)
    self.entry:setText(value)
    self.combo.selected = #self.combo.options
    for index, v in ipairs(self.setting.advancedCombo.values) do
        if tostring(v.text) == value then
            self.combo.selected = index
        end
    end
end

function SandboxAdvancedControl:new(x, y, width, height, setting, tooltip)
    local o = ISUIElement:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.setting = setting
    o.tooltip = tooltip
    return o
end

-- -- -- -- --

function SandboxOptionsScreenPresetPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self.joypadButtons[self.joypadIndex] then
        self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

function SandboxOptionsScreenPresetPanel:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus(joypadData)
end

function SandboxOptionsScreenPresetPanel:onJoypadDown(button, joypadData)
    if button == Joypad.BButton and not self:isFocusOnControl() then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
    elseif button == Joypad.YButton then
        joypadData.focus = self.parent.searchEntry
        updateJoypadFocus(joypadData)
    else
        ISPanelJoypad.onJoypadDown(self, button, joypadData)
    end
end

function SandboxOptionsScreenPresetPanel:onJoypadDirUp(joypadData)
    if self:isFocusOnControl() then
        ISPanelJoypad.onJoypadDirUp(self, joypadData)
    else
        joypadData.focus = self.parent.listbox
        updateJoypadFocus(joypadData)
    end
end

function SandboxOptionsScreenPresetPanel:onJoypadDirLeft(joypadData)
    if self.joypadIndex == 1 then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
        return
    end
    ISPanelJoypad.onJoypadDirLeft(self, joypadData)
end

function SandboxOptionsScreenPresetPanel:onJoypadDirRight(joypadData)
    if self.joypadIndex == #self.joypadButtons then
        joypadData.focus = self.parent.advancedCheckBox
        updateJoypadFocus(joypadData)
        self.parent.advancedCheckBox:setJoypadFocused(true, joypadData)
        return
    end
    ISPanelJoypad.onJoypadDirRight(self, joypadData)
end



-- -- -- -- --

function SandboxOptionsScreen:syncStartDay()
    local year = getSandboxOptions():getFirstYear()
    local month = self.controls.StartMonth.selected
    if self.selectedYear == year and self.selectedMonth == month then return end
    self.selectedYear = year
    self.selectedMonth = month

    local lastDay = getGameTime():daysInMonth(year, month - 1)
    local t = {}
    for i=1,lastDay do table.insert(t, tostring(i)) end
    self.controls.StartDay.options = t
    if self.controls.StartDay.selected > lastDay then
        self.controls.StartDay.selected = lastDay
    end
end

function SandboxOptionsScreen:create()
    local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
    self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, self.onOptionMouseDown);
    self.backButton.internal = "BACK";
    self.backButton:initialise();
    self.backButton:instantiate();
    self.backButton:setAnchorLeft(true);
    self.backButton:setAnchorRight(false);
    self.backButton:setAnchorTop(false);
    self.backButton:setAnchorBottom(true);
    self.backButton:enableCancelColor()
    self:addChild(self.backButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_next"))
    self.playButton = ISButton:new(self.width - UI_BORDER_SPACING - btnWidth - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_next"), self, self.onOptionMouseDown);
    self.playButton.internal = "PLAY";
    self.playButton:initialise();
    self.playButton:instantiate();
    self.playButton:setAnchorLeft(false);
    self.playButton:setAnchorRight(true);
    self.playButton:setAnchorTop(false);
    self.playButton:setAnchorBottom(true);
    self.playButton:enableAcceptColor()
    self:addChild(self.playButton);

    self.presetPanel = SandboxOptionsScreenPresetPanel:new(0, self.backButton.y, 100, BUTTON_HGT)
    self.presetPanel:noBackground()
    self.presetPanel:setAnchorTop(false)
    self.presetPanel:setAnchorBottom(true)
    self:addChild(self.presetPanel)

    local labelX = 0
    local label = ISLabel:new(labelX, 3, FONT_HGT_SMALL, getText("Sandbox_SavedPresets"), 1, 1, 1, 1, UIFont.Medium, true);
    label:initialise();
    self.presetPanel:addChild(label);

    self.presetList = ISComboBox:new(labelX + getTextManager():MeasureStringX(UIFont.Medium, label:getName()) + UI_BORDER_SPACING*2, 0, CONTROL_WIDTH, BUTTON_HGT, self, self.onPresetChange);
    self.presetList:initialise();
    self.presetPanel:addChild(self.presetList);

    self.savePresetButton = ISButton:new(self.presetList.x + self.presetList.width + UI_BORDER_SPACING, 0, 50, BUTTON_HGT, getText("Sandbox_SaveButton"), self, self.onOptionMouseDown);
    self.savePresetButton.internal = "SAVEPRESET";
    self.savePresetButton:initialise();
    self.savePresetButton:instantiate();
    self.savePresetButton:setFont(UIFont.Small);
    self.savePresetButton:ignoreWidthChange();
    self.savePresetButton:ignoreHeightChange();
    self.savePresetButton:enableAcceptColor()
    self.presetPanel:addChild(self.savePresetButton);

    self.deletePresetButton = ISButton:new(self.savePresetButton:getRight() + UI_BORDER_SPACING, 0, 50, BUTTON_HGT, getText("UI_characreation_BuildDel"), self, self.onOptionMouseDown)
    self.deletePresetButton.internal = "DELETEPRESET"
    self.deletePresetButton:initialise()
    self.deletePresetButton:setFont(UIFont.Small)
    self.deletePresetButton:ignoreWidthChange()
    self.deletePresetButton:ignoreHeightChange()
    self.deletePresetButton:enableCancelColor()
    self.presetPanel:addChild(self.deletePresetButton)

    self.advancedCheckBox = ISTickBox:new(self.deletePresetButton:getRight() + UI_BORDER_SPACING, 0, BUTTON_HGT, BUTTON_HGT, "", self, self.changeAdvancedMode)
    self.advancedCheckBox:addOption(getText("Sandbox_Advanced"))
    self.advancedCheckBox.selected[1] = false
    self.advancedCheckBox.tooltip = getText("Sandbox_Advanced_tooltip")
    self.advancedCheckBox.onJoypadDirRight = function(_self, joypadData)
        joypadData.focus = _self.parent.parent
        updateJoypadFocus(joypadData)
        _self:setJoypadFocused(false)
    end
    self.advancedCheckBox.onJoypadDirUp = function(_self, joypadData)
        joypadData.focus = _self.parent.parent
        updateJoypadFocus(joypadData)
        _self:setJoypadFocused(false)
    end
    self.advancedCheckBox.onJoypadDirLeft = function(_self, joypadData)
        joypadData.focus = _self.parent
        updateJoypadFocus(joypadData)
        _self:setJoypadFocused(false)
    end
    self.advancedCheckBox.onJoypadDown = function(_self, button, joypadData)
        if button == Joypad.AButton then
            _self.joypadIndex = 1
            _self:forceClick()
        end
        if button == Joypad.YButton then
            joypadData.focus = _self.parent.parent.searchEntry
            updateJoypadFocus(joypadData)
            _self:setJoypadFocused(false)
        end
    end
    self.presetPanel:addChild(self.advancedCheckBox)

    if getDebug() then
        self.devPresetButton = ISButton:new(self.deletePresetButton:getRight() + UI_BORDER_SPACING, 0, 50, BUTTON_HGT, "*DEV*", self, self.onOptionMouseDown)
        self.devPresetButton.internal = "DEVPRESET"
        self.devPresetButton:initialise()
        self.devPresetButton:setFont(UIFont.Small)
        self.devPresetButton:ignoreWidthChange()
        self.devPresetButton:ignoreHeightChange()
        self.presetPanel:addChild(self.devPresetButton)
        self.advancedCheckBox:setX(self.devPresetButton:getRight()+UI_BORDER_SPACING)
    end
    self.presetPanel:setWidth(self.advancedCheckBox:getRight()+getTextManager():MeasureStringX(UIFont.Small, getText("Sandbox_Advanced")))
    self.presetPanel:setX(self.width / 2 - self.presetPanel:getWidth() / 2)

    self.presetPanel:insertNewLineOfButtons(self.presetList, self.savePresetButton, self.deletePresetButton, self.devPresetButton)
    self.presetPanel.joypadIndex = 1
    self.presetPanel.joypadIndexY = 1

    self.searchEntry = ISTextEntryBox:new("", UI_BORDER_SPACING+1, UI_BORDER_SPACING*2 + FONT_HGT_TITLE + 1, self.width - (UI_BORDER_SPACING+1)*2, ENTRY_HGT)
    self.searchEntry.font = UIFont.Medium
    self.searchEntry.onTextChange = function() self:doSearch() end
    self.searchEntry.setText = function(_self, str)
        if not str then
            str = "";
        end
        _self.javaObject:SetText(str);
        _self.title = str;

        if OnScreenKeyboard.IsVisible() then
            _self:onTextChange()
        end
    end
    self.searchEntry.prerender = self.searchPrerender
    self.searchEntry.onJoypadDown = function(_self, button, joypadData)
        if button == Joypad.BButton then
            joypadData.focus = _self.parent
            updateJoypadFocus(joypadData)
        else
            ISTextEntryBox.onJoypadDown(_self, button, joypadData)
        end
    end
    self.searchEntry:initialise()
    self.searchEntry:instantiate()
    self:addChild(self.searchEntry)

    self.listbox = SandboxOptionsScreenListBox:new(UI_BORDER_SPACING+1, self.searchEntry:getBottom()+UI_BORDER_SPACING, 300, self.height - self.searchEntry:getBottom() - UI_BORDER_SPACING*3-1 - BUTTON_HGT)
    self.listbox:initialise()
    self.listbox:setAnchorLeft(true)
    self.listbox:setAnchorRight(false)
    self.listbox:setAnchorTop(true)
    self.listbox:setAnchorBottom(true)
    self.listbox:setFont("Medium", 4)
    self.listbox.drawBorder = true
    self.listbox:setOnMouseDownFunction(self, self.onMouseDownListbox)
    self:addChild(self.listbox)

    self.controls = {}
    local SettingsTable = ServerSettingsScreen.getSandboxSettingsTable()
    local listboxWidth = 0

    --set listbox width
    for _,page in ipairs(SettingsTable) do
        listboxWidth = math.max(getTextManager():MeasureStringX(UIFont.Large, page.name), listboxWidth)
    end
    self.listbox:setWidth(listboxWidth + UI_BORDER_SPACING*2)

    for _,page in ipairs(SettingsTable) do
        local item = {}
        item.page = page
        item.panel = self:createPanel(page)
        self.listbox:addItem(page.name, item)
    end

    self:setVisible(false);
    self:loadPresets();
    for i,preset in ipairs(self.presets) do
        if preset.name == "Apocalypse" then
            self.presetList.selected = i
            break
        end
    end
    self:onPresetChange()

    self:onMouseDownListbox(self.listbox.items[1].item)
end

function SandboxOptionsScreen.searchPrerender(self)
    ISTextEntryBox.prerender(self)
    if not self.javaObject:isFocused() and self:getInternalText() == "" then
        self:drawText(getText("UI_sandbox_searchEntryBoxWord"), 2, 2, 0.9, 0.9, 0.9, 0.5, UIFont.Medium)
    end
end

function SandboxOptionsScreen:changeAdvancedMode(_, bool)
    for _, control in pairs(self.controls) do
        if control.Type == "SandboxAdvancedControl" then
            control:advancedCheckboxChanged(bool)
        end
    end
end

function SandboxOptionsScreen:doSearch()
    local searchWord = string.lower(self.searchEntry:getInternalText())
    for i, item in ipairs(self.listbox.items) do
        item.searchFound = false
        for name, label in pairs(item.item.panel.labels) do
            if searchWord ~= "" and string.find(string.lower(label:getName()), searchWord) then
                label.searchFound = true
                item.searchFound = true
                self:onMouseDownListbox(item.item)
                self.listbox.selected = i
            else
                label.searchFound = false
            end
        end
    end
end

function SandboxOptionsScreen:createPanel(page)
    local panel = SandboxOptionsScreenPanel:new(self.listbox:getRight() + UI_BORDER_SPACING, self.listbox:getY(), self.width - self.listbox:getRight() - UI_BORDER_SPACING*2-1, self.listbox:getHeight())
    panel._instance = self
    panel:initialise()
    panel:instantiate()
    panel:setAnchorRight(true)
    panel:setAnchorBottom(true)
    panel.settingNames = {}
    panel.labels = {}
    panel.controls = {}
    panel.titles = {}

    local largeFontHgt = getTextManager():getFontFromEnum(UIFont.Large):getLineHeight()
    local entryLargeHgt = largeFontHgt + 6

    local labels = {}
    local controls = {}
    local titles = {}
    for _,setting in ipairs(page.settings) do
        local settingName = setting.translatedName
        local tooltip = setting.tooltip
        if tooltip then
            tooltip = tooltip:gsub("\\n", "\n")
            tooltip = tooltip:gsub("\\\"", "\"")
        end
        local label
        local control
        if setting.type == "checkbox" then
            label = ISLabel:new(0, 0, ENTRY_HGT, settingName, 1, 1, 1, 1, UIFont.Medium)
            control = ISTickBox:new(0, 0, ENTRY_HGT, ENTRY_HGT, "", self, self.onTickBoxSelected, setting.name)
            control:addOption("")
            control.selected[1] = setting.default
            if setting.tooltip then
                control.tooltip = tooltip
            end
        elseif setting.type == "entry" or setting.type == "string" then
            if getDebug() and (setting.name == "WaterShutModifier" or setting.name == "ElecShutModifier") then
                settingName = "*DEBUG* " .. setting.name
            end
            label = ISLabel:new(0, 0, ENTRY_HGT, settingName, 1, 1, 1, 1, UIFont.Medium)
            if setting.advancedCombo then
                control = SandboxAdvancedControl:new(0, 0, CONTROL_WIDTH, ENTRY_HGT, setting, tooltip)
                control:initialise()
                control:instantiate()
            else
                control = ISTextEntryBox:new(setting.text, 0, 0, CONTROL_WIDTH, ENTRY_HGT)
                control.font = UIFont.Medium
                control.tooltip = tooltip
                control:initialise()
                control:instantiate()
                control:setOnlyNumbers(setting.onlyNumbers or false)
            end
        elseif setting.type == "enum" then
            label = ISLabel:new(0, 0, ENTRY_HGT, settingName, 1, 1, 1, 1, UIFont.Medium)
            control = ISComboBox:new(0, 0, CONTROL_WIDTH, ENTRY_HGT, self, self.onComboBoxSelected, setting.name)
            if tooltip then
                control.tooltip = { defaultTooltip = tooltip }
            end
            control:initialise()
            for index,value in ipairs(setting.values) do
                control:addOption(value)
                if index == setting.default then
                    control.selected = index
                end
            end
        elseif setting.type == "spinbox" then
            label = ISLabel:new(0, 0, ENTRY_HGT, settingName, 1, 1, 1, 1, UIFont.Medium)
            control = ISSpinBox:new(0, 0, CONTROL_WIDTH, ENTRY_HGT, nil, nil)
            control:initialise()
            control:instantiate()
            if setting.name == "StartYear" then
                local firstYear = getSandboxOptions():getFirstYear()
                for i=1,100 do
                    control:addOption(tostring(firstYear + i - 1))
                end
            elseif setting.name == "StartDay" then
            end
        end
        if label and control then
            label.tooltip = tooltip
            table.insert(labels, label)
            table.insert(controls, control)
            self.controls[setting.name] = control
            table.insert(panel.settingNames, setting.name)
            panel.labels[setting.name] = label
            panel.controls[setting.name] = control

            if setting.title then
                titles[#labels] = { title = getText("Sandbox_Title_" .. setting.title) }
            end
        else
            error "no label or control"
        end
    end

    local labelWidth = 0
    for _,label in ipairs(labels) do
        labelWidth = math.max(labelWidth, label:getWidth())
    end
    --if labelWidth + CONTROL_WIDTH > panel.width - 13 - UI_BORDER_SPACING then
    --    CONTROL_WIDTH = panel.width - labelWidth - 13 - UI_BORDER_SPACING*2
    --end
    local xOffset = (panel.width - (labelWidth + CONTROL_WIDTH + UI_BORDER_SPACING*2))/2
    local y = 11

    local addControlsTo = panel
    addControlsTo:setScrollChildren(true)
    addControlsTo:addScrollBars()
    addControlsTo.vscroll.doSetStencil = false

    for i=1,#labels do
        if titles[i] then
            local title = ISLabel:new(0, 0, entryLargeHgt, titles[i].title, 1, 1, 1, 1, UIFont.Large)
            table.insert(panel.titles, title)
            addControlsTo:addChild(title)
            title:setX((panel:getWidth()-title:getWidth())/2)
            title:setY(y + UI_BORDER_SPACING*2)

            y = y + entryLargeHgt + 22
            titles[i].yShift = y
        end

        local label = labels[i]
        addControlsTo:addChild(label)
        label:setX(xOffset)
        label:setY(y)
        y = y + math.max(label:getHeight(), controls[i]:getHeight()) + UI_BORDER_SPACING;
        end
    y = 11
    for i=1,#controls do
        if titles[i] then
            y = titles[i].yShift
        end

        local label = labels[i]
        local control = controls[i]
        addControlsTo:addChild(control)
        control:setX(panel:getWidth() - xOffset - control:getWidth())
        control:setY(y)
        y = y + math.max(label:getHeight(), control:getHeight()) + UI_BORDER_SPACING
        if control.isCombobox or control.isTickBox or (control.Type == "ISTextEntryBox") or (control.Type == "SandboxAdvancedControl") then
            panel:insertNewLineOfButtons(control)
        end
        addControlsTo:setScrollHeight(y)
    end
    if #panel.joypadButtonsY > 0 then
        panel.joypadIndex = 1
        panel.joypadIndexY = 1
        panel.joypadButtons = panel.joypadButtonsY[1]
    end
    return panel
end

function SandboxOptionsScreen:onTickBoxSelected(_, value, optionName)
    if optionName == "ZombieMigrate" then
        if value then
            self.controls["ZombieConfig.RedistributeHours"]:setText("12.0")
        else
            self.controls["ZombieConfig.RedistributeHours"]:setText("0.0")
        end
    end
end

function SandboxOptionsScreen:onComboBoxSelected(combo, optionName)
    if optionName == "Zombies" then
        local Zombies = combo.selected
        local popMult = ZombiePopulationMultiplierTable
        self.controls["ZombieConfig.PopulationMultiplier"]:setText(popMult[Zombies])
    end
    if optionName == "ZombieRespawn" then
        local respawn = combo.selected
        local respawnHours = { "16.0", "72.0", "216.0", "0.0" }
        self.controls["ZombieConfig.RespawnHours"]:setText(respawnHours[respawn])
        local respawnUnseenHours = { "6.0", "16.0", "48.0", "0.0" }
        self.controls["ZombieConfig.RespawnUnseenHours"]:setText(respawnUnseenHours[respawn])
        local respawnMultipler = { "0.5", "0.1", "0.05", "0.0" }
        self.controls["ZombieConfig.RespawnMultiplier"]:setText(respawnMultipler[respawn])
    end
end

function SandboxOptionsScreen:settingsToUI(options)
    for i=1,options:getNumOptions() do
        local option = options:getOptionByIndex(i-1)
        local control = self.controls[option:getName()]
        if control then
            if option:getType() == "boolean" then
                control.selected[1] = option:getValue()
            elseif option:getType() == "double" then
                control:setText(option:getValueAsString())
            elseif option:getType() == "enum" then
                control.selected = option:getValue()
            elseif option:getType() == "integer" then
                control:setText(option:getValueAsString())
            elseif option:getType() == "string" then
                control:setText(option:getValue())
            elseif option:getType() == "text" then
                control:setText(option:getValue())
            end
        end
    end
end

function SandboxOptionsScreen:settingsFromUI(options)
    for i=1,options:getNumOptions() do
        local option = options:getOptionByIndex(i-1)
        local control = self.controls[option:getName()]
        if control then
            if option:getType() == "boolean" then
                option:setValue(control.selected[1] == true)
            elseif option:getType() == "double" then
                option:parse(control:getText())
            elseif option:getType() == "enum" then
                option:setValue(control.selected)
            elseif option:getType() == "integer" then
                option:parse(control:getText())
            elseif option:getType() == "string" then
                option:setValue(control:getText())
            elseif option:getType() == "text" then
                option:setValue(control:getText())
            end
        end
    end
end

function SandboxOptionsScreen:onMouseDownListbox(item)
    if item.page then
        if self.currentPanel then
            self:removeChild(self.currentPanel)
            self.currentPanel = nil
        end
        if item.panel then
            self:addChild(item.panel)
            item.panel:setWidth(self.width - self.listbox:getRight() - UI_BORDER_SPACING*2-1)
            item.panel:setHeight(self.listbox:getHeight())
            self.currentPanel = item.panel
            self:onPanelChange()
        end
    end
end

function SandboxOptionsScreen:onResolutionChange(oldw, oldh, neww, newh)
    if self.currentPanel then
    self.presetPanel:setX((self.width - self.presetPanel:getWidth()) / 2)
        self:onPanelChange()
    end
    self.searchEntry:setWidth(self.width - (UI_BORDER_SPACING+1)*2)
end

function SandboxOptionsScreen:onPanelChange()
    local labelWidth = 0
    self.currentPanel:setWidth(self.width - self.listbox:getRight() - UI_BORDER_SPACING*2 - 1)
    local panelWidth = self.currentPanel.width
    local name

    for i=1,#self.currentPanel.settingNames do
        name = self.currentPanel.settingNames[i]
        labelWidth = math.max(labelWidth, self.currentPanel.labels[name].width)
    end

    local xOffset = (panelWidth - (labelWidth + CONTROL_WIDTH + UI_BORDER_SPACING*2))/2

    for i=1,#self.currentPanel.settingNames do
        name = self.currentPanel.settingNames[i]
        self.currentPanel.labels[name]:setX(xOffset)
        self.currentPanel.controls[name]:setX(panelWidth - xOffset - self.currentPanel.controls[name].width)
    end

    for i=1,#self.currentPanel.titles do
        self.currentPanel.titles[i]:setX((panelWidth-self.currentPanel.titles[i].width)/2)
    end
end

function SandboxOptionsScreen:onPresetChange()
    local presetLoaded = self.presets[self.presetList.selected];
    if presetLoaded then
        self:settingsToUI(presetLoaded.options)
    end
end

function SandboxOptionsScreen:addPresetToList(fileName, text, userDefined)
    self.presetList:addOption(text)

    local newPreset = {}
    newPreset.name = fileName
    newPreset.options = SandboxOptions.new()
    newPreset.userDefined = userDefined
    if userDefined then
        newPreset.options:loadPresetFile(newPreset.name)
    else
        newPreset.options:loadGameFile(newPreset.name)
    end
    table.insert(self.presets, newPreset)
end

function SandboxOptionsScreen:loadPresets()
    self.presetList.options = {};
    self.presets = {};

    self:addPresetToList("Apocalypse", getText("UI_NewGame_Apocalypse"), false)
    self:addPresetToList("Survivor", getText("UI_NewGame_Survivor"), false)
    self:addPresetToList("Builder", getText("UI_NewGame_Builder"), false)
    self:addPresetToList("Beginner", getText("UI_NewGame_InitialInfection"), false)
    self:addPresetToList("FirstWeek", getText("UI_NewGame_OneWeekLater"), false)
    self:addPresetToList("Survival", getText("UI_NewGame_Survival"), false)
    self:addPresetToList("SixMonthsLater", getText("UI_NewGame_SixMonths"), false)

    local presets = getSandboxPresets();
    if presets then
        for i=1,presets:size() do
            local fileName = presets:get(i-1)
            self:addPresetToList(fileName, fileName, true)
        end
    end

    if self.presetList.selected > #self.presetList.options then
        self.presetList.selected = #self.presetList.options
    end
    self:onPresetChange()
end


function SandboxOptionsScreen:getNormalPreset()
    local newPreset = {};
    newPreset.name = "FirstWeek";
    newPreset.options = SandboxOptions.new()
    newPreset.options:loadGameFile(newPreset.name)
    return newPreset;
end

function SandboxOptionsScreen:getSurvivalPreset()
    local newPreset = {};
    newPreset.name = "Survival";
    newPreset.options = SandboxOptions.new()
    newPreset.options:loadGameFile(newPreset.name)
    return newPreset;
end

function SandboxOptionsScreen:getHardPreset()
    local newPreset = {};
    newPreset.name = "SixMonthsLater";
    newPreset.options = SandboxOptions.new()
    newPreset.options:loadGameFile(newPreset.name)
    return newPreset;
end

function SandboxOptionsScreen:getBeginnerPreset()
    local newPreset = {};
    newPreset.name = "Beginner";
    newPreset.options = SandboxOptions.new()
    newPreset.options:loadGameFile(newPreset.name)
    return newPreset;
end

function SandboxOptionsScreen:getApocalypsePreset()
    local newPreset = {};
    newPreset.name = "Apocalypse";
    newPreset.options = SandboxOptions.new()
    newPreset.options:loadGameFile(newPreset.name)
    return newPreset;
end

function SandboxOptionsScreen:getSurvivorPreset()
    local newPreset = {};
    newPreset.name = "Survivor";
    newPreset.options = SandboxOptions.new()
    newPreset.options:loadGameFile(newPreset.name)
    return newPreset;
end

function SandboxOptionsScreen:getBuilderPreset()
    local newPreset = {};
    newPreset.name = "Builder";
    newPreset.options = SandboxOptions.new()
    newPreset.options:loadGameFile(newPreset.name)
    return newPreset;
end

function SandboxOptionsScreen:prerender()
    SandboxOptionsScreen.instance = self

    self:syncStartDay()

    ISPanelJoypad.prerender(self);
    self:drawTextCentre(getText("UI_optionscreen_SandboxOptions"), self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Title);

    local deleteOK = false
    if self.presets[self.presetList.selected] then
        deleteOK = self.presets[self.presetList.selected].userDefined
        if getDebug() then
            self.devPresetButton:setEnable(not deleteOK)
        end
    end
    self.deletePresetButton:setEnable(deleteOK)

    -- This is used to highlight options with non-default values.
    self:settingsFromUI(self.nonDefaultOptions)
end

function SandboxOptionsScreen:render()
    ISPanelJoypad.render(self)

    if self.listbox.joyfocus then
        local ui = self.listbox
        self:drawRectBorder(ui:getX(), ui:getY(), ui:getWidth(), ui:getHeight(), 0.4, 0.2, 1.0, 1.0)
        self:drawRectBorder(ui:getX()+1, ui:getY()+1, ui:getWidth()-2, ui:getHeight()-2, 0.4, 0.2, 1.0, 1.0)
    elseif self.currentPanel.joyfocus then
        local ui = self.currentPanel
        self:drawRectBorder(ui:getX(), ui:getY(), ui:getWidth(), ui:getHeight(), 0.4, 0.2, 1.0, 1.0)
        self:drawRectBorder(ui:getX()+1, ui:getY()+1, ui:getWidth()-2, ui:getHeight()-2, 0.4, 0.2, 1.0, 1.0)
    elseif self.presetPanel.joyfocus then
        local ui = self.presetPanel
        self:drawRectBorder(ui:getX() - 4, ui:getY() - 4, ui:getWidth() + 4 + 3, ui:getHeight() + 4 + 3, 0.4, 0.2, 1.0, 1.0)
        self:drawRectBorder(ui:getX() - 3, ui:getY() - 3, ui:getWidth() + 3 + 2, ui:getHeight() + 4 + 2, 0.4, 0.2, 1.0, 1.0)
    end
    if self.searchEntry.isJoypad then
        self:drawTextureScaled(Joypad.Texture.YButton, self.width - UI_BORDER_SPACING-JOYPAD_TEX_SIZE, self.searchEntry:getY() + (self.searchEntry.height-JOYPAD_TEX_SIZE)/2, JOYPAD_TEX_SIZE, JOYPAD_TEX_SIZE, 1, 1, 1, 1)
    end
end

function SandboxOptionsScreen:setSandboxVars()
    local options = getSandboxOptions()
    self:settingsFromUI(options)
    local waterShut = options:getOptionByName("WaterShut"):getValue()
    local elecShut = options:getOptionByName("ElecShut"):getValue()
    options:set("WaterShutModifier", options:randomWaterShut(waterShut))
    options:set("ElecShutModifier", options:randomElectricityShut(elecShut))
    options:toLua()
end

function SandboxOptionsScreen:onOptionMouseDown(button, x, y)
    if button.internal == "BACK" then
        self:setVisible(false);
        if MainScreen.instance.createWorld or MapSpawnSelect.instance:hasChoices() then
            MapSpawnSelect.instance:setVisible(true, self.joyfocus)
            return
        end
        if WorldSelect.instance:hasChoices() then
            WorldSelect.instance:setVisible(true, self.joyfocus)
            return
        end
    end
    if button.internal == "PLAY" then
        MainScreen.instance.sandOptions:setVisible(false);
        MainScreen.instance.charCreationProfession.previousScreen = "SandboxOptionsScreen"
        MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus);
        self:setSandboxVars();
        local preset = self.presets[self.presetList.selected].name or "Apocalypse"
        getWorld():setPreset(preset);
    end
    if button.internal == "SAVEPRESET" then
        local name = "New"
        if self.presets[self.presetList.selected] and self.presets[self.presetList.selected].userDefined then
            name = self.presets[self.presetList.selected].name or "New"
        end
        local modal = ISTextBox:new((getCore():getScreenWidth() / 2) - 140, (getCore():getScreenHeight() / 2) - 90, 280, 180, getText("Sandbox_SavePrompt"), name, self, self.onSavePreset);
        modal.backgroundColor.a = 0.9
        modal:initialise();
        modal:setAlwaysOnTop(true)
        modal:setCapture(true)
        modal:setValidateFunction(self, self.onValidateSavePreset)
        modal:addToUIManager();
        if self.presetPanel.joyfocus then
            modal.param1 = self.presetPanel.joyfocus
            self.presetPanel.joyfocus.focus = modal
            updateJoypadFocus(self.presetPanel.joyfocus)
        end
    end
    if button.internal == "DELETEPRESET" then
        local preset = self.presets[self.presetList.selected]
        if preset and preset.userDefined then
            self:deletePresetStep1(preset)
        end
    end
    if button.internal == "DEVPRESET" then
        local preset = self.presets[self.presetList.selected]
        if preset and not preset.userDefined then
            local screenW = getCore():getScreenWidth()
            local screenH = getCore():getScreenHeight()
            local modal = ISModalDialog:new((screenW - 230) / 2, (screenH - 120) / 2, 230, 120,
                    "Overwrite media/lua/shared/Sandbox/" .. preset.name .. ".lua?", true, self, self.onSaveDeveloperPreset);
            modal.backgroundColor.a = 0.9
            modal:initialise()
            modal:setCapture(true)
            modal:setAlwaysOnTop(true)
            modal:addToUIManager()
            if self.presetPanel.joyfocus then
                modal.param1 = self.presetPanel.joyfocus
                self.presetPanel.joyfocus.focus = modal
                updateJoypadFocus(self.presetPanel.joyfocus)
            end
        end
    end
end

function SandboxOptionsScreen:onSavePreset(button, joypadData)
    local modal = button.parent;
    if joypadData then
        joypadData.focus = self.presetPanel
        updateJoypadFocus(joypadData)
    end
    if button.internal == "OK" then
        local name = button.parent.entry:getText()
        if SandboxOptions.isValidPresetName(name) then
            modal:destroy()
            local options = SandboxOptions.new()
            self:settingsFromUI(options)
            options:savePresetFile(name)
            self:loadPresets()
            for i,preset in ipairs(self.presets) do
                if preset.name == name then
                    self.presetList.selected = i
                    self:onPresetChange()
                    break
                end
            end
        else
            -- Let player know an invalid character was entered
            modal:showErrorMessage(true, getText("Sandbox_PresetName_Error"))
        end
    elseif button.internal == "CANCEL" then
        modal:destroy()
    end
end

function SandboxOptionsScreen:deletePresetStep1(preset)
    local screenW = getCore():getScreenWidth()
    local screenH = getCore():getScreenHeight()
    local modal = ISModalDialog:new((screenW - 230) / 2, (screenH - 120) / 2, 230, 120, getText("Sandbox_DeletePresetPrompt", preset.name), true, self, self.deletePresetStep2);
    modal.backgroundColor.a = 0.9
    modal:initialise()
    modal:setCapture(true)
    modal:setAlwaysOnTop(true)
    modal:addToUIManager()
    if self.presetPanel.joyfocus then
        modal.param1 = self.presetPanel.joyfocus
        self.presetPanel.joyfocus.focus = modal
        updateJoypadFocus(self.presetPanel.joyfocus)
    end
end

function SandboxOptionsScreen:deletePresetStep2(button, joypadData)
    if joypadData then
        joypadData.focus = self.presetPanel
        updateJoypadFocus(joypadData)
    end
    if button.internal == "NO" then return end

    local preset = self.presets[self.presetList.selected]
    if preset and preset.userDefined then
        deleteSandboxPreset(preset.name)
        self:loadPresets()
    end
end

function SandboxOptionsScreen:onValidateSavePreset(text)
    return SandboxOptions.isValidPresetName(text)
end

function SandboxOptionsScreen:onSaveDeveloperPreset(button, joypadData)
    if joypadData then
        joypadData.focus = self.presetPanel
        updateJoypadFocus(joypadData)
    end
    if button.internal == "NO" then return end
    local preset = self.presets[self.presetList.selected]
    if preset and not preset.userDefined then
        self:settingsFromUI(preset.options)
        preset.options:saveGameFile(preset.name)
        self:loadPresets()
    end
end

function SandboxOptionsScreen:setVisible(visible, joypadData)
    ISPanelJoypad.setVisible(self, visible, joypadData)
    if not visible then
        self.hadJoypadFocus = true
    end
end

function SandboxOptionsScreen:onGainJoypadFocus(joypadData)
    if self.hadJoypadFocus then
        ISPanelJoypad.onGainJoypadFocus(self, joypadData)
        self:setISButtonForA(self.playButton)
        self:setISButtonForB(self.backButton)
    else
        self.hadJoypadFocus = true
        joypadData.focus = self.listbox
        updateJoypadFocus(joypadData)
    end
    self.searchEntry:setWidth(self.width - UI_BORDER_SPACING*3 - JOYPAD_TEX_SIZE - 1)
    self.searchEntry.isJoypad = true
end

function SandboxOptionsScreen:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self.playButton.isJoypad = false
    self.backButton:clearJoypadButton()
    self.ISButtonY = nil
end

function SandboxOptionsScreen:onJoypadDirUp(joypadData)
    joypadData.focus = self.listbox
    updateJoypadFocus(joypadData)
end

function SandboxOptionsScreen:onJoypadDirLeft(joypadData)
    joypadData.focus = self.advancedCheckBox
    updateJoypadFocus(joypadData)
    self.advancedCheckBox:setJoypadFocused(true, joypadData)
end

function SandboxOptionsScreen:onJoypadDirRight(joypadData)
    joypadData.focus = self.presetPanel
    updateJoypadFocus(joypadData)
end

function SandboxOptionsScreen:onJoypadDown(button, joypadData)
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
    if button == Joypad.YButton then
        joypadData.focus = self.searchEntry
        updateJoypadFocus(joypadData)
    end
end

function SandboxOptionsScreen:new(x, y, width, height)
    local o = {}
    o = ISPanelJoypad:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.x = x
    o.y = y
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=1, g=1, b=1, a=0.2};
    o.width = width
    o.height = height
    o.nonDefaultOptions = SandboxOptions.new()
    SandboxOptionsScreen.instance = o
    return o
end