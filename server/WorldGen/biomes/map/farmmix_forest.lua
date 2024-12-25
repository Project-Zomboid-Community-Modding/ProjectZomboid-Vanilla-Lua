local farmmix_forest = {
    features = {
        TREE = {
            { f = worldgen.features.TREE.silverbell_jumbo, p = 0.18 },
            { f = worldgen.features.TREE.silverbell, p = 0.19 },
            { f = worldgen.features.TREE.silverbell_sapling, p = 0.09 },
            { f = worldgen.features.TREE.hawthorn_jumbo, p = 0.18 },
            { f = worldgen.features.TREE.hawthorn, p = 0.19 },
            { f = worldgen.features.TREE.hawthorn_sapling, p = 0.1 },
            { f = worldgen.features.TREE.dogwood_jumbo, p = 0.04 },
            { f = worldgen.features.TREE.dogwood, p = 0.02 },
            { f = worldgen.features.TREE.dogwood_sapling, p = 0.01 },
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

worldgen.biomes_map["farmmix_forest"] = farmmix_forest