local map_forest = {
    features = {},
    params = {
        landscape = {},
        plant = {},
        temperature = {},
        hygrometry = {},
        placements = {
            GENERIC = {
                "blends_natural_01_*",

                "!blends_natural_01_0",
                "!blends_natural_01_5",
                "!blends_natural_01_6",
                "!blends_natural_01_7",

                "!blends_natural_01_64",
                "!blends_natural_01_69",
                "!blends_natural_01_70",
                "!blends_natural_01_71",

                "!blends_natural_02_*",
            },
        },
        protected = {
            "vegetation_drying*",
            "vegetation_farm*",
            "vegetation_foliage*",
            "vegetation_gardening*",
            "vegetation_indoor*",
            "vegetation_ornamental*",
        },
        generate = false
    }
}

local map_forest_boulder_none = {
    parent = "map_forest",
    params = { ore_level = { "NONE" } }
}

local map_forest_boulder_very_low = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.001 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local map_forest_boulder_low = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.002 } } },
    params = { ore_level = { "LOW" } }
}

local map_forest_boulder_medium = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.01 } } },
    params = { ore_level = { "MEDIUM" } }
}

local map_forest_boulder_high = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.02 } } },
    params = { ore_level = { "HIGH" } }
}

local map_forest_boulder_very_high = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.04 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

local map_forest_limestone_none = {
    parent = "map_forest",
    params = { ore_level = { "NONE" } }
}

local map_forest_limestone_very_low = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.0005 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local map_forest_limestone_low = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.001 } } },
    params = { ore_level = { "LOW" } }
}

local map_forest_limestone_medium = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.005 } } },
    params = { ore_level = { "MEDIUM" } }
}

local map_forest_limestone_high = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.01 } } },
    params = { ore_level = { "HIGH" } }
}

local map_forest_limestone_very_high = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.02 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

local map_forest_flint_none = {
    parent = "map_forest",
    params = { ore_level = { "NONE" } }
}

local map_forest_flint_very_low = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.0005 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local map_forest_flint_low = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.001 } } },
    params = { ore_level = { "LOW" } }
}

local map_forest_flint_medium = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.005 } } },
    params = { ore_level = { "MEDIUM" } }
}

local map_forest_flint_high = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.01 } } },
    params = { ore_level = { "HIGH" } }
}

local map_forest_flint_very_high = {
    parent = "map_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.02 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

worldgen.biomes_map["map_forest"] = map_forest
worldgen.biomes_map["map_forest_boulder_none"] = map_forest_boulder_none
worldgen.biomes_map["map_forest_boulder_very_low"] = map_forest_boulder_very_low
worldgen.biomes_map["map_forest_boulder_low"] = map_forest_boulder_low
worldgen.biomes_map["map_forest_boulder_medium"] = map_forest_boulder_medium
worldgen.biomes_map["map_forest_boulder_high"] = map_forest_boulder_high
worldgen.biomes_map["map_forest_boulder_very_high"] = map_forest_boulder_very_high
worldgen.biomes_map["map_forest_limestone_none"] = map_forest_limestone_none
worldgen.biomes_map["map_forest_limestone_very_low"] = map_forest_limestone_very_low
worldgen.biomes_map["map_forest_limestone_low"] = map_forest_limestone_low
worldgen.biomes_map["map_forest_limestone_medium"] = map_forest_limestone_medium
worldgen.biomes_map["map_forest_limestone_high"] = map_forest_limestone_high
worldgen.biomes_map["map_forest_limestone_very_high"] = map_forest_limestone_very_high
worldgen.biomes_map["map_forest_flint_none"] = map_forest_flint_none
worldgen.biomes_map["map_forest_flint_very_low"] = map_forest_flint_very_low
worldgen.biomes_map["map_forest_flint_low"] = map_forest_flint_low
worldgen.biomes_map["map_forest_flint_medium"] = map_forest_flint_medium
worldgen.biomes_map["map_forest_flint_high"] = map_forest_flint_high
worldgen.biomes_map["map_forest_flint_very_high"] = map_forest_flint_very_high
