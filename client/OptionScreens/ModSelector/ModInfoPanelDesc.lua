--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModInfoPanel"

ModInfoPanel.Desc = ISPanelJoypad:derive("ModInfoPanelDesc")

local UI_BORDER_SPACING = 10

function ModInfoPanel.Desc:render()
    ISPanelJoypad.render(self)

    local alpha = 1.0
    local size = 200
    if self.tex == Texture.getWhite() then alpha = 0.1 end
    self:drawTextureScaled(self.tex, self.width - size - UI_BORDER_SPACING-1, UI_BORDER_SPACING+1, size, size, alpha, 1, 1, 1)
end

function ModInfoPanel.Desc:createChildren()
    self.richText = ISRichTextPanel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, self.width - 200 - UI_BORDER_SPACING*2, self.height - UI_BORDER_SPACING*2-2)
    self.richText.text = ""
    self.richText.borderColor = {r=1, g=1, b=1, a=0.0}
    self.richText.background = false
    self.richText.autosetheight = false
    self.richText.clip = true
    self.richText.marginLeft = 0
    self.richText:initialise()
    self.richText:instantiate()
    self.richText:addScrollBars(true)
    self.richText:paginate()
    self:addChild(self.richText)
end

function ModInfoPanel.Desc:setModInfo(modInfo)
    self.richText:setText(modInfo:getDescription())
    self.richText:paginate()

    if modInfo:getPosterCount() > 0 then
        self.tex = getTexture(modInfo:getPoster(0))
    else
        self.tex = Texture.getWhite()
    end
end

function ModInfoPanel.Desc:new(x, y, width)
    local o = ISPanelJoypad:new(x, y, width, 200 + UI_BORDER_SPACING*2+2)
    setmetatable(o, self)
    self.__index = self
    o.tex = Texture.getWhite()
    return o
end