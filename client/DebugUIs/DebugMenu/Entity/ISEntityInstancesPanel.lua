--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISEntityInstancesPanel = ISPanel:derive("ISEntityInstancesPanel");

function ISEntityInstancesPanel:initialise()
	ISPanel.initialise(self);
end


function ISEntityInstancesPanel:createChildren()
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
    self.entryBox.onTextChange = ISEntityInstancesPanel.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self:addChild(self.entryBox);

    y = self.entryBox:getBottom()+UI_BORDER_SPACING;

    self.list = ISScrollingListBox:new(x, y, LEFT_BAR_WIDTH, self.height - y - UI_BORDER_SPACING*2-2);
    self.list.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.list:initialise();
    self.list:instantiate();
    self.list.itemheight = BUTTON_HGT*2;
    self.list.selected = 0;
    self.list.font = UIFont.Small;
    self.list.doDrawItem = ISEntityInstancesPanel.drawEntityListItem;
    self.list.target = self;
    self.list.onmousedown = ISEntityInstancesPanel.onEntityListSelected;
    self.list.drawBorder = true;
    self:addChild(self.list);

    y = self.listLabel:getY();
    x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;

    local tickOptions = {};
    table.insert(tickOptions, { text = getText("IGUI_Entities_Instances_DebugUI"), ticked = getDebugOptions():getBoolean("Entity.DebugUI") });
    local y2,obj2 = ISDebugUtils.addTickBox(self, {}, x, y, BUTTON_HGT, BUTTON_HGT, "Tooltip", tickOptions, ISEntityInstancesPanel.onEntityDebugUI);

    y = self.list:getY();
    x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;

    local midWidth = self.width - x - UI_BORDER_SPACING;

    self.reloadScriptsButton = ISButton:new(x, y, midWidth,BUTTON_HGT,getText("IGUI_Entities_Instances_ReloadScripts"),self, ISEntityInstancesPanel.onButtonClick);
    self.reloadScriptsButton:initialise();
    self.reloadScriptsButton:instantiate();
    self.reloadScriptsButton.enable = true;
    self:addChild(self.reloadScriptsButton);

    y = self:incY(y, self.reloadScriptsButton, UI_BORDER_SPACING);

    self.reloadButton = ISButton:new(x, y, midWidth,BUTTON_HGT,getText("IGUI_Entities_Instances_ReloadEntities"),self, ISEntityInstancesPanel.onButtonClick);
    self.reloadButton:initialise();
    self.reloadButton:instantiate();
    self.reloadButton.enable = true;
    self:addChild(self.reloadButton);

    y = self:incY(y, self.reloadButton, UI_BORDER_SPACING);

    self.entityPanel = ISEntityViewPanel:new(x, y, self:getWidth()-(x*2-1), self.height - y - UI_BORDER_SPACING)
    self.entityPanel:initialise();
    self.entityPanel:instantiate();
    self:addChild(self.entityPanel);

    self:populate();
end

function ISEntityInstancesPanel:onResize(_width, _height)
    ISPanel.onResize(self, _width, _height);

    self.list:setHeight(self.height - self.list:getY() - UI_BORDER_SPACING - 1);

    local x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;
    local midWidth = self.width - x - UI_BORDER_SPACING - 1;

    self.reloadScriptsButton:setWidth(midWidth);
    self.reloadButton:setWidth(midWidth);
    self.entityPanel:setWidth(midWidth);
    self.entityPanel:setHeight(self.height - self.entityPanel:getY() - UI_BORDER_SPACING - 1);
end

function ISEntityInstancesPanel:onEntityDebugUI(_index, _selected, _arg1, _arg2, _tickbox)
    getDebugOptions():setBoolean("Entity.DebugUI", _selected);
end

function ISEntityInstancesPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISEntityInstancesPanel.onTextChange(box)
    if not box then
        return;
    end
    if box:getInternalText()~=box.target.searchText then
        box.target.searchText = box:getInternalText();
        box.target:populate();
    end
end

