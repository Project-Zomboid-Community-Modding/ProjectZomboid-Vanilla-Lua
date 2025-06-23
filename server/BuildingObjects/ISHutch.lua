require "BuildingObjects/ISBuildingObject"


ISHutch = ISBuildingObject:derive("ISHutch");

function ISHutch:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISHutch\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local sq = getWorld():getCell():getGridSquare(x, y, z);
	local hutch = IsoHutch.new(sq, north, sprite, self.def, nil)
	hutch:transmitCompleteItemToClients()
end

function ISHutch:walkTo(x, y, z)
	local square = getCell():getGridSquare(x, y, z)
--	if self.doubleSprite then
--		local square2 = self:getSquare2(square, self.north)
--		if square:DistToProper(self.character) < square2:DistToProper(self.character) then
--			return luautils.walkAdj(self.character, square)
--		end
--		return luautils.walkAdj(self.character, square2)
--	else
	if not isServer() then
		return luautils.walkAdj(self.character, square)
	else
		return luautils.walkAdj(self.player, square)
	end
--	end
end

function ISHutch:onTimedActionStart(action)
	ISBuildingObject.onTimedActionStart(self, action)
	self.character:SetVariable("LootPosition", "Mid")
	action:setOverrideHandModels(nil, nil)
	-- ISBuildAction is running, ISAddTentAction completes instantly
	action.character:faceLocation(action.square:getX(), action.square:getY())
end

function ISHutch:new(character, def)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o:setNorthSprite(def.baseSprite);
	o:setSprite(def.baseSprite);
	if not isServer() then
		o.character = getSpecificPlayer(character);
	end
    o.actionAnim = "Loot"
	o.def = def
    showDebugInfoInChat("Cursor New \'ISHutch\'")
	return o;
end

function ISHutch:isValid(square)
--	local valid = self:isSquareFree(square)
--	if self.doubleSprite then
--		local square2 = self:getSquare2(square, self.north)
--		if valid and not (square2 and self:isSquareFree(square2) and not square:isSomethingTo(square2)) then
--			valid = false
--		end
--	end
--	return valid
	return true;
end

function ISHutch:render(x, y, z, square)
	-- render the first part
	ISBuildingObject.render(self, x, y, z, square)

	-- render other sprites
	for i, def in ipairs(self.def.extraSprites) do
		local sprite2 = IsoSprite.new();
--		print("DEF!", def, def.sprite, def.zoffset, def.yoffset);
		sprite2:LoadSingleTexture(def.sprite);
		local sq2 = getSquare(x + def.xoffset, y + def.yoffset, z + def.zoffset);
		if self:isValid(sq2) then
			sprite2:RenderGhostTile(x + def.xoffset, y + def.yoffset, z + def.zoffset);
		else
			sprite2:RenderGhostTileRed(x + def.xoffset, y + def.yoffset, z + def.zoffset);
		end
	end

--	if self.doubleSprite then
--		local sprite2Name = self.troughSprite.backLeft;
--		if not self.north then
--			sprite2Name = self.troughSprite.backRight;
--		end
--		local sprite2 = IsoSprite.new();
--		sprite2:LoadSingleTexture(sprite2Name);
--		x, y, z = self:getSquare2Pos(square, self.north)
--		self.sq2 = getSquare(x, y, z);
--		self.sprite2 = sprite2Name;
--		if self:isValid(square) then
--			sprite2:RenderGhostTile(x, y, z);
--		else
--			sprite2:RenderGhostTileRed(x, y, z);
--		end
--	end
end

function ISHutch:isSquareFree(square)
	if not square then return false end
	if square:getMovingObjects():size() > 0 then return false end
	if square:getStaticMovingObjects():size() > 0 then return false end
	if square:isVehicleIntersecting() then return false end
	for i=0,square:getObjects():size()-1 do
		local object = square:getObjects():get(i)
		if object:getSprite() and not object:getSprite():getProperties():Is(IsoFlagType.solidfloor) then
            if object:getType() == IsoObjectType.tree or object:getType() == IsoObjectType.wall then
                return false;
            end
		    return not square:isSolidTrans();
		end
	end
	return true
end

function ISHutch:getSquare2Pos(square, north)
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

function ISHutch:getSquare2(square, north)
	local x, y, z = self:getSquare2Pos(square, north)
	return getCell():getGridSquare(x, y, z)
end

