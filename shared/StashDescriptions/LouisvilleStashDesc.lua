--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "StashDescriptions/StashUtil";

-- LVMap1 (gun cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap1", "Map", "Base.LouisvilleMap8", "Stash_AnnotedMap");
stashMap.buildingX = 12841
stashMap.buildingY = 3593
stashMap:addStamp("FaceDead", nil, 12810, 3530, 1, 0, 0)
stashMap:addStamp("ArrowWest", nil, 12824, 3529, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap1_Text1", 12834, 3523, 1, 0, 0)
stashMap:addStamp("Circle", nil, 12840, 3592, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap1_Text2", 12850, 3583, 1, 0, 0)
stashMap.spawnTable = "GunCache1"
stashMap:addContainer("GunBox", nil, "Base.Bag_DuffelBagTINT", nil, nil, nil, nil)

-- LVMap2 (general cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap2", "Map", "Base.LouisvilleMap7", "Stash_AnnotedMap")
stashMap.buildingX = 12643
stashMap.buildingY = 3226
stashMap:addStamp("X", nil, 12643, 3226, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap2_Text1", 12652, 3217, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap2_Text2", 12540, 3261, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap2_Text3", 12541, 3279, 1, 0, 0)
stashMap:addStamp("Cross", nil, 12607, 3366, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap2_Text4", 12553, 3327, 1, 0, 0)
stashMap.spawnTable = "SurvivorCache1";

-- LVMap3 (pick up truck)
local stashMap = StashUtil.newStash("LouisvilleStashMap3", "Map", "Base.LouisvilleMap8", "Stash_AnnotedMap");
stashMap:addStamp(nil, "Stash_LVMap3_Text1", 12954, 3181, 1, 0, 0)
stashMap:addStamp("ArrowSouth", nil, 13005, 3233, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap3_Text2", 13017, 3225, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap3_Text3", 12999, 3257, 1, 0, 0)

-- LVMap4 (general location info)
local stashMap = StashUtil.newStash("LouisvilleStashMap4", "Map", "Base.LouisvilleMap9", "Stash_AnnotedMap")
stashMap.buildingX = 13961
stashMap.buildingY = 3231
stashMap:addStamp("ArrowWest", nil, 13970, 3153, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap4_Text1", 13981, 3144, 1, 0, 0)
stashMap:addStamp("Burger", nil, 13960, 3212, 1, 0, 0)
stashMap:addStamp("Gun", nil, 13960, 3231, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap4_Text2", 13967, 3219, 1, 0, 0)
stashMap:addStamp("Apple", nil, 13961, 3246, 1, 0, 0)
stashMap:addStamp("Lightning", nil, 13958, 3263, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap4_Text4", 13976, 3255, 1, 0, 0)

-- LVMap5 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap5", "Map", "Base.LouisvilleMap4", "Stash_AnnotedMap")
stashMap.buildingX = 12148
stashMap.buildingY = 2450
stashMap:addStamp("ArrowSouthWest", nil, 12158, 2438, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap5_Text1", 12167, 2419, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap5_Text2", 12170, 2440, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap5_Text3", 12407, 2398, 1, 0, 0)
stashMap:addStamp("Skull", nil, 12474, 2390, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap5_Text4", 12403, 2419, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap5_Text5", 12235, 2510, 1, 0, 0)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1";

-- LVMap6 (overrun houses and survivor house)
-- FIXME: 3 houses are marked as infested
local stashMap = StashUtil.newStash("LouisvilleStashMap6", "Map", "Base.LouisvilleMap6", "Stash_AnnotedMap")
stashMap.buildingX = 13786
stashMap.buildingY = 2379
stashMap:addStamp("Skull", nil, 13734, 2378, 1, 0, 0)
stashMap:addStamp("Skull", nil, 13757, 2377, 1, 0, 0)
stashMap:addStamp("Heart", nil, 13785, 2376, 1, 0, 0)
stashMap:addStamp("Heart", nil, 13780, 2384, 1, 0, 0)
stashMap:addStamp("Heart", nil, 13792, 2386, 1, 0, 0)
stashMap:addStamp("Skull", nil, 13787, 2411, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap6_Text1", 13717, 2347, 1, 0, 0)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1";

-- LVMap7 (survivor house, only spawn on zed)
local stashMap = StashUtil.newStash("LouisvilleStashMap7", "Map", "Base.LouisvilleMap6", "Stash_AnnotedMap")
stashMap.buildingX = 14073
stashMap.buildingY = 2616
stashMap:addStamp("House", nil, 14069, 2613, 1, 0, 0)
stashMap:addStamp(nil, "", 14086, 2605, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap7_Text1", 14086, 2605, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap7_Text2", 14085, 2627, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap7_Text3", 14086, 2647, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap7_Text4", 14086, 2668, 1, 0, 0)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"
stashMap.spawnOnlyOnZed = true

-- LVMap8 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap8", "Map", "Base.LouisvilleMap5", "Stash_AnnotedMap")
stashMap.buildingX = 13323
stashMap.buildingY = 2121
stashMap:addStamp("ArrowSouthWest", nil, 13330, 2114, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap8_Text1", 13339, 2099, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap8_Text2", 13336, 2127, 1, 0, 0)
stashMap:addStamp("Skull", nil, 13232, 2196, 1, 0, 0)
stashMap:addStamp("Skull", nil, 13295, 2196, 1, 0, 0)
stashMap:addStamp("Skull", nil, 13345, 2196, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap8_Text3", 13182, 2210, 1, 0, 0)
stashMap.spawnTable = "SurvivorCache1";
stashMap:addContainer("SurvivorCrate", "carpentry_01_16", nil, nil, 13323, 2119, 1)

-- LVMap9 (guns and food cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap9", "Map", "Base.LouisvilleMap5", "Stash_AnnotedMap")
stashMap.buildingX = 13034
stashMap.buildingY = 2839
stashMap:addStamp("Asterisk", nil, 13035, 2841, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap9_Text1", 13046, 2833, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap9_Text2", 13100, 2866, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap9_Text3", 13095, 2888, 1, 0, 0)
stashMap.spawnTable = "SurvivorCache1";
stashMap:addContainer("SurvivorCrate", "carpentry_01_16", nil, nil, 13035, 2837, 0)

-- LVMap10 (food cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap10", "Map", "Base.LouisvilleMap4", "Stash_AnnotedMap")
stashMap.buildingX = 12280
stashMap.buildingY = 2032
stashMap:addStamp("Target", nil, 12279, 2032, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap10_Text1", 12235, 2047, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap10_Text2", 12246, 2069, 1, 0, 0)
stashMap:addStamp("Skull", nil, 12321, 2079, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap10_Text3", 12226, 2100, 1, 0, 0)
stashMap:addStamp(nil, "", 12224, 2129, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap10_Text4", 12224, 2124, 1, 0, 0)
stashMap.spawnTable = "FoodCache1"
stashMap:addContainer("FoodBox", "carpentry_01_16", nil, "kitchen", nil, nil, nil)

-- LVMap11 (general location info)
local stashMap = StashUtil.newStash("LouisvilleStashMap11", "Map", "Base.LouisvilleMap5", "Stash_AnnotedMap")
stashMap.buildingX = 12702
stashMap.buildingY = 2004
stashMap:addStamp("ArrowEast", nil, 12907, 1920, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap11_Text1", 12817, 1909, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap11_Text2", 12821, 1927, 1, 0, 0)
stashMap:addStamp("X", nil, 12701, 2014, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap11_Text3", 12678, 2027, 1, 0, 0)
stashMap:addStamp("MedCross", nil, 12942, 2031, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap11_Text4", 12916, 2043, 1, 0, 0)

-- LVMap12 (general location info)
local stashMap = StashUtil.newStash("LouisvilleStashMap12", "Map", "Base.LouisvilleMap6", "Stash_AnnotedMap")
stashMap.buildingX = 13733
stashMap.buildingY = 1898
stashMap:addStamp("ArrowWest", nil, 13778, 1871, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap12_Text1", 13787, 1861, 1, 0, 0)
stashMap:addStamp("ArrowNorthEast", nil, 13725, 1907, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap12_Text2", 13701, 1917, 1, 0, 0)
stashMap:addStamp("Tent", nil, 13770, 2003, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap12_Text3", 13779, 1994, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap12_Text4", 13746, 2017, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap12_Text5", 13749, 2032, 1, 0, 0)

-- LVMap13 (car)
local stashMap = StashUtil.newStash("LouisvilleStashMap13", "Map", "Base.LouisvilleMap2", "Stash_AnnotedMap")
stashMap.buildingX = 13266
stashMap.buildingY = 1842
stashMap:addStamp("Circle", nil, 13237, 1745, 1, 0, 0)
stashMap:addStamp("Circle", nil, 13235, 1756, 1, 0, 0)
stashMap:addStamp("Circle", nil, 13236, 1768, 1, 0, 0)
stashMap:addStamp("Circle", nil, 13237, 1780, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap13_Text1", 13251, 1745, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap13_Text2", 13250, 1765, 1, 0, 0)
stashMap:addStamp("Circle", nil, 13323, 1815, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap13_Text3", 13334, 1809, 1, 0, 0)
stashMap:addStamp("House", nil, 13265, 1841, 1, 0, 0)

-- LVMap14 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap14", "Map", "Base.LouisvilleMap1", "Stash_AnnotedMap")
stashMap.buildingX = 12191
stashMap.buildingY = 1775
stashMap:addStamp("House", nil, 12190, 1773, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap14_Text1", 12193, 1747, 0, 0, 1)
stashMap:addStamp(nil, "Stash_LVMap14_Text2", 12210, 1764, 0, 0, 1)
stashMap:addStamp(nil, "Stash_LVMap14_Text3", 12208, 1782, 0, 0, 1)
stashMap:addStamp(nil, "Stash_LVMap14_Text4", 12203, 1819, 0, 0, 1)
stashMap:addStamp(nil, "Stash_LVMap14_Text5", 12202, 1838, 0, 0, 1)
stashMap:addStamp(nil, "Stash_LVMap14_Text6", 12201, 1858, 0, 0, 1)
stashMap:addStamp(nil, "Stash_LVMap14_Text7", 12220, 1880, 0, 0, 1)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- LVMap15 (car with gun cache)
local stashMap = StashUtil.newStash("LouisvilleStashMap15", "Map", "Base.LouisvilleMap1", "Stash_AnnotedMap")
stashMap.buildingX = 12619
stashMap.buildingY = 1406
stashMap:addStamp(nil, "Stash_LVMap15_Text1", 12427, 1190, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap15_Text2", 12429, 1210, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap15_Text3", 12427, 1233, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap15_Text4", 12422, 1254, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap15_Text5", 12422, 1276, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap15_Text6", 12421, 1295, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap15_Text7", 12421, 1321, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap15_Text8", 12418, 1342, 1, 0, 0)
stashMap:addStamp("Target", nil, 12546, 1393, 1, 0, 0)
stashMap:addStamp("Circle", nil, 12632, 1406, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap15_Text9", 12644, 1398, 1, 0, 0)

-- LVMap16 (survivor house)
local stashMap = StashUtil.newStash("LouisvilleStashMap16", "Map", "Base.LouisvilleMap5", "Stash_AnnotedMap")
stashMap.buildingX = 13520
stashMap.buildingY = 2024
stashMap:addStamp(nil, "Stash_LVMap16_Text1", 13323, 1945, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap16_Text2", 13450, 1972, 1, 0, 0)
stashMap:addStamp("House", nil, 13519, 2024, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap16_Text3", 13532, 2015, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap16_Text4", 13529, 2032, 1, 0, 0)
stashMap:addStamp(nil, "Stash_LVMap16_Text5", 13531, 2051, 1, 0, 0)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

