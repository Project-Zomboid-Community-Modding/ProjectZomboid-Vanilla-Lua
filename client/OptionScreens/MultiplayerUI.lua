require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISPanelJoypad"
require "ISUI/ISRichTextPanel"
require "ISUI/ISMPEditServer"
require "ISUI/ISScrollingListBox"

MultiplayerUI = ISPanel:derive("MultiplayerUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local BUTTON_HGT = FONT_HGT_SMALL + 3 * 2
local ENTRY_HGT = FONT_HGT_MEDIUM + 3 * 2
local INTERNET_HEADER_HGT = FONT_HGT_SMALL
local INTERNET_LIST_Y = 14 + ENTRY_HGT + 14 + INTERNET_HEADER_HGT;
local SEPARATOR_WIDTH = 2;
local SEPARATOR_LENGTH = 44;
local SEPARATOR_Y = 4;
local SERVER_INFO_WIDTH = 0;
local ICON_X = 13;
local SERVERNAME_X = 65;
local PLAYERS_COUNT_SEPARATOR = 0;
local PING_SEPARATOR = 0;
local INFO_ICON_WIDTH = 14;
local INFO_ICON_HEIGHT = 16;
local SERVER_ICON_SIZE = 42

function MultiplayerUI:initialise()
	ISPanel.initialise(self);
end

function MultiplayerUI:instantiate()
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

function MultiplayerUI:create()

    self.screenShading = ISMPScreenShading:new(self);
    self.screenShading:initialise()
    self.screenShading:setVisible(false)
    self.screenShading:addToUIManager()

    self.backButton = ISButton:new(0, 0, 81, BUTTON_HGT, getText("UI_servers_back"), self, MultiplayerUI.onOptionMouseDown);
    self.backButton.internal = "BACK";
    self.backButton:initialise();
    self.backButton:instantiate();
    self.backButton:enableCancelColor()
    self:addChild(self.backButton);

    self.refreshBtn = ISButton:new(0, 0, 81, BUTTON_HGT, getText("UI_servers_refresh"), self, MultiplayerUI.onOptionMouseDown);
    self.refreshBtn.internal = "REFRESH";
    self.refreshBtn:initialise();
    self.refreshBtn:instantiate();
    self:addChild(self.refreshBtn);

    self.connectBtn = ISButton:new(0, 0, 81, BUTTON_HGT, getText("UI_servers_connect"), self, MultiplayerUI.onOptionMouseDown);
    self.connectBtn.internal = "CONNECTFROMBROWSER";
    self.connectBtn:initialise();
    self.connectBtn:instantiate();
    self.connectBtn:enableAcceptColor();
    self:addChild(self.connectBtn);

    local tabHeight = 3 + FONT_HGT_LARGE + 3
    local tabGap = 12
    local tabWidth1 = 1 + tabHeight + getTextManager():MeasureStringX(UIFont.Large, getText("UI_servers_serverlist")) + tabGap
    local tabWidth2 = 1 + tabHeight + getTextManager():MeasureStringX(UIFont.Large, getText("UI_servers_publicServer")) + tabGap

    self.tabs = ISMPTabPanel:new(0, 0, 500, 32);
    self.tabs:initialise();
    self.tabs.tabPadX = 6
    self.tabs.tabHeight = tabHeight
    self.tabs.tabWidth = math.max(tabWidth1, tabWidth2)
    self:addChild(self.tabs);

    self.leftFavoritesPanel = ISPanel:new(0, 0, 0, 0);
    self.leftFavoritesPanel:initialise();
    self.leftFavoritesPanel.borderColor = {r=0, g=0, b=0, a=0};
    self.leftFavoritesPanel.backgroundColor = {r=0, g=0, b=0, a=0};
    self.tabs:addView(getText("UI_servers_serverlist"), getTexture("media/ui/MP/mp_ui_tab_star_enabled.png"), getTexture("media/ui/MP/mp_ui_tab_star_disabled.png"), self.leftFavoritesPanel)

    self.leftInternetPanel = ISPanel:new(0, 0, 0, 0);
    self.leftInternetPanel:initialise();
    self.leftInternetPanel.borderColor = {r=0, g=0, b=0, a=0};
    self.leftInternetPanel.backgroundColor = {r=0, g=0, b=0, a=0};
    if isPublicServerListAllowed() then
        self.tabs:addView(getText("UI_servers_publicServer"), getTexture("media/ui/MP/mp_ui_tab_internet_enabled.png"), getTexture("media/ui/MP/mp_ui_tab_internet_disabled.png"), self.leftInternetPanel)
    end

    self.rightPanel = ISPanel:new(0, 0, 0, 0);
    self.rightPanel:initialise();
    self.rightPanel.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    self.rightPanel.backgroundColor = {r=0, g=0, b=0, a=0.8};
    self:addChild(self.rightPanel);

    self.rightPanelInternal = ISPanel:new(0, 0, 0, 0);
    self.rightPanelInternal:initialise();
    self.rightPanelInternal.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    self.rightPanelInternal.backgroundColor = {r=0, g=0, b=0, a=0.8};
    self.rightPanelInternal.default_bottom_background = getTexture("media/ui/MP/mp_ui_bottom_background.png");
    self:addChild(self.rightPanelInternal);
    self.rightPanelInternal.render = function(self)
        ISPanel.render(self)
        local bannerHeight = self:getWidth() * 251 / 954
        local serverInfoBluePanelHeight = 128
        -- Bottom Background
        self:drawTextureScaled(self.default_bottom_background, 1, bannerHeight+serverInfoBluePanelHeight, self:getWidth()-2, self:getHeight() - bannerHeight-serverInfoBluePanelHeight, 1, 1, 1, 1);
    end

    self.rightPanelFavouritesButton = ISMPButton:new(0, 0, 167, FONT_HGT_SMALL, getText("UI_servers_remove_from_favourites"), self, MultiplayerUI.onOptionMouseDown);
    self.rightPanelFavouritesButton.internal = "FAVOURITES";
    self.rightPanelFavouritesButton:initialise();
    self.rightPanelFavouritesButton:instantiate();
    self.rightPanelFavouritesButton.font = UIFont.Small;
    self.rightPanelFavouritesButton.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.rightPanelFavouritesButton.backgroundColorMouseOver = {r=0.4, g=0.4, b=0.4, a=1.0};
    self.rightPanelFavouritesButton.borderColor = {r=1.0, g=1.0, b=1.0, a=1.0};
    self.rightPanelFavouritesButton:forceImageSize(14, 14)
    self.rightPanelFavouritesButton:setImage(getTexture("media/ui/MP/mp_ui_star_light.png"))
    self:addChild(self.rightPanelFavouritesButton);
    self.rightPanelFavouritesButton:setWidthToTitle()

    self.serverDescription = ISRichTextPanel:new(self.rightPanelMargin, 0, 300, 300);
    self.serverDescription:initialise();
    self:addChild(self.serverDescription);
    self.serverDescription.background = false;
    self.serverDescription.autosetheight = false;
    self.serverDescription:addScrollBars();
    self.serverDescription:paginate();
    self:addChild(self.serverDescription)
    self.serverDescription.backgroundColor = {r=0, g=0, b=0, a=0.0};
    self.serverDescription.render = function(self)
        self:setStencilRect(0,0,self:getWidth(),self:getHeight());
        ISRichTextPanel.render(self)
        self:clearStencilRect();
    end

    self.accountList = ISScrollingListBox:new(0, 0, 100, 100);
    self.accountList:initialise();
    self.accountList:instantiate();
    self.accountList.itemheight = math.max(BUTTON_HGT + FONT_HGT_SMALL, FONT_HGT_MEDIUM + FONT_HGT_SMALL, SERVER_ICON_SIZE + 6 * 2)
    self.accountList.selected = 0;
    self.accountList.joypadParent = self;
    self.accountList.doDrawItem = function(_self, _y, _item, _alt) return MultiplayerUI.drawAccountListItem(_self, _y, _item, _alt) end
    self.accountList:setOnMouseDownFunction(self, self.onSelectAccount)
    self.accountList.onMouseDoubleClick = MultiplayerUI.onDoubleClickAccount;
    self.accountList.drawBorder = true;
    self.accountList.useStencilForChildren = true
    self.accountList.parent = self;
    self.leftFavoritesPanel:addChild(self.accountList);


    self.filter = ISTextEntryBox:new("", 0, 0, 33, ENTRY_HGT);
    self.filter.font = UIFont.Medium
    self.filter:initialise();
    self.filter:instantiate();
    self.filter.mpUI = self;
    self.filter.onTextChange = MultiplayerUI.onTextFilterChange;
    self.filter:setPlaceholderText(getText("UI_servers_filter"))
    self.filter:setClearButton(true)
    self.leftInternetPanel:addChild(self.filter);
    self.filter.javaObject:setCentreVertically(true);

    self.filterVersion = ISTickBox:new(59, 317, 16, 16, "", self, self.onChangeFilter);
    self.filterVersion.tooltip = getText("UI_servers_versionCheck")
    self.filterVersion:initialise();
    self.filterVersion:instantiate();
    self.filterVersion.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterVersion:addOption("")
    self.leftInternetPanel:addChild(self.filterVersion);

    self.filterEmptyServer = ISTickBox:new(59, 317, 16, 16, "", self, self.onChangeFilter);
    self.filterEmptyServer.tooltip = getText("UI_servers_showEmptyServer")
    self.filterEmptyServer:initialise();
    self.filterEmptyServer:instantiate();
    self.filterEmptyServer.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterEmptyServer:addOption("")
    self.filterEmptyServer:setSelected(1, true);
    self.leftInternetPanel:addChild(self.filterEmptyServer);

    self.filterWhitelistServer = ISTickBox:new(59, 317, 16, 16, "", self, self.onChangeFilter);
    self.filterWhitelistServer.tooltip = getText("UI_servers_showWhitelistServer")
    self.filterWhitelistServer:initialise();
    self.filterWhitelistServer:instantiate();
    self.filterWhitelistServer.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterWhitelistServer:addOption("")
    self.leftInternetPanel:addChild(self.filterWhitelistServer);

    self.filterPwdProtected = ISTickBox:new(59, 317, 16, 16, "", self, self.onChangeFilter);
    self.filterPwdProtected.tooltip = getText("UI_servers_showPwdProtectedServer")
    self.filterPwdProtected:initialise();
    self.filterPwdProtected:instantiate();
    self.filterPwdProtected.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterPwdProtected:addOption("")
    self.leftInternetPanel:addChild(self.filterPwdProtected);

    self.filterFullServer = ISTickBox:new(59, 317, 16, 16, "", self, self.onChangeFilter);
    self.filterFullServer.tooltip = getText("UI_servers_showFullServer")
    self.filterFullServer:initialise();
    self.filterFullServer:instantiate();
    self.filterFullServer.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterFullServer:addOption("")
    self.filterFullServer:setSelected(1, true);
    self.leftInternetPanel:addChild(self.filterFullServer);

    self.filterModdedServer = ISTickBox:new(59, 317, 16, 16, "", self, self.onChangeFilter);
    self.filterModdedServer.tooltip = getText("UI_servers_showModdedServer")
    self.filterModdedServer:initialise();
    self.filterModdedServer:instantiate();
    self.filterModdedServer.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterModdedServer:addOption("")
    self.filterModdedServer:setSelected(1, true);
    self.leftInternetPanel:addChild(self.filterModdedServer);

    self.internetList = ISScrollingListBox:new(0, 0, 100, 100);
    self.internetList:initialise();
    self.internetList:instantiate();
    self.internetList.itemheight = math.max(FONT_HGT_MEDIUM + FONT_HGT_SMALL, SERVER_ICON_SIZE + 6 * 2)
    self.internetList.selected = 0;
    self.internetList.joypadParent = self;
    self.internetList.doDrawItem = function(_self, _y, _item, _alt) return MultiplayerUI.drawInternetListItem(_self, _y, _item, _alt) end;
    self.internetList:setOnMouseDownFunction(self, self.onSelectInternetServer)
    self.internetList:setOnMouseDoubleClick(self, MultiplayerUI.onDoubleClickInternetList);
    self.internetList.drawBorder = true;
    self.internetList.parent = self;
    self.leftInternetPanel:addChild(self.internetList);

    -- sorting buttons (on top of the list, their position is updated in the renderSortButtons function)
    self.buttonSortName = ISButton:new(0, 0, 0, 0, "Name", self, MultiplayerUI.onClickSort);
    self.buttonSortName.internal = "name";
    self.buttonSortName:initialise();
    self.buttonSortName:instantiate();
    self.buttonSortName.borderColor = {a=0.5, r=self.internetList.borderColor.r, g=self.internetList.borderColor.g, b=self.internetList.borderColor.b}
    self.buttonSortName.backgroundColor = {r=self.serverListItem.r, g=self.serverListItem.g, b=self.serverListItem.b, a=0.8};
    self.buttonSortName.backgroundColorMouseOver = {r=self.serverListItem.r, g=self.serverListItem.g, b=self.serverListItem.b, a=1};
    self.buttonSortName.iconRight = self.arrowUp;
    self.buttonSortName.iconRightWidth = 10;
    self.buttonSortName.iconRightHeight = 10;
    self.buttonSortName.iconRightColor = {r=1, g=1, b=1, a=0.5};
    self.buttonSortName.titleLeft = true;
    self.leftInternetPanel:addChild(self.buttonSortName);

    self.buttonSortPlayer = ISButton:new(0, 0, 0, 0, "Players", self, MultiplayerUI.onClickSort);
    self.buttonSortPlayer.internal = "player";
    self.buttonSortPlayer:initialise();
    self.buttonSortPlayer:instantiate();
    self.buttonSortPlayer.borderColor = {a=0.5, r=self.internetList.borderColor.r, g=self.internetList.borderColor.g, b=self.internetList.borderColor.b}
    self.buttonSortPlayer.backgroundColor = {r=self.serverListItem.r, g=self.serverListItem.g, b=self.serverListItem.b, a=0.8};
    self.buttonSortPlayer.backgroundColorMouseOver = {r=self.serverListItem.r, g=self.serverListItem.g, b=self.serverListItem.b, a=1};
    self.buttonSortPlayer.iconRight = self.arrowDown;
    self.buttonSortPlayer.iconRightWidth = 10;
    self.buttonSortPlayer.iconRightHeight = 10;
    self.buttonSortPlayer.iconRightColor = {r=1, g=1, b=1, a=0.5};
    self.buttonSortPlayer.titleLeft = true;
    self.leftInternetPanel:addChild(self.buttonSortPlayer);

    self.buttonSortPing = ISButton:new(0, 0, 0, 0, "Ping (ms)", self, MultiplayerUI.onClickSort);
    self.buttonSortPing.internal = "ping";
    self.buttonSortPing:initialise();
    self.buttonSortPing:instantiate();
    self.buttonSortPing.borderColor = {a=0.5, r=self.internetList.borderColor.r, g=self.internetList.borderColor.g, b=self.internetList.borderColor.b}
    self.buttonSortPing.backgroundColor = {r=self.serverListItem.r, g=self.serverListItem.g, b=self.serverListItem.b, a=0.8};
    self.buttonSortPing.backgroundColorMouseOver = {r=self.serverListItem.r, g=self.serverListItem.g, b=self.serverListItem.b, a=1};
    self.buttonSortPing.iconRight = self.arrowUp;
    self.buttonSortPing.iconRightWidth = 10;
    self.buttonSortPing.iconRightHeight = 10;
    self.buttonSortPing.iconRightColor = {r=1, g=1, b=1, a=0.5};
    self.buttonSortPing.titleLeft = true;
    self.leftInternetPanel:addChild(self.buttonSortPing);

    MultiplayerUI.startRefreshTime = 0

    self:refreshList();

    self:onResolutionChange(0, 0, self.width, self.height)

    self.created = true
    self:requestServerList()
end

function MultiplayerUI:onClickSort(button)
    if self.sortType == button.internal then
        self.sortDown = not self.sortDown;
    else
        self.sortDown = true;
    end

    self.sortType = button.internal;
    self:sortInternetList();
end

function MultiplayerUI:onChangeFilter()
    self:sortInternetList();
    self.serversInList = false;
end

function MultiplayerUI.onTextFilterChange(box)
    box.mpUI:sortInternetList();
end

function MultiplayerUI:drawAccountListItem(y, item, alt)
    local a = 0.9;
    local serverListSelected = self.parent.parent.parent.serverListSelected
    local serverListItem = self.parent.parent.parent.serverListItem
    local ui_ping = self.parent.parent.parent.ui_ping
    local ui_players = self.parent.parent.parent.ui_players
    local ui_separator = self.parent.parent.parent.ui_separator
    local icon = self.parent.parent.parent.ui_details_icon
    local ui_icon_bg = self.parent.parent.parent.ui_icon_bg
    local add_icon = self.parent.parent.parent.ui_add_icon
    local online = self.parent.parent.parent.ui_online
    local offline = self.parent.parent.parent.ui_offline
    local subitem_first = self.parent.parent.parent.ui_subitem_first
    local subitem_other = self.parent.parent.parent.ui_subitem_other
    local leftSpace = 0;
    if item.item.type == "account" or item.item.type == "new_account" then
        leftSpace = 65;
    end

    if self.selected == item.index then
        self:drawRect(leftSpace, (y), self:getWidth()-leftSpace, self.itemheight - 1, serverListSelected.a, serverListSelected.r, serverListSelected.g, serverListSelected.b);
    else
        self:drawRect(leftSpace, (y), self:getWidth()-leftSpace, self.itemheight - 1, serverListItem.a, serverListItem.r, serverListItem.g, serverListItem.b);
    end

    local textOffsetY = (item.height - (FONT_HGT_MEDIUM + FONT_HGT_SMALL)) / 2
    local buttonOffsetY = (item.height - (BUTTON_HGT + FONT_HGT_SMALL)) / 2

    if item.item.type == "server" then
        local server = item.item.server
        -- Icon
        self:setStencilCircle(25, y + self:getYScroll() + (item.height - SERVER_ICON_SIZE) / 2, SERVER_ICON_SIZE, SERVER_ICON_SIZE)
        self:drawTextureScaled(icon, 25, y + (item.height - SERVER_ICON_SIZE) / 2, SERVER_ICON_SIZE, SERVER_ICON_SIZE, 1, 1, 1, 1);
        self:clearStencilRect()
        self:repaintStencilRect(0,0,self:getWidth(), self:getHeight())
        -- OnlineStatus
        if server:isResponded() then
            self:drawTextureScaled(online, 53, y + 32, 15, 15, 1, 1, 1, 1);
        else
            self:drawTextureScaled(offline, 53, y + 32, 15, 15, 1, 1, 1, 1);
        end

        -- Name
        self:setStencilRect(86, y + self:getYScroll() + textOffsetY, self:getWidth() - 314 - 86 - 5, FONT_HGT_MEDIUM)
        self:drawText(server:getName(), 86, y + textOffsetY, 1,1,1, a, UIFont.NewMedium);
        self:clearStencilRect()
        -- Info
        local text = server:getIp()..":"..tostring(server:getPort())
        local textX = 86
        self:drawText(text, textX, y + textOffsetY + FONT_HGT_MEDIUM, 1, 1, 1, a, UIFont.Small);
        textX = textX + getTextManager():MeasureStringX(UIFont.Small, text)
        text = " | "
        self:drawText(text, textX, y + textOffsetY + FONT_HGT_MEDIUM, 1, 1, 1, a, UIFont.Small);
        textX = textX + getTextManager():MeasureStringX(UIFont.Small, text)
        if server:getVersion() then
            self:drawText("V "..server:getVersion(), textX, y + textOffsetY + FONT_HGT_MEDIUM, 1, 1, 1, a, UIFont.NewSmall);
        else
            self:drawText("V -", textX, y + textOffsetY + FONT_HGT_MEDIUM, 1, 1, 1, a, UIFont.NewSmall);
        end

        local playerIconWid = 29
        local playerColumnWid = 6 + playerIconWid + 6 + getTextManager():MeasureStringX(UIFont.Medium, "999/999") + 6

        local pingIconWid = 27
        local pingColumnWid = 6 + pingIconWid + 6 + getTextManager():MeasureStringX(UIFont.Medium, "9999") + 6

        playerColumnWid = math.max(playerColumnWid, pingColumnWid)
        pingColumnWid = playerColumnWid

        SEPARATOR_LENGTH = item.height - SEPARATOR_Y * 2
        local pingColumnX = self:getWidth() - pingColumnWid
        local pingTextX = pingColumnX + 6 + pingIconWid + 6
        local playerColumnX = pingColumnX - playerColumnWid
        local playerTextX = playerColumnX + 6 + playerIconWid + 6
        textOffsetY = (item.height - FONT_HGT_MEDIUM) / 2
        local iconOffsetY = (item.height - 24) / 2

        -- Separator
        self:drawTextureScaled(ui_separator, playerColumnX, y + SEPARATOR_Y, SEPARATOR_WIDTH, SEPARATOR_LENGTH, 1, 1, 1, 1);
        -- Players
        self:drawTextureScaled(ui_players, playerColumnX + 6, y + iconOffsetY, 29, 24, 1, 1, 1, 1);
        if server:getPlayers() then
            self:drawText(server:getPlayers().."/"..server:getMaxPlayers(), playerTextX, y + textOffsetY, 1, 1, 1, a, UIFont.NewMedium);
        else
            self:drawText("-/-", playerTextX, y + textOffsetY, 1, 1, 1, a, UIFont.NewMedium);
        end
        -- Separator
        self:drawTextureScaled(ui_separator, pingColumnX, y + SEPARATOR_Y, SEPARATOR_WIDTH, SEPARATOR_LENGTH, 1, 1, 1, 1);
        -- Ping
        self:drawTextureScaled(ui_ping, pingColumnX + 6, y + iconOffsetY, 27, 24, 1, 1, 1, 1);
        if server:getPing() then
            self:drawText(server:getPing(), pingTextX, y + textOffsetY, 1, 1, 1, a, UIFont.NewMedium);
        else
            self:drawText("-", pingTextX, y + textOffsetY, 1, 1, 1, a, UIFont.NewMedium);
        end

        item.item.editButton:setX(playerColumnX - 10 - item.item.editButton.width)
        item.item.editButton:setY(y + self:getYScroll() + (item.height - BUTTON_HGT) / 2)
    end

    if item.item.type == "new_server" then
        -- Icon
        self:drawTextureScaled(add_icon, leftSpace+25, y + (item.height - SERVER_ICON_SIZE) / 2, SERVER_ICON_SIZE, SERVER_ICON_SIZE, 1, 1, 1, 1);
        -- Name
        self:drawText(getText("UI_servers_addserver"), leftSpace+86, y + (item.height - FONT_HGT_MEDIUM) / 2, 1,1,1, a, UIFont.NewMedium);
    end

    if item.item.type == "account" then
        local account = item.item.account
        if item.item.first then
            self:drawTextureScaled(subitem_first,45, y, 20, 29, 1, 1, 1, 1);
        else
            self:drawTextureScaled(subitem_other, 45, y-26, 20, 54, 1, 1, 1, 1);
        end
        -- Icon
        if account:getIcon() then
            self:setStencilCircle(leftSpace+25, y + self:getYScroll() + (item.height - SERVER_ICON_SIZE) / 2, SERVER_ICON_SIZE, SERVER_ICON_SIZE)
            self:drawTextureScaled(account:getIcon(), leftSpace+25, y + (item.height - SERVER_ICON_SIZE) / 2, SERVER_ICON_SIZE, SERVER_ICON_SIZE, 1, 1, 1, 1);
            self:clearStencilRect()
        else
            self:drawTextureScaled(ui_icon_bg, leftSpace+25, y + (item.height - SERVER_ICON_SIZE) / 2, SERVER_ICON_SIZE, SERVER_ICON_SIZE, 1, 1, 1, 1);
            self:drawTextCentre(getTwoLetters(account:getUserName()), leftSpace+46, y + 12, 1,1,1, a, UIFont.Large);
        end

        -- Name
        local name = account:getUserName();
        if account:getPlayerFirstAndLastName() then
            name = name .. " (" .. account:getPlayerFirstAndLastName() .. ")";
        end
        self:drawText(name, leftSpace+86, y + textOffsetY, 1,1,1, a, UIFont.NewMedium);
        -- Info
        if account:getTimePlayed() then
            self:drawText(getText("UI_servers_time_played")..tostring(account:getTimePlayed())..getText("UI_servers_minutes"), leftSpace+86, y + textOffsetY + FONT_HGT_MEDIUM, 1, 1, 1, a, UIFont.Small);
        else
            self:drawText(getText("UI_servers_time_played") .. "-" .. getText("UI_servers_minutes"), leftSpace+86, y + textOffsetY + FONT_HGT_MEDIUM, 1, 1, 1, a, UIFont.Small);
        end
        --self:drawText("|", leftSpace+217, y + 30, 1, 1, 1, a, UIFont.Small);
        if account:getLastLogon() then
            self:drawTextRight(getText("UI_servers_last_logout") .. tostring(account:getLastLogon()), self:getWidth() - 5, y + buttonOffsetY + BUTTON_HGT, 1, 1, 1, a, UIFont.NewSmall);
        else
            self:drawText(getText("UI_servers_last_logout") .. "-", self:getWidth() - 5, y + buttonOffsetY + BUTTON_HGT, 1, 1, 1, a, UIFont.NewSmall);
        end

        --self:drawRect(5, 80, self:getWidth() - 10, 10, 1,1,1,1);
        item.item.deleteButton:setX(self:getWidth() - item.item.deleteButton:getWidth() - 5)
        item.item.deleteButton:setY(y + self:getYScroll() + buttonOffsetY)

        item.item.editButton:setX(item.item.deleteButton:getX() - item.item.editButton:getWidth() - 5)
        item.item.editButton:setY(y + self:getYScroll() + buttonOffsetY)

        item.item.connectButton:setX(item.item.editButton:getX() - item.item.connectButton:getWidth() - 5)
        item.item.connectButton:setY(y + self:getYScroll() + buttonOffsetY)
    end

    if item.item.type == "new_account" then
        if item.item.first then
            self:drawTextureScaled(subitem_first,45, y, 20, 29, 1, 1, 1, 1);
        else
            self:drawTextureScaled(subitem_other, 45, y-26, 20, 54, 1, 1, 1, 1);
        end
        -- Icon
        self:drawTextureScaled(add_icon, leftSpace+25, y + (item.height - SERVER_ICON_SIZE) / 2, SERVER_ICON_SIZE, SERVER_ICON_SIZE, 1, 1, 1, 1);
        -- Name
        self:drawText(getText("UI_servers_add_new_account"), leftSpace+86, y + (item.height - FONT_HGT_MEDIUM) / 2, 1,1,1, a, UIFont.NewMedium);
    end

    return y + self.itemheight
end

function MultiplayerUI:drawInternetListItem(y, item, alt)
    local server = item.item
    if (y  + self:getYScroll() < -self.itemheight) or (y  + self:getYScroll() > self:getHeight()) then
        return y + self.itemheight
    end

    -- RJ: the filters you select on top are now done in java (GameClient.sortBrowserList)
    self.parent.parent.parent.serversInList = true;

    local a = 0.9;
    local serverListSelected = self.parent.parent.parent.serverListSelected
    local serverListItem = self.parent.parent.parent.serverListItem
    local ui_ping = self.parent.parent.parent.ui_ping
    local ui_players = self.parent.parent.parent.ui_players
    local ui_separator = self.parent.parent.parent.ui_separator
    local icon = self.parent.parent.parent.ui_icon_bg

    local ui_feature = self.parent.parent.parent.ui_feature
    local ui_feature_enabled = self.parent.parent.parent.ui_feature_enabled
    local ui_open = self.parent.parent.parent.ui_open
    local ui_closed = self.parent.parent.parent.ui_closed
    local ui_mod = self.parent.parent.parent.ui_filters_mods;
    local ui_mod_off = self.parent.parent.parent.ui_filters_mods_off;
    --    self.parent.selectedFaction = nil;
    -- self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    local iconOffsetY = (item.height - SERVER_ICON_SIZE) / 2
    local textOffsetY = (item.height - (FONT_HGT_MEDIUM + FONT_HGT_SMALL)) / 2

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, serverListSelected.a, serverListSelected.r, serverListSelected.g, serverListSelected.b);
    else
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, serverListItem.a, serverListItem.r, serverListItem.g, serverListItem.b);
    end

    local playerIconWid = 29
    local playerColumnWid = 6 + playerIconWid + 6 + getTextManager():MeasureStringX(UIFont.Medium, "999/999") + 6

    local pingIconWid = 27
    local pingColumnWid = 6 + pingIconWid + 6 + getTextManager():MeasureStringX(UIFont.Medium, "9999") + 6

    playerColumnWid = math.max(playerColumnWid, pingColumnWid)
    pingColumnWid = playerColumnWid

    -- Icon
    self:drawTextureScaled(icon, ICON_X, y + iconOffsetY, SERVER_ICON_SIZE, SERVER_ICON_SIZE, 1, 1, 1, 1);
    self:drawTextCentre(getTwoLetters(item.text), ICON_X + 21, y + (item.height - FONT_HGT_LARGE) / 2, 1,1,1, a, UIFont.Large);

    -- Name
    SERVER_INFO_WIDTH = self:getWidth() - playerColumnWid - pingColumnWid;
    self:setStencilRect(SERVERNAME_X, y + self:getYScroll() + textOffsetY, SERVER_INFO_WIDTH - 65, FONT_HGT_MEDIUM)
    self:drawText(item.item:getName(), SERVERNAME_X, y + textOffsetY, 1,1,1, a, UIFont.NewMedium);
    self:clearStencilRect()

    -- IP
    self:drawText(item.item:getIp()..":"..tostring(item.item:getPort()), SERVERNAME_X, y + textOffsetY + FONT_HGT_MEDIUM, 1, 1, 1, a, UIFont.Small);

    -- Icons in the bottom right
    local infoIconY = y + item.height - 4 - INFO_ICON_HEIGHT
    -- Whitelisted
    if item.item:isOpen() then
        self:drawTextureScaled(ui_feature, SERVER_INFO_WIDTH - 18, infoIconY, INFO_ICON_WIDTH, INFO_ICON_HEIGHT, 1, 1, 1, 1);
    else
        self:drawTextureScaled(ui_feature_enabled, SERVER_INFO_WIDTH - 18, infoIconY, INFO_ICON_WIDTH, INFO_ICON_HEIGHT, 1, 1, 1, 1);
    end
    -- Password protected
    if item.item:isPasswordProtected() then
        self:drawTextureScaled(ui_closed, SERVER_INFO_WIDTH - 18 - INFO_ICON_WIDTH - 4, infoIconY, INFO_ICON_WIDTH, INFO_ICON_HEIGHT, 1, 1, 1, 1);
    else
        self:drawTextureScaled(ui_open, SERVER_INFO_WIDTH - 18 - INFO_ICON_WIDTH - 4, infoIconY, INFO_ICON_WIDTH, INFO_ICON_HEIGHT, 1, 1, 1, 1);
    end
    -- mods
    if server:getMods() and "" ~= server:getMods() then
        self:drawTextureScaled(ui_mod, SERVER_INFO_WIDTH - 18 - (INFO_ICON_WIDTH * 2) - 8, infoIconY, INFO_ICON_WIDTH, INFO_ICON_HEIGHT, 1, 1, 1, 1);
    else
        self:drawTextureScaled(ui_mod_off, SERVER_INFO_WIDTH - 18 - (INFO_ICON_WIDTH * 2) - 8, infoIconY, INFO_ICON_WIDTH, INFO_ICON_HEIGHT, 1, 1, 1, 1);
    end

    -- Version
    if item.item:getVersion() and item.item:getVersion() ~= "" then
        self:drawTextRight("V ".. item.item:getVersion(), SERVER_INFO_WIDTH - 18 - (INFO_ICON_WIDTH * 3) - 8, y + 30, 1, 1, 1, a, UIFont.NewSmall);
    end

    SEPARATOR_LENGTH = item.height - SEPARATOR_Y * 2
    PLAYERS_COUNT_SEPARATOR = SERVER_INFO_WIDTH + 0
    textOffsetY = (item.height - FONT_HGT_MEDIUM) / 2
    iconOffsetY = (item.height - 24) / 2

    -- Separator
    self:drawTextureScaled(ui_separator, PLAYERS_COUNT_SEPARATOR, y + SEPARATOR_Y, SEPARATOR_WIDTH, SEPARATOR_LENGTH, 1, 1, 1, 1);
    -- Players
    self:drawTextureScaled(ui_players, PLAYERS_COUNT_SEPARATOR + 6, y + iconOffsetY, 29, 24, 1, 1, 1, 1);
    self:drawText(item.item:getPlayers().."/"..item.item:getMaxPlayers(), PLAYERS_COUNT_SEPARATOR + 6 + playerIconWid + 6, y + textOffsetY, 1, 1, 1, a, UIFont.NewMedium);
    -- Separator
    PING_SEPARATOR = PLAYERS_COUNT_SEPARATOR + playerColumnWid;
    self:drawTextureScaled(ui_separator, PING_SEPARATOR, y + SEPARATOR_Y, SEPARATOR_WIDTH, SEPARATOR_LENGTH, 1, 1, 1, 1);
    -- Ping
    self:drawTextureScaled(ui_ping, PING_SEPARATOR + 6, y + iconOffsetY, 27, 24, 1, 1, 1, 1);
    -- if ping is -1 we don't display it (it's initialised as -1)
    if tonumber(item.item:getPing()) > -1 then
        self:drawText(item.item:getPing(), PING_SEPARATOR + 6 + pingIconWid + 6, y + textOffsetY, 1, 1, 1, a, UIFont.NewMedium);
    end


    return y + self.itemheight
