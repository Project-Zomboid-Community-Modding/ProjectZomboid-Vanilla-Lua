local highway_NS_00 = {
    dimensions = { 20, 3 },
    zombies = 0.01,
    tiles = {
        "blends_street_01_86",
        "floors_exterior_tilesandstone_01_3",
        "street_curbs_01_9",
        "street_curbs_01_11",
        "street_trafficlines_01_4",
        "street_trafficlines_01_16",
        "street_trafficlines_01_20",
        "walls_garage_02_20"
    },
    schematic = {
        Floor = {
            "2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,0",
            "2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,0",
            "2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,0"
        },
        FloorFurniture = {
            "0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0",
            "0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0",
            "0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0"
        },
        FloorOverlay = {
            "0,0,5,0,0,0,0,0,7,6,0,0,0,0,0,0,0,0,0,0",
            "0,0,5,0,0,0,0,0,7,6,0,0,0,0,0,0,0,0,0,0",
            "0,0,5,0,0,5,0,0,7,6,0,0,5,0,0,0,0,0,0,0"
        },
        Furniture = {
            "8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8",
            "8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8",
            "8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8"
        }
    }
}

worldgen.prefabs["highway_NS_00"] = highway_NS_00