require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISInventoryPane"
require "ISUI/ISResizeWidget"
require "ISUI/ISMouseDrag"

require "defines"

MultiplayerScreen = ISPanel:derive("MultiplayerScreen");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function MultiplayerScreen:initialise()
	ISPanel.initialise(self);
end


--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function MultiplayerScreen:instantiate()

	--self:initialise();
	self.javaObject = UIElement.new(self);
	self.javaObject:setX(self.x);
	self.javaObject:setY(self.y);
	self.javaObject:setHeight(self.height);
	self.javaObject:setWidth(self.width);
	self.javaObject:setAnchorLeft(self.anchorLeft);
	self.javaObject:setAnchorRight(self.anchorRight);
	self.javaObject:setAnchorTop(self.anchorTop);
	self.javaObject:setAnchorBottom(self.anchorBottom);
end

function MultiplayerScreen:create()
    self.selectedServer = nil

    -------------------------------- START Auth Panel --------------------------------
    local authPanelWidth = 300
    local authPanelHeight = 520
    local authPanelItemHeight = 30
    local authPanelPanelWidth = authPanelWidth - 60
    local authPanelButtonWidth = authPanelWidth - 100

    local authPanelY = 30

    self.authPanel = ISPanel:new(0, 0, authPanelWidth, authPanelHeight);
    self.authPanel:initialise();
    self:addChild(self.authPanel);

    local text = getText("UI_Multiplayer_Server")
    local textWidth = getTextManager():MeasureStringX(UIFont.Large, text)
	self.serverLabel = ISLabel:new(textWidth + (authPanelWidth - textWidth) / 2.0, authPanelY, 30, text, 1, 1, 1, 1, UIFont.Large);
	self.serverLabel:initialise();
	self.serverLabel:instantiate();
	self.authPanel:addChild(self.serverLabel);
	authPanelY = authPanelY + authPanelItemHeight + 10

    -------------------------------- START Server Panel --------------------------------
	self.serverPanel = ISButton:new((authPanelWidth - authPanelPanelWidth) / 2.0, authPanelY, authPanelPanelWidth, 84, "", self, nil);
    self.serverPanel.internal = "ACCOUNTSELECT";
    self.serverPanel.onmousedown = MultiplayerScreen.onOptionMouseDown
    self.serverPanel.render = MultiplayerScreen.serverIconRender
    self.serverPanel:initialise();
    self.serverPanel:instantiate();
	self.authPanel:addChild(self.serverPanel);

	self.serverName = ISLabel:new(100, 10, 30, "???", 1, 1, 1, 1, UIFont.Medium, true);
	self.serverName:initialise();
	self.serverName:instantiate();
	self.serverPanel:addChild(self.serverName);

	self.serverStatus = ISLabel:new(100, 40, 30, getText("UI_Multiplayer_Offline"), 0.8, 0.5, 0.5, 1, UIFont.Medium, true);
	self.serverStatus:initialise();
	self.serverStatus:instantiate();
	self.serverPanel:addChild(self.serverStatus);
	authPanelY = authPanelY + 84 + 10
	-------------------------------- END Server Panel --------------------------------

    -------------------------------- START Username --------------------------------
    text = getText("UI_Multiplayer_Username")
    textWidth = getTextManager():MeasureStringX(UIFont.Large, text)
	self.usernameLabel = ISLabel:new( textWidth + (authPanelWidth - textWidth) / 2.0, authPanelY, 30, text, 1, 1, 1, 1, UIFont.Large);
	self.usernameLabel:initialise();
	self.usernameLabel:instantiate();
	self.authPanel:addChild(self.usernameLabel);
	authPanelY = authPanelY + authPanelItemHeight

	local entryHgt = FONT_HGT_SMALL + 2 * 2

	self.usernameEntry = ISTextEntryBox:new("", (authPanelWidth - authPanelPanelWidth) / 2.0, authPanelY, authPanelPanelWidth, entryHgt);
	self.usernameEntry:initialise();
	self.usernameEntry:instantiate();
	self.authPanel:addChild(self.usernameEntry);
	authPanelY = authPanelY + authPanelItemHeight
	-------------------------------- END Username --------------------------------

    self.authType = ISComboBox:new((authPanelWidth - authPanelPanelWidth) / 2.0, authPanelY, authPanelPanelWidth, 30, self, self.onComboAuthType);
    self.authType.internal = "AUTHTYPE";
    self.authType:initialise();
    self.authType:instantiate();
    self.authType.choicesColor = {r=1, g=1, b=1, a=1}
    self.authType:addOption(getText("UI_servers_auth_password"))
    self.authType:addOption(getText("UI_servers_auth_google"))
    self.authType:addOption(getText("UI_servers_auth_two_factor"))
    self.authPanel:addChild(self.authType);
    authPanelY = authPanelY + authPanelItemHeight

    text = getText("UI_Multiplayer_Password")
    textWidth = getTextManager():MeasureStringX(UIFont.Large, text)
	self.passwordLabel = ISLabel:new( textWidth + (authPanelWidth - textWidth) / 2.0, authPanelY, 30, text, 1, 1, 1, 1, UIFont.Large);
	self.passwordLabel:initialise();
	self.passwordLabel:instantiate();
	self.authPanel:addChild(self.passwordLabel);
	authPanelY = authPanelY + authPanelItemHeight

	self.passwordEntry = ISTextEntryBox:new("", (authPanelWidth - authPanelPanelWidth) / 2.0, authPanelY, authPanelPanelWidth, entryHgt);
	self.passwordEntry:initialise();
	self.passwordEntry:instantiate();
	self.authPanel:addChild(self.passwordEntry);
	authPanelY = authPanelY + authPanelItemHeight

    self.rememberPasswordTickBox = ISTickBox:new((authPanelWidth - authPanelPanelWidth) / 2.0, authPanelY, authPanelPanelWidth, 30,"");
    self.rememberPasswordTickBox.internal = "REMEMBER";
    self.rememberPasswordTickBox:initialise();
    self.rememberPasswordTickBox:instantiate();
    self.rememberPasswordTickBox.choicesColor = {r=1, g=1, b=1, a=1}
    self.rememberPasswordTickBox:addOption(getText("UI_servers_remember_password"))
    self.authPanel:addChild(self.rememberPasswordTickBox);
    authPanelY = authPanelY + authPanelItemHeight + 10

	self.playButton = ISButton:new((authPanelWidth - authPanelButtonWidth) / 2.0, authPanelY, authPanelButtonWidth, 50, getText("UI_Multiplayer_Login"), self, MultiplayerScreen.onOptionMouseDown);
	self.playButton.internal = "LOGIN";
	self.playButton:initialise();
	self.playButton:instantiate();
	self.playButton.font = UIFont.Large;
	self.playButton.backgroundColor = {r=0.3, g=1.0, b=0.3, a=0.5};
	self.playButton.backgroundColorMouseOver = {r=0.3, g=1.0, b=0.3, a=0.9}
	self.playButton.borderColor = {r=0.5, g=1.0, b=0.5, a=1.0};
	self.authPanel:addChild(self.playButton);
	authPanelY = authPanelY + 80

	self.registerButton = ISButton:new((authPanelWidth - authPanelButtonWidth) / 2.0, authPanelY, authPanelButtonWidth, 40, getText("UI_Multiplayer_ServerList"), self, MultiplayerScreen.onOptionMouseDown);
	self.registerButton.internal = "SERVERLIST";
	self.registerButton:initialise();
	self.registerButton:instantiate();
	self.registerButton.font = UIFont.Large;
	self.registerButton.backgroundColor = {r=0.5, g=0.5, b=0.5, a=0.5};
	self.registerButton.backgroundColorMouseOver = {r=0.5, g=0.8, b=0.5, a=0.5};
	self.registerButton.borderColor = {r=0.5, g=1.0, b=0.5, a=1.0};
	self.authPanel:addChild(self.registerButton);
	authPanelY = authPanelY + 50
    -------------------------------- END Auth Panel --------------------------------

    self.backButton = ISButton:new(0, 0, 250, 40, getText("UI_Multiplayer_Back"), self, MultiplayerScreen.onOptionMouseDown);
    self.backButton.internal = "BACK";
    self.backButton:initialise();
    self.backButton:instantiate();
    self.backButton.font = UIFont.Large;
    self.backButton.backgroundColor = {r=0.8, g=0.5, b=0.5, a=0.5};
    self.backButton.backgroundColorMouseOver = {r=0.9, g=0.6, b=0.6, a=0.6};
    self.backButton.borderColor = {r=0.8, g=0.5, b=0.5, a=1.0};
    self:addChild(self.backButton);

    self.choiceBackgroundNext = ISButton:new(0, 0, 40, 40,">", self, MultiplayerScreen.onOptionMouseDown);
    self.choiceBackgroundNext.internal = "BACKGROUND_NEXT";
    self.choiceBackgroundNext:initialise();
    self.choiceBackgroundNext:instantiate();
    self.choiceBackgroundNext.font = UIFont.Large;
    self.choiceBackgroundNext.backgroundColor = {r=0.3, g=0.3, b=0.3, a=0.5};
    self.choiceBackgroundNext.backgroundColorMouseOver = {r=0.3, g=0.3, b=0.3, a=0.9}
    self.choiceBackgroundNext.borderColor = {r=0.5, g=0.5, b=0.5, a=1.0};
    self.choiceBackgroundNext:setVisible(false)
    self:addChild(self.choiceBackgroundNext);

    self.choiceBackgroundPrevious = ISButton:new(0, 0, 40, 40,"<", self, MultiplayerScreen.onOptionMouseDown);
    self.choiceBackgroundPrevious.internal = "BACKGROUND_PREVIOUS";
    self.choiceBackgroundPrevious:initialise();
    self.choiceBackgroundPrevious:instantiate();
    self.choiceBackgroundPrevious.font = UIFont.Large;
    self.choiceBackgroundPrevious.backgroundColor = {r=0.3, g=0.3, b=0.3, a=0.5};
    self.choiceBackgroundPrevious.backgroundColorMouseOver = {r=0.3, g=0.3, b=0.3, a=0.9}
    self.choiceBackgroundPrevious.borderColor = {r=0.5, g=0.5, b=0.5, a=1.0};
    self.choiceBackgroundPrevious:setVisible(false)
    self:addChild(self.choiceBackgroundPrevious);

    self.listbox = ISScrollingListBox:new(0, 0, 500, 400);
    self.listbox:initialise();
    self.listbox:instantiate();
    self.listbox:setAnchorLeft(true);
    self.listbox:setAnchorRight(true);
    self.listbox:setAnchorTop(true);
    self.listbox:setAnchorBottom(true);
    self.listbox.itemheight = 85;
    self.listbox.doDrawItem = MultiplayerScreen.drawMap;
    self.listbox:setOnMouseDownFunction(self, MultiplayerScreen.onClickServer);
    self.listbox.drawBorder = true
    self.listbox.lockTexture = getTexture("media/ui/inventoryPanes/Button_Lock.png")
    self.listbox:setVisible(false)
    self:addChild(self.listbox);

    self.registerNewPlayer = false

	self:refreshList()
	self:onResolutionChange(0, 0, self.width, self.height)
    if #self.listbox.items > 0 then
        self:selectServerData(self.listbox.items[self.listbox.selected].item.server);
    end
