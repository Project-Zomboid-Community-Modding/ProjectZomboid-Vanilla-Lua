
--
--Black: 0.129,0.129,0.129
--Red: 0.65, 0.054, 0.054
--Blue: 0.156, 0.188, 0.49
--Green: 0.06, 0.39, 0.17
require "StashDescriptions/StashUtil";

-- EkronMap1 (medical cache)
local stashMap = StashUtil.newStash("EkronStashMap1", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 493
stashMap.buildingY = 9319
stashMap.zombies = 2;
stashMap:addStamp(nil, "Stash_EkronStashMap1_Text1", 475, 9420, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_EkronStashMap1_Text2", 480, 9439, 0.156, 0.188, 0.49)
stashMap:addStamp("MedCross", nil, 492, 9319, 0.156, 0.188, 0.49)
stashMap:addStamp("ArrowEast", nil, 549, 9430, 0.156, 0.188, 0.49)
stashMap.spawnTable = "MedicalCache1"
stashMap:addContainer("MedicalBox", "location_community_medical_01_89", nil, nil, 487, 9313, 0)

-- EkronMap2 (ammo boxes)
local stashMap = StashUtil.newStash("EkronStashMap2", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 387
stashMap.buildingY = 9625
stashMap.barricades = 40;
stashMap.spawnTable = "GunCache2";
stashMap:addContainer("GunBox", nil, "Base.Bag_AmmoBox_Mixed", "kitchen", nil,nil,nil)
stashMap.spawnTable = "GunCache2";
stashMap:addContainer("GunBox", nil, "Base.Bag_AmmoBox_Mixed", "kitchen", nil,nil,nil)
stashMap.spawnTable = "GunCache2";
stashMap:addContainer("GunBox", nil, "Base.Bag_AmmoBox_Mixed", "kitchen", nil,nil,nil)
stashMap.spawnTable = "GunCache2";
stashMap:addContainer("GunBox", nil, "Base.Bag_AmmoBox_Mixed", "kitchen", nil,nil,nil)
stashMap:addStamp(nil, "Stash_EkronMap2_Text1", 392, 9638, 0.156, 0.188, 0.49)
stashMap:addStamp("ArrowNorth", nil, 404, 9638, 0.156, 0.188, 0.49)
stashMap:addStamp("Gun", nil, 387, 9626, 0.156, 0.188, 0.49)
stashMap:addStamp("Wrench", nil, 388, 9606, 0.156, 0.188, 0.49)

-- EkronMap3 (gun)
local stashMap = StashUtil.newStash("EkronStashMap3", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 790
stashMap.buildingY = 9540
stashMap.barricades = 40;

stashMap.spawnTable = "GunCache2";
stashMap:addContainer("GunBox", nil, "Base.Bag_DuffelBagTINT", "derelict", nil,nil,nil)

stashMap:addStamp("X", nil, 792, 9541, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_EkronMap3_Text1", 762, 9547, 0.129,0.129,0.129)

-- EkronMap4 (survivor house)
local stashMap = StashUtil.newStash("EkronStashMap4", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 415
stashMap.buildingY = 9823
stashMap.barricades = 60;
stashMap.zombies = 2;
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("ArrowNorth", nil, 416, 9836, 0.65, 0.054, 0.054)
stashMap:addStamp("Pill", nil, 406, 9863, 0.129,0.129,0.129)
stashMap:addStamp("Apple", nil, 419, 9862, 0.129,0.129,0.129)
stashMap:addStamp("Gun", nil, 434, 9862, 0.129,0.129,0.129)

-- EkronMap5 (medical)
local stashMap = StashUtil.newStash("EkronStashMap5", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 684
stashMap.buildingY = 9830
stashMap.spawnTable = "MedicalCache1";
stashMap:addContainer("MedicalBox", nil, "Base.Bag_MedicalBag", "bathroom", nil,nil,nil)
stashMap:addStamp(nil, "Stash_EkronMap5_Text1", 752, 9823, 0.129,0.129,0.129)
stashMap:addStamp("ArrowNorthEast", nil, 672, 9837, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_EkronMap5_Text2", 658, 9840, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_EkronMap5_Text3", 627, 9871, 0.65, 0.054, 0.054)

-- EkronMap6 (rude message)
local stashMap = StashUtil.newStash("EkronStashMap6", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 1
stashMap.buildingY = 0
stashMap:addStamp(nil, "Stash_EkronMap6_Text1", 314, 9710, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_EkronMap6_Text2", 318, 9731, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_EkronMap6_Text3", 313, 9751, 0.65, 0.054, 0.054)

-- EkronMap7 (location info)
local stashMap = StashUtil.newStash("EkronStashMap7", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 2
stashMap.buildingY = 0
stashMap:addStamp("ArrowSouthEast", nil, 192, 9481, 0, 0, 0)
stashMap:addStamp(nil, "Stash_EkronMap7_Text1", 153, 9447, 0, 0, 0)
stashMap:addStamp("Egg", nil, 39, 9423, 0, 0, 0)

-- EkronMap8 (location info)
local stashMap = StashUtil.newStash("EkronStashMap8", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 3
stashMap.buildingY = 0
stashMap:addStamp("ArrowSouthWest", nil, 1757, 8362, 0, 0, 0)
stashMap:addStamp(nil, "Stash_EkronMap8_Text1", 1775, 8350, 0, 0, 0)
stashMap:addStamp("X", nil, 1982, 8596, 0, 0, 0)
stashMap:addStamp(nil, "Stash_EkronMap8_Text2", 1927, 8616, 0, 0, 0)


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

