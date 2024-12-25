local flower_plain = {
    features = {
        GROUND = {
            { f = worldgen.features.GROUND.light_grass, p = 1.0 }
        },
        PLANT = {
            { f = worldgen.features.PLANT.flower_overlay, p = 0.5 }
        },
        TREE = {
            { f = worldgen.features.TREE.oak, p = 0.01 }
        }
    },
    params = {
        landscape = { "PLAIN" },
        plant = { "FLOWER" },
        hygrometry = { "DRY", "RAIN" },
        zombies = 0.0
    }
}
worldgen.biomes["flower_plain"] = flower_plain