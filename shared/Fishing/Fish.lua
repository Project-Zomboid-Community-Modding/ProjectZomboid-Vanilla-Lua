Fishing = Fishing or {}

Fishing.Fish = {}

local Fish = Fishing.Fish

function Fish:new(character, lure, fishingRod, x, y)
    local o = {}
    setmetatable(o, self)
    self.__index = self

    o.character = character
    o.x = x
    o.y = y
    o.isRiver = Fishing.isRiver(x, y)   --getCell():getGridSquare(x, y, 0):getWater():getFlow() > 0
	o.fishingRod = fishingRod
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
	local isReel = self.fishingRod:getTension() >= 0.1
    local trashFactor = FishSchoolManager.getInstance():getTrashAbundance(self.x, self.y)
	
	-- Set speed to Normal in case players have sped their game up.
	setGameSpeed(1)
	getGameTime():setMultiplier(1)
	
	-- Start reducing odds of catching garbage at higher skill levels.
	if self.fishingLvl >= 5 then
		-- 20% lower trashFactor at start.
		local cleanFactor = 0.8
		if self.fishingLvl >= 9 then
			-- 80% lower at Lvl 9 and up.
			cleanFactor = 0.2
		elseif self.fishingLvl >= 7 then
			-- 40% lower at Lvl 7 and up.
			cleanFactor = 0.6
		end
		trashFactor = trashFactor * cleanFactor
	end
	
    local fishNum = FishSchoolManager.getInstance():getFishAbundance(self.x, self.y)
	local skillSizeLimit = Fishing.Utils.skillSizeLimit[self.fishingLvl]
	
    if (fishNum == 0.0 and ZombRandFloat(0.0, 4.0) < 0.1 + self.fishingLvl / 20.0) or (fishNum ~= 0 and ZombRandFloat(0.0 + self.fishingLvl / 30.0, 0.5 + self.fishingLvl / 20.0) > trashFactor) then
        local fishes = {}
        local baitFactorSum = 0
        for _, fishConfig in ipairs(Fishing.fishes) do
			local canCatch = fishConfig.maxWeight <= skillSizeLimit
            if fishConfig.isPredator then
                if not isReel then
                    canCatch = false
                end
            end
			if canCatch then
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

	-- Need to be skilled at Fishing to catch Legendary fish.
	if self.fishingLvl >= 8 and fishSizeData.size == "Big" then
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
				local newWeight = fishSizeData.weight + ZombRandFloat(0.0, weightDelta)
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
	
	local hungerFactor = fishSizeData.weight / fishConfig.weightFactor
	-- If fish is not bait, then min hunger should be 5 regardless of size.
	if fishConfig.itemType ~= "BaitFish" then
		if hungerFactor > 0.05 then
			item:setBaseHunger(-hungerFactor)
		else
			item:setBaseHunger(-0.05)
		end
    else
        item:setBaseHunger(-hungerFactor)
	end
    item:setHungChange(item:getBaseHunger())
    item:setActualWeight(fishSizeData.weight * 2.2)   -- weight is kg * 2.2 (in pound)
    item:setCustomWeight(true)

	-- Large species of fish sometimes reach the weight cap while still at "Medium".
	-- This changes their size to "Big"
	if item:getActualWeight() >= 45 and fishSizeData.size ~= "Big" then
		fishSizeData.size = "Big"
	end

	-- Not sure why fish above 0.6 are having this tooltip mistakenly applied?
	-- Changed to no longer rely on Recipe.OnTest results and just check weight directly.
	if item:getActualWeight() < 0.6 then
		item:setTooltip(getText("Tooltip_Fishing_TooSmallForSlicing"))
	end

    self.fishSize = fishSizeData.length / 20.0
    self.fishSizeLen = fishSizeData.length
    item:getModData().fishing_FishSize = fishSizeData.length
    item:getModData().fishing_FishHandItem = (luautils.split(fishConfig.itemType, "."))[2] .. "_Hand" .. modelSuffix

    -- the fish name is like : Big Trout - 26cm
    if fishConfig.isHaveDifferentSizes then
		-- Now that all the other stuff that calls on fish size is done, we need to modify the size entry based on fish weight. This is due to the weight limit in caught fish.
		-- Sizes: 0-15 - Small 15-30 - Medium, 35-45 - Big
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