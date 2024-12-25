--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

local SMALL_FONT_HGT = getTextManager():getFontHeight(UIFont.Small);
local MEDIUM_FONT_HGT = getTextManager():getFontHeight(UIFont.Medium);

ISCraftInventoryPanel = ISPanel:derive("ISCraftInventoryPanel");

--************************************************************************--
--** ISCraftInventoryPanel:initialise
--**
--************************************************************************--

function ISCraftInventoryPanel:initialise()
	ISPanel.initialise(self);
end

function ISCraftInventoryPanel:createChildren()
    ISPanel.createChildren(self);

    self.colGood = safeColorToTable(self.xuiSkin:color("C_ValidGreen"));
    self.colBad = safeColorToTable(self.xuiSkin:color("C_InvalidRed"));

    self.itemListBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISScrollingListBox, 0, 0, 100, 44);

	self.itemListBox.anchorLeft = false;
	self.itemListBox.anchorRight = false;
	self.itemListBox.anchorTop = false;
	self.itemListBox.anchorBottom = false;
    self.itemListBox.onMouseMove = function (_self, dx, dy)
        ISScrollingListBox.onMouseMove(_self, dx, dy)
        if _self.mouseoverselected>0 and _self.items[_self.mouseoverselected] then
            local data = _self.items[_self.mouseoverselected].item;

            if (not data) or data.isHeader or data.isNode then
                if _self.tooltipItem then
                    _self.tooltipItem:setVisible(false);
                end                
                if _self.tooltipItemUnavail then
                    _self.tooltipItemUnavail:setVisible(false);
                end
                return;
            end

            local row = -1;
            local lx = getMouseX() - _self:getAbsoluteX();
            local ly = getMouseY() - _self:getAbsoluteY();
            local sbarWid = 0
            if _self.vscroll and _self.vscroll:isVScrollBarVisible() then
                sbarWid = _self.vscroll:getWidth()
            end
            if lx < _self.width - sbarWid then
                --row = self:rowAt(self:getMouseX(), self:getMouseY())
                if not _self.tooltipItem then
                    _self.tooltipItem = ISToolTipInv:new(data.inventoryItem);
                    _self.tooltipItem:addToUIManager();
                end
                if not _self.tooltipItemUnavail then
                    _self.tooltipItemUnavail = ISToolTip:new();
                    _self.tooltipItemUnavail:addToUIManager();
                end

                if data.inventoryItem then
                    _self.tooltipItem:setItem(data.inventoryItem);
                    _self.tooltipItem:setCharacter(self.player);
                    _self.tooltipItem:setVisible(true);
                    _self.tooltipItem:setAlwaysOnTop(true);
                    
                    _self.tooltipItemUnavail:setVisible(false);
                else
                    _self.tooltipItemUnavail:setName(data.text);
                    _self.tooltipItemUnavail:setVisible(true);
                    _self.tooltipItemUnavail:setAlwaysOnTop(true);

                    _self.tooltipItem:setVisible(false);
                end
            end
        end
    end
    self.itemListBox.onMouseMoveOutside = function (_self, x, y)
        ISScrollingListBox.onMouseMoveOutside(_self, x, y)
        if _self.tooltipItem then
            _self.tooltipItem:setVisible(false);
            _self.tooltipItem:removeFromUIManager();
            _self.tooltipItem = nil;
        end
        if _self.tooltipItemUnavail then
            _self.tooltipItemUnavail:setVisible(false);
            _self.tooltipItemUnavail:removeFromUIManager();
            _self.tooltipItemUnavail = nil;
        end
    end
    self.itemListBox:initialise();
    self.itemListBox:instantiate();
    self.itemListBox.vscroll:setAnchorLeft(false);
    self.itemListBox.vscroll:setAnchorRight(false);
    self.itemListBox.vscroll:setAnchorTop(false);
    self.itemListBox.vscroll:setAnchorBottom(false);
    self.itemListBox.itemheight = 32;
    self.itemListBox.selected = 0;
    self.itemListBox.joypadParent = self;
    self.itemListBox.logic = self.logic;
    --self.itemListBox.recipeData = self.recipeData;
    self.itemListBox.colGood = self.colGood;
    self.itemListBox.colBad = self.colBad;
    self.itemListBox.font = UIFont.Medium;
    self.itemListBox.doDrawItem = ISCraftInventoryPanel.drawListItem;
    self.itemListBox.target = self;
    self.itemListBox.onmousedown = ISCraftInventoryPanel.onListSelected;
    self.itemListBox.drawBorder = true;

    self:addChild(self.itemListBox);
