if isClient() then return end

require "Farming/SFarmingSystem"
require "Farming/farming_vegetableconf"

local function noise(message) SFarmingSystem.instance:noise(message) end
local PRIORITY = 5
local cropSpriteMap = {}

local function randomSeedType()
	local seedTypes = {}
	-- for seedType,itemSprite in pairs(farming_vegetableconf.icons) do
	for seedType,itemSprite in pairs(farming_vegetableconf.props) do
		if seedType ~= "Tomato" then
			table.insert(seedTypes, seedType)
		end
	end
	return seedTypes[ZombRand(#seedTypes)+1]
end

local function removeExistingLuaObject(square)
	local luaObject = SFarmingSystem.instance:getLuaObjectOnSquare(square)
	if luaObject then
-- 		noise('removing luaObject at same location as newly-loaded isoObject')
		SFarmingSystem.instance:removeLuaObject(luaObject)
	end
end

local function NewPlow(isoObject)
	local square = isoObject:getSquare()
	removeExistingLuaObject(square)
	SPlantGlobalObject.initModData(isoObject:getModData())
	isoObject:getModData().exterior = square:isOutside()
	isoObject:setName(getText("Farming_Plowed_Land"))
end

local function NewDestroyed(isoObject)
	local square = isoObject:getSquare()
	removeExistingLuaObject(square)
	local modData = isoObject:getModData()
	SPlantGlobalObject.initModData(modData)
	modData.spriteName = isoObject:getSprite():getName()
	modData.state = "destroy"
	modData.exterior = square:isOutside()
	local typeOfSeed = nil
	if isoObject:getSprite():getName() == "vegetation_farming_01_14" then
		typeOfSeed = "Tomato"
	else
		-- We don't know what type of plant this was, pick a random one.
		typeOfSeed = randomSeedType()
	end
	isoObject:setName(getText("Farming_Destroyed") .. " " .. getText("Farming_" .. typeOfSeed))
	-- deadPlant()
	modData.nextGrowing = 0
	modData.waterLvl = 0
	modData.nbOfGrow = 0
	modData.mildewLvl = 0
	modData.aphidLvl = 0
	modData.fliesLvl = 0
	modData.slugsLvl = 0
	modData.weedsLvl = 0
	modData.health = 0
end

function NewPlant(isoObject)
	local square = isoObject:getSquare()
	removeExistingLuaObject(square)

	local spriteName = isoObject:getSprite():getName()
	local typeOfSeed = cropSpriteMap[spriteName].typeOfSeed

	local luaObject = SFarmingSystem.instance:newLuaObjectOnSquare(square)
	luaObject:initNew()
	luaObject.exterior = square:isOutside()
	isoObject:setSpecialTooltip(true)

	luaObject:seed(typeOfSeed)
	luaObject.waterLvl = ZombRand(luaObject.waterNeeded, luaObject.waterNeededMax or 100)
	luaObject.health = ZombRand(cropSpriteMap[spriteName].minHealth, cropSpriteMap[spriteName].maxHealth)

	local nbOfGrow = cropSpriteMap[spriteName].nbOfGrow

	for i=1,nbOfGrow-1 do
		SFarmingSystem.instance:growPlant(luaObject, nil, true)
		luaObject.waterLvl = ZombRand(luaObject.waterNeeded, luaObject.waterNeededMax or 100)
	end

	isoObject:setName(luaObject.objectName)
	isoObject:setSprite(luaObject.spriteName)
    if farming_vegetableconf.props[typeOfSeed].isHouseplant then
	   isoObject:getSprite():getProperties():set("IsMoveAble", "true")
	end
	luaObject:toModData(isoObject:getModData())
	luaObject:setSpriteName(farming_vegetableconf.getSpriteName(luaObject))
	noise('created farming/houseplant luaObject from pre-existing isoObject '..luaObject.x..','..luaObject.y)
end

-- MapObjects.OnNewWithSprite("vegetation_farming_01_1", NewPlow, PRIORITY)
MapObjects.OnNewWithSprite("vegetation_farming_01_13", NewDestroyed, PRIORITY)
MapObjects.OnNewWithSprite("vegetation_farming_01_14", NewDestroyed, PRIORITY)

local function LoadPlow(isoObject)
	if not SFarmingSystem.instance:isValidIsoObject(isoObject) then
		noise("couldn't find valid modData for existing isoObject; recreating it")
		NewPlow(isoObject)
	end
	SFarmingSystem.instance:loadIsoObject(isoObject)
end

local function LoadDestroyed(isoObject)
	if not SFarmingSystem.instance:isValidIsoObject(isoObject) then
		noise("couldn't find valid modData for existing isoObject; recreating it")
		NewDestroyed(isoObject)
	end
	SFarmingSystem.instance:loadIsoObject(isoObject)
end

local function LoadPlant(isoObject)
	if not SFarmingSystem.instance:isValidIsoObject(isoObject) then
		noise("couldn't find valid modData for existing isoObject; recreating it")
		NewPlant(isoObject)
	end
	SFarmingSystem.instance:loadIsoObject(isoObject)
end

MapObjects.OnLoadWithSprite("vegetation_farming_01_13", LoadDestroyed, PRIORITY)
MapObjects.OnLoadWithSprite("vegetation_farming_01_14", LoadDestroyed, PRIORITY)

for typeOfSeed,props in pairs(farming_vegetableconf.props) do
    MapObjects.OnNewWithSprite(farming_vegetableconf.sprite[typeOfSeed], NewPlant, PRIORITY)
    MapObjects.OnNewWithSprite(farming_vegetableconf.unhealthySprite[typeOfSeed], NewPlant, PRIORITY)
    MapObjects.OnNewWithSprite(farming_vegetableconf.dyingSprite[typeOfSeed], NewPlant, PRIORITY)
    MapObjects.OnNewWithSprite(farming_vegetableconf.deadSprite[typeOfSeed], NewPlant, PRIORITY)
    MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite[typeOfSeed], LoadPlant, PRIORITY)
    MapObjects.OnLoadWithSprite(farming_vegetableconf.unhealthySprite[typeOfSeed], LoadPlant, PRIORITY)
    MapObjects.OnLoadWithSprite(farming_vegetableconf.dyingSprite[typeOfSeed], LoadPlant, PRIORITY)
    MapObjects.OnLoadWithSprite(farming_vegetableconf.deadSprite[typeOfSeed], LoadPlant, PRIORITY)

	for i=1,#farming_vegetableconf.sprite[typeOfSeed] do
		cropSpriteMap[farming_vegetableconf.sprite[typeOfSeed][i]] = {
            typeOfSeed = typeOfSeed,
            minHealth= 50,
            maxHealth = 100,
            nbOfGrow = i,
        }
	end

	for i=1,#farming_vegetableconf.unhealthySprite[typeOfSeed] do
		cropSpriteMap[farming_vegetableconf.unhealthySprite[typeOfSeed][i]] = {
            typeOfSeed = typeOfSeed,
            minHealth= 25,
            maxHealth = 49,
            nbOfGrow = i,
        }
	end

	for i=1,#farming_vegetableconf.dyingSprite[typeOfSeed] do
		cropSpriteMap[farming_vegetableconf.dyingSprite[typeOfSeed][i]] = {
            typeOfSeed = typeOfSeed,
            minHealth= 1,
            maxHealth = 24,
            nbOfGrow = i,
        }
	end

	for i=1,#farming_vegetableconf.deadSprite[typeOfSeed] do
		cropSpriteMap[farming_vegetableconf.deadSprite[typeOfSeed][i]] = {
            typeOfSeed = typeOfSeed,
            minHealth= 0,
            maxHealth = 0,
            nbOfGrow = i,
        }
	end
end
