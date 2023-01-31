-- define here all the clothing that'll be available for a specific profession.
-- the default will always been available

ClothingSelectionDefinitions = ClothingSelectionDefinitions or {};

-- default selection, always available
ClothingSelectionDefinitions.default = {
	-- if there's no difference between male/female outfit, just create the female one, here we can have skirt
	Female = {
		-- this is the bodyLocation (defined in BodyLocations.lua)
		Hat = {
			chance = 10,
			items = {"Base.Hat_BaseballCap", "Base.Hat_BucketHat", "Base.Hat_GolfHat", "Base.Hat_Fedora", "Base.Hat_Visor_WhiteTINT", },
		},
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses_Normal", "Base.Glasses_Reading"},
		},
		
		TankTop = {
			chance = 10,
			items = {"Base.Vest_DefaultTEXTURE_TINT",},
		},
		
		Shirt = {
			chance = 10,
			items = {"Base.Shirt_FormalTINT", "Base.Shirt_FormalWhite_ShortSleeveTINT", "Base.Shirt_HawaiianTINT",},
			--saving this list for further option development
			--"Base.Dress_Normal", "Base.Dress_Normal", "Base.Dress_Knees", "Base.Dress_Long", "Base.Dress_long_Straps", "Base.Dress_SmallStrapless", "Base.Dress_Straps", "Base.DressKnees_Straps", "Base.Dress_SmallStraps", }, 
		},
	
		Tshirt = {
			items = {"Base.Tshirt_DefaultTEXTURE_TINT", "Base.Tshirt_WhiteLongSleeveTINT", "Base.Tshirt_PoloStripedTINT", "Base.Tshirt_PoloTINT", "Base.Shirt_CropTopTINT", "Base.Shirt_CropTopNoArmTINT", "Base.BoobTube", },
		},
		
--		Sweater = {
--			chance = 30,
--			items = {"Base.Jumper_PoloNeck", "Base.Jumper_RoundNeck", "Base.Jumper_VNeck"},
--		},
--
--		Jacket = {
--			chance = 30,
--			items = {"Base.Jacket_WhiteTINT", "Base.JacketLong_Random"},
--		},
		
		Pants = {
			items = {"Base.Trousers_DefaultTEXTURE_TINT", "Base.Trousers_Denim", "Base.Shorts_LongDenim", "Base.Shorts_ShortDenim", "Base.Shorts_ShortFormal"},
		},
		
		Skirt = {
			chance = 50,
			items = {"Base.Skirt_Knees", "Base.Skirt_Long", "Base.Skirt_Mini", "Base.Skirt_Normal",},
		},
		
		Dress = {
			chance = 10,
			items = {"Base.Dress_Normal", "Base.Dress_Normal", "Base.Dress_Knees", "Base.Dress_Long", "Base.Dress_long_Straps", "Base.Dress_SmallStrapless", "Base.Dress_Straps", "Base.DressKnees_Straps", "Base.Dress_SmallStraps",},
		},
		
		Socks = {
			items = {"Base.Socks_Ankle", "Base.Socks_Long",},
		},
		
		Shoes = {
			items = {"Base.Shoes_Random", "Base.Shoes_TrainerTINT", "Base.Shoes_Strapped"},
		},
	},
	
	Male = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_BaseballCap", "Base.Hat_BucketHat", "Base.Hat_GolfHat", "Base.Hat_Fedora", "Base.Hat_Visor_WhiteTINT", },
		},
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses_Normal", "Base.Glasses_Reading"},
		},
		
		TankTop = {
			chance = 30,
			items = {"Base.Vest_DefaultTEXTURE_TINT",},
		},
		
		Shirt = {
			chance = 10,
			items = {"Base.Shirt_FormalTINT", "Base.Shirt_FormalWhite_ShortSleeveTINT", "Base.Shirt_HawaiianTINT",},
		},
		
		Tshirt = {
			items = {"Base.Tshirt_DefaultTEXTURE_TINT", "Base.Tshirt_WhiteLongSleeveTINT", "Base.Tshirt_PoloStripedTINT", "Base.Tshirt_PoloTINT"},
		},
		
