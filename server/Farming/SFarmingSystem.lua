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

require "Map/SGlobalObjectSystem"

SFarmingSystem = SGlobalObjectSystem:derive("SFarmingSystem")

function SFarmingSystem:new()
	local o = SGlobalObjectSystem.new(self, "farming")

	 -- The value of this may have been read from gos_farming.bin already.
	o.hoursElapsed = o.hoursElapsed or 0

	o.hourElapsedForWater = 0
	o.previousHourHealth = 0

	local gameTime = GameTime.getInstance()
	local sec = math.floor(gameTime:getTimeOfDay() * 3600)
	o.previousHour = math.floor(sec / 3600)

	return o
end

function SFarmingSystem:initSystem()
	SGlobalObjectSystem.initSystem(self)

	-- Specify GlobalObjectSystem fields that should be saved.
	self.system:setModDataKeys({'hoursElapsed'})
	
	-- Specify GlobalObject fields that should be saved.
	self.system:setObjectModDataKeys({
		'state', 'nbOfGrow', 'typeOfSeed', 'fertilizer', 'mildewLvl',
		'aphidLvl', 'fliesLvl', 'slugsLvl', 'hasWeeds',  'waterLvl', 'waterNeeded', 'waterNeededMax',
		'lastWaterHour', 'nextGrowing', 'hasSeed', 'hasVegetable',
		'health', 'badCare', 'exterior', 'spriteName', 'objectName', 'cursed', 'compost', 'bonusYield', 'naturalLight'})

	self:convertOldModData()
end

function SFarmingSystem:getInitialStateForClient()
	return { hoursElapsed = self.hoursElapsed }
end

function SFarmingSystem:newLuaObject(globalObject)
	return SPlantGlobalObject:new(self, globalObject)
end

function SFarmingSystem:isValidModData(modData)
	return modData and modData.state and modData.nbOfGrow and modData.health
end

function SFarmingSystem:isValidIsoObject(isoObject)
	return isoObject:hasModData() and self:isValidModData(isoObject:getModData())
end

-- Take plant data previously stored in GameTime.getModData() and put it into
-- the new GlobalObjectSystem.
function SFarmingSystem:convertOldModData()
	-- If the gos_xxx.bin file existed, don't touch GameTime modData in case mods are using it.
	if self.system:loadedWorldVersion() ~= -1 then return end
	
	local modData = GameTime.getInstance():getModData()
	if modData.farming and modData.farming.plants then
		self:noise('converting old-style GameTime modData')
		for _,plant in pairs(modData.farming.plants) do
			if not self.system:getObjectAt(plant.x, plant.y, plant.z) then
				local globalObject = self.system:newObject(plant.x, plant.y, plant.z)
				for k,v in pairs(plant) do
					globalObject:getModData()[k] = v
				end
			end
		end
		modData.farming.plants = nil
		for k,v in pairs(modData.farming) do
			noise("copied "..tostring(k).."="..tostring(v))
			self[k] = v
		end
		modData.farming = nil
		self:noise('converted '..self.system:getObjectCount()..' plants')
	end
end

function SFarmingSystem:OnClientCommand(command, playerObj, args)
	SFarmingSystemCommands[command](playerObj, args)
end

function SFarmingSystem:EveryTenMinutes()
	local sec = math.floor(getGameTime():getTimeOfDay() * 3600)
	local currentHour = math.floor(sec / 3600)
	local day = getGameTime():getDay()
	-- an hour has passed
	if currentHour ~= self.previousHour then
		self.hoursElapsed = self.hoursElapsed + 1
		self.previousHour = currentHour
		self.hourElapsedForWater = self.hourElapsedForWater + 1
		-- every 2 hours, we lover the water lvl of all plant by 1
		-- we also gonna up our disease lvl
		local hourForWater = 5;
		if SandboxVars.PlantResilience == 1 then -- very high
			hourForWater = 12;
		elseif SandboxVars.PlantResilience == 2 then -- high
			hourForWater = 8;
		elseif SandboxVars.PlantResilience == 4 then -- low
			hourForWater = 3;
		elseif SandboxVars.PlantResilience == 5 then -- very low
			hourForWater = 2;
		end
		if self.hourElapsedForWater >= hourForWater then
			self:lowerWaterLvlAndUpDisease()
			self.hourElapsedForWater = 0
		end
		-- change health of the plant every 3 hours
		self.previousHourHealth = self.previousHourHealth + 1
		if self.previousHourHealth == 2 then
			self:changeHealth()
			self.previousHourHealth = 0
		end
		self:sendCommand('hoursElapsed', { hoursElapsed = self.hoursElapsed })
	end
