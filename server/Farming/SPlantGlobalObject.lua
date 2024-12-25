--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

-----------------------------------------------------------------------
--                          FARMING MOD                              --
--                      CODE BY ROBERT JOHNSON                       --
--                       TEXTURES BY THUZTOR                         --
-----------------------------------------------------------------------
--                          OFFICIAL TOPIC                           --
--  http://www.theindiestone.com/community/viewtopic.php?f=33&t=8675 --
--                                                                   --
-----------------------------------------------------------------------

if isClient() then return end

require "Map/SGlobalObject"

SPlantGlobalObject = SGlobalObject:derive("SPlantGlobalObject")

function SPlantGlobalObject:new(luaSystem, globalObject)
	local o = SGlobalObject.new(self, luaSystem, globalObject)
	return o;
end

function SPlantGlobalObject.initModData(modData)
	modData.state = "plow"
	modData.nbOfGrow = -1
	modData.typeOfSeed = "none"
	modData.fertilizer = 0
	modData.mildewLvl = 0
	modData.aphidLvl = 0
	modData.fliesLvl = 0
	modData.slugsLvl = 0
	modData.hasWeeds = false
	modData.waterLvl = 0
	modData.waterNeeded = 0
	modData.waterNeededMax = nil
	modData.lastWaterHour = 0
	modData.hasSeed = false
	modData.hasVegetable = false
	modData.cursed = false
	modData.compost = false
	modData.bonusYield = false
	modData.health = SFarmingSystem.instance:getHealth()
	modData.badCare = false
	modData.exterior = true
	modData.spriteName = "vegetation_farming_01_1"
	modData.objectName = getText("Farming_Plowed_Land");
end

function SPlantGlobalObject:initNew()
	SPlantGlobalObject.initModData(self)
end

function SPlantGlobalObject:stateFromIsoObject(isoObject)
	self:initNew()
	self:fromModData(isoObject:getModData())
	self.objectName = isoObject:getName()
	self.spriteName = isoObject:getSpriteName()

	-- MapObjects-related code (see MOFarming.lua) might have changed the
	-- isoObject when it was loaded, we must sync with clients.
	if isServer() then
		isoObject:sendObjectChange('name')
		isoObject:sendObjectChange('sprite')
		isoObject:transmitModData()
	end
end

function SPlantGlobalObject:stateToIsoObject(isoObject)
	self.exterior = self:getSquare():isOutside()
	if tonumber(self.aphidLvl) then self.aphidLvl = math.min(self.aphidLvl, 100) end
	if tonumber(self.fliesLvl) then self.fliesLvl = math.min(self.fliesLvl, 100) end
	if tonumber(self.mildewLvl) then self.mildewLvl = math.min(self.mildewLvl, 100) end
	if tonumber(self.slugsLvl) then self.slugsLvl = math.min(self.slugsLvl, 100) end
-- 	if tonumber(self.weedLvl) then self.weedLvl = math.min(self.weedLvl, 100) end

	if self.lastWaterHour and self.lastWaterHour > SFarmingSystem.instance.hoursElapsed then
		if farming_vegetableconf.props[self.typeOfSeed] then
			if getCore():getDebug() and getDebugOptions():getBoolean("Cheat.Farming.FastGrow") then
				self.nextGrowing = SFarmingSystem.instance.hoursElapsed + 1
			else
				self.nextGrowing = SFarmingSystem.instance.hoursElapsed + farming_vegetableconf.props[self.typeOfSeed].timeToGrow
			end
		end
		self.lastWaterHour = SFarmingSystem.instance.hoursElapsed
		self:noise('reset lastWaterHour/nextGrowing on plant '..self.x..','..self.y)
	end

	isoObject:setName(self.objectName)
	isoObject:setSprite(self.spriteName)
	self:toModData(isoObject:getModData())

	if isServer() then
		isoObject:sendObjectChange('name')
		isoObject:sendObjectChange('sprite')
		isoObject:transmitModData()
	end
end

function SPlantGlobalObject:getObject()
	return self:getIsoObject()
end