end

function MultiplayerScreen:onResolutionChange(oldw, oldh, neww, newh)
    local fontScale = getTextManager():getFontHeight(UIFont.Small) / 15
    local entrySize = 200 * fontScale;
	self:setWidth(neww)
	self:setHeight(newh)
    self:setX(0)
    self:setY(0)

    --self.listbox:setVisible(true)
    self.listbox:setX((self.width - math.max(500, self.width*0.26)) / 2.0)
    self.listbox:setY(math.max(100, self.width*0.09))
    self.listbox:setWidth(math.max(500, self.width*0.26))
    self.listbox:setHeight(self.height - math.max(200, self.width*0.18))
    self.listbox.vscroll:setX(self.listbox:getWidth()-self.listbox.vscroll:getWidth());
    self.listbox.vscroll:setHeight(self.listbox:getHeight());
    self.choiceBackgroundNext:setX(self.width - 70)
    self.choiceBackgroundNext:setY(self.height - 70)
    self.choiceBackgroundPrevious:setX(self.width - 120)
    self.choiceBackgroundPrevious:setY(self.height - 70)
    if self.width < 1100 then
        self.backButton:setX((self.width - self.backButton:getWidth()) / 2.0)
        self.backButton:setY(self.height-70)
        self.authPanel:setWidth(math.max(350, self.width*0.182))
        self.authPanel:setX((self.width - self.authPanel:getWidth()) / 2.0)
        self.authPanel:setY(self.height-600)
        self.authPanel:setHeight(500)
        self.choiceBackgroundNext:setVisible(false)
        self.choiceBackgroundPrevious:setVisible(false)
    else
        self.backButton:setX(100)
        self.backButton:setY(self.height-70)
        self.authPanel:setWidth(math.max(350, self.width*0.182))
        self.authPanel:setX((self.width - self.authPanel:getWidth()) / 2.0)
        self.authPanel:setY(self.height-530)
        self.authPanel:setHeight(500)
        self.choiceBackgroundNext:setVisible(true)
        self.choiceBackgroundPrevious:setVisible(true)
    end

    local authPanelWidth = math.max(350, self.width*0.182)
    local authPanelPanelWidth = authPanelWidth - 60
    local authPanelButtonWidth = authPanelWidth - 100

    local text = getText("UI_Multiplayer_Server")
    local textWidth = getTextManager():MeasureStringX(UIFont.Large, text)
    self.serverLabel:setX((authPanelWidth - textWidth) / 2.0)

    self.serverPanel:setWidth(authPanelPanelWidth)

    text = getText("UI_Multiplayer_Username")
    textWidth = getTextManager():MeasureStringX(UIFont.Large, text)
    self.usernameLabel:setX((authPanelWidth - textWidth) / 2.0)

    self.usernameEntry:setWidth(authPanelPanelWidth)

    self.authType:setWidth(authPanelPanelWidth)

    text = getText("UI_Multiplayer_Password")
    textWidth = getTextManager():MeasureStringX(UIFont.Large, text)
    self.passwordLabel:setX((authPanelWidth - textWidth) / 2.0)

    self.passwordEntry:setWidth(authPanelPanelWidth)

    self.rememberPasswordTickBox:setWidth(authPanelPanelWidth)

    self.playButton:setWidth(authPanelButtonWidth)

    self.registerButton:setWidth(authPanelButtonWidth)

