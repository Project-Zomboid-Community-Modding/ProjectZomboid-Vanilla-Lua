--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 09/05/2023
-- Time: 08:49
-- To change this template use File | Settings | File Templates.
--

-- This is the definition used when spawning a group of animals for migration

MigrationGroupDefinitions = MigrationGroupDefinitions or {};

MigrationGroupDefinitions["deer"] = {};
MigrationGroupDefinitions["deer"].male = "buck";
MigrationGroupDefinitions["deer"].female = "doe";
MigrationGroupDefinitions["deer"].baby = "fawn";
MigrationGroupDefinitions["deer"].minAnimal = 2; -- min & max animals are purely for female, baby & males will be outside this count
MigrationGroupDefinitions["deer"].maxAnimal = 5;
MigrationGroupDefinitions["deer"].maxMale = 1; -- male will be generated first
MigrationGroupDefinitions["deer"].babyChance = 20; -- percentage, here 20% of the female will have a baby with them
MigrationGroupDefinitions["deer"].possibleBreed = "whitetailed"; -- list separated by ","
MigrationGroupDefinitions["deer"].minTimeBeforeSleep = 1500; -- in minutes
MigrationGroupDefinitions["deer"].maxTimeBeforeSleep = 1900; -- in minutes
MigrationGroupDefinitions["deer"].minTimeBeforeEat = 1200; -- in minutes
MigrationGroupDefinitions["deer"].maxTimeBeforeEat = 1800; -- in minutes
--MigrationGroupDefinitions["deer"].eatPeriodStart =  "3,13"; -- define a sleep period, here deer will try to eat for 60mins from 5am to 7am for ex. this is a list separated by ",", so you can have 12,16 in period start, and 13,17 in periodEnd, meaning they'll eat from 12 to 13 and then from 16 to 17
--MigrationGroupDefinitions["deer"].eatPeriodEnd =  "10,19";
MigrationGroupDefinitions["deer"].timeToEat = 100; -- in minutes
--MigrationGroupDefinitions["deer"].sleepPeriodStart =  "10"; -- define a sleep period, here deer will try to sleep for 30mins from noon to 4pm.
--MigrationGroupDefinitions["deer"].sleepPeriodEnd =  "20";
MigrationGroupDefinitions["deer"].timeToSleep = 60; -- in minutes
MigrationGroupDefinitions["deer"].speed = 0.07; -- 1 is the base speed, 3 would be x3 speed etc.
MigrationGroupDefinitions["deer"].trackChance = 8000; -- chance per tick
MigrationGroupDefinitions["deer"].poopChance = 10500; -- chance per tick
MigrationGroupDefinitions["deer"].brokenTwigsChance = 8000;
MigrationGroupDefinitions["deer"].herbGrazeChance = 5000; -- used when eating
MigrationGroupDefinitions["deer"].furChance = 5000; -- used when sleeping
MigrationGroupDefinitions["deer"].flatHerbChance = 5000; -- used when sleeping
MigrationGroupDefinitions["deer"].trackSize = "large"; -- used when investigating a track, if your level in tracking is too low you'll see "large" "medium" etc. otherwise the name of the animal.