function SPlantGlobalObject:setObjectName(objectName)
	if objectName == self.objectName then return end
	self.objectName = objectName
	local object = self:getObject()
	if object then
		object:setName(self.objectName)
		if isServer() then
			object:sendObjectChange('name')
		end
		-- objectName is stored in modData
		self:toModData(object:getModData())
		-- also update GameTime modData
	end
end

function SPlantGlobalObject:setSpriteName(spriteName)
	if spriteName == self.spriteName then return end
	self.spriteName = spriteName
	local object = self:getObject()
	if object then
		object:setSprite(self.spriteName)
		if isServer() then
			object:sendObjectChange('sprite')
		end
		-- spriteName is stored in modData
		self:toModData(object:getModData())
		-- also update GameTime modData
	end
end

function SPlantGlobalObject:isAlive()
	return self.state ~= "destroyed" and self.state ~= "dead" and self.state ~= "rotten" and self.state ~= "harvested"
end

function SPlantGlobalObject:hasVisibleFlies()
	return self.fliesLvl > 30
end

function SPlantGlobalObject:isBadMonth()
    if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then return false end
    if not self or self.typeOfSeed == nil then return end
	local prop = farming_vegetableconf.props[self.typeOfSeed]
	if not prop then return end
	if not prop.badMonth then return false end
    for i = 1, #prop.badMonth do
        if getGameTime():getMonth()+1 == prop.badMonth[i] then
            return true
        end
    end
    return false
end

function SPlantGlobalObject:isBadMonthHardy()
    if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then return false end
    if not self or self.typeOfSeed then return end
	local prop = farming_vegetableconf.props[self.typeOfSeed]
	if not prop then return end
	return prop.badMonthHardyLevel and self.nbOfGrow >= prop.badMonthHardyLevel
end

function SPlantGlobalObject:isColdHardy()
	local prop = farming_vegetableconf.props[self.typeOfSeed]
	if not prop then return end
	return prop.coldHardy
end

function SPlantGlobalObject:isSowMonth()
    if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then return false end
    if not self or self.typeOfSeed then return end
	local prop = farming_vegetableconf.props[self.typeOfSeed]
	if not prop then return end
	if not prop.sowMonth then return false end
    for i = 1, #prop.sowMonth do
        if getGameTime():getMonth() == prop.sowMonth[i] then
            return true
        end
    end
    return false
end

function SPlantGlobalObject:isBestMonth()
    if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then return false end
    if not self or self.typeOfSeed then return end
	local prop = farming_vegetableconf.props[self.typeOfSeed]
	if not prop then return end
	if not prop.bestMonth then return false end
    for i = 1, #prop.bestMonth do
        if getGameTime():getMonth() == prop.bestMonth[i] then
            return true
        end
    end
    return false
end

function SPlantGlobalObject:isRiskMonth()
    if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then return false end
    if not self or self.typeOfSeed then return end
	local prop = farming_vegetableconf.props[self.typeOfSeed]
	if not prop then return end
	if not prop.riskMonth then return false end
    for i = 1, #prop.riskMonth do
        if getGameTime():getMonth() == prop.riskMonth[i] then
            return true
        end
    end
    return false
end

function SPlantGlobalObject:canHarvest()
	return self:isAlive() and self.hasVegetable
end

function SPlantGlobalObject:addObject()
	if self:getObject() then return end
	local square = self:getSquare()
	if not square then return end
	local object = IsoObject.new(square, self.spriteName, self.objectName)
	object:setSpecialTooltip(true);
	self:toModData(object:getModData())
	square:AddTileObject(object)
	object:transmitCompleteItemToClients()
end

function SPlantGlobalObject:removeObject()
	self:removeIsoObject()
end

-- if the plant doesn't have mildew, maybe it will have it !
-- base risk for mildew is 2%, but every pt of water below the required water lvl add 1% risk
function SPlantGlobalObject:mildew()
--     local prop = farming_vegetableconf.props[self.typeOfSeed]
    if self:defaultDiseaseCheck() and self.mildewLvl == 0 then self.mildewLvl = 1 end