--		Sweater = {
--			chance = 30,
--			items = {"Base.Jumper_PoloNeck", "Base.Jumper_RoundNeck", "Base.Jumper_VNeck"},
--		},
--
--		Jacket = {
--			chance = 30,
--			items = {"Base.Jacket_WhiteTINT", "Base.JacketLong_Random"},
--		},
		
		Pants = {
			items = {"Base.Trousers_DefaultTEXTURE_TINT", "Base.Trousers_Denim", "Base.Shorts_LongDenim", "Base.Shorts_ShortDenim", "Base.Shorts_ShortFormal"},
		},
		
		Socks = {
			items = {"Base.Socks_Ankle", "Base.Socks_Long"},
		},
		
		Shoes = {
			items = {"Base.Shoes_Random", "Base.Shoes_TrainerTINT"},
		},
	}
}

ClothingSelectionDefinitions.fireofficer = {
	Female = {
		Tshirt = {
			items = {"Base.Tshirt_Profession_FiremanBlue", "Base.Tshirt_Profession_FiremanRed", "Base.Tshirt_Profession_FiremanRed02", "Base.Tshirt_Profession_FiremanWhite"},
		},
		
		Pants = {
--			chance = 30,
			items = {"Base.Trousers_Fireman"},
		},
		
--		Jacket = {
--			items = {"Base.Jacket_Fireman"},
--		},
		
--		Sweater = {
--			items = {};
--		},
		
		Shoes = {
			items = {"Base.Shoes_Black", "Base.Shoes_ArmyBoots"};
		},
	},
}

ClothingSelectionDefinitions.policeofficer = {
	Female = {
	
		Hat = {
			chance = 10,
			items = {"Base.Hat_Police",},
		},
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses", "Base.Glasses_Aviators"},
		},
		
		Shirt = {
			chance = 20,
			items = {"Base.Shirt_OfficerWhite", "Base.Shirt_PoliceBlue" , "Base.Tshirt_PoliceBlue"},
		},
		
		Tshirt = {
--			chance = 20,
			items = {"Base.Tshirt_Profession_PoliceBlue", "Base.Tshirt_Profession_PoliceWhite"},
		},
		
--		Jacket = {
--			chance = 20,
--			items = {"Base.Jacket_Police"},
--		},
		
		Pants = {
			items = {"Base.Trousers_Police"},
		},
		
		-- we remove sweater from this outfit, you can still select one if you want
--		Sweater = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.parkranger = {
	Female = {
	
		Hat = {
			chance = 10,
			items = {"Base.Hat_Ranger",},
		},
		
		Shirt = {
			items = {"Base.Shirt_Ranger", "Base.Tshirt_Ranger",},
		},
		
		Tshirt = {
--			chance = 20,
			items = {"Base.Tshirt_Profession_RangerBrown", "Base.Tshirt_Profession_RangerGreen"},
		},
		
--		Jacket = {
--			chance = 20,
--			items = {"Base.Jacket_Ranger"},
--		},
		
		Pants = {
			items = {"Base.Trousers_Ranger"},
		},
		
--		Sweater = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.constructionworker = {
	Female = {
		Shirt = {
			items = {"Base.Shirt_Denim"},
		},
		
		TorsoExtra = {
			chance = 30,
			items = {"Base.Vest_HighViz"},
		},
		
		Pants = {
--			chance = 50,
			items = {"Base.Trousers_JeanBaggy"},
		},
		
--		Sweater = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.securityguard = {
	Female = {
--		Neck = {
----			chance = 70,
--			items = {"Base.Tie_Full"},
--		},
		
		Shirt = {
			items = {"Base.Shirt_FormalWhite"},
		},
		
		Pants = {
			items = {"Base.Trousers_Black"},
		},
		
--		Sweater = {
--			items = {};
--		},
--
--		Jacket = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.carpenter = {
	Female = {
		Mask = {
			chance = 5,
			items = {"Base.Hat_DustMask", },
		},	
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses_SafetyGoggles"},
		},
		
		Shirt = {
			items = {"Base.Shirt_Denim", "Base.Shirt_Lumberjack",},
		},
		
--		Hands = {
----			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Pants = {
--			chance = 50,
			items = {"Base.Trousers_JeanBaggy"},
		},
		
--		Sweater = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.burglar = {
	Female = {
		Hat = {
			chance = 10,
			items = { "Base.Hat_Beany", },
		},
		
		Mask = {
			chance = 5,
			items = {"Base.Hat_BandanaMaskTINT", },
		},
		
		MaskFull = {
			chance = 5,
			items = {"Base.Hat_BalaclavaFull",},
		},
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses_Sun"},
		},
		
--		Hands = {
----			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Pants = {
			items = {"Base.Trousers_Denim"},
		},
		
	}
}

ClothingSelectionDefinitions.chef = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_ChefHat", },
		},
		Jacket = {
			chance = 50,
			items = {"Base.Jacket_Chef"},
		},
		
		Pants = {
			items = {"Base.Trousers_Chef"},
		},
	}
}

ClothingSelectionDefinitions.repairman = {
	Female = {
--		Hands = {
----			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Shirt = {
			items = {"Base.Shirt_Denim"},
		},
		
		Pants = {
			items = {"Base.Trousers_Denim"},
		},
		
--		Sweater = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.farmer = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_Cowboy", "Base.Hat_SummerHat"},
		},
		
--		Hands = {
----			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Shirt = {
			items = {"Base.Shirt_Denim", "Base.Shirt_Lumberjack"},
		},
		
		Pants = {
--			chance = 50,
			items = {"Base.Trousers_Denim"},
		},
		
		Shoes = {
			chance = 20,
			items = {"Base.Shoes_Wellies"},
		},
	},
	Male = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_Cowboy", },
		},
		
--		Hands = {
----			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Shirt = {
			items = {"Base.Shirt_Denim", "Base.Shirt_Lumberjack"},
		},
		
		Pants = {
--			chance = 50,
			items = {"Base.Trousers_Denim"},
		},
		
		Shoes = {
			chance = 20,
			items = {"Base.Shoes_Wellies"},
		},
	},
}

ClothingSelectionDefinitions.fisherman = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_Beany", "Base.Hat_BonnieHat_CamoGreen" },
		},
		
--		Hands = {
----			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Shirt = {
			items = {"Base.Shirt_Denim", "Base.Shirt_Lumberjack"},
		},
		
		Pants = {
--			chance = 50,
			items = {"Base.Trousers_JeanBaggy"},
		},
		
		Shoes = {
			chance = 20,
			items = {"Base.Shoes_Wellies"},
		},
	},
}

ClothingSelectionDefinitions.doctor = {
	Female = {
		Neck = {
			chance = 70,
			items = {"Base.Tie_Full", },
		},

		Hat = {
			chance = 5,
			items = {"Base.Hat_SurgicalMask_Blue", "Base.Hat_SurgicalMask_Green", },
		},
		
		Shirt = {
			items = {"Base.Shirt_FormalTINT"},
		},
		
		Hands = {
			chance = 5,
			items = {"Base.Gloves_Surgical"},
		},
		
		-- Jacket = {
			-- items = {"Base.JacketLong_Doctor"},
		-- },
		
		Pants = {
			items = {"Base.Trousers_SuitTEXTURE"},
		},
		
	},
}

ClothingSelectionDefinitions.veteran = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_BaseballCapArmy", "Base.Hat_BeretArmy", "Base.Hat_BonnieHat_CamoGreen", "Base.Hat_Bandana", },
		},
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses_Eyepatch_Left", "Base.Glasses_Eyepatch_Right", "Base.Glasses_Shooting"},
		},
		
		Shirt = {
			chance = 10,
			items = {"Base.Shirt_CamoGreen",},
		},
		
		Tshirt = {
			items = {"Base.Tshirt_Profession_VeterenGreen", "Base.Tshirt_Profession_VeterenRed"},
		},
		
		Pants = {
			items = {"Base.Shorts_CamoGreenLong"},
		},
		
		Shoes = {
			items = {"Base.Shoes_TrainerTINT"},
		},
		
		Necklace = {
			chance = 80,
			items = {"Base.Necklace_DogTag"},
		},
	},
}

