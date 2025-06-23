--[[---------------------------------------------
-------------------------------------------------
--
-- generateMedicinalPlantsDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateMedicinalPlantsDefs()
	local itemDefs = {
		Plantain = {
			type = "Base.Plantain",
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
			spawnFuncs = { forageSystem.doWildCropSpawn },
		},
		Comfrey = {
			type = "Base.Comfrey",
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			altWorldTexture = forageSystem.worldSprites.vines,
			spawnFuncs = { forageSystem.doWildCropSpawn },
		},
		WildGarlic = {
			type = "Base.WildGarlic2",--changed to this so it could server as a food item
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
			spawnFuncs = { forageSystem.doWildCropSpawn },
		},
		CommonMallow = {
			type = "Base.CommonMallow",
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn, forageSystem.doWildCropSpawn },
			altWorldTexture = forageSystem.worldSprites.vines,
		},
		LemonGrass = {
			type = "Base.LemonGrass",
			minCount = 2,
			maxCount = 8,
			xp = 5,
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn, forageSystem.doWildCropSpawn },
			altWorldTexture = getTexture("media/textures/Foraging/worldSprites/lemongrass_worldSprite.png"),
		},
		BlackSage = {
			type = "Base.BlackSage",
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
				Farm        	= 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn, forageSystem.doWildCropSpawn },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
		},
		Ginseng = {
			type = "Base.Ginseng",
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      	= 10,
				PHForest    	= 10,
				PRForest    	= 10,
				BirchForest 	= 10,
				OrganicForest	= 10,
				DeepForest  	= 15,
				Vegitation  	= 5,
				FarmLand   		= 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
		},
	};
	for itemName, itemDef in pairs(itemDefs) do
		forageSystem.addForageDef(itemName, itemDef);
	end;
end

generateMedicinalPlantsDefs();