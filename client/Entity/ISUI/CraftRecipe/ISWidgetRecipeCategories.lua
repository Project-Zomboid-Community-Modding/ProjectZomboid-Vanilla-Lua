--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: tea-amuller				   **
--***********************************************************

--[[
    This widget displays a list of recipe categories.
--]]
require "ISUI/ISPanel"

local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local UI_BORDER_SPACING = 10
local MIN_LIST_BOX_WIDTH = 125 * FONT_SCALE;

ISWidgetRecipeCategories = ISPanel:derive("ISWidgetRecipeCategories");

--************************************************************************--
--** ISWidgetRecipeCategories:initialise
--**
--************************************************************************--

function ISWidgetRecipeCategories:initialise()
    ISPanel.initialise(self);
end

function ISWidgetRecipeCategories:createChildren()
    ISPanel.createChildren(self);

    self.recipeCategoryPanel = ISScrollingListBox:new(0, 0, self.listBoxWidth or MIN_LIST_BOX_WIDTH, 0);
    self.recipeCategoryPanel:initialise();
    self.recipeCategoryPanel:instantiate();
    self.recipeCategoryPanel.itemheight = ISCraftingUI.smallFontHeight + UI_BORDER_SPACING;
    self.recipeCategoryPanel.selected = 0;
    --self.recipeCategoryPanel.joypadParent = self;
    self.recipeCategoryPanel.font = UIFont.Small
    self.recipeCategoryPanel.drawBorder = true
    self.recipeCategoryPanel:setOnMouseDownFunction(self, self.onCategoryChanged);
    self.recipeCategoryPanel.drawDebugLines = self.drawDebugLines;

    self:addChild(self.recipeCategoryPanel);

end

function ISWidgetRecipeCategories:calculateLayout(_preferredWidth, _preferredHeight)
    local biggestSize = 0;
    if self.autoWidth then
        for i,v in pairs(self.recipeCategoryPanel.items) do
            local size = getTextManager():MeasureStringX(UIFont.Small, v.text)
            if size > biggestSize then
                biggestSize = size;
            end
        end
    end

    if biggestSize > 0 and biggestSize > MIN_LIST_BOX_WIDTH then 
        local desiredWidth = biggestSize + (UI_BORDER_SPACING * FONT_SCALE);
        if self.recipeCategoryPanel.vscroll then
            desiredWidth = desiredWidth + self.recipeCategoryPanel.vscroll:getWidth();
        end
        
        self:setWidth(desiredWidth);
        self.recipeCategoryPanel:setWidth(self:getWidth())
    else
        self:setWidth(self.listBoxWidth or MIN_LIST_BOX_WIDTH);
    end

    if self.recipeCategoryPanel.vscroll then
        self.recipeCategoryPanel.vscroll:setX(self.recipeCategoryPanel:getWidth()-self.recipeCategoryPanel.vscroll:getWidth());
    end
    
    self:setHeight(_preferredHeight);
    self:setInternalHeight(_preferredHeight);
end

function ISWidgetRecipeCategories:onResize()
    ISUIElement.onResize(self)
end

function ISWidgetRecipeCategories:prerender()
    ISPanel.prerender(self);

    self.recipeCategoryPanel.vscroll:setHeight(self.recipeCategoryPanel.height);
end

function ISWidgetRecipeCategories:render()
    ISPanel.render(self);
end

function ISWidgetRecipeCategories:update()
    ISPanel.update(self);
end

function ISWidgetRecipeCategories:setInternalHeight(_height)
    if self.recipeCategoryPanel then
        self.recipeCategoryPanel:setHeight(_height);
    end
end

function ISWidgetRecipeCategories:populateCategoryList()
    self.recipeCategoryPanel:clear();
    self.recipeCategoryPanel:addItem("-- ALL --", "");
    self.recipeCategoryPanel:addItem("Favourites", "*");

    local currentCategoryFilterFound = self.selectedCategory == "";

    if self.selectedCategory == "*" then
        self.recipeCategoryPanel.selected = 2;
        currentCategoryFilterFound = true;
    end

    --local categories = self.logic:getCategoryList();
    local categories = self.callbackTarget:getCategoryList();
    for i = 0, categories:size()-1 do
        local categoryNameCapitalised = string.upper(string.sub(categories:get(i), 1, 1)) .. string.sub(categories:get(i), 2, string.len(categories:get(i)));
        local item = self.recipeCategoryPanel:addItem(categoryNameCapitalised, categories:get(i));

        if categories:get(i) == self.selectedCategory then
            self.recipeCategoryPanel.selected = item.itemindex;
            currentCategoryFilterFound = true;
        end
    end

    if not currentCategoryFilterFound then
        -- reset filter
        self:onCategoryChanged("");
    end

    if categories:size() > 0 then
        self.isInitialised = true;
    end
end

function ISWidgetRecipeCategories:onCategoryChanged(_item)
    self.selectedCategory = _item;

    -- Selected category changed, tell our parent
    self.callbackTarget:onCategoryChanged(_item);
end

--************************************************************************--
--** ISWidgetRecipeCategories:new
--**
--************************************************************************--
function ISWidgetRecipeCategories:new(x, y, width, height)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.isInitialised = false;

    return o;
end