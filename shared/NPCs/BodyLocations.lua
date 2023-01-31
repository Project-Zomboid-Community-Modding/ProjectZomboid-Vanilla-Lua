--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

-- Locations must be declared in render-order.
-- Location IDs must match BodyLocation= and CanBeEquipped= values in items.txt.
local group = BodyLocations.getGroup("Human")

group:getOrCreateLocation("Bandage")
group:getOrCreateLocation("Wound")
group:getOrCreateLocation("BeltExtra") -- used for holster, empty texture items
group:getOrCreateLocation("Belt") -- empty texture items used for belt/utility belt
group:getOrCreateLocation("BellyButton") --Belly Button Jewellery
group:getOrCreateLocation("MakeUp_FullFace")
group:getOrCreateLocation("MakeUp_Eyes")
group:getOrCreateLocation("MakeUp_EyesShadow")
group:getOrCreateLocation("MakeUp_Lips")
group:getOrCreateLocation("Mask")
group:getOrCreateLocation("MaskEyes")-- Masks that cover eyes, so shouldn't show glasses (Gasmask)
group:getOrCreateLocation("MaskFull")-- covers face fully (welders mask)
group:getOrCreateLocation("Underwear")
group:getOrCreateLocation("UnderwearBottom")
group:getOrCreateLocation("UnderwearTop")
group:getOrCreateLocation("UnderwearExtra1")
group:getOrCreateLocation("UnderwearExtra2")
group:getOrCreateLocation("Hat")
group:getOrCreateLocation("FullHat") -- NBC Mask.. Should unequip everything head related (masks, glasses..)
group:getOrCreateLocation("Ears") --mainly earrings
group:getOrCreateLocation("EarTop") --earring at top of ear
group:getOrCreateLocation("Nose") --Nosestud, nosering
group:getOrCreateLocation("Torso1") -- Longjohns top
group:getOrCreateLocation("Torso1Legs1") -- Longjohns (top + bottom)

group:getOrCreateLocation("TankTop") -- TankTop (goes under tshirt or shirt)
group:getOrCreateLocation("Tshirt") -- TShirt/Vest (goes under shirt)
group:getOrCreateLocation("ShortSleeveShirt") -- ShortSleeveShirt So watches can be worn with short sleeve Shirts
group:getOrCreateLocation("LeftWrist") --Watches and Bracelets
group:getOrCreateLocation("RightWrist") --Watches and Bracelets
group:getOrCreateLocation("Shirt") -- Shirt

-- Neck-tie needs to be above any shirt
group:getOrCreateLocation("Neck")

