--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "Entity/ISUI/Controls/ISGroupBox"

ISItemSlotPanel = ISGroupBox:derive("ISItemSlotPanel");

local FONT_SCALE = getTextManager():getFontHeight(UIFont.Small) / 19; -- normalize to 1080p
local ICON_SCALE = math.max(1, (FONT_SCALE - math.floor(FONT_SCALE)) < 0.5 and math.floor(FONT_SCALE) or math.ceil(FONT_SCALE));
local SLOT_SIZE = 32 * math.max(1, ICON_SCALE) + 8;

function ISItemSlotPanel:initialise()
	ISGroupBox.initialise(self);
end

function ISItemSlotPanel:createChildren()
    ISGroupBox.createChildren(self);

    local styleCell = self.styleCell or "S_TableLayoutCell_ItemSlot";
    self.tableLayout = ISXuiSkin.build(self.xuiSkin, nil, ISTableLayout, 0, 0, 10, 10, nil, nil, styleCell);
    self.tableLayout:initialise();
    self.tableLayout:instantiate();
    self:setElement(self.tableLayout);
end

function ISItemSlotPanel:addLayoutCell()
    local columnIndex = #self.itemSlots % self.maxColumns;
    local rowIndex = math.floor(#self.itemSlots / self.maxColumns);
    if columnIndex == 0 then
        rowIndex = self.tableLayout:addRowFill(nil):index();
    end
    if rowIndex == 0 then
        columnIndex = self.tableLayout:addColumnFill(nil):index();
    end
    
    return columnIndex, rowIndex;
end

function ISItemSlotPanel:addResources(_resources, _styleItemSlot)
    if not self.javaObject then
        print("ISItemSlotPanel.addResources failed, must instantiate first.")
    end

    if _resources:size()==0 then
        return;
    end

    for i=0,_resources:size()-1 do
        -- always filter by item - add a slot per slot item
        local resource = _resources:get(i);
        local uniqueItems = resource:getUniqueItems();
        local uniqueItemCount = not resource:isEmpty() and uniqueItems:size() or 1;
        for j = 0, uniqueItemCount-1 do
            local itemTypeFilter = not uniqueItems:isEmpty() and uniqueItems:get(j) or nil;
            self:addResource(resource, _styleItemSlot, itemTypeFilter);
        end
    end

end

function ISItemSlotPanel:addResource(_resourceItem, _styleItemSlot, _itemTypeFilter)
    if not self.javaObject then
        print("ISItemSlotPanel.addResources failed, must instantiate first.")
    end

    if not _resourceItem then
        print("ISItemSlotPanel -> resource is nil")
        return;
    end
    
    local style = _styleItemSlot or "S_ItemSlot_Locked";
    local itemSlot = ISXuiSkin.build(self.xuiSkin, style, ISItemSlot, 0, 0, SLOT_SIZE, SLOT_SIZE, _resourceItem);
    itemSlot.drawProgress = self.drawProgress;
    itemSlot.showSelectInputsButton = self.showSelectInputsButton;
    itemSlot.onSelectInputsButtonClicked = ISItemSlotPanel.onSelectInputsButton;
    itemSlot.functionTarget = self;
    itemSlot.onBoxClicked = ISItemSlotPanel.onItemSlotRemoveItems;
    itemSlot.onItemDropped = ISItemSlotPanel.onItemSlotAddItems; --when items dragged under mouse are dropped in box
    --uiSlot.onVerifyItem = ISBlueprintLogicPanel.onItemSlotVerifyItem; --when items are checked to see if box can accept
    itemSlot.onItemRemove = ISItemSlotPanel.onItemSlotRemoveSingleItem; --when rightclicking to remove item
    itemSlot.onStoredItemChanged = ISItemSlotPanel.onStoredItemChanged; -- called when the stored item changes in slot
    itemSlot.allowDrop = self.allowDrop;
    itemSlot.renderRequiredItemCount = self.renderRequiredItemCount;
    if self.drawTooltip then
        itemSlot.drawTooltip = self.drawTooltip;
    end
    itemSlot.itemTypeFilter = _itemTypeFilter;
    itemSlot:initialise();
    itemSlot:instantiate();
    itemSlot:setCharacter(self.player);
    itemSlot:setResource( _resourceItem );
    
    local columnIndex, rowIndex = self:addLayoutCell();
    self.tableLayout:setElement(columnIndex, rowIndex, itemSlot);
    table.insert(self.itemSlots, itemSlot);
    
    return itemSlot;
end

function ISItemSlotPanel:getItemSlots()
    return self.itemSlots;
end

function ISItemSlotPanel:addDisplayInventoryItem(_item, _styleItemSlot)
    if not self.javaObject then
        print("ISItemSlotPanel.addResources failed, must instantiate first.")
    end

    if not _item then
        print("ISItemSlotPanel -> scriptItem is nil")
        return;
    end

    local columnIndex, rowIndex = self:addLayoutCell();

    local style = _styleItemSlot or "S_ItemSlot_Locked";
    local itemSlot = ISXuiSkin.build(self.xuiSkin, style, ISItemSlot, 0, 0, SLOT_SIZE, SLOT_SIZE);
    itemSlot.drawProgress = self.drawProgress;
    if self.drawTooltip then
        itemSlot.drawTooltip = self.drawTooltip;
    end
    itemSlot:initialise();
    itemSlot:instantiate();
    itemSlot:setCharacter(self.player);
    itemSlot:setStoredItem( _item );
    self.tableLayout:setElement(columnIndex, rowIndex, itemSlot);
    table.insert(self.itemSlots, itemSlot);
    
    return itemSlot;
end

function ISItemSlotPanel:addDisplayItem(_item, _styleItemSlot)
    if not self.javaObject then
        print("ISItemSlotPanel.addResources failed, must instantiate first.")
    end

    if not _item then
        print("ISItemSlotPanel -> item is nil")
        return;
    end

    local columnIndex, rowIndex = self:addLayoutCell();
    
    local style = _styleItemSlot or "S_ItemSlot_Locked";
    local itemSlot = ISXuiSkin.build(self.xuiSkin, style, ISItemSlot, 0, 0, SLOT_SIZE, SLOT_SIZE);
    itemSlot.drawProgress = self.drawProgress;
    if self.drawTooltip then
        itemSlot.drawTooltip = self.drawTooltip;
    end
    itemSlot:initialise();
    itemSlot:instantiate();
    itemSlot:setCharacter(self.player);
    itemSlot:setStoredScriptItem( _item );
    self.tableLayout:setElement(columnIndex, rowIndex, itemSlot);
    table.insert(self.itemSlots, itemSlot);
    
    return itemSlot;
end

function ISItemSlotPanel:addDisplayEmptySlot(_styleItemSlot)
    if not self.javaObject then
        print("ISItemSlotPanel.addResources failed, must instantiate first.")
    end

    local columnIndex, rowIndex = self:addLayoutCell();

    local style = _styleItemSlot or "S_ItemSlot_Locked";
    local itemSlot = ISXuiSkin.build(self.xuiSkin, style, ISItemSlot, 0, 0, SLOT_SIZE, SLOT_SIZE);
    itemSlot.drawProgress = self.drawProgress;
    if self.drawTooltip then
        itemSlot.drawTooltip = self.drawTooltip;
    end        
    itemSlot:initialise();
    itemSlot:instantiate();
    itemSlot:setCharacter(self.player);
    self.tableLayout:setElement(columnIndex, rowIndex, itemSlot);
    table.insert(self.itemSlots, itemSlot);
    
    return itemSlot
end

function ISItemSlotPanel:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISItemSlotPanel:prerender()
    ISGroupBox.prerender(self);
end

function ISItemSlotPanel:render()
    ISGroupBox.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 1, 0, 0);
    end
