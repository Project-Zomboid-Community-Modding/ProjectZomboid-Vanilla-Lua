--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISCraftRecipeTagsPanel = ISPanel:derive("ISCraftRecipeTagsPanel");

function ISCraftRecipeTagsPanel:initialise()
	ISPanel.initialise(self);
end


function ISCraftRecipeTagsPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;

    local LEFT_BAR_WIDTH = 200+(getCore():getOptionFontSizeReal()*50);

    self.listLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_DebugMenu_Search"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.listLabel:initialise();
    self.listLabel:instantiate();
    self:addChild(self.listLabel);

    self.entryBox = ISTextEntryBox:new("", x+self.listLabel.width+UI_BORDER_SPACING, y, self.width-self.listLabel.width-UI_BORDER_SPACING*3-2, BUTTON_HGT);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISCraftRecipeTagsPanel.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self:addChild(self.entryBox);

    y = self.entryBox:getBottom()+UI_BORDER_SPACING;

    self.list = ISScrollingListBox:new(UI_BORDER_SPACING+1, y, LEFT_BAR_WIDTH, self.height - y - UI_BORDER_SPACING*2-2);
    self.list.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.list:initialise();
    self.list:instantiate();
    self.list.itemheight = BUTTON_HGT;
    self.list.selected = 0;
    self.list.font = UIFont.Small;
    self.list.doDrawItem = ISCraftRecipeTagsPanel.drawTagListItem;
    self.list.target = self;
    self.list.onmousedown = ISCraftRecipeTagsPanel.onTagSelected;
    self.list.drawBorder = true;
    self.list.modColor = namedColorToTable("CornFlowerBlue");
    self:addChild(self.list);

    y = self.list:getY();
    x = self.list:getX() + self.list:getWidth() + 10;

    self.recipeList = ISScrollingListBox:new(x, y, self:getWidth()-(x*2-1), self.height - y - UI_BORDER_SPACING);
    self.recipeList.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.recipeList:initialise();
    self.recipeList:instantiate();
    self.recipeList.itemheight = BUTTON_HGT*2;
    self.recipeList.selected = 0;
    self.recipeList.font = UIFont.Small;
    self.recipeList.doDrawItem = ISCraftRecipeTagsPanel.drawRecipeListItem;
    self.recipeList.target = self;
    self.recipeList.drawBorder = true;
    self.recipeList.modColor = namedColorToTable("CornFlowerBlue");
    self:addChild(self.recipeList);

    self:populate();
end

function ISCraftRecipeTagsPanel:onResize(_width, _height)
    ISPanel.onResize(self, _width, _height);

    self.list:setHeight(self.height - self.list:getY() - UI_BORDER_SPACING - 1);

    local x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;
    local midWidth = self.width - x - UI_BORDER_SPACING - 1;

    self.recipeList:setWidth(midWidth);
    self.recipeList:setHeight(self.height - self.recipeList:getY() - UI_BORDER_SPACING - 1);
end

function ISCraftRecipeTagsPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISCraftRecipeTagsPanel.onTextChange(box)
    if not box then
        return;
    end
    if box:getInternalText()~=box.target.searchText then
        box.target.searchText = box:getInternalText();
        box.target:populate();
    end
end

function ISCraftRecipeTagsPanel:onButtonClick(_button)
end

local sortTags = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISCraftRecipeTagsPanel:populate()
    self.list:clear()

    local needle = self.searchText;
    if (not self.searchText) or self.searchText=="" then
        needle = false;
    end
    
    local tags = CraftRecipeManager.getAllRecipeTags();

    if not tags then
        return;
    end
    
    local temp = {};
    for i=0,tags:size()-1 do
        local tag = tags:get(i);

        local found = true;
        if needle then
            found = string.find( string.lower(tag), string.lower(self.searchText) ) and true or false;
        end
        if found then
            local t = {
                tag = tag,
                name = tag,
            }
            table.insert(temp, t);
        end
    end

    table.sort(temp, sortTags);

    for _,item in ipairs(temp) do
        self.list:addItem(item.name, item);
    end

    if self.list.items and #self.list.items>0 then
        --print("SELECTING ELEMENT")
        self.list.selected = 1;
        self:onTagSelected(self.list.items[self.list.selected].item);
    end
end

