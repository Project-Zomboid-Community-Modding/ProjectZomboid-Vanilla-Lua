require "ISUI/ISPanelJoypad"

ISMPEditServer = ISPanelJoypad:derive("ISMPEditServer");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local ENTRY_HGT = FONT_HGT_MEDIUM + 6

function ISMPEditServer:initialise()
	ISPanel.initialise(self);

    self:setWidth(getTextManager():MeasureStringX(UIFont.Medium, getText("UI_Server_Passwort_Hint")) + UI_BORDER_SPACING*5)

    self.serverName = ISTextEntryBox:new("", UI_BORDER_SPACING+2, UI_BORDER_SPACING+2+FONT_HGT_MEDIUM, self:getWidth() - (UI_BORDER_SPACING+2)*2, ENTRY_HGT);
    self.serverName.font = UIFont.Medium
    self.serverName.onOtherKey = ISMPEditServer.onOtherKey
    self.serverName:initialise();
    self.serverName:instantiate();
    self:addChild(self.serverName);

    self.serverAddress = ISTextEntryBox:new("", self.serverName:getX(), self.serverName:getBottom()+UI_BORDER_SPACING+FONT_HGT_MEDIUM, self.serverName:getWidth(), ENTRY_HGT);
    self.serverAddress.font = UIFont.Medium
    self.serverAddress.onOtherKey = ISMPEditServer.onOtherKey
    self.serverAddress:initialise();
    self.serverAddress:instantiate();
    self.serverAddress:setMasked(getCore():getOptionStreamerMode());
    self:addChild(self.serverAddress);

    local portOffset = UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_port"))

    self.serverPort = ISTextEntryBox:new("16261", self.serverName:getX() + portOffset, self.serverAddress:getBottom()+UI_BORDER_SPACING, self.serverName:getWidth() - portOffset, ENTRY_HGT);
    self.serverPort.font = UIFont.Medium
    self.serverPort.onOtherKey = ISMPEditServer.onOtherKey
    self.serverPort:initialise();
    self.serverPort:instantiate();
    self.serverPort:setMasked(getCore():getOptionStreamerMode())
    self:addChild(self.serverPort);

    self.serverPassword = ISTextEntryBox:new("", self.serverName:getX(), self.serverPort:getBottom()+UI_BORDER_SPACING+FONT_HGT_MEDIUM, self.serverName:getWidth(), ENTRY_HGT);
    self.serverPassword.font = UIFont.Medium
    self.serverPassword:initialise();
    self.serverPassword:instantiate();
    self.serverPassword:setMasked(true);
    self:addChild(self.serverPassword);

    self.seePasswordBtn = ISButton:new(self.serverPassword:getRight() - ENTRY_HGT, self.serverPassword:getY(), ENTRY_HGT, ENTRY_HGT, "", self, ISMPEditServer.onClick);
    self.seePasswordBtn.internal = "SEE";
    self.seePasswordBtn:setImage(self.ui_password_eye)
    self.seePasswordBtn:forceImageSize(22, 16)
    self.seePasswordBtn:initialise();
    self.seePasswordBtn:instantiate();
    self:addChild(self.seePasswordBtn);

    local btnWidth = UI_BORDER_SPACING + math.max(
        getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_cancel")),
        getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_save"))
    )

    self.cancelBtn = ISButton:new(UI_BORDER_SPACING+2 , self:getHeight() - BUTTON_HGT - UI_BORDER_SPACING - 2, btnWidth, BUTTON_HGT, getText("UI_servers_cancel"), self, ISMPEditServer.onClick);
    self.cancelBtn.internal = "CANCEL";
    self.cancelBtn:initialise();
    self.cancelBtn:instantiate();
    self.cancelBtn:enableCancelColor()
    self:addChild(self.cancelBtn);

    self.saveBtn = ISButton:new(self:getWidth() - btnWidth - UI_BORDER_SPACING-2, self.cancelBtn:getY(), btnWidth, BUTTON_HGT, getText("UI_servers_save"), self, ISMPEditServer.onClick);
    self.saveBtn.internal = "SAVE";
    self.saveBtn:initialise();
    self.saveBtn:instantiate();
    self.saveBtn:enableAcceptColor()
    self.saveBtn:setAnchorLeft(false);
    self.saveBtn:setAnchorRight(true);
    self:addChild(self.saveBtn);

    if self.server then
        self.serverName:setText(self.server:getName())
        self.serverAddress:setText(self.server:getIp())
        self.serverPort:setText(tostring(self.server:getPort()))
        self.serverPassword:setText("")
        self.isPasswordModified = false;
    end

    self:setHeight(self.serverPassword:getBottom() + UI_BORDER_SPACING*2 + BUTTON_HGT + 2)

    self:setX ( (getCore():getScreenWidth() - self:getWidth()) / 2);
    self:setY ( (getCore():getScreenHeight() - self:getHeight()) / 2);

    self.serverName:focus()
end

function ISMPEditServer:destroy()
	self:setVisible(false);
	self:removeFromUIManager();
	if self.joyfocus and self.joyfocus.focus == self then
		self.joyfocus.focus = self.prevFocus
		updateJoypadFocus(self.joyfocus)
	end
    self.ui.screenShading:setVisible(false)
end

