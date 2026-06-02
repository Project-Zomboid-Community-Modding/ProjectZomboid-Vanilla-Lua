require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateBerryDefs()
	local items = {
		generic = {
			chance = 15,
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			poisonChance = 5,
			poisonPowerMin = 1,
			poisonPowerMax = 10,
			poisonDetectionLevel = 5,
			spawnFuncs = { forageSystem.doPoisonItemSpawn, forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
			items = {
				BerryGeneric5 = "Base.BerryGeneric5",
				BerryGeneric4 = "Base.BerryGeneric4",
				BerryGeneric3 = "Base.BerryGeneric3",
				BerryGeneric2 = "Base.BerryGeneric2",
				BerryGeneric1 = "Base.BerryGeneric1",
				BerryPoisonIvy = "Base.BerryPoisonIvy",
			},
		},
		--safe berries
		specific = {
			chance = 10,
			months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
			poisonChance = 0,
			poisonPowerMin = 0,
			poisonPowerMax = 0,
			poisonDetectionLevel = 0,
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
			items = {
				BerryBlack = "Base.BerryBlack",
				BerryBlue = "Base.BerryBlue",
			},
		},
		winter = {
			chance = 10,
			months = { 1, 2, 3, 9, 10, 11, 12 },
			poisonChance = 0,
			poisonPowerMin = 0,
			poisonPowerMax = 0,
			poisonDetectionLevel = 0,
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn },
			items = {
				BeautyBerry = "Base.BeautyBerry",
				WinterBerry = "Base.WinterBerry",
			},
		},
		--poison berry
		poison = {
			chance = 10,
			months = { 1, 2, 3, 9, 10, 11, 12 },
			poisonChance = 1000, --ensure the chance will not be affected by skill
			poisonPowerMin = 5,
			poisonPowerMax = 10,
			poisonDetectionLevel = 5,
			spawnFuncs = { forageSystem.doWildFoodSpawn, forageSystem.doRandomAgeSpawn, forageSystem.doPoisonItemSpawn },
			items = {
				HollyBerry = "Base.HollyBerry",
			},
		},
	};
	for _, spawnTable in pairs(items) do
		for itemName, itemFullName in pairs(spawnTable.items) do
			forageSystem.addForageDef(
				itemName,
				{
				type = itemFullName,
				minCount = 1,
				maxCount = 4,
				xp = 5,
				snowChance = -10,
				categories = { "Berries" },
				zones = {
					BirchForest 	= spawnTable.chance,
					DeepForest  	= spawnTable.chance,
					FarmLand    	= spawnTable.chance,
					ForagingNav 	= spawnTable.chance,
					Forest      	= spawnTable.chance,
					OrganicForest	= spawnTable.chance,
					PHForest  		= spawnTable.chance,
					PRForest  		= spawnTable.chance,
					Vegitation  	= spawnTable.chance,
				},
				months = spawnTable.months,
				bonusMonths = { 5, 6, 7 },
				malusMonths = { 3, 4 },
				spawnFuncs = spawnTable.spawnFuncs,
				poisonChance = spawnTable.poisonChance,
				poisonPowerMin = spawnTable.poisonPowerMin,
				poisonPowerMax = spawnTable.poisonPowerMax,
				poisonDetectionLevel = spawnTable.poisonDetectionLevel,
				altWorldTexture = forageSystem.worldSprites.berryBushes,
				itemSizeModifier = 1.0,
				}
			);
		end;
	end;
end

generateBerryDefs();
