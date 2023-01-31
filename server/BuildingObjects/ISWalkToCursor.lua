--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISWalkToCursor = ISBuildingObject:derive("ISWalkToCursor")


function ISWalkToCursor:create(x, y, z, north, sprite)
	local square = getWorld():getCell():getGridSquare(x, y, z)
	ISTimedActionQueue.clear(self.character)
	ISTimedActionQueue.add(ISWalkToTimedAction:new(self.character, square))
end

function ISWalkToCursor:isValid(square)
	return square:TreatAsSolidFloor()
end

function ISWalkToCursor:render(x, y, z, square)
	if not ISWalkToCursor.floorSprite then
		ISWalkToCursor.floorSprite = IsoSprite.new()
		ISWalkToCursor.floorSprite:LoadFramesNoDirPageSimple('media/ui/FloorTileCursor.png')
	end

	local hc = getCore():getGoodHighlitedColor()
	if not self:isValid(square) then
		hc = getCore():getBadHighlitedColor()
	end
	ISWalkToCursor.floorSprite:RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)
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
	return o
end

