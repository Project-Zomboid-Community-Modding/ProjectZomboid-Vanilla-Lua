
Fishing = Fishing or {}

--------------------- FISHING PROPERTIES --------------------

Fishing.actionProperties = {}
Fishing.actionProperties.defaultLineLen = 6

--------------------- LURE PROPERTIES -----------------------
Fishing.lure = Fishing.lure or {}

Fishing.lure.Insect = {}
Fishing.lure.Insect["Base.Cricket"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.Grasshopper"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.AmericanLadyCaterpillar"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.BandedWoolyBearCaterpillar"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.Centipede"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.Centipede2"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.Millipede"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.Millipede2"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.MonarchCaterpillar"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.Pillbug"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.SawflyLarva"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.SilkMothCaterpillar"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.Cockroach"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.SwallowtailCaterpillar"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Insect["Base.Termites"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }

Fishing.lure.Minnows = {}
Fishing.lure.Minnows["Base.BaitFish"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Minnows["Base.Tadpole"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }

Fishing.lure.Leeches = {}
Fishing.lure.Leeches["Base.Leech"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Leeches["Base.Snail"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Leeches["Base.Slug"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Leeches["Base.Slug2"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }

Fishing.lure.Worms = {}
Fishing.lure.Worms["Base.Worm"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Worms["Base.Maggots"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }

Fishing.lure.Flesh = {}
Fishing.lure.Flesh["Base.Crayfish"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Flesh["Base.Shrimp"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.Flesh["Base.DogfoodOpen"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Flesh["Base.FishFillet"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Flesh["Base.Smallanimalmeat"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Flesh["Base.Smallbirdmeat"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Flesh["Base.MeatPatty"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Flesh["Base.FrogMeat"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Flesh["Base.Steak"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }

Fishing.lure.Plant = {}
Fishing.lure.Plant["Base.Cheese"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Plant["Base.CannedCornOpen"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Plant["Base.Dough"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Plant["Base.Bread"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Plant["Base.BreadDough"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Plant["Base.BaguetteDough"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }
Fishing.lure.Plant["Base.Baguette"] = { chanceModifier = 1.0, amountOfFoodHunger = 5 }

Fishing.lure.ArtificalLure = {}
Fishing.lure.ArtificalLure["Base.JigLure"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }
Fishing.lure.ArtificalLure["Base.MinnowLure"] = { chanceModifier = 1.0, amountOfFoodHunger = -1 }

Fishing.lure.All = {}

Fishing.IndexAllLures = function()
    Fishing.lure.All = {}
    for _, lureTable in pairs(Fishing.lure) do
        if lureTable ~= Fishing.lure.All then
            for item, val in pairs(lureTable) do
                Fishing.lure.All[item] = val
            end
        end
    end
end
Events.OnGameStart.Add(Fishing.IndexAllLures)
Events.OnServerStarted.Add(Fishing.IndexAllLures)

Fishing.IsLure = function(item)
    return Fishing.lure.All[item] ~= nil
end

Fishing.IsArtificalLure = function(item)
    return Fishing.lure.ArtificalLure[item] ~= nil
end

--------------------- FISH PROPERTIES -----------------------

Fishing.FishConfig = {}
Fishing.isSizeLimit = false

function Fishing.FishConfig:new(itemType)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.itemType = itemType
    o.lure = {}
    o.minLength = 10
    o.isHaveDifferentSizes = true

    return o
end

function Fishing.FishConfig:setLocation(isRiver, isLake)
    self.isRiver = isRiver
    self.isLake = isLake
end

function Fishing.FishConfig:setMaxLength(length)
    self.maxLength = math.floor(length)
end

function Fishing.FishConfig:setMaxWeight(weight)
    self.maxWeight = weight
end

function Fishing.FishConfig:addLures(itemTable, chanceCoeff)
    for item, data in pairs(itemTable) do
        self.lure[item] = chanceCoeff * data.chanceModifier
    end
end

function Fishing.FishConfig:clearLures()
    self.lure = {}
end

-- Lures chances: 1.0<->0.8 = Great, 0.8<->0.6 = Good, 0.6<->0.4 = Average, 0.4<->0.2 = Below Average, 0.2<->0.0 = Poor, 0.0 = None
function Fishing.FishConfig:getLureChance(item)
    return math.max(math.min(self.lure[item], 1), 0)
end

function Fishing.FishConfig:initFishSizeData()
    self.fishesSizeData = {}
    local deltaLength = self.maxLength - self.minLength

    local minL = self.minLength
    local maxL = math.floor(self.minLength + deltaLength * 0.3333)
    for length = minL, maxL do
        local fishData = {}
        fishData.size = "Small"
        fishData.length = length
        fishData.weight = math.min(0.1 + ((length - minL)/(maxL - minL)) * (self.maxWeight * 0.2 - 0.1), 45 / 2.2)      -- Limit in weight 45 lbs
        table.insert(self.fishesSizeData, fishData)
    end


    minL = math.floor(self.minLength + deltaLength * 0.3333) + 1
    maxL = math.floor(self.minLength + deltaLength * 0.6666)
    for length = minL, maxL do
        local fishData = {}
        fishData.size = "Medium"
        fishData.length = length
        fishData.weight = math.min(self.maxWeight * 0.2 + ((length - minL)/(maxL - minL)) * (self.maxWeight * 0.4), 45 / 2.2) -- Limit in weight 45 lbs
        table.insert(self.fishesSizeData, fishData)
    end

    minL = math.floor(self.minLength + deltaLength * 0.6666) + 1
    maxL = self.maxLength
    for length = minL, maxL do
        local fishData = {}
        fishData.size = "Big"
        fishData.length = length
        fishData.weight = math.min(self.maxWeight * 0.6 + ((length - minL)/(maxL - minL)) * (self.maxWeight * 0.4), 45 / 2.2) -- Limit in weight 45 lbs
        table.insert(self.fishesSizeData, fishData)
    end
end

function Fishing.FishConfig:getFishSizeData(smallChance, mediumChance, bigChance)
    local sum = 0
    local fishes = {}

    local maxWeightKG = 45 / 2.2
    for _, fishData in ipairs(self.fishesSizeData) do
        local ch = 0
        if (fishData.weight <= maxWeightKG) or (not Fishing.isSizeLimit)  then
            if fishData.size == "Small" then
                ch = smallChance
            elseif fishData.size == "Medium" then
                ch = mediumChance
            elseif fishData.size == "Big" then
                ch = bigChance
            end
        end
        if ch ~= 0 then
            table.insert(fishes, { chance = ch, data = fishData })
            sum = sum + ch
        end
    end

    local number = ZombRandFloat(0.0, sum)
    sum = 0
    for _, fish in ipairs(fishes) do
        sum = sum + fish.chance
        if sum >= number then
            return fish.data
        end
    end
    return nil
end


--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
Fishing.fishes = Fishing.fishes or {};
--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

local LargemouthBass = Fishing.FishConfig:new("Base.LargemouthBass")
LargemouthBass:setLocation(true, true)    -- River, Lake
LargemouthBass:setMaxLength(75) -- CM
LargemouthBass:setMaxWeight(10) -- KG
LargemouthBass:initFishSizeData()

LargemouthBass:addLures(Fishing.lure.Insect, 0.3)
LargemouthBass:addLures(Fishing.lure.Minnows, 0.7)
LargemouthBass:addLures(Fishing.lure.Leeches, 0.5)
LargemouthBass:addLures(Fishing.lure.Worms, 0.7)
LargemouthBass:addLures(Fishing.lure.Flesh, 0.1)
LargemouthBass:addLures(Fishing.lure.Plant, 0.0)
LargemouthBass.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
LargemouthBass.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
LargemouthBass.lure["Base.Maggots"] = 0.9

table.insert(Fishing.fishes, LargemouthBass)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local SmallmouthBass = Fishing.FishConfig:new("Base.SmallmouthBass")
SmallmouthBass:setLocation(true, true)    -- River, Lake
SmallmouthBass:setMaxLength(55) -- CM
SmallmouthBass:setMaxWeight(5) -- KG
SmallmouthBass:initFishSizeData()

SmallmouthBass:addLures(Fishing.lure.Insect, 0.3)
SmallmouthBass:addLures(Fishing.lure.Minnows, 0.7)
SmallmouthBass:addLures(Fishing.lure.Leeches, 0.5)
SmallmouthBass:addLures(Fishing.lure.Worms, 0.7)
SmallmouthBass:addLures(Fishing.lure.Flesh, 0.1)
SmallmouthBass:addLures(Fishing.lure.Plant, 0.0)
SmallmouthBass.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
SmallmouthBass.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
SmallmouthBass.lure["Base.Worm"] = 0.9

table.insert(Fishing.fishes, SmallmouthBass)

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local WhiteBass = Fishing.FishConfig:new("Base.WhiteBass")
WhiteBass:setLocation(true, true)    -- River, Lake
WhiteBass:setMaxLength(40) -- CM
WhiteBass:setMaxWeight(3) -- KG
WhiteBass:initFishSizeData()

WhiteBass:addLures(Fishing.lure.Insect, 0.3)
WhiteBass:addLures(Fishing.lure.Minnows, 0.3)
WhiteBass:addLures(Fishing.lure.Leeches, 0.7)
WhiteBass:addLures(Fishing.lure.Worms, 0.7)
WhiteBass:addLures(Fishing.lure.Flesh, 0.0)
WhiteBass:addLures(Fishing.lure.Plant, 0.0)
WhiteBass.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
WhiteBass.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
WhiteBass.lure["Base.Tadpole"] = 0.9

table.insert(Fishing.fishes, WhiteBass);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local SpottedBass = Fishing.FishConfig:new("Base.SpottedBass")
SpottedBass:setLocation(true, true)    -- River, Lake
SpottedBass:setMaxLength(45) -- CM
SpottedBass:setMaxWeight(5) -- KG
SpottedBass:initFishSizeData()

SpottedBass:addLures(Fishing.lure.Insect, 0.3)
SpottedBass:addLures(Fishing.lure.Minnows, 0.3)
SpottedBass:addLures(Fishing.lure.Leeches, 0.7)
SpottedBass:addLures(Fishing.lure.Worms, 0.7)
SpottedBass:addLures(Fishing.lure.Flesh, 0.0)
SpottedBass:addLures(Fishing.lure.Plant, 0.0)
SpottedBass.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
SpottedBass.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
SpottedBass.lure["Base.Crayfish"] = 0.9

table.insert(Fishing.fishes, SpottedBass);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local StripedBass = Fishing.FishConfig:new("Base.StripedBass")
StripedBass:setLocation(true, true)    -- River, Lake
StripedBass:setMaxLength(90) -- CM
StripedBass:setMaxWeight(15) -- KG
StripedBass:initFishSizeData()

StripedBass:addLures(Fishing.lure.Insect, 0.1)
StripedBass:addLures(Fishing.lure.Minnows, 0.7)
StripedBass:addLures(Fishing.lure.Leeches, 0.5)
StripedBass:addLures(Fishing.lure.Worms, 0.7)
StripedBass:addLures(Fishing.lure.Flesh, 0.5)
StripedBass:addLures(Fishing.lure.Plant, 0.0)
StripedBass.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
StripedBass.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
StripedBass.lure["Base.Leech"] = 0.9

table.insert(Fishing.fishes, StripedBass);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local Bluegill = Fishing.FishConfig:new("Base.Bluegill")
Bluegill:setLocation(true, true)    -- River, Lake
Bluegill:setMaxLength(35) -- CM
Bluegill:setMaxWeight(1.2) -- KG
Bluegill:initFishSizeData()

Bluegill:addLures(Fishing.lure.Insect, 0.5)
Bluegill:addLures(Fishing.lure.Minnows, 0.1)
Bluegill:addLures(Fishing.lure.Leeches, 0.7)
Bluegill:addLures(Fishing.lure.Worms, 0.7)
Bluegill:addLures(Fishing.lure.Flesh, 0.0)
Bluegill:addLures(Fishing.lure.Plant, 0.0)
Bluegill.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
Bluegill.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
Bluegill.lure["Base.Cricket"] = 0.9

table.insert(Fishing.fishes, Bluegill);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local WhiteCrappie = Fishing.FishConfig:new("Base.WhiteCrappie")
WhiteCrappie:setLocation(true, true)    -- River, Lake
WhiteCrappie:setMaxLength(24) -- CM
WhiteCrappie:setMaxWeight(2.5) -- KG
WhiteCrappie:initFishSizeData()

WhiteCrappie:addLures(Fishing.lure.Insect, 0.1)
WhiteCrappie:addLures(Fishing.lure.Minnows, 0.7)
WhiteCrappie:addLures(Fishing.lure.Leeches, 0.7)
WhiteCrappie:addLures(Fishing.lure.Worms, 0.5)
WhiteCrappie:addLures(Fishing.lure.Flesh, 0.0)
WhiteCrappie:addLures(Fishing.lure.Plant, 0.0)
WhiteCrappie.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
WhiteCrappie.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
WhiteCrappie.lure["Base.Tadpole"] = 0.9

table.insert(Fishing.fishes, WhiteCrappie);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local BlackCrappie = Fishing.FishConfig:new("Base.BlackCrappie")
BlackCrappie:setLocation(true, true)    -- River, Lake
BlackCrappie:setMaxLength(28) -- CM
BlackCrappie:setMaxWeight(2.7) -- KG
BlackCrappie:initFishSizeData()

BlackCrappie:addLures(Fishing.lure.Insect, 0.1)
BlackCrappie:addLures(Fishing.lure.Minnows, 0.7)
BlackCrappie:addLures(Fishing.lure.Leeches, 0.7)
BlackCrappie:addLures(Fishing.lure.Worms, 0.5)
BlackCrappie:addLures(Fishing.lure.Flesh, 0.0)
BlackCrappie:addLures(Fishing.lure.Plant, 0.0)
BlackCrappie.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
BlackCrappie.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
BlackCrappie.lure["Base.Tadpole"] = 0.9

table.insert(Fishing.fishes, BlackCrappie);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local RedearSunfish = Fishing.FishConfig:new("Base.RedearSunfish")
RedearSunfish:setLocation(true, true)    -- River, Lake
RedearSunfish:setMaxLength(20) -- CM
RedearSunfish:setMaxWeight(0.9) -- KG
RedearSunfish:initFishSizeData()

RedearSunfish:addLures(Fishing.lure.Insect, 0.7)
RedearSunfish:addLures(Fishing.lure.Minnows, 0.1)
RedearSunfish:addLures(Fishing.lure.Leeches, 0.7)
RedearSunfish:addLures(Fishing.lure.Worms, 0.5)
RedearSunfish:addLures(Fishing.lure.Flesh, 0.0)
RedearSunfish:addLures(Fishing.lure.Plant, 0.0)
RedearSunfish.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
RedearSunfish.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
RedearSunfish.lure["Base.Grasshopper"] = 0.9

table.insert(Fishing.fishes, RedearSunfish);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local YellowPerch = Fishing.FishConfig:new("Base.YellowPerch")
YellowPerch:setLocation(true, true)    -- River, Lake
YellowPerch:setMaxLength(30) -- CM
YellowPerch:setMaxWeight(1.9) -- KG
YellowPerch:initFishSizeData()

YellowPerch:addLures(Fishing.lure.Insect, 0.7)
YellowPerch:addLures(Fishing.lure.Minnows, 0.1)
YellowPerch:addLures(Fishing.lure.Leeches, 0.7)
YellowPerch:addLures(Fishing.lure.Worms, 0.5)
YellowPerch:addLures(Fishing.lure.Flesh, 0.0)
YellowPerch:addLures(Fishing.lure.Plant, 0.0)
YellowPerch.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
YellowPerch.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
YellowPerch.lure["Base.Snail"] = 0.9

table.insert(Fishing.fishes, YellowPerch);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local Sauger = Fishing.FishConfig:new("Base.Sauger")
Sauger:setLocation(true, true)    -- River, Lake
Sauger:setMaxLength(45) -- CM
Sauger:setMaxWeight(1.8) -- KG
Sauger:initFishSizeData()

Sauger:addLures(Fishing.lure.Insect, 0.5)
Sauger:addLures(Fishing.lure.Minnows, 0.1)
Sauger:addLures(Fishing.lure.Leeches, 0.7)
Sauger:addLures(Fishing.lure.Worms, 0.7)
Sauger:addLures(Fishing.lure.Flesh, 0.0)
Sauger:addLures(Fishing.lure.Plant, 0.0)
Sauger.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
Sauger.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
Sauger.lure["Base.Crayfish"] = 0.9

table.insert(Fishing.fishes, Sauger);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local GreenSunfish = Fishing.FishConfig:new("Base.GreenSunfish")
GreenSunfish:setLocation(true, true)    -- River, Lake
GreenSunfish:setMaxLength(20) -- CM
GreenSunfish:setMaxWeight(0.9) -- KG
GreenSunfish:initFishSizeData()

GreenSunfish:addLures(Fishing.lure.Insect, 0.7)
GreenSunfish:addLures(Fishing.lure.Minnows, 0.1)
GreenSunfish:addLures(Fishing.lure.Leeches, 0.5)
GreenSunfish:addLures(Fishing.lure.Worms, 0.7)
GreenSunfish:addLures(Fishing.lure.Flesh, 0.0)
GreenSunfish:addLures(Fishing.lure.Plant, 0.0)
GreenSunfish.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
GreenSunfish.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
GreenSunfish.lure["Base.Worm"] = 0.9

table.insert(Fishing.fishes, GreenSunfish);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local Walleye = Fishing.FishConfig:new("Base.Walleye")
Walleye:setLocation(true, true)    -- River, Lake
Walleye:setMaxLength(88) -- CM
Walleye:setMaxWeight(13) -- KG
Walleye:initFishSizeData()

Walleye:addLures(Fishing.lure.Insect, 0.7)
Walleye:addLures(Fishing.lure.Minnows, 0.7)
Walleye:addLures(Fishing.lure.Leeches, 0.7)
Walleye:addLures(Fishing.lure.Worms, 0.5)
Walleye:addLures(Fishing.lure.Flesh, 0.3)
Walleye:addLures(Fishing.lure.Plant, 0.0)
Walleye.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
Walleye.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
Walleye.lure["Base.Leech"] = 0.9

table.insert(Fishing.fishes, Walleye);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local FreshwaterDrum = Fishing.FishConfig:new("Base.FreshwaterDrum")
FreshwaterDrum:setLocation(true, true)    -- River, Lake
FreshwaterDrum:setMaxLength(95) -- CM
FreshwaterDrum:setMaxWeight(24.5) -- KG
FreshwaterDrum:initFishSizeData()

FreshwaterDrum:addLures(Fishing.lure.Insect, 0.1)
FreshwaterDrum:addLures(Fishing.lure.Minnows, 0.0)
FreshwaterDrum:addLures(Fishing.lure.Leeches, 0.5)
FreshwaterDrum:addLures(Fishing.lure.Worms, 0.7)
FreshwaterDrum:addLures(Fishing.lure.Flesh, 0.0)
FreshwaterDrum:addLures(Fishing.lure.Plant, 0.7)
FreshwaterDrum.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
FreshwaterDrum.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
FreshwaterDrum.lure["Base.Dough"] = 0.9

table.insert(Fishing.fishes, FreshwaterDrum);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local BlueCatfish = Fishing.FishConfig:new("Base.BlueCatfish")
BlueCatfish:setLocation(true, true)    -- River, Lake
BlueCatfish:setMaxLength(165) -- CM
BlueCatfish:setMaxWeight(68) -- KG
BlueCatfish:initFishSizeData()

BlueCatfish:addLures(Fishing.lure.Insect, 0.1)
BlueCatfish:addLures(Fishing.lure.Minnows, 0.0)
BlueCatfish:addLures(Fishing.lure.Leeches, 0.1)
BlueCatfish:addLures(Fishing.lure.Worms, 0.5)
BlueCatfish:addLures(Fishing.lure.Flesh, 0.7)
BlueCatfish:addLures(Fishing.lure.Plant, 0.5)
BlueCatfish.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
BlueCatfish.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
BlueCatfish.lure["Base.DogfoodOpen"] = 0.9

table.insert(Fishing.fishes, BlueCatfish);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local ChannelCatfish = Fishing.FishConfig:new("Base.ChannelCatfish")
ChannelCatfish:setLocation(true, true)    -- River, Lake
ChannelCatfish:setMaxLength(80) -- CM
ChannelCatfish:setMaxWeight(26) -- KG
ChannelCatfish:initFishSizeData()

ChannelCatfish:addLures(Fishing.lure.Insect, 0.1)
ChannelCatfish:addLures(Fishing.lure.Minnows, 0.0)
ChannelCatfish:addLures(Fishing.lure.Leeches, 0.1)
ChannelCatfish:addLures(Fishing.lure.Worms, 0.5)
ChannelCatfish:addLures(Fishing.lure.Flesh, 0.7)
ChannelCatfish:addLures(Fishing.lure.Plant, 0.5)
ChannelCatfish.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
ChannelCatfish.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
ChannelCatfish.lure["Base.DogfoodOpen"] = 0.9

table.insert(Fishing.fishes, ChannelCatfish);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local FlatheadCatfish = Fishing.FishConfig:new("Base.FlatheadCatfish")
FlatheadCatfish:setLocation(true, true)    -- River, Lake
FlatheadCatfish:setMaxLength(140) -- CM
FlatheadCatfish:setMaxWeight(55) -- KG
FlatheadCatfish:initFishSizeData()

FlatheadCatfish:addLures(Fishing.lure.Insect, 0.1)
FlatheadCatfish:addLures(Fishing.lure.Minnows, 0.0)
FlatheadCatfish:addLures(Fishing.lure.Leeches, 0.1)
FlatheadCatfish:addLures(Fishing.lure.Worms, 0.5)
FlatheadCatfish:addLures(Fishing.lure.Flesh, 0.7)
FlatheadCatfish:addLures(Fishing.lure.Plant, 0.5)
FlatheadCatfish.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
FlatheadCatfish.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
FlatheadCatfish.lure["Base.DogfoodOpen"] = 0.9

table.insert(Fishing.fishes, FlatheadCatfish);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local Muskellunge = Fishing.FishConfig:new("Base.Muskellunge")
Muskellunge:setLocation(true, true)    -- River, Lake
Muskellunge:setMaxLength(101) -- CM
Muskellunge:setMaxWeight(32) -- KG
Muskellunge:initFishSizeData()

Muskellunge:addLures(Fishing.lure.Insect, 0.1)
Muskellunge:addLures(Fishing.lure.Minnows, 0.7)
Muskellunge:addLures(Fishing.lure.Leeches, 0.5)
Muskellunge:addLures(Fishing.lure.Worms, 0.5)
Muskellunge:addLures(Fishing.lure.Flesh, 0.5)
Muskellunge:addLures(Fishing.lure.Plant, 0.0)
Muskellunge.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
Muskellunge.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
Muskellunge.lure["Base.BaitFish"] = 0.9

table.insert(Fishing.fishes, Muskellunge);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local AligatorGar = Fishing.FishConfig:new("Base.AligatorGar")
AligatorGar:setLocation(true, true)    -- River, Lake
AligatorGar:setMaxLength(243) -- CM
AligatorGar:setMaxWeight(150) -- KG
AligatorGar:initFishSizeData()

AligatorGar:addLures(Fishing.lure.Insect, 0.1)
AligatorGar:addLures(Fishing.lure.Minnows, 0.7)
AligatorGar:addLures(Fishing.lure.Leeches, 0.5)
AligatorGar:addLures(Fishing.lure.Worms, 0.5)
AligatorGar:addLures(Fishing.lure.Flesh, 0.5)
AligatorGar:addLures(Fishing.lure.Plant, 0.0)
AligatorGar.lure["Base.JigLure"] = 0.5  -- Looks like worm/leech/shrimp. Made from rubber.
AligatorGar.lure["Base.MinnowLure"] = 0.5   -- Looks like minnow. Made from plastic.
AligatorGar.lure["Base.BaitFish"] = 0.9

table.insert(Fishing.fishes, AligatorGar);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local Paddlefish = Fishing.FishConfig:new("Base.Paddlefish")
Paddlefish:setLocation(true, true)    -- River, Lake
Paddlefish:setMaxLength(220) -- CM
Paddlefish:setMaxWeight(90) -- KG
Paddlefish:initFishSizeData()

Paddlefish:addLures(Fishing.lure.Insect, 0.1)
Paddlefish:addLures(Fishing.lure.Minnows, 0.1)
Paddlefish:addLures(Fishing.lure.Leeches, 0.1)
Paddlefish:addLures(Fishing.lure.Worms, 0.1)
Paddlefish:addLures(Fishing.lure.Flesh, 0.1)
Paddlefish:addLures(Fishing.lure.Plant, 0.1)
Paddlefish.lure["Base.JigLure"] = 0.1  -- Looks like worm/leech/shrimp. Made from rubber.
Paddlefish.lure["Base.MinnowLure"] = 0.1   -- Looks like minnow. Made from plastic.

table.insert(Fishing.fishes, Paddlefish);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

local BaitFish = Fishing.FishConfig:new("Base.BaitFish")
BaitFish:setLocation(true, true)    -- River, Lake
BaitFish:setMaxLength(10) -- CM
BaitFish:setMaxWeight(0.05) -- KG
BaitFish.minLength = 5
BaitFish:initFishSizeData()
BaitFish.isHaveDifferentSizes = false

BaitFish:addLures(Fishing.lure.Insect, 0.7)
BaitFish:addLures(Fishing.lure.Minnows, 0.0)
BaitFish:addLures(Fishing.lure.Leeches, 0.0)
BaitFish:addLures(Fishing.lure.Worms, 0.7)
BaitFish:addLures(Fishing.lure.Flesh, 0.0)
BaitFish:addLures(Fishing.lure.Plant, 0.7)
BaitFish.lure["Base.JigLure"] = 0.0  -- Looks like worm/leech/shrimp. Made from rubber.
BaitFish.lure["Base.MinnowLure"] = 0.0   -- Looks like minnow. Made from plastic.

table.insert(Fishing.fishes, BaitFish);

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


--------------------- TRASH PROPERTIES -----------------------

Fishing.trashItems = Fishing.trashItems or {};
table.insert(Fishing.trashItems, "Base.Seaweed");
table.insert(Fishing.trashItems, "Base.RippedSheetsDirty");
table.insert(Fishing.trashItems, "Base.BrokenFishingNet");
table.insert(Fishing.trashItems, "Base.TinCanEmpty");
table.insert(Fishing.trashItems, "Base.WaterBottleEmpty");

--------------------- LINE PROPERTIES -----------------------
Fishing.line = Fishing.line or {};
Fishing.line["Base.Twine"] = 0.3 / 15.0
Fishing.line["Base.FishingLine"] = 0.2 / 15.0
Fishing.line["Base.PremiumFishingLine"] = 0.1 / 15.0

--------------------- HOOK PROPERTIES -----------------------
Fishing.hook = Fishing.hook or {};
Fishing.hook["Base.Paperclip"] = 0.8
Fishing.hook["Base.Nails"] = 1.0
Fishing.hook["Base.FishingHook"] = 1.2
Fishing.hook["Base.FishingHook_Forged"] = 1.2
Fishing.hook["Base.FishingHook_Bone"] = 1.2

--------------------- ROD PROPERTIES -----------------------
Fishing.rods = Fishing.rods or {};
Fishing.rods["Base.CraftedFishingRod"] = 0.8
Fishing.rods["Base.FishingRod"] = 1

--------------------- ROD BREAK REPLACEMENT -----------------------

Fishing.breakRodReplacement = Fishing.breakRodReplacement or {}
Fishing.breakRodReplacement["Base.CraftedFishingRod"] = "Base.WoodenStick"
Fishing.breakRodReplacement["Base.FishingRod"] = "Base.FishingRodBreak"

--------------------- FISH NET PROPERTIES -----------------------

Fishing.fishNet = Fishing.fishNet or {}
table.insert(Fishing.fishNet,"Base.BaitFish")
table.insert(Fishing.fishNet,"Base.Frog")
table.insert(Fishing.fishNet,"Base.Mussels")
table.insert(Fishing.fishNet, "Base.Seaweed")
table.insert(Fishing.fishNet, "Base.Crayfish")
table.insert(Fishing.fishNet, "Base.Tadpole")



Fishing.fishNetWithBait = Fishing.fishNetWithBait or {}
table.insert(Fishing.fishNetWithBait, "Base.BaitFish")
table.insert(Fishing.fishNetWithBait, "Base.Tadpole")
table.insert(Fishing.fishNetWithBait, "Base.Crayfish")
table.insert(Fishing.fishNetWithBait, "Base.BlueCatfish")
table.insert(Fishing.fishNetWithBait, "Base.ChannelCatfish")
table.insert(Fishing.fishNetWithBait, "Base.FlatheadCatfish")


--------------------- Item OnCreate functions -------------------

function Fishing.onCreateFish(item)
    if not item then return end

    local itemType = item:getFullType()
    local fishConfig = nil
    for _, config in ipairs(Fishing.fishes) do
        if config.itemType == itemType then
            fishConfig = config
            break
        end
    end

    if not fishConfig then
        print("[Fishing][OnCreateFish] no fish definition found for item type : " .. itemType)
        return
    end

    local fishSizeData = fishConfig:getFishSizeData(50, 30, 20)

    local nutritionFactor = 2.2 * fishSizeData.weight / item:getActualWeight()
    item:setCalories(item:getCalories() * nutritionFactor)
    item:setLipids(item:getLipids() * nutritionFactor)
    item:setCarbohydrates(item:getCarbohydrates() * nutritionFactor)
    item:setProteins(item:getProteins() * nutritionFactor)
    item:setWorldScale(fishSizeData.length / 100.0)

    item:setBaseHunger(-fishSizeData.weight / 6)
    item:setHungChange(item:getBaseHunger())
    item:setActualWeight(fishSizeData.weight * 2.2)   -- weight is kg * 2.2 (in pound)
    item:setCustomWeight(true)

    if instanceof(item, "Food") then
        if item:getActualWeight() <= 0.6 then
            item:setTooltip(getText("Tooltip_Fishing_TooSmallForSlicing"))
        end
    end
end

function Fishing.onCreateFishingRod(item)
    if not item then return end

    local lines = {}
    for key, _ in pairs(Fishing.line) do
        table.insert(lines, key)
    end
    item:getModData().fishing_LineType = lines[ZombRand(#lines)+1]

    local hooks = {}
    for key, _ in pairs(Fishing.hook) do
        table.insert(hooks, key)
    end
    item:getModData().fishing_HookType = hooks[ZombRand(#hooks)+1]

    return item
end

function Fishing.onCreateChum(item)
    if not item then return end
    item:setName(getText("UI_Chum_Blank"))
end
