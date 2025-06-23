-----------------------------------------------------------------------
--                          FARMING MOD                              --
--                      CODE BY ROBERT JOHNSON                       --
--                       TEXTURES BY THUZTOR                         --
-----------------------------------------------------------------------
--                          OFFICIAL TOPIC                           --
--  http://www.theindiestone.com/community/viewtopic.php?f=33&t=8675 --
--                                                                   --
-----------------------------------------------------------------------

farming_vegetableconf = {};

-- fetch our item in the container, if it's the vegetable we want, we add seeds to it
function getNbOfSeed(nbOfSeed, typeOfPlant, container)
	local result = 0;
	for i = 0, container:getItems():size() - 1 do
		local item = container:getItems():get(i);
		if item:getType() == typeOfPlant then
			result = result + nbOfSeed;
		end
	end
	return result;
end

-- return the number of vegtable you gain with your xp
-- every 10 points over 50 health you plant have = 1 more vegetable
function getVegetablesNumber(min, max, minAutorized, maxAutorized, plant, skill)

-- new version
-- plant.getVegetablesNumber(skill)


    if not skill then skill = 0 end
	local healthModifier = math.floor((plant.health - 50) /10);
	local aphidModifier = math.floor(plant.aphidLvl/10);
	local slugModifier = math.floor(plant.slugsLvl/10);
	local pestModifier = aphidModifier + slugModifier
-- 	if healthModifier < 0 then
-- 		healthModifier = 0;
--     end
-- 	if healthModifier >= 0 then
-- 		healthModifier = healthModifier + plant.fertilizer;
--     end

    local vegModifier = 0 -- + plant.fertilizer;
    if plant.bonusYield and not plant.cursed then
        vegModifier = vegModifier + 1
    end
--     if SandboxVars.PlantAbundance == 1 then -- very poor
--         vegModifier = -4;
--     elseif SandboxVars.PlantAbundance == 2 then -- poor
--         vegModifier = -2;
--     elseif SandboxVars.PlantAbundance == 4 then -- abundant
--         vegModifier = 3;
--     elseif SandboxVars.PlantAbundance == 5 then -- very abundant
--         vegModifier = 5;
--     end


	local minV = min + healthModifier;
	local maxV = max + healthModifier;
	if minV > (minAutorized + vegModifier) then
		minV = minAutorized + vegModifier;
	end
	if maxV > (maxAutorized  + vegModifier) then
		maxV = maxAutorized + vegModifier;
	end
	-- I have to add 1 to the maxV, don't know why but the zombRand never take the last digit (ex, between 5 and 10, you'll never have 10...)
	local nbOfVegetable = ZombRand(minV, maxV + 1);
    if plant.bonusYield and not plant.cursed then
        nbOfVegetable = math.max( nbOfVegetable, ZombRand(minV, maxV + 1) )
    end
-- 	-- every 10 pts of aphid lower by 1 the vegetable you'll get
-- 	-- every 10 pts of slug lower by 1 the vegetable you'll get
	nbOfVegetable = nbOfVegetable - pestModifier;

    if ZombRand(10) < skill then nbOfVegetable = nbOfVegetable + skill end
--     if plant.bonusYield then
--         numberOfVeg = math.floor(nbOfVegetable * 1.25)
--     end

	local sandboxYield = getSandboxOptions():getOptionByName("FarmingAmountNew"):getValue()
	numberOfVeg = math.floor(nbOfVegetable * sandboxYield)
	if nbOfVegetable < 1 then nbOfVegetable = 1 end
	return nbOfVegetable;
end

function randomGrowthOffset()
    return ZombRand(25)-12
end

function calcNextGrowing(nextGrowing, nextTime)
	if nextGrowing then
		return nextGrowing;
	end
	nextTime = nextTime * calcNextTimeFactor()
--     if SandboxVars.Farming == 1 then -- very fast
--         nextTime = nextTime / 3;
--     end
--     if SandboxVars.Farming == 2 then -- fast
--         nextTime = nextTime / 1.5;
--     end
--     if SandboxVars.Farming == 4 then -- slow
--         nextTime = nextTime * 1.5;
--     end
--     if SandboxVars.Farming == 5 then -- very slow
--         nextTime = nextTime * 3;
--     end
	nextTime = nextTime + randomGrowthOffset()
	if nextTime <= 0 then nextTime = 1 end
	return SFarmingSystem.instance.hoursElapsed + nextTime;
end

function calcNextTimeFactor()
	local nextTime = 1
	local sandboxTime = getSandboxOptions():getOptionByName("FarmingSpeedNew"):getValue()
	nextTime = nextTime / sandboxTime
