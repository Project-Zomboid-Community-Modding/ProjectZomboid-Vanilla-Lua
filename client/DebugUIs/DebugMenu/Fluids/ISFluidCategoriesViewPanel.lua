--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISFluidCategoriesViewPanel = ISPanel:derive("ISFluidCategoriesViewPanel");

function ISFluidCategoriesViewPanel:initialise()
	ISPanel.initialise(self);
end


function ISFluidCategoriesViewPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;

    local LEFT_BAR_WIDTH = 100+(getCore():getOptionFontSizeReal()*50);

    self.listLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_DebugMenu_Search"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.listLabel:initialise();
    self.listLabel:instantiate();
    self:addChild(self.listLabel);

    self.entryBox = ISTextEntryBox:new("", x+self.listLabel.width+UI_BORDER_SPACING, y, LEFT_BAR_WIDTH-self.listLabel.width-UI_BORDER_SPACING, BUTTON_HGT);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISFluidCategoriesViewPanel.onTextChange;
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
    self.list.doDrawItem = ISFluidCategoriesViewPanel.drawCategoryListItem;
    self.list.target = self;
    self.list.onmousedown = ISFluidCategoriesViewPanel.onCategorySelected;
    self.list.drawBorder = true;
    self.list.modColor = namedColorToTable("CornFlowerBlue");
    self:addChild(self.list);

    y = self.list:getY();
    x = self.list:getX() + self.list:getWidth() + 10;

    self.fluidList = ISScrollingListBox:new(x, y, self:getWidth()-(x*2-1), self.height - y - UI_BORDER_SPACING);
    self.fluidList.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.fluidList:initialise();
    self.fluidList:instantiate();
    self.fluidList.itemheight = BUTTON_HGT*2;
    self.fluidList.selected = 0;
    self.fluidList.font = UIFont.Small;
    self.fluidList.doDrawItem = ISFluidCategoriesViewPanel.drawFluidListItem;
    self.fluidList.target = self;
    self.fluidList.drawBorder = true;
    self.fluidList.modColor = namedColorToTable("CornFlowerBlue");
    self:addChild(self.fluidList);

    self:populate();
end

function ISFluidCategoriesViewPanel:onResize(_width, _height)
    ISPanel.onResize(self, _width, _height);

    self.list:setHeight(self.height - self.list:getY() - UI_BORDER_SPACING - 1);

    local x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;
    local midWidth = self.width - x - UI_BORDER_SPACING - 1;

    self.fluidList:setWidth(midWidth);
    self.fluidList:setHeight(self.height - self.fluidList:getY() - UI_BORDER_SPACING - 1);
end

function ISFluidCategoriesViewPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISFluidCategoriesViewPanel.onTextChange(box)
    if not box then
        return;
    end
    if box:getInternalText()~=box.target.searchText then
        box.target.searchText = box:getInternalText();
        box.target:populate();
    end
end

function ISFluidCategoriesViewPanel:onButtonClick(_button)
end

local sortCategories = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISFluidCategoriesViewPanel:populate()
    self.list:clear()

    local needle = self.searchText;
    if (not self.searchText) or self.searchText=="" then
        needle = false;
    end
    
    local categories = FluidCategory.getList();

    if not categories then
        return;
    end
    
    local temp = {};
    for i=0,categories:size()-1 do
        local category = categories:get(i);

        local found = true;
        if needle then
            found = string.find( string.lower(category:toString()), string.lower(self.searchText) ) and true or false;
        end
        if found then
            local t = {
                category = category,
                name = category:toString(),
            }
            table.insert(temp, t);
        end
    end

    table.sort(temp, sortCategories);

    for _,item in ipairs(temp) do
        self.list:addItem(item.name, item);
    end

    if self.list.items and #self.list.items>0 then
        --print("SELECTING ELEMENT")
        self.list.selected = 1;
        self:onCategorySelected(self.list.items[self.list.selected].item);
    end
end

function ISFluidCategoriesViewPanel:drawCategoryListItem(y, item, alt)
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

function ISFluidCategoriesViewPanel:onCategorySelected(_item)
    self.selectedCategory = _item.category;
    self:populateFluids();
end

local sortFluids = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISFluidCategoriesViewPanel:populateFluids()
    self.fluidList:clear()

    if not self.selectedCategory then
        return;
    end

    local fluids = Fluid.getAllFluids();
    if not fluids then
        return;
    end

    local temp = {};
    for i=0,fluids:size()-1 do
        local fluid = fluids:get(i);

        local found = true;
        if not fluid:isCategory(self.selectedCategory) then
            found = false;
        end
        if found then
            local t = {
                fluid = fluid,
                fulltype = fluid:getFluidTypeString(),
                name = fluid:getDisplayName(),
                vanilla = fluid:isVanilla(),
                color = fluid:getColor(),
                poison = fluid:isPoisonous(),
            }
            table.insert(temp, t);
        end
    end

    table.sort(temp, sortFluids);

    for _,item in ipairs(temp) do
        self.fluidList:addItem(item.name, item);
    end

    if self.fluidList.items and #self.fluidList.items>0 then
        --print("SELECTING ELEMENT")
        self.fluidList.selected = 1;
        --self:onFluidListSelected(self.list.items[self.list.selected].item);
    end
end

function ISFluidCategoriesViewPanel:drawFluidListItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    --if self.selected == item.index then
    --    self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    --end

    local x = 5;
    local r,g,b = item.item.color:getRedFloat(), item.item.color:getGreenFloat(), item.item.color:getBlueFloat();

    local cy = y+(self.itemheight/2);
    self:drawRect(x+1, cy-10, 20, 20, 1.0, r, g, b);
    self:drawRectBorder( x-1, cy-12, 24, 24, 0.2, 1.0, 1.0, 1.0)

    x = 34;

    if item.item.name then
        local drawY = y + (self.itemheight/4) - (FONT_HGT_SMALL /2) + 2;
        --local c = item.item.color;
        if item.item.fluid:getFluidType()==FluidType.Modded then
            --r,g,b = Colors.CornFlowerBlue:getRedFloat(), Colors.CornFlowerBlue:getGreenFloat(), Colors.CornFlowerBlue:getBlueFloat();
            self:drawText( "[M] "..item.item.name, x, drawY, self.modColor.r, self.modColor.g, self.modColor.b, 1.0, self.font);
        else
            self:drawText( item.item.name, x, drawY, 1, 1, 1, 1.0, self.font);
        end
    end
    if item.item.fulltype then
        local drawY = y + ((self.itemheight/4)*3) - (FONT_HGT_SMALL /2) - 1;
        self:drawText( "<"..item.item.fulltype..">", x, drawY, 0.3, 0.3, 0.3, 1.0, self.font);
    end

    return y + self.itemheight;
end

function ISFluidCategoriesViewPanel:prerender()
    ISPanel.prerender(self);
end


function ISFluidCategoriesViewPanel:render()
    ISPanel.render(self)
end

function ISFluidCategoriesViewPanel:close()
end

function ISFluidCategoriesViewPanel:new (x, y, width, height, player)
	local o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.searchText = "";
    --o.modColor = namedColorToTable("CornFlowerBlue");
	return o
end