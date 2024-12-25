local vegitation = {
    features = {
        TREE = {
            { f = worldgen.features.TREE.silverbell_jumbo, p = 0.01 },
            { f = worldgen.features.TREE.silverbell, p = 0.19 },
            { f = worldgen.features.TREE.silverbell_sapling, p = 0.1 },
            { f = worldgen.features.TREE.redbud_jumbo, p = 0.01 },
            { f = worldgen.features.TREE.redbud, p = 0.19 },
            { f = worldgen.features.TREE.redbud_sapling, p = 0.1 },
            { f = worldgen.features.TREE.yellowwood_jumbo, p = 0.02 },
            { f = worldgen.features.TREE.yellowwood, p = 0.28 },
            { f = worldgen.features.TREE.yellowwood_sapling, p = 0.1 },
        },
        BUSH = {
            { f = worldgen.features.BUSH.bush_dry, p = 1 },
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
            fernChance = 0.3,
            noGrassDiv = 12,
            noGrassStages = { 0.4 },
            grassStages = { 0.33, 0.5 } 
        },
    }
}

worldgen.biomes_map["vegitation"] = vegitation