local phmix_forest = {
    features = {
        TREE = {
            { f = worldgen.features.TREE.dogwood, p = 1 },

        },
        BUSH = {
            { f = worldgen.features.BUSH.bush_regular, p = 1 },
        },
        PLANT = {
            { f = worldgen.features.PLANT.grass_medium,  p = 0.284 },
            { f = worldgen.features.PLANT.grass_low,     p = 0.55 },

            { f = worldgen.features.PLANT.fern,          p = 0.083 },
            { f = worldgen.features.PLANT.generic_plant, p = 0.083 },
        }
    },
    params = {
        landscape = { "FOREST" },
        temperature = { "MEDIUM" },
        hygrometry = { "DRY", "RAIN" },
        placements = {
            GENERIC = {
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
        },
        protected = {
            "vegetation_drying*",
            "vegetation_farm*",
            "vegetation_foliage*",
            "vegetation_gardening*",
            "vegetation_indoor*",
            "vegetation_ornamental*",
        },
    }
}

worldgen.biomes_map["phmix_forest"] = phmix_forest