-- 	local mildewNumber = 2
-- 	local waterBelow = self.waterNeeded - self.waterLvl
-- 	-- our plant is well watered
-- 	if(waterBelow <= 0) then
-- 		waterBelow = 0
-- 	end
-- 	mildewNumber = mildewNumber + waterBelow
-- 	if SandboxVars.PlantResilience == 1 then -- very high
-- 		mildewNumber = mildewNumber - 8;
-- 	elseif SandboxVars.PlantResilience == 2 then -- high
-- 		mildewNumber = mildewNumber - 4;
-- 	elseif SandboxVars.PlantResilience == 4 then -- low
-- 		mildewNumber = mildewNumber + 4;
-- 	elseif SandboxVars.PlantResilience == 5 then -- very low
-- 		mildewNumber = mildewNumber + 8;
-- 	end
-- 	if mildewNumber < 0 then
-- 		mildewNumber = 0;
-- 	end
-- 	-- random !
-- 	-- plants take longer to grow + we want less disease jumping between plants to the chance was doubled.
-- 	if ZombRand(200 - (mildewNumber * 2)) == 0 then
-- 	-- if ZombRand(101 - mildewNumber) == 0 then
-- 	-- you got mildew !
-- 		self.mildewLvl = 1
--     end
end

-- if the plant doesn't have aphid, maybe it will have it !
-- base risk for aphid is 2%, but every pt of water below the required water lvl add 1% risk
function SPlantGlobalObject:aphid()
	local prop = farming_vegetableconf.props[self.typeOfSeed]
	if prop.aphidsBane or prop.aphidsProof then return end
    if self:defaultDiseaseCheck() and self.aphidLvl == 0 and (getClimateManager():getSeasonName() ~= "Winter" or not self.exterior) and season.currentTemp > 10 then self.aphidLvl = 1 end
-- 	local aphidNumber = 2
-- 	local waterBelow = self.waterNeeded - self.waterLvl
-- 	-- our plant is well watered
-- 	if(waterBelow <= 0) then
-- 		waterBelow = 0
-- 	end
-- 	aphidNumber = aphidNumber + waterBelow
-- 	if SandboxVars.PlantResilience == 1 then -- very high
-- 		aphidNumber = aphidNumber - 8;
-- 	elseif SandboxVars.PlantResilience == 2 then -- high
-- 		aphidNumber = aphidNumber - 4;
-- 	elseif SandboxVars.PlantResilience == 4 then -- low
-- 		aphidNumber = aphidNumber + 4;
-- 	elseif SandboxVars.PlantResilience == 5 then -- very low
-- 		aphidNumber = aphidNumber + 8;
-- 	end
-- 	if aphidNumber < 0 then
-- 		aphidNumber = 0;
-- 	end
-- 	-- random !
-- 	-- plants take longer to grow + we want less disease jumping between plants to the chance was doubled.
-- 	if ZombRand(200 - (aphidNumber * 2)) == 0 then
-- 	-- if ZombRand(101 - aphidNumber) == 0 then
-- 	-- you got aphid !
-- 		self.aphidLvl = 1
--     end
end

-- if the plant doesn't have flies, maybe it will have it !
-- base risk for flies is 2%, but every pt of water below the required water lvl add 1% risk
function SPlantGlobalObject:flies()
    local prop = farming_vegetableconf.props[self.typeOfSeed]
	if prop.fliesBane or prop.fliesProof then return end
    if self:defaultDiseaseCheck() and self.fliesLvl == 0 and (getClimateManager():getSeasonName() ~= "Winter" or not self.exterior) and season.currentTemp > 10 then self.fliesLvl = 1 end
-- 	local fliesNumber = 2
-- 	local waterBelow = self.waterNeeded - self.waterLvl
-- 	-- our plant is well watered
-- 	if(waterBelow <= 0) then
-- 		waterBelow = 0
-- 	end
-- 	fliesNumber = fliesNumber + waterBelow
-- 	if SandboxVars.PlantResilience == 1 then -- very high
-- 		fliesNumber = fliesNumber - 8;
-- 	elseif SandboxVars.PlantResilience == 2 then -- high
-- 		fliesNumber = fliesNumber - 4;
-- 	elseif SandboxVars.PlantResilience == 4 then -- low
-- 		fliesNumber = fliesNumber + 4;
-- 	elseif SandboxVars.PlantResilience == 5 then -- very low
-- 		fliesNumber = fliesNumber + 8;
-- 	end
-- 	if fliesNumber < 0 then
-- 		fliesNumber = 0;
-- 	end
-- 	-- random !
-- 	-- plants take longer to grow + we want less disease jumping between plants to the chance was doubled.
-- 	if ZombRand(200 - (fliesNumber * 2)) == 0 then
-- 	-- 	if ZombRand(101 - fliesNumber) == 0 then
-- 	-- you got flies !
-- 		self.fliesLvl = 1
--     end
end

