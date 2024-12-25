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
AnimalDefinitions.stages["sheep"] = {};
AnimalDefinitions.stages["sheep"].stages = {};
AnimalDefinitions.stages["sheep"].stages["lamb"] = {};
AnimalDefinitions.stages["sheep"].stages["lamb"].ageToGrow = 6 * 30; -- 6 months
AnimalDefinitions.stages["sheep"].stages["lamb"].nextStage = "ewe";
AnimalDefinitions.stages["sheep"].stages["lamb"].nextStageMale = "ram";

AnimalDefinitions.stages["sheep"].stages["ewe"] = {};
AnimalDefinitions.stages["sheep"].stages["ewe"].ageToGrow = 12 * 30;
AnimalDefinitions.stages["sheep"].stages["ewe"].minWeight = 250;
AnimalDefinitions.stages["sheep"].stages["ewe"].maxWeight = 700;

AnimalDefinitions.stages["sheep"].stages["ram"] = {}
AnimalDefinitions.stages["sheep"].stages["ram"].ageToGrow = 12 * 30;
AnimalDefinitions.stages["sheep"].stages["ram"].minWeight = 300;
AnimalDefinitions.stages["sheep"].stages["ram"].maxWeight = 800;


-- breeds
AnimalDefinitions.breeds = AnimalDefinitions.breeds or {};
AnimalDefinitions.breeds["sheep"] = {};
AnimalDefinitions.breeds["sheep"].breeds = {};

AnimalDefinitions.breeds["sheep"].breeds["suffolk"] = {}; -- meat sheep
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].name = "suffolk";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].texture = "Sheep";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].textureMale = "Sheep";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].milkType = "SheepMilk";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].woolType = "Base.WoolRaw";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].invIconMale = "Item_SheepSuffolk_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].invIconFemale = "Item_SheepSuffolk_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].invIconBaby = "Item_SheepSuffolk_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].invIconMaleDead = "Item_SheepSuffolk_Dead";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].invIconFemaleDead = "Item_SheepSuffolk_Dead";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].invIconBabyDead = "Item_SheepSuffolk_Lamb_Dead";
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes = {};
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxMilk"].minValue = 0.05;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxMilk"].maxValue = 0.2;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["meatRatio"] = {};
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["meatRatio"].minValue = 0.75;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["meatRatio"].maxValue = 0.95;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxWeight"] = {};
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxWeight"].minValue = 0.55;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxWeight"].maxValue = 0.75;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["woolInc"] = {};
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["woolInc"].minValue = 0.2;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["woolInc"].maxValue = 0.5;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxWool"] = {};
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxWool"].minValue = 0.2;
AnimalDefinitions.breeds["sheep"].breeds["suffolk"].forcedGenes["maxWool"].maxValue = 0.5;

AnimalDefinitions.breeds["sheep"].breeds["rambouillet"] = {}; -- wool sheep
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].name = "rambouillet";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].texture = "Sheep_White";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].textureMale = "Sheep_White";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].milkType = "SheepMilk";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].woolType = "Base.WoolRaw";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].invIconMale = "Item_SheepWhite_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].invIconFemale = "Item_SheepWhite_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].invIconBaby = "Item_SheepWhite_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].invIconMaleDead = "Item_SheepWhite_Dead";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].invIconFemaleDead = "Item_SheepWhite_Dead";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].invIconBabyDead = "Item_SheepWhite_Lamb_Dead";
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes = {};
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["maxMilk"].minValue = 0.05;
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["maxMilk"].maxValue = 0.2;
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["meatRatio"] = {};
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["meatRatio"].minValue = 0.3;
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["meatRatio"].maxValue = 0.6;
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["woolInc"] = {};
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["woolInc"].minValue = 0.6;
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["woolInc"].maxValue = 0.85;
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["maxWool"] = {};
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["maxWool"].minValue = 0.7;
AnimalDefinitions.breeds["sheep"].breeds["rambouillet"].forcedGenes["maxWool"].maxValue = 0.85;

