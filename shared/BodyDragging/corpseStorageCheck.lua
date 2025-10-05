-- This should hopefully outline all the stuff needed to grab containers that can hold an instanced body item.
-- Since the inventory pane can't be accessed using only IsoPlayer I'll need to add some extra stuff to integrate that.
-- This can be considered a basic working test I guess?

require "Util/LuaTableUtil"
require "ISUI/ISInventoryPaneContextMenu"
require "ISUI/ISVehicleMenu"
require "ISUI/ISContextMenu"
require "TimedActions/ISDropCorpseIntoContainer"

corpseStorageCheck = {}

corpseStorageCheck.isEnabled = true;

-- Grabs two lists of containers from IsoPlayer.
function corpseStorageCheck.worldObjectContext(playerNum, contextMenu, _worldObjects)
    if not corpseStorageCheck.isEnabled then
        return
    end

    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return
    end

    local isDraggingCorpse = playerObj:isDraggingCorpse()
    if not isDraggingCorpse then
        corpseStorageCheck.doContextGrabCorpsesFromContainers(playerNum, contextMenu, _worldObjects)
    else
        corpseStorageCheck.doContextDropCorpsesIntoContainers(playerNum, contextMenu, _worldObjects)
    end
end

function corpseStorageCheck.doContextDropCorpsesIntoContainers(playerNum, contextMenu, _worldObjects)
    print("Grapple:corpseStorageCheck.doContextDropCorpsesIntoContainers Searching for suitable containers to drop into.")

    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return
    end

    if not _worldObjects then
        return
    end

    local isDraggingCorpse = playerObj:isDraggingCorpse()
    if not isDraggingCorpse then
        print("Grapple:corpseStorageCheck.doContextDropCorpsesIntoContainers Not dragging a corpse.")
        return
    end

    local clickedSquare = nil;
    for i, v in ipairs(_worldObjects) do
        clickedSquare = v:getSquare();
        break ;
    end

    local suitableContainers = {}

    local clickedContainers = playerObj:getContextWorldSuitableContainersToDropCorpseInObjects(_worldObjects)
    for i = 0, clickedContainers:size() - 1 do
        LuaTableUtil:insertUnique(suitableContainers, clickedContainers:get(i))
    end

    local squareContainers = playerObj:getSuitableContainersToDropCorpseInSquare(clickedSquare);
    for i = 0, squareContainers:size() - 1 do
        LuaTableUtil:insertUnique(suitableContainers, squareContainers:get(i))
    end

    if #suitableContainers <= 0 then
        print("Grapple:corpseStorageCheck.doContextDropCorpsesIntoContainers No suitable containers found.")
        return
    end

    if #suitableContainers == 1 then
        local targetContainer = suitableContainers[1]
        local optionItem = contextMenu:addOptionOnTop(getText("IGUI_Option_DropCorpseIntoContainerName") .. corpseStorageCheck.getContainerName(targetContainer), playerNum, corpseStorageCheck.onDropCorpseInto, targetContainer)
        optionItem.notAvailable = corpseStorageCheck.canPlayerAccessContainer(playerNum, targetContainer) == false
        optionItem.toolTip = corpseStorageCheck.getContainerToolTip(playerNum, targetContainer)
        return
    end

    -- Create subGroup for all options
    local dropCorpseGroup = contextMenu:addOptionOnTop(getText("IGUI_Option_DropCorpseInto"));
    local dropCorpseSubMenu = contextMenu:getNew(contextMenu)
    contextMenu:addSubMenu(dropCorpseGroup, dropCorpseSubMenu)

    for i = 1, #suitableContainers do
        local targetContainer = suitableContainers[i]
        local optionItem = dropCorpseSubMenu:addOption(corpseStorageCheck.getContainerName(targetContainer), playerNum, corpseStorageCheck.onDropCorpseInto, targetContainer)
        optionItem.notAvailable = corpseStorageCheck.canPlayerAccessContainer(playerNum, targetContainer) == false
        optionItem.toolTip = corpseStorageCheck.getContainerToolTip(playerNum, targetContainer)
    end
end

function corpseStorageCheck.onDropCorpseInto(playerNum, targetContainer)
    local walkToSuccess = luautils.walkToContainer(targetContainer, playerNum)
    if not walkToSuccess then
        print("Grapple:Warning: Could not find a path to destination container.")
        return
    end

    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return
    end

    local doorNeedsOpening = targetContainer:doesVehicleDoorNeedOpening()
    if doorNeedsOpening then
        local canOpen = targetContainer:canCharacterUnlockVehicleDoor(playerObj)
        if not canOpen then
            print("Grapple:Warning: Player cannot open door. It may be locked or broken.")
            return
        end

        corpseStorageCheck.openContainerVehicleDoor(playerNum, targetContainer)
    end

    local playerObj = getSpecificPlayer(playerNum)
    ISTimedActionQueue.add(ISDropCorpseIntoContainer:new(playerObj, targetContainer))

    if doorNeedsOpening then
        corpseStorageCheck.closeContainerVehicleDoor(playerNum, targetContainer)
    end
end

