--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISScriptViewWindow = ISCollapsableWindow:derive("ISScriptViewWindow");
ISScriptViewWindow.instance = nil;
ISScriptViewWindow.coords = false;
local UI_BORDER_SPACING = 10

function ISScriptViewWindow.OnOpenPanel(_script)
    if ISScriptViewWindow.instance==nil then
        local x, y, w, h = 100, 100, 800, 600;
        if ISScriptViewWindow.coords then
            x, y, w, h = unpack(ISScriptViewWindow.coords);
        end
        ISScriptViewWindow.instance = ISScriptViewWindow:new (x, y, w, h);
        ISScriptViewWindow.instance:initialise();
        ISScriptViewWindow.instance:instantiate();
    end

    ISScriptViewWindow.instance:setScript(_script);
    ISScriptViewWindow.instance:addToUIManager();
    ISScriptViewWindow.instance:setVisible(true);

    return ISScriptViewWindow.instance;
end

function ISScriptViewWindow:initialise()
    ISCollapsableWindow.initialise(self);
end

function ISScriptViewWindow:createChildren()
    ISCollapsableWindow.createChildren(self);

    local x,y = 0, self:titleBarHeight()-1;

    y = y;

    self.scriptPanelY = y;

    self.scriptPanel = ISScriptViewPanel:new(x, y, self:getWidth(), self.height - y - self:resizeWidgetHeight())
    self.scriptPanel:initialise();
    self.scriptPanel:instantiate();
    self:addChild(self.scriptPanel);
end

function ISScriptViewWindow:setTitle(_title)
    self.title = tostring(_title);
end

function ISScriptViewWindow:setScript(_script)
    self.scriptPanel:setScript(_script);
end

function ISScriptViewWindow:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
    self.scriptPanel:setWidth(self.width);
    self.scriptPanel:setHeight(self.height - self.scriptPanelY - self:resizeWidgetHeight());
end

function ISScriptViewWindow:update()
    ISCollapsableWindow.update(self);
end

function ISScriptViewWindow:prerender()
    ISCollapsableWindow.prerender(self);
end


function ISScriptViewWindow:render()
    ISCollapsableWindow.render(self);

end

function ISScriptViewWindow:close()
    ISCollapsableWindow.close(self)
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, nil)
    end
    ISScriptViewWindow.coords = { self:getX(), self:getY(), self:getWidth(), self:getHeight() }
    ISScriptViewWindow.instance = nil;
    self:removeFromUIManager();
    if self.parent and self.parent.onCloseSubWindow then
        self.parent:onCloseSubWindow(self, false);
    end
end

function ISScriptViewWindow:new (x, y, width, height)
    local o = {}
    --o.data = {}
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.player = getPlayer();
    o.playerNum = getPlayer():getPlayerNum();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.greyCol = { r=0.4,g=0.4,b=0.4,a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.pin = true;
    o.isCollapsed = false;
    o.collapseCounter = 0;
    o.title = "Script View Window";
    --o.viewList = {}
    o.resizable = true;
    o.drawFrame = true;
    o.minimumWidth = 300;
    o.minimumHeight = 200;

    o.currentTile = nil;
    o.richtext = nil;
    o.overrideBPrompt = true;
    o.subFocus = nil;
    o.hotKeyPanels = {};
    o.isJoypadWindow = false;

    o.monitorID = -1;

    ISDebugMenu.RegisterClass(self);
    return o
end