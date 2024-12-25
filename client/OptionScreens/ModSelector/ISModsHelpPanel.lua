--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanelJoypad"

ISModsHelpPanel = ISPanelJoypad:derive("ISModsHelpPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)

function ISModsHelpPanel:createChildren()
    local btnWid = 100
    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local padY = 10

    local x = 10
    local y = 10 + FONT_HGT_TITLE + 10
    self.richText = ISRichTextPanel:new(x, y, self.width - x, self.height - padY - btnHgt - padY - y)
    self.richText.background = false
    self.richText.autosetheight = false
    self.richText.clip = true
    self.richText.marginRight = self.richText.marginLeft
    self:addChild(self.richText)
    self.richText:addScrollBars()

    local text = ""
    text = text .. getText("UI_modselector_help1")
    text = text .. getText("UI_modselector_help2")
    text = text .. getText("UI_modselector_help3")
    text = text .. getText("UI_modselector_help4")
    text = text .. getText("UI_modselector_help5")
    text = text .. getText("UI_modselector_help6")

    self.richText:setText(text)
    self.richText:paginate()

    self.ok = ISButton:new((self:getWidth() / 2) - btnWid / 2, self:getHeight() - padY - btnHgt, btnWid, btnHgt, getText("UI_Ok"), self, self.onOK)
    self.ok.anchorTop = false
    self.ok.anchorBottom = true
    self.ok:initialise()
    self.ok:instantiate()
    self:addChild(self.ok)
end

function ISModsHelpPanel:prerender()
    self:doRightJoystickScrolling()
    ISPanelJoypad.prerender(self)
end

function ISModsHelpPanel:render()
    ISPanelJoypad.render(self)
    self:drawTextCentre(getText("UI_modselector_ModHelpTitle"), self.width / 2, 10, 1, 1, 1, 1, UIFont.Title);
end

function ISModsHelpPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:setISButtonForA(self.ok)
end

function ISModsHelpPanel:onJoypadDown(button, joypadData)
    if button == Joypad.BButton then
        self.ok:forceClick()
        return
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISModsHelpPanel:doRightJoystickScrolling()
    if not self.joyfocus then return end
    if self.isFocusOnControl and self:isFocusOnControl() then return end
    self.richText:doRightJoystickScrolling(self.joyfocus)
end

function ISModsHelpPanel:onOK(button, x, y)
    self:setVisible(false)
    self:removeFromUIManager()
    ModSelector.instance:setVisible(true, self.joyfocus)
    if self.joyfocus then
        self.joyfocus.focus = ModSelector.instance
        ModSelector.instance.joypadIndex = ModSelector.instance.helpButton.ID
        updateJoypadFocus(self.joyfocus)
    end
end

function ISModsHelpPanel:new(x, y, width, height)
    local o = ISPanelJoypad.new(self, x, y, width, height)
    o.backgroundColor.a = 0.9
    o.texture = getTexture("spiffoWarning.png")
    return o
end
