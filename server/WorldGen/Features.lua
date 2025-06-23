require("WorldGen/WorldGen")

worldgen["features"] = {
    GROUND = {},
    PLANT = {},
    BUSH = {},
    TREE = {},
    ORE = {}
}

-- We preload all the features at this point
local files = WGUtils.instance:getFiles("lua/server/WorldGen/features")
for i = 1, WGUtils.instance:getFilesNum() do
    local path = string.gsub(WGUtils.instance:getFile(i - 1), "media/lua/server/", "")
    --print(path)
    require(path)
end