function SPlantGlobalObject:slugs()
    local prop = farming_vegetableconf.props[self.typeOfSeed]
	if prop.slugsBane or prop.slugsProof then return end
    if self:defaultDiseaseCheck() and self.slugsLvl == 0 and (getClimateManager():getSeasonName() ~= "Winter" or not self.exterior) and season.currentTemp > 10 then self.slugsLvl = 1 end
end

function SPlantGlobalObject:defaultDiseaseCheck()
   	local chance = 0
   	local waterBelow = self.waterNeeded - self.waterLvl
   	-- our plant is well watered
   	if(waterBelow <= 0) then
   		waterBelow = 0
   	end
   	chance = chance + waterBelow
   	if SandboxVars.PlantResilience == 1 then -- very high
   		chance = chance - 8;
   	elseif SandboxVars.PlantResilience == 2 then -- high
   		chance = chance - 4;
   	elseif SandboxVars.PlantResilience == 4 then -- low
   		chance = chance + 4;
   	elseif SandboxVars.PlantResilience == 5 then -- very low
   		chance = chance + 8;
   	end
   	if chance < 0 then
   		chance = 0;
   	end
   	-- random !
   	-- plants take longer to grow + we want less disease jumping between plants so the chance was reduced.
   	-- but weeds and being cursed increase the chance!
   	local roll = 200
   	if self.bonusYield then roll = roll*2 end
   	if self.hasWeeds then roll = roll/2 end
   	if self.cursed then roll = roll/2 end
    if ZombRand(roll) <= chance then
        return true
    end
    return false;
 end

-- up the disease by a number, it's the double if your plant is not well watered
function SPlantGlobalObject:upDisease()
    local water = farming_vegetableconf.calcWater(self.waterNeeded, self.waterLvl)
	-- mildew lvl up by 1 or 0.5 if your plant is well watered
	if self.mildewLvl ~= nil and self.mildewLvl > 0  then
		if(water >= 0) then
			self.mildewLvl = self.mildewLvl + 0.5
		else
			self.mildewLvl = self.mildewLvl + 1
		end
		self.mildewLvl = math.min(self.mildewLvl, 100)
	end
	-- flies lvl up by 1 or 0.5 if your plant is well watered
	if self.fliesLvl ~= nil and self.fliesLvl > 0  then
        local hasFlies = self:hasVisibleFlies()
		if getClimateManager():getSeasonName() == "Winter" and self.exterior then
            local hasFlies = self:hasVisibleFlies()
			self.fliesLvl = self.fliesLvl - 2
			if self.fliesLvl < 0 then
				self.fliesLvl = 0
			end
	        if hasFlies and not self:hasVisibleFlies() and self:getSquare() then self:getSquare():setHasFlies(false) end
		elseif(water >= 0) then
			self.fliesLvl = self.fliesLvl + 0.5
		    self.fliesLvl = math.min(self.fliesLvl, 100)
		else
			self.fliesLvl = self.fliesLvl + 1
		    self.fliesLvl = math.min(self.fliesLvl, 100)
		end
	end
	if self.slugsLvl ~= nil and self.slugsLvl > 0 then
		if getClimateManager():getSeasonName() == "Winter" and self.exterior then
			self.slugsLvl = self.slugsLvl - 2
			if self.slugsLvl < 0 then
				self.slugsLvl = 0
			end
		elseif(water >= 0) then
			self.slugsLvl = self.slugsLvl + 0.5
		    self.slugsLvl = math.min(self.slugsLvl, 100)
		else
			self.slugsLvl = self.slugsLvl + 1
		    self.slugsLvl = math.min(self.slugsLvl, 100)
		end
	end
	-- aphid is different than mildew, you'll have to deshydrate your plant to lower the aphid lvl
	if self.aphidLvl ~= nil and self.aphidLvl > 0 then
		if water == -1 or water == -2 or (getClimateManager():getSeasonName() == "Winter" and self.exterior) then
			self.aphidLvl = self.aphidLvl - 2
			if self.aphidLvl < 0 then
				self.aphidLvl = 0
			end
		else
			self.aphidLvl = self.aphidLvl + 1
			self.aphidLvl = math.min(self.aphidLvl, 100)
		end
	end
