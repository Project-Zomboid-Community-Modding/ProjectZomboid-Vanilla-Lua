--[[---------------------------------------------
-------------------------------------------------
--
-- generateForestGoodsDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";

local function generateForestGoodsDefs()
	local forestGoods = {
		Log = {
			type = "Base.Log",
			skill = 0,
			xp = 5,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 3,
				Forest      = 2,
				Vegitation  = 1,
			},
			bonusMonths = { 9, 10, 11 },
			itemSizeModifier = 5,
			isItemOverrideSize = true,
		},
		LongStick = {
			type = "Base.LongStick",
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 10,
				Forest      = 10,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			bonusMonths = { 9, 10, 11 },
		},
		LongStickBroken = {
			type = "Base.LongStick_Broken",
			xp = 1,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 10,
				Forest      = 10,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			bonusMonths = { 9, 10, 11 },
		},
		TreeBranch = {
			type = "Base.TreeBranch2",
			minCount = 1,
			maxCount = 2,
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 15,
				Forest      = 15,
				Vegitation  = 10,
				FarmLand    = 10,
				Farm        = 10,
				TrailerPark = 5,
				TownZone    = 5,
				ForagingNav = 5,
			},
			bonusMonths = { 9, 10, 11 },
		},
		Twigs = {
			type = "Base.Twigs",
			minCount = 1,
			maxCount = 3,
			xp = 1,
			categories = { "Firewood" },
			zones = {
				Forest      = 20,
				DeepForest  = 20,
				Vegitation  = 20,
				FarmLand    = 15,
				Farm        = 15,
				TrailerPark = 10,
				TownZone    = 10,
				ForagingNav = 10,
			},
			bonusMonths = { 9, 10, 11 },
		},
		Pinecone = {
			type = "Base.Pinecone",
			minCount = 1,
			maxCount = 3,
			xp = 1,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 15,
				Forest      = 15,
				Vegitation  = 10,
				FarmLand    = 10,
				Farm        = 10,
				TrailerPark = 5,
				TownZone    = 5,
				ForagingNav = 5,
			},
			months = { 9, 10, 11, 12 },
		},
		LargeBranch = {
			type = "Base.LargeBranch",
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 10,
				Forest      = 10,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			bonusMonths = { 9, 10, 11 },
		},
		LargeBranch_Broken = {
			type = "Base.Branch_Broken",
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 10,
				Forest      = 10,
				Vegitation  = 5,
				FarmLand    = 5,
				Farm        = 5,
			},
			bonusMonths = { 9, 10, 11 },
		},
		Sapling = {
			type = "Base.Sapling",
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 3,
				Forest      = 2,
				Vegitation  = 1,
			},
			bonusMonths = { 9, 10, 11 },
		},
			Dogbane = {
			type = "Base.Dogbane",
			minCount = 1,
			maxCount = 3,
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  = 5,
				Forest      = 10,
				Vegitation  = 10,
				FarmLand    = 10,
				Farm        = 10,
			},
			bonusMonths = { 9, 10, 11 },
			altWorldTexture = forageSystem.worldSprites.dogbane,
		},
	};
	for itemName, itemDef in pairs(forestGoods) do
		forageDefs[itemName] = itemDef;
	end;
end

generateForestGoodsDefs();