function ISCraftRecipeTagsPanel:drawTagListItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end

    local x = 5;

    if item.item.name then
        local drawY = y + (self.itemheight/2) - (FONT_HGT_SMALL /2) + 2;
        self:drawText( item.item.name, x, drawY, 1, 1, 1, 1.0, self.font);
    end

    return y + self.itemheight;
end

function ISCraftRecipeTagsPanel:onTagSelected(_item)
    self.selectedTag = _item.tag;
    self:populateRecipes();
end

local sortRecipes = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISCraftRecipeTagsPanel:populateRecipes()
    self.recipeList:clear()

    if not self.selectedTag then
        return;
    end

    local recipes = false;

    if self.selectedTag=="*" then
        recipes = ScriptManager.instance:getAllCraftRecipes();
    else
        recipes = CraftRecipeManager.getRecipesForTag(self.selectedTag);
    end

    if not recipes then
        return;
    end

    local temp = {};
    for i=0,recipes:size()-1 do
        local recipe = recipes:get(i);

        local t = {
            recipe = recipe,
            fulltype = recipe:getScriptObjectFullType(),
            name = recipe:getTranslationName(),
            icon = recipe:getIconTexture(),
        }
        table.insert(temp, t);
    end

    table.sort(temp, sortRecipes);

    for _,item in ipairs(temp) do
        self.recipeList:addItem(item.name, item);
    end

    if self.recipeList.items and #self.recipeList.items>0 then
        --print("SELECTING ELEMENT")
        self.recipeList.selected = 1;
        --self:onFluidListSelected(self.list.items[self.list.selected].item);
    end
end

function ISCraftRecipeTagsPanel:drawRecipeListItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end

    local x = 5;

    if item.item.icon then
        self:drawTextureScaledAspect(item.item.icon, x+2, y+2, self.itemheight-4, self.itemheight-4,  1.0, 1, 1, 1);
    end

    x = x + self.itemheight + 8;

    if item.item.name then
        local drawY = y + (self.itemheight/4) - (FONT_HGT_SMALL /2) + 2;
        --local c = item.item.color;
        self:drawText( item.item.name, x, drawY, 1, 1, 1, 1.0, self.font);
    end
    if item.item.fulltype then
        local drawY = y + ((self.itemheight/4)*3) - (FONT_HGT_SMALL /2) - 1;
        self:drawText( item.item.fulltype, x, drawY, 0.4, 0.4, 0.4, 1.0, self.font);
    end

    return y + self.itemheight;
end

function ISCraftRecipeTagsPanel:prerender()
    ISPanel.prerender(self);
end


function ISCraftRecipeTagsPanel:render()
    ISPanel.render(self)
end

function ISCraftRecipeTagsPanel:update()
    ISPanel.update(self)

    if self.recipeList then
        self.tooltipRecipe = nil;
        if self.recipeList.mouseoverselected and self.recipeList.mouseoverselected>0 then
            self.tooltipRecipe = self.recipeList.items[self.recipeList.mouseoverselected].item.recipe;
        end
        self:updateTooltip();
    end
end

function ISCraftRecipeTagsPanel:close()
end

function ISCraftRecipeTagsPanel:updateTooltip()
    if (not self.tooltipRecipe) then
        self:deactivateTooltip();
        return;
    end

    if self.activeTooltip and self.tooltipRecipe==self.activeTooltip.recipe then
        return;
    end

    local titleOnly = self.tooltipCounter>0;
    if self.activeTooltip then
        self.activeTooltip:setRecipe(self.tooltipRecipe, titleOnly);
    else
        self.activeTooltip = ISCraftRecipeTooltip.activateToolTipFor(self.recipeList, self.player, self.tooltipRecipe, nil, true, titleOnly, true);
    end
end

function ISCraftRecipeTagsPanel:deactivateTooltip()
    if self.activeTooltip then
        ISCraftRecipeTooltip.deactivateToolTipFor(self.recipeList);
        self.activeTooltip = nil;
    end
end

function ISCraftRecipeTagsPanel:close()
end

function ISCraftRecipeTagsPanel:new (x, y, width, height, player)
	local o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.searchText = "";
    --o.modColor = namedColorToTable("CornFlowerBlue");

    o.tooltipCounter = 0;
    o.activeTooltip = nil;
	return o
end