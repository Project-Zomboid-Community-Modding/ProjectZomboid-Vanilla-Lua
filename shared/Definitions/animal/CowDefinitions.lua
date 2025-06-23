--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 25/01/2022
-- Time: 10:08
-- To change this template use File | Settings | File Templates.
--

AnimalDefinitions = AnimalDefinitions or {};

-- stages
AnimalDefinitions.stages = AnimalDefinitions.stages or {}; -- animal can go thru several stage, it's used to either change body type (3D models), size, or simply allow or not to have baby etc.
AnimalDefinitions.stages["cow"] = {};
AnimalDefinitions.stages["cow"].stages = {};
AnimalDefinitions.stages["cow"].stages["cowcalf"] = {};
AnimalDefinitions.stages["cow"].stages["cowcalf"].ageToGrow = 6 * 30; -- in days, how muh time it'll take to reach the next stage, each day the animal will grow in size, at 0 days it'll be at min size, at the ageToGrow number it'll be at max (it depend how well fed the animal was tho)
--AnimalDefinitions.stages["cow"].stages["cowcalf"].ageToGrow = 10;
AnimalDefinitions.stages["cow"].stages["cowcalf"].nextStage = "cow"; -- what the animal will become once ageToGrow has been reached, this is for female
AnimalDefinitions.stages["cow"].stages["cowcalf"].nextStageMale = "bull"; -- what the animal will become once ageToGrow has been reached, this is for male
AnimalDefinitions.stages["cow"].stages["cow"] = {};
AnimalDefinitions.stages["cow"].stages["cow"].ageToGrow = 12 * 30; -- notice we don't define a next stage for the cow, as it's our final stage, this number is here so i can make the cow grows to max size at this number (depending again, on stats like thirst & hunger)
--AnimalDefinitions.stages["cow"].stages["cow"].ageToGrow = 10;
AnimalDefinitions.stages["cow"].stages["bull"] = {};
AnimalDefinitions.stages["cow"].stages["bull"].ageToGrow = 12 * 30;
--AnimalDefinitions.stages["cow"].stages["bull"].ageToGrow = 10;

