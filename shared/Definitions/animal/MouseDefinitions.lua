AnimalDefinitions = AnimalDefinitions or {};

-- stages
AnimalDefinitions.stages = AnimalDefinitions.stages or {};
AnimalDefinitions.stages["mouse"] = {};
AnimalDefinitions.stages["mouse"].stages = {};
AnimalDefinitions.stages["mouse"].stages["mousepups"] = {};
AnimalDefinitions.stages["mouse"].stages["mousepups"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["mouse"].stages["mousepups"].nextStage = "mousefemale";
AnimalDefinitions.stages["mouse"].stages["mousepups"].nextStageMale = "mouse";
AnimalDefinitions.stages["mouse"].stages["mouse"] = {};
AnimalDefinitions.stages["mouse"].stages["mouse"].ageToGrow = 2 * 30;
AnimalDefinitions.stages["mouse"].stages["mousefemale"] = {};
AnimalDefinitions.stages["mouse"].stages["mousefemale"].ageToGrow = 2 * 30;

-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["mouse"] = {};
AnimalDefinitions.breeds["mouse"].breeds = {};
AnimalDefinitions.breeds["mouse"].breeds["golden"] = {};
AnimalDefinitions.breeds["mouse"].breeds["golden"].name = "golden";
AnimalDefinitions.breeds["mouse"].breeds["golden"].texture = "Mouse_Golden";
AnimalDefinitions.breeds["mouse"].breeds["golden"].textureMale = "Mouse_Golden";
AnimalDefinitions.breeds["mouse"].breeds["golden"].rottenTexture = "mouse_rotting";
AnimalDefinitions.breeds["mouse"].breeds["golden"].forcedGenes = {};
AnimalDefinitions.breeds["mouse"].breeds["golden"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["mouse"].breeds["golden"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["mouse"].breeds["golden"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["mouse"].breeds["golden"].invIconMale = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["golden"].invIconFemale = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["golden"].invIconBaby = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["golden"].invIconMaleDead = "Item_MouseDead.png";
AnimalDefinitions.breeds["mouse"].breeds["golden"].invIconFemaleDead = "Item_MouseDead.png";
AnimalDefinitions.breeds["mouse"].breeds["golden"].invIconBabyDead = "Item_MouseDead.png";
AnimalDefinitions.breeds["mouse"].breeds["deer"] = {};
AnimalDefinitions.breeds["mouse"].breeds["deer"].name = "deer";
AnimalDefinitions.breeds["mouse"].breeds["deer"].texture = "Mouse_Deer";
AnimalDefinitions.breeds["mouse"].breeds["deer"].textureMale = "Mouse_Deer";
AnimalDefinitions.breeds["mouse"].breeds["deer"].rottenTexture = "mouse_rotting";
AnimalDefinitions.breeds["mouse"].breeds["deer"].forcedGenes = {};
AnimalDefinitions.breeds["mouse"].breeds["deer"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["mouse"].breeds["deer"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["mouse"].breeds["deer"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["mouse"].breeds["deer"].invIconMale = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["deer"].invIconFemale = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["deer"].invIconBaby = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["deer"].invIconMaleDead = "Item_MouseDead.png";
AnimalDefinitions.breeds["mouse"].breeds["deer"].invIconFemaleDead = "Item_MouseDead.png";
AnimalDefinitions.breeds["mouse"].breeds["deer"].invIconBabyDead = "Item_MouseDead.png";
AnimalDefinitions.breeds["mouse"].breeds["white"] = {};
AnimalDefinitions.breeds["mouse"].breeds["white"].name = "white";
AnimalDefinitions.breeds["mouse"].breeds["white"].texture = "Mouse_White";
AnimalDefinitions.breeds["mouse"].breeds["white"].textureMale = "Mouse_White";
AnimalDefinitions.breeds["mouse"].breeds["white"].rottenTexture = "mouseWhite_rotting";
AnimalDefinitions.breeds["mouse"].breeds["white"].forcedGenes = {};
AnimalDefinitions.breeds["mouse"].breeds["white"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["mouse"].breeds["white"].forcedGenes["maxMilk"].minValue = 0.75;
AnimalDefinitions.breeds["mouse"].breeds["white"].forcedGenes["maxMilk"].maxValue = 0.95;
AnimalDefinitions.breeds["mouse"].breeds["white"].invIconMale = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["white"].invIconFemale = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["white"].invIconBaby = "Item_Mouse";
AnimalDefinitions.breeds["mouse"].breeds["white"].invIconMaleDead = "Item_MouseDead.png";
AnimalDefinitions.breeds["mouse"].breeds["white"].invIconFemaleDead = "Item_MouseDead.png";
AnimalDefinitions.breeds["mouse"].breeds["white"].invIconBabyDead = "Item_MouseDead.png";

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {};
AnimalDefinitions.genome["mouse"] = {};
AnimalDefinitions.genome["mouse"].genes = {};
AnimalDefinitions.genome["mouse"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["mouse"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["mouse"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["mouse"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["mouse"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["mouse"].genes["strength"] = "strength";
AnimalDefinitions.genome["mouse"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["mouse"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["mouse"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["mouse"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["mouse"].genes["fertility"] = "fertility"
AnimalDefinitions.genome["mouse"].genes["stress"] = "stress";
AnimalDefinitions.genome["mouse"].genes["maxMilk"] = "maxMilk";
AnimalDefinitions.genome["mouse"].genes["milkInc"] = "milkInc";

-- animals
AnimalDefinitions.animals["mousepups"] = { };
AnimalDefinitions.animals["mousepups"].bodyModel = "Mouse_Body";
AnimalDefinitions.animals["mousepups"].bodyModelSkel = "Rat_Skeleton";
AnimalDefinitions.animals["mousepups"].textureSkeleton = "RatSkeleton";
AnimalDefinitions.animals["mousepups"].animset = "mouse";
AnimalDefinitions.animals["mousepups"].shadoww = 0.2;
AnimalDefinitions.animals["mousepups"].shadowfm = 0.2;
AnimalDefinitions.animals["mousepups"].shadowbm = 0.2;
AnimalDefinitions.animals["mousepups"].wanderMul = 150;
AnimalDefinitions.animals["mousepups"].breeds = copyTable(AnimalDefinitions.breeds["mouse"].breeds);
AnimalDefinitions.animals["mousepups"].stages = AnimalDefinitions.stages["mouse"].stages;
AnimalDefinitions.animals["mousepups"].genes = AnimalDefinitions.genome["mouse"].genes;
AnimalDefinitions.animals["mousepups"].minSize = 0.4
AnimalDefinitions.animals["mousepups"].maxSize = 0.7;
AnimalDefinitions.animals["mousepups"].hungerMultiplier = 0.00005;
AnimalDefinitions.animals["mousepups"].thirstMultiplier = 0.00009;
AnimalDefinitions.animals["mousepups"].alwaysFleeHumans = true;
AnimalDefinitions.animals["mousepups"].collidable = false;
AnimalDefinitions.animals["mousepups"].canBePicked = true;
AnimalDefinitions.animals["mousepups"].canBeKilledWithoutWeapon = true;
AnimalDefinitions.animals["mousepups"].canBePet = true;
AnimalDefinitions.animals["mousepups"].group = "mouse";
AnimalDefinitions.animals["mousepups"].wild = true;
AnimalDefinitions.animals["mousepups"].idleTypeNbr = 3;
AnimalDefinitions.animals["mousepups"].canClimbStairs = true;
AnimalDefinitions.animals["mousepups"].eatTypeTrough = "All";
AnimalDefinitions.animals["mousepups"].needMom = false;
AnimalDefinitions.animals["mousepups"].dontAttackOtherMale = true;
AnimalDefinitions.animals["mousepups"].trailerBaseSize = 10;
AnimalDefinitions.animals["mousepups"].minWeight = 0.02;
AnimalDefinitions.animals["mousepups"].maxWeight = 0.08;
AnimalDefinitions.animals["mousepups"].animalSize = 0;
AnimalDefinitions.animals["mousepups"].attackDist = 0;
AnimalDefinitions.animals["mousepups"].attackTimer = 4500;
AnimalDefinitions.animals["mousepups"].baseEncumbrance = 5;
AnimalDefinitions.animals["mousepups"].canThump = false;
AnimalDefinitions.animals["mousepups"].minEnclosureSize = 20;
AnimalDefinitions.animals["mousepups"].hungerBoost = 25;
AnimalDefinitions.animals["mousepups"].thirstBoost = 30;
AnimalDefinitions.animals["mousepups"].thirstHungerTrigger = 0.1;
AnimalDefinitions.animals["mousepups"].distToEat = 0.4;
AnimalDefinitions.animals["mousepups"].turnDelta = 0.95;
AnimalDefinitions.animals["mousepups"].eatFromMother = true;
AnimalDefinitions.animals["mousepups"].corpseSize = 0;
AnimalDefinitions.animals["mousepups"].dung = "Dung_Mouse";
AnimalDefinitions.animals["mousepups"].wildFleeTimeUntilDeadTimer = 50;


AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["mousefemale"] = {};
AnimalDefinitions.animals["mousefemale"].bodyModel = "Mouse_Body";
AnimalDefinitions.animals["mousefemale"].bodyModelSkel = "Rat_Skeleton";
AnimalDefinitions.animals["mousefemale"].textureSkeleton = "RatSkeleton";
AnimalDefinitions.animals["mousefemale"].animset = "mouse";
AnimalDefinitions.animals["mousefemale"].shadoww = 0.2;
AnimalDefinitions.animals["mousefemale"].shadowfm = 0.2;
AnimalDefinitions.animals["mousefemale"].shadowbm = 0.2;
AnimalDefinitions.animals["mousefemale"].minSize = 0.7;
AnimalDefinitions.animals["mousefemale"].maxSize = 1;
AnimalDefinitions.animals["mousefemale"].breeds = AnimalDefinitions.breeds["mouse"].breeds;
AnimalDefinitions.animals["mousefemale"].stages = AnimalDefinitions.stages["mouse"].stages;
AnimalDefinitions.animals["mousefemale"].genes = AnimalDefinitions.genome["mouse"].genes;
AnimalDefinitions.animals["mousefemale"].mate = "mouse";
AnimalDefinitions.animals["mousefemale"].minAge = AnimalDefinitions.stages["mouse"].stages["mousepups"].ageToGrow;
AnimalDefinitions.animals["mousefemale"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["mousefemale"].minAgeForBaby = AnimalDefinitions.animals["mousefemale"].minAge;
AnimalDefinitions.animals["mousefemale"].babyNbr = "5,9";
AnimalDefinitions.animals["mousefemale"].pregnantPeriod = 20;
AnimalDefinitions.animals["mousefemale"].hungerMultiplier = 0.00007;
AnimalDefinitions.animals["mousefemale"].thirstMultiplier = 0.00012;
AnimalDefinitions.animals["mousefemale"].babyType = "mousepups";
AnimalDefinitions.animals["mousefemale"].wanderMul = 300;
AnimalDefinitions.animals["mousefemale"].female = true;
AnimalDefinitions.animals["mousefemale"].alwaysFleeHumans = true;
AnimalDefinitions.animals["mousefemale"].collidable = false;
AnimalDefinitions.animals["mousefemale"].canBePicked = true;
AnimalDefinitions.animals["mousefemale"].canBeKilledWithoutWeapon = true;
AnimalDefinitions.animals["mousefemale"].canBePet = true;
AnimalDefinitions.animals["mousefemale"].group = "mouse";
AnimalDefinitions.animals["mousefemale"].wild = true;
AnimalDefinitions.animals["mousefemale"].idleTypeNbr = 3;
AnimalDefinitions.animals["mousefemale"].canClimbStairs = true;
AnimalDefinitions.animals["mousefemale"].eatTypeTrough = "All";
AnimalDefinitions.animals["mousefemale"].timeBeforeNextPregnancy = 5;
AnimalDefinitions.animals["mousefemale"].trailerBaseSize = 10;
AnimalDefinitions.animals["mousefemale"].minWeight = 0.05;
AnimalDefinitions.animals["mousefemale"].maxWeight = 0.1;
AnimalDefinitions.animals["mousefemale"].animalSize = 0;
AnimalDefinitions.animals["mousefemale"].attackDist = 0;
AnimalDefinitions.animals["mousefemale"].attackTimer = 1500;
AnimalDefinitions.animals["mousefemale"].baseEncumbrance = 7;
AnimalDefinitions.animals["mousefemale"].canThump = false;
AnimalDefinitions.animals["mousefemale"].minEnclosureSize = 20;
AnimalDefinitions.animals["mousefemale"].hungerBoost = 18;
AnimalDefinitions.animals["mousefemale"].thirstBoost = 22;
AnimalDefinitions.animals["mousefemale"].thirstHungerTrigger = 0.1;
AnimalDefinitions.animals["mousefemale"].distToEat = 0.4;
AnimalDefinitions.animals["mousefemale"].turnDelta = 0.95;
AnimalDefinitions.animals["mousefemale"].udder = true;
AnimalDefinitions.animals["mousefemale"].minMilk = 1;
AnimalDefinitions.animals["mousefemale"].maxMilk = 2;
AnimalDefinitions.animals["mousefemale"].corpseSize = 0;
AnimalDefinitions.animals["mousefemale"].dung = "Dung_Mouse";
AnimalDefinitions.animals["mousefemale"].wildFleeTimeUntilDeadTimer = 100;

AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["mouse"] = {};
AnimalDefinitions.animals["mouse"].bodyModel = "Mouse_Body";
AnimalDefinitions.animals["mouse"].bodyModelSkel = "Rat_Skeleton";
AnimalDefinitions.animals["mouse"].textureSkeleton = "RatSkeleton";
AnimalDefinitions.animals["mouse"].animset = "mouse";
AnimalDefinitions.animals["mouse"].shadoww = 0.2;
AnimalDefinitions.animals["mouse"].shadowfm = 0.2;
AnimalDefinitions.animals["mouse"].shadowbm = 0.2;
AnimalDefinitions.animals["mouse"].minSize = 0.7;
AnimalDefinitions.animals["mouse"].maxSize = 1;
AnimalDefinitions.animals["mouse"].breeds = AnimalDefinitions.breeds["mouse"].breeds;
AnimalDefinitions.animals["mouse"].stages = AnimalDefinitions.stages["mouse"].stages;
AnimalDefinitions.animals["mouse"].genes = AnimalDefinitions.genome["mouse"].genes;
AnimalDefinitions.animals["mouse"].mate = "mousefemale";
AnimalDefinitions.animals["mouse"].male = true;
AnimalDefinitions.animals["mouse"].minAge = AnimalDefinitions.stages["mouse"].stages["mousepups"].ageToGrow;
AnimalDefinitions.animals["mouse"].maxAgeGeriatric = 19 * 30;
AnimalDefinitions.animals["mouse"].minAgeForBaby = AnimalDefinitions.animals["mouse"].minAge;
AnimalDefinitions.animals["mouse"].pregnantPeriod = 20;
AnimalDefinitions.animals["mouse"].hungerMultiplier = AnimalDefinitions.animals["mousefemale"].hungerMultiplier;
AnimalDefinitions.animals["mouse"].thirstMultiplier = AnimalDefinitions.animals["mousefemale"].thirstMultiplier;
AnimalDefinitions.animals["mouse"].wanderMul = 300;
AnimalDefinitions.animals["mouse"].alwaysFleeHumans = true;
AnimalDefinitions.animals["mouse"].collidable = false;
AnimalDefinitions.animals["mouse"].canBePicked = true;
AnimalDefinitions.animals["mouse"].canBeKilledWithoutWeapon = true;
AnimalDefinitions.animals["mouse"].canBePet = true;
AnimalDefinitions.animals["mouse"].group = "mouse";
AnimalDefinitions.animals["mouse"].wild = true;
AnimalDefinitions.animals["mouse"].idleTypeNbr = 3;
AnimalDefinitions.animals["mouse"].canClimbStairs = true;
AnimalDefinitions.animals["mouse"].eatTypeTrough = "All";
AnimalDefinitions.animals["mouse"].dontAttackOtherMale = true;
AnimalDefinitions.animals["mouse"].trailerBaseSize = 10;
AnimalDefinitions.animals["mouse"].minWeight = 0.08;
AnimalDefinitions.animals["mouse"].maxWeight = 0.12;
AnimalDefinitions.animals["mouse"].animalSize = 0;
AnimalDefinitions.animals["mouse"].attackDist = 0;
AnimalDefinitions.animals["mouse"].attackTimer = 1500;
AnimalDefinitions.animals["mouse"].baseEncumbrance = 7;
AnimalDefinitions.animals["mouse"].canThump = false;
AnimalDefinitions.animals["mouse"].minEnclosureSize = 20;
AnimalDefinitions.animals["mouse"].hungerBoost = 18;
AnimalDefinitions.animals["mouse"].thirstBoost = 22;
AnimalDefinitions.animals["mouse"].thirstHungerTrigger = 0.1;
AnimalDefinitions.animals["mouse"].distToEat = 0.4;
AnimalDefinitions.animals["mouse"].turnDelta = 0.95;
AnimalDefinitions.animals["mouse"].corpseSize = 0;
AnimalDefinitions.animals["mouse"].dung = "Dung_Mouse";
AnimalDefinitions.animals["mouse"].wildFleeTimeUntilDeadTimer = 100;

local mouse_sounds = {
	idle = { name = "AnimalVoiceMouseIdle", slot = "voice", intervalMin = 10, intervalMax = 20 },
	pain = { name = "AnimalVoiceRatPain", slot = "voice", priority = 50 },
	death = { name = "AnimalVoiceMouseDeath", slot = "voice", priority = 100 },
	pick_up = { name = "PickUpAnimalMouse", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadMouse" },
	put_down = { name = "PutDownAnimalMouse", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadMouse" },
	runloop = { name = "AnimalFootstepsMouseRun", slot = "runloop" },
	stressed = { name = "AnimalVoiceRatStressed", intervalMin = 5, intervalMax = 10, slot = "voice" },
	walkloop = { name = "AnimalFootstepsMouseWalk", slot = "walkloop" },
}

AnimalDefinitions.animals["mouse"].breeds["golden"].sounds = mouse_sounds
AnimalDefinitions.animals["mouse"].breeds["deer"].sounds = mouse_sounds
AnimalDefinitions.animals["mouse"].breeds["white"].sounds = mouse_sounds

AnimalDefinitions.animals["mousepups"].breeds["golden"].sounds = mouse_sounds
AnimalDefinitions.animals["mousepups"].breeds["deer"].sounds = mouse_sounds
AnimalDefinitions.animals["mousepups"].breeds["white"].sounds = mouse_sounds

