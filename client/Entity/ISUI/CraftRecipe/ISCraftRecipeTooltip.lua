--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISCraftRecipeTooltip = ISPanel:derive("ISCraftRecipeTooltip");

function ISCraftRecipeTooltip:initialise()
	ISPanel.initialise(self);
end

function ISCraftRecipeTooltip:createChildren()
    ISPanel.createChildren(self);

    local styleCell = "S_TableLayoutCell_Pad5";
    self.rootTable = ISXuiSkin.build(self.xuiSkin, "S_TableLayout_Main", ISTableLayout, 0, 0, 10, 10, nil, nil, styleCell);
    self.rootTable:addColumnFill(nil);
    self.rootTable:initialise();
    self.rootTable:instantiate();
    self:addChild(self.rootTable);

    self:createDynamicChildren();
end

function ISCraftRecipeTooltip:createDynamicChildren()
    self.rootTable:clearTable();
    self.rootTable:addColumnFill(nil);

    if not self.recipe then
        self:xuiRecalculateLayout();
        return;
    end

    local column, row;

    self.titleWidget = ISXuiSkin.build(self.xuiSkin, "S_WidgetTitleHeader_Std", ISWidgetTitleHeader, 0, 0, 10, 10, self.recipe);
    self.titleWidget:initialise();
    self.titleWidget:instantiate();

    row = self.rootTable:addRow();
    self.rootTable:setElement(0, row:index(), self.titleWidget);

    if not self.titleOnly then
        self.infoBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISCraftRecipeInfoBox, 0, 0, 10, 10, self.player, self.recipe);
        self.infoBox.displayTags = self.debugMode;
        self.infoBox:initialise();
        self.infoBox:instantiate();

        row = self.rootTable:addRow();
        self.rootTable:setElement(0, row:index(), self.infoBox);

        if self.recipe:isUsesTools() then
            self.toolsWidget = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetRecipeTools, 0, 0, 10, 10, self.player, self.logic); -- self.player, self.recipeData, self.craftBench);
            self.toolsWidget.interactiveMode = false;
            if not self.logic then
                self.toolsWidget.recipe = self.recipe;
            end
            self.toolsWidget:initialise();
            self.toolsWidget:instantiate();

            row = self.rootTable:addRow();
            self.rootTable:setElement(0, row:index(), self.toolsWidget);
        end

        self.ingredients = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetIngredients, 0, 0, 10, 10, self.player, self.logic); -- self.player, self.recipeData, self.craftBench);
        self.ingredients.interactiveMode = false;
        if not self.logic then
            self.ingredients.recipe = self.recipe;
        end
        self.ingredients:initialise();
        self.ingredients:instantiate();

        row = self.rootTable:addRow();
        self.rootTable:setElement(0, row:index(), self.ingredients);
    end

    self:xuiRecalculateLayout();
end

function ISCraftRecipeTooltip:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    self.rootTable:calculateLayout(width, height);

    width = math.max(width, self.rootTable:getWidth());
    height = math.max(height, self.rootTable:getHeight());

    self:setWidth(width);
    self:setHeight(height);

    self.dirtyLayout = false;
end

function ISCraftRecipeTooltip:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISCraftRecipeTooltip:prerender()
    if self.dirtyLayout then
        if self.calculateLayout then self:calculateLayout(0, 0); end
        self.dirtyLayout = false;
    end

    self:position();

    ISPanel.prerender(self);
end

function ISCraftRecipeTooltip:position()
    if self.followMouse then
        local xOffset = 32;
        local yOffset = 0;
        local mx, my = getMouseX(), getMouseY();
        local x = mx + xOffset;
        local y = my + yOffset;

        local sx = getPlayerScreenLeft(self.playerNum);
        local sy = getPlayerScreenTop(self.playerNum);
        local sw = getPlayerScreenWidth(self.playerNum);
        local sh = getPlayerScreenHeight(self.playerNum);

        --print("mx="..tostring(mx)..", my="..tostring(my)..", sx="..tostring(sx)..", sy="..tostring(sy)..", sw="..tostring(sw)..", sh="..tostring(sh))

        if x+self:getWidth()>(sx+sw) then
            local x2 = mx - xOffset - self:getWidth();
            if x2>=sx then x = x2; end
        end
        if y+self:getHeight()>(sy+sh) then
            y = my - (self:getHeight() - (my-sy));
            if y<sy then y = sy; end
        end

        self:setX(x);
        self:setY(y);
    end
end

function ISCraftRecipeTooltip:render()
    ISPanel.render(self);
end

function ISCraftRecipeTooltip:update()
    ISPanel.update(self);

    if (not self.followMouse) and self.__parent and (not self.__parent:isMouseOver()) then
        ISCraftRecipeTooltip.deactivateToolTipFor(self.__parent)
    end

    if self.__parent and not self.__parent:isReallyVisible() then
        ISCraftRecipeTooltip.deactivateToolTipFor(self.__parent)
    end
end

function ISCraftRecipeTooltip:xuiRecalculateLayout()
    if self.calculateLayout and (not self.dirtyLayout) then
        self.dirtyLayout = true;
    end
