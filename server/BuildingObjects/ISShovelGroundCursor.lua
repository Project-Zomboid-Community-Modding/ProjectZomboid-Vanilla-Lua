--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISShovelGroundCursor = ISBuildingObject:derive("ISShovelGroundCursor")

local function predicateEmpty(item)
	return item:hasTag("HoldDirt") and item:getInventory():isEmpty();
end

local function predicateShovel(item)
	return not item:isBroken() and item:hasTag("TakeDirt")
end

local function predicateNotFull(item, type)
	return (item:getCurrentUsesFloat() + item:getUseDelta() <= 1);
end

local function predicateTypeNotFull(item, type)
	return (item:getFullType() == type) and (item:getCurrentUsesFloat() + item:getUseDelta() <= 1)
end

local function comparatorMostFull(item1, item2)
	return item1:getCurrentUsesFloat() - item2:getCurrentUsesFloat()
end

function ISShovelGroundCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISShovelGroundCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local playerObj = self.character
	local square = getWorld():getCell():getGridSquare(x, y, z)
	local groundType,object = self:getDirtGravelSand(square)
	local fullType,emptyItem = self:getEmptyItem()
	if luautils.walkAdj(playerObj, square, true) then
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, emptyItem)
		ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateShovel, true, true)
		ISTimedActionQueue.add(ISShovelGround:new(playerObj, emptyItem, object, "blends_natural_01_64", fullType))
	end
end

function ISShovelGroundCursor:new(sprite, northSprite, character, groundType)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o:setSprite(sprite)
	o:setNorthSprite(northSprite)
	o.groundType = groundType
	o.character = character
	o.player = character:getPlayerNum()
	o.noNeedHammer = true
	o.skipBuildAction = true
	showDebugInfoInChat("Cursor New \'ISShovelGroundCursor\'")
	return o
end

function ISShovelGroundCursor:isValid(square)
	local groundType,object = self:getDirtGravelSand(square)
	local itemCounts = ISShovelGroundCursor.GetEmptyItemCounts(self.character)
	return (groundType == self.groundType) and (itemCounts[groundType] + itemCounts.empty > 0)
end

function ISShovelGroundCursor:render(x, y, z, square)
	local groundType,object = self:getDirtGravelSand(square)
	local hc = getCore():getGoodHighlitedColor()
	if not self:isValid(square) then
		hc = getCore():getBadHighlitedColor()
	end
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)
end

function ISShovelGroundCursor.GetEmptyItemCounts(playerObj)
	local playerInv = playerObj:getInventory()
	local items = {}
	items.empty = playerInv:getCountEvalRecurse(predicateEmpty)
	items.dirt = playerInv:getCountTypeEvalRecurse("Dirtbag", predicateNotFull)
	items.gravel = playerInv:getCountTypeEvalRecurse("Gravelbag", predicateNotFull)
	items.sand = playerInv:getCountTypeEvalRecurse("Sandbag", predicateNotFull)
	items.clay = playerInv:getCountTypeEvalRecurse("Claybag", predicateNotFull)
	return items
end

function ISShovelGroundCursor.GetEmptyItem(playerObj, groundType)
	local playerInv = playerObj:getInventory()
	local fullType
	if groundType == "dirt" then
		fullType = "Base.Dirtbag"
	elseif groundType == "gravel" then
		fullType = "Base.Gravelbag"
	elseif groundType == "sand" then
		fullType = "Base.Sandbag"
	elseif groundType == "clay" then
        fullType = "Base.Claybag"
	end
	local item = playerInv:getBestEvalArgRecurse(predicateTypeNotFull, comparatorMostFull, fullType)
	if not item then
		item = playerInv:getFirstEvalRecurse(predicateEmpty)
	end
	return fullType,item
end

function ISShovelGroundCursor.GetDirtGravelSand(square)
	local index = square:getNextNonItemObjectIndex(0)
	while index >= 0 and index < square:getObjects():size() do
		local obj = square:getObjects():get(index)
		index = square:getNextNonItemObjectIndex(index + 1)
		if obj:hasModData() and obj:getModData().shovelled then
			-- skip already-shovelled squares
		elseif not isServer() and CFarmingSystem.instance and CFarmingSystem.instance:getLuaObjectOnSquare(square) then
			-- skip dirt with farm plants
		elseif obj:getSprite() and obj:getSprite():getName() then
			local spriteName = obj:getSprite():getName()
			if spriteName == "floors_exterior_natural_01_13" or
					spriteName == "blends_street_01_55" or
					spriteName == "blends_street_01_54" or
					spriteName == "blends_street_01_53" or
					spriteName == "blends_street_01_48" then
				return "gravel",obj
			end
			if spriteName == "blends_natural_01_0" or
						spriteName == "blends_natural_01_5" or
						spriteName == "blends_natural_01_6" or
						spriteName == "blends_natural_01_7" or
						spriteName == "floors_exterior_natural_01_24" then
				return "sand",obj
			end
			if spriteName == "blends_natural_01_96" or
						spriteName == "blends_natural_01_101" or
            			spriteName == "blends_natural_01_102" or
            			spriteName == "blends_natural_01_103" then
            	return "clay",obj
            end
			if luautils.stringStarts(spriteName, "blends_natural_01_") or
					luautils.stringStarts(spriteName, "floors_exterior_natural") then
				return "dirt",obj
			end
		end
	end
	return nil
end

function ISShovelGroundCursor:getDirtGravelSand(square)
	return ISShovelGroundCursor.GetDirtGravelSand(square)
end

function ISShovelGroundCursor:getEmptyItem()
	return ISShovelGroundCursor.GetEmptyItem(self.character, self.groundType)
end

