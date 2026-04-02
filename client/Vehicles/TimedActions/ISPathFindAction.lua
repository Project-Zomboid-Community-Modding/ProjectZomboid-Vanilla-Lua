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

local function tryAddLocationAdjacentToObject(square, direction, added, locations)
    local adjacent = square:getAdjacentSquare(direction)
    if adjacent == nil then return end
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

local function tryAddLocationsAdjacentToObject(square, added, locations, diagonal)
    if diagonal then
        tryAddLocationAdjacentToObject(square, IsoDirections.NW, added, locations)
        tryAddLocationAdjacentToObject(square, IsoDirections.NE, added, locations)
        tryAddLocationAdjacentToObject(square, IsoDirections.SE, added, locations)
        tryAddLocationAdjacentToObject(square, IsoDirections.SW, added, locations)
    else
        tryAddLocationAdjacentToObject(square, IsoDirections.N, added, locations)
        tryAddLocationAdjacentToObject(square, IsoDirections.S, added, locations)
        tryAddLocationAdjacentToObject(square, IsoDirections.W, added, locations)
        tryAddLocationAdjacentToObject(square, IsoDirections.E, added, locations)
    end
end

function ISPathFindAction:pathAdjacentToMultiTileObject(character, object, allowDiagonal)
    if not character:getCurrentSquare() then
        return nil
    end
    local added = {}
    local locations = {}
    local objects = ArrayList.new()
    object:getSpriteGridObjectsIncludingSelf(objects)
    for i=1,objects:size() do
        local square = objects:get(i-1):getSquare()
        tryAddLocationsAdjacentToObject(square, added, locations, false)
    end
    -- It's important to add the cardinal directions first, to avoid adding multiple
    -- destinations on the same square.  Also, these diagonal destinations are only
    -- used if no cardinal destination is available.
    local locationsAlt = {}
    if allowDiagonal then
        for i=1,objects:size() do
            local square = objects:get(i-1):getSquare()
            tryAddLocationsAdjacentToObject(square, added, locationsAlt, true)
        end
    end
    objects:clear()
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

-- Debug function for testing pathfinding.
function ISPathFindAction_pathToLocationF(targetX, targetY, targetZ)
	local playerObj = getSpecificPlayer(0)
	ISTimedActionQueue.add(ISPathFindAction:pathToLocationF(playerObj, targetX, targetY, targetZ))
end

