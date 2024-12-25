local organic_forest = {
    features = {
        TREE = {
            { f = worldgen.features.TREE.hemlock_jumbo, p = 0.55 },
            { f = worldgen.features.TREE.hemlock, p = 0.05 },
            { f = worldgen.features.TREE.linden_jumbo, p = 0.35 },
            { f = worldgen.features.TREE.linden, p = 0.05 },
            { f = worldgen.features.TREE.holly, p = 0.025 },
            { f = worldgen.features.TREE.holly_jumbo, p = 0.025 },

        },
        BUSH = {
            { f = worldgen.features.BUSH.bush_fat, p = 1 },
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

worldgen.biomes_map["organic_forest"] = organic_forest