end

function MultiplayerScreen:prerender()
    self.listbox.doDrawItem = self.drawMap
    self:drawTextureScaledAspect3(self.loginBackground, 0, 0, self.width, self.height, 1, 1, 1, 1)
    if self.passwordEntry:isFocused() then
        if not self.passwordWasFocused then
            self.passwordWasFocused = true
            self.passwordEntry:setMasked(true)
            self.passwordEntry:setText("")
        end
    end
    local fieldsOK = self:checkFields()

    self.listbox.vscroll:setX(self.listbox:getWidth()-self.listbox.vscroll:getWidth());
    self.listbox.vscroll:setHeight(self.listbox:getHeight());
end

function MultiplayerScreen.serverIconRender(self)
    ISButton.render(self)
    local multiplayerScreen = MainScreen.instance.multiplayer
    if multiplayerScreen and multiplayerScreen.serverIconTexture then
        multiplayerScreen:drawTextureScaled(multiplayerScreen.serverIconTexture,
                multiplayerScreen.authPanel:getX() + multiplayerScreen.serverPanel:getX() + 10,
                multiplayerScreen.authPanel:getY() + multiplayerScreen.serverPanel:getY() + 10,
                64, 64, 1, 1, 1, 1)
    end
end

function MultiplayerScreen:onMouseDown(x, y)
    if self.listbox:isVisible() then
        self.listbox:setVisible(false)
    end
    return true