--[[
	-- a day as passed, maybe npc will water the plant for us
	if self.currentDay ~= day then
		self.currentDay = day
--		self:automateNpc()
	end
--]]
	self:checkPlant()
end

function SFarmingSystem:lowerWaterLvlAndUpDisease()
	for i=1,self:getLuaObjectCount() do
		local luaObject = self:getLuaObjectByIndex(i)
		if luaObject:isAlive() then
            luaObject:lowerWaterLvl()
            luaObject:upDisease()
        end
	end
end

-- up or low the health of our plant, depending on weather, if they are well watered, etc.
function SFarmingSystem:changeHealth()
--     print("Change Health")
    local seasons = getSandboxOptions():getOptionByName("PlantGrowingSeasons"):getValue() == true
    local noInside = getSandboxOptions():getOptionByName("KillInsideCrops"):getValue() == true


    for i=1,self:getLuaObjectCount() do
        local luaObject = self:getLuaObjectByIndex(i)
        if luaObject:isAlive() and luaObject.state ~= "plow" then
--             print("Plant " .. tostring(i))
            -- if the square is available we check the inside/outside status
            local greenhouse = false
            local luaObjectSquare = luaObject:getSquare()
            if luaObjectSquare then
--                 print("Plant Square" .. tostring(i))
                luaObject.exterior = luaObjectSquare:isOutside()
                -- and we will also calculate the weed level
                -- look for grass, bushes, plants, etc. that aren't the plant itself
                luaObject.hasWeeds = SFarmingSystem:hasWeeds(luaObjectSquare)
                -- if the plant has enough of a pest flies infestation we apply flies to the square
                if luaObject:hasVisibleFlies() then luaObjectSquare:setHasFlies(true) end
                local room = luaObjectSquare:getRoom()
                if not luaObject.exterior and room and room:getRoomDef() then
                    local roomDef = string.lower(room:getRoomDef():getName())
                    if string.contains(roomDef, "greenhouse") then
                        greenhouse = true
                    end
                end
            end

            local badMultiplier = 1
            -- bad seasons kill crops
            if seasons and luaObject.exterior and  luaObject:isBadMonth() and not luaObject:isBadMonthHardy() then
                luaObject.cursed = true
            end
            if seasons and luaObject.exterior and getClimateManager():getSeasonName() == "Winter" and not luaObject:isColdHardy() then
                luaObject.cursed = true
            end
            -- if a plant is "cursed" ( 50% is planted in a risky month) then the odds are stacked against it
            if luaObject.cursed then badMultiplier = badMultiplier * 2 end
            if luaObject.hasWeeds then badMultiplier = badMultiplier * 2 end
            -- plants with insufficient natural light will have the badMultiplier increased
            if luaObject.naturalLight then badMultiplier = badMultiplier / luaObject.naturalLight end

	        local prop
	        if luaObject.typeOfSeed then prop = farming_vegetableconf.props[luaObject.typeOfSeed] end
	        local houseplant = prop and prop.isHouseplant

            -- change with weather
            local weather = getWorld():getWeather()
            if "sunny" == weather then -- if it's sunny
                if luaObject.exterior then
                    if not luaObject:isBadMonth() then
                        luaObject.health = luaObject.health + (1 /badMultiplier)
                    end
                else
                    if houseplant or greenhouse or not noInside then
                        luaObject.health = luaObject.health + (0.25 /badMultiplier)
                    end
                end
            end
            -- lower health if temperature is not high
            if season.currentTemp <= 10 and not luaObject:isColdHardy() then
                luaObject.health = luaObject.health - 0.5 * badMultiplier;
            end
            -- change with water
            local water = farming_vegetableconf.calcWater(luaObject.waterNeeded, luaObject.waterLvl)
            local waterMax = farming_vegetableconf.calcWater(luaObject.waterLvl, luaObject.waterNeededMax)
            if water >= 0 and waterMax >= 0 then
                luaObject.health = luaObject.health + 0.4 / badMultiplier
            elseif water == -1 then -- we low health by 0.2
                luaObject.health = luaObject.health - 0.2 * badMultiplier
            elseif water == -2 then -- low health by 0.5
                luaObject.health = luaObject.health - 0.5 * badMultiplier
            elseif waterMax == -1 and luaObject.health > 20  then
                luaObject.health = luaObject.health - 0.2 * badMultiplier
            elseif waterMax == -2 and luaObject.health > 20  then
                luaObject.health = luaObject.health - 0.5 * badMultiplier
            end
            -- if the plant is inside then it's slowly being killed if it's not a houseplant or in a greenhouse
            if noInside and (not luaObject.exterior) and (not houseplant) and (not greenhouse) then
                luaObject.health = luaObject.health - ( 1 * badMultiplier )
            end
            -- if it's winter bad news for houseplants that are outside
            if seasons and luaObject.exterior and getClimateManager():getSeasonName() == "Winter" and houseplant then
                luaObject.health = luaObject.health - (  1.5  * badMultiplier )
            end
            -- bad seasons kill crops
            if seasons and luaObject.exterior and  luaObject:isBadMonth() and not luaObject:isBadMonthHardy() then
                luaObject.health = luaObject.health - (  3  * badMultiplier )
            end
        end
	end
