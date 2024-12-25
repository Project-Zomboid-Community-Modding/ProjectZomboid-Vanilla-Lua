--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "Entity/ISUI/Layouts/ISBaseStockingLayout"

ISSodaStockingLayout = ISBaseStockingLayout:derive("ISSodaStockingLayout");

function ISSodaStockingLayout:new (x, y, _parentPanel, _blueprintLogic)
    local o = ISBaseStockingLayout:new(x, y, _parentPanel, _blueprintLogic);
    setmetatable(o, self)
    self.__index = self

    o.productColumns = 2;
    o.productPanelWidth = 250;
    o.productPanelHeight = 350;

    o.btnNames = {"cola", "dietcola", "ginger", "orange", "water" };
    o.buttonImg = {};

    for k,v in ipairs(o.btnNames) do
        table.insert(o.buttonImg, {
            name = v;
            on = getTexture("media/ui/Entity/Vending/Button_"..v.."_on.png");
            off = getTexture("media/ui/Entity/Vending/Button_"..v.."_off.png");
        })
    end

    return o
end