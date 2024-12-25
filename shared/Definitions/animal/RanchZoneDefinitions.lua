--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 23/03/2022
-- Time: 09:21
-- To change this template use File | Settings | File Templates.
--

-- This file is used to define "ranch" zone in the map, to know what we gonna spawn and where.
-- If a ranch type zone's name is empty, i'm gonna take a random one in the "ranch" section, otherwise you can force to "chicken" etc.

RanchZoneDefinitions = RanchZoneDefinitions or {};

RanchZoneDefinitions.type = {};
RanchZoneDefinitions.type["chicken"] = {};
RanchZoneDefinitions.type["chicken"].type = "chicken"; -- this is used if you have a ranch name (zone type will be Ranch, zone name will be chicken for ex.) so we know we pick this particular def and not a random one in the list
RanchZoneDefinitions.type["chicken"].globalName = "chicken"; -- this is to name the Designation animal zone that'll be created
RanchZoneDefinitions.type["chicken"].chance = 20; -- weight chance, when chosing a random ranch to spawn, we addition all of the chance we have and pick a random number in there, so the total can exced 100
RanchZoneDefinitions.type["chicken"].femaleType = "hen"; -- this is the animal type defined in the animaldefinition (check ChickenDefinitions for this one)
RanchZoneDefinitions.type["chicken"].maleType = "cockerel"; -- same, for male
RanchZoneDefinitions.type["chicken"].minFemaleNb = 4; -- min number of female animals
RanchZoneDefinitions.type["chicken"].maxFemaleNb = 10; -- uh, max numbers of female animals
RanchZoneDefinitions.type["chicken"].minMaleNb = 1; -- min number of male animals
RanchZoneDefinitions.type["chicken"].maxMaleNb = 1; -- max numbers of male animals
RanchZoneDefinitions.type["chicken"].forcedBreed = nil; -- you can put a forced breed here, like "rhodeisland" and all the chicken will be spawned as rhodeisland if we select this one, if nothing is set we gonna take a random breed in our list defined for this animal type
RanchZoneDefinitions.type["chicken"].chanceForBaby = 15; -- each time we spawn a female, we roll 100 and if we're <= chanceForBaby we add a baby for this female
RanchZoneDefinitions.type["chicken"].maleChance = 100; -- % of chance to get a male TODO: for now i leave it at 100% for testing purpose

RanchZoneDefinitions.type["chickensmall"] = {}; -- more intended for backyard without a hutch
RanchZoneDefinitions.type["chickensmall"].type = "chickensmall";
RanchZoneDefinitions.type["chickensmall"].globalName = "chicken";
RanchZoneDefinitions.type["chickensmall"].chance = 20;
RanchZoneDefinitions.type["chickensmall"].femaleType = "hen";
RanchZoneDefinitions.type["chickensmall"].maleType = "cockerel";
RanchZoneDefinitions.type["chickensmall"].minFemaleNb = 1;
RanchZoneDefinitions.type["chickensmall"].maxFemaleNb = 5;
RanchZoneDefinitions.type["chickensmall"].minMaleNb = 0;
RanchZoneDefinitions.type["chickensmall"].maxMaleNb = 0;
RanchZoneDefinitions.type["chickensmall"].chanceForBaby = 5;

RanchZoneDefinitions.type["chickenbig"] = {}; -- more intended for big chicken ranch
RanchZoneDefinitions.type["chickenbig"].type = "chickenbig";
RanchZoneDefinitions.type["chickenbig"].globalName = "chicken";
RanchZoneDefinitions.type["chickenbig"].chance = 20;
RanchZoneDefinitions.type["chickenbig"].femaleType = "hen";
RanchZoneDefinitions.type["chickenbig"].maleType = "cockerel";
RanchZoneDefinitions.type["chickenbig"].minFemaleNb = 10;
RanchZoneDefinitions.type["chickenbig"].maxFemaleNb = 20;
RanchZoneDefinitions.type["chickenbig"].minMaleNb = 1;
RanchZoneDefinitions.type["chickenbig"].maxMaleNb = 1;
RanchZoneDefinitions.type["chickenbig"].chanceForBaby = 10;
RanchZoneDefinitions.type["chickenbig"].maleChance = 100;