end

-- lower by 1 the waterLvl of all our plant
function SPlantGlobalObject:lowerWaterLvl(plant)
	if self.waterLvl ~= nil then
		local waterChange = 1
		if self.hasWeeds then waterChange = waterChange * 2 end
		-- flies make water dry more quickly, every 10 pts of flies, water lower by 1 more pts
		local waterFliesChanger = math.floor(self.fliesLvl / 10)
		self.waterLvl = self.waterLvl - waterChange - waterFliesChanger
		if self.waterLvl < 0 then
			self.waterLvl = 0
		end
	end
end

-- if we add mildew spray
function SPlantGlobalObject:cureMildew(mildewCureSource, uses, skill)
    if not skill then skill = 0 end
	for i=1,uses do
		if mildewCureSource then
			mildewCureSource:Use()
		end
		local kill = 10 + skill
		self.mildewLvl = self.mildewLvl - kill
		if self.mildewLvl < 0 then
			self.mildewLvl = 0
		end
	end
	self:saveData()
end

-- if we add insecticide spray
function SPlantGlobalObject:cureFlies(fliesCureSource, uses, skill)
    if not skill then skill = 0 end
    local hasFlies = self:hasVisibleFlies()
	for i=1,uses do
		if fliesCureSource then
			fliesCureSource:Use()
		end
		local kill = 10 + skill
		self.fliesLvl = self.fliesLvl - kill
		if self.fliesLvl < 0 then
			self.fliesLvl = 0
		end
	end
	if hasFlies and not self:hasVisibleFlies() and self:getSquare() then self:getSquare():setHasFlies(false) end
	self:saveData()
end

function SPlantGlobalObject:cureAphids(aphidsCureSource, uses, skill)
    if not skill then skill = 0 end
	for i=1,uses do
		if aphidsCureSource then
			aphidsCureSource:Use()
		end
		local kill = 10 + skill
		self.aphidLvl = self.aphidLvl - kill
		if self.aphidLvl < 0 then
			self.aphidLvl = 0
		end
	end
	self:saveData()
end

function SPlantGlobalObject:cureSlugs(slugsCureSource, uses, skill)
    if not skill then skill = 0 end
	for i=1,uses do
		if slugsCureSource then
			slugsCureSource:Use()
		end
		local kill = 10 + skill
		self.slugsLvl = self.slugsLvl - kill
		if self.slugsLvl < 0 then
			self.slugsLvl = 0
		end
	end
	self:saveData()
end

-- if we water our plant
-- we gonna add 5 water lvl for the plant for each use of the water source
function SPlantGlobalObject:water(waterSource, uses)
	for i=1,uses do
		if self.waterLvl < 100 then
			if waterSource then
				if waterSource:getCurrentUsesFloat() > 0 then
					waterSource:Use()
				end
			end
			self.waterLvl = self.waterLvl + 10
			if self.waterLvl > 100 then
				self.waterLvl = 100
			end
		end
	end
	-- we notice the hour of our last water, because if we don't water the plant every 48 hours, she die
	self.lastWaterHour = SFarmingSystem.instance.hoursElapsed;
	self:saveData()
end

-- fertilize the plant, more than 4 doses and your plant die ! (no mercy !)
function SPlantGlobalObject:fertilize(args)
    local skill = args.skill
	if self.state ~= "plow" and self:isAlive() then
	    -- compost is different as it can't kill a plant
	    if args.compost then
-- 	        print("Skill " .. tostring(skill))
	        self:compostPlant(skill)
	        return
	    end
        self.fertilizer = self.fertilizer + 1
		if self.fertilizer == 1  then
		    self:fertilize2(skill)
