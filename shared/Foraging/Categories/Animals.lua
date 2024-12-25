--[[---------------------------------------------
-------------------------------------------------
--
-- generateAnimalsDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";

local function generateAnimalsDefs()
	local itemDefs = {
		WildEggs = {
			type = "Base.WildEggs",
			minCount = 1,
			maxCount = 3,
			skill = 8,
			xp = 10,
			rainChance = -20,
			snowChance = -20,
			categories = { "Animals" },
			zones = {
				Forest      = 5,
				DeepForest  = 10,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
			spawnFuncs = { forageSystem.doRandomAgeSpawn },
		},
		Egg = {
			type = "Base.Egg",
			minCount = 1,
			maxCount = 3,
			skill = 8,
			xp = 10,
			rainChance = -20,
			snowChance = -20,
			categories = { "Animals" },
			zones = {
				Forest      = 5,
				DeepForest  = 10,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
			spawnFuncs = { forageSystem.doRandomAgeSpawn },
		},
		Worm = {
			type = "Base.Worm",
			minCount = 1,
			maxCount = 2,
			skill = 0,
			xp = 10,
			rainChance = 100,
			snowChance = -100,
			dayChance = -50,
			nightChance = 50,
			--itemTags = { "DigPlow" },
			categories = { "FishBait" },
			zones = {
				Forest      = 5,
				DeepForest  = 5,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
				TrailerPark = 5,
				TownZone    = 5,
				ForagingNav = 5,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
		},
		Frog = {
			type = "Base.Frog",
			skill = 7,
			xp = 10,
			rainChance = 100,
			snowChance = -100,
			dayChance = -50,
			nightChance = 50,
			categories = { "Animals" },
			zones = {
				Forest      = 5,
				DeepForest  = 5,
				Vegitation  = 5,
				FarmLand    = 2,
				Farm        = 2,
				TrailerPark = 0,
				TownZone    = 0,
				ForagingNav = 0,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
		},
		Slug = {
			type = "Base.Slug",
			skill = 3,
			xp = 10,
			rainChance = 100,
			snowChance = -100,
			dayChance = -50,
			nightChance = 50,
			categories = { "Animals" },
			zones = {
				Forest      = 5,
				DeepForest  = 5,
				Vegitation  = 5,
				FarmLand    = 2,
				Farm        = 2,
				TrailerPark = 0,
				TownZone    = 0,
				ForagingNav = 0,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
		},
		Slug2 = {
			type = "Base.Slug2",
			skill = 3,
			xp = 10,
			rainChance = 100,
			snowChance = -100,
			dayChance = -50,
			nightChance = 50,
			categories = { "Animals" },
			zones = {
				Forest      = 5,
				DeepForest  = 5,
				Vegitation  = 5,
				FarmLand    = 2,
				Farm        = 2,
				TrailerPark = 0,
				TownZone    = 0,
				ForagingNav = 0,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
		},
		Snail = {
			type = "Base.Snail",
			skill = 3,
			xp = 10,
			rainChance = 100,
			snowChance = -100,
			dayChance = -50,
			nightChance = 50,
			categories = { "Animals" },
			zones = {
				Forest      = 5,
				DeepForest  = 5,
				Vegitation  = 5,
				FarmLand    = 2,
				Farm        = 2,
				TrailerPark = 0,
				TownZone    = 0,
				ForagingNav = 0,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
		},
	};
	for itemName, itemDef in pairs(itemDefs) do
		forageDefs[itemName] = itemDef;
	end;
end

generateAnimalsDefs();