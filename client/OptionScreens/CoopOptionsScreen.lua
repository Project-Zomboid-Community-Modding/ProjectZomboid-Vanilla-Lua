-- Sergei Shubin
require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISInventoryPane"
require "ISUI/ISResizeWidget"
require "ISUI/ISMouseDrag"

require "defines"

CoopOptionsScreen = ISPanelJoypad:derive("CoopOptionsScreen");
CoopOptionsScreenPanel = ISPanelJoypad:derive("CoopOptionsScreenPanel")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local FONT_HGT_TITLE = getTextManager():getFontHeight(UIFont.Title)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local PROGRESS_BAR_STEP = 1/13
local PROGRESS_BAR_WORKSHOP_WEIGHT = 1/4
local PROGRESS_BAR_SPEED = 0.0003;

CoopConnection = {
    username = "admin",
    servername = "servertest",
    memory = is64bit() and 4096 or 1024,
};

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function CoopOptionsScreenPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	if self.parent.accountNameEntry:isVisible() then
		self:insertNewLineOfButtons(self.parent.accountNameEntry)
	end
	self:insertNewLineOfButtons(self.parent.settingsComboBox)
    self:insertNewLineOfButtons(self.parent.settingsButton)
	self:insertNewLineOfButtons(self.parent.memoryComboBox)
	self:insertNewLineOfButtons(self.parent.softResetButton)
	self:insertNewLineOfButtons(self.parent.deleteWorldButton)
	self:insertNewLineOfButtons(self.parent.deletePlayerButton)
	self.joypadIndexY = self.oldJoypadIndexY or 1
	self.joypadIndex = self.oldJoypadIndex or 1
	self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
	self.joypadButtons[self.joypadIndex]:setJoypadFocused(true)
end

function CoopOptionsScreenPanel:onLoseJoypadFocus(joypadData)
	self.oldJoypadIndexY = self.joypadIndexY
	self.oldJoypadIndex = self.joypadIndex
	self:clearJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function CoopOptionsScreenPanel:onJoypadBeforeDeactivate(joypadData)
	self.parent:onJoypadBeforeDeactivate(joypadData)
end

function CoopOptionsScreenPanel:onJoypadDown(button, joypadData)
    if button == Joypad.BButton and not self:isFocusOnControl() then
        joypadData.focus = self.parent
        updateJoypadFocus(joypadData)
    else
        ISPanelJoypad.onJoypadDown(self, button, joypadData)
    end
end

-- -- -- -- --
-- -- -- -- --
-- -- -- -- --

function CoopOptionsScreen:initialise()
    ISPanel.initialise(self);
end

function CoopOptionsScreen:instantiate()
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

function CoopOptionsScreen:new(x, y, width, height)
    local o = {}
    --o.data = {}
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.backgroundColor = {r=0, g=0, b=0, a=0.3};
    o.borderColor = {r=1, g=1, b=1, a=0.2};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.startY = UI_BORDER_SPACING + 1 + FONT_HGT_TITLE + 30 + FONT_HGT_LARGE + 10;
    o.itemheightoverride = {}
    o.selected = 1;
    CoopOptionsScreen.instance = o;
    return o
end

function basicButtonSetup(button, internal, anchors)
    button.internal = internal;
    button:initialise();
    button:instantiate();
    if anchors.left ~= nil then
        button:setAnchorLeft(anchors.left);
    end    
    if anchors.top ~= nul then
        button:setAnchorTop(anchors.top);
    end
    if anchors.right ~= nil then
        button:setAnchorRight(anchors.right);
    end
    if anchors.bottom ~= nil then
        button:setAnchorBottom(anchors.bottom);
    end
    button.borderColor = { r = 1, g = 1, b = 1, a = 0.1 };
    button:setFont(UIFont.Small);
    button:ignoreWidthChange();
    button:ignoreHeightChange();
end

