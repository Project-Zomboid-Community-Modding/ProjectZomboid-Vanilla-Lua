--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

ContextualActionHandlers = ContextualActionHandlers or {}

function ContextualActionHandlers.ClimbOverFence(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local fence = arg1
    local dir = arg2
    ISWorldObjectContextMenu.onClimbOverFence(worldobjects, fence, dir, playerNum)
end

function ContextualActionHandlers.ClimbSheetRope(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local square = arg1
    local down = arg2
    ISWorldObjectContextMenu.onClimbSheetRope(worldobjects, square, down, playerNum)
end

function ContextualActionHandlers.ClimbThroughWindow(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local window = arg1
    ISWorldObjectContextMenu.onClimbThroughWindow(worldobjects, window, playerNum)
end

function ContextualActionHandlers.CloseCurtain(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local curtain = arg1
    ISWorldObjectContextMenu.onOpenCloseCurtain(worldobjects, curtain, playerNum)
end

function ContextualActionHandlers.CloseDoor(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local door = arg1
    ISWorldObjectContextMenu.onOpenCloseDoor(worldobjects, door, playerNum)
end

function ContextualActionHandlers.CloseWindow(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local window = arg1
    ISWorldObjectContextMenu.onOpenCloseWindow(worldobjects, window, playerNum)
end

function ContextualActionHandlers.OpenCurtain(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local curtain = arg1
    ISWorldObjectContextMenu.onOpenCloseCurtain(worldobjects, curtain, playerNum)
end

function ContextualActionHandlers.OpenDoor(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local door = arg1
    ISWorldObjectContextMenu.onOpenCloseDoor(worldobjects, door, playerNum)
end

function ContextualActionHandlers.OpenWindow(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local window = arg1
    ISWorldObjectContextMenu.onOpenCloseWindow(worldobjects, window, playerNum)
end

function ContextualActionHandlers.OpenButcherHook(action, playerObj, hook, arg2, arg3, arg4)
    local sq = getSquare(hook:getX(), hook:getY(), hook:getZ());
    if not luautils.walkAdj(playerObj, sq) then return; end

    ISTimedActionQueue.add(ISOpenButcherHookUI:new(playerObj, hook));
end

function ContextualActionHandlers.OpenHutch(action, playerObj, hutch, arg2, arg3, arg4)
    local shiftPressed = isKeyDown(Keyboard.KEY_LSHIFT);
    local sq = getSquare(hutch:getX(), hutch:getY(), hutch:getZ());
    if not luautils.walkAdj(playerObj, sq) then return; end
    if hutch then
        hutch = hutch:getHutch();
        playerObj:setIsAiming(false);
        if shiftPressed then
            ISTimedActionQueue.add(ISGetHutchInfo:new(playerObj, hutch))
        else
            ISTimedActionQueue.add(ISToggleHutchDoor:new(playerObj, hutch))
        end
    end
end

function ContextualActionHandlers.AnimalsInteraction(action, playerObj, animal, arg2, arg3, arg4)
    local sq = getSquare(animal:getX(), animal:getY(), animal:getZ());
    if not luautils.walkAdj(playerObj, sq) then return; end
    local item = playerObj:getPrimaryHandItem()

    local milk = item and item:hasTag("BucketEmpty") and animal:readyToBeMilked();
    local shear = item and item:hasTag("Shear") and animal:readyToBeSheared();
    local pet = animal:canBePet();

    playerObj:setIsAiming(false);

    if milk then
        AnimalContextMenu.onMilkAnimal(animal, playerObj, item);
        return;
    end

    if shear then
        if instanceof(shear, "DrainableComboItem") and shear:getCurrentUsesFloat() <= 0 then
            return;
        end
        AnimalContextMenu.onShearAnimal(animal, playerObj, item);
        return;
    end

    if pet then
        AnimalContextMenu.onPetAnimal(animal, playerObj);
        return;
    end
end

function ContextualActionHandlers.SleepInBed(action, playerObj, bed, arg2, arg3, arg4)
    if playerObj:getVehicle() then return end
    if playerObj:hasTimedActions() then return end
    if playerObj:isSittingOnFurniture() then return end

    ISWorldObjectContextMenu.onRest(bed, playerObj:getPlayerNum())
end

function ContextualActionHandlerWrapper(action, playerObj, arg1, arg2, arg3, arg4)
    if ContextualActionHandlers[action] then
        ContextualActionHandlers[action](action, playerObj, arg1, arg2, arg3, arg4)
    else
        error(string.format('no ContextualAction handler for action %s', action))
    end
end

Hook.ContextualAction.Add(ContextualActionHandlerWrapper)
