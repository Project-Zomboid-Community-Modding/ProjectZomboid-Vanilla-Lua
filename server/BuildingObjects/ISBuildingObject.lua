--***********************************************************
--**                    ROBERT JOHNSON                     **
--** Class wich help you to drag an item over the world, it display a ghost render of the item
--** You can either press R or let the left mouse btn down and drag the mouse around to rotate the item                     **
--***********************************************************


require "ISBaseObject"

ISBuildingObject = ISBaseObject:derive("ISBuildingObject");

local function predicateNotBroken(item)
	return not item:isBroken()
end

--************************************************************************--
--** ISBuildingObject:initialise
--**
--************************************************************************--
function ISBuildingObject:initialise()

end

--************************************************************************--
--** ISBuildingObject:new
--**
--************************************************************************--
--~ function ISBuildingObject:derive (type)
--~     local o = {}
--~     setmetatable(o, self)
--~     self.__index = self
--~ 	o.Type= type;
--~     return o
--~ end

function ISBuildingObject:setCanPassThrough(passThrough)
	self.canPassThrough = passThrough;
end

function ISBuildingObject:setNorthSprite(sprite)
	self.northSprite = sprite;
end

function ISBuildingObject:setEastSprite(sprite)
	self.eastSprite = sprite;
end

function ISBuildingObject:setSouthSprite(sprite)
	self.southSprite = sprite;
end

function ISBuildingObject:setSprite(sprite)
	self.sprite = sprite;
	self.chosenSprite = sprite;
end

function ISBuildingObject:setDragNilAfterPlace(nilAfter)
	self.dragNilAfterPlace = nilAfter;
end

function ISBuildingObject.onDestroy(thump, player)
    thump:dumpContentsInSquare();
-- 	if thump:getContainer() and thump:getContainer():getItems() then
-- 		local items = thump:getContainer():getItems()
-- 		for i=0,items:size()-1 do
-- 			thump:getSquare():AddWorldInventoryItem(items:get(i), 0.0, 0.0, 0.0)
-- 		end
-- 	end
	if camping.isTentObject(thump) then
		camping.destroyTent(thump)
		return
	end
	for index, value in pairs(thump:getModData()) do
		if luautils.stringStarts(index, "need:") then
			local itemFullType = luautils.split(index, ":")[2];
			for i=1,tonumber(value) do
				if ZombRand(2) == 0 then
					-- item destroyed
				elseif player then
                    player:getInventory():AddItem(itemFullType);
                else
                    thump:getSquare():AddWorldInventoryItem(itemFullType, 0.0, 0.0, 0.0);
                end
			end
		end
	end
--	ISBuildingObject.removeFromGround(thump:getSquare());
	local stairObjects = buildUtil.getStairObjects(thump)
	if #stairObjects > 0 then
		for i=1,#stairObjects do
			stairObjects[i]:getSquare():transmitRemoveItemFromSquare(stairObjects[i])
		end
    else
		thump:getSquare():transmitRemoveItemFromSquare(thump)
	end
end

function ISBuildingObject.removeFromGround(square)
	if square then
		for i = 0, square:getSpecialObjects():size() - 1 do
			local thump = square:getSpecialObjects():get(i);
			if instanceof(thump, "IsoThumpable") then
				square:transmitRemoveItemFromSquare(thump);
				break;
			end
		end
	end
end

local function isMouseOverUI()
	local uis = UIManager.getUI()
	for i=1,uis:size() do
		local ui = uis:get(i-1)
		if ui:isMouseOver() then
			return true
		end
	end
	return false
end

-- render the item on the ground or launch the build
function DoTileBuilding(draggingItem, isRender, x, y, z, square)
	local spriteName = nil;
	if not draggingItem.player then print('ERROR: player not set in DoTileBuilding'); draggingItem.player = 0 end;
	-- if the square is nil we have to create it (for example, the 2nd floor square are nil)
	if square == nil and getWorld():isValidSquare(x, y, z) then
