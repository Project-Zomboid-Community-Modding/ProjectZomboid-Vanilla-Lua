--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISUIElement"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10

ModListPresets = ISUIElement:derive("ModListPresets")

function ModListPresets:new(x, y, width, height, model)
    local o = ISUIElement:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.model = model
    o.childrenLine = {}
    o.childrenIndex = 1
    return o
end

function ModListPresets:createChildren()
    self.presetCombo = ISComboBox:new(0, 0, math.min(200, self.width/2.0), BUTTON_HGT, self, self.choosePreset)
    self.presetCombo:initialise()
    self.presetCombo:addOptionWithData(getText("UI_mods_preset_choose"), "default")
    self.presetCombo:addOptionWithData(getText("UI_mods_preset_disableAll"), "default")
    self.presetCombo:addOptionWithData(getText("UI_mods_preset_enableAll"), "default")
    self.presetCombo:setAnchorLeft(true);
    self.presetCombo:setAnchorRight(false);
    self.presetCombo:setAnchorTop(false);
    self.presetCombo:setAnchorBottom(true);
    self.presetCombo:ignoreWidthChange();
    self.presetCombo:ignoreHeightChange();
    self:addChild(self.presetCombo)

    self.savePresetButton = ISButton:new(0, 0, 100, BUTTON_HGT, getText("UI_btn_save"), self, self.onPresetButton);
    self.savePresetButton.internal = "SAVE";
    self.savePresetButton:initialise();
    self.savePresetButton:instantiate();
    self.savePresetButton:setAnchorLeft(true);
    self.savePresetButton:setAnchorRight(false);
    self.savePresetButton:setAnchorTop(false);
    self.savePresetButton:setAnchorBottom(true);
    self.savePresetButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.savePresetButton:setFont(UIFont.Small);
    self.savePresetButton:ignoreWidthChange();
    self.savePresetButton:ignoreHeightChange();
    self:addChild(self.savePresetButton);
    self.savePresetButton:setWidthToTitle()
    self.savePresetButton:setX(self.presetCombo:getRight() + UI_BORDER_SPACING)

    self.delPresetButton = ISButton:new(0, 0, 100, BUTTON_HGT, getText("UI_btn_del"), self, self.onPresetButton);
    self.delPresetButton.internal = "DELETE";
    self.delPresetButton:initialise();
    self.delPresetButton:instantiate();
    self.delPresetButton:setAnchorLeft(true);
    self.delPresetButton:setAnchorRight(false);
    self.delPresetButton:setAnchorTop(false);
    self.delPresetButton:setAnchorBottom(true);
    self.delPresetButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.delPresetButton:setFont(UIFont.Small);
    self.delPresetButton:ignoreWidthChange();
    self.delPresetButton:ignoreHeightChange();
    self:addChild(self.delPresetButton);
    self.delPresetButton:setWidthToTitle()
    self.delPresetButton:setX(self.savePresetButton:getRight() + UI_BORDER_SPACING)

    self.sharePresetButton = ISButton:new(0, 0, 100, BUTTON_HGT, getText("UI_btn_share"), self, self.onPresetButton);
    self.sharePresetButton.internal = "SHARE";
    self.sharePresetButton:initialise();
    self.sharePresetButton:instantiate();
    self.sharePresetButton:setAnchorLeft(true);
    self.sharePresetButton:setAnchorRight(false);
    self.sharePresetButton:setAnchorTop(false);
    self.sharePresetButton:setAnchorBottom(true);
    self.sharePresetButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.sharePresetButton:setFont(UIFont.Small);
    self.sharePresetButton:ignoreWidthChange();
    self.sharePresetButton:ignoreHeightChange();
    self:addChild(self.sharePresetButton);
    self.sharePresetButton:setWidthToTitle()
    self.sharePresetButton:setX(self.delPresetButton:getRight() + UI_BORDER_SPACING)

    self.addPresetButton = ISButton:new(0, 0, 100, BUTTON_HGT, getText("UI_btn_add"), self, self.onPresetButton);
    self.addPresetButton.internal = "ADD";
    self.addPresetButton:initialise();
    self.addPresetButton:instantiate();
    self.addPresetButton:setAnchorLeft(true);
    self.addPresetButton:setAnchorRight(false);
    self.addPresetButton:setAnchorTop(false);
    self.addPresetButton:setAnchorBottom(true);
    self.addPresetButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.addPresetButton:setFont(UIFont.Small);
    self.addPresetButton:ignoreWidthChange();
    self.addPresetButton:ignoreHeightChange();
    self:addChild(self.addPresetButton);
    self.addPresetButton:setWidthToTitle()
    self.addPresetButton:setX(self.sharePresetButton:getRight() + UI_BORDER_SPACING)
