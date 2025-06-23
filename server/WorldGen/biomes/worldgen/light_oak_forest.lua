local light_oak_forest = {
    features = {
        GROUND = {
            { f = worldgen.features.GROUND.medium_grass, p = 1.0 }
        },
        PLANT = {
            { f = worldgen.features.PLANT.grass_medium, p = 0.3 },
            { f = worldgen.features.PLANT.grass_high, p = 0.3 },
            { f = worldgen.features.PLANT.generic_plant, p = 0.1 },
            { f = worldgen.features.PLANT.floor_leaves, p = 0.1 },
        },
        TREE = {
            { f = worldgen.features.TREE.maple_jumbo, p = 0.10625 },
            { f = worldgen.features.TREE.maple, p = 0.00625 },
            { f = worldgen.features.TREE.linden_jumbo, p = 0.003125 },
            { f = worldgen.features.TREE.linden, p = 0.003125 },
            { f = worldgen.features.TREE.yellowwood_jumbo, p = 0.003125 },
            { f = worldgen.features.TREE.yellowwood, p = 0.003125 },
            { f = worldgen.features.TREE.stumps, p = 0.0005 },
        }
    },
    params = {
        landscape = { "LIGHT_FOREST" },
        temperature = { "HOT" },
        hygrometry = { "DRY", "RAIN" },
        zombies = 0.001,
        generate = false
    }
}

local light_oak_forest_boulder_none = {
    parent = "light_oak_forest",
    params = { ore_level = { "NONE" } }
}

local light_oak_forest_boulder_very_low = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.005 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local light_oak_forest_boulder_low = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.01 } } },
    params = { ore_level = { "LOW" } }
}

local light_oak_forest_boulder_medium = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.05 } } },
    params = { ore_level = { "MEDIUM" } }
}

local light_oak_forest_boulder_high = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.1 } } },
    params = { ore_level = { "HIGH" } }
}

local light_oak_forest_boulder_very_high = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.2 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

local light_oak_forest_limestone_none = {
    parent = "light_oak_forest",
    params = { ore_level = { "NONE" } }
}

local light_oak_forest_limestone_very_low = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.0025 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local light_oak_forest_limestone_low = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.005 } } },
    params = { ore_level = { "LOW" } }
}

local light_oak_forest_limestone_medium = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.025 } } },
    params = { ore_level = { "MEDIUM" } }
}

local light_oak_forest_limestone_high = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.05 } } },
    params = { ore_level = { "HIGH" } }
}

local light_oak_forest_limestone_very_high = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.limestone, p = 0.1 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

local light_oak_forest_flint_none = {
    parent = "light_oak_forest",
    params = { ore_level = { "NONE" } }
}

local light_oak_forest_flint_very_low = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.0025 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local light_oak_forest_flint_low = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.005 } } },
    params = { ore_level = { "LOW" } }
}

local light_oak_forest_flint_medium = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.025 } } },
    params = { ore_level = { "MEDIUM" } }
}

local light_oak_forest_flint_high = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.05 } } },
    params = { ore_level = { "HIGH" } }
}

local light_oak_forest_flint_very_high = {
    parent = "light_oak_forest",
    features = { ORE = { { f = worldgen.features.ORE.flint, p = 0.1 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

worldgen.biomes["light_oak_forest"] = light_oak_forest
worldgen.biomes["light_oak_forest_boulder_none"] = light_oak_forest_boulder_none
worldgen.biomes["light_oak_forest_boulder_very_low"] = light_oak_forest_boulder_very_low
worldgen.biomes["light_oak_forest_boulder_low"] = light_oak_forest_boulder_low
worldgen.biomes["light_oak_forest_boulder_medium"] = light_oak_forest_boulder_medium
worldgen.biomes["light_oak_forest_boulder_high"] = light_oak_forest_boulder_high
worldgen.biomes["light_oak_forest_boulder_very_high"] = light_oak_forest_boulder_very_high
worldgen.biomes["light_oak_forest_limestone_none"] = light_oak_forest_limestone_none
worldgen.biomes["light_oak_forest_limestone_very_low"] = light_oak_forest_limestone_very_low
worldgen.biomes["light_oak_forest_limestone_low"] = light_oak_forest_limestone_low
worldgen.biomes["light_oak_forest_limestone_medium"] = light_oak_forest_limestone_medium
worldgen.biomes["light_oak_forest_limestone_high"] = light_oak_forest_limestone_high
worldgen.biomes["light_oak_forest_limestone_very_high"] = light_oak_forest_limestone_very_high
worldgen.biomes["light_oak_forest_flint_none"] = light_oak_forest_flint_none
worldgen.biomes["light_oak_forest_flint_very_low"] = light_oak_forest_flint_very_low
worldgen.biomes["light_oak_forest_flint_low"] = light_oak_forest_flint_low
worldgen.biomes["light_oak_forest_flint_medium"] = light_oak_forest_flint_medium
worldgen.biomes["light_oak_forest_flint_high"] = light_oak_forest_flint_high
worldgen.biomes["light_oak_forest_flint_very_high"] = light_oak_forest_flint_very_high