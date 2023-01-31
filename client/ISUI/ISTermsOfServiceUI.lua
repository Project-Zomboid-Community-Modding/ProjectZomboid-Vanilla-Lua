--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISTermsOfServiceUI = ISPanelJoypad:derive("ISTermsOfServiceUI")

-- When the terms and conditions are updated, increment this number.
local TERMS_OF_SERVICE_VERSION = 1

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_TITLE = UIFont.Medium
local FONT_HGT_TITLE = getTextManager():getFontHeight(FONT_TITLE)

function ISTermsOfServiceUI:createChildren()
	ISPanelJoypad.createChildren(self)

	local btnWid = 100
	local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
	local padBottom = 10

	local titleY = 10
	local titleHgt = FONT_HGT_TITLE

	local texture = self.texture
	self.textureY = titleY + titleHgt + 10

	local textX = 10 + texture:getWidth()
	self.richText = ISRichTextPanel:new(textX, titleY + titleHgt + 20, self.width - textX, self.height - padBottom - btnHgt - 10 - FONT_HGT_TITLE)
	self.richText:initialise()
	self:addChild(self.richText)
--	self.richText:addScrollBars()
	self.richText.background = false
--	self.richText.clip = true
	self.richText.autosetheight = true
	self.richText:setMargins(10, 10, 10, 10)
	self.richText.text = getText("UI_TermsOfService_Prompt1")
	if not isSteamOverlayEnabled() then
		self.richText.text = self.richText.text .. " <BR> " .. getText("UI_TermsOfService_Prompt2")
	end
	self.richText:paginate()

	local btnX = 10 + texture:getWidth() + 10
	self.button1 = ISButton:new(btnX, self.richText:getBottom(), btnWid, btnHgt, getText("UI_TermsOfService_Button1"), self, ISTermsOfServiceUI.onButton1)
	self.button1:initialise()
	self.button1:instantiate()
--	self.button1.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.button1)
	
	self.button2 = ISButton:new(btnX, self.button1:getBottom() + 10, btnWid, btnHgt, getText("UI_TermsOfService_Button2"), self, ISTermsOfServiceUI.onButton2)
	self.button2:initialise()
	self.button2:instantiate()
--	self.button2.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.button2)

	local textureBottom = self.textureY + texture:getHeight() + padBottom
	local btnY = math.max(self.button2:getBottom() + 40, textureBottom - padBottom - btnHgt)

	self.buttonAccept = ISButton:new(btnX, btnY, btnWid, btnHgt, getText("UI_TermsOfService_ButtonAccept"), self, ISTermsOfServiceUI.onButtonAccept)
	self.buttonAccept:initialise()
	self.buttonAccept:instantiate()
--	self.buttonAccept.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.buttonAccept)

	self.buttonQuit = ISButton:new(self.buttonAccept:getRight() + 20, btnY, btnWid, btnHgt, getText("UI_TermsOfService_ButtonQuit"), self, ISTermsOfServiceUI.onButtonQuit)
	self.buttonQuit:initialise()
	self.buttonQuit:instantiate()
--	self.buttonQuit.borderColor = {r=1, g=1, b=1, a=0.1}
	self:addChild(self.buttonQuit)

	self:setHeight(self.buttonAccept:getBottom() + padBottom)
	self:setY(getCore():getScreenHeight() / 2 - self.height / 2)

	self.joypadIndex = 1
	self.joypadIndexY = 1
	self:insertNewLineOfButtons(self.button1)
	self:insertNewLineOfButtons(self.button2)
	self:insertNewLineOfButtons(self.buttonAccept, self.buttonQuit)
end

function ISTermsOfServiceUI:destroy()
	UIManager.setShowPausedMessage(true)
	self:setVisible(false)
	if self.destroyOnClick then
		self:removeFromUIManager()
	end
	if UIManager.getSpeedControls() then
		UIManager.getSpeedControls():SetCurrentGameSpeed(1)
	end
	if self.player and JoypadState.players[self.player+1] then
		setJoypadFocus(self.player, self.prevFocus)
	elseif self.joyfocus and self.joyfocus.focus == self then
		self.joyfocus.focus = self.prevFocus
		updateJoypadFocus(self.joyfocus)
	end
