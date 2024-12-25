--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISCraftRecipeIconsPanel = ISPanel:derive("ISCraftRecipeIconsPanel");

function ISCraftRecipeIconsPanel:initialise()
	ISPanel.initialise(self);
end


function ISCraftRecipeIconsPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;
    local initY = y;

    local LEFT_BAR_WIDTH = 400+(getCore():getOptionFontSizeReal()*50);

    self.iconPanel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTiledIconPanel, 0, 0, 10, 10, self.player, nil, self);
    self.iconPanel.searchInfoText = getText("IGUI_DebugMenu_Search");
    -- for render the '_self' context is the ISTiledIconListBox
    self.iconPanel.onRenderTile = function(_self, _recipe, _x, _y, _width, _height, _mouseover)
        if _recipe and _recipe:getIconTexture() then
            local a,r,g,b = 1.0,1.0,1.0,1.0;
            _self:drawTextureScaledAspect(_recipe:getIconTexture(), _x, _y, _width, _height,  a, r, g, b);
        else
            _self:drawRectBorderStatic(_x, _y, _width, _height, 1.0, 0.5, 0.5, 0.5);
        end
    end
    -- for all other callbacks (underscored) '_self' is the 'ISTiledIconPanel' instance
    self.iconPanel.onTileClicked = function (_self, _recipe) end
    self.iconPanel.onTileMouseHover = function(_self, _recipe)
        self.tooltipRecipe = _recipe;
        self.tooltipCounter = self.tooltipCounterTime;
    end
    self.iconPanel.onPageScrolled = function(_self, _recipe)
        self.tooltipCounter = (self.tooltipCounterTime*4);
    end
    self.iconPanel.onFilterData = function(_self, _string, _dataList, _sourceDataList)
        CraftRecipeManager.filterRecipeList(_string, _dataList, _sourceDataList);
        CraftRecipeSort.alphaNumeric(_dataList);
    end
    self.iconPanel:initialise();
    self.iconPanel:instantiate();

    self.iconPanel:setDataList(ScriptManager.instance:getAllCraftRecipes());

    self:addChild(self.iconPanel);
end

function ISCraftRecipeIconsPanel:onResize(_width, _height)
    ISPanel.onResize(self, _width, _height);

    self.iconPanel:setX(0);
    self.iconPanel:setY(0);
    self.iconPanel:calculateLayout(self.width, self.height);
    --self.iconPanel:setWidth(self.width);
    --self.iconPanel:setHeight(self.height);

    self.tooltipRecipe = nil;
end

function ISCraftRecipeIconsPanel:prerender()
    ISPanel.prerender(self);

    if self.tooltipCounter>0 then
        self.tooltipCounter = self.tooltipCounter-UIManager.getSecondsSinceLastUpdate();
    end
    self:updateTooltip();
end


function ISCraftRecipeIconsPanel:render()
    ISPanel.render(self)
end

function ISCraftRecipeIconsPanel:close()
end

function ISCraftRecipeIconsPanel:updateTooltip()
    if (not self.tooltipRecipe) then
        self:deactivateTooltip();
        return;
    end

    --[[
    if self.activeTooltip and (self:getSelectedRecipe()==self.activeTooltip.recipe) then
        self:deactivateTooltip();
        return;
    end
    --]]

    local titleOnly = self.tooltipCounter>0;
    if self.activeTooltip then
        self.activeTooltip:setRecipe(self.tooltipRecipe, titleOnly);
    else
        self.activeTooltip = ISCraftRecipeTooltip.activateToolTipFor(self.iconPanel, self.player, self.tooltipRecipe, nil, true, titleOnly, true);
    end
end

function ISCraftRecipeIconsPanel:deactivateTooltip()
    if self.activeTooltip then
        ISCraftRecipeTooltip.deactivateToolTipFor(self.iconPanel);
        self.activeTooltip = nil;
    end
end

function ISCraftRecipeIconsPanel:new (x, y, width, height, player)
	local o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.searchText = "";
    --o.modColor = namedColorToTable("CornFlowerBlue");

    o.tooltipCounterTime = 0; --0.75;
    o.tooltipCounter = o.tooltipCounterTime;
    o.tooltipRecipe = nil;
    o.activeTooltip = nil;
	return o
end