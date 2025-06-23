--[[---------------------------------------------
-------------------------------------------------
--
-- generateStoneDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateStoneDefs()
	local stones = {
		SharpedStone = {
			type = "Base.SharpedStone",
			snowChance = -50,
			xp = 2,
			categories = { "Stones" },
			zones = {
				BirchForest		= 5,
				PHForest		= 5,
				PRForest		= 5,
				DeepForest		= 5,
				FarmLand    	= 5,
				ForagingNav 	= 5,
				Forest      	= 5,
				OrganicForest	= 5,
				TownZone    	= 5,
				TrailerPark 	= 5,
				Vegitation  	= 5,
			},
		},
		FlintNodule = {
			type = "Base.FlintNodule",
			hasRainedChance = 5,
			snowChance = -50,
			xp = 2,
			categories = { "Stones" },
			zones = {
				BirchForest		= 5,
				PHForest		= 5,
				PRForest		= 5,
				DeepForest		= 5,
				FarmLand    	= 5,
				ForagingNav 	= 5,
				Forest      	= 5,
				OrganicForest	= 5,
				TownZone    	= 5,
				TrailerPark 	= 5,
				Vegitation  	= 5,
			},
		},
		Stone = {
			type = "Base.Stone2",
			snowChance = -50,
			xp = 1,
			categories = { "Stones" },
			zones = {
				BirchForest		= 5,
				PHForest		= 5,
				PRForest		= 5,
				DeepForest		= 5,
				FarmLand    	= 5,
				ForagingNav 	= 5,
				Forest      	= 5,
				OrganicForest	= 5,
				TownZone    	= 5,
				TrailerPark 	= 5,
				Vegitation  	= 5,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
		Limestone = {
			type = "Base.Limestone",
			snowChance = -50,
			xp = 1,
			categories = { "Stones" },
			zones = {
				BirchForest		= 1,
				PHForest		= 1,
				PRForest		= 1,
				DeepForest		= 1,
				FarmLand    	= 1,
				ForagingNav 	= 1,
				Forest      	= 1,
				OrganicForest	= 1,
				TownZone    	= 1,
				TrailerPark 	= 1,
				Vegitation  	= 1,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
		LargeStone = {
			type = "Base.LargeStone",
			snowChance = -50,
			xp = 2,
			categories = { "Stones" },
			zones = {
				Forest      	= 1,
				PHForest		= 1,
				PRForest		= 1,
				BirchForest		= 1,
				DeepForest		= 1,
				OrganicForest	= 1,
				Vegitation  	= 1,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
		FlatStone = {
			type = "Base.FlatStone",
			snowChance = -50,
			xp = 1,
			categories = { "Stones" },
			zones = {
				Forest      	= 1,
				PHForest		= 1,
				PRForest		= 1,
				BirchForest		= 1,
				DeepForest		= 1,
				OrganicForest	= 1,
				Vegitation  	= 1,
				FarmLand    	= 1,
				ForagingNav 	= 1,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
		Clay = {
			type = "Base.Clay",
			rainChance = 30,
			hasRainedChance = 15,
			snowChance = -50,
			minCount = 2,
			maxCount = 4,
			xp = 1,
			categories = { "Stones" },
			zones = {
				Forest      	= 5,
				PHForest		= 5,
				PRForest		= 5,
				BirchForest		= 5,
				DeepForest		= 5,
				OrganicForest	= 5,
				Vegitation  	= 3,
				FarmLand    	= 5,
				TrailerPark 	= 1,
				TownZone    	= 1,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
	};
	for itemName, itemDef in pairs(stones) do
		forageSystem.addForageDef(itemName, itemDef);
	end;
end

generateStoneDefs();