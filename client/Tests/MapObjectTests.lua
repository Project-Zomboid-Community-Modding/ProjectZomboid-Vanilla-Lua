local function getObjectWithSprite(x, y, z, spriteName)
	local square = getCell():getGridSquare(x, y, z)
	if not square then return nil end
	for i=1,square:getObjects():size() do
		local isoObject = square:getObjects():get(i-1)
		if isoObject:getSprite() and ((isoObject:getSprite():getName() == spriteName) or
				(isoObject:getSpriteName() == spriteName)) then
			return isoObject
		end
	end
	return nil
end

local function newObject(x, y, z, spriteName, objectName)
	local square = getCell():getGridSquare(x, y, z)
	if not square then return nil end
	local isoObject = IsoObject.new(square, spriteName, objectName, false)
	square:AddTileObject(isoObject)
	return isoObject
end

local function removeAllButFloor(x, y, z)
	local square = getCell():getGridSquare(x, y, z)
	if not square then return nil end
	for i=square:getObjects():size(),2,-1 do
		local isoObject = square:getObjects():get(i-1)
		square:transmitRemoveItemFromSquare(isoObject)
	end
end

local function testNewObject(x, y, z, spriteName)
	newObject(x, y, z, spriteName)
	MapObjects.debugLoadChunk(math.floor(x / 10), math.floor(y / 10))
end

local function testLoadObject(x, y, z, spriteName)
	newObject(x, y, z, spriteName)
	MapObjects.debugLoadChunk(math.floor(x / 10), math.floor(y / 10))
end

local function expectNotNull(object)
	if object == nil then error "object was null" end
end

local function expectIsoObjectClass(isoObject, className)
	if not instanceof(isoObject, className) then error ("object class isn't "..className) end
end

local function expectIsoObjectContainer(isoObject, containerType)
	if not isoObject:getContainer() then error "container is null" end
	if isoObject:getContainer():getType() ~= containerType then error ("expected container type '"..containerType.."' but found "..isoObject:getContainer():getType()) end
end

local function expectIsoObjectName(isoObject, name)
	if isoObject:getName() ~= name then error ("expected object name '"..name.."' but found "..tostring(isoObject:getName())) end
end

local function expectIsoObjectSprite(isoObject, spriteName)
	if not isoObject:getSprite() then error "sprite is null" end
	if isoObject:getSprite():getName() ~= spriteName then error ("expected spite name '"..spriteName.."' but found "..isoObject:getSprite():getName()) end
end

local function expectModData(modData, expected)
	if not modData then error "object has no modData" end
	for key,value in pairs(expected) do
		if modData[key] ~= value then
			error ("expected "..key.."="..value)
		end
	end
end

local function expectModDataRange(modData, key, min, max)
	if not modData then error "object has no modData" end
	if not modData[key] or modData[key] < min or modData[key] > max then
		error ("expected "..key.." between "..min..' and '..max)
	end
end

local function expectGlobalObject(x, y, z, luaSystem)
	if not luaSystem:getLuaObjectAt(x, y, z) then error "GlobalObject is null" end
end

local function expectGlobalObjectNull(x, y, z, luaSystem)
	if luaSystem:getLuaObjectAt(x, y, z) then error "GlobalObject is not null" end
end

function MapObjectTestCampfire()
	local x,y,z = getPlayer():getX(),getPlayer():getY(),getPlayer():getZ()
	local square = getCell():getGridSquare(x, y, z)

	-- IsoObject -> unlit
	removeAllButFloor(x, y, z)
	expectGlobalObjectNull(x, y, z, CCampfireSystem.instance)
	testNewObject(x, y, z, "camping_01_6")
	local isoObject = getObjectWithSprite(x, y, z, "camping_01_6")
	expectNotNull(isoObject)
	expectIsoObjectClass(isoObject, "IsoObject")
	expectIsoObjectName(isoObject, "Campfire")
	expectIsoObjectContainer(isoObject, "campfire")
	expectModData(isoObject:getModData(), {
		exterior = square:isOutside(),
		isLit = false,
		fuelAmt = 0
	})
	expectGlobalObject(x, y, z, CCampfireSystem.instance)

	-- IsoObject -> lit
	removeAllButFloor(x, y, z)
	expectGlobalObjectNull(x, y, z, CCampfireSystem.instance)
	testNewObject(x, y, z, "camping_01_4")
	-- camping_01_4 (with the flame) isn't used, and IsoFire is instead
	local isoObject = getObjectWithSprite(x, y, z, "camping_01_5")
	expectNotNull(isoObject)
	expectIsoObjectClass(isoObject, "IsoObject")
	expectIsoObjectName(isoObject, "Campfire")
	expectIsoObjectContainer(isoObject, "campfire")
	expectModData(isoObject:getModData(), {
		exterior = square:isOutside(),
		isLit = true,
	})
	expectModDataRange(isoObject:getModData(), "fuelAmt", 3 * 60, 6 * 60)
	expectGlobalObject(x, y, z, CCampfireSystem.instance)
