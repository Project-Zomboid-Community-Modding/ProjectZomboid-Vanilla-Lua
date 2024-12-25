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
AnimalDefinitions.stages["chicken"] = {};
AnimalDefinitions.stages["chicken"].stages = {};
AnimalDefinitions.stages["chicken"].stages["chick"] = {};
AnimalDefinitions.stages["chicken"].stages["chick"].ageToGrow = 18 * 7; -- 18 weeks
AnimalDefinitions.stages["chicken"].stages["chick"].nextStage = "hen";
AnimalDefinitions.stages["chicken"].stages["chick"].nextStageMale = "cockerel";

AnimalDefinitions.stages["chicken"].stages["hen"] = {};
AnimalDefinitions.stages["chicken"].stages["hen"].ageToGrow = 12 * 30; -- 1 year

AnimalDefinitions.stages["chicken"].stages["cockerel"] = {}
AnimalDefinitions.stages["chicken"].stages["cockerel"].ageToGrow = 12 * 30;


-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["chicken"] = {};
AnimalDefinitions.breeds["chicken"].breeds = {};
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"] = {};
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].name = "rhodeisland";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].textureBaby = "chick";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].texture = "chicken";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].textureMale = "cockerel";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].invIconMale = "Item_Chicken_RoosterBrown";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].invIconFemale = "Item_Chicken_HenBrown";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].invIconBaby = "Item_Chicken_Chick";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].invIconMaleDead = "Item_Chicken_RoosterBrown_Dead";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].invIconFemaleDead = "Item_Chicken_HenBrown_Dead";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].invIconBabyDead = "Item_Chicken_Chick_Dead";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].featherItem = "Base.ChickenFeather";
AnimalDefinitions.breeds["chicken"].breeds["rhodeisland"].maxFeather = 100;

AnimalDefinitions.breeds["chicken"].breeds["leghorn"] = {};
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].name = "leghorn";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].textureBaby = "chick";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].texture = "chicken_white";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].textureMale = "cockerel_white";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].invIconMale = "Item_Chicken_RoosterWhite";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].invIconFemale = "Item_Chicken_HenWhite";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].invIconBaby = "Item_Chicken_Chick";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].invIconMaleDead = "Item_Chicken_RoosterWhite_Dead";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].invIconFemaleDead = "Item_Chicken_HenWhite_Dead";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].invIconBabyDead = "Item_Chicken_Chick_Dead";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].featherItem = "Base.ChickenFeather";
AnimalDefinitions.breeds["chicken"].breeds["leghorn"].maxFeather = 100;