--~ 		print("create new square : " .. x .. " " .. y);
		square = getCell():createNewGridSquare(x, y, z, true);
--~ 		print("square created : " .. newSq:getX() .. " " .. newSq:getY());
	end
--~ 	print("dragging : " .. x .. " " .. y);
--~ 	print("square is : " .. square:getX() .. " " .. square:getY());
	-- get the sprite we have to display
	if draggingItem.player == 0 and wasMouseActiveMoreRecentlyThanJoypad() then
		local mouseOverUI = isMouseOverUI();
		--if Mouse:isLeftDown() then
		if GameKeyboard.isKeyDown("Attack/Click") then
			if not draggingItem.isLeftDown then
				draggingItem.clickedUI = mouseOverUI;
				draggingItem.isLeftDown = true;
			end
			if draggingItem.clickedUI then return end
			draggingItem:rotateMouse(x, y);
		else
			if draggingItem.isLeftDown then
				draggingItem.isLeftDown = false;
				draggingItem.build = draggingItem.canBeBuild and not mouseOverUI and not draggingItem.clickedUI;
				draggingItem.clickedUI = false;
			end
			if mouseOverUI then return end
		end
	end
	spriteName = draggingItem:getSprite();
	-- if we have the left mouse button down, we fix the item to the square we clicked
	-- so while we have the left button down, we can drag the mouse to change the direction of the item (like in the Sims..)
	if (draggingItem.isLeftDown or draggingItem.build) and draggingItem.square then
		square = draggingItem.square;
		x = square:getX();
		y = square:getY();
	else -- else, the square is the one our mouse is on
		draggingItem.square = square;
	end
	-- There may be no square if we are at the edge of the map.
	if not square then
		draggingItem.canBeBuild = false
		return
	end
	-- render our item on the ground, if it can be placed we render it with a bit of red over it
	if isRender then
		-- we first call the isValid function of our item
		draggingItem.canBeBuild = draggingItem:isValid(square, draggingItem.north)

		if not draggingItem.canBeBuild then
			local nSprite = draggingItem.nSprite
			local canBeBuild = false
			for ii = 1, 4 do
				draggingItem.nSprite = ii
				draggingItem:getSprite()
				canBeBuild = draggingItem:isValid(square, draggingItem.north)
				if canBeBuild then
					draggingItem.canBeBuild = true
					break
				end
			end
			if not draggingItem.canBeBuild then
				draggingItem.nSprite = nSprite
			end
		end

		-- we call the render function of our item, because for stairs (for example), we drag only 1 item : the 1st part of the stairs
		-- so in the :render function is ISWoodenStair, we gonna display the 2 other part of the stairs, depending on his direction
		draggingItem:render(x, y, z, square)
	end
	-- finally build our item !
	if draggingItem.canBeBuild and draggingItem.build then
		draggingItem.build = false
		draggingItem:tryBuild(x, y, z)
	end
	if draggingItem.build and not draggingItem.dragNilAfterPlace then
		draggingItem:reinit();
	end
end

