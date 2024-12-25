--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase"

ISMusicIntensityEventsPanel = ISDebugSubPanelBase:derive("ISMusicIntensityEventsPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISMusicIntensityEventsPanel:createChildren()
	self.eventList = ISScrollingListBox:new(0, 0, self.width, self.height - UI_BORDER_SPACING*3 - BUTTON_HGT*2 - 1)
	self.eventList.drawBorder = true
	self.eventList.doDrawItem = self.doDrawItem
	self.eventList:setFont(UIFont.Small, 3)
	self:addChild(self.eventList)

	self.buttonClear = ISButton:new(UI_BORDER_SPACING+1, self.eventList:getBottom() + UI_BORDER_SPACING, 150, BUTTON_HGT, getText("IGUI_IntensityEvents_Clear"), self, self.onButtonClear)
	self.buttonClear.tooltip = getText("IGUI_IntensityEvents_Clear_Tooltip")
	self:addChild(self.buttonClear)

	self.buttonReload = ISButton:new(self.buttonClear:getRight() + UI_BORDER_SPACING, self.buttonClear:getY(), 150, BUTTON_HGT, getText("IGUI_IntensityEvents_Reload"), self, self.onButtonReload)
	self.buttonReload.tooltip = getText("IGUI_IntensityEvents_Reload_Tooltip")
	self:addChild(self.buttonReload)
end

function ISMusicIntensityEventsPanel:render()
	self.eventList.doDrawItem = self.doDrawItem
	self:populateEventList()
	ISDebugSubPanelBase.render(self)
	local player = getSpecificPlayer(0)
	if player then
		local mie = player:getMusicIntensityEvents()
		local intensity = mie:getIntensity()
		local f = math.min(intensity, 100) / 100
		local barX = UI_BORDER_SPACING+1
		local barWid = self.width - barX*2
		local barHgt = BUTTON_HGT
		local barY = self.height - UI_BORDER_SPACING - barHgt - 1
		self:drawProgressBar(barX, barY, barWid, barHgt, f, { r=0.0,g=0.0,b=1.0,a=1.0 })
		self:drawText(string.format(getText("IGUI_IntensityEvents_Intensity").." - %.2f / 100", f * 100), barX + UI_BORDER_SPACING, barY + (barHgt - FONT_HGT_SMALL) / 2, 1, 1, 1, 1, UIFont.Small)
	end
end

function ISMusicIntensityEventsPanel:populateEventList()
	self.eventList:clear()
	local player = getSpecificPlayer(0)
	if player == nil then return end
	local mie = player:getMusicIntensityEvents()
	local count = mie:getEventCount()
	for i=1,count do
		local event = mie:getEventByIndex(i-1)
		self.eventList:addItem(event:getId(), event)
	end
	self.buttonClear.enable = self.eventList:size() > 0
end

function ISMusicIntensityEventsPanel:doDrawItem(y, item, alt)
	local a = 0.9
	self:drawRectBorder(0, y, self:getWidth(), item.height, a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	if self.selected == item.index then
		self:drawRect(0, y, self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
	end
	local event = item.item
	local f = 1 - event:getElapsedTime() / event:getDuration()
	local barWid = 200
	local barHgt = item.height - 2
	self:drawProgressBar(self:getWidth() - 1 - barWid, y + (item.height - barHgt) / 2, barWid, barHgt, f, { r=0.0,g=0.0,b=1.0,a=1.0 })
	self:drawText(string.format("%s - %.2f", item.text, event:getIntensity()), 10, y + (item.height - FONT_HGT_SMALL) / 2, 1, 1, 1, a, self.font)
	return y + item.height
end

function ISMusicIntensityEventsPanel:onButtonClear()
	local player = getSpecificPlayer(0)
	if player == nil then return end
	player:getMusicIntensityEvents():clear()
end

function ISMusicIntensityEventsPanel:onButtonReload()
	reloadLuaFile("media/lua/client/Music/MusicIntensityConfig.lua")
end

function ISMusicIntensityEventsPanel:new(x, y, width, height, doStencil)
	local o = ISDebugSubPanelBase.new(self, x, y, width, height, doStencil)
	return o
end

