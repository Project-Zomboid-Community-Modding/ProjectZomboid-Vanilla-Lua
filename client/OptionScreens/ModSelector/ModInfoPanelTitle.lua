--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModInfoPanel"

local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local LABEL_HGT = FONT_HGT_MEDIUM + 6
local UI_BORDER_SPACING = 10

ModInfoPanel.Title = ISPanelJoypad:derive("ModInfoPanelTitle")

function ModInfoPanel.Title:createChildren()
    self.title = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, LABEL_HGT, getText("UI_modselector_title"), 1.0, 1.0, 1.0, 1.0, UIFont.Medium, true)
    self:addChild(self.title)
end

function ModInfoPanel.Title:setModInfo(modInfo)
    self.title.name = modInfo:getName()
end

function ModInfoPanel.Title:new(x, y, width)
    local o = ISPanelJoypad:new(x, y, width, LABEL_HGT + UI_BORDER_SPACING*2 + 1)
    setmetatable(o, self)
    self.__index = self
    return o
end