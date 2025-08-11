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
group:getOrCreateLocation("UnderwearBottom")
group:getOrCreateLocation("UnderwearTop")
group:getOrCreateLocation("Underwear")-- moved above 'top' and 'bottom' underwear
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
group:getOrCreateLocation("RightArm") --chainmail sleeve
group:getOrCreateLocation("LeftArm") --chainmail sleeve


group:getOrCreateLocation("Neck")-- neck model
group:getOrCreateLocation("Neck_Texture")-- Neck-tie needs to be above any shirt

group:getOrCreateLocation("Necklace") --Necklace, Necklace_Stone
group:getOrCreateLocation("Necklace_Long") -- Longer Necklaces, NecklaceLong
group:getOrCreateLocation("Right_MiddleFinger")
group:getOrCreateLocation("Left_MiddleFinger")
group:getOrCreateLocation("Left_RingFinger")
group:getOrCreateLocation("Right_RingFinger")
group:getOrCreateLocation("Hands")
group:getOrCreateLocation("HandsLeft")
group:getOrCreateLocation("HandsRight")
group:getOrCreateLocation("Calf_Left_Texture") --shinpad textures
group:getOrCreateLocation("Calf_Right_Texture") --shinpad textures
group:getOrCreateLocation("Socks")
group:getOrCreateLocation("Legs1") -- Longjohns bottom and skinny trousers
group:getOrCreateLocation("Shoes")
group:getOrCreateLocation("Codpiece")
group:getOrCreateLocation("ShortsShort") -- short shorts
group:getOrCreateLocation("ShortPants") --  long shorts, 
group:getOrCreateLocation("Pants_Skinny") -- Skinny Pants
group:getOrCreateLocation("Gaiter_Right") -- Gaiter right texture
group:getOrCreateLocation("Gaiter_Left") -- Gaiter left texture
group:getOrCreateLocation("Pants") -- Pants
group:getOrCreateLocation("Skirt") -- Skirt
group:getOrCreateLocation("Dress") -- Dress (top + skirt) / Robe
group:getOrCreateLocation("Legs5") -- Unused
group:getOrCreateLocation("ForeArm_Left") -- Left Vambraces
group:getOrCreateLocation("ForeArm_Right") -- Right Vambraces
group:getOrCreateLocation("LongSkirt") -- Skirt
group:getOrCreateLocation("LongDress") -- Dress (top + skirt) / Robe
group:getOrCreateLocation("VestTexture") --waistcoats texture
group:getOrCreateLocation("BodyCostume") -- Body Costume like spiffo suit or wedding dress
group:getOrCreateLocation("SportShoulderpad") --Football shoulderpads
group:getOrCreateLocation("Gorget") --Gorget
group:getOrCreateLocation("Jersey") --Football Jersey
group:getOrCreateLocation("Sweater") -- Sweater
group:getOrCreateLocation("SweaterHat") -- Hoodie UP
group:getOrCreateLocation("PantsExtra") -- Dungarees
group:getOrCreateLocation("Jacket") -- Jacket
group:getOrCreateLocation("Jacket_Down") -- Poncho hood down
group:getOrCreateLocation("Jacket_Bulky") --SuitJacket, Padded Jacket hood down, wedding suit
group:getOrCreateLocation("JacketHat") --  Poncho UP (can't wear hat with them)
group:getOrCreateLocation("JacketHat_Bulky") --Padded jacket (hood up)(can't wear hat with them)
group:getOrCreateLocation("JacketSuit") --Formal jackets (Jacket Suit and Wedding Jacket)
group:getOrCreateLocation("FullSuit") -- Diverse full suit, head gear still can be wear with it (Spiffo suit and wedding dress)
group:getOrCreateLocation("Boilersuit") -- Coveralls
group:getOrCreateLocation("FullSuitHead") -- Cover everything (hazmat)
group:getOrCreateLocation("FullSuitHeadSCBA") -- Cover everything (hazmat)
group:getOrCreateLocation("Knee_Left") -- Left Knee
group:getOrCreateLocation("Knee_Right") -- Right Knee
group:getOrCreateLocation("Calf_Left") -- Left Greaves 
group:getOrCreateLocation("Calf_Right") -- Right Greaves
group:getOrCreateLocation("Thigh_Left") --Left Thigh armour
group:getOrCreateLocation("Thigh_Right") --Right Thigh armour
group:getOrCreateLocation("SportShoulderpadOnTop") --Football shoulderpads on top of other clothes
group:getOrCreateLocation("ShoulderpadRight") --Right only shoulderpad
group:getOrCreateLocation("ShoulderpadLeft") --Left only shoulderpad
group:getOrCreateLocation("Elbow_Left") --Left elbow pads
group:getOrCreateLocation("Elbow_Right") --Right elbow pads
group:getOrCreateLocation("FullTop") -- unequip all top item (except tshirt/vest) (including hat/mask, for ghillie_top for example)
group:getOrCreateLocation("BathRobe") -- Need to avoid having coat/any textured models on top of it
group:getOrCreateLocation("FannyPackFront")
group:getOrCreateLocation("FannyPackBack")
group:getOrCreateLocation("Webbing")
group:getOrCreateLocation("SCBA")
group:getOrCreateLocation("SCBAnotank")
group:getOrCreateLocation("AmmoStrap")
group:getOrCreateLocation("ShoulderHolster")
group:getOrCreateLocation("AnkleHolster")

--group:getOrCreateLocation("LeftHand")
--group:getOrCreateLocation("RightHand")

--Apron
group:getOrCreateLocation("TorsoExtra")

-- Bullet, Hunting and High Viz vests
group:getOrCreateLocation("TorsoExtraVest")
group:getOrCreateLocation("TorsoExtraVestBullet")

--Cuirass, similar to vests but with an ALT model
group:getOrCreateLocation("Cuirass")

-- Spiffo tail is a separate item
group:getOrCreateLocation("Tail")

--Judges Robe acts like poncho or BathRobe but hiding more
group:getOrCreateLocation("FullRobe")

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

-- Can't wear hat, mask or earrings with SCBA
group:setExclusive("SCBA", "FullHat")
group:setExclusive("SCBA", "Mask")
group:setExclusive("SCBA", "MaskEyes")
group:setExclusive("SCBA", "MaskFull")
group:setExclusive("SCBA", "RightEye")
group:setExclusive("SCBA", "LeftEye")
group:setExclusive("SCBA", "Eyes")
group:setExclusive("SCBAnotank", "FullHat")
group:setExclusive("SCBAnotank", "Mask")
group:setExclusive("SCBAnotank", "MaskEyes")
group:setExclusive("SCBAnotank", "MaskFull")
group:setExclusive("SCBAnotank", "RightEye")
group:setExclusive("SCBAnotank", "LeftEye")
group:setExclusive("SCBAnotank", "Eyes")

group:setExclusive("LeftEye", "RightEye")

-- Can't wear skirt and pants.
group:setExclusive("Skirt", "Pants")
group:setExclusive("Skirt", "PantsExtra")
group:setExclusive("Skirt", "ShortPants")
group:setExclusive("Skirt", "ShortsShort")
group:setExclusive("Skirt", "Legs5")
group:setExclusive("LongSkirt", "Pants")
group:setExclusive("LongSkirt", "PantsExtra")
group:setExclusive("LongSkirt", "ShortPants")
group:setExclusive("LongSkirt", "ShortsShort")
group:setExclusive("LongSkirt", "Legs5")
group:setExclusive("Skirt", "Pants_Skinny")

--Can't wear Skirt and Dresses together
group:setExclusive("Skirt", "Dress")
group:setExclusive("Skirt", "LongDress")
group:setExclusive("LongSkirt", "Dress")
group:setExclusive("LongSkirt", "LongDress")

-- Multi-item (for example: longjohns) takes two slots.
group:setExclusive("Torso1Legs1", "Torso1")
group:setExclusive("Torso1Legs1", "Legs1")

-- Multi-item (for example: a dress) takes two slots.
group:setExclusive("Dress", "Shirt")
group:setExclusive("Dress", "ShortSleeveShirt")
group:setExclusive("Dress", "Pants")
group:setExclusive("Dress", "Pants_Skinny")
group:setExclusive("Dress", "PantsExtra")
group:setExclusive("Dress", "ShortPants")
group:setExclusive("Dress", "ShortsShort")
group:setExclusive("Dress", "Skirt")
group:setExclusive("Dress", "LongSkirt")
group:setExclusive("Dress", "FullTop")
group:setExclusive("LongDress", "Shirt")
group:setExclusive("LongDress", "ShortSleeveShirt")
group:setExclusive("LongDress", "Pants")
group:setExclusive("LongDress", "Pants_Skinny")
group:setExclusive("LongDress", "PantsExtra")
group:setExclusive("LongDress", "ShortPants")
group:setExclusive("LongDress", "ShortsShort")
group:setExclusive("LongDress", "Skirt")
group:setExclusive("LongDress", "FullTop")

-- Hazmat, can't be wear with anything (apart shirt/tshirt as they don't have models)
group:setExclusive("FullSuitHead", "Sweater")
group:setExclusive("FullSuitHead", "Hands")
group:setExclusive("FullSuitHead", "SweaterHat")
--group:setExclusive("FullSuitHead", "Shirt")
--group:setExclusive("FullSuitHead", "Tshirt")
group:setExclusive("FullSuitHead", "Jersey")
group:setExclusive("FullSuitHead", "Jacket")
group:setExclusive("FullSuitHead", "Jacket_Down")
group:setExclusive("FullSuitHead", "JacketHat")
group:setExclusive("FullSuitHead", "Jacket_Bulky")
group:setExclusive("FullSuitHead", "JacketHat_Bulky")
group:setExclusive("FullSuitHead", "Dress")
group:setExclusive("FullSuitHead", "LongDress")
group:setExclusive("FullSuitHead", "Pants")
group:setExclusive("FullSuitHead", "Pants_Skinny")
group:setExclusive("FullSuitHead", "PantsExtra")
group:setExclusive("FullSuitHead", "ShortPants")
group:setExclusive("FullSuitHead", "ShortsShort")
group:setExclusive("FullSuitHead", "Skirt")
group:setExclusive("FullSuitHead", "LongSkirt")
group:setExclusive("FullSuitHead", "BathRobe")
group:setExclusive("FullSuitHead", "FullRobe")
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
group:setExclusive("FullSuitHead", "Webbing")
group:setExclusive("FullSuitHead", "SCBA")
group:setExclusive("FullSuitHead", "SCBAnotank")
group:setExclusive("FullSuitHead", "ShoulderHolster")
group:setExclusive("FullSuitHead", "AnkleHolster")
group:setExclusive("FullSuitHead", "Back")
group:setExclusive("FullSuitHead", "Scarf")


-- Spiffo Suit and Wedding Dress. Can't wear with anything apart from head
group:setExclusive("FullSuit", "Sweater")
group:setExclusive("FullSuit", "SweaterHat")
group:setExclusive("FullSuit", "Jersey")
group:setExclusive("FullSuit", "Jacket")
group:setExclusive("FullSuit", "Jacket_Down")
group:setExclusive("FullSuit", "JacketSuit")
group:setExclusive("FullSuit", "JacketHat")
group:setExclusive("FullSuit", "Jacket_Bulky")
group:setExclusive("FullSuit", "JacketHat_Bulky")
group:setExclusive("FullSuit", "Dress")
group:setExclusive("FullSuit", "LongDress")
group:setExclusive("FullSuit", "Pants")
group:setExclusive("FullSuit", "Pants_Skinny")
group:setExclusive("FullSuit", "PantsExtra")
group:setExclusive("FullSuit", "ShortPants")
group:setExclusive("FullSuit", "ShortsShort")
group:setExclusive("FullSuit", "Skirt")
group:setExclusive("FullSuit", "LongSkirt")
group:setExclusive("FullSuit", "BathRobe")
group:setExclusive("FullSuit", "FullRobe")
group:setExclusive("FullSuit", "TorsoExtra")
group:setExclusive("FullSuit", "TorsoExtraVest")
group:setExclusive("FullSuit", "TorsoExtraVestBullet")
group:setExclusive("FullSuit", "Cuirass")
group:setExclusive("FullSuit", "FullSuitHead")
group:setExclusive("FullSuit", "FullTop")
group:setExclusive("FullSuit", "BodyCostume")
group:setExclusive("FullSuit", "Boilersuit")
group:setExclusive("FullSuit", "Webbing")
group:setExclusive("FullSuit", "SCBA")
group:setExclusive("FullSuit", "SCBAnotank")
group:setExclusive("FullSuit", "ShoulderHolster")
group:setExclusive("FullSuit", "AnkleHolster")


group:setExclusive("FullTop", "Sweater")
group:setExclusive("FullTop", "SweaterHat")
group:setExclusive("FullTop", "Jersey")
group:setExclusive("FullTop", "Jacket")
group:setExclusive("FullTop", "Jacket_Down")
group:setExclusive("FullTop", "JacketSuit")
group:setExclusive("FullTop", "JacketHat")
group:setExclusive("FullTop", "Jacket_Bulky")
group:setExclusive("FullTop", "JacketHat_Bulky")
group:setExclusive("FullTop", "Neck")
group:setExclusive("FullSuit", "Dress")
group:setExclusive("FullSuit", "LongDress")
group:setExclusive("FullTop", "BathRobe")
group:setExclusive("FullTop", "FullRobe")
group:setExclusive("FullTop", "Hat")
group:setExclusive("FullTop", "FullHat");
group:setExclusive("FullTop", "Eyes");
group:setExclusive("FullTop", "Mask")
group:setExclusive("FullTop", "Neck")
group:setExclusive("FullTop", "TorsoExtra")
group:setExclusive("FullTop", "TorsoExtraVest")
group:setExclusive("FullTop", "TorsoExtraVestBullet")
group:setExclusive("FullTop", "Cuirass")
group:setExclusive("FullTop", "Boilersuit")
group:setExclusive("FullTop", "Webbing")
group:setExclusive("FullTop", "SCBA")
group:setExclusive("FullTop", "SCBAnotank")
group:setExclusive("FullTop", "ShoulderHolster")


-- Boilersuit (Coveralls) Can't wear with anything apart from head, and Bullet, hunting and high viz vests.
group:setExclusive("Boilersuit", "Sweater")
group:setExclusive("Boilersuit", "SweaterHat")
group:setExclusive("Boilersuit", "Jersey")
group:setExclusive("Boilersuit", "Jacket")
group:setExclusive("Boilersuit", "Jacket_Down")
group:setExclusive("Boilersuit", "JacketSuit")
group:setExclusive("Boilersuit", "JacketHat")
group:setExclusive("Boilersuit", "Jacket_Bulky")
group:setExclusive("Boilersuit", "JacketHat_Bulky")
group:setExclusive("Boilersuit", "Dress")
group:setExclusive("Boilersuit", "LongDress")
group:setExclusive("Boilersuit", "Pants")
group:setExclusive("Boilersuit", "Pants_Skinny")
group:setExclusive("Boilersuit", "PantsExtra")
group:setExclusive("Boilersuit", "ShortPants")
group:setExclusive("Boilersuit", "ShortsShort")
group:setExclusive("Boilersuit", "Skirt")
group:setExclusive("Boilersuit", "LongSkirt")
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
group:setExclusive("BathRobe", "Jersey")
group:setExclusive("BathRobe", "Jacket")
group:setExclusive("BathRobe", "Jacket_Down")
group:setExclusive("BathRobe", "JacketSuit")
group:setExclusive("BathRobe", "JacketHat")
group:setExclusive("BathRobe", "Jacket_Bulky")
group:setExclusive("BathRobe", "JacketHat_Bulky")
group:setExclusive("BathRobe", "PantsExtra")
group:setExclusive("BathRobe", "TorsoExtra")
group:setExclusive("BathRobe", "TorsoExtraVest")
group:setExclusive("BathRobe", "TorsoExtraVestBullet")
group:setExclusive("BathRobe", "Cuirass")
group:setExclusive("BathRobe", "Boilersuit")
group:setExclusive("BathRobe", "Webbing")
group:setExclusive("BathRobe", "SCBA")
group:setExclusive("BathRobe", "SCBAnotank")
group:setExclusive("BathRobe", "PantsExtra")


-- apart from tanktop/tshirt/longjohns, you shouldn't add stuff on top of your FullRobe to avoid clipping
group:setExclusive("FullRobe", "Sweater")
group:setExclusive("FullRobe", "SweaterHat")
group:setExclusive("FullRobe", "Jersey")
group:setExclusive("FullRobe", "Jacket")
group:setExclusive("FullRobe", "Jacket_Down")
group:setExclusive("FullRobe", "JacketSuit")
group:setExclusive("FullRobe", "JacketHat")
group:setExclusive("FullRobe", "Jacket_Bulky")
group:setExclusive("FullRobe", "JacketHat_Bulky")
--group:setExclusive("FullRobe", "PantsExtra")
--group:setExclusive("FullRobe", "TorsoExtra")
--group:setExclusive("FullRobe", "TorsoExtraVest")
--group:setExclusive("FullRobe", "TorsoExtraVestBullet")
--group:setExclusive("BathRobe", "Cuirass")
--group:setExclusive("BathRobe", "Webbing")
group:setExclusive("FullRobe", "SCBA")
group:setExclusive("FullRobe", "SCBAnotank")


group:setExclusive("BodyCostume", "Sweater")
group:setExclusive("BodyCostume", "SweaterHat")
group:setExclusive("BodyCostume", "TorsoExtra")
group:setExclusive("BodyCostume", "TorsoExtraVest")
group:setExclusive("BodyCostume", "TorsoExtraVestBullet")
group:setExclusive("BodyCostume", "Cuirass")
group:setExclusive("BodyCostume", "Boilersuit")
--group:setExclusive("BodyCostume", "Shirt")
--group:setExclusive("BodyCostume", "Tshirt")
group:setExclusive("BodyCostume", "Dress")
group:setExclusive("BodyCostume", "LongDress")
group:setExclusive("BodyCostume", "Pants")
group:setExclusive("BodyCostume", "Pants_Skinny")
group:setExclusive("BodyCostume", "PantsExtra")
group:setExclusive("BodyCostume", "ShortPants")
group:setExclusive("BodyCostume", "ShortsShort")
group:setExclusive("BodyCostume", "FullTop")
group:setExclusive("BodyCostume", "BathRobe")
group:setExclusive("BodyCostume", "FullRobe")


-- can't wear hats with padded jacket

group:setExclusive("JacketHat", "Hat")
group:setExclusive("JacketHat_Bulky", "Hat")
group:setExclusive("JacketHat", "FullHat")
group:setExclusive("JacketHat_Bulky", "FullHat")
group:setExclusive("JacketHat", "Jacket")
group:setExclusive("JacketHat", "Jacket_Down")
group:setExclusive("JacketHat_Bulky", "Jacket")

--can't wear these with sport shoulderpads (when pads worn under jersey)
group:setExclusive("FullSuitHead", "SportShoulderpad")
group:setExclusive("FullSuit", "SportShoulderpad")
group:setExclusive("FullTop", "SportShoulderpad")
group:setExclusive("Boilersuit", "SportShoulderpad")
group:setExclusive("BathRobe", "SportShoulderpad")
group:setExclusive("FullRobe", "SportShoulderpad")
group:setExclusive("JacketHat", "SportShoulderpad")
group:setExclusive("JacketHat_Bulky", "SportShoulderpad")
group:setExclusive("Jacket", "SportShoulderpad")
group:setExclusive("JacketHat", "SportShoulderpad")
group:setExclusive("Jacket_Bulky", "SportShoulderpad")
group:setExclusive("Jacket_Down", "SportShoulderpad")
group:setExclusive("Sweater", "SportShoulderpad")
group:setExclusive("SweaterHat", "SportShoulderpad")
group:setExclusive("TorsoExtra", "SportShoulderpad")
group:setExclusive("TorsoExtraVest", "SportShoulderpad")
group:setExclusive("TorsoExtraVestBullet", "SportShoulderpad")
group:setExclusive("Cuirass", "SportShoulderpad")
group:setExclusive("ShoulderHolster", "SportShoulderpad")
group:setExclusive("SportShoulderpadOnTop", "SportShoulderpad")
group:setExclusive("Webbing", "SportShoulderpad")
group:setExclusive("SCBA", "SportShoulderpad")
group:setExclusive("SCBAnotank", "SportShoulderpad")
group:setExclusive("Back", "SportShoulderpad")
group:setExclusive("ShoulderpadRight", "SportShoulderpad")
group:setExclusive("ShoulderpadLeft", "SportShoulderpad")


--can't wear these with sport shoulderpads on top
group:setExclusive("TorsoExtraVest", "SportShoulderpadOnTop")
group:setExclusive("TorsoExtraVestBullet", "SportShoulderpadOnTop")
group:setExclusive("ShoulderHolster", "SportShoulderpadOnTop")
group:setExclusive("Webbing", "SportShoulderpadOnTop")
group:setExclusive("SCBA", "SportShoulderpadOnTop")
group:setExclusive("SCBAnotank", "SportShoulderpadOnTop")
group:setExclusive("Back", "SportShoulderpadOnTop")
group:setExclusive("ShoulderpadRight","SportShoulderpadOnTop")
group:setExclusive("ShoulderpadLeft","SportShoulderpadOnTop")

--can't wear these with single shoulderpad right
group:setExclusive("FullSuitHead", "ShoulderpadRight")
group:setExclusive("FullSuit", "ShoulderpadRight")
group:setExclusive("FullTop", "ShoulderpadRight")
group:setExclusive("TorsoExtraVestBullet", "ShoulderpadRight")
group:setExclusive("ShoulderHolster", "ShoulderpadRight")
group:setExclusive("Webbing", "ShoulderpadRight")
group:setExclusive("SCBA", "ShoulderpadRight")
group:setExclusive("SCBAnotank", "ShoulderpadRight")
group:setExclusive("Back", "ShoulderpadRight")

--can't wear these with single shoulderpad left
group:setExclusive("FullSuitHead", "ShoulderpadLeft")
group:setExclusive("FullSuit", "ShoulderpadLeft")
group:setExclusive("FullTop", "ShoulderpadLeft")
group:setExclusive("TorsoExtraVestBullet", "ShoulderpadLeft")
group:setExclusive("ShoulderHolster", "ShoulderpadLeft")
group:setExclusive("Webbing", "ShoulderpadLeft")
group:setExclusive("SCBA", "ShoulderpadLeft")
group:setExclusive("SCBAnotank", "ShoulderpadLeft")
group:setExclusive("Back", "ShoulderpadLeft")

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
group:setExclusive("TorsoExtraVestBullet", "TorsoExtra")
group:setExclusive("TorsoExtra", "TorsoExtraVest")
group:setExclusive("TorsoExtra", "TorsoExtraVestBullet")
group:setExclusive("TorsoExtraVest", "TorsoExtraVestBullet")
group:setExclusive("ShoulderHolster", "TorsoExtraVestBullet")
group:setExclusive("Cuirass", "TorsoExtra")
group:setExclusive("Cuirass", "TorsoExtraVest")
group:setExclusive("Cuirass", "TorsoExtraVestBullet")
group:setExclusive("Cuirass", "ShoulderHolster")


-- can't wear Jackets and Jacket_Hats with Jacket_Bulky or JacketHat_Bulky or JacketSuits or sweaters
group:setExclusive("Jacket", "JacketHat")
group:setExclusive("Jacket", "Jacket_Down")
group:setExclusive("Jacket", "JacketHat_Bulky")
group:setExclusive("Jacket", "Jacket_Bulky")
group:setExclusive("Jacket", "TorsoExtra")
group:setExclusive("JacketHat", "Jacket_Bulky")
group:setExclusive("JacketHat", "JacketHat_Bulky")
group:setExclusive("JacketHat", "Sweater")
group:setExclusive("JacketHat", "SweaterHat")
group:setExclusive("JacketHat", "TorsoExtra")
group:setExclusive("Jacket_Down", "Jacket_Bulky")
group:setExclusive("Jacket_Down", "JacketHat_Bulky")
group:setExclusive("Jacket_Bulky", "JacketHat_Bulky")
group:setExclusive("Jacket_Down", "Sweater")
group:setExclusive("Jacket_Down", "SweaterHat")
group:setExclusive("Jacket_Down", "TorsoExtra")
group:setExclusive("JacketSuit", "Jacket")
group:setExclusive("JacketSuit", "Jacket_Down")
group:setExclusive("JacketSuit", "Jacket_Bulky")
group:setExclusive("JacketSuit", "JacketHat")
group:setExclusive("JacketSuit", "JacketHat_Bulky")


--can't wear Jacket Suits with Sweaters, Sweater Hats or TorsoExtraVests or Cuirass
group:setExclusive("JacketSuit", "Sweater")
group:setExclusive("JacketSuit", "SweaterHat")
group:setExclusive("JacketSuit", "TorsoExtra")
group:setExclusive("JacketSuit", "TorsoExtraVest")
group:setExclusive("JacketSuit", "TorsoExtraVestBullet")
group:setExclusive("JacketSuit", "Webbing")
group:setExclusive("JacketSuit", "SCBA")
group:setExclusive("JacketSuit", "SCBAnotank")
group:setExclusive("JacketSuit", "Cuirass")
group:setExclusive("JacketSuit", "PantsExtra")

--can't wear Jacket_Bulky or JacketHat_Bulky with TorsoExtra or TorsoExtraVests or webbing or Cuirass
group:setExclusive("Jacket_Bulky", "TorsoExtra")
group:setExclusive("JacketHat_Bulky", "TorsoExtra")
group:setExclusive("Jacket_Bulky", "TorsoExtraVest")
group:setExclusive("JacketHat_Bulky", "TorsoExtraVest")
group:setExclusive("Jacket_Bulky", "TorsoExtraVestBullet")
group:setExclusive("JacketHat_Bulky", "TorsoExtraVestBullet")
group:setExclusive("Jacket_Bulky", "Webbing")
group:setExclusive("JacketHat_Bulky", "Webbing")
group:setExclusive("Jacket_Bulky", "SCBA")
group:setExclusive("JacketHat_Bulky", "SCBA")
group:setExclusive("Jacket_Bulky", "SCBAnotank")
group:setExclusive("JacketHat_Bulky", "SCBAnotank")
group:setExclusive("Jacket_Bulky", "Cuirass")
group:setExclusive("JacketHat_Bulky", "Cuirass")

-- webbing can't be worn with fanny packs (+ it's better)
group:setExclusive("FannyPackBack", "Webbing")
group:setExclusive("FannyPackFront", "Webbing")
-- group:setExclusive("FannyPackBack", "SCBA")
-- group:setExclusive("FannyPackFront", "SCBA")
-- group:setExclusive("FannyPackBack", "SCBAnotank")
-- group:setExclusive("FannyPackFront", "SCBAnotank")
-- they're really the same body location, holster and webbing, but for hiding the model they need to be different
group:setExclusive("ShoulderHolster", "Webbing")
group:setExclusive("SCBA", "Webbing")
group:setExclusive("SCBAnotank", "Webbing")
group:setExclusive("SCBA", "ShoulderHolster")
group:setExclusive("SCBAnotank", "ShoulderHolster")
group:setExclusive("SCBA", "Back")
group:setExclusive("SCBAnotank", "SCBA")
group:setExclusive("SCBA", "Cuirass")
group:setExclusive("SCBAnotank", "Cuirass")

