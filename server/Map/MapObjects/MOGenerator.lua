--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

local function noise(message) print('MOGenerator.lua: '..message) end

local function ReplaceExistingObject(object, fuel, condition, type)
	local cell = getWorld():getCell()
	local square = object:getSquare()
    if not type then type = "Base.Generator" end
	local item = instanceItem(type)
	if item == nil then
		noise('Failed to create '.. tostring(type) ..' item')
		return
	end
	item:setCondition(condition)
	item:getModData().fuel = fuel
	square:transmitRemoveItemFromSquare(object)

	local javaObject = IsoGenerator.new(item, cell, square)
	-- IsoGenerator constructor calls AddSpecialObject, probably it shouldn't.
--	square:AddSpecialObject(javaObject, index)
	javaObject:transmitCompleteItemToClients()
end

local function NewGenerator(object)
	local fuel = 0
	local condition = 100
	ReplaceExistingObject(object, fuel, condition, "Base.Generator")
end

local function NewGenerator_Yellow(object)
	local fuel = 0
	local condition = 100
	ReplaceExistingObject(object, fuel, condition, "Base.Generator_Yellow")
end

local function NewGenerator_Blue(object)
	local fuel = 0
	local condition = 100
	ReplaceExistingObject(object, fuel, condition, "Base.Generator_Blue")
end

local function NewGenerator_Old(object)
	local fuel = 0
	local condition = ZombRand(100) + 1
	ReplaceExistingObject(object, fuel, condition, "Base.Generator_Old")
end

local PRIORITY = 5

MapObjects.OnNewWithSprite("appliances_misc_01_0", NewGenerator, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_1", NewGenerator, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_2", NewGenerator, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_3", NewGenerator, PRIORITY)

MapObjects.OnNewWithSprite("appliances_misc_01_8", NewGenerator_Yellow, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_9", NewGenerator_Yellow, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_10", NewGenerator_Yellow, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_11", NewGenerator_Yellow, PRIORITY)

MapObjects.OnNewWithSprite("appliances_misc_01_12", NewGenerator_Blue, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_13", NewGenerator_Blue, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_14", NewGenerator_Blue, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_15", NewGenerator_Blue, PRIORITY)

MapObjects.OnNewWithSprite("appliances_misc_01_4", NewGenerator_Old, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_5", NewGenerator_Old, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_6", NewGenerator_Old, PRIORITY)
MapObjects.OnNewWithSprite("appliances_misc_01_7", NewGenerator_Old, PRIORITY)