end

function MultiplayerUI:getServerFeatured(server)
    for i,v in ipairs(self.accountList.items) do
        if v.item.type == "server" and v.item.server:getIp() == server:getIp() and v.item.server:getPort() == server:getPort() then return v.item; end;
    end
    return nil
end

function MultiplayerUI:onSelectInternetServer(server)
    if getSteamModeActive() and server:getIp() and server:getIp() ~= "" and server:getPort() then
        server:setMods("")
        server:setDescription("")
        steamRequestServerDetails(getHostByName(server:getIp()), server:getPort())
    end
    self:selectInternetServer(server)
end

function MultiplayerUI:selectInternetServer(server)
    if not self.created then
        return
    end
    self.selectedInternetServer = server;
    self.selectedInternetServerFeatured = (self:getServerFeatured(server) ~= nil)
    if self.selectedInternetServerFeatured then
        self.rightPanelFavouritesButton:setTitle(getText("UI_servers_remove_from_favourites"))
        self.rightPanelFavouritesButton:setImage(getTexture("media/ui/MP/mp_ui_star_light.png"))
    else
        self.rightPanelFavouritesButton:setTitle(getText("UI_servers_add_to_favourites"))
        self.rightPanelFavouritesButton:setImage(getTexture("media/ui/MP/mp_ui_star.png"))
    end
    self.rightPanelFavouritesButton:setWidthToTitle()
    self.serverDescription.text = string.gsub(server:getDescription() or "", "\\n", " <LINE> ");

    if server:getMods() and server:getMods() ~= "" then
        local mods = server:getMods()
        if getSteamModeActive() then
            mods = mods:gsub(";", ",")
        end
        mods = mods:gsub("<", "&lt")
        mods = mods:gsub(">", "&gt")
        mods = mods:gsub(",", " <LINE> ")
        self.serverDescription.text = self.serverDescription.text .. " <BR><IMAGE:media/ui/MP/mp_ui_filters_mods.png,24,24> <SIZE:large><RGB:0.45,0.57,0.64> " .. getText("UI_servers_mods") .. " <SIZE:small><RGB:1.0,1.0,1.0>234<LINE>" .. mods
    end

    self.serverDescription:paginate();
    local lines = splitString(server:getName(), 36)
    self.selectedInternetServerName1 = lines[0]
    self.selectedInternetServerName2 = lines[1]
