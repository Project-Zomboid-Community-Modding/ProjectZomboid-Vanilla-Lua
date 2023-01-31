-------------------------------------------------
-------------------------------------------------
--
-- ISSearchManager
--
-- eris
--
-------------------------------------------------
-------------------------------------------------
require "Foraging/forageSystem";
require "ISUI/ISPanel";
-------------------------------------------------
-------------------------------------------------
local eyeTex = {
	eyeconOn = getTexture("media/textures/Foraging/eyeconOn_Shade.png"),
	eyeconOff = getTexture("media/textures/Foraging/eyeconOff_Shade.png"),
};
-------------------------------------------------
-------------------------------------------------
local getTimestampMs = getTimestampMs;
local math = math;
local table = table;
-------------------------------------------------
-------------------------------------------------
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

local function isInRect(_x, _y, _x1, _x2, _y1, _y2)
	return (_x >= _x1 and _x <= _x2 and _y >= _y1 and _y <= _y2) or false;
end

local function clamp(_value, _min, _max)
	if _min > _max then _min, _max = _max, _min; end;
	return math.min(math.max(_value, _min), _max);
end

local function getDistance2D(_x1, _y1, _x2, _y2)
	return math.sqrt(math.abs(_x2 - _x1)^2 + math.abs(_y2 - _y1)^2);
end
-------------------------------------------------
-------------------------------------------------
LuaEventManager.AddEvent("onToggleSearchMode");
LuaEventManager.AddEvent("onEnableSearchMode");
LuaEventManager.AddEvent("onDisableSearchMode");
-------------------------------------------------
-------------------------------------------------
ISSearchManager         			    = ISPanel:derive("ISSearchManager");
ISSearchManager.players 			    = {};
ISSearchManager.iconItems 			    = {};
ISSearchManager.showDebug 			    = false;
ISSearchManager.showDebugLocations	    = false;
ISSearchManager.showDebugExtended	    = false;
ISSearchManager.showDebugVision		    = false;
ISSearchManager.showDebugVisionRadius   = false;
-------------------------------------------------
-------------------------------------------------
ISSearchManager.updateEvents          = {
	{ method = "updateCurrentZone",      tick = 10,     breakTick = false },
	{ method = "checkActiveZones",       tick = 30,     breakTick = false },
	{ method = "updateForceFindSystem",  tick = 10,     breakTick = false },
	{ method = "checkIcons",             tick = 5,      breakTick = false },
	{ method = "checkSquares",           tick = 5,      breakTick = false },
	{ method = "checkWorldIcons",        tick = 5,		breakTick = false },
};
-------------------------------------------------
-------------------------------------------------
--containers matching these types will be detected as a stash
ISSearchManager.stashTypes              = {
	["ShotgunBox"]	= true,
	["GunBox"] 		= true,
	["ToolsBox"] 	= true,
};

--skip these item types when adding world pins
ISSearchManager.ignoredItemTypes        = {
	["Base.UnusableWood"]   = true,
	["Base.UnusableMetal"]  = true,
};
-------------------------------------------------
-------------------------------------------------
function ISSearchManager.getManager(_character)
	if not ISSearchManager.players[_character] then
		ISSearchManager.setManager(_character, ISSearchManager:new(_character));
	end;
	return ISSearchManager.players[_character];
end;

function ISSearchManager.setManager(_character, _manager)
	if ISSearchManager.players[_character] then
		ISSearchManager.destroyUI(_character);
	end;
	ISSearchManager.players[_character] = _manager;
end;
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:onMouseDown()		 return false; 							end;
function ISSearchManager:onRightMouseUp() 	 return false; 							end;
function ISSearchManager:onRightMouseDown()  return false; 							end;
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:getAlpha()			 return self.textureColor.a; 			end;
function ISSearchManager:getColor()			 return self.textureColor; 				end;
function ISSearchManager:setAlpha(_a)		 self.textureColor.a = _a;				end;
function ISSearchManager:setColor(_rgba) 	 self.textureColor = _rgba;				end;
function ISSearchManager:flashEye(_amount)
	self.textureColor.a = math.max(_amount or 1, self.textureColor.a);
end;
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:onToggleVisible()
	if self:getIsVisible() then
		self:addToUIManager();
	else
		self:removeFromUIManager();
	end;
	self:update();
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:getScreenDelta() return -getPlayerScreenLeft(self.player), -getPlayerScreenTop(self.player); end;
function ISSearchManager:updateZoom() self.zoom = getCore():getZoom(self.player); 	end;

function ISSearchManager:updatePosition()
	local dx, dy = self:getScreenDelta();
	self:setX(isoToScreenX(self.player, self.character:getX(), self.character:getY(), self.character:getZ()) - (self.textureWidth / 2) + dx);
	self:setY(isoToScreenY(self.player, self.character:getX(), self.character:getY(), self.character:getZ()) + dy - (140 / self.zoom) - self.textureHeight);
end

function ISSearchManager:updateTimestamp()
	self.currentTimestamp = getTimestampMs();
	--
	if self.lastTimestamp <= 0 then self.lastTimestamp = self.currentTimestamp; end;
	self.timeDelta = self.currentTimestamp - self.lastTimestamp;
	if not self.character:isPlayerMoving() then self.timeDelta = -self.timeDelta; end;
	self.timeSinceFind = self.timeSinceFind + self.timeDelta;
	self.timeSinceFind = clamp(self.timeSinceFind, 0, self.timeToMoveIcon);
	--
	self.lastTimestamp = self.currentTimestamp;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:prerender() end;
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:renderEye()
	local tc = self.textureColor;
	self:drawTextureScaled(self.texture, 0, 0, self.textureWidth, self.textureHeight, tc.a, tc.r, tc.g, tc.b);
end

function ISSearchManager:render()
	self:updateZoom();
	self:updatePosition();
	self:renderEye();
	if ISSearchManager.showDebug then self:renderDebugInfo(); end;
end

