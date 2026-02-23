require "ISUI/ISPanelJoypad"

ISMPEnterPassword = ISPanelJoypad:derive("ISMPEnterPassword");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function ISMPEnterPassword:initialise()
	ISPanel.initialise(self);

    self.accountPassword = ISTextEntryBox:new("", 59, 53, 322, 33);
    self.accountPassword.font = UIFont.Medium
    self.accountPassword:initialise();
    self.accountPassword:instantiate();
    self.accountPassword:setMasked(true);
    self:addChild(self.accountPassword);

    self.seePasswordBtn = ISButton:new(348, 53, 33, 33, "", self, ISMPEnterPassword.onClick);
    self.seePasswordBtn.internal = "SEE";
    self.seePasswordBtn:setImage(self.ui_password_eye)
    self.seePasswordBtn:forceImageSize(22, 16)
    self.seePasswordBtn:initialise();
    self.seePasswordBtn:instantiate();
    self:addChild(self.seePasswordBtn);

    self.cancelBtn = ISButton:new(60 , self:getHeight() - 55, 93, 23, getText("UI_servers_cancel"), self, ISMPEnterPassword.onClick);
    self.cancelBtn.internal = "CANCEL";
    self.cancelBtn:initialise();
    self.cancelBtn:instantiate();
    self.cancelBtn:enableCancelColor()
    self:addChild(self.cancelBtn);

    self.connectBtn = ISButton:new(self:getWidth() - 60 - 93, self:getHeight() - 55, 93, 23, getText("UI_servers_button_connect"), self, ISMPEnterPassword.onClick);
    self.connectBtn.internal = "CONNECT";
    self.connectBtn:initialise();
    self.connectBtn:instantiate();
    self.connectBtn:enableAcceptColor()
    self:addChild(self.connectBtn);
end

function ISMPEnterPassword:destroy()
	self:setVisible(false);
	self:removeFromUIManager();
	if self.joyfocus and self.joyfocus.focus == self then
		self.joyfocus.focus = self.prevFocus
		updateJoypadFocus(self.joyfocus)
	end
    self.ui.screenShading:setVisible(false)
end

function ISMPEnterPassword:onClick(button)
    if button.internal == "SEE" then
        self.accountPassword:setMasked(not self.accountPassword:isMasked());
        return
    end
    if button.internal == "CONNECT" then
        self.account:setLastLogonNow()
        updateAccountToAccountList(self.account)
        if getSteamModeActive() then
            steamReleaseInternetServersRequest()
        end
        stopSendSecretKey();
        getCore():setNoSave(false);
        local server = self.server
        local localIP = getSteamModeActive() and server:getLocalIP() or ""
        local useSteamRelay = getSteamModeActive() and self.account:getUseSteamRelay()
        ConnectToServer.instance.loadingBackground = server:getServerLoadingScreen();
        ConnectToServer.instance:connect(self.ui, server:getName(), self.account:getUserName(), self.accountPassword:getInternalText(),
                server:getIp(), localIP, tostring(server:getPort()), server:getServerPassword(), useSteamRelay, true, self.account:getAuthType());

    end
    self:destroy();
    self.ui.modal = nil
end

function ISMPEnterPassword:onResolutionChange(oldw, oldh, neww, newh)
    self:setX((neww - self:getWidth()) / 2)
    self:setY((newh - self:getHeight()) / 2)
end

function ISMPEnterPassword:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawRectBorder(1, 1, self.width-2, self.height-2, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawText(getText("UI_servers_password"), 70, 35-8, 1, 1, 1, 1, UIFont.Medium);
end


function ISMPEnterPassword:onMouseUp(x, y)
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

function ISMPEnterPassword:onMouseUpOutside(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    ISMouseDrag.dragView = nil;
end

function ISMPEnterPassword:onMouseDown(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.downX = x;
    self.downY = y;
    self.moving = true;
    self:bringToTop();
end

function ISMPEnterPassword:onMouseMoveOutside(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = false;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISMPEnterPassword:onMouseMove(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = true;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISMPEnterPassword:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
	if self.yesno then
		self:setISButtonForA(self.yes)
		self:setISButtonForB(self.no)
	else
		self:setISButtonForA(self.ok)
	end
	self.joypadButtons = {}
end

function ISMPEnterPassword:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	if self.yesno then
		self.yes:clearJoypadButton()
		self.no:clearJoypadButton()
	else
		self.ok:clearJoypadButton()
	end
end

function ISMPEnterPassword:onJoypadBeforeDeactivate(joypadData)
	if self.removeIfJoypadDeactivated then -- ugh
		self:destroy()
	end
end

function ISMPEnterPassword:onJoypadDown(button)
	ISPanelJoypad.onJoypadDown(self, button)
end

function ISMPEnterPassword:new(ui, server, account)
	local o = ISPanelJoypad.new(self, x, y, width, height);
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = 440;
    o.height = 176;
    o.ui_password_eye = getTexture("media/ui/MP/mp_ui_password_eye.png");
    o.x = (ui:getWidth() - o.width) / 2;
    o.y = (ui:getHeight() - o.height) / 2;
    o.ui = ui
    o.server = server
    o.account = account
    o.moveWithMouse = false;
    return o;
end

