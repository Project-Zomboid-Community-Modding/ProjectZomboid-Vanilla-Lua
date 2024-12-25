--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ConnectToServer = ISPanelJoypad:derive("ConnectToServer")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)

function ConnectToServer:create()
	local buttonHgt = math.max(FONT_HGT_SMALL + 3 * 2, 25)

	self.title = ISLabel:new(self.width / 2, 20, 50, "???", 1, 1, 1, 1, UIFont.Large, true)
	self.title:initialise()
	self.title:instantiate()
	self.title:setAnchorLeft(true)
	self.title:setAnchorRight(false)
	self.title:setAnchorTop(true)
	self.title:setAnchorBottom(false)
	self.title.center = true
	self:addChild(self.title)

	self.serverName1 = ISLabel:new(self.width / 2 - 6, self.title:getBottom() + 40, FONT_HGT_MEDIUM, getText("UI_ConnectToServer_ServerName"), 0.7, 0.7, 0.7, 1, UIFont.Medium, false)
	self.serverName1:initialise()
	self.serverName1:instantiate()
	self.serverName1:setAnchorLeft(true)
	self.serverName1:setAnchorRight(false)
	self.serverName1:setAnchorTop(true)
	self.serverName1:setAnchorBottom(false)
	self:addChild(self.serverName1)

	self.userName1 = ISLabel:new(self.width / 2 - 6, self.serverName1:getBottom() + 8, FONT_HGT_MEDIUM, getText("UI_ConnectToServer_UserName"), 0.7, 0.7, 0.7, 1, UIFont.Medium, false)
	self.userName1:initialise()
	self.userName1:instantiate()
	self.userName1:setAnchorLeft(true)
	self.userName1:setAnchorRight(false)
	self.userName1:setAnchorTop(true)
	self.userName1:setAnchorBottom(false)
	self:addChild(self.userName1)

	local labelX = self.width / 2 + 6

	self.serverName = ISLabel:new(labelX, self.title:getBottom() + 40, FONT_HGT_MEDIUM, "???", 1, 1, 1, 1, UIFont.Medium, true)
	self.serverName:initialise()
	self.serverName:instantiate()
	self.serverName:setAnchorLeft(true)
	self.serverName:setAnchorRight(false)
	self.serverName:setAnchorTop(true)
	self.serverName:setAnchorBottom(false)
	self:addChild(self.serverName)

	self.userName = ISLabel:new(labelX, self.serverName:getBottom() + 8, FONT_HGT_MEDIUM, "???", 1, 1, 1, 1, UIFont.Medium, true)
	self.userName:initialise()
	self.userName:instantiate()
	self.userName:setAnchorLeft(true)
	self.userName:setAnchorRight(false)
	self.userName:setAnchorTop(true)
	self.userName:setAnchorBottom(false)
	self:addChild(self.userName)

	self.connectLabel = ISLabel:new(self.width / 2, self.userName:getBottom() + 50, FONT_HGT_MEDIUM, "", 1, 1, 1, 1, UIFont.Medium, true)
	self.connectLabel:initialise()
	self.connectLabel:instantiate()
	self.connectLabel:setAnchorLeft(true)
	self.connectLabel:setAnchorRight(false)
	self.connectLabel:setAnchorTop(true)
	self.connectLabel:setAnchorBottom(false)
	self.connectLabel.center = true
	self:addChild(self.connectLabel)

	self.googleAuthPopup = ISPanel:new(self.width / 2 - 100, self.connectLabel:getBottom()+25, 200, 200);
    self.googleAuthPopup.internal = "googleAuthPopup";
    self.googleAuthPopup:initialise();
    self.googleAuthPopup:instantiate();
    self.googleAuthPopup.choicesColor = {r=1, g=1, b=1, a=1}
    self.googleAuthPopup:setAnchorLeft(false);
    self.googleAuthPopup:setAnchorRight(true);
    self.googleAuthPopup:setAnchorTop(true);
    self.googleAuthPopup:setAnchorBottom(false);
    self.googleAuthPopup.alwaysOnTop = true;
    self.googleAuthPopup:setVisible(true);
    self:addChild(self.googleAuthPopup);

    self.googleAuthEntry = ISTextEntryBox:new("", self.googleAuthPopup:getWidth() / 2, self.googleAuthPopup:getHeight() - buttonHgt * 4, 100, buttonHgt);
    self.googleAuthEntry:initialise();
    self.googleAuthEntry:instantiate();
    self.googleAuthEntry:setAnchorLeft(false);
    self.googleAuthEntry:setAnchorRight(true);
    self.googleAuthEntry:setAnchorTop(true);
    self.googleAuthEntry:setAnchorBottom(false);
    self.googleAuthEntry:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthEntry:getWidth()/2);
    self.googleAuthPopup:addChild(self.googleAuthEntry);

    self.googleAuthLabel = ISLabel:new(self.googleAuthPopup:getWidth() / 2, self.googleAuthPopup:getHeight() - buttonHgt * 6, FONT_HGT_MEDIUM, getText("UI_ConnectToServer_GoogleAuth_Request"), 1, 1, 1, 1, UIFont.Medium, true);
    self.googleAuthLabel:initialise();
    self.googleAuthLabel:instantiate();
    self.googleAuthLabel:setAnchorLeft(false);
    self.googleAuthLabel:setAnchorRight(true);
    self.googleAuthLabel:setAnchorTop(true);
    self.googleAuthLabel:setAnchorBottom(false);
    self.googleAuthLabel:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthLabel:getWidth()/2);
    self.googleAuthPopup:addChild(self.googleAuthLabel);

    self.googleAuthButton = ISButton:new(self.googleAuthPopup:getWidth()/2, self.googleAuthPopup:getHeight()-buttonHgt*2, 100, buttonHgt, getText("UI_ConnectToServer_GoogleAuth_Send"), self, self.onSendButton);
    self.googleAuthButton:initialise();
    self.googleAuthButton:instantiate();
    self.googleAuthButton:setAnchorLeft(false);
    self.googleAuthButton:setAnchorRight(true);
    self.googleAuthButton:setAnchorTop(false);
    self.googleAuthButton:setAnchorBottom(true);
    self.googleAuthButton:setX(self.googleAuthPopup:getWidth()/2 - self.googleAuthButton:getWidth()/2);
    self.googleAuthPopup:addChild(self.googleAuthButton);

    self.googleAuthPopup:setVisible(false);

	self.richText = ISRichTextPanel:new(0, self.connectLabel:getBottom() + 150, self.width * 4 / 5, FONT_HGT_MEDIUM * 4)
	self.richText:initialise()
	self.richText:instantiate()
	self.richText:noBackground()
	self.richText:setMargins(0, 0, 0, 0)
	self.richText.font = UIFont.Medium
	self:addChild(self.richText)
	self.richText.text = getSteamModeActive() and getText("UI_ConnectToServer_ReminderSteam") or getText("UI_ConnectToServer_ReminderNoSteam")
	self.richText.text = " <CENTRE> " .. self.richText.text
	self.richText:paginate()
	self.richText:setX(self.width / 2 - self.richText.width / 2)

	self.backBtn = ISButton:new((self.width - 100) / 2, self.height - 50, 100, buttonHgt, getText("UI_btn_back"), self, self.onBackButton)
	self.backBtn.internal = "BACK"
	self.backBtn:initialise()
	self.backBtn:instantiate()
	self.backBtn:setAnchorLeft(true)
	self.backBtn:setAnchorRight(false)
	self.backBtn:setAnchorTop(false)
	self.backBtn:setAnchorBottom(true)
	self:addChild(self.backBtn)

	self.arrowBG = getTexture("media/ui/ArrowRight_Disabled.png")
	self.arrowFG = getTexture("media/ui/ArrowRight.png")

	ConnectToServer.instance = self