function ISBuildingObject:tryBuild(x, y, z)
	local square = getCell():getGridSquare(x, y, z)
	local playerObj = getSpecificPlayer(self.player)
	local playerInv = playerObj:getInventory()
	
	-- create build action, early, so we can call startCraftAction before walkTo
	local buildAction = nil;
	if not self.skipBuildAction then
		-- if you give a custom maxTime, if not it's calculated with the carpentry level
		local maxTime = (200 - (playerObj:getPerkLevel(Perks.Woodwork) * 5))
		if self.maxTime then
			maxTime = self.maxTime
		end
		if playerObj:isTimedActionInstant() then
			maxTime = 1
		end
		
		-- Pass a copy of this object to ISBuildAction to avoid issues with changing this object
		-- before the action completes, such as rotating it with the 'Rotate Building' key.
		local selfCopy = copyTable(self)
		setmetatable(selfCopy, getmetatable(self, true))
		local containers = ISInventoryPaneContextMenu.getContainers(playerObj);
		buildAction = ISBuildAction:new(playerObj, selfCopy, x, y, z, self.north, self:getSprite(), maxTime, containers);
	end
		
	if self.buildPanelLogic then
		buildAction:setOnComplete(self.onActionComplete, self);
		buildAction:setOnCancel(self.onActionComplete, self);
		self.buildPanelLogic:startCraftAction(buildAction);
	end
	
	if ISBuildMenu.cheat or self:walkTo(x, y, z) or ((self.Type == "fishingNet") and (self:isValid(square, true))) then
		if self.dragNilAfterPlace then
			getCell():setDrag(nil, self.player)
		elseif self.blockAfterPlace and not ISBuildMenu.cheat then
			self.blockBuild = true;
		end

		if self.skipBuildAction then
			-- farmingPlot doesn't need another action
			self:create(x, y, z, self.north, self:getSprite());
			self:onActionComplete();
			return nil;
		else
			if not self.noNeedHammer and not ISBuildMenu.cheat then
				local hammer = playerInv:getFirstTagEvalRecurse("Hammer", predicateNotBroken)
				if hammer then
					ISInventoryPaneContextMenu.equipWeapon(hammer, true, false, self.player)
				end
			end
			if self.equipBothHandItem then
				if luautils.haveToBeTransfered(playerObj, self.equipBothHandItem) then
					ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, self.equipBothHandItem, self.equipBothHandItem:getContainer(), playerInv));
				end
				ISInventoryPaneContextMenu.equipWeapon(self.equipBothHandItem, true, true, self.player)
			end
			if not ISBuildMenu.cheat then
				if self.firstItem then
					local item = nil
					if self.firstPredicate then
						item = playerInv:getFirstTypeEvalArgRecurse(self.firstItem, self.firstPredicate, self.firstArg)
						if not item then
							local groundItems = buildUtil.getMaterialOnGround(square)
							for _,item2 in ipairs(groundItems[self.firstItem]) do
								if self.firstPredicate(item2, self.firstArg) then
									item = item2
									break
								end
							end
							local time = ISWorldObjectContextMenu.grabItemTime(playerObj, item:getWorldItem())
							ISTimedActionQueue.add(ISGrabItemAction:new(playerObj, item:getWorldItem(), time))
						end
					else
						item = playerInv:getItemFromType(self.firstItem, true, true)
						if not item then
							local groundItems = buildUtil.getMaterialOnGround(square)
							item = groundItems[self.firstItem][1]
							local time = ISWorldObjectContextMenu.grabItemTime(playerObj, item:getWorldItem())
							ISTimedActionQueue.add(ISGrabItemAction:new(playerObj, item:getWorldItem(), time))
						end
					end
					ISInventoryPaneContextMenu.equipWeapon(item, true, false, self.player)
				end
				if self.secondItem then
					local item = playerInv:getItemFromType(self.secondItem, true, true)
					if instanceof(item, "Clothing") then
						if not item:isEquipped() then
							ISInventoryPaneContextMenu.wearItem(item, self.player)
						end
					else
						ISInventoryPaneContextMenu.equipWeapon(item, false, false, self.player)
					end
				end
			end

			ISTimedActionQueue.add(buildAction)
		end
	else
		print("ISBuildingObject -> tryBuild - cannot walkTo target")
		self:onActionComplete();
		return nil;
	end
	
	return buildAction;
end

function ISBuildingObject:onActionComplete()
	if self.buildPanelLogic ~= nil then
		print("ISBuildingObject -> onActionComplete - refresh BuildPanel")
		self.buildPanelLogic:stopCraftAction();

		-- Additional update to actualize the available items
		if isClient() and ISBuildWindow.instance then
			self.buildPanelLogic:updateFloorContainer();
			ISBuildWindow.instance:updateContainers();
			--self:updateModData();
		end
	end
