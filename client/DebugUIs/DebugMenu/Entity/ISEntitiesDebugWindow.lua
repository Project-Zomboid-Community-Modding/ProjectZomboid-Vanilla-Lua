--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISEntitiesDebugWindow = ISCollapsableWindow:derive("ISEntitiesDebugWindow");
ISEntitiesDebugWindow.coords = false;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10

function ISEntitiesDebugWindow.OnOpenPanel(_player)
    if ISEntitiesDebugWindow.instance then
        return ISEntitiesDebugWindow.instance;
    end
    local x, y, w, h = 200, 100, 640, 480;
    if ISEntitiesDebugWindow.coords then
        x, y, w, h = unpack(ISEntitiesDebugWindow.coords);
    end
    _player = _player or getPlayer(0);
    local ui = ISEntitiesDebugWindow:new(x, y, w, h, _player);
    ui:initialise();
    ui:instantiate();
    ui:setVisible(true);
    ui:addToUIManager();
    ISEntitiesDebugWindow.instance = ui;
end

function ISEntitiesDebugWindow:initialise()
	ISCollapsableWindow.initialise(self);
end


function ISEntitiesDebugWindow:createChildren()
    ISCollapsableWindow.createChildren(self);

    self.th = self:titleBarHeight();
    local rh = self.resizable and self:resizeWidgetHeight() or 0;
    self.rh = rh;

    self.minimumWidth = 640+(getCore():getOptionFontSizeReal()*100);
    self.minimumHeight = 480+(getCore():getOptionFontSizeReal()*100);
    self.width = math.max(self.width, self.minimumWidth); --self.minimumWidth;
    self.height = math.max(self.height, self.minimumHeight); -- self.minimumHeight;

    self.heightMod = self.th+rh;

    local innerY = self.th;

	self.panel = ISTabPanel:new(UI_BORDER_SPACING+1, innerY+UI_BORDER_SPACING+1, self.width-UI_BORDER_SPACING*2-2, self.height-self.heightMod-UI_BORDER_SPACING*2-2);
	self.panel:initialise();
    self.panel.tabPadX = UI_BORDER_SPACING*2;
    self.panel.equalTabWidth = true;
	self:addChild(self.panel);

    local h = self.panel:getHeight()-self.panel.tabHeight;
    local w = self.panel:getWidth();

	self.instancesScreen = ISEntityInstancesPanel:new (0, 0, w, h, self.player);
	self.instancesScreen:initialise()
	self.panel:addView(getText("IGUI_Entities_Instances"), self.instancesScreen);

	self.scriptScreen = ISEntityScriptsPanel:new (0, 0, w, h, self.player);
	self.scriptScreen:initialise()
	self.panel:addView(getText("IGUI_Entities_Scripts"), self.scriptScreen);

    self:setWidth(self.width);
    self:setHeight(self.height);
end

function ISEntitiesDebugWindow:onResize(_width, _height)
    ISCollapsableWindow.onResize(self, _width, _height);
    self.panel:setWidth(self.width-UI_BORDER_SPACING*2-2);
    self.panel:setHeight(self.height-self.heightMod-UI_BORDER_SPACING*2-2);

    local h = self.panel:getHeight()-self.panel.tabHeight;
    local w = self.panel:getWidth();

    self.scriptScreen:setWidth(w);
    self.scriptScreen:setHeight(h);
    self.instancesScreen:setWidth(w);
    self.instancesScreen:setHeight(h);
end

function ISEntitiesDebugWindow:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISEntitiesDebugWindow:prerender()
    ISCollapsableWindow.prerender(self);
end


function ISEntitiesDebugWindow:render()
    ISCollapsableWindow.render(self)
end

function ISEntitiesDebugWindow:close()
    ISCollapsableWindow.close(self);
    if JoypadState.players[self.playerNum+1] then
        if getFocusForPlayer(self.playerNum)==self then
            setJoypadFocus(self.playerNum, nil);
        end
    end
    self.instancesScreen:close();
    ISEntitiesDebugWindow.coords = { self:getX(), self:getY(), self:getWidth(), self:getHeight() }
    self:removeFromUIManager();
    ISEntitiesDebugWindow.instance = nil;
end

function ISEntitiesDebugWindow:onReloadEntities()
    self.instancesScreen:onReloadEntities();
end

function ISEntitiesDebugWindow:new (x, y, width, height, player)
	local o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.title = getText("IGUI_Entities_Title");
    o.searchText = "";
    ISDebugMenu.RegisterClass(self);
	return o
end