end

function MultiplayerUI:onDoubleClickInternetList(server)
    self.selectedInternetServerFeatured = (self:getServerFeatured(server) ~= nil)
    self:connectFromBrowser();
end

function MultiplayerUI.onDoubleClickAccount(accountList, x, y)
    local row = accountList:rowAt(x, y)
    local item = accountList.items[row]
    if item and item.item.type == "account" then
        accountList.parent.parent.parent:onPressButtonOnAccountList({internal = "CONNECT", server = item.item.server, account = item.item.account}, x, y)
    end
end

function MultiplayerUI:onSelectAccount(_item)
    if not self.created then
        return
    end
    self.selectedAccount = _item;
    if _item.type == "server" or _item.type == "account" then
        self:onSelectInternetServer(_item.server)
    end
    if _item.type == "new_server" then
        self.modal = ISMPEditServer:new(self, nil);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:setAlwaysOnTop(true)
        self.modal:setAlwaysOnTop(true)
    end
    if _item.type == "new_account" then
        self.modal = ISMPEditAccount:new(self, _item.server, nil);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:setAlwaysOnTop(true)
        self.modal:setAlwaysOnTop(true)
    end
end

function MultiplayerUI:onDeleteAccount(button, account)
    if button.internal == "YES" then
        deleteAccountToAccountList(account)
        self:refreshList()
    end
    self.modal = nil
    self.screenShading:setVisible(false)