-- can't wear pants or skinny pants with short pants and pantsextra etc
group:setExclusive("Pants", "ShortPants")
group:setExclusive("Pants_Skinny", "ShortPants")
group:setExclusive("Pants", "ShortsShort")
group:setExclusive("Pants_Skinny", "ShortsShort")
group:setExclusive("PantsExtra", "Pants")
group:setExclusive("PantsExtra", "Pants_Skinny")
group:setExclusive("PantsExtra", "ShortPants")
group:setExclusive("PantsExtra", "ShortsShort")
group:setExclusive("Dress", "LongDress")
group:setExclusive("Skirt", "LongSkirt")
group:setExclusive("ShortPants", "ShortsShort")
group:setExclusive("Pants", "Pants_Skinny")

-- can't wear PantsExtra with Sweater or SweaterHat
group:setExclusive("PantsExtra", "Sweater")
group:setExclusive("PantsExtra", "SweaterHat")

-- shin and knee armor
group:setExclusive("Calf_Left", "Calf_Left_Texture")
group:setExclusive("Calf_Right", "Calf_Right_Texture")
group:setExclusive("Knee_Left", "Calf_Left_Texture")
group:setExclusive("Knee_Right", "Calf_Right_Texture")
group:setExclusive("Knee_Left", "Calf_Left")
group:setExclusive("Knee_Right", "Calf_Right")

