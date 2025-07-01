-------------------------------------------------------
--              ROBERT JOHNSON'S LUA UTILS           --
-------------------------------------------------------

luautils = {};

-- startWith java style !
luautils.stringStarts = function(String,Start)
	return string.sub(String, 1, string.len(Start)) == Start;
end

luautils.stringEnds = function(String, End)
	return String:sub(-End:len()) == End;
end

luautils.trim = function(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- split java style
luautils.splitJavaStyle = function(pString, pPattern)
   local Table = {};
   local fpat = "(.-)" .. pPattern;
   local last_end = 1;
   local s, e, cap = pString:find(fpat, 1);
   while s do
      if s ~= 1 or cap ~= "" then
		table.insert(Table,cap);
      end
      last_end = e+1;
      s, e, cap = pString:find(fpat, last_end);
   end
   if last_end <= #pString then
      cap = pString:sub(last_end);
      table.insert(Table, cap);
   end
   return Table
end

function luautils.indexOf(table1, value)
	for i,v in ipairs(table1) do
		if v == value then
			return i
		end
	end
	return -1
end

function luautils.tableContains(table2, value)
	for i,v in pairs(table2) do
		if v == value then
			return true
		end
	end
	return false
end

-- get all the tile in the range of the startingGrid
luautils.getNextTiles = function(cell, startingGrid, range)
	local result = {};
	local rangeX = startingGrid:getX() - range;
	if(rangeX < 0) then
		rangeX = 0;
	end
	local rangeY = startingGrid:getY() - range;
	if(rangeY < 0) then
		rangeY = 0;
	end
	local rangeX2 = startingGrid:getX() + range;
	local rangeY2 = startingGrid:getY() + range;
	for x2=rangeX, rangeX2 do
		for y2=rangeY, rangeY2 do
			local nextGrid = cell:getGridSquare(x2, y2, startingGrid:getZ());
			if nextGrid then
				table.insert(result, #result, nextGrid);
			end
		end
	end
	return result;
end

function luautils.walk(playerObj, square, keepActions)
	if not keepActions then
		ISTimedActionQueue.clear(playerObj);
	end
--	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), square) then
		-- Avoid walking to already near spot
		local diffX = math.abs(square:getX() + 0.5 - playerObj:getX());
		local diffY = math.abs(square:getY() + 0.5 - playerObj:getY());
		if diffX <= 0.5 and diffY <= 0.5 then
			return true;
		end
      	if square ~= nil then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, square));
			return true;
		else
			return  false;
		end
--	else
--		return true;
--	end
end

function luautils.walkAdj(playerObj, square, keepActions, excludeList)
	if not keepActions then
		ISTimedActionQueue.clear(playerObj);
	end

	-- check if already on an excluded tile
	local onExcludedTile = false;
	if excludeList then
		for i, test in ipairs(excludeList) do
			if playerObj:getX() == test:getX() and playerObj:getY() == test:getY() and playerObj:getZ() == test:getZ() then
				onExcludedTile = true;
			end
		end
	end
	
	--	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), square) then
	-- Avoid walking to already near spot
	if not onExcludedTile then
		square = luautils.getCorrectSquareForWall(playerObj, square);
		local diffX = math.abs(square:getX() + 0.5 - playerObj:getX());
		local diffY = math.abs(square:getY() + 0.5 - playerObj:getY());
		if diffX <= 1.6 and diffY <= 1.6 and playerObj:getSquare():canReachTo(square) then
			return true;
		end
	end

	local adjacent = AdjacentFreeTileFinder.Find(square, playerObj, excludeList);
	if adjacent ~= nil then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
		return true;
	else
		return  false;
	end
	--	else
	--		return true;
	--	end
end

function luautils.walkAdjTest(playerObj, square)
--	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), square) then
		-- Avoid walking to already near spot
		square = luautils.getCorrectSquareForWall(playerObj, square);
		local diffX = math.abs(square:getX() + 0.5 - playerObj:getX());
		local diffY = math.abs(square:getY() + 0.5 - playerObj:getY());
		if diffX <= 1.6 and diffY <= 1.6 then
			return true;
		end
		local adjacent = AdjacentFreeTileFinder.Find(square, playerObj);
		if adjacent ~= nil then
-- 			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
			return true;
		else
			return  false;
		end
--	else
--		return true;
--	end
end

