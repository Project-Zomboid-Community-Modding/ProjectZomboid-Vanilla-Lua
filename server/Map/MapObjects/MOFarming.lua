--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

require "Farming/SFarmingSystem"
require "Farming/farming_vegetableconf"

local function noise(message) SFarmingSystem.instance:noise(message) end

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

--local function NewPlant(isoObject, typeOfSeed)
function NewPlant(isoObject, typeOfSeed)
 --print("SEEED" .. tostring(typeOfSeed))
	local square = isoObject:getSquare()
    --if not farming_vegetableconf.props[typeOfSeed].isHouseplant then
	    removeExistingLuaObject(square)
	--end

	local spriteName = isoObject:getSprite():getName()
	local luaObject = SFarmingSystem.instance:newLuaObjectOnSquare(square)
	luaObject:initNew()
	luaObject.exterior = square:isOutside()
	isoObject:setSpecialTooltip(true)

	luaObject:seed(typeOfSeed)
	luaObject.waterLvl = ZombRand(luaObject.waterNeeded, luaObject.waterNeededMax or 100)

	-- plow: nbOfGrow == -1
	-- seed: nbOfGrow == 0 -> 1
	-- rotten: nbOfGrow == 1

	local sprites = farming_vegetableconf.sprite[farming_vegetableconf.props[typeOfSeed].sprite] or farming_vegetableconf.sprite[typeOfSeed]
	local nbOfGrow = 1
	for i=1,#sprites do
		if sprites[i] == spriteName then
			break
		end
		nbOfGrow = nbOfGrow + 1
	end

	for i=1,nbOfGrow-1 do
		SFarmingSystem.instance:growPlant(luaObject, nil, true)
		luaObject.waterLvl = ZombRand(luaObject.waterNeeded, luaObject.waterNeededMax or 100)
	end

	isoObject:setName(luaObject.objectName)
	isoObject:setSprite(luaObject.spriteName)
    if farming_vegetableconf.props[typeOfSeed].isHouseplant then
        --getPlayer():Say("Houseplant")
	   isoObject:getSprite():getProperties():Set("IsMoveAble", "true")
	   --isoObject:getSprite():getProperties():Set("TileBlockStyle", nil)
	   --isoObject:getSprite():getProperties():Set("Movement", "HedgeLow")
	end
	luaObject:toModData(isoObject:getModData())
	luaObject:setSpriteName(farming_vegetableconf.getSpriteName(luaObject))
	noise('created farming/houseplant luaObject from pre-existing isoObject '..luaObject.x..','..luaObject.y)
end

local function NewBroccoli(isoObject)
	NewPlant(isoObject, "Broccoli")
end
local function NewCarrots(isoObject)
	NewPlant(isoObject, "Carrots")
end
local function NewCabbages(isoObject)
	NewPlant(isoObject, "Cabbages")
end
local function NewCorn(isoObject)
	NewPlant(isoObject, "Corn")
end
local function NewGarlic(isoObject)
	NewPlant(isoObject, "Garlic")
end
local function NewGreenpeas(isoObject)
	NewPlant(isoObject, "Greenpeas")
end
local function NewKale(isoObject)
	NewPlant(isoObject, "Kale")
end
local function NewOnion(isoObject)
	NewPlant(isoObject, "Onion")
end
local function NewPotatoes(isoObject)
	NewPlant(isoObject, "Potatoes")
end
local function NewRadishes(isoObject)
	NewPlant(isoObject, "Radishes")
end
local function NewSoybeans(isoObject)
	NewPlant(isoObject, "Soybeans")
end
local function NewSweetPotato(isoObject)
	NewPlant(isoObject, "SweetPotato")
end
local function NewStrawberry(isoObject)
	NewPlant(isoObject, "Strawberryplant")
end
local function NewTomato(isoObject)
	NewPlant(isoObject, "Tomato")
