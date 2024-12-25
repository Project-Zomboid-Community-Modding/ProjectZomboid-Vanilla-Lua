--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"

ModSelector = ISPanelJoypad:derive("ModSelector")

local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local BUTTON_PADDING = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2

function ModSelector:new(x, y, width, height)
    local o = ISPanelJoypad:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.background = true
    o.backgroundColor = {r=0, g=0, b=0, a=0.9}
    o.borderColor = {r=1, g=1, b=1, a=0.2}

    o.model = ModSelector.Model:new(o)
    ModSelector.instance = o
    return o
end

function ModSelector:create()
    local listY = UI_BORDER_SPACING*2 + math.max(FONT_HGT_TITLE, BUTTON_HGT) + 1
    local listHgt = self.height - listY - BUTTON_HGT - UI_BORDER_SPACING*2 - 1
    self.modListPanel = ModSelector.ModListPanel:new(UI_BORDER_SPACING+1, listY, self.width/2-UI_BORDER_SPACING, listHgt, self.model)
    self.modListPanel:initialise()
    self.modListPanel:instantiate()
    self.modListPanel:setAnchorLeft(true)
    self.modListPanel:setAnchorRight(true)
    self.modListPanel:setAnchorTop(true)
    self.modListPanel:setAnchorBottom(true)
    self:addChild(self.modListPanel)

    local left = self.modListPanel:getRight() + UI_BORDER_SPACING
    local top = self.modListPanel:getY()
    self.modInfoPanel = ModInfoPanel:new(left, top, self.width - UI_BORDER_SPACING - left - 1, self.modListPanel.height)
    self.modInfoPanel:setAnchorBottom(true)
    self.modInfoPanel:addScrollBars()
    self.modInfoPanel:setScrollChildren(true)
    self:addChild(self.modInfoPanel)
    self.modInfoPanel:setVisible(false)

    local btnWidth = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
    self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height - BUTTON_HGT - UI_BORDER_SPACING - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, ModSelector.onOptionMouseDown);
    self.backButton.internal = "BACK";
    self.backButton:initialise();
    self.backButton:instantiate();
    self.backButton:setAnchorLeft(true);
    self.backButton:setAnchorRight(false);
    self.backButton:setAnchorTop(false);
    self.backButton:setAnchorBottom(true);
    self.backButton:enableCancelColor()
    self.backButton:setFont(UIFont.Small);
    self.backButton:ignoreWidthChange();
    self.backButton:ignoreHeightChange();
    self:addChild(self.backButton);

    local presetWidth = self.modListPanel:getRight() - self.backButton:getRight() - UI_BORDER_SPACING
    self.presetPanel = ModListPresets:new(self.backButton:getRight() + UI_BORDER_SPACING, self.backButton.y, presetWidth, BUTTON_HGT, self.model)
    self.presetPanel:setAnchorLeft(true);
    self.presetPanel:setAnchorRight(false);
    self.presetPanel:setAnchorTop(false);
    self.presetPanel:setAnchorBottom(true);
    self.presetPanel:ignoreWidthChange();
    self.presetPanel:ignoreHeightChange();
    self:addChild(self.presetPanel)

    btnWidth = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_accept"))
    self.acceptButton = ISButton:new(self.width - UI_BORDER_SPACING - btnWidth - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_accept"), self, ModSelector.onOptionMouseDown);
    self.acceptButton.internal = "ACCEPT";
    self.acceptButton:initialise();
    self.acceptButton:instantiate();
    self.acceptButton:setAnchorLeft(false);
    self.acceptButton:setAnchorRight(true);
    self.acceptButton:setAnchorTop(false);
    self.acceptButton:setAnchorBottom(true);
    self.acceptButton:enableAcceptColor()
    self.acceptButton:setFont(UIFont.Small);
    self.acceptButton:ignoreWidthChange();
    self.acceptButton:ignoreHeightChange();
    self:addChild(self.acceptButton);

    btnWidth = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_mods_ModsOrder"))
    self.modOrderbtn = ISButton:new(self.acceptButton.x - btnWidth - UI_BORDER_SPACING, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_mods_ModsOrder"), self, ModSelector.onOptionMouseDown);
    self.modOrderbtn.internal = "MODSORDER";
    self.modOrderbtn:initialise();
    self.modOrderbtn:instantiate();
    self.modOrderbtn:setAnchorLeft(false);
    self.modOrderbtn:setAnchorRight(true);
    self.modOrderbtn:setAnchorTop(false);
    self.modOrderbtn:setAnchorBottom(true);
    self.modOrderbtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.modOrderbtn:setFont(UIFont.Small);
    self.modOrderbtn:ignoreWidthChange();
    self.modOrderbtn:ignoreHeightChange();
    self:addChild(self.modOrderbtn);

    btnWidth = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_mods_MapsOrder"))
    self.mapOrderbtn = ISButton:new(self.modOrderbtn.x - btnWidth - UI_BORDER_SPACING, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_mods_MapsOrder"), self, ModSelector.onOptionMouseDown);
    self.mapOrderbtn.internal = "MAPSORDER";
    self.mapOrderbtn.textColor = {r=1.0, g=0.4, b=0.05, a=1.0}
    self.mapOrderbtn:initialise();
    self.mapOrderbtn:instantiate();
    self.mapOrderbtn:setAnchorLeft(false);
    self.mapOrderbtn:setAnchorRight(true);
    self.mapOrderbtn:setAnchorTop(false);
    self.mapOrderbtn:setAnchorBottom(true);
    self.mapOrderbtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.mapOrderbtn:setFont(UIFont.Small);
    self.mapOrderbtn:ignoreWidthChange();
    self.mapOrderbtn:ignoreHeightChange();
    self:addChild(self.mapOrderbtn);

    btnWidth = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_help"))
    self.helpButton = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING-1, UI_BORDER_SPACING+1, btnWidth, BUTTON_HGT, getText("UI_btn_help"), self, ModSelector.onOptionMouseDown);
    self.helpButton.internal = "HELP";
    self.helpButton:initialise();
    self.helpButton:instantiate();
    self.helpButton:setAnchorLeft(false);
    self.helpButton:setAnchorRight(true);
    self.helpButton:setAnchorTop(true);
    self.helpButton:setAnchorBottom(false);
    self.helpButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.helpButton:setFont(UIFont.Small);
    self.helpButton:ignoreWidthChange();
    self.helpButton:ignoreHeightChange();
    self:addChild(self.helpButton);
end

function ModSelector:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    ISPanelJoypad.prerender(self)
    self:drawTextCentre(getText("UI_mods_SelectMods"), self.width / 2, 10, 1, 1, 1, 1, UIFont.Title)
end

function ModSelector:onResolutionChange()
    self.modListPanel:setWidth(self.width/2 - UI_BORDER_SPACING)
    self.modListPanel:recalcSize()

    local x = (self.modListPanel:getRight() + UI_BORDER_SPACING)
    self.modInfoPanel:setWidth(self.width - UI_BORDER_SPACING - x)
    self.modInfoPanel:recalcSize()
    self.modInfoPanel:setX(x)
end

function ModSelector:onOptionMouseDown(button, x, y)
    if button.internal == "ACCEPT" then
        self:onAccept()
    elseif button.internal == "BACK" then
        for _, modData in pairs(self.model.mods) do
            if modData.isActive ~= modData.defaultActive then
                self:setVisible(false)
                local w = 300
                local h = 100
                local modal = ISModalDialog:new(getCore():getScreenWidth()/2 - w/2, getCore():getScreenHeight() / 2 - h/2, w, h, getText("UI_mods_backAccept"), true, self, self.acceptChanges)
                modal:initialise()
                modal:addToUIManager()
                modal:bringToTop()
                if self.joyfocus then
                    self.joyfocus.focus = modal
                    updateJoypadFocus(self.joyfocus)
                end
                return
            end
        end
        self:onAccept()
    elseif button.internal == "HELP" then
        ModSelector.instance:setVisible(false)

        local width = 650
        local height = 650
        local nagPanel = ISModsHelpPanel:new(
                (getCore():getScreenWidth() - width)/2,
                (getCore():getScreenHeight() - height)/2,
                width, height)
        nagPanel:initialise()
        nagPanel:addToUIManager()
        nagPanel:setAlwaysOnTop(true)
        if self.joyfocus then
            self.joyfocus.focus = nagPanel
            updateJoypadFocus(self.joyfocus)
        end
    elseif button.internal == "MODSORDER" then
        ModSelector.instance:setVisible(false)

        local width = self.width*0.4
        local height = self.height*0.9
        local modLoadOrderPanel = ModSelector.ModLoadOrderPanel:new(
                (getCore():getScreenWidth() - width)/2,
                (getCore():getScreenHeight() - height)/2,
                width, height, self.model)
        modLoadOrderPanel:initialise()
        modLoadOrderPanel:instantiate()
        modLoadOrderPanel:addToUIManager()
        modLoadOrderPanel:setAlwaysOnTop(true)
        if self.joyfocus then
            self.joyfocus.focus = modLoadOrderPanel
            updateJoypadFocus(self.joyfocus)
        end
    elseif button.internal == "MAPSORDER" then
        ModSelector.instance:setVisible(false)

        local width = self.width*0.4
        local height = self.height*0.9
        local mapOrderPanel = ModSelector.MapOrderUI:new(
                (getCore():getScreenWidth() - width)/2,
                (getCore():getScreenHeight() - height)/2,
                width, height, self.model)
        mapOrderPanel:initialise()
        mapOrderPanel:instantiate()
        mapOrderPanel:addToUIManager()
        mapOrderPanel:setAlwaysOnTop(true)
        if self.joyfocus then
            self.joyfocus.focus = mapOrderPanel
            updateJoypadFocus(self.joyfocus)
        end
    end
end

function ModSelector:acceptChanges(button)
    if button.internal == "YES" then
        self:onAccept()
    else
        -- Revert changes
        for id, modData in pairs(self.model.mods) do
            if modData.isActive ~= modData.defaultActive then
                self.model:forceActivateMods(modData.modInfo, modData.defaultActive)
            end
            if self.model.favs[id] ~= modData.defaultFav then
                self.model.favs[id] = modData.defaultFav
            end
        end
        self:onAccept()
    end
end

function ModSelector:onAccept()
    self.model:acceptChanges()

    self:setVisible(false)
    if self.joyfocus then
        if self.joypadIndex ~= 0 then
            self.children[self.joypadIndex]:setJoypadFocused(false, self.joyfocus)
        end
        self.joyfocus.focus = self.returnToUI
        updateJoypadFocus(self.joyfocus)
    end
end

function ModSelector:updateView()
    self.modListPanel:updateView()
    self.presetPanel:updateView()

    self.mapOrderbtn.enable = self.model:checkMapConflicts()
end

function ModSelector:setExistingSavefile(folder)
    self.model:setExistingSavefile(folder)
end

function ModSelector:setServerSettingsMods(data, finishFunc)
    self.model:setServerSettingsMods(data, finishFunc)
end

function ModSelector:reloadMods()
    self.model:reloadMods()
end

function ModSelector:setNewGame()
    self.model.isNewGame = true
end

---------------------------

function ModSelector:onGainJoypadFocus(joypadData)
    if self.joypadIndex == 0 then
        self.joypadIndex = self.modListPanel.ID
    end
    self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
end

function ModSelector:onJoypadDown(button, joypadData)
    local child = self.children[self.joypadIndex]

    if button == Joypad.AButton and child and (child.isButton or child.isTickBox) then
        child:forceClick()
        return
    end
    if button == Joypad.AButton and child == self.modInfoPanel then
        joypadData.focus = self.modInfoPanel
        updateJoypadFocus(joypadData)
        return
    end
    if button == Joypad.AButton and child == self.modListPanel then
        joypadData.focus = self.modListPanel
        updateJoypadFocus(joypadData)
        if #self.modListPanel.modList.items ~= 0 then
            self.modInfoPanel:updateView(self.modListPanel.modList.items[1].item.modInfo)
        end
        return
    end
    if button == Joypad.BButton then
    end
end

function ModSelector:onJoypadDirUp(joypadData)
    self.children[self.joypadIndex]:setJoypadFocused(false, joypadData)
    if self.joypadIndex == self.mapOrderbtn.ID or self.joypadIndex == self.modOrderbtn.ID or self.joypadIndex == self.acceptButton.ID then
        if self.modInfoPanel:getIsVisible() then
            self.joypadIndex = self.modInfoPanel.ID
        else
            self.joypadIndex = self.modListPanel.ID
        end
    elseif self.joypadIndex == self.modInfoPanel.ID then
        self.joypadIndex = self.helpButton.ID
    elseif self.joypadIndex == self.backButton.ID or self.joypadIndex == self.presetPanel.ID then
        self.joypadIndex = self.modListPanel.ID
    elseif self.joypadIndex == self.modListPanel.ID then
        self.joypadIndex = self.helpButton.ID
    end
    self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
end

function ModSelector:onJoypadDirDown(joypadData)
    self.children[self.joypadIndex]:setJoypadFocused(false, joypadData)
    if self.joypadIndex == self.helpButton.ID then
        if self.modInfoPanel:getIsVisible() then
            self.joypadIndex = self.modInfoPanel.ID
        else
            self.joypadIndex = self.modListPanel.ID
        end
    elseif self.joypadIndex == self.modInfoPanel.ID then
        self.joypadIndex = self.acceptButton.ID
    elseif self.joypadIndex == self.modListPanel.ID then
        self.joypadIndex = self.backButton.ID
    end
    self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
end


function ModSelector:onJoypadDirLeft(joypadData)
    self.children[self.joypadIndex]:setJoypadFocused(false, joypadData)
    if self.joypadIndex == self.mapOrderbtn.ID then
        joypadData.focus = self.presetPanel
        self.presetPanel.joypadIndex = self.presetPanel.childrenLine[#self.presetPanel.childrenLine].ID
        self.presetPanel.childrenIndex = #self.presetPanel.childrenLine
        updateJoypadFocus(joypadData)
    elseif self.joypadIndex == self.acceptButton.ID then
        self.joypadIndex = self.modOrderbtn.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    elseif self.joypadIndex == self.modOrderbtn.ID then
        self.joypadIndex = self.mapOrderbtn.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    elseif self.joypadIndex == self.backButton.ID then
        self.joypadIndex = self.acceptButton.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    elseif self.joypadIndex == self.modInfoPanel.ID then
        self.joypadIndex = self.modListPanel.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

function ModSelector:onJoypadDirRight(joypadData)
    self.children[self.joypadIndex]:setJoypadFocused(false, joypadData)
    if self.joypadIndex == self.backButton.ID then
        joypadData.focus = self.presetPanel
        self.presetPanel.joypadIndex = self.presetPanel.childrenLine[1].ID
        self.presetPanel.childrenIndex = 1
        updateJoypadFocus(joypadData)
    elseif self.joypadIndex == self.mapOrderbtn.ID then
        self.joypadIndex = self.modOrderbtn.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    elseif self.joypadIndex == self.modOrderbtn.ID then
        self.joypadIndex = self.acceptButton.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    elseif self.joypadIndex == self.acceptButton.ID then
        self.joypadIndex = self.backButton.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    elseif (self.joypadIndex == self.modListPanel.ID) and self.modInfoPanel:getIsVisible() then
        self.joypadIndex = self.modInfoPanel.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

---------------------------

function ModSelector.showNagPanel()
    if getCore():isModsPopupDone() or getDebug() and getDebugOptions():getBoolean("UI.DisableWelcomeMessage") then
        return
    end
    getCore():setModsPopupDone(true)

    ModSelector.instance:setVisible(false)

    local width = 650
    local height = 400
    local nagPanel = ISModsNagPanel:new(
            (getCore():getScreenWidth() - width)/2,
            (getCore():getScreenHeight() - height)/2,
            width, height)
    nagPanel:initialise()
    nagPanel:addToUIManager()
    nagPanel:setAlwaysOnTop(true)
    local joypadData = JoypadState.getMainMenuJoypad()
    if joypadData then
        joypadData.focus = nagPanel
        updateJoypadFocus(joypadData)
    end
end

function ModSelector_onModsModified()
    if ModSelector.instance and ModSelector.instance:isReallyVisible() then
        ModSelector.instance:reloadMods()
    end
end
Events.OnModsModified.Add(ModSelector_onModsModified)