end

-- Override this to change the position the player walks to.
function ISBuildingObject:walkTo(x, y, z)
	if self.skipWalk2 then
		return true;
	end
	local square = getCell():getGridSquare(x, y, z)
	local playerObj = getSpecificPlayer(self.player)
	if self.isWallLike then
		return luautils.walkAdjWall(playerObj, square, self.north)
	end

	-- We can build wooden floor through window or door
	if self.Type == "ISWoodenFloor" and square and (square:Is(IsoFlagType.collideN) or square:Is(IsoFlagType.collideW)) then
		if luautils.walkAdj(playerObj, square) then return true end
		return luautils.walkAdjWall(playerObj, square, square:Is(IsoFlagType.collideN))
	end
	-- For walls on 2+ floor we can walk to them from both sides
	if self.currentMoveProps then
		return self.currentMoveProps:walkAdj(playerObj, square)
	end

	return luautils.walkAdj(playerObj, square)
end

-- Called in ISBuildAction:start().
-- Override this to call setOverrideHandModels() and/or player:SetVariable().
function ISBuildingObject:onTimedActionStart(action)
	local actionAnim = CharacterActionAnims.Build
	if self.actionAnim then
		actionAnim = self.actionAnim
	elseif self.firstItem == "BlowTorch" then
		actionAnim = "BlowTorch"
		if self.buildLow then
			actionAnim = "BlowTorchFloor"
		end
	else
		if self.buildLow then
			actionAnim = CharacterActionAnims.BuildLow
		end
	end
	action:setActionAnim(actionAnim)

	if action.character:isPrimaryEquipped("Base.BlowTorch") then
		action:setOverrideHandModels(action.character:getPrimaryHandItem(), nil)
	end
end

-- Called in ISBuildAction:stop().
function ISBuildingObject:onTimedActionStop(action)
end


function ISBuildingObject:updateModData()
	local items = self.buildPanelLogic:getRecipeData():getAllRecordedConsumedItems();
	for i=0, items:size()-1 do
		local usedItem = items:get(i)
		local key = "need:" .. usedItem:getFullType()

		if self.modData[key] == nil then
			self.modData[key] = 0
		end
		self.modData[key] = self.modData[key] + 1

		if usedItem:getFullType() == "Base.Doorknob" and usedItem:getKeyId() ~= -1 then
			self.modData["keyId"] = usedItem:getKeyId()
		end
	end
end

function ISBuildingObject:haveMaterial(square)
	local groundItems = buildUtil.getMaterialOnGround(square);
	local groundItemCounts = buildUtil.getMaterialOnGroundCounts(groundItems)
	local groundItemUses = buildUtil.getMaterialOnGroundUses(groundItems)
    local dragItem = self
	local modData = dragItem.modData;
	local playerObj = self.character;
    if playerObj == nil and dragItem ~= nil then
        playerObj = getSpecificPlayer(dragItem.player)
    end
	local playerInv = playerObj:getInventory()

    local cheat = playerObj:isBuildCheat();
    if ISBuildMenu and ISBuildMenu.cheat then
        cheat = true;
    end
    if cheat then
        return true;
    end

	if modData ~= nil then
		for index, value in pairs(modData) do
			if luautils.stringStarts(index, "need:") then
				local itemFullType = luautils.split(index, ":")[2];
				local nbOfItem = playerInv:getCountTypeEvalRecurse(itemFullType, buildUtil.predicateMaterial)
				-- if the build recipe requires nails, check the player's inventory for boxes of nails, and add them to the count
				if itemFullType == "Base.Nails" then
					nbOfItem = nbOfItem + playerInv:getCountTypeEvalRecurse("Base.NailsBox", buildUtil.predicateMaterial)*100;
					if groundItemCounts["Base.NailsBox"] then
						nbOfItem = nbOfItem + groundItemCounts["Base.NailsBox"]*100;
					end
				end
				if groundItemCounts[itemFullType] then
					nbOfItem = nbOfItem + groundItemCounts[itemFullType];
				end
				if nbOfItem < tonumber(value) then
					return false;
				end
			end
			if luautils.stringStarts(index, "use:") then
				local itemFullType = luautils.split(index, ":")[2];
				local nbOfUse = playerInv:getUsesTypeRecurse(itemFullType)
				if groundItemUses[itemFullType] then
					nbOfUse = nbOfUse + groundItemUses[itemFullType];
				end
				if nbOfUse < tonumber(value) then
					return false;
				end
			end
		end
	end
	
	if not self.noNeedHammer and not ISBuildMenu.cheat then
		local hammer = playerInv:getFirstTagEvalRecurse("Hammer", predicateNotBroken);
		if not hammer then
			return false;
		end
	end
	return true;