end
local function NewWheat(isoObject)
	NewPlant(isoObject, "Wheat")
end

local function NewBarley(isoObject)
	NewPlant(isoObject, "Barley")
end
local function NewBellPepper(isoObject)
	NewPlant(isoObject, "BellPepper")
end
local function NewCucumber(isoObject)
	NewPlant(isoObject, "Cucumber")
end
local function NewCauliflower(isoObject)
	NewPlant(isoObject, "Cauliflower")
end
local function NewLettuce(isoObject)
	NewPlant(isoObject, "Lettuce")
end
local function NewPumpkin(isoObject)
	NewPlant(isoObject, "Pumpkin")
end
local function NewRye(isoObject)
	NewPlant(isoObject, "Rye")
end
local function NewSpinach(isoObject)
	NewPlant(isoObject, "Spinach")
end
local function NewSugarBeets(isoObject)
	NewPlant(isoObject, "SugarBeets")
end
local function NewTobacco(isoObject)
	NewPlant(isoObject, "Tobacco")
end
local function NewTurnip(isoObject)
	NewPlant(isoObject, "Turnip")
end
local function NewWatermelon(isoObject)
	NewPlant(isoObject, "Watermelon")
end
local function NewZucchini(isoObject)
	NewPlant(isoObject, "Zucchini")
end


local function NewFlax(isoObject)
	NewPlant(isoObject, "Flax")
end
local function NewHemp(isoObject)
	NewPlant(isoObject, "Hemp")
end
local function NewHops(isoObject)
	NewPlant(isoObject, "Hops")
end
local function NewSunflower(isoObject)
	NewPlant(isoObject, "Sunflower")
end

local function NewBasil(isoObject)
	NewPlant(isoObject, "Basil")
end
local function NewBlackSage(isoObject)
	NewPlant(isoObject, "BlackSage")
end
local function NewBroadleafPlantain(isoObject)
	NewPlant(isoObject, "BroadleafPlantain")
end
local function NewChamomile(isoObject)
	NewPlant(isoObject, "Chamomile")
end
local function NewChives(isoObject)
	NewPlant(isoObject, "Chives")
end
local function NewCilantro(isoObject)
	NewPlant(isoObject, "Cilantro")
end
local function NewComfrey(isoObject)
	NewPlant(isoObject, "Comfrey")
end
local function NewCommonMallow(isoObject)
	NewPlant(isoObject, "CommonMallow")
end
local function NewCilantro(isoObject)
	NewPlant(isoObject, "Cilantro")
end
local function NewHabanero(isoObject)
	NewPlant(isoObject, "Habanero")
end
local function NewJalapeno(isoObject)
	NewPlant(isoObject, "Jalapeno")
end
local function NewLavender(isoObject)
	NewPlant(isoObject, "Lavender")
end
local function NewLeek(isoObject)
	NewPlant(isoObject, "Leek")
end
local function NewLemonGrass(isoObject)
	NewPlant(isoObject, "LemonGrass")
end
local function NewMarigold(isoObject)
	NewPlant(isoObject, "Marigold")
end
local function NewMint(isoObject)
	NewPlant(isoObject, "Mint")
end
local function NewOregano(isoObject)
	NewPlant(isoObject, "Oregano")
end
local function NewParsley(isoObject)
	NewPlant(isoObject, "Parsley")
end
local function NewPoppies(isoObject)
	NewPlant(isoObject, "Poppies")
end
local function NewRoses(isoObject)
	NewPlant(isoObject, "Roses")
end
local function NewRosemary(isoObject)
	NewPlant(isoObject, "Rosemary")
end
local function NewSage(isoObject)
	NewPlant(isoObject, "Sage")
end
local function NewThyme(isoObject)
	NewPlant(isoObject, "Thyme")
end
local function NewWildGarlic(isoObject)
	NewPlant(isoObject, "WildGarlic")
end

local PRIORITY = 5

