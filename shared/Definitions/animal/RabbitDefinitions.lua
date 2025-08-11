AnimalDefinitions = AnimalDefinitions or {};

-- stages
AnimalDefinitions.stages = AnimalDefinitions.stages or {};
AnimalDefinitions.stages["rabbit"] = {};
AnimalDefinitions.stages["rabbit"].stages = {};
AnimalDefinitions.stages["rabbit"].stages["rabkitten"] = {};
AnimalDefinitions.stages["rabbit"].stages["rabkitten"].ageToGrow = 4 * 30;
AnimalDefinitions.stages["rabbit"].stages["rabkitten"].nextStage = "rabdoe";
AnimalDefinitions.stages["rabbit"].stages["rabkitten"].nextStageMale = "rabbuck";
AnimalDefinitions.stages["rabbit"].stages["rabkitten"].minWeight = 0.1;
AnimalDefinitions.stages["rabbit"].stages["rabkitten"].maxWeight = 0.25;
AnimalDefinitions.stages["rabbit"].stages["rabdoe"] = {};
AnimalDefinitions.stages["rabbit"].stages["rabdoe"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["rabbit"].stages["rabdoe"].minWeight = 0.25;
AnimalDefinitions.stages["rabbit"].stages["rabdoe"].maxWeight = 0.5;
AnimalDefinitions.stages["rabbit"].stages["rabbuck"] = {};
AnimalDefinitions.stages["rabbit"].stages["rabbuck"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["rabbit"].stages["rabbuck"].minWeight = 0.25;
AnimalDefinitions.stages["rabbit"].stages["rabbuck"].maxWeight = 0.5;

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {}; -- all the genes this animal will have
AnimalDefinitions.genome["rabbit"] = {};
AnimalDefinitions.genome["rabbit"].genes = {};
AnimalDefinitions.genome["rabbit"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["rabbit"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["rabbit"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["rabbit"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["rabbit"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["rabbit"].genes["strength"] = "strength";
AnimalDefinitions.genome["rabbit"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["rabbit"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["rabbit"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["rabbit"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["rabbit"].genes["fertility"] = "fertility"
AnimalDefinitions.genome["rabbit"].genes["maxMilk"] = "maxMilk";
AnimalDefinitions.genome["rabbit"].genes["milkInc"] = "milkInc";
AnimalDefinitions.genome["rabbit"].genes["stress"] = "stress";

-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["rabbit"] = {};
AnimalDefinitions.breeds["rabbit"].breeds = {};
AnimalDefinitions.breeds["rabbit"].breeds["swamp"] = {};
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].name = "swamp";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].texture = "Rabbit_Swamp";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].textureMale = "Rabbit_Swamp";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].rottenTexture = "Rabbit_Rotting";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].textureBaby = "Rabbit_Kitten_Swamp";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].forcedGenes = {};
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].forcedGenes["maxMilk"] = {}; -- we gonna ensure the rabbit have enough milk to feed lots of babies
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconMale = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconFemale = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconBaby = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconMaleDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconFemaleDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconBabyDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconMaleSkel = "Item_Skeleton_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconFemaleSkel = "Item_Skeleton_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["swamp"].invIconBabySkel = "Item_Skeleton_Rabbit_Kit";

AnimalDefinitions.breeds["rabbit"].breeds["appalachian"] = {};
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].name = "appalachian";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].texture = "Rabbit_Appalachian";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].textureMale = "Rabbit_Appalachian";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].rottenTexture = "Rabbit_Rotting";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].textureBaby = "Rabbit_Kitten_Appalachian";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].forcedGenes = {};
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].forcedGenes["maxMilk"] = {}; -- we gonna ensure the rabbit have enough milk to feed lots of babies
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconMale = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconFemale = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconBaby = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconMaleDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconFemaleDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconBabyDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconMaleSkel = "Item_Skeleton_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconFemaleSkel = "Item_Skeleton_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["appalachian"].invIconBabySkel = "Item_Skeleton_Rabbit_Kit";

