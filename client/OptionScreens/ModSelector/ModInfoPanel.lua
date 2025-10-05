--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"

ModInfoPanel = ISPanelJoypad:derive("ModInfoPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local LABEL_HGT = FONT_HGT_MEDIUM + 6
local UI_BORDER_SPACING = 10
local JOYPAD_TEX_SIZE = 32
local BUTTON_PADDING = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2

function ModInfoPanel:new(x, y, width, height)
    local o = ISPanelJoypad:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.modInfoParams = {"Status", "Version", "Author", "Homepage", "ModLink", "ModID", "WorkshopID", "ZomboidVersion"}
    o.thumbnailPreviewImage = nil
    return o
end

function ModInfoPanel:drawCustomRectBorder(x, y, w, h, r, g, b, a)
    if self.javaObject ~= nil then
        self.javaObject:DrawTextureScaledColor(nil, x, y, 2, h, r, g, b, a);
        self.javaObject:DrawTextureScaledColor(nil, x+2, y, w-4, 2, r, g, b, a);
        self.javaObject:DrawTextureScaledColor(nil, x+w-2, y, 2, h, r, g, b, a);
        self.javaObject:DrawTextureScaledColor(nil, x+2, y+h-2, w-4, 2, r, g, b, a);
    end
end

function ModInfoPanel:render()
    if self.thumbnailPreviewImage then
        local h = self.height - self.thumbnailPanel:getBottom() - 100
        local w = self.thumbnailPreviewImage:getWidth() * (h / self.thumbnailPreviewImage:getHeight())
        self:drawTextureScaledAspect(self.thumbnailPreviewImage, (self.width - w)/2, self.thumbnailPanel:getBottom() + 16, w, h, 1, 1, 1, 1)
    end
	self:renderJoypadFocus()
end

function ModInfoPanel:recalcSize()
    ISPanelJoypad.recalcSize(self)
    for _, child in pairs(self:getChildren()) do
        child:setWidth(self.width)
        child:recalcSize()
    end
    self.incompatiblePanel:setHeight(self:getHeight() - self.incompatiblePanel:getY())
end

function ModInfoPanel:updateView(modInfo)
    self.modInfo = modInfo

    self.titlePanel:setModInfo(modInfo)
    self.descPanel:setModInfo(modInfo)
    self.thumbnailPanel:setModInfo(modInfo)

    for _, param in ipairs(self.modInfoParams) do
        self[param]:setModInfo(modInfo)
    end

    self.dependenciesPanel:setModInfo(modInfo)
    self.incompatiblePanel:setModInfo(modInfo)
    self.incompatiblePanel:setY(self.dependenciesPanel:getBottom()-1)
    self.incompatiblePanel:setHeight(self:getHeight() - self.incompatiblePanel:getY())
    self:setVisible(true)
end

function ModInfoPanel:createChildren()
    self.titlePanel = ModInfoPanel.Title:new(0, 0, self.width)
    self.titlePanel:initialise()
    self.titlePanel:instantiate()
    self:addChild(self.titlePanel)

    self.descPanel = ModInfoPanel.Desc:new(0, self.titlePanel:getBottom() - 1, self.width)
    self.descPanel:initialise()
    self.descPanel:instantiate()
    self:addChild(self.descPanel)

    self.thumbnailPanel = ModInfoPanel.Thumbnail:new(0, self.descPanel:getBottom() - 1, self.width)
    self.thumbnailPanel:initialise()
    self.thumbnailPanel:instantiate()
    self.thumbnailPanel:setAnchorRight(true)
    self:addChild(self.thumbnailPanel)

    local prevPanel = self.thumbnailPanel
    for _, param in ipairs(self.modInfoParams) do
        self[param] = ModInfoPanel.Param:new(0, prevPanel:getBottom() - 1, self.width, param)
        self[param]:initialise()
        self[param]:instantiate()
        self:addChild(self[param])
        prevPanel = self[param]
    end

    self.dependenciesPanel = ModInfoPanel.InteractionParam:new(0, prevPanel:getBottom()-1, self.width, "Dependencies")
    self.dependenciesPanel:initialise()
    self.dependenciesPanel:instantiate()
    self:addChild(self.dependenciesPanel)

    self.incompatiblePanel = ModInfoPanel.InteractionParam:new(0, self.dependenciesPanel:getBottom()-1, self.width, "IncompatibleWith")
    self.incompatiblePanel:initialise()
    self.incompatiblePanel:instantiate()
    self:addChild(self.incompatiblePanel)
end

-----------------

function ModInfoPanel:setJoypadFocused(val, joypadData)
    self.joypadFocused = val
end

function ModInfoPanel:onJoypadDown(button, joypadData)
    if button == Joypad.BButton then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
    end
end

function ModInfoPanel:onJoypadDirUp(joypadData)
    self.descPanel.richText:setYScroll(self.descPanel.richText:getYScroll() + 16)
end

function ModInfoPanel:onJoypadDirDown(joypadData)
    self.descPanel.richText:setYScroll(self.descPanel.richText:getYScroll() - 16)
end