ClothingSelectionDefinitions.nurse = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Hat_SurgicalCap_Blue", "Base.Hat_SurgicalCap_Green" },
		},
		
		Mask = {
			chance = 5,
			items = {"Base.Hat_SurgicalMask_Blue", "Base.Hat_SurgicalMask_Green", },
		},
		
		Shirt = {
			items = {"Base.Shirt_Scrubs"},
		},
		
		Hands = {
			chance = 5,
			items = {"Base.Gloves_Surgical"},
		},
		
		Pants = {
			items = {"Base.Trousers_Scrubs"},
		},
		
		Shoes = {
			items = {"Base.Shoes_TrainerTINT"},
		},
		
--		Jacket = {
--			items = {};
--		},
--
--		Sweater = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.lumberjack = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_Beany",},
		},
		
		Shirt = {
			items = {"Base.Shirt_Denim", "Base.Shirt_Lumberjack"},
		},
		
	
		Tshirt = {
			items = {"Base.Tshirt_McCoys"},
		},
		
--		Hands = {
----			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Pants = {
--			chance = 50,
			items = {"Base.Trousers_JeanBaggy"},
		},
		
--		Sweater = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.fitnessInstructor = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_Sweatband",},
		},
		
		Tshirt = {
--			chance = 30,
			items = {"Base.Tshirt_Sport"},
		},
		
		Hands = {
			chance = 20,
			items = {"Base.Gloves_FingerlessGloves"},
		},
		
		Pants = {
			items = {"Base.Shorts_LongSport", "Base.Shorts_ShortSport", },
		},
		
		Shoes = {
			items = {"Base.Shoes_TrainerTINT"},
		},
		
