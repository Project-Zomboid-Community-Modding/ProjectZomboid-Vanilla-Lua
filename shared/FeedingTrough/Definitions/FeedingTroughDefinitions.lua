--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

FeedingTroughDef = FeedingTroughDef or {};

FeedingTroughDef["doublemetal"] = {};
FeedingTroughDef["doublemetal"].spriteW = { "location_farm_accesories_01_34", "location_farm_accesories_01_35" };
FeedingTroughDef["doublemetal"].spriteN = { "location_farm_accesories_01_33", "location_farm_accesories_01_32" };
FeedingTroughDef["doublemetal"].planks = 4;
FeedingTroughDef["doublemetal"].nails = 8;
FeedingTroughDef["doublemetal"].skill = 4;
FeedingTroughDef["doublemetal"].maxFeed = 100; -- just used to calculate how full the feeding trough is to add an overlay
FeedingTroughDef["doublemetal"].maxWater = 100;
FeedingTroughDef["doublemetal"].spriteFoodOverlay1 = { location_farm_accesories_01_34 = "farm_01_50", location_farm_accesories_01_35 = "farm_01_51", location_farm_accesories_01_33 = "farm_01_49", location_farm_accesories_01_32 = "farm_01_48" };
FeedingTroughDef["doublemetal"].spriteFoodOverlay2 = { location_farm_accesories_01_34 = "farm_01_58", location_farm_accesories_01_35 = "farm_01_59", location_farm_accesories_01_33 = "farm_01_57", location_farm_accesories_01_32 = "farm_01_56" };
FeedingTroughDef["doublemetal"].spriteWaterOverlay1 = { location_farm_accesories_01_34 = "farm_01_26", location_farm_accesories_01_35 = "farm_01_27", location_farm_accesories_01_33 = "farm_01_25", location_farm_accesories_01_32 = "farm_01_24" };
FeedingTroughDef["doublemetal"].spriteWaterOverlay2 = { location_farm_accesories_01_34 = "farm_01_42", location_farm_accesories_01_35 = "farm_01_43", location_farm_accesories_01_33 = "farm_01_41", location_farm_accesories_01_32 = "farm_01_40" };

FeedingTroughDef["triplemetal"] = {};
FeedingTroughDef["triplemetal"].spriteW = { "location_farm_accesories_01_27", "location_farm_accesories_01_28", "location_farm_accesories_01_29" };
FeedingTroughDef["triplemetal"].spriteN = { "location_farm_accesories_01_26", "location_farm_accesories_01_25", "location_farm_accesories_01_24" };
FeedingTroughDef["triplemetal"].planks = 4;
FeedingTroughDef["triplemetal"].nails = 8;
FeedingTroughDef["triplemetal"].skill = 4;
FeedingTroughDef["triplemetal"].maxFeed = 150;
FeedingTroughDef["triplemetal"].maxWater = 150;
FeedingTroughDef["triplemetal"].spriteFoodOverlay1 = { location_farm_accesories_01_27 = "farm_01_99", location_farm_accesories_01_28 = "farm_01_100", location_farm_accesories_01_29 = "farm_01_101",
                                                        location_farm_accesories_01_26 = "farm_01_98", location_farm_accesories_01_25 = "farm_01_97", location_farm_accesories_01_24 = "farm_01_96" };
FeedingTroughDef["triplemetal"].spriteFoodOverlay2 = { location_farm_accesories_01_27 = "farm_01_67", location_farm_accesories_01_28 = "farm_01_68", location_farm_accesories_01_29 = "farm_01_69",
                                                        location_farm_accesories_01_26 = "farm_01_66", location_farm_accesories_01_25 = "farm_01_65", location_farm_accesories_01_24 = "farm_01_64" };
FeedingTroughDef["triplemetal"].spriteWaterOverlay1 = { location_farm_accesories_01_27 = "farm_01_19", location_farm_accesories_01_28 = "farm_01_20", location_farm_accesories_01_29 = "farm_01_21",
                                                        location_farm_accesories_01_26 = "farm_01_18", location_farm_accesories_01_25 = "farm_01_17", location_farm_accesories_01_24 = "farm_01_16" };
FeedingTroughDef["triplemetal"].spriteWaterOverlay2 = { location_farm_accesories_01_27 = "farm_01_35", location_farm_accesories_01_28 = "farm_01_36", location_farm_accesories_01_29 = "farm_01_37",
                                                        location_farm_accesories_01_26 = "farm_01_34", location_farm_accesories_01_25 = "farm_01_33", location_farm_accesories_01_24 = "farm_01_32" };

