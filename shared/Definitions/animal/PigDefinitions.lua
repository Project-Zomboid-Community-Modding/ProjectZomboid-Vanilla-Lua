--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 25/01/2022
-- Time: 10:08
-- To change this template use File | Settings | File Templates.
--

AnimalDefinitions = AnimalDefinitions or {};

-- stages
AnimalDefinitions.stages = AnimalDefinitions.stages or {};
AnimalDefinitions.stages["pig"] = {};
AnimalDefinitions.stages["pig"].stages = {};
AnimalDefinitions.stages["pig"].stages["piglet"] = {};
AnimalDefinitions.stages["pig"].stages["piglet"].ageToGrow = 20 * 7; -- 20 weeks
--AnimalDefinitions.stages["pig"].stages["piglet"].ageToGrow = 4;
AnimalDefinitions.stages["pig"].stages["piglet"].nextStage = "sow";
AnimalDefinitions.stages["pig"].stages["piglet"].nextStageMale = "boar";

AnimalDefinitions.stages["pig"].stages["sow"] = {};
AnimalDefinitions.stages["pig"].stages["sow"].ageToGrow = 20 * 7; -- 20 weeks

AnimalDefinitions.stages["pig"].stages["boar"] = {}
AnimalDefinitions.stages["pig"].stages["boar"].ageToGrow = 12 * 30;


