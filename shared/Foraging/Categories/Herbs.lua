require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateHerbDefs()
	local items = {
		generic = {
			chance = 1,
			items = {
				Basil		= "Base.Basil",
				Chives		= "Base.Chives",
				Cilantro	= "Base.Cilantro",
				Oregano		= "Base.Oregano",
				Parsley		= "Base.Parsley",
				Rosemary	= "Base.Rosemary",
				Sage		= "Base.Sage",
				Thyme		= "Base.Thyme",
				Chamomile	= "Base.Chamomile",
				Lavender	= "Base.Lavender",
				MintHerb	= "Base.MintHerb",
			},
			spawnFuncs = {
				forageSystem.doWildFoodSpawn,
				forageSystem.doRandomAgeSpawn,
				forageSystem.doWildCropSpawn,
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
					maxCount = 3,
					xp = 5,
					rainChance = 15,
					categories = { "WildHerbs" },
					zones = {
						BirchForest = spawnTable.chance,
						DeepForest = spawnTable.chance,
						FarmLand = spawnTable.chance,
						ForagingNav = spawnTable.chance,
						Forest = spawnTable.chance,
						OrganicForest = spawnTable.chance,
						PHForest = spawnTable.chance,
						PRForest = spawnTable.chance,
						TownZone = spawnTable.chance,
						TrailerPark = spawnTable.chance,
						Vegitation = spawnTable.chance,
					},
					months = { 3, 4, 5, 6, 7, 8, 9, 10, 11 },
					bonusMonths = { 8, 9, 10 },
					malusMonths = { 3, 4 },
					spawnFuncs = spawnTable.spawnFuncs,
					altWorldTexture = forageSystem.worldSprites.wildPlants,
				}
			);
		end;
	end;
end

generateHerbDefs();
