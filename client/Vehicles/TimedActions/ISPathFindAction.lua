require "TimedActions/ISBaseTimedAction"

ISPathFindAction = ISBaseTimedAction:derive("ISPathFindAction")

function ISPathFindAction:isValid()
	return true
end

function ISPathFindAction:update()
	if instanceof(self.character, "IsoPlayer") and
			(self.character:pressedMovement(false) or self.character:pressedCancelAction()) then
		self:forceStop()
		return
	end
	local result = self.character:getPathFindBehavior2():update()
	if result == BehaviorResult.Failed then
		if self.goal[1] == 'NearestPreferred' and not self.goal[4] and #self.goal[3] > 0 then
			self.goal[4] = true
			self.character:getPathFindBehavior2():pathToNearestTable(self.goal[3])
		end
	end
	if result == BehaviorResult.Failed then
		if self.onFailFunc then
			local args = self.onFailArgs
			self.onFailFunc(args[1], args[2], args[3], args[4])
			if self.runActionsAfterFailing then
				self:forceComplete();
				return
			end
		end
		self:forceStop()
		return
	end
	if result == BehaviorResult.Succeeded then
		self:forceComplete()
	end
end

function ISPathFindAction:start()
	self.action:setPathfinding(true);
	self.action:setAllowedWhileDraggingCorpses(true);
	if self.goal[1] == 'LocationF' then
		self.character:getPathFindBehavior2():pathToLocationF(self.goal[2], self.goal[3], self.goal[4])
	end
	if self.goal[1] == 'Nearest' then
		self.character:getPathFindBehavior2():pathToNearestTable(self.goal[2])
	end
	if self.goal[1] == 'NearestPreferred' then
		self.character:getPathFindBehavior2():pathToNearestTable(self.goal[2])
	end
	if self.goal[1] == 'SitOnFurniture' then
		self.character:getPathFindBehavior2():pathToSitOnFurniture(self.goal[2], self.goal[3])
	end
	if self.goal[1] == 'VehicleAdjacent' then
		self.character:getPathFindBehavior2():pathToVehicleAdjacent(self.goal[2])
	end
	if self.goal[1] == 'VehicleArea' then
		self.character:getPathFindBehavior2():pathToVehicleArea(self.goal[2], self.goal[3])
	end
	if self.goal[1] == 'VehicleSeat' then
		self.character:getPathFindBehavior2():pathToVehicleSeat(self.goal[2], self.goal[3])
	end
    if self.goal[1] == 'GrabCorpse' then
        self.character:getPathFindBehavior2():pathToGrabCorpse(self.goal[2])
    end
end

function ISPathFindAction:stop()
	ISBaseTimedAction.stop(self)
	self.character:getPathFindBehavior2():cancel()
	self.character:setPath2(nil)
end

function ISPathFindAction:perform()
	if self.runActionsAfterFailing then
		self.character:getPathFindBehavior2():cancel()
		self.character:setPath2(nil)
		ISBaseTimedAction.perform(self)
		return
	end
	if self.goal[1] == 'SitOnFurniture' then
		self.goalFurnitureObject = self.character:getPathFindBehavior2():getGoalSitOnFurnitureObject()
	end
	self.character:getPathFindBehavior2():cancel()
	self.character:setPath2(nil)
	ISBaseTimedAction.perform(self)
	if self.onCompleteFunc then
		local args = self.onCompleteArgs
		self.onCompleteFunc(args[1], args[2], args[3], args[4])
	end
end

function ISPathFindAction:setOnComplete(func, arg1, arg2, arg3, arg4)
	self.onCompleteFunc = func
	self.onCompleteArgs = { arg1, arg2, arg3, arg4 }
end

function ISPathFindAction:setOnFail(func, arg1, arg2, arg3, arg4)
	self.onFailFunc = func
	self.onFailArgs = { arg1, arg2, arg3, arg4 }
end

function ISPathFindAction:setRunActionsAfterFailing(b)
	self.runActionsAfterFailing = b
end

function ISPathFindAction:debugRender()
	if self.goal[1] == 'NearestPreferred' then
		local locations = self.goal[2]
		local locationsAlt = self.goal[3]
		for i=1,#locations,3 do
			local x,y,z = locations[i],locations[i+1],locations[i+2]
			renderIsoCircle(x, y, z, 0.1, 16, 1.0, 1.0, 1.0, 1.0, 1.0)
		end
		for i=1,#locationsAlt,3 do
			local x,y,z = locationsAlt[i],locationsAlt[i+1],locationsAlt[i+2]
			renderIsoCircle(x, y, z, 0.1, 16, 1.0, 1.0, 0.0, 0.0, 1.0)
		end
	end
