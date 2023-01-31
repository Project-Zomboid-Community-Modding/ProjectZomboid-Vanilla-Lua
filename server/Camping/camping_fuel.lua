-- This is a list of all the item types and categories that can be burned in a fire.
-- The value is the number of hours of fuel added to a fire.
campingFuelType = {
    Charcoal = 0.5,
    Log = 6.0,
    PercedWood = 2.0,
    Plank = 2.0,
    RippedSheets = 5/60.0,
    RippedSheetsDirty = 5/60.0,
    Sheet = 15/60.0,
    SheetPaper = 5/60.0,
    WoodenStick = 0.25,
    TreeBranch = 1.0,
    UnusableWood = 1.4,
    Twigs = 0.25,
    ToiletPaper = 0.2,
    Pinecone = 0.5,
    GroceryBag1 = 1/60.0,
    GroceryBag2 = 1/60.0,
    GroceryBag3 = 1/60.0,
    GroceryBag4 = 1/60.0,
    Plasticbag = 1/60.0,
    Money = 5/60.0,
    CardDeck = 5/60.0,
    Paperbag_Spiffos = 5/60.0,
    PaperBag = 5/60.0,
    Paperbag_Jays = 5/60.0,
    Tissue = 2/60.0,
    PaperNapkins = 5/60.0,

}
-- For Clothing, only unequipped items with FabricType defined are allowed.
campingFuelCategory = {
    Clothing = 15/60.0,
    Literature = 15/60.0
}

-- Types of items that can be used with a lighter/matches to start a fire.
campingLightFireType = {
    RippedSheets = 5/60.0,
    RippedSheetsDirty = 5/60.0,
    Sheet = 15/60.0,
    SheetPaper = 5/60.0,
    Twigs = 15/60.0,
    ToiletPaper = 5/60.0,
    Money = 5/60.0,
    CardDeck = 5/60.0,
    Paperbag_Spiffos = 5/60.0,
    PaperBag = 5/60.0,
    Paperbag_Jays = 5/60.0,
    Plasticbag = 1/60.0,
    GroceryBag1 = 1/60.0,
    GroceryBag2 = 1/60.0,
    GroceryBag3 = 1/60.0,
    GroceryBag4 = 1/60.0,
    Tissue = 2/60.0,
    PaperNapkins = 5/60.0,
}
campingLightFireCategory = {
    Clothing = 15/60.0,
    Literature = 15/60.0,
}

--add the trash tiles to the burnable lists
local i = 0

while i < 54 do
	local trash = ("trash_01_" .. (tostring(i)))
	campingFuelType[trash]= 15.0/60
	campingLightFireType[trash]= 15.0/60
	i = i +1
	
end