end

function SFarmingSystem:checkPlant()
--     local i = self:getLuaObjectCount()
--     while i > 0 do
	for i=1,self:getLuaObjectCount() do
	    if not self:getLuaObjectByIndex(i) then break end
		local luaObject = self:getLuaObjectByIndex(i)
	    if luaObject then self:checkPlant2(luaObject) end
	end
	local i = self:getLuaObjectCount()
	while i > 0 do
	    if not self:getLuaObjectByIndex(i) then break end
		local luaObject = self:getLuaObjectByIndex(i)
	    if luaObject then self:plowFadeCheck(luaObject) end
        i = i - 1
	end
end

function SFarmingSystem:plowFadeCheck(luaObject)
    if luaObject.state ~= "plow" and luaObject.state ~= "destroyed" and luaObject.state ~= "harvested" then return end
    local square = luaObject:getSquare()
    if not square then return end
    local mData = square:getModData()
    local day = getGameTime():getWorldAgeHours() / 24
    if not mData.plowDay then mData.plowDay = day end
    if (day - 30) <= mData.plowDay then return end
    if ZombRand(20000) == 0 then luaObject:removeObject() end
end

function SFarmingSystem:checkPlant2(luaObject)
    if (not luaObject) or (luaObject.state == "destroyed") or (luaObject.state == "harvested") then return end
    -- dead plants should gradually become destroyed over time, and unplanted furrows at a slower rate
    if (not  luaObject:isAlive()) and ZombRand(5000) == 0 then
        luaObject:destroyThis()
        return
    end
