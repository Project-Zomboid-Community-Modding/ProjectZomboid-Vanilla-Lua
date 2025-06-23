AnimalDefinitions = AnimalDefinitions or {};

-- stages
AnimalDefinitions.stages = AnimalDefinitions.stages or {};
AnimalDefinitions.stages["deer"] = {};
AnimalDefinitions.stages["deer"].stages = {};
AnimalDefinitions.stages["deer"].stages["fawn"] = {};
AnimalDefinitions.stages["deer"].stages["fawn"].ageToGrow = 2 * 30;
--AnimalDefinitions.stages["deer"].stages["fawn"].ageToGrow = 2;
AnimalDefinitions.stages["deer"].stages["fawn"].nextStage = "doe";
AnimalDefinitions.stages["deer"].stages["fawn"].nextStageMale = "buck";
AnimalDefinitions.stages["deer"].stages["doe"] = {};
AnimalDefinitions.stages["deer"].stages["doe"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["deer"].stages["buck"] = {};
AnimalDefinitions.stages["deer"].stages["buck"].ageToGrow = 2 * 30;

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {}; -- all the genes this animal will have
AnimalDefinitions.genome["deer"] = {};
AnimalDefinitions.genome["deer"].genes = {};
AnimalDefinitions.genome["deer"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["deer"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["deer"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["deer"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["deer"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["deer"].genes["strength"] = "strength";
AnimalDefinitions.genome["deer"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["deer"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["deer"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["deer"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["deer"].genes["fertility"] = "fertility"
AnimalDefinitions.genome["deer"].genes["stress"] = "stress";

-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["deer"] = {};
AnimalDefinitions.breeds["deer"].breeds = {};
AnimalDefinitions.breeds["deer"].breeds["whitetailed"] = {};
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].name = "whitetailed";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].texture = "DeerDoe";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].textureMale = "DeerStag";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].rottenTexture = "DeerStag_Rotting";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].textureBaby = "DeerFawn";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconMale = "Item_DeerMale_Dead";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconFemale = "Item_DeerFemale_Dead";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconBaby = "Item_DeerFawn_Dead";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconMaleDead = "Item_DeerMale_Dead";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconFemaleDead = "Item_DeerFemale_Dead";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconBabyDead = "Item_DeerFawn_Dead";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconMaleSkel = "Item_Skeleton_Deer_Stag";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconFemaleSkel = "Item_Skeleton_Deer_Doe";
AnimalDefinitions.breeds["deer"].breeds["whitetailed"].invIconBabySkel = "Item_Skeleton_Deer_Fawn";


-- animals
AnimalDefinitions.animals = AnimalDefinitions.animals or {};

AnimalDefinitions.animals["fawn"] = { };
AnimalDefinitions.animals["fawn"].bodyModel = "DeerFawn";
AnimalDefinitions.animals["fawn"].bodyModelSkel = "Deer_FawnSkeleton";
AnimalDefinitions.animals["fawn"].textureSkeleton = "DeerStag_Skeleton";
AnimalDefinitions.animals["fawn"].textureSkeletonBloody = "DeerStag_Skeleton_Butchered";
AnimalDefinitions.animals["fawn"].bodyModelSkelNoHead = "DeerFawn_Skeleton_NoHead";
AnimalDefinitions.animals["fawn"].animset = "fawn";
AnimalDefinitions.animals["fawn"].animalSize = 0.1;
AnimalDefinitions.animals["fawn"].modelscript = "DeerFawn";
AnimalDefinitions.animals["fawn"].shadoww = 0.4;
AnimalDefinitions.animals["fawn"].shadowfm = 1;
AnimalDefinitions.animals["fawn"].shadowbm = 1;
AnimalDefinitions.animals["fawn"].wanderMul = 300;
AnimalDefinitions.animals["fawn"].breeds = copyTable(AnimalDefinitions.breeds["deer"].breeds);
AnimalDefinitions.animals["fawn"].stages = AnimalDefinitions.stages["deer"].stages;
AnimalDefinitions.animals["fawn"].genes = AnimalDefinitions.genome["deer"].genes;
AnimalDefinitions.animals["fawn"].minSize = 0.85;
AnimalDefinitions.animals["fawn"].maxSize = 1.2;
AnimalDefinitions.animals["fawn"].sitRandomly = true;
AnimalDefinitions.animals["fawn"].idleTypeNbr = 3;
AnimalDefinitions.animals["fawn"].wild = true; -- wild animal will have some other behavior, they don't require to eat/drink and will always flee humans
AnimalDefinitions.animals["fawn"].spottingDist = 15; -- distance at which the animal will spot a human/zombie
AnimalDefinitions.animals["fawn"].group = "deer";
AnimalDefinitions.animals["fawn"].canBeAlerted = true;
AnimalDefinitions.animals["fawn"].canBeDomesticated = false;
AnimalDefinitions.animals["fawn"].canThump = false;
AnimalDefinitions.animals["fawn"].corpseSize = 5;
AnimalDefinitions.animals["fawn"].minBlood = 200;
AnimalDefinitions.animals["fawn"].maxBlood = 600;
AnimalDefinitions.animals["fawn"].trailerBaseSize = 100;
AnimalDefinitions.animals["fawn"].minWeight = 15;
AnimalDefinitions.animals["fawn"].maxWeight = 100;
AnimalDefinitions.animals["fawn"].wildFleeTimeUntilDeadTimer = 300; -- this will be used as a random timer to make the animal drop dead once you shot him, he'll flee and drop lots of blood before dropping dead, it's lowered by the aiming skill

AnimalDefinitions.animals["doe"] = {};
AnimalDefinitions.animals["doe"].bodyModel = "DeerDoe";
AnimalDefinitions.animals["doe"].bodyModelSkel = "Deer_DoeSkeleton";
AnimalDefinitions.animals["doe"].textureSkeleton = "DeerStag_Skeleton";
AnimalDefinitions.animals["doe"].textureSkeletonBloody = "DeerStag_Skeleton_Butchered";
AnimalDefinitions.animals["doe"].bodyModelSkelNoHead = "DeerDoe_Skeleton_NoHead";
AnimalDefinitions.animals["doe"].animset = "doe";
AnimalDefinitions.animals["doe"].modelscript = "DeerDoe";
AnimalDefinitions.animals["doe"].bodyModelHeadless = "DeerDoe_Headless";
AnimalDefinitions.animals["doe"].textureSkinned = "Deer_Skinned";
AnimalDefinitions.animals["doe"].shadoww = 0.7;
AnimalDefinitions.animals["doe"].shadowfm = 1.5;
AnimalDefinitions.animals["doe"].shadowbm = 1.5;
AnimalDefinitions.animals["doe"].minSize = 0.85;
AnimalDefinitions.animals["doe"].maxSize = 1.2;
AnimalDefinitions.animals["doe"].animalSize = 0.3;
AnimalDefinitions.animals["doe"].breeds = AnimalDefinitions.breeds["deer"].breeds;
AnimalDefinitions.animals["doe"].stages = AnimalDefinitions.stages["deer"].stages;
AnimalDefinitions.animals["doe"].genes = AnimalDefinitions.genome["deer"].genes;
AnimalDefinitions.animals["doe"].mate = "buck";
AnimalDefinitions.animals["doe"].minAge = AnimalDefinitions.stages["deer"].stages["fawn"].ageToGrow;
AnimalDefinitions.animals["doe"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["doe"].minAgeForBaby = 10;
AnimalDefinitions.animals["doe"].pregnantPeriod = 1;
AnimalDefinitions.animals["doe"].babyType = "fawn";
AnimalDefinitions.animals["doe"].wanderMul = 500;
AnimalDefinitions.animals["doe"].sitRandomly = true;
AnimalDefinitions.animals["doe"].idleTypeNbr = 3;
AnimalDefinitions.animals["doe"].wild = true;
AnimalDefinitions.animals["doe"].spottingDist = 19;
AnimalDefinitions.animals["doe"].group = "deer";
AnimalDefinitions.animals["doe"].canBeAlerted = true; -- can play the "alerted" animation before running away when spot a player
AnimalDefinitions.animals["doe"].canBeDomesticated = false;
AnimalDefinitions.animals["doe"].canThump = false;
AnimalDefinitions.animals["doe"].corpseSize = 5;
AnimalDefinitions.animals["doe"].minBlood = 800;
AnimalDefinitions.animals["doe"].maxBlood = 2500;
AnimalDefinitions.animals["doe"].female = true;
AnimalDefinitions.animals["doe"].trailerBaseSize = 300;
AnimalDefinitions.animals["doe"].minWeight = 110;
AnimalDefinitions.animals["doe"].maxWeight = 200;
AnimalDefinitions.animals["doe"].wildFleeTimeUntilDeadTimer = 700;

AnimalDefinitions.animals["buck"] = {};
AnimalDefinitions.animals["buck"].bodyModel = "DeerStag";
AnimalDefinitions.animals["buck"].bodyModelSkel = "Deer_StagSkeleton";
AnimalDefinitions.animals["buck"].textureSkeleton = "DeerStag_Skeleton";
AnimalDefinitions.animals["buck"].textureSkeletonBloody = "DeerStag_Skeleton_Butchered";
AnimalDefinitions.animals["buck"].bodyModelSkelNoHead = "DeerStag_Skeleton_NoHead";
AnimalDefinitions.animals["buck"].animset = "buck";
AnimalDefinitions.animals["buck"].modelscript = "DeerStag";
AnimalDefinitions.animals["buck"].bodyModelHeadless = "DeerStag_Headless";
AnimalDefinitions.animals["buck"].textureSkinned = "Deer_Skinned";
AnimalDefinitions.animals["buck"].shadoww = 0.7;
AnimalDefinitions.animals["buck"].shadowfm = 1.5;
AnimalDefinitions.animals["buck"].shadowbm = 1.5;
AnimalDefinitions.animals["buck"].minSize = 0.85;
AnimalDefinitions.animals["buck"].maxSize = 1.2;
AnimalDefinitions.animals["buck"].animalSize = 0.3;
AnimalDefinitions.animals["buck"].breeds = copyTable(AnimalDefinitions.breeds["deer"].breeds);
AnimalDefinitions.animals["buck"].stages = AnimalDefinitions.stages["deer"].stages;
AnimalDefinitions.animals["buck"].genes = AnimalDefinitions.genome["deer"].genes;
AnimalDefinitions.animals["buck"].mate = "doe";
AnimalDefinitions.animals["buck"].minAge = AnimalDefinitions.stages["deer"].stages["fawn"].ageToGrow;
AnimalDefinitions.animals["buck"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["buck"].minAgeForBaby = 10;
AnimalDefinitions.animals["buck"].babyType = AnimalDefinitions.animals["doe"].babyType;
AnimalDefinitions.animals["buck"].wanderMul = 500;
AnimalDefinitions.animals["buck"].sitRandomly = true;
AnimalDefinitions.animals["buck"].idleTypeNbr = 3;
AnimalDefinitions.animals["buck"].wild = true;
AnimalDefinitions.animals["buck"].spottingDist = AnimalDefinitions.animals["doe"].spottingDist;
AnimalDefinitions.animals["buck"].group = "deer";
AnimalDefinitions.animals["buck"].canBeAlerted = true;
AnimalDefinitions.animals["buck"].canBeDomesticated = false;
AnimalDefinitions.animals["buck"].canThump = false;
AnimalDefinitions.animals["buck"].corpseSize = AnimalDefinitions.animals["doe"].corpseSize;
AnimalDefinitions.animals["buck"].minBlood = 800;
AnimalDefinitions.animals["buck"].maxBlood = 2500;
AnimalDefinitions.animals["buck"].male = true;
AnimalDefinitions.animals["buck"].trailerBaseSize = 300;
AnimalDefinitions.animals["buck"].minWeight = 110;
AnimalDefinitions.animals["buck"].maxWeight = 200;
AnimalDefinitions.animals["buck"].wildFleeTimeUntilDeadTimer = 800;

local buck_sounds = {
	death = { name = "AnimalVoiceBuckDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyBuckBodyfall" },
	idle = { name = "AnimalVoiceBuckIdle", intervalMin = 10, intervalMax = 20, slot = "voice" },
	pain = { name = "AnimalVoiceBuckPain", slot = "voice", priority = 50 },
	pick_up = { name = "PickUpAnimalDeer", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadDeer" },
	put_down = { name = "PutDownAnimalDeer", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadDeer" },
	run = { name = "AnimalFootstepsBuckRun" },
	stressed = { name = "AnimalVoiceBuckStressed", intervalMin = 5, intervalMax = 10, slot = "voice" },
	walkBack = { name = "AnimalFootstepsBuckWalkBack" },
	walkFront = { name = "AnimalFootstepsBuckWalkFront" },
}
AnimalDefinitions.animals["buck"].breeds["whitetailed"].sounds = buck_sounds

local doe_sounds = {
	death = { name = "AnimalVoiceDoeDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyDoeBodyfall" },
	idle = { name = "AnimalVoiceDoeIdle", intervalMin = 10, intervalMax = 20, slot = "voice" },
	pain = { name = "AnimalVoiceDoePain", slot = "voice", priority = 50 },
	pick_up = { name = "PickUpAnimalDeer", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadDeer" },
	put_down = { name = "PutDownAnimalDeer", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadDeer" },
	run = { name = "AnimalFootstepsDoeRun" },
	stressed = { name = "AnimalVoiceDoeStressed", intervalMin = 5, intervalMax = 10, slot = "voice" },
	walkBack = { name = "AnimalFootstepsDoeWalkBack" },
	walkFront = { name = "AnimalFootstepsDoeWalkFront" },
}
AnimalDefinitions.animals["doe"].breeds["whitetailed"].sounds = doe_sounds

local fawn_sounds = {
	death = { name = "AnimalVoiceFawnDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyFawnBodyfall" },
	idle = { name = "AnimalVoiceFawnIdle", intervalMin = 6, intervalMax = 12, slot = "voice" },
	pain = { name = "AnimalVoiceFawnPain", slot = "voice", priority = 50 },
	pick_up = { name = "PickUpAnimalFawn", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadFawn" },
	put_down = { name = "PutDownAnimalFawn", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadFawn" },
	run = { name = "AnimalFootstepsFawnRun" },
	stressed = { name = "AnimalVoiceFawnStressed", intervalMin = 3, intervalMax = 8, slot = "voice" },
	walkBack = { name = "AnimalFootstepsFawnWalkBack" },
	walkFront = { name = "AnimalFootstepsFawnWalkFront" },
}
AnimalDefinitions.animals["fawn"].breeds["whitetailed"].sounds = fawn_sounds