MapObjects.OnNewWithSprite("vegetation_farming_01_1", NewPlow, PRIORITY)
MapObjects.OnNewWithSprite("vegetation_farming_01_13", NewDestroyed, PRIORITY)
MapObjects.OnNewWithSprite("vegetation_farming_01_14", NewDestroyed, PRIORITY)

MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Broccoli, NewBroccoli, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Cabbages, NewCabbages, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Carrots, NewCarrots, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Corn, NewCorn, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Garlic, NewGarlic, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Greenpeas, NewGreenpeas, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Kale, NewKale, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Onion, NewOnion, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Potatoes, NewPotatoes, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Radishes, NewRadishes, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Soybeans, NewSoybeans, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite["Strawberryplant"], NewStrawberry, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.SweetPotato, NewSweetPotato, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Tomato, NewTomato, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Wheat, NewWheat, PRIORITY)

MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Barley, NewBarley, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.BellPepper, NewBellPepper, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Cauliflower, NewCauliflower, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Cucumber, NewCucumber, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Lettuce, NewLettuce, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Pumpkin, NewPumpkin, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Rye, NewRye, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Spinach, NewSpinach, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.SugarBeets, NewSugarBeets, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Tobacco, NewTobacco, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Turnip, NewTurnip, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Watermelon, NewWatermelon, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Zucchini, NewZucchini, PRIORITY)

MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Flax, NewFlax, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Hemp, NewHemp, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Hops, NewHops, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Sunflower, NewSunflower, PRIORITY)

MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Basil, NewBasil, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.BlackSage, NewBlackSage, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.BroadleafPlantain, NewBroadleafPlantain, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Chamomile, NewChamomile, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Chives, NewChives, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Comfrey, NewComfrey, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.CommonMallow, NewCommonMallow, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Habanero, NewHabanero, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Jalapeno, NewJalapeno, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Lavender, NewLavender, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Leek, NewLeek, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.LemonGrass, NewLemonGrass, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Marigold, NewMarigold, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Mint, NewMint, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Oregano, NewOregano, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Parsley, NewParsley, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Poppies, NewPoppies, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Roses, NewRosemary, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Sage, NewSage, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.Thyme, NewThyme, PRIORITY)
MapObjects.OnNewWithSprite(farming_vegetableconf.sprite.WildGarlic, NewWildGarlic, PRIORITY)

-- -- -- -- --

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

local function LoadPlant(isoObject, typeOfSeed)
	if not SFarmingSystem.instance:isValidIsoObject(isoObject) then
		noise("couldn't find valid modData for existing isoObject; recreating it")
		NewPlant(isoObject, typeOfSeed)
	end
	SFarmingSystem.instance:loadIsoObject(isoObject)
end


local function LoadBroccoli(isoObject)
	LoadPlant(isoObject, "Broccoli")
end
local function LoadCarrots(isoObject)
	LoadPlant(isoObject, "Carrots")
end
local function LoadCabbages(isoObject)
	LoadPlant(isoObject, "Cabbages")
end
local function LoadCorn(isoObject)
	LoadPlant(isoObject, "Corn")
end
local function LoadGarlic(isoObject)
	LoadPlant(isoObject, "Garlic")
end
local function LoadGreenpeas(isoObject)
	LoadPlant(isoObject, "Greenpeas")
end
local function LoadKale(isoObject)
	LoadPlant(isoObject, "Kale")
end
local function LoadOnion(isoObject)
	LoadPlant(isoObject, "Onion")
end
local function LoadPotatoes(isoObject)
	LoadPlant(isoObject, "Potatoes")
end
local function LoadRadishes(isoObject)
	LoadPlant(isoObject, "Radishes")
end
local function LoadSoybeans(isoObject)
	LoadPlant(isoObject, "Soybeans")
end
local function LoadStrawberry(isoObject)
	LoadPlant(isoObject, "Strawberryplant")