function ISMPEditServer:onClick(button)
    if button.internal == "SEE" then
        self.serverPassword:setMasked(not self.serverPassword:isMasked());
        return
    end
    if button.internal == "SAVE" then
        if self.server then
            local newServer = self.server
            newServer:setName(self.serverName:getInternalText():trim());
            newServer:setIp(self.serverAddress:getInternalText():trim());
            newServer:setPort(tonumber(self.serverPort:getInternalText():trim()) or 16262);
            if self.isPasswordModified then
                newServer:setServerPassword(self.serverPassword:getInternalText():trim())
            end
            updateServerToAccountList(newServer)
        else
            local newServer = Server.new();
            newServer:setName(self.serverName:getInternalText():trim());
            newServer:setIp(self.serverAddress:getInternalText():trim());
            newServer:setPort(tonumber(self.serverPort:getInternalText():trim()) or 16262);
            newServer:setServerPassword(self.serverPassword:getInternalText():trim())
            addServerToAccountList(newServer)
        end
        self.ui:refreshList()
    end
    self:destroy();
    self.ui.modal = nil
end

function ISMPEditServer:onResolutionChange(oldw, oldh, neww, newh)
    self:setX((neww - self:getWidth()) / 2)
    self:setY((newh - self:getHeight()) / 2)
end

function ISMPEditServer:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawRectBorder(1, 1, self.width-2, self.height-2, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawText(getText("UI_servers_server_name"), self.serverName:getX(), self.serverName:getY()-FONT_HGT_MEDIUM, 1, 1, 1, 1, UIFont.Medium);
	self:drawText(getText("UI_servers_ip_domain"), self.serverName:getX(), self.serverAddress:getY()-FONT_HGT_MEDIUM, 1, 1, 1, 1, UIFont.Medium);
	self:drawText(getText("UI_servers_port"), self.serverName:getX(), self.serverPort:getY(), 1, 1, 1, 1, UIFont.Medium);
	self:drawText(getText("UI_servers_server_password"), self.serverName:getX(), self.serverPassword:getY()-FONT_HGT_MEDIUM, 1, 1, 1, 1, UIFont.Medium);

    self.saveBtn:setY(self:getHeight() - UI_BORDER_SPACING-2 - BUTTON_HGT)
    self.cancelBtn:setY(self:getHeight() - UI_BORDER_SPACING-2 - BUTTON_HGT)

    if not self.isPasswordModified then
        self.seePasswordBtn:setVisible(false)
    else
        self.seePasswordBtn:setVisible(true)
    end

    local isValid = true
    if self.serverName:getText():len() < 1 or detectBadWords(self.serverName:getText()) then
        self.serverName.backgroundColor = {r=0.5, g=0, b=0, a=0.5};
        isValid = false
    else
        self.serverName.backgroundColor = {r=0, g=0, b=0, a=0.5};
    end
    if self.serverAddress:getText():len() < 7 or detectBadWords(self.serverAddress:getText()) then
        self.serverAddress.backgroundColor = {r=0.5, g=0, b=0, a=0.5};
        isValid = false
    else
        self.serverAddress.backgroundColor = {r=0, g=0, b=0, a=0.5};
    end
    if self.serverPort:getText():len() < 1 or detectBadWords(self.serverPort:getText()) then
        self.serverPort.backgroundColor = {r=0.5, g=0, b=0, a=0.5};
        isValid = false
    else
        self.serverPort.backgroundColor = {r=0, g=0, b=0, a=0.5};
    end
    self.saveBtn:setEnable(isValid)
end

function ISMPEditServer:render()
    if self.serverPassword:isFocused() then
        self.isPasswordModified = true
    end
    if not self.isPasswordModified then

        self:drawText(getText("UI_Server_Passwort_Hint"), self.serverPassword:getX() + UI_BORDER_SPACING, self.serverPassword:getY() + (ENTRY_HGT-FONT_HGT_MEDIUM)/2, 1, 1, 1, 1, UIFont.Medium);
    end
end

function ISMPEditServer:onMouseUp(x, y)
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

function ISMPEditServer:onMouseUpOutside(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    ISMouseDrag.dragView = nil;
end

function ISMPEditServer:onMouseDown(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.downX = x;
    self.downY = y;
    self.moving = true;
    self:bringToTop();
end

function ISMPEditServer:onMouseMoveOutside(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = false;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISMPEditServer:onMouseMove(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = true;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISMPEditServer:onOtherKey(key)
    if key == Keyboard.KEY_TAB then
        if self.parent.serverName:isFocused() then
            self.parent.serverName:unfocus()
            self.parent.serverAddress:focus()
            return
        end
        if self.parent.serverAddress:isFocused() then
            self.parent.serverAddress:unfocus()
            self.parent.serverPort:focus()
            return
        end
        if self.parent.serverPort:isFocused() then
            self.parent.serverPort:unfocus()
            self.parent.serverPassword:focus()
            return
        end
    end
end

function ISMPEditServer:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
	if self.yesno then
		self:setISButtonForA(self.yes)
		self:setISButtonForB(self.no)
	else
		self:setISButtonForA(self.ok)
	end
	self.joypadButtons = {}
end

function ISMPEditServer:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	if self.yesno then
		self.yes:clearJoypadButton()
		self.no:clearJoypadButton()
	else
		self.ok:clearJoypadButton()
	end
end

function ISMPEditServer:onJoypadBeforeDeactivate(joypadData)
	if self.removeIfJoypadDeactivated then -- ugh
		self:destroy()
	end
end

function ISMPEditServer:onJoypadDown(button)
	ISPanelJoypad.onJoypadDown(self, button)
end

function ISMPEditServer:new(ui, server)
	local o = ISPanelJoypad.new(self, x, y, width, height);
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = 550;
    o.height = 348;
    o.ui_password_eye = getTexture("media/ui/MP/mp_ui_password_eye.png");
    o.x = (ui:getWidth() - o.width) / 2;
    o.y = (ui:getHeight() - o.height) / 2;
    o.ui = ui
    o.server = server
    o.isPasswordModified = true;
    o.moveWithMouse = false;
    return o;
end