function CoopOptionsScreen:create()
    local panel = CoopOptionsScreenPanel:new(0, self.startY, self.width, self.height)
    panel.anchorRight = true
    panel.anchorBottom = true
    panel.borderColor.a = 0
    panel.backgroundColor.a = 0
    self:addChild(panel)
    self.panel = panel

    local btnWidth = UI_BORDER_SPACING*2 + math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_coopscreen_edit_settings")),
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_coopscreen_softreset")),
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_coopscreen_delete_world")),
            getTextManager():MeasureStringX(UIFont.Small, getText("UI_coopscreen_delete_player"))
    )

    local labelRight = (self.width-UI_BORDER_SPACING)/2
    local label = ISLabel:new(labelRight, 0, BUTTON_HGT, getText("UI_coopscreen_account_name"), 1, 1, 1, 1, UIFont.Medium, false)
    self.panel:addChild(label)

    local entry = ISTextEntryBox:new("admin", label:getRight() + UI_BORDER_SPACING, label:getY(), btnWidth, BUTTON_HGT)
    entry.font = UIFont.Medium
    entry.onTextChange = CoopOptionsScreen.onUsernameChanged
    self.panel:addChild(entry)
    self.accountNameEntry = entry

    if getSteamModeActive() then
        label:setVisible(false)
        entry:setVisible(false)
    end

    label = ISLabel:new(labelRight, entry:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("UI_coopscreen_server_name"), 1, 1, 1, 1, UIFont.Medium, false)
    self.panel:addChild(label)

    local comboBox = ISComboBox:new(labelRight + UI_BORDER_SPACING, label:getY(), btnWidth, BUTTON_HGT, self, self.onSettingsSelected)
    self.panel:addChild(comboBox)
    self.settingsComboBox = comboBox

    self.settingsButton = ISButton:new(labelRight + UI_BORDER_SPACING, comboBox:getBottom()+UI_BORDER_SPACING, btnWidth, BUTTON_HGT, getText("UI_coopscreen_edit_settings"), self, self.onEditSettings)
    self.panel:addChild(self.settingsButton)


    label = ISLabel:new(labelRight, self.settingsButton:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("UI_coopscreen_server_memory"), 1, 1, 1, 1, UIFont.Medium, false)
    self.panel:addChild(label)

    local spinBox = ISComboBox:new(labelRight + UI_BORDER_SPACING, label:getY(), btnWidth, BUTTON_HGT, self, self.onMemorySelected)
    self.panel:addChild(spinBox)
    self.memoryToIndex = {}
    local max = is64bit() and 62 or 3
    for i=1,max do
        local MB = 512 + i * 256
        spinBox:addOptionWithData(tostring(MB / 1024) .. " GB", MB)
        self.memoryToIndex[MB] = i
    end
    self.memoryComboBox = spinBox

    self.softResetButton = ISButton:new(labelRight + UI_BORDER_SPACING, self.memoryComboBox:getBottom() + UI_BORDER_SPACING, btnWidth, BUTTON_HGT, getText("UI_coopscreen_softreset"), self, CoopOptionsScreen.onSoftReset);
    self.panel:addChild(self.softResetButton)

    self.deleteWorldButton = ISButton:new(labelRight + UI_BORDER_SPACING, self.softResetButton:getBottom() + UI_BORDER_SPACING, btnWidth, BUTTON_HGT, getText("UI_coopscreen_delete_world"), self, CoopOptionsScreen.onDeleteWorld);
    self.panel:addChild(self.deleteWorldButton)

    self.deletePlayerButton = ISButton:new(labelRight + UI_BORDER_SPACING, self.deleteWorldButton:getBottom() + UI_BORDER_SPACING, btnWidth, BUTTON_HGT, getText("UI_coopscreen_delete_player"), self, CoopOptionsScreen.onDeletePlayer);
    self.panel:addChild(self.deletePlayerButton)
    self.checkPlayer = false

    local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
    self.backButton = ISButton:new(UI_BORDER_SPACING + 1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, CoopOptionsScreen.onBackButtonDown);
    basicButtonSetup(self.backButton, "BACK", { left = true, top = false, bottom = true} );
    self.backButton:enableCancelColor()
    self:addChild(self.backButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_coopscreen_btn_start"))
    self.startButton = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_coopscreen_btn_start"), self, CoopOptionsScreen.onStartButtonDown);
    basicButtonSetup(self.startButton, "START", { left = false, top = false, right = true, bottom = true } );
    self.startButton:enableAcceptColor()
    self:addChild(self.startButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_coopscreen_btn_abort"))
    self.abortButton = ISButton:new(self.startButton.x - btnWidth - UI_BORDER_SPACING, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_coopscreen_btn_abort"), self, CoopOptionsScreen.onAbortButtonDown);
    basicButtonSetup(self.abortButton, "ABORT", { left = false, top = false, right = true, bottom = true } );
    self.abortButton:enableCancelColor()
    self.abortButton:setEnable(false);
    self:addChild(self.abortButton);

    self.richText = ISRichTextPanel:new(64, self.deletePlayerButton:getBottom() + 32, self.width - 64 * 2, 250)
    self.richText:initialise()
    self.richText.background = false
    self.richText:setAnchorBottom(false)
    self.richText:setAnchorRight(true)
    self.richText:setVisible(false)
    self.panel:addChild(self.richText)

    self:setVisible(false);

    self.statusTextY = UI_BORDER_SPACING + 1 + FONT_HGT_TITLE + 30

    self.serverProgressBar = ISProgressBar:new (20, self.statusTextY+FONT_HGT_LARGE+10, self.width-40, 25, "", UIFont.Small);
    self.serverProgressBar.progressColor = namedColorToTable("ProgressYellow"); --{r=1.0, g=0.95, b=0.4, a=1};
    self.serverProgressBar.progressTexture = self.horzTexture;
    self.serverProgressBar.forceIt = true;
    self.serverProgressBar:initialise();
    self.serverProgressBar:instantiate();
    self:addChild(self.serverProgressBar);
    self.serverProgressBar:setProgress(0);
    self.serverProgressBar:setVisible(false);

    self.progress = 0;
    self.nextProgress = 0;
    self.workshopCount = 0;
    self.serverStatus = "";
    self.uiStatus = "idle";

    Events.OnCoopServerMessage.Add(CoopOptionsScreen.onCoopServerMessage)
    Events.OnConnected.Add(CoopOptionsScreen.OnConnected)
    Events.OnConnectFailed.Add(CoopOptionsScreen.OnConnectFailed)
    Events.OnConnectionStateChanged.Add(CoopOptionsScreen.OnConnectionStateChanged)
end

function CoopOptionsScreen:render()
--    self.playButton:setVisible(false);
--    self.deleteButton:setVisible(false);
--~     self.newButton:setX(self.width - 126);
--    if false then --self.listbox.items[self.listbox.selected] then
--        self.playButton:setVisible(true);
--        self.deleteButton:setVisible(true);
--~         self.newButton:setX(self.playButton.x - 110);
--    end
end

function CoopOptionsScreen:prerender()
    if self.checkPlayer then
        self.checkPlayer = false
        self:checkPlayerExists()
    end
    ISPanel.prerender(self);
    if self.progress < self.nextProgress then
        self.progress = self.progress + PROGRESS_BAR_SPEED
        self.serverProgressBar:setProgress(CoopOptionsScreen.instance.progress)
    end
    self:drawTextCentre(getText("UI_coopscreen_title"), self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Title);
    self:drawTextCentre(self.serverStatus, self.width / 2, self.statusTextY, 1, 1, 1, 1, UIFont.Large);

    if self.softresetProgress then
        local barWidth = 300
        local barHeight = 24
        local done = barWidth * self.softresetProgress
        self:drawRect((self.width - barWidth) / 2, self.serverProgressBar:getBottom() + 32, done, barHeight, 1.0, 0.5, 0.5, 0.5)
        self:drawRectBorder((self.width - barWidth) / 2, self.serverProgressBar:getBottom() + 32, barWidth, barHeight, 1.0, 0.9, 0.9, 0.9)
    end

    self.panel:setVisible(self.uiStatus == "idle")

    CoopConnection.username = self.accountNameEntry:getText()
    if getSteamModeActive() then
        CoopConnection.username = getCurrentUserProfileName()
    end

    if self.uiStatus == "idle" then
        if getSteamModeActive() or isValidUserName(CoopConnection.username) then
            self.accountNameEntry:setValid(true)
            self.startButton:setEnable(true)
            if self.worldVersion == 0 then
                -- no version found
            elseif self.worldVersion > IsoWorld.getWorldVersion() then
                self.startButton:setEnable(false)
            elseif self.worldVersion <= 115 then
                self.startButton:setEnable(false)
            end
        else
            self.accountNameEntry:setValid(false)
            self.startButton:setEnable(false)
        end
    end

    local text = nil
    if self.worldVersion == 0 then
        -- not checked yet?
    elseif self.worldVersion > IsoWorld.getWorldVersion() then
        text = " <H1> <LEFT> <RED> " .. getText("UI_worldscreen_SaveCannotBeLoaded") .. " <LINE> <TEXT> <RED> " .. getText("UI_worldscreen_SavefileNewerThanGame") .. " <RGB:1,1,1> ";
    elseif self.worldVersion <= 115 then
        text = " <H1> <LEFT> <RED> " .. getText("UI_worldscreen_SaveCannotBeLoaded") .. " <LINE> <TEXT> <RED> " .. getText("UI_worldscreen_SavefileVehicle", self.worldVersion, IsoWorld.getWorldVersion()) .. " <RGB:1,1,1> "
    end
    if text then
        self.richText.text = text
        self.richText:paginate()
        self.richText:setVisible(true)
    else
        self.richText:setVisible(false)
    end
end

function CoopOptionsScreen:aboutToShow()
    self:loadOptions()
    self.accountNameEntry:setText(CoopConnection.username)
    self.settingsComboBox.options = {}
    self.settingsComboBox.selected = 1
    getServerSettingsManager():readAllSettings()
    for i=1,getServerSettingsManager():getSettingsCount() do
        local settings = getServerSettingsManager():getSettingsByIndex(i-1)
        self.settingsComboBox:addOption(settings:getName())
        if settings:getName() == CoopConnection.servername then
            self.settingsComboBox.selected = i
        end
    end
    if #self.settingsComboBox.options == 0 then
        self.settingsComboBox:addOption("servertest")
        self.settingsComboBox.selected = 1
    end

    CoopConnection.servername = self.settingsComboBox.options[self.settingsComboBox.selected]

    if self.memoryToIndex[CoopConnection.memory] then
        self.memoryComboBox.selected = self.memoryToIndex[CoopConnection.memory]
    else
        self.memoryComboBox.selected = 1
        CoopConnection.memory = self.memoryComboBox.options[self.memoryComboBox.selected].data
    end

    self:checkWorldExists()
    self:checkPlayerExists()
    self:checkWorldVersion()
end

function CoopOptionsScreen:onEditSettings()
    self:saveOptions()
    self:setVisible(false)
    ServerSettingsScreen.instance.prevScreen = self
    ServerSettingsScreen.instance.initialSelectedSettings = CoopConnection.servername
    ServerSettingsScreen.instance:aboutToShow()
    ServerSettingsScreen.instance:setVisible(true, self.panel.joyfocus or self.joyfocus)
end

function CoopOptionsScreen:onSettingsSelected()
    CoopConnection.servername = self.settingsComboBox.options[self.settingsComboBox.selected]
    self:checkWorldExists()
    self:checkPlayerExists()
    self:checkWorldVersion()
end

function CoopOptionsScreen:onMemorySelected()
    CoopConnection.memory = self.memoryComboBox.options[self.memoryComboBox.selected].data
end

function CoopOptionsScreen:getServerSaveFolder()
    return "Multiplayer/" .. CoopServer:getServerSaveFolder(CoopConnection.servername)
end

function CoopOptionsScreen:getPlayerSaveFolder()
    return "Multiplayer/" .. CoopServer:getPlayerSaveFolder(CoopConnection.servername)
end

function CoopOptionsScreen:onSoftReset()
    local screenW = getCore():getScreenWidth()
    local screenH = getCore():getScreenHeight()
    local folder = getAbsoluteSaveFolderName(self:getServerSaveFolder()):gsub("\\", "\\\\")
    local label = getText("UI_coopscreen_softreset_prompt", folder)
    local modal = ISModalDialog:new(0, 0, 1, 1, label, true, self, self.onSoftResetStep2)
    modal:setX((screenW - modal.width) / 2)
    modal:setY((screenH - modal.height) / 2)
    modal.backgroundColor.a = 0.9
    modal:initialise()
    modal:setCapture(true)
    modal:setAlwaysOnTop(true)
    modal:addToUIManager()
    local joypadData = self.panel.joyfocus
    if joypadData then
        modal.param1 = joypadData
        joypadData.focus = modal
        updateJoypadFocus(joypadData)
    end
end

function CoopOptionsScreen:onSoftResetStep2(button, joypadData)
    if joypadData then
        joypadData.focus = (button.internal == "NO") and self.panel or self
        updateJoypadFocus(joypadData)
    end
    if button.internal == "NO" then return end
    self.softreset = true
    self:onStartButtonDown()
end

function CoopOptionsScreen:onDeleteWorld()
    local screenW = getCore():getScreenWidth()
    local screenH = getCore():getScreenHeight()
    local folder = getAbsoluteSaveFolderName(self:getServerSaveFolder())
    local label = getText("UI_coopscreen_delete_world_prompt", folder)
    local modal = ISModalDialog:new(0, 0, 1, 1, label, true, self, self.onDeleteWorldStep2)
    modal:setX((screenW - modal.width) / 2)
    modal:setY((screenH - modal.height) / 2)
    modal.backgroundColor.a = 0.9
    modal:initialise()
    modal:setCapture(true)
    modal:setAlwaysOnTop(true)
    modal:addToUIManager()
    local joypadData = self.panel.joyfocus
    if joypadData then
        modal.param1 = joypadData
        joypadData.focus = modal
        updateJoypadFocus(joypadData)
    end
end

function CoopOptionsScreen:onDeleteWorldStep2(button, joypadData)
    if joypadData then
        joypadData.focus = self.panel
        updateJoypadFocus(joypadData)
    end
    if button.internal == "NO" then return end
    local folder = self:getServerSaveFolder(CoopConnection.servername)
    print('deleting coop server folder ' .. folder)
    if folder then
        deleteSave(folder)
    end
    self:checkWorldExists()
    self:checkWorldVersion()
end

function CoopOptionsScreen:onDeletePlayer()
    local screenW = getCore():getScreenWidth()
    local screenH = getCore():getScreenHeight()
    local label = getText("UI_coopscreen_delete_player_prompt", self.accountNameEntry:getText())
    local modal = ISModalDialog:new(0, 0, 1, 1, label, true, self, self.onDeletePlayerStep2)
    modal:setX((screenW - modal.width) / 2)
    modal:setY((screenH - modal.height) / 2)
    modal.backgroundColor.a = 0.9
    modal:initialise()
    modal:setCapture(true)
    modal:setAlwaysOnTop(true)
    modal:addToUIManager()
    local joypadData = self.panel.joyfocus
    if joypadData then
        modal.param1 = joypadData
        joypadData.focus = modal
        updateJoypadFocus(joypadData)
    end
end

function CoopOptionsScreen:onDeletePlayerStep2(button, joypadData)
    if joypadData then
        joypadData.focus = self.panel
        updateJoypadFocus(joypadData)
    end
    if button.internal == "NO" then return end
    print('deleting coop player ' .. self.accountNameEntry:getText())
    local folder = self:getPlayerSaveFolder(CoopConnection.servername)
    deletePlayerFromDatabase(self:getServerSaveFolder(CoopConnection.servername), self.accountNameEntry:getText(),CoopConnection.servername)
    if folder then
        deleteSave(folder)
    end
    self:checkPlayerExists()
end

function CoopOptionsScreen:onBackButtonDown(button, x, y)
    self:saveOptions()
    self:setVisible(false);
    MainScreen.instance.onlineCoopScreen:setVisible(false);
    MainScreen.instance.bottomPanel:setVisible(true);
    local joypadData = JoypadState.getMainMenuJoypad();
    if joypadData then
        joypadData.focus = MainScreen.instance;
        updateJoypadFocus(joypadData);
    end
end

function CoopOptionsScreen:onStartButtonDown(button, x, y)
    self:saveOptions()
    if getSteamModeActive() then
        steamReleaseInternetServersRequest() -- Needed due to PublicServerList:create()
    end
    CoopConnection.username = self.accountNameEntry:getText()

    if getServerSettingsManager():isValidNewName(CoopConnection.servername) then
        local settings = ServerSettings.new(CoopConnection.servername)
        if not settings:isValid() then
            local modal = ISModalDialog:new(getCore():getScreenWidth() / 2 - 175,getCore():getScreenHeight() / 2 - 75, 250, 150, settings:getErrorMsg(), false);
            modal:initialise()
            modal:addToUIManager()
            return;
        end
        DefaultServerSettings:setDefaultsFromSingleplayer(settings)
        settings:saveFiles()
    end
    -- Determine the server password (for non-Steam co-op servers)
    if not getSteamModeActive() then
        local settings = ServerSettings.new(CoopConnection.servername)
        if not settings:isValid() then
            local modal = ISModalDialog:new(getCore():getScreenWidth() / 2 - 175,getCore():getScreenHeight() / 2 - 75, 250, 150, settings:getErrorMsg(), false);
            modal:initialise()
            modal:addToUIManager()
            return;
        end
        settings:loadFiles()
        CoopConnection.serverPassword = settings:getServerOptions():getOption("Password")
    end
    if self.softreset then
        self.softreset = false
        CoopServer:softreset(CoopConnection.servername, CoopConnection.username, CoopConnection.memory)
    else
        local error = checkServerName(CoopConnection.servername)
        if error then
            local modal = ISModalDialog:new(getCore():getScreenWidth() / 2 - 175,getCore():getScreenHeight() / 2 - 75, 250, 150, error, false);
            modal:initialise()
            modal:addToUIManager()
            return;
        end
        CoopServer:launch(CoopConnection.servername, CoopConnection.username, CoopConnection.memory);
    end
    self.serverProgressBar:setVisible(true);
    self.serverProgressBar:setProgress(0);
    self.nextProgress = 0;
    self.progress = 0;
    self.serverStatus = getText("UI_ServerStatus_Launching");
    self.uiStatus = "launching";
    self.startButton:setEnable(false);
    self.abortButton:setEnable(true);
end

function CoopOptionsScreen:onAbortButtonDown(button, x, y)
    CoopServer:abort();
    self.abortButton:setEnable(false);
    self.backButton:setEnable(false);
end

function CoopOptionsScreen:checkWorldExists()
    local folder = self:getServerSaveFolder()
    local worldExists = checkSaveFolderExists(folder)
    self.softResetButton:setEnable(worldExists)
    self.deleteWorldButton:setEnable(worldExists)
end

function CoopOptionsScreen:onUsernameChanged()
    CoopOptionsScreen.instance.checkPlayer = true;
end

function CoopOptionsScreen:checkPlayerExists()
    self.deletePlayerButton:setEnable(checkPlayerExistsInDatabase(self:getServerSaveFolder(CoopConnection.servername), self.accountNameEntry:getText(), CoopConnection.servername))
end

function CoopOptionsScreen:checkWorldVersion()
	local folder = self:getServerSaveFolder()
	self.worldVersion = getServerSavedWorldVersion(folder)
end

function CoopOptionsScreen:saveOptions()
	local writer = getFileWriter("host.ini", true, false)
	writer:write("servername=" .. CoopConnection.servername .. "\r\n")
	writer:write("username=" .. CoopConnection.username .. "\r\n")
	writer:write("memory=" .. tostring(CoopConnection.memory) .. "\r\n")
	writer:close()
end

function CoopOptionsScreen:loadOptions()
    local reader = getFileReader("host.ini", false)
    if not reader then return end
    while true do
        local line = reader:readLine()
        if not line then
            reader:close()
            break
        end
        if luautils.stringStarts(line, "servername=") then
            CoopConnection.servername = string.split(line, "=")[2]
        elseif luautils.stringStarts(line, "username=") then
            CoopConnection.username = string.split(line, "=")[2]
        elseif luautils.stringStarts(line, "memory=") then
            CoopConnection.memory = tonumber(string.split(line, "=")[2])
        end
    end
end

function CoopOptionsScreen:onResolutionChange(oldw, oldh, neww, newh)
    local right = (self.width+UI_BORDER_SPACING)/2
    local left = (self.width-UI_BORDER_SPACING)/2
    local children = self.panel:getChildren()

    for _, i in pairs(children) do
        if i.name ~= nil then
            i:setX(left-i.width)
        else
            i:setX(right)
        end
    end
end

function CoopOptionsScreen:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:setISButtonForA(self.startButton)
    self:setISButtonForY(self.abortButton)
    self:setISButtonForB(self.backButton)
end

function CoopOptionsScreen:onLoseJoypadFocus(joypadData)
	self.startButton:clearJoypadButton()
	self.abortButton:clearJoypadButton()
	self.backButton:clearJoypadButton()
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function CoopOptionsScreen:onJoypadBeforeDeactivate(joypadData)
	
end

function CoopOptionsScreen:onJoypadDirUp(joypadData)
	joypadData.focus = self.panel
	updateJoypadFocus(joypadData)
end

function CoopOptionsScreen.onCoopServerMessage(tag, cookie, payload)
     -- print("onCoopServerMessage");
     -- print(tag);
     -- print(payload);
    if tag == "status" and CoopOptionsScreen.instance ~= nil then
        local itemsCountTemplate = luautils.split(getText("UI_ServerStatus_Downloaded_Workshop_Items_Count")," ")[1];
        if luautils.stringStarts(payload, itemsCountTemplate) then
            CoopOptionsScreen.instance.workshopCount = tonumber(luautils.split(payload," ")[2]);
        else
            local itemsCountTemplate = luautils.split(getText("UI_ServerStatus_Downloaded_Workshop_Items_Progress")," ")[1];

            local payloadXln = luautils.stringStarts(payload, "UI_ServerStatus") and getText(payload) or payload
            CoopOptionsScreen.instance.serverStatus = payloadXln;
            if luautils.stringStarts(payload, "UI_ServerStatus_Terminated") then
                CoopOptionsScreen.instance.serverProgressBar:setVisible(false);
                CoopOptionsScreen.instance.serverProgressBar:setProgress(0);
                CoopOptionsScreen.instance.nextProgress = 0;
            else
                if luautils.stringStarts(payload, itemsCountTemplate) then
                    CoopOptionsScreen.instance.nextProgress = CoopOptionsScreen.instance.nextProgress + ((PROGRESS_BAR_WORKSHOP_WEIGHT) / CoopOptionsScreen.instance.workshopCount);
                else
                    CoopOptionsScreen.instance.nextProgress = CoopOptionsScreen.instance.nextProgress + (PROGRESS_BAR_STEP);
                end
            end
        end
    end
 
    if tag == "status" and payload == "UI_ServerStatus_Started" then
        CoopServer:sendMessage("set-host-user", CoopConnection.username);
        CoopOptionsScreen.instance.uiStatus = "connecting";
        if getSteamModeActive() then
            CoopServer:sendMessage("set-host-steamid", getCurrentUserSteamID())
            local serverID = CoopServer:getSteamID()
            serverConnectCoop(serverID)
        else
            local serverAddress = CoopServer:getAddress();
            local serverPort = tostring(CoopServer:getPort());
			--Set auth method as password only (1st method)
            serverConnect(CoopConnection.username, CoopServer:getAdminPassword(), serverAddress, serverAddress, serverPort, CoopConnection.serverPassword, CoopConnection.servername, false, true, 1, "")
        end
    end

    if tag == "login-attempt" and payload == CoopConnection.username then
        -- print("connection approved");
        CoopServer:sendMessage("approve-login-attempt", payload);
    end

    if tag == "process-status" and payload == "terminated" then
        CoopOptionsScreen.instance.uiStatus = "idle";
        CoopOptionsScreen.instance.startButton:setEnable(true);
        CoopOptionsScreen.instance.abortButton:setEnable(false);
        CoopOptionsScreen.instance.backButton:setEnable(true);
        CoopOptionsScreen.instance.serverProgressBar:setVisible(false);
        CoopOptionsScreen.instance.serverProgressBar:setProgress(0);
        CoopOptionsScreen.instance.nextProgress = 0;
        CoopOptionsScreen.instance.serverStatus = getText("UI_coopscreen_server_stopped", CoopServer:getTerminationReason())
        CoopOptionsScreen.instance.softresetProgress = nil
    end

    if tag == "softreset-count" then
        CoopOptionsScreen.instance.softresetCount = tonumber(payload)
        CoopOptionsScreen.instance.serverStatus = getText("UI_coopscreen_softreset_status")
        CoopOptionsScreen.instance.softresetProgress = 0.0
    end
    if tag == "softreset-remaining" then
        local total = CoopOptionsScreen.instance.softresetCount
        local remaining = tonumber(payload)
        CoopOptionsScreen.instance.softresetProgress = (total - remaining) / total
    end
    if tag == "softreset-finished" then
        CoopOptionsScreen.instance.serverStatus = ""
        CoopOptionsScreen.instance.softresetProgress = nil
    end
end

function CoopOptionsScreen.OnConnected()
    -- Other uis also have Events.OnConnectFailed callbacks.
    if not CoopOptionsScreen.instance:getIsVisible() then return end
    CoopOptionsScreen.instance.connecting = false
    CoopOptionsScreen.instance:setVisible(false)
end

function CoopOptionsScreen.OnConnectFailed(message)
    -- ServerList and PublicServerList also have Events.OnConnectFailed callbacks.
    if not CoopOptionsScreen.instance:getIsVisible() then return end
    CoopOptionsScreen.instance.connecting = false

    if message == "ServerWorkshopItemsCancelled" then
        message = getText("UI_coopscreen_ServerWorkshopItemsCancelled")
    end

    if not CoopOptionsScreen.instance.failMessage then CoopOptionsScreen.instance.failMessage = message end
    if not message then message = CoopOptionsScreen.instance.failMessage end
    CoopOptionsScreen.instance.serverStatus = message or getText("UI_servers_connectionfailed")
end

function CoopOptionsScreen.OnConnectionStateChanged(state, message)
    if not CoopOptionsScreen.instance:getIsVisible() then return end
    print(state .. ',' .. tostring(message))
    if state == "Disconnected" then return end
    if state == "Disconnecting" then return end
    if state == "Failed" and message then CoopOptionsScreen.instance.failMessage = getText('UI_servers_'..message) return end
    if state == "ClientVersionMismatch" and message then
        CoopOptionsScreen.instance.failMessage = getText('UI_OnConnectFailed_ClientVersionMismatch', getCore():getVersion(), message)
        return
    end
    CoopOptionsScreen.instance.serverStatus = state and getText('UI_servers_'..state) or "???"
end

