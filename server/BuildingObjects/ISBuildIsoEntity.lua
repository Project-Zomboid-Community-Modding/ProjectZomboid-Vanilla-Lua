--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    To build iso objects via entity script.
    Objects require a EntityScript and SpriteConfig component.
--]]
local table_insert = table.insert;

ISBuildIsoEntity = ISBuildingObject:derive("ISBuildIsoEntity");

function ISBuildIsoEntity:walkTo(x, y, z)
	local playerObj = self.character
	local square = getCell():getGridSquare(x, y, z)

	-- find all tiles the constructed entity will use, so we can avoid standing on them
	local excludeTiles = self:getOccupiedTiles(square)

	-- We should path to the bottom end of stairs, not the top end
    local name = self.objectInfo:getScript():getName();

    if luautils.stringEnds(name, "Stairs") and self.north then
            print("ISBuildingObject -> walkTo stairs")
            square = getCell():getGridSquare(x+2, y, z)
    elseif luautils.stringEnds(name, "Stairs") then
            square = getCell():getGridSquare(x, y+2, z)
    end

	if self.isWallLike then
		return luautils.walkAdjWall(playerObj, square, self.north)
	else
		return luautils.walkAdj(playerObj, square, false, excludeTiles)
	end

	--local square2 = self:getSquare2(square, self.north)
	--if square2 == nil or square:DistToProper(playerObj) < square2:DistToProper(playerObj) then
	--	return luautils.walkAdj(playerObj, square)
	--end
	--return luautils.walkAdj(playerObj, square2)
end

function ISBuildIsoEntity:removeFromGround(square)
	--[[
	for i = 0, square:getSpecialObjects():size()-1 do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
			break
		end
	end

	local xa = square:getX();
	local ya = square:getY();

	if self:getNorth() then
		ya = ya - 1;
	else
		xa = xa - 1;
	end

	square = getCell():getGridSquare(xa, ya, square:getZ());
	for i = 0, square:getSpecialObjects():size()-1 do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
			break
		end
	end
	--]]
end

-- return the health of the new furniture, it reads base health and skill-based bonus health from the entity's script
-- skill-based bonus health then needs to be multiplied by the character's relevant skill level
function ISBuildIsoEntity:getHealth()
	if self.objectInfo:getScript():getHealth() ~= -1 then
		return self.objectInfo:getScript():getHealth();
	end

	return self.objectInfo:getScript():getSkillBaseHealth() + buildUtil.getWoodHealth(self);
end

function ISBuildIsoEntity:render(x, y, z, square)
	local valid = self:isValid(square);

	local face = self:getFace();
	if not face then
		self.tileSprite:RenderGhostTileRed(x, y, z);
		return;
	end
	for zz=0,face:getzLayers()-1 do
		for xx=0,face:getWidth()-1 do
			for yy=0,face:getHeight()-1 do
				local tileInfo = face:getTileInfo(xx,yy,zz);
				if tileInfo and (tileInfo:getSpriteName() or tileInfo:isBlocking()) then
					--if true then return; end
					-- set the isWallLike to walkAdjWall or simple walkAdj
					if not self.tileCheck or self.tileCheck ~= getSprite(tileInfo:getSpriteName()) then
						self.tileCheck = getSprite(tileInfo:getSpriteName());
						local props = self.tileCheck:getProperties();
						self.isWallLike = props:Is("WallN") or props:Is("WallW") or props:Is("WallNTrans") or props:Is("WallWTrans") or props:Is("WindowN") or props:Is("WindowW") or props:Is("DoorWallN") or props:Is("DoorWallW");
					end
					local sprite = tileInfo:getSpriteName() and self.spriteCache[tileInfo:getSpriteName()] or self.tileSprite;
					if sprite then
						local offsetY = 0
						if self.tileCheck:getProperties():Is("IsStackable") then
							local props = ISMoveableSpriteProps.new(self.tileCheck);
							offsetY = props:getTotalTableHeight(square);
						end
						if valid then
							sprite:RenderGhostTileColor(x+xx, y+yy, z+zz, 0, offsetY * Core.getTileScale(), 1.0, 1.0, 1.0, 0.6);
						else
							sprite:RenderGhostTileColor(x+xx, y+yy, z+zz, 0, offsetY * Core.getTileScale(), 0.65, 0.2, 0.2, 0.6);
						end
					end
				end
			end
		end
	end
end

function ISBuildIsoEntity:isObjectSpriteBlockingWallPlacement(_sprite, _north)
	local sprite = _sprite;
	if sprite then
		if _north then
			if sprite:getProperties():Is(IsoFlagType.collideN) then return true; end;
			if sprite:getProperties():Is(IsoFlagType.WindowN) then return true; end;
			if sprite:getProperties():Is(IsoFlagType.DoorWallN) then return true; end;
			if sprite:getProperties():Is(IsoFlagType.HoppableN) then return true; end;
		else
			if sprite:getProperties():Is(IsoFlagType.collideW) then return true; end;
			if sprite:getProperties():Is(IsoFlagType.WindowW) then return true; end;
			if sprite:getProperties():Is(IsoFlagType.DoorWallW) then return true; end;
			if sprite:getProperties():Is(IsoFlagType.HoppableW) then return true; end;
		end;
	end;
	return false;
end

