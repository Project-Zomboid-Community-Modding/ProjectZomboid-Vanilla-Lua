local grass_plain = {
    features = {
        GROUND = {
            { f = worldgen.features.GROUND.medium_grass, p = 1.0 }
        },
        PLANT = {
            { f = worldgen.features.PLANT.grass_overlay, p = 0.5 }
        },
        TREE = {
            { f = worldgen.features.TREE.oak, p = 0.01 }
        }
    },
    params = {
        landscape = { "PLAIN" },
        plant = { "GRASS" },
        hygrometry = { "DRY", "RAIN" },
        zombies = 0.01,
        generate = false
    }
}

local grass_plain_boulder_none = {
    parent = "grass_plain",
    params = { ore_level = { "NONE" } }
}

local grass_plain_boulder_very_low = {
    parent = "grass_plain",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.005 } } },
    params = { ore_level = { "VERY_LOW" } }
}

local grass_plain_boulder_low = {
    parent = "grass_plain",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.01 } } },
    params = { ore_level = { "LOW" } }
}

local grass_plain_boulder_medium = {
    parent = "grass_plain",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.05 } } },
    params = { ore_level = { "MEDIUM" } }
}

local grass_plain_boulder_high = {
    parent = "grass_plain",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.1 } } },
    params = { ore_level = { "HIGH" } }
}

local grass_plain_boulder_very_high = {
    parent = "grass_plain",
    features = { ORE = { { f = worldgen.features.ORE.boulders, p = 0.2 } } },
    params = { ore_level = { "VERY_HIGH" } }
}

worldgen.biomes["grass_plain"] = grass_plain
worldgen.biomes["grass_plain_boulder_none"] = grass_plain_boulder_none
worldgen.biomes["grass_plain_boulder_very_low"] = grass_plain_boulder_very_low
worldgen.biomes["grass_plain_boulder_low"] = grass_plain_boulder_low
worldgen.biomes["grass_plain_boulder_medium"] = grass_plain_boulder_medium
worldgen.biomes["grass_plain_boulder_high"] = grass_plain_boulder_high
worldgen.biomes["grass_plain_boulder_very_high"] = grass_plain_boulder_very_high