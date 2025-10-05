ClothingRecipesDefinitions = {};

--ClothingRecipesDefinitions["Sheet"] = {materials="Base.RippedSheets:4" }

ClothingRecipesDefinitions["FabricType"] = {}
ClothingRecipesDefinitions["FabricType"]["Cotton"] = {};
ClothingRecipesDefinitions["FabricType"]["Cotton"].material = "Base.RippedSheets";
ClothingRecipesDefinitions["FabricType"]["Cotton"].materialDirty = "Base.RippedSheetsDirty";

ClothingRecipesDefinitions["FabricType"]["Denim"] = {};
ClothingRecipesDefinitions["FabricType"]["Denim"].material = "Base.DenimStrips";
ClothingRecipesDefinitions["FabricType"]["Denim"].materialDirty = "Base.DenimStripsDirty";
ClothingRecipesDefinitions["FabricType"]["Denim"].noSheetRope = true;

ClothingRecipesDefinitions["FabricType"]["Leather"] = {}
ClothingRecipesDefinitions["FabricType"]["Leather"].material = "Base.LeatherStrips";
ClothingRecipesDefinitions["FabricType"]["Leather"].materialDirty = "Base.LeatherStripsDirty";
ClothingRecipesDefinitions["FabricType"]["Leather"].noSheetRope = true;
