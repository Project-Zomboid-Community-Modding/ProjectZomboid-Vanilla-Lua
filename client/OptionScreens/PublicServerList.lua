--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 23/01/14
-- Time: 12:49
-- To change this template use File | Settings | File Templates.
--

PublicServerList = ISPanelJoypad:derive("PublicServerList");
PublicServerList.pingedList = {};
PublicServerList.refreshTime = 0;
PublicServerList.refreshInterval = getSteamModeActive() and 5 or 60;

local hasShownLargeServerWarning = false;
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local SCROLLBAR_SPACING = 10 + UI_BORDER_SPACING

function PublicServerList:onSortingChanged()
	PublicServerList.instance:sortList()
end

function PublicServerList:onCheckLargeServerOption()
    if PublicServerList.instance.largeServer.selected[1] and (not hasShownLargeServerWarning) then
        local modal = ISModalRichText:new(getCore():getScreenWidth()/2-350,getCore():getScreenHeight()/2-300,700,600, getText("UI_servers_showLargeServer_warning"), false)
        modal:initialise()
        modal:addToUIManager()
        hasShownLargeServerWarning = true;
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            modal.prevFocus = self
            joypadData.focus = modal
        end
    end
    self:onFilterChanged()
end

function PublicServerList:create()
    if not isPublicServerListAllowed() then return; end
    if getSteamModeActive() and not isClient() then
        steamRequestInternetServersList()
        PublicServerList.refreshTime = getTimestamp()
    end

    local connectLabelHgt = 4 * 2 + getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight()
    local filterEtcHgt = BUTTON_HGT

    local fontScale = FONT_HGT_SMALL / 15
    local entrySize = 200 * fontScale;
    local entryX = self.width - entrySize - UI_BORDER_SPACING;

    local listX = UI_BORDER_SPACING+1
    local listWid = self.width - UI_BORDER_SPACING*2 - entrySize - listX
    local tabHeight = BUTTON_HGT
    local listTop = listX + tabHeight

    self.tabs = ISTabPanel:new(listX, listTop - tabHeight, listWid, tabHeight+1);
    self.tabs:initialise();
    self.tabs:setAnchorBottom(false);
    self.tabs:setAnchorRight(true);
    --	self.tabs.borderColor = { r = 0, g = 0, b = 0, a = 0};
    self.tabs.onMouseDown = self.onMouseDown_Tabs;
    self.tabs.onMouseUp = function(x,y) end
--    self.tabs.target = self;
    self.tabs:setEqualTabWidth(false)
    self.tabs.tabPadX = 40
    self.tabs:setCenterTabs(true)
    self.tabs.tabHeight = tabHeight
    self:addChild(self.tabs);

    self.tabs:addView(getText("UI_servers_serverlist"), ISUIElement:new(0,0,100,100))
    self.tabs:addView(getText("UI_servers_publicServer"), ISUIElement:new(0,0,100,100))
    self.tabs:activateView(getText("UI_servers_publicServer"))

    self.listbox = ISScrollingListBox:new(listX, listTop, listWid, self.height-BUTTON_HGT-connectLabelHgt-filterEtcHgt-UI_BORDER_SPACING*4-listTop);
    self.listbox:initialise();
    self.listbox:instantiate();
    self.listbox:setAnchorLeft(true);
    self.listbox:setAnchorRight(true);
    self.listbox:setAnchorTop(true);
    self.listbox:setAnchorBottom(true);
    self.listbox.vscroll:setAnchorBottom(false)
    self.listbox.itemheight = 110;
    self.listbox.doDrawItem = PublicServerList.drawMap;
    self.listbox:setOnMouseDoubleClick(self, PublicServerList.addServer);
    self.listbox:setOnMouseDownFunction(self, PublicServerList.onClickServer);
    self.listbox.onJoypadDown = PublicServerList.onJoypadDown_ListBox
    self.listbox.onJoypadDirRight = PublicServerList.onJoypadDirRight_ListBox
    self.listbox.drawBorder = true
    self.listbox.lockTexture = getTexture("media/ui/inventoryPanes/Button_Lock.png")

    self:addChild(self.listbox);
    self.filteredCount = 0;
    self.recountFilteredPending = false;
    self.recountFiltered = false;

    self.listTabs = ISTabPanelPaginated:new(listX, listX+self.listbox.height, listWid, tabHeight+1, #self.listbox.items);
    self.listTabs:initialise();
    self.listTabs:setAnchorBottom(false);
    self.listTabs:setAnchorRight(true);
    self.listTabs.mouseDownHook = self.onMouseDown_ListTabs
    self.listTabs.onMouseUp = function(x,y) end
    self.listTabs:setEqualTabWidth(false)
    self.listTabs.tabPadX = 40
    self.listTabs:setCenterTabs(true)
    self.listTabs.tabHeight = tabHeight
    self:addChild(self.listTabs);

    self.skipCount = 0
    self.listCount = 10
    self.pageChanged = true

    local y = listTop;
    local labelHgt = getTextManager():getFontFromEnum(UIFont.Medium):getLineHeight()
    local gapLabelY = 2

    self.scrollPanel = ISPanelJoypad:new(entryX, y, entrySize, self.listbox.height)
    self.scrollPanel:initialise()
    self.scrollPanel:instantiate()
    self.scrollPanel:setAnchorLeft(false);
    self.scrollPanel:setAnchorRight(true);
    self.scrollPanel:setAnchorTop(true);
    self.scrollPanel:setAnchorBottom(true);
    self.scrollPanel:setScrollChildren(true)
    self.scrollPanel:noBackground()
    self.scrollPanel:addScrollBars()
    self.scrollPanel.vscroll.doRepaintStencil = true
    self.scrollPanel.onGainJoypadFocus = PublicServerList.onGainJoypadFocus_RightPanel
    self.scrollPanel.onLoseJoypadFocus = PublicServerList.onLoseJoypadFocus_RightPanel
    self.scrollPanel.onJoypadDown = PublicServerList.onJoypadDown_RightPanel
    self.scrollPanel.onJoypadDirLeft = PublicServerList.onJoypadDirLeft_RightPanel
    self:addChild(self.scrollPanel)
    self.scrollPanel.prerender = function(self)
        self:setStencilRect(0, 0, self:getWidth(), self:getHeight())
        ISPanelJoypad.prerender(self)
    end
    self.scrollPanel.render = function(self)
        ISPanelJoypad.render(self)
        self:clearStencilRect()
        if self.joyfocus then
            self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
            self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
        end
    end
    self.scrollPanel.onMouseWheel = function(self, del)
        if self:getScrollHeight() > 0 then
            self:setYScroll(self:getYScroll() - (del * 40))
            return true
        end
        return false
    end

    entryX = 0
    y = 0

    self.serverNameLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_servername") .. ": ", 1, 1, 1, 1, UIFont.Medium, true);
    self.serverNameLabel:initialise();
    self.serverNameLabel:instantiate();
    self.serverNameLabel:setAnchorLeft(false);
    self.serverNameLabel:setAnchorRight(true);
    self.serverNameLabel:setAnchorTop(true);
    self.serverNameLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.serverNameLabel);

    y = y + labelHgt + gapLabelY;

    self.serverNameEntry = ISTextEntryBox:new("", entryX, y, entrySize, BUTTON_HGT);
    self.serverNameEntry:initialise();
    self.serverNameEntry:instantiate();
    self.serverNameEntry:setAnchorLeft(false);
    self.serverNameEntry:setAnchorRight(true);
    self.serverNameEntry:setAnchorTop(true);
    self.serverNameEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.serverNameEntry);

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    self.serverLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_IP"), 1, 1, 1, 1, UIFont.Medium, true);
    self.serverLabel:initialise();
    self.serverLabel:instantiate();
    self.serverLabel:setAnchorLeft(false);
    self.serverLabel:setAnchorRight(true);
    self.serverLabel:setAnchorTop(true);
    self.serverLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.serverLabel);

    y = y + labelHgt + gapLabelY;

    self.serverEntry = ISTextEntryBox:new("127.0.0.1", entryX, y, entrySize, BUTTON_HGT);
    self.serverEntry:initialise();
    self.serverEntry:instantiate();
    self.serverEntry:setAnchorLeft(false);
    self.serverEntry:setAnchorRight(true);
    self.serverEntry:setAnchorTop(true);
    self.serverEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.serverEntry);

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    self.portLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_Port"), 1, 1, 1, 1, UIFont.Medium, true);
    self.portLabel:initialise();
    self.portLabel:instantiate();
    self.portLabel:setAnchorLeft(false);
    self.portLabel:setAnchorRight(true);
    self.portLabel:setAnchorTop(true);
    self.portLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.portLabel);

    y = y + labelHgt + gapLabelY;

    self.portEntry = ISTextEntryBox:new("16261", entryX, y, entrySize, BUTTON_HGT);
    self.portEntry:initialise();
    self.portEntry:instantiate();
    self.portEntry:setAnchorLeft(false);
    self.portEntry:setAnchorRight(true);
    self.portEntry:setAnchorTop(true);
    self.portEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.portEntry);

    y = y + BUTTON_HGT + UI_BORDER_SPACING;
        
    local label = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_serverpwd"), 1, 1, 1, 1, UIFont.Medium, true);
    label:initialise();
    label:instantiate();
    label:setAnchorLeft(false);
    label:setAnchorRight(true);
    label:setAnchorTop(true);
    label:setAnchorBottom(false);
    self.scrollPanel:addChild(label);

    y = y + labelHgt + gapLabelY;

    local entry = ISTextEntryBox:new("", entryX, y, entrySize, BUTTON_HGT);
    entry:initialise();
    entry:instantiate();
    entry:setAnchorLeft(false);
    entry:setAnchorRight(true);
    entry:setAnchorTop(true);
    entry:setAnchorBottom(false);
    entry:setMasked(true);
    entry:setTooltip(getText("UI_servers_serverpwd_tt"))
    self.scrollPanel:addChild(entry);
    self.serverPasswordEntry = entry

	self.passwordWasFocused = false;
	self.firstAddServer = true;
	self.passwordText = "";

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