-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["pig"] = {};
AnimalDefinitions.breeds["pig"].breeds = {};
AnimalDefinitions.breeds["pig"].breeds["landrace"] = {};
AnimalDefinitions.breeds["pig"].breeds["landrace"].name = "landrace";
AnimalDefinitions.breeds["pig"].breeds["landrace"].texture = "FarmPig";
AnimalDefinitions.breeds["pig"].breeds["landrace"].textureMale = "FarmPig_Boar";
AnimalDefinitions.breeds["pig"].breeds["landrace"].invIconMale = "Item_PigWhite_Piglet";
AnimalDefinitions.breeds["pig"].breeds["landrace"].invIconFemale = "Item_PigWhite_Piglet";
AnimalDefinitions.breeds["pig"].breeds["landrace"].invIconBaby = "Item_PigWhite_Piglet";
AnimalDefinitions.breeds["pig"].breeds["landrace"].invIconMaleDead = "Item_PigWhite_Piglet_Dead";
AnimalDefinitions.breeds["pig"].breeds["landrace"].invIconFemaleDead = "Item_PigPink_Dead";
AnimalDefinitions.breeds["pig"].breeds["landrace"].invIconBabyDead = "Item_PigPink_Dead";
AnimalDefinitions.breeds["pig"].breeds["landrace"].forcedGenes = {};
AnimalDefinitions.breeds["pig"].breeds["landrace"].forcedGenes["maxMilk"] = {}; -- we gonna ensure the pig have enough milk to feed lots of babies
AnimalDefinitions.breeds["pig"].breeds["landrace"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["pig"].breeds["landrace"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["pig"].breeds["landrace"].forcedGenes["meatRatio"] = {};
AnimalDefinitions.breeds["pig"].breeds["landrace"].forcedGenes["meatRatio"].minValue = 0.5;
AnimalDefinitions.breeds["pig"].breeds["landrace"].forcedGenes["meatRatio"].maxValue = 0.8;

AnimalDefinitions.breeds["pig"].breeds["largeblack"] = {};
AnimalDefinitions.breeds["pig"].breeds["largeblack"].name = "largeblack";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].texture = "FarmPig_Black";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].textureMale = "FarmPig_Boar_Black";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].invIconMale = "Item_PigBlack_Piglet";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].invIconFemale = "Item_PigBlack_Piglet";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].invIconBaby = "Item_PigBlack_Piglet";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].invIconMaleDead = "Item_PigBlack_Piglet_Dead";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].invIconFemaleDead = "Item_PigBlack_Dead";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].invIconBabyDead = "Item_PigBlack_Dead";
AnimalDefinitions.breeds["pig"].breeds["largeblack"].forcedGenes = {};
AnimalDefinitions.breeds["pig"].breeds["largeblack"].forcedGenes["maxMilk"] = {}; -- we gonna ensure the pig have enough milk to feed lots of babies
AnimalDefinitions.breeds["pig"].breeds["largeblack"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["pig"].breeds["largeblack"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["pig"].breeds["largeblack"].forcedGenes["meatRatio"] = {};
AnimalDefinitions.breeds["pig"].breeds["largeblack"].forcedGenes["meatRatio"].minValue = 0.5;
AnimalDefinitions.breeds["pig"].breeds["largeblack"].forcedGenes["meatRatio"].maxValue = 0.8;

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {};
AnimalDefinitions.genome["pig"] = {};
AnimalDefinitions.genome["pig"].genes = {};
AnimalDefinitions.genome["pig"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["pig"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["pig"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["pig"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["pig"].genes["maxMilk"] = "maxMilk";
AnimalDefinitions.genome["pig"].genes["milkInc"] = "milkInc";
AnimalDefinitions.genome["pig"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["pig"].genes["strength"] = "strength";
AnimalDefinitions.genome["pig"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["pig"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["pig"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["pig"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["pig"].genes["fertility"] = "fertility";
AnimalDefinitions.genome["pig"].genes["stress"] = "stress";


-- animals
AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["piglet"] = {};
AnimalDefinitions.animals["piglet"].bodyModel = "FarmPig_PigletBody";
AnimalDefinitions.animals["piglet"].bodyModelSkel = "FarmPig_PigletSkeleton";
AnimalDefinitions.animals["piglet"].textureSkeleton = "PigSkeleton";
AnimalDefinitions.animals["piglet"].animset = "piglet";
AnimalDefinitions.animals["piglet"].modelscript = "FarmPig_PigletBody";
AnimalDefinitions.animals["piglet"].shadoww = 0.3;
AnimalDefinitions.animals["piglet"].shadowfm = 0.5;
AnimalDefinitions.animals["piglet"].shadowbm = 0.5;
AnimalDefinitions.animals["piglet"].turnDelta = 0.95;
AnimalDefinitions.animals["piglet"].animalSize = 0.15;
AnimalDefinitions.animals["piglet"].minSize = 0.85;
AnimalDefinitions.animals["piglet"].maxSize = 1.2;
AnimalDefinitions.animals["piglet"].sitRandomly = true;
AnimalDefinitions.animals["piglet"].stages = AnimalDefinitions.stages["pig"].stages;
AnimalDefinitions.animals["piglet"].breeds = copyTable(AnimalDefinitions.breeds["pig"].breeds);
AnimalDefinitions.animals["piglet"].genes = AnimalDefinitions.genome["pig"].genes;
AnimalDefinitions.animals["piglet"].alwaysFleeHumans = false;
AnimalDefinitions.animals["piglet"].canBeAttached = true;
AnimalDefinitions.animals["piglet"].minEnclosureSize = 20;
AnimalDefinitions.animals["piglet"].wanderMul = 300;
--AnimalDefinitions.animals["piglet"].hungerMultiplier = 0.01;
AnimalDefinitions.animals["piglet"].hungerMultiplier = 0.0005;
AnimalDefinitions.animals["piglet"].thirstMultiplier = 0.001;
AnimalDefinitions.animals["piglet"].idleTypeNbr = 2;
AnimalDefinitions.animals["piglet"].eatFromMother = true;
AnimalDefinitions.animals["piglet"].idleEmoteChance = 500;
AnimalDefinitions.animals["piglet"].periodicRun = true;
AnimalDefinitions.animals["piglet"].healthLossMultiplier = 0.05;
AnimalDefinitions.animals["piglet"].trailerBaseSize = 70;
AnimalDefinitions.animals["piglet"].canBePet = true;
AnimalDefinitions.animals["piglet"].canBePicked = true;
AnimalDefinitions.animals["piglet"].baseEncumbrance = 40;
AnimalDefinitions.animals["piglet"].luredPossibleItems = {{name="Base.AnimalFeedBag", chance=50}};
AnimalDefinitions.animals["piglet"].collisionSize = 0.24;
AnimalDefinitions.animals["piglet"].collidable = false;
AnimalDefinitions.animals["piglet"].minWeight = 15;
AnimalDefinitions.animals["piglet"].maxWeight = 110;
AnimalDefinitions.animals["piglet"].canThump = false;
AnimalDefinitions.animals["piglet"].group = "pig";
AnimalDefinitions.animals["piglet"].dung = "Dung_Pig";
AnimalDefinitions.animals["piglet"].ropeBone = "Bip01_Head";
AnimalDefinitions.animals["piglet"].stressAboveGround = true;
AnimalDefinitions.animals["piglet"].stressUnderRain = true;
AnimalDefinitions.animals["piglet"].dontAttackOtherMale = true;
AnimalDefinitions.animals["piglet"].dungChancePerDay = 70;
AnimalDefinitions.animals["piglet"].hungerBoost = 5;
AnimalDefinitions.animals["piglet"].thirstBoost = 7;
AnimalDefinitions.animals["piglet"].distToEat = 1;
AnimalDefinitions.animals["piglet"].litterEatTogether = true; -- when one baby needs to feed, every babies will be called to mom to eat all together
AnimalDefinitions.animals["piglet"].thirstHungerTrigger = 0.4;
AnimalDefinitions.animals["piglet"].minBlood = 200;
AnimalDefinitions.animals["piglet"].maxBlood = 600;
AnimalDefinitions.animals["piglet"].idleSoundRadius = 20;
AnimalDefinitions.animals["piglet"].idleSoundVolume = 10;


AnimalDefinitions.animals["sow"] = {};
AnimalDefinitions.animals["sow"].bodyModel = "FarmPig_SowBody";
AnimalDefinitions.animals["sow"].bodyModelSkel = "FarmPig_Skeleton";
AnimalDefinitions.animals["sow"].textureSkeleton = "PigSkeleton";
AnimalDefinitions.animals["sow"].animset = "pig";
AnimalDefinitions.animals["sow"].modelscript = "FarmPig_SowBody";
AnimalDefinitions.animals["sow"].bodyModelHeadless = "FarmPig_SowHeadless";
AnimalDefinitions.animals["sow"].textureSkinned = "FarmPig_Skinned";
AnimalDefinitions.animals["sow"].shadoww = 0.9
AnimalDefinitions.animals["sow"].shadowfm = 1.5;
AnimalDefinitions.animals["sow"].shadowbm = 1.5;
AnimalDefinitions.animals["sow"].turnDelta = 0.8;
AnimalDefinitions.animals["sow"].animalSize = 0.2;
AnimalDefinitions.animals["sow"].minSize = 0.85;
AnimalDefinitions.animals["sow"].maxSize = 1.15;
AnimalDefinitions.animals["sow"].minAge = AnimalDefinitions.stages["pig"].stages["piglet"].ageToGrow;
AnimalDefinitions.animals["sow"].babyType = "piglet";
AnimalDefinitions.animals["sow"].babyNbr = "5,10";
AnimalDefinitions.animals["sow"].idleEmoteChance = 700;
AnimalDefinitions.animals["sow"].sitRandomly = true;
AnimalDefinitions.animals["sow"].minAgeForBaby = 210;
--AnimalDefinitions.animals["sow"].maxAgeGeriatric = 12 * 12 * 30;
AnimalDefinitions.animals["sow"].maxAgeGeriatric = 5 * 12 * 30;
AnimalDefinitions.animals["sow"].udder = true;
AnimalDefinitions.animals["sow"].minMilk = 30;
AnimalDefinitions.animals["sow"].maxMilk = 50;
AnimalDefinitions.animals["sow"].female = true;
AnimalDefinitions.animals["sow"].stages = AnimalDefinitions.stages["pig"].stages;
AnimalDefinitions.animals["sow"].breeds = AnimalDefinitions.breeds["pig"].breeds;
AnimalDefinitions.animals["sow"].genes = AnimalDefinitions.genome["pig"].genes;
AnimalDefinitions.animals["sow"].alwaysFleeHumans = false;
AnimalDefinitions.animals["sow"].canBeAttached = true;
AnimalDefinitions.animals["sow"].baseEncumbrance = 100;
AnimalDefinitions.animals["sow"].wanderMul = 500;
AnimalDefinitions.animals["sow"].minEnclosureSize = 40;
AnimalDefinitions.animals["sow"].hungerMultiplier = 0.002;
AnimalDefinitions.animals["sow"].thirstMultiplier = 0.004;
AnimalDefinitions.animals["sow"].idleTypeNbr = 2;
AnimalDefinitions.animals["sow"].eatGrass = true;
AnimalDefinitions.animals["sow"].pregnantPeriod = 120;
--AnimalDefinitions.animals["sow"].pregnantPeriod = 2;
AnimalDefinitions.animals["sow"].healthLossMultiplier = 0.01;
AnimalDefinitions.animals["sow"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits";
AnimalDefinitions.animals["sow"].trailerBaseSize = 110;
AnimalDefinitions.animals["sow"].canBePet = true;
AnimalDefinitions.animals["sow"].luredPossibleItems = AnimalDefinitions.animals["piglet"].luredPossibleItems;
AnimalDefinitions.animals["sow"].collisionSize = 0.32;
AnimalDefinitions.animals["sow"].matingPeriodStart = 9; -- the month (here September) at which the mating season start, if 0 there's no mating season (can always reproduce)
AnimalDefinitions.animals["sow"].matingPeriodEnd = 2; -- the month (here February) at which the mating season end
AnimalDefinitions.animals["sow"].timeBeforeNextPregnancy = 7; -- in days
AnimalDefinitions.animals["sow"].attackTimer = 2000;
AnimalDefinitions.animals["sow"].thirstHungerTrigger = 0.2;
AnimalDefinitions.animals["sow"].minWeight = 115;
AnimalDefinitions.animals["sow"].maxWeight = 350;
AnimalDefinitions.animals["sow"].group = "pig";
AnimalDefinitions.animals["sow"].dung = "Dung_Pig";
AnimalDefinitions.animals["sow"].ropeBone = "Bip01_Head";
AnimalDefinitions.animals["sow"].stressAboveGround = true;
AnimalDefinitions.animals["sow"].stressUnderRain = true;
AnimalDefinitions.animals["sow"].dungChancePerDay = 70;
AnimalDefinitions.animals["sow"].corpseSize = 3.5;
AnimalDefinitions.animals["sow"].minBlood = 800;
AnimalDefinitions.animals["sow"].maxBlood = 2500;
AnimalDefinitions.animals["sow"].idleSoundRadius = 40;
AnimalDefinitions.animals["sow"].idleSoundVolume = 20;
AnimalDefinitions.animals["sow"].hungerBoost = 3;
AnimalDefinitions.animals["sow"].thirstBoost = 5;

AnimalDefinitions.animals["boar"] = {};
AnimalDefinitions.animals["boar"].bodyModel = "FarmPig_BoarBody";
AnimalDefinitions.animals["boar"].bodyModelSkel = "FarmPig_Skeleton";
AnimalDefinitions.animals["boar"].textureSkeleton = "PigSkeleton";
AnimalDefinitions.animals["boar"].animset = "pig";
AnimalDefinitions.animals["boar"].modelscript = "FarmPig_BoarBody";
AnimalDefinitions.animals["boar"].bodyModelHeadless = "FarmPig_BoarHeadless";
AnimalDefinitions.animals["boar"].textureSkinned = "FarmPig_Skinned";
AnimalDefinitions.animals["boar"].shadoww = AnimalDefinitions.animals["sow"].shadoww;
AnimalDefinitions.animals["boar"].shadowfm = AnimalDefinitions.animals["sow"].shadowfm;
AnimalDefinitions.animals["boar"].shadowbm = AnimalDefinitions.animals["sow"].shadowbm;
AnimalDefinitions.animals["boar"].sitRandomly = AnimalDefinitions.animals["sow"].sitRandomly;
AnimalDefinitions.animals["boar"].eatGrass = AnimalDefinitions.animals["sow"].eatGrass;
AnimalDefinitions.animals["boar"].turnDelta = AnimalDefinitions.animals["sow"].turnDelta;
AnimalDefinitions.animals["boar"].animalSize = AnimalDefinitions.animals["sow"].animalSize;
AnimalDefinitions.animals["boar"].minSize = AnimalDefinitions.animals["sow"].minSize;
AnimalDefinitions.animals["boar"].maxSize = AnimalDefinitions.animals["sow"].maxSize;
AnimalDefinitions.animals["boar"].minAge = AnimalDefinitions.animals["sow"].minAge;
AnimalDefinitions.animals["boar"].maxAgeGeriatric = AnimalDefinitions.animals["sow"].maxAgeGeriatric;
AnimalDefinitions.animals["boar"].idleEmoteChance = AnimalDefinitions.animals["sow"].idleEmoteChance;
AnimalDefinitions.animals["boar"].male = true;
AnimalDefinitions.animals["boar"].babyType = AnimalDefinitions.animals["sow"].babyType;
AnimalDefinitions.animals["boar"].minAgeForBaby = AnimalDefinitions.animals["sow"].minAgeForBaby;
AnimalDefinitions.animals["boar"].mate = "sow";
AnimalDefinitions.animals["boar"].baseEncumbrance = AnimalDefinitions.animals["sow"].baseEncumbrance;
AnimalDefinitions.animals["boar"].stages = AnimalDefinitions.stages["pig"].stages;
AnimalDefinitions.animals["boar"].breeds = copyTable(AnimalDefinitions.breeds["pig"].breeds);
AnimalDefinitions.animals["boar"].genes = AnimalDefinitions.genome["pig"].genes;
AnimalDefinitions.animals["boar"].alwaysFleeHumans = AnimalDefinitions.animals["sow"].alwaysFleeHumans;
AnimalDefinitions.animals["boar"].canBeAttached = AnimalDefinitions.animals["sow"].canBeAttached;
AnimalDefinitions.animals["boar"].wanderMul = AnimalDefinitions.animals["sow"].wanderMul;
AnimalDefinitions.animals["boar"].hungerMultiplier = AnimalDefinitions.animals["sow"].hungerMultiplier;
AnimalDefinitions.animals["boar"].thirstMultiplier = AnimalDefinitions.animals["sow"].thirstMultiplier;
AnimalDefinitions.animals["boar"].idleTypeNbr = AnimalDefinitions.animals["sow"].idleTypeNbr;
AnimalDefinitions.animals["boar"].healthLossMultiplier = AnimalDefinitions.animals["sow"].healthLossMultiplier;
AnimalDefinitions.animals["boar"].sittingPeriod = AnimalDefinitions.animals["sow"].sittingPeriod;
AnimalDefinitions.animals["boar"].eatTypeTrough = AnimalDefinitions.animals["sow"].eatTypeTrough;
AnimalDefinitions.animals["boar"].trailerBaseSize = AnimalDefinitions.animals["sow"].trailerBaseSize;
AnimalDefinitions.animals["boar"].canBePet = true;
AnimalDefinitions.animals["boar"].luredPossibleItems = AnimalDefinitions.animals["piglet"].luredPossibleItems;
AnimalDefinitions.animals["boar"].attackDist = 1;
AnimalDefinitions.animals["boar"].collisionSize = AnimalDefinitions.animals["sow"].collisionSize;
AnimalDefinitions.animals["boar"].attackTimer = AnimalDefinitions.animals["sow"].attackTimer;
AnimalDefinitions.animals["boar"].thirstHungerTrigger = AnimalDefinitions.animals["sow"].thirstHungerTrigger;
AnimalDefinitions.animals["boar"].dontAttackOtherMale = true;
AnimalDefinitions.animals["boar"].minWeight = 115;
AnimalDefinitions.animals["boar"].maxWeight = 350;
AnimalDefinitions.animals["boar"].group = "pig";
AnimalDefinitions.animals["boar"].dung = "Dung_Pig";
AnimalDefinitions.animals["boar"].ropeBone = "Bip01_Head";
AnimalDefinitions.animals["boar"].stressAboveGround = true;
AnimalDefinitions.animals["boar"].stressUnderRain = true;
AnimalDefinitions.animals["boar"].dungChancePerDay = 70;
AnimalDefinitions.animals["boar"].knockdownAttack = true;
AnimalDefinitions.animals["boar"].canDoLaceration = true;
AnimalDefinitions.animals["boar"].corpseSize = AnimalDefinitions.animals["sow"].corpseSize;
AnimalDefinitions.animals["boar"].minBlood = 800;
AnimalDefinitions.animals["boar"].maxBlood = 2500;
AnimalDefinitions.animals["boar"].idleSoundRadius = 40;
AnimalDefinitions.animals["boar"].idleSoundVolume = 20;
AnimalDefinitions.animals["boar"].hungerBoost = 3;
AnimalDefinitions.animals["boar"].thirstBoost = 5;


-- NOTE: boar.breeds must not be the same table as sow.breeds.
local boar_sounds = {
	death = { name = "AnimalVoiceBoarDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyBoarBodyfall" },
	idle = { name = "AnimalVoiceBoarIdle", intervalMin = 25, intervalMax = 50, slot = "voice" },
	pain = { name = "AnimalVoiceBoarPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalBoar" },
	pick_up = { name = "PickUpAnimalPig", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadPig" },
	put_down = { name = "PutDownAnimalPig", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadPig" },
	run = { name = "AnimalFootstepsBoarRun" },
	stressed = { name = "AnimalVoiceBoarStressed", intervalMin = 20, intervalMax = 40, slot = "voice" },
	walkBack = { name = "AnimalFootstepsBoarWalkBack" },
	walkFront = { name = "AnimalFootstepsBoarWalkFront" },
}
AnimalDefinitions.animals["boar"].breeds["landrace"].sounds = boar_sounds
AnimalDefinitions.animals["boar"].breeds["largeblack"].sounds = boar_sounds

local piglet_sounds = {
	death = { name = "AnimalVoicePigletDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyPigletBodyfall" },
	idle = { name = "AnimalVoicePigletIdle", intervalMin = 20, intervalMax = 50, slot = "voice" },
	pain = { name = "AnimalVoicePigletPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalPiglet" },
	pick_up = { name = "PickUpAnimalPiglet", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadPiglet" },
	put_down = { name = "PutDownAnimalPiglet", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadPiglet" },
	run = { name = "AnimalFootstepsPigletRun" },
	stressed = { name = "AnimalVoicePigletStressed", intervalMin = 15, intervalMax = 40, slot = "voice" },
	walkBack = { name = "AnimalFootstepsPigletWalkBack" },
	walkFront = { name = "AnimalFootstepsPigletWalkFront" },
}
AnimalDefinitions.animals["piglet"].breeds["landrace"].sounds = piglet_sounds
AnimalDefinitions.animals["piglet"].breeds["largeblack"].sounds = piglet_sounds

local sow_sounds = {
	death = { name = "AnimalVoiceSowDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleySowBodyfall" },
	idle = { name = "AnimalVoiceSowIdle", intervalMin = 25, intervalMax = 50, slot = "voice" },
	pain = { name = "AnimalVoiceSowPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalPig" },
	pick_up = { name = "PickUpAnimalPig", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadPig" },
	put_down = { name = "PutDownAnimalPig", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadPig" },
	run = { name = "AnimalFootstepsSowRun" },
	stressed = { name = "AnimalVoiceSowStressed", intervalMin = 15, intervalMax = 40, slot = "voice" },
	walkBack = { name = "AnimalFootstepsSowWalkBack" },
	walkFront = { name = "AnimalFootstepsSowWalkFront" },
}
AnimalDefinitions.animals["sow"].breeds["landrace"].sounds = sow_sounds
AnimalDefinitions.animals["sow"].breeds["largeblack"].sounds = sow_sounds