end

function ConnectToServer:prerender()
    if self.loadingBackground then
        self:drawTextureScaledAspect3(self.loadingBackground, -(self.width/0.7 - self.width)/2, -(self.height/0.8 - self.height)/2, self.width/0.7, self.height/0.8, 1, 1, 1, 1) -- 0.7 and 0.8 are ui scaling from the MainScreen.lua
    end
	ISPanelJoypad.prerender(self)
	ConnectToServer.instance = self
end

function ConnectToServer:render()
	ISPanelJoypad.render(self)

	if self.connecting then
		local x = self.width / 2 - 15 * 1.5
		local y = self.connectLabel.y - 25
		self:drawTexture(self.arrowBG, x, y, 1, 1, 1, 1)
		self:drawTexture(self.arrowBG, x + 15, y, 1, 1, 1, 1)
		self:drawTexture(self.arrowBG, x + 30, y, 1, 1, 1, 1)

		local ms = UIManager.getMillisSinceLastRender()
		self.timerMultiplierAnim = (self.timerMultiplierAnim or 0) + ms
		if self.timerMultiplierAnim <= 500 then
			self.animOffset = -1
		elseif self.timerMultiplierAnim <= 1000 then
			self.animOffset = 0
		elseif self.timerMultiplierAnim <= 1500 then
			self.animOffset = 15
		elseif self.timerMultiplierAnim <= 2000 then
			self.animOffset = 30
		else
			self.timerMultiplierAnim = 0
		end
		if self.animOffset > -1 then
			self:drawTexture(self.arrowFG, x + self.animOffset, y, 1, 1, 1, 1)
		end
	end
