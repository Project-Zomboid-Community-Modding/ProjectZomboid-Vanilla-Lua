--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

ISButcheringHook = ISBuildingObject:derive("ISButcheringHook");

--************************************************************************--
--** ISButcheringHook:new
--**
--************************************************************************--
function ISButcheringHook:create(x, y, z, north, sprite)
	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	self.javaObject = IsoButcherHook.new(self.sq);
	buildUtil.consumeMaterial(self);
	self.sq:AddTileObject(self.javaObject)
end

function ISButcheringHook:new(name, sprite)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSprite(sprite);
	o:setNorthSprite(sprite);
	o.name = name;
	return o;
end

function ISButcheringHook:isValid(square)
	if not ISBuildingObject.isValid(self, square) then return false; end
    return true;
end

function ISButcheringHook:render(x, y, z, square)
	ISBuildingObject.render(self, x, y, z, square)
end
