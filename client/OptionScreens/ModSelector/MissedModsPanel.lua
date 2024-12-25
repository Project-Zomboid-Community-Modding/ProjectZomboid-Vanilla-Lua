--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModSelector"

local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

ModSelector.MissedModsPanel = ISPanelJoypad:derive("MissedModsPanel")
local MissedModsPanel = ModSelector.MissedModsPanel

function MissedModsPanel:new(x, y, width, height, data)
    local o = ISPanelJoypad:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.data = data
    o.borderColor.a = 0

    return o
end

function MissedModsPanel:createChildren()
    local y = 10
    for k, v in pairs(self.data) do
        local button = ISButton:new(25, y, 550, FONT_HGT_MEDIUM + 6, k, self, MissedModsPanel.onOptionMouseDown)
        button.internal = v
        button:initialise()
        button:instantiate()
        button:setFont(UIFont.Medium)
        self:addChild(button)
        y = y + FONT_HGT_MEDIUM + 6 + 5
    end
    self:setScrollHeight(y)
end

function MissedModsPanel:onOptionMouseDown(button)
    activateSteamOverlayToWorkshopItem(button.internal)
end

function MissedModsPanel:prerender()
    ISPanelJoypad.prerender(self)
    self:setStencilRect(0, 0, self.width, self.height)
end

function MissedModsPanel:render()
    ISPanelJoypad.render(self)
    self:clearStencilRect()
    self:repaintStencilRect(0, 0, self.width, self.height)
end

----

ModSelector.MissedModsWindow = ISPanelJoypad:derive("MissedModsWindow")
local MissedModsWindow = ModSelector.MissedModsWindow

function MissedModsWindow:new(x, y, width, height, data)
    local o = ISPanelJoypad:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.data = data

    o.backgroundColor.a = 0.9

    return o
end

function MissedModsWindow:prerender()
    ISPanelJoypad.prerender(self)
    self:drawTextCentre(getText("UI_modselector_MissedModsTitle"), self.width / 2, 5, 1, 1, 1, 1, UIFont.Title)
end

function MissedModsWindow:createChildren()
    local panel = MissedModsPanel:new(0, 40, self.width, self.height - 90, self.data)
    panel:initialise()
    panel:instantiate()
    panel:setAnchorRight(true)
    panel:setAnchorBottom(true)
    panel:addScrollBars()
    panel:setScrollChildren(true)
    panel.vscroll.doSetStencil = false
    self:addChild(panel)

    local button = ISButton:new(self.width/2 - 50, self.height - 40, 100, 30, getText("UI_Ok"), self, MissedModsWindow.onOptionMouseDown)
    button.internal = "OK"
    button:initialise()
    button:instantiate()
    self:addChild(button)
end

function MissedModsWindow:onOptionMouseDown(button)
    self:setVisible(false)
    self:removeFromUIManager()
    ModSelector.instance:setVisible(true)
end






