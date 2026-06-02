require "Foraging/forageSystem";
require "ISUI/ISPanel";
ISBaseIcon = ISPanel:derive("ISBaseIcon");

ISBaseIcon.managedMarkers = {
	isoMarker	= "isoMarkers",
	worldMarker	= "worldMarkers",
};

ISBaseIcon.updateEvents = {
	{ method = "updateAlpha",		        tick = 5 },
	{ method = "updateViewDistance",        tick = 5 },
	{ method = "updatePerkLevel",           tick = 20 },
	{ method = "updateModifiers",           tick = 30 },
};

local pinIconBlank      = getTexture("media/textures/Foraging/pinIconBlank.png");
local pinIconUnknown    = getTexture("media/textures/Foraging/pinIconUnknown.png");
local poisonIcon        = getTexture("media/ui/SkullPoison.png");
local math = math;
local getTimestampMs = getTimestampMs;

local function iterList(_list)
	local list = _list;
	local size = list:size() - 1;
	local i = -1;
	return function()
		i = i + 1;
		if i <= size and not list:isEmpty() then
			return list:get(i), i;
		end;
	end;
end

local function clamp(_value, _min, _max)
	if _min > _max then _min, _max = _max, _min; end;
	return math.min(math.max(_value, _min), _max);
end

local function getDistance2D(_x1, _y1, _x2, _y2)
    return math.sqrt(math.abs(_x2 - _x1)^2 + math.abs(_y2 - _y1)^2);
end

function ISBaseIcon:isValid() 				return true; 					end;
function ISBaseIcon:onRightMouseUp() 		return false; 					end;
function ISBaseIcon:onRightMouseDown()		return false;					end;
function ISBaseIcon:doPickup()				return false;					end;
function ISBaseIcon:getAlpha()		 		return self.textureColor.a; 	end;
function ISBaseIcon:getColor()			 	return self.textureColor; 		end;
function ISBaseIcon:setAlpha(_a)			self.textureColor.a = _a;		end;
function ISBaseIcon:setColor(_rgba) 		self.textureColor = _rgba;		end;
function ISBaseIcon:prerender() 											end;
function ISBaseIcon:renderWorldIcon() 										end;
function ISBaseIcon:getGridSquare()			return self:initGridSquare();	end;
function ISBaseIcon:doSearchFocusCheck()									end;

function ISBaseIcon:setIsBeingRemoved(_isBeingRemoved)
	self.isBeingRemoved = _isBeingRemoved;
end;

function ISBaseIcon:getGameSpeed()
	if UIManager and UIManager.getSpeedControls then
		return UIManager.getSpeedControls():getCurrentGameSpeed();
	end;
	return 1;
end

