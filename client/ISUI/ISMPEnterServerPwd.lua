require "ISUI/ISPanelJoypad"

ISMPEnterServerPwd = ISPanelJoypad:derive("ISMPEnterServerPwd");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISMPEnterServerPwd:initialise()
	ISPanel.initialise(self);

    self.password = ISTextEntryBox:new("", 59, 80, 322, 33);
    self.password.font = UIFont.Medium
    self.password:initialise();
    self.password:instantiate();
    self.password:setMasked(true);
    self.password.onCommandEntered = ISMPEnterServerPwd.onCommandEntered;
    self.password.target = self;
    self:addChild(self.password);

    self.saveBtn = ISButton:new(10, self:getHeight() - BUTTON_HGT - 5, 93, BUTTON_HGT, getText("UI_servers_button_connect"), self, ISMPEnterServerPwd.onClick);
    self.saveBtn.internal = "SAVE";
    self.saveBtn:initialise();
    self.saveBtn:instantiate();
    self.saveBtn:enableAcceptColor()
    self:addChild(self.saveBtn);

    self.closeBtn = ISButton:new(5, self:getHeight() - BUTTON_HGT - 5, 93, BUTTON_HGT, getText("UI_servers_cancel"), self, ISMPEnterServerPwd.onClick);
    self.closeBtn.internal = "CLOSE";
    self.closeBtn:initialise();
    self.closeBtn:instantiate();
    self.closeBtn:enableCancelColor();
    self:addChild(self.closeBtn);
end

function ISMPEnterServerPwd:destroy()
	self:setVisible(false);
	self:removeFromUIManager();
	if self.joyfocus and self.joyfocus.focus == self then
		self.joyfocus.focus = self.prevFocus
		updateJoypadFocus(self.joyfocus)
	end
    self.ui.screenShading:setVisible(false)
end

function ISMPEnterServerPwd:onCommandEntered()
    if self.target and self.target.saveBtn:isEnabled() then
        self.target:onClick(self.target.saveBtn);
    end
end

function ISMPEnterServerPwd:onClick(button)
    if button.internal == "SAVE" then
        self.server:setServerPassword(self.password:getInternalText():trim())

        -- launch the select account or create after we're done with server pwd
        if self.connectAfter then
            self.ui:connectFromBrowser(self.server);
        end
        -- add to fav if we come from "add to favourites"
        if self.addToFavAfter then
            addServerToAccountList(self.server)
            self.ui:refreshList()
            local item = self.ui:getServerFeatured(self.server)
            self.ui:onSelectAccount(item)
        end
    end

    self:destroy();
    self.ui.modal = nil
end

function ISMPEnterServerPwd:onResolutionChange(oldw, oldh, neww, newh)
    self:setX((neww - self:getWidth()) / 2)
    self:setY((newh - self:getHeight()) / 2)
end

function ISMPEnterServerPwd:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawRectBorder(1, 1, self.width-2, self.height-2, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawText(getText("UI_servers_enterServerPwd", self.server:getName()), 70, 20, 1, 1, 1, 1, UIFont.Medium);
end

function ISMPEnterServerPwd:render()
    self:updateButtons()
end

function ISMPEnterServerPwd:updateButtons()
    self.saveBtn:setX(self:getWidth() - self.saveBtn:getWidth() - 15);
    self.saveBtn:setY(self:getHeight() - BUTTON_HGT - 15);

    self.closeBtn:setX(15);
    self.closeBtn:setY(self.saveBtn:getY());
end

function ISMPEnterServerPwd:onMouseUp(x, y)
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

function ISMPEnterServerPwd:onMouseUpOutside(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.moving = false;
    ISMouseDrag.dragView = nil;

    self:destroy();
end

function ISMPEnterServerPwd:onMouseDown(x, y)
    if not self.moveWithMouse then return; end
    if not self:getIsVisible() then
        return;
    end

    self.downX = x;
    self.downY = y;
    self.moving = true;
    self:bringToTop();
end

function ISMPEnterServerPwd:onMouseMoveOutside(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = false;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
    end
end

function ISMPEnterServerPwd:onMouseMove(dx, dy)
    if not self.moveWithMouse then return; end
    self.mouseOver = true;

    if self.moving then
        self:setX(self.x + dx);
        self:setY(self.y + dy);
        self:bringToTop();
        --ISMouseDrag.dragView = self;
    end
end

function ISMPEnterServerPwd:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
end

function ISMPEnterServerPwd:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function ISMPEnterServerPwd:onJoypadBeforeDeactivate(joypadData)
	if self.removeIfJoypadDeactivated then -- ugh
		self:destroy()
	end
end

function ISMPEnterServerPwd:onJoypadDown(button)
	ISPanelJoypad.onJoypadDown(self, button)
end

function ISMPEnterServerPwd:setAddToFavAfter(addToFavAfter)
    self.addToFavAfter = addToFavAfter;
    if self.addToFavAfter and self.saveBtn then
        self.saveBtn.title = getText("UI_btn_add");
    end
end

function ISMPEnterServerPwd:new(ui, server)
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

