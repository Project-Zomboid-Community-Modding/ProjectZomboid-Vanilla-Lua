ISRadioAndTvMenu = ISRadioAndTvMenu or {};

function ISRadioAndTvMenu.createMenu(worldObjects, context, playerObj)
    local done = {}; -- TODO this is lame, but somehow worldobjects have 2 times the same item sometimes, need to debug it out
    for _,object in ipairs(worldObjects) do
        if not done[object] then
            if instanceof(object, "IsoWaveSignal") and object:getSprite() and not object:getModData().RadioItemID then
                local option = context:addOption(getText("IGUI_DeviceOptions"), playerObj, ISRadioAndTvMenu.openTvPanel, object);
                local customItem = object:getProperties() and object:getProperties():get("CustomItem")
                if customItem then
                    local itemScript = getItem(customItem)
                    option.iconTexture = itemScript and itemScript:getNormalTexture()
                end
            end
            if instanceof(object, "Radio") then
                if object:getContainer():getType() == "floor" then
                    local square = object:getWorldItem():getSquare();
                    local _obj;
                    for i=0, square:getObjects():size()-1 do
                        local tObj = square:getObjects():get(i);
                        if instanceof(tObj, "IsoRadio") then
                            if tObj:getModData().RadioItemID == object:getID() then
                                _obj = tObj;
                                break;
                            end
                        end
                    end
                    if _obj then
                        local option = context:addOption(getText("IGUI_DeviceOptions"), playerObj, ISRadioAndTvMenu.openRadioPanel, _obj);
                        option.itemForTexture = object;
                    end
                else
                    if playerObj:getPrimaryHandItem() == object or playerObj:getSecondaryHandItem() == object  or playerObj:getClothingItem_Back() == object then
                        local option = context:addOption(getText("IGUI_DeviceOptions"), playerObj, ISRadioAndTvMenu.openRadioPanel, object);
                        option.itemForTexture = object;
                    end
                end
            end
        end
        done[object] = true;
    end
end

function ISRadioAndTvMenu.openTvPanel(playerObj, item)
    ISRadioWindow.activate(playerObj, item, true);
end

function ISRadioAndTvMenu.openRadioPanel(playerObj, item)
    ISRadioWindow.activate(playerObj, item);
end
