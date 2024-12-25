--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ISEntityUtilUI = {};

function ISEntityUtilUI.GetVendingInteriorTextures()
    local t = {};
    for i=0,8 do
        table.insert(t, getTexture("media/ui/Entity/Vending/vending_internal_"..tostring(i)..".png"))
    end
    return t;
end

function ISEntityUtilUI.GetVendingInteriorUnlitTextures()
    local t = {};
    for i=0,8 do
        table.insert(t, getTexture("media/ui/Entity/Vending/vending_internal_unlit_"..tostring(i)..".png"))
    end
    return t;
end

function ISEntityUtilUI.GetVendingAlphabeticalButtonTexture(_index)
    return getTexture("media/ui/Entity/Vending/vending_btn_alpha_"..tostring(_index)..".png")
end

function ISEntityUtilUI.GetVendingAlphabeticalLabelTexture(_index)
    return getTexture("media/ui/Entity/Vending/vending_label_alpha_"..tostring(_index)..".png")
end