require "ISUI/ISPanel"

local UI_BORDER_SPACING = 10
local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, (FONT_SCALE - math.floor(FONT_SCALE)) < 0.5 and math.floor(FONT_SCALE) or math.ceil(FONT_SCALE));
local LIST_ICON_SIZE = 32 * ICON_SCALE;

ISWidgetRecipeListPanel = ISPanel:derive("ISWidgetRecipeListPanel");

function ISWidgetRecipeListPanel:initialise()
    ISPanel.initialise(self);
end

function ISWidgetRecipeListPanel:createChildren()
    ISPanel.createChildren(self);

    self.recipeListPanel = ISRecipeScrollingListBox:new(0, 0, 10, 10, self.player, self.logic);
    self.recipeListPanel:initialise();
    self.recipeListPanel:instantiate();

    self.recipeListPanel.onItemMouseHover = function(_self, _item)
        self.callbackTarget:onRecipeItemMouseHover(_item);
    end
    --
    self.recipeListPanel.onScrolled = function(_self)
        self.callbackTarget:onRecipeListPanelScrolled();
    end

    self.recipeListPanel:setOnMouseDownFunction(self, function(_self, _recipe) _self.logic:setRecipe(_recipe) end);
    self.recipeListPanel.drawDebugLines = self.drawDebugLines;

    self:addChild(self.recipeListPanel);
end

function ISWidgetRecipeListPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    if self.expandToFitTooltip and self.recipeListPanel and self.recipeListPanel.items then
        for k, v in ipairs(self.recipeListPanel.items) do
            local craftRecipe = v and v.item;
            if craftRecipe then
                local text = craftRecipe:getTooltip() and getText(craftRecipe:getTooltip());
                local tooltipWidth = UI_BORDER_SPACING + LIST_ICON_SIZE + UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Small, text) + UI_BORDER_SPACING + (self.recipeListPanel.vscroll and self.recipeListPanel.vscroll:getWidth() or 0);
                if v.itemindex == 1 or tooltipWidth > self.largestTooltipWidth then
                    self.largestTooltipWidth = tooltipWidth;
                end
            end
        end
        
        width = math.max(width, self.largestTooltipWidth);
    end
    
    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetRecipeListPanel:onResize()
    ISUIElement.onResize(self)

    if self.recipeListPanel and self.recipeListPanel.selected then
        self.recipeListPanel:ensureVisible(self.recipeListPanel.selected);
    end
end

function ISWidgetRecipeListPanel:prerender()
    ISPanel.prerender(self);

    if self.recipeListPanel and self.recipeListPanel.vscroll then
        self.recipeListPanel.vscroll:setHeight(self.recipeListPanel:getHeight());
        self.recipeListPanel.vscroll:setX(self.recipeListPanel:getWidth()-self.recipeListPanel.vscroll:getWidth());
    end
end

function ISWidgetRecipeListPanel:render()
    -- process pending selected data
    if self.pendingSelectedData and self.recipeListPanel and self.recipeListPanel.items then
        for i = 1, #self.recipeListPanel.items do
            if self.recipeListPanel.items[i].item == self.pendingSelectedData then
                self.recipeListPanel.selected = i;
                self.recipeListPanel:ensureVisible(i);
                break;
            end
        end
        self.pendingSelectedData = nil;
    end
    
    ISPanel.render(self);
    self:renderJoypadFocus()

    -- show no recipes tooltip
    if #self.recipeListPanel.items == 0 then
        self:repaintStencilRect(0, 0, self.width, self.height)
        local tooltipStr = getText("IGUI_CraftingWindow_NoRecipes");
        local stringWidth = getTextManager():MeasureStringX(UIFont.Small, tooltipStr);
        local stringHeight = getTextManager():MeasureStringY(UIFont.Small, tooltipStr);
        local x = (self.recipeListPanel:getWidth() - stringWidth) / 2;
        local y = (self.recipeListPanel:getHeight() - stringHeight) / 2;
        local padding = 20;
        local boxX, boxY = math.max(0, self.recipeListPanel:getX() + x - padding), math.max(0, self.recipeListPanel:getY() + y - padding);
        local boxWidth, boxHeight = math.min(padding + stringWidth + padding, self.recipeListPanel:getWidth() - x), math.min(padding + stringHeight + padding, self.recipeListPanel:getHeight() - y);
    
        self:drawRect(boxX, boxY, boxWidth, boxHeight, 1, 0, 0, 0);
        self:drawRectBorder(boxX, boxY, boxWidth, boxHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        
        local x = self.recipeListPanel:getX() + ((self.recipeListPanel:getWidth() - stringWidth) / 2);
        local y = self.recipeListPanel:getY() + ((self.recipeListPanel:getHeight() - stringHeight) / 2);
        self:drawText(tooltipStr, x, y, 1.0, 1.0, 1.0, 1.0, UIFont.Small);
    end
end

function ISWidgetRecipeListPanel:update()
    ISPanel.update(self);
end

function ISWidgetRecipeListPanel:setSelectedData(_recipe)
    self.pendingSelectedData = _recipe; -- we defer this, as sometimes the list has not yet been rendered when this is called, and we need those cached heights. - spurcival
end

function ISWidgetRecipeListPanel:setDataList(_recipeCollection)
    local currentRecipe = self.logic:getRecipe();
    
    self.recipeListPanel:clear();
    local recipeFoundIndex = self.recipeListPanel:addGroup(nil, _recipeCollection:getNodes(), currentRecipe, self.enabledShowAllFilter);
    self.recipeListPanel.selected = recipeFoundIndex;
    local selectedItem = self.recipeListPanel.items[recipeFoundIndex];
    local selectedRecipe = selectedItem and selectedItem.item or nil;
    self.logic:setRecipe(selectedRecipe);
end

function ISWidgetRecipeListPanel:setInternalDimensions(_x, _y, _width, _height)
    if self.recipeListPanel then
        self.recipeListPanel:setHeight(_height);
        self.recipeListPanel:setWidth(_width);
        self.recipeListPanel:setX(_x);
        self.recipeListPanel:setY(_y);
    end
end

function ISWidgetRecipeListPanel:new(x, y, width, height, player, logic, callbackTarget)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.player = player;
    o.logic = logic;
    o.callbackTarget = callbackTarget;
    o.enabledShowAllFilter = false;
    
    o.wrapTooltipText = false;
    
    o.expandToFitTooltip = false;
    o.largestTooltipWidth = 0;

    return o
end
