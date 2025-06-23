--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISCollapsableWindow"

ISDebugAnimationTextUI = ISCollapsableWindow:derive("ISDebugAnimationTextUI")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function ISDebugAnimationTextUI:createChildren()
	ISCollapsableWindow.createChildren(self)
	local th = self:titleBarHeight()
	local rh = self:resizeWidgetHeight()
	local textBox = ISTextEntryBox:new("", 0, 0 + th, self.width, self.height - th - rh)
	textBox:initialise()
	textBox:setAnchorRight(true)
	textBox:setAnchorBottom(true)
	self:addChild(textBox)
	textBox:setEditable(false)
	textBox:setMultipleLine(true)
	textBox:addScrollBars()
	self.textBox = textBox
end

function ISDebugAnimationTextUI:setText()
	local text = self.character:getAnimationDebug()
	self.textBox:setText(text)
end

function ISDebugAnimationTextUI:prerender()
	ISCollapsableWindow.prerender(self)
	if self.isCollapsed then
		if self.isHighlighted then
			self.character:setOutlineHighlight(false)
			self.isHighlighted = false
		end
		return
	end
	local highlight = self:isMouseOver()
	if highlight then
		self.character:setOutlineHighlight(true)
		self.character:setOutlineHighlightCol(1.0, 1.0, 1.0, 1.0)
		self.isHighlighted = true
	elseif self.isHighlighted then
		self.character:setOutlineHighlight(false)
		self.isHighlighted = false
	end
	if self.character:getMovingObjectIndex() == -1 then
		self:setVisible(false)
		self:removeFromUIManager()
		return
	end
	self:setText()
end

function ISDebugAnimationTextUI:new(x, y, width, height, chr)
	local o = ISCollapsableWindow.new(self, x, y, width, height)
	o.title = "Animation Text"
	o.character = chr
	return o
end

