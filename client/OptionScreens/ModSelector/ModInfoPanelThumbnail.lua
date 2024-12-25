--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModInfoPanel"

ModInfoPanel.Thumbnail = ISPanelJoypad:derive("ModInfoPanelThumbnail")

function ModInfoPanel.Thumbnail:render()
    ISPanelJoypad.render(self)

    local height = self.thumbnailHeight
    local x = 0
    self.parent.thumbnailPreviewImage = nil
    for i=2, self.posterCount do
        local alpha = 1.0
        local tex = self.modInfo ~= nil and getTexture(self.modInfo:getPoster(i-1)) or Texture:getWhite()
        if tex == Texture.getWhite() then alpha = 0.1 end

        local width = tex:getWidth() * (height / tex:getHeight())
        self:drawTextureScaledAspect(tex, x + self.padX, (self.height - height) / 2, width, height, alpha, 1, 1, 1)
        x = x + self.padX + width

        if self:isMouseOver() and self:getIndexAt(self:getMouseX(), self:getMouseY()) == i then
            self.parent.thumbnailPreviewImage = tex
        end
    end
end

function ModInfoPanel.Thumbnail:getIndexAt(x, y)
    local xx = self.padX
    for i = 2, self.posterCount do
        local tex = self.modInfo ~= nil and getTexture(self.modInfo:getPoster(i-1)) or Texture:getWhite()
        local width = tex:getWidth() * (self.thumbnailHeight / tex:getHeight())
        if x > xx and x < xx + width then
            return i
        end
        xx = xx + self.padX + width
    end
    return -1
end

function ModInfoPanel.Thumbnail:setModInfo(modInfo)
    self.modInfo = modInfo

    self.posterCount = 0
    local xx = self.padX
    for i = 2, modInfo:getPosterCount() do
        local tex = self.modInfo ~= nil and getTexture(self.modInfo:getPoster(i-1)) or Texture:getWhite()
        local width = tex:getWidth() * (self.thumbnailHeight / tex:getHeight())
        xx = xx + self.padX + width
        if xx > self.width then
            return
        end
        self.posterCount = i
    end
end

function ModInfoPanel.Thumbnail:new(x, y, width)
    local o = ISPanelJoypad.new(self, x, y, width, 80)
    o.padX = 10
    o.padY = 8
    o.thumbnailWidth = 106
    o.thumbnailHeight = 80 - o.padY * 2
    o.index = 1
    return o
end