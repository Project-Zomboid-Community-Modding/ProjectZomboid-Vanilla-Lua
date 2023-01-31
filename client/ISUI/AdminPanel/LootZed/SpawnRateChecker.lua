LootZedTool = {}

LootZedTool.SpawnItemCheckerList = {}
LootZedTool.SpawnItemChecker = {}

local function iListContains(list, item)
    for i, val in ipairs(list) do
        if item == val then 
            return true
        end
    end
    return false
end

function LootZedTool.rollProceduralItem_CalcChances(proceduralItems, container, _, character, roomDist)
    local forcedToSpawn = nil
    local normalSpawn = {}

    for _, item in ipairs(proceduralItems) do
        local name = item.name
        local forceForItems = nil
        if item.forceForItems ~= nil then
            if string.find(item.forceForItems, ";") ~= nil then
                forceForItems = luautils.split(item.forceForItems, ";")
            else
                forceForItems = {item.forceForItems}
            end
        end
        local forceForZones = nil
        if item.forceForZones ~= nil then
            if string.find(item.forceForZones, ";") ~= nil then
                forceForZones = luautils.split(item.forceForZones, ";")
            else
                forceForZones = {item.forceForZones}
            end
        end
        local forceForTiles = nil
        if item.forceForTiles ~= nil then
            if string.find(item.forceForTiles, ";") ~= nil then
                forceForTiles = luautils.split(item.forceForTiles, ";")
            else
                forceForTiles = {item.forceForTiles}
            end
        end
        local forceForRooms = nil
        if item.forceForRooms ~= nil then
            if string.find(item.forceForRooms, ";") ~= nil then
                forceForRooms = luautils.split(item.forceForRooms, ";")
            else
                forceForRooms = {item.forceForRooms}
            end
        end
        
        if forceForItems then
            for x = container:getSourceGrid():getRoom():getRoomDef():getX(), container:getSourceGrid():getRoom():getRoomDef():getX2() do
                for y = container:getSourceGrid():getRoom():getRoomDef():getY(), container:getSourceGrid():getRoom():getRoomDef():getY2() do
                    local sq = container:getSourceGrid():getCell():getGridSquare(x, y, container:getSourceGrid():getZ())
                    if sq ~= nil then
                        for i = 0, sq:getObjects():size()-1 do
                            local obj = sq:getObjects():get(i)
                            if iListContains(forceForItems, obj:getSprite():getName()) then
                                forcedToSpawn = name
                                LootZedTool.SpawnItemChecker.forceForItems = obj:getSprite():getName()
                            end
                        end
                    end
                end
            end
        elseif forceForZones then
            local metaZones = getWorld():getMetaGrid():getZonesAt(container:getSourceGrid():getX(), container:getSourceGrid():getY(), 0)
            for i = 0, metaZones:size()-1 do
                if iListContains(forceForZones, metaZones:get(i):getType()) or iListContains(forceForZones, metaZones:get(i):getName()) then
                    forcedToSpawn = name                    
                    if iListContains(forceForZones, metaZones:get(i):getType()) then
                        LootZedTool.SpawnItemChecker.forceForZones = metaZones:get(i):getType()
                    elseif iListContains(forceForZones, metaZones:get(i):getName()) then
                        LootZedTool.SpawnItemChecker.forceForZones = metaZones:get(i):getName()
                    end
                end
            end
        elseif forceForTiles then
            local sq = container:getSourceGrid()
            if sq ~= nil then
                for i = 0, sq:getObjects():size()-1 do
                    local obj = sq:getObjects():get(i)
                    if obj:getSprite() ~= nil and iListContains(forceForTiles, obj:getSprite():getName()) then
                        forcedToSpawn = name
                        LootZedTool.SpawnItemChecker.forceForTiles = obj:getSprite():getName()
                    end
                end
            end
        elseif forceForRooms then
            local sq = container:getSourceGrid()
            if sq ~= nil then
                for i, room in ipairs(forceForRooms) do
                    if sq:getBuilding():getRandomRoom(room) ~= nil then
                        forcedToSpawn = name
                        LootZedTool.SpawnItemChecker.forceForRooms = room
                    end
                end
            end
        end

        if forceForItems == nil and forceForZones == nil and forceForTiles == nil and forceForRooms == nil then
            table.insert(normalSpawn, name)
        end
    end

    local containerNameToSpawn = nil
    if forcedToSpawn ~= nil then
        containerNameToSpawn = forcedToSpawn
        local containerDistToSpawn = ProceduralDistributions.list[containerNameToSpawn]
        if containerDistToSpawn ~= nil then
            LootZedTool.SpawnItemChecker.containerType = containerNameToSpawn
            if containerDistToSpawn.junk ~= nil then
                LootZedTool.doRollItem_CalcChances(containerDistToSpawn.junk, container, 0, character, true, true, roomDist)
            end
            LootZedTool.doRollItem_CalcChances(containerDistToSpawn, container, 0, character, true, false, roomDist)
        end
    elseif #normalSpawn ~= 0 then
        for i, n in ipairs(normalSpawn) do
            containerNameToSpawn = n
            local containerDistToSpawn = ProceduralDistributions.list[containerNameToSpawn]
            if containerDistToSpawn ~= nil then
                LootZedTool.SpawnItemChecker.containerType = containerNameToSpawn
                if containerDistToSpawn.junk ~= nil then
                    LootZedTool.doRollItem_CalcChances(containerDistToSpawn.junk, container, 0, character, true, true, roomDist)
                end
                LootZedTool.doRollItem_CalcChances(containerDistToSpawn, container, 0, character, true, false, roomDist)
            end
        end
    end