function luautils.walkAdjAltTest(playerObj, square, altSquare, keepActions)
	if not keepActions then
		ISTimedActionQueue.clear(playerObj);
	end
	if altSquare then
		local diffX = math.abs(square:getX() + 0.5 - altSquare:getX());
		local diffY = math.abs(square:getY() + 0.5 - altSquare:getY());
		if diffX <= 1.6 and diffY <= 1.6 then
			return true;
		end
	end
	square = luautils.getCorrectSquareForWall(playerObj, square);
	local adjacent = AdjacentFreeTileFinder.Find(square, playerObj);
	if adjacent ~= nil then
		ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
		return true;
	else
		return  false;
	end
end

-- taking other side of the wall if we're behind a collidable item
luautils.getCorrectSquareForWall = function(playerObj, square)
    if square:Is(IsoFlagType.collideW) and playerObj:getX() < square:getX() then
        return getCell():getGridSquare(square:getX() + 1, square:getY(), square:getZ());
    end
    if square:Is(IsoFlagType.collideN) and playerObj:getY() < square:getY() then
        return getCell():getGridSquare(square:getX(), square:getY() + 1, square:getZ());
    end
    return square;
end

function luautils.walkAdjWall(playerObj, square, north, keepActions)
	if not keepActions then
		ISTimedActionQueue.clear(playerObj);
	end
--	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), square) then
		local adjacent = AdjacentFreeTileFinder.FindWall(square, north, playerObj);
		if adjacent ~= nil then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
			return true;
		else
			return  false;
		end
--	else
--		return true;
--	end
end

function luautils.walkAdjWindowOrDoor(playerObj, square, item, keepActions)
	if not keepActions then
		ISTimedActionQueue.clear(playerObj);
	end
--	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), square) then
		local adjacent = AdjacentFreeTileFinder.FindWindowOrDoor(square, item, playerObj);
		if adjacent ~= nil then
			if adjacent == playerObj:getCurrentSquare() then
				return true;
			end
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
			return true;
		else
			return  false;
		end
--	else
--		return true;
--	end
end

local function getClosestChoice(choices, playerObj)
	local minDist = 100000
	local closest = nil
	for _,square in ipairs(choices) do
		local dist = square:DistToProper(playerObj)
		if dist < minDist then
			minDist = dist
			closest = square
		end
	end
	return closest
end

function luautils.walkAdjFence(playerObj, square, object, keepActions)
	if not keepActions then
		ISTimedActionQueue.clear(playerObj);
	end
	if object:getProperties():Is(IsoFlagType.cutW) and object:getProperties():Is(IsoFlagType.cutN) then
		-- Special case handling of combined north-west corner fences.
		local choices = {}
		if AdjacentFreeTileFinder.privCanStand(square) then
			table.insert(choices, square)
		end
		local n = square:getAdjacentSquare(IsoDirections.N)
		if n ~= nil and AdjacentFreeTileFinder.privCanStand(n) then
			table.insert(choices, n)
		end
		local w = square:getAdjacentSquare(IsoDirections.W)
		if w ~= nil and AdjacentFreeTileFinder.privCanStand(w) then
			table.insert(choices, w)
		end
		local adjacent = getClosestChoice(choices, playerObj)
		if adjacent ~= nil then
			if adjacent == playerObj:getCurrentSquare() then
				return true;
			end
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
			return true;
		end
		return  false;
	end
--	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), square) then
		local adjacent = AdjacentFreeTileFinder.FindWindowOrDoor(square, object, playerObj);
		if adjacent ~= nil then
			if adjacent == playerObj:getCurrentSquare() then
				return true;
			end
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent));
			return true;
		else
			return  false;
		end
--	else
--		return true;
--	end
end

