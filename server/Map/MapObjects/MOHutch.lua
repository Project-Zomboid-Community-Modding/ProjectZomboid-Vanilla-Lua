--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

MOHutch = {};
MOHutch.sprites = {}
MOHutch.sprites["location_farm_accesories_01_41"] = {x=0,y=-1,streamXFrom=0,streamYFrom=0};
MOHutch.sprites["location_farm_accesories_01_42"] = {x=-1,y=0,streamXFrom=-1,streamYFrom=-1};
MOHutch.sprites["location_farm_accesories_01_43"] = {x=-1,y=1,streamXFrom=-1,streamYFrom=0};
MOHutch.sprites["location_farm_accesories_01_44"] = {x=0,y=0,streamXFrom=0,streamYFrom=-1};
MOHutch.sprites["location_farm_accesories_01_45"] = {x=-1,y=0,streamXFrom=-1,streamYFrom=-1};
MOHutch.sprites["location_farm_accesories_01_46"] = {x=0,y=0,streamXFrom=0,streamYFrom=-1};
MOHutch.sprites["location_farm_accesories_01_47"] = {x=-1,y=0,streamXFrom=-1,streamYFrom=-1};
MOHutch.sprites["location_farm_accesories_01_48"] = {x=0,y=0,streamXFrom=0,streamYFrom=-1};
MOHutch.sprites["location_farm_accesories_01_49"] = {x=0,y=1,streamXFrom=0,streamYFrom=0};
MOHutch.sprites["location_farm_accesories_01_50"] = {x=0,y=0,streamXFrom=0,streamYFrom=-1};

MOHutch.sprites2 = {}
MOHutch.sprites2["location_farm_accesories_01_57"] = {x=0,y=-1,streamXFrom=0,streamYFrom=0};
MOHutch.sprites2["location_farm_accesories_01_58"] = {x=-1,y=0,streamXFrom=-1,streamYFrom=-1};
MOHutch.sprites2["location_farm_accesories_01_59"] = {x=-1,y=1,streamXFrom=-1,streamYFrom=0};
MOHutch.sprites2["location_farm_accesories_01_60"] = {x=0,y=0,streamXFrom=0,streamYFrom=-1};
MOHutch.sprites2["location_farm_accesories_01_61"] = {x=-1,y=0,streamXFrom=-1,streamYFrom=-1};
MOHutch.sprites2["location_farm_accesories_01_62"] = {x=0,y=0,streamXFrom=0,streamYFrom=-1};
MOHutch.sprites2["location_farm_accesories_01_63"] = {x=-1,y=0,streamXFrom=-1,streamYFrom=-1};
MOHutch.sprites2["location_farm_accesories_01_64"] = {x=0,y=0,streamXFrom=0,streamYFrom=-1};
MOHutch.sprites2["location_farm_accesories_01_65"] = {x=0,y=1,streamXFrom=0,streamYFrom=0};
MOHutch.sprites2["location_farm_accesories_01_66"] = {x=0,y=0,streamXFrom=0,streamYFrom=-1};

local function checkStreamed(square, spriteName)
	local coords = MOHutch.sprites[spriteName] or MOHutch.sprites2[spriteName];
	if not coords or not coords.streamXFrom or not coords.streamYFrom then return false; end
	--print("got new hutch", spriteName, " at sq: ", square:getX(), square:getY())

	if getSquare(square:getX() + coords.x, square:getY() + coords.y, square:getZ()) == nil then
		return false
	end

	for x=square:getX()+coords.streamXFrom,square:getX()+coords.streamXFrom+1 do
		for y=square:getY()+coords.streamYFrom,square:getY()+coords.streamYFrom+1 do
			--print("check sq for hutch at",x,y)
			local sq = getSquare(x, y, square:getZ());
			if sq then
				for i=0,sq:getObjects():size()-1 do
					local obj = sq:getObjects():get(i);
					if instanceof(obj, "IsoHutch") then -- as i'm checking every hutch possible tile, need to check if i already added a hutch from another tile
						return true;
					end
				end
			else
				return false;
			end
		end
	end

	return true;
end

local function ReplaceExistingObject(isoObject)
	local square = isoObject:getSquare()
	local spriteName = isoObject:getSprite():getName()
	local index = isoObject:getObjectIndex()
	local objToRemove = {};

	-- we gonna check that the squares needed to place a hutch is entirely streamed
	if not checkStreamed(square, spriteName) then return; end
	--print("streamed!")

	local baseX = 0;
	local baseY = 0;
	for x=square:getX()-2,square:getX()+2 do
		for y=square:getY()-2,square:getY()+2 do
			local sq = getSquare(x, y, square:getZ());
			if sq then
				for i=0,sq:getObjects():size()-1 do
					local obj = sq:getObjects():get(i);
					if instanceof(obj, "IsoHutch") then
						--print("found a hutch already at ", sq:getX(), sq:getY());
						return;
					end
					if obj:getSprite() and (MOHutch.sprites[obj:getSprite():getName()] or MOHutch.sprites2[obj:getSprite():getName()])then
						local cords = MOHutch.sprites[obj:getSprite():getName()];
						if not cords then
							cords = MOHutch.sprites2[obj:getSprite():getName()];
						end
						--print("remove hutch at", sq:getX(), sq:getY())
						if cords and cords.x == -1 and cords.y == 0 then
							baseX = sq:getX()-1;
							baseY = sq:getY();
							--print(obj:getSprite():getName(), "should be our base tile! ", baseX-1, baseY)
						end
						table.insert(objToRemove, obj);
					end
				end
			end
		end
	end


	for i,v in ipairs(objToRemove) do
		square:transmitRemoveItemFromSquare(v)
		v:getSquare():RemoveTileObject(v, false);
	end

	local cords = MOHutch.sprites[spriteName];
	local type = "hutchhen";
	if not cords then
		cords = MOHutch.sprites2[spriteName];
		type = "hutchturkey";
	end

	if baseX > 0 and baseY > 0 then
		--print("create hutch at ", baseX, baseY)
		local def = HutchDefinitions.hutchs[type];
		--local hutch = IsoHutch.new(getSquare(square:getX() + cords.x, square:getY() + cords.y, square:getZ()), true, def.baseSprite, def, nil);
		local hutch = IsoHutch.new(getSquare(baseX, baseY, square:getZ()), true, def.baseSprite, def, nil);
		hutch:toggleDoor();
	end

--	for x=square:getX()-1,square:getX()+2 do
--		for y=square:getY()-1,square:getY()+2 do
--			print("check sq ", x, y)
--			local sq = getSquare(x, y, square:getZ());
--			if sq then
--				for i=0,sq:getObjects():size()-1 do
--					local obj = sq:getObjects():get(i);
--					if obj:getSprite() and MOHutch.sprites[obj:getSprite():getName()] then
--						print("found a hutch tile to remove")
--						table.insert(objToRemove, obj);
--					end
--				end
--			else
--				print("no sq found here")
--			end
--		end
--	end
--
end

-- -- -- -- --

local function NewHutch(object)
	ReplaceExistingObject(object)
end

local PRIORITY = 5

MapObjects.OnNewWithSprite("location_farm_accesories_01_41", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_42", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_43", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_44", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_45", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_46", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_47", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_48", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_49", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_50", NewHutch, PRIORITY)

MapObjects.OnNewWithSprite("location_farm_accesories_01_57", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_58", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_59", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_60", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_61", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_62", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_63", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_64", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_65", NewHutch, PRIORITY)
MapObjects.OnNewWithSprite("location_farm_accesories_01_66", NewHutch, PRIORITY)