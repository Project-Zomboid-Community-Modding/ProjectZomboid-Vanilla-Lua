--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISWidgetRecipeTools = ISPanel:derive("ISWidgetRecipeTools");

--************************************************************************--
--** ISWidgetRecipeTools:initialise
--**
--************************************************************************--

function ISWidgetRecipeTools:initialise()
	ISPanel.initialise(self);
end

function ISWidgetRecipeTools:createChildren()
    ISPanel.createChildren(self);

    local fontHeight = -1; -- <=0 sets label initial height to font
    self.toolsLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, getText("IGUI_CraftingWindow_Tools"), 1.0, 1.0, 1.0, 1, UIFont.Medium, true);
    --self.amountLabel.scriptAmount = amount;
    self.toolsLabel:initialise();
    self.toolsLabel:instantiate();
    --self.amountLabel:setName("1000 / 1000");
    self:addChild(self.toolsLabel);

    local recipe = self.logic and self.logic:getRecipe() or self.recipe;

    self.colDisabled = { r=0.3, g=0.3, b=0.3 }
    self.colEnabled = { r=0.7, g=0.7, b=0.7 }
    self.colTextEnabled = { r=1.0, g=1.0, b=1.0 }
    self.colBad = safeColorToTable(self.xuiSkin:color("C_InvalidRed"));

    self.left = self:createToolSide(recipe, true);

    self.right = self:createToolSide(recipe, false);

end

function ISWidgetRecipeTools:createToolSide(_recipe, _doLeft)
    local table = {};

    local fontHeight = -1; -- <=0 sets label initial height to font

    if _doLeft then
        table.enabled = _recipe:getToolLeft()~=nil;
        table.inputScript = _recipe:getToolLeft();
    else
        table.enabled = _recipe:getToolRight()~=nil;
        table.inputScript = _recipe:getToolRight();
    end

    if table.enabled and table.inputScript:isAutomationOnly() then
        table.enabled = false;
    end

    local c = table.enabled and self.colEnabled or self.colDisabled;

    if table.enabled then
        table.inputWidget = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISWidgetInput, 0, 0, 10, 10, self.player, self.logic, table.inputScript);
        table.inputWidget.interactiveMode = self.interactiveMode;
        table.inputWidget:initialise();
        table.inputWidget:instantiate();
    end

    table.icon = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, self.iconSize, self.iconSize, nil);
    table.icon.autoScale = true;
    --table.icon.doBorder = true;
    table.icon.borderColor.a = 1;
    if not table.enabled then
        table.icon.borderColor = {r=c.r, g=c.g, b=c.b, a=0.7};
    end
    table.icon:initialise();
    table.icon:instantiate();
    self:addChild(table.icon);

    table.icon.tooltipUI = ISToolTip:new();
    table.icon.tooltipUI:setOwner(table.icon);
    table.icon.tooltipUI:setVisible(false);
    table.icon.tooltipUI:setAlwaysOnTop(true);
    table.icon.tooltipUI.maxLineWidth = 1000 -- don't wrap the lines
    table.icon.tooltipUI.nameMarginX = 0;
    table.icon.tooltipUI.defaultMyWidth = 0;

--     table.iconKeep = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISImage, 0, 0, 24, 24, self.textureKeep);
--     table.iconKeep.autoScale = true;
--     table.iconKeep:initialise();
--     table.iconKeep:instantiate();
--     table.iconKeep:setVisible(table.enabled and table.inputWidget.primary.isKeep);
--     self:addChild(table.iconKeep);

    c = table.enabled and self.colTextEnabled or self.colDisabled;
    local text = _doLeft and getText("IGUI_CraftingWindow_ToolLeft") or getText("IGUI_CraftingWindow_ToolRight");
    table.label = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, text, c.r, c.g, c.b, 1, UIFont.Large, true);
    --self.amountLabel.scriptAmount = amount;
    table.label:initialise();
    table.label:instantiate();
    --self.amountLabel:setName("1000 / 1000");
    self:addChild(table.label);

    return table;
end

