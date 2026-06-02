require "Foraging/forageSystem";

forageSystem.defaultDefinitions = {
	defaultItemDef = {
		type                    = "Base.MissingItemType",                       --item type including module
		minCount                = 1,                                            --minimum amount of items to pick up
		maxCount                = 1,                                            --maximum amount of items to pick up
		skill                   = 0,                                            --skill level required to see the item
		perks                   = { "PlantScavenging" },                        --perks required - can be multiple perks, skill level will be averaged
		xp                      = 1,                                            --xp reward on pickup - divide by 3 for spotting xp - is awarded to all perks required
		--
		recipes                 = {},                                           --recipes required to see the item
		traits                  = {},                                           --traits required to see the item
		itemTags                = {},                                           --itemTags required to see the item (digPlow etc)
		--
		categories              = { "Junk" },                                   --categories the item is a part of
		rainChance              = 0,                                            --rain chance modifier (percent)
		hasRainedChance         = 0,                                            --after rain chance modifier (percent)
		snowChance              = 0,                                            --snow chance modifier (percent)
		dayChance               = 0,                                            --day chance modifier (percent)
		nightChance             = 0,                                            --night chance modifier (percent)
		--
		zones = {                                                     			--zones where the item can be found
			Forest              = 1,                                            --[zone name] = number of rolls for item in this zone
			DeepForest          = 1,                                            --/!\ it is NOT a percent chance /!\
			Vegitation          = 1,
			FarmLand            = 1,
			Farm                = 1,
			TrailerPark         = 1,
			TownZone            = 1,
			Nav         		= 1,
			ForagingNav         = 1,
		},
		--
		months                  = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 },    --months when the item can be found
		validMonths             = {},    										--months when the item can be found
		bonusMonths             = {},                                           --months when the item is more common (must be in months)
		malusMonths             = {},                                           --months when the item is less common (must be in months)
		--
		spawnFuncs              = {},                                           --custom spawn function when item is picked up
		forceOutside            = true,                                         --item must be outside
		isOnWater               = false,                                        --item can be on water
		forceOnWater            = false,                                        --item must be on water
		canBeAboveFloor         = false,                                        --does nothing, ignored
		doIsoMarkerSprite       = nil,                                          --use a custom sprite/sprites for IsoMarker
		canBeOnTreeSquare       = true,                                         --can occupy the same square as an IsoTree
		--
		poisonChance            = 0,                                            --percent chance the item is poisoned
		poisonPowerMin          = 0,                                            --minimum amount of poison to apply
		poisonPowerMax          = 0,                                            --maximum amount of poison to apply
		poisonDetectionLevel    = 0,                                            --level required to detect the poison
		--
		itemSizeModifier        = 0,                                            --increase or decrease item weight in vision radius checking
		isItemOverrideSize      = false,                                        --use only itemSizeModifier in vision radius checking - not the real item weight
	},
	--- default values (applied if missing from zone definition)
	defaultZoneDef  = {
		name                    = "Unknown",                                    --zone type to attach this definition to - see objects.lua for possible zones
		densityMin              = 1,                                            --zone minimum icon density
		densityMax              = 1,                                            --zone maximum icon density
		refillPercent           = 1,                                            --percent of icons refilled per game day
		abundanceSetting        = "NatureAbundance",                            --sandbox setting used for icon density multiplier - see forageSystem.abundanceSettings
		containsBiomes			= {},				                            --loot tables contained within this zone. must be a valid loot table from another zone
	},
	--- default values (applied if missing from category definition)
	defaultCatDef = {
		chance                  = 0,                                            --rolls for this category - /!\ it is NOT a percent chance /!\
		name                    = "Unknown",                                    --category name used for forageSystem.catDef key
		typeCategory            = "Other",                                      --fuzzy category name - used for search window tooltip
		identifyCategoryPerk    = "PlantScavenging",                            --perk to identify category
		identifyCategoryLevel   = 0,                                            --perk level to identify category
		categoryHidden          = true,                                         --show exact category name in zone display window
		validFloors             = { "ANY" },                                    --valid floor types for items in this category - ANY is an override to allow all floors
		validFunc               = nil,                                          --can be used to provide your own valid function for floors - see forageSystem.isValidSquare
		--
		validMonths             = {},    										--months when the item can be found
		bonusMonths             = {},                                           --months when the item is more common (must be in months)
		malusMonths             = {},
		--
		rainChance              = 0,                                            --rain chance modifier (percent)
		hasRainedChance         = 0,                                            --after rain chance modifier (percent)
		snowChance              = 0,                                            --snow chance modifier (percent)
		dayChance               = 0,                                            --day chance modifier (percent)
		nightChance             = 0,                                            --night chance modifier (percent)
		zones = {                                                          		--zones where the category can be found
			Forest              = 0,                                            --[zone name] = number of rolls for category in this zone
			DeepForest          = 0,                                            --/!\ it is NOT a percent chance /!\
			Vegitation          = 0,
			FarmLand            = 0,
			Farm                = 0,
			TrailerPark         = 0,
			TownZone            = 0,
			ForagingNav         = 0,
			PHForest     		= 0,
			PRForest     		= 0,
			OrganicForest  		= 0,
			BirchForest  		= 0,
		},
		spriteAffinities        = {},                                           --sprite affinities for this item - see Stones/Twigs category for example
		chanceToMoveIcon        = 0.0,                                          --percent chance to move a nearby icon to the sprite detected
		chanceToCreateIcon      = 0.0,                                          --percent chance to generate a new temporary icon on a sprite affinity if no existing icons can be moved
		focusChanceMin			= 0.0,											--percent chance to change an icon to this category when it is the search focus category - this will be divided by the itemDef skill level
		focusChanceMax			= 0.0,											--percent chance to change an icon to this category when it is the search focus category - this will be divided by the itemDef skill level
	},
	--- default values (applied if missing from occupation/trait definition)
	defaultSkillDef = {
		name                    = "default",
		type                    = "trait",
		visionBonus             = 0,                                            -- bonus vision (squares)
		weatherEffect           = 0,                                            -- weather effect reduction (percent)
		darknessEffect          = 0,                                            -- darkness effect reduction (percent)
		specialisations         = {},                                           -- /!\ base /!\ vision bonus multipliers by category (percent)
		testFuncs               = {},                                           -- test functions for bonus/malus effects
	},
};
