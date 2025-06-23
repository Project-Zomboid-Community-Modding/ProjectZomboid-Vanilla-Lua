ProceduralDistributions = {};

ProceduralDistributions.list = {
	-- Profession table.
	AmbulanceDriverOutfit = {
		rolls = 3,
		items = {
			-- Clothing
			"Jacket_NavyBlue", 10,
			"Shirt_FormalWhite", 6,
			"Shirt_FormalWhite_ShortSleeve", 6,
			"Shoes_Black", 4,
			"Trousers_Black", 6,
			"Trousers_NavyBlue", 6,
			-- Equipment
			"Gloves_Surgical", 10,
			"Hat_SurgicalMask", 10,
			-- Literature
			"BookFirstAid1", 6,
			"BookFirstAid2", 4,
			"BookFirstAid3", 2,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"Book_Medical", 2,
			"Paperback_Medical", 6,
			-- Bags/Containers
			"Bag_MedicalBag", 0.5,
			"Bag_Satchel_Medical", 0.5,
			"FirstAidKit", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"HandTorch", 4,
				"Magazine_Health", 8,
				"Notepad", 10,
				"Pencil", 10,
				"PenLight", 6,
			}
		}
	},
	
	-- Profession table.
	AmbulanceDriverTools = {
		rolls = 3,
		items = {
			-- Literature
			"BookFirstAid1", 6,
			"BookFirstAid2", 4,
			"BookFirstAid3", 2,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"Book_Medical", 2,
			"Magazine_Health", 8,
			"Paperback_Medical", 6,
			-- Equipment
			"AlcoholWipes", 20,
			"Bandage", 20,
			"Bandage", 10,
			"Bandaid", 50,
			"Bandaid", 20,
			"Disinfectant", 8,
			"Gloves_Surgical", 10,
			"Hat_SurgicalMask", 10,
			"Pills", 50,
			"Pills", 20,
			"ScissorsBluntMedical", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"HandTorch", 4,
				"Notepad", 10,
				"Pencil", 10,
				"PenLight", 6,
			}
		}
	},
	
	AnthropologyBooks = {
		rolls = 4,
		items = {
			-- Literature (Skill Books)
			"BookCarving1", 10,
			"BookCarving2", 8,
			"BookCarving3", 6,
			"BookCarving4", 4,
			"BookCarving5", 2,
			"BookFlintKnapping1", 10,
			"BookFlintKnapping2", 8,
			"BookFlintKnapping3", 6,
			"BookFlintKnapping4", 4,
			"BookFlintKnapping5", 2,
			-- Literature (Recipes)
			"ArmorMag2", 10,
			"PrimitiveToolMag1", 10,
			"PrimitiveToolMag2", 10,
			"PrimitiveToolMag3", 10,
			"TailoringMag1", 10,
			"WeaponMag1", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	AnthropologyCounter = {
		rolls = 4,
		items = {
			-- Tools
			"Brush", 50,
			"KnappingTool", 10,
			"MagnifyingGlass", 20,
			-- Literature (Skill Books)
			"BookCarving1", 10,
			"BookCarving2", 8,
			"BookCarving3", 6,
			"BookCarving4", 4,
			"BookCarving5", 2,
			"BookFlintKnapping1", 10,
			"BookFlintKnapping2", 8,
			"BookFlintKnapping3", 6,
			"BookFlintKnapping4", 4,
			"BookFlintKnapping5", 2,
			-- Literature (Recipes)
			"ArmorMag2", 10,
			"PrimitiveToolMag1", 10,
			"PrimitiveToolMag2", 10,
			"PrimitiveToolMag3", 10,
			"TailoringMag1", 10,
			"WeaponMag1", 10,
			-- Misc.
			"Specimen_Minerals", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	AnthropologyDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Tools
			"Brush", 50,
			"KnappingTool", 10,
			"MagnifyingGlass", 20,
			-- Literature (Skill Books)
			"BookCarving1", 10,
			"BookCarving2", 8,
			"BookCarving3", 6,
			"BookCarving4", 4,
			"BookCarving5", 2,
			"BookFlintKnapping1", 10,
			"BookFlintKnapping2", 8,
			"BookFlintKnapping3", 6,
			"BookFlintKnapping4", 4,
			"BookFlintKnapping5", 2,
			-- Literature (Recipes)
			"ArmorMag2", 10,
			"PrimitiveToolMag1", 10,
			"PrimitiveToolMag2", 10,
			"PrimitiveToolMag3", 10,
			"TailoringMag1", 10,
			"WeaponMag1", 10,
			-- Misc.
			"Specimen_Minerals", 20,
			-- Special
			"Hominid_Skull", 0.5,
			"Hominid_Skull_Partial", 0.5,
		},
		junk = ClutterTables.DeskJunk,
	},
	
	AnthropologyDisplayClothing = {
		rolls = 4,
		items = {
			-- Tools
			"Needle_Bone", 20,
			"Needle_Bone", 10,
			"KnittingNeedles_Bone", 10,
			-- Clothing
			"Codpiece_Leather", 8,
			"Hat_DeerHeadress", 4,
			"Hat_HockeyMask_Copper", 1,
			"Hat_HockeyMask_Hide", 8,
			"Hat_HockeyMask_Wood", 8,
			-- Jewelry
			"Earring_BoarTusk", 8,
			"NecklaceLong_SkullMammal", 8,
			"NecklaceLong_SkullMammal_Multi", 4,
			"NecklaceLong_SkullSmall", 8,
			"NecklaceLong_SkullSmall_Multi", 4,
			"NecklaceLong_Teeth", 8,
			"Necklace_BoarTusk", 8,
			"Necklace_BoarTusk_Multi", 4,
			"Necklace_SkullMammal", 8,
			"Necklace_SkullMammal_Multi", 4,
			"Necklace_SkullSmall", 8,
			"Necklace_SkullSmall_Multi", 4,
			-- Materials
			"BoneBead_Large", 20,
			"HempScutched", 10,
			"LeatherStrips", 10,
			"TurkeyFeather", 10,
			-- Special
			"Hominid_Skull", 0.01,
			"Hominid_Skull_Fragment", 0.5,
			"Hominid_Skull_Partial", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	AnthropologyDisplayTools = {
		rolls = 4,
		items = {
			-- Tools
			"Awl_Bone", 4,
			"Awl_Stone", 4,
			"DullBoneKnife", 8,
			"FishingHook_Bone", 20,
			"Fleshing_Tool_Bone", 8,
			"KnappingTool", 8,
			"PrimitiveScythe", 4,
			"Saw_Flint", 8,
			"StoneChisel", 8,
			"StoneDrill", 8,
			-- Materials
			"HatchetHead_Bone", 4,
			"SharpedStone", 8,
			"StoneAxeHead", 4,
			"StoneBlade", 8,
			"StoneBladeLong", 4,
			-- Misc.
			"Whistle_Bone", 8,
			-- Special
			"Hominid_Skull", 0.01,
			"Hominid_Skull_Fragment", 0.5,
			"Hominid_Skull_Partial", 0.1,
			
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	AnthropologyDisplayWeapons = {
		rolls = 4,
		items = {
			-- Weapons
			"AxeStone", 4,
			"BoneClub", 8,
			"Cudgel_Bone", 4,
			"HammerStone", 8,
			"Hatchet_Bone", 8,
			"JawboneBovide_Axe", 4,
			"JawboneBovide_Club", 4,
			"LargeBoneClub", 4,
			"Mace_Stone", 4,
			"StoneMaul", 4,
			"TreeBranch_Bone", 4,
			-- Materials
			"BoneBead_Large", 8,
			"HatchetHead_Bone", 4,
			"SharpedStone", 8,
			"StoneAxeHead", 4,
			"StoneBlade", 8,
			"StoneBladeLong", 4,
			-- Special
			"Hominid_Skull", 0.01,
			"Hominid_Skull_Fragment", 0.5,
			"Hominid_Skull_Partial", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Box of old, random things that once belonged to someone. Lots of sentimental value.
	Antiques = {
		rolls = 4,
		items = {
			-- Literature/Stationery
			"BookFancy_Bible", 4,
			"BookFancy_ClassicFiction", 4,
			"BookFancy_ClassicNonfiction", 4,
			"LetterHandwritten", 10,
			"Newspaper", 10,
			"Newspaper", 10,
			"PenFancy", 10,
			"Postcard", 20,
			-- Photography
			"CameraExpensive", 4,
			"CameraFilm", 1,
			"Photo", 20,
			"Photo", 10,
			"Photo_VeryOld", 10,
			-- Jewelry/Watches
			"Bracelet_BangleRightGold", 0.5,
			"Bracelet_ChainRightGold", 0.5,
			"Earring_LoopLrg_Gold", 0.5,
			"Earring_LoopMed_Gold", 0.5,
			"Earring_LoopSmall_Gold_Both", 0.5,
			"Earring_LoopSmall_Gold_Top", 0.5,
			"Earring_Stud_Gold", 0.5,
			"Locket", 10,
			"Necklace_Pearl", 2,
			"Necklace_Crucifix", 4,
			"Necklace_SilverCrucifix", 1,
			"NecklaceLong_Gold", 1,
			"Necklace_Gold", 1,
			"Pocketwatch", 10,
			"Ring_Left_RingFinger_Gold", 1,
			"WristWatch_Left_ClassicBlack", 4,
			"WristWatch_Left_ClassicBrown", 4,
			"WristWatch_Left_ClassicGold", 1,
			"WristWatch_Left_Expensive", 0.1,
			-- Music
			"Bag_FluteCase", 1,
			"Bag_SaxophoneCase", 1,
			"Bag_TrumpetCase", 1,
			"Bag_ViolinCase", 1,
			"Banjo", 1,
			"Drumstick", 4,
			"Flightcase", 1,
			"GuitarAcoustic", 4,
			"Guitarcase", 1,
			"GuitarElectric", 2,
			"GuitarElectricBass", 2,
			"Harmonica", 4,
			"Microphone", 4,
			"Mov_SnareDrum", 0.1,
			"Mov_TomDrum", 0.1,
			"Mov_WoodSpeakerCabinet", 0.1,
			-- Sports
			"AthleticCup", 1,
			"BadmintonRacket", 2,
			"Baseball", 4,
			"BaseballBat", 1,
			"Basketball", 4,
			"FieldHockeyStick", 1,
			"Football", 4,
			"Gloves_BoxingRed", 1,
			"Gloves_LeatherGloves", 1,
			"GolfBall", 4,
			"Golfclub", 1,
			"Hat_BaseballHelmet", 1,
			"Hat_BoxingRed", 1,
			"Hat_FootballHelmet", 1,
			"Hat_GolfHat", 1,
			"Hat_HockeyHelmet", 1,
			"Hat_Sweatband", 1,
			"IceHockeyNeckGuard", 1,
			"IceHockeyStick", 1,
			"LaCrosseStick", 1,
			"Medal_Bronze", 8,
			"Medal_Gold", 2,
			"Medal_Silver", 4,
			"SoccerBall", 4,
			"TennisRacket", 2,
			"TrophyBronze", 4,
			"TrophyGold", 1,
			"TrophySilver", 2,
			"Whistle", 8,
			-- Hats
			"Hat_Cowboy", 2,
			"Hat_Fedora_Delmonte", 2,
			"Hat_FishermanRainHat", 1,
			"Hat_HardHat_Miner", 1,
			"Hat_PeakedCapYacht", 0.1,
			"Hat_Stovepipe", 0.5,
			"Hat_Stovepipe_UncleSam", 0.1,
			"Hat_WoolyHat", 1,
			-- Eyewear
			"Glasses_70s_Gold", 2,
			"Glasses_JackieO", 2,
			"Glasses_Macho", 2,
			"Glasses_MonocleLeft", 0.1,
			-- Cosmetic
			"Comb", 4,
			"Mirror", 4,
			"StraightRazor", 4,
			-- Smoking
			"Lighter", 10,
			"SmokingPipe", 4,
			-- Decor
			"Mov_DegreeDoctor", 1,
			"Mov_DegreeSurgeon", 1,
			"Mov_FlagUSA", 8,
			"Mov_FlagUSALarge", 4,
			"Mov_HuntingTrophy", 4,
			-- Military
			"CanteenMilitaryEmpty", 1,
			"Glasses_Aviators", 1,
			"Hat_ArmyWWII", 0.1,
			"Hat_BaseballCapArmy", 4,
			"Hat_BeretArmy", 1,
			"Hat_PeakedCapArmy", 1,
			"HolsterSimple_Green", 0.5,
			"MilitaryMedal", 4,
			"Shoes_ArmyBoots", 1,
			-- Crafted
			"JawboneBovide", 1,
			"JawboneBovide_Club", 0.1,
			"RailroadSpikeKnife", 0.1,
			"StoneBlade", 0.5,
			"StoneBladeLong", 0.1,
			-- Tools
			"Axe_Old", 0.2,
			"CarpentryChisel", 1,
			"FightingKnife", 0.001,
			"Fleshing_Tool", 1,
			"Glasses_OldWeldingGoggles", 4,
			"HandAxe_Old", 4,
			"HandDrill", 4,
			"Hatchet_Bone", 1,
			"HatchetHead_Bone", 1,
			"LargeHook", 1,
			"LargeKnife", 1,
			"OldDrill", 1,
			"ShortBat", 2,
			"SmallKnife", 2,
			-- Misc.
			"Bell", 10,
			"Bellows", 8,
			"Belt2", 4,
			"BrassNameplate", 1,
			"BucketCarved", 1,
			"BucketWood", 2,
			"Buckle", 10,
			"ButterKnife_Gold", 0.1,
			"ButterKnife_Silver", 1,
			"CigarBox_Keepsakes", 4,
			"FlintNodule", 8,
			"Fork_Gold", 0.1,
			"Fork_Silver", 1,
			"Gavel", 1,
			"Goblet", 0.5,
			"Goblet_Gold", 0.05,
			"Goblet_Silver", 0.1,
			"GoldCup", 0.05,
			"Hat_HeadMirrorUP", 8,
			"HolsterDouble", 1,
			"HolsterSimple_Brown", 2,
			"Lantern_Hurricane", 2,
			"MetalCup", 4,
			"PigTusk", 1,
			"PotScrubberFrog", 4,
			"RailroadSpike", 2,
			"SharpBone_Long", 1,
			"SilverCup", 0.1,
			"SnowGlobe", 10,
			"Spoon_Gold", 0.1,
			"Spoon_Silver", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.1,
				"CaseyPic", 0.1,
				"ChrisPic", 0.1,
				"CortmanPic", 0.1,
				"HankPic", 0.1,
				"JamesPic", 0.1,
				"KatePic", 0.1,
				"MariannePic", 0.1,
				"Necklace_DogTag", 10,
			}
		}
	},
	
	-- Fewer cutting tools here than in other cutlery drawers.
	ArenaKitchenCutlery = {
		rolls = 4,
		items = {
			-- Metal/Wood
			"GrillBrush", 20,
			"GrillBrush", 10,
			"BreadKnife", 4,
			"KitchenTongs", 20,
			"KitchenTongs", 10,
			"Ladle", 8,
			"Spatula", 20,
			"Spatula", 10,
			-- Plastic
			"PlasticFork", 10,
			"PlasticKnife", 10,
			"PlasticSpoon", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 8,
				"DishCloth", 10,
			}
		}
	},
	
	-- Frozen food service products. Weighted towards hotdogs and fries but has burgers too.
	ArenaKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"HotdogPack", 20,
			"HotdogPack", 10,
			"MeatPatty", 20,
			"MeatPatty", 10,
			-- Frozen Foods
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Premade sauces. Nothing fresh!
	ArenaKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Condiments
			"Dip_NachoCheese", 10,
			"Dip_Salsa", 10,
			"Ketchup", 10,
			"Mustard", 10,
			"Vinegar2", 8,
			"Vinegar_Jug", 0.5,
			-- Utensils
			"Ladle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 8,
				"DishCloth", 10,
			}
		}
	},
	
	-- Decommissioned underground Army bunker. Old forgotten kitchen supplies.
	ArmyBunkerKitchen = {
		isWorn = true,
		rolls = 4,
		items = {
			-- Cleaning/Maintenance
			"Bleach", 1,
			"Extinguisher", 1,
			"RatPoison", 1,
			"Soap2", 4,
			"TrapMouse", 1,
			-- Food/Drink
			"CannedCarrots2", 0.1,
			"CannedCorn", 0.1,
			"CannedCornedBeef", 0.5,
			"CannedFruitBeverage", 0.1,
			"CannedFruitCocktail", 0.1,
			"CannedMilk", 0.1,
			"CannedPeaches", 0.1,
			"CannedPeas", 0.1,
			"CannedPineapple", 0.1,
			"CannedPotato2", 0.1,
			"CannedSardines", 0.1,
			"CannedTomato2", 0.1,
			"DentedCan", 2,
			"DentedCan_Box", 0.05,
			"MysteryCan", 1,
			"MysteryCan_Box", 0.01,
			"TinnedBeans", 0.1,
			"TinnedSoup", 0.1,
			"TunaTin", 0.1,
			"WaterRationCan", 0.5,
			"WaterRationCan_Box", 0.05,
			-- Utensils
			"ButterKnife", 4,
			"Fork", 4,
			"Spoon", 4,
			"TinOpener_Old", 1,
			-- Trash
			"TinCanEmpty", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"BleachEmpty", 8,
				"DishCloth", 4,
				"TinOpener_Old", 10,
				"DentedCan", 8,
			}
		}
	},
	
	-- Stuff left in the lockers when the bunker was emptied.
	ArmyBunkerLockers = {
		isWorn = true,
		rolls = 4,
		items = {
			-- Army Equipment
			"CanteenMilitaryEmpty", 0.5,
			"EntrenchingTool", 0.5,
			"FlashLight_AngleHead_Army", 0.5,
			"GasmaskFilter", 2,
			"Hat_GasMask", 1,
			"Hat_NBCmask", 1,
			"HolsterSimple_Green", 2,
			"HuntingKnife", 0.1,
			"P38", 0.5,
			"SleepingBag_Camo_Packed", 0.1,
			-- Clothing
			"Belt2", 1,
			"Buckle", 4,
			"Hat_BeretArmy", 0.1,
			"Hat_PeakedCapArmy", 0.1,
			"Jacket_CoatArmy", 0.1,
			"PonchoGreenDOWN", 0.5,
			"Shoes_ArmyBoots", 0.1,
			"Trousers_ArmyService", 0.1,
			"Tshirt_ArmyGreen", 0.1,
			-- Electronics
			"Battery", 1,
			"HamRadio2", 0.001,
			"WalkieTalkie5", 0.1,
			-- Misc.
			"Razor", 0.5,
			"RippedSheets", 2,
			"RippedSheetsDirty", 4,
			"Soap2", 1,
			"ToiletPaper", 4,
			-- Water
			"WaterRationCan", 1,
			"WaterRationCan_Box", 0.1,
			-- Bags/Containers
			"Bag_ALICEpack_Army", 0.01,
			"Bag_ALICE_BeltSus_Camo", 0.01,
			"Bag_ALICE_BeltSus_Green", 0.01,
			"Bag_Military", 0.05,
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 10,
			}
		}
	},
	
	-- Old medical supplies. Probably not in very good condition.
	ArmyBunkerMedical = {
		isWorn = true,
		rolls = 4,
		items = {
			-- Army Equipment
			"FlashLight_AngleHead_Army", 0.1,
			-- Medical Supplies
			"AdhesiveBandageBox", 0.1,
			"Bandage", 1,
			"Bandaid", 4,
			"Coldpack", 2,
			"ColdpackBox", 0.1,
			"CottonBalls", 4,
			"CottonBallsBox", 0.1,
			"Disinfectant", 1,
			"Oxygen_Tank", 0.1,
			"RubberHose", 1,
			"Scalpel", 1,
			"ScissorsBluntMedical", 1,
			"Stethoscope", 0.5,
			"SutureNeedle", 2,
			"SutureNeedleBox", 0.1,
			"SutureNeedleHolder", 1,
			"TongueDepressor", 4,
			"Tweezers", 1,
			-- Pills
			"Antibiotics", 0.1,
			"AntibioticsBox", 0.01,
			"Pills", 0.5,
			"PillsBeta", 0.5,
			"PillsSleepingTablets", 0.5,
			-- Clothing
			"Gloves_Surgical", 1,
			"Hat_SurgicalCap", 1,
			"Hat_SurgicalMask", 1,
			"HospitalGown", 0.5,
			"Shirt_Scrubs", 0.1,
			"Trousers_Scrubs", 0.1,
			-- Cleaning
			"Bleach", 1,
			"Soap2", 1,
			-- Bags/Containers
			"Bag_ProtectiveCaseBulkyHazard", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"DisinfectantEmpty", 4,
				"Paperwork", 20,
			}
		}
	},
	
	-- Old storage room. A little rust never hurt anybody, right?
	ArmyBunkerStorage = {
		isWorn = true,
		rolls = 4,
		items = {
			-- Army Equipment
			"CanteenMilitaryEmpty", 0.1,
			"FlashLight_AngleHead_Army", 0.1,
			"GasmaskFilter", 2,
			"HamRadio2", 0.001,
			"Hat_GasMask", 1,
			"Hat_NBCmask", 1,
			"HolsterSimple_Green", 1,
			"JerryCanEmpty", 1,
			"WalkieTalkie5", 0.01,
			-- Tools
			"BallPeenHammer", 1,
			"Calipers", 1,
			"CarpentryChisel", 1,
			"EntrenchingTool", 0.1,
			"File", 1,
			"HandDrill", 1,
			"MetalworkingChisel", 1,
			"MetalworkingPunch", 1,
			"PipeWrench", 1,
			"Pliers", 1,
			"Ratchet", 1,
			"Saw", 1,
			"Screwdriver", 1,
			"SheetMetalSnips", 1,
			"SmallFileSet", 1,
			"SmallPunchSet", 1,
			"SmallSaw", 1,
			"ViseGrips", 1,
			"Wrench", 1,
			-- Materials
			"Battery", 1,
			"LightBulb", 1,
			"NutsBolts", 1,
			"RubberHose", 1,
			"Screws", 2,
			"Tarp", 4,
			-- Cleaning/Maintenance
			"Bleach", 1,
			"RatPoison", 1,
			"RippedSheets", 2,
			"RippedSheetsDirty", 4,
			"Soap2", 4,
			"ToiletPaper", 4,
			-- Misc.
			"Extinguisher", 1,
			"Mov_BlackRotaryPhone", 0.1,
			"Mov_Cot", 0.01,
			-- Water
			"WaterRationCan", 1,
			"WaterRationCan_Box", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"MeasuringTape", 1,
				"Paperwork", 10,
			}
		}
	},
	
	-- Maintenance depot for Army vehicles and aircraft. Extra work uniforms and accessories.
	ArmyHangarOutfit = {
		rolls = 4,
		items = {
			-- Jumpsuits
			"Boilersuit_Flying", 20,
			"Boilersuit_Flying", 20,
			"Boilersuit_Flying", 10,
			"Boilersuit_Flying", 10,
			-- Equipment
			"ElbowPad_Left_Military", 1,
			"Glasses_SafetyGoggles", 8,
			"Hat_BuildersRespirator", 4,
			"Hat_DustMask", 8,
			"Hat_EarMuff_Protectors", 8,
			"Hat_SPHhelmet", 4,
			"Kneepad_Left_Military", 4,
			"Vest_HighViz", 8,
			"WeldingMask", 4,
			-- Clothing
			"Hat_BeretArmy", 1,
			"Hat_PeakedCapArmy", 1,
			"Jacket_ArmyCamoGreen", 4,
			"Jacket_CoatArmy", 1,
			"Trousers_ArmyService", 4,
			"Tshirt_ArmyGreen", 8,
			-- Misc.
			"RespiratorFilters", 2,
			"WalkieTalkie5", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmyHangarMechanics = {
		rolls = 4,
		items = {
			-- Tools
			"Calipers", 4,
			"HandDrill", 10,
			"LugWrench", 10,
			"Pliers", 20,
			"Ratchet", 20,
			"Screwdriver", 20,
			"SheetMetalSnips", 10,
			"TireIron", 10,
			"TirePump", 10,
			"ViseGrips", 10,
			"Wrench", 20,
			-- Fuel
			"Funnel", 10,
			"JerryCan", 4,
			"JerryCanEmpty", 20,
			"JerryCanEmpty", 10,
			"RubberHose", 10,
			-- Materials
			"ElectricWire", 8,
			"Epoxy", 8,
			"FiberglassTape", 8,
			"HeavyChain", 10,
			"HeavyChain_Hook", 2,
			"LargeHook", 4,
			"NutsBolts", 10,
			"Oxygen_Tank", 2,
			"Propane_Refill", 2,
			"Rope", 10,
			"RopeStack", 0.1,
			"ScrewsBox", 4,
			"ScrewsCarton", 0.1,
			"SteelWool", 10,
			"Tarp", 10,
			-- Misc.
			"HandTorch", 8,
			"FlashLight_AngleHead_Army", 4,
			"WalkieTalkie5", 2,
			-- Bags/Containers
			"Bag_ProtectiveCaseMilitary_Tools", 1,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			-- Special
			"BlowerFan", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Extinguisher", 6,
				"Glasses_SafetyGoggles", 8,
				"Hat_EarMuff_Protectors", 4,
				"MarkerBlack", 10,
				"MeasuringTape", 10,
			}
		}
	},
	
	ArmyHangarTools = {
		rolls = 4,
		items = {
			-- Tools
			"BallPeenHammer", 8,
			"BlowTorch", 10,
			"BoltCutters", 4,
			"Calipers", 8,
			"CarpentryChisel", 6,
			"CeramicCrucible", 2,
			"ClubHammer", 2,
			"File", 8,
			"Hammer", 6,
			"HandDrill", 4,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.1,
			"MetalworkingPunch", 4,
			"Pliers", 8,
			"Ratchet", 4,
			"Saw", 8,
			"Screwdriver", 8,
			"SheetMetalSnips", 4,
			"Sledgehammer", 0.1,
			"Sledgehammer2", 0.1,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"ViseGrips", 4,
			"WoodenMallet", 1,
			"Wrench", 4,
			-- Materials
			"BatteryBox", 1,
			"BarbedWire", 8,
			"CircularSawblade", 4,
			"ElectricWire", 4,
			"Epoxy", 4,
			"FiberglassTape", 4,
			"HeavyChain", 10,
			"HeavyChain_Hook", 2,
			"LargeHook", 4,
			"LightBulbBox", 1,
			"NutsBolts", 10,
			"Oxygen_Tank", 2,
			"Propane_Refill", 2,
			"ScrewsBox", 4,
			"ScrewsCarton", 0.1,
			"WeldingRods", 8,
			"Wire", 4,
			-- Misc.
			"HandTorch", 8,
			"FlashLight_AngleHead_Army", 4,
			"WalkieTalkie5", 2,
			"Whetstone", 10,
			-- Bags/Containers
			"Bag_ProtectiveCaseMilitary_Tools", 1,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Extinguisher", 6,
				"Glasses_SafetyGoggles", 8,
				"Hat_EarMuff_Protectors", 4,
				"MarkerBlack", 10,
				"MeasuringTape", 10,
			}
		}
	},
	
	ArmyStorageAmmunition = {
		rolls = 4,
		items = {
			-- Ammo
			"308Box", 20,
			"308Box", 10,
			"308Carton", 1,
			"556Box", 20,
			"556Box", 20,
			"556Box", 10,
			"556Box", 10,
			"556Carton", 2,
			"Bullets9mmBox", 20,
			"Bullets9mmBox", 10,
			"Bullets9mmCarton", 1,
			"ShotgunShellsBox", 20,
			"ShotgunShellsBox", 10,
			"ShotgunShellsCarton", 1,
			-- Bags/Containers
			"Bag_AmmoBox", 10,
			"Bag_AmmoBox_308", 1,
			"Bag_AmmoBox_9mm", 1,
			"Bag_AmmoBox_ShotgunShells", 1,
			"Bag_ProtectiveCaseBulkyAmmo_308", 1,
			"Bag_ProtectiveCaseBulkyAmmo_556", 10,
			"Bag_ProtectiveCaseBulkyAmmo_9mm", 1,
			"Bag_ProtectiveCaseBulkyAmmo_ShotgunShells", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Radio repair, broadcast and A/V supplies. Things for electrical wiring and light.
	-- Also a bullhorn for crowds.
	ArmyStorageElectronics = {
		rolls = 4,
		items = {
			-- Electronics
			"Bullhorn", 10,
			"Calculator", 4,
			"FlashLight_AngleHead_Army", 4,
			"HandTorch", 10,
			"Headphones", 10,
			"Microphone", 8,
			"PowerBar", 20,
			"PowerBar", 10,
			"WristWatch_Left_ClassicMilitary", 10,
			-- Radio
			"HamRadio2", 1,
			"ManPackRadio", 1,
			"WalkieTalkie5", 10,
			-- Materials
			"Battery", 10,
			"BatteryBox", 1,
			"DuctTape", 4,
			"DuctTapeBox", 0.1,
			"ElectricWire", 50,
			"ElectricWire", 20,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"LightBulb", 10,
			"LightBulbBox", 1,
			"LightBulbGreen", 6,
			"LightBulbRed", 6,
			"RadioReceiver", 20,
			"RadioTransmitter", 20,
			"ScannerModule", 20,
			-- Literature
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"RadioMag1", 2,
			"RadioMag2", 2,
			"RadioMag3", 1,
			-- Misc.
			"BlowerFan", 1,
			"Mov_SatelliteDish", 2,
			-- Tools
			"Pliers", 10,
			"Screwdriver", 10,
			"Wrench", 8,
			-- Bags/Containers
			"Bag_ProtectiveCaseBulkyMilitary_HAMRadio2", 0.5,
			"Bag_ProtectiveCaseMilitary", 1,
			"Bag_ProtectiveCaseSmallMilitary_WalkieTalkie", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"CopperScrap", 10,
				"ElectronicsScrap", 20,
				"Glasses_SafetyGoggles", 8,
				"GraphPaper", 4,
				"MeasuringTape", 4,
				"Tsquare", 4,
			}
		}
	},
	
	-- Mostly sidearms but can have larger guns.
	-- Need to check what sidearms the Army uses and if they use shotguns/sniper rifles.
	ArmyStorageGuns = {
		rolls = 4,
		items = {
			-- Guns
			"AssaultRifle", 2,
			"AssaultRifle2", 0.1,
			"HuntingRifle", 4,
			"Pistol", 20,
			"Pistol", 10,
			"Shotgun", 4,
			-- Gun Accessories
			"AmmoStrap_Bullets", 4,
			"AmmoStrap_Shells", 1,
			"HolsterSimple_Green", 8,
			"x2Scope", 2,
			"x4Scope", 1,
			"x8Scope", 0.5,
			-- Clips/Magazines
			"9mmClip", 20,
			"9mmClip", 10,
			"556Clip", 8,
			-- Bags/Containers
			"Bag_AmmoBox", 2,
			"Bag_AmmoBox_308", 1,
			"Bag_AmmoBox_9mm", 4,
			"Bag_AmmoBox_ShotgunShells", 1,
			"Bag_ProtectiveCaseBulkyAmmo_308", 0.5,
			"Bag_ProtectiveCaseBulkyAmmo_556", 1,
			"Bag_ProtectiveCaseBulkyAmmo_9mm", 2,
			"Bag_ProtectiveCaseBulkyAmmo_ShotgunShells", 0.5,
			"Bag_ProtectiveCaseSmallMilitary_Pistol1", 4,
			"Bag_RifleCaseClothCamo", 1,
			"Bag_RifleCaseGreen", 2,
			"Bag_ShotgunCaseGreen", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmyStorageMedical = {
		rolls = 4,
		items = {
			-- Medical
			"AdhesiveBandageBox", 1,
			"AlcoholWipes", 10,
			"Antibiotics", 2,
			"AntibioticsBox", 0.01,
			"Bandaid", 8,
			"Bandage", 4,
			"BandageBox", 0.5,
			"Coldpack", 4,
			"ColdpackBox", 0.1,
			"CottonBallsBox", 1,
			"Disinfectant", 2,
			"Pills", 20,
			"Pills", 20,
			"Pills", 10,
			"Pills", 10,
			"PillsAntiDep", 8,
			"PillsBeta", 8,
			"PillsSleepingTablets", 8,
			-- Tools
			"SutureNeedleBox", 1,
			"SutureNeedleHolder", 4,
			"TongueDepressor", 10,
			"TongueDepressorBox", 2,
			-- Materials
			"Oxygen_Tank", 1,
			-- Accessories
			"Gloves_Surgical", 10,
			"Hat_SurgicalCap", 10,
			"Hat_SurgicalMask", 10,
			"Shirt_Scrubs", 4,
			"Stethoscope", 6,
			"Trousers_Scrubs", 4,
			-- Bags/Containers
			"Bag_MedicalBag", 0.1,
			"Bag_Satchel_Medical", 0.1,
			"FirstAidKit_Military", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmyStorageOutfit = {
		rolls = 4,
		items = {
			-- Clothing
			"Hat_BaseballCapArmy", 10,
			"Hat_BeretArmy", 8,
			"Jacket_ArmyCamoGreen", 6,
			"Jacket_CoatArmy", 2,
			"Shoes_ArmyBoots", 8,
			"Trousers_ArmyService", 8,
			"Tshirt_ArmyGreen", 6,
			"Tshirt_Profession_VeterenGreen", 6,
			"Tshirt_Profession_VeterenRed", 6,
			-- Accessories
			"CanteenMilitaryEmpty", 4,
			"ElbowPad_Left_Military", 1,
			"FlashLight_AngleHead_Army", 1,
			"Ghillie_Top", 0.01,
			"Ghillie_Trousers", 0.01,
			"Hat_Army", 1,
			"Hat_BalaclavaFace", 4,
			"Hat_BalaclavaFull", 4,
			"Hat_EarMuff_Protectors", 4,
			"Hat_GasMask", 2,
			"Hat_PeakedCapArmy", 8,
			"HolsterSimple_Green", 8,
			"Kneepad_Left_Military", 4,
			"SleepingBag_Camo_Packed", 4,
			"Vest_BulletArmy", 1,
			"WalkieTalkie5", 1,
			-- Bags/Containers
			"Bag_ALICEpack_Army", 0.1,
			"Bag_HydrationBackpack_CamoEmpty", 0.05,
			"Bag_Military", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusAmmoBoxes = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_AmmoBox", 20,
			"Bag_AmmoBox", 20,
			"Bag_AmmoBox", 10,
			"Bag_AmmoBox", 10,
			"Bag_ProtectiveCaseBulkyAmmo", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusBackpacks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Bag_ALICE_BeltSus_Camo", 1,
			"Bag_ALICE_BeltSus_Green", 1,
			"Bag_ALICEpack_Army", 10,
			"Bag_ALICEpack_DesertCamo", 4,
			"Bag_HydrationBackpack_CamoEmpty", 10,
			"Bag_MedicalBag", 10,
			"Bag_Military", 20,
			"Bag_Military", 10,
			"Bag_Satchel_Medical", 10,
			"Bag_Satchel_Military", 20,
			"Bag_Satchel_Military", 10,
			"SleepingBag_Camo_Packed", 20,
			"SleepingBag_Camo_Packed", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusCases = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_ProtectiveCaseMilitary", 20,
			"Bag_ProtectiveCaseMilitary", 10,
			"Bag_ProtectiveCaseBulkyMilitary", 10,
			"Bag_ProtectiveCaseSmallMilitary", 50,
			"Bag_ProtectiveCaseSmallMilitary", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusCots = {
		isShop = true,
		rolls = 4,
		items = {
			"Mov_Cot", 50,
			"Mov_Cot", 20,
			"Mov_Cot", 20,
			"Mov_Cot", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusFootwear = {
		isShop = true,
		rolls = 4,
		items = {
			"Shoes_ArmyBoots", 20,
			"Shoes_ArmyBoots", 20,
			"Shoes_ArmyBoots", 10,
			"Shoes_ArmyBoots", 10,
			"Shoes_ArmyBootsDesert", 20,
			"Shoes_ArmyBootsDesert", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusHeadwear = {
		isShop = true,
		rolls = 4,
		items = {
			"Hat_Army", 0.5,
			"Hat_ArmyDesert", 0.1,
			"Hat_ArmyWWII", 0.01,
			"Hat_BalaclavaFace", 8,
			"Hat_BalaclavaFull", 8,
			"Hat_BaseballCapArmy", 10,
			"Hat_BeretArmy", 2,
			"Hat_BonnieHat_CamoGreen", 10,
			"Hat_BonnieHat_DesertCamo", 4,
			"Hat_BonnieHat_DesertCamoNew", 1,
			"Hat_BonnieHat_MiliusCamo", 1,
			"Hat_BonnieHat_OliveDrab", 1,
			"Hat_BonnieHat_TigerStripeCamo", 1,
			"Hat_GasMask", 0.5,
			"Hat_PeakedCapArmy", 2,
			"SCBA_notank", 1,
			"ShemaghScarf", 1,
			"ShemaghScarf_Green", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusLiterature = {
		isShop = true,
		rolls = 4,
		items = {
			"BookAiming1", 10,
			"BookAiming2", 8,
			"BookAiming3", 6,
			"BookAiming4", 4,
			"BookAiming5", 2,
			"BookReloading1", 10,
			"BookReloading2", 8,
			"BookReloading3", 6,
			"BookReloading4", 4,
			"BookReloading5", 2,
			"Book_Military", 20,
			"Book_Military", 10,
			"Book_MilitaryHistory", 10,
			"EngineerMagazine2", 2,
			"KeyMag1", 2,
			"TrickMag1", 2,
			"Magazine_Military_New", 20,
			"Magazine_Military_New", 20,
			"Magazine_Military_New", 10,
			"Magazine_Military_New", 10,
			"Paperback_Military", 20,
			"Paperback_Military", 10,
			"Paperback_MilitaryHistory", 10,
			"WeaponMag2", 2,
			"WeaponMag3", 2,
			"WeaponMag5", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusMisc = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keyrings
			"KeyRing_EagleFlag", 2,
			"KeyRing_EightBall", 2,
			"KeyRing_Panther", 2,
			-- Accessories
			"ElbowPad_Left_Military", 0.5,
			"GasmaskFilter", 10,
			"HolsterShoulder", 0.5,
			"HolsterSimple_Green", 8,
			"Kneepad_Left_Military", 2,
			"P38", 10,
			"WristWatch_Left_ClassicMilitary", 10,
			-- Fire/Lighting
			"Candle", 10,
			"CandleBox", 4,
			"FlashLight_AngleHead_Army", 4,
			"Lighter", 10,
			"Matchbox", 10,
			-- Canteens/Flasks
			"CanteenMilitaryEmpty", 20,
			"CanteenMilitaryEmpty", 10,
			"FlaskEmpty", 8,
			-- Materials
			"Rope", 10,
			"RopeStack", 0.1,
			"Tarp", 10,
			"Twine", 10,
			-- Special
			"ManPackRadio", 0.001,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusOutfit = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_ChestRig", 1,
			"Jacket_ArmyCamoDesert", 4,
			"Jacket_ArmyCamoDesertNew", 2,
			"Jacket_ArmyCamoGreen", 10,
			"Jacket_ArmyCamoMilius", 1,
			"Jacket_ArmyCamoTigerStripe", 1,
			"Jacket_ArmyCamoUrban", 4,
			"Jacket_ArmyOliveDrab", 2,
			"PonchoGreenDOWN", 10,
			"ShemaghScarf_Green", 1,
			"Shirt_CamoDesert", 4,
			"Shirt_CamoDesertNew", 1,
			"Shirt_CamoGreen", 10,
			"Shirt_CamoMilius", 1,
			"Shirt_CamoTigerStripe", 1,
			"Shirt_CamoUrban", 4,
			"Shirt_OliveDrab", 2,
			"Shorts_CamoGreenLong", 10,
			"Shorts_CamoUrbanLong", 2,
			"Shorts_CamoDesertNewLong", 1,
			"Shorts_CamoMiliusLong", 1,
			"Shorts_CamoTigerStripeLong", 1,
			"Shorts_OliveDrabLong", 2,
			"Trousers_CamoDesert", 4,
			"Trousers_CamoDesertNew", 1,
			"Trousers_CamoGreen", 10,
			"Trousers_CamoMilius", 1,
			"Trousers_CamoTigerStripe", 1,
			"Trousers_CamoUrban", 4,
			"Trousers_OliveDrab", 2,
			"Tshirt_ArmyGreen", 10,
			"Tshirt_CamoDesert", 4,
			"Tshirt_CamoDesertNew", 1,
			"Tshirt_CamoGreen", 10,
			"Tshirt_CamoMilius", 1,
			"Tshirt_CamoTigerStripe", 1,
			"Tshirt_CamoUrban", 4,
			"Tshirt_OliveDrab", 2,
			"Vest_BulletArmy", 0.5,
			"Vest_BulletDesert", 0.1,
			"Vest_BulletOliveDrab", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusSnacks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BeefJerky", 20,
			"BeefJerky", 20,
			"BeefJerky", 10,
			"BeefJerky", 10,
			"DehydratedMeatStick", 20,
			"DehydratedMeatStick", 20,
			"DehydratedMeatStick", 10,
			"DehydratedMeatStick", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArmySurplusTools = {
		isShop = true,
		rolls = 4,
		items = {
			"CompassDirectional", 20,
			"CompassDirectional", 10,
			"EntrenchingTool", 20,
			"EntrenchingTool", 10,
			"FlashLight_AngleHead_Army", 4,
			"HandAxe", 8,
			"Handiknife", 10,
			"HuntingKnife", 10,
			"IceAxe", 1,
			"JerryCanEmpty", 20,
			"JerryCanEmpty", 10,
			"LargeKnife", 1,
			"Machete", 4,
			"Multitool", 1,
			"SmallKnife", 4,
			"Whetstone", 10,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Should there be loose cans? Assuming these need to be dialed down later.
	ArmySurplusWater = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"WaterRationCan_Box", 20,
			"WaterRationCan_Box", 20,
			"WaterRationCan_Box", 10,
			"WaterRationCan_Box", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArtStoreLiterature = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Art", 20,
			"Book_Art", 10,
			"Magazine_Art_New", 20,
			"Magazine_Art_New", 20,
			"Magazine_Art_New", 10,
			"Magazine_Art_New", 10,
			"Paperback_Art", 20,
			"Paperback_Art", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArtStoreOther = {
		isShop = true,
		rolls = 4,
		items = {
			"AdhesiveTapeBox", 0.1,
			"Book_Art", 2,
			"CompassGeometry", 10,
			"Glue", 10,
			"HolePuncher", 10,
			"Magazine_Art_New", 10,
			"Paperback_Art", 6,
			"PaperclipBox", 20,
			"PaperclipBox", 10,
			"RubberBand", 10,
			"Scissors", 10,
			"ScissorsBlunt", 10,
			"Scotchtape", 10,
			"Stapler", 10,
			"Staples", 10,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArtStorePaper = {
		isShop = true,
		rolls = 4,
		items = {
			"Notebook", 20,
			"Notebook", 20,
			"Notebook", 10,
			"Notebook", 10,
			"SheetPaper2", 50,
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"SheetPaper2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArtStorePen = {
		isShop = true,
		rolls = 4,
		items = {
			"Pencil", 20,
			"Pencil", 10,
			"Eraser", 20,
			"Eraser", 10,
			"BluePen", 20,
			"BluePen", 10,
			"RedPen", 20,
			"RedPen", 10,
			"Pen", 20,
			"Pen", 10,
			"Crayons", 20,
			"Crayons", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArtStorePottery = {
		isShop = true,
		rolls = 4,
		items = {
			"BookPottery1", 2,
			"BookPottery2", 1,
			"BookPottery3", 0.5,
			"BookPottery4", 0.1,
			"BookPottery5", 0.05,
			"Brush", 20,
			"Brush", 10,
			"Claybag", 50,
			"Claybag", 20,
			"Claybag", 20,
			"Claybag", 10,
			"ClayTool", 20,
			"ClayTool", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ArtSupplies = {
		rolls = 4,
		items = {
			"BluePen", 8,
			"Book_Art", 2,
			"Brush", 8,
			"ClayTool", 8,
			"CompassGeometry", 8,
			"Crayons", 8,
			"Eraser", 8,
			"Glue", 2,
			"GreenPen", 4,
			"Magazine_Art", 10,
			"MarkerBlack", 2,
			"MarkerBlue", 1,
			"MarkerGreen", 1,
			"MarkerRed", 1,
			"Notebook", 4,
			"PaintBlack", 1,
			"PaintBlue", 1,
			"PaintBrown", 1,
			"Paintbrush", 10,
			"PaintCyan", 1,
			"PaintGreen", 1,
			"PaintGrey", 1,
			"PaintLightBlue", 1,
			"PaintLightBrown", 1,
			"PaintOrange", 1,
			"PaintPink", 1,
			"PaintPurple", 1,
			"PaintRed", 1,
			"PaintTurquoise", 1,
			"PaintWhite", 1,
			"PaintYellow", 1,
			"Paperback_Art", 6,
			"Paperclip", 10,
			"PaperclipBox", 1,
			"Pen", 8,
			"Pencil", 10,
			"PencilSpiffo", 0.1,
			"PenFancy", 0.5,
			"PenMultiColor", 2,
			"PenSpiffo", 0.1,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			"SheetPaper2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BackstageClothingRack = {
		rolls = 4,
		items = {
			"DressKnees_Straps", 0.5,
			"Dress_Knees", 1,
			"Dress_Long", 1,
			"Dress_long_Straps", 0.5,
			"Dress_Short", 1,
			"Dress_SmallBlackStrapless", 0.5,
			"Dress_SmallStrapless", 0.5,
			"Dress_SmallStraps", 0.5,
			"Dress_Straps", 0.5,
			"Dungarees", 0.1,
			"HospitalGown", 0.1,
			"JacketLong_Doctor", 0.1,
			"JacketLong_Santa", 0.1,
			"JacketLong_SantaGreen", 0.1,
			"Jacket_ArmyCamoGreen", 0.1,
			"Jacket_Black", 0.1,
			"Jacket_Chef", 0.1,
			"Jacket_CoatArmy", 0.1,
			"Jacket_Fireman", 0.05,
			"Jacket_Leather", 0.1,
			"Jacket_LeatherBarrelDogs", 0.01,
			"Jacket_LeatherIronRodent", 0.01,
			"Jacket_LeatherWildRacoons", 0.01,
			"Jacket_Leather_Punk", 0.05,
			"Jacket_Police", 0.1,
			"Jacket_Ranger", 0.1,
			"Jacket_Sheriff", 0.1,
			"Jacket_Varsity", 0.1,
			"Jumper_DiamondPatternTINT", 0.5,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopDiamondTINT", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"PonchoYellowDOWN", 0.01,
			"Shirt_Baseball_KY", 0.1,
			"Shirt_Baseball_Rangers", 0.1,
			"Shirt_Baseball_Z", 0.1,
			"Shirt_Bowling_Blue", 0.005,
			"Shirt_Bowling_Brown", 0.005,
			"Shirt_Bowling_Green", 0.005,
			"Shirt_Bowling_LimeGreen", 0.005,
			"Shirt_Bowling_Pink", 0.005,
			"Shirt_Bowling_White", 0.005,
			"Shirt_CamoGreen", 0.1,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 2,
			"Shirt_HawaiianTINT", 0.1,
			"Shirt_Jockey01", 0.005,
			"Shirt_Jockey02", 0.005,
			"Shirt_Jockey03", 0.005,
			"Shirt_Jockey04", 0.005,
			"Shirt_Jockey05", 0.005,
			"Shirt_Jockey06", 0.005,
			"Shirt_Lumberjack", 0.1,
			"Shirt_Lumberjack_TINT", 0.1,
			"Shirt_OfficerWhite", 0.1,
			"Shirt_PoliceBlue", 0.1,
			"Shirt_PoliceGrey", 0.1,
			"Shirt_Priest", 0.1,
			"Shirt_PrisonGuard", 0.1,
			"Shirt_Ranger", 0.1,
			"Shirt_Scrubs", 0.1,
			"Shirt_Sheriff", 0.1,
			"Shirt_Workman", 0.1,
			"Shorts_BoxingBlue", 0.1,
			"Shorts_BoxingRed", 0.1,
			"Skirt_Knees", 1,
			"Skirt_Long", 1,
			"Skirt_Mini", 0.5,
			"Skirt_Normal", 1,
			"Skirt_Short", 1,
			"StockingsBlack", 1,
			"StockingsBlackSemiTrans", 0.5,
			"StockingsBlackTrans", 0.5,
			"StockingsWhite", 1,
			"Suit_Jacket", 2,
			"Suit_JacketTINT", 2,
			"TightsBlack", 1,
			"TightsBlackSemiTrans", 0.5,
			"TightsBlackTrans", 0.5,
			"TightsFishnets", 0.1,
			"TrousersMesh_Leather", 0.1,
			"TrousersMesh_Leather", 0.1,
			"Trousers_ArmyService", 0.1,
			"Trousers_CamoGreen", 0.1,
			"Trousers_Chef", 0.1,
			"Trousers_Fireman", 0.1,
			"Trousers_LeatherBlack", 0.1,
			"Trousers_Police", 0.1,
			"Trousers_PoliceGrey", 0.1,
			"Trousers_PrisonGuard", 0.1,
			"Trousers_Ranger", 0.1,
			"Trousers_Santa", 0.1,
			"Trousers_SantaGreen", 0.1,
			"Trousers_Scrubs", 0.1,
			"Trousers_Sheriff", 0.1,
			"Trousers_Suit", 2,
			"Trousers_SuitTEXTURE", 2,
			"Trousers_SuitWhite", 0.1,
			"Trousers_WhiteTINT", 0.5,
			"Tshirt_ArmyGreen", 0.1,
			"Tshirt_CamoGreen", 0.1,
			"Tshirt_LongSleeve_SuperColor", 0.1,
			"Tshirt_Profession_FiremanWhite", 0.1,
			"Tshirt_Profession_PoliceWhite", 0.1,
			"Tshirt_Profession_RangerGreen", 0.1,
			"Tshirt_Profession_VeterenGreen", 0.1,
			"Tshirt_Rock", 0.1,
			"Tshirt_Scrubs", 0.1,
			"Tshirt_Sheriff", 0.1,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.1,
			"Vest_DefaultTEXTURE", 0.5,
			"Vest_Foreman", 0.1,
			"Vest_HighViz", 0.1,
			"Vest_Hunting_CamoGreen", 0.1,
			"Vest_Hunting_Grey", 0.01,
			"Vest_Hunting_Orange", 0.1,
			"Vest_Trucker", 0.1,
			"Vest_Waistcoat", 0.5,
			"Vest_WaistcoatTINT", 0.5,
			"WeddingDress", 0.01,
			"WeddingJacket", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BackstageCounter = {
		rolls = 4,
		items = {
			"Garter", 0.5,
			"Glasses_Aviators", 0.5,
			"Glasses_CatsEye_Sun", 0.5,
			"Glasses_Cosmetic_70s_Gold", 0.1,
			"Glasses_Cosmetic_CatsEye", 0.1,
			"Glasses_Cosmetic_HalfMoon", 0.1,
			"Glasses_Cosmetic_MonocleLeft", 0.1,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Cosmetic_Normal_HornRimmed", 0.1,
			"Glasses_Cosmetic_Round_Normal", 0.1,
			"Glasses_Eyepatch_Left", 0.1,
			"Glasses_JackieO", 0.1,
			"Glasses_Round_Shades", 0.1,
			"Glasses_Sun", 1,
			"Gloves_BoxingBlue", 0.01,
			"Gloves_BoxingRed", 0.01,
			"Gloves_LongWomenGloves", 2,
			"Gloves_WhiteTINT", 1,
			"Hat_ArmyWWII", 0.001,
			"Hat_BandanaTINT", 1,
			"Hat_BaseballCapArmy", 0.1,
			"Hat_BaseballHelmet", 0.05,
			"Hat_Beret", 0.5,
			"Hat_BeretArmy", 0.1,
			"Hat_BoxingBlue", 0.01,
			"Hat_BoxingRed", 0.01,
			"Hat_BucketHatFishing", 0.01,
			"Hat_BuildersRespirator", 0.01,
			"Hat_ChefHat", 0.1,
			"Hat_Cowboy", 0.1,
			"Hat_Fedora", 0.1,
			"Hat_Fedora_Delmonte", 0.05,
			"Hat_Fireman", 0.05,
			"Hat_FishermanRainHat", 0.01,
			"Hat_FootballHelmet", 0.01,
			"Hat_GasMask", 0.01,
			"Hat_GolfHat", 0.1,
			"Hat_GolfHatTINT", 0.1,
			"Hat_HardHat", 0.01,
			"Hat_HardHat_Miner", 0.01,
			"Hat_HeadSack_Burlap", 2,
			"Hat_HeadSack_Cotton", 2,
			"Hat_HockeyHelmet", 0.01,
			"Hat_HockeyMask", 0.01,
			"Hat_JockeyHelmet01", 0.005,
			"Hat_JockeyHelmet02", 0.005,
			"Hat_JockeyHelmet03", 0.005,
			"Hat_JockeyHelmet04", 0.005,
			"Hat_JockeyHelmet05", 0.005,
			"Hat_JockeyHelmet06", 0.005,
			"Hat_PeakedCapArmy", 0.01,
			"Hat_PeakedCapYacht", 0.01,
			"Hat_Pirate", 0.01,
			"Hat_Police", 0.1,
			"Hat_Police_Grey", 0.1,
			"Hat_Raccoon", 0.01,
			"Hat_Ranger", 0.1,
			"Hat_RidingHelmet", 0.01,
			"Hat_SantaHat", 0.01,
			"Hat_SantaHatGreen", 0.01,
			"Hat_Sheriff", 0.1,
			"Hat_Stovepipe", 0.01,
			"Hat_Stovepipe_UncleSam", 0.01,
			"Hat_StrawHat", 0.5,
			"Hat_SummerFlowerHat", 1,
			"Hat_SummerHat", 1,
			"Hat_Sweatband", 0.1,
			"Hat_WeddingVeil", 0.01,
			"Hat_Witch", 0.01,
			"Hat_Wizard", 0.01,
			"Medal_Bronze", 4,
			"Medal_Silver", 2,
			"Medal_Gold", 1,
			"MilitaryMedal", 1,
			"Paperback_Play", 20,
			"SCBA_notank", 0.01,
			"Shoes_ArmyBoots", 0.05,
			"Shoes_Black", 0.5,
			"Shoes_BlackBoots", 0.05,
			"Shoes_Bowling", 0.1,
			"Shoes_Brown", 0.5,
			"Shoes_Fancy", 0.1,
			"Shoes_HikingBoots", 0.05,
			"Shoes_RidingBoots", 0.05,
			"Shoes_Strapped", 0.1,
			"Shoes_TrainerTINT", 0.5,
			"Shoes_Wellies", 0.05,
			"Shoes_WorkBoots", 0.05,
			"SmokingPipe", 2,
			"Tie_BowTieFull", 0.5,
			"Tie_Full", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				"Comb", 4,
				"Magazine_Art", 2,
				"Magazine_Cinema", 2,
				"Magazine_Fashion", 2,
				"MakeupEyeshadow", 6,
				"MakeupFoundation", 6,
				"Mirror", 4,
				"Paperback_Diet", 2,
				"Scissors", 1,
			}
		}
	},
	
	BackstageDresser = {
		rolls = 4,
		items = {
			"Belt2", 1,
			"Corset", 0.5,
			"Corset_Black", 0.5,
			"Corset_Red", 0.5,
			"DressKnees_Straps", 0.5,
			"Dress_Knees", 1,
			"Dress_Long", 1,
			"Dress_long_Straps", 0.5,
			"Dress_Short", 1,
			"Dress_SmallBlackStrapless", 0.5,
			"Dress_SmallStrapless", 0.5,
			"Dress_SmallStraps", 0.5,
			"Dress_Straps", 0.5,
			"Dungarees", 0.1,
			"Garter", 0.5,
			"Glasses_Aviators", 0.5,
			"Glasses_CatsEye_Sun", 0.5,
			"Glasses_Cosmetic_70s_Gold", 0.1,
			"Glasses_Cosmetic_CatsEye", 0.1,
			"Glasses_Cosmetic_HalfMoon", 0.1,
			"Glasses_Cosmetic_MonocleLeft", 0.1,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Cosmetic_Normal_HornRimmed", 0.1,
			"Glasses_Cosmetic_Round_Normal", 0.1,
			"Glasses_Eyepatch_Left", 0.1,
			"Glasses_JackieO", 0.1,
			"Glasses_Round_Shades", 0.1,
			"Glasses_Sun", 1,
			"Hat_HeadSack_Burlap", 2,
			"Hat_HeadSack_Cotton", 2,
			"HospitalGown", 0.1,
			"JacketLong_Doctor", 0.1,
			"JacketLong_Santa", 0.1,
			"JacketLong_SantaGreen", 0.1,
			"Jacket_ArmyCamoGreen", 0.1,
			"Jacket_Black", 0.1,
			"Jacket_Chef", 0.1,
			"Jacket_CoatArmy", 0.1,
			"Jacket_Fireman", 0.05,
			"Jacket_Leather", 0.1,
			"Jacket_LeatherBarrelDogs", 0.01,
			"Jacket_LeatherIronRodent", 0.01,
			"Jacket_LeatherWildRacoons", 0.01,
			"Jacket_Leather_Punk", 0.05,
			"Jacket_Police", 0.1,
			"Jacket_Ranger", 0.1,
			"Jacket_Sheriff", 0.1,
			"Jacket_Varsity", 0.1,
			"JewelleryBox", 0.5,
			"Jumper_DiamondPatternTINT", 0.5,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopDiamondTINT", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"Medal_Bronze", 4,
			"Medal_Silver", 2,
			"Medal_Gold", 1,
			"MilitaryMedal", 1,
			"Paperback_Play", 20,
			"PonchoYellowDOWN", 0.05,
			"Shirt_Baseball_KY", 0.1,
			"Shirt_Baseball_Rangers", 0.1,
			"Shirt_Baseball_Z", 0.1,
			"Shirt_Bowling_Blue", 0.005,
			"Shirt_Bowling_Brown", 0.005,
			"Shirt_Bowling_Green", 0.005,
			"Shirt_Bowling_LimeGreen", 0.005,
			"Shirt_Bowling_Pink", 0.005,
			"Shirt_Bowling_White", 0.005,
			"Shirt_CamoGreen", 0.1,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 2,
			"Shirt_HawaiianTINT", 0.1,
			"Shirt_Jockey01", 0.005,
			"Shirt_Jockey02", 0.005,
			"Shirt_Jockey03", 0.005,
			"Shirt_Jockey04", 0.005,
			"Shirt_Jockey05", 0.005,
			"Shirt_Jockey06", 0.005,
			"Shirt_Lumberjack", 0.1,
			"Shirt_Lumberjack_TINT", 0.1,
			"Shirt_OfficerWhite", 0.1,
			"Shirt_PoliceBlue", 0.1,
			"Shirt_PoliceGrey", 0.1,
			"Shirt_Priest", 0.1,
			"Shirt_PrisonGuard", 0.1,
			"Shirt_Ranger", 0.1,
			"Shirt_Scrubs", 0.1,
			"Shirt_Sheriff", 0.1,
			"Shirt_Workman", 0.1,
			"Shorts_BoxingBlue", 0.1,
			"Shorts_BoxingRed", 0.1,
			"Skirt_Knees", 1,
			"Skirt_Long", 1,
			"Skirt_Mini", 0.5,
			"Skirt_Normal", 1,
			"Skirt_Short", 1,
			"SmokingPipe", 2,
			"StockingsBlack", 1,
			"StockingsBlackSemiTrans", 0.5,
			"StockingsBlackTrans", 0.5,
			"StockingsWhite", 1,
			"Suit_Jacket", 2,
			"Suit_JacketTINT", 2,
			"TightsBlack", 1,
			"TightsBlackSemiTrans", 0.5,
			"TightsBlackTrans", 0.5,
			"TightsFishnets", 0.1,
			"TrousersMesh_Leather", 0.1,
			"TrousersMesh_Leather", 0.1,
			"Trousers_ArmyService", 0.1,
			"Trousers_CamoGreen", 0.1,
			"Trousers_Chef", 0.1,
			"Trousers_Fireman", 0.1,
			"Trousers_LeatherBlack", 0.1,
			"Trousers_Police", 0.1,
			"Trousers_PoliceGrey", 0.1,
			"Trousers_PrisonGuard", 0.1,
			"Trousers_Ranger", 0.1,
			"Trousers_Santa", 0.1,
			"Trousers_SantaGreen", 0.1,
			"Trousers_Scrubs", 0.1,
			"Trousers_Sheriff", 0.1,
			"Trousers_Suit", 2,
			"Trousers_SuitTEXTURE", 2,
			"Trousers_SuitWhite", 0.1,
			"Trousers_WhiteTINT", 0.5,
			"Tshirt_ArmyGreen", 0.1,
			"Tshirt_CamoGreen", 0.1,
			"Tshirt_LongSleeve_SuperColor", 0.1,
			"Tshirt_Profession_FiremanWhite", 0.1,
			"Tshirt_Profession_PoliceWhite", 0.1,
			"Tshirt_Profession_RangerGreen", 0.1,
			"Tshirt_Profession_VeterenGreen", 0.1,
			"Tshirt_Rock", 0.1,
			"Tshirt_Scrubs", 0.1,
			"Tshirt_Sheriff", 0.1,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.1,
			"Vest_DefaultTEXTURE", 0.5,
			"Vest_Foreman", 0.1,
			"Vest_HighViz", 0.1,
			"Vest_Hunting_CamoGreen", 0.1,
			"Vest_Hunting_Grey", 0.01,
			"Vest_Hunting_Orange", 0.1,
			"Vest_Trucker", 0.1,
			"Vest_Waistcoat", 0.5,
			"Vest_WaistcoatTINT", 0.5,
			"WeddingDress", 0.01,
			"WeddingJacket", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				"Comb", 4,
				"Magazine_Art", 2,
				"Magazine_Cinema", 2,
				"Magazine_Fashion", 2,
				"MakeupEyeshadow", 6,
				"MakeupFoundation", 6,
				"Mirror", 4,
				"Paperback_Diet", 2,
				"Scissors", 1,
			}
		}
	},
	
	BackstageLockers = {
		rolls = 2,
		items = {
			"Belt2", 1,
			"Corset", 0.5,
			"Corset_Black", 0.5,
			"Corset_Red", 0.5,
			"DressKnees_Straps", 0.5,
			"Dress_Knees", 1,
			"Dress_Long", 1,
			"Dress_long_Straps", 0.5,
			"Dress_Short", 1,
			"Dress_SmallBlackStrapless", 0.5,
			"Dress_SmallStrapless", 0.5,
			"Dress_SmallStraps", 0.5,
			"Dress_Straps", 0.5,
			"Dungarees", 0.1,
			"Garter", 0.5,
			"Glasses_Aviators", 0.5,
			"Glasses_CatsEye_Sun", 0.5,
			"Glasses_Cosmetic_70s_Gold", 0.1,
			"Glasses_Cosmetic_CatsEye", 0.1,
			"Glasses_Cosmetic_HalfMoon", 0.1,
			"Glasses_Cosmetic_MonocleLeft", 0.1,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Cosmetic_Normal_HornRimmed", 0.1,
			"Glasses_Cosmetic_Round_Normal", 0.1,
			"Glasses_Eyepatch_Left", 0.1,
			"Glasses_JackieO", 0.1,
			"Glasses_Round_Shades", 0.1,
			"Glasses_Sun", 1,
			"Gloves_BoxingBlue", 0.01,
			"Gloves_BoxingRed", 0.01,
			"Gloves_LongWomenGloves", 2,
			"Gloves_WhiteTINT", 1,
			"Hat_ArmyWWII", 0.001,
			"Hat_BandanaTINT", 1,
			"Hat_BaseballCapArmy", 0.1,
			"Hat_BaseballHelmet", 0.05,
			"Hat_Beret", 0.5,
			"Hat_BeretArmy", 0.1,
			"Hat_BoxingBlue", 0.01,
			"Hat_BoxingRed", 0.01,
			"Hat_BucketHatFishing", 0.01,
			"Hat_BuildersRespirator", 0.01,
			"Hat_ChefHat", 0.1,
			"Hat_Cowboy", 0.1,
			"Hat_Fedora", 0.1,
			"Hat_Fedora_Delmonte", 0.05,
			"Hat_Fireman", 0.05,
			"Hat_FishermanRainHat", 0.01,
			"Hat_FootballHelmet", 0.01,
			"Hat_GasMask", 0.01,
			"Hat_GolfHat", 0.1,
			"Hat_GolfHatTINT", 0.1,
			"Hat_HardHat", 0.01,
			"Hat_HardHat_Miner", 0.01,
			"Hat_HeadSack_Burlap", 2,
			"Hat_HeadSack_Cotton", 2,
			"Hat_HockeyHelmet", 0.01,
			"Hat_HockeyMask", 0.01,
			"Hat_JockeyHelmet01", 0.005,
			"Hat_JockeyHelmet02", 0.005,
			"Hat_JockeyHelmet03", 0.005,
			"Hat_JockeyHelmet04", 0.005,
			"Hat_JockeyHelmet05", 0.005,
			"Hat_JockeyHelmet06", 0.005,
			"Hat_PeakedCapArmy", 0.01,
			"Hat_PeakedCapYacht", 0.01,
			"Hat_Pirate", 0.01,
			"Hat_Police", 0.1,
			"Hat_Police_Grey", 0.1,
			"Hat_Raccoon", 0.01,
			"Hat_Ranger", 0.1,
			"Hat_RidingHelmet", 0.01,
			"Hat_SantaHat", 0.01,
			"Hat_SantaHatGreen", 0.01,
			"Hat_Sheriff", 0.1,
			"Hat_Stovepipe", 0.01,
			"Hat_Stovepipe_UncleSam", 0.01,
			"Hat_StrawHat", 0.5,
			"Hat_SummerFlowerHat", 1,
			"Hat_SummerHat", 1,
			"Hat_Sweatband", 0.1,
			"Hat_WeddingVeil", 0.01,
			"Hat_Witch", 0.01,
			"Hat_Wizard", 0.01,
			"HospitalGown", 0.1,
			"JacketLong_Doctor", 0.1,
			"JacketLong_Santa", 0.1,
			"JacketLong_SantaGreen", 0.1,
			"Jacket_ArmyCamoGreen", 0.1,
			"Jacket_Black", 0.1,
			"Jacket_Chef", 0.1,
			"Jacket_CoatArmy", 0.1,
			"Jacket_Fireman", 0.05,
			"Jacket_Leather", 0.1,
			"Jacket_LeatherBarrelDogs", 0.01,
			"Jacket_LeatherIronRodent", 0.01,
			"Jacket_LeatherWildRacoons", 0.01,
			"Jacket_Leather_Punk", 0.05,
			"Jacket_Police", 0.1,
			"Jacket_Ranger", 0.1,
			"Jacket_Sheriff", 0.1,
			"Jacket_Varsity", 0.1,
			"Jumper_DiamondPatternTINT", 0.5,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopDiamondTINT", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"Medal_Bronze", 4,
			"Medal_Silver", 2,
			"Medal_Gold", 1,
			"MilitaryMedal", 1,
			"Paperback_Play", 20,
			"PonchoYellowDOWN", 0.05,
			"SCBA_notank", 0.01,
			"Shirt_Baseball_KY", 0.1,
			"Shirt_Baseball_Rangers", 0.1,
			"Shirt_Baseball_Z", 0.1,
			"Shirt_Bowling_Blue", 0.005,
			"Shirt_Bowling_Brown", 0.005,
			"Shirt_Bowling_Green", 0.005,
			"Shirt_Bowling_LimeGreen", 0.005,
			"Shirt_Bowling_Pink", 0.005,
			"Shirt_Bowling_White", 0.005,
			"Shirt_CamoGreen", 0.1,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 2,
			"Shirt_HawaiianTINT", 0.1,
			"Shirt_Jockey01", 0.005,
			"Shirt_Jockey02", 0.005,
			"Shirt_Jockey03", 0.005,
			"Shirt_Jockey04", 0.005,
			"Shirt_Jockey05", 0.005,
			"Shirt_Jockey06", 0.005,
			"Shirt_Lumberjack", 0.1,
			"Shirt_Lumberjack_TINT", 0.1,
			"Shirt_OfficerWhite", 0.1,
			"Shirt_PoliceBlue", 0.1,
			"Shirt_PoliceGrey", 0.1,
			"Shirt_Priest", 0.1,
			"Shirt_PrisonGuard", 0.1,
			"Shirt_Ranger", 0.1,
			"Shirt_Scrubs", 0.1,
			"Shirt_Sheriff", 0.1,
			"Shirt_Workman", 0.1,
			"Shoes_ArmyBoots", 0.05,
			"Shoes_Black", 0.5,
			"Shoes_BlackBoots", 0.05,
			"Shoes_Bowling", 0.1,
			"Shoes_Brown", 0.5,
			"Shoes_Fancy", 0.1,
			"Shoes_HikingBoots", 0.05,
			"Shoes_RidingBoots", 0.05,
			"Shoes_Strapped", 0.1,
			"Shoes_TrainerTINT", 0.5,
			"Shoes_Wellies", 0.05,
			"Shoes_WorkBoots", 0.05,
			"Shorts_BoxingBlue", 0.1,
			"Shorts_BoxingRed", 0.1,
			"Skirt_Knees", 1,
			"Skirt_Long", 1,
			"Skirt_Mini", 0.5,
			"Skirt_Normal", 1,
			"Skirt_Short", 1,
			"SmokingPipe", 2,
			"StockingsBlack", 1,
			"StockingsBlackSemiTrans", 0.5,
			"StockingsBlackTrans", 0.5,
			"StockingsWhite", 1,
			"Suit_Jacket", 2,
			"Suit_JacketTINT", 2,
			"Tie_BowTieFull", 0.5,
			"Tie_Full", 0.5,
			"TightsBlack", 1,
			"TightsBlackSemiTrans", 0.5,
			"TightsBlackTrans", 0.5,
			"TightsFishnets", 0.1,
			"TrousersMesh_Leather", 0.1,
			"Trousers_ArmyService", 0.1,
			"Trousers_CamoGreen", 0.1,
			"Trousers_Chef", 0.1,
			"Trousers_Fireman", 0.1,
			"Trousers_LeatherBlack", 0.1,
			"Trousers_Police", 0.1,
			"Trousers_PoliceGrey", 0.1,
			"Trousers_PrisonGuard", 0.1,
			"Trousers_Ranger", 0.1,
			"Trousers_Santa", 0.1,
			"Trousers_SantaGreen", 0.1,
			"Trousers_Scrubs", 0.1,
			"Trousers_Sheriff", 0.1,
			"Trousers_Suit", 2,
			"Trousers_SuitTEXTURE", 2,
			"Trousers_SuitWhite", 0.1,
			"Trousers_WhiteTINT", 0.5,
			"Tshirt_ArmyGreen", 0.1,
			"Tshirt_CamoGreen", 0.1,
			"Tshirt_LongSleeve_SuperColor", 0.1,
			"Tshirt_Profession_FiremanWhite", 0.1,
			"Tshirt_Profession_PoliceWhite", 0.1,
			"Tshirt_Profession_RangerGreen", 0.1,
			"Tshirt_Profession_VeterenGreen", 0.1,
			"Tshirt_Rock", 0.1,
			"Tshirt_Scrubs", 0.1,
			"Tshirt_Sheriff", 0.1,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.1,
			"Vest_DefaultTEXTURE", 0.5,
			"Vest_Foreman", 0.1,
			"Vest_HighViz", 0.1,
			"Vest_Hunting_CamoGreen", 0.1,
			"Vest_Hunting_Grey", 0.01,
			"Vest_Hunting_Orange", 0.1,
			"Vest_Trucker", 0.1,
			"Vest_Waistcoat", 0.5,
			"Vest_WaistcoatTINT", 0.5,
			"WeddingDress", 0.01,
			"WeddingJacket", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				"Comb", 4,
				"Magazine_Art", 2,
				"Magazine_Cinema", 2,
				"Magazine_Fashion", 2,
				"MakeupEyeshadow", 6,
				"MakeupFoundation", 6,
				"Mirror", 4,
				"Paperback_Diet", 2,
				"Scissors", 1,
			}
		}
	},
	
	-- Snacks for stage actors.
	BackstageFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BagelPlain", 4,
			"BagelPoppy", 4,
			"BagelSesame", 4,
			"Champagne", 1,
			"CinnamonRoll", 8,
			"Croissant", 8,
			"Danish", 8,
			"DoughnutChocolate", 4,
			"DoughnutFrosted", 4,
			"DoughnutJelly", 4,
			"DoughnutPlain", 4,
			"MuffinFruit", 8,
			"MuffinGeneric", 8,
			"Painauchocolat", 8,
			"WaterBottle", 10,
			"WineAged", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Counterweights for stage lighting.
	BackstageRigging = {
		isShop = true,
		rolls = 4,
		items = {
			"Rope", 50,
			"Rope", 20,
			"RopeStack", 1,
			"Sandbag", 20,
			"Sandbag", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- This is a container from older versions that is now deprecated but kept around to stop old mods from breaking.
	Bakery = BakeryMisc,
	
	-- Bakery display shelves. Can be open or behind glass.
	BakeryBread = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BagelPlain", 8,
			"BagelPoppy", 8,
			"BagelSesame", 8,
			"Baguette", 10,
			"Bread", 20,
			"Bread", 10,
			"BunsHamburger", 10,
			"BunsHotdog", 10,
			"Croissant", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BakeryCake = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CakeBlackForest", 8,
			"CakeCarrot", 8,
			"CakeCheeseCake", 8,
			"CakeChocolate", 8,
			"CakeRedVelvet", 8,
			"CakeSlice", 20,
			"CakeSlice", 10,
			"CakeStrawberryShortcake", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BakeryDoughnuts = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"DoughnutChocolate", 20,
			"DoughnutChocolate", 10,
			"DoughnutFrosted", 20,
			"DoughnutFrosted", 10,
			"DoughnutJelly", 20,
			"DoughnutJelly", 10,
			"DoughnutPlain", 20,
			"DoughnutPlain", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Ingredient prep station.
	-- Commercial kitchens don't use the 'isShop' flag so their contents reflect some level of use.
	BakeryKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"BakingSoda", 2,
			"Butter", 2,
			"CannedMilk", 2,
			"CannedMilk_Box", 0.001,
			"Chocolate", 4,
			"ChocolateChips", 8,
			"Cinnamon", 8,
			"CocoaPowder", 8,
			"Flour2", 10,
			"GrahamCrackers", 4,
			"Lard", 1,
			"Margarine", 2,
			"Marshmallows", 4,
			"OilVegetable", 2,
			"Sugar", 10,
			"SugarBrown", 8,
			"Yeast", 4,
			-- Trays/Dishes
			"BakingPan", 8,
			"BakingTray", 8,
			"Bowl", 10,
			"MuffinTray", 8,
			-- Utensils
			"BreadKnife", 4,
			"RollingPin", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"KitchenKnife", 4,
				"KitchenTongs", 10,
				"KnifeParing", 8,
				"Ladle", 10,
				"Spoon", 8,
				"Whisk", 10,
				-- Misc.
				"Aluminum", 8,
				"Apron_White", 8,
				"CuttingBoardPlastic", 10,
				"DishCloth", 10,
				"Hat_ChefHat", 8,
				"OvenMitt", 10,
			}
		}
	},
	
	-- Extra prep equipment and ingredients.
	BakeryKitchenCutlery = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Utensils
			"BreadKnife", 8,
			"KitchenKnife", 8,
			"KitchenTongs", 10,
			"KnifeParing", 10,
			"Ladle", 10,
			"RollingPin", 8,
			"Spoon", 10,
			"Whisk", 10,
			-- Ingredients
			"BakingSoda", 2,
			"CannedMilk", 2,
			"CannedMilk_Box", 0.001,
			"ChocolateChips", 4,
			"Cinnamon", 4,
			"CocoaPowder", 4,
			"Flour2", 6,
			"OilVegetable", 1,
			"Sugar", 6,
			"SugarBrown", 4,
			"Yeast", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"Aluminum", 8,
				"CuttingBoardPlastic", 10,
				"DishCloth", 10,
				"OvenMitt", 10,
				"Apron_White", 8,
				"Hat_ChefHat", 8,
			}
		}
	},
	
	-- Not entirely sure what bakeries keep in their freezers or if they have them?
	-- Here's some extra butter and margarine since people sometimes stock it like this IRL.
	BakeryKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Butter", 20,
			"Butter", 20,
			"Butter", 10,
			"Butter", 10,
			"Margarine", 20,
			"Margarine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Dough and batter storage, plus additionmal ingredients. Fruit/veg selection is based on current bakery items.
	BakeryKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Dough/Batter
			"BreadDough", 50,
			"CakeBatter", 20,
			"PieDough", 20,
			-- Fruit/Veg.
			"Apple", 4,
			"Carrots", 4,
			"Cherry", 8,
			"Lemon", 4,
			"Lime", 4,
			"Strewberrie", 8,
			-- Ingredients
			"Butter", 10,
			"EggCarton", 8,
			"Icing", 8,
			"JamFruit", 8,
			"JamMarmalade", 4,
			"Lard", 4,
			"Margarine", 8,
			"Milk", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Box of unopened, non-refrigerated ingredients. Weighted towards flour and sugar.
	BakeryKitchenStorage = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BakingSoda", 4,
			"CannedMilk", 4,
			"CannedMilk_Box", 0.001,
			"Chocolate", 6,
			"ChocolateChips", 8,
			"Cinnamon", 8,
			"CocoaPowder", 8,
			"Flour2", 20,
			"GrahamCrackers", 6,
			"Marshmallows", 6,
			"OilVegetable", 4,
			"Sugar", 20,
			"SugarBrown", 8,
			"Yeast", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Extra trays, a few extra utensils and ingredients.
	BakeryKitchenTrays = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Trays/Dishes
			"BakingPan", 20,
			"BakingTray", 20,
			"MuffinTray", 20,
			"Bowl", 20,
			"Saucepan", 8,
			"SaucepanCopper", 1,
			-- Utensils
			"BreadKnife", 4,
			"RollingPin", 4,
			-- Ingredients
			"BakingSoda", 2,
			"CannedMilk", 2,
			"CannedMilk_Box", 0.001,
			"ChocolateChips", 4,
			"Cinnamon", 4,
			"CocoaPowder", 4,
			"Flour2", 6,
			"OilVegetable", 1,
			"Sugar", 6,
			"SugarBrown", 4,
			"Yeast", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"KitchenTongs", 10,
				"Ladle", 10,
				"Spoon", 8,
				"Whisk", 10,
				-- Misc.
				"Aluminum", 8,
				"Apron_White", 8,
				"CuttingBoardPlastic", 10,
				"DishCloth", 10,
				"Hat_ChefHat", 8,
				"OvenMitt", 10,
			}
		}
	},
	
	BakeryMisc = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CinnamonRoll", 8,
			"CookieChocolateChip", 2,
			"CookieJelly", 2,
			"CookiesChocolate", 2,
			"CookiesOatmeal", 2,
			"CookiesShortbread", 2,
			"CookiesSugar", 2,
			"CrispyRiceSquare", 8,
			"Cupcake", 8,
			"Danish", 8,
			"Gingerbreadman", 8,
			"JellyRoll", 8,
			"LemonBar", 8,
			"MuffinFruit", 6,
			"MuffinGeneric", 6,
			"Painauchocolat", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BakeryPie = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Pie", 20,
			"Pie", 10,
			"PieApple", 8,
			"PieBlueberry", 8,
			"PieKeyLime", 8,
			"PieLemonMeringue", 8,
			"PiePumpkin", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Music festival merchandise.
	BandMerchClothes = {
		isShop = true,
		rolls = 4,
		items = {
			"Tshirt_BluesCountry", 10,
			"Tshirt_EMD", 10,
			"Tshirt_HipHop", 10,
			"Tshirt_Indie", 10,
			"Tshirt_Metal", 10,
			"Tshirt_Punk", 10,
			"Tshirt_Rock", 10,
			"Tshirt_Rock2", 10,
			"Tshirt_TieDye", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Same as above.
	BandMerchShelves = {
		isShop = true,
		rolls = 4,
		items = {
			"BellyButton_DangleGold", 1,
			"BellyButton_DangleSilver", 1,
			"BellyButton_RingGold", 1,
			"BellyButton_RingSilver", 1,
			"BellyButton_StudGold", 1,
			"BellyButton_StudSilver", 1,
			"Belt2", 10,
			"Bracelet_LeftFriendshipTINT", 10,
			"Gloves_FingerlessLeatherGloves", 1,
			"Gloves_LeatherGloves", 1,
			"Hat_Bandana", 20,
			"Hat_BandanaTINT", 10,
			"Necklace_SilverCrucifix", 10,
			"Necklace_YingYang", 10,
			"NoseRing_Gold", 8,
			"NoseRing_Silver", 8,
			"NoseStud_Gold", 8,
			"Shoes_ArmyBoots", 6,
			"Shoes_HikingBoots", 6,
			"Shorts_CamoGreenLong", 8,
			"Trousers_CamoDesert", 6,
			"Trousers_CamoGreen", 6,
			"Trousers_Denim", 6,
			"Trousers_JeanBaggy", 20,
			"Trousers_JeanBaggy", 10,
			"Trousers_LeatherBlack", 1,
			"TrousersMesh_Leather", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BandPracticeClothing = {
		rolls = 4,
		items = {
			"Book_Horror", 1,
			"Book_Music", 1,
			"Book_Occult", 1,
			"Book_Quackery", 1,
			"Bracelet_BangleRightSilver", 8,
			"Earring_Stud_Gold", 8,
			"Glasses_Aviators", 0.5,
			"Glasses_Cosmetic_Normal", 1,
			"Glasses_Sun", 1,
			"Gloves_FingerlessLeatherGloves", 1,
			"Hat_BandanaTINT", 10,
			"HottieZ_New", 1,
			"Jacket_Leather_Punk", 4,
			"Magazine_Car", 6,
			"Magazine_Horror", 6,
			"Magazine_Music", 6,
			"Necklace_Gold", 8,
			"NoseRing_Gold", 8,
			"NoseRing_Silver", 8,
			"NoseStud_Gold", 8,
			"Paperback_Conspiracy", 4,
			"Paperback_Horror", 4,
			"Paperback_NewAge", 4,
			"Paperback_Occult", 4,
			"Paperback_Philosophy", 4,
			"Paperback_Quackery", 4,
			"Ring_Left_RingFinger_Gold", 8,
			"Shoes_ArmyBoots", 6,
			"Shoes_HikingBoots", 6,
			"Shoes_TrainerTINT", 10,
			"Shorts_CamoGreenLong", 8,
			"Trousers_CamoDesert", 6,
			"Trousers_CamoGreen", 6,
			"Trousers_Denim", 6,
			"Trousers_JeanBaggy", 10,
			"Tshirt_Rock", 20,
			"Tshirt_Rock", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Pretty sure this only shows up in the band trailers at the music festival.
	BandPracticeFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Alcohol
			"BeerBottle", 10,
			"BeerCan", 10,
			"BeerCanPack", 1,
			"BeerImported", 8,
			"BeerPack", 1,
			"Champagne", 1,
			"Flask", 1,
			"Rum", 2,
			"Scotch", 2,
			"Tequila", 2,
			"Vodka", 2,
			"Whiskey", 2,
			-- Snacks
			"Burger", 8,
			"Burrito", 8,
			"Caviar", 0.1,
			"ChickenFried", 4,
			"Corndog", 4,
			"FriedOnionRings", 8,
			"Fries", 8,
			"Hotdog", 4,
			"Paperbag_Jays", 1,
			"Paperbag_Spiffos", 1,
			"Pizza", 4,
			"Taco", 4,
			-- Condiments
			"Hotsauce", 1,
			"Ketchup", 1,
			"MayonnaiseFull", 1,
			"Mustard", 1,
			"Vinegar2", 1,
			-- Not-Alcohol
			"Pop", 4,
			"Pop2", 4,
			"Pop3", 4,
			"PopBottle", 4,
			"PopBottleRare", 1,
			"WaterBottle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Garage band instruments. Punk/grunge focused.
	BandPracticeInstruments = {
		rolls = 4,
		items = {
			"CDplayer", 10,
			"Disc_Retail", 20,
			"Disc_Retail", 10,
			"Drumstick", 20,
			"Drumstick", 10,
			"Flightcase", 1,
			"GuitarAcoustic", 2,
			"Guitarcase", 1,
			"GuitarElectric", 8,
			"GuitarElectricBass", 8,
			"Headphones", 20,
			"Keytar", 4,
			"Microphone", 20,
			"Mov_BlackSpeakerCabinet", 4,
			"Mov_GuitarAmplifier", 10,
			"Mov_SnareDrum", 4,
			"Mov_TomDrum", 4,
			"Mov_WoodSpeakerCabinet", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BankDeposit = {
		rolls = 4,
		items = {
			"Bag_MoneyBag", 0.1,
			"Bracelet_BangleRightGold", 4,
			"Bracelet_ChainRightGold", 4,
			"Briefcase_Money", 0.1,
			"CameraDisposable", 0.1,
			"CameraFilm", 0.1,
			"Earring_Dangly_Diamond", 1,
			"Earring_Dangly_Emerald", 1,
			"Earring_Dangly_Ruby", 1,
			"Earring_Dangly_Sapphire", 1,
			"Earring_LoopLrg_Gold", 1,
			"Earring_LoopMed_Gold", 1,
			"Earring_LoopSmall_Gold_Both", 1,
			"Earring_LoopSmall_Gold_Top", 1,
			"GemBag", 1,
			"IDcard", 10,
			"IDcard_Blank", 0.1,
			"MilitaryMedal", 1,
			"Money", 100,
			"Money", 50,
			"Money", 20,
			"Money", 20,
			"MoneyBundle", 100,
			"NecklaceLong_Gold", 10,
			"Necklace_Gold", 10,
			"Necklace_GoldDiamond", 4,
			"Necklace_GoldRuby", 4,
			"Paperwork", 50,
			"Paperwork", 20,
			"Paperwork", 10,
			"Paperwork", 10,
			"Photo_Secret", 0.1,
			"Pocketwatch", 8,
			"Postcard", 20,
			"Ring_Left_RingFinger_Gold", 10,
			"Ring_Left_RingFinger_GoldDiamond", 4,
			"Ring_Left_RingFinger_GoldRuby", 4,
			"ScratchTicket_Winner", 0.1,
			"SmallGoldBar", 4,
			"SmallSilverBar", 8,
			"StockCertificate", 50,
			"StockCertificate", 20,
			"StockCertificate", 10,
			"StockCertificate", 10,
			"WristWatch_Left_ClassicGold", 10,
			"WristWatch_Left_Expensive", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Extra glasses.
	BarCounterGlasses = {
		isShop = true,
		rolls = 4,
		items = {
			"DrinkingGlass", 50,
			"DrinkingGlass", 20,
			"DrinkingGlass", 10,
			"DrinkingGlass", 10,
			"GlassTumbler", 20,
			"GlassTumbler", 10,
			"GlassWine", 20,
			"GlassWine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"BottleOpener", 4,
				"CocktailUmbrella", 50,
				"CocktailUmbrella", 20,
				"Corkscrew", 2,
				"DishCloth", 10,
				"PaperNapkins2", 10,
				"Receipt", 10,
			}
		}
	},
	
	-- Extra storage under the counter. Mostly drinks, but also mix and snacks.
	BarCounterLiquor = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			-- Beer/Cider
			"BeerBottle", 8,
			"BeerImported", 4,
			"Cider", 4,
			-- Wine
			"Champagne", 0.1,
			"Port", 2,
			"Sherry", 2,
			"Vermouth", 2,
			"Wine", 4,
			"Wine2", 4,
			"WineAged", 1,
			"WineScrewtop", 6,
			-- Spirits
			"Brandy", 4,
			"Gin", 4,
			"Rum", 4,
			"Scotch", 4,
			"Tequila", 4,
			"Vodka", 4,
			"Whiskey", 4,
			-- Mix
			"CoffeeLiquer", 2,
			"Curacao", 2,
			"Grenadine", 2,
			"JuiceCranberry", 1,
			"JuiceLemon", 1,
			"JuiceOrange", 1,
			"JuiceTomato", 1,
			"SimpleSyrup", 2,
			-- Snacks
			"Crisps", 1,
			"Crisps2", 1,
			"Crisps3", 1,
			"Crisps4", 1,
			"Olives", 4,
			"Peanuts", 4,
			"Pickles", 2,
			"PorkRinds", 4,
			"Pretzel", 4,
			"TortillaChips", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"BottleOpener", 4,
				"CocktailUmbrella", 50,
				"CocktailUmbrella", 20,
				"Corkscrew", 2,
				"DishCloth", 10,
				"PaperNapkins2", 10,
				"Receipt", 10,
			}
		}
	},
	
	-- Snacks, smokes, and other stuff.
	BarCounterMisc = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			-- Beer/Cider
			"BeerBottle", 8,
			"BeerImported", 4,
			"Cider", 4,
			-- Tobacco/Smoking
			"Cigar", 0.1,
			"CigaretteCarton", 0.01,
			"CigarettePack", 4,
			"Cigarillo", 8,
			"Lighter", 2,
			"LighterDisposable", 4,
			"Matches", 8,
			-- Drinks (Non-Alcoholic)
			"Pop", 4,
			"Pop2", 4,
			"Pop3", 4,
			"PopBottle", 2,
			"PopBottleRare", 1,
			"SodaCan", 4,
			--"SodaCanRare", 0.5,
			-- Misc.
			"ScratchTicket", 20,
			"ScratchTicket", 10,
			"Sparklers", 8,
			-- Snacks
			"Crisps", 4,
			"Crisps2", 4,
			"Crisps3", 4,
			"Crisps4", 4,
			"Olives", 8,
			"Peanuts", 8,
			"Pickles", 4,
			"PorkRinds", 8,
			"Pretzel", 8,
			"TortillaChips", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"BottleOpener", 4,
				"CocktailUmbrella", 50,
				"CocktailUmbrella", 20,
				"Corkscrew", 2,
				"DishCloth", 10,
				"PaperNapkins2", 10,
				"Receipt", 10,
			}
		}
	},
	
	-- Same as BarCounterLiquor, but has weapons at the bottom of the list.
	BarCounterWeapon = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			-- Beer/Cider
			"BeerBottle", 8,
			"BeerImported", 4,
			"Cider", 4,
			-- Wine
			"Champagne", 0.1,
			"Port", 2,
			"Sherry", 2,
			"Vermouth", 2,
			"Wine", 4,
			"Wine2", 4,
			"WineAged", 1,
			"WineScrewtop", 6,
			-- Spirits
			"Brandy", 4,
			"Gin", 4,
			"Rum", 4,
			"Scotch", 4,
			"Tequila", 4,
			"Vodka", 4,
			"Whiskey", 4,
			-- Mix
			"CoffeeLiquer", 2,
			"Curacao", 2,
			"Grenadine", 2,
			"JuiceCranberry", 1,
			"JuiceLemon", 1,
			"JuiceOrange", 1,
			"JuiceTomato", 1,
			"SimpleSyrup", 2,
			-- Snacks
			"Crisps", 1,
			"Crisps2", 1,
			"Crisps3", 1,
			"Crisps4", 1,
			"Olives", 4,
			"Peanuts", 4,
			"Pickles", 2,
			"PorkRinds", 4,
			"Pretzel", 4,
			"TortillaChips", 4,
			-- Weapons
			"Bag_ShotgunDblSawnoffBag", 10,
			"Bag_ShotgunSawnoffBag", 10,
			"ShortBat", 50,
			"DoubleBarrelShotgunSawnoff", 20,
			"ShotgunSawnoff", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"BottleOpener", 4,
				"CocktailUmbrella", 50,
				"CocktailUmbrella", 20,
				"Corkscrew", 2,
				"DishCloth", 10,
				"PaperNapkins2", 10,
				"Receipt", 10,
			}
		}
	},
	
	-- Extra darts. Where's the board?
	BarCrateDarts = {
		rolls = 10,
		items = {
			"Dart", 50,
			"Dart", 20,
			"Dart", 20,
			"Dart", 10,
			"Dart", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BarCratePool = {
		rolls = 4,
		items = {
			"Poolcue", 20,
			"Poolcue", 20,
			"Poolcue", 10,
			"Poolcue", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"PoolBall", 50,
				"PoolBall", 20,
				"PoolBall", 20,
				"PoolBall", 10,
				"PoolBall", 10,
			}
		}
	},
	
	-- These bottles should be opened.
	BarShelfLiquor = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Wine
			"Champagne", 0.1,
			"Port", 2,
			"Sherry", 2,
			"Vermouth", 2,
			"Wine", 4,
			"Wine2", 4,
			"WineAged", 1,
			"WineScrewtop", 6,
			-- Spirits
			"Brandy", 4,
			"Gin", 4,
			"Rum", 4,
			"Scotch", 4,
			"Tequila", 4,
			"Vodka", 4,
			"Whiskey", 4,
			-- Mix
			"CoffeeLiquer", 2,
			"Curacao", 2,
			"Grenadine", 2,
			"JuiceCranberry", 1,
			"JuiceLemon", 1,
			"JuiceOrange", 1,
			"JuiceTomato", 1,
			"SimpleSyrup", 2,
			-- Glasses
			"DrinkingGlass", 50,
			"DrinkingGlass", 20,
			"GlassTumbler", 20,
			"GlassWine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"BottleOpener", 4,
				"CocktailUmbrella", 50,
				"CocktailUmbrella", 20,
				"Corkscrew", 2,
				"DishCloth", 10,
				"PaperNapkins2", 10,
				"Receipt", 10,
			}
		}
	},
	
	-- Super-low chance of well-maintained old tools.
	BarnTools = {
		rolls = 4,
		items = {
			-- Tools
			"Axe_Old", 0.01,
			"BallPeenHammerForged", 0.1,
			"ClubHammerForged", 0.1,
			"CrowbarForged", 0.1,
			"Fleshing_Tool", 10,
			"GardenFork_Forged", 0.5,
			"GardenHoeForged", 0.1,
			"HandAxe", 1,
			"HandAxeForged", 0.01,
			"HandAxe_Old", 0.05,
			"HandDrill", 8,
			"HandScythe", 20,
			"HandScytheForged", 0.1,
			"HeavyChain", 4,
			"Lantern_Hurricane", 8,
			"OldDrill", 1,
			"PickAxeForged", 0.01,
			"Scythe", 10,
			"ScytheForged", 0.1,
			"SheepElectricShears", 8,
			"SheepShears", 4,
			"SheepShearsForged", 0.1,
			"SpadeForged", 0.1,
			"WoodAxeForged", 0.01,
			-- Misc.
			"BucketForged", 4,
			"BucketWood", 8,
			"BucketLargeWood", 1,
			-- Materials
			"AnimalFeedBag", 8,
			"BurlapPiece", 10,
			"CheeseCloth", 10,
			"EmptySandbag", 50,
			"EmptySandbag", 20,
			"Handle", 4,
			"LongHandle", 4,
			"LongStick", 4,
			"OldAxeHead", 4,
			"Rope", 50,
			"Rope", 20,
			"RopeStack", 0.1,
			"SmallHandle", 8,
			"Whetstone", 10,
			"WoodenStick2", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BaseballLockers = {
		rolls = 4,
		items = {
			"AthleticCup", 4,
			"Bag_BaseballBag", 10,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"Baseball", 10,
			"BaseballBat", 4,
			"BaseballBat_Metal", 2,
			"BathTowel", 8,
			"Belt2", 4,
			"Book_Baseball", 2,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flask", 1,
			"Gloves_FingerlessLeatherGloves", 4,
			"Gum", 10,
			"Hat_BaseballHelmet", 4,
			"Headphones", 1,
			"Kneepad_Left_Sport", 4,
			"Money", 4,
			"Paperback_Baseball", 8,
			"ShinKneeGuard_L_Baseball", 4,
			"Shirt_Baseball_KY", 4,
			"Shirt_Baseball_Rangers", 4,
			"Shirt_Baseball_Z", 4,
			"Shoes_TrainerTINT", 8,
			"Sportsbottle", 4,
			"TobaccoChewing", 8,
			"Trousers_WhiteTEXTURE", 10,
			"Vest_CatcherVest", 8,
			"Whiskey", 1,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},
	
	-- More focused on memorabilia than actual equipment but still has some as a rarity.
	BaseballStoreShelves = {
		isShop = true,
		rolls = 4,
		items = {
			"AthleticCup", 1,
			"Bag_BaseballBag", 6,
			"Baseball", 20,
			"Baseball", 10,
			"BaseballBat", 4,
			"BaseballBat_Metal", 1,
			"Book_Baseball", 10,
			"Hat_BaseballCap", 2,
			"Hat_BaseballCapBlue", 2,
			"Hat_BaseballCapGreen", 2,
			"Hat_BaseballCapKY", 2,
			"Hat_BaseballCapKY_Red", 2,
			"Hat_BaseballCapRed", 2,
			"Hat_BaseballCapTINT", 10,
			"Hat_BaseballHelmet", 2,
			"Kneepad_Left_Sport", 1,
			"Paperback_Baseball", 20,
			"Paperback_Baseball", 10,
			"ShinKneeGuard_L_Baseball", 2,
			"Shirt_Baseball_KY", 10,
			"Shirt_Baseball_Rangers", 10,
			"Shirt_Baseball_Z", 10,
			"Shoes_TrainerTINT", 2,
			"SportsbottleEmpty", 10,
			"Trousers_WhiteTEXTURE", 4,
			"Vest_CatcherVest", 8,
			"Whistle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BatFactoryBats = {
		rolls = 4,
		items = {
			"BaseballBat", 50,
			"BaseballBat", 20,
			"BaseballBat", 20,
			"BaseballBat", 10,
			"BaseballBat", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BathroomCabinet = {
		rolls = 4,
		items = {
			-- Medical
			"AlcoholWipes", 4,
			"Antibiotics", 0.5,
			"Bandage", 2,
			"Bandaid", 8,
			"Disinfectant", 1,
			"Pills", 4,
			"PillsAntiDep", 1,
			"PillsBeta", 1,
			"PillsSleepingTablets", 4,
			"PillsVitamins", 2,
			-- Hygiene
			"Comb", 6,
			"Toothbrush", 10,
			"Toothpaste", 10,
			-- Cosmetic
			"Cologne", 4,
			"HairDyeCommon", 4,
			"Hairgel", 1,
			"Hairspray2", 6,
			"Lipstick", 6,
			"MakeupEyeshadow", 6,
			"MakeupFoundation", 6,
			"Mirror", 8,
			"Perfume", 4,
			"Razor", 4,
			"StraightRazor", 0.1,
			"Tweezers", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"CologneEmpty", 1,
				"DisinfectantEmpty", 1,
				"PerfumeEmpty", 1,
			}
		}
	},
	
	BathroomCounter = {
		rolls = 4,
		items = {
			-- Hygiene
			"Comb", 6,
			"Soap2", 8,
			"ToiletPaper", 20,
			"Toothbrush", 10,
			"Toothpaste", 8,
			-- Linens
			"BathTowel", 20,
			-- Medical
			"AlcoholWipes", 4,
			"Antibiotics", 0.5,
			"Bandage", 2,
			"Bandaid", 8,
			"BookFirstAid1", 1,
			"Disinfectant", 1,
			"FirstAidKit", 0.1,
			"Pills", 4,
			"PillsAntiDep", 1,
			"PillsBeta", 1,
			"PillsSleepingTablets", 4,
			"PillsVitamins", 2,
			-- Literature
			"HottieZ", 1,
			"Magazine_Health", 4,
			"Magazine_Popular", 8,
			"Magazine_Sports", 2,
			"Newspaper", 6,
			"Newspaper_Recent", 8,
			"Paperback", 8,
			"Paperback_Sports", 2,
			-- Cosmetic
			"Cologne", 4,
			"HairDyeCommon", 4,
			"Hairgel", 1,
			"Hairspray2", 6,
			"Lipstick", 6,
			"MakeupEyeshadow", 6,
			"MakeupFoundation", 6,
			"Mirror", 8,
			"Perfume", 4,
			"Razor", 4,
			"StraightRazor", 0.1,
			"Tweezers", 10,
			-- Misc.
			"Bleach", 4,
			"HairDryer", 10,
			"HairIron", 10,
			"Hat_ShowerCap", 4,
			"LongCoat_Bathrobe", 4,
			"PipeWrench", 1,
			"Rubberducky", 4,
			"SewingKit", 4,
		},
		junk = {
			rolls = 1,
			items = {
				-- Empty Bottles
				"BleachEmpty", 1,
				"CologneEmpty", 1,
				"DisinfectantEmpty", 1,
				"PerfumeEmpty", 1,
				-- Vermin
				"DeadMouse", 2,
				"DeadRat", 1,
				-- Toilet
				"ToiletBrush", 20,
				"Plunger", 20,
			}
		}
	},
	
	BathroomCounterEmpty = {
		rolls = 1,
		items = {
			
		},
		junk = {
			rolls = 1,
			items = {
				"DeadMouse", 2,
			}
		}
	},
	
	BathroomCounterMotel = {
		rolls = 1,
		items = {
			-- Hygiene
			"Soap2", 20,
			"ToiletPaper", 20,
			-- Linens
			"BathTowel", 20,
			"BathTowel", 10,
			-- Misc.
			"Hat_ShowerCap", 10,
			"LongCoat_Bathrobe", 20,
			"HairDryer", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"DeadMouse", 2,
			}
		}
	},
	
	-- Old container type. The function used to ensure it spawned is resource-intensive.
	-- Item spread in bathrooms with/without medicine cabinets was too minor to justify.
	-- Keeping it here for save stability. DON'T use it in mods!
	BathroomCounterNoMeds = {
		rolls = 1,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BathroomShelf = {
		rolls = 4,
		items = {
			-- Hygiene
			"Comb", 6,
			"Soap2", 8,
			"ToiletPaper", 10,
			"Toothbrush", 10,
			"Toothpaste", 10,
			-- Cosmetic
			"Cologne", 4,
			"HairDyeCommon", 4,
			"Hairgel", 1,
			"Hairspray2", 6,
			"Lipstick", 6,
			"MakeupEyeshadow", 6,
			"MakeupFoundation", 6,
			"Mirror", 8,
			"Perfume", 4,
			"Razor", 4,
			"StraightRazor", 0.1,
			"Tweezers", 10,
			-- Medicine
			"Antibiotics", 0.5,
			"Bandage", 2,
			"Bandaid", 8,
			"Disinfectant", 1,
			"FirstAidKit", 0.1,
			"Pills", 4,
			"PillsAntiDep", 1,
			"PillsBeta", 1,
			"PillsSleepingTablets", 4,
			"PillsVitamins", 2,
			-- Linens
			"BathTowel", 20,
			"BathTowel", 10,
			-- Literature
			"Book", 2,
			"BookFirstAid1", 1,
			"BookFirstAid2", 0.1,
			"HottieZ", 0.1,
			"Magazine_Health", 8,
			"Magazine_Popular", 8,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperback", 6,
			"TVMagazine", 8,
			-- Misc.
			"Hat_ShowerCap", 4,
			"LongCoat_Bathrobe", 2,
			"Rubberducky", 4,
			"SewingKit", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BBQCharcoal = {
		rolls = 2,
		canBurn = true,
		items = {
			"Chicken", 2,
			"Corn", 4,
			"MeatPatty", 6,
			"PorkChop", 2,
			"Potato", 4,
			"Salmon", 0.5,
			"Sausage", 1,
			"Steak", 1,
			"Shrimp", 0.5,
		},
		junk = {
			rolls = 1,
			canBurn = true,
			items = {
				"BastingBrush", 10,
				"BBQStarterFluid", 1,
				"CarvingFork2", 10,
				"Charcoal", 1,
				"Charcoal", 1,
				"Charcoal", 1,
				"Charcoal", 1,
				"GrillBrush", 10,
				"KitchenTongs", 10,
				"LighterBBQ", 4,
				"Matches", 1,
				"OvenMitt", 10,
				"Spatula", 10,
			}
		}
	},
	
	BBQCharcoalRich = {
		rolls = 4,
		canBurn = true,
		items = {
			"Chicken", 6,
			"Corn", 4,
			"HotdogPack", 1,
			"Lobster", 2,
			"MeatPatty", 1,
			"Mussels", 4,
			"MuttonChop", 6,
			"Oysters", 4,
			"PorkChop", 1,
			"Potato", 4,
			"Salmon", 6,
			"Sausage", 6,
			"Shrimp", 6,
			"Steak", 6,
		},
		junk = {
			rolls = 1,
			canBurn = true,
			items = {
				"BastingBrush", 10,
				"BBQStarterFluid", 1,
				"CarvingFork2", 10,
				"Charcoal", 1,
				"Charcoal", 1,
				"Charcoal", 1,
				"Charcoal", 1,
				"GrillBrush", 10,
				"KitchenTongs", 10,
				"LighterBBQ", 4,
				"Matches", 1,
				"OvenMitt", 10,
				"Spatula", 10,
			}
		}
	},
	
	BBQPropane = {
		rolls = 2,
		canBurn = true,
		items = {
			"Chicken", 2,
			"Corn", 4,
			"MeatPatty", 6,
			"PorkChop", 2,
			"Potato", 4,
			"Salmon", 0.5,
			"Sausage", 1,
			"Steak", 1,
			"Shrimp", 0.5,
		},
		junk = {
			rolls = 1,
			canBurn = true,
			items = {
				"BastingBrush", 10,
				"CarvingFork2", 10,
				"GrillBrush", 10,
				"KitchenTongs", 10,
				"LighterBBQ", 4,
				"OvenMitt", 10,
				"Spatula", 10,
			}
		}
	},
	
	BBQPropaneRich = {
		rolls = 2,
		canBurn = true,
		items = {
			"Chicken", 6,
			"Corn", 4,
			"HotdogPack", 1,
			"Lobster", 2,
			"MeatPatty", 1,
			"Mussels", 4,
			"MuttonChop", 6,
			"Oysters", 4,
			"PorkChop", 1,
			"Potato", 4,
			"Salmon", 6,
			"Sausage", 6,
			"Shrimp", 6,
			"Steak", 6,
		},
		junk = {
			rolls = 1,
			canBurn = true,
			items = {
				"BastingBrush", 10,
				"CarvingFork2", 10,
				"GrillBrush", 10,
				"KitchenTongs", 10,
				"LighterBBQ", 4,
				"OvenMitt", 10,
				"Spatula", 10,
			}
		}
	},
	
	BedroomDresser = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- Shirts/T-Shirts
			"BoobTube", 0.5,
			"BoobTubeSmall", 0.5,
			"Shirt_Baseball_KY", 0.2,
			"Shirt_Baseball_Rangers", 0.2,
			"Shirt_Baseball_Z", 0.2,
			"Shirt_CropTopNoArmTINT", 0.2,
			"Shirt_CropTopTINT", 0.2,
			"Shirt_Denim", 0.5,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 1,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shirt_Lumberjack", 0.5,
			"Shirt_Lumberjack_TINT", 0.5,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_LongSleeve_SuperColor", 0.1,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.1,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
			-- Sweaters
			"HoodieDOWN_WhiteTINT", 2,
			"Jumper_DiamondPatternTINT", 0.2,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			-- Shorts/Pants
			"Shorts_LongDenim", 1,
			"Shorts_ShortDenim", 1,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Shellsuit_Black", 0.05,
			"Trousers_Shellsuit_Blue", 0.05,
			"Trousers_Shellsuit_Green", 0.05,
			"Trousers_Shellsuit_Pink", 0.05,
			"Trousers_Shellsuit_Teal", 0.05,
			"Trousers_Shellsuit_TINT", 0.2,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Trousers_WhiteTINT", 2,
			-- Skirts/Dresses
			"Dress_Knees", 1,
			"Dress_Long", 1,
			"Dress_Normal", 1,
			"Skirt_Knees", 0.2,
			"Skirt_Long", 0.2,
			"Skirt_Normal", 0.2,
			"Skirt_Short", 0.2,
			-- Socks
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Long_Black", 2,
			"Socks_Long_White", 2,
			-- Bras
			"Bra_Strapless_AnimalPrint", 0.8,
			"Bra_Strapless_Black", 1,
			"Bra_Strapless_FrillyBlack", 0.2,
			"Bra_Strapless_FrillyPink", 0.2,
			"Bra_Strapless_RedSpots", 0.8,
			"Bra_Strapless_White", 1,
			"Bra_Straps_AnimalPrint", 0.8,
			"Bra_Straps_Black", 2,
			"Bra_Straps_FrillyBlack", 0.2,
			"Bra_Straps_FrillyPink", 0.2,
			"Bra_Straps_White", 2,
			-- Underwear
			"Boxers_Hearts", 0.8,
			"Boxers_RedStripes", 0.8,
			"Boxers_Silk_Black", 0.2,
			"Boxers_Silk_Red", 0.2,
			"Boxers_White", 2,
			"Briefs_AnimalPrints", 0.8,
			"Briefs_SmallTrunks_Black", 0.1,
			"Briefs_SmallTrunks_Blue", 0.1,
			"Briefs_SmallTrunks_Red", 0.1,
			"Briefs_SmallTrunks_WhiteTINT", 0.1,
			"Briefs_White", 2,
			"Corset", 0.2,
			"Corset_Black", 0.2,
			"FrillyUnderpants_Black", 0.4,
			"FrillyUnderpants_Pink", 0.4,
			"FrillyUnderpants_Red", 0.4,
			"Garter", 0.2,
			"LongJohns", 0.1,
			"LongJohns_Bottoms", 0.1,
			"StockingsBlack", 0.6,
			"StockingsBlackSemiTrans", 0.6,
			"StockingsBlackTrans", 0.6,
			"StockingsWhite", 0.6,
			"TightsBlack", 0.4,
			"TightsBlackSemiTrans", 0.4,
			"TightsBlackTrans", 0.4,
			"TightsFishnets", 0.2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			-- Hats
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.5,
			"Hat_Beret", 0.5,
			"Hat_BucketHat", 0.5,
			"Hat_Fedora", 0.05,
			"Hat_SummerHat", 0.2,
			-- Swimwear
			"Bikini_Pattern01", 0.2,
			"Bikini_TINT", 0.2,
			"Swimsuit_TINT", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			-- Literature (Generic)
			"Book_Fiction", 2,
			"Book_GeneralNonFiction", 2,
			"Brochure", 2,
			"Diary1", 1,
			"Diary2", 1,
			"Flier", 2,
			"GenericMail", 1,
			"Magazine", 6,
			"Magazine_Popular", 6,
			"Paperback_AdventureNonFiction", 4,
			"Paperback_Fiction", 6,
			"Paperback_SadNonFiction", 4,
			-- Linens
			"Pillow", 10,
			"Sheet", 10,
			-- Sports
			"Kneepad_Left_Sport", 1,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortSport", 0.5,
			"Trousers_Sport", 0.2,
			"Tshirt_Sport", 0.2,
			"Tshirt_SportDECAL", 0.2,
			-- Music/Electronics
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"RadioBlack", 0.5,
			"RadioRed", 0.2,
			"Harmonica", 0.02,
			"Headphones", 1,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			-- Misc.
			"Belt2", 4,
			"Cologne", 0.2,
			"Comb", 1,
			"LetterHandwritten", 1,
			"LongCoat_Bathrobe", 0.1,
			"Mirror", 1,
			"Perfume", 0.2,
			"Photo", 4,
			"Photo_Secret", 0.5,
			"Pills", 0.5,
			"PillsSleepingTablets", 1,
			"PillsVitamins", 0.1,
			"SewingKit", 0.5,
			"Tissue", 10,
			"TissueBox", 4,
			-- Guns
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"Pistol", 0.5,
			"Pistol2", 0.1,
			"Pistol3", 0.05,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"Revolver", 0.1,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			-- Special
			"Flask", 0.1,
			"HollowBook", 0.1,
			"JewelleryBox", 0.1,
			"Medal_Bronze", 0.005,
			"Medal_Gold", 0.001,
			"Medal_Silver", 0.002,
			"MilitaryMedal", 0.01,
			"SmokingPipe", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},
	
	BedroomDresserChild = {
		rolls = 4,
		items = {
			"Bag_FluteCase", 0.02,
			"Book_Childs", 2,
			"Book_Fantasy", 2,
			"Book_Fiction", 2,
			"Book_SciFi", 2,
			"BorisBadger", 0.0005,
			"Boxers_White", 2,
			"Bracelet_LeftFriendshipTINT", 1,
			"Bricktoys", 8,
			"Briefs_White", 4,
			"CanteenCowboyEmpty", 0.1,
			"CardDeck", 2,
			"CDplayer", 1,
			"CheckerBoard", 2,
			"ChessBlack", 2,
			"ChessWhite", 2,
			"ChildsPictureBook", 4,
			"Comb", 1,
			"ComicBook_Retail", 10,
			"Crayons", 10,
			"Cube", 4,
			"Diary1", 10,
			"Dice", 8,
			"Dice_00", 1,
			"Dice_10", 1,
			"Dice_12", 1,
			"Dice_20", 1,
			"Dice_4", 1,
			"Dice_6", 1,
			"Dice_8", 1,
			"DiceBag", 1,
			"Disc_Retail", 2,
			"Doll", 6,
			"Earbuds", 1,
			"ElbowPad_Left_Sport", 0.05,
			"ElbowPad_Left_TINT", 0.1,
			"ElectronicsMag5", 0.01,
			"EngineerMagazine1", 0.01,
			"Firecracker", 1,
			"FluffyfootBunny", 0.0005,
			"Flute", 0.02,
			"FreddyFox", 0.0005,
			"Frog", 0.001,
			"FurbertSquirrel", 0.0005,
			"GamePieceBlack", 2,
			"GamePieceRed", 2,
			"GamePieceWhite", 2,
			"HalloweenCandyBucket", 0.001,
			"Harmonica", 0.02,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 1,
			"Hat_BucketHat", 1,
			"Hat_HalloweenMaskDevil", 0.01,
			"Hat_HalloweenMaskMonster", 0.01,
			"Hat_HalloweenMaskPumpkin", 0.01,
			"Hat_HalloweenMaskSkeleton", 0.01,
			"Hat_HalloweenMaskVampire", 0.01,
			"Hat_HalloweenMaskWitch", 0.01,
			"Hat_Pirate", 0.05,
			"Hat_Wizard", 0.05,
			"Headphones", 1,
			"HollowBook_Kids", 0.001,
			"HoodieDOWN_WhiteTINT", 4,
			"JacquesBeaver", 0.0005,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"Kneepad_Left_Sport", 2,
			"Kneepad_Left_TINT", 4,
			"Magazine_Childs", 10,
			"Magazine_Gaming", 4,
			"Magazine_Humor", 4,
			"Magazine_Teens", 4,
			"Mirror", 1,
			"MoleyMole", 0.0005,
			"PancakeHedgehog", 0.0005,
			"PanchoDog", 0.0005,
			"Paperback_Childs", 6,
			"Paperback_Fantasy", 4,
			"Paperback_Fiction", 4,
			"Paperback_SciFi", 4,
			"PencilCase", 2,
			"Pillow", 10,
			"Pillow_Happyface", 0.5,
			"Pillow_Star", 0.5,
			"Plushabug", 0.0005,
			"PokerChips", 0.0005,
			"RadioBlack", 0.5,
			"RadioRed", 0.2,
			"RubberSpider", 1,
			"RPGmanual", 1,
			"SewingKit", 0.5,
			"Sheet", 10,
			"Shirt_Baseball_KY", 1,
			"Shirt_Baseball_Rangers", 1,
			"Shirt_Baseball_Z", 1,
			"Shirt_CropTopNoArmTINT", 1,
			"Shirt_CropTopTINT", 1,
			"Shoes_FlipFlop", 0.5,
			"Shoes_Sandals", 0.5,
			"Shoes_Slippers", 0.2,
			"Shoes_TrainerTINT", 1,
			"Shorts_LongDenim", 1,
			"Shorts_LongSport", 2,
			"Shorts_ShortDenim", 1,
			"Shorts_ShortSport", 2,
			"Skirt_Knees", 0.2,
			"Skirt_Long", 0.2,
			"Skirt_Normal", 0.2,
			"Skirt_Short", 0.2,
			"Socks_Ankle", 4,
			"Socks_Ankle_Black", 1,
			"Socks_Ankle_White", 2,
			"Socks_Long", 4,
			"Socks_Long_Black", 1,
			"Socks_Long_White", 2,
			"Spiffo", 0.0005,
			"SpiffoBig", 0.00005,
			"Swimsuit_TINT", 0.2,
			"Swimsuit_TINT", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"Tissue", 10,
			"TissueBox", 4,
			"ToyBadge", 1,
			"ToyBear", 6,
			"ToyCar", 6,
			"TrickMag1", 0.001,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Shellsuit_Black", 0.05,
			"Trousers_Shellsuit_Blue", 0.05,
			"Trousers_Shellsuit_Green", 0.05,
			"Trousers_Shellsuit_Pink", 0.05,
			"Trousers_Shellsuit_Teal", 0.05,
			"Trousers_Shellsuit_TINT", 0.2,
			"Trousers_Sport", 1,
			"Trousers_WhiteTINT", 2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_LongSleeve_SuperColor", 0.1,
			"Tshirt_PoloStripedTINT", 0.1,
			"Tshirt_PoloTINT", 0.1,
			"Tshirt_Sport", 1,
			"Tshirt_SportDECAL", 1,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.5,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
			"VideoGame", 2,
			"WalkieTalkie1", 1,
			"Whistle", 2,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			"Yoyo", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BedroomDresserClassy = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_WestMaple", 0.1,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- TODO: Sort Me!
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"Belt2", 4,
			"Bikini_Pattern01", 0.2,
			"Bikini_TINT", 0.2,
			"Book_Business", 1,
			"Book_ClassicFiction", 2,
			"Book_GeneralNonFiction", 2,
			"Book_Legal", 1,
			"Book_LiteraryFiction", 2,
			"Book_Rich", 4,
			"Boxers_Hearts", 0.2,
			"Boxers_RedStripes", 0.2,
			"Boxers_Silk_Black", 0.8,
			"Boxers_Silk_Red", 0.8,
			"Boxers_White", 2,
			"Bra_Strapless_AnimalPrint", 0.8,
			"Bra_Strapless_Black", 1,
			"Bra_Strapless_FrillyBlack", 0.2,
			"Bra_Strapless_FrillyPink", 0.2,
			"Bra_Strapless_RedSpots", 0.8,
			"Bra_Strapless_White", 1,
			"Bra_Straps_AnimalPrint", 0.8,
			"Bra_Straps_Black", 2,
			"Bra_Straps_FrillyBlack", 0.2,
			"Bra_Straps_FrillyPink", 0.2,
			"Bra_Straps_White", 2,
			"Briefs_AnimalPrints", 0.4,
			"Briefs_SmallTrunks_Black", 0.5,
			"Briefs_SmallTrunks_Blue", 0.5,
			"Briefs_SmallTrunks_Red", 0.5,
			"Briefs_SmallTrunks_WhiteTINT", 0.5,
			"Briefs_White", 2,
			"Brochure", 2,
			"CameraExpensive", 10,
			"CameraFilm", 10,
			"CDplayer", 1,
			"Champagne", 0.1,
			"Cologne", 0.4,
			"Comb", 1,
			"CordlessPhone", 10,
			"Corset", 0.2,
			"Corset_Black", 0.2,
			"Diary1", 1,
			"Diary2", 4,
			"Disc_Retail", 2,
			"Dress_Knees", 1,
			"Dress_Long", 1,
			"Dress_Normal", 1,
			"Earbuds", 1,
			"Flask", 0.1,
			"Flier", 2,
			"FrillyUnderpants_Black", 0.4,
			"FrillyUnderpants_Pink", 0.4,
			"FrillyUnderpants_Red", 0.4,
			"Garter", 0.8,
			"GemBag", 0.001,
			"GenericMail", 1,
			"Goblet", 0.001,
			"Harmonica", 0.02,
			"Hat_Beret", 1,
			"Hat_Fedora", 0.1,
			"Hat_Fedora_Delmonte", 0.05,
			"Hat_GolfHatTINT", 1,
			"Hat_SummerHat", 1,
			"Headphones", 1,
			"HollowBook_Valuables", 0.001,
			"HoodieDOWN_WhiteTINT", 1,
			"JewelleryBox_Fancy", 0.1,
			"Jumper_DiamondPatternTINT", 0.4,
			"Jumper_PoloNeck", 1,
			"Jumper_RoundNeck", 1,
			"Jumper_TankTopTINT", 1,
			"Jumper_VNeck", 1,
			"Kneepad_Left_Sport", 1,
			"LetterHandwritten", 1,
			"LongCoat_Bathrobe", 2,
			"LongJohns", 0.05,
			"LongJohns_Bottoms", 0.05,
			"Magazine", 4,
			"Magazine_Business", 4,
			"Magazine_Rich", 8,
			"MakeupCase_Professional", 0.1,
			"Medal_Bronze", 0.01,
			"Medal_Silver", 0.005,
			"Medal_Gold", 0.002,
			"MilitaryMedal", 0.001,
			"Mirror", 1,
			"Paperback_Business", 2,
			"Paperback_ClassicFiction", 6,
			"Paperback_Legal", 2,
			"Paperback_LiteraryFiction", 6,
			"Paperback_Rich", 8,
			"Perfume", 0.4,
			"Photo", 4,
			"Photo_Secret", 0.5,
			"Pillow", 10,
			"Pills", 0.5,
			"PillsSleepingTablets", 1,
			"PillsVitamins", 0.1,
			"Pistol", 0.5,
			"Pistol2", 0.1,
			"Pistol3", 0.05,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"RadioBlack", 0.5,
			"RadioRed", 0.2,
			"Revolver", 0.1,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			"SewingKit", 0.5,
			"Sheet", 10,
			"Shirt_FormalTINT", 4,
			"Shirt_FormalWhite", 4,
			"Shoes_Slippers", 0.2,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortSport", 0.5,
			"Skirt_Knees", 0.4,
			"Skirt_Long", 0.4,
			"Skirt_Normal", 0.2,
			"Skirt_Short", 0.2,
			"SmokingPipe", 0.01,
			"Socks_Ankle", 1,
			"Socks_Ankle_Black", 4,
			"Socks_Ankle_White", 2,
			"Socks_Long", 1,
			"Socks_Long_Black", 4,
			"Socks_Long_White", 2,
			"StockCertificate", 10,
			"StockingsBlack", 0.6,
			"StockingsBlackSemiTrans", 0.6,
			"StockingsBlackTrans", 0.6,
			"StockingsWhite", 0.6,
			"Suit_Jacket", 4,
			"Suit_JacketTINT", 4,
			"Swimsuit_TINT", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"Tie_BowTieFull", 1,
			"Tie_BowTieWorn", 1,
			"Tie_Full", 2,
			"Tie_Worn", 2,
			"TightsBlack", 0.4,
			"TightsBlackSemiTrans", 0.4,
			"TightsBlackTrans", 0.4,
			"Tissue", 10,
			"TissueBox", 4,
			"Trousers_Sport", 0.5,
			"Trousers_Suit", 4,
			"Trousers_SuitTEXTURE", 4,
			"Trousers_WhiteTINT", 2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_PoloStripedTINT", 4,
			"Tshirt_PoloTINT", 4,
			"Tshirt_Sport", 0.5,
			"Tshirt_SportDECAL", 0.5,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE", 4,
			"WristWatch_Left_Expensive", 0.01,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},
	
	BedroomDresserRedneck = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.005,
			"KeyRing_EagleFlag", 0.005,
			"KeyRing_EightBall", 0.005,
			"KeyRing_Panther", 0.005,
			"KeyRing_PineTree", 0.005,
			"KeyRing_PrayingHands", 0.005,
			"KeyRing_Sexy", 0.005,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- TODO: Sort Me!
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"Belt2", 4,
			"Bikini_Pattern01", 0.2,
			"Bikini_TINT", 0.2,
			"BoobTube", 1,
			"BoobTubeSmall", 1,
			"Boxers_Hearts", 0.8,
			"Boxers_RedStripes", 0.8,
			"Boxers_White", 2,
			"Bra_Strapless_AnimalPrint", 0.4,
			"Bra_Strapless_Black", 0.4,
			"Bra_Strapless_FrillyBlack", 0.1,
			"Bra_Strapless_FrillyPink", 0.1,
			"Bra_Strapless_RedSpots", 0.4,
			"Bra_Strapless_White", 0.4,
			"Bra_Straps_AnimalPrint", 0.4,
			"Bra_Straps_Black", 1,
			"Bra_Straps_FrillyBlack", 0.1,
			"Bra_Straps_FrillyPink", 0.1,
			"Bra_Straps_White", 1,
			"Briefs_AnimalPrints", 0.2,
			"Briefs_White", 2,
			"Brochure", 2,
			"CanteenMilitaryEmpty", 0.1,
			"CDplayer", 1,
			"Cologne", 0.1,
			"Comb", 1,
			"Diary1", 1,
			"Diary2", 1,
			"Disc_Retail", 2,
			"Dungarees", 0.5,
			"Earbuds", 1,
			"Firecracker", 0.01,
			"Flier", 2,
			"FrillyUnderpants_Black", 0.2,
			"FrillyUnderpants_Pink", 0.2,
			"FrillyUnderpants_Red", 0.2,
			"GenericMail", 1,
			"Handiknife", 0.5,
			"Harmonica", 0.02,
			"Hat_Bandana", 0.2,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapArmy", 0.1,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.5,
			"Hat_BucketHat", 0.5,
			"Hat_StrawHat", 0.5,
			"Hat_SummerHat", 0.1,
			"Headphones", 1,
			"HempMag1", 0.05,
			"HollowBook_Handgun", 0.001,
			"HollowBook_Whiskey", 0.001,
			"HoodieDOWN_WhiteTINT", 2,
			"Kneepad_Left_Sport", 1,
			"KnifeButterfly", 1,
			"KnifePocket", 0.5,
			"LargeKnife", 0.1,
			"LetterHandwritten", 1,
			"LongCoat_Bathrobe", 0.1,
			"LongJohns", 0.5,
			"LongJohns_Bottoms", 0.5,
			"Magazine", 4,
			"Magazine_Car", 6,
			"Magazine_Firearm", 4,
			"Magazine_Military", 2,
			"Magazine_Outdoors", 6,
			"Magazine_Sports", 6,
			"MilitaryMedal", 0.005,
			"Mirror", 1,
			"Multitool", 0.05,
			"Paperback_Poor", 8,
			"Perfume", 0.1,
			"Photo", 4,
			"Photo_Secret", 0.5,
			"Pillow", 10,
			"Pills", 0.5,
			"PillsSleepingTablets", 1,
			"PillsVitamins", 0.1,
			"Pistol", 0.5,
			"Pistol2", 0.1,
			"Pistol3", 0.05,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"RadioBlack", 0.5,
			"RadioRed", 0.2,
			"Revolver", 0.1,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			"SewingKit", 0.5,
			"Sheet", 10,
			"Shirt_CamoDesert", 0.5,
			"Shirt_CamoGreen", 1,
			"Shirt_CamoUrban", 0.2,
			"Shirt_CropTopNoArmTINT", 1,
			"Shirt_CropTopTINT", 1,
			"Shirt_Denim", 1,
			"Shirt_HawaiianRed", 0.1,
			"Shirt_HawaiianTINT", 0.1,
			"Shirt_Lumberjack", 1,
			"Shirt_Lumberjack_TINT", 1,
			"Shoes_Slippers", 0.2,
			"Shorts_CamoGreenLong", 1,
			"Shorts_CamoUrbanLong", 0.5,
			"Shorts_LongDenim", 2,
			"Shorts_ShortDenim", 2,
			"SmokingPipe", 0.01,
			"Socks_Ankle", 1,
			"Socks_Ankle_Black", 1,
			"Socks_Ankle_White", 4,
			"Socks_Heavy", 2,
			"Socks_Long", 1,
			"Socks_Long_Black", 1,
			"Socks_Long_White", 4,
			"StockingsBlack", 0.6,
			"StockingsBlackSemiTrans", 0.6,
			"StockingsBlackTrans", 0.6,
			"StockingsWhite", 0.6,
			"Swimsuit_TINT", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"SwitchKnife", 0.5,
			"TightsBlack", 0.2,
			"TightsBlackSemiTrans", 0.2,
			"TightsBlackTrans", 0.2,
			"TightsFishnets", 0.4,
			"Tissue", 10,
			"TissueBox", 4,
			"TrousersMesh_DenimLight", 2,
			"Trousers_CamoDesert", 0.5,
			"Trousers_CamoGreen", 1,
			"Trousers_CamoUrban", 0.2,
			"Trousers_DefaultTEXTURE", 1,
			"Trousers_DefaultTEXTURE_TINT", 1,
			"Trousers_Denim", 2,
			"Trousers_JeanBaggy", 2,
			"Trousers_WhiteTINT", 1,
			"Tshirt_ArmyGreen", 1,
			"Tshirt_CamoDesert", 0.5,
			"Tshirt_CamoGreen", 1,
			"Tshirt_CamoUrban", 0.2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_LongSleeve_SuperColor", 0.1,
			"Tshirt_Rock", 1,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.1,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Vest_Trucker", 0.1,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicMilitary", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
				"Necklace_DogTag", 1,
			}
		}
	},
	
	BedroomSidetable = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- TODO: Sort Me!
			"AlarmClock2", 10,
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"BluePen", 8,
			"Book_Fiction", 2,
			"Book_GeneralNonFiction", 2,
			"Calculator", 0.1,
			"Catalog", 8,
			"CDplayer", 1,
			"Cigar", 0.1,
			"CigarBox", 0.05,
			"CigarBox_Keepsakes", 0.001,
			"CigaretteRollingPapers", 0.1,
			"CigarettePack", 1,
			"Comb", 1,
			"CordlessPhone", 1,
			"Diary1", 1,
			"Diary2", 1,
			"Disc_Retail", 2,
			"Doodle", 1,
			"Earbuds", 1,
			"GenericMail", 1,
			"Glasses_Aviators", 0.5,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.05,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Reading", 1,
			"Glasses_Sun", 1,
			"GreenPen", 4,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Headphones", 1,
			"HollowBook", 0.001,
			"HottieZ", 0.1,
			"HotWaterBottleEmpty", 2,
			"KnifePocket", 0.1,
			"LetterHandwritten", 1,
			"Lighter", 1,
			"LighterDisposable", 3,
			"Magazine", 6,
			"Magazine_Popular", 6,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"Matches", 8,
			"Medal_Bronze", 0.005,
			"Medal_Silver", 0.002,
			"Medal_Gold", 0.001,
			"MilitaryMedal", 0.001,
			"Mirror", 1,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Note", 1,
			"Notebook", 4,
			"Paperback_Fiction", 6,
			"Paperback_AdventureNonFiction", 4,
			"Paperback_SadNonFiction", 4,
			"Pen", 8,
			"Pencil", 10,
			"PenFancy", 0.5,
			"Photo", 4,
			"Photo_Secret", 0.5,
			"Pills", 0.5,
			"PillsSleepingTablets", 2,
			"PillsVitamins", 0.1,
			"Pistol", 0.05,
			"Pistol2", 0.01,
			"Pistol3", 0.005,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"Pocketwatch", 0.5,
			"Postcard", 4,
			"RedPen", 8,
			"Revolver", 0.01,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			"SewingKit", 0.5,
			"SheetPaper2", 10,
			"SmokingPipe", 0.01,
			"Tissue", 10,
			"TissueBox", 4,
			"TobaccoChewing", 0.1,
			"TobaccoLoose", 0.1,
			"TVMagazine", 8,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},
	
	BedroomSidetableChild = {
		rolls = 4,
		items = {
			"AlarmClock2", 10,
			"BluePen", 8,
			"Book_Childs", 2,
			"Book_Fantasy", 2,
			"Book_Fiction", 2,
			"Book_SciFi", 2,
			"BorisBadger", 0.001,
			"Bracelet_LeftFriendshipTINT", 1,
			"Bricktoys", 8,
			"Calculator", 0.1,
			"CanteenCowboyEmpty", 0.1,
			"CardDeck", 2,
			"CDplayer", 1,
			"CheckerBoard", 2,
			"ChessBlack", 2,
			"ChessWhite", 2,
			"ChildsPictureBook", 4,
			"Comb", 1,
			"ComicBook_Retail", 10,
			"CookieJar_Bear", 0.001,
			"CordlessPhone", 1,
			"Crayons", 10,
			"Crystal", 0.4,
			"Cube", 4,
			"Diary1", 4,
			"Dice", 8,
			"DiceBag", 1,
			"Dice_00", 1,
			"Dice_10", 1,
			"Dice_12", 1,
			"Dice_20", 1,
			"Dice_4", 1,
			"Dice_6", 1,
			"Dice_8", 1,
			"Disc_Retail", 2,
			"Doll", 6,
			"DoodleKids", 8,
			"Earbuds", 1,
			"ElectronicsMag5", 0.01,
			"EngineerMagazine1", 0.01,
			"Firecracker", 1,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"Frog", 0.001,
			"FurbertSquirrel", 0.001,
			"GamePieceBlack", 2,
			"GamePieceRed", 2,
			"GamePieceWhite", 2,
			"Glasses_3dGlasses", 1,
			"Glasses_Groucho", 1,
			"Glasses_Novelty_Xray", 1,
			"GreenPen", 4,
			"HalloweenCandyBucket", 0.001,
			"Harmonica", 0.02,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 1,
			"Hat_BucketHat", 1,
			"Hat_HalloweenMaskDevil", 0.01,
			"Hat_HalloweenMaskMonster", 0.01,
			"Hat_HalloweenMaskPumpkin", 0.01,
			"Hat_HalloweenMaskSkeleton", 0.01,
			"Hat_HalloweenMaskVampire", 0.01,
			"Hat_HalloweenMaskWitch", 0.01,
			"Hat_Pirate", 0.05,
			"Hat_Wizard", 0.05,
			"Headphones", 1,
			"HollowBook_Kids", 0.001,
			"JacquesBeaver", 0.001,
			"KnifePocket", 0.005,
			"LighterDisposable", 0.01, -- little troublemaker over here
			"MagazineWordsearch", 2,
			"Magazine_Childs", 10,
			"Magazine_Humor", 4,
			"Magazine_Teens", 4,
			"Mirror", 1,
			"MoleyMole", 0.0005,
			"Note", 1,
			"Notebook", 4,
			"OujaBoard", 0.1,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"Paperback_Childs", 6,
			"Paperback_Fantasy", 4,
			"Paperback_Fiction", 4,
			"Paperback_SciFi", 4,
			"Pen", 8,
			"Pencil", 10,
			"PencilCase", 2,
			"PencilSpiffo", 0.005,
			"PenMultiColor", 2,
			"PenSpiffo", 0.005,
			"Plushabug", 0.001,
			"PokerChips", 2,
			"RedPen", 8,
			"RPGmanual", 1,
			"RubberSpider", 1,
			"SewingKit", 0.5,
			"SheetPaper2", 10,
			"Specimen_Beetles", 0.1,
			"Specimen_Butterflies", 0.1,
			"Specimen_Centipedes", 0.1,
			"Specimen_Insects", 0.1,
			"Specimen_Minerals", 0.4,
			"Spiffo", 0.001,
			"SpiffoBig", 0.001,
			"TarotCardDeck", 0.1,
			"Tissue", 10,
			"TissueBox", 4,
			"ToyBadge", 1,
			"ToyBear", 6,
			"ToyCar", 6,
			"TrickMag1", 0.001,
			"VideoGame", 2,
			"WalkieTalkie1", 1,
			"Whistle", 2,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			"Yoyo", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},
	
	BedroomSidetableClassy = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_WestMaple", 0.1,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- TODO: Sort Me!
			"AlarmClock2", 10,
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"BluePen", 8,
			"Book_Business", 2,
			"Book_Legal", 2,
			"Book_Rich", 4,
			"Calculator", 0.1,
			"CameraExpensive", 10,
			"CameraFilm", 10,
			"CDplayer", 1,
			"Cigar", 0.5,
			"CigaretteRollingPapers", 0.1,
			"CigarettePack", 1,
			"Cigarillo", 2,
			"Comb", 1,
			"CordlessPhone", 10,
			"Diary1", 1,
			"Diary2", 4,
			"Disc_Retail", 2,
			"Doodle", 1,
			"Earbuds", 1,
			"Flask", 0.1,
			"Garter", 0.8,
			"GemBag", 0.001,
			"GenericMail", 1,
			"Glasses_Aviators", 0.5,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.05,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Reading", 1,
			"Glasses_Sun", 1,
			"Goblet", 0.001,
			"GreenPen", 4,
			"Hat_Beret", 1,
			"Hat_Fedora", 0.1,
			"Hat_Fedora_Delmonte", 0.05,
			"Hat_GolfHatTINT", 1,
			"Hat_PeakedCapYacht", 0.1,
			"Hat_SummerHat", 1,
			"Headphones", 1,
			"HollowBook_Valuables", 0.001,
			"HottieZ", 0.1,
			"HotWaterBottleEmpty", 2,
			"Humidor", 0.05,
			"IDcard_Blank", 0.0001,
			"KnifePocket", 0.1,
			"LetterHandwritten", 1,
			"Lighter", 1,
			"LighterDisposable", 3,
			"Magazine", 4,
			"Magazine_Business", 4,
			"Magazine_Rich", 8,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MakeupCase_Professional", 0.1,
			"Matches", 8,
			"Medal_Bronze", 0.01,
			"Medal_Silver", 0.005,
			"Medal_Gold", 0.002,
			"MilitaryMedal", 0.001,
			"Mirror", 1,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Note", 1,
			"Notebook", 4,
			"Paperback_Business", 4,
			"Paperback_Legal", 4,
			"Paperback_Rich", 8,
			"Passport", 0.01,
			"Pen", 8,
			"Pencil", 10,
			"PenFancy", 4,
			"Photo", 4,
			"Photo_Secret", 0.5,
			"Pills", 0.5,
			"PillsSleepingTablets", 2,
			"PillsVitamins", 0.1,
			"Pistol", 0.05,
			"Pistol2", 0.01,
			"Pistol3", 0.005,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"Pocketwatch", 0.5,
			"Postcard", 4,
			"RedPen", 8,
			"Revolver", 0.01,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			"SewingKit", 0.5,
			"SheetPaper2", 10,
			"SmokingPipe", 0.01,
			"StockCertificate", 10,
			"Tie_BowTieFull", 1,
			"Tie_BowTieWorn", 1,
			"Tie_Full", 2,
			"Tie_Worn", 2,
			"Tissue", 10,
			"TissueBox", 4,
			"TobaccoChewing", 0.1,
			"TobaccoLoose", 0.1,
			"TVMagazine", 8,
			"WristWatch_Left_Expensive", 0.01,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},
	
	BedroomSidetableRedneck = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.005,
			"KeyRing_EagleFlag", 0.005,
			"KeyRing_EightBall", 0.005,
			"KeyRing_Clover", 0.005,
			"KeyRing_Panther", 0.005,
			"KeyRing_PineTree", 0.005,
			"KeyRing_PrayingHands", 0.005,
			"KeyRing_RabbitFoot", 0.1,
			"KeyRing_Sexy", 0.005,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- TODO: Sort Me!
			"AlarmClock2", 10,
			"ArmorMag3", 0.001,
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"BluePen", 8,
			"Calculator", 0.1,
			"CanteenMilitaryEmpty", 0.1,
			"CDplayer", 1,
			"Cigar", 0.1,
			"CigarBox", 0.05,
			"CigaretteRollingPapers", 0.1,
			"CigarettePack", 1,
			"Cigarillo", 4,
			"Comb", 1,
			"CordlessPhone", 1,
			"Diary1", 1,
			"Diary2", 1,
			"Disc_Retail", 2,
			"Doodle", 1,
			"Earbuds", 1,
			"Firecracker", 0.01,
			"GenericMail", 1,
			"Glasses_Aviators", 0.5,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.05,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Reading", 1,
			"Glasses_Sun", 1,
			"GreenPen", 4,
			"Handiknife", 0.5,
			"Hat_Bandana", 0.2,
			"Hat_BaseballCapArmy", 0.1,
			"Hat_BaseballCapTINT", 0.1,
			"Headphones", 1,
			"HempMag1", 0.05,
			"HollowBook_Handgun", 0.001,
			"HollowBook_Whiskey", 0.001,
			"HottieZ", 0.1,
			"HotWaterBottleEmpty", 1,
			"KnifeButterfly", 1,
			"KnifePocket", 0.5,
			"LargeKnife", 0.1,
			"LetterHandwritten", 1,
			"Lighter", 1,
			"LighterDisposable", 3,
			"Magazine", 4,
			"Magazine_Car", 4,
			"Magazine_Outdoors", 4,
			"Magazine_Sports", 4,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"Matches", 8,
			"MilitaryMedal", 0.005,
			"Mirror", 1,
			"Multitool", 0.05,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Note", 1,
			"Notebook", 4,
			"Paperback_Poor", 4,
			"Pen", 8,
			"Pencil", 10,
			"PenFancy", 0.5,
			"Photo", 4,
			"Photo_Secret", 0.5,
			"Pills", 0.5,
			"PillsSleepingTablets", 2,
			"PillsVitamins", 0.1,
			"Pistol", 0.05,
			"Pistol2", 0.01,
			"Pistol3", 0.005,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"Pocketwatch", 0.5,
			"Postcard", 4,
			"RedPen", 8,
			"Revolver", 0.01,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			"SewingKit", 0.5,
			"SheetPaper2", 10,
			"SmokingPipe", 0.01,
			"Tissue", 10,
			"TissueBox", 4,
			"TobaccoChewing", 0.1,
			"TobaccoLoose", 0.1,
			"TVMagazine", 8,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicMilitary", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
				"Necklace_DogTag", 1,
			}
		}
	},
	
	-- Beer taps don't work at the moment so have some extra beer.
	-- This contailer will be more cup-focused later.
	BeerGardenCounter = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BeerBottle", 20,
			"BeerBottle", 10,
			"BeerPack", 0.1,
			"BeerCan", 20,
			"BeerCan", 10,
			"BeerCanPack", 0.1,
			"BeerImported", 4,
			-- Misc.
			"BottleOpener", 4,
			"PaperNapkins2", 50,
			"PaperNapkins2", 20,
			"PlasticCup", 50,
			"PlasticCup", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"DishCloth", 10,
				"Receipt", 50,
				"Receipt", 20,
			}
		}
	},
	
	-- Items found in garbage bins tend to be in very poor condition.
	BinBar = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Beer/Cider
			"BeerImportedEmpty", 4,
			"BeerBottleEmpty", 20,
			"BeerBottleEmpty", 10,
			"BeerCanEmpty", 20,
			"BeerCanEmpty", 10,
			"CiderEmpty", 1,
			-- Liquor
			"BrandyEmpty", 1,
			"GinEmpty", 1,
			"RumEmpty", 1,
			"ScotchEmpty", 1,
			"TequilaEmpty", 1,
			"VodkaEmpty", 1,
			"WhiskeyEmpty", 1,
			-- Wine
			"PortEmpty", 1,
			"SherryEmpty", 1,
			"VermouthEmpty", 1,
			"Wine2OpenEmpty", 2,
			"WineAgedEmpty", 0.1,
			"WineOpenEmpty", 2,
			-- Mix
			"CoffeeLiquerEmpty", 1,
			"CuracaoEmpty", 1,
			"GrenadineEmpty", 1,
			"JuiceCranberryEmpty", 1,
			"JuiceLemonEmpty", 1,
			"JuiceOrangeEmpty", 1,
			"JuiceTomatoEmpty", 1,
			"PopBottleEmpty", 4,
			"SimpleSyrupEmpty", 1,
			"WaterBottleEmpty", 4,
			-- Food
			"Olives", 1,
			"Peanuts", 1,
			"Pickles", 1,
			"PorkRinds", 1,
			"Pretzel", 1,
			"TortillaChipsBaked", 1,
			-- Trash
			"BrokenGlass", 4,
			"Cockroach", 8,
			"CocktailUmbrella", 50,
			"CocktailUmbrella", 20,
			"PaperNapkins2", 50,
			"PaperNapkins2", 20,
			"Receipt", 50,
			"Receipt", 20,
			"RippedSheetsDirty", 4,
			"ScratchTicket_Loser", 20,
			"ScratchTicket_Loser", 10,
			"SmashedBottle", 4,
		},
		junk = ClutterTables.BinJunk,
	},
	
	-- Residential bathroom bins.
	BinBathroom = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Cosmetics
			"Comb", 1,
			"Hairgel", 1,
			"Hairspray2", 1,
			"Lipstick", 1,
			"MakeupEyeshadow", 1,
			"MakeupFoundation", 1,
			"Razor", 1,
			"StraightRazor", 0.01,
			"Toothbrush", 1,
			"Toothpaste", 1,
			-- Waste
			"BandageDirty", 8,
			"CottonBalls", 1,
			"PaperNapkins2", 4,
			"RippedSheetsDirty", 1,
			"Tissue", 8,
			"ToiletPaper", 1,
			-- Empties
			"BleachEmpty", 1,
			"CologneEmpty", 4,
			"DisinfectantEmpty", 1,
			"PerfumeEmpty", 4,
			-- Trash
			"Cockroach", 0.5,
			"DeadMouse", 0.1,
			"DeadRat", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	-- These generally work for both dining and kitchen areas in restaurants.
	BinCrepe = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Food
			"Biscuit", 8,
			"EggOmelette", 8,
			"EggScrambled", 8,
			"Pancakes", 20,
			"Pancakes", 10,
			"Pie", 4,
			"PotatoPancakes", 4,
			"Toast", 8,
			"Waffles", 20,
			"Waffles", 10,
			-- Trash
			"BrokenGlass", 0.4,
			"Cockroach", 8,
			"DeadMouse", 2,
			"DeadRat", 1,
			"FountainCup", 50,
			"FountainCup", 20,
			"MenuCard", 10,
			"PaperNapkins2", 50,
			"PaperNapkins2", 20,
			"Receipt", 50,
			"Receipt", 20,
			"Straw2", 50,
			"Straw2", 20,
		},
		junk = ClutterTables.BinJunk,
	},
	
	-- Larger version of BinGeneric, found below.
	BinDumpster = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Trash Bags
			"Bag_TrashBag", 20,
			"Bag_TrashBag", 20,
			"Bag_TrashBag", 10,
			"Bag_TrashBag", 10,
			-- Empties
			"BeerBottleEmpty", 2,
			"BeerCanEmpty", 8,
			"BeerImportedEmpty", 0.5,
			"BrandyEmpty", 0.1,
			"EmptyJar", 0.5,
			"GinEmpty", 0.1,
			"PaintbucketEmpty", 1,
			"Pop2Empty", 8,
			"Pop3Empty", 8,
			"PopBottleEmpty", 1,
			"PopBottleRareEmpty", 0.1,
			"PopEmpty", 8,
			"RumEmpty", 0.5,
			"ScotchEmpty", 0.1,
			"TequilaEmpty", 0.5,
			"VodkaEmpty", 0.5,
			"WaterBottleEmpty", 1,
			"WhiskeyEmpty", 0.5,
			"Wine2OpenEmpty", 0.1,
			"WineOpenEmpty", 0.1,
			-- Scrap
			"AnimalBone", 2,
			"BandageDirty", 2,
			"BaseballBat_Broken", 1,
			"BrokenGlass", 0.4,
			"CopperScrap", 1,
			"ElectronicsScrap", 2,
			"GardenToolHandle_Broken", 1,
			"JarLid", 0.5,
			"LargeAnimalBone", 1,
			"LongHandle_Broken", 1,
			"LongStick_Broken", 1,
			"MetalPipe_Broken", 1,
			"Mov_PalletEmpty", 4,
			"RippedSheetsDirty", 4,
			"ScrapMetal", 2,
			"SharpBone_Long", 1,
			"SharpBoneFragment", 1,
			"SmallAnimalBone", 4,
			"SmashedBottle", 1,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			-- Trash
			"Brochure", 1,
			"Cockroach", 8,
			"DeadMouse", 2,
			"DeadRat", 1,
			"Dung_Rat", 0.5,
			"Flier", 1,
			"FountainCup", 4,
			"PaperNapkins2", 4,
			"PlasticCup", 4,
			"Receipt", 10,
			"ScratchTicket_Loser", 4,
			"Splinters", 8,
			"Straw2", 8,
			"UnusableMetal", 2,
			"UnusableWood", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"CorpseMale", 0.01,
				"CorpseFemale", 0.01,
			}
		}
	},
	
	BinFireStation = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Trash Bags
			"Bag_TrashBag", 20,
			-- Empties
			"BeerBottleEmpty", 4,
			"BeerCanEmpty", 10,
			-- Discarded/Broken Tools
			"Axe", 10,
			"FireAxeHead", 20,
			-- Scrap
			"BandageDirty", 2,
			"BrokenGlass", 0.4,
			"CopperScrap", 1,
			"ElectronicsScrap", 2,
			"GardenToolHandle_Broken", 1,
			"LongHandle_Broken", 1,
			"LongStick_Broken", 1,
			"MetalPipe_Broken", 1,
			"RippedSheetsDirty", 4,
			"ScrapMetal", 2,
			"SmashedBottle", 1,
			-- Trash
			"Brochure", 1,
			"Cockroach", 8,
			"DeadMouse", 2,
			"DeadRat", 1,
			"Dung_Rat", 0.5,
			"Flier", 1,
			"FountainCup", 4,
			"PaperNapkins2", 4,
			"PlasticCup", 4,
			"Receipt", 10,
			"ScratchTicket_Loser", 4,
			"Straw2", 8,
			"Splinters", 8,
			"UnusableMetal", 2,
			"UnusableWood", 2,
		},
		junk = ClutterTables.BinJunk,
	},
	
	-- Garbage bins also roll for extra loot via the BinJunk list.
	-- See Distribution_BinJunk for a separate list of items. It's big!
	BinGeneric = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Trash Bags
			"Bag_TrashBag", 20,
			-- Empties
			"BeerBottleEmpty", 2,
			"BeerCanEmpty", 8,
			"BeerImportedEmpty", 0.5,
			"BrandyEmpty", 0.1,
			"EmptyJar", 0.5,
			"GinEmpty", 0.1,
			"PaintbucketEmpty", 1,
			"Pop2Empty", 8,
			"Pop3Empty", 8,
			"PopBottleEmpty", 1,
			"PopBottleRareEmpty", 0.1,
			"PopEmpty", 8,
			"RumEmpty", 0.5,
			"ScotchEmpty", 0.1,
			--"SodaCanEmpty", 8,
			"TequilaEmpty", 0.5,
			"VodkaEmpty", 0.5,
			"WaterBottleEmpty", 1,
			"WhiskeyEmpty", 0.5,
			"Wine2OpenEmpty", 0.1,
			"WineOpenEmpty", 0.1,
			-- Scrap
			"AnimalBone", 1,
			"BandageDirty", 2,
			"BaseballBat_Broken", 1,
			"BrokenGlass", 0.4,
			"CopperScrap", 1,
			"ElectronicsScrap", 2,
			"GardenToolHandle_Broken", 1,
			"JarLid", 0.5,
			"LongHandle_Broken", 1,
			"LongStick_Broken", 1,
			"MetalPipe_Broken", 1,
			"RippedSheetsDirty", 4,
			"ScrapMetal", 2,
			"SmallAnimalBone", 2,
			"SmashedBottle", 1,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			-- Trash
			"Brochure", 1,
			"Cockroach", 8,
			"DeadMouse", 2,
			"DeadRat", 1,
			"Dung_Rat", 0.5,
			"Flier", 1,
			"FountainCup", 4,
			"PaperNapkins2", 4,
			"PlasticCup", 4,
			"Receipt", 10,
			"ScratchTicket_Loser", 4,
			"Straw2", 8,
			"Splinters", 8,
			"UnusableMetal", 2,
			"UnusableWood", 2,
		},
		junk = ClutterTables.BinJunk,
	},
	
	-- General medical bin. Works for clinics, hospitals, etc.
	BinHospital = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Medical Waste
			"BandageDirty", 50,
			"BandageDirty", 20,
			"BandageDirty", 20,
			"BandageDirty", 10,
			"BandageDirty", 10,
			"CottonBalls", 8,
			"TongueDepressor", 8,
			-- Discarded Gear
			"Gloves_Surgical", 20,
			"Gloves_Surgical", 10,
			"Hat_SurgicalCap", 8,
			"Hat_SurgicalMask", 20,
			"Hat_SurgicalMask", 10,
			"Shirt_Scrubs", 1,
			"Trousers_Scrubs", 1,
			-- Empties
			"BleachEmpty", 4,
			"DisinfectantEmpty", 8,
			-- Trash
			"BrokenGlass", 0.4,
			"Card_Sympathy", 1,
			"Cockroach", 8,
			"DeadMouse", 2,
			"DeadRat", 1,
		},
		junk = ClutterTables.BinJunk,
	},
	
	-- Fast-food places tend to have a decent amount of food scraps in their bins.
	BinJays = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Food
			"Biscuit", 8,
			"ChickenFried", 50,
			"ChickenFried", 20,
			"Cornbread", 8,
			"Fries", 50,
			"Fries", 20,
			-- Chicken Bones
			"SmallAnimalBone", 20,
			"SmallAnimalBone", 10,
			-- Trash
			"BrokenGlass", 0.4,
			"Cockroach", 8,
			"DeadMouse", 2,
			"DeadRat", 1,
			"FountainCup", 50,
			"FountainCup", 20,
			"MenuCard", 10,
			"PaperNapkins2", 50,
			"PaperNapkins2", 20,
			"Receipt", 50,
			"Receipt", 20,
			"Straw2", 50,
			"Straw2", 20,
		},
		junk = ClutterTables.BinJunk,
	},
	
	-- How often are these emptied anyway?
	BinSpiffos = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Food
			"Burger", 50,
			"Burger", 20,
			"ChickenNuggets", 8,
			"FriedOnionRings", 8,
			"Fries", 50,
			"Fries", 20,
			-- Trash
			"BrokenGlass", 0.4,
			"Cockroach", 8,
			"DeadMouse", 2,
			"DeadRat", 1,
			"FountainCup", 50,
			"FountainCup", 20,
			"MenuCard", 10,
			"PaperNapkins2", 50,
			"PaperNapkins2", 20,
			"Receipt", 50,
			"Receipt", 20,
			"Straw2", 50,
			"Straw2", 20,
		},
		junk = ClutterTables.BinJunk,
	},
	
	BookstoreBags = {
		rolls = 4,
		items = {
			"Plasticbag", 20,
			"Plasticbag", 20,
			"Plasticbag", 10,
			"Plasticbag", 10,
			"Tote", 20,
			"Tote", 20,
			"Tote", 10,
			"Tote", 10,
			"Bag_Satchel", 4,
			"Bag_Satchel", 4,
			"Bag_Schoolbag", 8,
			"Bag_Schoolbag", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Genres sorted alphabetically. Skills books should be in relevant containers.
	BookstoreArt = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Art", 20,
			"Book_Art", 10,
			"Magazine_Art_New", 20,
			"Magazine_Art_New", 10,
			"Paperback_Art", 20,
			"Paperback_Art", 20,
			"Paperback_Art", 10,
			"Paperback_Art", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	BookstoreAutomotive = {
		isShop = true,
		rolls = 4,
		items = {
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"BookMechanic3", 6,
			"BookMechanic4", 4,
			"BookMechanic5", 2,
			"Magazine_Car_New", 20,
			"Magazine_Car_New", 10,
			"MechanicMag1", 2,
			"MechanicMag2", 2,
			"MechanicMag3", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	BookstoreBiography = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Biography", 20,
			"Book_Biography", 10,
			"Paperback_Biography", 20,
			"Paperback_Biography", 20,
			"Paperback_Biography", 10,
			"Paperback_Biography", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreBooks = {
		isShop = true,
		rolls = 4,
		items = {
			"BookAiming1", 1,
			"BookAiming2", 0.8,
			"BookAiming3", 0.6,
			"BookAiming4", 0.4,
			"BookAiming5", 0.2,
			"BookBlacksmith1", 10,
			"BookBlacksmith2", 8,
			"BookBlacksmith3", 6,
			"BookBlacksmith4", 4,
			"BookBlacksmith5", 2,
			"BookButchering1", 10,
			"BookButchering2", 8,
			"BookButchering3", 6,
			"BookButchering4", 4,
			"BookButchering5", 2,
			"BookCarpentry1", 10,
			"BookCarpentry2", 8,
			"BookCarpentry3", 6,
			"BookCarpentry4", 4,
			"BookCarpentry5", 2,
			"BookCarving1", 10,
			"BookCarving2", 8,
			"BookCarving3", 6,
			"BookCarving4", 4,
			"BookCarving5", 2,
			"BookCooking1", 10,
			"BookCooking2", 8,
			"BookCooking3", 6,
			"BookCooking4", 4,
			"BookCooking5", 2,
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"BookFishing1", 10,
			"BookFishing2", 8,
			"BookFishing3", 6,
			"BookFishing4", 4,
			"BookFishing5", 2,
			"BookFlintKnapping1", 1,
			"BookFlintKnapping2", 0.8,
			"BookFlintKnapping3", 0.6,
			"BookFlintKnapping4", 0.4,
			"BookFlintKnapping5", 0.2,
			"BookGlassmaking1", 10,
			"BookGlassmaking2", 8,
			"BookGlassmaking3", 6,
			"BookGlassmaking4", 4,
			"BookGlassmaking5", 2,
			"BookHusbandry1", 10,
			"BookHusbandry2", 8,
			"BookHusbandry3", 6,
			"BookHusbandry4", 4,
			"BookHusbandry5", 2,
			"BookLongBlade1", 1,
			"BookLongBlade2", 0.8,
			"BookLongBlade3", 0.6,
			"BookLongBlade4", 0.4,
			"BookLongBlade5", 0.2,
			"BookMaintenance1", 10,
			"BookMaintenance2", 8,
			"BookMaintenance3", 6,
			"BookMaintenance4", 4,
			"BookMaintenance5", 2,
			"BookMasonry1", 10,
			"BookMasonry2", 8,
			"BookMasonry3", 6,
			"BookMasonry4", 4,
			"BookMasonry5", 2,
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"BookMechanic3", 6,
			"BookMechanic4", 4,
			"BookMechanic5", 2,
			"BookMetalWelding1", 10,
			"BookMetalWelding2", 8,
			"BookMetalWelding3", 6,
			"BookMetalWelding4", 4,
			"BookMetalWelding5", 2,
			"BookPottery1", 10,
			"BookPottery2", 8,
			"BookPottery3", 6,
			"BookPottery4", 4,
			"BookPottery5", 2,
			"BookReloading1", 1,
			"BookReloading2", 0.8,
			"BookReloading3", 0.6,
			"BookReloading4", 0.4,
			"BookReloading5", 0.2,
			"BookTracking1", 10,
			"BookTracking2", 8,
			"BookTracking3", 6,
			"BookTracking4", 4,
			"BookTracking5", 2,
			"BookTrapping1", 10,
			"BookTrapping2", 8,
			"BookTrapping3", 6,
			"BookTrapping4", 4,
			"BookTrapping5", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	BookstoreBlueCollar = {
		isShop = true,
		rolls = 4,
		items = {
			"BookCarpentry1", 10,
			"BookCarpentry2", 8,
			"BookCarpentry3", 6,
			"BookCarpentry4", 4,
			"BookCarpentry5", 2,
			"BookBlacksmith1", 10,
			"BookBlacksmith2", 8,
			"BookBlacksmith3", 6,
			"BookBlacksmith4", 4,
			"BookBlacksmith5", 2,
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"BookMaintenance1", 10,
			"BookMaintenance2", 8,
			"BookMaintenance3", 6,
			"BookMaintenance4", 4,
			"BookMaintenance5", 2,
			"BookMasonry1", 10,
			"BookMasonry2", 8,
			"BookMasonry3", 6,
			"BookMasonry4", 4,
			"BookMasonry5", 2,
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"BookMechanic3", 6,
			"BookMechanic4", 4,
			"BookMechanic5", 2,
			"BookMetalWelding1", 10,
			"BookMetalWelding2", 8,
			"BookMetalWelding3", 6,
			"BookMetalWelding4", 4,
			"BookMetalWelding5", 2,
			"ElectronicsMag1", 2,
			"ElectronicsMag2", 2,
			"ElectronicsMag3", 2,
			"ElectronicsMag4", 2,
			"ElectronicsMag5", 2,
			"SmithingMag1", 0.1,
			"SmithingMag2", 0.1,
			"SmithingMag3", 0.1,
			"SmithingMag4", 0.1,
			"SmithingMag5", 0.1,
			"SmithingMag6", 0.1,
			"SmithingMag7", 0.1,
			"SmithingMag8", 0.1,
			"SmithingMag9", 0.1,
			"SmithingMag10", 0.1,
			"SmithingMag11", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	BookstoreBusiness = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Business", 20,
			"Book_Business", 10,
			"Magazine_Business_New", 20,
			"Magazine_Business_New", 10,
			"Paperback_Business", 20,
			"Paperback_Business", 20,
			"Paperback_Business", 10,
			"Paperback_Business", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreChilds = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Childs", 20,
			"Book_Childs", 10,
			"ChildsPictureBook", 20,
			"ChildsPictureBook", 20,
			"ChildsPictureBook", 10,
			"ChildsPictureBook", 10,
			"ComicBook_Retail", 20,
			"ComicBook_Retail", 10,
			"EngineerMagazine1", 2,
			"Magazine_Childs_New", 20,
			"Magazine_Childs_New", 10,
			"Magazine_Teens_New", 20,
			"Magazine_Teens_New", 10,
			"Paperback_Childs", 20,
			"Paperback_Childs", 20,
			"Paperback_Childs", 10,
			"Paperback_Childs", 10,
			"Paperback_Teens", 20,
			"Paperback_Teens", 10,
			"TrickMag1", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreCinema = {
		isShop = true,
		rolls = 4,
		items = {
			"ArmorMag1", 0.5,
			"Book_Cinema", 20,
			"Book_Cinema", 10,
			"Magazine_Cinema_New", 20,
			"Magazine_Cinema_New", 10,
			"Paperback_Cinema", 20,
			"Paperback_Cinema", 20,
			"Paperback_Cinema", 10,
			"Paperback_Cinema", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreComputer = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Computer", 20,
			"Book_Computer", 10,
			"Magazine_Tech_New", 20,
			"Magazine_Tech_New", 10,
			"Paperback_Computer", 20,
			"Paperback_Computer", 20,
			"Paperback_Computer", 10,
			"Paperback_Computer", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	BookstoreCooking = {
		isShop = true,
		rolls = 4,
		items = {
			"BookButchering1", 10,
			"BookButchering2", 8,
			"BookButchering3", 6,
			"BookButchering4", 4,
			"BookButchering5", 2,
			"BookCooking1", 10,
			"BookCooking2", 8,
			"BookCooking3", 6,
			"BookCooking4", 4,
			"BookCooking5", 2,
			"BookTailoring1", 10,
			"BookTailoring2", 8,
			"BookTailoring3", 6,
			"BookTailoring4", 4,
			"BookTailoring5", 2,
			"CookingMag1", 2,
			"CookingMag2", 2,
			"CookingMag3", 2,
			"CookingMag4", 2,
			"CookingMag5", 2,
			"CookingMag6", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	-- Storefrount counter. Keys and employee belongings.
	BookStoreCounter = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_BlueFox", 1,
			"KeyRing_Bug", 1,
			"KeyRing_Hotdog", 1,
			"KeyRing_Kitty", 1,
			"KeyRing_PrayingHands", 1,
			"KeyRing_RainbowStar", 1,
			"KeyRing_RubberDuck", 1,
			-- Misc.
			"Paperback_CrimeFiction", 10,
			"Paperback_Fantasy", 10,
			"Paperback_Horror", 10,
			"Paperback_Occult", 1,
			"Paperback_SciFi", 10,
			"Plasticbag", 20,
			"Plasticbag", 10,
			"RPGmanual", 8,
			"VideoGame", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	BookstoreCrafts = {
		isShop = true,
		rolls = 4,
		items = {
			"ArmorMag2", 0.5,
			"BookCarving1", 10,
			"BookCarving2", 8,
			"BookCarving3", 6,
			"BookCarving4", 4,
			"BookCarving5", 2,
			"BookFlintKnapping1", 10,
			"BookFlintKnapping2", 8,
			"BookFlintKnapping3", 6,
			"BookFlintKnapping4", 4,
			"BookFlintKnapping5", 2,
			"BookGlassmaking1", 10,
			"BookGlassmaking2", 8,
			"BookGlassmaking3", 6,
			"BookGlassmaking4", 4,
			"BookGlassmaking5", 2,
			"GlassmakingMag1", 2,
			"GlassmakingMag2", 2,
			"GlassmakingMag3", 2,
			"PrimitiveToolMag1", 0.5,
			"PrimitiveToolMag2", 0.5,
			"PrimitiveToolMag3", 0.5,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	BookstoreCrimeFiction = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_CrimeFiction", 20,
			"Book_CrimeFiction", 10,
			"Magazine_Crime_New", 20,
			"Magazine_Crime_New", 10,
			"Paperback_Fiction", 20,
			"Paperback_Fiction", 20,
			"Paperback_Fiction", 10,
			"Paperback_Fiction", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreFantasySciFi = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Fantasy", 20,
			"Book_Fantasy", 10,
			"Book_SciFi", 20,
			"Book_SciFi", 10,
			"Paperback_Fantasy", 20,
			"Paperback_Fantasy", 10,
			"Paperback_SciFi", 20,
			"Paperback_SciFi", 10,
			"RPGmanual", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	BookstoreFarming = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Farming", 20,
			"Book_Farming", 10,
			"Book_Nature", 20,
			"Book_Nature", 10,
			"BookFarming1", 10,
			"BookFarming2", 8,
			"BookFarming3", 6,
			"BookFarming4", 4,
			"BookFarming5", 2,
			"BookForaging1", 10,
			"BookForaging2", 8,
			"BookForaging3", 6,
			"BookForaging4", 4,
			"BookForaging5", 2,
			"BookHusbandry1", 10,
			"BookHusbandry2", 8,
			"BookHusbandry3", 6,
			"BookHusbandry4", 4,
			"BookHusbandry5", 2,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"Paperback_Nature", 20,
			"Paperback_Nature", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	BookstoreFashion = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Fashion", 20,
			"Book_Fashion", 10,
			"BookTailoring1", 10,
			"BookTailoring2", 8,
			"BookTailoring3", 6,
			"BookTailoring4", 4,
			"BookTailoring5", 2,
			"KnittingMag1", 2,
			"KnittingMag2", 2,
			"Magazine_Fashion_New", 20,
			"Magazine_Fashion_New", 10,
			"Paperback_Fashion", 20,
			"Paperback_Fashion", 20,
			"Paperback_Fashion", 10,
			"Paperback_Fashion", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreGeneralReference = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_GeneralReference", 50,
			"Book_GeneralReference", 20,
			"Book_GeneralReference", 20,
			"Book_GeneralReference", 20,
			"Book_GeneralReference", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreHistory = {
		isShop = true,
		rolls = 4,
		items = {
			"ArmorMag3", 0.5,
			"ArmorMag4", 0.5,
			"ArmorMag5", 0.5,
			"Book_History", 20,
			"Book_History", 10,
			"Paperback_History", 20,
			"Paperback_History", 20,
			"Paperback_History", 10,
			"Paperback_History", 10,
			"WeaponMag1", 0.5,
			"WeaponMag6", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreHobbies = {
		isShop = true,
		rolls = 4,
		items = {
			"BackgammonBoard", 10,
			"CardDeck", 20,
			"CardDeck", 10,
			"CheckerBoard", 20,
			"CheckerBoard", 10,
			"ChessBlack", 10,
			"ChessWhite", 10,
			"Cube", 20,
			"Cube", 10,
			"Magazine_Gaming_New", 20,
			"Magazine_Gaming_New", 10,
			"Magazine_Hobby_New", 20,
			"Magazine_Hobby_New", 10,
			"PokerChips", 10,
			"RPGmanual", 20,
			"RPGmanual", 20,
			"RPGmanual", 10,
			"RPGmanual", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreHorror = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Horror", 20,
			"Book_Horror", 10,
			"Magazine_Horror_New", 20,
			"Magazine_Horror_New", 10,
			"Paperback_Horror", 20,
			"Paperback_Horror", 20,
			"Paperback_Horror", 10,
			"Paperback_Horror", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreLegal = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Legal", 20,
			"Book_Legal", 10,
			"Magazine_Police_New", 20,
			"Magazine_Police_New", 10,
			"Paperback_Legal", 20,
			"Paperback_Legal", 20,
			"Paperback_Legal", 10,
			"Paperback_Legal", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreLiteraryFiction = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_LiteraryFiction", 20,
			"Book_LiteraryFiction", 10,
			"Paperback_LiteraryFiction", 20,
			"Paperback_LiteraryFiction", 20,
			"Paperback_LiteraryFiction", 10,
			"Paperback_LiteraryFiction", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreMedical = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Medical", 20,
			"Book_Medical", 10,
			"BookFirstAid1", 10,
			"BookFirstAid2", 8,
			"BookFirstAid3", 6,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			"Magazine_Health_New", 20,
			"Magazine_Health_New", 10,
			"Paperback_Medical", 20,
			"Paperback_Medical", 20,
			"Paperback_Medical", 10,
			"Paperback_Medical", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreMilitaryHistory = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_MilitaryHistory", 20,
			"Book_MilitaryHistory", 10,
			"Magazine_Military_New", 20,
			"Magazine_Military_New", 10,
			"Paperback_MilitaryHistory", 20,
			"Paperback_MilitaryHistory", 20,
			"Paperback_MilitaryHistory", 10,
			"Paperback_MilitaryHistory", 10,
			"WeaponMag2", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreMisc = {
		isShop = true,
		rolls = 4,
		items = {
			"ComicBook_Retail", 20,
			"ComicBook", 10,
			"CookingMag1", 2,
			"CookingMag2", 2,
			"CookingMag3", 2,
			"CookingMag4", 2,
			"CookingMag5", 2,
			"CookingMag6", 2,
			"ElectronicsMag1", 2,
			"ElectronicsMag2", 2,
			"ElectronicsMag3", 2,
			"ElectronicsMag4", 2,
			"ElectronicsMag5", 2,
			"EngineerMagazine1", 2,
			"EngineerMagazine2", 2,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"FishingMag1", 2,
			"FishingMag2", 2,
			"GlassmakingMag1", 0.5,
			"GlassmakingMag2", 0.5,
			"GlassmakingMag3", 0.5,
			"HerbalistMag", 2,
			"HuntingMag1", 2,
			"HuntingMag2", 2,
			"HuntingMag3", 2,
			"KnittingMag1", 2,
			"KnittingMag2", 2,
			"Magazine_New", 50,
			"Magazine_New", 20,
			"Magazine_New", 20,
			"Magazine_New", 10,
			"Magazine_New", 10,
			"MagazineCrossword", 10,
			"MagazineWordsearch", 10,
			"MechanicMag1", 2,
			"MechanicMag2", 2,
			"MechanicMag3", 2,
			"MetalworkMag1", 2,
			"MetalworkMag2", 2,
			"MetalworkMag3", 2,
			"MetalworkMag4", 2,
			"PhotoBook", 20,
			"PhotoBook", 10,
			"RadioMag1", 2,
			"RadioMag2", 2,
			"RadioMag3", 2,
			"RPGmanual", 2,
			"SmithingMag1", 0.1,
			"SmithingMag2", 0.1,
			"SmithingMag3", 0.1,
			"SmithingMag4", 0.1,
			"SmithingMag5", 0.1,
			"SmithingMag6", 0.1,
			"SmithingMag7", 0.1,
			"SmithingMag8", 0.1,
			"SmithingMag9", 0.1,
			"SmithingMag10", 0.1,
			"SmithingMag11", 0.1,
			"TVMagazine", 20,
			"TVMagazine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreMusic = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Music", 20,
			"Book_Music", 10,
			"Magazine_Music_New", 20,
			"Magazine_Music_New", 10,
			"Paperback_Music", 20,
			"Paperback_Music", 20,
			"Paperback_Music", 10,
			"Paperback_Music", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreNewAge = {
		isShop = true,
		rolls = 4,
		items = {
			"Crystal", 2,
			"Paperback_NewAge", 50,
			"Paperback_NewAge", 20,
			"Paperback_NewAge", 20,
			"Paperback_NewAge", 10,
			"Paperback_NewAge", 10,
			"TarotCardDeck", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreNonFiction = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_AdventureNonFiction", 20,
			"Book_AdventureNonFiction", 10,
			"Book_SadNonFiction", 20,
			"Book_SadNonFiction", 10,
			"Paperback_AdventureNonFiction", 20,
			"Paperback_AdventureNonFiction", 10,
			"Paperback_SadNonFiction", 20,
			"Paperback_SadNonFiction", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreOccult = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Occult", 20,
			"Book_Occult", 10,
			"OujaBoard", 2,
			"Paperback_Occult", 20,
			"Paperback_Occult", 20,
			"Paperback_Occult", 10,
			"Paperback_Occult", 10,
			"TarotCardDeck", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreOutdoors = {
		isShop = true,
		rolls = 4,
		items = {
			"ArmorMag6", 0.5,
			"Book_Nature", 20,
			"Book_Nature", 10,
			"BookFishing1", 10,
			"BookFishing2", 8,
			"BookFishing3", 6,
			"BookFishing4", 4,
			"BookFishing5", 2,
			"BookTracking1", 10,
			"BookTracking2", 8,
			"BookTracking3", 6,
			"BookTracking4", 4,
			"BookTracking5", 2,
			"BookTrapping1", 10,
			"BookTrapping2", 8,
			"BookTrapping3", 6,
			"BookTrapping4", 4,
			"BookTrapping5", 2,
			"FishingMag1", 2,
			"FishingMag2", 2,
			"HerbalistMag", 2,
			"Magazine_Outdoors_New", 20,
			"Magazine_Outdoors_New", 10,
			"Paperback_Nature", 20,
			"Paperback_Nature", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstorePersonal = {
		isShop = true,
		rolls = 4,
		items = {
			"Paperback_Diet", 20,
			"Paperback_Diet", 10,
			"Paperback_Relationship", 20,
			"Paperback_Relationship", 10,
			"Paperback_SelfHelp", 20,
			"Paperback_SelfHelp", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstorePhilosophy = {
		isShop = true,
		rolls = 4,
		items = {
			"Paperback_Philosophy", 50,
			"Paperback_Philosophy", 20,
			"Paperback_Philosophy", 20,
			"Paperback_Philosophy", 10,
			"Paperback_Philosophy", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstorePolitics = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Politics", 20,
			"Book_Politics", 10,
			"Paperback_Politics", 20,
			"Paperback_Politics", 20,
			"Paperback_Politics", 10,
			"Paperback_Politics", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreReligion = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Religion", 20,
			"Book_Religion", 10,
			"Paperback_Religion", 20,
			"Paperback_Religion", 20,
			"Paperback_Religion", 10,
			"Paperback_Religion", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreRomance = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Romance", 20,
			"Book_Romance", 10,
			"Paperback_Romance", 20,
			"Paperback_Romance", 20,
			"Paperback_Romance", 10,
			"Paperback_Romance", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreSchoolTextbook = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_SchoolTextbook", 50,
			"Book_SchoolTextbook", 20,
			"Book_SchoolTextbook", 20,
			"Book_SchoolTextbook", 10,
			"Book_SchoolTextbook", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreScience = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Science", 20,
			"Book_Science", 10,
			"Magazine_Science_New", 20,
			"Magazine_Science_New", 10,
			"Paperback_Science", 20,
			"Paperback_Science", 20,
			"Paperback_Science", 10,
			"Paperback_Science", 10,
			"RadioMag1", 2,
			"RadioMag2", 2,
			"RadioMag3", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreSports = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Golf", 10,
			"Book_Sports", 20,
			"Book_Sports", 10,
			"Magazine_Golf_New", 20,
			"Magazine_Golf_New", 10,
			"Magazine_Sports_New", 20,
			"Magazine_Sports_New", 10,
			"Paperback_Golf", 10,
			"Paperback_Sports", 20,
			"Paperback_Sports", 20,
			"Paperback_Sports", 10,
			"Paperback_Sports", 10,
			"WeaponMag4", 0.5,
			"WeaponMag7", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreStationery = {
		isShop = true,
		rolls = 4,
		items = {
			"AdhesiveTapeBox", 0.1,
			"BluePen", 10,
			"Diary1", 10,
			"Diary2", 10,
			"Eraser", 10,
			"GraphPaper", 10,
			"GreenPen", 10,
			"Journal", 20,
			"Journal", 10,
			"MarkerBlack", 10,
			"MarkerBlue", 8,
			"MarkerGreen", 8,
			"MarkerRed", 8,
			"Notebook", 20,
			"Notebook", 10,
			"Notepad", 20,
			"Notepad", 10,
			"PaperclipBox", 1,
			"Pen", 10,
			"Pencil", 20,
			"Pencil", 10,
			"PencilSpiffo", 0.01,
			"PenFancy", 4,
			"PenMultiColor", 2,
			"PenSpiffo", 0.01,
			"RedPen", 10,
			"Scissors", 10,
			"ScissorsBlunt", 10,
			"Scotchtape", 10,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreThriller = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Thriller", 20,
			"Book_Thriller", 10,
			"Paperback_Thriller", 20,
			"Paperback_Thriller", 20,
			"Paperback_Thriller", 10,
			"Paperback_Thriller", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreTravel = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Travel", 20,
			"Book_Travel", 10,
			"Paperback_Travel", 20,
			"Paperback_Travel", 20,
			"Paperback_Travel", 10,
			"Paperback_Travel", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BookstoreWestern = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Western", 20,
			"Book_Western", 10,
			"Paperback_Western", 20,
			"Paperback_Western", 20,
			"Paperback_Western", 10,
			"Paperback_Western", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Fresh shoes and empty bowling bags.
	BowlingAlleyCounters = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_BowlingBallBag", 20,
			"Bag_BowlingBallBag", 10,
			"Shirt_Bowling_Blue", 2,
			"Shirt_Bowling_Brown", 2,
			"Shirt_Bowling_Green", 2,
			"Shirt_Bowling_LimeGreen", 2,
			"Shirt_Bowling_Pink", 2,
			"Shirt_Bowling_White", 2,
			"Shoes_Bowling", 50,
			"Shoes_Bowling", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Alley regulars and their jackets/non-bowling shoes.
	BowlingAlleyLockers = {
		rolls = 4,
		items = {
			"Bag_BowlingBallBag", 8,
			"Bag_DuffelBagTINT", 1,
			"Bag_FannyPackFront", 4,
			"Bag_Satchel", 2,
			"JacketLong_Random", 10,
			"Jacket_Leather", 1,
			"Jacket_Shellsuit_TINT", 4,
			"Jacket_WhiteTINT", 8,
			"Shirt_Bowling_Blue", 8,
			"Shirt_Bowling_Brown", 8,
			"Shirt_Bowling_Green", 8,
			"Shirt_Bowling_LimeGreen", 8,
			"Shirt_Bowling_Pink", 8,
			"Shirt_Bowling_White", 8,
			"Shoes_Bowling", 20,
			"Shoes_Bowling", 10,
			"Shoes_Random", 8,
			"Shoes_TrainerTINT", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Fresh pins in new condition.
	BowlingAlleyPins = {
		isShop = true,
		rolls = 4,
		items = {
			"BowlingPin", 50,
			"BowlingPin", 20,
			"BowlingPin", 20,
			"BowlingPin", 10,
			"BowlingPin", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Do these smell a bit funky to you?
	BowlingAlleyShoes = {
		rolls = 4,
		items = {
			"Shoes_Bowling", 50,
			"Shoes_Bowling", 20,
			"Shoes_Bowling", 20,
			"Shoes_Bowling", 10,
			"Shoes_Bowling", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BoxingLockers = {
		rolls = 4,
		items = {
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"BathTowel", 8,
			"Belt2", 4,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"ElbowPad_Left_Sport", 1,
			"Flask", 1,
			"Gloves_BoxingBlue", 8,
			"Gloves_BoxingRed", 8,
			"Hat_BoxingBlue", 8,
			"Hat_BoxingRed", 8,
			"Hat_Sweatband", 4,
			"Headphones", 1,
			"HoodieDOWN_WhiteTINT", 1,
			"Kneepad_Left_Sport", 1,
			"Magazine_Health", 10,
			"Money", 4,
			"Paperback_Diet", 4,
			"Paperback_Sports", 4,
			"Pills", 4,
			"Shoes_ArmyBoots", 4,
			"Shorts_BoxingBlue", 8,
			"Shorts_BoxingRed", 8,
			"Vest_DefaultTEXTURE", 10,
			"Sportsbottle", 4,
			"Whiskey", 1,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},
	
	BoxingMemorabilia = {
		rolls = 4,
		items = {
			"Gloves_BoxingBlue", 8,
			"Gloves_BoxingRed", 8,
			"Hat_BoxingBlue", 8,
			"Hat_BoxingRed", 8,
			"Hat_Sweatband", 4,
			"Shoes_ArmyBoots", 4,
			"Shorts_BoxingBlue", 8,
			"Shorts_BoxingRed", 8,
			"TrophyGold", 20,
			"TrophyGold", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BoxingStorageGloves = {
		rolls = 4,
		items = {
			"Gloves_BoxingBlue", 20,
			"Gloves_BoxingBlue", 20,
			"Gloves_BoxingBlue", 10,
			"Gloves_BoxingBlue", 10,
			"Gloves_BoxingRed", 20,
			"Gloves_BoxingRed", 20,
			"Gloves_BoxingRed", 10,
			"Gloves_BoxingRed", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BoxingStorageHelmets = {
		rolls = 4,
		items = {
			"Hat_BoxingBlue", 20,
			"Hat_BoxingBlue", 20,
			"Hat_BoxingBlue", 10,
			"Hat_BoxingBlue", 10,
			"Hat_BoxingRed", 20,
			"Hat_BoxingRed", 20,
			"Hat_BoxingRed", 10,
			"Hat_BoxingRed", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BreakRoomCounter = {
		rolls = 4,
		items = {
			-- Food/Drink/Ingredients
			"CannedMilk", 4,
			"Cereal", 6,
			"Coffee2", 10,
			"Honey", 4,
			"OatsRaw", 8,
			"Popcorn", 8,
			"SugarBrown", 4,
			"SugarCubes", 10,
			"SugarPacket", 10,
			"Teabag2", 8,
			-- Utensils
			"PlasticFork", 10,
			"PlasticKnife", 10,
			"PlasticSpoon", 10,
			"TinOpener", 6,
			"TinOpener_Old", 1,
			-- Dishes
			"Bowl", 10,
			"Kettle", 6,
			"Mugl", 10,
			"Saucepan", 4,
			"SaucepanCopper", 0.1,
			-- Misc.
			"MenuCard", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			-- Literature
			"Magazine_Business", 2,
			"Magazine_Fashion", 2,
			"Magazine_Health", 2,
			"Magazine_Hobby", 2,
			"Magazine_Sports", 2,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"Paperback_Business", 1,
			"Paperback_Diet", 1,
			"Paperback_SelfHelp", 1,
			"Paperback_Sports", 1,
			"Paperback_Travel", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"DishCloth", 10,
			}
		}
	},
	
	BreakRoomShelves = {
		rolls = 4,
		items = {
			-- Food/Drink
			"CannedMilk", 1,
			"CannedMilkOpen", 4,
			"Cereal", 8,
			"Coffee2", 10,
			"Honey", 4,
			"OatsRaw", 8,
			"Popcorn", 8,
			"Teabag2", 8,
			"SugarBrown", 4,
			"SugarCubes", 20,
			"SugarCubes", 10,
			"SugarPacket", 10,
			-- Literature
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"Magazine_Business", 2,
			"Magazine_Fashion", 2,
			"Magazine_Health", 2,
			"Magazine_Hobby", 2,
			"Magazine_Sports", 2,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Note", 20,
			"Paperback_Business", 1,
			"Paperback_Diet", 1,
			"Paperback_SelfHelp", 1,
			"Paperback_Sports", 1,
			"Paperback_Travel", 1,
			"TVMagazine", 8,
			-- Misc.
			"CardDeck", 1,
			"RadioBlack", 2,
			"RadioRed", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Mugl", 20,
				"Mugl", 10,
				"PaperNapkins2", 20,
				"PaperNapkins2", 10,
				"SheetPaper2", 10,
			}
		}
	},
	
	-- Freshly-filled bottles from the factory.
	BreweryBottles = {
		isShop = true,
		rolls = 4,
		items = {
			"BeerBottle", 20,
			"BeerBottle", 20,
			"BeerBottle", 10,
			"BeerBottle", 10,
			"BeerPack", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Same as above but with cans.
	BreweryCans = {
		isShop = true,
		rolls = 4,
		items = {
			"BeerCan", 20,
			"BeerCan", 20,
			"BeerCan", 10,
			"BeerCan", 10,
			"BeerCanPack", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Clean, empty beer bottles for the factory.
	BreweryEmptyBottles = {
		isShop = true,
		rolls = 4,
		items = {
			"BeerBottleEmpty", 50,
			"BeerBottleEmpty", 20,
			"BeerBottleEmpty", 20,
			"BeerBottleEmpty", 10,
			"BeerBottleEmpty", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Same as above but with cans.
	BreweryEmptyCans = {
		isShop = true,
		rolls = 4,
		items = {
			"BeerCanEmpty", 50,
			"BeerCanEmpty", 20,
			"BeerCanEmpty", 20,
			"BeerCanEmpty", 10,
			"BeerCanEmpty", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Can't have beer without hops!
	BreweryHops = {
		isShop = true,
		rolls = 4,
		items = {
			"HopsDried", 50,
			"HopsDried", 20,
			"HopsDried", 20,
			"HopsDried", 10,
			"HopsDried", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Prep station for turning ground beef into patties.
	BurgerKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"MincedMeat", 20,
			"MincedMeat", 10,
			-- Sauces/Spices
			"Pepper", 4,
			"PowderedGarlic", 4,
			"PowderedOnion", 4,
			"Salt", 4,
			"SeasoningSalt", 8,
			-- Utensils
			"Fleshing_Tool", 10,
			"KitchenKnife", 8,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			-- Misc.
			"CuttingBoardPlastic", 4,
			"Whetstone", 10,
			-- Clothing
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 8,
				"CuttingBoardPlastic", 50,
				"DishCloth", 10,
			}
		}
	},
	
	-- Utensils for flipping burgers and scraping grills. Also spare knives.
	BurgerKitchenCutlery = {
		rolls = 4,
		items = {
			-- Knives
			"KitchenKnife", 2,
			"KnifeFillet", 2,
			"KnifeParing", 4,
			"MeatCleaver", 1,
			-- Utensils
			"GrillBrush", 20,
			"GrillBrush", 10,
			"KitchenTongs", 10,
			"Spatula", 20,
			"Spatula", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 8,
				"DishCloth", 10,
			}
		}
	},
	
	-- Frozen foods for deep frying and extra meat.
	BurgerKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 8,
			"Frozen_ChickenNuggets", 8,
			"MincedMeat", 20,
			"MincedMeat", 10,
			-- Fries
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BurgerKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Vegetables
			"Lettuce", 4,
			"Onion", 4,
			"Pickles", 4,
			"Processedcheese", 8,
			"Tomato", 4,
			-- Meat
			"Bacon", 4,
			"MeatPatty", 20,
			"MeatPatty", 10,
			"MincedMeat", 8,
			-- Condiments
			"BBQSauce", 2,
			"Ketchup", 4,
			"MayonnaiseFull", 2,
			"Mustard", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	BurgerKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BBQSauce", 8,
			"GravyMix", 6,
			"Hotsauce", 8,
			"Ladle", 10,
			"Ketchup", 10,
			"Mustard", 10,
			"Vinegar2", 8,
			"Vinegar_Jug", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 8,
				"DishCloth", 10,
			}
		}
	},
	
	BurglarTools = {
		rolls = 4,
		items = {
			"Bag_DuffelBagTINT", 0.5,
			"BaseballBat", 8,
			"BaseballBat_Metal", 4,
			"BlowTorch", 8,
			"BoltCutters", 8,
			"ClubHammer", 8,
			"Crowbar", 4,
			"DuctTape", 4,
			"File", 8,
			"Garbagebag", 10,
			"Gloves_LeatherGloves", 6,
			"Gloves_LeatherGlovesBlack", 4,
			"Gloves_Surgical", 10,
			"Hammer", 8,
			"HandDrill", 4,
			"Hat_BalaclavaFace", 2,
			"Hat_BalaclavaFull", 2,
			"Hat_HeadSack_Burlap", 1,
			"Hat_HeadSack_Cotton", 1,
			"HeavyChain", 2,
			"IDcard_Blank", 10,
			"KnifeButterfly", 0.1,
			"Pliers", 8,
			"Revolver_Short", 8,
			"Rope", 10,
			"RubberHose", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"SheetMetalSnips", 4,
			"Shoes_TrainerTINT", 2,
			"SmallFileSet", 8,
			"SmallSaw", 8,
			"SwitchKnife", 10,
			"Tarp", 10,
			"WoodenMallet", 8,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherChicken = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Chicken", 20,
			"Chicken", 20,
			"Chicken", 10,
			"Chicken", 10,
			"ChickenFoot", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherChops = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Steak", 20,
			"Steak", 10,
			"PorkChop", 20,
			"PorkChop", 20,
			"PorkChop", 10,
			"PorkChop", 10,
			"MuttonChop", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherFish = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BlackCrappie", 1,
			"BlueCatfish", 1,
			"Bluegill", 1,
			"ChannelCatfish", 1,
			"FlatheadCatfish", 1,
			"FreshwaterDrum", 1,
			"GreenSunfish", 1,
			"LargemouthBass", 1,
			"Lobster", 0.5,
			"Muskellunge", 1,
			"Mussels", 8,
			"Oysters", 8,
			"RedearSunfish", 2,
			"Salmon", 4,
			"Sauger", 2,
			"Shrimp", 8,
			"SmallmouthBass", 1,
			"SpottedBass", 1,
			"Squid", 0.1,
			"StripedBass", 1,
			"Walleye", 8,
			"WhiteBass", 1,
			"WhiteCrappie", 1,
			"YellowPerch", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherFreezer = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Bacon", 8,
			"Chicken", 8,
			"Frozen_ChickenNuggets", 8,
			"Frozen_FishFingers", 8,
			"Frozen_FrenchFries", 10,
			"MeatPatty", 20,
			"MeatPatty", 10,
			"MincedMeat", 20,
			"MincedMeat", 10,
			"MuttonChop", 4,
			"PorkChop", 8,
			"Sausage", 8,
			"Steak", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherGround = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"MeatPatty", 20,
			"MeatPatty", 20,
			"MeatPatty", 10,
			"MeatPatty", 10,
			"MincedMeat", 20,
			"MincedMeat", 20,
			"MincedMeat", 10,
			"MincedMeat", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherLiterature = {
		isShop = true,
		rolls = 4,
		items = {
			"Apron_White", 10,
			"BookButchering1", 6,
			"BookButchering2", 4,
			"BookButchering3", 2,
			"BookButchering4", 1,
			"BookButchering5", 0.5,
			"CuttingBoardPlastic", 10,
			"CuttingBoardWooden", 10,
			"Hat_ChefHat", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherSmoked = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Bacon", 20,
			"Bacon", 10,
			"Baloney", 20,
			"Baloney", 10,
			"Ham", 20,
			"Ham", 10,
			"Salami", 20,
			"Salami", 10,
			"Sausage", 20,
			"Sausage", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherSnacks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BeefJerky", 20,
			"BeefJerky", 20,
			"BeefJerky", 10,
			"BeefJerky", 10,
			"DehydratedMeatStick", 20,
			"DehydratedMeatStick", 20,
			"DehydratedMeatStick", 10,
			"DehydratedMeatStick", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherSpices = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BBQSauce", 20,
			"BBQSauce", 10,
			"Coffee2", 8,
			"Flour2", 8,
			"GravyMix", 10,
			"Hotsauce", 10,
			"Rice", 8,
			"Sugar", 10,
			"SugarBrown", 10,
			"TinnedBeans", 8,
			"Vinegar2", 10,
			"Vinegar_Jug", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ButcherTools = {
		isShop = true,
		rolls = 4,
		items = {
			-- Knives/Blades
			"Fleshing_Tool", 20,
			"Fleshing_Tool", 10, 
			"KitchenKnife", 20,
			"KitchenKnife", 10,
			"KnifeFillet", 10,
			"LargeKnife", 8,
			"MeatCleaver", 8,
			-- Utensils
			"CarvingFork2", 10,
			"KitchenTongs", 10,
			"WoodenMallet", 10,
			-- Clothing
			"Apron_White", 10,
			"Hat_ChefHat", 10,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"CuttingBoardWooden", 10,
			"DishCloth", 10,
			"Twine", 10,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CabinetFactoryTools = {
		rolls = 4,
		items = {
			-- Tools
			"Calipers", 4,
			"CarpentryChisel", 10,
			"ClubHammer", 8,
			"Crowbar", 4,
			"GardenSaw", 10,
			"Hammer", 10,
			"HandDrill", 4,
			"Hinge", 8,
			"Paintbrush", 4,
			"Pliers", 8,
			"Saw", 8,
			"Screwdriver", 10,
			"ViseGrips", 4,
			"WoodenMallet", 8,
			-- Clothing
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 4,
			"Hat_BuildersRespirator", 1,
			"Hat_DustMask", 4,
			"Hat_HardHat", 1,
			"Kneepad_Left_Workman", 4,
			-- Materials
			"CircularSawblade", 20,
			"CircularSawblade", 10,
			"DuctTape", 4,
			"Epoxy", 2,
			"Handle", 8,
			"LongHandle", 4,
			"LongStick", 4,
			"NailsBox", 8,
			"NailsCarton", 0.5,
			"NutsBolts", 8,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.5,
			"SmallHandle", 8,
			"Whetstone", 10,
			"WoodenStick2", 4,
			"Woodglue", 4,
		},
		junk = {
			rolls = 1,
			items = {
				-- Misc.
				"MagnifyingGlass", 10,
				"MeasuringTape", 10,
				"SteelWool", 10,
				-- Trash
				"Splinters", 8,
				"UnusableWood", 4,
			}
		}
	},
	
	-- Various things to mix into your coffee to make it more flavorful.
	CafeCounterMix = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Mix
			"Cinnamon", 4,
			"CocoaPowder", 4,
			"SimpleSyrup", 4,
			"SugarPacket", 50,
			"SugarPacket", 20,
			-- Utensils
			"Spoon", 20,
			"Spoon", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"DishCloth", 10,
				"PlasticTray", 20,
				"PlasticTray", 10,
			}
		}
	},
	
	CafeDiningFridge = {
		-- Non-coffee drinks, usually for take-out.
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"JuiceBox", 8,
			"JuiceBoxApple", 8,
			"JuiceBoxFruitpunch", 8,
			"JuiceBoxOrange", 8,
			"Milk_Personalsized", 20,
			"Milk_Personalsized", 10,
			"MilkChocolate_Personalsized", 20,
			"MilkChocolate_Personalsized", 10,
			"Pop", 8,
			"Pop2", 8,
			"Pop3", 8,
			"PopBottle", 8,
			"PopBottleRare", 1,
			"WaterBottle", 20,
			"WaterBottle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CafeKitchenCoffee = {
		-- Coffee and coffee-related supplies.
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Coffee
			"Coffee2", 50,
			"Coffee2", 20,
			-- Mix
			"SimpleSyrup", 4,
			"SugarPacket", 50,
			"SugarPacket", 20,
			-- Utensils
			"MugWhite", 20,
			"MugWhite", 10,
			"Spoon", 20,
			"Spoon", 10,
			-- Misc.
			"Mov_CoffeeMaker", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 8,
				"DishCloth", 10,
			}
		}
	},
	
	CafeKitchenFridge = {
		-- Mix for coffee and similar drinks. We some fridge-friendly syrup.
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Milk", 20,
			"Milk", 20,
			"Milk", 10,
			"Milk", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CafeKitchenMugs = {
		rolls = 4,
		items = {
			"MugWhite", 50,
			"MugWhite", 20,
			"MugWhite", 20,
			"MugWhite", 10,
			"MugWhite", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 8,
				"DishCloth", 10,
			}
		}
	},
	
	CafeKitchenSupplies = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Coffee
			"Coffee2", 20,
			"Coffee2", 10,
			-- Tea
			"Teabag2", 50,
			"Teabag2", 20,
			-- Mix
			"SimpleSyrup", 8,
			"SugarPacket", 20,
			"SugarPacket", 10,
			"Sugar", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CafeKitchenTea = {
		-- Tea and tea-related supplies.
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Tea
			"Teabag2", 50,
			"Teabag2", 20,
			"Teabag2", 20,
			"Teabag2", 10,
			-- Mix
			"SugarPacket", 50,
			"SugarPacket", 20,
			-- Utensils
			"Teacup", 20,
			"Teacup", 10,
			"Spoon", 20,
			"Spoon", 10,
			-- Misc.
			"Kettle", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 8,
				"DishCloth", 10,
			}
		}
	},
	
	CafeShelfBooks = {
		rolls = 4,
		items = {
			"Magazine_Art", 6,
			"Magazine_Business", 6,
			"Magazine_Cinema", 6,
			"Magazine_Fashion", 6,
			"Magazine_Health", 6,
			"Magazine_Music", 6,
			"Magazine_Outdoors", 6,
			"Magazine_Science", 6,
			"Magazine_Sports", 6,
			"Magazine_Tech", 6,
			"Newspaper_Recent", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- School cafeterias and work cafeterias are currently the same. May expand in the future.
	-- Display shelf with drinks.
	CafeteriaDrinks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			-- Soda
			"Pop", 2,
			"Pop2", 2,
			"Pop3", 2,
			"PopBottle", 2,
			"PopBottleRare", 0.5,
			"SodaCan", 4,
			--"SodaCanRare", 0.1,
			-- Milk
			"Milk_Personalsized", 8,
			"MilkChocolate_Personalsized", 8,
			-- Water/Juice
			"JuiceBox", 4,
			"JuiceBoxApple", 4,
			"JuiceBoxFruitpunch", 4,
			"JuiceBoxOrange", 4,
			"WaterBottle", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CafeteriaFruit = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			-- Fruit
			"Apple", 8,
			"Banana", 8,
			"BerryBlue", 8,
			"Cherry", 8,
			"Grapefruit", 4,
			"Grapes", 4,
			"Mango", 4,
			"Orange", 4,
			"Peach", 4,
			"Pear", 4,
			"Strewberrie", 8,
			"WatermelonSliced", 2,
			-- Misc.
			"GranolaBar", 8,
			"Yoghurt", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Currently a copy of DinerKitchenFreezer minus Steak. Will do more later.
	CafeteriaKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 6,
			"Chicken", 4,
			"Frozen_ChickenNuggets", 8,
			"Frozen_FishFingers", 8,
			"Ham", 2,
			"MeatPatty", 8,
			"MincedMeat", 8,
			"PorkChop", 4,
			-- Vegetables
			"CornFrozen", 8,
			"MixedVegetables", 8,
			"Peas", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Same as above.
	CafeteriaKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 6,
			"Chicken", 4,
			"Ham", 2,
			"MincedMeat", 8,
			"MeatPatty", 8,
			"PorkChop", 4,
			-- Misc.
			"Butter", 8,
			"EggCarton", 4,
			"Lard", 2,
			"Margarine", 8,
			"Milk", 8,
			"Processedcheese", 8,
			-- Vegetables
			"Lettuce", 8,
			"Onion", 8,
			"Tomato", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Sandwiches are currently in a state of limbo. Enjoy bagels, biscuits and muffins for now.
	CafeteriaSandwiches = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BagelPlain", 20,
			"BagelPlain", 10,
			"BagelPoppy", 8,
			"BagelSesame", 8,
			"Biscuit", 8,
			"MuffinFruit", 10,
			"MuffinGeneric", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Assorted sweets for lunch.
	CafeteriaSnacks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			-- Candy
			"Chocolate", 1,
			"Chocolate_Butterchunkers", 1,
			"Chocolate_Candy", 1,
			"Chocolate_Crackle", 1,
			"Chocolate_Deux", 1,
			"Chocolate_GalacticDairy", 1,
			"Chocolate_RoysPBPucks", 1,
			"Chocolate_Smirkers", 1,
			"Chocolate_SnikSnak", 1,
			-- Baked Goods
			"CinnamonRoll", 2,
			"CookieChocolateChip", 2,
			"CookieJelly", 1,
			"CookiesChocolate", 1,
			"CookiesOatmeal", 1,
			"CookiesShortbread", 1,
			"CookiesSugar", 1,
			"Cupcake", 2,
			-- Snack Cakes
			"ChocoCakes", 2,
			"HiHis", 2,
			"Plonkies", 4,
			"QuaggaCakes", 2,
			"SnoGlobes", 2,
			-- Chips/Pretzels
			"Crisps", 2,
			"Crisps2", 2,
			"Crisps3", 2,
			"Crisps4", 2,
			"Pretzel", 4,
			"TortillaChips", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CafeteriaTrays = {
		rolls = 4,
		items = {
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			"PlasticTray", 50,
			"PlasticTray", 20,
			"PlasticTray", 20,
			"PlasticTray", 10,
			"PlasticTray", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CameraStoreDisplayCase = {
		isShop = true,
		rolls = 4,
		items = {
			"Camera", 20,
			"Camera", 20,
			"Camera", 10,
			"Camera", 10,
			"CameraExpensive", 20,
			"CameraExpensive", 10,
			"CameraFilm", 20,
			"CameraFilm", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CameraStoreShelves = {
		isShop = true,
		rolls = 4,
		items = {
			"CameraDisposable", 20,
			"CameraDisposable", 20,
			"CameraDisposable", 10,
			"CameraDisposable", 10,
			"CameraFilm", 20,
			"CameraFilm", 20,
			"CameraFilm", 10,
			"CameraFilm", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingLockers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 0.1,
			"KeyRing_PineTree", 0.1,
			-- Literature
			"BookFishing1", 2,
			"BookFishing2", 1,
			"BookFishing3", 0.5,
			"BookFishing4", 0.1,
			"BookFishing5", 0.05,
			"BookForaging1", 2,
			"BookForaging2", 1,
			"BookForaging3", 0.5,
			"BookForaging4", 0.1,
			"BookForaging5", 0.05,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"HerbalistMag", 1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"Magazine_Outdoors", 10,
			"Paperback_Nature", 8,
			"Paperback_Travel", 8,
			"SurvivalSchematic", 1,
			-- Survival
			"CanteenEmpty", 2,
			"CompassDirectional", 4,
			"FirstAidKit_Camping", 1,
			"FlashLight_AngleHead_Army", 1,
			"InsectRepellent", 8,
			"Lantern_Propane", 1,
			"MetalCup", 1,
			"Multitool", 0.1,
			"P38", 2,
			"Propane_Refill", 1,
			"Spork", 8,
			"Tacklebox", 1,
			"WaterPurificationTablets", 1,
			"Whetstone", 10,
			"Whistle", 4,
			-- Snacks
			"BeefJerky", 1,
			"DehydratedMeatStick", 1,
			"GranolaBar", 2,
			"Gum", 10,
			"SunflowerSeeds", 2,
			-- Tools
			"HandAxe", 1,
			"Handiknife", 0.1,
			"HuntingKnife", 1,
			"KnifePocket", 0.1,
			"LargeKnife", 0.5,
			"SmallKnife", 2,
			-- Outfit
			"Dungarees_HuntingCamo", 1,
			"Glasses_Aviators", 0.5,
			"Glasses_Sun", 1,
			"Gloves_HuntingCamo", 1,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_BaseballCap_HuntingCamo", 4,
			"Hat_Beany", 2,
			"Hat_BonnieHat", 10,
			"Hat_BonnieHat_CamoGreen", 4,
			"Hoodie_HuntingCamo_DOWN", 2,
			"Jacket_HuntingCamo", 2,
			"Jacket_Padded_HuntingCamo", 0.05,
			"PonchoGreenDOWN", 4,
			"ShemaghScarf", 0.1,
			"Shirt_CamoGreen", 8,
			"Shirt_Lumberjack", 4,
			"Shirt_Lumberjack_TINT", 4,
			"Shoes_HikingBoots", 4,
			"Shoes_Wellies", 1,
			"Shorts_CamoGreenLong", 4,
			"Trousers_CamoDesert", 2,
			"Trousers_HuntingCamo", 2,
			"Trousers_Padded_HuntingCamo", 0.05,
			"Tshirt_CamoGreen", 8,
			"Tshirt_HuntingCamo", 1,
			"Tshirt_LongSleeve_HuntingCamo", 1,
			-- Sleeping Bags
			"SleepingBag_BluePlaid_Packed", 1,
			"SleepingBag_Camo_Packed", 0.5,
			"SleepingBag_Cheap_Blue_Packed", 2,
			"SleepingBag_Cheap_Green2_Packed", 2,
			"SleepingBag_Cheap_Green_Packed", 2,
			"SleepingBag_GreenPlaid_Packed", 1,
			"SleepingBag_Green_Packed", 1,
			"SleepingBag_HighQuality_Brown_Packed", 0.5,
			"SleepingBag_RedPlaid_Packed", 1,
			"SleepingBag_Spiffo_Packed", 0.05,
			-- Bags/Containers
			"Bag_ALICEpack", 0.01,
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_FishingBasket", 4,
			"Bag_HydrationBackpack", 0.01,
			"Bag_LeatherWaterBag", 1,
			"Bag_NormalHikingBag", 0.1,
			"Bag_Satchel_Fishing", 4,
			"Cooler", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},
	
	CampingStoreBackpacks = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_ALICEpack", 0.5,
			"Bag_ALICEpack", 0.5,
			"Bag_BigHikingBag", 2,
			"Bag_BigHikingBag", 2,
			"Bag_DuffelBag", 6,
			"Bag_DuffelBag", 6,
			"Bag_HydrationBackpack", 1,
			"Bag_HydrationBackpack", 1,
			"Bag_NormalHikingBag", 4,
			"Bag_NormalHikingBag", 4,
			"Bag_Schoolbag", 10,
			"Bag_Schoolbag", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreBooks = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Nature", 4,
			"Book_Travel", 4,
			"BookTrapping1", 10,
			"BookTrapping2", 8,
			"BookTrapping3", 6,
			"BookTrapping4", 4,
			"BookTrapping5", 2,
			"FishingMag1", 2,
			"FishingMag2", 2,
			"HerbalistMag", 2,
			"HuntingMag1", 2,
			"HuntingMag2", 2,
			"HuntingMag3", 2,
			"Magazine_Outdoors_New", 20,
			"Magazine_Outdoors_New", 20,
			"Magazine_Outdoors_New", 10,
			"Magazine_Outdoors_New", 10,
			"Paperback_Nature", 8,
			"Paperback_Travel", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreCases = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_ProtectiveCase", 20,
			"Bag_ProtectiveCase", 10,
			"Bag_ProtectiveCaseBulky", 10,
			"Bag_ProtectiveCaseSmall", 20,
			"Bag_ProtectiveCaseSmall", 10,
			"Cooler", 20,
			"Cooler", 20,
			"Cooler", 10,
			"Cooler", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreClothes = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_FannyPackFront", 10,
			"Dungarees_HuntingCamo", 1,
			"Glasses_Aviators", 4,
			"Glasses_Sun", 8,
			"Gloves_HuntingCamo", 4,
			"Gloves_WhiteTINT", 10,
			"Hat_Bandana", 4,
			"Hat_BandanaTINT", 4,
			"Hat_BaseballCap_HuntingCamo", 8,
			"Hat_Beany", 10,
			"HoodieDOWN_WhiteTINT", 8,
			"Hoodie_HuntingCamo_DOWN", 8,
			"Jacket_ArmyCamoGreen", 4,
			"Jacket_HuntingCamo", 4,
			"Jacket_PaddedDOWN", 8,
			"Jacket_Padded_HuntingCamo", 1,
			"LongJohns", 4,
			"LongJohns_Bottoms", 4,
			"PonchoGreenDOWN", 10,
			"ShemaghScarf", 1,
			"Shirt_CamoGreen", 8,
			"Shirt_Lumberjack", 4,
			"Shirt_Lumberjack_TINT", 4,
			"Socks_Heavy", 10,
			"Trousers_HuntingCamo", 4,
			"Trousers_Padded", 2,
			"Trousers_Padded_HuntingCamo", 1,
			"Tshirt_ArmyGreen", 4,
			"Tshirt_CamoGreen", 10,
			"Tshirt_HuntingCamo", 4,
			"Tshirt_LongSleeve_HuntingCamo", 4,
			"Vest_Hunting_Camo", 6,
			"Vest_Hunting_CamoGreen", 6,
			"Vest_Hunting_Grey", 2,
			"Vest_Hunting_Orange", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreGear = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keyrings
			"KeyRing_Bass", 4,
			"KeyRing_PineTree", 4,
			-- TODO: Sort Me!
			"Bag_LeatherWaterBagEmpty", 10,
			"Bag_FishingBasket", 10,
			"CanteenEmpty", 20,
			"CanteenEmpty", 10,
			"CanteenCowboyEmpty", 8,
			"CanteenMilitaryEmpty", 8,
			"CompassDirectional", 20,
			"CompassDirectional", 10,
			"DryFirestarterBlock", 10,
			"FirstAidKit_Camping_New", 10,
			"Flask", 8,
			"InsectRepellent", 20,
			"InsectRepellent", 10,
			"MetalCup", 2,
			"PenLight", 10,
			"Spork", 10,
			"Tacklebox", 10,
			"Twine", 10,
			"WaterPurificationTablets", 20,
			"WaterPurificationTablets", 10,
			"Whetstone", 10,
			"Whistle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreLegwear = {
		isShop = true,
		rolls = 4,
		items = {
			"Dungarees_HuntingCamo", 20,
			"Dungarees_HuntingCamo", 10,
			"Shoes_HikingBoots", 20,
			"Shoes_HikingBoots", 10,
			"Shoes_Wellies", 10,
			"Shorts_CamoGreenLong", 20,
			"Shorts_CamoGreenLong", 10,
			"Trousers_CamoGreen", 20,
			"Trousers_CamoGreen", 10,
			"Trousers_HuntingCamo", 8,
			"Trousers_Padded_HuntingCamo", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreLighting = {
		isShop = true,
		rolls = 4,
		items = {
			"Candle", 10,
			"CandleBox", 4,
			"FlashLight_AngleHead", 1,
			"HandTorch", 10,
			"Lantern_Propane", 20,
			"Lantern_Propane", 20,
			"Lantern_Propane", 10,
			"Lantern_Propane", 10,
			"Lighter", 20,
			"Lighter", 10,
			"LighterFluid", 8,
			"MagnesiumFirestarter", 10,
			"Matchbox", 10,
			"Propane_Refill", 8,
			"Torch", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreSleepingBags = {
		isShop = true,
		rolls = 4,
		items = {
			"SleepingBag_BluePlaid_Packed", 10,
			"SleepingBag_Cheap_Blue_Packed", 20,
			"SleepingBag_Cheap_Green2_Packed", 20,
			"SleepingBag_Cheap_Green_Packed", 20,
			"SleepingBag_GreenPlaid_Packed", 10,
			"SleepingBag_Green_Packed", 10,
			"SleepingBag_HighQuality_Brown_Packed", 4,
			"SleepingBag_Spiffo_Packed", 0.05,
			"SleepingBag_RedPlaid_Packed", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreTents = {
		isShop = true,
		rolls = 4,
		items = {
			"Rope", 20,
			"Rope", 10,
			"Stake", 50,
			"Stake", 20,
			"Tarp", 20,
			"Tarp", 10,
			"TentBlue_Packed", 20,
			"TentBlue_Packed", 10,
			"TentBrown_Packed", 20,
			"TentBrown_Packed", 10,
			"TentGreen_Packed", 20,
			"TentGreen_Packed", 10,
			"TentYellow_Packed", 20,
			"TentYellow_Packed", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CampingStoreTools = {
		isShop = true,
		rolls = 4,
		items = {
			"EntrenchingTool", 10,
			"HandAxe", 20,
			"Handiknife", 8,
			"IceAxe", 8,
			"HuntingKnife", 20,
			"HuntingKnife", 10,
			"KnifePocket", 8,
			"LargeKnife", 8,
			"Multitool", 1,
			"SmallKnife", 20,
			"SmallKnife", 10,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CandyStoreSnacks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Allsorts", 8,
			"CandiedApple", 6,
			"CandyCaramels", 8,
			"CandyFruitSlices", 8,
			"CandyGummyfish", 8,
			"CandyNovapops", 8,
			"Chocolate", 4,
			"ChocolateCoveredCoffeeBeans", 8,
			"Chocolate_Butterchunkers", 4,
			"Chocolate_Candy", 8,
			"Chocolate_Crackle", 4,
			"Chocolate_Deux", 4,
			"Chocolate_GalacticDairy", 4,
			"Chocolate_RoysPBPucks", 4,
			"Chocolate_Smirkers", 4,
			"Chocolate_SnikSnak", 4,
			"Gum", 10,
			"GummyBears", 8,
			"GummyWorms", 8,
			"HardCandies", 8,
			"JellyBeans", 8,
			"Jujubes", 8,
			"LicoriceBlack", 4,
			"LicoriceRed", 8,
			"MintCandy", 8,
			"Modjeska", 6,
			"Peppermint", 8,
			"RockCandy", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSupplyBatteries = {
		isShop = true,
		rolls = 4,
		items = {
			"CarBattery1", 10,
			"CarBattery1", 10,
			"CarBattery2", 8,
			"CarBattery2", 8,
			"CarBattery3", 6,
			"CarBattery3", 6,
			"CarBatteryCharger", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSupplyGasCans = {
		isShop = true,
		rolls = 4,
		items = {
			"JerryCanEmpty", 8,
			"PetrolCanEmpty", 20,
			"PetrolCanEmpty", 20,
			"PetrolCanEmpty", 10,
			"PetrolCanEmpty", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSupplyLiterature = {
		isShop = true,
		rolls = 4,
		items = {
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"BookMechanic3", 6,
			"BookMechanic4", 4,
			"BookMechanic5", 2,
			"Magazine_Car_New", 20,
			"Magazine_Car_New", 10,
			"MechanicMag1", 4,
			"MechanicMag2", 4,
			"MechanicMag3", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSupplyMagazines = {
		isShop = true,
		rolls = 4,
		items = {
			"Magazine_Car_New", 20,
			"Magazine_Car_New", 20,
			"Magazine_Car_New", 10,
			"Magazine_Car_New", 10,
			"MechanicMag1", 8,
			"MechanicMag2", 8,
			"MechanicMag3", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSupplyTools = {
		isShop = true,
		rolls = 4,
		items = {
			"CarBatteryCharger", 4,
			"ElectricWire", 20,
			"ElectricWire", 10,
			"Epoxy", 8,
			"FiberglassTape", 8,
			"Funnel", 10,
			"HeavyChain", 8,
			"HeavyChain_Hook", 1,
			"Jack", 4,
			"LargeHook", 2,
			"LugWrench", 20,
			"LugWrench", 10,
			"Pliers", 20,
			"Pliers", 10,
			"Ratchet", 20,
			"Ratchet", 10,
			"RubberHose", 10,
			"Screwdriver", 20,
			"Screwdriver", 10,
			"TireIron", 10,
			"TirePump", 20,
			"TirePump", 10,
			"ViseGrips", 10,
			"Wrench", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarBrakesModern1 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernBrake1", 20,
			"ModernBrake1", 20,
			"ModernBrake1", 10,
			"ModernBrake1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarBrakesModern2 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernBrake2", 20,
			"ModernBrake2", 20,
			"ModernBrake2", 10,
			"ModernBrake2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarBrakesModern3 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernBrake3", 20,
			"ModernBrake3", 20,
			"ModernBrake3", 10,
			"ModernBrake3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarBrakesNormal1 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalBrake1", 20,
			"NormalBrake1", 20,
			"NormalBrake1", 10,
			"NormalBrake1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarBrakesNormal2 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalBrake2", 20,
			"NormalBrake2", 20,
			"NormalBrake2", 10,
			"NormalBrake2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarBrakesNormal3 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalBrake3", 20,
			"NormalBrake3", 20,
			"NormalBrake3", 10,
			"NormalBrake3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarDealerDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_CarDealer", 0.1,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			-- TODO: Sort Me!
			"Calculator", 8,
			"CardDeck", 1,
			"Cashbox", 0.5,
			"CigarBox", 0.1,
			"CigarettePack", 10,
			"CreditCard", 20,
			"CreditCard", 10,
			"Glasses_Aviators", 0.5,
			"Glasses_Prescription_Aviators", 0.05,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Reading", 4,
			"Glasses_Sun", 1,
			"Gum", 20,
			"HolePuncher", 4,
			"Magazine_Car", 10,
			"MenuCard", 20,
			"MenuCard", 10,
			"MechanicMag1", 20,
			"MechanicMag2", 20,
			"MechanicMag3", 20,
			"Money", 20,
			"Money", 10,
			"MoneyBundle", 0.1,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperwork", 20,
			"Paperwork", 10,
			"PillsVitamins", 0.1,
			"PokerChips", 20,
			"PokerChips", 10,
			"TVMagazine", 8,
			"Whiskey", 0.1,
		},
		junk = ClutterTables.DeskJunk,
	},
	
	CarDealerFilingCabinet = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"KeyRing_CarDealer", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"BusinessCard", 1,
			"Cashbox", 0.1,
			"IndexCard", 10,
			"MoneyBundle", 0.1,
			"Notebook", 10,
			"Paperwork", 20,
			"Paperwork", 10,
			"SheetPaper2", 50,
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"SheetPaper2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarLightbars = {
		isShop = true,
		rolls = 4,
		items = {
			"LightbarRed", 20,
			"LightbarRed", 10,
			"LightbarRedBlue", 10,
			"LightbarYellow",  20,
			"LightbarYellow",  10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarMufflerModern1 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernCarMuffler1", 20,
			"ModernCarMuffler1", 20,
			"ModernCarMuffler1", 10,
			"ModernCarMuffler1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarMufflerModern2 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernCarMuffler2", 20,
			"ModernCarMuffler2", 20,
			"ModernCarMuffler2", 10,
			"ModernCarMuffler2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarMufflerModern3 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernCarMuffler3", 20,
			"ModernCarMuffler3", 20,
			"ModernCarMuffler3", 10,
			"ModernCarMuffler3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarMufflerNormal1 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalCarMuffler1", 20,
			"NormalCarMuffler1", 20,
			"NormalCarMuffler1", 10,
			"NormalCarMuffler1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarMufflerNormal2 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalCarMuffler2", 20,
			"NormalCarMuffler2", 20,
			"NormalCarMuffler2", 10,
			"NormalCarMuffler2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarMufflerNormal3 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalCarMuffler3", 20,
			"NormalCarMuffler3", 20,
			"NormalCarMuffler3", 10,
			"NormalCarMuffler3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarnivalPrizes = {
		rolls = 4,
		items = {
			"BorisBadger", 1,
			"Cashbox", 1,
			"Cube", 10,
			"Dice", 8,
			"FluffyfootBunny", 1,
			"Firecracker", 8,
			"FreddyFox", 1,
			"FurbertSquirrel", 1,
			"JacquesBeaver", 1,
			"MoleyMole", 1,
			"PancakeHedgehog", 1,
			"PanchoDog", 1,
			"Plushabug", 1,
			"Spiffo", 1,
			"SpiffoBig", 0.1,
			"Comb", 10,
			"Yoyo", 10,
			"Eraser", 10,
			"PencilSpiffo", 4,
			"PenMultiColor", 10,
			"PenSpiffo", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarpenterOutfit = {
		rolls = 3,
		items = {
			"BookCarpentry1", 6,
			"BookCarpentry2", 4,
			"BookCarpentry3", 2,
			"BookCarpentry4", 1,
			"BookCarpentry5", 0.5,
			"DuctTape", 4,
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 8,
			"Gloves_LeatherGloves", 1,
			"Handiknife", 1,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_EarMuff_Protectors", 4,
			"Hat_HardHat", 4,
			"Kneepad_Left_Workman", 4,
			"KnifePocket", 1,
			"MarkerBlack", 4,
			"Multitool", 0.1,
			"Notepad", 10,
			"Pencil", 10,
			"RippedSheets", 10,
			"Shirt_Lumberjack", 8,
			"Shirt_Lumberjack_TINT", 8,
			"Shoes_WorkBoots", 8,
			"Toolbox", 2,
			"ToolRoll_Leather", 0.5,
			"Trousers_Denim", 10,
			"Tshirt_DefaultTEXTURE_TINT", 6,
			"Tsquare", 10,
			"Vest_DefaultTEXTURE_TINT", 6,
			"Vest_HighViz", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarpenterTools = {
		rolls = 3,
		items = {
			"Axe", 0.05,
			"BookCarpentry1", 6,
			"BookCarpentry2", 4,
			"BookCarpentry3", 2,
			"BookCarpentry4", 1,
			"BookCarpentry5", 0.5,
			"CarpentryChisel", 8,
			"CircularSawblade", 4,
			"ClubHammer", 4,
			"Crowbar", 4,
			"DuctTape", 4,
			"Epoxy", 2,
			"Glue", 4,
			"Hammer", 8,
			"HandAxe", 1,
			"HandDrill", 4,
			"Handiknife", 1,
			"HeavyChain", 4,
			"KnifePocket", 1,
			"MarkerBlack", 4,
			"MeasuringTape", 10,
			"Multitool", 0.1,
			"NailsBox", 20,
			"Notepad", 10,
			"Pencil", 10,
			"RippedSheets", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"Toolbox", 2,
			"ToolRoll_Leather", 0.5,
			"Twine", 10,
			"ViseGrips", 4,
			"Whetstone", 10,
			"WoodAxe", 0.025,
			"WoodenMallet", 4,
			"Woodglue", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSuspensionModern1 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernSuspension1", 20,
			"ModernSuspension1", 20,
			"ModernSuspension1", 10,
			"ModernSuspension1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSuspensionModern2 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernSuspension2", 20,
			"ModernSuspension2", 20,
			"ModernSuspension2", 10,
			"ModernSuspension2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSuspensionModern3 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernSuspension3", 20,
			"ModernSuspension3", 20,
			"ModernSuspension3", 10,
			"ModernSuspension3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSuspensionNormal1 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalSuspension1", 20,
			"NormalSuspension1", 20,
			"NormalSuspension1", 10,
			"NormalSuspension1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSuspensionNormal2 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalSuspension2", 20,
			"NormalSuspension2", 20,
			"NormalSuspension2", 10,
			"NormalSuspension2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarSuspensionNormal3 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalSuspension3", 20,
			"NormalSuspension3", 20,
			"NormalSuspension3", 10,
			"NormalSuspension3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarTiresModern1 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernTire1", 20,
			"ModernTire1", 20,
			"ModernTire1", 10,
			"ModernTire1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarTiresModern2 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernTire2", 20,
			"ModernTire2", 20,
			"ModernTire2", 10,
			"ModernTire2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarTiresModern3 = {
		isShop = true,
		rolls = 4,
		items = {
			"ModernTire3", 20,
			"ModernTire3", 20,
			"ModernTire3", 10,
			"ModernTire3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarTiresNormal1 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalTire1", 20,
			"NormalTire1", 20,
			"NormalTire1", 10,
			"NormalTire1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarTiresNormal2 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalTire2", 20,
			"NormalTire2", 20,
			"NormalTire2", 10,
			"NormalTire2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarTiresNormal3 = {
		isShop = true,
		rolls = 4,
		items = {
			"NormalTire3", 20,
			"NormalTire3", 20,
			"NormalTire3", 10,
			"NormalTire3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarWindows1 = {
		isShop = true,
		rolls = 4,
		items = {
			"FrontWindow1", 10,
			"RearWindow1", 10,
			"RearWindshield1", 20,
			"RearWindshield1", 10,
			"Windshield1", 20,
			"Windshield1", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarWindows2 = {
		isShop = true,
		rolls = 4,
		items = {
			"FrontWindow2", 10,
			"RearWindow2", 10,
			"RearWindshield2", 20,
			"RearWindshield2", 10,
			"Windshield2", 20,
			"Windshield2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CarWindows3 = {
		isShop = true,
		rolls = 4,
		items = {
			"FrontWindow3", 10,
			"RearWindow3", 10,
			"RearWindshield3", 20,
			"RearWindshield3", 10,
			"Windshield3", 20,
			"Windshield3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CatfishKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Catfish
			"BlueCatfish", 10,
			"FlatheadCatfish", 10,
			"ChannelCatfish", 10,
			-- Tools
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Fleshing_Tool", 10,
			"Hat_ChefHat", 4,
			"KitchenKnife", 6,
			"KnifeFillet", 6,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			"Twine", 10,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CatfishKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Catfish
			-- Note: These suckers can be big. One fish can sometimes fill up the whole container!
			"BlueCatfish", 10,
			"ChannelCatfish", 10,
			"FlatheadCatfish", 10,
			-- Fries
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 10,
			"Frozen_FrenchFries", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CatfishKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Catfish
			"BlueCatfish", 10,
			"ChannelCatfish", 10,
			"FlatheadCatfish", 10,
			-- Ingredients
			"Butter", 20,
			"Butter", 10,
			"EggCarton", 10,
			"Milk", 20,
			"Milk", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ChangeroomCounters = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"BathTowel", 10,
			"FirstAidKit", 1,
			"Hat_ShowerCap", 4,
			"HairDryer", 4,
			"HairIron", 2,
			"Mirror", 6,
			"Razor", 4,
			"Rubberducky", 4,
			"Shoes_FlipFlop", 4,
			"Soap2", 10,
			"Sportsbottle", 8,
			"Whistle", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ChefOutfit = {
		rolls = 3,
		items = {
			"BookCooking1", 6,
			"BookCooking2", 4,
			"BookCooking3", 2,
			"BookCooking4", 1,
			"BookCooking5", 0.5,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"CookingMag1", 0.5,
			"CookingMag2", 0.5,
			"CookingMag3", 0.5,
			"CookingMag4", 0.5,
			"CookingMag5", 0.5,
			"CookingMag6", 0.5,
			"Hat_ChefHat", 8,
			"Jacket_Chef", 10,
			"Shoes_Black", 8,
			"Trousers_Chef", 10,
			"Tshirt_DefaultTEXTURE_TINT", 6,
			"Vest_DefaultTEXTURE_TINT", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ChefTools = {
		rolls = 3,
		items = {
			"BookCooking1", 6,
			"BookCooking2", 4,
			"BookCooking3", 2,
			"BookCooking4", 1,
			"BookCooking5", 0.5,
			"CookingMag1", 0.5,
			"CookingMag2", 0.5,
			"CookingMag3", 0.5,
			"CookingMag4", 0.5,
			"CookingMag5", 0.5,
			"CookingMag6", 0.5,
			"KnifeFillet", 10,
			"KitchenKnife", 10,
			"KnifeSushi", 1,
			"KnifeParing", 10,
			"MeatCleaver", 10,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	Chemistry = {
		rolls = 4,
		items = {
			"BakingSoda", 10,
			"Bleach", 10,
			"CleaningLiquid2", 4,
			"Disinfectant", 4,
			"Extinguisher", 8,
			"FirstAidKit", 2,
			"Funnel", 10,
			"Glasses_SafetyGoggles", 8,
			"Gloves_Dish", 10,
			"Hat_BuildersRespirator", 2,
			"JacketLong_Doctor", 4,
			"Oxygen_Tank", 2,
			"PropaneTank", 0.5,
			"RespiratorFilters", 2,
			"RubberHose", 10,
			"SteelWool", 10,
			"Vinegar_Jug", 10,
			"WaterBottle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Dough prep for dumplings and steam buns. Water, flour, and salt!
	ChineseKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"Flour2", 50,
			"Flour2", 20,
			"Salt", 8,
			-- Trays/Dishes
			"Bowl", 10,
			"BakingPan", 8,
			"BakingTray", 8,
			-- Utensils
			"KitchenTongs", 10,
			"Ladle", 10,
			"RollingPin", 8,
			"Whisk", 10,
			"Strainer", 10,
			-- Misc.
			"Aluminum", 8,
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"OvenMitt", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Prep station to slice, chop, and tenderize meat.
	ChineseKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Chicken", 8,
			"ChickenFoot", 4,
			"MincedMeat", 8,
			"PorkChop", 8,
			"Shrimp", 4,
			-- Sauces/Spices
			"Pepper", 4,
			"PowderedGarlic", 4,
			"PowderedOnion", 4,
			"Salt", 4,
			"Soysauce", 8,
			-- Utensils
			"Fleshing_Tool", 10,
			"KitchenKnife", 4,
			"KnifeFillet", 2,
			"KnifeParing", 2,
			"LargeKnife", 1,
			"MeatCleaver", 8,
			"WoodenMallet", 8,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Whetstone", 10,
			-- Clothing
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Hat_ChefHat", 4,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ChineseKitchenCutlery = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Utensils
			"ButterKnife", 6,
			"Chopsticks", 20,
			"Chopsticks", 10,
			"KitchenTongs", 10,
			"Ladle", 10,
			"Fork", 20,
			"Fork", 10,
			"KitchenKnife", 6,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			"Strainer", 10,
			"Spoon", 20,
			"Spoon", 10,
			"Whisk", 10,
			-- Misc.
			"DishCloth", 10,
			"Whetstone", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ChineseKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Chicken", 8,
			"ChickenFoot", 4,
			"MincedMeat", 8,
			"PorkChop", 8,
			"Shrimp", 8,
			"Steak", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ChineseKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Vegetables
			"Broccoli", 8,
			"Cabbage", 8,
			"Carrots", 8,
			"Corn", 8,
			"Cucumber", 8,
			"Leek", 8,
			"Onion", 8,
			-- Meat
			"Chicken", 8,
			"ChickenFoot", 4,
			"MincedMeat", 8,
			"PorkChop", 8,
			"Shrimp", 8,
			"Steak", 8,
			-- Misc.
			"EggCarton", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ChineseKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Condiments
			"Hotsauce", 8,
			"OilVegetable", 8,
			"SesameOil", 20,
			"SesameOil", 10,
			"Soysauce", 20,
			"Soysauce", 10,
			-- Utensils
			"Ladle", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClassroomDesk = {
		rolls = 2,
		items = {
			-- School Supplies
			"BluePen", 2,
			"CorrectionFluid", 1,
			"Crayons", 2,
			"Eraser", 8,
			"Glue", 4,
			"GreenPen", 2,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Pen", 4,
			"Pencil", 10,
			"PencilCase", 4,
			"PenMultiColor", 1,
			"RedPen", 2,
			"Scissors", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			-- Literature (Generic)
			"Book_SchoolTextbook", 10,
			"ComicBook_Retail", 2,
			"MagazineWordsearch", 0.1,
			"Magazine_Humor", 10,
			"Note", 20,
			"Note", 10,
			"Notebook", 10,
			"Paperback_Fiction", 10,
			-- Misc.
			"Bracelet_LeftFriendshipTINT", 2,
			"Clitter", 1,
			"Cube", 4,
			"Diary1", 0.1,
			"DoodleKids", 8,
			"RubberSpider", 0.1,
			"VideoGame", 1,
			"Yoyo", 4,
			-- Snacks
			"CandyNovapops", 0.1,
			"Chocolate", 0.5,
			"Chocolate_Butterchunkers", 0.1,
			"Chocolate_Candy", 0.1,
			"Chocolate_Crackle", 0.1,
			"Chocolate_Deux", 0.1,
			"Chocolate_GalacticDairy", 0.1,
			"Chocolate_RoysPBPucks", 0.1,
			"Chocolate_Smirkers", 0.1,
			"Chocolate_SnikSnak", 0.1,
			"Crisps", 0.1,
			"Gum", 4,
			"Lollipop", 1,
			-- Special
			"CigarBox_Kids", 0.01,
			"Firecracker", 0.1,
			"PencilSpiffo", 0.005,
			"PenSpiffo", 0.005,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClassroomMisc = {
		rolls = 4,
		items = {
			-- School Supplies
			"Calculator", 4,
			"Clipboard", 2,
			"CompassGeometry", 4,
			"CorrectionFluid", 2,
			"GraphPaper", 4,
			"MarkerBlack", 4,
			"MarkerBlue", 2,
			"MarkerGreen", 2,
			"MarkerRed", 2,
			"Notebook", 8,
			"Paperclip", 10,
			"PaperclipBox", 0.1,
			"PencilCase", 8,
			"ScissorsBlunt", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			-- Crafting Supplies
			"Claybag", 0.5,
			"Clitter", 2,
			"Glue", 2,
			"Scotchtape", 4,
			"Twine", 10,
			-- Literature (Generic)
			"Book_SchoolTextbook", 20,
			"Book_SchoolTextbook", 10,
			"Magazine_Science", 1,
			-- Literature (Skill Books)
			"BookBlacksmith1", 2,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 0.5,
			"BookButchering1", 0.5,
			"BookButchering2", 0.1,
			"BookButchering3", 0.05,
			"BookCarpentry1", 2,
			"BookCarpentry2", 1,
			"BookCarpentry3", 0.5,
			"BookCooking1", 2,
			"BookCooking2", 1,
			"BookCooking3", 0.5,
			"BookElectrician1", 2,
			"BookElectrician2", 1,
			"BookElectrician3", 0.5,
			"BookFarming1", 2,
			"BookFarming2", 1,
			"BookFarming3", 0.5,
			"BookFirstAid1", 2,
			"BookFirstAid2", 1,
			"BookFirstAid3", 0.5,
			"BookFishing1", 2,
			"BookFishing2", 1,
			"BookFishing3", 0.5,
			"BookForaging1", 2,
			"BookForaging2", 1,
			"BookForaging3", 0.5,
			"BookGlassmaking1", 2,
			"BookGlassmaking2", 1,
			"BookGlassmaking3", 0.5,
			"BookHusbandry1", 2,
			"BookHusbandry2", 1,
			"BookHusbandry3", 0.5,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"BookMasonry1", 2,
			"BookMasonry2", 1,
			"BookMasonry3", 0.5,
			"BookMechanic1", 2,
			"BookMechanic2", 1,
			"BookMechanic3", 0.5,
			"BookMetalWelding1", 2,
			"BookMetalWelding2", 1,
			"BookMetalWelding3", 0.5,
			"BookPottery1", 2,
			"BookPottery2", 1,
			"BookPottery3", 0.5,
			"BookTailoring1", 2,
			"BookTailoring2", 1,
			"BookTailoring3", 0.5,
			"BookTracking1", 2,
			"BookTracking2", 1,
			"BookTracking3", 0.5,
			"BookTrapping1", 2,
			"BookTrapping2", 1,
			"BookTrapping3", 0.5,
			-- Misc.
			"Bucket", 1,
			"DoodleKids", 4,
			"FirstAidKit", 1,
			"Soap2", 10,
			"Sponge", 10,
			-- Special
			"TrophyBronze", 0.1,
			"TrophyGold", 0.001,
			"TrophySilver", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClassroomShelves = {
		rolls = 4,
		items = {
			-- School Supplies
			"Calculator", 1,
			"Clipboard", 8,
			"CompassGeometry", 4,
			"CorrectionFluid", 1,
			"Eraser", 8,
			"Glue", 2,
			"GraphPaper", 10,
			"MarkerBlack", 4,
			"MarkerBlue", 2,
			"MarkerGreen", 2,
			"MarkerRed", 2,
			"Notebook", 10,
			"Notepad", 8,
			"Paperclip", 10,
			"PaperclipBox", 0.1,
			"Pencil", 10,
			"RubberBand", 6,
			"Scissors", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"Twine", 10,
			-- Literature (Generic)
			"Book_SchoolTextbook", 20,
			"Book_SchoolTextbook", 10,
			"Magazine_Science", 10,
			"Paperback_Science", 8,
			-- Literature (Skill)
			"BookBlacksmith1", 0.5,
			"BookBlacksmith2", 0.1,
			"BookBlacksmith3", 0.05,
			"BookButchering1", 0.5,
			"BookButchering2", 0.1,
			"BookButchering3", 0.05,
			"BookCarpentry1", 2,
			"BookCarpentry2", 1,
			"BookCarpentry3", 0.5,
			"BookCooking1", 2,
			"BookCooking2", 1,
			"BookCooking3", 0.5,
			"BookElectrician1", 2,
			"BookElectrician2", 1,
			"BookElectrician3", 0.5,
			"BookFarming1", 2,
			"BookFarming2", 1,
			"BookFarming3", 0.5,
			"BookFirstAid1", 2,
			"BookFirstAid2", 1,
			"BookFirstAid3", 0.5,
			"BookFishing1", 2,
			"BookFishing2", 1,
			"BookFishing3", 0.5,
			"BookForaging1", 2,
			"BookForaging2", 1,
			"BookForaging3", 0.5,
			"BookGlassmaking1", 0.5,
			"BookGlassmaking2", 0.1,
			"BookGlassmaking3", 0.05,
			"BookHusbandry1", 2,
			"BookHusbandry2", 1,
			"BookHusbandry3", 0.5,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"BookMasonry1", 2,
			"BookMasonry2", 1,
			"BookMasonry3", 0.5,
			"BookMechanic1", 2,
			"BookMechanic2", 1,
			"BookMechanic3", 0.5,
			"BookMetalWelding1", 2,
			"BookMetalWelding2", 1,
			"BookMetalWelding3", 0.5,
			"BookPottery1", 2,
			"BookPottery2", 1,
			"BookPottery3", 0.5,
			"BookTailoring1", 2,
			"BookTailoring2", 1,
			"BookTailoring3", 0.5,
			"BookTracking1", 2,
			"BookTracking2", 1,
			"BookTracking3", 0.5,
			"BookTrapping1", 2,
			"BookTrapping2", 1,
			"BookTrapping3", 0.5,
			-- Misc.
			"DoodleKids", 4,
			"RadioBlack", 1,
			"RadioRed", 1,
			-- Special
			"TrophyBronze", 0.1,
			"TrophyGold", 0.001,
			"TrophySilver", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClassroomSecondaryDesk = {
		rolls = 2,
		items = {
			-- School Supplies
			"BluePen", 2,
			"Calculator", 1,
			"CompassGeometry", 4,
			"CorrectionFluid", 1,
			"Eraser", 8,
			"Glue", 2,
			"GraphPaper", 10,
			"GreenPen", 2,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Pen", 4,
			"Pencil", 10,
			"RedPen", 2,
			"Scissors", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			-- Literature (Generic)
			"Book_Fiction", 2,
			"Book_SchoolTextbook", 10,
			"ComicBook_Retail", 4,
			"Magazine_Teens", 10,
			"Note", 20,
			"Note", 10,
			"Notebook", 10,
			"Paperback_Fiction", 10,
			-- Misc.
			"Bracelet_LeftFriendshipTINT", 2,
			"CDplayer", 4,
			"RPGmanual", 0.1,
			"VideoGame", 4,
			"Whistle", 2,
			-- Snacks
			"CandyNovapops", 0.1,
			"Chocolate", 0.5,
			"Chocolate_Butterchunkers", 0.1,
			"Chocolate_Candy", 0.1,
			"Chocolate_Crackle", 0.1,
			"Chocolate_Deux", 0.1,
			"Chocolate_GalacticDairy", 0.1,
			"Chocolate_RoysPBPucks", 0.1,
			"Chocolate_Smirkers", 0.1,
			"Chocolate_SnikSnak", 0.1,
			"Crisps", 0.1,
			"Gum", 4,
			-- Special
			"LighterDisposable", 0.1,
			"CigarettePack", 0.05,
			"CigaretteRollingPapers", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClassroomSecondaryMisc = {
		rolls = 4,
		items = {
			-- School Supplies
			"Calculator", 1,
			"Clipboard", 8,
			"CompassGeometry", 4,
			"CorrectionFluid", 1,
			"Glue", 2,
			"GraphPaper", 10,
			"MarkerBlack", 4,
			"MarkerBlue", 2,
			"MarkerGreen", 2,
			"MarkerRed", 2,
			"Notebook", 10,
			"Notepad", 8,
			"Paperback_Science", 8,
			"Paperclip", 10,
			"PaperclipBox", 0.1,
			"Pencil", 10,
			"PencilCase", 4,
			"RubberBand", 6,
			"Scissors", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"Twine", 10,
			-- Literature (Generic)
			"Book_SchoolTextbook", 20,
			"Book_SchoolTextbook", 10,
			"Magazine_Science", 1,
			-- Literature (Skill Books)
			"BookBlacksmith1", 0.5,
			"BookBlacksmith2", 0.1,
			"BookBlacksmith3", 0.05,
			"BookButchering1", 0.5,
			"BookButchering2", 0.1,
			"BookButchering3", 0.05,
			"BookCarpentry1", 2,
			"BookCarpentry2", 1,
			"BookCarpentry3", 0.5,
			"BookCooking1", 2,
			"BookCooking2", 1,
			"BookCooking3", 0.5,
			"BookElectrician1", 2,
			"BookElectrician2", 1,
			"BookElectrician3", 0.5,
			"BookFarming1", 2,
			"BookFarming2", 1,
			"BookFarming3", 0.5,
			"BookFirstAid1", 2,
			"BookFirstAid2", 1,
			"BookFirstAid3", 0.5,
			"BookFishing1", 2,
			"BookFishing2", 1,
			"BookFishing3", 0.5,
			"BookForaging1", 2,
			"BookForaging2", 1,
			"BookForaging3", 0.5,
			"BookGlassmaking1", 0.5,
			"BookGlassmaking2", 0.1,
			"BookGlassmaking3", 0.05,
			"BookHusbandry1", 2,
			"BookHusbandry2", 1,
			"BookHusbandry3", 0.5,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"BookMasonry1", 2,
			"BookMasonry2", 1,
			"BookMasonry3", 0.5,
			"BookMechanic1", 2,
			"BookMechanic2", 1,
			"BookMechanic3", 0.5,
			"BookMetalWelding1", 2,
			"BookMetalWelding2", 1,
			"BookMetalWelding3", 0.5,
			"BookPottery1", 2,
			"BookPottery2", 1,
			"BookPottery3", 0.5,
			"BookTailoring1", 2,
			"BookTailoring2", 1,
			"BookTailoring3", 0.5,
			"BookTracking1", 2,
			"BookTracking2", 1,
			"BookTracking3", 0.5,
			"BookTrapping1", 2,
			"BookTrapping2", 1,
			"BookTrapping3", 0.5,
			-- Misc.
			"Bucket", 1,
			"DoodleKids", 4,
			"FirstAidKit", 1,
			"Soap2", 10,
			"Sponge", 10,
			-- Special
			"TrophyBronze", 0.1,
			"TrophyGold", 0.001,
			"TrophySilver", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClassroomSecondaryShelves = {
		rolls = 4,
		items = {
			-- School Supplies
			"Calculator", 1,
			"Clipboard", 8,
			"CompassGeometry", 4,
			"CorrectionFluid", 1,
			"Eraser", 8,
			"Glue", 2,
			"GraphPaper", 10,
			"MarkerBlack", 4,
			"MarkerBlue", 2,
			"MarkerGreen", 2,
			"MarkerRed", 2,
			"Notebook", 10,
			"Notepad", 8,
			"Paperclip", 10,
			"PaperclipBox", 0.1,
			"Pencil", 10,
			"RubberBand", 6,
			"Scissors", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"Twine", 10,
			-- Literature (Generic)
			"Book_SchoolTextbook", 20,
			"Book_SchoolTextbook", 10,
			"Magazine_Science", 10,
			"Paperback_Science", 8,
			-- Literature (Skill)
			"BookBlacksmith1", 0.5,
			"BookBlacksmith2", 0.1,
			"BookBlacksmith3", 0.05,
			"BookButchering1", 0.5,
			"BookButchering2", 0.1,
			"BookButchering3", 0.05,
			"BookCarpentry1", 2,
			"BookCarpentry2", 1,
			"BookCarpentry3", 0.5,
			"BookCooking1", 2,
			"BookCooking2", 1,
			"BookCooking3", 0.5,
			"BookElectrician1", 2,
			"BookElectrician2", 1,
			"BookElectrician3", 0.5,
			"BookFarming1", 2,
			"BookFarming2", 1,
			"BookFarming3", 0.5,
			"BookFirstAid1", 2,
			"BookFirstAid2", 1,
			"BookFirstAid3", 0.5,
			"BookFishing1", 2,
			"BookFishing2", 1,
			"BookFishing3", 0.5,
			"BookForaging1", 2,
			"BookForaging2", 1,
			"BookForaging3", 0.5,
			"BookGlassmaking1", 0.5,
			"BookGlassmaking2", 0.1,
			"BookGlassmaking3", 0.05,
			"BookHusbandry1", 2,
			"BookHusbandry2", 1,
			"BookHusbandry3", 0.5,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"BookMasonry1", 2,
			"BookMasonry2", 1,
			"BookMasonry3", 0.5,
			"BookMechanic1", 2,
			"BookMechanic2", 1,
			"BookMechanic3", 0.5,
			"BookMetalWelding1", 2,
			"BookMetalWelding2", 1,
			"BookMetalWelding3", 0.5,
			"BookPottery1", 2,
			"BookPottery2", 1,
			"BookPottery3", 0.5,
			"BookTailoring1", 2,
			"BookTailoring2", 1,
			"BookTailoring3", 0.5,
			"BookTracking1", 2,
			"BookTracking2", 1,
			"BookTracking3", 0.5,
			"BookTrapping1", 2,
			"BookTrapping2", 1,
			"BookTrapping3", 0.5,
			-- Misc.
			"RadioBlack", 1,
			"RadioRed", 1,
			-- Special
			"TrophyBronze", 0.1,
			"TrophyGold", 0.001,
			"TrophySilver", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClosetInstruments = {
		rolls = 2,
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			-- TODO: Sort me!
			"AssaultRifle2", 0.001,
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_FluteCase", 6,
			"Bag_NormalHikingBag", 0.1,
			"Bag_RifleCaseCloth", 0.0025,
			"Bag_RifleCaseCloth2", 0.0005,
			"Bag_ShotgunCaseCloth", 0.0025,
			"Bag_ShotgunCaseCloth2", 0.0025,
			"Bag_Satchel", 0.2,
			"Bag_SaxophoneCase", 6,
			"Bag_Schoolbag", 0.5,
			"Bag_TrumpetCase", 6,
			"Bag_ViolinCase", 4,
			"Banjo", 4,
			"BaseballBat", 1,
			"BaseballBat_Metal", 0.5,
			"Battery", 10,
			"BatteryBox", 0.5,
			"Book_Music", 4,
			"Briefcase", 0.2,
			"Candle", 1,
			"CircularSawblade", 0.1,
			"ClosedUmbrellaBlack", 0.1,
			"ClosedUmbrellaBlue", 0.1,
			"ClosedUmbrellaRed", 0.1,
			"ClosedUmbrellaWhite", 0.1,
			"ClosedUmbrellaTINTED", 0.2,
			"Cooler", 0.1,
			"CowHide", 0.001,
			"Crowbar", 4,
			"DappleDeerHide", 0.001,
			"DeerHide", 0.001,
			"Disc_Retail", 2,
			"DoubleBarrelShotgun", 0.01,
			"Drumstick", 20,
			"Drumstick", 10,
			"DuctTape", 4,
			"ElectricWire", 10,
			"FirstAidKit", 2,
			"Flute", 6,
			"Gloves_FingerlessGloves", 0.1,
			"Gloves_FingerlessLeatherGloves", 0.05,
			"Gloves_LeatherGloves", 0.05,
			"Gloves_LeatherGlovesBlack", 0.05,
			"Gloves_WhiteTINT", 0.1,
			"GuitarAcoustic", 8,
			"GuitarElectricBass", 4,
			"GuitarElectric", 4,
			"Hammer", 8,
			"Handiknife", 1,
			"HandTorch", 8,
			"Harmonica", 8,
			"Hat_Bandana", 0.1,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.1,
			"Hat_BucketHat", 0.1,
			"Hat_Fedora", 0.05,
			"HotWaterBottleEmpty", 1,
			"HuntingRifle", 0.005,
			"JacketLong_Random", 1,
			"Jacket_Leather", 0.5,
			"Jacket_Padded", 0.05,
			"Jacket_Shellsuit_Black", 0.05,
			"Jacket_Shellsuit_Blue", 0.05,
			"Jacket_Shellsuit_Green", 0.05,
			"Jacket_Shellsuit_Pink", 0.05,
			"Jacket_Shellsuit_Teal", 0.05,
			"Jacket_Shellsuit_TINT", 0.2,
			"Jacket_WhiteTINT", 0.5,
			"Keytar", 6,
			"Kneepad_Left_Sport", 0.1,
			"Leash", 2,
			"LightBulb", 10,
			"LightBulbBox", 0.001,
			"NutsBolts", 8,
			"Machete", 0.001,
			"Magazine_Music", 10,
			"MeasuringTape", 10,
			"Mov_BeigeRotaryPhone", 0.001,
			"Mov_BlackRotaryPhone", 0.001,
			"Mov_Cot", 0.001,
			"Mov_RedRotaryPhone", 0.001,
			"Mov_WhiteRotaryPhone", 0.001,
			"Mov_HuntingTrophy", 0.01,
			"Multitool", 0.01,
			"Paperback_Music", 8,
			"PaperclipBox", 0.1,
			"Pliers", 8,
			"PowerBar", 4,
			"RifleCase1", 0.0025,
			"RifleCase2", 0.0005,
			"RifleCase3", 0.0005,
			"Rope", 10,
			"Saw", 8,
			"Saxophone", 6,
			"Screwdriver", 8,
			"SewingKit", 1,
			"Shoes_ArmyBoots", 0.1,
			"Shoes_ArmyBootsDesert", 0.05,
			"Shoes_BlackBoots", 0.2,
			"Shoes_Fancy", 0.1,
			"Shoes_FlipFlop", 0.5,
			"Shoes_HikingBoots", 0.5,
			"Shoes_Random", 2,
			"Shoes_Sandals", 0.5,
			"Shoes_Strapped", 0.5,
			"Shoes_TrainerTINT", 2,
			"Shoes_Wellies", 0.5,
			"Shoes_WorkBoots", 0.5,
			"Shotgun", 0.01,
			"ShotgunCase1", 0.0025,
			"ShotgunCase2", 0.0025,
			"Suitcase", 0.2,
			"Toolbox", 2,
			"Trumpet", 6,
			"Twine", 10,
			"VarmintRifle", 0.05,
			"ViseGrips", 4,
			"Violin", 4,
		},
		junk = ClutterTables.ClosetJunk,
	},
	
	ClosetShelfGeneric = {
		rolls = 2, -- adjusted down to 2 from 4 for rebalancing
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			-- TODO: Sort Me!
			"AssaultRifle2", 0.001,
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_NormalHikingBag", 0.1,
			"Bag_RifleCaseCloth", 0.0025,
			"Bag_RifleCaseCloth2", 0.0005,
			"Bag_Satchel", 0.2,
			"Bag_Schoolbag", 0.5,
			"Bag_ShotgunCaseCloth", 0.0025,
			"Bag_ShotgunCaseCloth2", 0.0025,
			"BaseballBat", 1,
			"BaseballBat_Metal", 0.5,
			"Battery", 10,
			"BatteryBox", 0.5,
			"Book", 4,
			"Briefcase", 0.2,
			"Candle", 1,
			"CircularSawblade", 0.1,
			"ClosedUmbrellaBlack", 0.1,
			"ClosedUmbrellaBlue", 0.1,
			"ClosedUmbrellaRed", 0.1,
			"ClosedUmbrellaWhite", 0.1,
			"ClosedUmbrellaTINTED", 0.2,
			"Cooler", 0.1,
			"CowHide", 0.001,
			"Crowbar", 4,
			"DappleDeerHide", 0.001,
			"DeerHide", 0.001,
			"Disc_Retail", 2,
			"DoubleBarrelShotgun", 0.01,
			"DuctTape", 4,
			"ElectricWire", 10,
			"FirstAidKit", 2,
			"Gloves_FingerlessGloves", 0.1,
			"Gloves_FingerlessLeatherGloves", 0.05,
			"Gloves_LeatherGloves", 0.05,
			"Gloves_LeatherGlovesBlack", 0.05,
			"Gloves_WhiteTINT", 0.1,
			"Hammer", 8,
			"Handiknife", 1,
			"HandTorch", 8,
			"Hat_Bandana", 0.1,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.1,
			"Hat_BucketHat", 0.1,
			"Hat_Fedora", 0.05,
			"HotWaterBottleEmpty", 1,
			"HuntingRifle", 0.005,
			"JacketLong_Random", 1,
			"Jacket_Leather", 0.5,
			"Jacket_Padded", 0.05,
			"Jacket_Shellsuit_Black", 0.05,
			"Jacket_Shellsuit_Blue", 0.05,
			"Jacket_Shellsuit_Green", 0.05,
			"Jacket_Shellsuit_Pink", 0.05,
			"Jacket_Shellsuit_Teal", 0.05,
			"Jacket_Shellsuit_TINT", 0.2,
			"Jacket_WhiteTINT", 0.5,
			"Kneepad_Left_Sport", 0.1,
			"Leash", 2,
			"LightBulb", 10,
			"LightBulbBox", 0.001,
			"Machete", 0.001,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"MeasuringTape", 10,
			"Mov_BeigeRotaryPhone", 0.001,
			"Mov_BlackRotaryPhone", 0.001,
			"Mov_Cot", 0.001,
			"Mov_HuntingTrophy", 0.01,
			"Mov_RedRotaryPhone", 0.001,
			"Mov_WhiteRotaryPhone", 0.001,
			"Multitool", 0.01,
			"Paperback", 8,
			"PaperclipBox", 0.1,
			"Pliers", 8,
			"PowerBar", 4,
			"RifleCase1", 0.0025,
			"RifleCase2", 0.0005,
			"RifleCase3", 0.0005,
			"Rope", 10,
			"Saw", 8,
			"Screwdriver", 8,
			"SewingKit", 1,
			"Shoes_ArmyBoots", 0.1,
			"Shoes_ArmyBootsDesert", 0.05,
			"Shoes_BlackBoots", 0.2,
			"Shoes_Fancy", 0.1,
			"Shoes_FlipFlop", 0.5,
			"Shoes_HikingBoots", 0.5,
			"Shoes_Random", 2,
			"Shoes_Sandals", 0.5,
			"Shoes_Strapped", 0.5,
			"Shoes_TrainerTINT", 2,
			"Shoes_Wellies", 0.5,
			"Shoes_WorkBoots", 0.5,
			"Shotgun", 0.01,
			"ShotgunCase1", 0.0025,
			"ShotgunCase2", 0.0025,
			"Suitcase", 0.2,
			"Toolbox", 2,
			"Twine", 10,
			"VarmintRifle", 0.05,
			"ViseGrips", 4,
		},
		junk = ClutterTables.ClosetJunk,
	},
	
	ClosetSportsEquipment = {
		rolls = 2,
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			-- TODO: Sort Me!
			"AssaultRifle2", 0.001,
			"BadmintonRacket", 10,
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_GolfBag", 10,
			"Bag_NormalHikingBag", 0.1,
			"Bag_RifleCaseCloth", 0.0025,
			"Bag_RifleCaseCloth2", 0.0005,
			"Bag_Satchel", 0.2,
			"Bag_Schoolbag", 0.5,
			"Bag_ShotgunCaseCloth", 0.0025,
			"Bag_ShotgunCaseCloth2", 0.0025,
			"BarBell", 8,
			"Baseball", 10,
			"BaseballBat", 6,
			"BaseballBat_Metal", 4,
			"Basketball", 10,
			"Battery", 10,
			"BatteryBox", 0.5,
			"Book_Sports", 4,
			"Birdie", 10,
			"Briefcase", 0.2,
			"Candle", 1,
			"CanoePadel", 6,
			"CanoePadelX2", 6,
			"CircularSawblade", 0.1,
			"ClosedUmbrellaBlack", 0.1,
			"ClosedUmbrellaBlue", 0.1,
			"ClosedUmbrellaRed", 0.1,
			"ClosedUmbrellaWhite", 0.1,
			"ClosedUmbrellaTINTED", 0.2,
			"Cooler", 0.1,
			"CowHide", 0.001,
			"Crowbar", 4,
			"DappleDeerHide", 0.001,
			"DeerHide", 0.001,
			"Disc_Retail", 2,
			"DoubleBarrelShotgun", 0.01,
			"DuctTape", 4,
			"DumbBell", 4,
			"ElbowPad_Left_Sport", 0.5,
			"ElbowPad_Left_TINT", 0.1,
			"ElectricWire", 10,
			"FieldHockeyStick", 6,
			"FirstAidKit", 2,
			"Football", 10,
			"Gloves_BoxingBlue", 4,
			"Gloves_BoxingRed", 4,
			"Gloves_FingerlessGloves", 0.1,
			"Gloves_FingerlessLeatherGloves", 0.05,
			"Gloves_LeatherGloves", 0.05,
			"Gloves_LeatherGlovesBlack", 0.05,
			"Gloves_WhiteTINT", 0.1,
			"GolfBall", 10,
			"Golfclub", 8,
			"GolfTee", 10,
			"Hammer", 8,
			"Handiknife", 1,
			"HandTorch", 8,
			"Hat_Bandana", 0.1,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_BaseballHelmet", 4,
			"Hat_Beany", 0.1,
			"Hat_BoxingBlue", 4,
			"Hat_BoxingRed", 4,
			"Hat_BucketHat", 0.1,
			"Hat_Fedora", 0.05,
			"Hat_FootballHelmet", 2,
			"Hat_HockeyHelmet", 2,
			"Hat_HockeyMask", 4,
			"HotWaterBottleEmpty", 1,
			"HuntingRifle", 0.005,
			"IceHockeyStick", 6,
			"JacketLong_Random", 1,
			"Jacket_Leather", 0.5,
			"Jacket_Padded", 0.05,
			"Jacket_Shellsuit_Black", 0.05,
			"Jacket_Shellsuit_Blue", 0.05,
			"Jacket_Shellsuit_Green", 0.05,
			"Jacket_Shellsuit_Pink", 0.05,
			"Jacket_Shellsuit_Teal", 0.05,
			"Jacket_Shellsuit_TINT", 0.2,
			"Jacket_WhiteTINT", 0.5,
			"Kneepad_Left_Sport", 2,
			"Kneepad_Left_TINT", 1,
			"LaCrosseStick", 6,
			"Leash", 2,
			"LightBulb", 10,
			"LightBulbBox", 0.001,
			"Machete", 0.001,
			"Magazine_Sports", 10,
			"MeasuringTape", 10,
			"Mov_BeigeRotaryPhone", 0.001,
			"Mov_BlackRotaryPhone", 0.001,
			"Mov_Cot", 0.001,
			"Mov_HuntingTrophy", 0.01,
			"Mov_RedRotaryPhone", 0.001,
			"Mov_WhiteRotaryPhone", 0.001,
			"Multitool", 0.01,
			"Paperback_Sports", 8,
			"PaperclipBox", 0.1,
			"Pliers", 8,
			"PowerBar", 4,
			"RifleCase1", 0.0025,
			"RifleCase2", 0.0005,
			"RifleCase3", 0.0005,
			"Rope", 10,
			"Saw", 8,
			"Screwdriver", 8,
			"SewingKit", 1,
			"ShinKneeGuard_L", 4,
			"Shinpad_HockeyGoalie_L", 2,
			"Shinpad_L", 4,
			"Shoes_ArmyBoots", 0.1,
			"Shoes_ArmyBootsDesert", 0.05,
			"Shoes_BlackBoots", 0.5,
			"Shoes_Fancy", 0.1,
			"Shoes_FlipFlop", 0.5,
			"Shoes_HikingBoots", 0.5,
			"Shoes_Random", 2,
			"Shoes_Sandals", 0.5,
			"Shoes_Strapped", 0.5,
			"Shoes_TrainerTINT", 2,
			"Shoes_Wellies", 0.5,
			"Shoes_WorkBoots", 0.5,
			"Shotgun", 0.01,
			"ShotgunCase1", 0.0025,
			"ShotgunCase2", 0.0025,
			"Shoulderpads_Football", 4,
			"Shoulderpads_IceHockey", 4,
			"SoccerBall", 10,
			"Suitcase", 0.2,
			"TennisBall", 10,
			"TennisRacket", 10,
			"Toolbox", 2,
			"Twine", 10,
			"VarmintRifle", 0.05,
			"Vest_CatcherVest", 8,
			"ViseGrips", 4,
			"Whistle", 8,
		},
		junk = ClutterTables.ClosetJunk,
	},
	
	ClothingPoor = {
		rolls = 4,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingRack = {
		rolls = 4,
		items = {
			"HoodieDOWN_WhiteTINT", 1,
			"JacketLong_Random", 0.5,
			"Jacket_Leather", 0.5,
			"Jacket_Shellsuit_Black", 0.05,
			"Jacket_Shellsuit_Blue", 0.05,
			"Jacket_Shellsuit_Green", 0.05,
			"Jacket_Shellsuit_Pink", 0.05,
			"Jacket_Shellsuit_Teal", 0.05,
			"Jacket_Shellsuit_TINT", 0.2,
			"Jacket_WhiteTINT", 0.5,
			"Jumper_DiamondPatternTINT", 0.1,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"LongCoat_Bathrobe", 0.1,
			"Shirt_FormalTINT", 0.5,
			"Shirt_FormalWhite", 0.5,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shirt_Lumberjack", 0.05,
			"Shirt_Lumberjack_TINT", 0.05,
			"Shorts_LongDenim", 1,
			"Shorts_LongSport", 0.5,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"Tie_BowTieFull", 0.5,
			"Tie_BowTieWorn", 0.5,
			"Tie_Full", 0.5,
			"Tie_Worn", 0.5,
			"Trousers", 2,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_HUE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Shellsuit_Black", 0.05,
			"Trousers_Shellsuit_Blue", 0.05,
			"Trousers_Shellsuit_Green", 0.05,
			"Trousers_Shellsuit_Pink", 0.05,
			"Trousers_Shellsuit_Teal", 0.05,
			"Trousers_Shellsuit_TINT", 0.2,
			"Trousers_Sport", 0.2,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Trousers_WhiteTINT", 2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.01,
			"Tshirt_LongSleeve_SuperColor", 0.1,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_Sport", 0.2,
			"Tshirt_SportDECAL", 0.2,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.1,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Vest_DefaultTEXTURE_TINT", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStorageAllJackets = {
		isShop = true,
		rolls = 4,
		items = {
			"JacketLong_Random", 2,
			"JacketLong_Random", 2,
			"Jacket_Black", 1,
			"Jacket_Leather", 1,
			"Jacket_Leather_Punk", 0.1,
			"Jacket_Shellsuit_Black", 4,
			"Jacket_Shellsuit_Blue", 4,
			"Jacket_Shellsuit_Green", 4,
			"Jacket_Shellsuit_Pink", 4,
			"Jacket_Shellsuit_Teal", 4,
			"Jacket_Shellsuit_TINT", 10,
			"Jacket_Shellsuit_TINT", 10,
			"Jacket_Varsity", 2,
			"Jacket_WhiteTINT", 10,7
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStorageAllShirts = {
		isShop = true,
		rolls = 4,
		items = {
			"HoodieDOWN_WhiteTINT", 10,
			"HoodieDOWN_WhiteTINT", 10,
			"Jumper_DiamondPatternTINT", 4,
			"Jumper_PoloNeck", 6,
			"Jumper_RoundNeck", 8,
			"Jumper_VNeck", 8,
			"Shirt_Baseball_KY", 6,
			"Shirt_Baseball_Rangers", 6,
			"Shirt_Baseball_Z", 6,
			"Shirt_Denim", 8,
			"Shirt_FormalWhite", 10,
			"Shirt_FormalWhite", 10,
			"Shirt_FormalTINT", 8,
			"Shirt_FormalWhite_ShortSleeve", 8,
			"Shirt_FormalWhite_ShortSleeveTINT", 8,
			"Shirt_Lumberjack", 10,
			"Shirt_Lumberjack_TINT", 10,
			"Tshirt_DefaultDECAL_TINT", 8,
			"Tshirt_DefaultTEXTURE_TINT", 8,
			"Tshirt_IndieStoneDECAL", 4,
			"Tshirt_LongSleeve_SuperColor", 4,
			"Tshirt_PoloStripedTINT", 6,
			"Tshirt_PoloTINT", 6,
			"Tshirt_Sport", 10,
			"Tshirt_SportDECAL", 8,
			"Tshirt_SuperColor", 4,
			"Tshirt_TieDye", 4,
			"Tshirt_WhiteLongSleeveTINT", 10,
			"Tshirt_WhiteTINT", 10,
			"Vest_DefaultTEXTURE_TINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStorageFootwear = {
		isShop = true,
		rolls = 4,
		items = {
			"Shoes_Black", 10,
			"Shoes_BlackBoots", 6,
			"Shoes_BlueTrainers", 8,
			"Shoes_Brown", 10,
			"Shoes_Fancy", 6,
			"Shoes_FlipFlop", 8,
			"Shoes_WorkBoots", 10,
			"Shoes_RedTrainers", 8,
			"Shoes_RidingBoots", 6,
			"Shoes_Sandals", 8,
			"Shoes_Strapped", 8,
			"Shoes_TrainerTINT", 10,
			"Shoes_TrainerTINT", 10,
			"Shoes_Wellies", 4,
			"Shoes_WorkBoots", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStorageHeadwear = {
		isShop = true,
		rolls = 4,
		items = {
			"Hat_BaseballCap", 6,
			"Hat_BaseballCapBlue", 6,
			"Hat_BaseballCapGreen", 6,
			"Hat_BaseballCapKY", 4,
			"Hat_BaseballCapKY_Red", 4,
			"Hat_BaseballCapRed", 6,
			"Hat_BaseballCapTINT", 10,
			"Hat_Beany", 6,
			"Hat_Beret", 6,
			"Hat_BonnieHat", 10,
			"Hat_BonnieHat_CamoGreen", 8,
			"Hat_BucketHat", 6,
			"Hat_Cowboy", 4,
			"Hat_Fedora", 4,
			"Hat_Fedora_Delmonte", 2,
			"Hat_GolfHat", 8,
			"Hat_GolfHatTINT", 8,
			"Hat_SummerHat", 4,
			"Hat_Sweatband", 10,
			"Hat_VisorBlack", 8,
			"Hat_VisorRed", 8,
			"Hat_Visor_WhiteTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStorageLegwear = {
		isShop = true,
		rolls = 4,
		items = {
			"Shorts_LongSport", 8,
			"Shorts_ShortSport", 8,
			"TrousersMesh_DenimLight", 8,
			"Trousers_DefaultTEXTURE_TINT", 8,
			"Trousers_Denim", 6,
			"Trousers_JeanBaggy", 6,
			"Trousers_Suit", 4,
			"Trousers_SuitTEXTURE", 8,
			"Trousers_SuitWhite", 4,
			"Trousers_WhiteTINT", 8,
			"Trousers_LeatherBlack", 2,
			"TrousersMesh_Leather", 2,
			"Trousers_Shellsuit_Black", 4,
			"Trousers_Shellsuit_Blue", 4,
			"Trousers_Shellsuit_Green", 4,
			"Trousers_Shellsuit_Pink", 4,
			"Trousers_Shellsuit_Teal", 4,
			"Trousers_Shellsuit_TINT", 10,
			"Trousers_Sport", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStorageWinter = {
		isShop = true,
		rolls = 4,
		items = {
			"Glasses_SkiGoggles", 6,
			"Hat_BalaclavaFace", 8,
			"Hat_BalaclavaFull", 8,
			"Hat_EarMuffs", 8,
			"Hat_WinterHat", 10,
			"Hat_WoolyHat", 10,
			"Jacket_PaddedDOWN", 8,
			"Jacket_PaddedDOWN", 8,
			"LongJohns", 6,
			"LongJohns_Bottoms", 8,
			"Scarf_StripeBlackWhite", 10,
			"Scarf_StripeBlueWhite", 10,
			"Scarf_StripeRedWhite", 10,
			"Scarf_White", 10,
			"Trousers_Padded", 8,
			"Trousers_Padded", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresBoots = {
		isShop = true,
		rolls = 4,
		items = {
			"Shoes_BlackBoots", 20,
			"Shoes_BlackBoots", 10,
			"Shoes_HikingBoots", 20,
			"Shoes_HikingBoots", 10,
			"Shoes_Wellies", 10,
			"Shoes_WorkBoots", 20,
			"Shoes_WorkBoots", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresDress = {
		isShop = true,
		rolls = 4,
		items = {
			"DressKnees_Straps", 10,
			"Dress_Knees", 10,
			"Dress_Long", 6,
			"Dress_long_Straps", 6,
			"Dress_Normal", 10,
			"Dress_Short", 10,
			"Dress_SmallBlackStrapless", 10,
			"Dress_SmallBlackStraps", 10,
			"Dress_SmallStrapless", 10,
			"Dress_SmallStraps", 10,
			"Dress_Straps", 10,
			"Skirt_Knees", 10,
			"Skirt_Long", 6,
			"Skirt_Normal", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresEyewear = {
		isShop = true,
		rolls = 4,
		items = {
			"Glasses", 10,
			"Glasses_Aviators", 10,
			"Glasses_CatsEye_Sun", 4,
			"Glasses_JackieO", 1,
			"Glasses_Macho", 1,
			"Glasses_Round_Shades", 4,
			"Glasses_Round_Shades", 4,
			"Glasses_SkiGoggles", 10,
			"Glasses_Sun", 10,
			"Glasses_SwimmingGoggles", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresGloves = {
		isShop = true,
		rolls = 4,
		items = {
			"Gloves_WhiteTINT", 10,
			"Gloves_WhiteTINT", 10,
			"Gloves_WhiteTINT", 10,
			"Gloves_WhiteTINT", 10,
			"Gloves_FingerlessGloves", 10,
			"Gloves_FingerlessGloves", 10,
			"Gloves_LeatherGloves", 6,
			"Gloves_LeatherGloves", 6,
			"Gloves_LeatherGlovesBlack", 4,
			"Gloves_LongWomenGloves", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresGlovesLeather = {
		isShop = true,
		rolls = 4,
		items = {
			"Gloves_LeatherGloves", 10,
			"Gloves_LeatherGloves", 10,
			"Gloves_LeatherGloves", 10,
			"Gloves_LeatherGloves", 10,
			"Gloves_LeatherGlovesBlack", 8,
			"Gloves_LeatherGlovesBlack", 8,
			"Gloves_LeatherGlovesBlack", 8,
			"Gloves_LeatherGlovesBlack", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresHeadwear = {
		isShop = true,
		rolls = 4,
		items = {
			"Hat_BaseballCap", 6,
			"Hat_BaseballCapBlue", 6,
			"Hat_BaseballCapGreen", 6,
			"Hat_BaseballCapKY", 4,
			"Hat_BaseballCapKY_Red", 4,
			"Hat_BaseballCapRed", 6,
			"Hat_BaseballCapTINT", 10,
			"Hat_Beany", 6,
			"Hat_Beany", 6,
			"Hat_Beret", 6,
			"Hat_Beret", 6,
			"Hat_BonnieHat", 10,
			"Hat_BonnieHat_CamoGreen", 8,
			"Hat_BucketHat", 6,
			"Hat_BucketHat", 6,
			"Hat_Cowboy", 4,
			"Hat_Fedora", 4,
			"Hat_Fedora_Delmonte", 2,
			"Hat_GolfHat", 6,
			"Hat_GolfHatTINT", 6,
			"Hat_SummerHat", 4,
			"Hat_SummerHat", 4,
			"Hat_Sweatband", 10,
			"Hat_VisorBlack", 6,
			"Hat_VisorRed", 6,
			"Hat_Visor_WhiteTINT", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresHolsters = {
		isShop = true,
		rolls = 4,
		items = {
			"HolsterAnkle", 2,
			"HolsterDouble", 20,
			"HolsterDouble", 10,
			"HolsterShoulder", 8,
			"HolsterSimple_Brown", 20,
			"HolsterSimple_Brown", 20,
			"HolsterSimple_Brown", 10,
			"HolsterSimple_Brown", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresJackets = {
		isShop = true,
		rolls = 4,
		items = {
			"JacketLong_Random", 2,
			"Jacket_Black", 1,
			"Jacket_Leather", 1,
			"Jacket_Shellsuit_Black", 4,
			"Jacket_Shellsuit_Blue", 4,
			"Jacket_Shellsuit_Green", 4,
			"Jacket_Shellsuit_Pink", 4,
			"Jacket_Shellsuit_Teal", 4,
			"Jacket_Shellsuit_TINT", 10,
			"Jacket_Shellsuit_TINT", 10,
			"Jacket_Varsity", 2,
			"Jacket_WhiteTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresJacketsFormal = {
		isShop = true,
		rolls = 4,
		items = {
			"Suit_Jacket", 10,
			"Suit_Jacket", 10,
			"Suit_Jacket", 10,
			"Suit_Jacket", 10,
			"Suit_Jacket", 10,
			"Suit_Jacket", 10,
			"Suit_JacketTINT", 8,
			"Suit_JacketTINT", 8,
			"Suit_JacketTINT", 8,
			"Suit_JacketTINT", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresJacketsLeather = {
		isShop = true,
		rolls = 4,
		items = {
			"Jacket_Black", 20,
			"Jacket_Black", 10,
			"Jacket_Leather", 20,
			"Jacket_Leather", 10,
			"JacketLong_Random", 20,
			"JacketLong_Random", 20,
			"JacketLong_Random", 10,
			"JacketLong_Random", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresJeans = {
		isShop = true,
		rolls = 4,
		items = {
			"TrousersMesh_DenimLight", 10,
			"TrousersMesh_DenimLight", 10,
			"TrousersMesh_DenimLight", 10,
			"TrousersMesh_DenimLight", 10,
			"Trousers_Denim", 10,
			"Trousers_Denim", 10,
			"Trousers_Denim", 10,
			"Trousers_Denim", 10,
			"Trousers_JeanBaggy", 10,
			"Trousers_JeanBaggy", 10,
			"Trousers_JeanBaggy", 10,
			"Trousers_JeanBaggy", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresJumpers = {
		isShop = true,
		rolls = 4,
		items = {
			"HoodieDOWN_WhiteTINT", 8,
			"HoodieDOWN_WhiteTINT", 8,
			"Jumper_RoundNeck", 10,
			"Jumper_RoundNeck", 10,
			"Jumper_RoundNeck", 10,
			"Jumper_RoundNeck", 10,
			"Jumper_VNeck", 8,
			"Jumper_VNeck", 8,
			"Jumper_PoloNeck", 8,
			"Jumper_PoloNeck", 8,
			"Jumper_DiamondPatternTINT", 6,
			"Jumper_DiamondPatternTINT", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresOvershirts = {
		isShop = true,
		rolls = 4,
		items = {
			"Shirt_Lumberjack", 20,
			"Shirt_Lumberjack", 10,
			"Shirt_Lumberjack_TINT", 20,
			"Shirt_Lumberjack_TINT", 10,
			"Shirt_Denim", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresPants = {
		isShop = true,
		rolls = 4,
		items = {
			"TrousersMesh_DenimLight", 10,
			"TrousersMesh_DenimLight", 10,
			"Trousers_DefaultTEXTURE_TINT", 10,
			"Trousers_DefaultTEXTURE_TINT", 10,
			"Trousers_Denim", 10,
			"Trousers_Denim", 10,
			"Trousers_JeanBaggy", 10,
			"Trousers_JeanBaggy", 10,
			"Trousers_Shellsuit_Black", 4,
			"Trousers_Shellsuit_Blue", 4,
			"Trousers_Shellsuit_Green", 4,
			"Trousers_Shellsuit_Pink", 4,
			"Trousers_Shellsuit_Teal", 4,
			"Trousers_Shellsuit_TINT", 10,
			"Trousers_Shellsuit_TINT", 10,
			"Trousers_WhiteTINT", 10,
			"Trousers_WhiteTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresPantsFormal = {
		isShop = true,
		rolls = 4,
		items = {
			"Trousers_SuitTEXTURE", 6,
			"Trousers_SuitTEXTURE", 6,
			"Trousers_SuitTEXTURE", 6,
			"Trousers_SuitTEXTURE", 6,
			"Trousers_SuitWhite", 8,
			"Trousers_SuitWhite", 8,
			"Trousers_SuitWhite", 8,
			"Trousers_SuitWhite", 8,
			"Trousers_Suit", 10,
			"Trousers_Suit", 10,
			"Trousers_Suit", 10,
			"Trousers_Suit", 10,
			"Trousers_Suit", 10,
			"Trousers_Suit", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresPantsLeather = {
		isShop = true,
		rolls = 4,
		items = {
			"Trousers_LeatherBlack", 10,
			"Trousers_LeatherBlack", 10,
			"Trousers_LeatherBlack", 10,
			"Trousers_LeatherBlack", 10,
			"TrousersMesh_Leather", 10,
			"TrousersMesh_Leather", 10,
			"TrousersMesh_Leather", 10,
			"TrousersMesh_Leather", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresShirts = {
		isShop = true,
		rolls = 4,
		items = {
			"Tshirt_WhiteTINT", 10,
			"Tshirt_WhiteTINT", 10,
			"Tshirt_WhiteLongSleeveTINT", 10,
			"Tshirt_WhiteLongSleeveTINT", 10,
			"Tshirt_DefaultTEXTURE_TINT", 8,
			"Tshirt_DefaultTEXTURE_TINT", 8,
			"Tshirt_DefaultDECAL_TINT", 8,
			"Tshirt_DefaultDECAL_TINT", 8,
			"Tshirt_PoloTINT", 6,
			"Tshirt_PoloTINT", 6,
			"Tshirt_PoloStripedTINT", 6,
			"Tshirt_PoloStripedTINT", 6,
			"Tshirt_IndieStoneDECAL", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresShirtsFormal = {
		isShop = true,
		rolls = 4,
		items = {
			"Shirt_FormalWhite", 10,
			"Shirt_FormalWhite", 10,
			"Shirt_FormalWhite", 10,
			"Shirt_FormalWhite", 10,
			"Shirt_FormalWhite_ShortSleeve", 8,
			"Shirt_FormalWhite_ShortSleeve", 8,
			"Shirt_FormalWhite_ShortSleeve", 8,
			"Shirt_FormalWhite_ShortSleeve", 8,
			"Shirt_FormalWhite_ShortSleeveTINT", 6,
			"Shirt_FormalWhite_ShortSleeveTINT", 6,
			"Shirt_FormalTINT", 6,
			"Shirt_FormalTINT", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresShoes = {
		isShop = true,
		rolls = 4,
		items = {
			"Shoes_Black", 8,
			"Shoes_Black", 8,
			"Shoes_Black", 8,
			"Shoes_Black", 8,
			"Shoes_BlueTrainers", 6,
			"Shoes_Brown", 8,
			"Shoes_Brown", 8,
			"Shoes_Brown", 8,
			"Shoes_Brown", 8,
			"Shoes_Fancy", 6,
			"Shoes_FlipFlop", 6,
			"Shoes_FlipFlop", 6,
			"Shoes_RedTrainers", 6,
			"Shoes_Sandals", 6,
			"Shoes_Strapped", 6,
			"Shoes_TrainerTINT", 10,
			"Shoes_TrainerTINT", 10,
			"Shoes_TrainerTINT", 10,
			"Shoes_TrainerTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresShoesLeather = {
		isShop = true,
		rolls = 4,
		items = {
			"Shoes_Black", 10,
			"Shoes_Black", 10,
			"Shoes_Black", 10,
			"Shoes_Black", 10,
			"Shoes_Brown", 10,
			"Shoes_Brown", 10,
			"Shoes_Brown", 10,
			"Shoes_Brown", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresSocks = {
		isShop = true,
		rolls = 4,
		items = {
			"Socks_Ankle", 20,
			"Socks_Ankle", 10,
			"Socks_Ankle_Black", 20,
			"Socks_Ankle_Black", 10,
			"Socks_Ankle_White", 20,
			"Socks_Ankle_White", 10,
			"Socks_Heavy", 10,
			"Socks_Long", 20,
			"Socks_Long", 10,
			"Socks_Long_Black", 20,
			"Socks_Long_Black", 10,
			"Socks_Long_White", 20,
			"Socks_Long_White", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresSport = {
		isShop = true,
		rolls = 4,
		items = {
			"Vest_DefaultTEXTURE_TINT", 10,
			"Vest_DefaultTEXTURE_TINT", 10,
			"Tshirt_Sport", 10,
			"Tshirt_Sport", 10,
			"Shorts_ShortSport", 10,
			"Shorts_ShortSport", 10,
			"Shorts_LongSport", 8,
			"Shorts_LongSport", 8,
			"Trousers_Sport", 10,
			"Trousers_Sport", 10,
			"Tshirt_SportDECAL", 8,
			"Tshirt_SportDECAL", 8,
			"Shirt_Baseball_Z", 6,
			"Shirt_Baseball_KY", 6,
			"Shirt_Baseball_KY", 6,
			"Shirt_Baseball_Rangers", 6,
			"Shirt_Baseball_Rangers", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresSummer = {
		isShop = true,
		rolls = 4,
		items = {
			"Bikini_Pattern01", 6,
			"Bikini_TINT", 6,
			"Shirt_HawaiianTINT", 10,
			"Shirt_HawaiianTINT", 10,
			"Shirt_HawaiianTINT", 10,
			"Shirt_HawaiianTINT", 10,
			"Swimsuit_TINT", 10,
			"SwimTrunks_Blue", 8,
			"SwimTrunks_Green", 8,
			"SwimTrunks_Red", 8,
			"SwimTrunks_Yellow", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresUnderwearWoman = {
		isShop = true,
		rolls = 4,
		items = {
			"Bra_Strapless_AnimalPrint", 8,
			"Bra_Strapless_Black", 10,
			"Bra_Strapless_FrillyBlack", 2,
			"Bra_Strapless_FrillyPink", 2,
			"Bra_Strapless_RedSpots", 8,
			"Bra_Strapless_White", 10,
			"Bra_Straps_AnimalPrint", 8,
			"Bra_Straps_Black", 20,
			"Bra_Straps_Black", 10,
			"Bra_Straps_FrillyBlack", 2,
			"Bra_Straps_FrillyPink", 2,
			"Bra_Straps_White", 20,
			"Bra_Straps_White", 10,
			"Corset", 2,
			"Corset_Black", 2,
			"FrillyUnderpants_Black", 4,
			"FrillyUnderpants_Pink", 4,
			"FrillyUnderpants_Red", 4,
			"Garter", 2,
			"StockingsBlack", 6,
			"StockingsBlackSemiTrans", 6,
			"StockingsBlackTrans", 6,
			"StockingsWhite", 6,
			"TightsBlack", 4,
			"TightsBlackSemiTrans", 4,
			"TightsBlackTrans", 4,
			"TightsFishnets", 2,
			"Underpants_Black", 20,
			"Underpants_Black", 10,
			"Underpants_White", 20,
			"Underpants_White", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresUnderwearMan = {
		isShop = true,
		rolls = 4,
		items = {
			"Boxers_Hearts", 8,
			"Boxers_RedStripes", 8,
			"Boxers_White", 20,
			"Boxers_White", 10,
			"Briefs_White", 20,
			"Briefs_White", 10,
			"Boxers_Silk_Black", 4,
			"Boxers_Silk_Red", 4,
			"Briefs_AnimalPrints", 8,
			"Briefs_SmallTrunks_Black", 2,
			"Briefs_SmallTrunks_Blue", 2,
			"Briefs_SmallTrunks_Red", 2,
			"Briefs_SmallTrunks_WhiteTINT", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ClothingStoresWoman = {
		rolls = 4,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ComicStoreCounter = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_BlueFox", 1,
			"KeyRing_Bug", 1,
			"KeyRing_Hotdog", 1,
			"KeyRing_Kitty", 1,
			"KeyRing_RainbowStar", 1,
			"KeyRing_RubberDuck", 1,
			-- Literature
			"ArmorMag1", 1,
			"ArmorMag3", 1,
			"ArmorMag4", 1,
			"ArmorMag5", 1,
			"ArmorMag6", 1,
			"TrickMag1", 1,
			"WeaponMag1", 1,
			"WeaponMag4", 1,
			"WeaponMag6", 1,
			-- Misc.
			"CigarBox_Gaming", 1,
			"ComicBook", 20,
			"CopperCup", 0.5,
			"Hat_HalloweenMaskDevil", 0.1,
			"Hat_HalloweenMaskMonster", 0.1,
			"Hat_HalloweenMaskPumpkin", 0.1,
			"Hat_HalloweenMaskSkeleton", 0.1,
			"Hat_HalloweenMaskVampire", 0.1,
			"Hat_HalloweenMaskWitch", 0.1,
			"Hat_Pirate", 0.1,
			"Hat_Witch", 0.1,
			"Hat_Wizard", 0.1,
			"MetalCup", 1,
			"Paperback_Fantasy", 20,
			"Paperback_SciFi", 20,
			"Plasticbag", 20,
			"Plasticbag", 10,
			"RPGmanual", 8,
			"TarotCardDeck", 8,
			"VideoGame", 10,
			
		},
		junk = {
			rolls = 1,
			items = {
				"Katana", 0.001,
				"Mace", 0.001,
				"Sword", 0.001,
			}
		}
	},
	
	ComicStoreDisplayBooks = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Fantasy", 20,
			"Book_Fantasy", 10,
			"Book_Occult", 20,
			"Book_Occult", 10,
			"Book_SciFi", 20,
			"Book_SciFi", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Book_Fantasy", 8,
				"Book_Occult", 8,
				"Book_SciFi", 8,
			}
		}
	},
	
	ComicStoreDisplayComics = {
		isShop = true,
		rolls = 4,
		items = {
			"ComicBook", 50,
			"ComicBook", 20,
			"ComicBook", 20,
			"ComicBook", 10,
			"ComicBook", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"ComicBook", 10,
			}
		}
	},
	
	ComicStoreDisplayDice = {
		isShop = true,
		rolls = 4,
		items = {
			-- Dice
			"Dice", 20,
			"Dice_00", 20,
			"Dice_10", 20,
			"Dice_12", 20,
			"Dice_20", 50,
			"Dice_4", 20,
			"Dice_6", 20,
			"Dice_8", 20,
			-- Dicebags
			"DiceBag", 20,
			"DiceBag", 10,
			-- Misc.
			"RPGmanual", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Dice", 1,
				"Dice_00", 1,
				"Dice_10", 1,
				"Dice_12", 1,
				"Dice_20", 1,
				"Dice_4", 1,
				"Dice_6", 1,
				"Dice_8", 1,
				"DiceBag", 4,
			}
		}
	},
	
	ComicStoreMagazines = {
		isShop = true,
		rolls = 4,
		items = {
			"Magazine_Cinema_New", 20,
			"Magazine_Gaming_New", 20,
			"Magazine_Hobby_New", 20,
			"Magazine_Horror_New", 10,
			"Magazine_Humor_New", 20,
			"Magazine_Teens_New", 10,
			"ArmorMag1", 0.05,
			"TrickMag1", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"ComicBook", 10,
			}
		}
	},
	
	ComicStoreShelfGames = {
		isShop = true,
		rolls = 4,
		items = {
			"GraphPaper", 50,
			"RPGmanual", 50,
			"RPGmanual", 20,
			"RPGmanual", 20,
			"RPGmanual", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"RPGmanual", 10,
			}
		}
	},
	
	ComicStoreShelfComics = {
		isShop = true,
		rolls = 4,
		items = {
			"ComicBook_Retail", 50,
			"ComicBook_Retail", 20,
			"ComicBook_Retail", 20,
			"ComicBook_Retail", 10,
			"ComicBook_Retail", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"ComicBook_Retail", 10,
			}
		}
	},
	
	ComicStoreShelfFantasy = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Fantasy", 8,
			"Paperback_Fantasy", 20,
			"Paperback_Fantasy", 20,
			"Paperback_Fantasy", 10,
			"Paperback_Fantasy", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Paperback_Fantasy", 10,
			}
		}
	},
	
	ComicStoreShelfSciFi = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_SciFi", 8,
			"Paperback_SciFi", 20,
			"Paperback_SciFi", 20,
			"Paperback_SciFi", 10,
			"Paperback_SciFi", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Paperback_SciFi", 10,
			}
		}
	},
	
	ConstructionWorkerOutfit = {
		rolls = 3,
		items = {
			"BookCarpentry1", 3,
			"BookCarpentry2", 2,
			"BookCarpentry3", 1,
			"BookCarpentry4", 0.5,
			"BookCarpentry5", 0.25,
			"BookMetalWelding1", 3,
			"BookMetalWelding2", 2,
			"BookMetalWelding3", 1,
			"BookMetalWelding4", 0.5,
			"BookMetalWelding5", 0.25,
			"DuctTape", 4,
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 8,
			"Gloves_LeatherGloves", 1,
			"Handiknife", 1,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_HardHat", 4,
			"Kneepad_Left_Workman", 4,
			"KnifePocket", 1,
			"MarkerBlack", 4,
			"Multitool", 0.1,
			"Notepad", 10,
			"Pencil", 10,
			"RippedSheets", 10,
			"Shirt_Lumberjack", 8,
			"Shirt_Lumberjack_TINT", 8,
			"Shoes_WorkBoots", 8,
			"Toolbox", 2,
			"Trousers_Denim", 10,
			"Tshirt_DefaultTEXTURE_TINT", 6,
			"Vest_DefaultTEXTURE_TINT", 6,
			"Vest_HighViz", 10,
			"WeldingMask", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ConstructionWorkerTools = {
		rolls = 3,
		items = {
			"BallPeenHammer", 8,
			"BlowTorch", 10,
			"BoltCutters", 8,
			"BookCarpentry1", 3,
			"BookCarpentry2", 2,
			"BookCarpentry3", 1,
			"BookCarpentry4", 0.5,
			"BookCarpentry5", 0.25,
			"BookMetalWelding1", 3,
			"BookMetalWelding2", 2,
			"BookMetalWelding3", 1,
			"BookMetalWelding4", 0.5,
			"BookMetalWelding5", 0.25,
			"CarpentryChisel", 4,
			"CircularSawblade", 4,
			"ClubHammer", 4,
			"DuctTape", 4,
			"ElectricWire", 6,
			"Epoxy", 1,
			"FiberglassTape", 1,
			"Hammer", 8,
			"HandDrill", 4,
			"Handiknife", 1,
			"KnifePocket", 1,
			"MeasuringTape", 10,
			"Multitool", 0.1,
			"NailsBox", 10,
			"Notepad", 10,
			"NutsBolts", 10,
			"Oxygen_Tank", 1,
			"Pencil", 10,
			"Propane_Refill", 1,
			"RippedSheets", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"SheetMetalSnips", 4,
			"Toolbox", 2,
			"Twine", 10,
			"WeldingRods", 4,
			"Whetstone", 10,
			"WoodenMallet", 4,
			"Woodglue", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ControlRoomCounter = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- TODO: Sort Me!
			"Battery", 10,
			"BatteryBox", 1,
			"BluePen", 8,
			"Book_Computer", 4,
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"Calculator", 8,
			"Clipboard", 8,
			"CopperScrap", 10,
			"ElectricWire", 20,
			"ElectricWire", 10,
			"ElectronicsScrap", 20,
			"ElectronicsScrap", 10,
			"Epoxy", 2,
			"FlashLight_AngleHead", 1,
			"GreenPen", 4,
			"HamRadio1", 1,
			"HandTorch", 8,
			"Magazine_Tech", 10,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Notepad", 8,
			"Paperback_Computer", 8,
			"Pen", 8,
			"PenFancy", 0.5,
			"RadioBlack", 6,
			"RadioRed", 4,
			"RedPen", 8,
			"Screwdriver", 10,
			"Torch", 4,
			"WalkieTalkie4", 4,
			"WalkieTalkie4", 4,
			"WalkieTalkie5", 1,
			"WalkieTalkie5", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CortmanOfficeBooks = {
		rolls = 4,
		items = {
			"BookFancy_Medical", 20,
			"BookFancy_Medical", 20,
			"BookFancy_Medical", 10,
			"BookFancy_Medical", 10,
			"BookFirstAid1", 10,
			"BookFirstAid2", 8,
			"BookFirstAid3", 6,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			"Mov_DegreeDoctor", 4,
			"Mov_DegreeSurgeon", 4,
			"Phonebook", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	CortmanOfficeDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Medical
			"AdhesiveBandageBox", 0.5,
			"AlcoholWipes", 4,
			"Bandage", 1,
			"BandageBox", 0.1,
			"Bandaid", 4,
			"CottonBalls", 4,
			"CottonBallsBox", 0.1,
			"Disinfectant", 1,
			"Gloves_Surgical", 4,
			"Hat_SurgicalMask", 4,
			"Pills", 4,
			"PillsVitamins", 1,
			"TongueDepressor", 4,
			"TongueDepressorBox", 0.1,
			-- Literature
			"BookFancy_Medical", 4,
			"Diary2", 0.1,
			"Magazine_Health", 10,
			"Paperback_Fiction", 4,
			"Paperback_Medical", 8,
			-- Stationery/Office
			"Paperwork", 20,
			"Paperwork", 10,
			"PenLight", 4,
			-- Misc.
			"Flask", 0.1,
			"Gum", 4,
			"IndexCard", 10,
			"MenuCard", 10,
			"Whiskey", 0.1,
			-- Story Items
			"CortmanPic", 0.001,
		},
		junk = ClutterTables.DeskJunk,
	},
	
	CortmanOfficeSidetable = {
		rolls = 4,
		items = {
			"Magazine_Health", 50,
			"Magazine_Health", 20,
			"Phonebook", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	CrateAnimalFeed = {
		rolls = 4,
		items = {
			"AnimalFeedBag", 50,
			"AnimalFeedBag", 20,
			"AnimalFeedBag", 20,
			"AnimalFeedBag", 10,
			"AnimalFeedBag", 10,
			"WheatSheafDried", 10,
			"WheatSack", 20,
			"WheatSeed", 10,
			"WheatSeedSack", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateAntiqueStove = {
		rolls = 1,
		items = {
			"Mov_AntiqueStove", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBakingSoda = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BakingSoda", 50,
			"BakingSoda", 20,
			"BakingSoda", 20,
			"BakingSoda", 10,
			"BakingSoda", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBaseballs = {
		isShop = true,
		rolls = 4,
		items = {
			"Baseball", 50,
			"Baseball", 20,
			"Baseball", 20,
			"Baseball", 10,
			"Baseball", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBasketballs = {
		isShop = true,
		rolls = 4,
		items = {
			"Basketball", 50,
			"Basketball", 20,
			"Basketball", 20,
			"Basketball", 10,
			"Basketball", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBatteries = {
		rolls = 4,
		isShop = true,
		items = {
			"BatteryBox", 50,
			"BatteryBox", 20,
			"BatteryBox", 20,
			"BatteryBox", 10,
			"BatteryBox", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBeer = {
		isShop = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BeerBottle", 20,
			"BeerBottle", 10,
			"BeerCan", 20,
			"BeerCan", 10,
			"BeerCanPack", 0.5,
			"BeerImported", 8,
			"BeerPack", 0.5,
			"Cider", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},


	CrateBibles = {
		rolls = 4,
		items = {
			-- Bibles
			"Book_Bible", 20,
			"Book_Bible", 10,
			"BookFancy_Bible", 4,
			"Paperback_Bible", 20,
			"Paperback_Bible", 20,
			"Paperback_Bible", 20,
			"Paperback_Bible", 10,
			-- Crucifixes
			"Necklace_Crucifix", 8,
			"Necklace_SilverCrucifix", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBlackBBQ = {
		rolls = 4,
		items = {
			"Apron_BBQ", 8,
			"BastingBrush", 10,
			"CarvingFork2", 10,
			"GrillBrush", 10,
			"KitchenTongs", 10,
			"LighterBBQ", 4,
			"OvenMitt", 10,
			"PropaneTank", 1,
			"Spatula", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_BlackBBQ", 200,
			}
		}
	},
	
	CrateBlacksmithing = {
		rolls = 4,
		items = {
			-- Tools
			"BallPeenHammer", 8,
			"Bellows", 8,
			"BucketLargeWood", 4,
			"Calipers", 2,
			"CeramicCrucible", 4,
			"CrudeBenchVise", 1,
			"DrawPlate", 8,
			"File", 8,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 4,
			"MetalworkingPunch", 8,
			"SheetMetalSnips", 4,
			"SmallFileSet", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"SmithingHammer", 8,
			"Tongs", 8,
			-- Components
			"BenchAnvil", 1,
			"BlacksmithAnvil", 1,
			"BlowerFan", 2,
			"IronBand", 1,
			"IronBandSmall", 4,
			"IronIngotMold", 2,
			"Mov_ElectricBlowerForge", 1,
			"IronBarMold", 2,
			"SteelBarMold", 1,
			-- Materials
			"IronBar", 4,
			"IronBarHalf", 6,
			"IronPiece", 10,
			"IronBarQuarter", 8,
			"SteelBar", 4,
			"SteelBarHalf", 6,
			"SteelPiece", 10,
			"SteelBarQuarter", 8,
			"SteelIngotMold", 1,
			-- Literature
			"BookBlacksmith1", 2,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 0.5,
			"BookBlacksmith4", 0.1,
			"BookBlacksmith5", 0.05,
			"BSToolsSchematic", 10,
			"CookwareSchematic", 10,
			"SmithingMag1", 4,
			"SmithingMag2", 4,
			"SmithingMag3", 4,
			"SmithingMag4", 4,
			"SmithingMag5", 4,
			"SmithingMag6", 4,
			"SmithingMag7", 4,
			"SmithingMag8", 4,
			"SmithingMag9", 4,
			"SmithingMag10", 4,
			"SmithingMag11", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBlueComfyChair = {
		rolls = 1,
		items = {
			"Mov_BlueComfyChair", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBluePlasticChairs = {
		rolls = 4,
		items = {
			"Mov_BluePlasticChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_BluePlasticChair", 200,
			}
		}
	},
	
	CrateBlueRattanChair = {
		rolls = 1,
		items = {
			"Mov_BlueRattanChair", 200,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	-- Crate of military boots.
	CrateBootsArmy = {
		rolls = 4,
		items = {
			"Shoes_ArmyBoots", 50,
			"Shoes_ArmyBoots", 20,
			"Shoes_ArmyBoots", 20,
			"Shoes_ArmyBoots", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Same as above. Desert variant.
	CrateBootsArmyDesert = {
		rolls = 4,
		items = {
			"Shoes_ArmyBootsDesert", 50,
			"Shoes_ArmyBootsDesert", 20,
			"Shoes_ArmyBootsDesert", 20,
			"Shoes_ArmyBootsDesert", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Old work boots.
	CrateBootsOld = {
		isWorn = true,
		rolls = 4,
		items = {
			"Shoes_WorkBoots", 50,
			"Shoes_WorkBoots", 20,
			"Shoes_WorkBoots", 20,
			"Shoes_WorkBoots", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBooks = {
		rolls = 4,
		items = {
			"Book_AdventureNonFiction", 2,
			"Book_Art", 1,
			"Book_Biography", 2,
			"Book_Business", 1,
			"Book_Childs", 2,
			"Book_Cinema", 1,
			"Book_Computer", 1,
			"Book_CrimeFiction", 2,
			"Book_Fantasy", 2,
			"Book_Farming", 1,
			"Book_Fashion", 2,
			"Book_Fiction", 4,
			"Book_GeneralNonFiction", 2,
			"Book_GeneralReference", 1,
			"Book_History", 1,
			"Book_Horror", 2,
			"Book_Legal", 1,
			"Book_LiteraryFiction", 2,
			"Book_Medical", 1,
			"Book_MilitaryHistory", 1,
			"Book_Music", 1,
			"Book_Nature", 1,
			"Book_Occult", 1,
			"Book_Politics", 1,
			"Book_Religion", 1,
			"Book_Romance", 2,
			"Book_SadNonFiction", 2,
			"Book_Science", 1,
			"Book_SciFi", 2,
			"Book_Sports", 2,
			"Book_Thriller", 2,
			"Book_Travel", 1,
			"Book_Western", 2,
			"BookAiming1", 0.6,
			"BookAiming2", 0.4,
			"BookAiming3", 0.2,
			"BookAiming4", 0.1,
			"BookAiming5", 0.05,
			"BookBlacksmith1", 6,
			"BookBlacksmith2", 4,
			"BookBlacksmith3", 2,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookButchering1", 6,
			"BookButchering2", 4,
			"BookButchering3", 2,
			"BookButchering4", 1,
			"BookButchering5", 0.5,
			"BookCarpentry1", 6,
			"BookCarpentry2", 4,
			"BookCarpentry3", 2,
			"BookCarpentry4", 1,
			"BookCarpentry5", 0.5,
			"BookCarving1", 6,
			"BookCarving2", 4,
			"BookCarving3", 2,
			"BookCarving4", 1,
			"BookCarving5", 0.5,
			"BookCooking1", 6,
			"BookCooking2", 4,
			"BookCooking3", 2,
			"BookCooking4", 1,
			"BookCooking5", 0.5,
			"BookElectrician1", 6,
			"BookElectrician2", 4,
			"BookElectrician3", 2,
			"BookElectrician4", 1,
			"BookElectrician5", 0.5,
			"BookFarming1", 6,
			"BookFarming2", 4,
			"BookFarming3", 2,
			"BookFarming4", 1,
			"BookFarming5", 0.5,
			"BookFirstAid1", 6,
			"BookFirstAid2", 4,
			"BookFirstAid3", 2,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"BookFishing1", 6,
			"BookFishing2", 4,
			"BookFishing3", 2,
			"BookFishing4", 1,
			"BookFishing5", 0.5,
			"BookFlintKnapping1", 0.6,
			"BookFlintKnapping2", 0.4,
			"BookFlintKnapping3", 0.2,
			"BookFlintKnapping4", 0.1,
			"BookFlintKnapping5", 0.05,
			"BookForaging1", 6,
			"BookForaging2", 4,
			"BookForaging3", 2,
			"BookForaging4", 1,
			"BookForaging5", 0.5,
			"BookGlassmaking1", 6,
			"BookGlassmaking2", 4,
			"BookGlassmaking3", 2,
			"BookGlassmaking4", 1,
			"BookGlassmaking5", 0.5,
			"BookHusbandry1", 6,
			"BookHusbandry2", 4,
			"BookHusbandry3", 2,
			"BookHusbandry4", 1,
			"BookHusbandry5", 0.5,
			"BookLongBlade1", 0.6,
			"BookLongBlade2", 0.4,
			"BookLongBlade3", 0.2,
			"BookLongBlade4", 0.1,
			"BookLongBlade5", 0.05,
			"BookMaintenance1", 6,
			"BookMaintenance2", 4,
			"BookMaintenance3", 2,
			"BookMaintenance4", 1,
			"BookMaintenance5", 0.5,
			"BookMasonry1", 6,
			"BookMasonry2", 4,
			"BookMasonry3", 2,
			"BookMasonry4", 1,
			"BookMasonry5", 0.5,
			"BookMechanic1", 6,
			"BookMechanic2", 4,
			"BookMechanic3", 2,
			"BookMechanic4", 1,
			"BookMechanic5", 0.5,
			"BookMetalWelding1", 6,
			"BookMetalWelding2", 4,
			"BookMetalWelding3", 2,
			"BookMetalWelding4", 1,
			"BookMetalWelding5", 0.5,
			"BookPottery1", 6,
			"BookPottery2", 4,
			"BookPottery3", 2,
			"BookPottery4", 1,
			"BookPottery5", 0.5,
			"BookReloading1", 0.6,
			"BookReloading2", 0.4,
			"BookReloading3", 0.2,
			"BookReloading4", 0.1,
			"BookReloading5", 0.05,
			"BookTailoring1", 6,
			"BookTailoring2", 4,
			"BookTailoring3", 2,
			"BookTailoring4", 1,
			"BookTailoring5", 0.5,
			"BookTracking1", 6,
			"BookTracking2", 4,
			"BookTracking3", 2,
			"BookTracking4", 1,
			"BookTracking5", 0.5,
			"BookTrapping1", 6,
			"BookTrapping2", 4,
			"BookTrapping3", 2,
			"BookTrapping4", 1,
			"BookTrapping5", 0.5,
			"Paperback_AdventureNonFiction", 2,
			"Paperback_Art", 1,
			"Paperback_Biography", 1,
			"Paperback_Business", 1,
			"Paperback_Childs", 2,
			"Paperback_Cinema", 1,
			"Paperback_Computer", 1,
			"Paperback_CrimeFiction", 2,
			"Paperback_Diet", 2,
			"Paperback_Fantasy", 2,
			"Paperback_Fashion", 2,
			"Paperback_Fiction", 4,
			"Paperback_History", 1,
			"Paperback_Horror", 2,
			"Paperback_Legal", 1,
			"Paperback_LiteraryFiction", 2,
			"Paperback_Medical", 1,
			"Paperback_MilitaryHistory", 1,
			"Paperback_Music", 1,
			"Paperback_Nature", 1,
			"Paperback_NewAge", 1,
			"Paperback_Occult", 1,
			"Paperback_Politics", 1,
			"Paperback_Relationship", 2,
			"Paperback_Religion", 2,
			"Paperback_Romance", 2,
			"Paperback_SadNonFiction", 2,
			"Paperback_Scary", 2,
			"Paperback_Science", 1,
			"Paperback_SciFi", 2,
			"Paperback_SelfHelp", 2,
			"Paperback_Sexy", 2,
			"Paperback_Sports", 2,
			"Paperback_Thriller", 2,
			"Paperback_Travel", 2,
			"Paperback_TrueCrime", 2,
			"Paperback_Western", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBooksSchool = {
		rolls = 4,
		items = {
			"Book_SchoolTextbook", 50,
			"Book_SchoolTextbook", 50,
			"Book_SchoolTextbook", 20,
			"Book_SchoolTextbook", 20,
			"BookBlacksmith1", 1,
			"BookBlacksmith2", 0.5,
			"BookBlacksmith3", 0.1,
			"BookButchering1", 1,
			"BookButchering2", 0.5,
			"BookButchering3", 0.1,
			"BookCarpentry1", 1,
			"BookCarpentry2", 0.5,
			"BookCarpentry3", 0.1,
			"BookCarving1", 1,
			"BookCarving2", 0.5,
			"BookCarving3", 0.1,
			"BookCooking1", 1,
			"BookCooking2", 0.5,
			"BookCooking3", 0.1,
			"BookElectrician1", 1,
			"BookElectrician2", 0.5,
			"BookElectrician3", 0.1,
			"BookFarming1", 1,
			"BookFarming2", 0.5,
			"BookFarming3", 0.1,
			"BookFirstAid1", 1,
			"BookFirstAid2", 0.5,
			"BookFirstAid3", 0.1,
			"BookFishing1", 1,
			"BookFishing2", 0.5,
			"BookFishing3", 0.1,
			"BookForaging1", 1,
			"BookForaging2", 0.5,
			"BookForaging3", 0.1,
			"BookGlassmaking1", 1,
			"BookGlassmaking2", 0.5,
			"BookGlassmaking3", 0.1,
			"BookHusbandry1", 1,
			"BookHusbandry2", 0.5,
			"BookHusbandry3", 0.1,
			"BookMaintenance1", 1,
			"BookMaintenance2", 0.5,
			"BookMaintenance3", 0.1,
			"BookMasonry1", 1,
			"BookMasonry2", 0.5,
			"BookMasonry3", 0.1,
			"BookMechanic1", 1,
			"BookMechanic2", 0.5,
			"BookMechanic3", 0.1,
			"BookMetalWelding1", 1,
			"BookMetalWelding2", 0.5,
			"BookMetalWelding3", 0.1,
			"BookPottery1", 1,
			"BookPottery2", 0.5,
			"BookPottery3", 0.1,
			"BookTailoring1", 1,
			"BookTailoring2", 0.5,
			"BookTailoring3", 0.1,
			"BookTracking1", 1,
			"BookTracking2", 0.5,
			"BookTracking3", 0.1,
			"BookTrapping1", 1,
			"BookTrapping2", 0.5,
			"BookTrapping3", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBrownComfyChair = {
		rolls = 1,
		items = {
			"Mov_BrownComfyChair", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBrownLowTables = {
		rolls = 4,
		items = {
			"Mov_BrownLowTable", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_BrownLowTable", 200,
			}
		}
	},
	
	CrateBunsBurger = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BunsHamburger", 50,
			"BunsHamburger", 20,
			"BunsHamburger", 20,
			"BunsHamburger", 10,
			"BunsHamburger", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateBunsHotdog = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BunsHotdog", 50,
			"BunsHotdog", 20,
			"BunsHotdog", 20,
			"BunsHotdog", 10,
			"BunsHotdog", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateButter = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Butter", 50,
			"Butter", 20,
			"Butter", 20,
			"Butter", 10,
			"Butter", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCameraFilm = {
		isShop = true,
		rolls = 4,
		items = {
			"CameraFilm", 50,
			"CameraFilm", 20,
			"CameraFilm", 20,
			"CameraFilm", 10,
			"CameraFilm", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCamping = {
		rolls = 4,
		items = {
			"Bag_ALICEpack", 0.01,
			"Bag_BigHikingBag", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_HydrationBackpack", 0.01,
			"Bag_LeatherWaterBag", 1,
			"Bag_NormalHikingBag", 1,
			"BookFishing1", 2,
			"BookFishing2", 1,
			"BookFishing3", 0.5,
			"BookFishing4", 0.1,
			"BookFishing5", 0.05,
			"BookForaging1", 2,
			"BookForaging2", 1,
			"BookForaging3", 0.5,
			"BookForaging4", 0.1,
			"BookForaging5", 0.05,
			"BookTrapping1", 2,
			"BookTrapping2", 1,
			"BookTrapping3", 0.5,
			"BookTrapping4", 0.1,
			"BookTrapping5", 0.05,
			"Book_Nature", 4,
			"Book_Travel", 4,
			"Canteen", 10,
			"CompassDirectional", 10,
			"Cooler", 1,
			"CopperCup", 0.5,
			"DryFirestarterBlock", 10,
			"Dungarees", 0.5,
			"FirstAidKit_Camping", 4,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"FlashLight_AngleHead", 1,
			"HandAxe", 4,
			"Handiknife", 1,
			"Hat_Beany", 10,
			"HerbalistMag", 1,
			"HoodieDOWN_WhiteTINT", 10,
			"HuntingKnife", 4,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"IceAxe", 1,
			"InsectRepellent", 10,
			"Jacket_ArmyCamoGreen", 1,
			"Jacket_PaddedDOWN", 8,
			"KnifePocket", 1,
			"Lantern_Hurricane", 1,
			"Lantern_Propane", 4,
			"LargeKnife", 1,
			"LongJohns", 10,
			"LongJohns_Bottoms", 10,
			"Magazine_Outdoors", 10,
			"MagnesiumFirestarter", 10,
			"Matchbox", 20,
			"MetalCup", 1,
			"Multitool", 0.01,
			"P38", 10,
			"Paperback_Nature", 8,
			"Paperback_Travel", 8,
			"PonchoGreenDOWN", 2,
			"Propane_Refill", 8,
			"Rope", 10,
			"ShemaghScarf", 0.01,
			"Shirt_CamoGreen", 2,
			"Shirt_CamoGreen", 2,
			"Shirt_Lumberjack", 1,
			"Shirt_Lumberjack_TINT", 1,
			"Shoes_HikingBoots", 2,
			"Shoes_Wellies", 0.5,
			"Shorts_CamoGreenLong", 2,
			"SleepingBag_BluePlaid_Packed", 2,
			"SleepingBag_Camo_Packed", 1,
			"SleepingBag_Cheap_Blue_Packed", 4,
			"SleepingBag_Cheap_Green2_Packed", 4,
			"SleepingBag_Cheap_Green_Packed", 4,
			"SleepingBag_GreenPlaid_Packed", 2,
			"SleepingBag_Green_Packed", 2,
			"SleepingBag_HighQuality_Brown_Packed", 1,
			"SleepingBag_Spiffo_Packed", 0.05,
			"SleepingBag_RedPlaid_Packed", 2,
			"SmallKnife", 4,
			"Socks_Heavy", 4,
			"Spork", 1,
			"Stake", 10,
			"Stake", 20,
			"Tarp", 10,
			"Tarp", 20,
			"TentBlue_Packed", 1,
			"TentBrown_Packed", 1,
			"TentGreen_Packed", 1,
			"TentYellow_Packed", 1,
			"Trousers_CamoGreen", 2,
			"Trousers_Padded", 6,
			"Tshirt_ArmyGreen", 2,
			"Tshirt_CamoGreen", 2,
			"Vest_Hunting_Camo", 0.5,
			"Vest_Hunting_CamoGreen", 0.5,
			"Vest_Hunting_Grey", 0.1,
			"Vest_Hunting_Orange", 0.5,
			"WaterPurificationTablets", 1,
			"Whetstone", 10,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCandyPackage = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CandyPackage", 50,
			"CandyPackage", 20,
			"CandyPackage", 20,
			"CandyPackage", 10,
			"CandyPackage", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCannedFood = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CannedBolognese", 6,
			"CannedBolognese_Box", 0.06,
			"CannedCarrots2", 4,
			"CannedCarrots_Box", 0.04,
			"CannedChili", 6,
			"CannedChili_Box", 0.06,
			"CannedCorn", 4,
			"CannedCorn_Box", 0.04,
			"CannedCornedBeef", 6,
			"CannedCornedBeef_Box", 0.06,
			"CannedFruitBeverage", 6,
			"CannedFruitBeverage_Box", 0.06,
			"CannedFruitCocktail", 6,
			"CannedFruitCocktail_Box", 0.06,
			"CannedMilk", 2,
			"CannedMilk_Box", 0.02,
			"CannedMushroomSoup", 6,
			"CannedMushroomSoup_Box", 0.06,
			"CannedPeaches", 4,
			"CannedPeaches_Box", 0.04,
			"CannedPeas", 4,
			"CannedPeas_Box", 0.04,
			"CannedPineapple", 4,
			"CannedPineapple_Box", 0.04,
			"CannedPotato2", 4,
			"CannedPotato_Box", 0.04,
			"CannedSardines", 6,
			"CannedSardines_Box", 0.06,
			"CannedTomato2", 4,
			"CannedTomato_Box", 0.04,
			"DentedCan", 1,
			"MysteryCan", 8,
			"MysteryCan_Box", 0.1,
			"TinnedBeans", 6,
			"TinnedBeans_Box", 0.06,
			"TinnedSoup", 6,
			"TinnedSoup_Box", 0.06,
			"TunaTin", 6,
			"TunaTin_Box", 0.06,
			"WaterRationCan_Box", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCannedFoodSpoiled = {
		rolls = 4,
		items = {
			"Cockroach", 6,
			"Cockroach", 6,
			"DeadRat", 4,
			"DeadMouse", 2,
			"DentedCan", 4,
			"MysteryCan", 2,
			"TinCanEmpty", 10,
			"TinCanEmpty", 10,
			"TinCanEmpty", 10,
			"TinCanEmpty", 10,
			"WaterBottleEmpty", 6,
			"WaterBottleEmpty", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Jarred, technically.
	CrateCannedTomato = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CannedTomato", 50,
			"CannedTomato", 20,
			"CannedTomato", 20,
			"CannedTomato", 10,
			"CannedTomato", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCanning = {
		rolls = 4,
		items = {
			"BoxOfJars", 4,
			"EmptyJar", 20,
			"EmptyJar", 20,
			"EmptyJar", 10,
			"EmptyJar", 10,
			"JarLid", 20,
			"JarLid", 20,
			"JarLid", 10,
			"JarLid", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCarpentry = {
		rolls = 4,
		items = {
			"Axe", 0.05,
			"BookCarpentry1", 2,
			"BookCarpentry2", 1,
			"BookCarpentry3", 0.5,
			"BookCarpentry4", 0.1,
			"BookCarpentry5", 0.05,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"BookMaintenance4", 0.1,
			"BookMaintenance5", 0.05,
			"CarpentryChisel", 8,
			"CircularSawblade", 4,
			"ClubHammer", 4,
			"Doorknob", 2,
			"DuctTape", 8,
			"ElbowPad_Left_Workman", 1,
			"Epoxy", 2,
			"GardenSaw", 10,
			"Glasses_SafetyGoggles", 8,
			"Hammer", 8,
			"HandAxe", 2,
			"HandDrill", 4,
			"Handle", 8,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_HardHat", 4,
			"Hinge", 4,
			"Kneepad_Left_Workman", 4,
			"Latch", 1,
			"LongHandle", 4,
			"LongStick", 4,
			"MeasuringTape", 10,
			"NailsBox", 20,
			"NailsBox", 10,
			"NailsCarton", 1,
			"Plank", 20,
			"Plank", 20,
			"Plank", 10,
			"Plank", 10,
			"RespiratorFilters", 2,
			"Saw", 8,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.5,
			"SmallHandle", 8,
			"Twine", 10,
			"Whetstone", 10,
			"WoodAxe", 0.025,
			"WoodenMallet", 4,
			"WoodenStick2", 8,
			"Woodglue", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCereal = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Cereal", 50,
			"Cereal", 20,
			"Cereal", 20,
			"Cereal", 10,
			"Cereal", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCharcoal = {
		isShop = true,
		isShop = true,
		rolls = 4,
		items = {
			"Charcoal", 50,
			"Charcoal", 20,
			"Charcoal", 20,
			"Charcoal", 10,
			"Charcoal", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateChestFreezer = {
		rolls = 1,
		items = {
			"Mov_ChestFreezer", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateChips = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Crisps", 20,
			"Crisps", 10,
			"Crisps2", 20,
			"Crisps2", 10,
			"Crisps3", 20,
			"Crisps3", 10,
			"Crisps4", 20,
			"Crisps4", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateChocolate = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Chocolate", 50,
			"Chocolate", 20,
			"Chocolate", 20,
			"Chocolate", 10,
			"Chocolate", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateChocolateChips = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"ChocolateChips", 50,
			"ChocolateChips", 20,
			"ChocolateChips", 20,
			"ChocolateChips", 10,
			"ChocolateChips", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateChromeSinks = {
		rolls = 4,
		items = {
			"Mov_ChromeSink", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_ChromeSink", 200,
			}
		}
	},
	
	-- Super rare!
	CrateCigarettes = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CigaretteCarton", 20,
			"CigaretteCarton", 20,
			"CigaretteCarton", 10,
			"CigaretteCarton", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateClayBags = {
		isShop = true,
		rolls = 4,
		items = {
			"Claybag", 50,
			"Claybag", 20,
			"Claybag", 20,
			"Claybag", 10,
			"Claybag", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateClayBricks = {
		isShop = true,
		rolls = 8,
		items = {
			"ClayBrick", 50,
			"ClayBrick", 20,
			"ClayBrick", 20,
			"ClayBrick", 10,
			"ClayBrick", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateClothesRandom = {
		rolls = 4,
		items = {
			"Belt2", 4,
			"Bikini_Pattern01", 1,
			"Bikini_TINT", 1,
			"BoobTube", 2,
			"BoobTubeSmall", 2,
			"Boxers_Hearts", 1,
			"Boxers_RedStripes", 1,
			"Boxers_Silk_Black", 0.1,
			"Boxers_Silk_Red", 0.1,
			"Boxers_White", 4,
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
			"Briefs_AnimalPrints", 1,
			"Briefs_SmallTrunks_Black", 0.1,
			"Briefs_SmallTrunks_Blue", 0.1,
			"Briefs_SmallTrunks_Red", 0.1,
			"Briefs_SmallTrunks_WhiteTINT", 0.5,
			"Briefs_White", 4,
			"Corset", 1,
			"Corset_Black", 1,
			"DressKnees_Straps", 1,
			"Dress_Knees", 2,
			"Dress_Long", 2,
			"Dress_Normal", 2,
			"Dress_Short", 2,
			"Dress_SmallBlackStrapless", 1,
			"Dress_SmallBlackStraps", 1,
			"Dress_SmallStrapless", 1,
			"Dress_SmallStraps", 1,
			"Dress_Straps", 1,
			"Dress_long_Straps", 1,
			"Dungarees", 0.1,
			"FrillyUnderpants_Black", 1,
			"FrillyUnderpants_Pink", 1,
			"FrillyUnderpants_Red", 1,
			"Garter", 1,
			"Gloves_FingerlessGloves", 1,
			"Gloves_LeatherGloves", 0.6,
			"Gloves_LeatherGlovesBlack", 0.4,
			"Gloves_LongWomenGloves", 0.4,
			"Gloves_WhiteTINT", 1,
			"Hat_BalaclavaFace", 0.1,
			"Hat_BalaclavaFull", 0.1,
			"Hat_Bandana", 0.1,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.5,
			"Hat_Beret", 0.5,
			"Hat_BucketHat", 0.5,
			"Hat_Cowboy", 0.1,
			"Hat_EarMuffs", 0.1,
			"Hat_Fedora", 0.05,
			"Hat_Fedora_Delmonte", 0.01,
			"Hat_GolfHat", 0.8,
			"Hat_GolfHatTINT", 0.5,
			"Hat_StrawHat", 0.1,
			"Hat_SummerHat", 0.1,
			"Hat_SummerFlowerHat", 0.1,
			"Hat_Sweatband", 1,
			"Hat_VisorBlack", 0.5,
			"Hat_VisorRed", 0.5,
			"Hat_Visor_WhiteTINT", 1,
			"Hat_WinterHat", 0.1,
			"Hat_WoolyHat", 0.1,
			"HoodieDOWN_WhiteTINT", 4,
			"Jacket_ArmyCamoDesert", 0.1,
			"Jacket_ArmyCamoGreen", 0.1,
			"Jacket_Leather", 0.5,
			"Jacket_Leather_Punk", 0.001,
			"Jacket_PaddedDOWN", 0.1,
			"Jacket_Shellsuit_Black", 0.1,
			"Jacket_Shellsuit_Blue", 0.1,
			"Jacket_Shellsuit_Green", 0.1,
			"Jacket_Shellsuit_Pink", 0.1,
			"Jacket_Shellsuit_TINT", 1,
			"Jacket_Shellsuit_Teal", 0.1,
			"Jacket_Varsity", 0.1,
			"Jacket_WhiteTINT", 1,
			"Jumper_DiamondPatternTINT", 1,
			"Jumper_PoloNeck", 2,
			"Jumper_RoundNeck", 2,
			"Jumper_TankTopTINT", 4,
			"Jumper_VNeck", 4,
			"LongCoat_Bathrobe", 0.1,
			"LongJohns", 0.1,
			"LongJohns_Bottoms", 0.1,
			"Scarf_StripeBlackWhite", 0.1,
			"Scarf_StripeBlueWhite", 0.1,
			"Scarf_StripeRedWhite", 0.1,
			"Scarf_White", 0.1,
			"Shirt_Baseball_KY", 0.5,
			"Shirt_Baseball_Rangers", 0.5,
			"Shirt_Baseball_Z", 0.5,
			"Shirt_CropTopNoArmTINT", 1,
			"Shirt_CropTopTINT", 1,
			"Shirt_CamoDesert", 0.1,
			"Shirt_CamoGreen", 0.1,
			"Shirt_CamoUrban", 0.1,
			"Shirt_Denim", 0.5,
			"Shirt_FormalTINT", 2,
			"Shirt_FormalWhite", 1,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shirt_HawaiianRed", 0.1,
			"Shirt_HawaiianTINT", 0.1,
			"Shirt_Lumberjack", 1,
			"Shirt_Lumberjack_TINT", 1,
			"Shoes_ArmyBoots", 0.1,
			"Shoes_ArmyBootsDesert", 0.05,
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
			"Shoes_Wellies", 0.5,
			"Shoes_WorkBoots", 0.5,
			"Shorts_CamoGreenLong", 0.1,
			"Shorts_CamoUrbanLong", 0.1,
			"Shorts_LongDenim", 2,
			"Shorts_LongSport", 2,
			"Shorts_ShortSport", 2,
			"Skirt_Knees", 2,
			"Skirt_Long", 2,
			"Skirt_Normal", 2,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Long_Black", 2,
			"Socks_Long_White", 2,
			"StockingsBlack", 0.1,
			"StockingsBlackSemiTrans", 0.1,
			"StockingsBlackTrans", 0.1,
			"StockingsWhite", 1,
			"Suit_Jacket", 0.5,
			"Suit_JacketTINT", 0.1,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"TightsBlack", 0.1,
			"TightsBlackSemiTrans", 0.1,
			"TightsBlackTrans", 0.1,
			"TightsFishnets", 0.1,
			"TrousersMesh_DenimLight", 1,
			"TrousersMesh_Leather", 0.1,
			"Trousers_CamoDesert", 0.1,
			"Trousers_CamoGreen", 0.1,
			"Trousers_CamoUrban", 0.1,
			"Trousers_DefaultTEXTURE_TINT", 1,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_LeatherBlack", 0.1,
			"Trousers_Padded", 0.1,
			"Trousers_Shellsuit_Black", 0.1,
			"Trousers_Shellsuit_Blue", 0.1,
			"Trousers_Shellsuit_Green", 0.1,
			"Trousers_Shellsuit_Pink", 0.1,
			"Trousers_Shellsuit_TINT", 1,
			"Trousers_Shellsuit_Teal", 0.1,
			"Trousers_Sport", 1,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Trousers_SuitWhite", 0.1,
			"Trousers_WhiteTINT", 4,
			"Tshirt_ArmyGreen", 0.1,
			"Tshirt_CamoDesert", 0.1,
			"Tshirt_CamoGreen", 0.1,
			"Tshirt_CamoUrban", 0.1,
			"Tshirt_DefaultDECAL_TINT", 0.5,
			"Tshirt_DefaultTEXTURE_TINT", 4,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_LongSleeve_SuperColor", 0.5,
			"Tshirt_PoloStripedTINT", 1,
			"Tshirt_PoloTINT", 1,
			"Tshirt_Rock", 1,
			"Tshirt_Sport", 1,
			"Tshirt_SportDECAL", 0.5,
			"Tshirt_SuperColor", 0.5,
			"Tshirt_TieDye", 0.5,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCocoaPowder = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CocoaPowder", 50,
			"CocoaPowder", 20,
			"CocoaPowder", 20,
			"CocoaPowder", 10,
			"CocoaPowder", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCondiments = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Ketchup", 20,
			"Ketchup", 10,
			"Mustard", 20,
			"Mustard", 10,
			"BBQSauce", 8,
			"Hotsauce", 4,
			"Vinegar2", 8,
			"Vinegar_Jug", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateConesIceCream = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Cone", 50,
			"Cone", 20,
			"Cone", 20,
			"Cone", 10,
			"Cone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCompactDiscs = {
		isShop = true,
		rolls = 4,
		items = {
			"Disc_Retail", 50,
			"Disc_Retail", 20,
			"Disc_Retail", 20,
			"Disc_Retail", 10,
			"Disc_Retail", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCornflour = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Cornflour2", 50,
			"Cornflour2", 20,
			"Cornflour2", 20,
			"Cornflour2", 10,
			"Cornflour2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCoffee = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Coffee2", 50,
			"Coffee2", 20,
			"Coffee2", 20,
			"Coffee2", 10,
			"Coffee2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateComics = {
		rolls = 4,
		items = {
			"ComicBook", 50,
			"ComicBook", 20,
			"ComicBook", 20,
			"ComicBook", 10,
			"ComicBook", 10,
			"RPGmanual", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateComputer = {
		rolls = 4,
		items = {
			"ElectronicsScrap", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_DesktopComputer", 100,
			}
		}
	},
	
	CrateConcrete = {
		isShop = true,
		rolls = 4,
		items = {
			"ConcretePowder", 50,
			"ConcretePowder", 20,
			"ConcretePowder", 20,
			"ConcretePowder", 10,
			"ConcretePowder", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCostume = {
		rolls = 4,
		items = {
			"Comb", 4,
			"Corset", 0.2,
			"Corset_Black", 0.1,
			"Corset_Red", 0.1,
			"Garter", 0.2,
			"Glasses_Aviators", 8,
			"Glasses_Eyepatch_Left", 0.5,
			"Glasses_SafetyGoggles", 8,
			"Glasses_SkiGoggles", 6,
			"Glasses_Sun", 10,
			"Glasses_SwimmingGoggles", 6,
			"HairDyeUncommon", 6,
			"Hairgel", 2,
			"Hairspray2", 6,
			"Hat_Antlers", 2,
			"Hat_BuildersRespirator", 0.1,
			"Hat_BunnyEarsBlack", 2,
			"Hat_BunnyEarsWhite", 2,
			"Hat_ChefHat", 2,
			"Hat_Cowboy", 2,
			"Hat_DeerHeadress", 0.001,
			"Hat_FootballHelmet", 1,
			"Hat_FurryEars", 2,
			"Hat_GasMask", 0.1,
			"Hat_HalloweenMaskDevil", 0.5,
			"Hat_HalloweenMaskMonster", 0.5,
			"Hat_HalloweenMaskPumpkin", 0.5,
			"Hat_HalloweenMaskSkeleton", 0.5,
			"Hat_HalloweenMaskVampire", 0.5,
			"Hat_HalloweenMaskWitch", 0.5,
			"Hat_HardHat", 4,
			"Hat_HardHat_Miner", 0.5,
			"Hat_HeadMirrorUP", 8,
			"Hat_HeadSack_Burlap", 4,
			"Hat_HeadSack_Cotton", 4,
			"Hat_HockeyMask", 1,
			"Hat_HockeyMask_MetalScrap", 0.001,
			"Hat_HockeyMask_Wood", 0.01,
			"Hat_JokeArrow", 2,
			"Hat_JokeKnife", 2,
			"Hat_PartyHat_Stars", 4,
			"Hat_PartyHat_TINT", 4,
			"Hat_Pilgrim", 0.01,
			"Hat_Pirate", 0.5,
			"Hat_Police", 2,
			"Hat_Police_Grey", 2,
			"Hat_Raccoon", 2,
			"Hat_SantaHat", 2,
			"Hat_SantaHatGreen", 2,
			"Hat_Stovepipe", 0.5,
			"Hat_Stovepipe_UncleSam", 0.1,
			"Hat_Witch", 0.5,
			"Hat_Wizard", 0.5,
			"JacketLong_Doctor", 4,
			"MakeupEyeshadow", 6,
			"MakeupFoundation", 6,
			"Mirror", 8,
			"Necklace_Teeth", 0.1,
			"NecklaceLong_Teeth", 0.1,
			"RopeBelt", 4,
			"SCBA_notank", 0.1,
			"TightsFishnets", 0.2,
			"Whistle", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateCrackers = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Crackers", 50,
			"Crackers", 20,
			"Crackers", 20,
			"Crackers", 10,
			"Crackers", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateDarkBlueChairs = {
		rolls = 4,
		items = {
			"Mov_DarkBlueChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_DarkBlueChair", 200,
			}
		}
	},
	
	CrateDarkWoodenChairs = {
		rolls = 4,
		items = {
			"Mov_DarkWoodenChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_DarkWoodenChair", 200,
			}
		}
	},
	
	CrateDishes = {
		rolls = 4,
		items = {
			"Bowl", 20,
			"Bowl", 10,
			"DrinkingGlass", 20,
			"DrinkingGlass", 10,
			"GlassTumbler", 10,
			"GlassWine", 4,
			"Mugl", 10,
			"Plate", 20,
			"Plate", 10,
			"Teacup", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateEggs = {
		isShop = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"EggCarton", 50,
			"EggCarton", 20,
			"EggCarton", 20,
			"EggCarton", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateElectronics = {
		rolls = 4,
		items = {
			"BlowerFan", 1,
			"BookElectrician1", 2,
			"BookElectrician2", 1,
			"BookElectrician3", 0.5,
			"BookElectrician4", 0.1,
			"BookElectrician5", 0.05,
			"Bullhorn", 1,
			"CDplayer", 4,
			"CopperScrap", 10,
			"CordlessPhone", 2,
			"Earbuds", 4,
			"ElectricWire", 20,
			"ElectricWire", 10,
			"ElectronicsScrap", 20,
			"ElectronicsScrap", 10,
			"FlashLight_AngleHead", 1,
			"HairDryer", 10,
			"HairIron", 10,
			"HamRadio1", 0.01,
			"HamRadio2", 0.001,
			"HandTorch", 8,
			"Headphones", 4,
			"Microphone", 4,
			"Mov_Microwave", 0.1,
			"Mov_Microwave2", 0.1,
			"Mov_Toaster", 0.5,
			"PowerBar", 4,
			"RadioBlack", 2,
			"RadioRed", 1,
			"Remote", 4,
			"Speaker", 1,
			"Torch", 4,
			"VideoGame", 2,
			"WalkieTalkie1", 1,
			"WalkieTalkie2", 0.5,
			"WalkieTalkie3", 0.20,
			"WalkieTalkie4", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_SatelliteDish", 4,
			}
		}
	},
	
	CrateEmptyBottles1 = {
		isTrash = true,
		rolls = 4,
		items = {
			"BeerBottleEmpty", 50,
			"BeerBottleEmpty", 20,
			"BeerBottleEmpty", 20,
			"BeerBottleEmpty", 10,
			"BeerBottleEmpty", 10,
			"BeerImportedEmpty", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateEmptyBottles2 = {
		isTrash = true,
		rolls = 4,
		items = {
			"BeerBottleEmpty", 20,
			"BeerBottleEmpty", 10,
			"BrandyEmpty", 10,
			"CoffeeLiquerEmpty", 4,
			"CuracaoEmpty", 4,
			"GinEmpty", 10,
			"GrenadineEmpty", 4,
			"PortEmpty", 4,
			"RumEmpty", 10,
			"ScotchEmpty", 4,
			"SherryEmpty", 4,
			"TequilaEmpty", 10,
			"VermouthEmpty", 4,
			"VodkaEmpty", 10,
			"WhiskeyEmpty", 20,
			"Wine2OpenEmpty", 10,
			"WineAgedEmpty", 0.1,
			"WineOpenEmpty", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateEmptyMixed = {
		isTrash = true,
		rolls = 4,
		items = {
			"BeerBottleEmpty", 20,
			"BeerCanEmpty", 20,
			"GinEmpty", 1,
			"Pop2Empty", 20,
			"Pop3Empty", 20,
			"PopBottleEmpty", 10,
			"PopBottleRareEmpty", 4,
			"PopEmpty", 20,
			"RumEmpty", 1,
			"TequilaEmpty", 1,
			"VodkaEmpty", 1,
			"WaterBottleEmpty", 10,
			"WhiskeyEmpty", 1,
			"Wine2OpenEmpty", 1,
			"WineOpenEmpty", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateEmptyTinCans = {
		isTrash = true,
		rolls = 4,
		items = {
			"TinCanEmpty", 50,
			"TinCanEmpty", 20,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			"TinCanEmpty", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateEspressoMachine = {
		rolls = 4,
		items = {
			"Mugl", 20,
			"Mugl", 20,
			"Mugl", 10,
			"Mugl", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_Espresso", 200,
			}
		}
	},
	
	CrateFabric_Cotton = {
		isTrash = true,
		rolls = 4,
		items = {
			"FabricRoll_Cotton", 50,
			"FabricRoll_Cotton", 20,
			"FabricRoll_Cotton", 20,
			"FabricRoll_Cotton", 10,
			"FabricRoll_Cotton", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFabric_DenimBlack = {
		isTrash = true,
		rolls = 4,
		items = {
			"FabricRoll_DenimBlack", 50,
			"FabricRoll_DenimBlack", 20,
			"FabricRoll_DenimBlack", 20,
			"FabricRoll_DenimBlack", 10,
			"FabricRoll_DenimBlack", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFabric_DenimBlue = {
		isTrash = true,
		rolls = 4,
		items = {
			"FabricRoll_DenimBlue", 50,
			"FabricRoll_DenimBlue", 20,
			"FabricRoll_DenimBlue", 20,
			"FabricRoll_DenimBlue", 10,
			"FabricRoll_DenimBlue", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFabric_DenimDarkBlue = {
		isTrash = true,
		rolls = 4,
		items = {
			"FabricRoll_DenimDarkBlue", 50,
			"FabricRoll_DenimDarkBlue", 20,
			"FabricRoll_DenimDarkBlue", 20,
			"FabricRoll_DenimDarkBlue", 10,
			"FabricRoll_DenimDarkBlue", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFancyBlackChairs = {
		rolls = 4,
		items = {
			"Mov_FancyBlackChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_FancyBlackChair", 200,
			}
		}
	},
	
	CrateFancyDarkTables = {
		rolls = 4,
		items = {
			"Mov_FancyDarkTable", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_FancyDarkTable", 200,
			}
		}
	},
	
	CrateFancyLowTables = {
		rolls = 4,
		items = {
			"Mov_FancyLowTable", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_FancyLowTable", 200,
			}
		}
	},
	
	CrateFancyToilets = {
		rolls = 4,
		items = {
			"Mov_FancyToilet", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_FancyToilet", 200,
			}
		}
	},
	
	CrateFancyWhiteChairs = {
		rolls = 4,
		items = {
			"Mov_FancyWhiteChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_FancyWhiteChair", 200,
			}
		}
	},
	
	CrateFarming = {
		rolls = 4,
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
			-- Herbs
			"BasilBagSeed", 0.5,
			"ChamomileBagSeed", 0.5,
			"ChivesBagSeed", 0.5,
			"CilantroBagSeed", 0.5,
			"LemonGrassBagSeed", 0.5,
			"MarigoldBagSeed", 0.5,
			"MintBagSeed", 0.5,
			"OreganoBagSeed", 0.5,
			"ParsleyBagSeed", 0.5,
			"RosemaryBagSeed", 0.5,
			"SageBagSeed", 0.5,
			"ThymeBagSeed", 0.5,
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
			"SugarBeetBagSeed", 4,
			"SunflowerBagSeed", 4,
			"SweetPotatoBagSeed", 4,
			"TomatoBagSeed2", 2,
			"TurnipBagSeed", 4,
			"WatermelonBagSeed", 2,
			"ZucchiniBagSeed", 2,
			-- Materials
			"AnimalFeedBag", 2,
			"BarbedWire", 10,
			"BarbedWireStack", 0.5,
			"BurlapPiece", 8,
			"CompostBag", 1,
			"Fertilizer", 2,
			"Handle", 2,
			"LongHandle", 1,
			"Rope", 4,
			"RopeStack", 0.1,
			"SmallHandle", 2,
			"Stake", 20,
			"Wire", 4,
			"WireStack", 0.1,
			"WoodenStick2", 2,
			-- Tools
			"CarpentryChisel", 2,
			"Fleshing_Tool", 10,
			"GardenFork", 1,
			"GardenHoe", 2,
			"GardeningSprayEmpty", 6,
			"GardenSaw", 10,
			"HandAxe", 1,
			"HandFork", 2,
			"HandScythe", 2,
			"HandShovel", 10,
			"LargeKnife", 1,
			"LeafRake", 10,
			"Machete", 0.01,
			"PickAxe", 0.5,
			"Rake", 10,
			"Scythe", 10,
			"SheepElectricShears", 2,
			"SheepShears", 2,
			"WateredCan", 6,
			-- Clothing
			"ElbowPad_Left_Workman", 1,
			"Gloves_LeatherGloves", 2,
			"Hat_BuildersRespirator", 2,
			"KnapsackSprayer", 1,
			"Kneepad_Left_Workman", 4,
			-- Literature
			"BookFarming1", 2,
			"BookFarming2", 1,
			"BookFarming3", 0.5,
			"BookFarming4", 0.1,
			"BookFarming5", 0.05,
			"BookHusbandry1", 2,
			"BookHusbandry2", 1,
			"BookHusbandry3", 0.5,
			"BookHusbandry4", 0.1,
			"BookHusbandry5", 0.05,
			"Book_Farming", 8,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			-- Misc.
			"Bucket", 4,
			"CheeseCloth", 8,
			"Mov_SaltLick", 1,
			"RakeHead", 4,
			"RatPoison", 8,
			"RespiratorFilters", 2,
			"SlugRepellent", 4,
			"TrapMouse", 4,
			-- Bags/Containers
			"Bag_GardenBasket", 1,
			"SeedBag_Farming", 4,
			"Toolbox_Farming", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"MeasuringTape", 8,
				"Padlock", 4,
				"Twine", 4,
			}
		}
	},
	
	CrateFishing = {
		rolls = 4,
		items = {
			"Bag_FishingBasket", 2,
			"Bag_Satchel_Fishing", 2,
			"Bobber", 10,
			"BookFishing1", 2,
			"BookFishing2", 1,
			"BookFishing3", 0.5,
			"BookFishing4", 0.1,
			"BookFishing5", 0.05,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"FishingHook", 10,
			"FishingHookBox", 4,
			"FishingLine", 20,
			"FishingLine", 10,
			"FishingMag1", 2,
			"FishingMag2", 2,
			"FishingNet", 10,
			"FishingNet", 20,
			"FishingRod", 20,
			"FishingRod", 10,
			"FishingTackle", 10,
			"FishingTackle2", 10,
			"Gaffhook", 1,
			"Handiknife", 1,
			"Hat_BucketHatFishing", 4,
			"Hat_FishermanRainHat", 0.001,
			"Hat_PeakedCapYacht", 0.001,
			"JigLure", 10,
			"KnifeFillet", 10,
			"KnifePocket", 1,
			"MinnowLure", 10,
			"Multitool", 0.01,
			"PremiumFishingLine", 4,
			"Tacklebox", 2,
			"Toolbox_Fishing", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFlour = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Flour2", 50,
			"Flour2", 20,
			"Flour2", 20,
			"Flour2", 10,
			"Flour2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFertilizer = {
		isShop = true,
		rolls = 4,
		items = {
			"Fertilizer", 50,
			"Fertilizer", 20,
			"Fertilizer", 20,
			"Fertilizer", 10,
			"Fertilizer", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFitnessWeights = {
		rolls = 4,
		items = {
			"DumbBell", 50,
			"DumbBell", 10,
			"BarBell", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_FitnessContraption", 200,
			}
		}
	},
	
	CrateFoldingChairs = {
		rolls = 4,
		items = {
			"Mov_FoldingChair", 40,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_FoldingChair", 200,
			}
		}
	},
	
	CrateFootballs = {
		isShop = true,
		rolls = 4,
		items = {
			"Football", 50,
			"Football", 20,
			"Football", 20,
			"Football", 10,
			"Football", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFootwearRandom = {
		rolls = 4,
		items = {
			"Shoes_ArmyBoots", 1,
			"Shoes_ArmyBootsDesert", 0.5,
			"Shoes_Black", 8,
			"Shoes_BlackBoots", 2,
			"Shoes_BlueTrainers", 4,
			"Shoes_Brown", 8,
			"Shoes_FlipFlop", 4,
			"Shoes_HikingBoots", 4,
			"Shoes_RedTrainers", 4,
			"Shoes_RidingBoots", 2,
			"Shoes_TrainerTINT", 8,
			"Shoes_Wellies", 1,
			"Shoes_WorkBoots", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateFountainCups = {
		isShop = true,
		rolls = 4,
		items = {
			"FountainCup", 50,
			"FountainCup", 20,
			"FountainCup", 20,
			"FountainCup", 10,
			"FountainCup", 10,
			"Straw2", 50,
			"Straw2", 20,
			"Straw2", 20,
			"Straw2", 10,
			"Straw2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGardening = {
		rolls = 4,
		items = {
			-- Seeds
			"BasilBagSeed", 4,
			"BellPepperBagSeed", 2,
			"BroccoliBagSeed2", 2,
			"CabbageBagSeed2", 2,
			"CarrotBagSeed2", 2,
			"CauliflowerBagSeed", 2,
			"ChamomileBagSeed", 4,
			"ChivesBagSeed", 4,
			"CilantroBagSeed", 4,
			"CucumberBagSeed", 2,
			"GarlicBagSeed", 2,
			"GreenpeasBagSeed", 2,
			"HabaneroBagSeed", 1,
			"JalapenoBagSeed", 2,
			"KaleBagSeed", 2,
			"LeekBagSeed", 2,
			"LemonGrassBagSeed", 4,
			"LettuceBagSeed", 2,
			"MarigoldBagSeed", 4,
			"MintBagSeed", 4,
			"OnionBagSeed", 2,
			"OreganoBagSeed", 4,
			"ParsleyBagSeed", 4,
			"PotatoBagSeed2", 2,
			"PumpkinBagSeed", 1,
			"RedRadishBagSeed2", 2,
			"RosemaryBagSeed", 4,
			"SageBagSeed", 4,
			"SpinachBagSeed", 2,
			"StrewberrieBagSeed2", 2,
			"SunflowerBagSeed", 4,
			"SweetPotatoBagSeed", 2,
			"ThymeBagSeed", 4,
			"TomatoBagSeed2", 2,
			"TurnipBagSeed", 2,
			"WatermelonBagSeed", 1,
			"ZucchiniBagSeed", 2,
			-- Tools
			"GardenFork", 1,
			"GardenHoe", 2,
			"GardeningSprayEmpty", 6,
			"GardenSaw", 10,
			"HandAxe", 1,
			"HandFork", 8,
			"HandScythe", 8,
			"HandShovel", 10,
			"KnapsackSprayer", 1,
			"LeafRake", 10,
			"Machete", 0.01,
			"PickAxe", 0.5,
			"Rake", 10,
			"Scythe", 2,
			"WateredCan", 6,
			-- Literature
			"BookFarming1", 2,
			"BookFarming2", 1,
			"BookFarming3", 0.5,
			"BookFarming4", 0.1,
			"BookFarming5", 0.05,
			"Book_Farming", 8,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			-- Accessories
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 8,
			"Gloves_LeatherGloves", 2,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 8,
			"Kneepad_Left_Workman", 4,
			"RespiratorFilters", 2,
			"Hat_StrawHat", 1,
			"Hat_SummerHat", 1,
			-- Misc.
			"Bucket", 4,
			"Handle", 2,
			"LongHandle", 1,
			"LongStick", 1,
			"Mov_Brazier", 1,
			"Padlock", 4,
			"RakeHead", 4,
			"SmallHandle", 2,
			"WoodenStick2", 2,
			-- Materials
			"BurlapPiece", 8,
			"CompostBag", 2,
			"Fertilizer", 2,
			"Gravelbag", 4,
			"RatPoison", 2,
			"SlugRepellent", 10,
			"Stake", 10,
			"Wire", 4,
			-- Bags/Containers
			"Bag_GardenBasket", 10,
			"Toolbox_Gardening", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGenerator = {
		rolls = 4,
		items = {
			"BookElectrician1", 2,
			"BookElectrician2", 1,
			"BookElectrician3", 0.5,
			"BookElectrician4", 0.1,
			"BookElectrician5", 0.05,
			"ElectronicsMag4", 6,
			"Screwdriver", 10,
		},
		junk = {
			onlyOne = true,
			rolls = 20,
			items = {
				"Generator", 10,
				"Generator_Blue", 10,
				"Generator_Yellow", 10,
				"Generator_Old", 40,
			}
		}
	},
	
	CrateGolfBalls = {
		isShop = true,
		rolls = 4,
		items = {
			"GolfBall", 50,
			"GolfBall", 20,
			"GolfBall", 20,
			"GolfBall", 10,
			"GolfBall", 10,
			"GolfTee", 50,
			"GolfTee", 20,
			"GolfTee", 20,
			"GolfTee", 10,
			"GolfTee", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGolfClubs = {
		isShop = true,
		rolls = 4,
		items = {
			"Golfclub", 50,
			"Golfclub", 20,
			"Golfclub", 20,
			"Golfclub", 10,
			"Golfclub", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGrahamCrackers = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"GrahamCrackers", 20,
			"GrahamCrackers", 20,
			"GrahamCrackers", 10,
			"GrahamCrackers", 10,
			"GrahamCrackers", 10,
			"GrahamCrackers", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGravelBags = {
		isShop = true,
		rolls = 4,
		items = {
			"Gravelbag", 50,
			"Gravelbag", 20,
			"Gravelbag", 20,
			"Gravelbag", 10,
			"Gravelbag", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGravyMix = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"GravyMix", 50,
			"GravyMix", 20,
			"GravyMix", 20,
			"GravyMix", 10,
			"GravyMix", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGreenChairs = {
		rolls = 4,
		items = {
			"Mov_GreenChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_GreenChair", 200,
			}
		}
	},
	
	CrateGreenComfyChair = {
		rolls = 1,
		items = {
			"Mov_GreenComfyChair", 200,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	CrateGreenOven = {
		rolls = 1,
		items = {
			"Mov_GreenOven", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGreyChairs = {
		rolls = 4,
		items = {
			"Mov_GreyChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_GreyChair", 200,
			}
		}
	},
	
	CrateGreyComfyChair = {
		rolls = 1,
		items = {
			"Mov_GreyComfyChair", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGreyOven = {
		rolls = 1,
		items = {
			"Mov_GreyOven", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateGum = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Gum", 100,
			"Gum", 50,
			"Gum", 50,
			"Gum", 20,
			"Gum", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateHeavyChains = {
		rolls = 4,
		items = {
			"HeavyChain", 50,
			"HeavyChain", 20,
			"HeavyChain", 10,
			"HeavyChain", 10,
			"HeavyChain_Hook", 6,
			"LargeHook", 20,
			"LargeHook", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateHotsauce = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Hotsauce", 50,
			"Hotsauce", 20,
			"Hotsauce", 20,
			"Hotsauce", 10,
			"Hotsauce", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Refugee camp supply crates. These have already been opened so the food and medicine is mostly gone.
	CrateHumanitarian = {
		rolls = 4,
		items = {
			"Antibiotics", 0.001,
			"Bandaid", 2,
			"Bandage", 1,
			"Battery", 8,
			"BatteryBox", 0.1,
			"BeefJerky", 0.01,
			"Candle", 4,
			"CandleBox", 0.001,
			"CannedBolognese", 0.01,
			"CannedCarrots2", 0.01,
			"CannedChili", 0.01,
			"CannedCorn", 0.01,
			"CannedCornedBeef", 0.01,
			"CannedFruitCocktail", 0.01,
			"CannedMilk", 0.01,
			"CannedMushroomSoup", 0.01,
			"CannedPeaches", 0.01,
			"CannedPeas", 0.01,
			"CannedPineapple", 0.01,
			"CannedPotato2", 0.01,
			"CannedSardines", 0.01,
			"CannedTomato2", 0.01,
			"DehydratedMeatStick", 0.01,
			"DentedCan", 2,
			"FirstAidKit", 0.01,
			"HandTorch", 1,
			"Matches", 4,
			"Matchbox", 2,
			"Mov_Cot", 0.001,
			"MysteryCan", 1,
			"P38", 2,
			"Pills", 0.01,
			"PonchoYellowDOWN", 2,
			"SleepingBag_Camo_Packed", 1,
			"TinnedBeans", 0.01,
			"TinnedSoup", 0.01,
			"ToiletPaper", 4,
			"TunaTin", 0.01,
			"WalkieTalkie4", 1,
			"WalkieTalkie5", 0.5,
			"WaterBottle", 0.01,
			"WaterPurificationTablets", 0.001,
		},
		junk = {
			rolls = 1,
			items = {
				"TinCanEmpty", 20,
				"TinCanEmpty", 10,
				"WaterBottleEmpty", 4,
			}
		}
	},
	
	CrateIndustrialDye = {
		rolls = 8,
		items = {
			"IndustrialDye", 50,
			"IndustrialDye", 20,
			"IndustrialDye", 20,
			"IndustrialDye", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateIndustrialSinks = {
		rolls = 4,
		items = {
			"Mov_DarkIndustrialSink", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_DarkIndustrialSink", 200,
			}
		}
	},
	
	CrateInstruments = {
		rolls = 4,
		items = {
			"Banjo", 6,
			"Drumstick", 20,
			"Drumstick", 10,
			"Flute", 4,
			"GuitarAcoustic", 4,
			"GuitarElectricBass", 4,
			"GuitarElectric", 4,
			"Harmonica", 8,
			"Keytar", 6,
			"Saxophone", 4,
			"Trumpet", 4,
			"Violin", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateLargeStone = {
		rolls = 4,
		items = {
			"LargeStone", 50,
			"LargeStone", 20,
			"LargeStone", 10,
			"Limestone", 20,
			"Limestone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateLeather = {
		isShop = true,
		rolls = 4,
		items = {
			"LeatherStrips", 50,
			"LeatherStrips", 20,
			"LeatherStrips", 20,
			"LeatherStrips", 10,
			"LeatherStrips", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateLightRoundTable = {
		rolls = 1,
		items = {
			"Mov_LightRoundTable", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateLimestoneCrushed = {
		isShop = true,
		rolls = 4,
		items = {
			"CrushedLimestone", 50,
			"CrushedLimestone", 20,
			"CrushedLimestone", 20,
			"CrushedLimestone", 10,
			"CrushedLimestone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateLinens = {
		rolls = 4,
		items = {
			"Sheet", 50,
			"Sheet", 20,
			"Sheet", 20,
			"Sheet", 10,
			"Sheet", 10,
			"BathTowel", 20,
			"BathTowel", 10,
			"Pillow", 20,
			"Pillow", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateLiquor = {
		isShop = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Spirits
			"Brandy", 10,
			"Gin", 10,
			"Rum", 10,
			"Scotch", 10,
			"Tequila", 10,
			"Vodka", 10,
			"Whiskey", 10,
			-- Mix
			"Bitters", 10,
			"CoffeeLiquer", 10,
			"Curacao", 10,
			"Grenadine", 10,
			"SimpleSyrup", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	CrateLongStick = {
		isShop = true,
		rolls = 4,
		items = {
			"LongStick", 50,
			"LongStick", 20,
			"LongStick", 20,
			"LongStick", 10,
			"LongStick", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateLongTables = {
		rolls = 4,
		items = {
			"Mov_LongTable", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_LongTable", 200,
			}
		}
	},
	
	CrateLumber = {
		isShop = true,
		rolls = 6,
		items = {
			"Plank", 50,
			"Plank", 20,
			"Plank", 20,
			"Plank", 10,
			"Plank", 10,
		},
		junk = {
			rolls = 4,
			items = {
				"Splinters", 8,
			}
		}
	},
	
	CrateMacaroni = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Macaroni", 50,
			"Macaroni", 20,
			"Macaroni", 20,
			"Macaroni", 10,
			"Macaroni", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateMagazines = {
		rolls = 4,
		items = {
			"ArmorMag3", 0.001,
			"ArmorMag4", 0.001,
			"ArmorMag5", 0.001,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"GlassmakingMag1", 0.5,
			"GlassmakingMag2", 0.5,
			"GlassmakingMag3", 0.5,
			"HerbalistMag", 1,
			"HottieZ", 0.1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"Magazine_Art", 2,
			"Magazine_Business", 2,
			"Magazine_Car", 4,
			"Magazine_Childs", 4,
			"Magazine_Cinema", 2,
			"Magazine_Crime", 2,
			"Magazine_Fashion", 4,
			"Magazine_Firearm", 2,
			"Magazine_Health", 2,
			"Magazine_Hobby", 4,
			"Magazine_Horror", 4,
			"Magazine_Humor", 4,
			"Magazine_Military", 2,
			"Magazine_Music", 2,
			"Magazine_Outdoors", 2,
			"Magazine_Police", 2,
			"Magazine_Science", 2,
			"Magazine_Sports", 4,
			"Magazine_Tech", 2,
			"Magazine_Teens", 4,
			"MagazineCrossword", 10,
			"MagazineWordsearch", 10,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkMag1", 1,
			"MetalworkMag2", 1,
			"MetalworkMag3", 1,
			"MetalworkMag4", 1,
			"PrimitiveToolMag1", 0.001,
			"PrimitiveToolMag2", 0.001,
			"PrimitiveToolMag3", 0.001,
			"SmithingMag1", 0.1,
			"SmithingMag2", 0.1,
			"SmithingMag3", 0.1,
			"SmithingMag4", 0.1,
			"SmithingMag5", 0.1,
			"SmithingMag6", 0.1,
			"SmithingMag7", 0.1,
			"SmithingMag8", 0.1,
			"SmithingMag9", 0.1,
			"SmithingMag10", 0.1,
			"SmithingMag11", 0.01,
			"TVMagazine", 8,
			"WeaponMag1", 0.001,
			"WeaponMag2", 0.001,
			"WeaponMag3", 0.001,
			"WeaponMag4", 0.001,
			"WeaponMag5", 0.001,
			"WeaponMag6", 0.001,
			"WeaponMag7", 0.001,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateMannequins = {
		rolls = 4,
		items = {
			"Mov_MannequinFemale", 50,
			"Mov_MannequinMale", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_MannequinFemale", 50,
			}
		}
	},
	
	CrateMapleSyrup = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"MapleSyrup", 50,
			"MapleSyrup", 20,
			"MapleSyrup", 20,
			"MapleSyrup", 10,
			"MapleSyrup", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateMaps = {
		rolls = 4,
		items = {
			"Base.LouisvilleMap1", 2,
			"Base.LouisvilleMap2", 2,
			"Base.LouisvilleMap3", 2,
			"Base.LouisvilleMap4", 2,
			"Base.LouisvilleMap5", 2,
			"Base.LouisvilleMap6", 2,
			"Base.LouisvilleMap7", 2,
			"Base.LouisvilleMap8", 2,
			"Base.LouisvilleMap9", 2,
			"Base.MuldraughMap", 10,
			"Base.WestpointMap", 10,
			"Base.MarchRidgeMap", 10,
			"Base.RosewoodMap", 10,
			"Base.RiversideMap", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateMapsLarge = {
		rolls = 4,
		items = {
			"Mov_MapUSA", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_MapUSA", 100,
			}
		}
	},
	
	CrateMarinara = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Marinara", 50,
			"Marinara", 20,
			"Marinara", 20,
			"Marinara", 10,
			"Marinara", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateMarshmallows = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Marshmallows", 50,
			"Marshmallows", 20,
			"Marshmallows", 20,
			"Marshmallows", 10,
			"Marshmallows", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateMasonry = {
		rolls = 4,
		items = {
			"BookMasonry1", 2,
			"BookMasonry2", 1,
			"BookMasonry3", 0.5,
			"BookMasonry4", 0.1,
			"BookMasonry5", 0.05,
			"ClubHammer", 20,
			"ClubHammer", 10,
			"FlatStone", 20,
			"FlatStone", 10,
			"MasonsChisel", 50,
			"MasonsChisel", 20,
			"MasonsChisel", 10,
			"MasonsTrowel", 20,
			"MasonsTrowel", 10,
			"StoneBlock", 20,
			"StoneBlock", 20,
			"StoneBlock", 10,
			"StoneBlock", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateMechanics = {
		rolls = 4,
		items = {
			"Base.LouisvilleMap1", 0.05,
			"Base.LouisvilleMap2", 0.05,
			"Base.LouisvilleMap3", 0.05,
			"Base.LouisvilleMap4", 0.05,
			"Base.LouisvilleMap5", 0.05,
			"Base.LouisvilleMap6", 0.05,
			"Base.LouisvilleMap7", 0.05,
			"Base.LouisvilleMap8", 0.05,
			"Base.LouisvilleMap9", 0.05,
			"Base.MarchRidgeMap", 0.4,
			"Base.MuldraughMap", 0.4,
			"Base.RiversideMap", 0.4,
			"Base.RosewoodMap", 0.4,
			"Base.WestpointMap", 0.4,
			"BlowerFan", 1,
			"BookMechanic1", 2,
			"BookMechanic2", 1,
			"BookMechanic3", 0.5,
			"BookMechanic4", 0.1,
			"BookMechanic5", 0.05,
			"BlowTorch", 4,
			"Calipers", 2,
			"CarBattery1", 1,
			"ElbowPad_Left_Workman", 1,
			"ElectricWire", 10,
			"Epoxy", 4,
			"FiberglassTape", 4,
			"EngineParts", 20,
			"EngineParts", 10,
			"File", 4,
			"Funnel", 10,
			"HandDrill", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"HeavyChain", 8,
			"HeavyChain_Hook", 1,
			"IronBar", 4,
			"IronBarHalf", 6,
			"IronPiece", 10,
			"IronBarQuarter", 8,
			"Jack", 2,
			"Kneepad_Left_Workman", 4,
			"LargeHook", 2,
			"LightBulb", 10,
			"LightBulbBox", 1,
			"LugWrench", 8,
			"Magazine_Car", 10,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 4,
			"NormalSuspension1", 1,
			"OldBrake1", 6,
			"OldCarMuffler1", 8,
			"PetrolCanEmpty", 10,
			"Pliers", 8,
			"RespiratorFilters", 2,
			"RubberHose", 10,
			"Screwdriver", 10,
			"SheetMetalSnips", 4,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"SteelBar", 4,
			"SteelBarHalf", 6,
			"SteelPiece", 10,
			"SteelBarQuarter", 8,
			"TireIron", 4,
			"TirePump", 8,
			"ViseGrips", 4,
			"WeldingMask", 1,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateMetalwork = {
		rolls = 4,
		items = {
			"BallPeenHammer", 8,
			"BenchAnvil", 1,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"BookMaintenance4", 0.1,
			"BookMaintenance5", 0.05,
			"BookMetalWelding1", 2,
			"BookMetalWelding2", 1,
			"BookMetalWelding3", 0.5,
			"BookMetalWelding4", 0.1,
			"BookMetalWelding5", 0.05,
			"BlowerFan", 2,
			"BlowTorch", 10,
			"BoltCutters", 8,
			"Calipers", 4,
			"DrawPlate", 8,
			"ElbowPad_Left_Workman", 1,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"File", 8,
			"Glasses_SafetyGoggles", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"IronBar", 4,
			"IronBarHalf", 6,
			"IronPiece", 10,
			"IronBarQuarter", 8,
			"Kneepad_Left_Workman", 4,
			"MetalBar", 10,
			"MetalPipe", 10,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"NutsBolts", 8,
			"Oxygen_Tank", 10,
			"Pliers", 8,
			"Propane_Refill", 10,
			"RespiratorFilters", 2,
			"Screwdriver", 10,
			"SheetMetal", 10,
			"SheetMetalSnips", 8,
			"SmallFileSet", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"SmallSheetMetal", 10,
			"SmithingHammer", 2,
			"SteelBar", 4,
			"SteelBarHalf", 6,
			"SteelPiece", 10,
			"SteelBarQuarter", 8,
			"ViseGrips", 4,
			"WeldingMask", 8,
			"WeldingRods", 10,
			"Wire", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"PropaneTank", 10,
			}
		}
	},
	
	CrateMetalLockers = {
		rolls = 4,
		items = {
			"Mov_GreenWallLocker", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_GreenWallLocker", 200,
			}
		}
	},
	
	CrateModernOven = {
		rolls = 1,
		items = {
			"Mov_ModernOven", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateNapkins = {
		rolls = 4,
		items = {
			-- ALREADY EXISTS. OOPS.
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateNewspapers = {
		rolls = 4,
		items = {
			"Newspaper", 50,
			"Newspaper", 20,
			"Newspaper", 20,
			"Newspaper", 10,
			"Newspaper", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateNewspapersNew = {
		isShop = true,
		rolls = 4,
		items = {
			"Newspaper_Herald_New", 50,
			"Newspaper_Herald_New", 20,
			"Newspaper_Herald_New", 20,
			"Newspaper_Herald_New", 10,
			"Newspaper_Herald_New", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateOakRoundTable = {
		rolls = 1,
		items = {
			"Mov_OakRoundTable", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateOfficeChairs = {
		rolls = 4,
		items = {
			"Mov_OfficeChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_OfficeChair", 200,
			}
		}
	},
	
	CrateOfficeSupplies = {
		isShop = true,
		rolls = 4,
		items = {
			"AdhesiveTapeBox", 0.01,
			"BluePen", 8,
			"Calculator", 8,
			"Clipboard", 8,
			"CorrectionFluid", 4,
			"Eraser", 8,
			"Glue", 2,
			"GreenPen", 4,
			"HolePuncher", 4,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Notebook", 20,
			"Notebook", 10,
			"Notepad", 20,
			"Notepad", 10,
			"Paperclip", 10,
			"PaperclipBox", 1,
			"Pen", 8,
			"Pencil", 10,
			"Pencil", 20,
			"PencilSpiffo", 0.001,
			"PenSpiffo", 0.001,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"SheetPaper2", 10,
			"Stapler", 4,
			"Staples", 10,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateOilOlive = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"OilOlive", 50,
			"OilOlive", 20,
			"OilOlive", 20,
			"OilOlive", 10,
			"OilOlive", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateOilVegetable = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"OilVegetable", 50,
			"OilVegetable", 20,
			"OilVegetable", 20,
			"OilVegetable", 10,
			"OilVegetable", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateOrangeModernChair = {
		rolls = 1,
		items = {
			"Mov_OrangeModernChair", 200,
			"Mov_OrangeFuton", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePaint = {
		isShop = true,
		rolls = 8,
		items = {
			-- Paint
			"PaintBlack", 10,
			"PaintBlue", 10,
			"PaintBrown", 10,
			"PaintGreen", 10,
			"PaintGrey", 10,
			"PaintLightBlue", 10,
			"PaintLightBrown", 10,
			"PaintRed", 10,
			"PaintWhite", 10,
			"PaintYellow", 10,
			-- Paint: Bright Colors
			"PaintCyan", 20,
			"PaintOrange", 20,
			"PaintPink", 20,
			"PaintPurple", 20,
			"PaintTurquoise", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePancakeMix = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"PancakeMix", 50,
			"PancakeMix", 20,
			"PancakeMix", 20,
			"PancakeMix", 10,
			"PancakeMix", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePaperBagJays = {
		isShop = true,
		rolls = 4,
		items = {
			"Paperbag_Jays", 50,
			"Paperbag_Jays", 20,
			"Paperbag_Jays", 20,
			"Paperbag_Jays", 10,
			"Paperbag_Jays", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePaperBagSpiffos = {
		isShop = true,
		rolls = 4,
		items = {
			"Paperbag_Spiffos", 50,
			"Paperbag_Spiffos", 20,
			"Paperbag_Spiffos", 20,
			"Paperbag_Spiffos", 10,
			"Paperbag_Spiffos", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePaperNapkins = {
		isShop = true,
		rolls = 4,
		items = {
			"PaperNapkins2", 50,
			"PaperNapkins2", 20,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			"PaperNapkins2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePasta = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Pasta", 50,
			"Pasta", 20,
			"Pasta", 20,
			"Pasta", 10,
			"Pasta", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePeanuts = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Peanuts", 50,
			"Peanuts", 20,
			"Peanuts", 20,
			"Peanuts", 10,
			"Peanuts", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePetSupplies = {
		rolls = 4,
		items = {
			"CatFoodBag", 10,
			"CatToy", 6,
			"CatTreats", 10,
			"DogChew", 6,
			"Dogfood", 20,
			"Dogfood", 10,
			"DogFoodBag", 10,
			"DogTag_Pet", 1,
			"Leash", 4,
			"Rubberducky", 4,
			"TennisBall", 8,
			"WaterDishEmpty", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePhotos = {
		rolls = 4,
		items = {
			"Photo", 50,
			"Photo", 20,
			"Photo", 20,
			"Photo", 10,
			"Photo", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePlaster = {
		isShop = true,
		rolls = 4,
		items = {
			"PlasterPowder", 50,
			"PlasterPowder", 20,
			"PlasterPowder", 20,
			"PlasterPowder", 10,
			"PlasterPowder", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"PlasterTrowel", 8,
			}
		}
	},
	
	CratePlasticChairs = {
		rolls = 4,
		items = {
			"Mov_PlasticChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_PlasticChair", 200,
			}
		}
	},
	
	CratePlasticLowTables = {
		rolls = 4,
		items = {
			"Mov_PlasticLowTable", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_PlasticLowTable", 200,
			}
		}
	},
	
	CratePlasticTrays = {
		isShop = true,
		rolls = 4,
		items = {
			"PlasticTray", 50,
			"PlasticTray", 20,
			"PlasticTray", 20,
			"PlasticTray", 10,
			"PlasticTray", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePopcorn = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Popcorn", 50,
			"Popcorn", 20,
			"Popcorn", 20,
			"Popcorn", 10,
			"Popcorn", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePottery = {
		rolls = 4,
		items = {
			"BookPottery1", 2,
			"BookPottery2", 1,
			"BookPottery3", 0.5,
			"BookPottery4", 0.1,
			"BookPottery5", 0.05,
			"Brush", 20,
			"Brush", 10,
			"Claybag", 50,
			"Claybag", 20,
			"ClayTool", 20,
			"ClayTool", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePropane = {
		isShop = true,
		rolls = 4,
		items = {
			"PropaneTank", 50,
			"PropaneTank", 20,
			"PropaneTank", 20,
			"PropaneTank", 10,
			"PropaneTank", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePurpleRattanChair = {
		rolls = 1,
		items = {
			"Mov_PurpleRattanChair", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CratePurpleWoodenChairs = {
		rolls = 4,
		items = {
			"Mov_PurpleWoodenChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_PurpleWoodenChair", 200,
			}
		}
	},
	
	CrateRandomJunk = {
		rolls = 1,
		items = {
			"Axe", 0.05,
			"BackgammonBoard", 1,
			"BadmintonRacket", 0.4,
			"Bag_ALICEpack", 0.001,
			"Bag_BigHikingBag", 0.05,
			"Bag_NormalHikingBag", 0.1,
			"BallPeenHammer", 0.6,
			"Banjo", 0.2,
			"BarBell", 0.4,
			"Baseball", 1,
			"BaseballBat", 0.2,
			"BaseballBat_Metal", 0.1,
			"Basketball", 1,
			"BathTowel", 1,
			"Battery", 4,
			"Birdie", 1,
			"BlowerFan", 0.001,
			"BlowTorch", 0.8,
			"BluePen", 0.8,
			"BoltCutters", 0.8,
			"Bobber", 1,
			"BoobTube", 1,
			"BoobTubeSmall", 1,
			"Book", 4,
			"BottleOpener", 1,
			"Bricktoys", 1,
			"Bucket", 1,
			"Bullhorn", 0.1,
			"BurlapPiece", 0.5,
			"CDplayer", 0.4,
			"Calculator", 0.8,
			"Candle", 1,
			"CanoePadel", 0.1,
			"CanoePadelX2", 0.1,
			"Canteen", 0.1,
			"CarBatteryCharger", 0.1,
			"CardDeck", 1,
			"Card_Birthday", 1,
			"Card_Christmas", 1,
			"Card_Easter", 1,
			"Card_Halloween", 1,
			"Card_Hanukkah", 1,
			"Card_LunarYear", 1,
			"Card_StPatrick", 1,
			"Card_Sympathy", 1,
			"Card_Valentine", 1,
			"CarpentryChisel", 0.5,
			"Catalog", 2,
			"CatToy", 0.6,
			"CheckerBoard", 1,
			"CircularSawblade", 0.4,
			"Clipboard", 0.8,
			"ClubHammer", 0.4,
			"CombinationPadlock", 0.4,
			"ComicBook", 1,
			"Cooler", 0.1,
			"CopperScrap", 0.1,
			"CordlessPhone", 0.2,
			"Crayons", 1,
			"Crowbar", 0.4,
			"Cube", 1,
			"DenimStrips", 1,
			"DiceBag", 1,
			"Dice_00", 1,
			"Dice_10", 1,
			"Dice_12", 1,
			"Dice_20", 1,
			"Dice_4", 1,
			"Dice_6", 1,
			"Dice_8", 1,
			"Disc_Retail", 1,
			"DogChew", 0.6,
			"Doll", 1,
			"DoodleKids", 1,
			"Drumstick", 1,
			"DuctTape", 0.4,
			"DumbBell", 1,
			"Dungarees", 0.05,
			"Earbuds", 0.4,
			"ElectricWire", 1,
			"ElectronicsScrap", 1,
			"EmptyJar", 1,
			"FieldHockeyStick", 0.2,
			"FishingHook", 1,
			"FishingLine", 1,
			"FishingNet", 1,
			"FishingTackle", 1,
			"FishingTackle2", 1,
			"Flask", 0.1,
			"Flute", 0.4,
			"Football", 1,
			"Funnel", 1,
			"GamePieceBlack", 1,
			"GamePieceRed", 1,
			"GamePieceWhite", 1,
			"GardenFork", 0.1,
			"GardenHoe", 0.2,
			"GardenSaw", 0.6,
			"Glasses_SafetyGoggles", 0.8,
			"Glue", 0.2,
			"Goblet", 0.01,
			"GolfBall", 1,
			"GolfTee", 1,
			"Golfclub", 0.8,
			"GraphPaper", 1,
			"GreenPen", 0.4,
			"GuitarAcoustic", 0.1,
			"GuitarElectricBass", 0.1,
			"GuitarElectric", 0.1,
			"HairDryer", 1,
			"HairIron", 1,
			"Hairgel", 0.2,
			"Hairspray2", 0.6,
			"HamRadio1", 0.001,
			"HamRadio2", 0.0001,
			"Hammer", 0.8,
			"HandFork", 0.1,
			"HandScythe", 0.1,
			"HandShovel", 1,
			"HandTorch", 0.8,
			"Hat_BicycleHelmet", 0.2,
			"Hat_BuildersRespirator", 0.1,
			"Hat_DustMask", 0.8,
			"Hat_HardHat", 0.4,
			"Hat_HardHat_Miner", 0.05,
			"Hat_HockeyHelmet", 0.2,
			"Hat_RidingHelmet", 0.2,
			"Hat_StrawHat", 0.1,
			"Headphones", 0.4,
			"HoodieDOWN_WhiteTINT", 0.8,
			"IceHockeyStick", 0.2,
			-- NOTE: Temporarily bumped for testing purposes.
			"IndustrialDye", 20,
			"InsectRepellent", 1,
			"Jack", 0.2,
			"JacketLong_Random", 0.8,
			"Jacket_ArmyCamoGreen", 0.1,
			"Jacket_Leather", 0.1,
			"Jacket_Varsity", 0.4,
			"Jacket_WhiteTINT", 0.8,
			"JarLid", 1,
			"JerryCanEmpty", 1,
			"JigLure", 1,
			"Jumper_DiamondPatternTINT", 0.1,
			"Jumper_PoloNeck", 0.4,
			"Jumper_RoundNeck", 0.6,
			"Jumper_VNeck", 0.6,
			"KeyRing_Clover", 0.005,
			"KeyRing_RabbitFoot", 1,
			"Keytar", 0.2,
			"Kneepad_Left", 0.1,
			"KnifeButterfly", 0.1,
			"LaCrosseStick", 0.2,
			"LeafRake", 1,
			"Leash", 0.4,
			"LeatherStrips", 1,
			"LightBulb", 1,
			"Lighter", 1,
			"Loupe", 0.1,
			"LugWrench", 0.4,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"MagazineCrossword", 1,
			"MagazineWordsearch", 1,
			"MagnifyingGlass", 0.4,
			"MarkerBlack", 0.2,
			"MarkerBlue", 0.1,
			"MarkerGreen", 0.1,
			"MarkerRed", 0.1,
			"Matchbox", 10,
			"MeasuringTape", 1,
			"Medal_Bronze", 0.005,
			"Medal_Silver", 0.002,
			"Medal_Gold", 0.001,
			"MetalBar", 0.6,
			"MetalPipe", 0.6,
			"MinnowLure", 1,
			"NailsBox", 1,
			"Needle", 1,
			"Newspaper", 1,
			"Notebook", 1,
			"Notepad", 0.8,
			"NutsBolts", 1,
			"Padlock", 0.4,
			"PaintBlack", 0.4,
			"PaintBlue", 0.4,
			"PaintBrown", 0.4,
			"PaintCyan", 0.4,
			"PaintGreen", 0.4,
			"PaintGrey", 0.4,
			"PaintLightBlue", 0.4,
			"PaintLightBrown", 0.4,
			"PaintOrange", 0.4,
			"PaintPink", 0.4,
			"PaintPurple", 0.4,
			"PaintRed", 0.4,
			"PaintTurquoise", 0.4,
			"PaintWhite", 0.4,
			"PaintYellow", 0.4,
			"Paintbrush", 10,
			"Paperback", 8,
			"Paperclip", 1,
			"PaperclipBox", 0.1,
			"Pen", 0.8,
			"Pencil", 1,
			"Phonebook", 1,
			"PickAxe", 0.05,
			"Pillow", 1,
			"Pipe", 0.6,
			"PipeWrench", 0.6,
			"PlasterTrowel", 10,
			"Pliers", 1,
			"PokerChips", 2,
			"PonchoGreenDOWN", 0.2,
			"PotScrubberFrog", 0.001,
			"PowerBar", 0.4,
			"PremiumFishingLine", 0.2,
			"PropaneTank", 0.5,
			"RPGmanual", 1,
			"RadioBlack", 0.2,
			"RadioRed", 0.1,
			"Rake", 1,
			"RakeHead", 0.4,
			"Ratchet", 1,
			"RecipeClipping", 1,
			"RedPen", 0.8,
			"Remote", 0.4,
			"RubberBand", 0.6,
			"RubberHose", 1,
			"Rubberducky", 0.4,
			"Saw", 0.8,
			"Saxophone", 0.4,
			"SCBA_notank", 0.1,
			"Scissors", 0.2,
			"ScissorsBlunt", 0.2,
			"ScissorsBluntMedical", 0.1,
			"Scotchtape", 0.2,
			"ScrapMetal", 0.2,
			"Screwdriver", 0.8,
			"ScrewsBox", 0.8,
			"SeedBag", 0.1,
			"SewingKit", 0.6,
			"Sheet", 1,
			"SheetMetal", 0.8,
			"SheetPaper2", 1,
			"Shirt_Baseball_KY", 0.4,
			"Shirt_Baseball_Rangers", 0.4,
			"Shirt_Baseball_Z", 0.4,
			"Shirt_CamoGreen", 0.2,
			"Shirt_CropTopNoArmTINT", 1,
			"Shirt_CropTopTINT", 1,
			"Shirt_Denim", 0.6,
			"Shirt_FormalTINT", 0.6,
			"Shirt_FormalWhite", 0.8,
			"Shirt_FormalWhite_ShortSleeve", 0.6,
			"Shirt_FormalWhite_ShortSleeveTINT", 0.6,
			"Shirt_Lumberjack", 0.1,
			"Shirt_Lumberjack_TINT", 0.1,
			"Shoes_ArmyBoots", 0.1,
			"Shoes_ArmyBootsDesert", 0.1,
			"Shoes_Black", 0.8,
			"Shoes_BlackBoots", 0.2,
			"Shoes_BlueTrainers", 0.4,
			"Shoes_Brown", 0.8,
			"Shoes_FlipFlop", 0.4,
			"Shoes_HikingBoots", 0.1,
			"Shoes_RedTrainers", 0.4,
			"Shoes_RidingBoots", 0.2,
			"Shoes_TrainerTINT", 0.8,
			"Shoes_Wellies", 0.1,
			"Shoes_WorkBoots", 0.1,
			"Shorts_CamoGreenLong", 0.2,
			"Shorts_LongSport", 0.6,
			"Shorts_ShortSport", 0.8,
			"Shovel", 0.4,
			"Shovel2", 0.4,
			"SleepingBag_Cheap_Blue_Packed", 0.1,
			"SleepingBag_Cheap_Green2_Packed", 0.1,
			"SleepingBag_Cheap_Green_Packed", 0.1,
			"SmallSheetMetal", 0.8,
			"SnowShovel", 0.2,
			"SoccerBall", 1,
			"Speaker", 0.1,
			"Sportsbottle", 0.1,
			"SteelWool", 1,
			"SwitchKnife", 0.1,
			"TVMagazine", 1,
			"Tacklebox", 0.1,
			"Tarp", 1,
			"TennisBall", 0.8,
			"TennisRacket", 0.4,
			"TentBlue_Packed", 0.01,
			"TentBrown_Packed", 0.01,
			"TentGreen_Packed", 0.01,
			"TentYellow_Packed", 0.01,
			"Thread", 10,
			"TireIron", 0.4,
			"TirePump", 0.6,
			"Torch", 0.4,
			"ToyBear", 1,
			"ToyCar", 1,
			"TrophyBronze", 0.1,
			"TrophyGold", 0.001,
			"TrophySilver", 0.01,
			"TrousersMesh_DenimLight", 0.8,
			"Trousers_CamoGreen", 0.2,
			"Trousers_DefaultTEXTURE_TINT", 0.8,
			"Trousers_Denim", 0.8,
			"Trousers_JeanBaggy", 0.8,
			"Trousers_Sport", 0.8,
			"Trousers_Suit", 0.4,
			"Trousers_SuitTEXTURE", 0.6,
			"Trousers_SuitWhite", 0.6,
			"Trousers_WhiteTINT", 0.8,
			"Trumpet", 0.4,
			"Tshirt_ArmyGreen", 0.2,
			"Tshirt_CamoGreen", 0.2,
			"Tshirt_DefaultDECAL_TINT", 0.6,
			"Tshirt_DefaultTEXTURE_TINT", 0.6,
			"Tshirt_IndieStoneDECAL", 0.1,
			"Tshirt_LongSleeve_SuperColor", 0.2,
			"Tshirt_PoloStripedTINT", 0.4,
			"Tshirt_PoloTINT", 0.4,
			"Tshirt_Sport", 0.8,
			"Tshirt_SportDECAL", 0.6,
			"Tshirt_SuperColor", 0.2,
			"Tshirt_TieDye", 0.2,
			"Tshirt_WhiteLongSleeveTINT", 0.8,
			"Tshirt_WhiteTINT", 0.8,
			"Tsquare", 0.1,
			"VHS_Retail", 1,
			"Vest_DefaultTEXTURE_TINT", 0.8,
			"Vest_Hunting_Camo", 0.05,
			"Vest_Hunting_CamoGreen", 0.05,
			"Vest_Hunting_Grey", 0.01,
			"Vest_Hunting_Orange", 0.05,
			"VideoGame", 0.2,
			"Violin", 0.2,
			"ViseGrips", 0.5,
			"WalkieTalkie1", 0.1,
			"WalkieTalkie2", 0.05,
			"WalkieTalkie3", 0.025,
			"WalkieTalkie4", 0.01,
			"WallpaperPastePowder", 0.1,
			"WaterDishEmpty", 0.4,
			"WaterPurificationTablets", 0.1,
			"WeldingMask", 0.4,
			"WeldingRods", 0.8,
			"Whistle", 1,
			"Wire", 0.6,
			"WoodAxe", 0.025,
			"WoodenMallet", 0.4,
			"Woodglue", 0.2,
			"Wrench", 0.6,
			"Yoyo", 1,
		},
		junk = ClutterTables.ClosetJunk,
	},
	
	CrateRedBBQ = {
		rolls = 4,
		items = {
			"Apron_BBQ", 8,
			"BastingBrush", 10,
			"CarvingFork2", 10,
			"Charcoal", 1,
			"Charcoal", 1,
			"Charcoal", 1,
			"Charcoal", 1,
			"GrillBrush", 10,
			"KitchenTongs", 10,
			"LighterBBQ", 4,
			"OvenMitt", 10,
			"Spatula", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_RedBBQ", 200,
			}
		}
	},
	
	CrateRedChairs = {
		rolls = 4,
		items = {
			"Mov_RedChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_RedChair", 200,
			}
		}
	},
	
	CrateRedOven = {
		rolls = 1,
		items = {
			"Mov_RedOven", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateRice = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Rice", 50,
			"Rice", 20,
			"Rice", 20,
			"Rice", 10,
			"Rice", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateRiceVinegar = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"RiceVinegar", 50,
			"RiceVinegar", 20,
			"RiceVinegar", 20,
			"RiceVinegar", 10,
			"RiceVinegar", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateRedWoodenChairs = {
		rolls = 4,
		items = {
			"Mov_RedWoodenChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_RedWoodenChair", 200,
			}
		}
	},
	
	CrateRoundTable = {
		rolls = 1,
		items = {
			"Mov_RoundTable", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSalonSupplies = {
		isShop = true,
		rolls = 4,
		items = {
			"HairDyeCommon", 20,
			"HairDyeCommon", 20,
			"HairDyeCommon", 10,
			"HairDyeCommon", 10,
			"HairDyeUncommon", 20,
			"HairDyeUncommon", 10,
			"Hairgel", 20,
			"Hairgel", 10,
			"Hairspray2", 20,
			"Hairspray2", 20,
			"Hairspray2", 10,
			"Hairspray2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSandBags = {
		isShop = true,
		rolls = 4,
		items = {
			"Sandbag", 50,
			"Sandbag", 20,
			"Sandbag", 20,
			"Sandbag", 10,
			"Sandbag", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSeaweed = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Seaweed", 50,
			"Seaweed", 20,
			"Seaweed", 20,
			"Seaweed", 10,
			"Seaweed", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSheetMetal = {
		isShop = true,
		rolls = 6,
		items = {
			"SheetMetal", 50,
			"SheetMetal", 20,
			"SheetMetal", 20,
			"SheetMetal", 10,
			"SheetMetal", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSkeletonDisplay = {
		rolls = 1,
		items = {
			"Mov_SkeletonDisplay", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSmallTables = {
		rolls = 4,
		items = {
			"Mov_SmallTable", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_SmallTable", 200,
			}
		}
	},
	
	CrateSoccerBalls = {
		isShop = true,
		rolls = 4,
		items = {
			"SoccerBall", 50,
			"SoccerBall", 20,
			"SoccerBall", 20,
			"SoccerBall", 10,
			"SoccerBall", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSodaBottles = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"PopBottle", 50,
			"PopBottle", 20,
			"PopBottle", 20,
			"PopBottle", 10,
			"PopBottle", 10,
			"PopBottleRare", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSodaCans = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Pop", 20,
			"Pop", 10,
			"Pop2", 20,
			"Pop2", 10,
			"Pop3", 20,
			"Pop3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSoysauce = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Soysauce", 50,
			"Soysauce", 20,
			"Soysauce", 20,
			"Soysauce", 10,
			"Soysauce", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Spiffo Merchandise box. Mugs should be Ultra-Rare since they are also a scenery item.
	-- Wearable Spiffo costumes are meant to ONLY show up on zombies! NOT in containers!
	CrateSpiffoMerch = {
		isShop = true,
		rolls = 1,
		items = {
			"Apron_Spiffos", 8,
			"BorisBadger", 10,
			"FluffyfootBunny", 10,
			"FreddyFox", 10,
			"FurbertSquirrel", 10,
			"JacquesBeaver", 10,
			"MoleyMole", 10,
			"MugSpiffo", 0.001,
			"PancakeHedgehog", 10,
			"PenSpiffo", 10,
			"PencilSpiffo", 10,
			"SpiffoBig", 0.001,
			"Tie_Full_Spiffo", 8,
			"Tie_Worn_Spiffo", 8,
			"Tshirt_BusinessSpiffo", 8,
			"Tshirt_SpiffoDECAL", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSports = {
		rolls = 4,
		items = {
			"AthleticCup", 4,
			"BadmintonRacket", 10,
			"BarBell", 8,
			"Baseball", 20,
			"Baseball", 10,
			"BaseballBat", 6,
			"BaseballBat_Metal", 4,
			"Basketball", 20,
			"Basketball", 10,
			"Birdie", 20,
			"Birdie", 10,
			"Book_Sports", 4,
			"CanoePadel", 6,
			"CanoePadelX2", 6,
			"DumbBell", 4,
			"ElbowPad_Left_Sport", 0.1,
			"ElbowPad_Left_TINT", 0.05,
			"FieldHockeyStick", 6,
			"Football", 20,
			"Football", 10,
			"Gloves_BoxingBlue", 2,
			"Gloves_BoxingRed", 2,
			"GolfBall", 20,
			"GolfBall", 10,
			"Golfclub", 8,
			"GolfTee", 20,
			"GolfTee", 10,
			"Hat_BaseballHelmet", 4,
			"Hat_BoxingBlue", 4,
			"Hat_BoxingRed", 4,
			"Hat_FootballHelmet", 2,
			"Hat_HockeyHelmet", 2,
			"Hat_HockeyMask", 4,
			"IceHockeyStick", 6,
			"Kneepad_Left_Sport", 2,
			"Kneepad_Left_TINT", 0.5,
			"LaCrosseStick", 6,
			"Magazine_Sports", 10,
			"Paperback_Sports", 8,
			"ShinKneeGuard_L", 4,
			"Shinpad_HockeyGoalie_L", 4,
			"Shinpad_L", 4,
			"Shorts_FootballPants", 4,
			"Shorts_HockeyPants", 4,
			"Shoulderpads_Football", 2,
			"Shoulderpads_IceHockey", 2,
			"SoccerBall", 20,
			"SoccerBall", 10,
			"TennisBall", 20,
			"TennisBall", 10,
			"TennisRacket", 10,
			"TrophyBronze", 10,
			"TrophyGold", 1,
			"TrophySilver", 5,
			"Vest_CatcherVest", 4,
			"Whistle", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateStoneBlocks = {
		isShop = true,
		rolls = 4,
		items = {
			"StoneBlock", 50,
			"StoneBlock", 20,
			"StoneBlock", 20,
			"StoneBlock", 10,
			"StoneBlock", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSugar = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Sugar", 50,
			"Sugar", 20,
			"Sugar", 20,
			"Sugar", 10,
			"Sugar", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSugarBrown = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"SugarBrown", 50,
			"SugarBrown", 20,
			"SugarBrown", 20,
			"SugarBrown", 10,
			"SugarBrown", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateSunflowerSeeds = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"SunflowerSeeds", 50,
			"SunflowerSeeds", 20,
			"SunflowerSeeds", 20,
			"SunflowerSeeds", 10,
			"SunflowerSeeds", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateTacoShells = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"TacoShell", 50,
			"TacoShell", 20,
			"TacoShell", 20,
			"TacoShell", 10,
			"TacoShell", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateTailoring = {
		rolls = 4,
		items = {
			"Awl", 8,
			"Buckle", 4,
			"BookTailoring1", 2,
			"BookTailoring2", 1,
			"BookTailoring3", 0.5,
			"BookTailoring4", 0.1,
			"BookTailoring5", 0.05,
			"DenimStrips", 10,
			"LeatherStrips", 10,
			-- NOTE: Temporarily bumped for testing purposes.
			"IndustrialDye", 50,
			"Needle", 20,
			"SewingKit", 6,
			"HoodieDOWN_WhiteTINT", 2,
			"Shirt_Denim", 2,
			"Shirt_FormalWhite", 8,
			"Shirt_FormalWhite", 8,
			"Shirt_FormalTINT", 4,
			"Shirt_FormalTINT", 4,
			"Thread", 20,
			"Thread", 10,
			"Shirt_Lumberjack", 2,
			"Shirt_Lumberjack_TINT", 2,
			"Trousers_Denim", 2,
			"Trousers_JeanBaggy", 2,
			"Trousers_Suit", 8,
			"Trousers_Suit", 8,
			"Trousers_SuitTEXTURE", 8,
			"Trousers_SuitTEXTURE", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateTea = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Teabag2", 50,
			"Teabag2", 20,
			"Teabag2", 20,
			"Teabag2", 10,
			"Teabag2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateToiletPaper = {
		rolls = 4,
		isShop = true,
		items = {
			"ToiletPaper", 50,
			"ToiletPaper", 20,
			"ToiletPaper", 20,
			"ToiletPaper", 10,
			"ToiletPaper", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateTomatoPaste = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"TomatoPaste", 50,
			"TomatoPaste", 20,
			"TomatoPaste", 20,
			"TomatoPaste", 10,
			"TomatoPaste", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Usually found in garages. Weighted towards home maintenance.
	CrateTools = {
		rolls = 4,
		items = {
			-- Gardening/Lawncare
			"Axe", 0.05,
			"GardenFork", 1,
			"GardenHoe", 2,
			"GardenSaw", 8,
			"HandAxe", 1,
			"HandFork", 1,
			"HandScythe", 1,
			"HandShovel", 8,
			"LeafRake", 8,
			"Machete", 0.01,
			"PickAxe", 0.5,
			"Rake", 8,
			"RakeHead", 1,
			"Scythe", 1,
			"Shovel", 4,
			"Shovel2", 4,
			"SnowShovel", 2,
			"WoodAxe", 0.025,
			-- Mechanics
			"Funnel", 8,
			"Jack", 1,
			"LugWrench", 4,
			"Ratchet", 4,
			"RubberHose", 8,
			"TireIron", 4,
			"TirePump", 4,
			-- Tools - Simple
			"ClubHammer", 2,
			"Crowbar", 2,
			"Hammer", 4,
			"HandDrill", 4,
			"KnifePocket", 0.1,
			"LargeKnife", 1,
			"PipeWrench", 4,
			"Pliers", 4,
			"Saw", 4,
			"Screwdriver", 6,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"WoodenMallet", 2,
			-- Tools - Skill-related
			"BallPeenHammer", 2,
			"BlowTorch", 2,
			"BoltCutters", 2,
			"Calipers", 1,
			"CarpentryChisel", 2,
			"File", 1,
			"MasonsChisel", 1,
			"MasonsTrowel", 1,
			"MetalworkingChisel", 1,
			"MetalworkingPliers", 0.1,
			"MetalworkingPunch", 1,
			"PlasterTrowel", 4,
			"SheetMetalSnips", 1,
			"SmallFileSet", 1,
			"SmallPunchSet", 1,
			"SmallSaw", 1,
			"Tongs", 1,
			"ViseGrips", 2,
			-- Materials
			"DuctTape", 4,
			"Epoxy", 1,
			"Handle", 4,
			"HeavyChain", 1,
			"LongHandle", 2,
			"LongStick", 2,
			"NailsBox", 4,
			"NutsBolts", 4,
			"Rope", 2,
			"ScrewsBox", 2,
			"SmallHandle", 4,
			"Twine", 8,
			"Whetstone", 10,
			"WoodenStick2", 4,
			"Woodglue", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"MeasuringTape", 10,
			}
		}
	},
	
	CrateToolsOld = {
		rolls = 4,
		isWorn = true,
		items = {
			"Axe_Old", 0.05,
			"BallPeenHammerForged", 6,
			"BlowTorch", 8,
			"BoltCutters", 8,
			"Calipers", 2,
			"ClubHammerForged", 4,
			"CrowbarForged", 4,
			"File", 2,
			"Fleshing_Tool", 10,
			"Funnel", 10,
			"Gaffhook", 1,
			"GardenFork_Forged", 1,
			"GardenHoeForged", 2,
			"GardenSaw", 10,
			"HammerForged", 8,
			"HandAxeForged", 1,
			"HandAxe_Old", 1,
			"HandDrill", 4,
			"HandFork", 1,
			"HandScytheForged", 1,
			"HandShovel", 10,
			"HeavyChain", 8,
			"LargeHook", 1,
			"LargeKnife", 1,
			"LeafRake", 10,
			"LugWrench", 4,
			"MacheteForged", 0.01,
			"MasonsChisel", 2,
			"MasonsTrowel", 2,
			"MetalworkingChisel", 2,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 2,
			"OldDrill", 1,
			"PickAxeForged", 0.5,
			"PipeWrench", 6,
			"PlasterTrowel", 10,
			"Pliers", 8,
			"Rake", 10,
			"Ratchet", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"ScytheForged", 1,
			"SheepShearsForged", 2,
			"SheetMetalSnips", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.01,
			"SledgehammerForged", 0.01,
			"SmallFileSet", 2,
			"SmallPunchSet", 2,
			"SmallSaw", 2,
			"SnowShovel", 2,
			"SpadeForged", 4,
			"TireIron", 4,
			"TirePump", 8,
			"Tongs", 2,
			"ViseGrips", 4,
			"Whetstone", 10,
			"WoodAxeForged", 0.025,
			"WoodenMallet", 4,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateTortillaChips = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"TortillaChips", 50,
			"TortillaChips", 20,
			"TortillaChips", 20,
			"TortillaChips", 10,
			"TortillaChips", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateToys = {
		rolls = 4,
		items = {
			-- Toys
			"Bricktoys", 20,
			"Bricktoys", 10,
			"CardDeck", 10,
			"Crayons", 10,
			"Cube", 10,
			"Doll", 20,
			"Doll", 10,
			"RubberSpider", 10,
			"ToyBear", 20,
			"ToyBear", 10,
			"ToyCar", 10,
			"Yoyo", 10,
			-- Hats/Masks
			"Hat_HalloweenMaskDevil", 0.01,
			"Hat_HalloweenMaskMonster", 0.01,
			"Hat_HalloweenMaskPumpkin", 0.01,
			"Hat_HalloweenMaskSkeleton", 0.01,
			"Hat_HalloweenMaskVampire", 0.01,
			"Hat_HalloweenMaskWitch", 0.01,
			"Hat_Pirate", 0.01,
			"Hat_Wizard", 0.01,
			-- Collectibles
			"BorisBadger", 0.01,
			"FluffyfootBunny", 0.01,
			"FreddyFox", 0.01,
			"FurbertSquirrel", 0.01,
			"JacquesBeaver", 0.01,
			"MoleyMole", 0.01,
			"PancakeHedgehog", 0.01,
			"PanchoDog", 0.01,
			"Plushabug", 0.01,
			"Spiffo", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateTV = {
		rolls = 1,
		items = {
			"TvBlack", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateTVWide = {
		rolls = 1,
		items = {
			"TvWideScreen", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateVHSTapes = {
		rolls = 4,
		items = {
			"Magazine_Cinema", 10,
			"VHS_Retail", 50,
			"VHS_Retail", 20,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
			"VHS_Retail", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateWallFinish = {
		rolls = 4,
		items = {
			"Bucket", 2,
			"PaintBlack", 1,
			"PaintBlue", 1,
			"PaintBrown", 1,
			"PaintCyan", 1,
			"PaintGreen", 1,
			"PaintGrey", 1,
			"PaintLightBlue", 1,
			"PaintLightBrown", 1,
			"PaintOrange", 1,
			"PaintPink", 1,
			"PaintPurple", 1,
			"PaintRed", 1,
			"PaintTurquoise", 1,
			"PaintWhite", 1,
			"PaintYellow", 1,
			"Paintbrush", 4,
			"PlasterPowder", 8,
			"PlasterPowder", 8,
			"PlasterTrowel", 10,
			"Wallpaper_BeigeStripe", 1,
			"Wallpaper_BlackFloral", 1,
			"Wallpaper_BlueStripe", 1,
			"Wallpaper_GreenDiamond", 1,
			"Wallpaper_GreenFloral", 1,
			"Wallpaper_PinkChevron", 1,
			"Wallpaper_PinkFloral", 1,
			"WallpaperPastePowder", 8,
			"WallpaperPastePowder", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateWhiteComfyChair = {
		rolls = 1,
		items = {
			"Mov_WhiteComfyChair", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateWhiteSimpleChairs = {
		rolls = 4,
		items = {
			"Mov_WhiteSimpleChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_WhiteSimpleChair", 200,
			}
		}
	},
	
	CrateWhiteSinks = {
		rolls = 4,
		items = {
			"Mov_WhiteSink", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_WhiteSink", 200,
			}
		}
	},
	
	CrateWhiteWoodenChairs = {
		rolls = 4,
		items = {
			"Mov_WhiteWoodenChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_WhiteWoodenChair", 200,
			}
		}
	},
	
	CrateWoodenChairs = {
		rolls = 4,
		items = {
			"Mov_WoodenChair", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_WoodenChair", 200,
			}
		}
	},
	
	CrateWoodenStools = {
		rolls = 4,
		items = {
			"Mov_WoodenStool", 50,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_WoodenStool", 200,
			}
		}
	},
	
	CrateYeast = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Yeast", 50,
			"Yeast", 20,
			"Yeast", 20,
			"Yeast", 10,
			"Yeast", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateYellowModernChair = {
		rolls = 1,
		items = {
			"Mov_YellowModernChair", 200,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrateWallets = {
		isShop = true,
		rolls = 4,
		items = {
			"Wallet", 20,
			"Wallet", 20,
			"Wallet", 20,
			"Wallet", 20,
			"Wallet", 10,
			"Wallet", 10,
			"Wallet", 10,
			"Wallet", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Refill bottles for office water dispensers.
	CrateWaterDispenserBottle = {
		isShop = true,
		rolls = 4,
		items = {
			"WaterDispenserBottle", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"WaterDispenserBottle", 100,
			}
		}
	},
	
	CrateWine = {
		isShop = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Champagne", 4,
			"Port", 10,
			"Sherry", 10,
			"Vermouth", 10,
			"Wine", 20,
			"Wine2", 20,
			"WineAged", 8,
			"WineBox", 20,
			"WineScrewtop", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		},
	},
	
	CrepeKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"BakingSoda", 8,
			"CannedMilk", 2,
			"CannedMilk_Box", 0.001,
			"Cinnamon", 8,
			"OilVegetable", 4,
			"PancakeMix", 20,
			"PancakeMix", 10,
			"Sugar", 8,
			"SugarBrown", 8,
			"Yeast", 4,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
			-- Utensils
			"BreadKnife", 8,
			"KitchenTongs", 10,
			"Ladle", 10,
			"RollingPin", 8,
			"Whisk", 10,
			-- Misc.
			"Aluminum", 8,
			"DishCloth", 10,
			"OvenMitt", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrepeKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Fruit
			"Apple", 4,
			"Banana", 4,
			"Cherry", 8,
			"Lemon", 4,
			"Lime", 4,
			"Orange", 4,
			"Peach", 4,
			"Pineapple", 2,
			"Strewberrie", 8,
			-- Meat
			"Bacon", 8,
			"Ham", 4,
			-- Misc.
			"Butter", 8,
			"EggCarton", 2,
			"Lard", 4,
			"Margarine", 4,
			"Milk", 8,
			-- Sauces/Condiments
			"JamFruit", 8,
			"JamMarmalade", 4,
			"Ketchup", 2,
			"MapleSyrup", 20,
			"MapleSyrup", 10,
			"MayonnaiseFull", 2,
			"Mustard", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CrepeKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Condiments
			"CannedMilk", 2,
			"CannedMilk_Box", 0.001,
			"JamFruit", 8,
			"JamMarmalade", 4,
			"MapleSyrup", 20,
			"MapleSyrup", 10,
			"PeanutButter", 4,
			-- Utensils
			"Ladle", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
			-- Misc.
			"DishCloth", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CultistClothing = {
		rolls = 4,
		items = {
			-- Clothing
			"Boilersuit_Flying", 1,
			"Dress_Knees_Crafted_Burlap", 2,
			"Dress_Knees_Crafted_Cotton", 2,
			"Dress_Long_Crafted_Cotton", 2,
			"Dress_Knees_Crafted_DenimLight", 2,
			"Dungarees", 4,
			"PonchoGreenDOWN", 10,
			"Shirt_Crafted_Burlap", 2,
			"Shirt_Crafted_Cotton", 2,
			"Shirt_Crafted_DenimRandom", 2,
			"Shirt_Denim", 2,
			"Shirt_Lumberjack_Green", 8,
			"Trousers_Crafted_DenimRandom", 8,
			"Trousers_Denim", 4,
			"Tshirt_TieDye", 10,
			"Vest_DefaultTEXTURE", 10,
			"Vest_Hunting_Camo", 1,
			"Vest_Hunting_CamoGreen", 1,
			-- Underwear
			"Bra_Strapless_White", 2,
			"Briefs_SmallTrunks_WhiteTINT", 2,
			"Briefs_White", 2,
			"Underpants_White", 2,
			-- Footwear
			"Shoes_ArmyBoots", 2,
			"Shoes_Random", 2,
			"Shoes_Sandals", 4,
			"Shoes_TireSandals", 10,
			"Shoes_Wellies", 8,
			"Shoes_WorkBoots", 2,
			-- Misc.
			"Belt2", 4,
			"Hat_Bandana_Green", 10,
			"Hat_StrawHat", 4,
			"RopeBelt", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	CyberCafeDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_BlueFox", 0.01,
			"KeyRing_Bug", 0.01,
			"KeyRing_Hotdog", 0.01,
			"KeyRing_Kitty", 0.01,
			"KeyRing_RainbowStar", 0.01,
			"KeyRing_RubberDuck", 0.01,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- Literature (Skills)
			"ArmorMag1", 1,
			"ArmorMag3", 1,
			"ArmorMag4", 1,
			"ArmorMag5", 1,
			"ArmorMag6", 1,
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"TrickMag1", 1,
			"WeaponMag1", 1,
			"WeaponMag4", 1,
			"WeaponMag6", 1,
			-- Literature (Generic)
			"Book_Computer", 4,
			"ComicBook", 10,
			"Magazine_Gaming", 10,
			"Magazine_Tech", 10,
			"Paperback_Computer", 8,
			"Paperback_Fantasy", 4,
			"Paperback_SciFi", 4,
			-- Hobbies (Gaming)
			"CigarBox_Gaming", 1,
			"Dice", 1,
			"DiceBag", 4,
			"Dice_00", 1,
			"Dice_10", 1,
			"Dice_12", 1,
			"Dice_20", 1,
			"Dice_4", 1,
			"Dice_6", 1,
			"Dice_8", 1,
			"GraphPaper", 20,
			"RPGmanual", 8,
			"TrickMag1", 0.1,
			"VideoGame", 10,
			-- Hobbies (Electronics/Radio)
			"Battery", 10,
			"BatteryBox", 1,
			"ElectricWire", 4,
			"ElectronicsScrap", 20,
			"Epoxy", 1,
			"LightBulbGreen", 4,
			"LightBulbRed", 4,
			"RadioBlack", 2,
			"RadioReceiver", 4,
			"RadioRed", 1,
			"RadioTransmitter", 4,
			"ScannerModule", 4,
			"Screwdriver", 4,
			-- Misc.
			"Cashbox", 0.1,
			"Money",  10,
			"Receipt", 50,
			"Receipt", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"Katana", 0.001,
				"Mace", 0.001,
				"Sword", 0.001,
			}
		}
	},
	
	CyberCafeFilingCabinet = {
		rolls = 4,
		items = {
			-- Literature (Skills)
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			-- Literature (Generic)
			"Book_Computer", 10,
			"ComicBook", 20,
			"Magazine_Gaming", 20,
			"Magazine_Tech", 20,
			"Paperback_Computer", 20,
			"Paperback_Fantasy", 8,
			"Paperback_SciFi", 8,
			-- Hobbies (Gaming)
			"GraphPaper", 50,
			"GraphPaper", 20,
			"RPGmanual", 20,
			"RPGmanual", 10,
			"TrickMag1", 0.5,
			-- Misc.
			"Cashbox", 0.1,
			"Receipt", 50,
			"Receipt", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DaycareCounter = {
		rolls = 4,
		items = {
			"BluePen", 8,
			"Book_Childs", 4,
			"BorisBadger", 0.001,
			"Bricktoys", 6,
			"Bucket", 1,
			"ChildsPictureBook", 4,
			"Crayons", 10,
			"Crayons", 20,
			"Doll", 4,
			"DoodleKids", 4,
			"Eraser", 8,
			"FirstAidKit", 1,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"Glue", 2,
			"GreenPen", 4,
			"Hat_Pilgrim", 0.5,
			"Hat_Pirate", 0.5,
			"Hat_Witch", 0.5,
			"Hat_Wizard", 0.01,
			"JacquesBeaver", 0.001,
			"Magazine_Childs", 10,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"MoleyMole", 0.001,
			"PancakeHedgehog", 0.001,
			"Paperback_Childs", 8,
			"Pencil", 10,
			"PencilSpiffo", 0.005,
			"PenMultiColor", 2,
			"PenSpiffo", 0.005,
			"Pillow", 10,
			"Pillow_Happyface", 1,
			"Pillow_Star", 1,
			"Plushabug", 0.001,
			"RedPen", 8,
			"RubberBand", 6,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			"Sheet", 10,
			"SheetPaper2", 10,
			"Soap2", 10,
			"Spiffo", 0.001,
			"Sponge", 10,
			"ToyBear", 6,
			"ToyCar", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			},
		}
	},
	
	DaycareDesk = {
		rolls = 4,
		items = {
			"BluePen", 8,
			"Book_Childs", 4,
			"BorisBadger", 0.001,
			"Bricktoys", 6,
			"ChildsPictureBook", 4,
			"Clitter", 1,
			"ComicBook_Retail", 1,
			"CookieChocolateChip", 1,
			"CookiesOatmeal", 1,
			"Crayons", 20,
			"Crayons", 10,
			"Doll", 4,
			"DoodleKids", 8,
			"Eraser", 8,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"Glue", 2,
			"GreenPen", 4,
			"JacquesBeaver", 0.001,
			"JuiceBox", 0.5,
			"JuiceBoxApple", 0.5,
			"JuiceBoxFruitpunch", 0.5,
			"JuiceBoxOrange", 0.5,
			"Lollipop", 1,
			"Magazine_Childs", 10,
			"Milk_Personalsized", 1,
			"MilkChocolate_Personalsized", 1,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"MenuCard", 1,
			"MoleyMole", 0.001,
			"Note", 20,
			"Note", 10,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"Paperback_Childs", 8,
			"Pen", 8,
			"Pencil", 10,
			"PencilSpiffo", 0.005,
			"PenMultiColor", 2,
			"PenSpiffo", 0.005,
			"Plushabug", 0.001,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			"SheetPaper2", 10,
			"Spiffo", 0.001,
			"ToyBear", 6,
			"ToyCar", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DaycareShelves = {
		rolls = 4,
		items = {
			"BluePen", 8,
			"Book_Childs", 4,
			"BorisBadger", 0.001,
			"Bricktoys", 6,
			"ChildsPictureBook", 8,
			"Clipboard", 8,
			"Crayons", 20,
			"Crayons", 10,
			"Doll", 4,
			"DoodleKids", 4,
			"Eraser", 8,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"Glue", 2,
			"GreenPen", 4,
			"Hat_Pilgrim", 0.5,
			"Hat_Pirate", 0.5,
			"Hat_Witch", 0.5,
			"Hat_Wizard", 0.5,
			"JacquesBeaver", 0.001,
			"Magazine_Childs", 10,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"MoleyMole", 0.001,
			"Notepad", 8,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"Paperback_Childs", 8,
			"Pen", 8,
			"Pencil", 10,
			"PenFancy", 0.5,
			"PenMultiColor", 2,
			"Pillow", 10,
			"Pillow_Happyface", 0.5,
			"Pillow_Star", 0.5,
			"Plushabug", 0.001,
			"RadioBlack", 1,
			"RadioRed", 1,
			"RedPen", 8,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			"Sheet", 10,
			"SheetPaper2", 10,
			"Spiffo", 0.001,
			"ToyBear", 6,
			"ToyCar", 6,
			"Twine", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DeepFryKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Chicken", 8,
			"FishFillet", 8,
			"Frozen_ChickenNuggets", 8,
			"Frozen_FishFingers", 8,
			"Oysters", 8,
			"Shrimp", 8,
			-- Fries
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 10
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DeepFryKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Chicken", 8,
			"FishFillet", 8,
			"Oysters", 8,
			"Shrimp", 8,
			-- Misc.
			"EggCarton", 4,
			"Milk", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DepartmentStoreJewelry = {
		isShop = true,
		rolls = 4,
		items = {
			"Bracelet_BangleRightGold", 4,
			"Bracelet_BangleRightSilver", 6,
			"Bracelet_ChainRightGold", 4,
			"Bracelet_ChainRightSilver", 6,
			"Bracelet_LeftFriendshipTINT", 10,
			"Earring_Dangly_Pearl", 8,
			"Earring_Pearl", 8,
			"Earring_Stud_Gold", 4,
			"Earring_Stud_Silver", 6,
			"NecklaceLong_Gold", 4,
			"NecklaceLong_Silver", 6,
			"Necklace_Crucifix", 10,
			"Necklace_Gold", 4,
			"Necklace_Pearl", 8,
			"Necklace_Silver", 6,
			"Necklace_SilverCrucifix", 8,
			"Necklace_YingYang", 10,
			"Ring_Left_RingFinger_Gold", 4,
			"Ring_Left_RingFinger_Silver", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DepartmentStoreWatches = {
		isShop = true,
		rolls = 4,
		items = {
			"Pocketwatch", 1,
			"WristWatch_Left_ClassicBlack", 8,
			"WristWatch_Left_ClassicBlack", 8,
			"WristWatch_Left_ClassicBrown", 8,
			"WristWatch_Left_ClassicBrown", 8,
			"WristWatch_Left_ClassicGold", 4,
			"WristWatch_Left_ClassicGold", 4,
			"WristWatch_Left_DigitalBlack", 10,
			"WristWatch_Left_DigitalBlack", 10,
			"WristWatch_Left_DigitalDress", 6,
			"WristWatch_Left_DigitalRed", 10,
			"WristWatch_Left_DigitalRed", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DerelictHouseCrime = {
		isWorn = true,
		rolls = 1,
		items = {
			"Bag_BurglarBag", 0.01,
			"Bag_Dancer", 4,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_MoneyBag", 0.01,
			"BallPeenHammer", 0.2,
			"BaseballBat", 0.2,
			"BaseballBat_Metal", 0.1,
			"BlowTorch", 2,
			"BoltCutters", 2,
			"ClubHammer", 0.2,
			"CreditCard", 4,
			"CreditCard", 8,
			"Crowbar", 0.1,
			"CrudeKnife", 0.1,
			"DuctTape", 1,
			"Garbagebag", 10,
			"GlassShiv", 0.5,
			"Gloves_LeatherGloves", 0.1,
			"Gloves_LeatherGlovesBlack", 0.05,
			"Hammer", 0.2,
			"HandAxe", 0.05,
			"HandDrill", 0.5,
			"Handbag", 4,
			"Hat_BalaclavaFace", 0.01,
			"Hat_BalaclavaFull", 0.01,
			"Hat_HeadSack_Burlap", 0.1,
			"Hat_HeadSack_Cotton", 0.1,
			"HeavyChain", 2,
			"HuntingKnife", 0.2,
			"IcePick", 0.5,
			"IDcard", 4,
			"IDcard", 8,
			"IDcard_Blank", 0.1,
			"KnifeButterfly", 0.2,
			"KnifePocket", 0.1,
			"KnifeShiv", 0.5,
			"LargeKnife", 0.1,
			"LeadPipe", 0.1,
			"Machete", 0.001,
			"MetalBar", 0.1,
			"MoneyBundle", 10,
			"Pliers", 2,
			"Purse", 4,
			"RailroadSpikeKnife", 0.1,
			"Rope", 10,
			"RubberBand", 10,
			"RubberHose", 8,
			"Saw", 2,
			"Screwdriver", 0.5,
			"SheetMetalSnips", 1,
			"SmallKnife", 0.5,
			"SmashedBottle", 4,
			"SwitchKnife", 0.5,
			"Tarp", 2,
			"WoodenMallet", 0.2,
		},
		junk = ClutterTables.BinJunk,
	},
	
	DerelictHouseDrugs = {
		isWorn = true,
		rolls = 1,
		items = {
			"Aluminum", 4,
			"BandageDirty", 2,
			"Belt2", 10,
			"BeerBottle", 1,
			"BeerCan", 2,
			"BeerCanEmpty", 20,
			"BeerCanEmpty", 10,
			"BeerBottleEmpty", 10,
			"BlowTorch", 8,
			"Candle", 10,
			"Glue", 6,
			"LightBulb", 8,
			"LighterDisposable", 4,
			"LighterFluid", 2,
			"Matches", 8,
			"Mirror", 4,
			"Pills", 6,
			"PillsAntiDep", 4,
			"PillsBeta", 4,
			"PillsSleepingTablets", 4,
			"Plasticbag", 10,
			"RubberHose", 8,
			"Spoon", 20,
			"Spoon", 10,
			"SteelWool", 10,
			"WaterBottle", 0.1,
			"WaterBottleEmpty", 4,
			"WhiskeyEmpty", 2,
			"Whiskey", 1,
			"WineBox", 1,
		},
		junk = ClutterTables.BinJunk,
	},
	
	DerelictHouseJunk = {
		isWorn = true,
		rolls = 1,
		items = {
			"BandageDirty", 2,
			"BeerCan", 8,
			"BeerBottle", 2,
			"Brochure", 1,
			"BrokenGlass", 0.4,
			"Cockroach", 8,
			"CopperScrap", 1,
			"DeadMouse", 2,
			"DeadRat", 1,
			"Dung_Mouse", 1,
			"Dung_Rat", 1,
			"ElectronicsScrap", 2,
			"EmptyJar", 0.5,
			"Flier", 1,
			"FountainCup", 4,
			"JarLid", 0.5,
			"PaintbucketEmpty", 1,
			"PaperNapkins2", 4,
			"PlasticCup", 4,
			"Pop2", 8,
			"Pop3", 8,
			"PopBottle", 1,
			"Pop", 8,
			"Receipt", 10,
			"RippedSheetsDirty", 4,
			"ScrapMetal", 2,
			"ScratchTicket_Loser", 4,
			"SmashedBottle", 1,
			"Splinters", 4,
			"Straw2", 8,
			"TinCanEmpty", 10,
			"TinCanEmpty", 10,
			"UnusableMetal", 2,
			"UnusableWood", 2,
			"WaterBottle", 1,
			"Whiskey", 0.5,
			"Wine", 0.5,
			"Wine2", 0.5,
		},
		junk = ClutterTables.BinJunk,
	},
	
	DerelictHouseParty = {
		isWorn = true,
		rolls = 1,
		items = {
			"BeerBottle", 10,
			"BeerCan", 20,
			"BeerCan", 10,
			"BrokenGlass", 0.4,
			"Crisps", 0.1,
			"Crisps2", 0.1,
			"Crisps3", 0.1,
			"Crisps4", 0.1,
			"Flask", 0.01,
			"PlasticCup", 20,
			"PlasticCup", 10,
			"Pop", 4,
			"Pop2", 4,
			"Pop3", 4,
			"PopBottle", 1,
			"PopBottleRare", 0.1,
			"SmashedBottle", 10,
			"WaterBottle", 4,
			"Whiskey", 2,
			"Wine", 4,
			"Wine2", 4,
			"WineBox", 1,
		},
		junk = ClutterTables.BinJunk,
	},
	
	DerelictHouseSquatter = {
		isWorn = true,
		rolls = 1,
		items = {
			"Bag_TrashBag", 10,
			"BathTowel", 0.1,
			"BeefJerky", 0.1,
			"Candle", 10,
			"CannedBolognese", 0.01,
			"CannedCarrots2", 0.01,
			"CannedChili", 0.01,
			"CannedCorn", 0.01,
			"CannedCornedBeef", 0.01,
			"CannedFruitCocktail", 0.01,
			"CannedMilk", 0.01,
			"CannedMushroomSoup", 0.01,
			"CannedPeaches", 0.01,
			"CannedPeas", 0.01,
			"CannedPineapple", 0.01,
			"CannedPotato2", 0.01,
			"CannedSardines", 0.01,
			"CannedTomato2", 0.01,
			"CigarettePack", 0.01,
			"CigaretteRolled", 2,
			"CigaretteRollingPapers", 0.001,
			"CigaretteSingle", 1,
			"Cockroach", 4,
			"Crackers", 0.1,
			"Crisps", 0.1,
			"DeadMouse", 1,
			"DeadRat", 2,
			"DehydratedMeatStick", 0.1,
			"Flask", 0.01,
			"Lantern_Propane", 0.001,
			"Newspaper", 1,
			"Newspaper_Recent", 1,
			"P38", 1,
			"Plasticbag_Bags", 8,
			"PorkRinds", 0.1,
			"SleepingBag_Cheap_Blue_Packed", 0.001,
			"SleepingBag_Cheap_Green2_Packed", 0.001,
			"SleepingBag_Cheap_Green_Packed", 0.001,
			"SmallKnife", 0.1,
			"SmashedBottle", 0.5,
			"TinCanEmpty", 10,
			"TinCanEmpty", 20,
			"TinnedBeans", 0.01,
			"TinnedSoup", 0.01,
			"TinOpener", 2,
			"TinOpener_Old", 0.5,
			"TobaccoChewing", 0.001,
			"TobaccoLoose", 0.001,
			"ToiletPaper", 1,
			"TunaTin", 0.01,
			"WaterBottle", 2,
			"WaterPurificationTablets", 0.001,
			"Whiskey", 0.5,
			"Wine", 0.5,
			"Wine2", 0.5,
		},
		junk = ClutterTables.BinJunk,
	},
	
	DerelictHouseStove = {
		rolls = 1,
		ignoreZombieDensity = true,
		items = {
			"Cockroach", 8,
			"DeadMouse", 2,
			"DeadRat", 1,
			"Dung_Mouse", 1,
			"Dung_Rat", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"BakingPan", 0.1,
				"BakingTray", 0.1,
				"MuffinTray", 0.05,
				"RoastingPan", 0.1,
			}
		}
	},
	
	DeskGeneric = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- Literature
			"Book_Business", 4,
			"Magazine_Business", 10,
			"Paperback_Business", 8,
			-- Memorabilia
			"Photo", 4,
		},
		junk = ClutterTables.DeskJunk,
	},
	
	DinerBackRoomCounter = {
		rolls = 4,
		items = {
			-- Dishes
			"BakingPan", 10,
			"BakingTray", 10,
			"Bowl", 10,
			"CheeseGrater", 10,
			"DrinkingGlass", 20,
			"GlassTumbler", 10,
			"GridlePan", 10,
			"KitchenTongs", 8,
			"KnifeParing", 6,
			"MuffinTray", 10,
			"Mugl", 10,
			"Pan", 10,
			"Plate", 10,
			"Pot", 10,
			"RoastingPan", 10,
			"Saucepan", 10,
			"SaucepanCopper", 4,
			"Strainer", 10,
			-- Utensils
			"BreadKnife", 8,
			"ButterKnife", 10,
			"CarvingFork2", 8,
			"Fork", 10,
			"Ladle", 10,
			"LargeKnife", 1,
			"KitchenKnife", 6,
			"MeatCleaver", 4,
			"PizzaCutter", 8,
			"Spatula", 8,
			"Spoon", 10,
			"Whisk", 10,
			-- Misc.
			"DishCloth", 10,
			"Whetstone", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
			-- Bags/Containers
			"Bag_ShotgunSawnoffBag", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DinerKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 6,
			"Chicken", 4,
			"Frozen_ChickenNuggets", 8,
			"Frozen_FishFingers", 8,
			"Ham", 2,
			"MeatPatty", 8,
			"MincedMeat", 8,
			"PorkChop", 4,
			"Steak", 2,
			-- Vegetables
			"CornFrozen", 8,
			"MixedVegetables", 8,
			"Peas", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DinerKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 6,
			"Chicken", 4,
			"Ham", 2,
			"MincedMeat", 8,
			"MeatPatty", 8,
			"PorkChop", 4,
			"Steak", 2,
			-- Misc.
			"Butter", 8,
			"EggCarton", 4,
			"Lard", 2,
			"Margarine", 8,
			"Milk", 8,
			"Processedcheese", 8,
			-- Vegetables
			"Lettuce", 8,
			"Onion", 8,
			"Tomato", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DishCabinetGeneric = {
		rolls = 4,
		items = {
			"Brandy", 0.1,
			"ButterKnife_Gold", 0.01,
			"ButterKnife_Silver", 0.1,
			"Fork_Gold", 0.01,
			"Fork_Silver", 0.1,
			"Gin", 2,
			"Port", 0.1,
			"Rum", 2,
			"Scotch", 0.1,
			"Spoon_Gold", 0.01,
			"Spoon_Silver", 0.1,
			"Tequila", 2,
			"Vermouth", 0.1,
			"Vodka", 2,
			"Whiskey", 2,
			"Wine", 0.5,
			"Wine2", 0.5,
			"WineBox", 4,
			"WineScrewtop", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"BottleOpener", 10,
				"Corkscrew", 8,
				"GlassWine", 20,
				"GlassWine", 10,
				"IcePick", 2,
				"Plate", 20,
				"Plate", 10,
				"Teacup", 20,
				"Teacup", 10,
			}
		}
	},
	
	DishCabinetLiquor = {
		rolls = 4,
		items = {
			"Brandy", 4,
			"Champagne", 0.5,
			"Gin", 4,
			"Port", 1,
			"Rum", 4,
			"Scotch", 4,
			"Tequila", 4,
			"Vermouth", 1,
			"Vodka", 4,
			"Whiskey", 4,
			"Wine", 2,
			"Wine2", 2,
			"WineAged", 0.5,
			"WineBox", 8,
			"WineScrewtop", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"Corkscrew", 8,
				"GlassWine", 50,
				"GlassWine", 20,
				"BottleOpener", 10,
				"IcePick", 2,
			}
		}
	},
	
	DishCabinetVIPLounge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Brandy", 10,
			"Champagne", 4,
			"Port", 10,
			"Sherry", 10,
			"Vermouth", 10,
			"WineAged", 20,
			"WineAged", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Corkscrew", 8,
				"GlassWine", 50,
				"GlassWine", 20,
				"IcePick", 2,
			}
		}
	},
	
	DoctorOutfit = {
		rolls = 4,
		items = {
			"Antibiotics", 4,
			"Bag_DoctorBag", 2,
			"Bag_MedicalBag", 0.5,
			"Bag_Satchel_Medical", 0.5,
			"BookFirstAid1", 6,
			"BookFirstAid2", 4,
			"BookFirstAid3", 2,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"FirstAidKit", 2,
			"Gloves_Surgical", 10,
			"HandTorch", 4,
			"Hat_SurgicalMask", 10,
			"Hat_HeadMirrorUP", 1,
			"PenLight", 6,
			"Shirt_FormalWhite", 10,
			"Shoes_Brown", 8,
			"Stethoscope", 8,
			"Trousers_SuitTEXTURE", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DoctorTools = {
		rolls = 4,
		items = {
			"AlcoholWipes", 20,
			"Antibiotics", 4,
			"Bag_DoctorBag", 2,
			"Bag_MedicalBag", 0.5,
			"Bag_Satchel_Medical", 0.5,
			"Bandage", 20,
			"Bandage", 20,
			"Bandaid", 20,
			"Bandaid", 20,
			"BookFirstAid1", 6,
			"BookFirstAid2", 4,
			"BookFirstAid3", 2,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"Disinfectant", 20,
			"Gloves_Surgical", 10,
			"HandTorch", 4,
			"Hat_HeadMirrorUP", 1,
			"Hat_SurgicalMask", 10,
			"PenLight", 6,
			"Pills", 20,
			"Pills", 20,
			"PillsAntiDep", 20,
			"PillsBeta", 20,
			"PillsSleepingTablets", 20,
			"Scalpel", 10,
			"ScissorsBluntMedical", 10,
			"SutureNeedle", 10,
			"SutureNeedleHolder", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DogFoodFactoryBags = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"DogFoodBag", 50,
			"DogFoodBag", 20,
			"DogFoodBag", 20,
			"DogFoodBag", 10,
			"DogFoodBag", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DogFoodFactoryBones = {
		rolls = 8,
		items = {
			"AnimalBone", 20,
			"AnimalBone", 10,
			"SmallAnimalBone", 50,
			"SmallAnimalBone", 20,
			"SharpBoneFragment", 50,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DogFoodFactoryCans = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Dogfood", 50,
			"Dogfood", 20,
			"Dogfood", 20,
			"Dogfood", 10,
			"Dogfood", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DogFoodFactoryEquipment = {
		rolls = 4,
		items = {
			"Apron_White", 8,
			"Fleshing_Tool", 10,
			"Glasses_SafetyGoggles", 10,
			"Gloves_Surgical", 10,
			"Hat_DustMask", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Clipboard", 8,
				"Paperwork", 10,
				"Pen", 8,
				"RedPen", 4,
			}
		}
	},
	
	DresserGeneric = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- TODO: Sort Me!
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"BaseballBat", 0.1,
			"BaseballBat_Metal", 0.1,
			"Belt2", 4,
			"BoobTube", 0.5,
			"BoobTubeSmall", 0.5,
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Diary1", 1,
			"Diary2", 1,
			"Earbuds", 1,
			"Flask", 0.1,
			"GenericMail", 1,
			"Headphones", 1,
			"HollowBook", 0.001,
			"HoodieDOWN_WhiteTINT", 0.5,
			"JewelleryBox", 0.1,
			"Jumper_DiamondPatternTINT", 0.3,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"Kneepad_Left_Sport", 1,
			"LetterHandwritten", 1,
			"LongJohns", 1,
			"LongJohns_Bottoms", 1,
			"Photo", 4,
			"Photo_Secret", 0.1,
			"Pistol", 0.05,
			"Pistol2", 0.01,
			"Pistol3", 0.005,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"RadioBlack", 0.5,
			"RadioRed", 0.2,
			"Revolver", 0.1,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			"SewingKit", 0.5,
			"Shirt_Baseball_KY", 0.2,
			"Shirt_Baseball_Rangers", 0.2,
			"Shirt_Baseball_Z", 0.2,
			"Shirt_CropTopNoArmTINT", 0.5,
			"Shirt_CropTopTINT", 0.5,
			"Shirt_Denim", 0.5,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 1,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shirt_Lumberjack", 0.5,
			"Shirt_Lumberjack_TINT", 0.5,
			"Shorts_LongDenim", 1,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortSport", 0.5,
			"Skirt_Knees", 0.2,
			"Skirt_Long", 0.2,
			"Skirt_Normal", 0.2,
			"Skirt_Short", 0.2,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Long_Black", 2,
			"Socks_Long_White", 2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"Tissue", 10,
			"TissueBox", 1,
			"Trousers", 2,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_HUE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Sport", 0.2,
			"Trousers_Suit", 0.3,
			"Trousers_SuitTEXTURE", 0.3,
			"Trousers_WhiteTINT", 2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.01,
			"Tshirt_LongSleeve_SuperColor", 0.2,
			"Tshirt_PoloStripedTINT", 0.7,
			"Tshirt_PoloTINT", 0.7,
			"Tshirt_Sport", 0.2,
			"Tshirt_SportDECAL", 0.2,
			"Tshirt_SuperColor", 0.2,
			"Tshirt_TieDye", 0.2,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Vest_DefaultTEXTURE_TINT", 1,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},
	
	DryerEmpty = {
		rolls = 1,
		items = {
			"Socks_Ankle", 4,
			"Socks_Ankle_Black", 4,
			"Socks_Ankle_White", 4,
			"Socks_Heavy", 1,
			"Socks_Long", 4,
			"Socks_Long_Black", 4,
			"Socks_Long_White", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"DryerLint", 50,
				"DryerLint", 20,
				"DryerLint", 10,
				"Money", 10,
			}
		}
	},
	
	DrugLabGuns = {
		rolls = 2,
		items = {
			-- Guns
			"AssaultRifle", 2,
			"AssaultRifle2", 0.1,
			"DoubleBarrelShotgun", 8,
			"DoubleBarrelShotgunSawnoff", 8,
			"HuntingRifle", 6,
			"Pistol", 8,
			"Pistol2", 6,
			"Pistol3", 4,
			"Revolver", 6,
			"Revolver_Long", 4,
			"Revolver_Short", 8,
			"Shotgun", 8,
			"ShotgunSawnoff", 8,
			-- Ammo
			"308Box", 10,
			"556Box", 10,
			"Bullets44Box", 10,
			"Bullets45Box", 10,
			"Bullets9mmBox", 10,
			"ShotgunShellsBox", 10,
			-- Clips/Magazines
			"44Clip", 8,
			"45Clip", 8,
			"556Clip", 8,
			"9mmClip", 8,
			"M14Clip", 10,
			-- Knives/Blades
			"HuntingKnife", 8,
			"KnifeButterfly", 4,
			"LargeKnife", 1,
			"Machete", 0.1,
			"SwitchKnife", 4,
			-- Accessories
			"HolsterDouble", 4,
			"HolsterShoulder", 2,
			"HolsterSimple_Brown", 8,
			"Vest_BulletCivilian", 2,
			-- Literature
			"ArmorMag3", 1,
			"ArmorMag7", 1,
			"EngineerMagazine2", 1,
			"ExplosiveSchematic", 2,
			"HempMag1", 4,
			"KeyMag1", 2,
			"TrickMag1", 2,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			-- Misc.
			"CigaretteCarton", 0.1,
			"CigarettePack", 8,
			"CordlessPhone", 1,
			"CreditCard", 8,
			"MoneyBundle", 50,
			"MoneyBundle", 20,
			"Pager", 4,
			"WalkieTalkie4", 10,
			-- Bags/Containers
			"Bag_AmmoBox_Mixed", 1,
			"Bag_BurglarBag", 1,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_MoneyBag", 1,
			"Bag_ProtectiveCaseSmall_Armorer", 1,
			"Bag_WeaponBag", 1,
			"Briefcase_Money", 1,
			-- Special
			"GemBag", 0.1,
			"HollowBook_Handgun", 0.001,
			"SuspiciousPackage", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DrugLabMoney = {
		rolls = 4,
		items = {
			-- Money
			"MoneyBundle", 100,
			"MoneyBundle", 50,
			-- Guns
			"DoubleBarrelShotgunSawnoff", 8,
			"Pistol", 8,
			"Pistol2", 6,
			"Pistol3", 4,
			"Revolver", 6,
			"Revolver_Long", 4,
			"Revolver_Short", 8,
			"ShotgunSawnoff", 8,
			-- Knives/Blades
			"KnifeButterfly", 4,
			"LargeKnife", 1,
			"Machete", 0.1,
			"SwitchKnife", 4,
			-- Literature
			"ArmorMag3", 1,
			"ArmorMag7", 1,
			"EngineerMagazine2", 1,
			"ExplosiveSchematic", 2,
			"HempMag1", 4,
			"KeyMag1", 2,
			"Magazine_Business", 10,
			"TrickMag1", 2,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			-- Misc.
			"CameraDisposable", 10,
			"CameraFilm", 10,
			"Catalog", 1,
			"CordlessPhone", 2,
			"CordlessPhone", 1,
			"CreditCard", 20,
			"CreditCard", 10,
			"CigaretteCarton", 0.1,
			"CigarettePack", 8,
			"Pager", 4,
			"Glasses_Aviators", 0.5,
			"Glasses_Sun", 1,
			"PokerChips", 10,
			"RubberBand", 20,
			"RubberBand", 10,
			"WalkieTalkie4", 10,
			-- Bags/Containers
			"Bag_DuffelBagTINT", 0.5,
			"Bag_MoneyBag", 20,
			"Briefcase_Money", 10,
			-- Special
			"GemBag", 1,
			"HollowBook_Valuables", 0.001,
			"IDcard_Blank", 20,
			"IDcard_Blank", 10,
			"SuspiciousPackage", 1,
			"WristWatch_Left_Expensive", 1,
		},
		junk = {
			rolls = 1,
			items = {
				-- Stationery/Office
				"Calculator", 20,
				"Notebook", 10,
				"Notepad", 20,
				"Pen", 8,
				"Pencil", 8,
				"Phonebook", 50,
				"Phonebook", 20,
			}
		}
	},
	
	DrugLabOutfit = {
		rolls = 4,
		items = {
			-- Accessories
			"Boilersuit", 20,
			"Boilersuit", 10,
			"Glasses_SafetyGoggles", 20,
			"Glasses_SafetyGoggles", 10,
			"Gloves_Dish", 20,
			"Gloves_Surgical", 10,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 20,
			"Hat_DustMask", 10,
			"HazmatSuit", 1,
			"RespiratorFilters", 2,
			"SCBA", 1,
			-- Knives/Blades
			"KnifeButterfly", 4,
			"LargeKnife", 1,
			"Machete", 0.1,
			"SwitchKnife", 4,
			-- Literature
			"ArmorMag3", 1,
			"ArmorMag7", 1,
			"EngineerMagazine2", 1,
			"ExplosiveSchematic", 2,
			"HempMag1", 4,
			"KeyMag1", 2,
			"Magazine_Business", 10,
			"TrickMag1", 2,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			-- Misc.
			"CigaretteCarton", 0.01,
			"CigarettePack", 8,
			"MoneyBundle", 20,
			-- Bags/Containers
			"Bag_DuffelBagTINT", 0.5,
			"Bag_MoneyBag", 8,
			"Briefcase_Money", 8,
			-- Special
			"GemBag", 1,
			"HollowBook_Valuables", 0.001,
			"SuspiciousPackage", 1,
			"WristWatch_Left_Expensive", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	DrugLabSupplies = {
		rolls = 4,
		items = {
			-- Tools
			"BakingTray", 10,
			"Bowl", 10,
			"BlowTorch", 10,
			"Funnel", 10,
			"IcePick", 10,
			"Plate", 10,
			"Pot", 20,
			"Pot", 10,
			-- Pills
			"Pills", 20,
			"Pills", 10,
			"PillsVitamins", 20,
			"PillsVitamins", 10,
			-- Materials
			"Aluminum", 8,
			"BakingSoda", 10,
			"Bleach", 8,
			"CleaningLiquid2", 10,
			"Disinfectant", 8,
			"DuctTape", 4,
			"Garbagebag", 10,
			"Matchbox", 10,
			"Oxygen_Tank", 10,
			"PetrolCan", 2,
			"PetrolCanEmpty", 4,
			"Pipe", 10,
			"Propane_Refill", 10,
			"RubberHose", 10,
			"Scotchtape", 8,
			"SteelWool", 10,
			-- Literature
			"ArmorMag3", 1,
			"ArmorMag7", 1,
			"EngineerMagazine2", 1,
			"ExplosiveSchematic", 2,
			"HempMag1", 4,
			"KeyMag1", 2,
			"Magazine_Business", 10,
			"TrickMag1", 2,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			-- Misc.
			"Base.HempBagSeed", 4,
			"CreditCard", 8,
			"HempMag1", 8,
			"Mirror", 8,
			"Plasticbag", 8,
			"Spoon", 10,
			-- Bags/Containers
			"Bag_DuffelBagTINT", 0.5,
			"Bag_MoneyBag", 8,
			-- Special
			"GemBag", 1,
			"HollowBook_Valuables", 0.001,
			"SuspiciousPackage", 1,
			"WristWatch_Left_Expensive", 1,
		},
		junk = {
			rolls = 1,
			items = {
				-- Stationery/Office
				"Calculator", 20,
				"Clipboard", 10,
				"GraphPaper", 10,
				"Journal", 4,
				"MarkerBlack", 8,
				"Note", 10,
				"Notebook", 10,
				"Notepad", 20,
				"Pen", 8,
				"Pencil", 8,
				"SheetPaper2", 10,
			}
		}
	},
	
	DrugShackDrugs = {
		isWorn = true,
		rolls = 4,
		items = {
			-- Pills
			"Pills", 20,
			"Pills", 10,
			"PillsAntiDep", 10,
			"PillsBeta", 10,
			"PillsSleepingTablets", 10,
			"PillsVitamins", 20,
			"PillsVitamins", 10,
			-- Drinks
			"BeerBottle", 10,
			"BeerCan", 10,
			"Brandy", 1,
			"Gin", 4,
			"Rum", 4,
			"Scotch", 1,
			"Tequila", 4,
			"Vodka", 4,
			"Whiskey", 8,
			"WineScrewtop", 8,
			-- Tobacco/Smoking
			"CigaretteCarton",  0.01,
			"CigarettePack", 4,
			"CigaretteRolled", 6,
			"CigaretteRollingPapers", 6,
			"CigaretteSingle", 6,
			"Cigarillo", 6,
			"TobaccoChewing", 1,
			"TobaccoLoose", 1,
			-- Tools
			"BlowTorch", 8,
			"Spoon", 20,
			"Spoon", 10,
			-- Materials
			"Aluminum", 8,
			"Glue", 10,
			"LightBulb", 8,
			"Matches", 8,
			"Plasticbag", 10,
			"RubberHose", 8,
			"SteelWool", 10,
			-- Misc.
			"Belt2", 10,
			"Candle", 10,
			"HempBagSeed", 2,
			"Mirror", 4,
			"SmokingPipe", 4,
			-- Literature
			"ArmorMag3", 1,
			"ArmorMag7", 1,
			"EngineerMagazine2", 1,
			"ExplosiveSchematic", 2,
			"HempMag1", 4,
			"KeyMag1", 2,
			"Magazine_Business", 10,
			"TrickMag1", 2,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			-- Trash
			"BeerBottleEmpty", 20,
			"BeerCanEmpty", 20,
			"WhiskeyEmpty", 20,
			-- Special
			"HollowBook_Whiskey", 0.01,
			"SuspiciousPackage", 1,
		},
		junk = ClutterTables.BinJunk,
	},
	
	DrugShackMisc = {
		isWorn = true,
		rolls = 4,
		items = {
			-- Knives
			"KnifePocket", 0.1,
			"SmallKnife", 1,
			"SwitchKnife", 1,
			-- Tobacco/Smoking
			"CigaretteCarton",  0.01,
			"CigarettePack", 4,
			"CigaretteRolled", 6,
			"CigaretteRollingPapers", 6,
			"CigaretteSingle", 6,
			"Cigarillo", 6,
			"TobaccoChewing", 1,
			"TobaccoLoose", 1,
			-- Literature
			"ArmorMag3", 1,
			"ArmorMag7", 1,
			"EngineerMagazine2", 1,
			"ExplosiveSchematic", 2,
			"HempMag1", 4,
			"KeyMag1", 2,
			"Magazine", 10,
			"Magazine_Business", 10,
			"Magazine_Crime", 4,
			"Newspaper", 10,
			"TrickMag1", 2,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			-- Materials
			"Garbagebag", 10,
			"HeavyChain", 2,
			"RubberBand", 10,
			-- Misc.
			"CreditCard", 4,
			"CreditCard", 8,
			"HempBagSeed", 2,
			"LighterDisposable", 4,
			"SmokingPipe", 4,
			-- Bags/Containers
			"Bag_Dancer", 4,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_MoneyBag", 0.01,
			"Bag_TrashBag", 10,
			"Handbag", 4,
			"Plasticbag_Bags", 8,
			"Purse", 4,
			"Tote_Bags", 4,
			-- Special
			"HollowBook", 0.001,
			"IDcard", 4,
			"IDcard", 8,
			"IDcard_Blank", 0.1,
		},
		junk = ClutterTables.BinJunk,
	},
	
	DrugShackTools = {
		isWorn = true,
		rolls = 4,
		items = {
			-- Tools
			"BallPeenHammer", 6,
			"BlowTorch", 8,
			"BoltCutters", 8,
			"CarpentryChisel", 4,
			"ClubHammer", 4,
			"Crowbar", 4,
			"Hammer", 8,
			"HandAxe", 4,
			"HandDrill", 4,
			"PipeWrench", 6,
			"Ratchet", 6,
			"Saw", 8,
			"Screwdriver", 10,
			"SheetMetalSnips", 1,
			"Shovel", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"TireIron", 4,
			"Wrench", 8,
			-- Knives
			"LargeKnife", 1,
			"RailroadSpikeKnife", 1,
			"SmallKnife", 4,
			-- Accessories
			"Hat_HeadSack_Burlap", 1,
			"Hat_HeadSack_Cotton", 1,
			-- Materials
			"CircularSawblade", 4,
			"CopperScrap", 4,
			"DuctTape", 4,
			"ElectricWire", 10,
			"ElectronicsScrap", 10,
			"HeavyChain", 4,
			"Rope", 10,
			"ScrapMetal", 10,
			"Tarp", 10,
			"UnusableMetal", 10,
			-- Literature
			"ArmorMag3", 1,
			"ArmorMag7", 1,
			"EngineerMagazine2", 1,
			"ExplosiveSchematic", 2,
			"HempMag1", 4,
			"KeyMag1", 2,
			"Magazine", 10,
			"Magazine_Business", 10,
			"Magazine_Crime", 4,
			"Newspaper", 10,
			"TrickMag1", 2,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			-- Bags/Containers
			"Bag_ToolBag", 0.1,
		},
		junk = ClutterTables.BinJunk,
	},
	
	DrugShackWeapons = {
		isWorn = true,
		rolls = 4,
		items = {
			-- Guns
			"DoubleBarrelShotgun", 4,
			"DoubleBarrelShotgunSawnoff", 8,
			"Pistol", 8,
			"Revolver", 6,
			"Revolver_Short", 8,
			"Shotgun", 4,
			"ShotgunSawnoff", 8,
			"VarmintRifle", 2,
			-- Melee Weapons
			"BaseballBat", 8,
			"BaseballBat_Metal", 4,
			-- Knives/Blades
			"Axe", 0.05,
			"CrudeKnife", 4,
			"HandAxe", 8,
			"HuntingKnife", 4,
			"IcePick", 4,
			"KnifeButterfly", 4,
			"LargeKnife", 1,
			"Machete", 1,
			"SmallKnife", 4,
			"SwitchKnife", 4,
			-- Improvised Weapons
			"GlassShiv", 4,
			"KnifeShiv", 8,
			"LeadPipe", 8,
			"MetalBar", 8,
			"SmashedBottle", 8,
			-- Literature
			"ArmorMag3", 1,
			"ArmorMag7", 1,
			"EngineerMagazine2", 1,
			"ExplosiveSchematic", 2,
			"HempMag1", 4,
			"KeyMag1", 2,
			"Magazine", 10,
			"Magazine_Business", 10,
			"Magazine_Crime", 4,
			"Newspaper", 10,
			"TrickMag1", 2,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			-- Bags/Containers
			"Bag_BurglarBag", 0.1,
			"Bag_MoneyBag", 0.01,
			-- Special
			"HollowBook_Handgun", 0.001,
		},
		junk = ClutterTables.BinJunk,
	},
	
	ElectronicStoreAppliances = {
		isShop = true,
		rolls = 1,
		items = {
			"HairDryer", 50,
			"HairDryer", 20,
			"HairIron", 50,
			"HairIron", 20,
			"Mov_Microwave2", 20,
			"Mov_Microwave2", 10,
			"Mov_Microwave", 20,
			"Mov_Microwave", 10,
			"Mov_Toaster", 20,
			"Mov_Toaster", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_Microwave2", 50,
				"Mov_Microwave", 50,
				"Mov_Toaster", 50,
			}
		}
	},
	
	ElectronicStoreCases = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_ProtectiveCase", 20,
			"Bag_ProtectiveCase", 10,
			"Bag_ProtectiveCaseBulky", 10,
			"Bag_ProtectiveCaseSmall", 50,
			"Bag_ProtectiveCaseSmall", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ElectronicStoreComputers = {
		isShop = true,
		rolls = 1,
		items = {
			"Mov_DesktopComputer", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_DesktopComputer", 100,
			}
		}
	},
	
	ElectronicStoreHAMRadio = {
		isShop = true,
		rolls = 1,
		items = {
			"HamRadio1", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"HamRadio1", 100,
			}
		}
	},
	
	ElectronicStoreLights = {
		isShop = true,
		rolls = 4,
		items = {
			"LightBulbBox", 20,
			"LightBulbBox", 10,
			"LightBulbRed", 8,
			"LightBulbGreen", 8,
			"LightBulbBlue", 8,
			"LightBulbYellow", 8,
			"LightBulbCyan", 8,
			"LightBulbMagenta", 8,
			"LightBulbOrange", 8,
			"LightBulbPurple", 8,
			"LightBulbPink", 8,
			"Mov_Lamp1", 4,
			"Mov_Lamp2", 4,
			"Mov_Lamp3", 4,
			"Mov_Lamp4", 4,
			"Mov_Lamp5", 4,
			"Mov_Lamp6", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_Lamp1", 8,
				"Mov_Lamp2", 8,
				"Mov_Lamp3", 8,
				"Mov_Lamp4", 8,
				"Mov_Lamp5", 8,
				"Mov_Lamp6", 8,
			}
		}
	},
	
	ElectronicStoreMagazines = {
		isShop = true,
		rolls = 4,
		items = {
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"ElectronicsMag1", 8,
			"ElectronicsMag2", 8,
			"ElectronicsMag3", 8,
			"ElectronicsMag4", 8,
			"ElectronicsMag5", 8,
			"EngineerMagazine1", 8,
			"EngineerMagazine2", 8,
			"Magazine_Tech_New", 20,
			"Magazine_Tech_New", 10,
			"RadioMag1", 8,
			"RadioMag2", 8,
			"RadioMag3", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ElectronicStoreMisc = {
		isShop = true,
		rolls = 4,
		items = {
			"BatteryBox", 20,
			"BatteryBox", 20,
			"BatteryBox", 10,
			"BatteryBox", 10,
			"BlowerFan", 1,
			"Bullhorn", 8,
			"HomeAlarm", 10,
			"PowerBar", 10,
			"RadioBlack", 4,
			"RadioRed", 2,
			"Remote", 20,
			"Remote", 10,
			"WalkieTalkie2", 8,
			"WalkieTalkie3", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ElectronicStoreMusic = {
		isShop = true,
		rolls = 4,
		items = {
			"Magazine_Music_New", 10,
			"Disc_Retail", 50,
			"Disc_Retail", 20,
			"Mov_BlackSpeakerCabinet", 4,
			"Mov_GuitarAmplifier", 20,
			"Mov_WoodSpeakerCabinet", 4,
			"Headphones", 20,
			"Headphones", 10,
			"Microphone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ElectronicStorePhones = {
		isShop = true,
		rolls = 4,
		items = {
			"CordlessPhone", 50,
			"CordlessPhone", 20,
			"CordlessPhone", 20,
			"CordlessPhone", 10,
			"Mov_BlackModernPhone", 50,
			"Mov_BlackModernPhone", 20,
			"Mov_WhiteModernPhone", 50,
			"Mov_WhiteModernPhone", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	Empty = {
		rolls = 1,
		items = {
			
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	EngineerTools = {
		rolls = 4,
		items = {
			"Aluminum", 8,
			"Amplifier", 8,
			"Battery", 10,
			"BatteryBox", 1,
			"Book_Science", 4,
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"CopperScrap", 10,
			"DuctTape", 4,
			"ElectricWire", 10,
			"ElectronicsMag1", 2,
			"ElectronicsMag2", 2,
			"ElectronicsMag3", 2,
			"ElectronicsMag4", 2,
			"ElectronicsMag5", 2,
			"ElectronicsScrap", 20,
			"ElectronicsScrap", 10,
			"EngineerMagazine1", 2,
			"EngineerMagazine2", 2,
			"Epoxy", 2,
			"FlashLight_AngleHead", 1,
			"GraphPaper", 10,
			"Hairspray2", 8,
			"LightBulbGreen", 10,
			"LightBulbRed", 10,
			"Magazine_Tech", 10,
			"MetalPipe", 10,
			"Microphone", 4,
			"MotionSensor", 8,
			"NutsBolts", 8,
			"Paperback_Science", 8,
			"RadioMag1", 2,
			"RadioMag2", 2,
			"RadioMag3", 1,
			"RadioReceiver", 8,
			"RadioTransmitter", 8,
			"RemoteCraftedV1", 8,
			"RemoteCraftedV2", 6,
			"RemoteCraftedV3", 4,
			"ScannerModule", 8,
			"Screwdriver", 10,
			"Sparklers", 8,
			"SteelWool", 10,
			"TimerCrafted", 8,
			"Toolbox", 2,
			"TriggerCrafted", 8,
			"Tsquare", 10,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ElectricianOutfit = {
		rolls = 3,
		items = {
			"BookElectrician1", 6,
			"BookElectrician2", 4,
			"BookElectrician3", 2,
			"BookElectrician4", 1,
			"BookElectrician5", 0.5,
			"DuctTape", 4,
			"ElbowPad_Left_Workman", 1,
			"ElectronicsMag1", 2,
			"ElectronicsMag2", 2,
			"ElectronicsMag3", 2,
			"ElectronicsMag4", 2,
			"ElectronicsMag5", 2,
			"EngineerMagazine1", 2,
			"EngineerMagazine2", 2,
			"Glasses_SafetyGoggles", 8,
			"Gloves_LeatherGloves", 1,
			"Handiknife", 1,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_DustMask", 8,
			"Hat_EarMuff_Protectors", 8,
			"Hat_HardHat", 4,
			"Kneepad_Left_Workman", 4,
			"KnifePocket", 1,
			"MarkerBlack", 4,
			"Multitool", 0.1,
			"Notepad", 10,
			"Pencil", 10,
			"RadioMag1", 2,
			"RadioMag2", 2,
			"RadioMag3", 2,
			"RippedSheets", 10,
			"Shirt_Lumberjack", 8,
			"Shirt_Lumberjack_TINT", 8,
			"Shoes_WorkBoots", 8,
			"Toolbox", 2,
			"Trousers_Denim", 10,
			"Tshirt_DefaultTEXTURE_TINT", 6,
			"Vest_DefaultTEXTURE_TINT", 6,
			"Vest_HighViz", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ElectricianTools = {
		rolls = 3,
		items = {
			"Aluminum", 8,
			"Amplifier", 8,
			"BoltCutters", 4,
			"BookElectrician1", 6,
			"BookElectrician2", 4,
			"BookElectrician3", 2,
			"BookElectrician4", 1,
			"BookElectrician5", 0.5,
			"CopperScrap", 8,
			"DuctTape", 4,
			"ElectricWire", 10,
			"ElectronicsMag1", 2,
			"ElectronicsMag2", 2,
			"ElectronicsMag3", 2,
			"ElectronicsMag4", 2,
			"ElectronicsMag5", 2,
			"ElectronicsScrap", 20,
			"EngineerMagazine1", 2,
			"EngineerMagazine2", 2,
			"Epoxy", 2,
			"FirstAidKit", 2,
			"FlashLight_AngleHead", 1,
			"Handiknife", 1,
			"KnifePocket", 1,
			"MeasuringTape", 10,
			"MarkerBlack", 4,
			"MetalPipe", 6,
			"MotionSensor", 8,
			"Multitool", 0.1,
			"Notepad", 10,
			"Pencil", 10,
			"PowerBar", 10,
			"RadioMag1", 3,
			"RadioMag2", 2,
			"RadioMag3", 1,
			"RemoteCraftedV1", 8,
			"RemoteCraftedV2", 4,
			"RemoteCraftedV3", 2,
			"RippedSheets", 10,
			"ScrapMetal", 4,
			"Screwdriver", 10,
			"Sparklers", 10,
			"TimerCrafted", 8,
			"Toolbox", 2,
			"TriggerCrafted", 8,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FactoryLockers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"Bag_WorkerBag", 0.5,
			"Belt2", 4,
			"Boilersuit", 20,
			"Boilersuit", 10,
			"Briefcase", 0.2,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"ElbowPad_Left_Workman", 1,
			"Flask", 1,
			"Gum", 10,
			"Glasses_Aviators", 1,
			"Glasses_SafetyGoggles", 8,
			"Glasses_Sun", 2,
			"Handbag", 0.5,
			"Hat_DustMask", 8,
			"Hat_EarMuff_Protectors", 8,
			"Hat_HardHat", 4,
			"Headphones", 1,
			"KnifePocket", 0.1,
			"Kneepad_Left_Workman", 4,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"Money", 4,
			"Paperback_Poor", 8,
			"Purse", 0.5,
			"Shirt_Denim", 8,
			"Shirt_Lumberjack", 4,
			"Shirt_Lumberjack_TINT", 4,
			"Shirt_Workman", 20,
			"Shirt_Workman", 10,
			"Shoes_WorkBoots", 8,
			"Shoes_TrainerTINT", 8,
			"Sportsbottle", 1,
			"Suitcase", 0.2,
			"Toolbox", 2,
			"Trousers_Denim", 8,
			"Trousers_JeanBaggy", 8,
			"Tshirt_WhiteTINT", 10,
			"Vest_Foreman", 1,
			"Vest_HighViz", 4,
			"TobaccoChewing", 1,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	FarmerOutfit = {
		rolls = 3,
		items = {
			"BookButchering1", 6,
			"BookButchering2", 4,
			"BookButchering3", 2,
			"BookButchering4", 1,
			"BookButchering5", 0.5,
			"BookFarming1", 6,
			"BookFarming2", 4,
			"BookFarming3", 2,
			"BookFarming4", 1,
			"BookFarming5", 0.5,
			"BookHusbandry1", 6,
			"BookHusbandry2", 4,
			"BookHusbandry3", 2,
			"BookHusbandry4", 1,
			"BookHusbandry5", 0.5,
			"Dungarees", 10,
			"ElbowPad_Left_Workman", 1,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"GardeningSprayEmpty", 6,
			"Gloves_LeatherGloves", 1,
			"HandShovel", 10,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_BuildersRespirator", 2,
			"Hat_StrawHat", 8,
			"Hat_SummerHat", 2,
			"HerbalistMag", 2,
			"Kneepad_Left_Workman", 4,
			"KnifePocket", 1,
			"MarkerBlack", 4,
			"RippedSheets", 10,
			"SeedBag", 20,
			"Shoes_WorkBoots", 8,
			"SlugRepellent", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"SeedBag", 10,
			}
		}
	},

	FarmerTools = {
		rolls = 3,
		items = {
			"Bag_GardenBasket", 10,
			"BookButchering1", 6,
			"BookButchering2", 4,
			"BookButchering3", 2,
			"BookButchering4", 1,
			"BookButchering5", 0.5,
			"BookFarming1", 6,
			"BookFarming2", 4,
			"BookFarming3", 2,
			"BookFarming4", 1,
			"BookFarming5", 0.5,
			"BookHusbandry1", 6,
			"BookHusbandry2", 4,
			"BookHusbandry3", 2,
			"BookHusbandry4", 1,
			"BookHusbandry5", 0.5,
			"BoxOfJars", 1,
			"Bucket", 4,
			"BurlapPiece", 4,
			"CarpentryChisel", 4,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"GardenFork", 2,
			"GardenHoe", 4,
			"GardeningSprayEmpty", 6,
			"GardenSaw", 10,
			"HandAxe", 4,
			"HandFork", 4,
			"HandScythe", 4,
			"HandShovel", 10,
			"HerbalistMag", 2,
			"KnapsackSprayer", 1,
			"LeafRake", 10,
			"Machete", 0.5,
			"Padlock", 4,
			"PickAxe", 1,
			"Rake", 10,
			"RakeHead", 4,
			"RespiratorFilters", 2,
			"RippedSheets", 10,
			"Scythe", 4,
			"SeedBag", 20,
			"SlugRepellent", 10,
			"Stake", 10,
			"Toolbox_Gardening", 10,
			"TrapMouse", 8,
			"Twine", 10,
			"WateredCan", 6,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"SeedBag", 10,
			}
		}
	},

	FilingCabinetGeneric = {
		rolls = 4,
		items = {
			"BusinessCard", 0.1,
			"LetterHandwritten", 20,
			"LetterHandwritten", 10,
			"IndexCard", 20,
			"IndexCard", 10,
			"MoneyBundle", 0.01,
			"Notebook", 10,
			"Paperwork", 50,
			"Paperwork", 50,
			"Paperwork", 20,
			"Paperwork", 20,
			"Paperwork", 10,
			"Paperwork", 10,
			"SheetPaper2", 50,
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"SheetPaper2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FirearmWeapons = {
		rolls = 2,
		items = {
			-- Guns
			"DoubleBarrelShotgun", 4,
			"Pistol", 8,
			"Pistol2", 6,
			"Revolver", 6,
			"Revolver_Short", 10,
			"Shotgun", 8,
			"VarmintRifle", 10,
			-- Ammo
			"223Box", 20,
			"Bullets38Box", 20,
			"Bullets45Box", 4,
			"Bullets9mmBox", 10,
			"ShotgunShellsBox", 10,
			-- Clips/Magazines
			"45Clip", 6,
			"9mmClip", 10,
			-- Gun Accessories
			"ChokeTubeFull", 4,
			"ChokeTubeImproved", 2,
			"HolsterSimple_Brown", 8,
			"RecoilPad", 4,
			"x2Scope", 4,
			"x4Scope", 2,
			-- Skill Books
			"BookAiming1", 1,
			"BookAiming2", 1,
			"BookAiming3", 1,
			"BookAiming4", 1,
			"BookAiming5", 0.5,
			"BookReloading1", 1,
			"BookReloading2", 1,
			"BookReloading3", 1,
			"BookReloading4", 1,
			"BookReloading5", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FirearmWeapons_Mid = {
		rolls = 3,
		items = {
			-- Guns
			"AssaultRifle2", 4,
			"DoubleBarrelShotgun", 2,
			"DoubleBarrelShotgunSawnoff", 2,
			"HuntingRifle", 6,
			"Pistol", 8,
			"Pistol2", 6,
			"Revolver", 6,
			"Revolver_Long", 4,
			"Revolver_Short", 10,
			"Shotgun", 4,
			"ShotgunSawnoff", 4,
			"VarmintRifle", 10,
			"Bag_RifleCaseCloth", 1,
			"Bag_RifleCaseCloth2", 1,
			"Bag_ShotgunCaseCloth", 1,
			"Bag_ShotgunCaseCloth2", 1,
			"RifleCase1", 1,
			"RifleCase2", 1,
			"ShotgunCase1", 1,
			"ShotgunCase2", 1,
			-- Ammo
			"223Box", 20,
			"223Carton", 4,
			"308Box", 10,
			"Bullets38Box", 20,
			"Bullets38Carton", 5,
			"Bullets44Box", 6,
			"Bullets45Box", 4,
			"Bullets9mmBox", 10,
			"Bullets9mmCarton", 2,
			"ShotgunShellsBox", 10,
			"ShotgunShellsCarton", 2,
			"Bag_AmmoBox_Mixed", 1,
			-- Clips/Magazines
			"45Clip", 6,
			"9mmClip", 10,
			"M14Clip", 6,
			-- Gun Accessories
			"ChokeTubeFull", 4,
			"ChokeTubeImproved", 2,
			"GunLight", 1,
			"Holster_DuctTape", 8,
			"HolsterShoulder", 1,
			"HolsterSimple", 4,
			"RecoilPad", 4,
			"RedDot", 1,
			"x2Scope", 4,
			"x4Scope", 2,
			"x8Scope", 1,
			-- Bags/Containers
			"AmmoStrap_Bullets", 8,
			"AmmoStrap_Shells", 4,
			-- Skill Books
			"BookAiming1", 1,
			"BookAiming2", 1,
			"BookAiming3", 1,
			"BookAiming4", 1,
			"BookAiming5", 0.5,
			"BookReloading1", 1,
			"BookReloading2", 1,
			"BookReloading3", 1,
			"BookReloading4", 1,
			"BookReloading5", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FirearmWeapons_Late = {
		rolls = 4,
		items = {
			-- Guns
			"AssaultRifle", 1,
			"AssaultRifle2", 4,
			"DoubleBarrelShotgun", 4,
			"DoubleBarrelShotgunSawnoff", 4,
			"HuntingRifle", 6,
			"Pistol", 8,
			"Pistol2", 6,
			"Pistol3", 4,
			"Revolver", 6,
			"Revolver_Long", 4,
			"Revolver_Short", 10,
			"Shotgun", 8,
			"ShotgunSawnoff", 8,
			"Bag_RifleCaseCloth2", 1,
			"Bag_ShotgunCaseCloth", 1,
			"Bag_ShotgunCaseCloth2", 1,
			"Bag_RifleCaseClothCamo", 1,
			"Bag_RifleCaseGreen", 1,
			"Bag_ShotgunCaseGreen", 1,
			"RifleCase2", 1,
			"RifleCase3", 1,
			"ShotgunCase1", 1,
			"ShotgunCase2", 1,
 			-- Ammo
			"308Box", 10,
			"308Carton", 2,
			"556Box", 6,
			"556Carton", 1,
			"Bullets38Box", 20,
			"Bullets38Carton", 5,
			"Bullets44Box", 6,
			"Bullets44Carton", 1,
			"Bullets45Box", 4,
			"Bullets45Carton", 1,
			"Bullets9mmBox", 10,
			"Bullets9mmCarton", 2,
			"ShotgunShellsBox", 10,
			"ShotgunShellsCarton", 2,
			"Bag_AmmoBox", 1,
			"Bag_AmmoBox_Mixed", 1,
			"Bag_AmmoBox_ShotgunShells", 1,
			"Bag_ProtectiveCaseBulkyAmmo", 1,
			-- Clips/Magazines
			"44Clip", 8,
			"45Clip", 6,
			"556Clip", 4,
			"9mmClip", 10,
			"M14Clip", 6,
			-- Gun Accessories
			"ChokeTubeFull", 4,
			"ChokeTubeImproved", 2,
			"GunLight", 1,
			"Holster_DuctTape", 8,
			"HolsterAnkle", 0.5,
			"HolsterDouble", 1,
			"HolsterShoulder", 0.5,
			"HolsterSimple", 4,
			"RecoilPad", 4,
			"RedDot", 1,
			"x2Scope", 4,
			"x4Scope", 2,
			"x8Scope", 1,
			"Bag_ProtectiveCaseSmall_Armorer", 1,
			-- Bags/Containers
			"AmmoStrap_Bullets", 8,
			"AmmoStrap_Shells", 4,
			"Bag_ALICE_BeltSus", 2,
			"Bag_ChestRig", 1,
			"Bag_WeaponBag", 1,
			-- Skill Books
			"BookAiming1", 1,
			"BookAiming2", 1,
			"BookAiming3", 1,
			"BookAiming4", 1,
			"BookAiming5", 0.5,
			"BookReloading1", 1,
			"BookReloading2", 1,
			"BookReloading3", 1,
			"BookReloading4", 1,
			"BookReloading5", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FireDeptLockers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_MedicalBag", 0.1,
			"Bag_Satchel_Medical", 0.1,
			"Belt2", 4,
			"Briefcase", 0.2,
			"Bullhorn", 1,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"FirstAidKit", 5,
			"FirstAidKit_NewPro", 5,
			"Flask", 0.5,
			"Glasses_Aviators", 1,
			"Glasses_Sun", 2,
			"Gum", 10,
			"Hat_Fireman", 2,
			"Headphones", 1,
			"Jacket_Fireman", 4,
			"Handbag", 0.5,
			"Lunchbag", 1,
			"Lunchbox", 1,
			"Lunchbox2", 0.001,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"Money", 4,
			"Oxygen_Tank", 2,
			"Paperback_Poor", 8,
			"Purse", 0.5,
			"SCBA", 2,
			"Shirt_Denim", 8,
			"Shirt_Lumberjack", 8,
			"Shirt_Lumberjack_TINT", 8,
			"Shoes_WorkBoots", 8,
			"Socks_Heavy", 8,
			"Sportsbottle", 1,
			"Suitcase", 0.2,
			"TobaccoChewing", 1,
			"Trousers_Fireman", 8,
			"Tshirt_Profession_FiremanBlue", 10,
			"Tshirt_Profession_FiremanRed", 10,
			"Tshirt_Profession_FiremanRed02", 10,
			"Tshirt_Profession_FiremanWhite", 10,
			"WalkieTalkie4", 1,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},
	
	FiremanOutfit = {
		rolls = 3,
		items = {
			"FirstAidKit", 2,
			"Gloves_LeatherGloves", 1,
			"Hat_Fireman", 8,
			"Jacket_Fireman", 10,
			"LongJohns", 2,
			"MarkerBlack", 4,
			"SCBA_notank", 2,
			"Shoes_WorkBoots", 10,
			"Socks_Heavy", 8,
			"Trousers_Fireman", 10,
			"Tshirt_WhiteLongSleeveTINT", 10,
			"Vest_DefaultTEXTURE_TINT", 10,
			"WalkieTalkie4", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FiremanTools = {
		rolls = 3,
		items = {
			"Axe", 10,
			"Bag_MedicalBag", 0.5,
			"Bandage", 10,
			"BoltCutters", 8,
			"Bucket", 10,
			"Bullhorn", 10,
			"CarBatteryCharger", 0.1,
			"Crowbar", 4,
			"Disinfectant", 4,
			"Extinguisher", 10,
			"FirstAidKit", 2,
			"Hammer", 8,
			"HandAxe", 10,
			"LugWrench", 4,
			"Oxygen_Tank", 2,
			"PickAxe", 0.5,
			"Pills", 10,
			"PipeWrench", 6,
			"Rope", 10,
			"RubberHose", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"Shovel", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"TireIron", 4,
			"TirePump", 8,
			"WoodAxe", 0.025,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Includes a red lightbar for firetrucks.
	FireStorageMechanics = {
		rolls = 4,
		items = {
			-- Tools
			"BlowerFan", 1,
			"BlowTorch", 4,
			"Calipers", 2,
			"File", 4,
			"Funnel", 10,
			"HandDrill", 4,
			"Jack", 2,
			"LargeHook", 2,
			"LugWrench", 8,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 4,
			"Pliers", 8,
			"Ratchet", 10,
			"Screwdriver", 10,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"TireIron", 4,
			"TirePump", 8,
			"ViseGrips", 4,
			-- Materials
			"DuctTape", 4,
			"ElectricWire", 10,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"HeavyChain", 8,
			"HeavyChain_Hook", 1,
			"NutsBolts", 10,
			"RubberHose", 10,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.1,
			"WeldingRods", 8,
			-- Accessories
			"WeldingMask", 1,
			"ElbowPad_Left_Workman", 1,
			"Kneepad_Left_Workman", 4,
			-- Lights/Electronics
			"CarBatteryCharger", 1,
			"Battery", 10,
			"BatteryBox", 1,
			"LightbarRed", 20,
			-- Bags/Containers
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			-- Misc.
			"CopperScrap", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FireStorageOutfit = {
		rolls = 4,
		items = {
			"Hat_Fireman", 20,
			"Hat_Fireman", 10,
			"SCBA_notank", 4,
			"SCBA_notank", 4,
			"Jacket_Fireman", 20,
			"Jacket_Fireman", 10,
			"LongJohns", 2,
			"Shoes_WorkBoots", 10,
			"Socks_Heavy", 8,
			"Trousers_Fireman", 20,
			"Trousers_Fireman", 10,
			"WalkieTalkie4", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FireStorageTools = {
		rolls = 4,
		items = {
			"Axe", 20,
			"Axe", 10,
			"Bullhorn", 10,
			"Crowbar", 4,
			"Hammer", 8,
			"HeavyChain", 4,
			"HandAxe", 4,
			"LargeHook", 1,
			"LugWrench", 4,
			"Mov_RoadBarrier", 4,
			"Mov_RoadCone", 4,
			"Mov_RoadCone2", 4,
			"Oxygen_Tank", 10,
			"PickAxe", 0.5,
			"PipeWrench", 6,
			"Rope", 10,
			"RopeStack", 0.1,
			"Saw", 8,
			"Screwdriver", 10,
			"Shovel", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"TireIron", 4,
			"TirePump", 8,
			"WoodAxe", 0.025,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FishChipsKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"FishFillet", 20,
			"FishFillet", 20,
			"FishFillet", 10,
			"FishFillet", 10,
			-- Spices
			"Flour2", 8,
			"Pepper", 4,
			"Salt", 4,
			-- Utensils
			"KitchenKnife", 6,
			"KnifeFillet", 6,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			-- Clothing
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Hat_ChefHat", 4,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Twine", 10,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FishChipsKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Fish
			"FishFillet", 20,
			"FishFillet", 20,
			"FishFillet", 10,
			"FishFillet", 10,
			-- Chips
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FishChipsKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Fish
			"FishFillet", 20,
			"FishFillet", 20,
			"FishFillet", 10,
			"FishFillet", 10,
			-- Misc.
			"EggCarton", 8,
			"Milk", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FishChipsKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Condiments
			"Hotsauce", 8,
			"Ketchup", 20,
			"Ketchup", 10,
			"Vinegar2", 20,
			"Vinegar2", 10,
			"Vinegar_Jug", 1,
			-- Utensils
			"Ladle", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FishermanOutfit = {
		rolls = 3,
		items = {
			"Bag_Satchel_Fishing", 0.5,
			"BookFishing1", 6,
			"BookFishing2", 4,
			"BookFishing3", 2,
			"BookFishing4", 1,
			"BookFishing5", 0.5,
			"CanteenCowboy", 10,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Dungarees", 10,
			"FishingMag1", 2,
			"FishingMag2", 2,
			"Gloves_LeatherGloves", 1,
			"Handiknife", 1,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_BucketHatFishing", 4,
			"Hat_FishermanRainHat", 0.001,
			"Hat_PeakedCapYacht", 0.001,
			"InsectRepellent", 10,
			"KnifeFillet", 1,
			"KnifePocket", 1,
			"Multitool", 0.1,
			"Shoes_Wellies", 8,
			"Tacklebox", 1,
			"Toolbox_Fishing", 2,
			"WaterPurificationTablets", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FishermanTools = {
		rolls = 3,
		items = {
			"Bag_Satchel_Fishing", 0.5,
			"Bobber", 10,
			"BookFishing1", 6,
			"BookFishing2", 4,
			"BookFishing3", 2,
			"BookFishing4", 1,
			"BookFishing5", 0.5,
			"FishingHook", 10,
			"FishingHookBox", 2,
			"FishingLine", 10,
			"FishingMag1", 2,
			"FishingMag2", 2,
			"FishingNet", 8,
			"FishingRod", 4,
			"FishingTackle", 10,
			"FishingTackle2", 10,
			"Gaffhook", 2,
			"Handiknife", 1,
			"InsectRepellent", 10,
			"JigLure", 10,
			"KnifeFillet", 8,
			"KnifePocket", 1,
			"MinnowLure", 10,
			"Multitool", 0.1,
			"Pliers", 8,
			"PremiumFishingLine", 4,
			"ShortBat", 8,
			"Tacklebox", 1,
			"Toolbox_Fishing", 2,
			"Twine", 10,
			"WaterPurificationTablets", 1,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FishingStoreBait = {
		isShop = true,
		rolls = 4,
		items = {
			"BaitFish", 50,
			"BaitFish", 20,
			"BaitFish", 20,
			"BaitFish", 10,
			"BaitFish", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FishingStoreGear = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 4,
			"KeyRing_PineTree", 4,
			-- Tools
			"FishingNet", 4,
			"FishingRod", 4,
			"Gaffhook", 0.5,
			"KnifeFillet", 6,
			"ShortBat", 2,
			-- Accessories
			"Bobber", 10,
			"FishingHook", 10,
			"FishingHookBox", 2,
			"FishingLine", 8,
			"FishingTackle", 6,
			"FishingTackle2", 6,
			"JigLure", 6,
			"PremiumFishingLine", 4,
			-- Clothing
			"Chainmail_Hand_L", 2,
			"Chainmail_Hand_R", 0.1,
			"Hat_BucketHatFishing", 8,
			"Hat_FishermanRainHat", 0.1,
			"Hat_PeakedCapYacht", 0.01,
			-- Literature
			"BookFishing1", 10,
			"BookFishing2", 8,
			"BookFishing3", 6,
			"BookFishing4", 4,
			"BookFishing5", 2,
			"HerbalistMag", 2,
			"FishingMag1", 4,
			"FishingMag2", 4,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			-- Bags/Containers
			"Bag_FishingBasket", 4,
			"Tacklebox", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FitnessTrainer = {
		rolls = 4,
		items = {
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"BarBell", 4,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"DumbBell", 10,
			"Earbuds", 1,
			"ElbowPad_Left_Sport", 0.1,
			"Hat_Sweatband", 8,
			"Headphones", 1,
			"HoodieDOWN_WhiteTINT", 1,
			"Kneepad_Left_Sport", 4,
			"Magazine_Health", 10,
			"Paperback_Diet", 4,
			"Paperback_NewAge", 4,
			"Paperback_SelfHelp", 4,
			"PillsVitamins", 1,
			"Shirt_Baseball_KY", 0.5,
			"Shirt_Baseball_Rangers", 0.5,
			"Shirt_Baseball_Z", 0.5,
			"Shoes_BlueTrainers", 0.2,
			"Shoes_FlipFlop", 1,
			"Shoes_RedTrainers", 0.2,
			"Shoes_Sandals", 1,
			"Shoes_TrainerTINT", 2,
			"Shorts_LongSport", 1,
			"Shorts_ShortSport", 1,
			"Sportsbottle", 10,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"Trousers_Sport", 0.5,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_Sport", 0.5,
			"Tshirt_SportDECAL", 0.5,
			"Vest_DefaultTEXTURE_TINT", 0.5,
			"Whistle", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FoodGourmet = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Apron_White", 8,
			"Bag_PicnicBasket", 0.5,
			"BalsamicVinegar", 4,
			"Brandy", 10,
			"BookCooking1", 10,
			"BookCooking2", 8,
			"BookCooking3", 6,
			"BookCooking4", 4,
			"BookCooking5", 2,
			"BottleOpener", 2,
			"Capers", 10,
			"CannedBellPepper", 10,
			"CannedBroccoli", 10,
			"CannedCabbage", 10,
			"CannedCarrots", 10,
			"CannedEggplant", 10,
			"CannedLeek", 10,
			"CannedPotato", 10,
			"CannedRedRadish", 10,
			"CannedTomato", 10,
			"Corkscrew", 2,
			"Flask", 1,
			"Gin", 10,
			"GingerRoot", 10,
			"GlassWine", 20,
			"GlassWine", 10,
			"Hat_ChefHat", 4,
			"Hotsauce", 10,
			"IcePick", 0.1,
			"KnifeSushi", 1,
			"Olives", 10,
			"Paperback_Diet", 8,
			"Port", 10,
			"RiceVinegar", 10,
			"Rum", 10,
			"Scotch", 10,
			"Seasoning_Basil", 4,
			"Seasoning_Chives", 4,
			"Seasoning_Cilantro", 4,
			"Seasoning_Oregano", 4,
			"Seasoning_Parsley", 4,
			"Seasoning_Rosemary", 4,
			"Seasoning_Sage", 4,
			"Seasoning_Thyme", 4,
			"Sherry", 10,
			"Soysauce", 10,
			"Tequila", 10,
			"Vermouth", 10,
			"Vodka", 10,
			"Wasabi", 10,
			"Whetstone", 10,
			"Whiskey", 10,
			"Wine", 10,
			"Wine2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	ForestFireTools = {
		rolls = 4,
		items = {
			"Axe", 1,
			"Bucket", 8,
			"EmptySandbag", 20,
			"Extinguisher", 10,
			"Mov_RoadCone", 4,
			"Mov_RoadCone2", 4,
			"Sandbag", 20,
			"Sandbag", 10,
			"Shovel", 8,
			"Shovel2", 8,
			"Whetstone", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FossoilCounterCleaning = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Cleaning Supplies
			"Bleach", 8,
			"Bucket", 10,
			"CleaningLiquid2", 4,
			"DishCloth", 10,
			"Extinguisher", 8,
			"Sponge", 10,
			-- Clothing
			"Hat_BaseballCap_Fossoil", 8,
			"Hat_BaseballCap_Fossoil02", 4,
			"Tshirt_Fossoil", 10,
			-- Sign
			"Mov_SignOutOfGas_Fossoil", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_SignOutOfGas_Fossoil", 20,
			}
		}
	},

	FreezerDrugLab = {
		rolls = 4,
		items = {
			"Coldpack", 20,
			"Coldpack", 20,
			"Coldpack", 10,
			"Coldpack", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FreezerFarmStorage = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"Bacon", 20,
			"Bacon", 10,
			"ChickenFillet", 20,
			"ChickenFillet", 10,
			"ChickenWhole", 8,
			"Ham", 10,
			"MincedMeat", 20,
			"MincedMeat", 10,
			"PorkChop", 20,
			"PorkChop", 10,
			"Sausage", 20,
			"Sausage", 10,
			"Steak", 10,
			"Venison", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FreezerGarage = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"Bacon", 8,
			"Chicken", 6,
			"CornFrozen", 8,
			"Creamocle", 4,
			"FishFillet", 6,
			"Frozen_ChickenNuggets", 4,
			"Frozen_FishFingers", 4,
			"Frozen_FrenchFries", 4,
			"Frozen_TatoDots", 4,
			"FudgeePop", 4,
			"Ham", 6,
			"HotdogPack", 8,
			"Icecream", 6,
			"IcecreamSandwich", 4,
			"MeatPatty", 8,
			"MincedMeat", 8,
			"MixedVegetables", 8,
			"Mussels", 2,
			"MuttonChop", 4,
			"Peas", 8,
			"PizzaWhole", 1,
			"PizzaRecipe", 1,
			"Popsicle", 4,
			"PorkChop", 8,
			"Sausage", 8,
			"Steak", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FreezerGeneric = {
		ignoreZombieDensity = true,
		rolls = 2, -- reduced to 1 from 4 to rebalance food spawns
		items = {
			"Bacon", 8,
			"Bread", 8,
			"BunsHamburger", 4,
			"BunsHotdog", 4,
			"Chicken", 6,
			"Coldpack", 1,
			"CornFrozen", 8,
			"Creamocle", 4,
			"FishFillet", 6,
			"Frozen_ChickenNuggets", 4,
			"Frozen_FishFingers", 4,
			"Frozen_FrenchFries", 4,
			"Frozen_TatoDots", 4,
			"FudgeePop", 4,
			"Ham", 6,
			"HotdogPack", 8,
			"Icecream", 6,
			"IcecreamSandwich", 4,
			"IcePick", 0.1,
			"MeatPatty", 8,
			"MincedMeat", 8,
			"MixedVegetables", 8,
			"Mussels", 2,
			"MuttonChop", 4,
			"Oysters", 2,
			"Peas", 8,
			"PizzaWhole", 1,
			"PizzaRecipe", 1,
			"Popsicle", 4,
			"PorkChop", 8,
			"Salmon", 4,
			"Sausage", 8,
			"Shrimp", 2,
			"Steak", 6,
			"TVDinner", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FreezerRich = {
		ignoreZombieDensity = true,
		rolls = 3, -- reduced to 3 from 4 to rebalance food spawns
		items = {
			"Bacon", 10,
			"Bread", 8,
			"Baguette", 6,
			"BunsHamburger", 4,
			"BunsHotdog", 4,
			"Chicken", 8,
			"CornFrozen", 10,
			"Creamocle", 10,
			"Croissant", 6,
			"FishFillet", 8,
			"Frozen_ChickenNuggets", 5,
			"Frozen_FishFingers", 5,
			"Frozen_FrenchFries", 5,
			"Frozen_TatoDots", 5,
			"FudgeePop", 10,
			"Ham", 8,
			"HotdogPack", 10,
			"Icecream", 8,
			"IcecreamSandwich", 10,
			"IcePick", 0.1,
			"MeatPatty", 10,
			"MincedMeat", 10,
			"MixedVegetables", 10,
			"Mussels", 4,
			"MuttonChop", 6,
			"Oysters", 4,
			"Peas", 10,
			"PizzaRecipe", 1,
			"PizzaWhole", 1,
			"PorkChop", 10,
			"Salmon", 6,
			"Sausage", 10,
			"Shrimp", 4,
			"Steak", 8,
			"TVDinner", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FreezerTrailerPark = {
		ignoreZombieDensity = true,
		rolls = 1, -- reduced to 1 from 4 to rebalance food spawns
		items = {
			"Bacon", 6,
			"Bread", 8,
			"BunsHamburger", 4,
			"BunsHotdog", 4,
			"Chicken", 4,
			"CornFrozen", 6,
			"Creamocle", 6,
			"FishFillet", 4,
			"Frozen_ChickenNuggets", 3,
			"Frozen_FishFingers", 3,
			"Frozen_FrenchFries", 3,
			"Frozen_TatoDots", 3,
			"FudgeePop", 6,
			"Ham", 4,
			"HotdogPack", 6,
			"Icecream", 4,
			"IcecreamSandwich", 6,
			"IcePick", 0.1,
			"MeatPatty", 6,
			"MincedMeat", 6,
			"MixedVegetables", 6,
			"Peas", 8,
			"PizzaWhole", 1,
			"Popsicle", 6,
			"PorkChop", 6,
			"Salmon", 2,
			"Sausage", 6,
			"Steak", 4,
			"TVDinner", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FreezerFrozenFood = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 2,
		items = {
			"CornFrozen", 10,
			"Frozen_ChickenNuggets", 6,
			"Frozen_FishFingers", 6,
			"Frozen_FrenchFries", 8,
			"Frozen_TatoDots", 8,
			"MixedVegetables", 10,
			"Peas", 10,
			"PizzaWhole", 1,
			"PizzaRecipe", 1,
			"TVDinner", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FreezerIceCream = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 2,
		items = {
			"Creamocle", 8,
			"FudgeePop", 8,
			"Icecream", 20,
			"Icecream", 20,
			"Icecream", 10,
			"Icecream", 10,
			"IcecreamSandwich", 8,
			"Popsicle", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeBeer = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 2,
		items = {
			"BeerCan", 20,
			"BeerCan", 20,
			"BeerCan", 10,
			"BeerCan", 10,
			"BeerCanPack", 0.1,
			"BeerBottle", 20,
			"BeerBottle", 20,
			"BeerBottle", 10,
			"BeerBottle", 10,
			"BeerPack", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeBottles = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 2,
		items = {
			"WaterBottle", 20,
			"WaterBottle", 20,
			"WaterBottle", 10,
			"WaterBottle", 10,
			"PopBottle", 20,
			"PopBottle", 20,
			"PopBottle", 10,
			"PopBottle", 10,
			"PopBottleRare", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeBreakRoom = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"Apple", 8,
			"Banana", 8,
			"Burger", 4,
			"CakeSlice", 4,
			"CannedFruitBeverage", 1,
			"Grapefruit", 8,
			"Hotdog", 4,
			"Ketchup", 1,
			"Lunchbag", 10,
			"Lunchbox", 10,
			"Lunchbox2", 0.001,
			"MayonnaiseFull", 1,
			"Mustard", 1,
			"Orange", 8,
			"Paperbag_Jays", 0.5,
			"Paperbag_Spiffos", 0.5,
			"Peach", 8,
			"Pear", 8,
			"Pie", 4,
			"PieApple", 4,
			"PieBlueberry", 4,
			"PieKeyLime", 4,
			"PieLemonMeringue", 4,
			"PiePumpkin", 4,
			"Pop", 4,
			"Pop2", 4,
			"Pop3", 4,
			"PopBottle", 4,
			"PopBottleRare", 0.1,
			"Processedcheese", 8,
			"RemouladeFull", 1,
			"Sportsbottle", 1,
			"TVDinner", 10,
			"WaterBottle", 4,
			"Yoghurt", 4,
			"Yoghurt", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeDrugLab = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"BeerBottle", 10,
			"BeerCan", 10,
			"Flask", 1,
			"Lunchbag", 1,
			"Lunchbag", 2,
			"Lunchbox", 2,
			"Lunchbox2", 0.001,
			"MenuCard", 20,
			"MenuCard", 10,
			"PaperBag", 10,
			"Paperbag_Jays", 1,
			"Paperbag_Spiffos", 1,
			"Sportsbottle", 4,
			"WaterBottle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeFarmStorage = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"BeerCan", 20,
			"BeerCan", 10,
			"BeerBottle", 20,
			"BeerBottle", 10,
			"Butter", 10,
			"Milk", 10,
			"EggCarton", 10,
			"Pop", 8,
			"Pop2", 8,
			"Pop3", 8,
			"PopBottle", 4,
			"PopBottleRare", 1,
			"WaterBottle", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeGarage = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"BeerBottle", 20,
			"BeerBottle", 10,
			"BeerCan", 20,
			"BeerCan", 10,
			"BeerCanPack", 1,
			"BeerPack", 1,
			"Pop", 8,
			"Pop2", 8,
			"Pop3", 8,
			"PopBottle", 4,
			"PopBottleRare", 1,
			"WaterBottle", 4,
			"WaterRationCan_Box", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeGeneric = {
		ignoreZombieDensity = true,
		rolls = 2, --reduced by 2 to rebalance food
		items = {
			-- Fruit
			"Apple", 2,
			"Banana", 2,
			"Cherry", 2,
			"Grapefruit", 2,
			"Grapes", 2,
			"Lemon", 2,
			"Lime", 2,
			"Orange", 2,
			"Peach", 2,
			"Pear", 2,
			"Pineapple", 1,
			"Strewberrie", 2,
			"Watermelon", 0.5,
			-- Vegetables
			"Avocado", 1,
			"BellPepper", 1,
			"Broccoli", 2,
			"BrusselSprouts", 1,
			"Cabbage", 2,
			"Carrots", 2,
			"Cauliflower", 2,
			"Corn", 2,
			"Cucumber", 2,
			"Eggplant", 2,
			"Garlic", 2,
			"Leek", 2,
			"Lettuce", 2,
			"Onion", 2,
			"PepperJalapeno", 1,
			"Pickles", 8,
			"Potato", 2,
			"RedRadish", 2,
			"Squash", 1,
			"Tomato", 2,
			"Zucchini", 2,
			-- Ingredients
			"BakingSoda", 1,
			"Lard", 1,
			"Margarine", 2,
			-- Sauces/Condiments
			"BalsamicVinegar", 0.1,
			"BBQSauce", 1,
			"Dip_NachoCheese", 0.5,
			"Dip_Ranch", 1,
			"Dip_Salsa", 1,
			"Hotsauce", 1,
			"JamFruit", 1,
			"JamMarmalade", 0.5,
			"Ketchup", 1,
			"MapleSyrup", 1,
			"MayonnaiseFull", 1,
			"Mustard", 1,
			"RemouladeFull", 0.5,
			"SourCream", 1,
			"Soysauce", 0.5,
			-- Meat
			"Bacon", 8,
			"Baloney", 8,
			"Chicken", 6,
			"Ham", 6,
			"MeatPatty", 8,
			"MincedMeat", 8,
			"MuttonChop", 4,
			"PorkChop", 8,
			"Salami", 8,
			"Sausage", 8,
			"Steak", 6,
			-- Fish/Shellfish
			"Mussels", 2,
			"Salmon", 4,
			"Shrimp", 2,
			-- Drinks
			"BeerBottle", 2,
			"BeerCan", 2,
			"BeerCanPack", 0.05,
			"BeerPack", 0.05,
			"CannedFruitBeverage", 1,
			"Flask", 0.1,
			"JuiceBox", 1,
			"JuiceBoxApple", 1,
			"JuiceBoxFruitpunch", 1,
			"JuiceBoxOrange", 1,
			"PopBottle", 2,
			"PopBottleRare", 0.5,
			"Sportsbottle", 0.05,
			"WaterBottle", 2,
			-- Eggs/Dairy
			"Butter", 2,
			"Cheese", 2,
			"EggCarton", 0.5,
			"Milk", 8,
			"MilkChocolate_Personalsized", 4,
			"Processedcheese", 8,
			"Yoghurt", 4,
			-- Misc.
			"Paperbag_Jays", 0.1,
			"Paperbag_Spiffos", 0.1,
			"TakeoutBox_Chinese", 0.1,
			"TakeoutBox_Styrofoam", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeMedical = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"Coldpack", 20,
			"Coldpack", 20,
			"Coldpack", 10,
			"Coldpack", 10,
			"WaterBottle", 20,
			"WaterBottle", 20,
			"WaterBottle", 10,
			"WaterBottle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeOffice = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"Apple", 8,
			"Banana", 8,
			"Burger", 4,
			"CakeSlice", 4,
			"CannedFruitBeverage", 1,
			"Hotdog", 4,
			"Lunchbag", 10,
			"Lunchbox", 10,
			"Lunchbox2", 0.001,
			"Orange", 8,
			"Peach", 8,
			"Pie", 4,
			"PieApple", 4,
			"PieBlueberry", 4,
			"PieKeyLime", 4,
			"PieLemonMeringue", 4,
			"PiePumpkin", 4,
			"Pop", 4,
			"Pop2", 4,
			"Pop3", 4,
			"Pizza", 4,
			"PopBottle", 4,
			"PopBottleRare", 0.1,
			"Sportsbottle", 1,
			"TakeoutBox_Chinese", 10,
			"TakeoutBox_Styrofoam", 10,
			"WaterBottle", 4,
			"Yoghurt", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeOther = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 2,
		items = {
			"Butter", 10,
			"Cheese", 20,
			"Cheese", 10,
			"EggCarton", 20,
			"EggCarton", 10,
			"Lard", 6,
			"Margarine", 10,
			"MayonnaiseFull", 10,
			"Milk", 20,
			"Milk", 10,
			"Processedcheese", 20,
			"Processedcheese", 10,
			"RemouladeFull", 6,
			"Yoghurt", 20,
			"Yoghurt", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeRich = {
		ignoreZombieDensity = true,
		rolls = 3, -- reduced to 3 from 4 to rebalance food spawns
		items = {
			"Apple", 4,
			"Avocado", 4,
			"Bacon", 2,
			"Bag_PicnicBasket", 0.1,
			"BakingSoda", 1,
			"Baloney", 4,
			"BalsamicVinegar", 0.5,
			"Banana", 4,
			"Basil", 2,
			"BeerBottle", 4,
			"BeerPack", 0.1,
			"BellPepper", 4,
			"Broccoli", 4,
			"Butter", 8,
			"Cabbage", 4,
			"CannedBellPepper", 4,
			"CannedBroccoli", 2,
			"CannedCabbage", 2,
			"CannedCarrots", 2,
			"CannedEggplant", 6,
			"CannedFruitBeverage", 1,
			"CannedLeek", 2,
			"CannedPotato", 2,
			"CannedRedRadish", 2,
			"CannedTomato", 6,
			"Carrots", 4,
			"Cauliflower", 4,
			"Caviar", 0.1,
			"Cheese", 4,
			"Cherry", 4,
			"Chicken", 2,
			"Chives", 2,
			"Cilantro", 2,
			"Corn", 4,
			"Cucumber", 4,
			"Dip_NachoCheese", 1,
			"Dip_Ranch", 2,
			"Dip_Salsa", 2,
			"EggCarton", 2,
			"Eggplant", 4,
			"Flask", 0.01,
			"GingerRoot", 2,
			"Grapefruit", 4,
			"Grapes", 4,
			"Ham", 8,
			"Hotsauce", 2,
			"JuiceBox", 2,
			"JuiceBoxApple", 2,
			"JuiceBoxFruitpunch", 2,
			"JuiceBoxOrange", 2,
			"Ketchup", 2,
			"Lard", 4,
			"Leek", 4,
			"Lemon", 4,
			"Lettuce", 4,
			"Lime", 4,
			"Lobster", 2,
			"MapleSyrup", 2,
			"Margarine", 4,
			"MayonnaiseFull", 2,
			"MeatPatty", 10,
			"Milk", 10,
			"MilkChocolate_Personalsized", 6,
			"MincedMeat", 10,
			"Mustard", 2,
			"MuttonChop", 6,
			"Onion", 4,
			"Orange", 4,
			"Oregano", 2,
			"Parsley", 2,
			"Peach", 4,
			"Pear", 4,
			"PepperJalapeno", 2,
			"Pickles", 10,
			"Pineapple", 2,
			"PopBottle", 4,
			"PopBottleRare", 0.1,
			"PorkChop", 10,
			"Processedcheese", 10,
			"RedRadish", 4,
			"RemouladeFull", 1,
			"Rosemary", 2,
			"Sage", 2,
			"Salami", 10,
			"Salmon", 6,
			"Sausage", 10,
			"SesameOil", 1,
			"SourCream", 2,
			"Soysauce", 1,
			"Sportsbottle", 0.05,
			"Squid", 2,
			"Steak", 2,
			"Strewberrie", 4,
			"TakeoutBox_Chinese", 0.5,
			"Thyme", 2,
			"Tomato", 4,
			"WaterBottle", 4,
			"Watermelon", 1,
			"Wine", 2,
			"Wine2", 2,
			"Yoghurt", 6,
			"Zucchini", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Bag_PicnicBasket", 0.1,
			}
		}
	},
	
	FridgeSnacks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			-- Snacks
			"BagelPlain", 2,
			"BagelPoppy", 2,
			"BagelSesame", 2,
			"Burger", 8,
			"Burrito", 8,
			"Corndog", 8,
			"Croissant", 4,
			"Danish", 4,
			"Hotdog", 8,
			"MuffinFruit", 4,
			"MuffinGeneric", 4,
			"Yoghurt", 8,
			-- Drinks
			"JuiceBox", 6,
			"JuiceBoxApple", 6,
			"JuiceBoxFruitpunch", 6,
			"JuiceBoxOrange", 6,
			"MilkChocolate_Personalsized", 8,
			"Milk_Personalsized", 8,
			"WaterBottle", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeSoda = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Pop", 10,
			"Pop", 4,
			"Pop2", 10,
			"Pop2", 4,
			"Pop3", 10,
			"Pop3", 4,
			"PopBottle", 8,
			"PopBottle", 2,
			"PopBottleRare", 4,
			"SodaCan", 10,
			--"SodaCanRare", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeTrailerPark = {
		ignoreZombieDensity = true,
		rolls = 1, -- reduced to 1 from 4 to rebalance food spawns
		items = {
			"Apple", 1,
			"BBQSauce", 0.5,
			"Bacon", 6,
			"BakingSoda", 1,
			"Baloney", 0.8,
			"Banana", 1,
			"BeerCan", 4,
			"BeerCanPack", 0.1,
			"Butter", 1,
			"Cabbage", 1,
			"Carrots", 1,
			"Cauliflower", 1,
			"Chicken", 0.4,
			"Cooler_Beer", 1,
			"Corn", 1,
			"Dip_NachoCheese", 0.1,
			"Dip_Ranch", 0.5,
			"Dip_Salsa", 0.5,
			"EggCarton", 0.4,
			"Flask", 0.01,
			"Garlic", 1,
			"Grapefruit", 1,
			"Grapes", 1,
			"Ham", 0.8,
			"Hotsauce", 0.5,
			"JuiceBox", 1,
			"JuiceBoxApple", 1,
			"JuiceBoxFruitpunch", 1,
			"JuiceBoxOrange", 1,
			"Ketchup", 0.5,
			"Lard", 0.5,
			"Lemon", 1,
			"Lime", 1,
			"MapleSyrup", 0.5,
			"Margarine", 1,
			"MayonnaiseFull", 0.5,
			"MeatPatty", 6,
			"Milk", 6,
			"MincedMeat", 6,
			"Mustard", 0.5,
			"Onion", 1,
			"Orange", 1,
			"Paperbag_Jays", 0.1,
			"Paperbag_Spiffos", 0.1,
			"Pickles", 6,
			"Pop", 2,
			"Pop2", 2,
			"Pop3", 2,
			"PopBottle", 2,
			"PopBottleRare", 0.05,
			"PorkChop", 6,
			"Processedcheese", 6,
			"RedRadish", 1,
			"RemouladeFull", 0.1,
			"Sausage", 6,
			"Sportsbottle", 0.05,
			"Steak", 4,
			"Strewberrie", 1,
			"TakeoutBox_Chinese", 0.1,
			"TakeoutBox_Styrofoam", 0.1,
			"Tomato", 1,
			"WaterBottle", 1,
			"Yoghurt", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	FridgeVIPLounge = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BeerImported", 50,
			"BeerImported", 20,
			"BeerImported", 10,
			"BeerImported", 10,
			"Caviar", 8,
			"Champagne", 8,
			"WaterBottle", 20,
			"WaterBottle", 10,
			"Wine", 20,
			"Wine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Corkscrew", 8,
				"IcePick", 4,
			}
		}
	},

	FridgeWater = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 2,
		items = {
			"WaterBottle", 50,
			"WaterBottle", 20,
			"WaterBottle", 20,
			"WaterBottle", 10,
			"WaterBottle", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Clone of ProduceStoragePotatoes. Might be useful for modders/future stuff to have a separate container, plus it's been around for a while already.
	FryFactoryPotatoes = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Potato,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	GarageCarpentry = {
		rolls = 4,
		items = {
			-- Tools
			"Axe", 0.01,
			"CarpentryChisel", 8,
			"ClubHammer", 2,
			"GardenSaw", 6,
			"Hammer", 4,
			"HandAxe", 2,
			"HandDrill", 2,
			"KnifePocket", 0.1,
			"Pliers", 4,
			"Saw", 4,
			"Screwdriver", 6,
			"ViseGrips", 2,
			"WoodAxe", 0.01,
			"WoodenMallet", 2,
			-- Lumber
			"LongHandle", 8,
			"Handle", 8,
			"LongStick", 8,
			"Plank", 20,
			"Plank", 20,
			"Plank", 10,
			"Plank", 10,
			"SmallHandle", 8,
			"WoodenStick2", 8,
			-- Materials
			"CircularSawblade", 2,
			"Doorknob", 2,
			"DuctTape", 4,
			"Epoxy", 1,
			"Hinge", 4,
			"Latch", 1,
			"NailsBox", 4,
			"NailsCarton", 0.5,
			"Rope", 8,
			"ScrewsBox", 4,
			"ScrewsCarton", 0.1,
			"Twine", 8,
			"Woodglue", 2,
			-- Equipmemt
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 4,
			"Gloves_LeatherGloves", 1,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 8,
			"Hat_EarMuff_Protectors", 8,
			"Hat_HardHat", 4,
			"Kneepad_Left_Workman", 4,
			"RespiratorFilters", 2,
			-- Misc.
			"GraphPaper", 4,
			"MeasuringTape", 8,
			"Mov_LightConstruction", 0.1,
			"Tsquare", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Nails", 8,
				"Nails", 4,
			}
		}
	},
	
	GarageFirearms = {
		rolls = 4,
		items = {
			-- Guns
			"AssaultRifle2", 0.5,
			"DoubleBarrelShotgun", 2,
			"HuntingRifle", 4,
			"Pistol", 4,
			"Pistol2", 2,
			"Pistol3", 1,
			"Revolver", 2,
			"Revolver_Long", 1,
			"Revolver_Short", 4,
			"Shotgun", 4,
			"VarmintRifle", 6,
			-- Accessories
			"AmmoStrap_Bullets", 4,
			"AmmoStrap_Shells", 4,
			"Bag_ALICE_BeltSus_Camo", 0.1,
			"Bag_ALICE_BeltSus_Green", 0.1,
			"ChokeTubeFull", 4,
			"ChokeTubeImproved", 2,
			"GunLight", 1,
			"HolsterAnkle", 1,
			"HolsterDouble", 4,
			"HolsterShoulder", 2,
			"HolsterSimple_Brown", 8,
			"RecoilPad", 4,
			"RedDot", 4,
			"x2Scope", 4,
			"x4Scope", 2,
			"x8Scope", 1,
			-- Knives
			"HuntingKnife", 4,
			"KnifeButterfly", 0.1,
			"KnifePocket", 0.5,
			"LargeKnife", 1,
			"SmallKnife", 2,
			-- Bags/Containers
			"Bag_AmmoBox_Hunting", 6,
			"Bag_AmmoBox_Mixed", 4,
			"Bag_ProtectiveCaseBulkyAmmo", 1,
			"Bag_ProtectiveCaseBulkyAmmo_Hunting", 1,
			"Bag_ProtectiveCaseSmall_Armorer", 1,
			"Bag_ProtectiveCaseSmall_Pistol1", 1,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.5,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.1,
			"Bag_ProtectiveCaseSmall_Revolver1", 1,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.5,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.1,
			"Bag_RifleCaseCloth", 1,
			"Bag_RifleCaseCloth2", 0.5,
			"Bag_ShotgunCaseCloth", 1,
			"Bag_ShotgunCaseCloth2", 1,
			"PistolCase1", 1,
			"PistolCase2", 0.5,
			"PistolCase3", 0.1,
			"RevolverCase1", 1,
			"RevolverCase2", 0.5,
			"RevolverCase3", 0.1,
			"RifleCase1", 0.5,
			"RifleCase2", 0.1,
			"RifleCase3", 0.05,
			"ShotgunCase1", 0.5,
			"ShotgunCase2", 0.5,
			-- Misc.
			"FirstAidKit", 4,
			"FlashLight_AngleHead_Army", 1,
			"Glasses_Prescription_Shooting", 0.5,
			"Glasses_Shooting", 8,
			"Hat_EarMuff_Protectors", 8,
			"MilitaryMedal", 0.1,
			"Mov_FlagUSA", 4,
			"Mov_FlagUSALarge", 1,
			"Mov_HuntingTrophy", 1,
			"Paperback_MilitaryHistory", 4,
			"Screwdriver", 10,
			"ShemaghScarf_Green", 0.1,
			-- Literature (Skill Books)
			"BookAiming1", 1,
			"BookAiming2", 0.8,
			"BookAiming3", 0.6,
			"BookAiming4", 0.4,
			"BookAiming5", 0.2,
			"BookReloading1", 1,
			"BookReloading2", 0.8,
			"BookReloading3", 0.6,
			"BookReloading4", 0.4,
			"BookReloading5", 0.2,
			-- Literature (Magazines)
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"HerbalistMag", 1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"Magazine_Crime", 2,
			"Magazine_Firearm", 8,
			"Magazine_Military", 2,
			"Magazine_Outdoors", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	GarageMechanics = {
		rolls = 4,
		items = {
			-- Tools
			"BlowerFan", 0.5,
			"BlowTorch", 4,
			"Calipers", 1,
			"File", 1,
			"Funnel", 6,
			"HeavyChain", 4,
			"HeavyChain_Hook", 0.5,
			"Jack", 4,
			"LargeHook", 0.5,
			"LugWrench", 1,
			"MetalworkingChisel", 1,
			"MetalworkingPunch", 1,
			"Screwdriver", 6,
			"SheetMetalSnips", 2,
			"SmallFileSet", 1,
			"SmallPunchSet", 1,
			"SmallSaw", 1,
			"TireIron", 1,
			"TirePump", 4,
			"Wrench", 4,
			-- Batteries
			"Battery", 4,
			"BatteryBox", 0.5,
			"CarBattery1", 2,
			"CarBattery2", 2,
			"CarBattery3", 2,
			"CarBatteryCharger", 4,
			-- Literature (Skill Books)
			"BookElectrician1", 6,
			"BookElectrician2", 4,
			"BookElectrician3", 2,
			"BookElectrician4", 1,
			"BookElectrician5", 0.5,
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"BookMechanic3", 6,
			"BookMechanic4", 4,
			"BookMechanic5", 2,
			-- Accessories
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 4,
			"Gloves_LeatherGloves", 1,
			"HandTorch", 8,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_EarMuff_Protectors", 8,
			"Kneepad_Left_Workman", 4,
			"RespiratorFilters", 2,
			"WeldingMask", 1,
			-- Fuel
			"PetrolCan", 2,
			"PetrolCanEmpty", 10,
			-- Materials
			"ElectricWire", 8,
			"Epoxy", 4,
			"FiberglassTape", 4,
			"LightBulb", 8,
			"LightBulbBox", 0.5,
			"RubberHose", 8,
			"SteelWool", 8,
			-- Misc.
			"GraphPaper", 4,
			"Magazine_Car", 10,
			"Mov_LightConstruction", 0.1,
			"Tarp", 8,
			-- Bags/Containers
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GarageMetalwork = {
		rolls = 4,
		items = {
			-- Tools
			"BallPeenHammer", 4,
			"Bellows", 8, -- Increased for testing purposes.
			"BenchAnvil", 0.1,
			"BlowTorch", 4,
			"BoltCutters", 2,
			"Calipers", 2,
			"CeramicCrucible", 0.05,
			"DrawPlate", 2,
			"File", 2,
			"HandDrill", 2,
			"MetalworkingChisel", 2,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 2,
			"Pliers", 2,
			"Screwdriver", 6,
			"SheetMetalSnips", 4,
			"SmallFileSet", 2,
			"SmallPunchSet", 2,
			"SmallSaw", 2,
			"SmithingHammer", 1,
			"Tongs", 0.5,
			"ViseGrips", 2,
			-- Accessories
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 4,
			"Gloves_LeatherGloves", 1,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"Kneepad_Left_Workman", 4,
			"RespiratorFilters", 2,
			"WeldingMask", 4,
			-- Materials
			"Epoxy", 2,
			"FiberglassTape", 2,
			"NutsBolts", 10,
			"Screws", 10,
			"ScrewsBox", 4,
			"SteelWool", 10,
			"WeldingRods", 8,
			"Wire", 10,
			-- Misc.
			"GraphPaper", 4,
			"Mov_ElectricBlowerForge", 0.01,
			"Mov_LightConstruction", 0.1,
			-- Metal
			"MetalBar", 10,
			"MetalPipe", 10,
			"SheetMetal", 20,
			"SmallSheetMetal", 10,
			"SteelBar", 4,
			"SteelBarHalf", 8,
			-- Fuel
			"Oxygen_Tank", 10,
			"Propane_Refill", 10,
			-- Special
			"Bag_ProtectiveCaseSmall_KeyCutting", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GarageTools = {
		rolls = 4,
		items = {
			-- Landscaping/Gardening
			"GardenFork", 1,
			"GardenHoe", 2,
			"GardenSaw", 10,
			"HandFork", 2,
			"HandScythe", 2,
			"HandShovel", 10,
			"LeafRake", 10,
			"Machete", 0.01,
			"PickAxe", 0.5,
			"Rake", 10,
			"Scythe", 1,
			"Shovel", 4,
			"Shovel2", 4,
			"SnowShovel", 2,
			-- Tools
			"Axe", 0.05,
			"CarpentryChisel", 2,
			"ClubHammer", 4,
			"Crowbar", 4,
			"File", 2,
			"Hammer", 8,
			"HandAxe", 4,
			"HandDrill", 4,
			"KnifePocket", 0.5,
			"LargeKnife", 1,
			"PipeWrench", 6,
			"Pliers", 8,
			"Screwdriver", 10,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"ViseGrips", 4,
			"WoodAxe", 0.025,
			"WoodenMallet", 4,
			"Wrench", 8,
			-- Mechanics
			"Funnel", 10,
			"LugWrench", 4,
			"Ratchet", 10,
			"TireIron", 4,
			"TirePump", 8,
			-- Metalworking
			"BallPeenHammer", 4,
			"Calipers", 2,
			"MetalworkingChisel", 2,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 2,
			"Saw", 8,
			"SheetMetalSnips", 4,
			"SmallFileSet", 2,
			"SmallPunchSet", 2,
			"SmallSaw", 2,
			-- Accessories
			"ElbowPad_Left_Workman", 0.5,
			"Glasses_SafetyGoggles", 4,
			"Gloves_LeatherGloves", 1,
			"Hat_BuildersRespirator", 1,
			"Hat_DustMask", 6,
			"Hat_EarMuff_Protectors", 4,
			"Kneepad_Left_Workman", 2,
			"RespiratorFilters", 1,
			-- Materials
			"CircularSawblade", 4,
			"NutsBolts", 8,
			"Rope", 10,
			"RubberHose", 10,
			"SteelWool", 10,
			"Twine", 10,
			-- Masonry
			"MasonsChisel", 1,
			"MasonsTrowel", 1,
			-- Misc.
			"GraphPaper", 4,
			"MeasuringTape", 10,
			"Mov_LightConstruction", 0.1,
			"RatPoison", 1,
			"Tongs", 1,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GardenerOutfit = {
		rolls = 3,
		items = {
			"Dungarees", 10,
			"ElbowPad_Left_Workman", 1,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"GardeningSprayEmpty", 6,
			"Gloves_LeatherGloves", 1,
			"HandShovel", 10,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_StrawHat", 8,
			"Hat_SummerHat", 2,
			"HerbalistMag", 2,
			"Kneepad_Left_Workman", 4,
			"KnifePocket", 1,
			"MarkerBlack", 4,
			"RippedSheets", 10,
			"Shoes_WorkBoots", 8,
			"SlugRepellent", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GardenerTools = {
		rolls = 3,
		items = {
			"Bag_GardenBasket", 10,
			"BookFarming1", 6,
			"BookFarming2", 4,
			"BookFarming3", 2,
			"BookFarming4", 1,
			"BookFarming5", 0.5,
			"BookForaging1", 6,
			"BookForaging2", 4,
			"BookForaging3", 2,
			"BookForaging4", 1,
			"BookForaging5", 0.5,
			"Bucket", 4,
			"BurlapPiece", 4,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"GardenFork", 2,
			"GardenHoe", 4,
			"GardeningSprayEmpty", 6,
			"GardenSaw", 10,
			"HandAxe", 4,
			"HandFork", 4,
			"HandScythe", 4,
			"HandShovel", 10,
			"HerbalistMag", 2,
			"KnapsackSprayer", 1,
			"LeafRake", 10,
			"Machete", 0.5,
			"Padlock", 4,
			"PickAxe", 1,
			"Rake", 10,
			"RakeHead", 4,
			"RippedSheets", 10,
			"Scythe", 4,
			"SlugRepellent", 10,
			"Stake", 10,
			"TrapMouse", 8,
			"Twine", 10,
			"WateredCan", 6,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GardenStoreMisc = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_GardenBasket", 10,
			"Base.BasilBagSeed", 4,
			"Base.BellPepperBagSeed", 2,
			"Base.BroccoliBagSeed2", 2,
			"Base.CabbageBagSeed2", 2,
			"Base.CarrotBagSeed2", 2,
			"Base.CauliflowerBagSeed", 2,
			"Base.ChamomileBagSeed", 4,
			"Base.ChivesBagSeed", 4,
			"Base.CilantroBagSeed", 4,
			"Base.CucumberBagSeed", 2,
			"Base.GarlicBagSeed", 2,
			"Base.GreenpeasBagSeed", 2,
			"Base.HabaneroBagSeed", 1,
			"Base.JalapenoBagSeed", 2,
			"Base.KaleBagSeed", 2,
			"Base.LeekBagSeed", 2,
			"Base.LemonGrassBagSeed", 4,
			"Base.LettuceBagSeed", 2,
			"Base.MarigoldBagSeed", 4,
			"Base.MintBagSeed", 4,
			"Base.OnionBagSeed", 2,
			"Base.OreganoBagSeed", 4,
			"Base.ParsleyBagSeed", 4,
			"Base.PotatoBagSeed2", 2,
			"Base.PumpkinBagSeed", 2,
			"Base.RedRadishBagSeed2", 2,
			"Base.RosemaryBagSeed", 4,
			"Base.SageBagSeed", 4,
			"Base.SpinachBagSeed", 2,
			"Base.StrewberrieBagSeed2", 2,
			"Base.SunflowerBagSeed", 4,
			"Base.ThymeBagSeed", 4,
			"Base.TomatoBagSeed2", 2,
			"Base.TurnipBagSeed", 2,
			"Base.WatermelonBagSeed", 2,
			"Base.ZucchiniBagSeed", 2,
			"BookFarming1", 10,
			"BookFarming2", 8,
			"BookFarming3", 6,
			"BookFarming4", 4,
			"BookFarming5", 2,
			"Book_Farming", 4,
			"BookForaging1", 10,
			"BookForaging2", 8,
			"BookForaging3", 6,
			"BookForaging4", 4,
			"BookForaging5", 2,
			"BookMasonry1", 10,
			"BookMasonry2", 8,
			"BookMasonry3", 6,
			"BookMasonry4", 4,
			"BookMasonry5", 2,
			"BoxOfJars", 1,
			"BurlapPiece", 8,
			"ElbowPad_Left_Workman", 1,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"GardeningSprayEmpty", 10,
			"HandShovel", 10,
			"Kneepad_Left_Workman", 4,
			"Mov_GardenGnome", 4,
			"Mov_PinkFlamingo", 4,
			"Mov_SaltLick", 4,
			"SlugRepellent", 10,
			"TrapMouse", 8,
			"WateredCan", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GardenStoreTools = {
		isShop = true,
		rolls = 4,
		items = {
			"Bucket", 2,
			"GardenHoe", 2,
			"GardenFork", 2,
			"GardeningSprayEmpty", 10,
			"GardenSaw", 10,
			"HandAxe", 4,
			"HandFork", 1,
			"HandScythe", 1,
			"HandShovel", 10,
			"KnapsackSprayer", 4,
			"LeafRake", 10,
			"Machete", 0.01,
			"Rake", 10,
			"RakeHead", 4,
			"Scythe", 1,
			"Shovel", 4,
			"Stake", 20,
			"Stake", 10,
			"WateredCan", 10,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	Gas2GoCounterCleaning = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Cleaning Supplies
			"Bleach", 8,
			"Bucket", 10,
			"CleaningLiquid2", 4,
			"DishCloth", 10,
			"Extinguisher", 8,
			"Sponge", 10,
			-- Clothing
			"Tshirt_Gas2Go", 4,
			"Hat_BaseballCap_Gas2Go", 4,
			-- Sign
			"Mov_SignOutOfGas_Gas2Go", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_SignOutOfGas_Gas2Go", 20,
			}
		}
	},
	
	GasStorageMechanics = {
		isShop = true,
		rolls = 4,
		items = {
			"Base.LouisvilleMap1", 0.05,
			"Base.LouisvilleMap2", 0.05,
			"Base.LouisvilleMap3", 0.05,
			"Base.LouisvilleMap4", 0.05,
			"Base.LouisvilleMap5", 0.05,
			"Base.LouisvilleMap6", 0.05,
			"Base.LouisvilleMap7", 0.05,
			"Base.LouisvilleMap8", 0.05,
			"Base.LouisvilleMap9", 0.05,
			"Base.MarchRidgeMap", 0.4,
			"Base.MuldraughMap", 0.4,
			"Base.RiversideMap", 0.4,
			"Base.RosewoodMap", 0.4,
			"Base.WestpointMap", 0.4,
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"Funnel", 10,
			"HeavyChain", 2,
			"LightBulb", 20,
			"LightBulb", 10,
			"LightBulbBox", 0.1,
			"LugWrench", 4,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"PetrolCanEmpty", 20,
			"PetrolCanEmpty", 10,
			"RubberHose", 10,
			"TireIron", 4,
			"TirePump", 8,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GasStorageCombo = {
		isShop = true,
		rolls = 4,
		items = {
			"Allsorts", 2,
			"BeefJerky", 10,
			"CandyCaramels", 2,
			"CandyCorn", 2,
			"CandyFruitSlices", 2,
			"CandyGummyfish", 2,
			"CandyNovapops", 2,
			"CandyPackage", 1,
			"ChocoCakes", 4,
			"Chocolate", 4,
			"Chocolate_Butterchunkers", 2,
			"Chocolate_Candy", 4,
			"Chocolate_Crackle", 2,
			"Chocolate_Deux", 2,
			"Chocolate_GalacticDairy", 2,
			"Chocolate_RoysPBPucks", 2,
			"Chocolate_Smirkers", 2,
			"Chocolate_SnikSnak", 2,
			"Crisps", 6,
			"Crisps2", 6,
			"Crisps3", 6,
			"Crisps4", 6,
			"DehydratedMeatStick", 10,
			"GranolaBar", 4,
			"Gum", 4,
			"GummyBears", 2,
			"GummyWorms", 2,
			"HardCandies", 2,
			"HiHis", 4,
			"JellyBeans", 2,
			"Jujubes", 2,
			"LicoriceBlack", 1,
			"LicoriceRed", 2,
			"Lollipop", 2,
			"Matches", 8,
			"Peanuts", 4,
			"Peppermint", 2,
			"Plonkies", 4,
			"Pop", 8,
			"Pop2", 8,
			"Pop3", 8,
			"PopBottle", 2,
			"PopBottleRare", 0.1,
			"PorkRinds", 6,
			"QuaggaCakes", 4,
			"SnoGlobes", 4,
			"SunflowerSeeds", 4,
			"TortillaChips", 6,
			"WaterBottle", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GasStoreCounterCleaning = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Cleaning Supplies
			"Bleach", 8,
			"Bucket", 10,
			"CleaningLiquid2", 4,
			"DishCloth", 10,
			"Extinguisher", 8,
			"Sponge", 10,
			-- Misc.
			"Mov_SignOutOfGas", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_SignOutOfGas", 20,
			}
		}
	},
	
	GasStoreSpecial = {
		isShop = true,
		rolls = 4,
		items = {
			-- Tobacco
			"Cigar", 0.5,
			"CigaretteCarton", 0.01,
			"CigarettePack", 20,
			"CigarettePack", 10,
			"CigaretteRollingPapers", 1,
			"Cigarillo", 8,
			"Cigarillo", 8,
			"TobaccoChewing", 1,
			"TobaccoLoose", 1,
			-- Lighters/Matches
			"Lighter", 10,
			"LighterDisposable", 20,
			"LighterFluid", 1,
			"Matches", 20,
			"Matches", 10,
			-- Keyrings
			"KeyRing_Bass", 0.5,
			"KeyRing_BlueFox", 0.1,
			"KeyRing_Bug", 0.1,
			"KeyRing_EagleFlag", 0.5,
			"KeyRing_EightBall", 0.5,
			"KeyRing_Hotdog", 0.1,
			"KeyRing_Kitty", 0.1,
			"KeyRing_Panther", 0.5,
			"KeyRing_PineTree", 0.5,
			"KeyRing_PrayingHands", 0.5,
			"KeyRing_RainbowStar", 0.1,
			"KeyRing_RubberDuck", 0.1,
			"KeyRing_Sexy", 0.1,
			-- Bandanas
			"Hat_Bandana", 10,
			"Hat_BandanaTINT", 20,
			"Hat_BandanaTINT", 10,
			-- Sunglasses
			"Glasses", 2,
			"Glasses_Aviators", 2,
			"Glasses_Sun", 2,
			-- Gloves
			"Gloves_LeatherGloves", 1,
			-- Knives
			"KnifeButterfly", 4,
			"KnifePocket", 1,
			-- Misc.
			"Sparklers", 8,
			"Firecracker", 20,
			"Firecracker", 10,
			"FlaskEmpty", 1,
			"PillsVitamins", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GasStoreEmergency = {
		isShop = true,
		rolls = 4,
		items = {
			"BatteryBox", 8,
			"BookMechanic1", 2,
			"CandleBox", 8,
			"CarBatteryCharger", 6,
			"Epoxy", 2,
			"Extinguisher", 10,
			"FiberglassTape", 2,
			"FirstAidKit_New", 10,
			"Funnel", 10,
			"Jack", 2,
			"LugWrench", 6,
			"Matchbox", 2,
			"PetrolCanEmpty", 20,
			"PetrolCanEmpty", 10,
			"Pliers", 8,
			"Ratchet", 20,
			"RubberHose", 10,
			"Rope", 20,
			"Rope", 10,
			"Screwdriver", 10,
			"TireIron", 4,
			"TirePump", 8,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Wrench", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GasStoreToiletries = {
		isShop = true,
		rolls = 4,
		items = {
			"Razor", 10,
			"Soap2", 20,
			"Soap2", 10,
			"TissueBox", 20,
			"TissueBox", 10,
			"ToiletPaper", 20,
			"ToiletPaper", 10,
			"Toothbrush", 10,
			"Toothpaste", 20,
			"Toothpaste", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GeneratorRoom = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- TODO: Sort Me!
			"BlowerFan", 1,
			"BlowTorch", 10,
			"Boilersuit", 8,
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"BoltCutters", 8,
			"CopperScrap", 10,
			"Crowbar", 4,
			"DuctTape", 4,
			"Dungarees", 4,
			"ElbowPad_Left_Workman", 1,
			"ElectricWire", 20,
			"ElectricWire", 10,
			"ElectronicsScrap", 20,
			"ElectronicsScrap", 10,
			"Epoxy", 2,
			"Extinguisher", 6,
			"FiberglassTape", 2,
			"FlashLight_AngleHead", 1,
			"Glasses_SafetyGoggles", 8,
			"HandDrill", 4,
			"HandTorch", 8,
			"Hat_EarMuff_Protectors", 8,
			"Kneepad_Left_Workman", 4,
			"MeasuringTape", 10,
			"NutsBolts", 8,
			"Oxygen_Tank", 10,
			"Pliers", 8,
			"Propane_Refill", 10,
			"Ratchet", 10,
			"RippedSheets", 8,
			"RippedSheetsDirty", 10,
			"Screwdriver", 10,
			"SheetMetalSnips", 4,
			"Toolbox", 2,
			"Torch", 4,
			"Vest_Foreman", 1,
			"Vest_HighViz", 4,
			"ViseGrips", 4,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	Gifts = {
		isShop = true,
		rolls = 4,
		items = {
			"Belt2", 8,
			"BorisBadger", 0.001,
			"Boxers_Hearts", 0.8,
			"Boxers_RedStripes", 0.8,
			"Boxers_Silk_Black", 0.4,
			"Boxers_Silk_Red", 0.4,
			"Bricktoys", 10,
			"Briefs_AnimalPrints", 0.8,
			"Briefs_SmallTrunks_Black", 0.2,
			"Briefs_SmallTrunks_Blue", 0.2,
			"Briefs_SmallTrunks_Red", 0.2,
			"Briefs_SmallTrunks_WhiteTINT", 0.2,
			"Briefs_White", 1,
			"Card_Birthday", 10,
			"Card_Christmas", 10,
			"Card_Hanukkah", 10,
			"Card_LunarYear", 10,
			"Card_Valentine", 10,
			"CardDeck", 8,
			"Cologne", 8,
			"Crayons", 10,
			"Cube", 10,
			"Dice", 8,
			"Disc_Retail", 2,
			"Doll", 10,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"JacquesBeaver", 0.001,
			"Lipstick", 8,
			"MakeupEyeshadow", 4,
			"MoleyMole", 0.001,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"PenFancy", 8,
			"Perfume", 8,
			"Plushabug", 0.001,
			"Pocketwatch", 4,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 4,
			"Socks_Ankle_White", 1,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Long_Black", 4,
			"Socks_Long_White", 1,
			"Spiffo", 0.001,
			"ToyBear", 10,
			"ToyCar", 10,
			"TrickMag1", 0.1,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"VHS_Retail", 1,
			"VideoGame", 4,
			"Wallet", 20,
			"Yoyo", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GiftStoreFancy = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keyrings
			"KeyRing_Bass", 1,
			"KeyRing_BlueFox", 1,
			"KeyRing_Bug", 1,
			"KeyRing_Clover", 1,
			"KeyRing_EagleFlag", 1,
			"KeyRing_EightBall", 1,
			"KeyRing_Hotdog", 1,
			"KeyRing_Kitty", 1,
			"KeyRing_Panther", 1,
			"KeyRing_PineTree", 1,
			"KeyRing_PrayingHands", 1,
			"KeyRing_RabbitFoot", 1,
			"KeyRing_RainbowStar", 1,
			"KeyRing_RubberDuck", 1,
			"KeyRing", 1,
			-- Clothing
			"Belt2", 10,
			"Gloves_LeatherGloves", 4,
			"Gloves_LeatherGlovesBlack", 4,
			"Hat_GolfHat", 1,
			"Scarf_StripeBlackWhite", 4,
			-- Alcohol/Tobacco
			"BottleOpener", 8,
			"BottleOpener_Keychain", 8,
			"Cigar", 4,
			"Cigarillo", 4,
			"Corkscrew", 8,
			"FlaskEmpty", 4,
			"Lighter", 8,
			"SmokingPipe", 4,
			"TobaccoLoose", 4,
			-- Store Magazines
			"Magazine_Rich_New", 20,
			"Magazine_Rich_New", 10,
			-- Misc.
			"ButterKnife_Gold", 0.1,
			"ButterKnife_Silver", 1,
			"Cologne", 10,
			"Diary2", 8,
			"Handiknife", 2,
			"Fork_Gold", 0.1,
			"Fork_Silver", 1,
			"KnifePocket", 2,
			"LetterOpener", 4,
			"PenFancy", 8,
			"Perfume", 10,
			"Spoon_Gold", 0.1,
			"Spoon_Silver", 1,
			"StraightRazor", 4,
			"Wallet", 20,
			-- Watches
			"Pocketwatch", 4,
			"WristWatch_Left_ClassicBlack", 8,
			"WristWatch_Left_ClassicBrown", 8,
			"WristWatch_Left_ClassicGold", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GiftStoreCards = {
		isShop = true,
		rolls = 4,
		items = {
			"Card_Birthday", 20,
			"Card_Christmas", 10,
			"Card_Easter", 10,
			"Card_Halloween", 10,
			"Card_Hanukkah", 10,
			"Card_LunarYear", 10,
			"Card_StPatrick", 10,
			"Card_Sympathy", 10,
			"Card_Valentine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GiftStoreToys = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_BlueFox", 2,
			"KeyRing_Bug", 2,
			"KeyRing_EightBall", 2,
			"KeyRing_Hotdog", 2,
			"KeyRing_Kitty", 2,
			"KeyRing_PrayingHands", 2,
			"KeyRing_RainbowStar", 2,
			"KeyRing_RubberDuck", 2,
			-- Collectibles
			"BorisBadger", 0.001,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"JacquesBeaver", 0.001,
			"MoleyMole", 0.001,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"Plushabug", 0.001,
			"Spiffo", 0.001,
			-- Toys
			"Bricktoys", 20,
			"Bricktoys", 10,
			"CardDeck", 8,
			"Crayons", 20,
			"Crayons", 10,
			"Cube", 20,
			"Cube", 10,
			"Dice", 8,
			"Doll", 20,
			"Doll", 10,
			"RubberSpider", 10,
			"ToyBear", 20,
			"ToyBear", 10,
			"ToyCar", 20,
			"ToyCar", 10,
			"Yoyo", 20,
			"Yoyo", 10,
			-- Masks
			"Hat_HalloweenMaskDevil", 0.01,
			"Hat_HalloweenMaskMonster", 0.01,
			"Hat_HalloweenMaskPumpkin", 0.01,
			"Hat_HalloweenMaskSkeleton", 0.01,
			"Hat_HalloweenMaskVampire", 0.01,
			"Hat_HalloweenMaskWitch", 0.01,
			"Hat_Pirate", 0.01,
			"Hat_Wizard", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartBakingMisc = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Aluminum", 20,
			"Aluminum", 10,
			"BakingSoda", 10,
			"CannedMilk", 2,
			"CannedMilk_Box", 0.02,
			"Cinnamon", 10,
			"ChocolateChips", 10,
			"CocoaPowder", 10,
			"Flour2", 20,
			"Flour2", 10,
			"OatsRaw", 10,
			"OilOlive", 10,
			"OilVegetable", 10,
			"Sparklers", 1,
			"Sugar", 10,
			"SugarBrown", 10,
			"Yeast", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartBathing = {
		isShop = true,
		rolls = 4,
		items = {
			"BathTowel", 20,
			"BathTowel", 20,
			"BathTowel", 10,
			"BathTowel", 10,
			"Shoes_FlipFlop", 10,
			"HairDryer", 10,
			"HairIron", 10,
			"Hat_ShowerCap", 10,
			"LongCoat_Bathrobe", 20,
			"LongCoat_Bathrobe", 10,
			"Mirror", 10,
			"Razor", 10,
			"Rubberducky", 10,
			"Soap2", 20,
			"Soap2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartBBQ = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Apron_BBQ", 8,
			"Apron_Black", 4,
			"Apron_White", 4,
			"BBQSauce", 20,
			"BBQSauce", 10,
			"BBQStarterFluid", 1,
			"BastingBrush", 10,
			"BunsHamburger", 20,
			"BunsHamburger", 10,
			"BunsHotdog", 20,
			"BunsHotdog", 10,
			"CarvingFork2", 10,
			"Charcoal", 4,
			"Charcoal", 4,
			"Charcoal", 4,
			"Charcoal", 4,
			"GrillBrush", 10,
			"Hat_ChefHat", 4,
			"LighterBBQ", 10,
			"KitchenKnife", 6,
			"KitchenTongs", 10,
			"MeatCleaver", 4,
			"OvenMitt", 10,
			"Spatula", 10,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartBedding = {
		isShop = true,
		rolls = 4,
		items = {
			"Button", 10,
			"DishCloth", 20,
			"DishCloth", 10,
			-- NOTE: Temporarily bumped for testing purposes.
			"IndustrialDye", 20,
			"KnittingNeedles", 10,
			"Needle", 10,
			"SewingKit", 4,
			"Pillow", 20,
			"Pillow", 10,
			"Sheet", 20,
			"Sheet", 20,
			"Sheet", 10,
			"Sheet", 10,
			"Thread", 20,
			"Thread", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartBottles = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"WaterBottle", 20,
			"WaterBottle", 10,
			"PopBottle", 20,
			"PopBottle", 10,
			"PopBottleRare", 2,
			"Pop", 20,
			"Pop", 10,
			"Pop2", 20,
			"Pop2", 10,
			"Pop3", 20,
			"Pop3", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartBreakfast = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Cereal", 20,
			"Cereal", 20,
			"Cereal", 10,
			"Cereal", 10,
			"Coffee2", 20,
			"Coffee2", 10,
			"JamFruit", 20,
			"JamFruit", 10,
			"JamMarmalade", 6,
			"MapleSyrup", 20,
			"MapleSyrup", 10,
			"PeanutButter", 20,
			"PeanutButter", 10,
			"OatsRaw", 20,
			"OatsRaw", 10,
			"Teabag2", 20,
			"Teabag2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartCandy = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Allsorts", 8,
			"CandyCaramels", 8,
			"CandyFruitSlices", 8,
			"CandyGummyfish", 8,
			"CandyNovapops", 8,
			"CandyPackage", 2,
			"CandyCorn", 8,
			"Chocolate", 8,
			"ChocolateCoveredCoffeeBeans", 8,
			"Chocolate_Butterchunkers", 4,
			"Chocolate_Candy", 8,
			"Chocolate_Crackle", 4,
			"Chocolate_Deux", 4,
			"Chocolate_GalacticDairy", 4,
			"Chocolate_RoysPBPucks", 4,
			"Chocolate_Smirkers", 4,
			"Chocolate_SnikSnak", 4,
			"GranolaBar", 8,
			"Gum", 8,
			"GummyBears", 8,
			"GummyWorms", 8,
			"HardCandies", 8,
			"JellyBeans", 8,
			"Jujubes", 8,
			"LicoriceBlack", 8,
			"LicoriceRed", 8,
			"Lollipop", 8,
			"MintCandy", 8,
			"Modjeska", 8,
			"Peppermint", 8,
			"RockCandy", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartCannedFood = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CannedBolognese", 6,
			"CannedBolognese_Box", 0.06,
			"CannedCarrots2", 4,
			"CannedCarrots_Box", 0.04,
			"CannedChili", 6,
			"CannedChili_Box", 0.06,
			"CannedCorn", 4,
			"CannedCorn_Box", 0.04,
			"CannedCornedBeef", 6,
			"CannedCornedBeef_Box", 0.06,
			"CannedFruitBeverage", 6,
			"CannedFruitBeverage_Box", 0.06,
			"CannedFruitCocktail", 6,
			"CannedFruitCocktail_Box", 0.06,
			"CannedMilk", 2,
			"CannedMilk_Box", 0.02,
			"CannedMushroomSoup", 6,
			"CannedMushroomSoup_Box", 0.06,
			"CannedPeaches", 4,
			"CannedPeaches_Box", 0.04,
			"CannedPeas", 4,
			"CannedPeas_Box", 0.04,
			"CannedPineapple", 4,
			"CannedPineapple_Box", 0.04,
			"CannedPotato2", 4,
			"CannedPotato_Box", 0.04,
			"CannedSardines", 6,
			"CannedSardines_Box", 0.06,
			"CannedTomato2", 4,
			"CannedTomato_Box", 0.04,
			"TinnedBeans", 6,
			"TinnedBeans_Box", 0.06,
			"TinnedSoup", 6,
			"TinnedSoup_Box", 0.06,
			"TunaTin", 6,
			"TunaTin", 0.06,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartCleaning = {
		isShop = true,
		rolls = 4,
		items = {
			"Bleach", 20,
			"Bleach", 10,
			"Broom", 10,
			"CleaningLiquid2", 20,
			"CleaningLiquid2", 10,
			"DishCloth", 20,
			"DishCloth", 10,
			"Garbagebag_box", 20,
			"Garbagebag_box", 10,
			"Gloves_Dish", 20,
			"Gloves_Dish", 10,
			"Mop", 10,
			"Sponge", 20,
			"Sponge", 10,
			"SteelWool", 20,
			"SteelWool", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartCosmetics = {
		isShop = true,
		rolls = 4,
		items = {
			"Cologne", 10,
			"HairDyeCommon", 8,
			"HairDyeUncommon", 2,
			"Hairgel", 20,
			"Hairgel", 10,
			"Hairspray2", 20,
			"Hairspray2", 10,
			"Lipstick", 20,
			"Lipstick", 10,
			"MakeupEyeshadow", 10,
			"MakeupFoundation", 10,
			"Perfume", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartCrisps = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Crisps", 20,
			"Crisps", 10,
			"Crisps2", 20,
			"Crisps2", 10,
			"Crisps3", 20,
			"Crisps3", 10,
			"Crisps4", 20,
			"Crisps4", 10,
			"TortillaChips", 10,
			"Peanuts", 10,
			"Popcorn", 10,
			"PorkRinds", 10,
			"SunflowerSeeds", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartDryGoods = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BouillonCube", 10,
			"Crackers", 10,
			"DriedApricots", 10,
			"DriedBlackBeans", 8,
			"DriedChickpeas", 8,
			"DriedKidneyBeans", 8,
			"DriedLentils", 8,
			"DriedSplitPeas", 8,
			"DriedWhiteBeans", 8,
			"Macandcheese", 6,
			"Macandcheese_Box", 0.06,
			"Macaroni", 10,
			"Pasta", 10,
			"Ramen", 10,
			"Rice", 10,
			"TacoShell", 10,
			"Tortilla", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	-- Seedbags in stores are empty so are more common here than in other containers.
	GigamartFarming = {
		isShop = true,
		rolls = 4,
		items = {
			"AnimalFeedBag", 10,
			"Bag_GardenBasket", 10,
			"Base.BarleyBagSeed", 8,
			"Base.BasilBagSeed", 1,
			"Base.BellPepperBagSeed", 2,
			"Base.BroccoliBagSeed2", 2,
			"Base.CabbageBagSeed2", 2,
			"Base.CarrotBagSeed2", 2,
			"Base.CauliflowerBagSeed", 2,
			"Base.ChamomileBagSeed", 1,
			"Base.ChivesBagSeed", 1,
			"Base.CilantroBagSeed", 1,
			"Base.CornBagSeed", 8,
			"Base.CucumberBagSeed", 2,
			"Base.FlaxBagSeed", 8,
			"Base.GarlicBagSeed", 2,
			"Base.GreenpeasBagSeed", 2,
			"Base.HabaneroBagSeed", 1,
			"Base.HopsBagSeed", 8,
			"Base.JalapenoBagSeed", 2,
			"Base.KaleBagSeed", 2,
			"Base.LeekBagSeed", 2,
			"Base.LemonGrassBagSeed", 4,
			"Base.LettuceBagSeed", 2,
			"Base.MarigoldBagSeed", 4,
			"Base.MintBagSeed", 4,
			"Base.OnionBagSeed", 2,
			"Base.OreganoBagSeed", 4,
			"Base.ParsleyBagSeed", 4,
			"Base.PotatoBagSeed2", 2,
			"Base.PumpkinBagSeed", 2,
			"Base.RedRadishBagSeed2", 2,
			"Base.RosemaryBagSeed", 1,
			"Base.RyeBagSeed", 8,
			"Base.SageBagSeed", 1,
			"Base.SpinachBagSeed", 2,
			"Base.StrewberrieBagSeed2", 2,
			"Base.SugarBeetBagSeed", 8,
			"Base.SunflowerBagSeed", 2,
			"Base.SweetPotatoBagSeed", 2,
			"Base.ThymeBagSeed", 1,
			"Base.TobaccoBagSeed", 8,
			"Base.TomatoBagSeed2", 2,
			"Base.TurnipBagSeed", 2,
			"Base.WatermelonBagSeed", 2,
			"Base.WheatBagSeed", 8,
			"Base.ZucchiniBagSeed", 2,
			"BookButchering1", 10,
			"BookButchering2", 8,
			"BookButchering3", 6,
			"BookButchering4", 4,
			"BookButchering5", 2,
			"BookFarming1", 10,
			"BookFarming2", 8,
			"BookFarming3", 6,
			"BookFarming4", 4,
			"BookFarming5", 2,
			"BookHusbandry1", 10,
			"BookHusbandry2", 8,
			"BookHusbandry3", 6,
			"BookHusbandry4", 4,
			"BookHusbandry5", 2,
			"Bucket", 2,
			"BurlapPiece", 4,
			"CompostBag", 1,
			"ElbowPad_Left_Workman", 1,
			"Fertilizer", 2,
			"Fleshing_Tool", 10,
			"GardenFork", 0.5,
			"GardenHoe", 2,
			"GardenSaw", 10,
			"GardeningSprayEmpty", 6,
			"HandAxe", 2,
			"HandFork", 2,
			"HandScythe", 2,
			"HandShovel", 10,
			"HandShovel", 6,
			"KnapsackSprayer", 0.5,
			"Kneepad_Left_Workman", 4,
			"LeafRake", 10,
			"Machete", 0.01,
			"Padlock", 3,
			"PickAxe", 0.5,
			"Rake", 10,
			"RakeHead", 4,
			"RatPoison", 1,
			"Scythe", 10,
			"SeedBag", 10,
			"SlugRepellent", 10,
			"WateredCan", 6,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartHouseElectronics = {
		isShop = true,
		rolls = 4,
		items = {
			"BatteryBox", 20,
			"BatteryBox", 10,
			"CDplayer", 20,
			"CDplayer", 10,
			"CordlessPhone", 20,
			"CordlessPhone", 10,
			"ElectricWire", 6,
			"HairDryer", 10,
			"HairIron", 10,
			"HandTorch", 8,
			"PowerBar", 10,
			"Microphone", 8,
			"Mov_CoffeeMaker", 4,
			"Mov_Espresso", 0.5,
			"Mov_Microwave", 4,
			"Mov_Microwave2", 4,
			"Mov_Toaster", 6,
			"PenLight", 8,
			"PowerBar", 20,
			"PowerBar", 10,
			"RadioBlack", 8,
			"RadioRed", 4,
			"Remote", 10,
			"Torch", 4,
			"VideoGame", 20,
			"VideoGame", 10,
			"WalkieTalkie2", 8,
			"WalkieTalkie3", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartHousewares = {
		isShop = true,
		rolls = 4,
		items = {
			"Bowl", 20,
			"Bowl", 10,
			"ButterKnife", 10,
			"Candle", 20,
			"Candle", 10,
			"CheeseGrater", 10,
			"DrinkingGlass", 20,
			"DrinkingGlass", 10,
			"Fork", 10,
			"GlassTumbler", 10,
			"GlassWine", 6,
			"Ladle", 10,
			"Mugl", 10,
			"PizzaCutter", 10,
			"Plate", 20,
			"Plate", 10,
			"Spoon", 10,
			"Teacup", 10,
			"Whetstone", 10,
			"Whisk", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartLiterature = {
		isShop = true,
		rolls = 4,
		items = {
			"Magazine_Fashion_New", 8,
			"Magazine_Health_New", 8,
			"Magazine_Hobby_New", 8,
			"Magazine_Humor_New", 8,
			"Magazine_Sports_New", 8,
			"Magazine_Teens_New", 8,
			"Paperback_Childs", 8,
			"Paperback_CrimeFiction", 8,
			"Paperback_Diet", 8,
			"Paperback_Fashion", 8,
			"Paperback_NewAge", 8,
			"Paperback_Relationship", 8,
			"Paperback_Romance", 20,
			"Paperback_Romance", 10,
			"Paperback_SelfHelp", 8,
			"Paperback_Sports", 8,
			"Paperback_Thriller", 8,
			"Paperback_Travel", 8,
			"Paperback_TrueCrime", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartPaper = {
		isShop = true,
		rolls = 4,
		items = {
			"TissueBox", 20,
			"TissueBox", 20,
			"TissueBox", 10,
			"TissueBox", 10,
			"ToiletPaper", 20,
			"ToiletPaper", 20,
			"ToiletPaper", 10,
			"ToiletPaper", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartPots = {
		isShop = true,
		rolls = 4,
		items = {
			"BakingPan", 10,
			"BakingTray", 10,
			"BastingBrush", 10,
			"BreadKnife", 8,
			"CarvingFork2", 10,
			"GridlePan", 10,
			"GrillBrush", 10,
			"Kettle", 10,
			"Kettle_Copper", 2,
			"KitchenKnife", 6,
			"KnifeFillet", 6,
			"KnifeParing", 6,
			"MeatCleaver", 4,
			"MuffinTray", 10,
			"Pan", 10,
			"Pot", 10,
			"RoastingPan", 10,
			"Saucepan", 10,
			"SaucepanCopper", 2,
			"Spatula", 10,
			"Strainer", 10,
			"OvenMitt", 10,
			"CuttingBoardPlastic", 10,
			"CuttingBoardWooden", 6,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartSauce = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BalsamicVinegar", 2,
			"BBQSauce", 20,
			"BBQSauce", 10,
			"Dip_NachoCheese", 8,
			"Dip_Ranch", 8,
			"Dip_Salsa", 8,
			"Hotsauce", 10,
			"JamFruit", 10,
			"JamMarmalade", 8,
			"Ketchup", 10,
			"Marinara", 20,
			"Marinara", 10,
			"Mustard", 10,
			"PeanutButter", 10,
			"RiceVinegar", 4,
			"Soysauce", 8,
			"Vinegar2", 8,
			"Vinegar_Jug", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartSchool = {
		isShop = true,
		rolls = 4,
		items = {
			"AdhesiveTapeBox", 0.1,
			"Bag_Satchel", 6,
			"Bag_Schoolbag", 20,
			"Bag_Schoolbag", 20,
			"Bag_Schoolbag", 10,
			"Bag_Schoolbag", 10,
			"BluePen", 10,
			"Calculator", 10,
			"Clipboard", 10,
			"Eraser", 10,
			"Glue", 8,
			"GreenPen", 10,
			"MarkerBlack", 10,
			"MarkerBlue", 8,
			"MarkerGreen", 8,
			"MarkerRed", 8,
			"Mov_BinRound", 4,
			"Mov_CorkBoard", 4,
			"Mov_WallClock", 4,
			"Notepad", 10,
			"PaperclipBox", 10,
			"Pen", 10,
			"Pencil", 20,
			"Pencil", 10,
			"PencilSpiffo", 1,
			"PenSpiffo", 1,
			"RedPen", 10,
			"RubberBand", 10,
			"Scissors", 10,
			"ScissorsBlunt", 10,
			"Scotchtape", 10,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartSpices = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Capers", 20,
			"Capers", 10,
			"Olives", 20,
			"Olives", 10,
			"Pepper", 20,
			"Pepper", 10,
			"PowderedGarlic", 20,
			"PowderedGarlic", 10,
			"PowderedOnion", 20,
			"PowderedOnion", 10,
			"Salt", 20,
			"Salt", 10,
			"SeasoningSalt", 20,
			"SeasoningSalt", 10,
			"Seasoning_Basil", 8,
			"Seasoning_Chives", 8,
			"Seasoning_Cilantro", 8,
			"Seasoning_Oregano", 8,
			"Seasoning_Parsley", 8,
			"Seasoning_Rosemary", 8,
			"Seasoning_Sage", 8,
			"Seasoning_Thyme", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartLightbulb = {
		isShop = true,
		rolls = 4,
		items = {
			"LightBulbBox", 20,
			"LightBulbBox", 10,
			"LightBulbBlue", 8,
			"LightBulbCyan", 8,
			"LightBulbGreen", 8,
			"LightBulbMagenta", 8,
			"LightBulbOrange", 8,
			"LightBulbPink", 8,
			"LightBulbPurple", 8,
			"LightBulbRed", 8,
			"LightBulbYellow", 8,
			"Mov_Lamp1", 4,
			"Mov_Lamp2", 4,
			"Mov_Lamp3", 4,
			"Mov_Lamp4", 4,
			"Mov_Lamp5", 4,
			"Mov_Lamp6", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Mov_Lamp1", 8,
				"Mov_Lamp2", 8,
				"Mov_Lamp3", 8,
				"Mov_Lamp4", 8,
				"Mov_Lamp5", 8,
				"Mov_Lamp6", 8,
			}
		}
	},
	
	GigamartToiletries = {
		isShop = true,
		rolls = 4,
		items = {
			"HairDryer", 10,
			"HairIron", 10,
			"Razor", 10,
			"Soap2", 20,
			"Soap2", 10,
			"TissueBox", 20,
			"TissueBox", 20,
			"TissueBox", 10,
			"TissueBox", 10,
			"Toothbrush", 10,
			"Toothpaste", 20,
			"Toothpaste", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartTools = {
		isShop = true,
		rolls = 4,
		items = {
			"Axe", 0.05,
			"BallPeenHammer", 6,
			"Brush", 4,
			"Calipers", 1,
			"CarpentryChisel", 4,
			"CircularSawblade", 4,
			"ClubHammer", 4,
			"CombinationPadlock", 10,
			"Crowbar", 4,
			"ElbowPad_Left_Workman", 1,
			"Epoxy", 1,
			"FiberglassTape", 1,
			"File", 1,
			"Fleshing_Tool", 4,
			"Funnel", 10,
			"Hammer", 8,
			"HandAxe", 4,
			"HandDrill", 4,
			"Handiknife", 8,
			"Handle", 2,
			"Hat_BuildersRespirator", 2,
			"Kneepad_Left_Workman", 4,
			"LeafRake", 10,
			"LongHandle", 1,
			"LongStick", 1,
			"LugWrench", 4,
			"MasonsChisel", 10,
			"MasonsTrowel", 10,
			"MeasuringTape", 10,
			"MetalworkingChisel", 1,
			"MetalworkingPliers", 0.1,
			"MetalworkingPunch", 1,
			"Multitool", 0.1,
			"NailsBox", 10,
			"NailsCarton", 0.5,
			"NutsBolts", 8,
			"Padlock", 10,
			"PickAxe", 0.5,
			"PipeWrench", 6,
			"PlasterTrowel", 8,
			"Pliers", 8,
			"Rake", 10,
			"RakeHead", 4,
			"Ratchet", 10,
			"RespiratorFilters", 2,
			"Rope", 20,
			"Rope", 10,
			"RopeStack", 0.1,
			"RubberHose", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.1,
			"SheetMetalSnips", 4,
			"Shovel", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"SmallFileSet", 1,
			"SmallHandle", 2,
			"SmallPunchSet", 1,
			"SmallSaw", 1,
			"SnowShovel", 2,
			"SteelWool", 10,
			"TireIron", 4,
			"TirePump", 8,
			"Twine", 10,
			"ViseGrips", 4,
			"Whetstone", 10,
			"WoodenMallet", 4,
			"WoodenStick2", 2,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GigamartToys = {
		isShop = true,
		rolls = 4,
		items = {
			"BorisBadger", 0.001,
			"Bricktoys", 20,
			"Bricktoys", 10,
			"CardDeck", 8,
			"Crayons", 20,
			"Crayons", 10,
			"Cube", 20,
			"Cube", 10,
			"Dice", 8,
			"Doll", 20,
			"Doll", 10,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"Hat_HalloweenMaskDevil", 0.01,
			"Hat_HalloweenMaskMonster", 0.01,
			"Hat_HalloweenMaskPumpkin", 0.01,
			"Hat_HalloweenMaskSkeleton", 0.01,
			"Hat_HalloweenMaskVampire", 0.01,
			"Hat_HalloweenMaskWitch", 0.01,
			"Hat_Pirate", 0.05,
			"Hat_Wizard", 0.05,
			"JacquesBeaver", 0.001,
			"MoleyMole", 0.001,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"RubberSpider", 10,
			"Spiffo", 0.001,
			"ToyBear", 20,
			"ToyBear", 10,
			"ToyCar", 20,
			"ToyCar", 10,
			"Yoyo", 20,
			"Yoyo", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GolfLockers = {
		rolls = 4,
		items = {
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_GolfBag", 10,
			"Bag_Satchel", 0.2,
			"BathTowel", 8,
			"Belt2", 4,
			"BluePen", 8,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Eraser", 8,
			"Flask", 0.5,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Sun", 1,
			"Gloves_LeatherGloves", 4,
			"GolfBall", 20,
			"GolfBall", 10,
			"Golfclub", 10,
			"Gum", 10,
			"Handbag", 0.5,
			"Hat_GolfHatTINT", 10,
			"Hat_VisorBlack", 4,
			"Hat_VisorRed", 4,
			"Hat_Visor_WhiteTINT", 10,
			"Headphones", 1,
			"Magazine", 1,
			"Magazine_Business", 4,
			"Magazine_Golf", 10,
			"Magazine_Rich", 4,
			"Money", 20,
			"Money", 10,
			"Notepad", 10,
			"Paperback_Business", 4,
			"Paperback_Golf", 8,
			"Paperback_Rich", 4,
			"Pen", 8,
			"Pencil", 10,
			"Purse", 0.5,
			"RedPen", 8,
			"Sportsbottle", 4,
			"Tshirt_PoloStripedTINT", 10,
			"Tshirt_PoloTINT", 10,
			"TrophyBronze", 10,
			"TrophyGold", 1,
			"TrophySilver", 5,
			"Whistle", 2,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},
	
	GolfFactoryTools = {
		-- Club shafts are made by drawing bars out. Heads are forged and milled.
		rolls = 4,
		items = {
			"AluminumFragments", 1,
			"BallPeenHammer", 8,
			"Calipers", 8,
			"DrawPlate", 20,
			"DrawPlate", 10,
			"Epoxy", 4,
			"File", 8,
			"Glasses_SafetyGoggles", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"Hat_HardHat", 2,
			"MarkerBlack", 10,
			"MeasuringTape", 10,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"Pliers", 8,
			"RespiratorFilters", 2,
			"Saw", 8,
			"Screwdriver", 10,
			"Screws", 10,
			"ScrewsBox", 4,
			"ScrewsCarton", 0.1,
			"SheetMetalSnips", 4,
			"SmallFileSet", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"SteelBar", 20,
			"SteelBar", 10,
			"ViseGrips", 4,
			"WeldingMask", 4,
			"Tongs", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GolfStoreBags = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_GolfBag", 50,
			"Bag_GolfBag", 20,
			"Bag_GolfBag", 20,
			"Bag_GolfBag", 10,
			"Bag_GolfBag", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	GolfStoreAccessories = {
		isShop = true,
		rolls = 4,
		items = {
			"Gloves_LeatherGloves", 8,
			"GolfBall", 50,
			"GolfBall", 50,
			"GolfBall", 20,
			"GolfBall", 20,
			"GolfTee", 50,
			"GolfTee", 50,
			"GolfTee", 20,
			"GolfTee", 20,
			"Hat_GolfHat", 8,
			"Hat_GolfHatTINT", 10,
			"Hat_VisorBlack", 8,
			"Hat_VisorRed", 8,
			"Hat_Visor_WhiteTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	GolfStoreClothingRack = {
		isShop = true,
		rolls = 4,
		items = {
			"Jumper_TankTopTINT", 20,
			"Jumper_TankTopDiamondTINT", 20,
			"Tshirt_PoloStripedTINT", 20,
			"Tshirt_PoloTINT", 20,
			"Trousers_SuitWhite", 20,
			"Trousers_SuitWhite", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GolfStoreLiterature = {
		isShop = true,
		rolls = 4,
		items = {
			"Magazine_Golf", 50,
			"Magazine_Golf", 20,
			"Magazine_Golf", 20,
			"Magazine_Golf", 10,
			"Magazine_Golf", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GolfStorage = {
		-- Golf-related items for gyms and public recreation facilities.
		rolls = 4,
		items = {
			"Bag_GolfBag", 8,
			"Gloves_LeatherGloves", 2,
			"GolfBall", 50,
			"GolfBall", 50,
			"GolfBall", 20,
			"GolfBall", 20,
			"Golfclub", 20,
			"Golfclub", 20,
			"Golfclub", 10,
			"Golfclub", 10,
			"GolfTee", 50,
			"GolfTee", 50,
			"GolfTee", 20,
			"GolfTee", 20,
			"Hat_GolfHat", 1,
			"Hat_GolfHatTINT", 4,
			"Hat_VisorBlack", 2,
			"Hat_VisorRed", 2,
			"Hat_Visor_WhiteTINT", 8,
			"Jumper_TankTopTINT", 1,
			"Jumper_TankTopDiamondTINT", 1,
			"Magazine_Golf", 20,
			"Trousers_SuitWhite", 4,
			"Tshirt_PoloStripedTINT", 2,
			"Tshirt_PoloTINT", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GrillAcessories = {
		isShop = true,
		rolls = 4,
		items = {
			"Apron_BBQ", 8,
			"Apron_Black", 4,
			"Apron_White", 4,
			"BastingBrush", 20,
			"BastingBrush", 10,
			"BBQStarterFluid", 1,
			"CarvingFork2", 20,
			"CarvingFork2", 10,
			"Cooler", 10,
			"CuttingBoardWooden", 10,
			"GrillBrush", 20,
			"GrillBrush", 10,
			"KitchenTongs", 10,
			"LighterBBQ", 10,
			"Spatula", 20,
			"Spatula", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GrillStoreBlackBBQ = {
		isShop = true,
		rolls = 1,
		items = {
			"Mov_BlackBBQ", 200,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GrillStoreRedBBQ = {
		isShop = true,
		rolls = 1,
		items = {
			"Mov_RedBBQ", 200,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStandFruits1 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Apple", 20,
			"Apple", 10,
			"Banana", 20,
			"Banana", 10,
			"Peach", 20,
			"Peach", 10,
			"Pear", 20,
			"Pear", 10,
			"Pineapple", 8,
			"Watermelon", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStandFruits2 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Cherry", 20,
			"Cherry", 10,
			"Grapes", 20,
			"Grapes", 10,
			"Mango", 20,
			"Mango", 10,
			"Pineapple", 8,
			"Strewberrie", 20,
			"Strewberrie", 10,
			"Watermelon", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStandFruits3 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Grapefruit", 20,
			"Grapefruit", 10,
			"Lemon", 20,
			"Lemon", 10,
			"Lime", 20,
			"Lime", 10,
			"Orange", 20,
			"Orange", 10,
			"Pineapple", 8,
			"Watermelon", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStandLettuce = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
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
		}
	},

	GroceryStandVegetables1 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Carrots", 20,
			"Carrots", 10,
			"Cucumber", 20,
			"Cucumber", 10,
			"Leek", 20,
			"Leek", 10,
			"Onion", 20,
			"Onion", 10,
			"Potato", 20,
			"Potato", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStandVegetables2 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Corn", 20,
			"Corn", 10,
			"RedRadish", 20,
			"RedRadish", 10,
			"Squash", 20,
			"Squash", 10,
			"Tomato", 20,
			"Tomato", 10,
			"Zucchini", 20,
			"Zucchini", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStandVegetables3 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Avocado", 20,
			"Avocado", 10,
			"BellPepper", 20,
			"BellPepper", 10,
			"Blackbeans", 20,
			"Blackbeans", 10,
			"PepperHabanero", 20,
			"PepperHabanero", 10,
			"PepperJalapeno", 20,
			"PepperJalapeno", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStandVegetables4 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Broccoli", 20,
			"Broccoli", 10,
			"BrusselSprouts", 20,
			"BrusselSprouts", 10,
			"Cabbage", 20,
			"Cabbage", 10,
			"Spinach", 20,
			"Spinach", 10,
			"Eggplant", 20,
			"Eggplant", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStandVegetables5 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Cauliflower", 20,
			"Cauliflower", 10,
			"Greenpeas", 20,
			"Greenpeas", 10,
			"Kale", 20,
			"Kale", 10,
			"MushroomsButton", 20,
			"MushroomsButton", 10,
			"SweetPotato", 20,
			"SweetPotato", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStorageCrate1 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Allsorts", 1,
			"BouillonCube", 1,
			"CandyCaramels", 1,
			"CandyCorn", 1,
			"CandyFruitSlices", 1,
			"CandyGummyfish", 1,
			"CandyNovapops", 1,
			"CandyPackage", 1,
			"CannedBolognese", 1,
			"CannedBolognese_Box", 0.01,
			"CannedCarrots2", 0.8,
			"CannedCarrots_Box", 0.008,
			"CannedChili", 1,
			"CannedChili_Box", 0.01,
			"CannedCorn", 0.8,
			"CannedCorn_Box", 0.008,
			"CannedCornedBeef", 1,
			"CannedCornedBeef_Box", 0.01,
			"CannedFruitCocktail", 1,
			"CannedFruitCocktail_Box", 0.01,
			"CannedMilk", 0.2,
			"CannedMilk_Box", 0.002,
			"CannedMushroomSoup", 1,
			"CannedMushroomSoup_Box", 0.01,
			"CannedPeaches", 0.8,
			"CannedPeaches_Box", 0.008,
			"CannedPeas", 0.8,
			"CannedPeas_Box", 0.008,
			"CannedPineapple", 0.8,
			"CannedPineapple_Box", 0.008,
			"CannedPotato2", 0.8,
			"CannedPotato_Box", 0.008,
			"CannedSardines", 1,
			"CannedSardines_Box", 0.01,
			"CannedTomato2", 0.8,
			"CannedTomato_Box", 0.008,
			"Cereal", 1,
			"ChocoCakes", 1,
			"Chocolate", 1,
			"ChocolateCoveredCoffeeBeans", 1,
			"Chocolate_Butterchunkers", 1,
			"Chocolate_Candy", 1,
			"Chocolate_Crackle", 1,
			"Chocolate_Deux", 1,
			"Chocolate_GalacticDairy", 1,
			"Chocolate_RoysPBPucks", 1,
			"Chocolate_Smirkers", 1,
			"Chocolate_SnikSnak", 1,
			"Coffee2", 1,
			"Crackers", 1,
			"Crisps", 1,
			"Crisps2", 1,
			"Crisps3", 1,
			"Crisps4", 1,
			"DehydratedMeatStick", 1,
			"DriedBlackBeans", 0.8,
			"DriedChickpeas", 0.8,
			"DriedKidneyBeans", 0.8,
			"DriedLentils", 0.8,
			"DriedSplitPeas", 0.8,
			"DriedWhiteBeans", 0.8,
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
			"Macandcheese", 1,
			"Macaroni", 0.5,
			"MintCandy", 1,
			"Modjeska", 1,
			"Pasta", 0.5,
			"Peanuts", 1,
			"Peppermint", 1,
			"Plonkies", 1,
			"Pop", 2,
			"Pop2", 2,
			"Pop3", 2,
			"PopBottle", 1,
			"PopBottleRare", 0.01,
			"Popcorn", 1,
			"PorkRinds", 1,
			"Ramen", 1,
			"Rice", 1,
			"RockCandy", 1,
			"SunflowerSeeds", 1,
			"TacoShell", 1,
			"Teabag2", 1,
			"TinnedBeans", 1,
			"TinnedBeans_Box", 0.01,
			"TinnedSoup", 1,
			"TinnedSoup_Box", 0.01,
			"Tortilla", 1,
			"TortillaChips", 1,
			"TunaTin", 1,
			"WaterBottle", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStorageCrate2 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CannedCarrots2", 10,
			"CannedCarrots_Box", 0.1,
			"CannedCorn", 10,
			"CannedCorn_Box", 0.1,
			"CannedPeas", 10,
			"CannedPeas_Box", 0.1,
			"CannedPotato2", 10,
			"CannedPotato_Box", 0.1,
			"CannedTomato2", 10,
			"CannedTomato_Box", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GroceryStorageCrate3 = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"CannedFruitBeverage", 10,
			"CannedFruitBeverage_Box", 0.1,
			"CannedFruitCocktail", 10,
			"CannedFruitCocktail_Box", 0.1,
			"CannedPeaches", 10,
			"CannedPeaches_Box", 0.1,
			"CannedPineapple", 10,
			"CannedPineapple_Box", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreAccessories = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_Bass", 2,
			"KeyRing_EagleFlag", 2,
			"KeyRing_PineTree", 2,
			"KeyRing_PrayingHands", 2,
			-- Scopes
			"x2Scope", 10,
			"x4Scope", 8,
			"x8Scope", 6,
			-- Sights/Lights
			"GunLight", 10,
			"RedDot", 10,
			"TritiumSights", 10,
			-- Holsters
			"HolsterAnkle", 1,
			"HolsterDouble", 10,
			"HolsterShoulder", 4,
			"HolsterSimple", 20,
			"HolsterSimple", 10,
			-- Accessories
			"AmmoStrap_Bullets", 10,
			"AmmoStrap_Shells", 10,
			"Glasses_Shooting", 20,
			-- Misc.
			"ChokeTubeFull", 8,
			"ChokeTubeImproved", 8,
			"RecoilPad", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreAmmunition = {
		isShop = true,
		rolls = 4,
		items = {
			"223Box", 20,
			"223Box", 10,
			"223Carton", 1,
			"308Box", 20,
			"308Box", 10,
			"308Carton", 1,
			"556Box", 20,
			"556Box", 10,
			"556Carton", 1,
			"Bullets38Box", 20,
			"Bullets38Box", 10,
			"Bullets38Carton", 1,
			"Bullets44Box", 20,
			"Bullets44Box", 10,
			"Bullets44Carton", 1,
			"Bullets45Box", 20,
			"Bullets45Box", 10,
			"Bullets45Carton", 1,
			"Bullets9mmBox", 20,
			"Bullets9mmBox", 10,
			"Bullets9mmCarton", 1,
			"ShotgunShellsBox", 20,
			"ShotgunShellsBox", 10,
			"ShotgunShellsCarton", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreBodyArmor = {
		isShop = true,
		rolls = 4,
		items = {
			"Vest_BulletCivilian", 50,
			"Vest_BulletCivilian", 20,
			"Vest_BulletCivilian", 20,
			"Vest_BulletCivilian", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreCases = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_ProtectiveCaseSmall_Pistol1", 20,
			"Bag_RifleCaseCloth", 20,
			"Bag_RifleCaseClothCamo", 20,
			"Bag_RifleCase", 50,
			"Bag_RifleCase", 20,
			"Bag_RifleCaseGreen", 20,
			"PistolCase1", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreCounter = {
		isShop = true,
		rolls = 4,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreDisplayCase = {
		isShop = true,
		rolls = 4,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreKnives = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_Bass", 2,
			"KeyRing_EagleFlag", 2,
			"KeyRing_PineTree", 2,
			"KeyRing_PrayingHands", 2,
			-- Knives
			"FightingKnife", 0.1,
			"Fleshing_Tool", 20,
			"Fleshing_Tool", 10,
			"HandAxe", 20,
			"HandAxe", 10,
			"Handiknife", 4,
			"HuntingKnife", 20,
			"HuntingKnife", 10,
			"KnifeButterfly", 10,
			"KnifePocket", 4,
			"LargeKnife", 8,
			"Multitool", 4,
			"SmallKnife", 10,
			"SwitchKnife", 10,
			-- Misc.
			"Whetstone", 50,
			"Whetstone", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreLiterature = {
		isShop = true,
		rolls = 4,
		items = {
			-- Literature (Generic)
			"Book_MilitaryHistory", 20,
			"Book_MilitaryHistory", 10,
			"Magazine_Crime_New", 10,
			"Magazine_Firearm_New", 20,
			"Magazine_Firearm_New", 10,
			"Magazine_Outdoors_New", 20,
			"Magazine_Outdoors_New", 10,
			"Magazine_Police_New", 10,
			"Paperback_MilitaryHistory", 20,
			"Paperback_MilitaryHistory", 20,
			"Paperback_MilitaryHistory", 10,
			"Paperback_MilitaryHistory", 10,
			-- Literature (Skill Books)
			"BookAiming1", 10,
			"BookAiming2", 8,
			"BookAiming3", 6,
			"BookAiming4", 4,
			"BookAiming5", 2,
			"BookFishing1", 10,
			"BookFishing2", 8,
			"BookFishing3", 6,
			"BookFishing4", 4,
			"BookFishing5", 2,
			"BookForaging1", 10,
			"BookForaging2", 8,
			"BookForaging3", 6,
			"BookForaging4", 4,
			"BookForaging5", 2,
			"BookReloading1", 10,
			"BookReloading2", 8,
			"BookReloading3", 6,
			"BookReloading4", 4,
			"BookReloading5", 2,
			"BookTrapping1", 10,
			"BookTrapping2", 8,
			"BookTrapping3", 6,
			"BookTrapping4", 4,
			"BookTrapping5", 2,
			-- Literature (Recipes)
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"FishingMag1", 2,
			"FishingMag2", 2,
			"HerbalistMag", 2,
			"HuntingMag1", 2,
			"HuntingMag2", 2,
			"HuntingMag3", 2,
			"SmithingMag1", 2,
			"SmithingMag2", 2,
			"SmithingMag3", 2,
			"SmithingMag4", 2,
			"SmithingMag5", 2,
			"SmithingMag6", 2,
			"SmithingMag7", 2,
			"SmithingMag8", 2,
			"SmithingMag9", 2,
			"SmithingMag10", 2,
			"SmithingMag11", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreMagazineRack = {
		isShop = true,
		rolls = 4,
		items = {
			-- Literature (Generic)
			"Magazine_Crime_New", 10,
			"Magazine_Firearm_New", 20,
			"Magazine_Firearm_New", 10,
			"Magazine_Outdoors_New", 20,
			"Magazine_Outdoors_New", 10,
			"Magazine_Police_New", 10,
			-- Literature (Recipes)
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"FishingMag1", 2,
			"FishingMag2", 2,
			"HerbalistMag", 2,
			"HuntingMag1", 2,
			"HuntingMag2", 2,
			"HuntingMag3", 2,
			"SmithingMag1", 2,
			"SmithingMag2", 2,
			"SmithingMag3", 2,
			"SmithingMag4", 2,
			"SmithingMag5", 2,
			"SmithingMag6", 2,
			"SmithingMag7", 2,
			"SmithingMag8", 2,
			"SmithingMag9", 2,
			"SmithingMag10", 2,
			"SmithingMag11", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreMagsAmmo = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_Bass", 2,
			"KeyRing_EagleFlag", 2,
			"KeyRing_PineTree", 2,
			"KeyRing_PrayingHands", 2,
			-- Clips/Magazines
			"44Clip", 20,
			"44Clip", 10,
			"45Clip", 20,
			"45Clip", 10,
			"9mmClip", 50,
			"9mmClip", 20,
			"M14Clip", 20,
			"M14Clip", 10,
			-- Ammo
			"223Box", 20,
			"223Carton", 1,
			"308Box", 20,
			"308Carton", 1,
			"556Box", 20,
			"556Carton", 1,
			"Bullets38Box", 20,
			"Bullets38Carton", 1,
			"Bullets44Box", 20,
			"Bullets44Carton", 1,
			"Bullets45Box", 20,
			"Bullets45Carton", 1,
			"Bullets9mmBox", 20,
			"Bullets9mmCarton", 1,
			"ShotgunShellsBox", 20,
			"ShotgunShellsCarton", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- needed for some corner case stuff
	GunStoreGuns = {
		isShop = true,
		rolls = 2,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_Bass", 2,
			"KeyRing_EagleFlag", 2,
			"KeyRing_PineTree", 2,
			"KeyRing_PrayingHands", 2,
			-- Pistols
			"Pistol", 10,
			"Pistol2", 8,
			"Pistol3", 6,
			"Revolver", 8,
			"Revolver_Long", 6,
			"Revolver_Short", 10,
			-- Rifles/Shotguns
			"AssaultRifle2", 4,
			"DoubleBarrelShotgun", 8,
			"DoubleBarrelShotgun", 8,
			"HuntingRifle", 8,
			"Shotgun", 10,
			"Shotgun", 10,
			"VarmintRifle", 10,
			-- Clips/Magazines
			"44Clip", 8,
			"45Clip", 8,
			"9mmClip", 8,
			"M14Clip", 8,
			-- Accessories
			"AmmoStrap_Bullets", 10,
			"AmmoStrap_Shells", 10,
			"ChokeTubeFull", 6,
			"ChokeTubeImproved", 6,
			"RecoilPad", 6,
			"RecoilPad", 6,
			"RedDot", 6,
			"x2Scope", 8,
			"x4Scope", 6,
			"x8Scope", 4,
			-- Ammo
			"223Box", 10,
			"308Box", 10,
			"Bullets38Box", 10,
			"Bullets44Box", 10,
			"Bullets45Box", 10,
			"Bullets9mmBox", 10,
			"ShotgunShellsBox", 20,
			"ShotgunShellsBox", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStorePistols = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_Bass", 2,
			"KeyRing_EagleFlag", 2,
			"KeyRing_PineTree", 2,
			"KeyRing_PrayingHands", 2,
			-- Pistols
			"Pistol", 50,
			"Pistol2", 20,
			"Pistol3", 10,
			"Revolver", 20,
			"Revolver_Long", 10,
			"Revolver_Short", 50,
			-- Clips/Magazines
			"44Clip", 20,
			"45Clip", 20,
			"9mmClip", 20,
			-- Accessories
			"GunLight", 10,
			"HolsterAnkle", 1,
			"HolsterDouble", 10,
			"HolsterShoulder", 4,
			"HolsterSimple", 10,
			"RedDot", 10,
			"TritiumSights", 10,
			-- Ammo
			"Bullets38Box", 20,
			"Bullets44Box", 20,
			"Bullets45Box", 20,
			"Bullets9mmBox", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreRifles = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_Bass", 2,
			"KeyRing_EagleFlag", 2,
			"KeyRing_PineTree", 2,
			"KeyRing_PrayingHands", 2,
			-- Rifles
			"AssaultRifle2", 10,
			"HuntingRifle", 50,
			"HuntingRifle", 20,
			"VarmintRifle", 20,
			"VarmintRifle", 10,
			-- Clips/Magazines
			"M14Clip", 8,
			-- Accessories
			"AmmoStrap_Bullets", 10,
			"RecoilPad", 6,
			"x2Scope", 8,
			"x4Scope", 6,
			"x8Scope", 4,
			-- Ammo
			"223Box", 20,
			"308Box", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreShelf = {
		isShop = true,
		rolls = 4,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GunStoreShotguns = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys
			"CarKey", 2,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Keyrings (Store)
			"KeyRing_Bass", 2,
			"KeyRing_EagleFlag", 2,
			"KeyRing_PineTree", 2,
			"KeyRing_PrayingHands", 2,
			-- Shotguns
			"DoubleBarrelShotgun", 20,
			"DoubleBarrelShotgun", 10,
			"Shotgun", 50,
			"Shotgun", 20,
			-- Accessories
			"AmmoStrap_Shells", 10,
			"ChokeTubeFull", 6,
			"ChokeTubeImproved", 6,
			"RecoilPad", 6,
			-- Ammo
			"ShotgunShellsBox", 20,
			"ShotgunShellsBox", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GymLaundry = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"BathTowel", 20,
			"BathTowel", 10,
			"BathTowel", 10,
			"Hat_Sweatband", 10,
			"Shorts_LongSport", 2,
			"Shorts_ShortSport", 2,
			"Trousers_Sport", 1,
			"Tshirt_Sport", 1,
			"Tshirt_SportDECAL", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GymLockers = {
		rolls = 4,
		items = {
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"BathTowel", 8,
			"BathTowel", 8,
			"Belt2", 4,
			"Bikini_Pattern01", 0.2,
			"Bikini_TINT", 0.2,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"ElbowPad_Left_Sport", 0.1,
			"GranolaBar", 8,
			"Gum", 10,
			"Handbag", 0.5,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.1,
			"Hat_BucketHat", 0.1,
			"Hat_Sweatband", 8,
			"Headphones", 1,
			"HoodieDOWN_WhiteTINT", 1,
			"Kneepad_Left_Sport", 4,
			"Magazine_Health", 10,
			"Money", 4,
			"Paperback_Diet", 4,
			"Paperback_SelfHelp", 4,
			"Paperback_Sports", 4,
			"Purse", 0.5,
			"Shirt_Baseball_KY", 0.5,
			"Shirt_Baseball_Rangers", 0.5,
			"Shirt_Baseball_Z", 0.5,
			"Shoes_BlueTrainers", 0.2,
			"Shoes_FlipFlop", 1,
			"Shoes_RedTrainers", 0.2,
			"Shoes_Sandals", 1,
			"Shoes_TrainerTINT", 2,
			"Shorts_LongSport", 1,
			"Shorts_ShortSport", 1,
			"Sportsbottle", 10,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"Trousers_Sport", 0.5,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_Sport", 0.5,
			"Tshirt_SportDECAL", 0.5,
			"Vest_DefaultTEXTURE_TINT", 0.5,
			"Whistle", 4,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	GymMats = {
		rolls = 4,
		items = {
			"Mov_GymnMat", 20,
			"Mov_GymnMat", 20,
			"Mov_GymnMat", 10,
			"Mov_GymnMat", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GymSweatbands = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"BathTowel", 10,
			"Hat_Sweatband", 20,
			"Hat_Sweatband", 20,
			"Hat_Sweatband", 10,
			"Hat_Sweatband", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GymTowels = {
		rolls = 4,
		items = {
			"BathTowel", 50,
			"BathTowel", 20,
			"BathTowel", 20,
			"BathTowel", 10,
			"BathTowel", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	GymWeights = {
		rolls = 4,
		items = {
			"BarBell", 8,
			"BathTowel", 20,
			"BathTowel", 10,
			"DumbBell", 20,
			"DumbBell", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Hiker = {
		rolls = 4,
		items = {
			"Bag_ALICEpack", 0.5,
			"Bag_BigHikingBag", 2,
			"Bag_FannyPackFront", 2,
			"Bag_HydrationBackpack", 0.5,
			"Bag_LeatherWaterBag", 1,
			"Bag_NormalHikingBag", 4,
			"Base.LouisvilleMap1", 0.5,
			"Base.LouisvilleMap2", 0.5,
			"Base.LouisvilleMap3", 0.5,
			"Base.LouisvilleMap4", 0.5,
			"Base.LouisvilleMap5", 0.5,
			"Base.LouisvilleMap6", 0.5,
			"Base.LouisvilleMap7", 0.5,
			"Base.LouisvilleMap8", 0.5,
			"Base.LouisvilleMap9", 0.5,
			"Base.MarchRidgeMap", 4,
			"Base.MuldraughMap", 4,
			"Base.RiversideMap", 4,
			"Base.RosewoodMap", 4,
			"Base.WestpointMap", 4,
			"BeefJerky", 8,
			"Candle", 10,
			"Canteen", 10,
			"Cooler", 0.1,
			"FlashLight_AngleHead", 1,
			"Flask", 1,
			"Glasses_Aviators", 2,
			"Glasses_Sun", 4,
			"GranolaBar", 10,
			"HandAxe", 2,
			"Handiknife", 1,
			"HandTorch", 8,
			"Hat_Bandana", 10,
			"Hat_BandanaTINT", 10,
			"Hat_Beany", 10,
			"Hat_BonnieHat", 10,
			"Hat_BonnieHat_CamoGreen", 8,
			"Hat_SummerHat", 8,
			"IceAxe", 1,
			"InsectRepellent", 10,
			"KnifeButterfly", 8,
			"KnifePocket", 1,
			"LargeKnife", 4,
			"Magazine_Outdoors", 10,
			"Matches", 10,
			"Multitool", 0.1,
			"Paperback_Nature", 8,
			"Paperback_Travel", 8,
			"PonchoYellowDOWN", 6,
			"Shirt_CamoGreen", 8,
			"Shirt_Lumberjack", 4,
			"Shirt_Lumberjack_TINT", 4,
			"Shoes_HikingBoots", 10,
			"Shoes_Wellies", 2,
			"Shorts_CamoGreenLong", 8,
			"SleepingBag_BluePlaid_Packed", 2,
			"SleepingBag_Camo_Packed", 1,
			"SleepingBag_Cheap_Blue_Packed", 4,
			"SleepingBag_Cheap_Green2_Packed", 4,
			"SleepingBag_Cheap_Green_Packed", 4,
			"SleepingBag_GreenPlaid_Packed", 2,
			"SleepingBag_Green_Packed", 2,
			"SleepingBag_HighQuality_Brown_Packed", 1,
			"SleepingBag_Spiffo_Packed", 0.05,
			"SleepingBag_RedPlaid_Packed", 2,
			"SmallKnife", 8,
			"Spork", 10,
			"TentBlue_Packed", 0.1,
			"TentBrown_Packed", 0.1,
			"TentGreen_Packed", 0.1,
			"TentYellow_Packed", 0.1,
			"Torch", 4,
			"Trousers_CamoDesert", 6,
			"Tshirt_CamoGreen", 10,
			"WaterBottle", 10,
			"WaterPurificationTablets", 10,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Hobbies = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 0.01,
			"KeyRing_BlueFox", 0.05,
			"KeyRing_Bug", 0.05,
			"KeyRing_EagleFlag", 0.01,
			"KeyRing_EightBall", 0.01,
			"KeyRing_Hotdog", 0.05,
			"KeyRing_Kitty", 0.05,
			"KeyRing_Panther", 0.01,
			"KeyRing_PineTree", 0.01,
			"KeyRing_PrayingHands", 0.01,
			"KeyRing_RainbowStar", 0.05,
			"KeyRing_RubberDuck", 0.05,
			"KeyRing_Sexy", 0.01,
			-- TODO: Sort Me!
			"BluePen", 10,
			"Book_Fantasy", 4,
			"Book_SciFi", 4,
			"BorisBadger", 0.001,
			"Bricktoys", 10,
			"Calculator", 10,
			"CardDeck", 8,
			"ChessBlack", 20,
			"ChessWhite", 20,
			"CigarBox_Gaming", 4,
			"Clitter", 4,
			"ComicBook", 20,
			"ComicBook", 10,
			"Crystal", 1,
			"Cube", 10,
			"Dice", 8,
			"Dice_00", 20,
			"Dice_10", 20,
			"Dice_12", 20,
			"Dice_20", 20,
			"Dice_4", 20,
			"Dice_6", 20,
			"Dice_8", 20,
			"DiceBag", 20,
			"Disc_Retail", 2,
			"Doodle", 20,
			"Doodle", 10,
			"Doll", 10,
			"Eraser", 10,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"Goblet", 1,
			"GraphPaper", 10,
			"GreenPen", 4,
			"JacquesBeaver", 0.001,
			"KnittingMag1", 10,
			"KnittingMag2", 10,
			"Magazine_Gaming", 4,
			"Magazine_Hobby", 4,
			"Magazine_Horror", 4,
			"Magazine_Humor", 4,
			"Magazine_Science", 4,
			"Magazine_Tech", 4,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MoleyMole", 0.001,
			"Mov_DesktopComputer", 1,
			"Mov_PaintingElisa", 4,
			"Mov_PosterDroids", 4,
			"Mov_PosterElement", 4,
			"Mov_PosterOmega", 4,
			"Mov_PosterPaws", 4,
			"OujaBoard", 0.1,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"Paperback_Fantasy", 8,
			"Paperback_SciFi", 8,
			"Pen", 10,
			"Pencil", 10,
			"RadioMag1", 2,
			"RadioMag2", 2,
			"RadioMag3", 2,
			"RedPen", 4,
			"RPGmanual", 20,
			"RPGmanual", 10,
			"RubberSpider", 10,
			"SheetPaper2", 10,
			"SmithingMag1", 1,
			"SmithingMag2", 1,
			"SmithingMag3", 1,
			"SmithingMag4", 1,
			"SmithingMag5", 1,
			"SmithingMag6", 1,
			"SmithingMag7", 1,
			"SmithingMag8", 1,
			"SmithingMag9", 1,
			"SmithingMag10", 1,
			"SmithingMag11", 1,
			"Specimen_Beetles", 1,
			"Specimen_Butterflies", 1,
			"Specimen_Centipedes", 1,
			"Specimen_Insects", 1,
			"Specimen_Minerals", 4,
			"Spiffo", 0.001,
			"TarotCardDeck", 0.1,
			"ToyBear", 10,
			"ToyCar", 10,
			"Twine", 1,
			"VHS_Retail", 1,
			"VideoGame", 4,
			"Yoyo", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Katana", 0.001,
			}
		}
	},

	HolidayStuff = {
		rolls = 4,
		items = {
			"BorisBadger", 0.001,
			"Bricktoys", 10,
			"Candycane", 20,
			"Candycane", 10,
			"CandyMolasses", 20,
			"CandyMolasses", 10,
			"CardDeck", 8,
			"Card_Christmas", 10,
			"Card_Easter", 10,
			"Card_Halloween", 10,
			"Card_Hanukkah", 10,
			"Card_LunarYear", 10,
			"Card_StPatrick", 10,
			"Card_Valentine", 10,
			"ChristmasHanging", 10,
			"ChristmasOrnament_Gold1", 10,
			"ChristmasOrnament_Gold2", 10,
			"ChristmasOrnament_Gold3", 10,
			"ChristmasOrnament_Green1", 10,
			"ChristmasOrnament_Green2", 10,
			"ChristmasOrnament_Green3", 10,
			"ChristmasOrnament_Red1", 10,
			"ChristmasOrnament_Red2", 10,
			"ChristmasOrnament_Red3", 10,
			"ChristmasWreath", 10,
			"Crayons", 10,
			"Cube", 10,
			"Dice", 8,
			"Disc_Retail", 2,
			"Doll", 10,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"Gingerbreadman", 10,
			"Hat_Antlers", 10,
			"Hat_HalloweenMaskDevil", 0.5,
			"Hat_HalloweenMaskMonster", 0.5,
			"Hat_HalloweenMaskPumpkin", 0.5,
			"Hat_HalloweenMaskSkeleton", 0.5,
			"Hat_HalloweenMaskVampire", 0.5,
			"Hat_HalloweenMaskWitch", 0.5,
			"Hat_Pilgrim", 0.01,
			"Hat_Pirate", 0.01,
			"Hat_SantaHat", 10,
			"Hat_SantaHatGreen", 10,
			"Hat_Witch", 0.5,
			"Hat_Wizard", 0.5,
			"JacketLong_Santa", 10,
			"JacketLong_SantaGreen", 10,
			"JacquesBeaver", 0.001,
			"LightBulbRed", 10,
			"LightBulbGreen", 10,
			"LightBulbBlue", 10,
			"LightBulbYellow", 10,
			"LightBulbCyan", 10,
			"LightBulbMagenta", 10,
			"LightBulbOrange", 10 ,
			"LightBulbPurple", 10,
			"LightBulbPink", 10,
			"MoleyMole", 0.001,
			"Mov_FlagUSA", 4,
			"Mov_FlagUSALarge", 1,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"Plushabug", 0.001,
			"RubberSpider", 10,
			"Spiffo", 0.001,
			"ToyBear", 10,
			"ToyCar", 10,
			"Trousers_Santa", 10,
			"Trousers_SantaGreen", 10,
			"VHS_Retail", 1,
			"VideoGame", 4,
			"Yoyo", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	HomeCinemaFilm = {
		rolls = 4,
		items = {
			"VHS_Retail", 50,
			"VHS_Retail", 20,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
			"VHS_Retail", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	HomeCinemaLiterature = {
		rolls = 4,
		items = {
			"Book_Cinema", 10,
			"Magazine_Cinema", 20,
			"Magazine_Cinema", 50,
			"Paperback_Cinema", 10,
			"Paperback_Cinema", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Homesteading = {
		rolls = 4,
		items = {
			"Bag_LeatherWaterBag", 1,
			"Base.BasilBagSeed", 4,
			"Base.BarleyBagSeed", 1,
			"Base.BellPepperBagSeed", 2,
			"Base.BroccoliBagSeed2", 2,
			"Base.CabbageBagSeed2", 2,
			"Base.CarrotBagSeed2", 2,
			"Base.CauliflowerBagSeed", 2,
			"Base.ChamomileBagSeed", 4,
			"Base.ChivesBagSeed", 4,
			"Base.CilantroBagSeed", 4,
			"Base.CornBagSeed", 1,
			"Base.CucumberBagSeed", 2,
			"Base.FlaxBagSeed", 1,
			"Base.GarlicBagSeed", 2,
			"Base.GreenpeasBagSeed", 2,
			"Base.HabaneroBagSeed", 1,
			"Base.HopsBagSeed", 1,
			"Base.JalapenoBagSeed", 2,
			"Base.KaleBagSeed", 2,
			"Base.LeekBagSeed", 4,
			"Base.LemonGrassBagSeed", 4,
			"Base.LettuceBagSeed", 2,
			"Base.MarigoldBagSeed", 4,
			"Base.MintBagSeed", 4,
			"Base.OnionBagSeed", 2,
			"Base.OreganoBagSeed", 4,
			"Base.ParsleyBagSeed", 4,
			"Base.PotatoBagSeed2", 2,
			"Base.PumpkinBagSeed", 2,
			"Base.RedRadishBagSeed2", 2,
			"Base.RosemaryBagSeed", 4,
			"Base.RyeBagSeed", 1,
			"Base.SageBagSeed", 4,
			"Base.SpinachBagSeed", 2,
			"Base.StrewberrieBagSeed2", 2,
			"Base.SugarBeetBagSeed", 1,
			"Base.SunflowerBagSeed", 4,
			"Base.SweetPotatoBagSeed", 2,
			"Base.ThymeBagSeed", 4,
			"Base.TobaccoBagSeed", 1,
			"Base.TomatoBagSeed2", 2,
			"Base.TurnipBagSeed", 2,
			"Base.WatermelonBagSeed", 2,
			"Base.WheatBagSeed", 1,
			"Base.ZucchiniBagSeed", 2,
			"Bag_GardenBasket", 10,
			"BookButchering1", 10,
			"BookButchering2", 8,
			"BookButchering3", 6,
			"BookButchering4", 4,
			"BookButchering5", 2,
			"BookFarming1", 10,
			"BookFarming2", 8,
			"BookFarming3", 6,
			"BookFarming4", 4,
			"BookFarming5", 2,
			"Book_Farming", 8,
			"BookHusbandry1", 10,
			"BookHusbandry2", 8,
			"BookHusbandry3", 6,
			"BookHusbandry4", 4,
			"BookHusbandry5", 2,
			"BoxOfJars", 1,
			"BurlapPiece", 4,
			"CannedBellPepper", 10,
			"CannedBroccoli", 10,
			"CannedCabbage", 10,
			"CannedCarrots", 10,
			"CannedEggplant", 10,
			"CannedLeek", 10,
			"CannedPotato", 10,
			"CannedRedRadish", 10,
			"CannedTomato", 10,
			"CheeseCloth", 20,
			"CheeseCloth", 10,
			"EmptyJar", 20,
			"EmptyJar", 10,
			"FarmingMag1", 2,
			"FarmingMag2", 2,
			"FarmingMag3", 2,
			"FarmingMag4", 2,
			"FarmingMag5", 2,
			"FarmingMag6", 2,
			"FarmingMag7", 2,
			"FarmingMag8", 2,
			"GardenFork", 1,
			"GardenHoe", 2,
			"GardenSaw", 10,
			"GardeningSprayEmpty", 6,
			"GlassmakingMag1", 2,
			"GlassmakingMag2", 2,
			"GlassmakingMag3", 2,
			"HandAxe", 4,
			"HandDrill", 4,
			"HandFork", 2,
			"HandScythe", 2,
			"HandShovel", 10,
			"Handiknife", 8,
			"JarLid", 20,
			"JarLid", 10,
			"KnapsackSprayer", 1,
			"KnittingMag1", 8,
			"KnittingMag2", 8,
			"KnittingNeedles", 10,
			"LargeKnife", 2,
			"LeafRake", 10,
			"Machete", 0.01,
			"Multitool", 0.1,
			"OldDrill", 1,
			"PanForged", 4,
			"PotForged", 1,
			"Rake", 10,
			"RakeHead", 4,
			"Rope", 10,
			"Scythe", 10,
			"SeedBag", 1,
			"Shovel", 4,
			"Shovel2", 4,
			"SlugRepellent", 10,
			"SmallKnife", 4,
			"SmithingMag1", 1,
			"SmithingMag2", 1,
			"SmithingMag3", 1,
			"SmithingMag4", 1,
			"SmithingMag5", 1,
			"SmithingMag6", 1,
			"SmithingMag7", 1,
			"SmithingMag8", 1,
			"SmithingMag9", 1,
			"SmithingMag10", 1,
			"SmithingMag11", 1,
			"Sugar", 10,
			"Toolbox_Gardening", 10,
			"Vinegar2", 10,
			"Vinegar_Jug", 1,
			"WateredCan", 6,
			"Whetstone", 10,
			"WoodAxe", 0.025,
			"WoodenMallet", 4,
			"Yarn", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	HospitalLockers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"Bag_MedicalBag", 0.1,
			"Bag_Satchel_Medical", 0.1,
			"Belt2", 4,
			"BookFirstAid1", 2,
			"BookFirstAid2", 1,
			"BookFirstAid3", 0.5,
			"BookFirstAid4", 0.1,
			"BookFirstAid5", 0.05,
			"Briefcase", 0.2,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flask", 0.1,
			"Glasses_Sun", 1,
			"Gum", 10,
			"Headphones", 1,
			"Handbag", 0.5,
			"Hat_HeadMirrorUP", 1,
			"JacketLong_Doctor", 4,
			"JacketLong_Doctor", 4,
			"Jacket_WhiteTINT", 0.5,
			"Jumper_DiamondPatternTINT", 0.1,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_VNeck", 0.5,
			"Lunchbag", 1,
			"Lunchbox", 1,
			"Lunchbox2", 0.001,
			"Magazine_Health", 10,
			"Money", 4,
			"Paperback_Medical", 8,
			"Purse", 0.5,
			"Shirt_FormalTINT", 0.5,
			"Shirt_FormalWhite", 0.5,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shirt_Scrubs", 8,
			"Shirt_Scrubs", 8,
			"Shoes_Random", 2,
			"Shoes_TrainerTINT", 2,
			"Socks_Ankle", 1,
			"Socks_Ankle_Black", 4,
			"Socks_Ankle_White", 2,
			"Socks_Long", 1,
			"Socks_Long_Black", 4,
			"Socks_Long_White", 2,
			"Sportsbottle", 1,
			"Stethoscope", 2,
			"Suitcase", 0.2,
			"Trousers_Scrubs", 8,
			"Trousers_Scrubs", 8,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Tshirt_WhiteTINT", 2,
			"Vest_DefaultTEXTURE_TINT", 1,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	HospitalMagazineRack = {
		rolls = 4,
		items = {
			"Magazine_Health", 20,
			"Magazine_Health", 20,
			"Magazine_Health", 10,
			"Magazine_Health", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	HospitalRoomCleaning = {
		rolls = 4,
		items = {
			"AlcoholWipes", 4,
			"Bleach", 8,
			"Bucket", 10,
			"CleaningLiquid2", 4,
			"DishCloth", 10,
			"Disinfectant", 2,
			"Gloves_Surgical", 8,
			"Hat_SurgicalMask", 8,
			"Sponge", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	HospitalRoomCounter = {
		rolls = 4,
		items = {
			"AlcoholWipes", 4,
			"Disinfectant", 2,
			"Gloves_Surgical", 8,
			"Hat_SurgicalMask", 8,
			"BookFirstAid1", 2,
			"BookFirstAid2", 1,
			"BookFirstAid3", 0.5,
			"BookFirstAid4", 0.1,
			"BookFirstAid5", 0.05,
			"PenLight", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	HospitalRoomFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Apple", 4,
			"BagelPlain", 1,
			"BagelPoppy", 1,
			"BagelSesame", 1,
			"Banana", 4,
			"CannedFruitBeverage", 6,
			"CinnamonRoll", 1,
			"JuiceBox", 2,
			"JuiceBoxApple", 2,
			"JuiceBoxFruitpunch", 2,
			"JuiceBoxOrange", 2,
			"MilkChocolate_Personalsized", 4,
			"Milk_Personalsized", 6,
			"MuffinFruit", 2,
			"MuffinGeneric", 2,
			"Orange", 4,
			"Paperbag_Jays", 0.05,
			"Paperbag_Spiffos", 0.05,
			"Pop", 0.5,
			"Pop2", 0.5,
			"Pop3", 0.5,
			"PopBottle", 0.1,
			"PopBottleRare", 0.01,
			"WaterBottle", 8,
			"Yoghurt", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	HospitalRoomShelves = {
		rolls = 4,
		items = {
			"AlcoholWipes", 20,
			"AlcoholWipes", 10,
			"Antibiotics", 8,
			"AntibioticsBox", 0.5,
			"Bag_MedicalBag", 0.1,
			"Bag_Satchel_Medical", 0.1,
			"Bandage", 20,
			"Bandage", 10,
			"BandageBox", 1,
			"BookFirstAid1", 2,
			"BookFirstAid2", 1,
			"BookFirstAid3", 0.5,
			"BookFirstAid4", 0.1,
			"BookFirstAid5", 0.05,
			"CottonBalls", 10,
			"CottonBallsBox", 4,
			"Disinfectant", 4,
			"Gloves_Surgical", 10,
			"Hat_SurgicalCap", 10,
			"Hat_SurgicalMask", 10,
			"HospitalGown", 50,
			"HospitalGown", 20,
			"Oxygen_Tank", 4,
			"PenLight", 4,
			"Pills", 20,
			"Pills", 10,
			"PillsAntiDep", 8,
			"PillsBeta", 8,
			"PillsSleepingTablets", 8,
			"ScissorsBluntMedical", 10,
			"TongueDepressor", 10,
			"TongueDepressorBox", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Personal storage for patients staying in private rooms.
	HospitalRoomWardrobe = {
		rolls = 2,
		items = {
			"Belt2", 0.5,
			"Book_Bible", 0.1,
			"Boxers_White", 1,
			"Briefs_White", 1,
			"CDplayer", 1,
			"CigarettePack", 0.1,
			"Cologne", 1,
			"Comb", 4,
			"CordlessPhone", 0.1,
			"Dress_Knees", 0.5,
			"Dress_Long", 0.5,
			"Dress_Normal", 0.5,
			"Handbag", 0.1,
			"Headphones", 1,
			"HoodieDOWN_WhiteTINT", 4,
			"Jacket_Shellsuit_Black", 0.01,
			"Jacket_Shellsuit_Blue", 0.01,
			"Jacket_Shellsuit_Green", 0.01,
			"Jacket_Shellsuit_Pink", 0.01,
			"Jacket_Shellsuit_Teal", 0.01,
			"Jacket_Shellsuit_TINT", 0.05,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"Lipstick", 2,
			"LongCoat_Bathrobe", 8,
			"Magazine", 5,
			"MagazineCrossword", 1,
			"MagazineWordsearch", 1,
			"Magazine_Popular", 5,
			"MakeupEyeshadow", 2,
			"MakeupFoundation", 2,
			"Mirror", 1,
			"Necklace_Crucifix", 0.5,
			"Necklace_SilverCrucifix", 0.1,
			"Paperback", 8,
			"Paperback_Bible", 0.5,
			"Perfume", 1,
			"Purse", 0.1,
			"Shirt_Denim", 0.5,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 1,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shoes_Slippers", 8,
			"Shorts_LongDenim", 0.5,
			"Shorts_ShortDenim", 0.5,
			"Skirt_Knees", 0.5,
			"Skirt_Long", 0.5,
			"Skirt_Normal", 0.5,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Long_Black", 2,
			"Socks_Long_White", 2,
			"Tissue", 4,
			"TissueBox", 0.5,
			"Toothbrush", 10,
			"TrousersMesh_DenimLight", 1,
			"Trousers_DefaultTEXTURE", 1,
			"Trousers_DefaultTEXTURE_TINT", 1,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Shellsuit_Black", 0.01,
			"Trousers_Shellsuit_Blue", 0.01,
			"Trousers_Shellsuit_Green", 0.01,
			"Trousers_Shellsuit_Pink", 0.01,
			"Trousers_Shellsuit_Teal", 0.01,
			"Trousers_Shellsuit_TINT", 0.05,
			"Trousers_WhiteTINT", 1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"TVMagazine", 4,
			"Underpants_Black", 1,
			"Underpants_White", 1,
			"Vest_DefaultTEXTURE", 1,
			"Vest_DefaultTEXTURE_TINT", 1,
			"Wallet", 2,
			"WristWatch_Left_Expensive", 0.01,
			"WristWatch_Left_ClassicBlack", 0.01,
			"WristWatch_Left_ClassicBrown", 0.01,
			"WristWatch_Left_ClassicGold", 0.01,
			"WristWatch_Left_DigitalBlack", 0.01,
			"WristWatch_Left_DigitalDress", 0.01,
			"WristWatch_Left_DigitalRed", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},

	HotdogStandDrinks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Apron_White", 8,
			"BastingBrush", 10,
			"BunsHotdog", 10,
			"Cashbox", 1,
			"CuttingBoardPlastic", 10,
			"Hat_FastFood", 4,
			"BreadKnife", 6,
			"KitchenTongs", 10,
			"Pop", 20,
			"Pop", 10,
			"Pop2", 20,
			"Pop2", 10,
			"Pop3", 20,
			"Pop3", 10,
			"PopBottle", 4,
			"PopBottleRare", 0.1,
			"WaterBottle", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	HotdogStandToppings = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Apron_White", 8,
			"BastingBrush", 10,
			"BBQSauce", 8,
			"BreadKnife", 6,
			"BunsHotdog", 10,
			"Cabbage", 4,
			"Cashbox", 1,
			"CuttingBoardPlastic", 10,
			"Dip_Salsa", 8,
			"Hat_FastFood", 4,
			"Ketchup", 8,
			"KnifeParing", 6,
			"KitchenTongs", 10,
			"Mustard", 8,
			"Onion", 10,
			"Processedcheese", 6,
			"SeasoningSalt", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Hunter = {
		rolls = 4,
		items = {
			"223Box", 10,
			"308Box", 10,
			"Bag_AmmoBox_Hunting", 1,
			"Bag_LeatherWaterBag", 0.1,
			"Bag_RifleCaseCloth", 2,
			"Bag_RifleCaseCloth2", 1,
			"Bag_ShotgunCaseCloth", 2,
			"Bag_ShotgunCaseCloth2", 2,
			"BookTracking1", 6,
			"BookTracking2", 4,
			"BookTracking3", 2,
			"BookTracking4", 1,
			"BookTracking5", 0.5,
			"BookTrapping1", 6,
			"BookTrapping2", 4,
			"BookTrapping3", 2,
			"BookTrapping4", 1,
			"BookTrapping5", 0.5,
			"Bullets44Box", 10,
			"Bullets45Box", 10,
			"Canteen", 10,
			"DappleDeerHide", 1,
			"DeerHide", 1,
			"DoubleBarrelShotgun", 4,
			"Dungarees_HuntingCamo", 1,
			"FlashLight_AngleHead", 1,
			"Gloves_HuntingCamo", 1,
			"HandAxe", 2,
			"Handiknife", 1,
			"Hat_BaseballCap_HuntingCamo", 10,
			"Hat_BonnieHat", 10,
			"Hat_BonnieHat_CamoGreen", 8,
			"HerbalistMag", 2,
			"Hoodie_HuntingCamo_DOWN", 10,
			"HuntingKnife", 6,
			"HuntingMag1", 2,
			"HuntingMag2", 2,
			"HuntingMag3", 2,
			"HuntingRifle", 2,
			"Jacket_HuntingCamo", 6,
			"Jacket_Padded_HuntingCamo", 1,
			"KnifeButterfly", 8,
			"KnifePocket", 1,
			"LargeKnife", 4,
			"LongJohns", 4,
			"LongJohns_Bottoms", 4,
			"Magazine_Firearm", 10,
			"Magazine_Outdoors", 10,
			"Mov_HuntingTrophy", 1,
			"Multitool", 0.1,
			"PanForged", 4,
			"Paperback_MilitaryHistory", 4,
			"Paperback_Nature", 8,
			"PonchoGreenDOWN", 6,
			"PotForged", 1,
			"RifleCase1", 2,
			"RifleCase2", 1,
			"Shirt_CamoGreen", 8,
			"Shirt_Lumberjack", 4,
			"Shirt_Lumberjack_TINT", 4,
			"Shoes_HikingBoots", 4,
			"Shoes_Wellies", 1,
			"Shorts_CamoGreenLong", 8,
			"Shotgun", 4,
			"ShotgunCase1", 2,
			"ShotgunCase2", 2,
			"ShotgunShellsBox", 10,
			"SmallKnife", 8,
			"Trousers_HuntingCamo", 6,
			"Trousers_Padded_HuntingCamo", 1,
			"Tshirt_HuntingCamo", 10,
			"Tshirt_LongSleeve_HuntingCamo", 10,
			"VarmintRifle", 4,
			"Vest_Hunting_Camo", 6,
			"Vest_Hunting_CamoGreen", 6,
			"Vest_Hunting_Grey", 2,
			"Vest_Hunting_Orange", 6,
			"Whetstone", 10,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	HuntingLockers = {
		rolls = 4,
		items = {
			"223Box", 10,
			"308Box", 10,
			"AmmoStrap_Bullets", 4,
			"AmmoStrap_Shells", 4,
			"ArmorMag6", 0.001,
			"Bag_ALICEpack", 0.01,
			"Bag_AmmoBox_Hunting", 1,
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_HydrationBackpack", 0.01,
			"Bag_LeatherWaterBag", 1,
			"Bag_NormalHikingBag", 0.1,
			"Bag_RifleCaseCloth", 2,
			"Bag_RifleCaseCloth2", 1,
			"Bag_ShotgunCaseCloth", 2,
			"Bag_ShotgunCaseCloth2", 2,
			"BeefJerky", 10,
			"BookAiming1", 1,
			"BookAiming2", 0.8,
			"BookAiming3", 0.6,
			"BookAiming4", 0.4,
			"BookAiming5", 0.2,
			"BookReloading1", 1,
			"BookReloading2", 0.8,
			"BookReloading3", 0.6,
			"BookReloading4", 0.4,
			"BookReloading5", 0.2,
			"BookTracking1", 2,
			"BookTracking2", 1,
			"BookTracking3", 0.5,
			"BookTracking4", 0.1,
			"BookTracking5", 0.05,
			"BookTrapping1", 2,
			"BookTrapping2", 1,
			"BookTrapping3", 0.5,
			"BookTrapping4", 0.1,
			"BookTrapping5", 0.05,
			"Bullets44Box", 10,
			"Bullets45Box", 10,
			"Canteen", 10,
			"CanteenCowboy", 4,
			"DoubleBarrelShotgun", 4,
			"Dungarees_HuntingCamo", 1,
			"FirstAidKit_Camping", 4,
			"FlashLight_AngleHead", 1,
			"Flask", 1,
			"Glasses_Aviators", 1,
			"Glasses_Shooting", 8,
			"Glasses_Sun", 2,
			"Gloves_HuntingCamo", 1,
			"GranolaBar", 8,
			"Gum", 10,
			"HandAxe", 2,
			"Handiknife", 1,
			"Hat_BaseballCap_HuntingCamo", 10,
			"Hat_Beany", 10,
			"Hat_BonnieHat", 10,
			"Hat_BonnieHat_CamoGreen", 8,
			"Hoodie_HuntingCamo_DOWN", 10,
			"HuntingKnife", 8,
			"HuntingRifle", 2,
			"InsectRepellent", 10,
			"Jacket_HuntingCamo", 6,
			"Jacket_Padded_HuntingCamo", 1,
			"KnifeButterfly", 8,
			"KnifePocket", 1,
			"LargeKnife", 4,
			"Magazine_Firearm", 4,
			"Magazine_Outdoors", 8,
			"Mov_Cot", 0.1,
			"Multitool", 0.1,
			"Paperback_MilitaryHistory", 4,
			"Paperback_Nature", 8,
			"PonchoGreenDOWN", 6,
			"Revolver", 6,
			"Revolver_Long", 4,
			"RifleCase1", 2,
			"RifleCase2", 1,
			"ShemaghScarf_Green", 0.01,
			"Shirt_CamoGreen", 8,
			"Shirt_Lumberjack", 4,
			"Shirt_Lumberjack_TINT", 4,
			"Shoes_HikingBoots", 4,
			"Shoes_Wellies", 1,
			"Shorts_CamoGreenLong", 8,
			"Shotgun", 4,
			"ShotgunCase1", 2,
			"ShotgunCase2", 2,
			"ShotgunShellsBox", 10,
			"SleepingBag_Camo_Packed", 4,
			"SmallKnife", 8,
			"TobaccoChewing", 1,
			"Trousers_CamoGreen", 6,
			"Trousers_HuntingCamo", 6,
			"Trousers_Padded_HuntingCamo", 1,
			"Tshirt_CamoGreen", 10,
			"Tshirt_HuntingCamo", 10,
			"Tshirt_LongSleeve_HuntingCamo", 10,
			"VarmintRifle", 4,
			"Vest_Hunting_Camo", 6,
			"Vest_Hunting_CamoGreen", 6,
			"Vest_Hunting_Grey", 2,
			"Vest_Hunting_Orange", 6,
			"WaterPurificationTablets", 1,
			"Whetstone", 10,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	ImprovisedCrafts = {
		rolls = 4,
		items = {
			"BlowerFan", 1,
			"CircularSawblade", 4,
			"CopperScrap", 10,
			"DuctTape", 4,
			"ElectronicsScrap", 10,
			"FiberglassTape", 1,
			"Epoxy", 1,
			"Glue", 10,
			"Magazine_Hobby", 10,
			"MetalPipe", 20,
			"MetalPipe", 10,
			"Pipe", 20,
			"Pipe", 10,
			"Saw", 8,
			"Scotchtape", 10,
			"Screwdriver", 10,
			"SharpedStone", 10,
			"Twine", 10,
			"WoodenStick2", 20,
			"WoodenStick2", 10,
			"Woodglue", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ItalianKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"Flour2", 8,
			"OilOlive", 8,
			"Pasta", 20,
			"Pasta", 10,
			"Yeast", 8,
			-- Utensils
			"BreadKnife", 8,
			"CheeseGrater", 10,
			"KitchenTongs", 10,
			"Ladle", 10,
			"PizzaCutter", 8,
			"RollingPin", 8,
			"Strainer", 10,
			"Whisk", 10,
			-- Misc.
			"Aluminum", 8,
			"DishCloth", 10,
			"OvenMitt", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ItalianKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Chicken", 4,
			"MincedMeat", 8,
			"PorkChop", 4,
			"Salami", 8,
			"Sausage", 8,
			"Steak", 2,
			-- Spices
			"Pepper", 8,
			"PowderedGarlic", 8,
			"PowderedOnion", 8,
			"Salt", 8,
			"Seasoning_Basil", 6,
			"Seasoning_Oregano", 6,
			"Seasoning_Rosemary", 6,
			"Seasoning_Sage", 6,
			"Seasoning_Thyme", 6,
			-- Utensils
			"Fleshing_Tool", 10,
			"KitchenKnife", 6,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			"WoodenMallet", 4,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Twine", 10,
			"Whetstone", 10,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
			-- Clothing
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ItalianKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Chicken", 4,
			"Ham", 2,
			"MincedMeat", 8,
			"Salami", 8,
			"Sausage", 8,
			"Steak", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ItalianKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Fruit
			"Apple", 2,
			"Cherry", 4,
			"Grapes", 2,
			"Lemon", 2,
			"Lime", 2,
			"Orange", 2,
			"Peach", 2,
			"Pear", 2,
			"Strewberrie", 4,
			-- Vegetables
			"Cabbage", 2,
			"Cauliflower", 2,
			"Corn", 2,
			"Cucumber", 2,
			"Eggplant", 2,
			"Garlic", 4,
			"Lettuce", 2,
			"Onion", 4,
			"Tomato", 4,
			"Zucchini", 2,
			-- Misc.
			"Butter", 8,
			"Cheese", 4,
			"EggCarton", 2,
			"Milk", 8,
			-- Meat
			"Chicken", 4,
			"Ham", 2,
			"MincedMeat", 8,
			"Salami", 8,
			"Sausage", 8,
			"Steak", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ItalianKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"CannedTomato", 20,
			"CannedTomato", 20,
			"CannedTomato", 10,
			"CannedTomato", 10,
			"OilOlive", 8,
			-- Spices
			"Pepper", 4,
			"PowderedGarlic", 4,
			"PowderedOnion", 4,
			"Salt", 4,
			"Seasoning_Basil", 2,
			"Seasoning_Oregano", 2,
			"Seasoning_Rosemary", 2,
			"Seasoning_Sage", 2,
			"Seasoning_Thyme", 2,
			-- Utensils
			"Ladle", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JackiesDesk = {
		rolls = 4,
		items = {
			-- Literature
			"Paperwork", 50,
			"Paperwork", 20,
			-- Electronics
			"Battery", 20,
			"BatteryBox", 4,
			"Microphone", 8,
			"RadioReceiver", 8,
			"RadioTransmitter", 8,
			-- Misc.
			"CigarettePack", 8,
			"MakeupCase_Professional", 1,
			"MakeupEyeshadow", 8,
			"MakeupFoundation", 8,
			"Pills", 20,
			"PillsVitamins", 10,
			-- Trash
			"TinCanEmpty", 50,
			"TinCanEmpty", 20,
			"WaterBottleEmpty", 20,
			"Tissue", 20,
			-- Special
			"FlaskEmpty", 1,
		},
		junk = ClutterTables.DeskJunk,
	},

	JanitorChemicals = {
		rolls = 4,
		items = {
			"Bleach", 20,
			"Bleach", 20,
			"Bleach", 10,
			"Bleach", 10,
			"CleaningLiquid2", 20,
			"CleaningLiquid2", 10,
			"RatPoison", 20,
			"RatPoison", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JanitorCleaning = {
		rolls = 4,
		items = {
			"Bleach", 20,
			"Bleach", 10,
			"BookCarpentry1", 2,
			"BookElectrician1", 2,
			"Broom", 10,
			"Bucket", 10,
			"CleaningLiquid2", 10,
			"Garbagebag_box", 8,
			"Gloves_Dish", 10,
			"Mop", 10,
			"RatPoison", 1,
			"RippedSheets", 20,
			"RippedSheets", 10,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			"Sponge", 10,
			"Tarp", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JanitorMisc = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- TODO: Sort Me!
			"BookMaintenance1", 4,
			"BookMaintenance2", 2,
			"BookMaintenance3", 1,
			"BookMaintenance4", 0.5,
			"BookMaintenance5", 0.1,
			"BeerCan", 0.1,
			"BottleOpener", 0.1,
			"Brochure", 2,
			"Flask", 0.1,
			"Flier", 2,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Cigar", 0.1,
			"CigarettePack", 4,
			"CigaretteRollingPapers", 1,
			"Cigarillo", 8,
			"ComicBook", 4,
			"ElbowPad_Left_Workman", 1,
			"Flask", 0.1,
			"Garbagebag_box", 4,
			"Glasses_SafetyGoggles", 8,
			"Gloves_Dish", 10,
			"Gum", 10,
			"HottieZ", 1,
			"Kneepad_Left_Workman", 4,
			"KnifePocket", 0.5,
			"LighterDisposable", 4,
			"Lunchbag", 10,
			"Lunchbox", 10,
			"Lunchbox2", 0.001,
			"Magazine_Hobby", 8,
			"Magazine_Humor", 8,
			"Magazine_Sports", 8,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"Matches", 8,
			"Mov_BeigeRotaryPhone", 0.01,
			"Mov_BlackModernPhone", 0.001,
			"Mov_BlackRotaryPhone", 0.01,
			"Mov_RedRotaryPhone", 0.01,
			"Mov_WhiteModernPhone", 0.001,
			"Mov_WhiteRotaryPhone", 0.01,
			"Mugl", 4,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperback_Poor", 8,
			"RatPoison", 1,
			"RippedSheets", 20,
			"RippedSheets", 10,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			"TissueBox", 4,
			"TobaccoChewing", 10,
			"TobaccoLoose", 1,
			"TVMagazine", 4,
			"Twine", 10,
			"WalkieTalkie2", 2,
			"Whiskey", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JanitorTools = {
		rolls = 4,
		items = {
			"Bag_JanitorToolbox", 2,
			"CircularSawblade", 4,
			"CombinationPadlock", 10,
			"Crowbar", 4,
			"DuctTape", 4,
			"Epoxy", 1,
			"FiberglassTape", 1,
			"File", 1,
			"Funnel", 10,
			"Garbagebag_box", 8,
			"Glasses_SafetyGoggles", 8,
			"Hammer", 8,
			"HandDrill", 4,
			"Handle", 4,
			"KnifePocket", 0.5,
			"LightBulb", 20,
			"LightBulb", 10,
			"LongHandle", 2,
			"LongStick", 2,
			"MeasuringTape", 10,
			"MetalworkingChisel", 1,
			"MetalworkingPliers", 0.1,
			"MetalworkingPunch", 1,
			"NailsBox", 10,
			"NutsBolts", 8,
			"Padlock", 10,
			"PipeWrench", 6,
			"Pliers", 8,
			"Plunger", 10,
			"PowerBar", 10,
			"RippedSheets", 10,
			"RippedSheetsDirty", 10,
			"RubberHose", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"SheetMetalSnips", 4,
			"SmallFileSet", 1,
			"SmallHandle", 4,
			"SmallPunchSet", 1,
			"SmallSaw", 1,
			"SteelWool", 10,
			"Tarp", 10,
			"TrapMouse", 10,
			"Twine", 10,
			"ViseGrips", 4,
			"Whetstone", 10,
			"Woodglue", 2,
			"WoodenStick2", 4,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JaysDiningCounter = {
		rolls = 4,
		items = {
			"FountainCup", 20,
			"FountainCup", 10,
			"MenuCard", 20,
			"MenuCard", 10,
			"Paperbag_Jays", 20,
			"Paperbag_Jays", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			"PlasticTray", 20,
			"PlasticTray", 10,
			"Straw2", 20,
			"Straw2", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JaysKitchenBags = {
		isShop = true,
		rolls = 4,
		items = {
			"MenuCard", 20,
			"MenuCard", 10,
			"Paperbag_Jays", 50,
			"Paperbag_Jays", 20,
			"Paperbag_Jays", 20,
			"Paperbag_Jays", 10,
			"Paperbag_Jays", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JaysKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"BakingSoda", 4,
			"Cornflour2", 20,
			"Cornflour2", 10,
			"OilVegetable", 4,
			"Yeast", 4,
			-- Utensils
			"BreadKnife", 8,
			"KitchenTongs", 10,
			"Ladle", 10,
			"RollingPin", 8,
			"Strainer", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
			-- Misc.
			"Aluminum", 8,
			"DishCloth", 10,
			"OvenMitt", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JaysKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Chicken", 20,
			"Chicken", 10,
			-- Spices
			"Pepper", 4,
			"Salt", 4,
			-- Utensils
			"KitchenKnife", 6,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			"WoodenMallet", 4,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Whetstone", 10,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JaysKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Chicken", 20,
			"Chicken", 10,
			"Frozen_ChickenNuggets", 20,
			"Frozen_ChickenNuggets", 10,
			-- Fries
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JaysKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Chicken", 20,
			"Chicken", 20,
			"Chicken", 10,
			"Chicken", 10,
			-- Ingredients
			"EggCarton", 8,
			"Milk", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JaysKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Condiments
			"GravyMix", 20,
			"GravyMix", 10,
			"Hotsauce", 8,
			"Vinegar2", 8,
			"Vinegar_Jug", 1,
			-- Utensils
			"Ladle", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JerkyFactoryCrate = {
		isShop = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BeefJerky", 20,
			"BeefJerky", 20,
			"BeefJerky", 10,
			"BeefJerky", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JerkyFactoryMeat = {
		isShop = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Beef", 20,
			"Beef", 20,
			"Beef", 10,
			"Beef", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JerkyFactorySpices = {
		isShop = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Hotsauce", 8,
			"Salt", 20,
			"Salt", 10,
			"Soysauce", 8,
			"SugarBrown", 20,
			"SugarBrown", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JerkyFactoryTools = {
		isShop = true,
		rolls = 4,
		items = {
			-- Utensils
			"Fleshing_Tool", 10,
			"HandAxe", 4,
			"KitchenKnife", 10,
			"KnifeFillet", 8,
			"LargeKnife", 4,
			"MeatCleaver", 8,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Whetstone", 10,
			-- Clothing
			"Chainmail_Hand_L", 4,
			"Chainmail_Hand_R", 0.5,
			-- Literature (Skill Books)
			"BookButchering1", 4,
			"BookButchering2", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	JewelerTools = {
		rolls = 4,
		items = {
			-- Jewellery
			"BellyButton_DangleGold", 1,
			"BellyButton_RingGold", 1,
			"BellyButton_StudGold", 1,
			"Bracelet_BangleRightGold", 4,
			"Bracelet_ChainRightGold", 4,
			"Earring_LoopLrg_Gold", 4,
			"Earring_LoopMed_Gold", 4,
			"Earring_LoopSmall_Gold_Both", 4,
			"Earring_LoopSmall_Gold_Top", 4,
			"Earring_Stud_Gold", 4,
			"NecklaceLong_Gold", 4,
			"Necklace_Gold", 4,
			"NoseRing_Gold", 2,
			"NoseStud_Gold", 2,
			"Ring_Left_RingFinger_Gold", 20,
			"Ring_Left_RingFinger_Gold", 10,
			-- Gems
			"Diamond", 8,
			"Emerald", 8,
			"GemBag", 1,
			"Ruby", 8,
			"Sapphire", 8,
			-- Misc.
			"Pocketwatch", 4,
			-- Materials
			"GoldSheet", 1,
			"SilverSheet", 2,
			"SmallGoldBar", 10,
			"SmallSilverBar", 10,
			-- Tools
			"BenchAnvil", 1,
			"CeramicCrucible", 8,
			"DrawPlate", 20,
			"DrawPlate", 10,
			"Loupe", 10,
			"MetalworkingPliers", 8,
			"Pliers", 8,
			"Tongs", 8,
			-- Accessories
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 10,
			"Gloves_Surgical", 10,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Kneepad_Left_Workman", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"GoldScrap", 4,
				"SilverScrap", 8,
			}
		}
	},

	JewelryGems = {
		isShop = true,
		rolls = 4,
		items = {
			"Diamond", 1,
			"Earring_Dangly_Diamond", 4,
			"Earring_Dangly_Emerald", 6,
			"Earring_Dangly_Pearl", 8,
			"Earring_Dangly_Ruby", 6,
			"Earring_Dangly_Sapphire", 6,
			"Earring_Stone_Emerald", 6,
			"Earring_Stone_Ruby", 6,
			"Earring_Stone_Sapphire", 6,
			"Emerald", 1,
			"GemBag", 0.1,
			"Loupe", 4,
			"Ruby", 1,
			"Sapphire", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JewelryGold = {
		isShop = true,
		rolls = 4,
		items = {
			"Earring_LoopLrg_Gold", 10,
			"Earring_LoopMed_Gold", 10,
			"Earring_LoopSmall_Gold_Both", 10,
			"Earring_LoopSmall_Gold_Top", 10,
			"Earring_Stud_Gold", 10,
			"Loupe", 4,
			"NecklaceLong_Gold", 10,
			"NecklaceLong_GoldDiamond", 4,
			"Necklace_Gold", 10,
			"Necklace_GoldDiamond", 4,
			"Necklace_GoldRuby", 6,
			"NoseRing_Gold", 10,
			"NoseStud_Gold", 10,
			"Ring_Left_RingFinger_Gold", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JewelryNavelRings = {
		isShop = true,
		rolls = 4,
		items = {
			"BellyButton_DangleGold", 6,
			"BellyButton_DangleGoldRuby", 4,
			"BellyButton_DangleSilver", 8,
			"BellyButton_DangleSilverDiamond", 4,
			"BellyButton_RingGold", 6,
			"BellyButton_RingGoldDiamond", 4,
			"BellyButton_RingGoldRuby", 4,
			"BellyButton_RingSilver", 8,
			"BellyButton_RingSilverAmethyst", 6,
			"BellyButton_RingSilverDiamond", 4,
			"BellyButton_RingSilverRuby", 4,
			"BellyButton_StudGold", 6,
			"BellyButton_StudGoldDiamond", 4,
			"BellyButton_StudSilver", 8,
			"BellyButton_StudSilverDiamond", 4,
			"Loupe", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JewelryOthers = {
		isShop = true,
		rolls = 4,
		items = {
			"Earring_Dangly_Pearl", 8,
			"Earring_Pearl", 8,
			"Loupe", 4,
			"Necklace_Choker", 6,
			"Necklace_Choker_Amber", 6,
			"Necklace_Choker_Diamond", 6,
			"Necklace_Choker_Sapphire", 6,
			"Necklace_Pearl", 8,
			"Necklace_YingYang", 6,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JewelrySilver = {
		isShop = true,
		rolls = 4,
		items = {
			"Earring_LoopLrg_Silver", 10,
			"Earring_LoopMed_Silver", 10,
			"Earring_LoopSmall_Silver_Both", 10,
			"Earring_LoopSmall_Silver_Top", 10,
			"Earring_Stud_Silver", 10,
			"Loupe", 4,
			"NecklaceLong_Silver", 10,
			"NecklaceLong_SilverDiamond", 4,
			"NecklaceLong_SilverEmerald", 6,
			"NecklaceLong_SilverSapphire", 6,
			"Necklace_Silver", 10,
			"Necklace_SilverCrucifix", 10,
			"Necklace_SilverDiamond", 4,
			"Necklace_SilverSapphire", 6,
			"NoseRing_Silver", 10,
			"Ring_Left_RingFinger_Silver", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JewelryWeddingRings = {
		isShop = true,
		rolls = 4,
		items = {
			"Loupe", 4,
			"Ring_Left_RingFinger_Gold", 10,
			"Ring_Left_RingFinger_Gold", 10,
			"Ring_Left_RingFinger_Gold", 10,
			"Ring_Left_RingFinger_GoldDiamond", 8,
			"Ring_Left_RingFinger_GoldRuby", 8,
			"Ring_Left_RingFinger_Silver", 10,
			"Ring_Left_RingFinger_Silver", 10,
			"Ring_Left_RingFinger_Silver", 10,
			"Ring_Left_RingFinger_SilverDiamond", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JewelryWrist = {
		isShop = true,
		rolls = 4,
		items = {
			"Bracelet_ChainRightSilver", 10,
			"Bracelet_BangleRightSilver", 10,
			"Bracelet_ChainRightGold", 6,
			"Bracelet_BangleRightGold", 6,
			"Pocketwatch", 4,
			"WristWatch_Left_DigitalDress", 6,
			"WristWatch_Left_DigitalRed", 10,
			"WristWatch_Left_DigitalBlack", 10,
			"WristWatch_Left_ClassicGold", 8,
			"WristWatch_Left_ClassicBrown", 10,
			"WristWatch_Left_ClassicBlack", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JewelryStorageAll = {
		isShop = true,
		rolls = 4,
		items = {
			"Bracelet_BangleRightGold", 4,
			"Bracelet_BangleRightSilver", 8,
			"Bracelet_ChainRightGold", 4,
			"Bracelet_ChainRightSilver", 8,
			"Earring_Dangly_Diamond", 1,
			"Earring_Dangly_Emerald", 4,
			"Earring_Dangly_Pearl", 6,
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
			"Earring_Stone_Emerald", 4,
			"Earring_Stone_Ruby", 4,
			"Earring_Stone_Sapphire", 4,
			"Earring_Stud_Gold", 8,
			"Earring_Stud_Silver", 8,
			"GemBag", 10,
			"Loupe", 4,
			"NecklaceLong_Gold", 8,
			"NecklaceLong_GoldDiamond", 1,
			"NecklaceLong_Silver", 8,
			"NecklaceLong_SilverDiamond", 4,
			"NecklaceLong_SilverEmerald", 4,
			"NecklaceLong_SilverSapphire", 4,
			"Necklace_Gold", 8,
			"Necklace_GoldDiamond", 1,
			"Necklace_GoldRuby", 4,
			"Necklace_Silver", 8,
			"Necklace_SilverCrucifix", 8,
			"Necklace_SilverDiamond", 4,
			"Necklace_SilverSapphire", 4,
			"NoseRing_Gold", 8,
			"NoseRing_Silver", 8,
			"NoseStud_Gold", 8,
			"Pocketwatch", 4,
			"Ring_Left_RingFinger_Gold", 8,
			"Ring_Left_RingFinger_Gold", 8,
			"Ring_Left_RingFinger_Gold", 8,
			"Ring_Left_RingFinger_Gold", 8,
			"Ring_Left_RingFinger_GoldDiamond", 6,
			"Ring_Left_RingFinger_GoldRuby", 6,
			"Ring_Left_RingFinger_Silver", 8,
			"Ring_Left_RingFinger_Silver", 8,
			"Ring_Left_RingFinger_Silver", 8,
			"Ring_Left_RingFinger_Silver", 8,
			"Ring_Left_RingFinger_SilverDiamond", 6,
			"SmallGoldBar", 20,
			"SmallGoldBar", 10,
			"SmallSilverBar", 20,
			"SmallSilverBar", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"GoldScrap", 4,
				"SilverScrap", 8,
			}
		}
	},

	JockeyLockers = {
		rolls = 4,
		items = {
			"AthleticCup", 4,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_MoneyBag", 0.001,
			"Bag_Satchel", 0.2,
			"BathTowel", 8,
			"Belt2", 4,
			"Book_Rich", 2,
			"Briefcase", 0.2,
			"Briefcase_Money", 0.001,
			"CDplayer", 2,
			"CigarettePack", 2,
			"CordlessPhone", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flask", 4,
			"Gloves_LeatherGloves", 4,
			"Gum", 10,
			"Handbag", 0.1,
			"Hat_JockeyHelmet01", 2,
			"Hat_JockeyHelmet02", 2,
			"Hat_JockeyHelmet03", 2,
			"Hat_JockeyHelmet04", 2,
			"Hat_JockeyHelmet05", 2,
			"Hat_JockeyHelmet06", 2,
			"Hat_PeakedCapYacht", 0.1,
			"Headphones", 1,
			"HoodieDOWN_WhiteTINT", 1,
			"Magazine", 4,
			"Magazine_Business", 4,
			"Magazine_Rich", 8,
			"Medal_Bronze", 1,
			"Medal_Silver", 0.5,
			"Medal_Gold", 0.1,
			"Money", 20,
			"Money", 10,
			"MoneyBundle", 1,
			"Paperback_Rich", 8,
			"Paperback_Sports", 4,
			"Pills", 8,
			"Purse", 0.1,
			"Shirt_Jockey01", 4,
			"Shirt_Jockey02", 4,
			"Shirt_Jockey03", 4,
			"Shirt_Jockey05", 4,
			"Shirt_Jockey06", 4,
			"Shoes_RidingBoots", 10,
			"Shoes_TrainerTINT", 2,
			"Sportsbottle", 1,
			"StockCertificate", 10,
			"Suitcase", 0.5,
			"Trousers_WhiteTEXTURE", 10,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Vest_DefaultTEXTURE_TINT", 1,
			"Whiskey", 4,
			"Whistle", 2,
			"WristWatch_Left_Expensive", 0.01,
			"WristWatch_Left_ClassicGold", 0.01,
			"WristWatch_Left_DigitalDress", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	JudgeMattHassCounter = {
		rolls = 4,
		items = {
			-- Literature
			"Book_Legal", 4,
			"BookFancy_Legal", 1,
			"Magazine_Firearm", 10,
			"Magazine_Golf", 10,
			"Paperwork", 50,
			"Paperwork", 20,
			-- Cosmetic
			"Cologne", 20,
			"Comb", 10,
			"MakeupCase_Professional", 1,
			"Mirror", 20,
		},
		junk = {
			rolls = 1,
			items = {
				-- Firearms
				"Revolver_Long", 200,
				-- 	Literature
				"BookFancy_Bible", 10,
			}
		}
	},

	JunkBin = {
		rolls = 4,
		items = {
			"BarbedWire", 2,
			"CopperScrap", 4,
			"ElectricWire", 10,
			"ElectronicsScrap", 10,
			"MetalPipe", 6,
			"Pipe", 6,
			"Receipt", 10,
			"ScrapMetal", 10,
			"ScratchTicket", 4,
			"SheetMetal", 8,
			"SmallSheetMetal", 8,
			"Twine", 10,
			"UnusableMetal", 10,
			"UnusableWood", 10,
			"Wire", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	JunkHoard = {
		isWorn = true,
		rolls = 4,
		items = {
			"Bag_TrashBag", 20,
			"Bag_TrashBag", 10,
			"Buckle", 10,
			"Book", 10,
			"Brochure", 2,
			"BusinessCard", 1,
			"ButterKnife_Gold", 0.01,
			"ButterKnife_Silver", 0.1,
			"Catalog", 4,
			"ComicBook", 10,
			"Card_Birthday", 1,
			"Card_Christmas", 1,
			"Card_Easter", 1,
			"Card_Halloween", 1,
			"Card_Hanukkah", 1,
			"Card_LunarYear", 1,
			"Card_StPatrick", 1,
			"Card_Sympathy", 1,
			"Card_Valentine", 1,
			"CircularSawblade", 1,
			"CopperScrap", 1,
			"DeadMouse", 10,
			"DeadRat", 10,
			"DiceBag", 0.1,
			"ElectronicsScrap", 2,
			"EmptyJar", 10,
			"Fleshing_Tool", 0.01,
			"Flier", 2,
			"Fork_Gold", 0.01,
			"Fork_Silver", 0.1,
			"Garbagebag", 10,
			"GenericMail", 10,
			"Goblet", 0.0001,
			"TrophyBronze", 1,
			"TrophyGold", 1,
			"TrophySilver", 1,
			"LetterHandwritten", 20,
			"LetterHandwritten", 10,
			"Magazine", 10,
			"Magazine", 5,
			"Magazine_Popular", 10,
			"Magazine_Popular", 5,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MenuCard", 1,
			"MilitaryMedal", 0.01,
			"MoneyBundle", 0.1,
			"Mov_DesktopComputer", 1,
			"Mov_HuntingTrophy", 1,
			"Newspaper", 20,
			"Newspaper", 10,
			"Note", 20,
			"Note", 10,
			"Paperback", 20,
			"Paperback", 10,
			"Phonebook", 20,
			"Phonebook", 10,
			"Photo", 20,
			"Photo", 10,
			"Photo_VeryOld", 10,
			"Plasticbag_Bags", 8,
			"PopBottleEmpty", 2,
			"PotScrubberFrog", 0.001,
			"Receipt", 10,
			"RippedSheets", 10,
			"RPGmanual", 0.1,
			"ScrapMetal", 2,
			"Spoon_Gold", 0.01,
			"Spoon_Silver", 0.1,
			"Tote_Bags", 4,
			"TVMagazine", 20,
			"TVMagazine", 10,
			"Twine", 10,
			"VHS_Home", 4,
			"WristWatch_Left_Expensive", 0.0001,
			"WristWatch_Left_ClassicGold", 0.01,
			"WristWatch_Left_DigitalDress", 0.01,
			"WaterBottle", 2,
			"Whiskey", 1,
			"Wine", 1,
			"Wine2", 1,
		},
		junk = ClutterTables.ClosetJunk,
	},

	-- Residential kitchens. Baking supplies.
	KitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"BakingSoda", 1,
			"CannedMilk", 1,
			"Chocolate", 2,
			"ChocolateChips", 1,
			"Cinnamon", 1,
			"CocoaPowder", 1,
			"Cornflour2", 0.5,
			"Cornmeal2", 0.5,
			"Flour2", 4,
			"GrahamCrackers", 1,
			"GravyMix", 0.5,
			"Marshmallows", 1,
			"OilOlive", 1,
			"OilVegetable", 1,
			"PancakeMix", 2,
			"Sugar", 2,
			"SugarBrown", 2,
			"SugarCubes", 6,
			"Vinegar2", 1,
			"Vinegar_Jug", 0.05,
			"Yeast", 4,
			-- Trays/Dishes
			"BakingPan", 4,
			"BakingTray", 4,
			"Bowl", 8,
			"MuffinTray", 4,
			-- Utensils
			"Ladle", 6,
			"RollingPin", 4,
			"Spoon", 10,
			"Whisk", 8,
			-- Misc.
			"Aluminum", 2,
			"DishCloth", 10,
			"OvenMitt", 8,
			"Sparklers", 0.5,
		},
		junk = {
			rolls = 1,
			items = {
				"DeadMouse", 1,
				"DeadRat", 1,
				"Yeast", 4,

			}
		}
	},

	-- Kitchen wall shelf.
	KitchenBook = {
		rolls = 4,
		items = {
			-- Skill Books
			"BookButchering1", 2,
			"BookButchering2", 1,
			"BookButchering3", 0.5,
			"BookCooking1", 2,
			"BookCooking2", 1,
			"BookCooking3", 0.5,
			"BookFarming1", 2,
			"BookFarming2", 1,
			"BookFarming3", 0.5,
			"BookFirstAid1", 2,
			"BookHusbandry1", 2,
			"BookHusbandry2", 1,
			"BookHusbandry3", 0.5,
			"BookTailoring1", 2,
			"BookTailoring2", 1,
			"BookTailoring3", 0.5,
			-- Literature (Recipes)
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"KnittingMag1", 0.5,
			"KnittingMag2", 0.5,
			"RecipeClipping", 10,
			-- Stationery
			"BluePen", 4,
			"Calculator", 0.5,
			"Eraser", 4,
			"Glue", 1,
			"GreenPen", 1,
			"MarkerBlack", 1,
			"MarkerBlue", 0.1,
			"MarkerGreen", 0.1,
			"MarkerRed", 0.1,
			"Paperclip", 8,
			"PaperclipBox", 0.1,
			"Pen", 4,
			"Pencil", 8,
			"RedPen", 4,
			"RubberBand", 6,
			"Scissors", 2,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			-- Literature (Generic)
			"Brochure", 8,
			"Catalog", 10,
			"DoodleKids", 10,
			"Flier", 8,
			"GenericMail", 20,
			"IndexCard", 20,
			"LetterHandwritten", 10,
			"Magazine", 6,
			"Magazine_Popular", 10,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Note", 20,
			"Notebook", 4,
			"Notepad", 8,
			"Paperback", 4,
			"Paperback_Diet", 4,
			"Paperback_Medical", 4,
			"Phonebook", 20,
			"Photo", 10,
			"Receipt", 20,
			"TVMagazine", 6,
			-- Electronics
			"CordlessPhone", 4,
			"RadioBlack", 2,
			"RadioRed", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},

	KitchenBottles = {
		ignoreZombieDensity = true,
		rolls = 2, -- reduced to 2 from 4 to rebalance food spawns
		items = {
			"BeerBottle", 1,
			"BeerCan", 2,
			"BeerCanPack", 0.01,
			"BeerPack", 0.01,
			"Flask", 0.1,
			"JuiceBox", 4,
			"JuiceBoxApple", 4,
			"JuiceBoxFruitpunch", 4,
			"JuiceBoxOrange", 4,
			"Pop", 8,
			"Pop2", 8,
			"Pop3", 8,
			"PopBottle", 4,
			"PopBottleRare", 0.1,
			"SodaCan", 8,
			--"SodaCanRare", 2,
			"WaterBottle", 4,
			"Whiskey", 2,
			"Wine", 1,
			"Wine2", 1,
			"WineBox", 2,
		},
		junk = {
			rolls = 4,
			items = {
				"BottleOpener", 10,
				"Corkscrew", 4,
				"DishCloth", 10,
				"DrinkingGlass", 10,
				"GlassTumbler", 8,
				"GlassWine", 4,
				"PlasticCup", 10,
			}
		}
	},

	KitchenBreakfast = {
		ignoreZombieDensity = true,
		rolls = 2, -- reduced to 2 from 4 to rebalance food spawns
		items = {
			"Bread", 6,
			"CannedMilk", 2,
			"Cereal", 8,
			"Chocolate", 6,
			"Cinnamon", 4,
			"Coffee2", 4,
			"CookieJar", 0.1,
			"CookieJar_Bear", 0.001,
			"Crackers", 8,
			"GranolaBar", 6,
			"Honey", 4,
			"JamFruit", 6,
			"JamMarmalade", 1,
			"MapleSyrup", 4,
			"OatsRaw", 6,
			"PancakeMix", 6,
			"PeanutButter", 8,
			"Sugar", 2,
			"SugarBrown", 2,
			"SugarCubes", 6,
			"Teabag2", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"DeadMouse", 1,
				"DeadRat", 1,
				"DishCloth", 10,
			}
		}
	},

	KitchenCannedFood = {
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"CannedBolognese", 4,
			"CannedCarrots2", 2,
			"CannedChili", 4,
			"CannedCorn", 2,
			"CannedCornedBeef", 4,
			"CannedFruitBeverage", 4,
			"CannedFruitCocktail", 4,
			"CannedMilk", 1,
			"CannedMushroomSoup", 4,
			"CannedPeaches", 2,
			"CannedPeas", 2,
			"CannedPineapple", 2,
			"CannedPotato2", 2,
			"CannedSardines", 4,
			"CannedTomato2", 2,
			"Dogfood", 1,
			"MysteryCan", 1,
			"TinnedBeans", 4,
			"TinnedSoup", 4,
			"TinOpener", 8,
			"TinOpener_Old", 2,
			"TomatoPaste", 2,
			"TunaTin", 2,
			"Vinegar2", 1,
			"Vinegar_Jug", 0.05,
		},
		junk = {
			rolls = 1,
			items = {
				"DeadMouse", 1,
				"DeadRat", 1,
				"DentedCan", 2,
				"DishCloth", 10,
				"MysteryCan", 1,
			}
		}
	},

	KitchenDishes = {
		rolls = 4,
		items = {
			"Bowl", 10,
			"BreadKnife", 8,
			"ButterKnife", 10,
			"CarvingFork2", 4,
			"CheeseGrater", 8,
			"DrinkingGlass", 10,
			"Fleshing_Tool", 0.01,
			"Fork", 10,
			"GlassTumbler", 8,
			"GlassWine", 4,
			"KitchenKnife", 6,
			"KnifeFillet", 6,
			"KnifeParing", 6,
			"KitchenTongs", 8,
			"Ladle", 8,
			"LargeKnife", 0.1,
			"MeatCleaver", 4,
			"MortarPestle", 0.5,
			"Mugl", 10,
			"PizzaCutter", 6,
			"Plate", 10,
			"Spatula", 8,
			"Spoon", 10,
			"Strainer", 8,
			"Teacup", 4,
			"TinOpener", 8,
			"TinOpener_Old", 2,
			"Whetstone", 4,
			"Whisk", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"DishCloth", 10,
			}
		}
	},

	KitchenDryFood = {
		ignoreZombieDensity = true,
		rolls = 2, -- reduced to 2 from 4 to rebalance food spawns
		items = {
			"BouillonCube", 10,
			"Cereal", 8,
			"Chocolate", 6,
			"Crackers", 8,
			"Crisps", 4,
			"Crisps2", 4,
			"Crisps3", 4,
			"Crisps4", 4,
			"DriedApricots", 6,
			"DriedBlackBeans", 2, -- halved their value to rebalance food
			"DriedChickpeas", 2, -- halved their value to rebalance food
			"DriedKidneyBeans", 2, -- halved their value to rebalance food
			"DriedLentils", 2, -- halved their value to rebalance food
			"DriedSplitPeas", 2, -- halved their value to rebalance food
			"DriedWhiteBeans", 2, -- halved their value to rebalance food
			"Macandcheese", 8,
			"Macaroni", 2,
			"Marinara", 8,
			"Pasta", 2,
			"Pepper", 20,
			"Popcorn", 6,
			"PorkRinds", 4,
			"Ramen", 4,
			"Rice", 2,
			"Salt", 20,
			"PowderedGarlic", 4,
			"PowderedOnion", 4,
			"SeasoningSalt", 6,
			"TacoShell", 2,
			"Tortilla", 2,
			"TortillaChips", 4,
			"Vinegar2", 4,
			"Vinegar_Jug", 0.2,
			"Yeast", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"DeadMouse", 1,
				"DeadRat", 1,
				"DishCloth", 10,
			}
		}
	},

	KitchenPots = {
		rolls = 4,
		items = {
			"BakingPan", 8,
			"BakingTray", 10,
			"BastingBrush", 10,
			"CheeseGrater", 8,
			"CuttingBoardPlastic", 4,
			"CuttingBoardWooden", 4,
			"GridlePan", 8,
			"GrillBrush", 4,
			"Kettle", 10,
			"Kettle_Copper", 1,
			"KitchenTongs", 8,
			"Ladle", 8,
			"MortarPestle", 0.5,
			"MuffinTray", 8,
			"OvenMitt", 8,
			"Pan", 10,
			"PizzaCutter", 6,
			"Pot", 8,
			"RoastingPan", 8,
			"RollingPin", 8,
			"Saucepan", 10,
			"SaucepanCopper", 2,
			"Spatula", 8,
			"Strainer", 8,
			"TinOpener", 8,
			"Whisk", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"DishCloth", 10,
			}
		}
	},

	KitchenRandom = {
		rolls = 2,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_Clover", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RabbitFoot", 0.01,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			"KeyRing_StinkyFace", 0.001,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- Kitchen/Cutlery
			"BottleOpener", 4,
			"CheeseCloth", 8,
			"Chopsticks", 0.05,
			"Corkscrew", 6,
			-- Tools
			"KnifeButterfly", 1,
			"KnifePocket", 0.1,
			"LargeKnife", 0.1,
			"Fleshing_Tool", 0.01,
			"Funnel", 6,
			"Hammer", 4,
			"Handiknife", 0.1,
			"MeasuringTape", 6,
			"Multitool", 0.001,
			"Pliers", 4,
			"Scissors", 1,
			"ScissorsBlunt", 1,
			"Screwdriver", 6,
			"ViseGrips", 1,
			"Whetstone", 4,
			-- Cleaning/Maintenance
			"Bleach", 2,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"CleaningLiquid2", 2,
			"Gloves_Dish", 8,
			"SewingKit", 1,
			"Sponge", 6,
			-- Literature (Generic)
			"Brochure", 2,
			"BusinessCard", 0.5,
			"Card_Birthday", 0.01,
			"Card_Christmas", 0.01,
			"Card_Easter", 0.01,
			"Card_Halloween", 0.01,
			"Card_Hanukkah", 0.01,
			"Card_LunarYear", 0.01,
			"Card_StPatrick", 0.01,
			"Card_Sympathy", 0.01,
			"Card_Valentine", 0.01,
			"Catalog", 8,
			"Flier", 2,
			"IndexCard", 6,
			"Magazine", 3,
			"Magazine_Popular", 3,
			"MenuCard", 6,
			"Note", 8,
			"Notepad", 4,
			"Paperback_Diet", 4,
			"Paperback_Medical", 4,
			"Phonebook", 4,
			"Photo", 1,
			"Receipt", 8,
			"RecipeClipping", 0.5,
			"ScratchTicket", 0.1,
			"ScratchTicket_Winner", 0.1,
			"TVMagazine", 4,
			-- Stationery/Office
			"BluePen", 4,
			"Calculator", 1,
			"Clipboard", 1,
			"Eraser", 4,
			"GraphPaper", 0.05,
			"GreenPen", 2,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Paperclip", 6,
			"Pen", 4,
			"Pencil", 6,
			"RedPen", 4,
			-- Eyewear
			"Glasses_Aviators", 0.5,
			"Glasses_Reading", 1,
			"Glasses_Sun", 1,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			-- Canning
			"BoxOfJars", 0.1,
			"EmptyJar", 4,
			"JarLid", 4,
			"Vinegar2", 4,
			"Vinegar_Jug", 0.2,
			-- Electronics
			"Battery", 8,
			"BatteryBox", 0.1,
			"HandTorch", 4,
			"HomeAlarm", 0.05,
			"LightBulb", 0.5,
			"LightBulbBlue", 0.01,
			"LightBulbCyan", 0.03,
			"LightBulbGreen", 0.01,
			"LightBulbMagenta", 0.01,
			"LightBulbOrange", 0.006,
			"LightBulbPink", 0.001,
			"LightBulbPurple", 0.003,
			"LightBulbRed", 0.01,
			"LightBulbYellow", 0.06,
			"PowerBar", 4,
			"RadioBlack", 1,
			"RadioRed", 0.5,
			"Timer", 8,
			"Torch", 2,
			-- Firearms
			"Pistol", 0.005,
			"Revolver_Short", 0.01,
			-- Gardening
			"GardeningSprayEmpty", 2,
			"InsectRepellent", 0.5,
			"SeedBag", 0.5,
			"TrapMouse", 4,
			-- Materials
			"Aluminum", 4,
			"DuctTape", 1,
			"Epoxy", 0.05,
			"Glue", 2,
			"Needle", 2,
			"RubberHose", 0.5,
			"Scotchtape", 4,
			"SteelWool", 6,
			"Thread", 6,
			"Twine", 6,
			"Wire", 2,
			"Woodglue", 0.5,
			"Yarn", 2,
			-- Medical
			"Bandaid", 6,
			"Pills", 0.5,
			"PillsAntiDep", 0.05,
			"PillsBeta", 0.05,
			"PillsVitamins", 0.05,
			-- Pets
			"Dogfood", 2,
			"DogFoodBag", 0.1,
			"DogTag_Pet", 0.5,
			"Leash", 0.5,
			"WaterDishEmpty", 0.5,
			-- Photography
			"Camera", 0.5,
			"CameraDisposable", 0.1,
			"CameraExpensive", 0.001,
			"CameraFilm", 1,
			-- Sports
			"Sportsbottle", 0.1,
			"Whistle", 0.1,
			-- Tobacco/Smoking
			"Cigar", 0.05,
			"CigarettePack", 1,
			"CigaretteRollingPapers", 0.5,
			"Cigarillo", 0.5,
			"LighterBBQ", 2,
			"LighterDisposable", 2,
			"LighterFluid", 0.5,
			"Matchbox", 0.5,
			"Matches", 4,
			"TobaccoChewing", 0.5,
			"TobaccoLoose", 0.5,
			-- Bags
			"Garbagebag", 8,
			"Garbagebag_box", 2,
			"PaperBag", 4,
			"Plasticbag_Bags", 4,
			"Tote_Bags", 2,
			-- Containers
			"CookieJar", 0.05,
			"Cooler", 0.05,
			-- Misc.
			"Buckle", 2,
			"Candle", 6,
			"CardDeck", 4,
			"CombinationPadlock", 0.5,
			"CreditCard", 0.5,
			"Dice", 4,
			"Doily", 4,
			"HotWaterBottleEmpty", 4,
			-- NOTE: Temporarily bumped for testing purposes.
			"IndustrialDye", 20,
			"Money", 1,
			"Padlock", 0.5,
			"PokerChips", 0.5,
			"Sparklers", 2,
			"Thimble", 4,
			"TissueBox", 1,
			-- Special
			"CookieJar_Bear", 0.001,
			"HollowBook", 0.001,
			"PotScrubberFrog", 0.001,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},

	KnifeFactoryCutlery = {
		isShop = true,
		rolls = 4,
		items = {
			"ButterKnife", 50,
			"ButterKnife", 20,
			"BreadKnife", 50,
			"BreadKnife", 20,
			"KnifeParing", 50,
			"KnifeParing", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	KnifeFactoryHandles = {
		isShop = true,
		rolls = 4,
		items = {
			"SmallHandle", 50,
			"SmallHandle", 20,
			"SmallHandle", 20,
			"SmallHandle", 10,
			"SmallHandle", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	KnifeFactoryKitchenKnife = {
		isShop = true,
		rolls = 4,
		items = {
			"KitchenKnife", 50,
			"KitchenKnife", 20,
			"KitchenKnife", 20,
			"KitchenKnife", 10,
			"KitchenKnife", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	KnifeFactoryKitchenKnifeBlades = {
		isShop = true,
		rolls = 4,
		items = {
			"KitchenKnifeBlade", 50,
			"KitchenKnifeBlade", 20,
			"KitchenKnifeBlade", 20,
			"KitchenKnifeBlade", 10,
			"KitchenKnifeBlade", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	KnifeFactoryMeatCleaver = {
		isShop = true,
		rolls = 4,
		items = {
			"MeatCleaver", 50,
			"MeatCleaver", 20,
			"MeatCleaver", 20,
			"MeatCleaver", 10,
			"MeatCleaver", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	KnifeFactoryMeatCleaverBlades = {
		isShop = true,
		rolls = 4,
		items = {
			"MeatCleaverBlade", 50,
			"MeatCleaverBlade", 20,
			"MeatCleaverBlade", 20,
			"MeatCleaverBlade", 10,
			"MeatCleaverBlade", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	KnifeFactorySushiKnife = {
		isShop = true,
		rolls = 4,
		items = {
			"KnifeSushi", 50,
			"KnifeSushi", 20,
			"KnifeSushi", 20,
			"KnifeSushi", 10,
			"KnifeSushi", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	KnifeFactoryTools = {
		rolls = 4,
		items = {
			"BallPeenHammer", 8,
			"Calipers", 8,
			"ElbowPad_Left_Workman", 1,
			"Epoxy", 4,
			"File", 8,
			"Glasses_SafetyGoggles", 4,
			"HandDrill", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"Hat_HardHat", 2,
			"Kneepad_Left_Workman", 4,
			"MarkerBlack", 10,
			"MeasuringTape", 10,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"Pliers", 8,
			"RespiratorFilters", 2,
			"Saw", 8,
			"Screwdriver", 10,
			"Screws", 10,
			"ScrewsBox", 4,
			"ScrewsCarton", 0.1,
			"SheetMetalSnips", 8,
			"SmallHandle", 20,
			"SmallFileSet", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"SteelBar", 4,
			"SteelBarHalf", 6,
			"SteelPiece", 10,
			"SteelBarQuarter", 8,
			"ViseGrips", 4,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"AluminumFragments", 4,
			}
		}
	},

	KnifeStoreCutlery = {
		isShop = true,
		rolls = 4,
		items = {
			"KitchenKnife", 50,
			"KitchenKnife", 20,
			"KnifeFillet", 20,
			"KnifeFillet", 10,
			"KnifeParing", 20,
			"KnifeParing", 10,
			"KnifeSushi", 4,
			"MeatCleaver", 20,
			"MeatCleaver", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LaboratoryBooks = {
		rolls = 4,
		items = {
			"Book_Medical", 20,
			"Book_Medical", 20,
			"Book_Medical", 10,
			"Book_Medical", 10,
			"BookFirstAid1", 10,
			"BookFirstAid2", 8,
			"BookFirstAid3", 6,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			"Phonebook", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LaboratoryGasStorage = {
		rolls = 4,
		items = {
			"Oxygen_Tank", 20,
			"Oxygen_Tank", 20,
			"Oxygen_Tank", 10,
			"Oxygen_Tank", 10,
			"PropaneTank", 20,
			"PropaneTank", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LaboratoryLockers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"Belt2", 4,
			"Book_Science", 4,
			"Briefcase", 0.2,
			"Calculator", 4,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flask", 0.1,
			"Glasses_SafetyGoggles", 8,
			"Glasses_Sun", 1,
			"Gloves_Surgical", 10,
			"Gum", 10,
			"Hat_BuildersRespirator", 0.5,
			"Headphones", 1,
			"Handbag", 0.5,
			"JacketLong_Doctor", 4,
			"JacketLong_Doctor", 4,
			"Jacket_WhiteTINT", 0.5,
			"Jumper_DiamondPatternTINT", 0.1,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_VNeck", 0.5,
			"Lunchbag", 1,
			"Lunchbox", 1,
			"Lunchbox2", 0.001,
			"Magazine_Health", 10,
			"Money", 4,
			"Paperback_Science", 8,
			"Purse", 0.5,
			"RespiratorFilters", 1,
			"RubberHose", 4,
			"Shirt_FormalTINT", 0.5,
			"Shirt_FormalWhite", 0.5,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shoes_Random", 2,
			"Shoes_TrainerTINT", 2,
			"Socks_Ankle", 1,
			"Socks_Ankle_Black", 4,
			"Socks_Ankle_White", 2,
			"Socks_Long", 1,
			"Socks_Long_Black", 4,
			"Socks_Long_White", 2,
			"Sportsbottle", 1,
			"Suitcase", 0.2,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Tshirt_WhiteTINT", 2,
			"Vest_DefaultTEXTURE_TINT", 1,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	LaundryCleaning = {
		rolls = 4,
		items = {
			"Bleach", 10,
			"Broom", 10,
			"Bucket", 10,
			"CleaningLiquid2", 4,
			"Garbagebag_box", 2,
			"Gloves_Dish", 10,
			-- NOTE: Temporarily bumped for testing purposes.
			"IndustrialDye", 20,
			"Mop", 10,
			"RippedSheets", 8,
			"RippedSheetsDirty", 10,
			"SewingKit", 2,
			"Sponge", 10,
			"Toolbox", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LaundryHospital = {
		rolls = 4,
		items = {
			"HospitalGown", 20,
			"HospitalGown", 10,
			"Sheet", 50,
			"Sheet", 20,
			"Sheet", 20,
			"Sheet", 10,
			"Sheet", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LaundryLoad1 = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"BathTowel", 10,
			"Boxers_Hearts", 2,
			"Boxers_RedStripes", 2,
			"Boxers_Silk_Black", 1,
			"Boxers_Silk_Red", 1,
			"Boxers_White", 4,
			"Briefs_AnimalPrints", 2,
			"Briefs_SmallTrunks_Black", 0.5,
			"Briefs_SmallTrunks_Blue", 0.5,
			"Briefs_SmallTrunks_Red", 0.5,
			"Briefs_SmallTrunks_WhiteTINT", 0.5,
			"Briefs_White", 4,
			"Socks_Ankle", 10,
			"Socks_Ankle_Black", 10,
			"Socks_Ankle_White", 10,
			"Socks_Heavy", 1,
			"Socks_Long", 10,
			"Socks_Long_Black", 10,
			"Socks_Long_White", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Bracelet_LeftFriendshipTINT", 0.001,
				"Money", 1,
			}
		}
	},

	LaundryLoad2 = {
		rolls = 4,
		items = {
			"BathTowel", 50,
			"BathTowel", 20,
			"BathTowel", 20,
			"BathTowel", 10,
			"BathTowel", 10,
			"DishCloth", 20,
			"DishCloth", 10,
			"Sheet", 20,
			"Sheet", 10,
			"Socks_Ankle", 10,
			"Socks_Ankle_Black", 10,
			"Socks_Ankle_White", 10,
			"Socks_Heavy", 1,
			"Socks_Long", 10,
			"Socks_Long_Black", 10,
			"Socks_Long_White", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Bracelet_LeftFriendshipTINT", 0.001,
			}
		}
	},

	LaundryLoad3 = {
		rolls = 4,
		items = {
			"Dungarees", 0.01,
			"Shorts_CamoGreenLong", 0.1,
			"Shorts_LongSport", 8,
			"Shorts_ShortSport", 10,
			"TrousersMesh_DenimLight", 20,
			"Trousers_CamoGreen", 0.1,
			"Trousers_DefaultTEXTURE_TINT", 20,
			"Trousers_Denim", 10,
			"Trousers_JeanBaggy", 10,
			"Trousers_Suit", 4,
			"Trousers_SuitTEXTURE", 4,
			"Trousers_SuitWhite", 1,
			"Trousers_WhiteTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Bracelet_LeftFriendshipTINT", 0.001,
				"Earbuds", 1,
				"Money", 1,
			}
		}
	},

	LaundryLoad4 = {
		rolls = 4,
		items = {

			"Shirt_Baseball_KY", 1,
			"Shirt_Baseball_Rangers", 1,
			"Shirt_Baseball_Z", 1,
			"Tshirt_ArmyGreen", 0.1,
			"Tshirt_CamoGreen", 0.1,
			"Tshirt_DefaultDECAL_TINT", 1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_WhiteTINT", 20,
			"Tshirt_WhiteTINT", 20,
			"Tshirt_WhiteTINT", 20,
			"Tshirt_WhiteTINT", 20,
			"Tshirt_WhiteTINT", 20,
			"Tshirt_WhiteTINT", 20,
			"Vest_DefaultTEXTURE_TINT", 20,
			"Vest_DefaultTEXTURE_TINT", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"Bracelet_LeftFriendshipTINT", 0.001,
				"Money", 1,
			}
		}
	},

	LaundryLoad5 = {
		rolls = 4,
		items = {
			"HoodieDOWN_WhiteTINT", 20,
			"Jumper_DiamondPatternTINT", 1,
			"Jumper_PoloNeck", 2,
			"Jumper_RoundNeck", 4,
			"Jumper_VNeck", 6,
			"Shirt_CamoGreen", 8,
			"Shirt_Denim", 8,
			"Shirt_FormalTINT", 10,
			"Shirt_FormalWhite", 6,
			"Shirt_FormalWhite", 6,
			"Shirt_FormalWhite_ShortSleeve", 6,
			"Shirt_FormalWhite_ShortSleeveTINT", 10,
			"Shirt_Lumberjack", 4,
			"Shirt_Lumberjack_TINT", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Bracelet_LeftFriendshipTINT", 0.001,
				"Money", 1,
			}
		}
	},

	LaundryLoad6 = {
		rolls = 4,
		items = {
			"Dress_Knees", 1,
			"Dress_Long", 0.6,
			"Dress_Normal", 0.8,
			"Dress_Short", 1,
			"HoodieDOWN_WhiteTINT", 1,
			"Jumper_DiamondPatternTINT", 0.4,
			"Jumper_PoloNeck", 0.6,
			"Jumper_RoundNeck", 0.8,
			"Jumper_VNeck", 0.8,
			"Shirt_Baseball_KY", 0.6,
			"Shirt_Baseball_Rangers", 0.6,
			"Shirt_Baseball_Z", 0.6,
			"Shirt_Denim", 0.8,
			"Shirt_FormalTINT", 0.8,
			"Shirt_FormalWhite", 1,
			"Shirt_FormalWhite_ShortSleeve", 0.8,
			"Shirt_FormalWhite_ShortSleeveTINT", 0.8,
			"Shirt_Lumberjack", 1,
			"Shirt_Lumberjack_TINT", 1,
			"Shorts_LongSport", 0.8,
			"Shorts_ShortSport", 0.8,
			"Skirt_Knees", 1,
			"Skirt_Long", 0.6,
			"Skirt_Normal", 1,
			"TrousersMesh_DenimLight", 0.8,
			"Trousers_DefaultTEXTURE_TINT", 0.8,
			"Trousers_Denim", 0.6,
			"Trousers_JeanBaggy", 0.6,
			"Trousers_Sport", 1,
			"Trousers_Suit", 0.4,
			"Trousers_SuitTEXTURE", 0.8,
			"Trousers_SuitWhite", 0.4,
			"Trousers_WhiteTINT", 0.8,
			"Tshirt_DefaultDECAL_TINT", 0.8,
			"Tshirt_DefaultTEXTURE_TINT", 0.8,
			"Tshirt_IndieStoneDECAL", 0.4,
			"Tshirt_PoloStripedTINT", 0.6,
			"Tshirt_PoloTINT", 0.6,
			"Tshirt_Sport", 1,
			"Tshirt_SportDECAL", 0.8,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 1,
			"Vest_DefaultTEXTURE_TINT", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Bracelet_LeftFriendshipTINT", 0.001,
				"Earbuds", 1,
				"Money", 1,
			}
		}
	},

	LaundryLoad7 = {
		rolls = 4,
		items = {
			"Socks_Ankle", 10,
			"Socks_Ankle_Black", 10,
			"Socks_Ankle_White", 10,
			"Socks_Heavy", 1,
			"Socks_Long", 10,
			"Socks_Long_Black", 10,
			"Socks_Long_White", 10,
			"BathTowel", 20,
			"BathTowel", 10,
			"Sheet", 20,
			"Sheet", 10,
			"Tshirt_WhiteTINT", 50,
			"Tshirt_WhiteTINT", 20,
			"Tshirt_WhiteTINT", 20,
			"Tshirt_WhiteTINT", 10,
			"Tshirt_WhiteTINT", 10,
			"Vest_DefaultTEXTURE_TINT", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Bracelet_LeftFriendshipTINT", 0.001,
			}
		}
	},

	LaundryLoad8 = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"BathTowel", 10,
			"Bra_Strapless_AnimalPrint", 2,
			"Bra_Strapless_Black", 4,
			"Bra_Strapless_FrillyBlack", 1,
			"Bra_Strapless_FrillyPink", 1,
			"Bra_Strapless_RedSpots", 2,
			"Bra_Strapless_White", 4,
			"Bra_Straps_AnimalPrint", 2,
			"Bra_Straps_Black", 4,
			"Bra_Straps_FrillyBlack", 1,
			"Bra_Straps_FrillyPink", 1,
			"Bra_Straps_White", 4,
			"FrillyUnderpants_Black", 1,
			"FrillyUnderpants_Pink", 1,
			"FrillyUnderpants_Red", 1,
			"Socks_Ankle", 10,
			"Socks_Ankle_Black", 10,
			"Socks_Ankle_White", 10,
			"Socks_Heavy", 1,
			"Socks_Long", 10,
			"Socks_Long_Black", 10,
			"Socks_Long_White", 10,
			"Underpants_Black", 4,
			"Underpants_White", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Bracelet_LeftFriendshipTINT", 0.001,
				"Money", 1,
			}
		}
	},

	LibraryArt = {
		rolls = 4,
		items = {
			"Book_Art", 20,
			"Book_Art", 10,
			"Paperback_Art", 20,
			"Paperback_Art", 20,
			"Paperback_Art", 10,
			"Paperback_Art", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.01,
			}
		}
	},

	LibraryBiography = {
		rolls = 4,
		items = {
			"Book_Biography", 20,
			"Book_Biography", 10,
			"Paperback_Biography", 20,
			"Paperback_Biography", 20,
			"Paperback_Biography", 10,
			"Paperback_Biography", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryBooks = {
		rolls = 4,
		items = {
			"BookBlacksmith1", 8,
			"BookBlacksmith2", 6,
			"BookBlacksmith3", 4,
			"BookBlacksmith4", 2,
			"BookBlacksmith5", 1,
			"BookButchering1", 8,
			"BookButchering2", 6,
			"BookButchering3", 4,
			"BookButchering4", 2,
			"BookButchering5", 1,
			"BookCarpentry1", 8,
			"BookCarpentry2", 6,
			"BookCarpentry3", 4,
			"BookCarpentry4", 2,
			"BookCarpentry5", 1,
			"BookCarving1", 0.8,
			"BookCarving2", 0.6,
			"BookCarving3", 0.4,
			"BookCarving4", 0.2,
			"BookCarving5", 0.1,
			"BookCooking1", 8,
			"BookCooking2", 6,
			"BookCooking3", 4,
			"BookCooking4", 2,
			"BookCooking5", 1,
			"BookElectrician1", 8,
			"BookElectrician2", 6,
			"BookElectrician3", 4,
			"BookElectrician4", 2,
			"BookElectrician5", 1,
			"BookFishing1", 8,
			"BookFishing2", 6,
			"BookFishing3", 4,
			"BookFishing4", 2,
			"BookFishing5", 1,
			"BookGlassmaking1", 8,
			"BookGlassmaking2", 6,
			"BookGlassmaking3", 4,
			"BookGlassmaking4", 2,
			"BookGlassmaking5", 1,
			"BookHusbandry1", 8,
			"BookHusbandry2", 6,
			"BookHusbandry3", 4,
			"BookHusbandry4", 2,
			"BookHusbandry5", 1,
			"BookMaintenance1", 8,
			"BookMaintenance2", 6,
			"BookMaintenance3", 4,
			"BookMaintenance4", 2,
			"BookMaintenance5", 1,
			"BookMasonry1", 8,
			"BookMasonry2", 6,
			"BookMasonry3", 4,
			"BookMasonry4", 2,
			"BookMasonry5", 1,
			"BookMechanic1", 8,
			"BookMechanic2", 6,
			"BookMechanic3", 4,
			"BookMechanic4", 2,
			"BookMechanic5", 1,
			"BookMetalWelding1", 8,
			"BookMetalWelding2", 6,
			"BookMetalWelding3", 4,
			"BookMetalWelding4", 2,
			"BookMetalWelding5", 1,
			"BookPottery1", 8,
			"BookPottery2", 6,
			"BookPottery3", 4,
			"BookPottery4", 2,
			"BookPottery5", 1,
			"BookTracking1", 8,
			"BookTracking2", 6,
			"BookTracking3", 4,
			"BookTracking4", 2,
			"BookTracking5", 1,
			"BookTrapping1", 8,
			"BookTrapping2", 6,
			"BookTrapping3", 4,
			"BookTrapping4", 2,
			"BookTrapping5", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryBusiness = {
		rolls = 4,
		items = {
			"Book_Business", 20,
			"Book_Business", 10,
			"Paperback_Business", 20,
			"Paperback_Business", 20,
			"Paperback_Business", 10,
			"Paperback_Business", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryChilds = {
		rolls = 4,
		items = {
			"Book_Childs", 20,
			"Book_Childs", 10,
			"Paperback_Childs", 20,
			"Paperback_Childs", 20,
			"Paperback_Childs", 10,
			"Paperback_Childs", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.1,
			}
		}
	},

	LibraryCinema = {
		rolls = 4,
		items = {
			"Book_Cinema", 20,
			"Book_Cinema", 10,
			"Paperback_Cinema", 20,
			"Paperback_Cinema", 20,
			"Paperback_Cinema", 10,
			"Paperback_Cinema", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryComputer = {
		rolls = 4,
		items = {
			"Book_Computer", 20,
			"Book_Computer", 10,
			"Paperback_Computer", 20,
			"Paperback_Computer", 20,
			"Paperback_Computer", 10,
			"Paperback_Computer", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryCrimeFiction = {
		rolls = 4,
		items = {
			"Book_CrimeFiction", 20,
			"Book_CrimeFiction", 10,
			"Paperback_Fiction", 20,
			"Paperback_Fiction", 20,
			"Paperback_Fiction", 10,
			"Paperback_Fiction", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryCounter = {
		rolls = 4,
		items = {
			"Book", 20,
			"Calculator", 4,
			"FirstAidKit", 0.5,
			"IndexCard", 20,
			"IndexCard", 10,
			"Magazine_Popular", 10,
			"Paperback", 50,
			"Paperback", 20,
		},
		junk = ClutterTables.CounterJunk,
	},

	LibraryFantasySciFi = {
		rolls = 4,
		items = {
			"Book_Fantasy", 20,
			"Book_Fantasy", 10,
			"Book_SciFi", 20,
			"Book_SciFi", 10,
			"Paperback_Fantasy", 20,
			"Paperback_Fantasy", 10,
			"Paperback_SciFi", 20,
			"Paperback_SciFi", 10,
			"RPGmanual", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryFashion = {
		rolls = 4,
		items = {
			"Book_Fashion", 20,
			"Book_Fashion", 10,
			"BookTailoring1", 10,
			"BookTailoring2", 8,
			"BookTailoring3", 6,
			"BookTailoring4", 4,
			"BookTailoring5", 2,
			"Paperback_Fashion", 20,
			"Paperback_Fashion", 20,
			"Paperback_Fashion", 10,
			"Paperback_Fashion", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryGeneralReference = {
		rolls = 4,
		items = {
			"Book_GeneralReference", 50,
			"Book_GeneralReference", 20,
			"Book_GeneralReference", 20,
			"Book_GeneralReference", 20,
			"Book_GeneralReference", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryHistory = {
		rolls = 4,
		items = {
			"Book_History", 20,
			"Book_History", 10,
			"Paperback_History", 20,
			"Paperback_History", 20,
			"Paperback_History", 10,
			"Paperback_History", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryHorror = {
		rolls = 4,
		items = {
			"Book_Horror", 20,
			"Book_Horror", 10,
			"Paperback_Horror", 20,
			"Paperback_Horror", 20,
			"Paperback_Horror", 10,
			"Paperback_Horror", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryLegal = {
		rolls = 4,
		items = {
			"Book_Legal", 20,
			"Book_Legal", 10,
			"Paperback_Legal", 20,
			"Paperback_Legal", 20,
			"Paperback_Legal", 10,
			"Paperback_Legal", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryLiteraryFiction = {
		rolls = 4,
		items = {
			"Book_LiteraryFiction", 20,
			"Book_LiteraryFiction", 10,
			"Paperback_LiteraryFiction", 20,
			"Paperback_LiteraryFiction", 20,
			"Paperback_LiteraryFiction", 10,
			"Paperback_LiteraryFiction", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryMagazines = {
		rolls = 4,
		items = {
			"ArmorMag4", 0.01,
			"ArmorMag4", 0.01,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"GlassmakingMag1", 1,
			"GlassmakingMag2", 1,
			"GlassmakingMag3", 1,
			"HerbalistMag", 1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkMag1", 1,
			"MetalworkMag2", 1,
			"MetalworkMag3", 1,
			"MetalworkMag4", 1,
			"PrimitiveToolMag1", 0.01,
			"PrimitiveToolMag2", 0.01,
			"PrimitiveToolMag3", 0.01,
			"SmithingMag2", 1,
			"SmithingMag3", 1,
			"SmithingMag4", 1,
			"SmithingMag5", 1,
			"SmithingMag6", 1,
			"SmithingMag7", 1,
			"SmithingMag8", 1,
			"SmithingMag9", 1,
			"SmithingMag10", 1,
			"SmithingMag11", 1,
			"WeaponMag6", 0.01,
			"WeaponMag7", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryMedical = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Medical", 20,
			"Book_Medical", 10,
			"BookFirstAid1", 10,
			"BookFirstAid2", 8,
			"BookFirstAid3", 6,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			"Paperback_Medical", 20,
			"Paperback_Medical", 20,
			"Paperback_Medical", 10,
			"Paperback_Medical", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryMilitaryHistory = {
		rolls = 4,
		items = {
			"Book_MilitaryHistory", 20,
			"Book_MilitaryHistory", 10,
			"Paperback_MilitaryHistory", 20,
			"Paperback_MilitaryHistory", 20,
			"Paperback_MilitaryHistory", 10,
			"Paperback_MilitaryHistory", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryMusic = {
		rolls = 4,
		items = {
			"Book_Music", 20,
			"Book_Music", 10,
			"Paperback_Music", 20,
			"Paperback_Music", 20,
			"Paperback_Music", 10,
			"Paperback_Music", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryNewAge = {
		rolls = 4,
		items = {
			"Paperback_NewAge", 50,
			"Paperback_NewAge", 20,
			"Paperback_NewAge", 20,
			"Paperback_NewAge", 10,
			"Paperback_NewAge", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryNonFiction = {
		rolls = 4,
		items = {
			"Book_AdventureNonFiction", 20,
			"Book_AdventureNonFiction", 10,
			"Book_SadNonFiction", 20,
			"Book_SadNonFiction", 10,
			"Paperback_AdventureNonFiction", 20,
			"Paperback_AdventureNonFiction", 10,
			"Paperback_SadNonFiction", 20,
			"Paperback_SadNonFiction", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryOccult = {
		rolls = 4,
		items = {
			"Book_Occult", 20,
			"Book_Occult", 10,
			"Paperback_Occult", 20,
			"Paperback_Occult", 20,
			"Paperback_Occult", 10,
			"Paperback_Occult", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryOutdoors = {
		rolls = 4,
		items = {
			"Book_Farming", 20,
			"Book_Farming", 20,
			"Book_Farming", 10,
			"Book_Nature", 20,
			"Book_Nature", 10,
			"BookFarming1", 10,
			"BookFarming2", 8,
			"BookFarming3", 6,
			"BookFarming4", 4,
			"BookFarming5", 2,
			"BookForaging1", 10,
			"BookForaging2", 8,
			"BookForaging3", 6,
			"BookForaging4", 4,
			"BookForaging5", 2,
			"BookHusbandry1", 10,
			"BookHusbandry2", 8,
			"BookHusbandry3", 6,
			"BookHusbandry4", 4,
			"BookHusbandry5", 2,
			"Paperback_Nature", 20,
			"Paperback_Nature", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryPhilosophy = {
		rolls = 4,
		items = {
			"Paperback_Philosophy", 50,
			"Paperback_Philosophy", 20,
			"Paperback_Philosophy", 20,
			"Paperback_Philosophy", 10,
			"Paperback_Philosophy", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryPolitics = {
		rolls = 4,
		items = {
			"Book_Politics", 20,
			"Book_Politics", 10,
			"Paperback_Politics", 20,
			"Paperback_Politics", 20,
			"Paperback_Politics", 10,
			"Paperback_Politics", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryReligion = {
		rolls = 4,
		items = {
			"Book_Religion", 20,
			"Book_Religion", 10,
			"Paperback_Religion", 20,
			"Paperback_Religion", 20,
			"Paperback_Religion", 10,
			"Paperback_Religion", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryRomance = {
		rolls = 4,
		items = {
			"Book_Romance", 20,
			"Book_Romance", 10,
			"Paperback_Romance", 20,
			"Paperback_Romance", 20,
			"Paperback_Romance", 10,
			"Paperback_Romance", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryScience = {
		rolls = 4,
		items = {
			"Book_Science", 20,
			"Book_Science", 10,
			"Paperback_Science", 20,
			"Paperback_Science", 20,
			"Paperback_Science", 10,
			"Paperback_Science", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryPersonal = {
		rolls = 4,
		items = {
			"Paperback_Diet", 20,
			"Paperback_Diet", 10,
			"Paperback_Relationship", 20,
			"Paperback_Relationship", 10,
			"Paperback_SelfHelp", 20,
			"Paperback_SelfHelp", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibrarySports = {
		rolls = 4,
		items = {
			"Book_Golf", 10,
			"Book_Sports", 20,
			"Book_Sports", 10,
			"Paperback_Golf", 10,
			"Paperback_Sports", 20,
			"Paperback_Sports", 20,
			"Paperback_Sports", 10,
			"Paperback_Sports", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryThriller = {
		rolls = 4,
		items = {
			"Book_Thriller", 20,
			"Book_Thriller", 10,
			"Paperback_Thriller", 20,
			"Paperback_Thriller", 20,
			"Paperback_Thriller", 10,
			"Paperback_Thriller", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryTravel = {
		rolls = 4,
		items = {
			"Book_Travel", 20,
			"Book_Travel", 10,
			"Paperback_Travel", 20,
			"Paperback_Travel", 20,
			"Paperback_Travel", 10,
			"Paperback_Travel", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LibraryWestern = {
		rolls = 4,
		items = {
			"Book_Western", 20,
			"Book_Western", 10,
			"Paperback_Western", 20,
			"Paperback_Western", 20,
			"Paperback_Western", 10,
			"Paperback_Western", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Doodle", 0.001,
			}
		}
	},

	LingerieStoreAccessories = {
		isShop = true,
		rolls = 4,
		items = {
			"Hat_BunnyEarsBlack", 8,
			"Hat_BunnyEarsWhite", 8,
			"KeyRing_Sexy", 10,
			"BunnyTail", 10,
			"Gloves_LongWomenGloves", 20,
			"Gloves_LongWomenGloves", 10,
			"Corset_Black", 8,
			"Corset_Red", 8,
			"Corset", 10,
			"Paperback_Sexy", 8,
			"Pillow_Heart", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LingerieStoreBras = {
		isShop = true,
		rolls = 4,
		items = {
			"Bra_Strapless_AnimalPrint", 8,
			"Bra_Strapless_Black", 10,
			"Bra_Strapless_FrillyBlack", 8,
			"Bra_Strapless_FrillyPink", 8,
			"Bra_Strapless_FrillyRed", 8,
			"Bra_Strapless_RedSpots", 8,
			"Bra_Strapless_White", 10,
			"Bra_Straps_AnimalPrint", 8,
			"Bra_Straps_Black", 10,
			"Bra_Straps_FrillyBlack", 8,
			"Bra_Straps_FrillyPink", 8,
			"Bra_Straps_FrillyRed", 8,
			"Bra_Straps_White", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LingerieStoreOutfits = {
		isShop = true,
		rolls = 4,
		items = {
			"Dress_SmallStraps", 10,
			"Dress_SmallStrapless", 10,
			"Dress_SmallBlackStraps", 10,
			"Dress_SmallBlackStrapless", 10,
			"Dress_Short", 10,
			"Dress_SatinNegligee", 8,
			"BunnySuitBlack", 8,
			"BunnySuitPink", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LingerieStoreUnderwear = {
		isShop = true,
		rolls = 4,
		items = {
			"FrillyUnderpants_Black", 8,
			"FrillyUnderpants_Pink", 8,
			"FrillyUnderpants_Red", 8,
			"Garter", 8,
			"StockingsBlack", 10,
			"StockingsBlack", 10,
			"StockingsBlackSemiTrans", 10,
			"StockingsBlackTrans", 10,
			"StockingsWhite", 10,
			"TightsBlack", 10,
			"TightsBlackSemiTrans", 10,
			"TightsBlackTrans", 10,
			"TightsFishnets", 8,
			"Underpants_AnimalPrint", 8,
			"Underpants_Black", 10,
			"Underpants_RedSpots", 8,
			"Underpants_White", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Paper bags and cleaning supplies under the cash register.
	LiquorStoreBags = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- Bags
			"PaperBag", 50,
			"PaperBag", 20,
			-- Cleaning Supplies
			"Bleach", 4,
			"Bucket", 4,
			"CleaningLiquid2", 4,
			"DishCloth", 10,
			"Sponge", 10,
			-- Misc.
			"Extinguisher", 2,
		},
		junk = {
			rolls = 2,
			items = {
				"Receipt", 20,
				"Receipt", 10,
			}
		}
	},

	-- Beer bottles and cans. Found mostly in liquor stores.
	LiquorStoreBeer = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BeerBottle", 20,
			"BeerBottle", 20,
			"BeerBottle", 10,
			"BeerBottle", 10,
			"BeerCan", 20,
			"BeerCan", 20,
			"BeerCan", 10,
			"BeerCan", 10,
			"BeerCanPack", 1,
			"BeerPack", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Imported beer and cider.
	LiquorStoreBeerFancy = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"BeerImported", 20,
			"BeerImported", 20,
			"BeerImported", 10,
			"BeerImported", 10,
			"Cider", 20,
			"Cider", 20,
			"Cider", 10,
			"Cider", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Liquor stores have various types of grain alcohol on the shelves.
	LiquorStoreBrandy = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Brandy", 20,
			"Brandy", 20,
			"Brandy", 10,
			"Brandy", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Liquor stores.
	LiquorStoreGin = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Gin", 20,
			"Gin", 20,
			"Gin", 10,
			"Gin", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Various liqueurs and cocktail-oriented mixes.
	LiquorStoreMix = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Bitters", 20,
			"Bitters", 10,
			"CoffeeLiquer", 20,
			"CoffeeLiquer", 10,
			"Curacao", 20,
			"Curacao", 10,
			"Grenadine", 20,
			"Grenadine", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Liquor stores.
	LiquorStoreRum = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Rum", 20,
			"Rum", 20,
			"Rum", 10,
			"Rum", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Ditto.
	LiquorStoreScotch = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Scotch", 20,
			"Scotch", 20,
			"Scotch", 10,
			"Scotch", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- The next few containers all spawn in liquor stores.
	LiquorStoreTequila = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Tequila", 20,
			"Tequila", 20,
			"Tequila", 10,
			"Tequila", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LiquorStoreVodka = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Vodka", 20,
			"Vodka", 20,
			"Vodka", 10,
			"Vodka", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LiquorStoreWhiskey = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Whiskey", 20,
			"Whiskey", 20,
			"Whiskey", 10,
			"Whiskey", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LiquorStoreWine = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Wine", 20,
			"Wine", 10,
			"Wine2", 20,
			"Wine2", 10,
			"WineRed_Boxed", 4,
			"WineBox", 20,
			"WineBox", 10,
			"WineWhite_Boxed", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Champagne might need to be more rare.
	LiquorStoreWineFancy = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Champagne", 20,
			"Champagne", 10,
			"Port", 20,
			"Port", 10,
			"Sherry", 20,
			"Sherry", 10,
			"Vermouth", 20,
			"Vermouth", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LivingRoomShelf = {
		rolls = 4,
		items = {
			-- Literature (Skill Books)
			"BookAiming1", 0.005,
			"BookAiming2", 0.0025,
			"BookAiming3", 0.0001,
			"BookBlacksmith1", 0.1,
			"BookBlacksmith2", 0.05,
			"BookBlacksmith3", 0.025,
			"BookButchering1", 0.1,
			"BookButchering2", 0.05,
			"BookButchering3", 0.025,
			"BookCarpentry1", 0.1,
			"BookCarpentry2", 0.05,
			"BookCarpentry3", 0.025,
			"BookCarving1", 0.005,
			"BookCarving2", 0.0025,
			"BookCarving3", 0.0001,
			"BookCooking1", 0.1,
			"BookCooking2", 0.05,
			"BookCooking3", 0.025,
			"BookElectrician1", 0.1,
			"BookElectrician2", 0.05,
			"BookElectrician3", 0.025,
			"BookFarming1", 0.1,
			"BookFarming2", 0.05,
			"BookFarming3", 0.025,
			"BookFirstAid1", 0.1,
			"BookFirstAid2", 0.05,
			"BookFirstAid3", 0.025,
			"BookFishing1", 0.1,
			"BookFishing2", 0.05,
			"BookFishing3", 0.025,
			"BookForaging1", 0.1,
			"BookForaging2", 0.05,
			"BookForaging3", 0.025,
			"BookGlassmaking1", 0.1,
			"BookGlassmaking2", 0.05,
			"BookGlassmaking3", 0.025,
			"BookHusbandry1", 0.1,
			"BookHusbandry2", 0.05,
			"BookHusbandry3", 0.025,
			"BookLongBlade1", 0.005,
			"BookLongBlade2", 0.0025,
			"BookLongBlade3", 0.0001,
			"BookMaintenance1", 0.1,
			"BookMaintenance2", 0.05,
			"BookMaintenance3", 0.025,
			"BookMasonry1", 0.1,
			"BookMasonry2", 0.05,
			"BookMasonry3", 0.025,
			"BookMechanic1", 0.1,
			"BookMechanic2", 0.05,
			"BookMechanic3", 0.025,
			"BookMetalWelding1", 0.1,
			"BookMetalWelding2", 0.05,
			"BookMetalWelding3", 0.025,
			"BookPottery1", 0.1,
			"BookPottery2", 0.05,
			"BookPottery3", 0.025,
			"BookReloading1", 0.005,
			"BookReloading2", 0.0025,
			"BookReloading3", 0.0001,
			"BookTailoring1", 0.1,
			"BookTailoring2", 0.05,
			"BookTailoring3", 0.025,
			"BookTracking1", 0.1,
			"BookTracking2", 0.05,
			"BookTracking3", 0.025,
			"BookTrapping1", 0.1,
			"BookTrapping2", 0.05,
			"BookTrapping3", 0.025,
			-- Literature (Magazines)
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			-- Literature (Generic)
			"Book", 4,
			"Brochure", 2,
			"ChildsPictureBook", 1,
			"ComicBook", 6,
			"ComicBook_Retail", 6,
			"Doodle", 1,
			"Flier", 2,
			"Magazine_Popular", 10,
			"Paperback", 8,
			"PhotoBook", 4,
			"RPGmanual", 0.1,
			"TVMagazine", 8,
			-- Electronics/Music
			"CDplayer", 2,
			"Disc_Retail", 4,
			"Earbuds", 2,
			"Headphones", 1,
			"RadioBlack", 0.5,
			"RadioRed", 0.1,
			-- Photography
			"Camera", 0.5,
			"CameraExpensive", 0.001,
			"CameraFilm", 1,
			"PhotoAlbum", 4,
			"PhotoAlbum_Old", 0.1,
			-- VHS Tapes
			"VHS_Home", 4,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
			-- Special
			"HollowBook", 0.001,
			"SnowGlobe", 0.001,
		},
		junk = ClutterTables.ShelfJunk,
	},

	LivingRoomShelfClassy = {
		rolls = 4,
		items = {
			-- Literature (Skill Books)
			"BookAiming1", 0.005,
			"BookAiming2", 0.0025,
			"BookAiming3", 0.0001,
			"BookBlacksmith1", 0.1,
			"BookBlacksmith2", 0.05,
			"BookBlacksmith3", 0.025,
			"BookButchering1", 0.1,
			"BookButchering2", 0.05,
			"BookButchering3", 0.025,
			"BookCarpentry1", 0.1,
			"BookCarpentry2", 0.05,
			"BookCarpentry3", 0.025,
			"BookCarving1", 0.005,
			"BookCarving2", 0.0025,
			"BookCarving3", 0.0001,
			"BookCooking1", 0.1,
			"BookCooking2", 0.05,
			"BookCooking3", 0.025,
			"BookElectrician1", 0.1,
			"BookElectrician2", 0.05,
			"BookElectrician3", 0.025,
			"BookFarming1", 0.1,
			"BookFarming2", 0.05,
			"BookFarming3", 0.025,
			"BookFirstAid1", 0.1,
			"BookFirstAid2", 0.05,
			"BookFirstAid3", 0.025,
			"BookFishing1", 0.1,
			"BookFishing2", 0.05,
			"BookFishing3", 0.025,
			"BookForaging1", 0.1,
			"BookForaging2", 0.05,
			"BookForaging3", 0.025,
			"BookGlassmaking1", 0.1,
			"BookGlassmaking2", 0.05,
			"BookGlassmaking3", 0.025,
			"BookHusbandry1", 0.1,
			"BookHusbandry2", 0.05,
			"BookHusbandry3", 0.025,
			"BookLongBlade1", 0.005,
			"BookLongBlade2", 0.0025,
			"BookLongBlade3", 0.0001,
			"BookMaintenance1", 0.1,
			"BookMaintenance2", 0.05,
			"BookMaintenance3", 0.025,
			"BookMasonry1", 0.1,
			"BookMasonry2", 0.05,
			"BookMasonry3", 0.025,
			"BookMechanic1", 0.1,
			"BookMechanic2", 0.05,
			"BookMechanic3", 0.025,
			"BookMetalWelding1", 0.1,
			"BookMetalWelding2", 0.05,
			"BookMetalWelding3", 0.025,
			"BookPottery1", 0.1,
			"BookPottery2", 0.05,
			"BookPottery3", 0.025,
			"BookReloading1", 0.005,
			"BookReloading2", 0.0025,
			"BookReloading3", 0.0001,
			"BookTailoring1", 0.1,
			"BookTailoring2", 0.05,
			"BookTailoring3", 0.025,
			"BookTracking1", 0.1,
			"BookTracking2", 0.05,
			"BookTracking3", 0.025,
			"BookTrapping1", 0.1,
			"BookTrapping2", 0.05,
			"BookTrapping3", 0.025,
			-- Literature (Magazines)
			"ArmorMag4", 0.01,
			"ArmorMag5", 0.01,
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"PrimitiveToolMag1", 0.01,
			"PrimitiveToolMag2", 0.01,
			"PrimitiveToolMag3", 0.01,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			"WeaponMag6", 0.01,
			"WeaponMag7", 0.1,
			-- Literature (Generic)
			"Book_Rich", 4,
			"Brochure", 2,
			"ComicBook", 6,
			"ComicBook_Retail", 6,
			"Doodle", 1,
			"Flier", 2,
			"Magazine_Rich", 10,
			"Paperback_Rich", 8,
			"PhotoBook", 6,
			"RPGmanual", 0.1,
			"TVMagazine", 8,
			-- Electronics/Music
			"CDplayer", 2,
			"Disc_Retail", 4,
			"Earbuds", 2,
			"Headphones", 1,
			"RadioBlack", 0.5,
			"RadioRed", 0.1,
			-- Photography
			"Camera", 2,
			"CameraExpensive", 0.01,
			"CameraFilm", 2,
			"PhotoAlbum", 4,
			"PhotoAlbum_Old", 0.1,
			-- VHS Tapes
			"VHS_Home", 4,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
			-- Special
			"HollowBook_Valuables", 0.001,
			"PenFancy", 0.1,
			"SnowGlobe", 0.001,
		},
		junk = ClutterTables.ShelfJunk,
	},

	LivingRoomShelfRedneck = {
		rolls = 4,
		items = {
			-- Literature (Skill Books)
			"BookAiming1", 0.005,
			"BookAiming2", 0.0025,
			"BookAiming3", 0.0001,
			"BookBlacksmith1", 0.1,
			"BookBlacksmith2", 0.05,
			"BookBlacksmith3", 0.025,
			"BookButchering1", 0.1,
			"BookButchering2", 0.05,
			"BookButchering3", 0.025,
			"BookCarpentry1", 0.1,
			"BookCarpentry2", 0.05,
			"BookCarpentry3", 0.025,
			"BookCarving1", 0.005,
			"BookCarving2", 0.0025,
			"BookCarving3", 0.0001,
			"BookCooking1", 0.1,
			"BookCooking2", 0.05,
			"BookCooking3", 0.025,
			"BookElectrician1", 0.1,
			"BookElectrician2", 0.05,
			"BookElectrician3", 0.025,
			"BookFarming1", 0.1,
			"BookFarming2", 0.05,
			"BookFarming3", 0.025,
			"BookFirstAid1", 0.1,
			"BookFirstAid2", 0.05,
			"BookFirstAid3", 0.025,
			"BookFishing1", 0.1,
			"BookFishing2", 0.05,
			"BookFishing3", 0.025,
			"BookForaging1", 0.1,
			"BookForaging2", 0.05,
			"BookForaging3", 0.025,
			"BookGlassmaking1", 0.1,
			"BookGlassmaking2", 0.05,
			"BookGlassmaking3", 0.025,
			"BookHusbandry1", 0.1,
			"BookHusbandry2", 0.05,
			"BookHusbandry3", 0.025,
			"BookLongBlade1", 0.005,
			"BookLongBlade2", 0.0025,
			"BookLongBlade3", 0.0001,
			"BookMaintenance1", 0.1,
			"BookMaintenance2", 0.05,
			"BookMaintenance3", 0.025,
			"BookMasonry1", 0.1,
			"BookMasonry2", 0.05,
			"BookMasonry3", 0.025,
			"BookMechanic1", 0.1,
			"BookMechanic2", 0.05,
			"BookMechanic3", 0.025,
			"BookMetalWelding1", 0.1,
			"BookMetalWelding2", 0.05,
			"BookMetalWelding3", 0.025,
			"BookPottery1", 0.1,
			"BookPottery2", 0.05,
			"BookPottery3", 0.025,
			"BookReloading1", 0.005,
			"BookReloading2", 0.0025,
			"BookReloading3", 0.0001,
			"BookTailoring1", 0.1,
			"BookTailoring2", 0.05,
			"BookTailoring3", 0.025,
			"BookTracking1", 0.1,
			"BookTracking2", 0.05,
			"BookTracking3", 0.025,
			"BookTrapping1", 0.1,
			"BookTrapping2", 0.05,
			"BookTrapping3", 0.025,
			-- Literature (Magazines)
			"ArmorMag3", 0.001,
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"HempMag1", 0.05,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			"WeaponMag4", 0.001,
			"WeaponMag7", 0.1,
			-- Literature (Generic)
			"Book_Bible", 1,
			"Book_Rich", 4,
			"Brochure", 2,
			"ComicBook", 6,
			"ComicBook_Retail", 6,
			"Doodle", 1,
			"Flier", 2,
			"Magazine_Popular", 10,
			"Paperback_Poor", 8,
			"PhotoBook", 2,
			"RPGmanual", 0.1,
			"TVMagazine", 8,
			-- Photography
			"Camera", 0.5,
			"CameraDisposable", 2,
			"CameraFilm", 1,
			"PhotoAlbum", 4,
			"PhotoAlbum_Old", 0.1,
			-- Electronics/Music
			"CDplayer", 2,
			"Disc_Retail", 4,
			"Earbuds", 2,
			"Headphones", 1,
			"RadioBlack", 0.5,
			"RadioRed", 0.1,
			-- VHS Tapes
			"VHS_Home", 4,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
			-- Special
			"Firecracker", 0.01,
			"HollowBook", 0.001,
			"SnowGlobe", 0.001,
		},
		junk = ClutterTables.ShelfJunk,
	},

	LivingRoomShelfNoTapes = {
		rolls = 2,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Generic filler like pens/pencils are in SideTableJunk.
	LivingRoomSideTable = {
		rolls = 4,
		items = {
			-- Literature (Generic)
			"Brochure", 4,
			"ComicBook", 2,
			"Doodle", 1,
			"Flier", 4,
			"GenericMail", 8,
			"Magazine", 4,
			"Magazine_Popular", 4,
			"Paperback", 4,
			"Phonebook", 4,
			"PhotoBook", 4,
			"Postcard", 4,
			-- Literature (Magazines)
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			-- Eyewear
			"Glasses_Aviators", 0.5,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.05,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Reading", 1,
			"Glasses_Sun", 1,
			-- Photography
			"Camera", 0.5,
			"CameraExpensive", 0.001,
			"PhotoAlbum", 4,
			"PhotoAlbum_Old", 0.1,
			-- Electronics/Music
			"CordlessPhone", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Headphones", 1,
			"PowerBar", 4,
			"Remote", 20,
			"WalkieTalkie1", 0.5,
			"WalkieTalkie2", 0.1,
			"WalkieTalkie3", 0.05,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			-- Misc
			"Doily", 4,
			-- Special
			"CigarBox_Keepsakes", 0.001,
			"HollowBook", 0.001,
			"KnifePocket", 0.1,
			"PencilSpiffo", 0.001,
			"PenFancy", 0.05,
			"PenSpiffo", 0.001,
		},
		junk = ClutterTables.SideTableJunk,
	},

	LivingRoomSideTableClassy = {
		rolls = 4,
		items = {
			-- Literature (Generic)
			"Brochure", 4,
			"Catalog", 4,
			"ComicBook", 2,
			"Doodle", 1,
			"Flier", 4,
			"GenericMail", 8,
			"Magazine_Business", 2,
			"Magazine_Rich", 4,
			"Paperback_Business", 1,
			"Paperback_Legal", 1,
			"Paperback_Rich", 2,
			"Phonebook", 4,
			"PhotoBook", 6,
			-- Literature (Magazines)
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			-- Photography
			"Camera", 1,
			"CameraExpensive", 0.5,
			"PhotoAlbum", 4,
			"PhotoAlbum_Old", 0.1,
			-- Electronics/Music
			"CordlessPhone", 4,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Headphones", 1,
			"PowerBar", 4,
			"Remote", 20,
			"WalkieTalkie1", 0.5,
			"WalkieTalkie2", 0.1,
			"WalkieTalkie3", 0.05,
			-- Eyewear
			"Glasses_Aviators", 0.5,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.05,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Reading", 1,
			"Glasses_Sun", 1,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			"WristWatch_Left_Expensive", 0.01,
			-- Misc
			"Doily", 8,
			-- Special
			"Flask", 0.1,
			"HollowBook_Valuables", 0.001,
			"KeyRing_WestMaple", 0.1,
			"KnifePocket", 0.1,
			"PencilSpiffo", 0.001,
			"PenFancy", 4,
			"PenSpiffo", 0.001,
			"Pocketwatch", 0.5,
			"StockCertificate", 10,
		},
		junk = ClutterTables.SideTableJunk,
	},

	LivingRoomSideTableRedneck = {
		rolls = 4,
		items = {
			-- Literature (Generic)
			"Book_Bible", 0.1,
			"Brochure", 4,
			"Catalog", 4,
			"ComicBook", 2,
			"Doodle", 1,
			"Flier", 4,
			"GenericMail", 4,
			"Magazine_Car", 2,
			"Magazine_Outdoors", 4,
			"Magazine_Sports", 1,
			"Paperback_Bible", 1,
			"Paperback_Poor", 2,
			"Phonebook", 4,
			"PhotoBook", 2,
			-- Literature (Magazines)
			"ArmorMag3", 0.001,
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"HempMag1", 0.05,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			"WeaponMag4", 0.001,
			"WeaponMag7", 0.1,
			-- Eyewear
			"Glasses_Aviators", 0.5,
			"Glasses_Cosmetic_Normal", 0.1,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.05,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Reading", 1,
			"Glasses_Sun", 1,
			-- Photography
			"Camera", 0.1,
			"PhotoAlbum", 4,
			"PhotoAlbum_Old", 0.1,
			-- Electronics/Music
			"CordlessPhone", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Headphones", 1,
			"PowerBar", 4,
			"Remote", 20,
			"WalkieTalkie1", 0.5,
			"WalkieTalkie2", 0.1,
			"WalkieTalkie3", 0.05,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicMilitary", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			-- Misc
			"Doily", 4,
			-- Special
			"CanteenMilitary", 0.1,
			"Firecracker", 0.01,
			"Handiknife", 0.1,
			"Hat_Bandana", 0.2,
			"HollowBook", 0.001,
			"HottieZ", 0.1,
			"KnifeButterfly", 1,
			"KnifePocket", 0.1,
			"LargeKnife", 0.1,
			"Multitool", 0.001,
			"PencilSpiffo", 0.001,
			"PenSpiffo", 0.001,
			"TobaccoChewing", 0.1,
			"TobaccoLoose", 0.1,
		},
		junk = ClutterTables.SideTableJunk,
	},

	LivingRoomSideTableNoRemote = {
		rolls = 4,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	LivingRoomWardrobe = {
		rolls = 2,
		items = {
			"BackgammonBoard", 2,
			"Bag_FluteCase", 4,
			"Bag_SaxophoneCase", 4,
			"Bag_TrumpetCase", 4,
			"BaseballBat", 0.1,
			"BaseballBat_Metal", 0.1,
			"Bikini_Pattern01", 0.2,
			"Bikini_TINT", 0.2,
			"BluePen", 8,
			"Book", 4,
			"BookAiming1", 0.005,
			"BookAiming2", 0.0025,
			"BookAiming3", 0.0001,
			"BookBlacksmith1", 0.1,
			"BookBlacksmith2", 0.05,
			"BookBlacksmith3", 0.025,
			"BookButchering1", 0.1,
			"BookButchering2", 0.05,
			"BookButchering3", 0.025,
			"BookCarpentry1", 0.1,
			"BookCarpentry2", 0.05,
			"BookCarpentry3", 0.025,
			"BookCarving1", 0.005,
			"BookCarving2", 0.0025,
			"BookCarving3", 0.0001,
			"BookCooking1", 0.1,
			"BookCooking2", 0.05,
			"BookCooking3", 0.025,
			"BookElectrician1", 0.1,
			"BookElectrician2", 0.05,
			"BookElectrician3", 0.025,
			"BookFarming1", 0.1,
			"BookFarming2", 0.05,
			"BookFarming3", 0.025,
			"BookFirstAid1", 0.1,
			"BookFirstAid2", 0.05,
			"BookFirstAid3", 0.025,
			"BookFishing1", 0.1,
			"BookFishing2", 0.05,
			"BookFishing3", 0.025,
			"BookForaging1", 0.1,
			"BookForaging2", 0.05,
			"BookForaging3", 0.025,
			"BookGlassmaking1", 0.1,
			"BookGlassmaking2", 0.05,
			"BookGlassmaking3", 0.025,
			"BookHusbandry1", 0.1,
			"BookHusbandry2", 0.05,
			"BookHusbandry3", 0.025,
			"BookLongBlade1", 0.005,
			"BookLongBlade2", 0.0025,
			"BookLongBlade3", 0.0001,
			"BookMaintenance1", 0.1,
			"BookMaintenance2", 0.05,
			"BookMaintenance3", 0.025,
			"BookMasonry1", 0.1,
			"BookMasonry2", 0.05,
			"BookMasonry3", 0.025,
			"BookMechanic1", 0.1,
			"BookMechanic2", 0.05,
			"BookMechanic3", 0.025,
			"BookMetalWelding1", 0.1,
			"BookMetalWelding2", 0.05,
			"BookMetalWelding3", 0.025,
			"BookPottery1", 0.1,
			"BookPottery2", 0.05,
			"BookPottery3", 0.025,
			"BookReloading1", 0.005,
			"BookReloading2", 0.0025,
			"BookReloading3", 0.0001,
			"BookTailoring1", 0.1,
			"BookTailoring2", 0.05,
			"BookTailoring3", 0.025,
			"BookTracking1", 0.1,
			"BookTracking2", 0.05,
			"BookTracking3", 0.025,
			"BookTrapping1", 0.1,
			"BookTrapping2", 0.05,
			"BookTrapping3", 0.025,
			"Briefcase", 0.2,
			"Brochure", 2,
			"CardDeck", 2,
			"Catalog", 8,
			"CDplayer", 1,
			"CheckerBoard", 2,
			"ChessBlack", 2,
			"ChessWhite", 2,
			"ClosedUmbrellaBlack", 0.1,
			"ClosedUmbrellaBlue", 0.1,
			"ClosedUmbrellaRed", 0.1,
			"ClosedUmbrellaWhite", 0.1,
			"ClosedUmbrellaTINTED", 0.2,
			"ComicBook", 4,
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"Cooler", 0.1,
			"Disc_Retail", 2,
			"Doodle", 1,
			"Earbuds", 1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"Eraser", 8,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"Flask", 0.1,
			"Flier", 2,
			"Flightcase", 0.01,
			"Flute", 0.02,
			"GamePieceBlack", 2,
			"GamePieceRed", 2,
			"GamePieceWhite", 2,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"Gloves_FingerlessGloves", 0.1,
			"Gloves_LeatherGloves", 0.05,
			"Gloves_LeatherGlovesBlack", 0.05,
			"Gloves_LongWomenGloves", 0.1,
			"Gloves_WhiteTINT", 0.1,
			"GuitarAcoustic", 0.01,
			"Guitarcase", 0.01,
			"GuitarElectricBass", 0.01,
			"GuitarElectric", 0.01,
			"Handbag", 0.5,
			"Headphones", 1,
			"HerbalistMag", 0.1,
			"HollowBook", 0.001,
			"HoodieDOWN_WhiteTINT", 1,
			"HotWaterBottleEmpty", 2,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"JacketLong_Random", 0.5,
			"Jacket_Leather", 0.5,
			"Jacket_Shellsuit_Black", 0.05,
			"Jacket_Shellsuit_Blue", 0.05,
			"Jacket_Shellsuit_Green", 0.05,
			"Jacket_Shellsuit_Pink", 0.05,
			"Jacket_Shellsuit_Teal", 0.05,
			"Jacket_Shellsuit_TINT", 0.2,
			"Jacket_WhiteTINT", 0.5,
			"Keytar", 0.01,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"Magazine_Popular", 10,
			"MagazineCrossword", 4,
			"MagazineWordsearch", 4,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"Mov_HuntingTrophy", 0.01,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Notebook", 10,
			"Paperback", 8,
			"Pen", 8,
			"Pencil", 10,
			"Phonebook", 4,
			"PhotoAlbum", 8,
			"PokerChips", 2,
			"Purse", 0.5,
			"RadioBlack", 2,
			"RadioRed", 1,
			"RedPen", 8,
			"RPGmanual", 0.1,
			"Saxophone", 0.01,
			"SheetPaper2", 10,
			"Shirt_Baseball_KY", 0.5,
			"Shirt_Baseball_Rangers", 0.5,
			"Shirt_Baseball_Z", 0.5,
			"Shorts_LongSport", 1,
			"Shorts_ShortSport", 1,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			"SnowGlobe", 0.001,
			"Sportsbottle", 0.1,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"TissueBox", 4,
			"Toolbox", 2,
			"Trousers_Sport", 0.5,
			"Trumpet", 0.01,
			"Tshirt_LongSleeve_SuperColor", 0.5,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_Sport", 0.5,
			"Tshirt_SportDECAL", 0.5,
			"Tshirt_SuperColor", 0.5,
			"Tshirt_TieDye", 0.5,
			"TVMagazine", 8,
			"VHS_Home", 4,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
			"VideoGame", 2,
			"WalkieTalkie1", 1,
			"Whistle", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
			}
		}
	},

	Locker = {
		rolls = 4,
		items = {
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_NormalHikingBag", 0.1,
			"Bag_Satchel", 0.2,
			"BluePen", 8,
			"Calculator", 1,
			"CDplayer", 1,
			"Clipboard", 8,
			"Disc_Retail", 2,
			"Doodle", 1,
			"Dress_Knees", 1,
			"Dress_Long", 1,
			"Dress_Normal", 1,
			"Earbuds", 1,
			"Eraser", 8,
			"Flask", 0.1,
			"GreenPen", 4,
			"Handbag", 0.5,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.1,
			"Hat_Beret", 0.5,
			"Hat_BucketHat", 0.1,
			"Headphones", 1,
			"HoodieDOWN_WhiteTINT", 1,
			"JacketLong_Random", 0.5,
			"Jacket_Leather", 0.5,
			"Jacket_WhiteTINT", 0.5,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"MagazineCrossword", 4,
			"MagazineWordsearch", 4,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Notebook", 10,
			"Notepad", 8,
			"Paperback", 8,
			"Paperclip", 10,
			"PaperclipBox", 1,
			"Pen", 8,
			"Pencil", 10,
			"Photo", 2,
			"Purse", 0.5,
			"RedPen", 8,
			"RubberBand", 6,
			"SheetPaper2", 10,
			"Shoes_Random", 2,
			"Shoes_TrainerTINT", 2,
			"Shorts_LongDenim", 1,
			"Skirt_Knees", 1,
			"Skirt_Long", 1,
			"Skirt_Normal", 1,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Long_White", 2,
			"Sportsbottle", 0.1,
			"Trousers", 2,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_HUE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_WhiteTINT", 2,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"TVMagazine", 4,
			"Vest_DefaultTEXTURE_TINT", 1,
			"WalkieTalkie2", 0.5,
			"WalkieTalkie3", 0.1,
			"Whistle", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	LockerArmyBedroom = {
		rolls = 4,
		items = {
			"9mmClip", 0.1,
			"556Box", 0.1,
			"556Clip", 0.1,
			"AssaultRifle", 0.001,
			"Bag_ALICE_BeltSus_Camo", 0.1,
			"Bag_ALICE_BeltSus_Green", 0.1,
			"Bag_ALICEpack_Army", 0.05,
			"Bag_Military", 0.1,
			"Bag_ProtectiveCaseMilitary", 1,
			"Bag_ProtectiveCaseSmallMilitary_FirstAid", 4,
			"Bag_ProtectiveCaseSmallMilitary_Pistol1", 0.4,
			"Bag_RifleCaseGreen", 0.0025,
			"BeefJerky", 1,
			"Belt2", 1,
			"BookAiming1", 1,
			"BookAiming2", 0.5,
			"BookAiming3", 0.1,
			"BookReloading1", 1,
			"BookReloading2", 0.5,
			"BookReloading3", 0.1,
			"Bullets9mmBox", 0.1,
			"CanteenMilitary", 2,
			"CDplayer", 1,
			"DehydratedMeatStick", 1,
			"Diary2", 1,
			"Disc_Retail", 1,
			"Earbuds", 1,
			"ElbowPad_Left_Military", 0.1,
			"EntrenchingTool", 1,
			"FlashLight_AngleHead_Army", 1,
			"GasmaskFilter", 2,
			"Glasses_Aviators", 1,
			"Glasses_Sun", 2,
			"HandTorch", 2,
			"Hat_Army", 0.1,
			"Hat_BaseballCapArmy", 1,
			"Hat_BeretArmy", 1,
			"Hat_EarMuff_Protectors", 0.5,
			"Hat_GasMask", 0.5,
			"Hat_PeakedCapArmy", 1,
			"HolsterSimple_Green", 2,
			"HottieZ", 1,
			"HuntingKnife", 1,
			"KnifePocket", 0.1,
			"Jacket_ArmyCamoGreen", 2,
			"Jacket_CoatArmy", 2,
			"Kneepad_Left_Military", 0.5,
			"Magazine", 2,
			"Magazine_Popular", 2,
			"Magazine_Military", 2,
			"Mirror", 1,
			"Money", 4,
			"P38", 1,
			"Paperback", 4,
			"PillsVitamins", 1,
			"Pistol2", 0.1,
			"PonchoGreenDOWN", 2,
			"Razor", 1,
			"ShemaghScarf_Green", 0.001,
			"Shirt_CamoDesert", 0.5,
			"Shirt_CamoGreen", 2,
			"Shirt_CamoUrban", 0.5,
			"Shoes_ArmyBoots", 1,
			"SleepingBag_Camo_Packed", 2,
			"Soap2", 0.5,
			"TobaccoChewing", 1,
			"ToiletPaper", 2,
			"Trousers_ArmyService", 2,
			"Trousers_CamoDesert", 0.5,
			"Trousers_CamoGreen", 2,
			"Trousers_CamoUrban", 0.5,
			"Tshirt_ArmyGreen", 2,
			"Tshirt_CamoDesert", 0.5,
			"Tshirt_CamoGreen", 2,
			"Tshirt_CamoUrban", 0.5,
			"Tshirt_Profession_VeterenGreen", 2,
			"Tshirt_Profession_VeterenRed", 2,
			"Vest_BulletArmy", 0.1,
			"WalkieTalkie5", 1,
			"Whetstone", 1,
			"WristWatch_Left_ClassicMilitary", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	LockerArmyBedroomHome = {
		rolls = 4,
		items = {
			"AssaultRifle2", 0.001,
			"Bag_ALICEpack_Army", 0.05,
			"Bag_BigHikingBag", 0.1,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Military", 0.1,
			"Bag_NormalHikingBag", 0.5,
			"BaseballBat", 0.5,
			"BaseballBat_Metal", 0.5,
			"Belt2", 1,
			"BookAiming1", 1,
			"BookAiming2", 0.5,
			"BookAiming3", 0.1,
			"BookReloading1", 1,
			"BookReloading2", 0.5,
			"BookReloading3", 0.1,
			"CanteenMilitary", 2,
			"CDplayer", 1,
			"Diary2", 1,
			"FirstAidKit_Military", 0.5,
			"Glasses_Aviators", 1,
			"Glasses_Sun", 2,
			"Disc_Retail", 1,
			"Dungarees", 0.5,
			"Earbuds", 1,
			"ElbowPad_Left_Military", 0.1,
			"EntrenchingTool", 1,
			"FlashLight_AngleHead_Army", 1,
			"GasmaskFilter", 2,
			"Gloves_FingerlessGloves", 0.1,
			"Gloves_LeatherGloves", 0.05,
			"Gloves_LeatherGlovesBlack", 0.05,
			"HandTorch", 2,
			"Hat_Army", 0.1,
			"Hat_Bandana", 1,
			"Hat_BaseballCapArmy", 1,
			"Hat_BeretArmy", 1,
			"Hat_BonnieHat", 1,
			"Hat_BonnieHat_CamoGreen", 1,
			"Hat_EarMuff_Protectors", 0.5,
			"Hat_GasMask", 0.5,
			"Hat_PeakedCapArmy", 1,
			"HolsterDouble", 1,
			"HolsterShoulder", 0.5,
			"HolsterSimple_Green", 2,
			"HottieZ", 1,
			"HuntingKnife", 1,
			"Kneepad_Left_Military", 0.5,
			"KnifePocket", 0.1,
			"Jacket_ArmyCamoGreen", 2,
			"Jacket_CoatArmy", 2,
			"Jacket_PaddedDOWN", 1,
			"LongJohns", 0.5,
			"LongJohns_Bottoms", 0.5,
			"Magazine_Firearm", 4,
			"Magazine_Military", 8,
			"MilitaryMedal", 1,
			"Money", 4,
			"Paperback_Fantasy", 2,
			"Paperback_SciFi", 2,
			"Pistol", 0.5,
			"Pistol2", 0.1,
			"Pistol3", 0.05,
			"PonchoGreenDOWN", 0.4,
			"Revolver", 0.1,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			"ShemaghScarf_Green", 0.01,
			"Shirt_CamoDesert", 0.5,
			"Shirt_CamoGreen", 2,
			"Shirt_CamoUrban", 0.5,
			"Shirt_Denim", 1,
			"Shirt_HawaiianTINT", 0.5,
			"Shirt_Lumberjack", 1,
			"Shirt_Lumberjack_TINT", 1,
			"Shoes_ArmyBoots", 1,
			"Shoes_Wellies", 1,
			"Shorts_CamoGreenLong", 1,
			"Shorts_CamoUrbanLong", 0.5,
			"Shotgun", 0.01,
			"SleepingBag_Camo_Packed", 2,
			"TobaccoChewing", 1,
			"Trousers_ArmyService", 2,
			"Trousers_CamoDesert", 0.5,
			"Trousers_CamoGreen", 2,
			"Trousers_CamoUrban", 0.5,
			"Tshirt_ArmyGreen", 2,
			"Tshirt_CamoDesert", 0.5,
			"Tshirt_CamoGreen", 2,
			"Tshirt_CamoUrban", 0.5,
			"Tshirt_Profession_VeterenGreen", 2,
			"Tshirt_Profession_VeterenRed", 2,
			"Tshirt_Rock", 1,
			"VarmintRifle", 0.05,
			"Vest_BulletArmy", 0.1,
			"Vest_DefaultTEXTURE_TINT", 2,
			"WalkieTalkie5", 1,
			"Whetstone", 1,
			"Whistle", 1,
			"WristWatch_Left_ClassicMilitary", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"CombinationPadlock", 10,
				"Necklace_DogTag", 10,
				"Padlock", 1,
			}
		}
	},

	LockerClassy = {
		rolls = 4,
		items = {
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_GolfBag", 0.5,
			"Bag_MoneyBag", 0.001,
			"Bag_NormalHikingBag", 0.1,
			"Bag_Satchel", 0.2,
			"BluePen", 8,
			"BottleOpener", 1,
			"BusinessCard", 4,
			"Briefcase_Money", 0.001,
			"Calculator", 1,
			"CameraExpensive", 10,
			"CameraFilm", 10,
			"CDplayer", 1,
			"Clipboard", 8,
			"Corkscrew", 1,
			"CreditCard", 10,
			"Diary2", 1,
			"Disc_Retail", 2,
			"Doodle", 1,
			"Earbuds", 1,
			"Flask", 0.1,
			"GreenPen", 4,
			"Gum", 10,
			"Handbag", 0.5,
			"Hat_Fedora", 0.5,
			"Hat_Fedora_Delmonte", 0.5,
			"Hat_GolfHatTINT", 0.2,
			"Hat_PeakedCapYacht", 0.001,
			"Headphones", 1,
			"Jacket_Leather", 0.5,
			"Jacket_WhiteTINT", 0.5,
			"Jumper_DiamondPatternTINT", 0.5,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"Magazine_Business", 4,
			"Magazine_Rich", 8,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Money", 20,
			"Money", 10,
			"MoneyBundle", 1,
			"Notepad", 8,
			"Paperback_Business", 4,
			"Paperback_Rich", 8,
			"Pen", 8,
			"PenFancy", 4,
			"Purse", 0.5,
			"RedPen", 8,
			"Shirt_FormalTINT", 2,
			"Shirt_FormalTINT", 2,
			"Shirt_FormalWhite", 2,
			"Shirt_FormalWhite", 2,
			"Shirt_FormalWhite_ShortSleeve", 0.5,
			"Shirt_FormalWhite_ShortSleeveTINT", 0.5,
			"Shoes_Random", 2,
			"Shoes_Random", 2,
			"Socks_Ankle", 1,
			"Socks_Ankle_Black", 4,
			"Socks_Ankle_White", 2,
			"Socks_Long", 1,
			"Socks_Ankle_Black", 4,
			"Socks_Long_White", 2,
			"Sportsbottle", 0.1,
			"StockCertificate", 10,
			"Suit_Jacket", 1,
			"Suit_Jacket", 1,
			"Suit_JacketTINT", 1,
			"Suit_JacketTINT", 1,
			"Tie_BowTieFull", 0.5,
			"Tie_BowTieWorn", 0.5,
			"Tie_Full", 0.5,
			"Tie_Worn", 0.5,
			"Trousers", 2,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_HUE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Suit", 2,
			"Trousers_Suit", 2,
			"Trousers_SuitTEXTURE", 2,
			"Trousers_SuitTEXTURE", 2,
			"Trousers_SuitWhite", 1,
			"Trousers_WhiteTINT", 2,
			"Tshirt_PoloStripedTINT", 2,
			"Tshirt_PoloTINT", 2,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Vest_DefaultTEXTURE_TINT", 1,
			"WalkieTalkie2", 1,
			"WalkieTalkie3", 0.5,
			"Whistle", 0.1,
			"Wine", 1,
			"WristWatch_Left_Expensive", 0.01,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	LoggingFactoryTools = {
		rolls = 4,
		items = {
			-- Mechanics/Towing
			"HeavyChain", 10,
			"HeavyChain_Hook", 2,
			"Jack", 2,
			"LargeHook", 6,
			"LugWrench", 4,
			"Screwdriver", 10,
			"TireIron", 4,
			"Wrench", 8,
			-- Axes
			"HandAxe", 8,
			"WoodAxe", 4,
			-- Tools - Carpentry
			"CarpentryChisel", 10,
			"GardenSaw", 8,
			"HandAxe", 6,
			"HandDrill", 8,
			"OldDrill", 2,
			"Saw", 4,
			"ViseGrips", 4,
			-- Tools - Other
			"Crowbar", 4,
			"Hammer", 8,
			"PickAxe", 1,
			"PipeWrench", 6,
			"Pliers", 8,
			"Shovel", 8,
			"Shovel2", 8,
			"Sledgehammer", 0.1,
			"Sledgehammer2", 0.1,
			"Whetstone", 10,
			-- Accessories
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 6,
			"Gloves_LeatherGloves", 2,
			"Hat_EarMuff_Protectors", 4,
			"Hat_HardHat", 8,
			"Kneepad_Left_Workman", 4,
			-- Materials
			"Handle", 8,
			"LongHandle", 4,
			"LongStick", 4,
			"Rope", 50,
			"Rope", 20,
			"RopeStack", 1,
			"SmallHandle", 8,
			"Tarp", 10,
			"WoodenStick2", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"MeasuringTape", 10,
				"Splinters", 20,
				"Splinters", 20,
				"Splinters", 10,
				"Splinters", 10,
			}
		}
	},

	MagazineRackBrochure = {
		rolls = 4,
		items = {
			"Brochure", 50,
			"Brochure", 20,
			"Brochure", 20,
			"Brochure", 10,
			"Brochure", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MagazineRackCards = {
		rolls = 4,
		items = {
			"Card_Birthday", 20,
			"Card_Birthday", 10,
			"Card_Christmas", 8,
			"Card_Easter", 8,
			"Card_Halloween", 8,
			"Card_Hanukkah", 8,
			"Card_LunarYear", 8,
			"Card_StPatrick", 8,
			"Card_Sympathy", 20,
			"Card_Sympathy", 10,
			"Card_Valentine", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MagazineRackMaps = {
		rolls = 4,
		items = {
			"Base.LouisvilleMap1", 1,
			"Base.LouisvilleMap2", 1,
			"Base.LouisvilleMap3", 1,
			"Base.LouisvilleMap4", 1,
			"Base.LouisvilleMap5", 1,
			"Base.LouisvilleMap6", 1,
			"Base.LouisvilleMap7", 1,
			"Base.LouisvilleMap8", 1,
			"Base.LouisvilleMap9", 1,
			"Base.MuldraughMap", 8,
			"Base.WestpointMap", 8,
			"Base.MarchRidgeMap", 8,
			"Base.RosewoodMap", 8,
			"Base.RiversideMap", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MagazineRackMixed = {
		rolls = 4,
		items = {
			"Brochure", 20,
			"Brochure", 10,
			"ComicBook_Retail", 20,
			"ComicBook_Retail", 20,
			"ComicBook_Retail", 10,
			"ComicBook_Retail", 10,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"Flier", 20,
			"Flier", 10,
			"GlassmakingMag1", 0.5,
			"GlassmakingMag2", 0.5,
			"GlassmakingMag3", 0.5,
			"HempMag1", 0.5,
			"HerbalistMag", 1,
			"HottieZ_New", 0.5,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"Magazine_Art_New", 4,
			"Magazine_Business_New", 4,
			"Magazine_Car_New", 4,
			"Magazine_Childs_New", 4,
			"Magazine_Cinema_New", 4,
			"Magazine_Crime_New", 4,
			"Magazine_Fashion_New", 4,
			"Magazine_Firearm_New", 4,
			"Magazine_Golf_New", 4,
			"Magazine_Health_New", 8,
			"Magazine_Hobby_New", 8,
			"Magazine_Horror_New", 4,
			"Magazine_Humor_New", 4,
			"Magazine_Military_New", 1,
			"Magazine_Music_New", 4,
			"Magazine_Outdoors_New", 4,
			"Magazine_Police_New", 1,
			"Magazine_Rich_New", 1,
			"Magazine_Science_New", 4,
			"Magazine_Sports_New", 4,
			"Magazine_Tech_New", 4,
			"Magazine_Teens_New", 4,
			"MagazineCrossword", 10,
			"MagazineWordsearch", 10,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkMag1", 1,
			"MetalworkMag2", 1,
			"MetalworkMag3", 1,
			"MetalworkMag4", 1,
			"Paperback", 4,
			"SmithingMag1", 0.1,
			"SmithingMag2", 0.1,
			"SmithingMag3", 0.1,
			"SmithingMag4", 0.1,
			"SmithingMag5", 0.1,
			"SmithingMag6", 0.1,
			"SmithingMag7", 0.1,
			"SmithingMag8", 0.1,
			"SmithingMag9", 0.1,
			"SmithingMag10", 0.1,
			"SmithingMag11", 0.1,
			"TVMagazine_New", 20,
			"TVMagazine_New", 10,
			"WeaponMag4", 0.01,
			"WeaponMag7", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MagazineRackNewspaper = {
		rolls = 4,
		items = {
			"Newspaper_New", 50,
			"Newspaper_New", 20,
			"Newspaper_New", 20,
			"Newspaper_New", 10,
			"Newspaper_New", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MagazineRackPaperback = {
		rolls = 4,
		items = {
			"Paperback_CrimeFiction", 8,
			"Paperback_Diet", 8,
			"Paperback_Fashion", 8,
			"Paperback_Medical", 8,
			"Paperback_NewAge", 8,
			"Paperback_Relationship", 8,
			"Paperback_Romance", 20,
			"Paperback_Romance", 10,
			"Paperback_SelfHelp", 8,
			"Paperback_Thriller", 8,
			"Paperback_Travel", 8,
			"Paperback_TrueCrime", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MannequinFactoryPaint = {
		rolls = 4,
		items = {
			-- Tools
			"Paintbrush", 50,
			"Paintbrush", 20,
			-- Paint
			"PaintWhite", 50,
			"PaintWhite", 20,
			"PaintWhite", 20,
			"PaintWhite", 10,
			-- Outfit
			"Boilersuit", 8,
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 8,
			"Gloves_LeatherGloves", 1,
			"Hat_BuildersRespirator", 8,
			"Hat_HardHat", 1,
			"Kneepad_Left_Workman", 4,
			-- Misc.
			"RespiratorFilters", 4,
			"RippedSheets", 20,
			"RippedSheets", 10,
		},
		junk = {
			rolls = 1,
			items = {
				-- Misc.
				"MeasuringTape", 10,
				"RippedSheetsDirty", 50,
				"RippedSheetsDirty", 20,
				-- Trash
				"Splinters", 8,
				"UnusableWood", 4,
			}
		}
	},

	-- Same as CabinetFactoryTools until I get the components for this.
	MannequinFactoryTools = {
		rolls = 4,
		items = {
			-- Tools
			"CarpentryChisel", 10,
			"ClubHammer", 8,
			"Crowbar", 4,
			"GardenSaw", 10,
			"Hammer", 10,
			"HandAxe", 2,
			"HandDrill", 8,
			"Hinge", 8,
			"OldDrill", 1,
			"Paintbrush", 4,
			"Pliers", 8,
			"Saw", 8,
			"Screwdriver", 10,
			"ViseGrips", 4,
			"WoodenMallet", 8,
			-- Clothing
			"Boilersuit", 1,
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 4,
			"Hat_BuildersRespirator", 1,
			"Hat_DustMask", 4,
			"Hat_HardHat", 1,
			"Kneepad_Left_Workman", 4,
			-- Materials
			"CircularSawblade", 20,
			"CircularSawblade", 10,
			"DuctTape", 8,
			"Epoxy", 2,
			"Handle", 8,
			"NailsBox", 8,
			"NailsCarton", 0.5,
			"NutsBolts", 8,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.5,
			"SmallHandle", 8,
			"Whetstone", 10,
			"Woodglue", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"MagnifyingGlass", 10,
				"MeasuringTape", 10,
				"SteelWool", 10,
			}
		}
	},

	-- Need to hash out what kind of books this dude would keep in his office.
	MayorWestPointBooks = {
		rolls = 4,
		items = {
			"Book_History", 20,
			"Book_History", 10,
			"Book_Legal", 50,
			"Book_Legal", 20,
			"Book_Politics", 50,
			"Book_Politics", 20,
			"BookFancy_History", 1,
			"BookFancy_Legal", 4,
			"BookFancy_Politics", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Copy of generic office desk for now.
	MayorWestPointDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Literature
			"Book_Business", 1,
			"IndexCard", 10,
			"Magazine_Rich", 4,
			"MenuCard", 10,
			"Paperback_Business", 2,
			"Paperback_Fiction", 1,
			"Paperwork", 20,
			"Paperwork", 10,
			"StockCertificate", 1,
			-- Misc.
			"Gum", 4,
			"CreditCard", 8,
			"PillsVitamins", 0.1,
			-- Special
			"Cashbox", 0.1,
			"CigarBox", 0.05,
			"Diary2", 0.1,
			"Flask", 0.1,
			"MoneyBundle", 0.01,
		},
		junk = ClutterTables.DeskJunk,
	},

	-- Waiting on tiledef. Also need to figure out what the Mayor is likely to keep in here.
	MayorWestPointSafe = {
		rolls = 4,
		items = {

		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Meat = {
		rolls = 1,
		items = {
			-- DEPRECATED
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicOutfit = {
		rolls = 4,
		items = {
			"Boilersuit_BlueRed", 20,
			"BookMechanic1", 6,
			"BookMechanic2", 4,
			"BookMechanic3", 2,
			"BookMechanic4", 1,
			"BookMechanic5", 0.5,
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 8,
			"Gloves_LeatherGloves", 1,
			"Handiknife", 1,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_EarMuff_Protectors", 8,
			"Kneepad_Left_Workman", 4,
			"KnifePocket", 1,
			"MarkerBlack", 4,
			"MechanicMag1", 2,
			"MechanicMag2", 2,
			"MechanicMag3", 2,
			"Multitool", 0.01,
			"Notepad", 10,
			"Pencil", 10,
			"RippedSheets", 10,
			"Shoes_TrainerTINT", 8,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Tshirt_DefaultTEXTURE_TINT", 6,
			"Vest_DefaultTEXTURE_TINT", 6,
			"WeldingMask", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicTools = {
		rolls = 4,
		items = {
			"BlowerFan", 1,
			"BlowTorch", 8,
			"BoltCutters", 8,
			"BookMechanic1", 6,
			"BookMechanic2", 4,
			"BookMechanic3", 2,
			"BookMechanic4", 1,
			"BookMechanic5", 0.5,
			"Calipers", 2,
			"Epoxy", 4,
			"FiberglassTape", 4,
			"File", 4,
			"Funnel", 10,
			"Handiknife", 1,
			"HandDrill", 4,
			"HandTorch", 8,
			"Jack", 2,
			"KnifePocket", 1,
			"LugWrench", 4,
			"MechanicMag1", 2,
			"MechanicMag2", 2,
			"MechanicMag3", 2,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 4,
			"Multitool", 0.01,
			"NutsBolts", 10,
			"Pliers", 8,
			"RespiratorFilters", 2,
			"RubberHose", 10,
			"Screwdriver", 10,
			"Screws", 10,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"SteelWool", 10,
			"Tarp", 10,
			"TireIron", 4,
			"TirePump", 8,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Torch", 4,
			"ViseGrips", 4,
			"WeldingMask", 4,
			"Wrench", 8,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfBooks = {
		rolls = 4,
		items = {
			"BluePen", 8,
			"Book", 10,
			"Book", 20,
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"BookMechanic3", 6,
			"BookMechanic4", 4,
			"BookMechanic5", 2,
			"Calculator", 8,
			"Catalog", 8,
			"Clipboard", 8,
			"GraphPaper", 10,
			"GreenPen", 4,
			"Magazine", 4,
			"Magazine_Popular", 4,
			"Magazine_Car", 10,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MarkerBlack", 4,
			"MechanicMag1", 2,
			"MechanicMag2", 2,
			"MechanicMag3", 2,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Notepad", 8,
			"Paperback_Poor", 4,
			"Phonebook", 20,
			"Pen", 8,
			"Pencil", 10,
			"RedPen", 8,
			"TVMagazine", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfBrakes = {
		rolls = 4,
		items = {
			"ElbowPad_Left_Workman", 1,
			"EngineParts", 10,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"Jack", 2,
			"HandDrill", 4,
			"HeavyChain", 2,
			"Kneepad_Left_Workman", 4,
			"LugWrench", 8,
			"ModernBrake1", 8,
			"ModernBrake2", 6,
			"ModernBrake3", 4,
			"NormalBrake1", 10,
			"NormalBrake2", 8,
			"NormalBrake3", 6,
			"Screwdriver", 10,
			"Tarp", 10,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Torch", 4,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfElectric = {
		rolls = 4,
		items = {
			"Battery", 10,
			"BatteryBox", 1,
			"BlowerFan", 1,
			"CarBattery1", 10,
			"CarBattery2", 8,
			"CarBattery3", 6,
			"CarBatteryCharger", 6,
			"CopperScrap", 10,
			"ElbowPad_Left_Workman", 1,
			"ElectricWire", 20,
			"ElectricWire", 10,
			"ElectronicsScrap", 20,
			"ElectronicsScrap", 10,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"HandDrill", 4,
			"Kneepad_Left_Workman", 4,
			"LightbarRedBlue", 0.5,
			"LightbarRed", 1,
			"LightbarYellow", 1,
			"RadioBlack", 8,
			"RadioRed", 6,
			"Screwdriver", 10,
			"Tarp", 10,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Torch", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfMisc = {
		rolls = 4,
		items = {
			"Bleach", 8,
			"BluePen", 8,
			"Brochure", 2,
			"Broom", 10,
			"Bucket", 10,
			"Calculator", 8,
			"CameraDisposable", 10,
			"Cigar", 0.1,
			"CigarettePack", 4,
			"Cigarillo", 8,
			"CleaningLiquid2", 4,
			"Clipboard", 8,
			"ElbowPad_Left_Workman", 1,
			"Epoxy", 0.5,
			"FiberglassTape", 0.5,
			"Flask", 0.1,
			"Flier", 2,
			"Funnel", 10,
			"Garbagebag", 10,
			"Glasses_SafetyGoggles", 8,
			"GreenPen", 4,
			"HandDrill", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_EarMuff_Protectors", 8,
			"HeavyChain", 2,
			"HottieZ", 0.1,
			"Kneepad_Left_Workman", 4,
			"Magazine", 4,
			"Magazine_Popular", 4,
			"Magazine_Car", 10,
			"MarkerBlack", 4,
			"Mop", 10,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Notepad", 8,
			"NutsBolts", 8,
			"Paperback_Poor", 4,
			"Pen", 8,
			"Pencil", 10,
			"Receipt", 10,
			"RedPen", 8,
			"RespiratorFilters", 2,
			"RippedSheets", 20,
			"RippedSheets", 10,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			"RubberHose", 10,
			"Tarp", 10,
			"TVMagazine", 4,
			"Whiskey", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfMufflers = {
		rolls = 4,
		items = {
			"ElbowPad_Left_Workman", 1,
			"EngineParts", 10,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"HandDrill", 4,
			"HeavyChain", 2,
			"Kneepad_Left_Workman", 4,
			"ModernCarMuffler1", 8,
			"ModernCarMuffler2", 6,
			"ModernCarMuffler3", 4,
			"NormalCarMuffler1", 10,
			"NormalCarMuffler2", 8,
			"NormalCarMuffler3", 6,
			"Tarp", 10,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Torch", 4,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfOutfit = {
		rolls = 4,
		items = {
			"Boilersuit_BlueRed", 20,
			"Boilersuit_BlueRed", 20,
			"Boilersuit_BlueRed", 10,
			"Boilersuit_BlueRed", 10,
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 8,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_EarMuff_Protectors", 8,
			"Kneepad_Left_Workman", 4,
			"RespiratorFilters", 2,
			"WeldingMask", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfSuspension = {
		rolls = 4,
		items = {
			"ElbowPad_Left_Workman", 1,
			"EngineParts", 10,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"HandDrill", 4,
			"HeavyChain", 2,
			"Jack", 2,
			"Kneepad_Left_Workman", 4,
			"LugWrench", 4,
			"ModernSuspension1", 8,
			"ModernSuspension2", 6,
			"ModernSuspension3", 4,
			"NormalSuspension1", 10,
			"NormalSuspension2", 8,
			"NormalSuspension3", 6,
			"Screwdriver", 10,
			"Tarp", 10,
			"TireIron", 8,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Torch", 4,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfTools = {
		rolls = 4,
		items = {
			"BlowerFan", 1,
			"BlowTorch", 8,
			"Boilersuit_BlueRed", 10,
			"Calipers", 2,
			"ElbowPad_Left_Workman", 1,
			"Epoxy", 1,
			"FiberglassTape", 1,
			"File", 4,
			"Funnel", 10,
			"Glasses_SafetyGoggles", 8,
			"HandDrill", 4,
			"HandTorch", 8,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_EarMuff_Protectors", 8,
			"HeavyChain", 8,
			"HeavyChain_Hook", 1,
			"IronBar", 4,
			"IronBarHalf", 6,
			"IronPiece", 10,
			"IronBarQuarter", 8,
			"Jack", 2,
			"Kneepad_Left_Workman", 4,
			"LargeHook", 2,
			"LugWrench", 4,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 4,
			"NutsBolts", 10,
			"Pliers", 8,
			"RubberHose", 10,
			"Screwdriver", 10,
			"SheetMetalSnips", 4,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"SteelBar", 4,
			"SteelBarHalf", 6,
			"SteelPiece", 10,
			"SteelBarQuarter", 8,
			"SteelWool", 10,
			"Tarp", 10,
			"TireIron", 4,
			"TirePump", 8,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Torch", 4,
			"ViseGrips", 4,
			"Whetstone", 10,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MechanicShelfWheels = {
		rolls = 4,
		items = {
			"ElbowPad_Left_Workman", 1,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"HandDrill", 4,
			"HeavyChain", 2,
			"Jack", 2,
			"Kneepad_Left_Workman", 4,
			"LugWrench", 4,
			"ModernTire1", 8,
			"ModernTire2", 6,
			"ModernTire3", 4,
			"NormalTire1", 10,
			"NormalTire2", 8,
			"NormalTire3", 6,
			"Screwdriver", 10,
			"Tarp", 10,
			"TireIron", 4,
			"TirePump", 8,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Torch", 4,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"TirePiece", 4,
			}
		}
	},

	MechanicSpecial = {
		rolls = 4,
		items = {
			"BlowerFan", 1,
			"BlowTorch", 8,
			"BoltCutters", 8,
			"BookMechanic1", 6,
			"BookMechanic2", 4,
			"BookMechanic3", 2,
			"BookMechanic4", 1,
			"BookMechanic5", 0.5,
			"Calipers", 2,
			"ElbowPad_Left_Workman", 1,
			"EngineParts", 10,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"File", 4,
			"Funnel", 10,
			"GraphPaper", 10,
			"HandDrill", 4,
			"HandTorch", 8,
			"Hat_BuildersRespirator", 2,
			"HeavyChain", 8,
			"HeavyChain_Hook", 1,
			"Jack", 2,
			"Kneepad_Left_Workman", 4,
			"LargeHook", 1,
			"LightbarRedBlue", 0.5,
			"LightbarRed", 1,
			"LightbarYellow", 1,
			"LugWrench", 4,
			"Magazine_Car", 5,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 4,
			"ModernBrake1", 2,
			"ModernBrake2", 1,
			"ModernBrake3", 0.5,
			"ModernCarMuffler1", 2,
			"ModernCarMuffler1", 2,
			"ModernCarMuffler2", 1,
			"ModernCarMuffler2", 1,
			"ModernCarMuffler3", 0.5,
			"ModernCarMuffler3", 0.5,
			"ModernSuspension1", 2,
			"ModernSuspension2", 1,
			"ModernSuspension3", 0.5,
			"ModernTire1", 2,
			"ModernTire2", 1,
			"ModernTire3", 0.5,
			"NutsBolts", 8,
			"Pliers", 8,
			"RespiratorFilters", 2,
			"RubberHose", 10,
			"Screwdriver", 10,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"Tarp", 10,
			"TireIron", 8,
			"TirePump", 10,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"Torch", 4,
			"ViseGrips", 4,
			"Wrench", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MedicalCabinet = {
		rolls = 4,
		items = {
			"AdhesiveBandageBox", 0.1,
			"AlcoholWipes", 10,
			"Bandage", 6,
			"Bandaid", 10,
			"Coldpack", 8,
			"CottonBalls", 10,
			"Gloves_Surgical", 10,
			"ScissorsBlunt", 4,
			"ScissorsBluntMedical", 4,
			"Scotchtape", 4,
			"Tweezers", 4,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	MedicalClinicDrugs = {
		rolls = 4,
		items = {
			"AdhesiveBandageBox", 1,
			"AlcoholWipes", 10,
			"Antibiotics", 4,
			"AntibioticsBox", 0.1,
			"Bandage", 4,
			"BandageBox", 1,
			"Bandaid", 8,
			"CottonBalls", 10,
			"CottonBallsBox", 2,
			"Disinfectant", 4,
			"Pills", 20,
			"Pills", 20,
			"Pills", 10,
			"Pills", 10,
			"PillsAntiDep", 8,
			"PillsBeta", 4,
			"PillsSleepingTablets", 8,
			"TongueDepressor", 10,
			"TongueDepressorBox", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MedicalClinicOutfit = {
		rolls = 4,
		items = {
			"AdhesiveBandageBox", 1,
			"AntibioticsBox", 0.01,
			"BandageBox", 0.1,
			"Corset_Medical", 2,
			"CottonBallsBox", 0.5,
			"Disinfectant", 1,
			"Gloves_Surgical", 20,
			"Gloves_Surgical", 10,
			"Hat_HeadMirrorUP", 1,
			"Hat_SurgicalMask", 20,
			"Hat_SurgicalMask", 10,
			"JacketLong_Doctor", 0.1,
			"PenLight", 4,
			"Pills", 4,
			"PillsAntiDep", 1,
			"PillsBeta", 0.5,
			"PillsSleepingTablets", 1,
			"Shirt_Scrubs", 20,
			"Shirt_Scrubs", 10,
			"Stethoscope", 8,
			"TongueDepressorBox", 1,
			"Trousers_Scrubs", 20,
			"Trousers_Scrubs", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MedicalClinicTools = {
		rolls = 4,
		items = {
			"AlcoholWipes", 4,
			"Bandage", 1,
			"Bandaid", 4,
			"CottonBallsBox", 1,
			"Disinfectant", 1,
			"Gloves_Surgical", 4,
			"Hat_SurgicalMask", 4,
			"Oxygen_Tank", 1,
			"PenLight", 4,
			"Pills", 1,
			"RubberHose", 10,
			"Scalpel", 10,
			"ScissorsBluntMedical", 10,
			"Stethoscope", 1,
			"SutureNeedle", 8,
			"SutureNeedleBox", 2,
			"SutureNeedleHolder", 10,
			"TongueDepressor", 10,
			"TongueDepressorBox", 4,
			"Tweezers", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MedicalOfficeCounter = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"AdhesiveBandageBox", 0.5,
			"AlcoholWipes", 4,
			"Bandaid", 4,
			"Bandage", 1,
			"BandageBox", 0.1,
			"Book_Medical", 4,
			"CottonBalls", 4,
			"CottonBallsBox", 0.1,
			"Disinfectant", 1,
			"Gloves_Surgical", 4,
			"Hat_SurgicalMask", 4,
			"IndexCard", 10,
			"Magazine_Health", 10,
			"Paperback_Medical", 8,
			"Paperwork", 20,
			"Paperwork", 10,
			"PenLight", 4,
			"Pills", 4,
			"TongueDepressor", 4,
			"TongueDepressorBox", 0.1,
		},
		junk = ClutterTables.CounterJunk,
	},

	MedicalOfficeDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Medical
			"AdhesiveBandageBox", 0.5,
			"AlcoholWipes", 4,
			"Bandage", 1,
			"BandageBox", 0.1,
			"Bandaid", 4,
			"CottonBalls", 4,
			"CottonBallsBox", 0.1,
			"Disinfectant", 1,
			"Gloves_Surgical", 4,
			"Hat_SurgicalMask", 4,
			"Pills", 4,
			"PillsVitamins", 1,
			"TongueDepressor", 4,
			"TongueDepressorBox", 0.1,
			-- Literature
			"Book_Medical", 4,
			"Diary2", 0.1,
			"Magazine_Health", 10,
			"Paperback_Fiction", 4,
			"Paperback_Medical", 8,
			-- Stationery/Office
			"Paperwork", 20,
			"Paperwork", 10,
			"PenLight", 4,
			-- Misc.
			"Flask", 0.1,
			"Gum", 4,
			"IndexCard", 10,
			"MenuCard", 10,
			"Whiskey", 0.1,
		},
		junk = ClutterTables.DeskJunk,
	},

	MedicalOfficeBooks = {
		rolls = 4,
		items = {
			"Book_Medical", 20,
			"Book_Medical", 20,
			"Book_Medical", 10,
			"Book_Medical", 10,
			"BookFirstAid1", 10,
			"BookFirstAid2", 8,
			"BookFirstAid3", 6,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			"Mov_DegreeDoctor", 4,
			"Mov_DegreeSurgeon", 4,
			"Phonebook", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MedicalStorageDrugs = {
		rolls = 4,
		items = {
			"AdhesiveBandageBox", 4,
			"AlcoholWipes", 20,
			"AlcoholWipes", 10,
			"Antibiotics", 8,
			"AntibioticsBox", 0.5,
			"Bag_ProtectiveCaseBulkyHazard", 1,
			"Bandage", 8,
			"BandageBox", 2,
			"Bandaid", 20,
			"Bandaid", 10,
			"CottonBalls", 10,
			"CottonBallsBox", 8,
			"Disinfectant", 8,
			"Pills", 50,
			"Pills", 20,
			"Pills", 20,
			"Pills", 10,
			"PillsAntiDep", 20,
			"PillsAntiDep", 10,
			"PillsBeta", 10,
			"PillsSleepingTablets", 10,
			"TongueDepressor", 10,
			"TongueDepressorBox", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MedicalStorageOutfit = {
		rolls = 4,
		items = {
			"AdhesiveBandageBox", 1,
			"AntibioticsBox", 0.01,
			"BandageBox", 0.1,
			"Corset_Medical", 4,
			"CottonBallsBox", 0.5,
			"Disinfectant", 1,
			"Gloves_Surgical", 20,
			"Gloves_Surgical", 10,
			"Hat_SurgicalCap", 20,
			"Hat_SurgicalCap", 10,
			"Hat_SurgicalMask", 20,
			"Hat_SurgicalMask", 10,
			"HospitalGown", 8,
			"JacketLong_Doctor", 0.5,
			"PenLight", 4,
			"Pills", 4,
			"PillsAntiDep", 1,
			"PillsBeta", 0.5,
			"PillsSleepingTablets", 1,
			"Shirt_Scrubs", 20,
			"Shirt_Scrubs", 10,
			"Stethoscope", 8,
			"TongueDepressorBox", 1,
			"Trousers_Scrubs", 20,
			"Trousers_Scrubs", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MedicalStorageTools = {
		rolls = 4,
		items = {
			"AlcoholWipes", 8,
			"Bag_ProtectiveCaseBulkyHazard", 1,
			"Bandage", 4,
			"Bandaid", 10,
			"CottonBallsBox", 1,
			"Disinfectant", 2,
			"Gloves_Surgical", 8,
			"Hat_SurgicalMask", 8,
			"Oxygen_Tank", 2,
			"PenLight", 4,
			"RubberHose", 10,
			"Scalpel", 20,
			"Scalpel", 10,
			"ScissorsBluntMedical", 20,
			"ScissorsBluntMedical", 10,
			"Stethoscope", 1,
			"SutureNeedle", 8,
			"SutureNeedleBox", 2,
			"SutureNeedleHolder", 20,
			"SutureNeedleHolder", 10,
			"TongueDepressor", 10,
			"TongueDepressorBox", 4,
			"Tweezers", 20,
			"Tweezers", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MeleeWeapons = {
		rolls = 4,
		items = {
			-- Improvised Weapons
			"BowlingPin", 1,
			"ChairLeg", 2,
			"FireplacePoker", 1,
			"LeadPipe", 8,
			"MetalBar", 8,
			"MetalPipe", 8,
			"Plank", 8,
			"Plunger", 4, -- deliberate easter egg
			"Sapling", 4,
			"TableLeg", 1,
			-- Materials
			"CircularSawblade", 1,
			"Handle", 4,
			"LongHandle", 4,
			"LongStick", 4,
			"FlintNodule", 1,
			"SharpedStone", 1,
			"StoneBlade", 1,
			"SharpBoneFragment", 1,
			"Whetstone", 10,
			-- Sports Equipment
			"BaseballBat", 4, -- boosted to normalize for the lack of other weapons
			"BaseballBat_Metal", 2, -- boosted to normalize for the lack of other weapons
			"CanoePadel", 1,
			"CanoePadelX2", 1,
			"FieldHockeyStick", 1,
			"Golfclub", 4,
			"IceHockeyStick", 1,
			"LaCrosseStick", 1,
			-- Knives
			"BreadKnife", 6,
			"FightingKnife", 1,
			"Handiknife", 0.1,
			"HuntingKnife", 8,
			"KitchenKnife", 6,
			"KnifeButterfly", 4,
			"KnifePocket", 0.1,
			"LargeKnife", 0.5,
			"SmallKnife", 1,
			"SteakKnife", 8,
			"SwitchKnife", 4,
			-- Tools
			"Axe", 1,
			"BallPeenHammer", 4,
			"BoltCutters", 1,
			"ClubHammer", 4,
			"Crowbar", 4,
			"GardenFork", 1,
			"GardenHoe", 1,
			"Hammer", 8,
			"HandAxe", 4,
			"PickAxe", 0.1,
			"PipeWrench", 4,
			"ShortBat", 2,
			"Shovel", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.1,
			"Sledgehammer2", 0.1,
			"WoodAxe", 0.1,
			"WoodenMallet", 4,
			-- Military/Law Enforcement
			"EntrenchingTool", 1,
			"Nightstick", 4,
			-- Crafted/Modified Weapons
			"BaseballBat_Nails", 1,
			"BaseballBat_Broken_Nails", 0.5,
			"BowlingPin_Nails", 0.1,
			"Handle_Nails", 0.5,
			"KnifeShiv", 8,
			"LongHandle_Broken_Nails", 0.5,
			"Plank_Broken_Nails", 0.5,
			"WoodenStick_Nails", 1,
			"WoodenStick_Broken_Nails", 0.5,
			-- Bags/Containers
			"Bag_GolfBag_Melee", 0.5,
			-- Special
			"Machete", 0.5,
			-- Skill Books and Recipes
			"BookBlacksmith1", 1,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 1,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookCarving1", 1,
			"BookCarving2", 1,
			"BookCarving3", 1,
			"BookCarving4", 1,
			"BookCarving5", 0.5,
			"BookFlintKnapping1", 1,
			"BookFlintKnapping2", 1,
			"BookFlintKnapping3", 1,
			"BookFlintKnapping4", 1,
			"BookFlintKnapping5", 0.5,
			"BookMaintenance1", 1,
			"BookMaintenance2", 1,
			"BookMaintenance3", 1,
			"BookMaintenance4", 1,
			"BookMaintenance5", 0.5,
			"MeleeWeaponSchematic", 50,
			"WeaponMag1", 1,
			"WeaponMag2", 1,
			"WeaponMag3", 1,
			"WeaponMag4", 1,
			"WeaponMag5", 1,
			"WeaponMag6", 1,
			"WeaponMag7", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"BanjoNeck_Broken", 2,
				"BaseballBat_Broken", 4,
				"CanoePadelX2_Broken", 1,
				"FieldHockeyStick_Broken", 2,
				"GardenToolHandle_Broken", 2,
				"GuitarAcousticNeck_Broken", 2,
				"GuitarElectricNeck_Broken", 2,
				"GuitarElectricBassNeck_Broken", 2,
				"LongHandle_Broken", 4,
				"LongStick_Broken", 2,
				"Plank_Broken", 2,
				"TableLeg_Broken", 2,
				"WoodenStick_Broken", 4,
			}
		}
	},

	MeleeWeapons_Mid = {
		rolls = 4,
		items = {
			-- Improvised Weapons
			"BowlingPin", 1,
			"ChairLeg", 2,
			"FireplacePoker", 1,
			"LargeBranch", 1,
			"LeadPipe", 8,
			"LongStick", 4,
			"MetalBar", 8,
			"MetalPipe", 8,
			"Sapling", 4,
			"TableLeg", 1,
			-- Materials
			"CircularSawblade", 2,
			"CircularSawblade_Half", 1,
			"Handle", 2,
			"LongHandle", 2,
			"LongStick", 2,
			"FlintNodule", 2,
			"SharpedStone", 2,
			"StoneBlade", 2,
			"StoneBladeLong", 1,
			"SharpBoneFragment", 2,
			"SharpBone_Long", 1,
			"Whetstone", 20,
			"Whetstone", 10,
			-- Sports Equipment
			"BaseballBat", 2,
			"BaseballBat_Metal", 1,
			"CanoePadel", 1,
			"CanoePadelX2", 1,
			"FieldHockeyStick", 1,
			"Golfclub", 4,
			"IceAxe", 1,
			"IceHockeyStick", 1,
			"LaCrosseStick", 1,
			-- Knives
			"FightingKnife", 2,
			"Handiknife", 0.5,
			"HuntingKnife", 8,
			"KnifeButterfly", 8,
			"KnifePocket", 0.5,
			"LargeKnife", 4,
			"SmallKnife", 2,
			"SwitchKnife", 8,
			-- Tools
			"Axe", 0.5,
			"Axe_Old", 0.1,
			"BallPeenHammer", 4,
			"BoltCutters", 1,
			"ClubHammer", 4,
			"Crowbar", 4,
			"GardenFork", 1,
			"GardenFork_Forged", 0.1,
			"GardenHoe", 1,
			"Hammer", 8,
			"HandAxe", 4,
			"HandAxe_Old", 0.1,
			"PickAxe", 0.1,
			"PipeWrench", 2,
			"RailroadSpikePuller", 0.5,
			"RailroadSpikePullerOld", 0.1,
			"ShortBat", 1,
			"Shovel", 1,
			"Shovel2", 1,
			"Sledgehammer", 0.1,
			"Sledgehammer2", 0.1,
			"WoodAxe", 0.1,
			"WoodenMallet", 4,
			-- Military/Law Enforcement
			"EntrenchingTool", 1,
			"Nightstick", 2,
			-- Crafted/Modified Weapons
			"BaseballBat_Nails", 0.1,
			"BaseballBat_Broken_Nails", 0.1,
			"BaseballBat_Can", 0.1,
			"BaseballBat_RakeHead", 0.1,
			"BaseballBat_RailSpike", 0.1,
			"BaseballBat_Sawblade", 0.1,
			"BowlingPin_Nails", 0.5,
			"Broom_BarbedWire", 0.1,
			"ChairLeg_Nails", 0.1,
			"CrudeKnife", 1,
			"Cudgel_Nails", 0.1,
			"FieldHockeyStick_Nails", 0.1,
			"FieldHockeyStick_Broken_Nails", 0.1,
			"Handle_Nails", 0.1,
			"Handle_Can", 0.1,
			"KnifeShiv", 1,
			"Branch_Broken_Nails", 0.1,
			"LargeKnife_Scrap", 0.1,
			"LongHandle_Broken_Nails", 0.1,
			"LongHandle_Can", 0.1,
			"LongHandle_RakeHead", 0.1,
			"LongHandle_Railspike", 0.1,
			"LongHandle_Sawblade", 0.1,
			"Machete_Crude", 0.1,
			"MetalPipe_Railspike", 0.1,
			"Plank_Sawblade", 0.1,
			"ShortBat_Can", 0.1,
			"ShortBat_Nails", 0.1,
			"ShortBat_RailSpike", 0.1,
			"ShortBat_Sawblade", 0.1,
			"ShortBat_RakeHead", 0.1,
			"SpearCrafted", 1,
			"SpearGlass", 0.1,
			"TableLeg_Nails", 0.1,
			"TableLeg_Broken_Nails", 0.1,
			"TreeBranch_Can", 0.1,
			"TreeBranch_Nails", 0.1,
			"TreeBranch_Railspike", 0.1,
			"WoodenStick_Nails", 0.1,
			"WoodenStick_Broken_Nails", 0.1,
			"WoodenStick_Can", 0.1,
			-- Bags/Containers
			"Bag_GolfBag_Melee", 1,
			-- Special
			"Machete", 1,
			"Katana", 0.01,
			-- Skill Books and Recipes
			"BookBlacksmith1", 1,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 1,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookCarving1", 1,
			"BookCarving2", 1,
			"BookCarving3", 1,
			"BookCarving4", 1,
			"BookCarving5", 0.5,
			"BookFlintKnapping1", 1,
			"BookFlintKnapping2", 1,
			"BookFlintKnapping3", 1,
			"BookFlintKnapping4", 1,
			"BookFlintKnapping5", 0.5,
			"BookMaintenance1", 1,
			"BookMaintenance2", 1,
			"BookMaintenance3", 1,
			"BookMaintenance4", 1,
			"BookMaintenance5", 0.5,
			"MeleeWeaponSchematic", 50,
			"MeleeWeaponSchematic", 20,
			"WeaponMag1", 2,
			"WeaponMag2", 2,
			"WeaponMag3", 2,
			"WeaponMag4", 2,
			"WeaponMag5", 2,
			"WeaponMag6", 2,
			"WeaponMag7", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"BaseballBat_Broken", 8,
				"CanoePadelX2_Broken", 2,
				"FieldHockeyStick_Broken", 4,
				"GardenToolHandle_Broken", 6,
				"Katana_Broken", 1,
				"LongHandle_Broken", 8,
				"LongStick_Broken", 8,
				"Plank_Broken", 4,
				"TableLeg_Broken", 1,
			}
		}
	},

	MeleeWeapons_Late = {
		rolls = 4,
		items = {
			-- Improvised Weapons
			"BowlingPin", 1,
			"ChairLeg", 2,
			"FireplacePoker", 1,
			"LargeBranch", 1,
			"LeadPipe", 8,
			"LongStick", 4,
			"MetalBar", 8,
			"MetalPipe", 8,
			"Sapling", 4,
			"TableLeg", 2,
			-- Materials
			"CircularSawblade", 4,
			"CircularSawblade_Half", 4,
			"Handle", 4,
			"LongHandle", 4,
			"LongStick", 4,
			"FlintNodule", 4,
			"SharpedStone", 4,
			"StoneBlade", 4,
			"SharpBone_Long", 4,
			"SharpBoneFragment", 4,
			"Whetstone", 20,
			"Whetstone", 10,
			-- Sports Equipment
			"BarBell", 1,
			"BaseballBat", 2,
			"BaseballBat_Metal", 1,
			"DumbBell", 2,
			"IceAxe", 2,
			-- Knives
			"FightingKnife", 4,
			"Handiknife", 1,
			"HuntingKnife", 8,
			"KnifeButterfly", 8,
			"KnifePocket", 1,
			"LargeKnife", 4,
			"SmallKnife", 2,
			"SwitchKnife", 8,
			-- Tools
			"Axe", 1,
			"Axe_Old", 0.1,
			"BallPeenHammer", 4,
			"BoltCutters", 1,
			"ClubHammer", 4,
			"Crowbar", 4,
			"GardenFork", 1,
			"GardenFork_Forged", 0.1,
			"GardenHoe", 1,
			"Hammer", 8,
			"HandAxe", 4,
			"HandAxe_Old", 0.1,
			"PickAxe", 0.1,
			"PipeWrench", 2,
			"RailroadSpikePuller", 0.5,
			"RailroadSpikePullerOld", 0.1,
			"ShortBat", 1,
			"Shovel", 1,
			"Shovel2", 1,
			"Sledgehammer", 0.1,
			"Sledgehammer2", 0.1,
			"WoodAxe", 0.1,
			"WoodenMallet", 4,
			-- Military/Law Enforcement
			"EntrenchingTool", 1,
			"Nightstick", 2,
			-- Crafted/Modified Weapons
			"Axe_Sawblade", 0.1,
			"Axe_Sawblade_Hatchet", 0.1,
			"BaseballBat_Nails", 0.1,
			"BaseballBat_Broken_Nails", 0.1,
			"BaseballBat_GardenForkHead", 0.1,
			"BaseballBat_Metal_Bolts", 0.1,
			"BaseballBat_Metal_Sawblade", 0.1,
			"BaseballBat_RakeHead", 0.1,
			"BaseballBat_RailSpike", 0.1,
			"BaseballBat_Sawblade", 0.1,
			"BaseballBat_ScrapSheet", 0.1,
			"BlockMace", 0.1,
			"BlockMaul", 0.1,
			"BoneClub", 0.1,
			"BoneClub_Spiked", 0.1,
			"BowlingPin_Nails", 1,
			"CrudeKnife", 1,
			"Cudgel_Bone", 0.1,
			"Cudgel_Brake", 0.1,
			"Cudgel_GardenForkHead", 0.1,
			"Cudgel_Nails", 0.1,
			"Cudgel_Railspike", 0.1,
			"Cudgel_Sawblade", 0.1,
			"Cudgel_ScrapSheet", 0.1,
			"Cudgel_SpadeHead", 0.1,
			"EngineMaul", 0.1,
			"FieldHockeyStick_Broken_Nails", 0.1,
			"FieldHockeyStick_Nails", 0.1,
			"FieldHockeyStick_Sawblade", 0.1,
			"Handle_Nails", 0.1,
			"Handle_Can", 0.1,
			"Hatchet_Bone", 0.1,
			"HatchetHead_Bone", 0.1,
			"IceHockeyStick_BarbedWire", 0.1,
			"JawboneBovide_Axe", 0.01,
			"JawboneBovide_Club", 0.01,
			"LargeBoneClub", 0.1,
			"LargeBoneClub_Spiked", 0.1,
			"Branch_Broken_Nails", 0.1,
			"LargeKnife_Scrap", 0.1,
			"LongHandle_Brake", 0.1,
			"LongHandle_Broken_Nails", 0.1,
			"LongHandle_Can", 0.1,
			"LongHandle_RakeHead", 0.1,
			"LongHandle_Railspike", 0.1,
			"LongHandle_Sawblade", 0.1,
			"Machete_Crude", 0.1,
			"MetalPipe_Railspike", 0.1,
			"Morningstar_Scrap", 0.1,
			"Morningstar_Scrap_Short", 0.1,
			"Plank_Brake", 0.1,
			"Plank_Saw", 0.1,
			"ScrapMaul", 0.1,
			"ScrapWeaponGardenFork", 0.1,
			"ScrapWeaponRakeHead", 0.1,
			"ScrapWeaponSpade", 0.1,
			"Screwdriver_Improvised", 10,
			"ShortBat_Can", 0.1,
			"ShortSword_Scrap", 0.1,
			"RailroadSpikeKnife", 0.1,
			"ScrapWeapon_Brake", 0.1,
			"ShortBat_Nails", 0.1,
			"ShortBat_RailSpike", 0.1,
			"ShortBat_Sawblade", 0.1,
			"ShortBat_RakeHead", 0.1,
			"Spear_Bone", 0.1,
			"Spear_BoneLong", 0.1,
			"SpearCrafted", 4,
			"SpearSteakKnife", 0.1,
			"Sword_Scrap", 0.1,
			"TableLeg_Chain", 0.1,
			"TableLeg_Sawblade", 0.1,
			"TreeBranch_Bone", 0.1,
			"TreeBranch_Can", 0.1,
			"TreeBranch_Nails", 0.1,
			"TreeBranch_Railspike", 0.1,
			"WoodenStick_Can", 0.1,
			-- Bags/Containers
			"Bag_GolfBag_Melee", 1,
			-- Special
			"Machete", 2,
			"Sword", 0.1,
			"Katana", 0.1,
			-- Skill Books and Recipes
			"BookBlacksmith1", 1,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 1,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookCarving1", 1,
			"BookCarving2", 1,
			"BookCarving3", 1,
			"BookCarving4", 1,
			"BookCarving5", 0.5,
			"BookFlintKnapping1", 1,
			"BookFlintKnapping2", 1,
			"BookFlintKnapping3", 1,
			"BookFlintKnapping4", 1,
			"BookFlintKnapping5", 0.5,
			"BookMaintenance1", 1,
			"BookMaintenance2", 1,
			"BookMaintenance3", 1,
			"BookMaintenance4", 1,
			"BookMaintenance5", 0.5,
			"MeleeWeaponSchematic", 50,
			"MeleeWeaponSchematic", 50,
			"WeaponMag1", 5,
			"WeaponMag2", 5,
			"WeaponMag3", 5,
			"WeaponMag4", 5,
			"WeaponMag5", 5,
			"WeaponMag6", 5,
			"WeaponMag7", 5,
		},
		junk = {
			rolls = 1,
			items = {
				"BaseballBat_Broken", 8,
				"AnimalBone", 8,
				"Katana_Broken", 1,
				"LargeAnimalBone", 4,
				"LongHandle_Broken", 8,
				"Plank_Broken", 4,
				"SharpBoneFragment", 4,
				"TableLeg_Broken", 0.5,
			}
		}
	},

	MetalShopTools = {
		rolls = 4,
		items = {
			"BallPeenHammer", 8,
			"BlowTorch", 20,
			"BlowTorch", 10,
			"BoltCutters", 8,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"BookMaintenance4", 0.1,
			"BookMaintenance5", 0.05,
			"BookMetalWelding1", 2,
			"BookMetalWelding2", 1,
			"BookMetalWelding3", 0.5,
			"BookMetalWelding4", 0.1,
			"BookMetalWelding5", 0.05,
			"Calipers", 8,
			"DrawPlate", 8,
			"ElbowPad_Left_Workman", 1,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"File", 8,
			"Glasses_SafetyGoggles", 4,
			"HandDrill", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"Hat_HardHat", 2,
			"Kneepad_Left_Workman", 4,
			"MarkerBlack", 10,
			"MeasuringTape", 10,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"Mov_ElectricBlowerForge", 1,
			"NutsBolts", 20,
			"NutsBolts", 10,
			"Oxygen_Tank", 20,
			"Oxygen_Tank", 10,
			"Pliers", 8,
			"Propane_Refill", 20,
			"Propane_Refill", 10,
			"PropaneTank", 4,
			"RespiratorFilters", 2,
			"Saw", 8,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.5,
			"SheetMetalSnips", 8,
			"SmallFileSet", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"SteelWool", 10,
			"ViseGrips", 4,
			"WeldingMask", 4,
			"WeldingRods", 20,
			"WeldingRods", 20,
			"WeldingRods", 10,
			"WeldingRods", 10,
			"Whetstone", 10,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"AluminumFragments", 4,
			}
		}
	},

	MetalWorkerOutfit = {
		rolls = 3,
		items = {
			"Boilersuit_BlueRed", 20,
			"BookMetalWelding1", 6,
			"BookMetalWelding2", 4,
			"BookMetalWelding3", 2,
			"BookMetalWelding4", 1,
			"BookMetalWelding5", 0.5,
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 10,
			"Gloves_LeatherGloves", 1,
			"Handiknife", 1,
			"Hat_Bandana", 1,
			"Hat_BandanaTINT", 1,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_HardHat", 4,
			"Kneepad_Left_Workman", 4,
			"KnifePocket", 1,
			"MarkerBlack", 4,
			"MetalworkMag1", 2,
			"MetalworkMag2", 2,
			"MetalworkMag3", 2,
			"MetalworkMag4", 2,
			"Multitool", 0.01,
			"Notepad", 10,
			"Pencil", 10,
			"RippedSheets", 10,
			"Shoes_WorkBoots", 8,
			"Toolbox", 2,
			"Tshirt_DefaultTEXTURE_TINT", 6,
			"Vest_DefaultTEXTURE_TINT", 6,
			"WeldingMask", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MetalWorkerTools = {
		rolls = 3,
		items = {
			"BallPeenHammer", 8,
			"BlowTorch", 20,
			"BoltCutters", 8,
			"BookMetalWelding1", 6,
			"BookMetalWelding2", 4,
			"BookMetalWelding3", 2,
			"BookMetalWelding4", 1,
			"BookMetalWelding5", 0.5,
			"Calipers", 8,
			"DrawPlate", 8,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"File", 8,
			"HandDrill", 4,
			"Handiknife", 1,
			"KnifeButterfly", 4,
			"KnifePocket", 1,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"MetalworkMag1", 2,
			"MetalworkMag2", 2,
			"MetalworkMag3", 2,
			"MetalworkMag4", 2,
			"Multitool", 0.01,
			"NutsBolts", 10,
			"Oxygen_Tank", 10,
			"Pliers", 8,
			"Propane_Refill", 10,
			"RespiratorFilters", 2,
			"RippedSheets", 20,
			"RippedSheets", 10,
			"Screwdriver", 10,
			"ScrewsBox", 4,
			"ScrewsCarton", 0.1,
			"SheetMetalSnips", 8,
			"SmallFileSet", 8,
			"SmallSaw", 8,
			"SmallPunchSet", 8,
			"SmallSheetMetal", 20,
			"ViseGrips", 4,
			"WeldingMask", 4,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MexicanKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"Cornflour2", 20,
			"Cornflour2", 10,
			"Flour2", 10,
			"TacoShell", 8,
			"Tortilla", 8,
			"TortillaChipsBaked", 8,
			-- Utensils
			"BreadKnife", 8,
			"RollingPin", 8,
			"KitchenTongs", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
			-- Misc.
			"Aluminum", 8,
			"DishCloth", 10,
			"OvenMitt", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MexicanKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Chicken", 8,
			"FishFillet", 4,
			"MincedMeat", 8,
			"Shrimp", 4,
			"Steak", 2,
			-- Spices
			"Pepper", 4,
			"PowderedGarlic", 4,
			"PowderedOnion", 4,
			"Salt", 4,
			-- Utensils
			"Fleshing_Tool", 10,
			"KitchenKnife", 6,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			-- Clothing
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Hat_ChefHat", 4,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Twine", 10,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MexicanKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Chicken", 4,
			"FishFillet", 4,
			"MincedMeat", 8,
			"Shrimp", 8,
			"Steak", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MexicanKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Fruit
			"Banana", 2,
			"Lemon", 4,
			"Lime", 4,
			"Mango", 2,
			"Pineapple", 1,
			-- Vegetables
			"Avocado", 4,
			"BellPepper", 4,
			"Blackbeans", 2,
			"Cauliflower", 2,
			"Corn", 2,
			"Cucumber", 2,
			"Lettuce", 2,
			"Onion", 2,
			"PepperHabanero", 1,
			"PepperJalapeno", 2,
			"Potato", 2,
			"Tomato", 2,
			"Zucchini", 2,
			-- Meat
			"Chicken", 4,
			"FishFillet", 4,
			"MincedMeat", 8,
			"Shrimp", 8,
			"Steak", 2,
			-- Herbs
			"Cilantro", 8,
			-- Sauces/Condiments
			"SourCream", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MexicanKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Condiments
			"Dip_NachoCheese", 8,
			"Dip_Salsa", 8,
			"Honey", 4,
			"Hotsauce", 8,
			-- Spices
			"Cinnamon", 6,
			"PowderedGarlic", 8,
			"PowderedOnion", 8,
			"Seasoning_Cilantro", 6,
			"Seasoning_Oregano", 6,
			"Seasoning_Thyme", 6,
			-- Utensils
			"Ladle", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MorgueChemicals = {
		rolls = 4,
		items = {
			-- Chemicals
			"Bleach", 20,
			"Bleach", 20,
			"Bleach", 10,
			"Bleach", 10,
			"Disinfectant", 20,
			"Disinfectant", 20,
			"Disinfectant", 10,
			"Disinfectant", 10,
			-- Materials
			"CottonBalls", 10,
			"CottonBallsBox", 4,
			"Garbagebag", 8,
			"Garbagebag_box", 1,
			"Oxygen_Tank", 1,
			"RubberHose", 10,
			"Tarp", 8,
			"Thread", 20,
			"Thread", 10,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {
				-- Misc.
				"BluePen", 4,
				"IndexCard", 8,
				"Journal", 2,
				"Note", 8,
				"Notebook", 2,
				"Notepad", 6,
				"Paperwork", 20,
				"Paperwork", 10,
				"Pen", 4,
				"Pencil", 6,
				"PenLight", 8,
				"RedPen", 4,
			}
		}
	},

	MorgueOutfit = {
		rolls = 4,
		items = {
			-- Accessories
			"Glasses_SafetyGoggles", 20,
			"Glasses_SafetyGoggles", 10,
			"Gloves_Surgical", 20,
			"Gloves_Surgical", 10,
			"Hat_BuildersRespirator", 8,
			"Hat_SurgicalMask", 20,
			"Hat_SurgicalMask", 10,
			"RespiratorFilters", 8,
			"SCBA", 4,
			"Stethoscope", 8,
			-- Clothing
			"Belt2", 2,
			"Apron_White", 10,
			"JacketLong_Doctor", 4,
			"Shirt_FormalWhite", 2,
			"Shirt_Scrubs", 8,
			"Suit_Jacket", 1,
			"Tie_Full", 0.5,
			"Trousers_Scrubs", 8,
			"Trousers_Suit", 2,
			-- Literature
			"Book_Medical", 4,
			"BookFancy_Medical", 1,
		},
		junk = {
			rolls = 1,
			items = {
				-- Misc.
				"BluePen", 4,
				"IndexCard", 8,
				"Journal", 2,
				"Note", 8,
				"Notebook", 2,
				"Notepad", 6,
				"Paperwork", 20,
				"Paperwork", 10,
				"Pen", 4,
				"Pencil", 6,
				"PenLight", 8,
				"RedPen", 4,
			}
		}
	},

	MorgueTools = {
		rolls = 4,
		items = {
			-- Tools
			"ClubHammer", 8,
			"BoltCutters", 4,
			"Fleshing_Tool", 10,
			"HandAxe", 8,
			"HandDrill", 8,
			"Saw", 8,
			"Scalpel", 20,
			"Scalpel", 10,
			"ScissorsBluntMedical", 8,
			"SutureNeedle", 20,
			"SutureNeedle", 10,
			"SutureNeedleBox", 1,
			"SutureNeedleHolder", 8,
			"Tweezers", 8,
			-- Accessories
			"Glasses_SafetyGoggles", 10,
			"Gloves_Surgical", 10,
			"Hat_SurgicalMask", 10,
			-- Materials
			"CottonBalls", 10,
			"CottonBallsBox", 4,
			"Garbagebag", 8,
			"Garbagebag_box", 1,
			"Oxygen_Tank", 1,
			"RubberHose", 10,
			"Tarp", 8,
			"Thread", 20,
			"Thread", 10,
			"Twine", 10,
			"Whetstone", 10,
			-- Literature
			"Book_Medical", 4,
			"BookFancy_Medical", 1,
		},
		junk = {
			rolls = 1,
			items = {
				-- Misc.
				"BluePen", 4,
				"IndexCard", 8,
				"Journal", 2,
				"Note", 8,
				"Notebook", 2,
				"Notepad", 6,
				"Paperwork", 20,
				"Paperwork", 10,
				"Pen", 4,
				"Pencil", 6,
				"PenLight", 8,
				"RedPen", 4,
			}
		}
	},

	MotelFridge = {
		ignoreZombieDensity = true,
		rolls = 1,
		items = {
			"BeerBottle", 6,
			"BeerCan", 6,
			"Burger", 6,
			"Burrito", 10,
			"Corndog", 10,
			"Fries", 6,
			"Hotdog", 6,
			"MuffinFruit", 10,
			"MuffinGeneric", 10,
			"Pizza", 6,
			"Pop", 6,
			"Pop2", 6,
			"Pop3", 6,
			"PopBottle", 4,
			"PopBottleRare", 0.1,
			"Whiskey", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MotelLinens = {
		rolls = 4,
		items = {
			"Sheet", 50,
			"Sheet", 20,
			"Sheet", 20,
			"Sheet", 10,
			"Sheet", 10,
			"Pillow", 20,
			"Pillow", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MotelSideTable = {
		rolls = 1,
		items = {
			"Book_Bible", 200,
			"Phonebook", 200,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MotelTowels = {
		rolls = 4,
		items = {
			"BathTowel", 50,
			"BathTowel", 20,
			"BathTowel", 20,
			"BathTowel", 10,
			"BathTowel", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MovieRentalShelves = {
		rolls = 4,
		items = {
			"Magazine_Cinema_New", 10,
			"VHS_Retail", 50,
			"VHS_Retail", 20,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
			"VHS_Retail", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreBass = {
		isShop = true,
		rolls = 4,
		items = {
			"Flightcase", 4,
			"Guitarcase", 4,
			"GuitarElectricBass", 50,
			"GuitarElectricBass", 20,
			"Mov_BlackSpeakerCabinet", 4,
			"Mov_GuitarAmplifier", 20,
			"Mov_WoodSpeakerCabinet", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreBrass = {
		isShop = true,
		rolls = 4,
		items = {
			"Flute", 20,
			"Flute", 20,
			"Flute", 10,
			"Flute", 10,
			"Saxophone", 20,
			"Saxophone", 10,
			"Trumpet", 20,
			"Trumpet", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreCases = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_FluteCase", 10,
			"Bag_ProtectiveCaseBulky", 10,
			"Bag_SaxophoneCase", 10,
			"Bag_TrumpetCase", 10,
			"Bag_ViolinCase", 10,
			"Flightcase", 20,
			"Flightcase", 10,
			"Guitarcase", 20,
			"Guitarcase", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreCDs = {
		isShop = true,
		rolls = 4,
		items = {
			"CDplayer", 20,
			"CDplayer", 10,
			"Disc_Retail", 50,
			"Disc_Retail", 20,
			"Disc_Retail", 20,
			"Disc_Retail", 10,
			"Disc_Retail", 10,
			"Earbuds", 10,
			"Headphones", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreDrums = {
		isShop = true,
		rolls = 4,
		items = {
			"Drumstick", 50,
			"Drumstick", 20,
			"Mov_DrumStool", 20,
			"Mov_KickDrum", 10,
			"Mov_SnareDrum", 20,
			"Mov_TomDrum", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreGuitar = {
		isShop = true,
		rolls = 4,
		items = {
			"Flightcase", 4,
			"Guitarcase", 4,
			"GuitarElectric", 50,
			"GuitarElectric", 20,
			"Mov_BlackSpeakerCabinet", 4,
			"Mov_GuitarAmplifier", 20,
			"Mov_WoodSpeakerCabinet", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreLiterature = {
		isShop = true,
		rolls = 4,
		items = {
			"Book_Music", 20,
			"Book_Music", 10,
			"Magazine_Music_New", 20,
			"Magazine_Music_New", 20,
			"Magazine_Music_New", 10,
			"Magazine_Music_New", 10,
			"Paperback_Music", 20,
			"Paperback_Music", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreOthers = {
		isShop = true,
		rolls = 4,
		items = {
			"Harmonica", 50,
			"Harmonica", 20,
			"Keytar", 20,
			"Keytar", 20,
			"Keytar", 10,
			"Keytar", 10,
			"Magazine_Music_New", 20,
			"Magazine_Music_New", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreSpeaker = {
		isShop = true,
		rolls = 4,
		items = {
			"Microphone", 20,
			"Microphone", 10,
			"Mov_BlackSpeakerCabinet", 10,
			"Mov_GuitarAmplifier", 20,
			"Mov_GuitarAmplifier", 10,
			"Mov_WoodSpeakerCabinet", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	MusicStoreStringed = {
		isShop = true,
		rolls = 4,
		items = {
			"Violin", 20,
			"Violin", 10,
			"GuitarAcoustic", 20,
			"GuitarAcoustic", 20,
			"GuitarAcoustic", 10,
			"GuitarAcoustic", 10,
			"Banjo", 20,
			"Banjo", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	NolansDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Nolans", 1,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"Book_Romance", 50,
			"Calculator", 8,
			"CardDeck", 1,
			"Cigar", 50,
			"Cigar", 20,
			"CreditCard", 20,
			"CreditCard", 10,
			"Glasses_Aviators", 0.5,
			"Glasses_Prescription_Aviators", 0.05,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_Reading", 4,
			"Glasses_Sun", 1,
			"Gum", 20,
			"Hat_Cowboy", 50,
			"HolePuncher", 4,
			"Magazine_Car", 10,
			"MenuCard", 20,
			"MenuCard", 10,
			"MechanicMag1", 20,
			"MechanicMag2", 20,
			"MechanicMag3", 20,
			"Money", 50,
			"Money", 20,
			"MoneyBundle", 1,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperwork", 20,
			"Paperwork", 10,
			"PillsVitamins", 0.1,
			"PokerChips", 20,
			"PokerChips", 10,
			"TVMagazine", 8,
			"Whiskey", 0.1,
		},
		junk = ClutterTables.DeskJunk,
	},

	NolansFilingCabinet = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Nolans", 1,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"CarKey", 50,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"BusinessCard", 1,
			"IndexCard", 10,
			"MoneyBundle", 0.1,
			"Notebook", 10,
			"Paperwork", 20,
			"Paperwork", 10,
			"SheetPaper2", 50,
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"SheetPaper2", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	NolansFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Beer
			"BeerBottle", 8,
			"BeerCan", 8,
			"BeerCanPack", 0.1,
			"BeerImported", 4,
			"BeerPack", 0.1,
			-- Sausage
			"Baloney", 20,
			"BaloneySlice", 50,
			"BaloneySlice", 20,
			"BaloneySlice", 20,
			"BaloneySlice", 10,
			"Sausage", 20,
			"Sausage", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"BeerCanPack", 100,
			}
		}
	},

	NurseOutfit = {
		rolls = 4,
		items = {
			"Bag_MedicalBag", 0.5,
			"Bag_Satchel_Medical", 0.5,
			"BookFirstAid1", 6,
			"BookFirstAid2", 4,
			"BookFirstAid3", 2,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"FirstAidKit", 2,
			"Gloves_Surgical", 10,
			"HandTorch", 4,
			"Hat_SurgicalCap", 10,
			"Hat_SurgicalMask", 10,
			"Notepad", 10,
			"Pencil", 10,
			"PenLight", 6,
			"Shirt_Scrubs", 10,
			"Shoes_TrainerTINT", 8,
			"Trousers_Scrubs", 10,
			"Tshirt_Scrubs", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	NurseTools = {
		rolls = 4,
		items = {
			"AlcoholWipes", 20,
			"Bandage", 20,
			"Bandage", 20,
			"Bandaid", 20,
			"Bandaid", 20,
			"BookFirstAid1", 6,
			"BookFirstAid2", 4,
			"BookFirstAid3", 2,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"Disinfectant", 20,
			"Gloves_Surgical", 10,
			"HandTorch", 4,
			"Hat_SurgicalCap", 10,
			"Notepad", 10,
			"Pencil", 10,
			"PenLight", 6,
			"Pills", 20,
			"Pills", 20,
			"Scalpel", 10,
			"ScissorsBluntMedical", 10,
			"SutureNeedle", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	OfficeCounter = {
		rolls = 4,
		items = {
			"Book_Business", 1,
			"IndexCard", 10,
			"Magazine_Rich", 10,
			"MenuCard", 4,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Magazine_Rich", 10,
			"Paperback_Business", 4,
			"Paperback_Fiction", 1,
			"Paperwork", 20,
			"Paperwork", 10,
		},
		junk = ClutterTables.CounterJunk,
	},

	OfficeDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Literature
			"Book_Business", 1,
			"IndexCard", 10,
			"Magazine_Rich", 4,
			"MenuCard", 10,
			"Paperback_Business", 2,
			"Paperback_Fiction", 1,
			"Paperwork", 20,
			"Paperwork", 10,
			"StockCertificate", 1,
			-- Misc.
			"Gum", 4,
			"CreditCard", 2,
			"PillsVitamins", 0.1,
			-- Special
			"Cashbox", 0.1,
			"CigarBox", 0.05,
			"Diary2", 0.1,
			"Flask", 0.1,
			"MoneyBundle", 0.01,
		},
		junk = ClutterTables.DeskJunk,
	},

	OfficeDeskHome = {
		rolls = 4,
		items = {
			-- Keyrings (Personalized)
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- Literature
			"Book_Business", 4,
			"Book_Legal", 2,
			"IndexCard", 10,
			"Magazine_Rich", 4,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperback_Business", 8,
			"Paperback_Fiction", 4,
			"Paperback_Legal", 4,
			"Paperwork", 10,
			"Photo", 10,
			"Photo", 1,
			"StockCertificate", 10,
			-- Electronics/Music
			"Calculator", 8,
			"CDplayer", 4,
			"CordlessPhone", 8,
			"Disc_Retail", 4,
			"Earbuds", 4,
			"Headphones", 2,
			"Mov_BeigeRotaryPhone", 0.01,
			"Mov_BlackModernPhone", 0.1,
			"Mov_BlackRotaryPhone", 0.05,
			"RadioBlack", 4,
			"RadioRed", 2,
			"WalkieTalkie2", 2,
			"WalkieTalkie3", 1,
			-- Misc.
			"BottleOpener", 1,
			"CreditCard", 2,
			"Frame", 4,
			"Gum", 8,
			"KnifePocket", 0.1,
			"LetterOpener", 4,
			"MagnifyingGlass", 0.5,
			"Money", 10,
			"MoneyBundle", 0.01,
			"Pills", 0.5,
			"PillsVitamins", 0.1,
			-- Firearms
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"Pistol", 0.05,
			"Pistol2", 0.01,
			"Pistol3", 0.005,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"Revolver", 0.01,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			-- Special
			"Camera", 2,
			"CameraExpensive", 0.1,
			"CameraFilm", 1,
			"Cigar", 0.5,
			"CigarBox", 0.1,
			"Flask", 1,
			"Humidor", 0.001,
			"PenFancy", 4,
			"Pocketwatch", 0.5,
			"WristWatch_Left_Expensive", 0.001,
		},
		junk = ClutterTables.DeskJunk,
	},

	OfficeDeskHomeClassy = {
		rolls = 4,
		items = {
			-- Keyrings (Personalized)
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			"KeyRing_WestMaple", 0.1,
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- Literature
			"Book_Business", 4,
			"Book_Legal", 4,
			"Book_Rich", 4,
			"IndexCard", 10,
			"Magazine_Rich", 4,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperback_Business", 8,
			"Paperback_Fiction", 4,
			"Paperback_Legal", 4,
			"Paperback_Rich", 4,
			"Paperwork", 10,
			"Photo", 10,
			"Photo", 1,
			"StockCertificate", 20,
			-- Electronics/Music
			"Calculator", 8,
			"CDplayer", 4,
			"CordlessPhone", 8,
			"Disc_Retail", 4,
			"Earbuds", 4,
			"Headphones", 2,
			"Mov_BeigeRotaryPhone", 0.01,
			"Mov_BlackModernPhone", 0.1,
			"Mov_BlackRotaryPhone", 0.05,
			"RadioBlack", 4,
			"RadioRed", 2,
			"WalkieTalkie2", 2,
			"WalkieTalkie3", 1,
			-- Misc.
			"BottleOpener", 1,
			"Corkscrew", 1,
			"CreditCard", 2,
			"Frame", 4,
			"Gum", 8,
			"KnifePocket", 0.1,
			"LetterOpener", 4,
			"MagnifyingGlass", 0.5,
			"Money", 50,
			"Money", 20,
			"MoneyBundle", 0.5,
			"Pills", 0.5,
			"PillsVitamins", 0.1,
			-- Firearms
			"Bag_ProtectiveCaseSmall_Pistol1", 0.005,
			"Bag_ProtectiveCaseSmall_Pistol2", 0.0025,
			"Bag_ProtectiveCaseSmall_Pistol3", 0.0005,
			"Bag_ProtectiveCaseSmall_Revolver1", 0.005,
			"Bag_ProtectiveCaseSmall_Revolver2", 0.0025,
			"Bag_ProtectiveCaseSmall_Revolver3", 0.0005,
			"Pistol", 0.05,
			"Pistol2", 0.01,
			"Pistol3", 0.005,
			"PistolCase1", 0.005,
			"PistolCase2", 0.0025,
			"PistolCase3", 0.0005,
			"Revolver", 0.01,
			"RevolverCase1", 0.01,
			"RevolverCase2", 0.005,
			"RevolverCase3", 0.001,
			"Revolver_Long", 0.005,
			"Revolver_Short", 0.05,
			-- Special
			"CameraExpensive", 2,
			"CameraFilm", 1,
			"Cashbox", 0.5,
			"Champagne", 0.1,
			"Cigar", 1,
			"Flask", 1,
			"GemBag", 0.001,
			"HollowBook_Valuables", 0.001,
			"Humidor", 0.1,
			"Passport", 0.01,
			"PenFancy", 8,
			"Pocketwatch", 1,
			"SmallGoldBar", 0.001,
			"SmallSilverBar", 0.005,
			"WristWatch_Left_Expensive", 0.1,
		},
		junk = ClutterTables.DeskJunk,
	},

	OfficeDeskSecretary = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_BlueFox", 0.005,
			"KeyRing_Kitty", 0.005,
			"KeyRing_Panther", 0.005,
			"KeyRing_PrayingHands", 0.005,
			"KeyRing_RainbowStar", 0.005,
			"KeyRing_RubberDuck", 0.005,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Literature
			"Book_Business", 4,
			"Magazine_Fashion", 4,
			"Magazine_Popular", 10,
			"Paperback_Diet", 1,
			"Paperback_Fashion", 1,
			"Paperback_Fiction", 6,
			"Paperback_Relationship", 1,
			"Paperback_Romance", 1,
			"Paperback_SelfHelp", 1,
			"Paperback_TrueCrime", 1,
			-- Cosmetic
			"Comb", 8,
			"Lipstick", 8,
			"MakeupEyeshadow", 8,
			"MakeupFoundation", 8,
			"Mirror", 8,
			"Perfume", 8,
			-- Misc.
			"CordlessPhone", 4,
			"CreditCard", 2,
			"Gum", 8,
			"Handbag", 4,
			"IndexCard", 10,
			"MenuCard", 10,
			"Paperwork", 10,
			"Paperwork", 20,
			"PillsVitamins", 0.1,
			"Purse", 4,
			-- Special
			"Diary2", 0.1,
			"Flask", 0.1,
		},
		junk = ClutterTables.DeskJunk,
	},

	OfficeDeskStressed = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.005,
			"KeyRing_EagleFlag", 0.005,
			"KeyRing_EightBall", 0.005,
			"KeyRing_Panther", 0.005,
			"KeyRing_PineTree", 0.005,
			"KeyRing_Sexy", 0.005,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"Book_Business", 4,
			"CigarettePack", 10,
			"CreditCard", 2,
			"Diary2", 0.1,
			"Flask", 4,
			"HottieZ", 1,
			"IndexCard", 10,
			"HollowBook_Whiskey", 0.001,
			"LighterDisposable", 6,
			"Magazine_Rich", 10,
			"MenuCard", 10,
			"MoneyBundle", 0.1,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperback_Business", 8,
			"Paperback_Conspiracy", 2,
			"Paperback_Quackery", 2,
			"Paperback_SelfHelp", 2,
			"Paperwork", 20,
			"Paperwork", 10,
			"Photo_Secret", 1,
			"Pills", 8,
			"PillsAntiDep", 10,
			"PokerChips", 10,
			"Revolver_Short", 0.05,
			"ScratchTicket_Loser", 10,
			"StockCertificate", 1,
			"Whiskey", 4,
			"WhiskeyEmpty", 8,
		},
		junk = ClutterTables.DeskJunk,
	},

	OfficeDrawers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.001,
			"KeyRing_Bug", 0.001,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.001,
			"KeyRing_Kitty", 0.001,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.001,
			"KeyRing_RubberDuck", 0.001,
			"KeyRing_Sexy", 0.001,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"BluePen", 8,
			"BusinessCard", 1,
			"Calculator", 8,
			"Clipboard", 8,
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Doodle", 1,
			"Eraser", 8,
			"Glue", 2,
			"GreenPen", 4,
			"HolePuncher", 4,
			"IndexCard", 10,
			"LetterOpener", 1,
			"Magazine_Business", 10,
			"Magazine_Rich", 4,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Note", 20,
			"Note", 10,
			"Notebook", 10,
			"Notepad", 8,
			"Paperback_Business", 8,
			"Paperclip", 10,
			"PaperclipBox", 1,
			"Paperwork", 20,
			"Paperwork", 10,
			"Pen", 8,
			"Pencil", 10,
			"RadioBlack", 2,
			"RadioRed", 1,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"Stapler", 4,
			"Staples", 10,
			"StockCertificate", 1,
			"TVMagazine", 4,
			"Twine", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	OfficeShelfSupplies = {
		rolls = 4,
		items = {
			"AdhesiveTapeBox", 0.1,
			"BluePen", 8,
			"BusinessCard", 1,
			"Calculator", 8,
			"Clipboard", 8,
			"Glue", 2,
			"GreenPen", 4,
			"HolePuncher", 4,
			"IndexCard", 10,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Notebook", 20,
			"Notebook", 10,
			"Notepad", 8,
			"Paperclip", 10,
			"PaperclipBox", 1,
			"Pen", 8,
			"Pencil", 10,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			"SheetPaper2", 10,
			"Stapler", 10,
			"Staples", 4,
			"Twine", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	OptometristDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Literature
			"BookGlassmaking1", 10,
			"BookGlassmaking2", 8,
			"BookGlassmaking3", 6,
			"BookGlassmaking4", 4,
			"BookGlassmaking5", 2,
			"Book_Medical", 4,
			"Diary2", 0.1,
			"Magazine_Health", 10,
			"Paperback_Fiction", 4,
			"Paperback_Medical", 8,
			-- Stationery/Office
			"Paperwork", 20,
			"Paperwork", 10,
			"PenLight", 4,
			-- Misc.
			"Flask", 0.1,
			"Gum", 4,
			"IndexCard", 10,
			"MenuCard", 10,
			"Whiskey", 0.1,
		},
		junk = ClutterTables.DeskJunk,
	},

	OptometristGlasses = {
		isShop = true,
		rolls = 4,
		items = {
			"Glasses_Normal", 20,
			"Glasses_Normal", 10,
			"Glasses_Prescription", 8,
			"Glasses_Prescription_Aviators", 4,
			"Glasses_Prescription_Sun", 8,
			"Glasses_Reading", 20,
			"Glasses_Reading", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Mirror", 100,
			}
		}
	},

	OtherGeneric = {
		rolls = 1,
		items = {
			"Battery", 8,
			"BluePen", 8,
			"Book", 2,
			"BoxOfJars", 0.01,
			"Brochure", 2,
			"Calculator", 1,
			"Candle", 2,
			"CigarettePack", 1,
			"Clipboard", 1,
			"Doodle", 1,
			"EmptyJar", 0.5,
			"Eraser", 8,
			"Flier", 2,
			"Garbagebag", 10,
			"Garbagebag_box", 1,
			"Glue", 2,
			"GreenPen", 4,
			"HandTorch", 8,
			"JarLid", 0.5,
			"KnifePocket", 0.1,
			"LighterDisposable", 4,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Matches", 8,
			"Newspaper", 10,
			"Notebook", 4,
			"Notepad", 10,
			"Paperback", 10,
			"NutsBolts", 8,
			"Paperback", 8,
			"Paperclip", 10,
			"PaperclipBox", 1,
			"Pen", 8,
			"Pencil", 10,
			"Receipt", 10,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			"SheetPaper2", 10,
			"Tissue", 10,
			"TissueBox", 1,
			"Torch", 4,
			"TVMagazine", 4,
			"Twine", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
			}
		}
	},

	PawnShopCases = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_FluteCase", 10,
			"Bag_ProtectiveCase", 10,
			"Bag_ProtectiveCaseBulky", 10,
			"Bag_ProtectiveCaseSmall", 10,
			"Bag_RifleCase", 10,
			"Bag_RifleCaseCloth", 10,
			"Bag_SaxophoneCase", 10,
			"Bag_TrumpetCase", 10,
			"Bag_ViolinCase", 10,
			"Briefcase", 10,
			"Flightcase", 10,
			"Guitarcase", 10,
			"PistolCase1", 10,
			"Suitcase", 10,
			"Toolbox", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PawnShopGuns = {
		isShop = true,
		rolls = 4,
		items = {
			"44Clip", 8,
			"45Clip", 8,
			"9mmClip", 8,
			"AmmoStrap_Bullets", 10,
			"AmmoStrap_Shells", 10,
			"Bullets38Box", 10,
			"Bullets44Box", 10,
			"Bullets45Box", 10,
			"Bullets9mmBox", 10,
			"ChokeTubeFull", 4,
			"ChokeTubeImproved", 2,
			"DoubleBarrelShotgun", 8,
			"HolsterAnkle", 1,
			"HolsterDouble", 10,
			"HolsterShoulder", 4,
			"HolsterSimple", 20,
			"HolsterSimple", 10,
			"MilitaryMedal", 1,
			"Pistol", 8,
			"Pistol2", 6,
			"Pistol3", 4,
			"RecoilPad", 4,
			"RedDot", 1,
			"Revolver", 6,
			"Revolver_Long", 4,
			"Revolver_Short", 8,
			"Shotgun", 10,
			"ShotgunShellsBox", 10,
			"x2Scope", 4,
			"x4Scope", 2,
			"x8Scope", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PawnShopGunsSpecial = {
		rolls = 4,
		items = {
			"308Box", 20,
			"556Box", 10,
			"556Clip", 10,
			"AmmoStrap_Bullets", 10,
			"AmmoStrap_Shells", 10,
			"AssaultRifle", 0.25,
			"AssaultRifle2", 1,
			"Bag_ALICE_BeltSus_Camo", 0.5,
			"Bag_ALICE_BeltSus_Green", 0.5,
			"Bag_AmmoBox_Mixed", 10,
			"Bag_ChestRig", 1,
			"Bag_Military", 1,
			"Bag_MoneyBag", 1,
			"Bag_ProtectiveCaseBulkyAmmo", 10,
			"Bag_ProtectiveCaseSmall_Armorer", 1,
			"Bag_ProtectiveCaseSmall_Pistol3", 2,
			"Bag_ProtectiveCaseSmall_Revolver3", 2,
			"Bag_ShotgunCaseCloth", 2,
			"Bag_ShotgunCaseCloth2", 2,
			"Bag_WeaponBag", 1,
			"Base.HempBagSeed", 1,
			"Bullets44Box", 10,
			"Bullets45Box", 10,
			"CameraFilm", 1,
			"CanteenMilitary", 1,
			"ChokeTubeFull", 8,
			"ChokeTubeImproved", 8,
			"DoubleBarrelShotgun", 4,
			"ElbowPad_Left_Tactical", 1,
			"FirstAidKit_Military", 4,
			"FirstAidKit_Camping", 4,
			"FlashLight_AngleHead_Army", 1,
			"GemBag", 0.01,
			"HolsterAnkle", 1,
			"HolsterDouble", 10,
			"HolsterShoulder", 4,
			"HolsterSimple", 20,
			"HolsterSimple", 10,
			"IDcard_Blank", 1,
			"Katana", 0.1,
			"Kneepad_Left_Tactical", 1,
			"KnifeButterfly", 1,
			"M14Clip", 10,
			"Machete", 2,
			"Magazine_Firearm", 10,
			"Magazine_Military", 10,
			"ManPackRadio", 0.5,
			"MilitaryMedal", 1,
			"Mov_FlagUSA", 4,
			"Mov_FlagUSALarge", 1,
			"Pistol3", 4,
			"PistolCase3", 2,
			"RecoilPad", 10,
			"RedDot", 10,
			"RevolverCase3", 2,
			"Revolver_Long", 4,
			"RifleCase3", 1,
			"RifleCase4", 0.25,
			"Shotgun", 4,
			"ShotgunCase1", 2,
			"ShotgunCase2", 2,
			"ShotgunShellsBox", 10,
			"SwitchKnife", 1,
			"ThighProtective_L", 0.1,
			"Vest_BulletCivilian", 2,
			"WristWatch_Left_Expensive", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"x2Scope", 10,
			"x4Scope", 8,
			"x8Scope", 6,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PawnShopKnives = {
		isShop = true,
		rolls = 4,
		items = {
			"Axe_Old", 0.5,
			"EntrenchingTool", 4,
			"FightingKnife", 0.1,
			"Fleshing_Tool", 20,
			"Fleshing_Tool", 10,
			"HandAxe_Old", 4,
			"Handiknife", 2,
			"HuntingKnife", 10,
			"IceAxe", 4,
			"JawboneBovide_Club", 0.01,
			"Katana", 0.1,
			"KnifeButterfly", 10,
			"KnifePocket", 2,
			"LargeKnife", 4,
			"Mace", 0.1,
			"Machete", 1,
			"Multitool", 0.5,
			"SmallKnife", 10,
			"SwitchKnife", 10,
			"Sword", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PawnShopTools = {
		isShop = true,
		rolls = 4,
		items = {
			"Axe_Old", 0.05,
			"BallPeenHammerForged", 2,
			"BlowerFan", 1,
			"BoltCutters", 8,
			"Calipers", 4,
			"ClubHammerForged", 1,
			"CrowbarForged", 1,
			"File", 4,
			"Fleshing_Tool", 4,
			"HammerForged", 4,
			"HandAxeForged", 1,
			"HandAxe_Old", 1,
			"HandDrill", 4,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 4,
			"PickAxeForged", 0.1,
			"PipeWrench", 4,
			"Pliers", 10,
			"Screwdriver", 10,
			"ScytheForged", 0.1,
			"SheetMetalSnips", 4,
			"SledgehammerForged", 0.01,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"ViseGrips", 10,
			"Whetstone", 10,
			"WoodAxe", 0.2,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PetShopShelf = {
		isShop = true,
		rolls = 4,
		items = {
			-- Accessories
			"DogTag_Pet_Blank", 20,
			"DogTag_Pet_Blank", 10,
			"KeyRing_Kitty", 4,
			"Leash", 20,
			"Leash", 10,
			-- Food
			"CatFoodBag", 10,
			"CatTreats", 10,
			"Dogfood", 20,
			"Dogfood", 10,
			"DogFoodBag", 10,
			"WaterDishEmpty", 20,
			"WaterDishEmpty", 10,
			-- Toys
			"CatToy", 20,
			"CatToy", 10,
			"DogChew", 20,
			"DogChew", 10,
			"Rubberducky", 20,
			"Rubberducky", 10,
			"TennisBall", 20,
			"TennisBall", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PharmacyCosmetics = {
		isShop = true,
		rolls = 4,
		items = {
			"Cologne", 8,
			"HairDryer", 10,
			"HairIron", 10,
			"HairDyeCommon", 8,
			"HairDyeUncommon", 2,
			"Hairgel", 4,
			"Hairgel", 4,
			"Hairspray2", 6,
			"Hairspray2", 6,
			"Lipstick", 10,
			"Lipstick", 10,
			"MakeupEyeshadow", 10,
			"MakeupFoundation", 10,
			"Perfume", 8,
			"Razor", 4,
			"Soap2", 4,
			"Toothbrush", 4,
			"Toothpaste", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	Photographer = {
		rolls = 4,
		items = {
			"Bag_SatchelPhoto", 10,
			"Book_Art", 4,
			"Camera", 20,
			"Camera", 10,
			"CameraExpensive", 4,
			"CameraFilm", 20,
			"CameraFilm", 10,
			"Mov_Projector", 0.1,
			"Paperback_Art", 8,
			"Photo", 50,
			"Photo", 20,
			"Photo", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.1,
				"CaseyPic", 0.1,
				"ChrisPic", 0.1,
				"CortmanPic", 0.1,
				"HankPic", 0.1,
				"JamesPic", 0.1,
				"KatePic", 0.1,
				"MariannePic", 0.1,
			}
		}
	},

	PizzaKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Pizza
			"PizzaRecipe", 1,
			-- Ingredients
			"Flour2", 20,
			"Flour2", 10,
			"OilOlive", 4,
			"Yeast", 4,
			-- Misc.
			"Aluminum", 8,
			"DishCloth", 10,
			"OvenMitt", 10,
			-- Utensils
			"BakingTray", 10,
			"BreadKnife", 8,
			"CheeseGrater", 10,
			"KitchenTongs", 10,
			"Ladle", 10,
			"PizzaCutter", 10,
			"RollingPin", 8,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PizzaKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Misc.
			"Bacon", 4,
			"Ham", 2,
			"MincedMeat", 4,
			"Pepperoni", 8,
			"Salami", 4,
			"Sausage", 4,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Twine", 10,
			"Whetstone", 10,
			-- Utensils
			"Fleshing_Tool", 10,
			"CheeseGrater", 10,
			"KitchenKnife", 6,
			"LargeKnife", 2,
			"MeatCleaver", 4,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PizzaKitchenCheese = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Cheese
			"Cheese", 20,
			"Cheese", 10,
			-- Utensils
			"CheeseGrater", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"CheeseGrater", 100,
			}
		}
	},

	PizzaKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 4,
			"Ham", 2,
			"MincedMeat", 4,
			"Pepperoni", 8,
			"Salami", 4,
			"Sausage", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PizzaKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 4,
			"Ham", 2,
			"MincedMeat", 4,
			"Pepperoni", 8,
			"Salami", 4,
			"Sausage", 4,
			-- Vegetables
			"BellPepper", 4,
			"Onion", 4,
			"PepperJalapeno", 4,
			"Tomato", 4,
			-- Fruit
			"Pineapple", 1,
			-- Cheese
			"Cheese", 8,
			-- Dough
			"Dough", 20,
			"Dough", 10,
			-- Pizza
			"PizzaRecipe", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PizzaKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Condiments
			"BBQSauce", 2,
			"PowderedGarlic", 6,
			"PowderedOnion", 6,
			"TomatoPaste", 20,
			"TomatoPaste", 10,
			"Seasoning_Basil", 6,
			"Seasoning_Oregano", 6,
			-- Utensils
			"Ladle", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Ladle", 100,
			}
		}
	},

	PlankStashGold = {
		rolls = 4,
		items = {
			"SmallGoldBar", 50,
			"SmallGoldBar", 20,
			"SmallGoldBar", 20,
			"SmallGoldBar", 10,
			"SmallGoldBar", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PlankStashGun = {
		rolls = 4,
		items = {
			"CigaretteCarton", 0.1,
			"CigarettePack", 4,
			"CreditCard", 10,
			"CreditCard", 10,
			"Flask", 2,
			"HollowBook_Handgun", 0.001,
			"HolsterAnkle", 1,
			"HolsterDouble", 4,
			"HolsterShoulder", 2,
			"HolsterSimple_Brown", 8,
			"IDcard_Blank", 1,
			"KnifeButterfly", 1,
			"MilitaryMedal", 1,
			"Money", 20,
			"Money", 10,
			"Pistol", 10,
			"Pistol2", 6,
			"Pistol3", 2,
			"Revolver", 6,
			"Revolver_Long", 2,
			"Revolver_Short", 10,
			"SwitchKnife", 1,
			"Whiskey", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"Revolver_Short", 20,
			}
		}
	},

	PlankStashMagazine = {
		rolls = 4,
		items = {
			"CigaretteCarton", 0.1,
			"CigarettePack", 4,
			"Flask", 2,
			"HollowBook_Whiskey", 0.001,
			"HottieZ", 20,
			"HottieZ", 20,
			"HottieZ", 10,
			"HottieZ", 10,
			"Magazine_Car", 10,
			"Magazine_Crime", 10,
			"Magazine_Firearm", 10,
			"Magazine_Military", 10,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"TVMagazine", 8,
			"Tissue", 10,
			"TissueBox", 1,
			"Whiskey", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"HottieZ", 100,
				"Tissue", 100,
			}
		}
	},

	PlankStashMisc = {
		rolls = 4,
		items = {
			"Base.HempBagSeed", 1,
			"Bracelet_BangleRightGold", 8,
			"Bracelet_ChainRightGold", 8,
			"CigaretteCarton", 0.1,
			"CigarettePack", 4,
			"CreditCard", 10,
			"Diamond", 1,
			"Earring_LoopLrg_Gold", 8,
			"Earring_LoopMed_Gold", 8,
			"Earring_LoopSmall_Gold_Both", 8,
			"Earring_LoopSmall_Gold_Top", 8,
			"Earring_Stud_Gold", 8,
			"Emerald", 1,
			"Flask", 2,
			"HempMag1", 4,
			"HollowBook_Whiskey", 0.001,
			"IDcard_Blank", 1,
			"Locket", 10,
			"MilitaryMedal", 0.1,
			"Money", 50,
			"Money", 20,
			"Money", 10,
			"Money", 10,
			"NecklaceLong_Gold", 8,
			"NecklaceLong_GoldDiamond", 4,
			"Necklace_Gold", 8,
			"Necklace_GoldDiamond", 4,
			"Necklace_GoldRuby", 4,
			"Pocketwatch", 8,
			"PokerChips", 10,
			"Ring_Left_RingFinger_Gold", 8,
			"Ruby", 1,
			"Sapphire", 1,
			"SilverBar", 2,
			"SmallGoldBar", 4,
			"SmallSilverBar", 8,
			"StockCertificate", 20,
			"StockCertificate", 10,
			"Wallet", 20,
			"Whiskey", 2,
			"WristWatch_Left_ClassicGold", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PlankStashMoney = {
		rolls = 4,
		items = {
			"CreditCard", 20,
			"CreditCard", 10,
			"Diamond", 4,
			"Emerald", 4,
			"GemBag", 2,
			"HollowBook_Valuables", 0.001,
			"IDcard_Blank", 1,
			"MoneyBundle", 100,
			"MoneyBundle", 50,
			"MoneyBundle", 20,
			"Pocketwatch", 8,
			"Ruby", 4,
			"Sapphire", 4,
			"SilverBar", 2,
			"SmallGoldBar", 4,
			"SmallSilverBar", 8,
			"StockCertificate", 20,
			"StockCertificate", 20,
			"StockCertificate", 10,
			"StockCertificate", 10,
			"Wallet", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PlumbingSupplies = {
		rolls = 4,
		items = {
			"BlowTorch", 10,
			"BoltCutters", 8,
			"CopperScrap", 10,
			"LeadPipe", 20,
			"LeadPipe", 10,
			"MetalPipe", 20,
			"MetalPipe", 10,
			"NutsBolts", 8,
			"Oxygen_Tank", 10,
			"Pipe", 20,
			"Pipe", 10,
			"PipeWrench", 10,
			"Plunger", 10,
			"Propane_Refill", 10,
			"ScrapMetal", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceCaptainCabinet = {
		rolls = 4,
		items = {
			-- Alcohol
			"Brandy", 8,
			"Champagne", 2,
			"Port", 4,
			"Scotch", 8,
			"Vermouth", 4,
			"Whiskey", 8,
			"Wine", 8,
			"Wine2", 8,
			"WineAged", 2,
			-- Tobacco/Smoking
			"CigarBox", 4,
			"Matchbox", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"Corkscrew", 8,
				"GlassWine", 50,
				"GlassWine", 20,
				"BottleOpener", 10,
				"IcePick", 2,
			}
		}
	},

	PoliceCaptainDesk = {
		rolls = 2,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_SecurityPass", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Outfit
			"HolsterShoulder", 2,
			"HolsterSimple_Black", 8,
			-- Weapons
			"Revolver_Long", 1,
			-- Food
			"DoughnutChocolate", 1,
			"DoughnutFrosted", 1,
			"DoughnutJelly", 1,
			"DoughnutPlain", 1,
			"Danish", 1,
			-- Literature
			"ArmorMag7", 0.001,
			"Book_Legal", 4,
			"Diary2", 0.1,
			"Journal", 10,
			"Magazine_Crime", 4,
			"Magazine_Police", 10,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Notepad", 10,
			"Paperback_CrimeFiction", 4,
			"Paperback_Legal", 8,
			-- Misc.
			"CardDeck", 8,
			"Flask", 0.1,
			"MagnifyingGlass", 1,
			"Paperwork", 20,
			"Paperwork", 10,
			"Pills", 1,
			"PillsVitamins", 1,
			-- Special
			"Badge", 4,
			"Briefcase_Money", 0.01,
			"Cigar", 8,
			"CigarBox", 1,
			"Matchbox", 8,
		},
		junk = ClutterTables.DeskJunk,
	},

	PoliceDesk = {
		rolls = 2,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_SecurityPass", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Outfit
			"Glasses_Aviators", 1,
			"Glasses_Sun", 2,
			"HandTorch", 4,
			"HolsterShoulder", 1,
			"HolsterSimple_Black", 4,
			"WalkieTalkie4", 1,
			"Zipties", 10,
			-- Weapons
			"Nightstick", 2,
			"Pistol", 0.1,
			-- Food
			"DoughnutChocolate", 1,
			"DoughnutFrosted", 1,
			"DoughnutJelly", 1,
			"DoughnutPlain", 1,
			"Danish", 1,
			-- Literature
			"ArmorMag7", 0.001,
			"Book_Legal", 4,
			"Diary2", 0.1,
			"Journal", 10,
			"Magazine_Crime", 4,
			"Magazine_Police", 10,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Notepad", 10,
			"Paperback_CrimeFiction", 4,
			"Paperback_Legal", 8,
			-- Misc.
			"Camera", 2,
			"CameraFilm", 1,
			"CameraFilm", 2,
			"CardDeck", 8,
			"Flask", 0.1,
			"Gum", 10,
			"MagnifyingGlass", 1,
			"MenuCard", 10,
			"Paperwork", 10,
			"Paperwork", 20,
			"Photo", 1,
			"Pills", 1,
			"PillsVitamins", 1,
			"PokerChips", 2,
			-- Special
			"IDcard", 2,
			"IDcard", 1,
			"MoneyBundle", 0.001,
			"Photo_Secret", 2,
			"Photo_Secret", 1,
			-- Moveables
			"Mov_BlackModernPhone", 0.01,
		},
		junk = ClutterTables.DeskJunk,
	},

	PoliceEvidence = {
		rolls = 1,
		items = {
			-- Tools
			"Axe", 0.05,
			"BallPeenHammer", 6,
			"BlowTorch", 8,
			"BoltCutters", 8,
			"ClubHammer", 4,
			"Crowbar", 4,
			"Hammer", 8,
			"HandAxe", 10,
			"HandDrill", 4,
			"Machete", 1,
			"PipeWrench", 6,
			"Pliers", 8,
			"Ratchet", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"SheetMetalSnips", 4,
			"Shovel", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"WoodenMallet", 4,
			"Wrench", 8,
			-- Weapons
			"BaseballBat", 8,
			"BaseballBat_Metal", 4,
			"SwitchKnife", 10,
			"HuntingKnife", 4,
			"KnifeButterfly", 10,
			"KnifePocket", 2,
			"LargeKnife", 4,
			"SmallKnife", 10,
			-- Literature (Recipes)
			"ArmorMag3", 4,
			"ArmorMag7", 4,
			"EngineerMagazine2", 4,
			"ExplosiveSchematic", 10,
			"HempMag1", 10,
			"KeyMag1", 8,
			"TrickMag1", 8,
			"WeaponMag3", 4,
			"WeaponMag4", 4,
			"WeaponMag5", 4,
			"MeleeWeaponSchematic", 10,
			-- Literature (Generic)
			"Diary1", 10,
			"Diary2", 10,
			"GenericMail", 20,
			"GenericMail", 10,
			"LetterHandwritten", 20,
			"LetterHandwritten", 10,
			-- Electronics
			"CordlessPhone", 1,
			"HomeAlarm", 10,
			"Mov_DesktopComputer", 1,
			-- Money
			"MoneyBundle", 50,
			"MoneyBundle", 20,
			-- Stationery/Office
			"Clipboard", 20,
			"Clipboard", 10,
			"IndexCard", 20,
			"IndexCard", 10,
			"Journal", 20,
			"Journal", 10,
			"Note", 20,
			"Note", 10,
			"Notebook", 20,
			"Notebook", 10,
			"Notepad", 20,
			"Notepad", 10,
			"Paperwork", 200,
			"Paperwork", 100,
			"Paperwork", 20,
			"Paperwork", 10,
			-- Pills
			"Pills", 20,
			"Pills", 10,
			-- Photography
			"CameraFilm", 200,
			"CameraFilm", 100,
			"CameraFilm", 20,
			"CameraFilm", 10,
			"Photo", 10,
			"Photo_Secret", 20,
			"Photo_Secret", 10,
			-- Watches/Jewellery
			"NecklaceLong_Gold", 1,
			"NecklaceLong_GoldDiamond", 0.4,
			"Necklace_Gold", 1,
			"Necklace_GoldDiamond", 0.4,
			"Necklace_GoldRuby", 0.6,
			"Ring_Left_RingFinger_Gold", 1,
			"Ring_Left_RingFinger_Gold", 1,
			"Ring_Left_RingFinger_GoldDiamond", 0.8,
			"Ring_Left_RingFinger_GoldRuby", 0.8,
			"WristWatch_Left_ClassicGold", 0.8,
			"WristWatch_Left_DigitalDress", 0.8,
			"WristWatch_Left_Expensive", 0.1,
			-- Misc.
			"CigaretteCarton", 1,
			"CreditCard", 10,
			"HempBagSeed", 10,
			"IDcard", 20,
			"IDcard", 10,
			"IDcard_Blank", 1,
			"MagnifyingGlass", 1,
			"StockCertificate", 10,
			"Zipties", 10,
			-- Guns
			"DoubleBarrelShotgun", 8,
			"DoubleBarrelShotgunSawnoff", 8,
			"Pistol", 8,
			"Revolver", 6,
			"Revolver_Short", 8,
			"Shotgun", 8,
			"ShotgunSawnoff", 8,
			"VarmintRifle", 8,
			-- Accessories
			"Vest_BulletCivilian", 2,
			"HolsterShoulder", 8,
			-- Bags/Containers
			"Bag_BurglarBag", 1,
			"Bag_Dancer", 1,
			"Bag_MoneyBag", 1,
			"Bag_WeaponBag", 1,
			"Briefcase_Money", 1,
			-- Special
			"GemBag", 1,
			"SuspiciousPackage", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceFileBox = {
		rolls = 4,
		items = {
			-- Paperwork
			"Paperwork", 200,
			"Paperwork", 100,
			"Paperwork", 50,
			"Paperwork", 20,
			-- Evidence
			"CameraFilm", 200,
			"CameraFilm", 100,
			"CameraFilm", 20,
			"CameraFilm", 10,
			"IDcard", 4,
			"Photo_Secret", 20,
			"Photo_Secret", 10,
			"StockCertificate", 4,
			-- Special
			"Briefcase_Money", 0.001,
			-- Moveables
			"Mov_DesktopComputer", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceFilingCabinet = {
		rolls = 4,
		items = {
			-- Stationery/Office
			"Clipboard", 10,
			"Notebook", 6,
			"Notepad", 10,
			"Note", 20,
			"Note", 10,
			"SheetPaper2", 50,
			"SheetPaper2", 20,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			-- Paperwork
			"Paperwork", 200,
			"Paperwork", 100,
			"Paperwork", 50,
			"Paperwork", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Includes a red/blue lightbar for police cars.
	PoliceStorageMechanics = {
		rolls = 4,
		items = {
			-- Tools
			"BlowerFan", 1,
			"BlowTorch", 4,
			"Calipers", 2,
			"File", 4,
			"Funnel", 10,
			"HandDrill", 4,
			"Jack", 2,
			"LargeHook", 2,
			"LugWrench", 8,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 4,
			"Pliers", 8,
			"Ratchet", 10,
			"Screwdriver", 10,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"TireIron", 4,
			"TirePump", 8,
			"ViseGrips", 4,
			-- Materials
			"DuctTape", 4,
			"ElectricWire", 10,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"HeavyChain", 8,
			"HeavyChain_Hook", 1,
			"NutsBolts", 10,
			"RubberHose", 10,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.1,
			"WeldingRods", 8,
			-- Accessories
			"WeldingMask", 1,
			"ElbowPad_Left_Workman", 1,
			"Kneepad_Left_Workman", 4,
			-- Lights/Electronics
			"CarBatteryCharger", 1,
			"Battery", 10,
			"BatteryBox", 1,
			"LightbarRedBlue", 20,
			-- Bags/Containers
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			-- Misc.
			"CopperScrap", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	PoliceLockers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_SecurityPass", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- TODO: Sort Me!
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_MedicalBag", 0.1,
			"Bag_Police", 0.2,
			"Bag_Satchel", 0.2,
			"Bag_Satchel_Medical", 0.1,
			"Belt2", 4,
			"BookAiming1", 1,
			"BookAiming2", 0.8,
			"BookAiming3", 0.6,
			"BookAiming4", 0.4,
			"BookAiming5", 0.2,
			"BookReloading1", 1,
			"BookReloading2", 0.8,
			"BookReloading3", 0.6,
			"BookReloading4", 0.4,
			"BookReloading5", 0.2,
			"Briefcase", 0.2,
			"Bullhorn", 1,
			"Camera", 2,
			"CameraFilm", 2,
			"CameraFilm", 1,
			"CDplayer", 2,
			"Danish", 1,
			"Disc_Retail", 2,
			"DoughnutChocolate", 1,
			"DoughnutFrosted", 1,
			"DoughnutJelly", 1,
			"DoughnutPlain", 1,
			"Earbuds", 1,
			"FirstAidKit", 4,
			"FirstAidKit_NewPro", 4,
			"Flask", 0.1,
			"Glasses_Aviators", 1,
			"Glasses_Sun", 2,
			"Gum", 10,
			"Handbag", 0.5,
			"HandTorch", 4,
			"Hat_CrashHelmet_Police", 1,
			"Hat_EarMuff_Protectors", 8,
			"Hat_Police", 4,
			"Headphones", 1,
			"HolsterAnkle", 1,
			"HolsterShoulder", 2,
			"HolsterSimple_Black", 8,
			"Jacket_Police", 4,
			"Kneepad_Left_Tactical", 1,
			"Lunchbag", 1,
			"Lunchbox", 1,
			"Lunchbox2", 0.01,
			"Magazine", 4,
			"Magazine_Crime", 4,
			"Magazine_Police", 10,
			"Money", 4,
			"MoneyBundle", 0.001,
			"Nightstick", 2,
			"Paperback_CrimeFiction", 4,
			"Paperback_Legal", 8,
			"Purse", 0.5,
			"Shirt_OfficerWhite", 6,
			"Shirt_PoliceBlue", 10,
			"Shoes_Random", 8,
			"Sportsbottle", 1,
			"Suitcase", 0.2,
			"TobaccoChewing", 1,
			"Trousers_Police", 8,
			"Tshirt_PoliceBlue", 10,
			"Vest_BulletPolice", 2,
			"WalkieTalkie4", 1,
			"Whistle", 2,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			"Zipties", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"Bag_MoneyBag", 0.0001,
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	PoliceOutfit = {
		rolls = 3,
		items = {
			"Bag_Police", 0.5,
			"Glasses_Aviators", 10,
			"Gloves_LeatherGlovesBlack", 10,
			"Hat_CrashHelmet_Police", 0.5,
			"Hat_EarMuff_Protectors", 1,
			"Hat_Police", 10,
			"HolsterAnkle", 1,
			"HolsterShoulder", 2,
			"HolsterSimple_Black", 8,
			"Jacket_Police", 10,
			"KeyRing_SecurityPass", 10,
			"Kneepad_Left_Tactical", 1,
			"KnifePocket", 1,
			"Notepad", 10,
			"Pen", 8,
			"Pistol", 10,
			"Shirt_OfficerWhite", 6,
			"Shirt_PoliceBlue", 10,
			"Shoes_Random", 10,
			"Shotgun", 8,
			"Trousers_Police", 10,
			"Tshirt_PoliceBlue", 4,
			"Tshirt_Profession_PoliceBlue", 4,
			"Vest_BulletPolice", 4,
			"WalkieTalkie4", 10,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceStateOutfit = {
		rolls = 3,
		items = {
			"Bag_Police", 0.5,
			"Glasses_Aviators", 10,
			"Gloves_LeatherGlovesBlack", 10,
			"Hat_CrashHelmet_Police", 0.5,
			"Hat_EarMuff_Protectors", 1,
			"Hat_Police_Grey", 10,
			"HolsterAnkle", 1,
			"HolsterShoulder", 2,
			"HolsterSimple_Brown", 8,
			"Jacket_Police", 10,
			"KeyRing_SecurityPass", 10,
			"Kneepad_Left_Tactical", 1,
			"KnifePocket", 1,
			"Notepad", 10,
			"Pen", 8,
			"Pistol2", 4,
			"Revolver_Long", 6,
			"Revolver_Short", 10,
			"Shirt_OfficerWhite", 6,
			"Shirt_PoliceGrey", 6,
			"Shoes_Random", 10,
			"Shotgun", 8,
			"Trousers_PoliceGrey", 10,
			"Tshirt_PoliceGrey", 4,
			"Tshirt_Profession_PoliceWhite", 4,
			"Vest_BulletPolice", 4,
			"WalkieTalkie4", 10,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceStateTools = {
		rolls = 3,
		items = {
			"45Clip", 2,
			"AmmoStrap_Bullets", 4,
			"AmmoStrap_Shells", 4,
			"Bullets38Box", 10,
			"Bullets44Box", 6,
			"Bullets45Box", 4,
			"Bullhorn", 10,
			"FirstAidKit", 2,
			"Nightstick", 10,
			"Pistol2", 4,
			"Revolver_Long", 6,
			"Revolver_Short", 10,
			"Shotgun", 8,
			"ShotgunShellsBox", 10,
			"WalkieTalkie4", 10,
			"Whistle", 2,
			"Zipties", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceStorageAmmunition = {
		rolls = 4,
		items = {
			-- Ammo
			"308Box", 20,
			"308Box", 10,
			"Bullets9mmBox", 50,
			"Bullets9mmBox", 20,
			"Bullets9mmBox", 20,
			"Bullets9mmBox", 10,
			"ShotgunShellsBox", 50,
			"ShotgunShellsBox", 20,
			-- Bags/Containers
			"Bag_AmmoBox_308", 8,
			"Bag_AmmoBox_9mm", 20,
			"Bag_AmmoBox_ShotgunShells", 10,
			"Bag_ProtectiveCaseBulkyAmmo_308", 2,
			"Bag_ProtectiveCaseBulkyAmmo_9mm", 8,
			"Bag_ProtectiveCaseBulkyAmmo_ShotgunShells", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceStorageGuns = {
		rolls = 4,
		items = {
			-- Pistols
			"Pistol", 50,
			"Pistol", 20,
			--Shotguns
			"Shotgun", 20,
			"Shotgun", 10,
			-- Rifles
			"AssaultRifle2", 4,
			"HuntingRifle", 10,
			-- Clips/Magazines
			"9mmClip", 50,
			"9mmClip", 20,
			"9mmClip", 20,
			"9mmClip", 10,
			-- Accessories
			"AmmoStrap_Bullets", 4,
			"AmmoStrap_Shells", 4,
			"HolsterAnkle", 1,
			"HolsterShoulder", 2,
			"HolsterSimple_Black", 8,
			"x2Scope", 4,
			"x4Scope", 2,
			"x8Scope", 1,
			-- Ammo
			"308Box", 20,
			"308Box", 10,
			"Bullets9mmBox", 50,
			"Bullets9mmBox", 20,
			"ShotgunShellsBox", 50,
			"ShotgunShellsBox", 20,
			-- Bags/Containers
			"Bag_Police", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceStorageOutfit = {
		rolls = 4,
		items = {
			"Bag_Police", 0.1,
			"ElbowPad_Left_Tactical", 1,
			"Hat_CrashHelmet_Police", 2,
			"Hat_EarMuff_Protectors", 8,
			"Hat_Police", 4,
			"Jacket_Police", 4,
			"Jacket_Police", 4,
			"Kneepad_Left_Tactical", 4,
			"Shirt_PoliceBlue", 4,
			"Shoes_Black", 8,
			"Shoes_Brown", 8,
			"Trousers_Police", 8,
			"Trousers_PoliceGrey", 8,
			"Tshirt_PoliceBlue", 10,
			"Vest_BulletPolice", 4,
			"WalkieTalkie4", 10,
			"Zipties", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoliceTools = {
		rolls = 3,
		items = {
			"9mmClip", 10,
			"AmmoStrap_Bullets", 4,
			"AmmoStrap_Shells", 4,
			"Bullets9mmBox", 20,
			"Bullets9mmBox", 10,
			"Bullhorn", 10,
			"FirstAidKit", 2,
			"Nightstick", 10,
			"Pistol", 20,
			"Shotgun", 8,
			"ShotgunShellsBox", 10,
			"WalkieTalkie4", 10,
			"Whistle", 2,
			"Zipties", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PoolLockers = {
		rolls = 4,
		items = {
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"BathTowel", 20,
			"BathTowel", 10,
			"Bikini_Pattern01", 6,
			"Bikini_TINT", 6,
			"Briefs_SmallTrunks_Black", 2,
			"Briefs_SmallTrunks_Blue", 2,
			"Briefs_SmallTrunks_Red", 2,
			"Briefs_SmallTrunks_WhiteTINT", 2,
			"CombinationPadlock", 10,
			"Magazine_Health", 10,
			"Magazine_Sports", 10,
			"Paperback_Diet", 8,
			"Paperback_Sports", 8,
			"Shoes_FlipFlop", 8,
			"Sportsbottle", 10,
			"SwimTrunks_Blue", 8,
			"SwimTrunks_Green", 8,
			"SwimTrunks_Red", 8,
			"SwimTrunks_Yellow", 8,
			"Glasses_SwimmingGoggles", 8,
			"Swimsuit_TINT", 10,
			"Whistle", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	PostOfficeBooks = {
		rolls = 4,
		items = {
			"Bag_Mail", 4,
			"Book_AdventureNonFiction", 2,
			"Book_Art", 2,
			"Book_Biography", 2,
			"Book_Business", 2,
			"Book_Childs", 2,
			"Book_Cinema", 2,
			"Book_Computer", 2,
			"Book_CrimeFiction", 2,
			"Book_Fantasy", 2,
			"Book_Farming", 2,
			"Book_Fashion", 2,
			"Book_Fiction", 2,
			"Book_GeneralNonFiction", 2,
			"Book_GeneralReference", 2,
			"Book_Golf", 2,
			"Book_History", 2,
			"Book_Horror", 2,
			"Book_Legal", 2,
			"Book_LiteraryFiction", 2,
			"Book_Medical", 2,
			"Book_MilitaryHistory", 2,
			"Book_Music", 2,
			"Book_Nature", 2,
			"Book_Occult", 2,
			"Book_Politics", 2,
			"Book_Religion", 2,
			"Book_Romance", 2,
			"Book_SadNonFiction", 2,
			"Book_SchoolTextbook", 2,
			"Book_Science", 2,
			"Book_SciFi", 2,
			"Book_Sports", 2,
			"Book_Thriller", 2,
			"Book_Travel", 2,
			"Book_Western", 2,
			"BookAiming1", 0.6,
			"BookAiming2", 0.4,
			"BookAiming3", 0.2,
			"BookAiming4", 0.1,
			"BookAiming5", 0.05,
			"BookBlacksmith1", 6,
			"BookBlacksmith2", 4,
			"BookBlacksmith3", 2,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookButchering1", 6,
			"BookButchering2", 4,
			"BookButchering3", 2,
			"BookButchering4", 1,
			"BookButchering5", 0.5,
			"BookCarpentry1", 6,
			"BookCarpentry2", 4,
			"BookCarpentry3", 2,
			"BookCarpentry4", 1,
			"BookCarpentry5", 0.5,
			"BookCarving1", 6,
			"BookCarving2", 4,
			"BookCarving3", 2,
			"BookCarving4", 1,
			"BookCarving5", 0.5,
			"BookCooking1", 6,
			"BookCooking2", 4,
			"BookCooking3", 2,
			"BookCooking4", 1,
			"BookCooking5", 0.5,
			"BookElectrician1", 6,
			"BookElectrician2", 4,
			"BookElectrician3", 2,
			"BookElectrician4", 1,
			"BookElectrician5", 0.5,
			"BookFarming1", 6,
			"BookFarming2", 4,
			"BookFarming3", 2,
			"BookFarming4", 1,
			"BookFarming5", 0.5,
			"BookFirstAid1", 6,
			"BookFirstAid2", 4,
			"BookFirstAid3", 2,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"BookFishing1", 6,
			"BookFishing2", 4,
			"BookFishing3", 2,
			"BookFishing4", 1,
			"BookFishing5", 0.5,
			"BookFlintKnapping1", 0.6,
			"BookFlintKnapping2", 0.4,
			"BookFlintKnapping3", 0.2,
			"BookFlintKnapping4", 0.1,
			"BookFlintKnapping5", 0.05,
			"BookForaging1", 6,
			"BookForaging2", 4,
			"BookForaging3", 2,
			"BookForaging4", 1,
			"BookForaging5", 0.5,
			"BookGlassmaking1", 6,
			"BookGlassmaking2", 4,
			"BookGlassmaking3", 2,
			"BookGlassmaking4", 1,
			"BookGlassmaking5", 0.5,
			"BookHusbandry1", 6,
			"BookHusbandry2", 4,
			"BookHusbandry3", 2,
			"BookHusbandry4", 1,
			"BookHusbandry5", 0.5,
			"BookLongBlade1", 0.6,
			"BookLongBlade2", 0.4,
			"BookLongBlade3", 0.2,
			"BookLongBlade4", 0.1,
			"BookLongBlade5", 0.05,
			"BookMaintenance1", 6,
			"BookMaintenance2", 4,
			"BookMaintenance3", 2,
			"BookMaintenance4", 1,
			"BookMaintenance5", 0.5,
			"BookMasonry1", 6,
			"BookMasonry2", 4,
			"BookMasonry3", 2,
			"BookMasonry4", 1,
			"BookMasonry5", 0.5,
			"BookMechanic1", 6,
			"BookMechanic2", 4,
			"BookMechanic3", 2,
			"BookMechanic4", 1,
			"BookMechanic5", 0.5,
			"BookMetalWelding1", 6,
			"BookMetalWelding2", 4,
			"BookMetalWelding3", 2,
			"BookMetalWelding4", 1,
			"BookMetalWelding5", 0.5,
			"BookPottery1", 6,
			"BookPottery2", 4,
			"BookPottery3", 2,
			"BookPottery4", 1,
			"BookPottery5", 0.5,
			"BookReloading1", 0.6,
			"BookReloading2", 0.4,
			"BookReloading3", 0.2,
			"BookReloading4", 0.1,
			"BookReloading5", 0.05,
			"BookTailoring1", 6,
			"BookTailoring2", 4,
			"BookTailoring3", 2,
			"BookTailoring4", 1,
			"BookTailoring5", 0.5,
			"BookTracking1", 6,
			"BookTracking2", 4,
			"BookTracking3", 2,
			"BookTracking4", 1,
			"BookTracking5", 0.5,
			"BookTrapping1", 6,
			"BookTrapping2", 4,
			"BookTrapping3", 2,
			"BookTrapping4", 1,
			"BookTrapping5", 0.5,
			"Paperback_AdventureNonFiction", 4,
			"Paperback_Art", 4,
			"Paperback_Biography", 4,
			"Paperback_Business", 4,
			"Paperback_Childs", 4,
			"Paperback_Cinema", 4,
			"Paperback_Computer", 4,
			"Paperback_CrimeFiction", 4,
			"Paperback_Diet", 4,
			"Paperback_Fantasy", 4,
			"Paperback_Fashion", 4,
			"Paperback_Fiction", 4,
			"Paperback_Golf", 4,
			"Paperback_History", 4,
			"Paperback_Horror", 4,
			"Paperback_Legal", 4,
			"Paperback_LiteraryFiction", 4,
			"Paperback_Medical", 4,
			"Paperback_MilitaryHistory", 4,
			"Paperback_Music", 4,
			"Paperback_Nature", 4,
			"Paperback_NewAge", 4,
			"Paperback_Occult", 4,
			"Paperback_Politics", 4,
			"Paperback_Relationship", 4,
			"Paperback_Religion", 4,
			"Paperback_Romance", 4,
			"Paperback_SadNonFiction", 4,
			"Paperback_Scary", 4,
			"Paperback_SciFi", 4,
			"Paperback_Science", 4,
			"Paperback_SelfHelp", 4,
			"Paperback_Sexy", 4,
			"Paperback_Sports", 4,
			"Paperback_Thriller", 4,
			"Paperback_Travel", 4,
			"Paperback_TrueCrime", 4,
			"Paperback_Western", 4,
			"Parcel_ExtraLarge", 1,
			"Parcel_ExtraSmall", 10,
			"Parcel_Large", 2,
			"Parcel_Medium", 4,
			"Parcel_Small", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PostOfficeBoxes = {
		rolls = 4,
		items = {
			"Bag_Satchel_Mail", 4,
			"Mov_CardboardBox", 50,
			"Mov_CardboardBox", 20,
			"Mov_CardboardBox", 20,
			"Mov_CardboardBox", 10,
			"Mov_CardboardBox", 10,
			"Parcel_ExtraLarge", 1,
			"Parcel_ExtraSmall", 10,
			"Parcel_Large", 2,
			"Parcel_Medium", 4,
			"Parcel_Small", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PostOfficeMagazines = {
		rolls = 4,
		items = {
			"Bag_Mail", 4,
			"Brochure", 20,
			"Brochure", 10,
			"ComicBook_Retail", 1,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"Flier", 20,
			"Flier", 10,
			"GlassmakingMag1", 0.5,
			"GlassmakingMag2", 0.5,
			"GlassmakingMag3", 0.5,
			"HerbalistMag", 1,
			"HottieZ", 0.1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"Magazine_Art_New", 8,
			"Magazine_Business_New", 8,
			"Magazine_Car_New", 8,
			"Magazine_Childs_New", 8,
			"Magazine_Cinema_New", 8,
			"Magazine_Crime_New", 8,
			"Magazine_Fashion_New", 8,
			"Magazine_Firearm_New", 8,
			"Magazine_Golf_New", 8,
			"Magazine_Health_New", 8,
			"Magazine_Hobby_New", 8,
			"Magazine_Horror_New", 8,
			"Magazine_Humor_New", 8,
			"Magazine_Military_New", 8,
			"Magazine_Music_New", 8,
			"Magazine_Outdoors_New", 8,
			"Magazine_Police_New", 8,
			"Magazine_Science_New", 8,
			"Magazine_Sports_New", 8,
			"Magazine_Tech_New", 8,
			"Magazine_Teens_New", 8,
			"MagazineCrossword", 4,
			"MagazineWordsearch", 4,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkMag1", 1,
			"MetalworkMag2", 1,
			"MetalworkMag3", 1,
			"MetalworkMag4", 1,
			"Parcel_ExtraLarge", 1,
			"Parcel_ExtraSmall", 10,
			"Parcel_Large", 2,
			"Parcel_Medium", 4,
			"Parcel_Small", 8,
			"SmithingMag1", 0.1,
			"SmithingMag2", 0.1,
			"SmithingMag3", 0.1,
			"SmithingMag4", 0.1,
			"SmithingMag5", 0.1,
			"SmithingMag6", 0.1,
			"SmithingMag7", 0.1,
			"SmithingMag8", 0.1,
			"SmithingMag9", 0.1,
			"SmithingMag10", 0.1,
			"SmithingMag11", 0.1,
			"TVMagazine", 20,
			"TVMagazine", 10,
			"WeaponMag1", 0.001,
			"WeaponMag2", 0.001,
			"WeaponMag3", 0.001,
			"WeaponMag4", 0.001,
			"WeaponMag5", 0.001,
			"WeaponMag7", 0.001,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PostOfficeNewspapers = {
		rolls = 4,
		items = {
			"Bag_Mail", 4,
			"Newspaper_New", 50,
			"Newspaper_New", 20,
			"Newspaper_New", 20,
			"Newspaper_New", 10,
			"Newspaper_New", 10,
			"Parcel_ExtraLarge", 1,
			"Parcel_ExtraSmall", 10,
			"Parcel_Large", 2,
			"Parcel_Medium", 4,
			"Parcel_Small", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PostOfficeParcels = {
		rolls = 2,
		items = {
			"Bag_Mail", 20,
			"Bag_Mail", 10,
			"Parcel_ExtraLarge", 4,
			"Parcel_ExtraSmall", 10,
			"Parcel_Large", 8,
			"Parcel_Medium", 10,
			"Parcel_Small", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PostOfficeSupplies = {
		rolls = 4,
		items = {
			"AdhesiveTapeBox", 0.1,
			"Bag_Satchel_Mail", 4,
			"BluePen", 8,
			"Calculator", 8,
			"Clipboard", 8,
			"GreenPen", 4,
			"HolePuncher", 4,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Notepad", 8,
			"PaperclipBox", 1,
			"Pen", 10,
			"Pen", 20,
			"Pencil", 20,
			"Pencil", 10,
			"RedPen", 8,
			"Scissors", 8,
			"ScissorsBlunt", 8,
			"Scotchtape", 4,
			"Stapler", 4,
			"Staples", 10,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	PrisonCellRandom = {
		rolls = 4,
		items = {
			-- Hygiene
			"Comb", 4,
			"Mirror", 8,
			"Soap2", 10,
			"Toothbrush", 10,
			"Toothpaste", 10,
			-- Luxuries/Personal
			"Harmonica", 1,
			"LetterHandwritten", 4,
			"MetalCup", 2,
			"Photo", 4,
			"RadioBlack", 1,
			-- Snacks
			"Crisps", 1,
			"PorkRinds", 1,
			"Ramen", 4,
			-- Literature
			"Book_Bible", 1,
			"Book_ClassicFiction", 1,
			"Book_Legal", 1,
			"Book_Religion", 1,
			"Book_SchoolTextbook", 4,
			"Paperback_Bible", 4,
			"Paperback_Business", 2,
			"Paperback_ClassicFiction", 2,
			"Paperback_Legal", 2,
			"Paperback_Philosophy", 2,
			"Paperback_SelfHelp", 8,
			-- Contraband
			"CigarettePack", 1,
			"CrudeKnife", 0.1,
			"Flask", 0.01,
			"GlassShiv", 0.1,
			"HottieZ", 0.5,
			"KeyMag1", 0.1,
			"KnifeButterfly", 0.05,
			"KnifePocket", 0.01,
			"KnifeShiv", 0.1,
			"Lighter", 1,
			"LighterDisposable", 4,
			"Matches", 1,
			"Money", 4,
			"Pager", 4,
			"Photo_Racy", 1,
			"Pills", 0.1,
			"PillsBeta", 0.1,
			"Screwdriver_Improvised", 0.01,
			"SmallSaw", 0.001,
			"Spoon", 4,
			"SwitchKnife", 0.05,
			"Toothbrush_Shiv", 1,
			"TrickMag1", 0.1,
			"WeaponMag3", 0.1,
			"Whiskey", 0.01,
			-- Special
			"HollowBook_Prison", 0.005,
		},
		junk = {
			rolls = 1,
			items = {
				"BathTowel", 20,
				"Boilersuit_Prisoner", 100,
				"IDcard_Male", 1,
				"Shoes_FlipFlop", 10,
			}
		}
	},

	PrisonCellRandomClassy = {
		rolls = 4,
		items = {
			-- Hygiene
			"Comb", 4,
			"HairDryer", 2,
			"HairIron", 2,
			"Mirror", 8,
			"Soap2", 10,
			"Toothbrush", 10,
			"Toothpaste", 10,
			-- Luxuries/Personal
			"Harmonica", 2,
			"MetalCup", 4,
			"RadioBlack", 1,
			-- Snacks
			"Chocolate", 4,
			"Crisps", 10,
			"PorkRinds", 8,
			"Ramen", 10,
			-- Literature
			"Book_Bible", 1,
			"Book_ClassicFiction", 1,
			"Book_Legal", 1,
			"Book_Religion", 1,
			"Book_SchoolTextbook", 4,
			"Paperback_Bible", 4,
			"Paperback_Business", 2,
			"Paperback_ClassicFiction", 2,
			"Paperback_Legal", 2,
			"Paperback_Philosophy", 2,
			"Paperback_SelfHelp", 8,
			-- Contraband
			"CigarettePack", 1,
			"CrudeKnife", 0.1,
			"Flask", 0.01,
			"GlassShiv", 0.1,
			"HottieZ", 0.5,
			"KeyMag1", 0.1,
			"KnifeButterfly", 0.05,
			"KnifePocket", 0.01,
			"KnifeShiv", 0.1,
			"Lighter", 1,
			"LighterDisposable", 4,
			"Matches", 1,
			"Money", 20,
			"Money", 10,
			"MoneyBundle", 1,
			"Pager", 4,
			"Photo_Racy", 1,
			"Pills", 0.1,
			"PillsBeta", 0.1,
			"Screwdriver_Improvised", 0.1,
			"SmallSaw", 0.001,
			"Spoon", 4,
			"SwitchKnife", 0.05,
			"Toothbrush_Shiv", 1,
			"TrickMag1", 0.1,
			"WeaponMag3", 0.1,
			"Whiskey", 0.01,
			-- Special
			"HollowBook_Prison", 0.001,
		},
		junk = {
			rolls = 1,
			items = {
				"BathTowel", 20,
				"Bag_MoneyBag", 0.0001,
				"Boilersuit_Prisoner", 100,
				"IDcard_Male", 1,
				"Shoes_FlipFlop", 10,
			}
		}
	},

	PrisonGuardLockers = {
		rolls = 4,
		items = {
			-- Equipment
			"Bullhorn", 10,
			"HandTorch", 4,
			"HolsterSimple_Black", 4,
			"KeyRing_SecurityPass", 0.1,
			"Nightstick", 2,
			"ShortBat", 0.5,
			"WalkieTalkie4", 1,
			"WalkieTalkie5", 0.5,
			"Whistle", 2,
			-- Armor
			"ElbowPad_Left_Tactical", 1,
			"Hat_RiotHelmet", 2,
			"Kneepad_Left_Tactical", 4,
			"ShinKneeGuard_L_Protective", 2,
			"ThighProtective_L", 1,
			"Vest_BulletCivilian", 2,
			-- Clothing
			"Glasses_Aviators", 1,
			"Glasses_Sun", 2,
			"Shirt_PoliceBlue", 10,
			"Shirt_PoliceGrey", 10,
			"Shirt_PrisonGuard", 10,
			"Shoes_Random", 8,
			"Trousers_Police", 8,
			"Trousers_PoliceGrey", 8,
			"Trousers_PrisonGuard", 10,
			"Tshirt_PoliceBlue", 10,
			"Tshirt_PoliceGrey", 10,
			"Tshirt_Profession_PoliceBlue", 10,
			"Tshirt_Profession_PoliceWhite", 10,
			-- Medical
			"FirstAidKit", 4,
			"FirstAidKit_NewPro", 4,
			-- Misc.
			"Flask", 0.5,
			"Gum", 10,
			"Lunchbag", 1,
			"Lunchbox", 1,
			"Lunchbox2", 0.01,
			"Magazine", 4,
			"Magazine_Crime", 4,
			"Magazine_Police", 8,
			"Money", 4,
			"Paperback", 8,
			"Sportsbottle", 1,
			"TobaccoChewing", 1,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_ClassicMilitary", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			-- Bags/Containers
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
		},
		junk = {
			rolls = 1,
			items = {
				"Bag_MoneyBag", 0.0001,
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	PrisonArmoryShotguns = {
		rolls = 4,
		items = {
			-- Shotguns
			"Shotgun", 50,
			"Shotgun", 20,
			"Shotgun", 20,
			"Shotgun", 10,
			-- Shells
			"Bag_AmmoBox_ShotgunShells", 20,
			"Bag_AmmoBox_ShotgunShells", 10,
			"Bag_ProtectiveCaseBulkyAmmo_ShotgunShells", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"Bag_MoneyBag", 0.0001,
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	PrisonStorageArmor = {
		rolls = 4,
		items = {
			-- Armor
			"ElbowPad_Left_Tactical", 20,
			"Hat_RiotHelmet", 20,
			"Kneepad_Left_Tactical", 20,
			"ShinKneeGuard_L_Protective", 20,
			"ThighProtective_L", 20,
			"Vest_BulletCivilian", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	PrisonRiotStorage = {
		rolls = 4,
		items = {
			-- Equipment
			"Bullhorn", 10,
			"HandTorch", 4,
			"HolsterSimple_Black", 10,
			"KeyRing_SecurityPass", 0.1,
			"Nightstick", 10,
			"ShortBat", 10,
			"WalkieTalkie4", 10,
			"WalkieTalkie5", 0.5,
			"Whistle", 10,
			-- Medical
			"FirstAidKit", 4,
			"FirstAidKit_NewPro", 4,
			-- Armor
			"ElbowPad_Left_Tactical", 10,
			"Hat_RiotHelmet", 10,
			"Kneepad_Left_Tactical", 10,
			"ShinKneeGuard_L_Protective", 10,
			"ThighProtective_L", 10,
			"Vest_BulletCivilian", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"Bag_MoneyBag", 0.0001,
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	PrisonLaundry = {
		rolls = 4,
		items = {
			"Boilersuit_Prisoner", 50,
			"Boilersuit_Prisoner", 20,
			"Boilersuit_Prisoner", 20,
			"Boilersuit_Prisoner", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	ProduceStorageApples = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Small", 20,
			"ProduceBox_Small", 20,
			"ProduceBox_Small", 10,
			"ProduceBox_Small", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Apple,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageBellPeppers = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_BellPepper,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageBroccoli = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Broccoli,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageCabbages = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Large", 20,
			"ProduceBox_Large", 20,
			"ProduceBox_Large", 10,
			"ProduceBox_Large", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Cabbage,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageCarrots = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Carrot,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageCauliflower = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Cauliflower,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageCherry = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_ExtraSmall", 20,
			"ProduceBox_ExtraSmall", 20,
			"ProduceBox_ExtraSmall", 10,
			"ProduceBox_ExtraSmall", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Cherry,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageCorn = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Corn,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageEggplant = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Eggplant,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageEmptyBoxes = {
		rolls = 8,
		items = {
			"ProduceBox_ExtraSmall", 50,
			"ProduceBox_Large", 10,
			"ProduceBox_Medium", 20,
			"ProduceBox_Small", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageEquipment = {
		rolls = 8,
		items = {
			-- Equipment
			"Apron_White", 8,
			"Glasses_SafetyGoggles", 10,
			"Gloves_Surgical", 10,
			"Hat_DustMask", 10,
			-- Empty  Boxes
			"ProduceBox_ExtraSmall", 20,
			"ProduceBox_Large", 4,
			"ProduceBox_Medium", 8,
			"ProduceBox_Small", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Clipboard", 10,
				"DuctTape", 4,
				"MarkerBlack", 8,
				"Paperwork", 10,
				"Pencil", 8,
			}
		}
	},

	ProduceStorageGrapes = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Small", 20,
			"ProduceBox_Small", 20,
			"ProduceBox_Small", 10,
			"ProduceBox_Small", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Grapes,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageGreenpeas = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Greenpeas,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageKale = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Large", 20,
			"ProduceBox_Large", 20,
			"ProduceBox_Large", 10,
			"ProduceBox_Large", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Kale,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageLeeks = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Leek,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageLettuce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Large", 20,
			"ProduceBox_Large", 20,
			"ProduceBox_Large", 10,
			"ProduceBox_Large", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Lettuce,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageLooseFruit = {
		isWorn = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Apple", 20,
			"Cherry", 50,
			"Cherry", 20,
			"Grapes", 20,
			"Peach", 20,
			"Pear", 20,
			"Strewberrie", 50,
			"Strewberrie", 20,
			"Watermelon", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageLooseVeg = {
		isWorn = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BellPepper", 8,
			"Broccoli", 8,
			"Cabbage", 4,
			"Carrots", 8,
			"Cauliflower", 8,
			"Corn", 8,
			"Eggplant", 8,
			"Greenpeas", 8,
			"Kale", 4,
			"Leek", 8,
			"Lettuce", 4,
			"Onion", 8,
			"Potato", 8,
			"RedRadish", 20,
			"SweetPotato", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageOnions = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Onion,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStoragePeaches = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Small", 20,
			"ProduceBox_Small", 20,
			"ProduceBox_Small", 10,
			"ProduceBox_Small", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Peach,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStoragePears = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Small", 20,
			"ProduceBox_Small", 20,
			"ProduceBox_Small", 10,
			"ProduceBox_Small", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Pear,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStoragePotatoes = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Potato,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageRadishes = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Radish,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageRottenFruit = {
		isRotten = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Apple", 20,
			"Cherry", 50,
			"Cherry", 20,
			"Grapes", 20,
			"Peach", 20,
			"Pear", 20,
			"Strewberrie", 50,
			"Strewberrie", 20,
			"Watermelon", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageRottenVeg = {
		isRotten = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BellPepper", 8,
			"Broccoli", 8,
			"Cabbage", 4,
			"Carrots", 8,
			"Cauliflower", 8,
			"Corn", 8,
			"Eggplant", 8,
			"Greenpeas", 8,
			"Kale", 4,
			"Leek", 8,
			"Lettuce", 4,
			"Onion", 8,
			"Potato", 8,
			"RedRadish", 20,
			"SweetPotato", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageStrawberries = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_ExtraSmall", 20,
			"ProduceBox_ExtraSmall", 20,
			"ProduceBox_ExtraSmall", 10,
			"ProduceBox_ExtraSmall", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Strawberry,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageSweetPotatoes = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_SweetPotato,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageTomatoes = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 20,
			"ProduceBox_Medium", 10,
			"ProduceBox_Medium", 10,
		},
		bags = BagsAndContainers.ProduceStorage_Tomato,
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ProduceStorageWatermelons = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Watermelon", 20,
			"Watermelon", 20,
			"Watermelon", 10,
			"Watermelon", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RadioFactoryComponents = {
		rolls = 4,
		items = {
			"BatteryBox", 10,
			"ElectricWire", 20,
			"ElectricWire", 10,
			"LightBulbGreen", 10,
			"LightBulbRed", 10,
			"RadioReceiver", 20,
			"RadioReceiver", 10,
			"RadioTransmitter", 20,
			"RadioTransmitter", 10,
			"ScannerModule", 20,
			"ScannerModule", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RailYardSpikes = {
		isShop = true,
		rolls = 6,
		items = {
			"RailroadSpike", 50,
			"RailroadSpike", 20,
			"RailroadSpike", 20,
			"RailroadSpike", 10,
			"RailroadSpike", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RailYardTools = {
		rolls = 4,
		items = {
			-- Tools
			"BallPeenHammer", 2,
			"BlowTorch", 8,
			"BoltCutters", 2,
			"Calipers", 2,
			"CarpentryChisel", 1,
			"CeramicCrucible", 4,
			"ClubHammer", 2,
			"CrudeBenchVise", 1,
			"File", 4,
			"HandAxe", 1,
			"HandDrill", 2,
			"MetalworkingChisel", 1,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 1,
			"PipeWrench", 1,
			"Pliers", 2,
			"RailroadSpikePuller", 10,
			"RailroadSpikePullerOld", 4,
			"Ratchet", 2,
			"Screwdriver", 2,
			"SheetMetalSnips", 1,
			"Sledgehammer", 0.1,
			"Sledgehammer2", 0.1,
			"SmallFileSet", 1,
			"SmallPunchSet", 1,
			"SmallSaw", 1,
			"ViseGrips", 1,
			"Wrench", 4,
			-- Accessories
			"ElbowPad_Left_Workman", 1,
			"FlashLight_AngleHead", 1,
			"Glasses_SafetyGoggles", 4,
			"HandTorch", 8,
			"Hat_EarMuff_Protectors", 4,
			"Hat_HardHat", 2,
			"Hat_BuildersRespirator", 2,
			"Kneepad_Left_Workman", 4,
			"Torch", 4,
			-- Misc.
			"MeasuringTape", 10,
			"Mov_ElectricBlowerForge", 1,
			-- Materials
			"NutsBolts", 10,
			"Oxygen_Tank", 4,
			"Propane_Refill", 4,
			"ScrewsBox", 10,
			"ScrewsCarton", 0.5,
			"WeldingRods", 8,
			"Wire", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RandomFiller = {
		rolls = 4,
		items = {
			"BluePen", 8,
			"Book", 4,
			"BottleOpener", 1,
			"BoxOfJars", 0.01,
			"Brochure", 2,
			"Calculator", 1,
			"Candle", 10,
			"CigarettePack", 1,
			"CircularSawblade", 1,
			"Clipboard", 1,
			"Cooler", 0.1,
			"CopperScrap", 0.1,
			"ElectricWire", 10,
			"ElectronicsScrap", 10,
			"EmptyJar", 0.5,
			"Flier", 2,
			"Garbagebag", 4,
			"Garbagebag_box", 1,
			"Glue", 2,
			"GreenPen", 4,
			"HandTorch", 8,
			"JarLid", 0.5,
			"KnifePocket", 0.1,
			"LightBulb", 10,
			"LighterDisposable", 4,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"Matches", 8,
			"Newspaper", 10,
			"Notebook", 4,
			"Notepad", 10,
			"Paperback", 8,
			"NutsBolts", 8,
			"Paperclip", 10,
			"PaperclipBox", 1,
			"Pen", 8,
			"Pencil", 10,
			"PowerBar", 4,
			"RedPen", 8,
			"RubberBand", 6,
			"Scissors", 2,
			"ScissorsBlunt", 2,
			"Scotchtape", 4,
			"ScrapMetal", 0.1,
			"SheetPaper2", 10,
			"Tissue", 4,
			"TissueBox", 1,
			"Torch", 4,
			"TVMagazine", 10,
			"Twine", 10,
			"Wire", 6,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
			}
		}
	},

	RangerOutfit = {
		rolls = 3,
		items = {
			"CompassDirectional", 10,
			"DoubleBarrelShotgun", 8,
			"Gloves_LeatherGlovesBlack", 10,
			"Handiknife", 1,
			"Hat_Ranger", 6,
			"HuntingRifle", 4,
			"InsectRepellent", 10,
			"Jacket_Ranger", 10,
			"Kneepad_Left_Tactical", 1,
			"KnifePocket", 1,
			"Multitool", 0.01,
			"Notebook", 10,
			"Pen", 8,
			"Revolver", 6,
			"Revolver_Long", 4,
			"Shirt_OfficerWhite", 6,
			"Shirt_Ranger", 6,
			"Shoes_Random", 10,
			"Shotgun", 8,
			"Trousers_Ranger", 10,
			"VarmintRifle", 8,
			"WalkieTalkie4", 10,
			"WaterPurificationTablets", 1,
			"Whistle", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RangerTools = {
		rolls = 3,
		items = {
			"223Box", 10,
			"308Box", 10,
			"BookTrapping1", 6,
			"BookTrapping2", 4,
			"BookTrapping3", 2,
			"BookTrapping4", 1,
			"BookTrapping5", 0.5,
			"Bullhorn", 10,
			"Bullets45Box", 10,
			"Garbagebag_box", 0.5,
			"GardenHoe", 2,
			"HandAxe", 4,
			"HuntingRifle", 4,
			"PickAxe", 0.5,
			"Revolver", 6,
			"Revolver_Long", 4,
			"Shotgun", 8,
			"ShotgunShellsBox", 10,
			"Shovel", 4,
			"Shovel2", 4,
			"TrapBox", 4,
			"TrapCage", 4,
			"TrapCrate", 4,
			"TrapSnare", 4,
			"TrapStick", 4,
			"VarmintRifle", 8,
			"WalkieTalkie4", 10,
			"WaterPurificationTablets", 1,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RecRoomShelf = {
		rolls = 2,
		items = {
			"BackgammonBoard", 10,
			"BluePen", 8,
			"Book", 10,
			"BookAiming1", 0.005,
			"BookAiming2", 0.0025,
			"BookAiming3", 0.0001,
			"BookBlacksmith1", 0.1,
			"BookBlacksmith2", 0.05,
			"BookBlacksmith3", 0.025,
			"BookButchering1", 0.1,
			"BookButchering2", 0.05,
			"BookButchering3", 0.025,
			"BookCarpentry1", 0.1,
			"BookCarpentry2", 0.05,
			"BookCarpentry3", 0.025,
			"BookCarving1", 0.005,
			"BookCarving2", 0.0025,
			"BookCarving3", 0.0001,
			"BookCooking1", 0.1,
			"BookCooking2", 0.05,
			"BookCooking3", 0.025,
			"BookElectrician1", 0.1,
			"BookElectrician2", 0.05,
			"BookElectrician3", 0.025,
			"BookFarming1", 0.1,
			"BookFarming2", 0.05,
			"BookFarming3", 0.025,
			"BookFirstAid1", 0.1,
			"BookFirstAid2", 0.05,
			"BookFirstAid3", 0.025,
			"BookFishing1", 0.1,
			"BookFishing2", 0.05,
			"BookFishing3", 0.025,
			"BookForaging1", 0.1,
			"BookForaging2", 0.05,
			"BookForaging3", 0.025,
			"BookGlassmaking1", 0.1,
			"BookGlassmaking2", 0.05,
			"BookGlassmaking3", 0.025,
			"BookHusbandry1", 0.1,
			"BookHusbandry2", 0.05,
			"BookHusbandry3", 0.025,
			"BookLongBlade1", 0.005,
			"BookLongBlade2", 0.0025,
			"BookLongBlade3", 0.0001,
			"BookMaintenance1", 0.1,
			"BookMaintenance2", 0.05,
			"BookMaintenance3", 0.025,
			"BookMasonry1", 0.1,
			"BookMasonry2", 0.05,
			"BookMasonry3", 0.025,
			"BookMechanic1", 0.1,
			"BookMechanic2", 0.05,
			"BookMechanic3", 0.025,
			"BookMetalWelding1", 0.1,
			"BookMetalWelding2", 0.05,
			"BookMetalWelding3", 0.025,
			"BookPottery1", 0.1,
			"BookPottery2", 0.05,
			"BookPottery3", 0.025,
			"BookReloading1", 0.005,
			"BookReloading2", 0.0025,
			"BookReloading3", 0.0001,
			"BookTailoring1", 0.1,
			"BookTailoring2", 0.05,
			"BookTailoring3", 0.025,
			"BookTracking1", 0.1,
			"BookTracking2", 0.05,
			"BookTracking3", 0.025,
			"BookTrapping1", 0.1,
			"BookTrapping2", 0.05,
			"BookTrapping3", 0.025,
			"Brochure", 2,
			"Calculator", 1,
			"CardDeck", 10,
			"CDplayer", 2,
			"CheckerBoard", 10,
			"ChessBlack", 8,
			"ChessWhite", 8,
			"Clipboard", 1,
			"ComicBook", 4,
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"Disc_Retail", 4,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"Eraser", 8,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"Flier", 2,
			"GamePieceBlack", 8,
			"GamePieceRed", 8,
			"GamePieceWhite", 8,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"GreenPen", 4,
			"HerbalistMag", 0.1,
			"HollowBook_Whiskey", 0.001,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"Magazine", 10,
			"Magazine", 5,
			"Magazine_Popular", 10,
			"Magazine_Popular", 5,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Notebook", 10,
			"Notepad", 8,
			"Paperback", 20,
			"Pen", 8,
			"Pencil", 10,
			"PenFancy", 0.5,
			"Photo", 2,
			"PokerChips", 10,
			"RadioBlack", 2,
			"RadioRed", 1,
			"RedPen", 8,
			"RPGmanual", 1,
			"SheetPaper2", 10,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			"TVMagazine", 8,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RestaurantKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 2,
			"Chicken", 2,
			"Ham", 2,
			"MincedMeat", 2,
			"MuttonChop", 1,
			"PorkChop", 2,
			"Sausage", 2,
			"Steak", 1,
			-- Fish/Seafood
			"BlackCrappie", 0.1,
			"BlueCatfish", 0.1,
			"Bluegill", 0.1,
			"ChannelCatfish", 0.1,
			"Crayfish", 1,
			"FishFillet", 2,
			"FlatheadCatfish", 0.1,
			"FreshwaterDrum", 0.1,
			"LargemouthBass", 0.1,
			"Mussels", 1,
			"Oysters", 1,
			"Salmon", 2,
			"Sauger", 0.1,
			"Shrimp", 1,
			"SmallmouthBass", 0.1,
			"SpottedBass", 0.1,
			"StripedBass", 0.1,
			"Walleye", 0.1,
			"WhiteBass", 0.1,
			"WhiteCrappie", 0.1,
			"YellowPerch", 0.1,
			-- Vegetables
			"CornFrozen", 4,
			"MixedVegetables", 4,
			"Peas", 4,
			-- Frozen Foods
			"Frozen_ChickenNuggets", 4,
			"Frozen_FishFingers", 4,
			"Frozen_FrenchFries", 8,
			"Frozen_TatoDots", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RestaurantKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Vegetables
			"Avocado", 1,
			"BellPepper", 2,
			"Blackbeans", 1,
			"Broccoli", 2,
			"BrusselSprouts", 1,
			"Cabbage", 2,
			"Carrots", 4,
			"Cauliflower", 2,
			"Corn", 4,
			"Cucumber", 2,
			"Eggplant", 2,
			"Garlic", 4,
			"Greenpeas", 2,
			"Kale", 1,
			"Leek", 2,
			"Lettuce", 2,
			"Onion", 4,
			"PepperJalapeno", 1,
			"Potato", 4,
			"RedRadish", 2,
			"Spinach", 2,
			"Squash", 2,
			"SweetPotato", 2,
			"Tomato", 2,
			"Turnip", 2,
			"Zucchini", 2,
			-- Fresh Herbs
			"Basil", 2,
			"Chives", 2,
			"Cilantro", 1,
			"GreenOnions", 2,
			"LemonGrass", 1,
			"MintHerb", 1,
			"Oregano", 2,
			"Parsley", 2,
			"Rosemary", 2,
			"Sage", 2,
			"Thyme", 2,
			-- Fruits
			"Apple", 2,
			"Cherry", 4,
			"Grapefruit", 1,
			"Grapes", 2,
			"Lemon", 2,
			"Lime", 2,
			"Mango", 1,
			"Orange", 2,
			"Peach", 2,
			"Pear", 1,
			"Pineapple", 0.5,
			"Strewberrie", 4,
			-- Meat
			"Bacon", 2,
			"Chicken", 2,
			"FrogMeat", 0.5,
			"Ham", 2,
			"MincedMeat", 2,
			"MuttonChop", 1,
			"PorkChop", 2,
			"Rabbitmeat", 0.5,
			"Sausage", 1,
			"Smallbirdmeat", 0.5,
			"Steak", 1,
			-- Fish/Seafood
			"BlackCrappie", 0.1,
			"BlueCatfish", 0.1,
			"Bluegill", 0.1,
			"ChannelCatfish", 0.1,
			"Crayfish", 1,
			"FishFillet", 2,
			"FlatheadCatfish", 0.1,
			"FreshwaterDrum", 0.1,
			"LargemouthBass", 0.1,
			"Lobster", 0.1,
			"Mussels", 1,
			"Oysters", 1,
			"Salmon", 2,
			"Sauger", 0.1,
			"Shrimp", 1,
			"SmallmouthBass", 0.1,
			"SpottedBass", 0.1,
			"StripedBass", 0.1,
			"Walleye", 0.1,
			"WhiteBass", 0.1,
			"WhiteCrappie", 0.1,
			"YellowPerch", 0.1,
			-- Dairy
			"Butter", 4,
			"Cheese", 4,
			"Milk", 8,
			"Processedcheese", 8,
			-- Misc.
			"Egg", 8,
			"EggCarton", 2,
			"Lard", 2,
			"Margarine", 2,
			-- Sauces/Condiments
			"BBQSauce", 2,
			"Capers", 0.5,
			"Dip_NachoCheese", 1,
			"Dip_Ranch", 1,
			"Dip_Salsa", 1,
			"Hotsauce", 2,
			"JamFruit", 2,
			"JamMarmalade", 1,
			"Ketchup", 4,
			"Marinara", 2,
			"MayonnaiseFull", 2,
			"Mustard", 4,
			"RemouladeFull", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	RestaurantMenus = {
		rolls = 4,
		items = {
			-- Menus
			"MenuCard", 50,
			"MenuCard", 20,
			"MenuCard", 20,
			"MenuCard", 10,
			"MenuCard", 10,
			-- Keys/Keyrings
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Stationery
			"BluePen", 1,
			"Calculator", 2,
			"Clipboard", 1,
			"Eraser", 1,
			"HolePuncher", 0.1,
			"MarkerBlack", 0.1,
			"MarkerBlue", 0.1,
			"MarkerGreen", 0.1,
			"MarkerRed", 0.1,
			"Pen", 1,
			"Pencil", 4,
			"RedPen", 1,
			-- Misc.
			"Note", 1,
			"Notepad", 1,
			"Phonebook", 10,
			"Receipt", 20,
			"Receipt", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SafehouseArmor = {
		rolls = 2,
		items = {
			-- Armor
			"Vest_BulletCivilian", 4,
			"Vest_BulletPolice", 1,
			"Vest_CatcherVest", 8,
			-- Padding
			"AthleticCup", 8,
			"ElbowPad_Left_Sport", 4,
			"ElbowPad_Left_Workman", 2,
			"Kneepad_Left_Sport", 8,
			"Kneepad_Left_Workman", 4,
			"ShinKneeGuard_L", 4,
			"Shinpad_HockeyGoalie_L", 4,
			"Shinpad_L", 4,
			"Shoulderpads_IceHockey", 4,
			-- Helmets
			"Hat_ArmyWWII", 0.01,
			"Hat_BaseballHelmet", 4,
			"Hat_BicycleHelmet", 6,
			"Hat_CrashHelmet", 4,
			"Hat_CrashHelmet_Stars", 0.5,
			"Hat_Fireman", 0.5,
			"Hat_FootballHelmet", 4,
			"Hat_HardHat", 4,
			"Hat_HockeyHelmet", 4,
			-- Masks
			"Hat_BuildersRespirator", 4,
			"Hat_DustMask", 10,
			"Hat_HalloweenMaskDevil", 0.01,
			"Hat_HalloweenMaskMonster", 0.01,
			"Hat_HalloweenMaskPumpkin", 0.01,
			"Hat_HalloweenMaskSkeleton", 0.01,
			"Hat_HalloweenMaskVampire", 0.01,
			"Hat_HalloweenMaskWitch", 0.01,
			"Hat_HockeyMask", 4,
			"Hat_SurgicalMask", 10,
			"WeldingMask", 4,
			-- Glasses/Goggles
			"Glasses_Aviators", 1,
			"Glasses_Eyepatch_Left", 2,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.1,
			"Glasses_Prescription_Shooting", 0.1,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_SafetyGoggles", 4,
			"Glasses_Shooting", 2,
			"Glasses_SkiGoggles", 4,
			"Glasses_Sun", 2,
			"Glasses_SwimmingGoggles", 4,
			-- Gloves
			"Gloves_FingerlessLeatherGloves", 8,
			"Gloves_IceHockeyGloves", 4,
			"Gloves_LeatherGloves", 6,
			-- Jackets
			"JacketLong_Random", 4,
			"Jacket_ArmyCamoGreen", 1,
			"Jacket_Black", 1,
			"Jacket_Leather", 4,
			"Jacket_Leather_Punk", 0.1,
			"Jacket_PaddedDOWN", 4,
			-- Rain Gear/Ponchos
			"PonchoGarbageBag", 1,
			"PonchoGreenDOWN", 4,
			"PonchoTarp", 1,
			"PonchoYellowDOWN", 4,
			-- Misc.
			"Fleshing_Tool", 10,						 
			"Hat_Bandana", 8,
			"Hat_BandanaTINT", 8,
			"VambraceMagazine_Left", 8,
			-- Gun Accessories
			"Bag_ChestRig", 0.5,
			"HolsterSimple", 4,
			-- Literature (Recipe and Skill)
			"BookBlacksmith1", 1,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 1,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookTailoring1", 1,
			"BookTailoring2", 1,
			"BookTailoring3", 1,
			"BookTailoring4", 1,
			"BookTailoring5", 0.5,
			"ArmorMag1", 1,
			"ArmorMag2", 1,
			"ArmorMag3", 1,
			"ArmorMag4", 1,
			"ArmorMag5", 1,
			"ArmorMag6", 1,
			"ArmorMag7", 1,
			"ArmorSchematic", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SafehouseArmor_Mid = {
		rolls = 2,
		items = {
			-- Leather Armor
			"Vambrace_Leather_Left", 1,
			-- Armor
			"Vest_BulletArmy", 1,
			"Vest_BulletCivilian", 4,
			"Vest_BulletPolice", 1,
			"Vest_CatcherVest", 8,
			-- Padding
			"AthleticCup", 8,
			"ElbowPad_Left_Military", 1,
			"ElbowPad_Left_Sport", 4,
			"ElbowPad_Left_Tactical", 1,
			"ElbowPad_Left_Workman", 2,
			"Kneepad_Left_Military", 2,
			"Kneepad_Left_Sport", 8,
			"Kneepad_Left_Tactical", 2,
			"Kneepad_Left_Workman", 4,
			"ShinKneeGuard_L", 4,
			"Shinpad_HockeyGoalie_L", 4,
			"Shinpad_L", 4,
			"Shoulderpads_IceHockey", 4,
			"Shoulderpad_Football_L", 4,
			"Shoulderpad_Football_R", 4,
			-- Helmets
			"Hat_Army", 1,
			"Hat_ArmyWWII", 0.01,
			"Hat_BaseballHelmet", 4,
			"Hat_BicycleHelmet", 6,
			"Hat_CrashHelmet", 4,
			"Hat_CrashHelmet_Police", 0.5,
			"Hat_CrashHelmet_Stars", 0.5,
			"Hat_Fireman", 0.5,
			"Hat_FootballHelmet", 4,
			"Hat_HardHat", 4,
			"Hat_HardHat_Miner", 0.5,
			"Hat_HockeyHelmet", 4,
			"Hat_RidingHelmet", 2,
			"Hat_RiotHelmet", 1,
			-- Masks
			"Hat_BuildersRespirator", 4,
			"Hat_DustMask", 10,
			"Hat_GasMask", 2,
			"Hat_HalloweenMaskDevil", 0.01,
			"Hat_HalloweenMaskMonster", 0.01,
			"Hat_HalloweenMaskPumpkin", 0.01,
			"Hat_HalloweenMaskSkeleton", 0.01,
			"Hat_HalloweenMaskVampire", 0.01,
			"Hat_HalloweenMaskWitch", 0.01,
			"Hat_HockeyMask", 4,
			"Hat_HockeyMask_Wood", 1,
			"Hat_ImprovisedGasMask", 8,
			"Hat_SurgicalMask", 10,
			"SCBA_notank", 1,
			"WeldingMask", 4,
			-- Glasses/Goggles
			"Glasses_Aviators", 1,
			"Glasses_Eyepatch_Left", 2,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.1,
			"Glasses_Prescription_Shooting", 0.1,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_SafetyGoggles", 4,
			"Glasses_Shooting", 2,
			"Glasses_SkiGoggles", 4,
			"Glasses_Sun", 2,
			"Glasses_SwimmingGoggles", 4,
			-- Gloves
			"Gloves_FingerlessLeatherGloves", 8,
			"Gloves_IceHockeyGloves", 4,
			"Gloves_LeatherGloves", 6,
			-- Jackets
			"JacketLong_Random", 4,
			"Jacket_ArmyCamoGreen", 1,
			"Jacket_Black", 1,
			"Jacket_Fireman", 1,
			"Jacket_Leather", 4,
			"Jacket_Leather_Punk", 0.1,
			"Jacket_PaddedDOWN", 4,
			"Jacket_Police", 1,
			"Jacket_Sheriff", 1,
			-- Rain Gear/Ponchos
			"PonchoGarbageBag", 4,
			"PonchoGreenDOWN", 1,
			"PonchoTarp", 4,
			"PonchoYellowDOWN", 1,
			-- Pants
			"TrousersMesh_Leather", 4,
			"Trousers_LeatherBlack", 4,
			-- Misc.
			"Buckle", 8,
			"Cuirass_Magazine", 4,
			"Fleshing_Tool", 20,						 
			"GreaveBodyArmour_Left", 1,
			"Hat_BalaclavaFace", 2,
			"Hat_BalaclavaFull", 2,
			"Hat_Bandana", 8,
			"Hat_BandanaTINT", 8,
			"IceHockeyNeckGuard", 4,
			"ShemaghScarf", 2,
			"ShemaghScarf_Green", 1,
			"ThighBodyArmour_L", 1,
			"VambraceMagazine_Left", 4,
			"Vambrace_BodyArmour_Left", 1,
			-- Gun Accessories
			"AmmoStrap_Bullets", 6,
			"AmmoStrap_Shells", 4,
			"Bag_ChestRig", 1,
			"HolsterAnkle", 1,
			"HolsterDouble", 2,
			"HolsterShoulder", 1,
			"HolsterSimple", 4,
			-- Literature (Recipe and Skill)
			"BookBlacksmith1", 1,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 1,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookTailoring1", 1,
			"BookTailoring2", 1,
			"BookTailoring3", 1,
			"BookTailoring4", 1,
			"BookTailoring5", 0.5,
			"ArmorMag1", 2,
			"ArmorMag2", 2,
			"ArmorMag3", 2,
			"ArmorMag4", 2,
			"ArmorMag5", 2,
			"ArmorMag6", 2,
			"ArmorMag7", 2,
			"ArmorSchematic", 50,
			"ArmorSchematic", 20,

		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SafehouseArmor_Late = {
		rolls = 3,
		items = {
			-- Leather Armor
			"Codpiece_Leather", 0.5,
			"Gorget_Leather", 0.5,
			"Vambrace_Leather_Left", 1,
			-- Metal Armor
			"Codpiece_Metal", 0.1,
			"Cuirass_Metal", 0.01,
			"Cuirass_MetalScrap", 0.1,
			"Gorget_Metal", 0.1,
			"GreaveScrap_Left", 0.1,
			"GreaveSpikeScrap_Left", 0.01,
			"Greave_Left", 0.01,
			"ShinKneeGuard_L_Metal", 0.5,
			"Shoulderpad_Articulated_L_Metal", 0.01,
			"Shoulderpad_Articulated_R_Metal", 0.01,
			"Shoulderpad_MetalScrap_L", 0.5,
			"Shoulderpad_MetalSpikeScrap_L", 0.01,
			"Shoulderpad_Metal_L", 0.01,
			"ThighMetal_L", 0.01,
			"ThighScrapMetalSpike_L", 0.01,
			"ThighScrapMetal_L", 0.1,
			"VambraceScrap_Left", 0.1,
			"VambraceSpikeScrap_Left", 0.01,
			"Vambrace_Left", 0.01,
			-- Tire Armor
			"Cuirass_Tire", 1,
			"GreaveTire_Left", 1,
			"Shoulderpad_Tire_L", 1,
			"Shoulderpad_Tire_R", 1,
			"ThighTire_L", 1,
			"VambraceTire_Left", 1,
			-- Armor
			"Vest_BulletArmy", 1,
			"Vest_BulletCivilian", 4,
			"Vest_BulletPolice", 1,
			"Vest_BulletSWAT", 0.1,
			"Vest_CatcherVest", 8,
			-- Padding
			"AthleticCup", 8,
			"ElbowPad_Left_Military", 1,
			"ElbowPad_Left_Sport", 4,
			"ElbowPad_Left_Tactical", 1,
			"ElbowPad_Left_Workman", 2,
			"Kneepad_Left_Military", 2,
			"Kneepad_Left_Sport", 8,
			"Kneepad_Left_Tactical", 2,
			"Kneepad_Left_Workman", 4,
			"ThighProtective_L", 1,
			"ShinKneeGuard_L", 4,
			"Shinpad_HockeyGoalie_L", 4,
			"Shinpad_L", 4,
			"Shoulderpads_IceHockey", 4,
			"Shoulderpad_Football_L", 4,
			"Shoulderpad_Football_R", 4,
			-- Helmets
			"Hat_Army", 1,
			"Hat_ArmyWWII", 0.01,
			"Hat_BaseballHelmet", 4,
			"Hat_CrashHelmet", 4,
			"Hat_CrashHelmet_Police", 0.5,
			"Hat_CrashHelmet_Stars", 0.5,
			"Hat_Fireman", 0.5,
			"Hat_FootballHelmet", 4,
			"Hat_HardHat", 4,
			"Hat_HardHat_Miner", 0.5,
			"Hat_HockeyHelmet", 4,
			"Hat_MetalHelmet", 0.01,
			"Hat_MetalScrapHelmet", 0.1,
			"Hat_RiotHelmet", 1,
			"Hat_SPHhelmet", 0.5,
			"Hat_SWAT", 0.1,
			-- Masks
			"Hat_BuildersRespirator", 4,
			"Hat_DustMask", 10,
			"Hat_GasMask", 2,
			"Hat_HockeyMask", 4,
			"Hat_HockeyMask_Copper", 0.1,
			"Hat_HockeyMask_MetalScrap", 0.1,
			"Hat_HockeyMask_Wood", 1,
			"Hat_ImprovisedGasMask", 8,
			"Hat_NBCmask", 0.1,
			"Hat_SurgicalMask", 10,
			"SCBA_notank", 1,
			"WeldingMask", 4,
			-- Glasses/Goggles
			"Glasses_Aviators", 1,
			"Glasses_Eyepatch_Left", 2,
			"Glasses_Prescription", 0.1,
			"Glasses_Prescription_Aviators", 0.1,
			"Glasses_Prescription_Shooting", 0.1,
			"Glasses_Prescription_Sun", 0.1,
			"Glasses_SafetyGoggles", 4,
			"Glasses_Shooting", 2,
			"Glasses_SkiGoggles", 4,
			"Glasses_Sun", 2,
			-- Gloves
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Chainmail_SleeveFull_L", 0.01,
			"Chainmail_SleeveFull_R", 0.001,
			"Gloves_FingerlessLeatherGloves", 8,
			"Gloves_IceHockeyGloves", 4,
			"Gloves_LeatherGloves", 6,
			"Gloves_LeatherGlovesBlack", 6,
			"Gloves_MetalArmour", 0.01,
			"Gloves_MetalScrapArmour", 0.1,
			-- Jackets
			"JacketLong_Random", 4,
			"Jacket_ArmyCamoGreen", 1,
			"Jacket_Black", 1,
			"Jacket_Fireman", 1,
			"Jacket_Leather", 4,
			"Jacket_Leather_Punk", 0.1,
			"Jacket_PaddedDOWN", 4,
			"Jacket_Police", 1,
			"Jacket_Sheriff", 1,
			-- Rain Gear/Ponchos
			"PonchoGarbageBag", 4,
			"PonchoGreenDOWN", 1,
			"PonchoTarp", 4,
			"PonchoYellowDOWN", 1,
			-- Pants
			"TrousersMesh_Leather", 4,
			"Trousers_LeatherBlack", 4,
			-- Misc.
			"Buckle", 8,
			"Cuirass_Magazine", 8,
			"Fleshing_Tool", 50,				 
			"GreaveBodyArmour_Left", 2,
			"Hat_BalaclavaFace", 2,
			"Hat_BalaclavaFull", 2,
			"Hat_Bandana", 8,
			"Hat_BandanaTINT", 8,
			"IceHockeyNeckGuard", 4,
			"ShemaghScarf", 2,
			"ShemaghScarf_Green", 1,
			"ThighBodyArmour_L", 2,
			"VambraceMagazine_Left", 8,
			"Vambrace_BodyArmour_Left", 2,
			-- Gun Accessories
			"AmmoStrap_Bullets", 6,
			"AmmoStrap_Shells", 4,
			"Bag_ChestRig", 1,
			"HolsterAnkle", 1,
			"HolsterDouble", 2,
			"HolsterShoulder", 1,
			"HolsterSimple", 4,
			-- Literature (Recipe and Skill)
			"BookBlacksmith1", 1,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 1,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookTailoring1", 1,
			"BookTailoring2", 1,
			"BookTailoring3", 1,
			"BookTailoring4", 1,
			"BookTailoring5", 0.5,
			"ArmorMag1", 5,
			"ArmorMag2", 5,
			"ArmorMag3", 5,
			"ArmorMag4", 5,
			"ArmorMag5", 5,
			"ArmorMag6", 5,
			"ArmorMag7", 5,
			"ArmorSchematic", 50,
			"ArmorSchematic", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Should these have scraps of takeout and other perishable snacks inside?
	SafehouseBin = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Medical Waste
			"BandageDirty", 20,
			"BandageDirty", 10,
			"Gloves_Surgical", 4,
			"Hat_SurgicalMask", 4,
			"RippedSheetsDirty", 50,
			"RippedSheetsDirty", 20,
			"Scalpel", 1,
			-- Clothing
			"Gloves_LeatherGloves", 1,
			"Hat_DustMask", 4,
			-- Broken Items/Weapons
			"BanjoNeck_Broken", 2,
			"BaseballBat_Broken", 8,
			"GardenToolHandle_Broken", 4,
			"GuitarAcousticNeck_Broken", 2,
			"GuitarElectricBassNeck_Broken", 2,
			"GuitarElectricNeck_Broken", 2,
			"Handle", 2,
			"LongHandle_Broken", 2,
			"LongStick_Broken", 2,
			"SmallHandle", 4,
			"SmashedBottle", 1,
			-- Empties
			"BleachEmpty", 2,
			"CleaningLiquid2Empty", 2,
			"EmptyJar", 4,
			"PopBottleEmpty", 4,
			"PopBottleRareEmpty", 1,
			"WaterBottleEmpty", 4,
			-- Trash
			"CopperScrap", 4,
			"DentedCan", 4,
			"ElectronicsScrap", 8,
			"ScrapMetal", 8,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			"UnusableMetal", 8,
			"UnusableWood", 8,
			-- Misc.
			"RatPoison", 1,
			"JarLid", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- More filled version of above. More bottles and junk in general. Lots of dirty rags and bandages.
	SafehouseBin_Mid = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Medical Waste
			"BandageDirty", 50,
			"BandageDirty", 20,
			"Gloves_Surgical", 4,
			"Hat_SurgicalMask", 4,
			"RippedSheetsDirty", 50,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirtyBundle", 20,
			"Scalpel", 2,
			"ScissorsBluntMedical", 2,
			"SutureNeedleHolder", 2,
			-- Clothing
			"Gloves_LeatherGloves", 1,
			"Hat_DustMask", 4,
			-- Broken Items/Weapons
			"BanjoNeck_Broken", 2,
			"BaseballBat_Broken", 8,
			"GardenToolHandle_Broken", 4,
			"GuitarAcousticNeck_Broken", 2,
			"GuitarElectricBassNeck_Broken", 2,
			"GuitarElectricNeck_Broken", 2,
			"Handle", 2,
			"LongHandle_Broken", 2,
			"LongStick_Broken", 2,
			"SmallHandle", 4,
			"SmashedBottle", 1,
			-- Empties
			"BeerBottleEmpty", 10,
			"BeerCanEmpty", 10,
			"BleachEmpty", 4,
			"CleaningLiquid2Empty", 4,
			"DisinfectantEmpty", 4,
			"EmptyJar", 4,
			"GinEmpty", 1,
			"Pop2Empty", 4,
			"Pop3Empty", 4,
			"PopBottleEmpty", 8,
			"PopBottleRareEmpty", 2,
			"PopEmpty", 4,
			"RumEmpty", 1,
			--"SodaCanEmpty", 4,
			"TequilaEmpty", 1,
			"VodkaEmpty", 1,
			"WaterBottleEmpty", 20,
			"WaterBottleEmpty", 10,
			"WhiskeyEmpty", 2,
			"WineScrewtopEmpty", 2,
			-- Trash
			"CopperScrap", 4,
			"DentedCan", 4,
			"ElectronicsScrap", 8,
			"ScrapMetal", 8,
			"TinCanEmpty", 50,
			"TinCanEmpty", 20,
			"UnusableMetal", 8,
			"UnusableWood", 8,
			-- Misc.
			"Battery", 4,
			"JarLid", 4,
			"LightBulb", 2,
			"RatPoison", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- More liquor bottles, more rags. Vermin and other random discarded objects can now be found in here.
	SafehouseBin_Late = {
		isTrash = true,
		rolls = 4,
		items = {
			-- Medical Waste
			"BandageDirty", 8,
			"Gloves_Surgical", 1,
			"Hat_SurgicalMask", 1,
			"RippedSheetsDirty", 50,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			"RippedSheetsDirtyBundle", 20,
			"Scalpel", 4,
			"ScissorsBluntMedical", 4,
			"SutureNeedleHolder", 4,
			-- Clothing
			"Gloves_LeatherGloves", 1,
			"Hat_DustMask", 4,
			-- Broken Items/Weapons
			"BanjoNeck_Broken", 2,
			"BaseballBat_Broken", 8,
			"GardenToolHandle_Broken", 4,
			"GuitarAcousticNeck_Broken", 2,
			"GuitarElectricBassNeck_Broken", 2,
			"GuitarElectricNeck_Broken", 2,
			"Handle", 2,
			"LongHandle_Broken", 2,
			"LongStick_Broken", 2,
			"SmallHandle", 4,
			"SmashedBottle", 1,
			-- Empties
			"BeerBottleEmpty", 20,
			"BeerCanEmpty", 20,
			"BleachEmpty", 8,
			"CleaningLiquid2Empty", 8,
			"DisinfectantEmpty", 8,
			"EmptyJar", 4,
			"GinEmpty", 4,
			"Pop2Empty", 4,
			"Pop3Empty", 4,
			"PopBottleEmpty", 8,
			"PopBottleRareEmpty", 2,
			"PopEmpty", 4,
			"RumEmpty", 4,
			"ScotchEmpty", 4,
			--"SodaCanEmpty", 4,
			"TequilaEmpty", 4,
			"VodkaEmpty", 4,
			"WaterBottleEmpty", 20,
			"WaterBottleEmpty", 10,
			"WhiskeyEmpty", 8,
			"Wine2OpenEmpty", 2,
			"WineOpenEmpty", 2,
			"WineScrewtopEmpty", 4,
			-- Trash
			"CopperScrap", 4,
			"DentedCan", 4,
			"ElectronicsScrap", 8,
			"ScrapMetal", 8,
			"TinCanEmpty", 50,
			"TinCanEmpty", 20,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			"UnusableMetal", 8,
			"UnusableWood", 8,
			-- Vermin
			"Cockroach", 8,
			"DeadMouse", 4,
			"DeadRat", 2,
			"Maggots", 8,
			-- Misc.
			"Battery", 4,
			"HottieZ", 2,
			"JarLid", 4,
			"LightBulb", 2,
			"Photo", 2,
			"RatPoison", 1,
			"Revolver_Short", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SafehouseBookShelf = {
		rolls = 4,
		items = {
			-- Skill Books
			"BookAiming1", 1,
			"BookAiming2", 1,
			"BookAiming3", 1,
			"BookAiming4", 1,
			"BookAiming5", 0.5,
			"BookBlacksmith1", 1,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 1,
			"BookBlacksmith4", 1,
			"BookBlacksmith5", 0.5,
			"BookButchering1", 1,
			"BookButchering2", 1,
			"BookButchering3", 1,
			"BookButchering4", 1,
			"BookButchering5", 0.5,
			"BookCarpentry1", 1,
			"BookCarpentry2", 1,
			"BookCarpentry3", 1,
			"BookCarpentry4", 1,
			"BookCarpentry5", 0.5,
			"BookCarving1", 1,
			"BookCarving2", 1,
			"BookCarving3", 1,
			"BookCarving4", 1,
			"BookCarving5", 0.5,
			"BookCooking1", 1,
			"BookCooking2", 1,
			"BookCooking3", 1,
			"BookCooking4", 1,
			"BookCooking5", 0.5,
			"BookElectrician1", 1,
			"BookElectrician2", 1,
			"BookElectrician3", 1,
			"BookElectrician4", 1,
			"BookElectrician5", 0.5,
			"BookFarming1", 1,
			"BookFarming2", 1,
			"BookFarming3", 1,
			"BookFarming4", 1,
			"BookFarming5", 0.5,
			"BookFirstAid1", 1,
			"BookFirstAid2", 1,
			"BookFirstAid3", 1,
			"BookFirstAid4", 1,
			"BookFirstAid5", 0.5,
			"BookFishing1", 1,
			"BookFishing2", 1,
			"BookFishing3", 1,
			"BookFishing4", 1,
			"BookFishing5", 0.5,
			"BookFlintKnapping1", 1,
			"BookFlintKnapping2", 1,
			"BookFlintKnapping3", 1,
			"BookFlintKnapping4", 1,
			"BookFlintKnapping5", 0.5,
			"BookForaging1", 1,
			"BookForaging2", 1,
			"BookForaging3", 1,
			"BookForaging4", 1,
			"BookForaging5", 0.5,
			"BookGlassmaking1", 1,
			"BookGlassmaking2", 1,
			"BookGlassmaking3", 1,
			"BookGlassmaking4", 1,
			"BookGlassmaking5", 0.5,
			"BookHusbandry1", 1,
			"BookHusbandry2", 1,
			"BookHusbandry3", 1,
			"BookHusbandry4", 1,
			"BookHusbandry5", 0.5,
			"BookLongBlade1", 1,
			"BookLongBlade2", 1,
			"BookLongBlade3", 1,
			"BookLongBlade4", 1,
			"BookLongBlade5", 0.5,
			"BookMaintenance1", 1,
			"BookMaintenance2", 1,
			"BookMaintenance3", 1,
			"BookMaintenance4", 1,
			"BookMaintenance5", 0.5,
			"BookMasonry1", 1,
			"BookMasonry2", 1,
			"BookMasonry3", 1,
			"BookMasonry4", 1,
			"BookMasonry5", 0.5,
			"BookMechanic1", 1,
			"BookMechanic2", 1,
			"BookMechanic3", 1,
			"BookMechanic4", 1,
			"BookMechanic5", 0.5,
			"BookMetalWelding1", 1,
			"BookMetalWelding2", 1,
			"BookMetalWelding3", 1,
			"BookMetalWelding4", 1,
			"BookMetalWelding5", 0.5,
			"BookPottery1", 1,
			"BookPottery2", 1,
			"BookPottery3", 1,
			"BookPottery4", 1,
			"BookPottery5", 0.5,
			"BookReloading1", 1,
			"BookReloading2", 1,
			"BookReloading3", 1,
			"BookReloading4", 1,
			"BookReloading5", 0.5,
			"BookTailoring1", 1,
			"BookTailoring2", 1,
			"BookTailoring3", 1,
			"BookTailoring4", 1,
			"BookTailoring5", 0.5,
			"BookTracking1", 1,
			"BookTracking2", 1,
			"BookTracking3", 1,
			"BookTracking4", 1,
			"BookTracking5", 0.5,
			"BookTrapping4", 1,
			"BookTrapping5", 0.5,
			-- Magazines
			"ArmorMag1", 1,
			"ArmorMag2", 1,
			"ArmorMag3", 1,
			"ArmorMag4", 1,
			"ArmorMag5", 1,
			"ArmorMag6", 1,
			"ArmorMag7", 1,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"GlassmakingMag1", 1,
			"GlassmakingMag2", 1,
			"GlassmakingMag3", 1,
			"HempMag1", 1,
			"HerbalistMag", 1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KeyMag1", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkMag1", 1,
			"MetalworkMag2", 1,
			"MetalworkMag3", 1,
			"MetalworkMag4", 1,
			"PrimitiveToolMag1", 1,
			"PrimitiveToolMag2", 1,
			"PrimitiveToolMag3", 1,
			"RadioMag1", 1,
			"RadioMag2", 1,
			"RadioMag3", 1,
			"SmithingMag1", 1,
			"SmithingMag10", 1,
			"SmithingMag11", 1,
			"SmithingMag2", 1,
			"SmithingMag3", 1,
			"SmithingMag4", 1,
			"SmithingMag5", 1,
			"SmithingMag6", 1,
			"SmithingMag7", 1,
			"SmithingMag8", 1,
			"SmithingMag9", 1,
			"WeaponMag1", 0.5,
			"WeaponMag2", 0.5,
			"WeaponMag3", 0.5,
			"WeaponMag4", 0.5,
			"WeaponMag5", 0.5,
			"WeaponMag6", 0.5,
			"WeaponMag7", 0.5,
			-- Clippings/Recipes
			"ArmorSchematic", 20,
			"BSToolsSchematic", 20,
			"CookwareSchematic", 20,
			"ExplosiveSchematic", 20,
			"MeleeWeaponSchematic", 20,
			"RecipeClipping", 10,
			"SurvivalSchematic", 20,
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
			-- Electronics/Music/VHS
			"CDplayer", 6,
			"Disc_Retail", 10,
			"VHS_Home", 10,
			"VHS_Retail", 50,
			"VHS_Retail", 20,
			"WalkieTalkie2", 2,
			"WalkieTalkie3", 1,
			-- Literature (Generic)
			"Brochure", 10,
			"Catalog", 10,
			"Diary1", 6,
			"Flier", 10,
			"Journal", 10,
			"LetterHandwritten", 20,
			"Magazine", 10,
			"MagazineCrossword", 8,
			"MagazineWordsearch", 8,
			"Notebook", 20,
			"Photo", 50,
			"Photo", 20,
			"Photo_Secret", 4,
			"Photo_VeryOld", 10,
			-- Special
			"HollowBook_Valuables", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				"Eraser", 6,
				"MagnifyingGlass", 2,
				"MarkerBlack", 6,
				"Pen", 8,
				"Pencil", 10,
				"PencilSpiffo", 0.1,
				"PenFancy", 1,
				"PenMultiColor", 1,
				"PenLight", 4,
				"PenSpiffo", 0.1,
			}
		},
		maxMap = 1,
		stashChance = 10,
	},

	-- Loads of freshly-looted booze from local bars and liquor stores.
	SafehouseBooze = {
		isShop = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Beer
			"BeerBottle", 50,
			"BeerBottle", 20,
			"BeerCan", 50,
			"BeerCan", 20,
			"BeerCanPack", 1,
			"BeerImported", 8,
			"BeerPack", 1,
			"Cider", 8,
			-- Wine
			"Champagne", 1,
			"Port", 8,
			"Sherry", 8,
			"Vermouth", 8,
			"Wine", 10,
			"Wine2", 10,
			"WineAged", 2,
			"WineBox", 20,
			"WineScrewtop", 20,
			-- Spirits
			"Brandy", 10,
			"Gin", 10,
			"Rum", 10,
			"Scotch", 10,
			"Tequila", 10,
			"Vodka", 10,
			"Whiskey", 10,
			-- Mix
			"CoffeeLiquer", 8,
			"Curacao", 8,
			"Grenadine", 8,
			"JuiceCranberry", 4,
			"JuiceLemon", 4,
			"JuiceOrange", 4,
			"JuiceTomato", 4,
			"SimpleSyrup", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		},
	},

	SafehouseDryer = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"DishCloth", 20,
			"RippedSheets", 20,
			"RippedSheets", 20,
			"RippedSheets", 10,
			"RippedSheets", 10,
			"Sheet", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SafehouseFireplace = {
		rolls = 4,
		items = {
			-- Skill Books
			"BookButchering1", 0.5,
			"BookButchering2", 0.1,
			"BookCarpentry1", 0.5,
			"BookCarpentry2", 0.1,
			"BookCarving1", 0.5,
			"BookCarving2", 0.1,
			"BookCooking1", 0.5,
			"BookCooking2", 0.1,
			"BookElectrician1", 0.5,
			"BookElectrician2", 0.1,
			"BookFarming1", 0.5,
			"BookFarming2", 0.1,
			"BookFirstAid1", 0.5,
			"BookFirstAid2", 0.1,
			"BookFishing1", 0.5,
			"BookFishing2", 0.1,
			"BookForaging1", 0.5,
			"BookForaging2", 0.1,
			"BookGlassmaking1", 0.5,
			"BookGlassmaking2", 0.1,
			"BookHusbandry1", 0.5,
			"BookHusbandry2", 0.1,
			"BookMaintenance1", 0.5,
			"BookMaintenance2", 0.1,
			"BookMasonry1", 0.5,
			"BookMasonry2", 0.1,
			"BookMechanic1", 0.5,
			"BookMechanic2", 0.1,
			"BookMetalWelding1", 0.5,
			"BookMetalWelding2", 0.1,
			"BookPottery1", 0.5,
			"BookPottery2", 0.1,
			"BookTailoring1", 0.5,
			"BookTailoring2", 0.1,
			"BookTracking1", 0.5,
			"BookTracking2", 0.1,
			"BookTrapping1", 0.5,
			"BookTrapping2", 0.1,
			-- Magazines
			"ArmorMag1", 0.05,
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"HempMag1", 0.05,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"WeaponMag1", 0.01,
			"WeaponMag2", 0.01,
			"WeaponMag3", 0.01,
			"WeaponMag4", 0.01,
			"WeaponMag5", 0.01,
			"WeaponMag7", 0.01,
			-- Maps
			"LouisvilleMap1", 0.05,
			"LouisvilleMap2", 0.05,
			"LouisvilleMap3", 0.05,
			"LouisvilleMap4", 0.05,
			"LouisvilleMap5", 0.05,
			"LouisvilleMap6", 0.05,
			"LouisvilleMap7", 0.05,
			"LouisvilleMap8", 0.05,
			"LouisvilleMap9", 0.05,
			"MarchRidgeMap", 0.5,
			"MuldraughMap", 0.5,
			"RiversideMap", 0.5,
			"RosewoodMap", 0.5,
			"WestpointMap", 0.5,
			-- Literature (Generic)
			"Brochure", 50,
			"Brochure", 20,
			"Catalog", 20,
			"ComicBook_Retail", 8,
			"Flier", 50,
			"Flier", 20,
			"GenericMail", 50,
			"GenericMail", 20,
			"HottieZ", 4,
			"LetterHandwritten", 8,
			"Magazine", 20,
			"Magazine", 10,
			"MagazineCrossword", 8,
			"MagazineWordsearch", 8,
			"Newspaper", 20,
			"Newspaper", 10,
			"Paperwork", 20,
			"Paperwork", 10,
			"Phonebook", 20,
			"RecipeClipping", 8,
			-- Fuel/Flammables
			"BandageDirty", 8,
			"Firewood", 10,
			"Money", 50,
			"Money", 20,
			"Money", 20,
			"Money", 10,
			"MoneyBundle", 4,
			"RippedSheetsDirty", 8,
			"Twigs", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"FireplacePoker", 4,
			}
		},
		maxMap = 1, -- yes, even in the fireplace
		stashChance = 10,
	},

	SafehouseFireplace_Late = {
		rolls = 4,
		items = {
			-- Skill Books
			"BookButchering1", 0.5,
			"BookButchering2", 0.1,
			"BookCarpentry1", 0.5,
			"BookCarpentry2", 0.1,
			"BookCarving1", 0.5,
			"BookCarving2", 0.1,
			"BookCooking1", 0.5,
			"BookCooking2", 0.1,
			"BookElectrician1", 0.5,
			"BookElectrician2", 0.1,
			"BookFarming1", 0.5,
			"BookFarming2", 0.1,
			"BookFirstAid1", 0.5,
			"BookFirstAid2", 0.1,
			"BookFishing1", 0.5,
			"BookFishing2", 0.1,
			"BookForaging1", 0.5,
			"BookForaging2", 0.1,
			"BookGlassmaking1", 0.5,
			"BookGlassmaking2", 0.1,
			"BookHusbandry1", 0.5,
			"BookHusbandry2", 0.1,
			"BookMaintenance1", 0.5,
			"BookMaintenance2", 0.1,
			"BookMasonry1", 0.5,
			"BookMasonry2", 0.1,
			"BookMechanic1", 0.5,
			"BookMechanic2", 0.1,
			"BookMetalWelding1", 0.5,
			"BookMetalWelding2", 0.1,
			"BookPottery1", 0.5,
			"BookPottery2", 0.1,
			"BookTailoring1", 0.5,
			"BookTailoring2", 0.1,
			"BookTracking1", 0.5,
			"BookTracking2", 0.1,
			"BookTrapping1", 0.5,
			"BookTrapping2", 0.1,
			-- Magazines
			"ArmorMag1", 0.05,
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"HempMag1", 0.05,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"WeaponMag1", 0.01,
			"WeaponMag2", 0.01,
			"WeaponMag3", 0.01,
			"WeaponMag4", 0.01,
			"WeaponMag5", 0.01,
			"WeaponMag7", 0.01,
			-- Maps
			"LouisvilleMap1", 0.05,
			"LouisvilleMap2", 0.05,
			"LouisvilleMap3", 0.05,
			"LouisvilleMap4", 0.05,
			"LouisvilleMap5", 0.05,
			"LouisvilleMap6", 0.05,
			"LouisvilleMap7", 0.05,
			"LouisvilleMap8", 0.05,
			"LouisvilleMap9", 0.05,
			"MarchRidgeMap", 0.5,
			"MuldraughMap", 0.5,
			"RiversideMap", 0.5,
			"RosewoodMap", 0.5,
			"WestpointMap", 0.5,
			-- Literature (Generic)
			"Brochure", 50,
			"Brochure", 20,
			"Catalog", 20,
			"ComicBook_Retail", 8,
			"Flier", 50,
			"Flier", 20,
			"GenericMail", 50,
			"GenericMail", 20,
			"HottieZ", 4,
			"LetterHandwritten", 8,
			"Magazine", 20,
			"Magazine", 10,
			"MagazineCrossword", 8,
			"MagazineWordsearch", 8,
			"Newspaper", 20,
			"Newspaper", 10,
			"Paperwork", 20,
			"Paperwork", 10,
			"Phonebook", 20,
			"RecipeClipping", 8,
			-- Fuel/Flammables
			"BandageDirty", 8,
			"Firewood", 1,
			"Money", 50,
			"Money", 20,
			"Money", 20,
			"Money", 10,
			"MoneyBundle", 4,
			"RippedSheetsDirty", 8,
			"Twigs", 8,
			-- Misc.
			"AnimalBone", 4,
			"JawboneBovide", 2,
			"SharpBoneFragment", 8,
			"SharpBone_Long", 4,
			"SmallAnimalBone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"FireplacePoker", 4,
			}
		},
		maxMap = 1, -- yes, even in the fireplace
		stashChance = 10,
	},

	-- Less emphasis on survival, more on what's tasty. Lots of candy and snacks!
	SafehouseFood = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Snack Cakes
			"ChocoCakes", 4,
			"HiHis", 4,
			"Plonkies", 8,
			"QuaggaCakes", 4,
			"SnoGlobes", 4,
			-- Candy
			"Allsorts", 1,
			"CandyCaramels", 2,
			"CandyGummyfish", 2,
			"CandyNovapops", 2,
			"Chocolate", 2,
			"ChocolateCoveredCoffeeBeans", 1,
			"Chocolate_Butterchunkers", 2,
			"Chocolate_Candy", 2,
			"Chocolate_Crackle", 2,
			"Chocolate_Deux", 2,
			"Chocolate_GalacticDairy", 2,
			"Chocolate_RoysPBPucks", 2,
			"Chocolate_Smirkers", 2,
			"Chocolate_SnikSnak", 2,
			"GummyBears", 2,
			"GummyWorms", 2,
			"HardCandies", 1,
			"JellyBeans", 1,
			"Jujubes", 1,
			"LicoriceBlack", 1,
			"LicoriceRed", 2,
			"Lollipop", 4,
			"MintCandy", 1,
			"Modjeska", 1,
			"Peppermint", 1,
			-- Baked Goods
			"Bread", 8,
			"BunsHamburger", 4,
			"BunsHotdog", 4,
			-- Canned Food
			"CannedBolognese", 2,
			"CannedCarrots2", 2,
			"CannedChili", 2,
			"CannedCorn", 2,
			"CannedCornedBeef", 2,
			"CannedFruitBeverage", 2,
			"CannedFruitCocktail", 2,
			"CannedMilk", 1,
			"CannedMushroomSoup", 2,
			"CannedPeaches", 2,
			"CannedPeas", 2,
			"CannedPineapple", 2,
			"CannedPotato2", 2,
			"CannedSardines", 2,
			"CannedTomato2", 2,
			"Dogfood", 1,
			"TinnedBeans", 2,
			"TinnedSoup", 2,
			"TunaTin", 2,
			-- Ingredients
			"BakingSoda", 4,
			"ChocolateChips", 4,
			"Cinnamon", 2,
			"CocoaPowder", 4,
			"Flour2", 8,
			"OatsRaw", 8,
			"OilOlive", 4,
			"OilVegetable", 8,
			"PancakeMix", 4,
			"Sugar", 8,
			"SugarBrown", 8,
			"TomatoPaste", 4,
			"Yeast", 8,
			-- Nonperishables
			"Cereal", 8,
			"Coffee2", 4,
			"Crackers", 8,
			"GrahamCrackers", 8,
			"PeanutButter", 8,
			"Teabag2", 8,
			-- Snacks
			"BeefJerky", 8,
			"Crisps", 4,
			"Crisps2", 4,
			"Crisps3", 4,
			"Crisps4", 4,
			"DehydratedMeatStick", 8,
			"GranolaBar", 8,
			"Peanuts", 4,
			"Popcorn", 4,
			"PorkRinds", 2,
			"Pretzel", 4,
			"SunflowerSeeds", 4,
			"TortillaChips", 4,
			-- Literature
			"BookCooking1", 1,
			"BookCooking2", 1,
			"BookCooking3", 1,
			"BookCooking4", 1,
			"BookCooking5", 1,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"RecipeClipping", 10,
			-- Drinks
			"BeerBottle", 10,
			"BeerCan", 10,
			"BeerCanPack", 1,
			"BeerImported", 2,
			"BeerPack", 1,
			"Pop", 10,
			"Pop2", 10,
			"Pop3", 10,
			"PopBottle", 10,
			"PopBottleRare", 4,
			"SodaCan", 8,
			--"SodaCanRare", 2,
			"WaterBottle", 8,
			"WaterDispenserBottle", 0.5,
			-- Misc.
			"DentedCan", 4,
			"MysteryCan", 8,
			"P38", 1,
			"Spork", 1,
			"TrapMouse", 10,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"TrapMouse", 20,
				"TrapMouse", 10,
			}
		}
	},

	-- Mostly canned food and a few essentials. Few luxuries remain. Smoking helps manage the appetite.
	SafehouseFood_Mid = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Canned Food
			"CannedBolognese", 4,
			"CannedCarrots2", 4,
			"CannedChili", 4,
			"CannedCorn", 4,
			"CannedCornedBeef", 4,
			"CannedFruitBeverage", 4,
			"CannedFruitCocktail", 4,
			"CannedMilk", 2,
			"CannedMushroomSoup", 4,
			"CannedPeaches", 4,
			"CannedPeas", 4,
			"CannedPineapple", 4,
			"CannedPotato2", 4,
			"CannedSardines", 4,
			"CannedTomato2", 4,
			"Dogfood", 2,
			"TinnedBeans", 4,
			"TinnedSoup", 4,
			"TomatoPaste", 4,
			"TunaTin", 4,
			-- Ingredients
			"BakingSoda", 2,
			"Flour2", 2,
			"OatsRaw", 2,
			"OilVegetable", 2,
			"PancakeMix", 1,
			"Sugar", 2,
			"SugarBrown", 2,
			"TomatoPaste", 1,
			"Yeast", 2,
			-- Nonperishables
			"Crackers", 2,
			"PeanutButter", 2,
			-- Snacks
			"BeefJerky", 2,
			"Crisps", 1,
			"Crisps2", 1,
			"Crisps3", 1,
			"Crisps4", 1,
			"DehydratedMeatStick", 2,
			"GranolaBar", 1,
			"Peanuts", 1,
			"Popcorn", 1,
			"PorkRinds", 1,
			"Pretzel", 1,
			"SunflowerSeeds", 1,
			"TortillaChips", 1,
			-- Literature
			"BookCooking1", 1,
			"BookCooking2", 1,
			"BookCooking3", 1,
			"BookCooking4", 1,
			"BookCooking5", 1,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"RecipeClipping", 10,
			-- Drinks
			"BeerBottle", 2,
			"BeerCan", 2,
			"Pop", 2,
			"Pop2", 2,
			"Pop3", 2,
			"PopBottle", 2,
			"PopBottleRare", 0.5,
			"SodaCan", 2,
			"WaterBottle", 20,
			"WaterBottle", 10,
			"WaterDispenserBottle", 0.5,
			-- Tobacco/Smoking
			"CigaretteCarton", 0.1,
			"CigarettePack", 10,
			"CigaretteRollingPapers", 4,
			"Lighter", 1,
			"LighterDisposable", 4,
			"Matchbox", 2,
			"Matches", 8,
			"TobaccoChewing", 4,
			"TobaccoLoose", 4,
			-- Misc.
			"DentedCan", 8,
			"MysteryCan", 4,
			"MysteryCan_Box", 1,
			"P38", 2,
			"Spork", 2,
			"TrapMouse", 10,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"TrapMouse", 50,
				"TrapMouse", 20,
			}
		}
	},

	-- Hardly anything left. Are you desperate enough to eat what you find in here?
	SafehouseFood_Late = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Canned Food
			"CannedBolognese", 1,
			"CannedCarrots2", 1,
			"CannedChili", 1,
			"CannedCorn", 1,
			"CannedCornedBeef", 1,
			"CannedFruitBeverage", 1,
			"CannedFruitCocktail", 1,
			"CannedMilk", 0.5,
			"CannedMushroomSoup", 1,
			"CannedPeaches", 1,
			"CannedPeas", 1,
			"CannedPineapple", 1,
			"CannedPotato2", 1,
			"CannedSardines", 1,
			"CannedTomato2", 1,
			"Dogfood", 2,
			"TinnedBeans", 1,
			"TinnedSoup", 1,
			"TomatoPaste", 1,
			"TunaTin", 1,
			-- Nonperishables
			"Crackers", 1,
			"PeanutButter", 1,
			-- Snacks
			"BeefJerky", 1,
			"DehydratedMeatStick", 1,
			-- Literature
			"BookCooking1", 1,
			"BookCooking2", 1,
			"BookCooking3", 1,
			"BookCooking4", 1,
			"BookCooking5", 1,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"HottieZ", 4,
			"RecipeClipping", 10,
			-- Trash
			"BandageDirty", 8,
			"BrokenGlass", 4,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			"SmashedBottle", 4,
			"TinCanEmpty", 50,
			"TinCanEmpty", 20,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			-- Empties
			"BeerBottleEmpty", 8,
			"BeerCanEmpty", 8,
			"BeerImportedEmpty", 1,
			"BleachEmpty", 8,
			"BrandyEmpty", 2,
			"CleaningLiquid2Empty", 8,
			"CoffeeLiquerEmpty", 1,
			"CuracaoEmpty", 1,
			"DisinfectantEmpty", 8,
			"GinEmpty", 2,
			"GrenadineEmpty", 1,
			"JuiceCranberryEmpty", 1,
			"JuiceLemonEmpty", 1,
			"JuiceOrangeEmpty", 1,
			"JuiceTomatoEmpty", 1,
			"Pop2Empty", 4,
			"Pop3Empty", 4,
			"PopBottleEmpty", 2,
			"PopBottleRareEmpty", 1,
			"PopEmpty", 4,
			"PortEmpty", 1,
			"RumEmpty", 2,
			"ScotchEmpty", 2,
			"SherryEmpty", 1,
			"SimpleSyrupEmpty", 1,
			--"SodaCanEmpty", 4,
			"TequilaEmpty", 2,
			"VermouthEmpty", 1,
			"VodkaEmpty", 2,
			"WaterBottleEmpty", 10,
			"WaterDispenserBottleEmpty", 0.1,
			"WhiskeyEmpty", 4,
			"Wine2OpenEmpty", 1,
			"WineOpenEmpty", 1,
			"WineScrewtopEmpty", 4,
			-- Vermin
			"Cockroach", 10,
			"DeadMouse", 8,
			"DeadRat", 4,
			"Maggots", 10,
			-- Misc.
			"CatFoodBag", 1,
			"DentedCan", 8,
			"DogFoodBag", 1,
			"MysteryCan", 4,
			"MysteryCan_Box", 1,
			"P38", 4,
			"Spork", 4,
			"TrapMouse", 10,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"TrapMouse", 50,
				"TrapMouse", 20,
				"TrapMouse", 20,
				"TrapMouse", 10,
			}
		}
	},

	-- Lots of icecream. Extra frozen foods and even some medical supplies.
	SafehouseFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Frozen Foods
			"CornFrozen", 8,
			"Frozen_ChickenNuggets", 8,
			"Frozen_FishFingers", 8,
			"Frozen_FrenchFries", 8,
			"MixedVegetables", 8,
			"Peas", 8,
			-- Meat
			"Bacon", 4,
			"Chicken", 8,
			"Ham", 4,
			"HotdogPack", 10,
			"MeatPatty", 10,
			"MincedMeat", 4,
			"PorkChop", 8,
			"Steak", 2,
			-- Ice Cream
			"Creamocle", 8,
			"FudgeePop", 8,
			"Icecream", 20,
			"Icecream", 10,
			"IcecreamSandwich", 8,
			"Popsicle", 8,
			-- Medical Supplies
			"AdhesiveBandageBox", 10,
			"AntibioticsBox", 1,
			"BandageBox", 8,
			"ColdpackBox", 10,
			"Disinfectant", 20,
			"Disinfectant", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Nearly empty. Some stuff left over but not much.
	SafehouseFreezer_Mid = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Frozen Foods
			"CornFrozen", 2,
			"Frozen_ChickenNuggets", 1,
			"Frozen_FishFingers", 1,
			"Frozen_FrenchFries", 1,
			"MixedVegetables", 2,
			"Peas", 2,
			-- Meat
			"Bacon", 1,
			"Chicken", 1,
			"Ham", 1,
			"MincedMeat", 1,
			"PorkChop", 1,
			-- Ice Cream
			"Icecream", 2,
			-- Medical Supplies
			"AdhesiveBandageBox", 4,
			"Bandage", 8,
			"BandageBox", 1,
			"ColdpackBox", 4,
			"Disinfectant", 8,
			"RippedSheets", 20,
			"RippedSheets", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- A few scavenged critters and some garbage. Items at the bottom should suggest some kind of story.
	SafehouseFreezer_Late = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Animals
			"DeadSquirrel", 8,
			"DeadMouse", 10,
			"DeadRat", 8,
			"DeadRabbit", 4,
			"DeadBird", 8,
			"Frog", 8,
			-- Vermin
			"Cockroach", 2,
			"Maggots", 2,
			"Worm", 4,
			-- Empties
			"GinEmpty", 2,
			"RumEmpty", 2,
			"TequilaEmpty", 2,
			"VodkaEmpty", 2,
			"WaterBottleEmpty", 8,
			"WhiskeyEmpty", 4,
			-- Trash
			"BrokenGlass", 2,
			"SmashedBottle", 1,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			-- Medical Supplies
			"BandageDirty", 8,
			"Coldpack", 1,
			"DisinfectantEmpty", 10,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			-- Misc.
			"Corkscrew", 2,
			"FlaskEmpty", 2,
			"HottieZ", 1,
			"HuntingKnife", 1,
			"IcePick", 2,
			"Photo", 2,
			"Revolver_Short", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Booze, snacks, and other things looted from restaurants, convenience stores and bars. Extra sauces and ingredients.
	SafehouseFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Alcohol
			"BeerBottle", 10,
			"BeerCan", 10,
			"BeerCanPack", 1,
			"BeerImported", 4,
			"BeerPack", 1,
			"Brandy", 2,
			"Champagne", 0.1,
			"Gin", 2,
			"Port", 1,
			"Rum", 2,
			"Scotch", 2,
			"Sherry", 1,
			"Tequila", 2,
			"Vermouth", 1,
			"Vodka", 2,
			"Whiskey", 4,
			"Wine", 2,
			"Wine2", 2,
			"WineAged", 0.5,
			"WineBox", 2,
			"WineScrewtop", 4,
			-- Mix
			"CoffeeLiquer", 2,
			"Curacao", 1,
			"Grenadine", 1,
			"JuiceCranberry", 4,
			"JuiceLemon", 4,
			"JuiceOrange", 4,
			"JuiceTomato", 4,
			"SimpleSyrup", 2,
			-- Other Drinks
			"CannedFruitBeverage", 8,
			"Pop", 10,
			"Pop2", 10,
			"Pop3", 10,
			"PopBottle", 8,
			"PopBottleRare", 4,
			"SodaCan", 8,
			--"SodaCanRare", 2,
			"WaterBottle", 8,
			-- Sauces/Condiments
			"BalsamicVinegar", 1,
			"BBQSauce", 4,
			"Dip_NachoCheese", 4,
			"Dip_Ranch", 4,
			"Dip_Salsa", 4,
			"Hotsauce", 4,
			"Ketchup", 4,
			"MapleSyrup", 2,
			"MayonnaiseFull", 4,
			"Mustard", 4,
			"RemouladeFull", 2,
			"SourCream", 4,
			"Soysauce", 2,
			-- Ingredients
			"BakingSoda", 1,
			"Butter", 2,
			"Cheese", 4,
			"EggCarton", 1,
			"Lard", 1,
			"Margarine", 2,
			"Milk", 8,
			"MilkChocolate_Personalsized", 4,
			"Processedcheese", 8,
			"Yoghurt", 8,
			-- Prepared Food
			"Biscuit", 2,
			"Burger", 4,
			"Burrito", 2,
			"Caviar", 0.01,
			"ChickenFried", 4,
			"Cornbread", 2,
			"Corndog", 4,
			"EggOmelette", 1,
			"EggScrambled", 1,
			"FriedOnionRings", 4,
			"Fries", 4,
			"Hotdog", 4,
			"Pancakes", 2,
			"Paperbag_Jays", 1,
			"Paperbag_Spiffos", 1,
			"Perogies", 1,
			"Pie", 1,
			"PieApple", 1,
			"PieBlueberry", 1,
			"PieKeyLime", 1,
			"PieLemonMeringue", 1,
			"PiePumpkin", 1,
			"Pizza", 4,
			"PotatoPancakes", 1,
			"Taco", 2,
			"Waffles", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Most of the good stuff is gone. Whatever was preserveable has been preserved or eaten. At least there's water.
	SafehouseFridge_Mid = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Alcohol
			"BeerBottle", 2,
			"BeerCan", 2,
			"Gin", 0.1,
			"Rum", 0.1,
			"Scotch", 0.1,
			"Tequila", 0.1,
			"Vodka", 0.1,
			"Whiskey", 0.5,
			"Wine", 0.1,
			"Wine2", 0.1,
			"WineBox", 0.5,
			"WineScrewtop", 1,
			-- Mix
			"JuiceCranberry", 0.1,
			"JuiceLemon", 0.1,
			"JuiceOrange", 0.1,
			"JuiceTomato", 0.1,
			"SimpleSyrup", 0.5,
			-- Other Drinks
			"CannedFruitBeverage", 1,
			"Pop", 2,
			"Pop2", 2,
			"Pop3", 2,
			"PopBottle", 1,
			"PopBottleRare", 0.1,
			"SodaCan", 2,
			"WaterBottle", 20,
			"WaterBottle", 10,
			"WaterDispenserBottle", 1,
			-- Sauces/Condiments
			"BBQSauce", 1,
			"Dip_NachoCheese", 0.5,
			"Dip_Ranch", 0.5,
			"Dip_Salsa", 0.5,
			"Hotsauce", 1,
			"Ketchup", 2,
			"MapleSyrup", 0.5,
			"MayonnaiseFull", 1,
			"Mustard", 2,
			"RemouladeFull", 0.5,
			"SourCream", 1,
			"Soysauce", 1,
			-- Ingredients
			"BakingSoda", 1,
			"Butter", 1,
			"Cheese", 2,
			"EggCarton", 0.1,
			"Lard", 0.1,
			"Margarine", 1,
			"Milk", 2,
			"MilkChocolate_Personalsized", 0.5,
			"Processedcheese", 4,
			"Yoghurt", 4,
			-- Prepared Food
			"Burger", 2,
			"Burrito", 1,
			"Caviar", 0.01,
			"ChickenFried", 2,
			"Corndog", 2,
			"FriedOnionRings", 1,
			"Fries", 1,
			"Hotdog", 2,
			"Pizza", 2,
			"Taco", 1,
			-- Preserved Food
			"CannedBellPepper", 2,
			"CannedBroccoli", 2,
			"CannedCabbage", 2,
			"CannedCarrots", 2,
			"CannedEggplant", 2,
			"CannedLeek", 2,
			"CannedRedRadish", 2,
			"CannedRedRadish", 2,
			"CannedTomato", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- You'd be lucky to find anything edible here. Interesting items at the bottom ala the 'Late' freezer.
	SafehouseFridge_Late = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"BakingSoda", 1,
			-- Preserved Food
			"CannedBellPepper", 0.1,
			"CannedBroccoli", 0.1,
			"CannedCabbage", 0.1,
			"CannedCarrots", 0.1,
			"CannedEggplant", 0.1,
			"CannedLeek", 0.1,
			"CannedRedRadish", 0.1,
			"CannedRedRadish", 0.1,
			"CannedTomato", 0.1,
			-- Animals
			"DeadSquirrel", 8,
			"DeadMouse", 10,
			"DeadRat", 8,
			"DeadRabbit", 4,
			"DeadBird", 8,
			"Frog", 8,
			-- Vermin
			"Maggots", 2,
			"Worm", 4,
			-- Alcohol (Empty)
			"BeerBottleEmpty", 4,
			"BeerCanEmpty", 4,
			"GinEmpty", 1,
			"RumEmpty", 1,
			"ScotchEmpty", 1,
			"TequilaEmpty", 1,
			"VodkaEmpty", 1,
			"WhiskeyEmpty", 4,
			"WineOpenEmpty", 1,
			"Wine2OpenEmpty", 1,
			"WineScrewtopEmpty", 4,
			-- Mix (Empty)
			"CoffeeLiquerEmpty", 0.5,
			"CuracaoEmpty", 0.5,
			"GrenadineEmpty", 0.5,
			"JuiceCranberryEmpty", 1,
			"JuiceLemonEmpty", 1,
			"JuiceOrangeEmpty", 1,
			"JuiceTomatoEmpty", 1,
			"SimpleSyrupEmpty", 0.5,
			-- Other Drinks (Empty)
			"PopEmpty", 2,
			"Pop2Empty", 2,
			"Pop3Empty", 2,
			"PopBottleEmpty", 1,
			"PopBottleRareEmpty", 0.5,
			--"SodaCanEmpty", 2,
			"WaterBottle", 4,
			"WaterBottleEmpty", 8,
			"WaterDispenserBottleEmpty", 0.1,
			-- Trash
			"BandageDirty", 8,
			"BrokenGlass", 2,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			"SmashedBottle", 1,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			-- Misc.
			"Corkscrew", 2,
			"FlaskEmpty", 2,
			"HottieZ", 1,
			"HuntingKnife", 1,
			"IcePick", 2,
			"Photo", 2,
			"Revolver_Short", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Rare but well-stocked with emergency lighting supplies. Should have at least one propane lantern.
	SafehouseLighting = {
		isShop = true,
		rolls = 4,
		items = {
			-- Candles
			"Candle", 20,
			"Candle", 10,
			"CandleBox", 8,
			-- Lanterns
			"Lantern_Hurricane", 0.1,
			"Lantern_Propane", 4,
			"Propane_Refill", 20,
			"Propane_Refill", 10,
			-- Flashlights
			"Battery", 20,
			"Battery", 10,
			"BatteryBox", 8,
			"FlashLight_AngleHead", 4,
			"FlashLight_AngleHead_Army", 1,
			"HandTorch", 20,
			"LightBulb", 10,
			"LightBulbBox", 4,
			"Torch", 8,
			-- Matches/Lighters
			"Lighter", 8,
			"LighterDisposable", 20,
			"LighterFluid", 8,
			"MagnesiumFirestarter", 10,
			"Matchbox", 10,
			"Matches", 20,
			"Sparklers", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"Lantern_Propane", 100,
			}
		}
	},

	-- Late-game version of the above. Mostly electrical lighting. No fuel left.
	SafehouseLighting_Late = {
		isShop = true,
		rolls = 4,
		items = {
			-- Candles
			"Candle", 20,
			"Candle", 10,
			"CandleBox", 8,
			-- Lanterns
			"Lantern_CraftedElectric", 8,
			"Lantern_Hurricane", 0.01,
			"Lantern_Propane", 1,
			-- Flashlights
			"Battery", 20,
			"Battery", 10,
			"BatteryBox", 1,
			"FlashLight_AngleHead", 1,
			"FlashLight_AngleHead_Army", 0.1,
			"Flashlight_Crafted", 20,
			"HandTorch", 8,
			"LightBulb", 10,
			"LightBulbBox", 4,
			"Torch", 2,
			-- Matches/Lighters
			"Lighter", 1,
			"LighterDisposable", 8,
			"MagnesiumFirestarter", 10,
			"Matchbox", 10,
			"Matches", 20,
			"Sparklers", 8,
			-- Lightbars
			"LightbarRed", 10,
			"LightbarRedBlue", 10,
			"LightbarYellow", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Lantern_CraftedElectric", 100,
			}
		}
	},

	-- Fresh medical supplies and lots of them. Scavenged from pharmacies and clinics.
	SafehouseMedical = {
		isShop = true,
		rolls = 4,
		items = {
			-- Bandages
			"AdhesiveBandageBox", 20,
			"Bandaid", 50,
			"Bandaid", 20,
			"Bandage", 20,
			"Bandage", 10,
			"BandageBox", 8,
			-- Pills
			"Antibiotics", 8,
			"AntibioticsBox", 1,
			"Pills", 50,
			"Pills", 20,
			"PillsAntiDep", 20,
			"PillsBeta", 20,
			"PillsSleepingTablets", 20,
			"PillsVitamins", 20,
			-- Disinfectant
			"AlcoholWipes", 50,
			"AlcoholWipes", 20,
			"Bleach", 20,
			"Bleach", 10,
			"Disinfectant", 20,
			"Disinfectant", 10,
			-- Gloves/Masks
			"Gloves_Surgical", 20,
			"Hat_SurgicalMask", 20,
			-- Tools
			"Scalpel", 20,
			"ScissorsBluntMedical", 20,
			"Stethoscope", 4,
			"SutureNeedle", 20,
			"SutureNeedleBox", 8,
			"SutureNeedleHolder", 20,
			"Tweezers", 20,
			-- Materials
			"CottonBalls", 20,
			"CottonBallsBox", 8,
			"TongueDepressor", 20,
			"TongueDepressorBox", 8,
			-- Literature
			"Book_Medical", 4,
			"BookFirstAid1", 10,
			"BookFirstAid2", 8,
			"BookFirstAid3", 6,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			-- Bags/Containers
			"Bag_MedicalBag", 1,
			"Bag_Satchel_Medical", 1,
			"FirstAidKit_New", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Still a decent stash left but starting to run thin. Herbal remedies are now being used due to shortages.
	SafehouseMedical_Mid = {
		rolls = 4,
		items = {
			-- Bandages
			"AdhesiveBandageBox", 8,
			"Bandaid", 20,
			"Bandaid", 10,
			"Bandage", 8,
			"BandageBox", 2,
			"RippedSheets", 50,
			"RippedSheets", 20,
			-- Pills
			"Antibiotics", 2,
			"AntibioticsBox", 0.1,
			"Pills", 20,
			"Pills", 10,
			"PillsAntiDep", 10,
			"PillsBeta", 10,
			"PillsSleepingTablets", 10,
			"PillsVitamins", 10,
			-- Herbs
			"BlackSageDried", 8,
			"ComfreyDried", 8,
			"CommonMallowDried", 8,
			"Ginseng", 8,
			"PlantainDried", 8,
			"WildGarlicDried", 8,
			-- Disinfectant
			"AlcoholWipes", 20,
			"AlcoholWipes", 10,
			"Bleach", 8,
			"Disinfectant", 8,
			-- Gloves/Masks
			"Gloves_Surgical", 20,
			"Hat_SurgicalMask", 20,
			-- Tools
			"MortarPestle", 10,
			"Scalpel", 10,
			"ScissorsBluntMedical", 10,
			"Stethoscope", 2,
			"SutureNeedle", 10,
			"SutureNeedleBox", 2,
			"SutureNeedleHolder", 10,
			"Tweezers", 10,
			-- Materials
			"CottonBalls", 10,
			"CottonBallsBox", 4,
			"Tissue", 10,
			"TissueBox", 4,
			"ToiletPaper", 8,
			"TongueDepressor", 10,
			"TongueDepressorBox", 4,
			-- Literature
			"Book_Medical", 4,
			"BookFirstAid1", 10,
			"BookFirstAid2", 8,
			"BookFirstAid3", 6,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			-- Bags/Containers
			"Bag_MedicalBag", 0.5,
			"Bag_Satchel_Medical", 0.5,
			"FirstAidKit", 4,
			-- Misc.
			"Splint", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Desperation has set in. Unconvential remedies may have been used. What exactly happened here?
	SafehouseMedical_Late = {
		rolls = 4,
		items = {
			-- Bandages
			"AdhesiveBandageBox", 0.5,
			"Bandage", 4,
			"BandageDirty", 20,
			"BandageDirty", 10,
			"BandageBox", 0.1,
			"RippedSheetsDirty", 50,
			"RippedSheetsDirty", 20,
			"RippedSheets", 20,
			"RippedSheets", 10,
			-- Herbs
			"BlackSageDried", 8,
			"ComfreyDried", 8,
			"CommonMallowDried", 8,
			"Ginseng", 8,
			"PlantainDried", 8,
			"WildGarlicDried", 8,
			-- Pills
			"Antibiotics", 0.5,
			"Pills", 10,
			"PillsAntiDep", 4,
			"PillsBeta", 4,
			"PillsSleepingTablets", 4,
			"PillsVitamins", 4,
			-- Disinfectant/Alcohol
			"AlcoholWipes", 8,
			"Bleach", 8,
			"BleachEmpty", 20,
			"Disinfectant", 4,
			"DisinfectantEmpty", 20,
			"Gin", 8,
			"Rum", 8,
			"Vodka", 8,
			"Whiskey", 10,
			-- Gloves/Masks
			"Gloves_Surgical", 8,
			"Hat_SurgicalMask", 8,
			-- Tools
			"MortarPestle", 20,
			"Scalpel", 4,
			"ScissorsBluntMedical", 4,
			"SutureNeedle", 4,
			"SutureNeedleBox", 1,
			"SutureNeedleHolder", 4,
			"Tweezers", 4,
			-- Materials
			"CottonBalls", 4,
			"CottonBallsBox", 1,
			"Tissue", 10,
			"TissueBox", 4,
			"ToiletPaper", 8,
			"TongueDepressor", 4,
			"TongueDepressorBox", 1,
			-- Literature
			"Book_Medical", 4,
			"BookFirstAid1", 10,
			"BookFirstAid2", 8,
			"BookFirstAid3", 6,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			-- Bags/Containers
			"Bag_MedicalBag", 0.1,
			"Bag_Satchel_Medical", 0.1,
			"FirstAidKit", 1,
			-- Misc.
			"BlowTorch", 1,
			"CarpentryChisel", 2,
			"FireplacePoker", 2,
			"Garbagebag", 8,
			"Garbagebag_box", 4,
			"Glasses_Eyepatch_Left", 4,
			"Glasses_SafetyGoggles", 8,
			"HandAxe", 2,
			"HuntingKnife", 2,
			"KnifeFillet", 2,
			"Photo", 2,
			"Revolver_Short", 1,
			"Saw", 2,
			"Splint", 8,
			"Tarp", 4,
			"WoodenMallet", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Loads of meat and seafood looted from grocery stores. Eat it before it goes bad!
	SafehouseStove = {
		canBurn = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 4,
			"Chicken", 4,
			"MeatPatty", 4,
			"MuttonChop", 2,
			"PizzaRecipe", 0.5,
			"PorkChop", 4,
			"Sausage", 4,
			"Steak", 2,
			-- Fish/Seafood
			"FishFillet", 4,
			"Lobster", 0.1,
			"Mussels", 2,
			"Oysters", 2,
			"Salmon", 4,
			"Shrimp", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"BakingTray", 10,
				"BakingPan", 10,
				"MuffinTray", 10,
				"RoastingPan", 10,
			}
		}
	},

	-- Small animals are now supplementing what's left of the meat.
	SafehouseStove_Mid = {
		canBurn = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 1,
			"Chicken", 1,
			"MeatPatty", 1,
			"PorkChop", 1,
			"Sausage", 1,
			-- Wild Game
			"Rabbitmeat", 4,
			"Smallanimalmeat", 10,
			"Smallbirdmeat", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"BakingTray", 10,
				"BakingPan", 10,
				"MuffinTray", 10,
				"RoastingPan", 10,
			}
		}
	},

	-- Whatever's left in here probably isn't very tasty.
	SafehouseStove_Late = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Vermin
			"Cockroach", 10,
			"DeadMouse", 6,
			"DeadRabbit", 2,
			"DeadRat", 4,
			"DeadSquirrel", 4,
			"Frog", 4,
			"Maggots", 8,
			-- Trash
			"BrokenGlass", 4,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			"TinCanEmpty", 20,
			"TinCanEmpty", 10,
			"WhiskeyEmpty", 4,
			-- Misc.
			"HuntingKnife", 2,
			"KnifeFillet", 4,
			"MeatCleaver", 4,
			"PanForged", 1,
			"Revolver_Short", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"BakingTray", 10,
				"BakingPan", 10,
				"MuffinTray", 10,
				"RoastingPan", 10,
			}
		}
	},

	SafehouseTraps = {
		rolls = 4,
		items = {
			"Aerosolbomb", 10,
			"Amplifier", 8,
			"CopperScrap", 8,
			"DuctTape", 8,
			"ElectricWire", 20,
			"ElectricWire", 10,
			"ElectronicsScrap", 20,
			"ElectronicsScrap", 10,
			"Epoxy", 2,
			"ExplosiveSchematic", 20,
			"Firecracker_Crafted", 20,
			"Firecracker_Crafted", 10,
			"FlameTrap", 10,
			"MetalPipe", 10,
			"Molotov", 20,
			"MotionSensor", 8,
			"NoiseTrap", 10,
			"PipeBomb", 10,
			"RemoteCraftedV1", 10,
			"RemoteCraftedV2", 6,
			"RemoteCraftedV3", 4,
			"ScrapMetal", 4,
			"Screwdriver", 10,
			"SmokeBomb", 20,
			"SmokeBomb", 10,
			"TimerCrafted", 6,
			"TriggerCrafted", 8,
			"Twine", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SafehouseWasher = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"DishCloth", 20,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 20,
			"RippedSheetsDirty", 10,
			"RippedSheetsDirty", 10,
			"Sheet", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SalonCounter = {
		rolls = 4,
		items = {
			"BathTowel", 20,
			"Book_Fashion", 2,
			"Comb", 50,
			"HairDryer", 20,
			"HairIron", 20,
			"HairDyeCommon", 10,
			"HairDyeUncommon", 4,
			"Hairgel", 20,
			"Hairspray2", 50,
			"Magazine_Fashion", 20,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperback_Fashion", 8,
			"Scissors", 50,
			"StraightRazor", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SalonShelfHaircare = {
		rolls = 4,
		items = {
			"HairDryer", 20,
			"HairIron", 20,
			"HairDyeCommon", 50,
			"HairDyeCommon", 20,
			"HairDyeUncommon", 20,
			"HairDyeUncommon", 10,
			"Hairgel", 50,
			"Hairspray2", 50,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SalonShelfTowels = {
		rolls = 4,
		items = {
			"BathTowel", 50,
			"BathTowel", 20,
			"BathTowel", 20,
			"BathTowel", 10,
			"BathTowel", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SchoolGymSportsGear = {
		rolls = 4,
		items = {
			"BadmintonRacket", 10,
			"BarBell", 1,
			"BaseballBat", 6,
			"BaseballBat_Metal", 6,
			"Birdie", 20,
			"DumbBell", 4,
			"ElbowPad_Left_Sport", 1,
			"FieldHockeyStick", 8,
			"Gloves_IceHockeyGloves_Black", 2,
			"Gloves_IceHockeyGloves_Blue", 2,
			"Hat_FootballHelmet", 2,
			"Hat_HockeyHelmet", 2,
			"Hat_HockeyMask", 1,
			"IceHockeyNeckGuard", 4,
			"IceHockeyStick", 8,
			"Kneepad_Left_Sport", 4,
			"LaCrosseStick", 8,
			"ShinKneeGuard_L", 4,
			"Shinpad_HockeyGoalie_L", 4,
			"Shinpad_L", 4,
			"Shoulderpads_Football", 2,
			"Shoulderpads_IceHockey", 2,
			"TennisBall", 20,
			"TennisRacket", 10,
			"Vest_CatcherVest", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SchoolLockers = {
		rolls = 2,
		items = {
			-- School Supplies
			"Book_SchoolTextbook", 20,
			"Book_SchoolTextbook", 10,
			"GraphPaper", 10,
			"Notebook", 10,
			"Notepad", 8,
			"PencilCase", 8,
			"SheetPaper2", 20,
			"SheetPaper2", 10,
			-- Clothing
			"Hat_Beany", 0.1,
			"Hat_BucketHat", 0.1,
			"HoodieDOWN_WhiteTINT", 1,
			-- Literature (Generic)
			"ComicBook_Retail", 2,
			"Diary1", 1,
			"IndexCard", 10,
			"LetterHandwritten", 10,
			"Magazine_Childs", 1,
			"Magazine_Hobby", 0.1,
			"Magazine_Humor", 1,
			"Magazine_Teens", 1,
			"Note", 20,
			"Note", 10,
			"Paperback_Childs", 1,
			"Paperback_Fantasy", 1,
			"Paperback_SciFi", 1,
			"RPGmanual", 0.1,
			-- Misc.
			"Bracelet_LeftFriendshipTINT", 1,
			"DiceBag", 0.1,
			"Gum", 20,
			"Photo", 0.5,
			"RubberSpider", 0.1,
			-- Electronics/Music
			"Calculator", 4,
			"CDplayer", 2,
			"Disc_Retail", 4,
			"Earbuds", 2,
			"Headphones", 1,
			"VideoGame", 4,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			-- Sports
			"ElbowPad_Left_Sport", 0.01,
			"ElbowPad_Left_TINT", 0.005,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Sweatband", 0.1,
			"Jacket_Varsity", 2,
			"Kneepad_Left_Sport", 0.05,
			"Kneepad_Left_TINT", 0.01,
			"Shirt_Baseball_KY", 0.2,
			"Shirt_Baseball_Rangers", 0.2,
			"Shirt_Baseball_Z", 0.2,
			"Shoes_BlueTrainers", 0.1,
			"Shoes_RedTrainers", 0.1,
			"Shoes_TrainerTINT", 2,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortSport", 0.5,
			"Sportsbottle", 0.1,
			"Trousers_Sport", 0.2,
			"Tshirt_LongSleeve_SuperColor", 0.2,
			"Tshirt_Sport", 0.2,
			"Tshirt_SportDECAL", 0.2,
			"Tshirt_SuperColor", 0.2,
			"Tshirt_TieDye", 0.2,
			"Whistle", 0.1,
			-- Bags/Containers
			"Bag_Satchel", 4,
			"Bag_Schoolbag", 4,
			"Bag_Schoolbag_Patches", 0.1,
			"Lunchbag", 2,
			"Lunchbox", 2,
			"Lunchbox2", 0.001,
			-- Special
			"Firecracker", 1,
			"Hat_HalloweenMaskDevil", 0.005,
			"Hat_HalloweenMaskMonster", 0.005,
			"Hat_HalloweenMaskPumpkin", 0.005,
			"Hat_HalloweenMaskSkeleton", 0.005,
			"Hat_HalloweenMaskVampire", 0.005,
			"Hat_HalloweenMaskWitch", 0.005,
			"WeaponMag7", 0.01,
			"Money", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
			}
		}
	},

	SchoolLockersBad = {
		rolls = 2,
		items = {
			-- Keys/Keyrings
			"KeyRing_EagleFlag", 0.1,
			"KeyRing_EightBall", 0.1,
			"KeyRing_Panther", 0.1,
			"KeyRing_Sexy", 0.1,
			-- Schoolbags
			"Bag_Schoolbag", 4,
			"Bag_Schoolbag_Patches", 0.5,
			-- School Supplies
			"Book_SchoolTextbook", 2,
			"Calculator", 0.5,
			"GraphPaper", 4,
			"Notebook", 6,
			"Notepad", 4,
			"PencilCase", 8,
			"RubberBand", 2,
			"SheetPaper2", 4,
			-- Clothing
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_BucketHat", 0.1,
			"HoodieDOWN_WhiteTINT", 2,
			"Jacket_Black", 2,
			"Jacket_Leather_Punk", 1,
			"Jacket_Varsity", 2,
			"Tshirt_LongSleeve_SuperColor", 0.5,
			"Tshirt_SuperColor", 0.5,
			"Tshirt_TieDye", 0.5,
			-- Electronics/Music
			"CDplayer", 4,
			"Disc_Retail", 8,
			"Earbuds", 4,
			"Headphones", 2,
			"VideoGame", 10,
			-- Gym Stuff
			"Hat_Sweatband", 0.1,
			"Kneepad_Left_Sport", 0.1,
			"Shoes_BlueTrainers", 0.1,
			"Shoes_RedTrainers", 0.1,
			"Shoes_TrainerTINT", 2,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortSport", 0.5,
			"Trousers_Sport", 0.2,
			"Tshirt_Sport", 0.2,
			"Tshirt_SportDECAL", 0.2,
			"Whistle", 1,
			-- Personal
			"ComicBook_Retail", 10,
			"Diary1", 1,
			"Gum", 20,
			"LetterHandwritten", 4,
			"Lunchbag", 2,
			"Lunchbox", 2,
			"Lunchbox2", 0.001,
			"Magazine_Horror", 0.5,
			"Magazine_Humor", 1,
			"Magazine_Teens", 1,
			"Money", 8,
			"Photo", 0.1,
			-- Contraband
			"CigarettePack", 2,
			"CigaretteRollingPapers", 0.5,
			"Cigarillo", 2,
			"Dart", 10,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"Firecracker", 20,
			"Flask", 0.1,
			"Glasses_3dGlasses", 1,
			"Glasses_Groucho", 1,
			"Glasses_Novelty_Xray", 1,
			"Handiknife", 0.1,
			"Hat_Bandana", 0.2,
			"Hat_BandanaTINT", 0.2,
			"Hat_HalloweenMaskDevil", 0.05,
			"Hat_HalloweenMaskMonster", 0.05,
			"Hat_HalloweenMaskPumpkin", 0.05,
			"Hat_HalloweenMaskSkeleton", 0.05,
			"Hat_HalloweenMaskVampire", 0.05,
			"Hat_HalloweenMaskWitch", 0.05,
			"HempMag1", 0.01,
			"HottieZ", 8,
			"KnifeButterfly", 2,
			"KnifePocket", 0.1,
			"LighterDisposable", 8,
			"RubberSpider", 0.1,
			"SwitchKnife", 2,
			"TobaccoChewing", 4,
			"TobaccoLoose", 0.5,
			"TrapMouse", 1, -- for pranks
			"TrickMag1", 1,
			"WeaponMag4", 1,
			"WeaponMag7", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
			}
		}
	},

	ScienceMisc = {
		rolls = 4,
		items = {
			-- Literature (Generic)
			"Book_Science", 4,
			"GraphPaper", 20,
			"GraphPaper", 10,
			"IndexCard", 10,
			"Magazine_Science", 10,
			"Magazine_Tech", 10,
			"Paperback_Science", 8,
			-- Tools
			"Scalpel", 10,
			"Scissors", 4,
			"ScissorsBlunt", 8,
			"ScissorsBluntMedical", 8,
			"Screwdriver", 10,
			"SutureNeedleHolder", 10,
			"Tweezers", 10,
			-- Equipment
			"BakingTray", 8,
			"BlowerFan", 0.1,
			"Extinguisher", 8,
			"Loupe", 8,
			"MeasuringTape", 1,
			"MortarPestle", 8,
			"RespiratorFilters", 2,
			-- Materials
			"CopperScrap", 4,
			"CottonBalls", 10,
			"ElectronicsScrap", 10,
			"EmptyJar", 10,
			"JarLid", 10,
			"RubberHose", 10,
			"SteelWool", 10,
			"Twine", 10,
			-- Clothing
			"Glasses_SafetyGoggles", 10,
			"Gloves_Dish", 10,
			"Gloves_Surgical", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 8,
			"Hat_EarMuff_Protectors", 4,
			"JacketLong_Doctor", 1,
			-- Electronics
			"Battery", 20,
			"Battery", 10,
			"BatteryBox", 4,
			"FlashLight_AngleHead", 1,
			"HandTorch", 4,
			"LightBulb", 20,
			"LightBulb", 10,
			"PenLight", 8,
			"PowerBar", 4,
			"Torch", 1,
			-- Specimens
			"Specimen_Beetles", 4,
			"Specimen_Brain", 1,
			"Specimen_Butterflies", 4,
			"Specimen_Centipedes", 4,
			"Specimen_FetalCalf", 1,
			"Specimen_FetalLamb", 1,
			"Specimen_FetalPiglet", 1,
			"Specimen_Insects", 4,
			"Specimen_Minerals", 4,
			"Specimen_MonkeyHead", 1,
			"Specimen_Octopus", 1,
			"Specimen_Tapeworm", 1,
			-- Misc.
			"FirstAidKit", 2,
			"Frog", 0.01,

		},
		junk = {
			rolls = 1,
			items = {
				-- Stationery/Office
				"BluePen", 1,
				"Calculator", 8,
				"Clipboard", 8,
				"CompassGeometry", 8,
				"Eraser", 6,
				"MagnifyingGlass", 8,
				"Paperclip", 8,
				"Pen", 4,
				"Pencil", 4,
				"RedPen", 1,
				"RubberBand", 8,
				"Stapler", 8,
				"Staples", 8,
				"Tsquare", 2,
			}
		}
	},

	SeafoodKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"FishFillet", 4,
			"Lobster", 8,
			"Oysters", 4,
			"Salmon", 4,
			"Shrimp", 8,
			-- Spices
			"Pepper", 8,
			"Salt", 8,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Twine", 10,
			-- Utensils
			"Fleshing_Tool", 10,
			"KitchenKnife", 6,
			"KnifeFillet", 6,
			"LargeKnife", 2,
			"MeatCleaver", 4,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
			-- Clothing
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SeafoodKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Seafood
			"FishFillet", 4,
			"Frozen_FishFingers", 8,
			"Salmon", 4,
			"Shrimp", 20,
			"Shrimp", 10,
			-- Fries
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SeafoodKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Seafood
			"Lobster", 8,
			"Oysters", 8,
			"Salmon", 4,
			"Shrimp", 8,
			"Squid", 2,
			-- Fruit
			"Lemon", 8,
			-- Sauces/Condiments
			"MayonnaiseFull", 8,
			"RemouladeFull", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SeafoodKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Hotsauce", 8,
			"Ketchup", 4,
			"Mustard", 2,
			"Vinegar2", 8,
			"Vinegar_Jug", 1,
			-- Utensils
			"Ladle", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SecurityDesk = {
		rolls = 2,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_SecurityPass", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Food
			"Danish", 1,
			"DoughnutChocolate", 1,
			"DoughnutFrosted", 1,
			"DoughnutJelly", 1,
			"DoughnutPlain", 1,
			-- Outfit
			"Glasses_Aviators", 1,
			"Glasses_Sun", 2,
			"HandTorch", 4,
			"WalkieTalkie4", 1,
			"Zipties", 10,
			-- Weapons (Melee)
			"Nightstick", 2,
			"ShortBat", 0.5,
			-- Guns/Ammo
			"9mmClip", 0.1,
			"Bullets38Box", 2,
			"Bullets9mmBox", 1,
			"Pistol", 0.1,
			"Revolver_Short", 0.5,
			-- Medical
			"Pills", 1,
			"PillsVitamins", 1,
			-- Literature
			"Notepad", 10,
			"Book_Legal", 4,
			"Diary2", 0.1,
			"Journal", 10,
			"Magazine_Crime", 4,
			"Magazine_Police", 10,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Paperback_CrimeFiction", 4,
			"Paperback_Legal", 8,
			"Paperwork", 20,
			"Paperwork", 10,
			-- Misc.
			"CardDeck", 8,
			"CDplayer", 2,
			"CigarettePack", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flask", 0.5,
			"Gum", 10,
			"Headphones", 1,
			"LighterDisposable", 2,
			"MenuCard", 10,
			"Money", 4,
			"PokerChips", 2,
			"Sportsbottle", 1,
			"TobaccoChewing", 1,
			-- Moveables
			"Mov_BlackModernPhone", 0.01,
			-- Special
			"ArmorMag7", 0.001,
		},
		junk = ClutterTables.DeskJunk,
	},

	SecurityLockers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_SecurityPass", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- Weapons (Melee)
			"Nightstick", 2,
			"ShortBat", 0.5,
			-- Outfit
			"Belt2", 4,
			"Glasses_Aviators", 1,
			"Glasses_Sun", 2,
			"HolsterShoulder", 0.1,
			"HolsterSimple_Black", 0.5,
			"WalkieTalkie4", 1,
			"WristWatch_Left_ClassicMilitary", 1,
			"Zipties", 10,
			-- Medical
			"FirstAidKit", 4,
			"FirstAidKit_NewPro", 0.1,
			-- Guns/Ammo
			"9mmClip", 0.1,
			"Bullets38Box", 2,
			"Bullets9mmBox", 1,
			"Pistol", 0.1,
			"Revolver_Short", 0.5,
			-- Literature (Generic)
			"Magazine", 4,
			"Magazine_Crime", 4,
			"Magazine_Police", 8,
			"Paperback_CrimeFiction", 4,
			"Paperback_Legal", 8,
			-- Misc.
			"CigarettePack", 1,
			"CDplayer", 2,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flask", 0.5,
			"Gum", 10,
			"Headphones", 1,
			"LighterDisposable", 2,
			"Money", 4,
			"Sportsbottle", 1,
			"TobaccoChewing", 1,
			-- Special
			"ArmorMag7", 0.001,
		},
		junk = {
			rolls = 1,
			items = {
				"CombinationPadlock", 10,
				"Padlock", 1,
			}
		}
	},

	ServingTrayBiscuits = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Biscuit", 20,
			"Biscuit", 20,
			"Biscuit", 10,
			"Biscuit", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayBurgers = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Burger", 20,
			"Burger", 20,
			"Burger", 10,
			"Burger", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayBurritos = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Burrito", 20,
			"Burrito", 20,
			"Burrito", 10,
			"Burrito", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayChicken = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Chicken", 20,
			"Chicken", 20,
			"Chicken", 10,
			"Chicken", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayChickenFried = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ChickenFried", 20,
			"ChickenFried", 20,
			"ChickenFried", 10,
			"ChickenFried", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayChickenNuggets = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ChickenNuggets", 20,
			"ChickenNuggets", 20,
			"ChickenNuggets", 10,
			"ChickenNuggets", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayChickenWings = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ChickenWings", 20,
			"ChickenWings", 20,
			"ChickenWings", 10,
			"ChickenWings", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayCornbread = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Cornbread", 20,
			"Cornbread", 20,
			"Cornbread", 10,
			"Cornbread", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayFish = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"FishFillet", 20,
			"FishFillet", 20,
			"FishFillet", 10,
			"FishFillet", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayFishFried = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"FishFried", 20,
			"FishFried", 20,
			"FishFried", 10,
			"FishFried", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayFishFingers = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"FishFingers", 20,
			"FishFingers", 20,
			"FishFingers", 10,
			"FishFingers", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayFries = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"FrenchFries", 20,
			"FrenchFries", 20,
			"FrenchFries", 10,
			"FrenchFries", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayGravy = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Gravy", 20,
			"Gravy", 20,
			"Gravy", 10,
			"Gravy", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayHam = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"HamSlice", 20,
			"HamSlice", 20,
			"HamSlice", 10,
			"HamSlice", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayHotdogs = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Hotdog", 20,
			"Hotdog", 20,
			"Hotdog", 10,
			"Hotdog", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayLobster = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Lobster", 20,
			"Lobster", 20,
			"Lobster", 10,
			"Lobster", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayMaki = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Maki", 20,
			"Maki", 20,
			"Maki", 20,
			"Maki", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayMeatDumplings = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"MeatDumpling", 20,
			"MeatDumpling", 20,
			"MeatDumpling", 10,
			"MeatDumpling", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayMeatSteamBuns = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"MeatSteamBun", 20,
			"MeatSteamBun", 20,
			"MeatSteamBun", 10,
			"MeatSteamBun", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayMussels = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Mussels", 20,
			"Mussels", 20,
			"Mussels", 10,
			"Mussels", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayNoodleSoup = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"NoodleSoup", 20,
			"NoodleSoup", 20,
			"NoodleSoup", 10,
			"NoodleSoup", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayOmelettes = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"EggOmelette", 20,
			"EggOmelette", 20,
			"EggOmelette", 10,
			"EggOmelette", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayOnigiri = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Onigiri", 20,
			"Onigiri", 20,
			"Onigiri", 10,
			"Onigiri", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayOnionRings = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"FriedOnionRings", 20,
			"FriedOnionRings", 20,
			"FriedOnionRings", 10,
			"FriedOnionRings", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayOysters = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Oysters", 20,
			"Oysters", 20,
			"Oysters", 10,
			"Oysters", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayOystersFried = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"OystersFried", 20,
			"OystersFried", 20,
			"OystersFried", 10,
			"OystersFried", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayPancakes = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Pancakes", 20,
			"Pancakes", 20,
			"Pancakes", 10,
			"Pancakes", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayPerogies = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Perogies", 20,
			"Perogies", 20,
			"Perogies", 10,
			"Perogies", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayPotatoPancakes = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"PotatoPancakes", 20,
			"PotatoPancakes", 20,
			"PotatoPancakes", 10,
			"PotatoPancakes", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayPie = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Pie", 10,
			"PieApple", 10,
			"PieBlueberry", 10,
			"PieKeyLime", 10,
			"PieLemonMeringue", 10,
			"PiePumpkin", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayPizza = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Pizza", 20,
			"Pizza", 20,
			"Pizza", 10,
			"Pizza", 10,
			"PizzaWhole", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayPorkChops = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"PorkChop", 20,
			"PorkChop", 20,
			"PorkChop", 10,
			"PorkChop", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayRefriedBeans = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"RefriedBeans", 20,
			"RefriedBeans", 20,
			"RefriedBeans", 10,
			"RefriedBeans", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTraySalmon = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Salmon", 20,
			"Salmon", 20,
			"Salmon", 10,
			"Salmon", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTraySausage = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Sausage", 20,
			"Sausage", 20,
			"Sausage", 10,
			"Sausage", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayScrambledEggs = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"EggScrambled", 20,
			"EggScrambled", 20,
			"EggScrambled", 10,
			"EggScrambled", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayShrimp = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Shrimp", 20,
			"Shrimp", 20,
			"Shrimp", 10,
			"Shrimp", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayShrimpFried = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ShrimpFried", 20,
			"ShrimpFried", 20,
			"ShrimpFried", 10,
			"ShrimpFried", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayShrimpDumplings = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"ShrimpDumpling", 20,
			"ShrimpDumpling", 20,
			"ShrimpDumpling", 10,
			"ShrimpDumpling", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTraySpringRolls = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Springroll", 20,
			"Springroll", 20,
			"Springroll", 10,
			"Springroll", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTraySteak = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Steak", 20,
			"Steak", 20,
			"Steak", 10,
			"Steak", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTraySushiEgg = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"SushiEgg", 20,
			"SushiEgg", 20,
			"SushiEgg", 10,
			"SushiEgg", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTraySushiFish = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"SushiFish", 20,
			"SushiFish", 20,
			"SushiFish", 10,
			"SushiFish", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayTaco = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Taco", 20,
			"Taco", 20,
			"Taco", 10,
			"Taco", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayTatoDots = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"TatoDots", 20,
			"TatoDots", 20,
			"TatoDots", 10,
			"TatoDots", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayTofuFried = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"TofuFried", 20,
			"TofuFried", 20,
			"TofuFried", 10,
			"TofuFried", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ServingTrayWaffles = {
		cookFood = true,
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Waffles", 20,
			"Waffles", 20,
			"Waffles", 10,
			"Waffles", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	SewingStoreDye = {
		isShop = true,
		rolls = 6,
		items = {
			"IndustrialDye", 50,
			"IndustrialDye", 20,
			"IndustrialDye", 20,
			"IndustrialDye", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	SewingStoreFabric = {
		isShop = true,
		rolls = 4,
		items = {
			"Sheet", 20,
			"Sheet", 20,
			"Sheet", 10,
			"Sheet", 10,
			"Thread", 20,
			"Thread", 10,
			"Yarn", 20,
			"Yarn", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	SewingStoreTools = {
		isShop = true,
		rolls = 4,
		items = {
			"Awl", 4,
			"Button", 6,
			"Button", 6,
			"KnittingNeedles", 20,
			"KnittingNeedles", 10,
			"Needle", 20,
			"Needle", 10,
			"Scissors", 8,
			"SewingKit", 4,
			"Thread", 20,
			"Thread", 20,
			"Thread", 10,
			"Thread", 10,
			"Twine", 20,
			"Twine", 10,
			"Yarn", 20,
			"Yarn", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},
	
	ShelfGeneric = {
		rolls = 2,
		items = {
			"BluePen", 8,
			"Book", 10,
			"BookAiming1", 0.005,
			"BookAiming2", 0.0025,
			"BookAiming3", 0.0001,
			"BookBlacksmith1", 0.1,
			"BookBlacksmith2", 0.05,
			"BookBlacksmith3", 0.025,
			"BookButchering1", 0.1,
			"BookButchering2", 0.05,
			"BookButchering3", 0.025,
			"BookCarpentry1", 0.1,
			"BookCarpentry2", 0.05,
			"BookCarpentry3", 0.025,
			"BookCarving1", 0.005,
			"BookCarving2", 0.0025,
			"BookCarving3", 0.0001,
			"BookCooking1", 0.1,
			"BookCooking2", 0.05,
			"BookCooking3", 0.025,
			"BookElectrician1", 0.1,
			"BookElectrician2", 0.05,
			"BookElectrician3", 0.025,
			"BookFarming1", 0.1,
			"BookFarming2", 0.05,
			"BookFarming3", 0.025,
			"BookFirstAid1", 0.1,
			"BookFirstAid2", 0.05,
			"BookFirstAid3", 0.025,
			"BookFishing1", 0.1,
			"BookFishing2", 0.05,
			"BookFishing3", 0.025,
			"BookForaging1", 0.1,
			"BookForaging2", 0.05,
			"BookForaging3", 0.025,
			"BookGlassmaking1", 0.1,
			"BookGlassmaking2", 0.05,
			"BookGlassmaking3", 0.025,
			"BookHusbandry1", 0.1,
			"BookHusbandry2", 0.05,
			"BookHusbandry3", 0.025,
			"BookLongBlade1", 0.005,
			"BookLongBlade2", 0.0025,
			"BookLongBlade3", 0.0001,
			"BookMaintenance1", 0.1,
			"BookMaintenance2", 0.05,
			"BookMaintenance3", 0.025,
			"BookMasonry1", 0.1,
			"BookMasonry2", 0.05,
			"BookMasonry3", 0.025,
			"BookMechanic1", 0.1,
			"BookMechanic2", 0.05,
			"BookMechanic3", 0.025,
			"BookMetalWelding1", 0.1,
			"BookMetalWelding2", 0.05,
			"BookMetalWelding3", 0.025,
			"BookPottery1", 0.1,
			"BookPottery2", 0.05,
			"BookPottery3", 0.025,
			"BookReloading1", 0.005,
			"BookReloading2", 0.0025,
			"BookReloading3", 0.0001,
			"BookTailoring1", 0.1,
			"BookTailoring2", 0.05,
			"BookTailoring3", 0.025,
			"BookTracking1", 0.1,
			"BookTracking2", 0.05,
			"BookTracking3", 0.025,
			"BookTrapping1", 0.1,
			"BookTrapping2", 0.05,
			"BookTrapping3", 0.025,
			"Brochure", 2,
			"Calculator", 1,
			"CarKey", 2,
			"Clipboard", 1,
			"ComicBook", 4,
			"CookingMag1", 0.1,
			"CookingMag2", 0.1,
			"CookingMag3", 0.1,
			"CookingMag4", 0.1,
			"CookingMag5", 0.1,
			"CookingMag6", 0.1,
			"CreditCard", 1,
			"Diary1", 0.1,
			"Diary2", 0.1,
			"Disc_Retail", 2,
			"ElectronicsMag1", 0.1,
			"ElectronicsMag2", 0.1,
			"ElectronicsMag3", 0.1,
			"ElectronicsMag4", 0.1,
			"ElectronicsMag5", 0.1,
			"EngineerMagazine1", 0.1,
			"EngineerMagazine2", 0.1,
			"FarmingMag1", 0.1,
			"FarmingMag2", 0.1,
			"FarmingMag3", 0.1,
			"FarmingMag4", 0.1,
			"FarmingMag5", 0.1,
			"FarmingMag6", 0.1,
			"FarmingMag7", 0.1,
			"FarmingMag8", 0.1,
			"FishingMag1", 0.1,
			"FishingMag2", 0.1,
			"Flier", 2,
			"GlassmakingMag1", 0.05,
			"GlassmakingMag2", 0.05,
			"GlassmakingMag3", 0.05,
			"GreenPen", 4,
			"HerbalistMag", 0.1,
			"HuntingMag1", 0.1,
			"HuntingMag2", 0.1,
			"HuntingMag3", 0.1,
			"KnittingMag1", 0.1,
			"KnittingMag2", 0.1,
			"Magazine", 5,
			"Magazine_Popular", 5,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MarkerBlack", 1,
			"MarkerBlue", 0.5,
			"MarkerGreen", 0.5,
			"MarkerRed", 0.5,
			"MechanicMag1", 0.1,
			"MechanicMag2", 0.1,
			"MechanicMag3", 0.1,
			"MetalworkMag1", 0.1,
			"MetalworkMag2", 0.1,
			"MetalworkMag3", 0.1,
			"MetalworkMag4", 0.1,
			"Newspaper", 4,
			"Newspaper_Recent", 4,
			"Note", 10,
			"Notebook", 10,
			"Notepad", 8,
			"Paperback", 20,
			"Paperwork", 20,
			"Paperwork", 10,
			"Pen", 8,
			"Pencil", 10,
			"Photo", 1,
			"RedPen", 8,
			"Phonebook", 10,
			"RPGmanual", 0.1,
			"SheetPaper2", 10,
			"SmithingMag1", 0.01,
			"SmithingMag2", 0.01,
			"SmithingMag3", 0.01,
			"SmithingMag4", 0.01,
			"SmithingMag5", 0.01,
			"SmithingMag6", 0.01,
			"SmithingMag7", 0.01,
			"SmithingMag8", 0.01,
			"SmithingMag9", 0.01,
			"SmithingMag10", 0.01,
			"SmithingMag11", 0.01,
			"TVMagazine", 8,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SmokingRoomCigars = {
		rolls = 4,
		items = {
			"Cigar", 50,
			"Cigar", 20,
			"CigarBox", 8,
			"Matchbox", 10,
			"Lighter", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"CigarBox", 50,
			}
		}
	},

	SmokingRoomPipes = {
		rolls = 4,
		items = {
			"SmokingPipe", 8,
			"TobaccoLoose", 20,
			"TobaccoLoose", 10,
			"Matchbox", 10,
			"Lighter", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"SmokingPipe", 50,
			}
		}
	},

	SpiffosDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Spiffos", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- TODO: Sort Me!
			"Flask", 0.5,
			"MenuCard", 20,
			"MenuCard", 10,
			"Paperback_Fiction", 4,
			"Paperwork", 20,
			"Paperwork", 10,
			"PenSpiffo", 10,
			"PencilSpiffo", 10,
			"TVMagazine", 8,
			"Whiskey", 0.5,
		},
		junk = ClutterTables.DeskJunk,
	},

	SpiffosDiningCounter = {
		rolls = 4,
		items = {
			"FountainCup", 20,
			"FountainCup", 10,
			"MenuCard", 20,
			"MenuCard", 10,
			"Paperbag_Spiffos", 20,
			"Paperbag_Spiffos", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			"PlasticTray", 20,
			"PlasticTray", 10,
			"Straw2", 20,
			"Straw2", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SpiffosKitchenBags = {
		isShop = true,
		rolls = 4,
		items = {
			"Apron_Spiffos", 8,
			"DishCloth", 10,
			"Hat_FastFood_Spiffo", 4,
			"MenuCard", 20,
			"MenuCard", 10,
			"Paperbag_Spiffos", 50,
			"Paperbag_Spiffos", 20,
			"Paperbag_Spiffos", 20,
			"Paperbag_Spiffos", 10,
			"Paperbag_Spiffos", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Frying oil?
	SpiffosKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Oil
			"OilVegetable", 20,
			"OilVegetable", 10,
			-- Utensils
			"BakingPan", 10,
			"BakingTray", 10,
			"RoastingPan", 10,
			"KitchenTongs", 10,
			-- Misc.
			"DishCloth", 10,
			"OvenMitt", 10,
			-- Clothing
			"Apron_Spiffos", 8,
			"Hat_FastFood_Spiffo", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SpiffosKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"MeatPatty", 8,
			"MincedMeat", 8,
			-- Spices
			"Pepper", 8,
			"Salt", 8,
			-- Utensils
			"KitchenKnife", 6,
			"LargeKnife", 2,
			"MeatCleaver", 4,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Twine", 10,
			"Whetstone", 10,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
			-- Clothing
			"Apron_Spiffos", 8,
			"Hat_FastFood_Spiffo", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Spiffo Merchandise table for the back kitchen. Super uncommon.
	-- Collectible items need to stay RARE! Spiffo suits are for zombies only, NOT for containers!
	SpiffosKitchenSpecial = {
		rolls = 2,
		items = {
			-- Collectibles
			"BorisBadger", 1,
			"Spiffo", 1,
			"SpiffoBig", 0.001,
			"FluffyfootBunny", 1,
			"FreddyFox", 1,
			"FurbertSquirrel", 1,
			"JacquesBeaver", 1,
			"MoleyMole", 1,
			"MugSpiffo", 50, -- Should probably be reduced due to the mug showing up in scenery as an Ultra-Rare item.
			"PancakeHedgehog", 1,
			-- Utensils
			"Paperbag_Spiffos", 20,
			"Paperbag_Spiffos", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			"FountainCup", 20,
			"FountainCup", 10,
			"PlasticTray", 20,
			"PlasticTray", 10,
			"Straw2", 20,
			"Straw2", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_Spiffos", 8,
			"Hat_FastFood_Spiffo", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SpiffosKitchenCups = {
		rolls = 4,
		items = {
			-- Utensils
			"FountainCup", 50,
			"FountainCup", 20,
			"FountainCup", 20,
			"FountainCup", 10,
			"FountainCup", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			"Straw2", 50,
			"Straw2", 20,
			"Straw2", 20,
			"Straw2", 10,
			"Straw2", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_Spiffos", 8,
			"Hat_FastFood_Spiffo", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SpiffosKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 4,
			"MeatPatty", 20,
			"MeatPatty", 10,
			-- Fries
			"Frozen_FrenchFries", 20,
			"Frozen_FrenchFries", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SpiffosKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 4,
			"MeatPatty", 20,
			"MeatPatty", 10,
			-- Vegetables
			"Lettuce", 8,
			"Onion", 8,
			"Tomato", 8,
			-- Misc.
			"Processedcheese", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SpiffosKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BBQSauce", 4,
			"GravyMix", 4,
			"Hotsauce", 4,
			"Ketchup", 8,
			"Mustard", 8,
			"Vinegar2", 4,
			"Vinegar_Jug", 1,
			-- Misc.
			"DishCloth", 10,
			-- Utensils
			"Ladle", 10,
			-- Clothing
			"Apron_Spiffos", 8,
			"Hat_FastFood_Spiffo", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SpiffosKitchenTrays = {
		rolls = 4,
		items = {
			-- Utensils
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			"PlasticTray", 50,
			"PlasticTray", 20,
			"PlasticTray", 20,
			"PlasticTray", 10,
			"PlasticTray", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_Spiffos", 8,
			"Hat_FastFood_Spiffo", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreAccessories = {
		isShop = true,
		rolls = 4,
		items = {
			"AthleticCup", 2,
			"Bag_DuffelBagTINT", 6,
			"Bag_FannyPackFront", 10,
			"BathTowel", 10,
			"Book_Baseball", 4,
			"Book_Golf", 2,
			"Earbuds", 8,
			"Glasses_Sun", 8,
			"Glasses_SwimmingGoggles", 8,
			"Sportsbottle", 20,
			"Sportsbottle", 10,
			"Hat_Sweatband", 20,
			"Hat_Sweatband", 10,
			"Magazine_Health_New", 6,
			"Magazine_Golf_New", 6,
			"Magazine_Sports_New", 10,
			"Paperback_Baseball", 8,
			"Paperback_Diet", 8,
			"Paperback_Golf", 4,
			"Whistle", 50,
			"Whistle", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreBadminton = {
		isShop = true,
		rolls = 4,
		items = {
			"ElbowPad_Left_Sport", 4,
			"Hat_Sweatband", 10,
			"Kneepad_Left_Sport", 10,
			"Socks_Ankle_White", 10,
			"Birdie", 50,
			"Birdie", 20,
			"BadmintonRacket", 20,
			"BadmintonRacket", 10,
			"Tshirt_PoloStripedTINT", 10,
			"Tshirt_PoloTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreBaseball = {
		isShop = true,
		rolls = 4,
		items = {
			"AthleticCup", 4,
			"Bag_BaseballBag", 8,
			"Baseball", 50,
			"Baseball", 20,
			"BaseballBat", 20,
			"BaseballBat_Metal", 10,
			"Gloves_FingerlessLeatherGloves", 10,
			"Hat_BaseballHelmet", 8,
			"Kneepad_Left_Sport", 4,
			"ShinKneeGuard_L_Baseball", 10,
			"Shirt_Baseball_KY", 8,
			"Shirt_Baseball_Rangers", 8,
			"Shirt_Baseball_Z", 8,
			"Trousers_WhiteTEXTURE", 10,
			"Vest_CatcherVest", 4,
			"Sportsbottle", 10,
			"Whistle", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreBoxing = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_DuffelBagTINT", 4,
			"ElbowPad_Left_Sport", 1,
			"Gloves_BoxingBlue", 50,
			"Gloves_BoxingBlue", 20,
			"Gloves_BoxingRed", 50,
			"Gloves_BoxingRed", 20,
			"Hat_BoxingBlue", 20,
			"Hat_BoxingBlue", 10,
			"Hat_BoxingRed", 20,
			"Hat_BoxingRed", 10,
			"HoodieDOWN_WhiteTINT", 20,
			"HoodieDOWN_WhiteTINT", 10,
			"Kneepad_Left_Sport", 4,
			"Shorts_BoxingBlue", 10,
			"Shorts_BoxingRed", 10,
			"Shoes_ArmyBoots", 6,
			"Vest_DefaultTEXTURE", 20,
			"Vest_DefaultTEXTURE", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreFootball = {
		isShop = true,
		rolls = 4,
		items = {
			"AthleticCup", 4,
			"Football_Jersey_Black", 10,
			"Football_Jersey_Blue", 10,
			"Football_Jersey_White", 10,
			"Football", 50,
			"Football", 20,
			"Hat_FootballHelmet", 20,
			"Hat_FootballHelmet", 10,
			"Shorts_FootballPants", 10,
			"Shoulderpads_Football", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreGolf = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_FannyPackFront", 10,
			"Bag_GolfBag", 10,
			"Glasses_Sun", 10,
			"Gloves_LeatherGloves", 6,
			"GolfBall", 50,
			"GolfBall", 20,
			"Golfclub", 20,
			"Golfclub", 10,
			"GolfTee", 50,
			"Hat_GolfHat", 4,
			"Hat_GolfHatTINT", 8,
			"Hat_VisorBlack", 4,
			"Hat_VisorRed", 4,
			"Hat_Visor_WhiteTINT", 10,
			"Notepad", 20,
			"Pencil", 20,
			"Trousers_Suit", 10,
			"Tshirt_PoloStripedTINT", 10,
			"Tshirt_PoloTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreIceHockey = {
		isShop = true,
		rolls = 4,
		items = {
			"AthleticCup", 10,
			"Gloves_IceHockeyGloves", 8,
			"Hat_HockeyHelmet", 10,
			"Hat_HockeyMask", 10,
			"Ice_Hockey_Jersey_Black", 4,
			"Ice_Hockey_Jersey_BlueUni", 4,
			"Ice_Hockey_Jersey_Red", 4,
			"Ice_Hockey_Jersey_White", 10,
			"IceHockeyNeckGuard", 8,
			"IceHockeyStick", 20,
			"IceHockeyStick", 10,
			"ShinKneeGuard_L_IceHockey", 8,
			"Shinpad_HockeyGoalie_L", 4,
			"Shorts_HockeyPants", 8,
			"Shoulderpads_IceHockey", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Non-specific padding for other sports.
	SportStorePadding = {
		isShop = true,
		rolls = 4,
		items = {
			"AthleticCup", 4,
			"ElbowPad_Left_Sport", 10,
			"ElbowPad_Left_TINT", 2,
			"Kneepad_Left_Sport", 20,
			"Kneepad_Left_Sport", 10,
			"Kneepad_Left_TINT", 8,
			"ShinKneeGuard_L_TINT", 1,
			"Shinpad_L", 10,
			"Shoulderpads_IceHockey", 2,
			"ShinKneeGuard_L", 4,
			"Shinpad_HockeyGoalie_L", 2,
			"Shoulderpads_Football", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreTennis = {
		isShop = true,
		rolls = 4,
		items = {
			"ElbowPad_Left_Sport", 4,
			"Hat_Sweatband", 10,
			"Kneepad_Left_Sport", 10,
			"Socks_Ankle_White", 10,
			"TennisBall", 50,
			"TennisBall", 20,
			"TennisRacket", 20,
			"TennisRacket", 10,
			"Tshirt_PoloStripedTINT", 10,
			"Tshirt_PoloTINT", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoreSneakers = {
		isShop = true,
		rolls = 4,
		items = {
			"Shoes_TrainerTINT", 10,
			"Shoes_TrainerTINT", 10,
			"Shoes_TrainerTINT", 10,
			"Shoes_TrainerTINT", 10,
			"Shoes_BlueTrainers", 10,
			"Shoes_RedTrainers", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStorageBats = {
		isShop = true,
		rolls = 4,
		items = {
			"BaseballBat", 20,
			"BaseballBat", 20,
			"BaseballBat", 10,
			"BaseballBat", 10,
			"BaseballBat_Metal", 20,
			"BaseballBat_Metal", 20,
			"BaseballBat_Metal", 10,
			"BaseballBat_Metal", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStorageBalls = {
		isShop = true,
		rolls = 4,
		items = {
			"Baseball", 20,
			"Baseball", 10,
			"Football", 20,
			"Football", 10,
			"Basketball", 20,
			"Basketball", 10,
			"SoccerBall", 20,
			"SoccerBall", 10,
			"TennisBall", 20,
			"TennisBall", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStorageHelmets = {
		isShop = true,
		rolls = 4,
		items = {
			"Hat_BaseballHelmet", 20,
			"Hat_BaseballHelmet", 10,
			"Hat_BoxingBlue", 10,
			"Hat_BoxingRed", 10,
			"Hat_FootballHelmet", 20,
			"Hat_FootballHelmet", 10,
			"Hat_HockeyHelmet", 20,
			"Hat_HockeyHelmet", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStoragePaddles = {
		isShop = true,
		rolls = 4,
		items = {
			"CanoePadel", 20,
			"CanoePadel", 20,
			"CanoePadel", 10,
			"CanoePadel", 10,
			"CanoePadelX2", 20,
			"CanoePadelX2", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStorageRacquets = {
		isShop = true,
		rolls = 4,
		items = {
			"TennisRacket", 20,
			"TennisRacket", 20,
			"TennisRacket", 10,
			"TennisRacket", 10,
			"BadmintonRacket", 20,
			"BadmintonRacket", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStorageSticks = {
		isShop = true,
		rolls = 4,
		items = {
			"FieldHockeyStick", 10,
			"IceHockeyStick", 20,
			"IceHockeyStick", 10,
			"LaCrosseStick", 20,
			"LaCrosseStick", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SportStorageWeights = {
		isShop = true,
		rolls = 4,
		items = {
			"BarBell", 20,
			"BarBell", 10,
			"DumbBell", 20,
			"DumbBell", 20,
			"DumbBell", 10,
			"DumbBell", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Mostly plastic bags. Some paper.
	StoreCounterBags = {
		isShop = true,
		rolls = 4,
		items = {
			"Plasticbag", 20,
			"Plasticbag", 20,
			"Plasticbag", 10,
			"Plasticbag", 10,
			"PaperBag", 20,
			"PaperBag", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Tote bags for high-end stores.
	StoreCounterBagsFancy = {
		isShop = true,
		rolls = 4,
		items = {
			"Tote", 50,
			"Tote", 20,
			"Tote", 20,
			"Tote", 10,
			"Tote", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Paper bags for liquor stores or takeout lunches or whatever.
	StoreCounterBagsPaper = {
		isShop = true,
		rolls = 4,
		items = {
			"PaperBag", 50,
			"PaperBag", 20,
			"PaperBag", 20,
			"PaperBag", 10,
			"PaperBag", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- The space under cash registers. Usually has supplies for keeping the storefront tidy.
	StoreCounterCleaning = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 1,
			"Key1", 1,
			"Key1", 1,
			-- Cleaning Supplies
			"Bleach", 4,
			"Bucket", 4,
			"CleaningLiquid2", 4,
			"DishCloth", 10,
			"Sponge", 10,
			-- Misc.
			"Extinguisher", 2,
		},
		junk = {
			rolls = 2,
			items = {
				"Receipt", 20,
				"Receipt", 10,
			}
		}
	},

	StoreCounterStrawsNapkins = {
		rolls = 4,
		items = {
			"Straw2", 20,
			"Straw2", 20,
			"Straw2", 10,
			"Straw2", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
			"PaperNapkins2", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	StoreCounterTobacco = {
		rolls = 4,
		items = {
			"Candle", 20,
			"Candle", 10,
			"Cigar", 0.5,
			"CigaretteRollingPapers", 1,
			"CigaretteCarton", 0.1,
			"CigarettePack", 20,
			"CigarettePack", 10,
			"Cigarillo", 8,
			"Cigarillo", 8,
			"Firecracker", 8,
			"Lighter", 10,
			"LighterDisposable", 20,
			"LighterFluid", 1,
			"Matches", 20,
			"Matches", 10,
			"ScratchTicket", 20,
			"ScratchTicket", 10,
			"Sparklers", 8,
			"TobaccoChewing", 1,
			"TobaccoLoose", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	StoreDisplayWatches = {
		rolls = 4,
		items = {
			"Pocketwatch", 1,
			"WristWatch_Left_ClassicBlack", 8,
			"WristWatch_Left_ClassicBlack", 8,
			"WristWatch_Left_ClassicBrown", 8,
			"WristWatch_Left_ClassicBrown", 8,
			"WristWatch_Left_ClassicGold", 4,
			"WristWatch_Left_ClassicGold", 4,
			"WristWatch_Left_DigitalBlack", 10,
			"WristWatch_Left_DigitalBlack", 10,
			"WristWatch_Left_DigitalDress", 6,
			"WristWatch_Left_DigitalRed", 10,
			"WristWatch_Left_DigitalRed", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Generic baking prep station. Buns/bread and other simple things.
	StoreKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Trays/Dishes
			"BakingPan", 10,
			"BakingTray", 10,
			"MuffinTray", 10,
			"RoastingPan", 10,
			-- Ingredients
			"BakingSoda", 8,
			"CannedMilk", 2,
			"CannedMilk_Box", 0.001,
			"Flour2", 20,
			"Flour2", 10,
			"OilOlive", 4,
			"OilVegetable", 8,
			"Sugar", 10,
			"Yeast", 20,
			-- Utensils
			"BreadKnife", 4,
			"KnifeParing", 2,
			"PizzaCutter", 4,
			"RollingPin", 8,
			-- Misc.
			"Aluminum", 8,
			"Twine", 4,
		},
		junk = {
			rolls = 1,
			items = {
				-- Linens
				"Apron_White", 4,
				"DishCloth", 10,
				"OvenMitt", 8,
				-- Utensils
				"KitchenTongs", 10,
				"Strainer", 10,
				"Whisk", 10,
			}
		}
	},

	-- Meat prep station. Nonspecific meat type. No seafood.
	StoreKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Chicken", 4,
			"Ham", 4,
			"MincedMeat", 4,
			"PorkChop", 4,
			"Sausage", 4,
			"Steak", 2,
			-- Spices
			"Pepper", 2,
			"PowderedGarlic", 2,
			"PowderedOnion", 2,
			"Salt", 2,
			"SeasoningSalt", 2,
			"Seasoning_Basil", 1,
			"Seasoning_Chives", 1,
			"Seasoning_Cilantro", 1,
			"Seasoning_Oregano", 1,
			"Seasoning_Parsley", 1,
			"Seasoning_Rosemary", 1,
			"Seasoning_Sage", 1,
			"Seasoning_Thyme", 1,
			-- Utensils
			"Fleshing_Tool", 20,
			"Fleshing_Tool", 10,
			"KitchenKnife", 4,
			"KnifeFillet", 8,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			"WoodenMallet", 2,
			-- Misc.
			"Aluminum", 4,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"CuttingBoardPlastic", 2,
			"Twine", 8,
			"Whetstone", 10,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
		},
		junk = {
			rolls = 1,
			items = {
				-- Linens
				"Apron_White", 4,
				"DishCloth", 10,
				-- Misc.
				"CuttingBoardPlastic", 50,
			}
		}
	},

	-- Coffee/tea prep station. Cafes have more specific containers up above.
	StoreKitchenCafe = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Mugs/Cups
			"MugWhite", 50,
			"MugWhite", 20,
			"MugWhite", 20,
			"MugWhite", 10,
			"Teacup", 50,
			"Teacup", 20,
			-- Spoons
			"Spoon", 50,
			"Spoon", 20,
			-- Kettles
			"Kettle", 8,
			"Kettle_Copper", 2,
			-- Tea/Coffee
			"Coffee2", 8,
			"Teabag2", 20,
			"Teabag2", 10,
			-- Milk/Sugar
			"CannedMilk", 2,
			"CannedMilk_Box", 0.001,
			"Sugar", 4,
			"SugarCubes", 20,
			"SugarCubes", 10,
			"SugarPacket", 20,
			"SugarPacket", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 4,
				"DishCloth", 10,
				"OvenMitt", 8,
			}
		}
	},

	-- Cleaning supplies under/around the sink.
	StoreKitchenCleaning = {
		rolls = 4,
		items = {
			-- Cleaning Supplies
			"Bleach", 4,
			"CleaningLiquid2", 8,
			"Soap2", 10,
			-- Tools
			"Bucket", 10,
			"Extinguisher", 2,
			"PipeWrench", 1,
			-- Pest Control
			"RatPoison", 2,
			"TrapMouse", 4,
		},
		junk = {
			rolls = 1,
			items = {
				-- Tools
				"DishCloth", 50,
				"Gloves_Dish", 20,
				"Sponge", 50,
				-- Junk
				"BleachEmpty", 2,
				"CleaningLiquid2Empty", 4,
			}
		}
	},

	-- Knives, forks, and spoons for eating. Small chance of extra cooking utensils as well.
	StoreKitchenCutlery = {
		rolls = 4,
		items = {
			-- Kitchenware
			"ButterKnife", 50,
			"ButterKnife", 20,
			"Fork", 50,
			"Fork", 20,
			"Spoon", 50,
			"Spoon", 20,
			-- Knives
			"BreadKnife", 2,
			"KitchenKnife", 1,
			"KnifeFillet", 2,
			"KnifeParing", 2,
			"LargeKnife", 0.1,
			"MeatCleaver", 1,
		},
		junk = {
			rolls = 1,
			items = {
				-- Utensils
				"BastingBrush", 2,
				"CarvingFork2", 2,
				"CheeseGrater", 4,
				"GrillBrush", 2,
				"KitchenTongs", 4,
				"Ladle", 4,
				"PizzaCutter", 2,
				"Spatula", 4,
				"Strainer", 2,
				"Whetstone", 10,
				"Whisk", 4,
				-- Linens
				"Apron_White", 4,
				"DishCloth", 10,
				"OvenMitt", 8,
			}
		}
	},

	-- Paper bags for takeout.
	StoreKitchenBags = {
		isShop = true,
		rolls = 4,
		items = {
			-- Paper Bags
			"PaperBag", 50,
			"PaperBag", 20,
			"PaperBag", 20,
			"PaperBag", 10,
			-- Misc.
			"MenuCard", 20,
			"MenuCard", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 4,
				"DishCloth", 10,
			}
		}
	},

	-- Disposable cups for the soda dispenser.
	StoreKitchenCups = {
		rolls = 4,
		items = {
			-- Fountain Cups
			"FountainCup", 50,
			"FountainCup", 20,
			"FountainCup", 20,
			"FountainCup", 10,
			-- Straws
			"Straw2", 50,
			"Straw2", 20,
			"Straw2", 20,
			"Straw2", 10,
			-- Misc.
			"MenuCard", 20,
			"MenuCard", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 4,
				"DishCloth", 10,
			}
		}
	},

	-- Bowls, plates, and whatever else is fit to eat off of.
	StoreKitchenDishes = {
		rolls = 4,
		items = {
			-- Bowls
			"Bowl", 20,
			"Bowl", 20,
			"Bowl", 10,
			"Bowl", 10,
			-- Plates
			"Plate", 50,
			"Plate", 20,
			"Plate", 20,
			"Plate", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 4,
				"DishCloth", 10,
				"OvenMitt", 8,
			}
		}
	},

	-- Glassware for drinks.
	StoreKitchenGlasses = {
		isShop = true,
		rolls = 4,
		items = {
			-- Glasses
			"DrinkingGlass", 50,
			"DrinkingGlass", 20,
			"DrinkingGlass", 20,
			"DrinkingGlass", 10,
			"GlassTumbler", 20,
			"GlassTumbler", 10,
			"GlassWine", 8,
			-- Mugs/Teacups
			"MugWhite", 20,
			"MugWhite", 10,
			"Teacup", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 4,
				"DishCloth", 10,
			}
		}
	},

	-- Fry-cutting station. If mashing and peeling are added in the future that'll happen here too.
	StoreKitchenPotatoes = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Potatoes
			"Potato", 50,
			"Potato", 20,
			"Potato", 20,
			"Potato", 10,
			-- Utensils
			"CuttingBoardPlastic", 2,
			"KitchenKnife", 4,
			"KnifeParing", 8,
			"Whetstone", 10,
			-- Misc.
			"EmptySandbag", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 4,
				"CuttingBoardPlastic", 50,
				"DishCloth", 10,
			}
		}
	},

	-- Pots, handled pans, and a small chance of random bakeware.
	StoreKitchenPots = {
		rolls = 4,
		items = {
			-- Pots
			"Pot", 20,
			"Pot", 10,
			"Saucepan", 10,
			"SaucepanCopper", 2,
			-- Pans
			"Pan", 20,
			"Pan", 10,
			"GridlePan", 10,
			-- Baking/Roasting
			"BakingPan", 4,
			"BakingTray", 4,
			"MuffinTray", 4,
			"RoastingPan", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 4,
				"DishCloth", 10,
				"OvenMitt", 8,
			}
		}
	},

	-- Condiment/sauce prep station. Non-specific ingredients.
	StoreKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Ingredients
			"BalsamicVinegar", 0.5,
			"Egg", 4,
			"EggCarton", 0.5,
			"JuiceLemon", 1,
			"Ketchup", 4,
			"Lemon", 2,
			"Lime", 2,
			"Mustard", 4,
			"TomatoPaste", 2,
			"Vinegar2", 4,
			"Vinegar_Jug", 0.1,
			-- Spices
			"Pepper", 4,
			"PowderedGarlic", 4,
			"PowderedOnion", 4,
			"Salt", 4,
			"Seasoning_Basil", 2,
			"Seasoning_Chives", 2,
			"Seasoning_Cilantro", 2,
			"Seasoning_Oregano", 2,
			"Seasoning_Parsley", 2,
			"Seasoning_Rosemary", 2,
			"Seasoning_Sage", 2,
			"Seasoning_Thyme", 2,
			-- Utensils
			"Bowl", 8,
			"Spoon", 10,
		},
		junk = {
			rolls = 1,
			items = {
				-- Utensils
				"Ladle", 10,
				"Whisk", 10,
				-- Linens
				"Apron_White", 4,
				"CuttingBoardPlastic", 50,
				"DishCloth", 10,
			}
		}
	},

	-- Serving trays for carrying food to tables.
	StoreKitchenTrays = {
		isShop = true,
		rolls = 4,
		items = {
			-- Trays
			"PlasticTray", 50,
			"PlasticTray", 20,
			"PlasticTray", 20,
			"PlasticTray", 10,
			-- Misc.
			"MenuCard", 20,
			"MenuCard", 10,
			"PaperNapkins2", 20,
			"PaperNapkins2", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Apron_White", 4,
				"DishCloth", 10,
			}
		}
	},

	StoreShelfBBQ = {
		isShop = true,
		rolls = 4,
		items = {
			"Apron_BBQ", 8,
			"Apron_Black", 4,
			"Apron_White", 4,
			"BBQSauce", 10,
			"BBQStarterFluid", 4,
			"BastingBrush", 8,
			"BunsHamburger", 10,
			"BunsHotdog", 10,
			"CarvingFork2", 8,
			"Charcoal", 1,
			"Charcoal", 1,
			"Charcoal", 1,
			"Charcoal", 1,
			"DryFirestarterBlock", 4,
			"Hat_ChefHat", 4,
			"KitchenTongs", 8,
			"LighterBBQ", 10,
			"OvenMitt", 8,
			"PropaneTank", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	StoreShelfBeer = {
		rolls = 1,
		items = {
			-- DEPRECATED. See 'LiquorStoreBeer' instead.
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Combined snack/drink container.
	StoreShelfCombo = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 3,
		items = {
			"Allsorts", 2,
			"BeefJerky", 10,
			"CandyCaramels", 2,
			"CandyCorn", 2,
			"CandyFruitSlices", 2,
			"CandyGummyfish", 2,
			"CandyNovapops", 2,
			"CandyPackage", 1,
			"ChocoCakes", 4,
			"Chocolate", 4,
			"Chocolate_Butterchunkers", 2,
			"Chocolate_Candy", 4,
			"Chocolate_Crackle", 2,
			"Chocolate_Deux", 2,
			"Chocolate_GalacticDairy", 2,
			"Chocolate_RoysPBPucks", 2,
			"Chocolate_Smirkers", 2,
			"Chocolate_SnikSnak", 2,
			"ChocolateCoveredCoffeeBeans", 1,
			"Crisps", 6,
			"Crisps2", 6,
			"Crisps3", 6,
			"Crisps4", 6,
			"DehydratedMeatStick", 10,
			"GranolaBar", 8,
			"Gum", 10,
			"GummyBears", 2,
			"GummyWorms", 2,
			"HardCandies", 1,
			"HiHis", 4,
			"JellyBeans", 2,
			"Jujubes", 2,
			"LicoriceBlack", 1,
			"LicoriceRed", 2,
			"Lollipop", 2,
			"MintCandy", 1,
			"Modjeska", 2,
			"Peanuts", 4,
			"Peppermint", 1,
			"Plonkies", 4,
			"Pop", 6,
			"Pop2", 6,
			"Pop3", 6,
			"PopBottle", 2,
			"PopBottleRare", 0.05,
			"PorkRinds", 4,
			"QuaggaCakes", 4,
			"SnoGlobes", 4,
			"SunflowerSeeds", 4,
			"TortillaChips", 6,
			"WaterBottle", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Mostly soda. Some water.
	StoreShelfDrinks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Pop", 20,
			"Pop", 10,
			"Pop2", 20,
			"Pop2", 10,
			"Pop3", 20,
			"Pop3", 10,
			"PopBottle", 20,
			"PopBottle", 10,
			"PopBottleRare", 2,
			"SodaCan", 20,
			"SodaCan", 10,
			--"SodaCanRare", 4,
			"WaterBottle", 20,
			"WaterBottle", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Generic electronics found on non-specialized store shelves.
	StoreShelfElectronics = {
		isShop = true,
		rolls = 4,
		items = {
			"BatteryBox", 20,
			"BatteryBox", 10,
			"Bullhorn", 1,
			"CordlessPhone", 8,
			"HairDryer", 10,
			"HairIron", 10,
			"HandTorch", 8,
			"HomeAlarm", 10,
			"Microphone", 4,
			"Pager", 10,
			"PenLight", 8,
			"PowerBar", 20,
			"PowerBar", 10,
			"RadioBlack", 6,
			"RadioRed", 4,
			"Remote", 10,
			"Torch", 4,
			"WalkieTalkie1", 6,
			"WalkieTalkie2", 4,
			"WalkieTalkie3", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Basic road supplies for gas stations.
	StoreShelfMechanics = {
		isShop = true,
		rolls = 4,
		items = {
			"Base.LouisvilleMap1", 0.05,
			"Base.LouisvilleMap2", 0.05,
			"Base.LouisvilleMap3", 0.05,
			"Base.LouisvilleMap4", 0.05,
			"Base.LouisvilleMap5", 0.05,
			"Base.LouisvilleMap6", 0.05,
			"Base.LouisvilleMap7", 0.05,
			"Base.LouisvilleMap8", 0.05,
			"Base.LouisvilleMap9", 0.05,
			"Base.MarchRidgeMap", 0.4,
			"Base.MuldraughMap", 0.4,
			"Base.RiversideMap", 0.4,
			"Base.RosewoodMap", 0.4,
			"Base.WestpointMap", 0.4,
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"Epoxy", 1,
			"FiberglassTape", 1,
			"Funnel", 10,
			"Glasses_Aviators", 2,
			"Glasses_Sun", 10,
			"Gloves_FingerlessLeatherGloves", 2,
			"Gloves_LeatherGloves", 1,
			"Gloves_LeatherGlovesBlack", 1,
			"HeavyChain", 1,
			"LightBulb", 4,
			"LightBulb", 4,
			"LugWrench", 2,
			"Magazine_Car_New", 10,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"PetrolCanEmpty", 20,
			"PetrolCanEmpty", 10,
			"Ratchet", 10,
			"RubberHose", 10,
			"Screwdriver", 4,
			"TireIron", 2,
			"TirePump", 8,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	StoreShelfMedical = {
		isShop = true,
		rolls = 4,
		items = {
			"AlcoholWipes", 20,
			"AlcoholWipes", 10,
			"Bandaid", 20,
			"Bandaid", 10,
			"Pills", 20,
			"Pills", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Snacks found in places like gas stations.
	StoreShelfSnacks = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			-- Candy
			"Allsorts", 1,
			"CandyCaramels", 1,
			"CandyGummyfish", 1,
			"CandyNovapops", 1,
			"CandyPackage", 0.5,
			"ChocolateCoveredCoffeeBeans", 1,
			"Gum", 10,
			"GummyBears", 2,
			"GummyWorms", 2,
			"HardCandies", 1,
			"JellyBeans", 2,
			"Jujubes", 2,
			"LicoriceBlack", 1,
			"LicoriceRed", 2,
			"MintCandy", 2,
			"Modjeska", 1,
			"Peppermint", 1,
			-- Chips/Pretzels/Etc.
			"Crisps", 4,
			"Crisps2", 4,
			"Crisps3", 4,
			"Crisps4", 4,
			"Peanuts", 4,
			"PorkRinds", 4,
			"Pretzel", 4,
			"SunflowerSeeds", 4,
			"TortillaChips", 4,
			-- Chocolate Bars/Granola
			"Chocolate", 2,
			"Chocolate_Butterchunkers", 1,
			"Chocolate_Candy", 2,
			"Chocolate_Crackle", 1,
			"Chocolate_Deux", 1,
			"Chocolate_GalacticDairy", 1,
			"Chocolate_RoysPBPucks", 1,
			"Chocolate_Smirkers", 1,
			"Chocolate_SnikSnak", 1,
			"GranolaBar", 6,
			-- Jerky/Meat
			"BeefJerky", 4,
			"DehydratedMeatStick", 8,
			-- Snack Cakes
			"ChocoCakes", 2,
			"HiHis", 2,
			"Plonkies", 2,
			"QuaggaCakes", 2,
			"SnoGlobes", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Generic spices for foods.
	StoreShelfSpices = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Pepper", 20,
			"Pepper", 10,
			"PowderedGarlic", 8,
			"PowderedOnion", 8,
			"Salt", 20,
			"Salt", 10,
			"Seasoning_Basil", 4,
			"Seasoning_Chives", 4,
			"Seasoning_Cilantro", 4,
			"Seasoning_Oregano", 4,
			"Seasoning_Parsley", 4,
			"Seasoning_Rosemary", 4,
			"Seasoning_Sage", 4,
			"Seasoning_Thyme", 4,
			"SeasoningSalt", 20,
			"SeasoningSalt", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	StoreShelfWhiskey = {
		rolls = 1,
		items = {
			-- DEPRECATED. See 'LiquorStoreWhiskey' instead.
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	StoreShelfWine = {
		rolls = 1,
		items = {
			-- DEPRECATED. See 'LiquorStoreWine' instead.
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	StoveClassy = {
		canBurn = true,
		ignoreZombieDensity = true,
		rolls = 3,
		items = {
			"Caviar", 0.1,
			"Chicken", 2,
			"Lobster", 0.5,
			"MeatPatty", 4,
			"Mussels", 1,
			"MuttonChop", 1,
			"Oysters", 1,
			"PorkChop", 2,
			"Salmon", 1,
			"Sausage", 2,
			"Shrimp", 1,
			"Steak", 0.5,
		},
		junk = {
			rolls = 1,
			canBurn = true,
			items = {
				"BakingPan", 10,
				"BakingTray", 10,
				"MuffinTray", 8,
				"RoastingPan", 10,
			}
		}
	},

	StoveGeneric = {
		canBurn = true,
		ignoreZombieDensity = true,
		rolls = 2,
		items = {
			"Chicken", 1,
			"MeatPatty", 2,
			"Mussels", 0.5,
			"MuttonChop", 0.5,
			"Oysters", 0.5,
			"PorkChop", 1,
			"Salmon", 0.5,
			"Sausage", 1,
			"Shrimp", 0.5,
			"Steak", 0.1,
		},
		junk = {
			rolls = 1,
			canBurn = true,
			items = {
				"BakingPan", 10,
				"BakingTray", 10,
				"MuffinTray", 8,
				"RoastingPan", 10,
			}
		}
	},

	StoveRedneck = {
		canBurn = true,
		ignoreZombieDensity = true,
		rolls = 1,
		items = {
			"Chicken", 0.5,
			"MeatPatty", 2,
			"PorkChop", 0.5,
			"Salmon", 0.1,
			"Sausage", 0.5,
			"Shrimp", 0.1,
			"Steak", 0.05,
		},
		junk = {
			rolls = 1,
			canBurn = true,
			items = {
				"BakingPan", 10,
				"BakingTray", 10,
				"MuffinTray", 8,
				"RoastingPan", 10,
			}
		}
	},

	StoveSpiffos = {
		canBurn = true,
		ignoreZombieDensity = true,
		rolls = 3,
		items = {
			"MeatPatty", 20,
			"MeatPatty", 20,
			"MeatPatty", 10,
			"MeatPatty", 10,
		},
		junk = {
			rolls = 1,
			canBurn = true,
			items = {
				"GrillBrush", 10,
				"KitchenTongs", 10,
				"OvenMitt", 8,
				"Spatula", 10,
			}
		}
	},

	StripClubDressers = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Sexy", 1,
			-- TODO: Sort Me!
			"Bag_Dancer", 10,
			"Bikini_Pattern01", 2,
			"Bikini_TINT", 2,
			"BoobTube", 1,
			"BoobTubeSmall", 1,
			"BottleOpener", 1,
			"Bra_Strapless_AnimalPrint", 8,
			"Bra_Strapless_Black", 10,
			"Bra_Strapless_FrillyBlack", 4,
			"Bra_Strapless_FrillyPink", 4,
			"Bra_Strapless_RedSpots", 8,
			"Bra_Strapless_White", 10,
			"Bra_Straps_AnimalPrint", 8,
			"Bra_Straps_Black", 10,
			"Bra_Straps_FrillyBlack", 4,
			"Bra_Straps_FrillyPink", 4,
			"Bra_Straps_White", 10,
			"Camera", 10,
			"CameraDisposable", 10,
			"CameraExpensive", 0.05,
			"CameraFilm", 20,
			"CameraFilm", 10,
			"CardDeck", 2,
			"Card_Valentine", 10,
			"Clitter", 10,
			"Comb", 4,
			"ComicBook", 0.1,
			"Corset", 2,
			"Corset_Black", 2,
			"Diary1", 10,
			"FrillyUnderpants_Black", 4,
			"FrillyUnderpants_Pink", 4,
			"FrillyUnderpants_Red", 4,
			"Garter", 2,
			"Gum", 10,
			"HairDryer", 8,
			"HairIron", 8,
			"Hairgel", 10,
			"Hairspray2", 10,
			"Hat_BunnyEarsBlack", 4,
			"Hat_BunnyEarsWhite", 4,
			"Hat_Police", 4,
			"HottieZ", 1,
			"IDcard_Blank", 0.1,
			"IDcard_Female", 1,
			"JewelleryBox", 4,
			"KnifeButterfly", 1,
			"Leash", 1,
			"LetterHandwritten", 10,
			"Lipstick", 6,
			"Magazine", 8,
			"Magazine_Fashion", 10,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"MakeupEyeshadow", 6,
			"MakeupFoundation", 6,
			"MenuCard", 10,
			"Mirror", 8,
			"Money", 100,
			"Money", 50,
			"Money", 20,
			"MoneyBundle", 4,
			"Paperback_Diet", 8,
			"Paperback_Fashion", 8,
			"Paperback_Relationship", 8,
			"Paperback_Sexy", 8,
			"Perfume", 4,
			"Photo_Secret", 10,
			"Pillow_Heart", 0.001,
			"PokerChips", 10,
			"Pop", 10,
			"RubberSpider", 1,
			"Shirt_CropTopNoArmTINT", 1,
			"Shirt_CropTopTINT", 1,
			"Shoes_Fancy", 1,
			"Shoes_Strapped", 1,
			"StockingsBlack", 4,
			"StockingsBlackSemiTrans", 4,
			"StockingsBlackTrans", 4,
			"StockingsWhite", 4,
			"SwitchKnife", 1,
			"TightsBlack", 4,
			"TightsBlackSemiTrans", 4,
			"TightsBlackTrans", 4,
			"TightsFishnets", 2,
			"TVMagazine", 10,
			"Tweezers", 10,
			"Underpants_Black", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SurvivalGear = {
		rolls = 4,
		items = {
			-- Survival Gear
			"Bobber", 10,
			"Candle", 10,
			"CompassDirectional", 4,
			"CopperCup", 0.5,
			"FirstAidKit_Military", 2,
			"HandTorch", 8,
			"Lantern_Hurricane", 1,
			"Lantern_Propane", 4,
			"Matches", 10,
			"MetalCup", 1,
			"P38", 10,
			"PanForged", 10,
			"PotForged", 4,
			"Propane_Refill", 8,
			"SewingKit", 4,
			"WaterPurificationTablets", 1,
			"Whetstone", 10,
			"Whistle", 2,
			-- Fishing
			"FishingHook", 10,
			"FishingHookBox", 2,
			"FishingLine", 10,
			"FishingNet", 10,
			"FishingRod", 10,
			"FishingTackle", 10,
			"FishingTackle2", 10,
			"JigLure", 10,
			"MinnowLure", 10,
			"PremiumFishingLine", 4,
			-- Army Surplus
			"ElbowPad_Left_Military", 1,
			"Kneepad_Left_Military", 4,
			"FlashLight_AngleHead_Army", 1,
			"WalkieTalkie5", 1,
			"WristWatch_Left_ClassicMilitary", 1,
			-- Guns
			"DoubleBarrelShotgun", 0.01,
			"HuntingRifle", 0.01,
			"Shotgun", 0.01,
			"VarmintRifle", 0.05,
			-- Knives/Blades
			"HandAxe", 8,
			"Handiknife", 2,
			"HuntingKnife", 4,
			"KnifeButterfly", 8,
			"KnifePocket", 2,
			"LargeKnife", 2,
			"Machete", 1,
			"Multitool", 0.01,
			"SmallKnife", 8,
			-- Sleeping Bags/ Tents
			"SleepingBag_BluePlaid_Packed", 2,
			"SleepingBag_Camo_Packed", 1,
			"SleepingBag_Cheap_Blue_Packed", 4,
			"SleepingBag_Cheap_Green2_Packed", 4,
			"SleepingBag_Cheap_Green_Packed", 4,
			"SleepingBag_Green_Packed", 2,
			"SleepingBag_GreenPlaid_Packed", 2,
			"SleepingBag_HighQuality_Brown_Packed", 1,
			"SleepingBag_RedPlaid_Packed", 2,
			"SleepingBag_Spiffo_Packed", 0.05,
			"TentBlue_Packed", 0.1,
			"TentBrown_Packed", 0.1,
			"TentGreen_Packed", 0.1,
			"TentYellow_Packed", 0.1,
			-- Clothing
			"Hat_BonnieHat", 10,
			"Hat_BonnieHat_CamoGreen", 8,
			"HoodieDOWN_WhiteTINT", 10,
			"Jacket_ArmyCamoGreen", 6,
			"Jacket_PaddedDOWN", 8,
			"LongJohns", 4,
			"LongJohns_Bottoms", 4,
			"PonchoGarbageBag", 1,
			"PonchoGreenDOWN", 4,
			"PonchoTarp", 1,
			"PonchoYellowDOWN", 4,
			"ShemaghScarf_Green", 1,
			"Shirt_CamoGreen", 8,
			"Shirt_Denim", 8,
			"Shoes_ArmyBoots", 1,
			"Shoes_ArmyBootsDesert", 0.05,
			"Shoes_HikingBoots", 6,
			"Shoes_Wellies", 4,
			"Shoes_WorkBoots", 6,
			"Shorts_CamoGreenLong", 8,
			"Socks_Heavy", 4,
			"Tshirt_ArmyGreen", 10,
			"Tshirt_CamoGreen", 10,
			"Vest_Hunting_Camo", 6,
			"Vest_Hunting_CamoGreen", 6,
			"Vest_Hunting_Grey", 2,
			-- Literature (Skill Books)
			"BookAiming1", 2,
			"BookAiming2", 1,
			"BookAiming3", 0.5,
			"BookAiming4", 0.1,
			"BookAiming5", 0.01,
			"BookBlacksmith1", 2,
			"BookBlacksmith2", 1,
			"BookBlacksmith3", 0.5,
			"BookBlacksmith4", 0.1,
			"BookBlacksmith5", 0.01,
			"BookButchering1", 2,
			"BookButchering2", 1,
			"BookButchering3", 0.5,
			"BookButchering4", 0.1,
			"BookButchering5", 0.01,
			"BookFirstAid1", 2,
			"BookFirstAid2", 1,
			"BookFirstAid3", 0.5,
			"BookFirstAid4", 0.1,
			"BookFirstAid5", 0.01,
			"BookFishing1", 2,
			"BookFishing2", 1,
			"BookFishing3", 0.5,
			"BookFishing4", 0.5,
			"BookFishing5", 0.1,
			"BookForaging1", 2,
			"BookForaging2", 1,
			"BookForaging3", 0.5,
			"BookForaging4", 0.1,
			"BookForaging5", 0.01,
			"BookHusbandry1", 2,
			"BookHusbandry2", 1,
			"BookHusbandry3", 0.5,
			"BookHusbandry4", 0.1,
			"BookHusbandry5", 0.01,
			"BookLongBlade1", 2,
			"BookLongBlade2", 1,
			"BookLongBlade3", 0.5,
			"BookLongBlade4", 0.1,
			"BookLongBlade5", 0.01,
			"BookReloading1", 2,
			"BookReloading2", 1,
			"BookReloading3", 0.5,
			"BookReloading4", 0.1,
			"BookReloading5", 0.01,
			"BookTracking1", 2,
			"BookTracking2", 1,
			"BookTracking3", 0.5,
			"BookTracking4", 0.1,
			"BookTracking5", 0.01,
			"BookTrapping1", 2,
			"BookTrapping2", 1,
			"BookTrapping3", 0.5,
			"BookTrapping4", 0.1,
			"BookTrapping5", 0.01,
			-- Literature (Recipes)
			"FishingMag1", 1,
			"FishingMag2", 1,
			"GlassmakingMag1", 4,
			"GlassmakingMag2", 4,
			"GlassmakingMag3", 4,
			"HerbalistMag", 1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"SmithingMag1", 1,
			"SmithingMag10", 1,
			"SmithingMag11", 1,
			"SmithingMag2", 1,
			"SmithingMag3", 1,
			"SmithingMag4", 1,
			"SmithingMag5", 1,
			"SmithingMag6", 1,
			"SmithingMag7", 1,
			"SmithingMag8", 1,
			"SmithingMag9", 1,
			"SurvivalSchematic", 10,
			-- Bags/Containers
			"Bag_ALICEpack", 0.5,
			"Bag_BigHikingBag", 2,
			"Bag_FannyPackFront", 2,
			"Bag_LeatherWaterBag", 1,
			"Bag_NormalHikingBag", 4,
			"Bag_RifleCaseCloth", 0.0025,
			"Bag_RifleCaseCloth2", 0.0005,
			"Bag_ShotgunCaseCloth", 0.0025,
			"Bag_ShotgunCaseCloth2", 0.0025,
			"RifleCase1", 0.0025,
			"RifleCase2", 0.0005,
			"ShotgunCase1", 0.0025,
			"ShotgunCase2", 0.0025,
			-- Special
			"SmallGoldBar", 1,
			"SmallSilverBar", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Rice prep station.
	SushiKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Rice", 20,
			"Rice", 20,
			"Rice", 10,
			"Rice", 10,
			"RiceVinegar", 10,
			-- Misc.
			"CuttingBoardWooden", 10,
			"DishCloth", 10,
			"OvenMitt", 10,
			-- Utensils
			"KitchenTongs", 10,
			"KnifeSushi", 20,
			"Strainer", 10,
			-- Clothing
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Sushi prep station.
	SushiKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Seafood
			"Salmon", 4,
			"Shrimp", 8,
			"Squid", 2,
			-- Sushi Ingredients
			"RicePaper", 8,
			"Seaweed", 8,
			-- Sauces/Condiments
			"RiceVinegar", 4,
			"Soysauce", 4,
			"Wasabi", 4,
			-- Misc.
			"CuttingBoardWooden", 10,
			"DishCloth", 10,
			-- Utensils
			"KnifeSushi", 20,
			-- Clothing
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Hat_ChefHat", 4,
			-- Literature (Skill Books)
			"BookButchering3", 1,
			"BookButchering4", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SushiKitchenCutlery = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"RicePaper", 8,
			"RiceVinegar", 4,
			"Seaweed", 8,
			"Soysauce", 4,
			-- Utensils
			"Chopsticks", 50,
			"Chopsticks", 20,
			"KnifeSushi", 20,
			"KnifeSushi", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SushiKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Salmon", 20,
			"Salmon", 10,
			"Shrimp", 20,
			"Shrimp", 20,
			"Shrimp", 10,
			"Shrimp", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SushiKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Seafood
			"FishRoe", 4,
			"Salmon", 20,
			"Salmon", 10,
			"Shrimp", 20,
			"Shrimp", 10,
			"Squid", 8,
			-- Vegetables
			"Avocado", 4,
			"BellPepper", 4,
			"Carrots", 4,
			"Cucumber", 8,
			"Daikon", 8,
			"Edamame", 8,
			"GingerPickled", 8,
			"Leek", 4,
			"Seaweed", 20,
			"Seaweed", 10,
			"Zucchini", 4,
			-- Misc.
			"Tofu", 10,
			-- Sauces/Condiments
			"Soysauce", 8,
			"Wasabi", 8,
			"RiceVinegar", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	SushiKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Condiments
			"RiceVinegar", 20,
			"RiceVinegar", 10,
			"Soysauce", 20,
			"Soysauce", 10,
			"Wasabi", 8,
			-- Utensils
			"Chopsticks", 10,
			"KnifeSushi", 4,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	TestingLab = {
		rolls = 4,
		items = {
			-- Clothing
			"Apron_White", 10,
			"Glasses_SafetyGoggles", 8,
			"Gloves_Surgical", 10,
			"Hat_BuildersRespirator", 2,
			"Hat_NBCmask", 0.1,
			"Hat_SurgicalMask", 10,
			"HazmatSuit", 0.1,
			"JacketLong_Doctor", 4,
			"Shirt_Scrubs", 8,
			"Trousers_Scrubs", 8,
			-- Medical
			"AlcoholWipes", 10,
			"Antibiotics", 4,
			"Bandage", 10,
			"CottonBalls", 10,
			"Disinfectant", 4,
			"Pills", 10,
			"PillsAntiDep", 10,
			"PillsBeta", 10,
			"PillsSleepingTablets", 10,
			-- Literature
			"Book_Medical", 4,
			"Book_Science", 4,
			"Magazine_Science", 10,
			"Magazine_Tech", 10,
			"Paperback_Medical", 8,
			"Paperback_Science", 8,
			-- Tools
			"RespiratorFilters", 2,
			"Saw", 8,
			"Scalpel", 10,
			"Tweezers", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"BluePen", 8,
				"Calculator", 8,
				"Clipboard", 8,
				"GreenPen", 4,
				"MarkerBlack", 4,
				"MarkerBlue", 0.5,
				"MarkerGreen", 0.5,
				"MarkerRed", 0.5,
				"Notebook", 2,
				"Notepad", 8,
				"Pen", 8,
				"PenFancy", 0.5,
				"RedPen", 8,
			}
		}
	},

	-- Soda dispensers aren't functional at the moment so have some spare soda.
	-- This will eventually hold only fountain cups, straws, and related objects.
	TheatreDrinks = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Soda
			"Pop", 10,
			"Pop2", 10,
			"Pop3", 10,
			"PopBottle", 8,
			"PopBottleRare", 1,
			"SodaCan", 8,
			--"SodaCanRare", 2,
			-- Misc.
			"FountainCup", 50,
			"FountainCup", 20,
			"PaperNapkins2", 50,
			"PaperNapkins2", 20,
			"Straw2", 50,
			"Straw2", 20,
		},
		junk = {
			rolls = 1,
			items = {
				"DishCloth", 10,
			}
		}
	},

	TheatreKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Creamocle", 8,
			"FudgeePop", 8,
			"Icecream", 20,
			"Icecream", 20,
			"Icecream", 10,
			"Icecream", 10,
			"IcecreamSandwich", 8,
			"Popsicle", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	TheatreLiterature = {
		rolls = 4,
		items = {
			"Magazine_Cinema_New", 50,
			"Magazine_Cinema_New", 20,
			"Magazine_Cinema_New", 20,
			"Magazine_Cinema_New", 10,
			"Magazine_Cinema_New", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	TheatreSnacks = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"CandyCaramels", 8,
			"CandyFruitSlices", 8,
			"CandyGummyfish", 8,
			"CandyNovapops", 8,
			"CandyPackage", 4,
			"Chocolate", 8,
			"Chocolate_Butterchunkers", 8,
			"Chocolate_Candy", 8,
			"Chocolate_Crackle", 8,
			"Chocolate_Deux", 8,
			"Chocolate_GalacticDairy", 8,
			"Chocolate_RoysPBPucks", 8,
			"Chocolate_Smirkers", 8,
			"Chocolate_SnikSnak", 8,
			"GummyBears", 8,
			"GummyWorms", 8,
			"JellyBeans", 8,
			"Jujubes", 8,
			"LicoriceBlack", 4,
			"LicoriceRed", 6,
			"Pretzel", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	TheatrePopcorn = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Popcorn", 50,
			"Popcorn", 20,
			"Popcorn", 20,
			"Popcorn", 10,
			"Popcorn", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Accessories for properly enjoying fine tobacco.
	TobaccoStoreAccessories = {
		isShop = true,
		rolls = 4,
		items = {
			"CigaretteRollingPapers", 50,
			"CigaretteRollingPapers", 20,
			"Lighter", 20,
			"Lighter", 10,
			"Matchbox", 50,
			"Matchbox", 20,
			-- Empty Cigar Boxes
			"CigarBox", 8,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Watch where you spit!
	TobaccoStoreChew = {
		rolls = 4,
		items = {
			"TobaccoChewing", 50,
			"TobaccoChewing", 20,
			"TobaccoChewing", 20,
			"TobaccoChewing", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Packs and cartons.
	TobaccoStoreCigarettes = {
		isShop = true,
		rolls = 4,
		items = {
			"CigaretteCarton", 8,
			"CigarettePack", 50,
			"CigarettePack", 20,
			"CigarettePack", 20,
			"CigarettePack", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Stink the place up on a budget!
	TobaccoStoreCigarillos = {
		isShop = true,
		rolls = 4,
		items = {
			"Cigarillo", 50,
			"Cigarillo", 20,
			"Cigarillo", 50,
			"Cigarillo", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- The finest local and imported cigars, all in one spot!
	TobaccoStoreCigars = {
		rolls = 4,
		items = {
			"Cigar", 50,
			"Cigar", 20,
			"CigarBox", 20,
			"CigarBox", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"CigarBox", 10,
			}
		}
	},

	-- Just like grandpa used to smoke!
	TobaccoStorePipes = {
		rolls = 4,
		items = {
			"SmokingPipe", 20,
			"SmokingPipe", 10,
			"TobaccoLoose", 50,
			"TobaccoLoose", 20,
			"TobaccoLoose", 20,
			"TobaccoLoose", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	ToolCabinetMechanics = {
		rolls = 4,
		items = {
			"Battery", 10,
			"BatteryBox", 1,
			"BlowerFan", 1,
			"BlowTorch", 4,
			"Calipers", 2,
			"CarBatteryCharger", 1,
			"CopperScrap", 2,
			"DuctTape", 4,
			"ElbowPad_Left_Workman", 1,
			"ElectricWire", 10,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"File", 4,
			"Funnel", 10,
			"HandDrill", 4,
			"HeavyChain", 8,
			"HeavyChain_Hook", 1,
			"Jack", 2,
			"Kneepad_Left_Workman", 4,
			"LargeHook", 2,
			"LugWrench", 8,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 0.5,
			"MetalworkingPunch", 4,
			"NutsBolts", 10,
			"Pliers", 8,
			"Ratchet", 10,
			"RubberHose", 10,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.1,
			"SmallFileSet", 4,
			"SmallPunchSet", 4,
			"SmallSaw", 4,
			"TireIron", 4,
			"TirePump", 8,
			"Toolbox_Mechanic", 2,
			"ToolRoll_Leather", 4,
			"ViseGrips", 4,
			"WeldingMask", 1,
			"WeldingRods", 8,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolFactoryBarStock = {
		rolls = 4,
		items = {
			"SteelBar", 50,
			"SteelBar", 20,
			"SteelBar", 20,
			"SteelBar", 10,
			"SteelBar", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolFactoryHandles = {
		rolls = 4,
		items = {
			"Handle", 20,
			"Handle", 20,
			"Handle", 10,
			"Handle", 10,
			"LongHandle", 10,
			"SmallHandle", 20,
			"SmallHandle", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolFactoryIngots = {
		rolls = 4,
		items = {
			"SteelIngot", 50,
			"SteelIngot", 20,
			"SteelIngot", 20,
			"SteelIngot", 10,
			"SteelIngot", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolFactorySawBlades = {
		rolls = 4,
		items = {
			"HacksawBlade", 20,
			"HacksawBlade", 20,
			"HacksawBlade", 10,
			"HacksawBlade", 10,
			"SmallSawblade", 20,
			"SmallSawblade", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolFactoryTools = {
		rolls = 4,
		items = {
			"Awl", 4,
			"BallPeenHammer", 8,
			"Calipers", 8,
			"CarpentryChisel", 4,
			"ElbowPad_Left_Workman", 1,
			"File", 8,
			"Epoxy", 2,
			"Glasses_SafetyGoggles", 4,
			"HandDrill", 4,
			"Handle", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"Hat_HardHat", 2,
			"Kneepad_Left_Workman", 4,
			"LongHandle", 2,
			"MarkerBlack", 10,
			"MeasuringTape", 10,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"Pliers", 8,
			"RespiratorFilters", 2,
			"Saw", 8,
			"Screwdriver", 10,
			"Screws", 10,
			"ScrewsBox", 4,
			"ScrewsCarton", 0.1,
			"SheetMetalSnips", 4,
			"SmallFileSet", 8,
			"SmallHandle", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"SteelBar", 4,
			"SteelBarHalf", 6,
			"SteelPiece", 10,
			"SteelBarQuarter", 8,
			"SteelIngot", 2,
			"SteelBlock", 4,
			"SteelChunk", 8,
			"ViseGrips", 4,
			"WeldingMask", 4,
			"Whetstone", 10,
			"Woodglue", 8,
			"Tongs", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"AluminumFragments", 2,
				"BrassScrap", 2,
				"IronScrap", 2,
				"Splinters", 4,
				"SteelScrap", 2,
				"UnusableMetal", 2,
				"UnusableWood", 2,
			}
		}
	},

	ToolStoreAccessories = {
		isShop = true,
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 4,
			"KeyRing_EagleFlag", 4,
			"KeyRing_PineTree", 4,
			"KeyRing_PrayingHands", 4,
			-- Protective Gear
			"Glasses_SafetyGoggles", 20,
			"Gloves_LeatherGloves", 4,
			"Hat_BuildersRespirator", 8,
			"Hat_DustMask", 20,
			"Hat_EarMuff_Protectors", 10,
			"Hat_HardHat", 8,
			"Hat_HardHat_Miner", 2,
			"RespiratorFilters", 8,
			"WeldingMask", 8,
			-- Vests
			"Vest_Foreman", 8,
			"Vest_HighViz", 20,
			"Vest_HighViz", 10,
			-- Bags/Containers
			"Bag_Satchel", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"CompassGeometry", 10,
				"MarkerBlack", 20,
				"MarkerBlack", 10,
				"Pencil", 10,
				"MeasuringTape", 10,
			}
		}
	},

	ToolStoreBooks = {
		isShop = true,
		rolls = 4,
		items = {
			-- Skill Books
			"BookBlacksmith1", 10,
			"BookBlacksmith2", 8,
			"BookBlacksmith3", 6,
			"BookBlacksmith4", 4,
			"BookBlacksmith5", 2,
			"BookCarpentry1", 10,
			"BookCarpentry2", 8,
			"BookCarpentry3", 6,
			"BookCarpentry4", 4,
			"BookCarpentry5", 2,
			"BookElectrician1", 10,
			"BookElectrician2", 8,
			"BookElectrician3", 6,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"BookGlassmaking1", 10,
			"BookGlassmaking2", 8,
			"BookGlassmaking3", 6,
			"BookGlassmaking4", 4,
			"BookGlassmaking5", 2,
			"BookMaintenance1", 10,
			"BookMaintenance2", 8,
			"BookMaintenance3", 6,
			"BookMaintenance4", 4,
			"BookMaintenance5", 2,
			"BookMechanic1", 10,
			"BookMechanic2", 8,
			"BookMechanic3", 6,
			"BookMechanic4", 4,
			"BookMechanic5", 2,
			"BookMetalWelding1", 10,
			"BookMetalWelding2", 8,
			"BookMetalWelding3", 6,
			"BookMetalWelding4", 4,
			"BookMetalWelding5", 2,
			-- Magazines
			"ElectronicsMag1", 2,
			"ElectronicsMag2", 2,
			"ElectronicsMag3", 2,
			"ElectronicsMag4", 2,
			"ElectronicsMag5", 2,
			"EngineerMagazine1", 2,
			"EngineerMagazine2", 2,
			"GlassmakingMag1", 2,
			"GlassmakingMag2", 2,
			"GlassmakingMag3", 2,
			"MechanicMag1", 2,
			"MechanicMag2", 2,
			"MechanicMag3", 2,
			"MetalworkMag1", 2,
			"MetalworkMag2", 2,
			"MetalworkMag3", 2,
			"MetalworkMag4", 2,
			"SmithingMag1", 1,
			"SmithingMag2", 1,
			"SmithingMag3", 1,
			"SmithingMag4", 1,
			"SmithingMag5", 1,
			"SmithingMag6", 1,
			"SmithingMag7", 1,
			"SmithingMag8", 1,
			"SmithingMag9", 1,
			"SmithingMag10", 1,
			"SmithingMag11", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreCarpentry = {
		isShop = true,
		rolls = 4,
		items = {
			"Axe", 0.05,
			"CarpentryChisel", 8,
			"CircularSawblade", 8,
			"ClubHammer", 4,
			"Doorknob", 2,
			"DuctTape", 8,
			"ElbowPad_Left_Workman", 2,
			"Epoxy", 2,
			"GardenSaw", 10,
			"Glasses_SafetyGoggles", 8,
			"Hammer", 8,
			"Hammer", 8,
			"HandAxe", 4,
			"HandDrill", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Hat_HardHat", 4,
			"Hinge", 4,
			"Kneepad_Left_Workman", 8,
			"Latch", 1,
			"MeasuringTape", 10,
			"NailsBox", 20,
			"NailsBox", 10,
			"NailsCarton", 1,
			"Pliers", 8,
			"RespiratorFilters", 2,
			"Saw", 8,
			"Screwdriver", 10,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.5,
			"ViseGrips", 4,
			"WoodAxe", 0.025,
			"WoodenMallet", 4,
			"Woodglue", 4,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreFarming = {
		isShop = true,
		rolls = 4,
		items = {
			"AnimalFeedBag", 10,
			"Base.BarleyBagSeed", 8,
			"Base.BasilBagSeed", 1,
			"Base.BellPepperBagSeed", 2,
			"Base.BroccoliBagSeed2", 2,
			"Base.CabbageBagSeed2", 2,
			"Base.CarrotBagSeed2", 2,
			"Base.CauliflowerBagSeed", 2,
			"Base.ChamomileBagSeed", 1,
			"Base.ChivesBagSeed", 1,
			"Base.CilantroBagSeed", 1,
			"Base.CornBagSeed", 8,
			"Base.CucumberBagSeed", 2,
			"Base.FlaxBagSeed", 8,
			"Base.GarlicBagSeed", 2,
			"Base.GreenpeasBagSeed", 2,
			"Base.HabaneroBagSeed", 1,
			"Base.HopsBagSeed", 8,
			"Base.JalapenoBagSeed", 2,
			"Base.KaleBagSeed", 2,
			"Base.LeekBagSeed", 2,
			"Base.LemonGrassBagSeed", 4,
			"Base.LettuceBagSeed", 2,
			"Base.MarigoldBagSeed", 4,
			"Base.MintBagSeed", 4,
			"Base.OnionBagSeed", 2,
			"Base.OreganoBagSeed", 4,
			"Base.ParsleyBagSeed", 4,
			"Base.PotatoBagSeed2", 2,
			"Base.PumpkinBagSeed", 2,
			"Base.RedRadishBagSeed2", 2,
			"Base.RosemaryBagSeed", 1,
			"Base.RyeBagSeed", 8,
			"Base.SageBagSeed", 1,
			"Base.SpinachBagSeed", 2,
			"Base.StrewberrieBagSeed2", 2,
			"Base.SugarBeetBagSeed", 8,
			"Base.SunflowerBagSeed", 2,
			"Base.SweetPotatoBagSeed", 2,
			"Base.ThymeBagSeed", 1,
			"Base.TobaccoBagSeed", 8,
			"Base.TomatoBagSeed2", 2,
			"Base.TurnipBagSeed", 2,
			"Base.WatermelonBagSeed", 2,
			"Base.WheatBagSeed", 8,
			"Base.ZucchiniBagSeed", 2,
			"Bucket", 2,
			"BurlapPiece", 8,
			"CarpentryChisel", 2,
			"CompostBag", 1,
			"ElbowPad_Left_Workman", 2,
			"Fertilizer", 2,
			"Fleshing_Tool", 10,
			"GardenFork", 0.5,
			"GardenHoe", 2,
			"GardeningSprayEmpty", 6,
			"GardenSaw", 10,
			"HandAxe", 4,
			"HandFork", 2,
			"HandScythe", 2,
			"HandShovel", 10,
			"Hat_BuildersRespirator", 2,
			"Kneepad_Left_Workman", 8,
			"LongHandle", 2,
			"KnapsackSprayer", 4,
			"LeafRake", 10,
			"Machete", 0.01,
			"Mov_SaltLick", 4,
			"Padlock", 3,
			"PickAxe", 0.5,
			"Rake", 10,
			"RakeHead", 4,
			"RatPoison", 1,
			"RespiratorFilters", 2,
			"Scythe", 10,
			"SeedBag", 10,
			"SheepElectricShears", 2,
			"SheepShears", 2,
			"SlugRepellent", 10,
			"WateredCan", 6,
			"Whetstone", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreFootwear = {
		isShop = true,
		rolls = 4,
		items = {
			"Shoes_WorkBoots", 20,
			"Shoes_WorkBoots", 20,
			"Shoes_WorkBoots", 10,
			"Shoes_WorkBoots", 10,
			"Shoes_Wellies", 20,
			"Shoes_Wellies", 10,
			"Socks_Heavy", 10,
			"Socks_Heavy", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreHandles = {
		isShop = true,
		rolls = 6,
		items = {
			"Handle", 50,
			"Handle", 20,
			"LongHandle", 20,
			"LongHandle", 10,
			"LongStick", 20,
			"LongStick", 10,
			"SmallHandle", 50,
			"SmallHandle", 20,
			"WoodenStick2", 20,
			"WoodenStick2", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreKeymaking = {
		isShop = true,
		rolls = 4,
		items = {
			-- Blank Keys
			"Key_Blank", 50,
			"Key_Blank", 20,
			"Key_Blank", 20,
			"Key_Blank", 10,
			-- Keyrings
			"KeyRing", 20,
			"KeyRing", 10,
			"KeyRing_Bass", 4,
			"KeyRing_EagleFlag", 4,
			"KeyRing_PrayingHands", 4,
			"KeyRing_PineTree", 4,
			"KeyRing_EightBall", 4,
			"KeyRing_SecurityPass", 8,
			-- Tools
			"SmallFileSet", 10,
			-- Literature
			"KeyMag1", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreMetalwork = {
		isShop = true,
		rolls = 4,
		items = {
			"Awl", 4,
			"BallPeenHammer", 6,
			"BenchAnvil", 1,
			"BlowerFan", 1,
			"BlowTorch", 8,
			"BoltCutters", 8,
			"Calipers", 8,
			"CeramicCrucible", 4,
			"DrawPlate", 8,
			"ElbowPad_Left_Workman", 2,
			"Epoxy", 2,
			"FiberglassTape", 2,
			"File", 8,
			"Glasses_SafetyGoggles", 8,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 10,
			"Kneepad_Left_Workman", 8,
			"MetalBar", 10,
			"MetalPipe", 10,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"Mov_ElectricBlowerForge", 1,
			"NutsBolts", 8,
			"Oxygen_Tank", 10,
			"Propane_Refill", 10,
			"Pliers", 8,
			"RespiratorFilters", 2,
			"Screwdriver", 8,
			"SheetMetal", 10,
			"SheetMetalSnips", 4,
			"SmallFileSet", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"SmallSheetMetal", 10,
			"SmithingHammer", 2,
			"SteelWool", 10,
			"Tongs", 10,
			"ViseGrips", 4,
			"WeldingMask", 4,
			"WeldingRods", 10,
			"Wire", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreMisc = {
		isShop = true,
		rolls = 4,
		items = {
			"BarbedWire", 2,
			"BatteryBox", 10,
			"CircularSawblade", 8,
			"CombinationPadlock", 10,
			"Cooler", 1,
			"DuctTape", 8,
			"ElectricWire", 10,
			"EmptySandbag", 2,
			"GraphPaper", 10,
			"Handiknife", 2,
			"HandTorch", 8,
			"KeyMag1", 1,
			"KnifePocket", 2,
			"MeasuringTape", 20,
			"MeasuringTape", 10,
			"Mov_LightConstruction", 4,
			"Multitool", 0.1,
			"NailsBox", 20,
			"NailsBox", 10,
			"NailsCarton", 1,
			"NutsBolts", 8,
			"Padlock", 4,
			"Paintbrush", 8,
			"PlasterPowder", 10,
			"PlasterTrowel", 8,
			"RespiratorFilters", 10,
			"Rope", 20,
			"Rope", 10,
			"RopeStack", 0.1,
			"RubberHose", 10,
			"ScrewsBox", 8,
			"ScrewsCarton", 0.1,
			"SteelWool", 10,
			"Torch", 4,
			"TrapMouse", 4,
			"Twine", 10,
			"Wire", 10,
			"WallpaperPastePowder", 10,
			"Whetstone", 10,
			"Woodglue", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreOutfit = {
		isShop = true,
		rolls = 4,
		items = {
			"Boilersuit", 4,
			"Boilersuit", 4,
			"Boilersuit_BlueRed", 2,
			"ElbowPad_Left_Workman", 2,
			"Dungarees", 4,
			"Kneepad_Left_Workman", 8,
			"Shirt_Denim", 4,
			"Shirt_Lumberjack", 8,
			"Shirt_Lumberjack_TINT", 8,
			"Shirt_Workman", 10,
			"Shirt_Workman", 10,
			"Trousers_Denim", 8,
			"Trousers_Denim", 8,
			"Trousers_JeanBaggy", 8,
			"Trousers_JeanBaggy", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStorePaint = {
		isShop = true,
		rolls = 4,
		items = {
			-- Paint
			"PaintBlack", 10,
			"PaintBlue", 10,
			"PaintBrown", 10,
			"PaintGreen", 10,
			"PaintGrey", 10,
			"PaintLightBlue", 10,
			"PaintLightBrown", 10,
			"PaintRed", 10,
			"PaintWhite", 10,
			"PaintYellow", 10,
			-- Paint: Bright Colors
			"PaintCyan", 20,
			"PaintOrange", 20,
			"PaintPink", 20,
			"PaintPurple", 20,
			"PaintTurquoise", 20,
			-- Accessories
			"Bucket", 8,
			"Paintbrush", 20,
			"Paintbrush", 10,
			-- Outfit
			"Boilersuit", 8,
			"Boilersuit_BlueRed", 4,
			"ElbowPad_Left_Workman", 4,
			"Glasses_SafetyGoggles", 8,
			"Hat_BuildersRespirator", 8,
			"Kneepad_Left_Workman", 8,
			"RespiratorFilters", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	ToolStoreTools = {
		isShop = true,
		rolls = 4,
		items = {
			"Axe", 0.05,
			"BallPeenHammer", 6,
			"BlowerFan", 1,
			"Calipers", 1,
			"CarpentryChisel", 4,
			"CircularSawblade", 8,
			"ClubHammer", 4,
			"Crowbar", 4,
			"File", 1,
			"Funnel", 10,
			"GardenFork", 1,
			"GardenHoe", 2,
			"GardenSaw", 10,
			"Hammer", 8,
			"HandAxe", 4,
			"HandDrill", 4,
			"HandFork", 2,
			"Handiknife", 8,
			"HandScythe", 2,
			"HandShovel", 10,
			"Hat_BuildersRespirator", 2,
			"KnifeButterfly", 8,
			"LeafRake", 10,
			"LugWrench", 4,
			"Machete", 0.01,
			"MasonsChisel", 10,
			"MasonsTrowel", 10,
			"MetalworkingChisel", 1,
			"MetalworkingPliers", 0.1,
			"MetalworkingPunch", 1,
			"Multitool", 0.1,
			"PickAxe", 0.5,
			"PipeWrench", 6,
			"Pliers", 8,
			"Rake", 10,
			"RakeHead", 4,
			"Ratchet", 10,
			"Saw", 8,
			"Screwdriver", 10,
			"Scythe", 1,
			"SheetMetalSnips", 4,
			"Shovel", 4,
			"Shovel2", 4,
			"Sledgehammer", 0.01,
			"Sledgehammer2", 0.01,
			"SmallFileSet", 1,
			"SmallPunchSet", 1,
			"SmallSaw", 1,
			"SnowShovel", 2,
			"TireIron", 4,
			"TirePump", 8,
			"Tongs", 10,
			"ViseGrips", 4,
			"Whetstone", 10,
			"WoodAxe", 0.025,
			"WoodenMallet", 4,
			"Wrench", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Box of old trapping/hunting supplies. Trapping-oriented but still has firearms.
	Trapper = {
		rolls = 4,
		items = {
			-- Traps
			"TrapBox", 10,
			"TrapCage", 10,
			"TrapCrate", 10,
			"TrapMouse", 10,
			"TrapSnare", 10,
			"TrapStick", 10,
			-- Tools
			"HandAxe", 8,
			"Handiknife", 1,
			"HuntingKnife", 10,
			"KnifeButterfly", 8,
			"KnifeFillet", 10,
			"KnifePocket", 1,
			"LargeKnife", 4,
			"Multitool", 0.1,
			"SmallKnife", 8,
			-- Guns/Ammo
			"DoubleBarrelShotgun", 2,
			"HuntingRifle", 1,
			"Shotgun", 2,
			"VarmintRifle", 8,
			-- Gun Cases
			"Bag_RifleCaseCloth", 0.5,
			"Bag_RifleCaseCloth2", 0.1,
			"Bag_ShotgunCaseCloth", 0.1,
			"Bag_ShotgunCaseCloth2", 0.1,
			"RifleCase1", 0.5,
			"RifleCase2", 0.1,
			"ShotgunCase1", 0.1,
			"ShotgunCase2", 0.1,
			-- Outdoors/Survival
			"Bag_LeatherWaterBag", 1,
			"Canteen", 4,
			"CanteenCowboy", 1,
			"CompassDirectional", 8,
			"EntrenchingTool", 1,
			"FlashLight_AngleHead", 4,
			"HandTorch", 8,
			"InsectRepellent", 10,
			"Lantern_Propane", 1,
			"MagnesiumFirestarter", 8,
			"Matchbox", 2,
			"Matches", 8,
			"P38", 1,
			"ToiletPaper", 2,
			"WaterPurificationTablets", 1,
			"Whetstone", 10,
			"Whistle", 2,
			-- Clothing
			"Dungarees_HuntingCamo", 4,
			"Gloves_HuntingCamo", 4,
			"Hat_BaseballCap_HuntingCamo", 10,
			"Hat_BonnieHat", 10,
			"Hat_BonnieHat_CamoGreen", 8,
			"Hoodie_HuntingCamo_DOWN", 10,
			"Jacket_HuntingCamo", 10,
			"Jacket_Padded_HuntingCamo", 8,
			"LongJohns", 4,
			"LongJohns_Bottoms", 4,
			"PonchoGreenDOWN", 6,
			"ShemaghScarf_Green", 1,
			"Shirt_CamoGreen", 8,
			"Shirt_Lumberjack", 4,
			"Shirt_Lumberjack_TINT", 4,
			"Shoes_HikingBoots", 4,
			"Shoes_Wellies", 1,
			"Shorts_CamoGreenLong", 8,
			"Trousers_HuntingCamo", 10,
			"Trousers_Padded_HuntingCamo", 4,
			"Tshirt_CamoGreen", 10,
			"Tshirt_HuntingCamo", 10,
			"Tshirt_LongSleeve_HuntingCamo", 6,
			-- Literature
			"ArmorMag6", 1,
			"BookAiming1", 1,
			"BookAiming2", 0.8,
			"BookAiming3", 0.6,
			"BookAiming4", 0.4,
			"BookAiming5", 0.2,
			"BookTracking1", 10,
			"BookTracking2", 8,
			"BookTracking3", 6,
			"BookTracking4", 4,
			"BookTracking5", 2,
			"BookTrapping1", 10,
			"BookTrapping2", 8,
			"BookTrapping3", 6,
			"BookTrapping4", 4,
			"BookTrapping5", 2,
			"BookReloading1", 1,
			"BookReloading2", 0.8,
			"BookReloading3", 0.6,
			"BookReloading4", 0.4,
			"BookReloading5", 0.2,
			"Magazine_Firearm", 8,
			"Magazine_Outdoors", 8,
			"Paperback_Nature", 8,
			"SurvivalSchematic", 4,
			-- Special
			"DappleDeerHide", 1,
			"DeerHide", 1,
			"Mov_HuntingTrophy", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- University Office Desks: Work In Progress Area Ahead!
	UniversityDesk_Art = {
		rolls = 4,
		items = {
			-- Literature
			"Book_Art", 50,
			"Book_Art", 20,
			"BookPottery3", 50,
			"BookPottery4", 20,
			"BookPottery5", 10,
			"BookPotterySet", 4,
			-- Clothing
			"Glasses_Round_HoloSkulls", 4,
			"Glasses_Round_Shades", 8,
			"Hat_BandanaTINT", 8,
			"Hat_Beret", 8,
			"Tshirt_TieDye", 8,
			-- Tools/Misc.
			"PenFancy", 10,
			"ClayTool", 10,
			-- Materials
			"Claybag", 20,
			"BoneBead_Large", 8,
			-- Special
			"SmokingPipe", 8,
			"CigaretteRollingPapers", 8,
			"HempBagSeed", 10,
			"HempMag1", 8,
		},
		junk = ClutterTables.DeskJunk,
	},

	UniversityDesk_Business = {
		rolls = 4,
		items = {
			-- Literature
			"Book_Business", 50,
			"Book_Business", 20,
			"Magazine_Business", 50,
			"Magazine_Business", 50,
			"Magazine_Business", 20,
			"Magazine_Business", 20,
			"Newspaper_New", 20,
			"Newspaper_New", 10,
			-- Clothing
			"Tie_Full", 8,
			"Shirt_FormalWhite", 4,
			-- Tools/Misc.
			"PenFancy", 20,
			"Calculator", 20,
			"Pager", 8,
			-- Materials
			"Clipboard", 10,
			"GraphPaper", 50,
			"GraphPaper", 20,
			-- Special
			"Briefcase", 8,
			"Flask", 8,
			"Pills", 8,
			"PillsVitamins", 8,
			"WristWatch_Left_Expensive", 4,
			"Humidor", 2,
		},
		junk = ClutterTables.DeskJunk,
	},

	UniversityDesk_Cinema = {
		rolls = 4,
		items = {
			-- Literature
			"Book_Cinema", 50,
			"Book_Cinema", 20,
			"Magazine_Cinema", 50,
			"Magazine_Cinema", 50,
			"Magazine_Cinema", 20,
			"Magazine_Cinema", 20,
			"TVMagazine", 20,
			"TVMagazine", 10,
			-- Clothing
			"Glasses_3dGlasses", 8,
			"Glasses_JackieO", 8,
			"Hat_Beret", 8,
			"Scarf_StripeBlackWhite", 8,
			-- Tools/Misc.
			"VHS_Retail", 50,
			"VHS_Retail", 50,
			"VHS_Retail", 20,
			"VHS_Retail", 20,
			"VHS_Retail", 10,
			-- Moveables
			"Mov_Projector", 4,
			-- Special
			"CigarettePack", 8,
			"WineScrewtop", 8,
		},
		junk = ClutterTables.DeskJunk,
	},

	UniversityDesk_Computer = {
		rolls = 4,
		items = {
			-- Literature
			"Book_Computer", 50,
			"Book_Computer", 20,
			"Magazine_Tech", 50,
			"Magazine_Tech", 50,
			"Magazine_Tech", 20,
			"Magazine_Tech", 20,
			-- Clothing
			"Glasses_Normal_HornRimmed", 8,
			"Tie_BowTieFull", 8,
			-- Tools/Misc.
			"Pager", 8,
			-- Materials
			"GraphPaper", 8,
			-- Special
			"ComicBook", 8,
			"DiceBag", 8,
			"RPGmanual", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Electrical = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Engineering = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_English = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Fashion = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Glassmaking = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_History = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Legal = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Math = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Medical = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Medieval = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Music = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Nature = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Occult = {
		rolls = 4,
		items = {
			-- Literature
			"BookFancy_Bible", 8,
			"BookFancy_Occult", 10,
			"Book_Occult", 50,
			"Book_Occult", 20,
			"Diary2", 20,
			-- Tools/Misc.
			"MortarPestle", 10,
			-- Special
			"StoneKnifeLong", 8,
			"Goblet_Gold", 8,
			"Hat_HockeyMask_Gold", 8,
			"Necklace_SilverCrucifix", 20,
			"Ring_Left_RingFinger_Gold", 8,
			"Ruby", 8,
			"WineAged", 8,
		},
		junk = ClutterTables.DeskJunk,
	},

	UniversityDesk_Philosophy = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Politics = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Religion = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Science = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityDesk_Therapy = {
		rolls = 4,
		items = {
			-- Literature
			"Paperback_SelfHelp", 50,
			"Paperback_SelfHelp", 50,
			"Paperback_SelfHelp", 20,
			"Paperback_SelfHelp", 20,
			"Paperback_SelfHelp", 10,
			-- Clothing
			"Tshirt_TieDye", 8,
			"LongCoat_Bathrobe", 8,
			-- Tools/Misc.
			"CDplayer", 8,
			"Hat_EarMuffs", 8,
			"Headphones", 8,
			"Pillow", 8,
			"ToyBear", 8,
			-- Materials
			"Sheet", 8,
			-- Special
			"Pillow_Happyface", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Filing cabinets for the desks.
	UniversityFilingCabinet_Art = {
		rolls = 4,
		items = {
			-- Literature
			"Book_Art", 50,
			"Book_Art", 20,
			"BookPottery3", 50,
			"BookPottery4", 20,
			"BookPottery5", 10,
			"BookPotterySet", 4,
			-- Tools
			"ClayTool", 10,
			-- Materials
			"Claybag", 20,
			"BoneBead_Large", 8,
			-- Special
			"SmokingPipe", 8,
			"CigaretteRollingPapers", 8,
			"HempBagSeed", 10,
			"HempMag1", 8,
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},
	UniversityFilingCabinet_Business = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Cinema = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Computer = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Engineering = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_English = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Fashion = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Glassmaking = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_History = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Legal = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Math = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Medical = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Medieval = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Music = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Nature = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Occult = {
		rolls = 4,
		items = {
			-- Tools
			"Calipers", 10,
			-- Skulls
			"Calf_Skull", 4,
			"DeerFawn_Skull", 2,
			"Hominid_Skull", 20,
			"Hominid_Skull_Partial", 10,
			"Lamb_Skull", 4,
			"Piglet_Skull", 4,
			-- Misc.
			"Specimen_Brain", 20,
			"Specimen_FetalCalf", 4,
			"Specimen_FetalLamb", 4,
			"Specimen_FetalPiglet", 4,
			"Specimen_MonkeyHead", 4,
			"Specimen_Tapeworm", 4,
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Philosophy = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Politics = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Religion = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Science = {
		rolls = 4,
		items = {
			-- IN PROGRESS
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},

	UniversityFilingCabinet_Therapy = {
		rolls = 4,
		items = {
			-- Literature
			"Paperback_SelfHelp", 50,
			"Paperback_SelfHelp", 50,
			"Paperback_SelfHelp", 20,
			"Paperback_SelfHelp", 20,
			"Paperback_SelfHelp", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"Paperwork", 50,
				"Paperwork", 50,
				"Paperwork", 20,
				"Paperwork", 20,
			}
		}
	},
	-- LEAVING WIP ZONE

	-- Dorm room fridge.
	UniversityFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"BeerBottle", 4,
			"BeerCan", 4,
			"Burger", 8,
			"Burrito", 8,
			"ChickenFried", 4,
			"Corndog", 4,
			"Flask", 0.1,
			"FriedOnionRings", 8,
			"Fries", 8,
			"Gravy", 4,
			"Hotdog", 4,
			"Hotsauce", 1,
			"Ketchup", 1,
			"MayonnaiseFull", 1,
			"MuffinFruit", 4,
			"MuffinGeneric", 4,
			"Mustard", 1,
			"Pop", 4,
			"Pop2", 4,
			"Pop3", 4,
			"PopBottle", 4,
			"PopBottleRare", 0.1,
			"Taco", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityLibraryArt = {
		rolls = 4,
		items = {
			"BookPottery3", 8,
			"BookPottery4", 4,
			"BookPottery5", 2,
			"Book_Art", 20,
			"Book_Art", 20,
			"Book_Art", 10,
			"Book_Art", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryBiography = {
		rolls = 4,
		items = {
			"Book_Biography", 50,
			"Book_Biography", 20,
			"Book_Biography", 20,
			"Book_Biography", 10,
			"Book_Biography", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryBooks = {
		rolls = 4,
		items = {
			"BookBlacksmith3", 8,
			"BookBlacksmith4", 4,
			"BookBlacksmith5", 2,
			"BookButchering3", 8,
			"BookButchering4", 4,
			"BookButchering5", 2,
			"BookCarpentry3", 8,
			"BookCarpentry4", 4,
			"BookCarpentry5", 2,
			"BookCarving3", 8,
			"BookCarving4", 4,
			"BookCarving5", 2,
			"BookCooking3", 8,
			"BookCooking4", 4,
			"BookCooking5", 2,
			"BookElectrician3", 8,
			"BookElectrician4", 4,
			"BookElectrician5", 2,
			"BookFarming3", 8,
			"BookFarming4", 4,
			"BookFarming5", 2,
			"BookFirstAid3", 8,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			"BookFishing3", 8,
			"BookFishing4", 4,
			"BookFishing5", 2,
			"BookForaging3", 8,
			"BookForaging4", 4,
			"BookForaging5", 2,
			"BookGlassmaking3", 8,
			"BookGlassmaking4", 4,
			"BookGlassmaking5", 2,
			"BookHusbandry3", 8,
			"BookHusbandry4", 4,
			"BookHusbandry5", 2,
			"BookMaintenance3", 8,
			"BookMaintenance4", 4,
			"BookMaintenance5", 2,
			"BookMasonry3", 8,
			"BookMasonry4", 4,
			"BookMasonry5", 2,
			"BookMechanic3", 8,
			"BookMechanic4", 4,
			"BookMechanic5", 2,
			"BookMetalWelding3", 8,
			"BookMetalWelding4", 4,
			"BookMetalWelding5", 2,
			"BookPottery3", 8,
			"BookPottery4", 4,
			"BookPottery5", 2,
			"BookTailoring3", 8,
			"BookTailoring4", 4,
			"BookTailoring5", 2,
			"BookTracking3", 8,
			"BookTracking4", 4,
			"BookTracking5", 2,
			"BookTrapping3", 8,
			"BookTrapping4", 4,
			"BookTrapping5", 2,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryBusiness = {
		rolls = 4,
		items = {
			"Book_Business", 50,
			"Book_Business", 20,
			"Book_Business", 20,
			"Book_Business", 10,
			"Book_Business", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryCinema = {
		rolls = 4,
		items = {
			"Book_Cinema", 50,
			"Book_Cinema", 20,
			"Book_Cinema", 20,
			"Book_Cinema", 10,
			"Book_Cinema", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryComputer = {
		rolls = 4,
		items = {
			"Book_Computer", 50,
			"Book_Computer", 20,
			"Book_Computer", 20,
			"Book_Computer", 10,
			"Book_Computer", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryGeneralReference = {
		rolls = 4,
		items = {
			"Book_GeneralReference", 50,
			"Book_GeneralReference", 20,
			"Book_GeneralReference", 20,
			"Book_GeneralReference", 10,
			"Book_GeneralReference", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryHistory = {
		rolls = 4,
		items = {
			"Book_History", 50,
			"Book_History", 20,
			"Book_History", 20,
			"Book_History", 10,
			"BookFancy_History", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryLegal = {
		rolls = 4,
		items = {
			"Book_Legal", 50,
			"Book_Legal", 20,
			"Book_Legal", 20,
			"Book_Legal", 10,
			"BookFancy_Legal", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryMagazines = {
		rolls = 4,
		items = {
			"ArmorMag4", 0.01,
			"ArmorMag4", 0.01,
			"CookingMag1", 1,
			"CookingMag2", 1,
			"CookingMag3", 1,
			"CookingMag4", 1,
			"CookingMag5", 1,
			"CookingMag6", 1,
			"ElectronicsMag1", 1,
			"ElectronicsMag2", 1,
			"ElectronicsMag3", 1,
			"ElectronicsMag4", 1,
			"ElectronicsMag5", 1,
			"EngineerMagazine1", 1,
			"EngineerMagazine2", 1,
			"FarmingMag1", 1,
			"FarmingMag2", 1,
			"FarmingMag3", 1,
			"FarmingMag4", 1,
			"FarmingMag5", 1,
			"FarmingMag6", 1,
			"FarmingMag7", 1,
			"FarmingMag8", 1,
			"FishingMag1", 1,
			"FishingMag2", 1,
			"GlassmakingMag1", 1,
			"GlassmakingMag2", 1,
			"GlassmakingMag3", 1,
			"HerbalistMag", 1,
			"HuntingMag1", 1,
			"HuntingMag2", 1,
			"HuntingMag3", 1,
			"KnittingMag1", 1,
			"KnittingMag2", 1,
			"MechanicMag1", 1,
			"MechanicMag2", 1,
			"MechanicMag3", 1,
			"MetalworkMag1", 1,
			"MetalworkMag2", 1,
			"MetalworkMag3", 1,
			"MetalworkMag4", 1,
			"PrimitiveToolMag1", 1,
			"PrimitiveToolMag2", 1,
			"PrimitiveToolMag3", 1,
			"SmithingMag2", 1,
			"SmithingMag3", 1,
			"SmithingMag4", 1,
			"SmithingMag5", 1,
			"SmithingMag6", 1,
			"SmithingMag7", 1,
			"SmithingMag8", 1,
			"SmithingMag9", 1,
			"SmithingMag10", 1,
			"SmithingMag11", 1,
			"WeaponMag6", 1,
			"WeaponMag7", 1,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryMedical = {
		isShop = true,
		rolls = 4,
		items = {
			"BookFirstAid3", 8,
			"BookFirstAid4", 4,
			"BookFirstAid5", 2,
			"Book_Medical", 20,
			"Book_Medical", 20,
			"Book_Medical", 10,
			"BookFancy_Medical", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryMilitaryHistory = {
		rolls = 4,
		items = {
			"BookAiming3", 1,
			"BookAiming3", 2,
			"BookAiming3", 4,
			"BookReloading3", 1,
			"BookReloading3", 2,
			"BookReloading3", 4,
			"Book_MilitaryHistory", 20,
			"Book_MilitaryHistory", 20,
			"Book_MilitaryHistory", 10,
			"BookFancy_MilitaryHistory", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryMusic = {
		rolls = 4,
		items = {
			"Book_Music", 50,
			"Book_Music", 20,
			"Book_Music", 20,
			"Book_Music", 10,
			"Book_Music", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryPhilosophy = {
		rolls = 4,
		items = {
			"Book_Philosophy", 50,
			"Book_Philosophy", 20,
			"Book_Philosophy", 20,
			"Book_Philosophy", 10,
			"BookFancy_Philosophy", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryPolitics = {
		rolls = 4,
		items = {
			"Book_Politics", 50,
			"Book_Politics", 20,
			"Book_Politics", 20,
			"Book_Politics", 10,
			"BookFancy_Politics", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibraryScience = {
		rolls = 4,
		items = {
			"Book_Science", 50,
			"Book_Science", 20,
			"Book_Science", 20,
			"Book_Science", 10,
			"Book_Science", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	UniversityLibrarySports = {
		rolls = 4,
		items = {
			"Book_Sports", 50,
			"Book_Sports", 20,
			"Book_Sports", 20,
			"Book_Sports", 10,
			"Book_Sports", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Dorm sidetable.
	UniversitySideTable = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.005,
			"KeyRing_Bug", 0.005,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.005,
			"KeyRing_Kitty", 0.005,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.005,
			"KeyRing_RubberDuck", 0.005,
			"KeyRing_Sexy", 0.001,
			-- TODO: Sort Me!
			"AlarmClock2", 10,
			"ArmorMag2", 0.01,
			"Bag_Satchel", 0.2,
			"Bag_Schoolbag", 2,
			"Bag_Schoolbag_Patches", 0.1,
			"Base.HempBagSeed", 0.01,
			"BeerBottle", 0.05,
			"BeerCan", 0.05,
			"BeerCanEmpty", 0.2,
			"BeerBottleEmpty", 0.2,
			"Belt2", 4,
			"BluePen", 2,
			"Book_SciFi", 0.1,
			"Book_GeneralNonFiction", 2,
			"Book_Fantasy", 0.1,
			"BookElectrician1", 0.05,
			"BookElectrician2", 0.01,
			"BookElectrician3", 0.005,
			"BookFirstAid1", 0.05,
			"BookFirstAid2", 0.01,
			"BookFirstAid3", 0.005,
			"Boxers_Hearts", 0.8,
			"Boxers_RedStripes", 0.8,
			"Boxers_White", 2,
			"Briefs_AnimalPrints", 0.8,
			"Briefs_SmallTrunks_Black", 0.1,
			"Briefs_SmallTrunks_Blue", 0.1,
			"Briefs_SmallTrunks_Red", 0.1,
			"Briefs_SmallTrunks_WhiteTINT", 0.1,
			"Briefs_White", 2,
			"Brochure", 1,
			"Calculator", 2,
			"CandyCaramels", 0.05,
			"CandyGummyfish", 0.05,
			"CandyNovapops", 0.05,
			"CDplayer", 1,
			"Chocolate", 0.1,
			"Chocolate_Butterchunkers", 0.05,
			"Chocolate_Candy", 0.1,
			"Chocolate_Crackle", 0.05,
			"Chocolate_Deux", 0.05,
			"Chocolate_GalacticDairy", 0.05,
			"Chocolate_RoysPBPucks", 0.05,
			"Chocolate_Smirkers", 0.05,
			"Chocolate_SnikSnak", 0.05,
			"ChocolateCoveredCoffeeBeans", 0.05,
			"CigarettePack", 1,
			"CigaretteRollingPapers", 0.1,
			"Cigarillo", 1,
			"Cologne", 0.2,
			"Comb", 1,
			"CordlessPhone", 4,
			"Crisps", 0.1,
			"Crisps2", 0.1,
			"Crisps3", 0.1,
			"Crisps4", 0.1,
			"Diary1", 1,
			"Diary2", 1,
			"Disc_Retail", 2,
			"Doodle", 1,
			"Earbuds", 1,
			"Flask", 0.05,
			"Flier", 2,
			"Football", 1,
			"FountainCup", 0.5,
			"GranolaBar", 0.2,
			"GreenPen", 1,
			"Gum", 0.5,
			"GummyBears", 0.05,
			"GummyWorms", 0.05,
			"HalloweenCandyBucket", 0.001,
			"Harmonica", 0.02,
			"Hat_BaseballCap", 0.1,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beret", 0.5,
			"Hat_BucketHat", 0.5,
			"Headphones", 1,
			"HempMag1", 0.05,
			"HoodieDOWN_WhiteTINT", 2,
			"HottieZ", 0.1,
			"Jumper_DiamondPatternTINT", 0.2,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"KnifePocket", 0.05,
			"LetterHandwritten", 1,
			"Lighter", 1,
			"LighterDisposable", 4,
			"LongCoat_Bathrobe", 0.1,
			"MagazineCrossword", 1,
			"MagazineWordsearch", 1,
			"Matches", 8,
			"Mirror", 1,
			"Note", 1,
			"Notebook", 4,
			"PaperNapkins2", 0.5,
			"Pen", 2,
			"Pencil", 4,
			"PenFancy", 0.1,
			"Photo", 4,
			"Photo_Secret", 0.5,
			"Pills", 0.5,
			"PillsSleepingTablets", 1,
			"PillsVitamins", 1,
			"PlasticCup", 8,
			"Pop2Empty", 1,
			"Pop3Empty", 1,
			"PopBottleEmpty", 0.1,
			"PopEmpty", 1,
			"RadioBlack", 0.5,
			"RadioRed", 0.2,
			"RedPen", 2,
			"SewingKit", 0.5,
			"SheetPaper2", 4,
			"Shirt_Baseball_KY", 0.2,
			"Shirt_Baseball_Rangers", 0.2,
			"Shirt_Baseball_Z", 0.2,
			"Shirt_Denim", 0.5,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 1,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shirt_Lumberjack", 0.5,
			"Shirt_Lumberjack_TINT", 0.5,
			"Shorts_LongDenim", 1,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortDenim", 1,
			"Shorts_ShortSport", 0.5,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Long_White", 2,
			"SunflowerSeeds", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"Tissue", 10,
			"TissueBox", 4,
			"TobaccoChewing", 0.1,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Shellsuit_Black", 0.05,
			"Trousers_Shellsuit_Blue", 0.05,
			"Trousers_Shellsuit_Green", 0.05,
			"Trousers_Shellsuit_Pink", 0.05,
			"Trousers_Shellsuit_Teal", 0.05,
			"Trousers_Shellsuit_TINT", 0.2,
			"Trousers_Sport", 0.2,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Trousers_WhiteTINT", 2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_Sport", 0.2,
			"Tshirt_SportDECAL", 0.2,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"TVMagazine", 8,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
			"WeaponMag1", 0.001,
			"WeaponMag7", 0.1,
			"WhiskeyEmpty", 0.1,
			"Whiskey", 0.05,
			"WristWatch_Left_ClassicBlack", 0.01,
			"WristWatch_Left_ClassicBrown", 0.01,
			"WristWatch_Left_ClassicGold", 0.01,
			"WristWatch_Left_DigitalBlack", 0.01,
			"WristWatch_Left_DigitalDress", 0.01,
			"WristWatch_Left_DigitalRed", 0.01,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},

	UniversityStorageAnthropology = {
		rolls = 4,
		items = {
			-- Tools
			"Awl_Bone", 8,
			"Awl_Stone", 4,
			"CeramicMortarandPestle", 4,
			"CrudeWoodenTongs", 4,
			"DullBoneKnife", 8,
			"FishingHook_Bone", 8,
			"KnappingTool", 8,
			"Needle_Bone", 8,
			"PrimitiveScythe", 1,
			"Saw_Flint", 4,
			"StoneChisel", 4,
			"StoneDrill", 4,
			-- Clothing
			"Codpiece_Leather", 1,
			"Hat_DeerHeadress", 1,
			"Hat_HockeyMask_Wood", 2,
			-- Jewelry
			"Earring_BoarTusk", 1,
			"NecklaceLong_SkullMammal", 1,
			"NecklaceLong_SkullMammal_Multi", 1,
			"NecklaceLong_SkullSmall", 1,
			"NecklaceLong_SkullSmall_Multi", 1,
			"NecklaceLong_Teeth", 1,
			"Necklace_BoarTusk", 1,
			"Necklace_BoarTusk_Multi", 1,
			"Necklace_SkullMammal", 1,
			"Necklace_SkullMammal_Multi", 1,
			"Necklace_SkullSmall", 1,
			"Necklace_SkullSmall_Multi", 1,
			-- Bones/Fossils
			"AnimalBone", 8,
			"Hominid_Skull", 1,
			"Hominid_Skull_Fragment", 4,
			"Hominid_Skull_Partial", 2,
			"JawboneBovide", 4,
			"PigTusk", 4,
			"SharpBoneFragment", 8,
			"SharpBone_Long", 4,
			-- Materials
			"BoneBead_Large", 8,
			"HatchetHead_Bone", 4,
			"HempScutched", 8,
			"LeatherStrips", 8,
			"SharpedStone", 8,
			"StoneAxeHead", 4,
			"StoneBlade", 8,
			"StoneBladeLong", 4,
			"TurkeyFeather", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	UniversityStorageScience = {
		rolls = 4,
		items = {
			-- Schoolbooks
			"Book_Science", 8,
			"Paperback_Science", 20,
			"Paperback_Science", 10,
			-- Tools
			"Scalpel", 8,
			"Scissors", 2,
			"ScissorsBlunt", 4,
			"ScissorsBluntMedical", 6,
			"Screwdriver", 6,
			"SutureNeedleHolder", 6,
			"Tweezers", 6,
			-- Equipment
			"Apron_White", 10,
			"BlowerFan", 0.5,
			"Extinguisher", 4,
			"Glasses_SafetyGoggles", 8,
			"Gloves_Dish", 8,
			"Hat_BuildersRespirator", 4,
			"Hat_SurgicalMask", 8,
			"JacketLong_Doctor", 2,
			"Loupe", 4,
			"MortarPestle", 4,
			"PropaneTank", 0.1,
			"RespiratorFilters", 2,
			"SCBA", 1,
			-- Materials
			"CopperScrap", 4,
			"CottonBallsBox", 2,
			"ElectronicsScrap", 10,
			"EmptyJar", 10,
			"JarLid", 10,
			"Oxygen_Tank", 1,
			"RubberHose", 10,
			"SteelWool", 10,
			"Twine", 10,
			-- Electronics
			"Battery", 8,
			"BatteryBox", 2,
			"FlashLight_AngleHead", 1,
			"HandTorch", 4,
			"LightBulb", 8,
			"LightBulbBox", 2,
			"PenLight", 8,
			"PowerBar", 4,
			"Torch", 1,
			-- Specimens
			"Specimen_Beetles", 8,
			"Specimen_Brain", 2,
			"Specimen_Butterflies", 8,
			"Specimen_Centipedes", 8,
			"Specimen_FetalCalf", 2,
			"Specimen_FetalLamb", 2,
			"Specimen_FetalPiglet", 2,
			"Specimen_Insects", 8,
			"Specimen_Minerals", 8,
			"Specimen_MonkeyHead", 2,
			"Specimen_Octopus", 2,
			"Specimen_Tapeworm", 2,
			-- Stationery/Office
			"PenLight", 8,
			"Calculator", 1,
			"Clipboard", 8,
			"CompassGeometry", 4,
			"GraphPaper", 10,
			"Notebook", 10,
			-- Misc.
			"FirstAidKit", 2,
			"Frog", 0.01,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Dorm wardrobe.
	UniversityWardrobe = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"KeyRing_Bass", 0.001,
			"KeyRing_BlueFox", 0.005,
			"KeyRing_Bug", 0.005,
			"KeyRing_EagleFlag", 0.001,
			"KeyRing_EightBall", 0.001,
			"KeyRing_Hotdog", 0.005,
			"KeyRing_Kitty", 0.005,
			"KeyRing_Panther", 0.001,
			"KeyRing_PineTree", 0.001,
			"KeyRing_PrayingHands", 0.001,
			"KeyRing_RainbowStar", 0.005,
			"KeyRing_RubberDuck", 0.005,
			"KeyRing_Sexy", 0.001,
			-- TODO: Sort Me!
			"AthleticCup", 0.1,
			"BadmintonRacket", 0.005,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_Satchel", 0.2,
			"Bag_Schoolbag", 2,
			"Bag_Schoolbag_Patches", 0.1,
			"Banjo", 0.005,
			"BarBell", 0.005,
			"Base.HempBagSeed", 0.01,
			"Baseball", 0.05,
			"BaseballBat", 0.05,
			"BaseballBat_Metal", 0.02,
			"Basketball", 0.05,
			"Belt2", 4,
			"Birdie", 0.05,
			"Book_SciFi", 0.1,
			"Book_GeneralNonFiction", 2,
			"Book_Fantasy", 0.1,
			"BookElectrician1", 0.05,
			"BookElectrician2", 0.01,
			"BookElectrician3", 0.005,
			"BookFirstAid1", 0.05,
			"BookFirstAid2", 0.01,
			"BookFirstAid3", 0.005,
			"Boxers_Hearts", 0.8,
			"Boxers_RedStripes", 0.8,
			"Boxers_White", 2,
			"Bracelet_LeftFriendshipTINT", 4,
			"Briefs_AnimalPrints", 0.5,
			"Briefs_SmallTrunks_Black", 0.1,
			"Briefs_SmallTrunks_Blue", 0.1,
			"Briefs_SmallTrunks_Red", 0.1,
			"Briefs_SmallTrunks_WhiteTINT", 0.1,
			"Briefs_White", 2,
			"CDplayer", 1,
			"ClosedUmbrellaBlack", 0.1,
			"ClosedUmbrellaBlue", 0.1,
			"ClosedUmbrellaRed", 0.1,
			"ClosedUmbrellaWhite", 0.1,
			"ClosedUmbrellaTINTED", 0.2,
			"ComicBook", 0.5,
			"Diary1", 1,
			"Diary2", 1,
			"DiceBag", 0.001,
			"Disc_Retail", 2,
			"DumbBell", 0.05,
			"Earbuds", 1,
			"FieldHockeyStick", 0.005,
			"Flightcase", 0.005,
			"Football", 0.05,
			"Gloves_BoxingBlue", 0.001,
			"Gloves_BoxingRed", 0.001,
			"Gloves_FingerlessLeatherGloves", 0.1,
			"Gloves_LeatherGloves", 0.05,
			"Gloves_LeatherGlovesBlack", 0.05,
			"Gloves_WhiteTINT", 0.1,
			"GuitarAcoustic", 0.005,
			"Guitarcase", 0.005,
			"HalloweenCandyBucket", 0.001,
			"Harmonica", 0.02,
			"Hat_Bandana", 0.1,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_BaseballHelmet", 0.005,
			"Hat_Beret", 0.5,
			"Hat_BoxingBlue", 0.005,
			"Hat_BoxingRed", 0.005,
			"Hat_BucketHat", 0.5,
			"Hat_FootballHelmet", 0.005,
			"Hat_HockeyHelmet", 0.002,
			"Hat_HockeyMask", 0.001,
			"Headphones", 1,
			"HempMag1", 0.05,
			"IceHockeyStick", 0.005,
			"HoodieDOWN_WhiteTINT", 2,
			"JacketLong_Random", 0.5,
			"Jacket_Leather", 0.5,
			"Jacket_Shellsuit_Black", 0.05,
			"Jacket_Shellsuit_Blue", 0.05,
			"Jacket_Shellsuit_Green", 0.05,
			"Jacket_Shellsuit_Pink", 0.05,
			"Jacket_Shellsuit_Teal", 0.05,
			"Jacket_Shellsuit_TINT", 0.2,
			"Jacket_WhiteTINT", 1,
			"Jumper_DiamondPatternTINT", 0.2,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"Keytar", 0.005,
			"LaCrosseStick", 0.005,
			"LetterHandwritten", 1,
			"LongCoat_Bathrobe", 2,
			"LongJohns", 0.1,
			"LongJohns_Bottoms", 0.1,
			"Necklace_YingYang", 4,
			"Photo", 4,
			"PlasticCup", 8,
			"RPGmanual", 0.001,
			"Saxophone", 0.005,
			"ShinKneeGuard_L", 0.001,
			"Shinpad_L", 0.001,
			"Shirt_Denim", 0.5,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 1,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shirt_Lumberjack", 0.5,
			"Shirt_Lumberjack_TINT", 0.5,
			"Shoes_FlipFlop", 2,
			"Shoes_Random", 0.5,
			"Shoes_Sandals", 0.5,
			"Shoes_Strapped", 0.5,
			"Shoes_TrainerTINT", 1,
			"Shorts_LongDenim", 1,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortDenim", 1,
			"Shorts_ShortSport", 0.5,
			"SoccerBall", 0.005,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Long_White", 2,
			"Suit_Jacket", 0.5,
			"Suit_JacketTINT", 0.5,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"TennisBall", 0.005,
			"TennisRacket", 0.005,
			"TrophyBronze", 1,
			"TrophyGold", 0.1,
			"TrophySilver", 0.5,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Shellsuit_Black", 0.05,
			"Trousers_Shellsuit_Blue", 0.05,
			"Trousers_Shellsuit_Green", 0.05,
			"Trousers_Shellsuit_Pink", 0.05,
			"Trousers_Shellsuit_Teal", 0.05,
			"Trousers_Shellsuit_TINT", 0.2,
			"Trousers_Sport", 0.5,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Trousers_WhiteTINT", 2,
			"Trumpet", 0.005,
			"Tshirt_DefaultDECAL_TINT", 0.5,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_LongSleeve_SuperColor", 0.5,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_Rock", 1,
			"Tshirt_Sport", 0.5,
			"Tshirt_SportDECAL", 0.5,
			"Tshirt_SuperColor", 0.5,
			"Tshirt_TieDye", 0.5,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
			"VideoGame", 4,
			"Violin", 0.005,
			"WeaponMag1", 0.001,
			"WeaponMag7", 0.1,
			"Whistle", 1,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},

	-- Box of old vacation stuff. Beach themed.
	VacationStuff = {
		rolls = 4,
		items = {
			-- Clothing
			"Bikini_Pattern01", 8,
			"Bikini_TINT", 8,
			"Briefs_SmallTrunks_Black", 2,
			"Briefs_SmallTrunks_Blue", 2,
			"Briefs_SmallTrunks_Red", 2,
			"Briefs_SmallTrunks_WhiteTINT", 2,
			"Glasses_Aviators", 4,
			"Glasses_Sun", 8,
			"Glasses_SwimmingGoggles", 10,
			"Hat_BonnieHat", 2,
			"Hat_StrawHat", 4,
			"Hat_SummerFlowerHat", 1,
			"Hat_SummerHat", 2,
			"ShemaghScarf", 1,
			"Shoes_Sandals", 8,
			"Shoes_FlipFlop", 10,
			"Swimsuit_TINT", 8,
			"SwimTrunks_Blue", 6,
			"SwimTrunks_Green", 6,
			"SwimTrunks_Red", 6,
			"SwimTrunks_Yellow", 6,
			"Tshirt_TieDye", 4,
			-- Bags/Containers
			"Bag_BigHikingBag_Travel", 0.5,
			"Bag_DuffelBagTINT", 1,
			"Bag_FannyPackFront", 4,
			"Bag_HikingBag_Travel", 1,
			"Bag_Schoolbag_Travel", 2,
			"Bag_Satchel", 1,
			"Cooler", 10,
			-- Literature
			"Book_GeneralNonFiction", 2,
			"Brochure", 50,
			"Flier", 50,
			"MagazineCrossword", 2,
			"MagazineWordsearch", 2,
			"Magazine_Rich", 10,
			"Paperback_Fiction", 4,
			"Paperback_Travel", 8,
			"Postcard", 50,
			"Postcard", 20,
			"TVMagazine", 10,
			-- Linens
			"BathTowel", 20,
			"BathTowel", 10,
			"Pillow", 8,
			-- Outdoors
			"AlcoholWipes", 8,
			"Bandaid", 8,
			"FirstAidKit_Camping", 1,
			"InsectRepellent", 10,
			-- Photography
			"CameraDisposable", 10,
			"Photo", 50,
			"Photo", 20,
			"Photo", 20,
			"PhotoAlbum", 10,
			-- Mementos
			"SnowGlobe", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WaitingRoomDesk = {
		rolls = 4,
		items = {
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 0.1,
			"Key1", 0.5,
			"Key1", 0.5,
			"Key1", 0.5,
			-- Medical
			"AdhesiveBandageBox", 0.5,
			"Bandaid", 4,
			"Gloves_Surgical", 4,
			"Hat_SurgicalMask", 4,
			-- Stationery/Office
			"Paperwork", 20,
			"Paperwork", 10,
			"PenLight", 4,
			-- Literature
			"Book_Medical", 4,
			"Magazine_Health", 6,
			"Magazine_Popular", 10,
			"Paperback_Diet", 1,
			"Paperback_Fiction", 6,
			"Paperback_Relationship", 1,
			"Paperback_Romance", 1,
			"Paperback_SelfHelp", 1,
			"Paperback_TrueCrime", 1,
			-- Cosmetic
			"Comb", 8,
			"Lipstick", 8,
			"MakeupEyeshadow", 8,
			"MakeupFoundation", 8,
			"Mirror", 8,
			"Perfume", 8,
			-- Misc.
			"CordlessPhone", 4,
			"CreditCard", 8,
			"Gum", 8,
			"Handbag", 4,
			"IndexCard", 10,
			"MenuCard", 10,
			"PillsVitamins", 0.1,
			"Purse", 4,
			-- Special
			"Diary2", 0.1,
			"Flask", 0.1,
		},
		junk = ClutterTables.DeskJunk,
	},

	-- Box of stuff you put on the wall.
	WallDecor = {
		rolls = 4,
		items = {
			"Mov_FlagAdmin", 4,
			"Mov_FlagUSA", 4,
			"Mov_FlagUSALarge", 4,
			"Mov_PaintingBetty", 4,
			"Mov_PaintingElisa", 4,
			"Mov_PaintingGreen", 4,
			"Mov_PaintingLibrary", 4,
			"Mov_PosterDroids", 4,
			"Mov_PosterElement", 4,
			"Mov_PosterMedical", 4,
			"Mov_PosterOmega", 4,
			"Mov_PosterPaws", 4,
			"Mov_PosterPieBlue", 4,
			"Mov_PosterPieGreen", 4,
			"Mov_PosterPiePink", 4,
			"Mov_PosterPieRed", 4,
			"Mov_SignArmy", 4,
			"Mov_SignCitrus", 4,
			"Mov_SignRestricted", 4,
			"Mov_SignWarning", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WardrobeChild = {
		rolls = 4,
		items = {
			-- Clothing
			"Boxers_White", 2,
			"Briefs_White", 4,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 1,
			"Hat_BucketHat", 1,
			"HoodieDOWN_WhiteTINT", 4,
			"Jacket_Shellsuit_Black", 0.05,
			"Jacket_Shellsuit_Blue", 0.05,
			"Jacket_Shellsuit_Green", 0.05,
			"Jacket_Shellsuit_Pink", 0.05,
			"Jacket_Shellsuit_Teal", 0.05,
			"Jacket_Shellsuit_TINT", 0.2,
			"Jacket_Varsity", 1,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"Shirt_Baseball_KY", 1,
			"Shirt_Baseball_Rangers", 1,
			"Shirt_Baseball_Z", 1,
			"Shirt_CropTopNoArmTINT", 1,
			"Shirt_CropTopTINT", 1,
			"Shoes_FlipFlop", 0.5,
			"Shoes_HikingBoots", 0.1,
			"Shoes_Sandals", 0.5,
			"Shoes_Slippers", 0.2,
			"Shoes_TrainerTINT", 1,
			"Shorts_LongDenim", 1,
			"Shorts_LongSport", 2,
			"Shorts_ShortDenim", 1,
			"Shorts_ShortSport", 2,
			"Skirt_Knees", 0.2,
			"Skirt_Long", 0.2,
			"Skirt_Normal", 0.2,
			"Skirt_Short", 0.2,
			"Socks_Ankle", 4,
			"Socks_Ankle_Black", 1,
			"Socks_Ankle_White", 2,
			"Socks_Long", 4,
			"Socks_Ankle_Black", 1,
			"Socks_Long_White", 2,
			"Swimsuit_TINT", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Shellsuit_Black", 0.05,
			"Trousers_Shellsuit_Blue", 0.05,
			"Trousers_Shellsuit_Green", 0.05,
			"Trousers_Shellsuit_Pink", 0.05,
			"Trousers_Shellsuit_Teal", 0.05,
			"Trousers_Shellsuit_TINT", 0.2,
			"Trousers_Sport", 1,
			"Trousers_WhiteTINT", 2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_LongSleeve_SuperColor", 1,
			"Tshirt_PoloStripedTINT", 0.1,
			"Tshirt_PoloTINT", 0.1,
			"Tshirt_Sport", 1,
			"Tshirt_SportDECAL", 1,
			"Tshirt_SuperColor", 1,
			"Tshirt_TieDye", 1,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
			-- Collectibles
			"BorisBadger", 0.001,
			"FluffyfootBunny", 0.001,
			"FreddyFox", 0.001,
			"FurbertSquirrel", 0.001,
			"JacquesBeaver", 0.001,
			"MoleyMole", 0.001,
			"PancakeHedgehog", 0.001,
			"PanchoDog", 0.001,
			"Plushabug", 0.001,
			"Spiffo", 0.001,
			"SpiffoBig", 0.0001,
			-- Bags/Containers
			"Bag_FannyPackFront", 2,
			"Bag_Satchel", 0.2,
			"Bag_Schoolbag_Kids", 0.5,
			"HalloweenCandyBucket", 0.001,
			"PencilCase", 2,
			-- Costume
			"Glasses_3dGlasses", 1,
			"Glasses_Groucho", 1,
			"Glasses_Novelty_Xray", 1,
			"Hat_HalloweenMaskDevil", 0.01,
			"Hat_HalloweenMaskMonster", 0.01,
			"Hat_HalloweenMaskPumpkin", 0.01,
			"Hat_HalloweenMaskSkeleton", 0.01,
			"Hat_HalloweenMaskVampire", 0.01,
			"Hat_HalloweenMaskWitch", 0.01,
			"Hat_Pirate", 0.05,
			"Hat_Wizard", 0.05,
			-- Toys/Electronics
			"BackgammonBoard", 2,
			"Bricktoys", 8,
			"CardDeck", 2,
			"CheckerBoard", 2,
			"ChessBlack", 2,
			"ChessWhite", 2,
			"Crayons", 10,
			"Cube", 4,
			"Dart", 1,
			"Dice", 8,
			"DiceBag", 1,
			"Dice_00", 1,
			"Dice_10", 1,
			"Dice_12", 1,
			"Dice_20", 1,
			"Dice_4", 1,
			"Dice_6", 1,
			"Dice_8", 1,
			"Doll", 6,
			"GamePieceBlack", 2,
			"GamePieceRed", 2,
			"GamePieceWhite", 2,
			"OujaBoard", 0.1,
			"RubberSpider", 1,
			"TarotCardDeck", 0.1,
			"ToyBear", 6,
			"ToyCar", 6,
			"VideoGame", 2,
			"WalkieTalkie1", 1,
			"Yoyo", 2,
			-- Literature
			"Book_Childs", 2,
			"ChildsPictureBook", 4,
			"ComicBook", 10,
			"Diary1", 10,
			"DoodleKids", 8,
			"ElectronicsMag5", 0.01,
			"EngineerMagazine1", 0.01,
			"Magazine_Childs", 10,
			"Magazine_Humor", 8,
			"Paperback_Childs", 8,
			"RPGmanual", 1,
			"TrickMag1", 0.005,
			-- Misc.
			"Pillow", 10,
			"Pillow_Happyface", 0.001,
			"Pillow_Star", 0.001,
			"Sheet", 10,
			-- Science
			"Specimen_Beetles", 0.1,
			"Specimen_Butterflies", 0.1,
			"Specimen_Centipedes", 0.1,
			"Specimen_Insects", 0.1,
			"Specimen_Minerals", 0.4,
			-- Sports
			"ElbowPad_Left_Sport", 0.05,
			"ElbowPad_Left_TINT", 0.1,
			"Kneepad_Left_Sport", 2,
			"Kneepad_Left_TINT", 4,
			"TrophyBronze", 4,
			"TrophyGold", 0.2,
			"TrophySilver", 1,
			"Whistle", 2,
			-- Music
			"Bag_FluteCase", 0.02,
			"Bag_SaxophoneCase", 0.01,
			"Bag_TrumpetCase", 0.01,
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flightcase", 0.01,
			"Flute", 0.02,
			"GuitarAcoustic", 0.02,
			"Guitarcase", 0.01,
			"GuitarElectricBass", 0.01,
			"GuitarElectric", 0.01,
			"Harmonica", 0.02,
			"Headphones", 1,
			"Keytar", 0.01,
			"Saxophone", 0.01,
			"Trumpet", 0.01,
			-- Special
			"Bracelet_LeftFriendshipTINT", 1,
			"CanteenCowboy", 0.1,
			"CigarBox_Kids", 1,
			"Firecracker", 1,
			"Frog", 0.001,
			"HollowBook_Kids", 0.001,
			"HolsterDouble", 0.1,
			"PokerChips", 2,
			"ToyBadge", 1,
			"TrapMouse", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WardrobeClassy = {
		rolls = 4,
		items = {
			-- Clothing
			"Belt2", 4,
			"Bikini_Pattern01", 0.2,
			"Bikini_TINT", 0.2,
			"Boxers_Hearts", 0.2,
			"Boxers_RedStripes", 0.2,
			"Boxers_Silk_Black", 0.8,
			"Boxers_Silk_Red", 0.8,
			"Boxers_White", 2,
			"Bra_Strapless_AnimalPrint", 0.8,
			"Bra_Strapless_Black", 1,
			"Bra_Strapless_FrillyBlack", 0.2,
			"Bra_Strapless_FrillyPink", 0.2,
			"Bra_Strapless_RedSpots", 0.8,
			"Bra_Strapless_White", 1,
			"Bra_Straps_AnimalPrint", 0.8,
			"Bra_Straps_Black", 2,
			"Bra_Straps_FrillyBlack", 0.2,
			"Bra_Straps_FrillyPink", 0.2,
			"Bra_Straps_White", 2,
			"Briefs_AnimalPrints", 0.4,
			"Briefs_SmallTrunks_Black", 0.5,
			"Briefs_SmallTrunks_Blue", 0.5,
			"Briefs_SmallTrunks_Red", 0.5,
			"Briefs_SmallTrunks_WhiteTINT", 0.5,
			"Briefs_White", 2,
			"Corset", 0.4,
			"Corset_Black", 0.2,
			"Corset_Red", 0.2,
			"Dress_Knees", 1,
			"Dress_Long", 1,
			"Dress_Normal", 1,
			"FrillyUnderpants_Black", 0.4,
			"FrillyUnderpants_Pink", 0.4,
			"FrillyUnderpants_Red", 0.4,
			"Garter", 0.8,
			"Gloves_LeatherGloves", 0.1,
			"Gloves_LeatherGlovesBlack", 0.1,
			"Gloves_LongWomenGloves", 0.2,
			"Gloves_WhiteTINT", 0.2,
			"Hat_Beret", 1,
			"Hat_Fedora", 0.1,
			"Hat_Fedora_Delmonte", 0.05,
			"Hat_GolfHat", 1,
			"Hat_GolfHatTINT", 2,
			"Hat_PeakedCapYacht", 0.1,
			"Hat_SummerFlowerHat", 1,
			"Hat_SummerHat", 1,
			"HoodieDOWN_WhiteTINT", 1,
			"Jacket_Leather", 0.5,
			"Jacket_WhiteTINT", 1,
			"Jumper_DiamondPatternTINT", 0.4,
			"Jumper_PoloNeck", 1,
			"Jumper_RoundNeck", 1,
			"Jumper_TankTopTINT", 1,
			"Jumper_VNeck", 1,
			"LongCoat_Bathrobe", 2,
			"LongJohns", 0.05,
			"LongJohns_Bottoms", 0.05,
			"Shirt_FormalTINT", 4,
			"Shirt_FormalWhite", 4,
			"Shoes_Fancy", 1,
			"Shoes_HikingBoots", 0.2,
			"Shoes_Random", 1,
			"Shoes_Sandals", 1,
			"Shoes_Slippers", 0.2,
			"Shoes_Strapped", 1,
			"Shoes_TrainerTINT", 0.5,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortSport", 0.5,
			"Skirt_Knees", 0.4,
			"Skirt_Long", 0.4,
			"Skirt_Normal", 0.4,
			"Socks_Ankle", 1,
			"Socks_Ankle_Black", 4,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 1,
			"Socks_Ankle_Black", 4,
			"Socks_Long_White", 2,
			"StockingsBlack", 0.6,
			"StockingsBlackSemiTrans", 0.6,
			"StockingsBlackTrans", 0.6,
			"StockingsWhite", 0.6,
			"Suit_Jacket", 4,
			"Suit_JacketTINT", 4,
			"Swimsuit_TINT", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"Tie_BowTieFull", 1,
			"Tie_BowTieWorn", 1,
			"Tie_Full", 2,
			"Tie_Worn", 2,
			"TightsBlack", 0.4,
			"TightsBlackSemiTrans", 0.4,
			"TightsBlackTrans", 0.4,
			"Trousers_Sport", 0.5,
			"Trousers_Suit", 4,
			"Trousers_SuitTEXTURE", 4,
			"Trousers_WhiteTINT", 2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_PoloStripedTINT", 4,
			"Tshirt_PoloTINT", 4,
			"Tshirt_Sport", 0.5,
			"Tshirt_SportDECAL", 0.5,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE", 4,
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_WestMaple", 0.1,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- Watches
			"Pocketwatch", 0.1,
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 1,
			"WristWatch_Left_DigitalRed", 0.1,
			"WristWatch_Left_Expensive", 0.1,
			-- Literature
			"Book_Business", 2,
			"Book_Legal", 2,
			"Book_Rich", 4,
			"Diary1", 1,
			"Diary2", 4,
			"LetterHandwritten", 1,
			"Magazine", 4,
			"Magazine_Business", 4,
			"Magazine_Rich", 8,
			"Paperback_Business", 4,
			"Paperback_Legal", 4,
			"Paperback_Rich", 8,
			"Photo", 4,
			"StockCertificate", 10,
			-- Sports
			"BarBell", 0.1,
			"BaseballBat", 0.1,
			"BaseballBat_Metal", 0.1,
			"DumbBell", 0.2,
			"Kneepad_Left_Sport", 1,
			"TrophyBronze", 10,
			"TrophyGold", 1,
			"TrophySilver", 5,
			-- Music
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flightcase", 0.1,
			"GuitarAcoustic", 0.01,
			"Guitarcase", 0.01,
			"GuitarElectricBass", 0.01,
			"GuitarElectric", 0.01,
			"Headphones", 1,
			"Keytar", 0.01,
			-- Misc.
			"ClosedUmbrellaBlack", 0.1,
			"ClosedUmbrellaBlue", 0.1,
			"ClosedUmbrellaRed", 0.1,
			"ClosedUmbrellaWhite", 0.1,
			"ClosedUmbrellaTINTED", 0.2,
			"Sheet", 10,
			"Pillow", 10,
			-- Bags/Containers
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_NormalHikingBag", 0.1,
			"Bag_Satchel", 0.2,
			"Briefcase", 0.2,
			"Handbag", 0.5,
			"Hatbox", 1,
			"JewelleryBox_Fancy", 0.1,
			"MakeupCase_Professional", 0.1,
			"Purse", 0.5,
			"Shoebox", 1,
			"Suitcase", 0.5,
			-- Guns/Ammo
			"AssaultRifle2", 0.001,
			"DoubleBarrelShotgun", 0.01,
			"HuntingRifle", 0.01,
			"Shotgun", 0.01,
			"VarmintRifle", 0.05,
			-- Gun Cases
			"Bag_RifleCaseCloth", 0.0025,
			"Bag_RifleCaseCloth2", 0.0005,
			"Bag_ShotgunCaseCloth", 0.0025,
			"Bag_ShotgunCaseCloth2", 0.0025,
			"RifleCase1", 0.0025,
			"RifleCase2", 0.0005,
			"RifleCase3", 0.0005,
			"ShotgunCase1", 0.0025,
			"ShotgunCase2", 0.0025,
			-- Special
			"Bag_MoneyBag", 0.001,
			"Briefcase_Money", 0.001,
			"CameraExpensive", 10,
			"CameraFilm", 10,
			"Champagne", 0.1,
			"CordlessPhone", 10,
			"Flask", 0.1,
			"GemBag", 0.001,
			"Goblet", 0.001,
			"Hat_HockeyMask_Gold", 0.0001,
			"HollowBook_Valuables", 0.001,
			"IDcard_Blank", 0.001,
			"MilitaryMedal", 0.001,
			"MoneyBundle", 0.001,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},

	WardrobeGeneric = {
		rolls = 4,
		items = {
			-- Clothing
			"Belt2", 4,
			"Bikini_Pattern01", 0.2,
			"Bikini_TINT", 0.2,
			"BoobTube", 0.5,
			"BoobTubeSmall", 0.5,
			"Boxers_Hearts", 0.8,
			"Boxers_RedStripes", 0.8,
			"Boxers_Silk_Black", 0.2,
			"Boxers_Silk_Red", 0.2,
			"Boxers_White", 2,
			"Bra_Strapless_AnimalPrint", 0.8,
			"Bra_Strapless_Black", 1,
			"Bra_Strapless_FrillyBlack", 0.2,
			"Bra_Strapless_FrillyPink", 0.2,
			"Bra_Strapless_RedSpots", 0.8,
			"Bra_Strapless_White", 1,
			"Bra_Straps_AnimalPrint", 0.8,
			"Bra_Straps_Black", 2,
			"Bra_Straps_FrillyBlack", 0.2,
			"Bra_Straps_FrillyPink", 0.2,
			"Bra_Straps_White", 2,
			"Briefs_AnimalPrints", 0.5,
			"Briefs_SmallTrunks_Black", 0.1,
			"Briefs_SmallTrunks_Blue", 0.1,
			"Briefs_SmallTrunks_Red", 0.1,
			"Briefs_SmallTrunks_WhiteTINT", 0.1,
			"Briefs_White", 2,
			"Corset", 0.2,
			"Corset_Black", 0.1,
			"Corset_Red", 0.1,
			"Dress_Knees", 1,
			"Dress_Long", 1,
			"Dress_Normal", 1,
			"FrillyUnderpants_Black", 0.4,
			"FrillyUnderpants_Pink", 0.4,
			"FrillyUnderpants_Red", 0.4,
			"Garter", 0.2,
			"Gloves_FingerlessGloves", 0.1,
			"Gloves_LeatherGloves", 0.05,
			"Gloves_LeatherGlovesBlack", 0.05,
			"Gloves_LongWomenGloves", 0.1,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.5,
			"Hat_Beret", 0.5,
			"Hat_BucketHat", 0.5,
			"Hat_Fedora", 0.05,
			"Hat_SummerFlowerHat", 0.1,
			"Hat_SummerHat", 0.1,
			"HoodieDOWN_WhiteTINT", 2,
			"JacketLong_Random", 0.5,
			"Jacket_Leather", 0.5,
			"Jacket_Shellsuit_Black", 0.05,
			"Jacket_Shellsuit_Blue", 0.05,
			"Jacket_Shellsuit_Green", 0.05,
			"Jacket_Shellsuit_Pink", 0.05,
			"Jacket_Shellsuit_Teal", 0.05,
			"Jacket_Shellsuit_TINT", 0.2,
			"Jacket_WhiteTINT", 1,
			"Jumper_DiamondPatternTINT", 0.2,
			"Jumper_PoloNeck", 0.5,
			"Jumper_RoundNeck", 0.5,
			"Jumper_TankTopTINT", 0.5,
			"Jumper_VNeck", 0.5,
			"LongCoat_Bathrobe", 2,
			"LongJohns", 0.1,
			"LongJohns_Bottoms", 0.1,
			"Shirt_CropTopNoArmTINT", 0.2,
			"Shirt_CropTopTINT", 0.2,
			"Shirt_Denim", 0.5,
			"Shirt_FormalTINT", 1,
			"Shirt_FormalWhite", 1,
			"Shirt_FormalWhite_ShortSleeve", 1,
			"Shirt_FormalWhite_ShortSleeveTINT", 1,
			"Shirt_Lumberjack", 0.5,
			"Shirt_Lumberjack_TINT", 0.5,
			"Shoes_FlipFlop", 0.5,
			"Shoes_HikingBoots", 0.1,
			"Shoes_Random", 0.5,
			"Shoes_Sandals", 0.5,
			"Shoes_Slippers", 0.2,
			"Shoes_Strapped", 0.5,
			"Shoes_TrainerTINT", 0.5,
			"Shoes_WorkBoots", 0.1,
			"Shorts_LongDenim", 1,
			"Shorts_LongSport", 0.5,
			"Shorts_ShortDenim", 1,
			"Shorts_ShortSport", 0.5,
			"Skirt_Knees", 0.2,
			"Skirt_Long", 0.2,
			"Skirt_Normal", 0.2,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Ankle_White", 2,
			"Socks_Heavy", 1,
			"Socks_Long", 2,
			"Socks_Ankle_Black", 2,
			"Socks_Long_White", 2,
			"StockingsBlack", 0.6,
			"StockingsBlackSemiTrans", 0.6,
			"StockingsBlackTrans", 0.6,
			"StockingsWhite", 0.6,
			"Suit_Jacket", 0.5,
			"Suit_JacketTINT", 0.5,
			"Swimsuit_TINT", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"TightsBlack", 0.4,
			"TightsBlackSemiTrans", 0.4,
			"TightsBlackTrans", 0.4,
			"TightsFishnets", 0.2,
			"TrousersMesh_DenimLight", 2,
			"Trousers_DefaultTEXTURE", 2,
			"Trousers_DefaultTEXTURE_TINT", 2,
			"Trousers_Denim", 1,
			"Trousers_JeanBaggy", 1,
			"Trousers_Shellsuit_Black", 0.05,
			"Trousers_Shellsuit_Blue", 0.05,
			"Trousers_Shellsuit_Green", 0.05,
			"Trousers_Shellsuit_Pink", 0.05,
			"Trousers_Shellsuit_Teal", 0.05,
			"Trousers_Shellsuit_TINT", 0.2,
			"Trousers_Sport", 0.2,
			"Trousers_Suit", 0.5,
			"Trousers_SuitTEXTURE", 0.5,
			"Trousers_WhiteTINT", 2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_LongSleeve_SuperColor", 0.1,
			"Tshirt_PoloStripedTINT", 0.5,
			"Tshirt_PoloTINT", 0.5,
			"Tshirt_Sport", 0.2,
			"Tshirt_SportDECAL", 0.2,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.1,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicGold", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalDress", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			-- Literature
			"Diary1", 1,
			"Diary2", 1,
			"LetterHandwritten", 1,
			"Photo", 4,
			-- Sports
			"BarBell", 0.1,
			"BaseballBat", 0.5,
			"BaseballBat_Metal", 0.5,
			"DumbBell", 0.2,
			"Kneepad_Left_Sport", 1,
			"TrophyBronze", 1,
			"TrophyGold", 0.1,
			"TrophySilver", 0.5,
			-- Music
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flightcase", 0.01,
			"GuitarAcoustic", 0.01,
			"Guitarcase", 0.01,
			"GuitarElectricBass", 0.01,
			"GuitarElectric", 0.01,
			"Harmonica", 0.02,
			"Headphones", 1,
			"Keytar", 0.01,
			-- Misc.
			"ClosedUmbrellaBlack", 0.1,
			"ClosedUmbrellaBlue", 0.1,
			"ClosedUmbrellaRed", 0.1,
			"ClosedUmbrellaWhite", 0.1,
			"ClosedUmbrellaTINTED", 0.2,
			"Pillow", 10,
			"Sheet", 10,
			-- Bags/Containers
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_NormalHikingBag", 0.1,
			"Bag_Satchel", 0.2,
			"Briefcase", 0.2,
			"Handbag", 0.5,
			"Purse", 0.5,
			"Suitcase", 0.5,
			-- Guns/Ammo
			"AssaultRifle2", 0.001,
			"DoubleBarrelShotgun", 0.01,
			"HuntingRifle", 0.01,
			"Shotgun", 0.01,
			"VarmintRifle", 0.05,
			-- Gun Cases
			"Bag_RifleCaseCloth", 0.0025,
			"Bag_RifleCaseCloth2", 0.0005,
			"Bag_ShotgunCaseCloth", 0.0025,
			"Bag_ShotgunCaseCloth2", 0.0025,
			"RifleCase1", 0.0025,
			"RifleCase2", 0.0005,
			"RifleCase3", 0.0005,
			"ShotgunCase1", 0.0025,
			"ShotgunCase2", 0.0025,
			-- Special
			"HollowBook", 0.001,
			"MilitaryMedal", 0.001,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
			}
		}
	},

	WardrobeManClassy = WardrobeClassy,

	WardrobeRedneck = {
		rolls = 4,
		items = {
			-- Clothing
			"Belt2", 4,
			"Bikini_Pattern01", 0.2,
			"Bikini_TINT", 0.2,
			"BoobTube", 1,
			"BoobTubeSmall", 1,
			"Boxers_Hearts", 0.8,
			"Boxers_RedStripes", 0.8,
			"Boxers_White", 2,
			"Bra_Strapless_AnimalPrint", 0.4,
			"Bra_Strapless_Black", 0.4,
			"Bra_Strapless_FrillyBlack", 0.1,
			"Bra_Strapless_FrillyPink", 0.1,
			"Bra_Strapless_RedSpots", 0.4,
			"Bra_Strapless_White", 0.4,
			"Bra_Straps_AnimalPrint", 0.4,
			"Bra_Straps_Black", 1,
			"Bra_Straps_FrillyBlack", 0.1,
			"Bra_Straps_FrillyPink", 0.1,
			"Bra_Straps_White", 1,
			"Briefs_AnimalPrints", 0.2,
			"Briefs_White", 2,
			"Dungarees", 0.5,
			"Dungarees_HuntingCamo", 0.1,
			"FrillyUnderpants_Black", 0.2,
			"FrillyUnderpants_Pink", 0.2,
			"FrillyUnderpants_Red", 0.2,
			"Gloves_FingerlessGloves", 0.2,
			"Gloves_HuntingCamo", 0.01,
			"Gloves_LeatherGloves", 0.05,
			"Gloves_LeatherGlovesBlack", 0.05,
			"Hat_Bandana", 0.2,
			"Hat_BaseballCap", 0.05,
			"Hat_BaseballCapArmy", 0.1,
			"Hat_BaseballCapBlue", 0.05,
			"Hat_BaseballCapGreen", 0.05,
			"Hat_BaseballCap_HuntingCamo", 0.01,
			"Hat_BaseballCapKY", 0.01,
			"Hat_BaseballCapKY_Red", 0.01,
			"Hat_BaseballCapRed", 0.05,
			"Hat_BaseballCapTINT", 0.5,
			"Hat_Beany", 0.5,
			"Hat_BucketHat", 0.5,
			"Hat_StrawHat", 0.5,
			"Hat_SummerHat", 0.2,
			"HoodieDOWN_WhiteTINT", 2,
			"Hoodie_HuntingCamo_DOWN", 0.1,
			"JacketLong_Random", 0.5,
			"Jacket_ArmyCamoDesert", 0.5,
			"Jacket_ArmyCamoGreen", 1,
			"Jacket_ArmyCamoUrban", 0.2,
			"Jacket_Black", 0.5,
			"Jacket_HuntingCamo", 0.1,
			"Jacket_Padded_HuntingCamo", 0.01,
			"Jacket_WhiteTINT", 1,
			"LongCoat_Bathrobe", 0.1,
			"LongJohns", 0.5,
			"LongJohns_Bottoms", 0.5,
			"Shirt_CamoDesert", 0.5,
			"Shirt_CamoGreen", 1,
			"Shirt_CamoUrban", 0.2,
			"Shirt_CropTopNoArmTINT", 1,
			"Shirt_CropTopTINT", 1,
			"Shirt_Denim", 1,
			"Shirt_HawaiianRed", 0.1,
			"Shirt_HawaiianTINT", 0.1,
			"Shirt_Lumberjack", 2,
			"Shirt_Lumberjack_TINT", 2,
			"Shoes_ArmyBoots", 0.1,
			"Shoes_ArmyBootsDesert", 0.05,
			"Shoes_FlipFlop", 0.5,
			"Shoes_HikingBoots", 0.1,
			"Shoes_Random", 2,
			"Shoes_Slippers", 0.2,
			"Shoes_TrainerTINT", 2,
			"Shoes_Wellies", 0.1,
			"Shoes_WorkBoots", 0.5,
			"Shorts_CamoGreenLong", 1,
			"Shorts_CamoUrbanLong", 0.5,
			"Shorts_LongDenim", 2,
			"Shorts_ShortDenim", 2,
			"Socks_Ankle", 2,
			"Socks_Ankle_Black", 1,
			"Socks_Ankle_White", 4,
			"Socks_Heavy", 2,
			"Socks_Long", 2,
			"Socks_Ankle_Black", 1,
			"Socks_Long_White", 4,
			"StockingsBlack", 0.6,
			"StockingsBlackSemiTrans", 0.6,
			"StockingsBlackTrans", 0.6,
			"StockingsWhite", 0.6,
			"Swimsuit_TINT", 0.2,
			"SwimTrunks_Blue", 0.1,
			"SwimTrunks_Green", 0.1,
			"SwimTrunks_Red", 0.1,
			"SwimTrunks_Yellow", 0.1,
			"TightsBlack", 0.2,
			"TightsBlackSemiTrans", 0.2,
			"TightsBlackTrans", 0.2,
			"TightsFishnets", 0.4,
			"TrousersMesh_DenimLight", 2,
			"Trousers_CamoDesert", 0.5,
			"Trousers_CamoGreen", 1,
			"Trousers_CamoUrban", 0.2,
			"Trousers_DefaultTEXTURE", 1,
			"Trousers_DefaultTEXTURE_TINT", 1,
			"Trousers_Denim", 2,
			"Trousers_HuntingCamo", 0.1,
			"Trousers_Padded_HuntingCamo", 0.01,
			"Trousers_JeanBaggy", 2,
			"Trousers_WhiteTINT", 1,
			"Tshirt_ArmyGreen", 1,
			"Tshirt_CamoDesert", 0.5,
			"Tshirt_CamoGreen", 1,
			"Tshirt_CamoUrban", 0.2,
			"Tshirt_DefaultDECAL_TINT", 0.1,
			"Tshirt_DefaultTEXTURE_TINT", 1,
			"Tshirt_HuntingCamo", 0.1,
			"Tshirt_IndieStoneDECAL", 0.001,
			"Tshirt_LongSleeve_HuntingCamo", 0.1,
			"Tshirt_LongSleeve_SuperColor", 0.1, 
			"Tshirt_Rock", 1,
			"Tshirt_SuperColor", 0.1,
			"Tshirt_TieDye", 0.1,
			"Tshirt_WhiteLongSleeveTINT", 1,
			"Tshirt_WhiteTINT", 2,
			"Underpants_Black", 2,
			"Underpants_White", 2,
			"Vest_DefaultTEXTURE_TINT", 4,
			-- Keys/Keyrings
			"CarKey", 2,
			"KeyRing_Bass", 0.005,
			"KeyRing_Clover", 0.005,
			"KeyRing_EagleFlag", 0.005,
			"KeyRing_EightBall", 0.005,
			"KeyRing_Panther", 0.005,
			"KeyRing_PineTree", 0.005,
			"KeyRing_PrayingHands", 0.1,
			"KeyRing_RabbitFoot", 0.1,
			"KeyRing_Sexy", 0.005,
			"KeyRing", 1,
			"Key1", 2,
			"Key1", 2,
			"Key1", 2,
			-- Watches
			"WristWatch_Left_ClassicBlack", 0.1,
			"WristWatch_Left_ClassicBrown", 0.1,
			"WristWatch_Left_ClassicMilitary", 0.1,
			"WristWatch_Left_DigitalBlack", 0.1,
			"WristWatch_Left_DigitalRed", 0.1,
			-- Literature
			"Diary1", 1,
			"Diary2", 1,
			"HempMag1", 0.05,
			"LetterHandwritten", 1,
			"Magazine", 4,
			"Magazine_Car", 4,
			"Magazine_Outdoors", 4,
			"Magazine_Sports", 4,
			"Paperback_Poor", 4,
			"Photo", 4,
			"WeaponMag4", 0.001,
			-- Sports
			"BarBell", 0.1,
			"BaseballBat", 0.5,
			"BaseballBat_Metal", 0.5,
			"DumbBell", 0.2,
			"Kneepad_Left_Sport", 1,
			"ShinKneeGuard_L_TINT", 0.01,
			"TrophyBronze", 1,
			"TrophyGold", 0.1,
			"TrophySilver", 0.5,
			-- Music
			"CDplayer", 1,
			"Disc_Retail", 2,
			"Earbuds", 1,
			"Flightcase", 0.01,
			"GuitarAcoustic", 0.01,
			"Guitarcase", 0.01,
			"GuitarElectricBass", 0.01,
			"GuitarElectric", 0.01,
			"Headphones", 1,
			"Keytar", 0.01,
			-- Misc.
			"ClosedUmbrellaBlack", 0.1,
			"ClosedUmbrellaBlue", 0.1,
			"ClosedUmbrellaRed", 0.1,
			"ClosedUmbrellaWhite", 0.1,
			"ClosedUmbrellaTINTED", 0.2,
			"Pillow", 10,
			"Sheet", 10,
			-- Bags/Containers
			"Bag_BigHikingBag", 0.05,
			"Bag_DuffelBagTINT", 0.5,
			"Bag_FannyPackFront", 2,
			"Bag_NormalHikingBag", 0.1,
			"Bag_Satchel", 0.2,
			"Handbag", 0.5,
			"Purse", 0.5,
			"Suitcase", 0.5,
			-- Knives
			"Handiknife", 0.5,
			"KnifeButterfly", 1,
			"KnifePocket", 0.5,
			"LargeKnife", 0.1,
			"Multitool", 0.001,
			-- Guns/Ammo
			"AssaultRifle2", 0.001,
			"DoubleBarrelShotgun", 0.01,
			"HuntingRifle", 0.01,
			"Shotgun", 0.01,
			"VarmintRifle", 0.05,
			-- Gun Cases
			"Bag_RifleCaseCloth", 0.0025,
			"Bag_RifleCaseCloth2", 0.0005,
			"Bag_ShotgunCaseCloth", 0.0025,
			"Bag_ShotgunCaseCloth2", 0.0025,
			"RifleCase1", 0.0025,
			"RifleCase2", 0.0005,
			"RifleCase3", 0.0005,
			"ShotgunCase1", 0.0025,
			"ShotgunCase2", 0.0025,
			-- Special
			"CanteenMilitary", 0.1,
			"Firecracker", 0.01,
			"HollowBook_Handgun", 0.001,
			"HollowBook_Whiskey", 0.001,
			"MilitaryMedal", 0.005,
		},
		junk = {
			rolls = 1,
			items = {
				"BobPic", 0.001,
				"CaseyPic", 0.001,
				"ChrisPic", 0.001,
				"CortmanPic", 0.001,
				"HankPic", 0.001,
				"JamesPic", 0.001,
				"KatePic", 0.001,
				"MariannePic", 0.001,
				"IDcard", 1,
				"Necklace_DogTag", 1,
			}
		}
	},

	WardrobeWoman = WardrobeGeneric,

	WardrobeWomanClassy = WardrobeClassy,

	WeddingStoreDresses = {
		isShop = true,
		rolls = 4,
		items = {
			"DressKnees_Straps", 6,
			"Dress_Knees", 6,
			"Dress_Long", 10,
			"Dress_long_Straps", 10,
			"Dress_Normal", 8,
			"Dress_Short", 4,
			"Dress_Straps", 10,
			"Garter", 4,
			"Hat_WeddingVeil", 10,
			"WeddingDress", 10,
			"WeddingDress", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},
	
	WeddingStoreSuits = {
		isShop = true,
		rolls = 4,
		items = {
			"Suit_Jacket", 10,
			"Suit_JacketTINT", 10,
			"Trousers_Suit", 10,
			"WeddingJacket", 20,
			"WeddingJacket", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	WeldingWorkshopFuel = {
		rolls = 4,
		items = {
			"Oxygen_Tank", 20,
			"Oxygen_Tank", 10,
			"PropaneTank", 20,
			"PropaneTank", 20,
			"PropaneTank", 10,
			"PropaneTank", 10,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	WeldingWorkshopMetal = {
		rolls = 4,
		items = {
			"IronBar", 8,
			"IronBarHalf", 10,
			"MetalBar", 10,
			"MetalPipe", 10,
			"SheetMetal", 20,
			"SheetMetal", 10,
			"SmallSheetMetal", 10,
			"SteelBar", 8,
			"SteelBarHalf", 10,
			"WeldingRods", 20,
			"Wire", 20,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	WeldingWorkshopTools = {
		rolls = 4,
		items = {
			-- Tools
			"BallPeenHammer", 8,
			"BenchAnvil", 1,
			"BlowerFan", 2,
			"BlowTorch", 10,
			"BoltCutters", 8,
			"Calipers", 8,
			"DrawPlate", 8,
			"File", 8,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"Pliers", 8,
			"Screwdriver", 10,
			"SheetMetalSnips", 8,
			"SmallFileSet", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"SmallSheetMetal", 10,
			"SmithingHammer", 2,
			"ViseGrips", 4,
			-- Materials
			"Epoxy", 2,
			"FiberglassTape", 2,
			"NutsBolts", 8,
			"Oxygen_Tank", 10,
			"Propane_Refill", 10,
			"SheetMetal", 10,
			"Whetstone", 10,
			-- Accessories
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"Kneepad_Left_Workman", 4,
			"RespiratorFilters", 2,
			"WeldingMask", 8,
			-- Literature
			"BSToolsSchematic", 4,
			"CookwareSchematic", 4,
			"BookMaintenance1", 2,
			"BookMaintenance2", 1,
			"BookMaintenance3", 0.5,
			"BookMaintenance4", 0.1,
			"BookMaintenance5", 0.05,
			"BookMetalWelding1", 2,
			"BookMetalWelding2", 1,
			"BookMetalWelding3", 0.5,
			"BookMetalWelding4", 0.1,
			"BookMetalWelding5", 0.05,
		},
		junk = {
			rolls = 1,
			items = {
				
			}
		}
	},

	-- Biscuits and cornbread.
	WesternKitchenBaking = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Foods
			"Cornbread", 8,
			"Biscuit", 8,
			-- Ingredients
			"BakingSoda", 4,
			"Butter", 4,
			"Cornflour2", 8,
			"Flour2", 8,
			"Margarine", 4,
			"Sugar", 4,
			"Yeast", 8,
			-- Utensils
			"BreadKnife", 8,
			"KitchenTongs", 10,
			"RollingPin", 8,
			"SteakKnife", 10,
			-- Misc.
			"Aluminum", 8,
			"DishCloth", 10,
			"OvenMitt", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WesternKitchenButcher = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 4,
			"PorkChop", 8,
			"Sausage", 8,
			"Steak", 10,
			-- Sauces/Spices
			"BBQSauce", 4,
			"Pepper", 4,
			"PowderedGarlic", 4,
			"PowderedOnion", 4,
			"Salt", 4,
			"SeasoningSalt", 4,
			"Vinegar2", 4,
			-- Utensils
			"Fleshing_Tool", 10,
			"KitchenKnife", 6,
			"LargeKnife", 1,
			"MeatCleaver", 4,
			"SteakKnife", 10,
			-- Misc.
			"CuttingBoardPlastic", 10,
			"DishCloth", 10,
			"Twine", 10,
			-- Clothing
			"Apron_White", 8,
			"Chainmail_Hand_L", 1,
			"Chainmail_Hand_R", 0.1,
			"Hat_ChefHat", 4,
			-- Literature (Skill Books)
			"BookButchering1", 1,
			"BookButchering2", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WesternKitchenFreezer = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			"Bacon", 8,
			"PorkChop", 20,
			"PorkChop", 10,
			"Sausage", 20,
			"Sausage", 10,
			"Steak", 50,
			"Steak", 20,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WesternKitchenFridge = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Meat
			"Bacon", 8,
			"PorkChop", 10,
			"Sausage", 10,
			"Steak", 50,
			"Steak", 20,
			-- Vegetables
			"BellPepper", 8,
			"Blackbeans", 4,
			"Corn", 10,
			"Garlic", 8,
			"Onion", 8,
			"Potato", 10,
			"PepperJalapeno", 4,
			-- Sauces/Condiments
			"Butter", 8,
			"SourCream", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WesternKitchenSauce = {
		ignoreZombieDensity = true,
		rolls = 4,
		items = {
			-- Sauces/Spices
			"BBQSauce", 10,
			"GravyMix", 10,
			"Hotsauce", 8,
			"Ketchup", 8,
			"MayonnaiseFull", 8,
			"Mustard", 8,
			"Pepper", 4,
			"PowderedGarlic", 4,
			"PowderedOnion", 4,
			"Salt", 4,
			"SeasoningSalt", 4,
			"TomatoPaste", 4,
			"Vinegar2", 8,
			"Vinegar_Jug", 1,
			-- Utensils
			"BastingBrush", 10,
			"Ladle", 10,
			"SteakKnife", 10,
			-- Misc.
			"DishCloth", 10,
			-- Clothing
			"Apron_White", 8,
			"Hat_ChefHat", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Clean, empty bottles.
	WhiskeyBottlingEmpty = {
		isShop = true,
		rolls = 4,
		items = {
			"WhiskeyEmpty", 50,
			"WhiskeyEmpty", 20,
			"WhiskeyEmpty", 20,
			"WhiskeyEmpty", 10,
			"WhiskeyEmpty", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Full and freshly bottled.
	WhiskeyBottlingFull = {
		ignoreZombieDensity = true,
		isShop = true,
		rolls = 4,
		items = {
			"Whiskey", 50,
			"Whiskey", 20,
			"Whiskey", 20,
			"Whiskey", 10,
			"Whiskey", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestBarCounter = {
		rolls = 4,
		items = {
			-- Glasses/Cups
			"ClayMug", 4,
			"CopperCup", 2,
			"DrinkingGlass", 10,
			"GlassWine", 8,
			"MetalCup", 8,
			"SilverCup", 1,
			-- Cutlery
			"SpoonForged", 4,
			-- Misc.
			"DishCloth", 10,
			"Doily", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestBarShelf = {
		rolls = 4,
		items = {
			-- Prop Bottles
			"GinEmpty", 20,
			"PortEmpty", 10,
			"RumEmpty", 20,
			"ScotchEmpty", 10,
			"SherryEmpty", 10,
			"VermouthEmpty", 10,
			"WhiskeyEmpty", 50,
			"Wine2OpenEmpty", 10,
			-- Glasses/Cups
			"DrinkingGlass", 20,
			"DrinkingGlass", 10,
			"GlassWine", 8,
			-- Misc.
			"DishCloth", 10,
			"Doily", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestBarberCounter = {
		rolls = 4,
		items = {
			"BathTowel", 4,
			"Belt2", 4,
			"ClayBowl", 8,
			"ClayJarGlazed", 4,
			"CologneEmpty", 8,
			"Forceps_Forged", 2,
			"Mirror", 8,
			"PerfumeEmpty", 8,
			"Pocketwatch", 0.1,
			"ScissorsForged", 4,
			"StraightRazor", 8,
			"Tweezers_Forged", 4,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestBarberShelves = {
		rolls = 4,
		items = {
			"CologneEmpty", 20,
			"CologneEmpty", 10,
			"Belt2", 8,
			"ClayBowl", 8,
			"ClayJarGlazed", 4,
			"Mirror", 8,
			"PerfumeEmpty", 20,
			"PerfumeEmpty", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Prop clothing and antique/reproduction historically-themed items.
	WildWestBedroom = {
		rolls = 4,
		items = {
			"Broom_Twig", 8,
			"ClayBowl", 4,
			"ClayJar", 2,
			"ClayPot", 8,
			"CopperCup", 1,
			"Doily", 10,
			"Goblet_Wood", 4,
			"Kettle_Copper", 1,
			"KnittingNeedles", 8,
			"Lantern_Hurricane", 8,
			"MetalCup", 4,
			"Pocketwatch", 0.1,
			"PotForged", 2,
			"Teacup", 4,
			"Yarn", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Old-school blacksmithing tools and supplies. Rare chance of Old West smithing skill book.
	WildWestBlacksmith = {
		rolls = 4,
		items = {
			-- Tools
			"Bellows", 10,
			"BucketLargeWood", 2,
			"BucketWood", 8,
			"File", 4,
			"MetalworkingChisel", 4,
			"MetalworkingPliers", 4,
			"MetalworkingPunch", 4,
			"SmithingHammer", 8,
			"Tongs", 10,
			-- Materials
			"Coke", 8,
			"IronBarHalf", 2,
			"IronBarQuarter", 4,
			-- Molds
			"WoodenBarCastMold", 2,
			"WoodenBlacksmithAnvilMold", 1,
			"WoodenBrickMold", 2,
			"WoodenCrucibleMold", 2,
			"WoodenIngotCastMold", 2,
			"WoodenShingleMold", 2,
			"WoodenTileMold", 2,
			-- Schematics
			"BSToolsSchematic", 8,
			"CookwareSchematic", 4,
			-- Clothing
			"Glasses_OldWeldingGoggles", 1,
			"Gloves_LeatherGlovesBrown", 4,
			-- Special
			"BookBlacksmith3", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestClothing = {
		rolls = 4,
		items = {
			"Dungarees", 2,
			"Shirt_Crafted_Cotton", 8,
			"Shirt_Crafted_DenimRandom", 4,
			"Suit_Jacket", 2,
			"Trousers_Crafted_DenimRandom", 8,
			"Vest_Waistcoat", 2,
			"Shirt_FormalWhite", 1,
			"Trousers_SuitWhite_White", 1,
			"Trousers_Suit", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestGeneralStore = {
		isShop = true,
		rolls = 4,
		items = {
			"Bag_GardenBasket", 8,
			"Bag_PicnicBasket", 8,
			"Broom_Twig", 8,
			"CigarBox", 1,
			"ClayBowl", 8,
			"ClayJar", 8,
			"ClayJarGlazed", 4,
			"CookieJar", 4,
			"Hatbox", 8,
			"Fleshing_Tool", 4,
			"JewelleryBox_Fancy", 1,
			"PanForged", 8,
			"PotForged", 8,
			"Toolbox_Wooden", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestKitchen = {
		rolls = 4,
		items = {
			"Broom_Twig", 8,
			"BucketCarved", 2,
			"BucketForged", 2,
			"BucketWood", 4,
			"Fleshing_Tool", 1,
			"ForkForged", 4,
			"Kettle_Copper", 8,
			"KitchenKnifeForged", 2,
			"Lantern_Hurricane", 4,
			"MeatCleaverForged", 2,
			"PanForged", 8,
			"PotForged", 8,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestLivingRoom = {
		rolls = 4,
		items = {
			"Bellows", 4,
			"BookFancy_Bible", 1,
			"BookFancy_ClassicFiction", 1,
			"BookFancy_ClassicNonfiction", 1,
			"Book_ClassicFiction", 4,
			"Book_ClassicNonfiction", 4,
			"Broom_Twig", 8,
			"ClayJar", 2,
			"ClayJarGlazed", 1,
			"FireplacePoker", 4,
			"Fleshing_Tool", 1,
			"Lantern_Hurricane", 4,
			"PanForged", 2,
			"PotForged", 1,
			"Shoes_CowboyBoots", 1,
			"Shoes_CowboyBoots_Fancy", 0.1,
			"Shoes_CowboyBoots_SnakeSkin", 0.1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestShelves = {
		rolls = 4,
		items = {
			"BookFancy_Bible", 4,
			"BookFancy_ClassicFiction", 4,
			"BookFancy_ClassicNonfiction", 4,
			"Book_ClassicFiction", 10,
			"Book_ClassicNonfiction", 10,
			"CanteenCowboyEmpty", 2,
			"Fleshing_Tool", 1,
			"HandScytheForged", 1,
			"Kettle_Copper", 2,
			"Lantern_Hurricane", 4,
			"MagnifyingGlass", 4,
			"Pocketwatch", 4,
			"SheepShearsForged", 1,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- This is an actor, not a law enforcement officer.
	WildWestSheriffDesk = {
		rolls = 4,
		items = {
			"ToyBadge", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestSheriffLocker = {
		rolls = 4,
		items = {
			"ToyBadge", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	WildWestSouveniers = {
		rolls = 4,
		items = {
			"ToyBadge", 50,
			"ToyBadge", 20,
			"CanteenCowboyEmpty", 10,
			"Specimen_Minerals", 10,
			"SnowGlobe", 10,
			"Hat_Raccoon", 10,
			"PenFancy", 20,
			"PenFancy", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- No kindling or flammable materials. Small chance of prop items.
	WildWestWoodStove = {
		rolls = 4,
		items = {
			"Bellows", 4,
			"FireplacePoker", 4,
			"PotForged", 1,
			"PanForged", 2,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Fresh wire at full condition.
	WireFactoryBarbed = {
		isShop = true,
		rolls = 4,
		items = {
			"BarbedWireStack", 20,
			"BarbedWireStack", 20,
			"BarbedWireStack", 10,
			"BarbedWireStack", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Same as above.
	WireFactoryBasic = {
		isShop = true,
		rolls = 4,
		items = {
			"WireStack", 20,
			"WireStack", 20,
			"WireStack", 10,
			"WireStack", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- No stacks for this one sadly.
	WireFactoryElectric = {
		isShop = true,
		rolls = 4,
		items = {
			"ElectricWire", 50,
			"ElectricWire", 20,
			"ElectricWire", 20,
			"ElectricWire", 10,
			"ElectricWire", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

	-- Drawing plates plus generic factory tools.
	WireFactoryTools = {
		rolls = 4,
		items = {
			-- Clothing
			"ElbowPad_Left_Workman", 1,
			"Glasses_SafetyGoggles", 4,
			"Hat_BuildersRespirator", 2,
			"Hat_DustMask", 4,
			"Hat_EarMuff_Protectors", 4,
			"Hat_HardHat", 2,
			"Kneepad_Left_Workman", 4,
			"WeldingMask", 4,
			-- Tools
			"BallPeenHammer", 8,
			"Calipers", 8,
			"DrawPlate", 20,
			"DrawPlate", 10,
			"File", 8,
			"MetalworkingChisel", 8,
			"MetalworkingPliers", 1,
			"MetalworkingPunch", 8,
			"Pliers", 8,
			"Saw", 8,
			"Screwdriver", 10,
			"SheetMetalSnips", 8,
			"SmallFileSet", 8,
			"SmallPunchSet", 8,
			"SmallSaw", 8,
			"ViseGrips", 4,
			"Tongs", 4,
			-- Misc.
			"MarkerBlack", 10,
			"MeasuringTape", 10,
			"RespiratorFilters", 2,
			-- Materials
			"BarbedWire", 10,
			"ElectricWire", 10,
			"Screws", 10,
			"ScrewsBox", 4,
			"ScrewsCarton", 0.1,
			"SteelBar", 4,
			"SteelBarHalf", 6,
			"SteelBarQuarter", 8,
			"SteelPiece", 10,
			"Whetstone", 10,
			"Wire", 20,
			"Wire", 10,
		},
		junk = {
			rolls = 1,
			items = {
				"AluminumFragments", 4,
			}
		}
	},

	WoodcraftDudeCounter = {
		rolls = 4,
		items = {
			-- Misc.
			"Comb", 20,
			"Mirror", 20,
			"Photo_Racy", 50,
			"Photo_Racy", 20,
			-- Tools
			"CarpentryChisel", 2,
			"ClubHammer", 1,
			"GardenSaw", 4,
			"Hammer", 4,
			"HandAxe", 4,
			"HandDrill", 2,
			"OldDrill", 1,
			"Paintbrush", 1,
			"Pliers", 2,
			"Saw", 2,
			"Screwdriver", 4,
			"ViseGrips", 1,
			"WoodenMallet", 2,
			-- Clothing
			"Glasses_SafetyGoggles", 4,
			-- Materials
			"CircularSawblade", 8,
			"DuctTape", 2,
			"Epoxy", 0.5,
			"NailsBox", 2,
			"NailsCarton", 0.1,
			"NutsBolts", 2,
			"ScrewsBox", 2,
			"ScrewsCarton", 0.1,
			"Woodglue", 2,
		},
		junk = {
			rolls = 1,
			items = {
				"Cologne", 200,
				"MeasuringTape", 4,
			}
		}
	},

	-- Gas station shirt rack.
	ZippeeClothing = {
		rolls = 4,
		items = {
			"Shirt_HawaiianTINT", 10,
			"Tshirt_DefaultDECAL_TINT", 8,
			"Tshirt_DefaultTEXTURE_TINT", 8,
			"Tshirt_IndieStoneDECAL", 6,
			"Tshirt_PoloStripedTINT", 6,
			"Tshirt_PoloTINT", 6,
			"Tshirt_Rock", 10,
			"Tshirt_SpiffoDECAL", 0.001,
			"Tshirt_Sport", 10,
			"Tshirt_SportDECAL", 10,
			"Tshirt_WhiteTINT", 20,
			"Tshirt_WhiteTINT", 10,
			"Vest_DefaultTEXTURE_TINT", 10,
		},
		junk = {
			rolls = 1,
			items = {

			}
		}
	},

}
--
--	all = clothingStores;
--
--	clothesstore = clothingStores;


--table.insert(ProceduralDistributions.list, distributionTable);

--for mod compat:
--ProceduralDistributions = distributionTable;
