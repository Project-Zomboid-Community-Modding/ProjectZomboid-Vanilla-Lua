--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 07/02/2017
-- Time: 14:57
-- To change this template use File | Settings | File Templates.
--

require "StashDescriptions/StashUtil";

-- guns
local stashMap = StashUtil.newStash("MulStashMap1", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
--stashMap.daysToSpawn = "0-30";
--stashMap.zombies = 5
--stashMap.traps = "1-5";
--stashMap.barricades = 50;
stashMap.buildingX = 10663
stashMap.buildingY = 9764
stashMap.spawnTable = "GunCache1";
stashMap:addContainer("GunBox","floors_interior_tilesandwood_01_57",nil,"closet",nil,nil,nil);
stashMap:addStamp("X", nil, 10663, 9763, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap1_Text1", 10673, 9755, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap1_Text2", 10630, 9299, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap1_Text3", 10572, 9551, 0, 0, 1)

local stashMap = StashUtil.newStash("MulStashMap2", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 3
stashMap.buildingX = 10876
stashMap.buildingY = 10191
stashMap.spawnTable = "GunCache1";
stashMap:addContainer("GunBox",nil,"Base.Bag_DuffelBagTINT",nil,nil,nil,nil);
stashMap:addStamp("X", nil, 10877, 10191, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap2_Text1", 10837, 10199, 0, 0, 0)
stashMap:addStamp("X", nil, 10631, 9379, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap2_Text2", 10640, 9373, 0, 0, 1)
stashMap:addStamp("Circle", nil, 10686, 9826, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap2_Text3", 10695, 9820, 0, 0, 0)

local stashMap = StashUtil.newStash("MulStashMap11", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.buildingX = 10622
stashMap.buildingY = 9654
stashMap.spawnTable = "GunCache1";
stashMap:addContainer("GunBox",nil,"Base.Bag_DuffelBagTINT",nil,nil,nil,nil);
stashMap:addStamp("X", nil, 10625, 9652, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap11_Text1", 10632, 9644, 0, 0, 0)
stashMap:addStamp("Exclamation", nil, 10878, 10032, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap11_Text2", 10850, 10041, 0, 0, 1)
stashMap:addStamp("Circle", nil, 10686, 9826, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap11_Text3", 10695, 9820, 0, 0, 0)

-- shotgun
local stashMap = StashUtil.newStash("MulStashMap3", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10673
stashMap.buildingY = 10188
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("ShotgunBox","floors_interior_tilesandwood_01_62",nil,"hall",nil,nil,nil);
stashMap:addStamp("X", nil, 10674, 10186, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap3_Text1", 10683, 10177, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap3_Text2", 10581, 9287, 0, 0, 1)
stashMap:addStamp("Circle", nil, 10762, 10053, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap3_Text3", 10771, 10047, 0, 0, 0)

local stashMap = StashUtil.newStash("MulStashMap4", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10760
stashMap.buildingY = 10083
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("ShotgunBox","floors_interior_tilesandwood_01_62",nil,"bedroom",nil,nil,nil);
stashMap:addStamp("X", nil, 10760, 10085, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap4_Text1", 10768, 10075, 0, 0, 0)
stashMap:addStamp("Exclamation", nil, 10878, 10032, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap4_Text2", 10850, 10041, 0, 0, 1)
stashMap:addStamp("Skull", nil, 10665, 9941, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap4_Text3", 10680, 9933, 0, 0, 0)

local stashMap = StashUtil.newStash("MulStashMap12", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10619
stashMap.buildingY = 10529
stashMap.zombies = 2;
stashMap.barricades = 50;
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("ShotgunBox","carpentry_01_16",nil,nil,nil,nil,nil);
stashMap:addStamp("X", nil, 10621, 10530, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap12_Text1", 10631, 10519, 0, 0, 0)
stashMap:addStamp("Exclamation", nil, 10878, 10032, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap12_Text2", 10850, 10041, 0, 0, 1)
stashMap:addStamp("Skull", nil, 10729, 10453, 1, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap12_Text3", 10737, 10445, 1, 0, 0)

-- tools
local stashMap = StashUtil.newStash("MulStashMap5", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10875
stashMap.buildingY = 10080
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox","carpentry_01_16",nil,"kitchen",nil,nil,nil);
stashMap:addStamp("Circle", nil, 10875, 10079, 0, 0, 0)

local stashMap = StashUtil.newStash("MulStashMap13", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10689
stashMap.buildingY = 10359
stashMap.spawnOnlyOnZed = true;
stashMap.barricades = 80;
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox","carpentry_01_16",nil,nil,nil,nil,nil);
stashMap:addStamp("X", nil, 10685, 10362, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap13_Text1", 10695, 10354, 0, 0, 1)
stashMap:addStamp("Exclamation", nil, 10699, 10454, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap13_Text2", 10663, 10466, 0, 0, 1)
stashMap:addStamp("Skull", nil, 10729, 10286, 1, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap13_Text3", 10737, 10278, 1, 0, 0)

local stashMap = StashUtil.newStash("MulStashMap6", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10698
stashMap.buildingY = 9524
stashMap.spawnOnlyOnZed = true;
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox","carpentry_01_16",nil,nil,nil,nil,nil);
stashMap:addStamp("Circle", nil, 10698, 9523, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap6_Text1", 10657, 9539, 0, 0, 0)
stashMap:addStamp("Exclamation", nil, 10878, 10032, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap6_Text2", 10850, 10041, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap6_Text21", 10837, 10056, 0, 0, 1)
stashMap:addStamp(nil, "Stash_MulMap6_Text3", 10813, 9970, 1, 0, 0)

-- survivor houses
local stashMap = StashUtil.newStash("MulStashMap7", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.barricades = 80;
stashMap.buildingX = 10882;
stashMap.buildingY = 9888;
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("House", nil, 10882, 9890, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap7_Text1", 10892, 9882, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap7_Text2", 10812, 9790, 0, 0, 0)
stashMap:addStamp("ArrowEast", nil, 10761, 10055, 1, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap7_Text3", 10771, 10047, 1, 0, 0)

local stashMap = StashUtil.newStash("MulStashMap8", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 7;
stashMap.buildingX = 10854
stashMap.buildingY = 9927
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("House", nil, 10854, 9925, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap8_Text1", 10863, 9917, 0, 0, 0)
stashMap:addStamp("Circle", nil, 10650, 9926, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap8_Text2", 10590, 9934, 0, 0, 0)
stashMap:addStamp("ArrowSouth", nil, 10590, 9758, 1, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap8_Text3", 10537, 9721, 1, 0, 0)

-- danger houses
local stashMap = StashUtil.newStash("MulStashMap9", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 10;
stashMap.buildingX = 10686
stashMap.buildingY = 9909
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("Skull", nil, 10685, 9909, 0, 0, 0)

local stashMap = StashUtil.newStash("MulStashMap10", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 10;
stashMap.buildingX = 10725
stashMap.buildingY = 9984
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("Skull", nil, 10724, 9983, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap10_Text1", 10733, 9971, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap10_Text2", 10601, 9643, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap10_Text3", 10747, 9854, 0, 0, 0)

-- survivor house
local stashMap = StashUtil.newStash("MulStashMap14", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 10670
stashMap.buildingY = 9573
stashMap:addStamp("X", nil, 10670, 9573, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap14_Text1", 10680, 9563, 0, 0, 0)
stashMap:addStamp("Skull", nil, 10593, 9737, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap14_Text2", 10606, 9716, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap14_Text3", 10606, 9741, 0, 0, 0)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- medical cache
local stashMap = StashUtil.newStash("MulStashMap15", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 10781
stashMap.buildingY = 9881
stashMap:addStamp("Pill", nil, 10781, 9880, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap15_Text1", 10790, 9870, 0, 0, 0)
stashMap:addStamp("Skull", nil, 10698, 9943, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap15_Text2", 10711, 9925, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap15_Text21", 10711, 9948, 0, 0, 0)
stashMap.spawnTable = "MedicalCache1"
stashMap:addContainer("MedicalBox", "floors_interior_tilesandwood_01_62", nil, "livingroom", nil, nil, nil)

-- gun cache
local stashMap = StashUtil.newStash("MulStashMap16", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10628
stashMap.buildingY = 9698
stashMap:addStamp("Gun", nil, 10628, 9697, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap16_Text1", 10637, 9687, 0, 0, 0)
stashMap:addStamp("KnifeFork", nil, 10625, 9654, 0, 0, 0)
stashMap:addStamp("Skull", nil, 10591, 9676, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap16_Text2", 10601, 9667, 0, 0, 0)
stashMap.spawnTable = "GunCache1"
stashMap:addContainer("GunBox", nil, "Base.Bag_DuffelBagTINT", nil, nil, nil, nil)

-- unlooted store
local stashMap = StashUtil.newStash("MulStashMap17", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 10608
stashMap.buildingY = 9615
stashMap:addStamp("X", nil, 10607, 9614, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap17_Text1", 10616, 9606, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap17_Text2", 10614, 9630, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap17_Text3", 10616, 9655, 0, 0, 0)

-- gun cache
local stashMap = StashUtil.newStash("MulStashMap18", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 10976
stashMap.buildingY = 9729
stashMap:addStamp(nil, "Stash_MulMap18_Text1", 10985, 9719, 0, 0, 0)
stashMap:addStamp("Target", nil, 10975, 9727, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap18_Text11", 10985, 9743, 0, 0, 0)
stashMap:addStamp(nil, "Stash_MulMap18_Text12", 10986, 9767, 0, 0, 0)
stashMap.spawnTable = "GunCache1"
stashMap:addContainer("GunBox", nil, "Base.Bag_DuffelBagTINT", nil, nil, nil, nil)

