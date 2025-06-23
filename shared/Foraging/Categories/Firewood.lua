--[[---------------------------------------------
-------------------------------------------------
--
-- generateFirewoodDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateFirewoodDefs()
	local firewood = {
		Log = {
			type = "Base.Log",
			skill = 0,
			xp = 5,
			categories = { "Firewood" },
			zones = {
				DeepForest  	= 3,
				OrganicForest  	= 5,
				BirchForest  	= 4,
				PRForest  		= 3,
				PHForest  		= 3,
				Forest      	= 2,
				Vegitation  	= 1,
			},
			bonusMonths = { 9, 10, 11 },
			itemSizeModifier = 5,
			isItemOverrideSize = true,
		},
		TreeBranch = {
			type = "Base.TreeBranch2",
			minCount = 1,
			maxCount = 2,
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  	= 15,
				Forest      	= 15,
				OrganicForest  	= 20,
				BirchForest  	= 15,
				PRForest  		= 12,
				PHForest  		= 12,
				Vegitation  	= 10,
				FarmLand    	= 10,
				TrailerPark 	= 5,
				TownZone    	= 5,
				ForagingNav 	= 5,
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
				Forest      	= 20,
				OrganicForest  	= 20,
				BirchForest  	= 20,
				PRForest  		= 20,
				PHForest  		= 20,
				DeepForest  	= 20,
				Vegitation  	= 20,
				FarmLand    	= 15,
				TrailerPark 	= 10,
				TownZone    	= 10,
				ForagingNav 	= 10,
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
				DeepForest  	= 15,
				Forest      	= 15,
				OrganicForest  	= 25,
				BirchForest  	= 20,
				PRForest  		= 20,
				PHForest  		= 20,
				Vegitation  	= 10,
				FarmLand    	= 10,
				TrailerPark 	= 5,
				TownZone    	= 5,
				ForagingNav 	= 5,
			},
			months = { 9, 10, 11, 12 },
		},
		LargeBranch = {
			type = "Base.LargeBranch",
			xp = 2,
			categories = { "Firewood" },
			zones = {
				BirchForest  	= 10,
				DeepForest  	= 10,
				Farm        	= 5,
				Forest      	= 10,
				OrganicForest  	= 12,
				PHForest  		= 10,
				PRForest  		= 10,
				Vegitation  	= 5,
			},
			bonusMonths = { 9, 10, 11 },
		},
		LargeBranch_Broken = {
			type = "Base.Branch_Broken",
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  	= 10,
				OrganicForest  	= 15,
				BirchForest  	= 10,
				PRForest  		= 10,
				PHForest  		= 10,
				Forest      	= 10,
				Vegitation  	= 5,
				FarmLand    	= 5,
			},
			bonusMonths = { 9, 10, 11 },
		},
		Sapling = {
			type = "Base.Sapling",
			xp = 2,
			categories = { "Firewood" },
			zones = {
				DeepForest  	= 3,
				OrganicForest  	= 7,
				BirchForest  	= 3,
				PRForest  		= 3,
				PHForest  		= 3,
				Forest      	= 2,
				Vegitation  	= 1,
			},
			bonusMonths = { 9, 10, 11 },
		},
	};
	for itemName, itemDef in pairs(firewood) do
		forageSystem.addForageDef(itemName, itemDef);
	end;
end

generateFirewoodDefs();