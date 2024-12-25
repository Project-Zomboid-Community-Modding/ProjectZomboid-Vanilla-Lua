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

local function generateStoneDefs()
	local stones = {
		SharpedStone = {
			type = "Base.SharpedStone",
			snowChance = -50,
			xp = 2,
			categories = { "Stones" },
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
		},
		FlintNodule = {
			type = "Base.FlintNodule",
			snowChance = -50,
			xp = 2,
			categories = { "Stones" },
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
		},
		Stone = {
			type = "Base.Stone2",
			snowChance = -50,
			xp = 1,
			categories = { "Stones" },
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
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
		Limestone = {
			type = "Base.Limestone",
			snowChance = -50,
			xp = 1,
			categories = { "Stones" },
			zones = {
				Forest      = 1,
				DeepForest  = 1,
				Vegitation  = 1,
				FarmLand    = 1,
				Farm        = 1,
				TrailerPark = 1,
				TownZone    = 1,
				ForagingNav = 1,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
		LargeStone = {
			type = "Base.LargeStone",
			snowChance = -50,
			xp = 2,
			categories = { "Stones" },
			zones = {
				Forest      = 1,
				DeepForest  = 1,
				Vegitation  = 1,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
		--Flint = {
		--	type = "Base.Flint",
		--	snowChance = -50,
		--	xp = 1,
		--	categories = { "Stones" },
		--	zones = {
		--		Forest      = 1,
		--		DeepForest  = 1,
		--		Vegitation  = 1,
		--		FarmLand    = 1,
		--		Farm        = 1,
		--		ForagingNav = 1,
		--	},
		--	months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		--},
		FlatStone = {
			type = "Base.FlatStone",
			snowChance = -50,
			xp = 1,
			categories = { "Stones" },
			zones = {
				Forest      = 1,
				DeepForest  = 1,
				Vegitation  = 1,
				FarmLand    = 1,
				Farm        = 1,
				ForagingNav = 1,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
		Clay = {
			type = "Base.Clay",
			snowChance = -50,
			xp = 1,
			categories = { "Stones" },
			zones = {
				Forest      = 5,
				DeepForest  = 5,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
				TrailerPark = 1,
				TownZone    = 1,
			},
			months = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },
		},
	};
	for itemName, itemDef in pairs(stones) do
		forageDefs[itemName] = itemDef;
	end;
end

generateStoneDefs();