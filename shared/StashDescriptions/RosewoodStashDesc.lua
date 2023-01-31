--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 22/02/2017
-- Time: 11:30
-- To change this template use File | Settings | File Templates.
--

require "StashDescriptions/StashUtil";

-- guns
local stashMap = StashUtil.newStash("RosewoodStashMap1", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
--stashMap.spawnOnlyOnZed = true;
--stashMap.daysToSpawn = "0-30";
stashMap.zombies = 5;
--stashMap.traps = "1-5";
--stashMap.barricades = 50;
stashMap.buildingX = 8238
stashMap.buildingY = 11555
stashMap.spawnTable = "GunCache1";
stashMap:addContainer("GunBox",nil,"Base.Bag_DuffelBagTINT",nil,nil,nil,nil);
stashMap:addStamp("Target", nil, 8237, 11554, 0, 0, 0)

-- shotgun
local stashMap = StashUtil.newStash("RosewoodStashMap2", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 8301
stashMap.buildingY = 11552
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("ShotgunBox","floors_interior_tilesandwood_01_61",nil,"livingroom",nil,nil,nil);
stashMap:addStamp("X", nil, 8301, 11552, 0, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap2_Text1", 8313, 11544, 0, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap2_Text2", 8332, 11603, 0, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap2_Text3", 8049, 11651, 1, 0, 0)

-- tools
local stashMap = StashUtil.newStash("RosewoodStashMap3", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.daysToSpawn = "0-30";
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 2;
stashMap.buildingX = 8419
stashMap.buildingY = 11581
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox",nil,"Base.Bag_DuffelBagTINT",nil,nil,nil,nil);
stashMap:addStamp("Circle", nil, 8419, 11581, 0, 0, 1)
stashMap:addStamp(nil, "Stash_RosewoodStashMap3_Text1", 8233, 11551, 0, 0, 1)
stashMap:addStamp(nil, "Stash_RosewoodStashMap3_Text11", 8394, 11589, 0, 0, 1)
stashMap:addStamp("X", nil, 8135, 11740, 0, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap3_Text2", 8145, 11732, 0, 0, 0)
stashMap:addStamp("ArrowSouth", nil, 8105, 11608, 1, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap3_Text3", 8073, 11575, 1, 0, 0)

-- food cache
local stashMap = StashUtil.newStash("RosewoodStashMap4", "Map", "Base.RosewoodMap", "Stash_AnnotedMap")
stashMap.buildingX = 7995
stashMap.buildingY = 11451
stashMap:addStamp(nil, "Stash_RosewoodStashMap4_Text1", 8005, 11441, 0, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap4_Text2", 7917, 11375, 0, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap4_Text3", 7916, 11400, 0, 0, 0)
stashMap:addStamp("ArrowNorth", nil, 7994, 11464, 0, 0, 0)
stashMap:addStamp("ArrowWest", nil, 7974, 11452, 0, 0, 0)
stashMap.spawnTable = "FoodCache1"
stashMap:addContainer("FoodBox", "carpentry_01_16", nil, "kitchen", nil, nil, nil)

-- unlooted restaurant
local stashMap = StashUtil.newStash("RosewoodStashMap5", "Map", "Base.RosewoodMap", "Stash_AnnotedMap")
stashMap.buildingX = 8076
stashMap.buildingY = 11312
stashMap:addStamp(nil, "Stash_RosewoodStashMap5_Text1", 8088, 11301, 0, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap5_Text2", 7940, 11338, 0, 0, 0)
stashMap:addStamp(nil, "Stash_RosewoodStashMap5_Text3", 7941, 11361, 0, 0, 0)
stashMap:addStamp("X", nil, 8077, 11311, 0, 0, 0)