-- vambraces, can't wear vambraces and wrist watches or jewellery
group:setExclusive("ForeArm_Left","LeftWrist")
group:setExclusive("ForeArm_Right", "RightWrist")
-- Chainmail sleeves and single gloves aren't compatible with gloves
-- group:setExclusive("RightArm", "Hands")
-- group:setExclusive("LeftArm", "Hands")
-- group:setExclusive("HandsLeft","Hands")
-- group:setExclusive("HandsRight", "Hands")
-- Chainmail sleeves and single gloves aren't compatible with  each other
group:setExclusive("HandsLeft", "LeftArm")
group:setExclusive("HandsRight", "RightArm")

--can't wear neck textures with neck models (2d and 3d ties)
group:setExclusive("Neck", "Neck_Texture")


-- Backwards compatibility
group:getLocation("Tshirt"):addAlias("Top")
group:getLocation("Pants"):addAlias("Bottoms")


-- Hide items in the second location when an item is in the first location.
-- The item will still be hidden if there is a hole in the outer item.
group:setHideModel("BathRobe", "LeftWrist")
group:setHideModel("BathRobe", "RightWrist")
group:setHideModel("FullRobe", "LeftWrist")
group:setHideModel("FullRobe", "RightWrist")
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
group:setHideModel("TorsoExtraVestBullet", "FannyPackFront")
group:setHideModel("Cuirass", "FannyPackFront")
group:setHideModel("BathRobe", "FannyPackFront")
group:setHideModel("FullRobe", "FannyPackFront")
group:setHideModel("FullSuit", "FannyPackFront")
group:setHideModel("FullTop", "FannyPackFront")
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
group:setHideModel("TorsoExtraVestBullet", "FannyPackBack")
group:setHideModel("Cuirass", "FannyPackBack")
group:setHideModel("BathRobe", "FannyPackBack")
group:setHideModel("FullRobe", "FannyPackBack")
group:setHideModel("FullSuit", "FannyPackBack")
group:setHideModel("JacketHat", "FannyPackBack")
group:setHideModel("JacketHat_Bulky", "FannyPackBack")
group:setHideModel("Boilersuit", "FannyPackBack")
group:setHideModel("Sweater", "FannyPackBack")
group:setHideModel("SweaterHat", "FannyPackBack")
group:setHideModel("FullTop", "FannyPackBack")

