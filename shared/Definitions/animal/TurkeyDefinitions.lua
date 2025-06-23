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
AnimalDefinitions.stages["turkey"] = {};
AnimalDefinitions.stages["turkey"].stages = {};
AnimalDefinitions.stages["turkey"].stages["turkeypoult"] = {};
AnimalDefinitions.stages["turkey"].stages["turkeypoult"].ageToGrow = 18 * 7; -- 18 weeks
AnimalDefinitions.stages["turkey"].stages["turkeypoult"].nextStage = "turkeyhen";
AnimalDefinitions.stages["turkey"].stages["turkeypoult"].nextStageMale = "gobblers";

AnimalDefinitions.stages["turkey"].stages["turkeyhen"] = {};
AnimalDefinitions.stages["turkey"].stages["turkeyhen"].ageToGrow = 12 * 30; -- 1 year

AnimalDefinitions.stages["turkey"].stages["gobblers"] = {}
AnimalDefinitions.stages["turkey"].stages["gobblers"].ageToGrow = 12 * 30;


-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["turkey"] = {};
AnimalDefinitions.breeds["turkey"].breeds = {};
AnimalDefinitions.breeds["turkey"].breeds["meleagris"] = {};
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].name = "meleagris";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].textureBaby = "turkey_poult";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].texture = "turkey_hen";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].textureMale = "turkey";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].rottenTexture = "Turkey_Rotting";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconMale = "Item_Turkey";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconFemale = "Item_TurkeyHen";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconBaby = "Item_TurkeyPoult";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconMaleDead = "Item_Turkey_Dead";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconFemaleDead = "Item_TurkeyHen_Dead";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconBabyDead = "Item_TurkeyPoult_Dead";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconMaleSkel = "Item_Skeleton_Turkey";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconFemaleSkel = "Item_Skeleton_Turkey";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].invIconBabySkel = "Item_Skeleton_Turkey_Poult";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].featherItem = "Base.TurkeyFeather";
AnimalDefinitions.breeds["turkey"].breeds["meleagris"].maxFeather = 120;

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {};
AnimalDefinitions.genome["turkey"] = {};
AnimalDefinitions.genome["turkey"].genes = {};
AnimalDefinitions.genome["turkey"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["turkey"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["turkey"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["turkey"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["turkey"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["turkey"].genes["strength"] = "strength";
AnimalDefinitions.genome["turkey"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["turkey"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["turkey"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["turkey"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["turkey"].genes["fertility"] = "fertility"
AnimalDefinitions.genome["turkey"].genes["eggSize"] = "eggSize";
AnimalDefinitions.genome["turkey"].genes["stress"] = "stress";
AnimalDefinitions.genome["turkey"].genes["eggClutch"] = "eggClutch";

-- animals
AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["turkeypoult"] = {};
AnimalDefinitions.animals["turkeypoult"].bodyModel = "Turkey_Poult";
AnimalDefinitions.animals["turkeypoult"].bodyModelSkel = "Turkey_PoultSkeleton";
AnimalDefinitions.animals["turkeypoult"].textureSkeleton = "TurkeySkeleton";
AnimalDefinitions.animals["turkeypoult"].bodyModelSkelNoHead = "Turkey_PoultSkeleton_NoHead";
AnimalDefinitions.animals["turkeypoult"].animset = "turkeypoult";
AnimalDefinitions.animals["turkeypoult"].shadoww = 0.15;
AnimalDefinitions.animals["turkeypoult"].shadowfm = 0.2;
AnimalDefinitions.animals["turkeypoult"].shadowbm = 0.2;
AnimalDefinitions.animals["turkeypoult"].turnDelta = 0.95;
AnimalDefinitions.animals["turkeypoult"].animalSize = 1;
AnimalDefinitions.animals["turkeypoult"].minSize = 0.9;
AnimalDefinitions.animals["turkeypoult"].maxSize = 1;
AnimalDefinitions.animals["turkeypoult"].sitRandomly = true;
AnimalDefinitions.animals["turkeypoult"].genes = AnimalDefinitions.genome["turkey"].genes;
AnimalDefinitions.animals["turkeypoult"].stages = AnimalDefinitions.stages["turkey"].stages;
AnimalDefinitions.animals["turkeypoult"].breeds = copyTable(AnimalDefinitions.breeds["turkey"].breeds);
AnimalDefinitions.animals["turkeypoult"].alwaysFleeHumans = false;
AnimalDefinitions.animals["turkeypoult"].canBePicked = true;
AnimalDefinitions.animals["turkeypoult"].minEnclosureSize = 20;
AnimalDefinitions.animals["turkeypoult"].wanderMul = 200;
AnimalDefinitions.animals["turkeypoult"].hutches = "hutchhen,hutchturkey";
AnimalDefinitions.animals["turkeypoult"].enterHutchTime = 20;
AnimalDefinitions.animals["turkeypoult"].exitHutchTime = 7;
AnimalDefinitions.animals["turkeypoult"].attackDist = 0;
AnimalDefinitions.animals["turkeypoult"].attackTimer = 3500;
AnimalDefinitions.animals["turkeypoult"].hungerMultiplier = 0.00015;
AnimalDefinitions.animals["turkeypoult"].thirstMultiplier = 0.00025;
AnimalDefinitions.animals["turkeypoult"].idleTypeNbr = 5;
AnimalDefinitions.animals["turkeypoult"].sittingTypeNbr = 1;
AnimalDefinitions.animals["turkeypoult"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits,Seeds,Nuts";
AnimalDefinitions.animals["turkeypoult"].healthLossMultiplier = 0.2;
AnimalDefinitions.animals["turkeypoult"].idleEmoteChance = 500;
AnimalDefinitions.animals["turkeypoult"].trailerBaseSize = 25;
AnimalDefinitions.animals["turkeypoult"].collisionSize = 0;
AnimalDefinitions.animals["turkeypoult"].baseEncumbrance = 10;
AnimalDefinitions.animals["turkeypoult"].canBePet = true;
AnimalDefinitions.animals["turkeypoult"].collidable = false;
AnimalDefinitions.animals["turkeypoult"].minWeight = 0.05;
AnimalDefinitions.animals["turkeypoult"].maxWeight = 0.3;
AnimalDefinitions.animals["turkeypoult"].canThump = false;
AnimalDefinitions.animals["turkeypoult"].group = "turkey";
AnimalDefinitions.animals["turkeypoult"].dung = "Dung_Turkey";
AnimalDefinitions.animals["turkeypoult"].matingPeriodStart = 4;
AnimalDefinitions.animals["turkeypoult"].matingPeriodEnd = 5;
AnimalDefinitions.animals["turkeypoult"].stressUnderRain = true;
AnimalDefinitions.animals["turkeypoult"].needMom = false;
AnimalDefinitions.animals["turkeypoult"].hungerBoost = 12;
AnimalDefinitions.animals["turkeypoult"].thirstBoost = 22;
AnimalDefinitions.animals["turkeypoult"].distToEat = 1;
AnimalDefinitions.animals["turkeypoult"].corpseSize = 0;


AnimalDefinitions.animals["turkeyhen"] = {};
AnimalDefinitions.animals["turkeyhen"].bodyModel = "Turkey";
AnimalDefinitions.animals["turkeyhen"].bodyModelSkel = "Turkey_Skeleton";
AnimalDefinitions.animals["turkeyhen"].textureSkeleton = "TurkeySkeleton";
AnimalDefinitions.animals["turkeyhen"].bodyModelSkelNoHead = "Turkey_Skeleton_NoHead";
AnimalDefinitions.animals["turkeyhen"].animset = "turkey";
AnimalDefinitions.animals["turkeyhen"].shadoww = 0.4;
AnimalDefinitions.animals["turkeyhen"].shadowfm = 0.5;
AnimalDefinitions.animals["turkeyhen"].shadowbm = 0.5;
AnimalDefinitions.animals["turkeyhen"].turnDelta = 0.9;
AnimalDefinitions.animals["turkeyhen"].animalSize = 0;
AnimalDefinitions.animals["turkeyhen"].minSize = 0.8;
AnimalDefinitions.animals["turkeyhen"].maxSize = 1.1;
AnimalDefinitions.animals["turkeyhen"].minAge = AnimalDefinitions.stages["turkey"].stages["turkeypoult"].ageToGrow;
AnimalDefinitions.animals["turkeyhen"].babyType = "turkeypoult";
AnimalDefinitions.animals["turkeyhen"].eggsPerDay = 1;
AnimalDefinitions.animals["turkeyhen"].minClutchSize = 9; -- turkey are different from chicken, they produce 7 to 17 eggs per year and start to lay them in may
AnimalDefinitions.animals["turkeyhen"].maxClutchSize = 17;
AnimalDefinitions.animals["turkeyhen"].layEggPeriodStart = 5; -- month, here turkey start to lay in may
AnimalDefinitions.animals["turkeyhen"].fertilizedTimeMax = 14 * 24; -- in hour, (2 weeks here) the time the animal will stay fertile once a rooster fertilized it
AnimalDefinitions.animals["turkeyhen"].eggType = "Base.TurkeyEgg";
--AnimalDefinitions.animals["turkeyhen"].timeToHatch = 2;
AnimalDefinitions.animals["turkeyhen"].timeToHatch = 28 * 24; -- in hour (21 days here) the time the egg will take to hatch a baby
AnimalDefinitions.animals["turkeyhen"].canBePicked = true;
--AnimalDefinitions.animals["turkeyhen"].timeToHatch = 2;
AnimalDefinitions.animals["turkeyhen"].sitRandomly = true;
AnimalDefinitions.animals["turkeyhen"].idleEmoteChance = 650;
AnimalDefinitions.animals["turkeyhen"].minAgeForBaby = 18 * 7;
AnimalDefinitions.animals["turkeyhen"].maxAgeGeriatric = 12 * 12 * 30;
AnimalDefinitions.animals["turkeyhen"].female = true;
AnimalDefinitions.animals["turkeyhen"].genes = AnimalDefinitions.genome["turkey"].genes;
AnimalDefinitions.animals["turkeyhen"].stages = AnimalDefinitions.stages["turkey"].stages;
AnimalDefinitions.animals["turkeyhen"].breeds = AnimalDefinitions.breeds["turkey"].breeds;
AnimalDefinitions.animals["turkeyhen"].alwaysFleeHumans = false;
AnimalDefinitions.animals["turkeyhen"].sittingTypeNbr = 1;
AnimalDefinitions.animals["turkeyhen"].wanderMul = 500;
AnimalDefinitions.animals["turkeyhen"].hutches = AnimalDefinitions.animals["turkeypoult"].hutches;
AnimalDefinitions.animals["turkeyhen"].enterHutchTime = AnimalDefinitions.animals["turkeypoult"].enterHutchTime;
AnimalDefinitions.animals["turkeyhen"].exitHutchTime = AnimalDefinitions.animals["turkeypoult"].exitHutchTime;
AnimalDefinitions.animals["turkeyhen"].minEnclosureSize = 40;
AnimalDefinitions.animals["turkeyhen"].hungerMultiplier = 0.00055;
AnimalDefinitions.animals["turkeyhen"].thirstMultiplier = 0.0015;
AnimalDefinitions.animals["turkeyhen"].idleTypeNbr = 5;
AnimalDefinitions.animals["turkeyhen"].healthLossMultiplier = 0.1;
AnimalDefinitions.animals["turkeyhen"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits,Seeds,Nuts";
AnimalDefinitions.animals["turkeyhen"].attackDist = 1;
AnimalDefinitions.animals["turkeyhen"].attackTimer = 3500;
AnimalDefinitions.animals["turkeyhen"].baseDmg = 0.1;
AnimalDefinitions.animals["turkeyhen"].trailerBaseSize = 40;
AnimalDefinitions.animals["turkeyhen"].collisionSize = 0.27;
AnimalDefinitions.animals["turkeyhen"].baseEncumbrance = 25;
AnimalDefinitions.animals["turkeyhen"].canBePet = true;
AnimalDefinitions.animals["turkeyhen"].collidable = false;
AnimalDefinitions.animals["turkeyhen"].minWeight = 4;
AnimalDefinitions.animals["turkeyhen"].maxWeight = 9;
AnimalDefinitions.animals["turkeyhen"].canThump = false;
AnimalDefinitions.animals["turkeyhen"].group = "turkey";
AnimalDefinitions.animals["turkeyhen"].dung = "Dung_Turkey";
AnimalDefinitions.animals["turkeyhen"].stressUnderRain = true;
AnimalDefinitions.animals["turkeyhen"].hungerBoost = 7;
AnimalDefinitions.animals["turkeyhen"].thirstBoost = 15;
AnimalDefinitions.animals["turkeyhen"].distToEat = 1;
AnimalDefinitions.animals["turkeyhen"].corpseSize = 0.7;
AnimalDefinitions.animals["turkeyhen"].idleSoundRadius = 20;
AnimalDefinitions.animals["turkeyhen"].idleSoundVolume = 10;

AnimalDefinitions.animals["gobblers"] = {};
AnimalDefinitions.animals["gobblers"].bodyModel = "Turkey";
AnimalDefinitions.animals["gobblers"].bodyModelSkel = "Turkey_Skeleton";
AnimalDefinitions.animals["gobblers"].textureSkeleton = "TurkeySkeleton";
AnimalDefinitions.animals["gobblers"].bodyModelSkelNoHead = "Turkey_Skeleton_NoHead";
AnimalDefinitions.animals["gobblers"].animset = "turkey";
AnimalDefinitions.animals["gobblers"].shadoww = AnimalDefinitions.animals["turkeyhen"].shadoww;
AnimalDefinitions.animals["gobblers"].shadowfm = AnimalDefinitions.animals["turkeyhen"].shadowfm;
AnimalDefinitions.animals["gobblers"].shadowbm = AnimalDefinitions.animals["turkeyhen"].shadowbm;
AnimalDefinitions.animals["gobblers"].eatingTypeNbr = AnimalDefinitions.animals["turkeyhen"].eatingTypeNbr;
AnimalDefinitions.animals["gobblers"].sitRandomly = AnimalDefinitions.animals["turkeyhen"].sitRandomly;
AnimalDefinitions.animals["gobblers"].turnDelta = AnimalDefinitions.animals["turkeyhen"].turnDelta;
AnimalDefinitions.animals["gobblers"].animalSize = AnimalDefinitions.animals["turkeyhen"].animalSize;
AnimalDefinitions.animals["gobblers"].minSize = AnimalDefinitions.animals["turkeyhen"].minSize;
AnimalDefinitions.animals["gobblers"].maxSize = AnimalDefinitions.animals["turkeyhen"].maxSize;
AnimalDefinitions.animals["gobblers"].minAge = AnimalDefinitions.animals["turkeyhen"].minAge;
AnimalDefinitions.animals["gobblers"].maxAgeGeriatric = AnimalDefinitions.animals["turkeyhen"].maxAgeGeriatric;
AnimalDefinitions.animals["gobblers"].idleEmoteChance = AnimalDefinitions.animals["turkeyhen"].idleEmoteChance;
AnimalDefinitions.animals["gobblers"].male = true;
AnimalDefinitions.animals["gobblers"].canBePicked = true;
AnimalDefinitions.animals["gobblers"].minAgeForBaby = 18 * 7;
AnimalDefinitions.animals["gobblers"].babyType = AnimalDefinitions.animals["turkeyhen"].babyType;
AnimalDefinitions.animals["gobblers"].mate = "turkeyhen";
AnimalDefinitions.animals["gobblers"].genes = AnimalDefinitions.genome["turkey"].genes;
AnimalDefinitions.animals["gobblers"].stages = AnimalDefinitions.stages["turkey"].stages;
AnimalDefinitions.animals["gobblers"].breeds = copyTable(AnimalDefinitions.breeds["turkey"].breeds);
AnimalDefinitions.animals["gobblers"].alwaysFleeHumans = AnimalDefinitions.animals["turkeyhen"].alwaysFleeHumans;
AnimalDefinitions.animals["gobblers"].wanderMul = AnimalDefinitions.animals["turkeyhen"].wanderMul;
AnimalDefinitions.animals["gobblers"].hutches = AnimalDefinitions.animals["turkeypoult"].hutches;
AnimalDefinitions.animals["gobblers"].enterHutchTime = AnimalDefinitions.animals["turkeypoult"].enterHutchTime;
AnimalDefinitions.animals["gobblers"].exitHutchTime = AnimalDefinitions.animals["turkeypoult"].exitHutchTime;
AnimalDefinitions.animals["gobblers"].hungerMultiplier = AnimalDefinitions.animals["turkeyhen"].hungerMultiplier;
AnimalDefinitions.animals["gobblers"].thirstMultiplier = AnimalDefinitions.animals["turkeyhen"].thirstMultiplier;
AnimalDefinitions.animals["gobblers"].idleTypeNbr = AnimalDefinitions.animals["turkeyhen"].idleTypeNbr;
AnimalDefinitions.animals["gobblers"].sittingTypeNbr = AnimalDefinitions.animals["turkeyhen"].sittingTypeNbr;
AnimalDefinitions.animals["gobblers"].healthLossMultiplier = AnimalDefinitions.animals["turkeyhen"].healthLossMultiplier;
AnimalDefinitions.animals["gobblers"].sittingPeriod = AnimalDefinitions.animals["turkeyhen"].sittingPeriod;
AnimalDefinitions.animals["gobblers"].eatTypeTrough = AnimalDefinitions.animals["turkeyhen"].eatTypeTrough;
AnimalDefinitions.animals["gobblers"].attackDist = AnimalDefinitions.animals["turkeyhen"].attackDist;
AnimalDefinitions.animals["gobblers"].attackTimer = AnimalDefinitions.animals["turkeyhen"].attackTimer;
AnimalDefinitions.animals["gobblers"].fleeHumansMod = 0.8; -- TODO Is that useful to have some animals less likely to flee humans?
AnimalDefinitions.animals["gobblers"].dontAttackOtherMale = false;
AnimalDefinitions.animals["gobblers"].baseDmg = AnimalDefinitions.animals["turkeyhen"].baseDmg;
AnimalDefinitions.animals["gobblers"].trailerBaseSize = AnimalDefinitions.animals["turkeyhen"].trailerBaseSize;
AnimalDefinitions.animals["gobblers"].collisionSize = AnimalDefinitions.animals["turkeyhen"].collisionSize;
AnimalDefinitions.animals["gobblers"].baseEncumbrance = AnimalDefinitions.animals["turkeyhen"].baseEncumbrance;
AnimalDefinitions.animals["gobblers"].canBePet = true;
AnimalDefinitions.animals["gobblers"].collidable = false;
AnimalDefinitions.animals["gobblers"].minWeight = 8;
AnimalDefinitions.animals["gobblers"].maxWeight = 12;
AnimalDefinitions.animals["gobblers"].canThump = false;
AnimalDefinitions.animals["gobblers"].group = "turkey";
AnimalDefinitions.animals["gobblers"].dung = "Dung_Turkey";
AnimalDefinitions.animals["gobblers"].matingPeriodStart = 4;
AnimalDefinitions.animals["gobblers"].matingPeriodEnd = 5;
AnimalDefinitions.animals["gobblers"].stressUnderRain = true;
AnimalDefinitions.animals["gobblers"].attackIfStressed = true;
AnimalDefinitions.animals["gobblers"].attackBack = true;
AnimalDefinitions.animals["gobblers"].hungerBoost = 7;
AnimalDefinitions.animals["gobblers"].thirstBoost = 15;
AnimalDefinitions.animals["gobblers"].distToEat = 1;
AnimalDefinitions.animals["gobblers"].minBodyPart = 11;
AnimalDefinitions.animals["gobblers"].corpseSize = 0.7;
AnimalDefinitions.animals["gobblers"].idleSoundRadius = 20;
AnimalDefinitions.animals["gobblers"].idleSoundVolume = 10;


local turkey_sounds = {
	death = { name = "AnimalVoiceTurkeyDeath", slot = "voice", priority = 100 },
	fight = { name = "AnimalVoiceTurkeyFight", slot = "voice" },
	idle = { name = "AnimalVoiceTurkeyIdleWalk", intervalMin = 20, intervalMax = 30, slot = "voice" },
	idle_fly = { name = "AnimalVoiceTurkeyIdleFly", slot = "voice" },
	idle_peck = { name = "AnimalVoiceChickenIdlePeck", slot = "voice" },
	idle_walk = { name = "AnimalVoiceTurkeyIdleWalk", intervalMin = 7, intervalMax = 10, slot = "voice" },
	pain = { name = "AnimalVoiceTurkeyPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalTurkey" },
	pick_up = { name = "PickUpAnimalTurkey", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadTurkey" },
	put_down = { name = "PutDownAnimalTurkey", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadTurkey" },
	run = { name = "AnimalFootstepsTurkeyWalk" },
	stressed = { name = "AnimalVoiceTurkeyStressed", intervalMin = 3, intervalMax = 5, slot = "voice" },
	walk = { name = "AnimalFootstepsTurkeyWalk" },
	scratching = { name = "AnimalFoleyTurkeyScratching", slot = "voice" },
	grooming = { name = "AnimalFoleyTurkeyGrooming", slot = "voice" },
}

AnimalDefinitions.animals["turkeyhen"].breeds["meleagris"].sounds = turkey_sounds

local turkey_poult_sounds = {
	death = { name = "AnimalVoiceTurkeyPoultDeath", slot = "voice", priority = 100 },
	idle = { name = "AnimalVoiceTurkeyPoultIdle", intervalMin = 15, intervalMax = 30, slot = "voice" },
	pain = { name = "AnimalVoiceTurkeyPoultPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalChick" },
	pick_up = { name = "PickUpAnimalTurkeyPoult", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadTurkeyPoult" },
	put_down = { name = "PutDownAnimalTurkeyPoult", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadTurkeyPoult" },
	stressed = { name = "AnimalVoiceTurkeyPoultStressed", intervalMin = 2, intervalMax = 3, slot = "voice" },
}

AnimalDefinitions.animals["turkeypoult"].breeds["meleagris"].sounds = turkey_poult_sounds

AnimalDefinitions.animals["gobblers"].breeds["meleagris"].sounds = turkey_sounds

