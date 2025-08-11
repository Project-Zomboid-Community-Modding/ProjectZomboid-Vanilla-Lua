--***********************************************************
--**                    THE INDIE STONE                    **
--**                 author: tea-spurcival                 **
--***********************************************************

BuildRecipeCode = BuildRecipeCode or {}
BuildRecipeCode.barricade = {}
BuildRecipeCode.canBePlastered = {}
BuildRecipeCode.stairs = {}
BuildRecipeCode.floor = {}
BuildRecipeCode.doorFrame = {}
BuildRecipeCode.butcheringHook = {}
BuildRecipeCode.chickenHutch = {}
BuildRecipeCode.feedingTrough = {}
BuildRecipeCode.campfire = {}
BuildRecipeCode.composter = {}
BuildRecipeCode.windowGlass = {};
BuildRecipeCode.woodLampPillar = {};

function BuildRecipeCode.barricade.OnIsValid(params)
	local tileInfoSprite = params.tileInfo:getSpriteName() and getSprite(params.tileInfo:getSpriteName());
	local square = params.square
    if params.facing == "s" then
        square = getWorld():getCell():getGridSquare(square:getX(), square:getY()+1, square:getZ());
    elseif params.facing == "e" then
        square = getWorld():getCell():getGridSquare(square:getX()+1, square:getY(), square:getZ());
    end
    local objects = square:getObjects();

	for i = 0,objects:size()-1 do
        local object = objects:get(i);
        if (((instanceof(object, "IsoDoor") and not object:IsOpen()) or instanceof(object,"IsoWindow")) and object:isBarricadeAllowed()) or (instanceof(object, "IsoThumpable") and object:getCanBarricade()) then
            if (params.facing == "s" or params.facing == "e") and (params.north == object:getNorth()) and not object:getBarricadeOnOppositeSquare() then
                return true;
            elseif (params.facing == "n" or params.facing == "w") and (params.north == object:getNorth()) and not object:getBarricadeOnSameSquare() then
                return true;
            end
        end
	end

    return false;
end

function BuildRecipeCode.barricade.OnIsValidPlanks(params)
	local tileInfoSprite = params.tileInfo:getSpriteName() and getSprite(params.tileInfo:getSpriteName());
	local square = params.square
    if params.facing == "s" then
        square = getWorld():getCell():getGridSquare(square:getX(), square:getY()+1, square:getZ());
    elseif params.facing == "e" then
        square = getWorld():getCell():getGridSquare(square:getX()+1, square:getY(), square:getZ());
    end
    local objects = square:getObjects();

	for i = 0,objects:size()-1 do
         local object = objects:get(i);
         if (((instanceof(object, "IsoDoor") and not object:IsOpen()) or instanceof(object,"IsoWindow")) and object:isBarricadeAllowed()) or (instanceof(object, "IsoThumpable") and object:getCanBarricade()) then
             if (params.facing == "s" or params.facing == "e") and (not object:getBarricadeOnOppositeSquare() or (object:getBarricadeOnOppositeSquare() and object:getBarricadeOnOppositeSquare():canAddPlank())) then
				 if params.facing == "s" and object:getNorth() then
					 return true
				 end
				 if params.facing == "e" and not object:getNorth() then
					 return true
				 end
             elseif (params.facing == "n" or params.facing == "w") and (not object:getBarricadeOnSameSquare() or (object:getBarricadeOnSameSquare() and object:getBarricadeOnSameSquare():canAddPlank())) then
				 if params.facing == "n" and object:getNorth() then
					 return true
				 end
				 if params.facing == "w" and not object:getNorth() then
					 return true
				 end
             end
         end
 	end

    return false;
end

function BuildRecipeCode.barricade.TimedActionOnIsValid(params)
	-- check barricadeTarget to ensure state has not changed since we started (e.g. a player has opened the door)
	local square = params.square;
	if params.facing == "s" then
		square = getWorld():getCell():getGridSquare(square:getX(), square:getY()+1, square:getZ());
	elseif params.facing == "e" then
		square = getWorld():getCell():getGridSquare(square:getX()+1, square:getY(), square:getZ());
	end
	local objects = square:getObjects();
	for i = 0,objects:size()-1 do
		local object = objects:get(i);
		if (((instanceof(object, "IsoDoor") and not object:IsOpen()) or instanceof(object,"IsoWindow")) and object:isBarricadeAllowed()) or (instanceof(object, "IsoThumpable") and object:getCanBarricade()) then
			return true;
		end
	end

	return false;
end