--hiding Necklace and Necklace_Long under these clothes
group:setHideModel("BathRobe", "Necklace")
group:setHideModel("BathRobe", "Necklace_Long")
group:setHideModel("FullRobe", "Necklace")
group:setHideModel("FullRobe", "Necklace_Long")
group:setHideModel("FullSuit", "Necklace")
group:setHideModel("FullSuit", "Necklace_Long")
group:setHideModel("FullSuitHead", "Necklace")
group:setHideModel("FullSuitHead", "Necklace_Long")
group:setHideModel("FullTop", "Necklace")
group:setHideModel("FullTop", "Necklace_Long")
group:setHideModel("Jacket", "Necklace")
group:setHideModel("Jacket", "Necklace_Long")
group:setHideModel("JacketSuit", "Necklace")
group:setHideModel("JacketSuit", "Necklace_Long")
group:setHideModel("Jacket_Bulky", "Necklace")
group:setHideModel("Jacket_Bulky", "Necklace_Long")
group:setHideModel("JacketHat_Bulky", "Necklace")
group:setHideModel("JacketHat_Bulky", "Necklace_Long")
group:setHideModel("JacketHat", "Necklace")
group:setHideModel("JacketHat", "Necklace_Long")
group:setHideModel("Sweater", "Necklace")
group:setHideModel("Sweater", "Necklace_Long")
group:setHideModel("SweaterHat", "Necklace")
group:setHideModel("SweaterHat", "Necklace_Long")
group:setHideModel("Boilersuit", "Necklace")
group:setHideModel("Boilersuit", "Necklace_Long") 
group:setHideModel("Cuirass", "Necklace")
group:setHideModel("Cuirass", "Necklace_Long")
group:setHideModel("TorsoExtraVestBullet", "Necklace")
group:setHideModel("TorsoExtraVestBullet", "Necklace_Long")
group:setHideModel("TorsoExtraVest", "Necklace")
group:setHideModel("TorsoExtraVest", "Necklace_Long")
group:setHideModel("TorsoExtra", "Necklace")
group:setHideModel("TorsoExtra", "Necklace_Long") 

