require "StashDescriptions/StashUtil";

-- guns
local stashMap = StashUtil.newStash("MulStashMap1", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
--stashMap.daysToSpawn = "0-30";
--stashMap.zombies = 5
--stashMap.traps = "1-5";
--stashMap.barricades = 50;
stashMap.buildingX = 10660
stashMap.buildingY = 9758
stashMap.spawnTable = "GunCache1";
stashMap:addContainer("GunBox","floors_interior_tilesandwood_01_60",nil,"livingroom",nil,nil,nil);
stashMap:addStamp("X", nil, 10657, 9757, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap1_Text1", 10673, 9755, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap1_Text3", 10572, 9551, 0.156, 0.188, 0.49)

local stashMap = StashUtil.newStash("MulStashMap2", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 3
stashMap.buildingX = 10876
stashMap.buildingY = 10191
stashMap.spawnTable = "GunCache1";
stashMap:addContainer("GunBox",nil,"Base.Bag_DuffelBagTINT",nil,nil,nil,nil);
stashMap:addStamp("X", nil, 10877, 10191, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap2_Text1", 10837, 10199, 0.129, 0.129, 0.129)
--stashMap:addStamp("X", nil, 10631, 9379, 0.156, 0.188, 0.49)
--stashMap:addStamp("Circle", nil, 10686, 9826, 0.129, 0.129, 0.129)

local stashMap = StashUtil.newStash("MulStashMap11", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.buildingX = 10612
stashMap.buildingY = 9649
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("GunBox",nil,"Base.Bag_DuffelBagTINT",nil,nil,nil,nil);
stashMap:addStamp("X", nil, 10611, 9642, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap11_Text1", 10620, 9644, 0.129, 0.129, 0.129)
--stashMap:addStamp("Exclamation", nil, 10878, 10032, 0.156, 0.188, 0.49)
stashMap:addStamp("Circle", nil, 10686, 9826, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap11_Text3", 10695, 9820, 0.129, 0.129, 0.129)


-- shotgun
local stashMap = StashUtil.newStash("MulStashMap3", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10673
stashMap.buildingY = 10188
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("ShotgunBox","floors_interior_tilesandwood_01_62",nil,"hall",nil,nil,nil);
stashMap:addStamp("X", nil, 10674, 10186, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap3_Text1", 10683, 10177, 0.129, 0.129, 0.129)
stashMap:addStamp("Circle", nil, 10762, 10053, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap3_Text3", 10771, 10047, 0.129, 0.129, 0.129)

local stashMap = StashUtil.newStash("MulStashMap4", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10873
stashMap.buildingY = 10025
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("ShotgunBox","floors_interior_tilesandwood_01_62",nil,"livingroom",nil,nil,nil);
stashMap:addStamp("X", nil, 10760, 10085, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap4_Text1", 10768, 10075, 0.129, 0.129, 0.129)
stashMap:addStamp("Exclamation", nil, 10878, 10022, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_MulMap4_Text2", 10850, 10041, 0.156, 0.188, 0.49)
stashMap:addStamp("Skull", nil, 10665, 9941, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap4_Text3", 10680, 9933, 0.129, 0.129, 0.129)

local stashMap = StashUtil.newStash("MulStashMap12", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10619
stashMap.buildingY = 10529
stashMap.zombies = 2;
stashMap.barricades = 50;
stashMap.spawnTable = "ShotgunCache1";
stashMap:addContainer("ShotgunBox","carpentry_01_16",nil,nil,10619,10532,0);
stashMap:addStamp("X", nil, 10621, 10530, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap12_Text1", 10631, 10519, 0.129, 0.129, 0.129)
--stashMap:addStamp("Exclamation", nil, 10878, 10032, 0.156, 0.188, 0.49)
stashMap:addStamp("Skull", nil, 10729, 10453, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_MulMap12_Text3", 10737, 10445, 0.65, 0.054, 0.054)

-- tools
local stashMap = StashUtil.newStash("MulStashMap5", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10875
stashMap.buildingY = 10080
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox","carpentry_01_16",nil,"kitchen",nil,nil,nil);
stashMap:addStamp("Circle", nil, 10875, 10079, 0.129, 0.129, 0.129)

local stashMap = StashUtil.newStash("MulStashMap13", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10689
stashMap.buildingY = 10359
stashMap.spawnOnlyOnZed = true;
stashMap.barricades = 80;
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox","carpentry_01_16",nil,nil,10696,10371,0);
stashMap:addStamp("X", nil, 10685, 10362, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_MulMap13_Text1", 10695, 10354, 0.156, 0.188, 0.49)
stashMap:addStamp("Skull", nil, 10736, 10295, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_MulMap13_Text3", 10746, 10279, 0.65, 0.054, 0.054)


local stashMap = StashUtil.newStash("MulStashMap6", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10698
stashMap.buildingY = 9524
stashMap.spawnOnlyOnZed = true;
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox","carpentry_01_16",nil,nil,nil,nil,nil);
stashMap:addStamp("Circle", nil, 10698, 9523, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap6_Text1", 10657, 9539, 0.129, 0.129, 0.129)
--stashMap:addStamp("Exclamation", nil, 10878, 10032, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_MulMap6_Text2", 10820, 9650, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_MulMap6_Text21", 10822, 9665, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_MulMap6_Text3", 10702, 9630, 0.65, 0.054, 0.054)

-- survivor houses
local stashMap = StashUtil.newStash("MulStashMap7", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.barricades = 80;
stashMap.buildingX = 10882;
stashMap.buildingY = 9888;
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("House", nil, 10882, 9890, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap7_Text1", 10892, 9882, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap7_Text2", 10812, 9790, 0.129, 0.129, 0.129)
stashMap:addStamp("ArrowEast", nil, 10712, 9858, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_MulMap7_Text3", 10722, 9850, 0.65, 0.054, 0.054)

local stashMap = StashUtil.newStash("MulStashMap8", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 7;
stashMap.buildingX = 10854
stashMap.buildingY = 9927
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("House", nil, 10854, 9925, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap8_Text1", 10863, 9917, 0.129, 0.129, 0.129)
--stashMap:addStamp("Circle", nil, 10650, 9926, 0.129, 0.129, 0.129)
stashMap:addStamp("ArrowSouth", nil, 10738, 9880, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_MulMap8_Text3", 10673, 9857, 0.65, 0.054, 0.054)

-- danger houses
local stashMap = StashUtil.newStash("MulStashMap9", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 10;
stashMap.buildingX = 10686
stashMap.buildingY = 9909
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("Skull", nil, 10685, 9909, 0.129, 0.129, 0.129)

local stashMap = StashUtil.newStash("MulStashMap10", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.spawnOnlyOnZed = true;
stashMap.zombies = 10;
stashMap.buildingX = 10719
stashMap.buildingY = 9989
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("Skull", nil, 10718, 9989, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap10_Text1", 10733, 9971, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap10_Text3", 10747, 9854, 0.129, 0.129, 0.129)


-- survivor house
local stashMap = StashUtil.newStash("MulStashMap14", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 10667
stashMap.buildingY = 9577
stashMap:addStamp("X", nil, 10664, 9578, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap14_Text1", 10680, 9563, 0.129, 0.129, 0.129)
stashMap:addStamp("Skull", nil, 10593, 9657, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap14_Text2", 10606, 9650, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap14_Text3", 10606, 9675, 0.129, 0.129, 0.129)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- medical cache
local stashMap = StashUtil.newStash("MulStashMap15", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 10781
stashMap.buildingY = 9883
stashMap:addStamp("Pill", nil, 10781, 9880, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap15_Text1", 10790, 9870, 0.129, 0.129, 0.129)
stashMap:addStamp("Skull", nil, 10698, 9943, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap15_Text2", 10711, 9925, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap15_Text21", 10711, 9948, 0.129, 0.129, 0.129)
stashMap.spawnTable = "MedicalCache1"
stashMap:addContainer("MedicalBox", "floors_interior_tilesandwood_01_62", nil, "livingroom", nil, nil, nil)

-- gun cache
local stashMap = StashUtil.newStash("MulStashMap16", "Map", "Base.MuldraughMap", "Stash_AnnotedMap");
stashMap.buildingX = 10628
stashMap.buildingY = 9698
stashMap:addStamp("Gun", nil, 10628, 9697, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap16_Text1", 10637, 9687, 0.129, 0.129, 0.129)
stashMap:addStamp("KnifeFork", nil, 10611, 9644, 0.129, 0.129, 0.129)
stashMap:addStamp("Skull", nil, 10591, 9676, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_MulMap16_Text2", 10601, 9730, 0.65, 0.054, 0.054)
stashMap.spawnTable = "GunCache1"
stashMap:addContainer("GunBox", nil, "Base.Bag_DuffelBagTINT", nil, nil, nil, nil)

-- unlooted store
local stashMap = StashUtil.newStash("MulStashMap17", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 10608
stashMap.buildingY = 9615
stashMap:addStamp("X", nil, 10607, 9614, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_MulMap17_Text1", 10616, 9606, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_MulMap17_Text2", 10614, 9630, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_MulMap17_Text3", 10616, 9655, 0.156, 0.188, 0.49)

-- gun cache
local stashMap = StashUtil.newStash("MulStashMap18", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 10976
stashMap.buildingY = 9729
stashMap:addStamp(nil, "Stash_MulMap18_Text1", 10985, 9719, 0.06, 0.39, 0.17)
stashMap:addStamp("Target", nil, 10975, 9727, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_MulMap18_Text11", 10985, 9743, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_MulMap18_Text12", 10986, 9767, 0.06, 0.39, 0.17)
stashMap.spawnTable = "GunCache1"
stashMap:addContainer("GunBox", nil, "Base.Bag_DuffelBagTINT", nil, nil, nil, nil)

--lovely lake house (no changes)
local stashMap = StashUtil.newStash("MulStashMap19", "Map", "Base.MuldraughMap", "Stash_AnnotedMap")
stashMap.buildingX = 8
stashMap.buildingY = 0
stashMap:addStamp("Sun", nil, 10090, 8259, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_MulMap19_Text1", 10024, 8264, 0.65, 0.054, 0.054)