group:getOrCreateLocation("Necklace") --Necklace, Necklace_Stone
group:getOrCreateLocation("Necklace_Long") -- Longer Necklaces, NecklaceLong
group:getOrCreateLocation("Right_MiddleFinger")
group:getOrCreateLocation("Left_MiddleFinger")
group:getOrCreateLocation("Left_RingFinger")
group:getOrCreateLocation("Right_RingFinger")
group:getOrCreateLocation("Hands")
group:getOrCreateLocation("HandsLeft")
group:getOrCreateLocation("HandsRight")
group:getOrCreateLocation("Socks")
group:getOrCreateLocation("Legs1") -- Longjohns bottom
group:getOrCreateLocation("Pants") -- Pants
group:getOrCreateLocation("Skirt") -- Skirt
group:getOrCreateLocation("Legs5") -- Unused
group:getOrCreateLocation("Dress") -- Dress (top + skirt) / Robe
group:getOrCreateLocation("BodyCostume") -- Body Costume like spiffo suit or wedding dress
group:getOrCreateLocation("Sweater") -- Sweater
group:getOrCreateLocation("SweaterHat") -- Hoodie UP
group:getOrCreateLocation("Jacket") -- Jacket
group:getOrCreateLocation("Jacket_Down") -- Poncho hood down
group:getOrCreateLocation("Jacket_Bulky") --SuitJacket, Padded Jacket hood down, wedding suit
group:getOrCreateLocation("JacketHat") --  Poncho UP (can't wear hat with them)
group:getOrCreateLocation("JacketHat_Bulky") --Padded jacket (hood up)(can't wear hat with them)
group:getOrCreateLocation("JacketSuit") --Formal jackets (Army Coat, Jacket Suit and Wedding Jacket)
group:getOrCreateLocation("FullSuit") -- Diverse full suit, head gear still can be wear with it (Spiffo suit and wedding dress)
group:getOrCreateLocation("Boilersuit") -- Coveralls
group:getOrCreateLocation("FullSuitHead") -- Cover everything (hazmat)
group:getOrCreateLocation("FullTop") -- unequip all top item (except tshirt/vest) (including hat/mask, for ghillie_top for example)
group:getOrCreateLocation("BathRobe") -- Need to avoid having coat/any textured models on top of it
group:getOrCreateLocation("Shoes")
group:getOrCreateLocation("FannyPackFront")
group:getOrCreateLocation("FannyPackBack")
group:getOrCreateLocation("AmmoStrap")

--group:getOrCreateLocation("LeftHand")
--group:getOrCreateLocation("RightHand")

-- Apron model is above jacket + pants, order doesn't seem to matter?
group:getOrCreateLocation("TorsoExtra")

-- Bullet, Hunting and High Viz vests
group:getOrCreateLocation("TorsoExtraVest")

-- Spiffo tail is a separate item
group:getOrCreateLocation("Tail")

-- Backpacks
group:getOrCreateLocation("Back")

group:getOrCreateLocation("LeftEye") --currently for eyepatch left
group:getOrCreateLocation("RightEye") --currently for eyepatch right

group:getOrCreateLocation("Eyes") -- need to be on top because of special UV
group:getOrCreateLocation("Scarf") -- need to be on top of everything!

group:getOrCreateLocation("ZedDmg")

-- underwear
--group:setExclusive("Underwear", "UnderwearTop")
--group:setExclusive("Underwear", "UnderwearBottom")
--group:setExclusive("Underwear", "UnderwearExtra1")

-- can't wear glasses with a mask that cover eyes
group:setExclusive("MaskEyes", "Eyes")
group:setExclusive("MaskEyes", "LeftEye")
group:setExclusive("MaskEyes", "RightEye")
group:setExclusive("MaskFull", "Eyes")
group:setExclusive("MaskFull", "LeftEye")
group:setExclusive("MaskFull", "RightEye")

-- Can't wear hat, mask or earrings with a full hat 
group:setExclusive("FullHat", "Hat")
group:setExclusive("FullHat", "Mask")
group:setExclusive("FullHat", "MaskEyes")
group:setExclusive("FullHat", "MaskFull")
group:setExclusive("FullHat", "RightEye")
group:setExclusive("FullHat", "LeftEye")
group:setExclusive("FullHat", "Eyes")

group:setExclusive("LeftEye", "RightEye")

-- Can't wear skirt and pants.
group:setExclusive("Skirt", "Pants")
group:setExclusive("Skirt", "Legs5")

-- Multi-item (for example: longjohns) takes two slots.
group:setExclusive("Torso1Legs1", "Torso1")
group:setExclusive("Torso1Legs1", "Legs1")

-- Multi-item (for example: a dress) takes two slots.
group:setExclusive("Dress", "Shirt")
group:setExclusive("Dress", "ShortSleeveShirt")
group:setExclusive("Dress", "Pants")
group:setExclusive("Dress", "Skirt")
group:setExclusive("Dress", "FullTop")

-- Hazmat, can't be wear with anything (apart shirt/tshirt as they don't have models)
group:setExclusive("FullSuitHead", "Sweater")
group:setExclusive("FullSuitHead", "Hands")
group:setExclusive("FullSuitHead", "SweaterHat")
--group:setExclusive("FullSuitHead", "Shirt")
--group:setExclusive("FullSuitHead", "Tshirt")
group:setExclusive("FullSuitHead", "Jacket")
group:setExclusive("FullSuitHead", "Jacket_Down")
group:setExclusive("FullSuitHead", "JacketHat")
group:setExclusive("FullSuitHead", "Jacket_Bulky")
group:setExclusive("FullSuitHead", "JacketHat_Bulky")
group:setExclusive("FullSuitHead", "Dress")
group:setExclusive("FullSuitHead", "Pants")
group:setExclusive("FullSuitHead", "Skirt")
group:setExclusive("FullSuitHead", "BathRobe")
group:setExclusive("FullSuitHead", "Hat")
group:setExclusive("FullSuitHead", "FullHat");
group:setExclusive("FullSuitHead", "Eyes");
group:setExclusive("FullSuitHead", "Mask")
group:setExclusive("FullSuitHead", "MaskEyes")
group:setExclusive("FullSuitHead", "MaskFull")
group:setExclusive("FullSuitHead", "Neck")
group:setExclusive("FullSuitHead", "TorsoExtra")
group:setExclusive("FullSuitHead", "FullTop")
group:setExclusive("FullSuitHead", "BodyCostume")

-- Spiffo Suit and Wedding Dress. Can't wear with anything apart from head
group:setExclusive("FullSuit", "Sweater")
group:setExclusive("FullSuit", "SweaterHat")
group:setExclusive("FullSuit", "Jacket")
group:setExclusive("FullSuit", "Jacket_Down")
group:setExclusive("FullSuit", "JacketSuit")
group:setExclusive("FullSuit", "JacketHat")
group:setExclusive("FullSuit", "Jacket_Bulky")
group:setExclusive("FullSuit", "JacketHat_Bulky")
group:setExclusive("FullSuit", "Dress")
group:setExclusive("FullSuit", "Pants")
group:setExclusive("FullSuit", "Skirt")
group:setExclusive("FullSuit", "BathRobe")
group:setExclusive("FullSuit", "TorsoExtra")
group:setExclusive("FullSuit", "TorsoExtraVest")
group:setExclusive("FullSuit", "FullSuitHead")
group:setExclusive("FullSuit", "FullTop")
group:setExclusive("FullSuit", "BodyCostume")
group:setExclusive("FullSuit", "Boilersuit")

group:setExclusive("FullTop", "Sweater")
group:setExclusive("FullTop", "SweaterHat")
group:setExclusive("FullTop", "Jacket")
group:setExclusive("FullTop", "Jacket_Down")
group:setExclusive("FullTop", "JacketSuit")
group:setExclusive("FullTop", "JacketHat")
group:setExclusive("FullTop", "Jacket_Bulky")
group:setExclusive("FullTop", "JacketHat_Bulky")
group:setExclusive("FullTop", "Dress")
group:setExclusive("FullTop", "BathRobe")
group:setExclusive("FullTop", "Hat")
group:setExclusive("FullTop", "FullHat");
group:setExclusive("FullTop", "Eyes");
group:setExclusive("FullTop", "Mask")
group:setExclusive("FullTop", "Neck")
group:setExclusive("FullTop", "TorsoExtra")
group:setExclusive("FullTop", "TorsoExtraVest")
group:setExclusive("FullTop", "Boilersuit")

-- Boilersuit (Coveralls) Can't wear with anything apart from head, and Bullet, hunting and high viz vests.
group:setExclusive("Boilersuit", "Sweater")
group:setExclusive("Boilersuit", "SweaterHat")
group:setExclusive("Boilersuit", "Jacket")
group:setExclusive("Boilersuit", "Jacket_Down")
group:setExclusive("Boilersuit", "JacketSuit")
group:setExclusive("Boilersuit", "JacketHat")
group:setExclusive("Boilersuit", "Jacket_Bulky")
group:setExclusive("Boilersuit", "JacketHat_Bulky")
group:setExclusive("Boilersuit", "Dress")
group:setExclusive("Boilersuit", "Pants")
group:setExclusive("Boilersuit", "Skirt")
group:setExclusive("Boilersuit", "BathRobe")
group:setExclusive("Boilersuit", "TorsoExtra")
group:setExclusive("Boilersuit", "FullSuitHead")
group:setExclusive("Boilersuit", "FullTop")
group:setExclusive("Boilersuit", "BodyCostume")
group:setExclusive("Boilersuit", "FullSuit")
group:setExclusive("Boilersuit", "FullTop")

-- apart from tanktop/tshirt/longjohns, you shouldn't add stuff on top of your bathrobe to avoid clipping
group:setExclusive("BathRobe", "Sweater")
group:setExclusive("BathRobe", "SweaterHat")
group:setExclusive("BathRobe", "Jacket")
group:setExclusive("BathRobe", "Jacket_Down")
group:setExclusive("BathRobe", "JacketSuit")
group:setExclusive("BathRobe", "JacketHat")
group:setExclusive("BathRobe", "Jacket_Bulky")
group:setExclusive("BathRobe", "JacketHat_Bulky")
group:setExclusive("BathRobe", "TorsoExtra")
group:setExclusive("BathRobe", "TorsoExtraVest")
group:setExclusive("BathRobe", "Boilersuit")

group:setExclusive("BodyCostume", "Sweater")
group:setExclusive("BodyCostume", "SweaterHat")
group:setExclusive("BodyCostume", "TorsoExtra")
group:setExclusive("BodyCostume", "TorsoExtraVest")
group:setExclusive("BodyCostume", "Boilersuit")
--group:setExclusive("BodyCostume", "Shirt")
--group:setExclusive("BodyCostume", "Tshirt")
group:setExclusive("BodyCostume", "Dress")
group:setExclusive("BodyCostume", "Pants")
group:setExclusive("BodyCostume", "FullTop")
group:setExclusive("BodyCostume", "BathRobe")
group:setExclusive("BodyCostume", "Neck")

-- can't wear hats with padded jacket
group:setExclusive("JacketHat", "Hat")
group:setExclusive("JacketHat_Bulky", "Hat")
group:setExclusive("JacketHat", "FullHat")
group:setExclusive("JacketHat_Bulky", "FullHat")
group:setExclusive("JacketHat", "Jacket")
group:setExclusive("JacketHat", "Jacket_Down")
group:setExclusive("JacketHat_Bulky", "Jacket")

-- can't wear hats with hoodieup
group:setExclusive("SweaterHat", "Hat")
group:setExclusive("SweaterHat", "FullHat")
group:setExclusive("SweaterHat", "Sweater")

-- can't wear maskfull with a hats, maskeyes or masks
group:setExclusive("MaskFull", "Hat")
group:setExclusive("MaskFull", "MaskEyes")
group:setExclusive("MaskFull", "Mask")
-- can't wear mask and other masks 
group:setExclusive("Mask", "MaskEyes")
group:setExclusive("Mask", "MaskFull")

--can't wear TorsoExtra with TorsoExtraVests
group:setExclusive("TorsoExtraVest", "TorsoExtra")
group:setExclusive("TorsoExtra", "TorsoExtraVest")

-- can't wear Jackets and Jacket_Hats with Jacket_Bulky or JacketHat_Bulky or JacketSuits or sweaters
group:setExclusive("Jacket", "JacketHat")
group:setExclusive("Jacket", "Jacket_Down")
group:setExclusive("Jacket", "JacketHat_Bulky")
group:setExclusive("Jacket", "Jacket_Bulky")
group:setExclusive("JacketHat", "Jacket_Bulky")
group:setExclusive("JacketHat", "JacketHat_Bulky")
group:setExclusive("JacketHat", "Sweater")
group:setExclusive("JacketHat", "SweaterHat")
group:setExclusive("Jacket_Down", "Jacket_Bulky")
group:setExclusive("Jacket_Down", "JacketHat_Bulky")
group:setExclusive("Jacket_Bulky", "JacketHat_Bulky")
group:setExclusive("Jacket_Down", "Sweater")
group:setExclusive("Jacket_Down", "SweaterHat")
group:setExclusive("JacketSuit", "Jacket")
group:setExclusive("JacketSuit", "Jacket_Down")
group:setExclusive("JacketSuit", "Jacket_Bulky")
group:setExclusive("JacketSuit", "JacketHat")
group:setExclusive("JacketSuit", "JacketHat_Bulky")

--can't wear Jacket Suits with Sweaters, Sweater Hats or TorsoExtraVests
group:setExclusive("JacketSuit", "Sweater")
group:setExclusive("JacketSuit", "SweaterHat")
group:setExclusive("JacketSuit", "TorsoExtraVest")

--can't wear Jacket_Bulky or JacketHat_Bulky with TorsoExtraVests
group:setExclusive("Jacket_Bulky", "TorsoExtraVest")
group:setExclusive("JacketHat_Bulky", "TorsoExtraVest")

-- Backwards compatibility
group:getLocation("Tshirt"):addAlias("Top")
group:getLocation("Pants"):addAlias("Bottoms")

-- Hide items in the second location when an item is in the first location.
-- The item will still be hidden if there is a hole in the outer item.
group:setHideModel("BathRobe", "LeftWrist")
group:setHideModel("BathRobe", "RightWrist")
group:setHideModel("FullSuit", "LeftWrist")
group:setHideModel("FullSuit", "RightWrist")
group:setHideModel("FullSuitHead", "LeftWrist")
group:setHideModel("FullSuitHead", "RightWrist")
group:setHideModel("FullTop", "LeftWrist")
group:setHideModel("FullTop", "RightWrist")
group:setHideModel("Jacket", "LeftWrist")
group:setHideModel("Jacket", "RightWrist")
group:setHideModel("JacketSuit", "LeftWrist")
group:setHideModel("JacketSuit", "RightWrist")
group:setHideModel("Jacket_Bulky", "LeftWrist")
group:setHideModel("Jacket_Bulky", "RightWrist")
group:setHideModel("JacketHat_Bulky", "LeftWrist")
group:setHideModel("JacketHat_Bulky", "RightWrist")
group:setHideModel("JacketHat", "Ears")
group:setHideModel("JacketHat", "EarTop")
group:setHideModel("JacketHat_Bulky", "Ears")
group:setHideModel("JacketHat_Bulky", "EarTop")
group:setHideModel("Shirt", "LeftWrist")
group:setHideModel("Shirt", "RightWrist")
group:setHideModel("Sweater", "LeftWrist")
group:setHideModel("Sweater", "RightWrist")
group:setHideModel("SweaterHat", "LeftWrist")
group:setHideModel("SweaterHat", "RightWrist")
group:setHideModel("SweaterHat", "Ears")
group:setHideModel("SweaterHat", "EarTop")
group:setHideModel("Boilersuit", "LeftWrist")
group:setHideModel("Boilersuit", "RightWrist")
--hiding fanny pack front
group:setHideModel("Jacket", "FannyPackFront")
group:setHideModel("Jacket_Down", "FannyPackFront")
group:setHideModel("JacketSuit", "FannyPackFront")
group:setHideModel("Jacket_Bulky", "FannyPackFront")
group:setHideModel("TorsoExtra", "FannyPackFront")
group:setHideModel("TorsoExtraVest", "FannyPackFront")
group:setHideModel("BathRobe", "FannyPackFront")
group:setHideModel("FullSuit", "FannyPackFront")
group:setHideModel("JacketHat", "FannyPackFront")
group:setHideModel("JacketHat_Bulky", "FannyPackFront")
group:setHideModel("Boilersuit", "FannyPackFront")
group:setHideModel("Sweater", "FannyPackFront")
group:setHideModel("SweaterHat", "FannyPackFront")
--hiding fanny pack back
group:setHideModel("Jacket", "FannyPackBack")
group:setHideModel("Jacket_Down", "FannyPackBack")
group:setHideModel("JacketSuit", "FannyPackBack")
group:setHideModel("Jacket_Bulky", "FannyPackBack")
group:setHideModel("TorsoExtra", "FannyPackBack")
group:setHideModel("TorsoExtraVest", "FannyPackBack")
group:setHideModel("BathRobe", "FannyPackBack")
group:setHideModel("FullSuit", "FannyPackBack")
group:setHideModel("JacketHat", "FannyPackBack")
group:setHideModel("JacketHat_Bulky", "FannyPackBack")
group:setHideModel("Boilersuit", "FannyPackBack")
group:setHideModel("Sweater", "FannyPackBack")
group:setHideModel("SweaterHat", "FannyPackBack")
--hiding items with poncho hood up and down
group:setHideModel("JacketHat", "Sweater")
group:setHideModel("JacketHat", "SweaterHat")
group:setHideModel("Jacket_Down", "Sweater")
group:setHideModel("Jacket_Down", "SweaterHat")
group:setHideModel("JacketHat", "TorsoExtraVest")
group:setHideModel("Jacket_Down", "TorsoExtraVest")

--hide hoodie when hood down with padded jacket
group:setHideModel("Jacket_Bulky", "Sweater")
group:setHideModel("JacketHat_Bulky", "SweaterHat")
group:setHideModel("JacketHat_Bulky", "Sweater")

-- Multiple items at these locations are allowed.
group:setMultiItem("Bandage", true)
group:setMultiItem("Wound", true)
group:setMultiItem("ZedDmg", true)

--Hide jumpers under Jackets
group:setHideModel("Jacket", "Sweater")