AnimalDefinitions.breeds["sheep"].breeds["friesian"] = {}; -- dairy sheep
AnimalDefinitions.breeds["sheep"].breeds["friesian"].name = "friesian";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].texture = "Sheep_White";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].textureMale = "Sheep_White";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].milkType = "SheepMilk";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].woolType = "Base.WoolRaw";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].invIconMale = "Item_SheepWhite_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].invIconFemale = "Item_SheepWhite_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].invIconBaby = "Item_SheepWhite_Lamb";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].invIconMaleDead = "Item_SheepWhite_Dead";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].invIconFemaleDead = "Item_SheepWhite_Dead";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].invIconBabyDead = "Item_SheepWhite_Lamb_Dead";
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes = {};
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["maxMilk"] = {};
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["maxMilk"].minValue = 0.65;
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["maxMilk"].maxValue = 0.85;
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["meatRatio"] = {};
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["meatRatio"].minValue = 0.3;
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["meatRatio"].maxValue = 0.6;
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["woolInc"] = {};
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["woolInc"].minValue = 0.2;
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["woolInc"].maxValue = 0.5;
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["maxWool"] = {};
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["maxWool"].minValue = 0.2;
AnimalDefinitions.breeds["sheep"].breeds["friesian"].forcedGenes["maxWool"].maxValue = 0.5;

