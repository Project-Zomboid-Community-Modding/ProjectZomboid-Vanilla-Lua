require "ISUI/ISCollapsableWindow"

LuaDebugger = ISCollapsableWindow:derive("LuaDebugger");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local DEBUG_TOOLSTRIP_HEIGHT = UI_BORDER_SPACING*2 + BUTTON_HGT

function LuaDebugger:initialise()

    ISCollapsableWindow.initialise(self);

    self.title = "Current Coroutine";
end

function LuaDebugger:createChildren()
    --print("instance");
    ISCollapsableWindow.createChildren(self);

    local th = self:titleBarHeight()
    local rh = self:resizeWidgetHeight()
    
    self.threadPanel = LuaThreadWindow:new(0, th, self.width, self.height-th-rh);
    self.threadPanel:initialise();
    self.threadPanel:setAnchorRight(true);
    self.threadPanel:setAnchorBottom(true);
    self:addChild(self.threadPanel);

    self.resizeWidget2:bringToTop()
    self.resizeWidget:bringToTop()
end

function LuaDebugger:prerender()
    local screenWidth = getCore():getScreenWidth();
    local screenHeight = getCore():getScreenHeight();
    if self.width ~= screenWidth or self.height ~= screenHeight - DEBUG_TOOLSTRIP_HEIGHT then
        self:onResolutionChange(self.width, self.height, screenWidth, screenHeight)
    end
    ISCollapsableWindow.prerender(self)
end

function LuaDebugger:onResolutionChange(oldw, oldh, neww, newh)
    local screenWidth = getCore():getScreenWidth();
    local screenHeight = getCore():getScreenHeight();
    self:setWidth(screenWidth);
    self:setHeight(screenHeight - DEBUG_TOOLSTRIP_HEIGHT);

    local del = screenWidth / 1920;
    LuaFileBrowser.instance:setWidth(700 * del);
    LuaFileBrowser.instance:setHeight(screenHeight / 3);
    LuaFileBrowser.instance:setX(screenWidth - (700 * del));
    LuaFileBrowser.instance:setY(screenHeight - (screenHeight / 3));

    for file,ui in pairs(SourceWindow.map) do
        if ui.x > screenWidth - 50 then
            ui:setX(screenWidth - 50);
        end
        if ui.y > screenHeight - 50 then
            ui:setY(screenHeight - 50);
        end
    end

    WatchWindowInstance:setWidth((screenWidth - 700) / 2);
    WatchWindowInstance:setHeight(screenHeight / 3);
    WatchWindowInstance:setX(0);
    WatchWindowInstance:setY(screenHeight - (screenHeight / 3));
end

function LuaDebugger:new (x, y, width, height)
    local o = {}
    --o.data = {}
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.clearStentil = false
    return o
end



DoLuaDebuggerOnBreak = function (file, line)

    local f = file
    local src = nil;
    if f ~= nil then
        if SourceWindow.map[f] ~= nil then
            src =SourceWindow.map[f];
            src:removeFromUIManager();
            src:addToUIManager();
            src:setVisible(true);
        else

            src = SourceWindow:new(getCore():getScreenWidth() / 2, 0, 600, 600, f);
            SourceWindow.map[f] = src;
            src:initialise();
            src:addToUIManager();

        end
        src:scrollToLine(line+1)
        LuaDebugger.instance.threadPanel:fill();
    else
        LuaDebugger.instance.threadPanel:fill();
    end

    for k, v in pairs(ObjectViewer.map) do
       v:storePos();
       v:fill();
       v:restorePos();
    end
--   panel2:collapse();

--	getWorld():setDrawWorld(false);
--	CharacterInfoPage.doInfo(SurvivorFactory:CreateSurvivor());
end

DoLuaDebugger = function (f, line)

    local panel2 = LuaDebugger:new(0, DEBUG_TOOLSTRIP_HEIGHT, getCore():getScreenWidth(), getCore():getScreenHeight()-DEBUG_TOOLSTRIP_HEIGHT);
    panel2:initialise();
    panel2:addToUIManager();
    LuaDebugger.instance = panel2;
    local del = getCore():getScreenWidth() / 1920;
    panel2:backMost();

    panel2 = LuaFileBrowser:new(getCore():getScreenWidth()-(700*del), getCore():getScreenHeight() - (getCore():getScreenHeight()/3), (700*del), getCore():getScreenHeight()/3);
    panel2:initialise();
    panel2:addToUIManager();
    LuaFileBrowser.instance = panel2;

    panel2 = WatchWindow:new(300, 300, 300, 200);
    panel2:initialise();
    panel2:addToUIManager();

    panel2 = DebugToolstrip:new(0, 0, getCore():getScreenWidth(), DEBUG_TOOLSTRIP_HEIGHT)
    panel2:initialise();
    panel2:addToUIManager();

    if f ~= nil then
        local src = nil;
        if SourceWindow.map[f] ~= nil then
            src =SourceWindow.map[f];
            src:removeFromUIManager();
            src:addToUIManager();
            src:setVisible(true);
        else

            src = SourceWindow:new(getCore():getScreenWidth() / 2, 0, 600, 600, f);
            SourceWindow.map[f] = src;
            src:initialise();
            src:addToUIManager();

        end

        src:scrollToLine(line+1)
        LuaDebugger.instance.threadPanel:fill();
    else
        LuaDebugger.instance.threadPanel:fill();
    end
--   panel2:collapse();

--	getWorld():setDrawWorld(false);
--	CharacterInfoPage.doInfo(SurvivorFactory:CreateSurvivor());
end
