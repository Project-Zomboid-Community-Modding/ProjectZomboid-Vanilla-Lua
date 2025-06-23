--[[---------------------------------------------
-------------------------------------------------
--
-- forageSystem
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------


--[[
MODDING FAQ:

[*] How do I add an item to be foraged?
	To add an item, it needs at least two things:
		-a category defined, with a chance in a zone, and:
		-an item definition, with a chance in a zone.

	To ease adding definitions, events are provided in forageSystem.init() before each step of table generation.
	The important step is getting the definitions into the table before generateLootTable() is called, or items will not be findable!

	The easiest way to add an item, is to:
	 -Create an itemDef (see addItemDef() for examples)
	 -Add a chance to the itemDef for the zones to find it in. (see addItemDef for examples)
	 -Make sure the category can be found in the zones you want it found in. (see addCatDef for examples)
	 -Insert them into the definition tables. There are two ways to do this provided:
	 	-For just a few itemDefs or for maximum control, use addItemDef() directly.
	 	-For a table of itemDefs, pass the table to populateItemDefs().

	 Events are provided before each step to allow overwriting definitions and preserving the order of operations.
	 	-When using the add<x>Def helpers, the first definition provided takes precedence.
	    -When using the populateItemDefs helper, the last definition added takes precedence.
			-If a definition exists, it will use the modifyItemDef helper function.
	    -When using any other populate<x>Defs helper other than populateItemDefs, it will skip existing entries.
	        -To overwrite entries, use the add<x>Def helpers.
		-Order of operations is important when definitions are added.

[*] Do I need to use the events and helpers? Can I just put data into the forage tables?
	Short answer: No. You can put data directly into the forage definition tables.
		-If it breaks, you may keep both halves.

	Long answer: Yes, it's highly recommended.
		-If the order of operations change the event should be moved along with that change inside of forageSystem.init().
		  -It provides a bit of extra insurance against updates changing the order.
		-Helper functions (add<x>Def) (populate<x>Defs) can help with backwards + forwards compatibility.
			-It provides a bit of extra insurance against table structure changes.
		-Please note: I cannot guarantee multiple mods will play nice together where they affect the same definitions.
]]




--if isServer() then return; end;
-------------------------------------------------
-------------------------------------------------
local table = table;
local math  = math;
-------------------------------------------------
-------------------------------------------------
local function iterList(_list)
	local list = _list;
	local size = list:size() - 1;
	local i = -1;
	return function()
		i = i + 1;
		if i <= size and not list:isEmpty() then
			return list:get(i), i;
		end;
	end;
end

local function isInRect(_x, _y, _x1, _x2, _y1, _y2)
	return (_x >= _x1 and _x <= _x2 and _y >= _y1 and _y <= _y2) or false;
end

local function clamp(_value, _min, _max)
	if _min > _max then _min, _max = _max, _min; end;
	return math.min(math.max(_value, _min), _max);
end

--[[--======== forageSystem ========--]]--

forageSystem = {
	isInitialised		 = false,
	-- definition tables
	itemDefs             = {}, -- item table
	catDefs    		     = {}, -- category definitions
	zoneDefs             = {}, -- zone definitions
	skillDefs            = {   -- occupation and trait bonus definitions
		occupation = {},
		trait      = {},
	},

	-- internal tables (pre-import)
	forageDefinitions	 = {},
	zoneDefinitions		 = {},
	categoryDefinitions	 = {},
	defaultDefinitions	 = {},

	-- forage system loot tables
	lootTable			 = {},  -- the loot table - see generateLootTable for structure
	lootTableMonth		 = 1,
	processedEntries	 = {},

	--tracking for rerolling icons
	currentMonth         = 0,
	currentTime          = "isDay",
	currentWeather       = "isNormal",
	--
	maxIconsPerZone      = 2000,-- maximum icons possible in any zone
	zoneDensityMulti     = 20,  -- default icon density value for all zones.
	-- sandbox settings
	abundanceSettings    = {
		NatureAbundance  = { -75, -50, 0, 50, 100 }, -- bonus percent density per zone
		OtherLoot        = { -100, -95, -75, -50, 0, 50, 100 }, -- bonus percent density per zone
	},
	-- extended chance settings (percents)
	monthBonus           = 50,  -- good forage months
	monthMalus           = -50, -- bad forage months
	-- vision settings (squares)
	levelBonus           = 0.5, -- bonus per perk level
	-- vision settings (radius multipliers)
	aimMultiplier		 = 1.33,    --multiply radius by this amount when aiming/looking around
	sneakMultiplier		 = 1.10,    --multiply radius by this amount when sneaking
	darkVisionRadius	 = 1.5,     --icon radius for dark squares (less than lightPenaltyCutoff)
	minVisionRadius      = 3.0,     --the minimum radius from center for vision checks (well lit squares)
	maxVisionRadius      = 10.0,    --the maximum radius from center for vision checks (before bonuses)
	visionRadiusCap      = 15.0,    --the maximum radius cap from center for vision checks (after bonuses)
	minimumSizeBonus     = 0.50,    --used in calculating bonus for item size

	-- foraging penalty
	endurancePenalty     = 0.015,
	fatiguePenalty       = -0.001,

	-- vision settings (percents) (search radius)
	lightPenaltyMax      = 95, -- darkness effect on search radius (light level)
	weatherPenaltyMax    = 75, -- weather effect (rain, fog, snow)
	exhaustionPenaltyMax = 75, -- exhaustion effect (endurance, fatigue)
	panicPenaltyMax      = 95, -- panic effect (fear, panic, stress)
	bodyPenaltyMax       = 75, -- body effect (drunk, pain, sickness, food sickness)
	clothingPenaltyMax   = 95, -- clothing effect (helmet, glasses, blindfolds)
	hungerBonusMax       = 50, -- hunger effect (finding food when hungry)
	effectReductionMax   = 75, -- maximum effect reduction from traits/occupation

	-- specific to lighting level - if penalty is higher than this, cannot spot anything (radius will still change)
	lightPenaltyCutoff	 = 50,

	clothingPenalties 	  = {  -- clothing vision penalties (percents)
		--unless it covers the eye area, it has no penalty
		--regular hats, bandanas, etc. have no penalty
		FullSuitHead    = 75,   --completely covers the head, face and eyes
		FullHat		    = 75,   --completely covers the head, face and eyes
		MaskFull	    = 50,   --covering the face and eyes but not head
		SCBA    	    = 50,   --covering the face and eyes but not head
		SCBAnotank	    = 50,   --covering the face and eyes but not head
		MaskEyes	    = 20,   --just covering the face but with eye holes
		Mask	        = 20,   --just covering the face but with eye holes
		Eyes		    = 2.5,  --small debuff for wearing sunglasses
		LeftEye		    = 2.5,  --yarr, eyepatches give a little debuff
		RightEye	    = 2.5,  --yarr, eyepatches give a little debuff
	};

	isForageableFuncs = {
		"isItemExist", "isValidMonthInternal", "isItemInZone", "hasNeededPerks",
		"hasNeededTraits",	"hasNeededRecipes",	 "hasRequiredItems",
	},

	-- base XP modifier for foraging (percent)
	globalXPModifier     = 800,

	-- diminishing base XP returns per level for foraging items below skill level (percent)
	levelXPModifier      = 5,

	-- alternate sprites used for world items in search mode
	worldSprites = {
		dogbane = { "d_plants_1_64" },
		wildPlants = {
			{ "d_plants_1_11" }, { "d_plants_1_12" }, { "d_plants_1_13" },
			{ "d_plants_1_14" }, { "d_plants_1_15" },
		},
		smallTrees = {
			{ "media/textures/Foraging/worldSprites/smallTree_worldSprite.png" },
			{ "media/textures/Foraging/worldSprites/smallTree2_worldSprite.png" },
		},
		berryBushes = {
			{ "f_bushes_1_4", "f_bushes_1_68", "f_bushes_1_84" },
			{ "f_bushes_1_4", "f_bushes_1_68", "f_bushes_1_88" },
		},
		bushes = {
			{ "f_bushes_1_64" }, { "f_bushes_1_65" }, { "f_bushes_1_66" },
		},
		shrubs = {
			{ "d_plants_1_19" }, { "d_plants_1_20" }, { "d_plants_1_21" },
			{ "d_plants_1_22" }, { "d_plants_1_23" }, { "f_bushes_1_68" },
			{ "f_bushes_1_77" }, { "f_bushes_1_78" },
		},
		vines = {
			{ "d_plants_1_38" }, { "d_plants_1_49" }, { "d_plants_1_50" },
		},
	},

	-- world sprite affinities used for forage definitions
	spriteAffinities = {
		genericPlants = {
			"d_generic_1_17", "d_generic_1_18", "d_generic_1_19",
			"d_generic_1_47", "d_generic_1_48", "d_generic_1_49",
			"d_generic_1_50", "d_generic_1_51", "d_generic_1_52",
			"d_generic_1_53", "d_generic_1_54", "d_generic_1_55",
			"d_generic_1_80", "d_generic_1_81", "d_generic_1_82",
			"d_generic_1_83", "d_generic_1_84",	"d_generic_1_85",
			"d_generic_1_86", "d_generic_1_87",
			"d_plants_1_0", "d_plants_1_1", "d_plants_1_2",
			"d_plants_1_3",	"d_plants_1_4",	"d_plants_1_5",
			"d_plants_1_6",	"d_plants_1_7",	"d_plants_1_8",
			"d_plants_1_9",	"d_plants_1_10", "d_plants_1_11",
			"d_plants_1_12", "d_plants_1_13", "d_plants_1_14",
			"d_plants_1_15", "d_plants_1_16", "d_plants_1_17",
			"d_plants_1_18", "d_plants_1_19", "d_plants_1_20",
			"d_plants_1_21", "d_plants_1_22", "d_plants_1_23",
			"d_plants_1_24", "d_plants_1_25", "d_plants_1_26",
			"d_plants_1_27", "d_plants_1_28", "d_plants_1_29",
			"d_plants_1_30", "d_plants_1_31", "d_plants_1_32",
			"d_plants_1_33", "d_plants_1_34", "d_plants_1_35",
			"d_plants_1_36", "d_plants_1_37", "d_plants_1_38",
			"d_plants_1_39", "d_plants_1_40", "d_plants_1_41",
			"d_plants_1_42", "d_plants_1_43", "d_plants_1_44",
			"d_plants_1_45", "d_plants_1_46", "d_plants_1_47",
			"d_plants_1_48", "d_plants_1_49", "d_plants_1_50",
			"d_plants_1_51", "d_plants_1_52", "d_plants_1_53",
			"d_plants_1_54", "d_plants_1_55", "d_plants_1_56",
			"d_plants_1_57", "d_plants_1_58", "d_plants_1_59",
			"d_plants_1_60", "d_plants_1_61", "d_plants_1_62",
			"d_plants_1_63",
		},
		specialPlants = {
			"d_generic_1_17", "d_generic_1_18", "d_generic_1_19",
			"d_generic_1_47", "d_generic_1_48", "d_generic_1_49",
			"d_generic_1_50", "d_generic_1_51", "d_generic_1_52",
			"d_generic_1_53", "d_generic_1_54", "d_generic_1_55",
			"d_generic_1_80", "d_generic_1_81", "d_generic_1_82",
			"d_generic_1_83", "d_generic_1_84", "d_generic_1_85",
			"d_generic_1_86", "d_generic_1_87",
		},
		firewood = {
			"d_generic_1_8", "d_generic_1_9", "d_generic_1_10",
			"d_generic_1_11", "d_generic_1_12", "d_generic_1_14",
			"d_generic_1_15", "d_generic_1_31", "d_generic_1_44",
			"d_generic_1_45",
		},
		trash = {
			"d_trash_0", "d_trash_1", "d_trash_2",
			"d_trash_3", "d_trash_4", "d_trash_5",
			"d_trash_6", "d_trash_7", "d_trash_8",
			"d_trash_9", "d_trash_10", "d_trash_11",
			"d_trash_12", "d_trash_13", "d_trash_14",
			"d_trash_15", "d_trash_16", "d_trash_17",
			"d_trash_18", "d_trash_19", "d_trash_20",
			"d_trash_21", "d_trash_22", "d_trash_23",
			"d_trash_24", "d_trash_25", "trash_01_0",
			"trash_01_1", "trash_01_2", "trash_01_3",
			"trash_01_4", "trash_01_5", "trash_01_6",
			"trash_01_7", "trash_01_8", "trash_01_9",
			"trash_01_10", "trash_01_11", "trash_01_12",
			"trash_01_16", "trash_01_17", "trash_01_18",
			"trash_01_19", "trash_01_20", "trash_01_21",
			"trash_01_22", "trash_01_23", "trash_01_24",
			"trash_01_25", "trash_01_26", "trash_01_27",
			"trash_01_28", "trash_01_29", "trash_01_30",
			"trash_01_31", "trash_01_32", "trash_01_33",
			"trash_01_34", "trash_01_35", "trash_01_36",
			"trash_01_37", "trash_01_38", "trash_01_39",
			"trash_01_40", "trash_01_41", "trash_01_42",
			"trash_01_43", "trash_01_44", "trash_01_45",
			"trash_01_46", "trash_01_47", "trash_01_48",
			"trash_01_49", "trash_01_50", "trash_01_51",
			"trash_01_52", "trash_01_53",
		},
		stones = {
			--stones on the ground
			"d_generic_1_13", "d_generic_1_22", "d_generic_1_23",
			"d_generic_1_24", "d_generic_1_25", "d_generic_1_40",
			"d_generic_1_41", "d_generic_1_42", "d_generic_1_43",
			--cracks in the road
			"floors_overlay_street_01_0", "floors_overlay_street_01_1", "floors_overlay_street_01_2",
			"floors_overlay_street_01_3", "floors_overlay_street_01_4", "floors_overlay_street_01_5",
			"floors_overlay_street_01_6", "floors_overlay_street_01_7", "floors_overlay_street_01_8",
			"floors_overlay_street_01_9", "floors_overlay_street_01_10", "floors_overlay_street_01_11",
			"floors_overlay_street_01_12", "floors_overlay_street_01_13", "floors_overlay_street_01_14",
			"floors_overlay_street_01_15", "floors_overlay_street_01_16", "floors_overlay_street_01_17",
			"floors_overlay_street_01_18", "floors_overlay_street_01_19", "floors_overlay_street_01_20",
			"floors_overlay_street_01_21", "floors_overlay_street_01_22", "floors_overlay_street_01_23",
			"floors_overlay_street_01_24", "floors_overlay_street_01_25", "floors_overlay_street_01_26",
			"floors_overlay_street_01_27", "floors_overlay_street_01_28", "floors_overlay_street_01_29",
			"floors_overlay_street_01_30", "floors_overlay_street_01_31", "floors_overlay_street_01_32",
			"floors_overlay_street_01_33", "floors_overlay_street_01_34", "floors_overlay_street_01_35",
			"floors_overlay_street_01_36", "floors_overlay_street_01_37", "floors_overlay_street_01_38",
			"floors_overlay_street_01_39", "floors_overlay_street_01_40", "floors_overlay_street_01_41",
			"floors_overlay_street_01_42", "floors_overlay_street_01_43", "floors_overlay_street_01_44",
			"floors_overlay_street_01_45", "floors_overlay_street_01_46", "floors_overlay_street_01_47",
			"floors_overlay_street_01_48", "floors_overlay_street_01_49", "floors_overlay_street_01_50",
			"floors_overlay_street_01_51", "floors_overlay_street_01_52", "floors_overlay_street_01_53",
			"floors_overlay_street_01_54", "floors_overlay_street_01_55", "floors_overlay_street_01_56",
			"floors_overlay_street_01_57", "floors_overlay_street_01_58", "floors_overlay_street_01_59",
			"floors_overlay_street_01_60", "floors_overlay_street_01_61", "floors_overlay_street_01_62",
			"floors_overlay_street_01_63", "blends_streetoverlays_01_0", "blends_streetoverlays_01_1",
			"blends_streetoverlays_01_2", "blends_streetoverlays_01_3", "blends_streetoverlays_01_4",
			"blends_streetoverlays_01_5", "blends_streetoverlays_01_6", "blends_streetoverlays_01_7",
			"blends_streetoverlays_01_8", "blends_streetoverlays_01_9", "blends_streetoverlays_01_10",
			"blends_streetoverlays_01_11", "blends_streetoverlays_01_12", "blends_streetoverlays_01_13",
			"blends_streetoverlays_01_14", "blends_streetoverlays_01_15", "blends_streetoverlays_01_16",
			"blends_streetoverlays_01_17", "blends_streetoverlays_01_18", "blends_streetoverlays_01_19",
			"blends_streetoverlays_01_20", "blends_streetoverlays_01_21", "blends_streetoverlays_01_22",
			"blends_streetoverlays_01_23", "blends_streetoverlays_01_24", "blends_streetoverlays_01_25",
			"blends_streetoverlays_01_26", "blends_streetoverlays_01_27", "blends_streetoverlays_01_28",
			"blends_streetoverlays_01_29", "blends_streetoverlays_01_30", "blends_streetoverlays_01_31",
			--larger boulders
			"boulders_0", "boulders_1", "boulders_2",
			"boulders_3", "boulders_4", "boulders_5",
			"boulders_6", "boulders_7",	"boulders_8",
			"boulders_9", "boulders_10", "boulders_11",
			"boulders_12", "boulders_13", "boulders_14",
			"boulders_15", "boulders_16", "boulders_17",
			"boulders_18", "boulders_19", "boulders_20",
			"boulders_21", "boulders_22", "boulders_23",
			"boulders_24", "boulders_25", "boulders_26",
			"boulders_27", "boulders_28", "boulders_29",
			"boulders_30", "boulders_31", "boulders_32",
			"boulders_33", "boulders_34", "boulders_35",
			--ore deposits stone/clay
			"crafting_ore_32", "crafting_ore_33", "crafting_ore_34", "crafting_ore_35",
			"crafting_ore_35", "crafting_ore_36", "crafting_ore_37", "crafting_ore_38",
			"crafting_ore_39", "crafting_ore_40", "crafting_ore_41", "crafting_ore_42",
			"crafting_ore_43", "crafting_ore_44", "crafting_ore_45", "crafting_ore_46",
			"crafting_ore_47", "crafting_ore_48", "crafting_ore_49",
		},
	},

	seedTable = {
		["Base.BarleySheaf"] = {
			["type"] = "Base.BarleySeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Basil"] = {
			["type"] = "Base.BasilSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.BellPepper"] = {
			["type"] = "Base.BellPepperSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.BlackSage"] = {
			["type"] = "Base.BlackSageSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Broccoli"] = {
			["type"] = "Base.BroccoliSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Cabbage"] = {
			["type"] = "Base.CabbageSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Carrots"] = {
			["type"] = "Base.CarrotSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Cauliflower"] = {
			["type"] = "Base.CauliflowerSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Chamomile"] = {
			["type"] = "Base.ChamomileSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Chives"] = {
			["type"] = "Base.ChivesSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Cilantro"] = {
			["type"] = "Base.CilantroSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Comfrey"] = {
			["type"] = "Base.ComfreySeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.CommonMallow"] = {
			["type"] = "Base.CommonMallowSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Corn"] = {
			["type"] = "Base.CornSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Cucumber"] = {
			["type"] = "Base.CucumberSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Flax"] = {
			["type"] = "Base.FlaxSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Garlic"] = {
			["type"] = "Base.GarlicSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Greenpeas"] = {
			["type"] = "Base.GreenpeasSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Kale"] = {
			["type"] = "Base.KaleSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Lavender"] = {
			["type"] = "Base.LavenderSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Leek"] = {
			["type"] = "Base.LeekSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.LemonGrass"] = {
			["type"] = "Base.LemonGrassSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Lettuce"] = {
			["type"] = "Base.LettuceSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Marigold"] = {
			["type"] = "Base.MarigoldSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.MintHerb"] = {
			["type"] = "Base.MintSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Onion"] = {
			["type"] = "Base.OnionSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Oregano"] = {
			["type"] = "Base.OreganoSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Parsley"] = {
			["type"] = "Base.ParsleySeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.PepperHabanero"] = {
			["type"] = "Base.HabaneroSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.PepperJalapeno"] = {
			["type"] = "Base.JalapenoSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Plantain"] = {
			["type"] = "Base.BroadleafPlantainSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.PoppyPods"] = {
			["type"] = "Base.PoppySeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Potato"] = {
			["type"] = "Base.PotatoSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.RedRadish"] = {
			["type"] = "Base.RedRadishSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Rosemary"] = {
			["type"] = "Base.RosemarySeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Roses"] = {
			["type"] = "Base.RoseSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.RyeSheaf"] = {
			["type"] = "Base.RyeSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Sage"] = {
			["type"] = "Base.SageSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Soybeans"] = {
			["type"] = "Base.SoybeansSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Spinach"] = {
			["type"] = "Base.SpinachSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Strewberrie"] = {
			["type"] = "Base.StrewberrieSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.SugarBeet"] = {
			["type"] = "Base.SugarBeetSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.SunflowerHead"] = {
			["type"] = "Base.SunflowerSeeds",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.SweetPotato"] = {
			["type"] = "Base.SweetPotatoSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Thyme"] = {
			["type"] = "Base.ThymeSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Tobacco"] = {
			["type"] = "Base.TobaccoSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Tomato"] = {
			["type"] = "Base.TomatoSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Turnip"] = {
			["type"] = "Base.TurnipSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Watermelon"] = {
			["type"] = "Base.WatermelonSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.WheatSheaf"] = {
			["type"] = "Base.WheatSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.WildGarlic2"] = {
			["type"] = "Base.WildGarlicSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
		["Base.Zucchini"] = {
			["type"] = "Base.ZucchiniSeed",
			["amount"] = 10,
			["chance"] = 75,
		},
	},
};

function forageSystem.integrityCheck()
	log(DebugType.Foraging, "[forageSystem][integrityCheck] checking all zoneData.");
	local zonesChecked = 0;
	local zonesRemoved = 0;
	local iconsChecked = 0;
	local iconsRemoved = 0;
	local isInRect = isInRect;
	local metaGrid = getWorld():getMetaGrid();
	local wx1, wx2, wy1, wy2 = metaGrid:getMinX() * 300, metaGrid:getMaxX() * 300, metaGrid:getMinY() * 300, metaGrid:getMaxY() * 300;
	for zoneID, zoneData in pairs(forageData) do
		local removeZone = false;
		local x1, x2, y1, y2;
		if zoneData.bounds then
			x1, x2, y1, y2 = zoneData.bounds.x1, zoneData.bounds.x2, zoneData.bounds.y1, zoneData.bounds.y2;
		end;
		if not forageSystem.zoneDefs[zoneData.name] then
			removeZone = true;
			log(DebugType.Foraging, "[forageSystem][integrityCheck] zoneDef does not exist for " .. (zoneData.name or "[no type]"));
			log(DebugType.Foraging, "[forageSystem][integrityCheck] removing zone " .. zoneID .. ".");
		elseif not (x1 and x2 and y1 and y2) then
			removeZone = true;
			log(DebugType.Foraging, "[forageSystem][integrityCheck] zoneDef does not have valid bounds " .. (zoneData.name or "[no type]"));
			log(DebugType.Foraging, "[forageSystem][integrityCheck] removing zone " .. zoneID .. ".");
		elseif not (isInRect(x1, y1, wx1, wx2, wy1, wy2) and isInRect(x2, y2, wx1, wx2, wy1, wy2)) then
			removeZone = true;
			log(DebugType.Foraging, "[forageSystem][integrityCheck] zone is outside the world boundary " .. (zoneData.name or "[no type]"));
			log(DebugType.Foraging, "[forageSystem][integrityCheck] removing zone " .. zoneID .. ".");
		end
		if not removeZone and not forageSystem.checkMetaZone(zoneData) then
			removeZone = true;
			log(DebugType.Foraging, "[forageSystem][integrityCheck] metagrid zone doesn't exist " .. (zoneData.name or "[no type]"));
			log(DebugType.Foraging, "[forageSystem][integrityCheck] removing zone " .. zoneID .. ".");
		end;
		if not removeZone then
			--ensure itemsLeft is within limits
			if zoneData.itemsLeft < 0 then zoneData.itemsLeft = 0; end;
			if zoneData.itemsLeft > zoneData.itemsTotal then zoneData.itemsLeft = zoneData.itemsTotal; end;
			--
			for iconID, iconData in pairs(zoneData.forageIcons) do
				local removeIcon = false;
				if not forageSystem.itemDefs[iconData.itemType] then removeIcon = true;
					log(DebugType.Foraging, "[forageSystem][integrityCheck] itemDef does not exist for " .. (iconData.itemType or "[no type]"));
					log(DebugType.Foraging, "[forageSystem][integrityCheck] removing icon " .. iconID .. ".");
				elseif not forageSystem.catDefs[iconData.catName] then removeIcon = true;
					log(DebugType.Foraging, "[forageSystem][integrityCheck] catDef does not exist for " .. (iconData.catName or "[no category]"));
					log(DebugType.Foraging, "[forageSystem][integrityCheck] removing icon " .. iconID .. ".");
				elseif not (iconData.x and iconData.y and iconData.z) then removeIcon = true;
					log(DebugType.Foraging, "[forageSystem][integrityCheck] icon has invalid or missing x/y/z location " .. iconID .. ".");
					log(DebugType.Foraging, "[forageSystem][integrityCheck] removing icon " .. iconID .. ".");
				elseif not isInRect(iconData.x, iconData.y, x1, x2,	y1, y2) then removeIcon = true;
					log(DebugType.Foraging, "[forageSystem][integrityCheck] icon is out of zone bounds " .. iconID .. ".");
					log(DebugType.Foraging, "[forageSystem][integrityCheck] removing icon " .. iconID .. ".");
				end;
				--
				if removeIcon then
					zoneData.forageIcons[iconID] = nil;
					iconsRemoved = iconsRemoved + 1;
				end;
				--
				iconsChecked = iconsChecked + 1;
			end;
		end;
		if removeZone then
			forageData[zoneID] = nil;
			zonesRemoved = zonesRemoved + 1;
		end;
		zonesChecked = zonesChecked + 1;
	end;
	log(DebugType.Foraging, "[forageSystem][integrityCheck] checked integrity of " .. zonesChecked .. " zones.");
	if zonesRemoved > 0 then
		log(DebugType.Foraging, "[forageSystem][integrityCheck] " .. zonesRemoved .. " zones failed integrity check and were removed.");
	else
		log(DebugType.Foraging, "[forageSystem][integrityCheck] all zones passed testing.");
	end;
	log(DebugType.Foraging, "[forageSystem][integrityCheck] checked integrity of " .. iconsChecked .. " icons.");
	if iconsRemoved > 0 then
		log(DebugType.Foraging, "[forageSystem][integrityCheck] " .. iconsRemoved .. " icons failed integrity check and were removed.");
	else
		log(DebugType.Foraging, "[forageSystem][integrityCheck] all icons passed testing.");
	end;
end

function forageSystem.doItemDefCheck(_doItemFile)
	log(DebugType.Foraging, "=============");
	log(DebugType.Foraging, "[forageSystem][doItemDefCheck] testing all items for missing forage definitions.");
	log(DebugType.Foraging, "=============");
	local allItems = getAllItems();
	local itemFullName;
	local fileWriterObj = getFileWriter("forageMissingItems.log", true, false);
	for item in iterList(allItems) do
		if not item:getObsolete() and not item:isHidden() then
			itemFullName = item:getFullName();
			if not forageSystem.itemDefs[itemFullName] then
				if _doItemFile then
					fileWriterObj:write(itemFullName.."\r\n");
				else
					log(DebugType.Foraging, itemFullName);
				end;
			end;
		end;
	end;
	fileWriterObj:close();
	log(DebugType.Foraging, "=============");
end

function forageSystem.clearTables()
	forageSystem.itemDefs = {};
	forageSystem.catDefs = {};
	forageSystem.zoneDefs = {};
	forageSystem.skillDefs = {occupation = {}, trait = {}};
end

function forageSystem.init()
	--prevent multiple initialisations
	if forageSystem.isInitialised then return; end;

	--clear all imported definition tables
	forageSystem.clearTables();

	triggerEvent("preAddForageDefs", forageSystem);
	forageSystem.setOptionValues();

	triggerEvent("preAddSkillDefs", forageSystem);
	forageSystem.populateSkillDefs();

	triggerEvent("preAddCatDefs", forageSystem);
	forageSystem.populateCatDefs();

	triggerEvent("preAddZoneDefs", forageSystem);
	forageSystem.populateZoneDefs();
	forageSystem.populateMixedZoneCategories();

	triggerEvent("preAddItemDefs", forageSystem);
	forageSystem.populateScavengeDefs();
	forageSystem.populateItemDefs();

	triggerEvent("onAddForageDefs", forageSystem);
	forageSystem.generateLootTable();

	--initialise forageData table
	if isClient() then
		forageClient.init();
		forageClient.updateData();
	end;

	--check integrity of forageData
	forageSystem.integrityCheck();
	--
	--these can also be called from the Lua debugger.
	--forageSystem.doItemDefCheck(); --list all items without forage definitions
	--forageSystem.statisticsDebug(); --generate spawn rates table on load.
	--forageSystem.createDebugLog(true); --create picker stats file (statisticsDebug.log) on load.

	--forageClient.clearData(); --debug clear forageData database
	--forageClient.syncForageData();
	--
	forageSystem.updateTimeValues();
	--
	Events.EveryHours.Add(forageSystem.recreateIcons);
	Events.EveryDays.Add(forageSystem.recreateIcons);
	Events.EveryDays.Add(forageSystem.lootTableUpdate);
	Events.OnWeatherPeriodStart.Add(forageSystem.recreateIcons);
	Events.OnWeatherPeriodStage.Add(forageSystem.recreateIcons);
	Events.OnWeatherPeriodComplete.Add(forageSystem.recreateIcons);
	--
	forageSystem.isInitialised = true;
end

Events.OnLoadedMapZones.Add(forageSystem.init);

function forageSystem.setOptionValues()
	--any needed sandbox and server option values should be initialised here
	forageSystem.itemBlacklist = getSandboxOptions():getOptionByName("LootItemRemovalList"):getSplitCSVList();
end

--[[---------------------------------------------
--
-- zoneData
--
--]]---------------------------------------------

--[[--======== createZoneData ========--
	@param _forageZone
	@param _zoneDef
]]--

function forageSystem.createZoneData(_forageZone, _zoneDef)
	local zoneData = {};
	--
	zoneData.id             = _forageZone:getName();
	_forageZone:setName(zoneData.id);
	_forageZone:setOriginalName(zoneData.id);
	zoneData.name           = _zoneDef.name;
	zoneData.x              = _forageZone:getX();
	zoneData.y              = _forageZone:getY();
	zoneData.size           = _forageZone:getWidth() * _forageZone:getHeight();
	zoneData.bounds         = {
		x1			    = zoneData.x,
		y1			    = zoneData.y,
		x2			    = zoneData.x + _forageZone:getWidth(),
		y2			    = zoneData.y + _forageZone:getHeight(),
	};
	zoneData.itemsTotal     = 0;
	zoneData.itemsLeft      = 0;
	zoneData.forageIcons    = {};
	forageSystem.checkMetaZone(zoneData);
	--
	forageSystem.fillZone(zoneData);
	forageClient.addZone(zoneData);
	--
	return zoneData;
end

function forageSystem.checkMetaZone(_zoneData)
	if _zoneData.metaZone then return true end
	local metaGrid = getWorld():getMetaGrid();
	local bounds = _zoneData.bounds;
	local zone = metaGrid:getZoneWithBoundsAndType(bounds.x1, bounds.y1, 0, bounds.x2 - bounds.x1, bounds.y2 - bounds.y1, _zoneData.name);
	if zone ~= nil then
		_zoneData.size = zone:getTotalArea();
		_zoneData.metaZone = zone;
		return true;
	end
	return false;
end

function forageSystem.zoneContains(_zoneData, _x, _y, _z)
	if not _zoneData or not _zoneData.metaZone then return false; end;
	return _zoneData.metaZone:contains(_x, _y, _z);
end

function forageSystem.zoneIntersects(_zoneData, _x, _y, _z, _w, _h)
	if not _zoneData or not _zoneData.metaZone then return false; end;
	return _zoneData.metaZone:intersects(_x, _y, _z, _w, _h);
end

function forageSystem.fillZone(_zoneData)
	local zoneDef = forageSystem.zoneDefs[_zoneData.name];
	local refillValue = zoneDef.densityMin;
	if zoneDef.densityMin ~= zoneDef.densityMax then
		refillValue = ZombRandFloat(zoneDef.densityMin, zoneDef.densityMax * forageSystem.getRefillBonus(_zoneData));
	end;
	refillValue = math.floor((_zoneData.size / (forageSystem.zoneDensityMulti * 100)) * refillValue);
	--roll for up to 3 bonus items if the zone would otherwise be empty
	if (refillValue < 1) and (ZombRand(100) <= 10) then refillValue = (ZombRand(3) + 1); end;
	_zoneData.itemsLeft = refillValue;
	_zoneData.itemsTotal = _zoneData.itemsLeft;
	_zoneData.lastRefill = forageSystem.getWorldAge();
end

--[[--======== checkRefillZone ========--
	@param _zoneData
]]--

function forageSystem.checkRefillZone(_zoneData)
	--don't refill zones which are active/seen today
	--local zones = getZones(_zoneData.x, _zoneData.y, 0);
	--for zone in iterList(zones) do
	--	if zone:getType() == "ForageZone" then
	--		if zone:getHoursSinceLastSeen() <= 24 then
	--			return;
	--		end;
	--	end;
	--end;
	--
	local worldAge = forageSystem.getWorldAge();
	local zoneDef = forageSystem.zoneDefs[_zoneData.name];
	if zoneDef then
		if _zoneData.itemsTotal > _zoneData.itemsLeft then
			local lastRefillDays = math.floor((worldAge - _zoneData.lastRefill) / 24);
			local refillAmount = _zoneData.itemsTotal * (lastRefillDays * (zoneDef.refillPercent / 100));
			if refillAmount >= 1 then
				_zoneData.itemsLeft = math.floor(_zoneData.itemsLeft + refillAmount);
				if _zoneData.itemsLeft > _zoneData.itemsTotal then _zoneData.itemsLeft = _zoneData.itemsTotal; end;
				_zoneData.lastRefill = worldAge
			end;
		elseif _zoneData.itemsTotal <= _zoneData.itemsLeft then
			--if the zone is full or has too many items, re-roll the density and icons
			forageSystem.fillZone(_zoneData);
		end;
		forageSystem.updateZone(_zoneData);
	end;
end

--[[--======== updateZone ========--]]--

function forageSystem.updateZone(_zoneData)
	_zoneData.lastAction = forageSystem.getWorldAge();
	forageClient.updateZone(_zoneData);
end

--[[--======== takeItem ========--
	@param _zoneData
	@param _number - (optional) number of items to take

	Returns number of forages remaining
]]--

function forageSystem.takeItem(_zoneData, _number)
	local number = _number or 1;
	_zoneData.itemsLeft = clamp(_zoneData.itemsLeft - number, 0, _zoneData.itemsLeft);
	forageClient.updateZone(_zoneData);
	return _zoneData.itemsLeft;
end

function forageSystem.getWorldAge()
	return getGameTime():getWorldAgeHours();
end

--[[--======== statisticsDebug ========--
	Gathers and stores item spawn statistics for every loot table

	For debugging and balancing loot rates.
--]]--

--[[
function forageSystem.statisticsDebug(_createDebugLog, _doItemStats)
	forageSystem.statisticsTable = {zones = {}};
	local categoryTable = {};
	local itemTable = {};
	for zoneName, zoneLoot in pairs(forageSystem.lootTable) do
		forageSystem.statisticsTable.zones[zoneName] = {};
		forageSystem.statisticsTable.zones[zoneName] = {};
		categoryTable = {};
		for _, categoryLoot in ipairs(zoneLoot) do
			itemTable = {};
			if (not forageSystem.statisticsTable.zones[zoneName][categoryLoot.category]) then
				forageSystem.statisticsTable.zones[zoneName][categoryLoot.category] = {
					items = {},
					chance = 0;
				};
				for __, itemLoot in ipairs(categoryLoot.items) do
					itemTable[itemLoot] = (itemTable[itemLoot] or 0) + 1;
					forageSystem.statisticsTable.zones[zoneName][categoryLoot.category].items[itemLoot] = (itemTable[itemLoot] / #categoryLoot.items);
				end;
			end;
			categoryTable[categoryLoot.category] = (categoryTable[categoryLoot.category] or 0) + 1;
			forageSystem.statisticsTable.zones[zoneName][categoryLoot.category].chance = (categoryTable[categoryLoot.category] / #zoneLoot);
		end;
	end;
	if _createDebugLog then
		forageSystem.createDebugLog(_doItemStats);
	end;
end

function forageSystem.createDebugLog(_doItemStats)
	local fileWriterObj = getFileWriter("statisticsDebug.log", true, false);
	local itemDef, totalCategoryChance;
	for zoneName, zoneLoot in pairs(forageSystem.statisticsTable.zones) do
		fileWriterObj:write("-------\r\n"..zoneName.."\r\n-------\r\n" );
		for categoryName, categoryLoot in pairs(zoneLoot) do
			fileWriterObj:write("\r\nCategory = "..categoryName.." = " .. string.format("%.2f", categoryLoot.chance * 100).. "%\r\n");
			if _doItemStats then
				for itemName, itemChance in pairs(categoryLoot.items) do
					totalCategoryChance = 0;
					itemDef = forageSystem.itemDefs[itemName];
					for _, itemCategory in ipairs(itemDef.categories) do
						totalCategoryChance = totalCategoryChance + weatherLoot[itemCategory].chance;
					end;
					fileWriterObj:write(
						"    Item = "..itemName.." = "
						.. string.format("%.2f", itemChance * 100) .. "% = ["
						.. string.format("%.6f", (itemChance * categoryLoot.chance) * 100) .. "%] = ("
						.. string.format("%.6f", (itemChance * totalCategoryChance) * 100) .. "%)\r\n"
					);
				end;
			end;
			fileWriterObj:write("\r\n\r\n\r\n\r\n");
		end;
	end;
	fileWriterObj:write("\r\n");
	fileWriterObj:close();
end
--]]--

--[[--======== createForageIcons ========--
	@param _zoneData
	@param _recreate
	@param _count - number of items to create
]]--

function forageSystem.createForageIcons(_zoneData, _recreate, _count)
	local maxIconsPerZone = forageSystem.maxIconsPerZone;
	local count = _count or maxIconsPerZone;
	local forageIcons = {};
	--
	if _recreate then _zoneData.forageIcons = {}; end;
	--
	for _, icon in pairs(_zoneData.forageIcons) do
		if forageSystem.itemDefs[icon.itemType] then
			table.insert(forageIcons, icon);
		else
			log(DebugType.Foraging, "[forageSystem][createForageIcons] itemDef not defined for itemType, skipping " .. icon.itemType);
		end;
	end;
	if (not _zoneData) or (not _zoneData.name) or (not forageSystem.zoneDefs[_zoneData.name]) then
		log(DebugType.Foraging, "[forageSystem][createForageIcons] zoneDef not defined for zoneData type, skipping " .. _zoneData.name or "undefined");
		return forageIcons;
	end;
	--
	local zoneName = _zoneData.name;
	--
	if not forageSystem.lootTable[zoneName] then
		log(DebugType.Foraging, "[forageSystem][createForageIcons] a loot table is not generated for " .. zoneName);
		return forageIcons;
	end;
	--
	local itemsLeft = math.floor(_zoneData.itemsLeft);
	--
	if itemsLeft > 0 and #forageIcons < itemsLeft then
		local i = 0;
		local rX;
		local rY;
		local forageIcon;
		local itemType;
		local catName;
		local zoneid = _zoneData.id;
		local location = Location.new();
		local getRandomUUID = getRandomUUID;
		--
		repeat
			itemType, catName = forageSystem.pickRandomItemType(zoneName);
			if itemType and catName then
				location = _zoneData.metaZone:pickRandomLocation(location);
				if location then
					rX, rY = location:getX(), location:getY()
					forageIcon = {
						id = getRandomUUID(),
						zoneid = zoneid,
						x = rX,
						y = rY,
						z = 0,
						catName = catName,
						itemType = itemType,
						isBonusIcon = false,
					};
					table.insert(forageIcons, forageIcon);
					_zoneData.forageIcons[forageIcon.id] = forageIcon;
				end
			end;
			i = i + 1;
		until
			i >= count
			or i >= maxIconsPerZone
			or #forageIcons >= maxIconsPerZone
			or #forageIcons >= itemsLeft
	end;
	forageClient.updateZone(_zoneData);
	return forageIcons;
end

function forageSystem.updateTimeValues()
	forageSystem.currentMonth = (getGameTime():getMonth() + 1);
	forageSystem.currentTime = forageSystem.getTimeOfDay();
	forageSystem.currentWeather = forageSystem.getWeatherType();
end

function forageSystem.checkIfRecreateIcons()
 return forageSystem.currentMonth ~= (getGameTime():getMonth() + 1)
    or  forageSystem.currentTime ~= forageSystem.getTimeOfDay()
    or  forageSystem.currentWeather ~= forageSystem.getWeatherType();
end

function forageSystem.recreateIcons()
	if forageSystem.checkIfRecreateIcons() then
		local icon, removeIcon;
		for zoneID, zoneData in pairs(forageData) do
			if (not zoneData.forageIcons) then zoneData.forageIcons = {}; end;
			for iconID in pairs(zoneData.forageIcons) do
				removeIcon = true;
				for _, manager in pairs(ISSearchManager.players) do
					if manager and manager.isSearchMode then
						icon = manager.forageIcons[iconID];
						if icon and (icon:getIsSeen() or icon:getIsNoticed()) then
							removeIcon = false;
							icon.isNoticed = false;
						end;
					end;
				end;
				if removeIcon then
					triggerEvent("onUpdateIcon", zoneData, iconID, nil);
					zoneData.forageIcons[iconID] = nil;
				end;
			end;
			for _, manager in pairs(ISSearchManager.players) do
				if manager and manager.isSearchMode and manager.activeZones[zoneID] ~= nil then
					manager.activeZones[zoneID] = nil;
				end;
			end;
			forageSystem.checkRefillZone(zoneData);
			forageClient.updateZone(zoneData);
		end;
	end;
	--
	forageSystem.updateTimeValues();
end

function forageSystem.debugRefreshAllZones()
	for zoneID, zoneData in pairs(forageData) do
		if (not zoneData.forageIcons) then zoneData.forageIcons = {}; end;
		forageSystem.debugRefreshZone(zoneData)
		forageSystem.checkRefillZone(zoneData);
		forageClient.updateZone(zoneData);
	end;
	--update tracking values
	forageSystem.updateTimeValues();
end

function forageSystem.debugRefreshZone(_zoneData)
	local zoneData = _zoneData;
	if (not zoneData.forageIcons) then zoneData.forageIcons = {}; end;
	for iconID in pairs(zoneData.forageIcons) do
		triggerEvent("onUpdateIcon", zoneData, iconID, nil);
		zoneData.forageIcons[iconID] = nil;
	end;
	forageSystem.fillZone(zoneData);
	forageClient.updateZone(zoneData);
	forageSystem.updateTimeValues();
end

--[[--======== getZoneData ========--]]--

function forageSystem.getZoneData(_forageZone, _zoneDef, _x, _y)
	if not _forageZone then return nil; end;
	if _forageZone:getType() == "ForageZone" then
		local zoneData = forageData[_forageZone:getName()];
		if zoneData then
			forageClient.updateZone(zoneData);
			return zoneData;
		else
			if _zoneDef then
				log(DebugType.Foraging, "[forageSystem][getZoneData] zoneData will be initialised for ".. _forageZone:getType());
				return forageSystem.createZoneData(_forageZone, _zoneDef);
			end;
			if _x and _y then
				local defZone, zoneDef = forageSystem.getDefinedZoneAt(_x, _y);
				if (defZone and zoneDef) then
					log(DebugType.Foraging, "[forageSystem][getZoneData] zoneData will be initialised for ".. _forageZone:getType());
					return forageSystem.createZoneData(_forageZone, zoneDef);
				end;
			end;
		end;
	else
		log(DebugType.Foraging, "[forageSystem][getZoneData] tried to get zoneData for non scavenge zone: ".. _forageZone:getType());
	end;
	log(DebugType.Foraging, "[forageSystem][getZoneData] zoneData not found, removing ".. _forageZone:getType());
	return nil;
end

--[[---------------------------------------------
--
-- lootTable
--
--]]---------------------------------------------

function forageSystem.getCurrentLootEntries(_zoneName)
	local zoneName = _zoneName;
	local month = getGameTime():getMonth() + 1;
	local timeOfDay = forageSystem.getTimeOfDay();
	local weatherType = forageSystem.getWeatherType();
	--
	if not forageSystem.processedEntries[zoneName] then
		forageSystem.processedEntries[zoneName] = {};
	end;
	if not forageSystem.processedEntries[zoneName][month] then
		forageSystem.processedEntries[zoneName][month]  = {};
	end;
	if not forageSystem.processedEntries[zoneName][month][timeOfDay] then
		forageSystem.processedEntries[zoneName][month][timeOfDay]  = {};
	end;
	if not forageSystem.processedEntries[zoneName][month][timeOfDay][weatherType] then
		forageSystem.processedEntries[zoneName][month][timeOfDay][weatherType]  = {};
	end;
	return forageSystem.processedEntries[zoneName][month][timeOfDay][weatherType];
end

function forageSystem.processEntries(_zoneName, _lootTable)
	local totalRolls = 0;
	local thisChance = 0;
	local entries = {};

	local month = getGameTime():getMonth() + 1;
	local rainAmount = getClimateManager():getPrecipitationIntensity();
	local puddleAmount = getPuddlesManager():getPuddlesSize();
	local snowAmount = getClimateManager():getSnowStrength();
	local isDay = forageSystem.getTimeOfDay();

	for name, entry in pairs(_lootTable) do
		thisChance =
			entry.definition.zones[_zoneName]
			* forageSystem.getMonthMulti(entry.definition, month)
			* forageSystem.getWeatherMulti(entry.definition, rainAmount, puddleAmount, snowAmount)
			* forageSystem.getTimeOfDayBonus(entry.definition, isDay)
		totalRolls = totalRolls + thisChance;
		entries[name] = {
			roll = totalRolls,
			definition = entry.definition,
		};
	end;
	return entries, totalRolls;
end

function forageSystem.pickRandomItemType(_zoneName, _rolledCategory)
	local zoneName = _zoneName;

	local lootTable = forageSystem.lootTable[zoneName];

	if lootTable then
		local processedEntries = forageSystem.getCurrentLootEntries(zoneName);

		if not processedEntries[zoneName] then
			local categories, totalRolls = forageSystem.processEntries(zoneName, lootTable.categories);
			processedEntries[zoneName] = categories;
			processedEntries[zoneName].totalRolls = totalRolls;
		end;

		local roll;
		local rolledCategory = _rolledCategory;
		if not rolledCategory then
			roll = processedEntries[zoneName].totalRolls * ZombRandFloat(0.0, 1.0);
			for categoryName, category in pairs(processedEntries[zoneName]) do
				if roll <= category.roll then
					rolledCategory = categoryName;
					break;
				end;
			end;
		end;

		if rolledCategory and lootTable.categories[rolledCategory] then
			if not processedEntries[zoneName][rolledCategory].items then
				local items, totalRolls = forageSystem.processEntries(zoneName, lootTable.categories[rolledCategory].items);
				processedEntries[zoneName][rolledCategory].items = items;
				processedEntries[zoneName][rolledCategory].totalRolls = totalRolls;
			end;

			roll = processedEntries[zoneName][rolledCategory].totalRolls * ZombRandFloat(0.0, 1.0);
			local month = getGameTime():getMonth() + 1;
			for itemType, item in pairs(processedEntries[zoneName][rolledCategory].items) do
				if roll <= item.roll then
					if forageSystem.isValidMonth(item.definition, month) then
						return itemType, rolledCategory;
					end;
				end;
			end;
		end;
	end;

	return nil, nil;
end

function forageSystem.clearLastMonthLootEntries(_month)
	for zoneName, zoneMonths in pairs(forageSystem.processedEntries) do
		if zoneMonths[_month] then
			forageSystem.processedEntries[zoneName][_month] = nil;
		end;
	end;
end

function forageSystem.lootTableUpdate()
	if forageSystem.lootTableMonth ~= getGameTime():getMonth() + 1 then
		forageSystem.clearLastMonthLootEntries(forageSystem.lootTableMonth);
		forageSystem.lootTableMonth = getGameTime():getMonth() + 1;
	end;
end

function forageSystem.generateLootTable()
	local lootTable = {};
	local itemDefs = forageSystem.itemDefs;
	local zoneDefs = forageSystem.zoneDefs;
	local catDefs = forageSystem.catDefs;

	for zoneName, zoneDef in pairs(zoneDefs) do
		lootTable[zoneName] = {
			categories = {},
			definition = zoneDef,
		};
		for catName, catDef in pairs(catDefs) do
			lootTable[zoneName].categories[catName] = {
				items = {},
				definition = catDef;
			};
		end;
	end;

	for zoneName in pairs(zoneDefs) do
		for catName, catDef in pairs(catDefs) do
			lootTable[zoneName].categories[catName].zones = catDef.zones;
		end;
	end;

	for itemType, itemDef in pairs(itemDefs) do
		for zoneName in pairs(itemDef.zones) do
			if zoneDefs[zoneName] then
				for _, catName in ipairs(itemDef.categories) do
					if catDefs[catName] then
						lootTable[zoneName].categories[catName].items[itemType] = {
							definition = itemDef,
						};
					else
						log(DebugType.Foraging, "[forageSystem][generateLootTable] no such category is defined "..catName..", ignoring for definition "..itemType);
					end;
				end;
			else
				log(DebugType.Foraging, "[forageSystem][generateLootTable] no such zone is defined "..zoneName..", ignoring for definition "..itemType);
			end;
		end;
	end;

	forageSystem.lootTable = lootTable;
end

--[[---------------------------------------------
--
-- itemDefs
--
--]]---------------------------------------------

--[[--======== addItemDef ========--
	@param _itemDef

	Adds a definition to forageSystem.itemDefs

	example:

	an apple
	only in Forest zone
	chance is 1
	only available in July
	only in the ForestGoods category
	granting 10 xp

	(All missing definition info will be filled in automatically!)
	(See forageSystem.defaultDefinitions.defaultItemDef for the possible values)

	local appleDef = {
		type = "Base.Apple",
        zones = {
            Forest      = 1,
        },
        categories = { "ForestGoods" },
		months = { 7, },
		xp = 10,
	};

	forageSystem.addItemDef(appleDef);

	if the definition exists, it will overwrite the existing one.
	only one definition may exist per item.

	To modify a definition: see forageSystem.modifyItemDef
]]--

function forageSystem.addItemDef(_itemDef)
	if not (_itemDef and _itemDef.type) then return; end;
	local itemDef = _itemDef;
	if forageSystem.isItemExist(nil, itemDef) then
		if forageSystem.isItemScriptValid(nil, itemDef) then
			-- blacklisted items will be removed from existing zoneData in forageSystem.integrityCheck()
			if (not forageSystem.itemBlacklist:contains(itemDef.type)) then
				local def = forageSystem.importDef(itemDef, forageSystem.defaultDefinitions.defaultItemDef);
				local defType = def.type;
				if (not def.itemSize) then def.itemSize = forageSystem.getItemDefSize(def); end;
				--handle mixed zones. inject the chances for the other zone multiplied by the chanceRatio
				local rollAverage = 1;
				local zoneNumber = 1;
				for zoneName, zoneDef in pairs(forageSystem.zoneDefs) do
					if (not itemDef.zones[zoneName]) then
						if zoneDef.containsBiomes then
							for containedZone, chanceRatio in pairs(zoneDef.containsBiomes) do
								if itemDef.zones[containedZone] then
									rollAverage = rollAverage + (itemDef.zones[containedZone] * chanceRatio);
								end;
								zoneNumber = zoneNumber + 1;
							end;
							itemDef.zones[zoneName] = math.ceil(rollAverage / zoneNumber);
							zoneNumber = 1;
							rollAverage = 1;
						end;
					end;
				end;
				def.validMonths = {};
				for _, thisMonth in ipairs(def.months) do
					def.validMonths[thisMonth] = 1;
				end;
				local monthBonus = 1 + (forageSystem.monthBonus / 100);
				for _, bonusMonth in ipairs(def.bonusMonths) do
					if def.validMonths[bonusMonth] then
						def.validMonths[bonusMonth] = def.validMonths[bonusMonth] * monthBonus;
					end;
				end;
				local monthMalus = 1 + (forageSystem.monthMalus / 100);
				for _, malusMonth in ipairs(itemDef.malusMonths) do
					if def.validMonths[malusMonth] then
						def.validMonths[malusMonth] = def.validMonths[malusMonth] * monthMalus;
					end;
				end;
				for _, catName in ipairs(def.categories) do
					if forageSystem.catDefs[catName] then
						for _, month in ipairs(itemDef.months) do
							forageSystem.catDefs[catName].validMonths[month] = 1;
						end;
					end;
				end;
				if not forageSystem.itemDefs[defType] then
					forageSystem.itemDefs[defType] = def;
					-- update the item script to know that it can be foraged
                    local scriptItem = ScriptManager.instance:getItem(itemDef.type)
                    scriptItem:setCanBeForaged(true);
                    forageSystem.setScriptItemFocusCategories(itemDef, scriptItem);
					return defType, true; -- defType is added
				else
					log(DebugType.Foraging, "[forageSystem][addItemDef] item is already defined! "..itemDef.type);
					log(DebugType.Foraging, "[forageSystem][addItemDef] using forageSystem.modifyItemDef to change a defined itemDef for "..itemDef.type);
					forageSystem.modifyItemDef(itemDef);
				end;
				return defType, false; -- defType was not added
			else
				log(DebugType.Foraging, "[forageSystem][addItemDef] item matches entry in LootItemRemovalList sandbox setting, skipping "..itemDef.type);
			end;
		end;
	else
		log(DebugType.Foraging, "[forageSystem][addItemDef] no such item, ignoring "..itemDef.type);
	end;
	return itemDef.type, false; -- _itemDef.type could not be added
end

--[[--======== removeItemDef ========--
	@param _itemDef

	Removes a definition from forageSystem.itemDefs (matching _itemDef.type)

	example:

	to remove the definition for Base.Apple - this is all that is strictly required.

	forageSystem.removeItemDef({type = "Base.Apple"})

	an existing itemDef may be passed to this function too.

	example:

	local appleDef = forageSystem.itemDefs["Base.Apple"];

	forageSystem.removeItemDef(appleDef);
]]--

function forageSystem.removeItemDef(_itemDef)
	if _itemDef and forageSystem.isItemExist(nil, _itemDef) then
		forageSystem.itemDefs[_itemDef.type] = nil; --wipe the definition
        -- update the item script to know that it cannot be foraged
        local scriptItem = ScriptManager.instance:getItem(_itemDef.type)
        scriptItem:setCanBeForaged(false);
        scriptItem:clearForageFocusCategories();
	else
		log(DebugType.Foraging, "[forageSystem][removeItemDef] no such item, ignoring "..((_itemDef and _itemDef.type) or "unknown type"));
	end;
end

--[[--======== modifyItemDef ========--
	@param _itemDef

	Removes a definition from forageSystem.itemDefs and replaces it with _itemDef.

	example:

	local appleDef = {
		type = "Base.Apple",
        zones = {
            Forest      = 10,
        },
        categories = { "ForestGoods", "Junk" },
		months = { 7, 8, 9 },
		xp = 1000,
	};

	forageSystem.modifyItemDef(appleDef);

	this can also be done with forageSystem.addItemDef
	both functions are provided for convenience
	if the itemDef does not exist, it will not be added via this function.
]]--

function forageSystem.modifyItemDef(_itemDef)
	if _itemDef and forageSystem.itemDefs[_itemDef.type] and forageSystem.isItemExist(nil, _itemDef) then
		forageSystem.removeItemDef(_itemDef);
		forageSystem.addItemDef(_itemDef);
	else
		log(DebugType.Foraging, "[forageSystem][modifyItemDef] no such item or itemDef, ignoring "..((_itemDef and _itemDef.type) or "unknown type"));
	end;
end

function forageSystem.populateScavengeDefs()
	for categoryName, category in pairs(scavenges) do
		for _, def in ipairs(category) do
			if not def.categories then
				local categoryToUse = categoryName;
				for catName in pairs(forageSystem.catDefs) do
					if string.lower(catName) == string.lower(categoryName) then
						categoryToUse = catName;
					end;
				end;
				def.categories = {tostring(categoryToUse)};
				if not forageSystem.catDefs[categoryToUse] then
					log(DebugType.Foraging, "[forageSystem][populateScavengeDefs] no such category and did not find a match for " .. categoryName);
					log(DebugType.Foraging, "[forageSystem][populateScavengeDefs] adding a new category "..categoryToUse.." with the default definition for "..categoryName);
					forageSystem.addCatDef({name = categoryToUse}, false, true);
				end;
			end;
			forageSystem.addItemDef(def, true);
		end;
	end;
end

--[[--======== populateItemDefs ========--
	@param _itemDefs - (optional) a table of itemsDefs to add

	The main function for bulk adding definitions.
	A table full of itemDefs may be added via this function. See forageSystem.forageDefinitions for how to structure bulk tables.
]]--

function forageSystem.populateItemDefs(_itemDefs)
	for _, def in pairs(_itemDefs or forageSystem.forageDefinitions) do
		forageSystem.addItemDef(def);
	end;
end

--[[---------------------------------------------
--]]---------------------------------------------

--[[--======== createForageZone ========--
	@param _x, _y - coordinates for zone
	@param _definedZone - (optional) IsoZone - use this defZone instead

	Create a scavenge zone at x/y, optionally sets number of forages remaining
]]--

function forageSystem.createForageZone(_x, _y, _defZone)
	local zoneDef, defZone;
	if _defZone then
		defZone = _defZone;
		zoneDef = forageSystem.getZoneDef(_defZone);
	else
		zoneDef, defZone = forageSystem.getDefinedZoneAt(_x, _y);
	end;
	if not (zoneDef and defZone) then return false; end;
	local forageZone = getWorld():registerZone(getRandomUUID(), "ForageZone", defZone:getX(), defZone:getY(), 0, defZone:getWidth(), defZone:getHeight());
	local zoneData = forageSystem.createZoneData(forageZone, zoneDef);
	forageClient.updateZone(zoneData);
	return zoneData;
end

function forageSystem.getForageZoneAt(_x, _y)
	local zones = getZones(_x, _y, 0);
	local defZone;
	if zones then
		for zone in iterList(zones) do
			if forageSystem.zoneDefs[zone:getType()] then defZone = zone; end;
		end;
		if not defZone then return nil; end;
		-- There can be multiple rectangular ForageZone zones at the location.
		for zone in iterList(zones) do
			if zone:getType() == "ForageZone" then
				if zone:getX() == defZone:getX() and zone:getY() == defZone:getY() and zone:getZ() == defZone:getZ() and zone:getWidth() == defZone:getWidth() and zone:getHeight() == defZone:getHeight() then
					return forageSystem.getZoneData(zone, forageSystem.zoneDefs[defZone:getType()], _x, _y);
				end;
			end;
		end
	end;
	if defZone then return forageSystem.createForageZone(_x, _y, defZone); end;
	return nil;
end

function forageSystem.getRandomCoord(_x1, _x2, _y1, _y2)
	return ZombRand(_x1, _x2) + 1, ZombRand(_y1, _y2) + 1;
end

function forageSystem.getZoneRandomCoord(_zoneData)
	local location = _zoneData.metaZone:pickRandomLocation(Location.new())
	if location then
		return location:getX(), location:getY()
	end
	local x1, x2 = _zoneData.bounds.x1, _zoneData.bounds.x2;
	local y1, y2 = _zoneData.bounds.y1, _zoneData.bounds.y2;
	return ZombRand(x1, x2) + 1, ZombRand(y1, y2) + 1;
end

function forageSystem.getZoneRandomCoordNearPoint(_zoneData, _minDist, _x, _y)
	local x1, x2    = _zoneData.bounds.x1, _zoneData.bounds.x2;
	local y1, y2    = _zoneData.bounds.y1, _zoneData.bounds.y2;
	local newX      = _x + ZombRand(_minDist / 2, _minDist);
	local newY      = _y + ZombRand(_minDist / 2, _minDist);
	if isInRect(newX, newY, x1, x2, y1, y2) then
		return newX, newY;
	end;
	return ZombRand(x1, x2) + 1, ZombRand(y1, y2) + 1;
end

function forageSystem.getDefinedZoneAt(_x, _y)
	local zones = getZones(_x, _y, 0);
	if zones then
		for zone in iterList(zones) do
			if forageSystem.zoneDefs[zone:getType()] then
				return forageSystem.zoneDefs[zone:getType()], zone;
			end;
		end;
	end;
	return false, false;
end

--[[--======== getRefillBonus ========--
	@param _value - (optional) alternate value

	Returns refill bonus value for sandbox setting specified in zoneDef.

	Must be a sandbox setting, see SandboxVars for possible options.
]]--

function forageSystem.getRefillBonus(_zoneData)
	local zoneDef = forageSystem.zoneDefs[_zoneData.name];
	if not zoneDef then
		log(DebugType.Foraging, "[forageSystem][getRefillBonus] could not find a zoneDef for "..tostring(_zoneData.name));
		log(DebugType.Foraging, "[forageSystem][getRefillBonus] using bonus value of 0 for " .. tostring(_zoneData.name));
		return 0;
	end;
	--
	local abundanceSetting = zoneDef.abundanceSetting or "NatureAbundance";
	if not (forageSystem.abundanceSettings[abundanceSetting] and SandboxVars[abundanceSetting]) then
		log(DebugType.Foraging, "[forageSystem][getRefillBonus] could not find an abundance setting or invalid value for "..tostring(_zoneData.name));
		log(DebugType.Foraging, "[forageSystem][getRefillBonus] using bonus value of 0 for " .. tostring(_zoneData.name));
		return 0;
	end;
	if not (forageSystem.abundanceSettings[abundanceSetting][SandboxVars[abundanceSetting]]) then
		log(DebugType.Foraging, "[forageSystem][getRefillBonus] forageSystem could not find an abundance setting for " .. tostring(abundanceSetting));
		log(DebugType.Foraging, "[forageSystem][getRefillBonus] using bonus value of 0 for " .. tostring(_zoneData.name));
		return 0;
	end;
	--
	return 1 + (forageSystem.abundanceSettings[abundanceSetting][SandboxVars[abundanceSetting]] / 100) or 0;
end

--[[--======== importDef ========--]]--

function forageSystem.importDef(_def, _defaultDef)
	for key, value in pairs(_defaultDef) do
		if _def[key] == nil then _def[key] = value; end;
	end;
	return _def;
end

--[[--======== getZoneDefByType ========--]]--

function forageSystem.getZoneDefByType(_zoneName)
	return forageSystem.zoneDefs[_zoneName];
end

--[[--======== getZoneDef ========--]]--

function forageSystem.getZoneDef(_definedZone)
	return forageSystem.zoneDefs[_definedZone:getType()];
end

--[[--======== addZoneDef ========--]]--

function forageSystem.addZoneDef(_zoneDef, _overwrite)
	local zoneDef = forageSystem.importDef(_zoneDef, forageSystem.defaultDefinitions.defaultZoneDef);
	local zoneName = zoneDef.name;

	if forageSystem.zoneDefs[zoneName] then
		if _overwrite then
			forageSystem.zoneDefs[zoneName] = zoneDef;
			log(DebugType.Foraging, "[forageSystem][addZoneDef] overwriting definition for "..zoneName);
		else
			log(DebugType.Foraging, "[forageSystem][addZoneDef] definition for "..zoneName.." exists, ignoring");
			return;
		end;
	end;

	forageSystem.zoneDefs[zoneName] = zoneDef;
end

--[[--======== populateZoneDefs ========--
	@param _zoneDefs - (optional) add zoneDefs from a provided table

	Initialises the zone list
]]--

function forageSystem.populateZoneDefs(_zoneDefs)
	log(DebugType.Foraging, "[forageSystem][populateZoneDefs] Begin adding zoneDefs");
	for _, def in pairs(_zoneDefs or forageSystem.zoneDefinitions) do
		log(DebugType.Foraging, "[forageSystem][populateZoneDefs] Adding zoneDef: " .. def.name);
		forageSystem.addZoneDef(def);
	end;
	log(DebugType.Foraging, "[forageSystem][populateZoneDefs] Finished adding zoneDefs");
end;

--[[--======== populateMixedZoneCategories ========--
	Adds mixed zone definitions to the category definition tables

	This is used for mixed biomes, such as BirchMixForest, where loot can be from from multiple tables.
]]--

function forageSystem.populateMixedZoneCategories()
	local zoneDefs = forageSystem.zoneDefs;
	local catDefs = forageSystem.catDefs;

	log(DebugType.Foraging, "[forageSystem][populateMixedZoneCategories] Populating mixed category tables");
	for zoneName, zoneDef in pairs(zoneDefs) do

		for containedZone, chanceRatio  in pairs(zoneDef.containsBiomes) do
			--/!\ this generates a lot of debug lines, uncomment with caution
			--log(DebugType.Foraging, "[forageSystem][generateLootTable] "..zoneName.." contains loot from "..containedZone..", adding loot to mixed table");

			--category chances are multiplied by a ratio so loot chances can be adjusted for sub-biomes
			for _, catDef in pairs(catDefs) do
				catDef.zones[zoneName] = (catDef.zones[containedZone] or 0) * chanceRatio;
				--/!\ this generates a lot of debug lines, uncomment with caution
				--log(DebugType.Foraging, "[forageSystem][generateLootTable] "..containedZone.." category chance injected into category "..catDef.name.." for mixed zone " ..zoneName..", chance = "..catDef.zones[zoneName].." at a chanceRatio of "..chanceRatio..". original chance: "..(catDef.zones[containedZone] or 0));
			end;

		end;
	end;
	log(DebugType.Foraging, "[forageSystem][populateMixedZoneCategories] Finished populating mixed category tables");
end;

--[[--======== addCatDef ========--
	@param _catDef
	@param _overwrite - (optional) forces overwrite if definition exists

	Adds a category definition to forageSystem.catDefs, optionally overwrites existing definition

	example:

	local animalDef = {
		name                    = "Animals",
		typeCategory            = "Animals",
		identifyCategoryPerk    = "PlantScavenging",
		identifyCategoryLevel   = 5,
		categoryHidden          = false,
		validFloors             = { "ANY" },
		zones              		= {
			BirchForest  	= 15,
			DeepForest      = 15,
			FarmLand        = 20,
			ForagingNav     = 3,
			Forest          = 15,
			OrganicForest  	= 15,
			PHForest     	= 15,
			PRForest     	= 15,
			TownZone        = 5,
			TrailerPark     = 5,
			Vegitation      = 25,
		},
		spriteAffinities        = forageSystem.spriteAffinities.genericPlants,
		chanceToMoveIcon        = 3.0,
		chanceToCreateIcon      = 0.1,
		focusChanceMin			= 5.0,
		focusChanceMax			= 15.0,
	};


	forageSystem.addCatDef(animalDef, true);

	this would add a category for "Animals" to the category definitions, overwriting it if already existing.
]]--

function forageSystem.addCatDef(_catDef, _overwrite)
	local catDef = forageSystem.importDef(_catDef, forageSystem.defaultDefinitions.defaultCatDef);
	local categoryName = catDef.name;
	if forageSystem.catDefs[categoryName] then
		if _overwrite then
			log(DebugType.Foraging, "[forageSystem][addCatDef] overwriting definition for "..categoryName);
		else
			log(DebugType.Foraging, "[forageSystem][addCatDef] definition for "..categoryName.." exists, ignoring");
			return;
		end;
	end;
	--if there are any spriteAffinities, it will also add them to forageSystem.spriteAffinities here
	local woSprites = catDef.spriteAffinities;
	if woSprites and #woSprites > 0 then
		for _, spriteName in ipairs(woSprites) do
			if (not forageSystem.spriteAffinities[spriteName]) then
				forageSystem.spriteAffinities[spriteName] = {};
			end;
			table.insert(forageSystem.spriteAffinities[spriteName], catDef.name);
		end;
	end;
	forageSystem.catDefs[categoryName] = catDef;
end

--[[--======== populateCatDefs ========--
	@param _catDefs - (optional) use a provided table to add categories

	This function serves as a bulk-adder helper.
]]--

function forageSystem.populateCatDefs(_catDefs)
	for _, def in pairs(_catDefs or forageSystem.categoryDefinitions) do
		forageSystem.addCatDef(def);
	end;
end

--[[--======== addSkillDef ========--
	@param _skillDef
	@param _overwrite - (optional) force overwrite if definition exists

	Adds skill definition to global table, optionally overwrites existing definition
]]--

function forageSystem.addSkillDef(_skillDef, _overwrite)
	local def = forageSystem.importDef(_skillDef, forageSystem.defaultDefinitions.defaultSkillDef);
	local skillName = def.name;
	local skillType = def.type;
	if (not forageSystem.skillDefs[skillType]) then
		log(DebugType.Foraging, "[forageSystem][addSkillDef] invalid type for definition, ignoring "..skillName .. " : " .. skillType);
		return;
	end
	if forageSystem.skillDefs[skillType][skillName] then
		if _overwrite then
			log(DebugType.Foraging, "[forageSystem][addSkillDef] overwriting definition for "..skillName);
		else
			log(DebugType.Foraging, "[forageSystem][addSkillDef] definition for "..skillName.." exists, ignoring");
			return;
		end;
	end;
	forageSystem.skillDefs[skillType][skillName] = def;
end

--[[--======== populateSkillDefs ========--
	@param _skillDefs - (optional) override default table (forageSkills) with a new table

	This function serves as a bulk-adder helper.
]]--

function forageSystem.populateSkillDefs(_skillDefs)
	for _, def in pairs(_skillDefs or forageSystem.forageSkillDefinitions) do
		forageSystem.addSkillDef(def);
	end;
end

--[[---------------------------------------------
--
-- Items
--
--]]---------------------------------------------


--[[--======== getItemDefSize ========--
	@param _itemDef
]]--

function forageSystem.getItemDefSize(_itemDef)
	local itemObj = ScriptManager.instance:FindItem(_itemDef.type);
	local itemSize = (itemObj and itemObj:getActualWeight()) or 1.0;
	if _itemDef.itemSizeModifier > 0 then
		if _itemDef.isItemOverrideSize then
			itemSize = _itemDef.itemSizeModifier;
		else
			itemSize = itemSize + _itemDef.itemSizeModifier;
		end;
	end;
	return itemSize;
end

--[[--======== addOrDropItems ========--
	@param _character - IsoPlayer
	@param _inventory - inventory used
	@param _items - ArrayList of items to add
]]--

function forageSystem.addOrDropItems(_character, _inventory, _items, _discardItems)
	local inv = _inventory;
	local plInv = _character:getInventory();
	if (not _discardItems) then
		for item in iterList(_items) do
			inv:AddItem(item);
			sendAddItemToContainer(inv, item);
			if (inv:getCapacityWeight() > inv:getEffectiveCapacity(_character)) then
				inv:Remove(item);
				sendRemoveItemFromContainer(inv, item);
				if inv == plInv then
					_character:getCurrentSquare():AddWorldInventoryItem(item, 0.0, 0.0, 0.0);
				else
					plInv:AddItem(item);
					sendAddItemToContainer(plInv, item);
				end;
			end;
			if (plInv:getCapacityWeight() > plInv:getEffectiveCapacity(_character)) then
				_character:getCurrentSquare():AddWorldInventoryItem(item, 0.0, 0.0, 0.0);
				inv:Remove(item);
				sendRemoveItemFromContainer(inv, item);
			end;
			triggerEvent("OnContainerUpdate");
		end;
	end
	return _items;
end

function forageSystem.isValidFloor(_square, _itemDef, _catDef)
	if not _square then return false; end;
	if not _square:getFloor() then return false; end;
	if _square:Is(IsoFlagType.water) then return (_itemDef.isOnWater or _itemDef.forceOnWater); end;
	local floorTexture = _square:getFloor():getTextureName();
	if floorTexture then
		for _, floorType in ipairs(_catDef.validFloors) do
			if floorType == "ANY" then return true; end;
			if luautils.stringStarts(floorTexture, floorType) then return true; end;
		end;
	end;
	return false;
end

function forageSystem.isValidSquare(_square, _itemDef, _catDef)
	if (not _square) then return false; end;
	if _square:Is(IsoFlagType.solid) then return false; end;
	if _square:Is(IsoFlagType.solidtrans) then return false; end;
	if (not _square:isNotBlocked(false)) then return false; end;
	if _itemDef.forceOutside and (not _square:Is(IsoFlagType.exterior)) then return false; end;
	if _itemDef.forceOnWater and not (_square:Is(IsoFlagType.water)) then return false; end;
	if _square:HasTree() and (not _itemDef.canBeOnTreeSquare) then return false; end;
	if _catDef.validFunc then
		_catDef.validFunc(_square, _itemDef, _catDef);
	else
		return forageSystem.isValidFloor(_square, _itemDef, _catDef);
	end;
	return false;
end

--[[---------------------------------------------
--
--	Vision Radius
--
--]]---------------------------------------------

--[[--======== getCategoryBonus ========--]]--

function forageSystem.getCategoryBonus(_character, _catDef)
	if not (_catDef and _catDef.name) then return 1.0; end;
	local categoryName = _catDef.name;
	local specBonus = 0;
	local professionDef = forageSystem.skillDefs.occupation[_character:getDescriptor():getProfession()];
	if professionDef then
		if forageSystem.isValidSkillDefEffect(_character, professionDef, "specialisations") then
			specBonus = specBonus + (professionDef.specialisations[categoryName] or 0);
		end;
	end;
	for trait, traitDef in pairs(forageSystem.skillDefs.trait) do
		if _character:HasTrait(trait) then
			if forageSystem.isValidSkillDefEffect(_character, traitDef, "specialisations") then
				specBonus = specBonus + (traitDef.specialisations[categoryName] or 0);
			end;
		end;
	end;
	return 1 + (specBonus / 100);
end

--[[--======== getLevelVisionBonus ========--]]--

function forageSystem.getLevelVisionBonus(_perkLevel)
	return (_perkLevel * forageSystem.levelBonus);
end

--[[--======== getAimVisionBonus ========--
	@param _character - IsoPlayer
]]--

function forageSystem.getAimVisionBonus(_character)
	if _character then
		if _character:isAiming() then
			return forageSystem.aimMultiplier;
		end;
	end;
	return 1.0;
end

--[[--======== getSneakVisionBonus ========--
	@param _character - IsoPlayer
]]--

function forageSystem.getSneakVisionBonus(_character)
	if _character then
		--aim takes priority over crouching
		if _character:isSneaking() and (not _character:isAiming()) then
			return forageSystem.sneakMultiplier;
		end;
	end;
	return 1.0;
end

--[[--======== getMovementVisionPenalty ========--
	@param _character - IsoPlayer
]]--

function forageSystem.getMovementVisionPenalty(_character)
	local movementPenalty = 0;
	if _character:isPlayerMoving() then
		if _character:isRunning() then
			movementPenalty = 1;
		elseif _character:isSprinting() then
			movementPenalty = 1;
		end;
	end;
	return 1 - movementPenalty;
end

--[[--======== getHungerBonus ========--
	@param _character - IsoPlayer

	Returns bonus to spot food items when hungry as float 1 - (0-hungerBonusMax)
]]--

function forageSystem.getHungerBonus(_character, _itemDef)
	if not (_itemDef and _itemDef.type) then return 1; end;
	local hungerBonus = 0;
	if getItem(_itemDef.type) and isItemFood(_itemDef.type) then
		local hungerLevel = _character:getStats():getHunger();
		hungerBonus = (forageSystem.hungerBonusMax * hungerLevel) / 100;
	end;
	return 1 + hungerBonus;
end

--[[--======== getItemSizePenalty ========--
	@param _itemSize - item weight
]]--

function forageSystem.getItemSizePenalty(_itemSize)
	return math.log(clamp(_itemSize, 0.1, 10)) + forageSystem.minimumSizeBonus;
end

--[[--======== getDifficultyPenalty ========--
	@param _perkLevel

	Returns penalty for an item (based on skill) as float 1 - 0
]]--

function forageSystem.getDifficultyPenalty(_perkLevel)
	return (_perkLevel + 1) / 10;
end

--[[--======== getBodyPenalty ========--
	@param _character - IsoPlayer

	Returns penalty for body conditions as float 1 - (0-bodyPenaltyMax)
]]--

function forageSystem.getBodyPenalty(_character)
	local sickLevel = _character:getStats():getSickness();
	local painLevel = _character:getStats():getPain() / 100;
	local foodSickLevel = _character:getBodyDamage():getFoodSicknessLevel() / 100;
	local drunkLevel = _character:getStats():getDrunkenness() / 100;
	--
	local bodyPenalty = math.max(painLevel, sickLevel, foodSickLevel, drunkLevel);
	return clamp(1 - bodyPenalty, 1 - (forageSystem.bodyPenaltyMax / 100), 1);
end

--[[--======== getClothingPenalty ========--
	@param _character - IsoPlayer

	Returns penalty for clothing as float 1 - (0-clothingPenaltyMax)
]]--

function forageSystem.getClothingPenalty(_character)
	local clothingPenalty = 0;
	local wornItems = _character:getWornItems();
	for wornItem in iterList(wornItems) do
		if wornItem and wornItem:getLocation() then
			clothingPenalty = clothingPenalty + (forageSystem.clothingPenalties[wornItem:getLocation()] or 0);
		end;
	end;
	return clamp(1 - (clothingPenalty / 100), 1 - (forageSystem.clothingPenaltyMax / 100), 1);
end

--[[--======== getPanicPenalty ========--
	@param _character - IsoPlayer

	Returns penalty for panic conditions as float 1 - (0-panicPenaltyMax)
]]--

function forageSystem.getPanicPenalty(_character)
	local panicLevel = _character:getStats():getPanic() / 100;
	local fearLevel = _character:getStats():getFear();
	local stressLevel = _character:getStats():getStress();
	--
	local panicPenalty = math.max(panicLevel, fearLevel, stressLevel);
	return clamp(1 - panicPenalty, 1 - (forageSystem.panicPenaltyMax / 100), 1);
end

--[[--======== getExhaustionPenalty ========--
	@param _character - IsoPlayer

	Returns penalty for exhaustion conditions as float 1 - (0-exhaustionPenaltyMax)
]]--

function forageSystem.getExhaustionPenalty(_character)
	local enduranceLevel = 1 - _character:getStats():getEndurance();
	local fatigueLevel = _character:getStats():getFatigue();
	--
	local exhaustionPenalty = math.max(enduranceLevel + fatigueLevel);
	return clamp(1 - exhaustionPenalty, 1 - (forageSystem.exhaustionPenaltyMax / 100), 1);
end

--[[--======== getWeatherEffectReduction ========--
	@param _character - IsoPlayer

	Returns weather effect total reduction for character as percent
]]--

function forageSystem.getWeatherEffectReduction(_character)
	local effectReduction = 0;
	local professionDef = forageSystem.skillDefs.occupation[_character:getDescriptor():getProfession()];
	if professionDef then
		if forageSystem.isValidSkillDefEffect(_character, professionDef, "weatherEffect") then
			effectReduction = effectReduction + professionDef.weatherEffect;
		end;
	end;
	for trait, traitDef in pairs(forageSystem.skillDefs.trait) do
		if _character:HasTrait(trait) then
			if forageSystem.isValidSkillDefEffect(_character, traitDef, "weatherEffect") then
				effectReduction = effectReduction + traitDef.weatherEffect;
			end;
		end;
	end;
	effectReduction = clamp(effectReduction / 100, 0, forageSystem.effectReductionMax / 100);
	return 1 - effectReduction;
end

--[[--======== getWeatherPenalty ========--
	@param _character - IsoPlayer
	@param _square - IsoGridSquare

	Returns penalty for weather conditions as float 1 - (0-weatherPenaltyMax)
]]--

function forageSystem.getWeatherPenalty(_character, _square)
	if not (_character and _square) then return 1; end;
	if not _square:isOutside() then return 1; end;
	local weatherPenalty = 0;
	local climateManager = getClimateManager();
	local fogLevel = climateManager:getFogIntensity();
	local snowLevel = math.min(climateManager:getSnowStrength(), 1);
	--
	local rainLevel = climateManager:getPrecipitationIntensity();
	local primaryItem = _character:getPrimaryHandItem();
	local secondaryItem = _character:getSecondaryHandItem();
	local umbrellaPrimary = primaryItem and primaryItem:isProtectFromRainWhileEquipped();
	local umbrellaSecondary = secondaryItem and secondaryItem:isProtectFromRainWhileEquipped();
	--if using an umbrella rain penalty is reduced by 90%
	if umbrellaPrimary or umbrellaSecondary then
		rainLevel = rainLevel * 0.1;
	end;
	--use highest of rain/fog
	weatherPenalty = rainLevel + fogLevel;
	--add up to 25% for snow covered ground
	weatherPenalty = weatherPenalty + (snowLevel / 4);
	--add up to 10% for cloudy days
	local cloudLevel = climateManager:getCloudIntensity();
	weatherPenalty = weatherPenalty + (cloudLevel * 0.1);
	local effectReduction = forageSystem.getWeatherEffectReduction(_character);
	weatherPenalty = math.min(weatherPenalty, forageSystem.weatherPenaltyMax / 100);
	return 1 - (weatherPenalty * effectReduction);
end

--[[--======== getDarknessEffectReduction ========--
	@param _character - IsoPlayer

	Returns darkness effect total reduction for character as percent
]]--

function forageSystem.getDarknessEffectReduction(_character)
	local effectReduction = 0;
	local professionDef = forageSystem.skillDefs.occupation[_character:getDescriptor():getProfession()];
	if professionDef then
		if forageSystem.isValidSkillDefEffect(_character, professionDef, "darknessEffect") then
			effectReduction = effectReduction + professionDef.darknessEffect;
		end;
	end;
	for trait, traitDef in pairs(forageSystem.skillDefs.trait) do
		if _character:HasTrait(trait) then
			if forageSystem.isValidSkillDefEffect(_character, traitDef, "darknessEffect") then
				effectReduction = effectReduction + traitDef.darknessEffect;
			end;
		end;
	end;
	effectReduction = clamp(effectReduction / 100, 0, forageSystem.effectReductionMax / 100);
	return 1 - effectReduction;
end

--[[--======== getLightLevelPenalty ========--
	@param _character - IsoPlayer
	@param _square - IsoGridSquare

	Returns penalty for IsoGridSquare as float (0 to 1)
]]--

function forageSystem.getLightLevelPenalty(_character, _square, _doReduction)
	if not (_square and _character) then return 0; end;
	local lightLevel = _square:getLightLevel(_character:getPlayerNum());
	local dayLightStrength = getClimateManager():getDayLightStrength();
	--just make it fully bright if over 80%
	if lightLevel > 0.8 then lightLevel = 1; end;
	if _square:isOutside() then
		lightLevel = math.max(dayLightStrength, lightLevel);
	end;
	local effectReduction = forageSystem.getDarknessEffectReduction(_character);
	local lightPenalty = 0;
	if _doReduction then
		lightPenalty = (1 - lightLevel) * effectReduction;
	else
		lightPenalty = (1 - lightLevel);
	end;
	return clamp(1 - lightPenalty, 1 - (forageSystem.lightPenaltyMax / 100), 1);
end

--[[--======== getProfessionVisionBonus ========--
	@param _character - IsoPlayer

	Returns profession bonus vision in squares
]]--

function forageSystem.getProfessionVisionBonus(_character)
	local professionDef = forageSystem.skillDefs.occupation[_character:getDescriptor():getProfession()];
	if professionDef then
		if forageSystem.isValidSkillDefEffect(_character, professionDef, "visionBonus") then
			return professionDef.visionBonus;
		end;
	end;
	return 0;
end

--[[--======== getTraitVisionBonus ========--
	@param _character - IsoPlayer

	Returns trait bonus vision total in squares
]]--

function forageSystem.getTraitVisionBonus(_character)
	local traitBonus = 0;
	for trait, traitDef in pairs(forageSystem.skillDefs.trait) do
		if _character:HasTrait(trait) then
			if forageSystem.isValidSkillDefEffect(_character, traitDef, "visionBonus") then
				traitBonus = traitBonus + traitDef.visionBonus;
			end;
		end;
	end;
	return traitBonus;
end

--[[--======== isValidSkillDefEffect ========--
	@param _character - IsoPlayer
	@param _skillDef
	@param _bonusEffect

	Tests if skillDef effect should be applied (using skillDef.testFunc)
]]--

function forageSystem.isValidSkillDefEffect(_character, _skillDef, _bonusEffect)
	for _, testFunc in ipairs(_skillDef.testFuncs) do
		if not testFunc(_character, _skillDef, _bonusEffect) then return false; end;
	end;
	return true;
end

--[[--======== getMonthMulti ========--
	@param _itemDef
	@param _month - (optional) month to check

	Returns month bonus total for itemDef as percent
]]--

function forageSystem.getMonthMulti(_itemDef, _month)
	if not _itemDef then return 0; end;
	return _itemDef.validMonths[_month or (getGameTime():getMonth() + 1)] or 0;
end

--[[--======== getTimeOfDay ========--]]--

function forageSystem.getTimeOfDay()
	local season = getClimateManager():getSeason();
	local dawn = season:getDawn();
	local dusk = season:getDusk();
	local timeOfDay = getGameTime():getTimeOfDay();
	if (timeOfDay < dawn) or (timeOfDay > dusk) then return "isNight"; end;
	return "isDay";
end

--[[--======== getTimeOfDayBonus ========--
	@param _def - itemDef or catDef
	@param _isDay - true/false (optional) get result for time of day

	Returns time of day bonus total in percent for itemDef
]]--

function forageSystem.getTimeOfDayBonus(_def, _isDay)
	if (not _def) then return 1; end;
	local isDay;
	if _isDay ~= nil then
		isDay = _isDay == true;
	else
		isDay = forageSystem.getTimeOfDay() == "isDay";
	end;
	if isDay then
		return (100 + _def.dayChance) / 100;
	else
		return (100 + _def.nightChance) / 100;
	end;
end

--[[--======== getWeatherType ========--]]--

function forageSystem.getWeatherType()
	local precipitationIntensity = getClimateManager():getPrecipitationIntensity();
	local puddlesSize = getPuddlesManager():getPuddlesSize();
	local snowStrength = getClimateManager():getSnowStrength();
	if
		precipitationIntensity > 0.1
		or puddlesSize > 0.1
		or snowStrength > 0.1
	then
		return
			"isRaining"..round(precipitationIntensity, 1)
			.. "hasRained"..round(puddlesSize, 1)
			.. "isSnowing"..round(snowStrength, 1)
	end;
	return "isNormal";
end

--[[--======== getWeatherBonus ========--
	@param _def

	Returns weather bonus total in percent for itemDef or catDef
]]--

function forageSystem.getWeatherBonus(_def, _isRaining, _isSnowing, _hasRained)
	if not _def then return 1; end;
	local isRaining = _isRaining ~= nil and _isRaining or getClimateManager():getPrecipitationIntensity() > 0;
	local hasRained = _hasRained ~= nil and _hasRained or getPuddlesManager():getPuddlesSize() > 0.1;
	local isSnowing = _isSnowing ~= nil and _isSnowing or getClimateManager():getSnowStrength() > 0;
	local bonusChance = 100;
	if isRaining then bonusChance = bonusChance + _def.rainChance; end;
	if hasRained then bonusChance = bonusChance + _def.hasRainedChance; end;
	if isSnowing then bonusChance = bonusChance + _def.snowChance; end;
	return (bonusChance / 100)
end

function forageSystem.getWeatherMulti(_def, _rainAmount, _puddleAmount, _snowAmount)
	if not _def then return 1; end;
	local rainChance = _def.rainChance * _rainAmount;
	local hasRainedChance = _def.hasRainedChance * _puddleAmount;
	local snowChance = _def.snowChance * _snowAmount;
	return (100 + rainChance + hasRainedChance + snowChance) / 100;
end

--[[--======== hasRequiredItems ========--
	@param _character - IsoPlayer
	@param _itemDef

	Returns true if all items in itemDef are in inventory (matching by tag)
]]--

function forageSystem.hasRequiredItems(_character, _itemDef)
	local itemTest = function(_item, _tag)
		return not _item:isBroken() and _item:hasTag(_tag);
	end;
	local playerInv = _character:getInventory();
	local requiredItems = 0;
	for _, itemTag in ipairs(_itemDef.itemTags) do
		if playerInv:getFirstEvalArgRecurse(itemTest, itemTag) then
			requiredItems = requiredItems + 1;
		end;
	end;
	return #_itemDef.itemTags == requiredItems;
end

--[[--======== hasNeededTraits ========--
	@param _character - IsoPlayer
	@param _itemDef

	Returns true if all traits in itemDef are known
]]--

function forageSystem.hasNeededTraits(_character, _itemDef)
	local knownTraits = 0;
	for _, trait in ipairs(_itemDef.traits) do
		if _character:HasTrait(trait) then
			knownTraits = knownTraits + 1;
		end;
	end;
	return #_itemDef.traits == knownTraits;
end

--[[--======== hasNeededRecipes ========--
	@param _character - IsoPlayer
	@param _itemDef

	Returns true if all recipes in itemDef are known
]]--

function forageSystem.hasNeededRecipes(_character, _itemDef)
	local knownRecipes = 0;
	for _, recipe in ipairs(_itemDef.recipes) do
		if _character:isRecipeActuallyKnown(recipe) then
			knownRecipes = knownRecipes + 1;
		end;
	end;
	return #_itemDef.recipes == knownRecipes;
end

--[[--======== getPerkLevel ========--
	@param _character - IsoPlayer
	@param _itemDef

	Returns perk level / number of perks
]]--

function forageSystem.getPerkLevel(_character, _itemDef)
	local perkLevel = 0;
	local numPerks = #_itemDef.perks;
	if numPerks <= 0 then return 0; end;
	for _, perk in ipairs(_itemDef.perks) do
		perkLevel = perkLevel + _character:getPerkLevel(Perks.FromString(perk));
	end;
	perkLevel = math.ceil(perkLevel / numPerks);
	return perkLevel;
end

--[[--======== isItemTypeExist ========--
@param _itemDef

Returns true if an item type exists
]]--

function forageSystem.isItemTypeExist(_itemType)
	return (_itemType and ScriptManager.instance:FindItem(_itemType) and true) or false;
end;

--[[--======== hasNeededPerks ========--
@param _character - IsoPlayer
@param _itemDef

Returns true if player is sufficient level for all perk requirements
]]--

function forageSystem.hasNeededPerks(_character, _itemDef, _zoneDef)
	return (_itemDef and _itemDef.skill <= forageSystem.getPerkLevel(_character, _itemDef)) or false;
end

--[[--======== isItemExist ========--
	@param _itemDef
	@param _zoneDef - zoneDef

	Returns true if an item type exists
]]--

function forageSystem.isItemExist(_character, _itemDef, _zoneDef)
	local itemObj = (_itemDef and _itemDef.type) and ScriptManager.instance:FindItem(_itemDef.type);
	return (itemObj and (not itemObj:getObsolete()) and true) or false;
end

--[[--======== isItemScriptValid ========--
	@param _itemDef
	@param _zoneDef - zoneDef

	Returns true if an item script is valid for use as an item definition
]]--

function forageSystem.isItemScriptValid(_character, _itemDef, _zoneDef)
	local isValid = false;
	if _itemDef and _itemDef.type then
		local itemType = _itemDef.type;
		local scriptItem = ScriptManager.instance:FindItem(itemType);
		--item type may only contain a-z, 0-9, underscore, period
		if itemType:match('^[a-zA-Z0-9._]+$') ~= nil then
			if scriptItem then
				if (not scriptItem:getObsolete()) then
					local iconsForTexture = scriptItem:getIconsForTexture();
					if (scriptItem:getIcon() ~= "None") or (iconsForTexture and (not iconsForTexture:isEmpty())) then
						local itemObj = instanceItem(itemType);
						if itemObj then
						    if isServer() then
						        isValid = true;
						    elseif itemObj:getTexture() then
								isValid = true;
							else
								log(DebugType.Foraging, "[forageSystem][isItemScriptValid] item failed test [getTexure], ignoring definition for "..itemType);
							end;
						else
							log(DebugType.Foraging, "[forageSystem][isItemScriptValid] item failed test [instanceItem], ignoring definition for "..itemType);
						end;
					else
						log(DebugType.Foraging, "[forageSystem][isItemScriptValid] item script failed test [getIcon] or [getIconsForTexture], ignoring definition for "..itemType);
					end;
				else
					log(DebugType.Foraging, "[forageSystem][isItemScriptValid] item failed test [getObsolete], ignoring definition for "..itemType);
				end;
			else
				log(DebugType.Foraging, "[forageSystem][isItemScriptValid] could not find an item script, ignoring definition for "..itemType);
			end;
		else
			log(DebugType.Foraging, "[forageSystem][isItemScriptValid] item type contains illegal characters, ignoring definition for "..itemType);
		end;
	end;
	--
	return isValid;
end

function forageSystem.isItemInZone(_character, _itemDef, _zoneDef)
	for zoneName in pairs(_itemDef.zones) do
		if zoneName == _zoneDef.name then return true; end;
	end;
	return false;
end

function forageSystem.isValidMonthInternal(_character, _itemDef, _zoneDef, _month)
	return forageSystem.isValidMonth(_itemDef, _month);
end

function forageSystem.isValidMonth(_def, _month)
	return _def.validMonths[_month or getGameTime():getMonth() + 1];
end

function forageSystem.setScriptItemFocusCategories(_itemDef, _scriptItem)
	local itemDef = _itemDef;
	local scriptItem = _scriptItem;
	if itemDef and scriptItem then
		for _, categoryName in ipairs(itemDef.categories) do
			if forageSystem.catDefs[categoryName] and not forageSystem.catDefs[categoryName].categoryHidden then
				scriptItem:addForageFocusCategory(categoryName);
			end;
		end;
	end;
end

--[[--======== isForageable ========--
	@param _character - IsoPlayer
	@param _zoneDef - zoneDef
	@param _itemDef
]]--

function forageSystem.isForageable(_character, _itemDef, _zoneDef)
	for _, testFunc in ipairs(forageSystem.isForageableFuncs) do
		if type(testFunc) == "function" then
			if not testFunc(_character, _itemDef, _zoneDef) then
				return false;
			end;
		elseif type(testFunc) == "string" then
			if forageSystem[testFunc] then
				if not forageSystem[testFunc](_character, _itemDef, _zoneDef) then
					return false;
				end;
			else
				log(DebugType.Foraging, "[forageSystem][isForageable] could not find function forageSystem."..testFunc);
			end;
		else
			log(DebugType.Foraging, "[forageSystem][isForageable] not string or function "..type(testFunc));
			return false;
		end;
	end;
	return true;
end

--[[--======== addForageDef ========--
	@param _itemType - item type, without "Module."
	@param _forageDef - forageDef is an unprocessed itemDef.
]]--

function forageSystem.addForageDef(_itemType, _forageDef)
	if not _forageDef then return; end;
	if not _itemType then
		log(DebugType.Foraging, "[forageSystem][addForageDef] a forageDef is missing a type! ".. _itemType);
		return;
	end;
	if not forageSystem.forageDefinitions[_itemType] then
		forageSystem.forageDefinitions[_itemType] = _forageDef;
	else
		log(DebugType.Foraging, "[forageSystem][addForageDef] a forageDef is already defined! ".. _itemType);
	end;
end

--[[---------------------------------------------
--
--	Character
--
--]]---------------------------------------------

--[[--======== giveItemXP ========--
	@param _character - IsoPlayer
	@param _itemDef
	@param _amount - (optional) override amount of xp by a percent (float 0-1)

	Awards the _character an (_amount) of the _itemDef defined xp value
]]--

function forageSystem.itemFound(_character, _itemType, _amount)
    local _itemDef = forageSystem.itemDefs[_itemType];
	forageSystem.giveItemXP(_character, _itemDef, _amount);
end

function forageSystem.giveItemXP(_character, _itemDef, _amount)
	local pfPerk, currentXP;
	--
	local xpAmount              = _itemDef.xp * (_amount or 1);
	local globalXPModifier      = forageSystem.globalXPModifier / 100;
	local levelXPModifier       = forageSystem.levelXPModifier / 100;
	local perkLevel             = forageSystem.getPerkLevel(_character, _itemDef);
	local diminishingReturn     = 1 - ((perkLevel - _itemDef.skill) * levelXPModifier);
	--
	xpAmount = math.max((xpAmount * globalXPModifier) * diminishingReturn, 1);
	for _, perk in ipairs(_itemDef.perks) do
		pfPerk = Perks.FromString(perk);
		if pfPerk then
			currentXP = _character:getXp():getXP(pfPerk);
			addXp(_character, pfPerk, xpAmount);
		end;
	end;
end

--[[--======== doEndurancePenalty ========--
	@param _character - IsoPlayer
	@param _amount - (optional) amount to endure

	Returns endurance level
]]--

function forageSystem.doEndurancePenalty(_character, _amount)
	local enduranceLevel = _character:getStats():getEndurance();
	enduranceLevel = enduranceLevel - (_amount or forageSystem.endurancePenalty);
	_character:getStats():setEndurance(enduranceLevel);
	return enduranceLevel;
end

--[[--======== doFatiguePenalty ========--
	@param _character - IsoPlayer
	@param _amount - (optional) amount to fatigue

	Returns fatigue level
]]--

function forageSystem.doFatiguePenalty(_character, _amount)
	local fatigueLevel = _character:getStats():getFatigue();
	fatigueLevel = fatigueLevel + (_amount or forageSystem.fatiguePenalty);
	_character:getStats():setFatigue(fatigueLevel);
	return fatigueLevel;
end

function forageSystem.doGlassesCheck(_character, _skillDef, _bonusEffect)
	if _bonusEffect == "visionBonus" then
		local visualAids = {
			["Base.Glasses_Normal"]     = true,
			["Base.Glasses_Reading"]    = true,
		};
		local wornItem = _character:getWornItem("Eyes");
		if wornItem and visualAids[wornItem:getFullType()] then
			return false;
		end;
	end;
	return true;
end

--[[---------------------------------------------
--
--[[--======== Spawn Functions ========--]]--
--
--]]---------------------------------------------

function forageSystem.doPoisonItemSpawn(_character, _inventory, _itemDef, _items)
	if _itemDef.poisonChance and _itemDef.poisonPowerMin and _itemDef.poisonPowerMax then
		if _itemDef.poisonChance > 0 and _itemDef.poisonPowerMax > 0 then
			local perkLevel = forageSystem.getPerkLevel(_character, _itemDef);
			--increase poison chance by up to 30% for level 0
			if ZombRand(100) < _itemDef.poisonChance + ((10 - perkLevel) * 3) then
				for item in iterList(_items) do
					item:setPoisonPower(ZombRand(_itemDef.poisonPowerMin, _itemDef.poisonPowerMax) + 1);
					item:setPoisonDetectionLevel(_itemDef.poisonDetectionLevel or 0);
					item:setUseForPoison(item:getHungChange());
				end;
			end;
		end;
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

function forageSystem.doRandomAgeSpawn(_character, _inventory, _itemDef, _items)
	local perkLevel = forageSystem.getPerkLevel(_character, _itemDef);
	for item in iterList(_items) do
		--set random age based on perkLevel and random chance
		local randomAge = 0;
		if (ZombRand(10) + 1) <= perkLevel then
			randomAge = ZombRandFloat(0.0, item:getOffAge() / 2);
		elseif ZombRand(3) <= perkLevel then
			randomAge = ZombRandFloat(0.0, item:getOffAge());
		else
			randomAge = ZombRandFloat(item:getOffAge(), item:getOffAgeMax());
		end;
		item:setAge(randomAge);
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

function forageSystem.doWorldAgeSpawn(_character, _inventory, _itemDef, _items)
	local worldAge = getGameTime():getWorldAgeHours();
	for item in iterList(_items) do
		item:setAge(worldAge);
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

function forageSystem.doWildFoodSpawn(_character, _inventory, _itemDef, _items)
	-- Randomize the size of the item
	local perkLevel = forageSystem.getPerkLevel(_character, _itemDef);
	for item in iterList(_items) do
		item:setName(item:getDisplayName() .. " (" .. getText("UI_foraging_WildFood") .. ")");

		-- skill modifier raises the total size a bit more
		local sizeModifier = ((ZombRand(45) + 5) / 100) + ((ZombRand(perkLevel) + 1) * 0.05);

		-- don't reduce hunger under 2 and cap size to 1 because it's weird finding 0 hunger food.
		if item:getBaseHunger() <= -0.02 and item:getBaseHunger() * sizeModifier <= -0.01 then
			item:setBaseHunger(item:getBaseHunger() * sizeModifier);
			item:setHungChange(item:getHungChange() * sizeModifier);
		end;

		-- all foraged wild food can still have nutrition affects regardless of size.
		item:setCarbohydrates(item:getCarbohydrates() * sizeModifier);
		item:setLipids(item:getLipids() * sizeModifier);
		item:setProteins(item:getProteins() * sizeModifier);
		item:setCalories(item:getCalories() * sizeModifier);
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

function forageSystem.doWildCropSpawn(_character, _inventory, _itemDef, _items)
	--chance to generate a few seeds
	local seedData = forageSystem.seedTable[_itemDef.type];
	if seedData then
		local seedChance = seedData.chance;
		if ZombRand(100) + 1 <= seedChance then
			for _ = 1, ZombRand(seedData.amount) + 1 do
				_items:add(instanceItem(seedData.type));
			end;
		end;
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

function forageSystem.doJunkWeaponSpawn(_character, _inventory, _itemDef, _items)
	for item in iterList(_items) do
		local conditionMax = item:getConditionMax();
		if conditionMax > 0 then
			item:setCondition(ZombRand(conditionMax) + 1); -- Randomize the weapon condition
		end;
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

function forageSystem.doGenericItemSpawn(_character, _inventory, _itemDef, _items)
	for item in iterList(_items) do
		if item:IsDrainable() then
			item:setUsedDelta(ZombRandFloat(0.0, 1.0)); -- Randomize the item uses remaining
		end;
		local conditionMax = item:getConditionMax();
		if conditionMax > 0 then
			item:setCondition(ZombRand(conditionMax) + 1); -- Randomize the weapon condition
		end;
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

function forageSystem.doClothingItemSpawn(_character, _inventory, _itemDef, _items)
	for item in iterList(_items) do
		if item:IsClothing() and not item:isCosmetic() then
			item:randomizeCondition(25, 75, 25, 33);
		end;
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

function forageSystem.doDeadTrapAnimalSpawn(_character, _inventory, _itemDef, _items)
	for item in iterList(_items) do
		--search for trap animal definition
		for _, trapDef in pairs(TrapAnimals) do
			if trapDef.item == _itemDef.type then
				-- Randomize the hunger reduction of the animal
				local size = ZombRand(trapDef.minSize, trapDef.maxSize);
				local typicalSize = item:getBaseHunger() * -100;
				local statsModifier = size / typicalSize;
				-- Set the animal's stats depending on the random size
				item:setBaseHunger(item:getBaseHunger() * statsModifier);
				item:setHungChange(item:getHungChange() * statsModifier);
				item:setActualWeight(item:getActualWeight() * statsModifier);
				item:setCarbohydrates(item:getCarbohydrates() * statsModifier);
				item:setLipids(item:getLipids() * statsModifier);
				item:setProteins(item:getProteins() * statsModifier);
				item:setCalories(item:getCalories() * statsModifier);
			end;
		end;
		--dead animals can only be in the range of barely fresh to rotted
		if ZombRand(10) + 1 <= 3 then
			--barely fresh to rotted
			local freshLimit = item:getOffAge() - (item:getOffAge() / 4);
			item:setAge(ZombRandFloat(freshLimit, item:getOffAgeMax()));
		else
			--stale to rotted
			item:setAge(ZombRandFloat(item:getOffAge(), item:getOffAgeMax()));
		end;
	end;
	return _items; --custom spawn scripts must return an arraylist of items (or nil)
end

Events.OnItemFound.Add(forageSystem.itemFound);