--     if luaObject.state == "plow" and ZombRand(20) == 0 then
--         luaObject:removeObject()
--         return
--     end
    self:checkPlantSquare(luaObject)
    -- if the plant still alive
    if luaObject.state ~= "plow" and luaObject:isAlive() then
        if luaObject.nextGrowing and self.hoursElapsed >= luaObject.nextGrowing then
            self:growPlant(luaObject, nil, true)
        end
        self:checkWater(luaObject)
        luaObject:checkStat()
    end
    -- add the icon if we have the required farming xp and if we're close enough of the plant
    luaObject:addIcon()
    -- update the plant sprite
    local sprite = farming_vegetableconf.getSpriteName(luaObject)
    if sprite then luaObject:setSpriteName(sprite) end
    luaObject:saveData()
end

function SFarmingSystem:checkPlantSquare(luaObject)
    local square = luaObject:getSquare()
    if not square then return end
    luaObject.exterior = square:isOutside()
    luaObject.hasWeeds = SFarmingSystem:hasWeeds(square)
    -- if the plant has enough of a pest flies infestation we apply flies to the square
    if luaObject:hasVisibleFlies() then square:setHasFlies(true) end
    -- we may destroy our plant if someone walk onto it, or if it's already dead
    self:destroyOnWalk(luaObject, square)
end

function SFarmingSystem:checkWater(luaObject)
    local waterFactor = 1
    if luaObject.hasWeeds then waterFactor = waterFactor * 2 end
    if RainManager.isRaining() and luaObject.exterior then
        luaObject.waterLvl = luaObject.waterLvl + (30 * getClimateManager():getPrecipitationIntensity() / waterFactor)
        luaObject.lastWaterHour = self.hoursElapsed
    -- if it's sunny, we lower a bit our water lvl
    elseif season.weather == "sunny" then
        luaObject.waterLvl = luaObject.waterLvl - 0.1 * waterFactor
    end
    if luaObject.waterLvl > 100 then
        luaObject.waterLvl = 100
    end
    if luaObject.waterLvl < 0 then
        luaObject.waterLvl = 0
    end
end
-- grow the plant
function SFarmingSystem:growPlant(luaObject, nextGrowing, updateNbOfGrow)
	if(luaObject.state == "seeded") then
		luaObject = farming_vegetableconf.grow(luaObject, nextGrowing, updateNbOfGrow)
		-- maybe this plant gonna be disease
		if luaObject.nbOfGrow > 0 then
			self:diseaseThis(luaObject)
		end
		luaObject.nbOfGrow = luaObject.nbOfGrow + 1
	end
end

function SFarmingSystem:harvest(luaObject, player)
    local skill = player:getPerkLevel(Perks.Farming)
	local props = farming_vegetableconf.props[luaObject.typeOfSeed]
	local numberOfVeg = getVegetablesNumber(props.minVeg, props.maxVeg, props.minVegAutorized, props.maxVegAutorized, luaObject, skill)

	if numberOfVeg > 0 and props.isFlower and player then
        player:getBodyDamage():setUnhappynessLevel(bodyDamage:getUnhappynessLevel() - numberOfVeg/2 )
        player:getBodyDamage():setBoredomLevel(player:getBodyDamage():getBoredomLevel() - numberOfVeg/2 )
        player:getStats():setStress(stats:getStress() - numberOfVeg/2 )
	end

	if props.vegetableName and player then
		local items = player:getInventory():AddItems(props.vegetableName, tonumber(numberOfVeg));
		sendAddItemsToContainer(player:getInventory(), items);
	end

    if props.produceExtra and player then
		local items = player:getInventory():AddItems(props.produceExtra, tonumber(numberOfVeg));
		sendAddItemsToContainer(player:getInventory(), items);
    end

	if luaObject.hasSeed and player then
	    local seedPerVeg = props.seedPerVeg or 0.5
	    local number = math.min(tonumber(math.floor(numberOfVeg * seedPerVeg)), 1)
		local items = player:getInventory():AddItems(props.seedName, number);
		sendAddItemsToContainer(player:getInventory(), items);
	end

	luaObject.hasVegetable = false
	luaObject.hasSeed = false

	-- the strawberrie don't disapear, it goes on phase 2 again