-- 		    -- there's no benefit to fertilizing in winter
-- 		    if getClimateManager():getSeasonName() ~= "Winter" or getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then
--                 -- increase the effect on time reduction as plants take longer to grow now
--                 local growChange = 80
--                 if self.hasWeeds then growChange = growChange/2 end
--                 self.nextGrowing = self.nextGrowing - growChange
--     -- 			self.nextGrowing = self.nextGrowing - 20
--                 if self.nextGrowing < 1 then
--                     self.nextGrowing = 1
--                 end
--                 local prop = farming_vegetableconf.props[self.typeOfSeed]
--                 if (prop.harvestLevel and self.nbOfGrow < prop.harvestLevel) or not prop.harvestLevel  and not self.hasWeeds then
--                     self.health = self.health + 25
--                 end
--                 -- fertilizer will boost the yield of a crop if applied at the start
--                 if self.nbOfGrow <= 2 and not self.cursed and not self.hasWeeds then
--                     self.bonusYield = true
--                 end
--             end
		elseif  self.fertilizer == 2  then
            self.health = self.health - 25
		elseif self.fertilizer > 2  then -- too much fertilizer and our plant cursed !
            self.cursed = true
            self.health = self.health - 25
		end
        if self.health <= 0 then
            self.health = 0
            self:killThis()
        end
		self:saveData()
	end
end



function SPlantGlobalObject:compostPlant(skill)
    if not skill then skill = 0 end
    -- if the plant is already fertilized, no benefits
    if self.compost then return end
    self.compost = true
    self:fertilize2(skill)
    self:saveData()
    -- there's no benefit to fertilizing in winter
--     if getClimateManager():getSeasonName() ~= "Winter" or getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then
--         -- increase the effect on time reduction as plants take longer to grow now
--         local growChange = 80
--         if self.hasWeeds then growChange = growChange/2 end
--         self.nextGrowing = self.nextGrowing - growChange
-- -- 			self.nextGrowing = self.nextGrowing - 20
--         if self.nextGrowing < 1 then
--             self.nextGrowing = 1
--         end
--         local prop = farming_vegetableconf.props[self.typeOfSeed]
--         if (prop.harvestLevel and self.nbOfGrow < prop.harvestLevel) or not prop.harvestLevel  and not self.hasWeeds then
--             self.health = self.health + 25
--         end
--         -- fertilizer will boost the yield of a crop if applied at the start
--         if self.nbOfGrow <= 2 and not self.cursed and not self.hasWeeds then
--             self.bonusYield = true
--         end
--     end
end

function SPlantGlobalObject:fertilize2(skill)
    if not skill then skill = 0 end
    -- there's no benefit to fertilizing in winter
    if getClimateManager():getSeasonName() ~= "Winter" or getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == false then
        -- increase the effect on time reduction as plants take longer to grow now
        local growChange = 40
        if self.hasWeeds then growChange = growChange/2 end
        self.nextGrowing = self.nextGrowing - growChange
-- 			self.nextGrowing = self.nextGrowing - 20
        if self.nextGrowing < 1 then
            self.nextGrowing = 1
        end
        local prop = farming_vegetableconf.props[self.typeOfSeed]
        if (prop.harvestLevel and self.nbOfGrow < prop.harvestLevel) or not prop.harvestLevel  and not self.hasWeeds then
            self.health = self.health + 10
        end
        -- fertilizer can boost the yield of a crop if applied at the start

        if self.nbOfGrow <= 3 and not self.cursed and not self.hasWeeds and ZombRand(20) < (9 + skill) then
            self.bonusYield = true
        end
        if self.health > 100 then
            self.health = 100
        end
    end
end

-- check the stat to make them ok (if water < 0 we set it to 0 for example)
-- if health < 0 the plant is dead (dry)
function SPlantGlobalObject:checkStat()
    if not self:isAlive() then return end
--     print("TEXT Y" .. tostring(self))
--     print("TEXT X" .. tostring(self.state))
--     print("TEXT Z" .. tostring(self.nbOfGrow))
	if self.state ~= "plow" and self.nbOfGrow > 1 then
		if self.waterLvl <= 0 then
			self:dryThis()
		elseif self.waterLvl > 100 then
			self.waterLvl = 100
		end
		if self.health <= 0 then
			self:killThis()
