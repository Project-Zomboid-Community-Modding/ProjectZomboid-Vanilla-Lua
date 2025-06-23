--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISCleanBloodCursor = ISBuildingObject:derive("ISCleanBloodCursor")

function ISCleanBloodCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISCleanBloodCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local square = getWorld():getCell():getGridSquare(x, y, z)
	ISWorldObjectContextMenu.doCleanBlood(self.character, square)
end

function ISCleanBloodCursor:isValid(square)
	return ISWorldObjectContextMenu.canCleanBlood(self.character, square)
end

function ISCleanBloodCursor:render(x, y, z, square)
	local hc = getCore():getGoodHighlitedColor()
	if not self:isValid(square) then
		hc = getCore():getBadHighlitedColor()
	end
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)
end

function ISCleanBloodCursor:new(sprite, northSprite, character)
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
	showDebugInfoInChat("Cursor New \'ISCleanBloodCursor\'")
	return o
end