end

function ConnectToServer:onResize(width, height)
	ISPanelJoypad.onResize(self, width, height)
	if not self.title then return end
	self.title:setX(width / 2)
	self.serverName1:setX(width / 2 - 6 - self.serverName1.width)
	self.userName1:setX(width / 2 - 6 - self.userName1.width)
	self.serverName:setX(width / 2 + 6)
	self.userName:setX(width / 2 + 6)
	self.connectLabel:setX(width / 2)
	self.richText:setX(width / 2 - self.richText.width / 2)
	self.backBtn:setX(width / 2 - self.backBtn.width / 2)
end

function ConnectToServer:onSendButton()
    sendGoogleAuth(self.userName:getName(), self.googleAuthEntry:getText())
    self.googleAuthPopup:setVisible(false);
    self.googleAuthEntry:setText("");
    self.richText:setY(self.connectLabel:getBottom() + 150);
end

function ConnectToServer:onBackButton()
	if self.connecting or isClient() then
		self.connecting = false
		backToSinglePlayer()
	end
	self.googleAuthPopup:setVisible(false);
    self.googleAuthEntry:setText("");
    self.richText:setY(self.connectLabel:getBottom() + 150);
	self:setVisible(false)
	self.loadingBackground = nil
	if self.isCoop then
		local joypadData = JoypadState.getMainMenuJoypad()
		if joypadData then
			joypadData.focus = MainScreen.instance
		end
		MainScreen.instance.bottomPanel:setVisible(true, self.joyfocus)
	else
		self.previousScreen:setVisible(true, self.joyfocus)
	end
end

function ConnectToServer:connect(previousScreen, serverName, userName, password, IP, localIP, port, serverPassword, useSteamRelay, doHash, authType)
	previousScreen:setVisible(false)
	self:setVisible(true, JoypadState.getMainMenuJoypad())
	self.previousScreen = previousScreen
	self.title:setName(getText("UI_ConnectToServer_TitleDedicated"))

	self.serverName1:setVisible(true)
	self.serverName:setVisible(true)
	if serverName == "" then
		self.serverName1:setName(getText("UI_ConnectToServer_ServerIP"))
		self.serverName:setName(IP)
	else
		self.serverName1:setName(getText("UI_ConnectToServer_ServerName"))
		self.serverName:setName(serverName)
	end

	self.userName:setName(userName)

	self.connectLabel.name = getText("UI_servers_Connecting")
	self.failMessage = nil
	self.backBtn:setTitle(getText("UI_coopscreen_btn_abort"))
	self.connecting = true
	self.isCoop = false
	self:onResize(self.width, self.height)
	serverConnect(userName, password, IP, localIP, port, serverPassword, serverName, useSteamRelay, doHash, authType, "")
end

function ConnectToServer:connectCoop(previousScreen, serverSteamID)
	previousScreen:setVisible(false)
	self:setVisible(true, JoypadState.getMainMenuJoypad())
	self.previousScreen = previousScreen
	self.title:setName(getText("UI_ConnectToServer_TitleCoop"))

	self.serverName1:setVisible(false)
	self.serverName:setVisible(false)

	self.userName:setName(getCurrentUserProfileName())

	self.connectLabel.name = getText("UI_servers_Connecting")
	self.failMessage = nil
	self.backBtn:setTitle(getText("UI_coopscreen_btn_abort"))
	self.connecting = true
	self.isCoop = true
	self:onResize(self.width, self.height)
	serverConnectCoop(serverSteamID)
end

function ConnectToServer:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self:setISButtonForB(self.backBtn)
end

function ConnectToServer:OnConnected()
	if SystemDisabler.getKickInDebug() and getDebug() and not isAdmin() and not isCoopHost() and
			not SystemDisabler.getOverrideServerConnectDebugCheck() then
		forceDisconnect()
		return
	end
	connectionManagerLog("connect-state-finish", "lua-connected");
	self.connecting = false
	self:setVisible(false)
	local joypadData = JoypadState.getMainMenuJoypad()
	if not checkSavePlayerExists() then
		if MapSpawnSelect.instance:hasChoices() then
			MapSpawnSelect.instance:fillList()
			MapSpawnSelect.instance:setVisible(true, joypadData)
		elseif WorldSelect.instance:hasChoices() then
			WorldSelect.instance:fillList()
			WorldSelect.instance:setVisible(true, joypadData)
		else
			MapSpawnSelect.instance:useDefaultSpawnRegion()
			MainScreen.instance.charCreationProfession.previousScreen = nil
			MainScreen.instance.charCreationProfession:setVisible(true, joypadData)
		end
	else
		GameWindow.doRenderEvent(false)