RanchZoneDefinitions.type["pig"] = {};
RanchZoneDefinitions.type["pig"].type = "pig";
RanchZoneDefinitions.type["pig"].globalName = "pig";
RanchZoneDefinitions.type["pig"].chance = 5;
RanchZoneDefinitions.type["pig"].femaleType = "sow";
RanchZoneDefinitions.type["pig"].maleType = "boar";
RanchZoneDefinitions.type["pig"].minFemaleNb = 1;
RanchZoneDefinitions.type["pig"].maxFemaleNb = 5;
RanchZoneDefinitions.type["pig"].minMaleNb = 1;
RanchZoneDefinitions.type["pig"].maxMaleNb = 2;
RanchZoneDefinitions.type["pig"].chanceForBaby = 5;
RanchZoneDefinitions.type["pig"].maleChance = 100;

RanchZoneDefinitions.type["pigsmall"] = {};
RanchZoneDefinitions.type["pigsmall"].type = "pigsmall";
RanchZoneDefinitions.type["pigsmall"].globalName = "pig";
RanchZoneDefinitions.type["pigsmall"].chance = 5;
RanchZoneDefinitions.type["pigsmall"].femaleType = "sow";
RanchZoneDefinitions.type["pigsmall"].maleType = "boar";
RanchZoneDefinitions.type["pigsmall"].minFemaleNb = 1;
RanchZoneDefinitions.type["pigsmall"].maxFemaleNb = 2;
RanchZoneDefinitions.type["pigsmall"].minMaleNb = 1;
RanchZoneDefinitions.type["pigsmall"].maxMaleNb = 0;
RanchZoneDefinitions.type["pigsmall"].chanceForBaby = 5;
RanchZoneDefinitions.type["pigsmall"].maleChance = 100;

RanchZoneDefinitions.type["piglarge"] = {};
RanchZoneDefinitions.type["piglarge"].type = "piglarge";
RanchZoneDefinitions.type["piglarge"].globalName = "pig";
RanchZoneDefinitions.type["piglarge"].chance = 5;
RanchZoneDefinitions.type["piglarge"].femaleType = "sow";
RanchZoneDefinitions.type["piglarge"].maleType = "boar";
RanchZoneDefinitions.type["piglarge"].minFemaleNb = 3;
RanchZoneDefinitions.type["piglarge"].maxFemaleNb = 8;
RanchZoneDefinitions.type["piglarge"].minMaleNb = 1;
RanchZoneDefinitions.type["piglarge"].maxMaleNb = 2;
RanchZoneDefinitions.type["piglarge"].chanceForBaby = 5;
RanchZoneDefinitions.type["piglarge"].maleChance = 100;

RanchZoneDefinitions.type["pigonlyone"] = {}; -- only one pig, intended for one pig in a backyard (come on now, my previous drummer had one pig in his backyard, we called him War.. because of War Pig... eh, you love metal big too much sometime?)
RanchZoneDefinitions.type["pigonlyone"].type = "pigonlyone";
RanchZoneDefinitions.type["pigonlyone"].globalName = "pig";
RanchZoneDefinitions.type["pigonlyone"].chance = 1;
RanchZoneDefinitions.type["pigonlyone"].femaleType = "sow";
RanchZoneDefinitions.type["pigonlyone"].maleType = "boar";
RanchZoneDefinitions.type["pigonlyone"].minFemaleNb = 1;
RanchZoneDefinitions.type["pigonlyone"].maxFemaleNb = 1;
RanchZoneDefinitions.type["pigonlyone"].minMaleNb = 0;
RanchZoneDefinitions.type["pigonlyone"].maxMaleNb = 0;
RanchZoneDefinitions.type["pigonlyone"].chanceForBaby = 0;

RanchZoneDefinitions.type["sheep"] = {};
RanchZoneDefinitions.type["sheep"].type = "sheep";
RanchZoneDefinitions.type["sheep"].globalName = "sheep";
RanchZoneDefinitions.type["sheep"].chance = 7;
RanchZoneDefinitions.type["sheep"].femaleType = "ewe";
RanchZoneDefinitions.type["sheep"].maleType = "ram";
RanchZoneDefinitions.type["sheep"].minFemaleNb = 1;
RanchZoneDefinitions.type["sheep"].maxFemaleNb = 3;
RanchZoneDefinitions.type["sheep"].minMaleNb = 1;
RanchZoneDefinitions.type["sheep"].maxMaleNb = 1;
RanchZoneDefinitions.type["sheep"].chanceForBaby = 10;
RanchZoneDefinitions.type["sheep"].maleChance = 100;