AnimalDefinitions.breeds["rabbit"].breeds["cottontail"] = {};
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].name = "swamp";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].texture = "Rabbit_Cottontail";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].textureMale = "Rabbit_Cottontail";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].rottenTexture = "Rabbit_Rotting";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].textureBaby = "Rabbit_Kitten_Cottontail";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].forcedGenes = {};
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].forcedGenes["maxMilk"] = {}; -- we gonna ensure the rabbit have enough milk to feed lots of babies
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconMale = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconFemale = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconBaby = "Item_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconMaleDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconFemaleDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconBabyDead = "Item_RabbitDead";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconMaleSkel = "Item_Skeleton_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconFemaleSkel = "Item_Skeleton_Rabbit";
AnimalDefinitions.breeds["rabbit"].breeds["cottontail"].invIconBabySkel = "Item_Skeleton_Rabbit_Kit";




-- animals
AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["rabkitten"] = { };
AnimalDefinitions.animals["rabkitten"].bodyModel = "RabKitten_Body";
AnimalDefinitions.animals["rabkitten"].bodyModelSkel = "Rabbit_KittenSkeleton";
AnimalDefinitions.animals["rabkitten"].textureSkeleton = "RabbitSkeleton";
AnimalDefinitions.animals["rabkitten"].textureSkeletonBloody = "RabbitSkeleton_Butchered";
AnimalDefinitions.animals["rabkitten"].bodyModelSkelNoHead = "Rabbit_KittenSkeleton_NoHead";
AnimalDefinitions.animals["rabkitten"].animset = "rabkitten";
AnimalDefinitions.animals["rabkitten"].modelscript = "RabKit";
AnimalDefinitions.animals["rabkitten"].shadoww = 0.1;
AnimalDefinitions.animals["rabkitten"].shadowfm = 0.2;
AnimalDefinitions.animals["rabkitten"].shadowbm = 0.2;
AnimalDefinitions.animals["rabkitten"].wanderMul = 300;
AnimalDefinitions.animals["rabkitten"].breeds = copyTable(AnimalDefinitions.breeds["rabbit"].breeds);
AnimalDefinitions.animals["rabkitten"].stages = AnimalDefinitions.stages["rabbit"].stages;
AnimalDefinitions.animals["rabkitten"].genes = AnimalDefinitions.genome["rabbit"].genes;
AnimalDefinitions.animals["rabkitten"].minSize = 1;
AnimalDefinitions.animals["rabkitten"].maxSize = 1.2;
AnimalDefinitions.animals["rabkitten"].sitRandomly = false;
AnimalDefinitions.animals["rabkitten"].idleTypeNbr = 6;
AnimalDefinitions.animals["rabkitten"].wild = true;
AnimalDefinitions.animals["rabkitten"].spottingDist = 9;
AnimalDefinitions.animals["rabkitten"].hungerMultiplier = 0.0001;
AnimalDefinitions.animals["rabkitten"].thirstMultiplier = 0.0002;
--AnimalDefinitions.animals["rabkitten"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits";
AnimalDefinitions.animals["rabkitten"].periodicRun = true;
AnimalDefinitions.animals["rabkitten"].eatFromMother = true;
AnimalDefinitions.animals["rabkitten"].trailerBaseSize = 50;
AnimalDefinitions.animals["rabkitten"].healthLossMultiplier = 0.2;
AnimalDefinitions.animals["rabkitten"].hungerBoost = 22;
AnimalDefinitions.animals["rabkitten"].thirstBoost = 30;
AnimalDefinitions.animals["rabkitten"].idleEmoteChance = 500;
AnimalDefinitions.animals["rabkitten"].collisionSize = 0;
AnimalDefinitions.animals["rabkitten"].baseEncumbrance = 10;
AnimalDefinitions.animals["rabkitten"].canBePet = true;
AnimalDefinitions.animals["rabkitten"].canBeKilledWithoutWeapon = true;
AnimalDefinitions.animals["rabkitten"].collidable = false;
AnimalDefinitions.animals["rabkitten"].minWeight = 1;
AnimalDefinitions.animals["rabkitten"].maxWeight = 2;
AnimalDefinitions.animals["rabkitten"].canThump = false;
AnimalDefinitions.animals["rabkitten"].luredPossibleItems = {{name="Base.HayTuft", chance=30},{name="Base.GrassTuft", chance=50},{name="Base.Carrots", chance=70}};
AnimalDefinitions.animals["rabkitten"].group = "rabbit";
AnimalDefinitions.animals["rabkitten"].stressAboveGround = true;
AnimalDefinitions.animals["rabkitten"].litterEatTogether = true;
AnimalDefinitions.animals["rabkitten"].thirstHungerTrigger = 0.2;
AnimalDefinitions.animals["rabkitten"].wildFleeTimeUntilDeadTimer = 100;

AnimalDefinitions.animals["rabdoe"] = {};
AnimalDefinitions.animals["rabdoe"].bodyModel = "Rab_Body";
AnimalDefinitions.animals["rabdoe"].bodyModelSkel = "Rabbit_Skeleton";
AnimalDefinitions.animals["rabdoe"].textureSkeleton = "RabbitSkeleton";
AnimalDefinitions.animals["rabdoe"].textureSkeletonBloody = "RabbitSkeleton_Butchered";
AnimalDefinitions.animals["rabdoe"].bodyModelSkelNoHead = "Rabbit_Skeleton_NoHead";
AnimalDefinitions.animals["rabdoe"].animset = "rabbit";
AnimalDefinitions.animals["rabdoe"].modelscript = "RabDoe";
AnimalDefinitions.animals["rabdoe"].shadoww = 0.2;
AnimalDefinitions.animals["rabdoe"].shadowfm = 0.3;
AnimalDefinitions.animals["rabdoe"].shadowbm = 0.3;
AnimalDefinitions.animals["rabdoe"].minSize = 1;
AnimalDefinitions.animals["rabdoe"].maxSize = 1.2;
AnimalDefinitions.animals["rabdoe"].breeds = AnimalDefinitions.breeds["rabbit"].breeds;
AnimalDefinitions.animals["rabdoe"].stages = AnimalDefinitions.stages["rabbit"].stages;
AnimalDefinitions.animals["rabdoe"].genes = AnimalDefinitions.genome["rabbit"].genes;
AnimalDefinitions.animals["rabdoe"].mate = "rabbuck";
AnimalDefinitions.animals["rabdoe"].minAge = AnimalDefinitions.stages["rabbit"].stages["rabkitten"].ageToGrow;
AnimalDefinitions.animals["rabdoe"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["rabdoe"].minAgeForBaby = 6 * 30; -- 6 months
AnimalDefinitions.animals["rabdoe"].pregnantPeriod = 43;
AnimalDefinitions.animals["rabdoe"].timeBeforeNextPregnancy = 20; -- in days
AnimalDefinitions.animals["rabdoe"].female = true;
AnimalDefinitions.animals["rabdoe"].babyNbr = "3,7";
AnimalDefinitions.animals["rabdoe"].babyType = "rabkitten";
AnimalDefinitions.animals["rabdoe"].wanderMul = 500;
AnimalDefinitions.animals["rabdoe"].eatGrass = true;
AnimalDefinitions.animals["rabdoe"].sitRandomly = true;
AnimalDefinitions.animals["rabdoe"].idleTypeNbr = 6;
AnimalDefinitions.animals["rabdoe"].wild = true;
AnimalDefinitions.animals["rabdoe"].udder = 20;
AnimalDefinitions.animals["rabdoe"].minMilk = 20;
AnimalDefinitions.animals["rabdoe"].maxMilk = 40;
AnimalDefinitions.animals["rabdoe"].spottingDist = 14;
AnimalDefinitions.animals["rabdoe"].hungerMultiplier = 0.0005;
AnimalDefinitions.animals["rabdoe"].thirstMultiplier = 0.001;
AnimalDefinitions.animals["rabdoe"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits";
AnimalDefinitions.animals["rabdoe"].collisionSize = 0.24;
AnimalDefinitions.animals["rabdoe"].baseEncumbrance = 20;
AnimalDefinitions.animals["rabdoe"].canBePet = true;
AnimalDefinitions.animals["rabdoe"].canBeKilledWithoutWeapon = true;
AnimalDefinitions.animals["rabdoe"].collidable = false;
AnimalDefinitions.animals["rabdoe"].minWeight = 2;
AnimalDefinitions.animals["rabdoe"].maxWeight = 7;
AnimalDefinitions.animals["rabdoe"].canThump = false;
AnimalDefinitions.animals["rabdoe"].luredPossibleItems = AnimalDefinitions.animals["rabkitten"].luredPossibleItems;
AnimalDefinitions.animals["rabdoe"].trailerBaseSize = 90;
AnimalDefinitions.animals["rabdoe"].group = "rabbit";
AnimalDefinitions.animals["rabdoe"].stressAboveGround = true;
AnimalDefinitions.animals["rabdoe"].hungerBoost = 16;
AnimalDefinitions.animals["rabdoe"].thirstBoost = 20;
AnimalDefinitions.animals["rabdoe"].wildFleeTimeUntilDeadTimer = 300;

AnimalDefinitions.animals["rabbuck"] = {};
AnimalDefinitions.animals["rabbuck"].bodyModel = "Rab_Body";
AnimalDefinitions.animals["rabbuck"].bodyModelSkel = "Rabbit_Skeleton";
AnimalDefinitions.animals["rabbuck"].textureSkeleton = "RabbitSkeleton";
AnimalDefinitions.animals["rabbuck"].textureSkeletonBloody = "RabbitSkeleton_Butchered";
AnimalDefinitions.animals["rabbuck"].bodyModelSkelNoHead = "Rabbit_Skeleton_NoHead";
AnimalDefinitions.animals["rabbuck"].animset = "rabbit";
AnimalDefinitions.animals["rabbuck"].modelscript = "RabBuck";
AnimalDefinitions.animals["rabbuck"].shadoww = 0.2;
AnimalDefinitions.animals["rabbuck"].shadowfm = 0.3;
AnimalDefinitions.animals["rabbuck"].shadowbm = 0.3;
AnimalDefinitions.animals["rabbuck"].minSize = 1;
AnimalDefinitions.animals["rabbuck"].maxSize = 1.2;
AnimalDefinitions.animals["rabbuck"].breeds = copyTable(AnimalDefinitions.breeds["rabbit"].breeds);
AnimalDefinitions.animals["rabbuck"].stages = AnimalDefinitions.stages["rabbit"].stages;
AnimalDefinitions.animals["rabbuck"].genes = AnimalDefinitions.genome["rabbit"].genes;
AnimalDefinitions.animals["rabbuck"].mate = "rabdoe";
AnimalDefinitions.animals["rabbuck"].minAge = AnimalDefinitions.stages["rabbit"].stages["rabkitten"].ageToGrow;
AnimalDefinitions.animals["rabbuck"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["rabbuck"].minAgeForBaby = AnimalDefinitions.animals["rabdoe"].minAgeForBaby;
AnimalDefinitions.animals["rabbuck"].babyType = AnimalDefinitions.animals["rabdoe"].babyType;
AnimalDefinitions.animals["rabbuck"].wanderMul = 500;
AnimalDefinitions.animals["rabbuck"].sitRandomly = true;
AnimalDefinitions.animals["rabbuck"].male = true;
AnimalDefinitions.animals["rabbuck"].idleTypeNbr = 6;
AnimalDefinitions.animals["rabbuck"].wild = true;
AnimalDefinitions.animals["rabbuck"].eatGrass = true;
AnimalDefinitions.animals["rabbuck"].dontAttackOtherMale = true;
AnimalDefinitions.animals["rabbuck"].spottingDist = AnimalDefinitions.animals["rabdoe"].spottingDist;
AnimalDefinitions.animals["rabbuck"].hungerMultiplier = AnimalDefinitions.animals["rabdoe"].hungerMultiplier;
AnimalDefinitions.animals["rabbuck"].thirstMultiplier = AnimalDefinitions.animals["rabdoe"].thirstMultiplier;
AnimalDefinitions.animals["rabbuck"].trailerBaseSize = AnimalDefinitions.animals["rabdoe"].trailerBaseSize;
AnimalDefinitions.animals["rabbuck"].collisionSize = AnimalDefinitions.animals["rabdoe"].collisionSize;
AnimalDefinitions.animals["rabbuck"].baseEncumbrance = AnimalDefinitions.animals["rabdoe"].baseEncumbrance; -- base weight when holding the animal inside inventory, will be multiplied by animal's size
AnimalDefinitions.animals["rabbuck"].canBePet = AnimalDefinitions.animals["rabdoe"].canBePet;
AnimalDefinitions.animals["rabbuck"].canBeKilledWithoutWeapon = AnimalDefinitions.animals["rabdoe"].canBeKilledWithoutWeapon;
AnimalDefinitions.animals["rabbuck"].collidable = AnimalDefinitions.animals["rabdoe"].collidable; -- don't collide wiht chick or chicken
AnimalDefinitions.animals["rabbuck"].minWeight = AnimalDefinitions.animals["rabdoe"].minWeight;
AnimalDefinitions.animals["rabbuck"].maxWeight = AnimalDefinitions.animals["rabdoe"].maxWeight;
AnimalDefinitions.animals["rabbuck"].canThump = AnimalDefinitions.animals["rabdoe"].canThump;
AnimalDefinitions.animals["rabbuck"].eatTypeTrough = AnimalDefinitions.animals["rabdoe"].eatTypeTrough;
AnimalDefinitions.animals["rabbuck"].luredPossibleItems = AnimalDefinitions.animals["rabdoe"].luredPossibleItems;
AnimalDefinitions.animals["rabbuck"].group = "rabbit";
AnimalDefinitions.animals["rabbuck"].stressAboveGround = true;
AnimalDefinitions.animals["rabbuck"].hungerBoost = 16;
AnimalDefinitions.animals["rabbuck"].thirstBoost = 20;
AnimalDefinitions.animals["rabbuck"].wildFleeTimeUntilDeadTimer = 300;

local rabbit_sounds = {
	death = { name = "AnimalVoiceRabbitDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyRabbitBodyfall" },
	idle = { name = "AnimalVoiceRabbitIdle", intervalMin = 20, intervalMax = 40, slot = "voice" },
	pain = { name = "AnimalVoiceRabbitPain", slot = "voice", priority = 50 },
	pick_up = { name = "PickUpAnimalRabbit", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadRabbit" },
	put_down = { name = "PutDownAnimalRabbit", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadRabbit" },
	runloop = { name = "AnimalFootstepsRabbitRun", slot = "runloop" },
	stressed = { name = "AnimalVoiceRabbitStressed", intervalMin = 10, intervalMax = 20, slot = "voice" },
	walkloop = { name = "AnimalFootstepsRabbitWalk", slot = "walkloop" },
}

AnimalDefinitions.animals["rabbuck"].breeds["appalachian"].sounds = rabbit_sounds
AnimalDefinitions.animals["rabbuck"].breeds["cottontail"].sounds = rabbit_sounds
AnimalDefinitions.animals["rabbuck"].breeds["swamp"].sounds = rabbit_sounds

AnimalDefinitions.animals["rabdoe"].breeds["appalachian"].sounds = rabbit_sounds
AnimalDefinitions.animals["rabdoe"].breeds["cottontail"].sounds = rabbit_sounds
AnimalDefinitions.animals["rabdoe"].breeds["swamp"].sounds = rabbit_sounds

local rabkitten_sounds = {
	death = { name = "AnimalVoiceBabyRabbitDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyBabyRabbitBodyfall" },
	idle = { name = "AnimalVoiceRabbitIdle", intervalMin = 20, intervalMax = 35, slot = "voice" },
	pain = { name = "AnimalVoiceBabyRabbitPain", slot = "voice", priority = 50 },
	pick_up = { name = "PickUpAnimalBabyRabbit", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadBabyRabbit" },
	put_down = { name = "PutDownAnimalBabyRabbit", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadBabyRabbit" },
	runloop = { name = "AnimalFootstepsBabyRabbitRun", slot = "runloop" },
	stressed = { name = "AnimalVoiceBabyRabbitStressed", intervalMin = 10, intervalMax = 20, slot = "voice" },
	walkloop = { name = "AnimalFootstepsBabyRabbitWalk", slot = "walkloop" },
}


AnimalDefinitions.animals["rabkitten"].breeds["appalachian"].sounds = rabkitten_sounds
AnimalDefinitions.animals["rabkitten"].breeds["cottontail"].sounds = rabkitten_sounds
AnimalDefinitions.animals["rabkitten"].breeds["swamp"].sounds = rabkitten_sounds