end

function MultiplayerUI:onDeleteServer(button, server)
    if button.internal == "YES" then
        deleteServerToAccountList(server)
        self:refreshList()
        self:selectInternetServer(server)
    end
    self.modal = nil
    self.screenShading:setVisible(false)
end

function MultiplayerUI:onPressButtonOnAccountList(button, x, y)
    if button.internal == "EDIT_SERVER" then
        self.modal = ISMPEditServer:new(self, button.server);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:setAlwaysOnTop(true)
        self.modal:setAlwaysOnTop(true)
    elseif button.internal == "DELETE_ACCOUNT" then
        self.modal = ISModalDialog:new(0,0, 250, 150,  getText("UI_servers_delete_account"), true, self, MultiplayerUI.onDeleteAccount, nil, button.account);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:setAlwaysOnTop(true)
        self.modal:setAlwaysOnTop(true)
    elseif button.internal == "EDIT_ACCOUNT" then
        self.modal = ISMPEditAccount:new(self, button.server, button.account);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:setAlwaysOnTop(true)
        self.modal:setAlwaysOnTop(true)
    elseif button.internal == "CONNECT" then
        print("Connecting to server (IP: " .. tostring(button.server:getIp()) .. "; Port: " .. tostring(button.server:getPort()) .. ").")
        self:connectToServer(button.server, button.account);
    end