-- 			self:dryThis()
		end
	end
	if self.waterLvl < 0 then
		self.waterLvl = 0
	end
	if self.health < 0 then
		self.health = 0
	elseif self.health > 100 then
		self.health = 100
	end
end

function SPlantGlobalObject:killThis()
	self.state = "dead"
	self:setSpriteName(farming_vegetableconf.getSpriteName(self))
	self:setObjectName(farming_vegetableconf.getObjectName(self))
	self:deadPlant()
end

-- make the plant dry (no more water !)
function SPlantGlobalObject:dryThis()
-- 	if self.typeOfSeed == "Tomato" then
-- 		self:setSpriteName("vegetation_farming_01_6")
-- 	else
-- 		self:setSpriteName("vegetation_farming_01_5")
-- 	end
	self.state = "dead"
	self:setSpriteName(farming_vegetableconf.getSpriteName(self))
	self:setObjectName(farming_vegetableconf.getObjectName(self))
	self:deadPlant()
end

function SPlantGlobalObject:rottenThis()
-- 	local texture = nil
-- 	if self.typeOfSeed == "Carrots" then
-- 		texture = "vegetation_farming_01_13"
-- 	elseif self.typeOfSeed == "Broccoli" then
-- 		texture = "vegetation_farming_01_23"
-- 	elseif self.typeOfSeed == "Strawberryplant" then
-- 		texture = "vegetation_farming_01_63"
-- 	elseif self.typeOfSeed == "Radishes" then
-- 		texture = "vegetation_farming_01_39"
-- 	elseif self.typeOfSeed == "Tomato" then
-- 		texture = "vegetation_farming_01_71"
-- 	elseif self.typeOfSeed == "Potatoes" then
-- 		texture = "vegetation_farming_01_47"
-- 	elseif self.typeOfSeed == "Cabbages" then
-- 		texture = "vegetation_farming_01_31"
-- 	end
-- 	self:setSpriteName(texture)
	self.state = "rotten"
	self:setSpriteName(farming_vegetableconf.getSpriteName(self))
	self:setObjectName(farming_vegetableconf.getObjectName(self))
	self:deadPlant()
end

-- destroy the plant (someone walked on it :))
function SPlantGlobalObject:destroyThis()
	-- tomato has different smashed tile
-- 	if self.typeOfSeed == "Tomato" then
-- 		self:setSpriteName("vegetation_farming_01_14")
-- 	else
-- 		self:setSpriteName("vegetation_farming_01_13")
-- 	end
	self.state = "destroyed"
	self:setSpriteName(farming_vegetableconf.getSpriteName(self))
	self:setObjectName(farming_vegetableconf.getObjectName(self))
	self:deadPlant()
-- 	self:saveData()
end
-- change the plant to a destroyed yet harvested state
function SPlantGlobalObject:harvestThis()
	self.state = "harvested"
	self:setSpriteName(farming_vegetableconf.getSpriteName(self))
	self:setObjectName(farming_vegetableconf.getObjectName(self))
	self:deadPlant()
-- 	self:saveData()
end

function SPlantGlobalObject:seed(typeOfSeed, skill)
    if not skill then skill = 0 end
	-- will set the first growing state for the type of seed
	self.nbOfGrow = 0
	self.state = "seeded"
	self.typeOfSeed = typeOfSeed
	-- You have 48 hours to water your plant, if not, she will be dry
	self.lastWaterHour = SFarmingSystem.instance.hoursElapsed
	self.waterNeeded = 0
	SFarmingSystem.instance:growPlant(self, nil, true)
    if getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == true then
        if not self:isSowMonth() then self.cursed = true
        elseif self:isRiskMonth() and ZombRand(20) < (11 - skill) then self.cursed = true
        elseif self:isBestMonth() and ZombRand(20) < (9 + skill) then self.bonusYield = true
        end
    end
    self:initHealth(skill)
	self:setSpriteName(farming_vegetableconf.getSpriteName(self))
	self:saveData()
end

function SPlantGlobalObject:initHealth(skill)
    local seasons = getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == true
    if not skill then skill = 0 end
    if seasons and self:isBestMonth() then
		self.health = ZombRand(57, 64) + skill
    elseif seasons and self.cursed then
		self.health = ZombRand(37, 44) + skill
    else
        self.health =  SFarmingSystem.instance:getHealth() + skill
    end