end

function ISBuildingObject:reinit()
--~ 	ISBuildingObject.nSprite = 1;
	self.isLeftDown = false;
	self.clickedUI = false;
	self.canBeBuild = false;
	self.build = false;
	self.square = nil;
--~ 	ISBuildingObject.north = false;
end

function ISBuildingObject:reset()
--	getCell():setDrag(nil);
	self.northSprite = nil;
	self.sprite = nil;
	self.southSprite = nil;
	self.eastSprite = nil;
	self.nSprite = 1;
	self.isLeftDown = false;
	self.clickedUI = false;
	self.canBeBuild = false;
	self.build = false;
	self.square = nil;
	self.north = false;
	self.south = false;
	self.east = false;
	self.west = false;
	self.chosenSprite = nil;
	self.dragNilAfterPlace = false;
	self.xJoypad = -1;
	self.yJoypad = -1;
	self.zJoypad = -1;
	self.isWallLike = false;
	self.isCorner = false;
	self.completionSound = nil;
end

function ISBuildingObject:init()
	self:reset();
	self.canBeAlwaysPlaced = false;
	self.isContainer = false;
	self.canPassThrough = false;
	self.canBarricade = false;
	self.thumpDmg = 8;
	self.isDoor = false;
	self.isDoorFrame = false;
	self.crossSpeed = 1.0;
	self.blockAllTheSquare = false;
	self.dismantable = false;
	self.canBePlastered = false;
	self.hoppable = false;
    self.isThumpable = true;
    self.isFloor = false;
	self.modData = {};
end

-- get the sprite depending on the position of the mouse and if the player press "r" or not
function ISBuildingObject:getSprite()
	self.north = false;
	self.south = false;
	self.east = false;
	self.west = false;
	self.chosenSprite = self.sprite;
	if self.nSprite == 1 then
		self.west = true;
		self.chosenSprite = self.sprite;
	elseif self.nSprite == 2 then
		self.north = true;
		self.chosenSprite = self.northSprite;
	elseif self.nSprite == 3 then
		if self.eastSprite then
			self.chosenSprite = self.eastSprite;
			self.east = true;
		else
			self.west = true;
			self.chosenSprite = self.sprite;
		end
	elseif self.nSprite == 4 then
		if self.southSprite then
			self.south = true;
			self.chosenSprite = self.southSprite;
		else
			self.north = true;
			self.chosenSprite = self.northSprite;
		end
	end
	return self.chosenSprite;
end

function ISBuildingObject:isValid(square)
    if self.notExterior and not square:Is(IsoFlagType.exterior) then return false end
	if not self:haveMaterial(square) then return false end
	if square:isVehicleIntersecting() then return false end
	if self.canBeAlwaysPlaced then
		-- even if we can place this item everywhere, we can't place 2 same objects on the same tile
		for i=0,square:getObjects():size()-1 do
			local obj = square:getObjects():get(i);
			if self:getSprite() == obj:getTextureName() then
				return false
			end
		end
		return true
	end
	local blockedByCharacters = self.isWallLike ~= true
	return buildUtil.canBePlace(self, square) and square:isFreeOrMidair(blockedByCharacters)
