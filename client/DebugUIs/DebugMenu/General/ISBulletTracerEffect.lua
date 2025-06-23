ISBulletTracerEffect = ISDebugSubPanelBase:derive("ISBulletTracerEffect")
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

function ISBulletTracerEffect:initialise()
	ISDebugSubPanelBase.initialise(self)
end

function ISBulletTracerEffect:createChildren()
	ISDebugSubPanelBase.createChildren(self)

	local needsScrollBar = 1
	if self.height > (BUTTON_HGT+1)*9 + UI_BORDER_SPACING*19 + 2 + getTextManager():getFontHeight(UIFont.Medium) then
		needsScrollBar = 0
	end

	local x,y,w = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1,self.width-UI_BORDER_SPACING*2 - SCROLL_BAR_WIDTH*needsScrollBar - 1;

	self:initHorzBars(x, w)
	local barMod = UI_BORDER_SPACING;

	local obj;
	y, obj = ISDebugUtils.addLabel(self, "float_title", x+(w/2), y, getText("IGUI_BulletTracerEffect_Title"), UIFont.Medium)
	obj.center = true
	y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

	local y2, label, value, slider
	self.optionToSlider = {}
	for i=1,FBORenderTracerEffects.getInstance():getOptionCount() do
		local option = FBORenderTracerEffects.getInstance():getOptionByIndex(i-1)
		y2,label = ISDebugUtils.addLabel(self, option, x, y, getText("IGUI_BulletTracerEffect_"..option:getName()), UIFont.Small)
		y2,value = ISDebugUtils.addLabel(self, option, x+(w-300)-20,y, "0", UIFont.Small, false)
		y,slider = ISDebugUtils.addSlider(self, option, x+(w-300),y,300, BUTTON_HGT, self.onSliderChange)
		slider.valueLabel = value
		slider:setValues(option:getMin(), option:getMax(), (option:getMax() - option:getMin()) / 100, (option:getMax() - option:getMin()) / 10, true)
		self.optionToSlider[option] = slider
		y = ISDebugUtils.addHorzBar(self, math.max(y,y2)+barMod)+barMod+1
	end

	local btnWidth = UI_BORDER_SPACING*2+getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_BulletTracerEffect_Reset"))
	y,obj = ISDebugUtils.addButton(self, "restoreDefaults", x, y, btnWidth, BUTTON_HGT, getText("IGUI_BulletTracerEffect_Reset"), self.onResetToDefault)
	self:setSliderValues()
	self:setScrollHeight(y+UI_BORDER_SPACING+1);
end

function ISBulletTracerEffect:prerender()
	ISDebugSubPanelBase.prerender(self)
end

function ISBulletTracerEffect:setSliderValues()
	for i=1,FBORenderTracerEffects.getInstance():getOptionCount() do
		local option = FBORenderTracerEffects.getInstance():getOptionByIndex(i-1)
		self.ignoreSlider = true
		local slider = self.optionToSlider[option]
		slider:setCurrentValue(option:getValue())
		slider.valueLabel:setName(string.format("%.3f", option:getValue()))
		self.ignoreSlider = false
	end
end

function ISBulletTracerEffect:onSliderChange(_newval, _slider)
	if self.ignoreSlider then return end
	local option = _slider.customData
	option:setValue(_newval)
	_slider.valueLabel:setName(string.format("%.3f", option:getValue()))
	FBORenderTracerEffects.getInstance():save()
end

function ISBulletTracerEffect:onResetToDefault()
	for i=1,FBORenderTracerEffects.getInstance():getOptionCount() do
		local option = FBORenderTracerEffects.getInstance():getOptionByIndex(i-1)
		option:resetToDefault()
	end
	FBORenderTracerEffects.getInstance():save()
	self:setSliderValues()
end

function ISBulletTracerEffect:new(x, y, width, height, doStencil)
	local o = ISDebugSubPanelBase:new(x, y, width, height, doStencil)
	setmetatable(o, self)
	self.__index = self
	return o
end

