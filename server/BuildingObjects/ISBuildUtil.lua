--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

buildUtil = {};
buildUtil.cheat = false or getDebug(); -- we need this? we already have "ISBuildMenu.cheat"

-- if a thumpable item already placed on this tile, we cannot place another
buildUtil.canBePlace = function(ISItem, square)
	if not square then
		return false
	end
	if square:getZ() >= 32 then
		return false;
	end
	if isClient() and SafeHouse.isSafeHouse(square, getSpecificPlayer(ISItem.player):getUsername(), true) then
		return false;
	end
	if isServer() and SafeHouse.isSafeHouse(square, ISItem.player:getUsername(), true) then
        return false;
    end
	for i = 0, square:getObjects():size() - 1 do
		local item = square:getObjects():get(i);
		if (item:getSprite() and ((item:getSprite():getProperties():Is(IsoFlagType.collideN) and ISItem.north) or
				(item:getSprite():getProperties():Is(IsoFlagType.collideW) and not ISItem.north))) or
				((instanceof(item, "IsoThumpable") and (item:getNorth() == ISItem.north or ISItem.ignoreNorth)) and not item:isCorner() and not item:isFloor()) or
				(instanceof(item, "IsoWindow") and item:getNorth() == ISItem.north) or
				(instanceof(item, "IsoDoor") and item:getNorth() == ISItem.north) then
			-- even if we can place this item everywhere, we can't place 2 same objects on the same tile
			if ISItem.canBeAlwaysPlaced and ISItem:getSprite() == item:getTextureName() then
				return false;
			elseif ISItem.canBeAlwaysPlaced then
				return true;
			end
			return false;
		end
	end
	if square:isVehicleIntersecting() then return false end
	return true;
end

-- give the health of the item, depending on you're carpentry level + if you're a construction worker
buildUtil.getWoodHealth = function(ISItem)
	if not ISItem or not ISItem.player then
		return 100;
	end
    local playerObj = ISItem.player
    if not isServer() then
        playerObj = getSpecificPlayer(ISItem.player)
    end
	local health = (playerObj:getPerkLevel(Perks.Woodwork) * 50);
	if playerObj:HasTrait("Handy") then
		health = health + 100;
	end
	return health;
end

-- check if a corner has to be added
-- if you place a wall to make a corner for example, there is still a hole where you can walk, so your fort will not be zombie proof
-- here we gonna check if, when you add a wall, we need to add a corner
function buildUtil.checkCorner(x, y, z, north, thumpable, item)
	local found = false;
	local xoffset = 1;
	local yoffset = -1;
	local sx = x + 1;
	local sy = y;
	if not north then
		xoffset = -1;
		yoffset = 1;
		sx = x;
		sy = y + 1;
	end
	local sq2 = getCell():getGridSquare(x + xoffset, y + yoffset, z);
	if not sq2 then return end
	for i = 0, sq2:getSpecialObjects():size() - 1 do
		local item = sq2:getSpecialObjects():get(i);
		if instanceof(item, "IsoThumpable") and item:getNorth() ~= north  then
			found = true;
			break;
		end
	end
	if found then
		-- don't add a corner if there's a wall on the tile
		local sq2 = getCell():getGridSquare(sx, sy, z);
		if sq2 and sq2:getWallFull() then
			return;
		end
		buildUtil.addCorner(sx,sy,z,thumpable,item);
	end
end

-- add the needed corner so there will be no hole in your fort
function buildUtil.addCorner(x,y,z, thumpable, item)
	if item.corner ~= nil then
		local sq = getCell():getGridSquare(x, y, z);
		local corner = IsoThumpable.new(getCell(), sq, item.corner, false, nil);
		corner:setCorner(true);
		corner:setCanBarricade(false);
		corner:setCanBePlastered(true);
		sq:AddSpecialObject(corner);
		sq:RecalcAllWithNeighbours(true);
		corner:transmitCompleteItemToClients();
	end
end

function buildUtil.addWoodXp(ISItem)
    local playerObj = ISItem.player
    if not isServer() then
        playerObj = getSpecificPlayer(ISItem.player)
    end
	addXp(playerObj, Perks.Woodwork, 3)
end

function buildUtil.predicateMaterial(item)
	return not instanceof(item, "InventoryContainer") or item:getInventory():getItems():isEmpty()
end

