require "ISUI/ISPanelJoypad"

ISMPEditAccount = ISPanelJoypad:derive("ISMPEditAccount");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local ENTRY_HGT = FONT_HGT_SMALL + 3 * 2
local COMBO_HGT = FONT_HGT_SMALL + 3 * 2
local TICKBOX_HGT = FONT_HGT_SMALL + 3 * 2

function ISMPEditAccount:initialise()
	ISPanel.initialise(self);

    self.login = ISTextEntryBox:new("", 59, UI_BORDER_SPACING + FONT_HGT_MEDIUM, 322, ENTRY_HGT);
    self.login.font = UIFont.Medium
    self.login:initialise();
    self.login:instantiate();
    self.login.onTextChange = ISMPEditAccount.onLoginTextChange;
    self.login.onOtherKey = ISMPEditAccount.onOtherKey
    self.login.onCommandEntered = ISMPEditAccount.onCommandEntered;
    self.login.target = self;
    self:addChild(self.login);

    self.authType = ISComboBox:new(59, self.login:getBottom() + UI_BORDER_SPACING + FONT_HGT_MEDIUM, 322, COMBO_HGT, self, self.onComboAuthType);
    self.authType.internal = "AUTHTYPE";
    self.authType:initialise();
    self.authType:instantiate();
    self.authType.choicesColor = {r=1, g=1, b=1, a=1}
    self.authType:addOption(getText("UI_servers_auth_password"))
    self.authType.image = self.ui_droplist
    self:addChild(self.authType);

    self.password = ISTextEntryBox:new("", 59, self.authType:getBottom() + UI_BORDER_SPACING + FONT_HGT_MEDIUM, 322, ENTRY_HGT);
    self.password.font = UIFont.Medium
    self.password:initialise();
    self.password:instantiate();
    self.password:setMasked(true);
    self.password.onOtherKey = ISMPEditAccount.onOtherKey
    self.password.onCommandEntered = ISMPEditAccount.onCommandEntered;
    self.password.target = self;
    self:addChild(self.password);

    self.seePasswordBtn = ISButton:new(348, self.password.y, 33, BUTTON_HGT, "", self, ISMPEditAccount.onClick);
    self.seePasswordBtn.internal = "SEE";
    self.seePasswordBtn:setImage(self.ui_password_eye)
    self.seePasswordBtn:forceImageSize(22, 16)
    self.seePasswordBtn:initialise();
    self.seePasswordBtn:instantiate();
    self:addChild(self.seePasswordBtn);

    self.rememberPasswordTickBox = ISTickBox:new(59, self.password:getBottom() + UI_BORDER_SPACING, TICKBOX_HGT, TICKBOX_HGT, "");
    self.rememberPasswordTickBox.internal = "REMEMBER";
    self.rememberPasswordTickBox:initialise();
    self.rememberPasswordTickBox:instantiate();
    self.rememberPasswordTickBox.choicesColor = {r=1, g=1, b=1, a=1}
    self.rememberPasswordTickBox:addOption(getText("UI_servers_remember_password"))
    self.rememberPasswordTickBox:setSelected(1, true)
    self:addChild(self.rememberPasswordTickBox);

    local addBelow = self.rememberPasswordTickBox
    if getSteamModeActive() then
        self.steamRelayTickBox = ISTickBox:new(59, self.rememberPasswordTickBox:getBottom() + 4, TICKBOX_HGT, TICKBOX_HGT, "");
        self.steamRelayTickBox.internal = "STEAMRELAY";
        self.steamRelayTickBox:initialise();
        self.steamRelayTickBox:instantiate();
        self.steamRelayTickBox.choicesColor = {r=1, g=1, b=1, a=1}
        self.steamRelayTickBox:addOption(getText("UI_servers_useSteamRelay"))
        self:addChild(self.steamRelayTickBox);
        addBelow = self.steamRelayTickBox
    end

    self.googleAuthPopup = ISPanel:new(59-20, addBelow:getBottom() + UI_BORDER_SPACING, 322+40, 350);
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

    self.googleAuthLabel = ISLabel:new(0, 30, 18, getText("UI_servers_send_QR_Label"), 1, 1, 1, 1, UIFont.Medium, true);
    self.googleAuthLabel:initialise();
    self.googleAuthLabel:instantiate();
    self.googleAuthLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthLabel:getWidth()/2);
    self.googleAuthPopup:addChild(self.googleAuthLabel);

    self.googleAuthButton = ISButton:new(10, self.googleAuthPopup:getHeight()-52, 93, BUTTON_HGT, getText("UI_servers_send_QR"), self, ISMPEditAccount.onClick);
    self.googleAuthButton.internal = "QR";
    self.googleAuthButton:initialise();
    self.googleAuthButton:instantiate();
    self.googleAuthButton:enableAcceptColor()
    self.googleAuthPopup:addChild(self.googleAuthButton);

    self.googleAuthPopup.qrTexture = nil;
    self.googleAuthPopup.statusLabel = "";
    self.googleKey = ""
    self.googleAuthPopup.render = function(self)
        ISPanel.render(self)
        self:drawTextCentre(self.statusLabel, self.width / 2, 60, 1, 1.0, 1.0, 1, UIFont.Large);
        if self.qrTexture then
            self:drawTexture(self.qrTexture, self.width / 2 - self.qrTexture:getWidth()/2, 90, 1, 1, 1, 1)
        end
    end
    self.googleAuthPopup:setVisible(false);

    self.cancelBtn = ISButton:new(60, addBelow:getBottom() + UI_BORDER_SPACING, 93, BUTTON_HGT, getText("UI_servers_cancel"), self, ISMPEditAccount.onClick);
    self.cancelBtn.internal = "CANCEL";
    self.cancelBtn:initialise();
    self.cancelBtn:instantiate();
    self.cancelBtn:enableCancelColor()
    self:addChild(self.cancelBtn);

    self.saveBtn = ISButton:new(self:getWidth() - 60 - 93, self.cancelBtn.y, 93, BUTTON_HGT, getText("UI_servers_save"), self, ISMPEditAccount.onClick);
    self.saveBtn.internal = "SAVE";
    self.saveBtn:initialise();
    self.saveBtn:instantiate();
    self.saveBtn:enableAcceptColor()
    self:addChild(self.saveBtn);

    self:setHeight(self.saveBtn:getBottom() + UI_BORDER_SPACING)
    self.originalHeight = self.height

    if self.account then
        self.login:setText(self.account:getUserName())
        self.authType.selected = self.account:getAuthType()
        self.authType:setEnabled(self.account:getAuthType() == 1);
        self.password:setText("")
        self.rememberPasswordTickBox:setSelected(1, self.account:isSavePwd())
        if getSteamModeActive() then
            self.steamRelayTickBox:setSelected(1, self.account:getUseSteamRelay())
        end
        if self.account:isSavePwd() then
            self.isPasswordModified = false;
        end
    end

    self:onComboAuthType()

    self.servers_serveripmessage_lines = splitString(getText("UI_servers_serveripmessage"), 60)
    self.servers_serveripwarning_lines = splitString(getText("UI_servers_serveripwarning"), 60)

    ISMPEditAccount.instance = self

    self.login:focus()