end

function MultiplayerScreen:checkFields()
    local valid = true;
    local tooltip = nil

    self.usernameEntry:setValid(true)
    self.usernameEntry:setTooltip(getText("UI_servers_username_tt"))
    self.passwordEntry:setValid(true)
    self.passwordEntry:setTooltip(getText("UI_servers_pwd_tt"))

    if 2 ~= self.authType:getSelected() and self.passwordEntry:getInternalText():trim() == "" then
        self.passwordEntry:setValid(false)
        self.passwordEntry:setTooltip(getText("UI_servers_err_username_pwd"))
        if valid then
            tooltip = getText("UI_servers_err_username_pwd")
        end
        valid = false;
    end

    if not isValidUserName(self.usernameEntry:getText()) then
        self.usernameEntry:setValid(false)
        self.usernameEntry:setTooltip(getText("UI_servers_notvalid_username"))
        if valid then
            tooltip = getText("UI_servers_err_username")
        end
        valid = false;
        return;
    end

    if valid then
        if not canConnect() then
            self.playButton:setTitle(getText("UI_Multiplayer_Login") .. " " .. getReconnectCountdownTimer())
            valid = false;
        else
            self.playButton:setTitle(getText("UI_Multiplayer_Login"))
            valid = true;
        end
    end

    self.playButton:setEnable(valid)
    self.playButton:setTooltip(tooltip)
    return valid