end
local function LoadSweetPotato(isoObject)
	LoadPlant(isoObject, "SweetPotato")
end
local function LoadTomato(isoObject)
	LoadPlant(isoObject, "Tomato")
end
local function LoadWheat(isoObject)
	LoadPlant(isoObject, "Wheat")
end

local function LoadBarley(isoObject)
	LoadPlant(isoObject, "Barley")
end
local function LoadBellPepper(isoObject)
	LoadPlant(isoObject, "BellPepper")
end
local function LoadCauliflower(isoObject)
	LoadPlant(isoObject, "Cauliflower")
end
local function LoadCucumber(isoObject)
	LoadPlant(isoObject, "Cauliflower")
end
local function LoadLettuce(isoObject)
	LoadPlant(isoObject, "Lettuce")
end
local function LoadPumpkin(isoObject)
	LoadPlant(isoObject, "Pumpkin")
end
local function LoadRye(isoObject)
	LoadPlant(isoObject, "Rye")
end
local function LoadSpinach(isoObject)
	LoadPlant(isoObject, "Spinach")
end
local function LoadSugarBeets(isoObject)
	LoadPlant(isoObject, "SugarBeets")
end
local function LoadTobacco(isoObject)
	LoadPlant(isoObject, "Tobacco")
end
local function LoadTurnip(isoObject)
	LoadPlant(isoObject, "Turnip")
end
local function LoadWatermelon(isoObject)
	LoadPlant(isoObject, "Watermelon")
end
local function LoadZucchini(isoObject)
	LoadPlant(isoObject, "Zucchini")
end

local function LoadFlax(isoObject)
	LoadPlant(isoObject, "Flax")
end
local function LoadHemp(isoObject)
	LoadPlant(isoObject, "Hemp")
end
local function LoadHops(isoObject)
	LoadPlant(isoObject, "Hops")
end
local function LoadSunflower(isoObject)
	LoadPlant(isoObject, "Sunflower")
end

local function LoadBasil(isoObject)
	LoadPlant(isoObject, "Basil")
end
local function LoadBlackSage(isoObject)
	LoadPlant(isoObject, "BlackSage")
end
local function LoadBroadleafPlantain(isoObject)
	LoadPlant(isoObject, "BroadleafPlantain")
end
local function LoadChamomile(isoObject)
	LoadPlant(isoObject, "Chamomile")
end
local function LoadChives(isoObject)
	LoadPlant(isoObject, "Chives")
end
local function LoadCilantro(isoObject)
	LoadPlant(isoObject, "Cilantro")
end
local function LoadComfrey(isoObject)
	LoadPlant(isoObject, "Comfrey")
end
local function LoadCommonMallow(isoObject)
	LoadPlant(isoObject, "CommonMallow")
end
local function LoadHabanero(isoObject)
	LoadPlant(isoObject, "Habanero")
end
local function LoadJalapeno(isoObject)
	LoadPlant(isoObject, "Jalapeno")
end
local function LoadLavender(isoObject)
	LoadPlant(isoObject, "Lavender")
end
local function LoadLeek(isoObject)
	LoadPlant(isoObject, "Leek")
end
local function LoadLemonGrass(isoObject)
	LoadPlant(isoObject, "LemonGrass")
end
local function LoadMarigold(isoObject)
	LoadPlant(isoObject, "Marigold")
end
local function LoadMint(isoObject)
	LoadPlant(isoObject, "Mint")
end
local function LoadOregano(isoObject)
	LoadPlant(isoObject, "Oregano")
end
local function LoadParsley(isoObject)
	LoadPlant(isoObject, "Parsley")
end
local function LoadPoppies(isoObject)
	LoadPlant(isoObject, "Poppies")
end
local function LoadRosemary(isoObject)
	LoadPlant(isoObject, "Rosemary")
end
local function LoadRoses(isoObject)
	LoadPlant(isoObject, "Roses")
end
local function LoadSage(isoObject)
	LoadPlant(isoObject, "Sage")
