local pine_forest = {
    features = {
        GROUND = {
            { f = worldgen.features.GROUND.dark_grass, p = 1.0 }
        },
        PLANT = {
            { f = worldgen.features.PLANT.grass_medium, p = 0.3 },
            { f = worldgen.features.PLANT.grass_high, p = 0.3 },
            { f = worldgen.features.PLANT.generic_plant, p = 0.1 },
            { f = worldgen.features.PLANT.floor_leaves, p = 0.1 },
        },
        TREE = {
            { f = worldgen.features.TREE.pine_jumbo, p = 0.07083 },
            { f = worldgen.features.TREE.holly_jumbo, p = 0.07083 },
            { f = worldgen.features.TREE.hemlock_jumbo, p = 0.07083 },
            { f = worldgen.features.TREE.pine, p = 0.0125 },
            { f = worldgen.features.TREE.holly, p = 0.0125 },
            { f = worldgen.features.TREE.hemlock, p = 0.0125 },
            { f = worldgen.features.TREE.stumps, p = 0.001 },
        }
    },
    params = {
        landscape = { "FOREST" },
        temperature = { "COLD" },
        hygrometry = { "DRY", "RAIN" },
        zombies = 0.001,
        generate = false
    }
}

local pine_forest_boulder_none = {
    parent = "pine_forest",
    params = { ore_level = { "NONE" } }
}

local pine_forest_boulder_very_low = {
    parent = "pine_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.005 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local pine_forest_boulder_low = {
    parent = "pine_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.01 } } },
    params = { ore_level = { "LOW" } }
}

local pine_forest_boulder_medium = {
    parent = "pine_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.05 } } },
    params = { ore_level = { "MEDIUM" } }
}

local pine_forest_boulder_high = {
    parent = "pine_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.1 } } },
    params = { ore_level = { "HIGH" } }
}

local pine_forest_boulder_very_high = {
    parent = "pine_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.2 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

worldgen.biomes["pine_forest"] = pine_forest
worldgen.biomes["pine_forest_boulder_none"] = pine_forest_boulder_none
worldgen.biomes["pine_forest_boulder_very_low"] = pine_forest_boulder_very_low
worldgen.biomes["pine_forest_boulder_low"] = pine_forest_boulder_low
worldgen.biomes["pine_forest_boulder_medium"] = pine_forest_boulder_medium
worldgen.biomes["pine_forest_boulder_high"] = pine_forest_boulder_high
worldgen.biomes["pine_forest_boulder_very_high"] = pine_forest_boulder_very_high