end

function MultiplayerUI:connectToServer(server, account)
    getCore():setAccountUsed(account)
    if not account:isSavePwd() then
        self.modal = ISMPEnterPassword:new(self, server, account);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:setAlwaysOnTop(true)
        self.modal:setAlwaysOnTop(true)
        return
    end
    account:setLastLogonNow()
    updateAccountToAccountList(account)
    if getSteamModeActive() then
        steamReleaseInternetServersRequest()
    end
    stopSendSecretKey();
    getCore():setNoSave(false);
    local localIP = getSteamModeActive() and server:getLocalIP() or ""
    local useSteamRelay = getSteamModeActive() and account:getUseSteamRelay()
    ConnectToServer.instance.loadingBackground = server:getServerLoadingScreen();
    ConnectToServer.instance:connect(self, server:getName(), account:getUserName(), account:getPwd(), server:getIp(), localIP, tostring(server:getPort()), server:getServerPassword(), useSteamRelay, false, account:getAuthType());
end

function MultiplayerUI:refreshList()
    for i, item in ipairs(self.accountList.items) do
        if item.item.type == "server" then
            self.accountList:removeChild(item.item.editButton)
        end
        if item.item.type == "account" then
            self.accountList:removeChild(item.item.deleteButton)
            self.accountList:removeChild(item.item.editButton)
            self.accountList:removeChild(item.item.connectButton)
        end
    end
    self.accountList:clear();
    local servers = getServerList();
    local isFirst = true
    for _,server in ipairs(servers) do
        isFirst = true

        editButton = ISButton:new(0, 0, 92, BUTTON_HGT, getText("UI_servers_button_edit"), self, MultiplayerUI.onPressButtonOnAccountList);
        editButton.internal = "EDIT_SERVER";
        editButton:initialise();
        editButton:instantiate();
        editButton.server = server
        editButton.font = UIFont.Small;
        self.accountList:addChild(editButton);

        self.accountList:addItem(server:getName(), {type="server", server=server, editButton=editButton});
        if getSteamModeActive() and server:getPort() and isSteamServerBrowserEnabled() then
            steamRequestServerDetails(getHostByName(server:getIp()), server:getPort())
        end
        for i=0,server:getAccounts():size()-1 do
            local account = server:getAccounts():get(i);

            deleteButton = ISButton:new(0, 0, 83, BUTTON_HGT, getText("UI_servers_button_delete"), self, MultiplayerUI.onPressButtonOnAccountList);
            deleteButton.internal = "DELETE_ACCOUNT";
            deleteButton:initialise();
            deleteButton:instantiate();
            deleteButton.server = server
            deleteButton.account = account
            deleteButton.font = UIFont.Small;
            deleteButton:enableCancelColor()
            deleteButton:setWidthToTitle();
            self.accountList:addChild(deleteButton);

            editButton = ISButton:new(0, 0, 65, BUTTON_HGT, getText("UI_servers_button_edit"), self, MultiplayerUI.onPressButtonOnAccountList);
            editButton.internal = "EDIT_ACCOUNT";
            editButton:initialise();
            editButton:instantiate();
            editButton.server = server
            editButton.account = account
            editButton.font = UIFont.Small;
            editButton:setWidthToTitle();
            self.accountList:addChild(editButton);

            connectButton = ISButton:new(0, 0, 92, BUTTON_HGT, getText("UI_servers_button_connect"), self, MultiplayerUI.onPressButtonOnAccountList);
            connectButton.internal = "CONNECT";
            connectButton:initialise();
            connectButton:instantiate();
            connectButton.server = server
            connectButton.account = account
            connectButton.font = UIFont.Small;
            connectButton:enableAcceptColor()
            connectButton:setWidthToTitle();
            self.accountList:addChild(connectButton);

            self.accountList:addItem(account:getUserName(), {type="account", first=isFirst, server=server, account=account, deleteButton=deleteButton, editButton=editButton, connectButton=connectButton});
            isFirst = false
        end
        self.accountList:addItem("", {type="new_account", first=isFirst, server=server});
    end

    self.accountList:addItem("", {type="new_server"});
end

function MultiplayerUI:requestServerList()
    if MultiplayerUI.startRefreshTime ~= nil and getTimestamp() - MultiplayerUI.startRefreshTime <= 60 then
        return
    end
    MultiplayerUI.serverCount = steamRequestInternetServersCount()
    MultiplayerUI.received = 0
    MultiplayerUI.startRefreshTime = getTimestamp()
    MultiplayerUI.refreshTime = getTimestamp()
    self.internetList:clear();

    if not isPublicServerListAllowed() then return; end
    if getSteamModeActive() then
        steamRequestInternetServersList()
        return
    end
    local servers = getPublicServersList();
    if servers == nil or #servers == 0 then
        return;
    end
    for i, k in ipairs(servers) do
        self:analyzeServerData(k)
    end
end

MultiplayerUI.done = false;
function MultiplayerUI:analyzeServerData(server)
    server:setFeatured(self:getServerFeatured(server) ~= nil);

    if not server:isPublic() then
        return;
    end

    -- RJ: there's some people having and display huge players number with 0 max, gonna ignore them
    if tonumber(server:getPlayers()) > tonumber(server:getMaxPlayers()) then
        return;
    end

    table.insert(self.serverList, server);

    if not self.selectedInternetServer then
       MultiplayerUI:selectInternetServer(server)
    end

    self.listChanged = true; -- this is so we can fire the sort if needed
end

function MultiplayerUI:serverInfoBluePanelHeight()
    return FONT_HGT_LARGE * 2 + FONT_HGT_MEDIUM * 2 + FONT_HGT_SMALL + self.rightPanelFavouritesButton.height
end

function MultiplayerUI:onResolutionChange(oldw, oldh, neww, newh)
	self:setWidth(neww)
	self:setHeight(newh)
    self:setX(0)
    self:setY(0)

    local rightPanelWidth = 481
    local rightPanelLeftSpace = 7

    if self.width < 1600 then
        self.tabs:setX(math.max(10, self.width*0.1648))
        self.tabs:setY(math.max(10, self.height*0.1648) - self.tabs.tabHeight)
        self.tabs:setWidth(self.width - math.max(10, self.width*0.1648)*2)
        self.tabs:setHeight(self.height - math.max(10, self.height*0.1648)*2)

        self.backButton:setX(self.tabs:getX())
        self.backButton:setY(self.tabs:getBottom() + FONT_HGT_SMALL)

        self.refreshBtn:setX(self.tabs:getRight() - self.refreshBtn:getWidth())
        self.refreshBtn:setY(self.backButton:getY())

        self.connectBtn:setX(self.refreshBtn:getX() - self.connectBtn:getWidth() - 5)
        self.connectBtn:setY(self.refreshBtn:getY())

        self.accountList:setX(8)
        self.accountList:setY(8)
        self.accountList:setWidth(self.tabs:getWidth() - 16)
        self.accountList:setHeight(self.tabs:getHeight() - self.tabs.tabHeight - 16)

        self.internetList:setX(8)
        self.internetList:setY(INTERNET_LIST_Y)
        self.internetList:setWidth(self.tabs:getWidth() - 16)
        self.internetList:setHeight(self.tabs:getHeight() - self.tabs.tabHeight - 8 - INTERNET_LIST_Y)

        self.filter:setX(self.internetList:getX())
        self.filter:setY(14)
        self.filter:setWidth(self.tabs:getWidth() + 326 - 840)
        self.filter:setHeight(ENTRY_HGT)

        self.filterVersion:setX(self.tabs:getWidth() - 39)
        self.filterVersion:setY(23)

        self.filterFullServer:setX(self.tabs:getWidth() - 139)
        self.filterFullServer:setY(23)

        self.filterEmptyServer:setX(self.tabs:getWidth() - 214)
        self.filterEmptyServer:setY(23)

        self.filterPwdProtected:setX(self.tabs:getWidth() - 279)
        self.filterPwdProtected:setY(23)

        self.filterWhitelistServer:setX(self.tabs:getWidth() - 344)
        self.filterWhitelistServer:setY(23)

        self.filterModdedServer:setX(self.tabs:getWidth() - 410)
        self.filterModdedServer:setY(23)

        self.rightPanel:setVisible(false)
        self.rightPanelInternal:setVisible(false)
        self.serverDescription:setVisible(false)
        self.rightPanelFavouritesButton:setVisible(false)
    else
        self.tabs:setX(math.max(10, self.width*0.1648))
        self.tabs:setY(math.max(10, self.height*0.1648) - self.tabs.tabHeight)
        self.tabs:setWidth(self.width - math.max(10, self.width*0.1648)*2 - rightPanelWidth - rightPanelLeftSpace)
        self.tabs:setHeight(self.height - math.max(10, self.height*0.1648)*2)
        --self.tabs:setHeight(32)

        self.backButton:setX(self.tabs:getX())
        self.backButton:setY(self.tabs:getBottom() + FONT_HGT_SMALL)

        self.refreshBtn:setX(self.tabs:getRight() - self.refreshBtn:getWidth())
        self.refreshBtn:setY(self.backButton:getY())

        self.connectBtn:setX(self.refreshBtn:getX() - self.connectBtn:getWidth() - 5)
        self.connectBtn:setY(self.refreshBtn:getY())

        self.accountList:setX(8)
        self.accountList:setY(8)
        self.accountList:setWidth(self.tabs:getWidth() - 16)
        self.accountList:setHeight(self.tabs:getHeight() - self.tabs.tabHeight - 16)

        self.internetList:setX(8)
        self.internetList:setY(INTERNET_LIST_Y)
        self.internetList:setWidth(self.tabs:getWidth() - 16)
        self.internetList:setHeight(self.tabs:getHeight() - self.tabs.tabHeight - 8 - INTERNET_LIST_Y)

        self.filter:setX(self.internetList:getX())
        self.filter:setY(14)
        self.filter:setWidth(self.tabs:getWidth() + 326 - 840)
        self.filter:setHeight(ENTRY_HGT)

        self.filterVersion:setX(self.tabs:getWidth() - 39)
        self.filterVersion:setY(23)

        self.filterFullServer:setX(self.tabs:getWidth() - 139)
        self.filterFullServer:setY(23)

        self.filterEmptyServer:setX(self.tabs:getWidth() - 214)
        self.filterEmptyServer:setY(23)

        self.filterPwdProtected:setX(self.tabs:getWidth() - 279)
        self.filterPwdProtected:setY(23)

        self.filterWhitelistServer:setX(self.tabs:getWidth() - 344)
        self.filterWhitelistServer:setY(23)

        self.filterModdedServer:setX(self.tabs:getWidth() - 410)
        self.filterModdedServer:setY(23)

        self.rightPanel:setVisible(true)
        self.rightPanel:setX(self.width - math.max(10, self.width*0.1648) - rightPanelWidth)
        self.rightPanel:setY(math.max(10, self.height*0.1648))
        self.rightPanel:setWidth(rightPanelWidth)
        self.rightPanel:setHeight(self.tabs.height - self.tabs.tabHeight)
        self.rightPanelInternal:setVisible(true)
        self.rightPanelInternal:setX(self.rightPanel:getX() + 8)
        self.rightPanelInternal:setY(self.rightPanel:getY() + 8)
        self.rightPanelInternal:setWidth(self.rightPanel:getWidth() - 16)
        self.rightPanelInternal:setHeight(self.rightPanel:getHeight() - 16)

        local bannerHeight = self.rightPanelInternal:getWidth() * 251 / 954
        local serverInfoBluePanelHeight = self:serverInfoBluePanelHeight()

        self.rightPanelFavouritesButton:setVisible(true)
        self.rightPanelFavouritesButton:setX(self.rightPanelInternal:getX() + 19)
        self.rightPanelFavouritesButton:setY(self.rightPanelInternal:getY() + bannerHeight + serverInfoBluePanelHeight - self.rightPanelFavouritesButton.height)
        self.rightPanelFavouritesButton:setHeight(FONT_HGT_SMALL)

        self.serverDescription:setVisible(true)
        self.serverDescription:setX(self.rightPanelInternal:getX() + 1)
        self.serverDescription:setY(self.rightPanelInternal:getY() + bannerHeight + serverInfoBluePanelHeight)
        self.serverDescription:setWidth(self.rightPanelInternal:getWidth())
        self.serverDescription:setHeight(self.rightPanelInternal:getHeight() - bannerHeight - serverInfoBluePanelHeight)

        self.rightPanelFavouritesButton:setVisible(true)
    end
    if self.screenShading then
        self.screenShading:onResolutionChange(oldw, oldh, neww, newh)
    end
    if self.modal and self.modal.onResolutionChange then
        self.modal:onResolutionChange(oldw, oldh, neww, newh)
    end
