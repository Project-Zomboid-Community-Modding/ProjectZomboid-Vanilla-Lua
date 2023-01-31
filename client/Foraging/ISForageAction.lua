--[[---------------------------------------------
-------------------------------------------------
--
-- ISForageAction
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------
require "Foraging/forageSystem";
require "TimedActions/ISBaseTimedAction";
ISForageAction = ISBaseTimedAction:derive("ISForageAction");
-------------------------------------------------
-------------------------------------------------
function ISForageAction:isValid()
	if not (self.manager and self.manager.forageIcons[self.forageIcon.iconID]) then return false; end;
	if not self.forageIcon.square and self.character:getSquare() then return false; end;
	if self.forageIcon.square:isBlockedTo(self.character:getSquare()) then return false; end;
	return true;
end
-------------------------------------------------
-------------------------------------------------
function ISForageAction:waitToStart()
	if not self.discardItems then
		self.character:faceLocation(self.forageIcon.square:getX(), self.forageIcon.square:getY())
	end
	return self.character:shouldBeTurning()
end
-------------------------------------------------
-------------------------------------------------
function ISForageAction:update()
	if not self.discardItems then
		self.character:faceLocation(self.forageIcon.square:getX(), self.forageIcon.square:getY())
	end
	self.character:setMetabolicTarget(Metabolics.LightWork);
end
-------------------------------------------------
-------------------------------------------------
function ISForageAction:stop()
	ISBaseTimedAction.stop(self);
end
-------------------------------------------------
-------------------------------------------------
function ISForageAction:start()
	self.action:setUseProgressBar(false);
	if self.discardItems then
		self:perform();
	else
		self:setActionAnim("Forage");
		self:setOverrideHandModels(nil, nil);
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISForageAction:perform()
	if self.forageIcon == nil or self.forageIcon.itemList == nil then return; end;
	--
	--flag the icon for removal
	self.forageIcon:setIsBeingRemoved(true);
	--do the icon removal
	self.manager:removeItem(self.forageIcon);
	self.manager:removeIcon(self.forageIcon);
	--do the foraging action
	self:forage();
	--trigger event so other managers will remove the icon
	triggerEvent("onUpdateIcon", self.forageIcon.zoneData, self.forageIcon.iconID, nil);
	ISBaseTimedAction.perform(self); -- remove from queue / start next.
end
-------------------------------------------------
-------------------------------------------------
function ISForageAction:forage()
	forageSystem.doFatiguePenalty(self.character);
	forageSystem.doEndurancePenalty(self.character);
	forageSystem.giveItemXP(self.character, self.itemDef, 0.75);
	--
	-- add the items to player inventory
	-- these items are generated when the icon is first spotted in self.forageIcon.itemList
	local itemsAdded = forageSystem.addOrDropItems(self.character, self.targetContainer, self.forageIcon.itemList, self.discardItems);
	local itemsTable = {};
	for i = 0, itemsAdded:size() - 1 do
		local item = itemsAdded:get(i);
		if not itemsTable[item:getFullType()] then itemsTable[item:getFullType()] = {item = item, count = 0}; end;
		itemsTable[item:getFullType()].count = itemsTable[item:getFullType()].count + 1;
	end;
	--
	--create the halo note, injecting the item image
	--TODO: this requires item images to be in media/textures - should get the image location from the texture here instead
	local itemTexture;
	for _, itemData in pairs(itemsTable) do
		local item = itemData.item;
		local count = itemData.count;
		if item:getTexture() ~= nil then
			if string.find(tostring(item:getTexture():getName()), "media") and string.find(tostring(item:getTexture():getName()), "textures") then
				itemTexture = "[img="..tostring(item:getTexture():getName()).."]";
			else
				itemTexture = "[img=media/textures/"..tostring(item:getTexture():getName()).."]"
			end
		else
			itemTexture = ""
		end
		if not self.discardItems then
			table.insert(self.manager.haloNotes,itemTexture.."    "..count.. " "..item:getDisplayName());
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISForageAction:new(_forageIcon, _targetContainer, _discardItems)
	local o = {}
	setmetatable(o, self)
	self.__index = self;
	--
	o.forageIcon = _forageIcon;
	o.zoneData = _forageIcon.zoneData;
	o.manager = _forageIcon.manager;
	o.character = _forageIcon.character;
	o.itemDef = _forageIcon.itemDef;
	o.targetContainer = _targetContainer;
	o.discardItems = _discardItems;
	--
	if _discardItems then
		o.stopOnWalk = true;
		o.stopOnRun = true;
		o.maxTime = 10;
	else
		o.stopOnWalk = false;
		o.stopOnRun = true;
		o.maxTime = 50;
	end
	o.currentTime = 0;
	o.started = false;
	--
	return o;
end
-------------------------------------------------
-------------------------------------------------