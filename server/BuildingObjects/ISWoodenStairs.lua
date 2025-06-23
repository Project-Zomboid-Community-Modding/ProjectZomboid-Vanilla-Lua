--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

ISWoodenStairs = ISBuildingObject:derive("ISWoodenStairs");

--************************************************************************--
--** ISWoodenStairs:new
--**
--************************************************************************--
function ISWoodenStairs:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISWoodenStairs\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	--local thumpable = IsoThumpable.new(cell, self.sq, sprite, north, self);
	self:setInfo(self.sq, 0, north, sprite, self);

	-- name of our 2 sprites needed for the rest of the stairs
	local spriteAName = self.northSprite2;
	local spriteBName = self.northSprite3;

	local xa = x;
	local ya = y;
	local xb = x;
	local yb = y;

	-- we get the x and y of our next tile (depend if we're placing the stairs north or not)
	if north then
		ya = ya - 1;
		yb = yb - 2;
	else
		-- if we're not north we also change our sprite
		spriteAName = self.sprite2;
		spriteBName = self.sprite3;
		xa = xa - 1;
		xb = xb - 2;
	end
	local squareA = getCell():getGridSquare(xa, ya, z);
	if squareA == nil then
		squareA = IsoGridSquare.new(getCell(), nil, xa, ya, z);
		getCell():ConnectNewSquare(squareA, false);
	end
	local squareB = getCell():getGridSquare(xb, yb, z);
	if squareB == nil then
		squareB = IsoGridSquare.new(getCell(), nil, xb, yb, z);
		getCell():ConnectNewSquare(squareB, false);
	end
	if z == 0 and squareA:getFloor():getSprite():getProperties():Is(IsoFlagType.water) then
		squareA:addFloor("carpentry_02_57");
	end
	if z == 0 and squareB:getFloor():getSprite():getProperties():Is(IsoFlagType.water) then
		squareB:addFloor("carpentry_02_57");
	end

	self:setInfo(squareA, 1, north, spriteAName, self);
	self:setInfo(squareB, 2, north, spriteBName, self);

	buildUtil.consumeMaterial(self);
	end

function ISWoodenStairs:setInfo(square, level, north, sprite, luaobject)
	-- add stairs to our ground
    local pillarSprite = self.pillar;
    if north then
        pillarSprite = self.pillarNorth;
    end
	local thumpable = square:AddStairs(north, level, sprite, pillarSprite, luaobject);
	-- recalc the collide
	square:RecalcAllWithNeighbours(true);
	-- name of the item for the tooltip
	thumpable:setName("Wooden Stairs");
	-- we can't barricade/unbarricade the stairs
	thumpable:setCanBarricade(false);
	thumpable:setIsDismantable(true);
	-- the stairs have 500 base health + 100 per carpentry lvl
	thumpable:setMaxHealth(self:getHealth());
	thumpable:setHealth(thumpable:getMaxHealth());
	thumpable:setIsStairs(true);
--	thumpable:setIsThumpable(false)
	-- the sound that will be played when our stairs will be broken
	thumpable:setBreakSound("BreakObject");
	thumpable:setModData(copyTable(self.modData))
	thumpable:transmitCompleteItemToClients();
end

function ISWoodenStairs:new(sprite, sprite2, sprite3, northSprite, northSprite2, northSprite3, pillar, pillarNorth)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSprite(sprite);
	o:setNorthSprite(northSprite);
	o.sprite2 = sprite2;
	o.sprite3 = sprite3;
	o.northSprite2 = northSprite2;
	o.northSprite3 = northSprite3;
    o.pillar = pillar;
    o.pillarNorth = pillarNorth;
    showDebugInfoInChat("Cursor New \'ISWoodenStairs\'")
	return o;
end

-- return the health of the new stairs, it's 500 + 100 per carpentry lvl
function ISWoodenStairs:getHealth()
	return 500 + buildUtil.getWoodHealth(self);
end

function ISWoodenStairs:render(x, y, z, square)
	-- render the first part
	local spriteName = self:getSprite()
	local sprite = IsoSprite.new()
	sprite:LoadSingleTexture(spriteName)

	-- if the square is free and our item can be build
	-- the ConnectedToStairs + north is used to check if the floor is connected to another stair sin the opposite direction (to avoid teleportation)
	local spriteFree = ISBuildingObject.isValid(self, square) and z < getMaximumWorldLevel() and not square:getModData()["ConnectedToStairs" .. tostring(not self.north)]
	local above = getCell():getGridSquare(x, y, z + 1)
	if above and above:getFloor() then spriteFree = false end
	if spriteFree then
		sprite:RenderGhostTile(x, y, z);
	else
		sprite:RenderGhostTileRed(x, y, z);
	end

	-- render the other part of the stairs
	if z >= getMaximumWorldLevel() then
		return;
	end
	-- name of our 2 sprites needed for the rest of the stairs
	local spriteAName = self.northSprite2;
	local spriteBName = self.northSprite3;

	local spriteAFree = true;
	local spriteBFree = true;

	-- we get the x and y of our next tile (depend if we're placing the stairs north or not)
	local xa, ya = self:getSquare2Pos(square, self.north)
	local xb, yb = self:getSquare3Pos(square, self.north)

	-- if we're not north we also change our sprite
	if not self.north then
		spriteAName = self.sprite2;
		spriteBName = self.sprite3;
	end

	local squareA = getCell():getGridSquare(xa, ya, z);
	if squareA == nil and getWorld():isValidSquare(xa, ya, z) then
		squareA = IsoGridSquare.new(getCell(), nil, xa, ya, z);
		getCell():ConnectNewSquare(squareA, false);
	end
	local squareB = getCell():getGridSquare(xb, yb, z);
	if squareB == nil and getWorld():isValidSquare(xb, yb, z) then
		squareB = IsoGridSquare.new(getCell(), nil, xb, yb, z);
		getCell():ConnectNewSquare(squareB, false);
	end

	-- test if the square are free to add our stairs
	if not buildUtil.canBePlace(self, squareA) or squareA:getModData()["ConnectedToStairs" .. tostring(not self.north)] then
		spriteAFree = false;
	end
	if not buildUtil.canBePlace(self, squareB) or squareB:getModData()["ConnectedToStairs" .. tostring(not self.north)] then
		spriteBFree = false;
	end
	above = getCell():getGridSquare(xa, ya, z + 1)
	if above and above:getFloor() then spriteAFree = false end
	above = getCell():getGridSquare(xb, yb, z + 1)
	if above and above:getFloor() then spriteBFree = false end
	if above and above:getWall(self.north) then spriteBFree = false end

	local xt, yt, zt = self:getSquareTopPos(square, self.north)
	local top = getCell():getGridSquare(xt, yt, zt)
	if top and (top:isSolid() or top:isSolidTrans()) then
		spriteBFree = false
	end

	-- render our second stage of the stairs
	local spriteA = IsoSprite.new();
	spriteA:LoadSingleTexture(spriteAName);
	if spriteAFree then
		spriteA:RenderGhostTile(xa, ya, z);
	else
		spriteA:RenderGhostTileRed(xa, ya, z);
	end
	-- render the next tile (last stage of the stairs)
	local spriteB = IsoSprite.new();
	spriteB:LoadSingleTexture(spriteBName);
	if spriteBFree then
		spriteB:RenderGhostTile(xb, yb, z);
	else
		spriteB:RenderGhostTileRed(xb, yb, z);
	end
end

function ISWoodenStairs:isValid(square)
	if square:getZ() >= getMaximumWorldLevel() then return false end
	if not ISBuildingObject.isValid(self, square) then
		return false
	end
	if square:getModData()["ConnectedToStairs" .. tostring(not self.north)] then
		return false
	end
	local xa, ya, za = self:getSquare2Pos(square, self.north)
	local squareA = getCell():getGridSquare(xa, ya, za)
	if not squareA or not buildUtil.canBePlace(self, squareA) or squareA:getModData()["ConnectedToStairs" .. tostring(not self.north)] then
		return false
	end
	local xb, yb, zb = self:getSquare3Pos(square, self.north)
	local squareB = getCell():getGridSquare(xb, yb, zb)
	if not squareB or not buildUtil.canBePlace(self, squareB) or squareB:getModData()["ConnectedToStairs" .. tostring(not self.north)] then
		return false
	end
	-- Check for floors above the stairs.
	local above = getCell():getGridSquare(square:getX(), square:getY(), square:getZ()+1)
	if above and above:getFloor() then return false end
	local above = getCell():getGridSquare(xa, ya, za+1)
	if above and above:getFloor() then return false end
	local above = getCell():getGridSquare(xb, yb, zb+1)
	if above and above:getFloor() then return false end

	-- Don't allow walls at the top of stairs.
	if above and above:getWall(self.north) then
		return false
	end

	-- Don't allow obstacles at the top of stairs.
	local xt, yt, zt = self:getSquareTopPos(square, self.north)
	local top = getCell():getGridSquare(xt, yt, zt)
	if top and (top:isSolid() or top:isSolidTrans()) then
		return false
	end
	
	return true
end

function ISWoodenStairs:getSquare2Pos(square, north)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()
	if north then
		y = y - 1
	else
		x = x - 1
	end
	return x, y, z
end

function ISWoodenStairs:getSquare3Pos(square, north)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()
	if north then
		y = y - 2
	else
		x = x - 2
	end
	return x, y, z
end

function ISWoodenStairs:getSquareTopPos(square, north)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()
	if north then
		y = y - 3
	else
		x = x - 3
	end
	return x, y, z + 1
end

