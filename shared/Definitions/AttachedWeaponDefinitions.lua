-- define weapons to be attached to zombies when creating them
-- random knives inside their neck, spear in their stomach, meatcleaver in their back...
-- this is used in IsoZombie.addRandomAttachedWeapon()

AttachedWeaponDefinitions = AttachedWeaponDefinitions or {};

-- This is now defined in the Zombie Sandbox settings
-- AttachedWeaponDefinitions.chanceOfAttachedWeapon = 6; -- Global chance of having an attached weapon, if we pass this we gonna add randomly one from the list

-- random spear in the stomach
AttachedWeaponDefinitions.spearStomach = {
	chance = 5, -- chance is total, we'll get the chance of every definition and take one from there
	weaponLocation = {"Stomach"}, -- defined in AttachedLocations.lua
	bloodLocations = {"Torso_Lower","Back"}, -- we add blood & hole on this part
	addHoles = true, -- if true, you need at least one bloodLocation
	daySurvived = 30, -- needed day of survival before seeing this one
	weapons = { -- list of possible weapons, we'll take one randomly from there
		"Base.ClosedUmbrellaBlack",
		"Base.ClosedUmbrellaBlue",
		"Base.ClosedUmbrellaRed",
		"Base.ClosedUmbrellaWhite",
		"Base.FireplacePoker",
		"Base.FieldHockeyStick",
		"Base.IceHockeyStick",
		"Base.LongHandle",
		"Base.LongStick_Broken",
		"Base.Poolcue",
		"Base.SpearCrafted",
		"Base.SpearGlass",
		"Base.SpearHuntingKnife",
		"Base.SpearKnife",
		"Base.SpearScissors",
		"Base.SpearScrewdriver",
		"Base.SpearSteakKnife",
		"Base.TableLeg", -- it's kind of ridiculous, but so was the night stick or metal pipe through the tummy, we're allowed some reasonable fun
		"Base.WoodenStick2",
	},
}

AttachedWeaponDefinitions.spearStomach_Special = {
	chance = 1,
	weaponLocation = {"Stomach"},
	bloodLocations = {"Torso_Lower","Back"},
	addHoles = true,
	daySurvived = 60,
	weapons = {
		"Base.LongStick",
		"Base.Sapling",
		"Base.SpearCraftedFireHardened",
		"Base.SpearCrude",
		"Base.SpearCrudeLong",
		"Base.SpearBone",
		"Base.SpearBone_Long",
	},
}

-- katana in stomach
-- diluted with lower tier weapons now
AttachedWeaponDefinitions.katanaStomach = {
	chance = 1,
	weaponLocation = {"Stomach"},
	bloodLocations = {"Torso_Lower","Back"},
	addHoles = true,
	daySurvived = 60,
	weapons = {
		"Base.BreadKnife", -- a little extra balancing
		"Base.CrudeShortSword",
		"Base.Katana",
		"Base.Katana_Broken",
		"Base.Machete",
		"Base.Machete_Crude",
		"Base.ShortSword_Scrap",
		"Base.Sword_Scrap",
		"Base.Sword_Scrap_Broken",
	},
}

-- meat cleaver & some others low weapons (Hand Axes..) in the back
AttachedWeaponDefinitions.meatCleaverBackLowQuality = {
	chance = 5,
	weaponLocation = {"MeatCleaver in Back"},
	bloodLocations = {"Back"},
	addHoles = true,
	daySurvived = 0,
	weapons = {
		"Base.HandAxe",
		"Base.MeatCleaver",
	},
}

-- Better weapons in the back
AttachedWeaponDefinitions.meatCleaverBack = {
	chance = 1,
	weaponLocation = {"MeatCleaver in Back"},
	bloodLocations = {"Back"},
	addHoles = true,
	daySurvived = 20,
	weapons = {
		"Base.HandAxe_Old",
		"Base.Machete",
		"Base.Machete_Crude",
		"Base.MeatCleaver_Scrap",
	},
}

-- Axe in the back
AttachedWeaponDefinitions.axeBack = {
	chance = 2,
	weaponLocation = {"Axe Back"},
	bloodLocations = {"Back"},
	addHoles = true,
	daySurvived = 15,
	weapons = {
		"Base.Axe",
		"Base.IceAxe",
-- 		"Base.PickAxe",
-- 		"Base.WoodAxe",
	},
}

-- Axe in the back
AttachedWeaponDefinitions.axeBack_Special = {
	chance = 1,
	weaponLocation = {"Axe Back"},
	bloodLocations = {"Back"},
	addHoles = true,
	daySurvived = 60,
	weapons = {
		"Base.Axe_Old",
		"Base.Axe_Sawblade",
		"Base.Axe_Sawblade_Hatchet",
		"Base.Axe_ScrapCleaver",
		"Base.Hatchet_Bone",
		"Base.JawboneBovide_Axe",
	},
}

-- random knife (low quality weapon) in the back
AttachedWeaponDefinitions.knifeLowQualityBack = {
	chance = 30,
	weaponLocation = {"Knife in Back"},
	bloodLocations = {"Back"},
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.ButterKnife",
		"Base.CarvingFork2",
		"Base.Fork",
		"Base.HandFork",
		"Base.LetterOpener",
		"Base.KnifeFillet",
		"Base.KnifeParing",
		"Base.Screwdriver",
		"Base.Scissors",
		"Base.TinOpener_Old",
	},
}

-- hunting knife (better quality) in the back
AttachedWeaponDefinitions.huntingKnifeBack = {
	chance = 5,
	weaponLocation = {"Knife in Back"},
	bloodLocations = {"Back"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
        "Base.HandShovel",
		"Base.HuntingKnife",
		"Base.LargeKnife",
        "Base.MasonsTrowel",
	},
}

-- random knife (better quality) in the back
AttachedWeaponDefinitions.knifeBack = {
	chance = 10,
	weaponLocation = {"Knife in Back"},
	bloodLocations = {"Back"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
		"Base.BreadKnife",
		"Base.KitchenKnife",
		"Base.SteakKnife",
	},
}

AttachedWeaponDefinitions.knifeBack_Special = {
	chance = 1,
	weaponLocation = {"Knife in Back"},
	bloodLocations = {"Back"},
	addHoles = false,
	daySurvived = 60,
	weapons = {
		"Base.CrudeKnife",
		"Base.FightingKnife",
		"Base.GlassShiv",
		"Base.KnifeShiv",
		"Base.LongCrudeKnife",
		"Base.LongStick_Broken",
        "Base.SharpBone_Long",
        "Base.Toothbrush_Shiv",
	},
}

-- random knife (low quality weapon) in the left leg
AttachedWeaponDefinitions.knifeLowQualityLeftLeg = {
	chance = 30,
	weaponLocation = {"Knife Left Leg"},
	bloodLocations = {"UpperLeg_L"},
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.ButterKnife",
		"Base.CarvingFork2",
		"Base.Fork",
		"Base.HandFork",
		"Base.LetterOpener",
		"Base.KnifeFillet",
		"Base.KnifeParing",
		"Base.Screwdriver",
		"Base.Scissors",
		"Base.TinOpener_Old",
	},
}

-- hunting knife (better quality) in the left leg
AttachedWeaponDefinitions.huntingKnifeLeftLeg = {
	chance = 5,
	weaponLocation = {"Knife Left Leg"},
	bloodLocations = {"UpperLeg_L"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
        "Base.HandShovel",
		"Base.HuntingKnife",
		"Base.LargeKnife",
        "Base.MasonsTrowel",
	},
}

-- random knife (better quality) in the left leg
AttachedWeaponDefinitions.knifeLeftLeg = {
	chance = 10,
	weaponLocation = {"Knife Left Leg"},
	bloodLocations = {"UpperLeg_L"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
		"Base.BreadKnife",
		"Base.KitchenKnife",
		"Base.SteakKnife",
	},
}

AttachedWeaponDefinitions.knifeLeftLeg_Special = {
	chance = 1,
	weaponLocation = {"Knife Left Leg"},
	bloodLocations = {"UpperLeg_L"},
	addHoles = false,
	daySurvived = 60,
	weapons = {
		"Base.CrudeKnife",
		"Base.FightingKnife",
		"Base.GlassShiv",
		"Base.KnifeShiv",
		"Base.LongCrudeKnife",
		"Base.LongStick_Broken",
        "Base.SharpBone_Long",
        "Base.Toothbrush_Shiv",
	},
}

-- random knife (low quality weapon) in the right leg
AttachedWeaponDefinitions.knifeLowQualityLeftLeg = {
	chance = 30,
	weaponLocation = {"Knife Right Leg"},
	bloodLocations = {"UpperRight_L"},
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.ButterKnife",
		"Base.CarvingFork2",
		"Base.Fork",
		"Base.HandFork",
		"Base.LetterOpener",
		"Base.KnifeFillet",
		"Base.KnifeParing",
		"Base.Screwdriver",
		"Base.Scissors",
		"Base.TinOpener_Old",
	},
}

-- hunting knife (better quality) in the right leg
AttachedWeaponDefinitions.huntingKnifeRightLeg = {
	chance = 5,
	weaponLocation = {"Knife Right Leg"},
	bloodLocations = {"UpperRight_L"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
        "Base.HandShovel",
		"Base.HuntingKnife",
		"Base.LargeKnife",
        "Base.MasonsTrowel",
	},
}

-- random knife (better quality) in the right leg
AttachedWeaponDefinitions.knifeRightLeg = {
	chance = 10,
	weaponLocation = {"Knife Right Leg"},
	bloodLocations = {"UpperRight_L"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
		"Base.BreadKnife",
		"Base.KitchenKnife",
		"Base.SteakKnife",
	},
}