function luautils.walkToContainer(container, playerNum)
	if container:getType() == "floor" then
		return true
	end
	local playerObj = getSpecificPlayer(playerNum)
	if container:getParent() and not container:getVehiclePart() and container:getParent():getSquare():DistToProper(playerObj:getCurrentSquare()) < 2 then
		return true;
	end

	if container:isInCharacterInventory(playerObj) then
		return true
	end
	local isoObject = container:getParent()
	if not isoObject or not isoObject:getSquare() then
		return true
	end
	if instanceof(isoObject, "BaseVehicle") then
		if playerObj:getVehicle() == isoObject then
			return true
		end
		if playerObj:getVehicle() then
			error "luautils.walkToContainer()"
		end
		local part = container:getVehiclePart()
		if part and part:getArea() then
			if part:getVehicle():canAccessContainer(part:getIndex(), playerObj) then
				return true
			end
			if part:getDoor() and part:getInventoryItem() then
				-- TODO: open the door if needed
			end
			ISTimedActionQueue.add(ISPathFindAction:pathToVehicleArea(playerObj, part:getVehicle(), part:getArea()))
			return true
		end
		error "luautils.walkToContainer()"
	end
	if instanceof(isoObject, "IsoDeadBody") then
		return true
	end
	
	local adjacent = AdjacentFreeTileFinder.Find(isoObject:getSquare(), playerObj)
	if not adjacent then
		return false
	end
	if adjacent == playerObj:getCurrentSquare() then
		return true
	end
	ISTimedActionQueue.clear(playerObj)
	ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
	return true
end

function luautils.haveToBeTransfered(player, item, dontWalk)
	if item and item:getContainer() ~= nil and item:getContainer() ~= player:getInventory() then
		if dontWalk then return true; end
		luautils.walkToContainer(item:getContainer(), player:getPlayerNum())
		return true
	else
		return false;
	end
end

function luautils.haveToBeTransferedWhileTrading(player, item, dontWalk)
	if item and item:getContainer() ~= player:getInventory() then
		if dontWalk then return true; end
		if item:getContainer() ~= nil then
			luautils.walkToContainer(item:getContainer(), player:getPlayerNum())
		end
		return true;
	else
		return false;
	end
end

--[[ moved to env.lua
function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end
--]]

function luautils.round(num, idp)
    return round(num,idp);
end

function luautils.updatePerksXp(perks, player)
	local level = player:getPerkLevel(perks);
	player:getXp():setXPToLevel(perks, level);
end

-------------------------------------------------------
--              ROBOMAT'S LUA UTILS           --
-------------------------------------------------------

---
-- This function tries to equip the passed items as
-- primary or secondary items. It will return the items
-- that had been originally equipped.
-- Alternatively you can pass on Strings (e.g.: "Base.Screwdriver") and
-- the function will try to find that item in the player's inventory and equip it.
--
-- @param _player - The player who equips the items.
-- @param _primItemToEquip - The item to equip in the primary slot.
-- @param _scndItemToEquip - The item to equip in the secondary slot.
--
-- @author RoboMat
--
function luautils.equipItems(_player, _primItemToEquip, _scndItemToEquip)
    local player = _player;
    local primItem = _primItemToEquip;
    local scndItem = _scndItemToEquip;

    -- If we didn't receive an actual item we use the string
    -- to find an appropriate item in the inventory.
    if type(primItem) == 'string' then
        primItem = player:getInventory():FindAndReturn(primItem);
    end
    if type(scndItem) == 'string' then
        scndItem = player:getInventory():FindAndReturn(scndItem);
    end

    -- Store the currently equipped items.
    local storePrim = player:getPrimaryHandItem();
    local storeScnd = player:getSecondaryHandItem();

    -- Equip the new items if necessary.
    if primItem then
        if not storePrim or storePrim ~= primItem then
            ISTimedActionQueue.add(ISEquipWeaponAction:new(player, primItem, 25, true));
        end
    end
    if scndItem then
        if not storeScnd or storeScnd ~= scndItem then
            ISTimedActionQueue.add(ISEquipWeaponAction:new(player, scndItem, 25, false));
        end
    end

    -- Return the stored items in case we want to re-equip them later on.
    return storePrim, storeScnd;
end


---
-- Shows a modal window that informs the player about something and only has
-- an okay button to be closed.
--
-- @param _text - The text to display on the modal
-- @param _centered - If set to true the modal will be centered (optional)
-- @param _width - The width of the window (optional)
-- @param _height - The height of the window (optional)
--
-- @author RoboMat
--
function luautils.okModal(_text, _centered, _width, _height, _posX, _posY)
    local posX = _posX or 0;
    local posY = _posY or 0;
    local width = _width or 230;
    local height = _height or 120;
    local centered = _centered;
    local txt = _text;
    local core = getCore();

    -- center the modal if necessary
    if centered then
        posX = core:getScreenWidth() * 0.5 - width * 0.5;
        posY = core:getScreenHeight() * 0.5 - height * 0.5;
    end

    local modal = ISModalDialog:new(posX, posY, width, height, txt, false, nil, nil);
    modal:initialise();
    modal:addToUIManager();