end

function ModListPresets:addChild(child)
    ISUIElement.addChild(self, child)
    table.insert(self.childrenLine, child)
end

function ModListPresets:updateView()
    local temp = {}
    for i, option in ipairs(self.presetCombo.options) do
        if option.data == "default" then
            table.insert(temp, option)
        end
    end
    self.presetCombo.options = temp

    for name, data in pairs(self.parent.model.presets) do
        self.presetCombo:addOptionWithData(name, data)
    end
end

function ModListPresets:onPresetButton(button)
    if button.internal == "SAVE" then
        local name = "New"
        if self.presetCombo.options[self.presetCombo.selected] and self.presetCombo.options[self.presetCombo.selected].data ~= "default" then
            name = self.presetCombo.options[self.presetCombo.selected].text or "New"
        end
        local modal = ISTextBox:new((getCore():getScreenWidth() / 2) - 140, (getCore():getScreenHeight() / 2) - 90, 280, 180, getText("UI_mods_SavePrompt"), name, self, self.onSavePreset);
        modal.backgroundColor.a = 0.9
        modal:initialise();
        modal:setAlwaysOnTop(true)
        modal:setCapture(true)
        modal:setValidateFunction(self, self.onValidateSavePreset)
        modal:addToUIManager()
        modal:bringToTop()
        if self.joyfocus then
            modal.prevFocus = self
            self.joyfocus.focus = modal
            updateJoypadFocus(self.joyfocus)
        end
    end
    if button.internal == "DELETE" then
        local name = self.presetCombo.options[self.presetCombo.selected].text
        self.parent.model.presets[name] = nil
        self.parent.model:saveModDataToFile()
        self:updateView()
        self.presetCombo.selected = 1
        self:choosePreset(self.presetCombo)
    end
    if button.internal == "SHARE" then
        if self.presetCombo.options[self.presetCombo.selected] and self.presetCombo.options[self.presetCombo.selected].data ~= "default" then
            local text = self.parent.model:getPresetShareText(self.presetCombo.options[self.presetCombo.selected].text)
            Clipboard.setClipboard(text)
            local modal = ISModalDialog:new(getCore():getScreenWidth()/2 - 280/2, getCore():getScreenHeight() / 2 - 180/2, 280, 180, "Mods preset text copied to clipboard", false)
            modal:initialise()
            modal:addToUIManager()
            if self.joyfocus then
                modal.prevFocus = self
                self.joyfocus.focus = modal
                updateJoypadFocus(self.joyfocus)
            end
        end
    end
    if button.internal == "ADD" then
        local modal = ISTextBox:new(getCore():getScreenWidth()/2 - 280/2, getCore():getScreenHeight() / 2 - 180/2, 280, 180, "Paste here mods preset text:", "", self, self.addSharedPreset)
        modal:initialise()
        modal:addToUIManager()
        if self.joyfocus then
            self.joyfocus.focus = modal
            updateJoypadFocus(self.joyfocus)
        end
    end
end

function ModListPresets:addSharedPreset(button)
    self.model:addSharedPreset(button)
    if button.parent.joyfocus then
        button.parent.joyfocus.focus = self
        updateJoypadFocus(button.parent.joyfocus)
    end
end

function ModListPresets:onValidateSavePreset(text)
    return SandboxOptions.isValidPresetName(text)
end

function ModListPresets:onSavePreset(button)
    local modal = button.parent;
    if button.internal == "OK" then
        local name = button.parent.entry:getText()
        if SandboxOptions.isValidPresetName(name) then
            modal:destroy()
            local data = {}
            local modArray = self.model:getActiveMods():getMods()
            for i = 0, modArray:size()-1 do
                local mId = modArray:get(i)
                data[mId] = self.model.mods[mId].modInfo:getWorkshopID() or ""
            end
            self.parent.model.presets[name] = data
            self.parent.model:saveModDataToFile()
            self:updateView()
            for i, opt in ipairs(self.presetCombo.options) do
                if opt.text == name then
                    self.presetCombo.selected = i
                end
            end
            self:choosePreset(self.presetCombo)
        else
            -- Let player know an invalid character was entered
            modal:showErrorMessage(true, getText("Sandbox_PresetName_Error"))
        end
    elseif button.internal == "CANCEL" then
        modal:destroy()
    end
    if button.parent.joyfocus then
        button.parent.joyfocus.focus = self
        updateJoypadFocus(button.parent.joyfocus)
    end
end

