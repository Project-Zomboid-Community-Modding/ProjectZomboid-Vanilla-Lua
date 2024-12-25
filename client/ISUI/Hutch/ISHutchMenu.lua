--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 24/03/2022
-- Time: 09:40
-- To change this template use File | Settings | File Templates.
--

ISHutchMenu = {}

function ISHutchMenu.OnFillWorldObjectContextMenu(player, context, worldobjects, test)
    if test and ISWorldObjectContextMenu.Test then return true end

    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    if playerObj:getVehicle() then return false end

    local hutch = nil;
    for i,v in ipairs(worldobjects) do
        if instanceof(v, "IsoHutch") then
            hutch = v:getHutch();
            break;
        end
    end

    if not hutch then return; end

    local distOk = playerObj:getCurrentSquare():DistToProper(hutch:getEntrySq()) <= 5;

    local subOption = context:addOption(getText("ContextMenu_Hutch"), worldobjects, nil);
    local subMenu = ISContextMenu:getNew(context);
    context:addSubMenu(subOption, subMenu);

    local option = subMenu:addOption(getText("ContextMenu_Hutch_Info"), hutch, ISHutchMenu.onInfo, playerObj)
    --if not distOk then
    --    option.notAvailable = true;
    --    local tooltip = ISWorldObjectContextMenu.addToolTip();
    --    tooltip:setName(getText("Tooltip_Hutch_TooFar"));
    --    option.toolTip = tooltip;
    --    return;
    --end

    if hutch:isOpen() then
        subMenu:addOption(getText("ContextMenu_Close_door"), hutch, ISHutchMenu.onToggleDoor, playerObj)
    else
        subMenu:addOption(getText("ContextMenu_Open_door"), hutch, ISHutchMenu.onToggleDoor, playerObj)
    end

    if hutch:isEggHatchDoorOpen() then
        subMenu:addOption(getText("ContextMenu_Hutch_CloseHatchDoor"), hutch, ISHutchMenu.onToggleEggHatchDoor, playerObj)
    else
        subMenu:addOption(getText("ContextMenu_Hutch_OpenHatchDoor"), hutch, ISHutchMenu.onToggleEggHatchDoor, playerObj)
    end

    if AnimalContextMenu.cheat then
        subMenu:addDebugOption("Set Hutch Dirt to 100", hutch, ISHutchMenu.setDirt, playerObj, 100)
        subMenu:addDebugOption("Set Hutch Dirt to 0", hutch, ISHutchMenu.setDirt, playerObj, 0)
        --subMenu:addOption("[DEBUG] Set Nest Dirt to 100", hutch, ISHutchMenu.setNestDirt, playerObj, 100)
        --subMenu:addOption("[DEBUG] Set Nest Dirt to 0", hutch, ISHutchMenu.setNestDirt, playerObj, 0)
    end

    -- put chicken/turkey inside the hutch
    if playerObj:getPrimaryHandItem() and instanceof(playerObj:getPrimaryHandItem(), "AnimalInventoryItem") then
        local animal = playerObj:getPrimaryHandItem():getAnimal();
        if not animal:canBePutInHutch(hutch) then
            return;
        end

        local option = subMenu:addOption(getText("ContextMenu_PutAnimalInHutch", animal:getFullName()), hutch, ISHutchMenu.onPutAnimalInsideHutch, playerObj)
        if hutch:isAllDoorClosed() then
            option.notAvailable = true;
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("IGUI_PutAnimalInHutch_DoorsClosed"));
            option.toolTip = tooltip;
        end
        if hutch:getAnimalInside():size() >= hutch:getMaxAnimals() then
            option.notAvailable = true;
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("IGUI_PutAnimalInHutch_HutchFull"));
            option.toolTip = tooltip;
        end
    end
end

ISHutchMenu.onPutAnimalInsideHutch = function(hutch, player)
    if luautils.walkAdj(player, hutch:getEntrySq()) then
        ISTimedActionQueue.add(ISPutAnimalInHutch:new(player, hutch))
    end
end

ISHutchMenu.setDirt = function(hutch, player, perc)
    if isClient() then
        sendClientCommandV(player, "hutch", "dirt",
                "x", hutch:getX(),
                "y", hutch:getY(),
                "z", hutch:getZ(),
                "dirt", perc)
    else
        hutch:setHutchDirt(perc);
    end
end

ISHutchMenu.setNestDirt = function(hutch, player, perc)
    if isClient() then
        sendClientCommandV(player, "hutch", "nestBoxDirt",
                "x", hutch:getX(),
                "y", hutch:getY(),
                "z", hutch:getZ(),
                "dirt", perc)
    else
        hutch:setNestBoxDirt(perc);
    end
end

ISHutchMenu.onInfo = function(hutch, chr)
    if luautils.walkAdj(chr, hutch:getEntrySq()) then
        ISTimedActionQueue.add(ISGetHutchInfo:new(chr, hutch))
    end
end

ISHutchMenu.onToggleDoor = function(hutch, player)
    if luautils.walkAdj(player, hutch:getEntrySq()) then
        ISTimedActionQueue.add(ISToggleHutchDoor:new(player, hutch))
    end
end

ISHutchMenu.onToggleEggHatchDoor = function(hutch, player)
    if luautils.walkAdj(player, hutch:getEntrySq()) then
        ISTimedActionQueue.add(ISToggleHutchEggHatchDoor:new(player, hutch))
    end
end

Events.OnFillWorldObjectContextMenu.Add(ISHutchMenu.OnFillWorldObjectContextMenu)