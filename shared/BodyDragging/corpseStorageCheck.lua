-- This should hopefully outline all the stuff needed to grab containers that can hold an instanced body item.
-- Since the inventory pane can't be accessed using only IsoPlayer I'll need to add some extra stuff to integrate that.
-- This can be considered a basic working test I guess?

corpseStorageCheck = {}

corpseStorageCheck.isEnabled = false;

-- Grabs two lists of containers from IsoPlayer.
function corpseStorageCheck.worldObjectContext(_player, contextMenu, _worldObjects)
    if not corpseStorageCheck.isEnabled then
        return
    end

    print("Grapple:corpseStorageCheck.worldObjectContext")

    local player = getSpecificPlayer(_player)

    local isDraggingCorpse = player:isDraggingCorpse()
    if not isDraggingCorpse then
        return
    end

    local worldContainers = player:getSuitableContainersToDropCorpse()
    if worldContainers:size() <= 0 then
        print("Grapple:No containers found.")
        return
    end

    for i=0, worldContainers:size()-1 do
        local targetContainer = worldContainers:get(i)
        contextMenu:addOption("Drop Corpse Into " .. targetContainer:getType(), _player, corpseStorageCheck.onDropCorpseInto, targetContainer)
    end
end

function corpseStorageCheck.onDropCorpseInto(_player, targetContainer)
    local player = getSpecificPlayer(_player)

    local playerSq = player:getCurrentSquare()
    local targetSq = targetContainer:getSquare()
    if targetSq and playerSq ~= targetSq then
        ISTimedActionQueue.add(ISWalkToTimedAction:new(player, targetSq))
    end
    ISTimedActionQueue.add(ISDropCorpseIntoContainer:new(player, targetContainer))
end

Events.OnFillWorldObjectContextMenu.Add(corpseStorageCheck.worldObjectContext)