AttachedWeaponDefinitions.knifeRightLeg_Special = {
	chance = 1,
	weaponLocation = {"Knife Right Leg"},
	bloodLocations = {"UpperRight_L"},
	addHoles = false,
	daySurvived = 60,
	weapons = {
		"Base.CrudeKnife",
		"Base.FightingKnife",
		"Base.GlassShiv",
		"Base.KnifeShiv",
		"Base.LongCrudeKnife",
		"Base.LongStick_Broken",
        "Base.SharpBone_Long",
        "Base.Toothbrush_Shiv",
	},
}

-- random knife (low quality weapon) in the shoulder
AttachedWeaponDefinitions.knifeLowQualityShoulder = {
	chance = 30,
	weaponLocation = {"Knife Shoulder"},
	bloodLocations = {"UpperArm_L", "Torso_Upper"},
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.ButterKnife",
		"Base.CarvingFork2",
		"Base.Fork",
		"Base.HandFork",
		"Base.LetterOpener",
		"Base.KnifeFillet",
		"Base.KnifeParing",
		"Base.Screwdriver",
		"Base.Scissors",
		"Base.TinOpener_Old",
	},
}

-- hunting knife (better quality) in the shoulder
AttachedWeaponDefinitions.huntingKnifeShoulder = {
	chance = 5,
	weaponLocation = {"Knife Shoulder"},
	bloodLocations = {"UpperArm_L", "Torso_Upper"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
        "Base.HandShovel",
		"Base.HuntingKnife",
		"Base.LargeKnife",
        "Base.MasonsTrowel",
	},
}


-- random knife (better quality) in the shoulder
AttachedWeaponDefinitions.knifeShoulder = {
	chance = 10,
	weaponLocation = {"Knife Shoulder"},
	bloodLocations = {"UpperArm_L", "Torso_Upper"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
		"Base.BreadKnife",
		"Base.KitchenKnife",
		"Base.SteakKnife",
	},
}

AttachedWeaponDefinitions.knifeShoulder_Special = {
	chance = 1,
	weaponLocation = {"Knife Shoulder"},
	bloodLocations = {"UpperArm_L", "Torso_Upper"},
	addHoles = false,
	daySurvived = 60,
	weapons = {
		"Base.CrudeKnife",
		"Base.FightingKnife",
		"Base.GlassShiv",
		"Base.KnifeShiv",
		"Base.LongCrudeKnife",
		"Base.LongStick_Broken",
        "Base.SharpBone_Long",
        "Base.Toothbrush_Shiv",
	},
}

-- Machete in shoulder
AttachedWeaponDefinitions.MacheteShoulder = {
	chance = 1,
	weaponLocation = {"Knife Shoulder"},
	bloodLocations = {"UpperArm_L", "Torso_Upper"},
	addHoles = true,
	daySurvived = 20,
	weapons = {
		"Base.Machete",
	},
}

AttachedWeaponDefinitions.MacheteShoulder_Special = {
	chance = 1,
	weaponLocation = {"Knife Shoulder"},
	bloodLocations = {"UpperArm_L", "Torso_Upper"},
	addHoles = true,
	daySurvived = 60,
	weapons = {
		"Base.Machete_Crude",
		"Base.Sword_Scrap",
		"Base.Sword_Scrap_Broken",
	},
}

-- random knife (low quality weapon) in the stomach
AttachedWeaponDefinitions.knifeLowQualityStomach = {
	chance = 30,
	weaponLocation = {"Knife Stomach"},
	bloodLocations = {"Torso_Lower"},
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.ButterKnife",
		"Base.CarvingFork2",
		"Base.Fork",
		"Base.HandFork",
		"Base.LetterOpener",
		"Base.KnifeFillet",
		"Base.KnifeParing",
		"Base.Screwdriver",
		"Base.Scissors",
		"Base.Stake",
		"Base.TinOpener_Old",
	},
}

-- hunting knife (better quality) in the stomach
AttachedWeaponDefinitions.huntingKnifeStomach = {
	chance = 5,
	weaponLocation = {"Knife Stomach"},
	bloodLocations = {"Torso_Lower", "Back"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
        "Base.HandShovel",
		"Base.HuntingKnife",
		"Base.LargeKnife",
        "Base.MasonsTrowel",
	},
}


-- random knife (better quality) in the stomach
AttachedWeaponDefinitions.knifeStomach = {
	chance = 10,
	weaponLocation = {"Knife Stomach"},
	bloodLocations = {"Torso_Lower", "Back"},
	addHoles = false,
	daySurvived = 10,
	weapons = {
		"Base.BreadKnife",
		"Base.KitchenKnife",
		"Base.SteakKnife",
	},
}

AttachedWeaponDefinitions.knifeStomach_Special = {
	chance = 1,
	weaponLocation = {"Knife Stomach"},
	bloodLocations = {"Torso_Lower", "Back"},
	addHoles = false,
	daySurvived = 60,
	weapons = {
		"Base.CrudeKnife",
		"Base.FightingKnife",
		"Base.GlassShiv",
		"Base.KnifeShiv",
		"Base.LongCrudeKnife",
		"Base.LongStick_Broken",
        "Base.SharpBone_Long",
        "Base.Toothbrush_Shiv",
	},
}

-- random weapon in stomach
AttachedWeaponDefinitions.weaponInStomach = {
	chance = 3,
	weaponLocation = {"Knife Stomach"},
	bloodLocations = {"Torso_Lower", "Back"},
	addHoles = true,
	daySurvived = 10,
	weapons = {
		"Base.BanjoNeck_Broken",
		"Base.BaseballBat_Broken",
		"Base.CarpentryChisel",
		"Base.ChairLeg",
		"Base.Crowbar",
		"Base.FieldHockeyStick_Broken",
		"Base.File",
		"Base.GardenToolHandle_Broken",
		"Base.GuitarAcousticNeck_Broken",
		"Base.GuitarElectricNeck_Broken",
		"Base.GuitarElectricBassNeck_Broken",
		"Base.Handle",
		"Base.LeadPipe",
		"Base.LongHandle_Broken",
		"Base.MasonsChisel",
		"Base.MetalBar",
		"Base.MetalPipe_Broken",
		"Base.MetalworkingChisel",
		"Base.Nightstick",
		"Base.PipeWrench",
		"Base.SteelBar",
		"Base.SteelBarHalf",
		"Base.SteelRodHalf",
		"Base.TableLeg_Broken",
		"Base.TireIron",
	},
}

AttachedWeaponDefinitions.weaponInStomach_Special = {
	chance = 1,
	weaponLocation = {"Knife Stomach"},
	bloodLocations = {"Torso_Lower", "Back"},
	addHoles = true,
	daySurvived = 60,
	weapons = {
		"Base.BoltCutters",
		"Base.Bone",
		"Base.Branch_Broken",
		"Base.LargeBone",
		"Base.TreeBranch2",
	},
}

-- removed as it didn't translate well, and also crowbars etc can now be impaled through the tummy

-- -- crowbar in the back
-- AttachedWeaponDefinitions.crowbarBack = {
-- 	chance = 3,
-- 	weaponLocation = {"Crowbar Back"},
-- 	bloodLocations = {"Back"},
-- 	addHoles = true,
-- 	daySurvived = 10,
-- 	weapons = {
-- 		"Base.Crowbar",
-- 		"Base.FireplacePoker",
-- 	},
-- }

