--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModInfoPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10

ModInfoPanel.InteractionParam = ISPanelJoypad:derive("ModInfoPanelInteractionParam")

function ModInfoPanel.InteractionParam:render()
    self:drawRectBorder(0, 0, self.borderX, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    self:drawText(self.name, self.borderX - UI_BORDER_SPACING - self.labelWidth, (BUTTON_HGT - FONT_HGT_SMALL) / 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small)

    for index,val in ipairs(self.modDict) do
        local y = (index - 1) * BUTTON_HGT + 2
        self:drawText(val.id, self.borderX + self.padX, y, val.color.r, val.color.g, val.color.b, 0.9, UIFont.Small)
        if not (self:isMouseOver() and self:getMouseX() > self.borderX + self.padX and self:getMouseX() < self.borderX + self.padX + val.len
                and self:getMouseY() > y and self:getMouseY() < y + FONT_HGT_SMALL + 1) then
            self:drawRectBorder(self.borderX + self.padX, y+FONT_HGT_SMALL, val.len, 1, 0.9, val.color.r, val.color.g, val.color.b)
        else
            if self.pressed then
                if val.available then
                    self.parent:setModInfo(val.modInfo)
                else
                    local t = luautils.split(val.id, "\\")
                    if t[1] ~= "" then
                        activateSteamOverlayToWorkshopItem(t[1])
                    end
                end
            end
        end
    end
    self.pressed = false
end

function ModInfoPanel.InteractionParam:onMouseDown(x, y)
    self.pressed = true
end

function ModInfoPanel.InteractionParam:setModInfo(modInfo)
    self.modInfo = modInfo
    local model = self.parent.parent.model
    local modData = model.mods[modInfo:getId()]

    self.modDict = {}
    if self.type == "Dependencies" and self.modInfo:getRequire() ~= nil then
        for id, _ in pairs(modData.requireMods) do
            local color = { r = 0.9, g = 0.0, b = 0.0 }
            local available = false
            local modInfo2
            if model.mods[id] then
                available = true
                modInfo2 = model.mods[id].modInfo
                if model.mods[id].isActive then
                    color = { r = 0.0, g = 0.9, b = 0.0 }
                else
                    color = { r = 0.9, g = 0.9, b = 0.9 }
                end
            end
            table.insert(self.modDict, { id = id, color = color, len = getTextManager():MeasureStringX(UIFont.Small, id), available = available, modInfo = modInfo2 })
        end
    end
    if self.type == "IncompatibleWith" and self.modInfo:getIncompatible() ~= nil then
        for id, _ in pairs(model.incompatibles[modInfo:getId()]) do
            local color = { r = 0.9, g = 0.0, b = 0.0 }
            local available = false
            local modInfo2
            if model.mods[id] then
                available = true
                modInfo2 = model.mods[id].modInfo
                if model.mods[id].isActive then
                    color = { r = 0.9, g = 0.0, b = 0.0 }
                else
                    color = { r = 0.9, g = 0.9, b = 0.9 }
                end
            end
            table.insert(self.modDict, { id = id, color = color, len = getTextManager():MeasureStringX(UIFont.Small, id), available = available, modInfo = modInfo2 })
        end
    end
    self:setHeight(#self.modDict == 0 and BUTTON_HGT or (#self.modDict)*BUTTON_HGT)
end

function ModInfoPanel.InteractionParam:new(x, y, width, type)
    local o = ISPanelJoypad:new(x, y, width, BUTTON_HGT)
    setmetatable(o, self)
    self.__index = self
    o.type = type
    o.name = getText(type)
    o.labelWidth = getTextManager():MeasureStringX(UIFont.Small, o.name)
    o.padX = UI_BORDER_SPACING
    o.padY = UI_BORDER_SPACING
    o.modDict = {}
    o.borderX = width / 4.0
    return o
end
