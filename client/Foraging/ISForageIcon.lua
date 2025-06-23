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
	local itemTypeList = {}
	ISTimedActionQueue.add(ISForageAction:new(self.character, self.iconID, itemTypeList, self.character:getInventory(), true, self.itemType));
end

function ISForageIcon:doForage(_x, _y, _contextOption, _targetContainer)
	if _contextOption then _contextOption:hideAndChildren(); end;
	local targetSquare = getCell():getGridSquare(self.xCoord, self.yCoord, self.zCoord);
	if not targetSquare then return; end;
	--
	--double clicking sends item to currently selected inventory in panel
	if self:getIsSeen() and self:getAlpha() > 0 then
		local targetContainer = _targetContainer or getPlayerInventory(self.player).inventory or self.character:getInventory();
		if targetContainer:isItemAllowed(self.itemObj) then
			if targetContainer and targetSquare and luautils.walkAdj(self.character, targetSquare) then
			    local itemTypeList = {}
			    for i = 0, self.itemList:size() - 1 do
			        table.insert(itemTypeList, self.itemList:get(i):getType());
                end;
				ISTimedActionQueue.add(ISForageAction:new(self.character, self.iconID, itemTypeList, targetContainer, false, self.itemType));
			end;
		end;
	else
		return false;
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
		local pickedItemType = forageSystem.pickRandomItemType(_zoneData.name, _catDef.name);
		local itemDef = forageSystem.itemDefs[pickedItemType];
		--convert icon to new type
		if itemDef and itemDef.type then
			local itemObj = instanceItem(itemDef.type);
			if itemObj then
				self.itemDef					= itemDef;
				self.catDef						= _catDef;
				self.itemSize					= self.itemDef.itemSize or 1.0;
				self.itemType					= itemDef.type;
				self.icon.itemType				= itemDef.type;
				self.altWorldTexture			= itemDef.altWorldTexture;
				self.render3DTexture			= itemDef.render3DTexture;
				self.isMover					= itemDef.isMover or false;
				self.itemObj					= itemObj;
				self.itemList					= nil;
				self.icon.itemList				= nil;
				self.itemTexture				= itemObj:getTexture();
				self:initialise();
				self.itemList = nil;
				self:getItemList();
				return true;
			end;
		end;
	end;
	return false;
end

function ISForageIcon:doSearchFocusCheck()
	--only roll valid icons
	if not (self.catDef and self.zoneData and self.itemObj) then
		print("[ISForageIcon][doSearchFocusCheck] icon: " .. self.itemType .. " failed test, skipping. " .. self.iconID);
		return;
	end;

	--don't roll more than once
	if not self.canRollForSearchFocus then return; end;

	local searchWindow = ISSearchWindow.players[self.character];

	local iconNeedsUpdate = false;

	if searchWindow and searchWindow.searchFocusCategory then
		if self.catDef.name ~= searchWindow.searchFocusCategory then
			local catDef = forageSystem.catDefs[searchWindow.searchFocusCategory];
			if not catDef then return; end;
			iconNeedsUpdate = self:getNewCategoryItem(catDef, self.zoneData);
		end;
	end;

	--prevent rolling this icon for search focus ever again (saved to the zoneData)
	self.canRollForSearchFocus			= false;
	self.icon.canRollForSearchFocus		= false;

	--update icon for all split screen players
	if iconNeedsUpdate then
		triggerEvent("onUpdateIcon", self.zoneData, self.iconID, self);
	end;
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
	if self.altWorldTexture then
		self.renderWorldIcon = self.renderAltWorldTexture;
		self:initAltTexture();
	elseif self.render3DTexture then
		self.renderWorldIcon = self.render3DItem;
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
	local forageIcon = _forageIcon;
	local zoneData = _zoneData;
	local o = {};
	o = ISBaseIcon:new(_manager, forageIcon, zoneData);
	setmetatable(o, self)
	self.__index				= self;
	o.zoneData					= zoneData;
	o.zoneDef					= forageSystem.zoneDefs[zoneData.name];
	o.catDef					= forageSystem.catDefs[forageIcon.catName];
	o.itemDef					= forageSystem.itemDefs[forageIcon.itemType];
	o.itemType					= forageIcon.itemType;
	o.itemObj					= forageIcon.itemObj or instanceItem(forageIcon.itemType);
	o.itemList					= forageIcon.itemList;
	o.itemTexture				= o.itemObj:getTexture();
	o.itemSize					= (o.itemDef and o.itemDef.itemSize) or 1.0;
	o.onMouseDoubleClick		= ISForageIcon.doForage;
	o.identifyDistance			= 0;
	o.altWorldTexture			= o.itemDef.altWorldTexture;
	o.render3DTexture			= o.itemDef.render3DTexture;
	o.textureCenter				= 0;
	o.onClickContext			= ISForageIcon.doForage;
	o.identified				= false;
	o.canMoveVertical			= true;
	o.iconClass					= "forageIcon";
	o.itemRotation				= forageIcon.itemRotation or ZombRand(360);
	--
	forageIcon.itemObj			= o.itemObj;
	forageIcon.itemRotation     = o.itemRotation;
	--
	if type(forageIcon.canRollForSearchFocus) == "boolean" then
		o.canRollForSearchFocus				= forageIcon.canRollForSearchFocus;
	else
		o.canRollForSearchFocus				= true;
		forageIcon.canRollForSearchFocus	= true;
	end;
	o:initialise();
	return o;
end
-------------------------------------------------
-------------------------------------------------