function ISSearchManager:renderDebugInfo()
	if self:getGameSpeed() ~= 1 then return; end;
	self:checkMarkers();
	--if ISSearchManager.showDebugVisionRadius then
	--	if not self.debugPlayerMarker then
	--		self.debugPlayerMarker = getIsoMarkers():addCircleIsoMarker(self.character:getCurrentSquare(), 1, 1, 1, 1);
	--		self.debugPlayerMarker:setSize(self.radius);
	--		self.debugPlayerMarker:setPos(self.character:getX(), self.character:getY(), self.character:getZ());
	--	else
	--		self.debugPlayerMarker:setSize(self.radius);
	--		self.debugPlayerMarker:setPos(self.character:getX(), self.character:getY(), self.character:getZ());
	--	end;
	--else
	--	if self.debugPlayerMarker then
	--		self.debugPlayerMarker:remove();
	--		self.debugPlayerMarker = nil;
	--	end;
	--end;
	for iconID, icon in pairs(self.stashIcons) do
		--renderIsoCircle(icon.xCoord, icon.yCoord, icon.zCoord, icon.viewDistance, 1, 1, 0, 1, 1);
		icon:drawTextCentre("stash", 0, 50, 1, 1, 1, 1, UIFont.NewMedium);
	end;
	for iconID, icon in pairs(self.worldObjectIcons) do
		--renderIsoCircle(icon.xCoord, icon.yCoord, icon.zCoord, icon.viewDistance, 1, 1, 0, 1, 1);
		icon:drawTextCentre(icon.itemType, 0, 50, 1, 1, 1, 1, UIFont.NewMedium);
		if ISSearchManager.showDebugVision then
			local y = 60;
			y = y + 15;
			icon:drawTextCentre("Vision Data", 0, y, 1, 1, 1, 1, UIFont.NewSmall);
			for k, v in pairs(icon.visionData) do
				y = y + 15;
				icon:drawTextCentre(tostring(k).." = "..tostring(v), 0, y, 1, 1, 1, 1, UIFont.NewSmall);
			end;
		end;
	end;
	if ISSearchManager.showDebugLocations then
		for iconID, icon in pairs(self.forageIcons) do
			if (not self.debugArrows[iconID]) then
				if icon.icon.isBonusIcon then
					self.debugArrows[iconID] = getWorldMarkers():addPlayerHomingPoint(self.character, icon.xCoord, icon.yCoord, 0, 1, 0, 1);
				else
					self.debugArrows[iconID] = getWorldMarkers():addPlayerHomingPoint(self.character, icon.xCoord, icon.yCoord, 1, 1, 1, 1);
				end;
			else
				local x, y = icon.xCoord, icon.yCoord;
				if x ~= self.debugArrows[iconID]:getX() or y ~= self.debugArrows[iconID]:getY() then
					self.debugArrows[iconID]:setX(icon.xCoord);
					self.debugArrows[iconID]:setY(icon.yCoord);
				end;
			end;
		end;
	end;
	for iconID in pairs(self.activeIcons) do
		local icon = self.forageIcons[iconID];
		--debug icons
		--icon:renderWorldIcon();
		--Render3DItem(icon.itemObj, icon.square, icon.xCoord, icon.yCoord, 0, icon.itemRotation);
		icon:updatePinIconPosition();
		icon:drawTextCentre(icon.itemType, 0, 50, 1, 1, 1, 1, UIFont.NewMedium);
		local y = 60;
		if ISSearchManager.showDebugExtended then
			if icon.itemDef then
				local itemDef = icon.itemDef;
				y = y + 15;
				icon:drawTextCentre("Perk level required: " .. itemDef.skill, 0, y, 1, 1, 1, 1, UIFont.NewSmall);
				y = y + 15;
				icon:drawTextCentre("Perks required: " .. tostring(unpack(itemDef.perks) or "none"), 0, y, 1, 1, 1, 1, UIFont.NewSmall);
				y = y + 15;
				icon:drawTextCentre("Traits required: " .. tostring(unpack(itemDef.traits) or "none"), 0, y, 1, 1, 1, 1, UIFont.NewSmall);
				y = y + 15;
				icon:drawTextCentre("Recipe required: " .. tostring(unpack(itemDef.recipes) or "none"), 0, y, 1, 1, 1, 1, UIFont.NewSmall);
				y = y + 15;
				icon:drawTextCentre("Itemtags required: " .. tostring(unpack(itemDef.itemTags) or "none"), 0, y, 1, 1, 1, 1, UIFont.NewSmall);
			end;
		end;
		if ISSearchManager.showDebugVisionRadius then
			if not self.debugMarkers[iconID] then
				if icon.square then
					self.debugMarkers[iconID] = getIsoMarkers():addCircleIsoMarker(icon.square, 1, 1, 1, 1);
				end;
				--self.debugMarkers[iconID]:setSize(icon.viewDistance);
				--self.debugMarkers[iconID]:setPos(icon.xCoord, icon.yCoord, icon.zCoord);
			else
				self.debugMarkers[iconID]:setPos(icon.xCoord, icon.yCoord, icon.zCoord);
				self.debugMarkers[iconID]:setSize(icon.viewDistance);
			end;
		end;
		if ISSearchManager.showDebugVision then
			y = y + 15;
			icon:drawTextCentre("Vision Data", 0, y, 1, 1, 1, 1, UIFont.NewSmall);
			for k, v in pairs(icon.visionData) do
				y = y + 15;
				icon:drawTextCentre(tostring(k).." = "..tostring(v), 0, y, 1, 1, 1, 1, UIFont.NewSmall);
			end;
			y = y + 15;
			icon:drawTextCentre("Distance 2D: " .. tostring(icon.distanceToPlayer or "none"), 0, y, 1, 1, 1, 1, UIFont.NewSmall);
			y = y + 15;
			icon:drawTextCentre("View Distance: " .. tostring(icon.viewDistance or "none"), 0, y, 1, 1, 1, 1, UIFont.NewSmall);
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:isIconOnSquare(_square, _iconList)
	if not (_square and _iconList) then return; end;
	for iconID, icon in pairs(_iconList) do
		if icon.square == _square then return true; end;
	end;
	return false;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:addHaloNote(_text)
	table.insert(self.haloNotes, _text);
end

function ISSearchManager:displayHaloNotes()
	if #self.haloNotes > 0 then
		if self.character:getHaloTimerCount() == 0 then
			self.character:setHaloNote(table.remove(self.haloNotes), 220, 220, 220, 100);
			self.triggerHalo = false;
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:clearSpriteCheckedSquares()
	table.wipe(self.spriteCheckedSquares);
end

function ISSearchManager:clearMovedIconsSquares()
	table.wipe(self.movedIconsSquares);
end

function ISSearchManager:clearCheckedSquares()
	table.wipe(self.checkedSquares);
	table.wipe(self.squareStack);
end

function ISSearchManager:clearQueue()
	table.wipe(self.worldIconStack);
	table.wipe(self.iconStack);
	self.iconQueue = 0;
end

function ISSearchManager:clearHaloNotes()
	table.wipe(self.haloNotes);
end

function ISSearchManager:reset()
	self:resetForceFindSystem();
	self:clearZoneData();
	self:clearIcons();
	self:clearQueue();
	self:clearCheckedSquares();
	self:clearMovedIconsSquares();
	self:clearHaloNotes();
	self:resetVisionBonuses();
	self:checkMarkers();
end

function ISSearchManager:clearZoneData()
	for zoneID, zoneData in pairs(self.activeZones) do
		for iconID in pairs(zoneData.forageIcons) do
			if self.forageIcons[iconID] then self:removeIcon(self.forageIcons[iconID]); end;
		end;
		self.activeZones[zoneID] = nil;
	end;
	self.currentZone = nil;
	table.wipe(self.activeZones);
end

function ISSearchManager:removeZoneAndIcons(_zoneData)
	self.activeZones[_zoneData.id] = nil;
	for iconID in pairs(_zoneData.forageIcons) do
		if self.forageIcons[iconID] then
			self:removeIcon(self.forageIcons[iconID]);
		end;
	end;
end

function ISSearchManager:removeItem(_icon)
	forageSystem.takeItem(_icon.zoneData);
	forageClient.updateIcon(_icon.zoneData, _icon.iconID, nil);
	forageClient.updateZone(_icon.zoneData);
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:addIcon(_id, _iconClass, _itemType, _itemObj, _x, _y, _z)
	local id = _id or getRandomUUID();
	--create icon class/category if it does not exist so it can be managed/removed
	if not self[_iconClass] then
		self[_iconClass] = {};
		self.iconCategories[_iconClass] = _iconClass;
	end;
	if not self[_iconClass][id] then
		local itemObj = _itemObj or InventoryItemFactory.CreateItem(_itemType or "Base.Plank");
		local itemType = _itemType or itemObj:getFullType();
		local icon = {
			id          = id,
			x           = _x,
			y           = _y,
			z		    = _z,
			itemObj     = itemObj,
			itemType    = itemType,
			isBonusIcon = false,
		};
		self[_iconClass][id] = ISBaseIcon:new(self, icon);
		self[_iconClass][id]:doUpdateEvents(true);
		self[_iconClass][id]:addToUIManager();
		self[_iconClass][id]:findTextureCenter();
		self.iconCategories[_iconClass] = _iconClass;
		return self[_iconClass][id];
	end;