-- 	if nextTime < 1 then nextTime = 1 end
--     if SandboxVars.Farming == 1 then -- very fast
--         nextTime = nextTime / 3;
--     end
--     if SandboxVars.Farming == 2 then -- fast
--         nextTime = nextTime / 1.5;
--     end
--     if SandboxVars.Farming == 4 then -- slow
--         nextTime = nextTime * 1.5;
--     end
--     if SandboxVars.Farming == 5 then -- very slow
--         nextTime = nextTime * 3;
--     end
	return nextTime;
end

function growNext(planting, nameOfTile, nextGrowing, howManyTime)
	planting.nextGrowing = calcNextGrowing(nextGrowing, howManyTime)
	planting:setObjectName(nameOfTile)
	return planting
end

farming_vegetableconf.calcWater = function(waterMin, waterLvl)
	if waterLvl and waterMin then
		-- 1 test, our water lvl is > of our waterMin, it's ok, your plant can grow !
		if waterLvl >= waterMin then
			return 0;
		-- 2 test, our waterLvl is less than 10% less than waterMin, your plant can grow but with more hours (ex : lvlMin 70, you have 65 -> your plant grow + 10 hours)
		elseif waterLvl >= math.floor(waterMin /  1.10) then
			return waterMin - waterLvl;
		-- 3 test, our waterLvl is > 30% less than required waterLvl, your plant can't grow, and the next growing state will be in 5 hours
		elseif waterLvl >= math.floor(waterMin /  1.30) then
			return -1;
		-- if the waterLvl is the plant < 30% less than requiredLvl, the plant will be dead !
		else
			return -2;
		end
	else -- if we're here, it's because of waterMax, we gonna return 0, it's ok, we don't need waterMax for now :)
		return 0;
	end
end

-- check if the disease will up the next time the plant grow
farming_vegetableconf.calcDisease = function(diseaseLvl)
	if diseaseLvl > 0 then
		-- < 10 it's ok
		if diseaseLvl < 10 then
			return 0;
		-- < 30 -> diseaseLvl = hours in supplement for next growing phase
		elseif diseaseLvl < 30 then
			return diseaseLvl;
		elseif diseaseLvl < 60 then -- plant don't grow if disease between 30 and 60
			return -1;
		else -- plant die if disease > 60
			return -2;
		end
	end
	return 0;
end

farming_vegetableconf.getObjectPhase = function(plant)
    local prop = farming_vegetableconf.props[plant.typeOfSeed]
    if plant.hasSeed then
        return getText("Farming_In_bloom");
--         return getText("Farming_Seed_bearing");
    elseif plant.hasVegetable then
        return getText("Farming_Ready_to_harvest");
    elseif plant.nbOfGrow and plant.nbOfGrow == prop.harvestLevel then
        return getText("Farming_Harvest_Soon");
    elseif plant.nbOfGrow and plant.nbOfGrow <= 2 then
        return getText("Farming_Seedling");
    else
        return getText("Farming_Young");
    end
    return false
end

-- get the object name depending on his current phase
farming_vegetableconf.getObjectName = function(plant)

--     local prop = farming_vegetableconf.props[plant.typeOfSeed]

	if plant.state == "plow" then return getText("Farming_Plowed_Land")
	elseif plant.state == "destroyed" then return getText("Farming_Destroyed") .. " " .. getText("Farming_" .. plant.typeOfSeed)
	elseif plant.state == "dead" then return getText("Farming_Dead") .. " " .. getText("Farming_" .. plant.typeOfSeed)
	elseif plant.state == "rotten" then return getText("Farming_Rotten") .. " " .. getText("Farming_" .. plant.typeOfSeed)
	elseif plant.state == "harvested" then return getText("Farming_Harvested") .. " " .. getText("Farming_" .. plant.typeOfSeed) end
    return farming_vegetableconf.getObjectPhase(plant) .. " " .. getText("Farming_" ..plant.typeOfSeed);

--     if plant.hasSeed then
--         return getText("Farming_Seed_bearing");
--     elseif plant.hasVegetable then
--         return getText("Farming_Ready_to_harvest");
--     elseif plant.nbOfGrow == prop.harvestLevel - 1 then
--         return getText("Farming_Harvest_Soon");
--     elseif plant.nbOfGrow <= 2 then
--         return getText("Farming_Seedling");
--     else
--         return getText("Farming_Young");
--     end



