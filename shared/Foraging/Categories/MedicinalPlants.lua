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
				Forest      = 10,
				DeepForest  = 15,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
		},
		Comfrey = {
			type = "Base.Comfrey",
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      = 10,
				DeepForest  = 15,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			altWorldTexture = forageSystem.worldSprites.vines,
		},
		WildGarlic = {
			type = "Base.WildGarlic2",--changed to this so it could server as a food item
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      = 10,
				DeepForest  = 15,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
		},
		CommonMallow = {
			type = "Base.CommonMallow",
			minCount = 2,
			maxCount = 8,
			xp = 15,
			recipes = { "Herbalist" },
			categories = { "MedicinalPlants" },
			zones = {
				Forest      = 10,
				DeepForest  = 15,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
			altWorldTexture = forageSystem.worldSprites.vines,
		},
		LemonGrass = {
			type = "Base.LemonGrass",
			minCount = 2,
			maxCount = 8,
			xp = 5,
			categories = { "MedicinalPlants" },
			zones = {
				Forest      = 10,
				DeepForest  = 15,
				Vegitation  = 15,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
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
				Forest      = 10,
				DeepForest  = 15,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
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
				Forest      = 10,
				DeepForest  = 15,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
			altWorldTexture = forageSystem.worldSprites.wildPlants,
		},
	};
	for itemName, itemDef in pairs(itemDefs) do
		forageDefs[itemName] = itemDef;
	end;
end

generateMedicinalPlantsDefs();