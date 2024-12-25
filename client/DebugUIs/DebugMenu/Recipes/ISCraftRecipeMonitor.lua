--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISCraftRecipeMonitor = ISCollapsableWindow:derive("ISCraftRecipeMonitor");
ISCraftRecipeMonitor.instance = nil;

function ISCraftRecipeMonitor.OnOpenPanel(_monitor)
    local window = ISCraftRecipeMonitor:new (100, 100, 1000, 600, "CraftRecipe Monitor");
    window:initialise();
    window:instantiate();
    window:addToUIManager();
    window:setVisible(true);

    window:setMonitor(_monitor)

    return window;
end

function ISCraftRecipeMonitor:initialise()
    ISCollapsableWindow.initialise(self);
end

function ISCraftRecipeMonitor:createChildren()
    ISCollapsableWindow.createChildren(self);

    local x,y = 10, self:titleBarHeight();

    local obj;

    y = y+3;
    local topY = y;

    y,obj = ISDebugUtils.addLabel(self,{}, x, y,"CraftRecipe canStart test results.", UIFont.Small, true);
    local yy, btn = ISDebugUtils.addButton(self, {}, self.width-85, topY, 75, 20, "Show Recipe", ISCraftRecipeMonitor.onBtnClick)
    self.btnRecipe = btn;
    y = y+8;

    self.infoListY = y;

    self.listView = ISStringListView:new (x, y, self:getWidth()-(x*2), self.height - (y+10));
    self.listView.borderColor = {r=0.0, g=0.0, b=0.0, a=0};
    self.listView:initialise();
    self.listView:instantiate();
    self:addChild(self.listView);
end

function ISCraftRecipeMonitor:setMonitor(_monitor)
    self.listView:clear();

    self.monitor = nil;
    if _monitor then
        self.monitor = _monitor;
        self.listView:populate(self.monitor:GetLines());
        self.listView:setExpandedAll();
    end
end

function ISCraftRecipeMonitor:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
    self.listView:setWidth(self.width - 20);
    self.listView:setHeight(self.height-(self.infoListY+10));
    self.btnRecipe:setX(self.width-85);
end

function ISCraftRecipeMonitor:onBtnClick(_button)

    if _button == self.btnRecipe then
        if self.monitor and self.monitor:getRecipe() then
            ISScriptViewWindow.OnOpenPanel(self.monitor:getRecipe());
        end
    end
end

function ISCraftRecipeMonitor:update()
    ISCollapsableWindow.update(self);

    if self.monitor and self.monitor:getRecipe() then
        self.btnRecipe.enable = true;
    else
        self.btnRecipe.enable = false;
    end
end

function ISCraftRecipeMonitor:prerender()
    ISCollapsableWindow.prerender(self);
end


function ISCraftRecipeMonitor:render()
    ISCollapsableWindow.render(self);

end

function ISCraftRecipeMonitor:close()
    ISCollapsableWindow.close(self)
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, nil)
    end
    ISCraftRecipeMonitor.instance = nil;
    self:removeFromUIManager();
end

function ISCraftRecipeMonitor:new (x, y, width, height, title)
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
    o.title = title;
    --o.viewList = {}
    o.resizable = true;
    o.drawFrame = true;

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