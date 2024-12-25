require "BuildingObjects/ISBuildingObject"


ISFeedingTrough = ISBuildingObject:derive("ISFeedingTrough");

function ISFeedingTrough:create(x, y, z, north, sprite)
	local sq = getWorld():getCell():getGridSquare(x, y, z);
    SFeedingTroughSystem.instance:addTrough(sq,self.def,north,false)
    if self.def.sprite2 then
        local x1, y1, z1 = self:getSquare2Pos(sq,north)
        local sq2 = getWorld():getCell():getGridSquare(x1,y1,z1)
        if sq2 then
            SFeedingTroughSystem.instance:addTrough(sq2,self.def,north,true)
        end
    end
end

function ISFeedingTrough:getSquare2Pos(square, north)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()
	if north then
		x = x - 1
	else
		y = y - 1
	end
	return x, y, z
end

function ISFeedingTrough:walkTo(x, y, z)
	local square = getCell():getGridSquare(x, y, z)
	if self.doubleSprite then
		local square2 = self:getSquare2(square, self.north)
		if square:DistToProper(self.character) < square2:DistToProper(self.character) then
			return luautils.walkAdj(self.character, square)
		end
		return luautils.walkAdj(self.character, square2)
	else
		return luautils.walkAdj(self.character, square)
	end
end

function ISFeedingTrough:onTimedActionStart(action)
	ISBuildingObject.onTimedActionStart(self, action)
	self.character:SetVariable("LootPosition", "Mid")
	action:setOverrideHandModels(nil, nil)
	-- ISBuildAction is running, ISAddTentAction completes instantly
	action.character:faceLocation(action.square:getX(), action.square:getY())
end

function ISFeedingTrough:new(character, def)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o:setNorthSprite(def.spriteNorth1);
	o:setSprite(def.sprite1);
	o.troughSprite = {};
	o.troughSprite.backLeft = def.spriteNorth2;
	o.troughSprite.backRight = def.sprite2;
	if not isServer() then
        o.character = getSpecificPlayer(character);
    end
    o.actionAnim = "Loot"
	o.def = def;
	o.doubleSprite = def.sprite2 ~= nil;
--~ 	o:setDragNilAfterPlace(true);
	return o;
end

function ISFeedingTrough:isValid(square)
	local valid = self:isSquareFree(square)
	if self.doubleSprite then
		local square2 = self:getSquare2(square, self.north)
		if valid and not (square2 and self:isSquareFree(square2) and not square:isSomethingTo(square2)) then
			valid = false
		end
	end
	return valid
end

function ISFeedingTrough:render(x, y, z, square)
	-- render the first part
	ISBuildingObject.render(self, x, y, z, square)

	if self.doubleSprite then
		local sprite2Name = self.troughSprite.backLeft;
		if not self.north then
			sprite2Name = self.troughSprite.backRight;
		end
		local sprite2 = IsoSprite.new();
		sprite2:LoadSingleTexture(sprite2Name);
		x, y, z = self:getSquare2Pos(square, self.north)
		self.sq2 = getSquare(x, y, z);
		self.sprite2 = sprite2Name;
		if self:isValid(square) then
			sprite2:RenderGhostTile(x, y, z);
		else
			sprite2:RenderGhostTileRed(x, y, z);
		end
	end
end

function ISFeedingTrough:isSquareFree(square)
	if not square then return false end
	if square:getMovingObjects():size() > 0 then return false end
	if square:getStaticMovingObjects():size() > 0 then return false end
	if square:isVehicleIntersecting() then return false end
	for i=0,square:getObjects():size()-1 do
		local object = square:getObjects():get(i)
		if object:getSprite() and not object:getSprite():getProperties():Is(IsoFlagType.solidfloor) then
            if object:getType() == IsoObjectType.tree then
                return false;
            end
		    return not square:isSolidTrans();
		end
	end
	return true
end

function ISFeedingTrough:getSquare2Pos(square, north)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()
	if north then
		x = x - 1
	else
		y = y - 1
	end
	return x, y, z
end

function ISFeedingTrough:getSquare2(square, north)
	local x, y, z = self:getSquare2Pos(square, north)
	return getCell():getGridSquare(x, y, z)
end