function ISBuildIsoEntity:isValidPerSquare(square, tileInfo, _requiresFloor, _extendsN, _extendsW)
	local tileInfoSprite = tileInfo:getSpriteName() and getSprite(tileInfo:getSpriteName());
	local tileInfoSpriteProps = tileInfoSprite and tileInfoSprite:getProperties();

	local testCollisions = true;
	local canBuildOverWater = false;

	-- call onTest
	if self.objectInfo:getScript():getOnIsValid() then
		local func = self.objectInfo:getScript():getOnIsValid();
		local params = {square = square, tileInfo = tileInfo, north = self.north, canBuildOverWater = canBuildOverWater, testCollisions = testCollisions}

		if not BaseCraftingLogic.callLuaBool(func, params) then
			return false;
		end

		-- write back parameter overrides
		canBuildOverWater = params.canBuildOverWater;
		testCollisions = params.testCollisions;
	end

	if testCollisions then
		-- check if we are passing through a wall - do not allow
		if _extendsN and ((square:getProperties():Is(IsoFlagType.collideN) or square:getProperties():Is(IsoFlagType.WallN) or square:getProperties():Is(IsoFlagType.WallNW) or square:getProperties():Is(IsoFlagType.WindowN) or square:getProperties():Is(IsoFlagType.DoorWallN) or square:getProperties():Is(IsoFlagType.HoppableN))) then
			return false;
		end
		if _extendsW and ((square:getProperties():Is(IsoFlagType.collideW) or square:getProperties():Is(IsoFlagType.WallW) or square:getProperties():Is(IsoFlagType.WallNW) or square:getProperties():Is(IsoFlagType.WindowW) or square:getProperties():Is(IsoFlagType.DoorWallW) or square:getProperties():Is(IsoFlagType.HoppableW))) then
			return false;
		end

		if square:isVehicleIntersecting() then
			return false
		end

		if not tileInfoSprite or not tileInfoSprite:getType() == IsoObjectType.wall then
			if buildUtil.stairIsBlockingPlacement( square, true ) then
				return false;
			end	-- DO THIS SMARTER
			--    if buildUtil.stairIsBlockingPlacement( square, true, (self.nSprite==4 or self.nSprite==2) ) then return false; end -- SMARTER?

			if _requiresFloor then
				if not square:isFree(true) then
					-- check if we can build over water
					if canBuildOverWater then
						-- look for water tile
						local isWater = square:getFloor():getSprite():getProperties():Is(IsoFlagType.water) or (square:getObjects():size() == 2 and square:getProperties():Is(IsoFlagType.taintedWater));
						if not isWater then
							return false;
						end
					elseif tileInfoSpriteProps and tileInfoSpriteProps:Is("IsStackable") then
						if square:getFloor() == nil then
							return false;
						end
					else
						return false;
					end
				end
			else
				if not square:isFreeOrMidair(true) then
					return false;
				end
			end
		end
	end

	-- Check for PREVIOUS STAGES
	self.previousStageObject = nil;
	if self.previousStages:size()>0 then
		for i = 0, self.previousStages:size()-1 do
			for j = 0, square:getSpecialObjects():size()-1 do
				local stageName = string.lower(self.previousStages:get(i));
				local object = square:getSpecialObjects():get(j);
				local objectName = object:getName();
				if (objectName and stageName == string.lower(objectName)) then
					if instanceof(object, "IsoThumpable") and object:getNorth() == self.north then
						self.previousStageObject = object;
						return true;
					end
				end
			end
		end

		return false; -- previousStages not found
	end

	-- DOOR STUFF
	local isDoor = tileInfoSprite and (tileInfoSprite:getType() == IsoObjectType.doorW or tileInfoSprite:getType() == IsoObjectType.doorN);
	if isDoor then
		local hasFrame = false
		local hasDoor = false
		for i = 0, square:getSpecialObjects():size() - 1 do
			local item = square:getSpecialObjects():get(i);
			if instanceof(item, "IsoThumpable") and item:isDoorFrame() and item:getNorth() == self.north then
				hasFrame = true
			end
			if instanceof(item, "IsoThumpable") and item:isDoor() and item:getNorth() == self.north then
				hasDoor = true
			end
		end

		for i=0,square:getObjects():size()-1 do
			local o = square:getObjects():get(i)
			if instanceof(o, 'IsoObject') then
				if self.north and o:getType() == IsoObjectType.doorFrN then
					hasFrame = true
				end
				if not self.north and o:getType() == IsoObjectType.doorFrW then
					hasFrame = true
				end
				local sprite = o:getSprite()
				if self.north and sprite and sprite:getProperties():Is("DoorWallN") then
					hasFrame = true
				end
				if not self.north and sprite and sprite:getProperties():Is("DoorWallW") then
					hasFrame = true
				end
			end
			if instanceof(o, 'IsoDoor') and o:getNorth() == self.north then
				hasDoor = true
			end
		end

		if not square:hasFloor(self.north) then
			return false;
		end

		if self.dontNeedFrame then
			return not hasDoor;
		else
			return hasFrame and not hasDoor;
		end
	end

	-- WINDOW STUFF
	--local isWindow = tileInfoSprite and (tileInfoSpriteProps:Is("WindowW") or tileInfoSpriteProps:Is("WindowN"));
	if self.needWindowFrame then
		local hasFrame = false
		local hasWindow = false;
		for i = 0, square:getSpecialObjects():size() - 1 do
			local item = square:getSpecialObjects():get(i);
			if instanceof(item, "IsoThumpable") and item:isWindow() and item:getNorth() == self.north then
				hasFrame = true
			end
		end

		for i=0,square:getObjects():size()-1 do
			local o = square:getObjects():get(i)
			if instanceof(o, 'IsoObject') then
				--if self.north and o:getType() == IsoObjectType.doorFrN then
				--	hasFrame = true
				--end
				--if not self.north and o:getType() == IsoObjectType.doorFrW then
				--	hasFrame = true
				--end
				local sprite = o:getSprite()
				if self.north and sprite and sprite:getProperties():Is("WindowN") then
					hasFrame = true
				end
				if not self.north and sprite and sprite:getProperties():Is("WindowW") then
					hasFrame = true
				end
			end
			if instanceof(o, 'IsoWindow') and o:getNorth() == self.north then
				hasWindow = true
			end
		end

		return hasFrame and not hasWindow;
	end

	-- CHECK SOLID, can never place a solid on a solid
	if tileInfoSpriteProps and (square and square:getProperties() and square:getProperties():Is("BlocksPlacement") or square:isSolid() or square:isSolidTrans()) and (tileInfoSpriteProps:Is(IsoFlagType.solidtrans) or tileInfoSpriteProps:Is("BlocksPlacement")) then
		if tileInfoSpriteProps:Is("IsStackable") then
			local props = ISMoveableSpriteProps.new(tileInfoSprite)
			return props:canPlaceMoveable("bogus", square, nil)
		end
		return false;
	end

	-- AGAINST WALLS (shelves..)
	if self.needToBeAgainstWall then
		local originalSq = square;
		local x = square:getX();
		local y = square:getY();
		local z = square:getZ();
		local face = self:getFace():getFaceName();
		if("n" == face) then
			y = y + 1;
		end
		if("w" == face) then
			x = x + 1;
		end
		square = getSquare(x, y, z);
		for i=0,square:getObjects():size()-1 do
			local obj = square:getObjects():get(i);
			if (self.north and obj:getProperties():Is("WallN")) or (not self.north and obj:getProperties():Is("WallW")) then
				for j=0,originalSq:getSpecialObjects():size() - 1 do
					local sObj = originalSq:getSpecialObjects():get(j);
					--print("got sobj?", sObj, obj)
					if(sObj ~= obj and instanceof(sObj, "IsoThumpable")) then
						return false;
					end
				end
				return true;
			end
		end
		return false;
	end

	-- WALL STUFF - check another objects on the same square - WALLS specific perhaps...
	local isWall = tileInfoSprite and tileInfoSprite:getType() == IsoObjectType.wall;
	if isWall then
		for i=1,square:getObjects():size() do
			local object = square:getObjects():get(i-1);
			local sprite = object:getSprite()
			if sprite then
				if self:isObjectSpriteBlockingWallPlacement(sprite, self.north)	then
					return false;
				end;
				-- Forbid placing walls between parts of multi-tile objects like couches.
				-- TODO: Check for parts being destroyed.
				local spriteGrid = sprite:getSpriteGrid()
				if spriteGrid then
					local gridX = spriteGrid:getSpriteGridPosX(sprite)
					local gridY = spriteGrid:getSpriteGridPosY(sprite)
					if self.north and gridY > 0 then
						return false;
					end
					if not self.north and gridX > 0 then
						return false;
					end
				end
			end
		end

		-- WALL STUFF
		-- if we don't have floor we gonna check if there's a stairs under it, in this case we allow the build
		local hasFloor = square:hasFloor(self.north);
		-- for pole we need to check the tile on northwest (y-1, x-1) and west (x-1)
		if self.isPole then
			local poleSq = getSquare(square:getX()-1, square:getY()-1, square:getZ());
			if not hasFloor and poleSq then
				hasFloor = poleSq:hasFloor();
				if not hasFloor then
					poleSq = getSquare(square:getX()-1, square:getY(), square:getZ());
					if poleSq then
						hasFloor = poleSq:hasFloor();
					end
				end
			end
		end

		if not hasFloor then
			local belowSQ = getCell():getGridSquare(square:getX(), square:getY(), square:getZ()-1)
			if belowSQ then
				if self.north and not belowSQ:HasStairsWest() then return false; end
				if not self.north and not belowSQ:HasStairsNorth() then return false; end
				if not belowSQ:Has(IsoObjectType.wall) then return false; end
			end
		end
	end

	return true;