end

function ISItemSlotPanel:update()
    ISGroupBox.update(self);
end

function ISItemSlotPanel:onItemSlotRemoveSingleItem( _itemSlot, _item )
    ISEntityUI.ItemSlotRemoveSingleItem( self.player, self.entity, _itemSlot, _item )
end

function ISItemSlotPanel:onItemSlotRemoveItems( _itemSlot, _isRightClick, _isShift )
    if _itemSlot.itemTypeFilter then
        local items = _itemSlot.resource:getStoredItemsOfType(_itemSlot.itemTypeFilter);
        ISEntityUI.ItemSlotRemoveItems( self.player, self.entity, _itemSlot, items );
    else
        ISEntityUI.ItemSlotRemoveItems( self.player, self.entity, _itemSlot );
    end
end

function ISItemSlotPanel:onItemSlotAddItems( _itemSlot, _itemList )
    ISEntityUI.ItemSlotAddItems( self.player, self.entity, _itemSlot, _itemList )
end

function ISItemSlotPanel:removeAllSlots()
    self.tableLayout:clearTable();
    table.wipe(self.itemSlots);
end

function ISItemSlotPanel:onSelectInputsButton( _itemSlot )
    if self.functionTarget and self.onSelectInputsButtonClicked then
        self.onSelectInputsButtonClicked(self.functionTarget, _itemSlot);
    end
    if self.logic and self.showSelectInputsButton then
        local activeSlot = self.logic:getManualSelectItemSlot();
        for i = 1, #self.itemSlots do
            self.itemSlots[i]:setSelectInputsButtonActive(activeSlot == self.itemSlots[i]);
        end
    end
end

function ISItemSlotPanel:onStoredItemChanged( _itemSlot )
    if self.functionTarget and self.onItemSlotContentsChanged then
        self.onItemSlotContentsChanged(self.functionTarget, _itemSlot);
    end
end

--************************************************************************--
--** ISItemSlotPanel:new
--**
--************************************************************************--
function ISItemSlotPanel:new (x, y, width, height, player, entity, logic, _styleLabel, _styleCell)
	local o = ISGroupBox:new(x, y, width, height, _styleLabel);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;
    o.logic = logic;

    o.itemSlots = {};
    o.allowDrop = true;
    
    o.functionTarget = nil;
    o.onSelectInputsButtonClicked = nil;
    o.onItemSlotContentsChanged = nil;
    
    o.renderRequiredItemCount = false;
    
    o.styleCell = _styleCell;
    o.drawProgress = false;
    
    o.showSelectInputsButton = false;
    o.maxColumns = 4;

    return o
end