--[[---------------------------------------------
-------------------------------------------------
--
-- generateForestRaritiesDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateForestRaritiesDefs()
	local forestRarities = {
		camper = {
			skill = 0,
			xp = 5,
			minCount = 1,
			maxCount = 1,
			items = {
-- 				["CampfireKit"]				= "Base.CampfireKit", -- the campfire kit is an obsolete item
				["CampingTentKit"]			= "Base.CampingTentKit2",
				["HottieZ"]					= "Base.HottieZ",
				["Tarp"]					= "Base.Tarp",
				["DryFirestarterBlock"]		= "Base.DryFirestarterBlock",
				["MagnesiumFirestarter"]	= "Base.MagnesiumFirestarter",
				["AxeStone"]				= "Base.AxeStone",
				["PercedWood"]				= "Base.PercedWood",
			},
		},
		trapper = {
			skill = 8,
			xp = 25,
			minCount = 1,
			maxCount = 1,
			items = {
				["TrapBox"]             = "Base.TrapBox",
				["TrapCage"]            = "Base.TrapCage",
				["TrapCrate"]           = "Base.TrapCrate",
				["TrapMouse"]           = "Base.TrapMouse",
				["TrapSnare"]           = "Base.TrapSnare",
				["TrapStick"]           = "Base.TrapStick",
			},
		},
		hiker = {
			skill = 8,
			xp = 25,
			minCount = 1,
			maxCount = 1,
			items = {
				["Bag_NormalHikingBag"] = "Base.Bag_NormalHikingBag",
				["Bag_BigHikingBag"]    = "Base.Bag_BigHikingBag",
				--["SteelAndFlint"]		= "Base.SteelAndFlint",
				--["SteelKnuckle"]		= "Base.SteelKnuckle",
				["CanteenCowboy"]		= "Base.CanteenCowboy",
				["CanteenMilitary"]		= "Base.CanteenMilitary",
				--["CanoePadel"]			= "Base.CanoePadel",
				--["CanoePadelX2"]		= "Base.CanoePadelX2",
			},
		},
		miner = {
			skill = 7,
			xp = 25,
			minCount = 1,
			maxCount = 1,
			items = {
				["IronOre"]				= "Base.IronOre",
			},
		},
	};
	for _, spawnTable in pairs(forestRarities) do
		for itemName, itemFullName in pairs(spawnTable.items) do
			forageSystem.addForageDef(
				itemName,
				{
					type = itemFullName,
					minCount = spawnTable.minCount,
					maxCount = spawnTable.maxCount;
					skill = spawnTable.skill,
					xp = spawnTable.xp,
					categories = { "ForestRarities" },
					zones = {
						BirchForest = 1,
						DeepForest = 1,
						Forest = 1,
						OrganicForest = 1,
						PHForest = 1,
						PRForest = 1,
					},
				}
			);
		end;
	end;
end

generateForestRaritiesDefs();