end

function MultiplayerScreen:onOptionMouseDown(button, x, y)
    if button.internal == "ACCOUNTSELECT" then
        if #self.listbox.items > 0 then
            self.listbox:setVisible(true)
        end
    end
	if button.internal == "LOGIN" then
	    if not MainScreen.instance.multiplayer:checkFields() then
	        return
	    end
        if getSteamModeActive() then
            steamReleaseInternetServersRequest()
        end
        stopSendSecretKey();
        getCore():setNoSave(false);
        local server = self.selectedServer--self.listbox.items[self.listbox.selected].item.server
        local localIP = getSteamModeActive() and server:getLocalIP() or ""
        local useSteamRelay = getSteamModeActive() and server:getUseSteamRelay()
        local doHash = false;
        local passwordData = server:getPwd()
        if self.passwordWasFocused then
            doHash = true;
            passwordData = self.passwordEntry:getInternalText()
        end
        if self.rememberPasswordTickBox:isSelected(1) and self.passwordWasFocused then
            server:setPwd(passwordData, true)
            self:saveServer(server)
        end
        if server:isSavePwd() and not self.rememberPasswordTickBox:isSelected(1) then
            server:setSavePwd(false);
            server:setPwd("", true)
            self:saveServer(server)
        end
        ConnectToServer.instance.loadingBackground = server:getServerLoadingScreen();
        ConnectToServer.instance:connect(self, server:getName(), self.usernameEntry:getText(), passwordData,
            server:getIp(), localIP, server:getPort(), server:getServerPassword(), useSteamRelay, doHash, server:getAuthType());
	end

	if button.internal == "REGISTER" then
        if not MainScreen.instance.multiplayer:checkFields() then
            return
        end
        local newServer = self:getServer();
        getCustomizationData(newServer:getUserName(), newServer:getPwd(), newServer:getIp(), newServer:getPort(), newServer:getServerPassword(), newServer:getName(), false);
        MainScreen.instance.serverList:addServerToList(newServer);
        MainScreen.instance.serverList:writeServerOnFile(newServer, true);
        self:refreshList()
    end
	if button.internal == "SERVERLIST" then
	    self:setVisible(false);
        MainScreen.instance.multiplayer:setVisible(false);
        MainScreen.instance.serverList:pingServers(true);
        MainScreen.instance.serverList:setVisible(true, joypadData);
        if ActiveMods.requiresResetLua(ActiveMods.getById("nomods")) then
            getCore():ResetLua("nomods", "joinServer")
        end
    end
	if button.internal == "BACK" then
        if getSteamModeActive() then
            steamReleaseInternetServersRequest()
        end
	    if self.rememberPasswordTickBox:isSelected(1) and self.passwordWasFocused then
	        local server = self.selectedServer
	        local passwordData = self.passwordEntry:getInternalText()
            server:setPwd(passwordData, true)
            self:saveServer(server)
        end
        self:setVisible(false);
        MainScreen.instance.multiplayer:setVisible(false);
        MainScreen.instance.bottomPanel:setVisible(true);
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            joypadData.focus = MainScreen.instance
            updateJoypadFocus(joypadData)
        end
        MainScreen.resetLuaIfNeeded()
	end
    if button.internal == "BACKGROUND_NEXT" then
        local server = self.selectedServer
        server:setLoginScreenId(server:getLoginScreenId() + 1)
        self:saveServer(server)
       -- self.loginBackground = getClientLoadingScreen(server:getLoginScreenId())
    end
    if button.internal == "BACKGROUND_PREVIOUS" then
        local server = self.selectedServer
        server:setLoginScreenId(server:getLoginScreenId() - 1)
        self:saveServer(server)
     --   self.loginBackground = getClientLoadingScreen(server:getLoginScreenId())
    end