end

function LootZedTool.doRollItem_CalcChances(containerDist, _, _, character, _, isJunk, _)
    local lucky = false
    local unlucky = false
    local itemName = ""

    if character ~= nil then
        lucky = character:getTraits():contains("Lucky")
        unlucky = character:getTraits():contains("Unlucky")
    end

    local n = containerDist.rolls

    for i=1, #containerDist.items, 2 do
        itemName = containerDist.items[i]
        local itemNumber = containerDist.items[i+1]

        if lucky then
            itemNumber = itemNumber * 1.1
        end
        if unlucky then
            itemNumber = itemNumber * 0.9
        end

        local lootModifier = ItemPickerJava.getLootModifier(itemName)

        if isJunk then
            lootModifier = 1.0
            itemNumber = itemNumber * 1.4
        end

        local chance = (itemNumber*lootModifier)/100.0
        if LootZedTool.SpawnItemCheckerList[LootZedTool.SpawnItemChecker.containerType] == nil then
            LootZedTool.SpawnItemCheckerList[LootZedTool.SpawnItemChecker.containerType] = {}
        end
        if LootZedTool.SpawnItemCheckerList[LootZedTool.SpawnItemChecker.containerType][itemName] == nil then
            LootZedTool.SpawnItemCheckerList[LootZedTool.SpawnItemChecker.containerType][itemName] = (1 - (1-chance)^n)
        else
            LootZedTool.SpawnItemCheckerList[LootZedTool.SpawnItemChecker.containerType][itemName] = LootZedTool.SpawnItemCheckerList[LootZedTool.SpawnItemChecker.containerType][itemName] + (1 - (1-chance)^n)
        end
    end
end

function LootZedTool.rollItem_CalcChances(containerDist, container, doItemContainer, player, roomDist)
    if containerDist ~= nil and container ~= nil then
        if containerDist.procedural then
            LootZedTool.rollProceduralItem_CalcChances(containerDist.procList, container, 0, player, roomDist)
        else
            if containerDist.junk ~= nil then
                LootZedTool.doRollItem_CalcChances(containerDist.junk, container, 0, player, doItemContainer, true, roomDist)
            end

            LootZedTool.doRollItem_CalcChances(containerDist, container, 0, player, doItemContainer, false, roomDist)
        end
    end
end

function LootZedTool.fillContainerType_CalcChances(roomDist, container, roomName, player)
    local doItemContainer = true
    if NoContainerFillRooms[roomName] ~= nil then
        doItemContainer = false       
    end

    local containerDist = nil

    if roomDist["all"] ~= nil then
        containerDist = roomDist["all"]
        LootZedTool.rollItem_CalcChances(containerDist, container, doItemContainer, player, roomDist)
        LootZedTool.SpawnItemChecker.containerType = "all"
    end

    containerDist = roomDist[container:getType()]
    LootZedTool.SpawnItemChecker.containerType = container:getType()

    if containerDist == nil then
        containerDist = roomDist["other"]
        LootZedTool.SpawnItemChecker.containerType = "other"
    end

    if containerDist ~= nil then
        LootZedTool.rollItem_CalcChances(containerDist, container, doItemContainer, player, roomDist)
    end
