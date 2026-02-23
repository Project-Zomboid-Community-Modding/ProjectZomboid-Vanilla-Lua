ISWalkToCursor = ISBuildingObject:derive("ISWalkToCursor")

local blockedPathfindingStates = {
    [ClimbOverFenceState.instance()] = true,
    [ClimbOverWallState.instance()] = true,
    [ClimbSheetRopeState.instance()] = true,
    [ClimbDownSheetRopeState.instance()] = true,
    [ClimbThroughWindowState.instance()] = true,
};

function ISWalkToCursor:tryBuild(x, y, z)
    self:create(x, y, z, self.north, self:getSprite());
end

function ISWalkToCursor:create(x, y, z, north, sprite)
    local targetSquare = self:locateTargetSquare(getWorld():getCell():getGridSquare(x, y, z));
    if not targetSquare then return; end;
    -- prevents clicking walk-to during certain event states.
    if (blockedPathfindingStates[self.character:getCurrentState()]) then
        log(DebugType.Action, "Cursor Create \'ISWalkToCursor\' blocked by state " .. tostring(self.character:getCurrentState()));
        return false;
    end;
    log(DebugType.Action, "Cursor Create \'ISWalkToCursor\' "..tostring(targetSquare:getX())..", "..tostring(targetSquare:getY())..", "..tostring(targetSquare:getZ())..", "..tostring(north)..", "..tostring(sprite));
	ISTimedActionQueue.clear(self.character)
	ISTimedActionQueue.add(ISWalkToTimedAction:new(self.character, targetSquare))
end

function ISWalkToCursor:locateTargetSquare(square)
    local testSquare = square;
    local validSquare = false;
    local z = square:getZ();
    local x = square:getX();
    local y = square:getY();

    if testSquare and not testSquare:TreatAsSolidFloor() then
        repeat
            z = z - 1;
            testSquare = getWorld():getCell():getGridSquare(x, y, z);
            if testSquare and testSquare:TreatAsSolidFloor()  then
                validSquare = true;
                break;
            end;
        until
            validSquare
            or IsoChunkMap.isGridSquareOutOfRangeZ(z)
    end;

    return testSquare;
end

function ISWalkToCursor:isValid(square)
    local targetSquare = self:locateTargetSquare(getWorld():getCell():getGridSquare(square:getX(), square:getY(), square:getZ()));
	return targetSquare and targetSquare:TreatAsSolidFloor()
end

function ISWalkToCursor:render(x, y, z, square)
    local hc = getCore():getGoodHighlitedColor()
    local targetSquare = self:locateTargetSquare(square);
    if not targetSquare or not self:isValid(targetSquare) then
        hc = getCore():getBadHighlitedColor()
    end
    if targetSquare then
        self:getFloorCursorSprite():RenderGhostTileColor(targetSquare:getX(), targetSquare:getY(), targetSquare:getZ(), hc:getR(), hc:getG(), hc:getB(), 0.8)
    end
    if square ~= targetSquare then
        hc = getCore():getBadHighlitedColor();
        self:getFloorCursorSprite():RenderGhostTileColor(square:getX(), square:getY(), square:getZ(), hc:getR(), hc:getG(), hc:getB(), 0.8)
    end
end

function ISWalkToCursor:new(sprite, northSprite, character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o:setSprite(sprite)
	o:setNorthSprite(northSprite)
	o.character = character
	o.player = character:getPlayerNum()
	o.noNeedHammer = true
	o.skipBuildAction = true
    log(DebugType.Action, "Cursor New \'ISWalkToCursor\'")
	return o
end
