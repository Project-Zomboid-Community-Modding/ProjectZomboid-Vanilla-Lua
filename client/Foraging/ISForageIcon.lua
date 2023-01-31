--[[---------------------------------------------
-------------------------------------------------
--
-- ISForageIcon
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------
require "Foraging/forageSystem";
require "ISUI/ISPanel";
require "Foraging/ISBaseIcon";
ISForageIcon = ISBaseIcon:derive("ISForageIcon");
-------------------------------------------------
-------------------------------------------------
function ISForageIcon:onRightMouseUp()		return self:doContextMenu();							end;
function ISForageIcon:onRightMouseDown()	return (self:getIsSeen() and self:getAlpha() > 0);		end;
-------------------------------------------------
-------------------------------------------------
function ISForageIcon:onClickDiscard(_x, _y, _contextOption)
	if _contextOption then _contextOption:hideAndChildren(); end;
	local targetSquare = getCell():getGridSquare(self.xCoord, self.yCoord, self.zCoord);
	if not targetSquare then return; end;
	--
	ISTimedActionQueue.add(ISForageAction:new(self, self.character:getInventory(), true));
end

function ISForageIcon:doForage(_x, _y, _contextOption, _targetContainer)
	if _contextOption then _contextOption:hideAndChildren(); end;
	local targetSquare = getCell():getGridSquare(self.xCoord, self.yCoord, self.zCoord);
	if not targetSquare then return; end;
	--
	--double clicking sends item to currently selected inventory in panel
	local targetContainer = _targetContainer or getPlayerInventory(self.player).inventory or self.character:getInventory();
	if targetContainer:isItemAllowed(self.itemObj) then
		if targetContainer and targetSquare and luautils.walkAdj(self.character, targetSquare) then
			ISTimedActionQueue.add(ISForageAction:new(self, targetContainer, false));
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISForageIcon:getNewCategoryItem(_catDef, _zoneData)
	local perkLevel = self.character:getPerkLevel(Perks.FromString(_catDef.identifyCategoryPerk));
	if perkLevel < _catDef.identifyCategoryLevel then return; end;
	--roll for a chance to convert this item into one from the selected focus category
	local chanceRoll = _catDef.focusChanceMin + (math.abs(_catDef.focusChanceMax - _catDef.focusChanceMin) / math.max(10 - perkLevel, 1));
	if ZombRandFloat(0.0, 100.0) < chanceRoll then
		--create a loot table
		local possibleItemTypes = {};
		for itemType, itemDef in pairs(forageSystem.itemDefs) do
			if forageSystem.isForageable(self.character, self.itemDef, self.zoneData) then
				for _, catName in ipairs(itemDef.categories) do
					if (catName == _catDef.name) and forageSystem.isValidMonth(nil, itemDef) then
						if self.square and forageSystem.isValidSquare(self.square, itemDef, _catDef) then
							if itemDef.zones[_zoneData.name] then
								--just using the base chance for the items in this zone
								for i = 1, itemDef.zones[_zoneData.name] do
									table.insert(possibleItemTypes, itemDef);
								end;
								break;
							end;
						end;
					end;
				end;
			end;
		end;
		--pick an item type
		local pickedItemType;
		if #possibleItemTypes > 0 then
			pickedItemType = possibleItemTypes[ZombRand(#possibleItemTypes) + 1];
		end;
		--convert icon to new type
		if pickedItemType then
			self.itemDef					= pickedItemType;
			self.catDef						= _catDef;
			self.itemSize					= self.itemDef.itemSize or 1.0;
			self.itemType					= pickedItemType.type;
			self.altWorldTexture			= self.itemDef.altWorldTexture;
			self.render3DTexture			= self.itemDef.render3DTexture;
			self.isMover					= self.itemDef.isMover or false;
			self.icon.itemType				= self.itemType;
			self.itemObj					= InventoryItemFactory.CreateItem(self.icon.itemType);
			self.itemTexture				= self.itemObj:getTexture();
			self:initialise();
			ISSearchManager.iconItems[self.iconID] = nil;
			if self.itemList then
				self.itemList = nil;
				self:getItemList();
			end
		end;
	end;
end

function ISForageIcon:doSearchFocusCheck()
	--only roll valid icons
	if not (self.catDef and self.catDef.focusChanceMin and self.catDef.focusChanceMax and self.zoneData) then
		return;
	end;

	--don't roll more than once
	if not self.canRollForSearchFocus then return; end;

	--don't attempt with hidden categories (these are rarer items)
	if self.catDef.categoryHidden then return; end;

	local searchWindow = ISSearchWindow.players[self.character];
	if searchWindow and searchWindow.searchFocusCategory then
		if not forageSystem.catDefs[searchWindow.searchFocusCategory] then return; end;
		if self.catDef.name ~= searchWindow.searchFocusCategory then
			self:getNewCategoryItem(forageSystem.catDefs[searchWindow.searchFocusCategory], self.zoneData);
		end;
	end;

	--prevent rolling this icon for search focus ever again (saved to the zoneData)
	self.canRollForSearchFocus			= false;
	self.icon.canRollForSearchFocus		= false;

	--update icon for split screen players
	triggerEvent("onUpdateIcon", self.zoneData, self.iconID, self);
end
-------------------------------------------------
-------------------------------------------------
function ISForageIcon:updatePinIconPosition()
	self:updateZoom();
	self:updateAlpha();
	local dx, dy = self:getScreenDelta();
	self:setX(isoToScreenX(self.player, self.xCoord, self.yCoord, self.zCoord) + dx - self.width / 2);
	self:setY(isoToScreenY(self.player, self.xCoord, self.yCoord, self.zCoord) + dy + (self.pinOffset / self.zoom));
	self:setY(self.y - (30 / self.zoom) - (self.height) + (math.sin(self.bounceStep) * self.bounceHeight));
end
-------------------------------------------------
-------------------------------------------------
function ISForageIcon:checkIsForageable()
	self.isForageable = forageSystem.isForageable(self.character, self.itemDef, self.zoneDef);
	return self.isForageable;
end

function ISForageIcon:checkIsIdentified()
	local perkLevel = self.character:getPerkLevel(Perks.FromString(self.catDef.identifyCategoryPerk));
	if (self.distanceToPlayer <= self.onSquareDistance) or (perkLevel >= self.catDef.identifyCategoryLevel) then
		self.identified = true;
	else
		self.identified = (self.distanceToPlayer <= self.identifyDistance);
	end;
end

function ISForageIcon:initialise()
	ISBaseIcon.initialise(self);
	self.perkLevel = forageSystem.getPerkLevel(self.character, self.itemDef);
	self:checkIsIdentified();
	--
	if self.render3DTexture then
		self.renderWorldIcon = self.render3DItem;
	elseif self.altWorldTexture then
		self.renderWorldIcon = self.renderAltWorldTexture;
		self:initAltTexture();
	elseif self.itemTexture then
		self.renderWorldIcon = self.renderWorldItemTexture;
	end;
	--
	self:findTextureCenter();
	self:findPinOffset();
	self:initItemCount();
end
-------------------------------------------------
-------------------------------------------------
function ISForageIcon:new(_manager, _forageIcon, _zoneData)
	local o = {};
	o = ISBaseIcon:new(_manager, _forageIcon, _zoneData);
	setmetatable(o, self)
	self.__index = self;
	o.zoneData					= _zoneData;
	o.zoneDef					= forageSystem.zoneDefs[_zoneData.name];
	o.catDef					= forageSystem.catDefs[_forageIcon.catName];
	o.itemDef					= forageSystem.itemDefs[_forageIcon.itemType];
	o.itemSize					= (o.itemDef and o.itemDef.itemSize) or 1.0;
	o.onMouseDoubleClick		= ISForageIcon.doForage;
	o.identifyDistance			= 0;
	o.altWorldTexture			= o.itemDef.altWorldTexture;
	o.render3DTexture			= o.itemDef.render3DTexture;
	o.textureCenter				= 0;
	o.isMover					= o.itemDef.isMover or false;
	o.onClickContext			= ISForageIcon.doForage;
	o.identified				= false;
	o.canMoveVertical			= true;
	o.iconClass					= "forageIcon";
	o.canRollForSearchFocus		= _forageIcon.canRollForSearchFocus or true;
	o:initialise();
	return o;
end
-------------------------------------------------
-------------------------------------------------
