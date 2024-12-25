--***********************************************************
--**                    THE INDIE STONE                    **
--**                 author: tea-spurcival                 **
--***********************************************************

BuildRecipeCode = BuildRecipeCode or {}
BuildRecipeCode.stairs = {}
BuildRecipeCode.floor = {}
BuildRecipeCode.butcheringHook = {}
BuildRecipeCode.chickenHutch = {}
BuildRecipeCode.feedingTrough = {}
BuildRecipeCode.campfire = {}
BuildRecipeCode.composter = {}
BuildRecipeCode.windowGlass = {};

function BuildRecipeCode.stairs.OnIsValid(params)
	if params.square:getZ() >= getMaximumWorldLevel() then
		return false
	end

	if params.square:getModData()["ConnectedToStairs" .. tostring(not params.north)] then
		return false
	end

	-- Check for floors above the stairs.
	local above = getCell():getGridSquare(params.square:getX(), params.square:getY(), params.square:getZ()+1)
	if above and above:getFloor() then
		return false
	end

	local tileInfoSprite = params.tileInfo:getSpriteName() and getSprite(params.tileInfo:getSpriteName());
	local tileType = tileInfoSprite:getType();
	local isTopStair = tileType == IsoObjectType.stairsTW or tileType == IsoObjectType.stairsTN;
	--local isMiddleStair = tileType == IsoObjectType.stairsMW or tileType == IsoObjectType.stairsMN;
	local isBottomStair = tileType == IsoObjectType.stairsBW or tileType == IsoObjectType.stairsBN;

	-- write back canBuildOverWater true for mid and top stair
	if params.square:getZ() == 0 then
		params.canBuildOverWater = not isBottomStair;
	end

	-- do top stair checks
	if isTopStair then
		-- Don't allow walls at the top of stairs.
		if above and above:getWall(not params.north) then
			return false
		end

		-- Don't allow obstacles at the top of stairs.
		local xt, yt, zt = params.square:getX(), params.square:getY(), params.square:getZ()+1;
		if params.north then
			xt = xt - 1
		else
			yt = yt - 1
		end
		local top = getCell():getGridSquare(xt, yt, zt)
		if top then
			if (top:isSolid() or top:isSolidTrans()) then
				return false
			end
		end
	end

	return true;
end

function BuildRecipeCode.stairs.OnCreate(thumpable)
	local topNorth = thumpable:getType() == IsoObjectType.stairsTN;
	local topWest = thumpable:getType() == IsoObjectType.stairsTW;
	local middleStair = thumpable:getType() == IsoObjectType.stairsMN or thumpable:getType() == IsoObjectType.stairsMW;

	local x = thumpable:getX();
	local y = thumpable:getY();
	local z = thumpable:getZ();

	local square = thumpable:getSquare();
	local overWater = square:getFloor():getSprite():getProperties():Is(IsoFlagType.water);

	-- remove removable objects
	local objects = square:getObjects();
	for i=objects:size()-1, 0, -1 do
		local object = objects:get(i);
		if object and object ~= thumpable then
			local objProps = object:getProperties();

			local shouldRemove = objProps and ((object:getProperties():Is(IsoFlagType.vegitation) and object:getType() ~= IsoObjectType.tree) or object:getProperties():Is(IsoFlagType.canBeRemoved));
			overWater = overWater or object:getSprite():getProperties():Is(IsoFlagType.water) or object:getSprite():getProperties():Is(IsoFlagType.taintedWater);

			if object:getTextureName() ~= nil and string.contains(object:getTextureName(), "floors_rugs") then
				shouldRemove = false;
			end

			if shouldRemove then
				square:transmitRemoveItemFromSquare(object)
				square:RemoveTileObject(object);
			end
		end
	end

	-- get desired floor tile
	local floorTile = "carpentry_02_57";
	if thumpable:getTextureName() and string.contains(thumpable:getTextureName(), "constructedobjects") then
		floorTile = "constructedobjects_01_86";
	end

	-- place floor under stair if on water
	if z == 0 and overWater then
		square:addFloor(floorTile);
	end

	-- add landing
	if topNorth or topWest then
		local above = nil;

		if topNorth then
			if getWorld():isValidSquare(x, y-1, z+1) then
				above = getCell():getGridSquare(x, y-1, z+1);
				if above == nil then
					above = IsoGridSquare.new(getCell(), nil, x, y-1, z+1);
					getCell():ConnectNewSquare(above, false);
				end
				if not above:getProperties():Is(IsoFlagType.solidfloor) then
					above:addFloor(floorTile);
				end
			end
		else
			if getWorld():isValidSquare(x-1, y, z+1) then
				above = getCell():getGridSquare(x-1, y, z+1);
				if above == nil then
					above = IsoGridSquare.new(getCell(), nil, x-1, y, z+1);
					getCell():ConnectNewSquare(above, false);
				end
				if not above:getProperties():Is(IsoFlagType.solidfloor) then
					above:addFloor(floorTile);
				end
			end
		end

		above:getModData()["ConnectedToStairs"..tostring(topNorth)] = true;
		above:RecalcAllWithNeighbours(true);

		above = getCell():getGridSquare(x, y, z+1);
		if above == nil then
			above = IsoGridSquare.new(getCell(), nil, x, y, z+1);
			getCell():ConnectNewSquare(above, false);
		end
		above:RecalcAllWithNeighbours(true);
	end