end

function SPlantGlobalObject:deadPlant()
    if self:getSquare() and self:hasVisibleFlies() then self:getSquare():setHasFlies(false) end
	self.nextGrowing = 0
	self.waterLvl = 0
-- 	self.nbOfGrow = 0
	self.mildewLvl = 0
	self.aphidLvl = 0
	self.fliesLvl = 0
	self.slugsLvl = 0
	self.hasWeeds = false
	self.naturalLight = 1
	self.health = 0
	self.hasSeeds = false
	self.hasVegetable = false
	self.cursed = false
	self.compost = false
	self.bonusYield = false
	self:saveData()
end

function SPlantGlobalObject:addIcon()
end

function SPlantGlobalObject:saveData()
	local isoObject = self:getIsoObject()
	if isoObject then
		self:toModData(isoObject:getModData())
		isoObject:transmitModData()
	end
end

function SPlantGlobalObject:fromModData(modData)
	self.state = modData.state
	self.nbOfGrow = modData.nbOfGrow
	self.typeOfSeed = modData.typeOfSeed
	self.fertilizer = modData.fertilizer
	self.mildewLvl = modData.mildewLvl
	self.aphidLvl = modData.aphidLvl
	self.fliesLvl = modData.fliesLvl
	self.slugsLvl = modData.slugsLvl
-- 	self.weedLvl = modData.weedLvl
	self.hasWeeds = modData.hasWeeds == "true" or modData.hasWeeds == true
	self.naturalLight = modData.naturalLight
	self.waterLvl = modData.waterLvl
	self.waterNeeded = modData.waterNeeded
	self.waterNeededMax = modData.waterNeededMax
	self.lastWaterHour = modData.lastWaterHour
	self.nextGrowing = modData.nextGrowing
	self.hasSeed = modData.hasSeed == "true" or modData.hasSeed == true
	self.hasVegetable = modData.hasVegetable == "true" or modData.hasVegetable == true
	self.cursed = modData.cursed == "true" or modData.cursed == true
	self.compost = modData.compost == "true" or modData.compost == true
	self.bonusYield = modData.bonusYield == "true" or modData.bonusYield == true
	self.health = modData.health
	self.badCare = modData.badCare == "true" or modData.badCare == true
	self.exterior = modData.exterior == true or modData.exterior == nil
	self.spriteName = modData.spriteName
	self.objectName = modData.objectName
	if not self.spriteName then -- old-style modData
		self.spriteName = farming_vegetableconf.getSpriteName(self)
	end
	if not self.objectName then -- old-style modData
		self.objectName = farming_vegetableconf.getObjectName(self)
	end
end

function SPlantGlobalObject:toModData(modData)
	modData.state = self.state
	modData.nbOfGrow = self.nbOfGrow
	modData.typeOfSeed = self.typeOfSeed
	modData.fertilizer = self.fertilizer
	modData.mildewLvl = self.mildewLvl
	modData.aphidLvl = self.aphidLvl
	modData.fliesLvl = self.fliesLvl
	modData.slugsLvl = self.slugsLvl
	modData.naturalLight= self.naturalLight
	modData.hasWeeds = self.hasWeeds
	modData.waterLvl = self.waterLvl
	modData.waterNeeded = self.waterNeeded
	modData.waterNeededMax = self.waterNeededMax
	modData.lastWaterHour = self.lastWaterHour
	modData.nextGrowing = self.nextGrowing
	modData.hasSeed = self.hasSeed
	modData.hasVegetable = self.hasVegetable
	modData.cursed = self.cursed
	modData.compost = self.compost
	modData.bonusYield = self.bonusYield
	modData.health = self.health
	modData.badCare = self.badCare
	modData.exterior = self.exterior
	modData.spriteName = self.spriteName
	modData.objectName = self.objectName
end

function SPlantGlobalObject:fromObject(object)
	self:initFromIsoObject(object)
end

function SPlantGlobalObject:loadGridSquare()
	local isoObject = self:getObject()
	if not isoObject then return end
	self:loadIsoObject(isoObject)
end