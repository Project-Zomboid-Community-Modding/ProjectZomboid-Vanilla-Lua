ClutterTables = ClutterTables or {}

ClutterTables.TrunkItems = {
	-- Bags/Containers
	"Bag_BreakdownBag", 0.1,
	"Plasticbag_Bags", 8,
	"Tote_Bags", 2,
	-- Misc.
	"ToiletPaper", 2,
	"WaterBottle", 2,
	-- Tools/Materials
	"CarBatteryCharger", 0.1,
	"DuctTape", 4,
	"EmptySandbag", 4,
	"Garbagebag", 6,
	"Garbagebag_box", 0.1,
	"Jack", 2,
	"LugWrench", 4,
	"PetrolCanEmpty", 10,
	"Ratchet", 10,
	"Rope", 1,
	"RubberHose", 1,
	"Screwdriver", 10,
	"Tarp", 4,
	"TireIron", 4,
	"TirePump", 8,
	"Wrench", 8,
	-- Trash
	"BeerBottleEmpty", 1,
	"BeerCanEmpty", 2,
	"BeerImportedEmpty", 0.1,
	"BrandyEmpty", 0.05,
	"GinEmpty", 0.05,
	"Pop2Empty", 2,
	"Pop3Empty", 2,
	"PopBottleEmpty", 1,
	"PopBottleRareEmpty", 0.5,
	"PopEmpty", 2,
	"RumEmpty", 0.1,
	"ScotchEmpty", 0.05,
	--"SodaCanEmpty", 2,
	"TequilaEmpty", 0.1,
	"VodkaEmpty", 0.1,
	"WaterBottleEmpty", 1,
	"WhiskeyEmpty", 0.1,
	"Wine2OpenEmpty", 0.05,
	"WineOpenEmpty", 0.05,
	-- Trash
	"FountainCupEmpty", 4,
	"PaperNapkins2", 8,
	"Receipt", 4,
	"Straw2", 4,
	"Tissue", 4,
	-- Corpses
	"CorpseFemale", 0.001,
	"CorpseMale", 0.001,
}

ClutterTables.TrunkJunk = {
	rolls = 1,
	ignoreZombieDensity = true,
	items = ClutterTables.TrunkItems,
}