function ISWidgetRecipeTools:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local editModeMargin = 24;

    local minHeight = (self.margin*2) + self.iconSize;
    local minWidth = self.margin*2;
    if self.editMode then
        minWidth = minWidth + (2*editModeMargin)+(self.margin*2);
    end

    minWidth = minWidth + (self.iconSize*2);
    minWidth = minWidth + self.toolsLabel:getWidth();
    minWidth = minWidth + self.left.label:getWidth();
    minWidth = minWidth + self.right.label:getWidth();
    minWidth = minWidth + (self.margin*4);

    width = math.max(width, minWidth);
    height = math.max(height, minHeight);

    local centerX = width/2;
    self.toolsLabel:setX(centerX - (self.toolsLabel:getWidth()/2));
    self.toolsLabel.originalX = self.toolsLabel:getX();
    self.toolsLabel:setY(self.margin-2);
    if not self.editMode then
        self.toolsLabel:setY((height/2)-(self.toolsLabel:getHeight()/2));
    end

    local x = self.margin;
    if self.editMode then x = x+editModeMargin+self.margin; end
    self.left.icon:setX(x);
    self.left.icon:setY(self.margin);
    x = self.left.icon:getX() + self.left.icon:getWidth() + self.margin + 2;

    local iconMid = self.left.icon:getX() + (self.left.icon:getWidth() / 2);
--     self.left.iconKeep:setX(iconMid - (self.left.iconKeep:getWidth()/2));
--     self.left.iconKeep:setY(height - self.left.iconKeep:getHeight() - 1);

    self.left.label:setX(x);
    self.left.label.originalX = self.left.label:getX();
    self.left.label:setY((height/2) - (self.left.label:getHeight()/2));

    x = width - self.margin - self.right.icon:getWidth();
    if self.editMode then x = x-editModeMargin-self.margin; end
    self.right.icon:setX(x);
    self.right.icon:setY(self.margin);
    x = x - self.margin - self.right.label:getWidth() - 2;

    iconMid = self.right.icon:getX() + (self.right.icon:getWidth() / 2);
--     self.right.iconKeep:setX(iconMid - (self.right.iconKeep:getWidth()/2));
--     self.right.iconKeep:setY(height - self.right.iconKeep:getHeight() - 1);

    self.right.label:setX(x);
    self.right.label.originalX = self.right.label:getX();
    self.right.label:setY((height/2) - (self.right.label:getHeight()/2));

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetRecipeTools:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetRecipeTools:prerender()
    ISPanel.prerender(self);

    self:updateToolValues(self.left);
    self:updateToolValues(self.right);

    if self.doToolBorder then
        if self.left then
            local c = self.left.icon.borderColor;
            self:drawRectBorder(self.left.icon:getX()-2, self.left.icon:getY()-2, self.left.icon:getWidth()+4, self.left.icon:getHeight()+4, 1.0, c.r, c.g, c.b);
        end
        if self.right then
            local c = self.right.icon.borderColor;
            self:drawRectBorder(self.right.icon:getX()-2, self.right.icon:getY()-2, self.right.icon:getWidth()+4, self.right.icon:getHeight()+4, 1.0, c.r, c.g, c.b);
        end
    end
end

function ISWidgetRecipeTools:updateToolValues(_table)
    if _table.enabled then
        _table.inputWidget:updateValues();
        _table.icon.texture = _table.inputWidget.primary.icon.texture;
        _table.icon.backgroundColor.a = _table.inputWidget.primary.icon.backgroundColor.a;
        _table.icon:setMouseOverText(_table.inputWidget.primary.iconText);
        local c = self.colEnabled;
        if self.logic and (not self.logic:isInputSatisfied(_table.inputScript)) then
            c = self.colBad;
        end
        _table.icon.borderColor.r = c.r;
        _table.icon.borderColor.g = c.g;
        _table.icon.borderColor.b = c.b;

        --_table.iconKeep:setVisible(_table.enabled and _table.inputWidget.primary.isKeep);
--         _table.iconKeep.backgroundColor.a = _table.inputWidget.iconKeep.backgroundColor.a
    end
end

function ISWidgetRecipeTools:render()
    ISPanel.render(self);
end

function ISWidgetRecipeTools:update()
    ISPanel.update(self);
end


--************************************************************************--
--** ISWidgetRecipeTools:new
--**
--************************************************************************--
function ISWidgetRecipeTools:new(x, y, width, height, player, logic) -- recipeData, craftBench)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.background = true;
    --o.margin = 5;
    o.player = player;
    o.logic = logic;
    --o.recipeData = recipeData;
    --o.craftBench = craftBench;
    o.editMode = false;

    o.iconSize = 32;

    o.doToolBorder = true;

    o.textureKeep = getTexture("media/ui/Entity/Crafting_Keep_24.png");
    o.textureDrain = getTexture("media/ui/Entity/Crafting_Drain_24.png");
--     o.textureKeep = getTexture("media/ui/Entity/keep_item_icon.png");

    o.margin = 5;
    o.minimumWidth = 0;
    o.minimumHeight = 0;

    --o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;
    return o;
end