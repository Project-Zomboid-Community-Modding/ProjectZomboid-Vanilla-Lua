--[[---------------------------------------------
-------------------------------------------------
--
-- generateHerbDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";

local function generateHerbDefs()
	local items = {
		generic = {
			chance = 1,
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
			items = {
				Basil		= "Base.Basil",
				Chives		= "Base.Chives",
				Cilantro	= "Base.Cilantro",
				Oregano		= "Base.Oregano",
				Parsley		= "Base.Parsley",
				Rosemary	= "Base.Rosemary",
				Sage		= "Base.Sage",
				Thyme		= "Base.Thyme",
			},
		},
	};
	for _, spawnTable in pairs(items) do
		for itemName, itemFullName in pairs(spawnTable.items) do
			forageDefs[itemName] = {
				type = itemFullName,
				minCount = 1,
				maxCount = 3,
				xp = 5,
				rainChance = 15,
				categories = { "WildHerbs" },
				zones = {
					Forest      = spawnTable.chance,
					DeepForest  = spawnTable.chance,
					Vegitation  = spawnTable.chance,
					FarmLand    = spawnTable.chance,
					Farm        = spawnTable.chance,
					TrailerPark = spawnTable.chance,
					TownZone    = spawnTable.chance,
					ForagingNav = spawnTable.chance,
				},
				months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
				bonusMonths = { 8, 9, 10 },
				malusMonths = { 3, 4 },
				spawnFuncs = spawnTable.spawnFuncs,
			};
		end;
	end;
end

generateHerbDefs();
