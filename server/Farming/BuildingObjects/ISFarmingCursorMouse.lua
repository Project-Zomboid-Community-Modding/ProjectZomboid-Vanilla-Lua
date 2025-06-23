ISFarmingCursorMouse = ISBuildingObject:derive("ISFarmingCursorMouse")

function ISFarmingCursorMouse:create(x, y, z, north, sprite)
--	getCell():setDrag(nil, self.player)
	self:hideTooltip();
	self:onSquareSelected(getWorld():getCell():getGridSquare(x, y, z))
end

function ISFarmingCursorMouse:render(x, y, z, square)
	local hc = getCore():getGoodHighlitedColor()
	if not self:isValid(square) then
		hc = getCore():getBadHighlitedColor()
	end
	self.sq = square;
	self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, hc:getR(), hc:getG(), hc:getB(), 0.8)
	
	self:renderTooltip();
end

-- Called by IsoCell.setDrag()
function ISFarmingCursorMouse:deactivate()
	self:hideTooltip();
end

function ISFarmingCursorMouse:hideTooltip()
	if self.tooltip then
		self.tooltip:removeFromUIManager()
		self.tooltip:setVisible(false)
		self.tooltip = nil
	end
end

function ISFarmingCursorMouse:renderTooltip()
	if not self.tooltipTxt then
		self:hideTooltip();
		return;
	end
	
	if not self.tooltip then
		self.tooltip = ISWorldObjectContextMenu.addToolTip();
		self.tooltip:setVisible(true)
		self.tooltip:addToUIManager()
		self.tooltip.followMouse = not self.joypadFarming
		self.tooltip.maxLineWidth = 1000
	else
		self.tooltip.description = self.tooltipTxt;
	end

	if self.tooltip and self.joypadFarming then
		self.tooltip:setX(isoToScreenX(self.player, self.square:getX(), self.square:getY(), self.square:getZ()));
		self.tooltip:setY(isoToScreenY(self.player, self.square:getX(), self.square:getY(), self.square:getZ()));
	end
end

function ISFarmingCursorMouse:getAPrompt()
	return getText("ContextMenu_Farming")
end

function ISFarmingCursorMouse:getLBPrompt()
	return nil
end

function ISFarmingCursorMouse:getRBPrompt()
	return nil
end

function ISFarmingCursorMouse.IsVisible()
	return ISFarmingMenu.cursor and getCell():getDrag(0) == ISFarmingMenu.cursor
end

function ISFarmingCursorMouse:new(character, onSquareSelected, isValid)
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
	o.joypadFarming = JoypadState.players[o.player + 1];
	return o
end
