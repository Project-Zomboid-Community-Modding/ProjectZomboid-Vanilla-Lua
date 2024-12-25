--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "Entity/ISUI/Controls/ISGroupBox"

ISItemSlotPanel = ISGroupBox:derive("ISItemSlotPanel");

function ISItemSlotPanel:initialise()
	ISGroupBox.initialise(self);
end

function ISItemSlotPanel:createChildren()
    ISGroupBox.createChildren(self);

    local styleCell = self.styleCell or "S_TableLayoutCell_ItemSlot";
    self.tableLayout = ISXuiSkin.build(self.xuiSkin, nil, ISTableLayout, 0, 0, 10, 10, nil, nil, styleCell);
    self.tableLayout:addRowFill(nil);
    self.tableLayout:initialise();
    self.tableLayout:instantiate();
    self:setElement(self.tableLayout);
end

function ISItemSlotPanel:addResources(_resources, _styleItemSlot)
    if not self.javaObject then
        print("ISItemSlotPanel.addResources failed, must instantiate first.")
    end

    if _resources:size()==0 then
        return;
    end

    for i=0,_resources:size()-1 do
        self:addResource(_resources:get(i), _styleItemSlot)
    end

end

function ISItemSlotPanel:addResource(_resourceItem, _styleItemSlot)
    if not self.javaObject then
        print("ISItemSlotPanel.addResources failed, must instantiate first.")
    end

    if not _resourceItem then
        print("ISItemSlotPanel -> resource is nil")
        return;
    end

    local columnIndex = self.tableLayout:addColumnFill(nil):index();

    local style = _styleItemSlot or "S_ItemSlot_Locked";
    local itemSlot = ISXuiSkin.build(self.xuiSkin, style, ISItemSlot, 0, 0, 44, 44, _resourceItem);
    itemSlot.drawProgress = self.drawProgress;
    itemSlot:initialise();
    itemSlot:instantiate();
    itemSlot:setCharacter(self.player);
    itemSlot:setResource( _resourceItem );
    itemSlot.functionTarget = self;
    itemSlot.onBoxClicked = ISItemSlotPanel.onItemSlotRemoveItems;
    itemSlot.onItemDropped = ISItemSlotPanel.onItemSlotAddItems; --when items dragged under mouse are dropped in box
    --uiSlot.onVerifyItem = ISBlueprintLogicPanel.onItemSlotVerifyItem; --when items are checked to see if box can accept
    itemSlot.onItemRemove = ISItemSlotPanel.onItemSlotRemoveSingleItem; --when rightclicking to remove item
    self.tableLayout:setElement(columnIndex, 0, itemSlot);
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
    ISEntityUI.ItemSlotRemoveItems( self.player, self.entity, _itemSlot );
end

function ISItemSlotPanel:onItemSlotAddItems( _itemSlot, _itemList )
    ISEntityUI.ItemSlotAddItems( self.player, self.entity, _itemSlot, _itemList )
end

--************************************************************************--
--** ISItemSlotPanel:new
--**
--************************************************************************--
function ISItemSlotPanel:new (x, y, width, height, player, entity, _styleLabel, _styleCell)
	local o = ISGroupBox:new(x, y, width, height, _styleLabel);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;

    o.styleCell = _styleCell;
    o.drawProgress = false;

    return o
end