end

function ISBuildingObject:render(x, y, z, square)
	-- ghost sprite is a blueprint of what we're currently building
	if self.ghostSprite then
		self.ghostSprite:RenderGhostTile(self.ghostSpriteX, self.ghostSpriteY, self.ghostSpriteZ);
		return;
	end
	-- optionally draw a floor tile to aid placement (stacked wooden crates for example)
	if self.renderFloorHelper then
		if not self.RENDER_SPRITE_FLOOR then
			self.RENDER_SPRITE_FLOOR = IsoSprite.new()
			self.RENDER_SPRITE_FLOOR:LoadSingleTexture('carpentry_02_56')
		end
		self.RENDER_SPRITE_FLOOR:RenderGhostTile(x, y, z)
	end

	local spriteName = self:getSprite()
	if not self.RENDER_SPRITE then
		self.RENDER_SPRITE = IsoSprite.new()
	end
	if self.RENDER_SPRITE_NAME ~= spriteName then
		self.RENDER_SPRITE:LoadSingleTexture(spriteName)
		self.RENDER_SPRITE_NAME = spriteName
	end

	local sharedSprite = getSprite(self.RENDER_SPRITE_NAME)
	if square and sharedSprite and sharedSprite:getProperties():Is("IsStackable") then
		local props = ISMoveableSpriteProps.new(self.RENDER_SPRITE)
		local offsetY = props:getTotalTableHeight(square)
		local r,g,b,a = 1,1,1,0.6
		if not self:isValid(square) then
			r,g,b,a = 0.65,0.2,0.2,0.6
		end
		self.RENDER_SPRITE:RenderGhostTileColor(x, y, z, 0, offsetY * Core.getTileScale(), r, g, b, a)
		return
	end

	-- if the square is free and our item can be build
	if self:isValid(square) then
		self.RENDER_SPRITE:RenderGhostTile(x, y, z);
	else
		self.RENDER_SPRITE:RenderGhostTileRed(x, y, z);
	end
end

function ISBuildingObject:rotateKey(key)
	if getCore():isKey("Rotate building", key) then
		self.nSprite = self.nSprite + 1;
		if self.nSprite > 4 then
			self.nSprite = 1;
		end
	end
end

local function rotateKey(key)
	if getCell() and getCell():getDrag(0) then
		getCell():getDrag(0):rotateKey(key)
	end
end

-- we gonna rotate our building depending on the position of the mouse
function ISBuildingObject:rotateMouse(x, y)
	if self.square then
		-- we start to get the direction the mouse is compared to the selected square for the item
		local difx = x - self.square:getX();
		local dify = y - self.square:getY();
		-- west
		if difx < 0 and math.abs(difx) > math.abs(dify) then
			self.nSprite = 1;
		end
		-- east
		if difx > 0 and math.abs(difx) > math.abs(dify) then
			self.nSprite = 3;
		end
		-- north
		if dify < 0 and math.abs(difx) < math.abs(dify) then
			self.nSprite = 2;
		end
		-- south
		if dify > 0 and math.abs(difx) < math.abs(dify) then
			self.nSprite = 4;
		end
	end
end

-- Called by Java in IsoCell.setDrag().  Can be overridden to do stuff.
function ISBuildingObject:deactivate()
end

function ISBuildingObject:onJoypadPressButton(joypadIndex, joypadData, button)
    local playerObj = getSpecificPlayer(joypadData.player)
    if button == Joypad.AButton then
        if self.canBeBuild then
            self:tryBuild(self.xJoypad, self.yJoypad, self.zJoypad)
        end
    end

    if button == Joypad.BButton then
        getCell():setDrag(nil, joypadData.player);
    end

    if button == Joypad.YButton then
        if self.isYButtonResetCursor then
            self.xJoypad = self.character:getCurrentSquare():getX()
            self.yJoypad = self.character:getCurrentSquare():getY()
        end
    end

    if button == Joypad.RBumper then
        self.nSprite = self.nSprite + 1;
        if self.nSprite > 4 then
            self.nSprite = 1;
        end
    end

    if button == Joypad.LBumper then
        self.nSprite = self.nSprite - 1;
        if self.nSprite < 1 then
            self.nSprite = 4;
        end
    end
