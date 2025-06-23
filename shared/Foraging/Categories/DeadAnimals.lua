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
require "Foraging/forageSystem";

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
				BirchForest		= 2,
				DeepForest  	= 2,
				Farm        	= 2,
				FarmLand    	= 2,
				ForagingNav 	= 2,
				Forest      	= 2,
				OrganicForest	= 2,
				PHForest  		= 2,
				PRForest  		= 2,
				TownZone    	= 2,
				TrailerPark 	= 2,
				Vegitation  	= 2,
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
				BirchForest		= 2,
				DeepForest  	= 2,
				Farm        	= 1,
				FarmLand    	= 1,
				ForagingNav 	= 1,
				Forest      	= 2,
				OrganicForest	= 2,
				PHForest  		= 2,
				PRForest  		= 2,
				TownZone    	= 2,
				TrailerPark 	= 2,
				Vegitation  	= 2,
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
				BirchForest		= 2,
				DeepForest  	= 1,
				Farm        	= 2,
				FarmLand    	= 2,
				ForagingNav 	= 1,
				Forest      	= 1,
				OrganicForest	= 2,
				PHForest  		= 2,
				PRForest  		= 2,
				Vegitation  	= 2,
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
				Forest      	= 2,
				PHForest  		= 2,
				PRForest  		= 2,
				BirchForest		= 2,
				OrganicForest	= 2,
				DeepForest  	= 2,
				Vegitation  	= 2,
				FarmLand    	= 5,
				Farm        	= 5,
				TrailerPark 	= 10,
				TownZone    	= 10,
				ForagingNav 	= 1,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
			spawnFuncs = { forageSystem.doDeadTrapAnimalSpawn },
			forceOutside = false,
			canBeAboveFloor = true,
		},
		DeadMouse = {
			type = "Base.DeadMouse",
			skill = 5,
			xp = 10,
			rainChance = -10,
			snowChance = -10,
			categories = { "DeadAnimals" },
			zones = {
				Forest      	= 2,
				PHForest  		= 2,
				PRForest  		= 2,
				BirchForest		= 2,
				OrganicForest	= 2,
				DeepForest  	= 2,
				Vegitation  	= 2,
				FarmLand    	= 5,
				Farm        	= 5,
				TrailerPark 	= 10,
				TownZone    	= 10,
				ForagingNav 	= 1,
			},
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			malusMonths = { 3, 4 },
			spawnFuncs = { forageSystem.doDeadTrapAnimalSpawn },
			forceOutside = false,
			canBeAboveFloor = true,
		},
	};
	for itemName, itemDef in pairs(itemDefs) do
		forageSystem.addForageDef(itemName, itemDef);
	end;
end

generateDeadAnimalsDefs();