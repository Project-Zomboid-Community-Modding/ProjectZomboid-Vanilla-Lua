local birch_forest = {
    features = {
        GROUND = {
            { f = worldgen.features.GROUND.light_grass, p = 1.0 }
        },
        PLANT = {
            { f = worldgen.features.PLANT.grass_overlay, p = 0.4 },
            { f = worldgen.features.PLANT.generic_plant, p = 0.1 },
            { f = worldgen.features.PLANT.floor_leaves, p = 0.1 },
        },
        TREE = {
            { f = worldgen.features.TREE.birch, p = 0.25 },
--             { f = worldgen.features.PLANT.stumps, p = 0.0001 }
        }
    },
    params = {
        landscape = { "FOREST" },
        temperature = { "MEDIUM" },
        hygrometry = { "DRY", "RAIN" },
        zombies = 0.005,
        generate = false
    }
}

local birch_forest_boulder_none = {
    parent = "birch_forest",
    params = { ore_level = { "NONE" } }
}

local birch_forest_boulder_very_low = {
    parent = "birch_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.005 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local birch_forest_boulder_low = {
    parent = "birch_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.01 } } },
    params = { ore_level = { "LOW" } }
}

local birch_forest_boulder_medium = {
    parent = "birch_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.05 } } },
    params = { ore_level = { "MEDIUM" } }
}

local birch_forest_boulder_high = {
    parent = "birch_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.1 } } },
    params = { ore_level = { "HIGH" } }
}

local birch_forest_boulder_very_high = {
    parent = "birch_forest",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.2 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

worldgen.biomes["birch_forest"] = birch_forest
worldgen.biomes["birch_forest_boulder_none"] = birch_forest_boulder_none
worldgen.biomes["birch_forest_boulder_very_low"] = birch_forest_boulder_very_low
worldgen.biomes["birch_forest_boulder_low"] = birch_forest_boulder_low
worldgen.biomes["birch_forest_boulder_medium"] = birch_forest_boulder_medium
worldgen.biomes["birch_forest_boulder_high"] = birch_forest_boulder_high
worldgen.biomes["birch_forest_boulder_very_high"] = birch_forest_boulder_very_high