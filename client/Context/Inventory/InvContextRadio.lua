--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ISInventoryMenuElements = ISInventoryMenuElements or {};

function ISInventoryMenuElements.ContextRadio()
    local self 					= ISMenuElement.new();
    self.invMenu			    = ISContextManager.getInstance().getInventoryMenu();

    function self.init()
    end

    function self.createMenu( _item )
        if getCore():getGameMode() == "Tutorial" then
            return;
        end
        if instanceof(_item, "Radio") then
            if _item:getContainer():getType() == "floor" then
                local square = _item:getWorldItem():getSquare()
                local _obj = nil
                for i=0, square:getObjects():size()-1 do
                    local tObj = square:getObjects():get(i)
                    if instanceof(tObj, "IsoRadio") then
                        if tObj:getModData().RadioItemID == _item:getID() then
                            _obj = tObj
                            break
                        end
                    end
                end
                if _obj ~= nil then
                    self.invMenu.context:addOption(getText("IGUI_DeviceOptions"), self.invMenu, self.openPanel, _obj );
                end
            else
                if self.invMenu.player:getPrimaryHandItem() == _item or self.invMenu.player:getSecondaryHandItem() == _item then
                    self.invMenu.context:addOption(getText("IGUI_DeviceOptions"), self.invMenu, self.openPanel, _item );
                end
            end
        end
    end

    function self.openPanel( _p, _item )
        ISRadioWindow.activate( _p.player, _item );
    end

    return self;
end
