local phmix_forest = {
    features = {
        TREE = {
            { f = worldgen.features.TREE.silverbell_jumbo, p = 0.2 },
            { f = worldgen.features.TREE.redbud_jumbo, p = 0.2 },
            { f = worldgen.features.TREE.dogwood_jumbo, p = 0.1 },
            { f = worldgen.features.TREE.silverbell, p = 0.2 },
            { f = worldgen.features.TREE.redbud, p = 0.2 },
            { f = worldgen.features.TREE.dogwood, p = 0.1 },

        },
        BUSH = {
            { f = worldgen.features.BUSH.bush_regular, p = 1 },
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

worldgen.biomes_map["phmix_forest"] = phmix_forest