end

function ISBuildIsoEntity:isValid(square)
	if self.blockBuild then
		return false;
	end

	if not square then
		return false;
	end

	-- don't allow if we don't have materials
	if not self:haveMaterial(square) then return false end

	-- don't allow if someone else's safehouse
	if isClient() and SafeHouse.isSafeHouse(square, getSpecificPlayer(self.player):getUsername(), true) then
		return false;
	end

	local x,y,z = square:getX(), square:getY(), square:getZ();

	local face = self:getFace();
	if not face then
		return false;
	end
	for zz=0,face:getzLayers()-1 do
		for xx=0,face:getWidth()-1 do
			for yy=0,face:getHeight()-1 do
				local tileInfo = face:getTileInfo(xx,yy,zz);
				local sq = getCell():getGridSquare(x+xx, y+yy, z+zz);
				if tileInfo then
					--if tileInfo and (tileInfo:getSpriteName() or tileInfo:isBlocking()) then
					if not sq then
						return false;
					else
						if not self:isValidPerSquare(sq, tileInfo, zz==0, yy>0, xx>0) then
							return false;
						end
					end
				end
			end
		end
	end
	return true;
end

function ISBuildIsoEntity:getOccupiedTiles(square)
	local occupiedTiles = {}
	if square then
		local x,y,z = square:getX(), square:getY(), square:getZ();
		local face = self:getFace();

		if face then
			for zz=0,face:getzLayers()-1 do
				for xx=0,face:getWidth()-1 do
					for yy=0,face:getHeight()-1 do
						local tileInfo = face:getTileInfo(xx,yy,zz);
						local sq = getCell():getGridSquare(x+xx, y+yy, z+zz);
						if tileInfo and (tileInfo:getSpriteName() or tileInfo:isBlocking()) and sq then
							--if sq then
							table_insert(occupiedTiles, sq)
						end
					end
				end
			end
		end
	end
	return occupiedTiles;
