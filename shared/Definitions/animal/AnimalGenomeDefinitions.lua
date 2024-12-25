--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 30/03/2022
-- Time: 09:31
-- To change this template use File | Settings | File Templates.
--

-- Define all the possible genes and their extra value (hidden recessive disease/bonus) here
-- When first running the genome of an animal, the closer to the average (maxValue - minValue), the best chance it has to be dominant, a dominant gene will always be passed onto the children if there's a recessive and one dominant, if 2 dominant or 2 recessives are presents, one will be picked at random.
-- Mutations can appears, even tho small chance, it could affect genes in a great way: adding a hidden "perk" into a recessive gene, increasing/decreasing by a lot the value of the gene, making a recessive gene go dominant...
-- There's still always a less small chance that the gene's value evolve (maxMilk could be transfered from the father but gain or lose a 0.05 value for example)

AnimalGenomeDefinitions = AnimalGenomeDefinitions or {};

AnimalGenomeDefinitions.genes = {};
AnimalGenomeDefinitions.genes["maxSize"] = {}; -- maxSize will define the size AND weight of an animal (both are linked anyway)
AnimalGenomeDefinitions.genes["maxSize"].minValue = 0.85; -- default value are a rand 0.2-0.6, this way we can force animals to be bigger by default (the size gene influence only the 3D model size, not its weight/meat), this way we don't have really small animals that looks weird
AnimalGenomeDefinitions.genes["maxSize"].maxValue = 0.95;
AnimalGenomeDefinitions.genes["maxSize"].forcedValues = true; -- sometimes, when generating the allele, there's a small chance to make a rand(0,1) instead of the classic rand(0.2,0.6) to add more randomness, set this to true to avoid it (like here, we don't want a possible maxSize at 0.01 or something)

AnimalGenomeDefinitions.genes["maxMilk"] = {}; -- affect max & min milk of the animal
AnimalGenomeDefinitions.genes["maxMilk"].ratio = {}; -- you can define ratio for each gene, that will impact some other gene
AnimalGenomeDefinitions.genes["maxMilk"].ratio["meatRatio"] = 0.6; -- this mean maxMilk will impact the meat, if you have a 1.0 in maxMilk, the meat gene will take 0.6 - 1.0 = -0.4. so the less maxMilk the higher meat you'll get, basically an Angus-Holstein cross breeding will never get a 1.0 in meat (from Angus) and a 1.0 in maxMilk (from Holstein), the meat ratio will be dampened because of this ratio, but having a small maxMilk means more meat ratio!

AnimalGenomeDefinitions.genes["meatRatio"] = {}; -- this is a weight to meat ratio, you can have a big fat cow but yield poor meat, like a holstein, while an Angus, even tho smaller, yield way more meat
AnimalGenomeDefinitions.genes["meatRatio"].minValue = 0.8;
AnimalGenomeDefinitions.genes["meatRatio"].maxValue = 1;

AnimalGenomeDefinitions.genes["ageToGrow"] = {};-- influence how fast a baby will become adult, impact is low, having this at 0.1 doesn't mean +90% of days survived to become adult, but something like +20%
AnimalGenomeDefinitions.genes["ageToGrow"].minValue = 0.5;
AnimalGenomeDefinitions.genes["ageToGrow"].maxValue = 0.8;
AnimalGenomeDefinitions.genes["ageToGrow"].forcedValues = true;

