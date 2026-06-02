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

-- six tile bends, tall metal pole fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_64", "fencing_01_65", "fencing_01_64", "fencing_01_65", "fencing_01_64", "fencing_01_65"} },
                           { stage = 1, tiles = {"fencing_damaged_04_0", "fencing_damaged_04_1", "fencing_damaged_04_2", "fencing_damaged_04_3", "fencing_damaged_04_4", "fencing_damaged_04_5"} },
                           { stage = 2, tiles = {"fencing_damaged_04_64", "fencing_damaged_04_65", "fencing_damaged_04_66", "fencing_damaged_04_67", "fencing_damaged_04_68", "fencing_damaged_04_69"} },
                           { stage = 3, tiles = {"fencing_damaged_04_96", "fencing_damaged_04_97", "fencing_damaged_04_98", "fencing_damaged_04_99", "fencing_damaged_04_100", "fencing_damaged_04_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_04_113", "fencing_damaged_04_112", "fencing_damaged_04_117", "fencing_damaged_04_114", "fencing_damaged_04_116", "fencing_damaged_04_115"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_68", "fencing_01_65", "fencing_01_64", "fencing_01_65", "fencing_01_64", "fencing_01_65"} },
                           { stage = 1, tiles = {"fencing_damaged_04_0", "fencing_damaged_04_1", "fencing_damaged_04_2", "fencing_damaged_04_3", "fencing_damaged_04_4", "fencing_damaged_04_5"} },
                           { stage = 2, tiles = {"fencing_damaged_04_64", "fencing_damaged_04_65", "fencing_damaged_04_66", "fencing_damaged_04_67", "fencing_damaged_04_68", "fencing_damaged_04_69"} },
                           { stage = 3, tiles = {"fencing_damaged_04_96", "fencing_damaged_04_97", "fencing_damaged_04_98", "fencing_damaged_04_99", "fencing_damaged_04_100", "fencing_damaged_04_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_04_113", "fencing_damaged_04_112", "fencing_damaged_04_117", "fencing_damaged_04_114", "fencing_damaged_04_116", "fencing_damaged_04_115"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_64", "fencing_01_65", "fencing_01_64", "fencing_01_65", "fencing_01_64", "fencing_01_65"} },
                           { stage = 1, tiles = {"fencing_damaged_04_8", "fencing_damaged_04_9", "fencing_damaged_04_10", "fencing_damaged_04_11", "fencing_damaged_04_12", "fencing_damaged_04_13"} },
                           { stage = 2, tiles = {"fencing_damaged_04_48", "fencing_damaged_04_49", "fencing_damaged_04_50", "fencing_damaged_04_51", "fencing_damaged_04_52", "fencing_damaged_04_53"} },
                           { stage = 3, tiles = {"fencing_damaged_04_80", "fencing_damaged_04_81", "fencing_damaged_04_82", "fencing_damaged_04_83", "fencing_damaged_04_84", "fencing_damaged_04_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_04_139", "fencing_damaged_04_141", "fencing_damaged_04_136", "fencing_damaged_04_140", "fencing_damaged_04_138", "fencing_damaged_04_137"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_68", "fencing_01_65", "fencing_01_64", "fencing_01_65", "fencing_01_64", "fencing_01_65"} },
                           { stage = 1, tiles = {"fencing_damaged_04_8", "fencing_damaged_04_9", "fencing_damaged_04_10", "fencing_damaged_04_11", "fencing_damaged_04_12", "fencing_damaged_04_13"} },
                           { stage = 2, tiles = {"fencing_damaged_04_48", "fencing_damaged_04_49", "fencing_damaged_04_50", "fencing_damaged_04_51", "fencing_damaged_04_52", "fencing_damaged_04_53"} },
                           { stage = 3, tiles = {"fencing_damaged_04_80", "fencing_damaged_04_81", "fencing_damaged_04_82", "fencing_damaged_04_83", "fencing_damaged_04_84", "fencing_damaged_04_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_04_139", "fencing_damaged_04_141", "fencing_damaged_04_136", "fencing_damaged_04_140", "fencing_damaged_04_138", "fencing_damaged_04_137"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_67", "fencing_01_66", "fencing_01_67", "fencing_01_66", "fencing_01_67", "fencing_01_66"} },
                           { stage = 1, tiles = {"fencing_damaged_04_16", "fencing_damaged_04_17", "fencing_damaged_04_18", "fencing_damaged_04_19", "fencing_damaged_04_20", "fencing_damaged_04_21"} },
                           { stage = 2, tiles = {"fencing_damaged_04_61", "fencing_damaged_04_60", "fencing_damaged_04_59", "fencing_damaged_04_58", "fencing_damaged_04_57", "fencing_damaged_04_56"} },
                           { stage = 3, tiles = {"fencing_damaged_04_93", "fencing_damaged_04_92", "fencing_damaged_04_91", "fencing_damaged_04_90", "fencing_damaged_04_89", "fencing_damaged_04_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_04_132", "fencing_damaged_04_129", "fencing_damaged_04_131", "fencing_damaged_04_128", "fencing_damaged_04_130", "fencing_damaged_04_133"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_68", "fencing_01_66", "fencing_01_67", "fencing_01_66", "fencing_01_67", "fencing_01_66"} },
                           { stage = 1, tiles = {"fencing_damaged_04_16", "fencing_damaged_04_17", "fencing_damaged_04_18", "fencing_damaged_04_19", "fencing_damaged_04_20", "fencing_damaged_04_21"} },
                           { stage = 2, tiles = {"fencing_damaged_04_61", "fencing_damaged_04_60", "fencing_damaged_04_59", "fencing_damaged_04_58", "fencing_damaged_04_57", "fencing_damaged_04_56"} },
                           { stage = 3, tiles = {"fencing_damaged_04_93", "fencing_damaged_04_92", "fencing_damaged_04_91", "fencing_damaged_04_90", "fencing_damaged_04_89", "fencing_damaged_04_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_04_132", "fencing_damaged_04_129", "fencing_damaged_04_131", "fencing_damaged_04_128", "fencing_damaged_04_130", "fencing_damaged_04_133"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_67", "fencing_01_66", "fencing_01_67", "fencing_01_66", "fencing_01_67", "fencing_01_66"} },
                           { stage = 1, tiles = {"fencing_damaged_04_24", "fencing_damaged_04_25", "fencing_damaged_04_26", "fencing_damaged_04_27", "fencing_damaged_04_28", "fencing_damaged_04_29"} },
                           { stage = 2, tiles = {"fencing_damaged_04_45", "fencing_damaged_04_44", "fencing_damaged_04_43", "fencing_damaged_04_42", "fencing_damaged_04_41", "fencing_damaged_04_40"} },
                           { stage = 3, tiles = {"fencing_damaged_04_109", "fencing_damaged_04_108", "fencing_damaged_04_107", "fencing_damaged_04_106", "fencing_damaged_04_105", "fencing_damaged_04_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_04_125", "fencing_damaged_04_123", "fencing_damaged_04_124", "fencing_damaged_04_122", "fencing_damaged_04_121", "fencing_damaged_04_120"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_68", "fencing_01_66", "fencing_01_67", "fencing_01_66", "fencing_01_67", "fencing_01_66"} },
                           { stage = 1, tiles = {"fencing_damaged_04_24", "fencing_damaged_04_25", "fencing_damaged_04_26", "fencing_damaged_04_27", "fencing_damaged_04_28", "fencing_damaged_04_29"} },
                           { stage = 2, tiles = {"fencing_damaged_04_45", "fencing_damaged_04_44", "fencing_damaged_04_43", "fencing_damaged_04_42", "fencing_damaged_04_41", "fencing_damaged_04_40"} },
                           { stage = 3, tiles = {"fencing_damaged_04_109", "fencing_damaged_04_108", "fencing_damaged_04_107", "fencing_damaged_04_106", "fencing_damaged_04_105", "fencing_damaged_04_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_04_125", "fencing_damaged_04_123", "fencing_damaged_04_124", "fencing_damaged_04_122", "fencing_damaged_04_121", "fencing_damaged_04_120"},
});

--four tile bends, tall metal pole fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_64", "fencing_01_65", "fencing_01_64", "fencing_01_65"} },
                           { stage = 1, tiles = {"fencing_damaged_04_184", "fencing_damaged_04_185", "fencing_damaged_04_186", "fencing_damaged_04_187"} },
                           { stage = 2, tiles = {"fencing_damaged_04_192", "fencing_damaged_04_193", "fencing_damaged_04_194", "fencing_damaged_04_195"} },
                           { stage = 3, tiles = {"fencing_damaged_04_188", "fencing_damaged_04_189", "fencing_damaged_04_190", "fencing_damaged_04_191"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_04_200", "fencing_damaged_04_202", "fencing_damaged_04_204", "fencing_damaged_04_201", "fencing_damaged_04_205", "fencing_damaged_04_203"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_68", "fencing_01_65", "fencing_01_64", "fencing_01_65"} },
                           { stage = 1, tiles = {"fencing_damaged_04_184", "fencing_damaged_04_185", "fencing_damaged_04_186", "fencing_damaged_04_187"} },
                           { stage = 2, tiles = {"fencing_damaged_04_192", "fencing_damaged_04_193", "fencing_damaged_04_194", "fencing_damaged_04_195"} },
                           { stage = 3, tiles = {"fencing_damaged_04_188", "fencing_damaged_04_189", "fencing_damaged_04_190", "fencing_damaged_04_191"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_04_200", "fencing_damaged_04_202", "fencing_damaged_04_204", "fencing_damaged_04_201", "fencing_damaged_04_205", "fencing_damaged_04_203"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_64", "fencing_01_65", "fencing_01_64", "fencing_01_65"} },
                           { stage = 1, tiles = {"fencing_damaged_04_152", "fencing_damaged_04_153", "fencing_damaged_04_154", "fencing_damaged_04_155"} },
                           { stage = 2, tiles = {"fencing_damaged_04_164", "fencing_damaged_04_165", "fencing_damaged_04_166", "fencing_damaged_04_167"} },
                           { stage = 3, tiles = {"fencing_damaged_04_160", "fencing_damaged_04_161", "fencing_damaged_04_162", "fencing_damaged_04_163"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_04_147", "fencing_damaged_04_149", "fencing_damaged_04_145", "fencing_damaged_04_148", "fencing_damaged_04_146", "fencing_damaged_04_144"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_68", "fencing_01_65", "fencing_01_64", "fencing_01_65"} },
                           { stage = 1, tiles = {"fencing_damaged_04_152", "fencing_damaged_04_153", "fencing_damaged_04_154", "fencing_damaged_04_155"} },
                           { stage = 2, tiles = {"fencing_damaged_04_164", "fencing_damaged_04_165", "fencing_damaged_04_166", "fencing_damaged_04_167"} },
                           { stage = 3, tiles = {"fencing_damaged_04_160", "fencing_damaged_04_161", "fencing_damaged_04_162", "fencing_damaged_04_163"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_04_147", "fencing_damaged_04_149", "fencing_damaged_04_145", "fencing_damaged_04_148", "fencing_damaged_04_146", "fencing_damaged_04_144"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_67", "fencing_01_66", "fencing_01_67", "fencing_01_66"} },
                           { stage = 1, tiles = {"fencing_damaged_04_159", "fencing_damaged_04_158", "fencing_damaged_04_157", "fencing_damaged_04_156"} },
                           { stage = 2, tiles = {"fencing_damaged_04_175", "fencing_damaged_04_174", "fencing_damaged_04_173", "fencing_damaged_04_172"} },
                           { stage = 3, tiles = {"fencing_damaged_04_171", "fencing_damaged_04_170", "fencing_damaged_04_169", "fencing_damaged_04_168"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_04_179", "fencing_damaged_04_177", "fencing_damaged_04_180", "fencing_damaged_04_176", "fencing_damaged_04_181", "fencing_damaged_04_178"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_68", "fencing_01_66", "fencing_01_67", "fencing_01_66"} },
                           { stage = 1, tiles = {"fencing_damaged_04_159", "fencing_damaged_04_158", "fencing_damaged_04_157", "fencing_damaged_04_156"} },
                           { stage = 2, tiles = {"fencing_damaged_04_175", "fencing_damaged_04_174", "fencing_damaged_04_173", "fencing_damaged_04_172"} },
                           { stage = 3, tiles = {"fencing_damaged_04_171", "fencing_damaged_04_170", "fencing_damaged_04_169", "fencing_damaged_04_168"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_04_179", "fencing_damaged_04_177", "fencing_damaged_04_180", "fencing_damaged_04_176", "fencing_damaged_04_181", "fencing_damaged_04_178"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_67", "fencing_01_66", "fencing_01_67", "fencing_01_66"} },
                           { stage = 1, tiles = {"fencing_damaged_04_211", "fencing_damaged_04_210", "fencing_damaged_04_209", "fencing_damaged_04_208"} },
                           { stage = 2, tiles = {"fencing_damaged_04_215", "fencing_damaged_04_214", "fencing_damaged_04_213", "fencing_damaged_04_212"} },
                           { stage = 3, tiles = {"fencing_damaged_04_223", "fencing_damaged_04_222", "fencing_damaged_04_221", "fencing_damaged_04_220"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_04_226", "fencing_damaged_04_224", "fencing_damaged_04_227", "fencing_damaged_04_225", "fencing_damaged_04_228", "fencing_damaged_04_229"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_68", "fencing_01_66", "fencing_01_67", "fencing_01_66"} },
                           { stage = 1, tiles = {"fencing_damaged_04_211", "fencing_damaged_04_210", "fencing_damaged_04_209", "fencing_damaged_04_208"} },
                           { stage = 2, tiles = {"fencing_damaged_04_215", "fencing_damaged_04_214", "fencing_damaged_04_213", "fencing_damaged_04_212"} },
                           { stage = 3, tiles = {"fencing_damaged_04_223", "fencing_damaged_04_222", "fencing_damaged_04_221", "fencing_damaged_04_220"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_04_226", "fencing_damaged_04_224", "fencing_damaged_04_227", "fencing_damaged_04_225", "fencing_damaged_04_228", "fencing_damaged_04_229"},
});


-- six tile bends, tall metal divider fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_0", "fencing_damaged_05_1", "fencing_damaged_05_2", "fencing_damaged_05_3", "fencing_damaged_05_4", "fencing_damaged_05_5"} },
                           { stage = 2, tiles = {"fencing_damaged_05_64", "fencing_damaged_05_65", "fencing_damaged_05_66", "fencing_damaged_05_67", "fencing_damaged_05_68", "fencing_damaged_05_69"} },
                           { stage = 3, tiles = {"fencing_damaged_05_96", "fencing_damaged_05_97", "fencing_damaged_05_98", "fencing_damaged_05_99", "fencing_damaged_05_100", "fencing_damaged_05_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_113", "fencing_damaged_05_112", "fencing_damaged_05_117", "fencing_damaged_05_114", "fencing_damaged_05_116", "fencing_damaged_05_115"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_81", "fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_0", "fencing_damaged_05_1", "fencing_damaged_05_2", "fencing_damaged_05_3", "fencing_damaged_05_4", "fencing_damaged_05_5"} },
                           { stage = 2, tiles = {"fencing_damaged_05_64", "fencing_damaged_05_65", "fencing_damaged_05_66", "fencing_damaged_05_67", "fencing_damaged_05_68", "fencing_damaged_05_69"} },
                           { stage = 3, tiles = {"fencing_damaged_05_96", "fencing_damaged_05_97", "fencing_damaged_05_98", "fencing_damaged_05_99", "fencing_damaged_05_100", "fencing_damaged_05_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_113", "fencing_damaged_05_112", "fencing_damaged_05_117", "fencing_damaged_05_114", "fencing_damaged_05_116", "fencing_damaged_05_115"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_8", "fencing_damaged_05_9", "fencing_damaged_05_10", "fencing_damaged_05_11", "fencing_damaged_05_12", "fencing_damaged_05_13"} },
                           { stage = 2, tiles = {"fencing_damaged_05_48", "fencing_damaged_05_49", "fencing_damaged_05_50", "fencing_damaged_05_51", "fencing_damaged_05_52", "fencing_damaged_05_53"} },
                           { stage = 3, tiles = {"fencing_damaged_05_80", "fencing_damaged_05_81", "fencing_damaged_05_82", "fencing_damaged_05_83", "fencing_damaged_05_84", "fencing_damaged_05_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_139", "fencing_damaged_05_141", "fencing_damaged_05_136", "fencing_damaged_05_140", "fencing_damaged_05_138", "fencing_damaged_05_137"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_81", "fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_8", "fencing_damaged_05_9", "fencing_damaged_05_10", "fencing_damaged_05_11", "fencing_damaged_05_12", "fencing_damaged_05_13"} },
                           { stage = 2, tiles = {"fencing_damaged_05_48", "fencing_damaged_05_49", "fencing_damaged_05_50", "fencing_damaged_05_51", "fencing_damaged_05_52", "fencing_damaged_05_53"} },
                           { stage = 3, tiles = {"fencing_damaged_05_80", "fencing_damaged_05_81", "fencing_damaged_05_82", "fencing_damaged_05_83", "fencing_damaged_05_84", "fencing_damaged_05_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_139", "fencing_damaged_05_141", "fencing_damaged_05_136", "fencing_damaged_05_140", "fencing_damaged_05_138", "fencing_damaged_05_137"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_16", "fencing_damaged_05_17", "fencing_damaged_05_18", "fencing_damaged_05_19", "fencing_damaged_05_20", "fencing_damaged_05_21"} },
                           { stage = 2, tiles = {"fencing_damaged_05_61", "fencing_damaged_05_60", "fencing_damaged_05_59", "fencing_damaged_05_58", "fencing_damaged_05_57", "fencing_damaged_05_56"} },
                           { stage = 3, tiles = {"fencing_damaged_05_93", "fencing_damaged_05_92", "fencing_damaged_05_91", "fencing_damaged_05_90", "fencing_damaged_05_89", "fencing_damaged_05_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_132", "fencing_damaged_05_129", "fencing_damaged_05_131", "fencing_damaged_05_128", "fencing_damaged_05_130", "fencing_damaged_05_133"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_82", "fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_16", "fencing_damaged_05_17", "fencing_damaged_05_18", "fencing_damaged_05_19", "fencing_damaged_05_20", "fencing_damaged_05_21"} },
                           { stage = 2, tiles = {"fencing_damaged_05_61", "fencing_damaged_05_60", "fencing_damaged_05_59", "fencing_damaged_05_58", "fencing_damaged_05_57", "fencing_damaged_05_56"} },
                           { stage = 3, tiles = {"fencing_damaged_05_93", "fencing_damaged_05_92", "fencing_damaged_05_91", "fencing_damaged_05_90", "fencing_damaged_05_89", "fencing_damaged_05_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_132", "fencing_damaged_05_129", "fencing_damaged_05_131", "fencing_damaged_05_128", "fencing_damaged_05_130", "fencing_damaged_05_133"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_24", "fencing_damaged_05_25", "fencing_damaged_05_26", "fencing_damaged_05_27", "fencing_damaged_05_28", "fencing_damaged_05_29"} },
                           { stage = 2, tiles = {"fencing_damaged_05_45", "fencing_damaged_05_44", "fencing_damaged_05_43", "fencing_damaged_05_42", "fencing_damaged_05_41", "fencing_damaged_05_40"} },
                           { stage = 3, tiles = {"fencing_damaged_05_109", "fencing_damaged_05_108", "fencing_damaged_05_107", "fencing_damaged_05_106", "fencing_damaged_05_105", "fencing_damaged_05_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_125", "fencing_damaged_05_123", "fencing_damaged_05_124", "fencing_damaged_05_122", "fencing_damaged_05_121", "fencing_damaged_05_120"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_82", "fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_24", "fencing_damaged_05_25", "fencing_damaged_05_26", "fencing_damaged_05_27", "fencing_damaged_05_28", "fencing_damaged_05_29"} },
                           { stage = 2, tiles = {"fencing_damaged_05_45", "fencing_damaged_05_44", "fencing_damaged_05_43", "fencing_damaged_05_42", "fencing_damaged_05_41", "fencing_damaged_05_40"} },
                           { stage = 3, tiles = {"fencing_damaged_05_109", "fencing_damaged_05_108", "fencing_damaged_05_107", "fencing_damaged_05_106", "fencing_damaged_05_105", "fencing_damaged_05_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_125", "fencing_damaged_05_123", "fencing_damaged_05_124", "fencing_damaged_05_122", "fencing_damaged_05_121", "fencing_damaged_05_120"},
});

--four tile bends, tall metal divider fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_184", "fencing_damaged_05_185", "fencing_damaged_05_186", "fencing_damaged_05_187"} },
                           { stage = 2, tiles = {"fencing_damaged_05_192", "fencing_damaged_05_193", "fencing_damaged_05_194", "fencing_damaged_05_195"} },
                           { stage = 3, tiles = {"fencing_damaged_05_188", "fencing_damaged_05_189", "fencing_damaged_05_190", "fencing_damaged_05_191"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_200", "fencing_damaged_05_202", "fencing_damaged_05_204", "fencing_damaged_05_201", "fencing_damaged_05_205", "fencing_damaged_05_203"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_184", "fencing_damaged_05_185", "fencing_damaged_05_186", "fencing_damaged_05_187"} },
                           { stage = 2, tiles = {"fencing_damaged_05_192", "fencing_damaged_05_193", "fencing_damaged_05_194", "fencing_damaged_05_195"} },
                           { stage = 3, tiles = {"fencing_damaged_05_188", "fencing_damaged_05_189", "fencing_damaged_05_190", "fencing_damaged_05_191"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_200", "fencing_damaged_05_202", "fencing_damaged_05_204", "fencing_damaged_05_201", "fencing_damaged_05_205", "fencing_damaged_05_203"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_152", "fencing_damaged_05_153", "fencing_damaged_05_154", "fencing_damaged_05_155"} },
                           { stage = 2, tiles = {"fencing_damaged_05_164", "fencing_damaged_05_165", "fencing_damaged_05_166", "fencing_damaged_05_167"} },
                           { stage = 3, tiles = {"fencing_damaged_05_160", "fencing_damaged_05_161", "fencing_damaged_05_162", "fencing_damaged_05_163"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_147", "fencing_damaged_05_149", "fencing_damaged_05_145", "fencing_damaged_05_148", "fencing_damaged_05_146", "fencing_damaged_05_144"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_152", "fencing_damaged_05_153", "fencing_damaged_05_154", "fencing_damaged_05_155"} },
                           { stage = 2, tiles = {"fencing_damaged_05_164", "fencing_damaged_05_165", "fencing_damaged_05_166", "fencing_damaged_05_167"} },
                           { stage = 3, tiles = {"fencing_damaged_05_160", "fencing_damaged_05_161", "fencing_damaged_05_162", "fencing_damaged_05_163"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_147", "fencing_damaged_05_149", "fencing_damaged_05_145", "fencing_damaged_05_148", "fencing_damaged_05_146", "fencing_damaged_05_144"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_159", "fencing_damaged_05_158", "fencing_damaged_05_157", "fencing_damaged_05_156"} },
                           { stage = 2, tiles = {"fencing_damaged_05_175", "fencing_damaged_05_174", "fencing_damaged_05_173", "fencing_damaged_05_172"} },
                           { stage = 3, tiles = {"fencing_damaged_05_171", "fencing_damaged_05_170", "fencing_damaged_05_169", "fencing_damaged_05_168"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_180", "fencing_damaged_05_176", "fencing_damaged_05_179", "fencing_damaged_05_178", "fencing_damaged_05_177", "fencing_damaged_05_181"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_159", "fencing_damaged_05_158", "fencing_damaged_05_157", "fencing_damaged_05_156"} },
                           { stage = 2, tiles = {"fencing_damaged_05_175", "fencing_damaged_05_174", "fencing_damaged_05_173", "fencing_damaged_05_172"} },
                           { stage = 3, tiles = {"fencing_damaged_05_171", "fencing_damaged_05_170", "fencing_damaged_05_169", "fencing_damaged_05_168"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_180", "fencing_damaged_05_176", "fencing_damaged_05_179", "fencing_damaged_05_178", "fencing_damaged_05_177", "fencing_damaged_05_181"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_211", "fencing_damaged_05_210", "fencing_damaged_05_209", "fencing_damaged_05_208"} },
                           { stage = 2, tiles = {"fencing_damaged_05_215", "fencing_damaged_05_214", "fencing_damaged_05_213", "fencing_damaged_05_212"} },
                           { stage = 3, tiles = {"fencing_damaged_05_223", "fencing_damaged_05_222", "fencing_damaged_05_221", "fencing_damaged_05_220"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_224", "fencing_damaged_05_225", "fencing_damaged_05_228", "fencing_damaged_05_229", "fencing_damaged_05_227", "fencing_damaged_05_226"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_211", "fencing_damaged_05_210", "fencing_damaged_05_209", "fencing_damaged_05_208"} },
                           { stage = 2, tiles = {"fencing_damaged_05_215", "fencing_damaged_05_214", "fencing_damaged_05_213", "fencing_damaged_05_212"} },
                           { stage = 3, tiles = {"fencing_damaged_05_223", "fencing_damaged_05_222", "fencing_damaged_05_221", "fencing_damaged_05_220"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_224", "fencing_damaged_05_225", "fencing_damaged_05_228", "fencing_damaged_05_229", "fencing_damaged_05_227", "fencing_damaged_05_226"},
});


-- six tile bends, tall metal divider fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_0", "fencing_damaged_05_1", "fencing_damaged_05_2", "fencing_damaged_05_3", "fencing_damaged_05_4", "fencing_damaged_05_5"} },
                           { stage = 2, tiles = {"fencing_damaged_05_64", "fencing_damaged_05_65", "fencing_damaged_05_66", "fencing_damaged_05_67", "fencing_damaged_05_68", "fencing_damaged_05_69"} },
                           { stage = 3, tiles = {"fencing_damaged_05_96", "fencing_damaged_05_97", "fencing_damaged_05_98", "fencing_damaged_05_99", "fencing_damaged_05_100", "fencing_damaged_05_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_113", "fencing_damaged_05_112", "fencing_damaged_05_117", "fencing_damaged_05_114", "fencing_damaged_05_116", "fencing_damaged_05_115"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_81", "fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_0", "fencing_damaged_05_1", "fencing_damaged_05_2", "fencing_damaged_05_3", "fencing_damaged_05_4", "fencing_damaged_05_5"} },
                           { stage = 2, tiles = {"fencing_damaged_05_64", "fencing_damaged_05_65", "fencing_damaged_05_66", "fencing_damaged_05_67", "fencing_damaged_05_68", "fencing_damaged_05_69"} },
                           { stage = 3, tiles = {"fencing_damaged_05_96", "fencing_damaged_05_97", "fencing_damaged_05_98", "fencing_damaged_05_99", "fencing_damaged_05_100", "fencing_damaged_05_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_113", "fencing_damaged_05_112", "fencing_damaged_05_117", "fencing_damaged_05_114", "fencing_damaged_05_116", "fencing_damaged_05_115"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_8", "fencing_damaged_05_9", "fencing_damaged_05_10", "fencing_damaged_05_11", "fencing_damaged_05_12", "fencing_damaged_05_13"} },
                           { stage = 2, tiles = {"fencing_damaged_05_48", "fencing_damaged_05_49", "fencing_damaged_05_50", "fencing_damaged_05_51", "fencing_damaged_05_52", "fencing_damaged_05_53"} },
                           { stage = 3, tiles = {"fencing_damaged_05_80", "fencing_damaged_05_81", "fencing_damaged_05_82", "fencing_damaged_05_83", "fencing_damaged_05_84", "fencing_damaged_05_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_139", "fencing_damaged_05_141", "fencing_damaged_05_136", "fencing_damaged_05_140", "fencing_damaged_05_138", "fencing_damaged_05_137"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_81", "fencing_01_80", "fencing_01_81", "fencing_01_80", "fencing_01_81"} },
                           { stage = 1, tiles = {"fencing_damaged_05_8", "fencing_damaged_05_9", "fencing_damaged_05_10", "fencing_damaged_05_11", "fencing_damaged_05_12", "fencing_damaged_05_13"} },
                           { stage = 2, tiles = {"fencing_damaged_05_48", "fencing_damaged_05_49", "fencing_damaged_05_50", "fencing_damaged_05_51", "fencing_damaged_05_52", "fencing_damaged_05_53"} },
                           { stage = 3, tiles = {"fencing_damaged_05_80", "fencing_damaged_05_81", "fencing_damaged_05_82", "fencing_damaged_05_83", "fencing_damaged_05_84", "fencing_damaged_05_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_05_139", "fencing_damaged_05_141", "fencing_damaged_05_136", "fencing_damaged_05_140", "fencing_damaged_05_138", "fencing_damaged_05_137"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_16", "fencing_damaged_05_17", "fencing_damaged_05_18", "fencing_damaged_05_19", "fencing_damaged_05_20", "fencing_damaged_05_21"} },
                           { stage = 2, tiles = {"fencing_damaged_05_61", "fencing_damaged_05_60", "fencing_damaged_05_59", "fencing_damaged_05_58", "fencing_damaged_05_57", "fencing_damaged_05_56"} },
                           { stage = 3, tiles = {"fencing_damaged_05_93", "fencing_damaged_05_92", "fencing_damaged_05_91", "fencing_damaged_05_90", "fencing_damaged_05_89", "fencing_damaged_05_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_132", "fencing_damaged_05_129", "fencing_damaged_05_131", "fencing_damaged_05_128", "fencing_damaged_05_130", "fencing_damaged_05_133"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_82", "fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_16", "fencing_damaged_05_17", "fencing_damaged_05_18", "fencing_damaged_05_19", "fencing_damaged_05_20", "fencing_damaged_05_21"} },
                           { stage = 2, tiles = {"fencing_damaged_05_61", "fencing_damaged_05_60", "fencing_damaged_05_59", "fencing_damaged_05_58", "fencing_damaged_05_57", "fencing_damaged_05_56"} },
                           { stage = 3, tiles = {"fencing_damaged_05_93", "fencing_damaged_05_92", "fencing_damaged_05_91", "fencing_damaged_05_90", "fencing_damaged_05_89", "fencing_damaged_05_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_132", "fencing_damaged_05_129", "fencing_damaged_05_131", "fencing_damaged_05_128", "fencing_damaged_05_130", "fencing_damaged_05_133"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_24", "fencing_damaged_05_25", "fencing_damaged_05_26", "fencing_damaged_05_27", "fencing_damaged_05_28", "fencing_damaged_05_29"} },
                           { stage = 2, tiles = {"fencing_damaged_05_45", "fencing_damaged_05_44", "fencing_damaged_05_43", "fencing_damaged_05_42", "fencing_damaged_05_41", "fencing_damaged_05_40"} },
                           { stage = 3, tiles = {"fencing_damaged_05_109", "fencing_damaged_05_108", "fencing_damaged_05_107", "fencing_damaged_05_106", "fencing_damaged_05_105", "fencing_damaged_05_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_125", "fencing_damaged_05_123", "fencing_damaged_05_124", "fencing_damaged_05_122", "fencing_damaged_05_121", "fencing_damaged_05_120"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_84", "fencing_01_82", "fencing_01_83", "fencing_01_82", "fencing_01_83", "fencing_01_82"} },
                           { stage = 1, tiles = {"fencing_damaged_05_24", "fencing_damaged_05_25", "fencing_damaged_05_26", "fencing_damaged_05_27", "fencing_damaged_05_28", "fencing_damaged_05_29"} },
                           { stage = 2, tiles = {"fencing_damaged_05_45", "fencing_damaged_05_44", "fencing_damaged_05_43", "fencing_damaged_05_42", "fencing_damaged_05_41", "fencing_damaged_05_40"} },
                           { stage = 3, tiles = {"fencing_damaged_05_109", "fencing_damaged_05_108", "fencing_damaged_05_107", "fencing_damaged_05_106", "fencing_damaged_05_105", "fencing_damaged_05_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_05_125", "fencing_damaged_05_123", "fencing_damaged_05_124", "fencing_damaged_05_122", "fencing_damaged_05_121", "fencing_damaged_05_120"},
});

-- six tile bends, tall barbed metal divider fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_88", "fencing_01_89", "fencing_01_88", "fencing_01_89", "fencing_01_88", "fencing_01_89"} },
                           { stage = 1, tiles = {"fencing_damaged_06_0", "fencing_damaged_06_1", "fencing_damaged_06_2", "fencing_damaged_06_3", "fencing_damaged_06_4", "fencing_damaged_06_5"} },
                           { stage = 2, tiles = {"fencing_damaged_06_64", "fencing_damaged_06_65", "fencing_damaged_06_66", "fencing_damaged_06_67", "fencing_damaged_06_68", "fencing_damaged_06_69"} },
                           { stage = 3, tiles = {"fencing_damaged_06_96", "fencing_damaged_06_97", "fencing_damaged_06_98", "fencing_damaged_06_99", "fencing_damaged_06_100", "fencing_damaged_06_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_06_113", "fencing_damaged_06_112", "fencing_damaged_06_117", "fencing_damaged_06_114", "fencing_damaged_06_116", "fencing_damaged_06_115"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_92", "fencing_01_89", "fencing_01_88", "fencing_01_89", "fencing_01_88", "fencing_01_89"} },
                           { stage = 1, tiles = {"fencing_damaged_06_0", "fencing_damaged_06_1", "fencing_damaged_06_2", "fencing_damaged_06_3", "fencing_damaged_06_4", "fencing_damaged_06_5"} },
                           { stage = 2, tiles = {"fencing_damaged_06_64", "fencing_damaged_06_65", "fencing_damaged_06_66", "fencing_damaged_06_67", "fencing_damaged_06_68", "fencing_damaged_06_69"} },
                           { stage = 3, tiles = {"fencing_damaged_06_96", "fencing_damaged_06_97", "fencing_damaged_06_98", "fencing_damaged_06_99", "fencing_damaged_06_100", "fencing_damaged_06_101"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_06_113", "fencing_damaged_06_112", "fencing_damaged_06_117", "fencing_damaged_06_114", "fencing_damaged_06_116", "fencing_damaged_06_115"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_88", "fencing_01_89", "fencing_01_88", "fencing_01_89", "fencing_01_88", "fencing_01_89"} },
                           { stage = 1, tiles = {"fencing_damaged_06_8", "fencing_damaged_06_9", "fencing_damaged_06_10", "fencing_damaged_06_11", "fencing_damaged_06_12", "fencing_damaged_06_13"} },
                           { stage = 2, tiles = {"fencing_damaged_06_48", "fencing_damaged_06_49", "fencing_damaged_06_50", "fencing_damaged_06_51", "fencing_damaged_06_52", "fencing_damaged_06_53"} },
                           { stage = 3, tiles = {"fencing_damaged_06_80", "fencing_damaged_06_81", "fencing_damaged_06_82", "fencing_damaged_06_83", "fencing_damaged_06_84", "fencing_damaged_06_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_06_139", "fencing_damaged_06_141", "fencing_damaged_06_136", "fencing_damaged_06_140", "fencing_damaged_06_138", "fencing_damaged_06_137"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_92", "fencing_01_89", "fencing_01_88", "fencing_01_89", "fencing_01_88", "fencing_01_89"} },
                           { stage = 1, tiles = {"fencing_damaged_06_8", "fencing_damaged_06_9", "fencing_damaged_06_10", "fencing_damaged_06_11", "fencing_damaged_06_12", "fencing_damaged_06_13"} },
                           { stage = 2, tiles = {"fencing_damaged_06_48", "fencing_damaged_06_49", "fencing_damaged_06_50", "fencing_damaged_06_51", "fencing_damaged_06_52", "fencing_damaged_06_53"} },
                           { stage = 3, tiles = {"fencing_damaged_06_80", "fencing_damaged_06_81", "fencing_damaged_06_82", "fencing_damaged_06_83", "fencing_damaged_06_84", "fencing_damaged_06_85"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_06_139", "fencing_damaged_06_141", "fencing_damaged_06_136", "fencing_damaged_06_140", "fencing_damaged_06_138", "fencing_damaged_06_137"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_91", "fencing_01_90", "fencing_01_91", "fencing_01_90", "fencing_01_91", "fencing_01_90"} },
                           { stage = 1, tiles = {"fencing_damaged_06_16", "fencing_damaged_06_17", "fencing_damaged_06_18", "fencing_damaged_06_19", "fencing_damaged_06_20", "fencing_damaged_06_21"} },
                           { stage = 2, tiles = {"fencing_damaged_06_61", "fencing_damaged_06_60", "fencing_damaged_06_59", "fencing_damaged_06_58", "fencing_damaged_06_57", "fencing_damaged_06_56"} },
                           { stage = 3, tiles = {"fencing_damaged_06_93", "fencing_damaged_06_92", "fencing_damaged_06_91", "fencing_damaged_06_90", "fencing_damaged_06_89", "fencing_damaged_06_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_06_132", "fencing_damaged_06_129", "fencing_damaged_06_131", "fencing_damaged_06_128", "fencing_damaged_06_130", "fencing_damaged_06_133"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_92", "fencing_01_90", "fencing_01_91", "fencing_01_90", "fencing_01_91", "fencing_01_90"} },
                           { stage = 1, tiles = {"fencing_damaged_06_16", "fencing_damaged_06_17", "fencing_damaged_06_18", "fencing_damaged_06_19", "fencing_damaged_06_20", "fencing_damaged_06_21"} },
                           { stage = 2, tiles = {"fencing_damaged_06_61", "fencing_damaged_06_60", "fencing_damaged_06_59", "fencing_damaged_06_58", "fencing_damaged_06_57", "fencing_damaged_06_56"} },
                           { stage = 3, tiles = {"fencing_damaged_06_93", "fencing_damaged_06_92", "fencing_damaged_06_91", "fencing_damaged_06_90", "fencing_damaged_06_89", "fencing_damaged_06_88"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_06_132", "fencing_damaged_06_129", "fencing_damaged_06_131", "fencing_damaged_06_128", "fencing_damaged_06_130", "fencing_damaged_06_133"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_91", "fencing_01_90", "fencing_01_91", "fencing_01_90", "fencing_01_91", "fencing_01_90"} },
                           { stage = 1, tiles = {"fencing_damaged_06_24", "fencing_damaged_06_25", "fencing_damaged_06_26", "fencing_damaged_06_27", "fencing_damaged_06_28", "fencing_damaged_06_29"} },
                           { stage = 2, tiles = {"fencing_damaged_06_45", "fencing_damaged_06_44", "fencing_damaged_06_43", "fencing_damaged_06_42", "fencing_damaged_06_41", "fencing_damaged_06_40"} },
                           { stage = 3, tiles = {"fencing_damaged_06_109", "fencing_damaged_06_108", "fencing_damaged_06_107", "fencing_damaged_06_106", "fencing_damaged_06_105", "fencing_damaged_06_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_06_125", "fencing_damaged_06_123", "fencing_damaged_06_120", "fencing_damaged_06_124", "fencing_damaged_06_121", "fencing_damaged_06_122"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_92", "fencing_01_90", "fencing_01_91", "fencing_01_90", "fencing_01_91", "fencing_01_90"} },
                           { stage = 1, tiles = {"fencing_damaged_06_24", "fencing_damaged_06_25", "fencing_damaged_06_26", "fencing_damaged_06_27", "fencing_damaged_06_28", "fencing_damaged_06_29"} },
                           { stage = 2, tiles = {"fencing_damaged_06_45", "fencing_damaged_06_44", "fencing_damaged_06_43", "fencing_damaged_06_42", "fencing_damaged_06_41", "fencing_damaged_06_40"} },
                           { stage = 3, tiles = {"fencing_damaged_06_109", "fencing_damaged_06_108", "fencing_damaged_06_107", "fencing_damaged_06_106", "fencing_damaged_06_105", "fencing_damaged_06_104"} } },
    collapsedOffset   = 2,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_06_125", "fencing_damaged_06_123", "fencing_damaged_06_120", "fencing_damaged_06_124", "fencing_damaged_06_121", "fencing_damaged_06_122"},
});

--four tile bends, tall barbed metal divider fence

-- bent north, no corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_88", "fencing_01_89", "fencing_01_88", "fencing_01_89"} },
                           { stage = 1, tiles = {"fencing_damaged_06_184", "fencing_damaged_06_185", "fencing_damaged_06_186", "fencing_damaged_06_187"} },
                           { stage = 2, tiles = {"fencing_damaged_06_192", "fencing_damaged_06_193", "fencing_damaged_06_194", "fencing_damaged_06_195"} },
                           { stage = 3, tiles = {"fencing_damaged_06_188", "fencing_damaged_06_189", "fencing_damaged_06_190", "fencing_damaged_06_191"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_06_200", "fencing_damaged_06_202", "fencing_damaged_06_204", "fencing_damaged_06_201", "fencing_damaged_06_205", "fencing_damaged_06_203"},
});

-- bent north, corner
table.insert(tiles, {
    dir               = "N",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_92", "fencing_01_89", "fencing_01_88", "fencing_01_89"} },
                           { stage = 1, tiles = {"fencing_damaged_06_184", "fencing_damaged_06_185", "fencing_damaged_06_186", "fencing_damaged_06_187"} },
                           { stage = 2, tiles = {"fencing_damaged_06_192", "fencing_damaged_06_193", "fencing_damaged_06_194", "fencing_damaged_06_195"} },
                           { stage = 3, tiles = {"fencing_damaged_06_188", "fencing_damaged_06_189", "fencing_damaged_06_190", "fencing_damaged_06_191"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_06_200", "fencing_damaged_06_202", "fencing_damaged_06_204", "fencing_damaged_06_201", "fencing_damaged_06_205", "fencing_damaged_06_203"},
});

-- bent south, no corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_88", "fencing_01_89", "fencing_01_88", "fencing_01_89"} },
                           { stage = 1, tiles = {"fencing_damaged_06_152", "fencing_damaged_06_153", "fencing_damaged_06_154", "fencing_damaged_06_155"} },
                           { stage = 2, tiles = {"fencing_damaged_06_164", "fencing_damaged_06_165", "fencing_damaged_06_166", "fencing_damaged_06_167"} },
                           { stage = 3, tiles = {"fencing_damaged_06_160", "fencing_damaged_06_161", "fencing_damaged_06_162", "fencing_damaged_06_163"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_06_147", "fencing_damaged_06_149", "fencing_damaged_06_145", "fencing_damaged_06_148", "fencing_damaged_06_146", "fencing_damaged_06_144"},
});

-- bent south, corner
table.insert(tiles, {
    dir               = "S",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_92", "fencing_01_89", "fencing_01_88", "fencing_01_89"} },
                           { stage = 1, tiles = {"fencing_damaged_06_152", "fencing_damaged_06_153", "fencing_damaged_06_154", "fencing_damaged_06_155"} },
                           { stage = 2, tiles = {"fencing_damaged_06_164", "fencing_damaged_06_165", "fencing_damaged_06_166", "fencing_damaged_06_167"} },
                           { stage = 3, tiles = {"fencing_damaged_06_160", "fencing_damaged_06_161", "fencing_damaged_06_162", "fencing_damaged_06_163"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 2,
    collapsedSizeY    = 3,
    collapsed         =   {"fencing_damaged_06_147", "fencing_damaged_06_149", "fencing_damaged_06_145", "fencing_damaged_06_148", "fencing_damaged_06_146", "fencing_damaged_06_144"},
});

-- bent west, no corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_91", "fencing_01_90", "fencing_01_91", "fencing_01_90"} },
                           { stage = 1, tiles = {"fencing_damaged_06_159", "fencing_damaged_06_158", "fencing_damaged_06_157", "fencing_damaged_06_156"} },
                           { stage = 2, tiles = {"fencing_damaged_06_175", "fencing_damaged_06_174", "fencing_damaged_06_173", "fencing_damaged_06_172"} },
                           { stage = 3, tiles = {"fencing_damaged_06_171", "fencing_damaged_06_170", "fencing_damaged_06_169", "fencing_damaged_06_168"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_06_180", "fencing_damaged_06_176", "fencing_damaged_06_179", "fencing_damaged_06_178", "fencing_damaged_06_177", "fencing_damaged_06_181"},
});

-- bent west, corner
table.insert(tiles, {
    dir               = "W",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_92", "fencing_01_90", "fencing_01_91", "fencing_01_90"} },
                           { stage = 1, tiles = {"fencing_damaged_06_159", "fencing_damaged_06_158", "fencing_damaged_06_157", "fencing_damaged_06_156"} },
                           { stage = 2, tiles = {"fencing_damaged_06_175", "fencing_damaged_06_174", "fencing_damaged_06_173", "fencing_damaged_06_172"} },
                           { stage = 3, tiles = {"fencing_damaged_06_171", "fencing_damaged_06_170", "fencing_damaged_06_169", "fencing_damaged_06_168"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_06_180", "fencing_damaged_06_176", "fencing_damaged_06_179", "fencing_damaged_06_178", "fencing_damaged_06_177", "fencing_damaged_06_181"},
});

-- bent east, no corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_91", "fencing_01_90", "fencing_01_91", "fencing_01_90"} },
                           { stage = 1, tiles = {"fencing_damaged_06_211", "fencing_damaged_06_210", "fencing_damaged_06_209", "fencing_damaged_06_208"} },
                           { stage = 2, tiles = {"fencing_damaged_06_215", "fencing_damaged_06_214", "fencing_damaged_06_213", "fencing_damaged_06_212"} },
                           { stage = 3, tiles = {"fencing_damaged_06_223", "fencing_damaged_06_222", "fencing_damaged_06_221", "fencing_damaged_06_220"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_06_224", "fencing_damaged_06_225", "fencing_damaged_06_228", "fencing_damaged_06_229", "fencing_damaged_06_227", "fencing_damaged_06_226"},
});

-- bent east, corner
table.insert(tiles, {
    dir               = "E",
    health            = 100,
    stages            =   {{ stage = 0, tiles = {"fencing_01_92", "fencing_01_90", "fencing_01_91", "fencing_01_90"} },
                           { stage = 1, tiles = {"fencing_damaged_06_211", "fencing_damaged_06_210", "fencing_damaged_06_209", "fencing_damaged_06_208"} },
                           { stage = 2, tiles = {"fencing_damaged_06_215", "fencing_damaged_06_214", "fencing_damaged_06_213", "fencing_damaged_06_212"} },
                           { stage = 3, tiles = {"fencing_damaged_06_223", "fencing_damaged_06_222", "fencing_damaged_06_221", "fencing_damaged_06_220"} } },
    collapsedOffset   = 1,
    collapsedSizeX    = 3,
    collapsedSizeY    = 2,
    collapsed         =   {"fencing_damaged_06_224", "fencing_damaged_06_225", "fencing_damaged_06_228", "fencing_damaged_06_229", "fencing_damaged_06_227", "fencing_damaged_06_226"},
});


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
                           { stage = 1, tiles = {"fencing_damaged_03_45", "fencing_damaged_03_44", "fencing_damaged_03_43"} },
                           { stage = 2, tiles = {"fencing_damaged_01_69", "fencing_damaged_01_68", "fencing_damaged_01_67"} } },
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
                           { stage = 1, tiles = {"fencing_damaged_03_45", "fencing_damaged_03_44", "fencing_damaged_03_43"} },
                           { stage = 2, tiles = {"fencing_damaged_01_69", "fencing_damaged_01_68", "fencing_damaged_01_67"} } },
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
                           { stage = 1, tiles = {"fencing_damaged_03_40", "fencing_damaged_03_41", "fencing_damaged_03_42"} },
                           { stage = 2, tiles = {"fencing_damaged_01_64", "fencing_damaged_01_73", "fencing_damaged_01_66"} } },
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
                           { stage = 1, tiles = {"fencing_damaged_03_40", "fencing_damaged_03_41", "fencing_damaged_03_42"} },
                           { stage = 2, tiles = {"fencing_damaged_01_64", "fencing_damaged_01_73", "fencing_damaged_01_66"} } },
    doSmashCollapse   = false,
    debris            = debrisTilesWoodCurvedFence,
});

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

BentFences.getInstance():addFenceTiles(VERSION, tiles)

--[[
                        { stage = 1, tiles = {"", "", "", "", "", ""} },
                        { stage = 2, tiles = {"", "", "", "", "", ""} },
                        { stage = 3, tiles = {"", "", "", "", "", ""} } },
          collapsed =   {"", "", "", "", "", ""},

]]--