end

function ISBuildIsoEntity:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISBuildIsoEntity\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local playerObj = self.character

	local cheat = self.character:isBuildCheat()
	if self.buildPanelLogic and self.buildPanelLogic:isCraftCheat() then
        cheat = true;
    end

	if isServer() then
        self.buildPanelLogic:startCraftAction(nil);
		-- This call is necessary for the server to determine the object's heading direction (e.g., self.north, self.west, etc.)
		-- Otherwise, it may fail the build in self:isValidPerSquare.
		self:getSprite()
    end

	local consumed = false;
	if self.buildPanelLogic then
		if cheat then
			consumed= true;
			self.character:getPlayerCraftHistory():addCraftHistoryCraftedEvent(self.craftRecipe:getName());
		else
			consumed = self.buildPanelLogic:performCurrentRecipe();
		end
	else
		consumed = cheat or ISBuildIsoEntity.ConsumeBuildEntityItems(self.objectInfo, playerObj);
	end

	if not consumed then
		print("ISBuildIsoEntity -> consume failed")
		return;
	end
	print("ISBuildIsoEntity -> consume success")

	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);

	if isServer() then
		-- There may be no square at these coordinates, according to the DoTileBuilding function
		if self.sq == nil and getWorld():isValidSquare(x, y, z) then
			self.sq = cell:createNewGridSquare(x, y, z, true);
		end

		-- Not sure if this can happen here, but it does on the client side in the DoTileBuilding function
		if not self.sq then
			print("ISBuildIsoEntity -> can't create square - fail")
			return;
		end
		self.sq:EnsureSurroundNotNull();
	end

	local face = self:getFace();
	local openFace = self:getOpenFace(north);

	if not self:isValid(self.sq) then
		print("ISBuildIsoEntity -> square invalid - fail")
		return false;
	end

	if openFace and (openFace:getWidth() ~= face:getWidth() or openFace:getHeight() ~= face:getHeight()) then
		print("ISBuildIsoEntity -> openFace different size to closedFace - discarding")
		-- note: this is normal for doubleDoors and garageDoors - these openFaces are determined by tile offset elsewhere - spurcival
		openFace = nil;
	end

	self:updateModData()

	for zz=0,face:getzLayers()-1 do
		for xx=0,face:getWidth()-1 do
			for yy=0,face:getHeight()-1 do
				local tileInfo = face:getTileInfo(xx,yy,zz);
				local openTileInfo = openFace and openFace:getTileInfo(xx, yy, zz);
				local sq = getCell():getGridSquare(x+xx, y+yy, z+zz);
				if tileInfo and tileInfo:getSpriteName() then
					local sprite = tileInfo:getSpriteName();
					local openSprite = openTileInfo and openTileInfo:getSpriteName() or false;
					self:setInfo(sq, north, sprite, openSprite)
				end
			end
		end
	end

	print("ISBuildIsoEntity -> create success")
end