--hide neck models (ties) under these
group:setHideModel("Sweater","Neck")
group:setHideModel("SweaterHat","Neck")
group:setHideModel("Jersey","Neck")
group:setHideModel("Jacket","Neck")
group:setHideModel("Jacket_Down","Neck")
group:setHideModel("JacketHat","Neck")
group:setHideModel("Jacket_Bulky","Neck")
group:setHideModel("JacketHat_Bulky","Neck")
group:setHideModel("BathRobe","Neck")
group:setHideModel("FullRobe","Neck")
group:setHideModel("TorsoExtra","Neck")
group:setHideModel("FullTop","Neck")
group:setHideModel("BodyCostume","Neck")
group:setHideModel("SCBA","Neck")
group:setHideModel("SCBAnotank","Neck")
group:setHideModel("Scarf","Neck")
group:setHideModel("TorsoExtraVest","Neck")
group:setHideModel("TorsoExtraVestBullet","Neck")
group:setHideModel("Boilersuit","Neck")
group:setHideModel("PantsExtra","Neck")
--group:setHideModel("JacketSuit","Neck") --so 3d model Ties can be seen with suits
group:setHideModel("FullSuit","Neck")
group:setHideModel("FullSuitHead","Neck")
group:setHideModel("FullSuitHeadSCBA","Neck")