--[[
    -- Steam ID label/field

    self.steamIdLabel = ISLabel:new(entryX, y, labelHgt, "Steam ID", 1, 1, 1, 1, UIFont.Medium, true);
    self.steamIdLabel:initialise();
    self.steamIdLabel:instantiate();
    self.steamIdLabel:setAnchorLeft(false);
    self.steamIdLabel:setAnchorRight(true);
    self.steamIdLabel:setAnchorTop(true);
    self.steamIdLabel:setAnchorBottom(false);
    self.steamIdLabel:setVisible(false);
    self:addChild(self.steamIdLabel);

    y = y + labelHgt + gapLabelY;

    self.steamIdEntry = ISTextEntryBox:new("", entryX, y, entrySize, BUTTON_HGT);
    self.steamIdEntry:initialise();
    self.steamIdEntry:instantiate();
    self.steamIdEntry:setAnchorLeft(false);
    self.steamIdEntry:setAnchorRight(true);
    self.steamIdEntry:setAnchorTop(true);
    self.steamIdEntry:setAnchorBottom(false);
    self.steamIdEntry:setVisible(false);
    self:addChild(self.steamIdEntry);

    y = y + BUTTON_HGT + UI_BORDER_SPACING;
--]]
    self.filtersPopup = ISPanel:new(self.width / 2 - 100, self.height / 2-200, 300, 350);
    self.filtersPopup.internal = "googleAuthPopup";
    self.filtersPopup:initialise();
    self.filtersPopup:instantiate();
    self.filtersPopup.choicesColor = {r=1, g=1, b=1, a=1}
    self.filtersPopup:setAnchorLeft(false);
    self.filtersPopup:setAnchorRight(true);
    self.filtersPopup:setAnchorTop(true);
    self.filtersPopup:setAnchorBottom(false);
    self.filtersPopup.alwaysOnTop = true;
    self.filtersPopup:setVisible(false);
    self:addChild(self.filtersPopup);

    self.filtersPopup.prerender = function(self)
        if self.background then
            self:drawRectStatic(0, 0, self.width, self.height, 1, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
            self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        end
    end

    self.filtersPopupLabel = ISLabel:new(self.filtersPopup:getWidth() / 2, BUTTON_HGT, labelHgt, getText("UI_servers_filters_Label"), 1, 1, 1, 1, UIFont.Medium, true);
    self.filtersPopupLabel:initialise();
    self.filtersPopupLabel:instantiate();
    self.filtersPopupLabel:setAnchorLeft(true);
    self.filtersPopupLabel:setAnchorRight(false);
    self.filtersPopupLabel:setAnchorTop(true);
    self.filtersPopupLabel:setAnchorBottom(false);
    self.filtersPopup:addChild(self.filtersPopupLabel);

    self.closeFiltersPopupButton = ISButton:new(10, self.filtersPopup:getHeight()-BUTTON_HGT*2, 100, BUTTON_HGT, getText("UI_servers_close_filters"), self, self.onCloseFiltersButton);
    self.closeFiltersPopupButton.internal = "QR";
    self.closeFiltersPopupButton:initialise();
    self.closeFiltersPopupButton:instantiate();
    self.closeFiltersPopupButton:setAnchorLeft(true);
    self.closeFiltersPopupButton:setAnchorRight(false);
    self.closeFiltersPopupButton:setAnchorTop(true);
    self.closeFiltersPopupButton:setAnchorBottom(false);
    self.filtersPopup:addChild(self.closeFiltersPopupButton);

    self.googleAuthPopup = ISPanel:new(self.width / 2 - 100, self.height / 2-200, 300, 350);
    self.googleAuthPopup.internal = "googleAuthPopup";
    self.googleAuthPopup:initialise();
    self.googleAuthPopup:instantiate();
    self.googleAuthPopup.choicesColor = {r=1, g=1, b=1, a=1}
    self.googleAuthPopup:setAnchorLeft(false);
    self.googleAuthPopup:setAnchorRight(true);
    self.googleAuthPopup:setAnchorTop(true);
    self.googleAuthPopup:setAnchorBottom(false);
    self.googleAuthPopup.alwaysOnTop = true;
    self.googleAuthPopup:setVisible(true);
    self:addChild(self.googleAuthPopup);

    self.googleAuthLabel = ISLabel:new(self.googleAuthPopup:getWidth() / 2, BUTTON_HGT, labelHgt, getText("UI_servers_send_QR_Label"), 1, 1, 1, 1, UIFont.Medium, true);
    self.googleAuthLabel:initialise();
    self.googleAuthLabel:instantiate();
    self.googleAuthLabel:setAnchorLeft(false);
    self.googleAuthLabel:setAnchorRight(true);
    self.googleAuthLabel:setAnchorTop(true);
    self.googleAuthLabel:setAnchorBottom(false);
    self.googleAuthLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthLabel:getWidth()/2);
    self.googleAuthPopup:addChild(self.googleAuthLabel);

    self.googleAuthConnectLabel = ISRichTextPanel:new(self.googleAuthPopup:getWidth() / 2, BUTTON_HGT*3, self.googleAuthPopup:getWidth() * 4 / 5, labelHgt);
    self.googleAuthConnectLabel:initialise();
    self.googleAuthConnectLabel:instantiate();
    self.googleAuthConnectLabel:noBackground()
    self.googleAuthConnectLabel:setMargins(0, 0, 0, 0)
    self.googleAuthConnectLabel.font = UIFont.Medium
    self.googleAuthConnectLabel.text = ""
    self.googleAuthConnectLabel.text = " <CENTRE> " .. self.googleAuthConnectLabel.text
    self.googleAuthConnectLabel:paginate()
    self.googleAuthConnectLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthConnectLabel.width/2);
    self.googleAuthPopup.qrY = self.googleAuthConnectLabel:getBottom()+25;
    self.googleAuthPopup:addChild(self.googleAuthConnectLabel);

    self.googleAuthButton = ISButton:new(10, self.googleAuthPopup:getHeight()-BUTTON_HGT*2, 100, BUTTON_HGT, getText("UI_servers_send_QR"), self, self.onSendButton);
    self.googleAuthButton.internal = "QR";
    self.googleAuthButton:initialise();
    self.googleAuthButton:instantiate();
    self.googleAuthButton:setAnchorLeft(false);
    self.googleAuthButton:setAnchorRight(true);
    self.googleAuthButton:setAnchorTop(false);
    self.googleAuthButton:setAnchorBottom(true);
    self.googleAuthButton:setX(self.googleAuthPopup:getWidth() - self.googleAuthButton:getWidth()-10);
    self.googleAuthPopup:addChild(self.googleAuthButton);

    self.closeAuthPopupButton = ISButton:new(10, self.googleAuthPopup:getHeight()-BUTTON_HGT*2, 100, BUTTON_HGT, getText("UI_servers_close_QR_popup"), self, self.onCloseQRButton);
    self.closeAuthPopupButton.internal = "QR";
    self.closeAuthPopupButton:initialise();
    self.closeAuthPopupButton:instantiate();
    self.closeAuthPopupButton:setAnchorLeft(false);
    self.closeAuthPopupButton:setAnchorRight(true);
    self.closeAuthPopupButton:setAnchorTop(false);
    self.closeAuthPopupButton:setAnchorBottom(true);
    --self.closeAuthPopupButton:setX(self.googleAuthPopup:getWidth() - self.closeAuthPopupButton:getWidth()-10);
    self.googleAuthPopup:addChild(self.closeAuthPopupButton);

    self.googleAuthPopup.qrTexture = nil;

    self.googleKey = ""

    self.googleAuthPopup.render = function(self)
        ISPanel.render(self)
        self:clearStencilRect()
        if self.qrTexture then
            self:drawTexture(self.qrTexture, self.width / 2 - self.qrTexture:getWidth()/2, self.qrY, 1, 1, 1, 1)
        end
    end

    self.googleAuthPopup:setVisible(false);

    self.descLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_desc") .. ": ", 1, 1, 1, 1, UIFont.Medium, true);
    self.descLabel:initialise();
    self.descLabel:instantiate();
    self.descLabel:setAnchorLeft(false);
    self.descLabel:setAnchorRight(true);
    self.descLabel:setAnchorTop(true);
    self.descLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.descLabel);

    y = y + labelHgt + gapLabelY;

    self.descEntry = ISTextEntryBox:new("", entryX, y, entrySize, BUTTON_HGT);
    self.descEntry:initialise();
    self.descEntry:instantiate();
    self.descEntry:setAnchorLeft(false);
    self.descEntry:setAnchorRight(true);
    self.descEntry:setAnchorTop(true);
    self.descEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.descEntry);
    self.descEntry:setMultipleLine(true)
    self.descEntry:setMaxLines(20)

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    --    self.usernameLabel = ISLabel:new(entryX, y, 50, getText("UI_servers_username") .. ": ", 1, 1, 1, 1, UIFont.Medium, true);
    self.usernameLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_username"), 1, 1, 1, 1, UIFont.Medium, true);
    self.usernameLabel:initialise();
    self.usernameLabel:instantiate();
    self.usernameLabel:setAnchorLeft(false);
    self.usernameLabel:setAnchorRight(true);
    self.usernameLabel:setAnchorTop(true);
    self.usernameLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.usernameLabel);

    y = y + labelHgt + gapLabelY;

    self.usernameEntry = ISTextEntryBox:new("", entryX, y, entrySize, BUTTON_HGT);
    self.usernameEntry:initialise();
    self.usernameEntry:instantiate();
    self.usernameEntry:setAnchorLeft(false);
    self.usernameEntry:setAnchorRight(true);
    self.usernameEntry:setAnchorTop(true);
    self.usernameEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.usernameEntry);

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    self.authTypeLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_auth_type"), 1, 1, 1, 1, UIFont.Medium, true);
    self.authTypeLabel:initialise();
    self.authTypeLabel:instantiate();
    self.authTypeLabel:setAnchorLeft(false);
    self.authTypeLabel:setAnchorRight(true);
    self.authTypeLabel:setAnchorTop(true);
    self.authTypeLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.authTypeLabel);

    y = y + labelHgt + gapLabelY;

    self.authType = ISComboBox:new(entryX, y, entrySize, BUTTON_HGT);
    self.authType.internal = "AUTHTYPE";
    self.authType:initialise();
    self.authType:instantiate();
    self.authType.choicesColor = {r=1, g=1, b=1, a=1}
    self.authType:setAnchorLeft(false);
    self.authType:setAnchorRight(true);
    self.authType:setAnchorTop(true);
    self.authType:setAnchorBottom(false);
    self.authType:addOption(getText("UI_servers_auth_password"))
    self.authType:addOption(getText("UI_servers_auth_google"))
    self.authType:addOption(getText("UI_servers_auth_two_factor"))
    self.scrollPanel:addChild(self.authType);
    self.scrollPanel:insertNewLineOfButtons(self.authType);


    y = y + BUTTON_HGT + UI_BORDER_SPACING

    --    self.passwordLabel = ISLabel:new(entryX, y, 50, getText("UI_servers_pwd") .. ": ", 1, 1, 1, 1, UIFont.Medium, true);
    self.passwordLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_pwd"), 1, 1, 1, 1, UIFont.Medium, true);
    self.passwordLabel:initialise();
    self.passwordLabel:instantiate();
    self.passwordLabel:setAnchorLeft(false);
    self.passwordLabel:setAnchorRight(true);
    self.passwordLabel:setAnchorTop(true);
    self.passwordLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.passwordLabel);

    y = y + labelHgt + gapLabelY;

    self.passwordEntry = ISTextEntryBox:new("", entryX, y, entrySize, BUTTON_HGT);
    self.passwordEntry:initialise();
    self.passwordEntry:instantiate();
    self.passwordEntry:setAnchorLeft(false);
    self.passwordEntry:setAnchorRight(true);
    self.passwordEntry:setAnchorTop(true);
    self.passwordEntry:setAnchorBottom(false);
    self.passwordEntry:setMasked(true);
    self.passwordEntry:setTooltip(getText("UI_servers_pwd_tt"))
    self.scrollPanel:addChild(self.passwordEntry);

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    self.rememberPasswordTickBox = ISTickBox:new(entryX, y, entrySize, BUTTON_HGT,"");
    self.rememberPasswordTickBox.internal = "REMEMBER";
    self.rememberPasswordTickBox:initialise();
    self.rememberPasswordTickBox:instantiate();
    self.rememberPasswordTickBox.choicesColor = {r=1, g=1, b=1, a=1}
    self.rememberPasswordTickBox:setAnchorLeft(false);
    self.rememberPasswordTickBox:setAnchorRight(true);
    self.rememberPasswordTickBox:setAnchorTop(true);
    self.rememberPasswordTickBox:setAnchorBottom(false);
    self.rememberPasswordTickBox:addOption(getText("UI_servers_remember_password"))
    self.scrollPanel:addChild(self.rememberPasswordTickBox);
    self.scrollPanel:insertNewLineOfButtons(self.rememberPasswordTickBox);

    y = y + BUTTON_HGT + UI_BORDER_SPACING;
    
    if getSteamModeActive() then
        self.connectTypeLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_connectionOptions"), 1, 1, 1, 1, UIFont.Medium, true);
        self.connectTypeLabel:initialise();
        self.connectTypeLabel:instantiate();
        self.connectTypeLabel:setAnchorLeft(false);
        self.connectTypeLabel:setAnchorRight(true);
        self.connectTypeLabel:setAnchorTop(true);
        self.connectTypeLabel:setAnchorBottom(false);
        self.scrollPanel:addChild(self.connectTypeLabel);

        y = y + labelHgt + gapLabelY;

        self.connectTypeEntry = ISTickBox:new(entryX, y, entrySize, BUTTON_HGT, "", nil, nil);
        self.connectTypeEntry:addOption(getText("UI_servers_useSteamRelay"))
        self.connectTypeEntry:initialise();
        self.connectTypeEntry:instantiate();
        self.connectTypeEntry:setAnchorLeft(false);
        self.connectTypeEntry:setAnchorRight(true);
        self.connectTypeEntry:setAnchorTop(true);
        self.connectTypeEntry:setAnchorBottom(false);
        self.scrollPanel:addChild(self.connectTypeEntry);

        y = y + BUTTON_HGT + UI_BORDER_SPACING;
    end
    y = y + UI_BORDER_SPACING

    local saveEraseBtnWidth = UI_BORDER_SPACING*2 + math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_erase")),
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_save"))
    )

    self.eraseBtn = ISButton:new(entryX, y, saveEraseBtnWidth, BUTTON_HGT, getText("UI_servers_erase"), self, PublicServerList.onOptionMouseDown);
    self.eraseBtn.internal = "ERASE";
    self.eraseBtn:initialise();
    self.eraseBtn:instantiate();
    self.eraseBtn:setAnchorLeft(false);
    self.eraseBtn:setAnchorRight(true);
    self.eraseBtn:setAnchorTop(false);
    self.eraseBtn:setAnchorBottom(false);
    self.scrollPanel:addChild(self.eraseBtn);

    self.addBtn = ISButton:new(self.scrollPanel.width - saveEraseBtnWidth, y, saveEraseBtnWidth, BUTTON_HGT, getText("UI_servers_save"), self, PublicServerList.onOptionMouseDown);
    self.addBtn.internal = "ADD";
    self.addBtn:initialise();
    self.addBtn:instantiate();
    self.addBtn:setAnchorLeft(false);
    self.addBtn:setAnchorRight(true);
    self.addBtn:setAnchorTop(false);
    self.addBtn:setAnchorBottom(false);
    self.scrollPanel:addChild(self.addBtn);

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    y = y + UI_BORDER_SPACING
    y = y + UI_BORDER_SPACING

    self.steamIPwarningLabel = ISRichTextPanel:new(entryX, y, self.scrollPanel.width, labelHgt);
    self.steamIPwarningLabel:initialise();
    self.steamIPwarningLabel:instantiate();
    self.steamIPwarningLabel:setAnchorLeft(false);
    self.steamIPwarningLabel:setAnchorRight(true);
    self.steamIPwarningLabel:setAnchorTop(true);
    self.steamIPwarningLabel:setAnchorBottom(false);
    self.steamIPwarningLabel:setMargins(0, 0, SCROLLBAR_SPACING, 0);
    self.scrollPanel:addChild(self.steamIPwarningLabel);
    self.steamIPwarningLabel.text = getText("UI_servers_serveripwarning")
    self.steamIPwarningLabel:paginate()
    self.lastUseSteamRelay = false

    self.scrollPanel:setScrollHeight(self.steamIPwarningLabel:getBottom() + BUTTON_HGT + UI_BORDER_SPACING)

    local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
    self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, PublicServerList.onOptionMouseDown);
    self.backButton.internal = "BACK";
    self.backButton:initialise();
    self.backButton:instantiate();
    self.backButton:setAnchorLeft(true);
    self.backButton:setAnchorTop(false);
    self.backButton:setAnchorBottom(true);
    self:addChild(self.backButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_joinServer"))
    self.playButton = ISButton:new(self.listbox.x + self.listbox.width - btnWidth, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_servers_joinServer"), self, PublicServerList.onOptionMouseDown);
    self.playButton.internal = "NEXT";
    self.playButton:initialise();
    self.playButton:instantiate();
    self.playButton:setAnchorLeft(false);
    self.playButton:setAnchorRight(true);
    self.playButton:setAnchorTop(false);
    self.playButton:setAnchorBottom(true);
    self:addChild(self.playButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_delete"))
    self.registerBtn = ISButton:new(self.playButton.x - UI_BORDER_SPACING - btnWidth, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_servers_register_QR"), self, PublicServerList.onOptionMouseDown);
    self.registerBtn.internal = "REGISTER";
    self.registerBtn:initialise();
    self.registerBtn:instantiate();
    self.registerBtn:setAnchorLeft(false);
    self.registerBtn:setAnchorRight(true);
    self.registerBtn:setAnchorTop(false);
    self.registerBtn:setAnchorBottom(true);
    self:addChild(self.registerBtn);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_refresh").." 99")
    self.refreshBtn = ISButton:new(self.backButton:getRight() + UI_BORDER_SPACING, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_servers_refresh"), self, PublicServerList.onOptionMouseDown);
    self.refreshBtn.internal = "REFRESH";
    self.refreshBtn:initialise();
    self.refreshBtn:instantiate();
    self.refreshBtn:setAnchorLeft(true);
    self.refreshBtn:setAnchorRight(false);
    self.refreshBtn:setAnchorTop(false);
    self.refreshBtn:setAnchorBottom(true);
    self:addChild(self.refreshBtn);

    local children = self.scrollPanel.javaObject:getControls()
    for i=1,children:size() do
        local child = children:get(i-1):getTable()
        if child.Type == "ISTextEntryBox" then
            self.scrollPanel:insertNewLineOfButtons(child)
        end
    end
    self.scrollPanel:insertNewLineOfButtons(self.eraseBtn, self.addBtn)
    self.scrollPanel.joypadIndex = 1
    self.scrollPanel.joypadIndexY = 1

    local filterEtcY = self.height-UI_BORDER_SPACING*3-BUTTON_HGT*3+3 -- figure this height issue out somehow
    self.filterUI = {}
    self.filterX = listX
    self.filterPadX = UI_BORDER_SPACING
    self.filterBottomPad = self.height - (filterEtcY + filterEtcHgt)

    self.filtersButton = ISButton:new(listX, self.scrollPanel:getBottom()+UI_BORDER_SPACING, 10, filterEtcHgt, getText("UI_servers_btn_filters"), self, PublicServerList.onOptionMouseDown);
    self.filtersButton.internal = "FILTERS";
    self.filtersButton:initialise();
    self.filtersButton:instantiate();
    self.filtersButton:setAnchorLeft(true);
    self.filtersButton:setAnchorTop(false);
    self.filtersButton:setAnchorBottom(true);
    self:addChild(self.filtersButton);

    self.versionCheckBox = ISTickBox:new(listX, self.filtersPopupLabel:getBottom()+ UI_BORDER_SPACING, 10, filterEtcHgt, "", self, self.onFilterChanged);
    self.versionCheckBox:initialise();
    self.versionCheckBox:instantiate();
    self.versionCheckBox:setAnchorLeft(true);
    self.versionCheckBox:setAnchorRight(false);
    self.versionCheckBox:setAnchorTop(true);
    self.versionCheckBox:setAnchorBottom(false);
    self.versionCheckBox.autoWidth = true
    self.filtersPopup:addChild(self.versionCheckBox);
    self.versionCheckBox:addOption(getText("UI_servers_versionCheck"));

    self.emptyServer = ISTickBox:new(listX, self.versionCheckBox:getBottom()+ UI_BORDER_SPACING, 10, filterEtcHgt, "", self, self.onFilterChanged);
    self.emptyServer:initialise();
    self.emptyServer:instantiate();
    self.emptyServer:setAnchorLeft(true);
    self.emptyServer:setAnchorRight(false);
    self.emptyServer:setAnchorTop(true);
    self.emptyServer:setAnchorBottom(false);
    self.emptyServer.selected[1] = true;
    self.emptyServer.autoWidth = true
    self.filtersPopup:addChild(self.emptyServer);
    self.emptyServer:addOption(getText("UI_servers_showEmptyServer"));

    self.whitelistServer = ISTickBox:new(listX, self.emptyServer:getBottom()+ UI_BORDER_SPACING, 10, filterEtcHgt, "", self, self.onFilterChanged);
    self.whitelistServer:initialise();
    self.whitelistServer:instantiate();
    self.whitelistServer:setAnchorLeft(true);
    self.whitelistServer:setAnchorRight(false);
    self.whitelistServer:setAnchorTop(true);
    self.whitelistServer:setAnchorBottom(false);
    self.whitelistServer.selected[1] = false;
    self.whitelistServer.autoWidth = true
    self.filtersPopup:addChild(self.whitelistServer);
    self.whitelistServer:addOption(getText("UI_servers_showWhitelistServer"));

    self.pwdProtected = ISTickBox:new(listX, self.whitelistServer:getBottom()+ UI_BORDER_SPACING, 10, filterEtcHgt, "", self, self.onFilterChanged);
    self.pwdProtected:initialise();
    self.pwdProtected:instantiate();
    self.pwdProtected:setAnchorLeft(true);
    self.pwdProtected:setAnchorRight(false);
    self.pwdProtected:setAnchorTop(true);
    self.pwdProtected:setAnchorBottom(false);
    self.pwdProtected.selected[1] = false;
    self.pwdProtected.autoWidth = true
    self.filtersPopup:addChild(self.pwdProtected);
    self.pwdProtected:addOption(getText("UI_servers_showPwdProtectedServer"));

    self.largeServer = ISTickBox:new(listX, self.pwdProtected:getBottom()+ UI_BORDER_SPACING, 10, filterEtcHgt, "", self, PublicServerList.onCheckLargeServerOption);
    self.largeServer:initialise();
    self.largeServer:instantiate();
    self.largeServer:setAnchorLeft(true);
    self.largeServer:setAnchorRight(false);
    self.largeServer:setAnchorTop(true);
    self.largeServer:setAnchorBottom(false);
    self.largeServer.selected[1] = false;
    self.largeServer.autoWidth = true
    self.filtersPopup:addChild(self.largeServer);
    self.largeServer:addOption(getText("UI_servers_showLargeServer"));

    self.vanillaServer = ISTickBox:new(listX, self.largeServer:getBottom()+ UI_BORDER_SPACING, 10, filterEtcHgt, "", self, self.onFilterChanged);
    self.vanillaServer:initialise();
    self.vanillaServer:instantiate();
    self.vanillaServer:setAnchorLeft(true);
    self.vanillaServer:setAnchorRight(false);
    self.vanillaServer:setAnchorTop(true);
    self.vanillaServer:setAnchorBottom(false);
    self.vanillaServer.selected[1] = true;
    self.vanillaServer.autoWidth = true
    self.filtersPopup:addChild(self.vanillaServer);
    self.vanillaServer:addOption(getText("UI_servers_showVanillaServer"));
    --table.insert(self.filterUI, self.vanillaServer)

    self.moddedServer = ISTickBox:new(listX, self.vanillaServer:getBottom()+ UI_BORDER_SPACING, 10, filterEtcHgt, "", self, self.onFilterChanged);
    self.moddedServer:initialise();
    self.moddedServer:instantiate();
    self.moddedServer:setAnchorLeft(true);
    self.moddedServer:setAnchorRight(false);
    self.moddedServer:setAnchorTop(true);
    self.moddedServer:setAnchorBottom(false);
    self.moddedServer.selected[1] = true;
    self.moddedServer.autoWidth = true
    self.filtersPopup:addChild(self.moddedServer);
    self.moddedServer:addOption(getText("UI_servers_showModdedServer"));
    --table.insert(self.filterUI, self.moddedServer)

    self.filterLabel = ISLabel:new(listX, self.moddedServer:getBottom()+ UI_BORDER_SPACING, BUTTON_HGT, getText("UI_servers_nameFilter"), 1, 1, 1, 1, UIFont.Small, true);
    self.filterLabel:initialise();
    self.filterLabel:instantiate();
    self.filterLabel:setAnchorLeft(true);
    self.filterLabel:setAnchorRight(false);
    self.filterLabel:setAnchorTop(true);
    self.filterLabel:setAnchorBottom(false);
    self.filtersPopup:addChild(self.filterLabel);

    self.filterEntry = ISTextEntryBox:new("", self.filterLabel:getRight() + UI_BORDER_SPACING, self.filterLabel:getY(), 130, BUTTON_HGT);
    self.filterEntry:initialise();
    self.filterEntry:instantiate();
    self.filterEntry:setAnchorLeft(true);
    self.filterEntry:setAnchorRight(false);
    self.filterEntry:setAnchorTop(true);
    self.filterEntry:setAnchorBottom(false);
    self.filtersPopup:addChild(self.filterEntry);

    self.closeFiltersPopupButton:setY(self.filterEntry:getBottom() + UI_BORDER_SPACING)
    self.filtersPopup:shrinkWrap(UI_BORDER_SPACING, UI_BORDER_SPACING, nil)
    self.closeFiltersPopupButton:setX(self.filtersPopup:getWidth() / 2 - self.closeFiltersPopupButton:getWidth() / 2)
    self.filtersPopupLabel:setX(self.filtersPopup:getWidth()/2 - self.filtersPopupLabel:getWidth()/2);

    self.sortingLabel = ISLabel:new(self.filtersButton:getRight() + UI_BORDER_SPACING, self.filtersButton:getY(), BUTTON_HGT, getText("UI_servers_sortLabel"), 1, 1, 1, 1, UIFont.Small, true);
    self.sortingLabel:initialise();
    self.sortingLabel:instantiate();
    self.sortingLabel:setAnchorLeft(true);
    self.sortingLabel:setAnchorRight(false);
    self.sortingLabel:setAnchorTop(false);
    self.sortingLabel:setAnchorBottom(true);
    self:addChild(self.sortingLabel);

    self.sortingType = ISComboBox:new(self.sortingLabel:getRight() + UI_BORDER_SPACING, self.filtersButton:getY(), 130, BUTTON_HGT, self, self.onSortingChanged);
    self.sortingType:initialise();
    self.sortingType:instantiate();
    self.sortingType.choicesColor = {r=1, g=1, b=1, a=1}
    self.sortingType:setAnchorLeft(true);
    self.sortingType:setAnchorRight(false);
    self.sortingType:setAnchorTop(false);
    self.sortingType:setAnchorBottom(true);
    self.sortingType:addOption(getText("UI_servers_sortType_Players"))
    self.sortingType:addOption(getText("UI_servers_sortType_Ping"))
    self:addChild(self.sortingType);

    if #self.listbox.items > 0 then
        self:fillFields(self.listbox.items[self.listbox.selected].item.server);
    end

end


function PublicServerList:onFilterChanged()
    self.recountFilteredPending = true;
    self.firstDrawPending = true
    self.firstDraw = false
    self.filteredCount = 0;
    self.listTabs:setPagesCount(0)
    --self.listbox:setVisible(false);
end


function PublicServerList:onMouseDown_ListTabs(x, y)
    if self:getMouseY() >= 0 and self:getMouseY() < self.tabHeight then
        local tabIndex = self:getTabIndexAtX(self:getMouseX())
        PublicServerList.instance.skipCount = 0
        PublicServerList.instance.pageChanged = true
        PublicServerList.instance.firstDrawPending = true
        PublicServerList.instance.firstDraw = false
        --PublicServerList.instance.scrollPanel:setYScroll(0)

        local clickedView = nil;
        for ind,value in ipairs(self.viewList) do
            -- we get the view we clicked on
            if ind == tabIndex then
                clickedView = value;
                break;
            end
        end
        -- if we clicked on another view, we display it and make the previous one not visible
        if clickedView and clickedView.name ~= self.activeView.name then
            self:activateView(clickedView.name)
        end
    end
end

function PublicServerList:onMouseDown_Tabs(x, y)
    if self:getMouseY() >= 0 and self:getMouseY() < self.tabHeight then
        local tabIndex = self:getTabIndexAtX(self:getMouseX())
        if tabIndex == 1 then
            if getSteamModeActive() then
                steamReleaseInternetServersRequest()
            end
            MainScreen.instance.joinPublicServer:setVisible(false)
            MainScreen.instance.serverList:setVisible(true, JoypadState.getMainMenuJoypad())
            if not getSteamModeActive() then
                MainScreen.instance.serverList:refreshList()
            end
        end
    end
end

function PublicServerList:prerender()
PublicServerList.instance = self
    ISPanelJoypad.prerender(self);

    PublicServerList.instance = self

--    self:drawTextCentre( getText("UI_servers_publicServer"), self.width / 2 - 100, 10, 1, 1, 1, 1, UIFont.Large);

    self:drawTextCentre(getText("UI_servers_addToFavorite"), self.scrollPanel:getX() + self.scrollPanel:getWidth() / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Large);

    local fieldsOK = self:checkFields()

    local find = false;

    for i,v in ipairs(MainScreen.instance.serverList.listbox.items) do
        if v.item.server:getName() == self.serverNameEntry:getText() then
            find = true;
            break;
        end
    end

    if fieldsOK and find then
        self.firstAddServer = true;
        self.addBtn:setEnable(false);
        self.addBtn:setTooltip(getText("UI_servers_err_saved_server_exists"))
        self.authType:setEnabled(false)
        if self.passwordEntry:isFocused() then
            if not self.passwordWasFocused then
                self.passwordWasFocused = true
                self.passwordEntry:setMasked(true)
                self.passwordEntry:setText("")
            end
        else
            if self.passwordWasFocused then
                self.passwordWasFocused = false;
                self.passwordText = self.passwordEntry:getInternalText();
                if self.passwordText ~= "" then
                    self.passwordEntry:setMasked(false);
                    self.passwordEntry:setText(getText("UI_Server_Passwort_Hint"));
                end
            end
        end
        -- If google auth of two factor selected enable register QR button
        if 1 ~= self.authType:getSelected() then
            self.registerBtn:setVisible(true);
            self.registerBtn:setEnabled(true);
            self.passwordEntry:setMasked(true);
        end
    else
        if self.firstAddServer then
            self.firstAddServer = false;
            self.passwordEntry:setText("");
        end
        self.authType:setEnabled(true)
        self.registerBtn:setVisible(false);
        self.registerBtn:setEnabled(false);
    end
-- Check if this is a google auth only
    if 2 == self.authType:getSelected() then
        self.rememberPasswordTickBox:setEnabled(false);
        self.passwordEntry:setEnabled(false);
        self.passwordLabel:setEnabled(false);
        self.rememberPasswordTickBox:setVisible(false);
        self.passwordEntry:setVisible(false);
        self.passwordLabel:setVisible(false);
    else
        self.rememberPasswordTickBox:setEnabled(true);
        self.passwordEntry:setEnabled(true);
        self.passwordLabel:setEnabled(true);
        self.rememberPasswordTickBox:setVisible(true);
        self.passwordEntry:setVisible(true);
        self.passwordLabel:setVisible(true);
    end

    if (getTimestamp() - PublicServerList.refreshTime) < PublicServerList.refreshInterval then
        self.refreshBtn:setEnable(false);
        self.refreshBtn:setTitle(getText("UI_servers_refresh") .. " " .. (PublicServerList.refreshInterval - math.floor(getTimestamp() - PublicServerList.refreshTime)));
    else
        self.refreshBtn:setEnable(true);
        self.refreshBtn:setTitle(getText("UI_servers_refresh"));
    end

    local item = self.listbox.items[self.listbox.selected]
    if self.playButton:isEnabled() and item and item.item.server:getVersion() ~= getCore():getVersion() then
        self.playButton:setEnable(false)
        local tooltip = getText("UI_servers_err_version_mismatch", item.item.server:getVersion(), getCore():getVersion())
        self.playButton:setTooltip(tooltip)
    end

    if self.joyfocus then
        self:setISButtonForA(self.playButton)
        self:setISButtonForB(self.backButton)
        self:setISButtonForX(self.refreshBtn)
    else
        self.ISButtonA = nil
        self.ISButtonB = nil
        self.playButton:clearJoypadButton()
        self.backButton:clearJoypadButton()
        self.refreshBtn:clearJoypadButton()
    end

    local useSteamRelay = getSteamModeActive() and self.connectTypeEntry.selected[1]
    if self.lastUseSteamRelay ~= useSteamRelay then
        self.lastUseSteamRelay = useSteamRelay
        if (useSteamRelay) then
            self.steamIPwarningLabel:setText(getText("UI_servers_serveripmessage"))
            self.steamIPwarningLabel:paginate()
        else
            self.steamIPwarningLabel:setText(getText("UI_servers_serveripwarning"))
            self.steamIPwarningLabel:paginate()
        end
    end
end

function PublicServerList:setServerDescription(item)
    local text = item.server:getDescription()
    text = text:gsub("<", "&lt"):gsub(">", "&gt")
    text = text:gsub("\\n", "\n")
    text = " <RGB:0.8,0.8,0.8> " .. text
    item.richText:setText(text)
    item.richText:paginate()
end

function PublicServerList:countMods(modString)
    local totalMods = 0
    local list = luautils.split(modString, ",")
    for _,modID in ipairs(list) do
        if #string.trim(modID) > 0 then
            totalMods = totalMods + 1
        end
    end
    return totalMods
end

function PublicServerList:setServerMods(item)
    if item.server:getMods() and item.server:getMods() ~= "" then
        local mods = item.server:getMods()
        local modCount = nil
        if getSteamModeActive() then
            mods = mods:gsub(";", ",")
            modCount = item.rules and tonumber(item.rules.modCount) or nil
        end
        mods = mods:gsub(",", ", ")
        local text = getText("UI_servers_mods") .. mods:gsub("<", "&lt"):gsub(">", "&gt")
        if modCount then
            local totalMods = self:countMods(mods)
            if totalMods ~= modCount then
                text = string.format("%s %s", text, getText("Tooltip_AndNMore", modCount - totalMods))
            end
        end
        text = " <RGB:0.8,0.8,0.8> " .. text
        item.modsText = ISRichTextLayout:new(self:getWidth()-17)
        item.modsText:setText(text)
        item.modsText:paginate()
    else
        item.modsText = nil
    end
end

function PublicServerList:addServerToList(server)
    local item = {}
    item.server = server

    local name = server:getName();

    local error = checkServerName(name);

    if error then
        return;
    end

    
    item.richText = ISRichTextLayout:new(self:getWidth()-17)
    item.richText:initialise()
    self:setServerDescription(item)

    self:setServerMods(item)

    self.listbox:addItem(name, item);

    if not server:isOpen() then
        return
    end

    if not self.versionCheckBox.selected[1] then
        if server:getVersion() and server:getVersion() ~= getCore():getVersion() then
            return
        end
    end

    if not self.emptyServer.selected[1] then
        if server:getPlayers() and tonumber(server:getPlayers()) == 0 then
            return
        end
    end

    if not self.whitelistServer.selected[1] then
        if not server:isOpen() then
            return
        end
    end

    if not self.pwdProtected.selected[1] then
        if server:isPasswordProtected() then
            return
        end
    end

    if not self.largeServer.selected[1] then
        if tonumber(server:getMaxPlayers()) >= 32 then
            return
        end
    end

    if not self.vanillaServer.selected[1] then
        if "" == server:getMods() then
            return
        end
    end

    if not self.moddedServer.selected[1] then
        if "" ~= server:getMods() then
            return
        end
    end

    if not self.hasVisibleItem then
        self:fillFields(server)
        self.listbox.selected = #self.listbox.items
        self.hasVisibleItem = true
    end
    self.filteredCount = self.filteredCount + 1
    self.listTabs:setPagesCount(math.ceil(self.filteredCount / self.listCount))
end

function PublicServerList:refreshList()
    self.pageChanged = true
    self.skipCount = 0
    self.listCount = 10
    self.filteredCount = 0
    self.listTabs:setPagesCount(0)
    self.listbox:clear();
    self.hasVisibleItem = false
    if not isPublicServerListAllowed() then return; end
    if getSteamModeActive() then
        steamRequestInternetServersList()
        PublicServerList.refreshTime = getTimestamp()
        return
    end
    local dirs = getPublicServersList();
    if #dirs == 0 then
        return;
    end
    table.sort(dirs, function(a,b) return tonumber(a:getPlayers())>tonumber(b:getPlayers()) end)
    for i, k in ipairs(dirs) do
        --if k:getVersion() == getCore():getVersion() then
            self:addServerToList(k);
        --end
    end
    PublicServerList.refreshTime = getTimestamp();
end

function PublicServerList:sortList()
    local sorted = {}
    for _,item in ipairs(self.listbox.items) do
        local item2 = {}
        item2.item = item
        item2.isSpiffoSpace = string.find(item.item.server:getName(), "SpiffoSpace")
        if 1 == self.sortingType:getSelected() then
            item2.numPlayers = tonumber(item.item.server:getPlayers())
        end
        if 2 == self.sortingType:getSelected() then
            item2.ping = tonumber(item.item.server:getPing())
        end
        table.insert(sorted, item2)
    end
    table.sort(sorted, function(a,b)
        if a.isSpiffoSpace then
            if not b.isSpiffoSpace then
                return true
            end
        elseif b.isSpiffoSpace then
            if not a.isSpiffoSpace then
                return false
            end
        end
        if a.ping then
            return a.ping < b.ping
        end
        if a.numPlayers then
            return a.numPlayers > b.numPlayers
        end
    end)
    self.listbox.items = {}
    for _,item2 in ipairs(sorted) do
        table.insert(self.listbox.items, item2.item)
    end
end

function PublicServerList:onSendButton()
    local server = self.listbox.items[self.listbox.selected].item.server
    local doHash = true;
    if server:isSavePwd() and server:getPwd() == self.passwordText then
        doHash = false;
    end
    self.googleAuthConnectLabel.text = getText("UI_servers_QR_connecting")
    self.googleAuthConnectLabel.text = " <CENTRE> " .. self.googleAuthConnectLabel.text
    self.googleAuthConnectLabel:paginate()
    self.googleAuthConnectLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthConnectLabel.width/2);
    sendSecretKey(self.usernameEntry:getText(), self.passwordText, self.serverEntry:getText(), self.portEntry:getText(), doHash, self.authType:getSelected(), self.googleKey);
end

function PublicServerList:onCloseQRButton()
    self.googleAuthPopup.qrTexture = nil;
    self.googleAuthPopup:setVisible(false);
    self.googleAuthConnectLabel.name = ""
end

function PublicServerList:onCloseFiltersButton()
    self.filtersPopup:setVisible(false);
end

function PublicServerList:onOptionMouseDown(button, x, y)
    if button.internal == "FILTERS" then
        self.filtersPopup:setVisible(true);
    end
    if button.internal == "REFRESH" then
        self:refreshList();
    end
    if button.internal == "SAVEDSERVERS" then
        if getSteamModeActive() then
            steamReleaseInternetServersRequest()
        end
        self:setVisible(false);
        MainScreen.instance.serverList:setVisible(true);
        MainScreen.instance.serverList:refreshList();
    end
    if button.internal == "BACK" then
        if getSteamModeActive() then
            steamReleaseInternetServersRequest()
        end
        --        getCore():ResetLua(true, "exitJoinServer")
        PublicServerList.instance:setVisible(false);
        MainScreen.instance.serverList:setVisible(false);
        MainScreen.instance.bottomPanel:setVisible(true);
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            joypadData.focus = MainScreen.instance
            updateJoypadFocus(joypadData)
        end
        MainScreen.resetLuaIfNeeded()
    end
    if button.internal == "ADD" then
        self:addServer();
    end
    if button.internal == "ERASE" then
        self:erase();
    end
    if button.internal == "REGISTER" then
        self.googleAuthPopup:setVisible(true);
        local username = self.usernameEntry:getText();
        self.googleKey = generateSecretKey(username);
        self.googleAuthPopup.qrTexture = createQRCodeTex(username,self.googleKey)
    end
    if button.internal == "NEXT" then
        local server = self.listbox.items[self.listbox.selected].item.server
        if server:getVersion() ~= getCore():getVersion() then
        else
            if self:checkFields() then
                if getSteamModeActive() then
                    steamReleaseInternetServersRequest()
                end
                local localIP = ""
                local useSteamRelay = getSteamModeActive() and self.connectTypeEntry.selected[1]
                local doHash = true;
				if self.passwordEntry:isFocused() then
					self.passwordText = self.passwordEntry:getInternalText();
				end
				if server:isSavePwd() and server:getPwd() == self.passwordText then
                    doHash = false;
                end
                ConnectToServer.instance:connect(self, server:getName(), self.usernameEntry:getText(),
                    self.passwordText, self.serverEntry:getText(),
					localIP, self.portEntry:getText(), self.serverPasswordEntry:getInternalText(), useSteamRelay, doHash, self.authType:getSelected());
            end
        end
    end
    --self.listbox:sort();
end

function PublicServerList:addServer()
    if PublicServerList.instance:checkFields() then
        PublicServerList.instance:trimFields()
        local newServer = Server.new();
        newServer:setName(self.serverNameEntry:getText() or "");
        newServer:setIp(self.serverEntry:getText() or "");
        newServer:setPort(self.portEntry:getText() or "");
        newServer:setServerPassword(self.serverPasswordEntry:getInternalText() or "")
        newServer:setDescription(self.descEntry:getText() or "");
        newServer:setUserName(self.usernameEntry:getText() or "");
        newServer:setPwd(self.passwordText or "", true);
        self.passwordWasFocused = true;
        newServer:setSavePwd(self.rememberPasswordTickBox:isSelected(1));
        newServer:setAuthType(self.authType:getSelected());
        if getSteamModeActive() then
            newServer:setUseSteamRelay(self.connectTypeEntry:isSelected(1));
        end
--        newServer:setSteamId(self.steamIdEntry:getText() or "");
        getCustomizationData(newServer:getUserName(), newServer:getPwd(), newServer:getIp(), newServer:getPort(), newServer:getServerPassword(), newServer:getName(), false);
        self:writeServerOnFile(newServer, true);
        self:setVisible(false);
        MainScreen.instance.serverList:fillFields(newServer);
        MainScreen.instance.serverList:setVisible(true);
        MainScreen.instance.serverList:refreshList();
        for index,item in ipairs(MainScreen.instance.serverList.listbox.items) do
            if item.text == newServer:getName() then
                MainScreen.instance.serverList.listbox.selected = index
                break
            end
        end
    end
end

function PublicServerList:checkFields()
    self.usernameEntry:setValid(true)
    self.usernameEntry:setTooltip(getText("UI_servers_username_tt"))
    
    self.passwordEntry:setValid(true)
    self.passwordEntry:setTooltip(getText("UI_servers_pwd_tt"))
    
    self.serverEntry:setValid(true)
    self.serverEntry:setTooltip(nil)
    
    self.portEntry:setValid(true)
    self.portEntry:setTooltip(nil)

--    self.passwordEntry:setValid(true)
--    self.passwordEntry:setTooltip(getText("UI_servers_serverpwd_tt"))

    local valid = true
    local tooltip = nil
    -- Check for an empty password. If it's a google auth (type 2) then there is no need to check.
    if 2 ~= self.authType:getSelected() and self.passwordEntry:getInternalText():trim() == "" then
        self.passwordEntry:setValid(false)
        self.passwordEntry:setTooltip(getText("UI_servers_err_username_pwd"))
        if valid then
            tooltip = getText("UI_servers_err_username_pwd")
        end
        valid = false;
    end
    
    if self.serverEntry:getText():trim() == "" then
        self.serverEntry:setValid(false)
        self.serverEntry:setTooltip(getText("UI_servers_err_ip"))
        if valid then
            tooltip = getText("UI_servers_err_ip")
        end
        valid = false;
    end
    if not tonumber(self.portEntry:getText():trim()) then
        self.portEntry:setValid(false)
        self.portEntry:setTooltip(getText("UI_servers_err_port"))
        if valid then
            tooltip = getText("UI_servers_err_port")
        end
        valid = false;
    end
    if not isValidUserName(self.usernameEntry:getText()) then
        self.usernameEntry:setValid(false)
        self.usernameEntry:setTooltip(getText("UI_servers_err_username"))
        if valid then
            tooltip = getText("UI_servers_err_username")
        end
        valid = false;
    end
--    if self.passwordEntry:getText():trim() == "" then
--        self.passwordEntry:setValid(false)
--        self.passwordEntry:setTooltip(getText("UI_servers_needPwd"))
--        if valid then
--            tooltip = getText("UI_servers_needPwd")
--        end
--        valid = false;
--    end

	if valid then
		local intValid, intTooltip = self:canConnect();
		if not intValid then
			valid = false;
			tooltip = intTooltip;
		end
	end

    if self.listbox.selected == -1 or #self.listbox.items == 0 then
        self.playButton:setEnable(false)
        self.playButton:setTooltip(nil)
    else
    self.playButton:setEnable(valid)
    self.playButton:setTooltip(tooltip)
    end
    
    self.addBtn:setEnable(valid)
    self.addBtn:setTooltip(tooltip)

    return valid;
end

function PublicServerList:canConnect()
	if not canConnect() then
		self.playButton:setTitle(getText("UI_servers_joinServer") .. " " .. getReconnectCountdownTimer())
		self.showCountdownForJoin = true;
		return false, nil;
	end
	if self.showCountdownForJoin then
		self.playButton:setTitle(getText("UI_servers_joinServer"))
		self.showCountdownForJoin = false;
	end
	return true, "";
end

function PublicServerList:clickNext()
    if not self.playButton:isEnabled() then
        return;
    end
    --    stopPing();
    --    PublicServerList.pingIndex = 1;
    stopSendSecretKey();
    self.connecting = true;
    self.playButton:setEnable(false);
    self.backButton:setEnable(false);
    self.failMessage = nil
    local server = self.listbox.items[self.listbox.selected].item.server
    self.connectLabel.name = getText("UI_servers_Connecting");
    local localIP = ""
    serverConnect(server:getUserName(), server:getPwd(), server:getIp(), localIP, server:getPort(), server:getServerPassword(), server:getName(), server:getUseSteamRelay());
end

function PublicServerList:emptyServerFile(server, append)
    local fileOutput = getFileWriter(getServerListFile(), false, false)
    fileOutput:close();
end

function PublicServerList:writeServerOnFile(server, append)
    local fileOutput = getFileWriter(getServerListFile(), true, append);
    fileOutput:write("name=" .. server:getName() .. "\r\n");
    fileOutput:write("ip=" .. server:getIp() .. "\r\n");
    fileOutput:write("port=" .. server:getPort() .. "\r\n");
    fileOutput:write("serverpassword=" .. server:getServerPassword() .. "\r\n");
    fileOutput:write("description=" .. server:getDescription() .. "\r\n");
    fileOutput:write("user=" .. server:getUserName() .. "\r\n");
    fileOutput:write("remember=" .. tostring(server:isSavePwd()) .. "\r\n");
    fileOutput:write("authType=" .. tostring(server:getAuthType()) .. "\r\n");
    fileOutput:write("loginScreenId=" .. tostring(server:getLoginScreenId()) .. "\r\n");
    fileOutput:write("serverCustomizationLastUpdate=" .. tostring(server:getServerCustomizationLastUpdate()) .. "\r\n");
    if server:isSavePwd() then
        fileOutput:write("password=" .. server:getPwd() .. "\r\n");
    end
    fileOutput:write("usesteamrelay=" .. tostring(server:getUseSteamRelay()) .. "\r\n");
    fileOutput:close();
end

function PublicServerList:erase()
    self.serverNameEntry:setText("");
    self.serverEntry:setText("127.0.0.1");
    self.portEntry:setText("16261");
    self.serverPasswordEntry:setText("");
    self.descEntry:setText("");
    self.usernameEntry:setText("");
    self.passwordEntry:setText("");
    self.passwordText = "";
    self.rememberPasswordTickBox:setSelected(1, false)
    self.authType:setSelected(1);
--    self.steamIdEntry:setText("");
    if getSteamModeActive() then
        self.connectTypeEntry.selected[1] = false;
    end
end

function PublicServerList:onClickServer(item)
    self:fillFields(item.server);
end

function PublicServerList:fillFields(item)
    self.serverNameEntry:setText(item:getName());
    self.serverEntry:setText(item:getIp());
--    self.steamIdEntry:setText(item:getSteamId());
    self.portEntry:setText(item:getPort());
    self.serverPasswordEntry:setText(item:getServerPassword())
    self.descEntry:setText(item:getDescription());
    self.usernameEntry:setText(item:getUserName());
    self.passwordEntry:setText(item:getPwd());
    self.passwordText = item:getPwd();
    self.passwordWasFocused = true;
    self.rememberPasswordTickBox:setSelected(1,item:isSavePwd());
    self.authType:setSelected(item:getAuthType());
    if getSteamModeActive() then
        self.connectTypeEntry.selected[1] = item:getUseSteamRelay();
    end
end

function PublicServerList:trimFields(item)
    self.serverNameEntry:setText(self.serverNameEntry:getText():trim());
    self.serverEntry:setText(self.serverEntry:getText():trim());
--    self.steamIdEntry:setText(self.steamIdEntry:getText():trim());
    self.portEntry:setText(self.portEntry:getText():trim());
    self.serverPasswordEntry:setText(self.serverPasswordEntry:getInternalText():trim())
    self.descEntry:setText(self.descEntry:getText():trim());
    self.usernameEntry:setText(self.usernameEntry:getText():trim());
    self.passwordEntry:setText(self.passwordEntry:getInternalText():trim());
end



function PublicServerList:drawMap(y, item, alt)
    if PublicServerList.instance.pageChanged then
        PublicServerList.instance.pageChanged = false;
        self.stopPrerender = true;
        return y;
    end
    if item.index == 1 then
        if PublicServerList.instance.recountFiltered then
            PublicServerList.instance.recountFiltered = false
        end
        if PublicServerList.instance.recountFilteredPending then
            PublicServerList.instance.recountFilteredPending = false
            PublicServerList.instance.recountFiltered = true
        end
        PublicServerList.instance.pageChanged = false
        PublicServerList.instance.skipCount = 0
    end

    if PublicServerList.instance.recountFilteredPending then
        return y;
    end

    local server = item.item.server
    if not server:isPublic() then
        return y;
    end
    local filter = PublicServerList.instance.filterEntry:getInternalText()
    if string.trim(filter) and not string.contains(string.lower(server:getName()), string.lower(string.trim(filter))) then
        return y;
    end

    if not PublicServerList.instance.versionCheckBox.selected[1] then
        if server:getVersion() and server:getVersion() ~= getCore():getVersion() then
            return y
        end
    end

    if not PublicServerList.instance.emptyServer.selected[1] then
        if server:getPlayers() and tonumber(server:getPlayers()) == 0 then
            return y
        end
    end

    if not PublicServerList.instance.whitelistServer.selected[1] then
        if not server:isOpen() then
            return y
        end
    end

    if not PublicServerList.instance.pwdProtected.selected[1] then
        if server:isPasswordProtected() then
            return y
        end
    end

    if not PublicServerList.instance.largeServer.selected[1] then
        if tonumber(server:getMaxPlayers()) >= 32 then
            return y
        end
    end

    if not PublicServerList.instance.vanillaServer.selected[1] then
        if "" == server:getMods() then
            return y
        end
    end

    if not PublicServerList.instance.moddedServer.selected[1] then
        if "" ~= server:getMods() then
            return y
        end
    end
    if PublicServerList.instance.recountFiltered then
        PublicServerList.instance.filteredCount = PublicServerList.instance.filteredCount + 1;
        PublicServerList.instance.listTabs:setPagesCount(math.ceil(PublicServerList.instance.filteredCount / PublicServerList.instance.listCount))
    end

    if PublicServerList.instance.listTabs:getActiveViewIndex() then
        if PublicServerList.instance.skipCount < (tonumber(PublicServerList.instance.listTabs:getActiveViewIndex()) - 1) * PublicServerList.instance.listCount then
            PublicServerList.instance.skipCount = PublicServerList.instance.skipCount + 1;
            return y;
        elseif PublicServerList.instance.skipCount >= tonumber(PublicServerList.instance.listTabs:getActiveViewIndex()) * PublicServerList.instance.listCount then
            --PublicServerList.instance.skipCount = PublicServerList.instance.skipCount + 1;
            --return y;
        end
        PublicServerList.instance.skipCount = PublicServerList.instance.skipCount + 1;
    end

    if y + self:getYScroll() + item.height < 0 or y + self:getYScroll() >= self.height then
        return y + item.height
    end

    local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15);
    elseif isMouseOver then
        self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.95, 0.05, 0.05, 0.05);
    end
    self:drawRectBorder(0, (y), self:getWidth(), item.height-1, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    local dx = 0
    if server:isPasswordProtected() then
        dx = self.lockTexture:getWidth() + 8
        local largeFontHgt = getTextManager():getFontFromEnum(UIFont.Large):getLineHeight()
        self:drawTexture(self.lockTexture, 20, y + 15 + (largeFontHgt - self.lockTexture:getHeight()) / 2, 1, 1, 1, 1)
    end
    self:drawText(server:getName() .. " (" .. string.trim(server:getIp()) .. ":" .. server:getPort() .. ")", 20+dx, y+15, 0.9, 0.9, 0.9, 0.9, UIFont.Large);

    local richText = item.item.richText
    if richText:getWidth() ~= self:getWidth() - 17 then
        richText:setWidth(self:getWidth() - 17)
        richText:paginate()
    end
    local yy = y + 45
    richText:render(0, yy, self)
    yy = yy + richText:getHeight()

    self:drawText(getText("UI_servers_players") .. server:getPlayers() .. " / " .. server:getMaxPlayers(), self.width / 2, yy, 0.9, 0.9, 0.9, 0.9, UIFont.Small);

    self:drawText(getText("UI_servers_version") .. server:getVersion(), self.width / 2, yy+FONT_HGT_SMALL, 0.9, 0.9, 0.9, 0.9, UIFont.Small);

--    if not server:isOpen() then
--        self:drawText("Need Registration", self:getWidth() - 100, y+45, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
--    end

    if server:isOpen() then
        self:drawText(getText("UI_servers_WhitelistOff"), 20, yy, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    else
        self:drawText(getText("UI_servers_WhitelistOn"), 20, yy, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    end

    if getSteamModeActive() then
        self:drawText(getText("UI_servers_Ping", server:getPing()), 20, yy+FONT_HGT_SMALL, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    else
        local min = getText("IGUI_Gametime_minutes");
        if server:getLastUpdate() < 1 then
            min = getText("IGUI_Gametime_minute");
        end
        self:drawText(getText("UI_servers_LastUpdate") .. server:getLastUpdate() .. " " .. min .. " ago", 20, yy+FONT_HGT_SMALL, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    end

    yy = yy + 2 * FONT_HGT_SMALL

    if item.item.modsText then
        local richText = item.item.modsText
        if richText:getWidth() ~= self:getWidth() - 17 then
            richText:setWidth(self:getWidth() - 17)
            richText:paginate()
        end
        richText:render(0, yy, self)
        yy = yy + richText:getHeight()
    end

    if PublicServerList.pingedList[server:getIp()] ~= nil then
        self:drawText(getText("UI_servers_Users") .. PublicServerList.pingedList[server:getIp()].users, 20, y+70, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    end

    self.itemheightoverride[item.text] = yy + 12 - y;

    y = y + self.itemheightoverride[item.text];

    return y;
end

function PublicServerList:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:setISButtonForA(self.playButton)
    self:setISButtonForB(self.backButton)
	self:setISButtonForX(self.refreshBtn)
    self:restoreJoypadFocus(joypadData)
end

function PublicServerList:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus(joypadData)
end

function PublicServerList:onJoypadDown(button, joypadData)
    if button == Joypad.LBumper then
        if getSteamModeActive() then
            steamReleaseInternetServersRequest()
        end
        MainScreen.instance.joinPublicServer:setVisible(false)
        MainScreen.instance.serverList:setVisible(true, joypadData)
        if not getSteamModeActive() then
            MainScreen.instance.serverList:refreshList()
        end
        return
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function PublicServerList:onJoypadDirUp(joypadData)
    if self.joypadIndexY == 1 then
        self.listbox:setJoypadFocused(true, joypadData)
        return
    end
    ISPanelJoypad.onJoypadDirUp(self, joypadData)
end

function PublicServerList:onJoypadDirDown(joypadData)
    ISPanelJoypad.onJoypadDirDown(self, joypadData)
end

-----

function PublicServerList:onJoypadDown_ListBox(button, joypadData)
    if button == Joypad.AButton then
        
    end
    if button == Joypad.BButton then
        self:setJoypadFocused(false, joypadData)
        joypadData.focus = self.parent
    end
    if button == Joypad.LBumper then
        self.parent:onJoypadDown(button, joypadData)
    end
end

function PublicServerList:onJoypadDirRight_ListBox(joypadData)
    self:setJoypadFocused(false, joypadData)
    joypadData.focus = self.parent.scrollPanel
end

-----

function PublicServerList:onGainJoypadFocus_RightPanel(joypadData)
    self:restoreJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
end

function PublicServerList:onLoseJoypadFocus_RightPanel(joypadData)
    self:clearJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function PublicServerList:onJoypadDown_RightPanel(button, joypadData)
    if (button == Joypad.BButton) and not self:isFocusOnControl() then
        joypadData.focus = self.parent
        return
    end
    if button == Joypad.LBumper then
        self.parent:onJoypadDown(button, joypadData)
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function PublicServerList:onJoypadDirLeft_RightPanel(joypadData)
    if self.joypadIndex == 1 then
        joypadData.focus = self.parent.listbox
        self.parent.listbox:setJoypadFocused(true, joypadData)
        return
    end
    ISPanelJoypad.onJoypadDirLeft(self, joypadData)
end

-----

function PublicServerList:initialise()
    ISPanelJoypad.initialise(self);
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function PublicServerList:instantiate()
    self.javaObject = UIElement.new(self);
    self.javaObject:setX(self.x);
    self.javaObject:setY(self.y);
    self.javaObject:setHeight(self.height);
    self.javaObject:setWidth(self.width);
    self.javaObject:setAnchorLeft(self.anchorLeft);
    self.javaObject:setAnchorRight(self.anchorRight);
    self.javaObject:setAnchorTop(self.anchorTop);
    self.javaObject:setAnchorBottom(self.anchorBottom);
end

function PublicServerList.OnSteamServerResponded(serverIndex)
    local server = steamGetInternetServerDetails(serverIndex)
    if server then
        PublicServerList.instance:addServerToList(server)
        steamRequestServerRules(server:getIp(), tonumber(server:getPort()))
    end
end

function PublicServerList.OnSteamRefreshInternetServers()
    steamReleaseInternetServersRequest()
    PublicServerList.instance:sortList()
end

function PublicServerList.OnSteamRulesRefreshComplete(host, port, rules)
    local self = PublicServerList.instance
    local items = self.listbox.items
    for i=1,#items do
        local server = items[i].item.server
        if server:getIp() == host and server:getPort() == tostring(port) then
            items[i].item.rules = rules
            if rules.description then
                server:setDescription(rules.description)
                self:setServerDescription(items[i].item)
                if i == self.listbox.selected then
                    self:fillFields(server)
                end
            end
            if rules.version then
                server:setVersion(rules.version)
            end
            server:setOpen(rules.open == "1")
            server:setPublic(rules.public == "1")
            if rules.mods then
                server:setMods(rules.mods)
            end
            self:setServerMods(items[i].item)
            break
        end
    end
end

function PublicServerList:onResolutionChange(oldw, oldh, neww, newh)
    if not self.filterUI then return end
    local fontScale = FONT_HGT_SMALL / 15
    local entrySize = 200 * fontScale;
    local listX = UI_BORDER_SPACING+1
    local listWid = self.width - UI_BORDER_SPACING*2 - entrySize - listX
    self.listbox:setWidth(math.max(listWid, 200))
    self.tabs:setWidth(math.max(listWid, 200))
end

function PublicServerList:new(x, y, width, height)
    -- using a virtual 100 height res for doing the UI, so it resizes properly on different rez's.
    local o = {}
    --o.data = {}
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = 0;
    o.y = 0;
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0.0 };
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.0 };
    o.itemheightoverride = {};
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    PublicServerList.instance = o;
    o.NoLabel = false;
    o.anchorBottom = false;
    return o;
end

function PublicServerList:OnConnectFailed(message, detail)
    if self.googleAuthConnectLabel then
        local labelSuccess = " <CENTRE> " .. getText("UI_servers_QR_send_success")
        local labelFailed = " <CENTRE> " .. getText("UI_servers_QR_send_failed")
        if labelSuccess ~= self.googleAuthConnectLabel.text  and labelFailed ~= self.googleAuthConnectLabel.text then
            self.googleAuthConnectLabel.text = message or getText("UI_servers_connectionfailed")
            self.googleAuthConnectLabel.text = " <CENTRE> " .. self.googleAuthConnectLabel.text
            self.googleAuthConnectLabel:paginate()
            self.googleAuthConnectLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthConnectLabel.width/2);
        end
        stopSendSecretKey();
    end
end

function PublicServerList:OnConnected()
    if self.googleAuthConnectLabel then
        self.googleAuthConnectLabel.text = getText("UI_servers_QR_sending_key")
        self.googleAuthConnectLabel.text = " <CENTRE> " .. self.googleAuthConnectLabel.text
        self.googleAuthConnectLabel:paginate()
        self.googleAuthConnectLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthConnectLabel.width/2);
    end
end

function PublicServerList:OnQRReceived(message)
    self.googleAuthConnectLabel.text = message--getText("UI_servers_QR_send_success")
    self.googleAuthConnectLabel.text = " <CENTRE> " .. self.googleAuthConnectLabel.text
    self.googleAuthConnectLabel:paginate()
    self.googleAuthConnectLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthConnectLabel.width/2);
    stopSendSecretKey();
end

function OnConnectFailed(message, detail)
    PublicServerList.instance:OnConnectFailed(message,detail)
end

function OnConnected()
    PublicServerList.instance:OnConnected()
end

local function OnQRReceived(message)
	PublicServerList.instance:OnQRReceived(message)
end

Events.OnQRReceived.Add(OnQRReceived)
Events.OnConnectFailed.Add(OnConnectFailed)
Events.OnDisconnect.Add(OnConnectFailed)
Events.OnConnected.Add(OnConnected)

Events.ServerPinged.Add(PublicServerList.ServerPinged);
if getSteamModeActive() then
    LuaEventManager.AddEvent("OnSteamServerResponded")
    LuaEventManager.AddEvent("OnSteamRefreshInternetServers")
    LuaEventManager.AddEvent("OnSteamRulesRefreshComplete")
    Events.OnSteamServerResponded.Add(PublicServerList.OnSteamServerResponded)
    Events.OnSteamRefreshInternetServers.Add(PublicServerList.OnSteamRefreshInternetServers)
    Events.OnSteamRulesRefreshComplete.Add(PublicServerList.OnSteamRulesRefreshComplete)
end