function corpseStorageCheck.doContextGrabCorpsesFromContainers(playerNum, contextMenu, _worldObjects)
    print("Grapple:corpseStorageCheck.doContextGrabCorpsesFromContainers Searching for suitable containers that contain a corpse.")

    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return
    end

    if not _worldObjects then
        return
    end

    local isDraggingCorpse = playerObj:isDraggingCorpse()
    if isDraggingCorpse then
        print("Grapple:corpseStorageCheck.doContextGrabCorpsesFromContainers Already dragging a corpse. Cannot grab another.")
        return
    end

    local clickedSquare = nil;
    for i, v in ipairs(_worldObjects) do
        clickedSquare = v:getSquare();
        break ;
    end

    local suitableContainers = {}

    local clickedContainers = playerObj:getContextWorldContainersWithHumanCorpse(_worldObjects)
    for i = 0, clickedContainers:size() - 1 do
        LuaTableUtil:insertUnique(suitableContainers, clickedContainers:get(i))
    end

    local squareContainers = playerObj:getSuitableContainersWithHumanCorpseInSquare(clickedSquare);
    for i = 0, squareContainers:size() - 1 do
        LuaTableUtil:insertUnique(suitableContainers, squareContainers:get(i))
    end

    if #suitableContainers <= 0 then
        print("Grapple:corpseStorageCheck.doContextGrabCorpsesFromContainers No suitable containers found.")
        return
    end

    if #suitableContainers == 1 then
        local targetContainer = suitableContainers[1]
        local optionItem = contextMenu:addOptionOnTop(getText("IGUI_Option_GrabCorpseFromContainerName") .. corpseStorageCheck.getContainerName(targetContainer), playerNum, corpseStorageCheck.onGrabCorpseFrom, targetContainer)
        optionItem.notAvailable = corpseStorageCheck.canPlayerAccessContainer(playerNum, targetContainer) == false
        optionItem.toolTip = corpseStorageCheck.getContainerToolTip(playerNum, targetContainer)
        return
    end

    -- Create subGroup for all options
    local grabCorpsesGroup = contextMenu:addOptionOnTop(getText("IGUI_Option_GrabCorpseFrom"));
    local grabCorpsesSubMenu = contextMenu:getNew(contextMenu)
    contextMenu:addSubMenu(grabCorpsesGroup, grabCorpsesSubMenu)

    for i = 1, #suitableContainers do
        local targetContainer = suitableContainers[i]
        local optionItem = grabCorpsesSubMenu:addOption(corpseStorageCheck.getContainerName(targetContainer), playerNum, corpseStorageCheck.onGrabCorpseFrom, targetContainer)
        optionItem.notAvailable = corpseStorageCheck.canPlayerAccessContainer(playerNum, targetContainer) == false
        optionItem.toolTip = corpseStorageCheck.getContainerToolTip(playerNum, targetContainer)
    end
end

function corpseStorageCheck.onGrabCorpseFrom(playerNum, targetContainer)
    local corpseItem = targetContainer:findHumanCorpseItem()
    if not corpseItem then
        print("Grapple:Warning: Target container does not have a corpse.")
        return
    end

    local walkToSuccess = luautils.walkToContainer(targetContainer, playerNum)
    if not walkToSuccess then
        print("Grapple:Warning: Could not find a path to target container.")
        return
    end

    local doorNeedsOpening = targetContainer:doesVehicleDoorNeedOpening()
    if doorNeedsOpening then
        local canOpen = targetContainer:canCharacterUnlockVehicleDoor(playerObj)
        if not canOpen then
            print("Grapple:Warning: Player cannot open door. It may be locked or broken.")
            return
        end

        corpseStorageCheck.openContainerVehicleDoor(playerNum, targetContainer)
    end

    ISInventoryPaneContextMenu.transferItemToPlayer(corpseItem, playerNum)

    if doorNeedsOpening then
        corpseStorageCheck.closeContainerVehicleDoor(playerNum, targetContainer)
    end
end

function corpseStorageCheck.openContainerVehicleDoor(playerNum, targetContainer)
    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return false
    end

    local part = targetContainer:getVehicleSeatDoorPart()
    if not part then
        return false
    end

    ISVehicleMenu.onOpenDoor(playerObj, part)
end

function corpseStorageCheck.closeContainerVehicleDoor(playerNum, targetContainer)
    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return false
    end

    local part = targetContainer:getVehicleSeatDoorPart()
    if not part then
        return false
    end

    ISVehicleMenu.onCloseDoor(playerObj, part)
end

function corpseStorageCheck.isPlayerGrabbingCorpseItem(playerNum, item, targetContainer)
    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return false
    end

    if not item then
        return false
    end

    if not targetContainer then
        return false
    end

    if not item:isHumanCorpse() then
        return false;
    end

    local playerInv = getPlayerInventory(playerNum).inventory;
    if not playerInv then
        return false
    end

    if playerInv == targetContainer then
        return true
    end

    return false
end

function corpseStorageCheck.canPlayerAccessContainer(playerNum, targetContainer)
    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return false
    end

    if not targetContainer then
        return false
    end

    local playerInv = getPlayerInventory(playerNum).inventory;
    if not playerInv then
        return false
    end

    if playerInv == targetContainer then
        return true
    end

    return playerObj:canAccessContainer(targetContainer)
end

function corpseStorageCheck.getContainerToolTip(playerNum, targetContainer)
    local playerObj = getSpecificPlayer(playerNum)
    if not playerObj then
        return nil
    end

    if not targetContainer then
        return nil
    end

    local playerInv = getPlayerInventory(playerNum).inventory;
    if not playerInv then
        return nil
    end

    local toolTipText = nil
    if playerInv == targetContainer then
        toolTipText = "IGUI_Tooltip_PlayerOwn"
    else
        toolTipText = playerObj:getContainerToolTip(targetContainer);
    end

    if toolTipText == nil or toolTipText == "" then
        return nil
    end

    local toolTip = ISInventoryPaneContextMenu.addToolTip();
    toolTip.description = getText(toolTipText)

    return toolTip
end

function corpseStorageCheck.getContainerName(container)
    if not container then
        return "!NULL!"
    end

    local containerType = container:getType()
    local containerKey = "IGUI_ContainerTitle_" .. containerType
    local containerName = getText(containerKey)

    return containerName
end

Events.OnFillWorldObjectContextMenu.Add(corpseStorageCheck.worldObjectContext)