MigrationGroupDefinitions["rabbit"] = {};
MigrationGroupDefinitions["rabbit"].male = "rabbuck";
MigrationGroupDefinitions["rabbit"].female = "rabdoe";
MigrationGroupDefinitions["rabbit"].baby = "rabkitten";
MigrationGroupDefinitions["rabbit"].minAnimal = 3;
MigrationGroupDefinitions["rabbit"].maxAnimal = 8;
MigrationGroupDefinitions["rabbit"].maxMale = 3;
MigrationGroupDefinitions["rabbit"].babyChance = 40;
MigrationGroupDefinitions["rabbit"].possibleBreed = "swamp,appalachian,cottontail";
--MigrationGroupDefinitions["rabbit"].eatPeriodStart =  "5,16";
--MigrationGroupDefinitions["rabbit"].eatPeriodEnd =  "10,22";
MigrationGroupDefinitions["rabbit"].timeToEat = 100;
--MigrationGroupDefinitions["rabbit"].sleepPeriodStart =  "12";
--MigrationGroupDefinitions["rabbit"].sleepPeriodEnd =  "20";
MigrationGroupDefinitions["rabbit"].minTimeBeforeSleep = 1500;
MigrationGroupDefinitions["rabbit"].maxTimeBeforeSleep = 1900;
MigrationGroupDefinitions["rabbit"].minTimeBeforeEat = 1200;
MigrationGroupDefinitions["rabbit"].maxTimeBeforeEat = 1800;
MigrationGroupDefinitions["rabbit"].timeToSleep = 60;
MigrationGroupDefinitions["rabbit"].speed = 0.03;
MigrationGroupDefinitions["rabbit"].trackChance = 13000;
MigrationGroupDefinitions["rabbit"].poopChance = 10000;
MigrationGroupDefinitions["rabbit"].brokenTwigsChance = 35000;
MigrationGroupDefinitions["rabbit"].herbGrazeChance = 4000;
MigrationGroupDefinitions["rabbit"].furChance = 4000;
MigrationGroupDefinitions["rabbit"].flatHerbChance = 4000;
MigrationGroupDefinitions["rabbit"].trackSize = "small";

-- these are larger groups i'm gonna use for when we add more animal, this way "small" can spawn either rabbit, squirrel, raccoon etc..
MigrationGroupDefinitions["small"] = {};
MigrationGroupDefinitions["small"].groups = {};
MigrationGroupDefinitions["small"].groups.rabbit = {};
MigrationGroupDefinitions["small"].groups.rabbit.animal ="rabbit"; -- should be the same as the MigrationGroupDefinitions (MigrationGroupDefinitions["rabbit"] for ex.)
MigrationGroupDefinitions["small"].groups.rabbit.chance = 100; -- weighted chance between all possible groups
--MigrationGroupDefinitions["small"].groups.squirrel = {};
--MigrationGroupDefinitions["small"].groups.squirrel.animal = "squirrel";
--MigrationGroupDefinitions["small"].groups.squirrel.chance = 80;

MigrationGroupDefinitions["large"] = {};
MigrationGroupDefinitions["large"].groups = {};
MigrationGroupDefinitions["large"].groups.deer = {};
MigrationGroupDefinitions["large"].groups.deer.animal ="deer";
MigrationGroupDefinitions["large"].groups.deer.chance = 100;

-- TODO RJ: remove that one day, only used to debug stuff atm
MigrationGroupDefinitions["predator"] = {};
MigrationGroupDefinitions["predator"].male = "rabbuck";
MigrationGroupDefinitions["predator"].female = "rabdoe";
MigrationGroupDefinitions["predator"].baby = "rabkitten";
MigrationGroupDefinitions["predator"].minAnimal = 3;
MigrationGroupDefinitions["predator"].maxAnimal = 8;
MigrationGroupDefinitions["predator"].maxMale = 2;
MigrationGroupDefinitions["predator"].babyChance = 0;
MigrationGroupDefinitions["predator"].possibleBreed = "swamp,appalachian,cottontail";
MigrationGroupDefinitions["predator"].eatPeriodStart =  "5,16";
MigrationGroupDefinitions["predator"].eatPeriodEnd =  "7,18";
MigrationGroupDefinitions["predator"].timeToEat = 60;
MigrationGroupDefinitions["predator"].sleepPeriodStart =  "12";
MigrationGroupDefinitions["predator"].sleepPeriodEnd =  "16";
MigrationGroupDefinitions["predator"].timeToSleep = 30;
MigrationGroupDefinitions["predator"].speed = 0.5;
MigrationGroupDefinitions["predator"].trackChance = 13000;
MigrationGroupDefinitions["predator"].poopChance = 10000;
MigrationGroupDefinitions["predator"].brokenTwigsChance = 35000;
MigrationGroupDefinitions["predator"].herbGrazeChance = 4000;
MigrationGroupDefinitions["predator"].furChance = 4000;
MigrationGroupDefinitions["predator"].flatHerbChance = 4000;
MigrationGroupDefinitions["predator"].trackSize = "large";