--		Sweater = {
--			items = {};
--		},
--
--		Jacket = {
--			items = {};
--		},
	},
}

ClothingSelectionDefinitions.burgerflipper = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_FastFood_Spiffo", },
		},
--		TankTop = {
--			items = {"Base.Vest_DefaultTEXTURE_TINT",},
--		},
		
		Shirt = {
			items = {};
		},
		
		Tshirt = {
			items = {"Base.Tshirt_BusinessSpiffo"};
		},
		
		Shoes = {
			items = {"Base.Shoes_TrainerTINT"},
		},
		
		Pants = {
			items = {"Base.Trousers_Denim"},
		},
		
--		Sweater = {
--			items = {};
--		},
--
--		Jacket = {
--			items = {};
--		},
		
--		TorsoExtra = {
--			items = {"Base.Apron_White"},
--		}
	},
}

ClothingSelectionDefinitions.electrician = {
	Female = {
		Mask = {
			chance = 5,
			items = {"Base.Hat_DustMask", },
		},	
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses_SafetyGoggles"},
		},
		
		Shirt = {
			items = {"Base.Shirt_Denim", "Base.Shirt_Lumberjack"},
		},
		
--		Hands = {
--			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Pants = {
			items = {"Base.Trousers_Denim"},
		},
		
--		Sweater = {
--			items = {};
--		},
		
--		FullSuit = {
--			chance = 20,
--			items = {"Boilersuit"},
--		},
		
		TorsoExtra = {
			chance = 30,
			items = {"Base.Vest_HighViz"},
		},
	},
}

ClothingSelectionDefinitions.metalworker = {
	Female = {
		Mask = {
			chance = 5,
			items = {"Base.Hat_DustMask", },
		},	
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses_SafetyGoggles"},
		},
		
		Shirt = {
			items = {"Base.Shirt_Denim", "Base.Shirt_Lumberjack"},
		},
		
--		Hands = {
--			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Pants = {
			items = {"Base.Trousers_Denim"},
		},
		
--		Sweater = {
--			items = {};
--		},
		
--		FullSuit = {
--			chance = 20,
--			items = {"Boilersuit"},
--		},
		
		TorsoExtra = {
			chance = 30,
			items = {"Base.Vest_HighViz"},
		},
	},
}

ClothingSelectionDefinitions.engineer = {
	Female = {
		Hat = {
			chance = 5,
			items = {"Base.Hat_DustMask", },
		},	
		
		Neck = {
			chance = 20,
			items = {"Base.Tie_Full"},
		},
		
		Shirt = {
			items = {"Base.Shirt_FormalTINT"},
		},
		
		Pants = {
			items = {"Base.Trousers_SuitTEXTURE"},
		},
		
--		Sweater = {
--			items = {};
--		},
		
		TorsoExtra = {
			chance = 30,
			items = {"Base.Vest_HighViz"},
		},
	},
}

ClothingSelectionDefinitions.mechanics = {
	Female = {
		Hat = {
			chance = 10,
			items = {"Base.Hat_Bandana", },
		},	
		
		Mask = {
			chance = 5,
			items = {"Base.Hat_DustMask", },
		},	
		
		Eyes = {
			chance = 10,
			items = {"Base.Glasses_SafetyGoggles"},
		},
		
		Shirt = {
			items = {"Base.Shirt_Denim", "Base.Shirt_Lumberjack"},
		},
	
		Tshirt = {
			items = {"Base.Tshirt_Fossoil", "Base.Tshirt_Gas2Go", "Base.Tshirt_ThunderGas"},
		},
		
--		Hands = {
--			chance = 20,
--			items = {"Base.Gloves_LeatherGloves"},
--		},
		
		Pants = {
			items = {"Base.Trousers_Denim"},
		},
		
--		Sweater = {
--			items = {};
--		},
		
--		FullSuit = {
--			chance = 20,
--			items = {"Boilersuit"},
--		},
		
--		TorsoExtra = {
--			chance = 30,
--			items = {"Base.Vest_HighViz"},
--		},
	},
}
