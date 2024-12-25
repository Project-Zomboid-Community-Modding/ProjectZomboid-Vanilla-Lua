--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

ContextualActionHandlers = ContextualActionHandlers or {}

function ContextualActionHandlers.ClimbOverFence(action, playerObj, arg1, arg2, arg3, arg4)
    local worldobjects = nil
    local playerNum = playerObj:getIndex()
    local fence = arg1
    ISWorldObjectContextMenu.onClimbOverFence(worldobjects, fence, playerNum)
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

function ContextualActionHandlerWrapper(action, playerObj, arg1, arg2, arg3, arg4)
    if ContextualActionHandlers[action] then
        ContextualActionHandlers[action](action, playerObj, arg1, arg2, arg3, arg4)
    else
        error(string.format('no ContextualAction handler for action %s', action))
    end
end

Hook.ContextualAction.Add(ContextualActionHandlerWrapper)