-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {};
AnimalDefinitions.genome["chicken"] = {};
AnimalDefinitions.genome["chicken"].genes = {};
AnimalDefinitions.genome["chicken"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["chicken"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["chicken"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["chicken"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["chicken"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["chicken"].genes["strength"] = "strength";
AnimalDefinitions.genome["chicken"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["chicken"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["chicken"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["chicken"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["chicken"].genes["fertility"] = "fertility"
AnimalDefinitions.genome["chicken"].genes["eggSize"] = "eggSize";
AnimalDefinitions.genome["chicken"].genes["stress"] = "stress";

-- animals
AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["chick"] = {};
AnimalDefinitions.animals["chick"].bodyModel = "Chicken_Chick";
AnimalDefinitions.animals["chick"].bodyModelSkel = "Chicken_Chick_Skeleton";
AnimalDefinitions.animals["chick"].textureSkeleton = "ChickenSkeleton";
AnimalDefinitions.animals["chick"].animset = "chick";
AnimalDefinitions.animals["chick"].shadoww = 0.15;
AnimalDefinitions.animals["chick"].shadowfm = 0.2;
AnimalDefinitions.animals["chick"].shadowbm = 0.2;
AnimalDefinitions.animals["chick"].turnDelta = 0.7;
AnimalDefinitions.animals["chick"].animalSize = 0;
AnimalDefinitions.animals["chick"].minSize = 0.9;
AnimalDefinitions.animals["chick"].maxSize = 1;
AnimalDefinitions.animals["chick"].sitRandomly = true;
AnimalDefinitions.animals["chick"].genes = AnimalDefinitions.genome["chicken"].genes;
AnimalDefinitions.animals["chick"].stages = AnimalDefinitions.stages["chicken"].stages;
AnimalDefinitions.animals["chick"].breeds = copyTable(AnimalDefinitions.breeds["chicken"].breeds);
AnimalDefinitions.animals["chick"].alwaysFleeHumans = false;
AnimalDefinitions.animals["chick"].canBePicked = true;
AnimalDefinitions.animals["chick"].minEnclosureSize = 20;
AnimalDefinitions.animals["chick"].wanderMul = 200;
AnimalDefinitions.animals["chick"].hutches = "hutchhen,hutchturkey"; -- list separated by ','
AnimalDefinitions.animals["chick"].enterHutchTime = 20;
AnimalDefinitions.animals["chick"].exitHutchTime = 7;
AnimalDefinitions.animals["chick"].attackDist = 0;
AnimalDefinitions.animals["chick"].attackTimer = 3500;
AnimalDefinitions.animals["chick"].hungerMultiplier = 0.0001;
AnimalDefinitions.animals["chick"].thirstMultiplier = 0.0002;
AnimalDefinitions.animals["chick"].idleTypeNbr = 4;
AnimalDefinitions.animals["chick"].sittingTypeNbr = 1;
AnimalDefinitions.animals["chick"].eatingTypeNbr = 1;
AnimalDefinitions.animals["chick"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits,Seeds,Nuts,Nut,Insect";
--AnimalDefinitions.animals["hen"].periodicRun = true;
AnimalDefinitions.animals["chick"].healthLossMultiplier = 0.2;
AnimalDefinitions.animals["chick"].idleEmoteChance = 500;
AnimalDefinitions.animals["chick"].trailerBaseSize = 20;
AnimalDefinitions.animals["chick"].collisionSize = 0; -- no need collision for chick
AnimalDefinitions.animals["chick"].baseEncumbrance = 10;
AnimalDefinitions.animals["chick"].canBePet = true;
AnimalDefinitions.animals["chick"].collidable = false; -- don't collide wiht chick or chicken
AnimalDefinitions.animals["chick"].minWeight = 0.05;
AnimalDefinitions.animals["chick"].maxWeight = 0.2;
AnimalDefinitions.animals["chick"].canThump = false;
AnimalDefinitions.animals["chick"].group = "chicken";
AnimalDefinitions.animals["chick"].dung = "Dung_Chicken";
AnimalDefinitions.animals["chick"].needMom = false; -- every baby will follow their mom, if they can't find her it'll be displayed in their animalUI, this set to false won't display the message, as a chick doesn't need suckling it doesn't matter
AnimalDefinitions.animals["chick"].hungerBoost = 15;
AnimalDefinitions.animals["chick"].thirstBoost = 22;
AnimalDefinitions.animals["chick"].distToEat = 1;
AnimalDefinitions.animals["chick"].corpseSize = 0;

AnimalDefinitions.animals["hen"] = {};
AnimalDefinitions.animals["hen"].bodyModel = "Chicken_Hen";
AnimalDefinitions.animals["hen"].bodyModelSkel = "Chicken_Skeleton";
AnimalDefinitions.animals["hen"].textureSkeleton = "ChickenSkeleton";
AnimalDefinitions.animals["hen"].animset = "hen";
AnimalDefinitions.animals["hen"].shadoww = 0.4;
AnimalDefinitions.animals["hen"].shadowfm = 0.5;
AnimalDefinitions.animals["hen"].shadowbm = 0.5;
AnimalDefinitions.animals["hen"].turnDelta = 0.7;
AnimalDefinitions.animals["hen"].animalSize = 0.1;
AnimalDefinitions.animals["hen"].minSize = 0.8;
AnimalDefinitions.animals["hen"].maxSize = 1.1;
AnimalDefinitions.animals["hen"].minAge = AnimalDefinitions.stages["chicken"].stages["chick"].ageToGrow;
AnimalDefinitions.animals["hen"].babyType = "chick";
AnimalDefinitions.animals["hen"].eggsPerDay = 1;
AnimalDefinitions.animals["hen"].fertilizedTimeMax = 14 * 24; -- in hour, (2 weeks here) the time the animal will stay fertile once a rooster fertilized it
AnimalDefinitions.animals["hen"].eggType = "Base.Egg"; -- if one animal can have eggs, they can be fertilized or not, depend if a rooster mated with the chicken or not
AnimalDefinitions.animals["hen"].timeToHatch = 21 * 24; -- in hour (21 days here) the time the egg will take to hatch a baby
AnimalDefinitions.animals["hen"].canBePicked = true;
AnimalDefinitions.animals["hen"].sitRandomly = true;
AnimalDefinitions.animals["hen"].minAgeForBaby = 2;
AnimalDefinitions.animals["hen"].idleEmoteChance = 650;
AnimalDefinitions.animals["hen"].maxAgeGeriatric = 12 * 12 * 30;
AnimalDefinitions.animals["hen"].female = true;
AnimalDefinitions.animals["hen"].genes = AnimalDefinitions.genome["chicken"].genes;
AnimalDefinitions.animals["hen"].stages = AnimalDefinitions.stages["chicken"].stages;
AnimalDefinitions.animals["hen"].breeds = AnimalDefinitions.breeds["chicken"].breeds;
AnimalDefinitions.animals["hen"].alwaysFleeHumans = false;
AnimalDefinitions.animals["hen"].eatingTypeNbr = 1;
AnimalDefinitions.animals["hen"].sittingTypeNbr = 1;
AnimalDefinitions.animals["hen"].wanderMul = 500;
AnimalDefinitions.animals["hen"].minEnclosureSize = 40;
AnimalDefinitions.animals["hen"].hungerMultiplier = 0.0005;
AnimalDefinitions.animals["hen"].thirstMultiplier = 0.001;
AnimalDefinitions.animals["hen"].idleTypeNbr = 5;
AnimalDefinitions.animals["hen"].healthLossMultiplier = 0.1;
AnimalDefinitions.animals["hen"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits,Seeds,Nuts,Nut,Insect";
AnimalDefinitions.animals["hen"].hutches = AnimalDefinitions.animals["chick"].hutches;
AnimalDefinitions.animals["hen"].enterHutchTime = AnimalDefinitions.animals["chick"].enterHutchTime;
AnimalDefinitions.animals["hen"].exitHutchTime = AnimalDefinitions.animals["chick"].exitHutchTime;
AnimalDefinitions.animals["hen"].attackDist = 1;
AnimalDefinitions.animals["hen"].attackTimer = 3500;
AnimalDefinitions.animals["hen"].baseDmg = 0.1;
AnimalDefinitions.animals["hen"].trailerBaseSize = 30;
AnimalDefinitions.animals["hen"].collisionSize = 0.24;
AnimalDefinitions.animals["hen"].baseEncumbrance = 20; -- base weight when holding the animal inside inventory, will be multiplied by animal's size
AnimalDefinitions.animals["hen"].canBePet = true;
AnimalDefinitions.animals["hen"].collidable = false; -- don't collide wiht chick or chicken
AnimalDefinitions.animals["hen"].minWeight = 2;
AnimalDefinitions.animals["hen"].maxWeight = 5;
AnimalDefinitions.animals["hen"].canThump = false;
AnimalDefinitions.animals["hen"].group = "chicken";
AnimalDefinitions.animals["hen"].dung = "Dung_Chicken";
AnimalDefinitions.animals["hen"].hungerBoost = 9;
AnimalDefinitions.animals["hen"].thirstBoost = 15;
AnimalDefinitions.animals["hen"].distToEat = 1;
AnimalDefinitions.animals["hen"].corpseSize = 0.7;
AnimalDefinitions.animals["hen"].idleSoundRadius = 20;
AnimalDefinitions.animals["hen"].idleSoundVolume = 10;

AnimalDefinitions.animals["cockerel"] = {};
AnimalDefinitions.animals["cockerel"].bodyModel = "Chicken_Cockrel";
AnimalDefinitions.animals["cockerel"].bodyModelSkel = "Cockerel_Skeleton";
AnimalDefinitions.animals["cockerel"].textureSkeleton = "ChickenSkeleton";
AnimalDefinitions.animals["cockerel"].animset = "cockerel";
AnimalDefinitions.animals["cockerel"].shadoww = AnimalDefinitions.animals["hen"].shadoww;
AnimalDefinitions.animals["cockerel"].shadowfm = AnimalDefinitions.animals["hen"].shadowfm;
AnimalDefinitions.animals["cockerel"].shadowbm = AnimalDefinitions.animals["hen"].shadowbm;
AnimalDefinitions.animals["cockerel"].eatingTypeNbr = AnimalDefinitions.animals["hen"].eatingTypeNbr;
AnimalDefinitions.animals["cockerel"].sitRandomly = AnimalDefinitions.animals["hen"].sitRandomly;
AnimalDefinitions.animals["cockerel"].turnDelta = AnimalDefinitions.animals["hen"].turnDelta;
AnimalDefinitions.animals["cockerel"].animalSize = AnimalDefinitions.animals["hen"].animalSize;
AnimalDefinitions.animals["cockerel"].minSize = AnimalDefinitions.animals["hen"].minSize;
AnimalDefinitions.animals["cockerel"].maxSize = AnimalDefinitions.animals["hen"].maxSize;
AnimalDefinitions.animals["cockerel"].minAge = AnimalDefinitions.animals["hen"].minAge;
AnimalDefinitions.animals["cockerel"].maxAgeGeriatric = AnimalDefinitions.animals["hen"].maxAgeGeriatric;
AnimalDefinitions.animals["cockerel"].idleEmoteChance = AnimalDefinitions.animals["hen"].idleEmoteChance;
AnimalDefinitions.animals["cockerel"].male = true;
AnimalDefinitions.animals["cockerel"].canBePicked = true;
AnimalDefinitions.animals["cockerel"].minAgeForBaby = 7 * 18;
AnimalDefinitions.animals["cockerel"].babyType = AnimalDefinitions.animals["hen"].babyType;
AnimalDefinitions.animals["cockerel"].mate = "hen";
AnimalDefinitions.animals["cockerel"].genes = AnimalDefinitions.genome["chicken"].genes;
AnimalDefinitions.animals["cockerel"].stages = AnimalDefinitions.stages["chicken"].stages;
AnimalDefinitions.animals["cockerel"].breeds = copyTable(AnimalDefinitions.breeds["chicken"].breeds);
AnimalDefinitions.animals["cockerel"].alwaysFleeHumans = AnimalDefinitions.animals["hen"].alwaysFleeHumans;
AnimalDefinitions.animals["cockerel"].wanderMul = AnimalDefinitions.animals["hen"].wanderMul;
AnimalDefinitions.animals["cockerel"].hungerMultiplier = AnimalDefinitions.animals["hen"].hungerMultiplier;
AnimalDefinitions.animals["cockerel"].thirstMultiplier = AnimalDefinitions.animals["hen"].thirstMultiplier;
AnimalDefinitions.animals["cockerel"].idleTypeNbr = AnimalDefinitions.animals["hen"].idleTypeNbr;
AnimalDefinitions.animals["cockerel"].sittingTypeNbr = AnimalDefinitions.animals["hen"].sittingTypeNbr;
AnimalDefinitions.animals["cockerel"].healthLossMultiplier = AnimalDefinitions.animals["hen"].healthLossMultiplier;
AnimalDefinitions.animals["cockerel"].sittingPeriod = AnimalDefinitions.animals["hen"].sittingPeriod;
AnimalDefinitions.animals["cockerel"].eatTypeTrough = AnimalDefinitions.animals["hen"].eatTypeTrough;
AnimalDefinitions.animals["cockerel"].hutches = AnimalDefinitions.animals["chick"].hutches;
AnimalDefinitions.animals["cockerel"].enterHutchTime = AnimalDefinitions.animals["chick"].enterHutchTime;
AnimalDefinitions.animals["cockerel"].exitHutchTime = AnimalDefinitions.animals["chick"].exitHutchTime;
AnimalDefinitions.animals["cockerel"].attackDist = AnimalDefinitions.animals["hen"].attackDist;
AnimalDefinitions.animals["cockerel"].attackTimer = AnimalDefinitions.animals["hen"].attackTimer;
AnimalDefinitions.animals["cockerel"].fleeHumansMod = 0.8; -- TODO Is that useful to have some animals less likely to flee humans?
AnimalDefinitions.animals["cockerel"].dontAttackOtherMale = false;
AnimalDefinitions.animals["cockerel"].attackIfStressed = true;
AnimalDefinitions.animals["cockerel"].attackBack = true;
AnimalDefinitions.animals["cockerel"].baseDmg = AnimalDefinitions.animals["hen"].baseDmg;
AnimalDefinitions.animals["cockerel"].trailerBaseSize = AnimalDefinitions.animals["hen"].trailerBaseSize;
AnimalDefinitions.animals["cockerel"].collisionSize = AnimalDefinitions.animals["hen"].collisionSize;
AnimalDefinitions.animals["cockerel"].baseEncumbrance = AnimalDefinitions.animals["hen"].baseEncumbrance;
AnimalDefinitions.animals["cockerel"].canBePet = true;
AnimalDefinitions.animals["cockerel"].collidable = false; -- don't collide wiht chick or chicken
AnimalDefinitions.animals["cockerel"].minWeight = 2.5;
AnimalDefinitions.animals["cockerel"].maxWeight = 6;
AnimalDefinitions.animals["cockerel"].canThump = false;
AnimalDefinitions.animals["cockerel"].group = "chicken";
AnimalDefinitions.animals["cockerel"].dung = "Dung_Chicken";
AnimalDefinitions.animals["cockerel"].hungerBoost = 9;
AnimalDefinitions.animals["cockerel"].thirstBoost = 15;
AnimalDefinitions.animals["cockerel"].distToEat = 1;
AnimalDefinitions.animals["cockerel"].minBodyPart = 11; -- this is used to make this animal hit up to legs (11 being BodyPartType.UpperLeg_L) max.
AnimalDefinitions.animals["cockerel"].corpseSize = 0.7;
AnimalDefinitions.animals["cockerel"].idleSoundRadius = 20;
AnimalDefinitions.animals["cockerel"].idleSoundVolume = 10;


local chicken_sounds = {
	death = { name = "AnimalVoiceChickenDeath", slot = "voice", priority = 100 },
	fight = { name = "AnimalVoiceChickenFight", slot = "voice" },
	idle_fly = { name = "AnimalVoiceChickenIdleFly", slot = "voice" },
	idle_peck = { name = "AnimalVoiceChickenIdlePeck", slot = "voice" },
	idle = { name = "AnimalVoiceChickenIdleWalk", intervalMin = 20, intervalMax = 30, slot = "voice" },
	idle_walk = { name = "AnimalVoiceChickenIdleWalk", intervalMin = 7, intervalMax = 10, slot = "voice" },
	pain = { name = "AnimalVoiceChickenPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalChicken" },
	pick_up = { name = "PickUpAnimalChicken", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadChicken" },
	put_down = { name = "PutDownAnimalChicken", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadChicken" },
	scratching = { name = "AnimalFoleyTurkeyScratching", slot = "voice" },
	grooming = { name = "AnimalFoleyTurkeyGrooming", slot = "voice" },
	run = { name = "AnimalFootstepsChickenWalk" },
	stressed = { name = "AnimalVoiceChickenStressed", intervalMin = 2, intervalMax = 30, slot = "voice" },
	walk = { name = "AnimalFootstepsChickenWalk" },
}

AnimalDefinitions.animals["hen"].breeds["leghorn"].sounds = chicken_sounds
AnimalDefinitions.animals["hen"].breeds["rhodeisland"].sounds = chicken_sounds

local chick_sounds = {
	death = { name = "AnimalVoiceChickDeath", slot = "voice", priority = 100 },
	idle = { name = "AnimalVoiceChickIdle", intervalMin = 15, intervalMax = 30, slot = "voice" },
	pain = { name = "AnimalVoiceChickPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalChick" },
	pick_up = { name = "PickUpAnimalChick", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadChick" },
	put_down = { name = "PutDownAnimalChick", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadChick" },
	stressed = { name = "AnimalVoiceChickStressed", intervalMin = 2, intervalMax = 30, slot = "voice" },
}

-- NOTE: chick.breeds must not be the same table as hen.breeds.
AnimalDefinitions.animals["chick"].breeds["leghorn"].sounds = chick_sounds
AnimalDefinitions.animals["chick"].breeds["rhodeisland"].sounds = chick_sounds

-- NOTE: cockerel.breeds must not be the same table as hen.breeds.
AnimalDefinitions.animals["cockerel"].breeds["leghorn"].sounds = chicken_sounds
AnimalDefinitions.animals["cockerel"].breeds["rhodeisland"].sounds = chicken_sounds