--     if plant:isAlive() then
--     if plant.hasSeed then
--         return getText("Farming_Seed-bearing") .. " " .. getText("Farming_" ..plant.typeOfSeed);
--     elseif plant.hasVegetable then
--         return getText("Farming_Ready_for_Harvest") .. " " .. getText("Farming_" ..plant.typeOfSeed);
--     elseif plant.nbOfGrow <= 1 then
--         return getText("Farming_Seedling") .. " " .. getText("Farming_" ..plant.typeOfSeed);
--     else
--         return getText("Farming_Young") .. " " .. getText("Farming_" ..plant.typeOfSeed);
--     end
--     end

-- 	if plant.nbOfGrow <= 1 then
-- 		return getText("Farming_Seedling") .. " " .. getText("Farming_" ..plant.typeOfSeed);
-- 	elseif plant.nbOfGrow <= 4 then
-- 		return getText("Farming_Young") .. " " .. getText("Farming_" ..plant.typeOfSeed);
-- 	elseif plant.nbOfGrow == 5 then
--         if plant.typeOfSeed == "Tomato" then
--             return getText("Farming_Young") .. " " .. getText("Farming_" ..plant.typeOfSeed);
--         end
-- 		if plant.typeOfSeed == "Strawberryplant" or plant.typeOfSeed == "Potatoes" then
-- 			return getText("Farming_In_bloom") .. " " .. getText("Farming_" ..plant.typeOfSeed);
-- 		else
-- 			return getText("Farming_Ready_for_Harvest") .. " " .. getText("Farming_" ..plant.typeOfSeed);
-- 		end
-- 	elseif plant.nbOfGrow == 6 then
-- 		return getText("Farming_Seed-bearing") .. " " .. getText("Farming_" ..plant.typeOfSeed);
-- 	end
-- 	return "Mystery Plant"
end

farming_vegetableconf.getSpriteName = function(plant)
	local prop = farming_vegetableconf.props[plant.typeOfSeed]
    local nbOfGrow = plant.nbOfGrow
	if plant.state == "plow" then return "vegetation_farming_01_1" end
    local spriteType = "sprite"
    local health = math.min(plant.health, plant.waterLvl)
    local disease = math.max(plant.mildewLvl, plant.aphidLvl)
    local disease = math.max(disease, plant.slugsLvl)
    if plant.state == "destroyed" or plant.state == "harvested" then
        spriteType = "trampledSprite"
--     elseif plant.state == "rotten"  and stage > 6  then
--         spriteType = "sprite"
--         nbOfGrow = nbOfGrow + 1
    elseif plant.state == "dead" or plant.state == "rotten" then
        spriteType = "deadSprite"
    elseif health < 25 or disease >= 30 then
        spriteType = "dyingSprite"
    elseif health < 50 or disease >= 10 or plant.fertilizer > 1 then
        spriteType = "unhealthySprite"
    end
    if farming_vegetableconf[spriteType] and farming_vegetableconf[spriteType][plant.typeOfSeed] and farming_vegetableconf[spriteType][plant.typeOfSeed][nbOfGrow]  then
        return farming_vegetableconf[spriteType][plant.typeOfSeed][nbOfGrow]
    end
end

farming_vegetableconf.grow = function(planting, nextGrowing, updateNbOfGrow)
	local nbOfGrow = planting.nbOfGrow;
	local water = farming_vegetableconf.calcWater(planting.waterNeeded, planting.waterLvl);
	local waterMax = farming_vegetableconf.calcWater(planting.waterLvl, planting.waterNeededMax);
	local diseaseLvl = farming_vegetableconf.calcDisease(planting.mildewLvl);
	local prop = farming_vegetableconf.props[planting.typeOfSeed]
	local name = farming_vegetableconf.getObjectName(planting)

    if planting.fertilizer >= 1 then
        planting.fertilizer = planting.fertilizer - 1
    end
    planting.compost = false
	local cheat = getCore():getDebug() and getDebugOptions():getBoolean("Cheat.Farming.FastGrow")
	if (nbOfGrow > prop.fullGrown) then -- rotten
        planting:rottenThis()
	elseif (nbOfGrow == prop.fullGrown) then -- mature with seed
		if(water >= 0 and waterMax >= 0 and diseaseLvl >= 0) then
		    local rotTime = prop.rotTime or math.floor(prop.timeToGrow/2)
			planting.nextGrowing = calcNextGrowing(nextGrowing, rotTime);
			planting:setObjectName(name)
