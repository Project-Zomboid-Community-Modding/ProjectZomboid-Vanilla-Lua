
AnimalDefinitions = AnimalDefinitions or {};

-- stages
AnimalDefinitions.stages = AnimalDefinitions.stages or {};
AnimalDefinitions.stages["raccoon"] = {};
AnimalDefinitions.stages["raccoon"].stages = {};
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"] = {};
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].nextStage = "raccoonsow";
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].nextStageMale = "raccoonboar";
AnimalDefinitions.stages["raccoon"].stages["raccoonboar"] = {};
AnimalDefinitions.stages["raccoon"].stages["raccoonboar"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["raccoon"].stages["raccoonsow"] = {};
AnimalDefinitions.stages["raccoon"].stages["raccoonsow"].ageToGrow = 2 * 30;

-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["raccoon"] = {};
AnimalDefinitions.breeds["raccoon"].breeds = {};
AnimalDefinitions.breeds["raccoon"].breeds["grey"] = {};
AnimalDefinitions.breeds["raccoon"].breeds["grey"].name = "grey";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].texture = "Raccoon";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].textureMale = "Raccoon";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].rottenTexture = "Raccoon_Rotting";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconMale = "Item_Raccoon";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconFemale = "Item_Raccoon";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconBaby = "Item_Raccoon_Kit";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconMaleDead = "Item_Raccoon_Dead";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconFemaleDead = "Item_Raccoon_Dead";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconBabyDead = "Item_Raccoon_Kit_Dead";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconMaleSkel = "Item_Skeleton_Raccoon";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconFemaleSkel = "Item_Skeleton_Raccoon";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].invIconBabySkel = "Item_Skeleton_Raccoon";

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {};
AnimalDefinitions.genome["raccoon"] = {};
AnimalDefinitions.genome["raccoon"].genes = {};
AnimalDefinitions.genome["raccoon"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["raccoon"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["raccoon"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["raccoon"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["raccoon"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["raccoon"].genes["strength"] = "strength";
AnimalDefinitions.genome["raccoon"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["raccoon"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["raccoon"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["raccoon"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["raccoon"].genes["fertility"] = "fertility"
AnimalDefinitions.genome["raccoon"].genes["stress"] = "stress";

-- animals
AnimalDefinitions.animals["raccoonkit"] = { };
AnimalDefinitions.animals["raccoonkit"].bodyModel = "Raccoon_Body";
AnimalDefinitions.animals["raccoonkit"].bodyModelSkel = "Raccoon_Skeleton";
AnimalDefinitions.animals["raccoonkit"].textureSkeleton = "RaccoonSkeleton";
AnimalDefinitions.animals["raccoonkit"].textureSkeletonBloody = "RaccoonSkeleton_Butchered";
AnimalDefinitions.animals["raccoonkit"].bodyModelSkelNoHead = "Raccoon_Skeleton_NoHead";
AnimalDefinitions.animals["raccoonkit"].animset = "raccoon";
AnimalDefinitions.animals["raccoonkit"].shadoww = 0.2;
AnimalDefinitions.animals["raccoonkit"].shadowfm = 0.2;
AnimalDefinitions.animals["raccoonkit"].shadowbm = 0.2;
AnimalDefinitions.animals["raccoonkit"].wanderMul = 500;
AnimalDefinitions.animals["raccoonkit"].breeds = copyTable(AnimalDefinitions.breeds["raccoon"].breeds);
AnimalDefinitions.animals["raccoonkit"].stages = AnimalDefinitions.stages["raccoon"].stages;
AnimalDefinitions.animals["raccoonkit"].genes = AnimalDefinitions.genome["raccoon"].genes;
AnimalDefinitions.animals["raccoonkit"].minSize = 0.5
AnimalDefinitions.animals["raccoonkit"].maxSize = 0.9;
AnimalDefinitions.animals["raccoonkit"].hungerMultiplier = 0.001;
AnimalDefinitions.animals["raccoonkit"].thirstMultiplier = 0.002;
AnimalDefinitions.animals["raccoonkit"].hungerBoost = 25;
AnimalDefinitions.animals["raccoonkit"].thirstBoost = 30;
AnimalDefinitions.animals["raccoonkit"].thirstHungerTrigger = 0.1;
AnimalDefinitions.animals["raccoonkit"].distToEat = 1;
AnimalDefinitions.animals["raccoonkit"].alwaysFleeHumans = true;
AnimalDefinitions.animals["raccoonkit"].collidable = false;
AnimalDefinitions.animals["raccoonkit"].group = "raccoon";
AnimalDefinitions.animals["raccoonkit"].canBePicked = true;
AnimalDefinitions.animals["raccoonkit"].baseEncumbrance = 10;
AnimalDefinitions.animals["raccoonkit"].wild = true;
AnimalDefinitions.animals["raccoonkit"].idleTypeNbr = 2;
AnimalDefinitions.animals["raccoonkit"].canClimbStairs = true;
AnimalDefinitions.animals["raccoonkit"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits";
--AnimalDefinitions.animals["raccoonkit"].canClimbFences = true;
AnimalDefinitions.animals["raccoonkit"].needMom = false;
AnimalDefinitions.animals["raccoonkit"].canBePet = true;
--AnimalDefinitions.animals["raccoonkit"].canBeDomesticated = false; -- animal will never stop being "wild", can't breed them etc.
AnimalDefinitions.animals["raccoonkit"].trailerBaseSize = 30;
AnimalDefinitions.animals["raccoonkit"].turnDelta = 0.95;
AnimalDefinitions.animals["raccoonkit"].litterEatTogether = true;
AnimalDefinitions.animals["raccoonkit"].eatFromMother = true;
AnimalDefinitions.animals["raccoonkit"].addTrackingXp = false;
AnimalDefinitions.animals["raccoonkit"].corpseSize = 0;
AnimalDefinitions.animals["raccoonkit"].minWeight = 1;
AnimalDefinitions.animals["raccoonkit"].maxWeight = 8;
AnimalDefinitions.animals["raccoonkit"].minEnclosureSize = 40;
AnimalDefinitions.animals["raccoonkit"].dung = "Dung_Raccoon";
AnimalDefinitions.animals["raccoonkit"].wildFleeTimeUntilDeadTimer = 150;
AnimalDefinitions.animals["raccoonkit"].sitRandomly = true;


AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["raccoonsow"] = {};
AnimalDefinitions.animals["raccoonsow"].bodyModel = "Raccoon_Body";
AnimalDefinitions.animals["raccoonsow"].bodyModelSkel = "Raccoon_Skeleton";
AnimalDefinitions.animals["raccoonsow"].textureSkeleton = "RaccoonSkeleton";
AnimalDefinitions.animals["raccoonsow"].textureSkeletonBloody = "RaccoonSkeleton_Butchered";
AnimalDefinitions.animals["raccoonsow"].bodyModelSkelNoHead = "Raccoon_Skeleton_NoHead";
AnimalDefinitions.animals["raccoonsow"].animset = "raccoon";
AnimalDefinitions.animals["raccoonsow"].shadoww = 0.3;
AnimalDefinitions.animals["raccoonsow"].shadowfm = 0.5;
AnimalDefinitions.animals["raccoonsow"].shadowbm = 0.5;
AnimalDefinitions.animals["raccoonsow"].minSize = 0.9;
AnimalDefinitions.animals["raccoonsow"].maxSize = 1.2;
AnimalDefinitions.animals["raccoonsow"].breeds = AnimalDefinitions.breeds["raccoon"].breeds;
AnimalDefinitions.animals["raccoonsow"].stages = AnimalDefinitions.stages["raccoon"].stages;
AnimalDefinitions.animals["raccoonsow"].genes = AnimalDefinitions.genome["raccoon"].genes;
AnimalDefinitions.animals["raccoonsow"].mate = "raccoonboar";
AnimalDefinitions.animals["raccoonsow"].timeBeforeNextPregnancy = 7; -- in days
AnimalDefinitions.animals["raccoonsow"].female = true;
AnimalDefinitions.animals["raccoonsow"].hungerMultiplier = 0.009;
AnimalDefinitions.animals["raccoonsow"].thirstMultiplier = 0.01;
AnimalDefinitions.animals["raccoonsow"].hungerBoost = 20;
AnimalDefinitions.animals["raccoonsow"].thirstBoost = 25;
AnimalDefinitions.animals["raccoonsow"].thirstHungerTrigger = 0.1;
AnimalDefinitions.animals["raccoonsow"].distToEat = AnimalDefinitions.animals["raccoonkit"].distToEat;
AnimalDefinitions.animals["raccoonsow"].minAge = AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].ageToGrow;
AnimalDefinitions.animals["raccoonsow"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["raccoonsow"].minAgeForBaby = AnimalDefinitions.animals["raccoonsow"].minAge;
AnimalDefinitions.animals["raccoonsow"].pregnantPeriod = 35;
AnimalDefinitions.animals["raccoonsow"].babyType = "raccoonkit";
AnimalDefinitions.animals["raccoonsow"].wanderMul = 600;
AnimalDefinitions.animals["raccoonsow"].alwaysFleeHumans = true;
AnimalDefinitions.animals["raccoonsow"].collidable = false;
AnimalDefinitions.animals["raccoonsow"].group = "raccoon";
AnimalDefinitions.animals["raccoonsow"].canBePicked = true;
AnimalDefinitions.animals["raccoonsow"].baseEncumbrance = 20;
AnimalDefinitions.animals["raccoonsow"].wild = true;
AnimalDefinitions.animals["raccoonsow"].idleTypeNbr = 2;
AnimalDefinitions.animals["raccoonsow"].canClimbStairs = true; -- most animals can't climb stairs, this is defaulted to false
AnimalDefinitions.animals["raccoonsow"].eatTypeTrough = AnimalDefinitions.animals["raccoonkit"].eatTypeTrough;
AnimalDefinitions.animals["raccoonsow"].canBePet = true;
--AnimalDefinitions.animals["raccoonsow"].canClimbFences = true;
--AnimalDefinitions.animals["raccoonsow"].canBeDomesticated = false;
AnimalDefinitions.animals["raccoonsow"].trailerBaseSize = 50;
AnimalDefinitions.animals["raccoonsow"].turnDelta = 0.95;
AnimalDefinitions.animals["raccoonsow"].addTrackingXp = false;
AnimalDefinitions.animals["raccoonsow"].corpseSize = 0;
AnimalDefinitions.animals["raccoonsow"].minWeight = 9;
AnimalDefinitions.animals["raccoonsow"].maxWeight = 14;
AnimalDefinitions.animals["raccoonsow"].minEnclosureSize = AnimalDefinitions.animals["raccoonkit"].minEnclosureSize;
AnimalDefinitions.animals["raccoonsow"].dung = "Dung_Raccoon";
AnimalDefinitions.animals["raccoonsow"].wildFleeTimeUntilDeadTimer = 250;
AnimalDefinitions.animals["raccoonsow"].sitRandomly = AnimalDefinitions.animals["raccoonkit"].sitRandomly;


AnimalDefinitions.animals["raccoonboar"] = {};
AnimalDefinitions.animals["raccoonboar"].bodyModel = "Raccoon_Body";
AnimalDefinitions.animals["raccoonboar"].bodyModelSkel = "Raccoon_Skeleton";
AnimalDefinitions.animals["raccoonboar"].textureSkeleton = "RaccoonSkeleton";
AnimalDefinitions.animals["raccoonboar"].textureSkeletonBloody = "RaccoonSkeleton_Butchered";
AnimalDefinitions.animals["raccoonboar"].bodyModelSkelNoHead = "Raccoon_Skeleton_NoHead";
AnimalDefinitions.animals["raccoonboar"].animset = "raccoon";
AnimalDefinitions.animals["raccoonboar"].shadoww = 0.3;
AnimalDefinitions.animals["raccoonboar"].shadowfm = 0.5;
AnimalDefinitions.animals["raccoonboar"].shadowbm = 0.5;
AnimalDefinitions.animals["raccoonboar"].minSize = 0.9;
AnimalDefinitions.animals["raccoonboar"].maxSize = 1.2;
AnimalDefinitions.animals["raccoonboar"].breeds = AnimalDefinitions.breeds["raccoon"].breeds;
AnimalDefinitions.animals["raccoonboar"].stages = AnimalDefinitions.stages["raccoon"].stages;
AnimalDefinitions.animals["raccoonboar"].genes = AnimalDefinitions.genome["raccoon"].genes;
AnimalDefinitions.animals["raccoonboar"].mate = "raccoonsow";
AnimalDefinitions.animals["raccoonboar"].hungerMultiplier = AnimalDefinitions.animals["raccoonsow"].hungerMultiplier;
AnimalDefinitions.animals["raccoonboar"].thirstMultiplier = AnimalDefinitions.animals["raccoonsow"].thirstMultiplier;
AnimalDefinitions.animals["raccoonboar"].hungerBoost = AnimalDefinitions.animals["raccoonsow"].hungerBoost;
AnimalDefinitions.animals["raccoonboar"].thirstBoost = AnimalDefinitions.animals["raccoonsow"].thirstBoost;
AnimalDefinitions.animals["raccoonboar"].thirstHungerTrigger = AnimalDefinitions.animals["raccoonsow"].thirstHungerTrigger;
AnimalDefinitions.animals["raccoonboar"].distToEat = AnimalDefinitions.animals["raccoonkit"].distToEat;
AnimalDefinitions.animals["raccoonboar"].minAge = AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].ageToGrow;
AnimalDefinitions.animals["raccoonboar"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["raccoonboar"].minAgeForBaby = AnimalDefinitions.animals["raccoonboar"].minAge;
AnimalDefinitions.animals["raccoonboar"].babyType = AnimalDefinitions.animals["raccoonsow"].babyType;
AnimalDefinitions.animals["raccoonboar"].wanderMul = 600;
AnimalDefinitions.animals["raccoonboar"].alwaysFleeHumans = true;
AnimalDefinitions.animals["raccoonboar"].male = true;
AnimalDefinitions.animals["raccoonboar"].collidable = false;
AnimalDefinitions.animals["raccoonboar"].group = "raccoon";
AnimalDefinitions.animals["raccoonboar"].canBePicked = true;
AnimalDefinitions.animals["raccoonboar"].baseEncumbrance = AnimalDefinitions.animals["raccoonsow"].baseEncumbrance;
AnimalDefinitions.animals["raccoonboar"].wild = true;
AnimalDefinitions.animals["raccoonboar"].idleTypeNbr = 2;
AnimalDefinitions.animals["raccoonboar"].canClimbStairs = true; -- most animals can't climb stairs, this is defaulted to false
AnimalDefinitions.animals["raccoonboar"].eatTypeTrough = AnimalDefinitions.animals["raccoonkit"].eatTypeTrough;
AnimalDefinitions.animals["raccoonboar"].canBePet = true;
--AnimalDefinitions.animals["raccoonboar"].canClimbFences = true;
--AnimalDefinitions.animals["raccoonboar"].canBeDomesticated = false;
AnimalDefinitions.animals["raccoonboar"].trailerBaseSize = 50;
AnimalDefinitions.animals["raccoonboar"].turnDelta = 0.95;
AnimalDefinitions.animals["raccoonboar"].addTrackingXp = false;
AnimalDefinitions.animals["raccoonboar"].corpseSize = 0;
AnimalDefinitions.animals["raccoonboar"].minWeight = 10;
AnimalDefinitions.animals["raccoonboar"].maxWeight = 15;
AnimalDefinitions.animals["raccoonboar"].minEnclosureSize = AnimalDefinitions.animals["raccoonkit"].minEnclosureSize;
AnimalDefinitions.animals["raccoonboar"].dung = "Dung_Raccoon";
AnimalDefinitions.animals["raccoonboar"].wildFleeTimeUntilDeadTimer = 250;
AnimalDefinitions.animals["raccoonboar"].sitRandomly = AnimalDefinitions.animals["raccoonkit"].sitRandomly;

local raccoon_kit_sounds = {
	death = { name = "AnimalVoiceBabyRaccoonDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyBabyRaccoonBodyfall" },
	idle = { name = "AnimalVoiceBabyRaccoonIdle", intervalMin = 10, intervalMax = 20, slot = "voice" },
	pain = { name = "AnimalVoiceBabyRaccoonPain", slot = "voice", priority = 50 },
	pick_up = { name = "PickUpAnimalBabyRaccoon", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadBabyRaccoon" },
	put_down = { name = "PutDownAnimalBabyRacoon", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadBabyRaccoon" },
	runloop = { name = "AnimalFootstepsBabyRaccoonRun", slot = "runloop" },
	stressed = { name = "AnimalVoiceBabyRaccoonStressed", intervalMin = 5, intervalMax = 10, slot = "voice" },
	walkBack = { name = "AnimalFootstepsBabyRaccoonWalkBack" },
	walkFront = { name = "AnimalFootstepsBabyRaccoonWalkFront" },
}

local raccoon_sounds = {
	death = { name = "AnimalVoiceRaccoonDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyRaccoonBodyfall" },
	idle = { name = "AnimalVoiceRaccoonIdle", intervalMin = 10, intervalMax = 20, slot = "voice" },
	pain = { name = "AnimalVoiceRaccoonPain", slot = "voice", priority = 50 },
	pick_up = { name = "PickUpAnimalRaccoon", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadRaccoon" },
	put_down = { name = "PutDownAnimalRaccoon", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadRaccoon" },
	runloop = { name = "AnimalFootstepsRaccoonRun", slot = "runloop" },
	stressed = { name = "AnimalVoiceRaccoonStressed", intervalMin = 5, intervalMax = 10, slot = "voice" },
	walkBack = { name = "AnimalFootstepsRaccoonWalkBack" },
	walkFront = { name = "AnimalFootstepsRaccoonWalkFront" },
}

AnimalDefinitions.animals["raccoonboar"].breeds["grey"].sounds = raccoon_sounds
AnimalDefinitions.animals["raccoonsow"].breeds["grey"].sounds = raccoon_sounds
AnimalDefinitions.animals["raccoonkit"].breeds["grey"].sounds = raccoon_kit_sounds