end

function ISCraftInventoryPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    self.itemListBox:setX(self.margin);
    self.itemListBox:setY(self.margin);
    self.itemListBox:setWidth(width-(self.margin*2));
    self.itemListBox:setHeight(height-(self.margin*2));

    self.itemListBox.vscroll:setX(self.itemListBox:getWidth()-self.itemListBox.vscroll:getWidth());
    self.itemListBox.vscroll:setHeight(self.itemListBox:getHeight());

    self.itemListBox:updateScrollbars();

    self:setWidth(width);
    self:setHeight(height);
end

function ISCraftInventoryPanel:onResize()
    ISUIElement.onResize(self)
end

function ISCraftInventoryPanel:prerender()
    if self.isDirty then
        self:populate();
        self.isDirty = false;
    end
    ISPanel.prerender(self);
end

function ISCraftInventoryPanel:render()
    ISPanel.render(self);
end

function ISCraftInventoryPanel:update()
    ISPanel.update(self);
end

function ISCraftInventoryPanel:selectFirst()
    if self.itemListBox.items and #self.itemListBox.items>0 then
        self.itemListBox.selected = 1;
        self:onListSelected(self.itemListBox.items[self.itemListBox.selected].item);
    end
end

function ISCraftInventoryPanel:populate()
    local selectedInventoryItem = nil;
    if self.itemListBox.items and self.itemListBox.selected and self.itemListBox.selected > 0 then
        selectedInventoryItem = self.itemListBox.items[self.itemListBox.selected].item.inventoryItem;
    end
    
    self.itemListBox:clear()

    self.inputScriptFilter = self.logic:getManualSelectInputScriptFilter();
    local nodes = self.inputScriptFilter and self.logic:getInputItemNodesForInput(self.inputScriptFilter) or self.logic:getInputItemNodes();
    local allInputItems = self.inputScriptFilter and self.inputScriptFilter:getPossibleInputItems();

    --if nodes:size()==0 then
    --    local header = self:createListHeader("Items");
    --    self.itemListBox:addItem(header.name, header);
    --    return;
    --end

    local item;

    local addedToolsHeader = false;
    local addedItemsHeader = false;
    for i=0,nodes:size()-1 do
        local node = nodes:get(i);
        
        if node:isTool() then
            if not addedToolsHeader then
                local header = self:createListHeader("Tools");
                self.itemListBox:addItem(header.name, header);
                addedToolsHeader = true;
            end
            --add tool element
            item = self:createListItemNode(node);
            self.itemListBox:addItem(item.name, item);

            if node:isExpanded() then
                for k=0,node:getItems():size()-1 do
                    local inventoryItem = node:getItems():get(k);
                    item = self:createListItemEntree(node, inventoryItem, k);
                    self.itemListBox:addItem(item.name, item);
                end
            end
        end
    end
    for i=0,nodes:size()-1 do
        local node = nodes:get(i);

        if not node:isTool() then
            if not addedItemsHeader then
                local header = self:createListHeader("Available Items");
                self.itemListBox:addItem(header.name, header);
                addedItemsHeader = true;
            end
            --add items element
            item = self:createListItemNode(node);
            self.itemListBox:addItem(item.name, item);

            if node:isExpanded() then
                for k=0,node:getItems():size()-1 do
                    local inventoryItem = node:getItems():get(k);
                    item = self:createListItemEntree(node, inventoryItem, k);
                    local listItem = self.itemListBox:addItem(item.name, item);
                    
                    -- restore selection
                    if inventoryItem == selectedInventoryItem then
                        self.itemListBox.selected = listItem.itemIndex;                        
                    end
                end
            end
        end
    end

    if (not addedToolsHeader) and (not addedItemsHeader) then
        local header = self:createListHeader("Available Items");
        self.itemListBox:addItem(header.name, header);
    end
    
    -- unavailables
    if allInputItems then
        local header = self:createListHeader("Possible Items", true);
        header.isUnavailableItemsHeader = true;
        self.itemListBox:addItem(header.name, header);

        if self.unavailablesExpanded or ((not addedToolsHeader) and (not addedItemsHeader)) then
            local index = 0;
            for i = 0, allInputItems:size()-1 do
                local inputItem = allInputItems:get(i);
                local found = false;
                for j = 0, nodes:size()-1 do
                    if nodes:get(j):getScriptItem() == inputItem then
                        found = true;
                    end
                end

                if not found then
                    item = self:createUnavailableListItemEntree(inputItem, index);
                    self.itemListBox:addItem(item.name, item);

                    index = index + 1;
                end
            end
        end
    end

    self.itemListBox:updateScrollbars();