function ISBuildIsoEntity:setInfo(square, north, sprite, openSprite)

	if self.objectInfo:getScript():isProp() then
		local props = ISMoveableSpriteProps.new(IsoObject.new(square, sprite):getSprite())
		props.rawWeight = 10
		props:placeMoveableInternal(square, instanceItem("Base.Plank"), sprite)
		return;
	end

	-- get correct thumpable
	local thumpable;
	if openSprite then
		thumpable = IsoThumpable.new(getCell(), square, sprite, openSprite, north, self);
	else
		thumpable = IsoThumpable.new(getCell(), square, sprite, north, self);
	end

	-- set property flags
	local spriteType = thumpable:getType();
	local thumpableProps = thumpable:getProperties();
	self.blockAllTheSquare = thumpableProps and thumpableProps:Is("BlocksPlacement"); -- need to consider prop IsHigh and IsLow here
	self.canPassThrough = thumpableProps and not (thumpableProps:Is(IsoFlagType.solid) or thumpableProps:Is(IsoFlagType.solidtrans) or
		thumpableProps:Is(IsoFlagType.doorN) or thumpableProps:Is(IsoFlagType.doorW) or
		thumpableProps:Is(IsoFlagType.WallN) or thumpableProps:Is(IsoFlagType.WallNTrans) or thumpableProps:Is(IsoFlagType.WallW) or
		thumpableProps:Is(IsoFlagType.WallWTrans) or thumpableProps:Is(IsoFlagType.WallNW));
	self.hoppable = thumpableProps and (thumpableProps:Is(IsoFlagType.HoppableN) or thumpableProps:Is(IsoFlagType.HoppableW) or thumpableProps:Is(IsoFlagType.TallHoppableN) or thumpableProps:Is(IsoFlagType.TallHoppableW));
	self.isStairs = spriteType and (spriteType == IsoObjectType.stairsTW or spriteType == IsoObjectType.stairsTN or spriteType == IsoObjectType.stairsMW or spriteType == IsoObjectType.stairsMN or spriteType == IsoObjectType.stairsBW or spriteType == IsoObjectType.stairsBN);
	self.isDoorFrame = spriteType and (spriteType == IsoObjectType.doorFrN or spriteType == IsoObjectType.doorFrW);
	self.isDoor = spriteType and (spriteType == IsoObjectType.doorN or spriteType == IsoObjectType.doorW);
	self.isFloor = thumpableProps and thumpableProps:Is(IsoFlagType.solidfloor);
	if self.isDoor then	-- set thumpDmg override for doors
		self.thumpDmg = 5;
	end
	self.canBarricade = ((spriteType and (spriteType == IsoObjectType.doorN or spriteType == IsoObjectType.doorW)) or (thumpableProps and (thumpableProps:Is(IsoFlagType.WindowN) or thumpableProps:Is(IsoFlagType.WindowW) or thumpableProps:Is(IsoFlagType.windowN) or thumpableProps:Is(IsoFlagType.windowW))))
			and thumpableProps and not (thumpableProps:Is("DoubleDoor") or thumpableProps:Is("GarageDoor"));

	buildUtil.setInfo(thumpable, self);

	if self.isDoor and self.modData["keyId"] ~= nil then
		thumpable:setKeyId(self.modData["keyId"])
	end

	local playerObj
	if isServer() then
		playerObj = self.character
	else
		playerObj = getSpecificPlayer(self.player)
	end
	local craftRecipe = self.objectInfo:getRecipe():getCraftRecipe()
	local perk = craftRecipe:getHighestRelevantSkill(playerObj)
	local perkLevel = playerObj:getPerkLevel(perk)

	-- Use at least the minimum required perk level in cheat mode, to avoid zero-health thumpables.
	if playerObj:isBuildCheat() then
		for i=1,craftRecipe:getRequiredSkillCount() do
			local requiredSkill = craftRecipe:getRequiredSkill(i-1)
			if (requiredSkill:getPerk() ~= nil) and (requiredSkill:getLevel() > perkLevel) then
				perkLevel = requiredSkill:getLevel()
			end
		end
	end

	local bonusHealth = self.objectInfo:getScript():getBonusHealth();
	local skillBonus = craftRecipe:getHighestRelevantSkillLevel(playerObj) * self.objectInfo:getScript():getSkillBaseHealth();
	local baseHealth = math.max(self.objectInfo:getScript():getHealth(), 0);
	-- MULTIPLY BONUS HEALTH
	local bonusHealthMultiplier = getSandboxOptions():getOptionByName("ConstructionBonusPoints"):getValue()
	if bonusHealthMultiplier == 1 then bonusHealth = bonusHealth * 0.5; end
	if bonusHealthMultiplier == 2 then bonusHealth = bonusHealth * 0.7; end
	if bonusHealthMultiplier == 4 then bonusHealth = bonusHealth * 1.3; end
	if bonusHealthMultiplier == 5 then bonusHealth = bonusHealth * 1.5; end
	local totalHealth = baseHealth + bonusHealth + skillBonus;
	thumpable:setMaxHealth(totalHealth);
	thumpable:setHealth(thumpable:getMaxHealth())

	thumpable:setBreakSound(self.objectInfo:getScript():getBreakSound());

	if thumpableProps and thumpableProps:Is("IsStackable") then
		local props = ISMoveableSpriteProps.new(thumpable:getSprite())
		local offsetY = props:getTotalTableHeight(square)
		thumpable:setRenderYOffset(offsetY)
	end

	if self.objectInfo:getScript() and self.objectInfo:getScript():getParent() then
		local gameEntityScript = self.objectInfo:getScript():getParent();
		local isFirstTimeCreated = true;
		GameEntityFactory.CreateIsoObjectEntity(thumpable, gameEntityScript, isFirstTimeCreated);
		--gameEntityScript:InstanceComponents(thumpable);
	else
		print("ISBuildIsoEntity -> Cannot instance components, script missing.")
	end

	local replacedObjectIndex = -1;
	if self.previousStageObject and self.previousStageObject:getSquare() == square then
		replacedObjectIndex = self.previousStageObject:getSquare():transmitRemoveItemFromSquare(self.previousStageObject);
		self.previousStageObject = nil;
	end

	-- lightsource properties
	if self.objectInfo:getScript():getLightRadius() then
		local script = self.objectInfo:getScript();

		-- get our FaceScript (not FaceInfo!)
		local index = self.nSprite; -- W and E
		if index == 2 then index = 0 end -- N
		if index == 4 then index = 2 end -- S
		local face = script:getFace(index);
		-- to build a lamp on pillar for ex. we need to check the torch used to add it's battery remaining values in the thumpable, we need to find what items has been used for it
		local consumedItems = self.buildPanelLogic:getAllConsumedItems();
		local torchUsed = nil;
		if consumedItems then
			for i=0, consumedItems:size() -1 do
				-- we can either have a full type (Base.Torch) or a list of tags
				local item = consumedItems:get(i);
				if script:getLightsourceItem() and item:getFullType() == script:getLightsourceItem() then
					torchUsed = item;
					break;
				end
				if script:getLightsourceTagItem() then
					for j=0, script:getLightsourceTagItem():size()-1 do
						local tag = script:getLightsourceTagItem():get(j);
						if item:getTags():contains(tag) then
							torchUsed = item;
							break;
						end
					end
				end
			end
		end

		if not torchUsed and self.character:isBuildCheat() and self.objectInfo:getScript():getDebugItem() then
			torchUsed = instanceItem(self.objectInfo:getScript():getDebugItem());
		end

		if torchUsed then
			thumpable:createLightSource(script:getLightRadius(), face:getLightsourceOffsetX(), face:getLightsourceOffsetY(), face:getLightsourceOffsetZ(), 0, script:getLightsourceFuel(), torchUsed, playerObj)
		end
	end

	square:AddSpecialObject(thumpable, replacedObjectIndex);
	buildUtil.checkCorner(square:getX(), square:getY(), square:getZ(), north, thumpable, self);

	-- This is so any containers that are in a tile are flagged as "already explored" so they don't spawn loot in them
	thumpable:setExplored(true)

	local result = nil;
	if self.objectInfo:getScript():getOnCreate() then
		local func = self.objectInfo:getScript():getOnCreate();
		result = BaseCraftingLogic.callLuaObject(func, thumpable);
	end

	square:RecalcAllWithNeighbours(true);
	if result ~= nil then
		-- object transmitted somewhere in OnCreate function, don't send again
		-- can be used when you have to transmit not just one object
		if result.objectAlreadyTransmitted then
			return;
		end

		-- transmitted object is not just isoThumpable,
		-- replace it to make sure client will get correct instance of the object
		if (result.replaceObject and result.object ~= nil) then
			result.object:transmitCompleteItemToClients();
		end
		return;
	end

	thumpable:transmitCompleteItemToClients();
