--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

local VERSION = 2

local tiles = {}

-- six tile bends, tall metal wire fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_56", "fencing_01_57", "fencing_01_56", "fencing_01_57", "fencing_01_56", "fencing_01_57"} },
                           { stage = 1, tiles = {"fencing_damaged_02_0", "fencing_damaged_02_1", "fencing_damaged_02_2", "fencing_damaged_02_3", "fencing_damaged_02_4", "fencing_damaged_02_5"} },
                           { stage = 2, tiles = {"fencing_damaged_02_64", "fencing_damaged_02_65", "fencing_damaged_02_66", "fencing_damaged_02_67", "fencing_damaged_02_68", "fencing_damaged_02_69"} },
                           { stage = 3, tiles = {"fencing_damaged_02_96", "fencing_damaged_02_97", "fencing_damaged_02_98", "fencing_damaged_02_99", "fencing_damaged_02_100", "fencing_damaged_02_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_02_113", "fencing_damaged_02_112", "fencing_damaged_02_117", "fencing_damaged_02_114", "fencing_damaged_02_116", "fencing_damaged_02_115"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_60", "fencing_01_57", "fencing_01_56", "fencing_01_57", "fencing_01_56", "fencing_01_57"} },
                           { stage = 1, tiles = {"fencing_damaged_02_0", "fencing_damaged_02_1", "fencing_damaged_02_2", "fencing_damaged_02_3", "fencing_damaged_02_4", "fencing_damaged_02_5"} },
                           { stage = 2, tiles = {"fencing_damaged_02_64", "fencing_damaged_02_65", "fencing_damaged_02_66", "fencing_damaged_02_67", "fencing_damaged_02_68", "fencing_damaged_02_69"} },
                           { stage = 3, tiles = {"fencing_damaged_02_96", "fencing_damaged_02_97", "fencing_damaged_02_98", "fencing_damaged_02_99", "fencing_damaged_02_100", "fencing_damaged_02_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_02_113", "fencing_damaged_02_112", "fencing_damaged_02_117", "fencing_damaged_02_114", "fencing_damaged_02_116", "fencing_damaged_02_115"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_56", "fencing_01_57", "fencing_01_56", "fencing_01_57", "fencing_01_56", "fencing_01_57"} },
                        { stage = 1, tiles = {"fencing_damaged_02_8", "fencing_damaged_02_9", "fencing_damaged_02_10", "fencing_damaged_02_11", "fencing_damaged_02_12", "fencing_damaged_02_13"} },
                        { stage = 2, tiles = {"fencing_damaged_02_48", "fencing_damaged_02_49", "fencing_damaged_02_50", "fencing_damaged_02_51", "fencing_damaged_02_52", "fencing_damaged_02_53"} },
                        { stage = 3, tiles = {"fencing_damaged_02_80", "fencing_damaged_02_81", "fencing_damaged_02_82", "fencing_damaged_02_83", "fencing_damaged_02_84", "fencing_damaged_02_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_02_139", "fencing_damaged_02_141", "fencing_damaged_02_136", "fencing_damaged_02_140", "fencing_damaged_02_138", "fencing_damaged_02_137"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_60", "fencing_01_57", "fencing_01_56", "fencing_01_57", "fencing_01_56", "fencing_01_57"} },
                            { stage = 1, tiles = {"fencing_damaged_02_8", "fencing_damaged_02_9", "fencing_damaged_02_10", "fencing_damaged_02_11", "fencing_damaged_02_12", "fencing_damaged_02_13"} },
                            { stage = 2, tiles = {"fencing_damaged_02_48", "fencing_damaged_02_49", "fencing_damaged_02_50", "fencing_damaged_02_51", "fencing_damaged_02_52", "fencing_damaged_02_53"} },
                            { stage = 3, tiles = {"fencing_damaged_02_80", "fencing_damaged_02_81", "fencing_damaged_02_82", "fencing_damaged_02_83", "fencing_damaged_02_84", "fencing_damaged_02_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_02_139", "fencing_damaged_02_141", "fencing_damaged_02_136", "fencing_damaged_02_140", "fencing_damaged_02_138", "fencing_damaged_02_137"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_59", "fencing_01_58", "fencing_01_59", "fencing_01_58", "fencing_01_59", "fencing_01_58"} },
                           { stage = 1, tiles = {"fencing_damaged_02_16", "fencing_damaged_02_17", "fencing_damaged_02_18", "fencing_damaged_02_19", "fencing_damaged_02_20", "fencing_damaged_02_21"} },
                           { stage = 2, tiles = {"fencing_damaged_02_61", "fencing_damaged_02_60", "fencing_damaged_02_59", "fencing_damaged_02_58", "fencing_damaged_02_57", "fencing_damaged_02_56"} },
                           { stage = 3, tiles = {"fencing_damaged_02_93", "fencing_damaged_02_92", "fencing_damaged_02_91", "fencing_damaged_02_90", "fencing_damaged_02_89", "fencing_damaged_02_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_02_132", "fencing_damaged_02_129", "fencing_damaged_02_131", "fencing_damaged_02_128", "fencing_damaged_02_130", "fencing_damaged_02_133"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_60", "fencing_01_58", "fencing_01_59", "fencing_01_58", "fencing_01_59", "fencing_01_58"} },
                           { stage = 1, tiles = {"fencing_damaged_02_16", "fencing_damaged_02_17", "fencing_damaged_02_18", "fencing_damaged_02_19", "fencing_damaged_02_20", "fencing_damaged_02_21"} },
                           { stage = 2, tiles = {"fencing_damaged_02_61", "fencing_damaged_02_60", "fencing_damaged_02_59", "fencing_damaged_02_58", "fencing_damaged_02_57", "fencing_damaged_02_56"} },
                           { stage = 3, tiles = {"fencing_damaged_02_93", "fencing_damaged_02_92", "fencing_damaged_02_91", "fencing_damaged_02_90", "fencing_damaged_02_89", "fencing_damaged_02_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_02_132", "fencing_damaged_02_129", "fencing_damaged_02_131", "fencing_damaged_02_128", "fencing_damaged_02_130", "fencing_damaged_02_133"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_59", "fencing_01_58", "fencing_01_59", "fencing_01_58", "fencing_01_59", "fencing_01_58"} },
                           { stage = 1, tiles = {"fencing_damaged_02_24", "fencing_damaged_02_25", "fencing_damaged_02_26", "fencing_damaged_02_27", "fencing_damaged_02_28", "fencing_damaged_02_29"} },
                           { stage = 2, tiles = {"fencing_damaged_02_45", "fencing_damaged_02_44", "fencing_damaged_02_43", "fencing_damaged_02_42", "fencing_damaged_02_41", "fencing_damaged_02_40"} },
                           { stage = 3, tiles = {"fencing_damaged_02_109", "fencing_damaged_02_108", "fencing_damaged_02_107", "fencing_damaged_02_106", "fencing_damaged_02_105", "fencing_damaged_02_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_02_125", "fencing_damaged_02_123", "fencing_damaged_02_124", "fencing_damaged_02_122", "fencing_damaged_02_121", "fencing_damaged_02_120"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_60", "fencing_01_58", "fencing_01_59", "fencing_01_58", "fencing_01_59", "fencing_01_58"} },
                           { stage = 1, tiles = {"fencing_damaged_02_24", "fencing_damaged_02_25", "fencing_damaged_02_26", "fencing_damaged_02_27", "fencing_damaged_02_28", "fencing_damaged_02_29"} },
                           { stage = 2, tiles = {"fencing_damaged_02_45", "fencing_damaged_02_44", "fencing_damaged_02_43", "fencing_damaged_02_42", "fencing_damaged_02_41", "fencing_damaged_02_40"} },
                           { stage = 3, tiles = {"fencing_damaged_02_109", "fencing_damaged_02_108", "fencing_damaged_02_107", "fencing_damaged_02_106", "fencing_damaged_02_105", "fencing_damaged_02_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_02_125", "fencing_damaged_02_123", "fencing_damaged_02_124", "fencing_damaged_02_122", "fencing_damaged_02_121", "fencing_damaged_02_120"},
});

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--four tile bends, tall metal wire fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_56", "fencing_01_57", "fencing_01_56", "fencing_01_57"} },
                           { stage = 1, tiles = {"fencing_damaged_02_184", "fencing_damaged_02_185", "fencing_damaged_02_186", "fencing_damaged_02_187"} },
                           { stage = 2, tiles = {"fencing_damaged_02_192", "fencing_damaged_02_193", "fencing_damaged_02_194", "fencing_damaged_02_195"} },
                           { stage = 3, tiles = {"fencing_damaged_02_188", "fencing_damaged_02_189", "fencing_damaged_02_190", "fencing_damaged_02_191"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_02_200", "fencing_damaged_02_202", "fencing_damaged_02_204", "fencing_damaged_02_201", "fencing_damaged_02_205", "fencing_damaged_02_203"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_60", "fencing_01_57", "fencing_01_56", "fencing_01_57"} },
                           { stage = 1, tiles = {"fencing_damaged_02_184", "fencing_damaged_02_185", "fencing_damaged_02_186", "fencing_damaged_02_187"} },
                           { stage = 2, tiles = {"fencing_damaged_02_192", "fencing_damaged_02_193", "fencing_damaged_02_194", "fencing_damaged_02_195"} },
                           { stage = 3, tiles = {"fencing_damaged_02_188", "fencing_damaged_02_189", "fencing_damaged_02_190", "fencing_damaged_02_191"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_02_200", "fencing_damaged_02_202", "fencing_damaged_02_204", "fencing_damaged_02_201", "fencing_damaged_02_205", "fencing_damaged_02_203"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_56", "fencing_01_57", "fencing_01_56", "fencing_01_57"} },
                           { stage = 1, tiles = {"fencing_damaged_02_152", "fencing_damaged_02_153", "fencing_damaged_02_154", "fencing_damaged_02_155"} },
                           { stage = 2, tiles = {"fencing_damaged_02_164", "fencing_damaged_02_165", "fencing_damaged_02_166", "fencing_damaged_02_167"} },
                           { stage = 3, tiles = {"fencing_damaged_02_160", "fencing_damaged_02_161", "fencing_damaged_02_162", "fencing_damaged_02_163"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_02_147", "fencing_damaged_02_149", "fencing_damaged_02_145", "fencing_damaged_02_148", "fencing_damaged_02_146", "fencing_damaged_02_144"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_60", "fencing_01_57", "fencing_01_56", "fencing_01_57"} },
                           { stage = 1, tiles = {"fencing_damaged_02_152", "fencing_damaged_02_153", "fencing_damaged_02_154", "fencing_damaged_02_155"} },
                           { stage = 2, tiles = {"fencing_damaged_02_164", "fencing_damaged_02_165", "fencing_damaged_02_166", "fencing_damaged_02_167"} },
                           { stage = 3, tiles = {"fencing_damaged_02_160", "fencing_damaged_02_161", "fencing_damaged_02_162", "fencing_damaged_02_163"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_02_147", "fencing_damaged_02_149", "fencing_damaged_02_145", "fencing_damaged_02_148", "fencing_damaged_02_146", "fencing_damaged_02_144"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_59", "fencing_01_58", "fencing_01_59", "fencing_01_58"} },
                           { stage = 1, tiles = {"fencing_damaged_02_159", "fencing_damaged_02_158", "fencing_damaged_02_157", "fencing_damaged_02_156"} },
                           { stage = 2, tiles = {"fencing_damaged_02_175", "fencing_damaged_02_174", "fencing_damaged_02_173", "fencing_damaged_02_172"} },
                           { stage = 3, tiles = {"fencing_damaged_02_171", "fencing_damaged_02_170", "fencing_damaged_02_169", "fencing_damaged_02_168"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_02_179", "fencing_damaged_02_177", "fencing_damaged_02_180", "fencing_damaged_02_176", "fencing_damaged_02_181", "fencing_damaged_02_178"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_60", "fencing_01_58", "fencing_01_59", "fencing_01_58"} },
                           { stage = 1, tiles = {"fencing_damaged_02_159", "fencing_damaged_02_158", "fencing_damaged_02_157", "fencing_damaged_02_156"} },
                           { stage = 2, tiles = {"fencing_damaged_02_175", "fencing_damaged_02_174", "fencing_damaged_02_173", "fencing_damaged_02_172"} },
                           { stage = 3, tiles = {"fencing_damaged_02_171", "fencing_damaged_02_170", "fencing_damaged_02_169", "fencing_damaged_02_168"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_02_179", "fencing_damaged_02_177", "fencing_damaged_02_180", "fencing_damaged_02_176", "fencing_damaged_02_181", "fencing_damaged_02_178"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_59", "fencing_01_58", "fencing_01_59", "fencing_01_58"} },
                           { stage = 1, tiles = {"fencing_damaged_02_211", "fencing_damaged_02_210", "fencing_damaged_02_209", "fencing_damaged_02_208"} },
                           { stage = 2, tiles = {"fencing_damaged_02_215", "fencing_damaged_02_214", "fencing_damaged_02_213", "fencing_damaged_02_212"} },
                           { stage = 3, tiles = {"fencing_damaged_02_223", "fencing_damaged_02_222", "fencing_damaged_02_221", "fencing_damaged_02_220"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_02_226", "fencing_damaged_02_224", "fencing_damaged_02_227", "fencing_damaged_02_225", "fencing_damaged_02_228", "fencing_damaged_02_229"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_60", "fencing_01_58", "fencing_01_59", "fencing_01_58"} },
                           { stage = 1, tiles = {"fencing_damaged_02_211", "fencing_damaged_02_210", "fencing_damaged_02_209", "fencing_damaged_02_208"} },
                           { stage = 2, tiles = {"fencing_damaged_02_215", "fencing_damaged_02_214", "fencing_damaged_02_213", "fencing_damaged_02_212"} },
                           { stage = 3, tiles = {"fencing_damaged_02_223", "fencing_damaged_02_222", "fencing_damaged_02_221", "fencing_damaged_02_220"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_02_226", "fencing_damaged_02_224", "fencing_damaged_02_227", "fencing_damaged_02_225", "fencing_damaged_02_228", "fencing_damaged_02_229"},
});

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3 tile wooden straight fence

local debrisTilesWoodStraightFence = {
  "fencing_damaged_01_128",
  "fencing_damaged_01_129",
  "fencing_damaged_01_130",
  "fencing_damaged_01_131",
  "fencing_damaged_03_120",
  "fencing_damaged_03_121",
  "fencing_damaged_03_122",
  "fencing_damaged_03_123",
};

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_72", "fencing_01_72", "fencing_01_72"} },
                           { stage = 1, tiles = {"fencing_damaged_03_13", "fencing_damaged_03_12", "fencing_damaged_03_11"} },
                           { stage = 2, tiles = {"fencing_damaged_01_21", "fencing_damaged_01_20", "fencing_damaged_01_19"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodStraightFence,
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_75", "fencing_01_72", "fencing_01_72"} },
                           { stage = 1, tiles = {"fencing_damaged_03_13", "fencing_damaged_03_12", "fencing_damaged_03_11"} },
                           { stage = 2, tiles = {"fencing_damaged_01_22", "fencing_damaged_01_20", "fencing_damaged_01_19"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodStraightFence,
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_72", "fencing_01_72", "fencing_01_72"} },
                           { stage = 1, tiles = {"fencing_damaged_03_13", "fencing_damaged_03_12", "fencing_damaged_03_11"} },
                           { stage = 2, tiles = {"fencing_damaged_01_21", "fencing_damaged_01_20", "fencing_damaged_01_19"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodStraightFence,
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_75", "fencing_01_72", "fencing_01_72"} },
                           { stage = 1, tiles = {"fencing_damaged_03_14", "fencing_damaged_03_12", "fencing_damaged_03_11"} },
                           { stage = 2, tiles = {"fencing_damaged_01_22", "fencing_damaged_01_20", "fencing_damaged_01_19"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodStraightFence,
});

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_73", "fencing_01_73", "fencing_01_73"} },
                           { stage = 1, tiles = {"fencing_damaged_03_8", "fencing_damaged_03_9", "fencing_damaged_03_10"} },
                           { stage = 2, tiles = {"fencing_damaged_01_16", "fencing_damaged_01_17", "fencing_damaged_01_18"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodStraightFence,
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_75", "fencing_01_73", "fencing_01_73"} },
                           { stage = 1, tiles = {"fencing_damaged_03_15", "fencing_damaged_03_9", "fencing_damaged_03_10"} },
                           { stage = 2, tiles = {"fencing_damaged_01_15", "fencing_damaged_01_17", "fencing_damaged_01_18"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodStraightFence,
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_73", "fencing_01_73", "fencing_01_73"} },
                           { stage = 1, tiles = {"fencing_damaged_03_8", "fencing_damaged_03_9", "fencing_damaged_03_10"} },
                           { stage = 2, tiles = {"fencing_damaged_01_16", "fencing_damaged_01_17", "fencing_damaged_01_18"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodStraightFence,
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_75", "fencing_01_73", "fencing_01_73"} },
                           { stage = 1, tiles = {"fencing_damaged_03_15", "fencing_damaged_03_9", "fencing_damaged_03_10"} },
                           { stage = 2, tiles = {"fencing_damaged_01_15", "fencing_damaged_01_17", "fencing_damaged_01_18"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodStraightFence,
});

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3 tile wooden curved fence

local debrisTilesWoodCurvedFence = debrisTilesWoodStraightFence;

-- bent west, no corner 1
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_10", "fencing_01_11", "fencing_01_10"} },
                           { stage = 1, tiles = {"fencing_damaged_03_53", "fencing_damaged_03_44", "fencing_damaged_03_51"} },
                           { stage = 2, tiles = {"fencing_damaged_01_77", "fencing_damaged_01_76", "fencing_damaged_01_75"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});


-- bent west, no corner 2
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_11", "fencing_01_10", "fencing_01_11"} },
                           { stage = 1, tiles = {"fencing_damaged_03_45", "fencing_damaged_03_44", "fencing_damaged_03_43"} },
                           { stage = 2, tiles = {"fencing_damaged_01_69", "fencing_damaged_01_68", "fencing_damaged_01_67"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_12", "fencing_01_10", "fencing_01_11"} },
                           { stage = 1, tiles = {"fencing_damaged_03_46", "fencing_damaged_03_44", "fencing_damaged_03_53"} },
                           { stage = 2, tiles = {"fencing_damaged_01_70", "fencing_damaged_01_76", "fencing_damaged_01_77"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent east, no corner 1
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_10", "fencing_01_11", "fencing_01_10"} },
                           { stage = 1, tiles = {"fencing_damaged_03_53", "fencing_damaged_03_44", "fencing_damaged_03_51"} },
                           { stage = 2, tiles = {"fencing_damaged_01_77", "fencing_damaged_01_76", "fencing_damaged_01_75"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent east, no corner 2
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_11", "fencing_01_10", "fencing_01_11"} },
                           { stage = 1, tiles = {"fencing_damaged_03_45", "fencing_damaged_03_44", "fencing_damaged_03_43"} },
                           { stage = 2, tiles = {"fencing_damaged_01_69", "fencing_damaged_01_68", "fencing_damaged_01_67"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_12", "fencing_01_10", "fencing_01_11"} },
                           { stage = 1, tiles = {"fencing_damaged_03_46", "fencing_damaged_03_44", "fencing_damaged_03_53"} },
                           { stage = 2, tiles = {"fencing_damaged_01_70", "fencing_damaged_01_76", "fencing_damaged_01_77"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent north, no corner 1
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_8", "fencing_01_9", "fencing_01_8"} },
                           { stage = 1, tiles = {"fencing_damaged_03_40", "fencing_damaged_03_41", "fencing_damaged_03_42"} },
                           { stage = 2, tiles = {"fencing_damaged_01_64", "fencing_damaged_01_73", "fencing_damaged_01_66"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent north, no corner 2
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_9", "fencing_01_8", "fencing_01_9"} },
                           { stage = 1, tiles = {"fencing_damaged_03_48", "fencing_damaged_03_49", "fencing_damaged_03_50"} },
                           { stage = 2, tiles = {"fencing_damaged_01_72", "fencing_damaged_01_73", "fencing_damaged_01_74"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});


-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_12", "fencing_01_9", "fencing_01_8"} },
                           { stage = 1, tiles = {"fencing_damaged_03_70", "fencing_damaged_03_41", "fencing_damaged_03_42"} },
                           { stage = 2, tiles = {"fencing_damaged_01_46", "fencing_damaged_01_73", "fencing_damaged_01_72"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent south, no corner 1
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_8", "fencing_01_9", "fencing_01_8"} },
                           { stage = 1, tiles = {"fencing_damaged_03_40", "fencing_damaged_03_41", "fencing_damaged_03_42"} },
                           { stage = 2, tiles = {"fencing_damaged_01_64", "fencing_damaged_01_73", "fencing_damaged_01_66"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent south, no corner 2
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_9", "fencing_01_8", "fencing_01_9"} },
                           { stage = 1, tiles = {"fencing_damaged_03_48", "fencing_damaged_03_49", "fencing_damaged_03_50"} },
                           { stage = 2, tiles = {"fencing_damaged_01_72", "fencing_damaged_01_73", "fencing_damaged_01_74"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_12", "fencing_01_9", "fencing_01_8"} },
                           { stage = 1, tiles = {"fencing_damaged_03_70", "fencing_damaged_03_41", "fencing_damaged_03_42"} },
                           { stage = 2, tiles = {"fencing_damaged_01_46", "fencing_damaged_01_73", "fencing_damaged_01_72"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3 tile concrete wall

local debrisTilesConcreteWall = {
    "fencing_damaged_01_132",
    "fencing_damaged_01_133",
    "fencing_damaged_01_134",
    "fencing_damaged_01_135",
    "fencing_damaged_03_124",
    "fencing_damaged_03_125",
    "fencing_damaged_03_126",
    "fencing_damaged_03_127",
};

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_40", "fencing_01_40", "fencing_01_40"} },
                           { stage = 1, tiles = {"fencing_damaged_03_21", "fencing_damaged_03_20", "fencing_damaged_03_19"} },
                           { stage = 2, tiles = {"fencing_damaged_01_29", "fencing_damaged_01_28", "fencing_damaged_01_27"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesConcreteWall,
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_42", "fencing_01_40", "fencing_01_40"} },
                           { stage = 1, tiles = {"fencing_damaged_03_21", "fencing_damaged_03_20", "fencing_damaged_03_19"} },
                           { stage = 2, tiles = {"fencing_damaged_01_29", "fencing_damaged_01_28", "fencing_damaged_01_27"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesConcreteWall,
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_40", "fencing_01_40", "fencing_01_40"} },
                           { stage = 1, tiles = {"fencing_damaged_03_21", "fencing_damaged_03_20", "fencing_damaged_03_19"} },
                           { stage = 2, tiles = {"fencing_damaged_01_29", "fencing_damaged_01_28", "fencing_damaged_01_27"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesConcreteWall,
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_42", "fencing_01_40", "fencing_01_40"} },
                           { stage = 1, tiles = {"fencing_damaged_03_21", "fencing_damaged_03_20", "fencing_damaged_03_19"} },
                           { stage = 2, tiles = {"fencing_damaged_01_29", "fencing_damaged_01_28", "fencing_damaged_01_27"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesConcreteWall,
});

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_41", "fencing_01_41", "fencing_01_41"} },
                           { stage = 1, tiles = {"fencing_damaged_03_16", "fencing_damaged_03_17", "fencing_damaged_03_18"} },
                           { stage = 2, tiles = {"fencing_damaged_01_24", "fencing_damaged_01_25", "fencing_damaged_01_26"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesConcreteWall,
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_42", "fencing_01_41", "fencing_01_41"} },
                           { stage = 1, tiles = {"fencing_damaged_03_16", "fencing_damaged_03_17", "fencing_damaged_03_18"} },
                           { stage = 2, tiles = {"fencing_damaged_01_24", "fencing_damaged_01_25", "fencing_damaged_01_26"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesConcreteWall,
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_41", "fencing_01_41", "fencing_01_41"} },
                           { stage = 1, tiles = {"fencing_damaged_03_16", "fencing_damaged_03_17", "fencing_damaged_03_18"} },
                           { stage = 2, tiles = {"fencing_damaged_01_24", "fencing_damaged_01_25", "fencing_damaged_01_26"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesConcreteWall,
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_42", "fencing_01_41", "fencing_01_41"} },
                           { stage = 1, tiles = {"fencing_damaged_03_16", "fencing_damaged_03_17", "fencing_damaged_03_18"} },
                           { stage = 2, tiles = {"fencing_damaged_01_24", "fencing_damaged_01_25", "fencing_damaged_01_26"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesConcreteWall,
});

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

BentFences.getInstance():addFenceTiles(VERSION, tiles)

--[[
                        { stage = 1, tiles = {"", "", "", "", "", ""} },
                        { stage = 2, tiles = {"", "", "", "", "", ""} },
                        { stage = 3, tiles = {"", "", "", "", "", ""} } },
          collapsed =   {"", "", "", "", "", ""},

]]--