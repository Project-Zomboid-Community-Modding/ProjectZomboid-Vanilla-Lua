--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISCraftRecipeQueriesPanel = ISPanel:derive("ISCraftRecipeQueriesPanel");

function ISCraftRecipeQueriesPanel:initialise()
	ISPanel.initialise(self);
end


function ISCraftRecipeQueriesPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;
    local initY = y;

    local LEFT_BAR_WIDTH = 400+(getCore():getOptionFontSizeReal()*50);

    self.listLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_DebugMenu_Search"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.listLabel:initialise();
    self.listLabel:instantiate();
    self:addChild(self.listLabel);

    self.entryBox = ISTextEntryBox:new("", x+self.listLabel.width+UI_BORDER_SPACING, y, LEFT_BAR_WIDTH-self.listLabel.width-UI_BORDER_SPACING, BUTTON_HGT);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISCraftRecipeQueriesPanel.onTextChange;
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
    self.list.doDrawItem = ISCraftRecipeQueriesPanel.drawQueryListItem;
    self.list.target = self;
    self.list.onmousedown = ISCraftRecipeQueriesPanel.onQuerySelected;
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
    self.recipeList.doDrawItem = ISCraftRecipeQueriesPanel.drawRecipeListItem;
    self.recipeList.target = self;
    self.recipeList.drawBorder = true;
    self.recipeList.modColor = namedColorToTable("CornFlowerBlue");
    self:addChild(self.recipeList);

    y = initY;

    self.queryLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_CraftRecipesDebug_Queries")..":", 1, 1, 1, 1.0, UIFont.Small, true);
    self.queryLabel:initialise();
    self.queryLabel:instantiate();
    self:addChild(self.queryLabel);

    self.BTN_WIDTH = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CraftRecipesDebug_Test")) + UI_BORDER_SPACING
    self.BTN_XOFFSET = self.BTN_WIDTH+(UI_BORDER_SPACING+1);
    self.testQueryButton = ISButton:new(self:getWidth()-self.BTN_XOFFSET, y, self.BTN_WIDTH, BUTTON_HGT,getText("IGUI_CraftRecipesDebug_Test"), self, ISCraftRecipeQueriesPanel.onButtonClick);
    self.testQueryButton:initialise();
    self.testQueryButton:instantiate();
    self.testQueryButton.enable = true;
    self:addChild(self.testQueryButton);

    local qx = x + self.BTN_WIDTH + UI_BORDER_SPACING;
    local qw = self:getWidth() - qx - self.BTN_WIDTH - (UI_BORDER_SPACING*2);
    self.queryBox = ISTextEntryBox:new("", qx, y, qw, BUTTON_HGT);
    self.queryBox.font = UIFont.Small;
    self.queryBox:initialise();
    self.queryBox:instantiate();
    --self.queryBox.onTextChange = ISCraftRecipeQueriesPanel.onTextChange;
    self.queryBox.target = self;
    self.queryBox:setClearButton(true);
    self:addChild(self.queryBox);

    self:populate();
end

function ISCraftRecipeQueriesPanel:onResize(_width, _height)
    ISPanel.onResize(self, _width, _height);

    self.list:setHeight(self.height - self.list:getY() - UI_BORDER_SPACING - 1);

    local x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;
    local midWidth = self.width - x - UI_BORDER_SPACING - 1;

    self.recipeList:setWidth(midWidth);
    self.recipeList:setHeight(self.height - self.recipeList:getY() - UI_BORDER_SPACING - 1);

    self.testQueryButton:setX(self.width-self.BTN_XOFFSET);

    local x = self.queryLabel:getX();
    local qx = x + self.queryLabel:getWidth() + UI_BORDER_SPACING
    local qw = self:getWidth() - qx - self.BTN_WIDTH - (UI_BORDER_SPACING*2);
    self.queryBox:setX(qx);
    self.queryBox:setWidth(qw);
end

function ISCraftRecipeQueriesPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISCraftRecipeQueriesPanel.onTextChange(box)
    if not box then
        return;
    end
    if box:getInternalText()~=box.target.searchText then
        box.target.searchText = box:getInternalText();
        box.target:populate();
    end
end

function ISCraftRecipeQueriesPanel:onButtonClick(_button)
    if _button and _button==self.testQueryButton then
        local query = self.queryBox:getInternalText();
        --print("testing query = "..tostring(query));
        self.selectedQuery = query;
        self:populateRecipes();
        self:populate(true);
    end
end

local sortQueries = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISCraftRecipeQueriesPanel:populate(_noAutoSelect)
    self.list:clear()

    local needle = self.searchText;
    if (not self.searchText) or self.searchText=="" then
        needle = false;
    end
    
    local queries = CraftRecipeManager.getTagGroups();

    if not queries then
        return;
    end
    
    local temp = {};
    for i=0,queries:size()-1 do
        local query = queries:get(i);

        local found = true;
        if needle then
            found = string.find( string.lower(query), string.lower(self.searchText) ) and true or false;
        end
        if found then
            local t = {
                query = query,
                name = query,
            }
            table.insert(temp, t);
        end
    end

    table.sort(temp, sortQueries);

    for _,item in ipairs(temp) do
        self.list:addItem(item.name, item);
    end

    if self.list.items and #self.list.items>0 and (not _noAutoSelect) then
        --print("SELECTING ELEMENT")
        self.list.selected = 1;
        self:onQuerySelected(self.list.items[self.list.selected].item);
    end
end

function ISCraftRecipeQueriesPanel:drawQueryListItem(y, item, alt)
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

function ISCraftRecipeQueriesPanel:onQuerySelected(_item)
    self.selectedQuery = _item.query;
    self:populateRecipes();
end

local sortRecipes = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISCraftRecipeQueriesPanel:populateRecipes()
    self.recipeList:clear()

    if not self.selectedQuery then
        return;
    end

    local recipes = false;

    if self.selectedQuery=="*" then
        recipes = ScriptManager.instance:getAllCraftRecipes();
    else
        --print("Query = "..tostring(self.selectedQuery))
        recipes = CraftRecipeManager.queryRecipes(self.selectedQuery);
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

function ISCraftRecipeQueriesPanel:drawRecipeListItem(y, item, alt)
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

function ISCraftRecipeQueriesPanel:prerender()
    ISPanel.prerender(self);
end


function ISCraftRecipeQueriesPanel:render()
    ISPanel.render(self)
end

function ISCraftRecipeQueriesPanel:update()
    ISPanel.update(self)

    if self.recipeList then
        self.tooltipRecipe = nil;
        if self.recipeList.mouseoverselected and self.recipeList.mouseoverselected>0 then
            self.tooltipRecipe = self.recipeList.items[self.recipeList.mouseoverselected].item.recipe;
        end
        self:updateTooltip();
    end
end

function ISCraftRecipeQueriesPanel:close()
end

function ISCraftRecipeQueriesPanel:updateTooltip()
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

function ISCraftRecipeQueriesPanel:deactivateTooltip()
    if self.activeTooltip then
        ISCraftRecipeTooltip.deactivateToolTipFor(self.recipeList);
        self.activeTooltip = nil;
    end
end

function ISCraftRecipeQueriesPanel:new (x, y, width, height, player)
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