end

function ISBuildIsoEntity:rotateKey(key)
	if getCore():isKey("Rotate building", key) then
		--todo
		self.nSprite = self.nSprite + 1;
		if self.nSprite > 4 then
			self.nSprite = 1;
		end
	end
end

function ISBuildIsoEntity:getFace()
	if self.nSprite~=self.nSpriteCache then
		-- find nearest valid face to self.nSprite
		local face;
		for i=0,3 do
			-- convert index from nSprite space to objectInfo space
			-- WNES 1 based to NWSE zero based
			local index = self.nSprite; -- W and E
			if index == 2 then index = 0 end -- N
			if index == 4 then index = 2 end -- S

			face = self.objectInfo:getFace(index);
			if face then
				-- we are good
				break;
			end

			-- no good, increment rotations
			self.nSprite = self.nSprite + 1;
			if self.nSprite > 4 then
				self.nSprite = 1;
			end
		end

		-- recache if needed
		if face~=self.face then
			self:cacheSprites(face);
		end

		self.face = face;
		self.nSpriteCache = self.nSprite;
	end

	return self.face;
end

function ISBuildIsoEntity:getOpenFace(_north)
	local face;

	if _north then
		face = self.objectInfo:getFace("n_open")
	else
		face = self.objectInfo:getFace("w_open")
	end

	return face;
end

function ISBuildIsoEntity:cacheSprites(_face)
	if _face then
		local face = _face;
		for z=0,face:getzLayers()-1 do
			for x=0,face:getWidth()-1 do
				for y=0,face:getHeight()-1 do
					local tileInfo = face:getTileInfo(x,y,z);
					if tileInfo and tileInfo:getSpriteName() then
						local sprite = IsoSprite.new();
						sprite:LoadSingleTexture(tileInfo:getSpriteName());
						self.spriteCache[tileInfo:getSpriteName()] = sprite;
						--todo is sprite not found add the ??? sprite?
					end
				end
			end
		end
	end
end

-- Called in ISBuildAction:start().
-- Override this to call setOverrideHandModels() and/or player:SetVariable().
function ISBuildIsoEntity:onTimedActionStart(action)
	-- set Anims
	local actionScript = self.craftRecipe and self.craftRecipe:getTimedActionScript() or false;
	if actionScript then
		action:setActionAnim(actionScript:getActionAnim());
		if actionScript:getAnimVarKey() then
			action:setAnimVariable(actionScript:getAnimVarKey(), actionScript:getAnimVarVal());
		end
	end

	-- equip tools
	action:setOverrideHandModels(self.buildPanelLogic:getModelHandOne(), self.buildPanelLogic:getModelHandTwo());
end

