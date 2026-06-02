require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateArtifactDefs()
	local artifacts = {
		stoneArtifacts = {
			chance = 5,
			xp = 20,
			categories = { "Artifacts" },
			items = {
				Awl_Stone              	= "Base.Awl_Stone",
				PrimitiveScythe        	= "Base.PrimitiveScythe",
				Saw_Flint        		= "Base.Saw_Flint",
				StoneAxeHead            = "Base.StoneAxeHead",
				StoneBlade             	= "Base.StoneBlade",
				StoneBladeLong        	= "Base.StoneBladeLong",
				StoneChisel             = "Base.StoneChisel",
				StoneDrill           	= "Base.StoneDrill",
				StoneMaceHead			= "Base.StoneMaceHead",
				StoneMaulHead           = "Base.StoneMaulHead",
			},
		},
		boneArtifacts = {
			chance = 5,
			xp = 20,
			categories = { "Artifacts" },
			items = {
				SharpBoneFragment       = "Base.SharpBoneFragment",
				Awl_Bone        		= "Base.Awl_Bone",
				SharpBone_Long     		= "Base.SharpBone_Long",
				BoneBead_Large          = "Base.BoneBead_Large",
				HatchetHead_Bone       	= "Base.HatchetHead_Bone",
				Needle_Bone	        	= "Base.Needle_Bone",
				FishingHook_Bone        = "Base.FishingHook_Bone",
				Whistle_Bone        	= "Base.Whistle_Bone",
			},
		},
		metalArtifacts = {
			chance = 5,
			xp = 20,
			categories = { "Artifacts" },
			items = {
				BallPeenHammerHead		= "Base.BallPeenHammerHead",
				ClawhammerHead			= "Base.ClawhammerHead",
				ClubHammerHead			= "Base.ClubHammerHead",
				ForkForged				= "Base.ForkForged",
				GardenForkHead_Forged	= "Base.GardenForkHead_Forged",
				GardenHoeHead			= "Base.GardenHoeHead",
				HandAxeHead				= "Base.HandAxeHead",
				HandScytheBlade			= "Base.HandScytheBlade",
				HeavyChainLink			= "Base.HeavyChainLink",
				HuntingKnifeBlade		= "Base.HuntingKnifeBlade",
				KeyRing_Forged			= "Base.KeyRing_Forged",
				KitchenKnifeBlade		= "Base.KitchenKnifeBlade",
				Lantern_Hurricane		= "Base.Lantern_Hurricane",
				LargeKnifeBlade			= "Base.LargeKnifeBlade",
				Latch					= "Base.Latch",
				MeatCleaverBlade		= "Base.MeatCleaverBlade",
				MetalCup				= "Base.MetalCup",
				OldAxeHead				= "Base.OldAxeHead",
				OldDrill				= "Base.OldDrill",
				PanForged				= "Base.PanForged",
				PickAxeHead				= "Base.PickAxeHead",
				PotForged				= "Base.PotForged",
				RakeHead				= "Base.RakeHead",
				ScissorsForged			= "Base.ScissorsForged",
				ScytheBlade				= "Base.ScytheBlade",
				SheepShearsForged		= "Base.SheepShearsForged",
				SledgehammerHead		= "Base.SledgehammerHead",
				SmithingHammerHead		= "Base.SmithingHammerHead",
				SpadeHead_Forged		= "Base.SpadeHead_Forged",
				SpoonForged				= "Base.SpoonForged",
				WoodAxeHead				= "Base.WoodAxeHead",
			},
		},
		rareCoins = {
			chance = 7,
			xp = 20,
			categories = { "Artifacts", "Junk", "Trash" },
			items = {
				SilverCoin       = "Base.SilverCoin",
			},
		},
		epicCoins = {
			chance = 1,
			xp = 20,
			categories = { "Artifacts" },
			items = {
				GoldCoin       	= "Base.GoldCoin",
			},
		},
	};
	for _, spawnTable in pairs(artifacts) do
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
					OrganicForest = spawnTable.chance,
					Vegitation = spawnTable.chance,
					FarmLand = spawnTable.chance,
				},
				spawnFuncs = { forageSystem.doGenericItemSpawn },
				forceOutside = false,
				canBeAboveFloor = true,
				itemSizeModifier = 0.5,
				isItemOverrideSize = true,
				}
			);
		end;
	end;
end

generateArtifactDefs();
