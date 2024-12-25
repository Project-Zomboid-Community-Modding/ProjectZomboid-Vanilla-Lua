--[[---------------------------------------------
-------------------------------------------------
--
-- ISStashIcon
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------
require "Foraging/forageSystem";
require "ISUI/ISPanel";
require "Foraging/ISBaseIcon";
ISStashIcon = ISBaseIcon:derive("ISStashIcon");
-------------------------------------------------
-------------------------------------------------
function ISStashIcon:isValid()
	return self:isInRangeOfPlayer(40);
end
-------------------------------------------------
-------------------------------------------------
function ISStashIcon:findPinOffset()
	-- IsoWorldInventoryObjects are 3/4 icon height above the world x,y coords.
	-- ISForageIcon icons are below the world x,y coords.
	if self.itemTexture then
		self.pinOffset = -self.itemTexture:getHeight() * 3 / 4
	end
end
-------------------------------------------------
-------------------------------------------------
function ISStashIcon:setWorldMarkerPosition()
	self.worldMarker:setX(self.xCoord);
	self.worldMarker:setY(self.yCoord);
	self.worldMarker:setHomeOnOffsetX(IsoUtils.XToScreen(self.xCoord % 1, self.yCoord % 1, 0, 0));
	self.worldMarker:setHomeOnOffsetY(IsoUtils.YToScreen(self.xCoord % 1, self.yCoord % 1, 0, 0));
end
-------------------------------------------------
-------------------------------------------------
function ISStashIcon:checkIsForageable()
	self.isForageable = self:isValid();
	return self.isForageable;
end
-------------------------------------------------
-------------------------------------------------
function ISStashIcon:new(_manager, _icon)
	local o = {};
	o = ISBaseIcon:new(_manager, _icon);
	setmetatable(o, self)
	self.__index = self;
	o.iconClass = "stashObject";
	o.isValidSquare = true;
	o.itemObjTable = _icon.itemObjTable;
	o.onMouseDoubleClick = ISStashIcon.doPickup;
	o:initialise();
	return o;
end