end
local function LoadThyme(isoObject)
	LoadPlant(isoObject, "Thyme")
end
local function LoadWildGarlic(isoObject)
	LoadPlant(isoObject, "WildGarlic")
end

-- local function LoadFern(isoObject)
	-- LoadPlant(isoObject, "Fern")
-- end

-- local function LoadDragonTree(isoObject)
	-- LoadPlant(isoObject, "DragonTree")
-- end

-- local function LoadSnakePlant(isoObject)
	-- LoadPlant(isoObject, "SnakePlant")
-- end

-- local function LoadCastIronPlant(isoObject)
	-- LoadPlant(isoObject, "CastIronPlant")
-- end

-- local function LoadFicus(isoObject)
	-- LoadPlant(isoObject, "Ficus")
-- end

-- local function LoadChineseEvergreen(isoObject)
	-- LoadPlant(isoObject, "ChineseEvergreen")
-- end

MapObjects.OnLoadWithSprite("vegetation_farming_01_1", LoadPlow, PRIORITY)
MapObjects.OnLoadWithSprite("vegetation_farming_01_13", LoadDestroyed, PRIORITY)
MapObjects.OnLoadWithSprite("vegetation_farming_01_14", LoadDestroyed, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Broccoli, LoadBroccoli, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Cabbages, LoadCabbages, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Carrots, LoadCarrots, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Corn, LoadCorn, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Garlic, LoadGarlic, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Greenpeas, LoadGreenpeas, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Kale, LoadKale, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Onion, LoadOnion, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Potatoes, LoadPotatoes, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Radishes, LoadRadishes, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Soybeans, LoadSoybeans, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite["Strawberryplant"], LoadStrawberry, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.SweetPotato, LoadSweetPotato, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Tomato, LoadTomato, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Wheat, LoadWheat, PRIORITY)

MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Barley, LoadBarley, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.BellPepper, LoadBellPepper, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Cauliflower, LoadCauliflower, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Cucumber, LoadCucumber, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Lettuce, LoadLettuce, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Pumpkin, LoadPumpkin, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Rye, LoadRye, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Spinach, LoadSpinach, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.SugarBeets, LoadSugarBeets, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Tobacco, LoadTobacco, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Turnip, LoadTurnip, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Watermelon, LoadWatermelon, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Zucchini, LoadZucchini, PRIORITY)

MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Flax, LoadFlax, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Hemp, LoadHemp, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Hops, LoadHops, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Sunflower, LoadSunflower, PRIORITY)

MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Basil, LoadBasil, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.BlackSage, LoadBlackSage, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.BroadleafPlantain, LoadBroadleafPlantain, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Chamomile, LoadChamomile, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Chives, LoadChives, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Cilantro, LoadCilantro, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Comfrey, LoadComfrey, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.CommonMallow, LoadCommonMallow, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Habanero, LoadHabanero, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Jalapeno, LoadJalapeno, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Lavender, LoadLavender, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Leek, LoadLeek, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.LemonGrass, LoadLemonGrass, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Marigold, LoadMarigold, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Mint, LoadMint, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Oregano, LoadOregano, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Parsley, LoadParsley, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Poppies, LoadPoppies, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Roses, LoadRoses, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Sage, LoadSage, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Rosemary, LoadRosemary, PRIORITY)
MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Thyme, LoadThyme, PRIORITY)

-- MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Fern, LoadFern, PRIORITY)
-- MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.DragonTree, LoadDragonTree, PRIORITY)
-- MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.SnakePlant, LoadSnakePlant, PRIORITY)
-- MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.CastIronPlant, LoadCastIronPlant, PRIORITY)
-- MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.Ficus, LoadFicus, PRIORITY)
-- MapObjects.OnLoadWithSprite(farming_vegetableconf.sprite.ChineseEvergreen, LoadChineseEvergreen, PRIORITY)