end

function ISBuildingObject:onJoypadDirDown(joypadData)
    self.yJoypad = self.yJoypad + 1;
end

function ISBuildingObject:onJoypadDirUp(joypadData)
    self.yJoypad = self.yJoypad - 1;
end

function ISBuildingObject:onJoypadDirRight(joypadData)
    self.xJoypad = self.xJoypad + 1;
end

function ISBuildingObject:onJoypadDirLeft(joypadData)
    self.xJoypad = self.xJoypad - 1;
end

function ISBuildingObject:getAPrompt()
    if self.canBeBuild then
        return getText("ContextMenu_Build")
    end
    return nil
end

function ISBuildingObject:getBPrompt()
    return getText("UI_Cancel")
end

function ISBuildingObject:getYPrompt()
	if self.isYButtonResetCursor then
		return getText("IGUI_SetCursorToPlayerLocation")
	end
	return nil
end

function ISBuildingObject:getLBPrompt()
    return getText("IGUI_Controller_RotateLeft")
end

function ISBuildingObject:getRBPrompt()
    return getText("IGUI_Controller_RotateRight")
end

function ISBuildingObject:getFloorCursorSprite()
	if not ISBuildingObject.floorCursorSprite then
		local spriteName = (Core.getTileScale() == 2) and 'media/ui/FloorTileCursor2x.png' or 'media/ui/FloorTileCursor.png'
		ISBuildingObject.floorCursorSprite = IsoSprite.new()
		ISBuildingObject.floorCursorSprite:LoadSingleTexture(spriteName)
	end
	return ISBuildingObject.floorCursorSprite
end

function ISBuildingObject:update()

end

-- x,y,z,square are the same arguments passed to render()
function ISBuildingObject:renderOpaqueObjectsInWorld(x, y, z, square)

end

function DoTileBuildingJoyPad(draggingItem, isRender, x, y, z)
    if draggingItem.xJoypad == -1 then
        draggingItem.xJoypad = x;
        draggingItem.yJoypad = y;
--        local buts = getButtonPrompts(playerIndex);
--        if buts ~= nil then
--            buts:getBestLBButtonAction(nil);
--            buts:getBestRBButtonAction(nil);
--        end
    end
    draggingItem.zJoypad = z;
    local square = getCell():getGridSquare(draggingItem.xJoypad, draggingItem.yJoypad, draggingItem.zJoypad);
    DoTileBuilding(draggingItem, isRender, draggingItem.xJoypad, draggingItem.yJoypad, draggingItem.zJoypad, square);
end

local function RenderOpaqueObjectsInWorld(playerIndex, x, y, z, square)
	local bo = getCell():getDrag(playerIndex)
	if bo == nil then return end
	if not bo.renderOpaqueObjectsInWorld then return end
	if JoypadState.players[playerIndex+1] then
		if bo.xJoypad == -1 then
			bo.xJoypad = x
			bo.yJoypad = y
		end
		bo.zJoypad = z
		square = getCell():getGridSquare(bo.xJoypad, bo.yJoypad, bo.zJoypad)
		x,y = bo.xJoypad, bo.yJoypad
	end
	bo:renderOpaqueObjectsInWorld(x, y, z, square)
end

Events.OnDoTileBuilding2.Add(DoTileBuilding);
Events.OnDoTileBuilding3.Add(DoTileBuildingJoyPad);
Events.OnKeyPressed.Add(rotateKey);
Events.OnDestroyIsoThumpable.Add(ISBuildingObject.onDestroy);
Events.RenderOpaqueObjectsInWorld.Add(RenderOpaqueObjectsInWorld);
