require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateBonesDefs()
	local bones = {
		--crafting items which can be found anywhere outside of towns
		generic = {
			chance = 10,
			xp = 20,
			categories = { "Bones", "Junk", "CraftingMaterials" },
			items = {
				AnimalBone              = "Base.AnimalBone",
				Antlers_Wall	        = "Base.Antlers_Wall",
				Bull_Skull         		= "Base.Bull_Skull",
				Calf_Skull         		= "Base.Calf_Skull",
				Cow_Skull         		= "Base.Cow_Skull",
				DeerDoe_Skull         	= "Base.DeerDoe_Skull",
				DeerFawn_Skull         	= "Base.DeerFawn_Skull",
				HerbivoreTeeth          = "Base.HerbivoreTeeth",
				JawboneBovide           = "Base.JawboneBovide",
				Lamb_Skull         		= "Base.Lamb_Skull",
				LargeAnimalBone	        = "Base.LargeAnimalBone",
				PigTusk                 = "Base.PigTusk",
				Pig_Skull         		= "Base.Pig_Skull",
				Piglet_Skull         	= "Base.Piglet_Skull",
				Rabbit_KittenSkull      = "Base.Rabbit_KittenSkull",
				Rabbit_Skull         	= "Base.Rabbit_Skull",
				Ram_Skull         		= "Base.Ram_Skull",
				Sheep_Skull         	= "Base.Sheep_Skull",
				SmallAnimalBone         = "Base.SmallAnimalBone",
			},
		},
	};
	for _, spawnTable in pairs(bones) do
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

generateBonesDefs();
