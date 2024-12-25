--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Xui debug window to test some stuff.
--]]

require "ISUI/ISCollapsableWindow"

XuiTestWindow = ISCollapsableWindow:derive("XuiTestWindow");

function XuiTestWindow:initialise()
	ISCollapsableWindow.initialise(self);
end


function XuiTestWindow:createChildren()
    ISCollapsableWindow.createChildren(self)
    self.th = self:titleBarHeight();
    local rh = self.resizable and self:resizeWidgetHeight() or 0;

    self.minimumWidth = 0;
    self.minimumHeight = 0;

    print("Creating window")
    self.heightMod = self.th+rh;

    --since this window has a title bar header and footer resize widget
    --we can set a xui draw rectangle to this table, child elements will know how to resize properly.
    ISXuiBuilder.setDrawRectangle(self, 0, self.th, self.width, self.height-self.heightMod);

    --local xuiScript = XuiManager.GetScript("TestUI2");

    local buildInfo = {
        references = {
            Ref_SubUI = "SubUI2",
        }
    }

    -- building the ui elements.
    -- all elements have a special table added to them as well as extra xui functions.
    -- passing 'self' reference to build will register xui functions such as xuiFind to this window as well.
    self.xuiPanel = ISXuiBuilder.build(self.xuiScript, self, buildInfo);
    self:addChild(self.xuiPanel);

    -- xuiFind has been registered to this window during build.
    -- it will allow to find an element with the provided 'xuiKey' in the hierarchy.
    self.buttonHello = self:xuiFind("buttonHello");
    if self.buttonHello then
        self.buttonHello.target = self;
        self.buttonHello.onclick = XuiTestWindow.onButtonClick;
    end
    self.panelButton = self:xuiFind("panelWithButton")
end

--[[
function XuiTestWindow.referenceFunction(_reference)
    if not _reference then
        return;
    end
    if _reference=="Ref_SubUI" then
        return "SubUI2";
    end
end
--]]

function XuiTestWindow:onButtonClick(_button)
    if _button==self.buttonHello then
        local c = Colors.GetRandomColor();
        self.panelButton.backgroundColor = {
            r = c:getRedFloat(),
            g = c:getGreenFloat(),
            b = c:getBlueFloat(),
            a = 1,
        }
    end
end

function XuiTestWindow:onResize(_width, _height)
    --ISCollapsableWindow.onResize(self, _width, _height)
    -- When resizing adjust this window's draw rectangle
    ISXuiBuilder.setDrawRectangle(self, 0, self.th, self.width, self.height-self.heightMod);
end

function XuiTestWindow:close()
	ISCollapsableWindow.close(self);
    self:removeFromUIManager();
    if self.parent and self.parent.onCloseSubWindow then
        self.parent:onCloseSubWindow(self, false);
    end
end

function XuiTestWindow:prerender()
    ISCollapsableWindow.prerender(self)
end


function XuiTestWindow:render()
    ISCollapsableWindow.render(self)
end

function XuiTestWindow:new (x, y, width, height, player, script)
	local o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.xuiScript = script;
	return o
end

