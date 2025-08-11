
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
AnimalDefinitions.stages["rat"] = {};
AnimalDefinitions.stages["rat"].stages = {};
AnimalDefinitions.stages["rat"].stages["ratbaby"] = {};
AnimalDefinitions.stages["rat"].stages["ratbaby"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["rat"].stages["ratbaby"].nextStage = "ratfemale";
AnimalDefinitions.stages["rat"].stages["ratbaby"].nextStageMale = "rat";
AnimalDefinitions.stages["rat"].stages["rat"] = {};
AnimalDefinitions.stages["rat"].stages["rat"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["rat"].stages["ratfemale"] = {};
AnimalDefinitions.stages["rat"].stages["ratfemale"].ageToGrow = 2 * 30;

-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["rat"] = {};
AnimalDefinitions.breeds["rat"].breeds = {};
AnimalDefinitions.breeds["rat"].breeds["grey"] = {};
AnimalDefinitions.breeds["rat"].breeds["grey"].name = "grey";
AnimalDefinitions.breeds["rat"].breeds["grey"].texture = "Rat";
AnimalDefinitions.breeds["rat"].breeds["grey"].textureMale = "Rat";
AnimalDefinitions.breeds["rat"].breeds["grey"].rottenTexture = "Rat_Rotting";
AnimalDefinitions.breeds["rat"].breeds["grey"].forcedGenes = {};
AnimalDefinitions.breeds["rat"].breeds["grey"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["rat"].breeds["grey"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["rat"].breeds["grey"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["rat"].breeds["grey"].invIconMale = "Item_Rat";
AnimalDefinitions.breeds["rat"].breeds["grey"].invIconFemale = "Item_Rat";
AnimalDefinitions.breeds["rat"].breeds["grey"].invIconBaby = "Item_Rat";
AnimalDefinitions.breeds["rat"].breeds["grey"].invIconMaleDead = "Item_DeadRat.png";
AnimalDefinitions.breeds["rat"].breeds["grey"].invIconFemaleDead = "Item_DeadRat.png";
AnimalDefinitions.breeds["rat"].breeds["grey"].invIconBabyDead = "Item_DeadRat.png";
AnimalDefinitions.breeds["rat"].breeds["white"] = {};
AnimalDefinitions.breeds["rat"].breeds["white"].name = "white";
AnimalDefinitions.breeds["rat"].breeds["white"].texture = "Rat_White";
AnimalDefinitions.breeds["rat"].breeds["white"].textureMale = "Rat_White";
AnimalDefinitions.breeds["rat"].breeds["white"].rottenTexture = "RatWhite_Rotting";
AnimalDefinitions.breeds["rat"].breeds["white"].forcedGenes = {};
AnimalDefinitions.breeds["rat"].breeds["white"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["rat"].breeds["white"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["rat"].breeds["white"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["rat"].breeds["white"].invIconMale = "Item_Rat";
AnimalDefinitions.breeds["rat"].breeds["white"].invIconFemale = "Item_Rat";
AnimalDefinitions.breeds["rat"].breeds["white"].invIconBaby = "Item_Rat";
AnimalDefinitions.breeds["rat"].breeds["white"].invIconMaleDead = "Item_DeadRat.png";
AnimalDefinitions.breeds["rat"].breeds["white"].invIconFemaleDead = "Item_DeadRat.png";
AnimalDefinitions.breeds["rat"].breeds["white"].invIconBabyDead = "Item_DeadRat.png";

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {};
AnimalDefinitions.genome["rat"] = {};
AnimalDefinitions.genome["rat"].genes = {};
AnimalDefinitions.genome["rat"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["rat"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["rat"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["rat"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["rat"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["rat"].genes["strength"] = "strength";
AnimalDefinitions.genome["rat"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["rat"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["rat"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["rat"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["rat"].genes["fertility"] = "fertility"
AnimalDefinitions.genome["rat"].genes["stress"] = "stress";
AnimalDefinitions.genome["rat"].genes["maxMilk"] = "maxMilk";
AnimalDefinitions.genome["rat"].genes["milkInc"] = "milkInc";

-- animals
AnimalDefinitions.animals["ratbaby"] = { };
AnimalDefinitions.animals["ratbaby"].bodyModel = "Rat_Body";
AnimalDefinitions.animals["ratbaby"].bodyModelSkel = "Rat_Skeleton";
AnimalDefinitions.animals["ratbaby"].textureSkeleton = "RatSkeleton";
AnimalDefinitions.animals["ratbaby"].textureSkeletonBloody = "Rat_Skeleton_Butchered";
AnimalDefinitions.animals["ratbaby"].bodyModelSkelNoHead = "Rat_Skeleton_NoHead";
AnimalDefinitions.animals["ratbaby"].animset = "rat";
AnimalDefinitions.animals["ratbaby"].shadoww = 0.2;
AnimalDefinitions.animals["ratbaby"].shadowfm = 0.2;
AnimalDefinitions.animals["ratbaby"].shadowbm = 0.2;
AnimalDefinitions.animals["ratbaby"].wanderMul = 250;
AnimalDefinitions.animals["ratbaby"].breeds = copyTable(AnimalDefinitions.breeds["rat"].breeds);
AnimalDefinitions.animals["ratbaby"].stages = AnimalDefinitions.stages["rat"].stages;
AnimalDefinitions.animals["ratbaby"].genes = AnimalDefinitions.genome["rat"].genes;
AnimalDefinitions.animals["ratbaby"].minSize = 0.4
AnimalDefinitions.animals["ratbaby"].maxSize = 0.7;
AnimalDefinitions.animals["ratbaby"].hungerMultiplier = 0.00008;
AnimalDefinitions.animals["ratbaby"].thirstMultiplier = 0.00016;
AnimalDefinitions.animals["ratbaby"].alwaysFleeHumans = true;
AnimalDefinitions.animals["ratbaby"].collidable = false;
AnimalDefinitions.animals["ratbaby"].group = "rat";
AnimalDefinitions.animals["ratbaby"].canBePicked = true;
AnimalDefinitions.animals["ratbaby"].canBeKilledWithoutWeapon = true;
AnimalDefinitions.animals["ratbaby"].canBePet = true;
AnimalDefinitions.animals["ratbaby"].wild = true;
AnimalDefinitions.animals["ratbaby"].idleTypeNbr = 2;
AnimalDefinitions.animals["ratbaby"].canClimbStairs = true;
AnimalDefinitions.animals["ratbaby"].eatTypeTrough = "All";
AnimalDefinitions.animals["ratbaby"].needMom = false;
AnimalDefinitions.animals["ratbaby"].dontAttackOtherMale = true;
AnimalDefinitions.animals["ratbaby"].trailerBaseSize = 10;
AnimalDefinitions.animals["ratbaby"].minWeight = 0.1;
AnimalDefinitions.animals["ratbaby"].maxWeight = 0.3;
AnimalDefinitions.animals["ratbaby"].animalSize = 0;
AnimalDefinitions.animals["ratbaby"].attackDist = 0;
AnimalDefinitions.animals["ratbaby"].attackTimer = 1500;
AnimalDefinitions.animals["ratbaby"].baseEncumbrance = 5;
AnimalDefinitions.animals["ratbaby"].canThump = false;
AnimalDefinitions.animals["ratbaby"].minEnclosureSize = 20;
AnimalDefinitions.animals["ratbaby"].hungerBoost = 25;
AnimalDefinitions.animals["ratbaby"].thirstBoost = 30;
AnimalDefinitions.animals["ratbaby"].thirstHungerTrigger = 0.1;
AnimalDefinitions.animals["ratbaby"].distToEat = 1;
AnimalDefinitions.animals["ratbaby"].turnDelta = 0.95;
AnimalDefinitions.animals["ratbaby"].litterEatTogether = true;
AnimalDefinitions.animals["ratbaby"].eatFromMother = true;
AnimalDefinitions.animals["ratbaby"].addTrackingXp = false; -- don't add tracking/sneaking xp when near rats, only deer & bunnies have that
AnimalDefinitions.animals["ratbaby"].corpseSize = 0;
AnimalDefinitions.animals["ratbaby"].dung = "Dung_Rat";
AnimalDefinitions.animals["ratbaby"].wildFleeTimeUntilDeadTimer = 50;


AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["ratfemale"] = {};
AnimalDefinitions.animals["ratfemale"].bodyModel = "Rat_Body";
AnimalDefinitions.animals["ratfemale"].bodyModelSkel = "Rat_Skeleton";
AnimalDefinitions.animals["ratfemale"].textureSkeleton = "RatSkeleton";
AnimalDefinitions.animals["ratfemale"].textureSkeletonBloody = "Rat_Skeleton_Butchered";
AnimalDefinitions.animals["ratfemale"].bodyModelSkelNoHead = "Rat_Skeleton_NoHead";
AnimalDefinitions.animals["ratfemale"].animset = "rat";
AnimalDefinitions.animals["ratfemale"].shadoww = 0.2;
AnimalDefinitions.animals["ratfemale"].shadowfm = 0.2;
AnimalDefinitions.animals["ratfemale"].shadowbm = 0.2;
AnimalDefinitions.animals["ratfemale"].minSize = 0.7;
AnimalDefinitions.animals["ratfemale"].maxSize = 1;
AnimalDefinitions.animals["ratfemale"].breeds = AnimalDefinitions.breeds["rat"].breeds;
AnimalDefinitions.animals["ratfemale"].stages = AnimalDefinitions.stages["rat"].stages;
AnimalDefinitions.animals["ratfemale"].genes = AnimalDefinitions.genome["rat"].genes;
AnimalDefinitions.animals["ratfemale"].mate = "rat";
AnimalDefinitions.animals["ratfemale"].female = true;
AnimalDefinitions.animals["ratfemale"].hungerMultiplier = 0.0001;
AnimalDefinitions.animals["ratfemale"].thirstMultiplier = 0.0002;
AnimalDefinitions.animals["ratfemale"].minAge = AnimalDefinitions.stages["rat"].stages["ratbaby"].ageToGrow;
AnimalDefinitions.animals["ratfemale"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["ratfemale"].minAgeForBaby = AnimalDefinitions.animals["ratfemale"].minAge;
AnimalDefinitions.animals["ratfemale"].pregnantPeriod = 23;
AnimalDefinitions.animals["ratfemale"].babyType = "ratbaby";
AnimalDefinitions.animals["ratfemale"].babyNbr = "2,10";
AnimalDefinitions.animals["ratfemale"].wanderMul = 400;
AnimalDefinitions.animals["ratfemale"].alwaysFleeHumans = true;
AnimalDefinitions.animals["ratfemale"].collidable = false;
AnimalDefinitions.animals["ratfemale"].group = "rat";
AnimalDefinitions.animals["ratfemale"].canBePet = true;
AnimalDefinitions.animals["ratfemale"].canBePicked = true;
AnimalDefinitions.animals["ratfemale"].canBeKilledWithoutWeapon = true;
AnimalDefinitions.animals["ratfemale"].wild = true;
AnimalDefinitions.animals["ratfemale"].idleTypeNbr = 2;
AnimalDefinitions.animals["ratfemale"].canClimbStairs = true; -- most animals can't climb stairs, this is defaulted to false
AnimalDefinitions.animals["ratfemale"].eatTypeTrough = "All";
AnimalDefinitions.animals["ratfemale"].timeBeforeNextPregnancy = 5;
AnimalDefinitions.animals["ratfemale"].trailerBaseSize = 10;
AnimalDefinitions.animals["ratfemale"].minWeight = 0.3;
AnimalDefinitions.animals["ratfemale"].maxWeight = 0.5;
AnimalDefinitions.animals["ratfemale"].animalSize = 0;
AnimalDefinitions.animals["ratfemale"].attackDist = 0;
AnimalDefinitions.animals["ratfemale"].attackTimer = 1500;
AnimalDefinitions.animals["ratfemale"].baseEncumbrance = 7;
AnimalDefinitions.animals["ratfemale"].canThump = false;
AnimalDefinitions.animals["ratfemale"].minEnclosureSize = 20;
AnimalDefinitions.animals["ratfemale"].hungerBoost = 18;
AnimalDefinitions.animals["ratfemale"].thirstBoost = 22;
AnimalDefinitions.animals["ratfemale"].thirstHungerTrigger = 0.1;
AnimalDefinitions.animals["ratfemale"].distToEat = 0.4;
AnimalDefinitions.animals["ratfemale"].turnDelta = 0.95;
AnimalDefinitions.animals["ratfemale"].udder = true;
AnimalDefinitions.animals["ratfemale"].minMilk = 1;
AnimalDefinitions.animals["ratfemale"].maxMilk = 2;
AnimalDefinitions.animals["ratfemale"].addTrackingXp = false;
AnimalDefinitions.animals["ratfemale"].corpseSize = 0;
AnimalDefinitions.animals["ratfemale"].dung = "Dung_Rat";
AnimalDefinitions.animals["ratfemale"].wildFleeTimeUntilDeadTimer = 100;


AnimalDefinitions.animals["rat"] = {};
AnimalDefinitions.animals["rat"].bodyModel = "Rat_Body";
AnimalDefinitions.animals["rat"].bodyModelSkel = "Rat_Skeleton";
AnimalDefinitions.animals["rat"].textureSkeleton = "RatSkeleton";
AnimalDefinitions.animals["rat"].textureSkeletonBloody = "Rat_Skeleton_Butchered";
AnimalDefinitions.animals["rat"].bodyModelSkelNoHead = "Rat_Skeleton_NoHead";
AnimalDefinitions.animals["rat"].animset = "rat";
AnimalDefinitions.animals["rat"].shadoww = 0.2;
AnimalDefinitions.animals["rat"].shadowfm = 0.2;
AnimalDefinitions.animals["rat"].shadowbm = 0.2;
AnimalDefinitions.animals["rat"].minSize = 0.7;
AnimalDefinitions.animals["rat"].maxSize = 1;
AnimalDefinitions.animals["rat"].breeds = AnimalDefinitions.breeds["rat"].breeds;
AnimalDefinitions.animals["rat"].stages = AnimalDefinitions.stages["rat"].stages;
AnimalDefinitions.animals["rat"].genes = AnimalDefinitions.genome["rat"].genes;
AnimalDefinitions.animals["rat"].mate = "ratfemale";
AnimalDefinitions.animals["rat"].male = true;
AnimalDefinitions.animals["rat"].hungerMultiplier = AnimalDefinitions.animals["ratfemale"].hungerMultiplier;
AnimalDefinitions.animals["rat"].thirstMultiplier = AnimalDefinitions.animals["ratfemale"].thirstMultiplier;
AnimalDefinitions.animals["rat"].minAge = AnimalDefinitions.stages["rat"].stages["ratbaby"].ageToGrow;
AnimalDefinitions.animals["rat"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["rat"].minAgeForBaby = AnimalDefinitions.animals["rat"].minAge;
AnimalDefinitions.animals["rat"].babyType = AnimalDefinitions.animals["ratfemale"].babyType;
AnimalDefinitions.animals["rat"].wanderMul = 400;
AnimalDefinitions.animals["rat"].alwaysFleeHumans = true;
AnimalDefinitions.animals["rat"].collidable = false;
AnimalDefinitions.animals["rat"].group = "rat";
AnimalDefinitions.animals["rat"].canBePet = true;
AnimalDefinitions.animals["rat"].canBePicked = true;
AnimalDefinitions.animals["rat"].canBeKilledWithoutWeapon = true;
AnimalDefinitions.animals["rat"].wild = true;
AnimalDefinitions.animals["rat"].idleTypeNbr = 2;
AnimalDefinitions.animals["rat"].canClimbStairs = true; -- most animals can't climb stairs, this is defaulted to false
AnimalDefinitions.animals["rat"].eatTypeTrough = "All";
AnimalDefinitions.animals["rat"].dontAttackOtherMale = true;
AnimalDefinitions.animals["rat"].trailerBaseSize = 10;
AnimalDefinitions.animals["rat"].minWeight = 0.4;
AnimalDefinitions.animals["rat"].maxWeight = 0.7;
AnimalDefinitions.animals["rat"].animalSize = 0;
AnimalDefinitions.animals["rat"].attackDist = 0;
AnimalDefinitions.animals["rat"].attackTimer = 1500;
AnimalDefinitions.animals["rat"].baseEncumbrance = 7;
AnimalDefinitions.animals["rat"].canThump = false;
AnimalDefinitions.animals["rat"].minEnclosureSize = 20;
AnimalDefinitions.animals["rat"].hungerBoost = 18;
AnimalDefinitions.animals["rat"].thirstBoost = 22;
AnimalDefinitions.animals["rat"].thirstHungerTrigger = 0.1;
AnimalDefinitions.animals["rat"].distToEat = 1;
AnimalDefinitions.animals["rat"].turnDelta = 0.95;
AnimalDefinitions.animals["rat"].addTrackingXp = false;
AnimalDefinitions.animals["rat"].corpseSize = AnimalDefinitions.animals["ratfemale"].corpseSize
AnimalDefinitions.animals["rat"].dung = "Dung_Rat";
AnimalDefinitions.animals["rat"].wildFleeTimeUntilDeadTimer = 100;

local rat_sounds = {
	pain = { name = "AnimalVoiceRatPain", slot = "voice", priority = 50 },
	death = { name = "AnimalVoiceRatDeath", slot = "voice", priority = 100 },
	runloop = { name = "AnimalFootstepsRatRun", slot = "runloop" },
	idle_walk = { name = "AnimalFootstepsRatWalk", slot = "voice" },
	idle = { name = "AnimalVoiceRatIdle", intervalMin = 10, intervalMax = 20, slot = "voice" },
	pick_up = { name = "PickUpAnimalRat", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadRat" },
	put_down = { name = "PutDownAnimalRat", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadRat" },
	stressed = { name = "AnimalVoiceRatStressed", intervalMin = 5, intervalMax = 15, slot = "voice" },
	scuttle_ceiling = { name = "AnimalRatScuttleCeiling", slot = "voice" },
	scuttle_cupboard = { name = "AnimalRatScuttleCupboard", slot = "voice" },
	scuttle_wall = { name = "AnimalRatScuttleWall", slot = "voice" },
}
AnimalDefinitions.animals["rat"].breeds["grey"].sounds = rat_sounds
AnimalDefinitions.animals["ratfemale"].breeds["grey"].sounds = rat_sounds
AnimalDefinitions.animals["ratbaby"].breeds["grey"].sounds = rat_sounds

AnimalDefinitions.animals["rat"].breeds["white"].sounds = rat_sounds
AnimalDefinitions.animals["ratfemale"].breeds["white"].sounds = rat_sounds
AnimalDefinitions.animals["ratbaby"].breeds["white"].sounds = rat_sounds