-- genome
AnimalDefinitions.genome = AnimalDefinitions.genome or {};
AnimalDefinitions.genome["sheep"] = {};
AnimalDefinitions.genome["sheep"].genes = {};
AnimalDefinitions.genome["sheep"].genes["maxSize"] = "maxSize";
AnimalDefinitions.genome["sheep"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["sheep"].genes["maxWeight"] = "maxWeight";
AnimalDefinitions.genome["sheep"].genes["lifeExpectancy"] = "lifeExpectancy";
AnimalDefinitions.genome["sheep"].genes["maxMilk"] = "maxMilk";
AnimalDefinitions.genome["sheep"].genes["meatRatio"] = "meatRatio";
AnimalDefinitions.genome["sheep"].genes["milkInc"] = "milkInc";
AnimalDefinitions.genome["sheep"].genes["resistance"] = "resistance";
AnimalDefinitions.genome["sheep"].genes["strength"] = "strength";
AnimalDefinitions.genome["sheep"].genes["hungerResistance"] = "hungerResistance";
AnimalDefinitions.genome["sheep"].genes["thirstResistance"] = "thirstResistance";
AnimalDefinitions.genome["sheep"].genes["aggressiveness"] = "aggressiveness";
AnimalDefinitions.genome["sheep"].genes["ageToGrow"] = "ageToGrow";
AnimalDefinitions.genome["sheep"].genes["fertility"] = "fertility"
AnimalDefinitions.genome["sheep"].genes["maxWool"] = "maxWool";
AnimalDefinitions.genome["sheep"].genes["woolInc"] = "woolInc";
AnimalDefinitions.genome["sheep"].genes["stress"] = "stress";

-- animals
AnimalDefinitions.animals = AnimalDefinitions.animals or {};
AnimalDefinitions.animals["lamb"] = {};
AnimalDefinitions.animals["lamb"].bodyModel = "Sheep_Lamb";
AnimalDefinitions.animals["lamb"].bodyModelSkel = "Sheep_LambSkeleton";
AnimalDefinitions.animals["lamb"].textureSkeleton = "SheepSkeleton";
AnimalDefinitions.animals["lamb"].animset = "lamb";
AnimalDefinitions.animals["lamb"].modelscript = "Sheep_Lamb";
AnimalDefinitions.animals["lamb"].shadoww = 0.3;
AnimalDefinitions.animals["lamb"].shadowfm = 0.8;
AnimalDefinitions.animals["lamb"].shadowbm = 0.8;
AnimalDefinitions.animals["lamb"].turnDelta = 0.95;
AnimalDefinitions.animals["lamb"].animalSize = 0.15;
AnimalDefinitions.animals["lamb"].minSize = 1;
AnimalDefinitions.animals["lamb"].maxSize = 1.5;
AnimalDefinitions.animals["lamb"].sitRandomly = true;
AnimalDefinitions.animals["lamb"].stages = AnimalDefinitions.stages["sheep"].stages;
AnimalDefinitions.animals["lamb"].breeds = copyTable(AnimalDefinitions.breeds["sheep"].breeds);
AnimalDefinitions.animals["lamb"].genes = AnimalDefinitions.genome["sheep"].genes;
AnimalDefinitions.animals["lamb"].alwaysFleeHumans = false;
AnimalDefinitions.animals["lamb"].canBeAttached = true;
AnimalDefinitions.animals["lamb"].minEnclosureSize = 20;
AnimalDefinitions.animals["lamb"].wanderMul = 300;
AnimalDefinitions.animals["lamb"].hungerMultiplier = 0.0005;
AnimalDefinitions.animals["lamb"].thirstMultiplier = 0.001;
AnimalDefinitions.animals["lamb"].idleTypeNbr = 5;
AnimalDefinitions.animals["lamb"].eatingTypeNbr = 1;
AnimalDefinitions.animals["lamb"].eatFromMother = true;
AnimalDefinitions.animals["lamb"].periodicRun = true;
AnimalDefinitions.animals["lamb"].healthLossMultiplier = 0.05;
AnimalDefinitions.animals["lamb"].idleEmoteChance = 500;
AnimalDefinitions.animals["lamb"].attackDist = 2;
AnimalDefinitions.animals["lamb"].attackTimer = 4000;
AnimalDefinitions.animals["lamb"].canBeFeedByHand = true;
AnimalDefinitions.animals["lamb"].feedByHandType = "SheepMilk"; -- the animal will also accept the lured possible items, but this one is only milk type
AnimalDefinitions.animals["lamb"].canBePicked = true;
AnimalDefinitions.animals["lamb"].baseEncumbrance = 30;
AnimalDefinitions.animals["lamb"].luredPossibleItems = {{name="Base.HayTuft", chance=30},{name="Base.GrassTuft", chance=50}};
AnimalDefinitions.animals["lamb"].trailerBaseSize = 60;
AnimalDefinitions.animals["lamb"].canBePet = true;
AnimalDefinitions.animals["lamb"].collisionSize = 0.24;
AnimalDefinitions.animals["lamb"].collidable = false;
AnimalDefinitions.animals["lamb"].minWeight = 20;
AnimalDefinitions.animals["lamb"].maxWeight = 70;
AnimalDefinitions.animals["lamb"].canThump = false;
AnimalDefinitions.animals["lamb"].group = "sheep";
AnimalDefinitions.animals["lamb"].dung = "Dung_Sheep";
AnimalDefinitions.animals["lamb"].happyAnim = 1; -- if there's an animation to show the animal is happy
AnimalDefinitions.animals["lamb"].ropeBone = "Bip01_Neck";
AnimalDefinitions.animals["lamb"].stressAboveGround = true;
AnimalDefinitions.animals["lamb"].stressUnderRain = true;
AnimalDefinitions.animals["lamb"].hungerBoost = 5;
AnimalDefinitions.animals["lamb"].thirstBoost = 7;
AnimalDefinitions.animals["lamb"].distToEat = 1;
AnimalDefinitions.animals["lamb"].minBlood = 200;
AnimalDefinitions.animals["lamb"].maxBlood = 600;
AnimalDefinitions.animals["lamb"].idleSoundRadius = 20;
AnimalDefinitions.animals["lamb"].idleSoundVolume = 10;


AnimalDefinitions.animals["ewe"] = {};
AnimalDefinitions.animals["ewe"].bodyModel = "Sheep_EweSheared";
AnimalDefinitions.animals["ewe"].bodyModelSkel = "Sheep_EweSkeleton";
AnimalDefinitions.animals["ewe"].textureSkeleton = "SheepSkeleton";
AnimalDefinitions.animals["ewe"].bodyModelFleece = "Sheep_EweFleece";
AnimalDefinitions.animals["ewe"].animset = "ewe";
AnimalDefinitions.animals["ewe"].modelscript = "Sheep_EweFleece";
AnimalDefinitions.animals["ewe"].bodyModelHeadless = "Sheep_EweSheared_Headless";
AnimalDefinitions.animals["ewe"].textureSkinned = "Sheep_Skinned";
AnimalDefinitions.animals["ewe"].shadoww = 0.5;
AnimalDefinitions.animals["ewe"].shadowfm = 1.5;
AnimalDefinitions.animals["ewe"].shadowbm = 1.5;
AnimalDefinitions.animals["ewe"].turnDelta = 0.9;
AnimalDefinitions.animals["ewe"].animalSize = 0.1;
AnimalDefinitions.animals["ewe"].minSize = 1;
AnimalDefinitions.animals["ewe"].maxSize = 1.3;
AnimalDefinitions.animals["ewe"].minAge = AnimalDefinitions.stages["sheep"].stages["lamb"].ageToGrow;
AnimalDefinitions.animals["ewe"].babyType = "lamb";
AnimalDefinitions.animals["ewe"].idleEmoteChance = 600;
AnimalDefinitions.animals["ewe"].sitRandomly = true;
AnimalDefinitions.animals["ewe"].minAgeForBaby = 7 * 30; -- 7 months
AnimalDefinitions.animals["ewe"].maxAgeGeriatric = 10 * 12 * 30; -- 10 years
AnimalDefinitions.animals["ewe"].udder = true;
AnimalDefinitions.animals["ewe"].female = true;
AnimalDefinitions.animals["ewe"].stages = AnimalDefinitions.stages["sheep"].stages;
AnimalDefinitions.animals["ewe"].breeds = AnimalDefinitions.breeds["sheep"].breeds;
AnimalDefinitions.animals["ewe"].genes = AnimalDefinitions.genome["sheep"].genes;
AnimalDefinitions.animals["ewe"].alwaysFleeHumans = false;
AnimalDefinitions.animals["ewe"].eatingTypeNbr = 1;
AnimalDefinitions.animals["ewe"].canBeAttached = true;
AnimalDefinitions.animals["ewe"].wanderMul = 1000;
AnimalDefinitions.animals["ewe"].minEnclosureSize = 40;
AnimalDefinitions.animals["ewe"].hungerMultiplier = 0.002;
AnimalDefinitions.animals["ewe"].thirstMultiplier = 0.004;
AnimalDefinitions.animals["ewe"].idleTypeNbr = 5;
AnimalDefinitions.animals["ewe"].eatGrass = true;
AnimalDefinitions.animals["ewe"].pregnantPeriod = 147;
AnimalDefinitions.animals["ewe"].baseEncumbrance = 80;
AnimalDefinitions.animals["ewe"].healthLossMultiplier = 0.01;
AnimalDefinitions.animals["ewe"].eatTypeTrough = "AnimalFeed,Grass,Hay,Vegetables,Fruits";
AnimalDefinitions.animals["ewe"].canBeMilked = true;
AnimalDefinitions.animals["ewe"].minMilk = 5;
AnimalDefinitions.animals["ewe"].maxMilk = 20;
AnimalDefinitions.animals["ewe"].attackDist = 2;
AnimalDefinitions.animals["ewe"].attackTimer = 6000;
AnimalDefinitions.animals["ewe"].maxWool = 20;
AnimalDefinitions.animals["ewe"].luredPossibleItems = AnimalDefinitions.animals["lamb"].luredPossibleItems;
AnimalDefinitions.animals["ewe"].milkAnimPreset = "Sheep";
AnimalDefinitions.animals["ewe"].trailerBaseSize = 100;
AnimalDefinitions.animals["ewe"].canBePet = true;
AnimalDefinitions.animals["ewe"].collisionSize = 0.32;
AnimalDefinitions.animals["ewe"].matingPeriodStart = 9; -- the month (here September) at which the mating season start, if 0 there's no mating season (can always reproduce)
AnimalDefinitions.animals["ewe"].matingPeriodEnd = 2; -- the month (here February) at which the mating season end
AnimalDefinitions.animals["ewe"].timeBeforeNextPregnancy = 3 * 4 * 7; -- in days, here 3 months
AnimalDefinitions.animals["ewe"].thirstHungerTrigger = 0.2;
AnimalDefinitions.animals["ewe"].minWeight = 60;
AnimalDefinitions.animals["ewe"].maxWeight = 120;
AnimalDefinitions.animals["ewe"].group = "sheep";
AnimalDefinitions.animals["ewe"].dung = "Dung_Sheep";
AnimalDefinitions.animals["ewe"].ropeBone = "Bip01_Neck";
AnimalDefinitions.animals["ewe"].stressAboveGround = true;
AnimalDefinitions.animals["ewe"].stressUnderRain = true;
AnimalDefinitions.animals["ewe"].corpseSize = 3.5;
AnimalDefinitions.animals["ewe"].minBlood = 800;
AnimalDefinitions.animals["ewe"].maxBlood = 2500;
AnimalDefinitions.animals["ewe"].idleSoundRadius = 40;
AnimalDefinitions.animals["ewe"].idleSoundVolume = 20;
AnimalDefinitions.animals["ewe"].hungerBoost = 3;
AnimalDefinitions.animals["ewe"].thirstBoost = 5;

AnimalDefinitions.animals["ram"] = {};
AnimalDefinitions.animals["ram"].bodyModel = "Sheep_RamSheared";
AnimalDefinitions.animals["ram"].bodyModelSkel = "Sheep_RamSkeleton";
AnimalDefinitions.animals["ram"].textureSkeleton = "SheepSkeleton";
AnimalDefinitions.animals["ram"].bodyModelFleece = "Sheep_RamFleece";
AnimalDefinitions.animals["ram"].animset = "ram";
AnimalDefinitions.animals["ram"].modelscript = "Sheep_RamFleece";
AnimalDefinitions.animals["ram"].bodyModelHeadless = "Sheep_RamSheared_Headless";
AnimalDefinitions.animals["ram"].textureSkinned = "Sheep_Skinned";
AnimalDefinitions.animals["ram"].shadoww = 0.5;
AnimalDefinitions.animals["ram"].shadowfm = 1.5;
AnimalDefinitions.animals["ram"].shadowbm = 1.5;
AnimalDefinitions.animals["ram"].eatingTypeNbr = AnimalDefinitions.animals["ewe"].eatingTypeNbr;
AnimalDefinitions.animals["ram"].sitRandomly = AnimalDefinitions.animals["ewe"].sitRandomly;
AnimalDefinitions.animals["ram"].eatGrass = AnimalDefinitions.animals["ewe"].eatGrass;
AnimalDefinitions.animals["ram"].turnDelta = AnimalDefinitions.animals["ewe"].turnDelta;
AnimalDefinitions.animals["ram"].animalSize = AnimalDefinitions.animals["ewe"].animalSize;
AnimalDefinitions.animals["ram"].minSize = AnimalDefinitions.animals["ewe"].minSize;
AnimalDefinitions.animals["ram"].maxSize = AnimalDefinitions.animals["ewe"].maxSize;
AnimalDefinitions.animals["ram"].minAge = AnimalDefinitions.animals["ewe"].minAge;
AnimalDefinitions.animals["ram"].maxAgeGeriatric = AnimalDefinitions.animals["ewe"].maxAgeGeriatric;
AnimalDefinitions.animals["ram"].idleEmoteChance = AnimalDefinitions.animals["ewe"].idleEmoteChance;
AnimalDefinitions.animals["ram"].male = true;
AnimalDefinitions.animals["ram"].minAgeForBaby = 6 * 30;
AnimalDefinitions.animals["ram"].babyType = AnimalDefinitions.animals["ewe"].babyType;
AnimalDefinitions.animals["ram"].mate = "ewe";
AnimalDefinitions.animals["ram"].matingPeriodStart = 9;
AnimalDefinitions.animals["ram"].matingPeriodEnd = 2;
AnimalDefinitions.animals["ram"].stages = AnimalDefinitions.stages["sheep"].stages;
AnimalDefinitions.animals["ram"].breeds = copyTable(AnimalDefinitions.breeds["sheep"].breeds);
AnimalDefinitions.animals["ram"].genes = AnimalDefinitions.genome["sheep"].genes;
AnimalDefinitions.animals["ram"].alwaysFleeHumans = AnimalDefinitions.animals["ewe"].alwaysFleeHumans;
AnimalDefinitions.animals["ram"].canBeAttached = AnimalDefinitions.animals["ewe"].canBeAttached;
AnimalDefinitions.animals["ram"].wanderMul = AnimalDefinitions.animals["ewe"].wanderMul;
AnimalDefinitions.animals["ram"].hungerMultiplier = AnimalDefinitions.animals["ewe"].hungerMultiplier;
AnimalDefinitions.animals["ram"].thirstMultiplier = AnimalDefinitions.animals["ewe"].thirstMultiplier;
AnimalDefinitions.animals["ram"].idleTypeNbr = 4;
AnimalDefinitions.animals["ram"].healthLossMultiplier = AnimalDefinitions.animals["ewe"].healthLossMultiplier;
AnimalDefinitions.animals["ram"].sittingPeriod = AnimalDefinitions.animals["ewe"].sittingPeriod;
AnimalDefinitions.animals["ram"].eatTypeTrough = AnimalDefinitions.animals["ewe"].eatTypeTrough;
AnimalDefinitions.animals["ram"].attackDist = AnimalDefinitions.animals["ewe"].attackDist;
AnimalDefinitions.animals["ram"].attackTimer = AnimalDefinitions.animals["ewe"].attackTimer;
AnimalDefinitions.animals["ram"].woolIncNb = AnimalDefinitions.animals["ewe"].woolIncNb;
AnimalDefinitions.animals["ram"].maxWool = AnimalDefinitions.animals["ewe"].maxWool;
AnimalDefinitions.animals["ram"].luredPossibleItems = AnimalDefinitions.animals["ewe"].luredPossibleItems;
AnimalDefinitions.animals["ram"].trailerBaseSize = AnimalDefinitions.animals["ewe"].trailerBaseSize;
AnimalDefinitions.animals["ram"].canBePet = true;
AnimalDefinitions.animals["ram"].baseEncumbrance = AnimalDefinitions.animals["ewe"].baseEncumbrance;
AnimalDefinitions.animals["ram"].collisionSize = AnimalDefinitions.animals["ewe"].collisionSize;
AnimalDefinitions.animals["ram"].thirstHungerTrigger = AnimalDefinitions.animals["ewe"].thirstHungerTrigger;
AnimalDefinitions.animals["ram"].minWeight = 80;
AnimalDefinitions.animals["ram"].maxWeight = 200;
AnimalDefinitions.animals["ram"].group = "sheep";
AnimalDefinitions.animals["ram"].dung = "Dung_Sheep";
AnimalDefinitions.animals["ram"].ropeBone = "Bip01_Neck";
AnimalDefinitions.animals["ram"].stressAboveGround = true;
AnimalDefinitions.animals["ram"].stressUnderRain = true;
AnimalDefinitions.animals["ram"].attackIfStressed = true;
AnimalDefinitions.animals["ram"].attackBack = true;
AnimalDefinitions.animals["ram"].knockdownAttack = true;
AnimalDefinitions.animals["ram"].canDoLaceration = true;
AnimalDefinitions.animals["ram"].corpseSize = AnimalDefinitions.animals["ewe"].corpseSize;
AnimalDefinitions.animals["ram"].minBlood = 800;
AnimalDefinitions.animals["ram"].maxBlood = 2500;
AnimalDefinitions.animals["ram"].idleSoundRadius = 40;
AnimalDefinitions.animals["ram"].idleSoundVolume = 20;
AnimalDefinitions.animals["ram"].hungerBoost = 3;
AnimalDefinitions.animals["ram"].thirstBoost = 5;

local ewe_sounds = {
	death = { name = "AnimalVoiceSheepDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleySheepBodyfall" },
	idle = { name = "AnimalVoiceSheepIdle", intervalMin = 20, intervalMax = 60, slot = "voice" },
	pain = { name = "AnimalVoiceSheepPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalSheep" },
	pick_up = { name = "PickUpAnimalSheep", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadSheep" },
	put_down = { name = "PutDownAnimalSheep", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadSheep" },
	run = { name = "AnimalFootstepsSheepRun" },
	stressed = { name = "AnimalVoiceSheepStressed", intervalMin = 15, intervalMax = 40, slot = "voice" },
	walkBack = { name = "AnimalFootstepsSheepWalkBack" },
	walkFront = { name = "AnimalFootstepsSheepWalkFront" },
}

AnimalDefinitions.animals["ewe"].breeds["suffolk"].sounds = ewe_sounds
AnimalDefinitions.animals["ewe"].breeds["rambouillet"].sounds = ewe_sounds
AnimalDefinitions.animals["ewe"].breeds["friesian"].sounds = ewe_sounds

local lamb_sounds = {
	death = { name = "AnimalVoiceLambDeath", slot = "voice", priority = 100 },
	fallover = { name = "AnimalFoleyLambBodyfall" },
	idle = { name = "AnimalVoiceLambIdle", intervalMin = 20, intervalMax = 60, slot = "voice" },
	pain = { name = "AnimalVoiceLambPain", slot = "voice", priority = 50 },
	petting = { name = "PetAnimalLamb" },
	pick_up = { name = "PickUpAnimalLamb", slot = "voice", priority = 1 },
	pick_up_corpse = { name = "PickUpAnimalDeadLamb" },
	put_down = { name = "PutDownAnimalLamb", slot = "voice", priority = 1 },
	put_down_corpse = { name = "PutDownAnimalDeadLamb" },
	run = { name = "AnimalFootstepsLambRun" },
	stressed = { name = "AnimalVoiceLambStressed", intervalMin = 15, intervalMax = 40, slot = "voice" },
	walkBack = { name = "AnimalFootstepsLambWalkBack" },
	walkFront = { name = "AnimalFootstepsLambWalkFront" },
}

AnimalDefinitions.animals["lamb"].breeds["suffolk"].sounds = lamb_sounds
AnimalDefinitions.animals["lamb"].breeds["rambouillet"].sounds = lamb_sounds
AnimalDefinitions.animals["lamb"].breeds["friesian"].sounds = lamb_sounds

AnimalDefinitions.animals["ram"].breeds["suffolk"].sounds = ewe_sounds
AnimalDefinitions.animals["ram"].breeds["rambouillet"].sounds = ewe_sounds
AnimalDefinitions.animals["ram"].breeds["friesian"].sounds = ewe_sounds