end

function ISMPEditAccount:onComboAuthType()
    if self.authType.selected ~= 1 and self.authType:isEnabled() then
        self.googleKey = generateSecretKey();
        self.googleAuthPopup.qrTexture = createQRCodeTex(self.login:getInternalText():trim(),self.googleKey)
        self.googleAuthPopup:setVisible(true);
        self.googleAuthButton:setEnable(true)
        self.googleAuthButton:setX((self.googleAuthPopup:getWidth() - self.googleAuthButton:getWidth())/2);
        self:setHeight(self.originalHeight + self.googleAuthPopup.height + UI_BORDER_SPACING);
    else
        self:setHeight(self.originalHeight);
        self.googleAuthPopup:setVisible(false);
    end
    self.saveBtn:setY(self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT)
    self.cancelBtn:setY(self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT)
    self:setX ( (getCore():getScreenWidth() - self:getWidth()) / 2);
    self:setY ( (getCore():getScreenHeight() - self:getHeight()) / 2);
end

function ISMPEditAccount:destroy()
	self:setVisible(false);
	self:removeFromUIManager();
	if self.joyfocus and self.joyfocus.focus == self then
		self.joyfocus.focus = self.prevFocus
		updateJoypadFocus(self.joyfocus)
	end
    self.ui.screenShading:setVisible(false)
end

