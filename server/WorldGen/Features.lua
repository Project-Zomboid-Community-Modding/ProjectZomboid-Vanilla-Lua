require("WorldGen/WorldGen")

worldgen["features"] = {
    GROUND = {},
    PLANT = {},
    BUSH = {},
    TREE = {},
    ORE = {},
    NONE = {},
}

-- We preload all the features at this point
local files = WorldGenUtils.INSTANCE:getFiles("lua/server/WorldGen/features")
for i = 1, WorldGenUtils.INSTANCE:getFilesNum() do
    local path = string.gsub(WorldGenUtils.INSTANCE:getFile(i - 1), "media/lua/server/", "")
    --print(path)
    require(path)
end
