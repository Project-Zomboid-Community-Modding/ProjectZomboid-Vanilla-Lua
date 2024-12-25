--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISModalRichText"

ISModsNagPanel = ISPanelJoypad:derive("ISModsNagPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local BUTTON_PADDING = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2

function ISModsNagPanel:createChildren()
	self.textureX = UI_BORDER_SPACING
	self.textureY = UI_BORDER_SPACING*2 + FONT_HGT_TITLE + 1
	self.textureW = self.texture:getWidth()
	self.textureH = self.texture:getHeight()

	local x = self.textureX + self.textureW
	local y = self.textureY
	self.richText = ISRichTextPanel:new(x, y, self.width - x, self.height - UI_BORDER_SPACING*2 - BUTTON_HGT - y - 1)
	self.richText.background = false
	self.richText.autosetheight = false
	self.richText.clip = true
	self.richText.marginRight = self.richText.marginLeft
	self:addChild(self.richText)
	self.richText:addScrollBars()

	self.richText:setText(getText("UI_ModsNagPanel_Text"))
	self.richText:paginate()

	local btnWidth = BUTTON_PADDING + getTextManager():MeasureStringX(UIFont.Small, getText("UI_Ok"))
	self.ok = ISButton:new((self:getWidth() - btnWidth) / 2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_Ok"), self, self.onOK)
	self.ok.anchorTop = false
	self.ok.anchorBottom = true
	self.ok:initialise()
	self.ok:instantiate()
--	self.ok.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.ok)
end

function ISModsNagPanel:render()
	ISPanelJoypad.render(self)
	self:drawTextCentre(getText("UI_ModsNagPanel_Title"), self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Title);
	self:drawTextureScaledAspect(self.texture, self.textureX, self.textureY, self.textureW, self.textureH, 1, 1, 1, 1)
end

function ISModsNagPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self:setISButtonForA(self.ok)
end

function ISModsNagPanel:onOK(button, x, y)
	self:setVisible(false)
	self:removeFromUIManager()
	ModSelector.instance:setVisible(true, self.joyfocus)
end

function ISModsNagPanel:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.backgroundColor.a = 0.9
	o.texture = getTexture("spiffoWarning.png")
	return o
end
