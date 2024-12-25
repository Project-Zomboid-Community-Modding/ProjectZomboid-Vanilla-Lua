--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISCraftRecipeDbgWindow = ISCollapsableWindow:derive("ISCraftRecipeDbgWindow");
ISCraftRecipeDbgWindow.coords = false;
local UI_BORDER_SPACING = 10

function ISCraftRecipeDbgWindow.OnOpenPanel(_player)
    if ISCraftRecipeDbgWindow.instance then
        return ISCraftRecipeDbgWindow.instance;
    end
    local x, y, w, h = 200, 100, 640, 480;
    if ISCraftRecipeDbgWindow.coords then
        x, y, w, h = unpack(ISCraftRecipeDbgWindow.coords);
    end
    _player = _player or getPlayer(0);
    local ui = ISCraftRecipeDbgWindow:new(x, y, w, h, _player);
    ui:initialise();
    ui:instantiate();
    ui:setVisible(true);
    ui:addToUIManager();
    ISCraftRecipeDbgWindow.instance = ui;
end

function ISCraftRecipeDbgWindow:initialise()
	ISCollapsableWindow.initialise(self);
end


function ISCraftRecipeDbgWindow:createChildren()
    ISCollapsableWindow.createChildren(self);

    self.th = self:titleBarHeight();
    local rh = self.resizable and self:resizeWidgetHeight() or 0;
    self.rh = rh;

    self.minimumWidth = 800+(getCore():getOptionFontSizeReal()*100);
    self.minimumHeight = 600+(getCore():getOptionFontSizeReal()*100);
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

	self.recipeOverviewScreen = ISCraftRecipeOverviewPanel:new (0, 0, w, h, self.player);
	self.recipeOverviewScreen:initialise()
	self.panel:addView(getText("IGUI_CraftRecipesDebug_CraftRecipes"), self.recipeOverviewScreen);

	self.recipeTagsScreen = ISCraftRecipeTagsPanel:new (0, 0, w, h, self.player);
	self.recipeTagsScreen:initialise()
	self.panel:addView(getText("IGUI_CraftRecipesDebug_Tags"), self.recipeTagsScreen);

	self.recipeQueriesScreen = ISCraftRecipeQueriesPanel:new (0, 0, w, h, self.player);
	self.recipeQueriesScreen:initialise()
	self.panel:addView(getText("IGUI_CraftRecipesDebug_Queries"), self.recipeQueriesScreen);

	self.recipeIconsScreen = ISCraftRecipeIconsPanel:new (0, 0, w, h, self.player);
	self.recipeIconsScreen:initialise()
	self.panel:addView(getText("IGUI_CraftRecipesDebug_IconList"), self.recipeIconsScreen);

	self.recipeTagsDebugScreen = ISCraftRecipeTagsDebugPanel:new (0, 0, w, h, self.player);
	self.recipeTagsDebugScreen:initialise()
	self.panel:addView(getText("IGUI_CraftRecipesDebug_TagsDebug"), self.recipeTagsDebugScreen);

    self:setWidth(self.width);
    self:setHeight(self.height);
end

function ISCraftRecipeDbgWindow:onResize(_width, _height)
    ISCollapsableWindow.onResize(self, _width, _height);
    self.panel:setWidth(self.width-UI_BORDER_SPACING*2-2);
    self.panel:setHeight(self.height-self.heightMod-UI_BORDER_SPACING*2-2);

    local h = self.panel:getHeight()-self.panel.tabHeight;
    local w = self.panel:getWidth();

    self.recipeOverviewScreen:setWidth(w);
    self.recipeOverviewScreen:setHeight(h);
    self.recipeTagsScreen:setWidth(w);
    self.recipeTagsScreen:setHeight(h);
    self.recipeQueriesScreen:setWidth(w);
    self.recipeQueriesScreen:setHeight(h);
    self.recipeIconsScreen:setWidth(w);
    self.recipeIconsScreen:setHeight(h);
    self.recipeTagsDebugScreen:setWidth(w);
    self.recipeTagsDebugScreen:setHeight(h);
end

function ISCraftRecipeDbgWindow:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISCraftRecipeDbgWindow:prerender()
    ISCollapsableWindow.prerender(self);
end


function ISCraftRecipeDbgWindow:render()
    ISCollapsableWindow.render(self)
end

function ISCraftRecipeDbgWindow:close()
    ISCollapsableWindow.close(self);
    if JoypadState.players[self.playerNum+1] then
        if getFocusForPlayer(self.playerNum)==self then
            setJoypadFocus(self.playerNum, nil);
        end
    end
    ISCraftRecipeDbgWindow.coords = { self:getX(), self:getY(), self:getWidth(), self:getHeight() }
    self:removeFromUIManager();
    ISCraftRecipeDbgWindow.instance = nil;
end

function ISCraftRecipeDbgWindow:new (x, y, width, height, player)
	local o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.title = getText("IGUI_CraftRecipesDebug_Title");
    o.searchText = "";
    ISDebugMenu.RegisterClass(self);
	return o
end