RanchZoneDefinitions.type["sheepsmall"] = {};
RanchZoneDefinitions.type["sheepsmall"].type = "sheepsmall";
RanchZoneDefinitions.type["sheepsmall"].globalName = "sheep";
RanchZoneDefinitions.type["sheepsmall"].chance = 7;
RanchZoneDefinitions.type["sheepsmall"].femaleType = "ewe";
RanchZoneDefinitions.type["sheepsmall"].maleType = "ram";
RanchZoneDefinitions.type["sheepsmall"].minFemaleNb = 1;
RanchZoneDefinitions.type["sheepsmall"].maxFemaleNb = 2;
RanchZoneDefinitions.type["sheepsmall"].minMaleNb = 1;
RanchZoneDefinitions.type["sheepsmall"].maxMaleNb = 0;
RanchZoneDefinitions.type["sheepsmall"].chanceForBaby = 10;
RanchZoneDefinitions.type["sheepsmall"].maleChance = 100;

RanchZoneDefinitions.type["sheeplarge"] = {};
RanchZoneDefinitions.type["sheeplarge"].type = "sheeplarge";
RanchZoneDefinitions.type["sheeplarge"].globalName = "sheep";
RanchZoneDefinitions.type["sheeplarge"].chance = 7;
RanchZoneDefinitions.type["sheeplarge"].femaleType = "ewe";
RanchZoneDefinitions.type["sheeplarge"].maleType = "ram";
RanchZoneDefinitions.type["sheeplarge"].minFemaleNb = 3;
RanchZoneDefinitions.type["sheeplarge"].maxFemaleNb = 8;
RanchZoneDefinitions.type["sheeplarge"].minMaleNb = 1;
RanchZoneDefinitions.type["sheeplarge"].maxMaleNb = 1;
RanchZoneDefinitions.type["sheeplarge"].chanceForBaby = 10;
RanchZoneDefinitions.type["sheeplarge"].maleChance = 100;

RanchZoneDefinitions.type["cow"] = {};
RanchZoneDefinitions.type["cow"].type = "cow";
RanchZoneDefinitions.type["cow"].globalName = "cow";
RanchZoneDefinitions.type["cow"].chance = 3;
RanchZoneDefinitions.type["cow"].femaleType = "cow";
RanchZoneDefinitions.type["cow"].maleType = "bull";
RanchZoneDefinitions.type["cow"].minFemaleNb = 1;
RanchZoneDefinitions.type["cow"].maxFemaleNb = 3;
RanchZoneDefinitions.type["cow"].minMaleNb = 1;
RanchZoneDefinitions.type["cow"].maxMaleNb = 1;
RanchZoneDefinitions.type["cow"].chanceForBaby = 5;
RanchZoneDefinitions.type["cow"].maleChance = 100;

RanchZoneDefinitions.type["cowlarge"] = {};
RanchZoneDefinitions.type["cowlarge"].type = "cowlarge";
RanchZoneDefinitions.type["cowlarge"].globalName = "cow";
RanchZoneDefinitions.type["cowlarge"].chance = 3;
RanchZoneDefinitions.type["cowlarge"].femaleType = "cow";
RanchZoneDefinitions.type["cowlarge"].maleType = "bull";
RanchZoneDefinitions.type["cowlarge"].minFemaleNb = 3;
RanchZoneDefinitions.type["cowlarge"].maxFemaleNb = 8;
RanchZoneDefinitions.type["cowlarge"].minMaleNb = 1;
RanchZoneDefinitions.type["cowlarge"].maxMaleNb = 1;
RanchZoneDefinitions.type["cowlarge"].chanceForBaby = 5;
RanchZoneDefinitions.type["cowlarge"].maleChance = 100;

RanchZoneDefinitions.type["turkey"] = {};
RanchZoneDefinitions.type["turkey"].type = "turkey";
RanchZoneDefinitions.type["turkey"].globalName = "turkey";
RanchZoneDefinitions.type["turkey"].chance = 5;
RanchZoneDefinitions.type["turkey"].femaleType = "turkeyhen";
RanchZoneDefinitions.type["turkey"].maleType = "gobblers";
RanchZoneDefinitions.type["turkey"].minFemaleNb = 3;
RanchZoneDefinitions.type["turkey"].maxFemaleNb = 8;
RanchZoneDefinitions.type["turkey"].minMaleNb = 1;
RanchZoneDefinitions.type["turkey"].maxMaleNb = 1;
RanchZoneDefinitions.type["turkey"].chanceForBaby = 12;
RanchZoneDefinitions.type["turkey"].maleChance = 100;