function ModListPresets:choosePreset(combo)
    local data = combo.options[combo.selected].data
    if data == "default" then
        self.delPresetButton:setEnable(false)
        if combo.selected == 2 then
            for _, modData in pairs(self.parent.model.mods) do
                if modData.isActive then
                    self.parent.model:forceActivateMods(modData.modInfo, false)
                end
            end
        elseif combo.selected == 3 then
            for _, modData in pairs(self.parent.model.mods) do
                if not modData.isActive and modData.isAvailable and modData.modId ~= "ModTemplate" then
                    self.parent.model:forceActivateMods(modData.modInfo, true)
                end
            end
        end
        return
    end

    local availableMods = {}
    self.delPresetButton:setEnable(true)
    for modId, modData in pairs(self.parent.model.mods) do
        if data[modId] then
            if not modData.isActive and modData.isAvailable then
                self.parent.model:forceActivateMods(modData.modInfo, true)
            end
            availableMods[modId] = true
        else
            if modData.isActive then
                self.parent.model:forceActivateMods(modData.modInfo, false)
            end
        end
    end

    local modList = {}
    for id, _ in pairs(data) do
        if availableMods[id] then
            table.insert(modList, id)
        end
    end
    self.model:correctAndSaveModOrder(modList)

    local isMissedMods = false
    local data2 = {}
    for k, v in pairs(data) do
        if availableMods[k] == nil then
            isMissedMods = true
            local t = luautils.split(k, "\\")
            data2[k] = t[1]
        end
    end

    if isMissedMods then
        ModSelector.instance:setVisible(false)

        local w = 600
        local h = 600
        self.missedModsPanel = ModSelector.MissedModsWindow:new(getCore():getScreenWidth()/2 - w/2, getCore():getScreenHeight() / 2 - h/2, w, h, data2)
        self.missedModsPanel:initialise();
        self.missedModsPanel:setAnchorRight(true);
        self.missedModsPanel:setAnchorLeft(true);
        self.missedModsPanel:setAnchorBottom(true);
        self.missedModsPanel:setAnchorTop(true);
        self.missedModsPanel:addToUIManager()
        self.missedModsPanel:bringToTop()
    end
end

function ModListPresets:onJoypadDown(button, joypadData)
    local child = self.children[self.joypadIndex]

    if button == Joypad.AButton and child and (child.isButton or child.isCombobox) then
        child:forceClick()
        return
    end
    if button == Joypad.BButton and child and child.isCombobox and child.expanded then
        child.expanded = false
        child:hidePopup()
        return
    end
end


function ModListPresets:onJoypadDirUp(joypadData)
    local child = self.children[self.joypadIndex]
    if child and child.isCombobox and child.expanded then
        child:onJoypadDirUp(joypadData)
        return
    end
    self.childrenLine[self.childrenIndex]:setJoypadFocused(false, joypadData)
    self.joyfocus.focus = self.parent
    self.parent.joypadIndex = self.parent.modListPanel.ID
    updateJoypadFocus(self.joyfocus)
end

function ModListPresets:onJoypadDirDown(joypadData)
    local child = self.children[self.joypadIndex]
    if child and child.isCombobox and child.expanded then
        child:onJoypadDirDown(joypadData)
    end
end

function ModListPresets:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
end

function ModListPresets:onJoypadDirLeft(joypadData)
    if self.childrenIndex > 1 then
        self.childrenLine[self.childrenIndex]:setJoypadFocused(false, joypadData);
        self.childrenIndex = self.childrenIndex - 1
        self.joypadIndex = self.childrenLine[self.childrenIndex].ID
        self.childrenLine[self.childrenIndex]:setJoypadFocused(true, joypadData);
    else
        self.childrenLine[self.childrenIndex]:setJoypadFocused(false, joypadData)
        self.joyfocus.focus = self.parent
        self.parent.joypadIndex = self.parent.backButton.ID
        updateJoypadFocus(self.joyfocus)
    end
end

function ModListPresets:onJoypadDirRight(joypadData)
    if self.childrenIndex < #self.childrenLine then
        self.childrenLine[self.childrenIndex]:setJoypadFocused(false, joypadData);
        self.childrenIndex = self.childrenIndex + 1
        self.joypadIndex = self.childrenLine[self.childrenIndex].ID
        self.childrenLine[self.childrenIndex]:setJoypadFocused(true, joypadData);
    else
        self.childrenLine[self.childrenIndex]:setJoypadFocused(false, joypadData)
        self.joyfocus.focus = self.parent
        self.parent.joypadIndex = self.parent.mapOrderbtn.ID
        updateJoypadFocus(self.joyfocus)
    end
end