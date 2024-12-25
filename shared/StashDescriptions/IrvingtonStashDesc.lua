
--
--Black: 0.129,0.129,0.129
--Red: 0.65, 0.054, 0.054
--Blue: 0.156, 0.188, 0.49
--Green: 0.06, 0.39, 0.17
require "StashDescriptions/StashUtil";

-- IrvingtonMap1 (race track times)
local stashMap = StashUtil.newStash("IrvingtonStashMap1", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 929
stashMap.buildingY = 13035
stashMap:addStamp("ArrowSouth", nil, 929, 13035, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_IrvingtonMap1_Text1", 972, 13025, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_IrvingtonMap1_Text2", 971, 13051, 0.65, 0.054, 0.054)

-- IrvingtonMap2 (survivor house)
local stashMap = StashUtil.newStash("IrvingtonStashMap2", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");

stashMap.buildingX = 2899
stashMap.buildingY = 14567
stashMap.spawnTable = "SurvivorCache1";
stashMap.barricades = 75;
stashMap.zombies = 1;
stashMap:addStamp("Circle", nil, 2900, 14569, 0.156, 0.188, 0.49)
stashMap:addStamp("Skull", nil, 2900, 14556, 0.156, 0.188, 0.49)
stashMap:addStamp("Skull", nil, 2886, 14567, 0.156, 0.188, 0.49)
stashMap:addStamp("Skull", nil, 2915, 14568, 0.156, 0.188, 0.49)
stashMap:addStamp("Skull", nil, 2898, 14583, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_IrvingtonMap2_Text1", 2826, 14586, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_IrvingtonMap2_Text2", 2827, 14608, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_IrvingtonMap2_Text3", 2829, 14634, 0.156, 0.188, 0.49)
stashMap.spawnOnlyOnZed = true

-- IrvingtonMap3 (food)
local stashMap = StashUtil.newStash("IrvingtonStashMap3", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 2233
stashMap.buildingY = 14271
stashMap.spawnTable = "SurvivorCache2";
stashMap.barricades = 75;
stashMap.zombies = 1;
stashMap:addStamp("House", nil, 2232, 14270, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_IrvingtonMap3_Text1", 2089, 14290, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_IrvingtonMap3_Text2", 2103, 14310, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_IrvingtonMap3_Text3", 2236, 14344, 0.65, 0.054, 0.054)


--IrvingtonMap4 (barricaded house)
local stashMap = StashUtil.newStash("IrvingtonStashMap4", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 1778
stashMap.buildingY = 14717
stashMap.spawnTable = "GunCache2";
stashMap.barricades = 25;
stashMap.zombies = 1;
stashMap:addStamp("Circle", nil, 1779, 14710, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_IrvingtonMap4_Text1", 1630, 14684, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_IrvingtonMap4_Text2", 1630, 14703, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_IrvingtonMap4_Text3", 1629, 14722, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_IrvingtonMap4_Text4", 1630, 14740, 0.129,0.129,0.129)


--IrvingtonMap5 (food)
local stashMap = StashUtil.newStash("IrvingtonStashMap5", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.barricades = 25;
stashMap.zombies = 1;
stashMap.buildingX = 2224
stashMap.buildingY = 14028
stashMap.spawnTable = "FoodCache1";
stashMap:addContainer("FoodBox", "furniture_storage_02_19", nil, nil, 2225, 14036, 0)
stashMap:addStamp("Star", nil, 2227, 14029, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_IrvingtonMap5_Text1", 2241, 13998, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_IrvingtonMap5_Text2", 2239, 14019, 0.156, 0.188, 0.49)

--IrvingtonMap6 (tools)
local stashMap = StashUtil.newStash("IrvingtonStashMap6", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 2722
stashMap.buildingY = 13962
stashMap.barricades = 25;
stashMap.spawnTable = "ToolsCache1";
stashMap:addStamp("Question", nil, 2722, 13958, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_IrvingtonMap6_Text1", 2679, 13963, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_IrvingtonMap6_Text2", 2655, 13980, 0.129,0.129,0.129)

--IrvingtonMap7 (survivor house)
local stashMap = StashUtil.newStash("IrvingtonStashMap7", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.barricades = 75;
stashMap.zombies = 3;
stashMap.spawnTable = "SurvivorCache2";
stashMap.buildingX = 2549
stashMap.buildingY = 14366
stashMap:addStamp("Asterisk", nil, 2549, 14364, 0.06, 0.39, 0.17)


--IrvingtonMap8 (location info)
local stashMap = StashUtil.newStash("IrvingtonStashMap8", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 2469
stashMap.buildingY = 14462
stashMap:addStamp("Apple", nil, 2469, 14462, 0.65, 0.054, 0.054)
stashMap:addStamp("Pill", nil, 2474, 14470, 0.65, 0.054, 0.054)
stashMap:addStamp("Apple", nil, 2486, 14462, 0.65, 0.054, 0.054)
stashMap:addStamp("ArrowNorthEast", nil, 2451, 14478, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_IrvingtonMap8_Text1", 2416, 14482, 0.65, 0.054, 0.054)
stashMap:addStamp("ArrowWest", nil, 2429, 14532, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_IrvingtonMap8_Text2", 2438, 14522, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_IrvingtonMap8_Text3", 2416, 14567, 0.65, 0.054, 0.054)

--IrvingtonMap9 (location info, two storey house)
local stashMap = StashUtil.newStash("IrvingtonStashMap9", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 6
stashMap.buildingY = 0
stashMap:addStamp("ArrowSouth", nil, 4012, 13637, 0, 0, 0)
stashMap:addStamp(nil, "Stash_IrvingtonMap9_Text1", 3897, 13583, 0, 0, 0)
stashMap:addStamp(nil, "Stash_IrvingtonMap9_Text2", 3916, 13605, 0, 0, 0)
stashMap:addStamp("Heart", nil, 3976, 13677, 0, 0, 0)
stashMap:addStamp("Heart", nil, 3990, 13677, 0, 0, 0)
stashMap:addStamp("Heart", nil, 4004, 13676, 0, 0, 0)
stashMap:addStamp("Heart", nil, 4021, 13678, 0, 0, 0)
stashMap:addStamp("Heart", nil, 4037, 13677, 0, 0, 0)

--IrvingtonMap10 (house)
local stashMap = StashUtil.newStash("IrvingtonStashMap10", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 7
stashMap.buildingY = 0
stashMap:addStamp(nil, "Stash_IrvingtonMap10_Text1", 1254, 13431, 0, 0, 0)
stashMap:addStamp("ArrowEast", nil, 1368, 13445, 0, 0, 0)
stashMap:addStamp("Target", nil, 1323, 13790, 0, 0, 0)
stashMap:addStamp(nil, "Stash_IrvingtonMap10_Text2", 1263, 13796, 0, 0, 0)

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

