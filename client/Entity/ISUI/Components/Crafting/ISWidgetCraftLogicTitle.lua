--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: spurcival 				   **
--***********************************************************

--[[
    A generic title header widget
--]]
require "ISUI/ISPanel"

ISWidgetCraftLogicTitle = ISPanel:derive("ISWidgetCraftLogicTitle");
local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, (FONT_SCALE - math.floor(FONT_SCALE)) < 0.5 and math.floor(FONT_SCALE) or math.ceil(FONT_SCALE));
local ICON_SIZE = 32 * math.max(1, FONT_SCALE);

function ISWidgetCraftLogicTitle:initialise()
    ISPanel.initialise(self);
end

function ISWidgetCraftLogicTitle:createChildren()
    ISPanel.createChildren(self);

    if self.enableIcon then
        self.icon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, ICON_SIZE, ICON_SIZE, self.iconTex);
        self.icon.autoScale = true;
        self.icon:initialise();
        self.icon:instantiate();
        self:addChild(self.icon);

        self.iconSize = self.icon:getHeight();
    else
        self.iconSize = ICON_SIZE;
    end

    local titleStr = self.title or "Unknown Object";

    if isDebugEnabled() then
        titleStr = titleStr .. "\n( DBG:" .. self.recipe:getName() .. ")";
    end

    local fontHeight = -1; -- <=0 sets label initial height to font
    self.titleLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, titleStr, 1, 1, 1, 1, UIFont.Small, true);
    self.titleLabel.origTitleStr = titleStr;
    self.titleLabel:initialise();
    self.titleLabel:instantiate();
    self.titleLabel:setHeightToName(0);
    self:addChild(self.titleLabel);
end

function ISWidgetCraftLogicTitle:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, 0);

    local spacing = 15;

    -- calc width
    local requiredWidth = spacing + self.titleLabel:getWidth() + spacing;
    if self.icon then
        requiredWidth = requiredWidth + self.icon:getWidth() + spacing;
    end
    
    width = math.max(width, requiredWidth + (self.paddingLeft + self.paddingRight) + (self.marginLeft+self.marginRight));

    -- calc height
    local labelsHeight = self.titleLabel:getHeight() + (self.paddingTop + self.paddingBottom) + (self.marginTop+self.marginBottom);
    height = math.max(height, labelsHeight);
    
    if self.icon then
        height = math.max(height, self.icon:getHeight() + (self.paddingTop + self.paddingBottom) + (self.marginTop+self.marginBottom));
    end
    
    -- draw labels
    local x = (width - requiredWidth) / 2;
    local y = ((height - labelsHeight) / 2) + self.paddingTop + self.marginTop;

    if self.icon then
        local iconAreaHeight = self.icon:getHeight();
        self.icon:setX(x);
        self.icon:setY((height - iconAreaHeight) / 2);
        x = x + self.icon:getWidth() + spacing;
    end

    self.titleLabel:setX(x);
    self.titleLabel.originalX = self.titleLabel:getX();
    self.titleLabel:setY(y);

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetCraftLogicTitle:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetCraftLogicTitle:prerender()
    ISPanel.prerender(self);
end

function ISWidgetCraftLogicTitle:render()
    ISPanel.render(self);
end

function ISWidgetCraftLogicTitle:update()
    ISPanel.update(self);
end

--************************************************************************--
--** ISWidgetCraftLogicTitle:new
--**
--************************************************************************--
function ISWidgetCraftLogicTitle:new(x, y, width, height, player, logic)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.player = player;
    o.recipe = logic:getRecipe();
    o.logic = logic;

    o.title = o.recipe and o.recipe:getTranslationName() or "Title";
    o.iconTex = o.recipe and o.recipe:getIconTexture();
    
    o.paddingTop = 2;
    o.paddingBottom = 2;
    o.paddingLeft = 2;
    o.paddingRight = 2;
    o.marginTop = 5;
    o.marginBottom = 5;
    o.marginLeft = 5;
    o.marginRight = 5;

    o.colWhite = { r=1.0, g=1.0, b=1.0, a=1.0 }
    o.colGood = {
        r=getCore():getGoodHighlitedColor():getR(),
        g=getCore():getGoodHighlitedColor():getG(),
        b=getCore():getGoodHighlitedColor():getB(),
        a=getCore():getGoodHighlitedColor():getA(),
    }
    o.colBad = {
        r=getCore():getBadHighlitedColor():getR(),
        g=getCore():getBadHighlitedColor():getG(),
        b=getCore():getBadHighlitedColor():getB(),
        a=getCore():getBadHighlitedColor():getA(),
    }

    o.enableIcon = true;

    o.backgroundColor = { r=1.0, g=1.0, b=1.0, a=0.2 };

    return o
end