end

function MultiplayerScreen:getServer()
        local newServer = Server.new();
        newServer:setName(self.selectedServer:getName());
        newServer:setIp(self.selectedServer:getIp());
        if getSteamModeActive() then
            newServer:setLocalIP(self.selectedServer:getLocalIP())
        end
        newServer:setPort(self.selectedServer:getPort());
        newServer:setServerPassword("")
        newServer:setDescription(self.selectedServer:getDescription());
        newServer:setUserName(self.usernameEntry:getText());
        newServer:setPwd(self.passwordEntry:getInternalText(), true);
        newServer:setSavePwd(self.rememberPasswordTickBox:isSelected(1));
        newServer:setAuthType(self.authType:getSelected())
        newServer:setLoginScreenId(self.selectedServer:getLoginScreenId())
        if getSteamModeActive() then
            newServer:setUseSteamRelay(false);
        end
        return newServer;
end

function MultiplayerScreen:saveServer(server)
    MainScreen.instance.serverList.listbox:removeItem(server:getName());
    MainScreen.instance.serverList:emptyServerFile()
    for i,v in ipairs(MainScreen.instance.serverList.listbox.items) do
        MainScreen.instance.serverList:writeServerOnFile(v.item.server, true);
    end
    local newServer = self:getServer();
    MainScreen.instance.serverList:addServerToList(newServer);
    MainScreen.instance.serverList:writeServerOnFile(newServer, true);
end

function MultiplayerScreen:refreshList()
    local selectedItemNum = self.listbox.selected
    self.listbox:clear()
    local servers = getServerList();
    local needSave = false
    for _,server in ipairs(servers) do
        if server:getNeedSave() then
            needSave = true
        end
        self:addServerToList(server)
        if getSteamModeActive() and tonumber(server:getPort()) then
            steamRequestServerDetails(server:getIp(), tonumber(server:getPort()))
        end
    end
    self.listbox:sort()
    if needSave then
        self:emptyServerFile()
        for _,server in ipairs(servers) do
            self:writeServerOnFile(server, true);
        end
    end

    if selectedItemNum < #self.listbox.items then
        self.listbox.selected = selectedItemNum
        if self.listbox.items[self.listbox.selected] ~= nil then
            self:selectServerData(self.listbox.items[self.listbox.selected].item.server);
        end
    end

    if #servers > 0 then
        self.registerNewPlayer = false
        self.playButton:setTitle(getText("UI_Multiplayer_Login"))
        self.playButton.internal = "LOGIN";
        self.usernameEntry:setEditable(false);
    else
        self.registerNewPlayer = true
        self.playButton:setTitle(getText("UI_Multiplayer_Register"))
        self.playButton.internal = "REGISTER";
        self.usernameEntry:setEditable(true);
        self:requestServerList()
    end
end

function MultiplayerScreen:requestServerList()
    if not isPublicServerListAllowed() then return; end
    if getSteamModeActive() then
        --steamRequestInternetServersList()
        return
    end
    local servers = getPublicServersList();
    if #servers == 0 then
        return;
    end
    for i, k in ipairs(servers) do
        self:analyzeServerData(k)
    end
end

function MultiplayerScreen:analyzeServerData(server)

    local name = server:getName();

    local error = checkServerName(name);
    if error then
        return;
    end

    if not server:isOpen() or server:isPasswordProtected() then
        return
    end

    if server:getVersion() and server:getVersion() ~= getCore():getVersion() and not getDebug() then
        return
    end

    if tonumber(server:getMaxPlayers()) <= 8 then
        return
    end

    if server:getPlayers() and tonumber(server:getPlayers()) == 0 then
        return
    end

    if server:getPlayers() and tonumber(server:getPlayers()) > tonumber(server:getMaxPlayers())/2 then
        return
    end

    if server:getMods() and server:getMods() ~= "" then
        return
    end

    if self.selectedServer == nil then
        self:selectServerData(server)
    else
        if getSteamModeActive() then
            if server:getPing() ~= nil and self.selectedServer:getPing() ~= nil and tonumber(server:getPing()) < tonumber(self.selectedServer:getPing()) then
                self:selectServerData(server)
            end
        end
    end