FeedingTroughDef["quadmetal"] = {};
FeedingTroughDef["quadmetal"].spriteW = { "location_farm_accesories_01_22", "location_farm_accesories_01_23", "location_farm_accesories_01_20", "location_farm_accesories_01_21" };
FeedingTroughDef["quadmetal"].spriteN = { "location_farm_accesories_01_17", "location_farm_accesories_01_16", "location_farm_accesories_01_19", "location_farm_accesories_01_18" };
FeedingTroughDef["quadmetal"].planks = 4;
FeedingTroughDef["quadmetal"].nails = 8;
FeedingTroughDef["quadmetal"].skill = 4;
FeedingTroughDef["quadmetal"].maxFeed = 200;
FeedingTroughDef["quadmetal"].maxWater = 100; -- not much water
FeedingTroughDef["quadmetal"].spriteFoodOverlay1 = { location_farm_accesories_01_16 = "farm_01_0", location_farm_accesories_01_17 = "farm_01_1", location_farm_accesories_01_18 = nil, location_farm_accesories_01_19 = "farm_01_3",
                                                     location_farm_accesories_01_22 = "farm_01_6", location_farm_accesories_01_23 = "farm_01_7", location_farm_accesories_01_20 = "farm_01_4", location_farm_accesories_01_21 = nil };
FeedingTroughDef["quadmetal"].spriteFoodOverlay2 = { location_farm_accesories_01_16 = "farm_01_8", location_farm_accesories_01_17 = "farm_01_9", location_farm_accesories_01_18 = nil, location_farm_accesories_01_19 = "farm_01_11",
                                                     location_farm_accesories_01_22 = "farm_01_14", location_farm_accesories_01_23 = "farm_01_15", location_farm_accesories_01_20 = "farm_01_12", location_farm_accesories_01_21 = nil };
FeedingTroughDef["quadmetal"].spriteWaterOverlay1 = { location_farm_accesories_01_16 = "farm_01_88", location_farm_accesories_01_17 = "farm_01_89", location_farm_accesories_01_18 = nil, location_farm_accesories_01_19 = "farm_01_91",
                                                     location_farm_accesories_01_22 = "farm_01_94", location_farm_accesories_01_23 = "farm_01_95", location_farm_accesories_01_20 = "farm_01_92", location_farm_accesories_01_21 = nil };
FeedingTroughDef["quadmetal"].spriteWaterOverlay2 = { location_farm_accesories_01_16 = "farm_01_80", location_farm_accesories_01_17 = "farm_01_81", location_farm_accesories_01_18 = nil, location_farm_accesories_01_19 = "farm_01_83",
                                                     location_farm_accesories_01_22 = "farm_01_86", location_farm_accesories_01_23 = "farm_01_87", location_farm_accesories_01_20 = "farm_01_84", location_farm_accesories_01_21 = nil };

FeedingTroughDef["double"] = {};
FeedingTroughDef["double"].spriteW = { "location_farm_accesories_01_4", "location_farm_accesories_01_5" };
FeedingTroughDef["double"].spriteN = { "location_farm_accesories_01_7", "location_farm_accesories_01_6" };
FeedingTroughDef["double"].planks = 4;
FeedingTroughDef["double"].nails = 8;
FeedingTroughDef["double"].skill = 4;
FeedingTroughDef["double"].maxFeed = 50; -- just used to calculate how full the feeding trough is to add an overlay
FeedingTroughDef["double"].maxWater = 50;
FeedingTroughDef["double"].spriteFoodOverlay1 = { location_farm_accesories_01_4 = "farm_01_44", location_farm_accesories_01_5 = "farm_01_45", location_farm_accesories_01_7 = "farm_01_47", location_farm_accesories_01_6 = "farm_01_46" };
FeedingTroughDef["double"].spriteFoodOverlay2 = { location_farm_accesories_01_4 = "farm_01_28", location_farm_accesories_01_5 = "farm_01_29", location_farm_accesories_01_7 = "farm_01_31", location_farm_accesories_01_6 = "farm_01_30" };
FeedingTroughDef["double"].spriteWaterOverlay1 = { location_farm_accesories_01_4 = "farm_01_76", location_farm_accesories_01_5 = "farm_01_77", location_farm_accesories_01_7 = "farm_01_79", location_farm_accesories_01_6 = "farm_01_78" };
FeedingTroughDef["double"].spriteWaterOverlay2 = { location_farm_accesories_01_4 = "farm_01_60", location_farm_accesories_01_5 = "farm_01_61", location_farm_accesories_01_7 = "farm_01_63", location_farm_accesories_01_6 = "farm_01_62" };

FeedingTroughDef["simple"] = {};
FeedingTroughDef["simple"].spriteW = { "location_farm_accesories_01_14" };
FeedingTroughDef["simple"].spriteN = { "location_farm_accesories_01_15" };
FeedingTroughDef["simple"].planks = 2;
FeedingTroughDef["simple"].nails = 4;
FeedingTroughDef["simple"].skill = 2;
FeedingTroughDef["simple"].maxFeed = 25;
FeedingTroughDef["simple"].maxWater = 50;
FeedingTroughDef["simple"].spriteFoodOverlay1 = { location_farm_accesories_01_14 = "farm_01_38", location_farm_accesories_01_15 = "farm_01_39" };
FeedingTroughDef["simple"].spriteFoodOverlay2 = { location_farm_accesories_01_14 = "farm_01_22", location_farm_accesories_01_15 = "farm_01_23" };
FeedingTroughDef["simple"].spriteWaterOverlay1 = { location_farm_accesories_01_14 = "farm_01_70", location_farm_accesories_01_15 = "farm_01_71" };
FeedingTroughDef["simple"].spriteWaterOverlay2 = { location_farm_accesories_01_14 = "farm_01_54", location_farm_accesories_01_15 = "farm_01_55" };