end

---
-- Based on the walkTo function from RJ's luautils.
--
-- @param _player - Player who should move his buttocks.
-- @param _object - The object / tile to walk to.
-- @param _cancelTA - Determines wether timed actions should be canceled
-- before the player starts to walk.
--
-- @author RoboMat
-- @since 2.0.0
--
function luautils.walkToObject(_player, _object, _cancelTA)
    local player = _player;
    local object = _object;
    local tile = _object:getSquare();
    local cancel = _cancelTA;

    -- Abort all current Timed Actions.
    if cancel then
        ISTimedActionQueue.clear(player);
    end

    -- Pathfinding and starting the actual walking.
    if not AdjacentFreeTileFinder.isTileOrAdjacent(player:getCurrentSquare(), tile) then
        local adjacent = AdjacentFreeTileFinder.FindWindowOrDoor(tile, object, player);
        if adjacent then
            ISTimedActionQueue.add(ISWalkToTimedAction:new(player, adjacent));
            return true;
        end
        return false;
    end
    return true;
end

---
-- Ported the WeaponLowerCondition(...) function of the
-- SwipeState.class to lua. Use this to damage your weapons.
-- If the weapon breaks during the execution of this function
-- it checks in which hand the item was equipped and tries to
-- replace it with the next best weapon.
--
-- @param _weapon - The weapon / item to damage.
-- @param _character - The player who is carrying the weapon.
-- @param _replace - (Optional) Wether or not to replace the item if it is broken.
-- @param _chance - (Optional) The chance for the weapon to be damaged. If omitted it uses the conditionLowerChance of the item.
--
-- @author RoboMat
--
function luautils.weaponLowerCondition(_weapon, _character, _replace, _chance)
    local weapon = _weapon;
    local chance = _chance or weapon:getConditionLowerChance();

    -- Random chance to damage the weapon based on the stats.
    if weapon:damageCheck(0,1, false) then
--     if ZombRand(chance) == 0 then
        local replace = _replace or true;
--         local condition = weapon:getCondition() - 1;
--         weapon:setCondition(condition);

        -- If the weapon breaks unequip it and get a new one instead.
        if condition <= 0 and replace then
            local char = _character;
            local descriptor = char:getDescriptor();
            local newWeapon = char:getInventory():getBestWeapon(descriptor);

            -- Checks in which hand the item was equipped.
            local pos = luautils.isEquipped(weapon, char);

            -- Replace it with the new weapon.
            if pos == 1 then
                ISTimedActionQueue.add(ISEquipWeaponAction:new(char, newWeapon, 25, true));
            elseif pos == 2 then
                ISTimedActionQueue.add(ISEquipWeaponAction:new(char, newWeapon, 25, false));
            elseif pos == 3 then -- TODO
                ISTimedActionQueue.add(ISEquipWeaponAction:new(char, newWeapon, 25, false));
            end
        end
    end
end

---
-- Checks if the item is equipped as the primary or
-- secondary weapon of the player. Returns 1 if the
-- weapon is the primary, 2 if it is the secondary,
-- 3 if it is equipped in both hands at the same time
-- and zero if it is not equipped.
--
-- @param _item - The item to check for.
-- @param _player - The player to search through.
--
-- @return 1 if in primary hand.
-- @return 2 if in secondary hand.
-- @return 3 if in both hands.
-- @return 0 if not equipped.
--
-- @author RoboMat
--
function luautils.isEquipped(_item, _player)
    local p = _player;
    local i = _item;
    local prim = p:getPrimaryHandItem();
    local scnd = p:getSecondaryHandItem();

    if prim == i and scnd == i then
        return 3;
    elseif prim == i then
        return 1;
    elseif scnd == i then
        return 2;
    end
    return 0;
end

function luautils.split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={};
	local i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function luautils.getConditionRGB(condition)
	local r = ((100 - condition) / 100) ;
	local g = (condition / 100);
	return {r = r, g = g, b = 0};
end

---
--checks if two squares are adjacent to one another
--
--@param _square1
--@param _square2
--
--@return true if adjacent
--@return false if not adjacent
--
--@author eris
--
function luautils.isSquareAdjacentToSquare(_square1, _square2)
	if not (_square1 and _square2) then return false; end;
	local squares = {
		n = _square1:getN(),
		s = _square1:getS(),
		e = _square1:getE(),
		w = _square1:getW(),
	};
	for _, square in pairs(squares) do
		if square and (square == _square2) then return true; end;
	end;
	return false;
