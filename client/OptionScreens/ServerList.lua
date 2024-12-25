--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 23/01/14
-- Time: 12:49
-- To change this template use File | Settings | File Templates.
--

ServerList = ISPanelJoypad:derive("ServerList");
ServerList.pingedList = {};
ServerList.refreshTime = 0
ServerList.refreshInterval = 5

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local SCROLLBAR_WIDTH = 13
local SCROLLBAR_SPACING = SCROLLBAR_WIDTH + UI_BORDER_SPACING

function ServerList:create()
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
    if isPublicServerListAllowed() then
        self.tabs:addView(getText("UI_servers_publicServer"), ISUIElement:new(0,0,100,100))
    end

    self.listbox = ISScrollingListBox:new(listX, listTop, listWid, self.height-UI_BORDER_SPACING*2-BUTTON_HGT-listTop-1);
    self.listbox:initialise();
    self.listbox:instantiate();
    self.listbox:setAnchorLeft(true);
    self.listbox:setAnchorRight(true);
    self.listbox:setAnchorTop(true);
    self.listbox:setAnchorBottom(true);
    self.listbox.itemheight = 110;
    self.listbox.doDrawItem = ServerList.drawMap;
    self.listbox:setOnMouseDoubleClick(self, ServerList.clickNext);
    self.listbox:setOnMouseDownFunction(self, ServerList.onClickServer);
    self.listbox.onJoypadDown = ServerList.onJoypadDown_ListBox
    self.listbox.onJoypadDirRight = ServerList.onJoypadDirRight_ListBox
    self.listbox.drawBorder = true
    self.listbox.lockTexture = getTexture("media/ui/inventoryPanes/Button_Lock.png")
    self:addChild(self.listbox);

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
    self.scrollPanel.onGainJoypadFocus = ServerList.onGainJoypadFocus_RightPanel
    self.scrollPanel.onLoseJoypadFocus = ServerList.onLoseJoypadFocus_RightPanel
    self.scrollPanel.onJoypadDown = ServerList.onJoypadDown_RightPanel
    self.scrollPanel.onJoypadDirLeft = ServerList.onJoypadDirLeft_RightPanel
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

    self.serverNameEntry = ISTextEntryBox:new("", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
    self.serverNameEntry:initialise();
    self.serverNameEntry:instantiate();
    self.serverNameEntry:setAnchorLeft(false);
    self.serverNameEntry:setAnchorRight(true);
    self.serverNameEntry:setAnchorTop(true);
    self.serverNameEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.serverNameEntry);
    table.insert(self.entryBoxes, self.serverNameEntry)

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

    self.serverEntry = ISTextEntryBox:new("127.0.0.1", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
    self.serverEntry:initialise();
    self.serverEntry:instantiate();
    self.serverEntry:setAnchorLeft(false);
    self.serverEntry:setAnchorRight(true);
    self.serverEntry:setAnchorTop(true);
    self.serverEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.serverEntry);
    table.insert(self.entryBoxes, self.serverEntry)

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    if getSteamModeActive() then
        self.localIPLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_LocalIP"), 1, 1, 1, 1, UIFont.Medium, true);
        self.localIPLabel:initialise();
        self.localIPLabel:instantiate();
        self.localIPLabel:setAnchorLeft(false);
        self.localIPLabel:setAnchorRight(true);
        self.localIPLabel:setAnchorTop(true);
        self.localIPLabel:setAnchorBottom(false);
        self.scrollPanel:addChild(self.localIPLabel);
        y = y + labelHgt + gapLabelY;

        self.localIPEntry = ISTextEntryBox:new("", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
        self.localIPEntry:initialise();
        self.localIPEntry:instantiate();
        self.localIPEntry:setAnchorLeft(false);
        self.localIPEntry:setAnchorRight(true);
        self.localIPEntry:setAnchorTop(true);
        self.localIPEntry:setAnchorBottom(false);
        self.localIPEntry:setTooltip(getText("UI_servers_LocalIP_tt"))
        self.scrollPanel:addChild(self.localIPEntry);
        table.insert(self.entryBoxes, self.localIPEntry)
        y = y + BUTTON_HGT + UI_BORDER_SPACING;
    end

    self.portLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_Port"), 1, 1, 1, 1, UIFont.Medium, true);
    self.portLabel:initialise();
    self.portLabel:instantiate();
    self.portLabel:setAnchorLeft(false);
    self.portLabel:setAnchorRight(true);
    self.portLabel:setAnchorTop(true);
    self.portLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.portLabel);

    y = y + labelHgt + gapLabelY;

    self.portEntry = ISTextEntryBox:new("16261", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
    self.portEntry:initialise();
    self.portEntry:instantiate();
    self.portEntry:setAnchorLeft(false);
    self.portEntry:setAnchorRight(true);
    self.portEntry:setAnchorTop(true);
    self.portEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.portEntry);
    table.insert(self.entryBoxes, self.portEntry)

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

    self.serverPasswordEntry = ISTextEntryBox:new("", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
    self.serverPasswordEntry:initialise();
    self.serverPasswordEntry:instantiate();
    self.serverPasswordEntry:setAnchorLeft(false);
    self.serverPasswordEntry:setAnchorRight(true);
    self.serverPasswordEntry:setAnchorTop(true);
    self.serverPasswordEntry:setAnchorBottom(false);
    self.serverPasswordEntry:setMasked(true);
    self.serverPasswordEntry:setTooltip(getText("UI_servers_serverpwd_tt"))
    self.scrollPanel:addChild(self.serverPasswordEntry);
    table.insert(self.entryBoxes, self.serverPasswordEntry)

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

-- Steam ID label/field
--[[

    self.steamIdLabel = ISLabel:new(labelX, y, labelHgt, "Steam ID", 1, 1, 1, 1, UIFont.Medium, true);
    self.steamIdLabel:initialise();
    self.steamIdLabel:instantiate();
    self.steamIdLabel:setAnchorLeft(false);
    self.steamIdLabel:setAnchorRight(true);
    self.steamIdLabel:setAnchorTop(true);
    self.steamIdLabel:setAnchorBottom(false);
    self.steamIdLabel:setVisible(false);
    self:addChild(self.steamIdLabel);

    y = y + labelHgt + gapLabelY;

    self.steamIdEntry = ISTextEntryBox:new("", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
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

    self.descEntry = ISTextEntryBox:new("", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
    self.descEntry:initialise();
    self.descEntry:instantiate();
    self.descEntry:setAnchorLeft(false);
    self.descEntry:setAnchorRight(true);
    self.descEntry:setAnchorTop(true);
    self.descEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.descEntry);
    self.descEntry:setMultipleLine(true)
    self.descEntry:setMaxLines(20)
    table.insert(self.entryBoxes, self.descEntry)

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

--    self.usernameLabel = ISLabel:new(labelX, y, 50, getText("UI_servers_username") .. ": ", 1, 1, 1, 1, UIFont.Medium, true);
    self.usernameLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_username"), 1, 1, 1, 1, UIFont.Medium, true);
    self.usernameLabel:initialise();
    self.usernameLabel:instantiate();
    self.usernameLabel:setAnchorLeft(false);
    self.usernameLabel:setAnchorRight(true);
    self.usernameLabel:setAnchorTop(true);
    self.usernameLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.usernameLabel);

    y = y + labelHgt + gapLabelY;

    self.usernameEntry = ISTextEntryBox:new("", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
    self.usernameEntry:initialise();
    self.usernameEntry:instantiate();
    self.usernameEntry:setAnchorLeft(false);
    self.usernameEntry:setAnchorRight(true);
    self.usernameEntry:setAnchorTop(true);
    self.usernameEntry:setAnchorBottom(false);
    self.scrollPanel:addChild(self.usernameEntry);
    table.insert(self.entryBoxes, self.usernameEntry)

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

--    self.passwordLabel = ISLabel:new(labelX, y, 50, getText("UI_servers_pwd") .. ": ", 1, 1, 1, 1, UIFont.Medium, true);
	self.authTypeLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_auth_type"), 1, 1, 1, 1, UIFont.Medium, true);
    self.authTypeLabel:initialise();
    self.authTypeLabel:instantiate();
    self.authTypeLabel:setAnchorLeft(false);
    self.authTypeLabel:setAnchorRight(true);
    self.authTypeLabel:setAnchorTop(true);
    self.authTypeLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.authTypeLabel);

    y = y + labelHgt + gapLabelY;

    self.authType = ISComboBox:new(entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
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
    table.insert(self.entryBoxes, self.authType)


    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    self.passwordLabel = ISLabel:new(entryX, y, labelHgt, getText("UI_servers_pwd"), 1, 1, 1, 1, UIFont.Medium, true);
    self.passwordLabel:initialise();
    self.passwordLabel:instantiate();
    self.passwordLabel:setAnchorLeft(false);
    self.passwordLabel:setAnchorRight(true);
    self.passwordLabel:setAnchorTop(true);
    self.passwordLabel:setAnchorBottom(false);
    self.scrollPanel:addChild(self.passwordLabel);

    y = y + labelHgt + gapLabelY;

    self.passwordEntry = ISTextEntryBox:new("", entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT);
    self.passwordEntry:initialise();
    self.passwordEntry:instantiate();
    self.passwordEntry:setAnchorLeft(false);
    self.passwordEntry:setAnchorRight(true);
    self.passwordEntry:setAnchorTop(true);
    self.passwordEntry:setAnchorBottom(false);
    self.passwordEntry:setMasked(true);
    self.passwordEntry:setTooltip(getText("UI_servers_pwd_tt"))
    self.scrollPanel:addChild(self.passwordEntry);
    table.insert(self.entryBoxes, self.passwordEntry)

    self.passwordWasFocused = false;
    self.firstAddServer = true;
    self.passwordText = "";

    y = y + BUTTON_HGT + UI_BORDER_SPACING;

    self.rememberPasswordTickBox = ISTickBox:new(entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT,"");
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
    table.insert(self.entryBoxes, self.rememberPasswordTickBox)

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

        self.connectTypeEntry = ISTickBox:new(entryX, y, self.scrollPanel.width-SCROLLBAR_SPACING, BUTTON_HGT, "");
        self.connectTypeEntry:addOption(getText("UI_servers_useSteamRelay"), 1)
        self.connectTypeEntry.choicesColor = {r=1, g=1, b=1, a=1}
        self.connectTypeEntry:initialise();
        self.connectTypeEntry:instantiate();
        self.connectTypeEntry:setAnchorLeft(false);
        self.connectTypeEntry:setAnchorRight(true);
        self.connectTypeEntry:setAnchorTop(true);
        self.connectTypeEntry:setAnchorBottom(false);
        self.scrollPanel:addChild(self.connectTypeEntry);
        table.insert(self.entryBoxes, self.connectTypeEntry)

        y = y + BUTTON_HGT + UI_BORDER_SPACING;
    end
    y = y + UI_BORDER_SPACING

    local saveEraseBtnWidth = UI_BORDER_SPACING*2 + math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_erase")),
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_save"))
    )

    self.eraseBtn = ISButton:new(entryX, y, saveEraseBtnWidth, BUTTON_HGT, getText("UI_servers_erase"), self, ServerList.onOptionMouseDown);
    self.eraseBtn.internal = "ERASE";
    self.eraseBtn:initialise();
    self.eraseBtn:instantiate();
    self.eraseBtn:setAnchorLeft(false);
    self.eraseBtn:setAnchorRight(true);
    self.eraseBtn:setAnchorTop(false);
    self.eraseBtn:setAnchorBottom(false);
    self.eraseBtn:enableCancelColor()
    self.scrollPanel:addChild(self.eraseBtn);

    self.addBtn = ISButton:new(self.scrollPanel.width - saveEraseBtnWidth - SCROLLBAR_SPACING, y, saveEraseBtnWidth, BUTTON_HGT, getText("UI_servers_add"), self, ServerList.onOptionMouseDown);
    self.addBtn.internal = "ADD";
    self.addBtn:initialise();
    self.addBtn:instantiate();
    self.addBtn:setAnchorLeft(false);
    self.addBtn:setAnchorRight(true);
    self.addBtn:setAnchorTop(false);
    self.addBtn:setAnchorBottom(false);
    self.addBtn:enableAcceptColor()
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

    if self.scrollPanel:getScrollHeight() < self.scrollPanel.height then
        SCROLLBAR_SPACING = 0
    else
        SCROLLBAR_SPACING = SCROLLBAR_WIDTH + UI_BORDER_SPACING
    end

    self.addBtn:setX(self.scrollPanel.width - self.addBtn.width - SCROLLBAR_SPACING)
    for _,ui in ipairs(self.entryBoxes) do
        ui:setWidth(self.scrollPanel.width - SCROLLBAR_SPACING)
    end

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

    local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
    self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height-BUTTON_HGT-UI_BORDER_SPACING-1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, ServerList.onOptionMouseDown);
    self.backButton.internal = "BACK";
    self.backButton:initialise();
    self.backButton:instantiate();
    self.backButton:setAnchorLeft(true);
    self.backButton:setAnchorTop(false);
    self.backButton:setAnchorBottom(true);
    self.backButton:enableCancelColor()
    self:addChild(self.backButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_publicServer"))
    self.publicBtn = ISButton:new(self.backButton:getRight() + UI_BORDER_SPACING, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_servers_publicServer"), self, ServerList.onOptionMouseDown);
    self.publicBtn.internal = "PUBLICSERVERS";
    self.publicBtn:initialise();
    self.publicBtn:instantiate();
    self.publicBtn:setAnchorLeft(true);
    self.publicBtn:setAnchorRight(false);
    self.publicBtn:setAnchorTop(false);
    self.publicBtn:setAnchorBottom(true);

    if false and isPublicServerListAllowed() then
        self:addChild(self.publicBtn);
    end

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_refresh"))
    self.refreshBtn = ISButton:new(self.publicBtn:getRight() + UI_BORDER_SPACING, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_servers_refresh"), self, ServerList.onOptionMouseDown);
    self.refreshBtn.internal = "REFRESH";
    self.refreshBtn:initialise();
    self.refreshBtn:instantiate();
    self.refreshBtn:setAnchorLeft(true);
    self.refreshBtn:setAnchorRight(false);
    self.refreshBtn:setAnchorTop(false);
    self.refreshBtn:setAnchorBottom(true);
    if getSteamModeActive() then
        self:addChild(self.refreshBtn);
    end

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_joinServer"))
    self.playButton = ISButton:new(self.listbox.x + self.listbox.width - btnWidth, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_servers_joinServer"), self, ServerList.onOptionMouseDown);
    self.playButton.internal = "NEXT";
    self.playButton:initialise();
    self.playButton:instantiate();
    self.playButton:setAnchorLeft(false);
    self.playButton:setAnchorRight(true);
    self.playButton:setAnchorTop(false);
    self.playButton:setAnchorBottom(true);
    self.playButton:enableAcceptColor()
    self:addChild(self.playButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_register_QR"))
    self.registerBtn = ISButton:new(self.playButton.x - UI_BORDER_SPACING - btnWidth, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_servers_register_QR"), self, ServerList.onOptionMouseDown);
    self.registerBtn.internal = "REGISTER";
    self.registerBtn:initialise();
    self.registerBtn:instantiate();
    self.registerBtn:setAnchorLeft(false);
    self.registerBtn:setAnchorRight(true);
    self.registerBtn:setAnchorTop(false);
    self.registerBtn:setAnchorBottom(true);
    self:addChild(self.registerBtn);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_delete"))
    self.deleteBtn = ISButton:new(self.registerBtn.x - UI_BORDER_SPACING - btnWidth, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_servers_delete"), self, ServerList.onOptionMouseDown);
    self.deleteBtn.internal = "DELETE";
    self.deleteBtn:initialise();
    self.deleteBtn:instantiate();
    self.deleteBtn:setAnchorLeft(false);
    self.deleteBtn:setAnchorRight(true);
    self.deleteBtn:setAnchorTop(false);
    self.deleteBtn:setAnchorBottom(true);
    self.deleteBtn:enableCancelColor()
    self:addChild(self.deleteBtn);

    self.getModBtn = ISButton:new(self.listbox.x + self.listbox.width/2, self.backButton.y, btnWidth, BUTTON_HGT, "GET THE MOD", self, ServerList.onOptionMouseDown);
    self.getModBtn.internal = "GETMOD";
    self.getModBtn:initialise();
    self.getModBtn:instantiate();
    self.getModBtn:setAnchorLeft(false);
    self.getModBtn:setAnchorRight(true);
    self.getModBtn:setAnchorTop(false);
    self.getModBtn:setAnchorBottom(true);
    self:addChild(self.getModBtn);
    self.getModBtn:setVisible(false);
	
	--self:insertNewLineOfButtons(self.listbox);
	--self:insertNewLineOfButtons(self.backButton, self.playButton);

    self:refreshList()
    if #self.listbox.items > 0 then
        self:fillFields(self.listbox.items[self.listbox.selected].item.server);
    end
end

function ServerList:onMouseDown_Tabs(x, y)
    if self:getMouseY() >= 0 and self:getMouseY() < self.tabHeight then
        local tabIndex = self:getTabIndexAtX(self:getMouseX())
        if tabIndex == 2 then
            MainScreen.instance.serverList:setVisible(false)
            MainScreen.instance.joinPublicServer:setVisible(true, JoypadState.getMainMenuJoypad())
            if getTimestamp() - PublicServerList.refreshTime >= 60 then
                MainScreen.instance.joinPublicServer:refreshList()
            end
        end
    end
end

function ServerList:prerender()
    ServerList.instance = self
    self.listbox.doDrawItem = self.drawMap

    ISPanelJoypad.prerender(self);

--    self:drawTextCentre( getText("UI_servers_serverlist"), self.width / 2 - 100, 10, 1, 1, 1, 1, UIFont.Large);

    self:drawTextCentre(getText("UI_servers_addToFavorite"), self.scrollPanel:getX() + self.scrollPanel:getWidth() / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Large);


    if self.listbox.selected ~= -1 and #self.listbox.items > 0 then
        self.deleteBtn:setEnable(true);
    else
        self.deleteBtn:setEnable(false);
    end

    local fieldsOK = self:checkFields()

    local find = false;

    for i,v in ipairs(self.listbox.items) do
        if v.item.server:getName() == self.serverNameEntry:getText() then
            find = true;
            break;
        end
    end

    if find then
        self.firstAddServer = true;
        self.authType:setEnabled(false)
        self.addBtn.title = getText("UI_servers_save");
        self.addBtn.internal = "SAVE";
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
        end
    else
        if self.firstAddServer then
            self.firstAddServer = false;
            self.passwordEntry:setText("");
        end
        self.authType:setEnabled(true)
        self.addBtn.title = getText("UI_servers_add");
        self.addBtn.internal = "ADD";
        self.registerBtn:setVisible(false);
        self.registerBtn:setEnabled(false);
        self.passwordEntry:setMasked(true);
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

    if (getTimestamp() - ServerList.refreshTime) < ServerList.refreshInterval then
        self.refreshBtn:setEnable(false);
        self.refreshBtn:setTitle(getText("UI_servers_refresh") .. " " .. (ServerList.refreshInterval - math.floor(getTimestamp() - ServerList.refreshTime)));
    else
        self.refreshBtn:setEnable(true);
        self.refreshBtn:setTitle(getText("UI_servers_refresh"));
    end

    if self.joyfocus then
        self:setISButtonForA(self.playButton)
        self:setISButtonForB(self.backButton)
        self:setISButtonForX(self.refreshBtn)
        self:setISButtonForY(self.deleteBtn)
    else
        self.ISButtonA = nil
        self.ISButtonB = nil
        self.playButton:clearJoypadButton()
        self.backButton:clearJoypadButton()
        self.refreshBtn:clearJoypadButton()
        self.deleteBtn:clearJoypadButton()
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

function ServerList:onSendButton()
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

function ServerList:onCloseQRButton()
    self.googleAuthPopup.qrTexture = nil;
    self.googleAuthPopup:setVisible(false);
    self.googleAuthConnectLabel.name = ""
end

function ServerList:onOptionMouseDown(button, x, y)
    self.getModBtn:setVisible(false);
    if button.internal == "PUBLICSERVERS" then
        self:setVisible(false);
        MainScreen.instance.joinPublicServer:setVisible(true);
        if getTimestamp() - PublicServerList.refreshTime >= 60 then
            MainScreen.instance.joinPublicServer:refreshList();
        end
    end
    if button.internal == "BACK" then
--        getCore():ResetLua(true, "exitJoinServer")
        self:setVisible(false);
        MainScreen.instance.serverList:setVisible(false);
        MainScreen.instance.multiplayer:setVisible(true);
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            joypadData.focus = MainScreen.instance
            updateJoypadFocus(joypadData)
        end
        MainScreen.resetLuaIfNeeded()
    end
    if button.internal == "REFRESH" then
        -- Quick refresh updates player counts
        if getSteamModeActive() then
            for i=1,#self.listbox.items do
                local item = self.listbox.items[i]
                local server = item.item.server
                if server:getIp() and server:getIp() ~= "" and tonumber(server:getPort()) then
                    steamRequestServerDetails(server:getIp(), tonumber(server:getPort()))
                end
            end
        	ServerList.refreshTime = getTimestamp()
        end
    end
    if button.internal == "ADD" then
        if self:checkFields() then
            self:trimFields()
            local newServer = Server.new();
            newServer:setName(self.serverNameEntry:getText() or "");
            newServer:setIp(self.serverEntry:getText() or "");
            if getSteamModeActive() then
                newServer:setLocalIP(self.localIPEntry:getText() or "")
            end
--            newServer:setSteamId(self.steamIdEntry:getText() or "");
            newServer:setPort(self.portEntry:getText() or "");
            newServer:setServerPassword(self.serverPasswordEntry:getInternalText() or "")
            newServer:setDescription(self.descEntry:getText() or "");
            newServer:setUserName(self.usernameEntry:getText() or "");
            newServer:setPwd(self.passwordEntry:getInternalText() or "", true);
            newServer:setSavePwd(self.rememberPasswordTickBox:isSelected(1));
            newServer:setAuthType(self.authType:getSelected())
            if getSteamModeActive() then
                newServer:setUseSteamRelay(self.connectTypeEntry:isSelected(1));
            end
            self:addServerToList(newServer);
            getCustomizationData(newServer:getUserName(), newServer:getPwd(), newServer:getIp(), newServer:getPort(), newServer:getServerPassword(), newServer:getName(), false);
            self:writeServerOnFile(newServer, true);
            MainScreen.instance.multiplayer:refreshList();
        end
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
    if button.internal == "DELETE" then
        self.listbox:removeItem(self.listbox.items[self.listbox.selected].text);
        self:emptyServerFile()
        for i,v in ipairs(self.listbox.items) do
            self:writeServerOnFile(v.item.server, true);
        end
        MainScreen.instance.multiplayer:refreshList();
        self:erase();
        if #self.listbox.items > 0 then
            local item = self.listbox.items[self.listbox.selected]
            self:fillFields(item.item.server)
        end
    end
    if button.internal == "SAVE" then
        if not self:checkFields() then return end
        local oldServer = self.listbox.items[self.listbox.selected].item.server
        local hashPwd = true;
        if oldServer:isSavePwd() and oldServer:getPwd() == self.passwordText then
            hashPwd = false;
        end
        self.listbox:removeItem(self.serverNameEntry:getText());
        self:emptyServerFile()
        for i,v in ipairs(self.listbox.items) do
            self:writeServerOnFile(v.item.server, true);
        end
        MainScreen.instance.multiplayer:refreshList();
        self:trimFields()
        local newServer = Server.new();
        newServer:setName(self.serverNameEntry:getText() or "");
        newServer:setIp(self.serverEntry:getText() or "");
        if getSteamModeActive() then
            newServer:setLocalIP(self.localIPEntry:getText() or "")
        end
--        newServer:setSteamId(self.steamIdEntry:getText() or "");
        newServer:setPort(self.portEntry:getText() or "");
        newServer:setServerPassword(self.serverPasswordEntry:getInternalText() or "")
        newServer:setDescription(self.descEntry:getText() or "");
        newServer:setUserName(self.usernameEntry:getText() or "");

        newServer:setPwd(self.passwordText or "", hashPwd);
        newServer:setSavePwd(self.rememberPasswordTickBox:isSelected(1));
        newServer:setAuthType(self.authType:getSelected())
        newServer:setUseSteamRelay(getSteamModeActive() and self.connectTypeEntry:isSelected(1) or false);
        self:addServerToList(newServer);
        getCustomizationData(newServer:getUserName(), newServer:getPwd(), newServer:getIp(), newServer:getPort(), newServer:getServerPassword(), newServer:getName(), false);
        self:writeServerOnFile(newServer, true);
        MainScreen.instance.multiplayer:refreshList();
    end
    if button.internal == "NEXT" then
        self:clickNext();
    end
    if button.internal == "GETMOD" then
        openUrl(button.url);
    end
    self.listbox:sort();
end

function ServerList:checkFields()
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
    
--    self.steamIdEntry:setValid(true)

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
        self.usernameEntry:setTooltip(getText("UI_servers_notvalid_username"))
        if valid then
            tooltip = getText("UI_servers_err_username")
        end
        valid = false;
    end

	if valid then
		local intValid, intTooltip = self:canConnect();
		if not intValid then
			valid = false;
			tooltip = intTooltip;
		end
	end

    self.playButton:setEnable(valid and (self.listbox.selected > 0))
    self.playButton:setTooltip(tooltip)
    
    self.addBtn:setEnable(valid)
    self.addBtn:setTooltip(tooltip)
    
    return valid;
end

function ServerList:canConnect()
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

function ServerList:clickNext()
    if not self.playButton:isEnabled() then
        return;
    end
--    stopPing();
--    ServerList.pingIndex = 1;
--    if not self.passwordEntry:getInternalText() or self.passwordEntry:getInternalText() == "" then
--        local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - (250 / 2), (getCore():getScreenHeight() / 2) - (150 / 2), 250, 150, getText("UI_servers_needPwd"), false);
--        modal:initialise()
--        modal:addToUIManager()
--        modal:setAlwaysOnTop(true)
--        if self.joyfocus then
--            self.joyfocus.focus = modal
--            updateJoypadFocus(self.joyfocus)
--        end
--        return;
--    end
    stopSendSecretKey();
    getCore():setNoSave(false);
    local server = self.listbox.items[self.listbox.selected].item.server
    local localIP = getSteamModeActive() and self.localIPEntry:getText() or ""
    local useSteamRelay = getSteamModeActive() and self.connectTypeEntry.selected[1]
    local doHash = true;
    if self.passwordEntry:isFocused() then
        self.passwordText = self.passwordEntry:getInternalText();
    end
    if server:isSavePwd() and server:getPwd() == self.passwordText then
        doHash = false;
    end
    ConnectToServer.instance:connect(self, server:getName(), self.usernameEntry:getText(), self.passwordText,
        self.serverEntry:getText(), localIP, self.portEntry:getText(), self.serverPasswordEntry:getInternalText(), useSteamRelay, doHash, self.authType:getSelected());
end

function ServerList:emptyServerFile(server, append)
    local fileOutput = getFileWriter(getServerListFile(), false, false)
    fileOutput:close();
end

function ServerList:writeServerOnFile(server, append)
    local fileOutput = getFileWriter(getServerListFile(), true, append);
    fileOutput:write("name=" .. server:getName() .. "\r\n");
    fileOutput:write("ip=" .. server:getIp() .. "\r\n");
    if getSteamModeActive() then
        fileOutput:write("localip=" .. server:getLocalIP() .. "\r\n");
    end
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

function ServerList:erase()
    self.serverNameEntry:setText("");
    self.serverEntry:setText("127.0.0.1");
    self.portEntry:setText("16261");
    self.serverPasswordEntry:setText("");
    self.descEntry:setText("");
    self.usernameEntry:setText("");
    self.passwordEntry:setText("");
    self.passwordText = "";
    self.rememberPasswordTickBox:setSelected(1,false);
    self.authType:setSelected(1);
--    self.steamIdEntry:setText("");
    if getSteamModeActive() then
        self.connectTypeEntry.selected[1] = false;
    end
end

function ServerList:onClickServer(item)
    self:fillFields(item.server);

    if getSteamModeActive() and item.responded then
        steamRequestServerDetails(item.server:getIp(), tonumber(item.server:getPort()))
    end
end

function ServerList:fillFields(item)
    self.serverNameEntry:setText(item:getName());
    self.serverEntry:setText(item:getIp());
    if getSteamModeActive() then
        self.localIPEntry:setText(item:getLocalIP());
    end
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

function ServerList:trimFields(item)
    self.serverNameEntry:setText(self.serverNameEntry:getText():trim());
    self.serverEntry:setText(self.serverEntry:getText():trim());
    if getSteamModeActive() then
        self.localIPEntry:setText(self.localIPEntry:getText():trim());
    end
--    self.steamIdEntry:setText(self.steamIdEntry:getText():trim());
    self.portEntry:setText(self.portEntry:getText():trim());
    self.serverPasswordEntry:setText(self.serverPasswordEntry:getInternalText():trim())
    self.descEntry:setText(self.descEntry:getText():trim());
    self.usernameEntry:setText(self.usernameEntry:getText():trim());
    self.passwordEntry:setText(self.passwordEntry:getInternalText():trim());
end

function ServerList:drawMap(y, item, alt)
    local server = item.item.server
    local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15);
    elseif isMouseOver then
        self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.95, 0.05, 0.05, 0.05);
    end
    self:drawRectBorder(0, (y), self:getWidth(), item.height-1, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

--    local connection = "Off";
--    if ServerList.pingedList[server:getIp()] ~= nil then
--        connection = "On";
--    end
    local dx = 0
    if server:isPasswordProtected() then
        dx = self.lockTexture:getWidth() + 8
        local largeFontHgt = getTextManager():getFontFromEnum(UIFont.Large):getLineHeight()
        self:drawTexture(self.lockTexture, 20, y + 15 + (largeFontHgt - self.lockTexture:getHeight()) / 2, 1, 1, 1, 1)
    end
    self:drawText(server:getName() .. " (" .. server:getIp() .. ":" .. server:getPort() .. ") ", 20+dx, y+15, 0.9, 0.9, 0.9, 0.9, UIFont.Large);

    if server:getUserName() and server:getUserName() ~= "" then
        self:drawText(getText("UI_servers_LogAs") .. server:getUserName(), 20, y+50, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    end

    local richText = item.item.richText
    if richText:getWidth() ~= self:getWidth() - 17 then
        richText:setWidth(self:getWidth() - 17)
        richText:paginate()
    end
    local yy = y + 70
    richText:render(0, yy, self)
    yy = yy + richText:getHeight()

    local smallFontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
    if item.item.responded then
        if server:isOpen() then
            self:drawText(getText("UI_servers_WhitelistOff"), 20, yy, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
        else
            self:drawText(getText("UI_servers_WhitelistOn"), 20, yy, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
        end
        self:drawText(getText("UI_servers_Ping", server:getPing()), 20, yy+smallFontHgt, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
        self:drawText(getText("UI_servers_players") .. server:getPlayers() .. " / " .. server:getMaxPlayers(), self:getWidth()  / 2, yy, 0.9, 0.9, 0.9, 0.9, UIFont.Small)
        local version = server:getVersion() or "???"
        self:drawText(getText("UI_servers_version") .. version, self:getWidth()  / 2, yy+smallFontHgt, 0.9, 0.9, 0.9, 0.9, UIFont.Small)
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
    elseif getSteamModeActive() then
        self:drawText(getText("UI_servers_not_responding"), 20, yy, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
        yy = yy + FONT_HGT_SMALL
    end

    if ServerList.pingedList[server:getIp()] ~= nil then
        self:drawText("Users : " .. ServerList.pingedList[server:getIp()].users, 20, y+70, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    end

    self.itemheightoverride[item.text] = yy + 12 - y

    y = y + self.itemheightoverride[item.text];

    return y;
end

function ServerList:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:setISButtonForA(self.playButton)
    self:setISButtonForB(self.backButton)
end

function ServerList:onJoypadDown(button, joypadData)
    if button == Joypad.RBumper then
        if not isPublicServerListAllowed() then return end
        MainScreen.instance.serverList:setVisible(false)
        MainScreen.instance.joinPublicServer:setVisible(true, joypadData)
        if getTimestamp() - PublicServerList.refreshTime >= 60 then
            MainScreen.instance.joinPublicServer:refreshList()
        end
        return
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ServerList:onJoypadDirUp(joypadData)
--	joypadData.focus = self.listbox
    self.listbox:setJoypadFocused(true, joypadData)
end

function ServerList:onJoypadDirDown(joypadData)
end

-----

function ServerList:onJoypadDown_ListBox(button, joypadData)
    if button == Joypad.AButton then
        
    end
    if button == Joypad.BButton then
        self:setJoypadFocused(false, joypadData)
        joypadData.focus = self.parent
    end
    if button == Joypad.RBumper then
        self.parent:onJoypadDown(button, joypadData)
    end
end

function ServerList:onJoypadDirRight_ListBox(joypadData)
    self:setJoypadFocused(false, joypadData)
    joypadData.focus = self.parent.scrollPanel
end

-----

function ServerList:onGainJoypadFocus_RightPanel(joypadData)
    self:restoreJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
end

function ServerList:onLoseJoypadFocus_RightPanel(joypadData)
    self:clearJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function ServerList:onJoypadDown_RightPanel(button, joypadData)
    if (button == Joypad.BButton) and not self:isFocusOnControl() then
        joypadData.focus = self.parent
        return
    end
    if button == Joypad.RBumper then
        self.parent:onJoypadDown(button, joypadData)
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ServerList:onJoypadDirLeft_RightPanel(joypadData)
    if self.joypadIndex == 1 then
        joypadData.focus = self.parent.listbox
        self.parent.listbox:setJoypadFocused(true, joypadData)
        return
    end
    ISPanelJoypad.onJoypadDirLeft(self, joypadData)
end

-----

function ServerList:initialise()
    ISPanelJoypad.initialise(self);
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function ServerList:instantiate()
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

function ServerList:onResolutionChange(oldw, oldh, neww, newh)
    local fontScale = FONT_HGT_SMALL / 15
    local entrySize = 200 * fontScale;
    local listX = UI_BORDER_SPACING+1
    local listWid = self.width - UI_BORDER_SPACING*2 - entrySize - listX
    self.listbox:setWidth(math.max(listWid, 200))
    self.tabs:setWidth(math.max(listWid, 200))

    if self.scrollPanel:getScrollHeight() < self.scrollPanel.height then
        SCROLLBAR_SPACING = 0
    else
        SCROLLBAR_SPACING = SCROLLBAR_WIDTH + UI_BORDER_SPACING
    end

    self.addBtn:setX(self.scrollPanel.width - self.addBtn.width - SCROLLBAR_SPACING)
    for _,ui in ipairs(self.entryBoxes) do
        ui:setWidth(self.scrollPanel.width - SCROLLBAR_SPACING)
    end
end


function ServerList:new(x, y, width, height)
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
    o.entryBoxes = {}
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    ServerList.instance = o;
    o.NoLabel = false;
    o.anchorBottom = false;
    return o;
end

function ServerList.onResetLua(reason)
	if reason == "ConnectedToServer" then
        reactivateJoypadAfterResetLua()
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            joypadData.focus = nil
            joypadData.lastfocus = nil
            JoypadState.forceActivate = joypadData.id
        end
		if DebugScenarios.instance ~= nil then
			MainScreen.instance:removeChild(DebugScenarios.instance)
			DebugScenarios.instance = nil
		end
		MainScreen.instance.bottomPanel:setVisible(false);
	end
end

function ServerList:OnConnectFailed(message, detail)
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

function ServerList:OnConnected()
    if self.googleAuthConnectLabel then
        self.googleAuthConnectLabel.text = getText("UI_servers_QR_sending_key")
        self.googleAuthConnectLabel.text = " <CENTRE> " .. self.googleAuthConnectLabel.text
        self.googleAuthConnectLabel:paginate()
        self.googleAuthConnectLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthConnectLabel.width/2);
    end
end

function ServerList:OnQRReceived(message)
    if self.googleAuthConnectLabel then
        self.googleAuthConnectLabel.text = message --getText("UI_servers_QR_send_success")
        self.googleAuthConnectLabel.text = " <CENTRE> " .. self.googleAuthConnectLabel.text
        self.googleAuthConnectLabel:paginate()
        self.googleAuthConnectLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthConnectLabel.width/2);
        stopSendSecretKey();
    end
end

function OnConnectFailed(message, detail)
    ServerList.instance:OnConnectFailed(message,detail)
end

function OnConnected()
    ServerList.instance:OnConnected()
end

local function OnQRReceived(message)
	ServerList.instance:OnQRReceived(message)
end

Events.OnQRReceived.Add(OnQRReceived)
Events.OnConnectFailed.Add(OnConnectFailed)
Events.OnDisconnect.Add(OnConnectFailed)
Events.OnConnected.Add(OnConnected)
Events.OnResetLua.Add(ServerList.onResetLua)

ServerList.pingIndex = 1;

function ServerList:pingServers(init)
    -- Both ServerList and PublicServerList have Events.ServerPinged callbacks
    if not ServerList.instance:getIsVisible() then return end

--    if init then
--        ServerList.pingedList = {};
--        ServerList.pingIndex = 1;
--    end
--    if ServerList.pingIndex <= #self.listbox.items then
--       local v = self.listbox.items[ServerList.pingIndex];
--        if v then
--            ServerList.pingIndex = ServerList.pingIndex + 1;
--            ping(v.item.server:getUserName(), v.item.server:getPwd(), v.item.server:getIp(), v.item.server:getPort());
--        end
--    else
--        stopPing();
--    end
end

function ServerList:setServerDescription(item)
    local text = item.server:getDescription()
    text = text:gsub("<", "&lt"):gsub(">", "&gt")
    text = text:gsub("\\n", "\n")
    text = " <RGB:0.8,0.8,0.8> " .. text
    item.richText:setText(text)
    item.richText:paginate()
end

function ServerList:countMods(modString)
    local totalMods = 0
    local list = luautils.split(modString, ",")
    for _,modID in ipairs(list) do
        if #string.trim(modID) > 0 then
            totalMods = totalMods + 1
        end
    end
    return totalMods
end

function ServerList:setServerMods(item)
    if item.server:getMods() and item.server:getMods() ~= "" then
        local mods = item.server:getMods()
        local modCount = nil
        if getSteamModeActive() then
            mods = mods:gsub(";", ",")
            modCount = item.rules and tonumber(item.rules.modCount) or nil
        end
        mods = mods:gsub(",", ", ")
        local text = getText("UI_servers_mods") .. mods:gsub(";", ", "):gsub("<", "&lt"):gsub(">", "&gt")
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

function ServerList:addServerToList(server)
    local item = {}
    item.server = server
    
    item.richText = ISRichTextLayout:new(self:getWidth()-17)
    item.richText:initialise()
    self:setServerDescription(item)

    self:setServerMods(item)

    if getSteamModeActive() then
        item.responded = false
        item.rules = nil
    end
    
    self.listbox:addItem(server:getName(), item);
	self.listbox.selected = #self.listbox.items;
end

function ServerList:refreshList()
    self.listbox:clear()
    local servers = getServerList();
    local needSave = false
    for _,server in ipairs(servers) do
        if server:getNeedSave() then
            needSave = true
        end
        self:addServerToList(server)
        if getSteamModeActive() and tonumber(server:getPort()) then
            steamRequestServerDetails(server:getIp(), tonumber(server:getPort()))
        end
    end
    self.listbox:sort()
    if needSave then
        self:emptyServerFile()
        for _,server in ipairs(servers) do
            self:writeServerOnFile(server, true);
        end
        MainScreen.instance.multiplayer:refreshList();
    end
end

ServerList.ServerPinged = function(ip, users)
--    if ServerList.pingedList[ip] == nil then
--        ServerList.pingedList[ip] = {};
--    end
--    ServerList.pingedList[ip].users = users;
--    forceDisconnect();
--    ServerList.instance:pingServers(false);
end

function ServerList.OnSteamServerResponded2(host, port, server2)
--    print('OnSteamServerResponded2 ' .. host .. ' ' .. tostring(port))
    local self = ServerList.instance
    local items = self.listbox.items
    for i=1,#items do
        local server = items[i].item.server
        if server:getIp() == host and server:getPort() == tostring(port) then
            items[i].item.responded = true
            server:setPing(server2:getPing())
            server:setPlayers(server2:getPlayers())
            server:setMaxPlayers(server2:getMaxPlayers())
            server:setMods(server2:getMods())
            server:setPasswordProtected(server2:isPasswordProtected())
--            self:setServerMods(items[i].item)
            if i == self.listbox.selected then
                self:fillFields(server)
            end
        end
    end
    steamRequestServerRules(host, port)
end

function ServerList.OnSteamServerFailedToRespond2(host, port)
    local self = ServerList.instance
    local items = self.listbox.items
    for i=1,#items do
        local server = items[i].item.server
        if server:getIp() == host and server:getPort() == tostring(port) then
            items[i].item.responded = false
        end
    end
end

function ServerList.OnSteamRulesRefreshComplete(host, port, rules)
--    print('OnSteamRulesRefreshComplete ' .. host .. ' ' .. tostring(port))
    local self = ServerList.instance
    local items = self.listbox.items
    for i=1,#items do
        local server = items[i].item.server
        if server:getIp() == host and server:getPort() == tostring(port) then
            items[i].item.rules = rules
            if rules.description then
                server:setDescription(rules.description)
                self:setServerDescription(items[i].item)
            end
            if rules.version then
                server:setVersion(rules.version)
            end
            if i == self.listbox.selected then
                self:fillFields(server)
            end
            server:setOpen(rules.open == "1")
            if rules.mods then
                server:setMods(rules.mods)
            end
            self:setServerMods(items[i].item)
        end
    end
end

function ServerList:onJoypadBeforeDeactivate(joypadData)
    self.backButton:clearJoypadButton()
    self.playButton:clearJoypadButton()
end

Events.ServerPinged.Add(ServerList.ServerPinged);
if getSteamModeActive() then
    LuaEventManager.AddEvent("OnSteamServerResponded2")
    LuaEventManager.AddEvent("OnSteamServerFailedToRespond2")
    LuaEventManager.AddEvent("OnSteamRulesRefreshComplete")
    Events.OnSteamServerResponded2.Add(ServerList.OnSteamServerResponded2)
    Events.OnSteamServerFailedToRespond2.Add(ServerList.OnSteamServerFailedToRespond2)
    Events.OnSteamRulesRefreshComplete.Add(ServerList.OnSteamRulesRefreshComplete)
end
