
if not DebugIsoRegionsEdit then
    DebugIsoRegionsEdit = {}
end

local KIND_WHITELIST = {
    ["Edit.WallN"] = { sprite = "walls_exterior_wooden_01_25", north = true,  name = "Wall Debug"       },
    ["Edit.WallW"] = { sprite = "walls_exterior_wooden_01_24", north = false, name = "Wall Debug"       },
    ["Edit.DoorN"] = { sprite = "walls_exterior_wooden_01_35", north = true,  name = "Door Frame Debug" },
    ["Edit.DoorW"] = { sprite = "walls_exterior_wooden_01_34", north = false, name = "Door Frame Debug" },
    ["Edit.Floor"] = { isFloor = true, sprite = "carpentry_02_56" },
}

function DebugIsoRegionsEdit.run(player, args)
    if type(args) ~= "table" then return end
    if type(args.kind) ~= "string" then return end
    if type(args.x) ~= "number" or type(args.y) ~= "number" or type(args.z) ~= "number" then return end

    local def = KIND_WHITELIST[args.kind]
    if not def then return end

    local x, y, z = math.floor(args.x), math.floor(args.y), math.floor(args.z)
    local cell = getCell()
    if not cell then return end

    local gs = cell:getGridSquare(x, y, z)
    if gs == nil then
        gs = cell:createNewGridSquare(x, y, z, true)
        if gs == nil then return end
    end

    if def.isFloor then
        if z == 0 then return end
        gs:addFloor(def.sprite)
    else
        local thumpable = IsoThumpable.new(cell, gs, def.sprite, def.north, nil)
        thumpable:setMaxHealth(100)
        thumpable:setName(def.name)
        gs:AddSpecialObject(thumpable)
        gs:RecalcAllWithNeighbours(true)
        if isServer() then thumpable:transmitCompleteItemToClients() end
    end

    if gs:getZone() ~= nil then
        gs:getZone():setHaveConstruction(true)
    end
end

return DebugIsoRegionsEdit