--************************************************************************--
--** ISBuildIsoEntity:new
--************************************************************************--
-- We need to send the nSprite to the server side.
function ISBuildIsoEntity:new(character, objectInfo, nSprite, containers, logic)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	--o:setSprite(sprite1);
	--o:setNorthSprite(northSprite1);
	--o.sprite2 = sprite2;
	--o.northSprite2 = northSprite2;
	o.character = character;
	o.nSprite = nSprite;
	o.nSpriteCache = -1;
	o.containers = containers;
	o.name = objectInfo:getName();
	o.objectInfo = objectInfo;
	o.craftRecipe = objectInfo:getRecipe() and objectInfo:getRecipe():getCraftRecipe() or false;

	if isServer() or isClient() then
		o.buildPanelLogic = BuildLogic.new(character, nil, nil);
		o.buildPanelLogic:setContainers(o.containers);
	else
		o.buildPanelLogic = logic;
	end

	o.buildPanelLogic:setRecipe(o.craftRecipe)

	o.isThumpable = objectInfo:getScript():getIsThumpable() or false;
	o.dontNeedFrame = objectInfo:getScript():getDontNeedFrame() or false;
	o.needWindowFrame = objectInfo:getScript():getNeedWindowFrame() or false;
	o.needToBeAgainstWall = objectInfo:getScript():getNeedToBeAgainstWall() or false;
	o.isPole = objectInfo:getScript():isPole() or false;

	o.previousStages = objectInfo:getScript():getPreviousStages();
	o.bonusHealth = objectInfo:getScript():getBonusHealth();

	--todo check which can be removed:
	o.dismantable = true;
	o.canBeAlwaysPlaced = true;
	o.buildLow = true;
	--todo

	o.spriteCache = {};
	o.tileSprite = self:getFloorCursorSprite();
	o.dragNilAfterPlace = true;
	o.blockAfterPlace = false;
	o.corner = objectInfo:getScript() and objectInfo:getScript():getCornerSprite() or nil;

	o.noNeedHammer = true;
	if o.craftRecipe then
		-- set general
		o.maxTime = o.craftRecipe:getTime();

		-- override sprites
		--local mainSprite = objectInfo:getFace("w") or objectInfo:getFace("single");
		--o:setSprite(mainSprite and mainSprite:getMasterTileInfo():getSpriteName() or nil);
		--o:setNorthSprite(objectInfo:getFace("n") and objectInfo:getFace("n"):getMasterTileInfo():getSpriteName() or nil);
		--o:setEastSprite(objectInfo:getFace("e") and objectInfo:getFace("e"):getMasterTileInfo():getSpriteName() or nil);
		--o:setSouthSprite(objectInfo:getFace("s") and objectInfo:getFace("s"):getMasterTileInfo():getSpriteName() or nil);

		-- set tools/props
		if o.craftRecipe:getToolLeft() and o.craftRecipe:getToolLeft():canUseItem("Base.Hammer")  then
			o.noNeedHammer = false;
		end
		if o.craftRecipe:getToolRight() and o.craftRecipe:getToolRight():canUseItem("Base.Hammer")  then
			o.noNeedHammer = false;
		end

		-- set sounds
		local actionScript = o.craftRecipe and o.craftRecipe:getTimedActionScript() or false;
		if actionScript then
			if actionScript:getSound() then
				o.craftingBank = actionScript:getSound();
			end
			if actionScript:getCompletionSound() then
				o.completionSound = actionScript:getCompletionSound();
			end
		end
	end

	o.canBeLockedByPadlock = objectInfo:getScript():getCanBePadlocked();

	o.blockBuild = false;
    showDebugInfoInChat("Cursor New \'ISBuildIsoEntity\'")
	return o;
end

--************************************************************************--
--** ISBuildIsoEntity Static
--************************************************************************--

function ISBuildIsoEntity.GetAllBuildableEntities()
	local resultObjectInfos = {};
	local infos = SpriteConfigManager.GetObjectInfoList();
	for i=0,infos:size()-1 do
		local info = infos:get(i);
		if info:getScript() and info:getRecipe() then
			table.insert(resultObjectInfos, info);
		end
	end
	return resultObjectInfos;
end

local function consumeItems(_player, _inventory, _isUses, _consumeCount, _items)
	if _consumeCount <= 0 then
		return 0;
	end

	for i=1,#_items do
		local item = _items[i];
		if _inventory then
			_player:removeFromHands(item)
			if not _isUses then
				if item:getContainer() then
					item:getContainer():Remove(item);
				else
					_inventory:Remove(item)
				end
				_consumeCount = _consumeCount - 1;
			end
		else
			local worldObj = item:getWorldItem();
			if not _isUses then
				worldObj:getSquare():transmitRemoveItemFromSquare(worldObj);
				_consumeCount = _consumeCount - 1;
			end
		end

		if _isUses and item and item:getCurrentUses() > 0 then
			_consumeCount = _consumeCount - buildUtil.useDrainable(item, _consumeCount)
		end

		if _consumeCount<=0 then
			break;
		end
	end
	return _consumeCount;
end

