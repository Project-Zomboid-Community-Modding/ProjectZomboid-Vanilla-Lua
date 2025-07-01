--[ Used to define the animals parts you'll get when butchering it. --]

AnimalPartsDefinitions = AnimalPartsDefinitions or {};
AnimalPartsDefinitions.animals = AnimalPartsDefinitions.animals or {};

-------------------
----- CHICKEN -----
-------------------
local henrhodeisland = AnimalPartsDefinitions.animals["henrhodeisland"] or {};
henrhodeisland.parts = henrhodeisland.parts or {};
table.insert(henrhodeisland.parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(henrhodeisland.parts, {item = "Base.ChickenWhole", nb = 1})
henrhodeisland.bones = henrhodeisland.bones or {};
table.insert(henrhodeisland.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
henrhodeisland.noSkeleton = true; -- when butchering a chicken you get a whole chicken, so no skeleton on ground
henrhodeisland.feather = "Base.ChickenFeather";
henrhodeisland.head = "Base.Chicken_Hen_Brown_Head";
henrhodeisland.skull = "Base.Chicken_Hen_Skull";
henrhodeisland.xpPerItem = 7;
AnimalPartsDefinitions.animals["henrhodeisland"] = henrhodeisland;

local cockerelrhodeisland = AnimalPartsDefinitions.animals["cockerelrhodeisland"] or {};
cockerelrhodeisland.parts = cockerelrhodeisland.parts or {};
table.insert(cockerelrhodeisland.parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(cockerelrhodeisland.parts, {item = "Base.ChickenWhole", nb = 1})
cockerelrhodeisland.bones = cockerelrhodeisland.bones or {};
cockerelrhodeisland.noSkeleton = true;
table.insert(cockerelrhodeisland.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
cockerelrhodeisland.feather = "Base.ChickenFeather";
cockerelrhodeisland.head = "Base.Chicken_Rooster_Head_Brown";
cockerelrhodeisland.skull = "Base.Chicken_Rooster_Skull";
cockerelrhodeisland.xpPerItem = 7;
AnimalPartsDefinitions.animals["cockerelrhodeisland"] = cockerelrhodeisland;

local chickrhodeisland = AnimalPartsDefinitions.animals["chickrhodeisland"] or {};
chickrhodeisland.parts = chickrhodeisland.parts or {};
chickrhodeisland.bones = chickrhodeisland.bones or {};
table.insert(chickrhodeisland.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
chickrhodeisland.noSkeleton = true;
chickrhodeisland.feather = "Base.ChickenFeather";
chickrhodeisland.head = "Base.Chicken_Chick_Head";
chickrhodeisland.skull = "Base.Chicken_Chick_Skull";
chickrhodeisland.xpPerItem = 3;
AnimalPartsDefinitions.animals["chickrhodeisland"] = chickrhodeisland;

local henleghorn = AnimalPartsDefinitions.animals["henleghorn"] or {};
henleghorn.parts = henleghorn.parts or {};
table.insert(henleghorn.parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(henleghorn.parts, {item = "Base.ChickenWhole", nb = 1})
henleghorn.bones = henleghorn.bones or {};
table.insert(henleghorn.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
henleghorn.noSkeleton = true;
henleghorn.feather = "Base.ChickenFeather";
henleghorn.head = "Base.Chicken_Hen_White_Head";
henleghorn.skull = "Base.Chicken_Hen_Skull";
henleghorn.xpPerItem = 7;
AnimalPartsDefinitions.animals["henleghorn"] = henleghorn;

local cockerelleghorn = AnimalPartsDefinitions.animals["cockerelleghorn"] or {};
cockerelleghorn.parts = cockerelleghorn.parts or {};
table.insert(cockerelleghorn.parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(cockerelleghorn.parts, {item = "Base.ChickenWhole", nb = 1})
cockerelleghorn.bones = cockerelleghorn.bones or {};
cockerelleghorn.noSkeleton = true;
table.insert(cockerelleghorn.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
cockerelleghorn.feather = "Base.ChickenFeather";
cockerelleghorn.head = "Base.Chicken_Rooster_Head_White";
cockerelleghorn.skull = "Base.Chicken_Rooster_Skull";
cockerelleghorn.xpPerItem = 7;
AnimalPartsDefinitions.animals["cockerelleghorn"] = cockerelleghorn;

local chickleghorn = AnimalPartsDefinitions.animals["chickleghorn"] or {};
chickleghorn.parts = chickleghorn.parts or {};
--table.insert(chickleghorn.parts, {item = "Base.Chicken", nb = 1})
chickleghorn.bones = chickleghorn.bones or {};
table.insert(chickleghorn.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
chickleghorn.noSkeleton = true;
chickleghorn.feather = "Base.ChickenFeather";
chickleghorn.head = "Base.Chicken_Chick_Head";
chickleghorn.skull = "Base.Chicken_Chick_Skull";
chickleghorn.xpPerItem = 3;
AnimalPartsDefinitions.animals["chickleghorn"] = chickleghorn;

-------------------
------- COWS ------
-------------------

local calfparts = {};
table.insert(calfparts, {item = "Base.Steak", minNb = 5, maxNb = 9})
table.insert(calfparts, {item = "Base.Beef", minNb = 5, maxNb = 9})
table.insert(calfparts, {item = "Base.AnimalSinew", minNb = 1, maxNb = 3})

local cowparts = {};
table.insert(cowparts, {item = "Base.Steak", minNb = 10, maxNb = 18})
table.insert(cowparts, {item = "Base.Beef", minNb = 10, maxNb = 18})
table.insert(cowparts, {item = "Base.AnimalSinew", minNb = 3, maxNb = 7})

--- ANGUS
local cowangus = AnimalPartsDefinitions.animals["cowangus"] or {};
cowangus.parts = cowangus.parts or cowparts;
cowangus.bones = cowangus.bones or {};
table.insert(cowangus.bones, {item = "Base.AnimalBone", minNb = 8, maxNb = 10})
table.insert(cowangus.bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
cowangus.leather = "Base.CowLeather_Angus_Full";
cowangus.head = "Base.Cow_Head_Angus";
cowangus.skull = "Base.Cow_Skull";
cowangus.xpPerItem = 25;
AnimalPartsDefinitions.animals["cowangus"] = cowangus;

local bullangus = AnimalPartsDefinitions.animals["bullangus"] or {};
bullangus.parts = bullangus.parts or cowparts;
bullangus.bones = bullangus.bones or {};
table.insert(bullangus.bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(bullangus.bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
bullangus.leather = "Base.CowLeather_Angus_Full";
bullangus.head = "Base.Bull_Head_Angus";
bullangus.skull = "Base.Bull_Skull";
bullangus.xpPerItem = 25;
AnimalPartsDefinitions.animals["bullangus"] = bullangus;

local cowcalfangus = AnimalPartsDefinitions.animals["cowcalfangus"] or {};
cowcalfangus.parts = cowcalfangus.parts or calfparts;
cowcalfangus.bones = cowcalfangus.bones or {};
table.insert(cowcalfangus.bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
cowcalfangus.leather = "Base.CalfLeather_Angus_Full";
cowcalfangus.head = "Base.Calf_Head_Angus";
cowcalfangus.skull = "Base.Calf_Skull";
cowcalfangus.xpPerItem = 18;
AnimalPartsDefinitions.animals["cowcalfangus"] = cowcalfangus;

--- SIMMENTAL
local cowsimmental = AnimalPartsDefinitions.animals["cowsimmental"] or {};
cowsimmental.parts = cowsimmental.parts or cowparts;
cowsimmental.bones = cowsimmental.bones or {};
table.insert(cowsimmental.bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(cowsimmental.bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
cowsimmental.leather = "Base.CowLeather_Simmental_Full";
cowsimmental.head = "Base.Cow_Head_Simmental";
cowsimmental.skull = "Base.Cow_Skull";
cowsimmental.xpPerItem = 25;
AnimalPartsDefinitions.animals["cowsimmental"] = cowsimmental;

local bullsimmental = AnimalPartsDefinitions.animals["bullsimmental"] or {};
bullsimmental.parts = bullsimmental.parts or cowparts;
bullsimmental.bones = bullsimmental.bones or {};
table.insert(bullsimmental.bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(bullsimmental.bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
bullsimmental.leather = "Base.CowLeather_Simmental_Full";
bullsimmental.head = "Base.Bull_Head_Simmental";
bullsimmental.skull = "Base.Bull_Skull";
bullsimmental.xpPerItem = 25;
AnimalPartsDefinitions.animals["bullsimmental"] = bullsimmental;

local cowcalfsimmental = AnimalPartsDefinitions.animals["cowcalfsimmental"] or {};
cowcalfsimmental.parts = cowcalfsimmental.parts or calfparts;
cowcalfsimmental.bones = cowcalfsimmental.bones or {};
table.insert(cowcalfsimmental.bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
cowcalfsimmental.leather = "Base.CalfLeather_Simmental_Full";
cowcalfsimmental.head = "Base.Calf_Head_Simmental";
cowcalfsimmental.skull = "Base.Calf_Skull";
cowcalfsimmental.xpPerItem = 18;
AnimalPartsDefinitions.animals["cowcalfsimmental"] = cowcalfsimmental;

--- HOLSTEIN
local cowholstein = AnimalPartsDefinitions.animals["cowholstein"] or {};
cowholstein.parts = cowholstein.parts or cowparts;
cowholstein.bones = cowholstein.bones or {};
table.insert(cowholstein.bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(cowholstein.bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
cowholstein.leather = "Base.CowLeather_Holstein_Full";
cowholstein.head = "Base.Cow_Head_Holstein";
cowholstein.skull = "Base.Cow_Skull";
cowholstein.xpPerItem = 25;
AnimalPartsDefinitions.animals["cowholstein"] = cowholstein;

local bullholstein = AnimalPartsDefinitions.animals["bullholstein"] or {};
bullholstein.parts = bullholstein.parts or cowparts;
bullholstein.bones = bullholstein.bones or {};
table.insert(bullholstein.bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(bullholstein.bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
bullholstein.leather = "Base.CowLeather_Holstein_Full";
bullholstein.head = "Base.Bull_Head_Holstein";
bullholstein.skull = "Base.Bull_Skull";
bullholstein.xpPerItem = 25;
AnimalPartsDefinitions.animals["bullholstein"] = bullholstein;

local cowcalfholstein = AnimalPartsDefinitions.animals["cowcalfholstein"] or {};
cowcalfholstein.parts = cowcalfholstein.parts or calfparts;
cowcalfholstein.bones = cowcalfholstein.bones or {};
table.insert(cowcalfholstein.bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
cowcalfholstein.leather = "Base.CalfLeather_Holstein_Full";
cowcalfholstein.head = "Base.Calf_Head_Holstein";
cowcalfholstein.skull = "Base.Calf_Skull";
cowcalfholstein.xpPerItem = 18;
AnimalPartsDefinitions.animals["cowcalfholstein"] = cowcalfholstein;

-------------------
------- PIGS ------
-------------------

local pigletparts = {};
table.insert(pigletparts, {item = "Base.PorkChop", minNb = 3, maxNb = 7})
table.insert(pigletparts, {item = "Base.Pork", minNb = 3, maxNb = 7})
table.insert(pigletparts, {item = "Base.AnimalSinew", minNb = 1, maxNb = 2})

local pigparts = {};
table.insert(pigparts, {item = "Base.PorkChop", minNb = 8, maxNb = 13})
table.insert(pigparts, {item = "Base.Pork", minNb = 8, maxNb = 13})
table.insert(pigparts, {item = "Base.AnimalSinew", minNb = 3, maxNb = 5})

--- LANDRACE
local sowlandrace = AnimalPartsDefinitions.animals["sowlandrace"] or {};
sowlandrace.parts = sowlandrace.parts or pigparts;
sowlandrace.bones = sowlandrace.bones or {};
table.insert(sowlandrace.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(sowlandrace.bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
table.insert(sowlandrace.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
sowlandrace.leather = "Base.PigLeather_Landrace_Full";
sowlandrace.head = "Base.Pig_Sow_Head_Pink";
sowlandrace.skull = "Base.Pig_Skull";
sowlandrace.xpPerItem = 18;
AnimalPartsDefinitions.animals["sowlandrace"] = sowlandrace;

local boarlandrace = AnimalPartsDefinitions.animals["boarlandrace"] or {};
boarlandrace.parts = boarlandrace.parts or pigparts;
boarlandrace.bones = boarlandrace.bones or {};
table.insert(boarlandrace.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(boarlandrace.bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
table.insert(boarlandrace.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
boarlandrace.leather = "Base.PigLeather_Landrace_Full";
boarlandrace.head = "Base.Pig_Boar_Head_Pink";
boarlandrace.skull = "Base.Pig_Skull";
boarlandrace.xpPerItem = 18;
AnimalPartsDefinitions.animals["boarlandrace"] = boarlandrace;

local pigletlandrace = AnimalPartsDefinitions.animals["pigletlandrace"] or {};
pigletlandrace.parts = pigletlandrace.parts or pigletparts;
pigletlandrace.bones = pigletlandrace.bones or {};
table.insert(pigletlandrace.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
pigletlandrace.leather = "Base.PigletLeather_Landrace_Full";
pigletlandrace.head = "Base.Pig_Piglet_Head_Pink";
pigletlandrace.skull = "Base.Piglet_Skull";
pigletlandrace.xpPerItem = 12;
AnimalPartsDefinitions.animals["pigletlandrace"] = pigletlandrace;

--- LARGE BLACK
local sowlargeblack = AnimalPartsDefinitions.animals["sowlargeblack"] or {};
sowlargeblack.parts = sowlargeblack.parts or pigparts;
sowlargeblack.bones = sowlargeblack.bones or {};
table.insert(sowlargeblack.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(sowlargeblack.bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
table.insert(sowlargeblack.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
sowlargeblack.leather = "Base.PigLeather_Black_Full";
sowlargeblack.head = "Base.Pig_Sow_Head_Black";
sowlargeblack.skull = "Base.Pig_Skull";
sowlargeblack.xpPerItem = 18;
AnimalPartsDefinitions.animals["sowlargeblack"] = sowlargeblack;

local boarlargeblack = AnimalPartsDefinitions.animals["boarlargeblack"] or {};
boarlargeblack.parts = boarlargeblack.parts or pigparts;
boarlargeblack.bones = boarlargeblack.bones or {};
table.insert(boarlargeblack.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(boarlargeblack.bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
table.insert(boarlargeblack.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
boarlargeblack.leather = "Base.PigLeather_Black_Full";
boarlargeblack.head = "Base.Pig_Boar_Head_Black";
boarlargeblack.skull = "Base.Pig_Skull";
boarlargeblack.xpPerItem = 18;
AnimalPartsDefinitions.animals["boarlargeblack"] = boarlargeblack;

local pigletlargeblack = AnimalPartsDefinitions.animals["pigletlargeblack"] or {};
pigletlargeblack.parts = pigletlargeblack.parts or pigletparts;
pigletlargeblack.bones = pigletlargeblack.bones or {};
table.insert(pigletlargeblack.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
pigletlargeblack.leather = "Base.PigletLeather_Black_Full";
pigletlargeblack.head = "Base.Pig_Piglet_Head_Black";
pigletlargeblack.skull = "Base.Piglet_Skull";
pigletlargeblack.xpPerItem = 12;
AnimalPartsDefinitions.animals["pigletlargeblack"] = pigletlargeblack;

-------------------
----- TURKEY ------
-------------------
local turkeyhenmeleagris = AnimalPartsDefinitions.animals["turkeyhenmeleagris"] or {};
turkeyhenmeleagris.parts = turkeyhenmeleagris.parts or {};
--table.insert(turkeyhenmeleagris.parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(turkeyhenmeleagris.parts, {item = "Base.TurkeyWhole", nb = 1})
turkeyhenmeleagris.bones = turkeyhenmeleagris.bones or {};
table.insert(turkeyhenmeleagris.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
turkeyhenmeleagris.noSkeleton = true;
turkeyhenmeleagris.feather = "Base.TurkeyFeather";
turkeyhenmeleagris.head = "Base.Turkey_Hen_Head";
turkeyhenmeleagris.skull = "Base.Turkey_Skull";
turkeyhenmeleagris.xpPerItem = 7;
AnimalPartsDefinitions.animals["turkeyhenmeleagris"] = turkeyhenmeleagris;

local gobblersmeleagris = AnimalPartsDefinitions.animals["gobblersmeleagris"] or {};
gobblersmeleagris.parts = gobblersmeleagris.parts or {};
--table.insert(gobblersmeleagris.parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(gobblersmeleagris.parts, {item = "Base.TurkeyWhole", nb = 1})
gobblersmeleagris.bones = gobblersmeleagris.bones or {};
table.insert(gobblersmeleagris.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
gobblersmeleagris.noSkeleton = true;
gobblersmeleagris.feather = "Base.TurkeyFeather";
gobblersmeleagris.head = "Base.Turkey_Gobbler_Head";
gobblersmeleagris.skull = "Base.Turkey_Skull";
gobblersmeleagris.xpPerItem = 7;
AnimalPartsDefinitions.animals["gobblersmeleagris"] = gobblersmeleagris;

local turkeypoultmeleagris = AnimalPartsDefinitions.animals["turkeypoultmeleagris"] or {};
turkeypoultmeleagris.parts = turkeypoultmeleagris.parts or {};
--table.insert(turkeypoultmeleagris.parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(turkeypoultmeleagris.parts, {item = "Base.TurkeyWhole", nb = 1})
turkeypoultmeleagris.bones = turkeypoultmeleagris.bones or {};
table.insert(turkeyhenmeleagris.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
turkeyhenmeleagris.noSkeleton = true;
turkeypoultmeleagris.feather = "Base.TurkeyFeather";
turkeypoultmeleagris.head = "Base.Turkey_Poult_Head";
turkeypoultmeleagris.skull = "Base.Turkey_PoultSkull";
turkeypoultmeleagris.xpPerItem = 3;
AnimalPartsDefinitions.animals["turkeypoultmeleagris"] = turkeypoultmeleagris;

-------------------
------ SHEEP ------
-------------------

local lambparts = {};
table.insert(lambparts, {item = "Base.MuttonChop", minNb = 4, maxNb = 9})
table.insert(lambparts, {item = "Base.AnimalSinew", minNb = 1, maxNb = 2})

local sheepparts = {};
table.insert(sheepparts, {item = "Base.MuttonChop", minNb = 9, maxNb = 15})
table.insert(sheepparts, {item = "Base.AnimalSinew", minNb = 3, maxNb = 5})

--- SUFFOLK
local ewesuffolk = AnimalPartsDefinitions.animals["ewesuffolk"] or {};
ewesuffolk.parts = ewesuffolk.parts or sheepparts;
ewesuffolk.bones = ewesuffolk.bones or {};
table.insert(ewesuffolk.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(ewesuffolk.bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(ewesuffolk.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
ewesuffolk.leather = "Base.SheepLeather_Full";
ewesuffolk.head = "Base.Sheep_Ewe_Head_Black";
ewesuffolk.skull = "Base.Sheep_Skull";
ewesuffolk.xpPerItem = 10;
AnimalPartsDefinitions.animals["ewesuffolk"] = ewesuffolk;

local ramsuffolk = AnimalPartsDefinitions.animals["ramsuffolk"] or {};
ramsuffolk.parts = ramsuffolk.parts or sheepparts;
ramsuffolk.bones = ramsuffolk.bones or {};
table.insert(ramsuffolk.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(ramsuffolk.bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(ramsuffolk.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
ramsuffolk.leather = "Base.SheepLeather_Full";
ramsuffolk.head = "Base.Sheep_Ram_Head_Black";
ramsuffolk.skull = "Base.Ram_Skull";
ramsuffolk.xpPerItem = 10;
AnimalPartsDefinitions.animals["ramsuffolk"] = ramsuffolk;

local lambsuffolk = AnimalPartsDefinitions.animals["lambsuffolk"] or {};
lambsuffolk.parts = lambsuffolk.parts or lambparts;
lambsuffolk.bones = lambsuffolk.bones or {};
table.insert(lambsuffolk.bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 10})
table.insert(lambsuffolk.bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
lambsuffolk.leather = "Base.LambLeather_Full";
lambsuffolk.head = "Base.Sheep_Lamb_Head_Black";
lambsuffolk.skull = "Base.Lamb_Skull";
lambsuffolk.xpPerItem = 6;
AnimalPartsDefinitions.animals["lambsuffolk"] = lambsuffolk;

-- RAMBOUILLET
local ewerambouillet = AnimalPartsDefinitions.animals["ewerambouillet"] or {};
ewerambouillet.parts = ewerambouillet.parts or sheepparts;
ewerambouillet.bones = ewerambouillet.bones or {};
table.insert(ewerambouillet.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(ewerambouillet.bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(ewerambouillet.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
ewerambouillet.leather = "Base.SheepLeather_Full";
ewerambouillet.head = "Base.Sheep_Ewe_Head_White";
ewerambouillet.skull = "Base.Sheep_Skull";
ewerambouillet.xpPerItem = 10;
AnimalPartsDefinitions.animals["ewerambouillet"] = ewerambouillet;

local ramrambouillet = AnimalPartsDefinitions.animals["ramrambouillet"] or {};
ramrambouillet.parts = ramrambouillet.parts or sheepparts;
ramrambouillet.bones = ramrambouillet.bones or {};
table.insert(ramrambouillet.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(ramrambouillet.bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(ramrambouillet.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
ramrambouillet.leather = "Base.SheepLeather_Full";
ramrambouillet.head = "Base.Sheep_Ram_Head_White";
ramrambouillet.skull = "Base.Ram_Skull";
ramrambouillet.xpPerItem = 10;
AnimalPartsDefinitions.animals["ramrambouillet"] = ramrambouillet;

local lambrambouillet = AnimalPartsDefinitions.animals["lambrambouillet"] or {};
lambrambouillet.parts = lambrambouillet.parts or lambparts;
lambrambouillet.bones = lambrambouillet.bones or {};
table.insert(lambrambouillet.bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 10})
table.insert(lambrambouillet.bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
lambrambouillet.leather = "Base.LambLeather_Full";
lambrambouillet.head = "Base.Sheep_Lamb_Head_White";
lambrambouillet.skull = "Base.Lamb_Skull";
lambrambouillet.xpPerItem = 6;
AnimalPartsDefinitions.animals["lambrambouillet"] = lambrambouillet;

-- FRIESIAN
local ewefriesian = AnimalPartsDefinitions.animals["ewefriesian"] or {};
ewefriesian.parts = ewefriesian.parts or sheepparts;
ewefriesian.bones = ewefriesian.bones or {};
table.insert(ewefriesian.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(ewefriesian.bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(ewefriesian.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
ewefriesian.leather = "Base.SheepLeather_Full";
ewefriesian.head = "Base.Sheep_Ewe_Head_White";
ewefriesian.skull = "Base.Sheep_Skull";
ewefriesian.xpPerItem = 10;
AnimalPartsDefinitions.animals["ewefriesian"] = ewefriesian;

local ramfriesian = AnimalPartsDefinitions.animals["ramfriesian"] or {};
ramfriesian.parts = ramfriesian.parts or sheepparts;
ramfriesian.bones = ramfriesian.bones or {};
table.insert(ramfriesian.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(ramfriesian.bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(ramfriesian.bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
ramfriesian.leather = "Base.SheepLeather_Full";
ramfriesian.head = "Base.Sheep_Ram_Head_White";
ramfriesian.skull = "Base.Ram_Skull";
ramfriesian.xpPerItem = 10;
AnimalPartsDefinitions.animals["ramfriesian"] = ramfriesian;

local lambfriesian = AnimalPartsDefinitions.animals["lambfriesian"] or {};
lambfriesian.parts = lambfriesian.parts or lambparts;
lambfriesian.bones = lambrambouillet.bones or {};
table.insert(lambfriesian.bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 10})
table.insert(lambfriesian.bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
lambfriesian.leather = "Base.LambLeather_Full";
lambfriesian.head = "Base.Sheep_Lamb_Head_White";
lambfriesian.skull = "Base.Lamb_Skull";
lambfriesian.xpPerItem = 6;
AnimalPartsDefinitions.animals["lambfriesian"] = lambfriesian;

-------------------
------- DEER ------
-------------------

local deerparts = {};
table.insert(deerparts, {item = "Base.Venison", minNb = 10, maxNb = 19})
table.insert(deerparts, {item = "Base.AnimalSinew", minNb = 3, maxNb = 8})

local fawnparts = {};
table.insert(fawnparts, {item = "Base.Venison", minNb = 5, maxNb = 9})
table.insert(fawnparts, {item = "Base.AnimalSinew", minNb = 1, maxNb = 3})

local doewhitetailed = AnimalPartsDefinitions.animals["doewhitetailed"] or {};
doewhitetailed.parts = doewhitetailed.parts or deerparts;
doewhitetailed.bones = doewhitetailed.bones or {};
table.insert(doewhitetailed.bones, {item = "Base.AnimalBone", minNb = 5, maxNb = 8})
table.insert(doewhitetailed.bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
doewhitetailed.leather = "Base.DeerLeather_Full";
doewhitetailed.head = "Base.Deer_Doe_Head";
lambsuffolk.skull = "Base.DeerDoe_Skull";
doewhitetailed.xpPerItem = 25;
AnimalPartsDefinitions.animals["doewhitetailed"] = doewhitetailed;

local buckwhitetailed = AnimalPartsDefinitions.animals["buckwhitetailed"] or {};
buckwhitetailed.parts = buckwhitetailed.parts or deerparts;
buckwhitetailed.bones = buckwhitetailed.bones or {};
table.insert(buckwhitetailed.bones, {item = "Base.AnimalBone", minNb = 5, maxNb = 8})
table.insert(buckwhitetailed.bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
buckwhitetailed.leather = "Base.DeerLeather_Full";
buckwhitetailed.head = "Base.Deer_Buck_Head";
buckwhitetailed.skull = "Base.DeerStag_Skull";
buckwhitetailed.xpPerItem = 25;
AnimalPartsDefinitions.animals["buckwhitetailed"] = buckwhitetailed;

local fawnwhitetailed = AnimalPartsDefinitions.animals["fawnwhitetailed"] or {};
fawnwhitetailed.parts = fawnwhitetailed.parts or fawnparts;
fawnwhitetailed.bones = fawnwhitetailed.bones or {};
table.insert(fawnwhitetailed.bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 10})
table.insert(fawnwhitetailed.bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 5})
fawnwhitetailed.leather = "Base.FawnLeather_Full";
fawnwhitetailed.head = "Base.Deer_Fawn_Head";
fawnwhitetailed.skull = "Base.DeerFawn_Skull";
fawnwhitetailed.xpPerItem = 18;
AnimalPartsDefinitions.animals["fawnwhitetailed"] = fawnwhitetailed;

-------------------
----- RABBITS -----
-------------------

local rabbitspart = {};
table.insert(rabbitspart, {item = "Base.Rabbitmeat", minNb = 4, maxNb = 7})

local rabbitskitpart = {};
table.insert(rabbitskitpart, {item = "Base.Rabbitmeat", minNb = 2, maxNb = 4})

-- SWAMP
local rabdoeswamp = AnimalPartsDefinitions.animals["rabdoeswamp"] or {};
rabdoeswamp.parts = rabdoeswamp.parts or rabbitspart;
rabdoeswamp.bones = rabdoeswamp.bones or {};
table.insert(rabdoeswamp.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(rabdoeswamp.bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
rabdoeswamp.head = "Base.Rabbit_Head_Swamp";
rabdoeswamp.skull = "Base.Rabbit_Skull";
rabdoeswamp.xpPerItem = 7;
AnimalPartsDefinitions.animals["rabdoeswamp"] = rabdoeswamp;

local rabbuckswamp = AnimalPartsDefinitions.animals["rabbuckswamp"] or rabdoeswamp;
AnimalPartsDefinitions.animals["rabbuckswamp"] = rabbuckswamp;

local rabkittenswamp = AnimalPartsDefinitions.animals["rabkittenswamp"] or {};
rabkittenswamp.parts = rabkittenswamp.parts or rabbitskitpart;
rabkittenswamp.bones = rabkittenswamp.bones or {};
table.insert(rabkittenswamp.bones, {item = "Base.SmallAnimalBone", minNb = 3, maxNb = 6})
rabkittenswamp.head = "Base.Rabbit_Kitten_Head_Swamp";
rabkittenswamp.skull = "Base.Rabbit_KittenSkull";
rabkittenswamp.xpPerItem = 3;
AnimalPartsDefinitions.animals["rabkittenswamp"] = rabkittenswamp;

-- APPALACHIAN
local rabdoeappalachian = AnimalPartsDefinitions.animals["rabdoeappalachian"] or {};
rabdoeappalachian.parts = rabdoeappalachian.parts or rabbitspart;
rabdoeappalachian.bones = rabdoeappalachian.bones or {};
table.insert(rabdoeappalachian.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(rabdoeappalachian.bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
rabdoeappalachian.head = "Base.Rabbit_Head_Appalachian";
rabdoeappalachian.skull = "Base.Rabbit_Skull";
rabdoeappalachian.xpPerItem = 7;
AnimalPartsDefinitions.animals["rabdoeappalachian"] = rabdoeappalachian;

local rabbuckappalachian = AnimalPartsDefinitions.animals["rabbuckappalachian"] or rabdoeappalachian;
AnimalPartsDefinitions.animals["rabbuckappalachian"] = rabbuckappalachian;

local rabkittenappalachian = AnimalPartsDefinitions.animals["rabkittenappalachian"] or {};
rabkittenappalachian.parts = rabkittenappalachian.parts or rabbitskitpart;
rabkittenappalachian.bones = rabkittenappalachian.bones or {};
table.insert(rabkittenappalachian.bones, {item = "Base.SmallAnimalBone", minNb = 3, maxNb = 6})
rabkittenappalachian.head = "Base.Rabbit_Kitten_Head_Appalachian";
rabkittenappalachian.skull = "Base.Rabbit_KittenSkull";
rabkittenappalachian.xpPerItem = 3;
AnimalPartsDefinitions.animals["rabkittenappalachian"] = rabkittenappalachian;

-- COTTON TAIL
local rabdoecottontail = AnimalPartsDefinitions.animals["rabdoecottontail"] or {};
rabdoecottontail.parts = rabdoecottontail.parts or rabbitspart;
rabdoecottontail.bones = rabdoecottontail.bones or {};
table.insert(rabdoecottontail.bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(rabdoecottontail.bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
rabdoecottontail.head = "Base.Rabbit_Head_CottonTail";
rabdoecottontail.skull = "Base.Rabbit_Skull";
rabdoecottontail.xpPerItem = 7;
AnimalPartsDefinitions.animals["rabdoecottontail"] = rabdoecottontail;

local rabbuckcottontail = AnimalPartsDefinitions.animals["rabbuckcottontail"] or rabdoecottontail;
AnimalPartsDefinitions.animals["rabbuckcottontail"] = rabbuckcottontail;

local rabkittencottontail = AnimalPartsDefinitions.animals["rabkittencottontail"] or {};
rabkittencottontail.parts = rabkittencottontail.parts or rabbitskitpart;
rabkittencottontail.bones = rabkittencottontail.bones or {};
table.insert(rabkittencottontail.bones, {item = "Base.SmallAnimalBone", minNb = 3, maxNb = 6})
rabkittencottontail.head = "Base.Rabbit_Kitten_Head_CottonTail";
rabkittencottontail.skull = "Base.Rabbit_KittenSkull";
rabkittencottontail.xpPerItem = 3;
AnimalPartsDefinitions.animals["rabkittencottontail"] = rabkittencottontail;

-------------------
------ RATS -------
-------------------
local ratfemalegrey = AnimalPartsDefinitions.animals["ratfemalegrey"] or {};
ratfemalegrey.parts = ratfemalegrey.parts or {};
table.insert(ratfemalegrey.parts, {item = "Base.DeadRatSkinned", nb = 1})
ratfemalegrey.bones = ratfemalegrey.bones or {};
table.insert(ratfemalegrey.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
ratfemalegrey.noSkeleton = true;
ratfemalegrey.xpPerItem = 7;
AnimalPartsDefinitions.animals["ratfemalegrey"] = ratfemalegrey;

local ratgrey = AnimalPartsDefinitions.animals["ratgrey"] or ratfemalegrey;
AnimalPartsDefinitions.animals["ratgrey"] = ratgrey;

local ratbabygrey = AnimalPartsDefinitions.animals["ratbabygrey"] or {};
ratbabygrey.parts = ratbabygrey.parts or {};
table.insert(ratbabygrey.parts, {item = "Base.DeadRatBabySkinned", nb = 1})
ratbabygrey.bones = ratbabygrey.bones or {};
table.insert(ratbabygrey.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
ratbabygrey.noSkeleton = true;
ratbabygrey.xpPerItem = 7;
AnimalPartsDefinitions.animals["ratbabygrey"] = ratbabygrey;

local ratfemalewhite = AnimalPartsDefinitions.animals["ratfemalewhite"] or {};
ratfemalewhite.parts = ratfemalewhite.parts or {};
table.insert(ratfemalewhite.parts, {item = "Base.DeadRatSkinned", nb = 1})
ratfemalewhite.bones = ratfemalewhite.bones or {};
table.insert(ratfemalewhite.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
ratfemalewhite.noSkeleton = true;
ratfemalewhite.xpPerItem = 7;
AnimalPartsDefinitions.animals["ratfemalewhite"] = ratfemalewhite;

local ratwhite = AnimalPartsDefinitions.animals["ratwhite"] or ratfemalewhite;
AnimalPartsDefinitions.animals["ratwhite"] = ratwhite;

local ratbabywhite = AnimalPartsDefinitions.animals["ratbabywhite"] or {};
ratbabywhite.parts = ratbabywhite.parts or {};
table.insert(ratbabywhite.parts, {item = "Base.DeadRatBabySkinned", nb = 1})
ratbabywhite.bones = ratbabywhite.bones or {};
table.insert(ratbabywhite.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
ratbabywhite.noSkeleton = true;
ratbabywhite.xpPerItem = 7;
AnimalPartsDefinitions.animals["ratbabywhite"] = ratbabywhite;

-------------------
------ MICE -------
-------------------
local mousefemalegolden = AnimalPartsDefinitions.animals["mousefemalegolden"] or {};
mousefemalegolden.parts = mousefemalegolden.parts or {};
table.insert(mousefemalegolden.parts, {item = "Base.DeadMouseSkinned", nb = 1})
mousefemalegolden.bones = mousefemalegolden.bones or {};
table.insert(mousefemalegolden.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
mousefemalegolden.noSkeleton = true;
mousefemalegolden.xpPerItem = 5;
AnimalPartsDefinitions.animals["mousefemalegolden"] = mousefemalegolden;

local mousegolden = AnimalPartsDefinitions.animals["mousegolden"] or mousefemalegolden;
AnimalPartsDefinitions.animals["mousegolden"] = mousegolden;

local mousepupsgolden = AnimalPartsDefinitions.animals["mousepupsgolden"] or {};
mousepupsgolden.parts = mousepupsgolden.parts or {};
table.insert(mousepupsgolden.parts, {item = "Base.DeadMousePupsSkinned", nb = 1})
mousepupsgolden.bones = mousepupsgolden.bones or {};
table.insert(mousepupsgolden.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
mousepupsgolden.noSkeleton = true;
mousepupsgolden.xpPerItem = 5;
AnimalPartsDefinitions.animals["mousepupsgolden"] = mousepupsgolden;

local mousefemaledeer = AnimalPartsDefinitions.animals["mousefemaledeer"] or {};
mousefemaledeer.parts = mousefemaledeer.parts or {};
table.insert(mousefemaledeer.parts, {item = "Base.DeadMouseSkinned", nb = 1})
mousefemaledeer.bones = mousefemaledeer.bones or {};
table.insert(mousefemaledeer.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
mousefemaledeer.noSkeleton = true;
mousefemaledeer.xpPerItem = 5;
AnimalPartsDefinitions.animals["mousefemaledeer"] = mousefemaledeer;

local mousedeer = AnimalPartsDefinitions.animals["mousedeer"] or mousefemaledeer;
AnimalPartsDefinitions.animals["mousedeer"] = mousedeer;

local mousepupsdeer = AnimalPartsDefinitions.animals["mousepupsdeer"] or {};
mousepupsdeer.parts = mousepupsdeer.parts or {};
table.insert(mousepupsdeer.parts, {item = "Base.DeadMousePupsSkinned", nb = 1})
mousepupsdeer.bones = mousepupsdeer.bones or {};
table.insert(mousepupsdeer.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
mousepupsdeer.noSkeleton = true;
mousepupsdeer.xpPerItem = 5;
AnimalPartsDefinitions.animals["mousepupsdeer"] = mousepupsdeer;

local mousefemalewhite = AnimalPartsDefinitions.animals["mousefemalewhite"] or {};
mousefemalewhite.parts = mousefemalewhite.parts or {};
table.insert(mousefemalewhite.parts, {item = "Base.DeadMouseSkinned", nb = 1})
mousefemalewhite.bones = mousefemalewhite.bones or {};
table.insert(mousefemalewhite.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
mousefemalewhite.noSkeleton = true;
mousefemalewhite.xpPerItem = 5;
AnimalPartsDefinitions.animals["mousefemalewhite"] = mousefemalewhite;

local mousewhite = AnimalPartsDefinitions.animals["mousewhite"] or mousefemalewhite;
AnimalPartsDefinitions.animals["mousewhite"] = mousewhite;

local mousepupswhite = AnimalPartsDefinitions.animals["mousepupswhite"] or {};
mousepupswhite.parts = mousepupswhite.parts or {};
table.insert(mousepupswhite.parts, {item = "Base.DeadMousePupsSkinned", nb = 1})
mousepupswhite.bones = mousepupswhite.bones or {};
table.insert(mousepupswhite.bones, {item = "Base.SmallAnimalBone", minNb = 1, maxNb = 2})
mousepupswhite.noSkeleton = true;
mousepupswhite.xpPerItem = 5;
AnimalPartsDefinitions.animals["mousepupswhite"] = mousepupswhite;

-------------------
----- RACCOON -----
-------------------

local raccoonkitparts = {};
table.insert(raccoonkitparts, {item = "Base.Smallanimalmeat", minNb = 3, maxNb = 5})

local raccoonparts = {};
table.insert(raccoonparts, {item = "Base.Smallanimalmeat", minNb = 5, maxNb = 8})

local raccoonsowgrey = AnimalPartsDefinitions.animals["raccoonsowgrey"] or {};
raccoonsowgrey.parts = raccoonsowgrey.parts or raccoonparts;
raccoonsowgrey.bones = raccoonsowgrey.bones or {};
table.insert(raccoonsowgrey.bones, {item = "Base.SmallAnimalBone", minNb = 3, maxNb = 6})
raccoonsowgrey.leather = "Base.RaccoonLeather_Grey_Full";
raccoonsowgrey.head = "Base.Raccoon_Sow_Head";
raccoonsowgrey.skull = "Base.Raccoon_Skull";
raccoonsowgrey.noSkeleton = true;
raccoonsowgrey.xpPerItem = 10;
AnimalPartsDefinitions.animals["raccoonsowgrey"] = raccoonsowgrey;

local raccoonboargrey = AnimalPartsDefinitions.animals["raccoonboargrey"] or {};
raccoonboargrey.parts = raccoonboargrey.parts or raccoonparts;
raccoonboargrey.bones = raccoonboargrey.bones or {};
table.insert(raccoonboargrey.bones, {item = "Base.SmallAnimalBone", minNb = 3, maxNb = 6})
raccoonboargrey.head = "Base.Raccoon_Boar_Head";
raccoonboargrey.skull = "Base.Raccoon_Skull";
raccoonboargrey.leather = "Base.RaccoonLeather_Grey_Full";
raccoonboargrey.noSkeleton = true;
raccoonboargrey.xpPerItem = 10;
AnimalPartsDefinitions.animals["raccoonboargrey"] = raccoonboargrey;

local raccoonkitgrey = AnimalPartsDefinitions.animals["raccoonkitgrey"] or {};
raccoonkitgrey.parts = raccoonkitgrey.parts or raccoonkitparts;
raccoonkitgrey.bones = rabkittencottontail.bones or {};
table.insert(raccoonkitgrey.bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 3})
raccoonkitgrey.leather = "Base.RaccoonLeather_Grey_Full";
raccoonkitgrey.head = "Base.Raccoon_Kit_Head";
raccoonkitgrey.skull = "Base.Raccoon_Skull";
raccoonkitgrey.noSkeleton = true;
raccoonkitgrey.xpPerItem = 10;
AnimalPartsDefinitions.animals["raccoonkitgrey"] = raccoonkitgrey;



-------------------
------ MEAT -------
-------------------
----- This is used to alter the meat given by the animals
----- So we can give more or less "prime" meat depending on skills/animal stats
--- the order has an importance here, the first of the list will be checked first, some maths to explain:
--- * the total % is 100, if we roll to give 20 meats, we first check the first in the list, if the baseChance is 10% (i'm not adding the skill/animal stats to simplify here) you'll have 2 of the first meat (prime cut)
--- * the remaining is then 90%, the remaining meat is 18, we roll the 2nd item, if the baseChance is 30, we'll give 90/30 = 2.7, which means in term of number of meat: 18*0.27 = 4.86 (5) meats of the 2nd category (medium cut)
--- * we have then 20 - 2 - 5 = 13 meat to give (poor cut)
--- item = the item that'll be given (it's always the same so we can simplify all the cooking recipes)
--- baseChance = the base chance of having this item given, it'll be multiplied by butchering skill and stats of the animal
--- hungerBoost = we take the base hunger of the given item and multiply it by this number (also influenced by animal stats)
--- baseName = will be the first name of the item, that + extraName will give something like Beef (Prime Cut) (Beef being baseName, extraName being (Prime Cut)
--- extraName = will be added to the item name, the full name is found in IGUI_AnimalMeat
AnimalPartsDefinitions.meat = {};
AnimalPartsDefinitions.meat["Base.Beef"] = AnimalPartsDefinitions.meat["Base.Beef"] or {};
AnimalPartsDefinitions.meat["Base.Beef"].variants = AnimalPartsDefinitions.meat["Base.Beef"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Beef"].variants, {item = "Base.Beef", baseChance = 20, hungerBoost = 3, baseName = "IGUI_AnimalMeat_Beef", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Beef"].variants, {item = "Base.Beef", baseChance = 50, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Beef", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Beef"].variants, {item = "Base.Beef", hungerBoost = 1, baseName = "IGUI_AnimalMeat_Beef", extraName = "IGUI_AnimalMeat_PoorCut"}) -- no need baseChance here as it's the last

AnimalPartsDefinitions.meat["Base.Steak"] = AnimalPartsDefinitions.meat["Base.Steak"] or {};
AnimalPartsDefinitions.meat["Base.Steak"].variants = AnimalPartsDefinitions.meat["Base.Steak"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Steak"].variants, {item = "Base.Steak", baseChance = 20, hungerBoost = 3, baseName = "IGUI_AnimalMeat_Steak", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Steak"].variants, {item = "Base.Steak", baseChance = 50, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Steak", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Steak"].variants, {item = "Base.Steak", hungerBoost = 1, baseName = "IGUI_AnimalMeat_Steak", extraName = "IGUI_AnimalMeat_PoorCut"}) -- no need baseChance here as it's the last

AnimalPartsDefinitions.meat["Base.Pork"] = AnimalPartsDefinitions.meat["Base.Pork"] or {};
AnimalPartsDefinitions.meat["Base.Pork"].variants = AnimalPartsDefinitions.meat["Base.Pork"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Pork"].variants, {item = "Base.Pork", baseChance = 20, hungerBoost = 3, baseName = "IGUI_AnimalMeat_Pork", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Pork"].variants, {item = "Base.Pork", baseChance = 50, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Pork", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Pork"].variants, {item = "Base.Pork", hungerBoost = 1, baseName = "IGUI_AnimalMeat_Pork", extraName = "IGUI_AnimalMeat_PoorCut"}) -- no need baseChance here as it's the last

AnimalPartsDefinitions.meat["Base.PorkChop"] = AnimalPartsDefinitions.meat["Base.PorkChop"] or {};
AnimalPartsDefinitions.meat["Base.PorkChop"].variants = AnimalPartsDefinitions.meat["Base.PorkChop"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.PorkChop"].variants, {item = "Base.PorkChop", baseChance = 20, hungerBoost = 3, baseName = "IGUI_AnimalMeat_PorkChop", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.PorkChop"].variants, {item = "Base.PorkChop", baseChance = 50, hungerBoost = 2, baseName = "IGUI_AnimalMeat_PorkChop", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.PorkChop"].variants, {item = "Base.PorkChop", hungerBoost = 1, baseName = "IGUI_AnimalMeat_PorkChop", extraName = "IGUI_AnimalMeat_PoorCut"}) -- no need baseChance here as it's the last

AnimalPartsDefinitions.meat["Base.MuttonChop"] = AnimalPartsDefinitions.meat["Base.MuttonChop"] or {};
AnimalPartsDefinitions.meat["Base.MuttonChop"].variants = AnimalPartsDefinitions.meat["Base.MuttonChop"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.MuttonChop"].variants, {item = "Base.MuttonChop", baseChance = 20, hungerBoost = 3, baseName = "IGUI_AnimalMeat_Mutton", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.MuttonChop"].variants, {item = "Base.MuttonChop", baseChance = 50, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Mutton", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.MuttonChop"].variants, {item = "Base.MuttonChop", hungerBoost = 1, baseName = "IGUI_AnimalMeat_Mutton", extraName = "IGUI_AnimalMeat_PoorCut"})

AnimalPartsDefinitions.meat["Base.Rabbitmeat"] = AnimalPartsDefinitions.meat["Base.Rabbitmeat"] or {};
AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants = AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants, {item = "Base.Rabbitmeat", baseChance = 20, hungerBoost = 3, baseName = "IGUI_AnimalMeat_Rabbit", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants, {item = "Base.Rabbitmeat", baseChance = 50, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Rabbit", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants, {item = "Base.Rabbitmeat", hungerBoost = 1, baseName = "IGUI_AnimalMeat_Rabbit", extraName = "IGUI_AnimalMeat_PoorCut"})

AnimalPartsDefinitions.meat["Base.Venison"] = AnimalPartsDefinitions.meat["Base.Venison"] or {};
AnimalPartsDefinitions.meat["Base.Venison"].variants = AnimalPartsDefinitions.meat["Base.Venison"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Venison"].variants, {item = "Base.Venison", baseChance = 20, hungerBoost = 3, baseName = "IGUI_AnimalMeat_Venison", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Venison"].variants, {item = "Base.Venison", baseChance = 50, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Venison", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Venison"].variants, {item = "Base.Venison", hungerBoost = 1, baseName = "IGUI_AnimalMeat_Venison", extraName = "IGUI_AnimalMeat_PoorCut"}) -- no need baseChance here as it's the last