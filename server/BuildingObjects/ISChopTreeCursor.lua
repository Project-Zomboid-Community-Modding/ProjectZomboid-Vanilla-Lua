--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISChopTreeCursor = ISBuildingObject:derive("ISChopTreeCursor")

function ISChopTreeCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISChopTreeCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	local square = getWorld():getCell():getGridSquare(x, y, z)
	ISWorldObjectContextMenu.doChopTree(self.character, square:getTree())
end

function ISChopTreeCursor:isValid(square)
	return square:HasTree()
end

function ISChopTreeCursor:render(x, y, z, square)
    if self.character:getVehicle() then
        getCell():setDrag(nil, self.player)
    end

	local hc = getCore():getBadHighlitedColor()
	if self:isValid(square) then
		hc = getCore():getGoodHighlitedColor()
		square:getTree():setHighlighted(true)
	end
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)
	IsoTree.setChopTreeCursorLocation(self.player, x, y, z)
end

function ISChopTreeCursor:getAPrompt()
	if self.canBeBuild then
		return getText("ContextMenu_Chop_Tree")
	end
	return nil
end

function ISChopTreeCursor:new(sprite, northSprite, character)
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
	showDebugInfoInChat("Cursor New \'ISChopTreeCursor\'")
	return o
end

