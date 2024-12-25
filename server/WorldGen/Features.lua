--There are 3 types of decors. GROUND defines the basic ground, PLANT defines the flowers and grass, TREE defines the tress
--All 3 types must be define here. The location of the features is in WorldGen/features/<ground, plant, tree>/xxxx
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