-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["cow"] = {}; -- animals can have several breed, it'll change its stats & skin
AnimalDefinitions.breeds["cow"].breeds = {};
AnimalDefinitions.breeds["cow"].breeds["angus"] = {}; -- meat cow
AnimalDefinitions.breeds["cow"].breeds["angus"].name = "angus"; -- name for translation
AnimalDefinitions.breeds["cow"].breeds["angus"].texture = "Cow_Black"; -- female texture, list separated by ','
AnimalDefinitions.breeds["cow"].breeds["angus"].textureMale = "Bull_Black"; -- male texture
AnimalDefinitions.breeds["cow"].breeds["angus"].rottenTexture = "CowBlack_Rotting";
AnimalDefinitions.breeds["cow"].breeds["angus"].milkType = "CowMilk"; -- what type of milk we get when milking the cow
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes = {}; -- you want to force some dominant genes (always given to the baby) for some breed, like a angus is a beefy cow, but yield poor milk (both of those genes should be dominant, you want poor milk so it eat less, and you care only for the meat, etc.)
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["maxMilk"] = {}; -- this means maxMilk will always be dominant if you spawn an angus, we set it specific to this breed because an angus never have lots of milk, that's part of this breed, the more milk, the more she eats/the less meat ratio she has..
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["maxMilk"].minValue = 0.05;
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["maxMilk"].maxValue = 0.2;
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["meatRatio"] = {};
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["meatRatio"].minValue = 0.75;
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["meatRatio"].maxValue = 0.95;
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["maxWeight"] = {};
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["maxWeight"].minValue = 0.45;
AnimalDefinitions.breeds["cow"].breeds["angus"].forcedGenes["maxWeight"].maxValue = 0.65;
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconMale = "Item_CowBlack_Calf"; -- when picked in inventory, show this icon, we can only take the calf for cows, but chicken you could take the rooster, hen or chick.
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconFemale = "Item_CowBlack_Calf";
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconBaby = "Item_CowBlack_Calf";
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconMaleDead = "Item_CowBlackMale_Dead"; -- when animal is dead and in inventory
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconFemaleDead = "Item_CowBlack_Dead";
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconBabyDead = "Item_CowBlack_Calf_Dead";
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconMaleSkel = "Item_Skeleton_Cow_Bull";
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconFemaleSkel = "Item_Skeleton_Cow";
AnimalDefinitions.breeds["cow"].breeds["angus"].invIconBabySkel = "Item_Skeleton_Cow_Calf";
AnimalDefinitions.breeds["cow"].breeds["simmental"] = {}; -- balanced (meat/milk) cow
AnimalDefinitions.breeds["cow"].breeds["simmental"].name = "simmental";
AnimalDefinitions.breeds["cow"].breeds["simmental"].texture = "Cow_Brown_01,Cow_Brown_02,Cow_Brown_03";
AnimalDefinitions.breeds["cow"].breeds["simmental"].textureMale = "Bull_Brown_01";
AnimalDefinitions.breeds["cow"].breeds["simmental"].rottenTexture = "CowBrown_Rotting";
AnimalDefinitions.breeds["cow"].breeds["simmental"].milkType = "CowMilk";
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes = {};
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["maxWeight"] = {};
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["maxWeight"].minValue = 0.5;
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["maxWeight"].maxValue = 0.7;
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["maxMilk"].minValue = 0.3;
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["maxMilk"].maxValue = 0.5;
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["meatRatio"] = {};
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["meatRatio"].minValue = 0.55;
AnimalDefinitions.breeds["cow"].breeds["simmental"].forcedGenes["meatRatio"].maxValue = 0.75;
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconMale = "Item_CowBrown_Calf";
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconFemale = "Item_CowBrown_Calf";
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconBaby = "Item_CowBrown_Calf";
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconMaleDead = "Item_CowBrownMale_Dead";
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconFemaleDead = "Item_CowBrown_Dead";
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconBabyDead = "Item_CowBrown_Calf_Dead";
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconMaleSkel = "Item_Skeleton_Cow_Bull";
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconFemaleSkel = "Item_Skeleton_Cow";
AnimalDefinitions.breeds["cow"].breeds["simmental"].invIconBabySkel = "Item_Skeleton_Cow_Calf";
AnimalDefinitions.breeds["cow"].breeds["holstein"] = {};
AnimalDefinitions.breeds["cow"].breeds["holstein"].name = "holstein"; -- dairy cow
AnimalDefinitions.breeds["cow"].breeds["holstein"].texture = "Cow_BW_01,Cow_BW_02,Cow_BW_03";
AnimalDefinitions.breeds["cow"].breeds["holstein"].textureMale = "Bull_BW_01";
AnimalDefinitions.breeds["cow"].breeds["holstein"].rottenTexture = "CowBW_Rotting";
AnimalDefinitions.breeds["cow"].breeds["holstein"].milkType = "CowMilk";
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes = {};
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["maxMilk"].minValue = 0.60;
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["maxMilk"].maxValue = 0.75
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["meatRatio"] = {};
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["meatRatio"].minValue = 0.35; -- the holstein shouldn't have a good meatRatio, it's breed for milk, not meat, but as we have a maxMilk to meatRatio correlation defined in AnimalGenomeDefinitions, the meatRatio will suffer by this ratio, depending on the maxMilk, so it'll be way less in the end
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["meatRatio"].maxValue = 0.55;
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["maxWeight"] = {};
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["maxWeight"].minValue = 0.6; -- holstein tend to get bbigger/fatter, but still give less meat (less muscles)
AnimalDefinitions.breeds["cow"].breeds["holstein"].forcedGenes["maxWeight"].maxValue = 0.8;
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconMale = "Item_CowSpotted_Calf";
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconFemale = "Item_CowSpotted_Calf";
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconBaby = "Item_CowSpotted_Calf";
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconMaleDead = "Item_CowBlackWhiteMale_Dead";
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconFemaleDead = "Item_CowBlackWhite_Dead";
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconBabyDead = "Item_CowSpotted_Calf_Dead";
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconMaleSkel = "Item_Skeleton_Cow_Bull";
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconFemaleSkel = "Item_Skeleton_Cow";
AnimalDefinitions.breeds["cow"].breeds["holstein"].invIconBabySkel = "Item_Skeleton_Cow_Calf";

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {}; -- all the genes this animal will have
AnimalDefinitions.genome["cow"] = {};
AnimalDefinitions.genome["cow"].genes = {};
AnimalDefinitions.genome["cow"].genes["maxSize"] = "maxSize"; -- total size of the 3D model
AnimalDefinitions.genome["cow"].genes["meatRatio"] = "meatRatio"; -- weight to meat ratio
AnimalDefinitions.genome["cow"].genes["maxWeight"] = "maxWeight" -- affect the total weight of the animal (this also depend on its size)
AnimalDefinitions.genome["cow"].genes["lifeExpectancy"] = "lifeExpectancy"; -- average life (modify maxAgeGeriatric, so affect baby chance when old etc.)
AnimalDefinitions.genome["cow"].genes["maxMilk"] = "maxMilk"; -- affect max & min milk of the animal
AnimalDefinitions.genome["cow"].genes["milkInc"] = "milkInc"; -- affect how fast an animal produce milk
AnimalDefinitions.genome["cow"].genes["resistance"] = "resistance"; -- affect how much health the animal will lose under certain condition (when hungry/thirsty, when taking damage..)
AnimalDefinitions.genome["cow"].genes["strength"] = "strength"; --  affect animal ability to inflict dmg
AnimalDefinitions.genome["cow"].genes["hungerResistance"] = "hungerResistance"; -- affect the hunger loss per hour of the animal
AnimalDefinitions.genome["cow"].genes["thirstResistance"] = "thirstResistance"; -- affect the thirst loss per hour of the animal
AnimalDefinitions.genome["cow"].genes["aggressiveness"] = "aggressiveness"; -- affect how much the animal will try to hit other animals/humans
AnimalDefinitions.genome["cow"].genes["ageToGrow"] = "ageToGrow"; -- age to grow will be increased by this gene
AnimalDefinitions.genome["cow"].genes["fertility"] = "fertility"; -- ability to get a baby
AnimalDefinitions.genome["cow"].genes["stress"] = "stress";  -- affect the starting stress on an animal, how fast it goes down and up (the bigger -> the more stress the animal gain/the less it lose)