end

function ISSearchManager:clearIcons()
	for iconClass in pairs(self.iconCategories) do
		for iconID, icon in pairs(self[iconClass]) do
			icon:remove();
			icon:removeFromUIManager();
			self[iconClass][iconID] = nil;
		end;
		self[iconClass] = {};
	end;
	table.wipe(self.activeIcons);
	table.wipe(self.movedIcons);
end

function ISSearchManager:removeIcon(_icon)
	if not _icon and _icon.iconID then return; end;
	_icon:reset();
	for iconClass in pairs(self.iconCategories) do
		self[iconClass][_icon.iconID] = nil;
	end;
	_icon:removeFromUIManager();
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:checkForSpriteAffinity(_square, _object, _zoneData)
	local spriteName, spriteCategory, catDef;
	local affinityTable = self.spriteAffinities;
	local spriteTable = {};
	spriteName = _object:getSprite() and _object:getSprite():getName();
	if spriteName then
		table.insert(spriteTable, spriteName);
		local animSprites = _object:getAttachedAnimSprite();
		if animSprites then
			for animSprite in iterList(animSprites) do
				spriteName = animSprite and animSprite:getName();
				if spriteName then table.insert(spriteTable, spriteName); end;
			end;
		end;
	end;
	--
	local doSpriteCheck = true;
	local categoryTable;
	for _, spriteName in ipairs(spriteTable) do
		categoryTable = affinityTable[spriteName];
		if categoryTable then
			spriteCategory = categoryTable[ZombRand(#categoryTable) + 1];
			catDef = spriteCategory and forageSystem.catDefs[spriteCategory] or false;
			if spriteCategory and catDef then
				if (not self:isIconOnSquare(_square, self.activeIcons)) then
					doSpriteCheck = false;
					if ZombRandFloat(0.0, 100.0) < catDef.chanceToMoveIcon then
						self:findSpriteAffinityIcon(_square, catDef, _zoneData);
					elseif ZombRandFloat(0.0, 100.0) < catDef.chanceToCreateIcon then
						self:createBonusIcon(_square, catDef, _zoneData);
					end;
				end;
			end;
		end;
	end;
	--
	return doSpriteCheck;
end

function ISSearchManager:createBonusIcon(_square, _catDef, _zoneData)
	local square, catDef = _square, _catDef;
	--generate a mini loot table
	local possibleItemTypes = {};
	for itemType, itemDef in pairs(forageSystem.itemDefs) do
		for _, catName in ipairs(itemDef.categories) do
			if (catName == catDef.name) and forageSystem.isValidMonth(nil, itemDef) then
				if itemDef.zones[_zoneData.name] then
					--just using the base chance for the items in this zone
					for i = 1, itemDef.zones[_zoneData.name] do
						table.insert(possibleItemTypes, itemDef);
					end;
					break;
				end
			end;
		end;
	end;
	local pickedItemType;
	if #possibleItemTypes > 0 then
		pickedItemType = possibleItemTypes[ZombRand(#possibleItemTypes) + 1];
	end;
	if pickedItemType then
		local iconID = getRandomUUID();
		local forageIcon = {
			id          			= iconID,
			zoneid      			= _zoneData.id,
			x           			= square:getX(),
			y           			= square:getY(),
			z           			= square:getZ(),
			catName     			= catDef.name,
			itemType    			= pickedItemType.type,
			isBonusIcon				= true,
			canRollForSearchFocus	= false,
		};
		_zoneData.forageIcons[iconID] = forageIcon;
		self.forageIcons[iconID] = ISForageIcon:new(self, forageIcon, _zoneData);
		self.activeIcons[iconID] = self.forageIcons[iconID];
		self.activeIcons[iconID]:doUpdateEvents(true);
		self.activeIcons[iconID]:addToUIManager();
		--
		--ignore this icon next time if it's still active
		self.movedIcons[iconID] = iconID;
		--ignore this square until the zone refills
		self.movedIconsSquares[square] = true;
		--add the bonus item to the loading queue of all managers
		for _, manager in pairs(ISSearchManager.players) do
			if manager.activeZones[_zoneData.id] then
				if (not manager.iconStack[iconID]) and (not manager.forageIcons[iconID]) then
					manager.iconStack[forageIcon] = _zoneData;
					manager.iconQueue = manager.iconQueue + 1;
				end;
			end;
		end;
	end;
end

function ISSearchManager:findSpriteAffinityIcon(_square, _catDef, _zoneData)
	local square, catDef = _square, _catDef;
	local foundIcon = false;
	for iconID, icon in pairs(self.activeIcons) do
		if (not self.movedIcons[iconID]) and (not self.activeIcons[iconID]) then
			if (not icon:getIsNoticed()) and (icon.catDef.name == catDef.name) then
				--make sure it's from this zone and not seen before
				if icon.icon.zoneid == _zoneData.id and (not icon:getIsSeen()) then
					foundIcon = true;
					--move it to the square
					self:doMoveIcon(icon, square:getX(), square:getY(), square:getZ());
					--force activate the icon
					icon:removeFromUIManager();
					icon:doUpdateEvents(true);
					icon:addToUIManager();
					self.activeIcons[iconID] = icon;
					--ignore this icon next time if it's still active
					self.movedIcons[iconID] = iconID;
					--ignore this square until the zone refills
					self.movedIconsSquares[square] = true;
					--prevent rolling this icon for search focus ever again (saved to the zoneData)
					icon.canRollForSearchFocus = false;
					icon.icon.canRollForSearchFocus = false;
					--stop here, we found an icon to move
					break;
				end;
			end;
		end;
	end;
	--if we didn't find an icon to move, we'll try an extra roll here to generate one instead
	if (not foundIcon) then
		if ZombRandFloat(0.0, 100.0) < catDef.chanceToCreateIcon then
			self:createBonusIcon(_square, _catDef, _zoneData);
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:worldItemTest(_itemObj)
	local itemCategory = _itemObj:getCategory();
	local itemType = _itemObj:getFullType();
	local itemWeight = _itemObj:getActualWeight();
	local isContainer = itemCategory == "Container";
	local isClothing = itemCategory == "Clothing";
	local isLightweight = itemWeight <= 0.5;
	local isVeryLightweight = itemWeight <= 0.2;
	--
	local doIcon = false;
	if (not self.ignoredItemTypes[itemType]) and (not self.ignoredItemCategories[itemCategory]) then
		if isContainer or isVeryLightweight or (isLightweight and not isClothing) then doIcon = true; end;
	end;
	--
	return doIcon;
end

function ISSearchManager:createIconsForWorldItems(_square)
	local square = _square;
	local iconCount = 0;
	local newIconMax = 10000;
	local itemObj, itemType, icon, iconID;
	for worldObject in iterList(square:getWorldObjects()) do
		itemObj = worldObject:getItem();
		if itemObj and self:worldItemTest(itemObj) then
			itemType = itemObj:getFullType();
			iconID = tostring(square).."-"..itemType;
			if not (self.worldObjectIcons[iconID] or self.worldIconStack[iconID]) then
				icon = {
					id       		= iconID,
					x        		= worldObject:getWorldPosX(),
					y        		= worldObject:getWorldPosY(),
					z			 	= worldObject:getWorldPosZ(),
					itemObj  		= itemObj,
					itemObjTable	= {},
					itemType 		= itemType,
					isBonusIcon     = false,
				};
				icon.itemObjTable[itemObj] = itemObj;
				self.worldIconStack[iconID] = icon;
				iconCount = iconCount + 1;
				if iconCount >= newIconMax then return; end;
			else
				icon = self.worldObjectIcons[iconID] or self.worldIconStack[iconID];
				if icon and (not icon.itemObjTable[itemObj]) then
					icon.itemObjTable[itemObj] = itemObj;
					--we find center x/y by averaging the pile
					--then put at highest item Z location so there is no overlapping
					if icon.xCoord and icon.yCoord and icon.zCoord then
						--we're adding to an existing icon
						icon.xCoord = (icon.xCoord + worldObject:getWorldPosX()) / 2;
						icon.yCoord = (icon.yCoord + worldObject:getWorldPosY()) / 2;
						icon.zCoord = math.max(icon.zCoord, worldObject:getWorldPosZ());
					else
						--this is a new icon, use the table we've just created
						icon.x = (icon.x + worldObject:getWorldPosX()) / 2;
						icon.y = (icon.y + worldObject:getWorldPosY()) / 2;
						icon.z = math.max(icon.z, worldObject:getWorldPosZ());
					end;
				end;
			end;
		end;
	end;
end

function ISSearchManager:createIconsForContainers(_square, _object)
	local square, object = _square, _object;
	local iconCount = 0;
	local newIconMax = 10000;
	if object:getContainer() then
		if self.stashTypes[object:getContainer():getType()] then
			if not self.stashIcons[object] then
				local itemObj = InventoryItemFactory.CreateItem("Base.Plank");
				local icon = {
					id          = object,
					x           = square:getX() + 0.5,
					y           = square:getY() + 0.5,
					z		    = square:getZ(),
					itemObj     = itemObj,
					itemType    = itemObj:getFullType(),
					isBonusIcon = false,
				};
				self.stashIcons[object] = ISWorldItemIcon:new(self, icon);
				self.stashIcons[object].iconClass = "stashObject";
				if self.stashIcons[object] then
					self.stashIcons[object]:doUpdateEvents(true);
					self.stashIcons[object]:addToUIManager();
					self.stashIcons[object]:findTextureCenter();
					self.stashIcons[object].itemTexture = getTexture("carpentry_01_16");
					self.stashIcons[object].renderItemTexture = false;
				end;
				iconCount = iconCount + 1;
				if iconCount >= newIconMax then return; end;
			end;
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------

function ISSearchManager:checkSquares()
	local plX, plY = self.character:getX(), self.character:getY();
	local sqX, sqY;
--	local zD;
	local squareCheckRate = self.squareCheckRate;
	local cellIconRadius = self.cellIconRadius * 2;
	local zoneData;
	local i = 1;
	for square in pairs(self.squareStack) do
		self.squareStack[square] = nil;
		--
		--debug highlight squares
		--if square and square:getFloor() then square:getFloor():setHighlighted(true); end;
		--
		sqX, sqY = square:getX(), square:getY();
		--
		if getDistance2D(plX, plY, sqX, sqY) < cellIconRadius then
			i = i + 1;
			if i > squareCheckRate then break; end;
			--
			--check if already activated a zone on this square
--			if not (zD and isInRect(sqX, sqY, zD.x1, zD.x2, zD.y1, zD.y2)) then
			if zoneData == nil or not forageSystem.zoneContains(zoneData, sqX, sqY, 0) then
				--activate zone and prepare to check sprites
				zoneData = self:getAndActivateZoneAtXY(sqX, sqY);
--				if zoneData then zD = zoneData.bounds; else zD = nil; end;
			end;
			--
			local doSpriteCheck = false;
			if self:isFinishedLoadingIcons() and (not square:HasTree()) then
				if zoneData and (not self.spriteCheckedSquares[square]) and (not self.movedIconsSquares[square]) then
					doSpriteCheck = true;
					self.spriteCheckedSquares[square] = true;
				end;
			end;
			--
			for object in iterList(square:getObjects()) do
				self:createIconsForContainers(square, object);
				--skip objects with attached data
				if doSpriteCheck and (not object:hasModData()) then
					doSpriteCheck = self:checkForSpriteAffinity(square, object, zoneData);
				end;
			end;
			self.checkedSquares[square] = true;
			self.movedIconsSquares[square] = true;
		end;
	end;
end

function ISSearchManager:createIconsForCell()
	-- look for new icons
	local cell = getCell();
	if (not cell) then return; end
	local square;
	local cellIconRadius = self.cellIconRadius;
	local plX, plY, plZ = self.character:getX(), self.character:getY(), self.character:getZ();
	--
	if self:isFinishedLoadingIcons() then
		for x = -cellIconRadius, cellIconRadius do
			for y = -cellIconRadius, cellIconRadius do
				square = cell:getGridSquare(plX + x, plY + y, plZ);
				if square then
					self:createIconsForWorldItems(square);
					if (not self.checkedSquares[square]) then
						self.squareStack[square] = true;
					end;
				end;
			end;
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:checkShouldForceIcon()
	if self.timeSinceFind < self.timeToMoveIcon then return; end;
	if self.distanceSinceFind < self.distanceMoveThreshold + self.distanceMoveExtra then return; end;
	if not self.currentZone then return; end;
	self:doMoveIconNearPlayer();
end

function ISSearchManager:getIsSeen(_icon)
	return self.seenIcons[_icon.iconID];
end

function ISSearchManager:spotIcon(_icon)
	self.seenIcons[_icon.iconID] = _icon.iconID;
	self.lastFoundX = _icon.xCoord;
	self.lastFoundY = _icon.yCoord;
	self:resetForceFindSystem();
	--
	if _icon.itemDef and (not self.xpIcons[_icon.iconID]) then
		forageSystem.giveItemXP(self.character, _icon.itemDef, 0.25);
		self.xpIcons[_icon.iconID] = _icon.iconID;
	end;
end

function ISSearchManager:updateForceFindSystem()
	self:updateTimestamp();
	--only move an icon if the player is in motion
	if self.character:isPlayerMoving() then
		local pX, pY = self.lastUpdateX, self.lastUpdateY;
		self.lastUpdateX, self.lastUpdateY = self.character:getX(), self.character:getY();
		--prevent player just walking in a circle to find stuff
		if getDistance2D(pX, pY, self.lastFoundX, self.lastFoundY) > self.distanceMoveThreshold + self.distanceMoveExtra then
			--increase distance moved tracker value
			self.distanceSinceFind = self.distanceSinceFind + getDistance2D(pX, pY, self.lastUpdateX, self.lastUpdateY);
			self:checkShouldForceIcon();
		end;
	end;
end

function ISSearchManager:resetForceFindSystem()
	self.timeDelta = 0;
	self.distanceSinceFind = 0;
	self.timeSinceFind = 0;
	--add some extra random distance and time
	self.distanceMoveExtra = ZombRand(20);
	self.timeToMoveIconExtra = ZombRand(30000);
	--slow down the icon moving for higher level, as it is less needed for skilled players
	self.timeToMoveIcon = self.timeToMoveIconMax - (self.perkLevel * self.reducedTimePerLevel) + self.timeToMoveIconExtra;
end

function ISSearchManager:doMoveIconNearPlayer()
	if not (self.currentZone and self.currentZone.bounds) then self:resetForceFindSystem(); return; end;
	local iconList = {};
	local insert = table.insert;
	local remove = table.remove;
	for iconID, icon in pairs(self.forageIcons) do
		--make sure it's not an activeIcon
		if not self.activeIcons[iconID] then
			--make sure it's from this zone and not seen before
			if icon.icon.zoneid == self.currentZone.id and (not icon:getIsSeen()) and (not icon:getIsNoticed()) then
				--make sure it's actually forageable
				if forageSystem.isForageable(self.character, icon.itemDef, self.currentZone) then
					insert(iconList, icon);
				end;
			end;
		end;
	end;
	if #iconList > 1 then
		local pickedIcon = iconList[ZombRand(#iconList) + 1];
		if pickedIcon then
			local squareList = {};
			local square;
			local plX, plY, plZ = self.character:getX(), self.character:getY(), self.character:getZ();
			--get zoneData boundaries to ensure icons are kept inside zone
			local zD = self.currentZone.bounds;
			local radius = math.min(self.radius, 3);
			for x = -radius, radius do
				for y = -radius, radius do
					--check is inside zone
--					if isInRect(plX + x, plY + y, zD.x1, zD.x2, zD.y1, zD.y2) then
					if forageSystem.zoneContains(self.currentZone, plX + x, plY + y, 0) then
						square = getCell():getGridSquare(plX + x, plY + y, plZ);
						if square and square:isCanSee(self.player) then
							insert(squareList, square);
						end;
					end;
				end;
			end;
			local pickedSquare;
			if #squareList > 1 then
				--pick a random square off the visible squares stack to move the icon
				pickedSquare = remove(squareList, ZombRand(#squareList) + 1);
				if pickedSquare and forageSystem.isValidSquare(pickedSquare, pickedIcon.itemDef, pickedIcon.catDef) then
					pickedIcon.isValidSquare = true;
					self:doMoveIcon(pickedIcon, pickedSquare:getX(), pickedSquare:getY(), pickedSquare:getZ());
					pickedIcon:doUpdateEvents(true);
					pickedIcon:removeFromUIManager();
					pickedIcon:addToUIManager();
					self.activeIcons[pickedIcon.iconID] = pickedIcon;
					pickedIcon:update();
					--prevent player just walking in a circle to find stuff
					self.lastFoundX, self.lastFoundY = pickedIcon.xCoord, pickedIcon.yCoord;
					--spot the icon for the player if they are struggling
					pickedIcon:spotIcon();
				end;
			end;
		end;
	end;
	--even if we fail to move an icon - reset the force find system and try again later
	self:resetForceFindSystem();
end

-------------------------------------------------
-------------------------------------------------
function ISSearchManager:doMoveIcon(_icon, _x, _y, _z)
	_icon:removeIsoMarker();
	_icon:removeWorldMarker();
	_icon.xCoord, _icon.yCoord, _icon.zCoord = _x, _y, _z;
	_icon.icon.x, _icon.icon.y, _icon.icon.z = _icon.xCoord, _icon.yCoord, _icon.zCoord;
	_icon:getGridSquare();
	triggerEvent("onUpdateIcon", _icon.zoneData, _icon.iconID, _icon);
end

function ISSearchManager:doChangePosition(_icon)
	while _icon and (not _icon.isValidSquare) do
		if (not _icon:getGridSquare()) then break; end;
		if forageSystem.isValidSquare(_icon.square, _icon.itemDef, _icon.catDef) then
			_icon.isValidSquare = true;
			break;
		else
			_icon.posChanges = _icon.posChanges + 1;
			if _icon.posChanges < _icon.maxPosChanges then
				local x, y = forageSystem.getZoneRandomCoord(_icon.zoneData);
				self:doMoveIcon(_icon, x, y, 0);
			else
				self:removeItem(_icon);
				self:removeIcon(_icon);
				break;
			end;
		end;
	end;
end

function ISSearchManager:checkActiveZones()
	local zD;
	local eW = self.activeIconRadius; --edge width
	local plX, plY = self.character:getX(), self.character:getY();
	--if the player is outside the zone plus the activeIconRadius then release the icons
	for iconID, icon in pairs(self.forageIcons) do
		local zoneData = self.activeZones[icon.icon.zoneid];
		if not zoneData then
			self:removeIcon(icon);
		else
--			zD = self.activeZones[icon.icon.zoneid].bounds;
--			if not isInRect(plX, plY, zD.x1 - eW, zD.x2 + eW, zD.y1 - eW, zD.y2 + eW) then
			if not forageSystem.zoneIntersects(zoneData, plX - eW, plY - eW, 0, eW * 2, eW * 2) then
				self:removeIcon(icon);
				self.activeZones[icon.icon.zoneid] = nil;
			end;
		end;
	end;
end

function ISSearchManager:checkCloseIcons()
	--wipe closeIcons table, used for radial menu pickup
	table.wipe(self.closeIcons);
	--update closeIcons table for the radial menu pickup option
	for iconID, icon in pairs(self.activeIcons) do
		if icon:isInRangeOfPlayer(5) and icon:getIsSeen() then self.closeIcons[iconID] = icon; end;
	end;
end

function ISSearchManager:checkWorldIcons()
	local UI = UIManager.getUI();
	if not UI then return; end;
	if self:getGameSpeed() ~= 1 then return; end;
	--
	local plX, plY = self.character:getX(), self.character:getY();
	local activeIconRadius = self.activeIconRadius;
	for iconID, icon in pairs(self.worldObjectIcons) do
		if getDistance2D(icon.xCoord, icon.yCoord, plX, plY) <= activeIconRadius then
			if not UI:contains(icon.javaObject) then
				icon:doUpdateEvents(true);
				icon:addToUIManager();
			end;
		else
			self:removeIcon(icon);
			icon:removeFromUIManager();
		end;
	end;
	--
	for iconID, icon in pairs(self.stashIcons) do
		if getDistance2D(icon.xCoord, icon.yCoord, plX, plY) <= activeIconRadius then
			if not UI:contains(icon.javaObject) then
				icon:doUpdateEvents(true);
				icon:addToUIManager();
			end;
		else
			self:removeIcon(icon);
			icon:removeFromUIManager();
		end;
	end;
end

function ISSearchManager:checkIcons()
	local UI = UIManager.getUI();
	if not UI then return; end;
	if self:getGameSpeed() ~= 1 then return; end;
	if (not self:isFinishedLoadingIcons()) then return; end;
	--
	local plX, plY = self.character:getX(), self.character:getY();
	local activeIconRadius = self.activeIconRadius;
	--
	for iconID, icon in pairs(self.forageIcons) do
		if icon.zoneData.forageIcons[iconID] then
			if getDistance2D(icon.xCoord, icon.yCoord, plX, plY) <= activeIconRadius then
				if not UI:contains(icon.javaObject) then
					icon:doUpdateEvents(true);
					icon:addToUIManager();
				end;
				self.activeIcons[iconID] = icon;
			else
				self.activeIcons[iconID] = nil;
				icon:removeFromUIManager();
			end;
		else
			self:removeIcon(icon);
		end;
	end;
end

function ISSearchManager:createIconsForZone(_zoneData, _recreate)
	local zoneData = _zoneData;
	local forageIcons = forageSystem.createForageIcons(zoneData, _recreate);
	--
	for _, icon in ipairs(forageIcons) do
		if (not self.iconStack[icon]) and (not self.forageIcons[icon.id]) then
			self.iconStack[icon] = zoneData;
			self.iconQueue = self.iconQueue + 1;
		end;
	end;
	--
	self.activeZones[zoneData.id] = zoneData;
end

function ISSearchManager:doChangeZone(_zoneData)
	if (not self.isSearchMode) then return; end;
	if _zoneData then
		if self.currentZoneName ~= _zoneData.name then
			self.currentZoneName = _zoneData.name;
			self.updateTick = 0;
		end;
	else
		self.currentZoneName = nil;
	end;
end

function ISSearchManager:getAndActivateZoneAtXY(_x, _y)
	local zoneData;
	local zD;
	local topZoneData = nil;
	--check if there is a zone here already loaded
	for activeZoneID, activeZoneData in pairs(self.activeZones) do
--		zD = activeZoneData.bounds;
--		if zD and isInRect(_x, _y, zD.x1, zD.x2, zD.y1, zD.y2) then
		if forageSystem.zoneContains(activeZoneData, _x, _y, 0) then
			if not topZoneData or getWorld():getMetaGrid():isZoneAbove(activeZoneData.metaZone, topZoneData.metaZone, _x, _y, 0) then
				topZoneData = activeZoneData;
			end
		end;
	end;
	if topZoneData then
		return topZoneData;
	end
	--
	if (not zoneData) then zoneData = forageSystem.getForageZoneAt(_x, _y); end;
	--
	if zoneData and (not self.activeZones[zoneData.id]) then
		self:createIconsForZone(zoneData);
	end;
	--
	return zoneData;
end

function ISSearchManager:updateCurrentZone()
	local zoneData = self:getAndActivateZoneAtXY(self.character:getX(), self.character:getY());
	self:doChangeZone(zoneData);
	self.currentZone = zoneData;
end

function ISSearchManager:isFinishedLoadingIcons()
	return self.iconQueue == 0;
end

function ISSearchManager:loadIcons()
	local i = 0;
	local iconLoadRate = self.iconLoadRate;
	for icon, zoneData in pairs(self.iconStack) do
		if icon ~= nil and zoneData ~= nil then
			if (not self.forageIcons[icon.id]) and zoneData.forageIcons[icon.id] then
				i = i + 1;
				if i > iconLoadRate then break; end;
				self.iconQueue = self.iconQueue - 1;
				self.forageIcons[icon.id] = ISForageIcon:new(self, icon, zoneData);
			end;
		end;
		self.iconStack[icon] = nil;
	end;
	--
	local j = 0;
	for iconID, icon in pairs(self.worldIconStack) do
		if (not self.worldObjectIcons[icon.id]) then
			j = j + 1;
			if j > iconLoadRate then break; end;
			self.worldObjectIcons[iconID] = ISWorldItemIcon:new(self, icon);
			self.worldObjectIcons[iconID].iconClass = "worldObject";
			if self.worldObjectIcons[iconID] then self.worldObjectIcons[iconID]:findTextureCenter(); end;
		end;
		self.worldIconStack[iconID] = nil;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:updateModifiers()
	local character			= self.character;
	--
	self.perkLevel			= self.character:getPerkLevel(Perks.PlantScavenging);
	self.square				= self.character:getCurrentSquare();
	--
	self.modifiers = {
		aimBonus			= math.max(forageSystem.getAimVisionBonus(character) * self.aimMulti, 1),
		sneakBonus			= math.max(forageSystem.getSneakVisionBonus(character) * self.sneakMulti, 1),
		traitBonus			= forageSystem.getTraitVisionBonus(character),
		professionBonus		= forageSystem.getProfessionVisionBonus(character),
		panicPenalty		= forageSystem.getPanicPenalty(character),
		bodyPenalty			= forageSystem.getBodyPenalty(character),
		exhaustionPenalty	= forageSystem.getExhaustionPenalty(character),
		clothingPenalty		= forageSystem.getClothingPenalty(character),
		weatherPenalty		= forageSystem.getWeatherPenalty(character, self.square),
		movementPenalty		= forageSystem.getMovementVisionPenalty(character),
		lightPenalty		= forageSystem.getLightLevelPenalty(character, self.square, true),
	};
end

function ISSearchManager:getOverlayRadius()
	self:updateModifiers();
	--
	local modifiers			= self.modifiers;
	-- skill bonuses
	local traitBonus        = modifiers.traitBonus;
	local professionBonus   = modifiers.professionBonus;
	-- overlay minimum maximum radius settings
	local minRadius         = self.minRadius + professionBonus + traitBonus;
	local maxRadius         = self.maxRadius + professionBonus + traitBonus;
	local maxRadiusCap      = self.maxRadiusCap;
	-- begin calculations
	local levelRadius       = (maxRadius - minRadius) * (self.perkLevel / 10);
	local overlayRadius     = clamp(minRadius + levelRadius, minRadius, maxRadius);
	-- apply penalties
	local penalties = {
		panic 				= modifiers.panicPenalty,
		body				= modifiers.bodyPenalty,
		exhaustion			= modifiers.exhaustionPenalty,
		clothing			= modifiers.clothingPenalty,
		weather 			= modifiers.weatherPenalty,
		movement 			= modifiers.movementPenalty,
	};
	--
	for _, modifier in pairs(penalties) do overlayRadius = overlayRadius * modifier; end;
	--only the highest modifier applies for aim or sneak
	local visionBonus 		= math.max(modifiers.aimBonus, modifiers.sneakBonus);
	--
	overlayRadius 			= overlayRadius * visionBonus;
	maxRadius 				= maxRadius * visionBonus;
	minRadius 				= minRadius * visionBonus;
	maxRadius 				= math.min(maxRadius, maxRadiusCap);
	--
	overlayRadius 			= overlayRadius * modifiers.lightPenalty;
	--
	return clamp(overlayRadius, self.minRadius, maxRadius);
end

function ISSearchManager:updateOverlay()
	--
	local blur = 0;
	local desaturation = 0;
	--
	local overlayEffectOption = getCore():getOptionSearchModeOverlayEffect();
	if overlayEffectOption == 1 or overlayEffectOption == 2 then
		blur = 0.5;
	end;
	if overlayEffectOption == 1 or overlayEffectOption == 3 then
		desaturation = 0.5;
	end;
	--
	local panicLevel = math.min(1 - forageSystem.getPanicPenalty(self.character), 0.5);
	local exhaustionLevel = math.min(1 - forageSystem.getExhaustionPenalty(self.character), 0.5);
	local darkLevel = 1 - forageSystem.getLightLevelPenalty(self.character, self.square, false);
	--use the highest value, and ensure there is always a slight border with 0.1 dark
	local darkness = math.max(math.max(panicLevel, exhaustionLevel, darkLevel), 0.1);
	--
	local radius = self:getOverlayRadius();
	--
	local sm = self.searchModeOverlay;
	sm:getBlur():setTargets(blur, blur);
	sm:getDesat():setTargets(desaturation, desaturation);
	sm:getRadius():setTargets(radius, radius);
	sm:getDarkness():setTargets(darkness, darkness);
	sm:getGradientWidth():setTargets(2, 2);
	--
	self.overlayValues.blur = blur;
	self.overlayValues.desaturation = desaturation;
	self.overlayValues.darkness = darkness;
	self.radius = radius;
	--
	getSearchMode():setEnabled(self.player, self.isSearchMode or self.isEffectOverlay);
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:checkShouldDisable()
	if ISSearchManager.showDebug then return false; end;
	local plStats = self.character:getStats();
	if plStats then
		if (plStats:getNumVeryCloseZombies() > 0) then return true; end;
		if (plStats:getNumVisibleZombies() >=3) and (plStats:getNumChasingZombies() >=3) then return true; end;
	end;
	if (self.character:isRunning() or self.character:isSprinting() and self.character:isJustMoved()) then
		return true;
	end;
	return false;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:getGameSpeed()
	if UIManager and UIManager.getSpeedControls then
		return UIManager.getSpeedControls():getCurrentGameSpeed();
	end;
	return 1;
end

function ISSearchManager:checkMarkers()
	local forceRemove = false;
	if (not self.isSearchMode) then forceRemove = true; end;
	if self:getGameSpeed() ~= 1 then forceRemove = true; end;
	--
	for iconID, debugMarker in pairs(self.debugMarkers) do
		if forceRemove or (not self.activeIcons[iconID]) or (not ISSearchManager.showDebug) or (not ISSearchManager.showDebugVisionRadius) then
			debugMarker:remove();
			self.debugMarkers[iconID] = nil;
		end;
	end;
	for iconID, debugArrow in pairs(self.debugArrows) do
		if forceRemove or (not self.forageIcons[iconID]) or (not ISSearchManager.showDebug) or (not ISSearchManager.showDebugLocations) then
			debugArrow:remove();
			self.debugArrows[iconID] = nil;
		end;
	end;
	for iconID, isoMarker in pairs(self.isoMarkers) do
		if (not self.forageIcons[iconID]) then
			isoMarker:remove();
			if self.forageIcons[iconID] then self.forageIcons[iconID].isoMarker = nil; end;
			self.isoMarkers[iconID] = nil;
		end;
	end;
	for iconID, worldMarker in pairs(self.worldMarkers) do
		if (not (self.forageIcons[iconID] or self.worldObjectIcons[iconID])) then
			worldMarker:remove();
			if self.forageIcons[iconID] then self.forageIcons[iconID].worldMarker = nil; end;
			self.worldMarkers[iconID] = nil;
		end;
	end;
end

function ISSearchManager:resetVisionBonuses()
	self.aimMulti              = 0;
	self.aimBonusTick          = 0;
	self.sneakMulti            = 0;
	self.sneakBonusTick        = 0;
end

function ISSearchManager:updateVisionBonuses()
	local aimBonusTick = -1;
	local sneakBonusTick = -1;
	if self.character:isAiming() then aimBonusTick = 1; end;
	if self.character:isSneaking() then sneakBonusTick = 1; end;
	self.aimBonusTick = clamp(self.aimBonusTick + aimBonusTick, 0, self.aimBonusTickMax);
	self.sneakBonusTick = clamp(self.sneakBonusTick + sneakBonusTick, 0, self.sneakBonusTickMax);

	self.aimMulti = self.aimBonusTick / self.aimBonusTickMax;
	self.sneakMulti = self.sneakBonusTick / self.sneakBonusTickMax;
end

function ISSearchManager:updateAlpha()
	self:setAlpha(clamp(self:getAlpha() - self.alphaStep, self.minAlpha, 1));
end

function ISSearchManager:doDisableCheck()
	if self.character:getVehicle() then self:toggleSearchMode(false); return; end;
	local disableTick = -1;
	if self:checkShouldDisable() then disableTick = 1; end;
	self.disableTick = clamp(self.disableTick + disableTick, 0, self.disableTickMax);
	if self.disableTick >= self.disableTickMax then self:toggleSearchMode(false); end;
end

function ISSearchManager:doUpdateEvents(_force)
	self.updateTick = self.updateTick + 1;
	--
	for i, event in ipairs(self.updateEvents) do
		if (_force or self.updateTick % event.tick == 0) and self[event.method] then
			self[event.method](self);
			if event.breakTick then break; end;
		end;
	end;
	--
	if self.updateTick > self.updateTickMax then self.updateTick = 0; end;
end

function ISSearchManager:update()
	self:displayHaloNotes();
	self:updateAlpha();
	self:updateVisionBonuses();
	self:updateOverlay();
	--
	if (not self.isSearchMode) then return; end;
	if self:getGameSpeed() == 0 then return; end;
	--
	self:doDisableCheck();
	self:checkMarkers();
	self:createIconsForCell();
	self:doUpdateEvents();
	self:loadIcons();
	--
	self.isSpotting = false;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:initialise()
	ISPanel.initialise(self);
	self:setVisible(false);
	self:bringToTop();
	self:update();
	self:setFollowGameWorld(true);
	self:setRenderThisPlayerOnly(self.player);
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:new(_character)
	local o = {};
	local w, h = eyeTex.eyeconOn:getWidth(), eyeTex.eyeconOn:getHeight();
	o = ISPanel:new(0, 0, 0, 0);
	setmetatable(o, self)
	self.__index      = self;
	o.baseWidth     		= w;
	o.baseHeight    		= h;
	o.textureWidth     		= w;
	o.textureHeight    		= h;
	o.width          		= 0;
	o.height         		= 0;

	o.texture         		= eyeTex.eyeconOn;
	o.textureColor    		= { r = 1, g = 1, b = 1, a = 0 };

	o.alphaStep				= 0.05;
	o.minAlpha				= 0;	 --minimum alpha value (debug)
	o.activeAlpha			= 0;	 --mode is active
	o.spotAlpha				= 0.33;  --something is in view not center view

	o.character       		= _character;
	o.player          		= _character:getPlayerNum();
	o.square				= _character:getCurrentSquare();
	o.cell            		= _character:getCell();
	o.perkLevel				= _character:getPerkLevel(Perks.PlantScavenging);

	o.isSearchMode    		= false;
	o.isEffectOverlay   	= false;
	o.isSpotting      		= false;

	o.haloNotes       		= {};

	o.iconCategories		= {
		forageIcons			= "forageIcons",
		activeIcons 		= "activeIcons",
		closeIcons 			= "closeIcons",
		worldObjectIcons	= "worldObjectIcons",
		stashIcons 			= "stashIcons",
	};

	o.forageIcons			= {};
	o.activeIcons			= {};

	o.closeIcons			= {};

	o.worldObjectIcons		= {};
	o.stashIcons			= {};

	o.seenIcons				= {};
	o.xpIcons				= {};

	o.iconStack				= {};
	o.iconQueue				= 0;
	o.worldIconStack		= {};

	--activating icons
	o.iconLoadRate			= 100;
	o.activeIconRadius		= 20;
	o.cellIconRadius		= 8;

	--zone data
	o.activeZones			= {};
	o.activeZoneRadius		= 10;
	o.currentZoneName		= nil;
	o.currentZone			= nil;

	o.updateTick			= 0;
	o.updateTickMax			= 200;
	o.updateEvents			= ISSearchManager.updateEvents;

	o.disableTick			= 0;
	o.disableTickMax		= 15;

	--force find system
	o.currentTimestamp		= getTimestampMs();
	o.lastTimestamp			= 0;
	o.timeDelta				= 0;
	o.timeSinceFind			= 0;
	o.timeToMoveIcon		= 30000;
	o.timeToMoveIconMax		= 30000;
	o.timeToMoveIconExtra	= 1000;
	o.reducedTimePerLevel	= -1500;
	o.distanceMoveExtra		= 10;
	o.distanceMoveThreshold	= 10;

	o.lastUpdateX			= _character:getX();
	o.lastUpdateY			= _character:getY();
	o.distanceSinceFind		= 0;
	o.lastFoundX			= 0;
	o.lastFoundY			= 0;

	--sprite affinity
	o.movedIcons			= {};
	o.movedIconsSquares		= {};
	o.checkedSquares		= {};
	o.spriteCheckedSquares	= {};
	o.squareStack			= {};
	o.squareCheckRate		= 100;
	o.spriteAffinities      = forageSystem.spriteAffinities;

	--overlay
	o.searchModeOverlay		= getSearchMode():getSearchModeForPlayer(o.player);
	o.radius				= 0;
	o.minRadius             = forageSystem.minVisionRadius;
	o.maxRadius             = forageSystem.maxVisionRadius;
	o.maxRadiusCap          = forageSystem.visionRadiusCap;
	o.overlayValues			= {
		blur				= 0,
		desaturation		= 0,
		darkness			= 0,
	};
	o.effectOverlayValues	= {
		blur				= 0,
		desaturation		= 0,
		darkness			= 0,
	};

	o.stashTypes			= ISSearchManager.stashTypes;

	o.ignoredItemTypes      = ISSearchManager.ignoredItemTypes;

	o.ignoredItemCategories = {};

	o.zoom                  = 1;

	o.isoMarkers            = {};
	o.worldMarkers          = {};
	o.debugMarkers          = {};
	o.debugArrows           = {};

	--tracker for bonus and delay before aim multi takes effect
	o.aimMulti              = 0;
	o.aimBonusTick          = 0;
	o.aimBonusTickMax       = 10;

	--tracker for bonus and delay before sneak multi takes effect
	o.sneakMulti            = 0;
	o.sneakBonusTick        = 0;
	o.sneakBonusTickMax     = 10;

	o.visibleTarget			= o;
	o.visibleFunction		= ISSearchManager.onToggleVisible;

	o:initialise();
	return o;
end
-------------------------------------------------
-------------------------------------------------
function ISSearchManager.createUI(_player)
	local character = getSpecificPlayer(_player);
	if not ISSearchManager.players[character] then
		ISSearchManager.setManager(character, ISSearchManager:new(character));
	end;
	print("[ISSearchManager] created UI for player " .. _player);
end

function ISSearchManager.destroyUI(_character)
	local manager = ISSearchManager.players[_character];
	getSearchMode():setEnabled(_character:getPlayerNum(), false);
	if manager then
		manager.isSearchMode = false;
		manager:reset();
		manager:removeFromUIManager();
		ISSearchManager.players[_character] = nil;
	end;
	print("[ISSearchManager] removed UI for player " .. _character:getPlayerNum());
end

Events.OnCreatePlayer.Add(ISSearchManager.createUI);
Events.OnPlayerDeath.Add(ISSearchManager.destroyUI);
-------------------------------------------------
-------------------------------------------------
function ISSearchManager:toggleSearchMode(_isSearchMode)
	self.updateTick = 0;
	--prevent search mode toggle in tutorial
	if "Tutorial" == getCore():getGameMode() then return; end;

	if type(_isSearchMode) == "boolean" then
		self.isSearchMode = _isSearchMode;
	else
		self.isSearchMode = not self.isSearchMode;
	end;

	--prevent enabling when doing an action which disables the mode (e.g. sprinting, driving)
	if self:checkShouldDisable() then self.isSearchMode = false; end;

	--toggle isSearchMode
	if self.isSearchMode then
		self:update();
		self:doUpdateEvents(true);
		triggerEvent("onEnableSearchMode", self.character, self.isSearchMode);
	else
		self.minAlpha = 0;
		self:reset();
		self:setAlpha(0);
		triggerEvent("onDisableSearchMode", self.character, self.isSearchMode);
	end;

	triggerEvent("onToggleSearchMode", self.character, self.isSearchMode);
	self:setVisible(self.isSearchMode);
end

function ISSearchManager.handleKeyPressed(_keyPressed)
	if isGamePaused() then return end
	if _keyPressed == getCore():getKey("Toggle Search Mode") then
		local manager = ISSearchManager.getManager(getSpecificPlayer(0));
		if manager then
			manager:toggleSearchMode();
			manager:bringToTop();
		end;
	end;
end

function ISSearchManager.initBinds()
	table.insert(keyBinding, { value = "[Search Mode]" } );
	table.insert(keyBinding, { value = "Toggle Search Mode", key = 207 } );
end

function ISSearchManager.OnGameStart()
	Events.OnKeyPressed.Add(ISSearchManager.handleKeyPressed);
end

Events.OnGameBoot.Add(ISSearchManager.initBinds);
Events.OnGameStart.Add(ISSearchManager.OnGameStart);
-------------------------------------------------
-------------------------------------------------
function ISSearchManager.onUpdateIcon(_zoneData, _iconID, _icon)
	for _, manager in pairs(ISSearchManager.players) do
		if _icon then
			table.wipe(manager.iconStack);
			table.wipe(manager.closeIcons);
			table.wipe(manager.activeZones);
			manager.iconQueue = 0;
			if manager.forageIcons[_iconID] then
				manager.forageIcons[_iconID]:removeIsoMarker();
				manager.forageIcons[_iconID]:removeWorldMarker();
				manager.forageIcons[_iconID].xCoord				= _icon.xCoord;
				manager.forageIcons[_iconID].yCoord				= _icon.yCoord;
				manager.forageIcons[_iconID].icon.x				= _icon.xCoord;
				manager.forageIcons[_iconID].icon.y				= _icon.yCoord;
				manager.forageIcons[_iconID].itemDef			= _icon.itemDef;
				manager.forageIcons[_iconID].catDef				= _icon.catDef;
				manager.forageIcons[_iconID].itemType			= _icon.itemType;
				manager.forageIcons[_iconID].icon.itemType		= _icon.itemType;
				manager.forageIcons[_iconID].icon.catName		= _icon.catDef.name;
				manager.forageIcons[_iconID].itemObj			= InventoryItemFactory.CreateItem(_icon.itemType);
				manager.forageIcons[_iconID].itemTexture		= _icon.itemObj:getTexture();
				manager.forageIcons[_iconID].isMover			= _icon.isMover or false;
				manager.forageIcons[_iconID].altWorldTexture	= _icon.altWorldTexture;
				manager.forageIcons[_iconID].render3DTexture	= _icon.render3DTexture;
				if _icon.itemDef then
					manager.forageIcons[_iconID].itemSize		= _icon.itemDef.itemSize or 1.0;
				end;
			end;
			manager.activeIcons[_iconID] = nil;
			_zoneData.forageIcons[_iconID] = _icon.icon;
		else
			table.wipe(manager.iconStack);
			table.wipe(manager.closeIcons);
			table.wipe(manager.activeZones);
			manager.iconQueue = 0;
			if manager.forageIcons[_iconID] then
				manager.forageIcons[_iconID]:reset();
				manager.forageIcons[_iconID]:removeIsoMarker();
				manager.forageIcons[_iconID]:removeWorldMarker();
				manager:removeIcon(manager.forageIcons[_iconID]);
			end;
			_zoneData.forageIcons[_iconID] = nil;
		end;
	end;
end

Events.onUpdateIcon.Add(ISSearchManager.onUpdateIcon);
-------------------------------------------------
-------------------------------------------------
function ISSearchManager.OnFillWorldObjectContextMenu(_player, _context, _worldObjects)
	if not _player and _context then return; end;
	local character = getSpecificPlayer(_player);
	local plX = math.floor(character:getX());
	local plY = math.floor(character:getY());
	local clickedX = screenToIsoX(_player, _context.x, _context.y, character:getZ());
	local clickedY = screenToIsoY(_player, _context.x, _context.y, character:getZ());
	local manager = ISSearchManager.getManager(character);
	local clickedSquareTable = {};
	for x = -1, 1 do
		for y = -1, 1 do
			local square = getCell():getGridSquare(clickedX + x, clickedY + y, character:getZ());
			if square then clickedSquareTable[square] = true; end;
		end;
	end;
	for x = -1, 1 do
		for y = -1, 1 do
			local square = getCell():getGridSquare(plX + x, plY + y, character:getZ());
			if square then clickedSquareTable[square] = true; end;
		end;
	end;
	for iconID, icon in pairs(manager.activeIcons) do
		if (clickedSquareTable[icon.square]) and icon:getIsSeen() then
			icon:doContextMenu(_context);
		end;
	end;
end

Events.OnFillWorldObjectContextMenu.Add(ISSearchManager.OnFillWorldObjectContextMenu);
-------------------------------------------------
-------------------------------------------------