end

function ISCraftRecipeTooltip:setRecipe(_recipe, _titleOnly)
    if (self.recipe~=_recipe) or (self.titleOnly~=_titleOnly) then
        self.recipe = _recipe;
        if self.logic then
            self.logic:setRecipe(_recipe); --recipeData:setRecipe(_recipe)
        end
        self.titleOnly = _titleOnly;
        self:createDynamicChildren();

        if self.titleOnly then
            self.backgroundColor.a = self.titleOnlyAlpha;
        else
            self.backgroundColor.a = 1.00;
        end
    end
end

function ISCraftRecipeTooltip:setTitleOnly(_b)
    if self.titleOnly~=_b then
        self.titleOnly = _b;
        self:createDynamicChildren();

        if self.titleOnly then
            self.backgroundColor.a = self.titleOnlyAlpha;
        else
            self.backgroundColor.a = 1.00;
        end
    end
end

--************************************************************************--
--** ISCraftRecipeTooltip:new
--**
--************************************************************************--
function ISCraftRecipeTooltip:new (x, y, width, height, player, recipe, logic, followMouse, debugMode) -- recipeData, craftBench, followMouse)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.logic = logic;
    --o.recipeData = recipeData;
    o.recipe = recipe; --recipeData:getRecipe();
    --o.craftBench = craftBench;
    o.followMouse = followMouse;
    o.titleOnly = false;
    o.titleOnlyAlpha = 0.5;

    --o.background = false;
    o.debugMode = debugMode;

    o.margin = 5;
    o.minimumWidth = width;
    o.minimumHeight = height;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end

--[[
function ISCraftRecipeTooltip.activateToolTipWithRecipeFor(_parent, _player, _recipe, _followMouse, _titleOnly)
    if not ISCraftRecipeTooltip.recipeDatas or not ISCraftRecipeTooltip.recipeDatas[_player] then
        ISCraftRecipeTooltip.recipeDatas = ISCraftRecipeTooltip.recipeDatas or {};
        ISCraftRecipeTooltip.recipeDatas[_player] = CraftRecipeData.new(CraftMode.Handcraft, true, true, false, true);
    end

    local recipeData = ISCraftRecipeTooltip.recipeDatas[_player];

    ISCraftRecipeTooltip.activateToolTipFor(_parent, _player, recipeData, _followMouse, _titleOnly)
end
--]]

function ISCraftRecipeTooltip.activateToolTipFor(_parent, _player, _recipe, _logic, _followMouse, _titleOnly, _debugMode)
    if not _recipe or (_logic and not _logic:getRecipe()) then  --(not _logic) or (not _logic:getRecipe()) then --(not _recipe) then
        ISCraftRecipeTooltip.deactivateToolTipFor(_parent);
        return;
    end

    --[[
    if not ISCraftRecipeTooltip.recipeDatas or not ISCraftRecipeTooltip.recipeDatas[_player] then
        ISCraftRecipeTooltip.recipeDatas = ISCraftRecipeTooltip.recipeDatas or {};
        ISCraftRecipeTooltip.recipeDatas[_player] = CraftRecipeData.new(CraftMode.Handcraft, true, true, false, true);
    end

    local recipeData = ISCraftRecipeTooltip.recipeDatas[_player];
    recipeData:setRecipe(_recipe);
    --]]

    if _parent.__toolTip ~= nil and _parent.__toolTip.logic==_logic and _parent.__toolTip.recipe==_recipe then
        _parent.__toolTip:setVisible(true);
        _parent.__toolTip:addToUIManager();
        _parent.__toolTip:bringToTop();
        return;
    end

    if _parent.__toolTip ~= nil then
        ISCraftRecipeTooltip.deactivateToolTipFor(_parent);
    end

    _parent.__toolTip = ISCraftRecipeTooltip:new(0,0,100,20, _player, _recipe, _logic, _followMouse, _debugMode); --recipeData, _craftBench, _followMouse);
    _parent.__toolTip.__parent = _parent;
    _parent.__toolTip.titleOnly = _titleOnly;
    _parent.__toolTip.background = true;
    _parent.__toolTip.backgroundColor = {r=0.1, g=0.1, b=0.1, a=1.0};
    _parent.__toolTip:initialise();
    _parent.__toolTip:addToUIManager();

    _parent.__toolTip:calculateLayout(0,0);

    if not _followMouse then
        local ax = _parent:getAbsoluteX();
        local ay = _parent:getAbsoluteY();

        _parent.__toolTip:setX(ax-_parent.__toolTip:getWidth()-8);
        _parent.__toolTip:setY(ay);
    else
        _parent.__toolTip:position();
    end

    if _titleOnly then
        _parent.__toolTip.backgroundColor.a = _parent.__toolTip.titleOnlyAlpha;
    end

    return _parent.__toolTip;
end

function ISCraftRecipeTooltip.deactivateToolTipFor(_parent)
    if _parent and _parent.__toolTip then
        _parent.__toolTip:removeFromUIManager();
        _parent.__toolTip:setVisible(false);
        _parent.__toolTip = nil;
        return true;
    end
    return false;
end