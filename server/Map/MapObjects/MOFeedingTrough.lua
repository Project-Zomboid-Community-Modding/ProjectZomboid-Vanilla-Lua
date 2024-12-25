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

local function ReplaceExistingObject(isoObject)
--	print("replace existing")
	local square = isoObject:getSquare()
	local spriteName = isoObject:getSprite():getName()
	local index = isoObject:getObjectIndex()
	removeExistingLuaObject(square)
	square:transmitRemoveItemFromSquare(isoObject)
	local north = true;
	if "location_farm_accesories_01_14" == spriteName or "location_farm_accesories_01_4" == spriteName or "location_farm_accesories_01_5" == spriteName or "location_farm_accesories_01_34" == spriteName or "location_farm_accesories_01_35" == spriteName then
		north = false;
	end
	isoObject = IsoFeedingTrough.new(square, spriteName, nil)
	isoObject:setNorth(north);
	-- we don't do double lua object for double feedingtrough, we just gonna link the lua object to the tile to get it from the right click context menu
	if "location_farm_accesories_01_5" == spriteName then
		isoObject:setLinkedX(square:getX());
		isoObject:setLinkedY(square:getY() + 1);
--		print("defined a linked trough")
--		return;
	end
	if "location_farm_accesories_01_6" == spriteName then
		isoObject:setLinkedX(square:getX() + 1);
		isoObject:setLinkedY(square:getY());
--		print("defined a linked trough")
--		return;
	end
	if "location_farm_accesories_01_32" == spriteName then
		isoObject:setLinkedX(square:getX() + 1);
		isoObject:setLinkedY(square:getY());
		--		print("defined a linked trough")
		--		return;
	end
	if "location_farm_accesories_01_35" == spriteName then
		isoObject:setLinkedX(square:getX());
		isoObject:setLinkedY(square:getY() + 1);
		--		print("defined a linked trough")
		--		return;
	end
	isoObject:initWithDef(); -- we have a definition for each feeding trough, with their max feed amount etc..
	square:AddSpecialObject(isoObject, index)
	isoObject:transmitCompleteItemToClients()
	if isoObject:getContainer() then
		MOFeedingTrough.generateContainer(isoObject);
	end

	isoObject:checkOverlayFull();
	return isoObject
end

-- Generate some food inside new feeding trough
MOFeedingTrough.generateContainer = function(trough)
	if ZombRand(6) == 0 then
		trough:setWater(ZombRand(40, trough:getMaxWater()))
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
	ReplaceExistingObject(object)
end

local function NewDoubleN(object)
	ReplaceExistingObject(object)
end

local function NewSingleW(object)
	ReplaceExistingObject(object)
end

local function NewSingleN(object)
	ReplaceExistingObject(object)
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

-- -- -- -- --

local function LoadObject(isoObject)
	if not SFeedingTroughSystem.instance:isValidIsoObject(isoObject) then
		isoObject = ReplaceExistingObject(isoObject)
	end
	SFeedingTroughSystem.instance:loadIsoObject(isoObject)
end

local function LoadDoubleW(object)
	LoadObject(object)
end

local function LoadDoubleN(object)
	LoadObject(object)
end

local function LoadSingleW(object)
	LoadObject(object)
end

local function LoadSingleN(object)
	LoadObject(object)
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

