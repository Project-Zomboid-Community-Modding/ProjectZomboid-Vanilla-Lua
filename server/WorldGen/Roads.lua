require("WorldGen/WorldGen")

worldgen["roads"] = {
    small_road = {
        feature = {
            --f = { "blends_street_01_86" }
            f = {
                main = {
                    "blends_natural_01_64",
                    "blends_natural_01_70",
                    "blends_natural_01_71"
                }
            },
            p = 0.75
        },
        filter_edge = 5e8,
        p = 0.0005
    }
}