--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase"

ISMusicThreatStatusPanel = ISDebugSubPanelBase:derive("ISMusicThreatStatusPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISMusicThreatStatusPanel:createChildren()
	local x,y = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1
	local w = self.width-x*2

	self:initHorzBars(x, w)

    local barMod = UI_BORDER_SPACING
	local statusCount = MusicThreatConfig.getInstance():getStatusCount()
	for i=1,statusCount do
		local id = MusicThreatConfig.getInstance():getStatusIdByIndex(i-1)
		y, obj = self:addFloatOption(id, id, x, y, w)
		y = ISDebugUtils.addHorzBar(self,y + barMod) + barMod+1
	end

	local btnWidth = 150
	y, self.buttonReload = ISDebugUtils.addButton(self, nil, self.width - UI_BORDER_SPACING - btnWidth - 1, self.height - BUTTON_HGT - UI_BORDER_SPACING - 1, btnWidth, BUTTON_HGT, getText("IGUI_IntensityEvents_Reload"), self.onButtonReload)
	self.buttonReload.tooltip = getText("IGUI_ThreatStatus_Reload")
end

function ISMusicThreatStatusPanel:render()
	self:setSliders()
	ISDebugSubPanelBase.render(self)
	local player = getSpecificPlayer(0)
	if player then
		local mtss = player:getMusicThreatStatuses()
		local intensity = mtss:getIntensity()
		local f = math.min(intensity, 100) / 100
		local barX = UI_BORDER_SPACING+1
		local barWid = self.width - barX*2 - UI_BORDER_SPACING - self.buttonReload.width
		local barHgt = BUTTON_HGT
		local barY = self.height - UI_BORDER_SPACING - barHgt - 1
		self:drawProgressBar(barX, barY, barWid, barHgt, f, { r=0.0,g=0.0,b=1.0,a=1.0 })
		self:drawText(string.format(getText("IGUI_IntensityEvents_Intensity").." - %.2f / 100", f * 100), barX + UI_BORDER_SPACING, barY + (barHgt - FONT_HGT_SMALL) / 2, 1, 1, 1, 1, UIFont.Small)
	end
end

function ISMusicThreatStatusPanel:setSliders()
	local player = getSpecificPlayer(0)
	if player == nil then return end
	local mtss = player:getMusicThreatStatuses()
	local mtc = MusicThreatConfig.getInstance()
	local count = mtss:getStatusCount()
	for i=1,count do
		local status = mtss:getStatusByIndex(i-1)
		self.floats[status:getId()].slider:setCurrentValue(status:getIntensity())
	end
end

-- From ClimateOptionsDebug.lua
function ISMusicThreatStatusPanel:addFloatOption(_label, _id, _x, _y, _w)
	local tickOptions = {}
	table.insert(tickOptions, { text = _label, ticked = false })

	local y, obj = ISDebugUtils.addTickBox(self,_id,_x,_y,(_w-300)-30,BUTTON_HGT,_id,tickOptions,ISMusicThreatStatusPanel.onTicked)
	local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false)
	local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ISMusicThreatStatusPanel.onSliderChange)
	obj3.valueLabel = obj2
	obj3:setValues(0.0, 1.0, 0.01, 0.01)
	obj3:setCurrentValue(0)

	self.floats[_id] = { option = _id, tickbox = obj, label = obj2, slider = obj3 }
	self.allOptions[_id] = self.floats[_id]

	return y>y3 and y or y3
end

function ISMusicThreatStatusPanel:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
	local s = self.allOptions[_tickbox.customData]
	local mtc = MusicThreatConfig.getInstance()
	if mtc:isStatusIntensityOverridden(s.option) then
		mtc:setStatusIntensityOverride(s.option, -1.0)
	else
		mtc:setStatusIntensityOverride(s.option, s.slider:getCurrentValue())
	end
end

function ISMusicThreatStatusPanel:onSliderChange(_newval, _slider)
	local mtc = MusicThreatConfig.getInstance()
	local s = self.floats[_slider.customData]
	if s then
		if s.slider.pretext then
			s.label:setName(s.slider.pretext..ISDebugUtils.printval(_newval,3))
		else
			s.label:setName(ISDebugUtils.printval(_newval,3))
		end
		mtc:setStatusIntensityOverride(s.option, s.tickbox:isSelected(1) and s.slider:getCurrentValue() or -1.0)
	end
end

function ISMusicThreatStatusPanel:onButtonReload()
	reloadLuaFile("media/lua/client/Music/MusicThreatConfig.lua")
end

function ISMusicThreatStatusPanel:new(x, y, width, height, doStencil)
	local o = ISDebugSubPanelBase.new(self, x, y, width, height, doStencil)
	o.allOptions = {}
	o.floats = {}
	return o
end

