--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDestroyStuffAction = ISBaseTimedAction:derive("ISDestroyStuffAction");

local function predicateSledgehammer(item)
	if item:isBroken() then return false end
	local type = item:getType()
	return item:hasTag("Sledgehammer") or type == "Sledgehammer" or type == "Sledgehammer2"
end

function ISDestroyStuffAction:isValid()
	if ISBuildMenu.cheat then return true end
	local sledgehammer = self.character:getInventory():getFirstEvalRecurse(predicateSledgehammer)
	if not sledgehammer then return false end
	--ensure the player hasn't moved too far away while the action was in queue
	local diffX = math.abs(self.item:getSquare():getX() + 0.5 - self.character:getX());
	local diffY = math.abs(self.item:getSquare():getY() + 0.5 - self.character:getY());
	return self.item:getObjectIndex() ~= -1 and (diffX <= 1.6 and diffY <= 1.6);
end

function ISDestroyStuffAction:waitToStart()
	self.character:faceThisObject(self.item)
	return self.character:shouldBeTurning()
end

function ISDestroyStuffAction:update()
	self.character:faceThisObject(self.item);
--	if self.spriteFrame < 5 and self.character:getSpriteDef():getFrame() >= 5 then
--		getSoundManager():PlayWorldSound("breakdoor", false, self.item:getSquare(), 1, 20, 1, false)
--        self.item:getSquare():playSound("HitObjectWithSledgehammer");
--        addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 10)
--	end
	self.spriteFrame = self.character:getSpriteDef():getFrame();
    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISDestroyStuffAction:start()
	if self.item == nil then
		return
	end
	if not self.sledge then
		self.sledge = self.character:getPrimaryHandItem();
	end
	if self.item:getProperties():Is(IsoFlagType.solidfloor) then
		self:setActionAnim("DestroyFloor")
	else
		self:setActionAnim(CharacterActionAnims.Destroy)
	end
--	getSoundManager():PlaySound("breakdoor", false, 1);
	-- add a sound to the list so zombie/npc can hear it
	addSound(self.character, self.character:getX(),self.character:getY(),self.character:getZ(), 20, 10);
end

function ISDestroyStuffAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISDestroyStuffAction:perform()
	if self.item == nil then
		return
	end

	-- we add the items contained inside the item we destroyed to put them randomly on the ground
	for i=1,self.item:getContainerCount() do
		local container = self.item:getContainerByIndex(i-1)
		for j=1,container:getItems():size() do
			self.item:getSquare():AddWorldInventoryItem(container:getItems():get(j-1), 0.0, 0.0, 0.0)
		end
	end

	-- corner walls need special handling, so this sets up ordinary walls to work with that handling to simplify things
	if not self.item:getSquare():getWall(false) == self.item and not self.item:getSquare():getWall(true) == self.item then --no wall
		self.cornerCounter = -1
	elseif self.item:getSquare():getWall(false) == self.item and not self.item:getSquare():getWall(true) == self.item then --west wall only
		self.cornerCounter = 0
	elseif not self.item:getSquare():getWall(false) == self.item and self.item:getSquare():getWall(true) == self.item then --north wall only
		self.cornerCounter = 1
	end

	-- destroy window if wall is destroyed
	if self.cornerCounter == 0 or self.cornerCounter == 1 then
		for i=0,self.item:getSquare():getSpecialObjects():size()-1 do
			local o = self.item:getSquare():getSpecialObjects():get(i)
			if instanceof(o, 'IsoWindow') and (o:getNorth() == (self.cornerCounter == 1)) then
				self.item = o
				break
			end
		end
	end

	-- destroy light switch on same square if wall is destroyed
	if self.cornerCounter == 0 or self.cornerCounter == 1 then
		for i=0,self.item:getSquare():getObjects():size()-1 do
			local o = self.item:getSquare():getObjects():get(i)
			if instanceof(o, 'IsoLightSwitch') then
				if o:getProperties():Is(IsoFlagType.attachedW) and (self.cornerCounter == 1) then
					o:getSquare():transmitRemoveItemFromSquare(o)
					o:getSquare():RemoveTileObject(o)
					break
				end
				if o:getProperties():Is(IsoFlagType.attachedN) and (self.cornerCounter == 0) then
					o:getSquare():transmitRemoveItemFromSquare(o)
					o:getSquare():RemoveTileObject(o)
					break
				end
			end
		end
	end

	-- destroy light switch on adjacent square if wall is destroyed [other side of wall]
	if self.cornerCounter == 0 or self.cornerCounter == 1 then
		local Nsquare,Wsquare
		if self.cornerCounter == 0 then Nsquare = self.item:getSquare():getAdjacentSquare(IsoDirections.N) end
		if self.cornerCounter == 1 then Wsquare = self.item:getSquare():getAdjacentSquare(IsoDirections.W) end
		if Nsquare ~= nil then
			for i=0,Nsquare:getObjects():size()-1 do
				local o = Nsquare:getObjects():get(i)
				if o:getProperties():Is(IsoFlagType.attachedS) then
					o:getSquare():transmitRemoveItemFromSquare(o)
					o:getSquare():RemoveTileObject(o)
					break
				end
			end
		end
		if Wsquare ~= nil then
			for i=0,Wsquare:getObjects():size()-1 do
				local o = Wsquare:getObjects():get(i)
				if o:getProperties():Is(IsoFlagType.attachedE) then
					o:getSquare():transmitRemoveItemFromSquare(o)
					o:getSquare():RemoveTileObject(o)
					break
				end
			end
		end
	end

	-- destroy barricades if door or window is destroyed
	if instanceof(self.item, 'IsoDoor') or (instanceof(self.item, 'IsoThumpable') and self.item:isDoor()) or
			instanceof(self.item, 'IsoWindow') then
		local barricade1 = self.item:getBarricadeOnSameSquare()
		local barricade2 = self.item:getBarricadeOnOppositeSquare()
		if barricade1 then
			barricade1:getSquare():transmitRemoveItemFromSquare(barricade1)
			barricade1:getSquare():RemoveTileObject(barricade1)
		end
		if barricade2 then
			barricade2:getSquare():transmitRemoveItemFromSquare(barricade2)
			barricade2:getSquare():RemoveTileObject(barricade2)
		end
	end

	-- remove curtains if window is destroyed
	if instanceof(self.item, 'IsoWindow') and self.item:HasCurtains() then
		local curtains = self.item:HasCurtains()
		curtains:getSquare():transmitRemoveItemFromSquare(curtains)
		local sheet = InventoryItemFactory.CreateItem("Base.Sheet")
		self.item:getSquare():AddWorldInventoryItem(sheet, 0, 0, 0)
    end
    -- remove sheet rope too
    if instanceof(self.item, 'IsoWindow') or instanceof(self.item, 'IsoThumpable') then
        self.item:removeSheetRope(nil);
    end

	if instanceof(self.item, 'IsoCurtain') and self.item:getSquare() then
		local sheet = InventoryItemFactory.CreateItem("Base.Sheet")
		self.item:getSquare():AddWorldInventoryItem(sheet, 0, 0, 0)
	end
	
	-- toggle off if it was a generator
	if instanceof(self.item, 'IsoGenerator') then
		self.item:setActivated(false);
	end

	local sq = self.item:getSquare()
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(sq)
	if campfire ~= nil then
		if campfire.isLit then
			for i = 0,sq:getObjects():size()-1 do
				local fireObj = sq:getObjects():get(i)
				if instanceof(fireObj, 'IsoFire') and fireObj:isPermanent() then
					square:transmitRemoveItemFromSquare(fireObj)
					square:getProperties():UnSet(IsoFlagType.burning)
				end
			end
		end
	end

	-- Hack, should we do triggerEvent("OnDestroyIsoThumpable") here?
	-- When you destroy with an axe, you get "need:XXX" materials back.
	if isClient() then
		local sq = self.item:getSquare()
		local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ(), index = self.item:getObjectIndex() }
		sendClientCommand(self.character, 'object', 'OnDestroyIsoThumpable', args)
	end

	-- Destroy all 3 stair objects (and sometimes the floor at the top)
	local stairObjects = buildUtil.getStairObjects(self.item)
	-- Destroy all 4 double-door objects
	local doubleDoorObjects = buildUtil.getDoubleDoorObjects(self.item)
	local garageDoorObjects = buildUtil.getGarageDoorObjects(self.item)
	local graveObjects = buildUtil.getGraveObjects(self.item)
	if #stairObjects > 0 then
		for i=1,#stairObjects do
            if isClient() then
                sledgeDestroy(stairObjects[i]);
			else
				stairObjects[i]:getSquare():transmitRemoveItemFromSquare(stairObjects[i])
			end
		end
	elseif #doubleDoorObjects > 0 then
		for i=1,#doubleDoorObjects do
			if isClient() then
				sledgeDestroy(doubleDoorObjects[i]);
			else
				doubleDoorObjects[i]:getSquare():transmitRemoveItemFromSquare(doubleDoorObjects[i])
			end
		end
	elseif #garageDoorObjects > 0 then
		for i=1,#garageDoorObjects do
			local object = garageDoorObjects[i]
			if isClient() then
				sledgeDestroy(object)
			else
				object:getSquare():transmitRemoveItemFromSquare(object)
			end
		end
	elseif #graveObjects > 0 then
		for i=1,#graveObjects do
			if isClient() then
				sledgeDestroy(graveObjects[i]);
			else
				graveObjects[i]:getSquare():transmitRemoveItemFromSquare(graveObjects[i])
			end
		end
    else
		if isClient() then
			sledgeDestroy(self.item);
		else
			if self.item:getSprite():getProperties():Is("CornerNorthWall") then

				local sq = self.item:getSquare()
				local objNew = IsoObject.getNew(sq, self:getCornerWallSprite(self.item:getSprite()), self:getCornerWallSprite(self.item:getSprite()), false);
				objNew:setAttachedAnimSprite(ArrayList:new())
				local index = self.item:getObjectIndex();

				--attached sprites
				if self.item:getAttachedAnimSprite() ~= nil and not self.item:getAttachedAnimSprite():isEmpty() then
					for i=1,self.item:getAttachedAnimSprite():size() do
						local attachedSprite = self:getCornerWallSprite(self.item:getAttachedAnimSprite():get(i-1):getParentSprite())
						if attachedSprite ~= nil then
							objNew:getAttachedAnimSprite():add(getSprite(attachedSprite):newInstance())
						end
					end
				end
				print(objNew)

				sq:transmitRemoveItemFromSquare(self.item);
				sq:transmitAddObjectToSquare(objNew, index);
			else --not a corner wall, just remove it
				self.item:getSquare():transmitRemoveItemFromSquare(self.item)
			end
		end
	end

