--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "Entity/ISUI/Layouts/ISBaseVendingLayout"

ISSodaVendingLayout = ISBaseVendingLayout:derive("ISSodaVendingLayout");

function ISSodaVendingLayout:new (x, y, _parentPanel, _blueprintLogic)
    local o = ISBaseVendingLayout:new(x, y, _parentPanel, _blueprintLogic);
    setmetatable(o, self)
    self.__index = self

    o.frontImageOn = getTexture("media/ui/Entity/Vending/Screen_on.png");
    o.frontImageOff = getTexture("media/ui/Entity/Vending/Screen_off.png");

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