function BuildRecipeCode.barricade.OnCreate(params)
    local thumpable = params.thumpable;
    local craftRecipeData = params.craftRecipeData;
    local character = params.character;
    local square = thumpable:getSquare();
    local opposite = false;
    if params.facing == "s" then
        opposite = true;
        square = getWorld():getCell():getGridSquare(square:getX(), square:getY()+1, square:getZ());
    elseif params.facing == "e" then
        opposite = true;
        square = getWorld():getCell():getGridSquare(square:getX()+1, square:getY(), square:getZ());
    end
	local objects = square:getObjects();
	local barricade;


	for i=objects:size()-1, 0, -1 do
		local object = objects:get(i);
		if instanceof(object, "IsoDoor") or instanceof(object,"IsoWindow") or (instanceof(object, "IsoThumpable") and (object:isDoor() or object:isWindow())) then
            if opposite and object:getBarricadeOnOppositeSquare() and object:getBarricadeOnOppositeSquare():canAddPlank() then
                barricade = object:getBarricadeOnOppositeSquare();
                local plank = craftRecipeData:getAllRecordedConsumedItems() and (not craftRecipeData:getAllRecordedConsumedItems():isEmpty()) and craftRecipeData:getAllRecordedConsumedItems():get(0);
                if not plank then
                    barricade:addPlank(character);
                else
                    barricade:addPlank(character, plank);
                end
            elseif object:getBarricadeOnSameSquare() and object:getBarricadeOnSameSquare():canAddPlank() then
                barricade = object:getBarricadeOnSameSquare();
                local plank = craftRecipeData:getAllRecordedConsumedItems() and (not craftRecipeData:getAllRecordedConsumedItems():isEmpty()) and craftRecipeData:getAllRecordedConsumedItems():get(0);
                if not plank then
                    barricade:addPlank(character);
                else
                    barricade:addPlank(character, plank);
                end
            else
                local items = craftRecipeData:getAllRecordedConsumedItems();
                if not items or items:isEmpty() then
                    items = ArrayList.new();
                end
                barricade = object:addBarricadesFromCraftRecipe(character, items, craftRecipeData, opposite);
            end
        end
	end
    if thumpable:hasModData() and barricade then
        local modData = thumpable:getModData();
        barricade:setModData(modData);
    end
	thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
end

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

function BuildRecipeCode.canBePlastered.OnCreate(params)
    local thumpable = params.thumpable;
    thumpable:setCanBePlastered(true);
end

function BuildRecipeCode.stairs.OnCreate(params)
    local thumpable = params.thumpable;
	local topNorth = thumpable:getType() == IsoObjectType.stairsTN;
	local topWest = thumpable:getType() == IsoObjectType.stairsTW;
	local middleStair = thumpable:getType() == IsoObjectType.stairsMN or thumpable:getType() == IsoObjectType.stairsMW;

	local x = thumpable:getX();
	local y = thumpable:getY();
	local z = thumpable:getZ();

	local square = thumpable:getSquare();
	local overWater = (square:getFloor() ~= nil) and square:getFloor():getSprite():getProperties():Is(IsoFlagType.water);

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

    --add pillars
    local floating = not square:HasStairsBelow(); --not square:TreatAsSolidFloor()
    if (topNorth or topWest) and (thumpable:getTextureName() and string.contains(thumpable:getTextureName(), "carpentry")) and floating then
        local zI = z - 1;
        local pillarSprite = "carpentry_02_95";
        if topWest then
            pillarSprite = "carpentry_02_94"
        end
        local sq = getCell():getGridSquare(x, y, zI);
        if sq == nil then
			sq = IsoGridSquare.new(getCell(), nil, x, y, zI);
			getCell():ConnectNewSquare(sq, true);
        end
        while zI >= 0 do
            local obj2 = IsoThumpable.new(getCell(), sq, pillarSprite, topNorth, {});
    		sq:AddSpecialObject(obj2);
    		obj2:transmitCompleteItemToServer();
            sq:RecalcAllWithNeighbours(true);

    		if sq:TreatAsSolidFloor() then
                break;
    		end

    		zI = zI - 1;

    		if getCell():getGridSquare(x, y, zI) == nil then
				sq = IsoGridSquare.new(getCell(), nil, x, y, zI);
				getCell():ConnectNewSquare(sq, true);
    		else
				sq = getCell():getGridSquare(x, y, zI);
    		end
        end
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

function BuildRecipeCode.floor.OnCreate(params)
    local thumpable = params.thumpable;
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

function BuildRecipeCode.doorFrame.OnIsValid(params)
	local square = (params.north and params.square:getN()) or (not params.north and params.square:getW());
	if square and square:getModData()["ConnectedToStairs" .. tostring(params.north)] then
		return false
	end

	return true;
end

function BuildRecipeCode.butcheringHook.OnCreate(params)
    local thumpable = params.thumpable;
	local sq = thumpable:getSquare();
	local javaObject = IsoButcherHook.new(sq);
	sq:AddTileObject(javaObject)

	if thumpable:getSquare() ~= nil then
		thumpable:removeFromWorld();
		thumpable:removeFromSquare();
		thumpable:setSquare(nil);
	end

	return { replaceObject = true, object = javaObject };
end

