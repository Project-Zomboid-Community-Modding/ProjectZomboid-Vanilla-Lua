--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISEntityViewWindow = ISCollapsableWindow:derive("ISEntityViewWindow");
ISEntityViewWindow.instance = nil;
ISEntityViewWindow.coords = false;

function ISEntityViewWindow.OnOpenPanel(_entity)
    if ISEntityViewWindow.instance==nil then
        local x, y, w, h = 100, 100, 800, 600;
        if ISEntityViewWindow.coords then
            x, y, w, h = unpack(ISEntityViewWindow.coords);
        end
        ISEntityViewWindow.instance = ISEntityViewWindow:new (x, y, w, h);
        ISEntityViewWindow.instance:initialise();
        ISEntityViewWindow.instance:instantiate();
    end

    ISEntityViewWindow.instance:setEntity(_entity);
    ISEntityViewWindow.instance:addToUIManager();
    ISEntityViewWindow.instance:setVisible(true);

    return ISEntityViewWindow.instance;
end

function ISEntityViewWindow:initialise()
    ISCollapsableWindow.initialise(self);
end

function ISEntityViewWindow:createChildren()
    ISCollapsableWindow.createChildren(self);

    local x,y = 10, self:titleBarHeight();

    y = y+3;

    self.entityPanelY = y;

    self.entityPanel = ISEntityViewPanel:new(x, y, self:getWidth()-(x*2), self.height - (y+10))
    self.entityPanel:initialise();
    self.entityPanel:instantiate();
    self:addChild(self.entityPanel);
end

function ISEntityViewWindow:setTitle(_title)
    self.title = tostring(_title);
end

function ISEntityViewWindow:setEntity(_entity)
    self.entityPanel:setEntity(_entity);
end

function ISEntityViewWindow:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
    self.entityPanel:setWidth(self.width - 20);
    self.entityPanel:setHeight(self.height-(self.entityPanelY+10));
end

function ISEntityViewWindow:update()
    ISCollapsableWindow.update(self);
end

function ISEntityViewWindow:prerender()
    ISCollapsableWindow.prerender(self);
end


function ISEntityViewWindow:render()
    ISCollapsableWindow.render(self);

end

function ISEntityViewWindow:close()
    ISCollapsableWindow.close(self)
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, nil)
    end
    ISEntityViewWindow.coords = { self:getX(), self:getY(), self:getWidth(), self:getHeight() }
    ISEntityViewWindow.instance = nil;
    self:removeFromUIManager();
    if self.parent and self.parent.onCloseSubWindow then
        self.parent:onCloseSubWindow(self, false);
    end
end

function ISEntityViewWindow:new (x, y, width, height)
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
    o.title = "Entity View Window";
    --o.viewList = {}
    o.resizable = true;
    o.drawFrame = true;
    o.minimumWidth = 500;
    o.minimumHeight = 300;

    ISDebugMenu.RegisterClass(self);
    return o
end