end

function ISPathFindAction:pathToLocationF(character, targetX, targetY, targetZ)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = -1
	o.goal = { 'LocationF', targetX, targetY, targetZ }
	return o
end

function ISPathFindAction:pathToNearest(character, locations)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = -1
	o.goal = { 'Nearest', locations }
	return o
end

function ISPathFindAction:pathToNearestPreferred(character, locations, locationsAlt)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = -1
	o.goal = { 'NearestPreferred', locations, locationsAlt, false }
	return o
end

function ISPathFindAction:pathToSitOnFurniture(character, bed, bAnySpriteGridObject)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = -1
	o.goal = { 'SitOnFurniture', bed, bAnySpriteGridObject }
	return o
end

function ISPathFindAction:pathToVehicleAdjacent(character, vehicle)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = -1
	o.goal = { 'VehicleAdjacent', vehicle }
	return o
end

function ISPathFindAction:pathToVehicleArea(character, vehicle, areaId)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = -1
	o.goal = { 'VehicleArea', vehicle, areaId }
	return o
end

function ISPathFindAction:pathToVehicleSeat(character, vehicle, seat)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = -1
	o.goal = { 'VehicleSeat', vehicle, seat }
	return o
end

function ISPathFindAction:pathToGrabCorpse(character, corpse)
    local o = ISBaseTimedAction.new(self, character)
    o.stopOnAim = false
    o.stopOnWalk = false
    o.stopOnRun = false
    o.maxTime = -1
    o.goal = { 'GrabCorpse', corpse }
    return o
end

local function tryAddLocationAdjacentToObject(square, direction, added, locations, predicate, predicateArg)
    local adjacent = square:getAdjacentSquare(direction)
    if adjacent == nil then return end
    if predicate and predicate(predicateArg, adjacent) then
        return
    end
    if luautils.tableContains(added, adjacent) then
        return
    end
    table.insert(added, adjacent)
    if AdjacentFreeTileFinder.isTileOrAdjacent(square, adjacent) then
        local dx, dy
        local diameter = 0.61
        local directionVector = direction:ToVector()
        if direction:isDiagonal() then
            dx = directionVector:getX() * ((math.sqrt(2) + diameter) / 2)
            dy = directionVector:getY() * ((math.sqrt(2) + diameter) / 2)
        else
            dx = directionVector:getX() * ((1 + diameter) / 2)
            dy = directionVector:getY() * ((1 + diameter) / 2)
        end
        local locationX = square:getX() + 0.5 + dx
        local locationY = square:getY() + 0.5 + dy
        locationX = math.min(adjacent:getX() + 1 - diameter / 2, math.max(locationX, adjacent:getX() + diameter / 2))
        locationY = math.min(adjacent:getY() + 1 - diameter / 2, math.max(locationY, adjacent:getY() + diameter / 2))
        table.insert(locations, locationX)
        table.insert(locations, locationY)
        table.insert(locations, adjacent:getZ())
    end
end

local function tryAddLocationsAdjacentToObject(square, added, locations, diagonal, predicate, predicateArg)
    if diagonal then
        tryAddLocationAdjacentToObject(square, IsoDirections.NW, added, locations, predicate, predicateArg)
        tryAddLocationAdjacentToObject(square, IsoDirections.NE, added, locations, predicate, predicateArg)
        tryAddLocationAdjacentToObject(square, IsoDirections.SE, added, locations, predicate, predicateArg)
        tryAddLocationAdjacentToObject(square, IsoDirections.SW, added, locations, predicate, predicateArg)
    else
        tryAddLocationAdjacentToObject(square, IsoDirections.N, added, locations, predicate, predicateArg)
        tryAddLocationAdjacentToObject(square, IsoDirections.S, added, locations, predicate, predicateArg)
        tryAddLocationAdjacentToObject(square, IsoDirections.W, added, locations, predicate, predicateArg)
        tryAddLocationAdjacentToObject(square, IsoDirections.E, added, locations, predicate, predicateArg)
    end
end