RanchZoneDefinitions.type["turkeylarge"] = {};
RanchZoneDefinitions.type["turkeylarge"].type = "turkeylarge";
RanchZoneDefinitions.type["turkeylarge"].globalName = "turkey";
RanchZoneDefinitions.type["turkeylarge"].chance = 5;
RanchZoneDefinitions.type["turkeylarge"].femaleType = "turkeyhen";
RanchZoneDefinitions.type["turkeylarge"].maleType = "gobblers";
RanchZoneDefinitions.type["turkeylarge"].minFemaleNb = 6;
RanchZoneDefinitions.type["turkeylarge"].maxFemaleNb = 15;
RanchZoneDefinitions.type["turkeylarge"].minMaleNb = 1;
RanchZoneDefinitions.type["turkeylarge"].maxMaleNb = 1;
RanchZoneDefinitions.type["turkeylarge"].chanceForBaby = 12;
RanchZoneDefinitions.type["turkeylarge"].maleChance = 100;

RanchZoneDefinitions.type["turkeysmall"] = {};
RanchZoneDefinitions.type["turkeysmall"].type = "turkeysmall";
RanchZoneDefinitions.type["turkeysmall"].globalName = "turkey";
RanchZoneDefinitions.type["turkeysmall"].chance = 5;
RanchZoneDefinitions.type["turkeysmall"].femaleType = "turkeyhen";
RanchZoneDefinitions.type["turkeysmall"].maleType = "gobblers";
RanchZoneDefinitions.type["turkeysmall"].minFemaleNb = 1;
RanchZoneDefinitions.type["turkeysmall"].maxFemaleNb = 4;
RanchZoneDefinitions.type["turkeysmall"].minMaleNb = 0;
RanchZoneDefinitions.type["turkeysmall"].maxMaleNb = 0;
RanchZoneDefinitions.type["turkeysmall"].chanceForBaby = 5;

RanchZoneDefinitions.type["rabbit"] = {};
RanchZoneDefinitions.type["rabbit"].type = "rabbit";
RanchZoneDefinitions.type["rabbit"].globalName = "rabbit";
RanchZoneDefinitions.type["rabbit"].chance = 5;
RanchZoneDefinitions.type["rabbit"].femaleType = "rabdoe";
RanchZoneDefinitions.type["rabbit"].maleType = "rabbuck";
RanchZoneDefinitions.type["rabbit"].minFemaleNb = 3;
RanchZoneDefinitions.type["rabbit"].maxFemaleNb = 7;
RanchZoneDefinitions.type["rabbit"].minMaleNb = 1;
RanchZoneDefinitions.type["rabbit"].maxMaleNb = 1;
RanchZoneDefinitions.type["rabbit"].chanceForBaby = 100;
RanchZoneDefinitions.type["rabbit"].maleChance = 100;

RanchZoneDefinitions.type["rabbitsmall"] = {};
RanchZoneDefinitions.type["rabbitsmall"].type = "rabbitsmall";
RanchZoneDefinitions.type["rabbitsmall"].globalName = "rabbit";
RanchZoneDefinitions.type["rabbitsmall"].chance = 5;
RanchZoneDefinitions.type["rabbitsmall"].femaleType = "rabdoe";
RanchZoneDefinitions.type["rabbitsmall"].maleType = "rabbuck";
RanchZoneDefinitions.type["rabbitsmall"].minFemaleNb = 1;
RanchZoneDefinitions.type["rabbitsmall"].maxFemaleNb = 4;
RanchZoneDefinitions.type["rabbitsmall"].minMaleNb = 0;
RanchZoneDefinitions.type["rabbitsmall"].maxMaleNb = 0;
RanchZoneDefinitions.type["rabbitsmall"].chanceForBaby = 0;

RanchZoneDefinitions.type["notchicken"] = {}; -- this is a simple list that'll have reference to others definitions, lots of farm should not have chicken but either cow, sheep or pigs, this is used to randomize them, those kind of list should appears at the end of other list
RanchZoneDefinitions.type["notchicken"].type = "notchicken";
RanchZoneDefinitions.type["notchicken"].possibleDef = {"sheep","cow","pig"};

RanchZoneDefinitions.type["notchickenlarge"] = {};
RanchZoneDefinitions.type["notchickenlarge"].type = "notchickenlarge";
RanchZoneDefinitions.type["notchickenlarge"].possibleDef = {"sheeplarge","cowlarge","piglarge"};

RanchZoneDefinitions.type["poultry"] = {};
RanchZoneDefinitions.type["poultry"].type = "poultry";
RanchZoneDefinitions.type["poultry"].possibleDef = {"chicken", "turkey"};

RanchZoneDefinitions.type["poultrylarge"] = {};
RanchZoneDefinitions.type["poultrylarge"].type = "poultrylarge";
RanchZoneDefinitions.type["poultrylarge"].possibleDef = {"chickenbig", "turkeylarge"};