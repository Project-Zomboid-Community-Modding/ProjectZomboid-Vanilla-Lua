--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "Entity/ISUI/Layouts/ISBaseStockingLayout"

ISVendorStockingLayout = ISBaseStockingLayout:derive("ISVendorStockingLayout");

function ISVendorStockingLayout:new (x, y, _parentPanel, _blueprintLogic)
    local o = ISBaseStockingLayout:new(x, y, _parentPanel, _blueprintLogic);
    setmetatable(o, self)
    self.__index = self

    o.productColumns = 3;
    o.productPanelWidth = 300;
    o.productPanelHeight = 350;

    return o
end