--~ 	local aboveGrid = getCell():getGridSquare(self.item:getSquare():getX(), self.item:getSquare():getY(), self.item:getSquare():getZ() + 1);
--~ 	if aboveGrid then
--~ 		print("grid exist");
--[[ do this only if the destroyed object was a lower crate;  it doesn't handle carpentry crates
		for i=0, self.item:getSquare():getObjects():size() - 1 do
			local itemAbove = self.item:getSquare():getObjects():get(i);
			if itemAbove:getSprite() then
				if itemAbove:getSprite():getName() == "carpentry_01_17" then
					itemAbove:setSprite(getSprite("carpentry_01_16"));
				end
				if itemAbove:getSprite():getName() == "carpentry_01_18" then
					itemAbove:setSprite(getSprite("carpentry_01_17"));
				end
			end
		end
--]]
--~ 	end

--	getSoundManager():PlaySound("breakdoor", false, 1);
	-- add a sound to the list so zombie/npc can hear it
	addSound(self.character, self.character:getX(),self.character:getY(),self.character:getZ(), 10, 10);
    -- reduce the sledge condition
	if not ISBuildMenu.cheat then
		local sledge = self.character:getPrimaryHandItem();
		if ZombRand(sledge:getConditionLowerChance() * 2) == 0 then
			sledge:setCondition(sledge:getCondition() - 1);
			ISWorldObjectContextMenu.checkWeapon(self.character);
		end
	end
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDestroyStuffAction:getCornerWallSprite(wallSprite)
	if self.cornerCounter == 0 and wallSprite:getProperties():Is("CornerWestWall") then
		return wallSprite:getProperties():Val("CornerWestWall")
	elseif self.cornerCounter == 1 and wallSprite:getProperties():Val("CornerNorthWall") then
		return wallSprite:getProperties():Val("CornerNorthWall")
	end
	return nil
end

function ISDestroyStuffAction:animEvent(event, parameter)
	if event == "PlaySwingSound" then
		local sledge = self.character:getPrimaryHandItem();
		self.character:playSound(sledge:getSwingSound())
	end
	if event == "PlayHitSound" then
		local sledge = self.character:getPrimaryHandItem();
		-- FIXME: Pick an appropriate value for hit surface.
		self.character:setMeleeHitSurface("Default")
		self.character:playSound(sledge:getDoorHitSound())
	end
end

	function ISDestroyStuffAction:new(character, item, cornerCounter)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.item = item;
	o.cornerCounter = -1;
	if cornerCounter ~= nil then
		o.cornerCounter = cornerCounter;
	end
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.maxTime = 300 - (character:getPerkLevel(Perks.Strength) * 10);
	if ISBuildMenu.cheat then o.maxTime = 1 end
    if character:isTimedActionInstant() then
        o.maxTime = 1;
    end
	o.spriteFrame = 0
	o.caloriesModifier = 8;
	return o;
end
