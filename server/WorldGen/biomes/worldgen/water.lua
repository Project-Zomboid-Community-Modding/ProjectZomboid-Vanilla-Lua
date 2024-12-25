local water = {
    features = {
        GROUND = {
            { f = worldgen.features.GROUND.water, p = 1.0 }
        }
    },
    params = {
        hygrometry = { "FLOODING" },
        zombies = 0.0
    }
}
worldgen.biomes["water"] = water