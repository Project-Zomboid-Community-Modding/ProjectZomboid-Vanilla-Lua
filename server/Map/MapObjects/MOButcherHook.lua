if isClient() then return end

local function ReplaceExistingObject(isoObject)
	local sq = isoObject:getSquare();
	local javaObject = IsoButcherHook.new(sq);
	sq:AddTileObject(javaObject)

	if isoObject:getSquare() ~= nil then
		isoObject:removeFromWorld();
		isoObject:removeFromSquare();
		isoObject:setSquare(nil);
	end
end

local function NewButcherHook(object)
	ReplaceExistingObject(object)
end

local PRIORITY = 5

MapObjects.OnNewWithSprite("crafted_04_120", NewButcherHook, PRIORITY)

local function LoadButcherHook(object)
	if not instanceof(object, "IsoButcherHook") then
	    ReplaceExistingObject(object)
    end
end

MapObjects.OnLoadWithSprite("crafted_04_120", LoadButcherHook, PRIORITY)
