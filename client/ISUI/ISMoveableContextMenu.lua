ISMoveableContextMenu = ISMoveableContextMenu or {};

function ISMoveableContextMenu.createMenu(context, item, playerObj)
    if item:getContainer() ~= playerObj:getInventory() then
        return;
    end

    if playerObj:getPrimaryHandItem() ~= item and playerObj:getSecondaryHandItem() ~= item then
        if instanceof(item, "Radio") and item:getWorldStaticItem() then
            return
        end

        local option = context:addOption(getText("IGUI_PlaceObject"), item, ISMoveableContextMenu.openMovableCursor, playerObj);
        option.itemForTexture = item;
    end
end

function ISMoveableContextMenu.openMovableCursor(item, playerObj)
    local mo = ISMoveableCursor:new(playerObj);
    getCell():setDrag(mo, mo.player);
    mo:setMoveableMode("place");
    mo:tryInitialItem(item);
end