-- hiding shoulderholster
-- use the same attachment name as the body location so the holster and any holstered weapon is hidden as appropriate
group:setHideModel("Jacket", "ShoulderHolster")
group:setHideModel("Jacket_Down", "ShoulderHolster")
group:setHideModel("JacketSuit", "ShoulderHolster")
group:setHideModel("Jacket_Bulky", "ShoulderHolster")
-- group:setHideModel("TorsoExtra", "ShoulderHolster")
group:setHideModel("TorsoExtraVest", "ShoulderHolster")
group:setHideModel("BathRobe","ShoulderHolster")
group:setHideModel("FullRobe","ShoulderHolster")
-- group:setHideModel("FullSuit", "ShoulderHolster") -- shouldn't be worn with a shoulder holster inside as it's a hazmat suit
group:setHideModel("JacketHat", "ShoulderHolster")
group:setHideModel("JacketHat_Bulky","ShoulderHolster")
-- group:setHideModel("Boilersuit", "ShoulderHolster")
-- group:setHideModel("Sweater", "ShoulderHolster")
-- group:setHideModel("SweaterHat", "ShoulderHolster")

-- hiding ankleholster
-- use the same attachment name as the body location so the holster and any holstered weapon is hidden as appropriate
group:setHideModel("Pants", "AnkleHolster")
group:setHideModel("PantsExtra", "AnkleHolster")
group:setHideModel("LongDress", "AnkleHolster")
group:setHideModel("LongSkirt", "AnkleHolster")

--hiding items with poncho hood up and down
group:setHideModel("JacketHat", "Sweater")
group:setHideModel("JacketHat", "SweaterHat")
group:setHideModel("Jacket_Down", "Sweater")
group:setHideModel("Jacket_Down", "SweaterHat")
group:setHideModel("JacketHat", "TorsoExtraVest")
group:setHideModel("Jacket_Down", "TorsoExtraVest")
group:setHideModel("JacketHat", "TorsoExtraVestBullet")
group:setHideModel("Jacket_Down", "TorsoExtraVestBullet")
group:setHideModel("JacketHat", "Cuirass")
group:setHideModel("Jacket_Down", "Cuirass")

--hide hoodie when hood down with padded jacket
group:setHideModel("Jacket_Bulky", "Sweater")
group:setHideModel("JacketHat_Bulky", "SweaterHat")
group:setHideModel("JacketHat_Bulky", "Sweater")

--hide these under FullRobes
group:setHideModel("FullRobe", "PantsExtra")
group:setHideModel("FullRobe", "TorsoExtra")
group:setHideModel("FullRobe", "TorsoExtraVest")
group:setHideModel("FullRobe", "TorsoExtraVestBullet")
group:setHideModel("FullRobe", "Cuirass")
group:setHideModel("FullRobe", "Webbing")
group:setHideModel("FullRobe", "Gorget")
group:setHideModel("FullRobe", "Codpiece")
group:setHideModel("FullRobe", "Thigh_Left")
group:setHideModel("FullRobe", "Thigh_Right")
group:setHideModel("FullRobe", "Knee_Left")
group:setHideModel("FullRobe", "Knee_Right")
group:setHideModel("FullRobe", "Elbow_Left")
group:setHideModel("FullRobe", "Elbow_Right")
group:setHideModel("FullRobe", "ForeArm_Left")
group:setHideModel("FullRobe", "ForeArm_Right")
group:setHideModel("FullRobe", "Calf_Left")
group:setHideModel("FullRobe", "Calf_Right")
group:setHideModel("FullRobe", "Jersey")
group:setHideModel("FullRobe", "ShoulderpadLeft")
group:setHideModel("FullRobe", "ShoulderpadRight")
group:setHideModel("FullRobe", "Boilersuit")
group:setHideModel("FullRobe", "Dress")
group:setHideModel("FullRobe", "Skirt")
group:setHideModel("FullRobe", "LongDress")
group:setHideModel("FullRobe", "LongSkirt")

