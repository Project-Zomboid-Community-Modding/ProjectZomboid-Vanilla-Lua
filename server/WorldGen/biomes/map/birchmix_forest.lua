local birchmix_forest = {
    features = {
        TREE = {
            { f = worldgen.features.TREE.hemlock_jumbo, p = 0.75 },
            { f = worldgen.features.TREE.hemlock, p = 0.05 },
            { f = worldgen.features.TREE.silverbell_jumbo, p = 0.15 },
            { f = worldgen.features.TREE.silverbell, p = 0.05 },
        },
        BUSH = {
            { f = worldgen.features.BUSH.bush_fat, p = 0.5 },
            { f = worldgen.features.BUSH.bush_regular, p = 0.5 },
        },
    },
    params = {
        landscape = { "FOREST" },
        temperature = { "MEDIUM" },
        hygrometry = { "DRY", "RAIN" },
        zombies = 0.001,
        placement = {
            "blends_natural_01_*",

            "!blends_natural_01_0",
            "!blends_natural_01_5",
            "!blends_natural_01_6",
            "!blends_natural_01_7",

            "!blends_natural_01_64",
            "!blends_natural_01_69",
            "!blends_natural_01_70",
            "!blends_natural_01_71",
        },
        grass = {
            fernChance = 0.5,
            noGrassDiv = 6,
            noGrassStages = { 0.4 },
            grassStages = { 0.33, 0.5 } 
        },
    }
}

worldgen.biomes_map["birchmix_forest"] = birchmix_forest