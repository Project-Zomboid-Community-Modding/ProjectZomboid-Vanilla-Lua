require "StashDescriptions/StashUtil";

-- food cache/survivor house
local stashMap = StashUtil.newStash("RiversideStashMap1", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6763
stashMap.buildingY = 5479
stashMap:addStamp("Circle", nil, 6763, 5479, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap1_Text1", 6742, 5493, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap1_Text11", 6742, 5514, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap1_Text2", 6618, 5446, 0.65, 0.054, 0.054)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- tool cache
local stashMap = StashUtil.newStash("RiversideStashMap2", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6255
stashMap.buildingY = 5209
stashMap:addStamp("Heart", nil, 6374, 5247, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap2_Text1", 6387, 5233, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap2_Text11", 6386, 5257, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap2_Text12", 6387, 5282, 0.65, 0.054, 0.054)
stashMap.spawnTable = "ToolsCache1";
stashMap:addContainer("ToolsBox", nil, "Base.Bag_DuffelBagTINT", nil, 6255, 5209, 1)

-- location info
local stashMap = StashUtil.newStash("RiversideStashMap3", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6207
stashMap.buildingY = 5346
stashMap:addStamp("Diamond", nil, 6223, 5347, 0.156, 0.188, 0.490)
stashMap:addStamp("KnifeFork", nil, 6198, 5347, 0.156, 0.188, 0.490)
stashMap:addStamp("Lightning", nil, 6191, 5358, 0.156, 0.188, 0.490)
stashMap:addStamp("Pill", nil, 6190, 5367, 0.156, 0.188, 0.490)
stashMap:addStamp("ArrowWest", nil, 6206, 5374, 0.156, 0.188, 0.490)
stashMap:addStamp(nil, "Stash_RiversideStashMap3_Text2", 6214, 5361, 0.156, 0.188, 0.490)
stashMap:addStamp("VHS", nil, 6209, 5348, 0.156, 0.188, 0.490)

-- Survivor House
local stashMap = StashUtil.newStash("RiversideStashMap4", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6763
stashMap.buildingY = 5330
stashMap:addStamp(nil, "Stash_RiversideStashMap4_Text1", 6697, 5274, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap4_Text11", 6623, 5298, 0.129,0.129,0.129)
stashMap:addStamp("X", nil, 6763, 5330, 0.129,0.129,0.129)
stashMap:addStamp("Cross", nil, 6570, 5375, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap4_Text2", 6528, 5384, 0.129,0.129,0.129)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- Survivor House
local stashMap = StashUtil.newStash("RiversideStashMap5", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6413
stashMap.buildingY = 5351
stashMap:addStamp("X", nil, 6413, 5351, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap5_Text1", 6319, 5291, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap5_Text2", 6319, 5316, 0.65, 0.054, 0.054)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- gun cache in floorboards
local stashMap = StashUtil.newStash("RiversideStashMap6", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6224
stashMap.buildingY = 5471
stashMap:addStamp("DollarSign", nil, 6224, 5470, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_RiversideStashMap6_Text1", 6124, 5478, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_RiversideStashMap6_Text11", 6122, 5503, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_RiversideStashMap6_Text12", 6123, 5527, 0.156, 0.188, 0.49)
stashMap.spawnTable = "GunCache1"
stashMap:addContainer("GunBox", "floors_interior_tilesandwood_01_62", nil, "kitchen", nil, nil, nil)

-- survivor house
local stashMap = StashUtil.newStash("RiversideStashMap7", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6629
stashMap.buildingY = 5330
stashMap:addStamp("Circle", nil, 6629, 5329, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap7_Text1", 6581, 5300, 0.129,0.129,0.129)
stashMap:addStamp("X", nil, 6507, 5348, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap7_Text2", 6447, 5363, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap7_Text21", 6447, 5387, 0.129,0.129,0.129)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- food cache
local stashMap = StashUtil.newStash("RiversideStashMap8", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6502
stashMap.buildingY = 5561
stashMap:addStamp("Apple", nil, 6502, 5561, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_RiversideStashMap8_Text1", 6517, 5558, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_RiversideStashMap8_Text11", 6517, 5582, 0.156, 0.188, 0.49)
stashMap:addStamp("Circle", nil, 6683, 5512, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_RiversideStashMap8_Text3", 6690, 5512, 0.156, 0.188, 0.49)
stashMap.spawnTable = "FoodCache1"
stashMap:addContainer("FoodBox", "carpentry_01_16", nil, nil, 6502, 5561, 0)

-- survivor house
local stashMap = StashUtil.newStash("RiversideStashMap9", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6057
stashMap.buildingY = 5347
stashMap:addStamp("Asterisk", nil, 6057, 5348, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap9_Text1", 6065, 5338, 0.129,0.129,0.129)
stashMap:addStamp("Circle", nil, 6061, 5304, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap9_Text2", 6071, 5292, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap9_Text3", 6051, 5382, 0.129,0.129,0.129)
stashMap.barricades = 80
stashMap.spawnTable = "SurvivorCache1"

-- location info
local stashMap = StashUtil.newStash("RiversideStashMap10", "Map", "Base.RiversideMap", "Stash_AnnotedMap")
stashMap.buildingX = 6495
stashMap.buildingY = 5265
stashMap:addStamp("KnifeFork", nil, 6508, 5264, 0.129, 0.129, 0.129)
stashMap:addStamp("Pill", nil, 6482, 5263, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap10_Text1", 6495, 5292, 0.129, 0.129, 0.129)
stashMap:addStamp(nil, "Stash_RiversideStashMap10_Text21", 6471, 5328, 0.650, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_RiversideStashMap10_Text3", 6487, 5374, 0.129, 0.129, 0.129)


