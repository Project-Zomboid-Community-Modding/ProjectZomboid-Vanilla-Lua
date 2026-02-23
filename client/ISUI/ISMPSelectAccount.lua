require "ISUI/ISPanelJoypad"

ISMPSelectAccount = ISPanelJoypad:derive("ISMPSelectAccount");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISMPSelectAccount:initialise()
	ISPanel.initialise(self);

    -- going there we have selected a server from the public browser list, we'll get the actual Server.java from the fav panel as it has everything loaded into it
    self.server = self.ui:getServerFeatured(self.server);

    if not self.server then
        self:destroy();
        return;
    end

    self.server = self.server.server;

    self.connectBtn = ISButton:new(10, self:getHeight() - BUTTON_HGT - 5, 93, BUTTON_HGT, getText("UI_servers_button_connect"), self, ISMPSelectAccount.onClick);
    self.connectBtn.internal = "CONNECT";
    self.connectBtn:initialise();
    self.connectBtn:instantiate();
    self.connectBtn:enableAcceptColor()
    self:addChild(self.connectBtn);

    self.addNewAccountBtn = ISButton:new(10, self:getHeight() - BUTTON_HGT - 5, 93, BUTTON_HGT, getText("UI_servers_add"), self, ISMPSelectAccount.onClick);
    self.addNewAccountBtn.internal = "ADD";
    self.addNewAccountBtn:initialise();
    self.addNewAccountBtn:instantiate();
    self:addChild(self.addNewAccountBtn);

    self.closeBtn = ISButton:new(5, self:getHeight() - BUTTON_HGT - 5, 93, BUTTON_HGT, getText("UI_servers_cancel"), self, ISMPSelectAccount.onClick);
    self.closeBtn.internal = "CLOSE";
    self.closeBtn:initialise();
    self.closeBtn:instantiate();
    self.closeBtn:enableCancelColor();
    self:addChild(self.closeBtn);

    self.accountList = ISComboBox:new(59, 73, 322, 33);
    self.accountList:initialise();
    self.accountList:instantiate();
    if not self.server:getAccounts():isEmpty() then
        self.accountAdded = true;
        for i=0,self.server:getAccounts():size()-1 do
            local account = self.server:getAccounts():get(i);
            local name = account:getUserName();
            if account:getPlayerFirstAndLastName() then
                name = name .. " (" .. account:getPlayerFirstAndLastName() .. ")";
            end
            self.accountList:addOptionWithData(name, account);
        end
    end
    self.accountList.choicesColor = {r=1, g=1, b=1, a=1}
    self.accountList.image = self.ui_droplist
    self:addChild(self.accountList);
end

function ISMPSelectAccount:destroy()
	self:setVisible(false);
	self:removeFromUIManager();
	if self.joyfocus and self.joyfocus.focus == self then
		self.joyfocus.focus = self.prevFocus
		updateJoypadFocus(self.joyfocus)
	end
    self.ui.screenShading:setVisible(false)
end

function ISMPSelectAccount:onClick(button)
    if button.internal == "CONNECT" then
        self.ui:connectToServer(self.server, self.accountList:getOptionData(self.accountList:getSelected()));
    end

    if button.internal == "ADD" then
        -- create the account
        self.modal = ISMPEditAccount:new(self, self.server, nil);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.modal.ui = self.ui;
        self.modal.connectAfter = true;
        self.modal.server = self.server;
        self.modal:bringToTop()
    end

    self:destroy();
    self.ui.modal = nil
end

function ISMPSelectAccount:onResolutionChange(oldw, oldh, neww, newh)
    self:setX((neww - self:getWidth()) / 2)
    self:setY((newh - self:getHeight()) / 2)
end

function ISMPSelectAccount:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawRectBorder(1, 1, self.width-2, self.height-2, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawText(getText("IGUI_SelectAccount_Server", self.server:getName()), 70, 20, 1, 1, 1, 1, UIFont.Medium);
end

function ISMPSelectAccount:render()
    self:updateButtons()
end

function ISMPSelectAccount:updateButtons()
    self.connectBtn:setX(self:getWidth() - self.connectBtn:getWidth() - 15);
    self.connectBtn:setY(self:getHeight() - BUTTON_HGT - 15);

    self.addNewAccountBtn:setX(self.connectBtn:getX() - self.addNewAccountBtn:getWidth() - 5);
    self.addNewAccountBtn:setY(self.connectBtn:getY());

    self.closeBtn:setX(15);
    self.closeBtn:setY(self.connectBtn:getY());
end

function ISMPSelectAccount:onMouseUp(x, y)
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

function ISMPSelectAccount:onMouseUpOutside(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    ISMouseDrag.dragView = nil;

    self:destroy();
end

function ISMPSelectAccount:onMouseDown(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.downX = x;
    self.downY = y;
    self.moving = true;
    self:bringToTop();
end

function ISMPSelectAccount:onMouseMoveOutside(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = false;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISMPSelectAccount:onMouseMove(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = true;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISMPSelectAccount:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
end

function ISMPSelectAccount:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function ISMPSelectAccount:onJoypadBeforeDeactivate(joypadData)
	if self.removeIfJoypadDeactivated then -- ugh
		self:destroy()
	end
end

function ISMPSelectAccount:onJoypadDown(button)
	ISPanelJoypad.onJoypadDown(self, button)
end

function ISMPSelectAccount:new(ui, server)
	local o = ISPanelJoypad.new(self, x, y, width, height);
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = 440;
    o.height = 400;
    o.x = (ui:getWidth() - o.width) / 2;
    o.y = (ui:getHeight() - o.height) / 2;
    o.ui = ui
    o.server = server
    o.ui_droplist = getTexture("media/ui/MP/mp_ui_droplist.png");
    return o;
end