AnimalGenomeDefinitions.genes["maxWool"] = {}; -- affect max & min wool of the animal
AnimalGenomeDefinitions.genes["maxWool"].minValue = 0.5;
AnimalGenomeDefinitions.genes["maxWool"].maxValue = 0.8;
AnimalGenomeDefinitions.genes["maxWool"].forcedValues = true;
AnimalGenomeDefinitions.genes["maxWool"].ratio = {};
AnimalGenomeDefinitions.genes["maxWool"].ratio["meatRatio"] = 0.6;
AnimalGenomeDefinitions.genes["maxWeight"] = {}; --influence the maximum weight of an animal (base weight is defined in the animal's def)
AnimalGenomeDefinitions.genes["maxWeight"].minValue = 0.5;
AnimalGenomeDefinitions.genes["maxWeight"].maxValue = 0.8;
AnimalGenomeDefinitions.genes["lifeExpectancy"] = {}; -- average life (modify maxAgeGeriatric, so affect baby chance when old etc.)
AnimalGenomeDefinitions.genes["lifeExpectancy"].minValue = 0.5;
AnimalGenomeDefinitions.genes["lifeExpectancy"].maxValue = 0.8;
AnimalGenomeDefinitions.genes["resistance"] = {}; -- this define the health loss when something bad happen to the animal (high hunger/thirst, wound, etc..), this gene at 1 means it'll loss way less health during bad things
AnimalGenomeDefinitions.genes["strength"] = {}; -- strength of the animal, used when we roll damage for when the animal attack
AnimalGenomeDefinitions.genes["fertility"] = {};  -- ability to get a baby
AnimalGenomeDefinitions.genes["fertility"].minValue = 0.75;
AnimalGenomeDefinitions.genes["fertility"].maxValue = 0.95;
AnimalGenomeDefinitions.genes["aggressiveness"] = {};  -- affect how much the animal will try to hit other animals/humans
AnimalGenomeDefinitions.genes["thirstResistance"] = {}; -- affect the thirst loss per hour of the animal
AnimalGenomeDefinitions.genes["hungerResistance"] = {};  -- affect the hunger loss per hour of the animal
AnimalGenomeDefinitions.genes["milkInc"] = {}; -- affect how fast an animal produce milk
AnimalGenomeDefinitions.genes["woolInc"] = {}; -- affect how fast an animal produce wool
AnimalGenomeDefinitions.genes["eggSize"] = {};  -- affect the egg size delivered by the animal (the bigger -> the more hunger reductioin)
AnimalGenomeDefinitions.genes["stress"] = {};  -- affect the starting stress on an animal, how fast it goes down and up (the bigger -> the more stress the animal gain/the less it lose)
AnimalGenomeDefinitions.genes["eggClutch"] = {}; -- affect the size of the egg clutch of an animal
AnimalGenomeDefinitions.genes["eggClutch"].minValue = 0.65;
AnimalGenomeDefinitions.genes["eggClutch"].maxValue = 0.95;




AnimalGenomeDefinitions.geneticDisorder = {}; -- list of genetic disorder an allele could carry, will bebcome active only if the 2 alleles of this gene have the same genetic disorder
-- BAD
AnimalGenomeDefinitions.geneticDisorder["gluttonous"] = "gluttonous"; -- animal will have to eat way more
AnimalGenomeDefinitions.geneticDisorder["highThirst"] = "highThirst"; -- animal will get thirsty very fast
AnimalGenomeDefinitions.geneticDisorder["fidget"] = "fidget"; -- animal will wander way more
AnimalGenomeDefinitions.geneticDisorder["bully"] = "bully"; -- animal will be way more aggressive
AnimalGenomeDefinitions.geneticDisorder["poorFertility"] = "poorFertility"; -- animal will have way less chance to carry children
AnimalGenomeDefinitions.geneticDisorder["sterile"] = "sterile"; -- animal will be not be able to have baby
AnimalGenomeDefinitions.geneticDisorder["weak"] = "weak"; -- animal will have poor strength
AnimalGenomeDefinitions.geneticDisorder["dwarf"] = "dwarf"; -- animal will have a small size
AnimalGenomeDefinitions.geneticDisorder["skinny"] = "skinny"; -- animal will have a small weight
AnimalGenomeDefinitions.geneticDisorder["bony"] = "bony"; -- animal will have a poor meatRatio
AnimalGenomeDefinitions.geneticDisorder["dieAtBirth"] = "dieAtBirth"; -- animal will be dead once born
AnimalGenomeDefinitions.geneticDisorder["poorLife"] = "poorLife"; -- animal will have his life expetacy reduced a lot
AnimalGenomeDefinitions.geneticDisorder["noEggs"] = "noEggs"; -- animal won't produce eggs
AnimalGenomeDefinitions.geneticDisorder["smallEggs"] = "smallEggs"; -- animal will produce really small eggs and won't be able to hatch a chick.
AnimalGenomeDefinitions.geneticDisorder["noWool"] = "noWool"; -- animal won't produce wool
AnimalGenomeDefinitions.geneticDisorder["poorWool"] = "poorWool"; -- animal will have its wool production reduced a lot
AnimalGenomeDefinitions.geneticDisorder["noMilk"] = "noMilk"; -- animal won't produce milk
AnimalGenomeDefinitions.geneticDisorder["poorMilk"] = "poorMilk"; -- animal will have its milk production reduced a lot
AnimalGenomeDefinitions.geneticDisorder["growSlow"] = "growSlow"; -- animal will take lots more time to get to the next stage (grow)
AnimalGenomeDefinitions.geneticDisorder["slowWalking"] = "slowWalking"; -- animal will have a regular problem to one of its leg, making it walk really slow/impossible to run
AnimalGenomeDefinitions.geneticDisorder["craven"] = "craven"; -- animal will flee humans and zombies
AnimalGenomeDefinitions.geneticDisorder["brave"] = "brave"; -- animal will never backup from a fight, and keep goinig untili he or the other fighter is dead
AnimalGenomeDefinitions.geneticDisorder["idiot"] = "idiot"; -- animal will sometimes forget to eat/drink
AnimalGenomeDefinitions.geneticDisorder["feeble"] = "feeble"; -- the max health for this animal will be reduced a lot
AnimalGenomeDefinitions.geneticDisorder["blind"] = "blind"; -- this animal will have trouble finding others animal to fecund, won't be able to enter a hutch, have trouble finding food
AnimalGenomeDefinitions.geneticDisorder["highStress"] = "highStress"; -- animal will gain way more stress and lose less
-- GOOD
AnimalGenomeDefinitions.geneticDisorder["fertile"] = "fertile"; -- fertility increased
AnimalGenomeDefinitions.geneticDisorder["strong"] = "strong"; -- strength increased