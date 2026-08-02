
if not DebugAddEnclosure then
    DebugAddEnclosure = {}
end

local FENCE_NS_SPRITE = "carpentry_02_41"
local FENCE_WE_SPRITE = "carpentry_02_40"
local CORNER_SPRITE   = "walls_exterior_wooden_01_27"
local FLOOR_SPRITE    = "carpentry_02_56"

local function broadcastObject(obj)
    if isServer() and obj and obj.transmitCompleteItemToClients then
        obj:transmitCompleteItemToClients()
    end
end

function DebugAddEnclosure.run(player)
    if not player then return end
    local centerSq = player:getCurrentSquare()
    if not centerSq then return end

    local size = 10
    local cx = centerSq:getX()
    local cy = centerSq:getY()
    local cz = centerSq:getZ()
    local cell = getCell()
    if not cell then return end

    DesignationZoneAnimal.new("NewZone", cx - size, cy - size, cz,
                              cx + size, cy + size, true)

    for x = cx - 9, cx - 4 do
        for y = cy - 9, cy - 4 do
            local isCorner =
                (x == cx - 4 and y == cy - 4) or
                (x == cx - 9 and y == cy - 9) or
                (x == cx - 9 and y == cy - 4) or
                (x == cx - 4 and y == cy - 9)

            if isCorner then
                local sq = getSquare(x, y, 0)
                if sq then
                    local obj = IsoObject.getNew(sq, CORNER_SPRITE, nil, false)
                    sq:AddTileObject(obj)
                    broadcastObject(obj)
                end
            end

            local sq = IsoGridSquare.new(cell, nil, x, y, 1)
            cell:ConnectNewSquare(sq, false)
            sq:addFloor(FLOOR_SPRITE)
        end
    end

    for x = cx - size, cx + (size - 1) do
        local sqN = getSquare(x, cy - size, cz)
        if sqN then
            local fence = IsoThumpable.new(cell, sqN, FENCE_NS_SPRITE, false,
                ISSimpleFurniture:new("Fence", FENCE_NS_SPRITE, FENCE_NS_SPRITE))
            sqN:AddTileObject(fence)
            broadcastObject(fence)
        end
        local sqS = getSquare(x, cy + size, cz)
        if sqS then
            local fence = IsoThumpable.new(cell, sqS, FENCE_NS_SPRITE, false,
                ISSimpleFurniture:new("Fence", FENCE_NS_SPRITE, FENCE_NS_SPRITE))
            sqS:AddTileObject(fence)
            broadcastObject(fence)
        end
    end

    for y = cy - size, cy + (size - 1) do
        local sqW = getSquare(cx - size, y, cz)
        if sqW then
            local fence = IsoThumpable.new(cell, sqW, FENCE_WE_SPRITE, false,
                ISSimpleFurniture:new("Fence", FENCE_WE_SPRITE, FENCE_WE_SPRITE))
            sqW:AddTileObject(fence)
            broadcastObject(fence)
        end
        local sqE = getSquare(cx + size, y, cz)
        if sqE then
            local fence = IsoThumpable.new(cell, sqE, FENCE_WE_SPRITE, false,
                ISSimpleFurniture:new("Fence", FENCE_WE_SPRITE, FENCE_WE_SPRITE))
            sqE:AddTileObject(fence)
            broadcastObject(fence)
        end
    end
end

return DebugAddEnclosure
