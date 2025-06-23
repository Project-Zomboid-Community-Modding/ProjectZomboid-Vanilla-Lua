--[[---------------------------------------------
-------------------------------------------------
--
-- generateCraftingMaterialDefs
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Foraging/forageDefinitions";
require "Foraging/forageSystem";

local function generateCraftingMaterialDefs()
	-- "Bottleneck" and tool type items for crafting
	-- These are multiple category items to allow for higher spawn rates
	local craftingMaterials = {
		materials = {
			minCount = 1,
			maxCount = 3,
			chance = 20,
			xp = 20,
			categories = { "Junk", "Trash", "CraftingMaterials" },
			items = {
				AluminumScrap			= "Base.AluminumScrap",
				CopperScrap				= "Base.CopperScrap",
				IronScrap				= "Base.IronScrap",
				SteelScrap				= "Base.SteelScrap",
			},
		},
		tools = {
			minCount = 1,
			maxCount = 1,
			chance = 5,
			xp = 20,
			categories = { "Junk", "CraftingMaterials" },
			items = {
				--FleshingTool            = "Base.FleshingTool",
				--IronBandSmall           = "Base.IronBandSaw",
				Awl                     = "Base.Awl",
				CarpentryChisel         = "Base.CarpentryChisel",
				CrudeWhetstone          = "Base.CrudeWhetstone",
				File                    = "Base.File",
				HandDrill               = "Base.HandDrill",
				Handiknife              = "Base.Handiknife",
				HeadingTool             = "Base.HeadingTool",
				IronBand                = "Base.IronBand",
				KnappingTool            = "Base.KnappingTool",
				MasonsChisel            = "Base.MasonsChisel",
				MasonsTrowel            = "Base.MasonsTrowel",
				MetalworkingChisel      = "Base.MetalworkingChisel",
				MetalworkingPunch       = "Base.MetalworkingPunch",
				Multitool               = "Base.Multitool",
				SheetMetalSnips         = "Base.SheetMetalSnips",
				SmallFileSet            = "Base.SmallFileSet",
				SmallPunchSet           = "Base.SmallPunchSet",
				ViseGrips               = "Base.ViseGrips",
				Whetstone               = "Base.Whetstone",
			},
		},
	};
	for _, spawnTable in pairs(craftingMaterials) do
		for itemName, itemFullName in pairs(spawnTable.items) do
			forageSystem.addForageDef(
                itemName,
                {
                    type = itemFullName,
                    minCount = spawnTable.minCount,
                    maxCount = spawnTable.maxCount,
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
                        TrailerPark = spawnTable.chance,
                        TownZone = spawnTable.chance,
                        ForagingNav = spawnTable.chance,
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

generateCraftingMaterialDefs();