function BuildRecipeCode.chickenHutch.OnCreate(params)
    local thumpable = params.thumpable;
	local sprite = thumpable:getSprite():getName();
	local hutch = nil;
	for i,v in pairs(HutchDefinitions.hutchs) do
		if sprite == v.baseSprite then
			hutch = IsoHutch.new(thumpable:getSquare(), thumpable:getNorth(), sprite, v, nil);
		end
	end

	if thumpable:getSquare() ~= nil then
		thumpable:removeFromWorld();
		thumpable:removeFromSquare();
		thumpable:setSquare(nil);
	end

	return { replaceObject = true, object = hutch };
end

function BuildRecipeCode.feedingTrough.OnCreate(params)
    local thumpable = params.thumpable;
    local sprite = thumpable:getSprite()
	local spriteName = sprite:getName();
	for i,def in pairs(FeedingTroughDef) do
		local isWest = luautils.tableContains(def.spriteW, spriteName)
		local isNorth = luautils.tableContains(def.spriteN, spriteName)
		if isWest or isNorth then
			local spriteGrid = sprite:getSpriteGrid()
			if spriteGrid then
				spriteGridX = spriteGrid:getSpriteGridPosX(sprite)
				spriteGridY = spriteGrid:getSpriteGridPosY(sprite)
				SFeedingTroughSystem.instance:addTrough(thumpable:getSquare(), def, isNorth, spriteGridX, spriteGridY)
			else
				SFeedingTroughSystem.instance:addTrough(thumpable:getSquare(), def, isNorth, -1, -1)
			end
            thumpable:removeFromWorld();
        	thumpable:removeFromSquare();
			thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
		end
	end

	return { objectAlreadyTransmitted = true }
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

function BuildRecipeCode.campfire.OnCreate(params)
    local thumpable = params.thumpable;
	local grid = thumpable:getSquare()
	if not grid then return end
	-- 	if self:getIsoObjectOnSquare(grid) then return nil end

	local luaObject = SCampfireSystem.instance:newLuaObjectOnSquare(grid)
	luaObject:initNew()
	luaObject:addObject()
	luaObject:addContainer()
	--luaObject:getIsoObject():transmitCompleteItemToClients()
	-- 	self:noise("#campfires="..self:getLuaObjectCount())
	luaObject:saveData()
	--return luaObject;
end

function BuildRecipeCode.composter.OnCreate(params)
    local thumpable = params.thumpable;
	local javaObject = IsoCompost.new(getCell(), thumpable:getSquare(), thumpable:getSprite():getName());
	thumpable:getSquare():AddSpecialObject(javaObject)
	javaObject:syncCompost()
	javaObject:setMovedThumpable(true)

	thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
end

function BuildRecipeCode.windowGlass.OnCreate(params)
    local thumpable = params.thumpable;
	local sprite = thumpable:getSprite():getName();

	local window = IsoWindow.new(getCell(), thumpable:getSquare(), thumpable:getSprite(), thumpable:getNorth());
	window:setIsLocked(false);
	thumpable:getSquare():AddSpecialObject(window);

	thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
end

function BuildRecipeCode.woodLampPillar.OnCreate(params)
    local thumpable = params.thumpable;
    local craftRecipeData = params.craftRecipeData;
    local spriteName = thumpable:getSprite():getName();
    local sq = thumpable:getSquare();
    local north = spriteName == "carpentry_02_60"
    local name = "Lamp on Pillar"
    local fuel = "Base.Battery";
    local baseItemType = "Base.HandTorch";
    local radius = 10;
    local baseItem = nil;
    local items = {}
    local table = {}
    if craftRecipeData then
        items = craftRecipeData:getAllInputItems()
        for i = 0,items:size()-1 do
            local item = items:get(i)
            if item and item:getFullType() == baseItemType then baseItem = item end
        end
    end
    if not baseItem then baseItem = instanceItem(baseItemType) end

    -- light stuff
    local offsetX = 0;
    local offsetY = 0;
    local lampOffsetX = 5;
    local lampOffsetY = 5;

    if spriteName == "carpentry_02_62" then
        offsetX = lampOffsetX;
    elseif spriteName == "carpentry_02_61" then
        offsetX = -lampOffsetX;
    elseif spriteName == "carpentry_02_59" then
        offsetY = lampOffsetY;
    elseif spriteName == "carpentry_02_60" then
        offsetY = -lampOffsetY;
    end
    thumpable:createLightSource(radius, offsetX, offsetY, 0, 0, fuel, baseItem, character);
-- 	thumpable:getModData()["need:"..baseItem] = "1"
    sq:AddSpecialObject(thumpable);
	thumpable:transmitCompleteItemToClients()

-- 	local javaObject = IsoThumpable.new(getCell(), thumpable:getSprite(), north, nil);
--     javaObject:createLightSource(radius, offsetX, offsetY, 0, 0, fuel, baseItem, character);
-- --     javaObject:setLifeDelta(0.000009);
-- --     javaObject:getLightSource():insertNewFuel(basItem);
-- 	javaObject:getModData()["need:"..baseItem] = "1"
--     sq:AddSpecialObject(javaObject);
-- 	javaObject:transmitCompleteItemToClients()

-- 	thumpable:getSquare():transmitRemoveItemFromSquare(thumpable);
end