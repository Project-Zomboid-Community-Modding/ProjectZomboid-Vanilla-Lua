--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

CBed_Interact = {}

CBed_Interact.onContextKey = function(playerObj, timePressedContext)
	if playerObj:getVehicle() then return end
	if playerObj:hasTimedActions() then return end
	if playerObj:isSittingOnFurniture() then return end
	if CBed_Interact.trySquareForBed(playerObj, playerObj:getSquare()) then
		return
	end
	local dir = playerObj:getDir()
	if CBed_Interact.trySquareInDirection(playerObj, dir) then
		return
	end
	if CBed_Interact.trySquareInDirection(playerObj, dir:RotLeft(1)) then
		return
	end
	if CBed_Interact.trySquareInDirection(playerObj, dir:RotRight(1)) then
		return
	end
end

CBed_Interact.trySquareInDirection = function(playerObj, dir)
	local sq = playerObj:getSquare():getAdjacentSquare(dir)
	return CBed_Interact.trySquareForBed(playerObj, sq)
end

CBed_Interact.trySquareForBed = function(playerObj, sq)
	if not sq then return false end
	if not sq:getCanSee(playerObj:getPlayerNum()) then return false end
	if playerObj:getCurrentSquare():isSomethingTo(sq) then return false end
	local bed = CBed_Interact.LookForBed(sq)
	if bed then
		ISWorldObjectContextMenu.onRest(bed, 0)
		return true
	end
	return false
end

CBed_Interact.LookForBed = function(sq)
	for i=0,sq:getObjects():size()-1 do
		local test = sq:getObjects():get(i)
		if instanceof(test, "IsoObject") and test:getSprite() and test:getSprite():getProperties() and test:getSprite():getProperties():Is(IsoFlagType.bed) then
			return test
		end
	end
	return nil
end

Events.OnContextKey.Add(CBed_Interact.onContextKey)