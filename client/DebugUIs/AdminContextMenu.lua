
AdminContextMenu = {};

local function removeDuplicates(list)
    local result = {}
    local seen = {}
    for _,item in ipairs(list) do
        if not seen[item] then
            seen[item] = true
            table.insert(result, item)
        end
    end
    return result
end

AdminContextMenu.onTriggerThunderUI = function(playerObj)
    local window = ISTriggerThunderUI:new(100, 350, 200, 200, playerObj)
    window:initialise()
    window:addToUIManager()
end

AdminContextMenu.doMenu = function(player, context, worldobjects, test)
    if not (isClient() and (isAdmin() or getAccessLevel() == "moderator")) then return true; end
    if test and ISWorldObjectContextMenu.Test then return true end

    local square = nil;
    for i,v in ipairs(worldobjects) do
        square = v:getSquare();
        break;
    end

    for i=1,square:getObjects():size() do
        table.insert(worldobjects, square:getObjects():get(i-1))
    end
    worldobjects = removeDuplicates(worldobjects)

    local playerObj = getSpecificPlayer(player)

    local debugOption = context:addDebugOption("Tools", worldobjects, nil);
    local subMenu = ISContextMenu:getNew(context);
    context:addSubMenu(debugOption, subMenu);

    subMenu:addOption("Teleport", playerObj, AdminContextMenu.onTeleportUI);
    subMenu:addOption("Remove item tool", playerObj, AdminContextMenu.onRemoveItemTool)
    subMenu:addOption("Spawn Vehicle", playerObj, AdminContextMenu.onSpawnVehicle);
    subMenu:addOption("Horde Manager", square, AdminContextMenu.onHordeManager, playerObj);
    subMenu:addOption("Trigger Thunder", playerObj, AdminContextMenu.onTriggerThunderUI)

    local noiseOption = subMenu:addOption("Make noise", worldobjects, nil);
    local noiseSubMenu = subMenu:getNew(subMenu);
    subMenu:addSubMenu(noiseOption, noiseSubMenu);

    noiseSubMenu:addOption("Radius: 10", square, AdminContextMenu.onMakeNoise, playerObj, 10, 100);
    noiseSubMenu:addOption("Radius: 20", square, AdminContextMenu.onMakeNoise, playerObj, 20, 100);
    noiseSubMenu:addOption("Radius: 50", square, AdminContextMenu.onMakeNoise, playerObj, 50, 100);
    noiseSubMenu:addOption("Radius: 100", square, AdminContextMenu.onMakeNoise, playerObj, 100, 100);
    noiseSubMenu:addOption("Radius: 200", square, AdminContextMenu.onMakeNoise, playerObj, 200, 100);
    noiseSubMenu:addOption("Radius: 500", square, AdminContextMenu.onMakeNoise, playerObj, 500, 100);

    subMenu:addOption(getText("IGUI_SpawnHorde_RemoveAllZombies"), nil, AdminContextMenu.OnRemoveAllZombiesClient)

    local vehicle = square:getVehicleContainer()
    if vehicle ~= nil then
        local debugVehOption = subMenu:addOption("Vehicle:", worldobjects, nil);
        local vehSubMenu = ISContextMenu:getNew(subMenu);
        context:addSubMenu(debugVehOption, vehSubMenu);

        vehSubMenu:addOption("HSV & Skin UI", playerObj, AdminContextMenu.onDebugColor, vehicle);
        vehSubMenu:addOption("Blood UI", playerObj, AdminContextMenu.onDebugBlood, vehicle);
        vehSubMenu:addOption("Remove", playerObj, ISVehicleMechanics.onCheatRemove, vehicle);
    end

    for _,obj in ipairs(worldobjects) do
        if instanceof(obj, "IsoDoor") or (instanceof(obj, "IsoThumpable") and obj:isDoor()) then
            local doorOption = subMenu:addOption("Door", worldobjects)
            local doorSubMenu = subMenu:getNew(subMenu)
            subMenu:addSubMenu(doorOption, doorSubMenu)

            doorSubMenu:addOption("Get Door Key", worldobjects, AdminContextMenu.OnGetDoorKey, obj, player)
            doorSubMenu:addOption(obj:isLocked() and "Door Unlock" or "Door Lock", worldobjects, AdminContextMenu.OnDoorLock, obj)
            doorSubMenu:addOption(string.format("Set Door Key ID (%d)", obj:getKeyId()), worldobjects, AdminContextMenu.OnSetDoorKeyID, obj)
            doorSubMenu:addOption("Set Door Building Key ID", worldobjects, AdminContextMenu.OnSetDoorKeyIDBuilding, obj)
            doorSubMenu:addOption("Set Door Random Key ID", worldobjects, AdminContextMenu.OnSetDoorKeyIDRandom, obj)
            doorSubMenu:addOption(string.format("Set force lock (%s)", tostring(not obj:getModData().CustomLock)), worldobjects, AdminContextMenu.setForceLockDoor, obj, player)
        end
    end
end
Events.OnFillWorldObjectContextMenu.Add(AdminContextMenu.doMenu);

AdminContextMenu.onTeleportUI = function(playerObj)
    local ui = ISTeleportDebugUI:new(0, 0, 300, 200, playerObj, nil, DebugContextMenu.onTeleportValid);
    ui:initialise();
    ui:addToUIManager();
end

AdminContextMenu.onRemoveItemTool = function(playerObj)
    local ui = ISRemoveItemTool:new(0, 0, playerObj);
    ui:initialise();
    ui:addToUIManager();
end

