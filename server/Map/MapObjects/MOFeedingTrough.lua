--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

MOFeedingTrough = {};

local function noise(message) SFeedingTroughSystem.instance:noise(message) end

local function removeExistingLuaObject(square)
	local luaObject = SFeedingTroughSystem.instance:getLuaObjectOnSquare(square)
	if luaObject then
-- 		noise('removing luaObject at same location as newly-loaded isoObject')
		SFeedingTroughSystem.instance:removeLuaObject(luaObject)
	end
end

local function ReplaceExistingObject(isoObject, isNorth)
--	print("replace existing")
	local square = isoObject:getSquare()
	local spriteName = isoObject:getSprite():getName()
	local index = isoObject:getObjectIndex()
	removeExistingLuaObject(square)
	square:transmitRemoveItemFromSquare(isoObject)
	isoObject = IsoFeedingTrough.new(square, spriteName, nil)
	isoObject:setNorth(isNorth);
	isoObject:initWithDef(); -- we have a definition for each feeding trough, with their max feed amount etc..
	square:AddSpecialObject(isoObject, index)
	isoObject:transmitCompleteItemToClients()
	if (isoObject == isoObject:getMasterTrough()) and isoObject:getContainer() then
		MOFeedingTrough.generateContainer(isoObject);
	end

	isoObject:checkOverlayFull();
	return isoObject
end

-- Generate some food inside new feeding trough
MOFeedingTrough.generateContainer = function(trough)
	if trough:getFluidContainer() ~= nil and ZombRand(6) == 0 then
		--trough:setWater(ZombRand(40, trough:getMaxWater()))
		trough:addWater(FluidType.TaintedWater, ZombRand(30, trough:getMaxWater()));
		return;
	end
	if ZombRand(4) == 0 then
		local nb = ZombRand(10, 30);
		for i=0, nb-1 do
			trough:getContainer():AddItem("Base.HayTuft")
		end
	end
	if ZombRand(4) == 0 then
		local nb = ZombRand(10, 30);
		for i=0, nb-1 do
			trough:getContainer():AddItem("Base.GrassTuft")
		end
	end
	if ZombRand(6) == 0 then
		local nb = ZombRand(3, 8);
		for i=0, nb-1 do
			trough:getContainer():AddItem("Base.AnimalFeedBag")
		end
	end
	trough:checkOverlayAfterAnimalEat();
end

-- -- -- -- --

local function NewDoubleW(object)
	ReplaceExistingObject(object, false)
end

local function NewDoubleN(object)
	ReplaceExistingObject(object, true)
end

local function NewSingleW(object)
	ReplaceExistingObject(object, false)
end

local function NewSingleN(object)
	ReplaceExistingObject(object, true)
end

local PRIORITY = 5

MapObjects.OnNewWithSprite("location_farm_accesories_01_4", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_5", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_6", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_7", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_14", NewSingleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_15", NewSingleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_34", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_35", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_32", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_33", NewDoubleN, PRIORITY)

-- triple metal
MapObjects.OnNewWithSprite("location_farm_accesories_01_24", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_25", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_26", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_27", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_28", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_29", NewDoubleW, PRIORITY)

-- quad metal
MapObjects.OnNewWithSprite("location_farm_accesories_01_16", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_17", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_18", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_19", NewDoubleN, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_20", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_21", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_22", NewDoubleW, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_23", NewDoubleW, PRIORITY)

-- -- -- -- --

local function LoadObject(isoObject, isNorth)
	if not SFeedingTroughSystem.instance:isValidIsoObject(isoObject) then
		isoObject = ReplaceExistingObject(isoObject, isNorth)
	end
	SFeedingTroughSystem.instance:loadIsoObject(isoObject)
end

local function LoadDoubleW(object)
	LoadObject(object, false)
end

local function LoadDoubleN(object)
	LoadObject(object, true)
end

local function LoadSingleW(object)
	LoadObject(object, false)
end

local function LoadSingleN(object)
	LoadObject(object, true)
end

MapObjects.OnLoadWithSprite("location_farm_accesories_01_4", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_5", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_6", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_7", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_14", LoadSingleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_15", LoadSingleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_34", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_35", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_32", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_33", LoadDoubleN, PRIORITY)

-- triple metal
MapObjects.OnLoadWithSprite("location_farm_accesories_01_24", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_25", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_26", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_27", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_28", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_29", LoadDoubleW, PRIORITY)

-- quad metal
MapObjects.OnLoadWithSprite("location_farm_accesories_01_16", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_17", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_18", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_19", LoadDoubleN, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_20", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_21", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_22", LoadDoubleW, PRIORITY)
MapObjects.OnLoadWithSprite("location_farm_accesories_01_23", LoadDoubleW, PRIORITY)
