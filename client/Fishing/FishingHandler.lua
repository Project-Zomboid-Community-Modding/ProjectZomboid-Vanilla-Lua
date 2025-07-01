Fishing = Fishing or {}
Fishing.ManagerInstances = {}
Fishing.Handler = {}

function Fishing.Handler.OnGameStart()
    for i = 0, getNumActivePlayers()-1 do
        local player = getSpecificPlayer(i)
        if player ~= nil then
            Fishing.Handler.handleFishing(player, player:getPrimaryHandItem())
        end
    end
end
Events.OnGameStart.Add(Fishing.Handler.OnGameStart)

function Fishing.Handler.onEquipPrimary(player, inventoryItem)
    if player:isLocal() and not player:isAiming() then
        Fishing.Handler.handleFishing(player, inventoryItem)
    end
end
Events.OnEquipPrimary.Add(Fishing.Handler.onEquipPrimary)

function Fishing.Handler.handleFishing(player, primaryHandItem)
    local playerIndex = player:getPlayerNum()

    if Fishing.Handler.isFishingValid(primaryHandItem) then
        if Fishing.ManagerInstances[playerIndex] == nil then
            Fishing.ManagerInstances[playerIndex] = Fishing.FishingManager:new(player, player:getJoypadBind())
        end
    else
        if Fishing.ManagerInstances[playerIndex] ~= nil then
            Fishing.ManagerInstances[playerIndex]:destroy()
            Fishing.ManagerInstances[playerIndex] = nil
        end
    end
end

function Fishing.Handler.isFishingValid(primaryHandItem)
    return primaryHandItem ~= nil and primaryHandItem:hasTag("FishingRod")
end