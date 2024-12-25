--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISFluidDebugWindow = ISCollapsableWindow:derive("ISFluidDebugWindow");
ISFluidDebugWindow.coords = false;
local UI_BORDER_SPACING = 10

function ISFluidDebugWindow.OnOpenPanel(_player)
    if ISFluidDebugWindow.instance then
        return ISFluidDebugWindow.instance;
    end
    local x, y, w, h = 200, 100, 640, 480;
    if ISFluidDebugWindow.coords then
        x, y, w, h = unpack(ISFluidDebugWindow.coords);
    end
    _player = _player or getPlayer(0);
    local ui = ISFluidDebugWindow:new(x, y, w, h, _player);
    ui:initialise();
    ui:instantiate();
    ui:setVisible(true);
    ui:addToUIManager();
    ISFluidDebugWindow.instance = ui;
end

function ISFluidDebugWindow:initialise()
	ISCollapsableWindow.initialise(self);
end


function ISFluidDebugWindow:createChildren()
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

	self.fluidOverviewScreen = ISFluidOverviewPanel:new (0, 0, w, h, self.player);
	self.fluidOverviewScreen:initialise()
	self.panel:addView(getText("IGUI_Fluids_FluidDef"), self.fluidOverviewScreen);

	self.fluidCategoriesScreen = ISFluidCategoriesViewPanel:new (0, 0, w, h, self.player);
	self.fluidCategoriesScreen:initialise()
	self.panel:addView(getText("IGUI_Fluids_Categories"), self.fluidCategoriesScreen);

	self.fluidItemsScreen = ISFluidItemsViewPanel:new (0, 0, w, h, self.player);
	self.fluidItemsScreen:initialise()
	self.panel:addView(getText("IGUI_Fluids_Items"), self.fluidItemsScreen);

	self.fluidMixerScreen = ISFluidMixerViewPanel:new (0, 0, w, h, self.player);
	self.fluidMixerScreen:initialise()
	self.panel:addView(getText("IGUI_Fluids_Mixer"), self.fluidMixerScreen);

    self:setWidth(self.width);
    self:setHeight(self.height);
end

function ISFluidDebugWindow:onResize(_width, _height)
    ISCollapsableWindow.onResize(self, _width, _height);
    self.panel:setWidth(self.width-UI_BORDER_SPACING*2-2);
    self.panel:setHeight(self.height-self.heightMod-UI_BORDER_SPACING*2-2);

    local h = self.panel:getHeight()-self.panel.tabHeight;
    local w = self.panel:getWidth();

    self.fluidOverviewScreen:setWidth(w);
    self.fluidOverviewScreen:setHeight(h);
    self.fluidCategoriesScreen:setWidth(w);
    self.fluidCategoriesScreen:setHeight(h);
    self.fluidItemsScreen:setWidth(w);
    self.fluidItemsScreen:setHeight(h);
    self.fluidMixerScreen:setWidth(w);
    self.fluidMixerScreen:setHeight(h);
end

function ISFluidDebugWindow:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISFluidDebugWindow:prerender()
    ISCollapsableWindow.prerender(self);
end


function ISFluidDebugWindow:render()
    ISCollapsableWindow.render(self)
end

function ISFluidDebugWindow:close()
    ISCollapsableWindow.close(self);
    if JoypadState.players[self.playerNum+1] then
        if getFocusForPlayer(self.playerNum)==self then
            setJoypadFocus(self.playerNum, nil);
        end
    end
    ISFluidDebugWindow.coords = { self:getX(), self:getY(), self:getWidth(), self:getHeight() }
    self:removeFromUIManager();
    ISFluidDebugWindow.instance = nil;
end

function ISFluidDebugWindow:new (x, y, width, height, player)
	local o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.title = getText("IGUI_Fluids_Title");
    o.searchText = "";
    ISDebugMenu.RegisterClass(self);
	return o
end