function ISMPEditAccount:onClick(button)
    if button.internal == "SEE" then
        self.password:setMasked(not self.password:isMasked());
        return
    end
    if button.internal == "QR" then
        local doHash = true;
        local password = self.password:getInternalText():trim()
        if self.account ~= nil and password == "" and self.account:isSavePwd() and self.isPasswordModified == false then
            password = self.account:getPwd()
            doHash = false;
        end
        self.googleAuthPopup.statusLabel = getText("UI_servers_QR_connecting")
        sendSecretKey(self.login:getInternalText():trim(), password, self.server:getIp(), self.server:getPort(), self.server:getServerPassword(), doHash, self.authType:getSelected(), self.googleKey);
        return
    end
    if button.internal == "SAVE" then
        local newAccount = self.account
        if newAccount then
            newAccount:setUserName(self.login:getInternalText():trim());
            if self.isPasswordModified and self.rememberPasswordTickBox:isSelected(1) then
                newAccount:encryptPwd(self.password:getInternalText():trim());
            end
            if self.account:isSavePwd() and not self.rememberPasswordTickBox:isSelected(1) then
                newAccount:setPwd("");
            end
            newAccount:setAuthType(self.authType.selected);
            if getSteamModeActive() then
                newAccount:setUseSteamRelay(self.steamRelayTickBox:isSelected(1))
            end
            newAccount:setSavePwd(self.rememberPasswordTickBox:isSelected(1))
            newAccount:setLastLogonNow()
            if not self.connectAfter then
                updateAccountToAccountList(newAccount)
            end
        else
            newAccount = Account.new();
            newAccount:setUserName(self.login:getInternalText():trim());
            newAccount:encryptPwd(self.password:getInternalText():trim());
            newAccount:setAuthType(self.authType.selected);
            if getSteamModeActive() then
                newAccount:setUseSteamRelay(self.steamRelayTickBox:isSelected(1))
            end
            newAccount:setSavePwd(self.rememberPasswordTickBox:isSelected(1))
            newAccount:setLastLogonNow()
            if not self.connectAfter then
                addAccountToAccountList(self.server, newAccount)
            end
        end

        self.ui:refreshList()
        if self.connectAfter then
            self.ui:connectToServer(self.server, newAccount);
        end
    end
    self:destroy();
    self.ui.modal = nil
end

function ISMPEditAccount:onResolutionChange(oldw, oldh, neww, newh)
    self:setX((neww - self:getWidth()) / 2)
    self:setY((newh - self:getHeight()) / 2)
end

