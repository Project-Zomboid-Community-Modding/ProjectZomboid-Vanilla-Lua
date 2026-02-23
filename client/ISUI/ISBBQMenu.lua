ISBBQMenu = {}

local function predicateNotEmpty(item)
	return item:getCurrentUsesFloat() > 0
end

function ISBBQMenu.onDisplayInfo(worldobjects, player, bbq)
	local playerObj = getSpecificPlayer(player)
	if not AdjacentFreeTileFinder.isTileOrAdjacent(playerObj:getCurrentSquare(), bbq:getSquare()) then
		local adjacent = AdjacentFreeTileFinder.Find(bbq:getSquare(), playerObj)
		if adjacent then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
			ISTimedActionQueue.add(ISBBQInfoAction:new(playerObj, bbq))
			return
		end
	else
		ISTimedActionQueue.add(ISBBQInfoAction:new(playerObj, bbq))
	end
end

function ISBBQMenu.FindPropaneTank(player, bbq)
	local tank = player:getInventory():getFirstTypeEvalRecurse("Base.PropaneTank", predicateNotEmpty)
	if tank and tank:getCurrentUsesFloat() > 0 then
		return tank
	end
	for y=bbq:getY()-1,bbq:getY()+1 do
		for x=bbq:getX()-1,bbq:getX()+1 do
			local square = getCell():getGridSquare(x, y, bbq:getZ())
			if square and not square:isSomethingTo(bbq:getSquare()) then
				local wobs = square:getWorldObjects()
				for i=0,wobs:size()-1 do
					local o = wobs:get(i)
					if o:getItem():getFullType() == "Base.PropaneTank" then
						if o:getItem():getCurrentUsesFloat() > 0 then
							return o
						end
					end
				end
			end
		end
	end
	return nil
end

function ISBBQMenu.onExtinguish(worldobjects, player, bbq)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, bbq:getSquare()) then
		ISTimedActionQueue.add(ISBBQExtinguish:new(playerObj, bbq))
	end
end

function ISBBQMenu.onInsertPropaneTank(worldobjects, player, bbq, tank)
	local playerObj = getSpecificPlayer(player)
	local square = bbq:getSquare()
	if instanceof(tank, "IsoWorldInventoryObject") then
		if playerObj:getSquare() ~= tank:getSquare() then
			ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, tank:getSquare()))
		end
		ISTimedActionQueue.add(ISBBQInsertPropaneTank:new(playerObj, bbq, tank))
	elseif luautils.walkAdj(playerObj, square) then
		ISWorldObjectContextMenu.transferIfNeeded(playerObj, tank)
		ISTimedActionQueue.add(ISBBQInsertPropaneTank:new(playerObj, bbq, tank))
	end
end

function ISBBQMenu.onRemovePropaneTank(worldobjects, player, bbq, tank)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, bbq:getSquare()) then
		ISTimedActionQueue.add(ISBBQRemovePropaneTank:new(playerObj, bbq))
	end
end

function ISBBQMenu.onToggle(worldobjects, player, bbq, tank)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, bbq:getSquare()) then
		ISTimedActionQueue.add(ISBBQToggle:new(playerObj, bbq))
	end
end