-- random weapon on police zombies holster
AttachedWeaponDefinitions.handgunHolster = {
	id = "handgunHolster",
	chance = 50,
	outfit = { "Bandit", "Bandit_Early", "Bandit_Mid", "Bandit_Late", "BountyHunter", "PlonkiesGuy", "PrivateMilitia",  "Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
	weaponLocation =  {"Holster Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterSimple",
	weapons = {
		"Base.Pistol",
		"Base.Pistol2",
		"Base.Pistol3",
		"Base.Revolver",
		"Base.Revolver_Long",
		"Base.Revolver_Short",
	},
}
AttachedWeaponDefinitions.handgunHolsterShoulder = {
	id = "handgunHolster",
	chance = 50,
	outfit = { "Bandit", "Bandit_Early", "Bandit_Mid", "Bandit_Late", "BankRobber", "BankRobberSuit", "Biker", "BountyHunter", "Hunter", "PlonkiesGuy", "Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
	weaponLocation =  {"Holster Shoulder"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterShoulder",
	weapons = {
		"Base.Pistol",
		"Base.Pistol2",
		"Base.Pistol3",
		"Base.Revolver",
		"Base.Revolver_Long",
		"Base.Revolver_Short",
	},
}
AttachedWeaponDefinitions.handgunHolsterPolice = {
	id = "handgunHolsterPolice",
	chance = 50,
	outfit = {"Police", "PoliceState", "PoliceRiot", "PrisonGuard", },
	weaponLocation =  {"Holster Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterSimple_Black",
	weapons = {
		"Base.Pistol",
	},
}
AttachedWeaponDefinitions.handgunHolsterAnkle = {
	id = "handgunHolsterPolice",
	chance = 5,
	outfit = {"Agent", "Bandit", "Bandit_Early", "Bandit_Mid", "Bandit_Late", "BankRobberSuit", "BountyHunter", "Detective", "Judge_Matt_Hass", "Mob", "MobCasual", "Police", "PoliceState", "PoliceRiot", "Police_SWAT", "PrisonGuard", "Sheriff_Deputy", "Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
	weaponLocation =  {"Holster Ankle"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterAnkle",
	weapons = {
		"Base.Revolver_Short",
	},
}
AttachedWeaponDefinitions.handgunHolsterDetective = {
	id = "handgunHolsterDetective",
	chance = 50,
	outfit = {"Agent", "Detective", "Mob", "MobCasual", "Police_SWAT"},
	weaponLocation =  {"Holster Shoulder"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterShoulder",
	weapons = {
		"Base.Pistol",
		"Base.Pistol2",
		"Base.Revolver",
		"Base.Revolver_Long",
		"Base.Revolver_Short",
	},
}
AttachedWeaponDefinitions.handgunHolsterArmy = {
	id = "handgunHolsterPolice",
	chance = 50,
	outfit = {"ArmyCamoDesert", "ArmyCamoGreen", "ArmyInstructor",  "ArmyServiceUniform", },
	weaponLocation =  {"Holster Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterSimple_Green",
	weapons = {
		"Base.Pistol",
	},
}
AttachedWeaponDefinitions.handgunHolsterRanger = {
	id = "handgunHolsterRanger",
	chance = 50,
	outfit = { "Hunter", "Ranger"},
	weaponLocation =  {"Holster Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterSimple_Brown",
	weapons = {
		"Base.Revolver",
		"Base.Revolver_Long",
	},
}
AttachedWeaponDefinitions.handgunHolsterSheriff = {
	id = "handgunHolster",
	chance = 50,
	outfit = { "Sheriff_Deputy", },
	weaponLocation =  {"Holster Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterSimple_Brown",
	weapons = {
		"Base.Pistol",
		"Base.Pistol2",
		"Base.Revolver",
		"Base.Revolver_Long",
	},
}

AttachedWeaponDefinitions.handgunHolsterSWAT = {
	id = "handgunHolsterSWAT",
	chance = 50,
	outfit = {   "Police_SWAT", },
	weaponLocation =  {"Holster Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterSimple",
	weapons = {
		"Base.Pistol",
		"Base.Revolver_Long",
	},
}

AttachedWeaponDefinitions.handgunHolsterGhillie = {
	id = "handgunHolsterSWAT",
	chance = 50,
	outfit = {  "Police_SWAT", },
	weaponLocation =  {"Holster Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterSimple",
	weapons = {
		"Base.Pistol",
		"Base.Revolver_Long",
	},
}

-- shotgun on police's back
AttachedWeaponDefinitions.shotgunPolice = {
	id = "shotgunPolice",
	chance = 30,
	outfit = {"Police", "PoliceState", "PoliceRiot", "Police_SWAT", "PrivateMilitia", "Ranger", "Sheriff_Deputy", },
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.Shotgun",
	},
}

AttachedWeaponDefinitions.gunOnBackSWAT = {
	id = "gunOnBackSWAT",
	chance = 30,
	outfit = {"Police_SWAT", },
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.AssaultRifle",
		"Base.AssaultRifle2",
		"Base.HuntingRifle",
		"Base.Shotgun",
	},
}

-- assault rifle on back
AttachedWeaponDefinitions.assaultRifleOnBack = {
	id = "assaultRifleOnBack",
	chance = 20,
	outfit = {"PrivateMilitia"},
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.AssaultRifle",
		"Base.AssaultRifle2",
	},
}
-- assault rifle on back
AttachedWeaponDefinitions.assaultRifleArmyOnBack = {
	id = "assaultRifleArmyOnBack",
	chance = 50,
	outfit = {"ArmyCamoDesert", "ArmyCamoGreen"},
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.AssaultRifle",
	},
}
AttachedWeaponDefinitions.gunOnBackMisc = {
	id = "gunOnBackMisc",
	chance = 30,
	outfit = {"PlonkiesGuy",},
-- 	outfit = {"Bandit", "Bandit_Early", "Bandit_Mid", "Bandit_Late", "PlonkiesGuy",},
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.AssaultRifle",
		"Base.AssaultRifle2",
		"Base.DoubleBarrelShotgun",
		"Base.DoubleBarrelShotgunSawnoff",
		"Base.HuntingRifle",
		"Base.VarmintRifle",
		"Base.Shotgun",
		"Base.ShotgunSawnoff",
	},
}
AttachedWeaponDefinitions.gunOnBackHunter = {
	id = "gunOnBackHunter",
	chance = 30,
	outfit = {"Hunter"},
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.DoubleBarrelShotgun",
		"Base.HuntingRifle",
		"Base.VarmintRifle",
		"Base.Shotgun",
	},
}
AttachedWeaponDefinitions.gunOnBackBagSurvivalist = {
	id = "gunOnBackBagSurvivalist",
	chance = 30,
	outfit = {"Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
	weaponLocation =  {"Rifle On Back with Bag"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.AssaultRifle",
		"Base.AssaultRifle2",
		"Base.DoubleBarrelShotgun",
		"Base.DoubleBarrelShotgunSawnoff",
		"Base.Shotgun",
		"Base.ShotgunSawnoff",
	},
}

-- varmint/hunting rifle on back
AttachedWeaponDefinitions.huntingRifleOnBack = {
	id = "huntingRifleOnBack",
	chance = 30,
	outfit = {"PrivateMilitia"},
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.VarmintRifle",
		"Base.HuntingRifle",
	},
}

-- varmint/hunting rifle on back
AttachedWeaponDefinitions.rifleOnBackGhillie = {
	id = "huntingRifleOnBack",
	chance = 30,
	outfit = {"Ghillie",},
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.AssaultRifle2",
		"Base.HuntingRifle",
	},
}

AttachedWeaponDefinitions.gunOnBackCrime = {
	id = "gunOnBackCrime",
	chance = 30,
	outfit = {"BankRobber", "BankRobberSuit"},
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.AssaultRifle",
		"Base.ShotgunSawnoff",
		"Base.DoubleBarrelShotgunSawnoff",
	},
}

AttachedWeaponDefinitions.gunOnBackBountyHunter = {
	id = "gunOnBackCrime",
	chance = 30,
	outfit = {"BountyHunter"},
	weaponLocation =  {"Rifle On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.AssaultRifle",
		"Base.ShotgunSawnoff",
	},
}

-- random construction tools on construction worker
AttachedWeaponDefinitions.constructionWorker = {
	chance = 80,
	outfit = {"ConstructionWorker", "Foreman"},
	weaponLocation = {"Belt Left", "Belt Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.Hammer",
		"Base.ClubHammer",
		"Base.WoodenMallet",
		"Base.BallPeenHammer",
	},
}

-- screwdriver on construction worker
AttachedWeaponDefinitions.constructionWorkerScrewdriver = {
	chance = 80,
	outfit = {"ConstructionWorker", "Foreman"},
	weaponLocation = {"Belt Left Screwdriver", "Belt Right Screwdriver"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.Screwdriver",
	},
}

-- hand axe on lumberjack
AttachedWeaponDefinitions.lumberjack = {
	chance = 80,
	outfit = {"McCoys"},
	weaponLocation = {"Belt Left", "Belt Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.HandAxe",
	},
}

-- back melee weapons previously used 3 tables, but this would result in some bandits having multiple back weapons in a way that the player cannot.
-- now one pool is used for bandits and survivalists

-- various melee weapon attached in back
AttachedWeaponDefinitions.meleeInBack_Bandit = {
	id = "meleeInBack_Bandit",
-- 	chance = 50,
	chance = 60,
	outfit = {"Bandit"},
	weaponLocation = {"Big Weapon On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
-- 	    -- "everyday item" weapons
-- 	    -- repeated twice to weight towards normalcy
		"Base.Axe",
		"Base.BaseballBat",
		"Base.BaseballBat_Metal",
		"Base.Crowbar",
		"Base.FieldHockeyStick",
		"Base.IceHockeyStick",
		"Base.Plank",
		"Base.Plunger", -- deliberate easter egg
		"Base.Shovel",
		"Base.Shovel2",
		"Base.TireIron",

		"Base.DoubleBarrelShotgun",
		"Base.HuntingRifle",
		"Base.VarmintRifle",
		"Base.Shotgun",
	},
}
AttachedWeaponDefinitions.meleeInBack_Early = {
	id = "meleeInBack_Early",
-- 	chance = 50,
	chance = 60,
	outfit = {"Bandit_Early"},
	weaponLocation = {"Big Weapon On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
	    -- "everyday item" weapons
	    -- repeated twice to weight towards normalcy
		"Base.Axe",
		"Base.BaseballBat",
		"Base.BaseballBat_Metal",
		"Base.Crowbar",
		"Base.FireplacePoker",
		"Base.LeadPipe",
		"Base.LongHandle",
		"Base.MetalPipe",
		"Base.TireIron",
		"Base.TreeBranch2",
		"Base.WoodenStick2",

		-- more outre weapons
		"Base.BaseballBat_Nails",
		"Base.BanjoNeck_Broken",
		"Base.GuitarAcousticNeck_Broken",
		"Base.GuitarElectricNeck_Broken",
		"Base.GuitarElectricBassNeck_Broken",
		"Base.ChairLeg",
		"Base.Plank_Nails",
		"Base.SpearCrafted",
		"Base.SpearGlass",
		"Base.BaseballBat_Broken",
		"Base.Branch_Broken",
		"Base.LongHandle_Broken",

		"Base.DoubleBarrelShotgun",
		"Base.DoubleBarrelShotgunSawnoff",
		"Base.HuntingRifle",
		"Base.VarmintRifle",
		"Base.Shotgun",
		"Base.ShotgunSawnoff",
	},
}
AttachedWeaponDefinitions.meleeInBack_Mid = {
	id = "meleeInBack_Mid",
-- 	chance = 50,
	chance = 60,
	outfit = {"Bandit_Mid"},
	weaponLocation = {"Big Weapon On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
	    -- "everyday item" weapons
		"Base.Axe",
		"Base.Axe_Old",
		"Base.BaseballBat",
		"Base.BaseballBat_Metal",
		"Base.BoltCutters",
		"Base.Crowbar",
		"Base.FireplacePoker",
		"Base.IceAxe",
		"Base.IronBar",
		"Base.LargeBranch",
		"Base.LongHandle",
		"Base.Machete",
		"Base.MetalBar",
		"Base.PickAxe",
		"Base.SteelBar",
		"Base.TireIron",
		"Base.WoodAxe",

		-- more outre weapons
		"Base.AxeStone",
		"Base.BaseballBat_Nails",
		"Base.JawboneBovide",
		"Base.LongHandle_Nails",
		"Base.MetalPipe_Railspike",
		"Base.SpearCraftedFireHardened",
		"Base.SpearGlass",
		"Base.TableLeg",
		"Base.TreeBranch_Nails",
		"Base.BaseballBat_Broken_Nails",
		"Base.Handle_Nails",
		"Base.Branch_Broken_Nails",
		"Base.LongHandle_Broken_Nails",
		"Base.ShortBat_Nails",
		"Base.ShortBat_RakeHead",

		"Base.FieldHockeyStick_Broken",
		"Base.FieldHockeyStick_Broken_Nails",
		"Base.FieldHockeyStick_Nails",
		"Base.IceHockeyStick_BarbedWire",
		"Base.LargeBone",
		"Base.ChairLeg_Nails",
		"Base.Plank_Broken",
		"Base.Plank_Broken_Nails",

		"Base.AssaultRifle",
		"Base.AssaultRifle2",
		"Base.DoubleBarrelShotgun",
		"Base.DoubleBarrelShotgunSawnoff",
		"Base.HuntingRifle",
		"Base.VarmintRifle",
		"Base.Shotgun",
		"Base.ShotgunSawnoff",
	},
}
AttachedWeaponDefinitions.meleeInBack_Late = {
	id = "meleeInBack_Late",
-- 	chance = 50,
	chance = 60,
	outfit = {"ArmorTest_Gladiator", "Bandit_Late"},
	weaponLocation = {"Big Weapon On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
	    -- "everyday item" weapons
		"Base.Axe",
		"Base.Axe_Old",
		"Base.BaseballBat_Metal",
		"Base.BoltCutters",
		"Base.Crowbar",
		"Base.IceAxe",
		"Base.Machete",
		"Base.PickAxe",
		"Base.TireIron",
		"Base.WoodAxe",

		-- more outre weapons
		"Base.Axe_Sawblade",
		"Base.Axe_ScrapCleaver",
		"Base.BaseballBat_RailSpike",
		"Base.BaseballBat_RakeHead",
		"Base.BaseballBat_Sawblade",
		"Base.Cudgel_Nails",
		"Base.Cudgel_RailSpiked",
		"Base.Cudgel_Sawblade",
		"Base.JawboneBovide_Axe",
		"Base.JawboneBovide_Club",
		"Base.LongHandle_Railspike",
		"Base.LongHandle_RakeHead",
		"Base.LongHandle_Sawblade",
		"Base.MetalPipe_Railspike",
		"Base.Morningstar_Scrap",
		"Base.ShortBat_Sawblade",
		"Base.SpearCrude",
		"Base.SpearCrudeLong",
		"Base.StoneAxeLarge",
		"Base.StoneMaul",
		"Base.Sword_Scrap",
		"Base.ShortBat_RailSpike",
		"Base.ShortBat_RakeHead",
		"Base.SpikedShortBat",

        "Base.Axe_Sawblade_Hatchet",
        "Base.BaseballBat_Metal_Bolts",
		"Base.Cudgel_GardenForkHead",
		"Base.FieldHockeyStick_Broken",
		"Base.FieldHockeyStick_Broken_Nails",
		"Base.FieldHockeyStick_Nails",
		"Base.FieldHockeyStick_Sawblade",
		"Base.IceHockeyStick_BarbedWire",
		"Base.Morningstar_Scrap_Short",
		"Base.Shortsword_Scrap",
		"Base.BaseballBat_GardenForkHead",
		"Base.BoneClub_Spiked",
		"Base.Cudgel_Bone",
		"Base.LargeBoneClub",
		"Base.LargeBoneClub_Spiked",
		"Base.SpearBone",
		"Base.SpearBone_Long",
		"Base.TreeBranch_Bone",
		"Base.JawboneBovide_Morningstar",
		"Base.KettleMace_Metal",
		"Base.KettleMace_Wood",
		"Base.TableLeg_Broken_Nails",
		"Base.TableLeg_Chain",
		"Base.TableLeg_Nails",
		"Base.TableLeg_Sawblade",
		"Base.ChairLeg_Nails",
		"Base.Plank_Saw",
		"Base.EngineMaul",
		"Base.ScrapMaul",
		"Base.ScrapWeaponSpade",
		"Base.ScrapWeaponGardenFork",
		"Base.ScrapWeaponRakeHead",
		"Base.Cudgel_Brake",
		"Base.LongHandle_Brake",
		"Base.Plank_Brake",
		"Base.Plank_Broken",
		"Base.Plank_Broken_Nails",
		"Base.Plank_Sawblade",
		"Base.ScrapWeapon_Brake",
		"Base.BlockMaul",
        "Base.BaseballBat_Can",
        "Base.BaseballBat_Metal_Sawblade",
        "Base.BaseballBat_ScrapSheet",
		"Base.BowlingPin_Nails",
        "Base.Cudgel_ScrapSheet",

		"Base.AssaultRifle",
		"Base.AssaultRifle2",
		"Base.DoubleBarrelShotgun",
		"Base.DoubleBarrelShotgunSawnoff",
		"Base.Shotgun",
		"Base.ShotgunSawnoff",
	},
}
AttachedWeaponDefinitions.meleeInBackBag = {
	id = "meleeInBackBag",
-- 	chance = 50,
	chance = 60,
	outfit = {"Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
-- 	weaponLocation = {"Big Weapon On Back with Bag"},
	weaponLocation =  {"Rifle On Back with Bag"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
	    -- "everyday item" weapons
	    -- repeated twice to weight towards normalcy
		"Base.Axe",
		"Base.BaseballBat",
		"Base.BaseballBat_Metal",
		"Base.Crowbar",
		"Base.FireplacePoker",
		"Base.LeadPipe",
-- 		"Base.LongHandle",
		"Base.MetalPipe",
		"Base.TireIron",
-- 		"Base.TreeBranch2",
-- 		"Base.WoodenStick2",

		-- more outre weapons
		"Base.BaseballBat_Nails",
-- 		"Base.BanjoNeck_Broken",
-- 		"Base.GuitarAcousticNeck_Broken",
-- 		"Base.GuitarElectricNeck_Broken",
-- 		"Base.GuitarElectricBassNeck_Broken",
		"Base.ChairLeg",
		"Base.Plank_Nails",
		"Base.SpearCrafted",
		"Base.BaseballBat_Broken",
		"Base.FieldHockeyStick_Broken",
		"Base.Branch_Broken",
		"Base.LongHandle_Broken",

		"Base.DoubleBarrelShotgun",
		"Base.DoubleBarrelShotgunSawnoff",
		"Base.HuntingRifle",
		"Base.VarmintRifle",
		"Base.Shotgun",
		"Base.ShotgunSawnoff",

-- 	    -- "everyday item" weapons
-- 	    -- repeated twice to weight towards normalcy
-- 		"Base.Axe",
-- 		"Base.Axe_Old",
-- 		"Base.BaseballBat",
-- 		"Base.BaseballBat_Metal",
-- 		"Base.BoltCutters",
-- 		"Base.Crowbar",
-- 		"Base.FireplacePoker",
-- 		"Base.HockeyStick",
-- 		"Base.IceAxe",
-- 		"Base.IronBar",
-- 		"Base.IceHockeyStick",
-- 		"Base.LargeBranch",
-- 		"Base.LeadPipe",
-- 		"Base.LongHandle",
-- 		"Base.Machete",
-- 		"Base.MetalBar",
-- 		"Base.MetalPipe",
-- 		"Base.PickAxe",
-- 		"Base.Plank",
-- 		"Base.Shovel",
-- 		"Base.Shovel2",
-- 		"Base.Sledgehammer",
-- 		"Base.SteelBar",
-- 		"Base.TireIron",
-- 		"Base.TreeBranch2",
-- 		"Base.WoodAxe",
-- 		"Base.WoodenStick2",
--
-- 	    -- repeated twice to weight towards normalcy
-- 		"Base.Axe",
-- 		"Base.Axe_Old",
-- 		"Base.BaseballBat",
-- 		"Base.BaseballBat_Metal",
-- 		"Base.BoltCutters",
-- 		"Base.Crowbar",
-- 		"Base.FireplacePoker",
-- 		"Base.HockeyStick",
-- 		"Base.IceAxe",
-- 		"Base.IronBar",
-- 		"Base.IceHockeyStick",
-- 		"Base.LargeBranch",
-- 		"Base.LeadPipe",
-- 		"Base.LongHandle",
-- 		"Base.Machete",
-- 		"Base.MetalBar",
-- 		"Base.MetalPipe",
-- 		"Base.PickAxe",
-- 		"Base.Plank",
-- 		"Base.Shovel",
-- 		"Base.Shovel2",
-- 		"Base.Sledgehammer2",
-- 		"Base.SteelBar",
-- 		"Base.TireIron",
-- 		"Base.TreeBranch2",
-- 		"Base.WoodAxe",
-- 		"Base.WoodenStick2",
--
-- 		-- more outre weapons
-- 		"Base.Axe_Sawblade",
-- 		"Base.Axe_ScrapCleaver",
-- 		"Base.AxeStone",
-- 		"Base.BanjoNeck_Broken",
-- 		"Base.BaseballBat_RailSpike",
-- 		"Base.BaseballBat_RakeHead",
-- 		"Base.BaseballBat_Sawblade",
-- 		"Base.BaseballBat_Nails",
-- 		"Base.ChairLeg",
-- 		"Base.Cudgel_Nails",
-- 		"Base.Cudgel_RailSpiked",
-- 		"Base.Cudgel_Sawblade",
-- 		"Base.GuitarAcousticNeck_Broken",
-- 		"Base.GuitarElectricNeck_Broken",
-- 		"Base.GuitarElectricBassNeck_Broken",
-- 		"Base.JawboneBovide",
-- 		"Base.JawboneBovide_Axe",
-- 		"Base.JawboneBovide_Club",
-- 		"Base.LongHandle_Railspike",
-- 		"Base.LongHandle_RakeHead",
-- 		"Base.LongHandle_Sawblade",
-- 		"Base.LongHandle_Nails",
-- 		"Base.MetalPipe_Railspike",
-- 		"Base.Morningstar_Scrap",
-- 		"Base.Plank_Nails",
-- 		"Base.ShortBat_Sawblade",
-- 		"Base.SpearCrafted",
-- 		"Base.SpearCraftedFireHardened",
-- 		"Base.SpearCrude",
-- 		"Base.SpearCrudeLong",
-- 		"Base.StoneAxeLarge",
-- 		"Base.StoneMaul",
-- 		"Base.Sword_Scrap",
-- 		"Base.TableLeg",
-- 		"Base.TreeBranch_Nails",
-- 		"Base.TreeBranch_Railspike",
	},
}
AttachedWeaponDefinitions.meleeInBackBag_Mid = {
	id = "meleeInBackBag_Mid",
-- 	chance = 50,
	chance = 60,
	outfit = {"Survivalist_Mid", "Survivalist02_Mid", "Survivalist03_Mid", "Survivalist04_Mid", "Survivalist05_Mid"},
-- 	weaponLocation = {"Big Weapon On Back with Bag"},
	weaponLocation =  {"Rifle On Back with Bag"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
	    -- "everyday item" weapons
		"Base.Axe",
		"Base.Axe_Old",
		"Base.BaseballBat",
		"Base.BaseballBat_Metal",
		"Base.BoltCutters",
		"Base.Crowbar",
		"Base.FireplacePoker",
		"Base.IceAxe",
		"Base.IronBar",
-- 		"Base.LargeBranch",
-- 		"Base.LongHandle",
		"Base.Machete",
		"Base.MetalBar",
		"Base.PickAxe",
		"Base.SteelBar",
		"Base.TireIron",
		"Base.WoodAxe",

		-- more outre weapons
-- 		"Base.AxeStone",
		"Base.BaseballBat_Nails",
-- 		"Base.JawboneBovide",
-- 		"Base.LongHandle_Nails",
-- 		"Base.MetalPipe_Railspike",
		"Base.SpearCraftedFireHardened",
		"Base.SpearGlass",
		"Base.TableLeg",
-- 		"Base.TreeBranch_Nails",
-- 		"Base.BaseballBat_Broken_Nails",
-- 		"Base.Handle_Nails",
-- 		"Base.Branch_Broken_Nails",
-- 		"Base.LongHandle_Broken_Nails",
		"Base.ShortBat_Nails",
		"Base.ShortBat_RakeHead",

		"Base.FieldHockeyStick_Broken_Nails",
		"Base.FieldHockeyStick_Nails",
-- 		"Base.LargeBone",
		"Base.ChairLeg_Nails",
		"Base.Plank_Broken",
		"Base.Plank_Broken_Nails",

		"Base.AssaultRifle",
		"Base.AssaultRifle2",
		"Base.DoubleBarrelShotgun",
		"Base.DoubleBarrelShotgunSawnoff",
		"Base.HuntingRifle",
		"Base.VarmintRifle",
		"Base.Shotgun",
		"Base.ShotgunSawnoff",
	},
}
AttachedWeaponDefinitions.meleeInBackBag_Late = {
	id = "meleeInBackBag_Late",
-- 	chance = 50,
	chance = 60,
	outfit = {"Survivalist_Late", "Survivalist02_Late", "Survivalist03_Late", "Survivalist04_Late", "Survivalist05_Late"},
-- 	weaponLocation = {"Big Weapon On Back with Bag"},
	weaponLocation =  {"Rifle On Back with Bag"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
	    -- "everyday item" weapons
		"Base.Axe",
		"Base.Axe_Old",
		"Base.BaseballBat_Metal",
		"Base.BoltCutters",
		"Base.Crowbar",
		"Base.IceAxe",
		"Base.Machete",
		"Base.PickAxe",
		"Base.TireIron",
		"Base.WoodAxe",

		-- more outre weapons
-- 		"Base.Axe_Sawblade",
-- 		"Base.Axe_ScrapCleaver",
		"Base.BaseballBat_RailSpike",
		"Base.BaseballBat_RakeHead",
-- 		"Base.BaseballBat_Sawblade",
-- 		"Base.Cudgel_Nails",
-- 		"Base.Cudgel_RailSpiked",
-- 		"Base.Cudgel_Sawblade",
-- 		"Base.JawboneBovide_Axe",
-- 		"Base.JawboneBovide_Club",
		"Base.LongHandle_Railspike",
		"Base.LongHandle_RakeHead",
-- 		"Base.LongHandle_Sawblade",
-- 		"Base.MetalPipe_Railspike",
-- 		"Base.Morningstar_Scrap",
-- 		"Base.ShortBat_Sawblade",
		"Base.SpearCrude",
		"Base.SpearCrudeLong",
-- 		"Base.StoneAxeLarge",
-- 		"Base.StoneMaul",
-- 		"Base.Sword_Scrap",
		"Base.ShortBat_RailSpike",
		"Base.ShortBat_RakeHead",
		"Base.SpikedShortBat",

        "Base.BaseballBat_Metal_Bolts",
		"Base.FieldHockeyStick_Broken",
		"Base.FieldHockeyStick_Broken_Nails",
		"Base.FieldHockeyStick_Nails",
-- 		"Base.BaseballBat_GardenForkHead",
-- 		"Base.LargeBoneClub",
-- 		"Base.SpearBone",
-- 		"Base.SpearBone_Long",
		"Base.TableLeg_Broken_Nails",
-- 		"Base.TableLeg_Chain",
		"Base.TableLeg_Nails",
		"Base.ChairLeg_Nails",
-- 		"Base.Plank_Saw",
-- 		"Base.EngineMaul",
-- 		"Base.ScrapMaul",
-- 		"Base.ScrapWeaponSpade",
-- 		"Base.ScrapWeaponGardenFork",
-- 		"Base.ScrapWeaponRakeHead",
-- 		"Base.LongHandle_Brake",
-- 		"Base.Plank_Brake",
-- 		"Base.Plank_Broken",
-- 		"Base.Plank_Broken_Nails",
-- 		"Base.Plank_Sawblade",
-- 		"Base.ScrapWeapon_Brake",
-- 		"Base.BlockMaul",
        "Base.BaseballBat_Can",
        "Base.BaseballBat_Metal_Sawblade",
        "Base.BaseballBat_ScrapSheet",
-- 		"Base.BowlingPin_Nails",
--         "Base.Cudgel_ScrapSheet",

		"Base.AssaultRifle",
		"Base.AssaultRifle2",
		"Base.DoubleBarrelShotgun",
		"Base.DoubleBarrelShotgunSawnoff",
		"Base.Shotgun",
		"Base.ShotgunSawnoff",
	},
}

-- -- more melee in back!
-- AttachedWeaponDefinitions.melee2InBack = {
-- 	id = "melee2InBack",
-- 	chance = 60,
-- 	outfit = {"Bandit"},
-- 	weaponLocation = {"Big Weapon On Back"},
-- 	bloodLocations = nil,
-- 	addHoles = false,
-- 	daySurvived = 0,
-- 	weapons = {
-- 		"Base.AxeStone",
-- 		"Base.LeadPipe",
-- 		"Base.MetalBar",
-- 		"Base.MetalPipe",
-- -- 		"Base.HockeyStick",
-- -- 		"Base.SpearCrafted",
-- 		-- new weapons
-- 		"Base.BoltCutters",
-- 		"Base.LongHandle",
-- 		"Base.LongHandle_Nails",
-- 		"Base.SteelBar",
-- 		"Base.StoneAxeLarge",
-- 		"Base.StoneMaul",
-- 	},
-- }
-- AttachedWeaponDefinitions.melee2InBackBag = {
-- 	id = "melee2InBackBag",
-- 	chance = 60,
-- 	outfit = {"Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
-- 	weaponLocation = {"Big Weapon On Back with Bag"},
-- 	bloodLocations = nil,
-- 	addHoles = false,
-- 	daySurvived = 0,
-- 	weapons = {
-- 		"Base.AxeStone",
-- 		"Base.LeadPipe",
-- 		"Base.MetalBar",
-- 		"Base.MetalPipe",
-- -- 		"Base.HockeyStick",
-- -- 		"Base.SpearCrafted",
-- 		-- new weapons
-- 		"Base.BoltCutters",
-- 		"Base.LongHandle",
-- 		"Base.LongHandle_Nails",
-- 		"Base.SteelBar",
-- 		"Base.StoneAxeLarge",
-- 		"Base.StoneMaul",
-- 	},
-- }


-- -- hammer/axe in belt left (so we keep knives for belt right if we got multiple items)
-- AttachedWeaponDefinitions.hammerBelt = {
-- 	id = "hammerBelt",
-- 	chance = 80,
-- 	outfit = {"Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
-- 	weaponLocation = {"Belt Left"},
-- 	bloodLocations = nil,
-- 	addHoles = false,
-- 	daySurvived = 0,
-- 	ensureItem = "Base.Belt2",
-- 	weapons = {
-- 		"Base.BallPeenHammer",
-- 		"Base.ClubHammer",
-- 		"Base.EntrenchingTool",
-- 		"Base.Hammer",
-- 		"Base.HammerStone",
-- 		"Base.HandAxe",
-- 		"Base.HandAxe_Old",
-- 		"Base.LargeHook",
-- 		"Base.MeatCleaver",
-- 		"Base.PipeWrench",
-- 		"Base.Ratchet",
-- 		"Base.MeatCleaver_Scrap",
-- 		"Base.WoodenMallet",
-- 		"Base.Wrench",
-- 	},
-- }

AttachedWeaponDefinitions.hammerBelt_Bandit = {
	id = "hammerBelt_Bandit",
	chance = 80,
	outfit = {"Bandit", },
	weaponLocation = {"Belt Left"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.BallPeenHammer",
		"Base.Hammer",
		"Base.PipeWrench",
		"Base.Ratchet",
		"Base.WoodenMallet",
		"Base.Wrench",
	},
}

AttachedWeaponDefinitions.hammerBelt_Early = {
	id = "hammerBelt_Early",
	chance = 80,
	outfit = {"Bandit_Early", "Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
	weaponLocation = {"Belt Left"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.BallPeenHammer",
		"Base.ClubHammer",
		"Base.GardenToolHandle_Broken",
		"Base.Hammer",
		"Base.HandAxe",
		"Base.MeatCleaver",
		"Base.PipeWrench",
		"Base.Ratchet",
		"Base.Wrench",
	},
}

AttachedWeaponDefinitions.hammerBelt_Mid = {
	id = "hammerBelt_Mid",
	chance = 80,
	outfit = {"Bandit_Mid", "Survivalist_Mid", "Survivalist02_Mid", "Survivalist03_Mid", "Survivalist04_Mid", "Survivalist05_Mid"},
	weaponLocation = {"Belt Left"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.BallPeenHammer",
		"Base.ClubHammer",
		"Base.EntrenchingTool",
		"Base.GardenToolHandle_Broken",
		"Base.Hammer",
		"Base.HammerStone",
		"Base.HandAxe",
		"Base.HandAxe_Old",
		"Base.LargeHook",
		"Base.MeatCleaver",
		"Base.PipeWrench",
		"Base.Ratchet",
		"Base.Wrench",
		"Base.Bone",
	},
}

AttachedWeaponDefinitions.hammerBelt_Late = {
	id = "hammerBelt_Late",
	chance = 80,
	outfit = {"ArmorTest_Gladiator", "Bandit_Late", "Survivalist_Late", "Survivalist02_Late", "Survivalist03_Late", "Survivalist04_Late", "Survivalist05_Late"},
	weaponLocation = {"Belt Left"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.BallPeenHammer",
		"Base.ClubHammer",
		"Base.EntrenchingTool",
		"Base.GardenToolHandle_Broken",
		"Base.Hammer",
		"Base.HandAxe",
		"Base.HandAxe_Old",
		"Base.LargeHook",
		"Base.MeatCleaver",
		"Base.PipeWrench",
		"Base.Ratchet",
		"Base.MeatCleaver_Scrap",
		"Base.Wrench",
		"Base.BoneClub",
		"Base.Hatchet_Bone",
		"Base.BlockMace",
	},
}

-- knives in belt right
-- AttachedWeaponDefinitions.knivesBelt = {
-- 	id = "knivesBelt",
-- 	chance = 80,
-- 	outfit = {"Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
-- 	weaponLocation = {"Belt Right Upside"},
-- 	bloodLocations = nil,
-- 	addHoles = false,
-- 	daySurvived = 0,
-- 	ensureItem = "Base.Belt2",
-- 	weapons = {
--         -- normal/everday weapons first
-- 	    -- repeated twice to weight towards normalacy
-- 		"Base.Handle",
-- 		"Base.HuntingKnife",
-- 		"Base.KitchenKnife",
-- 		"Base.KnifeButterfly",
-- 		"Base.KnifePocket",
-- 		"Base.LargeKnife",
-- 		"Base.Machete",
-- 		"Base.Nightstick",
-- 		"Base.ShortBat",
-- 		"Base.SmallKnife",
-- 		"Base.SteelBarHalf",
-- 		"Base.SteelRodHalf",
-- 		"Base.SwitchKnife",
--
-- 	    -- repeated twice to weight towards normalacy
-- 		"Base.Handle",
-- 		"Base.HuntingKnife",
-- 		"Base.KitchenKnife",
-- 		"Base.KnifeButterfly",
-- 		"Base.KnifePocket",
-- 		"Base.LargeKnife",
-- 		"Base.Machete",
-- 		"Base.Nightstick",
-- 		"Base.ShortBat",
-- 		"Base.SmallKnife",
-- 		"Base.SteelBarHalf",
-- 		"Base.SteelRodHalf",
-- 		"Base.SwitchKnife",
--
-- 		-- more outre weapons
-- 		"Base.BaseballBat_Broken",
-- 		"Base.BaseballBat_Broken_Nails",
-- 		"Base.CrudeKnife",
-- 		"Base.GardenToolHandle_Broken",
-- 		"Base.GlassShiv",
-- 		"Base.Handle_Nails",
-- 		"Base.KnifeShiv",
-- 		"Base.Branch_Broken",
-- 		"Base.Branch_Broken_Nails",
-- 		"Base.LongCrudeKnife",
-- 		"Base.LongHandle_Broken",
-- 		"Base.LongHandle_Broken_Nails",
-- 		"Base.Machete_Crude",
-- 		"Base.ShortBat_Nails",
-- 		"Base.ShortBat_RailSpike",
-- 		"Base.ShortBat_RakeHead",
-- 		"Base.SpikedShortBat",
-- 	},
-- }
AttachedWeaponDefinitions.knivesBelt_Bandit = {
	id = "knivesBelt_Bandit",
	chance = 80,
	outfit = {"Bandit"},
	weaponLocation = {"Belt Right Upside"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
        -- normal/everday weapons first
	    -- repeated twice to weight towards normalacy
		"Base.GlassShiv",
		"Base.KnifeShiv",
		"Base.KitchenKnife",
		"Base.KnifeButterfly",
		"Base.KnifePocket",
		"Base.SteakKnife",
		"Base.SwitchKnife",
        "Base.Toothbrush_Shiv",
	},
}

AttachedWeaponDefinitions.knivesBelt_Early = {
	id = "knivesBelt_Early",
	chance = 80,
	outfit = {"Bandit_Early", "Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
	weaponLocation = {"Belt Right Upside"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
        -- normal/everday weapons first
		"Base.HuntingKnife",
		"Base.KnifeButterfly",
		"Base.KnifePocket",
		"Base.Nightstick",
		"Base.ShortBat",
		"Base.SwitchKnife",
		"Base.GlassShiv",
		"Base.KnifeShiv",
        "Base.Toothbrush_Shiv",
		"Base.FightingKnife",

-- 		-- more outre weapons
-- 		"Base.BaseballBat_Broken",
-- 		"Base.Branch_Broken",
-- 		"Base.LongHandle_Broken",
	},
}

AttachedWeaponDefinitions.knivesBelt_Mid = {
	id = "knivesBelt_Mid",
	chance = 80,
	outfit = {"Bandit_Mid", "Survivalist_Mid", "Survivalist02_Mid", "Survivalist03_Mid", "Survivalist04_Mid", "Survivalist05_Mid"},
	weaponLocation = {"Belt Right Upside"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
        -- normal/everday weapons first
		"Base.HandScythe",
		"Base.LargeKnife",
		"Base.HuntingKnife",
		"Base.KnifeButterfly",
		"Base.KnifePocket",
		"Base.LargeKnife",
		"Base.Machete",
		"Base.Nightstick",
		"Base.ShortBat",
		"Base.SmallKnife",
		"Base.SteelBarHalf",
		"Base.SteelRodHalf",
		"Base.SwitchKnife",
		"Base.GlassShiv",
		"Base.KnifeShiv",
        "Base.Toothbrush_Shiv",
		"Base.FightingKnife",

		-- more outre weapons
-- 		"Base.BaseballBat_Broken_Nails",
		"Base.CrudeKnife",
-- 		"Base.Handle_Nails",
-- 		"Base.Branch_Broken_Nails",
-- 		"Base.LongHandle_Broken_Nails",
-- 		"Base.ShortBat_Nails",
-- 		"Base.ShortBat_RakeHead",

	},
}

AttachedWeaponDefinitions.knivesBelt_Late = {
	id = "knivesBelt_Late",
	chance = 80,
	outfit = {"ArmorTest_Gladiator", "Bandit_Late", "Survivalist_Late", "Survivalist02_Late", "Survivalist03_Late", "Survivalist04_Late", "Survivalist05_Late"},
	weaponLocation = {"Belt Right Upside"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
        -- normal/everday weapons first
	    -- repeated twice to weight towards normalacy
		"Base.HuntingKnife",
		"Base.LargeKnife",
		"Base.Machete",
		"Base.Nightstick",
		"Base.ShortBat",
		"Base.SmallKnife",
		"Base.SteelBarHalf",
		"Base.SteelRodHalf",
		"Base.GlassShiv",
		"Base.KnifeShiv",
        "Base.Toothbrush_Shiv",
		"Base.FightingKnife",

		-- more outre weapons
		"Base.CrudeKnife",
		"Base.CrudeShortSword",
		"Base.LargeKnife_Scrap",
		"Base.LongCrudeKnife",
		"Base.Machete_Crude",
		"Base.SharpBone_Long",
		"Base.ShortSword_Scrap",
-- 		"Base.ShortBat_RailSpike",
-- 		"Base.ShortBat_RakeHead",
-- 		"Base.SpikedShortBat",
	},
}

-- knives in belt right
AttachedWeaponDefinitions.knivesBeltHunter = {
	id = "knivesBeltHunter",
	chance = 80,
	outfit = {"Hunter", "PrivateMilitia"},
	weaponLocation = {"Belt Right Upside"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.HuntingKnife",
		"Base.KnifePocket",
		"Base.LargeKnife",
		"Base.SmallKnife",
	},
}

-- knives in belt right
AttachedWeaponDefinitions.knivesBeltFisherman = {
	id = "knivesBeltFisherman",
	chance = 60,
	outfit = {"Fisherman"},
	weaponLocation = {"Belt Right Upside"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.KnifeFillet",
		"Base.KnifePocket",
		"Base.LargeKnife",
		"Base.SmallKnife",
	},
}

-- -- crowbar or machete in back
-- AttachedWeaponDefinitions.bladeInBack = {
-- 	id = "bladeInBack",
-- 	chance = 20,
-- 	outfit = {"Bandit"},
-- 	weaponLocation = {"Blade On Back"},
-- 	bloodLocations = nil,
-- 	addHoles = false,
-- 	daySurvived = 0,
-- 	weapons = {
-- 		"Base.Crowbar",
-- 		"Base.Machete",
-- 		-- new weapons
-- 		"Base.FireplacePoker",
-- 		"Base.IceAxe",
-- 		"Base.TireIron",
-- 	},
-- }
-- AttachedWeaponDefinitions.bladeInBackBag = {
-- 	id = "bladeInBackBag",
-- 	chance = 20,
-- 	outfit = {"Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
-- 	weaponLocation = {"Big Blade On Back with Bag"},
-- 	bloodLocations = nil,
-- 	addHoles = false,
-- 	daySurvived = 0,
-- 	weapons = {
-- 		"Base.Crowbar",
-- 		"Base.Machete",
-- 		-- new weapons
-- 		"Base.FireplacePoker",
-- 		"Base.IceAxe",
-- 		"Base.TireIron",
-- 	},
-- }

-- machete in back
AttachedWeaponDefinitions.macheteInBack = {
	id = "macheteInBack",
	chance = 20,
	outfit = {"HockeyPsycho"},
	weaponLocation = {"Blade On Back"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.Machete",
	},
}


-- nightstick in belt
AttachedWeaponDefinitions.nightstick = {
	id = "nightstick",
	chance = 30,
	outfit = {"BountyHunter", "Police", "PoliceState", "PoliceRiot", "Police_SWAT", "PrisonGuard", "PrivateMilitia", "Sheriff_Deputy", },
	weaponLocation = {"Nightstick Left"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.Nightstick",
	},
}

-- radio on belt
AttachedWeaponDefinitions.policeRadio = {
	id = "policeRadio",
	chance = 30,
	outfit = {"Agent", "AirportSecurityTarmac", "AmbulanceDriver", "BankRobberSuit", "BountyHunter", "Detective", "FiremanFullSuit", "Police", "PoliceState", "PoliceRiot", "Police_SWAT", "PrisonGuard", "Sheriff_Deputy",},
	weaponLocation = {"Walkie Belt Left"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.WalkieTalkie4",
	},
}
AttachedWeaponDefinitions.civilianRadio = {
	id = "civilianRadio",
	chance = 80,
	outfit = {"AirportWorkerTarmac",},
	weaponLocation = {"Walkie Belt Left"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.WalkieTalkie3",
	},
}

-- canteen on belt
AttachedWeaponDefinitions.canteen = {
	id = "canteen",
	chance = 30,
	outfit = {"Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
	weaponLocation = {"Walkie Belt Left", "Walkie Belt Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.CanteenMilitary",
		"Base.CanteenMilitaryFull",
	},
}
AttachedWeaponDefinitions.armyBelt = {
	id = "armyBelt",
	chance = 30,
	outfit = {"ArmyCamoDesert", "ArmyCamoGreen", "Ghillie", "PrivateMilitia" },
	weaponLocation = {"Walkie Belt Left", "Walkie Belt Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.CanteenMilitary",
		"Base.CanteenMilitaryFull",
		"Base.WalkieTalkie5",
	},
}
-- tents and sleeping bags
AttachedWeaponDefinitions.survivalistBedroll = {
	id = "survivalistBedroll",
	chance = 10,
	outfit = {"Bandit", "Bandit_Early", "Bandit_Mid", "Bandit_Late", "PrivateMilitia", "Survivalist", "Survivalist02", "Survivalist03", "Survivalist04", "Survivalist05"},
	weaponLocation = {"Bedroll Bottom ALICE"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Bag_SurvivorBag",
	weapons = {
		"Base.TentBlue_Packed",
		"Base.TentBrown_Packed",
		"Base.TentGreen_Packed",
		"Base.TentYellow_Packed",
		"Base.SleepingBag_Camo_Packed",
		"Base.SleepingBag_BluePlaid_Packed",
		"Base.SleepingBag_Green_Packed",
		"Base.SleepingBag_GreenPlaid_Packed",
		"Base.SleepingBag_RedPlaid_Packed",
		"Base.SleepingBag_HighQuality_Brown_Packed",
		"Base.SleepingBag_Spiffo_Packed",
	},
}
AttachedWeaponDefinitions.armyDesertBedroll = {
	id = "armyDesertBedroll",
	chance = 50,
	outfit = {"ArmyCamoDesert"},
	weaponLocation = {"Bedroll Bottom ALICE"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Bag_ALICEpack",
	weapons = {
		"Base.TentGreen_Packed",
		"Base.SleepingBag_Camo_Packed",
	},
}
AttachedWeaponDefinitions.armyGreenBedroll = {
	id = "armyGreenBedroll",
	chance = 50,
	outfit = {"ArmyCamoGreen", "Ghillie"},
	weaponLocation = {"Bedroll Bottom ALICE"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Bag_ALICEpack_Army",
	weapons = {
		"Base.TentGreen_Packed",
		"Base.SleepingBag_Camo_Packed",
	},
}
AttachedWeaponDefinitions.backpackerBedroll = {
	id = "backpackerBedroll",
	chance = 50,
	outfit = {"Backpacker", "Bandit", "Bandit_Early", "Bandit_Mid", "Bandit_Late", },
	weaponLocation = {"Bedroll Bottom"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Bag_HikingBag_Travel",
	weapons = {
		"Base.SleepingBag_Cheap_Blue_Packed",
		"Base.SleepingBag_Cheap_Green_Packed",
		"Base.SleepingBag_Cheap_Green2_Packed",
	},
}
AttachedWeaponDefinitions.backpackerBedrollBig = {
	id = "backpackerBedrollBig",
	chance = 50,
	outfit = {"Backpacker", "Bandit", "Bandit_Early", "Bandit_Mid", "Bandit_Late", },
	weaponLocation = {"Bedroll Bottom Big"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Bag_BigHikingBag_Travel",
	weapons = {
		"Base.SleepingBag_Cheap_Blue_Packed",
		"Base.SleepingBag_Cheap_Green_Packed",
		"Base.SleepingBag_Cheap_Green2_Packed",
	},
}
AttachedWeaponDefinitions.hobboBedroll = {
	id = "hobboBedroll",
	chance = 50,
	outfit = {"Hobbo"},
	weaponLocation = {"Bedroll Bottom"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Bag_NormalHikingBag",
	weapons = {
		"Base.SleepingBag_Cheap_Blue_Packed",
		"Base.SleepingBag_Cheap_Green_Packed",
		"Base.SleepingBag_Cheap_Green2_Packed",
		"Base.TentBlue_Packed",
		"Base.TentBrown_Packed",
		"Base.TentGreen_Packed",
		"Base.TentYellow_Packed",
	},
}
AttachedWeaponDefinitions.guitarGuy = {
	id = "guitarGuy",
	chance = 100,
	outfit = {"CostumeWildWestClown", "GuitarGuy"},
	weaponLocation = {"Guitar Acoustic"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.GuitarAcoustic",
	},
}
AttachedWeaponDefinitions.banjo = {
	id = "banjo",
	chance = 100,
	outfit = {"CostumeWildWestClown"},
	weaponLocation = {"Guitar"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.Banjo",
	},
}

AttachedWeaponDefinitions.dracula = {
	chance = 100,
	outfit = {"CostumeVampire"},
	weaponLocation = {"Knife Stomach"},
	bloodLocations = {"Torso_Lower"},
	addHoles = false,
	daySurvived = 0,
	weapons = {
		"Base.Stake",
	},
}

-- Woodcut guy's hammer
AttachedWeaponDefinitions.woodcut = {
	chance = 100,
	outfit = {"Woodcut"},
	weaponLocation = {"Belt Left", "Belt Right"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.Hammer",
	},
}

-- Dean's survival knife
AttachedWeaponDefinitions.dean = {
	id = "dean",
	chance = 100,
	outfit = {"Dean"},
	weaponLocation = {"Belt Right Upside", "Belt Left Upside"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.Belt2",
	weapons = {
		"Base.HuntingKnife",
	},
}

-- Judge Matt Hass's .44 Magnum Revolver in a Shoulder Holster
AttachedWeaponDefinitions.handgunHolsterShoulder_Hass = {
	id = "handgunHolster_Hass",
	chance = 50,
	outfit = { "Judge_Matt_Hass", },
	weaponLocation =  {"Holster Shoulder"},
	bloodLocations = nil,
	addHoles = false,
	daySurvived = 0,
	ensureItem = "Base.HolsterShoulder",
	weapons = {
		"Base.Revolver_Long",
	},
}

-- Define some custom weapons attached on some specific outfit, so for example police have way more chance to have guns in holster and not simply a spear in stomach or something
AttachedWeaponDefinitions.attachedWeaponCustomOutfit = {};

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.HockeyPsycho = {
	chance = 100;
	weapons = {
		AttachedWeaponDefinitions.macheteInBack,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.PrivateMilitia = {
	chance = 50;
	maxitem = 3;
	weapons = {
		AttachedWeaponDefinitions.survivalistBedroll,
		AttachedWeaponDefinitions.shotgunPolice,
		AttachedWeaponDefinitions.assaultRifleOnBack,
		AttachedWeaponDefinitions.huntingRifleOnBack,
		AttachedWeaponDefinitions.handgunHolster,
		AttachedWeaponDefinitions.knivesBeltHunter,
		AttachedWeaponDefinitions.nightstick,
		AttachedWeaponDefinitions.armyBelt,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Police = {
	chance = 40; -- reduced as Police zombies are quite commonplace
-- 	chance = 50;
	maxitem = 2;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterPolice,
-- 		AttachedWeaponDefinitions.shotgunPolice, -- moved to the bottom to make the shotguns less common
		AttachedWeaponDefinitions.nightstick,
		AttachedWeaponDefinitions.policeRadio,
		AttachedWeaponDefinitions.shotgunPolice,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Detective = {
	chance = 50;
	maxitem = 3;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterDetective,
		AttachedWeaponDefinitions.policeRadio,
		AttachedWeaponDefinitions.handgunHolsterAnkle,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Agent = {
	chance = 80;
	maxitem = 3;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterDetective,
		AttachedWeaponDefinitions.policeRadio,
		AttachedWeaponDefinitions.handgunHolsterAnkle,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Judge_Matt_Hass = {
	chance = 100;
	maxitem = 2;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterAnkle,
		AttachedWeaponDefinitions.handgunHolsterShoulder_Hass,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.PoliceState = {
	chance = 50;
	maxitem = 2;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterPolice,
		AttachedWeaponDefinitions.nightstick,
		AttachedWeaponDefinitions.policeRadio,
		AttachedWeaponDefinitions.shotgunPolice,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.PoliceRiot = {
	chance = 60;
	maxitem = 3;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterPolice,
		AttachedWeaponDefinitions.nightstick,
		AttachedWeaponDefinitions.shotgunPolice,
		AttachedWeaponDefinitions.policeRadio,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Police_SWAT = {
	chance = 60;
	maxitem = 3;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterSWAT,
		AttachedWeaponDefinitions.gunOnBackSWAT,
		AttachedWeaponDefinitions.nightstick,
		AttachedWeaponDefinitions.policeRadio,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Sheriff_Deputy = {
	chance = 50;
	maxitem = 2;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterSheriff,
		AttachedWeaponDefinitions.shotgunPolice,
		AttachedWeaponDefinitions.nightstick,
		AttachedWeaponDefinitions.policeRadio,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Backpacker = {
	chance = 50;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.backpackerBedroll,
		AttachedWeaponDefinitions.backpackerBedrollBig,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.BankRobber = {
	chance = 60;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterShoulder,
		AttachedWeaponDefinitions.gunOnBackCrime,
	},
}
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.BankRobberSuit = {
	chance = 80;
	maxitem = 2;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterShoulder,
		AttachedWeaponDefinitions.gunOnBackCrime,
		AttachedWeaponDefinitions.policeRadio,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.BountyHunter = {
	chance = 70;
	maxitem = 2;
	weapons = {
		AttachedWeaponDefinitions.handgunHolster,
		AttachedWeaponDefinitions.policeRadio,
		AttachedWeaponDefinitions.nightstick,
		AttachedWeaponDefinitions.handgunHolsterShoulder,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Backpacker = {
	chance = 50;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.backpackerBedroll,
		AttachedWeaponDefinitions.backpackerBedrollBig,
		AttachedWeaponDefinitions.guitarGuy,
	},
}


AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Mob = {
	chance = 80;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterDetective,
	},
}
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.MobCasual = {
	chance = 80;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.handgunHolsterDetective,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.GuitarGuy = {
	chance = 100;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.guitarGuy,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Woodcut = {
	chance = 100;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.woodcut,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Dean = {
	chance = 100;
	maxitem = 1;
	weapons = {
		AttachedWeaponDefinitions.dean,
	},
}

-- consolitdated the back weapons to one table so have less paradoxes
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Bandit = {
	chance = 50;
	maxitem = 2;
	weapons = {
		AttachedWeaponDefinitions.meleeInBack_Bandit,
		AttachedWeaponDefinitions.hammerBelt_Bandit,
		AttachedWeaponDefinitions.knivesBelt_Bandit,
-- 		AttachedWeaponDefinitions.handgunHolster,
-- 		AttachedWeaponDefinitions.bladeInBack,
-- 		AttachedWeaponDefinitions.gunOnBackBandit,
-- 		AttachedWeaponDefinitions.survivalistBedroll,
-- 		AttachedWeaponDefinitions.handgunHolsterShoulder,
-- 		AttachedWeaponDefinitions.melee2InBack,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Bandit_Early = {
	chance = 60;
	maxitem = 3;
	weapons = {
		AttachedWeaponDefinitions.meleeInBack_Early,
		AttachedWeaponDefinitions.hammerBelt_Early,
		AttachedWeaponDefinitions.knivesBelt_Early,
		AttachedWeaponDefinitions.handgunHolster,
-- 		AttachedWeaponDefinitions.gunOnBackBandit,
-- 		AttachedWeaponDefinitions.backpackerBedroll,
-- 		AttachedWeaponDefinitions.survivalistBedroll,
-- 		AttachedWeaponDefinitions.handgunHolsterShoulder,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Bandit_Mid = {
	chance = 70;
	maxitem = 4;
	weapons = {
		AttachedWeaponDefinitions.meleeInBack_Mid,
		AttachedWeaponDefinitions.handgunHolster,
		AttachedWeaponDefinitions.hammerBelt_Mid,
		AttachedWeaponDefinitions.knivesBelt_Mid,
-- 		AttachedWeaponDefinitions.gunOnBackBandit,
-- 		AttachedWeaponDefinitions.backpackerBedrollBig,
		AttachedWeaponDefinitions.handgunHolsterShoulder,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Bandit_Late = {
	chance = 80;
	maxitem = 5;
	weapons = {
-- 		AttachedWeaponDefinitions.gunOnBackBandit,
		AttachedWeaponDefinitions.handgunHolster,
		AttachedWeaponDefinitions.hammerBelt_Late,
		AttachedWeaponDefinitions.knivesBelt_Late,
		AttachedWeaponDefinitions.meleeInBack_Late,
		AttachedWeaponDefinitions.survivalistBedroll,
		AttachedWeaponDefinitions.handgunHolsterShoulder,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist = {
	chance = 50;
	maxitem = 3;
	weapons = {
		AttachedWeaponDefinitions.meleeInBackBag,
-- 		AttachedWeaponDefinitions.bladeInBackBag,
		AttachedWeaponDefinitions.survivalistBedroll,
-- 		AttachedWeaponDefinitions.gunOnBackBagSurvivalist,
		AttachedWeaponDefinitions.handgunHolster,
		AttachedWeaponDefinitions.knivesBelt_Early,
		AttachedWeaponDefinitions.hammerBelt_Early,
		AttachedWeaponDefinitions.canteen,
		AttachedWeaponDefinitions.handgunHolsterShoulder,
-- 		AttachedWeaponDefinitions.melee2InBackBag,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Mid = {
	chance = 60;
	maxitem = 4;
	weapons = {
		AttachedWeaponDefinitions.meleeInBackBag_Mid,
-- 		AttachedWeaponDefinitions.bladeInBackBag,
		AttachedWeaponDefinitions.survivalistBedroll,
-- 		AttachedWeaponDefinitions.gunOnBackBagSurvivalist,
		AttachedWeaponDefinitions.handgunHolster,
		AttachedWeaponDefinitions.knivesBelt_Mid,
		AttachedWeaponDefinitions.hammerBelt_Mid,
		AttachedWeaponDefinitions.canteen,
		AttachedWeaponDefinitions.handgunHolsterShoulder,
-- 		AttachedWeaponDefinitions.melee2InBackBag,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Late = {
	chance = 70;
	maxitem = 5;
	weapons = {
		AttachedWeaponDefinitions.meleeInBackBag_Late,
-- 		AttachedWeaponDefinitions.bladeInBackBag,
		AttachedWeaponDefinitions.survivalistBedroll,
-- 		AttachedWeaponDefinitions.gunOnBackBagSurvivalist,
		AttachedWeaponDefinitions.handgunHolster,
		AttachedWeaponDefinitions.knivesBelt_Late,
		AttachedWeaponDefinitions.hammerBelt_Late,
		AttachedWeaponDefinitions.canteen,
		AttachedWeaponDefinitions.handgunHolsterShoulder,
-- 		AttachedWeaponDefinitions.melee2InBackBag,
	},
}

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist02 = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist03 = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist04 = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist05 = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist02_Mid = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Mid
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist03_Mid = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Mid
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist04_Mid = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Mid
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist05_Mid = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Mid

AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist02_Late = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Late
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist03_Late = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Late
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist04_Late = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Late
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist05_Late = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Survivalist_Late



AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Gladiator = {
	chance = 80;
	maxitem = 3;
	weapons = {
		AttachedWeaponDefinitions.hammerBelt_Late,
		AttachedWeaponDefinitions.knivesBelt_Late,
		AttachedWeaponDefinitions.meleeInBack_Late,
	},
}
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Metal = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Gladiator
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Natural = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Gladiator
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_RoadRash = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Gladiator
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Spikey = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Gladiator
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_SportsBall = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Gladiator
AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Tint = AttachedWeaponDefinitions.attachedWeaponCustomOutfit.ArmorTest_Gladiator

-- AttachedWeaponDefinitions.attachedWeaponCustomOutfit.Bandit_Advanced = {
-- 	chance = 90;
-- 	maxitem = 3;
-- 	weapons = {
-- 		AttachedWeaponDefinitions.gunOnBackBandit,
-- 		AttachedWeaponDefinitions.handgunHolster,
-- 		AttachedWeaponDefinitions.hammerBelt_Advanced,
-- 		AttachedWeaponDefinitions.knivesBelt_Advanced,
-- 		AttachedWeaponDefinitions.meleeInBack_Advanced,
-- 		AttachedWeaponDefinitions.survivalistBedroll,
-- 		AttachedWeaponDefinitions.handgunHolsterShoulder,
-- 	},
-- }
