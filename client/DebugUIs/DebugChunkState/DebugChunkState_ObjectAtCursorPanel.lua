--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10

DebugChunkState_ObjectAtCursorPanel = ISPanel:derive("DebugChunkState_ObjectAtCursorPanel")
local ObjectAtCursorPanel = DebugChunkState_ObjectAtCursorPanel

function ObjectAtCursorPanel:createChildren()
	local combo = ISComboBox:new(0, 0, self.width, BUTTON_HGT, self, self.onChangeObject)
	self:addChild(combo)
	self.combo = combo

	combo:addOption("box")
	combo:addOption("cylinder")
	combo:addOption("plane")
	combo:addOption("player")
	combo:select(self.debugChunkState.gameState:fromLua1("getObjectAtCursor", "id"))

	local sliderHgt = BUTTON_HGT
	local slider = ISSliderPanel:new(UI_BORDER_SPACING+1, combo:getBottom() + UI_BORDER_SPACING, 100, sliderHgt, self, self.onLevelsChanged)
	self:addChild(slider)
	self.sliderLevels = slider

	local label = ISLabel:new(slider:getRight() + UI_BORDER_SPACING, slider.y, sliderHgt, "Levels", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(label)
	slider.valueLabel = label
	slider:setValues(1.0, 10.0, 1.0, 1.0, true)
	slider:setCurrentValue(self.debugChunkState.gameState:fromLua1("getObjectAtCursor", "levels"), false)

	slider = ISSliderPanel:new(UI_BORDER_SPACING+1, slider:getBottom() + UI_BORDER_SPACING, 100, sliderHgt, self, self.onWidthChanged)
	self:addChild(slider)
	self.sliderWidth = slider

	label = ISLabel:new(slider:getRight() + UI_BORDER_SPACING, slider.y, sliderHgt, "Width", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(label)
	slider.valueLabel = label
	slider:setValues(0.5, 20.0, 0.5, 1.0, true)
	slider:setCurrentValue(self.debugChunkState.gameState:fromLua1("getObjectAtCursor", "width"), false)

	slider = ISSliderPanel:new(UI_BORDER_SPACING+1, self.sliderLevels:getY(), 100, sliderHgt, self, self.onScaleChanged)
	self:addChild(slider)
	self.sliderScale = slider

	label = ISLabel:new(slider:getRight() + UI_BORDER_SPACING, slider.y, sliderHgt, "Scale", 1, 1, 1, 1, UIFont.Medium, true)
	self:addChild(label)
	slider.valueLabel = label
	slider:setValues(1.0, 10.0, 1.0, 1.0, true)
	slider:setCurrentValue(self.debugChunkState.gameState:fromLua1("getObjectAtCursor", "scale"), false)

	self:syncUI()
end

function ObjectAtCursorPanel:update()
	ISPanel.update(self)
end

function ObjectAtCursorPanel:render()
	ISPanel.render(self)
end

function ObjectAtCursorPanel:syncUI()
	local id = self.debugChunkState.gameState:fromLua1("getObjectAtCursor", "id")
	if id == "player" then
		self.sliderLevels:setVisible(false)
		self.sliderLevels.valueLabel:setVisible(false)
		self.sliderWidth:setVisible(false)
		self.sliderWidth.valueLabel:setVisible(false)
		self.sliderScale:setVisible(true)
		self.sliderScale.valueLabel:setVisible(true)
	elseif id == "plane" then
		self.sliderLevels:setVisible(false)
		self.sliderLevels.valueLabel:setVisible(false)
		self.sliderWidth:setVisible(true)
		self.sliderWidth.valueLabel:setVisible(true)
		self.sliderScale:setVisible(false)
		self.sliderScale.valueLabel:setVisible(false)
	else
		self.sliderLevels:setVisible(true)
		self.sliderLevels.valueLabel:setVisible(true)
		self.sliderWidth:setVisible(true)
		self.sliderWidth.valueLabel:setVisible(true)
		self.sliderScale:setVisible(false)
		self.sliderScale.valueLabel:setVisible(false)
	end
	
	self:shrinkWrap(0, 0, function(child) return child:isVisible() end)
	self:setHeight(self:getHeight()+UI_BORDER_SPACING+1)
end

function ObjectAtCursorPanel:onChangeObject()
	self.debugChunkState.gameState:fromLua2("setObjectAtCursor", "id", self.combo:getSelectedText())
	self:syncUI()
end

function ObjectAtCursorPanel:onLevelsChanged(value, slider)
	self.debugChunkState.gameState:fromLua2("setObjectAtCursor", "levels", value)
	slider.valueLabel:setName(string.format("Levels: %d", value))
end

function ObjectAtCursorPanel:onWidthChanged(value, slider)
	self.debugChunkState.gameState:fromLua2("setObjectAtCursor", "width", value)
	slider.valueLabel:setName(string.format("Width: %.1f", value))
end

function ObjectAtCursorPanel:onScaleChanged(value, slider)
	self.debugChunkState.gameState:fromLua2("setObjectAtCursor", "scale", value)
	slider.valueLabel:setName(string.format("Scale: %.1f", value))
end

function ObjectAtCursorPanel:new(x, y, width, height, debugChunkState)
	height = BUTTON_HGT
	local o = ISPanel.new(self, x, y, width, height)
	o.backgroundColor.a = 0.9
	o.debugChunkState = debugChunkState
	return o
end