-- animals
AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["cowcalf"] = {};
AnimalDefinitions.animals["cowcalf"].bodyModel = "CowCalf_Body";
AnimalDefinitions.animals["cowcalf"].bodyModelSkel = "CowCalf_Skeleton";
AnimalDefinitions.animals["cowcalf"].textureSkeleton = "Bull_Skeleton";
AnimalDefinitions.animals["cowcalf"].textureSkeletonBloody = "CowBull_Skeleton_Butchered";
AnimalDefinitions.animals["cowcalf"].bodyModelSkelNoHead = "Calf_Skeleton_NoHead";
AnimalDefinitions.animals["cowcalf"].animset = "cowcalf";
AnimalDefinitions.animals["cowcalf"].modelscript = "CowCalf_Body";
AnimalDefinitions.animals["cowcalf"].bodyModelHeadless = "CowCalf_Headless";
AnimalDefinitions.animals["cowcalf"].textureSkinned = "Cow_Skinned";
AnimalDefinitions.animals["cowcalf"].shadoww = 0.5;
AnimalDefinitions.animals["cowcalf"].shadowfm = 1;
AnimalDefinitions.animals["cowcalf"].shadowbm = 1;
AnimalDefinitions.animals["cowcalf"].turnDelta = 0.9;
AnimalDefinitions.animals["cowcalf"].animalSize = 0.1;
AnimalDefinitions.animals["cowcalf"].minSize = 0.9;
AnimalDefinitions.animals["cowcalf"].maxSize = 1.2;
AnimalDefinitions.animals["cowcalf"].genes = AnimalDefinitions.genome["cow"].genes;
AnimalDefinitions.animals["cowcalf"].stages = AnimalDefinitions.stages["cow"].stages;
AnimalDefinitions.animals["cowcalf"].breeds = copyTable(AnimalDefinitions.breeds["cow"].breeds);
AnimalDefinitions.animals["cowcalf"].alwaysFleeHumans = false;
AnimalDefinitions.animals["cowcalf"].canBeAttached = true;
AnimalDefinitions.animals["cowcalf"].minEnclosureSize = 40;
AnimalDefinitions.animals["cowcalf"].wanderMul = 300; -- the smaller the more the animal will wander around (walk for no particular reason)
AnimalDefinitions.animals["cowcalf"].hungerMultiplier = 0.001;
AnimalDefinitions.animals["cowcalf"].thirstMultiplier = 0.002;
AnimalDefinitions.animals["cowcalf"].idleTypeNbr = 4;
AnimalDefinitions.animals["cowcalf"].idleEmoteChance = 700;
AnimalDefinitions.animals["cowcalf"].eatFromMother = true; -- look out for its mother to eat milk
AnimalDefinitions.animals["cowcalf"].periodicRun = true; -- sometimes a calf will run, never far from mom, just to train its legs?
AnimalDefinitions.animals["cowcalf"].healthLossMultiplier = 0.05;
AnimalDefinitions.animals["cowcalf"].minWeight = 60;
AnimalDefinitions.animals["cowcalf"].maxWeight = 350;
AnimalDefinitions.animals["cowcalf"].hungerBoost = 3;
AnimalDefinitions.animals["cowcalf"].thirstBoost = 3;
AnimalDefinitions.animals["cowcalf"].carcassItem = "Base.CorpseCalf"; -- when we butcher the corpse of an animal, we generate a carcass
AnimalDefinitions.animals["cowcalf"].trailerBaseSize = 120; -- the base size (it's multiply by current animal size) that the animal take inside a trailer
AnimalDefinitions.animals["cowcalf"].canBePet = true;
AnimalDefinitions.animals["cowcalf"].canBePicked = true;
AnimalDefinitions.animals["cowcalf"].baseEncumbrance = 80;
AnimalDefinitions.animals["cowcalf"].luredPossibleItems = {{name="Base.HayTuft", chance=30},{name="Base.GrassTuft", chance=50}};
AnimalDefinitions.animals["cowcalf"].collisionSize = 0.3;
AnimalDefinitions.animals["cowcalf"].canThump = false;
AnimalDefinitions.animals["cowcalf"].group = "cow"; -- just used for debug menu to spawn animal
AnimalDefinitions.animals["cowcalf"].dung = "Dung_Cow";
AnimalDefinitions.animals["cowcalf"].ropeBone = "Bip01_Neck";
AnimalDefinitions.animals["cowcalf"].stressAboveGround = true; -- lots of animals will gain high stress while above ground
AnimalDefinitions.animals["cowcalf"].dungChancePerDay = 70;
AnimalDefinitions.animals["cowcalf"].distToEat = 1; -- dist at which we trigger the eat from trough or ground
AnimalDefinitions.animals["cowcalf"].minBlood = 500; -- when butchering you can take off the blood, depending on animal's size the amount of blood will be between min & max, in cl (so 100 = 1L)
AnimalDefinitions.animals["cowcalf"].maxBlood = 1000;
AnimalDefinitions.animals["cowcalf"].thirstHungerTrigger = 0.4;
AnimalDefinitions.animals["cowcalf"].corpseSize = 2.5; -- this is used to make the cars bump higher when driving over a corpse, here 2x compared to normal (it's a float)
AnimalDefinitions.animals["cowcalf"].idleSoundRadius = 20; -- to attract zombies when playing idle sound
AnimalDefinitions.animals["cowcalf"].idleSoundVolume = 10;

AnimalDefinitions.animals["cow"] = {};
AnimalDefinitions.animals["cow"].bodyModel = "CowBody"; -- the 3D model
AnimalDefinitions.animals["cow"].bodyModelSkel = "Cow_Skeleton";
AnimalDefinitions.animals["cow"].textureSkeleton = "Bull_Skeleton";
AnimalDefinitions.animals["cow"].textureSkeletonBloody = "CowBull_Skeleton_Butchered";
AnimalDefinitions.animals["cow"].textureSkinned = "Cow_Skinned";
AnimalDefinitions.animals["cow"].bodyModelHeadless = "Cow_Headless";
AnimalDefinitions.animals["cow"].bodyModelSkelNoHead = "Cow_Skeleton_NoHead";
AnimalDefinitions.animals["cow"].animset = "cow"; -- the anim set in animzed
AnimalDefinitions.animals["cow"].modelscript = "CowBody";
AnimalDefinitions.animals["cow"].shadoww = 1; -- width shadow on ground, all shadows scale according to the size, so you need to define this shadow based on animal size = 1
AnimalDefinitions.animals["cow"].shadowfm = 3; -- forward shadow position on ground (that and shadowbm define the length of the shadow)
AnimalDefinitions.animals["cow"].shadowbm = 2; -- backward shadow position on ground
AnimalDefinitions.animals["cow"].turnDelta = 0.9; -- how fast the animal turn, higher number = faster turn
AnimalDefinitions.animals["cow"].animalSize = 0.3; -- used for pathfinding, bigger animals need a bigger number, so when we calculate if the animal is arrived at destination, we use this for an error margin
AnimalDefinitions.animals["cow"].minSize = 0.9; -- minimum size for the model, this will be at age 0
AnimalDefinitions.animals["cow"].maxSize = 1.1; -- the max model size the animal will be, every day the size grow a bit, depending on its current stage ageToGrow, basically at 0 days it'll be size "minSize", once its survived days reach stage.ageToGrow it'll be this number, if the animal was well feed/watered
AnimalDefinitions.animals["cow"].minAge = AnimalDefinitions.stages["cow"].stages["cowcalf"].ageToGrow; -- Used for stage grow, mainly for debug, so you can't set a cow at age 0, as it should be a calf, if we spawn a cow it'll be this age by default (as a calf takes one year to become a cow, its min age will be 360 days)
AnimalDefinitions.animals["cow"].babyType = "cowcalf"; -- the baby the animal will have
AnimalDefinitions.animals["cow"].sitRandomly = true; -- animal will randomly sit, like cows
AnimalDefinitions.animals["cow"].minAgeForBaby = 12 * 30; -- 12 months, the minimum age required to get a baby
--AnimalDefinitions.animals["cow"].minAgeForBaby = 10 * 30;
AnimalDefinitions.animals["cow"].maxAgeGeriatric = 12 * 12 * 30; -- 12 years, the more we get to this age, the less milk we gonna produce, and animal won't be able to have baby no more
AnimalDefinitions.animals["cow"].udder = true; -- if there's a udder, animal will produce milk
AnimalDefinitions.animals["cow"].female = true; -- gender, yeah, male can't have babies btw
AnimalDefinitions.animals["cow"].genes = AnimalDefinitions.genome["cow"].genes;
AnimalDefinitions.animals["cow"].stages = AnimalDefinitions.stages["cow"].stages;
AnimalDefinitions.animals["cow"].breeds = AnimalDefinitions.breeds["cow"].breeds;
AnimalDefinitions.animals["cow"].alwaysFleeHumans = false; -- animal can flee or not humans
AnimalDefinitions.animals["cow"].canBeAttached = true; -- can be attached with a rope
AnimalDefinitions.animals["cow"].wanderMul = 1500; -- the smaller the more the animal will wander around (walk for no particular reason)
AnimalDefinitions.animals["cow"].minEnclosureSize = 80; -- enclosure size in square numbers, if animal is under this number, he'll grow less big
AnimalDefinitions.animals["cow"].hungerMultiplier = 0.0035; -- per hour, set it to 0 to ignore hunger (for rat etc.)
AnimalDefinitions.animals["cow"].thirstMultiplier = 0.0065; -- per hour, set it to 0 to ignore thirst (for rat etc.)
AnimalDefinitions.animals["cow"].idleTypeNbr = 4; -- idle action, check in animation, used to make animals turn his head or whatever
AnimalDefinitions.animals["cow"].eatGrass = true; -- eat grass on floor, different from eating grass in a feeding trough
AnimalDefinitions.animals["cow"].pregnantPeriod = (9 * 30) + 10; -- 9 months and 10 days
AnimalDefinitions.animals["cow"].idleEmoteChance = 900; -- 1 in 900 per ticks the animal will play one if it's idle animation
--AnimalDefinitions.animals["cow"].pregnantPeriod = 3;
AnimalDefinitions.animals["cow"].healthLossMultiplier = 0.01; -- when hunger or thirst is under a certain treshold, health start to be reduced
AnimalDefinitions.animals["cow"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits"; -- what the animal can eat in a feeding trough, list separated by ','
AnimalDefinitions.animals["cow"].canBeMilked = true; -- you can have milk but not allow to be milked (pigs..)
AnimalDefinitions.animals["cow"].minMilk = 10; -- starting min milk, everytime you milk 5L, we gonna increase this by 1L, until maxMilk is reached
AnimalDefinitions.animals["cow"].maxMilk = 50; -- the max milk this animal can reach, if the current milk is near this number the animal will start to drop health, milk is affected by genes
AnimalDefinitions.animals["cow"].minWeight = 360;
AnimalDefinitions.animals["cow"].maxWeight = 950;
AnimalDefinitions.animals["cow"].carcassItem = "Base.CorpseCow";
AnimalDefinitions.animals["cow"].attackDist = 2;
AnimalDefinitions.animals["cow"].baseEncumbrance = 130;
AnimalDefinitions.animals["cow"].attackTimer = 8200;
AnimalDefinitions.animals["cow"].baseDmg = 0.3;
AnimalDefinitions.animals["cow"].milkAnimPreset = "Cow";
AnimalDefinitions.animals["cow"].trailerBaseSize = 400;
AnimalDefinitions.animals["cow"].canBePet = true;
AnimalDefinitions.animals["cow"].luredPossibleItems = AnimalDefinitions.animals["cowcalf"].luredPossibleItems;
AnimalDefinitions.animals["cow"].collisionSize = 0.5; -- this is the base size for collision detection, we also gonna take in account the current animal size (fully grown will need bigger collision radius compared to young ones)
AnimalDefinitions.animals["cow"].timeBeforeNextPregnancy = 70; -- in days
AnimalDefinitions.animals["cow"].thirstHungerTrigger = 0.3; -- this mean animal will look to drink/eat only when his hunger/thirst are >= 0.3. (default is 0.1)
AnimalDefinitions.animals["cow"].group = "cow";
AnimalDefinitions.animals["cow"].dung = "Dung_Cow"; -- dung item that'll be dropped on ground by animal
AnimalDefinitions.animals["cow"].ropeBone = "Bip01_Neck"; -- the rope needs to be attached to an animal bone to calculate the correct vector
AnimalDefinitions.animals["cow"].stressAboveGround = true;
AnimalDefinitions.animals["cow"].dungChancePerDay = 70;
AnimalDefinitions.animals["cow"].minBlood = 1000;
AnimalDefinitions.animals["cow"].maxBlood = 3500;
AnimalDefinitions.animals["cow"].corpseSize = 7;
AnimalDefinitions.animals["cow"].idleSoundRadius = 50;
AnimalDefinitions.animals["cow"].idleSoundVolume = 30;

AnimalDefinitions.animals["bull"] = {};
AnimalDefinitions.animals["bull"].bodyModel = "Bull_Body";
AnimalDefinitions.animals["bull"].bodyModelSkel = "Bull_Skeleton";
AnimalDefinitions.animals["bull"].textureSkeleton = "Bull_Skeleton";
AnimalDefinitions.animals["bull"].textureSkeletonBloody = "CowBull_Skeleton_Butchered";
AnimalDefinitions.animals["bull"].bodyModelSkelNoHead = "Bull_Skeleton_NoHead";
AnimalDefinitions.animals["bull"].animset = "cow";
AnimalDefinitions.animals["bull"].modelscript = "Bull_Body";
AnimalDefinitions.animals["bull"].textureSkinned = "Cow_Skinned";
AnimalDefinitions.animals["bull"].bodyModelHeadless = "Bull_Headless";
AnimalDefinitions.animals["bull"].shadoww = AnimalDefinitions.animals["cow"].shadoww;
AnimalDefinitions.animals["bull"].shadowfm = AnimalDefinitions.animals["cow"].shadowfm;
AnimalDefinitions.animals["bull"].shadowbm = AnimalDefinitions.animals["cow"].shadowbm;
AnimalDefinitions.animals["bull"].sitRandomly = AnimalDefinitions.animals["cow"].sitRandomly;
AnimalDefinitions.animals["bull"].eatGrass = AnimalDefinitions.animals["cow"].eatGrass;
AnimalDefinitions.animals["bull"].turnDelta = AnimalDefinitions.animals["cow"].turnDelta;
AnimalDefinitions.animals["bull"].animalSize = AnimalDefinitions.animals["cow"].animalSize;
AnimalDefinitions.animals["bull"].minSize = AnimalDefinitions.animals["cow"].minSize;
AnimalDefinitions.animals["bull"].maxSize = AnimalDefinitions.animals["cow"].maxSize;
AnimalDefinitions.animals["bull"].minAge = AnimalDefinitions.animals["cow"].minAge;
AnimalDefinitions.animals["bull"].maxAgeGeriatric = AnimalDefinitions.animals["cow"].maxAgeGeriatric;
AnimalDefinitions.animals["bull"].male = true;
AnimalDefinitions.animals["bull"].idleEmoteChance = AnimalDefinitions.animals["cow"].idleEmoteChance;
AnimalDefinitions.animals["bull"].minAgeForBaby = 10 * 30;
AnimalDefinitions.animals["bull"].babyType = AnimalDefinitions.animals["cow"].babyType;
AnimalDefinitions.animals["bull"].mate = "cow"; -- look for this animal when trying for babies
AnimalDefinitions.animals["bull"].genes = AnimalDefinitions.genome["cow"].genes;
AnimalDefinitions.animals["bull"].stages = AnimalDefinitions.stages["cow"].stages;
AnimalDefinitions.animals["bull"].breeds = copyTable(AnimalDefinitions.breeds["cow"].breeds);
AnimalDefinitions.animals["bull"].alwaysFleeHumans = AnimalDefinitions.animals["cow"].alwaysFleeHumans;
AnimalDefinitions.animals["bull"].canBeAttached = AnimalDefinitions.animals["cow"].canBeAttached;
AnimalDefinitions.animals["bull"].wanderMul = AnimalDefinitions.animals["cow"].wanderMul;
AnimalDefinitions.animals["bull"].hungerMultiplier = AnimalDefinitions.animals["cow"].hungerMultiplier;
AnimalDefinitions.animals["bull"].thirstMultiplier = AnimalDefinitions.animals["cow"].thirstMultiplier;
AnimalDefinitions.animals["bull"].idleTypeNbr = AnimalDefinitions.animals["cow"].idleTypeNbr;
--AnimalDefinitions.animals["bull"].tileTypeToEat = AnimalDefinitions.animals["cow"].tileTypeToEat;
AnimalDefinitions.animals["bull"].healthLossMultiplier = AnimalDefinitions.animals["cow"].healthLossMultiplier;
AnimalDefinitions.animals["bull"].sittingPeriod = AnimalDefinitions.animals["cow"].sittingPeriod;
AnimalDefinitions.animals["bull"].eatTypeTrough = AnimalDefinitions.animals["cow"].eatTypeTrough;
AnimalDefinitions.animals["bull"].minWeight = AnimalDefinitions.animals["cow"].minWeight;
AnimalDefinitions.animals["bull"].maxWeight = 1300;
AnimalDefinitions.animals["bull"].carcassItem = "Base.CorpseCow";
AnimalDefinitions.animals["bull"].attackDist = AnimalDefinitions.animals["cow"].attackDist;
AnimalDefinitions.animals["bull"].attackTimer = AnimalDefinitions.animals["cow"].attackTimer;
AnimalDefinitions.animals["bull"].baseDmg = AnimalDefinitions.animals["cow"].baseDmg;
AnimalDefinitions.animals["bull"].trailerBaseSize = AnimalDefinitions.animals["cow"].trailerBaseSize;
AnimalDefinitions.animals["bull"].canBePet = true;
AnimalDefinitions.animals["bull"].baseEncumbrance = AnimalDefinitions.animals["cow"].baseEncumbrance;
AnimalDefinitions.animals["bull"].attackBack = true;
AnimalDefinitions.animals["bull"].luredPossibleItems = AnimalDefinitions.animals["cowcalf"].luredPossibleItems;
AnimalDefinitions.animals["bull"].collisionSize = AnimalDefinitions.animals["cow"].collisionSize;
AnimalDefinitions.animals["bull"].group = "cow";
AnimalDefinitions.animals["bull"].dung = "Dung_Cow";
AnimalDefinitions.animals["bull"].thirstHungerTrigger = 0.3;
AnimalDefinitions.animals["bull"].attackIfStressed = true;
AnimalDefinitions.animals["bull"].ropeBone = "Bip01_Neck";
AnimalDefinitions.animals["bull"].stressAboveGround = true;
AnimalDefinitions.animals["bull"].dungChancePerDay = 70;
AnimalDefinitions.animals["bull"].knockdownAttack = true; -- attack from a bull can knock you down
AnimalDefinitions.animals["bull"].canDoLaceration = true; -- this animal can generate laceration and deep wound when attacking a player
AnimalDefinitions.animals["bull"].minBlood = 1000;
AnimalDefinitions.animals["bull"].maxBlood = 3500;
AnimalDefinitions.animals["bull"].corpseSize = AnimalDefinitions.animals["cow"].corpseSize;
AnimalDefinitions.animals["bull"].idleSoundRadius = 50;
AnimalDefinitions.animals["bull"].idleSoundVolume = 30;

-- NOTE: bull.breeds must not be the same table as cow.breeds.
local bull_sounds = {
	attack = { name = "AnimalVoiceBullAttack", slot = "voice", priority = 50 },
	death = { name = "AnimalVoiceBullDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyBullBodyfall" },
	idle = { name = "AnimalVoiceBullIdle", intervalMin = 15, intervalMax = 30, slot = "voice" },
	pain = { name = "AnimalVoiceBullPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalBull" },
	pick_up = { name = "PickUpAnimalCow", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadCow" },
	put_down = { name = "PutDownAnimalCow", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadCow" },
	run = { name = "AnimalFootstepsBullRun" },
	stressed = { name = "AnimalVoiceBullStressed", intervalMin = 5, intervalMax = 10, slot = "voice" },
	walkBack = { name = "AnimalFootstepsBullWalkBack" },
	walkFront = { name = "AnimalFootstepsBullWalkFront" },
}
AnimalDefinitions.animals["bull"].breeds["angus"].sounds = bull_sounds
AnimalDefinitions.animals["bull"].breeds["holstein"].sounds = bull_sounds
AnimalDefinitions.animals["bull"].breeds["simmental"].sounds = bull_sounds

local cowcalf_sounds = {
	death = { name = "AnimalVoiceCalfDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyCalfBodyfall" },
	idle = { name = "AnimalVoiceCalfIdle", intervalMin = 20, intervalMax = 50, slot = "voice" },
	pain = { name = "AnimalVoiceCalfPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalCalf" },
	pick_up = { name = "PickUpAnimalCalf", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadCalf" },
	put_down = { name = "PutDownAnimalCalf", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadCalf" },
	run = { name = "AnimalFootstepsCalfRun" },
	stressed = { name = "AnimalVoiceCalfStressed", intervalMin = 15, intervalMax = 30, slot = "voice" },
	walkBack = { name = "AnimalFootstepsCalfWalkBack" },
	walkFront = { name = "AnimalFootstepsCalfWalkFront" },
}
AnimalDefinitions.animals["cowcalf"].breeds["angus"].sounds = cowcalf_sounds
AnimalDefinitions.animals["cowcalf"].breeds["holstein"].sounds = cowcalf_sounds
AnimalDefinitions.animals["cowcalf"].breeds["simmental"].sounds = cowcalf_sounds

local cow_sounds = {
	death = { name = "AnimalVoiceCowDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyCowBodyfall" },
	idle = { name = "AnimalVoiceCowIdle", intervalMin = 30, intervalMax = 60, slot = "voice" },
	pain = { name = "AnimalVoiceCowPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalCow" },
	pick_up = { name = "PickUpAnimalCow", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadCow" },
	put_down = { name = "PutDownAnimalCow", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadCow" },
	run = { name = "AnimalFootstepsCowRun" },
	stressed = { name = "AnimalVoiceCowStressed", intervalMin = 20, intervalMax = 35, slot = "voice" },
	walkBack = { name = "AnimalFootstepsCowWalkBack" },
	walkFront = { name = "AnimalFootstepsCowWalkFront" },
}
AnimalDefinitions.animals["cow"].breeds["angus"].sounds = cow_sounds
AnimalDefinitions.animals["cow"].breeds["holstein"].sounds = cow_sounds
AnimalDefinitions.animals["cow"].breeds["simmental"].sounds = cow_sounds

