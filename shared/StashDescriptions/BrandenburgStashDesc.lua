
--
--Black: 0.129,0.129,0.129
--Red: 0.65, 0.054, 0.054
--Blue: 0.156, 0.188, 0.49
--Green: 0.06, 0.39, 0.17
require "StashDescriptions/StashUtil";

-- BBurgMap1 (survivor house, guns)
local stashMap = StashUtil.newStash("BBurgStashMap1", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");

stashMap.zombies = 5;
stashMap.barricades = 50;
stashMap.buildingX = 2174
stashMap.buildingY = 6011
stashMap.spawnTable = "GunCache1";
stashMap:addContainer("GunBox",nil,"Base.Bag_DuffelBagTINT",nil,nil,nil,nil);
stashMap:addStamp("Cross", nil, 2086, 6020, 0.65, 0.054, 0.054)
stashMap:addStamp("Circle", nil, 2174, 6012, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_BBurgMap1_Text1", 2121, 6019, 0.65, 0.054, 0.054)

-- BBurgMap2 (tools)
local stashMap = StashUtil.newStash("BBurgStashMap2", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.zombies = 2;
stashMap.buildingX = 1720
stashMap.buildingY = 5934
stashMap.spawnTable = "ToolsCache1";
stashMap:addStamp(nil, "Stash_BBurgMap2_Text1", 1799, 5944, 0.156, 0.188, 0.49)
stashMap:addStamp("Wrench", nil, 1725, 5938, 0.156, 0.188, 0.49)

-- BBurgMap3 (guns)
local stashMap = StashUtil.newStash("BBurgStashMap3", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 2132
stashMap.buildingY = 6344
stashMap.spawnTable = "GunCache2";
stashMap:addContainer("GunBox",nil,"Base.Bag_DuffelBagTINT",nil,2133,6350,0);
stashMap:addStamp("X", nil, 2138, 6348, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_BBurgMap3_Text1", 2117, 6356, 0.129,0.129,0.129)
stashMap:addStamp("Circle", nil, 2129, 6427, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_BBurgMap3_Text2", 2110, 6400, 0.65, 0.054, 0.054)

--BBurgMap4 (food)
local stashMap = StashUtil.newStash("BBurgStashMap4", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 2736
stashMap.buildingY = 6291
stashMap.spawnTable = "FoodCache1";
stashMap:addContainer("FoodBox", "furniture_storage_02_19", nil, nil, 2735, 6288, 0)
stashMap:addStamp("ArrowSouth", nil, 2735, 6283, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_BBurgMap4_Text1", 2705, 6292, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_BBurgMap4_Text2", 2692, 6337, 0.65, 0.054, 0.054)
stashMap.spawnOnlyOnZed = true
--BBurgMap5 (location info)
local stashMap = StashUtil.newStash("BBurgStashMap5", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 1936
stashMap.buildingY = 6583
stashMap:addStamp("FaceHappy", nil, 1936, 6583, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_BBurgMap5_Text2", 1927, 6586, 0.65, 0.054, 0.054)
stashMap:addStamp("ArrowNorth", nil, 2014, 6545, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_BBurgMap5_Text1", 1975, 6550, 0.65, 0.054, 0.054)

--BBurgMap6 (floorboard stash)
local stashMap = StashUtil.newStash("BBurgStashMap6", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 1675
stashMap.buildingY = 6109
stashMap:addStamp(nil, "Stash_BBurgMap6_Text1", 1504, 6016, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_BBurgMap6_Text2", 1504, 6040, 0.129,0.129,0.129)
stashMap:addStamp("Target", nil, 1674, 6108, 0.65, 0.054, 0.054)
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("ShotgunBox","floors_interior_tilesandwood_01_61",nil,"livingroom",nil,nil,nil);

--BBurgMap7 (survivor house)
local stashMap = StashUtil.newStash("BBurgStashMap7", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 2243
stashMap.buildingY = 5820
stashMap.spawnOnlyOnZed = true;
stashMap.spawnTable = "SurvivorCache2";
stashMap.barricades = 75;
stashMap.zombies = 2;
stashMap:addStamp(nil, "Stash_BBurgMap7_Text1", 2126, 5796, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_BBurgMap7_Text2", 2158, 5852, 0.156, 0.188, 0.49)
stashMap:addStamp("Skull", nil, 2243, 5820, 0, 0, 0)
stashMap.spawnOnlyOnZed = true
--BBurgMap8 (tools cache)
local stashMap = StashUtil.newStash("BBurgStashMap8", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 2774
stashMap.buildingY = 5907
stashMap:addStamp("House", nil, 2778, 5905, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_BBurgMap8_Text1", 2605, 5929, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_BBurgMap8_Text2", 2613, 5948, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_BBurgMap8_Text3", 2610, 5970, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_BBurgMap8_Text4", 2611, 5992, 0.06, 0.39, 0.17)
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("Toolbox",nil,"Base.Toolbox",nil,nil,nil,nil);
-- shotgun
--stashMap.spawnTable = "ShotgunCache1";
--stashMap:addContainer("ShotgunBox","floors_interior_tilesandwood_01_61",nil,"livingroom",nil,nil,nil);

-- tools
--stashMap.daysToSpawn = "0-30";
--stashMap.spawnOnlyOnZed = true;
--stashMap.zombies = 2;
--stashMap.spawnTable = "ToolsCache1";
--stashMap:addContainer("ToolsBox",nil,"Base.Bag_DuffelBagTINT",nil,nil,nil,nil);

-- food cache
--stashMap.spawnTable = "FoodCache1"
--stashMap:addContainer("FoodBox", "carpentry_01_16", nil, "kitchen", nil, nil, nil)