end

local function getNameForVehicleDistribution(tableData)
    for key, val in pairs(VehicleDistributions) do
        if tableData == val then
            return key
        end
    end
    return "Specific"
end

function LootZedTool.fillContainer_CalcChances(container, player)
    LootZedTool.SpawnItemChecker.roomName = ""
    LootZedTool.SpawnItemChecker.containerType = ""
    LootZedTool.SpawnItemChecker.forceForItems = ""
    LootZedTool.SpawnItemChecker.forceForZones = ""
    LootZedTool.SpawnItemChecker.forceForTiles = ""
    LootZedTool.SpawnItemChecker.forceForRooms = ""

    --- --- ---

    if instanceof(container:getParent(), "BaseVehicle") then
        local vehicle = container:getParent()
        local name = (luautils.split(vehicle:getScriptName(), "."))[2]
        local skinIndex = vehicle:getSkinIndex()

        if name ~= nil then
            local distribution = VehicleDistributions[1][name .. skinIndex]
            if distribution == nil then
                distribution = VehicleDistributions[1][name]
            end

            local distributionNormal = distribution.Normal
            local distributionSpecific = distribution.Specific

            LootZedTool.SpawnItemChecker.containerType = "Normal"
            local containerDist = distributionNormal[container:getType()]
            LootZedTool.rollItem_CalcChances(containerDist, container, true, player, nil)

            if distributionSpecific ~= nil then
                for i, tableData in ipairs(distributionSpecific) do
                    LootZedTool.SpawnItemChecker.containerType = getNameForVehicleDistribution(tableData)
                    containerDist = tableData[container:getType()]
                    LootZedTool.rollItem_CalcChances(containerDist, container, true, player, nil)
                end
            end
        end
        return
    end

    local sq = container:getSourceGrid()

    local room = nil
    if sq ~= nil then
        room = sq:getRoom()
    else
        return
    end

    if container:getType() == "inventorymale" or container:getType() == "inventoryfemale" then
        local containerType = container:getType()
        if container:getParent() ~= nil and instanceof(container:getParent(), "IsoDeadBody") then
            containerType = container:getParent():getOutfitName()
        end
        if containerType ~= nil then
            local containerDist = SuburbsDistributions["all"]["Outfit_" .. containerType]
            if containerDist == nil then
                containerDist = SuburbsDistributions["all"][container:getType()]
            end
            LootZedTool.SpawnItemChecker.containerType = containerType
            LootZedTool.rollItem_CalcChances(containerDist, container, true, player, nil)
        end
        return
    end

    local roomDist = SuburbsDistributions["all"]

    if room ~= nil and SuburbsDistributions[room:getName()] ~= nil then
        local roomName = room:getName()

        LootZedTool.SpawnItemChecker.roomName = roomName

        local roomDist2 = SuburbsDistributions[roomName]
        local containerDist = nil
        if roomDist2[container:getType()] ~= nil then
            containerDist = roomDist2[container:getType()]
            LootZedTool.SpawnItemChecker.containerType = container:getType()
        end

        if containerDist == nil and roomDist2["other"] ~= nil then
            containerDist = roomDist2["other"]
            LootZedTool.SpawnItemChecker.containerType = "other"
        end

        if containerDist == nil and roomDist2["all"] ~= nil then
            containerDist = roomDist2["all"]
            roomName = "all"
            LootZedTool.SpawnItemChecker.containerType = "all"
            LootZedTool.SpawnItemChecker.roomName = "all"
        end

        if containerDist == nil then
            LootZedTool.fillContainerType_CalcChances(roomDist, container, roomName, player)
            return
        end
    else
        local roomName = nil

        if room ~= nil then
            roomName = room:getName()
            LootZedTool.SpawnItemChecker.roomName = room:getName()
        else
            roomName = "all"
            LootZedTool.SpawnItemChecker.roomName = "all"
        end

        LootZedTool.fillContainerType_CalcChances(roomDist, container, roomName, player)
        return
    end

    if SuburbsDistributions[room:getName()] ~= nil then
        roomDist = SuburbsDistributions[room:getName()]
    end

    if roomDist ~= nil then
        LootZedTool.fillContainerType_CalcChances(roomDist, container, room:getName(), player)
        LootZedTool.SpawnItemChecker.roomName = room:getName()
    end
end

