Fishing = Fishing or {}

Fishing.Fish = {}

local Fish = Fishing.Fish

function Fish:new(character, lure, x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.character = character
    o.x = x
    o.y = y
    o.isRiver = Fishing.isRiver(x, y)   --getCell():getGridSquare(x, y, 0):getWater():getFlow() > 0
    o.lure = lure
    o.fishingLvl = character:getPerkLevel(Perks.Fishing)

    o.splashTimer = 0
    o.timer = 0
    o.dx = 0
    o.dy = 0

    o.fishSize = 1
    o.fishSizeLen = 1
    o.isTrash = false

    return o
end

function Fish:update(x, y)
    if self.fishItem == nil then
        self:getFish()
    end

    if self.isTrash then
        return
    end

    if self.timer <= 0 then
        self.dx = ((ZombRand(0, 20)-10)* self.fishSize)/1200.0
        self.dy = ((ZombRand(0, 20)-10)* self.fishSize)/1200.0

        self.timer = 400
    else
        if self.timer <= 200 then
            self.dx = 0
            self.dy = 0
        end
        self.timer = self.timer - getGameTime():getMultiplier()
    end

    self.splashTimer = self.splashTimer + 1
    if self.splashTimer % 30 == 0 then
        local dx = ZombRandFloat(0.0, 0.4) - 0.2
        local dy = ZombRandFloat(0.0, 0.4) - 0.2
        getCell():getGridSquare(x, y, 0):startWaterSplash(true, dx, dy)
        if isClient() then
            transmitBigWaterSplash(x, y, dx, dy)
        end
        self.splashTimer = 0
    end
end


function Fish:getFishByLure()
    local item = nil
    local trashFactor = FishSchoolManager.getInstance():getTrashAbundance(self.x, self.y)
    local fishNum = FishSchoolManager.getInstance():getFishAbundance(self.x, self.y)
    if (fishNum == 0.0 and ZombRandFloat(0.0, 4.0) < 0.1 + self.fishingLvl / 20.0) or (fishNum ~= 0 and ZombRandFloat(0.0 + self.fishingLvl / 30.0, 0.5 + self.fishingLvl / 20.0) > trashFactor) then
        local fishes = {}
        local baitFactorSum = 0
        for _, fishConfig in ipairs(Fishing.fishes) do
            if self.isRiver and fishConfig.isRiver then
                if fishConfig.lure[self.lure] ~= nil then
                    table.insert(fishes, fishConfig)
                    baitFactorSum = baitFactorSum + fishConfig.lure[self.lure]
                end
            elseif not self.isRiver and fishConfig.isLake then
                if fishConfig.lure[self.lure] ~= nil then
                    table.insert(fishes, fishConfig)
                    baitFactorSum = baitFactorSum + fishConfig.lure[self.lure]
                end
            end
        end

        local sum = 0
        local fishNumber = ZombRandFloat(0.0, baitFactorSum)
        for _, fishConfig in ipairs(fishes) do
            sum = sum + fishConfig.lure[self.lure]
            if sum >= fishNumber then
                item = fishConfig
                break
            end
        end

        if item == nil then
            if self.lure ~= nil then
                print("No fish for lure :" .. self.lure)
            end
            return Fishing.trashItems[ZombRand(#Fishing.trashItems) + 1], true
        end
        return item, false
    else
        return Fishing.trashItems[ZombRand(#Fishing.trashItems) + 1], true
    end
end

function Fish:createFish(fishConfig)
    local fishNum = FishSchoolManager.getInstance():getFishAbundance(self.x, self.y)
    local fishSmall, fishMedium, fishBig = Fishing.Utils.getFishSizeChancesBySkillLevel(self.fishingLvl, Fishing.Utils.isNearShore(self.x, self.y), fishNum)
    local fishSizeData = fishConfig:getFishSizeData(fishSmall, fishMedium, fishBig)

    local modelSuffix
    if (fishSizeData.size == "Big") then
        modelSuffix = "_Big"
    elseif fishSizeData.size == "Medium" then
        modelSuffix = "_Medium"
    else
        modelSuffix = "_Little"
    end

	-- TEMP NOTES WILL DELETE LATER
	-- Placed after modelSuffix to avoid complications.
	if fishSizeData.size == "Big" then
		-- Can set up something more complex later. Roll a D20 for now!
		local trophyRoll = ZombRand(20)
		-- If successful roll, add extra length/weight to current fish.
		if trophyRoll == 0 then
			-- Add Length
			if fishConfig.trophyLength then
				local lengthDelta = fishConfig.trophyLength - fishSizeData.length
				local newLength = fishSizeData.length + ZombRand(lengthDelta)
				if newLength > fishConfig.maxLength then
					fishSizeData.size = "Legendary"
					fishSizeData.length = newLength
				else
					fishSizeData.length = fishConfig.maxLength
				end
			end
			if fishConfig.trophyWeight then
				-- Add Weight
				local weightDelta = fishConfig.trophyWeight - fishSizeData.weight
				local newWeight = fishSizeData.weight + ZombRandFloat(weightDelta)
				if newWeight > fishConfig.maxWeight then
					if newWeight > fishConfig.maxWeight then
						fishSizeData.size = "Legendary"
						fishSizeData.weight = newWeight
					end
					fishSizeData.weight = newWeight
				else
					fishSizeData.weight = fishConfig.maxWeight
				end
			end
		end
	end

    local item = instanceItem(fishConfig.itemType);
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

    if not Recipe.OnTest.CutFish(item) then
        item:setTooltip(getText("Tooltip_Fishing_TooSmallForSlicing"))
    end

    self.fishSize = fishSizeData.length / 20.0
    self.fishSizeLen = fishSizeData.length
    item:getModData().fishing_FishSize = fishSizeData.length
    item:getModData().fishing_FishHandItem = (luautils.split(fishConfig.itemType, "."))[2] .. "_Hand" .. modelSuffix

    -- the fish name is like : Big Trout - 26cm
    if fishConfig.isHaveDifferentSizes then
        item:setName(getText("IGUI_Fish_" .. fishSizeData.size) .. " " .. getScriptManager():FindItem(fishConfig.itemType):getDisplayName() .. " - " .. fishSizeData.length .. "cm");
    end

    return item
end

function Fish:getFish()
    local item, isTrash = self:getFishByLure()
    if isTrash then
        self.fishItem = instanceItem(item)
        self.isTrash = true
        self.dx = 0.0015 * (ZombRand(3)-1)
        self.dy = 0.0015 * (ZombRand(3)-1)
    else
        self.fishItem = self:createFish(item)
        FishSchoolManager.getInstance():catchFish(self.x, self.y)
    end
end