end 

function BuildRecipeCode.floor.OnIsValid(params)
	if params.square:getZ() > 0 then
		local below = getCell():getGridSquare(params.square:getX(), params.square:getY(), params.square:getZ() - 1)
		if below and below:HasStairs() then
			return false
		end
	end

	local tileInfoSprite = params.tileInfo:getSpriteName();

	for i = 0, params.square:getObjects():size() - 1 do
		local item = params.square:getObjects():get(i);
		if (item:getTextureName() and luautils.stringStarts(item:getTextureName(), "vegetation_farming")) or
				(item:getSpriteName() and luautils.stringStarts(item:getSpriteName(), "vegetation_farming")) then
			return false;
		end
		if (item:getTextureName() and item:getTextureName() == tileInfoSprite) or
				(item:getSpriteName() and item:getSpriteName() == tileInfoSprite) then
			return false
		end
	end

	if not params.square:connectedWithFloor() then
		return false;
	end

	params.testCollisions = false;	-- we have already tested this

	return true;
end 

function BuildRecipeCode.floor.OnCreate(thumpable)
	local square = thumpable:getSquare();
	local objects = square:getObjects();

	-- remove removable objects
	local rug = nil;
	for i=objects:size()-1, 0, -1 do
		local object = objects:get(i);
		if object and object ~= thumpable then
			local objProps = object:getProperties();

			local shouldRemove = objProps and (object:getProperties():Is(IsoFlagType.canBeRemoved) or object:getProperties():Is(IsoFlagType.solidfloor) or object:getProperties():Is(IsoFlagType.noStart) or (object:getProperties():Is(IsoFlagType.vegitation) and object:getType() ~= IsoObjectType.tree) or object:getProperties():Is(IsoFlagType.taintedWater));
			shouldRemove = shouldRemove or (object:getTextureName() ~= nil and (string.contains(object:getTextureName(), "blends_grassoverlays")));

			if object:getTextureName() ~= nil and string.contains(object:getTextureName(), "floors_rugs") then
				rug = object;
				shouldRemove = false;
			end

			if shouldRemove then
				square:transmitRemoveItemFromSquare(object)
				square:RemoveTileObject(object);
			end
		end
	end

	if rug ~= nil then
		-- ensure floor under rug
		local rugIndex = objects:indexOf(rug);
		local floorIndex = objects:indexOf(thumpable);
		if rugIndex < floorIndex then
			-- swap position
			objects:set(rugIndex, thumpable);
			objects:set(floorIndex, rug);
		end
	end

	square:EnsureSurroundNotNull();
	square:RecalcProperties();

	DesignationZoneAnimal.addNewRoof(square:getX(), square:getY(), square:getZ());
	square:getCell():checkHaveRoof(square:getX(), square:getY());

	-- ensure square exists below, connect and recalc
	for z = square:getZ()-1, 0, -1 do
		local below = getCell():getGridSquare(square:getX(), square:getY(), z);
		if below == nil then
			below = IsoGridSquare.getNew(getCell(), nil, square:getX(), square:getY(), z);
			getCell():ConnectNewSquare(below, false);
		end
		below:EnsureSurroundNotNull();
		below:RecalcAllWithNeighbours(true);
	end

	-- clear water/erosion
	square:clearWater();
	square:disableErosion();
	local args = { x = square:getX(), y = square:getY(), z = square:getZ() }
	sendServerCommand('erosion', 'disableForSquare', args)

	-- clear cached visibility/lights/flag square as dirty
	invalidateLighting();
	square:setSquareChanged();
	thumpable:invalidateRenderChunkLevel(FBORenderChunk.DIRTY_OBJECT_ADD);
