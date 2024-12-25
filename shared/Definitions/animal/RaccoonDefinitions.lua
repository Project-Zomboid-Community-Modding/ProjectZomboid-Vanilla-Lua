
AnimalDefinitions = AnimalDefinitions or {};

-- stages
AnimalDefinitions.stages = AnimalDefinitions.stages or {};
AnimalDefinitions.stages["raccoon"] = {};
AnimalDefinitions.stages["raccoon"].stages = {};
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"] = {};
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].nextStage = "raccoonsow";
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].nextStageMale = "raccoonboar";
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].minWeight = 0.1;
AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].maxWeight = 0.25;
AnimalDefinitions.stages["raccoon"].stages["raccoonboar"] = {};
AnimalDefinitions.stages["raccoon"].stages["raccoonboar"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["raccoon"].stages["raccoonboar"].minWeight = 0.25;
AnimalDefinitions.stages["raccoon"].stages["raccoonboar"].maxWeight = 0.5;
AnimalDefinitions.stages["raccoon"].stages["raccoonsow"] = {};
AnimalDefinitions.stages["raccoon"].stages["raccoonsow"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["raccoon"].stages["raccoonsow"].minWeight = 0.25;
AnimalDefinitions.stages["raccoon"].stages["raccoonsow"].maxWeight = 0.5;

-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["raccoon"] = {};
AnimalDefinitions.breeds["raccoon"].breeds = {};
AnimalDefinitions.breeds["raccoon"].breeds["grey"] = {};
AnimalDefinitions.breeds["raccoon"].breeds["grey"].name = "grey";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].texture = "Raccoon";
AnimalDefinitions.breeds["raccoon"].breeds["grey"].textureMale = "Raccoon";

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
AnimalDefinitions.animals["raccoonkit"].animset = "raccoon";
AnimalDefinitions.animals["raccoonkit"].shadoww = 0.2;
AnimalDefinitions.animals["raccoonkit"].shadowfm = 0.2;
AnimalDefinitions.animals["raccoonkit"].shadowbm = 0.2;
AnimalDefinitions.animals["raccoonkit"].wanderMul = 30000;
AnimalDefinitions.animals["raccoonkit"].breeds = copyTable(AnimalDefinitions.breeds["raccoon"].breeds);
AnimalDefinitions.animals["raccoonkit"].stages = AnimalDefinitions.stages["raccoon"].stages;
AnimalDefinitions.animals["raccoonkit"].genes = AnimalDefinitions.genome["raccoon"].genes;
AnimalDefinitions.animals["raccoonkit"].minSize = 0.4
AnimalDefinitions.animals["raccoonkit"].maxSize = 0.7;
AnimalDefinitions.animals["raccoonkit"].hungerMultiplier = 0.0005;
AnimalDefinitions.animals["raccoonkit"].thirstMultiplier = 0.00003;
AnimalDefinitions.animals["raccoonkit"].alwaysFleeHumans = true;
AnimalDefinitions.animals["raccoonkit"].collidable = false;
AnimalDefinitions.animals["raccoonkit"].group = "raccoon";
AnimalDefinitions.animals["raccoonkit"].canBePicked = true;
AnimalDefinitions.animals["raccoonkit"].wild = true;
AnimalDefinitions.animals["raccoonkit"].idleTypeNbr = 2;
AnimalDefinitions.animals["raccoonkit"].canClimbStairs = true;
AnimalDefinitions.animals["raccoonkit"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits";
AnimalDefinitions.animals["raccoonkit"].canClimbFences = true;
AnimalDefinitions.animals["raccoonkit"].needMom = false;
AnimalDefinitions.animals["raccoonkit"].canBeDomesticated = false; -- animal will never stop being "wild", can't breed them etc.


AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["raccoonsow"] = {};
AnimalDefinitions.animals["raccoonsow"].bodyModel = "Raccoon_Body";
AnimalDefinitions.animals["raccoonsow"].bodyModelSkel = "Raccoon_Skeleton";
AnimalDefinitions.animals["raccoonsow"].textureSkeleton = "RaccoonSkeleton";
AnimalDefinitions.animals["raccoonsow"].animset = "raccoon";
AnimalDefinitions.animals["raccoonsow"].shadoww = 0.2;
AnimalDefinitions.animals["raccoonsow"].shadowfm = 0.2;
AnimalDefinitions.animals["raccoonsow"].shadowbm = 0.2;
AnimalDefinitions.animals["raccoonsow"].minSize = 0.7;
AnimalDefinitions.animals["raccoonsow"].maxSize = 1;
AnimalDefinitions.animals["raccoonsow"].breeds = AnimalDefinitions.breeds["raccoon"].breeds;
AnimalDefinitions.animals["raccoonsow"].stages = AnimalDefinitions.stages["raccoon"].stages;
AnimalDefinitions.animals["raccoonsow"].genes = AnimalDefinitions.genome["raccoon"].genes;
AnimalDefinitions.animals["raccoonsow"].mate = "raccoonboar";
AnimalDefinitions.animals["raccoonsow"].female = true;
AnimalDefinitions.animals["raccoonsow"].hungerMultiplier = 0.001;
AnimalDefinitions.animals["raccoonsow"].thirstMultiplier = 0.0005;
AnimalDefinitions.animals["raccoonsow"].minAge = AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].ageToGrow;
AnimalDefinitions.animals["raccoonsow"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["raccoonsow"].minAgeForBaby = AnimalDefinitions.animals["raccoonsow"].minAge;
AnimalDefinitions.animals["raccoonsow"].pregnantPeriod = 20;
AnimalDefinitions.animals["raccoonsow"].babyType = "raccoonkit";
AnimalDefinitions.animals["raccoonsow"].wanderMul = 50000;
AnimalDefinitions.animals["raccoonsow"].alwaysFleeHumans = true;
AnimalDefinitions.animals["raccoonsow"].collidable = false;
AnimalDefinitions.animals["raccoonsow"].group = "raccoon";
AnimalDefinitions.animals["raccoonsow"].canBePicked = true;
AnimalDefinitions.animals["raccoonsow"].wild = true;
AnimalDefinitions.animals["raccoonsow"].idleTypeNbr = 2;
AnimalDefinitions.animals["raccoonsow"].canClimbStairs = true; -- most animals can't climb stairs, this is defaulted to false
AnimalDefinitions.animals["raccoonsow"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits";
AnimalDefinitions.animals["raccoonsow"].canClimbFences = true;
AnimalDefinitions.animals["raccoonsow"].canBeDomesticated = false;


AnimalDefinitions.animals["raccoonboar"] = {};
AnimalDefinitions.animals["raccoonboar"].bodyModel = "Raccoon_Body";
AnimalDefinitions.animals["raccoonboar"].bodyModelSkel = "Raccoon_Skeleton";
AnimalDefinitions.animals["raccoonboar"].textureSkeleton = "RaccoonSkeleton";
AnimalDefinitions.animals["raccoonboar"].animset = "raccoon";
AnimalDefinitions.animals["raccoonboar"].shadoww = 0.2;
AnimalDefinitions.animals["raccoonboar"].shadowfm = 0.2;
AnimalDefinitions.animals["raccoonboar"].shadowbm = 0.2;
AnimalDefinitions.animals["raccoonboar"].minSize = 0.7;
AnimalDefinitions.animals["raccoonboar"].maxSize = 1;
AnimalDefinitions.animals["raccoonboar"].breeds = AnimalDefinitions.breeds["raccoon"].breeds;
AnimalDefinitions.animals["raccoonboar"].stages = AnimalDefinitions.stages["raccoon"].stages;
AnimalDefinitions.animals["raccoonboar"].genes = AnimalDefinitions.genome["raccoon"].genes;
AnimalDefinitions.animals["raccoonboar"].mate = "raccoonsow";
AnimalDefinitions.animals["raccoonboar"].hungerMultiplier = 0.001;
AnimalDefinitions.animals["raccoonboar"].thirstMultiplier = 0.0005;
AnimalDefinitions.animals["raccoonboar"].minAge = AnimalDefinitions.stages["raccoon"].stages["raccoonkit"].ageToGrow;
AnimalDefinitions.animals["raccoonboar"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["raccoonboar"].minAgeForBaby = AnimalDefinitions.animals["raccoonboar"].minAge;
AnimalDefinitions.animals["raccoonboar"].babyType = AnimalDefinitions.animals["raccoonsow"].babyType;
AnimalDefinitions.animals["raccoonboar"].wanderMul = 50000;
AnimalDefinitions.animals["raccoonboar"].alwaysFleeHumans = true;
AnimalDefinitions.animals["raccoonboar"].collidable = false;
AnimalDefinitions.animals["raccoonboar"].group = "raccoon";
AnimalDefinitions.animals["raccoonboar"].canBePicked = true;
AnimalDefinitions.animals["raccoonboar"].wild = true;
AnimalDefinitions.animals["raccoonboar"].idleTypeNbr = 2;
AnimalDefinitions.animals["raccoonboar"].canClimbStairs = true; -- most animals can't climb stairs, this is defaulted to false
AnimalDefinitions.animals["raccoonboar"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits";
AnimalDefinitions.animals["raccoonboar"].canClimbFences = true;
AnimalDefinitions.animals["raccoonboar"].canBeDomesticated = false;

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

