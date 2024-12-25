--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISCraftRecipeTagsDebugPanel = ISPanel:derive("ISCraftRecipeTagsDebugPanel");

function ISCraftRecipeTagsDebugPanel:initialise()
	ISPanel.initialise(self);
end


function ISCraftRecipeTagsDebugPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;
    local initY = y;

    local LEFT_BAR_WIDTH = 400+(getCore():getOptionFontSizeReal()*50);

    self.listView = ISStringListView:new (x, y, self:getWidth()-(x*2), self.height - (y+10));
    self.listView.borderColor = {r=0.0, g=0.0, b=0.0, a=0};
    self.listView:initialise();
    self.listView:instantiate();
    self:addChild(self.listView);

    --CraftRecipeManager.debugPrintTagManager(); <- prints to console
    local data = CraftRecipeManager.debugPrintTagManagerLines();
    self.listView:populate(data);
    --self.listView:setExpandedAll();
end

function ISCraftRecipeTagsDebugPanel:onResize(_width, _height)
    ISPanel.onResize(self, _width, _height);

    self.listView:setWidth(self.width-(self.listView:getX()*2));
    self.listView:setHeight(self.height - self.listView:getY() - UI_BORDER_SPACING - 1);
end

function ISCraftRecipeTagsDebugPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISCraftRecipeTagsDebugPanel:prerender()
    ISPanel.prerender(self);
end


function ISCraftRecipeTagsDebugPanel:render()
    ISPanel.render(self)
end

function ISCraftRecipeTagsDebugPanel:close()
end

function ISCraftRecipeTagsDebugPanel:new (x, y, width, height, player)
	local o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.searchText = "";
    --o.modColor = namedColorToTable("CornFlowerBlue");
	return o
end