function ISPathFindAction:pathAdjacentToSquares(character, squares, allowDiagonal)
    if not character:getCurrentSquare() then
        return nil
    end
    local added = {}
    local locations = {}
    local predicate = function(_squares, _square)
        return luautils.tableContains(_squares, _square)
    end
    for _,square in ipairs(squares) do
        tryAddLocationsAdjacentToObject(square, added, locations, false, predicate, squares)
    end
    -- It's important to add the cardinal directions first, to avoid adding multiple
    -- destinations on the same square.  Also, these diagonal destinations are only
    -- used if no cardinal destination is available.
    local locationsAlt = {}
    if allowDiagonal then
        for _,square in ipairs(squares) do
            tryAddLocationsAdjacentToObject(square, added, locationsAlt, true, predicate, squares)
        end
    end
    if #locations + #locationsAlt == 0 then
        return nil
    end
    if #locations == 0 then
        return ISPathFindAction:pathToNearest(character, locationsAlt)
    end
    if #locationsAlt == 0 then
        return ISPathFindAction:pathToNearest(character, locations)
    end
    return ISPathFindAction:pathToNearestPreferred(character, locations, locationsAlt)
end

local function isSquareAdjacentToAny(square, squares)
    for _,square2 in ipairs(squares) do
        if square:isAdjacentTo(square2) then
            return true
        end
    end
    return false
end

local function isSquareCardinalAdjacentToAny(square, squares)
    for _,square2 in ipairs(squares) do
        if square2:getAdjacentSquare(IsoDirections.W) == square or
                square2:getAdjacentSquare(IsoDirections.N) or
                square2:getAdjacentSquare(IsoDirections.E) == square or
                square2:getAdjacentSquare(IsoDirections.S) == square then
            return true
        end
    end
    return false
end

function ISPathFindAction:pathAdjacentToSquaresPredicate(character, squares, allowDiagonal, predicate, predicateArg)
    if not character:getCurrentSquare() then
        return nil
    end
    local added = {}
    local locations = {}
    for _,square in ipairs(squares) do
        tryAddLocationsAdjacentToObject(square, added, locations, false, predicate, predicateArg)
    end
    -- It's important to add the cardinal directions first, to avoid adding multiple
    -- destinations on the same square.  Also, these diagonal destinations are only
    -- used if no cardinal destination is available.
    local locationsAlt = {}
    if allowDiagonal then
        for _,square in ipairs(squares) do
            tryAddLocationsAdjacentToObject(square, added, locationsAlt, true, predicate, predicateArg)
        end
    end
    if #locations + #locationsAlt == 0 then
        return nil
    end
    if #locations == 0 then
        return ISPathFindAction:pathToNearest(character, locationsAlt)
    end
    if #locationsAlt == 0 then
        return ISPathFindAction:pathToNearest(character, locations)
    end
    -- Pathfind to diagonals that are in squares adjacent (in a cardinal direction) to an excluded square
    if type(predicateArg.squaresExcluded) == 'table' then
        local locationsAlt1 = {}
        for i=1,#locationsAlt,3 do
            local x,y,z = locationsAlt[i],locationsAlt[i+1],locationsAlt[i+2]
            local square = getCell():getGridSquare(fastfloor(x), fastfloor(y), fastfloor(z))
            if isSquareCardinalAdjacentToAny(square, predicateArg.squaresExcluded) then
                table.insert(locations, x)
                table.insert(locations, y)
                table.insert(locations, z)
            else
                table.insert(locationsAlt1, x)
                table.insert(locationsAlt1, y)
                table.insert(locationsAlt1, z)
            end
        end
        locationsAlt = locationsAlt1
    end
    return ISPathFindAction:pathToNearestPreferred(character, locations, locationsAlt)
end

function ISPathFindAction:pathAdjacentToMultiTileObject(character, object, allowDiagonal)
    local squares = {}
    local objects = ArrayList.new()
    object:getSpriteGridObjectsIncludingSelf(objects)
    for i=1,objects:size() do
        local square = objects:get(i-1):getSquare()
        table.insert(squares, square)
    end
    objects:clear()
    return ISPathFindAction:pathAdjacentToSquares(character, squares, allowDiagonal)
end

-- Debug function for testing pathfinding.
function ISPathFindAction_pathToLocationF(targetX, targetY, targetZ)
	local playerObj = getSpecificPlayer(0)
	ISTimedActionQueue.add(ISPathFindAction:pathToLocationF(playerObj, targetX, targetY, targetZ))
end