-- 	if luaObject.typeOfSeed == "Strawberryplant" then
	if props.growBack then
		luaObject.nbOfGrow = props.growBack
		luaObject.fertilizer = 0;
		self:growPlant(luaObject, nil, true)
--         self:setSpriteName(farming_vegetableconf.getSpriteName(luaObject))
--         luaObject:setSpriteName(farming_vegetableconf.getSpriteName(luaObject))
        local sprite = farming_vegetableconf.getSpriteName(luaObject)
        if sprite then luaObject:setSpriteName(sprite) end

		luaObject:saveData()
	else
	    -- change the plant to a harvested(destroyed) tile instead of removing it
-- 	    luaObject:destroyThis()
	    luaObject:harvestThis()
-- 		self:removePlant(luaObject)
	end
end

-- test if the plant gonna be disease
function SFarmingSystem:diseaseThis(luaObject)
    if luaObject.aphidLvl > 0 and luaObject.fliesLvl > 0 and luaObject.mildewLvl > 0 and luaObject.slugsLvl > 0 then
        return
    end

    local prop = farming_vegetableconf.props[luaObject.typeOfSeed]
    local aphidsBane =  prop.aphidsBane or prop.aphidsProof
    local fliesBane =  prop.fliesBane or prop.fliesProof
    local slugsBane =  prop.slugsBane or prop.slugsProof

	if (not aphidBane) or (not flyBane) or (not slugsBane) then
        local adjacent = self.system:getObjectsAdjacentTo(luaObject.x, luaObject.y, luaObject.z)
        for i=1,adjacent:size() do
            local luaObject2 = adjacent:get(i-1):getModData()
            -- companion plants have to grow somewhat before offering benefits
            if luaObject2.nbOfGrow >= 3 then
                local prop2 = farming_vegetableconf.props[luaObject2.typeOfSeed]
                if prop2.aphidsBane then aphidsBane = true end
                if prop2.fliesBane then fliesBane = true end
                if prop2.slugsBane then slugsBane = true end
            end
            if aphidsBane and fliesBane and slugsBane then break end
        end
    end
    if (luaObject.aphidLvl > 0 or aphidsBane) and (luaObject.fliesLvl > 0 or fliesBane) and luaObject.mildewLvl > 0 and (luaObject.slugsLvl > 0 or slugsBane) then
        return
    end
	-- if we don't already have mildew
	if(luaObject.mildewLvl == 0) then
		luaObject:mildew()
	end
	if(luaObject.aphidLvl == 0) and not aphidsBane then
		luaObject:aphid()
	end
	if(luaObject.fliesLvl == 0) and not fliesBane then
		luaObject:flies()
	end
	if(luaObject.slugsLvl == 0)  and not slugsBane then
		luaObject:slugs()
	end
    if (luaObject.aphidLvl > 0 or aphidsBane) and (luaObject.fliesLvl > 0 or fliesBane) and luaObject.mildewLvl > 0 and (luaObject.slugsLvl > 0 or slugsBane) then
        return
    end
    -- we gonna check all the plant near this one, if one is infected, maybe this one would be infected too !
    self:diseaseClosePlant(luaObject, aphidsBane, fliesBane, slugsBane)
end