function ISBaseIcon:doGrabSubMenu(_context, _contextOption, _inventory)
	local contextMenu = _context;
	local contextOption = _contextOption;
	local inventory = _inventory;
	if self.itemObjTable then
		local itemTable = {};
		for _, itemObj in pairs(self.itemObjTable) do
			if itemObj and itemObj:getWorldItem() then
				table.insert(itemTable, itemObj);
			end;
		end;
		if #itemTable > 1 then
			contextOption.onSelect = nil
			local subMenuGrab = ISContextMenu:getNew(contextMenu);
			contextMenu:addSubMenu(contextOption, subMenuGrab);
			subMenuGrab:addOption(getText("ContextMenu_Grab_one"), self, self.onClickContext, 0, 0, contextMenu, inventory, {self.itemObj});
			if #itemTable > 2 then
				subMenuGrab:addOption(getText("ContextMenu_Grab_half"), self, self.onClickContext, 0, 0, contextMenu, inventory, {unpack(itemTable, 1, math.ceil(#itemTable / 2))});
			end;
			subMenuGrab:addOption(getText("ContextMenu_Grab_all"), self, self.onClickContext, 0, 0, contextMenu, inventory, itemTable);
		end;
	end;
end

function ISBaseIcon:doContextMenu(_context)
	if self.isTrack then return; end
	if self:getIsSeen() and self:getAlpha() > 0 then
		self:getGridSquare();
		if (not self.square) then return; end;

		local contextMenu = _context;
		if not contextMenu then
			contextMenu = ISContextMenu.get(self.player, getMouseX(), getMouseY());
		end;
		if not contextMenu then return; end;

		local plInventory = self.character:getInventory();
		local plInventoryHasSpace = plInventory:getCapacityWeight() <= plInventory:getEffectiveCapacity(self.character);
		local contextName = getText("IGUI_Pickup").." "..getText("UI_foraging_UnknownItem");

		if self.identified then
			local displayName = self.itemObj:getDisplayName();
			if self.itemList and not self.itemList:isEmpty() then
				if self.itemList:get(0) ~= nil then
					displayName = self.itemList:get(0):getDisplayName();
				end;
			end;
			if not displayName then
				displayName = getText("UI_foraging_UnknownItem");
			end;
			contextName = getText("IGUI_Pickup").." "..displayName;
		end;

		local contextOption = contextMenu:addOption(contextName, self, nil, contextMenu, plInventory);
		local subMenu = ISContextMenu:getNew(contextMenu);
		local bpList = getPlayerInventory(self.player).backpacks;

		local plInvOption = subMenu:addOption(getText("ContextMenu_PutInContainer", getText("ContextMenu_MoveToInventory")), self, self.onClickContext, 0, 0, contextMenu, plInventory, {self.itemObj});
		plInvOption.iconTexture = getTexture("media/ui/Icon_InventoryBasic.png")
		if plInventory:hasRoomFor(self.character, self.itemObj) and plInventoryHasSpace then
			self:doGrabSubMenu(contextMenu, plInvOption, plInventory);
		else
			plInvOption.onSelect = nil;
			plInvOption.notAvailable = true;
		end;

		for _, backpack in ipairs(bpList) do
			local bpItem = backpack and backpack.inventory and backpack.inventory:getContainingItem();
			if bpItem then
				if backpack.inventory:isItemAllowed(self.itemObj) then
					local backPackOption = subMenu:addOption(getText("ContextMenu_PutInContainer", bpItem:getDisplayName()), self, self.onClickContext, 0, 0, contextMenu, backpack.inventory, {self.itemObj});
					backPackOption.itemForTexture = bpItem
					if (not backpack.inventory:hasRoomFor(self.character, self.itemObj)) or (not plInventoryHasSpace) then
						backPackOption.onSelect = nil;
						backPackOption.notAvailable = true;
					else
						self:doGrabSubMenu(contextMenu, backPackOption, backpack.inventory);
					end;
				end;
			end;
		end;
		contextMenu:addSubMenu(contextOption, subMenu);

		triggerEvent("onFillSearchIconContextMenu", contextMenu, self);
		return false;
	end;
	return false;
end

function ISBaseIcon:render3DItem()
	if self.itemObj and self.square then
		Render3DItem(self.itemObj, self.square, self.xCoord, self.yCoord, self.zCoord, self.itemRotation);
	end;
end

function ISBaseIcon:renderAltWorldTexture()
	self:updateZoom();
	self:updateAlpha();
	local dx, dy = self:getScreenDelta();
	self:setX(isoToScreenX(self.player, self.xCoord, self.yCoord, self.zCoord) + dx);
	self:setY(isoToScreenY(self.player, self.xCoord, self.yCoord, self.zCoord) + dy);
end

function ISBaseIcon:renderWorldItemTexture()
	self:updateZoom();
	self:updateAlpha();
	local dx, dy = self:getScreenDelta();
	self:setX(isoToScreenX(self.player, self.xCoord, self.yCoord, self.zCoord) - self.itemTexture:getWidth() / 2 / self.zoom + dx);
	self:setY(isoToScreenY(self.player, self.xCoord, self.yCoord, self.zCoord) + dy);
end

function ISBaseIcon:renderPinIcon()
	local tc = self.textureColor;
	if self.itemTexture and self.identified and self.renderItemTexture then
		local textureCenter = (self.itemTexture:getWidth() / 1.5 / self.zoom) / 2;
		local pinCenter = self.width / 2;
		self:drawTextureScaled(self.texture, 0, 0, self.width, self.height, self:getAlpha(), tc.r, tc.g, tc.b);
		self:drawTextureScaled(self.itemTexture, (pinCenter - textureCenter), 5 / self.zoom, self.itemTexture:getWidth() / 1.5 / self.zoom, self.itemTexture:getHeight() / 1.5 / self.zoom, self:getAlpha(), tc.r, tc.g, tc.b);
		if self.isKnownPoison then
			self:drawTextureScaled(poisonIcon, pinCenter, 15 / self.zoom, poisonIcon:getWidth() / self.zoom, poisonIcon:getHeight() / self.zoom, self:getAlpha(), tc.r, tc.g, tc.b)
		end;
	else
		self:drawTextureScaled(pinIconUnknown, 0, 0, self.width, self.height, self:getAlpha(), tc.r, tc.g, tc.b);
	end;
end

function ISBaseIcon:render()
	if self:getIsSeen() then
		self:updateBounce();
		self:updatePinIconSize();
		self:updatePinIconPosition();
		self:renderPinIcon();
	else
		self:resetBounce();
	end;
end

function ISBaseIcon:getAngleOffset2D(_angle1, _angle2)
	return 180 - math.abs(math.abs(_angle1 - _angle2) - 180);
end

function ISBaseIcon:getAngle2D(_x1, _y1, _x2, _y2)
	local angle = math.atan2(_x1 - _x2, -(_y1 - _y2));
	if angle < 0 then angle = math.abs(angle) else angle = 2 * math.pi - angle end;
	return math.deg(angle);
end

function ISBaseIcon:isCenterView(_bonusAngle)
	local objAngle1 = math.deg(self.character:getForwardDirection():getDirection() + math.pi / 2); --rotate 90 degrees CW
	if objAngle1 < 0 then objAngle1 = math.abs(360 + objAngle1); end; --fix to 0-360
	local objAngle2 = self:getAngle2D(self.xCoord, self.yCoord, self.character:getX(), self.character:getY()); --find angle to item
	objAngle2 = math.abs(objAngle2 - 360); --invert direction
	local offset2D = self:getAngleOffset2D(objAngle1, objAngle2); --find difference between angles
	if offset2D >= -(self.viewAngle + _bonusAngle + self.expandView) and offset2D <= (self.viewAngle + _bonusAngle + self.expandView) then
		return true;
	end;
	return false;
end

function ISBaseIcon:getDistance3D(_x1, _y1, _z1, _x2, _y2, _z2)
	local absX = math.abs(_x2 - _x1);
	local absY = math.abs(_y2 - _y1);
	local absZ = math.abs(_z2 - _z1) * self.zSize;
	return math.sqrt(absX^2 + absY^2) + absZ;
end

function ISBaseIcon:isInRangeOfPlayer(_range)
	return self:getDistance3D(self.character:getX(), self.character:getY(), self.character:getZ(), self.xCoord, self.yCoord, self.zCoord) <= _range;
end

function ISBaseIcon:isInRangeForUpdate()
	return
		((self.distanceToPlayer <= self.manager.radius and (not self.isDarknessCapped))
		or (self.distanceToPlayer <= self.viewDistance));
end

function ISBaseIcon:getIsSeen()			 			return self.isSeen; 				end;
function ISBaseIcon:setIsSeen(_isSeen)				self.isSeen = _isSeen; 				end;
function ISBaseIcon:getIsSeenThisUpdate() 			return self.isSeenThisUpdate; 		end;
function ISBaseIcon:setIsSeenThisUpdate(_isSeen) 	self.isSeenThisUpdate = _isSeen; 	end;
function ISBaseIcon:getIsNoticed()					return self.isNoticed; 			    end;
function ISBaseIcon:setIsNoticed(_isNoticed)		self.isNoticed = _isNoticed;		end;

function ISBaseIcon:getCanSeeThisUpdate()
	if (self.square and self.character) then
		if self.square:getZ() == self.character:getZ() then

			local currentSquare = self.character:getCurrentSquare();
			local canSeeSquare = self.square:isCanSee(self.player);
			local isOnSquare = self.distanceToPlayer <= self.onSquareDistance;
			local isBlockedTo = self.square:isBlockedTo(currentSquare);
			local lightPenalty = 1 - forageSystem.getLightLevelPenalty(self.character, self.square, true);
			local squareDarkMulti = self.square:getDarkMulti(self.player);

			if ISSearchManager.showDebug then
				self.visionData = {
					canSeeSquare = canSeeSquare and "true" or "false",
					isOnSquare = isOnSquare and "true" or "false",
					isBlockedTo = isBlockedTo and "true" or "false",
					lightPenalty = lightPenalty,
					squareDarkMulti = squareDarkMulti,
					itemSize = self.itemSize,
				};
			end;

			if isBlockedTo then return false; end;
			if isOnSquare then return true; end;

			if lightPenalty >= (forageSystem.lightPenaltyCutoff / 100) then
				--check for lit surface where the floor is dark - e.g. tables
				if squareDarkMulti <= 2.0 then
					return false;
				end;
			end;

			if self.perkLevel >= 5 then
				--also check adjacent squares
				for _, square in pairs(self.adjacentSquares) do
					canSeeSquare = square:isCanSee(self.player);
					if canSeeSquare and not square:isBlockedTo(currentSquare) then break; end;
				end;
			end;

			return canSeeSquare;
		end;
	end;
	return false;
end

function ISBaseIcon:updateModifiers()
	local character = self.character;
	self.modifiers.levelBonus			= forageSystem.getLevelVisionBonus(self.perkLevel);
	self.modifiers.traitBonus			= forageSystem.getTraitVisionBonus(character);
	self.modifiers.professionBonus		= forageSystem.getProfessionVisionBonus(character);
	self.modifiers.panic 				= forageSystem.getPanicPenalty(character);
	self.modifiers.body					= forageSystem.getBodyPenalty(character);
	self.modifiers.exhaustion			= forageSystem.getExhaustionPenalty(character);
	self.modifiers.clothing				= forageSystem.getClothingPenalty(character);
	self.modifiers.difficulty 			= forageSystem.getDifficultyPenalty(self.perkLevel);
	self.modifiers.size 				= forageSystem.getItemSizePenalty(self.itemSize);
	self.modifiers.weather				= forageSystem.getWeatherPenalty(character, self.square);
	self.modifiers.categoryBonus		= forageSystem.getCategoryBonus(character, self.catDef);
	self.modifiers.hungerBonus			= forageSystem.getHungerBonus(character, self.itemDef);
end

function ISBaseIcon:doVisionCheck()
	local character, itemDef = self.character, self.itemDef;
	--
	local maxRadiusCap = self.maxRadiusCap;
	local maxRadius = self.maxRadius;
	local minRadius = self.minRadius;
	--
	local levelBonus        = self.modifiers.levelBonus;
	local traitBonus        = self.modifiers.traitBonus;
	local professionBonus   = self.modifiers.professionBonus;
	--
	local viewDistance = minRadius;
	--
	maxRadius       = maxRadius + professionBonus + traitBonus;
	viewDistance    = viewDistance + levelBonus;
	viewDistance    = viewDistance + traitBonus;
	viewDistance    = viewDistance + professionBonus;
	viewDistance    = clamp(viewDistance, minRadius, maxRadius);
	--
	local modifiers = {
		panic 		= self.modifiers.panic,
		body		= self.modifiers.body,
		exhaustion	= self.modifiers.exhaustion,
		clothing	= self.modifiers.clothing,
		difficulty 	= self.modifiers.difficulty,
		size 		= self.modifiers.size,
		weather 	= self.modifiers.weather,
	};
	--
	for _, modifier in pairs(modifiers) do viewDistance = viewDistance * modifier; end;
	--
	--only the highest modifier applies for aim or sneak
	local aiming    = math.max(forageSystem.getAimVisionBonus(character) * self.manager.aimMulti, 1);
	local sneaking  = math.max(forageSystem.getSneakVisionBonus(character) * self.manager.sneakMulti, 1);

	local categoryBonus = self.modifiers.categoryBonus;
	local hungerBonus   = self.modifiers.hungerBonus;

	local visionBonus = math.max(aiming, sneaking) * categoryBonus * hungerBonus;

	viewDistance = viewDistance * visionBonus;
	maxRadius = maxRadius * visionBonus;
	minRadius = minRadius * visionBonus;
	maxRadius = math.min(maxRadius, maxRadiusCap);
	--
	local lightLevelPenalty = forageSystem.getLightLevelPenalty(character, self.square, true);
	if 1 - lightLevelPenalty >= (forageSystem.lightPenaltyCutoff / 100) then
		--if it is not well lit, you need to be on the square to see it
		viewDistance = self.darkVisionRadius;
		self.isDarknessCapped = true;
	else
		--otherwise the minimum is our normal minimum distance
		viewDistance = viewDistance * lightLevelPenalty;
		self.isDarknessCapped = false;
	end;
	--
	if itemDef and self.checkIsIdentified then
		self.identifyDistance = math.max((0.25 + ((self.perkLevel * 0.05)) * viewDistance), self.onSquareDistance);
		self:checkIsIdentified();
	end;
	--
	return clamp(viewDistance, minRadius, maxRadius);
end

function ISBaseIcon:remove() self.manager:removeIcon(self); end;

function ISBaseIcon:reset()
	self:setIsNoticed(false);
	self:setIsSeen(false);
	self:setIsSeenThisUpdate(false);
	self:setAlpha(0);
	self.alphaTarget = 0;
	self:resetBounce();
	self:removeIsoMarker();
	self:removeWorldMarker();
end

function ISBaseIcon:getScreenDelta() return -getPlayerScreenLeft(self.player), -getPlayerScreenTop(self.player); end;

function ISBaseIcon:updateZoom() self.zoom = getCore():getZoom(self.player); end;

function ISBaseIcon:updateAlpha()
	self.alphaTarget = clamp(1 - self.distanceToPlayer / self.maxRadius, 0, 1);
	--
	self:setAlpha(self.alphaTarget);
	--
	if self.isoMarker then
		self.isoMarker:setAlpha(self:getAlpha());
	end;
	if self:getAlpha() <= 0 then self:reset(); end;
end

function ISBaseIcon:updatePinIconPosition()
	self:updateZoom();
	self:updateAlpha();
	local dx, dy = self:getScreenDelta();
	self:setX(isoToScreenX(self.player, self.xCoord, self.yCoord, self.zCoord) + dx - self.width / 2); --for item texture
	self:setY(isoToScreenY(self.player, self.xCoord, self.yCoord, self.zCoord) + dy + (self.pinOffset / self.zoom));
	self:setY(self.y - (30 / self.zoom) - (self.height) + (math.sin(self.bounceStep) * self.bounceHeight));
end

function ISBaseIcon:updatePinIconSize()
	self:updateZoom()
	self:setWidth(self.baseWidth / self.zoom);
	self:setHeight(self.baseHeight / self.zoom);
end

function ISBaseIcon:initItem()
	if (not self.itemObj) then
		if self.icon then
			if self.icon.itemObj then
				self.itemObj = self.icon.itemObj;
			elseif self.icon.itemType then
				self.itemObj = instanceItem(self.icon.itemType);
				self.icon.itemObj = self.itemObj;
			else
				print("[ISBaseIcon][initItem] no item or type for "..self.icon.id);
			end;
		end;
	end;
	if self.itemObj and (not self.itemTexture) then
		self.itemTexture = self.itemObj:getTexture();
		self:findTextureCenter();
		self:findPinOffset();
	end;
end

function ISBaseIcon:initItemCount()
	if self.itemDef then
		if self.itemDef.minCount == self.itemDef.maxCount then
			self.itemCount = self.itemDef.minCount;
		else
			self.itemCount = ZombRand(self.itemDef.minCount, self.itemDef.maxCount) + 1;
		end;
	end;
end

function ISBaseIcon:getItemList()
	if self.itemDef and (not self.itemList) then
		if self.icon.itemList then
			self.itemList = self.icon.itemList;
		else
			self.itemList = ArrayList.new();
			--
			for _ = 1, self.itemCount do
				self.itemList:add(instanceItem(self.itemDef.type));
			end;
			--
			if self.itemDef.spawnFuncs then
				for _, spawnFunc in ipairs(self.itemDef.spawnFuncs) do
					self.itemList = spawnFunc(self.character, self.character:getInventory(), self.itemDef, self.itemList) or self.itemList;
				end;
			end;
			--
			self.icon.itemList = self.itemList;
		end
	end;
	--reset the itemObj to be the first item in the new list
	if self.itemList and not self.itemList:isEmpty() then
		if self.itemList:get(0) ~= nil then
			self.itemObj = self.itemList:get(0);
			self.icon.itemObj = self.itemObj;
		end;
	end;
	self:checkForPoison();
end

function ISBaseIcon:updateTimestamp()
	self.currentTimestamp = getTimestampMs();
	if self.lastTimestamp <= 0 then self.lastTimestamp = self.currentTimestamp; end;
	local aiming = math.max(forageSystem.getAimVisionBonus(self.character) * self.manager.aimMulti, 1);
	local sneaking = math.max(forageSystem.getSneakVisionBonus(self.character) * self.manager.sneakMulti, 1);
	self.timeDelta = (self.currentTimestamp - self.lastTimestamp) * math.max(aiming, sneaking, 1);
	self.lastTimestamp = self.currentTimestamp;
end

function ISBaseIcon:checkIsSpotted()
    if self:getSpotTimer() >= self.spotTimerMax then self:spotIcon(); end;
end

function ISBaseIcon:updateSpotTimerMax()
	self.spotTimerMax = 300 + ((10 - self.perkLevel + 1) * 200);
end

function ISBaseIcon:spotIcon()
	if (not self:getIsSeen()) then
		self:resetBounce();
		self.spotTimer = self.spotTimerMax;
		self:setIsNoticed(true);
		self:updateAlpha();
		self:setIsSeen(true);
		self:setIsSeenThisUpdate(true);
		self.manager:spotIcon(self);
		self:addIsoMarker();
		self:initItem();
		self:initItemCount();
		self:getItemList();
		if self.canRollForSearchFocus then
			self.canRollForSearchFocus = false;
		end;
	end;
end

function ISBaseIcon:updateSpotTimer()
	self:updateSpotTimerMax();
	if self.distanceToPlayer <= self.viewDistance and self.manager.isSearchMode and (not self:getIsSeen()) then
		self.manager.isSpotting = self;
		if self.distanceToPlayer <= self.minRadius or self:isCenterView((self.perkLevel or 0) * 6) then
			self:setIsNoticed(true);
			self.spotTimer = math.max(self.spotTimer + self.timeDelta, 0);
			self.stareVal = math.max(self.spotTimer / self.spotTimerMax, self.manager:getAlpha());
			self.manager:setAlpha(math.min(self.stareVal, 1));
			self.manager:resetForceFindSystem();
		else
			--anti frustration, the view will expand gradually until the item is spotted
			self.expandView = self.expandView + self.expandViewStep;
			self.manager:setAlpha(math.max(self.manager.spotAlpha, self.manager:getAlpha()));
		end;
	else
		self.expandView = 0;
		self.spotTimer = math.max(self.spotTimer - self.timeDelta, 0);
	end;
end

function ISBaseIcon:getIsSearchModeActive()
	if (self.manager.isSearchMode) and (not self.character:getVehicle()) then return true; end;
	self:reset();
	return false;
end

function ISBaseIcon:updateViewDistance()
	self.viewDistance = self:doVisionCheck();
	if ISSearchManager.showDebugVisionRadius and self.isoMarker then
		self.isoMarker:setCircleSize(self.viewDistance);
	end;
end

function ISBaseIcon:updateDistanceToPlayer()
	self.distanceToPlayer = self:getDistance3D(self.character:getX(), self.character:getY(), self.character:getZ(), self.xCoord, self.yCoord, self.zCoord);
end

function ISBaseIcon:removeIsoMarker()
	if self.isoMarker then self.isoMarker:remove(); self.isoMarker = nil; end;
end

function ISBaseIcon:addIsoMarker()
	self:updateAlpha();
	self:updateManagerMarkers();
	if self.isBeingRemoved then return; end;
	if not (self.itemObj and self.itemTexture) then self:initItem(); end;
	if self.iconClass and self.iconClass == "forageIcon" and (not self.isoMarker) then
		if self.altWorldTexture then
			local altTextures = {};
			local altName;
			for _, texture in ipairs(self.altWorldTexture) do
				altName = texture and texture:getName() or false;
				if altName then table.insert(altTextures, altName); end;
			end;
			if #altTextures > 0 then
				if self.itemDef.doIsoMarkerSprite then
					self.isoMarker = getIsoMarkers():addIsoMarker(self.itemDef.doIsoMarkerSprite, self.square, 1, 1, 1, self:getAlpha());
				else
					self.isoMarker = getIsoMarkers():addIsoMarker(altTextures, self.square, 1, 1, 1, self:getAlpha());
				end;
			else
				self.isoMarker = getIsoMarkers():addIsoMarker(self.itemObj, self.square, 1, 1, 1, self:getAlpha(), self.itemRotation);
			end;
		else
			self.isoMarker = getIsoMarkers():addIsoMarker(self.itemObj, self.square, 1, 1, 1, self:getAlpha(), self.itemRotation);
		end;
	end;
end

function ISBaseIcon:addWorldMarker()
	self:updateManagerMarkers();
	if self.isBeingRemoved then return; end;
	self.worldMarker = getWorldMarkers():addPlayerHomingPoint(self.character, self.xCoord, self.yCoord, 0.8, 0.8, 0.8, 1);
	self:setWorldMarkerPosition();
end

function ISBaseIcon:setWorldMarkerPosition()
	self.worldMarker:setX(self.xCoord);
	self.worldMarker:setY(self.yCoord);
	if self.altWorldTexture then
		self.worldMarker:setHomeOnOffsetX(IsoUtils.XToScreen(0.0, 0.0, 0, 0));
		self.worldMarker:setHomeOnOffsetY(IsoUtils.YToScreen(0.0, 0.0, 0, 0));
	elseif self.itemTexture then
		self.worldMarker:setHomeOnOffsetX(IsoUtils.XToScreen(0.5, 0.5, 0, 0));
		self.worldMarker:setHomeOnOffsetY(IsoUtils.YToScreen(0.5, 0.5, 0, 0) - self.itemTexture:getHeight() / 2);
	end;
end

function ISBaseIcon:removeWorldMarker()
	if self.worldMarker then self.worldMarker:remove(); self.worldMarker = nil; end;
end

function ISBaseIcon:updateWorldMarker()
	if
		(self.iconClass == "forageIcon" or self.iconClass == "worldObject")
		and self.manager.disableTick == 0
		and self:isNearby()
		and self:getIsSeenThisUpdate()
		and self:checkIsForageable()
		and self:isInRangeForUpdate()
	then
		if self.canRollForSearchFocus then
			self:doSearchFocusCheck();
		end;
		if (not self.isNoticed) then
			self:setIsNoticed(true);
		end;
		if (not self.worldMarker) then
			self:addWorldMarker();
		else
			self:setWorldMarkerPosition();
		end;
		if (not self.isoMarker) then
			self:addIsoMarker();
		end;
		if self.distanceSnapshot == -1 then
			self.distanceSnapshot = math.min(getDistance2D(
				self.manager.lastSpottedX, self.manager.lastSpottedY,
				self.xCoord, self.yCoord),
				self.manager.maxDistanceBonus
			);
			self.manager.lastSpottedX = self.xCoord;
			self.manager.lastSpottedY = self.yCoord;
		end;
	else
		self:removeWorldMarker();
		if (not self:getIsSeen()) then
			self:removeIsoMarker();
		end;
	end;
end

function ISBaseIcon:getSpotTimer()			return self.spotTimer; 							        end;
function ISBaseIcon:setSpotTimer(_time)		self.spotTimer = _time; 						        end;
function ISBaseIcon:isNearby()				return self.distanceToPlayer <= self.maxRadius;         end;
function ISBaseIcon:checkIsForageable()     return self.isForageable;                               end;

function ISBaseIcon:checkForPoison()
	if self.isTrack then return; end
	self.isKnownPoison = false;
	for item in iterList(self.itemList) do
		if self.character:isKnownPoison(item) then
			self.isKnownPoison = true;
			break;
		end;
	end;
end;

function ISBaseIcon:updateManagerMarkers()
	local manager = self.manager;
	local managedMarkers = self.managedMarkers;
	for markerType, managedType in pairs(managedMarkers) do
		if self[markerType] then
			if manager[managedType][self.iconID] then
				if manager[managedType][self.iconID] ~= self[markerType] then
					manager[managedType][self.iconID]:remove();
					manager[managedType][self.iconID] = self[markerType];
				end;
			else
				manager[managedType][self.iconID] = self[markerType];
			end;
		else
			if manager[managedType][self.iconID] then
				manager[managedType][self.iconID]:remove();
				manager[managedType][self.iconID] = nil;
			end;
		end;
	end;
end

function ISBaseIcon:updatePerkLevel()
	if self.itemDef then
		self.perkLevel = forageSystem.getPerkLevel(self.character, self.itemDef);
	else
		self.perkLevel = self.character:getPerkLevel(Perks.PlantScavenging);
	end;
end

function ISBaseIcon:checkIsPlayerRunning()
	return ((self.character:isRunning() or self.character:isSprinting()) and self.character:isPlayerMoving());
end

function ISBaseIcon:updateLastSeen()
	self.lastSeenHours = forageSystem.getWorldAge();
end

function ISBaseIcon:doUpdateEvents(_force)
	self.updateTick = self.updateTick + 1;
	--
	for i, event in ipairs(self.updateEvents) do
		if (_force or self.updateTick % event.tick == 0) and self[event.method] then
			self[event.method](self);
		end;
	end;
	--
	if self.updateTick > self.updateTickMax then self.updateTick = 0; end;
end

function ISBaseIcon:update()
	self:setIsSeenThisUpdate(false);
	--
	if (not self:getGridSquare()) or (not self:getIsSearchModeActive()) then
		self:removeIsoMarker();
		self:removeWorldMarker();
		return;
	end;
	--
	if (not self:isValid()) then self:remove(); return; end;
	--
	self:updateDistanceToPlayer();
	--
	if self:isNearby() then
		self:updateTimestamp();
		self:doUpdateEvents();
		if self.manager:getIsSeen(self) then self:spotIcon(); end;
		if (not self.isValidSquare) then self.manager:doChangePosition(self); return; end;
		self:setIsSeenThisUpdate(self:getCanSeeThisUpdate());
		if (not self:checkIsPlayerRunning()) then
			if self:getIsSeenThisUpdate() then
				if self:checkIsForageable() then
					self:updateSpotTimer();
					self:checkIsSpotted();
					self:updateLastSeen();
				end;
			end;
		else
			self:setSpotTimer(0);
		end;
	end;
	--
	self:updateWorldMarker();
	self:updateManagerMarkers();
end

function ISBaseIcon:findPinOffset()
	if self.altWorldTexture then
        local tallestTexture = 0;
        for _, texture in ipairs(self.altWorldTexture) do
            if tallestTexture < texture:getHeight() then tallestTexture = texture:getHeight() end;
        end;
        local tileHeight = 32 * Core.getTileScale()
        self.pinOffset = tileHeight / 2 - tallestTexture;
		return;
	end;
	if self.itemTexture then
		local tileHeight = 32 * Core.getTileScale()
		self.pinOffset = tileHeight / 2 - self.itemTexture:getHeight();
	end;
end

function ISBaseIcon:findTextureCenter()
	if self.altWorldTexture then
		local widestTexture = 0;
		for _, texture in ipairs(self.altWorldTexture) do
			if widestTexture < texture:getWidth() then widestTexture = texture:getWidth(); end;
		end;
		self.textureCenter = widestTexture / 2;
	elseif self.itemTexture then
		self.textureCenter = self.itemTexture:getWidth() / 2;
	else
		self.textureCenter = 0;
	end;
end

function ISBaseIcon:resetBounce()
	self.bounce = true;
	self.bounceStep = 1 * math.pi;
	self.bounceMax = 2 * math.pi;
	self.bounceHeight = 24;
	self.bounceSpeed = 0.1;
end

function ISBaseIcon:updateBounce()
	if self.bounce then
		self.bounceStep = self.bounceStep + self.bounceSpeed;
		if self.bounceStep >= self.bounceMax then
			self.bounce = false;
		end;
	end;
end

function ISBaseIcon:initGridSquare()
	local cell = getCell();
	if cell then
		local square = (getCell():getGridSquare(self.icon.x, self.icon.y, self.icon.z));
		if square then
			self.square = square;
			self.adjacentSquares = {
				north   = square:getN(),
				south   = square:getS(),
				east	= square:getE(),
				west	= square:getW(),
			};
			return self.square;
		end;
	end;
	return false;
end

function ISBaseIcon:initAltTexture()
	if type(self.altWorldTexture) == 'string' then
		self.altWorldTexture = {getTexture(texture)};
	elseif type(self.altWorldTexture) == 'table' then
		if type(self.altWorldTexture[1]) == 'table' then
			if #self.altWorldTexture > 1 then
				self.altWorldTexture = self.altWorldTexture[ZombRand(#self.altWorldTexture) + 1];
			else
				self.altWorldTexture = self.altWorldTexture[1];
			end;
		end;
		for i, texture in ipairs(self.altWorldTexture) do
			if type(texture) == 'string' then
				self.altWorldTexture[i] = getTexture(texture);
			end;
		end;
	else
		self.altWorldTexture = {self.altWorldTexture};
	end;
end

function ISBaseIcon:initialise()
	ISPanel.initialise(self);
	self:setAlpha(0);
	self:initGridSquare();
	self:setVisible(true);
	self:setFollowGameWorld(true);
	self:setRenderThisPlayerOnly(self.player);
end

function ISBaseIcon:new(_manager, _icon)
	local forageSystem = forageSystem;
	local o = {};
	o = ISPanel:new(0, 0, 30, 45);
	setmetatable(o, self)
	self.__index = self;

	o.width                 = 30;
	o.height                = 45;
	o.baseWidth             = o.width;
	o.baseHeight            = o.height;

	o.iconClass             = "ISBaseIcon";

	o.manager               = _manager;
	o.character             = _manager.character;
	o.player                = _manager.character:getPlayerNum();
	o.perkLevel             = _manager.perkLevel;

	o.icon                  = _icon;
	o.iconID                = _icon.id;
	o.xCoord                = _icon.x or 0;
	o.yCoord                = _icon.y or 0;
	o.zCoord                = _icon.z or 0;

	o.zSize                 = 10;

	o.texture               = pinIconBlank;
	o.textureColor          = {r = 1, g = 1, b = 1, a = 0};
	o.alphaTarget           = 0;

	o.square                = nil;
	o.adjacentSquares       = {};

	o.spotTimer             = 0;
	o.spotTimerMax          = 10000;
	o.lastTimestamp         = 0;
	o.currentTimestamp      = 0;

	o.lastSeenHours         = 0;
	o.onSquareDistance      = 1.5;
	o.darkVisionRadius      = forageSystem.darkVisionRadius;
	o.minRadius             = forageSystem.minVisionRadius;
	o.maxRadius             = forageSystem.maxVisionRadius;
	o.maxRadiusCap          = forageSystem.visionRadiusCap;

	o.distanceToPlayer      = 0;
	o.viewDistance          = 0;
	o.identifyDistance      = 0;

	o.isDarknessCapped      = false;

	o.isNoticed             = false;
	o.isSeen                = false;
	o.isSeenThisUpdate      = false;

	o.identified            = true;

	o.isBeingRemoved        = false;

	o.renderItemTexture     = true;
	o.isBonusIcon           = false;
	o.isForageable          = true;

	o.canMoveVertical       = false;

	o.posChanges            = 0;
	o.maxPosChanges         = 10;

	o.onMouseDoubleClick    = ISBaseIcon.doPickup;

	o.modifiers				= {
		levelBonus			= 0,
		traitBonus			= 0,
		professionBonus		= 0,
		panic 				= 0,
		body				= 0,
		exhaustion			= 0,
		clothing			= 0,
		difficulty 			= 0,
		size 				= 0,
		weather				= 0,
		categoryBonus		= 0,
		hungerBonus			= 0,
	};

	o.viewAngle             = 30;
	o.expandView            = 0;
	o.expandViewStep        = 0.5;

	o.textureCenter         = 0;
	o.pinOffset             = 0;

	o.itemType              = _icon.itemType;
	o.itemSize              = _icon.itemSize or 1.0;

	o.moveState             = "idle";
	o.moveTargetX           = o.xCoord;
	o.moveTargetY           = o.yCoord;

	o.visionData            = {};

	o.managedMarkers        = ISBaseIcon.managedMarkers;
	o.worldMarker           = nil;
	o.isoMarker             = nil;

	o.itemList              = nil;
	o.itemCount             = 1;
	o.isKnownPoison         = false;

	o.updateTick			= 0;
	o.updateTickMax			= 200;
	o.updateEvents          = ISBaseIcon.updateEvents;

	o.bounce				= true;
	o.bounceStep			= 1 * math.pi;
	o.bounceMax				= 2 * math.pi;
	o.bounceHeight			= 24;
	o.bounceSpeed			= 0.1;

	o.canRollForSearchFocus	= false;

	o.itemRotation			= ZombRand(360);

	o.distanceSnapshot		= -1;

	o:initialise();
	return o;
end