end

function MultiplayerScreen:selectServerData(server)
    self.selectedServer = server
    self:fillFields(server);
end

function MultiplayerScreen:onComboAuthType()
    if self.selectedServer ~= nil then
        self.selectedServer:setUserName(self.usernameEntry:getText());
        self.selectedServer:setAuthType(self.authType:getSelected())
        self:fillFields(self.selectedServer);
    end
end

function MultiplayerScreen.OnSteamServerResponded(serverIndex)
    local server = steamGetInternetServerDetails(serverIndex)
    if server and MainScreen.instance.multiplayer then
        MainScreen.instance.multiplayer:analyzeServerData(server)
    end
end

function MultiplayerScreen:addServerToList(server)
    local item = {}
    item.server = server

    item.richText = ISRichTextLayout:new(self:getWidth()-17)
    item.richText:initialise()
    self:setServerDescription(item)

    self:setServerMods(item)

    if getSteamModeActive() then
        item.responded = false
        item.rules = nil
    end

    self.listbox:addItem(server:getName(), item);
	self.listbox.selected = #self.listbox.items;
end

function MultiplayerScreen:fillFields(item)
    if item == nil then
       -- self.loginBackground = getClientLoadingScreen(ZombRand(100));
        self.serverIconTexture = nil;
        self.serverName:setName("???");
        self.usernameEntry:setText("");
        self.passwordWasFocused = true;
        self.passwordEntry:setMasked(true);
        self.passwordEntry:setText("");
        self.serverStatus:setName(getText("UI_Multiplayer_Offline"));
        self.serverStatus:setColor(0.8, 0.5, 0.5)
        self.authType:setSelected(2)
        self.rememberPasswordTickBox:setSelected(1, false)
    else
        self.loginBackground = item:getServerLoginScreen();
        if self.loginBackground == nil then
            if item:getLoginScreenId() == -1 then
                item:setLoginScreenId(ZombRand(100))
            end
       --     self.loginBackground = getClientLoadingScreen(item:getLoginScreenId())
        end
        if item:getServerIcon() ~= nil then
            self.serverIconTexture = item:getServerIcon();
        else
            self.serverIconTexture = getTexture("media/ui/zomboidIcon64.png")
        end
        if string.len(item:getName()) > 13 then
            self.serverName:setName(string.sub(item:getName(), 0, 12) .. "...");
        else
            self.serverName:setName(item:getName());
        end
        self.usernameEntry:setText(item:getUserName());
        self.passwordWasFocused = false;
        self.rememberPasswordTickBox:setSelected(1,item:isSavePwd());
        if item:isSavePwd() then
            self.passwordEntry:setMasked(false);
            self.passwordEntry:setText(getText("UI_Server_Passwort_Hint"));
        else
            self.passwordWasFocused = true;
            self.passwordEntry:setMasked(true);
            self.passwordEntry:setText("");
        end
        self.serverStatus:setName(item:getIp()..":"..item:getPort());
        self.serverStatus:setColor(0.5, 0.8, 0.5)
        self.authType:setSelected(item:getAuthType())
    end
    self:formRefresh(self.authType:getSelected())
end

function MultiplayerScreen:formRefresh(authType)
    if 2 == authType then
        self.passwordLabel:setVisible(false);
        self.passwordEntry:setVisible(false);
        self.rememberPasswordTickBox:setVisible(false);
    else
        self.passwordLabel:setVisible(true);
        self.passwordEntry:setVisible(true);
        self.rememberPasswordTickBox:setVisible(true);
    end
end

function MultiplayerScreen:setServerDescription(item)
    local text = item.server:getDescription()
    text = text:gsub("<", "&lt"):gsub(">", "&gt")
    text = text:gsub("\\n", "\n")
    text = " <RGB:0.8,0.8,0.8> " .. text
    item.richText:setText(text)
    item.richText:paginate()