-- fetch all the plant near our current disease plant, so maybe they gonna have a disease too
function SFarmingSystem:diseaseClosePlant(luaObject, aphidsBane, fliesBane, slugsBane)
	local adjacent = self.system:getObjectsAdjacentTo(luaObject.x, luaObject.y, luaObject.z)
	for i=1,adjacent:size() do
		local luaObject2 = adjacent:get(i-1):getModData()
		-- a close plant is infected
        -- we gonna re check if our plant can be infected
        local hasWeeds = luaObject2.hasWeeds
		if luaObject2.aphidLvl > 0 and luaObject.aphidLvl == 0 and not aphidsBane then
		    luaObject:aphid()
		    if hasWeeds then luaObject:aphid() end
		end
		if luaObject2.mildewLvl > 0 and luaObject.mildewLvl == 0 then
		    luaObject:mildew()
		    if hasWeeds then luaObject:mildew() end
		end
		if luaObject2.fliesLvl > 0 and luaObject.fliesLvl == 0 and not fliesBane then
		    luaObject:flies()
		    if hasWeeds then luaObject:flies() end
		end
		if luaObject2.slugsLvl > 0 and luaObject.slugsLvl == 0 and not slugsBane then
		    luaObject:slugs()
		    if hasWeeds then luaObject:slugs() end
		end
		if (luaObject2.aphidLvl > 0 or aphidsBane) and luaObject2.mildewLvl > 0 and (luaObject2.fliesLvl > 0 or fliesBane) and (luaObject2.slugsLvl > 0 or slugsBane) then break end
	end
	-- This returns the ArrayList to a pool for reuse.  There's no harm if
	-- you forget to call it.
	self.system:finishedWithList(adjacent)
end

-- if zombie or npc walk over your plant, you have 1 to 10 risk that your plant is destroyed
function SFarmingSystem:destroyOnWalk(luaObject, square)
-- 	local square = luaObject:getSquare()
-- 	if not square then return end
-- 	if luaObject.state == "plow" or luaObject.state == "destroyed" or luaObject.state == "harvested" then return end
	if square:isVehicleIntersectingCrops() then
        luaObject:destroyThis()
        return
	end
	-- the other stuff is handled java-side now

	-- if zombie walk on our plant !
-- 	for i=1,square:getMovingObjects():size() do
-- 		local movingObject = square:getMovingObjects():get(i-1)
-- 		if (instanceof(movingObject, "IsoZombie") and ZombRand(2) == 0) or (instanceof(movingObject, "BaseVehicle") and not movingObject:notKillCrops()) then
-- 			-- too bad ! :)
-- 			square:playSound("RemovePlant")
--             luaObject:destroyThis()
--             return
-- 		end
-- 	end
end

-- get the health of the new plant depending on the moon
function SFarmingSystem:getHealth()
    -- it's better to plant seed during ascending phase of the moon
    if season.moonCycle >= 4 and season.moonCycle < 18 then -- ascending moon health between 47 and 53
        return ZombRand(47, 54)
    elseif season.moonCycle >= 18 and season.moonCycle <= 21 then -- full moon, the best ! health between 57 and 64
        return ZombRand(57, 64)
    else -- descending moon, the worst, health between 37 and 44
        return ZombRand(37, 44)
    end
end

-- make the player more tired etc. when plowing land
function SFarmingSystem:changePlayer(player)
	-- 	player:getStats():setFatigue(player:getStats():getFatigue() + 0.006)
	player:getStats():setEndurance(player:getStats():getEndurance() - 0.0013)

	--Stat_Endurance
	syncPlayerStats(player, 0x00000002);
end


-- plow the land
function SFarmingSystem:plow(square)
    -- we remove grass and vegetation from the square
	self:removeTallGrass(square)
    local floor = square:getFloor();
    if (floor and floor:getSprite():getProperties():Val("grassFloor")) and square:checkHaveGrass() == true then
	    square:removeGrass()
	end
	-- we set the square to be shovelled to eliminate dirt exploits
--     local type,o = ISShovelGroundCursor.GetDirtGravelSand(sq)
--     if instanceof(o, 'IsoObject') then
--         local shovelledSprites = o:hasModData() and o:getModData().shovelledSprites
--         if not shovelledSprites then
--             o:getModData().shovelled = true
--         end
--     end

	local luaObject = self:newLuaObjectOnSquare(square)
	luaObject:initNew()
	luaObject.exterior = square:isOutside()
	luaObject:addObject()
	self:noise('plowed '..luaObject.x..','..luaObject.y)
	self:noise("#plants="..self:getLuaObjectCount())

	-- we apply mod data for furrow fade
	local mData = square:getModData()
    local plowDay = getGameTime():getWorldAgeHours() / 24
    mData.plowDay = plowDay
