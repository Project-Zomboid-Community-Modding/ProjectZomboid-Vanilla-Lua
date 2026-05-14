require "BuildingObjects/ISBuildingObject"

ISPickDungCursor = ISBuildingObject:derive("ISPickDungCursor")

function ISPickDungCursor:create(x, y, z, north, sprite)
	local playerObj = self.character
	local sq = getSquare(x, y, z)
	ISInventoryPaneContextMenu.equipWeapon(self.rake, true, true, playerObj:getPlayerNum())
	ISTimedActionQueue.add(ISPickupDung:new(playerObj, self.rake, sq, self.radius))
end

function ISPickDungCursor:walkTo(x, y, z)
	local playerObj = self.character
	local squares = self:getSquares(x, y, z)
    local closestSq = self:getClosestSquare(squares)
    if playerObj:getCurrentSquare() == closestSq then
        return true
    end
    local adjacent = AdjacentFreeTileFinder.Find(closestSq, self.character)
    if not adjacent then return false end
    ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
	return true
end

function ISPickDungCursor:isValid(square)
	return self:isValidArea(square:getX(), square:getY(), square:getZ())
end

function ISPickDungCursor:isValidArea(x, y, z)
	local squares = self:getSquares(x, y, z)
	for _,square2 in ipairs(squares) do
		if not square2:isCouldSee(self.character:getPlayerNum()) then
			return false
		end
		if square2:checkHaveDung() then
			return true
		end
	end
	return false
end

function ISPickDungCursor:isRunningAction()
    local actionQueue = ISTimedActionQueue.getTimedActionQueue(self.character)
    return actionQueue and actionQueue.queue and actionQueue.queue[1]
end

function ISPickDungCursor:getTopLeftOfSquares(x, y, z)
	if self.character:getJoypadBind() ~= -1 then
		local cx,cy = math.floor(self.character:getX()), math.floor(self.character:getY())
		if self.character:isOnFire() then
			return cx,cy,z
		end
		local dir = self.character:getDir()
		if     dir == IsoDirections.N  then   x,y = cx,   cy-2
		elseif dir == IsoDirections.NE then   x,y = cx+1, cy-2
		elseif dir == IsoDirections.E  then   x,y = cx+1, cy
		elseif dir == IsoDirections.SE then   x,y = cx+1, cy+1
		elseif dir == IsoDirections.S  then   x,y = cx,   cy+1
		elseif dir == IsoDirections.SW then   x,y = cx-2, cy+1
		elseif dir == IsoDirections.W  then   x,y = cx-2, cy
		elseif dir == IsoDirections.NW then   x,y = cx-2, cy-2
		end
	end
	return x,y,z
end

function ISPickDungCursor:render(x, y, z, square)
	if self:isRunningAction() then return end
	local bValid = self:isValidArea(x, y, z)
	if bValid then
		renderIsoRect(x + 1, y + 1, z, self.radius, getCore():getGoodHighlitedColor():getR(),getCore():getGoodHighlitedColor():getG(),getCore():getGoodHighlitedColor():getB(), 0.5, 1)
	else
		renderIsoRect(x + 1, y + 1, z, self.radius, getCore():getBadHighlitedColor():getR(),getCore():getBadHighlitedColor():getG(),getCore():getBadHighlitedColor():getB(), 0.5, 1)
	end
end

function ISPickDungCursor:onJoypadPressButton(joypadIndex, joypadData, button)
	if button == Joypad.AButton or button == Joypad.BButton then
		return ISBuildingObject.onJoypadPressButton(self, joypadIndex, joypadData, button)
	end
    if button == Joypad.YButton then
        return self:rotateKey(getCore():getKey("Rotate building"))
    end
end

function ISPickDungCursor:getAPrompt()
	return getText("ContextMenu_RakeDung")
end

function ISPickDungCursor:getYPrompt()
    return getText("ContextMenu_ChangeRadius")
end

function ISPickDungCursor:getLBPrompt()
	return nil
end

function ISPickDungCursor:getRBPrompt()
	return nil
end

function ISPickDungCursor:getSquares(x, y, z)
	local squares = {}
	local square = getCell():getGridSquare(x, y, z)
	table.insert(squares, square)
	for x2=x,x+self.radius-1 do
		for y2=y,y+self.radius-1 do
			square = getCell():getGridSquare(x2, y2, z)
			if square then
				table.insert(squares, square)
			end
		end
	end
	return squares
end

function ISPickDungCursor:getClosestSquare(squares)
	local closest
	local closestDist = 1000000
	for _,square2 in ipairs(squares) do
		local dist = IsoUtils.DistanceTo(self.character:getX(), self.character:getY(), square2:getX() + 0.5, square2:getY() + 0.5)
		if dist < closestDist then
			closest = square2
			closestDist = dist
		end
	end
	return closest
end

function ISPickDungCursor:rotateKey(key)
	if getCore():isKey("Rotate building", key) then
		self.radius = self.radius - 1
		if self.radius == 0 then
			self.radius = self.maxRadius
		end
	end
end

function ISPickDungCursor:new(character, rake)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o.character = character
	o.player = character:getPlayerNum()
	o.skipBuildAction = true
	o.noNeedHammer = true
	o.renderFloorHelper = true
	o.rake = rake
	o.radius = 3
	o.maxRadius = 3
	return o
end

Events.OnKeyPressed.Add(rotateKey)
