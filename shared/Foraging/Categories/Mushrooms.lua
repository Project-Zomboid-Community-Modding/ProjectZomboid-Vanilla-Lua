--[[---------------------------------------------
-------------------------------------------------
--
-- generateMushroomDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";

local function generateMushroomDefs()
	local items = {
		generic = {
			chance = 15,
			poisonChance = 10,
			poisonPowerMin = 5,
			poisonPowerMax = 50,
			poisonDetectionLevel = 5,
			spawnFuncs = { forageSystem.doPoisonItemSpawn, forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
			items = {
				MushroomGeneric7 = "Base.MushroomGeneric7",
				MushroomGeneric6 = "Base.MushroomGeneric6",
				MushroomGeneric5 = "Base.MushroomGeneric5",
				MushroomGeneric4 = "Base.MushroomGeneric4",
				MushroomGeneric3 = "Base.MushroomGeneric3",
				MushroomGeneric2 = "Base.MushroomGeneric2",
				MushroomGeneric1 = "Base.MushroomGeneric1",
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
				categories = { "Mushrooms" },
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
				poisonChance = spawnTable.poisonChance,
				poisonPowerMin = spawnTable.poisonPowerMin,
				poisonPowerMax = spawnTable.poisonPowerMax,
				poisonDetectionLevel = spawnTable.poisonDetectionLevel,
			};
		end;
	end;
end

generateMushroomDefs();