function buildUtil.useDrainable(item, uses)
	local count = math.min(uses, item:getCurrentUses())
	for i=1,count do
		item:UseAndSync()
	end
	return count
end

-- we gonna remove from the inventory all the required material
-- those material are in the mod data and they look like = ["need:Plank"] = "2", etc.
-- those need: stuff are used when you dismantle the item too
function buildUtil.consumeMaterial(ISItem)
	if not ISItem or not ISItem.player then return {}; end
	if not isServer() and ISBuildMenu.cheat then
		return {};
	end
	local playerObj = ISItem.player
	if not isServer() then
	    playerObj = getSpecificPlayer(ISItem.player)
	end
	local playerInv = playerObj:getInventory()
	local modData = ISItem.modData;
	local removedFromGround = false
	local consumedItems = {}
	for index, value in pairs(modData) do
		if luautils.stringStarts(index, "need:") then
			local itemFullType = luautils.split(index, ":")[2];
			local itemType = luautils.split(itemFullType, "%.")[2]
			local itemCount = tonumber(value);
			local items = playerInv:getSomeTypeEvalRecurse(itemFullType, buildUtil.predicateMaterial, itemCount)
			for i=1,items:size() do
				local item = items:get(i-1)
				playerObj:removeFromHands(item)
				if item:getContainer() then
					item:getContainer():Remove(item);
					sendRemoveItemFromContainer(item:getContainer(), item);
				else
					playerInv:Remove(item)
					sendRemoveItemFromContainer(playerInv, item);
				end
				itemCount = itemCount - 1
				table.insert(consumedItems, item)
			end
			-- if we didn't have all the required material inside our inventory, it's because the missing materials are on the ground, we gonna check them
			-- for each missing material in inventory
			if itemCount > 0 then
				-- check a 3x3 square around the building
				local groundItems = buildUtil.getMaterialOnGround(ISItem.sq)
				local items = groundItems[itemFullType]
				if items then
					local count = math.min(itemCount, #items)
					for i=1,count do
						local item = items[i]
						local worldObj = item:getWorldItem()
						table.insert(consumedItems, item)
						worldObj:getSquare():transmitRemoveItemFromSquare(worldObj)
					end
					itemCount = itemCount - count
					removedFromGround = true
				end
			end
			if itemCount > 0 and itemFullType == "Base.Nails" then
				buildUtil.openNailsBox(ISItem)
				items = playerInv:getSomeTypeEvalRecurse(itemFullType, buildUtil.predicateMaterial, itemCount)
				for i=1,items:size() do
					local item = items:get(i-1)
					playerObj:removeFromHands(item)
					if item:getContainer() then
						item:getContainer():Remove(item);
						sendRemoveItemFromContainer(item:getContainer(), item);
					else
						playerInv:Remove(item)
						sendRemoveItemFromContainer(playerInv, item);
					end
					itemCount = itemCount - 1
					table.insert(consumedItems, item)
				end
			end
			if itemCount > 0 then
				print('ERROR: consumeMaterial() did not find all required materials!')
			end
		end
		if luautils.stringStarts(index, "use:") then
			local itemFullType = luautils.split(index, ":")[2];
			local itemType = luautils.split(itemFullType, "%.")[2]
			local uses = tonumber(value);
			local remaining = uses
			local items = playerInv:getAllTypeRecurse(itemFullType)
			for i=1,items:size() do
				local item = items:get(i-1)
				if item:getCurrentUses() > 0 then
					remaining = remaining - buildUtil.useDrainable(item, remaining)
					table.insert(consumedItems, item)
					if remaining <= 0 then
						break
					end
				end
			end
			if remaining > 0 then
				local groundItems = buildUtil.getMaterialOnGround(ISItem.sq)
				local items = groundItems[itemFullType]
				if items then
					for _,item in ipairs(items) do
						if item:getCurrentUses() > 0 then
							remaining = remaining - buildUtil.useDrainable(item, remaining)
							table.insert(consumedItems, item)
							removedFromGround = true
							if remaining <= 0 then
								break
							end
						end
					end
				end
			end
		end
		if luautils.stringStarts(index, "xp:") then
			local skill = luautils.split(index, ":")[2];
			local xp = tonumber(value);
			addXp(playerObj, Perks.FromString(skill), xp)
		end
	end
	if removedFromGround then ISInventoryPage.dirtyUI() end
	return consumedItems
end

function buildUtil.openNailsBox(ISItem)
	if not ISItem or not ISItem.player then return {}; end
	if not isServer() and ISBuildMenu.cheat then
		return {};
	end
	local playerObj = ISItem.player
    if not isServer() then
        playerObj = getSpecificPlayer(ISItem.player)
    end
	local consumedItems = {}
	local playerInv = playerObj:getInventory()
	local itemFullType = "Base.NailsBox"
	local itemCount = 1
	local items = playerInv:getSomeTypeEvalRecurse(itemFullType, buildUtil.predicateMaterial, itemCount)
	for i=1,items:size() do
		local item = items:get(i-1)
		playerObj:removeFromHands(item)
		if item:getContainer() then
			sendRemoveItemFromContainer(item:getContainer(), item);
			item:getContainer():Remove(item);
		else
			playerInv:Remove(item)
			sendRemoveItemFromContainer(playerInv, item);
		end
		itemCount = itemCount - 1
		table.insert(consumedItems, item)
	end
	-- if we didn't have all the required material inside our inventory, it's because the missing materials are on the ground, we gonna check them
	-- for each missing material in inventory
	if itemCount > 0 then
		-- check a 3x3 square around the building
		local groundItems = buildUtil.getMaterialOnGround(ISItem.square)
		local items = groundItems[itemFullType]
		if items then
			local count = math.min(itemCount, #items)
			for i=1,count do
				local item = items[i]
				local worldObj = item:getWorldItem()
				table.insert(consumedItems, item)
				worldObj:getSquare():transmitRemoveItemFromSquare(worldObj)
			end
			itemCount = itemCount - count
			removedFromGround = true
		end
	end
	for i=1,#consumedItems do
		local items = playerObj:getInventory():AddItems("Base.Nails", 20) -- 20x5=100
		sendAddItemsToContainer(playerObj:getInventory(), items);
	end

	if removedFromGround then
		if isServer() then
			sendServerCommand(playerObj, 'ui', 'dirtyUI', { });
		else
			ISInventoryPage.dirtyUI();
		end
	end
end

function buildUtil.removeFromGround(square)
	for i = 0, square:getSpecialObjects():size()-1 do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
		end
	end
end

function buildUtil.getMaterialOnGround(squareToCheck)
	local result = {}
	if not squareToCheck then
		return result
	end
	for x=squareToCheck:getX()-1,squareToCheck:getX()+1 do
		for y=squareToCheck:getY()-1,squareToCheck:getY()+1 do
			local square = getCell():getGridSquare(x,y,squareToCheck:getZ())
			local wobs = square and square:getWorldObjects() or nil
			if wobs ~= nil then
				for i = 1,wobs:size() do
					local obj = wobs:get(i-1)
					local item = obj:getItem()
					if buildUtil.predicateMaterial(item) then
						local items = result[item:getFullType()] or {}
						table.insert(items, item)
						result[item:getFullType()] = items
						result[item:getType()] = items
					end
				end
			end
		end
	end
	return result
end

function buildUtil.getMaterialOnGroundCounts(itemMap)
	local result = {}
	for type,items in pairs(itemMap) do
		result[type] = #items
	end
	return result
end

function buildUtil.getMaterialOnGroundUses(itemMap)
	local result = {}
	for type,items in pairs(itemMap) do
		local item = items[1]
		if instanceof(item, "DrainableComboItem") then
			local uses = 0
			for _,item in ipairs(items) do
				uses = uses + item:getCurrentUses()
			end
			result[type] = uses
		end
	end
	return result
end

function buildUtil.checkMaterialOnGround(squareToCheck)
	local itemMap = buildUtil.getMaterialOnGround(squareToCheck)
	return buildUtil.getMaterialOnGroundCounts(itemMap)
end

-- all those infos are saved in java
function buildUtil.setInfo(javaObject, ISItem)
	javaObject:setCanPassThrough(ISItem.canPassThrough);
	javaObject:setCanBarricade(ISItem.canBarricade);
	javaObject:setThumpDmg(ISItem.thumpDmg);
	javaObject:setIsContainer(ISItem.isContainer);
	javaObject:setIsDoor(ISItem.isDoor);
	javaObject:setIsDoorFrame(ISItem.isDoorFrame);
	javaObject:setCrossSpeed(ISItem.crossSpeed);
	javaObject:setBlockAllTheSquare(ISItem.blockAllTheSquare);
	javaObject:setName(ISItem.name);
	javaObject:setIsDismantable(ISItem.dismantable);
	javaObject:setCanBePlastered(ISItem.canBePlastered);
	javaObject:setIsHoppable(ISItem.hoppable);
	javaObject:setModData(copyTable(ISItem.modData));
	if ISItem.isStairs then
		javaObject:setIsStairs(ISItem.isStairs);
	end
    javaObject:setIsThumpable(ISItem.isThumpable);
	if ISItem.isCorner then
		javaObject:setCorner(ISItem.isCorner);
	end
    if ISItem.containerType and javaObject:getContainer() then
       javaObject:getContainer():setType(ISItem.containerType);
    end
    if ISItem.canBeLockedByPadlock then
        javaObject:setCanBeLockByPadlock(ISItem.canBeLockedByPadlock);
    end
	if ISItem.modData and ISItem.modData["use:Base.BlowTorch"] then
		javaObject:setThumpSound("ZombieThumpMetal")
	end
	javaObject:setIsFloor(ISItem.isFloor);
end

local function addStairObject(objects, x, y, z)
	local square = getCell():getGridSquare(x, y, z)
	if not square then return end
	for i = square:getObjects():size(),1,-1 do
		local object = square:getObjects():get(i-1)
		if object:isStairsObject() then
			table.insert(objects, object)
		end
	end
end

local function getFloorObject(x, y, z)
	local square = getCell():getGridSquare(x, y, z)
	return square and square:getFloor() or nil
end

local function hasAdjacentFloor(x, y, z)
	for dy = -1,1 do
		for dx = -1,1 do
			if dx ~= 0 or dy ~= 0 then
				if getFloorObject(x + dx, y + dy, z) then
					return true
				end
			end
		end
	end
	return false
end

local function hasStairElements( x, y, z, checkTypes)
    local square = getCell():getGridSquare(x, y, z)
    if square and square:getFloor() then
        for _,objType in pairs(checkTypes) do
            if square:Has(objType) then
                return true;
            end
        end
    end
    return false;
end

-- for solid objects such as crates and other furniture only pass square and doAdjacent, for wall-like objects pass a north value for the object
-- behaviour is different based on above in the check for topstair elements
function buildUtil.stairIsBlockingPlacement( _square, _doAdjacent, _north )
    if _square then
        -- check if any kind of stair is on square
        if _square:HasStairs() then
            if _north == nil then
                return true
            end
            -- allow walls with the right orientation
            if _north == true and _square:HasStairsNorth() then
                return true
            end
            if _north == false and _square:HasStairsWest() then
                return true
            end
        end

        if not _doAdjacent then return false; end
        -- check for top and bot stairs on adjacent positions
        local x,y,z = _square:getX(), _square:getY(), _square:getZ();

        --check for bottom stair elements on current level
        if (_north==nil or _north==true) and hasStairElements(x,y-1,z,{IsoObjectType.stairsBN}) then
            return true;
        end
        if (_north==nil or _north==false) and hasStairElements(x-1,y,z,{IsoObjectType.stairsBW}) then
            return true;
        end

        --check for top stair elements below current level, for wall objects only returns true if the wall is actually blocking the stair
        if z>0 then
            if _north==nil and (hasStairElements(x,y+1,z-1,{IsoObjectType.stairsTN}) or hasStairElements(x+1,y,z-1,{IsoObjectType.stairsTW})) then
                return true;
            end
            if _north==true and hasStairElements(x,y,z-1,{IsoObjectType.stairsTN}) then
                return true;
            end
            if _north==false and hasStairElements(x,y,z-1,{IsoObjectType.stairsTW}) then
                return true;
            end
        end
    end
    return false;
end

local function countAdjacentStairs(x, y, z)
	local count = 0
	local square = getCell():getGridSquare(x + 1, y, z)
	if square and square:Has(IsoObjectType.stairsTW) then
		count = count + 1
	end
	square = getCell():getGridSquare(x, y + 1, z)
	if square and square:Has(IsoObjectType.stairsTN) then
		count = count + 1
	end
	return count
end

function buildUtil.getStairObjects(object, skipFloor)
	local objects = {}
	local x, y, z = object:getX(), object:getY(), object:getZ()
	if object:getType() == IsoObjectType.stairsTW then
		table.insert(objects, object)
		addStairObject(objects, x + 1, y, z)
		addStairObject(objects, x + 2, y, z)
	elseif object:getType() == IsoObjectType.stairsMW then
		addStairObject(objects, x - 1, y, z)
		table.insert(objects, object)
		addStairObject(objects, x + 1, y, z)
	elseif object:getType() == IsoObjectType.stairsBW then
		addStairObject(objects, x - 2, y, z)
		addStairObject(objects, x - 1, y, z)
		table.insert(objects, object)
	elseif object:getType() == IsoObjectType.stairsTN then
		table.insert(objects, object)
		addStairObject(objects, x, y + 1, z)
		addStairObject(objects, x, y + 2, z)
	elseif object:getType() == IsoObjectType.stairsMN then
		addStairObject(objects, x, y - 1, z)
		table.insert(objects, object)
		addStairObject(objects, x, y + 1, z)
	elseif object:getType() == IsoObjectType.stairsBN then
		addStairObject(objects, x, y - 2, z)
		addStairObject(objects, x, y - 1, z)
		table.insert(objects, object)
	end
	-- Also destroy the floor at the top of the stairs if it isn't adjacent to another floor tile.
	-- Don't destroy the floor if it is adjacent to another staircase.
	if #objects > 0 and (not skipFloor) then
		for i=1,#objects do
			local floor = nil
			x, y, z = objects[i]:getX(), objects[i]:getY(), objects[i]:getZ()
			if objects[i]:getType() == IsoObjectType.stairsTW then
				floor = getFloorObject(x - 1, y, z + 1)
			elseif objects[i]:getType() == IsoObjectType.stairsTN then
				floor = getFloorObject(x, y - 1, z + 1)
			end
			if floor and not hasAdjacentFloor(floor:getX(), floor:getY(), floor:getZ()) and
					countAdjacentStairs(floor:getX(), floor:getY(), floor:getZ() - 1) == 1 then
				table.insert(objects, floor)
			end
		end
	end
	return objects
end

function buildUtil.getDoubleDoorObjects(object)
	local objects = {}
	for i=1,4 do
		local dd = IsoDoor.getDoubleDoorObject(object, i)
		if dd then
			table.insert(objects, dd)
		end
	end
	return objects
end

function buildUtil.getGarageDoorObjects(object)
	local objects = {}
	if IsoDoor.getGarageDoorIndex(object) ~= -1 then
		table.insert(objects, object)
		local prev = IsoDoor.getGarageDoorPrev(object)
		while prev do
			table.insert(objects, prev)
			prev = IsoDoor.getGarageDoorPrev(prev)
		end
		local next = IsoDoor.getGarageDoorNext(object)
		while next do
			table.insert(objects, next)
			next = IsoDoor.getGarageDoorNext(next)
		end
	end
	return objects
end

function buildUtil.getGraveObjects(object)
	local objects = {}
	if not object or object:getName() ~= "EmptyGraves" then
		return objects
	end
	table.insert(objects, object)
	local sq1 = object:getSquare()
	local sq2 = nil
	if object:getNorth() then
		if object:getModData()["spriteType"] == "sprite1" then
			sq2 = getCell():getGridSquare(sq1:getX(), sq1:getY() - 1, sq1:getZ())
		elseif object:getModData()["spriteType"] == "sprite2" then
			sq2 = getCell():getGridSquare(sq1:getX(), sq1:getY() + 1, sq1:getZ())
		end
	else
		if object:getModData()["spriteType"] == "sprite1" then
			sq2 = getCell():getGridSquare(sq1:getX() - 1, sq1:getY(), sq1:getZ())
		elseif object:getModData()["spriteType"] == "sprite2" then
			sq2 = getCell():getGridSquare(sq1:getX() + 1, sq1:getY(), sq1:getZ())
		end
	end
	for i=1,sq2:getSpecialObjects():size() do
		local object2 = sq2:getSpecialObjects():get(i-1)
		if object2:getName() == "EmptyGraves" then
			table.insert(objects, object2)
			break
		end
	end
	return objects
end

function buildUtil.setHaveConstruction(_square, _hasConstruction)
	if _square and _square:getZone() then
		_square:getZone():setHaveConstruction(_hasConstruction);
		if isClient() then _square:getZone():sendToServer(); end;
	end;
end
