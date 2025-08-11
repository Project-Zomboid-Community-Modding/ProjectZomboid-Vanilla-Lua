--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require('ISUI/ISPanelJoypad')

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10

ISMapSymbolZoomPanel = ISPanelJoypad:derive("ISMapSymbolZoomPanel")

function ISMapSymbolZoomPanel:createChildren()
    local spinBoxWidth = getTextManager():MeasureStringX(UIFont.Small, " 99.9 ") + 15 * 2 + 2

    local label = ISLabel:new(UI_BORDER_SPACING, 0, FONT_HGT_SMALL, getText("UI_Zoom"), 1.0, 1.0, 1.0, 1.0, UIFont.Small, true)
    self:addChild(label)

    self.minZoomBox = ISSpinBox:new(label:getRight() + UI_BORDER_SPACING, 0, 80, FONT_HGT_SMALL + 2 * 2, self, self.onChangeMinZoom)
    self:addChild(self.minZoomBox)
    self:initSpinBox(self.minZoomBox)

    self.maxZoomBox = ISSpinBox:new(self.minZoomBox:getRight() + UI_BORDER_SPACING, 0, 80, FONT_HGT_SMALL + 2 * 2, self, self.onChangeMaxZoom)
    self:addChild(self.maxZoomBox)
    self:initSpinBox(self.maxZoomBox)
end

function ISMapSymbolZoomPanel:initSpinBox(spinBox)
    for i=0,24 do
        spinBox:addOption(string.format("%d", i))
        if i == 24 then break end
        spinBox:addOption(string.format("%d.5", i))
    end
end

function ISMapSymbolZoomPanel:onChangeMinZoom()
    local min = self:getZoom(self.minZoomBox)
    local max = self:getZoom(self.maxZoomBox)
    if min > max then
        self.minZoomBox.selected = self.maxZoomBox.selected
        min = max
    end
    self.parent.minZoom = min
end

function ISMapSymbolZoomPanel:onChangeMaxZoom()
    local min = self:getZoom(self.minZoomBox)
    local max = self:getZoom(self.maxZoomBox)
    if max < min then
        self.maxZoomBox.selected = self.minZoomBox.selected
        max = min
    end
    self.parent.maxZoom = max
end

function ISMapSymbolZoomPanel:setMinMaxZoom(minZoomF, maxZoomF)
    self.minZoomBox.selected = self:findClosestZoom(self.minZoomBox, minZoomF)
    self.maxZoomBox.selected = self:findClosestZoom(self.maxZoomBox, maxZoomF)
    self.parent.minZoom = self:getZoom(self.minZoomBox)
    self.parent.maxZoom = self:getZoom(self.maxZoomBox)
end

function ISMapSymbolZoomPanel:findClosestZoom(spinBox, zoomF)
    for index,text in ipairs(spinBox.options) do
        local value = tonumber(text)
        if value >= zoomF then
            return index
        end
    end
    return #spinBox.options
end

function ISMapSymbolZoomPanel:getZoom(spinBox)
    return tonumber(spinBox.options[spinBox.selected])
end

function ISMapSymbolZoomPanel:new(x, y, width, height)
    local o = ISPanelJoypad.new(self, x, y, width, height)
    o:noBackground()
    return o
end