end

function ISCraftInventoryPanel:createListHeader(_text, hasExpandArrow)
    local item = {};

    item.isHeader = true;
    item.isNode = false;
    item.name = _text;
    item.text = _text;
    item.hasExpandArrow = hasExpandArrow;
    item.textWidth = getTextManager():MeasureStringX(UIFont.Medium, item.text);

    return item;
end

function ISCraftInventoryPanel:createListItemNode(_node) -- _node:InputItemNode
    local item = {};

    item.isHeader = false;
    item.isNode = true;
    item.node = _node;
    item.script = _node:getScriptItem();
    item.name = _node:getScriptItem():getScriptObjectFullType();
    item.text = _node:getScriptItem():getDisplayName().." ("..tostring(_node:getItems():size())..")";
    item.textWidth = getTextManager():MeasureStringX(UIFont.Medium, item.text);

    return item;
end

function ISCraftInventoryPanel:createListItemEntree(_node, _inventoryItem, _index)
    local item = {};

    item.isHeader = false;
    item.isNode = false;
    item.node = _node;
    item.script = _node:getScriptItem();
    item.inventoryItem = _inventoryItem;
    item.index = _index;
    item.name = tostring(_index)..":".._node:getScriptItem():getScriptObjectFullType();
    item.text = _inventoryItem:getName(); --_node:getScriptItem():getDisplayName();
    item.textWidth = getTextManager():MeasureStringX(UIFont.Medium, item.text);

    return item;
end

function ISCraftInventoryPanel:createUnavailableListItemEntree(_item, _index)
    local item = {};

    item.isHeader = false;
    item.isNode = false;
    item.node = nil;
    item.script = _item;
    item.inventoryItem = nil;
    item.index = _index;
    item.name = tostring(_index)..":".._item:getScriptObjectFullType();
    item.text = _item:getDisplayName();
    item.textWidth = getTextManager():MeasureStringX(UIFont.Medium, item.text);
    item.isUnavailable = true;

    return item;
end