end

-- add xp, depending on the health of the plant
function SFarmingSystem:gainXp(player, luaObject)
	local xp = luaObject.health / 2
	if luaObject.badCare == true then
		xp = xp - 15
	else
		xp = xp + 25
	end
	if xp > 100 then
		xp = 100
	elseif xp < 0 then
		xp = 0
	end

	addXp(player, Perks.Farming, xp);
end

function SFarmingSystem:removePlant(luaObject)
	if not luaObject or luaObject.luaSystem ~= self then return end
    if luaObject:getSquare() and luaObject:hasVisibleFlies() then luaObject:getSquare():setHasFlies(false) end
	-- This calls removeLuaObject(luaObject) as a side effect of the OnObjectAboutToBeRemoved event
	luaObject:removeObject()
--	FarmingSystem.instance:removeLuaObject(plant)
end

function SFarmingSystem:removeTallGrass(sq)
	-- remove vegetation
	for i=sq:getObjects():size(),1,-1 do
		o = sq:getObjects():get(i-1)
		-- FIXME: blends_grassoverlays tiles should have 'vegitation' flag
		if o:getSprite() and (
				o:getSprite():getProperties():Is(IsoFlagType.canBeRemoved) or
				(o:getSprite():getProperties():Is(IsoFlagType.vegitation) and o:getType() ~= IsoObjectType.tree) or
				(o:getSprite():getName() and luautils.stringStarts(o:getSprite():getName(), "blends_grassoverlays"))) then
			sq:transmitRemoveItemFromSquare(o)
		end
	end
end

function SFarmingSystem:receiveCommand(playerObj, command, args)
	SFarmingSystemCommands[command](playerObj, args)
end

SGlobalObjectSystem.RegisterSystemClass(SFarmingSystem)

local function EveryTenMinutes()
	SFarmingSystem.instance:EveryTenMinutes()
end

Events.EveryTenMinutes.Add(EveryTenMinutes)

function SFarmingSystem:hasWeeds(square)
    if square:HasTree() then
        return true
    end
    if ISRemovePlantCursor:getRemovableObject(square) then
        return true
    end
    local objects = square:getObjects()
    if objects and objects:size() > 0 then
	for i=square:getObjects():size(),1,-1 do
		    v = square:getObjects():get(i-1)
            if v and self:hasWeeds2(v) then return true end
        end
    end
    return false
end

function SFarmingSystem:hasWeeds2(v)
    local spriteName
    if instanceof(v, "IsoObject") and v:getSprite()  then
        spriteName = v:getSprite():getName() or v:getSpriteName()
    end
    if v:getSprite() and (
            v:getSprite():getProperties():Is(IsoFlagType.canBeRemoved) or
            (v:getSprite():getProperties():Is(IsoFlagType.vegitation) and v:getType() ~= IsoObjectType.tree) or
            (v:getSprite():getName() and luautils.stringStarts(v:getSprite():getName(), "blends_grassoverlays"))) then
       return true
    end
    if v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.canBeCut) then
        return true
    end
    if v:getSprite() and v:getSprite():getProperties() and v:getSprite():getProperties():Is(IsoFlagType.canBeRemoved) then
        return true
    end
    local attached = v:getAttachedAnimSprite()
    if attached then
        for n=1,attached:size() do
            local sprite = attached:get(n-1)
            -- if sprite and sprite:getParentSprite() and sprite:getParentSprite():getProperties():Is(IsoFlagType.canBeCut) then
            if sprite and sprite:getParentSprite() and sprite:getParentSprite():getName() and luautils.stringStarts(sprite:getParentSprite():getName(), "f_wallvines_") then
                return true
            end
        end
    end
end

SFarmingSystem.destroyPlant = function(square)
    if not square then return end
    args = {}
    args.x = square:getX()
    args.y = square:getY()
    args.z = square:getZ()
	SFarmingSystemCommands.destroy(nil, args)
end
