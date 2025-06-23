ISSelectCursor = ISBuildingObject:derive("ISSelectCursor")

function ISSelectCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISSelectCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	getCell():setDrag(nil, self.player)
	self.ui:onSquareSelected(getWorld():getCell():getGridSquare(x, y, z))
end

function ISSelectCursor:isValid(square)
	return self.ui.cursor ~= nil;
end

function ISSelectCursor:render(x, y, z, square)
	local hc = getCore():getGoodHighlitedColor()
	if not self:isValid(square) then
		hc = getCore():getBadHighlitedColor()
	end
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)
end

function ISSelectCursor:new(character, ui, onSquareSelected)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o.ui = ui;
	o.onSquareSelected = onSquareSelected;
	o.character = character
	o.player = character:getPlayerNum()
	o.noNeedHammer = true
	o.skipBuildAction = true
	showDebugInfoInChat("Cursor New \'ISSelectCursor\'")
	return o
end