AdminContextMenu.onSpawnVehicle = function(playerObj)
    local ui = ISSpawnVehicleUI:new(0, 0, 200, 300, playerObj);
    ui:initialise();
    ui:addToUIManager();
end

AdminContextMenu.onHordeManager = function(square, player)
    local ui = ISSpawnHordeUI:new(0, 0, player, square);
    ui:initialise();
    ui:addToUIManager();
end

function AdminContextMenu.onDebugColor(playerObj, vehicle)
    debugVehicleColor(playerObj, vehicle)
end

function AdminContextMenu.onDebugBlood(playerObj, vehicle)
    debugVehicleBloodUI(playerObj, vehicle)
end


function AdminContextMenu.OnGetDoorKey(worldobjects, door, player)
    local keyID = -1
    if instanceof(door, "IsoDoor") then
        keyID = door:checkKeyId()
    elseif instanceof(door, "IsoThumpable") then
        keyID = door:getKeyId()
    end

    if keyID == -1 then
        keyID = ZombRand(100000000)
    end
    door:setKeyId(keyID)

    local doubleDoorObjects = buildUtil.getDoubleDoorObjects(door)
    for i=1,#doubleDoorObjects do
        local object = doubleDoorObjects[i]
        object:setKeyId(keyID)
    end

    local garageDoorObjects = buildUtil.getGarageDoorObjects(door)
    for i=1,#garageDoorObjects do
        local object = garageDoorObjects[i]
        object:setKeyId(keyID)
    end

    if isClient() then
        SendCommandToServer("/addkey \"" .. getSpecificPlayer(player):getDisplayName() .. "\" \"" .. luautils.trim(tostring(keyID)) .. "\"")
    else
        local item = instanceItem("Base.Key1")
        item:setKeyId(keyID)
        getSpecificPlayer(player):getInventory():AddItem(item);
    end
end

function AdminContextMenu.OnDoorLock(worldobjects, door)
    door:setIsLocked(not door:isLocked())
    if instanceof(door, "IsoDoor") and door:checkKeyId() ~= -1 then
        door:setLockedByKey(door:isLocked())
    end
    if instanceof(door, "IsoThumpable") and door:getKeyId() ~= -1 then
        door:setLockedByKey(door:isLocked())
    end
    getPlayer():getMapKnowledge():setKnownBlockedDoor(door, door:isLocked())

    local doubleDoorObjects = buildUtil.getDoubleDoorObjects(door)
    for i=1,#doubleDoorObjects do
        local object = doubleDoorObjects[i]
        object:setLockedByKey(door:isLocked())
    end

    local garageDoorObjects = buildUtil.getGarageDoorObjects(door)
    for i=1,#garageDoorObjects do
        local object = garageDoorObjects[i]
        object:setLockedByKey(door:isLocked())
    end
end


local function OnDoorSetKeyID2(target, button, obj)
    if button.internal == "OK" then
        local text = button.parent.entry:getText()
        local keyId = tonumber(text)
        if not keyId then return end
        obj:setKeyId(keyId)

        local doubleDoorObjects = buildUtil.getDoubleDoorObjects(obj)
        for i=1,#doubleDoorObjects do
            local object = doubleDoorObjects[i]
            object:setKeyId(keyId)
        end

        local garageDoorObjects = buildUtil.getGarageDoorObjects(obj)
        for i=1,#garageDoorObjects do
            local object = garageDoorObjects[i]
            object:setKeyId(keyId)
        end
    end
end

function AdminContextMenu.OnSetDoorKeyID(worldobjects, door)
    local modal = ISTextBox:new(0, 0, 280, 180, "Key ID:", tostring(door:getKeyId()), nil, OnDoorSetKeyID2, nil, door)
    modal:initialise()
    modal:addToUIManager()
end

function AdminContextMenu.OnSetDoorKeyIDRandom(worldobjects, door)
    local keyId = ZombRand(1000000)
    door:setKeyId(keyId)

    local doubleDoorObjects = buildUtil.getDoubleDoorObjects(door)
    for i=1,#doubleDoorObjects do
        local object = doubleDoorObjects[i]
        object:setKeyId(keyId)
    end

    local garageDoorObjects = buildUtil.getGarageDoorObjects(door)
    for i=1,#garageDoorObjects do
        local object = garageDoorObjects[i]
        object:setKeyId(keyId)
    end
end

function AdminContextMenu.setForceLockDoor(worldobjects, door, player)
    if not door:getModData().CustomLock then
        door:getModData().CustomLock = true
    else
        door:getModData().CustomLock = false
    end
    door:transmitModData()
end

function AdminContextMenu.OnSetDoorKeyIDBuilding(worldobjects, door)
    local sq = door:getSquare()
    local sq2 = door:getOppositeSquare()
    if sq == nil or sq2 == nil then return end
    local building = sq:getBuilding()
    local building2 = sq2:getBuilding()
    local bDef = nil
    local bDef2 = nil
    if building ~= nil then
        bDef = building:getDef()
    end
    if building2 ~= nil then
        bDef2 = building2:getDef()
    end
    if bDef ~= nil then
        door:setKeyId(bDef:getKeyId())
    elseif bDef2 ~= nil then
        door:setKeyId(bDef2:getKeyId())
    end
end

function AdminContextMenu.OnRemoveAllZombiesClient(zombie)
    SendCommandToServer(string.format("/removezombies -remove true"))
end

AdminContextMenu.onMakeNoise = function(square, playerObj, radius, volume)
    addSound(playerObj, square:getX(), square:getY(), square:getZ(), radius, volume)
end
