ISBuildCursorMouse = ISBuildingObject:derive("ISBuildCursorMouse")

function ISBuildCursorMouse:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISBuildCursorMouse\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
	self:hideTooltip();
	self:onSquareSelected(getWorld():getCell():getGridSquare(x, y, z))
end

function ISBuildCursorMouse:render(x, y, z, square)
	self.sq = square;
	if self.chosenSprite or self.previousSprite then
		if not self.chosenSprite then
			self.chosenSprite = self.previousSprite;
		end
		self.previousSprite = self.chosenSprite;
		ISBuildCursorMouse.spriteRender = IsoSprite.new()
		ISBuildCursorMouse.spriteRender:LoadSingleTexture(self.chosenSprite)
		local r,g,b,a = 0.0,1.0,0.0,0.8
		if not self:isValid(square) then
			r = 1.0
			g = 0.0
		end
		ISBuildCursorMouse.spriteRender:RenderGhostTileColor(x, y, z, r, g, b, a)
	end
	
	self:renderTooltip();
end

-- Called by IsoCell.setDrag()
function ISBuildCursorMouse:deactivate()
	self:hideTooltip();
end

function ISBuildCursorMouse:hideTooltip()
	if self.tooltip then
		self.tooltip:removeFromUIManager()
		self.tooltip:setVisible(false)
		self.tooltip = nil
	end
end

function ISBuildCursorMouse:renderTooltip()
	if not self.tooltipTxt then
		self:hideTooltip();
		return;
	end
	
	if not self.tooltip then
		self.tooltip = ISWorldObjectContextMenu.addToolTip();
		self.tooltip:setVisible(true)
		self.tooltip:addToUIManager()
		self.tooltip.followMouse = not self.joyfocus
		self.tooltip.maxLineWidth = 1000
		self.tooltip:setTexture(self.chosenSprite)
	else
		self.tooltip:setName(self.tooltipName);
		self.tooltip.description = self.tooltipTxt;
	end
end

function ISBuildCursorMouse.IsVisible()
	return ISBuildMenu.cursor and getCell():getDrag(0) == ISBuildMenu.cursor
end

function ISBuildCursorMouse:new(character, onSquareSelected, isValid)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o:init()
	o.onSquareSelected = onSquareSelected;
	o.isValid = isValid;
	o.character = character
	o.player = character:getPlayerNum()
	o.noNeedHammer = true
	o.skipBuildAction = true
	showDebugInfoInChat("Cursor New \'ISBuildCursorMouse\'")
	return o
end
