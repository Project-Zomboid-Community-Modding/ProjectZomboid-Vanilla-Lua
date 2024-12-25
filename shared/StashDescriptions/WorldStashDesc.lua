
--
--Black: 0.129,0.129,0.129
--Red: 0.65, 0.054, 0.054
--Blue: 0.156, 0.188, 0.49
--Green: 0.06, 0.39, 0.17
require "StashDescriptions/StashUtil";

-- WorldMap1 (survivor house)
local stashMap = StashUtil.newStash("WorldStashMap1", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 7303
stashMap.buildingY = 8430
stashMap.spawnTable = "SurvivorCache1";
stashMap.barricades = 75;
stashMap.zombies = 1;
stashMap:addStamp("Circle", nil, 7303, 8429, 0, 0, 0)
stashMap:addStamp(nil, "Stash_WorldMap1_Text1", 7235, 8438, 0, 0, 0)
stashMap:addStamp("Exclamation", nil, 7276, 8375, 0, 0, 0)
stashMap:addStamp(nil, "Stash_WorldMap1_Text2", 7257, 8346, 0, 0, 0)

-- WorldMap2 (survivor house, guns)
local stashMap = StashUtil.newStash("WorldStashMap2", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 6931
stashMap.buildingY = 8088
stashMap.spawnTable = "GunCache1";
stashMap.barricades = 75;

stashMap:addStamp("Diamond", nil, 6931, 8085, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap2_Text1", 6914, 8094, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap2_Text11", 6913, 8110, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap2_Text12", 6912, 8129, 0.65, 0.054, 0.054)

-- WorldMap3 (location info)
local stashMap = StashUtil.newStash("WorldStashMap3", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 5466
stashMap.buildingY = 9710
stashMap:addStamp("Asterisk", nil, 5466, 9710, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_WorldMap3_Text1", 5440, 9713, 0.06, 0.39, 0.17)
stashMap:addStamp(nil, "Stash_WorldMap3_Text11", 5433, 9731, 0.06, 0.39, 0.17)
stashMap:addStamp("Wrench", nil, 5471, 9663, 0.06, 0.39, 0.17)
stashMap:addStamp("Garbage", nil, 5436, 9684, 0.06, 0.39, 0.17)

--WorldMap4 (survivor house)
local stashMap = StashUtil.newStash("WorldStashMap4", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap:addStamp("Target", nil, 4704, 7914, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap4_Text1", 4646, 7922, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap4_Text11", 4647, 7940, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap4_Text12", 4643, 7962, 0.156, 0.188, 0.49)

stashMap.buildingX = 4704
stashMap.buildingY = 7914

--WorldMap5 (gun floorboard stash)
local stashMap = StashUtil.newStash("WorldStashMap5", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");

stashMap:addStamp("Exclamation", nil, 3971, 6237, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_WorldMap5_Text1", 3966, 6242, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_WorldMap5_Text11", 3966, 6262, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_WorldMap5_Text12", 3965, 6278, 0.129,0.129,0.129)

stashMap.buildingX = 3971
stashMap.buildingY = 6238

--WorldMap6 (location info)
local stashMap = StashUtil.newStash("WorldStashMap6", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 10134
stashMap.buildingY = 6650
stashMap:addStamp("Gears", nil, 10134, 6650, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap6_Text1", 10104, 6657, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap6_Text2", 10083, 6692, 0.156, 0.188, 0.49)
stashMap:addStamp("Circle", nil, 10104, 6630, 0.156, 0.188, 0.49)
stashMap:addStamp("Circle", nil, 10158, 6625, 0.156, 0.188, 0.49)
stashMap:addStamp("Circle", nil, 10144, 6683, 0.156, 0.188, 0.49)
stashMap:addStamp("Cross", nil, 10285, 6677, 0.156, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap6_Text3", 10271, 6680, 0.65, 0.054, 0.054)
stashMap:addStamp("Fish", nil, 10203, 6761, 0.156, 0.188, 0.49)


--WorldMap7 (food cache)
local stashMap = StashUtil.newStash("WorldStashMap7", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");

stashMap:addStamp("KnifeFork", nil, 11667, 8794, 0.65, 0.054, 0.054)
stashMap:addStamp("Garbage", nil, 11685, 8823, 0.65, 0.054, 0.054)
stashMap:addStamp("Apple", nil, 11692, 8792, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap7_Text1", 11640, 8797, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap7_Text2", 11649, 8832, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap7_Text21", 11598, 8851, 0.65, 0.054, 0.054)

stashMap.buildingX = 11689
stashMap.buildingY = 8973
stashMap.spawnTable = "FoodCache1";
stashMap:addContainer("FoodBox", "furniture_storage_02_19", nil, nil, 11689, 8789, 0)

--WorldMap8 (booze)
local stashMap = StashUtil.newStash("WorldStashMap8", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 11459
stashMap.buildingY = 8953
stashMap.spawnTable = "BoozeCache1";
stashMap:addStamp("ArrowNorthEast", nil, 11445, 8963, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceHappy", nil, 11433, 8974, 0.65, 0.054, 0.054)


--WorldMap9 (location info, railyard)
local stashMap = StashUtil.newStash("WorldStashMap9", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 11508
stashMap.buildingY = 9745
stashMap:addStamp(nil, "Stash_WorldMap9_Text2", 11565, 9874, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap9_Text1", 11625, 9687, 0.65, 0.054, 0.054)
stashMap:addStamp("ArrowWest", nil, 11508, 9745, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap9_Text5", 11522, 9733, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap9_Text3", 11500, 9676, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap9_Text4", 11793, 9813, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap9_Text6", 11624, 9957, 0.65, 0.054, 0.054)

--WorldMap10 (location info, crossroads town north of Dixie)
local stashMap = StashUtil.newStash("WorldStashMap10", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 11596
stashMap.buildingY = 8309
stashMap:addStamp("Circle", nil, 11596, 8309, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap10_Text1", 11581, 8313, 0.156, 0.188, 0.49)
stashMap:addStamp("Circle", nil, 11604, 8254, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap10_Text2", 11584, 8265, 0.156, 0.188, 0.49)
stashMap:addStamp("Circle", nil, 11671, 8304, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap10_Text3", 11650, 8312, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap10_Text4", 11665, 8373, 0.156, 0.188, 0.49)
stashMap:addStamp("Circle", nil, 11675, 8366, 0.156, 0.188, 0.49)

--WorldMap11 (radio relay location, useless)
local stashMap = StashUtil.newStash("WorldStashMap11", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 10267
stashMap.buildingY = 8743
stashMap:addStamp(nil, "Stash_WorldMap11_Text1", 10199, 8693, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap11_Text11", 10205, 8709, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap11_Text2", 10196, 8776, 0.65, 0.054, 0.054)
stashMap:addStamp("Sun", nil, 10267, 8743, 0.65, 0.054, 0.054)
stashMap:addStamp("X", nil, 10268, 8743, 0.65, 0.054, 0.054)

--WorldMap12 (survivor house, large camping grounds site)
local stashMap = StashUtil.newStash("WorldStashMap12", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 13850
stashMap.buildingY = 6769
stashMap.barricades = 75;
stashMap.zombies = 5;
stashMap.spawnTable = "SurvivorCache1";
stashMap:addStamp("Fire", nil, 13785, 6738, 1, 0,71, 0)
stashMap:addStamp(nil, "Stash_WorldMap12_Text1", 13702, 6603, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap12_Text11", 13704, 6632, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap12_Text2", 13718, 6696, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap12_Text21", 13739, 6760, 0.156, 0.188, 0.49)
stashMap:addStamp("FaceHappy", nil, 13766, 6738, 0.855, 0, 1)
stashMap:addStamp("FaceHappy", nil, 13805, 6738, 0.98, 1, 0.32)
stashMap:addStamp("FaceHappy", nil, 13786, 6753, 0.376, 1, 0.32)
stashMap:addStamp("FaceHappy", nil, 13785, 6721, 0.32, 0.4, 1)
stashMap:addStamp("Heart", nil, 13853, 6770, 0.65, 0.054, 0.054)


--WorldMap13 (survivor house, Valley Station)
local stashMap = StashUtil.newStash("WorldStashMap13", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap:addStamp("Circle", nil, 14023, 5476, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap13_Text1", 13956, 5483, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap13_Text11", 13956, 5503, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap13_Text12", 13955, 5525, 0.156, 0.188, 0.49)
stashMap.buildingX = 14023
stashMap.buildingY = 5476
stashMap.spawnTable = "SurvivorCache1";
stashMap.barricades = 35;
stashMap.zombies = 1;

--WorldMap14 (survivor house, east of Valley Station)
local stashMap = StashUtil.newStash("WorldStashMap14", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 14347
stashMap.buildingY = 5453
stashMap:addStamp("House", nil, 14347, 5453, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_WorldMap14_Text1", 14312, 5459, 0.129,0.129,0.129)
stashMap:addStamp("Cross", nil, 14392, 5519, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_WorldMap14_Text2", 14342, 5505, 0.129,0.129,0.129)
stashMap.spawnTable = "SurvivorCache2";
stashMap.barricades = 45;
stashMap.zombies = 1;

--WorldMap15 (gun cache)
local stashMap = StashUtil.newStash("WorldStashMap15", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap:addStamp("Lightning", nil, 14762, 4086, 0.65, 0.054, 0.054)
stashMap:addStamp("Gun", nil, 14732, 4084, 0.65, 0.054, 0.054)
stashMap.buildingX = 14732
stashMap.buildingY = 4084
stashMap.spawnTable = "GunCache1";

--WorldMap16 (army checkpoint map)
local stashMap = StashUtil.newStash("WorldStashMap16", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 12516
stashMap.buildingY = 4358
stashMap:addStamp("Trap", nil, 12516, 4358, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap16_Text1", 12507, 4299, 0.65, 0.054, 0.054)
stashMap:addStamp("ArrowNorth", nil, 12513, 4487, 0.65, 0.054, 0.054)
stashMap:addStamp("Trap", nil, 12512, 4474, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap16_Text2", 12494, 4377, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap16_Text3", 12485, 4494, 0.65, 0.054, 0.054)
stashMap:addStamp("ArrowNorth", nil, 12517, 4373, 0.65, 0.054, 0.054)

--WorldMap17 (facility "raid")
local stashMap = StashUtil.newStash("WorldStashMap17", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 5559
stashMap.buildingY = 12479
stashMap:addStamp("Target", nil, 5559, 12479, 0.65, 0.054, 0.054)
stashMap:addStamp("ArrowEast", nil, 5497, 12479, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap17_Text1", 5452, 12487, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap17_Text2", 5541, 12532, 0.65, 0.054, 0.054)
stashMap:addStamp(nil, "Stash_WorldMap17_Text21", 5537, 12560, 0.65, 0.054, 0.054)

--WorldMap18 (burned town info)
local stashMap = StashUtil.newStash("WorldStashMap18", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 13564
stashMap.buildingY = 4048
stashMap:addStamp("Fire", nil, 13564, 4048, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13609, 4075, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13658, 4104, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13700, 4116, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13704, 4068, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13661, 4052, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13611, 4045, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13580, 4019, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13518, 4096, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13561, 4132, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13587, 4157, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13592, 4102, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13549, 4074, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13686, 4084, 0.65, 0.054, 0.054)
stashMap:addStamp("Fire", nil, 13526, 4022, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceSad", nil, 13650, 4083, 0.65, 0.054, 0.054)
stashMap:addStamp("Gun", nil, 13662, 4089, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceHappy", nil, 13671, 4098, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13625, 4037, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13567, 4081, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13702, 4039, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13734, 4084, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13734, 4123, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13685, 4134, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13518, 4133, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13618, 4131, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceDead", nil, 13506, 4039, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceHappy", nil, 13746, 4049, 0.65, 0.054, 0.054)
stashMap:addStamp("Gun", nil, 13736, 4043, 0.65, 0.054, 0.054)
stashMap:addStamp("FaceSad", nil, 13725, 4035, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13502, 4104, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13621, 4101, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13659, 4132, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13746, 4112, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13675, 4037, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13582, 4034, 0.65, 0.054, 0.054)
stashMap:addStamp("Skull", nil, 13539, 4038, 0.65, 0.054, 0.054)

--WorldMap19 (gun cache)
local stashMap = StashUtil.newStash("WorldStashMap19", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 10209
stashMap.buildingY = 7416
stashMap.spawnTable = "GunCache1";
stashMap.barricades = 90;
stashMap:addStamp("X", nil, 10209, 7416, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_WorldMap19_Text1", 10156, 7422, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_WorldMap19_Text11", 10142, 7449, 0.129,0.129,0.129)
stashMap:addStamp(nil, "Stash_WorldMap19_Text12", 10136, 7477, 0.129,0.129,0.129)

--WorldMap20 (survivor bags, in small church)
local stashMap = StashUtil.newStash("WorldStashMap20", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 14549
stashMap.buildingY = 4974
stashMap.barricades = 80;
stashMap.zombies = 8;
stashMap.spawnTable = "GunCache2";
stashMap:addContainer("GunBox", nil, "Base.Bag_AmmoBox_Mixed", "church", nil,nil,nil)
stashMap.spawnTable = "GunCache2";
stashMap:addContainer("GunBox", nil, "Base.Bag_AmmoBox_Mixed", "church", nil,nil,nil)
stashMap:addContainer("GunBox", nil, "Base.Bag_FoodCanned", "church", nil,nil,nil)
stashMap:addContainer("GunBox", nil, "Base.Bag_FoodCanned", "church", nil,nil,nil)
stashMap:addContainer("GunBox", nil, "Base.Bag_ShotgunDblBag", "church", nil,nil,nil)
stashMap:addStamp("FaceDead", nil, 14549, 4974, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap20_Text1", 14492, 4982, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap20_Text2", 14483, 5005, 0.156, 0.188, 0.49)
stashMap:addStamp(nil, "Stash_WorldMap20_Text3", 14497, 5027, 0.156, 0.188, 0.49)

--WorldMap21 (location info)
local stashMap = StashUtil.newStash("WorldStashMap21", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 4
stashMap.buildingY = 0
stashMap:addStamp("Fuel", nil, 3566, 10909, 0.06, 0.39, 0.17)
stashMap:addStamp("Apple", nil, 3576, 10895, 0.06, 0.39, 0.17)
stashMap:addStamp("Hammer", nil, 3683, 10898, 0.06, 0.39, 0.17)

--WorldMap22 (survivor house)
local stashMap = StashUtil.newStash("WorldStashMap22", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap:addStamp(nil, "Stash_WorldMap22_Text1", 1191, 11884, 0.06, 0.39, 0.17)
stashMap.buildingX = 1226
stashMap.buildingY = 11879
stashMap.barricades = 80;
stashMap.zombies = 8;

--WorldMap23 (Thunder Gas)
local stashMap = StashUtil.newStash("WorldStashMap23", "Map", "Base.RosewoodMap", "Stash_AnnotedMap");
stashMap.buildingX = 5
stashMap.buildingY = 0
stashMap:addStamp("Fuel", nil, 8727, 14099, 0, 0, 0)
stashMap:addStamp(nil, "Stash_WorldMap23_Text2", 8679, 14103, 0, 0, 0)
stashMap:addStamp("Hammer", nil, 8727, 14082, 0, 0, 0)
stashMap:addStamp(nil, "Stash_WorldMap23_Text1", 8693, 14053, 0, 0, 0)

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