function ISEntityInstancesPanel:onButtonClick(_button)
    if _button==self.reloadButton then
        local reloadTable = ISEntityUI.GetReloadTable();
        ISEntityUI.CloseWindows();
        self:onReloadEntities();

        reloadEntitiesDebug();
        self.selectedEntityItem = false;

        self:populate();

        for k,v in ipairs(reloadTable) do
            if ISEntityUI.CanOpenWindowFor(v.player, v.entity) then
                ISEntityUI.OpenWindow(v.player, v.entity)
            end
        end
    elseif _button==self.reloadScriptsButton then
        local reloadTable = ISEntityUI.GetReloadTable();
        ISEntityUI.CloseWindows();
        self:onReloadEntities();

        reloadEntityScripts();
        self.selectedEntityItem = false;

        self:populate();

        for k,v in ipairs(reloadTable) do
            if ISEntityUI.CanOpenWindowFor(v.player, v.entity) then
                ISEntityUI.OpenWindow(v.player, v.entity)
            end
        end
    end
end

local sortEntities = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISEntityInstancesPanel:populate()
    self.list:clear()

    local needle = self.searchText;
    if (not self.searchText) or self.searchText=="" then
        needle = false;
    end

    local entities = getIsoEntitiesDebug();
    if not entities then
        return;
    end
    local temp = {};
    for i=0,entities:size()-1 do
        local entity = entities:get(i);

        local found = true;
        if needle then
            found = string.find( string.lower(entity:getEntityFullTypeDebug()), string.lower(self.searchText) ) and true or false;
            if not found then
                found = string.find( string.lower(entity:getEntityDisplayName()), string.lower(self.searchText) ) and true or false;
            end
        end
        if found then
            local t = {
                entity = entity,
                fulltype = entity:getEntityFullTypeDebug(),
                name = entity:getEntityDisplayName(),
                meta = entity:isMeta(),
            }
            table.insert(temp, t);
        end
    end

    table.sort(temp, sortEntities);

    for _,item in ipairs(temp) do
        self.list:addItem(item.name, item);
    end

    if self.list.items and #self.list.items>0 then
        --print("SELECTING ELEMENT")
        self.list.selected = 1;
        self:onEntityListSelected(self.list.items[self.list.selected].item);
    end
end

function ISEntityInstancesPanel:drawEntityListItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end


    if item.item.name then
        local drawY = y + (self.itemheight/4) - (FONT_HGT_SMALL/2) + 2;
        --local c = item.item.color;
        if item.item.meta then
            self:drawText( "(meta) "..item.item.name, 5, drawY, 0.8, 0.8, 1, 1.0, self.font);
        else
            self:drawText( item.item.name, 5, drawY, 1, 1, 1, 1.0, self.font);
        end
    end
    if item.item.fulltype then
        local drawY = y + ((self.itemheight/4)*3) - (FONT_HGT_SMALL/2) - 1;
        self:drawText( item.item.fulltype, 5, drawY, 0.4, 0.4, 0.4, 1.0, self.font);
    end

    return y + self.itemheight;
end

function ISEntityInstancesPanel:onEntityListSelected(_item)
    if self.selectedEntityItem and self.selectedEntityItem.entity and not (self.selectedEntityItem.entity.meta) then
        self.selectedEntityItem.entity:setHighlighted(false);
        self.selectedEntityItem.entity:setBlink(false);
    end
    self.selectedEntityItem = _item;

    if self.selectedEntityItem then
        if self.selectedEntityItem.entity and not (self.selectedEntityItem.entity.meta) then
            self.selectedEntityItem.entity:setHighlightColor(1.0, 0.0, 0.0, 1);
            self.selectedEntityItem.entity:setHighlighted(true, false);
            self.selectedEntityItem.entity:setBlink(true);
        end
        self.entityPanel:setEntity(self.selectedEntityItem.entity);
    else
        self.entityPanel:setEntity(nil);
    end
end

function ISEntityInstancesPanel:prerender()
    ISPanel.prerender(self);
end


function ISEntityInstancesPanel:render()
    ISPanel.render(self)
end

function ISEntityInstancesPanel:close()
    self:onReloadEntities();
end

function ISEntityInstancesPanel:onReloadEntities()
    if self.selectedEntityItem and self.selectedEntityItem.entity and not (self.selectedEntityItem.entity.meta) then
        self.selectedEntityItem.entity:setHighlighted(false);
        self.selectedEntityItem.entity:setBlink(false);
    end
end

function ISEntityInstancesPanel:new (x, y, width, height, player)
	local o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.searchText = "";
	return o
end