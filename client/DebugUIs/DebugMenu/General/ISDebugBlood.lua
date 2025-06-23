ISDebugBlood = ISDebugSubPanelBase:derive("ISDebugBlood")
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

function ISDebugBlood:initialise()
	ISDebugSubPanelBase.initialise(self)
end

function ISDebugBlood:createChildren()
	ISDebugSubPanelBase.createChildren(self)

	local x,y,w = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1,self.width-UI_BORDER_SPACING*2 - SCROLL_BAR_WIDTH - 1;

	self:initHorzBars(x, w)
	local barMod = UI_BORDER_SPACING;

	local obj;
	y, obj = ISDebugUtils.addLabel(self, "float_title", x+(w/2), y, getText("IGUI_DebugBlood_Title"), UIFont.Medium)
	obj.center = true
	y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

	local y2, label, value, slider
	self.partToSlider = {}
	for i=0,BloodBodyPartType.MAX:index()-1 do
		local part = BloodBodyPartType.FromIndex(i)
		y2,label = ISDebugUtils.addLabel(self, part, x, y, part:getDisplayName(), UIFont.Small)
		y2,value = ISDebugUtils.addLabel(self, part, x+(w-300)-20, y, "0", UIFont.Small, false)
		y,slider = ISDebugUtils.addSlider(self, part, x+(w-300), y, 300,BUTTON_HGT, self.onSliderChange)
		slider:setValues(0.0, 1.0, 0.01, 0.01, true)
--		slider:setCurrentValue(getPlayer():getHumanVisual():getBlood(part))
		self.partToSlider[part] = slider
		y = ISDebugUtils.addHorzBar(self, math.max(y,y2)+barMod)+barMod+1
	end

	local zeroWidthText = getText("IGUI_DebugBlood_ZeroAll")
	local addRandomText = getText("IGUI_DebugBlood_AddRandom")
	local zeroWidth = UI_BORDER_SPACING*2+getTextManager():MeasureStringX(UIFont.Small, zeroWidthText)
	local randomWidth = UI_BORDER_SPACING*2+getTextManager():MeasureStringX(UIFont.Small, addRandomText)
	y,obj = ISDebugUtils.addButton(self, "zeroAll", x, y, zeroWidth, BUTTON_HGT, zeroWidthText, self.onZeroAll)

	y = y-BUTTON_HGT --to move this button onto the same line, and next to the other button
	y,obj = ISDebugUtils.addButton(self, "addRandom", x+zeroWidth+UI_BORDER_SPACING, y, randomWidth, BUTTON_HGT, addRandomText, self.onRandomBlood)

	self:setScrollHeight(y+UI_BORDER_SPACING+1);
end

function ISDebugBlood:prerender()
	ISDebugSubPanelBase.prerender(self)
	if self.updateTime + 500 < getTimestampMs() then
		self:setSliderValues()
	end
end

function ISDebugBlood:setSliderValues()
	local playerObj = getSpecificPlayer(0)
	self.updateTime = getTimestampMs()
	for i=0,BloodBodyPartType.MAX:index()-1 do
		local part = BloodBodyPartType.FromIndex(i)
		local slider = self.partToSlider[part]
		local newValue = playerObj:getHumanVisual():getBlood(part)
		self.ignoreSlider = true
		slider:setCurrentValue(newValue)
		self.ignoreSlider = false
	end
end

function ISDebugBlood:onSliderChange(_newval, _slider)
	local playerObj = getSpecificPlayer(0)
	if self.ignoreSlider then return end
	local part = _slider.customData
	playerObj:getHumanVisual():setBlood(part, _newval)
	playerObj:resetModelNextFrame()
	triggerEvent("OnClothingUpdated", playerObj)
end

function ISDebugBlood:onZeroAll()
	local playerObj = getSpecificPlayer(0)
	playerObj:getHumanVisual():removeBlood()
	playerObj:resetModelNextFrame()
	triggerEvent("OnClothingUpdated", playerObj)
	self:setSliderValues()
end

function ISDebugBlood:onRandomBlood()
	local playerObj = getSpecificPlayer(0)
	playerObj:addBlood(nil, false, true, false)
	triggerEvent("OnClothingUpdated", playerObj)
	self:setSliderValues()
end

function ISDebugBlood:new(x, y, width, height, doStencil)
	local o = ISDebugSubPanelBase:new(x, y, width, height, doStencil)
	setmetatable(o, self)
	self.__index = self
	o.updateTime = 0
	return o
end

