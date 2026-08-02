require("WorldGen/WorldGen")
require("WorldGen/Features")

worldgen["biomes"] = {}
worldgen["biomes_map"] = {}
worldgen["subbiomes"] = {}

-- Should be loaded first because biomes need it
local files = WorldGenUtils.INSTANCE:getFiles("lua/server/WorldGen/biomes/subbiomes")
for i = 1, WorldGenUtils.INSTANCE:getFilesNum() do
    local path = string.gsub(WorldGenUtils.INSTANCE:getFile(i - 1), "media/lua/server/", "")
    --print(path)
    require(path)
end

files = WorldGenUtils.INSTANCE:getFiles("lua/server/WorldGen/biomes/map")
for i = 1, WorldGenUtils.INSTANCE:getFilesNum() do
    local path = string.gsub(WorldGenUtils.INSTANCE:getFile(i - 1), "media/lua/server/", "")
    --print(path)
    require(path)
end

files = WorldGenUtils.INSTANCE:getFiles("lua/server/WorldGen/biomes/worldgen")
for i = 1, WorldGenUtils.INSTANCE:getFilesNum() do
    local path = string.gsub(WorldGenUtils.INSTANCE:getFile(i - 1), "media/lua/server/", "")
    --print(path)
    require(path)
end
