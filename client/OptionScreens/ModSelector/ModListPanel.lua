--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModSelector"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local LABEL_HGT = FONT_HGT_MEDIUM + 6
local UI_BORDER_SPACING = 10
local JOYPAD_TEX_SIZE = 32
local BUTTON_PADDING = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2

ModSelector.ModListPanel = ISPanelJoypad:derive("ModListPanel")
local ModListPanel = ModSelector.ModListPanel

function ModListPanel:new(x, y, width, height, model)
    local o = ISPanelJoypad.new(self, x, y, width, height)
    o:noBackground()
    o.model = model
    o.joypadListFocus = true
    return o
end

function ModListPanel:updateView()
    local choosedItemModData = self.modList:getSelectedModData()
    local newChoosedIndex = 1
    local i = 1

    self:applyFilters()
    self.modList:clear()
    for _, modData in pairs(self.model.currentMods) do
        self.modList:addItem("", modData)
        if choosedItemModData == modData then
            newChoosedIndex = i
        end
        i = i + 1
    end
    self.modList.selected = newChoosedIndex
end

function ModListPanel:render()
    ISPanelJoypad.render(self)
    self:drawRectBorder(0, self.favoriteButton:getBottom() + UI_BORDER_SPACING, self.width, self.height - self.favoriteButton:getBottom() - UI_BORDER_SPACING, 0.9, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    if self.joyfocus and self.joypadListFocus then
        self:drawTextureScaled(Joypad.Texture.YButton, self.favoriteButton.x - BUTTON_HGT - UI_BORDER_SPACING, self.favoriteButton.y, JOYPAD_TEX_SIZE, JOYPAD_TEX_SIZE, 1, 1, 1, 1)
    end
end

function ModListPanel:drawCustomRectBorder(x, y, w, h, r, g, b, a)
    if self.javaObject ~= nil then
        self.javaObject:DrawTextureScaledColor(nil, x, y, 2, h, r, g, b, a);
        self.javaObject:DrawTextureScaledColor(nil, x+2, y, w-4, 2, r, g, b, a);
        self.javaObject:DrawTextureScaledColor(nil, x+w-2, y, 2, h, r, g, b, a);
        self.javaObject:DrawTextureScaledColor(nil, x+2, y+h-2, w-4, 2, r, g, b, a);
    end
end

function ModListPanel:prerender()
    ISPanelJoypad.prerender(self)
end

function ModListPanel:createChildren()
    self.filterPanel = ISPanelJoypad:new(0, 0, self:getWidth(), 50)
    self.filterPanel.render = function(_self)
        ISPanelJoypad.render(_self)
        _self:renderJoypadFocus()
    end
    self.filterPanel.onGainJoypadFocus = function(_self, _joypadData)
        ISPanelJoypad.onGainJoypadFocus(_self, _joypadData)
        _self:restoreJoypadFocus(_joypadData)
    end
    self.filterPanel.onLoseJoypadFocus = function(_self, _joypadData)
        ISPanelJoypad.onLoseJoypadFocus(_self, _joypadData)
        _self:clearJoypadFocus(_joypadData)
    end
    self.filterPanel.onJoypadDown = function(_self, _button, _joypadData)
        if _button == Joypad.BButton and not _self:isFocusOnControl() then
            _joypadData.focus = self.parent
            updateJoypadFocus(_joypadData)
            return
        end
        ISPanelJoypad.onJoypadDown(_self, _button, _joypadData)
    end
    self:addChild(self.filterPanel)

    local label = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, LABEL_HGT, getText("UI_modselector_filter"), 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
    self.filterPanel:addChild(label)

    self.filterCombo = ISComboBox:new(label:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING+1, math.min(200, self.width/2.0 - label:getRight()), BUTTON_HGT, self, self.updateView)
    self.filterCombo:initialise()
    for type, iconName in pairs(ModSelector.Model.categories) do
        self.filterCombo:addOption(getText(type))
    end
    self.filterCombo.selected = 1
    self.filterPanel:addChild(self.filterCombo)

    label = ISLabel:new(self.width/2, UI_BORDER_SPACING+1, LABEL_HGT, getText("UI_sandbox_searchEntryBoxWord") .. ":", 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
    self.filterPanel:addChild(label)
    self.searchLabel = label

    self.searchEntry = ISTextEntryBox:new("", label:getRight() + UI_BORDER_SPACING, UI_BORDER_SPACING+1, self.width - UI_BORDER_SPACING*2 - label:getRight() - 1, BUTTON_HGT)
    self.searchEntry.font = UIFont.Small
    self.searchEntry.onTextChange = function() self:updateView() end
    self.searchEntry.setText = ModListPanel.setText
    self.searchEntry:initialise()
    self.searchEntry:instantiate()
    self.filterPanel:addChild(self.searchEntry)

    local tickboxWidth = BUTTON_HGT + UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_modselector_showEnabledMods"))
    self.enabledModsTickbox = ISTickBox:new(UI_BORDER_SPACING+1, self.filterCombo:getBottom() + UI_BORDER_SPACING, tickboxWidth, BUTTON_HGT, "", self, self.updateView);
    self.enabledModsTickbox:initialise();
    self.enabledModsTickbox:instantiate();
    self.enabledModsTickbox:addOption(getText("UI_modselector_showEnabledMods"));
    self.filterPanel:addChild(self.enabledModsTickbox);

    --[[
    tickboxWidth = BUTTON_HGT + UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_modselector_showUnsupportedMods"))
    self.unsupportedModsTickbox = ISTickBox:new(self.enabledModsTickbox:getRight() + UI_BORDER_SPACING, self.enabledModsTickbox.y, tickboxWidth, BUTTON_HGT, "", self, self.applyUnsupportedMods);
    self.unsupportedModsTickbox:initialise();
    self.unsupportedModsTickbox:instantiate();
    self.unsupportedModsTickbox:addOption(getText("UI_modselector_showUnsupportedMods"));
    self:addChild(self.unsupportedModsTickbox);
]]
    local btnWidth = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_savedServers"))
    self.favoriteButton = ISButton:new(self.width - UI_BORDER_SPACING - btnWidth - 1, self.enabledModsTickbox.y, btnWidth, BUTTON_HGT, getText("UI_servers_savedServers"), self, ModListPanel.onOptionMouseDown)
    self.favoriteButton.internal = "Favorite"
    self.favoriteButton:initialise()
    self.favoriteButton:instantiate()
    self.filterPanel:addChild(self.favoriteButton)

    self.filterPanel:setHeight(self.favoriteButton:getBottom() + UI_BORDER_SPACING)

    self.filterPanel.joypadIndexY = 1
    self.filterPanel.joypadIndex = 1
    self.filterPanel:insertNewLineOfButtons(self.filterCombo, self.searchEntry)
    self.filterPanel:insertNewLineOfButtons(self.enabledModsTickbox, self.favoriteButton)

    self.modList = ModSelector.ModListBox:new(0, self.filterPanel:getBottom() + UI_BORDER_SPACING, self.width, self.height - self.filterPanel:getBottom() - UI_BORDER_SPACING, self.model)
    self.modList.drawBorder = true;
    self.modList:initialise();
    self.modList:instantiate();
    self:addChild(self.modList)
end

function ModListPanel:recalcSize()
    ISPanelJoypad.recalcSize(self)
    self.modList:setWidth(self.width)
    self.modList:setHeight(self.height - self.favoriteButton:getBottom() - UI_BORDER_SPACING)
    self.modList:recalcSize()
    self.searchEntry:setX(self.width - self.searchEntry.width - UI_BORDER_SPACING - 1)
    self.searchLabel:setX(self.searchEntry.x - self.searchLabel.width - UI_BORDER_SPACING)
    self.favoriteButton:setX(self.width - self.favoriteButton.width - UI_BORDER_SPACING - 1)
end


function ModListPanel:applyUnsupportedMods()
    if self.unsupportedModsTickbox.selected[1] then
        local unsupportedModModalWidth = UI_BORDER_SPACING*2 + math.max(
                getTextManager():MeasureStringX(UIFont.Small, getText("UI_modselector_usupportText1")),
                getTextManager():MeasureStringX(UIFont.Small, getText("UI_modselector_usupportText2"))
        )

        local modal = ISModalDialog:new((getCore():getScreenWidth()-unsupportedModModalWidth)/2, getCore():getScreenHeight() / 2 - 100/2, unsupportedModModalWidth, 100, getText("UI_modselector_usupportText1") .. getBreakModGameVersion():toString() .. getText("UI_modselector_usupportText2"), false, nil, function()
            ModSelector.instance:setVisible(true)
            ModSelector.instance.backButton:setJoypadFocused(false)
            ModSelector.instance.modListPanel.unsupportedModsTickbox:setJoypadFocused(false)
        end)
        modal:initialise()
        modal:addToUIManager()
        modal:bringToTop()
        ModSelector.instance:setVisible(false)

        if self.joyfocus then
            modal.prevFocus = self
            self.joyfocus.focus = modal
            updateJoypadFocus(self.joyfocus)
        end

        self.model:showUnsupportedMods(true)
    else
        self.model:showUnsupportedMods(false)
    end
end

function ModListPanel:applyFilters()
    local category = self.filterCombo.options[self.filterCombo.selected]
    local searchWord = string.lower(self.searchEntry:getInternalText())
    self.model:filterMods(category, searchWord, self.isFavoriteMode, self.enabledModsTickbox.selected[1])
end

function ModListPanel:onOptionMouseDown(button, x, y)
    if button.internal == "Favorite" then
        self.isFavoriteMode = not self.isFavoriteMode
        if self.isFavoriteMode then
            button.textColor = {r=0.0, g=1.0, b=0.0, a=1.0}
        else
            button.textColor = {r=1.0, g=1.0, b=1.0, a=1.0}
        end
        self:updateView()
    end
end

------------------

function ModListPanel.setText(self, str)
    if not str then
        str = "";
    end
    self.javaObject:SetText(str);
    self.title = str;

    if OnScreenKeyboard.IsVisible() then
        self:onTextChange()
    end
end

function ModListPanel:setJoypadFocused(val)
    self.joypadFocused = val
end
