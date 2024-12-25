--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "Entity/ISUI/Controls/ISGroupBox"

ISEnergySlotPanel = ISGroupBox:derive("ISEnergySlotPanel");

function ISEnergySlotPanel:initialise()
	ISGroupBox.initialise(self);
end

function ISEnergySlotPanel:createChildren()
    ISGroupBox.createChildren(self);

    self.tableLayout = ISXuiSkin.build(self.xuiSkin, nil, ISTableLayout, 0, 0, 10, 10);
    if self.isVertical then --energy bars are drawn vertically
        self.tableLayout:addRowFill(nil);
    else
        self.tableLayout:addColumnFill(nil);
    end
    --self.tableLayout:addRow("S_Row_Fill");
    self.tableLayout:initialise();
    self.tableLayout:instantiate();
    self:setElement(self.tableLayout);
end

function ISEnergySlotPanel:addResources(_resources, _styleEnergySlot, _styleIcon, _styleBar)
    if not self.javaObject then
        print("ISEnergySlotPanel.addResources failed, must instantiate first.")
    end

    if _resources:size()==0 then
        return;
    end

    for i=0,_resources:size()-1 do
        self:addResource(_resources:get(i), _styleEnergySlot, _styleIcon, _styleBar)
    end

end

function ISEnergySlotPanel:addResource(_resourceEnergy, _styleEnergySlot, _styleIcon, _styleBar)
    if not self.javaObject then
        print("ISEnergySlotPanel.addResources failed, must instantiate first.")
    end

    if not _resourceEnergy then
        print("ISEnergySlotPanel -> resource is nil")
        return;
    end

    local style = _styleEnergySlot or ((self.isVertical and "S_EnergySlot_Vertical") or "S_EnergySlot_Horizontal");

    local columnIndex, rowIndex = 0,0;
    local energySlot = ISXuiSkin.build(self.xuiSkin, style, ISEnergySlot, 0, 0, 100, 100, self.player, _resourceEnergy, _styleIcon, _styleBar);
    if self.isVertical then
        columnIndex = self.tableLayout:addColumnFill(nil):index();
    else
        rowIndex = self.tableLayout:addRowFill(nil):index();
    end
    energySlot:initialise();
    energySlot:instantiate();
    energySlot:setResource( _resourceEnergy );

    self.tableLayout:setElement(columnIndex, rowIndex, energySlot);
end

function ISEnergySlotPanel:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISEnergySlotPanel:prerender()
    ISGroupBox.prerender(self);
end

function ISEnergySlotPanel:render()
    ISGroupBox.render(self);

    --[[
    if true then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 1, 0, 0);
    end
    --]]
end

function ISEnergySlotPanel:update()
    ISGroupBox.update(self);
end

--************************************************************************--
--** ISEnergySlotPanel:new
--**
--************************************************************************--
function ISEnergySlotPanel:new (x, y, width, height, player, entity, _styleLabel)
	local o = ISGroupBox:new(x, y, width, height, _styleLabel);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;


    o.isVertical = true;

    return o
end