-- 			planting.hasVegetable = true;
			planting.hasSeed = true;
		else
			badPlant(water, waterMax, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow == prop.mature) then -- mature
		if(water >= 0 and waterMax >= 0 and diseaseLvl >= 0) then
			if cheat then
				planting.nextGrowing = calcNextGrowing(nextGrowing, 1);
			else
				planting.nextGrowing = calcNextGrowing(nextGrowing, prop.timeToGrow + water + waterMax + diseaseLvl);
			end
		else
			badPlant(water, waterMax, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif (nbOfGrow > 0) then -- young
		if water >= 0 and waterMax >= 0 and diseaseLvl >= 0 then
			if cheat then
				planting = growNext(planting, farming_vegetableconf.getObjectName(planting), nextGrowing, 1);
			else
				planting = growNext(planting, farming_vegetableconf.getObjectName(planting), nextGrowing, prop.timeToGrow + water + waterMax + diseaseLvl);
			end

			planting.waterNeeded = prop.waterLvl;
			if prop.waterLvlMax then
			    planting.waterNeededMax = prop.waterLvlMax;
			end
		else
			badPlant(water, waterMax, diseaseLvl, planting, nextGrowing, updateNbOfGrow);
		end
	elseif nbOfGrow == 0 then -- young
		if cheat then
			planting = growNext(planting, farming_vegetableconf.getObjectName(planting), nextGrowing, 1);
		else
			planting = growNext(planting, farming_vegetableconf.getObjectName(planting), nextGrowing, prop.timeToGrow + water + waterMax + diseaseLvl);
		end

        planting.waterNeeded = prop.waterNeeded
    end
    if planting:isAlive() then
        if (prop.harvestLevel and nbOfGrow >= prop.harvestLevel)
         or (not prop.harvestLevel and nbOfGrow >= prop.harvestLeve) then
            planting:setObjectName(name)
            planting.hasVegetable = true;
         end
    end
	return planting;
end

-- if we doesn't take well care of our plant
-- if the plant is not well watered or have a little disease, the growing is reported (50 hours)
-- if disease is too much (> 60) then the plant die
-- if water or waterMax == -2 (too much or too less watered), the growing is reported to 100 hours and lose a bunch of health
function badPlant(water, waterMax, diseaseLvl, plant, nextGrowing, updateNbOfGrow)
	if not waterMax then
		waterMax = 1;
	end
	-- if we're here, it's because we didn't take well care of our plant, so we notice it, we'll have less xp from this plant
	if water <= -1 or waterMax <= -1 then
		plant.badCare = true;
    end

    if diseaseLvl == -2 then -- our plant is dead if disease > 60
        plant:killThis();
        return;
    end

    if updateNbOfGrow then
        plant.nbOfGrow = plant.nbOfGrow -1;
    end

	if water == -1 or waterMax == -1 or diseaseLvl == -1 then-- we report our growing
		plant.nextGrowing = calcNextGrowing(nextGrowing, 30);
        return;
    end

    plant.nextGrowing = calcNextGrowing(nextGrowing, 50);

    local badMultiplier = 1
    -- if a plant is "cursed" ( 50% is planted in a risky month) then the odds are stacked against it
    if plant.cursed then badMultiplier = badMultiplier * 2 end
    if plant.hasWeeds then badMultiplier = badMultiplier * 2 end
    -- plants with insufficient natural light will have the badMultiplier increased
    if plant.naturalLight then badMultiplier = badMultiplier / plant.naturalLight end

    plant.health = plant.health - (4 * badMultiplier);
end

-- spurcival - helper function used by VerifyAllCraftRecipesAreLearnable
function doesSeasonRecipeExist(recipeName)
	for typeOfSeed,props in pairs(farming_vegetableconf.props) do
		if props.seasonRecipe == recipeName then
			return true;
		end
	end
	
	return false;
end

farming_vegetableconf.props = {};

farming_vegetableconf.sprite = {}
farming_vegetableconf.unhealthySprite = {}
farming_vegetableconf.dyingSprite = {}
farming_vegetableconf.deadSprite = {}
farming_vegetableconf.trampledSprite = {}

-- function ISGameLoadingUI.OnMovingObjectCrop(object)
--     print("2 - Zombie destroy crop " .. tostring(object))
--     local square = object:getSquare()
--     print("square " .. tostring(square))
--     if not square then return end
--     local plant = CFarmingSystem.instance:getLuaObjectOnSquare(square)
--     print("plant " .. tostring(plant))
--     if not plant then return end
-- 	if plant.state == "plow" or plant.state == "destroyed" or plant.state == "harvested" then return end
--     print("3 - Zombie destroy crop")
--
--     if (instanceof(object, "IsoZombie") and ZombRand(10) == 0) or (instanceof(object, "BaseVehicle") and not object:notKillCrops()) then
--
--     print("4 - Zombie destroy crop")
--         -- too bad ! :)
--         square:playSound("RemovePlant")
--         plant:destroyThis()
--         return
--     end
-- end
-- Events.OnMovingObjectCrop.Add(ISGameLoadingUI.OnMovingObjectCrop)