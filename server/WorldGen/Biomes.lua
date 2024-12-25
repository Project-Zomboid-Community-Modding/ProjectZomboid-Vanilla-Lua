-- Available params are
-- landscape = <FOREST, LIGHT_FOREST, PLAIN, NONE>
-- plant = <FLOWER, GRASS, NONE>
-- temperature = <HOT, COLD, MEDIUM>
-- hygrometry = <RAIN, DRY, NONE>
-- zombies = <chances of having zombies>

require("WorldGen/WorldGen")
require("WorldGen/Features")

worldgen["biomes"] = {}
worldgen["biomes_map"] = {}