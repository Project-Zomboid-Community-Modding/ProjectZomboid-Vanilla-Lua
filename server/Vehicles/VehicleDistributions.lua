VehicleDistributions = VehicleDistributions or {}

VehicleDistributions.GloveBox = {
	rolls = 1,
	items = {
		
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.TrunkStandard = {
	rolls = 1,
	items = {
		"NormalTire1", 0.5,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.TrunkHeavy = {
	rolls = 1,
	items = {
		"Cooler_Beer", 0.1,
		"NormalTire2", 0.5,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.TrunkSports = {
	rolls = 1,
	items = {
		"Cooler_Beer", 0.1,
		"HottieZ", 4,
		"NormalTire3", 0.5,
		"TrophyBronze", 1,
		"TrophyGold", 0.05,
		"TrophySilver", 0.1,
	},
	junk = ClutterTables.TrunkJunk,
}

-- Pretty sure this is deprecated but need to check.
VehicleDistributions.EmptySeat = {
	rolls = 1,
	items = {
		
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

VehicleDistributions.DriverSeat = {
	rolls = 1,
	items = {
		
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.Seat = {
	rolls = 1,
	items = {
		
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.SeatRear = {
	rolls = 1,
	items = {
		
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.NormalStandard = {
	TruckBed = VehicleDistributions.TrunkStandard;
	
	TrailerTrunk = VehicleDistributions.TrunkStandard;
	
	GloveBox = VehicleDistributions.GloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontLeft = VehicleDistributions.Seat;
	SeatRearLeft = VehicleDistributions.SeatRear;
	SeatRearRight = VehicleDistributions.SeatRear;
}

VehicleDistributions.NormalHeavy = {
	TruckBed = VehicleDistributions.TrunkHeavy;
	
	TruckBedOpen = VehicleDistributions.TrunkHeavy;
	
	TrailerTrunk = VehicleDistributions.TrunkHeavy;
	
	GloveBox = VehicleDistributions.GloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontLeft = VehicleDistributions.Seat;
	SeatRearLeft = VehicleDistributions.SeatRear;
	SeatRearRight = VehicleDistributions.SeatRear;
}

VehicleDistributions.LuxuryGloveBox = {
	rolls = 1,
	items = {
		"Book_Rich", 2,
		"BusinessCard", 1,
		"CameraExpensive", 10,
		"CameraFilm", 10,
		"CordlessPhone", 10,
		"Corkscrew", 1,
		"CreditCard", 10,
		"Diary2", 10,
		"Flask", 0.5,
		"Glasses_MonocleLeft", 0.001,
		"Gloves_FingerlessLeatherGloves", 1,
		"Gloves_LeatherGloves", 1,
		"Gloves_LeatherGlovesBlack", 1,
		"Hat_PeakedCapYacht", 0.01,
		"Lighter", 4,
		"Magazine_Rich", 10,
		"MenuCard", 10,
		"Money", 20,
		"Money", 10,
		"Paperback_Rich", 8,
		"Paperwork", 20,
		"Paperwork", 10,
		"PenFancy", 2,
		"Pills", 1,
		"PillsAntiDep", 1,
		"PillsBeta", 1,
		"PillsSleepingTablets", 1,
		"Pistol2", 0.8,
		"Pistol3", 0.6,
		"Pocketwatch", 2,
		"PokerChips", 10,
		"Revolver", 0.8,
		"ParkingTicket", 20,
		"ParkingTicket", 10,
		"SpeedingTicket", 20,
		"SpeedingTicket", 10,
		"StockCertificate", 2,
		"StockCertificate", 1,
		"WristWatch_Left_Expensive", 0.001,
		"Whiskey", 0.5,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.LuxuryTruckBed = {
	rolls = 4,
	items = {
		"Bag_FluteCase", 0.5,
		"Bag_GolfBag", 0.1,
		"Bag_MoneyBag", 0.001,
		"Bag_PicnicBasket", 0.1,
		"Bag_SatchelPhoto", 0.1,
		"Bag_SaxophoneCase", 0.5,
		"Bag_TennisBag", 0.1,
		"Bag_TrumpetCase", 0.5,
		"Bag_ViolinCase", 0.5,
		"Briefcase", 1,
		"Briefcase_Money", 0.001,
		"Flask", 1,
		"NormalTire3", 0.5,
		"Shoes_Random", 1,
		"TrophyBronze", 1,
		"TrophyGold", 0.01,
		"TrophySilver", 0.5,
		"Trousers_Suit", 0.5,
		"Trousers_WhiteTINT", 0.5,
		"Whiskey", 1,
		"Wine", 1,
		"Wine2", 1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.LuxurySeat = {
	rolls = 1,
	items = {
		"Bag_FluteCase", 0.5,
		"Bag_SaxophoneCase", 0.5,
		"Bag_TennisBag", 0.1,
		"Bag_TrumpetCase", 0.5,
		"Bag_ViolinCase", 0.5,
		"Book_Rich", 2,
		"Briefcase", 1,
		"Cigar", 1,
		"Flask", 1,
		"Hat_BaseballCap_WestMapleCountryClub", 0.01,
		"Hat_PeakedCapYacht", 0.01,
		"Lighter", 4,
		"Magazine_Rich", 10,
		"Money", 10,
		"PenFancy", 2,
		"Paperback_Rich", 8,
		"Pills", 1,
		"PillsAntiDep", 1,
		"PillsBeta", 1,
		"PillsSleepingTablets", 1,
		"Pocketwatch", 2,
		"Suitcase", 1,
		"Suit_Jacket", 0.1,
		"Suit_JacketTINT", 0.5,
		"Tie_Full", 1,
		"Trousers_Suit", 0.5,
		"Trousers_WhiteTINT", 0.5,
		"Whiskey", 1,
		"Wine", 1,
		"Wine2", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.LuxurySeatRear = {
	rolls = 1,
	items = {
		"Bag_FluteCase", 0.5,
		"Bag_GolfBag", 0.1,
		"Bag_SatchelPhoto", 0.1,
		"Bag_SaxophoneCase", 0.5,
		"Bag_TennisBag", 0.1,
		"Bag_TennisBag", 0.1,
		"Bag_TrumpetCase", 0.5,
		"Bag_ViolinCase", 0.5,
		"Book_Rich", 2,
		"Briefcase", 1,
		"Cigar", 1,
		"Flask", 1,
		"Hat_BaseballCap_WestMapleCountryClub", 0.01,
		"Hat_PeakedCapYacht", 0.01,
		"Magazine_Rich", 10,
		"Money", 10,
		"Paperback_Rich", 8,
		"PenFancy", 2,
		"Pills", 1,
		"PillsAntiDep", 1,
		"PillsBeta", 1,
		"PillsSleepingTablets", 1,
		"Pocketwatch", 2,
		"Shoes_Random", 1,
		"Suit_Jacket", 0.1,
		"Suit_JacketTINT", 0.5,
		"Tie_Full", 1,
		"Trousers_Suit", 0.5,
		"Trousers_WhiteTINT", 0.5,
		"Whiskey", 1,
		"Wine", 1,
		"Wine2", 1,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.NormalLuxury = {
	TruckBed = VehicleDistributions.LuxuryTruckBed;
	TruckBedOpen = VehicleDistributions.LuxuryTruckBed;
	
	GloveBox = VehicleDistributions.LuxuryGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.LuxurySeat;
	SeatRearLeft = VehicleDistributions.LuxurySeatRear;
	SeatRearRight = VehicleDistributions.LuxurySeatRear;
}

VehicleDistributions.SportsGloveBox = {
	rolls = 1,
	items = {
		"BeerBottle", 1,
		"BeerCan", 1,
		"Book_Rich", 1,
		"Book_Sports", 2,
		"Brochure", 1,
		"Camera", 0.5,
		"CardDeck", 8,
		"Cigar", 0.5,
		"CigaretteRollingPapers", 1,
		"Dice", 8,
		"ElbowPad_Left_Sport", 0.1,
		"Firecracker", 0.1,
		"Flask", 0.5,
		"Flier", 1,
		"Garter", 1,
		"Glasses", 2,
		"Glasses_Aviators", 2,
		"Glasses_Macho", 0.1,
		"Glasses_Sun", 2,
		"Gloves_FingerlessLeatherGloves", 1,
		"Gloves_LeatherGloves", 1,
		"Gloves_LeatherGlovesBlack", 1,
		"HottieZ", 1,
		"IDcard", 1,
        "KeyRing_Clover", 0.005,
		"KeyRing_RabbitFoot", 1,
		"KnifeButterfly", 0.1,
		"Kneepad_Left_Sport", 1,
		"Lighter", 4,
		"Magazine_Car", 8,
		"Magazine_Rich", 4,
		"Magazine_Sports", 8,
		"Paperback_Rich", 4,
		"Paperback_Sports", 8,
		"Pills", 1,
		"PillsAntiDep", 1,
		"PillsBeta", 1,
		"PillsSleepingTablets", 1,
		"Pistol2", 0.8,
		"Pistol3", 0.6,
		"PokerChips", 10,
		"Revolver", 0.8,
		"RubberSpider", 0.1,
		"ScratchTicket", 1,
		"ScratchTicket_Loser", 1,
		"ScratchTicket_Winner", 1,
		"SpeedingTicket", 50,
		"SpeedingTicket", 20,
		"SpeedingTicket", 20,
		"SpeedingTicket", 10,
		"SwitchKnife", 0.1,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
		"Whiskey", 0.5,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.NormalSports = {
	TruckBed = VehicleDistributions.TrunkSports;
	TruckBedOpen = VehicleDistributions.TrunkSports;
	
	GloveBox = VehicleDistributions.SportsGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.Seat;
	SeatRearLeft = VehicleDistributions.SeatRear;
	SeatRearRight = VehicleDistributions.SeatRear;
}

VehicleDistributions.SurvivalistGloveBox = {
	rolls = 1,
	items = {
		-- Tools/Knives
		"Fleshing_Tool", 1,
		"Handiknife", 1,
		"HuntingKnife", 8,
		"KnifePocket", 1,
		"Multitool", 0.1,
		"Pliers", 8,
		-- Guns
		"Pistol", 4,
		"Pistol2", 3,
		"Pistol3", 2,
		"Revolver", 3,
		"Revolver_Long", 2,
		"Revolver_Short", 4,
		-- Accessories
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"Bag_ALICE_BeltSus_Camo", 0.5,
		"Bag_ALICE_BeltSus_Green", 0.5,
		"Bag_ChestRig", 1,
		"Canteen", 10,
		"ElbowPad_Left_Military", 0.5,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 1,
		"Hat_GasMask", 0.5,
		"Hat_ImprovisedGasMask", 4,
		"Kneepad_Left_Military", 2,
		"WalkieTalkie5", 10,
		"WaterRationCan", 4,
		"WristWatch_Left_ClassicMilitary", 1,
		-- Snacks
		"BeefJerky", 8,
		"Chocolate", 8,
		-- Tobacco/Smoking
		"CigaretteCarton", 0.1,
		"CigaretteRollingPapers", 1,
		"Lighter", 1,
		"LighterDisposable", 4,
		"MagnesiumFirestarter", 10,
		"Matchbox", 2,
		"Matches", 8,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
		-- Survival
		"Candle", 10,
		"CompassDirectional", 10,
		"CopperCup", 0.5,
		"FirstAidKit_Military", 8,
		"InsectRepellent", 10,
		"MetalCup", 1,
		"P38", 10,
		"PillsVitamins", 10,
		"SewingKit", 10,
		"Spork", 10,
		"WaterPurificationTablets", 10,
		"Whetstone", 10,
		-- Clothing
		"Gloves_FingerlessLeatherGloves", 8,
		"Gloves_LeatherGloves", 6,
		"Gloves_LeatherGlovesBlack", 4,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"ShemaghScarf_Green", 1,
		"Socks_Heavy", 10,
		-- Materials/Fuel
		"Propane_Refill", 8,
		"RubberHose", 10,
		"Twine", 10,
		-- Misc.
		"BottleOpener", 10,
		"Funnel", 8,
		"IDcard", 1,
		"IDcard_Blank", 0.001,
		"KeyRing_EagleFlag", 1,
		"MagnifyingGlass", 0.5,
		-- Literature (Skill Books)
		"BookAiming4", 0.1,
		"BookAiming5", 0.05,
		"BookCarpentry4", 0.1,
		"BookCarpentry5", 0.05,
		"BookCarving4", 0.1,
		"BookCarving5", 0.05,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"BookFlintKnapping4", 0.1,
		"BookFlintKnapping5", 0.05,
		"BookMaintenance4", 0.1,
		"BookMaintenance5", 0.05,
		"BookMasonry4", 0.1,
		"BookMasonry5", 0.05,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"BookMetalWelding4", 0.1,
		"BookMetalWelding5", 0.05,
		"BookPottery4", 0.1,
		"BookPottery5", 0.05,
		"BookReloading4", 0.1,
		"BookReloading5", 0.05,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		-- Literature (Recipes)
		"ArmorMag2", 1,
		"ArmorMag3", 1,
		"ArmorMag7", 1,
		"ArmorSchematic", 1,
		"BSToolsSchematic", 1,
		"CookwareSchematic", 1,
		"ElectronicsMag1", 1,
		"ElectronicsMag2", 1,
		"ElectronicsMag3", 1,
		"ElectronicsMag4", 0.1,
		"ElectronicsMag4", 1,
		"ElectronicsMag5", 1,
		"EngineerMagazine1", 1,
		"EngineerMagazine2", 1,
		"ExplosiveSchematic", 1,
		"FarmingMag5", 1,
		"FishingMag1", 1,
		"FishingMag2", 1,
		"HempMag1", 2,
		"HerbalistMag", 4,
		"HuntingMag1", 1,
		"HuntingMag2", 1,
		"HuntingMag3", 1,
		"KeyMag1", 1,
		"MechanicMag2", 1,
		"MeleeWeaponSchematic", 1,
		"PrimitiveToolMag1", 1,
		"PrimitiveToolMag2", 1,
		"PrimitiveToolMag3", 1,
		"SmithingMag1", 0.1,
		"SmithingMag10", 0.1,
		"SmithingMag11", 0.1,
		"SmithingMag2", 0.1,
		"SmithingMag3", 0.1,
		"SmithingMag4", 0.1,
		"SmithingMag5", 0.1,
		"SmithingMag6", 0.1,
		"SmithingMag7", 0.1,
		"SmithingMag8", 0.1,
		"SmithingMag9", 0.1,
		"SurvivalSchematic", 8,
		"TrickMag1", 1,
		"WeaponMag1", 1,
		"WeaponMag2", 1,
		"WeaponMag3", 1,
		"WeaponMag4", 1,
		"WeaponMag5", 1,
		"WeaponMag6", 1,
		-- Literature (Generic)
		"Book_Bible", 2,
		"Magazine_Firearm", 4,
		"Magazine_Military", 4,
		"Paperback_Bible", 6,
		"Paperback_Conspiracy", 6,
		"Paperback_Hass", 4,
		"Paperback_Quigley", 4,
		-- Bags/Containers
		"Bag_ProtectiveCaseSmall_Pistol1", 4,
		"Bag_ProtectiveCaseSmall_Pistol2", 3,
		"Bag_ProtectiveCaseSmall_Pistol3", 2,
		"Bag_ProtectiveCaseSmall_Revolver1", 4,
		"Bag_ProtectiveCaseSmall_Revolver2", 3,
		"Bag_ProtectiveCaseSmall_Revolver3", 2,
		"Bag_ProtectiveCaseSmall_Survivalist", 0.5,
		"Bag_ProtectiveCaseSmallMilitary_FirstAid", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.SurvivalistTruckBed = {
	rolls = 4,
	items = {
		-- Traps/Explosives
		"Aerosolbomb", 10,
		"SmokeBomb", 10,
		"PipeBomb", 6,
		"FlameTrap", 4,
		"NoiseTrap", 10,
		-- Tools
		"BoltCutters", 10,
		"Fleshing_Tool", 10,
		"Machete", 1,
		"Pliers", 8,
		"Sledgehammer", 0.5,
		-- Accessories
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 4,
		"Hat_GasMask", 1,
		-- Food
		"CannedBellPepper", 6,
		"CannedBroccoli", 6,
		"CannedCabbage", 6,
		"CannedCarrots", 6,
		"CannedEggplant", 6,
		"CannedLeek", 6,
		"CannedPotato", 6,
		"CannedRedRadish", 6,
		"CannedTomato", 6,
		"Crisps", 10,
		"Crisps2", 10,
		"Crisps3", 10,
		"Crisps4", 10,
		"Dogfood", 10,
		-- Snacks
		"BeefJerky", 8,
		"Chocolate", 8,
		-- Tobacco/Smoking
		"CigaretteCarton", 0.1,
		-- Survival
		"Candle", 10,
		"Canteen", 10,
		"FirewoodBundle", 4,
		"InsectRepellent", 10,
		"Lantern_Hurricane", 1,
		"Lantern_Propane", 4,
		"P38", 10,
		"WaterDispenserBottle", 1,
		"WaterPurificationTablets", 10,
		"WaterRationCan_Box", 1,
		"Whetstone", 10,
		-- Tents/Sleeping Bags
		"SleepingBag_BluePlaid_Packed", 2,
		"SleepingBag_Camo_Packed", 1,
		"SleepingBag_Cheap_Blue_Packed", 4,
		"SleepingBag_Cheap_Green2_Packed", 4,
		"SleepingBag_Cheap_Green_Packed", 4,
		"SleepingBag_GreenPlaid_Packed", 2,
		"SleepingBag_Green_Packed", 2,
		"SleepingBag_HighQuality_Brown_Packed", 1,
		"SleepingBag_RedPlaid_Packed", 2,
		"SleepingBag_Spiffo_Packed", 1,
		"TentBlue_Packed", 1,
		"TentBrown_Packed", 1,
		"TentGreen_Packed", 1,
		"TentYellow_Packed", 1,
		-- Materials
		"JerryCan", 10,
		"PetrolCan", 10,
		"Propane_Refill", 8,
		"Rope", 10,
		"RubberHose", 10,
		-- Misc.
		"BaseballBat", 10,
		"CarBatteryCharger", 6,
		"Funnel", 10,
		"Generator", 0.1,
		"Mov_Cot", 4,
		"Mov_FlagUSA", 1,
		-- Literature (Skill Books)
		"BookAiming4", 0.1,
		"BookAiming5", 0.05,
		"BookCarpentry4", 0.1,
		"BookCarpentry5", 0.05,
		"BookCarving4", 0.1,
		"BookCarving5", 0.05,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"BookFlintKnapping4", 0.1,
		"BookFlintKnapping5", 0.05,
		"BookMaintenance4", 0.1,
		"BookMaintenance5", 0.05,
		"BookMasonry4", 0.1,
		"BookMasonry5", 0.05,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"BookMetalWelding4", 0.1,
		"BookMetalWelding5", 0.05,
		"BookPottery4", 0.1,
		"BookPottery5", 0.05,
		"BookReloading4", 0.1,
		"BookReloading5", 0.05,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		-- Literature (Recipes)
		"ArmorMag2", 1,
		"ArmorMag3", 1,
		"ArmorMag7", 1,
		"ArmorSchematic", 1,
		"BSToolsSchematic", 1,
		"CookwareSchematic", 1,
		"ElectronicsMag1", 1,
		"ElectronicsMag2", 1,
		"ElectronicsMag3", 1,
		"ElectronicsMag4", 0.1,
		"ElectronicsMag4", 1,
		"ElectronicsMag5", 1,
		"EngineerMagazine1", 1,
		"EngineerMagazine2", 1,
		"ExplosiveSchematic", 1,
		"FarmingMag5", 1,
		"FishingMag1", 1,
		"FishingMag2", 1,
		"HempMag1", 2,
		"HerbalistMag", 4,
		"HuntingMag1", 1,
		"HuntingMag2", 1,
		"HuntingMag3", 1,
		"KeyMag1", 1,
		"MechanicMag2", 1,
		"MeleeWeaponSchematic", 1,
		"PrimitiveToolMag1", 1,
		"PrimitiveToolMag2", 1,
		"PrimitiveToolMag3", 1,
		"SmithingMag1", 0.1,
		"SmithingMag10", 0.1,
		"SmithingMag11", 0.1,
		"SmithingMag2", 0.1,
		"SmithingMag3", 0.1,
		"SmithingMag4", 0.1,
		"SmithingMag5", 0.1,
		"SmithingMag6", 0.1,
		"SmithingMag7", 0.1,
		"SmithingMag8", 0.1,
		"SmithingMag9", 0.1,
		"SurvivalSchematic", 4,
		"TrickMag1", 1,
		"WeaponMag1", 1,
		"WeaponMag2", 1,
		"WeaponMag3", 1,
		"WeaponMag4", 1,
		"WeaponMag5", 1,
		"WeaponMag6", 1,
		-- Bags/Containers
		"Bag_ALICEpack", 0.01,
		"Bag_ALICE_BeltSus_Camo", 0.5,
		"Bag_ALICE_BeltSus_Green", 0.5,
		"Bag_AmmoBox_Mixed", 10,
		"Bag_BigHikingBag", 0.05,
		"Bag_ChestRig", 1,
		"Bag_DuffelBagTINT", 0.5,
		"Bag_FoodCanned", 10,
		"Bag_FoodSnacks", 10,
		"Bag_MedicalBag", 10,
		"Bag_NormalHikingBag", 0.1,
		"Bag_ProtectiveCaseBulkyAmmo", 1,
		"Bag_ProtectiveCaseBulky_Survivalist", 1,
		"Bag_ProtectiveCaseMilitary_Tools", 4,
		"Bag_ProtectiveCaseSmallMilitary_FirstAid", 10,
		"Bag_ProtectiveCaseSmall_Survivalist", 4,
		"Bag_ProtectiveCase_Survivalist", 2,
		"Bag_ShotgunBag", 0.5,
		"Bag_ShotgunCaseCloth", 0.25,
		"Bag_ShotgunCaseCloth2", 0.25,
		"Bag_ShotgunDblBag", 0.5,
		"Bag_ShotgunDblSawnoffBag", 1,
		"Bag_ShotgunSawnoffBag", 1,
		"Bag_ToolBag", 6,
		"Bag_WeaponBag", 1,
		"ShotgunCase1", 0.25,
		"ShotgunCase2", 0.25,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.SurvivalistSeatFront = {
	rolls = 1,
	items = {
		-- Traps/Explosives
		"Aerosolbomb", 10,
		"FlameTrap", 4,
		"NoiseTrap", 10,
		"PipeBomb", 6,
		"SmokeBomb", 10,
		-- Tools/Knives
		"Fleshing_Tool", 1,
		"Handiknife", 1,
		"KnifePocket", 1,
		"Machete", 1,
		"Multitool", 0.1,
		"Pliers", 8,
		"Sledgehammer", 0.5,
		-- Accessories
		"GasmaskFilter", 4,
		"Hat_GasMask", 1,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"Kneepad_Left_Military", 2,
		"FlashLight_AngleHead_Army", 1,
		"ElbowPad_Left_Military", 0.5,
		-- Food
		"CannedBellPepper", 6,
		"CannedBroccoli", 6,
		"CannedCabbage", 6,
		"CannedCarrots", 6,
		"CannedEggplant", 6,
		"CannedLeek", 6,
		"CannedPotato", 6,
		"CannedRedRadish", 6,
		"CannedTomato", 6,
		-- Tobacco/Smoking
		"CigaretteCarton", 0.1,
		"Lighter", 4,
		-- Survival
		"CopperCup", 0.5,
		"Lantern_Hurricane", 1,
		"Lantern_Propane", 4,
		"MetalCup", 1,
		"P38", 10,
		"PillsVitamins", 10,
		"SewingKit", 10,
		"WalkieTalkie5", 10,
		"Whetstone", 10,
		"WristWatch_Left_ClassicMilitary", 1,
		-- Sleeping Bags
		"SleepingBag_BluePlaid_Packed", 2,
		"SleepingBag_Camo_Packed", 1,
		"SleepingBag_Cheap_Blue_Packed", 4,
		"SleepingBag_Cheap_Green2_Packed", 4,
		"SleepingBag_Cheap_Green_Packed", 4,
		"SleepingBag_GreenPlaid_Packed", 2,
		"SleepingBag_Green_Packed", 2,
		"SleepingBag_HighQuality_Brown_Packed", 1,
		"SleepingBag_Spiffo_Packed", 1,
		"SleepingBag_RedPlaid_Packed", 2,
		-- Clothing
		"ShemaghScarf_Green", 1,
		"Shoes_ArmyBoots", 1,
		"Shoes_HikingBoots", 4,
		"Shoes_Wellies", 2,
		"Shoes_WorkBoots", 4,
		"Socks_Heavy", 10,
		"PonchoGreenDOWN", 6,
		"Dungarees", 6,
		-- Materials/Fuel
		"Propane_Refill", 8,
		"RubberHose", 10,
		"Twine", 10,
		-- Misc.
		"KeyRing_EagleFlag", 1,
		"Mov_FlagUSA", 1,
		"MagnifyingGlass", 0.1,
		-- Literature (Skill Books)
		"BookAiming4", 0.1,
		"BookAiming5", 0.05,
		"BookCarpentry4", 0.1,
		"BookCarpentry5", 0.05,
		"BookCarving4", 0.1,
		"BookCarving5", 0.05,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"BookFlintKnapping4", 0.1,
		"BookFlintKnapping5", 0.05,
		"BookMaintenance4", 0.1,
		"BookMaintenance5", 0.05,
		"BookMasonry4", 0.1,
		"BookMasonry5", 0.05,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"BookMetalWelding4", 0.1,
		"BookMetalWelding5", 0.05,
		"BookPottery4", 0.1,
		"BookPottery5", 0.05,
		"BookReloading4", 0.1,
		"BookReloading5", 0.05,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		-- Literature (Recipes)
		"ArmorMag2", 1,
		"ArmorMag3", 1,
		"ArmorMag7", 1,
		"ArmorSchematic", 1,
		"BSToolsSchematic", 1,
		"CookwareSchematic", 1,
		"ElectronicsMag1", 1,
		"ElectronicsMag2", 1,
		"ElectronicsMag3", 1,
		"ElectronicsMag4", 0.1,
		"ElectronicsMag4", 1,
		"ElectronicsMag5", 1,
		"EngineerMagazine1", 1,
		"EngineerMagazine2", 1,
		"ExplosiveSchematic", 1,
		"FarmingMag5", 1,
		"FishingMag1", 1,
		"FishingMag2", 1,
		"HempMag1", 2,
		"HerbalistMag", 4,
		"HuntingMag1", 1,
		"HuntingMag2", 1,
		"HuntingMag3", 1,
		"KeyMag1", 1,
		"MechanicMag2", 1,
		"MeleeWeaponSchematic", 1,
		"PrimitiveToolMag1", 1,
		"PrimitiveToolMag2", 1,
		"PrimitiveToolMag3", 1,
		"SmithingMag1", 0.1,
		"SmithingMag10", 0.1,
		"SmithingMag11", 0.1,
		"SmithingMag2", 0.1,
		"SmithingMag3", 0.1,
		"SmithingMag4", 0.1,
		"SmithingMag5", 0.1,
		"SmithingMag6", 0.1,
		"SmithingMag7", 0.1,
		"SmithingMag8", 0.1,
		"SmithingMag9", 0.1,
		"SurvivalSchematic", 8,
		"TrickMag1", 1,
		"WeaponMag1", 1,
		"WeaponMag2", 1,
		"WeaponMag3", 1,
		"WeaponMag4", 1,
		"WeaponMag5", 1,
		"WeaponMag6", 1,
		-- Literature (Generic)
		"Book_Bible", 2,
		"Magazine_Firearm", 4,
		"Magazine_Military", 4,
		"Paperback_Bible", 6,
		"Paperback_Conspiracy", 6,
		"Paperback_Hass", 4,
		"Paperback_Quigley", 4,
		-- Bags/Containers
		"Bag_ALICE_BeltSus_Camo", 0.5,
		"Bag_ALICE_BeltSus_Green", 0.5,
		"Bag_ALICEpack", 0.01,
		"Bag_AmmoBox_Mixed", 1,
		"Bag_BigHikingBag", 0.05,
		"Bag_ChestRig", 1,
		"Bag_DuffelBagTINT", 0.5,
		"Bag_FoodCanned", 10,
		"Bag_FoodSnacks", 10,
		"Bag_MedicalBag", 10,
		"Bag_NormalHikingBag", 0.1,
		"Bag_ProtectiveCase_Survivalist", 2,
		"Bag_ProtectiveCaseBulky_Survivalist", 1,
		"Bag_ProtectiveCaseMilitary_Tools", 4,
		"Bag_ProtectiveCaseSmall_Survivalist", 4,
		"Bag_ProtectiveCaseSmallMilitary_FirstAid", 10,
		"Bag_ProtectiveCaseSmallMilitary_WalkieTalkie", 4,
		"Bag_ShotgunBag", 0.5,
		"Bag_ShotgunDblBag", 0.5,
		"Bag_ShotgunCaseCloth", 0.25,
		"Bag_ShotgunCaseCloth2", 0.25,
		"Bag_ShotgunDblSawnoffBag", 1,
		"Bag_ShotgunSawnoffBag", 1,
		"Bag_ToolBag", 6,
		"ShotgunCase1", 0.25,
		"ShotgunCase2", 0.25,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.SurvivalistSeatRear = {
	rolls = 1,
	items = {
		-- Traps/Explosives
		"Aerosolbomb", 10,
		"FlameTrap", 4,
		"NoiseTrap", 10,
		"PipeBomb", 6,
		"SmokeBomb", 10,
		-- Tools/Knives
		"Fleshing_Tool", 1,
		"Handiknife", 1,
		"KnifePocket", 1,
		"Machete", 1,
		"Multitool", 0.1,
		"Pliers", 8,
		"Sledgehammer", 0.5,
		-- Accessories
		"GasmaskFilter", 4,
		"Hat_GasMask", 1,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"Kneepad_Left_Military", 2,
		"FlashLight_AngleHead_Army", 1,
		"ElbowPad_Left_Military", 0.5,
		-- Food
		"CannedBellPepper", 6,
		"CannedBroccoli", 6,
		"CannedCabbage", 6,
		"CannedCarrots", 6,
		"CannedEggplant", 6,
		"CannedLeek", 6,
		"CannedPotato", 6,
		"CannedRedRadish", 6,
		"CannedTomato", 6,
		-- Tobacco/Smoking
		"CigaretteCarton", 0.1,
		"Lighter", 4,
		-- Survival
		"CopperCup", 0.5,
		"Lantern_Hurricane", 1,
		"Lantern_Propane", 4,
		"MetalCup", 1,
		"P38", 10,
		"PillsVitamins", 10,
		"SewingKit", 10,
		"WalkieTalkie5", 10,
		"Whetstone", 10,
		"WristWatch_Left_ClassicMilitary", 1,
		-- Sleeping Bags
		"SleepingBag_BluePlaid_Packed", 2,
		"SleepingBag_Camo_Packed", 1,
		"SleepingBag_Cheap_Blue_Packed", 4,
		"SleepingBag_Cheap_Green2_Packed", 4,
		"SleepingBag_Cheap_Green_Packed", 4,
		"SleepingBag_GreenPlaid_Packed", 2,
		"SleepingBag_Green_Packed", 2,
		"SleepingBag_HighQuality_Brown_Packed", 1,
		"SleepingBag_Spiffo_Packed", 1,
		"SleepingBag_RedPlaid_Packed", 2,
		-- Clothing
		"ShemaghScarf_Green", 1,
		"Shoes_ArmyBoots", 1,
		"Shoes_HikingBoots", 4,
		"Shoes_Wellies", 2,
		"Shoes_WorkBoots", 4,
		"Socks_Heavy", 10,
		"PonchoGreenDOWN", 6,
		"Dungarees", 6,
		-- Materials/Fuel
		"Propane_Refill", 8,
		"RubberHose", 10,
		"Twine", 10,
		-- Misc.
		"KeyRing_EagleFlag", 1,
		"Mov_FlagUSA", 1,
		"MagnifyingGlass", 0.1,
		-- Literature (Skill Books)
		"BookAiming4", 0.1,
		"BookAiming5", 0.05,
		"BookCarpentry4", 0.1,
		"BookCarpentry5", 0.05,
		"BookCarving4", 0.1,
		"BookCarving5", 0.05,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"BookFlintKnapping4", 0.1,
		"BookFlintKnapping5", 0.05,
		"BookMaintenance4", 0.1,
		"BookMaintenance5", 0.05,
		"BookMasonry4", 0.1,
		"BookMasonry5", 0.05,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"BookMetalWelding4", 0.1,
		"BookMetalWelding5", 0.05,
		"BookPottery4", 0.1,
		"BookPottery5", 0.05,
		"BookReloading4", 0.1,
		"BookReloading5", 0.05,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		-- Literature (Recipes)
		"ArmorMag2", 1,
		"ArmorMag3", 1,
		"ArmorMag7", 1,
		"ArmorSchematic", 1,
		"BSToolsSchematic", 1,
		"CookwareSchematic", 1,
		"ElectronicsMag1", 1,
		"ElectronicsMag2", 1,
		"ElectronicsMag3", 1,
		"ElectronicsMag4", 0.1,
		"ElectronicsMag4", 1,
		"ElectronicsMag5", 1,
		"EngineerMagazine1", 1,
		"EngineerMagazine2", 1,
		"ExplosiveSchematic", 1,
		"FarmingMag5", 1,
		"FishingMag1", 1,
		"FishingMag2", 1,
		"HempMag1", 2,
		"HerbalistMag", 4,
		"HuntingMag1", 1,
		"HuntingMag2", 1,
		"HuntingMag3", 1,
		"KeyMag1", 1,
		"MechanicMag2", 1,
		"MeleeWeaponSchematic", 1,
		"PrimitiveToolMag1", 1,
		"PrimitiveToolMag2", 1,
		"PrimitiveToolMag3", 1,
		"SmithingMag1", 0.1,
		"SmithingMag10", 0.1,
		"SmithingMag11", 0.1,
		"SmithingMag2", 0.1,
		"SmithingMag3", 0.1,
		"SmithingMag4", 0.1,
		"SmithingMag5", 0.1,
		"SmithingMag6", 0.1,
		"SmithingMag7", 0.1,
		"SmithingMag8", 0.1,
		"SmithingMag9", 0.1,
		"SurvivalSchematic", 8,
		"TrickMag1", 1,
		"WeaponMag1", 1,
		"WeaponMag2", 1,
		"WeaponMag3", 1,
		"WeaponMag4", 1,
		"WeaponMag5", 1,
		"WeaponMag6", 1,
		-- Literature (Generic)
		"Book_Bible", 2,
		"Magazine_Firearm", 4,
		"Magazine_Military", 4,
		"Paperback_Bible", 6,
		"Paperback_Conspiracy", 6,
		"Paperback_Hass", 4,
		"Paperback_Quigley", 4,
		-- Bags/Containers
		"Bag_ALICE_BeltSus_Camo", 0.5,
		"Bag_ALICE_BeltSus_Green", 0.5,
		"Bag_ALICEpack", 0.01,
		"Bag_AmmoBox_Mixed", 1,
		"Bag_BigHikingBag", 0.05,
		"Bag_ChestRig", 1,
		"Bag_DuffelBagTINT", 0.5,
		"Bag_FoodCanned", 10,
		"Bag_FoodSnacks", 10,
		"Bag_MedicalBag", 10,
		"Bag_NormalHikingBag", 0.1,
		"Bag_ProtectiveCase_Survivalist", 2,
		"Bag_ProtectiveCaseBulky_Survivalist", 1,
		"Bag_ProtectiveCaseMilitary_Tools", 4,
		"Bag_ProtectiveCaseSmall_Survivalist", 4,
		"Bag_ProtectiveCaseSmallMilitary_FirstAid", 10,
		"Bag_ProtectiveCaseSmallMilitary_WalkieTalkie", 4,
		"Bag_ShotgunBag", 0.5,
		"Bag_ShotgunDblBag", 0.5,
		"Bag_ShotgunCaseCloth", 0.25,
		"Bag_ShotgunCaseCloth2", 0.25,
		"Bag_ShotgunDblSawnoffBag", 1,
		"Bag_ShotgunSawnoffBag", 1,
		"Bag_ToolBag", 6,
		"ShotgunCase1", 0.25,
		"ShotgunCase2", 0.25,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Survivalist = {
	specificId = "Survivalist";
	
	TruckBed = VehicleDistributions.SurvivalistTruckBed;
	
	TruckBedOpen = VehicleDistributions.SurvivalistTruckBed;
	
	TrailerTrunk = VehicleDistributions.SurvivalistTruckBed;
	
	GloveBox = VehicleDistributions.SurvivalistGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.SurvivalistSeatFront;
	SeatRearLeft = VehicleDistributions.SurvivalistSeatRear;
	SeatRearRight = VehicleDistributions.SurvivalistSeatRear;
}

VehicleDistributions.FishermanGloveBox = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"Bag_FishingBasket", 2,
		"Bag_Satchel_Fishing", 2,
		"Bobber", 20,
		"Bobber", 10,
		"BookFishing1", 2,
		"BookFishing2", 1,
		"BookFishing3", 0.5,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"BottleOpener", 10,
		"Candle", 10,
		"CanteenCowboy", 10,
		"Chainmail_Hand_L", 1,
		"Chainmail_Hand_R", 0.1,
		"CigaretteRollingPapers", 1,
		"FishingHook", 20,
		"FishingHook", 10,
		"FishingHookBox", 2,
		"FishingLine", 20,
		"FishingLine", 10,
		"FishingMag1", 2,
		"FishingMag2", 2,
		"FishingTackle", 20,
		"FishingTackle", 10,
		"FishingTackle2", 20,
		"FishingTackle2", 10,
		"FlashLight_AngleHead", 1,
		"Flask", 1,
		"Handiknife", 1,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BucketHatFishing", 4,
		"Hat_FishermanRainHat", 0.001,
		"Hat_PeakedCapYacht", 0.001,
		"InsectRepellent", 10,
		"JigLure", 10,
		"KeyRing_Bass", 1,
		"KnifeFillet", 10,
		"KnifePocket", 1,
		"Lighter", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Outdoors", 10,
		"MinnowLure", 10,
		"Multitool", 0.1,
		"Pliers", 8,
		"PremiumFishingLine", 4,
		"ShortBat", 8,
		"Tacklebox", 2,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
		"Twine", 10,
		"WaterPurificationTablets", 1,
		"Whetstone", 4,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.FishermanTruckBed = {
	rolls = 4,
	items = {
		"Bag_FishingBasket", 2,
		"Bag_Satchel_Fishing", 2,
		"Bobber", 20,
		"Bobber", 10,
		"BookFishing1", 2,
		"BookFishing2", 1,
		"BookFishing3", 0.5,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"Candle", 10,
		"CanteenCowboy", 10,
		"Cooler_Beer", 10,
		"FishingHook", 20,
		"FishingHook", 10,
		"FishingHookBox", 2,
		"FishingLine", 20,
		"FishingLine", 10,
		"FishingMag1", 2,
		"FishingMag2", 2,
		"FishingNet", 20,
		"FishingNet", 10,
		"FishingRod", 20,
		"FishingRod", 10,
		"FishingTackle", 20,
		"FishingTackle", 10,
		"FishingTackle2", 20,
		"FishingTackle2", 10,
		"FlashLight_AngleHead", 1,
		"Flask", 1,
		"Gaffhook", 10,
		"InsectRepellent", 10,
		"JigLure", 10,
		"KnifeFillet", 10,
		"MinnowLure", 10,
		"NormalTire2", 0.5,
		"PetrolCan", 4,
		"Pliers", 8,
		"PremiumFishingLine", 4,
		"Shoes_Wellies", 4,
		"ShortBat", 8,
		"Tacklebox", 2,
		"Toolbox_Fishing", 10, 
		"WaterPurificationTablets", 1,
		"Whetstone", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.FishermanSeatFront = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"Bobber", 20,
		"Bobber", 10,
		"BookFishing1", 2,
		"BookFishing2", 1,
		"BookFishing3", 0.5,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"Chainmail_Hand_L", 1,
		"Chainmail_Hand_R", 0.1,
		"FishingLine", 20,
		"FishingLine", 10,
		"FishingHook", 20,
		"FishingHook", 10,
		"FishingHookBox", 2,
		"FishingMag1", 2,
		"FishingMag2", 2,
		"FishingNet", 20,
		"FishingNet", 10,
		"FishingRod", 20,
		"FishingRod", 10,
		"FishingTackle", 20,
		"FishingTackle", 10,
		"FishingTackle2", 20,
		"FishingTackle2", 10,
		"FlashLight_AngleHead", 1,
		"Flask", 1,
		"Handiknife", 1,
		"Hat_BucketHatFishing", 4,
		"Hat_FishermanRainHat", 0.001,
		"Hat_PeakedCapYacht", 0.001,
		"InsectRepellent", 10,
		"JigLure", 10,
		"KeyRing_Bass", 1,
		"KnifePocket", 1,
		"Lighter", 4,
		"Magazine_Outdoors", 10,
		"MinnowLure", 10,
		"Multitool", 0.1,
		"Pliers", 8,
		"PremiumFishingLine", 4,
		"Shoes_Wellies", 4,
		"ShortBat", 8,
		"Twine", 10,
		"Whetstone", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.FishermanSeatRear = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"Bag_FishingBasket", 2,
		"Bag_Satchel_Fishing", 2,
		"Bobber", 20,
		"Bobber", 10,
		"BookFishing1", 2,
		"BookFishing2", 1,
		"BookFishing3", 0.5,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"Chainmail_Hand_L", 1,
		"Chainmail_Hand_R", 0.1,
		"Cooler_Beer", 10,
		"FishingHook", 20,
		"FishingHook", 10,
		"FishingHookBox", 2,
		"FishingLine", 20,
		"FishingLine", 10,
		"FishingNet", 20,
		"FishingNet", 10,
		"FishingRod", 20,
		"FishingRod", 10,
		"FishingTackle", 20,
		"FishingTackle", 10,
		"FishingTackle2", 20,
		"FishingTackle2", 10,
		"FlashLight_AngleHead", 1,
		"Flask", 1,
		"Handiknife", 1,
		"Hat_BucketHatFishing", 4,
		"Hat_FishermanRainHat", 0.001,
		"Hat_PeakedCapYacht", 0.001,
		"InsectRepellent", 10,
		"JigLure", 10,
		"KeyRing_Bass", 1,
		"KnifePocket", 1,
		"Magazine_Outdoors", 8,
		"MinnowLure", 10,
		"Multitool", 0.1,
		"PremiumFishingLine", 4,
		"Shoes_Wellies", 4,
		"ShortBat", 8,
		"Twine", 10,
		"Whetstone", 4,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Fisherman = {
	specificId = "Fisherman";
	
	TruckBed = VehicleDistributions.FishermanTruckBed;
	
	TruckBedOpen = VehicleDistributions.FishermanTruckBed;
	
	TrailerTrunk =  VehicleDistributions.FishermanTruckBed;
	
	GloveBox = VehicleDistributions.FishermanGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.FishermanSeatFront;
}

VehicleDistributions.GroceriesTruckBed = {
	rolls = 4,
	items = {
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"CookingMag1", 0.5,
		"CookingMag2", 0.5,
		"CookingMag3", 0.5,
		"CookingMag4", 0.5,
		"CookingMag5", 0.5,
		"CookingMag6", 0.5,
		"Cooler_Beer", 8,
		"Cooler_Meat", 8,
		"Cooler_Soda", 8,
		"GroceryBag1", 100,
		"GroceryBag1", 50,
		"GroceryBag2", 8,
		"GroceryBag3", 8,
		"GroceryBag4", 8,
		"GroceryBag5", 8,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.GroceriesSeatFront = {
	rolls = 1,
	items = {
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"CookingMag1", 0.5,
		"CookingMag2", 0.5,
		"CookingMag3", 0.5,
		"CookingMag4", 0.5,
		"CookingMag5", 0.5,
		"CookingMag6", 0.5,
		"GroceryBag1", 50,
		"GroceryBag1", 20,
		"GroceryBag2", 8,
		"GroceryBag3", 8,
		"GroceryBag4", 8,
		"GroceryBag5", 8,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.GroceriesSeatRear = {
	rolls = 1,
	items = {
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"CookingMag1", 0.5,
		"CookingMag2", 0.5,
		"CookingMag3", 0.5,
		"CookingMag4", 0.5,
		"CookingMag5", 0.5,
		"CookingMag6", 0.5,
		"GroceryBag1", 50,
		"GroceryBag1", 20,
		"GroceryBag2", 8,
		"GroceryBag3", 8,
		"GroceryBag4", 8,
		"GroceryBag5", 8,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Groceries = {
	specificId = "Groceries";
	
	TruckBed = VehicleDistributions.GroceriesTruckBed;
	TruckBedOpen = VehicleDistributions.GroceriesTruckBed;
	
	GloveBox = VehicleDistributions.GloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.GroceriesSeatFront;
	SeatRearLeft = VehicleDistributions.GroceriesSeatRear;
	SeatRearRight = VehicleDistributions.GroceriesSeatRear;
}

VehicleDistributions.GolfGloveBox = {
	rolls = 1,
	items = {
		"Book_Golf", 2,
		"Book_Rich", 1,
		"BottleOpener", 10,
		"BusinessCard", 1,
		"Clipboard", 10,
		"CordlessPhone", 10,
		"Flask", 0.5,
		"Gloves_LeatherGloves", 10,
		"GolfBall", 50,
		"GolfBall", 20,
		"GolfTee", 20,
		"GolfTee", 10,
		"Hat_GolfHat", 2,
		"Hat_GolfHatTINT", 4,
		"Hat_VisorBlack", 4,
		"Hat_VisorRed", 4,
		"Hat_Visor_WhiteTINT", 10,
		"Magazine_Golf", 8,
		"Magazine_Rich", 4,
		"MenuCard", 10,
		"Paperback_Golf", 8,
		"Paperback_Rich", 4,
		"StockCertificate", 2,
		"StockCertificate", 1,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.GolfTruckBed = {
	rolls = 4,
	items = {
		"Bag_GolfBag", 50,
		"Bag_GolfBag", 20,
		"Golfclub", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.GolfSeatFront = {
	rolls = 1,
	items = {
		"Book_Golf", 4,
		"Book_Rich", 2,
		"Bag_GolfBag", 10,
		"Flask", 0.5,
		"Gloves_LeatherGloves", 10,
		"GolfBall", 50,
		"GolfBall", 20,
		"Golfclub", 20,
		"GolfTee", 20,
		"GolfTee", 10,
		"Hat_BaseballCap_WestMapleCountryClub", 10,
		"Hat_GolfHat", 2,
		"Hat_GolfHatTINT", 4,
		"Hat_VisorBlack", 4,
		"Hat_VisorRed", 4,
		"Hat_Visor_WhiteTINT", 10,
		"Magazine_Golf", 8,
		"Magazine_Rich", 4,
		"Paperback_Golf", 8,
		"Paperback_Rich", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.GolfSeatRear = {
	rolls = 1,
	items = {
		"Bag_GolfBag", 10,
		"Book_Golf", 4,
		"Book_Rich", 2,
		"Flask", 0.5,
		"Gloves_LeatherGloves", 10,
		"GolfBall", 50,
		"GolfBall", 20,
		"Golfclub", 20,
		"GolfTee", 20,
		"GolfTee", 10,
		"Hat_BaseballCap_WestMapleCountryClub", 10,
		"Hat_GolfHat", 2,
		"Hat_GolfHatTINT", 4,
		"Hat_VisorBlack", 4,
		"Hat_VisorRed", 4,
		"Hat_Visor_WhiteTINT", 10,
		"Magazine_Golf", 8,
		"Magazine_Rich", 4,
		"Paperback_Golf", 8,
		"Paperback_Rich", 4,
		"TissueBox", 0.5,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Golf = {
	specificId = "Golf";
	
	TruckBed = VehicleDistributions.GolfTruckBed;
	TruckBedOpen = VehicleDistributions.GolfTruckBed;
	
	GloveBox = VehicleDistributions.GloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.GolfSeatFront;
	SeatRearLeft = VehicleDistributions.GolfSeatRear;
	SeatRearRight = VehicleDistributions.GolfSeatRear;
}

VehicleDistributions.ClothingTruckBed = {
	rolls = 4,
	items = {
		"BookTailoring1", 2,
		"BookTailoring2", 1,
		"BookTailoring3", 0.5,
		"BookTailoring4", 0.1,
		"BookTailoring5", 0.05,
		"Magazine_Fashion", 10,
		"Plasticbag_Clothing", 20,
		"Plasticbag_Clothing", 20,
		"Plasticbag_Clothing", 10,
		"Plasticbag_Clothing", 10,
		"Tote_Clothing", 20,
		"Tote_Clothing", 10,
		"SewingKit", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.ClothingSeatFront = {
	rolls = 1,
	items = {
		"BookTailoring1", 2,
		"BookTailoring2", 1,
		"BookTailoring3", 0.5,
		"BookTailoring4", 0.1,
		"BookTailoring5", 0.05,
		"Magazine_Fashion", 10,
		"Plasticbag_Clothing", 20,
		"Plasticbag_Clothing", 20,
		"Plasticbag_Clothing", 10,
		"Plasticbag_Clothing", 10,
		"Tote_Clothing", 20,
		"Tote_Clothing", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.ClothingSeatRear = {
	rolls = 1,
	items = {
		"BookTailoring1", 2,
		"BookTailoring2", 1,
		"BookTailoring3", 0.5,
		"BookTailoring4", 0.1,
		"BookTailoring5", 0.05,
		"Magazine_Fashion", 10,
		"Plasticbag_Clothing", 20,
		"Plasticbag_Clothing", 20,
		"Plasticbag_Clothing", 10,
		"Plasticbag_Clothing", 10,
		"Tote_Clothing", 20,
		"Tote_Clothing", 10,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Clothing = {
	specificId = "Clothing";
	
	TruckBed = VehicleDistributions.ClothingTruckBed;
	TruckBedOpen = VehicleDistributions.ClothingTruckBed;
	
	GloveBox = VehicleDistributions.GloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.ClothingSeatFront;
	SeatRearLeft = VehicleDistributions.ClothingSeatRear;
	SeatRearRight = VehicleDistributions.ClothingSeatRear;
}

VehicleDistributions.CarpenterGloveBox = {
	rolls = 1,
	items = {
		-- Keys/Keyrings
		"KeyRing_EagleFlag", 0.1,
		"KeyRing_EightBall", 0.1,
		"KeyRing_Panther", 0.1,
		"KeyRing_Sexy", 0.1,
		-- TODO: Sort Me!
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
		"BookFirstAid1", 0.5,
		"CarpentryChisel", 8,
		"CircularSawblade", 4,
		"Clipboard", 10,
		"Crowbar", 4,
		"DuctTape", 4,
		"ElbowPad_Left_Workman", 1,
		"ElectronicsMag4", 0.1,
		"FirstAidKit", 1,
		"Flask", 0.5,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"GraphPaper", 1,
		"Hammer", 8,
		"HandAxe", 4,
		"HandDrill", 4,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"NailsBox", 20,
		"NailsBox", 10,
		"Paperback", 4,
		"Paperwork", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 10,
		"Saw", 8,
		"Screwdriver", 10,
		"ScrewsBox", 8,
		"TobaccoChewing", 1,
		"Tsquare", 1,
		"Twine", 10,
		"ViseGrips", 4,
		"Woodglue", 2,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.CarpenterTruckBed = {
	rolls = 4,
	items = {
		"Axe", 0.5,
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
		"CircularSawblade", 20,
		"ClubHammer", 4,
		"Doorknob", 2,
		"DuctTape", 20,
		"DuctTape", 10,
		"ElectronicsMag4", 4,
		"GardenSaw", 8,
		"Generator", 0.1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Glue", 8,
		"Hammer", 8,
		"HandAxe", 4,
		"HandDrill", 4,
		"Handle", 8,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Hinge", 4,
		"Latch", 1,
		"LongHandle", 4,
		"LongStick", 4,
		"MeasuringTape", 10,
		"Mov_LightConstruction", 4,
		"NailsBox", 20,
		"NailsBox", 20,
		"NailsBox", 10,
		"NailsBox", 10,
		"PetrolCan", 4,
		"Plank", 100,
		"Plank", 50,
		"Plank", 50,
		"Plank", 50,
		"Plank", 20,
		"Plank", 20,
		"Pliers", 8,
		"PowerBar", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 20,
		"Rope", 10,
		"RubberHose", 10,
		"Saw", 6,
		"ScrewsBox", 8,
		"Sledgehammer", 0.5,
		"SmallHandle", 8,
		"Toolbox", 2,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
		"Whetstone", 4,
		"WoodAxe", 0.025,
		"WoodenMallet", 4,
		"Woodglue", 2,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.CarpenterSeatFront = {
	rolls = 1,
	items = {
		"Axe", 0.5,
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
		"Crowbar", 4,
		"DuctTape", 10,
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"NailsBox", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Saw", 8,
		"ScrewsBox", 8,
		"Shoes_WorkBoots", 6,
		"Sledgehammer", 0.5,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
		"WoodAxe", 0.025,
		"WoodenMallet", 4,
		"Woodglue", 2,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Carpenter = {
	specificId = "Carpenter";
	
	TruckBed = VehicleDistributions.CarpenterTruckBed;
	
	TruckBedOpen = VehicleDistributions.CarpenterTruckBed;
	
	TrailerTrunk =  VehicleDistributions.CarpenterTruckBed;
	
	GloveBox = VehicleDistributions.CarpenterGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.CarpenterSeatFront;
}

VehicleDistributions.ElectricianGloveBox = {
	rolls = 1,
	items = {
		"Bag_ProtectiveCaseSmall_Electronics", 1,
		"BookElectrician1", 2,
		"BookElectrician2", 1,
		"BookElectrician3", 0.5,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"BookFirstAid1", 0.5,
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"ElectricWire", 10,
		"ElectronicsMag1", 2,
		"ElectronicsMag2", 2,
		"ElectronicsMag3", 2,
		"ElectronicsMag4", 1,
		"ElectronicsMag5", 2,
		"ElectronicsScrap", 10,
		"EngineerMagazine1", 2,
		"EngineerMagazine2", 2,
		"FirstAidKit", 1,
		"FlashLight_AngleHead", 1,
		"Flask", 0.5,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"GraphPaper", 1,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Tech", 10,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paperback", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"Pliers", 8,
		"RadioMag1", 3,
		"RadioMag2", 2,
		"RadioMag3", 1,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Tsquare", 1,
		"Twine", 10,
		"ViseGrips", 4,
		"Vest_HighViz", 4,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.ElectricianTruckBed = {
	rolls = 4,
	items = {
		"Aluminum", 8,
		"Amplifier", 8,
		"Bag_ProtectiveCaseSmall_Electronics", 1,
		"BoltCutters", 1,
		"BookElectrician1", 2,
		"BookElectrician2", 1,
		"BookElectrician3", 0.5,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"ElectricWire", 20,
		"ElectricWire", 10,
		"ElectronicsMag1", 2,
		"ElectronicsMag2", 2,
		"ElectronicsMag3", 2,
		"ElectronicsMag4", 4,
		"ElectronicsMag5", 2,
		"ElectronicsScrap", 20,
		"ElectronicsScrap", 10,
		"EngineerMagazine1", 2,
		"EngineerMagazine2", 2,
		"FlashLight_AngleHead", 1,
		"Generator", 0.1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"MeasuringTape", 10,
		"MetalPipe", 6,
		"MotionSensor", 8,
		"Mov_LightConstruction", 4,
		"Mov_AirConditioner", 1,
		"PetrolCan", 4,
		"Pliers", 8,
		"PowerBar", 20,
		"PowerBar", 10,
		"RadioMag1", 3,
		"RadioMag2", 2,
		"RadioMag3", 1,
		"RemoteCraftedV1", 8,
		"RemoteCraftedV2", 4,
		"RemoteCraftedV3", 2,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 10,
		"Sledgehammer", 0.5,
		"TimerCrafted", 8,
		"TriggerCrafted", 8,
		"Twine", 10,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.ElectricianSeat = {
	rolls = 1,
	items = {
		"Bag_ProtectiveCaseSmall_Electronics", 1,
		"BookElectrician1", 2,
		"BookElectrician2", 1,
		"BookElectrician3", 0.5,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"ElbowPad_Left_Workman", 1,
		"ElectricWire", 10,
		"ElectronicsMag1", 2,
		"ElectronicsMag2", 2,
		"ElectronicsMag3", 2,
		"ElectronicsMag4", 1,
		"ElectronicsMag5", 2,
		"ElectronicsScrap", 10,
		"EngineerMagazine1", 2,
		"EngineerMagazine2", 2,
		"FlashLight_AngleHead", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Magazine_Tech", 10,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Pliers", 8,
		"RadioMag1", 3,
		"RadioMag2", 2,
		"RadioMag3", 1,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 10,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Electrician = {
	specificId = "Electrician";
	
	TruckBed = VehicleDistributions.ElectricianTruckBed;
	
	TruckBedOpen = VehicleDistributions.ElectricianTruckBed;
	
	TrailerTrunk =  VehicleDistributions.ElectricianTruckBed;
	
	GloveBox = VehicleDistributions.ElectricianGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.ElectricianSeat;
}

VehicleDistributions.FarmerGloveBox = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"Book_Bible", 2,
		"Book_Farming", 2,
		"BookFarming1", 2,
		"BookFarming2", 1,
		"BookFarming3", 0.5,
		"BookFarming4", 0.1,
		"BookFarming5", 0.5,
		"BookHusbandry1", 2,
		"BookHusbandry2", 1,
		"BookHusbandry3", 0.5,
		"BookHusbandry4", 0.1,
		"BookHusbandry5", 0.5,
		"BookFirstAid1", 0.5,
		"BottleOpener", 10,
		"BurlapPiece", 8,
		"CarpentryChisel", 1,
		"CigaretteRollingPapers", 1,
		"ElbowPad_Left_Workman", 1,
		"FarmingMag1", 2,
		"FarmingMag2", 2,
		"FarmingMag3", 2,
		"FarmingMag4", 2,
		"FarmingMag5", 2,
		"FarmingMag6", 2,
		"FarmingMag7", 2,
		"FarmingMag8", 2,
		"FirstAidKit", 1,
		"Flask", 0.5,
		"GardeningSprayEmpty", 6,
		"Gloves_LeatherGloves", 10,
		"HandShovel", 6,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_StrawHat", 4,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"Paperback_Bible", 4,
		"Paperback", 8,
		"Pliers", 4,
		"RatPoison", 1,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"SeedBag_Farming", 50,
		"SeedBag_Farming", 20,
		"SheepElectricShears", 2,
		"SheepShears", 2,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
		"Twine", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.FarmerTruckBed = {
	rolls = 4,
	items = {
		"AnimalFeedBag", 10,
		"Bag_GardenBasket", 10,
		"BookFarming1", 2,
		"BookFarming2", 1,
		"BookFarming3", 0.5,
		"BookFarming4", 0.1,
		"BookFarming5", 0.5,
		"BookHusbandry1", 2,
		"BookHusbandry2", 1,
		"BookHusbandry3", 0.5,
		"BookHusbandry4", 0.1,
		"BookHusbandry5", 0.5,
		"Bucket", 4,
		"BurlapPiece", 8,
		"CarpentryChisel", 1,
		"CompostBag", 10,
		"Dirtbag", 20,
		"Dirtbag", 10,
		"EmptySandbag", 20,
		"EmptySandbag", 10,
		"Fertilizer", 10,
		"GardenFork", 10,
		"GardenHoe", 2,
		"GardeningSprayEmpty", 6,
		"Gravelbag", 10,
		"HandAxe", 1,
		"HandFork", 2,
		"HandScythe", 2,
		"HandShovel", 6,
		"Hat_BuildersRespirator", 2,
		"KnapsackSprayer", 1,
		"LeafRake", 10,
		"Mov_SaltLick", 1,
		"PetrolCan", 4,
		"PickAxe", 0.5,
		"Pliers", 4,
		"Rake", 10,
		"RatPoison", 1,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 20,
		"Rope", 10,
		"RubberHose", 20,
		"RubberHose", 10,
		"Sandbag", 10,
		"Scythe", 10,
		"SeedBag_Farming", 20,
		"SheepElectricShears", 10,
		"SheepShears", 10,
		"Toolbox_Gardening", 10,
		"Twine", 10,
		"WateredCan", 6,
		"WheatSheafDried", 8,
		"WheatSack", 8,
		"WheatSeed", 8,
		"WheatSeedSack", 8,
		"Whetstone", 4,
		"Wire", 20,
		"Wire", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.FarmerSeatFront = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"Book_Bible", 1,
		"Book_Farming", 2,
		"BookFarming1", 2,
		"BookFarming2", 1,
		"BookFarming3", 0.5,
		"BookFarming4", 0.1,
		"BookFarming5", 0.5,
		"BookHusbandry1", 2,
		"BookHusbandry2", 1,
		"BookHusbandry3", 0.5,
		"BookHusbandry4", 0.1,
		"BookHusbandry5", 0.5,
		"BurlapPiece", 8,
		"CarpentryChisel", 1,
		"Dungarees", 6,
		"ElbowPad_Left_Workman", 1,
		"FarmingMag1", 2,
		"FarmingMag2", 2,
		"FarmingMag3", 2,
		"FarmingMag4", 2,
		"FarmingMag5", 2,
		"FarmingMag6", 2,
		"FarmingMag7", 2,
		"FarmingMag8", 2,
		"GardenFork", 10,
		"GardenHoe", 2,
		"GardeningSprayEmpty", 6,
		"Gloves_LeatherGloves", 10,
		"HandAxe", 1,
		"HandFork", 2,
		"HandScythe", 2,
		"HandShovel", 6,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_StrawHat", 4,
		"KnapsackSprayer", 1,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"Mov_SaltLick", 1,
		"Paperback_Bible", 4,
		"Pliers", 4,
		"Rake", 10,
		"RatPoison", 1,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"SeedBag_Farming", 20,
		"Shoes_Wellies", 4,
		"Twine", 10,
		"WateredCan", 6,
		"Wire", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Farmer = {
	specificId = "Farmer";
	
	TruckBed = VehicleDistributions.FarmerTruckBed;
	
	TruckBedOpen = VehicleDistributions.FarmerTruckBed;
	
	TrailerTrunk =  VehicleDistributions.FarmerTruckBed;
	
	GloveBox = VehicleDistributions.FarmerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.FarmerSeatFront;
}

VehicleDistributions.MetalWelderGloveBox = {
	rolls = 1,
	items = {
		-- Tools
		"BallPeenHammer", 6,
		"BlowTorch", 8,
		"Calipers", 8,
		"DrawPlate", 8,
		"File", 8,
		"MetalworkingChisel", 8,
		"MetalworkingPunch", 8,
		"Pliers", 8,
		"SmallFileSet", 8,
		"SmallPunchSet", 8,
		"SmallSaw", 8,
		"Tsquare", 1,
		"ViseGrips", 4,
		"Wire", 10,
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"FlashLight_AngleHead", 1,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"RespiratorFilters", 2,
		-- Materials
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"SteelWool", 10,
		"Twine", 10,
		-- Literature (Skills/Recipes)
		"BookBlacksmith1", 2,
		"BookBlacksmith2", 1,
		"BookBlacksmith3", 0.5,
		"BookBlacksmith4", 0.1,
		"BookBlacksmith5", 0.05,
		"BookFirstAid1", 0.5,
		"BookMetalWelding1", 2,
		"BookMetalWelding2", 1,
		"BookMetalWelding3", 0.5,
		"BookMetalWelding4", 0.1,
		"BookMetalWelding5", 0.05,
		"ElectronicsMag4", 0.1,
		"MetalworkMag1", 2,
		"MetalworkMag2", 2,
		"MetalworkMag3", 2,
		"MetalworkMag4", 2,
		-- Personal
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Paperback", 4,
		"TobaccoChewing", 1,
		-- Misc.
		"Clipboard", 10,
		"GraphPaper", 1,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paperwork", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.MetalWelderTruckBed = {
	rolls = 4,
	items = {
		-- Tools
		"BallPeenHammer", 10,
		"Bellows", 8,
		"BlowerFan", 2,
		"BlowTorch", 10,
		"BoltCutters", 1,
		"Calipers", 8,
		"CeramicCrucible", 10,
		"CrudeBenchVise", 1,
		"DrawPlate", 8,
		"File", 8,
		"MetalworkingChisel", 8,
		"MetalworkingPliers", 1,
		"MetalworkingPunch", 8,
		"PetrolCan", 4,
		"Pliers", 8,
		"Sledgehammer", 0.5,
		"SmallFileSet", 8,
		"SmallPunchSet", 8,
		"SmallSaw", 8,
		"Tongs", 10,
		"ViseGrips", 4,
		-- Equipment
		"FlashLight_AngleHead", 1,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"RespiratorFilters", 2,
		"WeldingMask", 10,
		"PowerBar", 10,
		-- Literature (Skills/Recipes)
		"BookBlacksmith1", 2,
		"BookBlacksmith2", 1,
		"BookBlacksmith3", 0.5,
		"BookBlacksmith4", 0.1,
		"BookBlacksmith5", 0.05,
		"BookMetalWelding1", 2,
		"BookMetalWelding2", 1,
		"BookMetalWelding3", 0.5,
		"BookMetalWelding4", 0.1,
		"BookMetalWelding5", 0.05,
		"ElectronicsMag4", 4,
		"MetalworkMag1", 2,
		"MetalworkMag2", 2,
		"MetalworkMag3", 2,
		"MetalworkMag4", 2,
		-- Materials
		"SteelWool", 10,
		"Twine", 10,
		"IronBand", 1,
		"IronBandSmall", 4,
		"IronBar", 4,
		"IronBarHalf", 6,
		"IronBarQuarter", 8,
		"IronPiece", 10,
		"MetalBar", 10,
		"MetalPipe", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 10,
		"RubberHose", 10,
		"SheetMetal", 10,
		"SmallSheetMetal", 10,
		"SteelBar", 4,
		"SteelBarHalf", 6,
		"SteelPiece", 10,
		"SteelBarQuarter", 8,
		"WeldingRods", 20,
		"WeldingRods", 10,
		"Wire", 20,
		"Wire", 10,
		-- Fuel
		"PropaneTank", 10,
		"PropaneTank", 2,
		-- Moveables
		"Generator", 0.1,
		"Mov_ElectricBlowerForge", 1,
		"Mov_LightConstruction", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.MetalWelderSeatFront = {
	rolls = 1,
	items = {
		-- Tools
		"BallPeenHammer", 10,
		"BlowTorch", 10,
		"Calipers", 8,
		"DrawPlate", 8,
		"File", 8,
		"MetalworkingChisel", 8,
		"MetalworkingPliers", 1,
		"MetalworkingPunch", 8,
		"Pliers", 8,
		"Sledgehammer", 0.5,
		"SmallFileSet", 8,
		"SmallPunchSet", 8,
		"SmallSaw", 8,
		"ViseGrips", 4,
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"FlashLight_AngleHead", 1,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MeasuringTape", 10,
		"RespiratorFilters", 2,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"WeldingMask", 10,
		-- Materials
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 10,
		"WeldingRods", 10,
		"Wire", 10,
		-- Literature (Skills/Recipes)
		"BookBlacksmith1", 2,
		"BookBlacksmith2", 1,
		"BookBlacksmith3", 0.5,
		"BookBlacksmith4", 0.1,
		"BookBlacksmith5", 0.05,
		"BookFirstAid1", 0.5,
		"BookMetalWelding1", 2,
		"BookMetalWelding2", 1,
		"BookMetalWelding3", 0.5,
		"BookMetalWelding4", 0.1,
		"BookMetalWelding5", 0.05,
		"ElectronicsMag4", 0.1,
		"MetalworkMag1", 2,
		"MetalworkMag2", 2,
		"MetalworkMag3", 2,
		"MetalworkMag4", 2,
		-- Misc.
		"MarkerBlack", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.MetalWelder = {
	specificId = "MetalWelder";
	
	TruckBed = VehicleDistributions.MetalWelderTruckBed;
	
	TruckBedOpen = VehicleDistributions.MetalWelderTruckBed;
	
	TrailerTrunk =  VehicleDistributions.MetalWelderTruckBed;
	
	GloveBox = VehicleDistributions.MetalWelderGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.MetalWelderSeatFront;
}

VehicleDistributions.BlacksmithGloveBox = {
	rolls = 1,
	items = {
		-- Tools
		"BallPeenHammer", 8,
		"Bellows", 8,
		"Calipers", 2,
		"CeramicCrucible", 4,
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
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"FlashLight_AngleHead", 1,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"RespiratorFilters", 2,
		-- Materials
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"SteelWool", 10,
		"Twine", 10,
		"Wire", 10,
		-- Literature (Skills/Recipes)
		"BookBlacksmith1", 4,
		"BookBlacksmith2", 2,
		"BookBlacksmith3", 1,
		"BookBlacksmith4", 0.5,
		"BookBlacksmith5", 0.1,
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
		-- Personal
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Paperback", 4,
		"TobaccoChewing", 1,
		-- Misc.
		"Clipboard", 10,
		"GraphPaper", 1,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paperwork", 10,
		"Tsquare", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.BlacksmithTruckBed = {
	rolls = 4,
	items = {
		-- Tools
		"BallPeenHammer", 10,
		"Bellows", 8,
		"BlowerFan", 2,
		"BlowTorch", 10,
		"BoltCutters", 1,
		"Calipers", 8,
		"CeramicCrucible", 10,
		"CrudeBenchVise", 1,
		"DrawPlate", 8,
		"File", 8,
		"MetalworkingChisel", 8,
		"MetalworkingPliers", 1,
		"MetalworkingPunch", 8,
		"PetrolCan", 4,
		"Pliers", 8,
		"Sledgehammer", 0.5,
		"SmallFileSet", 8,
		"SmallPunchSet", 8,
		"SmallSaw", 8,
		"Tongs", 10,
		"ViseGrips", 4,
		-- Components
		"BenchAnvil", 1,
		"IronIngotMold", 2,
		"IronBarMold", 2,
		-- Equipment
		"FlashLight_AngleHead", 1,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"PowerBar", 10,
		"RespiratorFilters", 2,
		"WeldingMask", 10,
		-- Literature (Skills/Recipes)
		"BookBlacksmith1", 4,
		"BookBlacksmith2", 2,
		"BookBlacksmith3", 1,
		"BookBlacksmith4", 0.5,
		"BookBlacksmith5", 0.1,
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
		-- Materials
		"SteelWool", 10,
		"Twine", 10,
		"IronBand", 1,
		"IronBandSmall", 4,
		"IronBar", 4,
		"IronBarHalf", 6,
		"IronBarQuarter", 8,
		"IronBand", 1,
		"IronBandSmall", 4,
		"IronPiece", 10,
		"MetalBar", 10,
		"MetalPipe", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 10,
		"RubberHose", 10,
		"SteelBar", 4,
		"SteelBarHalf", 6,
		"SteelPiece", 10,
		"SteelBarQuarter", 8,
		"WeldingRods", 20,
		"WeldingRods", 10,
		"Wire", 20,
		"Wire", 10,
		-- Fuel
		"PropaneTank", 10,
		"PropaneTank", 2,
		-- Moveables
		"Generator", 0.1,
		"Mov_ElectricBlowerForge", 1,
		"Mov_LightConstruction", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.BlacksmithSeatFront = {
	rolls = 1,
	items = {
		-- Tools
		"BallPeenHammer", 10,
		"Bellows", 8,
		"BlowTorch", 10,
		"BoltCutters", 1,
		"Calipers", 8,
		"CeramicCrucible", 10,
		"CrudeBenchVise", 1,
		"DrawPlate", 8,
		"File", 8,
		"MetalworkingChisel", 8,
		"MetalworkingPliers", 1,
		"MetalworkingPunch", 8,
		"PetrolCan", 4,
		"Pliers", 8,
		"Sledgehammer", 0.5,
		"SmallFileSet", 8,
		"SmallPunchSet", 8,
		"SmallSaw", 8,
		"Tongs", 10,
		"ViseGrips", 4,
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"FlashLight_AngleHead", 1,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MeasuringTape", 10,
		"RespiratorFilters", 2,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"WeldingMask", 10,
		-- Materials
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 10,
		"WeldingRods", 10,
		"Wire", 10,
		-- Literature (Skills/Recipes)
		"BookBlacksmith1", 4,
		"BookBlacksmith2", 2,
		"BookBlacksmith3", 1,
		"BookBlacksmith4", 0.5,
		"BookBlacksmith5", 0.1,
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
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Blacksmith = {
	TruckBed = VehicleDistributions.BlacksmithTruckBed;

	GloveBox = VehicleDistributions.BlacksmithGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.BlacksmithSeatFront;
}

VehicleDistributions.DoctorGloveBox = {
	rolls = 1,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bandage", 10,
		"Book_Medical", 4,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"Clipboard", 10,
		"CordlessPhone", 10,
		"Disinfectant", 4,
		"FirstAidKit", 10,
		"Flask", 0.5,
		"Gloves_Surgical", 10,
		"Hat_HeadMirrorUP", 1,
		"Hat_SurgicalMask", 10,
		"Magazine_Health", 8,
		"Magazine_Rich", 4,
		"Pager", 20,
		"Paperback_Medical", 8,
		"Paperwork", 20,
		"Paperwork", 10,
		"PenLight", 10,
		"Pills", 10,
		"PillsAntiDep", 10,
		"PillsBeta", 10,
		"PillsSleepingTablets", 10,
		"Scalpel", 10,
		"ScissorsBluntMedical", 10,
		"Screwdriver", 10,
		"Stethoscope", 8,
		"SutureNeedle", 10,
		"SutureNeedleHolder", 10,
		"Tweezers", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.DoctorTruckBed = {
	rolls = 4,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bag_DoctorBag", 10,
		"Bag_MedicalBag", 2,
		"Bandage", 10,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"Disinfectant", 4,
		"FirstAidKit", 10,
		"Gloves_Surgical", 10,
		"Hammer", 8,
		"Hat_HeadMirrorUP", 1,
		"Hat_SurgicalMask", 10,
		"JacketLong_Doctor", 8,
		"Pills", 10,
		"PillsAntiDep", 10,
		"PillsBeta", 10,
		"PillsSleepingTablets", 10,
		"Scalpel", 10,
		"ScissorsBluntMedical", 10,
		"Shirt_FormalWhite", 10,
		"Shoes_Brown", 8,
		"SutureNeedle", 10,
		"SutureNeedleHolder", 10,
		"Trousers_Suit", 10,
		"Tweezers", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.DoctorSeatFront = {
	rolls = 1,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bag_DoctorBag", 10,
		"Bag_MedicalBag", 2,
		"Bandage", 10,
		"Book_Medical", 4,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"Disinfectant", 4,
		"FirstAidKit", 10,
		"Gloves_Surgical", 10,
		"Hat_HeadMirrorUP", 1,
		"Hat_SurgicalMask", 10,
		"JacketLong_Doctor", 8,
		"Magazine_Health", 8,
		"Magazine_Rich", 4,
		"Paperback_Medical", 8,
		"Pills", 10,
		"PillsAntiDep", 10,
		"PillsBeta", 10,
		"PillsSleepingTablets", 10,
		"Scalpel", 10,
		"ScissorsBluntMedical", 10,
		"Shirt_FormalWhite", 10,
		"Shoes_Brown", 8,
		"Stethoscope", 8,
		"SutureNeedle", 10,
		"SutureNeedleHolder", 10,
		"Trousers_Suit", 10,
		"Tweezers", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.DoctorSeatRear = {
	rolls = 1,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bag_MedicalBag", 2,
		"Bandage", 10,
		"Book_Medical", 4,
		"Disinfectant", 4,
		"FirstAidKit", 10,
		"Gloves_Surgical", 10,
		"Hat_HeadMirrorUP", 1,
		"Hat_SurgicalMask", 10,
		"JacketLong_Doctor", 8,
		"Magazine_Health", 8,
		"Magazine_Rich", 4,
		"Paperback_Medical", 8,
		"Pills", 10,
		"PillsAntiDep", 10,
		"PillsBeta", 10,
		"PillsSleepingTablets", 10,
		"Scalpel", 10,
		"ScissorsBluntMedical", 10,
		"Shirt_FormalWhite", 10,
		"Shoes_Brown", 8,
		"Stethoscope", 8,
		"SutureNeedle", 10,
		"SutureNeedleHolder", 10,
		"TobaccoChewing", 0.05,
		"TobaccoLoose", 0.05,
		"Trousers_Suit", 10,
		"Tweezers", 10,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Doctor = {
	specificId = "Doctor";
	
	TruckBed = VehicleDistributions.DoctorTruckBed;
	
	TruckBedOpen = VehicleDistributions.DoctorTruckBed;
	
	GloveBox = VehicleDistributions.DoctorGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.DoctorSeatFront;
	SeatRearLeft = VehicleDistributions.DoctorSeatRear;
	SeatRearRight = VehicleDistributions.DoctorSeatRear;
}

VehicleDistributions.RadioGloveBox = {
	rolls = 1,
	items = {
		"BookElectrician1", 2,
		"BookElectrician2", 1,
		"BookElectrician3", 0.5,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"BookFirstAid1", 0.5,
		"CameraExpensive", 10,
		"CameraFilm", 20,
		"CameraFilm", 10,
		"Clipboard", 10,
		"CordlessPhone", 10,
		"ElectronicsMag4", 0.1,
		"FlashLight_AngleHead", 1,
		"GraphPaper", 1,
		"IDcard", 1,
		"Kneepad_Left_Workman", 1,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Tech", 10,
		"MarkerBlack", 4,
		"MenuCard", 10,
		"Notebook", 20,
		"Notebook", 10,
		"Notepad", 20,
		"Paperback", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"Phonebook", 20,
		"RadioMag1", 2,
		"RadioMag2", 2,
		"RadioMag3", 2,
		"TVMagazine", 10,
		"Twine", 10,
		"WalkieTalkie2", 8,
		"WalkieTalkie3", 4,
		"Zipties", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.RadioTruckBed = {
	rolls = 4,
	items = {
		"Bag_ProtectiveCaseBulky_Audio", 1,
		"Bag_ProtectiveCaseBulky_HAMRadio1", 1,
		"Bag_ProtectiveCaseSmall_WalkieTalkie", 6,
		"Bag_ProtectiveCase_Tools", 10,
		"BookElectrician1", 2,
		"BookElectrician2", 1,
		"BookElectrician3", 0.5,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"CameraExpensive", 20,
		"CameraExpensive", 10,
		"CameraFilm", 50,
		"CameraFilm", 20,
		"CameraFilm", 20,
		"CameraFilm", 10,
		"CameraFilm", 10,
		"ElectronicsMag4", 4,
		"ElectricWire", 20,
		"ElectricWire", 20,
		"ElectricWire", 10,
		"ElectricWire", 10,
		"FlashLight_AngleHead", 1,
		"Generator", 0.1,
		"Headphones", 20,
		"Headphones", 10,
		"Microphone", 20,
		"Mov_Microphone", 50,
		"Mov_TVCamera", 20,
		"PowerBar", 20,
		"PowerBar", 10,
		"RadioMag1", 2,
		"RadioMag2", 2,
		"RadioMag3", 2,
		"RadioReceiver", 10,
		"RadioTransmitter", 10,
		"ScannerModule", 10,
		"WalkieTalkie2", 20,
		"WalkieTalkie2", 10,
		"WalkieTalkie3", 4,
		"Zipties", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.RadioSeatFront = {
	rolls = 1,
	items = {
		"Bag_ProtectiveCaseSmall_WalkieTalkie", 2,
		"BookElectrician1", 2,
		"BookElectrician2", 1,
		"BookElectrician3", 0.5,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"CameraExpensive", 10,
		"FlashLight_AngleHead", 1,
		"Hat_BaseballCap_LBMW", 20,
		"Headphones", 10,
		"Kneepad_Left_Workman", 1,
		"Magazine_Tech", 10,
		"MarkerBlack", 4,
		"RadioMag1", 2,
		"RadioMag2", 2,
		"RadioMag3", 2,
		"Twine", 10,
		"WalkieTalkie2", 8,
		"WalkieTalkie3", 2,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Radio = {
	TruckBed = VehicleDistributions.RadioTruckBed;
	TruckBedOpen = VehicleDistributions.RadioTruckBed;
	
	GloveBox = VehicleDistributions.RadioGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.RadioSeatFront;
}

VehicleDistributions.NNNSeatFront = {
	rolls = 1,
	items = {
		"BookElectrician1", 2,
		"BookElectrician2", 1,
		"BookElectrician3", 0.5,
		"BookElectrician4", 0.1,
		"BookElectrician5", 0.05,
		"CameraExpensive", 10,
		"FlashLight_AngleHead", 1,
		"Hat_BaseballCap_3N", 20,
		"Headphones", 10,
		"Kneepad_Left_Workman", 1,
		"Magazine_Tech", 10,
		"MarkerBlack", 4,
		"RadioMag1", 2,
		"RadioMag2", 2,
		"RadioMag3", 2,
		"Twine", 10,
		"WalkieTalkie2", 8,
		"WalkieTalkie3", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.NNN = {
	TruckBed = VehicleDistributions.RadioTruckBed;
	TruckBedOpen = VehicleDistributions.RadioTruckBed;
	
	GloveBox = VehicleDistributions.RadioGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.NNNSeatFront;
}

VehicleDistributions.PainterGloveBox = {
	rolls = 1,
	items = {
		"BookFirstAid1", 0.5,
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"ElectronicsMag4", 0.1,
		"FirstAidKit", 1,
		"Flask", 0.5,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paintbrush", 10,
		"Paperback", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"PlasterTrowel", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"TobaccoChewing", 1,
		"Twine", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.PainterTruckBed = {
	rolls = 4,
	items = {
		"Boilersuit", 10,
		"Bucket", 20,
		"Bucket", 10,
		"ElectronicsMag4", 4,
		"Generator", 0.1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Mov_LightConstruction", 4,
		"PetrolCan", 4,
		"PaintBlack", 20,
		"PaintBlue", 20,
		"PaintBrown", 20,
		"Paintbrush", 20,
		"Paintbrush", 10,
		"PaintCyan", 20,
		"PaintGreen", 20,
		"PaintGrey", 20,
		"PaintLightBlue", 20,
		"PaintLightBrown", 20,
		"PaintOrange", 20,
		"PaintPink", 20,
		"PaintPurple", 20,
		"PaintRed", 20,
		"PaintTurquoise", 20,
		"PaintWhite", 20,
		"PaintYellow", 20,
		"PlasterPowder", 8,
		"PlasterTrowel", 10,
		"PowerBar", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 10,
		"RubberHose", 20,
		"RubberHose", 10,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"Wallpaper_BeigeStripe", 1,
		"Wallpaper_BlackFloral", 1,
		"Wallpaper_BlueStripe", 1,
		"Wallpaper_GreenDiamond", 1,
		"Wallpaper_GreenFloral", 1,
		"Wallpaper_PinkChevron", 1,
		"Wallpaper_PinkFloral", 1,
		"WallpaperPastePowder", 8,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.PainterSeatFront = {
	rolls = 1,
	items = {
		"Boilersuit", 10,
		"Brochure", 2,
		"Bucket", 10,
		"ElbowPad_Left_Workman", 1,
		"Flier", 2,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MeasuringTape", 10,
		"Paintbrush", 10,
		"PlasterTrowel", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Shoes_WorkBoots", 6,
		"Twine", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Painter = {
	specificId = "Painter";
	
	TruckBed = VehicleDistributions.PainterTruckBed;
	
	TruckBedOpen = VehicleDistributions.PainterTruckBed;
	
	TrailerTrunk =  VehicleDistributions.PainterTruckBed;
	
	GloveBox = VehicleDistributions.PainterGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PainterSeatFront;
}

VehicleDistributions.ConstructionWorkerGloveBox = {
	rolls = 1,
	items = {
		"BallPeenHammer", 6,
		"BlowTorch", 8,
		"BookCarpentry1", 1,
		"BookCarpentry2", 0.5,
		"BookCarpentry3", 0.1,
		"BookCarpentry4", 0.05,
		"BookCarpentry5", 0.01,
		"BookFirstAid1", 0.5,
		"BookMaintenance1", 2,
		"BookMaintenance2", 1,
		"BookMaintenance3", 0.5,
		"BookMaintenance4", 0.1,
		"BookMaintenance5", 0.05,
		"BookMetalWelding1", 1,
		"BookMetalWelding2", 0.5,
		"BookMetalWelding3", 0.1,
		"BookMetalWelding4", 0.05,
		"BookMetalWelding5", 0.01,
		"BottleOpener", 10,
		"CarpentryChisel", 2,
		"Clipboard", 10,
		"ClubHammer", 4,
		"Crowbar", 4,
		"ElbowPad_Left_Workman", 1,
		"ElectronicsMag4", 0.1,
		"File", 1,
		"FirstAidKit", 1,
		"Flask", 0.5,
		"GardenSaw", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"GraphPaper", 1,
		"Hammer", 8,
		"HandAxe", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MasonsChisel", 10,
		"MasonsTrowel", 10,
		"MeasuringTape", 10,
		"MetalworkingChisel", 1,
		"MetalworkingPunch", 1,
		"NailsBox", 10,
		"Paperback", 4,
		"Pliers", 8,
		"NutsBolts", 10,
		"Paperwork", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 10,
		"Saw", 8,
		"Screwdriver", 10,
		"ScrewsBox", 8,
		"SmallFileSet", 1,
		"SmallPunchSet", 1,
		"SmallSaw", 1,
		"SteelWool", 1,
		"TobaccoChewing", 1,
		"Tsquare", 1,
		"Twine", 10,
		"ViseGrips", 4,
		"WoodenMallet", 4,
		"Woodglue", 2,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.ConstructionWorkerTruckBed = {
	rolls = 4,
	items = {
		"Bag_ToolBag", 10,
		"BarbedWire", 10,
		"BoltCutters", 1,
		"BookCarpentry1", 1,
		"BookCarpentry2", 0.5,
		"BookCarpentry3", 0.1,
		"BookCarpentry4", 0.05,
		"BookCarpentry5", 0.01,
		"BookMaintenance1", 2,
		"BookMaintenance2", 1,
		"BookMaintenance3", 0.5,
		"BookMaintenance4", 0.1,
		"BookMaintenance5", 0.05,
		"BookMetalWelding1", 1,
		"BookMetalWelding2", 0.5,
		"BookMetalWelding3", 0.1,
		"BookMetalWelding4", 0.05,
		"BookMetalWelding5", 0.01,
		"Bucket", 10,
		"CarpentryChisel", 2,
		"ClayBrick", 50,
		"ClayBrick", 20,
		"Cooler_Beer", 1,
		"Cooler_Soda", 10,
		"ConcretePowder", 10,
		"DuctTape", 10,
		"ElectronicsMag4", 4,
		"EmptySandbag", 10,
		"File", 1,
		"Generator", 0.1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Gravelbag", 10,
		"HandAxe", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"LeadPipe", 10,
		"MasonsChisel", 10,
		"MasonsTrowel", 10,
		"MeasuringTape", 10,
		"MetalBar", 10,
		"MetalPipe", 10,
		"MetalworkingChisel", 1,
		"MetalworkingPliers", 0.1,
		"MetalworkingPunch", 1,
		"Mov_ConcreteMixer", 4,
		"Mov_LightConstruction", 4,
		"Mov_PalletEmpty", 4,
		"Mov_RoadBarrier", 4,
		"Mov_RoadCone", 10,
		"Mov_RoadCone2", 10,
		"NailsBox", 10,
		"NutsBolts", 10,
		"PetrolCan", 4,
		"PickAxe", 4,
		"Plank", 50,
		"Plank", 50,
		"Plank", 20,
		"Plank", 20,
		"Plank", 10,
		"PlasterPowder", 10,
		"Pliers", 8,
		"PowerBar", 10,
		"RailroadSpikePuller", 1,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 20,
		"Rope", 10,
		"RubberHose", 10,
		"SheetMetal", 10,
		"Sledgehammer", 0.5,
		"SmallFileSet", 1,
		"SmallPunchSet", 1,
		"SmallSaw", 1,
		"SmallSheetMetal", 20,
		"SmallSheetMetal", 10,
		"SteelWool", 1,
		"Toolbox", 10,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
		"Wallpaper_BeigeStripe", 0.1,
		"Wallpaper_BlackFloral", 0.1,
		"Wallpaper_BlueStripe", 0.1,
		"Wallpaper_GreenDiamond", 0.1,
		"Wallpaper_GreenFloral", 0.1,
		"Wallpaper_PinkChevron", 0.1,
		"Wallpaper_PinkFloral", 0.1,
		"WallpaperPastePowder", 0.1,
		"WeldingMask", 10,
		"WeldingRods", 10,
		"Whetstone", 4,
		"Wire", 20,
		"Wire", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.ConstructionWorkerSeatFront = {
	rolls = 1,
	items = {
		"Bag_ToolBag", 0.5,
		"BallPeenHammer", 6,
		"BlowTorch", 8,
		"BookCarpentry1", 1,
		"BookCarpentry2", 0.5,
		"BookCarpentry3", 0.1,
		"BookCarpentry4", 0.05,
		"BookCarpentry5", 0.01,
		"BookMaintenance1", 2,
		"BookMaintenance2", 1,
		"BookMaintenance3", 0.5,
		"BookMaintenance4", 0.1,
		"BookMaintenance5", 0.05,
		"BookMetalWelding1", 1,
		"BookMetalWelding2", 0.5,
		"BookMetalWelding3", 0.1,
		"BookMetalWelding4", 0.05,
		"BookMetalWelding5", 0.01,
		"CarpentryChisel", 2,
		"ClubHammer", 4,
		"Crowbar", 4,
		"ElbowPad_Left_Workman", 1,
		"File", 1,
		"Flier", 2,
		"GardenSaw", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"HandAxe", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MasonsChisel", 10,
		"MasonsTrowel", 10,
		"MeasuringTape", 10,
		"MetalworkingChisel", 1,
		"MetalworkingPliers", 0.1,
		"MetalworkingPunch", 1,
		"NailsBox", 10,
		"NutsBolts", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Saw", 8,
		"ScrewsBox", 8,
		"Sledgehammer", 0.5,
		"SmallFileSet", 1,
		"SmallPunchSet", 1,
		"SmallSaw", 1,
		"Toolbox", 2,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
		"WoodenMallet", 4,
		"Woodglue", 2,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.ConstructionWorker = {
	specificId = "ConstructionWorker";
	
	TruckBed = VehicleDistributions.ConstructionWorkerTruckBed;
	
	TruckBedOpen = VehicleDistributions.ConstructionWorkerTruckBed;
	
	TrailerTrunk =  VehicleDistributions.ConstructionWorkerTruckBed;
	
	GloveBox = VehicleDistributions.ConstructionWorkerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.ConstructionWorkerSeatFront;
}

VehicleDistributions.TaxiGloveBox = {
	rolls = 1,
	items = {
		"Brochure", 20,
		"Brochure", 10,
		"Cashbox", 4,
		"Flier", 20,
		"Flier", 10,
		"Flask", 1,
		"Gloves_FingerlessLeatherGloves", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MenuCard", 10,
		"Money", 100,
		"Money", 50,
		"Money", 20,
		"Money", 20,
		"Money", 10,
		"Money", 10,
		"Paperback", 20,
		"Paperwork", 10,
		"TVMagazine", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.TaxiTruckBed = {
	rolls = 4,
	items = {
		"Handbag", 0.5,
		"Purse", 0.5,
		"Suitcase", 1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.TaxiSeatFront = {
	rolls = 1,
	items = {
		"Handbag", 0.5,
		"Purse", 0.5,
		"Suitcase", 1,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.TaxiSeatRear = {
	rolls = 1,
	items = {
		"Handbag", 0.5,
		"Purse", 0.5,
		"Suitcase", 1,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.Taxi = {
	TruckBed = VehicleDistributions.TaxiTruckBed;
	
	GloveBox = VehicleDistributions.TaxiGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.TaxiSeatFront;
	SeatRearLeft = VehicleDistributions.TaxiSeatRear;
	SeatRearRight = VehicleDistributions.TaxiSeatRear;
}

VehicleDistributions.PoliceGloveBox = {
	rolls = 1,
	items = {
		"Book_Policing", 4,
		"BookFirstAid1", 0.5,
		"Bullets9mmBox", 10,
		"Bullhorn", 10,
		"CameraExpensive", 20,
		"CameraFilm", 20,
		"CameraFilm", 10,
		"Clipboard", 10,
		"Danish", 1,
		"DoughnutChocolate", 1,
		"DoughnutFrosted", 1,
		"DoughnutJelly", 1,
		"DoughnutPlain", 1,
		"FirstAidKit", 4,
		"Flask", 0.5,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"IDcard", 1,
		"Kneepad_Left_Tactical", 1,
		"Lighter", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Police", 8,
		"Magazine_Crime", 4,
		"Magazine_Firearm", 4,
		"MenuCard", 10,
		"Notebook", 20,
		"Paperback_Policing", 8,
		"Paperwork", 20,
		"Paperwork", 10,
		"Pen", 20,
		"Pistol", 8,
		"WalkieTalkie4", 10,
		"Whistle", 2,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.PoliceTruckBed = {
	rolls = 4,
	items = {
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle2", 1,
		"Bag_MedicalBag", 1,
		"Bag_Police", 1,
		"Bullets9mmBox", 20,
		"Bullets9mmBox", 10,
		"Bullhorn", 10,
		"HandTorch", 4,
		"Hat_CrashHelmet_Police", 2,
		"Hat_EarMuff_Protectors", 4,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Black", 8,
		"HuntingRifle", 8,
		"Kneepad_Left_Tactical", 1,
		"M14Clip", 4,
		"Mov_RoadBarrier", 10,
		"Mov_RoadCone", 10,
		"Nightstick", 10,
		"PetrolCan", 4,
		"Pistol", 10,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Vest_BulletPolice", 2,
		"WalkieTalkie4", 10,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.PoliceSeatFront = {
	rolls = 1,
	items = {
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle2", 1,
		"Bag_Police", 1,
		"Bag_ProtectiveCaseSmall_WalkieTalkiePolice", 6,
		"Book_Policing", 4,
		"Bullets9mmBox", 10,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"Hat_BaseballCap_Police", 10,
		"Hat_CrashHelmet_Police", 2,
		"Hat_EarMuff_Protectors", 4,
		"Hat_Police", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Black", 8,
		"HuntingRifle", 8,
		"Kneepad_Left_Tactical", 1,
		"Lighter", 4,
		"M14Clip", 4,
		"Magazine_Police", 8,
		"Magazine_Crime", 4,
		"Magazine_Firearm", 4,
		"Nightstick", 10,
		"Paperback_Policing", 8,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Vest_BulletPolice", 2,
		"WalkieTalkie4", 4,
		"Whistle", 2,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PoliceSeatRear = {
	rolls = 1,
	items = {
		
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.Police = {
	TruckBed = VehicleDistributions.PoliceTruckBed;
	
	GloveBox = VehicleDistributions.PoliceGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PoliceSeatFront;
	SeatRearLeft = VehicleDistributions.PoliceSeatRear;
	SeatRearRight = VehicleDistributions.PoliceSeatRear;
}

VehicleDistributions.RangerGloveBox = {
	rolls = 1,
	items = {
		"223Box", 10,
		"308Box", 10,
		"Bag_ProtectiveCaseSmall_Revolver2", 0.6,
		"Bag_ProtectiveCaseSmall_Revolver3", 0.4,
		"Book_Nature", 4,
		"Book_Policing", 2,
		"BookFirstAid1", 0.5,
		"BookTrapping1", 2,
		"BookTrapping2", 1,
		"BookTrapping3", 0.5,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"Bullets44Box", 10,
		"Bullets45Box", 10,
		"Bullhorn", 10,
		"Camera", 20,
		"CameraFilm", 20,
		"CameraFilm", 10,
		"Clipboard", 10,
		"FirstAidKit", 4,
		"FlashLight_AngleHead", 1,
		"Flask", 0.5,
		"Garbagebag", 6,
		"Garbagebag_box", 0.1,
		"Glasses_Aviators", 4,
		"Glasses_Macho", 0.5,
		"Gloves_LeatherGloves", 10,
		"Handiknife", 1,
		"Hat_Ranger", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Brown", 8,
		"HuntingKnife", 0.1,
		"HuntingMag1", 2,
		"HuntingMag2", 2,
		"HuntingMag3", 2,
		"IDcard", 1,
		"InsectRepellent", 10,
		"KnifePocket", 1,
		"Lighter", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Firearm", 4,
		"Magazine_Outdoors", 8,
		"Magazine_Police", 4,
		"Multitool", 0.1,
		"MenuCard", 10,
		"Paperback_Nature", 6,
		"Paperback_Policing", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"RatPoison", 1,
		"Revolver", 6,
		"Revolver_Long", 4,
		"ShotgunShellsBox", 10,
		"TobaccoChewing", 1,
		"Twine", 10,
		"WalkieTalkie4", 10,
		"WaterPurificationTablets", 1,
		"Whetstone", 10,
		"Whistle", 2,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.RangerTruckBed = {
	rolls = 4,
	items = {
		"223Box", 10,
		"308Box", 10,
		"Bag_ProtectiveCaseSmall_Revolver2", 0.6,
		"Bag_ProtectiveCaseSmall_Revolver3", 0.4,
		"Bag_RifleCaseCloth", 0.4,
		"Bag_RifleCaseCloth2", 0.2,
		"Bag_ShotgunCaseCloth", 0.4,
		"Bag_ShotgunCaseCloth2", 0.4,
		"BookTrapping1", 2,
		"BookTrapping2", 1,
		"BookTrapping3", 0.5,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"Bullets44Box", 10,
		"Bullets45Box", 10,
		"Bullhorn", 10,
		"DeadBird", 4,
		"DeadRabbit", 4,
		"DeadSquirrel", 4,
		"EmptySandbag", 20,
		"EmptySandbag", 10,
		"FlashLight_AngleHead", 1,
		"Garbagebag", 20,
		"Garbagebag", 10,
		"Garbagebag_box", 0.5,
		"GardenHoe", 2,
		"Hat_Ranger", 10,
		"InsectRepellent", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Brown", 8,
		"HuntingRifle", 4,
		"PetrolCan", 4,
		"PickAxe", 0.5,
		"RatPoison", 1,
		"Revolver", 6,
		"Revolver_Long", 4,
		"RifleCase1", 0.4,
		"RifleCase2", 0.2,
		"Rope", 10,
		"Shotgun", 8,
		"ShotgunCase1", 0.4,
		"ShotgunCase2", 0.4,
		"Shovel", 4,
		"Shovel2", 4,
		"Tarp", 20,
		"TrapBox", 4,
		"TrapCage", 4,
		"TrapCrate", 4,
		"TrapSnare", 4,
		"TrapStick", 4,
		"Twine", 10,
		"VarmintRifle", 8,
		"WalkieTalkie4", 10,
		"WaterPurificationTablets", 1,
		"Whetstone", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.RangerSeatFront = {
	rolls = 1,
	items = {
		"223Box", 10,
		"308Box", 10,
		"Bag_ProtectiveCaseSmall_Revolver2", 0.6,
		"Bag_ProtectiveCaseSmall_Revolver2", 0.6,
		"Bag_ProtectiveCaseSmall_Revolver3", 0.4,
		"Bag_ProtectiveCaseSmall_Revolver3", 0.4,
		"Bag_RifleCaseCloth", 0.4,
		"Bag_RifleCaseCloth2", 0.2,
		"Bag_ShotgunCaseCloth", 0.4,
		"Bag_ShotgunCaseCloth2", 0.4,
		"Book_Nature", 4,
		"Book_Policing", 2,
		"BookTrapping1", 2,
		"BookTrapping2", 1,
		"BookTrapping3", 0.5,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"Bullets44Box", 10,
		"Bullets45Box", 10,
		"EmptySandbag", 10,
		"FlashLight_AngleHead", 1,
		"GardenHoe", 2,
		"Glasses_Aviators", 4,
		"Glasses_Macho", 0.5,
		"Gloves_LeatherGloves", 10,
		"Handiknife", 1,
		"Hat_Ranger", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Brown", 8,
		"HuntingMag1", 2,
		"HuntingMag2", 2,
		"HuntingMag3", 2,
		"HuntingRifle", 4,
		"InsectRepellent", 10,
		"KnifePocket", 1,
		"Magazine_Firearm", 4,
		"Magazine_Outdoors", 8,
		"Magazine_Police", 4,
		"Multitool", 0.1,
		"Paperback_Nature", 6,
		"Paperback_Policing", 4,
		"PickAxe", 0.5,
		"RatPoison", 1,
		"Revolver", 6,
		"Revolver", 6,
		"Revolver_Long", 4,
		"Revolver_Long", 4,
		"RifleCase1", 0.4,
		"RifleCase2", 0.2,
		"Shotgun", 8,
		"ShotgunCase1", 0.4,
		"ShotgunCase2", 0.4,
		"ShotgunShellsBox", 10,
		"Shovel", 4,
		"Shovel2", 4,
		"TrapBox", 4,
		"TrapCage", 4,
		"TrapCrate", 4,
		"TrapSnare", 4,
		"TrapStick", 4,
		"Twine", 10,
		"VarmintRifle", 8,
		"WalkieTalkie4", 10,
		"Whetstone", 10,
		"Whistle", 2,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.RangerSeatRear = {
	rolls = 1,
	items = {
		"223Box", 10,
		"308Box", 10,
		"Bag_ProtectiveCaseSmall_Revolver2", 0.6,
		"Bag_ProtectiveCaseSmall_Revolver2", 0.6,
		"Bag_ProtectiveCaseSmall_Revolver3", 0.4,
		"Bag_ProtectiveCaseSmall_Revolver3", 0.4,
		"Bag_RifleCaseCloth", 0.4,
		"Bag_RifleCaseCloth2", 0.2,
		"Bag_ShotgunCaseCloth", 0.4,
		"Bag_ShotgunCaseCloth2", 0.4,
		"Book_Nature", 4,
		"Book_Policing", 2,
		"BookTrapping1", 2,
		"BookTrapping2", 1,
		"BookTrapping3", 0.5,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"Bullets44Box", 10,
		"Bullets45Box", 10,
		"EmptySandbag", 10,
		"FlashLight_AngleHead", 1,
		"GardenHoe", 2,
		"Gloves_LeatherGloves", 10,
		"Handiknife", 1,
		"Hat_Ranger", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Brown", 8,
		"HuntingMag1", 2,
		"HuntingMag2", 2,
		"HuntingMag3", 2,
		"HuntingRifle", 4,
		"InsectRepellent", 10,
		"KnifePocket", 1,
		"Magazine_Firearm", 4,
		"Magazine_Outdoors", 8,
		"Magazine_Police", 4,
		"Multitool", 0.1,
		"Paperback_Nature", 6,
		"Paperback_Policing", 4,
		"PickAxe", 0.5,
		"RatPoison", 1,
		"Revolver", 6,
		"Revolver", 6,
		"Revolver_Long", 4,
		"Revolver_Long", 4,
		"RifleCase1", 0.4,
		"RifleCase2", 0.2,
		"Shotgun", 8,
		"ShotgunCase1", 0.4,
		"ShotgunCase2", 0.4,
		"ShotgunShellsBox", 10,
		"Shovel", 4,
		"Shovel2", 4,
		"TrapBox", 4,
		"TrapCage", 4,
		"TrapCrate", 4,
		"TrapSnare", 4,
		"TrapStick", 4,
		"Twine", 10,
		"VarmintRifle", 8,
		"WalkieTalkie4", 10,
		"Whetstone", 10,
		"Whistle", 2,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Ranger = {
	TruckBed = VehicleDistributions.RangerTruckBed;
	
	TruckBedOpen = VehicleDistributions.RangerTruckBed;
	
	TrailerTrunk =  VehicleDistributions.RangerTruckBed;
	
	GloveBox = VehicleDistributions.RangerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.RangerSeatFront;
	SeatRearLeft = VehicleDistributions.RangerSeatRear;
	SeatRearRight = VehicleDistributions.RangerSeatRear;
}

VehicleDistributions.FireGloveBox = {
	rolls = 1,
	items = {
		"BookFirstAid1", 0.5,
		"Bullhorn", 10,
		"Camera", 20,
		"CameraFilm", 20,
		"CameraFilm", 10,
		"Clipboard", 10,
		"FirstAidKit", 4,
		"FlashLight_AngleHead", 1,
		"Flask", 0.5,
		"Glasses_Aviators", 4,
		"Glasses_Macho", 0.5,
		"HandAxe", 10,
		"HottieZ", 1,
		"IDcard", 1,
		"Lighter", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"Paperback", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"SCBA_notank", 2,
		"Socks_Heavy", 6,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.FireTruckBed = {
	rolls = 4,
	items = {
		"Axe", 20,
		"Axe", 10,
		"Bag_MedicalBag", 1,
		"Bag_ProtectiveCaseBulky_SCBA", 1,
		"Bandage", 10,
		"BoltCutters", 10,
		"Bucket", 20,
		"Bucket", 10,
		"Bullhorn", 10,
		"CarBatteryCharger", 6,
		"Disinfectant", 4,
		"ElectronicsMag4", 4,
		"Extinguisher", 20,
		"Extinguisher", 10,
		"FlashLight_AngleHead", 1,
		"Generator", 0.1,
		"Gloves_LeatherGloves", 10,
		"Hat_Fireman", 10,
		"Jacket_Fireman", 4,
		"LongJohns", 2,
		"Oxygen_Tank", 8,
		"PetrolCan", 4,
		"PickAxe", 0.5,
		"Pills", 10,
		"Rope", 20,
		"Rope", 10,
		"RubberHose", 20,
		"RubberHose", 10,
		"SCBA", 2,
		"Shoes_WorkBoots", 6,
		"Sledgehammer", 0.5,
		"Socks_Heavy", 6,
		"Trousers_Fireman", 8,
		"Tshirt_WhiteLongSleeveTINT", 6,
		"Vest_DefaultTEXTURE_TINT", 6,
		"WalkieTalkie4", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.FireSeatFront = {
	rolls = 1,
	items = {
		"Axe", 10,
		"Bucket", 10,
		"Extinguisher", 10,
		"FlashLight_AngleHead", 1,
		"Glasses_Aviators", 4,
		"Glasses_Macho", 0.5,
		"Gloves_LeatherGloves", 10,
		"Hat_BaseballCap_FireDept", 20,
		"Hat_Fireman", 10,
		"Jacket_Fireman", 4,
		"Lighter", 4,
		"LongJohns", 2,
		"MarkerBlack", 4,
		"Oxygen_Tank", 8,
		"PickAxe", 0.5,
		"SCBA", 2,
		"Shoes_WorkBoots", 6,
		"Socks_Heavy", 6,
		"Tarp", 10,
		"Trousers_Fireman", 8,
		"Tshirt_WhiteLongSleeveTINT", 6,
		"Vest_DefaultTEXTURE_TINT", 6,
		"WalkieTalkie4", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Fire = {
	TruckBed = VehicleDistributions.FireTruckBed;
	
	TruckBedOpen = VehicleDistributions.FireTruckBed;
	
	GloveBox = VehicleDistributions.FireGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.FireSeatFront;
}

VehicleDistributions.McCoyGloveBox = {
	rolls = 1,
	items = {
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
		"BookFirstAid1", 0.5,
		"Bullhorn", 10,
		"CarpentryChisel", 4,
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"ElectronicsMag4", 0.1,
		"FirstAidKit", 1,
		"Flask", 0.5,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"HandAxe", 4,
		"Hammer", 8,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"NailsBox", 10,
		"Paperback", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"Pliers", 4,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Screwdriver", 10,
		"ScrewsBox", 8,
		"TobaccoChewing", 1,
		"Tsquare", 1,
		"Twine", 10,
		"Whetstone", 10,
		"Woodglue", 2,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.McCoyTruckBed = {
	rolls = 4,
	items = {
		"Axe", 10,
		"BoltCutters", 1,
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
		"Bullhorn", 10,
		"CarBattery2", 4,
		"CarpentryChisel", 4,
		"ElectronicsMag4", 4,
		"Generator", 0.1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"HandAxe", 4,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Log", 50,
		"Log", 20,
		"Log", 20,
		"Log", 10,
		"Log", 10,
		"MeasuringTape", 10,
		"Mov_LightConstruction", 4,
		"NormalTire2", 1,
		"PetrolCan", 20,
		"PetrolCan", 4,
		"Pliers", 4,
		"PowerBar", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 20,
		"Rope", 10,
		"RubberHose", 10,
		"Saw", 8,
		"Sledgehammer", 0.5,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"Whetstone", 10,
		"WoodAxe", 2,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.McCoySeatFront = {
	rolls = 1,
	items = {
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
		"CarpentryChisel", 4,
		"ElbowPad_Left_Workman", 1,
		"HandAxe", 4,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Pliers", 4,
		"RespiratorFilters", 2,
		"TVMagazine", 1,
		"Twine", 10,
		"Whetstone", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.McCoy = {
	TruckBed = VehicleDistributions.McCoyTruckBed;
	
	TruckBedOpen = VehicleDistributions.McCoyTruckBed;
	
	TrailerTrunk =  VehicleDistributions.McCoyTruckBed;
	
	GloveBox = VehicleDistributions.McCoyGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.McCoySeatFront;
}

VehicleDistributions.HunterGloveBox = {
	rolls = 1,
	items = {
		"223Box", 10,
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"Bag_FannyPackFront", 2,
		"Bag_LeatherWaterBag", 1,
		"Bag_ProtectiveCaseSmall_Revolver2", 0.6,
		"Bag_ProtectiveCaseSmall_Revolver3", 0.4,
		"BeefJerky", 8,
		"Book_Nature", 2,
		"BookTrapping1", 2,
		"BookTrapping2", 1,
		"BookTrapping3", 0.5,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"BottleOpener", 10,
		"Bullets44Box", 10,
		"Bullets45Box", 10,
		"Candle", 10,
		"Canteen", 10,
		"CanteenCowboy", 4,
		"CigaretteRollingPapers", 1,
		"CopperCup", 0.5,
		"FirstAidKit_Camping", 1,
		"FlashLight_AngleHead", 1,
		"Fleshing_Tool", 1,
		"Glasses_Shooting", 4,
		"HandAxe", 4,
		"Handiknife", 1,
		"HandTorch", 8,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"HandAxe", 4,
		"HandAxe_Old", 1,
		"HuntingKnife", 10,
		"InsectRepellent", 10,
		"KnifeButterfly", 8,
		"KnifePocket", 1,
		"LargeKnife", 4,
		"Lighter", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Firearm", 4,
		"Magazine_Outdoors", 8,
		"MetalCup", 1,
		"Multitool", 0.1,
		"Paperback_MilitaryHistory", 4,
		"Paperback_Nature", 8,
		"Revolver", 6,
		"Revolver_Long", 4,
		"Rope", 10,
		"Saw", 8,
		"ShemaghScarf_Green", 0.1,
		"ShotgunShellsBox", 10,
		"SmallKnife", 8,
		"Socks_Heavy", 10,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
		"Twine", 10,
		"WaterPurificationTablets", 1,
		"Whetstone", 4,
		"Whistle", 2,
		"Whetstone", 4,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.HunterTruckBed = {
	rolls = 4,
	items = {
		"223Box", 10,
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"Bag_ALICEpack", 0.5,
		"Bag_AmmoBox_Hunting", 1,
		"Bag_BigHikingBag", 2,
		"Bag_HydrationBackpack_Camo", 0.01,
		"Bag_NormalHikingBag", 4,
		"Bag_RifleCaseCloth", 0.4,
		"Bag_RifleCaseCloth2", 0.2,
		"Bag_ShotgunCaseCloth", 0.4,
		"Bag_ShotgunCaseCloth2", 0.4,
		"Book_Nature", 2,
		"BookTrapping1", 2,
		"BookTrapping2", 1,
		"BookTrapping3", 0.5,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"Bullets44Box", 10,
		"Bullets45Box", 10,
		"Candle", 10,
		"Canteen", 10,
		"CanteenCowboy", 4,
		"Cooler_Beer", 10,
		"Mov_Cot", 1,
		"DeadBird", 8,
		"DeadRabbit", 8,
		"DeadSquirrel", 8,
		"DoubleBarrelShotgun", 8,
		"FlashLight_AngleHead", 1,
		"Fleshing_Tool", 10,
		"HandAxe", 4,
		"HandAxe_Old", 1,
		"HandTorch", 8,
		"Hat_BonnieHat_CamoGreen", 8,
		"HuntingKnife", 10,
		"HuntingRifle", 4,
		"InsectRepellent", 10,
		"KnifeButterfly", 8,
		"KnifePocket", 1,
		"LargeKnife", 4,
		"Jacket_ArmyCamoGreen", 6,
		"Lantern_Propane", 4,
		"Machete", 1,
		"PetrolCan", 4,
		"PonchoGreenDOWN", 6,
		"Propane_Refill", 8,
		"Revolver", 6,
		"Revolver_Long", 4,
		"RifleCase1", 0.4,
		"RifleCase2", 0.2,
		"Rope", 10,
		"Saw", 8,
		"ShemaghScarf_Green", 0.1,
		"Shotgun", 8,
		"ShotgunCase1", 0.4,
		"ShotgunCase2", 0.4,
		"ShotgunShellsBox", 10,
		"SleepingBag_Camo_Packed", 10,
		"SmallKnife", 8,
		"TentGreen_Packed", 4,
		"TrapBox", 4,
		"TrapCage", 4,
		"TrapCrate", 4,
		"TrapSnare", 4,
		"TrapStick", 4,
		"VarmintRifle", 8,
		"Vest_Hunting_Camo", 6,
		"Vest_Hunting_CamoGreen", 6,
		"Vest_Hunting_Grey", 2,
		"Vest_Hunting_Orange", 6,
		"Whetstone", 4,
		"Whistle", 2,
		"WoodAxe", 1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.HunterSeatFront = {
	rolls = 1,
	items = {
		"223Box", 10,
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"Bag_ALICEpack", 0.5,
		"Bag_BigHikingBag", 2,
		"Bag_LeatherWaterBag", 1,
		"Bag_HydrationBackpack_Camo", 0.01,
		"Bag_NormalHikingBag", 4,
		"Bag_RifleCaseCloth", 0.4,
		"Bag_RifleCaseCloth2", 0.2,
		"Bag_ShotgunCaseCloth", 0.4,
		"Bag_ShotgunCaseCloth2", 0.4,
		"Book_Nature", 2,
		"BookTrapping1", 2,
		"BookTrapping2", 1,
		"BookTrapping3", 0.5,
		"BookTrapping4", 0.1,
		"BookTrapping5", 0.05,
		"Bullets44Box", 10,
		"Bullets45Box", 10,
		"Candle", 10,
		"Canteen", 10,
		"CanteenCowboy", 4,
		"CopperCup", 0.5,
		"DoubleBarrelShotgun", 8,
		"FlashLight_AngleHead", 1,
		"Fleshing_Tool", 1,
		"Glasses_Shooting", 4,
		"HandAxe", 4,
		"HandAxe_Old", 1,
		"HandTorch", 8,
		"Handiknife", 1,
		"Hat_BonnieHat_CamoGreen", 8,
		"HuntingKnife", 10,
		"HuntingRifle", 4,
		"InsectRepellent", 10,
		"KnifeButterfly", 8,
		"KnifePocket", 1,
		"LargeKnife", 4,
		"Lantern_Propane", 4,
		"Machete", 1,
		"Magazine_Firearm", 4,
		"Magazine_Outdoors", 8,
		"MetalCup", 1,
		"Multitool", 0.1,
		"Paperback_MilitaryHistory", 4,
		"Paperback_Nature", 8,
		"PonchoGreenDOWN", 6,
		"Propane_Refill", 8,
		"Revolver", 6,
		"Revolver_Long", 4,
		"RifleCase1", 0.8,
		"RifleCase2", 0.4,
		"Rope", 10,
		"Saw", 8,
		"ShemaghScarf_Green", 0.1,
		"Shotgun", 8,
		"ShotgunCase1", 0.8,
		"ShotgunCase2", 0.8,
		"ShotgunShellsBox", 10,
		"SleepingBag_Camo_Packed", 10,
		"SmallKnife", 8,
		"Tarp", 10,
		"TissueBox", 0.5,
		"Twine", 10,
		"Socks_Heavy", 10,
		"VarmintRifle", 8,
		"Whetstone", 4,
		"Whistle", 2,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Hunter = {
	specificId = "Hunter";
	
	TruckBed = VehicleDistributions.HunterTruckBed;
	
	TruckBedOpen = VehicleDistributions.HunterTruckBed;
	
	TrailerTrunk =  VehicleDistributions.HunterTruckBed;
	
	GloveBox = VehicleDistributions.HunterGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.HunterSeatFront;
}

VehicleDistributions.FossoilGloveBox = {
	rolls = 1,
	items = {
		"BookFirstAid1", 0.5,
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"Bullhorn", 10,
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"Flask", 0.5,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paperback", 4,
		"Paperwork", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"TobaccoChewing", 1,
		"Tsquare", 1,
		"Twine", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.FossoilTruckBed = {
	rolls = 4,
	items = {
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"Bullhorn", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_HardHat", 10,
		"MeasuringTape", 10,
		"PetrolCan", 20,
		"PetrolCan", 10,
		"PetrolCanEmpty", 50,
		"PetrolCanEmpty", 20,
		"PetrolCanEmpty", 20,
		"PowerBar", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 20,
		"RubberHose", 10,
		"Sledgehammer", 0.5,
		"Twine", 1,
		"Vest_HighViz", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.FossoilSeatFront = {
	rolls = 1,
	items = {
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BaseballCap_Fossoil", 10,
		"Hat_BaseballCap_Fossoil02", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"PetrolCanEmpty", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Tarp", 10,
		"Tshirt_Fossoil", 10,
		"Twine", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Fossoil = {
	TruckBed = VehicleDistributions.FossoilTruckBed;
	
	TruckBedOpen = VehicleDistributions.FossoilTruckBed;
	
	GloveBox = VehicleDistributions.FossoilGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.FossoilSeatFront;
}

VehicleDistributions.PostalGloveBox = {
	rolls = 1,
	items = {
		"BookFirstAid1", 0.5,
		"Clipboard", 10,
		"Flask", 0.5,
		"Gloves_LeatherGloves", 10,
		"Hat_BaseballCapBlue", 10,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"Paperback", 4,
		"Paperwork", 10,
		"Shirt_FormalWhite_ShortSleeve", 10,
		"Tie_Full", 10,
		"Twine", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.PostalSeatFront = {
	rolls = 1,
	items = {
		"Bag_Satchel_Mail", 20,
		"Hat_BaseballCapBlue", 10,
		"MarkerBlack", 4,
		"Shirt_FormalWhite_ShortSleeve", 10,
		"Tie_Full", 10,
		"Twine", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PostalTruckBed = {
	rolls = 4,
	items = {
		"Bag_BirthdayBasket", 4,
		"Bag_Mail", 20,
		"Bag_Mail", 10,
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
		"BookHusbandry1", 6,
		"BookHusbandry2", 4,
		"BookHusbandry3", 2,
		"BookHusbandry4", 1,
		"BookHusbandry5", 0.5,
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
		"ComicBook_Retail", 20,
		"ComicBook_Retail", 10,
		"CookingMag1", 0.5,
		"CookingMag2", 0.5,
		"CookingMag3", 0.5,
		"CookingMag4", 0.5,
		"CookingMag5", 0.5,
		"CookingMag6", 0.5,
		"ElectronicsMag1", 0.5,
		"ElectronicsMag2", 0.5,
		"ElectronicsMag3", 0.5,
		"ElectronicsMag4", 0.5,
		"ElectronicsMag5", 0.5,
		"EngineerMagazine1", 0.5,
		"EngineerMagazine2", 0.5,
		"FarmingMag1", 0.5,
		"FarmingMag2", 0.5,
		"FarmingMag3", 0.5,
		"FarmingMag4", 0.5,
		"FarmingMag5", 0.5,
		"FarmingMag6", 0.5,
		"FarmingMag7", 0.5,
		"FarmingMag8", 0.5,
		"FishingMag1", 0.5,
		"FishingMag2", 0.5,
		"GenericMail", 20,
		"GenericMail", 10,
		"Hat_BaseballCapBlue", 10,
		"HerbalistMag", 0.5,
		"HottieZ", 0.1,
		"HuntingMag1", 0.5,
		"HuntingMag2", 0.5,
		"HuntingMag3", 0.5,
		"KnittingMag1", 0.5,
		"KnittingMag2", 0.5,
		"Magazine_New", 50,
		"Magazine_New", 20,
		"Magazine_New", 20,
		"Magazine_New", 10,
		"Magazine_New", 10,
		"MeasuringTape", 10,
		"MechanicMag1", 0.5,
		"MechanicMag2", 0.5,
		"MechanicMag3", 0.5,
		"MetalworkMag1", 0.5,
		"MetalworkMag2", 0.5,
		"MetalworkMag3", 0.5,
		"MetalworkMag4", 0.5,
		"Newspaper_New", 50,
		"Newspaper_New", 20,
		"Newspaper_New", 20,
		"Newspaper_New", 10,
		"Newspaper_New", 10,
		"Parcel_ExtraLarge", 4,
		"Parcel_ExtraSmall", 20,
		"Parcel_ExtraSmall", 10,
		"Parcel_Large", 8,
		"Parcel_Medium", 10,
		"Parcel_Small", 20,
		"Parcel_Small", 10,
		"Shirt_FormalWhite_ShortSleeve", 10,
		"SmithingMag1", 0.5,
		"SmithingMag2", 0.5,
		"Tie_Full", 10,
		"Twine", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.Postal = {
	TruckBed = VehicleDistributions.PostalTruckBed;

	GloveBox = VehicleDistributions.PostalGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PostalSeatFront;
}

-- Note: Spiffo Vans have some stuffed animals and pens/pencils, but not mugs.
-- Spiffo suits are found on zombies only. NOT containers!

VehicleDistributions.SpiffoGloveBox = {
	rolls = 1,
	items = {
		"Apron_Spiffos", 4,
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BookFirstAid1", 0.5,
		"Flask", 0.5,
		"KeyRing_Spiffos", 1,
		"MarkerBlack", 4,
		"MenuCard", 20,
		"MenuCard", 10,
		"Money", 100,
		"Money", 50,
		"Money", 20,
		"Money", 20,
		"Money", 10,
		"Money", 10,
		"Paperback", 4,
		"Paperwork", 10,
		"PencilSpiffo", 8,
		"PenSpiffo", 8,
		"Tie_Full_Spiffo", 2,
		"Tie_Worn_Spiffo", 2,
		"Tshirt_BusinessSpiffo", 4,
		"Tshirt_SpiffoDECAL", 4,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.SpiffoTruckBed = {
	rolls = 4,
	items = {
		"Apron_Spiffos", 4,
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BorisBadger", 0.1,
		"FluffyfootBunny", 0.1,
		"FountainCup", 20,
		"FountainCup", 10,
		"FreddyFox", 0.1,
		"FurbertSquirrel", 0.1,
		"Hat_FastFood_Spiffo", 8,
		"JacquesBeaver", 0.1,
		"MenuCard", 20,
		"MenuCard", 10,
		"MoleyMole", 0.1,
		"PancakeHedgehog", 0.1,
		"Paperbag_Spiffos", 20,
		"Paperbag_Spiffos", 10,
		"PaperNapkins2", 20,
		"PaperNapkins2", 10,
		"Pop", 10,
		"Pop2", 10,
		"Pop3", 10,
		"PopBottle", 8,
		"Spiffo", 0.1,
		"SpiffoBig", 0.001,
		"Straw2", 20,
		"Straw2", 10,
		"Tie_Full_Spiffo", 2,
		"Tie_Worn_Spiffo", 2,
		"Tshirt_BusinessSpiffo", 4,
		"Tshirt_SpiffoDECAL", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.SpiffoSeatFront = {
	rolls = 1,
	items = {
		"Apron_Spiffos", 4,
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BorisBadger", 0.1,
		"FluffyfootBunny", 0.1,
		"FreddyFox", 0.1,
		"FurbertSquirrel", 0.1,
		"Hat_BaseballCap_Spiffos", 10,
		"Hat_BaseballCap_SpiffosLogo", 10,
		"Hat_FastFood_Spiffo", 8,
		"JacquesBeaver", 0.1,
		"KeyRing_Spiffos", 1,
		"MarkerBlack", 4,
		"MoleyMole", 0.1,
		"PancakeHedgehog", 0.1,
		"PencilSpiffo", 8,
		"PenSpiffo", 8,
		"Spiffo", 0.1,
		"SpiffoBig", 0.001,
		"Tie_Full_Spiffo", 2,
		"Tie_Worn_Spiffo", 2,
		"Tshirt_BusinessSpiffo", 4,
		"Tshirt_SpiffoDECAL", 4,
		"TVMagazine", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Spiffo = {
	TruckBed = VehicleDistributions.SpiffoTruckBed;
	
	GloveBox = VehicleDistributions.SpiffoGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.SpiffoSeatFront;
}

VehicleDistributions.MassGenFacGloveBox = {
	rolls = 1,
	items = {
		"BallPeenHammer", 6,
		"BlowTorch", 8,
		"BookFirstAid1", 0.5,
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
		"Clipboard", 10,
		"DrawPlate", 8,
		"ElbowPad_Left_Workman", 1,
		"File", 8,
		"FlashLight_AngleHead", 1,
		"Flask", 0.5,
		"Glasses_OldWeldingGoggles", 0.1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"HottieZ", 1,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"MetalworkingChisel", 8,
		"MetalworkingPliers", 1,
		"MetalworkingPunch", 8,
		"MetalworkMag1", 2,
		"MetalworkMag2", 2,
		"MetalworkMag3", 2,
		"MetalworkMag4", 2,
		"NutsBolts", 10,
		"Paperback", 4,
		"Paperwork", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"SmallFileSet", 8,
		"SmallPunchSet", 8,
		"SmallSaw", 8,
		"Tsquare", 1,
		"Twine", 10,
		"ViseGrips", 4,
		"Wire", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.MassGenFacTruckBed = {
	rolls = 4,
	items = {
		"BallPeenHammer", 10,
		"BlowTorch", 10,
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
		"CarBatteryCharger", 6,
		"CeramicCrucible", 10,
		"CrudeBenchVise", 1,
		"DrawPlate", 8,
		"File", 8,
		"FlashLight_AngleHead", 1,
		"Glasses_SafetyGoggles", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"IronBar", 4,
		"IronBarHalf", 6,
		"IronPiece", 10,
		"IronBarQuarter", 8,
		"MeasuringTape", 10,
		"MetalBar", 10,
		"MetalPipe", 10,
		"MetalworkingChisel", 8,
		"MetalworkingPliers", 1,
		"MetalworkingPunch", 8,
		"Mov_ElectricBlowerForge", 1,
		"Mov_LightConstruction", 4,
		"NutsBolts", 10,
		"Pliers", 8,
		"PowerBar", 10,
		"PropaneTank", 2,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"SheetMetal", 10,
		"Sledgehammer", 0.5,
		"SmallFileSet", 8,
		"SmallPunchSet", 8,
		"SmallSaw", 8,
		"SmallSheetMetal", 10,
		"SteelBar", 4,
		"SteelBarHalf", 6,
		"SteelPiece", 10,
		"SteelBarQuarter", 8,
		"Tongs", 10,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
		"WeldingMask", 10,
		"WeldingRods", 20,
		"WeldingRods", 10,
		"Wire", 20,
		"Wire", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.MassGenFacSeatFront = {
	rolls = 1,
	items = {
		"BallPeenHammer", 10,
		"BlowTorch", 10,
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
		"File", 8,
		"FlashLight_AngleHead", 1,
		"Glasses_OldWeldingGoggles", 0.1,
		"Glasses_SafetyGoggles", 10,
		"Hat_BaseballCap_MassGenfac", 20,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"HottieZ", 1,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"MetalworkingChisel", 8,
		"MetalworkingPliers", 1,
		"MetalworkingPunch", 8,
		"NutsBolts", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Sledgehammer", 0.5,
		"SmallFileSet", 8,
		"SmallPunchSet", 8,
		"SmallSaw", 8,
		"TVMagazine", 1,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
		"WeldingMask", 10,
		"WeldingRods", 10,
		"Wire", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.MassGenFac = {
	TruckBed = VehicleDistributions.MassGenFacTruckBed;
	
	GloveBox = VehicleDistributions.MassGenFacGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.MassGenFacSeatFront;
}

VehicleDistributions.TransitGloveBox = {
	rolls = 1,
	items = {
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"Bullhorn", 10,
		"Clipboard", 10,
		"Flask", 0.5,
		"ElbowPad_Left_Workman", 1,
		"ElectronicsMag4", 0.1,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"Paperback", 4,
		"Paperwork", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Tsquare", 1,
		"Twine", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.TransitTruckBed = {
	rolls = 4,
	items = {
		"BlowTorch", 10,
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"BoltCutters", 1,
		"Bullhorn", 10,
		"CarBatteryCharger", 6,
		"ElectronicsMag4", 4,
		"Generator", 0.1,
		"HandTorch", 4,
		"Hat_BuildersRespirator", 2,
		"Hat_HardHat", 10,
		"Jack", 10,
		"Jack", 10,
		"LugWrench", 10,
		"PetrolCan", 10,
		"PowerBar", 10,
		"Ratchet", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"Screwdriver", 10,
		"Sledgehammer", 0.5,
		"TirePump", 10,
		"Toolbox", 10,
		"Torch", 2,
		"Twine", 10,
		"Wrench", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.KYTransitSeat = {
	rolls = 1,
	items = {
		"ElbowPad_Left_Workman", 1,
		"Hat_BaseballCap_KYTransit", 20,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 1,
		"Whiskey", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Transit = {
	TruckBed = VehicleDistributions.TransitTruckBed;
	TruckBedOpen = VehicleDistributions.TransitTruckBed;
	
	GloveBox = VehicleDistributions.GloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.KYTransitSeat;
}

VehicleDistributions.DistilleryGloveBox = {
	rolls = 1,
	items = {
		"BookFirstAid1", 0.5,
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"Flask", 4,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"Paperback", 4,
		"Paperwork", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.DistilleryTruckBed = {
	rolls = 4,
	items = {
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Whiskey", 100,
		"Whiskey", 50,
		"Whiskey", 20,
		"Whiskey", 20,
		"Whiskey", 10,
		"Whiskey", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.DistillerySeat = {
	rolls = 1,
	items = {
		"ElbowPad_Left_Workman", 1,
		"Hat_BaseballCap_ScarletOakDistillery", 20,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 1,
		"Whiskey", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Distillery = {
	TruckBed = VehicleDistributions.DistilleryTruckBed;
	
	GloveBox = VehicleDistributions.DistilleryGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.Seat;
}

VehicleDistributions.KnoxDistillerySeat = {
	rolls = 1,
	items = {
		"ElbowPad_Left_Workman", 1,
		"Hat_BaseballCap_KnoxDistillery", 20,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 1,
		"Whiskey", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.KnoxDistillery = {
	TruckBed = VehicleDistributions.DistilleryTruckBed;
	
	GloveBox = VehicleDistributions.DistilleryGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.Seat;
}

VehicleDistributions.HeraldsGloveBox = {
	rolls = 1,
	items = {
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"Flask", 0.5,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"Paperback", 4,
		"Paperwork", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.HeraldsTruckBed = {
	rolls = 4,
	items = {
		"Newspaper_Herald_New", 100,
		"Newspaper_Herald_New", 50,
		"Newspaper_Herald_New", 20,
		"Newspaper_Herald_New", 20,
		"Newspaper_Herald_New", 10,
		"Newspaper_Herald_New", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Twine", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.Heralds = {
	TruckBed = VehicleDistributions.HeraldsTruckBed;
	
	GloveBox = VehicleDistributions.HeraldsGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.Seat;
}

VehicleDistributions.AmbulanceGloveBox = {
	rolls = 1,
	items = {
		"AlcoholWipes", 20,
		"AlcoholWipes", 10,
		"Bag_ProtectiveCaseSmall_WalkieTalkiePolice", 6,
		"Bandage", 20,
		"Bandage", 10,
		"Base.LouisvilleMap1", 0.01,
		"Base.LouisvilleMap2", 0.01,
		"Base.LouisvilleMap3", 0.01,
		"Base.LouisvilleMap4", 0.01,
		"Base.LouisvilleMap5", 0.01,
		"Base.LouisvilleMap6", 0.01,
		"Base.LouisvilleMap7", 0.01,
		"Base.LouisvilleMap8", 0.01,
		"Base.LouisvilleMap9", 0.01,
		"Base.MarchRidgeMap", 0.4,
		"Base.MuldraughMap", 0.4,
		"Base.RiversideMap", 0.4,
		"Base.RosewoodMap", 0.4,
		"Base.WestpointMap", 0.4,
		"Battery", 10,
		"BluePen", 8,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"CDplayer", 2,
		"Cigar", 0.1,
		"CigarettePack", 8,
		"CigaretteRollingPapers", 0.05,
		"Cigarillo", 2,
		"Clipboard", 10,
		"Disc_Retail", 2,
		"DuctTape", 4,
		"Earbuds", 2,
		"Eraser", 6,
		"FirstAidKit", 10,
		"Glasses_Aviators", 0.05,
		"Glasses_Sun", 0.1,
		"Gloves_LeatherGloves", 0.1,
		"Gloves_LeatherGlovesBlack", 0.05,
		"Gloves_Surgical", 10,
		"Gum", 10,
		"HandTorch", 4,
		"Hat_SurgicalMask", 10,
		"Hat_SurgicalMask", 10,
		"IDcard", 1,
		"LighterDisposable", 4,
		"Magazine", 5,
		"Magazine_Popular", 5,
		"Matches", 8,
		"MenuCard", 1,
		"Notebook", 4,
		"Notepad", 10,
		"Pager", 10,
		"Paperback", 4,
		"Paperclip", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"Pen", 8,
		"PenLight", 10,
		"Pencil", 10,
		"Receipt", 10,
		"RedPen", 8,
		"RubberBand", 6,
		"Scalpel", 10,
		"Scotchtape", 8,
		"Stethoscope", 8,
		"Tissue", 10,
		"TissueBox", 0.5,
		"TobaccoChewing", 0.05,
		"TobaccoLoose", 0.05,
		"TVMagazine", 1,
		"WalkieTalkie4", 4,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

VehicleDistributions.AmbulanceTruckBed = {
	rolls = 4,
	items = {
		"AlcoholWipes", 20,
		"AlcoholWipes", 10,
		"Bag_MedicalBag", 5,
		"Bag_ProtectiveCaseBulkyHazard", 1,
		"Bag_Satchel_Medical", 5,
		"Bandage", 20,
		"Bandage", 10,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"Bullhorn", 1,
		"CarBatteryCharger", 0.1,
		"Corset_Medical", 2,
		"Disinfectant", 20,
		"Disinfectant", 10,
		"Gloves_Surgical", 20,
		"Gloves_Surgical", 10,
		"Hat_SurgicalMask", 20,
		"Hat_SurgicalMask", 10,
		"HospitalGown", 20,
		"HospitalGown", 10,
		"Oxygen_Tank", 20,
		"Oxygen_Tank", 10,
		"PenLight", 10,
		"Pills", 20,
		"Pills", 20,
		"Pills", 10,
		"Pills", 10,
		"PillsAntiDep", 20,
		"PillsAntiDep", 10,
		"PillsBeta", 20,
		"PillsBeta", 10,
		"PillsSleepingTablets", 20,
		"PillsSleepingTablets", 10,
		"RubberHose", 20,
		"Scalpel", 20,
		"Scalpel", 10,
		"ScissorsBluntMedical", 20,
		"ScissorsBluntMedical", 10,
		"SutureNeedle", 20,
		"SutureNeedle", 10,
		"SutureNeedleHolder", 20,
		"SutureNeedleHolder", 10,
		"Tweezers", 10,
	},
	junk = {
		rolls = 1,
		items = {
			"Bag_MedicalBag", 100,
			"CorpseFemale", 0.01,
			"CorpseMale", 0.01,
			"Mov_Gurney", 50,
			"Mov_MobileBloodbag", 10,
		}
	}
}

VehicleDistributions.AmbulanceSeatFront = {
	rolls = 1,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bag_ProtectiveCaseBulkyHazard", 0.1,
		"Base.LouisvilleMap1", 0.01,
		"Base.LouisvilleMap2", 0.01,
		"Base.LouisvilleMap3", 0.01,
		"Base.LouisvilleMap4", 0.01,
		"Base.LouisvilleMap5", 0.01,
		"Base.LouisvilleMap6", 0.01,
		"Base.LouisvilleMap7", 0.01,
		"Base.LouisvilleMap8", 0.01,
		"Base.LouisvilleMap9", 0.01,
		"Base.MarchRidgeMap", 0.4,
		"Base.MuldraughMap", 0.4,
		"Base.RiversideMap", 0.4,
		"Base.RosewoodMap", 0.4,
		"Base.WestpointMap", 0.4,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"CDplayer", 2,
		"Cigar", 0.1,
		"CigarettePack", 8,
		"CigaretteRollingPapers", 0.05,
		"Cigarillo", 2,
		"CottonBalls", 10,
		"Disc_Retail", 2,
		"Disinfectant", 4,
		"Glasses_Aviators", 0.05,
		"Glasses_Sun", 0.1,
		"Gloves_Surgical", 10,
		"Hat_SurgicalCap", 10,
		"Hat_SurgicalMask", 10,
		"LighterDisposable", 4,
		"Magazine", 5,
		"Magazine_Popular", 5,
		"Matches", 8,
		"Mirror", 4,
		"Notebook", 4,
		"Notepad", 10,
		"Paperclip", 4,
		"Pen", 8,
		"Pencil", 10,
		"Pills", 20,
		"Pills", 10,
		"PillsAntiDep", 10,
		"PillsBeta", 10,
		"PillsSleepingTablets", 10,
		"Razor", 4,
		"RedPen", 8,
		"RubberBand", 6,
		"Scalpel", 10,
		"ScissorsBluntMedical", 10,
		"Scotchtape", 8,
		"Shirt_Scrubs", 8,
		"Stethoscope", 8,
		"SutureNeedle", 10,
		"SutureNeedleHolder", 10,
		"Tissue", 10,
		"TobaccoChewing", 0.05,
		"TobaccoLoose", 0.05,
		"Trousers_Scrubs", 8,
		"TVMagazine", 1,
		"Tweezers", 10,
		"WalkieTalkie2", 2,
		"WalkieTalkie3", 1,
		"Wallet", 4,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.Ambulance = {
	TruckBed = VehicleDistributions.AmbulanceTruckBed;
	
	GloveBox = VehicleDistributions.AmbulanceGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.AmbulanceSeatFront;
}

VehicleDistributions.ArmyGloveBox = {
	rolls = 1,
	items = {
		"45Clip", 8,
		"556Box", 10,
		"556Clip", 8,
		"AlcoholWipes", 8,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"Bag_ALICE_BeltSus_Camo", 2,
		"Bag_ALICE_BeltSus_Green", 2,
		"Bandage", 4,
		"Bandaid", 10,
		"Base.LouisvilleMap1", 0.01,
		"Base.LouisvilleMap2", 0.01,
		"Base.LouisvilleMap3", 0.01,
		"Base.LouisvilleMap4", 0.01,
		"Base.LouisvilleMap5", 0.01,
		"Base.LouisvilleMap6", 0.01,
		"Base.LouisvilleMap7", 0.01,
		"Base.LouisvilleMap8", 0.01,
		"Base.LouisvilleMap9", 0.01,
		"Base.MarchRidgeMap", 0.4,
		"Base.MuldraughMap", 0.4,
		"Base.RiversideMap", 0.4,
		"Base.RosewoodMap", 0.4,
		"Base.WestpointMap", 0.4,
		"Battery", 10,
		"BluePen", 8,
		"BookFirstAid1", 0.5,
		"Bullets45Box", 10,
		"Candle", 1,
		"CanteenMilitary", 10,
		"Cigar", 0.1,
		"CigarettePack", 8,
		"CigaretteRollingPapers", 0.05,
		"Cigarillo", 2,
		"DuctTape", 4,
		"Earbuds", 2,
		"ElbowPad_Left_Military", 1,
		"ElectronicsMag4", 0.1,
		"EntrenchingTool", 10,
		"Eraser", 6,
		"FirstAidKit_Military", 4,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 8,
		"Glasses_Aviators", 1,
		"Glasses_Shooting", 1,
		"Glasses_Sun", 0.1,
		"Gloves_LeatherGloves", 0.1,
		"Gloves_LeatherGlovesBlack", 0.05,
		"GraphPaper", 1,
		"HandTorch", 4,
		"Hat_BalaclavaFace", 8,
		"Hat_BalaclavaFull", 8,
		"Hat_BandanaTINT", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_GasMask", 2,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Green", 8,
		"HuntingKnife", 10,
		"IDcard", 1,
		"Kneepad_Left_Military", 4,
		"LighterDisposable", 4,
		"M14Clip", 8,
		"Magazine_Military", 10,
		"Matches", 8,
		"Mirror", 4,
		"Notebook", 4,
		"Notepad", 10,
		"Paperback_Military", 4,
		"Paperclip", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"Pen", 8,
		"Pencil", 10,
		"Pistol2", 6,
		"Receipt", 10,
		"RedPen", 8,
		"ShotgunShellsBox", 10,
		"Spork", 10,
		"Tissue", 10,
		"TissueBox", 0.5,
		"TobaccoChewing", 1,
		"TobaccoLoose", 0.05,
		"TVMagazine", 1,
		"Twine", 10,
		"WalkieTalkie5", 10,
		"WaterPurificationTablets", 1,
		"WristWatch_Left_ClassicMilitary", 1,
	},
	junk = {
		rolls = 1,
		items = {
			
		}
	}
}

VehicleDistributions.ArmyLightTruckBed = {
	rolls = 4,
	items = {
		"45Clip", 8,
		"556Box", 10,
		"556Clip", 8,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle", 2,
		"AssaultRifle2", 0.1,
		"Bag_ALICE_BeltSus_Camo", 2,
		"Bag_ALICE_BeltSus_Green", 2,
		"Bag_ALICEpack_Army", 1,
		"Bag_MedicalBag", 0.5,
		"Bag_Military", 1,
		"BoltCutters", 1,
		"Bullets45Box", 10,
		"Bullhorn", 10,
		"CanteenMilitary", 10,
		"CarBatteryCharger", 6,
		"DuctTape", 4,
		"EmptySandbag", 20,
		"EmptySandbag", 10,
		"ElbowPad_Left_Military", 1,
		"EntrenchingTool", 10,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 8,
		"Ghillie_Top", 0.1,
		"Ghillie_Trousers", 0.1,
		"Glasses_Aviators", 1,
		"Hat_Army", 4,
		"Hat_BalaclavaFace", 8,
		"Hat_BalaclavaFull", 8,
		"Hat_BaseballCapArmy", 10,
		"Hat_BeretArmy", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_GasMask", 2,
		"Hat_PeakedCapArmy", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Green", 8,
		"Jack", 2,
		"Jacket_CoatArmy", 6,
		"JerryCan", 4,
		"JerryCanEmpty", 10,
		"Kneepad_Left_Military", 4,
		"LugWrench", 4,
		"M14Clip", 8,
		"Mov_Cot", 4,
		"Pistol2", 6,
		"Ratchet", 10,
		"Screwdriver", 10,
		"Shoes_ArmyBoots", 6,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"SleepingBag_Camo_Packed", 4,
		"Tarp", 10,
		"TireIron", 4,
		"TirePump", 8,
		"Trousers_ArmyService", 8,
		"Tshirt_ArmyGreen", 10,
		"Tshirt_Profession_VeterenGreen", 10,
		"Tshirt_Profession_VeterenRed", 10,
		"Twine", 10,
		"Vest_BulletArmy", 2,
		"WalkieTalkie5", 10,
		"WaterPurificationTablets", 1,
		"Wrench", 8,
		"x2Scope", 6,
		"x4Scope", 6,
		"x8Scope", 6,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseFemale", 0.01,
			"CorpseMale", 0.01,
		}
	}
}

VehicleDistributions.ArmyLightSeatFront = {
	rolls = 1,
	items = {
		"45Clip", 8,
		"556Box", 10,
		"556Clip", 8,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle", 2,
		"AssaultRifle2", 0.1,
		"Bag_ALICE_BeltSus_Camo", 2,
		"Bag_ALICE_BeltSus_Green", 2,
		"Bag_ALICEpack_Army", 1,
		"Bag_MedicalBag", 0.5,
		"Bag_Military", 1,
		"Base.LouisvilleMap1", 0.01,
		"Base.LouisvilleMap2", 0.01,
		"Base.LouisvilleMap3", 0.01,
		"Base.LouisvilleMap4", 0.01,
		"Base.LouisvilleMap5", 0.01,
		"Base.LouisvilleMap6", 0.01,
		"Base.LouisvilleMap7", 0.01,
		"Base.LouisvilleMap8", 0.01,
		"Base.LouisvilleMap9", 0.01,
		"Base.MarchRidgeMap", 0.4,
		"Base.MuldraughMap", 0.4,
		"Base.RiversideMap", 0.4,
		"Base.RosewoodMap", 0.4,
		"Base.WestpointMap", 0.4,
		"BluePen", 8,
		"Bullets45Box", 10,
		"CanteenMilitary", 10,
		"Cigar", 0.1,
		"CigarettePack", 8,
		"CigaretteRollingPapers", 0.05,
		"Cigarillo", 2,
		"ElbowPad_Left_Military", 1,
		"EntrenchingTool", 10,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 8,
		"Ghillie_Top", 0.1,
		"Ghillie_Trousers", 0.1,
		"Glasses_Aviators", 1,
		"Hat_Army", 4,
		"Hat_BalaclavaFace", 8,
		"Hat_BalaclavaFull", 8,
		"Hat_BaseballCapArmy", 10,
		"Hat_BeretArmy", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_GasMask", 2,
		"Hat_PeakedCapArmy", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Green", 8,
		"Jacket_CoatArmy", 6,
		"Kneepad_Left_Military", 4,
		"LighterDisposable", 4,
		"M14Clip", 8,
		"Magazine_Military", 10,
		"Matches", 8,
		"Mirror", 4,
		"Notebook", 4,
		"Notepad", 10,
		"Paperclip", 4,
		"Pen", 8,
		"Pencil", 10,
		"Pistol2", 6,
		"RedPen", 8,
		"Shoes_ArmyBoots", 6,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"SleepingBag_Camo_Packed", 4,
		"TobaccoChewing", 0.05,
		"TobaccoLoose", 0.05,
		"Trousers_ArmyService", 8,
		"Tshirt_ArmyGreen", 10,
		"Tshirt_Profession_VeterenGreen", 10,
		"Tshirt_Profession_VeterenRed", 10,
		"TVMagazine", 1,
		"Twine", 10,
		"Vest_BulletArmy", 2,
		"WalkieTalkie5", 10,
		"WristWatch_Left_ClassicMilitary", 1,
		"x2Scope", 6,
		"x4Scope", 6,
		"x8Scope", 6,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.ArmyLightSeatRear = {
	rolls = 1,
	items = {
		"9mmClip", 8,
		"556Box", 10,
		"556Clip", 8,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle", 2,
		"AssaultRifle2", 0.1,
		"Bag_ALICE_BeltSus_Camo", 2,
		"Bag_ALICE_BeltSus_Green", 2,
		"Bag_ALICEpack_Army", 1,
		"Bag_MedicalBag", 0.5,
		"Bag_Military", 1,
		"Base.LouisvilleMap1", 0.01,
		"Base.LouisvilleMap2", 0.01,
		"Base.LouisvilleMap3", 0.01,
		"Base.LouisvilleMap4", 0.01,
		"Base.LouisvilleMap5", 0.01,
		"Base.LouisvilleMap6", 0.01,
		"Base.LouisvilleMap7", 0.01,
		"Base.LouisvilleMap8", 0.01,
		"Base.LouisvilleMap9", 0.01,
		"Base.MarchRidgeMap", 0.4,
		"Base.MuldraughMap", 0.4,
		"Base.RiversideMap", 0.4,
		"Base.RosewoodMap", 0.4,
		"Base.WestpointMap", 0.4,
		"BluePen", 8,
		"Bullets9mmBox", 10,
		"DuctTape", 4,
		"ElbowPad_Left_Military", 1,
		"EntrenchingTool", 10,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 8,
		"Ghillie_Top", 0.1,
		"Ghillie_Trousers", 0.1,
		"Glasses_Aviators", 1,
		"Hat_Army", 4,
		"Hat_BalaclavaFace", 8,
		"Hat_BalaclavaFull", 8,
		"Hat_BaseballCapArmy", 10,
		"Hat_BeretArmy", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_GasMask", 2,
		"Hat_PeakedCapArmy", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Green", 8,
		"Jacket_CoatArmy", 6,
		"Kneepad_Left_Military", 4,
		"M14Clip", 8,
		"Magazine_Military", 10,
		"Notebook", 4,
		"Notepad", 10,
		"Paperclip", 4,
		"Pen", 8,
		"Pencil", 10,
		"Pistol", 6,
		"Plasticbag", 8,
		"RedPen", 8,
		"Shoes_ArmyBoots", 6,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"SleepingBag_Camo_Packed", 4,
		"ToiletPaper", 4,
		"Trousers_ArmyService", 8,
		"Tshirt_ArmyGreen", 10,
		"Tshirt_Profession_VeterenGreen", 10,
		"Tshirt_Profession_VeterenRed", 10,
		"TVMagazine", 1,
		"Twine", 10,
		"Vest_BulletArmy", 2,
		"WristWatch_Left_ClassicMilitary", 1,
		"x2Scope", 6,
		"x4Scope", 6,
		"x8Scope", 6,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.ArmyLight = {
	TruckBed = VehicleDistributions.ArmyLightTruckBed;
	TruckBedOpen = VehicleDistributions.ArmyLightTruckBed;
	
	GloveBox = VehicleDistributions.ArmyGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.ArmyLightSeatFront;
	SeatRearLeft = VehicleDistributions.ArmyLightSeatRear;
	SeatRearRight = VehicleDistributions.ArmyLightSeatRear;
}

VehicleDistributions.ArmyHeavyTruckBed = {
	rolls = 4,
	items = {
		"9mmClip", 8,
		"556Box", 10,
		"556Clip", 8,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle", 2,
		"AssaultRifle2", 0.1,
		"Bag_ALICE_BeltSus_Camo", 2,
		"Bag_ALICE_BeltSus_Green", 2,
		"Bag_ALICEpack_Army", 1,
		"Bag_MedicalBag", 0.5,
		"Bag_Military", 1,
		"BoltCutters", 1,
		"Bullets9mmBox", 10,
		"Bullhorn", 10,
		"CarBatteryCharger", 6,
		"DuctTape", 4,
		"ElbowPad_Left_Military", 1,
		"ElectronicsMag4", 4,
		"EmptySandbag", 20,
		"EmptySandbag", 10,
		"EntrenchingTool", 10,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 8,
		"Generator", 1,
		"Ghillie_Top", 0.1,
		"Ghillie_Trousers", 0.1,
		"Glasses_Aviators", 1,
		"Hat_Army", 4,
		"Hat_BalaclavaFace", 8,
		"Hat_BalaclavaFull", 8,
		"Hat_BaseballCapArmy", 10,
		"Hat_BeretArmy", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_GasMask", 2,
		"Hat_PeakedCapArmy", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Green", 8,
		"Jack", 2,
		"Jacket_CoatArmy", 6,
		"JerryCan", 4,
		"JerryCanEmpty", 10,
		"Kneepad_Left_Military", 4,
		"LugWrench", 4,
		"M14Clip", 8,
		"Mov_Cot", 4,
		"PetrolCanEmpty", 10,
		"Pistol", 6,
		"Ratchet", 10,
		"Screwdriver", 10,
		"Shoes_ArmyBoots", 6,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"SleepingBag_Camo_Packed", 4,
		"Tarp", 10,
		"TireIron", 4,
		"TirePump", 8,
		"Trousers_ArmyService", 8,
		"Tshirt_ArmyGreen", 10,
		"Tshirt_Profession_VeterenGreen", 10,
		"Tshirt_Profession_VeterenRed", 10,
		"Vest_BulletArmy", 2,
		"WalkieTalkie5", 10,
		"WaterPurificationTablets", 10,
		"Wrench", 8,
		"x2Scope", 6,
		"x4Scope", 6,
		"x8Scope", 6,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseFemale", 0.01,
			"CorpseMale", 0.01,
		}
	}
}

VehicleDistributions.ArmyHeavySeatFront = {
	rolls = 1,
	items = {
		"9mmClip", 8,
		"556Box", 10,
		"556Clip", 8,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle", 2,
		"AssaultRifle2", 0.1,
		"Bag_ALICE_BeltSus_Camo", 2,
		"Bag_ALICE_BeltSus_Green", 2,
		"Bag_ALICEpack_Army", 1,
		"Bag_MedicalBag", 0.5,
		"Bag_Military", 1,
		"Base.LouisvilleMap1", 0.01,
		"Base.LouisvilleMap2", 0.01,
		"Base.LouisvilleMap3", 0.01,
		"Base.LouisvilleMap4", 0.01,
		"Base.LouisvilleMap5", 0.01,
		"Base.LouisvilleMap6", 0.01,
		"Base.LouisvilleMap7", 0.01,
		"Base.LouisvilleMap8", 0.01,
		"Base.LouisvilleMap9", 0.01,
		"Base.MarchRidgeMap", 0.4,
		"Base.MuldraughMap", 0.4,
		"Base.RiversideMap", 0.4,
		"Base.RosewoodMap", 0.4,
		"Base.WestpointMap", 0.4,
		"BluePen", 8,
		"Bullets9mmBox", 10,
		"Cigar", 0.1,
		"CigarettePack", 8,
		"CigaretteRollingPapers", 0.05,
		"Cigarillo", 2,
		"ElbowPad_Left_Military", 1,
		"EntrenchingTool", 10,
		"FlashLight_AngleHead_Army", 1,
		"GasmaskFilter", 8,
		"Ghillie_Top", 0.1,
		"Ghillie_Trousers", 0.1,
		"Glasses_Aviators", 1,
		"Hat_Army", 4,
		"Hat_BalaclavaFace", 8,
		"Hat_BalaclavaFull", 8,
		"Hat_BaseballCapArmy", 10,
		"Hat_BeretArmy", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_GasMask", 2,
		"Hat_PeakedCapArmy", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Green", 8,
		"Jacket_CoatArmy", 6,
		"Kneepad_Left_Military", 4,
		"LighterDisposable", 4,
		"M14Clip", 8,
		"Magazine_Military", 10,
		"Matches", 8,
		"Mirror", 4,
		"Notebook", 4,
		"Notepad", 10,
		"Paperclip", 4,
		"Pen", 8,
		"Pencil", 10,
		"Pistol", 6,
		"RedPen", 8,
		"Shoes_ArmyBoots", 6,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"SleepingBag_Camo_Packed", 4,
		"TobaccoChewing", 0.05,
		"TobaccoLoose", 0.05,
		"Trousers_ArmyService", 8,
		"Tshirt_ArmyGreen", 10,
		"Tshirt_Profession_VeterenGreen", 10,
		"Tshirt_Profession_VeterenRed", 10,
		"TVMagazine", 1,
		"Twine", 10,
		"Vest_BulletArmy", 2,
		"WalkieTalkie5", 10,
		"WristWatch_Left_ClassicMilitary", 1,
		"x2Scope", 6,
		"x4Scope", 6,
		"x8Scope", 6,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.ArmyHeavy = {
	TruckBed = VehicleDistributions.ArmyHeavyTruckBed;
	TruckBedOpen = VehicleDistributions.ArmyHeavyTruckBed;
	
	GloveBox = VehicleDistributions.ArmyGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.ArmyHeavySeatFront;
}

VehicleDistributions.DancerGloveBox = {
	rolls = 1,
	items = {
		"Bag_Dancer", 10,
		"Brochure", 20,
		"BottleOpener", 10,
		"Camera", 10,
		"CameraDisposable", 20,
		"CameraFilm", 20,
		"CameraFilm", 20,
		"CameraFilm", 10,
		"CameraFilm", 10,
		"Card_Valentine", 10,
		"CigaretteRollingPapers", 1,
		"Clitter", 10,
		"Comb", 10,
		"Diary1", 10,
		"Flier", 20,
		"Garter", 10,
		"Glasses_JackieO", 2,
		"Glasses_CatsEye_Sun", 2,
		"Glasses_SunCheap", 4,
		"Gloves_LeatherGloves", 1,
		"Gloves_LeatherGlovesBlack", 1,
		"HairDryer", 10,
		"HairIron", 10,
		"Hairgel", 10,
		"Hairspray2", 10,
		"Handbag", 10,
		"HottieZ", 1,
		"IDcard_Blank", 0.001,
		"IDcard_Female", 1,
		"KeyRing_Sexy", 1,
		"KnifeButterfly", 0.1,
		"LetterHandwritten", 10,
		"Lipstick", 10,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 4,
		"Magazine_Fashion", 8,
		"MakeupEyeshadow", 10,
		"MakeupFoundation", 10,
		"Mirror", 10,
		"Paperback", 4,
		"Perfume", 10,
		"Photo_Secret", 10,
		"PokerChips", 10,
		"Purse", 10,
		"RubberSpider", 0.1,
		"StockingsBlack", 6,
		"StockingsBlackSemiTrans", 6,
		"StockingsBlackTrans", 6,
		"StockingsWhite", 6,
		"SwitchKnife", 0.1,
		"Tweezers", 10,
		"TVMagazine", 10,
		"Wallet_Female", 4,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.DancerTruckBed = {
	rolls = 4,
	items = {
		"Bag_Dancer", 10,
		"Clitter", 10,
		"HairDryer", 10,
		"HairIron", 10,
		"Hairgel", 10,
		"Hairspray2", 10,
		"HottieZ", 1,
		"MakeupEyeshadow", 10,
		"MakeupFoundation", 10,
		"NormalTire1", 0.5,
		"Shoes_Fancy", 4,
		"Shoes_Strapped", 4,
		"Tissue", 10,
		"TVMagazine", 10,
		"WineBox", 1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.DancerSeatFront = {
	rolls = 1,
	items = {
		"Bag_Dancer", 10,
		"Brochure", 20,
		"Clitter", 10,
		"Comb", 10,
		"Flier", 20,
		"Glasses_JackieO", 2,
		"Glasses_CatsEye_Sun", 2,
		"Glasses_SunCheap", 4,
		"HairDryer", 10,
		"HairIron", 10,
		"Hairgel", 10,
		"Hairspray2", 10,
		"Handbag", 4,
		"KeyRing_Sexy", 1,
		"JewelleryBox", 2,
		"Lipstick", 10,
		"Magazine", 5,
		"Magazine_Fashion", 5,
		"MakeupCase_Professional", 1,
		"MakeupEyeshadow", 10,
		"MakeupFoundation", 10,
		"Mirror", 10,
		"Perfume", 10,
		"Pillow_Heart", 0.01,
		"Purse", 4,
		"Shoes_Fancy", 4,
		"Shoes_Strapped", 4,
		"StockingsBlack", 6,
		"StockingsBlackSemiTrans", 6,
		"StockingsBlackTrans", 6,
		"StockingsWhite", 6,
		"TVMagazine", 1,
		"Tweezers", 10,
		"Wallet_Female", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.DancerSeatRear = {
	rolls = 1,
	items = {
		"Bag_Dancer", 10,
		"Brochure", 20,
		"Clitter", 10,
		"Comb", 10,
		"Flier", 20,
		"Flier", 20,
		"HairDryer", 10,
		"HairIron", 10,
		"Hairgel", 10,
		"Hairspray2", 10,
		"Handbag", 4,
		"JewelleryBox", 2,
		"KeyRing_Sexy", 1,
		"Magazine_Fashion", 10,
		"MakeupCase_Professional", 1,
		"Mirror", 10,
		"Perfume", 10,
		"Pillow_Heart", 0.01,
		"Purse", 4,
		"Shoes_Fancy", 4,
		"Shoes_Strapped", 4,
		"StockingsBlack", 6,
		"StockingsBlackSemiTrans", 6,
		"StockingsBlackTrans", 6,
		"StockingsWhite", 6,
		"Tweezers", 10,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Dancer = {
	TruckBed = VehicleDistributions.DancerTruckBed;
	
	GloveBox = VehicleDistributions.DancerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontLeft = VehicleDistributions.DancerSeatFront;
	SeatRearLeft = VehicleDistributions.DancerSeatRear;
	SeatRearRight = VehicleDistributions.DancerSeatRear;
}

VehicleDistributions.EvacueeGloveBox = {
	rolls = 1,
	items = {
		"Bandage", 6,
		"Bandaid", 10,
		"BeefJerky", 4,
		"CordlessPhone", 8,
		"Crisps", 2,
		"Crisps2", 2,
		"Crisps3", 2,
		"Crisps4", 2,
		"DehydratedMeatStick", 6,
		"Disinfectant", 4,
		"Doodle", 4,
		"Glasses_Reading", 4,
		"GranolaBar", 6,
		"LetterHandwritten", 4,
		"Magazine_Popular", 10,
		"Money", 50,
		"Money", 20,
		"Necklace_Crucifix", 6,
		"Paperback", 4,
		"Peanuts", 2,
		"Photo", 1,
		"Pills", 8,
		"Pocketwatch", 0.1,
		"Pop", 4,
		"Pop2", 4,
		"Pop3", 4,
		"PopBottle", 1,
		"SewingKit", 4,
		"Sportsbottle", 0.5,
		"SunflowerSeeds", 2,
		"TissueBox", 1,
		"ToiletPaper", 4,
		"WaterBottle", 1,
		"WristWatch_Left_Expensive", 0.1,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.EvacueeTruckBed = {
	rolls = 4,
	items = {
		"Bag_BigHikingBag", 0.05,
		"Bag_DuffelBagTINT", 0.5,
		"Bag_FannyPackFront", 2,
		"Bag_FoodSnacks", 20,
		"Bag_NormalHikingBag", 0.1,
		"Bag_Satchel", 0.2,
		"Bag_Schoolbag", 0.5,
		"Bag_Schoolbag_Kids", 2,
		"Cooler_Beer", 4,
		"Cooler_Soda", 4,
		"Crisps", 2,
		"Crisps2", 2,
		"Crisps3", 2,
		"Crisps4", 2,
		"DehydratedMeatStick", 6,
		"FirstAidKit", 2,
		"GranolaBar", 6,
		"Pillow", 4,
		"Pop", 4,
		"Pop2", 4,
		"Pop3", 4,
		"PopBottle", 1,
		"PorkRinds", 2,
		"Pretzel", 2,
		"Suitcase", 20,
		"Suitcase", 50,
		"SunflowerSeeds", 2,
		"ToiletPaper", 10,
		"TortillaChips", 2,
		"WaterBottle", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.EvacueeSeatFront = {
	rolls = 1,
	items = {
		"Book_Childs", 4,
		"BorisBadger", 0.01,
		"Bricktoys", 1,
		"CatToy", 1,
		"CDplayer", 2,
		"ComicBook", 6,
		"Crayons", 1,
		"Cube", 1,
		"Diary1", 6,
		"Diary2", 6,
		"DiceBag", 1,
		"Disc_Retail", 4,
		"DogChew", 1,
		"Doll", 1,
		"Doodle", 4,
		"Earbuds", 4,
		"FirstAidKit", 2,
		"FluffyfootBunny", 0.01,
		"FreddyFox", 0.01,
		"FurbertSquirrel", 0.01,
		"Hat_Beany", 0.1,
		"Headphones", 4,
		"JacquesBeaver", 0.01,
		"Leash", 1,
		"Magazine_Childs", 10,
		"Magazine_Humor", 8,
		"Magazine_Popular", 10,
		"MoleyMole", 0.01,
		"PancakeHedgehog", 0.01,
		"PanchoDog", 0.01,
		"Paperback_Childs", 10,
		"Pillow", 4,
		"Plushabug", 0.01,
		"PopBottle", 1,
		"RubberSpider", 1,
		"Spiffo", 0.01,
		"Suitcase", 4,
		"ToiletPaper", 4,
		"Toothbrush", 10,
		"ToyBear", 1,
		"ToyCar", 1,
		"VideoGame", 4,
		"WalkieTalkie1", 2,
		"WaterBottle", 1,
		"Yoyo", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.EvacueeSeatRear = {
	rolls = 1,
	items = {
		"Bag_FannyPackFront", 2,
		"Bag_FoodSnacks", 20,
		"Bag_Satchel", 0.2,
		"Bag_Schoolbag", 0.5,
		"Bag_Schoolbag_Kids", 2,
		"BeefJerky", 4,
		"Book_Childs", 4,
		"BorisBadger", 0.01,
		"Bricktoys", 1,
		"CatToy", 1,
		"CDplayer", 2,
		"ComicBook", 6,
		"Cooler_Beer", 10,
		"Cooler_Soda", 10,
		"Crayons", 1,
		"Crisps", 2,
		"Crisps2", 2,
		"Crisps3", 2,
		"Crisps4", 2,
		"Cube", 1,
		"DehydratedMeatStick", 6,
		"Diary1", 6,
		"Diary2", 6,
		"DiceBag", 1,
		"Disc_Retail", 4,
		"DogChew", 1,
		"Doll", 1,
		"Doodle", 4,
		"Earbuds", 4,
		"FirstAidKit", 2,
		"FluffyfootBunny", 0.01,
		"FreddyFox", 0.01,
		"FurbertSquirrel", 0.01,
		"GranolaBar", 6,
		"Hat_Beany", 0.1,
		"Headphones", 4,
		"JacquesBeaver", 0.01,
		"Leash", 1,
		"Magazine_Childs", 10,
		"Magazine_Humor", 8,
		"Magazine_Popular", 10,
		"MoleyMole", 0.01,
		"PancakeHedgehog", 0.01,
		"PanchoDog", 0.01,
		"Paperback_Childs", 10,
		"Peanuts", 2,
		"Pillow", 4,
		"Plushabug", 0.01,
		"Pop", 4,
		"Pop2", 4,
		"Pop3", 4,
		"PopBottle", 1,
		"PorkRinds", 2,
		"Pretzel", 2,
		"RubberSpider", 1,
		"Spiffo", 0.01,
		"Suitcase", 10,
		"SunflowerSeeds", 2,
		"ToiletPaper", 4,
		"Toothbrush", 10,
		"TortillaChips", 2,
		"ToyBear", 1,
		"ToyCar", 1,
		"VideoGame", 4,
		"WalkieTalkie1", 2,
		"WaterBottle", 1,
		"Yoyo", 1,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Evacuee = {
	specificId = "Evacuee";
	
	TruckBed = VehicleDistributions.EvacueeTruckBed;
	TruckBedOpen = VehicleDistributions.EvacueeTruckBed;
	
	GloveBox = VehicleDistributions.EvacueeGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontLeft = VehicleDistributions.EvacueeSeatFront;
	SeatRearLeft = VehicleDistributions.EvacueeSeatRear;
	SeatRearRight = VehicleDistributions.EvacueeSeatRear;
}

VehicleDistributions.NurseGloveBox = {
	rolls = 1,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bandage", 10,
		"Book_Medical", 4,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"Clipboard", 10,
		"CordlessPhone", 10,
		"Disinfectant", 4,
		"FirstAidKit", 10,
		"Flask", 0.5,
		"Gloves_Surgical", 10,
		"Hat_SurgicalCap", 10,
		"Hat_SurgicalMask", 10,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 4,
		"Magazine_Health", 10,
		"Pager", 20,
		"Paperback_Medical", 8,
		"Paperwork", 20,
		"Paperwork", 10,
		"PenLight", 10,
		"Pills", 10,
		"PillsAntiDep", 10,
		"PillsBeta", 10,
		"PillsSleepingTablets", 10,
		"Scalpel", 10,
		"ScissorsBluntMedical", 10,
		"Screwdriver", 10,
		"Stethoscope", 8,
		"SutureNeedle", 10,
		"SutureNeedleHolder", 10,
		"Tweezers", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.NurseTruckBed = {
	rolls = 4,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bag_MedicalBag", 2,
		"Bandage", 10,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"Disinfectant", 4,
		"FirstAidKit", 10,
		"Gloves_Surgical", 10,
		"Hammer", 8,
		"Hat_SurgicalCap", 10,
		"Hat_SurgicalMask", 10,
		"Pills", 10,
		"PillsAntiDep", 10,
		"PillsBeta", 10,
		"PillsSleepingTablets", 10,
		"ScissorsBluntMedical", 10,
		"Shirt_Scrubs", 10,
		"Shoes_TrainerTINT", 8,
		"Trousers_Scrubs", 10,
		"Tshirt_Scrubs", 10,
		"Tweezers", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.NurseSeatFront = {
	rolls = 1,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bag_MedicalBag", 2,
		"Bandage", 10,
		"BookFirstAid1", 2,
		"BookFirstAid2", 1,
		"BookFirstAid3", 0.5,
		"BookFirstAid4", 0.1,
		"BookFirstAid5", 0.05,
		"Disinfectant", 4,
		"FirstAidKit", 10,
		"Gloves_Surgical", 10,
		"Hat_SurgicalCap", 10,
		"Hat_SurgicalMask", 10,
		"JacketLong_Doctor", 4,
		"Magazine_Popular", 4,
		"Magazine_Health", 10,
		"Pills", 20,
		"Pills", 20,
		"ScissorsBluntMedical", 10,
		"Shirt_Scrubs", 8,
		"Shoes_TrainerTINT", 8,
		"Trousers_Scrubs", 8,
		"Tshirt_Scrubs", 10,
		"Tweezers", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.NurseSeatRear = {
	rolls = 1,
	items = {
		"AlcoholWipes", 10,
		"Antibiotics", 4,
		"Bag_MedicalBag", 2,
		"Bandage", 10,
		"Disinfectant", 4,
		"FirstAidKit", 10,
		"Gloves_Surgical", 10,
		"Hat_SurgicalCap", 10,
		"Hat_SurgicalMask", 10,
		"Magazine_Popular", 4,
		"Magazine_Health", 10,
		"Pills", 20,
		"Pills", 20,
		"ScissorsBluntMedical", 10,
		"Shirt_Scrubs", 8,
		"Shoes_TrainerTINT", 8,
		"TobaccoChewing", 0.05,
		"TobaccoLoose", 0.05,
		"Trousers_Scrubs", 8,
		"Tshirt_Scrubs", 10,
		"Tweezers", 10,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Nurse = {
	specificId = "Nurse";
	
	TruckBed = VehicleDistributions.NurseTruckBed;
	
	TruckBedOpen = VehicleDistributions.NurseTruckBed;
	
	GloveBox = VehicleDistributions.NurseGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.NurseSeatFront;
	SeatRearLeft = VehicleDistributions.NurseSeatRear;
	SeatRearRight = VehicleDistributions.NurseSeatRear;
}

VehicleDistributions.MechanicGloveBox = {
	rolls = 1,
	items = {
		"BlowTorch", 8,
		"BookFirstAid1", 0.5,
		"BoltCutters", 8,
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"Calipers", 2,
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"File", 4,
		"FirstAidKit", 1,
		"FlashLight_AngleHead", 1,
		"Flask", 0.5,
		"Funnel", 10,
		"Gloves_LeatherGloves", 10,
		"HandTorch", 8,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Kneepad_Left_Workman", 4,
		"LugWrench", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MechanicMag1", 2,
		"MechanicMag2", 2,
		"MechanicMag3", 2,
		"MetalworkingChisel", 4,
		"MetalworkingPunch", 4,
		"NutsBolts", 10,
		"Paperback", 4,
		"Paperwork", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"Screwdriver", 10,
		"ScrewsBox", 8,
		"SmallFileSet", 4,
		"SmallPunchSet", 4,
		"SmallSaw", 4,
		"SteelWool", 10,
		"TireIron", 4,
		"TirePump", 8,
		"TobaccoChewing", 1,
		"Torch", 4,
		"Twine", 10,
		"ViseGrips", 4,
		"WeldingMask", 1,
		"Wrench", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.MechanicTruckBed = {
	rolls = 4,
	items = {
		"BlowTorch", 8,
		"Boilersuit_BlueRed", 10,
		"BoltCutters", 8,
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"Calipers", 2,
		"CarBattery1", 4,
		"CarBattery2", 2,
		"CarBattery3", 1,
		"CarBatteryCharger", 4,
		"EngineParts", 20,
		"EngineParts", 10,
		"Epoxy", 4,
		"FiberglassTape", 4,
		"File", 4,
		"FlashLight_AngleHead", 1,
		"Funnel", 10,
		"Glasses_SafetyGoggles", 8,
		"HandTorch", 8,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Jack", 10,
		"LugWrench", 4,
		"MechanicMag1", 2,
		"MechanicMag2", 2,
		"MechanicMag3", 2,
		"MetalworkingChisel", 4,
		"MetalworkingPliers", 0.5,
		"MetalworkingPunch", 4,
		"ModernBrake1", 4,
		"ModernBrake2", 2,
		"ModernBrake3", 1,
		"ModernCarMuffler1", 4,
		"ModernCarMuffler2", 2,
		"ModernCarMuffler3", 1,
		"ModernSuspension1", 4,
		"ModernSuspension2", 2,
		"ModernSuspension3", 1,
		"ModernTire1", 8,
		"ModernTire2", 6,
		"ModernTire3", 4,
		"NormalBrake1", 4,
		"NormalBrake2", 2,
		"NormalBrake3", 1,
		"NormalCarMuffler1", 4,
		"NormalCarMuffler2", 2,
		"NormalCarMuffler3", 1,
		"NormalSuspension1", 4,
		"NormalSuspension2", 2,
		"NormalSuspension3", 1,
		"NormalTire1", 10,
		"NormalTire2", 8,
		"NormalTire3", 6,
		"NutsBolts", 10,
		"PetrolCan", 4,
		"PetrolCanEmpty", 10,
		"Pliers", 8,
		"Ratchet", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"Screwdriver", 10,
		"Screws", 10,
		"Shoes_TrainerTINT", 8,
		"Sledgehammer", 0.5,
		"SmallFileSet", 4,
		"SmallPunchSet", 4,
		"SmallSaw", 4,
		"SteelWool", 10,
		"Tarp", 10,
		"TireIron", 8,
		"TirePump", 8,
		"Toolbox_Mechanic", 2,
		"Torch", 4,
		"ViseGrips", 4,
		"WeldingMask", 1,
		"Wrench", 8,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.MechanicSeatFront = {
	rolls = 1,
	items = {
		"Boilersuit_BlueRed", 10,
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"Calipers", 2,
		"ElbowPad_Left_Workman", 1,
		"Epoxy", 4,
		"FiberglassTape", 4,
		"File", 4,
		"FlashLight_AngleHead", 1,
		"Funnel", 10,
		"Glasses_SafetyGoggles", 8,
		"Gloves_LeatherGloves", 10,
		"HandTorch", 8,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Jack", 2,
		"Kneepad_Left_Workman", 4,
		"LugWrench", 4,
		"MechanicMag1", 2,
		"MechanicMag2", 2,
		"MechanicMag3", 2,
		"MetalworkingChisel", 4,
		"MetalworkingPliers", 0.5,
		"MetalworkingPunch", 4,
		"NutsBolts", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"Screwdriver", 10,
		"Screws", 10,
		"Shoes_TrainerTINT", 8,
		"Sledgehammer", 0.5,
		"SmallFileSet", 4,
		"SmallPunchSet", 4,
		"SmallSaw", 4,
		"SteelWool", 10,
		"Tarp", 10,
		"TireIron", 4,
		"TirePump", 8,
		"Torch", 4,
		"ViseGrips", 4,
		"WeldingMask", 1,
		"Wrench", 8,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Mechanic = {
	specificId = "Mechanic";
	
	TruckBed = VehicleDistributions.MechanicTruckBed;
	
	TruckBedOpen = VehicleDistributions.MechanicTruckBed;
	
	TrailerTrunk =  VehicleDistributions.MechanicTruckBed;
	
	GloveBox = VehicleDistributions.MechanicGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.MechanicSeatFront;
}

VehicleDistributions.PrisonGuardGloveBox = {
	rolls = 1,
	items = {
		"BookFirstAid1", 0.5,
		"Bullets9mmBox", 10,
		"Bullhorn", 10,
		"Clipboard", 10,
		"Danish", 1,
		"DoughnutChocolate", 1,
		"DoughnutFrosted", 1,
		"DoughnutJelly", 1,
		"DoughnutPlain", 1,
		"ElbowPad_Left_Tactical", 1,
		"FirstAidKit", 4,
		"Flask", 0.5,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"HandTorch", 10,
		"IDcard", 1,
		"Kneepad_Left_Tactical", 4,
		"Lighter", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 4,
		"Magazine_Crime", 8,
		"MenuCard", 10,
		"Notebook", 20,
		"Paperback", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"Pen", 20,
		"Pistol", 8,
		"TobaccoChewing", 10,
		"WalkieTalkie4", 10,
		"Whistle", 10,
		"WristWatch_Left_ClassicMilitary", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.PrisonGuardTruckBed = {
	rolls = 4,
	items = {
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle2", 1,
		"Bag_MedicalBag", 1,
		"Bag_Police", 1,
		"Bullets9mmBox", 10,
		"Bullets9mmBox", 20,
		"Bullhorn", 10,
		"ElbowPad_Left_Tactical", 1,
		"HandTorch", 8,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Black", 8,
		"HuntingRifle", 8,
		"Kneepad_Left_Tactical", 4,
		"M14Clip", 4,
		"Mov_RoadBarrier", 10,
		"Mov_RoadCone", 10,
		"Nightstick", 10,
		"PetrolCan", 4,
		"Pistol", 10,
		"ShinKneeGuard_L_Protective", 2,
		"Shirt_PrisonGuard", 10,
		"Shoes_Random", 8,
		"ShortBat", 1,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Trousers_PrisonGuard", 10,
		"Tshirt_DefaultTEXTURE", 6,
		"Vest_BulletPolice", 10,
		"Vest_DefaultTEXTURE", 6,
		"WalkieTalkie4", 10,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.PrisonGuardSeatFront = {
	rolls = 1,
	items = {
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle2", 1,
		"Bag_Police", 1,
		"Bag_ProtectiveCaseSmall_WalkieTalkiePolice", 6,
		"Bullets9mmBox", 10,
		"ElbowPad_Left_Tactical", 1,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"Hat_RiotHelmet", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Black", 8,
		"HuntingRifle", 8,
		"Kneepad_Left_Tactical", 4,
		"Lighter", 4,
		"M14Clip", 4,
		"Magazine", 5,
		"Magazine_Crime", 5,
		"Nightstick", 10,
		"ShinKneeGuard_L_Protective", 2,
		"Shirt_PrisonGuard", 10,
		"Shoes_Random", 8,
		"ShortBat", 1,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Trousers_PrisonGuard", 10,
		"Tshirt_DefaultTEXTURE", 6,
		"Vest_BulletPolice", 10,
		"Vest_DefaultTEXTURE", 6,
		"WalkieTalkie4", 4,
		"WristWatch_Left_ClassicMilitary", 1,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PrisonGuardSeatRear = {
	rolls = 1,
	items = {
		
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.PrisonGuard = {
	TruckBed = VehicleDistributions.PrisonGuardTruckBed;
	
	GloveBox = VehicleDistributions.PrisonGuardGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PrisonGuardSeatFront;
	SeatRearLeft = VehicleDistributions.PrisonGuardSeatRear;
	SeatRearRight = VehicleDistributions.PrisonGuardSeatRear;
}

VehicleDistributions.GardenerGloveBox = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"BookFirstAid1", 0.5,
		"BurlapPiece", 8,
		"CanteenCowboy", 0.5,
		"CigaretteRollingPapers", 1,
		"ElbowPad_Left_Workman", 1,
		"FirstAidKit", 1,
		"GardeningSprayEmpty", 6,
		"Gloves_LeatherGloves", 10,
		"HandShovel", 6,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_StrawHat", 4,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"MasonsChisel", 10,
		"MasonsTrowel", 10,
		"Paperback", 4,
		"RatPoison", 1,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
		"Twine", 10,
		-- flower seed packets
		"ChamomileBagSeed", 4,
		"LavenderBagSeed", 4,
		"MarigoldBagSeed", 4,
		"PoppyBagSeed", 4,
		"RoseBagSeed", 4,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.GardenerTruckBed = {
	rolls = 4,
	items = {
		"Bucket", 4,
		"BurlapPiece", 8,
		"ClayBrick", 50,
		"ClayBrick", 20,
		"CompostBag", 10,
		"CrushedLimestone", 10,
		"Dirtbag", 20,
		"Dirtbag", 10,
		"EmptySandbag", 20,
		"EmptySandbag", 10,
		"Fertilizer", 10,
		"GardenFork", 10,
		"GardenHoe", 2,
		"GardeningSprayEmpty", 6,
		"Gravelbag", 10,
		"HandAxe", 1,
		"HandFork", 2,
		"HandScythe", 2,
		"HandShovel", 6,
		"KnapsackSprayer", 1,
		"LargeStone", 8,
		"Limestone", 4,
		"LeafRake", 10,
		"MasonsChisel", 10,
		"MasonsTrowel", 10,
		"PetrolCan", 4,
		"PickAxe", 0.5,
		"Rake", 10,
		"RatPoison", 1,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 20,
		"RubberHose", 10,
		"Sandbag", 10,
		"Scythe", 10,
		"StoneBlock", 50,
		"StoneBlock", 20,
		"Twine", 10,
		"WateredCan", 6,
		-- flower seed packets
		"ChamomileBagSeed", 4,
		"LavenderBagSeed", 4,
		"MarigoldBagSeed", 4,
		"PoppyBagSeed", 4,
		"RoseBagSeed", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.GardenerSeatFront = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"BurlapPiece", 8,
		"Dungarees", 6,
		"ElbowPad_Left_Workman", 1,
		"GardenFork", 10,
		"GardenHoe", 2,
		"GardeningSprayEmpty", 6,
		"Gloves_LeatherGloves", 10,
		"HandAxe", 1,
		"HandFork", 2,
		"HandScythe", 2,
		"HandShovel", 6,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_StrawHat", 4,
		"KnapsackSprayer", 1,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MasonsChisel", 10,
		"MasonsTrowel", 10,
		"Rake", 10,
		"RatPoison", 1,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Shoes_Wellies", 4,
		"Twine", 10,
		"WateredCan", 6,
		-- flower seed packets
		"ChamomileBagSeed", 4,
		"LavenderBagSeed", 4,
		"MarigoldBagSeed", 4,
		"PoppyBagSeed", 4,
		"RoseBagSeed", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Gardener = {
	
	TruckBed = VehicleDistributions.GardenerTruckBed;
	
	TruckBedOpen = VehicleDistributions.GardenerTruckBed;
	
	TrailerTrunk =  VehicleDistributions.GardenerTruckBed;
	
	GloveBox = VehicleDistributions.GardenerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.GardenerSeatFront;
}

VehicleDistributions.RancherGloveBox = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"BookFirstAid1", 0.5,
		"BurlapPiece", 8,
		"CanteenCowboy", 0.5,
		"CigaretteRollingPapers", 1,
		"ElbowPad_Left_Workman", 1,
		"FirstAidKit", 1,
		"Fleshing_Tool", 1,
		"GardeningSprayEmpty", 6,
		"Glasses", 2,
		"Glasses_Aviators", 0.5,
		"Glasses_Sun", 2,
		"Gloves_LeatherGloves", 10,
		"HandScythe", 6,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_Cowboy", 8,
		"Hat_StrawHat", 2,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Paperback", 4,
		"Pliers", 4,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"SheepElectricShears", 20,
		"SheepShears", 10,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
		"Twine", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.RancherTruckBed = {
	rolls = 4,
	items = {
		"AnimalFeedBag", 10,
		"BarbedWire", 20,
		"BarbedWire", 10,
		"BurlapPiece", 8,
		"Bucket", 4,
		"Dirtbag", 10,
		"Dirtbag", 20,
		"EmptySandbag", 10,
		"EmptySandbag", 20,
		"Fleshing_Tool", 10,
		"GardenFork", 10,
		"GardenHoe", 2,
		"Gravelbag", 10,
		"HandAxe", 1,
		"HandFork", 2,
		"HandScythe", 6,
		"Hat_Cowboy", 4,
		"KnapsackSprayer", 1,
		"LeafRake", 10,
		"Mov_HaystackSingle", 20,
		"Mov_HaystackSingle", 20,
		"Mov_HaystackSingle", 10,
		"Mov_HaystackSingle", 10,
		"Mov_SaltLick", 20,
		"PetrolCan", 4,
		"PickAxe", 0.5,
		"Pliers", 4,
		"Rake", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Rope", 20,
		"Rope", 10,
		"RubberHose", 20,
		"RubberHose", 10,
		"Sandbag", 10,
		"Scythe", 10,
		"SheepElectricShears", 20,
		"SheepShears", 10,
		"Twine", 10,
		"WheatSheafDried", 10,
		"WheatSack", 20,
		"WheatSeed", 10,
		"WheatSeedSack", 20,
		"Wire", 20,
		"Wire", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.RancherSeatFront = {
	rolls = 1,
	items = {
		"AnimalFeedBag", 10,
		"Bag_LeatherWaterBag", 1,
		"BurlapPiece", 8,
		"ElbowPad_Left_Workman", 1,
		"Dungarees", 6,
		"Fleshing_Tool", 1,
		"GardenFork", 10,
		"GardenHoe", 2,
		"Glasses", 2,
		"Glasses_Aviators", 0.5,
		"Glasses_Sun", 2,
		"Gloves_LeatherGloves", 10,
		"HandAxe", 1,
		"HandFork", 2,
		"HandScythe", 6,
		"Hat_Cowboy", 8,
		"Hat_StrawHat", 2,
		"KnapsackSprayer", 1,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"Pliers", 4,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Scythe", 10,
		"SheepElectricShears", 20,
		"SheepShears", 10,
		"Shoes_Wellies", 4,
		"Twine", 10,
		"Wire", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Rancher = {
	specificId = "Rancher";
	
	TruckBed = VehicleDistributions.RancherTruckBed;
	
	TruckBedOpen = VehicleDistributions.RancherTruckBed;
	
	TrailerTrunk =  VehicleDistributions.RancherTruckBed;
	
	GloveBox = VehicleDistributions.RancherGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.RancherSeatFront;
}

VehicleDistributions.PlumberGloveBox = {
	rolls = 1,
	items = {
		"Bleach", 20,
		"BlowTorch", 8,
		"BookFirstAid1", 0.5,
		"CigaretteRollingPapers", 1,
		"Clipboard", 10,
		"DuctTape", 10,
		"ElbowPad_Left_Workman", 1,
		"FirstAidKit", 1,
		"FlashLight_AngleHead", 1,
		"Flask", 0.5,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_Dish", 10,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paperback", 4,
		"Paperwork", 10,
		"PipeWrench", 20,
		"Pliers", 8,
		"Receipt", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"SteelWool", 10,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
		"ViseGrips", 4,
		"WeldingRods", 8,
		"Wrench", 20,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.PlumberTruckBed = {
	rolls = 4,
	items = {
		"Bleach", 20,
		"BlowTorch", 8,
		"Boilersuit", 6,
		"Bucket", 8,
		"DuctTape", 10,
		"FlashLight_AngleHead", 1,
		"Garbagebag", 20,
		"Garbagebag_box", 4,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_Dish", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"MeasuringTape", 10,
		"MetalPipe", 20,
		"MetalPipe", 10,
		"Mov_BlueComboWasherDryer", 4,
		"Mov_ChromeSink", 10,
		"Mov_DarkIndustrialSink", 10,
		"Mov_FancyHangingSink", 10,
		"Mov_FancyToilet", 50,
		"Mov_IndustrialSink", 10,
		"Mov_LowToilet", 20,
		"Mov_Urinal", 4,
		"Mov_WallShower", 4,
		"Mov_WhiteSink", 10,
		"Mov_WhiteHangingSink", 10,
		"PipeWrench", 20,
		"Pliers", 8,
		"Plunger", 50,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"Shoes_Wellies", 8,
		"Sledgehammer", 0.5,
		"SteelWool", 10,
		"Tarp", 10,
		"Toolbox", 2,
		"ViseGrips", 4,
		"WeldingRods", 8,
		"Wrench", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.PlumberSeatFront = {
	rolls = 1,
	items = {
		"Bleach", 20,
		"BlowTorch", 8,
		"Boilersuit", 6,
		"Bucket", 8,
		"DuctTape", 10,
		"ElbowPad_Left_Workman", 1,
		"FlashLight_AngleHead", 1,
		"Glasses_OldWeldingGoggles", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_Dish", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"PipeWrench", 20,
		"Pliers", 8,
		"Plunger", 50,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"Shoes_Wellies", 8,
		"Sledgehammer", 0.5,
		"SteelWool", 10,
		"Toolbox", 2,
		"ViseGrips", 4,
		"WeldingRods", 8,
		"Wrench", 20,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Plumber = {
	specificId = "Plumber";
	
	TruckBed = VehicleDistributions.PlumberTruckBed;
	
	TruckBedOpen = VehicleDistributions.PlumberTruckBed;
	
	TrailerTrunk =  VehicleDistributions.PlumberTruckBed;
	
	GloveBox = VehicleDistributions.PlumberGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PlumberSeatFront;
}

VehicleDistributions.LaundryGloveBox = {
	rolls = 1,
	items = {
		"Bleach", 20,
		"BookFirstAid1", 0.5,
		"CigaretteRollingPapers", 1,
		"FirstAidKit", 1,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"Paperback", 4,
		"Receipt", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"TobaccoChewing", 1,
		"TobaccoLoose", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.LaundryTruckBed = {
	rolls = 4,
	items = {
		"Bag_LaundryLinen", 50,
		"Bag_LaundryLinen", 20,
		"Bag_LaundryLinen", 20,
		"Bag_LaundryLinen", 10,
		"Bag_LaundryLinen", 10,
		"Bleach", 20,
		"Mov_WashingBin", 20,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.LaundrySeatFront = {
	rolls = 1,
	items = {
		"Bag_Laundry", 20,
		"Bleach", 20,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Laundry = {
	
	TruckBed = VehicleDistributions.LaundryTruckBed;
	
	TruckBedOpen = VehicleDistributions.LaundryTruckBed;
	
	TrailerTrunk =  VehicleDistributions.LaundryTruckBed;
	
	GloveBox = VehicleDistributions.LaundryGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.LaundrySeatFront;
}

VehicleDistributions.CourierGloveBox = {
	rolls = 1,
	items = {
		"BookFirstAid1", 0.5,
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"Flask", 0.5,
		"Gloves_LeatherGloves", 10,
		"Hat_BaseballCapBlue", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Paperback", 4,
		"Paperwork", 10,
		"Shirt_FormalWhite_ShortSleeve", 10,
		"Tie_Full", 10,
		"Twine", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.CourierSeatFront = {
	rolls = 1,
	items = {
		"Bag_Satchel_Mail", 20,
		"ElbowPad_Left_Workman", 1,
		"Hat_BaseballCap_USL", 20,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"Shirt_FormalWhite_ShortSleeve", 10,
		"Tie_Full", 10,
		"Twine", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.CourierTruckBed = {
	rolls = 4,
	items = {
		"Hat_BaseballCap_USL", 10,
		"MeasuringTape", 10,
		"Parcel_ExtraLarge", 50,
		"Parcel_ExtraLarge", 20,
		"Parcel_ExtraLarge", 10,
		"Parcel_ExtraSmall", 50,
		"Parcel_ExtraSmall", 20,
		"Parcel_ExtraSmall", 10,
		"Parcel_Large", 50,
		"Parcel_Large", 20,
		"Parcel_Large", 10,
		"Parcel_Medium", 50,
		"Parcel_Medium", 20,
		"Parcel_Medium", 10,
		"Parcel_Small", 50,
		"Parcel_Small", 20,
		"Parcel_Small", 10,
		"Shirt_FormalWhite_ShortSleeve", 10,
		"Tie_Full", 10,
		"Twine", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.Courier = {
	TruckBed = VehicleDistributions.CourierTruckBed;

	GloveBox = VehicleDistributions.CourierGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.CourierSeatFront;
}

VehicleDistributions.CateringGloveBox = {
	rolls = 1,
	items = {
		"Aluminum", 20,
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BookFirstAid1", 0.5,
		"BottleOpener", 4,
		"CigarettePack", 8,
		"Clipboard", 10,
		"CookingMag1", 0.5,
		"CookingMag2", 0.5,
		"CookingMag3", 0.5,
		"CookingMag4", 0.5,
		"CookingMag5", 0.5,
		"CookingMag6", 0.5,
		"Corkscrew", 4,
		"DishCloth", 10,
		"Flask", 0.5,
		"Hat_ChefHat", 8,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperback", 4,
		"Paperback_Diet", 8,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
		"RecipeClipping", 10,
		"Timer", 8,
		"Wine", 20,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.CateringSeatFront = {
	rolls = 1,
	items = {
		"Aluminum", 20,
		"Apron_White", 8,
		"BakingPan", 4,
		"BakingTray", 4,
		"BastingBrush", 4,
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BottleOpener", 4,
		"CannedBellPepper", 10,
		"CannedBroccoli", 10,
		"CannedCabbage", 10,
		"CannedCarrots", 10,
		"CannedEggplant", 10,
		"CannedLeek", 10,
		"CannedPotato", 10,
		"CannedRedRadish", 10,
		"CannedTomato", 10,
		"CarvingFork2", 4,
		"CigarettePack", 8,
		"CookingMag1", 0.5,
		"CookingMag2", 0.5,
		"CookingMag3", 0.5,
		"CookingMag4", 0.5,
		"CookingMag5", 0.5,
		"CookingMag6", 0.5,
		"Corkscrew", 4,
		"CuttingBoardPlastic", 6,
		"DishCloth", 10,
		"GridlePan", 4,
		"GroceryBag1", 20,
		"GroceryBag2", 10,
		"GroceryBag3", 10,
		"GroceryBag4", 10,
		"GroceryBag5", 10,
		"GroceryBagGourmet", 8,
		"Hat_ChefHat", 8,
		"IcePick", 0.5,
		"Jacket_Chef", 10,
		"KitchenKnife", 2,
		"KitchenTongs", 4,
		"KnifeFillet", 2,
		"KnifeParing", 2,
		"Ladle", 4,
		"MarkerBlack", 4,
		"MeatCleaver", 1,
		"MuffinTray", 4,
		"Notepad", 10,
		"OvenMitt", 8,
		"Pan", 4,
		"Pencil", 10,
		"Pot", 4,
		"Receipt", 10,
		"RecipeClipping", 10,
		"RoastingPan", 4,
		"Saucepan", 4,
		"Sheet", 4,
		"Shoes_Black", 8,
		"Strainer", 4,
		"Timer", 8,
		"Trousers_Chef", 10,
		"Whisk", 4,
		"Wine", 20,
		"Wine2", 20,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.CateringTruckBed = {
	rolls = 4,
	items = {
		"Aluminum", 20,
		"Apron_White", 8,
		"Bag_PicnicBasket", 1,
		"BakingPan", 4,
		"BakingTray", 4,
		"BastingBrush", 4,
		"BookCooking1", 2,
		"BookCooking2", 1,
		"BookCooking3", 0.5,
		"BookCooking4", 0.1,
		"BookCooking5", 0.05,
		"BottleOpener", 4,
		"CannedBellPepper", 10,
		"CannedBroccoli", 10,
		"CannedCabbage", 10,
		"CannedCarrots", 10,
		"CannedEggplant", 10,
		"CannedLeek", 10,
		"CannedPotato", 10,
		"CannedRedRadish", 10,
		"CannedTomato", 10,
		"CarvingFork2", 4,
		"CookingMag1", 0.5,
		"CookingMag2", 0.5,
		"CookingMag3", 0.5,
		"CookingMag4", 0.5,
		"CookingMag5", 0.5,
		"CookingMag6", 0.5,
		"Cooler_Beer", 10,
		"Cooler_Meat", 10,
		"Cooler_Soda", 10,
		"Corkscrew", 1,
		"CuttingBoardPlastic", 6,
		"DishCloth", 10,
		"GridlePan", 4,
		"GroceryBag1", 20,
		"GroceryBag2", 10,
		"GroceryBag3", 10,
		"GroceryBag4", 10,
		"GroceryBag5", 10,
		"GroceryBagGourmet", 8,
		"Hat_ChefHat", 8,
		"IcePick", 0.5,
		"Jacket_Chef", 10,
		"KitchenKnife", 2,
		"KitchenTongs", 4,
		"KnifeFillet", 2,
		"KnifeParing", 2,
		"Ladle", 4,
		"MeatCleaver", 1,
		"MuffinTray", 4,
		"OvenMitt", 8,
		"Pan", 4,
		"Pot", 4,
		"RecipeClipping", 10,
		"RoastingPan", 4,
		"Saucepan", 4,
		"Sheet", 4,
		"Shoes_Black", 8,
		"Strainer", 4,
		"Timer", 4,
		"Trousers_Chef", 10,
		"Whisk", 4,
		"Wine", 20,
		"Wine2", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.Catering = {
	TruckBed = VehicleDistributions.CateringTruckBed;

	GloveBox = VehicleDistributions.CateringGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.CateringSeatFront;
}

VehicleDistributions.BanditGloveBox = {
	rolls = 1,
	items = {
		"Bag_MoneyBag", 4,
		"Base.HempBagSeed", 4,
		"BottleOpener", 10,
		"Bullets38Box", 10,
		"Bullets44Box", 8,
		"Bullets45Box", 6,
		"Cigar", 8,
		"CordlessPhone", 10,
		"DuctTape", 10,
		"Flask", 20,
		"Garter", 8,
		"Glasses_Aviators", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_HalloweenMaskDevil", 0.05,
		"Hat_HalloweenMaskMonster", 0.05,
		"Hat_HalloweenMaskPumpkin", 0.05,
		"Hat_HalloweenMaskSkeleton", 0.05,
		"Hat_HalloweenMaskVampire", 0.05,
		"Hat_HalloweenMaskWitch", 0.05,
		"HottieZ", 10,
		"KnifeButterfly", 10,
		"Lighter", 4,
		"Magazine_Crime", 3,
		"Magazine_Firearm", 3,
		"Magazine_Popular", 1,
		"Money", 20,
		"Money", 10,
		"Photo_Secret", 20,
		"Photo_Secret", 10,
		"Pills", 50,
		"PillsVitamins", 50,
		"Pocketwatch", 4,
		"Ring_Left_RingFinger_Gold", 4,
		"Ring_Left_RingFinger_GoldDiamond", 2,
		"Ring_Left_RingFinger_GoldRuby", 2,
		"ShotgunShellsBox", 10,
		"SwitchKnife", 10,
		"TobaccoChewing", 10,
		"WalkieTalkie4", 10,
		"WristWatch_Left_Expensive", 8,
		"Zipties", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.BanditTruckBed = {
	rolls = 4,
	items = {
		"AmmoStrap_Bullets", 1,
		"AmmoStrap_Shells", 1,
		"Bag_BurglarBag", 10,
		"Bag_MoneyBag", 20,
		"Bag_WeaponBag", 1,
		"Base.HempBagSeed", 1,
		"BeerBottle", 50,
		"BeerBottle", 20,
		"BeerBottle", 20,
		"BeerBottle", 10,
		"BeerBottle", 10,
		"BeerCan", 50,
		"BeerCan", 20,
		"BeerCan", 20,
		"BeerCan", 10,
		"BeerCan", 10,
		"Bullets38Box", 10,
		"Bullets44Box", 8,
		"Bullets45Box", 6,
		"Cooler_Beer", 10,
		"DoubleBarrelShotgunSawnoff", 4,
		"GunLight", 1,
		"KnifeButterfly", 10,
		"Laser", 2,
		"RecoilPad", 2,
		"Revolver", 6,
		"Revolver_Long", 4,
		"Revolver_Short", 8,
		"ShotgunSawnoff", 4,
		"ShotgunShellsBox", 10,
		"SwitchKnife", 10,
		"Vest_BulletCivilian", 2,
		"x2Scope", 2,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.BanditSeatFront = {
	rolls = 1,
	items = {
		"Bag_BurglarBag", 10,
		"Bag_MoneyBag", 10,
		"Base.HempBagSeed", 4,
		"Bra_Strapless_AnimalPrint", 0.5,
		"Bra_Strapless_FrillyBlack", 0.5,
		"Bra_Strapless_FrillyPink", 0.5,
		"Bra_Strapless_RedSpots", 0.5,
		"Bra_Straps_AnimalPrint", 0.5,
		"Bra_Straps_FrillyBlack", 0.5,
		"Bra_Straps_FrillyPink", 0.5,
		"Bullets38Box", 10,
		"Bullets44Box", 8,
		"Bullets45Box", 6,
		"FrillyUnderpants_Black", 1,
		"FrillyUnderpants_Pink", 1,
		"FrillyUnderpants_Red", 1,
		"Garter", 1,
		"Gloves_LeatherGloves", 10,
		"Hat_Cowboy", 8,
		"Hat_HalloweenMaskDevil", 0.05,
		"Hat_HalloweenMaskMonster", 0.05,
		"Hat_HalloweenMaskPumpkin", 0.05,
		"Hat_HalloweenMaskSkeleton", 0.05,
		"Hat_HalloweenMaskVampire", 0.05,
		"Hat_HalloweenMaskWitch", 0.05,
		"HottieZ", 10,
		"KnifeButterfly", 10,
		"Magazine_Crime", 3,
		"Magazine_Firearm", 3,
		"Magazine_Popular", 1,
		"Pills", 10,
		"PillsVitamins", 10,
		"Revolver", 6,
		"Revolver_Long", 4,
		"Revolver_Short", 8,
		"Shirt_Denim", 10,
		"Shirt_FormalTINT", 10,
		"Shirt_HawaiianTINT", 8,
		"ShotgunShellsBox", 10,
		"SwitchKnife", 10,
		"Trousers_Denim", 10,
		"WalkieTalkie4", 10,
		"WristWatch_Left_Expensive", 8,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.BanditSeatRear = {
	rolls = 1,
	items = {
		"AmmoStrap_Bullets", 1,
		"AmmoStrap_Shells", 1,
		"Bag_BurglarBag", 10,
		"Bag_MoneyBag", 10,
		"Base.HempBagSeed", 4,
		"BeerBottle", 20,
		"BeerBottle", 10,
		"BeerCan", 20,
		"BeerCan", 10,
		"Bra_Strapless_AnimalPrint", 0.5,
		"Bra_Strapless_FrillyBlack", 0.5,
		"Bra_Strapless_FrillyPink", 0.5,
		"Bra_Strapless_RedSpots", 0.5,
		"Bra_Straps_AnimalPrint", 0.5,
		"Bra_Straps_FrillyBlack", 0.5,
		"Bra_Straps_FrillyPink", 0.5,
		"Bullets38Box", 10,
		"Bullets44Box", 8,
		"Bullets45Box", 6,
		"Cooler_Beer", 10,
		"DoubleBarrelShotgunSawnoff", 4,
		"FrillyUnderpants_Black", 1,
		"FrillyUnderpants_Pink", 1,
		"FrillyUnderpants_Red", 1,
		"Garter", 1,
		"Gloves_LeatherGloves", 10,
		"GunLight", 1,
		"Hat_Cowboy", 8,
		"Hat_HalloweenMaskDevil", 0.05,
		"Hat_HalloweenMaskMonster", 0.05,
		"Hat_HalloweenMaskPumpkin", 0.05,
		"Hat_HalloweenMaskSkeleton", 0.05,
		"Hat_HalloweenMaskVampire", 0.05,
		"Hat_HalloweenMaskWitch", 0.05,
		"HottieZ", 10,
		"KnifeButterfly", 10,
		"Laser", 2,
		"Magazine_Crime", 3,
		"Magazine_Firearm", 3,
		"Magazine_Popular", 1,
		"Pills", 10,
		"PillsVitamins", 10,
		"RecoilPad", 2,
		"Revolver", 6,
		"Revolver_Long", 4,
		"Revolver_Short", 8,
		"Shirt_Denim", 10,
		"Shirt_FormalTINT", 10,
		"Shirt_HawaiianTINT", 8,
		"ShotgunSawnoff", 4,
		"ShotgunShellsBox", 10,
		"SwitchKnife", 10,
		"TissueBox", 0.5,
		"Trousers_Denim", 10,
		"Vest_BulletCivilian", 2,
		"WalkieTalkie4", 10,
		"x2Scope", 2,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Bandit = {
	specificId = "Bandit";
	
	TruckBed = VehicleDistributions.BanditTruckBed;
	TruckBedOpen = VehicleDistributions.BanditTruckBed;
	
	GloveBox = VehicleDistributions.BanditGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.BanditSeatFront;
	SeatRearLeft = VehicleDistributions.BanditSeatRear;
	SeatRearRight = VehicleDistributions.BanditSeatRear;
}

VehicleDistributions.PoliceSWATGloveBox = {
	rolls = 1,
	items = {
		"308Box", 10,
		"556Box", 10,
		"BoltCutters", 8,
		"BookAiming4", 0.5,
		"BookAiming5", 0.1,
		"BookReloading4", 0.5,
		"BookReloading5", 0.1,
		"BookFirstAid1", 1,
		"Bullets44Box", 10,
		"Bullets9mmBox", 10,
		"Bullhorn", 20,
		"Clipboard", 10,
		"Danish", 1,
		"DoughnutChocolate", 1,
		"DoughnutFrosted", 1,
		"DoughnutJelly", 1,
		"DoughnutPlain", 1,
		"ElbowPad_Left_Tactical", 1,
		"FirstAidKit", 4,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"Hat_BalaclavaFace", 4,
		"Hat_BalaclavaFull", 4,
		"Hat_BaseballCap_SWAT", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_SWAT", 8,
		"Kneepad_Left_Tactical", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Notebook", 20,
		"Paperwork", 20,
		"Paperwork", 10,
		"Pen", 20,
		"Pistol", 8,
		"Revolver_Long", 4,
		"Rope", 10,
		"SCBA_notank", 1,
		"ShotgunShellsBox", 10,
		"ThighProtective_L", 1,
		"WalkieTalkie4", 10,
		"WristWatch_Left_ClassicMilitary", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.PoliceSWATTruckBed = {
	rolls = 4,
	items = {
		"Bag_AmmoBox", 1,
		"Bag_AmmoBox_308", 1,
		"Bag_AmmoBox_9mm", 1,
		"Bag_AmmoBox_ShotgunShells", 1,
		"Bag_ProtectiveCaseBulkyAmmo_308", 1,
		"Bag_ProtectiveCaseBulkyAmmo_556", 1,
		"Bag_ProtectiveCaseBulkyAmmo_9mm", 1,
		"Bag_ProtectiveCaseBulky_SCBA", 1,
		"Bag_ProtectiveCaseBulkyAmmo_ShotgunShells", 1,
		"Bag_ProtectiveCaseSmall_WalkieTalkiePolice", 6,
		"308Box", 10,
		"556Box", 20,
		"556Box", 10,
		"556Clip", 8,
		"AmmoStrap_Bullets", 8,
		"AmmoStrap_Shells", 8,
		"AssaultRifle", 4,
		"Bag_MedicalBag", 2,
		"Bag_Police", 4,
		"Boilersuit_SWAT", 8,
		"BoltCutters", 8,
		"Bullets44Box", 10,
		"Bullets9mmBox", 10,
		"Bullhorn", 20,
		"Crowbar", 8,
		"ElbowPad_Left_Tactical", 1,
		"HandTorch", 4,
		"Hat_EarMuff_Protectors", 8,
		"Hat_SWAT", 8,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Black", 8,
		"HuntingRifle", 8,
		"Kneepad_Left_Tactical", 4,
		"Mov_RoadBarrier", 10,
		"Mov_RoadCone", 10,
		"Nightstick", 10,
		"Oxygen_Tank", 8,
		"PetrolCan", 4,
		"Pistol", 10,
		"Revolver_Long", 4,
		"Rope", 10,
		"SCBA", 2,
		"ShinKneeGuard_L_Protective", 2,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Sledgehammer", 2,
		"ThighProtective_L", 1,
		"Vest_BulletSWAT", 8,
		"WalkieTalkie4", 4,
		"x2Scope", 8,
		"x4Scope", 4,
		"x8Scope", 2,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.PoliceSWATSeatFront = {
	rolls = 1,
	items = {
		"308Box", 10,
		"556Box", 10,
		"556Clip", 8,
		"AmmoStrap_Bullets", 8,
		"AmmoStrap_Shells", 8,
		"Bag_ProtectiveCaseSmall_WalkieTalkiePolice", 6,
		"Boilersuit_SWAT", 8,
		"BoltCutters", 8,
		"BookAiming4", 0.5,
		"BookAiming5", 0.1,
		"BookReloading4", 0.5,
		"BookReloading5", 0.1,
		"BookFirstAid1", 1,
		"Bullets44Box", 10,
		"Bullets9mmBox", 10,
		"Bullhorn", 20,
		"Crowbar", 8,
		"ElbowPad_Left_Tactical", 1,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"HandTorch", 4,
		"Hat_BalaclavaFace", 4,
		"Hat_BalaclavaFull", 4,
		"Hat_BaseballCap_SWAT", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_SWAT", 8,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Black", 8,
		"Kneepad_Left_Tactical", 4,
		"Lighter", 4,
		"Nightstick", 10,
		"Oxygen_Tank", 8,
		"Pistol", 10,
		"Revolver_Long", 4,
		"Rope", 10,
		"SCBA", 2,
		"ShinKneeGuard_L_Protective", 2,
		"Shirt_CamoUrban", 6,
		"Shoes_ArmyBoots", 6,
		"ShotgunShellsBox", 10,
		"Sledgehammer", 8,
		"ThighProtective_L", 1,
		"Trousers_CamoUrban", 6,
		"Tshirt_CamoUrban", 8,
		"Vest_BulletSWAT", 8,
		"WalkieTalkie4", 4,
		"WristWatch_Left_ClassicMilitary", 1,
		"x2Scope", 8,
		"x4Scope", 4,
		"x8Scope", 2,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PoliceSWATSeatRear = {
	rolls = 1,
	items = {
		"308Box", 10,
		"556Box", 10,
		"556Clip", 8,
		"AmmoStrap_Bullets", 8,
		"AmmoStrap_Shells", 8,
		"AssaultRifle", 4,
		"Bag_MedicalBag", 2,
		"Bag_Police", 4,
		"Boilersuit_SWAT", 8,
		"BoltCutters", 8,
		"BookAiming4", 0.5,
		"BookAiming5", 0.1,
		"BookReloading4", 0.5,
		"BookReloading5", 0.1,
		"BookFirstAid1", 1,
		"Bullets44Box", 10,
		"Bullets9mmBox", 10,
		"Bullhorn", 20,
		"Crowbar", 8,
		"ElbowPad_Left_Tactical", 1,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"HandTorch", 4,
		"Hat_BalaclavaFace", 4,
		"Hat_BalaclavaFull", 4,
		"Hat_BaseballCap_SWAT", 10,
		"Hat_EarMuff_Protectors", 8,
		"Hat_SWAT", 8,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Black", 8,
		"HuntingRifle", 8,
		"Kneepad_Left_Tactical", 4,
		"Lighter", 4,
		"Nightstick", 10,
		"Oxygen_Tank", 8,
		"Pistol", 10,
		"Revolver_Long", 4,
		"Rope", 10,
		"SCBA", 2,
		"ShinKneeGuard_L_Protective", 2,
		"Shirt_CamoUrban", 6,
		"Shoes_ArmyBoots", 6,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Sledgehammer", 8,
		"ThighProtective_L", 1,
		"Trousers_CamoUrban", 6,
		"Tshirt_CamoUrban", 8,
		"Vest_BulletSWAT", 8,
		"WalkieTalkie4", 10,
		"x2Scope", 8,
		"x4Scope", 4,
		"x8Scope", 2,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.PoliceSWAT = {
	TruckBed = VehicleDistributions.PoliceSWATTruckBed;
	
	GloveBox = VehicleDistributions.PoliceSWATGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PoliceSWATSeatFront;
	SeatRearLeft = VehicleDistributions.PoliceSWATSeatRear;
	SeatRearRight = VehicleDistributions.PoliceSWATSeatRear;
}

VehicleDistributions.PoliceStateSeatFront = {
	rolls = 1,
	items = {
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle2", 1,
		"Bag_Police", 1,
		"Bag_ProtectiveCaseSmall_WalkieTalkiePolice", 6,
		"Book_CrimeFiction", 0.5,
		"Book_Legal", 0.5,
		"Book_Policing", 2,
		"Bullets9mmBox", 10,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"Hat_BaseballCap_Police", 10,
		"Hat_CrashHelmet_Police", 2,
		"Hat_EarMuff_Protectors", 4,
		"Hat_Police_Grey", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Brown", 8,
		"HuntingRifle", 8,
		"Kneepad_Left_Tactical", 1,
		"Lighter", 4,
		"M14Clip", 4,
		"Magazine_Police", 8,
		"Magazine_Crime", 4,
		"Magazine_Firearm", 4,
		"Nightstick", 10,
		"Paperback_CrimeFiction", 2,
		"Paperback_Legal", 2,
		"Paperback_Policing", 6,
		"Paperback_TrueCrime", 2,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Vest_BulletPolice", 2,
		"WalkieTalkie4", 4,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PoliceState = {
	TruckBed = VehicleDistributions.PoliceTruckBed;

	GloveBox = VehicleDistributions.PoliceGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PoliceStateSeatFront;
	SeatRearLeft = VehicleDistributions.PoliceSeatRear;
	SeatRearRight = VehicleDistributions.PoliceSeatRear;
}

VehicleDistributions.PoliceSheriffSeatFront = {
	rolls = 1,
	items = {
		"308Box", 10,
		"AmmoStrap_Bullets", 4,
		"AmmoStrap_Shells", 4,
		"AssaultRifle2", 1,
		"Bag_Sheriff", 1,
		"Bag_ProtectiveCaseSmall_WalkieTalkiePolice", 6,
		"Book_CrimeFiction", 0.5,
		"Book_Legal", 0.5,
		"Book_Policing", 2,
		"Bullets9mmBox", 10,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"Hat_BaseballCap_Sheriff", 10,
		"Hat_CrashHelmet_Police", 2,
		"Hat_EarMuff_Protectors", 4,
		"Hat_Sheriff", 10,
		"HolsterAnkle", 0.1,
		"HolsterShoulder", 0.1,
		"HolsterSimple_Brown", 8,
		"HuntingRifle", 8,
		"Kneepad_Left_Tactical", 1,
		"Lighter", 4,
		"M14Clip", 4,
		"Magazine_Police", 8,
		"Magazine_Crime", 4,
		"Magazine_Firearm", 4,
		"Nightstick", 10,
		"Paperback_CrimeFiction", 2,
		"Paperback_Legal", 2,
		"Paperback_Policing", 6,
		"Paperback_TrueCrime", 2,
		"Pistol", 8,
		"Pistol2", 6,
		"Revolver", 6,
		"Revolver_Long", 4,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Vest_BulletPolice", 2,
		"WalkieTalkie4", 4,
		"x2Scope", 4,
		"x4Scope", 2,
		"x8Scope", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PoliceSheriff = {
	TruckBed = VehicleDistributions.PoliceTruckBed;

	GloveBox = VehicleDistributions.PoliceGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PoliceSheriffSeatFront;
	SeatRearLeft = VehicleDistributions.PoliceSeatRear;
	SeatRearRight = VehicleDistributions.PoliceSeatRear;
}

VehicleDistributions.PoliceDetectiveSeatFront = {
	rolls = 1,
	items = {
		"AmmoStrap_Shells", 4,
		"Bag_ProtectiveCaseSmall_WalkieTalkiePolice", 6,
		"Book_CrimeFiction", 0.5,
		"Book_Legal", 0.5,
		"Book_Policing", 2,
		"Bullets38Box", 10,
		"Glasses_Aviators", 10,
		"Glasses_Macho", 1,
		"Gloves_LeatherGlovesBlack", 10,
		"Hat_BaseballCapTINT", 10,
		"Hat_EarMuff_Protectors", 4,
		"HolsterSimple_Black", 2,
		"Kneepad_Left_Tactical", 1,
		"Lighter", 4,
		"M14Clip", 4,
		"Magazine_Police", 8,
		"Magazine_Crime", 4,
		"Magazine_Firearm", 4,
		"Nightstick", 10,
		"Paperback_CrimeFiction", 2,
		"Paperback_Legal", 2,
		"Paperback_Policing", 6,
		"Paperback_TrueCrime", 2,
		"Revolver_Short", 8,
		"Shotgun", 8,
		"ShotgunShellsBox", 10,
		"Vest_BulletPolice", 2,
		"WalkieTalkie4", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PoliceDetective = {
	TruckBed = VehicleDistributions.PoliceTruckBed;

	GloveBox = VehicleDistributions.PoliceGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PoliceDetectiveSeatFront;
	SeatRearLeft = VehicleDistributions.PoliceSeatRear;
	SeatRearRight = VehicleDistributions.PoliceSeatRear;
}

VehicleDistributions.PackRatGloveBox = {
	rolls = 1,
	items = {
		"BeerCanEmpty", 4,
		"BeerEmpty", 4,
		"Brochure", 50,
		"Brochure", 20,
		"Disc_Retail", 50,
		"Disc_Retail", 20,
		"Flier", 50,
		"Flier", 20,
		"Garbagebag", 10,
		"Magazine_Popular", 10,
		"Notebook", 10,
		"Notepad", 20,
		"PaperNapkins2", 10,
		"Phonebook", 10,
		"Paperclip", 50,
		"Paperclip", 20,
		"Plasticbag_Bags", 10,
		"PlasticCup", 10,
		"Pop2Empty", 10,
		"Pop3Empty", 10,
		"PopBottleEmpty", 10,
		"PopEmpty", 10,
		"Receipt", 50,
		"Receipt", 20,
		"Receipt", 20,
		"Receipt", 10,
		"RecipeClipping", 1,
		"RubberBand", 50,
		"RubberBand", 20,
		"ScratchTicket_Loser", 20,
		"ScratchTicket_Loser", 10,
		"Straw2", 10,
		"Tissue", 50,
		"Tissue", 20,
		"TissueBox", 4,
		"Tote_Bags", 4,
		"TVMagazine", 10,
		"WaterBottleEmpty", 10,
		"WhiskeyEmpty", 4,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.PackRatTruckBed = {
	rolls = 4,
	items = {
		"Bag_TrashBag", 20,
		"BeerCanEmpty", 4,
		"BeerEmpty", 4,
		"Brochure", 50,
		"Brochure", 20,
		"Cockroach", 4,
		"DeadMouse", 1,
		"DeadRat", 1,
		"ElectricWire", 10,
		"EmptyJar", 4,
		"Flier", 50,
		"Flier", 20,
		"FountainCup", 10,
		"Garbagebag", 20,
		"Garbagebag", 10,
		"JarLid", 4,
		"Maggots", 1,
		"PaintbucketEmpty", 1,
		"PaperNapkins2", 10,
		"Plasticbag_Bags", 10,
		"PlasticCup", 10,
		"Pop2Empty", 10,
		"Pop3Empty", 10,
		"PopBottleEmpty", 10,
		"PopEmpty", 10,
		"Straw2", 10,
		"TinCanEmpty", 10,
		"ToiletPaper", 10,
		"Tote_Bags", 4,
		"Twine", 10,
		"WaterBottleEmpty", 10,
		"WhiskeyEmpty", 4,
		"WineEmpty", 4,
		"Wine2Empty", 4,
		"Wire", 20,
		"Wire", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.PackRatSeatFront = {
	rolls = 1,
	items = {
		"BeerCanEmpty", 4,
		"BeerEmpty", 4,
		"Brochure", 20,
		"Disc_Retail", 50,
		"Disc_Retail", 20,
		"EmptyJar", 4,
		"Flier", 20,
		"FountainCup", 10,
		"JarLid", 4,
		"Magazine_Popular", 10,
		"MenuCard", 20,
		"PaintbucketEmpty", 1,
		"PaperNapkins2", 10,
		"Phonebook", 10,
		"Plasticbag_Bags", 10,
		"PlasticCup", 10,
		"Pop2Empty", 10,
		"Pop3Empty", 10,
		"PopBottleEmpty", 10,
		"PopEmpty", 10,
		"Receipt", 20,
		"Straw2", 10,
		"Tissue", 50,
		"Tissue", 20,
		"ToiletPaper", 10,
		"Tote_Bags", 4,
		"TVMagazine", 10,
		"Twine", 20,
		"WaterBottleEmpty", 10,
		"WhiskeyEmpty", 4,
		"WineEmpty", 4,
		"Wine2Empty", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PackRatSeatRear = {
	rolls = 1,
	items = {
		"Bag_TrashBag", 20,
		"BeerCanEmpty", 4,
		"BeerEmpty", 4,
		"Brochure", 20,
		"Disc_Retail", 50,
		"Disc_Retail", 20,
		"EmptyJar", 4,
		"Flier", 20,
		"FountainCup", 10,
		"JarLid", 4,
		"Magazine_Popular", 10,
		"MenuCard", 20,
		"PaintbucketEmpty", 1,
		"PaperNapkins2", 10,
		"Phonebook", 10,
		"Plasticbag_Bags", 10,
		"PlasticCup", 10,
		"Pop2Empty", 10,
		"Pop3Empty", 10,
		"PopBottleEmpty", 10,
		"PopEmpty", 10,
		"Receipt", 20,
		"Straw2", 10,
		"Tissue", 50,
		"Tissue", 20,
		"ToiletPaper", 10,
		"Tote_Bags", 4,
		"TVMagazine", 10,
		"Twine", 20,
		"WaterBottleEmpty", 10,
		"WhiskeyEmpty", 4,
		"WineEmpty", 4,
		"Wine2Empty", 4,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.PackRat = {
	
	TruckBed = VehicleDistributions.PackRatTruckBed;
	TruckBedOpen = VehicleDistributions.PackRatTruckBed;
	
	GloveBox = VehicleDistributions.PackRatGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PackRatSeatFront;
	SeatRearLeft = VehicleDistributions.PackRatSeatRear;
	SeatRearRight = VehicleDistributions.PackRatSeatRear;
}

VehicleDistributions.DrinkerGloveBox = {
	rolls = 1,
	items = {
		"BeerBottle", 20,
		"BeerBottle", 10,
		"BeerCan", 20,
		"BeerCan", 10,
		"BeerCanEmpty", 50,
		"BeerCanEmpty", 20,
		"BeerCanEmpty", 10,
		"BeerCanEmpty", 10,
		"BeerEmpty", 50,
		"BeerEmpty", 20,
		"BeerEmpty", 10,
		"BeerEmpty", 10,
		"BottleOpener", 200,
		"Flask", 20,
		"WhiskeyEmpty", 20,
		"Wine", 2,
		"Wine2", 2,
		"WineBox", 8,
		"WineEmpty", 20,
		"Wine2Empty", 20,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.DrinkerTruckBed = {
	rolls = 4,
	items = {
		"BeerBottle", 50,
		"BeerBottle", 20,
		"BeerCan", 50,
		"BeerCan", 20,
		"BeerCanEmpty", 50,
		"BeerCanEmpty", 20,
		"BeerCanEmpty", 10,
		"BeerCanEmpty", 10,
		"BeerEmpty", 50,
		"BeerEmpty", 20,
		"BeerEmpty", 10,
		"BeerEmpty", 10,
		"WhiskeyEmpty", 50,
		"Wine", 8,
		"Wine2", 8,
		"WineBox", 20,
		"WineBox", 10,
		"WineEmpty", 50,
		"Wine2Empty", 50,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.DrinkerSeatFront = {
	rolls = 1,
	items = {
		"BeerBottle", 20,
		"BeerBottle", 10,
		"BeerCan", 20,
		"BeerCan", 10,
		"BeerCanEmpty", 50,
		"BeerCanEmpty", 20,
		"BeerCanEmpty", 10,
		"BeerCanEmpty", 10,
		"BeerEmpty", 50,
		"BeerEmpty", 20,
		"BeerEmpty", 10,
		"BeerEmpty", 10,
		"BottleOpener", 200,
		"WhiskeyEmpty", 20,
		"Wine", 2,
		"Wine2", 2,
		"WineBox", 8,
		"WineEmpty", 20,
		"Wine2Empty", 20,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.DrinkerSeatRear = {
	rolls = 1,
	items = {
		"BeerBottle", 50,
		"BeerBottle", 20,
		"BeerCan", 50,
		"BeerCan", 20,
		"BeerCanEmpty", 50,
		"BeerCanEmpty", 20,
		"BeerCanEmpty", 10,
		"BeerCanEmpty", 10,
		"BeerEmpty", 50,
		"BeerEmpty", 20,
		"BeerEmpty", 10,
		"BeerEmpty", 10,
		"WhiskeyEmpty", 50,
		"Wine", 8,
		"Wine2", 8,
		"WineBox", 20,
		"WineBox", 10,
		"WineEmpty", 50,
		"Wine2Empty", 50,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Drinker = {
	
	TruckBed = VehicleDistributions.DrinkerTruckBed;
	TruckBedOpen = VehicleDistributions.DrinkerTruckBed;
	
	GloveBox = VehicleDistributions.DrinkerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.DrinkerSeatFront;
	SeatRearLeft = VehicleDistributions.DrinkerSeatRear;
	SeatRearRight = VehicleDistributions.DrinkerSeatRear;
}

VehicleDistributions.CamperGloveBox = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 1,
		"BookFishing1", 2,
		"BookFishing2", 1,
		"BookFishing3", 0.5,
		"BookFishing4", 0.1,
		"BookFishing5", 0.05,
		"Canteen", 10,
		"CanteenCowboy", 4,
		"CompassDirectional", 4,
		"CopperCup", 0.5,
		"FirstAidKit", 1,
		"FlashLight_AngleHead", 1,
		"Glasses_Aviators", 1,
		"Glasses_Sun", 4,
		"Glasses_SunCheap", 10,
		"Gloves_WhiteTINT", 8,
		"HandTorch", 10,
		"Hat_BandanaTINT", 10,
		"InsectRepellent", 10,
		"Magazine_Outdoors", 10,
		"MetalCup", 1,
		"Paperback_Nature", 8,
		"Paperback_Travel", 8,
		"Pliers", 4,
		"ShemaghScarf", 1,
		"Socks_Heavy", 10,
		"SurvivalSchematic", 1,
		"Tacklebox", 2,
		"Whetstone", 4,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.CamperTruckBed = {
	rolls = 4,
	items = {
		"Bag_ALICEpack", 1,
		"Bag_BigHikingBag", 4,
		"Bag_FannyPackFront", 10,
		"Bag_FoodSnacks", 20,
		"Bag_HydrationBackpack", 0.01,
		"Bag_NormalHikingBag", 8,
		"Bag_Satchel_Fishing", 2,
		"Bag_Schoolbag_Kids", 8,
		"Canteen", 0.5,
		"Cooler_Beer", 10,
		"Cooler_Meat", 20,
		"Cooler_Soda", 20,
		"FirewoodBundle", 10,
		"FishingRod", 10,
		"FlashLight_AngleHead", 1,
		"Hat_BandanaTINT", 10,
		"InsectRepellent", 10,
		"Lantern_Propane", 10,
		"Pillow", 10,
		"Pliers", 4,
		"PonchoYellowDOWN", 10,
		"Propane_Refill", 8,
		"Sheet", 10,
		"ShemaghScarf", 1,
		"Shoes_Wellies", 1,
		"SleepingBag_BluePlaid_Packed", 2,
		"SleepingBag_Camo_Packed", 1,
		"SleepingBag_Cheap_Blue_Packed", 4,
		"SleepingBag_Cheap_Green2_Packed", 4,
		"SleepingBag_Cheap_Green_Packed", 4,
		"SleepingBag_GreenPlaid_Packed", 2,
		"SleepingBag_Green_Packed", 2,
		"SleepingBag_HighQuality_Brown_Packed", 1,
		"SleepingBag_Spiffo_Packed", 0.1,
		"SleepingBag_RedPlaid_Packed", 2,
		"Suitcase", 10,
		"SurvivalSchematic", 1,
		"Tacklebox", 2,
		"TentBlue_Packed", 4,
		"TentBrown_Packed", 4,
		"TentGreen_Packed", 4,
		"TentYellow_Packed", 4,
		"Toolbox_Fishing", 2,
		"Torch", 10,
		"Whetstone", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.CamperSeatFront = {
	rolls = 1,
	items = {
		"Bag_ALICEpack", 1,
		"Bag_BigHikingBag", 4,
		"Bag_HydrationBackpack", 0.01,
		"Bag_LeatherWaterBag", 1,
		"Bag_FannyPackFront", 10,
		"Bag_NormalHikingBag", 8,
		"Bag_Satchel_Fishing", 2,
		"Bag_Schoolbag_Kids", 8,
		"Canteen", 10,
		"CanteenCowboy", 4,
		"CopperCup", 0.5,
		"FlashLight_AngleHead", 1,
		"Glasses_Aviators", 1,
		"Glasses_Sun", 4,
		"Glasses_SunCheap", 10,
		"HandTorch", 10,
		"Hat_BandanaTINT", 10,
		"InsectRepellent", 10,
		"Magazine_Outdoors", 10,
		"MetalCup", 1,
		"Paperback_Nature", 8,
		"Paperback_Travel", 8,
		"Pliers", 4,
		"ShemaghScarf", 1,
		"Socks_Heavy", 10,
		"SurvivalSchematic", 1,
		"Tacklebox", 2,
		"Toolbox_Fishing", 2,
		"Whetstone", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.CamperSeatRear = {
	rolls = 1,
	items = {
		"Bag_ALICEpack", 1,
		"Bag_BigHikingBag", 4,
		"Bag_HydrationBackpack", 0.01,
		"Bag_LeatherWaterBag", 1,
		"Bag_FannyPackFront", 10,
		"Bag_FoodSnacks", 20,
		"Bag_NormalHikingBag", 8,
		"Bag_Satchel_Fishing", 2,
		"Bag_Schoolbag_Kids", 8,
		"Canteen", 10,
		"CanteenCowboy", 4,
		"Cooler_Beer", 10,
		"Cooler_Meat", 20,
		"Cooler_Soda", 20,
		"CopperCup", 0.5,
		"FishingRod", 10,
		"FlashLight_AngleHead", 1,
		"HandTorch", 10,
		"HoodieDOWN_WhiteTINT", 10,
		"Hat_BandanaTINT", 10,
		"InsectRepellent", 10,
		"Magazine_Outdoors", 10,
		"MetalCup", 1,
		"Paperback_Nature", 8,
		"Paperback_Travel", 8,
		"Pillow", 10,
		"Pliers", 4,
		"PonchoYellowDOWN", 10,
		"Sheet", 10,
		"ShemaghScarf", 1,
		"Shoes_Wellies", 1,
		"SleepingBag_BluePlaid_Packed", 2,
		"SleepingBag_Camo_Packed", 1,
		"SleepingBag_Cheap_Blue_Packed", 4,
		"SleepingBag_Cheap_Green2_Packed", 4,
		"SleepingBag_Cheap_Green_Packed", 4,
		"SleepingBag_GreenPlaid_Packed", 2,
		"SleepingBag_Green_Packed", 2,
		"SleepingBag_HighQuality_Brown_Packed", 1,
		"SleepingBag_Spiffo_Packed", 0.1,
		"SleepingBag_RedPlaid_Packed", 2,
		"Socks_Heavy", 10,
		"Suitcase", 10,
		"Tacklebox", 2,
		"TentBlue_Packed", 4,
		"TentBrown_Packed", 4,
		"TentGreen_Packed", 4,
		"TentYellow_Packed", 4,
		"Toolbox_Fishing", 2,
		"Whetstone", 4,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.Camper = {
	
	TruckBed = VehicleDistributions.CamperTruckBed;
	TruckBedOpen = VehicleDistributions.CamperTruckBed;
	
	GloveBox = VehicleDistributions.CamperGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.CamperSeatFront;
	SeatRearLeft = VehicleDistributions.CamperSeatRear;
	SeatRearRight = VehicleDistributions.CamperSeatRear;
}

VehicleDistributions.AdventurerGloveBox = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 10,
		"Book_History", 50,
		"Book_History", 20,
		"Book_History", 20,
		"Book_History", 10,
		"Book_History", 10,
		"Bullets45Box", 4,
		"CanteenCowboy", 10,
		"CopperCup", 0.5,
		"Diary1", 20,
		"Hat_Fedora", 50,
		"Glasses_Aviators", 10,
		"Goblet", 10,
		"HolsterSimple_Brown", 10,
		"HolsterShoulder", 20,
		"MetalCup", 1,
		"Revolver", 50,
		"Rope", 50,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.AdventurerTruckBed = {
	rolls = 4,
	items = {
		"Bag_TreasureBag", 50,
		"Book_History", 20,
		"Book_History", 10,
		"Lantern_Hurricane", 10,
		"PickAxe", 20,
		"Rope", 10,
		"Shovel", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.AdventurerSeatFront = {
	rolls = 1,
	items = {
		"Bag_LeatherWaterBag", 10,
		"Bag_Satchel_Leather", 20,
		"Book_History", 50,
		"Book_History", 20,
		"CanteenCowboy", 10,
		"CopperCup", 0.5,
		"Diary1", 10,
		"Glasses_Aviators", 10,
		"Hat_Fedora", 50,
		"HolsterShoulder", 20,
		"Jacket_LeatherBrown", 50,
		"Lantern_Hurricane", 10,
		"MetalCup", 1,
		"PickAxe", 20,
		"Revolver", 50,
		"Rope", 50,
		"ShemaghScarf", 10,
		"Shovel", 20,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Adventurer = {
	
	TruckBed = VehicleDistributions.AdventurerTruckBed;
	TruckBedOpen = VehicleDistributions.AdventurerTruckBed;
	
	GloveBox = VehicleDistributions.AdventurerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.AdventurerSeatFront;
}

VehicleDistributions.BadTeensGloveBox = {
	rolls = 1,
	items = {
		-- Booze
		"BeerCan", 20,
		"BeerCan", 20,
		"BeerCan", 10,
		"BeerCan", 10,
		"Flask", 10,
		-- Prank Stuff
		"EggCarton", 10,
		"Firecracker", 50,
		"Firecracker", 50,
		"Firecracker", 20,
		"Firecracker", 20,
		"ToiletPaper", 50,
		"ToiletPaper", 20,
		-- Literature
		"ElectronicsMag5", 4,
		"EngineerMagazine1", 4,
		"HottieZ", 20,
		"TrickMag1", 4,
		"WeaponMag4", 4,
		-- Accessories
		"Glasses_3dGlasses", 4,
		"Glasses_Novelty_Xray", 8,
		"Glasses_Venetian", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.BadTeensTruckBed = {
	rolls = 4,
	items = {
		-- Booze
		"BeerCan", 20,
		"BeerCan", 20,
		"BeerCan", 10,
		"BeerCan", 10,
		"Cooler_Beer", 4,
		-- Prank Stuff
		"BaseballBat", 10,
		"EggCarton", 10,
		"Mov_GardenGnome", 20,
		"ToiletPaper", 50,
		"ToiletPaper", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.BadTeensSeatFront = {
	rolls = 1,
	items = {
		-- Booze
		"BeerCan", 20,
		"BeerCan", 20,
		"BeerCan", 10,
		"BeerCan", 10,
		-- Prank Stuff
		"BaseballBat", 10,
		"EggCarton", 10,
		"Firecracker", 50,
		"ToiletPaper", 50,
		"ToiletPaper", 20,
		-- Literature
		"ElectronicsMag5", 4,
		"EngineerMagazine1", 4,
		"HottieZ", 20,
		"TrickMag1", 4,
		"WeaponMag4", 4,
		-- Accessories
		"Glasses_3dGlasses", 4,
		"Glasses_Novelty_Xray", 8,
		"Glasses_Venetian", 10,
		"Hat_HalloweenMaskDevil", 1,
		"Hat_HalloweenMaskMonster", 1,
		"Hat_HalloweenMaskSkeleton", 1,
		"Hat_HalloweenMaskVampire", 1,
		"Hat_HalloweenMaskWitch", 1,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.BadTeensSeatRear = {
	rolls = 1,
	items = {
		-- Booze
		"BeerCan", 20,
		"BeerCan", 20,
		"BeerCan", 10,
		"BeerCan", 10,
		"Cooler_Beer", 4,
		-- Literature
		"ElectronicsMag5", 4,
		"EngineerMagazine1", 4,
		"HottieZ", 20,
		"TrickMag1", 4,
		"WeaponMag4", 4,
		-- Prank Stuff
		"BaseballBat", 10,
		"EggCarton", 10,
		"Firecracker", 50,
		"Mov_GardenGnome", 20,
		"ToiletPaper", 50,
		"ToiletPaper", 20,
		-- Accessories
		"Glasses_3dGlasses", 4,
		"Glasses_Novelty_Xray", 8,
		"Glasses_Venetian", 10,
		"Hat_HalloweenMaskDevil", 1,
		"Hat_HalloweenMaskMonster", 1,
		"Hat_HalloweenMaskSkeleton", 1,
		"Hat_HalloweenMaskVampire", 1,
		"Hat_HalloweenMaskWitch", 1,
		"Jacket_Varsity", 20,
	},
	junk = ClutterTables.SeatRearJunk,
}

VehicleDistributions.BadTeens = {
	
	TruckBed = VehicleDistributions.BadTeensTruckBed;
	TruckBedOpen = VehicleDistributions.BadTeensTruckBed;
	
	GloveBox = VehicleDistributions.BadTeensGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.BadTeensSeatFront;
	SeatRearLeft = VehicleDistributions.BadTeensSeatRear;
	SeatRearRight = VehicleDistributions.BadTeensSeatRear;
}

VehicleDistributions.EggsTruckBed = {
	rolls = 6,
	items = {
		"EggCarton", 20,
		"EggCarton", 20,
		"EggCarton", 20,
		"EggCarton", 20,
		"EggCarton", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.Eggs = {
	TruckBed = VehicleDistributions.EggsTruckBed;
	
	GloveBox = VehicleDistributions.GloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.SeatFront;
}

VehicleDistributions.ExterminatorGloveBox = {
	rolls = 1,
	items = {
		"Clipboard", 10,
		"DuctTape", 20,
		"ElbowPad_Left_Workman", 1,
		"Flask", 0.5,
		"Garbagebag_box", 20,
		"Garbagebag", 50,
		"Garbagebag", 20,
		"GardeningSprayEmpty", 50,
		"Glasses_SafetyGoggles", 50,
		"Gloves_Dish", 50,
		"Hat_BuildersRespirator", 20,
		"Hat_DustMask", 50,
		"InsectRepellent", 20,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"RatPoison", 20,
		"RespiratorFilters", 20,
		"SCBA_notank", 10,
		"TrapMouse", 50,
		"TrapMouse", 20,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.ExterminatorTruckBed = {
	rolls = 4,
	items = {
		"Bag_DeadMice", 50,
		"Bag_DeadRats", 50,
		"Bag_DeadRoaches", 50,
		"Boilersuit", 20,
		"DuctTape", 20,
		"Garbagebag_box", 10,
		"GardeningSprayEmpty", 20,
		"Glasses_SafetyGoggles", 20,
		"Gloves_Dish", 20,
		"Hat_BuildersRespirator", 20,
		"Hat_DustMask", 20,
		"HazmatSuit", 1,
		"InsectRepellent", 50,
		"InsectRepellent", 20,
		"KnapsackSprayer", 10,
		"Oxygen_Tank", 10,
		"RatPoison", 50,
		"RatPoison", 20,
		"RespiratorFilters", 20,
		"SCBA", 10,
		"Tarp", 20,
		"TrapMouse", 50,
		"TrapMouse", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.ExterminatorSeatFront = {
	rolls = 1,
	items = {
		"Bag_DeadMice", 10,
		"Bag_DeadRats", 10,
		"Bag_DeadRoaches", 10,
		"DuctTape", 20,
		"ElbowPad_Left_Workman", 1,
		"Garbagebag_box", 20,
		"Garbagebag", 50,
		"Garbagebag", 20,
		"GardeningSprayEmpty", 20,
		"Glasses_SafetyGoggles", 20,
		"Gloves_Dish", 20,
		"Hat_BuildersRespirator", 20,
		"Hat_DustMask", 20,
		"InsectRepellent", 20,
		"KnapsackSprayer", 10,
		"Kneepad_Left_Workman", 4,
		"Oxygen_Tank", 10,
		"RatPoison", 20,
		"RespiratorFilters", 20,
		"Tarp", 20,
		"TrapMouse", 50,
		"TrapMouse", 20,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Exterminator = {
	--specificId = "Exterminator";
	
	TruckBed = VehicleDistributions.ExterminatorTruckBed;
	TruckBedOpen = VehicleDistributions.ExterminatorTruckBed;
	
	GloveBox = VehicleDistributions.ExterminatorGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.ExterminatorSeatFront;
}

VehicleDistributions.MasonGloveBox = {
	rolls = 1,
	items = {
		"BookFirstAid1", 0.5,
		"Clipboard", 10,
		"ClubHammer", 10,
		"ElbowPad_Left_Workman", 1,
		"ElectronicsMag4", 0.1,
		"FirstAidKit", 1,
		"Flask", 0.5,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MasonsChisel", 10,
		"MasonsTrowel", 10,
		"MeasuringTape", 10,
		"Paperback", 4,
		"Paperwork", 20,
		"Paperwork", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"TobaccoChewing", 1,
		"Twine", 10,
		"ViseGrips", 4,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.MasonTruckBed = {
	rolls = 4,
	items = {
		"Boilersuit", 10,
		"ClayBrick", 50,
		"ClayBrick", 20,
		"ClubHammer", 10,
		"ConcretePowder", 10,
		"CrushedLimestone", 10,
		"FlatStone", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"LargeStone", 8,
		"Limestone", 4,
		"MarkerBlack", 4,
		"MasonsChisel", 20,
		"MasonsChisel", 10,
		"MasonsTrowel", 20,
		"MasonsTrowel", 10,
		"MeasuringTape", 10,
		"Mov_ConcreteMixer", 4,
		"PetrolCan", 4,
		"RespiratorFilters", 2,
		"Pliers", 8,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Sledgehammer", 0.5,
		"StoneBlock", 50,
		"StoneBlock", 20,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.MasonSeatFront = {
	rolls = 1,
	items = {
		"Boilersuit", 10,
		"Brochure", 2,
		"ClubHammer", 10,
		"ElbowPad_Left_Workman", 1,
		"Flier", 2,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MasonsChisel", 10,
		"MasonsTrowel", 10,
		"MeasuringTape", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Shoes_WorkBoots", 6,
		"Sledgehammer", 0.5,
		"Twine", 10,
		"ViseGrips", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Mason = {
	--specificId = "Mason";
	
	TruckBed = VehicleDistributions.MasonTruckBed;
	TruckBedOpen = VehicleDistributions.MasonTruckBed;
	
	GloveBox = VehicleDistributions.MasonGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.MasonSeatFront;
}

-- Small chance of pilfered snack cakes in the glovebox.
VehicleDistributions.StepVan_PlonkiesGloveBox = {
	rolls = 1,
	items = {
		"ChocoCakes", 4,
		"CigarettePack", 8,
		"Clipboard", 10,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Plonkies", 10,
		"QuaggaCakes", 4,
		"Receipt", 10,
		"SnoGlobes", 4,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

-- Should spawn a small handful of Plonkies, as well as some other snack cakes.
VehicleDistributions.StepVan_PlonkiesTruckBed = {
	rolls = 4,
	items = {
		"ChocoCakes", 20,
		"ChocoCakes", 10,
		"HiHis", 20,
		"HiHis", 10,
		"Plonkies", 50,
		"Plonkies", 20,
		"Plonkies", 20,
		"Plonkies", 10,
		"SnoGlobes", 20,
		"SnoGlobes", 10,
		"QuaggaCakes", 20,
		"QuaggaCakes", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_Plonkies = {
	
	TruckBed = VehicleDistributions.StepVan_PlonkiesTruckBed;
	
	GloveBox = VehicleDistributions.StepVan_PlonkiesGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.EmptySeat;
}

VehicleDistributions.PickUpTruckLights_AirportGloveBox = {
	rolls = 1,
	items = {
		"BoltCutters", 8,
		"BookFirstAid1", 0.5,
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"Clipboard", 10,
		"ElbowPad_Left_Workman", 1,
		"FirstAidKit", 1,
		"FlashLight_AngleHead", 1,
		"Flask", 0.5,
		"Gloves_LeatherGloves", 10,
		"HandTorch", 8,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Kneepad_Left_Workman", 4,
		"LugWrench", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MechanicMag1", 2,
		"MechanicMag2", 2,
		"MechanicMag3", 2,
		"NutsBolts", 10,
		"Paperback", 4,
		"Paperwork", 10,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"Screwdriver", 10,
		"ScrewsBox", 8,
		"TireIron", 4,
		"TirePump", 8,
		"TobaccoChewing", 1,
		"Torch", 4,
		"Twine", 10,
		"Wrench", 10,
		"Zipties", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.PickUpTruckLights_AirportTruckBed = {
	rolls = 4,
	items = {
		"BoltCutters", 8,
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"Bullhorn", 10,
		"Epoxy", 4,
		"FiberglassTape", 4,
		"FlashLight_AngleHead", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"HandTorch", 8,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Jack", 10,
		"LugWrench", 4,
		"MeasuringTape", 10,
		"NutsBolts", 10,
		"Pliers", 8,
		"Ratchet", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"RubberHose", 20,
		"Screws", 10,
		"Tarp", 10,
		"TireIron", 8,
		"TirePump", 8,
		"Toolbox_Mechanic", 2,
		"Torch", 4,
		"Twine", 1,
		"Vest_HighViz", 4,
		"Wrench", 8,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.PickUpTruckLights_AirportSeatFront = {
	rolls = 1,
	items = {
		"BookMechanic1", 2,
		"BookMechanic2", 1,
		"BookMechanic3", 0.5,
		"BookMechanic4", 0.1,
		"BookMechanic5", 0.05,
		"ElbowPad_Left_Workman", 1,
		"ElbowPad_Left_Workman", 1,
		"Epoxy", 4,
		"FiberglassTape", 4,
		"FlashLight_AngleHead", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"HandTorch", 8,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Jack", 2,
		"Kneepad_Left_Workman", 4,
		"Kneepad_Left_Workman", 4,
		"LugWrench", 4,
		"MarkerBlack", 4,
		"MechanicMag1", 2,
		"MechanicMag2", 2,
		"MechanicMag3", 2,
		"NutsBolts", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"RubberHose", 10,
		"Screwdriver", 10,
		"Screws", 10,
		"Tarp", 10,
		"TireIron", 4,
		"TirePump", 8,
		"Torch", 4,
		"Twine", 1,
		"Wrench", 8,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.PickUpTruckLights_Airport = {
	
	TruckBed = VehicleDistributions.PickUpTruckLights_AirportTruckBed;
	TruckBedOpen = VehicleDistributions.PickUpTruckLights_AirportTruckBed;
	
	GloveBox = VehicleDistributions.PickUpTruckLights_AirportGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PickUpTruckLights_AirportSeatFront;
}

VehicleDistributions.StepVan_AirportCateringGloveBox = {
	rolls = 1,
	items = {
		"BottleOpener", 4,
		"CigarettePack", 8,
		"Clipboard", 10,
		"Corkscrew", 4,
		"DishCloth", 10,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperback", 4,
		"Paperback_Diet", 8,
		"PaperNapkins2", 20,
		"Paperwork", 10,
		"Pencil", 10,
		"PlasticFork", 20,
		"PlasticKnife", 20,
		"PlasticSpoon", 20,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.StepVan_AirportCateringSeatFront = {
	rolls = 1,
	items = {
		"Aluminum", 20,
		"Apron_White", 8,
		"BottleOpener", 4,
		"Brandy", 4,
		"Champagne", 1,
		"CigarettePack", 8,
		"Corkscrew", 4,
		"DishCloth", 10,
		"Gin", 8,
		"MarkerBlack", 4,
		"MuffinTray", 4,
		"Notepad", 10,
		"OvenMitt", 8,
		"Pan", 4,
		"PaperNapkins2", 20,
		"Pencil", 10,
		"PlasticFork", 20,
		"PlasticKnife", 20,
		"PlasticSpoon", 20,
		"PlasticTray", 10,
		"Port", 4,
		"Receipt", 10,
		"Rum", 8,
		"Scotch", 4,
		"Sheet", 4,
		"Sherry", 4,
		"Shoes_Black", 8,
		"Tequila", 8,
		"TVDinner", 20,
		"Vermouth", 4,
		"Vodka", 8,
		"Whiskey", 8,
		"Wine", 6,
		"Wine2", 6,
		"WineAged", 2,
		"WineBox", 10,
		"WineScrewtop", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.StepVan_AirportCateringTruckBed = {
	rolls = 4,
	items = {
		"Aluminum", 20,
		"Apron_White", 8,
		"BottleOpener", 4,
		"Brandy", 4,
		"Champagne", 1,
		"Corkscrew", 1,
		"DishCloth", 10,
		"Gin", 8,
		"MuffinTray", 4,
		"OvenMitt", 8,
		"PaperNapkins2", 20,
		"PlasticFork", 20,
		"PlasticKnife", 20,
		"PlasticSpoon", 20,
		"PlasticTray", 10,
		"PlasticTray", 20,
		"Port", 4,
		"Rum", 8,
		"Scotch", 4,
		"Sheet", 4,
		"Sherry", 4,
		"Tequila", 8,
		"TVDinner", 20,
		"Vermouth", 4,
		"Vodka", 8,
		"Whiskey", 8,
		"Wine", 6,
		"Wine2", 6,
		"WineAged", 2,
		"WineBox", 10,
		"WineScrewtop", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_AirportCatering = {
	TruckBed = VehicleDistributions.StepVan_AirportCateringTruckBed;

	GloveBox = VehicleDistributions.StepVan_AirportCateringGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.StepVan_AirportCateringSeatFront;
}

VehicleDistributions.VanSeats_AirportShuttleGloveBox = {
	rolls = 1,
	items = {
		"Brochure", 20,
		"Brochure", 10,
		"Flier", 20,
		"Flier", 10,
		"Flask", 1,
		"Gloves_FingerlessLeatherGloves", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MenuCard", 10,
		"Money", 50,
		"Money", 20,
		"Money", 10,
		"Money", 10,
		"Paperback", 20,
		"Paperwork", 10,
		"TVMagazine", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.VanSeats_AirportShuttleTruckBed = {
	rolls = 4,
	items = {
		"Handbag", 0.5,
		"Purse", 0.5,
		"Suitcase", 1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.VanSeats_AirportShuttleSeatFront = {
	rolls = 1,
	items = {
		"Bag_HikingBag_Travel", 4,
		"Bag_Schoolbag_Travel", 4,
		"Briefcase", 2,
		"Brochure", 10,
		"CameraDisposable", 1,
		"Flier", 10,
		"Handbag", 4,
		"MagazineCrossword", 1,
		"MagazineWordsearch", 1,
		"Paperback_Fiction", 4,
		"Paperback_Travel", 8,
		"Postcard", 10,
		"Purse", 4,
		"Suitcase", 10,
		"TVMagazine", 10,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.VanSeats_AirportShuttleSeatRear = {
	rolls = 1,
	items = {
		"Bag_BigHikingBag_Travel", 2,
		"Bag_FannyPackFront", 1,
		"Bag_HikingBag_Travel", 4,
		"Bag_Satchel", 1,
		"Bag_Schoolbag_Travel", 4,
		"Briefcase", 8,
		"Brochure", 10,
		"CameraDisposable", 1,
		"Flier", 10,
		"Glasses_Aviators", 1,
		"Glasses_Sun", 2,
		"Handbag", 10,
		"JacketLong_Random", 1,
		"Jacket_Leather", 1,
		"Jacket_PaddedDOWN", 1,
		"Jacket_Shellsuit_Black", 0.2,
		"Jacket_Shellsuit_Blue", 0.2,
		"Jacket_Shellsuit_Green", 0.2,
		"Jacket_Shellsuit_Pink", 0.2,
		"Jacket_Shellsuit_Teal", 0.2,
		"Jacket_Shellsuit_TINT", 2,
		"Jacket_WhiteTINT", 4,
		"MagazineCrossword", 1,
		"MagazineWordsearch", 1,
		"Money", 1,
		"Paperback_Fiction", 4,
		"Paperback_Travel", 8,
		"Pillow", 1,
		"Postcard", 10,
		"Purse", 10,
		"Suitcase", 20,
		"Suit_Jacket", 1,
		"Suit_JacketTINT", 2,
	},
	junk = {
		rolls = 1,
		items = {
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
		}
	}
}

VehicleDistributions.VanSeats_AirportShuttle = {
	TruckBed = VehicleDistributions.VanSeats_AirportShuttleTruckBed;
	
	GloveBox = VehicleDistributions.VanSeats_AirportShuttleGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.VanSeats_AirportShuttleSeatFront;
	SeatRearLeft = VehicleDistributions.VanSeats_AirportShuttleSeatRear;
	SeatRearRight = VehicleDistributions.VanSeats_AirportShuttleSeatRear;
}

VehicleDistributions.StepVan_MarineBitesGloveBox = {
	rolls = 1,
	items = {
		"Chainmail_Hand_L", 1,
		"Chainmail_Hand_R", 0.1,
		"CigarettePack", 8,
		"Clipboard", 10,
		"Flask", 0.5,
		"Gloves_Dish", 20,
		"KnifeFillet", 20,
		"KnifeSushi", 1,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"MeatCleaver", 4,
		"Notepad", 10,
		"Paperback", 4,
		"Paperback_Diet", 8,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
		"Whetstone", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.StepVan_MarineBitesSeatFront = {
	rolls = 1,
	items = {
		"Apron_White", 8,
		"Chainmail_Hand_L", 1,
		"Chainmail_Hand_R", 0.1,
		"CigarettePack", 8,
		"Cooler_Seafood", 10,
		"Gloves_Dish", 20,
		"KnifeFillet", 20,
		"KnifeSushi", 1,
		"MarkerBlack", 4,
		"MeatCleaver", 4,
		"Notepad", 10,
		"Pencil", 10,
		"Receipt", 10,
		"Whetstone", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.StepVan_MarineBitesTruckBed = {
	rolls = 4,
	items = {
		"Apron_White", 8,
		"Chainmail_Hand_L", 1,
		"Chainmail_Hand_R", 0.1,
		"Cooler_Seafood", 50,
		"Cooler_Seafood", 20,
		"Cooler_Seafood", 20,
		"Cooler_Seafood", 10,
		"Fleshing_Tool", 10,
		"Gloves_Dish", 20,
		"KnifeFillet", 20,
		"KnifeSushi", 1,
		"MeatCleaver", 4,
		"Whetstone", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_MarineBites = {
	TruckBed = VehicleDistributions.StepVan_MarineBitesTruckBed;

	GloveBox = VehicleDistributions.StepVan_MarineBitesGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.StepVan_MarineBitesSeatFront;
}

VehicleDistributions.StepVan_ZippeeGloveBox = {
	rolls = 1,
	items = {
		"CigarettePack", 8,
		"Clipboard", 10,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.StepVan_ZippeeTruckBed = {
	rolls = 4,
	items = {
		"Allsorts", 2,
		"BeefJerky", 8,
		"CandyCaramels", 2,
		"CandyGummyfish", 2,
		"CandyNovapops", 2,
		"CandyPackage", 1,
		"ChocoCakes", 4,
		"Chocolate", 4,
		"ChocolateCoveredCoffeeBeans", 1,
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
		"MintCandy", 2,
		"Modjeska", 2,
		"Peanuts", 4,
		"Peppermint", 1,
		"Plonkies", 4,
		"Pop", 8,
		"Pop2", 8,
		"Pop3", 8,
		"PopBottle", 6,
		"PopBottleRare", 2,
		"PorkRinds", 4,
		"Pretzel", 6,
		"QuaggaCakes", 4,
		"SnoGlobes", 4,
		"SodaCan", 8,
		--"SodaCanRare", 2,
		"SunflowerSeeds", 4,
		"TortillaChips", 6,
		"WaterBottle", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_Zippee = {
	TruckBed = VehicleDistributions.StepVan_ZippeeTruckBed;

	GloveBox = VehicleDistributions.StepVan_ZippeeGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.EmptySeat;
}

-- Refilling vending machines usually involves emptying out the coin receptacle right?
VehicleDistributions.StepVan_SodaGloveBox = {
	rolls = 1,
	items = {
		"Cashbox", 10,
		"CigarettePack", 8,
		"Clipboard", 10,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Money", 50,
		"Money", 50,
		"Money", 20,
		"Money", 10,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Pop", 1,
		"Pop2", 1,
		"Pop3", 1,
		"PopBottle", 1,
		"Receipt", 10,
		"SodaCan", 1,
		--"SodaCanRare", 0.1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

-- Small amount of Soda, but mostly empties. Survivors clean these out quickly.
VehicleDistributions.StepVan_SodaTruckBed = {
	rolls = 4,
	items = {
		"Pop", 4,
		"Pop2", 4,
		"Pop2Empty", 20,
		"Pop3", 4,
		"Pop3Empty", 20,
		"PopBottle", 6,
		"PopBottleEmpty", 10,
		"PopBottleRare", 1,
		"PopEmpty", 20,
		"SodaCan", 8,
		--"SodaCanRare", 2,
		--"SodaCanEmpty", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_Soda = {
	
	TruckBed = VehicleDistributions.StepVan_SodaTruckBed;
	
	GloveBox = VehicleDistributions.StepVan_SodaGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.EmptySeat;
}

-- Cashbox and change from bar restock orders.
VehicleDistributions.StepVan_BeerGloveBox = {
	rolls = 1,
	items = {
		"Cashbox", 4,
		"CigarettePack", 8,
		"Clipboard", 10,
		"Flask", 0.5,
		"KnifeButterfly", 4,
		"SwitchKnife", 4,
		"Hat_BandanaTINT", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Money", 50,
		"Money", 20,
		"Money", 10,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

-- Small amount of Soda, but mostly empties. Survivors clean these out quickly.
VehicleDistributions.StepVan_BeerTruckBed = {
	rolls = 4,
	items = {
		"BeerBottle", 8,
		"BeerBottleEmpty", 50,
		"BeerBottleEmpty", 20,
		"BeerCan", 8,
		"BeerCanEmpty", 50,
		"BeerCanEmpty", 20,
		"BeerCanPack", 0.1,
		"BeerImported", 2,
		"BeerImportedEmpty", 10,
		"BeerPack", 0.1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_Beer = {
	
	TruckBed = VehicleDistributions.StepVan_BeerTruckBed;
	
	GloveBox = VehicleDistributions.StepVan_BeerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.EmptySeat;
}

-- Similar setup to the soda delivery vehicle but with chips instead.
VehicleDistributions.StepVan_ChipsGloveBox = {
	rolls = 1,
	items = {
		"Cashbox", 10,
		"CigarettePack", 8,
		"Clipboard", 10,
		"Crisps", 1,
		"Crisps2", 1,
		"Crisps3", 1,
		"Crisps4", 1,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Money", 50,
		"Money", 20,
		"Money", 20,
		"Money", 10,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"PorkRinds", 1,
		"Receipt", 10,
		"TortillaChips", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

-- Small amount of Chips. Pretend there are empty cardboard boxes strewn about or something.
VehicleDistributions.StepVan_ChipsTruckBed = {
	rolls = 4,
	items = {
		"Crisps", 8,
		"Crisps2", 8,
		"Crisps3", 8,
		"Crisps4", 8,
		"PorkRinds", 4,
		"TortillaChips", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_Chips = {
	
	TruckBed = VehicleDistributions.StepVan_ChipsTruckBed;
	
	GloveBox = VehicleDistributions.StepVan_ChipsGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.EmptySeat;
}

VehicleDistributions.StepVan_WindowsGloveBox = {
	rolls = 1,
	items = {
		-- Keys/Keyrings
		"KeyRing_EagleFlag", 0.1,
		"KeyRing_EightBall", 0.1,
		"KeyRing_Panther", 0.1,
		"KeyRing_Sexy", 0.1,
		-- TODO: Sort Me!
		"BookFirstAid1", 0.5,
		"Clipboard", 10,
		"Crowbar", 20,
		"ElbowPad_Left_Workman", 1,
		"FirstAidKit", 1,
		"Flask", 0.5,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"GraphPaper", 1,
		"HandDrill", 4,
		"Hat_Bandana", 1,
		"Hat_BandanaTINT", 1,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paperback", 4,
		"Paperwork", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"TobaccoChewing", 1,
		"Tsquare", 1,
		"Twine", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.StepVan_WindowsTruckBed = {
	rolls = 4,
	items = {
		"Crowbar", 20,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"HandDrill", 4,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"MeasuringTape", 10,
		"Mov_LightConstruction", 4,
		"Mov_WindowChrome", 20,
		"Mov_WindowSlider", 20,
		"Mov_WindowTiled", 20,
		"Mov_WindowWhite", 20,
		"Mov_WindowWhiteTiled", 20,
		"Mov_WindowWooden", 20,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Toolbox", 2,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_WindowsSeatFront = {
	rolls = 1,
	items = {
		"Crowbar", 20,
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		"Hat_BuildersRespirator", 2,
		"Hat_DustMask", 10,
		"Hat_EarMuff_Protectors", 10,
		"Hat_HardHat", 10,
		"Kneepad_Left_Workman", 4,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Pliers", 8,
		"RespiratorFilters", 2,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		"Saw", 8,
		"Shoes_WorkBoots", 6,
		"Twine", 10,
		"Vest_Foreman", 1,
		"Vest_HighViz", 4,
		"ViseGrips", 4,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.StepVan_Windows = {
	
	TruckBed = VehicleDistributions.StepVan_WindowsTruckBed;
	
	TruckBedOpen = VehicleDistributions.StepVan_WindowsTruckBed;
	
	TrailerTrunk =  VehicleDistributions.StepVan_WindowsTruckBed;
	
	GloveBox = VehicleDistributions.StepVan_WindowsGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.StepVan_WindowsSeatFront;
}

-- Copy of the StepVan version.
VehicleDistributions.Van_BeerGloveBox = {
	rolls = 1,
	items = {
		"Cashbox", 4,
		"CigarettePack", 8,
		"Clipboard", 10,
		"Flask", 0.5,
		"KnifeButterfly", 4,
		"SwitchKnife", 4,
		"Hat_BandanaTINT", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Money", 50,
		"Money", 20,
		"Money", 10,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.Van_BeerTruckBed = {
	rolls = 4,
	items = {
		"BeerBottle", 8,
		"BeerBottleEmpty", 50,
		"BeerBottleEmpty", 20,
		"BeerCan", 8,
		"BeerCanEmpty", 50,
		"BeerCanEmpty", 20,
		"BeerCanPack", 0.1,
		"BeerImported", 2,
		"BeerImportedEmpty", 10,
		"BeerPack", 0.1,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.Van_Beer = {
	
	TruckBed = VehicleDistributions.Van_BeerTruckBed;
	
	GloveBox = VehicleDistributions.Van_BeerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.EmptySeat;
}

-- Ditto but with imported beer.
VehicleDistributions.StepVan_ImportedBeerGloveBox = {
	rolls = 1,
	items = {
		"Cashbox", 4,
		"CigarettePack", 8,
		"Clipboard", 10,
		"Flask", 0.5,
		"KnifeButterfly", 4,
		"SwitchKnife", 4,
		"Hat_BandanaTINT", 4,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Money", 50,
		"Money", 20,
		"Money", 10,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.StepVan_ImportedBeerTruckBed = {
	rolls = 4,
	items = {
		"BeerImported", 10,
		"BeerImportedEmpty", 50,
		"BeerImportedEmpty", 20,
		"BeerImportedEmpty", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_Genuine_Beer = {
	
	TruckBed = VehicleDistributions.StepVan_ImportedBeerTruckBed;
	
	GloveBox = VehicleDistributions.StepVan_ImportedBeerGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.EmptySeat;
}

VehicleDistributions.StepVan_CerealGloveBox = {
	rolls = 1,
	items = {
		"CigarettePack", 8,
		"Clipboard", 10,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.StepVan_CerealTruckBed = {
	rolls = 4,
	items = {
		"Cereal", 50,
		"Cereal", 20,
		"Cereal", 10,
		"Cereal", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_Cereal = {
	TruckBed = VehicleDistributions.StepVan_CerealTruckBed;

	GloveBox = VehicleDistributions.StepVan_CerealGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.EmptySeat;
}

VehicleDistributions.Van_LocksmithGloveBox = {
	rolls = 1,
	items = {
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 4,
		"Gloves_LeatherGloves", 10,
		"Kneepad_Left_Workman", 4,
		"Loupe", 10,
		-- Personal
		"CigarettePack", 8,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		-- Misc.
		"Clipboard", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.Van_LocksmithTruckBed = {
	rolls = 4,
	items = {
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 4,
		"Gloves_LeatherGloves", 10,
		"Kneepad_Left_Workman", 4,
		"Loupe", 10,
		-- Locks/Keys
		"CombinationPadlock", 20,
		"Key_Blank", 200,
		"Key_Blank", 100,
		"Key_Blank", 50,
		"Key_Blank", 20,
		"Key_Blank", 10,
		"Key_Blank", 10,
		"Padlock", 20,
		-- Tools
		"Crowbar", 20,
		"File", 20,
		"HacksawBlade", 20,
		"HeavyChain", 20,
		"Pliers", 20,
		"Saw", 20,
		"Sledgehammer", 0.5,
		"SmallFileSet", 20,
		"SmallSaw", 20,
		"SmallSawblade", 20,
		"ViseGrips", 20,
		-- Bags/Containers
		"Bag_ProtectiveCaseSmall_KeyCutting", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.Van_LocksmithSeatFront = {
	rolls = 1,
	items = {
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 4,
		"Gloves_LeatherGloves", 10,
		"Kneepad_Left_Workman", 4,
		"Loupe", 10,
		-- Locks/Keys
		"CombinationPadlock", 10,
		"Padlock", 10,
		-- Tools
		"Crowbar", 20,
		"File", 20,
		"HacksawBlade", 10,
		"HeavyChain", 10,
		"Pliers", 8,
		"Saw", 8,
		"Sledgehammer", 0.5,
		"SmallFileSet", 10,
		"SmallSaw", 10,
		"SmallSawblade", 10,
		"ViseGrips", 10,
		-- Misc.
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		-- Bags/Containers
		"Bag_ProtectiveCaseSmall_KeyCutting", 20,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Van_Locksmith = {
	TruckBed = VehicleDistributions.Van_LocksmithTruckBed;

	GloveBox = VehicleDistributions.Van_LocksmithGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.Van_LocksmithSeatFront;
}

VehicleDistributions.StepVan_FloristGloveBox = {
	rolls = 1,
	items = {
		-- Cards
		"Card_Birthday", 20,
		"Card_Birthday", 10,
		"Card_Sympathy", 20,
		"Card_Sympathy", 10,
		-- Personal
		"CigarettePack", 8,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		-- Misc.
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.StepVan_FloristTruckBed = {
	rolls = 4,
	items = {
		-- Cards
		"Card_Birthday", 50,
		"Card_Sympathy", 20,
		-- Flowers
		"Chamomile", 20,
		"Lavender", 20,
		"Marigold", 20,
		"Poppies", 20,
		"Roses", 50,
		"Roses", 20,
		-- Boxes/Containers
		"Chocolate_HeartBox", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.StepVan_FloristSeatFront = {
	rolls = 1,
	items = {
		-- Cards
		"Card_Birthday", 50,
		"Card_Birthday", 20,
		"Card_Sympathy", 20,
		"Card_Sympathy", 10,
		-- Flowers
		"Chamomile", 10,
		"Lavender", 10,
		"Marigold", 10,
		"Poppies", 10,
		"Roses", 20,
		-- Boxes/Containers
		"Chocolate_HeartBox", 20,
		-- Misc.
		"MarkerBlack", 4,
		"Notepad", 10,
		"Pencil", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.StepVan_Florist = {
	TruckBed = VehicleDistributions.StepVan_FloristTruckBed;

	GloveBox = VehicleDistributions.StepVan_FloristGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.StepVan_FloristSeatFront;
}

VehicleDistributions.Van_CraftSuppliesGloveBox = {
	rolls = 1,
	items = {
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 4,
		"Gloves_LeatherGloves", 10,
		"Kneepad_Left_Workman", 4,
		-- Tools
		"Brush", 20,
		"ClayTool", 50,
		-- Literature
		"BookPottery1", 2,
		"BookPottery2", 1,
		"BookPottery3", 0.5,
		"BookPottery4", 0.1,
		"BookPottery5", 0.05,
		-- Personal
		"CigarettePack", 8,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		-- Misc.
		"Clipboard", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.Van_CraftSuppliesTruckBed = {
	rolls = 4,
	items = {
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 4,
		"Gloves_LeatherGloves", 10,
		"Kneepad_Left_Workman", 4,
		-- Tools
		"Brush", 20,
		"ClayTool", 50,
		-- Materials
		"Claybag", 50,
		"Claybag", 20,
		"Claybag", 20,
		"Claybag", 10,
		-- Literature
		"BookPottery1", 2,
		"BookPottery2", 1,
		"BookPottery3", 0.5,
		"BookPottery4", 0.1,
		"BookPottery5", 0.05,
		-- Bags/Containers
		"Toolbox", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.Van_CraftSuppliesSeatFront = {
	rolls = 1,
	items = {
		-- Equipment
		"ElbowPad_Left_Workman", 1,
		"Glasses_SafetyGoggles", 4,
		"Gloves_LeatherGloves", 10,
		"Kneepad_Left_Workman", 4,
		-- Tools
		"Brush", 10,
		"ClayTool", 20,
		-- Materials
		"Claybag", 10,
		-- Literature
		"BookPottery1", 2,
		"BookPottery2", 1,
		"BookPottery3", 0.5,
		"BookPottery4", 0.1,
		"BookPottery5", 0.05,
		-- Misc.
		"MarkerBlack", 4,
		"MeasuringTape", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Van_CraftSupplies = {
	TruckBed = VehicleDistributions.Van_CraftSuppliesTruckBed;

	GloveBox = VehicleDistributions.Van_CraftSuppliesGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.Van_CraftSuppliesFront;
}

-- High-value spawn with rare books/magazines.
VehicleDistributions.MobileLibraryTruckBed = {
	rolls = 4,
	items = {
		-- Kids Stuff
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
		-- Magazines
		"Magazine_Art_New", 8,
		"Magazine_Business_New", 8,
		"Magazine_Car_New", 8,
		"Magazine_Cinema_New", 8,
		"Magazine_Crime_New", 8,
		"Magazine_Fashion_New", 8,
		"Magazine_Firearm_New", 8,
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
		-- Recipes
		"ArmorMag3", 1,
		"ArmorMag4", 1,
		"ArmorMag5", 1,
		"CookingMag1", 4,
		"CookingMag2", 4,
		"CookingMag3", 4,
		"CookingMag4", 4,
		"CookingMag5", 4,
		"CookingMag6", 4,
		"ElectronicsMag1", 4,
		"ElectronicsMag2", 4,
		"ElectronicsMag3", 4,
		"ElectronicsMag4", 4,
		"ElectronicsMag5", 4,
		"EngineerMagazine1", 4,
		"EngineerMagazine2", 4,
		"FarmingMag1", 4,
		"FarmingMag2", 4,
		"FarmingMag3", 4,
		"FarmingMag4", 4,
		"FarmingMag5", 4,
		"FarmingMag6", 4,
		"FarmingMag7", 4,
		"FarmingMag8", 4,
		"FishingMag1", 4,
		"FishingMag2", 4,
		"GlassmakingMag1", 1,
		"GlassmakingMag2", 1,
		"GlassmakingMag3", 1,
		"HerbalistMag", 4,
		"HuntingMag1", 4,
		"HuntingMag2", 4,
		"HuntingMag3", 4,
		"KnittingMag1", 4,
		"KnittingMag2", 4,
		"MechanicMag1", 4,
		"MechanicMag2", 4,
		"MechanicMag3", 4,
		"MetalworkMag1", 4,
		"MetalworkMag2", 4,
		"MetalworkMag3", 4,
		"MetalworkMag4", 4,
		"PrimitiveToolMag1", 1,
		"PrimitiveToolMag2", 1,
		"PrimitiveToolMag3", 1,
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
		"WeaponMag1", 1,
		"WeaponMag2", 1,
		"WeaponMag3", 1,
		"WeaponMag4", 1,
		"WeaponMag5", 1,
		"WeaponMag6", 1,
		-- Skill Books
		"BookBlacksmith1", 20,
		"BookBlacksmith2", 10,
		"BookBlacksmith3", 8,
		"BookBlacksmith4", 6,
		"BookBlacksmith5", 4,
		"BookButchering1", 20,
		"BookButchering2", 10,
		"BookButchering3", 8,
		"BookButchering4", 6,
		"BookButchering5", 4,
		"BookCarpentry1", 20,
		"BookCarpentry2", 10,
		"BookCarpentry3", 8,
		"BookCarpentry4", 6,
		"BookCarpentry5", 4,
		"BookCarving1", 20,
		"BookCarving2", 10,
		"BookCarving3", 8,
		"BookCarving4", 6,
		"BookCarving5", 4,
		"BookCooking1", 20,
		"BookCooking2", 10,
		"BookCooking3", 8,
		"BookCooking4", 6,
		"BookCooking5", 4,
		"BookElectrician1", 20,
		"BookElectrician2", 10,
		"BookElectrician3", 8,
		"BookElectrician4", 6,
		"BookElectrician5", 4,
		"BookFishing1", 20,
		"BookFishing2", 10,
		"BookFishing3", 8,
		"BookFishing4", 6,
		"BookFishing5", 4,
		"BookFlintKnapping1", 1,
		"BookFlintKnapping2", 0.8,
		"BookFlintKnapping3", 0.6,
		"BookFlintKnapping4", 0.4,
		"BookFlintKnapping5", 0.2,
		"BookGlassmaking1", 20,
		"BookGlassmaking2", 10,
		"BookGlassmaking3", 8,
		"BookGlassmaking4", 6,
		"BookGlassmaking5", 4,
		"BookHusbandry1", 20,
		"BookHusbandry2", 10,
		"BookHusbandry3", 8,
		"BookHusbandry4", 6,
		"BookHusbandry5", 4,
		"BookLongBlade1", 1,
		"BookLongBlade2", 0.8,
		"BookLongBlade3", 0.6,
		"BookLongBlade4", 0.4,
		"BookLongBlade5", 0.2,
		"BookMaintenance1", 20,
		"BookMaintenance2", 10,
		"BookMaintenance3", 8,
		"BookMaintenance4", 6,
		"BookMaintenance5", 4,
		"BookMasonry1", 20,
		"BookMasonry2", 10,
		"BookMasonry3", 8,
		"BookMasonry4", 6,
		"BookMasonry5", 4,
		"BookMechanic1", 20,
		"BookMechanic2", 10,
		"BookMechanic3", 8,
		"BookMechanic4", 6,
		"BookMechanic5", 4,
		"BookMetalWelding1", 20,
		"BookMetalWelding2", 10,
		"BookMetalWelding3", 8,
		"BookMetalWelding4", 6,
		"BookMetalWelding5", 4,
		"BookPottery1", 20,
		"BookPottery2", 10,
		"BookPottery3", 8,
		"BookPottery4", 6,
		"BookPottery5", 4,
		"BookTracking1", 20,
		"BookTracking2", 10,
		"BookTracking3", 8,
		"BookTracking4", 6,
		"BookTracking5", 4,
		"BookTrapping1", 20,
		"BookTrapping2", 10,
		"BookTrapping3", 8,
		"BookTrapping4", 6,
		"BookTrapping5", 4,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.MobileLibrary = {
	TruckBed = VehicleDistributions.MobileLibraryTruckBed;
	
	TrailerTrunk  = VehicleDistributions.MobileLibraryTruckBed;
	
	GloveBox = VehicleDistributions.GloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.Seat;
}

VehicleDistributions.ButcherGloveBox = {
	rolls = 1,
	items = {
		-- Tools
		"KitchenKnife", 20,
		"KnifeFillet", 10,
		"LargeKnife", 8,
		"MeatCleaver", 8,
		"Whetstone", 50,
		"Whetstone", 20,
		"Fleshing_Tool", 20,
		-- Personal
		"CigarettePack", 8,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		-- Misc.
		"Clipboard", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.ButcherTruckBed = {
	rolls = 4,
	items = {
		-- Tools
		"KitchenKnife", 20,
		"KnifeFillet", 10,
		"LargeHook", 10,
		"LargeKnife", 8,
		"MeatCleaver", 8,
		"Whetstone", 50,
		"Whetstone", 20,
		"Fleshing_Tool", 20,
		-- Materials
		"Tarp", 20,
		"HeavyChain", 10,
		"Rope", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.ButcherSeatFront = {
	rolls = 1,
	items = {
		-- Tools
		"KitchenKnife", 20,
		"KnifeFillet", 10,
		"LargeHook", 10,
		"LargeKnife", 8,
		"MeatCleaver", 8,
		"Whetstone", 50,
		"Whetstone", 20,
		"Fleshing_Tool", 20,
		-- Materials
		"Tarp", 20,
		"HeavyChain", 10,
		"Rope", 20,
		-- Misc.
		"MarkerBlack", 4,
		"Notepad", 10,
		"Pencil", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Butcher = {
	TruckBed = VehicleDistributions.ButcherTruckBed;
	
	GloveBox = VehicleDistributions.ButcherGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontLeft = VehicleDistributions.ButcherSeatFront;
}

VehicleDistributions.LeatherGloveBox = {
	rolls = 1,
	items = {
		-- Tools
		"Awl", 50,
		"Awl", 20,
		"Awl", 20,
		"Awl", 10,
		"Whetstone", 20,
		"Whetstone", 10,
		"Fleshing_Tool", 10,
		"SewingKit", 50,
		-- Personal
		"CigarettePack", 8,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		-- Misc.
		"Clipboard", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.LeatherTruckBed = {
	rolls = 4,
	items = {
		-- Tools
		"Awl", 50,
		"Awl", 20,
		"Awl", 20,
		"Awl", 10,
		"Whetstone", 20,
		"Whetstone", 10,
		"Fleshing_Tool", 10,
		"SewingKit", 20,
		-- Materials
		"Leather_Crude_Small_Tan", 50,
		"Leather_Crude_Small_Tan", 20,
		"Leather_Crude_Small_Tan", 20,
		"Leather_Crude_Small_Tan", 10,
		"Leather_Crude_Large_Tan", 50,
		"Leather_Crude_Large_Tan", 20,
		"SewingKit", 20,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.LeatherSeatFront = {
	rolls = 1,
	items = {
		-- Tools
		"Awl", 50,
		"Awl", 20,
		"Awl", 20,
		"Awl", 10,
		"Whetstone", 20,
		"Whetstone", 10,
		"Fleshing_Tool", 10,
		"SewingKit", 20,
		-- Materials
		"Leather_Crude_Small_Tan", 50,
		"Leather_Crude_Small_Tan", 20,
		"Leather_Crude_Small_Tan", 20,
		"Leather_Crude_Small_Tan", 10,
		-- Misc.
		"MarkerBlack", 4,
		"Notepad", 10,
		"Pencil", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Leather = {
	TruckBed = VehicleDistributions.LeatherTruckBed;
	
	GloveBox = VehicleDistributions.LeatherGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontLeft = VehicleDistributions.LeatherSeatFront;
}

VehicleDistributions.GlassGloveBox = {
	rolls = 1,
	items = {
		-- Keys/Keyrings
		"KeyRing_EagleFlag", 0.1,
		"KeyRing_EightBall", 0.1,
		"KeyRing_Panther", 0.1,
		"KeyRing_Sexy", 0.1,
		-- Tools
		"CeramicCrucibleSmall", 20,
		"GlassBlowingPipe", 10,
		"Pliers", 20,
		"Tongs", 20,
		-- Equipment
		"Hat_BandanaTINT", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		-- Personal
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Paperback", 4,
		"TobaccoChewing", 1,
		-- Misc.
		"Clipboard", 10,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paperwork", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		-- Medical
		"BookFirstAid1", 0.5,
		"FirstAidKit", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.GlassTruckBed = {
	rolls = 4,
	items = {
		-- Tools
		"CeramicCrucibleSmall", 20,
		"GlassBlowingPipe", 10,
		"Pliers", 20,
		"Tongs", 20,
		-- Equipment
		"Hat_BandanaTINT", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		-- Materials
		"Charcoal", 50,
		"Charcoal", 20,
		-- Literature
		"BookGlassmaking1", 2,
		"BookGlassmaking2", 1,
		"BookGlassmaking3", 0.5,
		"BookGlassmaking4", 0.1,
		"BookGlassmaking5", 0.05,
		-- Windows
		"Mov_WindowChrome", 10,
		"Mov_WindowSlider", 10,
		"Mov_WindowTiled", 10,
		"Mov_WindowWhite", 10,
		"Mov_WindowWhiteTiled", 10,
		"Mov_WindowWooden", 10,
		-- Misc.
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Mov_LightConstruction", 4,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.GlassSeatFront = {
	rolls = 1,
	items = {
		-- Tools
		"CeramicCrucibleSmall", 50,
		"GlassBlowingPipe", 20,
		"Pliers", 50,
		"Tongs", 50,
		-- Materials
		"Charcoal", 20,
		-- Equipment
		"Hat_BandanaTINT", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		-- Literature
		"BookGlassmaking1", 2,
		"BookGlassmaking2", 1,
		"BookGlassmaking3", 0.5,
		"BookGlassmaking4", 0.1,
		"BookGlassmaking5", 0.05,
		-- Misc.
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Glass = {
	
	TruckBed = VehicleDistributions.GlassTruckBed;
	
	GloveBox = VehicleDistributions.GlassGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.GlassSeatFront;
}

VehicleDistributions.TailoringGloveBox = {
	rolls = 1,
	items = {
		-- Dye
		"IndustrialDye", 20,
		-- Tools
		"Awl", 10,
		"Needle", 50,
		"Needle", 20,
		"Scissors", 20,
		"SewingKit", 10,
		-- Personal
		"CigarettePack", 8,
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Magazine_Popular", 10,
		-- Misc.
		"Clipboard", 10,
		"MarkerBlack", 4,
		"Notepad", 10,
		"Paperwork", 10,
		"Pencil", 10,
		"Receipt", 10,
	},
	junk = ClutterTables.GloveBoxJunk,
}

VehicleDistributions.TailoringTruckBed = {
	rolls = 4,
	items = {

	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.TailoringSeatFront = {
	rolls = 1,
	items = {
		-- Dye
		"IndustrialDye", 20,
		-- Tools
		"Awl", 10,
		"Needle", 50,
		"Needle", 20,
		"Scissors", 20,
		"SewingKit", 10,
		-- Materials
		"FabricRoll_Cotton", 50,
		"FabricRoll_Cotton", 20,
		"FabricRoll_DenimBlack", 20,
		"FabricRoll_DenimBlue", 50,
		"FabricRoll_DenimDarkBlue", 20,
		"Thread", 50,
		"Thread", 20,
		-- Misc.
		"MarkerBlack", 4,
		"Notepad", 10,
		"Pencil", 10,
		"Thimble", 20,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Tailoring = {
	TruckBed = VehicleDistributions.TailoringTruckBed;

	GloveBox = VehicleDistributions.TailoringGloveBox;

	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontLeft = VehicleDistributions.TailoringSeatFront;
}

VehicleDistributions.PropaneGloveBox = {
	rolls = 1,
	items = {
		-- Keys/Keyrings
		"KeyRing_EagleFlag", 0.1,
		"KeyRing_EightBall", 0.1,
		"KeyRing_Panther", 0.1,
		"KeyRing_Sexy", 0.1,
		-- Tools
		"PipeWrench", 20,
		"Pliers", 20,
		"Ratchet", 10,
		"RubberHose", 20,
		"Wrench", 20,
		-- Equipment
		"Hat_BandanaTINT", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		-- Personal
		"Flask", 0.5,
		"Lunchbag", 4,
		"Lunchbox", 2,
		"Lunchbox2", 0.01,
		"Paperback", 4,
		"TobaccoChewing", 1,
		-- Misc.
		"Clipboard", 10,
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"Paperwork", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
		-- Medical
		"BookFirstAid1", 0.5,
		"FirstAidKit", 1,
	},
	junk = ClutterTables.GloveBoxWorkJunk,
}

VehicleDistributions.PropaneTruckBed = {
	rolls = 4,
	items = {
		-- Tools
		"PipeWrench", 20,
		"Pliers", 20,
		"Ratchet", 10,
		"RubberHose", 20,
		"Wrench", 20,
		-- Equipment
		"Hat_BandanaTINT", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		-- Fuel
		"PropaneTank", 100,
		"PropaneTank", 50,
		"PropaneTank", 50,
		"PropaneTank", 20,
		-- Misc.
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
	},
	junk = ClutterTables.TrunkJunk,
}

VehicleDistributions.PropaneSeatFront = {
	rolls = 1,
	items = {
		-- Tools
		"PipeWrench", 20,
		"Pliers", 20,
		"Ratchet", 10,
		"RubberHose", 20,
		"Wrench", 20,
		-- Equipment
		"Hat_BandanaTINT", 10,
		"Glasses_SafetyGoggles", 10,
		"Gloves_LeatherGloves", 10,
		-- Misc.
		"MarkerBlack", 4,
		"MeasuringTape", 10,
		"RippedSheets", 10,
		"RippedSheetsDirty", 10,
	},
	junk = ClutterTables.SeatFrontJunk,
}

VehicleDistributions.Propane = {
	
	TruckBed = VehicleDistributions.PropaneTruckBed;
	
	GloveBox = VehicleDistributions.PropaneGloveBox;
	
	SeatFrontLeft = VehicleDistributions.DriverSeat;
	SeatFrontRight = VehicleDistributions.PropaneSeatFront;
}

local distributionTable = {
	-- Classic cars
	SportsCar = {
		Normal = VehicleDistributions.NormalSports,
		Specific = { VehicleDistributions.Dancer, VehicleDistributions.Doctor, VehicleDistributions.Golf, VehicleDistributions.Nurse, VehicleDistributions.Survivalist, VehicleDistributions.Bandit, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.BadTeens},
	},

	ModernCar = {
		Normal = VehicleDistributions.NormalLuxury,
		Specific = { VehicleDistributions.Doctor, VehicleDistributions.Golf, VehicleDistributions.Nurse, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.BadTeens },
	},

	ModernCar02 = {
		Normal = VehicleDistributions.NormalLuxury,
		Specific = { VehicleDistributions.Doctor, VehicleDistributions.Golf, VehicleDistributions.Nurse, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.BadTeens },
	},

	CarLuxury = {
		Normal = VehicleDistributions.NormalLuxury,
		Specific = { VehicleDistributions.Dancer, VehicleDistributions.Doctor, VehicleDistributions.Golf, VehicleDistributions.NormalSports, VehicleDistributions.Nurse, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.BadTeens },
	},

	CarNormal =  {
		Normal = VehicleDistributions.NormalStandard,
		Specific = { VehicleDistributions.Clothing, VehicleDistributions.Doctor, VehicleDistributions.Golf, VehicleDistributions.Groceries, VehicleDistributions.Nurse, VehicleDistributions.Evacuee, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.BadTeens },
	},

	CarLights =  {
		Normal = VehicleDistributions.NormalStandard,
		Specific = { VehicleDistributions.Survivalist },
	},

	SmallCar =  {
		Normal = VehicleDistributions.NormalStandard,
		Specific = { VehicleDistributions.Clothing, VehicleDistributions.Dancer, VehicleDistributions.Doctor, VehicleDistributions.Groceries, VehicleDistributions.Nurse, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.BadTeens},
	},

	SmallCar02 =  {
		Normal = VehicleDistributions.NormalStandard,
		Specific = { VehicleDistributions.Clothing, VehicleDistributions.Doctor, VehicleDistributions.Groceries, VehicleDistributions.Nurse, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.BadTeens, VehicleDistributions.BadTeens},
	},

	CarStationWagon =  {
		Normal = VehicleDistributions.NormalStandard,
		Specific = { VehicleDistributions.Clothing, VehicleDistributions.Doctor, VehicleDistributions.Evacuee, VehicleDistributions.Golf, VehicleDistributions.Groceries, VehicleDistributions.Nurse, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	CarStationWagon2 =  {
		Normal = VehicleDistributions.NormalStandard,
		Specific = { VehicleDistributions.Clothing, VehicleDistributions.Doctor, VehicleDistributions.Evacuee, VehicleDistributions.Golf, VehicleDistributions.Groceries, VehicleDistributions.Nurse, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	Van =  {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Farmer, VehicleDistributions.Carpenter, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.Survivalist, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.Groceries, VehicleDistributions.Bandit, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.BadTeens, VehicleDistributions.Mason},
	},

	StepVan = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Farmer, VehicleDistributions.Carpenter, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.Survivalist, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.Laundry, VehicleDistributions.Exterminator, VehicleDistributions.Mason},
	},

	VanSeats = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Clothing, VehicleDistributions.Doctor, VehicleDistributions.Golf, VehicleDistributions.Groceries, VehicleDistributions.Nurse, VehicleDistributions.Survivalist, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	OffRoad = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Hunter, VehicleDistributions.Fisherman, VehicleDistributions.Survivalist, VehicleDistributions.Adventurer },
	},

	SUV = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Clothing, VehicleDistributions.Doctor, VehicleDistributions.Evacuee, VehicleDistributions.Golf, VehicleDistributions.Groceries, VehicleDistributions.Nurse, VehicleDistributions.Survivalist, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	PickUpVan = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Hunter, VehicleDistributions.Fisherman, VehicleDistributions.Carpenter, VehicleDistributions.Farmer, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.Survivalist, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.Rancher, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Mason },
	},

	PickUpVanLights = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Survivalist },
	},

	PickUpTruck = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Hunter, VehicleDistributions.Fisherman, VehicleDistributions.Carpenter, VehicleDistributions.Farmer, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.Survivalist, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.Rancher, VehicleDistributions.Bandit, VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Mason },
	},

	PickUpTruckLights = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = {  VehicleDistributions.Survivalist },
	},

	Trailer = {
		Normal = VehicleDistributions.NormalStandard,
		Specific = { VehicleDistributions.Fisherman, VehicleDistributions.Carpenter, VehicleDistributions.Farmer, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.Survivalist, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.Rancher, VehicleDistributions.Mason },
	},

	TrailerCover = {
		Normal = VehicleDistributions.NormalStandard,
		Specific = { VehicleDistributions.Fisherman, VehicleDistributions.Carpenter, VehicleDistributions.Farmer, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.Survivalist, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.Rancher, VehicleDistributions.Mason },
	},

	PickUpVan_Camo = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Hunter, VehicleDistributions.Fisherman,  VehicleDistributions.Survivalist, VehicleDistributions.Drinker },
	},

	PickUpTruck_Camo = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.Hunter, VehicleDistributions.Fisherman,  VehicleDistributions.Survivalist, VehicleDistributions.Drinker },
	},

	StepVan_Cereal = {
		Normal = VehicleDistributions.StepVan_Cereal,
	},

	StepVan_Masonry = {
		Normal = VehicleDistributions.Mason,
	},

	Van_Masonry = {
		Normal = VehicleDistributions.Mason,
	},

	VanSeats_Creature = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	-- TODO: Discuss unique loot for these with Blair.
	VanSeats_LadyDelighter = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	VanSeats_Space = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	VanSeats_Trippy  = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	VanSeats_Valkyrie  = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	VanSeats_Mural  = {
		Normal = VehicleDistributions.NormalHeavy,
		Specific = { VehicleDistributions.PackRat, VehicleDistributions.Drinker, VehicleDistributions.Camper, VehicleDistributions.BadTeens},
	},

	Van_Perfick_Potato = {
		Normal = VehicleDistributions.StepVan_Chips,
	},

	-- Specific cars like police, fire, ranger... We simply add their skin index to the loot table's name if they have one.

	-- Taxi
	CarTaxi = { Normal = VehicleDistributions.Taxi },
	CarTaxi2 = { Normal = VehicleDistributions.Taxi },

	-- Police
	PickUpVanLightsPolice = { Normal = VehicleDistributions.Police },
	CarLightsPolice = { Normal = VehicleDistributions.Police },

	-- Fire dept
	PickUpTruckLightsFire = { Normal = VehicleDistributions.Fire },
	PickUpVanLightsFire = { Normal = VehicleDistributions.Fire },

	-- Ranger
	PickUpVanLightsRanger = { Normal = VehicleDistributions.Ranger },
	PickUpTruckLightsRanger = { Normal = VehicleDistributions.Ranger },
	CarLightsRanger = { Normal = VehicleDistributions.Ranger },

	-- McCoy
	PickUpVanMccoy = { Normal = VehicleDistributions.McCoy },
	PickUpTruckMccoy = { Normal = VehicleDistributions.McCoy },
	VanMccoy = { Normal = VehicleDistributions.McCoy },

	-- Fossoil
	PickUpVanLightsFossoil = { Normal = VehicleDistributions.Fossoil },
	PickUpTruckLightsFossoil = { Normal = VehicleDistributions.Fossoil },
	VanFossoil = { Normal = VehicleDistributions.Fossoil },

	-- Postal
	StepVanMail = { Normal = VehicleDistributions.Postal },
	VanMail = { Normal = VehicleDistributions.Postal },

	-- Distillery
	StepVan_Scarlet = { Normal = VehicleDistributions.Distillery },
	Van_KnoxDisti = { Normal = VehicleDistributions.KnoxDistillery },

	-- MassGenFac
	Van_MassGenFac = { Normal = VehicleDistributions.MassGenFac },

	Van_Transit = { Normal = VehicleDistributions.Transit },

	-- Ambulance
	VanAmbulance = { Normal = VehicleDistributions.Ambulance },

	-- Radio
	VanRadio = { Normal = VehicleDistributions.Radio },
	VanRadio_3N = { Normal = VehicleDistributions.NNN },

	-- Spiffo
	VanSpiffo = { Normal = VehicleDistributions.Spiffo },

	-- KY Heralds
	StepVan_Heralds = { Normal = VehicleDistributions.Heralds },

	-- Plonkies
	StepVan_Plonkies ={ Normal = VehicleDistributions.StepVan_Plonkies },

	-- soft drinks/pop/soda
	StepVan_Citr8 ={ Normal = VehicleDistributions.StepVan_Soda },

	-- LectroMax
	Van_LectroMax = { Normal = VehicleDistributions.Electrician },

	VanSeats_Prison = { Normal = VehicleDistributions.PrisonGuard },
	-- Airport Vehicles
	PickUpTruckLightsAirport = { Normal = VehicleDistributions.PickUpTruckLights_Airport },
	StepVanAirportCatering = { Normal = VehicleDistributions.StepVan_AirportCatering },
	VanSeatsAirportShuttle  = { Normal = VehicleDistributions.VanSeats_AirportShuttle  },
	-- new utility vehicles
	VanUtility = { Normal = VehicleDistributions.ConstructionWorker },
	VanDeerValley = { Normal = VehicleDistributions.ConstructionWorker },
	VanKnobCreekGas = { Normal = VehicleDistributions.ConstructionWorker },
	VanOldMill = { Normal = VehicleDistributions.ConstructionWorker },
	VanKnoxCom = { Normal = VehicleDistributions.ConstructionWorker },
	-- new carpenter vehicles
	VanCarpenter = { Normal = VehicleDistributions.Carpenter },
	PickUpVanYingsWood = { Normal = VehicleDistributions.Carpenter },
	StepVan_Jorgensen = { Normal = VehicleDistributions.Carpenter },
	VanMicheles = { Normal = VehicleDistributions.Carpenter },
	VanJohnMcCoy = { Normal = VehicleDistributions.Carpenter },
	VanRosewoodworking = { Normal = VehicleDistributions.Carpenter },
	VanWPCarpentry = { Normal = VehicleDistributions.Carpenter },
	PickUpVanLightsKentuckyLumber = { Normal = VehicleDistributions.Carpenter },
	-- new landscaper vehicles
	VanGardener = { Normal = VehicleDistributions.Gardener },
	PickUpTruckJPLandscaping = { Normal = VehicleDistributions.Gardener },
	PickUpVanCallowayLandscaping = { Normal = VehicleDistributions.Gardener },
	StepVan_RandisPlants = { Normal = VehicleDistributions.Gardener },
	VanGardenGods = { Normal = VehicleDistributions.Gardener },
	VanLouisvilleLandscaping = { Normal = VehicleDistributions.Gardener },
	VanTreyBaines = { Normal = VehicleDistributions.Gardener },
	-- metalworking vehicles
	PickUpVanMetalworker = { Normal = VehicleDistributions.MetalWelder },
	VanMetalworker = { Normal = VehicleDistributions.MetalWelder },
	PickUpVanWeldingbyCamille = { Normal = VehicleDistributions.MetalWelder },
	VanRiversideFabrication = { Normal = VehicleDistributions.MetalWelder },
	VanSchwabSheetMetal = { Normal = VehicleDistributions.MetalWelder },
	VanMetalheads = { Normal = VehicleDistributions.MetalWelder },
	VanJonesFabrication = { Normal = VehicleDistributions.MetalWelder },
	PickUpVanHeltonMetalWorking = { Normal = VehicleDistributions.MetalWelder },
	VanMeltingPointMetal = { Normal = VehicleDistributions.MetalWelder },
	-- builder vehicles
	PickUpVanBuilder = { Normal = VehicleDistributions.ConstructionWorker },
	VanBuilder = { Normal = VehicleDistributions.ConstructionWorker },
	PickUpVanBrickingIt = { Normal = VehicleDistributions.ConstructionWorker },
	PickUpVanKimbleKonstruction = { Normal = VehicleDistributions.ConstructionWorker },
	VanBeckmans = { Normal = VehicleDistributions.ConstructionWorker },
	VanPennSHam = { Normal = VehicleDistributions.ConstructionWorker },
	VanKerrHomes = { Normal = VehicleDistributions.ConstructionWorker },
	PickUpVanMarchRidgeConstruction = { Normal = VehicleDistributions.ConstructionWorker },
	VanCoastToCoast = { Normal = VehicleDistributions.ConstructionWorker },
	-- mechanic vehicles
	StepVan_Mechanic = { Normal = VehicleDistributions.Mechanic },
	VanMechanic = { Normal = VehicleDistributions.Mechanic },
	StepVan_CompleteRepairShop = { Normal = VehicleDistributions.Mechanic },
	StepVan_LouisvilleMotorShop = { Normal = VehicleDistributions.Mechanic },
	VanKorshunovs = { Normal = VehicleDistributions.Mechanic },
	VanBrewsterHarbin = { Normal = VehicleDistributions.Mechanic },
	VanPlattAuto = { Normal = VehicleDistributions.Mechanic },
	VanMooreMechanics = { Normal = VehicleDistributions.Mechanic },
	VanMobileMechanics = { Normal = VehicleDistributions.Mechanic },
	-- tailoring vehicles
	StepVan_SmartKut = { Normal = VehicleDistributions.Tailoring },
	Van_HeritageTailors = { Normal = VehicleDistributions.Tailoring },

	-- other categories of profession vehicles
	StepVan_HuangsLaundry = { Normal = VehicleDistributions.Laundry },
	StepVan_SouthEasternHosp = { Normal = VehicleDistributions.Catering },
	StepVan_SouthEasternPaint = { Normal = VehicleDistributions.Painter },
	StepVan_USL = { Normal = VehicleDistributions.Courier },
	VanGreenes = { Normal = VehicleDistributions.Groceries},
	VanOvoFarm = { Normal = VehicleDistributions.Eggs},
	VanPluggedInElectrics = { Normal = VehicleDistributions.Electrician },
	Van_VoltMojo = { Normal = VehicleDistributions.Electrician },
	VanUncloggers = { Normal = VehicleDistributions.Plumber },
	Van_BugWipers = { Normal = VehicleDistributions.Exterminator },
	Van_Charlemange_Beer = { Normal = VehicleDistributions.Van_Beer },
	StepVan_Genuine_Beer = { Normal = VehicleDistributions.StepVan_ImportedBeer },
	StepVan_MarineBites = { Normal = VehicleDistributions.StepVan_MarineBites },
	StepVan_Zippee = { Normal = VehicleDistributions.StepVan_Zippee },
	Van_Locksmith = { Normal = VehicleDistributions.Van_Locksmith },
	StepVan_Florist = { Normal = VehicleDistributions.StepVan_Florist },
	Van_CraftSupplies = { Normal = VehicleDistributions.Van_CraftSupplies },
	StepVan_Blacksmith = { Normal = VehicleDistributions.Blacksmith },
	Van_Blacksmith = { Normal = VehicleDistributions.Blacksmith },
	StepVan_Butchers = { Normal = VehicleDistributions.Butcher },
	Van_Leather = { Normal = VehicleDistributions.Leather },
	StepVan_MobileLibrary = { Normal = VehicleDistributions.MobileLibrary },
	Van_Glass = { Normal = VehicleDistributions.Glass },
	StepVan_Glass = { Normal = VehicleDistributions.Glass },
	StepVan_Propane = { Normal = VehicleDistributions.Propane },
	-- new law enforcement vehicles
	CarLightsBulletinSheriff = { Normal = VehicleDistributions.PoliceSheriff },
	CarLightsKST = { Normal = VehicleDistributions.PoliceState },
	CarLightsLouisvilleCounty = { Normal = VehicleDistributions.Police },
	CarLightsMuldraughPolice = { Normal = VehicleDistributions.Police },
	ModernCarLightsCityLouisvillePD = { Normal = VehicleDistributions.Police },
	ModernCarLightsMeadeSheriff = { Normal = VehicleDistributions.PoliceSheriff },
	ModernCarLightsWestPoint = { Normal = VehicleDistributions.Police },
	PickUpVanLightsLouisvilleCounty = { Normal = VehicleDistributions.Police },
	PickUpVanLightsStatePolice  = { Normal = VehicleDistributions.PoliceState },
	StepVan_LouisvilleSWAT = { Normal = VehicleDistributions.PoliceSWAT },
}

-- define smashed car like their normal counterpart
distributionTable.CarNormalSmashedRear = distributionTable.CarNormal
distributionTable.CarNormalSmashedFront = distributionTable.CarNormal
distributionTable.CarNormalSmashedLeft = distributionTable.CarNormal
distributionTable.CarNormalSmashedRight = distributionTable.CarNormal

distributionTable.CarLightsSmashedRear = distributionTable.CarLights
distributionTable.CarLightsSmashedFront = distributionTable.CarLights
distributionTable.CarLightsSmashedLeft = distributionTable.CarLights
distributionTable.CarLightsSmashedRight = distributionTable.CarLights

distributionTable.CarStationWagonSmashedRear = distributionTable.CarStationWagon
distributionTable.CarStationWagonSmashedFront = distributionTable.CarStationWagon
distributionTable.CarStationWagonSmashedLeft = distributionTable.CarStationWagon
distributionTable.CarStationWagonSmashedRight = distributionTable.CarStationWagon

distributionTable.CarStationWagon2SmashedRear = distributionTable.CarStationWagon2
distributionTable.CarStationWagon2SmashedFront = distributionTable.CarStationWagon2
distributionTable.CarStationWagon2SmashedLeft = distributionTable.CarStationWagon2
distributionTable.CarStationWagon2SmashedRight = distributionTable.CarStationWagon2

distributionTable.ModernCarSmashedRear = distributionTable.ModernCar
distributionTable.ModernCarSmashedFront = distributionTable.ModernCar
distributionTable.ModernCarSmashedLeft = distributionTable.ModernCar
distributionTable.ModernCarSmashedRight = distributionTable.ModernCar

distributionTable.ModernCar02SmashedRear = distributionTable.ModernCar02
distributionTable.ModernCar02SmashedFront = distributionTable.ModernCar02
distributionTable.ModernCar02SmashedLeft = distributionTable.ModernCar02
distributionTable.ModernCar02SmashedRight = distributionTable.ModernCar02

distributionTable.PickUpTruckSmashedRear = distributionTable.PickUpTruck
distributionTable.PickUpTruckSmashedFront = distributionTable.PickUpTruck
distributionTable.PickUpTruckSmashedLeft = distributionTable.PickUpTruck
distributionTable.PickUpTruckSmashedRight = distributionTable.PickUpTruck

distributionTable.CarLuxurySmashedRear = distributionTable.CarLuxury
distributionTable.CarLuxurySmashedFront = distributionTable.CarLuxury
distributionTable.CarLuxurySmashedLeft = distributionTable.CarLuxury
distributionTable.CarLuxurySmashedRight = distributionTable.CarLuxury

distributionTable.OffRoadSmashedRear = distributionTable.OffRoad
distributionTable.OffRoadSmashedFront = distributionTable.OffRoad
distributionTable.OffRoadSmashedLeft = distributionTable.OffRoad
distributionTable.OffRoadSmashedRight = distributionTable.OffRoad

distributionTable.PickUpTruckLightsSmashedRear = distributionTable.PickUpTruckLights
distributionTable.PickUpTruckLightsSmashedFront = distributionTable.PickUpTruckLights
distributionTable.PickUpTruckLightsSmashedLeft = distributionTable.PickUpTruckLights
distributionTable.PickUpTruckLightsSmashedRight = distributionTable.PickUpTruckLights

distributionTable.PickUpVanSmashedRear = distributionTable.PickUpVan
distributionTable.PickUpVanSmashedFront = distributionTable.PickUpVan
distributionTable.PickUpVanSmashedLeft = distributionTable.PickUpVan
distributionTable.PickUpVanSmashedRight = distributionTable.PickUpVan

distributionTable.PickUpVanLightsSmashedRear = distributionTable.PickUpVanLights
distributionTable.PickUpVanLightsSmashedFront = distributionTable.PickUpVanLights
distributionTable.PickUpVanLightsSmashedLeft = distributionTable.PickUpVanLights
distributionTable.PickUpVanLightsSmashedRight = distributionTable.PickUpVanLights

distributionTable.CarSmallSmashedRear = distributionTable.SmallCar
distributionTable.CarSmallSmashedFront = distributionTable.SmallCar
distributionTable.CarSmallSmashedLeft = distributionTable.SmallCar
distributionTable.CarSmallSmashedRight = distributionTable.SmallCar

distributionTable.CarSmall02SmashedRear = distributionTable.SmallCar02
distributionTable.CarSmall02SmashedFront = distributionTable.SmallCar02
distributionTable.CarSmall02SmashedLeft = distributionTable.SmallCar02
distributionTable.CarSmall02SmashedRight = distributionTable.SmallCar02

distributionTable.StepVanSmashedRear = distributionTable.StepVan
distributionTable.StepVanSmashedFront = distributionTable.StepVan
distributionTable.StepVanSmashedLeft = distributionTable.StepVan
distributionTable.StepVanSmashedRight = distributionTable.StepVan

distributionTable.StepVanMailSmashedRear = distributionTable.StepVanMail
distributionTable.StepVanMailSmashedFront = distributionTable.StepVanMail
distributionTable.StepVanMailSmashedLeft = distributionTable.StepVanMail
distributionTable.StepVanMailSmashedRight = distributionTable.StepVanMail

distributionTable.SUVSmashedRear = distributionTable.SUV
distributionTable.SUVSmashedFront = distributionTable.SUV
distributionTable.SUVSmashedLeft = distributionTable.SUV
distributionTable.SUVSmashedRight = distributionTable.SUV

table.insert(VehicleDistributions, 1, distributionTable)