end

function ISTermsOfServiceUI:onButton1(button)
	local url = "https://projectzomboid.com/blog/support/terms-conditions/"
	if isSteamOverlayEnabled() then
		activateSteamOverlayToWebPage(url)
	else
		openUrl(url)
	end
end

function ISTermsOfServiceUI:onButton2(button)
	local url = "https://projectzomboid.com/blog/privacy-policy/"
	if isSteamOverlayEnabled() then
		activateSteamOverlayToWebPage(url)
	else
		openUrl(url)
	end
end

function ISTermsOfServiceUI:onButtonAccept(button)
	-- Remember that the user has accepted the current terms and conditions.
	getCore():setTermsOfServiceVersion(TERMS_OF_SERVICE_VERSION)
	getCore():saveOptions()

	self:destroy()
	if self.javaStateObj then
		self.javaStateObj:fromLua0("exit")
	elseif MainScreen and MainScreen.instance then
		MainScreen.instance:onTermsOfServiceOK()
	end
end

function ISTermsOfServiceUI:onButtonQuit(button)
	getCore():quitToDesktop()
end

function ISTermsOfServiceUI:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	local texture = self.texture
	self:drawTexture(texture, 10, self.textureY, texture:getWidth(), texture:getHeight(), 1, 1, 1, 1)
	self:drawTextCentre(getText("UI_TermsOfService_Title"), self:getWidth() / 2, 10, 1, 1, 1, 1, FONT_TITLE)
end

function ISTermsOfServiceUI:onMouseDown(x, y)
--	ISPanelJoypad.onMouseDown(self, x, y)
	-- FIXME: this prevents clicks being passed to windows behind, but need to swallow clicks outside and mouse-move events as well
	return true
end

function ISTermsOfServiceUI:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
--	self:setISButtonForA(self.button1)
	self:restoreJoypadFocus()
end

function ISTermsOfServiceUI:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
--	self.buttonAccept:clearJoypadButton()
end

function ISTermsOfServiceUI:onJoypadDown(button)
	ISPanelJoypad.onJoypadDown(self, button)
end

function ISTermsOfServiceUI:update()
	ISPanelJoypad.update(self)
	if self.alwaysOnTop then
		self:bringToTop()
	end
end

function ISTermsOfServiceUI:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.name = nil
	o.backgroundColor = {r=0, g=0, b=0, a=0.9}
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1}
	o.width = width
	o.height = height
	o.anchorLeft = true
	o.anchorRight = true
	o.anchorTop = true
	o.anchorBottom = true
	o.ok = nil
	o.destroyOnClick = true
	o.texture = getTexture("media/ui/spiffoJudge.png")
	return o
end

function ISTermsOfServiceUI.OnGameStateEnter(javaStateObj)
	if not instanceof(javaStateObj, "TermsOfServiceState") then return end
	javaStateObj:fromLua0("created")

	-- Only display this one time, or if the terms have changed.
	if getCore():getTermsOfServiceVersion() == TERMS_OF_SERVICE_VERSION then
		javaStateObj:fromLua0("exit")
		return
	end

	local width = 600
	local height = 200
	local modal = ISTermsOfServiceUI:new(getCore():getScreenWidth() / 2 - width / 2, getCore():getScreenHeight() / 2 - height / 2, width, height)
	modal.javaStateObj = javaStateObj
	modal:initialise()
	modal:addToUIManager()
	modal:setAlwaysOnTop(true)

	-- See JoyPadSetup.lua
	ISTermsOfServiceUI.instance = modal
	GameWindow.doRenderEvent(true)
end

Events.OnGameStateEnter.Add(ISTermsOfServiceUI.OnGameStateEnter)