function ISMPEditAccount:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawRectBorder(1, 1, self.width-2, self.height-2, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawText(getText("UI_servers_login"), 70, self.login.y - FONT_HGT_MEDIUM, 1, 1, 1, 1, UIFont.Medium);
	self:drawText(getText("UI_servers_authentication_type"), 70, self.authType.y - FONT_HGT_MEDIUM, 1, 1, 1, 1, UIFont.Medium);
	self:drawText(getText("UI_servers_password"), 70, self.password.y - FONT_HGT_MEDIUM, 1, 1, 1, 1, UIFont.Medium);

    if getSteamModeActive() then
        local useSteamRelay = self.steamRelayTickBox.selected[1]
        if (useSteamRelay) then
            self:drawTextCentre(self.servers_serveripmessage_lines[0], self.width / 2, self.height + UI_BORDER_SPACING, 0.9, 0.9, 0.9, 1, UIFont.Medium);
            self:drawTextCentre(self.servers_serveripmessage_lines[1], self.width / 2, self.height + UI_BORDER_SPACING + FONT_HGT_MEDIUM, 0.9, 0.9, 0.9, 1, UIFont.Medium);
        else
            self:drawTextCentre(self.servers_serveripwarning_lines[0], self.width / 2, self.height + UI_BORDER_SPACING, 0.9, 0.9, 0.9, 1, UIFont.Medium);
            self:drawTextCentre(self.servers_serveripwarning_lines[1], self.width / 2, self.height + UI_BORDER_SPACING + FONT_HGT_MEDIUM, 0.9, 0.9, 0.9, 1, UIFont.Medium);
        end
    end
    if not self.isPasswordModified then
        self.seePasswordBtn:setVisible(false)
    else
        self.seePasswordBtn:setVisible(true)
    end
end

function ISMPEditAccount.onLoginTextChange(txtEntry)
    local isValid = true
    self = txtEntry.target;
    local txt = txtEntry:getInternalText();

    self.saveBtn:setTooltip(nil);

    if txt:len() < 2 then
        self.saveBtn:setTooltip(getText("UI_servers_accountNameTooShort"));
        isValid = false;
    end

    if profanityFilterCheck(txt) then
        self.saveBtn:setTooltip(getText("UI_servers_accountNameBadWord", txt));
        isValid = false;
    end

    if self.accountLoginList[txtEntry:getInternalText()] then
        self.saveBtn:setTooltip(getText("UI_servers_accountAlreadyExist"));
        isValid = false;
    end

    if isValid then
        txtEntry.backgroundColor = {r=0, g=0, b=0, a=0.5};
    else
        txtEntry.backgroundColor = {r=0.5, g=0, b=0, a=0.5};
    end

    self.saveBtn:setEnable(isValid)
end

function ISMPEditAccount:render()
    if self.password:isFocused() then
        self.isPasswordModified = true
    end
    if not self.isPasswordModified then
        self:drawText(getText("UI_Server_Passwort_Hint"), 59+5, self.password.y + 3, 1, 1, 1, 1, UIFont.Medium);
    end

    if self.connectAfter then
        self.saveBtn:setTitle(getText("UI_servers_button_connect"))
    else
        self.saveBtn:setTitle(getText("UI_servers_save"))
    end
end

function ISMPEditAccount:onOtherKey(key)
    if key == Keyboard.KEY_TAB then
        if self.parent.login:isFocused() then
           self.parent.login:unfocus()
           self.parent.password:focus()
           return
        end
    end
end

function ISMPEditAccount:onCommandEntered()
    if self.target and self.target.saveBtn:isEnabled() then
        self.target:onClick(self.target.saveBtn);
    end
end

function ISMPEditAccount:onMouseUp(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    if ISMouseDrag.tabPanel then
        ISMouseDrag.tabPanel:onMouseUp(x,y);
    end

    ISMouseDrag.dragView = nil;
end

function ISMPEditAccount:onMouseUpOutside(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    ISMouseDrag.dragView = nil;
end

function ISMPEditAccount:onMouseDown(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.downX = x;
    self.downY = y;
    self.moving = true;
    self:bringToTop();
end

function ISMPEditAccount:onMouseMoveOutside(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = false;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISMPEditAccount:onMouseMove(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = true;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
        --ISMouseDrag.dragView = self;
    end
end

function ISMPEditAccount:onGainJoypadFocus(joypadData)
--    print("gained modal focus");
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
	if self.yesno then
		self:setISButtonForA(self.yes)
		self:setISButtonForB(self.no)
	else
		self:setISButtonForA(self.ok)
	end
	self.joypadButtons = {}
end

function ISMPEditAccount:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	if self.yesno then
		self.yes:clearJoypadButton()
		self.no:clearJoypadButton()
	else
		self.ok:clearJoypadButton()
	end
end

function ISMPEditAccount:onJoypadBeforeDeactivate(joypadData)
	if self.removeIfJoypadDeactivated then -- ugh
		self:destroy()
	end
end

function ISMPEditAccount:onJoypadDown(button)
	ISPanelJoypad.onJoypadDown(self, button)
end

function ISMPEditAccount.OnConnectFailed(message, detail)
    self = ISMPEditAccount.instance
    if self == nil then
        return
    end
    self.googleAuthPopup.statusLabel = getText("UI_servers_connectionfailed")
    stopSendSecretKey();
end

function ISMPEditAccount.OnConnected()
    self = ISMPEditAccount.instance
    if self == nil then
        return
    end
    self.googleAuthPopup.statusLabel = getText("UI_servers_QR_sending_key")
end

function ISMPEditAccount.OnQRReceived(message)
    self = ISMPEditAccount.instance
    if self == nil then
        return
    end
    self.googleAuthPopup.statusLabel = message
    stopSendSecretKey();
    self.googleAuthButton:setEnable(false)
end

Events.OnQRReceived.Add(ISMPEditAccount.OnQRReceived)
Events.OnConnectFailed.Add(ISMPEditAccount.OnConnectFailed)
Events.OnDisconnect.Add(ISMPEditAccount.OnConnectFailed)
Events.OnConnected.Add(ISMPEditAccount.OnConnected)

function ISMPEditAccount:new(ui, server, account)
	local o = ISPanelJoypad.new(self, x, y, width, height);
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = 440;
    o.height = 400;
    o.ui_password_eye = getTexture("media/ui/MP/mp_ui_password_eye.png");
    o.ui_droplist = getTexture("media/ui/MP/mp_ui_droplist.png");
    o.x = (ui:getWidth() - o.width) / 2;
    o.y = (ui:getHeight() - o.height) / 2;
    o.ui = ui
    o.server = server
    o.account = account
    o.isPasswordModified = true;
    o.moveWithMouse = false;

    -- get all the account login so we can check if this one already exist
    o.accountLoginList = {};
    for i=0,server:getAccounts():size() - 1 do
        o.accountLoginList[server:getAccounts():get(i):getUserName()] = true;
    end
    return o;
end