end

function BuildRecipeCode.butcheringHook.OnCreate(thumpable)
	local sq = thumpable:getSquare();
	local javaObject = IsoButcherHook.new(sq);
	sq:AddTileObject(javaObject)

	sq:transmitRemoveItemFromSquare(thumpable);
end

function BuildRecipeCode.chickenHutch.OnCreate(thumpable)
	local sprite = thumpable:getSprite():getName();

	for i,v in pairs(HutchDefinitions.hutchs) do
		if sprite == v.baseSprite then
			local hutch = IsoHutch.new(thumpable:getSquare(), thumpable:getNorth(), sprite, v, nil)
			hutch:transmitCompleteItemToClients()
			break;
		end
	end

	thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
end

function BuildRecipeCode.feedingTrough.OnCreate(thumpable)
	local sprite = thumpable:getSprite():getName();

	for i,def in pairs(FeedingTroughDef) do
		if def.sprite1 == sprite or def.spriteNorth1 == sprite then
			thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
			SFeedingTroughSystem.instance:addTrough(thumpable:getSquare(),def,thumpable:getNorth(),false)
			if def.sprite2 then
				local x1, y1, z1 = ISFeedingTrough:getSquare2Pos(thumpable:getSquare(),thumpable:getNorth())
				local sq2 = getCell():getGridSquare(x1,y1,z1)
				if sq2 then
					SFeedingTroughSystem.instance:addTrough(sq2,def,thumpable:getNorth(),true)
				end
			end
		end
		
		if def.sprite2 == sprite or def.spriteNorth2 == sprite then
			thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
		end
	end
end

function BuildRecipeCode.campfire.OnIsValid(params)
	if isServer() and SCampfireSystem.instance:getLuaObjectOnSquare(params.square) then
		return false
	end
	if not isServer() and CCampfireSystem.instance:getLuaObjectOnSquare(params.square) then
		return false
	end
	return true
end

function BuildRecipeCode.campfire.OnCreate(thumpable)
	local grid = thumpable:getSquare()
	if not grid then return end
	-- 	if self:getIsoObjectOnSquare(grid) then return nil end

	local luaObject = SCampfireSystem.instance:newLuaObjectOnSquare(grid)
	luaObject:initNew()
	luaObject:addObject()
	luaObject:addContainer()
	luaObject:getIsoObject():transmitCompleteItemToClients()

	-- 	self:noise("#campfires="..self:getLuaObjectCount())
	luaObject:saveData()
	return luaObject;
end

function BuildRecipeCode.composter.OnCreate(thumpable)
	local javaObject = IsoCompost.new(getCell(), thumpable:getSquare(), thumpable:getSprite():getName());
	thumpable:getSquare():AddSpecialObject(javaObject)
	javaObject:syncCompost()
	javaObject:setMovedThumpable(true)

	thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
end

function BuildRecipeCode.windowGlass.OnCreate(thumpable)
	local sprite = thumpable:getSprite():getName();

	local window = IsoWindow.new(getCell(), thumpable:getSquare(), thumpable:getSprite(), thumpable:getNorth());
	window:setIsLocked(false);
	thumpable:getSquare():AddSpecialObject(window);

	thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
end