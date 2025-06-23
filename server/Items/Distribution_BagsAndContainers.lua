BagsAndContainers = BagsAndContainers or {}

-- NOTE: Some containers have small sizes, so it's important to put items you want spawning in them FIRST.
-- Example: Gun cases. Ideal order goes Guns > Clips > Ammo > Holsters/Belts > Accessories

BagsAndContainers.ALICEpack_Army = {
	rolls = 1,
	items = {
		"AlcoholWipes", 1,
		"Bandage", 1,
		"CanteenMilitary", 1,
		"CompassDirectional", 1,
		"DehydratedMeatStick", 1,
		"Earbuds", 1,
		"EntrenchingTool", 0.5,
		"FirstAidKit_Military", 4,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 2,
		"GranolaBar", 1,
		"Gum", 10,
		"Hat_Army", 0.2,
		"Hat_GasMask", 0.5,
		"HolsterSimple_Green", 1,
		"HuntingKnife", 0.1,
		"HuntingKnife", 0.5,
		"KnifePocket", 1,
		"Lighter", 1,
		"ShemaghScarf_Green", 0.01,
		"Shoes_ArmyBoots", 0.2,
		"Spork", 10,
		"TobaccoChewing", 1,
		"Tshirt_ArmyGreen", 1,
		"WalkieTalkie5", 1,
		"WaterBottle", 1,
		"WaterPurificationTablets", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ALICE_BeltSus = {
	rolls = 1,
	items = {
		"AlcoholWipes", 1,
		"Bandage", 1,
		"CanteenMilitary", 1,
		"CompassDirectional", 1,
		"DehydratedMeatStick", 1,
		"Earbuds", 1,
		"EntrenchingTool", 0.5,
		"FirstAidKit_Military", 4,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 2,
		"GranolaBar", 1,
		"Gum", 10,
		"HuntingKnife", 0.5,
		"KnifePocket", 1,
		"Lighter", 1,
		"Notepad", 1,
		"P38", 1,
		"ScissorsBluntMedical", 1,
		"TobaccoChewing", 1,
		"WalkieTalkie5", 1,
		"WaterBottle", 1,
		"WaterPurificationTablets", 1,
		"Zipties", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.Bag_Skill_Maintenance_DuffelBag = {
	rolls = 1,
	items = {
		-- Keys/Keyrings
		"CarKey", 0.5,
		"KeyRing", 0.1,
		"Key1", 0.5,
		"Key1", 0.5,
		-- Tools
		"Awl", 4,
		"BallPeenHammer", 8,
		"BlowTorch", 4,
		"BoltCutters", 4,
		"Calipers", 2,
		"CarpentryChisel", 4,
		"ClubHammer", 4,
		"Crowbar", 4,
		"File", 2,
		"Funnel", 10,
		"GardenSaw", 8,
		"Hammer", 8,
		"HandDrill", 4,
		"HeadingTool", 1,
		"KnifePocket", 0.1,
		"MasonsChisel", 2,
		"MasonsTrowel", 2,
		"MetalworkingChisel", 2,
		"MetalworkingPunch", 2,
		"PipeWrench", 8,
		"Pliers", 10,
		"Saw", 8,
		"Screwdriver", 10,
		"SheetMetalSnips", 4,
		"SmallFileSet", 2,
		"SmallPunchSet", 2,
		"SmallSaw", 2,
		"Tongs", 2,
		"ViseGrips", 4,
		"WoodenMallet", 4,
		"Wrench", 8,
		-- Literature (Skill Books)
		"BookMaintenance1", 50,
		"BookMaintenance2", 20,
		"BookMaintenance3", 10,
		"BookMaintenance4", 8,
		"BookMaintenance5", 4,
		-- Materials
		"DuctTape", 20,
		"DuctTape", 10,
		"Epoxy", 20,
		"Epoxy", 10,
		"FiberglassTape", 20,
		"FiberglassTape", 10,
		"Woodglue", 20,
		"Woodglue", 10,
		-- Equipment
		"FlashLight_AngleHead", 10,
		"Glasses_SafetyGoggles", 4,
		"HandTorch", 4,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 4,
		"Hat_EarMuff_Protectors", 4,
		"RespiratorFilters", 2,
		-- Misc.
		"MarkerBlack", 10,
		"MeasuringTape", 10,
		"TobaccoChewing", 1,
		"Whetstone", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

-- More generic version of the Survivor bag.
-- Contents reflect a wide variety of possible loot sources.
BagsAndContainers.BanditItems = {
	-- Loot
	"Bracelet_BangleRightGold", 1,
	"Bracelet_ChainRightGold", 1,
	"CameraExpensive", 1,
	"CordlessPhone", 1,
	"CreditCard_Stolen", 10,
	"CreditCard_Stolen", 1,
	"Diamond", 1,
	"Earring_LoopLrg_Gold", 1,
	"Earring_LoopMed_Gold", 1,
	"Earring_LoopSmall_Gold_Both", 1,
	"Earring_LoopSmall_Gold_Top", 1,
	"Earring_Stud_Gold", 1,
	"Emerald", 1,
	"GemBag", 0.1,
	"Goblet", 0.1,
	"GoldBar", 0.1,
	"HollowBook_Valuables", 0.1,
	"IDcard_Blank", 0.1,
	"KeyRing_Clover", 0.005,
	"KeyRing_RabbitFoot", 0.1,
	"Locket", 0.1,
	"Medal_Gold", 1,
	"Medal_Silver", 1,
	"MilitaryMedal", 0.1,
	"Money", 50,
	"Money", 50,
	"Money", 20,
	"Money", 20,
	"Money", 10,
	"Money", 10,
	"MoneyBundle", 10,
	"MoneyBundle", 10,
	"MoneyBundle", 1,
	"NecklaceLong_Gold", 1,
	"NecklaceLong_GoldDiamond", 1,
	"Necklace_Gold", 1,
	"Necklace_GoldDiamond", 1,
	"Necklace_GoldRuby", 1,
	"Necklace_Pearl", 1,
	"Photo", 0.1,
	"Photo_Secret", 0.1,
	"Photo_VeryOld", 0.1,
	"Pocketwatch", 0.1,
	"Ring_Left_RingFinger_Gold", 1,
	"Ruby", 1,
	"Sapphire", 1,
	"ScratchTicket", 10,
	"ScratchTicket", 1,
	"ScratchTicket_Winner", 1,
	"SilverBar", 0.1,
	"SmallGoldBar", 1,
	"SmallSilverBar", 1,
	"TrophyGold", 1,
	"WristWatch_Left_ClassicBlack", 1,
	"WristWatch_Left_ClassicBrown", 1,
	"WristWatch_Left_ClassicGold", 1,
	"WristWatch_Left_DigitalDress", 1,
	"WristWatch_Left_Expensive", 0.1,
	-- Random Valuables
	"AlarmClock2", 1,
	"Bricktoys", 1,
	"ButterKnife_Gold", 1,
	"ButterKnife_Silver", 1,
	"Camera", 1,
	"CardDeck", 1,
	"ChristmasOrnament_Gold1", 0.01,
	"ChristmasOrnament_Gold2", 0.01,
	"ChristmasOrnament_Gold3", 0.01,
	"ChristmasOrnament_Green1", 0.01,
	"ChristmasOrnament_Green2", 0.01,
	"ChristmasOrnament_Green3", 0.01,
	"ChristmasOrnament_Red1", 0.01,
	"ChristmasOrnament_Red2", 0.01,
	"ChristmasOrnament_Red3", 0.01,
	"CocktailUmbrella", 0.1,
	"ComicBook", 1,
	"CopperScrap", 1,
	"Cube", 1,
	"Dice", 1,
	"DiceBag", 0.1,
	"ElectricWire", 1,
	"ElectronicsScrap", 1,
	"EngineParts", 1,
	"Firecracker", 1,
	"Fork_Gold", 1,
	"Fork_Silver", 1,
	"HairDyeUncommon", 1,
	"Hairgel", 1,
	"Hairspray2", 1,
	"Harmonica", 1,
	"Hat_BalaclavaFull", 0.1,
	"Hat_HalloweenMaskDevil", 0.05,
	"Hat_HalloweenMaskMonster", 0.05,
	"Hat_HalloweenMaskPumpkin", 0.05,
	"Hat_HalloweenMaskSkeleton", 0.05,
	"Hat_HalloweenMaskVampire", 0.05,
	"Hat_HalloweenMaskWitch", 0.05,
	"Hat_PeakedCapYacht", 0.05,
	"HempBagSeed", 1,
	"HempMag1", 2,
	"Hotsauce", 1,
	"HottieZ", 1,
	"LighterFluid", 1,
	"Mov_FlagUSA", 1,
	"Mov_FlagUSALarge", 1,
	"Mov_HuntingTrophy", 1,
	"NailsBox", 1,
	"NutsBolts", 1,
	"PanchoDog", 0.1,
	"Paperback_Scary", 1,
	"PencilSpiffo", 0.1,
	"PenFancy", 1,
	"PenMultiColor", 1,
	"PenSpiffo", 0.1,
	"Perfume", 1,
	"PetrolCan", 1,
	"PlasticSpoon", 1,
	"PlasticFork", 1,
	"Plushabug", 0.1,
	"PokerChips", 1,
	"PoolBall", 1,
	"RatPoison", 1,
	"Rubberducky", 1,
	"RubberHose", 1,
	"RubberSpider", 1,
	"ScrapMetal", 1,
	"SeedBag", 0.1,
	"SlugRepellent", 1,
	"SmokingPipe", 1,
	"Soap2", 1,
	"Sparklers", 1,
	"Spiffo", 0.1,
	"SpiffoBig", 0.001,
	"Spoon_Gold", 1,
	"Spoon_Silver", 1,
	"Spork", 1,
	"StraightRazor", 1,
	"ToiletPaper", 10,
	"ToiletPaper", 1,
	"Toothbrush", 1,
	"Toothpaste", 1,
	"ToyBear", 1,
	"ToyCar", 1,
	"TrapMouse", 1,
	"VideoGame", 1,
	"Yoyo", 1,
	-- Story Photos
	"BobPic", 0.001,
	"CaseyPic", 0.001,
	"ChrisPic", 0.001,
	"CortmanPic", 0.001,
	"HankPic", 0.001,
	"JamesPic", 0.001,
	"KatePic", 0.001,
	"MariannePic", 0.001,
	-- Maps
	"LouisvilleMap1", 1,
	"LouisvilleMap2", 1,
	"LouisvilleMap3", 1,
	"LouisvilleMap4", 1,
	"LouisvilleMap5", 1,
	"LouisvilleMap6", 1,
	"LouisvilleMap7", 1,
	"LouisvilleMap8", 1,
	"LouisvilleMap9", 1,
	"MarchRidgeMap", 1,
	"MuldraughMap", 1,
	"RiversideMap", 1,
	"RosewoodMap", 1,
	"WestpointMap", 1,
	-- Food
	"Allsorts", 1,
	"BeefJerky", 1,
	"CandyCaramels", 1,
	"CandyCorn", 1,
	"CandyFruitSlices", 1,
	"CandyGummyfish", 1,
	"CandyNovapops", 1,
	"CandyPackage", 1,
	"CannedBolognese", 10,
	"CannedBolognese", 2,
	"CannedCarrots2", 10,
	"CannedCarrots2", 2,
	"CannedChili", 10,
	"CannedChili", 2,
	"CannedCorn", 10,
	"CannedCorn", 2,
	"CannedCornedBeef", 10,
	"CannedCornedBeef", 2,
	"CannedFruitCocktail", 10,
	"CannedFruitCocktail", 2,
	"CannedMilk", 0.5,
	"CannedMushroomSoup", 10,
	"CannedMushroomSoup", 2,
	"CannedPeaches", 10,
	"CannedPeaches", 2,
	"CannedPeas", 10,
	"CannedPeas", 2,
	"CannedPineapple", 10,
	"CannedPineapple", 2,
	"CannedPotato2", 10,
	"CannedPotato2", 2,
	"CannedSardines", 10,
	"CannedSardines", 2,
	"CannedTomato2", 10,
	"CannedTomato2", 2,
	"Caviar", 0.1, -- because it's posh/funny
	"ChocoCakes", 1,
	"Chocolate", 1,
	"Chocolate_Butterchunkers", 1,
	"Chocolate_Candy", 1,
	"Chocolate_Crackle", 1,
	"Chocolate_Deux", 1,
	"Chocolate_GalacticDairy", 1,
	"Chocolate_RoysPBPucks", 1,
	"Chocolate_Smirkers", 1,
	"Chocolate_SnikSnak", 1,
	"Crackers", 1,
	"Crisps", 1,
	"Crisps", 5,
	"Crisps2", 1,
	"Crisps2", 5,
	"Crisps3", 1,
	"Crisps3", 5,
	"Crisps4", 1,
	"Crisps4", 5,
	"DehydratedMeatStick", 1,
	"DentedCan", 4,
	"Dogfood", 10,
	"Dogfood", 2,
	"GranolaBar", 1,
	"Gum", 1,
	"GummyBears", 1,
	"GummyWorms", 1,
	"HardCandies", 1,
	"HiHis", 1,
	"JellyBeans", 1,
	"Jujubes", 1,
	"LicoriceBlack", 1,
	"LicoriceRed", 1,
	"Lollipop", 1,
	"Macandcheese", 10,
	"Macandcheese", 2,
	"MysteryCan", 8,
	"Peanuts", 1,
	"Peppermint", 1,
	"Plonkies", 1,
	"Pop", 1,
	"Pop2", 1,
	"Pop3", 1,
	"PopBottle", 1,
	"PopBottleRare", 0.1,
	"PorkRinds", 1,
	"QuaggaCakes", 1,
	"Ramen", 10,
	"SnoGlobes", 1,
	"SunflowerSeeds", 1,
	"TinnedBeans", 10,
	"TinnedBeans", 2,
	"TinnedSoup", 10,
	"TinnedSoup", 2,
	"TortillaChips", 5,
	-- Water
	"Bag_LeatherWaterBag", 0.5,
	"Canteen", 1,
	"CanteenCowboy", 0.5,
	"Sportsbottle", 2,
	"WaterBottle", 4,
	-- Medical
	"AdhesiveBandageBox", 1,
	"AlcoholWipes", 4,
	"Antibiotics", 1,
	"AntibioticsBox", 1,
	"Bandage", 2,
	"BandageBox", 1,
	"BandageDirty", 2,
	"Bandaid", 4,
	"ColdpackBox", 1,
	"CottonBallsBox", 1,
	"Disinfectant", 1,
	"FirstAidKit", 1,
	"FirstAidKit_Camping", 0.5,
	"FirstAidKit_Military", 0.5,
	"Pills", 1,
	"Pills", 2,
	"PillsAntiDep", 1,
	"PillsAntiDep", 1,
	"PillsBeta", 1,
	"PillsBeta", 1,
	"PillsSleepingTablets", 1,
	"PillsSleepingTablets", 1,
	"PillsVitamins", 20,
	"PillsVitamins", 4,
	"RippedSheets", 8,
	"RippedSheetsDirty", 4,
	"ScissorsBluntMedical", 1,
	"SutureNeedle", 1,
	"SutureNeedleBox", 1,
	"SutureNeedleHolder", 1,
	-- Alcohol
	"BeerBottle", 10,
	"BeerBottle", 2,
	"BeerCan", 10,
	"BeerCan", 2,
	"BeerPack", 1,
	"BeerCanPack", 1,
	"Brandy", 0.1,
	"Brandy", 1,
	"Flask", 1,
	"Gin", 0.1,
	"Gin", 1,
	"Rum", 0.1,
	"Rum", 1,
	"Scotch", 0.1,
	"Scotch", 1,
	"Tequila", 0.1,
	"Tequila", 1,
	"Vodka", 0.1,
	"Vodka", 1,
	"Whiskey", 0.1,
	"Whiskey", 1,
	"Wine", 0.1,
	"Wine", 1,
	"Wine2", 0.1,
	"Wine2", 1,
	"WineBox", 0.1,
	"WineBox", 1,
	-- Tobacco
	"Cigar", 1,
	"CigaretteCarton", 0.1,
	"CigarettePack", 0.5,
	"CigarettePack", 5,
	"CigaretteRollingPapers", 0.1,
	"CigaretteRollingPapers", 1,
	"Cigarillo", 1,
	"TobaccoChewing", 0.5,
	"TobaccoChewing", 5,
	"TobaccoLoose", 0.1,
	"TobaccoLoose", 1,
	-- Fire/Lighting
	"Candle", 4,
	"DryFirestarterBlock", 1,
	"FlashLight_AngleHead", 1,
	"FlashLight_AngleHead_Army", 0.1,
	"HandTorch", 2,
	"Lantern_Propane", 0.1,
	"Lighter", 1,
	"LighterDisposable", 4,
	"MagnesiumFirestarter", 0.5,
	"Matchbox", 0.5,
	"Matches", 4,
	"PenLight", 1,
	"Propane_Refill", 0.1,
	"Torch", 0.5,
	-- Survival Gear
	"CompassDirectional", 1,
	"CopperCup", 0.5,
	"GasmaskFilter", 0.5,
	"InsectRepellent", 1,
	"MetalCup", 1,
	"WaterPurificationTablets", 0.1,
	"Whistle", 1,
	-- Clothing
	"Hat_BandanaTINT", 8,
	"Hat_DustMask", 2,
	"Hat_SurgicalMask", 2,
	"ShemaghScarf", 0.1,
	-- Electronics/Music
	"CDplayer", 2,
	"Disc_Retail", 4,
	"VHS_Home", 1,
	"VHS_Retail", 4,
	"WalkieTalkie2", 1,
	"WalkieTalkie3", 0.5,
	"WalkieTalkie4", 0.1,
	-- Armor/Padding
	"ElbowPad_Left", 0.1,
	"Kneepad_Left", 0.5,
	-- Maintenance
	"DuctTape", 2,
	"Epoxy", 1,
	"FiberglassTape", 1,
	"Glue", 4,
	"Scotchtape", 4,
	"Whetstone", 1,
	"Woodglue", 2,
	-- Tools/Knives
	"Bag_ProtectiveCaseSmall_KeyCutting", 1,
	"BallPeenHammer", 1,
	"Crowbar", 2,
	"Hammer", 1,
	"HandAxe", 1,
	"HandDrill", 2,
	"Handiknife", 0.1,
	"KnifeButterfly", 0.1,
	"KnifePocket", 0.1,
	"LugWrench", 1,
	"Multitool", 0.01,
	"Pliers", 1,
	"RubberHose", 2,
	"Saw", 1,
	"Scissors", 1,
	"Screwdriver", 4,
	"SheetMetalSnips", 1,
	"TireIron", 1,
	"ViseGrips", 1,
	"Wrench", 1,
	-- Guns/Ammo/Explosives
	"223Box", 6,
	"308Box", 1,
	"556Box", 1,
	"Bag_ChestRig", 1,
	"Bullets38Box", 6,
	"Bullets44Box", 1,
	"Bullets45Box", 1,
	"Bullets9mmBox", 6,
	"DoubleBarrelShotgunSawnoff", 1,
	"Molotov", 1,
	"ShotgunShellsBox", 6,
	-- Recipe Magazines/Schematics
	"ArmorMag1", 4,
	"ArmorMag2", 4,
	"ArmorMag3", 4,
	"ArmorMag4", 4,
	"ArmorMag5", 4,
	"ArmorMag6", 4,
	"ArmorMag7", 4,
	"ArmorSchematic", 4,
	"MeleeWeaponSchematic", 4,
	"WeaponMag1", 4,
	"WeaponMag2", 4,
	"WeaponMag3", 4,
	"WeaponMag4", 4,
	"WeaponMag5", 4,
	"WeaponMag6", 4,
}

BagsAndContainers.BanditBag = {
	rolls = 1,
	items = BagsAndContainers.BanditItems,
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.BanditBag_Early = {
	rolls = 2,
	items = BagsAndContainers.BanditItems,
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.BanditBag_Mid = {
	rolls = 3,
	items = BagsAndContainers.BanditItems,
	junk = {
		rolls = 1,
		items = {

		}
	},
	maxMap = 1,
	-- this mean 90% chance on normal sandbox settings to have an annoted map
	stashChance = 10,
}

BagsAndContainers.BanditBag_Late = {
	rolls = 4,
	items = BagsAndContainers.BanditItems,
	junk = {
		rolls = 1,
		items = {

		}
	},
	maxMap = 1,
	-- this mean 90% chance on normal sandbox settings to have an annoted map
	stashChance = 10,
}

BagsAndContainers.Cashbox = {
	rolls = 4,
	items = {
		"Money", 50,
		"Money", 50,
		"Money", 20,
		"Money", 20,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.CigarBox = {
	rolls = 4,
	items = {
		"Cigar", 50,
		"Cigar", 20,
		"Cigar", 20,
		"Cigar", 10,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.CigarBox_Gaming = {
	rolls = 1,
	items = {
		"Dice", 20,
		"DiceBag", 200,
		"Dice_00", 20,
		"Dice_10", 20,
		"Dice_12", 20,
		"Dice_20", 50,
		"Dice_4", 20,
		"Dice_6", 20,
		"Dice_8", 20,
		"Eraser", 100,
		"Pencil", 100,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.CigarBox_Keepsakes = {
	rolls = 4,
	items = {
		"LetterHandwritten", 50,
		"Lighter", 20,
		"Locket", 20,
		"Medal_Bronze", 20,
		"Medal_Gold", 10,
		"Medal_Silver", 20,
		"MilitaryMedal", 20,
		"Necklace_DogTag", 10,
		"Necklace_SilverCrucifix", 10,
		"PenFancy", 10,
		"Photo", 20,
		"Photo", 50,
		"Photo_VeryOld", 20,
		"Pocketwatch", 10,
		"Postcard", 50,
		"Ring_Left_RingFinger_Gold", 20,
		"SmokingPipe", 10,
		"StraightRazor", 10,
		"WristWatch_Left_Expensive", 1,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.CigarBox_Kids = {
	rolls = 4,
	items = {
		"Bracelet_LeftFriendshipTINT", 10,
		"CardDeck", 20,
		"Dice", 50,
		"DoodleKids", 50,
		"Firecracker", 10,
		"Glasses_3dGlasses", 1,
		"Glasses_Groucho", 1,
		"Glasses_Novelty_Xray", 1,
		"Glasses_Venetian", 1,
		"Harmonica", 20,
		"Money", 50,
		"Money", 20,
		"RubberSpider", 10,
		"SwitchKnife", 0.001,
		"ToyCar", 50,
		"Whistle", 20,
		"Yoyo", 20,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.Clothing_Generic = {
	rolls = 1,
	items = {
		-- Jackets
		"Jacket_ArmyCamoDesert", 0.1,
		"Jacket_ArmyCamoGreen", 0.1,
		"Jacket_Black", 0.5,
		"Jacket_PaddedDOWN", 0.1,
		"Jacket_Shellsuit_Black", 0.1,
		"Jacket_Shellsuit_Blue", 0.1,
		"Jacket_Shellsuit_Green", 0.1,
		"Jacket_Shellsuit_Pink", 0.1,
		"Jacket_Shellsuit_Teal", 0.1,
		"Jacket_Shellsuit_TINT", 1,
		"Jacket_Varsity", 0.1,
		"Jacket_WhiteTINT", 1,
		-- Gloves
		"Gloves_FingerlessGloves", 1,
		"Gloves_LeatherGloves", 0.6,
		"Gloves_LeatherGlovesBlack", 0.4,
		"Gloves_LongWomenGloves", 0.4,
		"Gloves_WhiteTINT", 1,
		-- Accessories
		"Scarf_StripeBlackWhite", 0.1,
		"Scarf_StripeBlueWhite", 0.1,
		"Scarf_StripeRedWhite", 0.1,
		"Scarf_White", 0.1,
		"ShemaghScarf", 0.01,
		-- Headwear
		"Hat_Bandana", 0.1,
		"Hat_BaseballCap", 0.5,
		"Hat_BaseballCapBlue", 0.5,
		"Hat_BaseballCapGreen", 0.5,
		"Hat_BaseballCapKY", 0.5,
		"Hat_BaseballCapKY_Red", 0.5,
		"Hat_BaseballCapRed", 0.5,
		"Hat_Beany", 0.5,
		"Hat_Beret", 0.5,
		"Hat_BucketHat", 0.5,
		-- Sweaters/Vests
		"HoodieDOWN_WhiteTINT", 4,
		"Jumper_DiamondPatternTINT", 1,
		"Jumper_PoloNeck", 2,
		"Jumper_RoundNeck", 2,
		"Jumper_TankTopTINT", 4,
		"Jumper_VNeck", 4,
		-- Shirts/T-shirts
		"Shirt_Denim", 0.5,
		"Shirt_HawaiianRed", 0.1,
		"Shirt_HawaiianTINT", 0.1,
		"Shirt_Lumberjack", 1,
		"Shirt_Lumberjack_TINT", 1,
		"Tshirt_DefaultDECAL_TINT", 0.5,
		"Tshirt_DefaultTEXTURE_TINT", 4,
		"Tshirt_IndieStoneDECAL", 0.001,
		"Tshirt_LongSleeve_SuperColor", 1,
		"Tshirt_PoloStripedTINT", 1,
		"Tshirt_PoloTINT", 1,
		"Tshirt_Rock", 1,
		"Tshirt_SuperColor", 1,
		"Tshirt_TieDye", 1,
		"Tshirt_WhiteLongSleeveTINT", 1,
		"Tshirt_WhiteTINT", 2,
		-- Crop-tops
		"BoobTube", 2,
		"BoobTubeSmall", 2,
		"Shirt_CropTopNoArmTINT", 1,
		"Shirt_CropTopTINT", 1,
		-- Pants/Shorts
		"Dungarees", 0.1,
		"Shorts_LongDenim", 2,
		"TrousersMesh_DenimLight", 1,
		"TrousersMesh_Leather", 0.1,
		"Trousers_DefaultTEXTURE_TINT", 1,
		"Trousers_Denim", 1,
		"Trousers_JeanBaggy", 1,
		"Trousers_LeatherBlack", 0.1,
		"Trousers_Padded", 0.1,
		"Trousers_Shellsuit_Black", 0.1,
		"Trousers_Shellsuit_Blue", 0.1,
		"Trousers_Shellsuit_Green", 0.1,
		"Trousers_Shellsuit_Pink", 0.1,
		"Trousers_Shellsuit_Teal", 0.1,
		"Trousers_Shellsuit_TINT", 1,
		-- Dresses/Skirts
		"DressKnees_Straps", 1,
		"Dress_Knees", 2,
		"Dress_Long", 2,
		"Dress_long_Straps", 1,
		"Dress_Normal", 2,
		"Dress_Short", 2,
		"Dress_SmallBlackStrapless", 1,
		"Dress_SmallBlackStraps", 1,
		"Dress_SmallStrapless", 1,
		"Dress_SmallStraps", 1,
		"Dress_Straps", 1,
		"Skirt_Knees", 2,
		"Skirt_Long", 2,
		"Skirt_Normal", 2,
		-- Leggings
		"StockingsBlack", 0.1,
		"StockingsBlackSemiTrans", 0.1,
		"StockingsBlackTrans", 0.1,
		"StockingsWhite", 1,
		"TightsBlack", 0.1,
		"TightsBlackSemiTrans", 0.1,
		"TightsBlackTrans", 0.1,
		"TightsFishnets", 0.1,
		-- Socks
		"Socks_Ankle", 10,
		"Socks_Ankle_White", 10,
		"Socks_Heavy", 4,
		"Socks_Long", 10,
		"Socks_Long_White", 10,
		-- Underwear
		"Boxers_Hearts", 1,
		"Boxers_RedStripes", 1,
		"Boxers_Silk_Black", 0.1,
		"Boxers_Silk_Red", 0.1,
		"Boxers_White", 4,
		"Briefs_AnimalPrints", 1,
		"Briefs_SmallTrunks_Black", 0.1,
		"Briefs_SmallTrunks_Blue", 0.1,
		"Briefs_SmallTrunks_Red", 0.1,
		"Briefs_SmallTrunks_WhiteTINT", 0.5,
		"Briefs_White", 4,
		"FrillyUnderpants_Black", 1,
		"FrillyUnderpants_Pink", 1,
		"FrillyUnderpants_Red", 1,
		"LongJohns", 0.1,
		"LongJohns_Bottoms", 0.1,
		"Underpants_Black", 2,
		"Underpants_White", 2,
		-- Bras
		"Bra_Strapless_AnimalPrint", 1,
		"Bra_Strapless_Black", 1,
		"Bra_Strapless_FrillyBlack", 1,
		"Bra_Strapless_FrillyPink", 1,
		"Bra_Strapless_RedSpots", 1,
		"Bra_Strapless_White", 1,
		"Bra_Straps_AnimalPrint", 1,
		"Bra_Straps_Black", 2,
		"Bra_Straps_FrillyBlack", 1,
		"Bra_Straps_FrillyPink", 1,
		"Bra_Straps_White", 2,
		-- Footwear
		"Shoes_Black", 0.5,
		"Shoes_BlackBoots", 0.5,
		"Shoes_BlueTrainers", 0.5,
		"Shoes_Fancy", 0.1,
		"Shoes_FlipFlop", 0.5,
		"Shoes_HikingBoots", 0.5,
		"Shoes_Random", 0.5,
		"Shoes_RedTrainers", 0.1,
		"Shoes_Sandals", 0.5,
		"Shoes_Strapped", 0.5,
		"Shoes_TrainerTINT", 0.5,
		"Shoes_WorkBoots", 0.5,
		-- Misc.
		"Belt2", 4,
		"LongCoat_Bathrobe", 0.1,
		"Vest_DefaultTEXTURE_TINT", 4,
		-- Formalwear
		"Shirt_FormalTINT", 2,
		"Shirt_FormalWhite", 1,
		"Shirt_FormalWhite_ShortSleeve", 1,
		"Shirt_FormalWhite_ShortSleeveTINT", 1,
		"Suit_Jacket", 0.5,
		"Suit_JacketTINT", 0.1,
		"Trousers_Suit", 0.5,
		"Trousers_SuitTEXTURE", 0.5,
		"Trousers_SuitWhite", 0.1,
		"Trousers_WhiteTINT", 4,
		-- Swimwear
		"Bikini_Pattern01", 1,
		"Bikini_TINT", 1,
		"SwimTrunks_Blue", 0.1,
		"SwimTrunks_Green", 0.1,
		"SwimTrunks_Red", 0.1,
		"SwimTrunks_Yellow", 0.1,
		-- Sportswear
		"Hat_GolfHat", 0.8,
		"Hat_GolfHatTINT", 0.5,
		"Hat_Sweatband", 1,
		"Hat_VisorBlack", 0.5,
		"Hat_VisorRed", 0.5,
		"Hat_Visor_WhiteTINT", 1,
		"Shirt_Baseball_KY", 0.5,
		"Shirt_Baseball_Rangers", 0.5,
		"Shirt_Baseball_Z", 0.5,
		"Shorts_LongSport", 2,
		"Shorts_ShortSport", 2,
		"Trousers_Sport", 1,
		"Tshirt_Sport", 1,
		"Tshirt_SportDECAL", 0.5,
		-- Camo/Military
		"Shirt_CamoDesert", 0.1,
		"Shirt_CamoGreen", 0.1,
		"Shirt_CamoUrban", 0.1,
		"Shorts_CamoGreenLong", 0.1,
		"Shorts_CamoUrbanLong", 0.1,
		"Trousers_CamoDesert", 0.1,
		"Trousers_CamoGreen", 0.1,
		"Trousers_CamoUrban", 0.1,
		"Tshirt_ArmyGreen", 0.1,
		"Tshirt_CamoDesert", 0.1,
		"Tshirt_CamoGreen", 0.1,
		"Tshirt_CamoUrban", 0.1,
		-- Special
		"Corset", 0.01,
		"Corset_Black", 0.01,
		"Garter", 0.01,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.CookieJar = {
	rolls = 4,
	items = {
		"CookieChocolateChip", 40,
		"CookieJelly", 10,
		"CookiesChocolate", 10,
		"CookiesOatmeal", 20,
		"CookiesShortbread", 10,
		"CookiesSugar", 10,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.Empty = {
	rolls = 1,
	items = {
	},
	junk = {
		rolls = 1,
		items = {
		}
	}
}

BagsAndContainers.Farming = {
	rolls = 3,
	items = {
		-- Crops
		"BarleyBagSeed", 8,
		"CornBagSeed", 8,
		"FlaxBagSeed", 8,
		"HopsBagSeed", 4,
		"RyeBagSeed", 8,
		"TobaccoBagSeed", 4,
		"WheatBagSeed", 8,
		"WheatSack", 1,
		"WheatSeed", 8,
		"WheatSeedSack", 1,
		"WheatSheafDried", 8,
		-- Fruits/Vegetables/Etc.
		"BellPepperBagSeed", 2,
		"BroccoliBagSeed2", 2,
		"CabbageBagSeed2", 2,
		"CarrotBagSeed2", 2,
		"CauliflowerBagSeed", 2,
		"CucumberBagSeed", 2,
		"GarlicBagSeed", 1,
		"GreenpeasBagSeed", 2,
		"HabaneroBagSeed", 0.5,
		"JalapenoBagSeed", 1,
		"KaleBagSeed", 1,
		"LeekBagSeed", 2,
		"LettuceBagSeed", 2,
		"OnionBagSeed", 2,
		"PotatoBagSeed2", 4,
		"PumpkinBagSeed", 1,
		"RedRadishBagSeed2", 2,
		"SpinachBagSeed", 2,
		"StrewberrieBagSeed2", 4,
		"SugarBeetBagSeed", 2,
		"SunflowerBagSeed", 4,
		"SweetPotatoBagSeed", 4,
		"TobaccoBagSeed", 4,
		"TomatoBagSeed2", 2,
		"TurnipBagSeed", 4,
		"WatermelonBagSeed", 2,
		"ZucchiniBagSeed", 2,
		-- Literature
		"BookFarming1", 10,
		"FarmingMag1", 2,
		"FarmingMag2", 2,
		"FarmingMag3", 2,
		"FarmingMag4", 2,
		"FarmingMag5", 2,
		"FarmingMag6", 2,
		"FarmingMag7", 2,
		"FarmingMag8", 2,
		-- Tools
		"CarpentryChisel", 2,
		"Fleshing_Tool", 10,
		"GardenSaw", 10,
		"HandAxe", 4,
		"HandDrill", 10,
		"HandFork", 10,
		"HandScythe", 2,
		"HandShovel", 10,
		"KnifePocket", 1,
		"Pliers", 10,
		"Scissors", 10,
		-- Clothing
		"Gloves_LeatherGloves", 10,
		"Hat_SummerHat", 10,
		"Kneepad_Left_Workman", 10,
		-- Misc.
		"MeasuringTape", 10,
		"BurlapPiece", 4,
		"RatPoison", 8,
		"RubberHose", 10,
		"SlugRepellent", 4,
		"Twine", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.FirstAidKit = {
	rolls = 1,
	items = {
		"AlcoholWipes", 50,
		"AlcoholWipes", 20,
		"AlcoholWipes", 10,
		"Bandage", 50,
		"Bandage", 20,
		"Bandage", 10,
		"Bandaid", 50,
		"Bandaid", 20,
		"Bandaid", 10,
		"BookFirstAid1", 10,
		"Coldpack", 10,
		"CottonBalls", 10,
		"Disinfectant", 10,
		"Gloves_Surgical", 10,
		"Gloves_Surgical", 10,
		"Pills", 10,
		"Scalpel", 5,
		"ScissorsBlunt", 10,
		"ScissorsBluntMedical", 10,
		"Scotchtape", 10,
		"SutureNeedle", 50,
		"SutureNeedle", 20,
		"SutureNeedle", 10,
		"SutureNeedleHolder", 20,
		"Tweezers", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.Gardening = {
	rolls = 3,
	items = {
		-- Herbs
		"BasilBagSeed", 4,
		"ChivesBagSeed", 4,
		"CilantroBagSeed", 4,
		"LemonGrassBagSeed", 4,
		"MintBagSeed", 4,
		"OreganoBagSeed", 4,
		"ParsleyBagSeed", 4,
		"RosemaryBagSeed", 4,
		"SageBagSeed", 4,
		"ThymeBagSeed", 4,
		-- Fruits/Vegetables/Etc.
		"BellPepperBagSeed", 2,
		"BroccoliBagSeed2", 2,
		"CabbageBagSeed2", 2,
		"CarrotBagSeed2", 2,
		"CauliflowerBagSeed", 2,
		"CucumberBagSeed", 2,
		"GarlicBagSeed", 1,
		"GreenpeasBagSeed", 2,
		"HabaneroBagSeed", 0.5,
		"JalapenoBagSeed", 1,
		"KaleBagSeed", 1,
		"LeekBagSeed", 2,
		"LettuceBagSeed", 2,
		"OnionBagSeed", 2,
		"PotatoBagSeed2", 4,
		"PumpkinBagSeed", 1,
		"RedRadishBagSeed2", 2,
		"SpinachBagSeed", 2,
		"StrewberrieBagSeed2", 4,
		"SugarBeetBagSeed", 2,
		"SunflowerBagSeed", 4,
		"SweetPotatoBagSeed", 4,
		"TobaccoBagSeed", 4,
		"TomatoBagSeed2", 2,
		"TurnipBagSeed", 4,
		"WatermelonBagSeed", 2,
		"ZucchiniBagSeed", 2,
		-- Flowers
		"ChamomileBagSeed", 4,
		"LavenderBagSeed", 4,
		"MarigoldBagSeed", 4,
		"PoppyBagSeed", 4,
		"RoseBagSeed", 4,
		-- Literature
		"BookFarming1", 10,
		"FarmingMag1", 2,
		"FarmingMag2", 2,
		"FarmingMag3", 2,
		"FarmingMag4", 2,
		"FarmingMag5", 2,
		"FarmingMag6", 2,
		"FarmingMag7", 2,
		"FarmingMag8", 2,
		-- Tools
		"GardenSaw", 10,
		"HandDrill", 10,
		"HandAxe", 4,
		"HandFork", 10,
		"HandScythe", 2,
		"HandShovel", 10,
		"KnifePocket", 1,
		"Pliers", 10,
		"Scissors", 10,
		-- Clothing
		"Gloves_LeatherGloves", 10,
		"Hat_SummerHat", 10,
		"Kneepad_Left_Workman", 10,
		-- Misc.
		"MeasuringTape", 10,
		"BurlapPiece", 4,
		"RatPoison", 2,
		"RubberHose", 10,
		"SlugRepellent", 10,
		"Twine", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.HalloweenCandyBucket = {
	rolls = 2,
	items = {
		-- Snack Cakes
		"ChocoCakes", 1,
		"HiHis", 1,
		"Plonkies", 2,
		"QuaggaCakes", 1,
		"SnoGlobes", 1,
		-- Candy
		"Allsorts", 2,
		"CandyCaramels", 4,
		"CandyCorn", 10,
		"CandyFruitSlices", 1,
		"CandyGummyfish", 4,
		"CandyMolasses", 10,
		"CandyNovapops", 4,
		"Chocolate", 4,
		"Chocolate_Butterchunkers", 4,
		"Chocolate_Candy", 4,
		"Chocolate_Crackle", 4,
		"Chocolate_Deux", 4,
		"Chocolate_GalacticDairy", 4,
		"Chocolate_RoysPBPucks", 4,
		"Chocolate_Smirkers", 4,
		"Chocolate_SnikSnak", 4,
		"GummyBears", 4,
		"GummyWorms", 4,
		"HardCandies", 2,
		"JellyBeans", 4,
		"Jujubes", 4,
		"LicoriceBlack", 2,
		"LicoriceRed", 4,
		"MintCandy", 2,
		"Modjeska", 1,
		"Peppermint", 2,
		"RockCandy", 1,
		-- Snacks/Drinks
		"CandiedApple", 8,
		"Crisps", 1,
		"Crisps2", 1,
		"Crisps3", 1,
		"Crisps4", 1,
		"GranolaBar", 8,
		"Gum", 4,
		"Peanuts", 2,
		"Pop", 1,
		"Pop2", 1,
		"Pop3", 1,
		"SodaCan", 1,
		--"SodaCanRare", 0.1,
		-- Misc.
		"Money", 4,
		"Toothbrush", 1,
		"Toothpaste", 1,
		"Whistle", 2,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.HandbagsAndPurses = {
	rolls = 2,
	items = {
		-- Keys/Keyrings
		"CarKey", 10,
		"KeyRing", 10,
		"Key1", 0.5,
		"Key1", 0.5,
		"Key1", 0.5,
		-- Stationery/Office
		"BluePen", 10,
		"Calculator", 1,
		"Pen", 10,
		"PenFancy", 0.1,
		"Pencil", 6,
		-- Money
		"Money", 50,
		"Money", 20,
		"Money", 10,
		-- Pills
		"Pills", 1,
		"PillsAntiDep", 0.01,
		"PillsBeta", 0.01,
		"PillsVitamins", 0.01,
		-- Smoking/Tobacco
		"Lighter", 1,
		"LighterDisposable", 10,
		"Matches", 10,
		-- Cosmetic
		"Comb", 4,
		"Hairgel", 0.1,
		"Hairspray2", 0.1,
		"Lipstick", 6,
		"MakeupEyeshadow", 6,
		"MakeupFoundation", 6,
		"Perfume", 4,
		"Tweezers", 6,
		-- Music
		"CDplayer", 1,
		"Disc_Retail", 2,
		"Earbuds", 1,
		-- Photography
		"Photo", 1,
		"Photo_Secret", 0.001,
		-- Literature (Generic)
		"Brochure", 2,
		"BusinessCard", 1,
		"Diary1", 0.1,
		"Flier", 2,
		"Magazine", 5,
		"Magazine_Popular", 5,
		"Note", 10,
		"Notepad", 10,
		"Paperback", 6,
		"ParkingTicket", 2,
		"Receipt", 10,
		"SpeedingTicket", 2,
		"TVMagazine", 1,
		-- Misc.
		"Bandaid", 6,
		"CardDeck", 1,
		"CigarettePack", 0.5,
		"CreditCard", 10,
		"Glasses_CatsEye", 2,
		"Glasses_CatsEye_Sun", 1,
		"Glasses_JackieO", 0.5,
		"Gum", 10,
		"KnifePocket", 0.1,
		"PokerChips", 0.1,
		"Revolver_Short", 0.1,
		"Tissue", 10,
		"ToiletPaper", 0.1,
		"Wallet_Female", 10,
	},
	junk = {
		rolls = 1,
		items = {
			"IDcard_Female", 10,
		}
	},
}

BagsAndContainers.Guitarcase = {
	onlyOne = true,
	rolls = 100,
	items = {
		"GuitarAcoustic", 4,
		"GuitarElectric", 4,
		"GuitarElectricBass", 4,
	},
	junk = {
		rolls = 1,
		items = {
			"GuitarPick", 50,
			"GuitarPick", 20,
			"TuningFork", 4,
		}
	},
}

BagsAndContainers.Hatbox = {
	onlyOne = true,
	rolls = 10,
	items = {
			-- Special
			"Hat_PeakedCapYacht", 1,
			"Hat_Stovepipe_Black", 0.1,
			-- Stetson
			"Hat_Cowboy", 10,
			-- Wide-Brimmed
			"Hat_SummerFlowerHat", 40,
			"Hat_SummerHat", 40,
			-- Fedora
			"Hat_Fedora", 40,
			"Hat_Fedora_Delmonte", 20,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.HikingBag = {
	rolls = 2,
	items = {
		-- Medical
		"AlcoholWipes", 4,
		"Bandage", 2,
		"Bandaid", 8,
		"FirstAidKit_Camping", 0.1,
		-- Clothing
		"HoodieDOWN_WhiteTINT", 2,
		"PonchoGreenDOWN", 0.5,
		"PonchoYellowDOWN", 0.5,
		"Socks_Heavy", 4,
		"Vest_DefaultTEXTURE_TINT", 4,
		-- Water
		"Bag_LeatherWaterBag", 0.5,
		"Canteen", 2,
		"Sportsbottle", 4,
		-- Tools
		"Handiknife", 0.5,
		"KnifePocket", 0.5,
		"Multitool", 0.01,
		-- Outdoors/Survival
		"Bag_ProtectiveCaseSmall_Survivalist", 0.1,
		"CompassDirectional", 4,
		"HandTorch", 2,
		"InsectRepellent", 4,
		"Mirror", 2,
		"ToiletPaper", 4,
		"WalkieTalkie2", 2,
		"WalkieTalkie3", 1,
		"WaterPurificationTablets", 1,
		"Whistle", 2,
		-- Snacks
		"BeefJerky", 2,
		"DehydratedMeatStick", 4,
		"DriedApricots", 4,
		"GranolaBar", 8,
		"Gum", 10,
		"Peanuts", 4,
		"SunflowerSeeds", 4,
		-- Misc.
		"BathTowel", 2,
		"Magazine_Outdoors", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

-- Accessories that may include high-end jewelry but not always.
BagsAndContainers.JewelleryBox = {
	rolls = 2,
	items = {
		"BellyButton_DangleGold", 2,
		"BellyButton_DangleGoldRuby", 0.5,
		"BellyButton_DangleSilver", 8,
		"BellyButton_DangleSilverDiamond", 1,
		"BellyButton_RingGold", 2,
		"BellyButton_RingGoldDiamond", 0.1,
		"BellyButton_RingGoldRuby", 0.5,
		"BellyButton_RingSilver", 8,
		"BellyButton_RingSilverAmethyst", 4,
		"BellyButton_RingSilverDiamond", 1,
		"BellyButton_RingSilverRuby", 2,
		"BellyButton_StudGold", 2,
		"BellyButton_StudGoldDiamond", 0.1,
		"BellyButton_StudSilver", 8,
		"BellyButton_StudSilverDiamond", 1,
		"Bracelet_BangleLeftGold", 2,
		"Bracelet_BangleLeftSilver", 8,
		"Bracelet_ChainLeftGold", 2,
		"Bracelet_ChainLeftSilver", 8,
		"Earring_Dangly_Diamond", 0.1,
		"Earring_Dangly_Emerald", 0.1,
		"Earring_Dangly_Pearl", 1,
		"Earring_Dangly_Ruby", 0.5,
		"Earring_Dangly_Sapphire", 0.5,
		"Earring_LoopLrg_Gold", 1,
		"Earring_LoopLrg_Silver", 4,
		"Earring_LoopMed_Gold", 1,
		"Earring_LoopMed_Silver", 4,
		"Earring_LoopSmall_Gold_Both", 1,
		"Earring_LoopSmall_Gold_Top", 1,
		"Earring_LoopSmall_Silver_Both", 4,
		"Earring_LoopSmall_Silver_Top", 4,
		"Earring_Stone_Emerald", 0.1,
		"Earring_Stone_Ruby", 0.1,
		"Earring_Stone_Sapphire", 0.1,
		"Earring_Stud_Gold", 2,
		"Earring_Stud_Silver", 4,
		"Necklace_Choker", 10,
		"Necklace_Choker_Amber", 4,
		"Necklace_Choker_Diamond", 1,
		"Necklace_Choker_Sapphire", 2,
		"Necklace_Crucifix", 4,
		"Necklace_SilverCrucifix", 1,
		"Necklace_YingYang", 8,
		"NoseRing_Gold", 2,
		"NoseRing_Silver", 8,
		"NoseStud_Gold", 2,
		"NoseStud_Silver", 8,
		"Ring_Left_RingFinger_Gold", 2,
		"Ring_Left_RingFinger_GoldDiamond", 0.1,
		"Ring_Left_RingFinger_GoldRuby", 0.5,
		"Ring_Left_RingFinger_Silver", 4,
		"Ring_Left_RingFinger_SilverDiamond", 0.5,
		"WristWatch_Left_DigitalDress", 4,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

-- Precious valuables and family heirlooms.
BagsAndContainers.JewelleryBox_Fancy = {
	rolls = 2,
	items = {
		-- Rings
		"Ring_Left_RingFinger_Gold", 4,
		"Ring_Left_RingFinger_GoldDiamond", 1,
		"Ring_Left_RingFinger_GoldRuby", 2,
		"Ring_Left_RingFinger_Silver", 8,
		"Ring_Left_RingFinger_SilverDiamond", 2,
		-- Bracelets
		"Bracelet_BangleLeftGold", 4,
		"Bracelet_BangleLeftSilver", 8,
		"Bracelet_ChainLeftGold", 4,
		"Bracelet_ChainLeftSilver", 8,
		-- Earrings
		"Earring_Dangly_Diamond", 1,
		"Earring_Dangly_Emerald", 4,
		"Earring_Dangly_Ruby", 4,
		"Earring_Dangly_Sapphire", 4,
		"Earring_LoopLrg_Gold", 8,
		"Earring_LoopLrg_Silver", 8,
		"Earring_LoopMed_Gold", 8,
		"Earring_LoopMed_Silver", 8,
		"Earring_LoopSmall_Gold_Both", 8,
		"Earring_LoopSmall_Gold_Top", 8,
		"Earring_LoopSmall_Silver_Both", 8,
		"Earring_LoopSmall_Silver_Top", 8,
		"Earring_Pearl", 10,
		"Earring_Dangly_Pearl", 10,
		"Earring_Stone_Emerald", 4,
		"Earring_Stone_Ruby", 4,
		"Earring_Stone_Sapphire", 4,
		-- Necklaces
		"NecklaceLong_Gold", 8,
		"NecklaceLong_GoldDiamond", 1,
		"NecklaceLong_Silver", 8,
		"NecklaceLong_SilverDiamond", 2,
		"NecklaceLong_SilverEmerald", 4,
		"NecklaceLong_SilverSapphire", 4,
		"Necklace_Gold", 8,
		"Necklace_GoldDiamond", 1,
		"Necklace_GoldRuby", 2,
		"Necklace_Pearl", 10,
		"Necklace_Silver", 8,
		"Necklace_SilverCrucifix", 8,
		"Necklace_SilverDiamond", 2,
		"Necklace_SilverSapphire", 4,
		-- Memorabilia
		"Photo_VeryOld", 10,
		"Pocketwatch", 8,
		"WristWatch_Left_Expensive", 2,
		-- Special
		"GemBag", 0.001,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.KeyCutting = {
	rolls = 2,
	items = {
		-- Blank Keys
		"Key_Blank", 50,
		"Key_Blank", 20,
		"Key_Blank", 20,
		"Key_Blank", 10,
		-- Literature
		"KeyMag1", 4,
	},
	junk = {
		rolls = 1,
		items = {
			"SmallFileSet", 100,
		}
	}
}

BagsAndContainers.KeyRing = {
	rolls = 2,
	items = {
		"CarKey", 50,
		"Key1", 50,
		"Key1", 50,
		"Key1", 50,
		"Key1", 50,
		"Key1", 50,
	},
	junk = {
		rolls = 1,
		items = {
			"BottleOpener_Keychain", 10,
		}
	}
}

BagsAndContainers.KeyRingOutdoors = {
	rolls = 2,
	items = {
		"CarKey", 50,
		"Key1", 50,
		"Key1", 50,
		"Key1", 50,
		"Key1", 50,
		"Key1", 50,
	},
	junk = {
		rolls = 1,
		items = {
			"BottleOpener_Keychain", 10,
		    "CompassDirectional", 1,
			"Handiknife", 1,
			"P38", 1,
			"Whistle", 1,
		}
	}
}

BagsAndContainers.Lunchbox = {
	rolls = 2,
	items = {
		"Apple", 20,
		"Banana", 20,
		"BeefJerky", 10,
		"Burrito", 10,
		"Chocolate", 10,
		"CinnamonRoll", 10,
		"CookieChocolateChip", 10,
		"CookieJelly", 10,
		"CookiesChocolate", 10,
		"CookiesOatmeal", 10,
		"CookiesShortbread", 10,
		"DehydratedMeatStick", 10,
		"DoughnutChocolate", 10,
		"DoughnutFrosted", 10,
		"DoughnutJelly", 10,
		"DoughnutPlain", 10,
		"GranolaBar", 20,
		"MuffinFruit", 20,
		"MuffinGeneric", 20,
		"Orange", 20,
		"Painauchocolat", 10,
		"Pretzel", 10,
		"Yoghurt", 20,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.MakeupCase_Professional = {
	rolls = 4,
	items = {
		-- Haircare
		"HairDyeCommon", 20,
		"HairDyeRare", 4,
		"HairDyeUncommon", 10,
		"Hairgel", 20,
		"Hairspray2", 50,
		"Hairspray2", 20,
		-- Makeup
		"Clitter", 10,
		"Lipstick", 20,
		"MakeupEyeshadow", 50,
		"MakeupEyeshadow", 20,
		"MakeupFoundation", 50,
		"MakeupFoundation", 20,
		-- Tools
		"Comb", 20,
		"HairDryer", 10,
		"HairIron", 10,
		"Mirror", 10,
		"Razor", 10,
		"Scissors", 20,
		"Tweezers", 20,
		-- Misc.
		"Book_Fashion", 1,
		"Magazine_Fashion", 10,
		"Paperback_Fashion", 4,
		"Perfume", 20,
		"Tissue", 20,
		"TissueBox", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.MoneyBag = {
	rolls = 4,
	items = {
		"GemBag", 1,
		"Money", 100,
		"Money", 50,
		"Money", 50,
		"Money", 20,
		"MoneyBundle", 100,
		"MoneyBundle", 50,
		"MoneyBundle", 20,
		"StockCertificate", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.Parcel_ExtraSmall = {
	onlyOne = true,
	rolls = 100,
	items = {
		"Allsorts", 10,
		"Bobber", 10,
		"Book", 10,
		"Cheese", 10,
		"Cigar", 10,
		"Cologne", 10,
		"Cube", 10,
		"Disc_Retail", 10,
		"Doll", 10,
		"FishingTackle", 10,
		"FishingTackle2", 10,
		"Handiknife", 10,
		"Harmonica", 10,
		"Headphones", 10,
		"HottieZ", 1,
		"KnifePocket", 10,
		"Locket", 10,
		"MapleSyrup", 10,
		"Multitool", 1,
		"Paperback", 10,
		"Perfume", 10,
		"Pocketwatch", 10,
		"Soap2", 10,
		"Socks_Ankle", 10,
		"Socks_Ankle_Black", 10,
		"Socks_Ankle_White", 10,
		"Socks_Heavy", 4,
		"Socks_Long", 10,
		"Socks_Long_Black", 10,
		"Socks_Long_White", 10,
		"StraightRazor", 10,
		"ToyCar", 10,
		"TrickMag1", 1,
		"VHS_Retail", 10,
		"VideoGame", 10,
		"Wallet", 10,
		"Whetstone", 10,
		"WristWatch_Left_ClassicGold", 10,
		"Yoyo", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.Parcel_Small = {
	onlyOne = true,
	rolls = 100,
	items = {
		"BathTowel", 10,
		"Camera", 10,
		"CameraExpensive", 10,
		"CDplayer", 10,
		"Jumper_DiamondPatternTINT", 10,
		"Jumper_PoloNeck", 10,
		"Jumper_RoundNeck", 10,
		"Jumper_VNeck", 10,
		"Kettle", 10,
		"Kettle_Copper", 1,
		"RadioRed", 10,
		"Whiskey", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.Parcel_Medium = {
	onlyOne = true,
	rolls = 100,
	items = {
		"Mov_CoffeeMaker", 10,
		"Mov_Toaster", 10,
		"Wine", 10,
		"Wine2", 10,
		"WineBox", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.Parcel_Large = {
	onlyOne = true,
	rolls = 100,
	items = {
		"Mov_FridgeMini", 10,
		"Mov_Microwave", 10,
		"Mov_Microwave2", 10,
		"TvWideScreen", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.Parcel_ExtraLarge = {
	onlyOne = true,
	rolls = 100,
	items = {
		"Bag_ProtectiveCaseBulky_HAMRadio1", 0.5,
		"HamRadio1", 0.5,
		"Mov_DesktopComputer", 10,
		"Mov_FitnessContraption", 10,
		"Mov_RedBBQ", 10,
		"Mov_SatelliteDish", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.PencilCase = {
	rolls = 2,
	items = {
		"BluePen", 4,
		"Calculator", 1,
		"CompassGeometry", 2,
		"CorrectionFluid", 1,
		"Crayons", 10,
		"Eraser", 8,
		"GreenPen", 4,
		"MarkerBlack", 2,
		"MarkerBlue", 1,
		"MarkerGreen", 1,
		"MarkerRed", 1,
		"Pen", 4,
		"Pencil", 20,
		"PencilSpiffo", 0.005,
		"PenMultiColor", 2,
		"PenSpiffo", 0.005,
		"RedPen", 4,
		"RubberBand", 8,
		"ScissorsBlunt", 4,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.PencilCase_Gaming = {
	rolls = 1,
	items = {
		"Dice", 20,
		"DiceBag", 200,
		"Dice_00", 20,
		"Dice_10", 20,
		"Dice_12", 20,
		"Dice_20", 50,
		"Dice_4", 20,
		"Dice_6", 20,
		"Dice_8", 20,
		"Eraser", 100,
		"Pencil", 100,
	},
	junk = {
		rolls = 1,
		items = {

		}
	}
}

BagsAndContainers.PistolCase1 = {
	rolls = 1,
	items = {
		"Pistol", 200,
		"9mmClip", 200,
		"9mmClip", 10,
		"Bullets9mmBox", 200,
		"Bullets9mmBox", 50,
		"Bullets9mmBox", 20,
		"Bullets9mmBox", 10,
		"HolsterShoulder", 1,
		"GunLight", 2,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.PistolCase2 = {
	rolls = 1,
	items = {
		"Pistol2", 200,
		"45Clip", 200,
		"45Clip", 10,
		"Bullets45Box", 200,
		"Bullets45Box", 50,
		"Bullets45Box", 20,
		"Bullets45Box", 10,
		"HolsterShoulder", 1,
		"GunLight", 2,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.PistolCase3 = {
	rolls = 1,
	items = {
		"Pistol3", 200,
		"44Clip", 200,
		"44Clip", 10,
		"Bullets44Box", 200,
		"Bullets44Box", 50,
		"Bullets44Box", 20,
		"Bullets44Box", 10,
		"HolsterShoulder", 1,
		"GunLight", 2,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.Plasticbags = {
	rolls = 10,
	items = {
		"Plasticbag", 20,
		"Plasticbag", 20,
		"Plasticbag", 20,
		"Plasticbag", 20,
		"Plasticbag", 20,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.Bag_Police = {
	rolls = 2,
	items = {
		"223Box", 10,
		"308Box", 10,
		"44Clip", 8,
		"45Clip", 8,
		"9mmClip", 8,
		"AmmoStraps", 6,
		"AssaultRifle2", 2,
		"Bullets38Box", 10,
		"Bullets44Box", 10,
		"Bullets45Box", 10,
		"Bullets9mmBox", 10,
		"ChokeTubeFull", 6,
		"ChokeTubeImproved", 6,
		"Crowbar", 8,
		"FirstAidKit", 4,
		"Glasses_Shooting", 8,
		"Gloves_FingerlessGloves", 8,
		"HuntingRifle", 4,
		"HolsterAnkle", 1,
		"HolsterShoulder", 2,
		"HolsterSimple_Black", 8,
		"KnifePocket", 4,
		"M14Clip", 8,
		"Nightstick", 8,
		"Pistol", 8,
		"Pistol2", 6,
		"Pistol3", 4,
		"RecoilPad", 6,
		"RedDot", 6,
		"Revolver", 6,
		"Revolver_Long", 4,
		"Revolver_Short", 8,
		"Shotgun", 10,
		"ShotgunSawnoff", 10,
		"ShotgunShellsBox", 10,
		"VarmintRifle", 8,
		"Vest_BulletPolice", 2,
		"x2Scope", 8,
		"x4Scope", 6,
		"x8Scope", 4,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Apple = {
	rolls = 8,
	items = {
		"Apple", 50,
		"Apple", 20,
		"Apple", 20,
		"Apple", 10,
		"Apple", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_BellPepper = {
	rolls = 8,
	items = {
		"BellPepper", 50,
		"BellPepper", 20,
		"BellPepper", 20,
		"BellPepper", 10,
		"BellPepper", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Broccoli = {
	rolls = 8,
	items = {
		"Broccoli", 50,
		"Broccoli", 20,
		"Broccoli", 20,
		"Broccoli", 10,
		"Broccoli", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Cabbage = {
	rolls = 8,
	items = {
		"Cabbage", 50,
		"Cabbage", 20,
		"Cabbage", 20,
		"Cabbage", 10,
		"Cabbage", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Carrot = {
	rolls = 8,
	items = {
		"Carrots", 50,
		"Carrots", 20,
		"Carrots", 20,
		"Carrots", 10,
		"Carrots", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Cauliflower = {
	rolls = 8,
	items = {
		"Cauliflower", 50,
		"Cauliflower", 20,
		"Cauliflower", 20,
		"Cauliflower", 10,
		"Cauliflower", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Cherry = {
	rolls = 12,
	items = {
		"Cherry", 50,
		"Cherry", 20,
		"Cherry", 20,
		"Cherry", 10,
		"Cherry", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Corn = {
	rolls = 8,
	items = {
		"Corn", 50,
		"Corn", 20,
		"Corn", 20,
		"Corn", 10,
		"Corn", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Eggplant = {
	rolls = 8,
	items = {
		"Eggplant", 50,
		"Eggplant", 20,
		"Eggplant", 20,
		"Eggplant", 10,
		"Eggplant", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Grapes = {
	rolls = 8,
	items = {
		"Grapes", 50,
		"Grapes", 20,
		"Grapes", 20,
		"Grapes", 10,
		"Grapes", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Greenpeas = {
	rolls = 8,
	items = {
		"Greenpeas", 50,
		"Greenpeas", 20,
		"Greenpeas", 20,
		"Greenpeas", 10,
		"Greenpeas", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Kale = {
	rolls = 8,
	items = {
		"Kale", 50,
		"Kale", 20,
		"Kale", 20,
		"Kale", 10,
		"Kale", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Leek = {
	rolls = 8,
	items = {
		"Leek", 50,
		"Leek", 20,
		"Leek", 20,
		"Leek", 10,
		"Leek", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Lettuce = {
	rolls = 8,
	items = {
		"Lettuce", 50,
		"Lettuce", 20,
		"Lettuce", 20,
		"Lettuce", 10,
		"Lettuce", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Onion = {
	rolls = 8,
	items = {
		"Onion", 50,
		"Onion", 20,
		"Onion", 20,
		"Onion", 10,
		"Onion", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Peach = {
	rolls = 8,
	items = {
		"Peach", 50,
		"Peach", 20,
		"Peach", 20,
		"Peach", 10,
		"Peach", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Pear = {
	rolls = 8,
	items = {
		"Pear", 50,
		"Pear", 20,
		"Pear", 20,
		"Pear", 10,
		"Pear", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Potato = {
	rolls = 8,
	items = {
		"Potato", 50,
		"Potato", 20,
		"Potato", 20,
		"Potato", 10,
		"Potato", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Radish = {
	rolls = 12,
	items = {
		"RedRadish", 50,
		"RedRadish", 20,
		"RedRadish", 20,
		"RedRadish", 10,
		"RedRadish", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Strawberry = {
	rolls = 12,
	items = {
		"Strewberrie", 50,
		"Strewberrie", 20,
		"Strewberrie", 20,
		"Strewberrie", 10,
		"Strewberrie", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_SweetPotato = {
	rolls = 8,
	items = {
		"SweetPotato", 50,
		"SweetPotato", 20,
		"SweetPotato", 20,
		"SweetPotato", 10,
		"SweetPotato", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ProduceStorage_Tomato = {
	rolls = 8,
	items = {
		"Tomato", 50,
		"Tomato", 20,
		"Tomato", 20,
		"Tomato", 10,
		"Tomato", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.RevolverCase1 = {
	rolls = 1,
	items = {
		"Revolver_Short", 200,
		"Bullets38Box", 200,
		"Bullets38Box", 50,
		"Bullets38Box", 20,
		"Bullets38Box", 10,
		"HolsterShoulder", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.RevolverCase2 = {
	rolls = 1,
	items = {
		"Revolver", 200,
		"Bullets45Box", 200,
		"Bullets45Box", 50,
		"Bullets45Box", 20,
		"Bullets45Box", 10,
		"HolsterShoulder", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.RevolverCase3 = {
	rolls = 1,
	items = {
		"Revolver_Long", 200,
		"Bullets44Box", 200,
		"Bullets44Box", 50,
		"Bullets44Box", 20,
		"Bullets44Box", 10,
		"HolsterShoulder", 1,
		"x2Scope", 4,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.RifleCase1 = {
	rolls = 1,
	items = {
		"VarmintRifle", 200,
		"223Box", 200,
		"223Box", 50,
		"223Box", 20,
		"223Box", 10,
		"AmmoStrap_Bullets_223", 2,
		"RecoilPad", 2,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.RifleCase2 = {
	rolls = 1,
	items = {
		"HuntingRifle", 200,
		"308Box", 200,
		"308Box", 50,
		"308Box", 20,
		"308Box", 10,
		"AmmoStrap_Bullets_308", 2,
		"RecoilPad", 2,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.RifleCase3 = {
	rolls = 1,
	items = {
		"AssaultRifle2", 200,
		"M14Clip", 200,
		"M14Clip", 10,
		"308Box", 200,
		"308Box", 50,
		"308Box", 20,
		"308Box", 10,
		"AmmoStrap_Bullets_308", 2,
		"RecoilPad", 2,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.RifleCase4 = {
	rolls = 1,
	items = {
		"AssaultRifle", 200,
		"556Clip", 200,
		"556Clip", 10,
		"556Box", 200,
		"556Box", 50,
		"556Box", 20,
		"556Box", 10,
		"AmmoStrap_Bullets", 2,
		"RecoilPad", 2,
		"RedDot", 2,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.Schoolbag = {
	rolls = 1,
	items = {
		"BluePen", 8,
		"Book", 20,
		"Book", 10,
		"CDplayer", 1,
		"Chocolate", 1,
		"ComicBook", 10,
		"CorrectionFluid", 1,
		"Crisps", 1,
		"Disc_Retail", 2,
		"Earbuds", 1,
		"GranolaBar", 1,
		"Gum", 4,
		"KnifePocket", 0.001,
		"Lighter", 1,
		"Paperback", 10,
		"Pen", 8,
		"Pencil", 10,
		"Pop", 1,
		"RedPen", 8,
		"RPGmanual", 0.1,
		"RubberBand", 1,
		"Scissors", 2,
		"SunflowerSeeds", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.Shoebox = {
	onlyOne = true,
	rolls = 10,
	items = {
		-- Boots
		"Shoes_CowboyBoots", 8,
		"Shoes_CowboyBoots_Fancy", 1,
		"Shoes_CowboyBoots_SnakeSkin", 1,
		-- Sneakers
		"Shoes_TrainerTINT", 10,
		-- Sandals
		"Shoes_Fancy", 20,
		"Shoes_Strapped", 20,
		-- Oxfords
		"Shoes_Brown", 20,
		"Shoes_Black", 40,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

BagsAndContainers.ShotgunCase1 = {
	rolls = 1,
	items = {
		"Shotgun", 200,
		"ShotgunShellsBox", 200,
		"ShotgunShellsBox", 50,
		"ShotgunShellsBox", 20,
		"ShotgunShellsBox", 10,
		"AmmoStrap_Shells", 2,
		"ChokeTubeFull", 4,
		"ChokeTubeImproved", 2,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

BagsAndContainers.ShotgunCase2 = {
	rolls = 1,
	items = {
		"DoubleBarrelShotgun", 200,
		"ShotgunShellsBox", 200,
		"ShotgunShellsBox", 50,
		"ShotgunShellsBox", 20,
		"ShotgunShellsBox", 10,
		"AmmoStrap_Shells", 2,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

-- Item table
BagsAndContainers.SurvivorItems = {
	-- Survival Gear
	"Candle", 20,
	"Candle", 10,
	"CompassDirectional", 10,
	"FlashLight_AngleHead_Army", 1,
	"GasmaskFilter", 20,
	"GasmaskFilter", 10,
	"Hat_GasMask", 10,
	"InsectRepellent", 10,
	"WaterPurificationTablets", 10,
	-- Food
	"BeefJerky", 20,
	"CannedBolognese", 20,
	"CannedCarrots2", 20,
	"CannedChili", 20,
	"CannedCorn", 20,
	"CannedCornedBeef", 20,
	"CannedFruitCocktail", 20,
	"CannedMushroomSoup", 20,
	"CannedPeaches", 20,
	"CannedPeas", 20,
	"CannedPineapple", 20,
	"CannedPotato2", 20,
	"CannedSardines", 20,
	"CannedTomato2", 20,
	"Crisps", 20,
	"Crisps2", 20,
	"Crisps3", 20,
	"Crisps4", 20,
	"Dogfood", 20,
	"Gum", 1,
	"Macandcheese", 10,
	"MysteryCan", 20,
	"PorkRinds", 8,
	"Ramen", 10,
	"TinnedBeans", 20,
	-- Water
	"Bag_LeatherWaterBag", 1,
	"CanteenMilitary", 20,
	"WaterBottle", 10,
	"WaterRationCan", 10,
	-- Medical
	"Bandage", 10,
	"Bandaid", 10,
	"FirstAidKit_Military", 4,
	"ScissorsBluntMedical", 1,
	"SutureNeedleHolder", 1,
	-- Maps
	"LouisvilleMap1", 20,
	"LouisvilleMap2", 20,
	"LouisvilleMap3", 20,
	"LouisvilleMap4", 20,
	"LouisvilleMap5", 20,
	"LouisvilleMap6", 20,
	"LouisvilleMap7", 20,
	"LouisvilleMap8", 20,
	"LouisvilleMap9", 20,
	"MarchRidgeMap", 20,
	"MuldraughMap", 20,
	"RiversideMap", 20,
	"RosewoodMap", 20,
	"WestpointMap", 20,
	-- Literature
	"ArmorMag1", 4,
	"ArmorMag2", 4,
	"ArmorMag3", 4,
	"ArmorMag4", 4,
	"ArmorMag5", 4,
	"ArmorMag6", 4,
	"ArmorMag7", 4,
	"ArmorSchematic", 4,
	"BookAiming1", 8,
	"BookAiming2", 8,
	"BookAiming3", 8,
	"BookAiming4", 8,
	"BookAiming5", 4,
	"BookBlacksmith1", 8,
	"BookBlacksmith2", 8,
	"BookBlacksmith3", 8,
	"BookBlacksmith4", 8,
	"BookBlacksmith5", 4,
	"BookButchering1", 8,
	"BookButchering2", 8,
	"BookButchering3", 8,
	"BookButchering4", 8,
	"BookButchering5", 4,
	"BookCarpentry1", 8,
	"BookCarpentry2", 8,
	"BookCarpentry3", 8,
	"BookCarpentry4", 8,
	"BookCarpentry5", 4,
	"BookCarving1", 8,
	"BookCarving2", 8,
	"BookCarving3", 8,
	"BookCarving4", 8,
	"BookCarving5", 4,
	"BookCooking1", 8,
	"BookCooking2", 8,
	"BookCooking3", 8,
	"BookCooking4", 8,
	"BookCooking5", 4,
	"BookElectrician1", 8,
	"BookElectrician2", 8,
	"BookElectrician3", 8,
	"BookElectrician4", 8,
	"BookElectrician5", 4,
	"BookFarming1", 8,
	"BookFarming2", 8,
	"BookFarming3", 8,
	"BookFarming4", 8,
	"BookFarming5", 4,
	"BookFirstAid1", 8,
	"BookFirstAid2", 8,
	"BookFirstAid3", 8,
	"BookFirstAid4", 8,
	"BookFirstAid5", 4,
	"BookFishing1", 8,
	"BookFishing2", 8,
	"BookFishing3", 8,
	"BookFishing4", 8,
	"BookFishing5", 4,
	"BookFlintKnapping1", 8,
	"BookFlintKnapping2", 8,
	"BookFlintKnapping3", 8,
	"BookFlintKnapping4", 8,
	"BookFlintKnapping5", 4,
	"BookForaging1", 8,
	"BookForaging2", 8,
	"BookForaging3", 8,
	"BookForaging4", 8,
	"BookForaging5", 4,
	"BookGlassmaking1", 8,
	"BookGlassmaking2", 8,
	"BookGlassmaking3", 8,
	"BookGlassmaking4", 8,
	"BookGlassmaking5", 4,
	"BookHusbandry1", 8,
	"BookHusbandry2", 8,
	"BookHusbandry3", 8,
	"BookHusbandry4", 8,
	"BookHusbandry5", 4,
	"BookLongBlade1", 8,
	"BookLongBlade2", 8,
	"BookLongBlade3", 8,
	"BookLongBlade4", 8,
	"BookLongBlade5", 4,
	"BookMaintenance1", 8,
	"BookMaintenance2", 8,
	"BookMaintenance3", 8,
	"BookMaintenance4", 8,
	"BookMaintenance5", 4,
	"BookMasonry1", 8,
	"BookMasonry2", 8,
	"BookMasonry3", 8,
	"BookMasonry4", 8,
	"BookMasonry5", 4,
	"BookMechanic1", 8,
	"BookMechanic2", 4,
	"BookMechanic3", 8,
	"BookMechanic5", 4,
	"BookMechanic4", 8,
	"BookMechanic5", 4,
	"BookMechanic4", 8,
	"BookMechanic5", 4,
	"BookMetalWelding1", 8,
	"BookMetalWelding2", 8,
	"BookMetalWelding3", 8,
	"BookMetalWelding4", 8,
	"BookMetalWelding5", 4,
	"BookPottery1", 8,
	"BookPottery2", 8,
	"BookPottery3", 8,
	"BookPottery4", 8,
	"BookPottery5", 4,
	"BookReloading1", 8,
	"BookReloading2", 8,
	"BookReloading3", 8,
	"BookReloading4", 8,
	"BookReloading5", 4,
	"BookTailoring1", 8,
	"BookTailoring2", 8,
	"BookTailoring3", 8,
	"BookTailoring4", 8,
	"BookTailoring5", 4,
	"BookTracking1", 8,
	"BookTracking2", 8,
	"BookTracking3", 8,
	"BookTracking4", 8,
	"BookTracking5", 4,
	"BookTrapping1", 8,
	"BookTrapping2", 8,
	"BookTrapping3", 8,
	"BookTrapping4", 8,
	"BookTrapping5", 4,
	"BSToolsSchematic", 4,
	"CookwareSchematic", 4,
	"ElectronicsMag1", 4,
	"ElectronicsMag2", 4,
	"ElectronicsMag3", 4,
	"ElectronicsMag4", 4,
	"ElectronicsMag5", 4,
	"EngineerMagazine1", 4,
	"EngineerMagazine2", 4,
	"ExplosiveSchematic", 4,
	"FarmingMag5", 4,
	"FishingMag1", 4,
	"FishingMag2", 4,
	"HempMag1", 8,
	"HerbalistMag", 10,
	"HuntingMag1", 4,
	"HuntingMag2", 4,
	"HuntingMag3", 4,
	"KeyMag1", 4,
	"MechanicMag2", 4,
	"MeleeWeaponSchematic", 4,
	"Paperback", 20,
	"Paperback", 10,
	"PrimitiveToolMag1", 4,
	"PrimitiveToolMag2", 4,
	"PrimitiveToolMag3", 4,
	"SurvivalSchematic", 4,
	"TrickMag1", 4,
	"WeaponMag1", 4,
	"WeaponMag2", 4,
	"WeaponMag3", 4,
	"WeaponMag4", 4,
	"WeaponMag5", 4,
	"WeaponMag6", 4,
	-- Seeds
	"BlackSageBagSeed", 10,
	"BroadleafPlantainBagSeed", 10,
	"ComfreyBagSeed", 10,
	"CommonMallowBagSeed", 10,
	"HempBagSeed", 4,
	"LemonGrassBagSeed", 10,
	"WildGarlicBagSeed", 10,
	-- Misc.
	"CDplayer", 2,
	"CrudeWhetstone", 10,
	"Disc_Retail", 4,
	"VHS_Retail", 4,
	"VHS_Home", 4,
	"EngineParts", 1,
	"Firecracker", 1,
	"Hat_BandanaTINT", 10,
	"Holster_DuctTape", 4,
	"IDcard_Blank", 0.1,
	"MortarPestle", 1,
	"PanForged", 8,
	"PonchoGarbageBag", 4,
	"PonchoTarp", 4,
	"PotForged", 2,
	"RubberHose", 1,
	"SewingKit", 2,
	"ShemaghScarf_Green", 1,
	"Soap2", 10,
	"Spork", 10,
	"TobaccoChewing", 1,
	"Whetstone", 1,
	-- Weapons/Accessories
	"Bag_ChestRig", 1,
	"DoubleBarrelShotgunSawnoff", 8,
	"Handiknife", 0.1,
	"KnifePocket", 0.1,
	"Machete", 4,
	"Multitool", 0.01,
	"ShotgunSawnoff", 10,
	"ShotgunShellsBox", 10,
	-- Special
	"Bag_ProtectiveCaseSmall_KeyCutting", 4,
	-- Bootleneck Crafting Items
	"Fleshing_Tool", 1,
	"HeadingTool", 1,
	"KnappingTool", 1,
    "MasonsChisel", 1,
    "MasonsTrowel", 1,
	"Tongs", 1,
}

BagsAndContainers.SurvivorBag = {
	rolls = 2,
	items = BagsAndContainers.SurvivorItems,
	junk = {
		rolls = 1,
		items = {
			
		}
	},
	-- only one map allowed
	maxMap = 1,
	-- this mean 90% chance on normal sandbox settings to have an annoted map
	stashChance = 10,
}

BagsAndContainers.SurvivorBag_Mid = {
	rolls = 2,
	items = BagsAndContainers.SurvivorItems,
	junk = {
		rolls = 1,
		items = {
			
		}
	},
	-- only two map allowed
	maxMap = 2,
	-- this mean 90% chance on normal sandbox settings to have an annoted map
	stashChance = 10,
}

BagsAndContainers.SurvivorBag_Late = {
	rolls = 2,
	items = BagsAndContainers.SurvivorItems,
	junk = {
		rolls = 1,
		items = {
			
		}
	},
	-- only two map allowed
	maxMap = 2,
	-- this mean 90% chance on normal sandbox settings to have an annoted map
	stashChance = 10,
}

-- Box of fishing tackle and related supplies.
BagsAndContainers.Tacklebox = {
	rolls = 2,
	items = {
		-- Keys/Keyrings
		"CarKey", 0.5,
		"KeyRing_Bass", 0.1,
		"Key1", 0.5,
		"Key1", 0.5,
		-- Fishing Gear
		"Bobber", 10,
		"FishingHook", 20,
		"FishingHook", 10,
		"FishingHookBox", 4,
		"FishingLine", 20,
		"FishingLine", 10,
		"FishingTackle", 10,
		"FishingTackle2", 10,
		"JigLure", 10,
		"MinnowLure", 10,
		"PremiumFishingLine", 4,
		-- Tools
		"FlashLight_AngleHead", 10,
		"HandTorch", 4,
		"KnifeFillet", 10,
		"KnifePocket", 10,
		"Pliers", 10,
		"ShortBat", 2,
		-- Literature
		"BookFishing1", 10,
		"FishingMag1", 4,
		"FishingMag2", 4,
		-- Misc.
		"BeerCan", 2,
		"BeerBottle", 1,
		"BottleOpener", 10,
		"Gloves_Dish", 8,
		"InsectRepellent", 10,
		"MeasuringTape", 6,
		"TobaccoChewing", 1,
		"Whetstone", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

-- Paper takeout container for chinese restaurants.
BagsAndContainers.TakeoutBox_Chinese = {
	rolls = 2,
	items = {
		"MeatDumpling", 20,
		"MeatSteamBun", 20,
		"ShrimpDumpling", 20,
		"ShrimpFried", 20,
		"Springroll", 20,
		"TofuFried", 20,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

-- Styrofoam takeout container for other restaurants.
-- Should spawn one piece of prepared food and possibly a side dish.
BagsAndContainers.TakeoutBox_Styrofoam = {
	rolls = 10,
	onlyOne = true,
	items = {
		"Burger", 20,
		"Burrito", 10,
		"ChickenFried", 10,
		"Hotdog", 10,
		"Pizza", 10,
	},
	junk = {
		rolls = 4,
		onlyOne = true,
		items = {
			"FriedOnionRings", 4,
			"Fries", 20,
		}
	}
}

-- Generic toolbox. No specific trade.
BagsAndContainers.Toolbox = {
	rolls = 1,
	items = {
		-- Keys/Keyrings
		"CarKey", 0.5,
		"KeyRing", 0.1,
		"Key1", 0.5,
		"Key1", 0.5,
		-- Tools
		"Awl", 4,
		"BallPeenHammer", 8,
		"BlowTorch", 4,
		"BoltCutters", 4,
		"Calipers", 2,
		"CarpentryChisel", 4,
		"ClubHammer", 4,
		"Crowbar", 4,
		"File", 2,
		"Funnel", 10,
		"GardenSaw", 8,
		"Hammer", 8,
		"HandAxe", 1,
		"HandDrill", 4,
		"HeadingTool", 1,
		"KnifePocket", 0.1,
		"MasonsChisel", 2,
		"MasonsTrowel", 2,
		"MetalworkingChisel", 2,
		"MetalworkingPunch", 2,
		"PipeWrench", 8,
		"Pliers", 10,
		"Saw", 8,
		"Screwdriver", 10,
		"SheetMetalSnips", 4,
		"SmallFileSet", 2,
		"SmallPunchSet", 2,
		"SmallSaw", 2,
		"Tongs", 2,
		"ViseGrips", 4,
		"WoodenMallet", 4,
		"Wrench", 8,
		-- Literature (Skill Books)
		"BookCarpentry1", 1,
		"BookElectrician1", 1,
		"BookMechanic1", 1,
		"BookMetalWelding1", 1,
		-- Materials
		"DuctTape", 8,
		"Epoxy", 2,
		"FiberglassTape", 2,
		"Nails", 10,
		"NailsBox", 4,
		"NutsBolts", 10,
		"RubberHose", 10,
		"Screws", 10,
		"ScrewsBox", 4,
		"Twine", 10,
		"WeldingRods", 4,
		"Wire", 4,
		"Woodglue", 8,
		-- Equipment
		"FlashLight_AngleHead", 10,
		"Glasses_SafetyGoggles", 4,
		"HandTorch", 4,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 4,
		"Hat_EarMuff_Protectors", 4,
		"RespiratorFilters", 2,
		"WeldingMask", 1,
		-- Misc.
		"CombinationPadlock", 8,
		"MarkerBlack", 10,
		"MeasuringTape", 10,
		"Padlock", 4,
		"PowerBar", 4,
		"TobaccoChewing", 1,
		"Whetstone", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

-- Traveling tourist and their supplies.
BagsAndContainers.Tourist = {
	rolls = 1,
	items = {
		-- Literature
		"Book_GeneralNonFiction", 2,
		"Brochure", 50,
		"Brochure", 20,
		"Brochure", 20,
		"Brochure", 10,
		"Catalog", 10,
		"Diary1", 4,
		"Flier", 20,
		"MagazineCrossword", 2,
		"MagazineWordsearch", 2,
		"Magazine_Rich", 10,
		"Paperback_Fiction", 4,
		"Paperback_Travel", 8,
		"TVMagazine", 10,
		-- Photography
		"CameraDisposable", 20,
		"Camera", 10,
		"CameraExpensive", 4,
		"CameraFilm", 50,
		"CameraFilm", 20,
		"Photo", 50,
		"Photo", 20,
		"Photo", 20,
		-- Medical
		"AlcoholWipes", 8,
		"Bandaid", 8,
		"FirstAidKit_Camping", 0.1,
		-- Essentials
		"BathTowel", 50,
		"BathTowel", 20,
		"CDplayer", 10,
		"Comb", 10,
		"Earbuds", 10,
		"Disc_Retail", 20,
		"Disc_Retail", 10,
		"Glasses_Sun", 10,
		"Glasses_Aviators", 2,
		"Glasses_CatsEye_Sun", 10,
		"Glasses_JackieO", 2,
		"Glasses_SwimmingGoggles", 20,
		"InsectRepellent", 10,
		"Money", 50,
		"Money", 50,
		"Money", 20,
		"Money", 20,
		"Tissue", 20,
		"Toothbrush", 20,
		"Toothpaste", 20,
		"Whistle", 4,
		-- Snacks/Drinks
		"BeefJerky", 4,
		"Crisps", 1,
		"Crisps2", 1,
		"Crisps3", 1,
		"Crisps4", 1,
		"GranolaBar", 8,
		"Gum", 20,
		"Peanuts", 4,
		"Plonkies", 1,
		"Pop", 2,
		"Pop2", 2,
		"Pop3", 2,
		"PopBottle", 1,
		"PopBottleRare", 0.1,
		"SunflowerSeeds", 4,
		"WaterBottle", 10,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

-- Generic wallet, meant to be found in containers.
BagsAndContainers.Wallet = {
	rolls = 1,
	items = {
		-- ID/Cards
		"CreditCard", 10,
		-- Money
		"Money", 50,
		"Money", 20,
		"Money", 20,
		"Money", 10,
		"Money", 10,
		-- Misc.
		"BusinessCard", 10,
		"ParkingTicket", 4,
		"Receipt", 10,
		"ScratchTicket", 0.1,
		"ScratchTicket_Winner", 0.1,
		"SpeedingTicket", 4,
		-- Mementos
		"Doodle", 0.1,
		"LetterHandwritten", 1,
		"Locket", 0.01,
		"Photo", 10,
		"Photo_Secret", 0.001,
		"Postcard", 2,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

-- Women's wallet. Mostly found on deceased zombies.
BagsAndContainers.Wallet_Female = {
	rolls = 1,
	items = {
		-- ID/Cards
		"CreditCard", 10,
		"CreditCard", 2,
		"CreditCard", 2,
		"IDcard_Female", 50,
		-- Money
		"Money", 50,
		"Money", 20,
		"Money", 20,
		"Money", 10,
		"Money", 10,
		-- Misc.
		"BusinessCard", 10,
		"ParkingTicket", 4,
		"Receipt", 10,
		"ScratchTicket", 0.1,
		"ScratchTicket_Winner", 0.1,
		"SpeedingTicket", 4,
		-- Mementos
		"Doodle", 0.1,
		"LetterHandwritten", 1,
		"Locket", 0.01,
		"Photo", 10,
		"Photo_Secret", 0.001,
		"Postcard", 2,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	},
}

-- Men's wallet. Same as above.
BagsAndContainers.Wallet_Male = {
	rolls = 1,
	items = {
		-- ID/Cards
		"CreditCard", 10,
		"CreditCard", 2,
		"CreditCard", 2,
		"IDcard_Male", 50,
		-- Money
		"Money", 50,
		"Money", 20,
		"Money", 20,
		"Money", 10,
		"Money", 10,
		-- Misc.
		"BusinessCard", 10,
		"ParkingTicket", 4,
		"Receipt", 10,
		"ScratchTicket", 0.1,
		"ScratchTicket_Winner", 0.1,
		"SpeedingTicket", 4,
		-- Mementos
		"Doodle", 0.1,
		"LetterHandwritten", 1,
		"Locket", 0.01,
		"Photo", 10,
		"Photo_Secret", 0.001,
		"Postcard", 2,
	},
	junk = {
		rolls = 1,
		items = {
		}
	},
}