--hide Gorget under these clothes
group:setHideModel("Jacket_Bulky", "Gorget")
group:setHideModel("JacketHat_Bulky", "Gorget")
group:setHideModel("SweaterHat", "Gorget")
group:setHideModel("Sweater", "Gorget")
group:setHideModel("Jacket_Down", "Gorget")
group:setHideModel("FullSuit", "Gorget")
group:setHideModel("Boilersuit", "Gorget")

--Hide Codpiece under these
group:setHideModel("Skirt", "Codpiece")
group:setHideModel("Dress", "Codpiece")
group:setHideModel("LongSkirt", "Codpiece")
group:setHideModel("LongDress", "Codpiece")
group:setHideModel("FullSuit", "Codpiece")
group:setHideModel("FullSuitHead", "Codpiece")
-- group:setHideModel("Jacket", "Codpiece")
group:setHideModel("Jacket_Down", "Codpiece")
group:setHideModel("JacketSuit", "Codpiece")
-- group:setHideModel("Jacket_Bulky", "Codpiece")
--group:setHideModel("TorsoExtra", "Codpiece")
--group:setHideModel("TorsoExtraVest", "Codpiece")
--group:setHideModel("TorsoExtraVestBullet", "Codpiece")
--group:setHideModel("Cuirass", "Codpiece")
group:setHideModel("BathRobe", "Codpiece")
group:setHideModel("JacketHat", "Codpiece")
group:setHideModel("JacketHat_Bulky", "Codpiece")
group:setHideModel("Sweater", "Codpiece")
group:setHideModel("SweaterHat", "Codpiece")


--hide calf, knee and thigh models (greaves) with long dresses and skirts
group:setHideModel("LongDress", "Calf_Left")
group:setHideModel("LongDress", "Calf_Right")
group:setHideModel("LongSkirt", "Calf_Left")
group:setHideModel("LongSkirt", "Calf_Right")
group:setHideModel("LongDress", "Knee_Left")
group:setHideModel("LongDress", "Knee_Right")
group:setHideModel("LongSkirt", "Knee_Left")
group:setHideModel("LongSkirt", "Knee_Right")
group:setHideModel("LongDress", "Thigh_Left")
group:setHideModel("LongDress", "Thigh_Right")
group:setHideModel("LongSkirt", "Thigh_Left")
group:setHideModel("LongSkirt", "Thigh_Right")

--hide thigh models with shorter dresses and skirt
group:setHideModel("Dress", "Thigh_Left")
group:setHideModel("Dress", "Thigh_Right")
group:setHideModel("Skirt", "Thigh_Left")
group:setHideModel("Skirt", "Thigh_Right")

--hide calf, knee and thigh models (greaves) with FullSuits and FullSuitHead
group:setHideModel("FullSuitHead", "Calf_Left")
group:setHideModel("FullSuitHead", "Calf_Right")
group:setHideModel("FullSuit", "Calf_Left")
group:setHideModel("FullSuit", "Calf_Right")
group:setHideModel("FullSuitHead", "Knee_Left")
group:setHideModel("FullSuitHead", "Knee_Right")
group:setHideModel("FullSuit", "Knee_Left")
group:setHideModel("FullSuit", "Knee_Right")
group:setHideModel("FullSuitHead", "Thigh_Left")
group:setHideModel("FullSuitHead", "Thigh_Right")
group:setHideModel("FullSuit", "Thigh_Left")
group:setHideModel("FullSuit", "Thigh_Right")

--hide Forearm models under Bulky Jackets
--group:setHideModel("Jacket_Bulky", "ForeArm_Left")
--group:setHideModel("Jacket_Bulky", "ForeArm_Right")
--group:setHideModel("JacketHat_Bulky", "ForeArm_Left")
--group:setHideModel("JacketHat_Bulky", "ForeArm_Right")

-- Multiple items at these locations are allowed.
group:setMultiItem("Bandage", true)
group:setMultiItem("Wound", true)
group:setMultiItem("ZedDmg", true)

--Hide jumpers under Jackets
--group:setHideModel("Jacket", "Sweater")

--hide Sport Shoulderpads under Jersey
group:setHideModel("Jersey", "SportShoulderpad")

--hide Jersey under Jackets and Sweaters
group:setHideModel("Sweater", "Jersey")
group:setHideModel("SweaterHat", "Jersey")
group:setHideModel("Jacket", "Jersey")
group:setHideModel("JacketHat", "Jersey")
group:setHideModel("Jacket_Bulky", "Jersey")
group:setHideModel("JacketHat_Bulky", "Jersey")
group:setHideModel("JacketSuit", "Jersey")
group:setHideModel("Jacket_Down", "Jersey")
group:setHideModel("Boilersuit", "Jersey")
group:setHideModel("FullTop", "Jersey")

--hide Thigh armour models with Jacket Suits, Bathrobs and Ponchos
group:setHideModel("JacketSuit", "Thigh_Right")
group:setHideModel("JacketSuit", "Thigh_Left")
group:setHideModel("JacketHat", "Thigh_Right")
group:setHideModel("JacketHat", "Thigh_Left")
group:setHideModel("Jacket_Down", "Thigh_Right")
group:setHideModel("Jacket_Down", "Thigh_Left")
group:setHideModel("BathRobe", "Thigh_Right")
group:setHideModel("BathRobe", "Thigh_Left")

-- define alt models used to avoid clipping
-- use alternative models for the second location when an item is in the first location.

--use alternate bandana mask and balaclava when hoods up on clothes
group:setAltModel("JacketHat_Bulky", "Mask")
group:setAltModel("JacketHat", "Mask")
group:setAltModel("SweaterHat", "Mask")

