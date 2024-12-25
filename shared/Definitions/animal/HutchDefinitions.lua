--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 24/03/2022
-- Time: 08:46
-- To change this template use File | Settings | File Templates.
--

-- define all the hutch (sorry Starsky) we can have in game

HutchDefinitions = HutchDefinitions or {};
HutchDefinitions.hutchs = {};
HutchDefinitions.hutchs["hutchhen"] = {};
HutchDefinitions.hutchs["hutchhen"].name = "hutchhen";
HutchDefinitions.hutchs["hutchhen"].planks = 18;
HutchDefinitions.hutchs["hutchhen"].nails = 30;
HutchDefinitions.hutchs["hutchhen"].skill = 4;
HutchDefinitions.hutchs["hutchhen"].enterSpotX = 0; -- offset of the tile the animal should enter/exit the hutch, this need to be an empty tile, here i setup in the front of the door
HutchDefinitions.hutchs["hutchhen"].enterSpotY = 1;
HutchDefinitions.hutchs["hutchhen"].maxAnimals = 20; -- max animals that can be inside the hutch
HutchDefinitions.hutchs["hutchhen"].maxNestBox = 3; -- start from 0, meaning 4 nest box
HutchDefinitions.hutchs["hutchhen"].baseSprite = "location_farm_accesories_01_50";
--HutchDefinitions.hutchs["hutchhen"].openHatchSprite = "location_farm_accesories_01_48"; -- this is the hatch for the eggs, here it's on the same tile as the baseSprite
--HutchDefinitions.hutchs["hutchhen"].closedHatchSprite = "location_farm_accesories_01_50";
--HutchDefinitions.hutchs["hutchhen"].hatchXOffset = 0;
--HutchDefinitions.hutchs["hutchhen"].hatchYOffset = 0;
--HutchDefinitions.hutchs["hutchhen"].hatchZOffset = 0;
HutchDefinitions.hutchs["hutchhen"].extraSprites = {};
table.insert(HutchDefinitions.hutchs["hutchhen"].extraSprites, {xoffset=1, yoffset=0, zoffset=0, sprite="location_farm_accesories_01_42"});
table.insert(HutchDefinitions.hutchs["hutchhen"].extraSprites, {xoffset=1, yoffset=-1, zoffset=0, sprite="location_farm_accesories_01_43"});
table.insert(HutchDefinitions.hutchs["hutchhen"].extraSprites, {xoffset=0, yoffset=-1, zoffset=0, sprite="location_farm_accesories_01_41"});
table.insert(HutchDefinitions.hutchs["hutchhen"].extraSprites, {xoffset=0, yoffset=0, zoffset=0, sprite="location_farm_accesories_01_44", spriteOpen="location_farm_accesories_01_46"});
table.insert(HutchDefinitions.hutchs["hutchhen"].extraSprites, {xoffset=1, yoffset=0, zoffset=0, sprite="location_farm_accesories_01_45", spriteOpen="location_farm_accesories_01_47"});

HutchDefinitions.hutchs["hutchhen"].eggHatchDoors = {};
table.insert(HutchDefinitions.hutchs["hutchhen"].eggHatchDoors, {xoffset=0, yoffset=0, zoffset=0, closedSprite="location_farm_accesories_01_50", sprite="location_farm_accesories_01_48"});
table.insert(HutchDefinitions.hutchs["hutchhen"].eggHatchDoors, {xoffset=0, yoffset=-1, zoffset=0, closedSprite="location_farm_accesories_01_41", sprite="location_farm_accesories_01_49"});

HutchDefinitions.hutchs["hutchturkey"] = {};
HutchDefinitions.hutchs["hutchturkey"].name = "hutchturkey";
HutchDefinitions.hutchs["hutchturkey"].planks = 18;
HutchDefinitions.hutchs["hutchturkey"].nails = 30;
HutchDefinitions.hutchs["hutchturkey"].skill = 4;
HutchDefinitions.hutchs["hutchturkey"].enterSpotX = 0;
HutchDefinitions.hutchs["hutchturkey"].enterSpotY = 1;
HutchDefinitions.hutchs["hutchturkey"].maxAnimals = 20; -- max animals that can be inside the hutch
HutchDefinitions.hutchs["hutchturkey"].maxNestBox = 3; -- start from 0, meaning 4 nest box
HutchDefinitions.hutchs["hutchturkey"].baseSprite = "location_farm_accesories_01_66";
HutchDefinitions.hutchs["hutchturkey"].extraSprites = {};
table.insert(HutchDefinitions.hutchs["hutchturkey"].extraSprites, {xoffset=1, yoffset=0, zoffset=0, sprite="location_farm_accesories_01_58"});
table.insert(HutchDefinitions.hutchs["hutchturkey"].extraSprites, {xoffset=1, yoffset=-1, zoffset=0, sprite="location_farm_accesories_01_59"});
table.insert(HutchDefinitions.hutchs["hutchturkey"].extraSprites, {xoffset=0, yoffset=-1, zoffset=0, sprite="location_farm_accesories_01_57"});
table.insert(HutchDefinitions.hutchs["hutchturkey"].extraSprites, {xoffset=0, yoffset=0, zoffset=0, sprite="location_farm_accesories_01_60", spriteOpen="location_farm_accesories_01_62"});
table.insert(HutchDefinitions.hutchs["hutchturkey"].extraSprites, {xoffset=1, yoffset=0, zoffset=0, sprite="location_farm_accesories_01_61", spriteOpen="location_farm_accesories_01_63"});

HutchDefinitions.hutchs["hutchturkey"].eggHatchDoors = {};
table.insert(HutchDefinitions.hutchs["hutchturkey"].eggHatchDoors, {xoffset=0, yoffset=0, zoffset=0, closedSprite="location_farm_accesories_01_66", sprite="location_farm_accesories_01_64"});
table.insert(HutchDefinitions.hutchs["hutchturkey"].eggHatchDoors, {xoffset=0, yoffset=-1, zoffset=0, closedSprite="location_farm_accesories_01_57", sprite="location_farm_accesories_01_65"});