end

function MultiplayerUI:prerender()
    -- Bottom Background
    local timeFromLastUpdate = getTimestamp() - (MultiplayerUI.startRefreshTime or 0)
    local refreshTime = 60;
    if getDebug() then
        refreshTime = 5;
    end
    if timeFromLastUpdate > refreshTime then
        self.refreshBtn:setTitle(getText("UI_servers_refresh"))
        self.refreshBtn:setEnable(true)
    else
        self.refreshBtn:setTitle(string.format(getText("UI_servers_refresh_timer"), refreshTime - timeFromLastUpdate))
        self.refreshBtn:setEnable(false)
    end
end

function MultiplayerUI:updateButtons()
    self.connectBtn:setEnable(self.selectedInternetServer ~= nil);
end

function MultiplayerUI:render()
    local bannerHeight = self.rightPanelInternal:getWidth() * 251 / 954
    local serverInfoBluePanelHeight = self:serverInfoBluePanelHeight()
    local serverIconUICircleSize = bannerHeight * 105 / 120
    local bannerRight = self.rightPanelInternal:getX()+self.rightPanelInternal:getWidth()
    if self.rightPanel:isVisible() then
        -- Banner
        self:drawTextureScaled(self.default_banner, self.rightPanelInternal:getX()+1, self.rightPanelInternal:getY()+1, self.rightPanelInternal:getWidth()-1, bannerHeight, 1, 1, 1, 1);
        self:drawRect(self.rightPanelInternal:getX()+1, self.rightPanelInternal:getY()+bannerHeight, self.rightPanelInternal:getWidth()-1, serverInfoBluePanelHeight, self.serverInfoBluePanelColor.a, self.serverInfoBluePanelColor.r, self.serverInfoBluePanelColor.g, self.serverInfoBluePanelColor.b);
        self:setStencilCircle(self.rightPanelInternal:getX()+18, self.rightPanelInternal:getY()+bannerHeight-17, serverIconUICircleSize-6, serverIconUICircleSize-6)
        self:drawTextureScaled(self.ui_details_icon, self.rightPanelInternal:getX()+18, self.rightPanelInternal:getY()+bannerHeight-17, serverIconUICircleSize-6, serverIconUICircleSize-6, 1, 1, 1, 1);
        self:clearStencilRect()
        self:drawTextureScaled(self.ui_circle, self.rightPanelInternal:getX()+15, self.rightPanelInternal:getY()+bannerHeight-20, serverIconUICircleSize, serverIconUICircleSize, 1, 1, 1, 1);
        -- NAME
        local textY = self.rightPanelInternal:getY()+bannerHeight + 6
        self:drawText(self.selectedInternetServerName1, self.rightPanelInternal:getX()+128, textY, 1, 1, 1, 1, UIFont.Large);
        self:drawText(self.selectedInternetServerName2, self.rightPanelInternal:getX()+128, textY + FONT_HGT_LARGE, 1, 1, 1, 1, UIFont.Large);
        textY = textY + FONT_HGT_LARGE * 2
        -- IP
        local textX = self.rightPanelInternal:getX() + 128
        local textWid = getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_IP")) + 8
        self:drawText(getText("UI_servers_IP"), textX, textY, self.serverInfoBlueTextColor.r, self.serverInfoBlueTextColor.g, self.serverInfoBlueTextColor.b, self.serverInfoBlueTextColor.a, UIFont.Medium);
        if self.selectedInternetServer then
            self:setStencilRect(self.rightPanelInternal:getX()+149, textY, 110, FONT_HGT_MEDIUM)
            self:drawText(self.selectedInternetServer:getIp(), textX + textWid, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
            self:clearStencilRect()
        else
            self:drawText("-", textX + textWid, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        end
        -- PORT
        textX = self.rightPanelInternal:getX()+260
        textWid = getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_Port")) + 8
        textY = self.rightPanelInternal:getY()+bannerHeight + 6 + FONT_HGT_LARGE * 2
        self:drawText(getText("UI_servers_Port"), textX, textY, self.serverInfoBlueTextColor.r, self.serverInfoBlueTextColor.g, self.serverInfoBlueTextColor.b, self.serverInfoBlueTextColor.a, UIFont.Medium);
        if self.selectedInternetServer then
            self:drawText(tostring(self.selectedInternetServer:getPort()), textX + textWid, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        else
            self:drawText("-", textX + textWid, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        end
        textY = textY + FONT_HGT_MEDIUM
        -- MAP
        textX = self.rightPanelInternal:getX()+128
        textWid = getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_Map")) + 8
        self:drawText(getText("UI_servers_Map"), textX, textY, self.serverInfoBlueTextColor.r, self.serverInfoBlueTextColor.g, self.serverInfoBlueTextColor.b, self.serverInfoBlueTextColor.a, UIFont.Medium);
        if self.selectedInternetServer then
            self:setStencilRect(textX + textWid, textY, 230, FONT_HGT_MEDIUM)
            self:drawText(self.selectedInternetServer:getMapName(), textX + textWid, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
            self:clearStencilRect()
        else
            self:drawText("-", textX + textWid, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        end
        -- Players
        textY = self.rightPanelInternal:getY() + bannerHeight + 6 + FONT_HGT_LARGE * 2
        self:drawTextureScaled(self.ui_details_players, bannerRight - 60, textY + (FONT_HGT_SMALL - 15) / 2, 18, 15, 1, 1, 1, 1);
        if self.selectedInternetServer and self.selectedInternetServer:getPlayers() and self.selectedInternetServer:getMaxPlayers() then
            self:drawText(self.selectedInternetServer:getPlayers().."/"..self.selectedInternetServer:getMaxPlayers(), bannerRight - 38, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        else
            self:drawText("-/-", bannerRight - 38, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        end
        textY = textY + FONT_HGT_SMALL
        -- Ping
        self:drawTextureScaled(self.ui_details_ping, bannerRight - 60, textY + (FONT_HGT_SMALL - 15) / 2, 18, 15, 1, 1, 1, 1);
        if self.selectedInternetServer and self.selectedInternetServer:getPing() then
            self:drawText(self.selectedInternetServer:getPing(), bannerRight - 38, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        else
            self:drawText("-", bannerRight - 38, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        end
        -- Version
        textY = self.rightPanelInternal:getY() + bannerHeight + 6 + FONT_HGT_LARGE * 2 + FONT_HGT_MEDIUM * 2
        if self.selectedInternetServer and self.selectedInternetServer:getVersion() then
            self:drawText("V "..self.selectedInternetServer:getVersion(), bannerRight - 220, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        else
            self:drawText("V -", bannerRight - 220, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        end
        -- Last update
        if self.selectedInternetServer then
            self:drawText(getText("UI_servers_last_update") .. tostring(self.selectedInternetServer:getLastUpdate()) .. getText("UI_servers_minutes_ago"), bannerRight - 150, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        else
            self:drawText(getText("UI_servers_last_update") .. "-" .. getText("UI_servers_minutes_ago"), bannerRight - 150, textY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        end

        -- numbers of server
        if self.tabs:getActiveViewIndex() == 2 then
            self:drawTextRight(getText("UI_servers_serverNb", tostring(#self.internetList.items), tostring(#self.serverList)), self.refreshBtn:getX() + self.refreshBtn:getWidth(), self.refreshBtn:getY() - FONT_HGT_SMALL, 1,1,1,1);
        end
        -- Button
        self:updateButtons();
        self:updateListSort();
        self.rightPanelFavouritesButton:prerender()
        self.rightPanelFavouritesButton:render()
    end
    --
    if self.tabs:getActiveViewIndex() == 2 then
        local leftPanelRightBorder = self.tabs:getX() + self.tabs:getWidth()
        local leftPanelTopBorder = self.tabs:getY() + self.tabs.tabHeight
        self:drawTextureScaled(self.ui_filters_allversions, leftPanelRightBorder - 99, leftPanelTopBorder + 19, 52, 24, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_separator_filter, leftPanelRightBorder - 111, leftPanelTopBorder + 11, 1, 39, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_filters_haveplayers, leftPanelRightBorder - 174, leftPanelTopBorder + 19, 28, 24, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_separator_filter, leftPanelRightBorder - 187, leftPanelTopBorder + 11, 1, 39, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_filters_4, leftPanelRightBorder - 239, leftPanelTopBorder + 19, 17, 24, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_separator_filter, leftPanelRightBorder - 252, leftPanelTopBorder + 11, 1, 39, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_filters_closed, leftPanelRightBorder - 304, leftPanelTopBorder + 19, 17, 24, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_separator_filter, leftPanelRightBorder - 316, leftPanelTopBorder + 11, 1, 39, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_filters_feature, leftPanelRightBorder - 370, leftPanelTopBorder + 19, 19, 24, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_separator_filter, leftPanelRightBorder - 382, leftPanelTopBorder + 11, 1, 39, 1, 1, 1, 1);
        self:drawTextureScaled(self.ui_filters_mods, leftPanelRightBorder - 442, leftPanelTopBorder + 19, 24, 24, 1, 1, 1, 1);
        if MultiplayerUI.serverCount then
            local progressbarWidth = 200
            local progressbarHeight = 22
            local progressbarX = self.tabs:getX() + (self.tabs:getWidth() - progressbarWidth) / 2
            --local progressbarY = self.tabs:getY() + self.tabs.tabHeight + self.tabs:getHeight() + 7
            local progressbarY = self.backButton:getY();
            self:drawProgressBar(progressbarX, progressbarY, progressbarWidth, progressbarHeight, MultiplayerUI.received / MultiplayerUI.serverCount, self.progressBarColor)
            self:drawRectBorder(progressbarX, progressbarY, progressbarWidth, progressbarHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
            if getTimestamp() - MultiplayerUI.refreshTime > 3 then
                MultiplayerUI.serverCount = nil
            end
        end
    end

    self.connectBtn:setVisible(self.tabs:getActiveViewIndex() == 2)

    self:renderSortButtons();
end

-- sort the list of server every X ticks, if the list has changed
function MultiplayerUI:updateListSort()
    if not self.listChanged then return; end
    if self.filterUpdateTimer > 0 then
        self.filterUpdateTimer = self.filterUpdateTimer - 1;
    end
    if self.filterUpdateTimer <= 0 then
        self:sortInternetList();
        self.filterUpdateTimer = self.sortListUpdateTicks;
        self.listChanged = false;
    end
end

function MultiplayerUI:sortInternetList()
    -- RJ: done this in java as it's wayyyy faster for big list sorting
    -- we gonna send a list of the filters we have, so java will filter it, no need to keep a full list for the render
    local filterTable = {};
    filterTable["version"] = self.filterVersion.selected[1];
    filterTable["empty"] = self.filterEmptyServer.selected[1];
    filterTable["whitelist"] = self.filterWhitelistServer.selected[1];
    filterTable["password"] = self.filterPwdProtected.selected[1];
    filterTable["full"] = self.filterFullServer.selected[1];
    filterTable["modded"] = self.filterModdedServer.selected[1];
    filterTable["name"] = self.filter:getInternalText();

    local newList = sortBrowserList(self.serverList, self.sortType, self.sortDown, filterTable);
    self.internetList:clear();
    for i,v in pairs(newList) do
        self.internetList:addItem(i, v);
    end
end

-- render the sort button on top of the list
function MultiplayerUI:renderSortButtons()
    -- hide buttons if nothing in the list
    self.buttonSortName:setVisible(self.serversInList);
    self.buttonSortPlayer:setVisible(self.serversInList);
    self.buttonSortPing:setVisible(self.serversInList);

    self.buttonSortName.iconRight = nil;
    self.buttonSortPlayer.iconRight = nil;
    self.buttonSortPing.iconRight = nil;

    local icon = self.arrowUp;
    if self.sortDown then
        icon = self.arrowDown;
    end

    if self.sortType == "name" then
        self.buttonSortName.iconRight = icon;
    end
    if self.sortType == "player" then
        self.buttonSortPlayer.iconRight = icon;
    end
    if self.sortType == "ping" then
        self.buttonSortPing.iconRight = icon;
    end

    -- ensure our buttons have the correct size (going basically from separators to separators)
    local listX = self.internetList:getX();
    self.buttonSortName:setX(listX);
    self.buttonSortName:setWidth(PLAYERS_COUNT_SEPARATOR - self.buttonSortName:getX() + listX + (SEPARATOR_WIDTH / 1) - 1);
    self.buttonSortName:setY(self.internetList:getY() - INTERNET_HEADER_HGT);
    self.buttonSortName:setHeight(INTERNET_HEADER_HGT);

    self.buttonSortPlayer:setX(self.buttonSortName:getX() + self.buttonSortName:getWidth());
    self.buttonSortPlayer:setWidth(PING_SEPARATOR - PLAYERS_COUNT_SEPARATOR);
    self.buttonSortPlayer:setY(self.buttonSortName:getY());
    self.buttonSortPlayer:setHeight(self.buttonSortName:getHeight());

    self.buttonSortPing:setX(self.buttonSortPlayer:getX() + self.buttonSortPlayer:getWidth());
    self.buttonSortPing:setWidth(self.internetList:getWidth() - PING_SEPARATOR);
    self.buttonSortPing:setY(self.buttonSortName:getY());
    self.buttonSortPing:setHeight(self.buttonSortName:getHeight());
end

function MultiplayerUI:onMouseDown_Tabs(x, y)
    self.parent:onResolutionChange(0, 0, self.parent.width, self.parent.height)
end

function MultiplayerUI:onOptionMouseDown(button, x, y)
	if button.internal == "BACK" then
        if getSteamModeActive() then
            steamReleaseInternetServersRequest()
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
	if button.internal == "FAVOURITES" and self.selectedInternetServer then
        if self.selectedInternetServerFeatured then
            self.modal = ISModalDialog:new(0,0, 250, 150,  getText("UI_servers_remove_server"), true, self, MultiplayerUI.onDeleteServer, nil, self.selectedInternetServer);
            self.modal:initialise()
            self.modal:addToUIManager()
            self.screenShading:setVisible(true)
            self.screenShading:setAlwaysOnTop(true)
            self.modal:setAlwaysOnTop(true)
        else
            if self:checkServerIsPwdProtected(self.selectedInternetServer, false, true) then
                return;
            end
            addServerToAccountList(self.selectedInternetServer)
            self:refreshList()
            local item = self:getServerFeatured(self.selectedInternetServer)
            self:onSelectAccount(item)
        end
	end
    if button.internal == "REFRESH" then
        self:requestServerList();
    end
    if button.internal == "CONNECTFROMBROWSER" then
        self:connectFromBrowser();
    end
end

function MultiplayerUI:connectFromBrowser(server)
    if not server then
        server = self.selectedInternetServer;
    end
    -- server is in our favorite, show the select account UI
    if self.selectedInternetServerFeatured then
        if self:checkServerIsPwdProtected(server, true, false) then
            return;
        end
        self.modal = ISMPSelectAccount:new(self, self.selectedInternetServer);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:setAlwaysOnTop(true)
        self.modal.connectAfter = true;
        self.modal:setAlwaysOnTop(true)
    elseif server then
        if self:checkServerIsPwdProtected(server, true, false) then
            return;
        end
        -- add the server to our favourite
        self.modal = ISMPEditAccount:new(self, server, nil);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.modal.ui = self;
        self.screenShading:setVisible(true)
        self.screenShading:setAlwaysOnTop(true)
        self.modal.connectAfter = true;
        self.modal:setAlwaysOnTop(true)
    end
end

-- when we click connect, if a server require a password and we didn't saved it, open the UI to enter it
function MultiplayerUI:checkServerIsPwdProtected(server, connectAfter, addToFavAfter)
    local favServer = self:getServerFeatured(server);

    if favServer then
        favServer = favServer.server;
    end

    -- we check that the selected server isn't password protected
    if not self.selectedInternetServer:isPasswordProtected() and (not server or server:getServerPassword()) then
        return false;
    end

    -- we never saved this server or we didn't add password
    -- we also check the server passed in param as it could be one we just added a password to
    local favPwd = (favServer ~= nil and favServer:getServerPassword() ~= nil and favServer:getServerPassword() ~= "");
    local passedPwd = (server ~= nil and server:getServerPassword() ~= nil and server:getServerPassword() ~= "");
    if passedPwd then
        favPwd = true;
    end
    if not favPwd and not passedPwd then
        self.modal = ISMPEnterServerPwd:new(self, self.selectedInternetServer);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:bringToTop()
        self.modal.connectAfter = connectAfter;
        self.modal:setAddToFavAfter(addToFavAfter);
        self.modal:bringToTop()
        return true;
    end
end

function MultiplayerUI.ServerPinged(ip, users)
end

function MultiplayerUI.OnSteamServerResponded(serverIndex)
    if MultiplayerUI.serverCount == 0 then
        MultiplayerUI.serverCount = steamRequestInternetServersCount()
    end
    if  serverIndex > MultiplayerUI.received then
        MultiplayerUI.received = serverIndex
    end
    MultiplayerUI.refreshTime = getTimestamp()
    local server = steamGetInternetServerDetails(serverIndex)
    if server and MultiplayerUI.instance then
        server:setResponded(true)
        MultiplayerUI.instance:analyzeServerData(server)
    end
end

function MultiplayerUI.OnSteamServerResponded2(host, port, server2)
    local self = MultiplayerUI.instance
    for i,v in ipairs(self.accountList.items) do
        if v.item.type == "server" and v.item.server:getIp2() == host and v.item.server:getPort() == port then
            v.item.server:setResponded(true)
            v.item.server:setPing(server2:getPing())
            v.item.server:setPlayers(server2:getPlayers())
            v.item.server:setMaxPlayers(server2:getMaxPlayers())
            v.item.server:setMods(server2:getMods())
            v.item.server:setPasswordProtected(server2:isPasswordProtected())
            updateServerToAccountList(v.item.server)
            if v.item.server == self.selectedInternetServer then
                self:selectInternetServer(v.item.server)
            end
        end;
    end

    if self.selectedInternetServer and self.selectedInternetServer:getIp() == server2:getIp() and self.selectedInternetServer:getPort() == server2:getPort() then
        self.selectedInternetServer:setResponded(true)
        self.selectedInternetServer:setPing(server2:getPing())
        self.selectedInternetServer:setPlayers(server2:getPlayers())
        self.selectedInternetServer:setMaxPlayers(server2:getMaxPlayers())
        self.selectedInternetServer:setMods(server2:getMods())
        self.selectedInternetServer:setPasswordProtected(server2:isPasswordProtected())
        self:selectInternetServer(self.selectedInternetServer)
    end

    steamRequestServerRules(host, port)
end

function MultiplayerUI.OnSteamServerFailedToRespond2(host, port)
    local self = MultiplayerUI.instance
    for i,v in ipairs(self.accountList.items) do
        if v.item.type == "server" and v.item.server:getIp2() == host and v.item.server:getPort() == port then
            v.item.server:setResponded(false)
        end;
    end
end

function MultiplayerUI.OnSteamRulesRefreshComplete(host, port, rules)
    local self = MultiplayerUI.instance
    for i,v in ipairs(self.accountList.items) do
        if v.item.type == "server" and v.item.server:getIp2() == host and v.item.server:getPort() == port then
            if rules.description then
                v.item.server:setDescription(rules.description)
            end
            if rules.version then
                v.item.server:setVersion(rules.version)
            end
            v.item.server:setOpen(rules.open == "1")
            if rules.mods then
                v.item.server:setMods(rules.mods)
            end
            updateServerToAccountList(v.item.server)
            if v.item.server == self.selectedInternetServer then
                self:selectInternetServer(v.item.server)
            end
        end;
    end


    if self.selectedInternetServer and self.selectedInternetServer:getIp2() == host and self.selectedInternetServer:getPort() == port then
        if rules.description then
            self.selectedInternetServer:setDescription(rules.description)
        end
        if rules.version then
            self.selectedInternetServer:setVersion(rules.version)
        end
        self.selectedInternetServer:setOpen(rules.open == "1")
        if rules.mods then
            self.selectedInternetServer:setMods(rules.mods)
        end
        self:selectInternetServer(self.selectedInternetServer)
    end
end

function MultiplayerUI.OnSteamRefreshInternetServers()
    steamReleaseInternetServersRequest()
end

function MultiplayerUI.onResetLua(reason)
    if reason == "ConnectedToServer" then
        reactivateJoypadAfterResetLua()
        local joypadData = JoypadState.getMainMenuJoypad()
        if joypadData then
            joypadData.focus = nil
            joypadData.lastfocus = nil
            JoypadState.forceActivate = joypadData.id
        end
        if DebugScenarios.instance ~= nil then
            MainScreen.instance:removeChild(DebugScenarios.instance)
            DebugScenarios.instance = nil
        end
        MainScreen.instance.bottomPanel:setVisible(false);
    end
end

function MultiplayerUI:new (x, y, width, height)
	local o = {}
	o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.created = false
	o.x = x;
	o.y = y;
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o.ui_details_icon = getTexture("media/ui/zomboidDefaultMPIcon.png");
    o.ui_icon_bg = getTexture("media/ui/MP/mp_ui_servericonbg.png");
	o.ui_details_ping = getTexture("media/ui/MP/mp_ui_details_ping.png");
	o.ui_details_players = getTexture("media/ui/MP/mp_ui_details_players.png");
	o.ui_circle = getTexture("media/ui/MP/mp_ui_circle.png");
	o.default_banner = getTexture("media/ui/MP/mp_ui_default_banner.png");
	o.default_bottom_background = getTexture("media/ui/MP/mp_ui_bottom_background.png");
	o.ui_ping = getTexture("media/ui/MP/mp_ui_ping.png");
	o.ui_players = getTexture("media/ui/MP/mp_ui_players.png");
	o.ui_separator = getTexture("media/ui/MP/mp_ui_separator.png");
	o.ui_online = getTexture("media/ui/MP/mp_ui_online.png");
	o.ui_offline = getTexture("media/ui/MP/mp_ui_offline.png");
	o.ui_subitem_first = getTexture("media/ui/MP/mp_ui_subitem_first.png");
	o.ui_subitem_other = getTexture("media/ui/MP/mp_ui_subitem_other.png");
	o.ui_add_icon = getTexture("media/ui/MP/mp_ui_add_icon.png");
    o.ui_feature = getTexture("media/ui/MP/mp_ui_feature.png");
    o.ui_feature_enabled = getTexture("media/ui/MP/mp_ui_feature_enabled.png");
    o.ui_open = getTexture("media/ui/MP/mp_ui_open.png");
    o.ui_closed = getTexture("media/ui/MP/mp_ui_closed.png");
    o.ui_filters_allversions = getTexture("media/ui/MP/mp_ui_filters_allversions.png");
    o.ui_filters_haveplayers = getTexture("media/ui/MP/mp_ui_filters_haveplayers.png");
    o.ui_filters_4 = getTexture("media/ui/MP/mp_ui_filters_4.png");
    o.ui_filters_closed = getTexture("media/ui/MP/mp_ui_filters_closed.png");
    o.ui_filters_feature = getTexture("media/ui/MP/mp_ui_filters_feature.png");
    o.ui_filters_mods = getTexture("media/ui/MP/mp_ui_filters_mods.png");
    o.ui_filters_mods_off = getTexture("media/ui/MP/mp_ui_filters_mods_off.png");
    o.ui_separator_filter = getTexture("media/ui/MP/mp_ui_separator_filter.png");
	o.serverInfoBluePanelColor = {r=0.05, g=0.15, b=0.25, a=1};
	o.serverInfoBlueTextColor = {r=0.45, g=0.57, b=0.64, a=1};
    o.serverInfoGrayTextColor = {r=0.8, g=0.8, b=0.8, a=1};
    o.serverListSelected = {r=0.61, g=0.23, b=0.11, a=0.5};
    o.serverListItem = {r=0.30, g=0.30, b=0.30, a=0.5};
    o.progressBarColor = {r=0.0, g=0.8, b=0.0, a=1};
    o.rightPanelMargin = 5;
    o.selectedInternetServerFeatured = false
    o.selectedInternetServer = nil
    o.selectedInternetServerName1 = ""
    o.selectedInternetServerName2 = ""
    o.serversInList = false;
    o.arrowUp = getTexture("media/ui/ArrowUp.png")
    o.arrowDown = getTexture("media/ui/ArrowDown.png")
    o.listChanged = false; -- this is so we can fire up the sort if needed
    o.sortListUpdateTicks = 100; -- how much ticks per update the list
    o.filterUpdateTimer = 10; -- as we update the list when we receive a server, we don't want to do it too often
    o.sortType = "player"; -- can be name, players or ping
    o.sortDown = true; -- if false we sort in ascending
    o.serverList = {};
    MultiplayerUI.instance = o;
	return o
end

Events.ServerPinged.Add(MultiplayerUI.ServerPinged);
Events.OnResetLua.Add(MultiplayerUI.onResetLua)
if getSteamModeActive() then
    LuaEventManager.AddEvent("OnSteamServerResponded")
    LuaEventManager.AddEvent("OnSteamServerResponded2")
    LuaEventManager.AddEvent("OnSteamServerFailedToRespond2")
    LuaEventManager.AddEvent("OnSteamRulesRefreshComplete")
    LuaEventManager.AddEvent("OnSteamRefreshInternetServers")
    Events.OnSteamServerResponded.Add(MultiplayerUI.OnSteamServerResponded)
    Events.OnSteamServerResponded2.Add(MultiplayerUI.OnSteamServerResponded2)
    Events.OnSteamServerFailedToRespond2.Add(MultiplayerUI.OnSteamServerFailedToRespond2)
    Events.OnSteamRulesRefreshComplete.Add(MultiplayerUI.OnSteamRulesRefreshComplete)
    Events.OnSteamRefreshInternetServers.Add(MultiplayerUI.OnSteamRefreshInternetServers)
end
