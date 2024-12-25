--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************
-- Ink Colours
--Black: 0.129, 0.129, 0.129
--Red: 0.65, 0.054, 0.054
--Blue: 0.156, 0.188, 0.49
--Green: 0.06, 0.39, 0.17
require "StashDescriptions/StashUtil";

-- LVMap1 (gun cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap1", "Map", "Base.LouisvilleMap8", "Stash_AnnotedMap");
stashMap.buildingX = 12841
stashMap.buildingY = 3593
stashMap:addStamp("FaceDead", nil, 12810, 3530, 0.129, 0.129, 0.129)
stashMap:addStamp("ArrowWest", nil, 12824, 3529, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_LVMap1_Text1", 12834, 3523, 0.129, 0.129, 0.129)
stashMap:addStamp("Circle", nil, 12840, 3592, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_LVMap1_Text2", 12850, 3583, 0.129, 0.129, 0.129)
stashMap.spawnTable = "GunCache1"
stashMap:addContainer("GunBox", nil, "Base.Bag_DuffelBagTINT", nil, nil, nil, nil)

-- LVMap2 (general cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap2", "Map", "Base.LouisvilleMap7", "Stash_AnnotedMap")
stashMap.buildingX = 12643
stashMap.buildingY = 3226
stashMap:addStamp("X", nil, 12643, 3226, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap2_Text1", 12652, 3217, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap2_Text2", 12540, 3261, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap2_Text3", 12541, 3279, 0.65, 0.054, 0.054)
stashMap:addStamp("Cross", nil, 12607, 3366, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap2_Text4", 12553, 3327, 0.65, 0.054, 0.054)
stashMap.spawnTable = "SurvivorCache1";
stashMap:addContainer("SurvivorCrate", "carpentry_01_16", nil, nil, 12643, 3228, 0)

-- LVMap3 (tools)
local stashMap = StashUtil.newStash("LouisvilleStashMap3", "Map", "Base.LouisvilleMap8", "Stash_AnnotedMap");
--stashMap.buildingX = 13003
--stashMap.buildingY = 3246
stashMap:addStamp(nil, "Stash_LVMap3_Text1", 12954, 3181, 0.06, 0.39, 0.17)
stashMap:addStamp("ArrowSouth", nil, 13005, 3233, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_LVMap3_Text2", 13017, 3225, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_LVMap3_Text3", 12999, 3257, 0.06, 0.39, 0.17)
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox","carpentry_01_16",nil,nil,nil,nil,nil);
-- LVMap4 (general location info)
local stashMap = StashUtil.newStash("LouisvilleStashMap4", "Map", "Base.LouisvilleMap9", "Stash_AnnotedMap")
stashMap.buildingX = 13961
stashMap.buildingY = 3231
stashMap:addStamp("ArrowWest", nil, 13970, 3153, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap4_Text1", 13981, 3144, 0.156, 0.188, 0.49)
stashMap:addStamp("Burger", nil, 13960, 3212, 0.156, 0.188, 0.49)
stashMap:addStamp("Gun", nil, 13960, 3231, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap4_Text2", 13967, 3219, 0.156, 0.188, 0.49)
stashMap:addStamp("Apple", nil, 13961, 3246, 0.156, 0.188, 0.49)
stashMap:addStamp("Lightning", nil, 13958, 3263, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap4_Text4", 13976, 3255, 0.156, 0.188, 0.49)

-- LVMap5 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap5", "Map", "Base.LouisvilleMap4", "Stash_AnnotedMap")
stashMap.buildingX = 12148
stashMap.buildingY = 2450
stashMap:addStamp("ArrowSouthWest", nil, 12158, 2438, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap5_Text1", 12167, 2419, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap5_Text2", 12170, 2440, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap5_Text3", 12407, 2398, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 12474, 2390, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap5_Text4", 12403, 2419, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap5_Text5", 12235, 2510, 0.65, 0.054, 0.054)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1";

-- LVMap6 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap6", "Map", "Base.LouisvilleMap6", "Stash_AnnotedMap")
stashMap.buildingX = 13786
stashMap.buildingY = 2379
--stashMap:addStamp("Skull", nil, 13734, 2378, 0.129, 0.129, 0.129)
--stashMap:addStamp("Skull", nil, 13757, 2377, 0.129, 0.129, 0.129)
stashMap:addStamp("Heart", nil, 13785, 2376, 0.129, 0.129, 0.129)
stashMap:addStamp("Heart", nil, 13780, 2384, 0.129, 0.129, 0.129)
stashMap:addStamp("Heart", nil, 13792, 2386, 0.129, 0.129, 0.129)
--stashMap:addStamp("Skull", nil, 13787, 2411, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_LVMap6_Text1", 13717, 2347, 0.129, 0.129, 0.129)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1";
stashMap:addContainer("ShotgunBox","carpentry_01_16",nil,nil,nil,nil,nil);
-- LVMap7 (survivor house, only spawn on zed)
local stashMap = StashUtil.newStash("LouisvilleStashMap7", "Map", "Base.LouisvilleMap6", "Stash_AnnotedMap")
stashMap.buildingX = 14073
stashMap.buildingY = 2616
stashMap:addStamp("House", nil, 14069, 2613, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "", 14086, 2605, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap7_Text1", 14086, 2605, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap7_Text2", 14085, 2627, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap7_Text3", 14086, 2647, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap7_Text4", 14086, 2668, 0.65, 0.054, 0.054)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"
stashMap.spawnOnlyOnZed = true

-- LVMap8 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap8", "Map", "Base.LouisvilleMap5", "Stash_AnnotedMap")
stashMap.buildingX = 13323
stashMap.buildingY = 2121
stashMap:addStamp("ArrowSouthWest", nil, 13330, 2114, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap8_Text1", 13339, 2099, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap8_Text2", 13336, 2127, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13232, 2196, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13295, 2196, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13345, 2196, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap8_Text3", 13182, 2210, 0.65, 0.054, 0.054)
stashMap.spawnTable = "SurvivorCache1";
stashMap:addContainer("SurvivorCrate", "carpentry_01_16", nil, nil, 13323, 2119, 1)

-- LVMap9 (guns and food cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap9", "Map", "Base.LouisvilleMap5", "Stash_AnnotedMap")
stashMap.buildingX = 13034
stashMap.buildingY = 2839
stashMap:addStamp("Asterisk", nil, 13035, 2841, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap9_Text1", 13046, 2833, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap9_Text2", 13100, 2866, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap9_Text3", 13095, 2888, 0.65, 0.054, 0.054)
stashMap.spawnTable = "SurvivorCache1";
stashMap:addContainer("SurvivorCrate", "carpentry_01_16", nil, nil, 13035, 2837, 0)

-- LVMap10 (food cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap10", "Map", "Base.LouisvilleMap4", "Stash_AnnotedMap")
stashMap.buildingX = 12280
stashMap.buildingY = 2032
stashMap:addStamp("Target", nil, 12279, 2032, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap10_Text1", 12235, 2047, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap10_Text2", 12246, 2069, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 12321, 2079, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap10_Text3", 12226, 2100, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "", 12224, 2129, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap10_Text4", 12224, 2124, 0.65, 0.054, 0.054)
stashMap.spawnTable = "FoodCache1"
stashMap:addContainer("FoodBox", "carpentry_01_16", nil, "kitchen", nil, nil, nil)

-- LVMap11 (general location info)
local stashMap = StashUtil.newStash("LouisvilleStashMap11", "Map", "Base.LouisvilleMap5", "Stash_AnnotedMap")
stashMap.buildingX = 12702
stashMap.buildingY = 2004
stashMap:addStamp("ArrowEast", nil, 12907, 1920, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap11_Text1", 12817, 1909, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap11_Text2", 12821, 1927, 0.65, 0.054, 0.054)
stashMap:addStamp("X", nil, 12701, 2014, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap11_Text3", 12678, 2027, 0.65, 0.054, 0.054)
stashMap:addStamp("MedCross", nil, 12942, 2031, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap11_Text4", 12916, 2043, 0.65, 0.054, 0.054)

-- LVMap12 (general location info)
local stashMap = StashUtil.newStash("LouisvilleStashMap12", "Map", "Base.LouisvilleMap6", "Stash_AnnotedMap")
stashMap.buildingX = 13733
stashMap.buildingY = 1898
stashMap:addStamp("ArrowWest", nil, 13778, 1871, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap12_Text1", 13787, 1861, 0.65, 0.054, 0.054)
stashMap:addStamp("ArrowNorthEast", nil, 13725, 1907, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap12_Text2", 13701, 1917, 0.65, 0.054, 0.054)
stashMap:addStamp("Tent", nil, 13770, 2003, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap12_Text3", 13779, 1994, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap12_Text4", 13746, 2017, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap12_Text5", 13749, 2032, 0.65, 0.054, 0.054)

-- LVMap13 (car)
local stashMap = StashUtil.newStash("LouisvilleStashMap13", "Map", "Base.LouisvilleMap2", "Stash_AnnotedMap")
stashMap.buildingX = 13266
stashMap.buildingY = 1842
stashMap:addStamp("Circle", nil, 13237, 1745, 0.129, 0.129, 0.129)
stashMap:addStamp("Circle", nil, 13235, 1756, 0.129, 0.129, 0.129)
stashMap:addStamp("Circle", nil, 13236, 1768, 0.129, 0.129, 0.129)
stashMap:addStamp("Circle", nil, 13237, 1780, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_LVMap13_Text1", 13251, 1745, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_LVMap13_Text2", 13250, 1765, 0.129, 0.129, 0.129)
--stashMap:addStamp("Circle", nil, 13323, 1815, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_LVMap13_Text3", 13334, 1809, 0.129, 0.129, 0.129)
stashMap:addStamp("House", nil, 13265, 1841, 0.129, 0.129, 0.129)

-- LVMap14 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap14", "Map", "Base.LouisvilleMap1", "Stash_AnnotedMap")
stashMap.buildingX = 12191
stashMap.buildingY = 1775
stashMap:addStamp("House", nil, 12190, 1773, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap14_Text1", 12193, 1747, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap14_Text2", 12210, 1764, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap14_Text3", 12208, 1782, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap14_Text4", 12203, 1819, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap14_Text5", 12202, 1838, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap14_Text6", 12201, 1858, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_LVMap14_Text7", 12220, 1880, 0.156, 0.188, 0.49)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- LVMap15 (art gallery)
local stashMap = StashUtil.newStash("LouisvilleStashMap15", "Map", "Base.LouisvilleMap1", "Stash_AnnotedMap")
stashMap.buildingX = 12619
stashMap.buildingY = 1406
stashMap:addStamp(nil, "Stash_LVMap15_Text1", 12427, 1190, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap15_Text2", 12429, 1210, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap15_Text3", 12427, 1233, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap15_Text4", 12422, 1254, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap15_Text5", 12422, 1276, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap15_Text6", 12421, 1295, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap15_Text7", 12421, 1321, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap15_Text8", 12418, 1342, 0.65, 0.054, 0.054)
stashMap:addStamp("Target", nil, 12546, 1393, 0.65, 0.054, 0.054)
--stashMap:addStamp("Circle", nil, 12632, 1406, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap15_Text9", 12644, 1398, 0.65, 0.054, 0.054)

-- LVMap16 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap16", "Map", "Base.LouisvilleMap5", "Stash_AnnotedMap")
stashMap.buildingX = 13520
stashMap.buildingY = 2024
stashMap:addStamp(nil, "Stash_LVMap16_Text1", 13323, 1945, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap16_Text2", 13450, 1972, 0.129, 0.129, 0.129)
stashMap:addStamp("House", nil, 13519, 2024, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap16_Text3", 13532, 2015, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap16_Text4", 13529, 2032, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_LVMap16_Text5", 13531, 2051, 0.65, 0.054, 0.054)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

