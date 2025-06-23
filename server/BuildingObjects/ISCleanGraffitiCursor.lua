--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISCleanGraffitiCursor = ISBuildingObject:derive("ISCleanGraffitiCursor")

function ISCleanGraffitiCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISCleanGraffitiCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local square = getWorld():getCell():getGridSquare(x, y, z)
	ISWorldObjectContextMenu.doCleanGraffiti(self.character, square)
end

function ISCleanGraffitiCursor:isValid(square)
	return ISWorldObjectContextMenu.canCleanGraffiti(self.character, square)
end

function ISCleanGraffitiCursor:render(x, y, z, square)
	local hc = getCore():getGoodHighlitedColor()
	if not self:isValid(square) then
		hc = getCore():getBadHighlitedColor()
	end
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)
end

function ISCleanGraffitiCursor:new(sprite, northSprite, character)
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
	showDebugInfoInChat("Cursor New \'ISCleanGraffitiCursor\'")
	return o
end