group:setAltModel("Pants", "Calf_Left")
group:setAltModel("Pants", "Calf_Right")
group:setAltModel("PantsExtra", "Calf_Left")
group:setAltModel("PantsExtra", "Calf_Right")
group:setAltModel("Boilersuit", "Calf_Left")
group:setAltModel("Boilersuit", "Calf_Right")
--group:setAltModel("ShortPants", "Calf_Left")
--group:setAltModel("ShortPants", "Calf_Right")
--Vambraces
group:setAltModel("JacketSuit", "ForeArm_Left")
group:setAltModel("JacketSuit", "ForeArm_Right")
group:setAltModel("Jacket", "ForeArm_Left")
group:setAltModel("Jacket", "ForeArm_Right")
group:setAltModel("Sweater", "ForeArm_Left")
group:setAltModel("Sweater", "ForeArm_Right")
group:setAltModel("SweaterHat", "ForeArm_Left")
group:setAltModel("SweaterHat", "ForeArm_Right")
group:setAltModel("Jacket_Bulky", "ForeArm_Left")
group:setAltModel("Jacket_Bulky", "ForeArm_Right")
group:setAltModel("JacketHat_Bulky", "ForeArm_Left")
group:setAltModel("JacketHat_Bulky", "ForeArm_Right")
group:setAltModel("Boilersuit", "ForeArm_Left")
group:setAltModel("Boilersuit", "ForeArm_Right")
group:setAltModel("FullSuitHead", "ForeArm_Left")
group:setAltModel("FullSuitHead", "ForeArm_Right")
group:setAltModel("FullSuit", "ForeArm_Left")
group:setAltModel("FullSuit", "ForeArm_Right")
group:setAltModel("BathRobe", "ForeArm_Left")
group:setAltModel("BathRobe", "ForeArm_Right")
--Football shoulderpads
group:setAltModel("SportShoulderpad", "Jersey")
--Kneepads
group:setAltModel("Pants", "Knee_Left")
group:setAltModel("Pants", "Knee_Right")
group:setAltModel("PantsExtra", "Knee_Left")
group:setAltModel("PantsExtra", "Knee_Right")
group:setAltModel("Boilersuit", "Knee_Left")
group:setAltModel("Boilersuit", "Knee_Right")
group:setAltModel("ShortPants", "Knee_Left")
group:setAltModel("ShortPants", "Knee_Right")
--Single shoulderpad
group:setAltModel("Jacket", "ShoulderpadRight")
group:setAltModel("JacketSuit", "ShoulderpadRight")
group:setAltModel("Jacket_Bulky", "ShoulderpadRight")
group:setAltModel("JacketHat_Bulky", "ShoulderpadRight")
group:setAltModel("Boilersuit", "ShoulderpadRight")
group:setAltModel("FullSuit", "ShoulderpadRight")
group:setAltModel("Sweater", "ShoulderpadRight")
group:setAltModel("SweaterHat", "ShoulderpadRight")
group:setAltModel("Jersey", "ShoulderpadRight")
group:setAltModel("TorsoExtraVest", "ShoulderpadRight")
group:setAltModel("TorsoExtraVestBullet", "ShoulderpadRight")

group:setAltModel("Jacket", "ShoulderpadLeft")
group:setAltModel("JacketSuit", "ShoulderpadLeft")
group:setAltModel("Jacket_Bulky", "ShoulderpadLeft")
group:setAltModel("JacketHat_Bulky", "ShoulderpadLeft")
group:setAltModel("Boilersuit", "ShoulderpadLeft")
group:setAltModel("FullSuit", "ShoulderpadLeft")
group:setAltModel("Sweater", "ShoulderpadLeft")
group:setAltModel("SweaterHat", "ShoulderpadLeft")
group:setAltModel("Jersey", "ShoulderpadLeft")
group:setAltModel("TorsoExtraVest", "ShoulderpadLeft")
group:setAltModel("TorsoExtraVestBullet", "ShoulderpadLeft")

--Elbow Pads
group:setAltModel("Jacket", "Elbow_Left")
group:setAltModel("JacketSuit", "Elbow_Left")
group:setAltModel("Jacket_Bulky", "Elbow_Left")
group:setAltModel("JacketHat_Bulky", "Elbow_Left")
group:setAltModel("Boilersuit", "Elbow_Left")
group:setAltModel("FullSuit", "Elbow_Left")
group:setAltModel("Sweater", "Elbow_Left")
group:setAltModel("SweaterHat", "Elbow_Left")
group:setAltModel("Jersey", "Elbow_Left")
group:setAltModel("FullSuitHead", "Elbow_Left")
group:setAltModel("FullSuit", "Elbow_Left")

group:setAltModel("Jacket", "Elbow_Right")
group:setAltModel("JacketSuit", "Elbow_Right")
group:setAltModel("Jacket_Bulky", "Elbow_Right")
group:setAltModel("JacketHat_Bulky", "Elbow_Right")
group:setAltModel("Boilersuit", "Elbow_Right")
group:setAltModel("FullSuit", "Elbow_Right")
group:setAltModel("Sweater", "Elbow_Right")
group:setAltModel("SweaterHat", "Elbow_Right")
group:setAltModel("Jersey", "Elbow_Right")
group:setAltModel("FullSuitHead", "Elbow_Right")
group:setAltModel("FullSuit", "Elbow_Right")

--Thigh Armour

group:setAltModel("Pants", "Thigh_Right")
group:setAltModel("PantsExtra", "Thigh_Right")
group:setAltModel("Boilersuit", "Thigh_Right")
group:setAltModel("ShortPants", "Thigh_Right")
group:setAltModel("ShortsShort", "Thigh_Right")

group:setAltModel("Pants", "Thigh_Left")
group:setAltModel("PantsExtra", "Thigh_Left")
group:setAltModel("Boilersuit", "Thigh_Left")
group:setAltModel("ShortPants", "Thigh_Left")
group:setAltModel("ShortsShort", "Thigh_Left")

--Cuirass
group:setAltModel("Jacket", "Cuirass")
group:setAltModel("Boilersuit", "Cuirass")
group:setAltModel("Sweater", "Cuirass")
group:setAltModel("SweaterHat", "Cuirass")
group:setAltModel("JacketSuit", "Cuirass")

--Codpiece
group:setAltModel("Pants", "Codpiece")
group:setAltModel("ShortsShort", "Codpiece")
group:setAltModel("ShortPants", "Codpiece")
group:setAltModel("Boilersuit", "Codpiece")
group:setAltModel("PantsExtra", "Codpiece")

--Webbing
group:setAltModel("Jacket", "Webbing")
group:setAltModel("Sweater", "Webbing")
group:setAltModel("SweaterHat", "Webbing")
group:setAltModel("Cuirass", "Webbing")
group:setAltModel("TorsoExtraVestBullet", "Webbing")