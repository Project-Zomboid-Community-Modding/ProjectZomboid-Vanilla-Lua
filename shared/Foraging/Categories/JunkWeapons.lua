--[[---------------------------------------------
-------------------------------------------------
--
-- generateJunkWeaponDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateJunkWeaponDefs()
	local junkWeapons = {
		normal = {
			chance = 50,
			xp = 1,
			categories = { "JunkWeapons", "Junk", "Trash" },
			items = {
				BluePen                     = "Base.BluePen",
				BreadKnife                  = "Base.BreadKnife",
				ButterKnife                 = "Base.ButterKnife",
				Fork                        = "Base.Fork",
				KitchenKnife                = "Base.KitchenKnife",
				Pen                         = "Base.Pen",
				Pencil                      = "Base.Pencil",
				RedPen                      = "Base.RedPen",
				Scissors                    = "Base.Scissors",
				Spoon                       = "Base.Spoon",
			},
		},
		uncommon = {
			chance = 25,
			xp = 2,
			categories = { "JunkWeapons", "Junk", "Trash" },
			items = {
				BallPeenHammer              = "Base.BallPeenHammer",
				ChairLeg                    = "Base.ChairLeg",
				CraftedFishingRod           = "Base.CraftedFishingRod",
				Drumstick                   = "Base.Drumstick",
				IcePick                     = "Base.IcePick",
				KnifeFillet                 = "Base.KnifeFillet",
				LeadPipe                    = "Base.LeadPipe",
				Pan                         = "Base.Pan",
				Plank                       = "Base.Plank",
				PlankNail                   = "Base.Plank_Nails",
				Plunger                     = "Base.Plunger",
				Poolcue                     = "Base.Poolcue",
				Rake                        = "Base.Rake",
				RollingPin                  = "Base.RollingPin",
				Saucepan                    = "Base.Saucepan",
			},
		},
		rare = {
			chance = 15,
			xp = 5,
			categories = { "JunkWeapons" , "Junk" },
			items = {
				--SpearButterKnife          	= "Base.SpearButterKnife",
				--SpearFork                 	= "Base.SpearFork",
				--SpearIcePick          		= "Base.SpearIcePick",
				--SpearLetterOpener          	= "Base.SpearLetterOpener",
				--SpearScalpel          		= "Base.SpearScalpel",
				--SpearSpoon          		= "Base.SpearSpoon",
				BadmintonRacket             = "Base.BadmintonRacket",
				Broom                       = "Base.Broom",
				ClosedUmbrellaBlack         = "Base.ClosedUmbrellaBlack",
				ClosedUmbrellaBlue          = "Base.ClosedUmbrellaBlue",
				ClosedUmbrellaRed           = "Base.ClosedUmbrellaRed",
				ClosedUmbrellaWhite         = "Base.ClosedUmbrellaWhite",
				FlintKnife                  = "Base.FlintKnife",
				GardenFork                  = "Base.GardenFork",
				GardenHoe                   = "Base.GardenHoe",
				Golfclub                    = "Base.Golfclub",
				GridlePan                   = "Base.GridlePan",
				Hammer                      = "Base.Hammer",
				HuntingKnife                = "Base.HuntingKnife",
				KnifeParing                 = "Base.KnifeParing",
				KnifePocket                 = "Base.KnifePocket",
				KnifeShiv                 	= "Base.KnifeShiv",
				LetterOpener                = "Base.LetterOpener",
				LongHandle                  = "Base.LongHandle",
				LongHandle_Nails            = "Base.LongHandle_Nails",
				Machete                     = "Base.Machete",
				MeatCleaver                 = "Base.MeatCleaver",
				MetalBar                    = "Base.MetalBar",
				MetalPipe                   = "Base.MetalPipe",
				Nightstick                  = "Base.Nightstick",
				PickAxe                     = "Base.PickAxe",
				PipeWrench                  = "Base.PipeWrench",
				Screwdriver                 = "Base.Screwdriver",
				Shovel                      = "Base.Shovel",
				Shovel2                     = "Base.Shovel2",
				SnowShovel                  = "Base.SnowShovel",
				SpearCrafted          		= "Base.SpearCrafted",
				SpearHandFork              	= "Base.SpearHandFork",
				SpearHuntingKnife          	= "Base.SpearHuntingKnife",
				SpearKnife          		= "Base.SpearKnife",
				SpearScissors          		= "Base.SpearScissors",
				SpearScrewdriver          	= "Base.SpearScrewdriver",
				Stake                       = "Base.Stake",
				TableLeg                    = "Base.TableLeg",
-- 				SpearBreadKnife          	= "Base.SpearBreadKnife",
-- 				SpearMachete          		= "Base.SpearMachete",
			},
		},
		epic = {
			chance = 5,
			xp = 10,
			categories = { "JunkWeapons" },
			items = {
				Banjo                       = "Base.Banjo",
				BaseballBat                 = "Base.BaseballBat",
				ClubHammer                  = "Base.ClubHammer",
				Crowbar                     = "Base.Crowbar",
				EntrenchingTool             = "Base.EntrenchingTool",
				FishingRod                  = "Base.FishingRod",
				HandAxe                     = "Base.HandAxe",
				HandFork                    = "Base.HandFork",
				HandScythe                  = "Base.HandScythe",
				HockeyStick                 = "Base.FieldHockeyStick",
				IceHockeyStick              = "Base.IceHockeyStick",
				KnifeButterfly             	= "Base.KnifeButterfly",
				KnifeSushi             		= "Base.KnifeSushi",
				StraightRazor            	= "Base.StraightRazor",
				SwitchKnife            		= "Base.SwitchKnife",
				TennisRacket                = "Base.TennisRacket",
			},
		},
		legendary = {
			chance = 1,
			xp = 25,
			categories = { "JunkWeapons" },
			items = {
				AssaultRifle                = "Base.AssaultRifle",
				AssaultRifle2               = "Base.AssaultRifle2",
				Axe                         = "Base.Axe",
				DoubleBarrelShotgun         = "Base.DoubleBarrelShotgun",
				DoubleBarrelShotgunSawnoff  = "Base.DoubleBarrelShotgunSawnoff",
				HuntingRifle                = "Base.HuntingRifle",
				Katana                      = "Base.Katana",
				Sword                       = "Base.Sword",
				Pistol                      = "Base.Pistol",
				Pistol2                     = "Base.Pistol2",
				Pistol3                     = "Base.Pistol3",
				Revolver                    = "Base.Revolver",
				Revolver_Long               = "Base.Revolver_Long",
				Revolver_Short              = "Base.Revolver_Short",
				Shotgun                     = "Base.Shotgun",
				ShotgunSawnoff              = "Base.ShotgunSawnoff",
				Sledgehammer                = "Base.Sledgehammer",
				Sledgehammer2               = "Base.Sledgehammer2",
				VarmintRifle                = "Base.VarmintRifle",
				WoodAxe                     = "Base.WoodAxe",
			},
		},
	};
	for _, spawnTable in pairs(junkWeapons) do
		for itemName, itemFullName in pairs(spawnTable.items) do
			forageSystem.addForageDef(
				itemName,
				{
					type = itemFullName,
					skill = 0,
					xp = spawnTable.xp,
					categories = spawnTable.categories,
					zones = {
						Forest = spawnTable.chance,
						DeepForest = spawnTable.chance,
						PHForest = spawnTable.chance,
						PRForest = spawnTable.chance,
						BirchForest = spawnTable.chance,
						Vegitation = spawnTable.chance,
						FarmLand = spawnTable.chance,
						TrailerPark = spawnTable.chance,
						TownZone = spawnTable.chance,
						ForagingNav = spawnTable.chance,
					},
					spawnFuncs = { forageSystem.doJunkWeaponSpawn },
					forceOutside = false,
					canBeAboveFloor = true,
					itemSizeModifier = 0.5,
					isItemOverrideSize = true,
				}
			);
		end;
	end;
end

generateJunkWeaponDefs();