end

function MapObjectTestFarming()
	local x,y,z = getPlayer():getX(),getPlayer():getY(),getPlayer():getZ()

	-- Plow
	removeAllButFloor(x, y, z)
	expectGlobalObjectNull(x, y, z, CFarmingSystem.instance)
	testNewObject(x, y, z, "vegetation_farming_01_1")
	local isoObject = getObjectWithSprite(x, y, z, "vegetation_farming_01_1")
	expectNotNull(isoObject)
	expectIsoObjectClass(isoObject, "IsoObject")
	expectIsoObjectName(isoObject, getText("Farming_Plowed_Land"))
	expectModData(isoObject:getModData(), {
		hasSeed = false,
		hasVegetable = false,
		nbOfGrow = -1,
		state = "plow",
		typeOfSeed = "none"
	})
	expectGlobalObject(x, y, z, CFarmingSystem.instance)

	-- Destroyed random
	removeAllButFloor(x, y, z)
	expectGlobalObjectNull(x, y, z, CFarmingSystem.instance)
	testNewObject(x, y, z, "vegetation_farming_01_13")
	local isoObject = getObjectWithSprite(x, y, z, "vegetation_farming_01_13")
	expectNotNull(isoObject)
	expectIsoObjectClass(isoObject, "IsoObject")
	expectModData(isoObject:getModData(), {
		hasSeed = false,
		hasVegetable = false,
		nbOfGrow = 0,
		state = "destroy",
		typeOfSeed = "none"
	})
	expectGlobalObject(x, y, z, CFarmingSystem.instance)

	-- Destroyed tomato
	removeAllButFloor(x, y, z)
	expectGlobalObjectNull(x, y, z, CFarmingSystem.instance)
	testNewObject(x, y, z, "vegetation_farming_01_14")
	local isoObject = getObjectWithSprite(x, y, z, "vegetation_farming_01_14")
	expectNotNull(isoObject)
	expectIsoObjectClass(isoObject, "IsoObject")
	expectIsoObjectName(isoObject, getText("Farming_Destroyed") .. " " .. getText("Farming_Tomato"))
	expectModData(isoObject:getModData(), {
		hasSeed = false,
		hasVegetable = false,
		nbOfGrow = 0,
		state = "destroy",
		typeOfSeed = "none"
	})
	expectGlobalObject(x, y, z, CFarmingSystem.instance)

	-- Tomato seeded
	removeAllButFloor(x, y, z)
	expectGlobalObjectNull(x, y, z, CFarmingSystem.instance)
	testNewObject(x, y, z, "vegetation_farming_01_64")
	local isoObject = getObjectWithSprite(x, y, z, "vegetation_farming_01_64")
	expectNotNull(isoObject)
	expectIsoObjectClass(isoObject, "IsoObject")
	expectIsoObjectName(isoObject, getText("Farming_Seedling") .. " " .. getText("Farming_Tomato"))
	expectModData(isoObject:getModData(), {
		hasSeed = false,
		hasVegetable = false,
		nbOfGrow = 1,
		state = "seeded",
		typeOfSeed = "Tomato"
	})
	expectGlobalObject(x, y, z, CFarmingSystem.instance)

	-- Tomato seedling
	removeAllButFloor(x, y, z)
	expectGlobalObjectNull(x, y, z, CFarmingSystem.instance)
	testNewObject(x, y, z, "vegetation_farming_01_65")
	local isoObject = getObjectWithSprite(x, y, z, "vegetation_farming_01_65")
	expectNotNull(isoObject)
	expectIsoObjectClass(isoObject, "IsoObject")
	expectIsoObjectName(isoObject, getText("Farming_Seedling") .. " " .. getText("Farming_Tomato"))
	expectModData(isoObject:getModData(), {
		hasSeed = false,
		hasVegetable = false,
		nbOfGrow = 2,
		state = "seeded",
		typeOfSeed = "Tomato"
	})
	expectGlobalObject(x, y, z, CFarmingSystem.instance)

	-- Tomato seed-bearing
	removeAllButFloor(x, y, z)
	expectGlobalObjectNull(x, y, z, CFarmingSystem.instance)
	testNewObject(x, y, z, "vegetation_farming_01_70")
	local isoObject = getObjectWithSprite(x, y, z, "vegetation_farming_01_70")
	expectNotNull(isoObject)
	expectIsoObjectClass(isoObject, "IsoObject")
	expectIsoObjectName(isoObject, getText("Farming_Seed-bearing") .. " " .. getText("Farming_Tomato"))
	expectModData(isoObject:getModData(), {
		hasSeed = true,
		hasVegetable = true,
		nbOfGrow = 7,
		state = "seeded",
		typeOfSeed = "Tomato"
	})
	expectGlobalObject(x, y, z, CFarmingSystem.instance)
end
