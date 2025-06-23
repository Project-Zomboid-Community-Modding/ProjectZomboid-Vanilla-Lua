--[[---------------------------------------------
-------------------------------------------------
--
-- generateMedicalDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateMedicalDefs()
	local medical = {
		uncommon = {
			chance = 50,
			xp = 5,
			items = {
				["BandageDirty"]            = "Base.BandageDirty",
				["Bandaid"]                 = "Base.Bandaid",
				["CottonBalls"]             = "Base.CottonBalls",
				["RippedSheets"]            = "Base.RippedSheets",
				["RippedSheetsDirty"]       = "Base.RippedSheetsDirty",
				["Thread"]                  = "Base.Thread",
			},
		},
		rare = {
			chance = 5,
			xp = 10,
			items = {
				["AlcoholBandage"]          = "Base.AlcoholBandage",
				["AlcoholRippedSheets"]     = "Base.AlcoholRippedSheets",
				["AlcoholWipes"]            = "Base.AlcoholWipes",
				["Bandage"]          		= "Base.Bandage",
				["Pills"]                   = "Base.Pills",
				["PillsAntiDep"]            = "Base.PillsAntiDep",
				["PillsBeta"]               = "Base.PillsBeta",
				["PillsSleepingTablets"]    = "Base.PillsSleepingTablets",
				["PillsVitamins"]           = "Base.PillsVitamins",
				["SutureNeedle"]            = "Base.SutureNeedle",
			},
		},
		legendary = {
			chance = 1,
			xp = 25,
			items = {
				["AlcoholedCottonBalls"]    = "Base.AlcoholedCottonBalls",
				["Antibiotics"]             = "Base.Antibiotics",
				["Disinfectant"]            = "Base.Disinfectant",
				["Splint"]                  = "Base.Splint",
				["SutureNeedleHolder"]      = "Base.SutureNeedleHolder",
				["Tweezers"]                = "Base.Tweezers",
			},
		},
	};
	for _, spawnTable in pairs(medical) do
		for itemName, itemFullName in pairs(spawnTable.items) do
			forageSystem.addForageDef(
				itemName,
				{
					type = itemFullName,
					skill = 0,
					xp = spawnTable.xp,
					categories = { "Medical" },
					zones = {
						Vegitation = spawnTable.chance,
						TrailerPark = spawnTable.chance,
						TownZone = spawnTable.chance,
						ForagingNav = spawnTable.chance,
					},
					spawnFuncs = { forageSystem.doGenericItemSpawn },
					forceOutside = false,
					canBeAboveFloor = true,
					itemSizeModifier = 0.5,
					isItemOverrideSize = true,
				}
			);
		end;
	end;
end

generateMedicalDefs();