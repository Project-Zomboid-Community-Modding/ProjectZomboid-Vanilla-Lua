--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISWalkToCursor = ISBuildingObject:derive("ISWalkToCursor")


function ISWalkToCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISWalkToCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local square = getWorld():getCell():getGridSquare(x, y, z)
	ISTimedActionQueue.clear(self.character)
	ISTimedActionQueue.add(ISWalkToTimedAction:new(self.character, square))
end

function ISWalkToCursor:isValid(square)
	return square:TreatAsSolidFloor()
end

function ISWalkToCursor:render(x, y, z, square)
	local hc = getCore():getGoodHighlitedColor()
	if not self:isValid(square) then
		hc = getCore():getBadHighlitedColor()
	end
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)
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
	showDebugInfoInChat("Cursor New \'ISWalkToCursor\'")
	return o
end