end

function MultiplayerScreen:setServerMods(item)
    if item.server:getMods() and item.server:getMods() ~= "" then
        local mods = item.server:getMods()
        local modCount = nil
        if getSteamModeActive() then
            mods = mods:gsub(";", ",")
            modCount = item.rules and tonumber(item.rules.modCount) or nil
        end
        mods = mods:gsub(",", ", ")
        local text = getText("UI_servers_mods") .. mods:gsub(";", ", "):gsub("<", "&lt"):gsub(">", "&gt")
        if modCount then
            local totalMods = self:countMods(mods)
            if totalMods ~= modCount then
                text = string.format("%s %s", text, getText("Tooltip_AndNMore", modCount - totalMods))
            end
        end
        text = " <RGB:0.8,0.8,0.8> " .. text
        item.modsText = ISRichTextLayout:new(self:getWidth()-17)
        item.modsText:setText(text)
        item.modsText:paginate()
    else
        item.modsText = nil
    end
end

function MultiplayerScreen:drawMap(y, item, alt)
    local server = item.item.server
    local isMouseOver = self.mouseoverselected == item.index and not self:isMouseOverScrollBar()
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15);
    elseif isMouseOver then
        self:drawRect(1, y + 1, self:getWidth() - 2, item.height - 2, 0.95, 0.05, 0.05, 0.05);
    end
    self:drawRectBorder(0, (y), self:getWidth(), item.height-1, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    local serverIconTexture = server:getServerIcon()
    if serverIconTexture then
        self:drawTextureScaled(serverIconTexture, 10, 10 + y, 64, 64, 1, 1, 1, 1)
    end
    local dx = 0
    if server:isPasswordProtected() then
        dx = self.lockTexture:getWidth() + 8
        local largeFontHgt = getTextManager():getFontFromEnum(UIFont.Large):getLineHeight()
        self:drawTexture(self.lockTexture, 20, y + 15 + (largeFontHgt - self.lockTexture:getHeight()) / 2, 1, 1, 1, 1)
    end
    self:drawText(server:getName() .. " (" .. server:getIp() .. ":" .. server:getPort() .. ") ",  84 + 20+dx, y+15, 0.9, 0.9, 0.9, 0.9, UIFont.Large);

    if server:getUserName() and server:getUserName() ~= "" then
        self:drawText(getText("UI_servers_LogAs") .. server:getUserName(), 84 + 20, y+50, 0.9, 0.9, 0.9, 0.9, UIFont.Small);
    end

    return y+84;
end

function MultiplayerScreen:onGainJoypadFocus_RightPanel(joypadData)
    self:restoreJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
end


function MultiplayerScreen:onLoseJoypadFocus_RightPanel(joypadData)
    self:clearJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function MultiplayerScreen:onClickServer(item)
    if item.server:getTimeFromServerCustomizationLastUpdate() > 3600 then
        item.server:updateServerCustomizationLastUpdate()
        getCustomizationData(item.server:getUserName(), item.server:getPwd(), item.server:getIp(), item.server:getPort(), item.server:getServerPassword(), item.server:getName(), false);
    end
    self:selectServerData(item.server)

    if getSteamModeActive() and item.responded then
        steamRequestServerDetails(item.server:getIp(), tonumber(item.server:getPort()))
    end
    self.listbox:setVisible(false)
end

function MultiplayerScreen:new (x, y, width, height)
	local o = {}
	--o.data = {}
	o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.x = x;
	o.y = y;
	o.backgroundColor = {r=0.0, g=0.0, b=0.0, a=0.0};
	o.borderColor = {r=1, g=1, b=1, a=0.0};
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.passwordWasFocused = false;
	return o
end

function MultiplayerScreen.OnServerCustomizationDataReceived()
    MainScreen.instance.multiplayer:refreshList();
end

Events.OnServerCustomizationDataReceived.Add(MultiplayerScreen.OnServerCustomizationDataReceived)
if getSteamModeActive() then
    LuaEventManager.AddEvent("OnSteamServerResponded")
    Events.OnSteamServerResponded.Add(MultiplayerScreen.OnSteamServerResponded)
end
