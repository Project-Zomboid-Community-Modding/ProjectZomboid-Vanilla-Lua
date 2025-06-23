-- This is a list of all the item types and categories that can be burned in a fire.
-- The value is the number of hours of fuel added to a fire.

-- NOTE: A lot of these values have been replaced by procedurally generated values for consistency/sanity
-- remaining items are for backup purposes for any cases that were missed

-- Items should use the "IsFireFuel" to dictate that an item can be used as fuel
-- The default value should be the item's weight * 2/3, but clothing, literature and maps default to  weight * 1/4
-- An item can have FireFuelRatio defined to set a custom multiplier that is applied to weight
-- And item that has a FireFueRatio is also considered to have the IsFireFuel tag

-- items that are already defined here are still valid, as a safety/backup, but the procedural fuel value calculations will use the lower of the value defined here or the procedurally calculated value
-- define or change an item's FireFuelRatio to change it's fuel value; this is the old system and shouldn't be continued to be used to define fire fuels or tinders
campingFuelType = {
    Charcoal = 0.5,
    CharcoalCrafted = 0.5,
    Log = 6.0,
    PercedWood = 2.0,
    Plank = 2.0,
    RippedSheets = 5/60.0,
    RippedSheetsDirty = 5/60.0,
    Sheet = 15/60.0,
    SheetPaper2 = 5/60.0,
    WoodenStick = 0.25,
    WoodenStick2 = 0.25,
    TreeBranch = 1.0,
    TreeBranch2 = 1.0,
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
    PaperNapkins2 = 5/60.0,
    Wallpaper_BeigeStripe = 0.25,
    Wallpaper_BlackFloral = 0.25,
    Wallpaper_BlueStripe = 0.25,
    Wallpaper_GreenDiamond = 0.25,
    Wallpaper_GreenFloral = 0.25,
    Wallpaper_PinkChevron = 0.25,
    Wallpaper_PinkFloral = 0.25,
    StockCertificate = 5/60.0,
    Paperwork = 5/60.0,
    IDcard = 5/120.0,
    IDcard_Female = 5/120.0,
    IDcard_Male = 5/120.0,
    Photo_Old = 5/120.0,
    TongueDepressor = 5/60.0,
    DryFirestarterBlock = 30/60.0,
    BBQStarterFluid = 15/60.0,
    GraphPaper = 5/60.0,
	Card_Birthday = 5/60.0,
	Card_Christmas = 5/60.0,
	Card_Christmas2 = 5/60.0,
	Card_Easter = 5/60.0,
	Card_Halloween = 5/60.0,
	Card_Hanukkah = 5/60.0,
	Card_LunarYear = 5/60.0,
	Card_StPatrick = 5/60.0,
	Card_Sympathy = 5/60.0,
	Card_Valentine = 5/60.0,
	LetterHandwritten = 5/60.0,
	Note = 5/60.0,
	Chopsticks = 5/60.0,
	LighterFluid = 5/60.0,
	IndexCard = 5/60.0,
	Phonebook = 30/60.0,
	Paperback = 10/60.0,
	RecipeClipping = 5/60.0,
	MenuCard = 5/60.0,
	GuitarAcoustic = 1.0,

}
-- For Clothing, only unequipped items with FabricType defined are allowed.
-- NOTE: A lot of these values are being replaced by procedurally generated values for consistency/sanity
-- remaining items are for backup purposes for any cases that were missed
campingFuelCategory = {
    Clothing = 15/60.0,
    Literature = 15/60.0,
    Map = 5/20.0,
}

-- Types of items that can be used with a lighter/matches to start a fire.
-- NOTE: A lot of these values are being replaced by procedurally generated values for consistency/sanity
-- remaining items are for backup purposes for any cases that were missed

-- Items should use the "IsFireTinder" to dictate that an item can be used as tinder
-- The default value should be the item's weight * 2/3, but clothing, literature and maps default to  weight * 1/4
-- An item can have FireFuelRatio defined to set a custom multiplier that is applied to weight

-- items that are already defined here are still valid, as a safety/backup, but the procedural fuel value calculations will use the lower of the value defined here or the procedurally calculated value
-- define or change an item's FireFuelRatio to change it's fuel value; this is the old system and shouldn't be continued to be used to define fire fuels or tinders
campingLightFireType = {
    RippedSheets = 5/60.0,
    RippedSheetsDirty = 5/60.0,
    Sheet = 15/60.0,
    SheetPaper2 = 5/60.0,
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
    PaperNapkins2 = 5/60.0,
    StockCertificate = 5/60.0,
    Paperwork = 5/60.0,
    IDcard = 5/120.0,
    IDcard_Female = 5/120.0,
    IDcard_Male = 5/120.0,
    Photo_Old = 5/120.0,
    Photo_Secret = 5/120.0,
    TongueDepressor = 5/60.0,
    Wallpaper_BeigeStripe = 15/60.0,
    Wallpaper_BlackFloral = 15/60.0,
    Wallpaper_BlueStripe = 15/60.0,
    Wallpaper_GreenDiamond = 15/60.0,
    Wallpaper_GreenFloral = 15/60.0,
    Wallpaper_PinkChevron = 15/60.0,
    Wallpaper_PinkFloral = 15/60.0,
    GraphPaper = 5/60.0,
	Card_Birthday = 5/60.0,
	Card_Christmas = 5/60.0,
	Card_Christmas2 = 5/60.0,
	Card_Easter = 5/60.0,
	Card_Halloween = 5/60.0,
	Card_Hanukkah = 5/60.0,
	Card_LunarYear = 5/60.0,
	Card_StPatrick = 5/60.0,
	Card_Sympathy = 5/60.0,
	Card_Valentine = 5/60.0,
	LetterHandwritten = 5/60.0,
	Note = 5/60.0,
	Chopsticks = 5/60.0,
	IndexCard = 5/60.0,
	Phonebook = 30/60.0,
	Paperback = 10/60.0,
	RecipeClipping = 5/60.0,
	MenuCard = 5/60.0,
}
-- NOTE: A lot of these values are being replaced by procedurally generated values for consistency/sanity
-- remaining items are for backup purposes for any cases that were missed
campingLightFireCategory = {
    Clothing = 15/60.0,
    Literature = 15/60.0,
    Map = 5/20.0,
}

--add the trash tiles to the burnable lists
local i = 0

while i < 54 do
	local trash = ("trash_01_" .. (tostring(i)))
	campingFuelType[trash]= 15.0/60
	campingLightFireType[trash]= 15.0/60
	i = i +1	
end
-- the maximum amount of fuel, in minutes, that can be in a BBQ/Campfire/Fireplace
-- CAMPING_FUEL_MAX = 480
function getCampingFuelMax()
    local max = (getSandboxOptions():getOptionByName("MaximumFireFuelHours"):getValue() * 60)
    return max
end