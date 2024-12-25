--[ Used to define the animals parts you'll get when butchering it. --]

AnimalPartsDefinitions = AnimalPartsDefinitions or {};
AnimalPartsDefinitions.animals = AnimalPartsDefinitions.animals or {};

-------------------
----- CHICKEN -----
-------------------
AnimalPartsDefinitions.animals["henrhodeisland"] = AnimalPartsDefinitions.animals["henrhodeisland"] or {};
AnimalPartsDefinitions.animals["henrhodeisland"].parts = AnimalPartsDefinitions.animals["henrhodeisland"].parts or {};
table.insert(AnimalPartsDefinitions.animals["henrhodeisland"].parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(AnimalPartsDefinitions.animals["henrhodeisland"].parts, {item = "Base.ChickenWhole", nb = 1})
AnimalPartsDefinitions.animals["henrhodeisland"].bones = AnimalPartsDefinitions.animals["henrhodeisland"].bones or {};
table.insert(AnimalPartsDefinitions.animals["henrhodeisland"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
AnimalPartsDefinitions.animals["henrhodeisland"].noSkeleton = true; -- when butchering a chicken you get a whole chicken, so no skeleton on ground
AnimalPartsDefinitions.animals["henrhodeisland"].feather = "Base.ChickenFeather";
AnimalPartsDefinitions.animals["henrhodeisland"].head = "Base.Chicken_Hen_Brown_Head";
AnimalPartsDefinitions.animals["henrhodeisland"].xpPerItem = 7;

AnimalPartsDefinitions.animals["cockerelrhodeisland"] = AnimalPartsDefinitions.animals["cockerelrhodeisland"] or {};
AnimalPartsDefinitions.animals["cockerelrhodeisland"].parts = AnimalPartsDefinitions.animals["cockerelrhodeisland"].parts or {};
table.insert(AnimalPartsDefinitions.animals["cockerelrhodeisland"].parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(AnimalPartsDefinitions.animals["cockerelrhodeisland"].parts, {item = "Base.ChickenWhole", nb = 1})
AnimalPartsDefinitions.animals["cockerelrhodeisland"].bones = AnimalPartsDefinitions.animals["cockerelrhodeisland"].bones or {};
AnimalPartsDefinitions.animals["cockerelrhodeisland"].noSkeleton = true;
table.insert(AnimalPartsDefinitions.animals["cockerelrhodeisland"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
AnimalPartsDefinitions.animals["cockerelrhodeisland"].feather = "Base.ChickenFeather";
AnimalPartsDefinitions.animals["cockerelrhodeisland"].head = "Base.Chicken_Rooster_Head_Brown";
AnimalPartsDefinitions.animals["cockerelrhodeisland"].xpPerItem = 7;

AnimalPartsDefinitions.animals["chickrhodeisland"] = AnimalPartsDefinitions.animals["chickrhodeisland"] or {};
AnimalPartsDefinitions.animals["chickrhodeisland"].parts = AnimalPartsDefinitions.animals["chickrhodeisland"].parts or {};
--table.insert(AnimalPartsDefinitions.animals["chickrhodeisland"].parts, {item = "Base.ChickenFoot", nb = 2})
--table.insert(AnimalPartsDefinitions.animals["chickrhodeisland"].parts, {item = "Base.Chicken", nb = 1})
AnimalPartsDefinitions.animals["chickrhodeisland"].bones = AnimalPartsDefinitions.animals["chickrhodeisland"].bones or {};
table.insert(AnimalPartsDefinitions.animals["chickrhodeisland"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
AnimalPartsDefinitions.animals["chickrhodeisland"].noSkeleton = true;
AnimalPartsDefinitions.animals["chickrhodeisland"].feather = "Base.ChickenFeather";
AnimalPartsDefinitions.animals["chickrhodeisland"].head = "Base.Chicken_Chick_Head";
AnimalPartsDefinitions.animals["chickrhodeisland"].xpPerItem = 3;

AnimalPartsDefinitions.animals["henleghorn"] = AnimalPartsDefinitions.animals["henleghorn"] or {};
AnimalPartsDefinitions.animals["henleghorn"].parts = AnimalPartsDefinitions.animals["henleghorn"].parts or {};
table.insert(AnimalPartsDefinitions.animals["henleghorn"].parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(AnimalPartsDefinitions.animals["henleghorn"].parts, {item = "Base.ChickenWhole", nb = 1})
AnimalPartsDefinitions.animals["henleghorn"].bones = AnimalPartsDefinitions.animals["henleghorn"].bones or {};
table.insert(AnimalPartsDefinitions.animals["henleghorn"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
AnimalPartsDefinitions.animals["henleghorn"].noSkeleton = true;
AnimalPartsDefinitions.animals["henleghorn"].feather = "Base.ChickenFeather";
AnimalPartsDefinitions.animals["henleghorn"].head = "Base.Chicken_Hen_White_Head";
AnimalPartsDefinitions.animals["henleghorn"].xpPerItem = 7;

AnimalPartsDefinitions.animals["cockerelleghorn"] = AnimalPartsDefinitions.animals["cockerelleghorn"] or {};
AnimalPartsDefinitions.animals["cockerelleghorn"].parts = AnimalPartsDefinitions.animals["cockerelleghorn"].parts or {};
table.insert(AnimalPartsDefinitions.animals["cockerelleghorn"].parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(AnimalPartsDefinitions.animals["cockerelleghorn"].parts, {item = "Base.ChickenWhole", nb = 1})
AnimalPartsDefinitions.animals["cockerelleghorn"].bones = AnimalPartsDefinitions.animals["cockerelleghorn"].bones or {};
AnimalPartsDefinitions.animals["cockerelleghorn"].noSkeleton = true;
table.insert(AnimalPartsDefinitions.animals["cockerelleghorn"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
AnimalPartsDefinitions.animals["cockerelleghorn"].feather = "Base.ChickenFeather";
AnimalPartsDefinitions.animals["cockerelleghorn"].head = "Base.Chicken_Rooster_Head_White";
AnimalPartsDefinitions.animals["cockerelleghorn"].xpPerItem = 7;

AnimalPartsDefinitions.animals["chickleghorn"] = AnimalPartsDefinitions.animals["chickleghorn"] or {};
AnimalPartsDefinitions.animals["chickleghorn"].parts = AnimalPartsDefinitions.animals["chickleghorn"].parts or {};
--table.insert(AnimalPartsDefinitions.animals["chickleghorn"].parts, {item = "Base.Chicken", nb = 1})
AnimalPartsDefinitions.animals["chickleghorn"].bones = AnimalPartsDefinitions.animals["chickleghorn"].bones or {};
table.insert(AnimalPartsDefinitions.animals["chickleghorn"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
AnimalPartsDefinitions.animals["chickleghorn"].noSkeleton = true;
AnimalPartsDefinitions.animals["chickleghorn"].feather = "Base.ChickenFeather";
AnimalPartsDefinitions.animals["chickleghorn"].head = "Base.Chicken_Chick_Head";
AnimalPartsDefinitions.animals["chickleghorn"].xpPerItem = 3;

-------------------
------- COWS ------
-------------------
--- ANGUS
AnimalPartsDefinitions.animals["cowangus"] = AnimalPartsDefinitions.animals["cowangus"] or {};
AnimalPartsDefinitions.animals["cowangus"].parts = AnimalPartsDefinitions.animals["cowangus"].parts or {};
table.insert(AnimalPartsDefinitions.animals["cowangus"].parts, {item = "Base.Steak", minNb = 8, maxNb = 15})
table.insert(AnimalPartsDefinitions.animals["cowangus"].parts, {item = "Base.Beef", minNb = 8, maxNb = 15})
AnimalPartsDefinitions.animals["cowangus"].bones = AnimalPartsDefinitions.animals["cowangus"].bones or {};
table.insert(AnimalPartsDefinitions.animals["cowangus"].bones, {item = "Base.AnimalBone", minNb = 8, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["cowangus"].bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["cowangus"].leather = "Base.CowLeather_Angus_Full";
AnimalPartsDefinitions.animals["cowangus"].head = "Base.Cow_Head_Angus";
AnimalPartsDefinitions.animals["cowangus"].xpPerItem = 25;

AnimalPartsDefinitions.animals["bullangus"] = AnimalPartsDefinitions.animals["bullangus"] or {};
AnimalPartsDefinitions.animals["bullangus"].parts = AnimalPartsDefinitions.animals["bullangus"].parts or {};
table.insert(AnimalPartsDefinitions.animals["bullangus"].parts, {item = "Base.Steak", minNb = 8, maxNb = 15})
table.insert(AnimalPartsDefinitions.animals["bullangus"].parts, {item = "Base.Beef", minNb = 8, maxNb = 15})
AnimalPartsDefinitions.animals["bullangus"].bones = AnimalPartsDefinitions.animals["bullangus"].bones or {};
table.insert(AnimalPartsDefinitions.animals["bullangus"].bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["bullangus"].bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["bullangus"].leather = "Base.CowLeather_Angus_Full";
AnimalPartsDefinitions.animals["bullangus"].head = "Base.Bull_Head_Angus";
AnimalPartsDefinitions.animals["bullangus"].xpPerItem = 25;

AnimalPartsDefinitions.animals["cowcalfangus"] = AnimalPartsDefinitions.animals["cowcalfangus"] or {};
AnimalPartsDefinitions.animals["cowcalfangus"].parts = AnimalPartsDefinitions.animals["cowcalfangus"].parts or {};
table.insert(AnimalPartsDefinitions.animals["cowcalfangus"].parts, {item = "Base.Steak", minNb = 3, maxNb = 6})
table.insert(AnimalPartsDefinitions.animals["cowcalfangus"].parts, {item = "Base.Beef", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["cowcalfangus"].bones = AnimalPartsDefinitions.animals["cowcalfangus"].bones or {};
table.insert(AnimalPartsDefinitions.animals["cowcalfangus"].bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
AnimalPartsDefinitions.animals["cowcalfangus"].leather = "Base.CalfLeather_Angus_Full";
AnimalPartsDefinitions.animals["cowcalfangus"].head = "Base.Calf_Head_Angus";
AnimalPartsDefinitions.animals["cowcalfangus"].xpPerItem = 18;

--- SIMMENTAL
AnimalPartsDefinitions.animals["cowsimmental"] = AnimalPartsDefinitions.animals["cowsimmental"] or {};
AnimalPartsDefinitions.animals["cowsimmental"].parts = AnimalPartsDefinitions.animals["cowsimmental"].parts or {};
table.insert(AnimalPartsDefinitions.animals["cowsimmental"].parts, {item = "Base.Steak", minNb = 8, maxNb = 15})
table.insert(AnimalPartsDefinitions.animals["cowsimmental"].parts, {item = "Base.Beef", minNb = 8, maxNb = 15})
AnimalPartsDefinitions.animals["cowsimmental"].bones = AnimalPartsDefinitions.animals["cowsimmental"].bones or {};
table.insert(AnimalPartsDefinitions.animals["cowsimmental"].bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["cowsimmental"].bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["cowsimmental"].leather = "Base.CowLeather_Simmental_Full";
AnimalPartsDefinitions.animals["cowsimmental"].head = "Base.Cow_Head_Simmental";
AnimalPartsDefinitions.animals["cowsimmental"].xpPerItem = 25;

AnimalPartsDefinitions.animals["bullsimmental"] = AnimalPartsDefinitions.animals["bullsimmental"] or {};
AnimalPartsDefinitions.animals["bullsimmental"].parts = AnimalPartsDefinitions.animals["bullsimmental"].parts or {};
table.insert(AnimalPartsDefinitions.animals["bullsimmental"].parts, {item = "Base.Steak", minNb = 8, maxNb = 15})
table.insert(AnimalPartsDefinitions.animals["bullsimmental"].parts, {item = "Base.Beef", minNb = 8, maxNb = 15})
AnimalPartsDefinitions.animals["bullsimmental"].bones = AnimalPartsDefinitions.animals["bullsimmental"].bones or {};
table.insert(AnimalPartsDefinitions.animals["bullsimmental"].bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["bullsimmental"].bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["bullsimmental"].leather = "Base.CowLeather_Simmental_Full";
AnimalPartsDefinitions.animals["bullsimmental"].head = "Base.Bull_Head_Simmental";
AnimalPartsDefinitions.animals["bullsimmental"].xpPerItem = 25;

AnimalPartsDefinitions.animals["cowcalfsimmental"] = AnimalPartsDefinitions.animals["cowcalfsimmental"] or {};
AnimalPartsDefinitions.animals["cowcalfsimmental"].parts = AnimalPartsDefinitions.animals["cowcalfsimmental"].parts or {};
table.insert(AnimalPartsDefinitions.animals["cowcalfsimmental"].parts, {item = "Base.Steak", minNb = 3, maxNb = 6})
table.insert(AnimalPartsDefinitions.animals["cowcalfsimmental"].parts, {item = "Base.Beef", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["cowcalfsimmental"].bones = AnimalPartsDefinitions.animals["cowcalfsimmental"].bones or {};
table.insert(AnimalPartsDefinitions.animals["cowcalfsimmental"].bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
AnimalPartsDefinitions.animals["cowcalfsimmental"].leather = "Base.CalfLeather_Simmental_Full";
AnimalPartsDefinitions.animals["cowcalfsimmental"].head = "Base.Calf_Head_Simmental";
AnimalPartsDefinitions.animals["cowcalfsimmental"].xpPerItem = 18;

--- HOLSTEIN
AnimalPartsDefinitions.animals["cowholstein"] = AnimalPartsDefinitions.animals["cowholstein"] or {};
AnimalPartsDefinitions.animals["cowholstein"].parts = AnimalPartsDefinitions.animals["cowholstein"].parts or {};
table.insert(AnimalPartsDefinitions.animals["cowholstein"].parts, {item = "Base.Steak", minNb = 8, maxNb = 15})
table.insert(AnimalPartsDefinitions.animals["cowholstein"].parts, {item = "Base.Beef", minNb = 8, maxNb = 15})
AnimalPartsDefinitions.animals["cowholstein"].bones = AnimalPartsDefinitions.animals["cowholstein"].bones or {};
table.insert(AnimalPartsDefinitions.animals["cowholstein"].bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["cowholstein"].bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["cowholstein"].leather = "Base.CowLeather_Holstein_Full";
AnimalPartsDefinitions.animals["cowholstein"].head = "Base.Cow_Head_Holstein";
AnimalPartsDefinitions.animals["cowholstein"].xpPerItem = 25;

AnimalPartsDefinitions.animals["bullholstein"] = AnimalPartsDefinitions.animals["bullholstein"] or {};
AnimalPartsDefinitions.animals["bullholstein"].parts = AnimalPartsDefinitions.animals["bullholstein"].parts or {};
table.insert(AnimalPartsDefinitions.animals["bullholstein"].parts, {item = "Base.Steak", minNb = 8, maxNb = 15})
table.insert(AnimalPartsDefinitions.animals["bullholstein"].parts, {item = "Base.Beef", minNb = 8, maxNb = 15})
AnimalPartsDefinitions.animals["bullholstein"].bones = AnimalPartsDefinitions.animals["bullholstein"].bones or {};
table.insert(AnimalPartsDefinitions.animals["bullholstein"].bones, {item = "Base.AnimalBone", minNb = 7, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["bullholstein"].bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["bullholstein"].leather = "Base.CowLeather_Holstein_Full";
AnimalPartsDefinitions.animals["bullholstein"].head = "Base.Bull_Head_Holstein";
AnimalPartsDefinitions.animals["bullholstein"].xpPerItem = 25;

AnimalPartsDefinitions.animals["cowcalfholstein"] = AnimalPartsDefinitions.animals["cowcalfholstein"] or {};
AnimalPartsDefinitions.animals["cowcalfholstein"].parts = AnimalPartsDefinitions.animals["cowcalfholstein"].parts or {};
table.insert(AnimalPartsDefinitions.animals["cowcalfholstein"].parts, {item = "Base.Steak", minNb = 3, maxNb = 6})
table.insert(AnimalPartsDefinitions.animals["cowcalfholstein"].parts, {item = "Base.Beef", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["cowcalfholstein"].bones = AnimalPartsDefinitions.animals["cowcalfholstein"].bones or {};
table.insert(AnimalPartsDefinitions.animals["cowcalfholstein"].bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
AnimalPartsDefinitions.animals["cowcalfholstein"].leather = "Base.CalfLeather_Holstein_Full";
AnimalPartsDefinitions.animals["cowcalfholstein"].head = "Base.Calf_Head_Holstein";
AnimalPartsDefinitions.animals["cowcalfholstein"].xpPerItem = 18;

-------------------
------- PIGS ------
-------------------
--- LANDRACE
AnimalPartsDefinitions.animals["sowlandrace"] = AnimalPartsDefinitions.animals["sowlandrace"] or {};
AnimalPartsDefinitions.animals["sowlandrace"].parts = AnimalPartsDefinitions.animals["sowlandrace"].parts or {};
table.insert(AnimalPartsDefinitions.animals["sowlandrace"].parts, {item = "Base.PorkChop", minNb = 6, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["sowlandrace"].parts, {item = "Base.Pork", minNb = 6, maxNb = 10})
AnimalPartsDefinitions.animals["sowlandrace"].bones = AnimalPartsDefinitions.animals["sowlandrace"].bones or {};
table.insert(AnimalPartsDefinitions.animals["sowlandrace"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["sowlandrace"].bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["sowlandrace"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["sowlandrace"].leather = "Base.PigLeather_Landrace_Full";
AnimalPartsDefinitions.animals["sowlandrace"].head = "Base.Pig_Sow_Head_Pink";
AnimalPartsDefinitions.animals["sowlandrace"].xpPerItem = 18;

AnimalPartsDefinitions.animals["boarlandrace"] = AnimalPartsDefinitions.animals["boarlandrace"] or {};
AnimalPartsDefinitions.animals["boarlandrace"].parts = AnimalPartsDefinitions.animals["boarlandrace"].parts or {};
table.insert(AnimalPartsDefinitions.animals["boarlandrace"].parts, {item = "Base.PorkChop", minNb = 6, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["boarlandrace"].parts, {item = "Base.Pork", minNb = 6, maxNb = 10})
AnimalPartsDefinitions.animals["boarlandrace"].bones = AnimalPartsDefinitions.animals["boarlandrace"].bones or {};
table.insert(AnimalPartsDefinitions.animals["boarlandrace"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["boarlandrace"].bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["boarlandrace"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["boarlandrace"].leather = "Base.PigLeather_Landrace_Full";
AnimalPartsDefinitions.animals["boarlandrace"].head = "Base.Pig_Boar_Head_Pink";
AnimalPartsDefinitions.animals["boarlandrace"].xpPerItem = 18;

AnimalPartsDefinitions.animals["pigletlandrace"] = AnimalPartsDefinitions.animals["pigletlandrace"] or {};
AnimalPartsDefinitions.animals["pigletlandrace"].parts = AnimalPartsDefinitions.animals["pigletlandrace"].parts or {};
table.insert(AnimalPartsDefinitions.animals["pigletlandrace"].parts, {item = "Base.PorkChop", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["pigletlandrace"].parts, {item = "Base.Pork", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["pigletlandrace"].bones = AnimalPartsDefinitions.animals["pigletlandrace"].bones or {};
table.insert(AnimalPartsDefinitions.animals["pigletlandrace"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
AnimalPartsDefinitions.animals["pigletlandrace"].leather = "Base.PigletLeather_Landrace_Full";
AnimalPartsDefinitions.animals["pigletlandrace"].head = "Base.Pig_Piglet_Head_Pink";
AnimalPartsDefinitions.animals["pigletlandrace"].xpPerItem = 12;

--- LARGE BLACK
AnimalPartsDefinitions.animals["sowlargeblack"] = AnimalPartsDefinitions.animals["sowlargeblack"] or {};
AnimalPartsDefinitions.animals["sowlargeblack"].parts = AnimalPartsDefinitions.animals["sowlargeblack"].parts or {};
table.insert(AnimalPartsDefinitions.animals["sowlargeblack"].parts, {item = "Base.PorkChop", minNb = 6, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["sowlargeblack"].parts, {item = "Base.Pork", minNb = 6, maxNb = 10})
AnimalPartsDefinitions.animals["sowlargeblack"].bones = AnimalPartsDefinitions.animals["sowlargeblack"].bones or {};
table.insert(AnimalPartsDefinitions.animals["sowlargeblack"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["sowlargeblack"].bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["sowlargeblack"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["sowlargeblack"].leather = "Base.PigLeather_Black_Full";
AnimalPartsDefinitions.animals["sowlargeblack"].head = "Base.Pig_Sow_Head_Black";
AnimalPartsDefinitions.animals["sowlargeblack"].xpPerItem = 18;

AnimalPartsDefinitions.animals["boarlargeblack"] = AnimalPartsDefinitions.animals["boarlargeblack"] or {};
AnimalPartsDefinitions.animals["boarlargeblack"].parts = AnimalPartsDefinitions.animals["boarlargeblack"].parts or {};
table.insert(AnimalPartsDefinitions.animals["boarlargeblack"].parts, {item = "Base.PorkChop", minNb = 6, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["boarlargeblack"].parts, {item = "Base.Pork", minNb = 6, maxNb = 10})
AnimalPartsDefinitions.animals["boarlargeblack"].bones = AnimalPartsDefinitions.animals["boarlargeblack"].bones or {};
table.insert(AnimalPartsDefinitions.animals["boarlargeblack"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["boarlargeblack"].bones, {item = "Base.AnimalBone", minNb = 4, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["boarlargeblack"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["boarlargeblack"].leather = "Base.PigLeather_Black_Full";
AnimalPartsDefinitions.animals["boarlargeblack"].head = "Base.Pig_Boar_Head_Black";
AnimalPartsDefinitions.animals["boarlargeblack"].xpPerItem = 18;

AnimalPartsDefinitions.animals["pigletlargeblack"] = AnimalPartsDefinitions.animals["pigletlargeblack"] or {};
AnimalPartsDefinitions.animals["pigletlargeblack"].parts = AnimalPartsDefinitions.animals["pigletlargeblack"].parts or {};
table.insert(AnimalPartsDefinitions.animals["pigletlargeblack"].parts, {item = "Base.PorkChop", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["pigletlargeblack"].parts, {item = "Base.Pork", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["pigletlargeblack"].bones = AnimalPartsDefinitions.animals["pigletlargeblack"].bones or {};
table.insert(AnimalPartsDefinitions.animals["pigletlargeblack"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
AnimalPartsDefinitions.animals["pigletlargeblack"].leather = "Base.PigletLeather_Black_Full";
AnimalPartsDefinitions.animals["pigletlargeblack"].head = "Base.Pig_Piglet_Head_Black";
AnimalPartsDefinitions.animals["pigletlargeblack"].xpPerItem = 12;

-------------------
----- TURKEY ------
-------------------
AnimalPartsDefinitions.animals["turkeyhenmeleagris"] = AnimalPartsDefinitions.animals["turkeyhenmeleagris"] or {};
AnimalPartsDefinitions.animals["turkeyhenmeleagris"].parts = AnimalPartsDefinitions.animals["turkeyhenmeleagris"].parts or {};
--table.insert(AnimalPartsDefinitions.animals["turkeyhenmeleagris"].parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(AnimalPartsDefinitions.animals["turkeyhenmeleagris"].parts, {item = "Base.TurkeyWhole", nb = 1})
AnimalPartsDefinitions.animals["turkeyhenmeleagris"].bones = AnimalPartsDefinitions.animals["turkeyhenmeleagris"].bones or {};
table.insert(AnimalPartsDefinitions.animals["turkeyhenmeleagris"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
AnimalPartsDefinitions.animals["turkeyhenmeleagris"].noSkeleton = true;
AnimalPartsDefinitions.animals["turkeyhenmeleagris"].feather = "Base.TurkeyFeather";
AnimalPartsDefinitions.animals["turkeyhenmeleagris"].head = "Base.Turkey_Hen_Head";
AnimalPartsDefinitions.animals["turkeyhenmeleagris"].xpPerItem = 7;

AnimalPartsDefinitions.animals["gobblersmeleagris"] = AnimalPartsDefinitions.animals["gobblersmeleagris"] or {};
AnimalPartsDefinitions.animals["gobblersmeleagris"].parts = AnimalPartsDefinitions.animals["gobblersmeleagris"].parts or {};
--table.insert(AnimalPartsDefinitions.animals["gobblersmeleagris"].parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(AnimalPartsDefinitions.animals["gobblersmeleagris"].parts, {item = "Base.TurkeyWhole", nb = 1})
AnimalPartsDefinitions.animals["gobblersmeleagris"].bones = AnimalPartsDefinitions.animals["gobblersmeleagris"].bones or {};
table.insert(AnimalPartsDefinitions.animals["gobblersmeleagris"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 6})
AnimalPartsDefinitions.animals["gobblersmeleagris"].noSkeleton = true;
AnimalPartsDefinitions.animals["gobblersmeleagris"].feather = "Base.TurkeyFeather";
AnimalPartsDefinitions.animals["gobblersmeleagris"].head = "Base.Turkey_Gobbler_Head";
AnimalPartsDefinitions.animals["gobblersmeleagris"].xpPerItem = 7;

AnimalPartsDefinitions.animals["turkeypoultmeleagris"] = AnimalPartsDefinitions.animals["turkeypoultmeleagris"] or {};
AnimalPartsDefinitions.animals["turkeypoultmeleagris"].parts = AnimalPartsDefinitions.animals["turkeypoultmeleagris"].parts or {};
--table.insert(AnimalPartsDefinitions.animals["turkeypoultmeleagris"].parts, {item = "Base.ChickenFoot", nb = 2})
table.insert(AnimalPartsDefinitions.animals["turkeypoultmeleagris"].parts, {item = "Base.TurkeyWhole", nb = 1})
AnimalPartsDefinitions.animals["turkeypoultmeleagris"].bones = AnimalPartsDefinitions.animals["turkeypoultmeleagris"].bones or {};
table.insert(AnimalPartsDefinitions.animals["turkeyhenmeleagris"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
AnimalPartsDefinitions.animals["turkeyhenmeleagris"].noSkeleton = true;
AnimalPartsDefinitions.animals["turkeypoultmeleagris"].feather = "Base.TurkeyFeather";
AnimalPartsDefinitions.animals["turkeypoultmeleagris"].head = "Base.Turkey_Poult_Head";
AnimalPartsDefinitions.animals["turkeypoultmeleagris"].xpPerItem = 3;

-------------------
------ SHEEP ------
-------------------
--- SUFFOLK
AnimalPartsDefinitions.animals["ewesuffolk"] = AnimalPartsDefinitions.animals["ewesuffolk"] or {};
AnimalPartsDefinitions.animals["ewesuffolk"].parts = AnimalPartsDefinitions.animals["ewesuffolk"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ewesuffolk"].parts, {item = "Base.MuttonChop", minNb = 9, maxNb = 15})
AnimalPartsDefinitions.animals["ewesuffolk"].bones = AnimalPartsDefinitions.animals["ewesuffolk"].bones or {};
table.insert(AnimalPartsDefinitions.animals["ewesuffolk"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["ewesuffolk"].bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["ewesuffolk"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["ewesuffolk"].leather = "Base.SheepLeather_Full";
AnimalPartsDefinitions.animals["ewesuffolk"].head = "Base.Sheep_Ewe_Head_Black";
AnimalPartsDefinitions.animals["ewesuffolk"].xpPerItem = 10;

AnimalPartsDefinitions.animals["ramsuffolk"] = AnimalPartsDefinitions.animals["ramsuffolk"] or {};
AnimalPartsDefinitions.animals["ramsuffolk"].parts = AnimalPartsDefinitions.animals["ramsuffolk"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ramsuffolk"].parts, {item = "Base.MuttonChop", minNb = 9, maxNb = 15})
AnimalPartsDefinitions.animals["ramsuffolk"].bones = AnimalPartsDefinitions.animals["ramsuffolk"].bones or {};
table.insert(AnimalPartsDefinitions.animals["ramsuffolk"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["ramsuffolk"].bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["ramsuffolk"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["ramsuffolk"].leather = "Base.SheepLeather_Full";
AnimalPartsDefinitions.animals["ramsuffolk"].head = "Base.Sheep_Ram_Head_Black";
AnimalPartsDefinitions.animals["ramsuffolk"].xpPerItem = 10;

AnimalPartsDefinitions.animals["lambsuffolk"] = AnimalPartsDefinitions.animals["lambsuffolk"] or {};
AnimalPartsDefinitions.animals["lambsuffolk"].parts = AnimalPartsDefinitions.animals["lambsuffolk"].parts or {};
table.insert(AnimalPartsDefinitions.animals["lambsuffolk"].parts, {item = "Base.MuttonChop", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["lambsuffolk"].bones = AnimalPartsDefinitions.animals["lambsuffolk"].bones or {};
table.insert(AnimalPartsDefinitions.animals["lambsuffolk"].bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["lambsuffolk"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["lambsuffolk"].leather = "Base.LambLeather_Full";
AnimalPartsDefinitions.animals["lambsuffolk"].head = "Base.Sheep_Lamb_Head_Black";
AnimalPartsDefinitions.animals["lambsuffolk"].xpPerItem = 6;

-- RAMBOUILLET
AnimalPartsDefinitions.animals["ewerambouillet"] = AnimalPartsDefinitions.animals["ewerambouillet"] or {};
AnimalPartsDefinitions.animals["ewerambouillet"].parts = AnimalPartsDefinitions.animals["ewerambouillet"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ewerambouillet"].parts, {item = "Base.MuttonChop", minNb = 9, maxNb = 15})
AnimalPartsDefinitions.animals["ewerambouillet"].bones = AnimalPartsDefinitions.animals["ewerambouillet"].bones or {};
table.insert(AnimalPartsDefinitions.animals["ewerambouillet"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["ewerambouillet"].bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["ewerambouillet"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["ewerambouillet"].leather = "Base.SheepLeather_Full";
AnimalPartsDefinitions.animals["ewerambouillet"].head = "Base.Sheep_Ewe_Head_White";
AnimalPartsDefinitions.animals["ewerambouillet"].xpPerItem = 10;

AnimalPartsDefinitions.animals["ramrambouillet"] = AnimalPartsDefinitions.animals["ramrambouillet"] or {};
AnimalPartsDefinitions.animals["ramrambouillet"].parts = AnimalPartsDefinitions.animals["ramrambouillet"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ramrambouillet"].parts, {item = "Base.MuttonChop", minNb = 9, maxNb = 15})
AnimalPartsDefinitions.animals["ramrambouillet"].bones = AnimalPartsDefinitions.animals["ramrambouillet"].bones or {};
table.insert(AnimalPartsDefinitions.animals["ramrambouillet"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["ramrambouillet"].bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["ramrambouillet"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["ramrambouillet"].leather = "Base.SheepLeather_Full";
AnimalPartsDefinitions.animals["ramrambouillet"].head = "Base.Sheep_Ram_Head_White";
AnimalPartsDefinitions.animals["ramrambouillet"].xpPerItem = 10;

AnimalPartsDefinitions.animals["lambrambouillet"] = AnimalPartsDefinitions.animals["lambrambouillet"] or {};
AnimalPartsDefinitions.animals["lambrambouillet"].parts = AnimalPartsDefinitions.animals["lambrambouillet"].parts or {};
table.insert(AnimalPartsDefinitions.animals["lambrambouillet"].parts, {item = "Base.MuttonChop", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["lambrambouillet"].bones = AnimalPartsDefinitions.animals["lambrambouillet"].bones or {};
table.insert(AnimalPartsDefinitions.animals["lambrambouillet"].bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["lambrambouillet"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["lambrambouillet"].leather = "Base.LambLeather_Full";
AnimalPartsDefinitions.animals["lambrambouillet"].head = "Base.Sheep_Lamb_Head_White";
AnimalPartsDefinitions.animals["lambrambouillet"].xpPerItem = 6;

-- FRIESIAN
AnimalPartsDefinitions.animals["ewefriesian"] = AnimalPartsDefinitions.animals["ewefriesian"] or {};
AnimalPartsDefinitions.animals["ewefriesian"].parts = AnimalPartsDefinitions.animals["ewefriesian"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ewefriesian"].parts, {item = "Base.MuttonChop", minNb = 9, maxNb = 15})
AnimalPartsDefinitions.animals["ewefriesian"].bones = AnimalPartsDefinitions.animals["ewefriesian"].bones or {};
table.insert(AnimalPartsDefinitions.animals["ewefriesian"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["ewefriesian"].bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["ewefriesian"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["ewefriesian"].leather = "Base.SheepLeather_Full";
AnimalPartsDefinitions.animals["ewefriesian"].head = "Base.Sheep_Ewe_Head_White";
AnimalPartsDefinitions.animals["ewefriesian"].xpPerItem = 10;

AnimalPartsDefinitions.animals["ramfriesian"] = AnimalPartsDefinitions.animals["ramfriesian"] or {};
AnimalPartsDefinitions.animals["ramfriesian"].parts = AnimalPartsDefinitions.animals["ramfriesian"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ramfriesian"].parts, {item = "Base.MuttonChop", minNb = 9, maxNb = 15})
AnimalPartsDefinitions.animals["ramfriesian"].bones = AnimalPartsDefinitions.animals["ramfriesian"].bones or {};
table.insert(AnimalPartsDefinitions.animals["ramfriesian"].bones, {item = "Base.SmallAnimalBone", minNb = 2, maxNb = 4})
table.insert(AnimalPartsDefinitions.animals["ramfriesian"].bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 7})
table.insert(AnimalPartsDefinitions.animals["ramfriesian"].bones, {item = "Base.LargeAnimalBone", minNb = 1, maxNb = 2})
AnimalPartsDefinitions.animals["ramfriesian"].leather = "Base.SheepLeather_Full";
AnimalPartsDefinitions.animals["ramfriesian"].head = "Base.Sheep_Ram_Head_White";
AnimalPartsDefinitions.animals["ramfriesian"].xpPerItem = 10;

AnimalPartsDefinitions.animals["lambfriesian"] = AnimalPartsDefinitions.animals["lambfriesian"] or {};
AnimalPartsDefinitions.animals["lambfriesian"].parts = AnimalPartsDefinitions.animals["lambfriesian"].parts or {};
table.insert(AnimalPartsDefinitions.animals["lambfriesian"].parts, {item = "Base.MuttonChop", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["lambfriesian"].bones = AnimalPartsDefinitions.animals["lambrambouillet"].bones or {};
table.insert(AnimalPartsDefinitions.animals["lambfriesian"].bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["lambfriesian"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["lambfriesian"].leather = "Base.LambLeather_Full";
AnimalPartsDefinitions.animals["lambfriesian"].head = "Base.Sheep_Lamb_Head_White";
AnimalPartsDefinitions.animals["lambfriesian"].xpPerItem = 6;

-------------------
------- DEER ------
-------------------
AnimalPartsDefinitions.animals["doewhitetailed"] = AnimalPartsDefinitions.animals["doewhitetailed"] or {};
AnimalPartsDefinitions.animals["doewhitetailed"].parts = AnimalPartsDefinitions.animals["doewhitetailed"].parts or {};
table.insert(AnimalPartsDefinitions.animals["doewhitetailed"].parts, {item = "Base.Venison", minNb = 8, maxNb = 15})
AnimalPartsDefinitions.animals["doewhitetailed"].bones = AnimalPartsDefinitions.animals["doewhitetailed"].bones or {};
table.insert(AnimalPartsDefinitions.animals["doewhitetailed"].bones, {item = "Base.AnimalBone", minNb = 5, maxNb = 8})
table.insert(AnimalPartsDefinitions.animals["doewhitetailed"].bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["doewhitetailed"].leather = "Base.DeerLeather_Full";
AnimalPartsDefinitions.animals["doewhitetailed"].head = "Base.Deer_Doe_Head";
AnimalPartsDefinitions.animals["doewhitetailed"].xpPerItem = 25;

AnimalPartsDefinitions.animals["buckwhitetailed"] = AnimalPartsDefinitions.animals["buckwhitetailed"] or {};
AnimalPartsDefinitions.animals["buckwhitetailed"].parts = AnimalPartsDefinitions.animals["buckwhitetailed"].parts or {};
table.insert(AnimalPartsDefinitions.animals["buckwhitetailed"].parts, {item = "Base.Venison", minNb = 9, maxNb = 17})
AnimalPartsDefinitions.animals["buckwhitetailed"].bones = AnimalPartsDefinitions.animals["buckwhitetailed"].bones or {};
table.insert(AnimalPartsDefinitions.animals["buckwhitetailed"].bones, {item = "Base.AnimalBone", minNb = 5, maxNb = 8})
table.insert(AnimalPartsDefinitions.animals["buckwhitetailed"].bones, {item = "Base.LargeAnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["buckwhitetailed"].leather = "Base.DeerLeather_Full";
AnimalPartsDefinitions.animals["buckwhitetailed"].head = "Base.Deer_Buck_Head";
AnimalPartsDefinitions.animals["buckwhitetailed"].xpPerItem = 25;

AnimalPartsDefinitions.animals["fawnwhitetailed"] = AnimalPartsDefinitions.animals["fawnwhitetailed"] or {};
AnimalPartsDefinitions.animals["fawnwhitetailed"].parts = AnimalPartsDefinitions.animals["fawnwhitetailed"].parts or {};
table.insert(AnimalPartsDefinitions.animals["fawnwhitetailed"].parts, {item = "Base.Venison", minNb = 2, maxNb = 4})
AnimalPartsDefinitions.animals["fawnwhitetailed"].bones = AnimalPartsDefinitions.animals["fawnwhitetailed"].bones or {};
table.insert(AnimalPartsDefinitions.animals["fawnwhitetailed"].bones, {item = "Base.SmallAnimalBone", minNb = 5, maxNb = 10})
table.insert(AnimalPartsDefinitions.animals["fawnwhitetailed"].bones, {item = "Base.AnimalBone", minNb = 3, maxNb = 5})
AnimalPartsDefinitions.animals["fawnwhitetailed"].leather = "Base.FawnLeather_Full";
AnimalPartsDefinitions.animals["fawnwhitetailed"].head = "Base.Deer_Fawn_Head";
AnimalPartsDefinitions.animals["fawnwhitetailed"].xpPerItem = 18;

-------------------
----- RABBITS -----
-------------------

-- SWAMP
AnimalPartsDefinitions.animals["rabdoeswamp"] = AnimalPartsDefinitions.animals["rabdoeswamp"] or {};
AnimalPartsDefinitions.animals["rabdoeswamp"].parts = AnimalPartsDefinitions.animals["rabdoeswamp"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabdoeswamp"].parts, {item = "Base.Rabbitmeat", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabdoeswamp"].bones = AnimalPartsDefinitions.animals["rabdoeswamp"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabdoeswamp"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(AnimalPartsDefinitions.animals["rabdoeswamp"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["rabdoeswamp"].head = "Base.Rabbit_Head_Swamp";
AnimalPartsDefinitions.animals["rabdoeswamp"].xpPerItem = 7;

AnimalPartsDefinitions.animals["rabbuckswamp"] = AnimalPartsDefinitions.animals["rabbuckswamp"] or {};
AnimalPartsDefinitions.animals["rabbuckswamp"].parts = AnimalPartsDefinitions.animals["rabbuckswamp"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabbuckswamp"].parts, {item = "Base.Rabbitmeat", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabbuckswamp"].bones = AnimalPartsDefinitions.animals["rabbuckswamp"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabbuckswamp"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(AnimalPartsDefinitions.animals["rabbuckswamp"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["rabbuckswamp"].head = "Base.Rabbit_Head_Swamp";
AnimalPartsDefinitions.animals["rabbuckswamp"].xpPerItem = 7;

AnimalPartsDefinitions.animals["rabkittenswamp"] = AnimalPartsDefinitions.animals["rabkittenswamp"] or {};
AnimalPartsDefinitions.animals["rabkittenswamp"].parts = AnimalPartsDefinitions.animals["rabkittenswamp"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabkittenswamp"].parts, {item = "Base.Rabbitmeat", minNb = 1, maxNb = 3})
AnimalPartsDefinitions.animals["rabkittenswamp"].bones = AnimalPartsDefinitions.animals["rabkittenswamp"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabkittenswamp"].bones, {item = "Base.SmallAnimalBone", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabkittenswamp"].head = "Base.Rabbit_Kitten_Head_Swamp";
AnimalPartsDefinitions.animals["rabkittenswamp"].xpPerItem = 3;

-- APPALACHIAN
AnimalPartsDefinitions.animals["rabdoeappalachian"] = AnimalPartsDefinitions.animals["rabdoeappalachian"] or {};
AnimalPartsDefinitions.animals["rabdoeappalachian"].parts = AnimalPartsDefinitions.animals["rabdoeappalachian"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabdoeappalachian"].parts, {item = "Base.Rabbitmeat", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabdoeappalachian"].bones = AnimalPartsDefinitions.animals["rabdoeappalachian"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabdoeappalachian"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(AnimalPartsDefinitions.animals["rabdoeappalachian"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["rabdoeappalachian"].head = "Base.Rabbit_Head_Appalachian";
AnimalPartsDefinitions.animals["rabdoeappalachian"].xpPerItem = 7;

AnimalPartsDefinitions.animals["rabbuckappalachian"] = AnimalPartsDefinitions.animals["rabbuckappalachian"] or {};
AnimalPartsDefinitions.animals["rabbuckappalachian"].parts = AnimalPartsDefinitions.animals["rabbuckappalachian"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabbuckappalachian"].parts, {item = "Base.Rabbitmeat", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabbuckappalachian"].bones = AnimalPartsDefinitions.animals["rabbuckappalachian"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabbuckappalachian"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(AnimalPartsDefinitions.animals["rabbuckappalachian"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["rabbuckappalachian"].head = "Base.Rabbit_Head_Appalachian";
AnimalPartsDefinitions.animals["rabbuckappalachian"].xpPerItem = 7;

AnimalPartsDefinitions.animals["rabkittenappalachian"] = AnimalPartsDefinitions.animals["rabkittenappalachian"] or {};
AnimalPartsDefinitions.animals["rabkittenappalachian"].parts = AnimalPartsDefinitions.animals["rabkittenappalachian"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabkittenappalachian"].parts, {item = "Base.Rabbitmeat", minNb = 1, maxNb = 3})
AnimalPartsDefinitions.animals["rabkittenappalachian"].bones = AnimalPartsDefinitions.animals["rabkittenappalachian"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabkittenappalachian"].bones, {item = "Base.SmallAnimalBone", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabkittenappalachian"].head = "Base.Rabbit_Kitten_Head_Appalachian";
AnimalPartsDefinitions.animals["rabkittenappalachian"].xpPerItem = 3;

-- COTTON TAIL
AnimalPartsDefinitions.animals["rabdoecottontail"] = AnimalPartsDefinitions.animals["rabdoecottontail"] or {};
AnimalPartsDefinitions.animals["rabdoecottontail"].parts = AnimalPartsDefinitions.animals["rabdoecottontail"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabdoecottontail"].parts, {item = "Base.Rabbitmeat", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabdoecottontail"].bones = AnimalPartsDefinitions.animals["rabdoecottontail"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabdoecottontail"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(AnimalPartsDefinitions.animals["rabdoecottontail"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["rabdoecottontail"].head = "Base.Rabbit_Head_CottonTail";
AnimalPartsDefinitions.animals["rabdoecottontail"].xpPerItem = 7;

AnimalPartsDefinitions.animals["rabbuckcottontail"] = AnimalPartsDefinitions.animals["rabbuckcottontail"] or {};
AnimalPartsDefinitions.animals["rabbuckcottontail"].parts = AnimalPartsDefinitions.animals["rabbuckcottontail"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabbuckcottontail"].parts, {item = "Base.Rabbitmeat", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabbuckcottontail"].bones = AnimalPartsDefinitions.animals["rabbuckcottontail"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabbuckcottontail"].bones, {item = "Base.SmallAnimalBone", minNb = 4, maxNb = 8})
table.insert(AnimalPartsDefinitions.animals["rabbuckcottontail"].bones, {item = "Base.AnimalBone", minNb = 0, maxNb = 2})
AnimalPartsDefinitions.animals["rabbuckcottontail"].head = "Base.Rabbit_Head_CottonTail";
AnimalPartsDefinitions.animals["rabbuckcottontail"].xpPerItem = 7;

AnimalPartsDefinitions.animals["rabkittencottontail"] = AnimalPartsDefinitions.animals["rabkittencottontail"] or {};
AnimalPartsDefinitions.animals["rabkittencottontail"].parts = AnimalPartsDefinitions.animals["rabkittencottontail"].parts or {};
table.insert(AnimalPartsDefinitions.animals["rabkittencottontail"].parts, {item = "Base.Rabbitmeat", minNb = 1, maxNb = 3})
AnimalPartsDefinitions.animals["rabkittencottontail"].bones = AnimalPartsDefinitions.animals["rabkittencottontail"].bones or {};
table.insert(AnimalPartsDefinitions.animals["rabkittencottontail"].bones, {item = "Base.SmallAnimalBone", minNb = 3, maxNb = 6})
AnimalPartsDefinitions.animals["rabkittencottontail"].head = "Base.Rabbit_Kitten_Head_CottonTail";
AnimalPartsDefinitions.animals["rabkittencottontail"].xpPerItem = 3;

-------------------
------ RATS -------
-------------------
AnimalPartsDefinitions.animals["ratfemalegrey"] = AnimalPartsDefinitions.animals["ratfemalegrey"] or {};
AnimalPartsDefinitions.animals["ratfemalegrey"].parts = AnimalPartsDefinitions.animals["ratfemalegrey"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ratfemalegrey"].parts, {item = "Base.DeadRatSkinned", nb = 1})
AnimalPartsDefinitions.animals["ratfemalegrey"].noSkeleton = true;
AnimalPartsDefinitions.animals["ratfemalegrey"].xpPerItem = 7;

AnimalPartsDefinitions.animals["ratgrey"] = AnimalPartsDefinitions.animals["ratgrey"] or {};
AnimalPartsDefinitions.animals["ratgrey"].parts = AnimalPartsDefinitions.animals["ratgrey"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ratgrey"].parts, {item = "Base.DeadRatSkinned", nb = 1})
AnimalPartsDefinitions.animals["ratgrey"].noSkeleton = true;
AnimalPartsDefinitions.animals["ratgrey"].xpPerItem = 7;

AnimalPartsDefinitions.animals["ratbabygrey"] = AnimalPartsDefinitions.animals["ratbabygrey"] or {};
AnimalPartsDefinitions.animals["ratbabygrey"].parts = AnimalPartsDefinitions.animals["ratbabygrey"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ratbabygrey"].parts, {item = "Base.DeadRatBabySkinned", nb = 1})
AnimalPartsDefinitions.animals["ratbabygrey"].noSkeleton = true;
AnimalPartsDefinitions.animals["ratbabygrey"].xpPerItem = 7;

AnimalPartsDefinitions.animals["ratfemalewhite"] = AnimalPartsDefinitions.animals["ratfemalewhite"] or {};
AnimalPartsDefinitions.animals["ratfemalewhite"].parts = AnimalPartsDefinitions.animals["ratfemalewhite"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ratfemalewhite"].parts, {item = "Base.DeadRatSkinned", nb = 1})
AnimalPartsDefinitions.animals["ratfemalewhite"].noSkeleton = true;
AnimalPartsDefinitions.animals["ratfemalewhite"].xpPerItem = 7;

AnimalPartsDefinitions.animals["ratwhite"] = AnimalPartsDefinitions.animals["ratwhite"] or {};
AnimalPartsDefinitions.animals["ratwhite"].parts = AnimalPartsDefinitions.animals["ratwhite"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ratwhite"].parts, {item = "Base.DeadRatSkinned", nb = 1})
AnimalPartsDefinitions.animals["ratwhite"].noSkeleton = true;
AnimalPartsDefinitions.animals["ratwhite"].xpPerItem = 7;

AnimalPartsDefinitions.animals["ratbabywhite"] = AnimalPartsDefinitions.animals["ratbabywhite"] or {};
AnimalPartsDefinitions.animals["ratbabywhite"].parts = AnimalPartsDefinitions.animals["ratbabywhite"].parts or {};
table.insert(AnimalPartsDefinitions.animals["ratbabywhite"].parts, {item = "Base.DeadRatBabySkinned", nb = 1})
AnimalPartsDefinitions.animals["ratbabywhite"].noSkeleton = true;
AnimalPartsDefinitions.animals["ratbabywhite"].xpPerItem = 7;

-------------------
------ MICE -------
-------------------
AnimalPartsDefinitions.animals["mousefemalegolden"] = AnimalPartsDefinitions.animals["mousefemalegolden"] or {};
AnimalPartsDefinitions.animals["mousefemalegolden"].parts = AnimalPartsDefinitions.animals["mousefemalegolden"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousefemalegolden"].parts, {item = "Base.DeadMouseSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousefemalegolden"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousefemalegolden"].xpPerItem = 5;

AnimalPartsDefinitions.animals["mousegolden"] = AnimalPartsDefinitions.animals["mousegolden"] or {};
AnimalPartsDefinitions.animals["mousegolden"].parts = AnimalPartsDefinitions.animals["mousegolden"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousegolden"].parts, {item = "Base.DeadMouseSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousegolden"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousegolden"].xpPerItem = 5;

AnimalPartsDefinitions.animals["mousepupsgolden"] = AnimalPartsDefinitions.animals["mousepupsgolden"] or {};
AnimalPartsDefinitions.animals["mousepupsgolden"].parts = AnimalPartsDefinitions.animals["mousepupsgolden"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousepupsgolden"].parts, {item = "Base.DeadMousePupsSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousepupsgolden"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousepupsgolden"].xpPerItem = 5;

AnimalPartsDefinitions.animals["mousefemaledeer"] = AnimalPartsDefinitions.animals["mousefemaledeer"] or {};
AnimalPartsDefinitions.animals["mousefemaledeer"].parts = AnimalPartsDefinitions.animals["mousefemaledeer"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousefemaledeer"].parts, {item = "Base.DeadMouseSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousefemaledeer"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousefemaledeer"].xpPerItem = 5;

AnimalPartsDefinitions.animals["mousedeer"] = AnimalPartsDefinitions.animals["mousedeer"] or {};
AnimalPartsDefinitions.animals["mousedeer"].parts = AnimalPartsDefinitions.animals["mousedeer"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousedeer"].parts, {item = "Base.DeadMouseSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousedeer"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousedeer"].xpPerItem = 5;

AnimalPartsDefinitions.animals["mousepupsdeer"] = AnimalPartsDefinitions.animals["mousepupsdeer"] or {};
AnimalPartsDefinitions.animals["mousepupsdeer"].parts = AnimalPartsDefinitions.animals["mousepupsdeer"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousepupsdeer"].parts, {item = "Base.DeadMousePupsSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousepupsdeer"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousepupsdeer"].xpPerItem = 5;

AnimalPartsDefinitions.animals["mousefemalewhite"] = AnimalPartsDefinitions.animals["mousefemalewhite"] or {};
AnimalPartsDefinitions.animals["mousefemalewhite"].parts = AnimalPartsDefinitions.animals["mousefemalewhite"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousefemalewhite"].parts, {item = "Base.DeadMouseSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousefemalewhite"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousefemalewhite"].xpPerItem = 5;

AnimalPartsDefinitions.animals["mousewhite"] = AnimalPartsDefinitions.animals["mousewhite"] or {};
AnimalPartsDefinitions.animals["mousewhite"].parts = AnimalPartsDefinitions.animals["mousewhite"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousewhite"].parts, {item = "Base.DeadMouseSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousewhite"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousewhite"].xpPerItem = 5;

AnimalPartsDefinitions.animals["mousepupswhite"] = AnimalPartsDefinitions.animals["mousepupswhite"] or {};
AnimalPartsDefinitions.animals["mousepupswhite"].parts = AnimalPartsDefinitions.animals["mousepupswhite"].parts or {};
table.insert(AnimalPartsDefinitions.animals["mousepupswhite"].parts, {item = "Base.DeadMousePupsSkinned", nb = 1})
AnimalPartsDefinitions.animals["mousepupswhite"].noSkeleton = true;
AnimalPartsDefinitions.animals["mousepupswhite"].xpPerItem = 5;

-------------------
----- RACCOON -----
-------------------
AnimalPartsDefinitions.animals["raccoonsowgrey"] = AnimalPartsDefinitions.animals["raccoonsowgrey"] or {};
AnimalPartsDefinitions.animals["raccoonsowgrey"].parts = AnimalPartsDefinitions.animals["raccoonsowgrey"].parts or {};
table.insert(AnimalPartsDefinitions.animals["raccoonsowgrey"].parts, {item = "Base.Deer_Doe_Head", nb = 1})
AnimalPartsDefinitions.animals["raccoonsowgrey"].xpPerItem = 10;

AnimalPartsDefinitions.animals["raccoonboargrey"] = AnimalPartsDefinitions.animals["raccoonboargrey"] or {};
AnimalPartsDefinitions.animals["raccoonboargrey"].parts = AnimalPartsDefinitions.animals["raccoonboargrey"].parts or {};
table.insert(AnimalPartsDefinitions.animals["raccoonboargrey"].parts, {item = "Base.Deer_Buck_Head", nb = 1})
AnimalPartsDefinitions.animals["raccoonboargrey"].xpPerItem = 10;

AnimalPartsDefinitions.animals["raccoonkitgrey"] = AnimalPartsDefinitions.animals["raccoonkitgrey"] or {};
AnimalPartsDefinitions.animals["raccoonkitgrey"].parts = AnimalPartsDefinitions.animals["raccoonkitgrey"].parts or {};
table.insert(AnimalPartsDefinitions.animals["raccoonkitgrey"].parts, {item = "Base.Deer_Fawn_Head", nb = 1})
AnimalPartsDefinitions.animals["raccoonkitgrey"].xpPerItem = 10;



-------------------
------ MEAT -------
-------------------
----- This is used to alter the meat given by the animals
----- So we can give more or less "prime" meat depending on skills/animal stats
--- the order has an importance here, the first of the list will be checked first, some maths to explain:
--- * the total % is 100, if we roll to give 20 meats, we first check the first in the list, if the baseChance is 10% (i'm not adding the skill/animal stats to simplify here) you'll have 2 of the first meat (prime cut)
--- * the remaining is then 90%, the remaining meat is 18, we roll the 2nd item, if the baseChance is 30, we'll give 90/30 = 2.7, which means in term of number of meat: 18*0.27 = 4.86 (5) meats of the 2nd category (medium cut)
--- * we have then 20 - 2 - 5 = 13 meat to give (poor cut)
--- item = the item that'll be given (it's always the same so we can somplify all the cooking recipes)
--- baseChance = the base chance of having this item given, it'll be multiplied by butchering skill and stats of the animal
--- hungerBoost = we take the base hunger of the given item and multiply it by this number (also influenced by animal stats)
--- baseName = will be the first name of the item, that + extraName will give something like Beef (Prime Cut) (Beef being baseName, extraName being (Prime Cut)
--- extraName = will be added to the item name, the full name is found in IGUI_AnimalMeat
AnimalPartsDefinitions.meat = {};
AnimalPartsDefinitions.meat["Base.Beef"] = AnimalPartsDefinitions.meat["Base.Beef"] or {};
AnimalPartsDefinitions.meat["Base.Beef"].variants = AnimalPartsDefinitions.meat["Base.Beef"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Beef"].variants, {item = "Base.Beef", baseChance = 20, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Beef", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Beef"].variants, {item = "Base.Beef", baseChance = 50, hungerBoost = 1.1, baseName = "IGUI_AnimalMeat_Beef", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Beef"].variants, {item = "Base.Beef", hungerBoost = 0.7, baseName = "IGUI_AnimalMeat_Beef", extraName = "IGUI_AnimalMeat_PoorCut"}) -- no need baseChance here as it's the last

AnimalPartsDefinitions.meat["Base.Pork"] = AnimalPartsDefinitions.meat["Base.Pork"] or {};
AnimalPartsDefinitions.meat["Base.Pork"].variants = AnimalPartsDefinitions.meat["Base.Pork"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Pork"].variants, {item = "Base.Pork", baseChance = 20, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Pork", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Pork"].variants, {item = "Base.Pork", baseChance = 50, hungerBoost = 1.1, baseName = "IGUI_AnimalMeat_Pork", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Pork"].variants, {item = "Base.Pork", hungerBoost = 0.7, baseName = "IGUI_AnimalMeat_Pork", extraName = "IGUI_AnimalMeat_PoorCut"}) -- no need baseChance here as it's the last

AnimalPartsDefinitions.meat["Base.MuttonChop"] = AnimalPartsDefinitions.meat["Base.MuttonChop"] or {};
AnimalPartsDefinitions.meat["Base.MuttonChop"].variants = AnimalPartsDefinitions.meat["Base.MuttonChop"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.MuttonChop"].variants, {item = "Base.MuttonChop", baseChance = 20, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Mutton", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.MuttonChop"].variants, {item = "Base.MuttonChop", baseChance = 50, hungerBoost = 1.1, baseName = "IGUI_AnimalMeat_Mutton", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.MuttonChop"].variants, {item = "Base.MuttonChop", hungerBoost = 0.7, baseName = "IGUI_AnimalMeat_Mutton", extraName = "IGUI_AnimalMeat_PoorCut"})

AnimalPartsDefinitions.meat["Base.Rabbitmeat"] = AnimalPartsDefinitions.meat["Base.Rabbitmeat"] or {};
AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants = AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants, {item = "Base.Rabbitmeat", baseChance = 20, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Rabbit", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants, {item = "Base.Rabbitmeat", baseChance = 50, hungerBoost = 1.1, baseName = "IGUI_AnimalMeat_Rabbit", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Rabbitmeat"].variants, {item = "Base.Rabbitmeat", hungerBoost = 0.7, baseName = "IGUI_AnimalMeat_Rabbit", extraName = "IGUI_AnimalMeat_PoorCut"})

AnimalPartsDefinitions.meat["Base.Venison"] = AnimalPartsDefinitions.meat["Base.Venison"] or {};
AnimalPartsDefinitions.meat["Base.Venison"].variants = AnimalPartsDefinitions.meat["Base.Venison"].variants or {};
table.insert(AnimalPartsDefinitions.meat["Base.Venison"].variants, {item = "Base.Venison", baseChance = 20, hungerBoost = 2, baseName = "IGUI_AnimalMeat_Venison", extraName = "IGUI_AnimalMeat_PrimeCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Venison"].variants, {item = "Base.Venison", baseChance = 50, hungerBoost = 1.1, baseName = "IGUI_AnimalMeat_Venison", extraName = "IGUI_AnimalMeat_MediumCut"})
table.insert(AnimalPartsDefinitions.meat["Base.Venison"].variants, {item = "Base.Venison", hungerBoost = 0.7, baseName = "IGUI_AnimalMeat_Venison", extraName = "IGUI_AnimalMeat_PoorCut"}) -- no need baseChance here as it's the last