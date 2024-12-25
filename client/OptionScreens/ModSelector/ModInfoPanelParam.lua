--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModInfoPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10

ModInfoPanel.Param = ISPanelJoypad:derive("ModInfoPanelParam")

function ModInfoPanel.Param:render()
    self:drawRectBorder(0, 0, self.borderX, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    self:drawText(self.name, self.borderX - UI_BORDER_SPACING - self.labelWidth, 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small)

    if self.modInfo == nil then return end

    if self.type == "Status" then
        if self.parent.parent.model:isModActive(self.modInfo:getId()) then
            self:drawText(getText("UI_mods_ModEnabled"), self.borderX+UI_BORDER_SPACING, 2, 0.0, 0.9, 0.0, 0.9, UIFont.Small)
        else
            self:drawText(getText("UI_mods_ModDisabled"), self.borderX+UI_BORDER_SPACING, 2, 0.9, 0.0, 0.0, 0.9, UIFont.Small)
        end
    elseif self.type == "Version" then
        self:drawText(self.modInfo:getModVersion(), self.borderX+UI_BORDER_SPACING, 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small)
    elseif self.type == "Author" then
        self:drawText(self.modInfo:getAuthor(), self.borderX+UI_BORDER_SPACING, 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small)
    elseif self.type == "Homepage" then
        self:drawText(self.modInfo:getUrl(), self.borderX+UI_BORDER_SPACING, 2, 0.05, 0.45, 0.7, 0.9, UIFont.Small)
        if self.modInfo:getUrl() ~= "" and not (self:isMouseOver() and self:getMouseX() > self.borderX+UI_BORDER_SPACING and self:getMouseX() < self.borderX+UI_BORDER_SPACING + self.urlLen
                and self:getMouseY() > 2 and self:getMouseY() < 2 + FONT_HGT_SMALL + 1) then
            self:drawRectBorder(self.borderX+UI_BORDER_SPACING, 1+FONT_HGT_SMALL, self.urlLen, 1, 0.9, 0.05, 0.45, 0.7)
        elseif self.modInfo:getUrl() ~= "" and self.pressed then
            local w = 300
            local h = 200
            local modal = ISModalDialog:new(getCore():getScreenWidth()/2 - w/2, getCore():getScreenHeight() / 2 - h/2, w, h, getText("UI_mods_openModUrl"), true, self, self.openUrl, _, self.modInfo:getUrl())
            modal:initialise()
            modal:addToUIManager()
            modal:bringToTop()
        end
    elseif self.type == "ModLink" then
        self:drawText(self.modLink, self.borderX+UI_BORDER_SPACING, 2, 0.05, 0.45, 0.7, 0.9, UIFont.Small)
        if self.modLink ~= "" and not (self:isMouseOver() and self:getMouseX() > self.borderX+UI_BORDER_SPACING and self:getMouseX() < self.borderX+UI_BORDER_SPACING + self.modLinkLen
                and self:getMouseY() > 2 and self:getMouseY() < 2 + FONT_HGT_SMALL + 1) then
            self:drawRectBorder(self.borderX+UI_BORDER_SPACING, 1+FONT_HGT_SMALL, self.modLinkLen, 1, 0.9, 0.05, 0.45, 0.7)
        elseif self.modLink ~= "" and self.pressed then
            activateSteamOverlayToWorkshopItem(self.workshopID)
        end
    elseif self.type == "ModID" then
        self:drawText(self.modInfo:getId(), self.borderX+UI_BORDER_SPACING, 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small)
    elseif self.type == "WorkshopID" then
        self:drawText(self.workshopID, self.borderX+UI_BORDER_SPACING, 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small)
    elseif self.type == "ZomboidVersion" then
        if self.modInfo:isAvailableSelf() then
            self:drawText(self.zomboidVersion, self.borderX+UI_BORDER_SPACING, 2, 0.9, 0.9, 0.9, 0.9, UIFont.Small)
        else
            self:drawText("AVAILABLE ONLY IN DEBUG (mod must be updated to " .. getBreakModGameVersion():toString() .. "+ version)", self.borderX+UI_BORDER_SPACING, 2, 0.9, 0.0, 0.0, 0.9, UIFont.Small)
        end
    end
    self.pressed = false
end

function ModInfoPanel.Param:openUrl(button, url)
    if button.internal == "YES" then
        openUrl(url)
    end
end

function ModInfoPanel.Param:onMouseDown(x, y)
    self.pressed = true
end

function ModInfoPanel.Param:setModInfo(modInfo)
    self.modInfo = modInfo

    self.zomboidVersion = (self.modInfo:getVersionMin() and self.modInfo:getVersionMin():toString() or "**")
            .. " - "
            .. (self.modInfo:getVersionMax() and self.modInfo:getVersionMax():toString() or "**")
    self.workshopID = self.modInfo:getWorkshopID() == nil and "" or self.modInfo:getWorkshopID()
    self.modLink = self.workshopID ~= "" and "https://steamcommunity.com/sharedfiles/filedetails/?id=" .. self.modInfo:getWorkshopID() or ""
    self.urlLen = getTextManager():MeasureStringX(UIFont.Small, self.modInfo:getUrl())
    self.modLinkLen = getTextManager():MeasureStringX(UIFont.Small, self.modLink)
end

function ModInfoPanel.Param:new(x, y, width, type)
    local o = ISPanelJoypad:new(x, y, width, BUTTON_HGT)
    setmetatable(o, self)
    self.__index = self
    o.type = type
    o.name = getText(type)
    o.labelWidth = getTextManager():MeasureStringX(UIFont.Small, o.name)
    o.tickTexture = getTexture("media/ui/inventoryPanes/Tickbox_Tick.png")
    o.zomboidVersion = ""
    o.workshopID = ""
    o.modLink = ""
    o.borderX = width / 4.0
    return o
end