function ISCraftInventoryPanel:drawListItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        --self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end

    local dx,dy = 0,0;
    local data = item.item;

    local width = self.width;
    if self:isVScrollBarVisible() then
        width = self.width - self.vscroll:getWidth();
    end

    if data.isHeader then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);

        dx = (width/2)-(data.textWidth/2);
        dy = y + ((self.itemheight/2)-(MEDIUM_FONT_HGT/2));

        if data.hasExpandArrow then
            --dx = dx - 36;

            local iconTexture = getTexture("media/ui/Entity/Icon_ExpandArrow_Closed_48x48.png");
            if self.target.unavailablesExpanded then
                iconTexture = getTexture("media/ui/Entity/Icon_ExpandArrow_Open_48x48.png");
            end

            self:drawTextureScaledAspect(iconTexture, 16, dy+4, 16, 16, 1, 1, 1, 1);
            --dx = dx + 36;
        end

        self:drawText( data.text, dx, dy, 1, 1, 1, 1.0, self.font);
    elseif data.isNode then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.1, 1.0, 1.0, 1.0);

        dx = 10;
        if data.script then
            ISInventoryItem.renderScriptItemIcon(self, data.script, dx, y+2, 1.0, self.itemheight-4, self.itemheight-4);
        end
        dx = dx + self.itemheight + 16;
        dy = y + ((self.itemheight/2)-(MEDIUM_FONT_HGT/2));

        self:drawText( data.text, dx, dy, 1, 1, 1, 1.0, self.font);
    else
        if data.inventoryItem and self.logic:getRecipeData():containsInputItem(data.inventoryItem) then
            local c = self.colGood;
            self:drawRect(2, (y), width, self.itemheight - 1, 0.5, c.r, c.g, c.b);
        end
        dx = 10;
        if data.inventoryItem then
            ISInventoryItem.renderItemIcon(self, data.inventoryItem, dx, y+2, 1.0, self.itemheight-4, self.itemheight-4);
        elseif data.isUnavailable and data.script then
            ISInventoryItem.renderScriptItemIcon(self, data.script, dx, y+2, 0.5, self.itemheight-4, self.itemheight-4);
        end
        dx = dx + self.itemheight + 16;
        dy = y + ((self.itemheight/2)-(MEDIUM_FONT_HGT/2));

        if data.isUnavailable then
            self:drawText( data.text, dx, dy, 1, 1, 1, 0.5, self.font);
        else
            local c = 0.0;
            local a = 0.6;
            local off = 1;
            self:drawText( data.text, dx+off, dy+off, c, c, c, a, self.font);
            self:drawText( data.text, dx+off, dy-off, c, c, c, a, self.font);
            self:drawText( data.text, dx-off, dy-off, c, c, c, a, self.font);
            self:drawText( data.text, dx-off, dy+off, c, c, c, a, self.font);

            self:drawText( data.text, dx, dy, 1, 1, 1, 1.0, self.font);
        end
    end

    return y + self.itemheight;
end

function ISCraftInventoryPanel:onListSelected(_item)
    self.selectedItem = _item;

    if self.selectedItem then
        --print("selected = "..tostring(self.itemListBox.selected));
        if self.selectedItem.isHeader then
            if self.selectedItem.isUnavailableItemsHeader then
                self.unavailablesExpanded = not self.unavailablesExpanded;
                self.isDirty = true;
            end
            --currently do nothing
        elseif self.selectedItem.isNode then
            self.selectedItem.node:toggleExpanded();
            --self.selectedItem.node.expanded = not self.selectedItem.node.expanded;
            self.isDirty = true;
            --self:populate();
        else
            if _item.inventoryItem then
                if self.logic:getRecipeData():containsInputItem(_item.inventoryItem) then
                    --remove the item - called on logic instead of cacheddata to trigger helper events - spurcival
                    self.logic:removeInputItem(_item.inventoryItem);
                else
                    --try and add the item to a input - called on logic instead of cacheddata to trigger helper events - spurcival
                    self.logic:offerInputItem(_item.inventoryItem);
                end
            end
        end
    else
        --
    end
end

function ISCraftInventoryPanel:onRebuildItemNodes(_inputItems)
    --print("Calling listener -> ISCraftInventoryPanel.onRebuildItemNodes")
    ---self.itemsList = _itemsList;

    --todo check if have to remove all previous added InputItems from recipeData

    self:populate();
    if self.itemListBox and (not self.itemListBox.selected or self.itemListBox.selected < 1) then
    self:selectFirst();
end
end

function ISCraftInventoryPanel:updateContainers(_containers)
    self:populate();
end

--************************************************************************--
--** ISCraftInventoryPanel:new
--**
--************************************************************************--
function ISCraftInventoryPanel:new(x, y, width, height, player, logic)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    o.background = false;
    --o.margin = 5;
    o.player = player;
    o.logic = logic;
    o.logic:addEventListener("onRebuildInputItemNodes", o.onRebuildItemNodes, o);

    o.inputScriptFilter = nil;
    o.unavailablesExpanded = false;
    
    o.margin = 5;
    o.minimumWidth = 256;
    o.minimumHeight = 32;

    --o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;
    return o;
end