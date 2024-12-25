--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "Entity/ISUI/Controls/ISGroupBox"

ISFluidSlotPanel = ISGroupBox:derive("ISFluidSlotPanel");

function ISFluidSlotPanel:initialise()
	ISGroupBox.initialise(self);
end

function ISFluidSlotPanel:createChildren()
    ISGroupBox.createChildren(self);

    self.tableLayout = ISXuiSkin.build(self.xuiSkin, nil, ISTableLayout, 0, 0, 10, 10);
    self.tableLayout:addRowFill(nil);
    self.tableLayout:initialise();
    self.tableLayout:instantiate();
    self:setElement(self.tableLayout);
end

function ISFluidSlotPanel:addResources(_resources, _styleFluidSlot, _styleBtnTransfer, _styleBtnClear, _styleBar)
    if not self.javaObject then
        print("ISFluidSlotPanel.addResources failed, must instantiate first.")
    end

    if _resources:size()==0 then
        return;
    end

    for i=0,_resources:size()-1 do
        self:addResource(_resources:get(i), _styleFluidSlot, _styleBtnTransfer, _styleBtnClear, _styleBar)
    end

end

function ISFluidSlotPanel:addResource(_resourceFluid, _styleFluidSlot, _styleBtnTransfer, _styleBtnClear, _styleBar)
    if not self.javaObject then
        print("ISFluidSlotPanel.addResources failed, must instantiate first.")
    end

    if not _resourceFluid then
        print("ISFluidSlotPanel -> resource is nil")
        return;
    end

    local columnIndex = self.tableLayout:addColumnFill(nil):index();

    local fluidSlot = ISXuiSkin.build(self.xuiSkin, _styleFluidSlot, ISFluidSlot, 0, 0, 100, 100, self.player, _resourceFluid, _styleBtnTransfer, _styleBtnClear, _styleBar);
    fluidSlot:initialise();
    fluidSlot:instantiate();
    fluidSlot:setResource( _resourceFluid );
    --fluidSlot.functionTarget = self;
    --fluidSlot.onTransferFluids = ISFluidSlotPanel.onTransferFluids;
    --fluidSlot.onClearFluids = ISFluidSlotPanel.onClearFluids;
    self.tableLayout:setElement(columnIndex, 0, fluidSlot);
end

function ISFluidSlotPanel:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISFluidSlotPanel:prerender()
    ISGroupBox.prerender(self);
end

function ISFluidSlotPanel:render()
    ISGroupBox.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 1, 0, 0);
    end
end

function ISFluidSlotPanel:update()
    ISGroupBox.update(self);
end

--************************************************************************--
--** ISFluidSlotPanel:new
--**
--************************************************************************--
function ISFluidSlotPanel:new (x, y, width, height, player, entity, _styleLabel)
	local o = ISGroupBox:new(x, y, width, height, _styleLabel);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;

    return o
end