end

--counts all items in the root container
--
--@param _containerList - a table of container objects to check
--@param _itemsNum - the total number of items
--
--@return the total number of items
--
--@author eris

function luautils.countItemsRecursive(_containerList, _itemsNum)
	local itemsNum = _itemsNum or 0;
	if #_containerList > 0 then
		local nextContainerList = {};
		for i = 1, #_containerList do
			local containerObj = _containerList[i];
			local containerList = containerObj:getItemsFromCategory("Container");
			for j = 0, containerList:size() - 1 do
				table.insert(nextContainerList, containerList:get(j):getInventory());
			end;
			itemsNum = itemsNum + containerObj:getItems():size();
		end;
		return luautils.countItemsRecursive(nextContainerList, itemsNum);
	else
		return itemsNum;
	end;
end

--finds the root container for an inventory
--
--@param _inventory - the inventory to check
--
--@return the root container
--
--@author eris

function luautils.findRootInventory(_inventory)
	local inventory = _inventory;
	local containingItem = inventory:getContainingItem();
	if containingItem and containingItem:getContainer() and containingItem:getContainer():getContainingItem() then
		if containingItem:getInventory() ~= _inventory then
			return luautils.findRootInventory(containingItem:getInventory());
		end;
	end;
	return inventory;
end

--tests for rough equality, useful for checking if something is "close enough" such as the final step of a lerp operation.
--
--@param _value - current value.
--
--@param _value2 - the value we want to check against.
--
--@param _delta - how different can it be, before it's considered unequal.
--
--@return - whether or not it's equal enough.
--
--@author eris

function luautils.roughlyEqual(_value, _value2, _delta)
	return math.abs(_value - _value2) < _delta;
end

--Lerps towards a value, with a built in final step to prevent infinite lerp.
--
--@param _sourceValue - current value.
--
--@param _destinationValue - the value we want to step towards.
--
--@param _stepRate - ratio of steps, higher values are faster.
--
--@param _finalStepRatio - optional, override the final step ratio.
--
--@return - the new value after one step.
--
--@author eris

function luautils.lerp(_sourceValue, _destinationValue, _stepRate, _finalStepRatio)
	--prevent endless lerping towards a target, if the next step would fall below the ratio threshold.
	if (luautils.roughlyEqual(_sourceValue, _destinationValue, _finalStepRatio or _stepRate)) then return _destinationValue; end;

	--return the new value
	return _sourceValue + (_destinationValue - _sourceValue) * _stepRate;
end

--Prints or dumps to file every global variable accessible by Lua.
--
--@param _print (optional) - prints output to console.
--
--@param _save (optional) - save output to LuaGlobals.log.
--
--@param _test (optional) - tests objects for closure, table or function type and prints to console.
--
--@return - void
--
--@author eris

function luautils.exportGlobals(_print, _save, _test)
	if _print then
		for k, v in pairs(_G) do
			print(tostring(k), tostring(v));
		end;
	end;
	if _save then
		print("writing globals to file: LuaGlobals.log");
		local file = getFileWriter("LuaGlobals.log", true, false);
		for k, v in pairs(_G) do
			file:write(tostring(k) .. " = " .. tostring(v) .. "\r\n");
		end;
		file:close();
	end;
	if _test then
		for k, v in pairs(_G) do
			if not (string.find(tostring(v), "closure")
					or string.find(tostring(v), "table")
					or string.find(tostring(v), "function")
			)
			then
				print(tostring(k) .. " = " .. tostring(v) .. " did not pass exportGlobals test.")
			end;
		end;
	end;
end

function round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end

function luautils.packString(stringTable, sep)
	if stringTable == nil then return; end;
	if sep == nil then
		sep = " ";
	end;
	local packedString = "";
	for i, string in pairs(stringTable) do
		packedString = packedString .. string;
		if (i ~= #stringTable) then
			packedString = packedString .. sep;
		end;
	end;
	return packedString;
end

function luautils.unpackString(text, sep)
	local stringTable = {};
	for _, splitString in ipairs(luautils.split(text, sep)) do
		if splitString ~= string.trim(sep) then
			stringTable[#stringTable + 1] = splitString;
		end;
	end;
	return unpack(stringTable);
end