--[[
		-- menu activated via joypad, we disable the joypads and will re-set them automatically when the game is started
		if joypadData then
			joypadData.focus = nil
			updateJoypadFocus(joypadData)
			JoypadState.count = 0
			JoypadState.players = {}
			JoypadState.joypads = {}
			JoypadState.forceActivate = joypadData.id
		end
--]]
		forceChangeState(LoadingQueueState.new())
	end
end

function ConnectToServer:OnGoogleAuthRequest()
    self.googleAuthPopup:setVisible(true);
    self.richText:setY(self.googleAuthPopup:getBottom() + 50);
end

function ConnectToServer:OnConnectFailed(message, detail)
	-- Other screens have Events.OnConnectFailed callbacks too
	self.googleAuthPopup:setVisible(false);
    self.googleAuthEntry:setText("");
    self.richText:setY(self.connectLabel:getBottom() + 150);
	if not self:getIsVisible() then return end

	if message == "ServerWorkshopItemsCancelled" then
		self:onBackButton()
		return
	end

	-- AccessDenied has a message from the server telling the client why the connection is refused.
	-- But it is followed by ID_DISCONNECTION_NOTIFICATION which has no message.
	-- So keep the first message we get after clicking the connect button.
	if not self.failMessage then self.failMessage = message end
	if not message then message = self.failMessage end
	if message and string.match(message, "MODURL=") then
		local test = string.split(message, "MODURL=")
		message = test[1]
--[[
		self.getModBtn:setVisible(true)
		self.getModBtn:setX(5 + (getTextManager():MeasureStringX(UIFont.Medium, message)/2) + self.listbox.x + self.listbox.width/2)
		self.getModBtn.url = test[2]
--]]
	end

	message = message or getText("UI_servers_connectionfailed")

	if detail and detail ~= "" then
		message = message .. "\n" .. detail
	end
	
	self.connectLabel.name = message

	self.backBtn:setTitle(getText("UI_btn_back"))

	self.connecting = false
end

function ConnectToServer:OnConnectionStateChanged(state, message, arg)
	if not self:getIsVisible() then return end
	print(state .. ',' .. tostring(message))
	if state == "Disconnected" then
	    if self.connecting then
            self:OnConnectFailed(getText("UI_servers_connectionfailed"), message)
        end
        return;
	end
	--if state == "Disconnected" then return end
	if state == "Disconnecting" then return end
	if state == "Failed" then
	    if message and message ~= "" then
            self:OnConnectFailed(getText('UI_servers_'..message), "")
	    else
	        self:OnConnectFailed(getText("UI_servers_connectionfailed"), "")
	    end
	    return
	end
	--if state == "Failed" and message then self.failMessage = getText('UI_servers_'..message); return end
	-- Set connecting to false so we don't draw the > > > in render()
	if state == "Connected" then self.connecting = false end
	if state == "Message" then self.connectLabel.name = getText('UI_servers_'..message) return end
	if state == "FormatMessage" then self.connectLabel.name = string.format(getText('UI_servers_'..message), arg) return end
	if state == "ClientVersionMismatch" and message then
		self:OnConnectFailed(getText('UI_OnConnectFailed_ClientVersionMismatch', getCore():getVersion(), message), "")
		return
	end
	self.connectLabel.name = state and getText('UI_servers_'..state) or "???"
end

local function OnConnected()
	ConnectToServer.instance:OnConnected()
end

local function OnConnectFailed(message, detail)
	ConnectToServer.instance:OnConnectFailed(message, detail)
end

local function OnGoogleAuthRequest()
	ConnectToServer.instance:OnGoogleAuthRequest()
end

local function OnConnectionStateChanged(state, message, arg)
	ConnectToServer.instance:OnConnectionStateChanged(state, message, arg)
end

Events.OnGoogleAuthRequest.Add(OnGoogleAuthRequest)
Events.OnConnected.Add(OnConnected)
Events.OnConnectFailed.Add(OnConnectFailed)
Events.OnDisconnect.Add(OnConnectFailed)
Events.OnConnectionStateChanged.Add(OnConnectionStateChanged)