local function parseObjectInfo(_player, _info, _inventory, _items, _outCanBuildList, _consume)
	if _info:getScript() and _info:getRecipe() then
		print("parse!", _info, _info:getScript());
		local constructItems = _info:getRecipe():getCraftRecipe():getInputs(); -- ArrayList<InputScript>

		local canBuild = true;

		for k=0,constructItems:size()-1 do
			local constructItem = constructItems:get(k);	--InputScript
			print("construct item!", constructItem:getOriginalLine()," ",k,"/",constructItems:size())
			local entryItems = constructItem:getPossibleInputItems();
			local testUses = not constructItem:isItemCount();
			local count = 1;
			if testUses then
				count = constructItem:getAmount();
			else
				count = constructItem:getIntAmount();
			end

			local consumeCount = constructItem:isKeep() and 0 or count;	-- number of items to consume

			-- For tools only inventory items are checked (invCount and invUses)
			local isTool = constructItem:isTool();

			for m=0, entryItems:size()-1 do
				local itemType = entryItems:get(m):getFullName();

				if (not _items[itemType]) or (not _items[itemType].hasTestedInventory) then
					if not _items[itemType] then
						_items[itemType] = {
							count = 0,
							uses = 0,
							invCount = 0,
							invUses = 0,
							items = {},
							invItems = {},
						};
					end
					_items[itemType].hasTestedInventory = true;
					local result = _inventory:getAllTypeEvalRecurse(itemType, ISBuildIsoEntity.predicateMaterial);

					_items[itemType].count = _items[itemType].count + result:size();	-- total count incl floor
					_items[itemType].invCount = _items[itemType].invCount + result:size();	-- total count in inv only
					for index=0,result:size()-1 do
						local test = result:get(index);
						if test and instanceof(test, "DrainableComboItem") and test:getCurrentUses() > 0 then
							-- 						    print("Result " .. tostring (result))
							_items[itemType].uses = _items[itemType].uses + test:getCurrentUses();
							_items[itemType].invUses = _items[itemType].invUses + test:getCurrentUses();
							-- 							_items[itemType].uses = _items[itemType].uses + result:getCurrentUses();
							-- 							_items[itemType].invUses = _items[itemType].invUses + result:getCurrentUses();
						end
						table_insert(_items[itemType].invItems, test);
					end
				end

				if _items[itemType] then
					if testUses then
						count = count - (isTool and _items[itemType].invUses or _items[itemType].uses);
					else
						count = count - (isTool and _items[itemType].invCount or _items[itemType].count);
					end
				end

				--print("ISBuildIsoEntity -> consume test ", itemType, consumeCount, _consume)
				if consumeCount>0 and _consume then
					local t = _items[itemType];
					consumeCount = consumeItems(_player, _inventory, testUses, consumeCount, t.invItems);	-- _consume inventory
					consumeCount = consumeItems(_player, nil, testUses, consumeCount, t.items);	-- _consume world items
				end
			end

			-- check if we could not find any
			if count > 0 then
				canBuild = false;
			end
		end

		if canBuild and _outCanBuildList then
			table.insert(_outCanBuildList, _info);
		end

		return canBuild;
	end
	return false;
end

--function ISBuildIsoEntity.GetBuildableEntityItems(_info, _player)
--	local items = ISBuildIsoEntity.GetAllGroundItemsForPlayer(_player);
--
--	local inventory = _player:getInventory();
--	parseObjectInfo(_player, _info, inventory, items, nil);
--	return items;
--end

function ISBuildIsoEntity.GetBuildableEntities(_player)	-- only used by right click build menu
	local items = ISBuildIsoEntity.GetAllGroundItemsForPlayer(_player);

	local inventory = _player:getInventory();

	local resultObjectInfos = {};
	local infos = SpriteConfigManager.GetObjectInfoList();
	for i=0,infos:size()-1 do
		local info = infos:get(i);

		parseObjectInfo(_player, info, inventory, items, resultObjectInfos);
	end
	return resultObjectInfos, items;
end

function ISBuildIsoEntity.ConsumeBuildEntityItems(_info, _player) -- used by create() - replace with unified path
	local items = ISBuildIsoEntity.GetAllGroundItemsForPlayer(_player);

	local inventory = _player:getInventory();
	local canBuild = parseObjectInfo(_player, _info, inventory, items, nil);

	if canBuild then
		--print("ISBuildIsoEntity -> consume test success, consuming for real")
		parseObjectInfo(_player, _info, inventory, items, nil, true);
		return true;
	end
	--print("ISBuildIsoEntity -> consume test failed")
	return false;
end

function ISBuildIsoEntity.predicateMaterial(item)
	return not instanceof(item, "InventoryContainer") or item:getInventory():getItems():isEmpty()
end

function ISBuildIsoEntity.GetAllGroundItemsForPlayer(_player)
	local result = {}
	local currentSquare = _player:getCurrentSquare();
	if not currentSquare then
		return result
	end
	for x=currentSquare:getX()-1,currentSquare:getX()+1 do
		for y=currentSquare:getY()-1,currentSquare:getY()+1 do
			local square = getCell():getGridSquare(x,y,currentSquare:getZ())
			local worldObjects = square and square:getWorldObjects() or nil
			if worldObjects ~= nil then
				for i = 0,worldObjects:size()-1 do
					local obj = worldObjects:get(i)
					local item = obj:getItem()
					if ISBuildIsoEntity.predicateMaterial(item) then
						local t = result[item:getFullType()] or {
							count = 0,
							uses = 0,
							invCount = 0,
							invUses = 0,
							items = {},
							invItems = {},
						};
						t.count = t.count + 1;
						if instanceof(item, "DrainableComboItem") and item:getCurrentUses() > 0 then
							t.uses = t.uses + item:getCurrentUses();
						end
						table_insert(t.items, item);
						result[item:getFullType()] = t;
					end
				end
			end
		end
	end
	return result
end
