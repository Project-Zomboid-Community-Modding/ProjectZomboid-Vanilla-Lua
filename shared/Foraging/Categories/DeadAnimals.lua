--[[---------------------------------------------
-------------------------------------------------
--
-- generateDeadAnimalsDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";

local function generateDeadAnimalsDefs()
	local itemDefs = {
		DeadBird = {
			type = "Base.DeadBird",
			skill = 7,
			xp = 10,
			rainChance = -10,
			snowChance = -10,
			categories = { "DeadAnimals" },
			zones = {
				Forest      = 2,
				DeepForest  = 2,
				Vegitation  = 2,
				FarmLand    = 2,
				Farm        = 2,
				TrailerPark = 2,
				TownZone    = 2,
				ForagingNav = 2,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
			spawnFuncs = { forageSystem.doDeadTrapAnimalSpawn },
			forceOutside = false,
			canBeAboveFloor = true,
		},
		DeadSquirrel = {
			type = "Base.DeadSquirrel",
			skill = 8,
			xp = 10,
			rainChance = -10,
			snowChance = -10,
			categories = { "DeadAnimals" },
			zones = {
				Forest      = 2,
				DeepForest  = 2,
				Vegitation  = 2,
				FarmLand    = 1,
				Farm        = 1,
				TrailerPark = 2,
				TownZone    = 2,
				ForagingNav = 1,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
			spawnFuncs = { forageSystem.doDeadTrapAnimalSpawn },
		},
		DeadRabbit = {
			type = "Base.DeadRabbit",
			skill = 10,
			xp = 10,
			rainChance = -10,
			snowChance = -10,
			categories = { "DeadAnimals" },
			zones = {
				Forest      = 1,
				DeepForest  = 1,
				Vegitation  = 2,
				FarmLand    = 2,
				Farm        = 2,
				TrailerPark = 0,
				TownZone    = 0,
				ForagingNav = 1,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
			spawnFuncs = { forageSystem.doDeadTrapAnimalSpawn },
		},
		DeadRat = {
			type = "Base.DeadRat",
			skill = 5,
			xp = 10,
			rainChance = -10,
			snowChance = -10,
			categories = { "DeadAnimals" },
			zones = {
				Forest      = 2,
				DeepForest  = 2,
				Vegitation  = 2,
				FarmLand    = 5,
				Farm        = 5,
				TrailerPark = 10,
				TownZone    = 10,
				ForagingNav = 1,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
			spawnFuncs = { forageSystem.doDeadTrapAnimalSpawn },
			forceOutside = false,
			canBeAboveFloor = true,
		},
	};
	for itemName, itemDef in pairs(itemDefs) do
		forageDefs[itemName] = itemDef;
	end;
end

generateDeadAnimalsDefs();