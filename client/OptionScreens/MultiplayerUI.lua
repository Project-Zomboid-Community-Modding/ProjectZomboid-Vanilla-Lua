require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISPanelJoypad"
require "ISUI/ISRichTextPanel"
require "ISUI/ISMPEditServer"
require "ISUI/ISScrollingListBox"

MultiplayerUI = ISPanel:derive("MultiplayerUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_NEW_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_NEW_MEDIUM = getTextManager():getFontHeight(UIFont.NewMedium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local FILTER_HGT = FONT_HGT_MEDIUM + 6
local TAB_HEIGHT = FONT_HGT_LARGE + 6
local UI_BORDER_SPACING = 10
local JOYPAD_TEX_SIZE = 32
local TICKBOX_SPACING = FILTER_HGT*2 + UI_BORDER_SPACING*3 + 1
local ACCOUNT_LIST_ITEM_HEIGHT = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM + FONT_HGT_SMALL
local SCROLL_BAR_WIDTH = 13

local RIGHT_PANEL_WIDTH = 450+(getCore():getOptionFontSizeReal()*50)
local PING_WIDTH = 0
local PLAYER_WIDTH = 0
local SERVER_INFO_WIDTH = 0;

local FILTER_SCALE = FILTER_HGT * 0.5

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
    self.screenShading.width = getCore():getScreenWidth()
    self.screenShading.height = getCore():getScreenHeight()

    local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_back"))
    self.backButton = ISButton:new(0, 0, btnWidth, BUTTON_HGT, getText("UI_servers_back"), self, MultiplayerUI.onOptionMouseDown);
    self.backButton.internal = "BACK";
    self.backButton:initialise();
    self.backButton:instantiate();
    --self.backButton.font = UIFont.Large;
    self.backButton:enableCancelColor()
    self:addChild(self.backButton);

    self.showIPAddressesTickBox = ISTickBox:new(0, 0, BUTTON_HGT + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_streamerMode")), BUTTON_HGT, "", self, self.onToggleShowIPs);
    self.showIPAddressesTickBox.tooltip = getText("UI_servers_streamerMode_tooltip")
    self.showIPAddressesTickBox:initialise();
    self.showIPAddressesTickBox:instantiate();
    self.showIPAddressesTickBox.choicesColor = {r=1, g=1, b=1, a=1}
    self.showIPAddressesTickBox:addOption(getText("UI_servers_streamerMode"))
    self.showIPAddressesTickBox:setSelected(1, getCore():getOptionStreamerMode())
    self:addChild(self.showIPAddressesTickBox);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_refresh"))
    self.refreshBtn = ISButton:new(0, 0, btnWidth, BUTTON_HGT, getText("UI_servers_refresh"), self, MultiplayerUI.onOptionMouseDown);
    self.refreshBtn.internal = "REFRESH";
    self.refreshBtn:initialise();
    self.refreshBtn:instantiate();
    self:addChild(self.refreshBtn);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_connect"))
    self.connectBtn = ISButton:new(0, 0, btnWidth, BUTTON_HGT, getText("UI_servers_connect"), self, MultiplayerUI.onOptionMouseDown);
    self.connectBtn.internal = "CONNECTFROMBROWSER";
    self.connectBtn:initialise();
    self.connectBtn:instantiate();
    self.connectBtn:enableAcceptColor();
    self:addChild(self.connectBtn);


    self.tabs = ISMPTabPanel:new(0, 0, 500, 32);
    self.tabs:initialise();
    self.tabs.tabPadX = UI_BORDER_SPACING
    self.tabs.tabHeight = TAB_HEIGHT
    self.tabs.tabWidth = TAB_HEIGHT + UI_BORDER_SPACING*2 + math.max(
        getTextManager():MeasureStringX(UIFont.Large, getText("UI_servers_serverlist")),
        getTextManager():MeasureStringX(UIFont.Large, getText("UI_servers_publicServer"))
    )
    self:addChild(self.tabs);

    self.leftFavoritesPanel = ISPanel:new(0, 0, 0, 0);
    self.leftFavoritesPanel:initialise();
    self.leftFavoritesPanel.borderColor = {r=0, g=0, b=0, a=0};
    self.leftFavoritesPanel.backgroundColor = {r=0, g=0, b=0, a=0};
    self.tabs:addView(getText("UI_servers_serverlist"), getTexture("media/ui/MP/mp_ui_star.png"), getTexture("media/ui/MP/mp_ui_star.png"), self.leftFavoritesPanel)

    self.leftInternetPanel = ISPanel:new(0, 0, 0, 0);
    self.leftInternetPanel:initialise();
    self.leftInternetPanel.borderColor = {r=0, g=0, b=0, a=0};
    self.leftInternetPanel.backgroundColor = {r=0, g=0, b=0, a=0};
    if isPublicServerListAllowed() then
        self.tabs:addView(getText("UI_servers_publicServer"), getTexture("media/ui/MP/mp_ui_internet.png"), getTexture("media/ui/MP/mp_ui_internet.png"), self.leftInternetPanel)
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

    btnWidth = btnPadding*2 + getTextManager():MeasureStringX(UIFont.Small, getText("UI_servers_remove_from_favourites"))
    self.rightPanelFavouritesButton = ISMPButton:new(0, 0, btnWidth, BUTTON_HGT, getText("UI_servers_remove_from_favourites"), self, MultiplayerUI.onOptionMouseDown);
    self.rightPanelFavouritesButton.internal = "FAVOURITES";
    self.rightPanelFavouritesButton:initialise();
    self.rightPanelFavouritesButton:instantiate();
    self.rightPanelFavouritesButton.font = UIFont.Small;
    self.rightPanelFavouritesButton.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.rightPanelFavouritesButton.backgroundColorMouseOver = {r=0.4, g=0.4, b=0.4, a=1.0};
    self.rightPanelFavouritesButton.borderColor = {r=1.0, g=1.0, b=1.0, a=1.0};
    self.rightPanelFavouritesButton.forcedHeightImage = FONT_HGT_SMALL
    self.rightPanelFavouritesButton.forcedWidthImage = FONT_HGT_SMALL
    self.rightPanelFavouritesButton:setImage(getTexture("media/ui/MP/mp_ui_star_outline.png"))
    self:addChild(self.rightPanelFavouritesButton);

    self.serverDescription = ISRichTextPanel:new(self.rightPanelMargin, 0, 300, 300);
    self.serverDescription:initialise();
    self:addChild(self.serverDescription);
    self.serverDescription.background = false;
    self.serverDescription.autosetheight = false;
    self.serverDescription:addScrollBars();
    self.serverDescription:paginate();
    self:addChild(self.serverDescription)
    self.serverDescription.backgroundColor = {r=0.0, g=0.0, b=0.0, a=0.0};
    self.serverDescription.render = function(self)
        self:setStencilRect(0,0,self:getWidth(),self:getHeight());
        ISRichTextPanel.render(self)
        self:clearStencilRect();
    end

    self.accountList = ISScrollingListBox:new(0, 0, 100, 100);
    self.accountList:initialise();
    self.accountList:instantiate();
    self.accountList.itemheight = ACCOUNT_LIST_ITEM_HEIGHT
    self.accountList.selected = 0;
    self.accountList.joypadParent = self;
    self.accountList.doDrawItem = self.drawAccountListItem;
    self.accountList:setOnMouseDownFunction(self, self.onSelectAccount)
    self.accountList.onMouseDoubleClick = MultiplayerUI.onDoubleClickAccount;
    --self.accountList.onRightMouseUp = ISRolesList.onRightMouse;
    self.accountList.drawBorder = true;
    self.accountList.useStencilForChildren = true
    self.accountList.parent = self;
    self.leftFavoritesPanel:addChild(self.accountList);

    self.filter = ISTextEntryBox:new("", 0, 0, 33, 33);
    self.filter.font = UIFont.Medium
    self.filter:initialise();
    self.filter:instantiate();
    self.filter.mpUI = self;
    self.filter.onTextChange = MultiplayerUI.onTextFilterChange;
    self.leftInternetPanel:addChild(self.filter);

    self.filterVersion = ISTickBox:new(59, 317, FILTER_HGT, FILTER_HGT, "", self, self.onChangeFilter);
    self.filterVersion.tooltip = getText("UI_servers_versionCheck")
    self.filterVersion:initialise();
    self.filterVersion:instantiate();
    self.filterVersion.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterVersion:addOption("")
    self.leftInternetPanel:addChild(self.filterVersion);

    self.filterEmptyServer = ISTickBox:new(59, 317, FILTER_HGT, FILTER_HGT, "", self, self.onChangeFilter);
    self.filterEmptyServer.tooltip = getText("UI_servers_showEmptyServer")
    self.filterEmptyServer:initialise();
    self.filterEmptyServer:instantiate();
    self.filterEmptyServer.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterEmptyServer:addOption("")
    self.filterEmptyServer:setSelected(1, true);
    self.leftInternetPanel:addChild(self.filterEmptyServer);

    self.filterWhitelistServer = ISTickBox:new(59, 317, FILTER_HGT, FILTER_HGT, "", self, self.onChangeFilter);
    self.filterWhitelistServer.tooltip = getText("UI_servers_showWhitelistServer")
    self.filterWhitelistServer:initialise();
    self.filterWhitelistServer:instantiate();
    self.filterWhitelistServer.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterWhitelistServer:addOption("")
    self.leftInternetPanel:addChild(self.filterWhitelistServer);

    self.filterPwdProtected = ISTickBox:new(59, 317, FILTER_HGT, FILTER_HGT, "", self, self.onChangeFilter);
    self.filterPwdProtected.tooltip = getText("UI_servers_showPwdProtectedServer")
    self.filterPwdProtected:initialise();
    self.filterPwdProtected:instantiate();
    self.filterPwdProtected.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterPwdProtected:addOption("")
    self.leftInternetPanel:addChild(self.filterPwdProtected);

    self.filterFullServer = ISTickBox:new(59, 317, FILTER_HGT, FILTER_HGT, "", self, self.onChangeFilter);
    self.filterFullServer.tooltip = getText("UI_servers_showFullServer")
    self.filterFullServer:initialise();
    self.filterFullServer:instantiate();
    self.filterFullServer.choicesColor = {r=1, g=1, b=1, a=1}
    self.filterFullServer:addOption("")
    self.filterFullServer:setSelected(1, true);
    self.leftInternetPanel:addChild(self.filterFullServer);

    self.filterModdedServer = ISTickBox:new(59, 317, FILTER_HGT, FILTER_HGT, "", self, self.onChangeFilter);
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
    self.internetList.itemheight = ACCOUNT_LIST_ITEM_HEIGHT
    self.internetList.selected = 0;
    self.internetList.joypadParent = self;
    self.internetList.doDrawItem = self.drawInternetListItem;
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
    for i, k in ipairs(self.serverList) do
        self.serverList[i] = nil;
    end
    self:refreshList();

--    self.tabs:activateView(getText("UI_servers_publicServer"))

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

function MultiplayerUI:onToggleShowIPs()
    getCore():setOptionStreamerMode(self.showIPAddressesTickBox:isSelected(1))
    getCore():saveOptions()
end

function MultiplayerUI.onTextFilterChange(box)
    box.mpUI:sortInternetList();
end

function MultiplayerUI:drawAccountListItem(y, item, alt)
    local a = 0.9;
    local serverListSelected = self.parent.parent.parent.serverListSelected
    local serverListItem = self.parent.parent.parent.serverListItem
    local ui_ping = self.parent.parent.parent.ui_ping
    local ui_players = self.parent.parent.parent.ui_playerCount
    local icon = self.parent.parent.parent.ui_details_icon
    local ui_icon_bg = self.parent.parent.parent.ui_icon_bg
    local add_icon = self.parent.parent.parent.ui_add_icon
    local online = self.parent.parent.parent.ui_online
    local offline = self.parent.parent.parent.ui_offline
    local subitem_first = self.parent.parent.parent.ui_subitem_first
    local subitem_other = self.parent.parent.parent.ui_subitem_other
    --    self.parent.selectedFaction = nil;
   -- self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    local leftSpace = 0;
    if item.item.type == "account" or item.item.type == "new_account" then
        leftSpace = 65;
    end

    if self.selected == item.index then
        self:drawRect(leftSpace, (y), self:getWidth()-leftSpace, self.itemheight - 1, serverListSelected.a, serverListSelected.r, serverListSelected.g, serverListSelected.b);
    else
        self:drawRect(leftSpace, (y), self:getWidth()-leftSpace, self.itemheight - 1, serverListItem.a, serverListItem.r, serverListItem.g, serverListItem.b);
    end

    local circleIconOffset = UI_BORDER_SPACING/2
    local circleIconHeight = self.itemheight - UI_BORDER_SPACING

    if item.item.type == "server" then
        local server = item.item.server
        -- ping
        local rightSideIconY = (self.itemheight - FILTER_HGT)/2
        local xRightOffset = self:getWidth() - UI_BORDER_SPACING - getTextManager():MeasureStringX(UIFont.Medium, "0000000")
        if server:getPing() then
            self:drawText(server:getPing(), xRightOffset, y + (self.itemheight-FONT_HGT_MEDIUM)/2, 1, 1, 1, 1, UIFont.NewMedium);
        else
            self:drawText("-", xRightOffset, y + (self.itemheight-FONT_HGT_MEDIUM)/2, 1, 1, 1, 1, UIFont.NewMedium);
        end

        local currentIcon = ui_ping
        xRightOffset = xRightOffset - FILTER_HGT - UI_BORDER_SPACING
        self:drawTextureScaled(currentIcon, xRightOffset, y + rightSideIconY, FILTER_HGT, FILTER_HGT, 1, 0.8, 0.8, 0.8);

        -- separator
        xRightOffset = xRightOffset - UI_BORDER_SPACING
        self:drawRect(xRightOffset-1, y, 2, self.itemheight, 0.3, 0, 0, 0);

        -- players
        xRightOffset = xRightOffset - UI_BORDER_SPACING - getTextManager():MeasureStringX(UIFont.Medium, "000/000")
        if server:getPlayers() then
            self:drawText(server:getPlayers().."/"..server:getMaxPlayers(), xRightOffset, y + (self.itemheight-FONT_HGT_MEDIUM)/2, 1, 1, 1, 1, UIFont.NewMedium);
        else
            self:drawText("-/-", xRightOffset, y + (self.itemheight-FONT_HGT_MEDIUM)/2, 1, 1, 1, 1, UIFont.NewMedium);
        end

        currentIcon = ui_players
        xRightOffset = xRightOffset - FILTER_HGT - UI_BORDER_SPACING
        self:drawTextureScaled(currentIcon, xRightOffset, y + rightSideIconY, FILTER_HGT, FILTER_HGT, 1, 0.8, 0.8, 0.8);

        -- separator
        xRightOffset = xRightOffset - UI_BORDER_SPACING
        self:drawRect(xRightOffset-1, y, 2, self.itemheight, 0.3, 0, 0, 0);

        -- edit button

        item.item.editButton:setX(xRightOffset - item.item.editButton:getWidth() - UI_BORDER_SPACING)
        item.item.editButton:setY(y + self:getYScroll() + (self.itemheight - BUTTON_HGT) / 2)

        -- Icon
        self:setStencilCircle(circleIconOffset, y + self:getYScroll() + circleIconOffset, circleIconHeight, circleIconHeight)
        self:drawTextureScaled(icon, circleIconOffset, y + circleIconOffset, circleIconHeight, circleIconHeight, 1, 1, 1, 1);
        self:clearStencilRect()
        self:repaintStencilRect(0, 0, self:getWidth(), self:getHeight())
        --self:drawTextureScaled(ui_icon_bg, 25, y + 4, 42, 42, 1, 1, 1, 1);
        --self:drawTextCentre(getTwoLetters(server:getName()), 46, y + 12, 1,1,1, a, UIFont.Large);
        -- OnlineStatus

        local onlineTextureHeight = 15
        local onlineTextureX = circleIconOffset + circleIconHeight - onlineTextureHeight
        if server:isResponded() then
            self:drawTextureScaled(online, onlineTextureX, y+onlineTextureX, onlineTextureHeight, onlineTextureHeight, 1, 1, 1, 1);
        else
            self:drawTextureScaled(offline, onlineTextureX, y+onlineTextureX, onlineTextureHeight, onlineTextureHeight, 1, 1, 1, 1);
        end

        xRightOffset = circleIconHeight+UI_BORDER_SPACING
        -- Name
        self:drawText(server:getName(), xRightOffset, y+UI_BORDER_SPACING, 1,1,1, a, UIFont.NewMedium);
        -- Info
        self:drawText(server:getDisplayAddress(), xRightOffset, y+FONT_HGT_MEDIUM+UI_BORDER_SPACING, 1, 1, 1, a, UIFont.Small);

        xRightOffset = xRightOffset + getTextManager():MeasureStringX(UIFont.Small, server:getDisplayAddress())
        self:drawText(" | ", xRightOffset, y+FONT_HGT_MEDIUM+UI_BORDER_SPACING, 1, 1, 1, a, UIFont.Small);
        -- version
        xRightOffset = xRightOffset + getTextManager():MeasureStringX(UIFont.Small, " | ")
        if server:getVersion() then
            self:drawText("v ".. server:getVersion(), xRightOffset, y+FONT_HGT_MEDIUM+UI_BORDER_SPACING, 1, 1, 1, a, UIFont.NewSmall);
        else
            self:drawText("v -", xRightOffset, y+FONT_HGT_MEDIUM+UI_BORDER_SPACING, 1, 1, 1, a, UIFont.NewSmall);
        end
    end

    if item.item.type == "new_server" then
        -- Icon
        self:drawTextureScaled(add_icon, leftSpace+circleIconOffset, y + circleIconOffset, circleIconHeight, circleIconHeight, 1, 1, 1, 1);
        -- Name
        self:drawText(getText("UI_servers_addserver"), leftSpace+circleIconHeight+UI_BORDER_SPACING, y+(self.itemheight-FONT_HGT_MEDIUM)/2, 1,1,1, a, UIFont.NewMedium);
    end

    if item.item.type == "account" then
        local account = item.item.account
        if item.item.first then
            self:drawTextureScaled(subitem_first, 45, y, 20, 29, 1, 1, 1, 1);
        else
            self:drawTextureScaled(subitem_other, 45, y-26, 20, 54, 1, 1, 1, 1);
        end

        -- Icon
        if account:getIcon() then
            self:setStencilCircle(leftSpace+circleIconOffset, y + self:getYScroll() + circleIconOffset, circleIconHeight, circleIconHeight)
            self:drawTextureScaled(account:getIcon(), leftSpace+circleIconOffset, y + circleIconOffset, circleIconHeight, circleIconHeight, 1, 1, 1, 1);
            self:clearStencilRect()
        else
            self:drawTextureScaled(ui_icon_bg, leftSpace+circleIconOffset, y + circleIconOffset, circleIconHeight, circleIconHeight, 1, 1, 1, 1);
            self:drawTextCentre(getTwoLetters(account:getUserName()), leftSpace+circleIconOffset+circleIconHeight/2, y + circleIconOffset+(circleIconHeight-FONT_HGT_LARGE)/2, 1,1,1, a, UIFont.Large);
        end

        -- Name
        local name = account:getUserName();
        if account:getPlayerFirstAndLastName() then
            name = name .. " (" .. account:getPlayerFirstAndLastName() .. ")";
        end
        self:drawText(name, leftSpace + circleIconHeight + UI_BORDER_SPACING, y, 1, 1, 1, a, UIFont.NewMedium);

        -- Info
        if account:getTimePlayed() then
            self:drawText(getText("UI_servers_time_played").." "..tostring(account:getTimePlayed()).." "..getText("UI_servers_minutes"), leftSpace + circleIconHeight + UI_BORDER_SPACING, y + self.itemheight - FONT_HGT_NEW_SMALL - FONT_HGT_NEW_SMALL, 1, 1, 1, a, UIFont.NewSmall);
        else
            self:drawText(getText("UI_servers_time_played").." - "..getText("UI_servers_minutes"), leftSpace + circleIconHeight + UI_BORDER_SPACING, y + self.itemheight - FONT_HGT_NEW_SMALL - FONT_HGT_NEW_SMALL, 1, 1, 1, a, UIFont.NewSmall);
        end

        -- Login
        if account:getLastLogon() then
            self:drawText(getText("UI_servers_last_logout").." "..tostring(account:getLastLogon()), leftSpace + circleIconHeight + UI_BORDER_SPACING, y + self.itemheight - FONT_HGT_NEW_SMALL, 1, 1, 1, a, UIFont.NewSmall);
        else
            self:drawText(getText("UI_servers_last_logout").." -", leftSpace + circleIconHeight + UI_BORDER_SPACING, y + self.itemheight - FONT_HGT_NEW_SMALL, 1, 1, 1, a, UIFont.NewSmall);
        end

        item.item.deleteButton:setX(self:getWidth() - item.item.deleteButton:getWidth() - UI_BORDER_SPACING - SCROLL_BAR_WIDTH)
        item.item.deleteButton:setY(y + self:getYScroll() + (self.itemheight-BUTTON_HGT)/2)

        item.item.editButton:setX(item.item.deleteButton:getX() - item.item.editButton:getWidth() - UI_BORDER_SPACING)
        item.item.editButton:setY(y + self:getYScroll() + (self.itemheight-BUTTON_HGT)/2)

        item.item.connectButton:setX(item.item.editButton:getX() - item.item.connectButton:getWidth() - UI_BORDER_SPACING)
        item.item.connectButton:setY(y + self:getYScroll() + (self.itemheight-BUTTON_HGT)/2)
    end

    if item.item.type == "new_account" then
        if item.item.first then
            self:drawTextureScaled(subitem_first,45, y, 20, 29, 1, 1, 1, 1);
        else
            self:drawTextureScaled(subitem_other, 45, y-26, 20, 54, 1, 1, 1, 1);
        end
        -- Icon
        self:drawTextureScaled(add_icon, leftSpace+circleIconOffset, y + circleIconOffset, circleIconHeight, circleIconHeight, 1, 1, 1, 1);
        -- Name
        self:drawText(getText("UI_servers_add_new_account"), leftSpace+circleIconHeight+UI_BORDER_SPACING, y+(self.itemheight-FONT_HGT_MEDIUM)/2, 1,1,1, a, UIFont.NewMedium);
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
    local ui_players = self.parent.parent.parent.ui_playerCount
    local icon = self.parent.parent.parent.ui_icon_bg

    local ui_passwordOff = self.parent.parent.parent.ui_passwordOff
    local ui_passwordOn = self.parent.parent.parent.ui_passwordOn
    local ui_whitelist = self.parent.parent.parent.ui_whitelist
    local ui_mods = self.parent.parent.parent.ui_mods;
    --    self.parent.selectedFaction = nil;
    -- self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    local rightSideIconY = (self.itemheight - FILTER_HGT)/2

    --background
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, serverListSelected.a, serverListSelected.r, serverListSelected.g, serverListSelected.b);
    else
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, serverListItem.a, serverListItem.r, serverListItem.g, serverListItem.b);
    end

    -- ping
    local xRightOffset = self:getWidth() - UI_BORDER_SPACING - getTextManager():MeasureStringX(UIFont.Medium, "0000000")
    if tonumber(item.item:getPing()) > -1 then
        self:drawText(item.item:getPing(), xRightOffset, y + (self.itemheight-FONT_HGT_MEDIUM)/2, 1, 1, 1, 1, UIFont.NewMedium);
    end

    local currentIcon = ui_ping
    xRightOffset = xRightOffset - FILTER_HGT - UI_BORDER_SPACING
    self:drawTextureScaled(currentIcon, xRightOffset, y + rightSideIconY, FILTER_HGT, FILTER_HGT, 1, 0.8, 0.8, 0.8);

    -- separator
    xRightOffset = xRightOffset - UI_BORDER_SPACING
    self:drawRect(xRightOffset-1, y, 2, self.itemheight, 0.3, 0, 0, 0);
    PING_WIDTH = self:getWidth() - xRightOffset

    -- players
    xRightOffset = xRightOffset - UI_BORDER_SPACING - getTextManager():MeasureStringX(UIFont.Medium, "000/000")
    self:drawText(item.item:getPlayers().."/"..item.item:getMaxPlayers(), xRightOffset, y + (self.itemheight-FONT_HGT_MEDIUM)/2, 1, 1, 1, 1, UIFont.NewMedium);

    currentIcon = ui_players
    xRightOffset = xRightOffset - FILTER_HGT - UI_BORDER_SPACING
    self:drawTextureScaled(currentIcon, xRightOffset, y + rightSideIconY, FILTER_HGT, FILTER_HGT, 1, 0.8, 0.8, 0.8);

    -- separator
    xRightOffset = xRightOffset - UI_BORDER_SPACING
    self:drawRect(xRightOffset-1, y, 2, self.itemheight, 0.3, 0, 0, 0);
    PLAYER_WIDTH = self:getWidth() - xRightOffset - PING_WIDTH

    SERVER_INFO_WIDTH = xRightOffset

    -- Circle Icon
    local circleIconOffset = UI_BORDER_SPACING/2
    local circleIconHeight = self.itemheight - UI_BORDER_SPACING
    self:drawTextureScaled(icon, circleIconOffset, y+circleIconOffset, circleIconHeight, circleIconHeight, 1, 1, 1, 1);
    self:drawTextCentre(getTwoLetters(item.text), circleIconOffset+circleIconHeight/2, y + circleIconOffset+(circleIconHeight-FONT_HGT_LARGE)/2, 1, 1, 1, a, UIFont.Large);
    -- FeatureStatus
    --self:drawTextureScaled(online, 124, y + 32, 15, 15, 1, 1, 1, 1);

    -- Right side icons
    -- Whitelisted
    currentIcon = ui_whitelist
    local iconColor
    if item.item:isOpen() then
        iconColor = 0.2
    else
        iconColor = 1
    end
    xRightOffset = SERVER_INFO_WIDTH - FILTER_HGT - UI_BORDER_SPACING
    self:drawTextureScaled(currentIcon, xRightOffset, y + rightSideIconY, FILTER_HGT, FILTER_HGT, 1, iconColor, iconColor, iconColor);

    -- Password protected
    if item.item:isPasswordProtected() then
        currentIcon = ui_passwordOn
        iconColor = 1
    else
        currentIcon = ui_passwordOff
        iconColor = 0.2
    end
    xRightOffset = xRightOffset - FILTER_HGT
    self:drawTextureScaled(currentIcon, xRightOffset, y + rightSideIconY, FILTER_HGT, FILTER_HGT, 1, iconColor, iconColor, iconColor);

    -- Modded server
    currentIcon = ui_mods
    if server:getMods() and "" ~= server:getMods() then
        iconColor = 1
    else
        iconColor = 0.2
    end
    xRightOffset = xRightOffset - FILTER_HGT
    self:drawTextureScaled(currentIcon, xRightOffset, y + rightSideIconY, FILTER_HGT, FILTER_HGT, 1, iconColor, iconColor, iconColor);

    -- Version
    xRightOffset = xRightOffset - UI_BORDER_SPACING
    local versionWidth = 0
    if item.item:getVersion() and item.item:getVersion() ~= "" then
        self:drawTextRight("v ".. item.item:getVersion(), xRightOffset, y + (self.itemheight-FONT_HGT_SMALL)/2, 1, 1, 1, a, UIFont.NewSmall);
        versionWidth = getTextManager():MeasureStringX(UIFont.NewSmall, "v ".. item.item:getVersion())
    end
    local stencilRight = xRightOffset - UI_BORDER_SPACING - versionWidth
    local stencilLeft = circleIconHeight+UI_BORDER_SPACING*2

    -- Name
    self:setStencilRect(circleIconHeight+UI_BORDER_SPACING, y+UI_BORDER_SPACING+self:getYScroll(), stencilRight - stencilLeft, FONT_HGT_MEDIUM)
    self:drawText(item.item:getName(), circleIconHeight+UI_BORDER_SPACING, y+UI_BORDER_SPACING, 1,1,1, a, UIFont.NewMedium);
    self:clearStencilRect()

    -- IP
    self:drawText(item.item:getDisplayAddress(), circleIconHeight+UI_BORDER_SPACING, y+FONT_HGT_MEDIUM+UI_BORDER_SPACING, 1, 1, 1, a, UIFont.Small);

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
        self.rightPanelFavouritesButton:setImage(getTexture("media/ui/MP/mp_ui_star_outline.png"))
    else
        self.rightPanelFavouritesButton:setTitle(getText("UI_servers_add_to_favourites"))
        self.rightPanelFavouritesButton:setImage(getTexture("media/ui/MP/mp_ui_star.png"))
    end
    self.serverDescription.text = server:getDescription();

    if server:getMods() and server:getMods() ~= "" then
        local mods = server:getMods()
        if getSteamModeActive() then
            mods = mods:gsub(";", ",")
        end
        mods = mods:gsub("<", "&lt")
        mods = mods:gsub(">", "&gt")
        mods = mods:gsub(",", " <LINE> ")
        self.serverDescription.text = self.serverDescription.text .. " <BR><IMAGE:media/ui/MP/mp_ui_mods.png,32,32> <SIZE:large><RGB:0.45,0.57,0.64> " .. getText("UI_servers_mods") .. " <LINE><SIZE:small><RGB:1.0,1.0,1.0>234" .. mods
    end

    self.serverDescription:paginate();
    local lines = splitString(server:getName(), 36)
    self.selectedInternetServerName1 = lines[0]
    self.selectedInternetServerName2 = lines[1]

    --if getSteamModeActive() and server.isResponded() then
    --    steamRequestServerDetails(server:getIp(), server:getPort())
    --end
    --if server:getIp() and server:getIp() ~= "" and server:getPort() then
    --    steamRequestServerDetails(server:getIp(), server:getPort())
    --end
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
        self.screenShading:bringToTop()
        self.modal:bringToTop()
    end
    if _item.type == "new_account" then
        self.modal = ISMPEditAccount:new(self, _item.server, nil);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:bringToTop()
        self.modal:bringToTop()
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
        self.screenShading:bringToTop()
        self.modal:bringToTop()
    elseif button.internal == "DELETE_ACCOUNT" then
        self.modal = ISModalDialog:new(0,0, 250, 150,  getText("UI_servers_delete_account"), true, self, MultiplayerUI.onDeleteAccount, nil, button.account);
        self.modal:initialise()
        self.modal:setX ( (getCore():getScreenWidth() - self.modal:getWidth()) / 2);
        self.modal:setY ( (getCore():getScreenHeight() - self.modal:getHeight()) / 2);
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:bringToTop()
        self.modal:bringToTop()
    elseif button.internal == "EDIT_ACCOUNT" then
        self.modal = ISMPEditAccount:new(self, button.server, button.account);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.screenShading:setVisible(true)
        self.screenShading:bringToTop()
        self.modal:bringToTop()
    elseif button.internal == "CONNECT" then
        DebugLog.General:debugln("Connecting to server (IP: " .. tostring(button.server:getIp()) .. "; Port: " .. tostring(button.server:getPort()) .. ").")
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
        self.screenShading:bringToTop()
        self.modal:bringToTop()
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

        local btnWidth = UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_button_edit"))
        editButton = ISButton:new(0, 0, btnWidth, BUTTON_HGT, getText("UI_servers_button_edit"), self, MultiplayerUI.onPressButtonOnAccountList);
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

            btnWidth = UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_button_delete"))
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

            btnWidth = UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_button_edit"))
            editButton = ISButton:new(0, 0, 65, BUTTON_HGT, getText("UI_servers_button_edit"), self, MultiplayerUI.onPressButtonOnAccountList);
            editButton.internal = "EDIT_ACCOUNT";
            editButton:initialise();
            editButton:instantiate();
            editButton.server = server
            editButton.account = account
            editButton.font = UIFont.Small;
            editButton:setWidthToTitle();
            self.accountList:addChild(editButton);

            btnWidth = UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_button_connect"))
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
    for i, k in ipairs(self.serverList) do
        self.serverList[i] = nil;
    end
    for i, k in ipairs(servers) do
        self:analyzeServerData(k)
    end
    self:sortInternetList();
end

MultiplayerUI.done = false;
function MultiplayerUI:analyzeServerData(server)
    server:setFeatured(self:getServerFeatured(server) ~= nil);

    -- RJ: it's just for me to run some heavier test on the server list
    --if #self.serverList > 20000 or MultiplayerUI.done then
    --    return;
    --end
    --for i=0, 10 do
    --    local newServer = Server.new();
    --    newServer:setName(server:getName() .. " " .. i)
    --    newServer:setIp(server:getIp());
    --    newServer:setPlayers(server:getPlayers())
    --    newServer:setMaxPlayers(server:getMaxPlayers())
    --    newServer:setOpen(server:isOpen());
    --    newServer:setPasswordProtected(server:isPasswordProtected());
    --    newServer:setVersion(server:getVersion());
    --    self.serverList[newServer:getName()] = newServer;
    --end
    --self.internetList:addItem(server:getName(), server);
    --self.serverList[server:getName()] = server;
    if not server:isPublic() then
        return;
    end

    -- RJ: there's some people having and display huge players number with 0 max, gonna ignore them
    if tonumber(server:getPlayers()) > tonumber(server:getMaxPlayers()) then
        return;
    end

    for i,v in ipairs(self.serverList) do
        if v:getPort() == server:getPort() and v:getIp() == server:getIp() then
            return;
        end
    end

    table.insert(self.serverList, server);

    if not self.selectedInternetServer then
       MultiplayerUI:selectInternetServer(server)
    end

    self.listChanged = true; -- this is so we can fire the sort if needed
    --MultiplayerUI.done = true;
    --self:sortInternetList();
end

function MultiplayerUI:onResolutionChange(oldw, oldh, neww, newh)
    local wideEnough = true
    local widthMulti = 1

    if self.width < 1200 then
        wideEnough = false
        widthMulti = 0
    end

    self.tabs:setWidth(self.width - (RIGHT_PANEL_WIDTH - UI_BORDER_SPACING)*widthMulti)
    self.tabs:setHeight(self.height - TAB_HEIGHT)

    -- favourites tab
    self.accountList:setX(UI_BORDER_SPACING)
    self.accountList:setY(UI_BORDER_SPACING+1)
    self.accountList:setWidth(self.tabs:getWidth() - UI_BORDER_SPACING*2 - 2)
    self.accountList:setHeight(self.tabs:getHeight() - UI_BORDER_SPACING*3 - BUTTON_HGT - 2)

    -- internet tab
    self.internetList:setX(UI_BORDER_SPACING)
    self.internetList:setY(FILTER_HGT + UI_BORDER_SPACING*2 + BUTTON_HGT)
    self.internetList:setWidth(self.tabs:getWidth() - UI_BORDER_SPACING*2 - 2)
    self.internetList:setHeight(self.tabs:getHeight() - FILTER_HGT - UI_BORDER_SPACING*4 - BUTTON_HGT*2 - 1)

    self.filterVersion:setX(self.internetList:getRight() - self.filterVersion:getWidth())
    self.filterVersion:setY(UI_BORDER_SPACING+1)

    self.filterFullServer:setX(self.filterVersion:getX() - TICKBOX_SPACING - FILTER_SCALE)
    self.filterFullServer:setY(self.filterVersion:getY())

    self.filterEmptyServer:setX(self.filterFullServer:getX() - TICKBOX_SPACING)
    self.filterEmptyServer:setY(self.filterVersion:getY())

    self.filterPwdProtected:setX(self.filterEmptyServer:getX() - TICKBOX_SPACING)
    self.filterPwdProtected:setY(self.filterVersion:getY())

    self.filterWhitelistServer:setX(self.filterPwdProtected:getX() - TICKBOX_SPACING)
    self.filterWhitelistServer:setY(self.filterVersion:getY())

    self.filterModdedServer:setX(self.filterWhitelistServer:getX() - TICKBOX_SPACING)
    self.filterModdedServer:setY(self.filterVersion:getY())

    self.filter:setX(UI_BORDER_SPACING)
    self.filter:setY(UI_BORDER_SPACING+1)
    self.filter:setWidth(self.filterModdedServer:getX() - self.filter:getX() - TICKBOX_SPACING + FILTER_HGT)
    self.filter:setHeight(FONT_HGT_MEDIUM + 6)

    -- buttons
    self.backButton:setX(0)
    self.backButton:setY(self.height - BUTTON_HGT)

    self.refreshBtn:setX(self.tabs:getRight() - self.refreshBtn:getWidth())
    self.refreshBtn:setY(self.backButton:getY())

    self.connectBtn:setX(self.refreshBtn:getX() - self.connectBtn:getWidth() - UI_BORDER_SPACING)
    self.connectBtn:setY(self.refreshBtn:getY())

    self.showIPAddressesTickBox:setX(self.backButton:getRight() + UI_BORDER_SPACING * 2)
    self.showIPAddressesTickBox:setY(self.backButton:getY())

    -- right panel
    self.rightPanel:setVisible(wideEnough)
    self.rightPanelInternal:setVisible(wideEnough)
    self.serverDescription:setVisible(wideEnough)
    self.rightPanelFavouritesButton:setVisible(wideEnough)

    if wideEnough then
        self.rightPanel:setX(self.tabs:getRight() + UI_BORDER_SPACING)
        self.rightPanel:setY(self.tabs.tabHeight)
        self.rightPanel:setWidth(RIGHT_PANEL_WIDTH)
        self.rightPanel:setHeight(self.tabs:getHeight())

        self.rightPanelInternal:setX(self.rightPanel:getX() + UI_BORDER_SPACING+1)
        self.rightPanelInternal:setY(self.rightPanel:getY() + UI_BORDER_SPACING+1)
        self.rightPanelInternal:setWidth(self.rightPanel:getWidth() - UI_BORDER_SPACING*2 - 2)
        self.rightPanelInternal:setHeight(self.rightPanel:getHeight() - UI_BORDER_SPACING*2 - 2)
    end

    if self.screenShading then
        self.screenShading:onResolutionChange(oldw, oldh, neww, newh)
    end
    if self.modal and self.modal.onResolutionChange then
        self.modal:onResolutionChange(oldw, oldh, neww, newh)
    end
end

function MultiplayerUI:prerender()
    local bannerHeight = self.rightPanelInternal:getWidth() * 251 / 954
    local serverInfoBluePanelHeight = 128
    local rightBottomPanelY = self.rightPanelInternal:getY()+bannerHeight+serverInfoBluePanelHeight
    -- Bottom Background
    --self:drawTextureScaled(self.default_bottom_background, self.rightPanelInternal:getX()+1, rightBottomPanelY, self.rightPanelInternal:getWidth()-1, self.rightPanelInternal:getHeight() - bannerHeight-serverInfoBluePanelHeight, 1, 1, 1, 1);
    local timeFromLastUpdate = getTimestamp() - MultiplayerUI.startRefreshTime
    local refreshTime = 60;
    if getDebug() then
        refreshTime = 5;
    end
    if timeFromLastUpdate > refreshTime then
        self.refreshBtn:setTitle(getText("UI_servers_refresh"))
        self.refreshBtn:setEnable(true)
    else
        self.refreshBtn:setTitle(getText("UI_servers_refresh_timer", refreshTime - timeFromLastUpdate))
        self.refreshBtn:setEnable(false)
    end
    if self.modal then
        self.modal:bringToTop()
    end
end

function MultiplayerUI:updateButtons()
    self.connectBtn:setEnable(self.selectedInternetServer ~= nil);
end

function MultiplayerUI:render()
    if self.rightPanel:isVisible() then

        local rightX = self.rightPanelInternal:getX()+1
        local rightY = self.rightPanelInternal:getY()+1
        local rightW = self.rightPanelInternal:getWidth()-2
        local rightH = self.rightPanelInternal:getHeight()-2
        local rightTop = rightY

        -- banner
        local bannerW = self.default_banner:getWidth()
        local bannerH = self.default_banner:getHeight()
        bannerH = rightW * (math.min(bannerW, bannerH) / math.max(bannerW, bannerH))
        self:drawTextureScaled(self.default_banner, rightX, rightY, rightW, bannerH, 1, 1, 1, 1);
        rightY = rightY+bannerH

        -- blue rectangle
        local blueRectH = (FONT_HGT_LARGE+FONT_HGT_MEDIUM+UI_BORDER_SPACING)*2 + BUTTON_HGT
        self:drawRect(rightX, rightY, rightW, blueRectH, self.serverInfoBluePanelColor.a, self.serverInfoBluePanelColor.r, self.serverInfoBluePanelColor.g, self.serverInfoBluePanelColor.b);

        -- circle icon
        local circleSize = math.min(bannerH * 0.875, 128)
        local circleBorderSize = circleSize + UI_BORDER_SPACING
        local circleBorderOffset = (circleBorderSize - circleSize)/2

        local circleX = rightX + UI_BORDER_SPACING
        local circleY = rightY - circleBorderSize+(FONT_HGT_LARGE*2)
        self:setStencilCircle(circleX+circleBorderOffset, circleY+circleBorderOffset, circleSize, circleSize)
        self:drawTextureScaled(self.ui_details_icon, circleX+circleBorderOffset, circleY+circleBorderOffset, circleSize, circleSize, 1, 1, 1, 1);
        self:clearStencilRect()
        self:drawTextureScaled(self.ui_circle, circleX, circleY, circleBorderSize, circleBorderSize, self.serverInfoBluePanelColor.a, self.serverInfoBluePanelColor.r, self.serverInfoBluePanelColor.g, self.serverInfoBluePanelColor.b);

        -- server name
        local textLeftMargin = circleX + circleBorderSize + UI_BORDER_SPACING
        local textTempMargin = textLeftMargin

        if self.selectedInternetServerName2 == "" then
            self:drawText(self.selectedInternetServerName1, textLeftMargin, rightY+FONT_HGT_LARGE, 1, 1, 1, 1, UIFont.Large);
        else
            self:drawText(self.selectedInternetServerName1, textLeftMargin, rightY, 1, 1, 1, 1, UIFont.Large);
            self:drawText(self.selectedInternetServerName2, textLeftMargin, rightY+FONT_HGT_LARGE, 1, 1, 1, 1, UIFont.Large);
        end
        textLeftMargin = rightX + UI_BORDER_SPACING
        textTempMargin = textLeftMargin
        rightY = rightY + FONT_HGT_LARGE*2

        -- IP
        self:drawText(getText("UI_servers_IP"), textTempMargin, rightY, self.serverInfoBlueTextColor.r, self.serverInfoBlueTextColor.g, self.serverInfoBlueTextColor.b, self.serverInfoBlueTextColor.a, UIFont.Medium);
        textTempMargin = textTempMargin + UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_IP"));
        if self.selectedInternetServer then
            self:drawText(self.selectedInternetServer:getDisplayIp(), textTempMargin, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        else
            self:drawText("-", textTempMargin, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        end
        textTempMargin = textTempMargin + UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, "000.000.000.000");

        -- port
        self:drawText(getText("UI_servers_Port"), textTempMargin, rightY, self.serverInfoBlueTextColor.r, self.serverInfoBlueTextColor.g, self.serverInfoBlueTextColor.b, self.serverInfoBlueTextColor.a, UIFont.Medium);
        textTempMargin = textTempMargin + UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_Port"));
        if self.selectedInternetServer then
            self:drawText(self.selectedInternetServer:getDisplayPort(), textTempMargin, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        else
            self:drawText("-", textTempMargin, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        end

        -- players
        local playersW = self.ui_playerCount:getWidth()
        local playersH = self.ui_playerCount:getHeight()
        playersW = playersW * (FONT_HGT_MEDIUM / playersH)
        playersH = FONT_HGT_MEDIUM

        local iconMargin = rightX + rightW - UI_BORDER_SPACING*2 - playersW - getTextManager():MeasureStringX(UIFont.Medium, "000/000");
        self:drawTextureScaled(self.ui_playerCount, iconMargin, rightY, playersW, playersH, self.serverInfoBlueTextColor.a, self.serverInfoBlueTextColor.r, self.serverInfoBlueTextColor.g, self.serverInfoBlueTextColor.b);
        if self.selectedInternetServer and self.selectedInternetServer:getPlayers() and self.selectedInternetServer:getMaxPlayers() then
            self:drawText(self.selectedInternetServer:getPlayers().."/"..self.selectedInternetServer:getMaxPlayers(), iconMargin+playersW+UI_BORDER_SPACING, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        else
            self:drawText("-/-", iconMargin+playersW+UI_BORDER_SPACING, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        end

        rightY = rightY+FONT_HGT_MEDIUM
        textTempMargin = textLeftMargin

        -- map
        self:drawText(getText("UI_servers_Map"), textTempMargin, rightY, self.serverInfoBlueTextColor.r, self.serverInfoBlueTextColor.g, self.serverInfoBlueTextColor.b, self.serverInfoBlueTextColor.a, UIFont.Medium);
        textTempMargin = textTempMargin + UI_BORDER_SPACING + getTextManager():MeasureStringX(UIFont.Medium, getText("UI_servers_Map"));
        if self.selectedInternetServer then
            self:drawText(self.selectedInternetServer:getMapName(), textTempMargin, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        else
            self:drawText("-", textTempMargin, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        end

        -- ping
        self:drawTextureScaled(self.ui_ping, iconMargin, rightY, playersW, playersH, self.serverInfoBlueTextColor.a, self.serverInfoBlueTextColor.r, self.serverInfoBlueTextColor.g, self.serverInfoBlueTextColor.b);
        if self.selectedInternetServer and self.selectedInternetServer:getPing() then
            self:drawText(self.selectedInternetServer:getPing(), iconMargin+playersW+UI_BORDER_SPACING, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        else
            self:drawText("-", iconMargin+playersW+UI_BORDER_SPACING, rightY, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Medium);
        end

        rightY = rightY+FONT_HGT_MEDIUM+UI_BORDER_SPACING
        textTempMargin = textLeftMargin

        -- favourites button
        self.rightPanelFavouritesButton:setX(textTempMargin)
        self.rightPanelFavouritesButton:setY(rightY)
        self:updateButtons();
        self:updateListSort();
        self.rightPanelFavouritesButton:prerender()
        self.rightPanelFavouritesButton:render()
        textTempMargin = textTempMargin + self.rightPanelFavouritesButton:getWidth() + UI_BORDER_SPACING

        -- Version
        local smallTextOffset = (BUTTON_HGT - FONT_HGT_SMALL)/2
        if self.selectedInternetServer and self.selectedInternetServer:getVersion() then
            self:drawText("v "..self.selectedInternetServer:getVersion(), textTempMargin, rightY+smallTextOffset, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        else
            self:drawText("v -", textTempMargin, rightY+smallTextOffset, self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        end
        rightY = rightY + BUTTON_HGT + UI_BORDER_SPACING

        -- server description
        self.serverDescription:setX(rightX)
        self.serverDescription:setY(rightY)
        self.serverDescription:setWidth(rightW)
        self.serverDescription:setHeight(rightH - rightY + rightTop - FONT_HGT_SMALL)

        -- last updated
        if self.selectedInternetServer then
            self:drawText(getText("UI_servers_last_update") .. tostring(self.selectedInternetServer:getLastUpdate()) .. getText("UI_servers_minutes_ago"), rightX+UI_BORDER_SPACING, rightY+self.serverDescription:getHeight(), self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        else
            self:drawText(getText("UI_servers_last_update") .. "-" .. getText("UI_servers_minutes_ago"), rightX+UI_BORDER_SPACING, rightY+self.serverDescription:getHeight(), self.serverInfoGrayTextColor.r, self.serverInfoGrayTextColor.g, self.serverInfoGrayTextColor.b, self.serverInfoGrayTextColor.a, UIFont.Small);
        end

        -- server count
        --if self.tabs:getActiveViewIndex() == 2 then
        --    self:drawTextRight(getText("UI_servers_serverNb", tostring(#self.internetList.items), tostring(#self.serverList)), self.refreshBtn:getX() + self.refreshBtn:getWidth(), self.refreshBtn:getY() - 18, 1,1,1,1);
        --end
    end
    --
    if self.tabs:getActiveViewIndex() == 2 then
        local x = self.tabs:getRight() - TICKBOX_SPACING
        local y = self.tabs:getY() + self.tabs.tabHeight + UI_BORDER_SPACING + 1

        x = self:drawTickboxIcons(self.ui_filters_6, x, y, FILTER_SCALE)
        x = self:drawTickboxIcons(self.ui_filters_5, x, y, 1)
        x = self:drawTickboxIcons(self.ui_filters_4, x, y, 1)
        x = self:drawTickboxIcons(self.ui_filters_3, x, y, 1)
        x = self:drawTickboxIcons(self.ui_filters_2, x, y, 1)
        x = self:drawTickboxIcons(self.ui_filters_1, x, y, 1)

        if self.filter:getInternalText() == "" then
            self:drawText(getText("UI_servers_filter"), self.tabs:getX() + self.filter:getX() + UI_BORDER_SPACING, self.tabs:getY() + self.tabs.tabHeight + self.filter:getY() + 3, 0.4, 0.4, 0.4, 1, UIFont.Medium);
        end
        if MultiplayerUI.serverCount then
            local progressbarWidth = self.connectBtn:getX() - self.showIPAddressesTickBox:getRight() - UI_BORDER_SPACING*3
            local progressbarHeight = BUTTON_HGT
            local progressbarX = self.showIPAddressesTickBox:getRight() + UI_BORDER_SPACING * 2
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
    self.refreshBtn:setVisible(self.tabs:getActiveViewIndex() == 2)

    self:renderSortButtons();
end

function MultiplayerUI:drawTickboxIcons(texture, x, y, scale)
    if scale == 1 then
        self:drawRect(x, y, 1, FILTER_HGT, 0.2, 1, 1, 1);
        self:drawTextureScaled(texture, x + 1 + UI_BORDER_SPACING, y, FILTER_HGT, FILTER_HGT, 1, 1, 1, 1);
    else
        self:drawRect(x - scale, y, 1, FILTER_HGT, 0.2, 1, 1, 1);
        self:drawTextureScaled(texture, x + 1 + UI_BORDER_SPACING - scale, y - scale / 2, FILTER_HGT + scale, FILTER_HGT + scale, 1, 1, 1, 1);
        x = x - scale
    end
    return x - TICKBOX_SPACING
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
    --table.sort(self.internetList.items, function(a, b)
    --    return self:sortServerList(a, b)
    --end)
end

-- RJ: Deprecated, java looks like way faster, still keeping it here for now just in case
function MultiplayerUI:sortServerList(a, b)
    if self.sortType == "name" then
        if self.sortDown then
            return a.item:getName() > b.item:getName();
        else
            return a.item:getName() < b.item:getName();
        end
    end
    if self.sortType == "player" then
        if self.sortDown then
            return tonumber(a.item:getPlayers()) > tonumber(b.item:getPlayers());
        else
            return tonumber(a.item:getPlayers()) < tonumber(b.item:getPlayers());
        end
    end
    if self.sortType == "ping" then
        if self.sortDown then
            return tonumber(a.item:getPing()) > tonumber(b.item:getPing());
        else
            return tonumber(a.item:getPing()) < tonumber(b.item:getPing());
        end
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
    self.buttonSortName:setWidth(SERVER_INFO_WIDTH);
    self.buttonSortName:setY(self.internetList:getY() - BUTTON_HGT);
    self.buttonSortName:setHeight(BUTTON_HGT);

    self.buttonSortPlayer:setX(self.buttonSortName:getX() + self.buttonSortName:getWidth());
    self.buttonSortPlayer:setWidth(PLAYER_WIDTH);
    self.buttonSortPlayer:setY(self.buttonSortName:getY());
    self.buttonSortPlayer:setHeight(self.buttonSortName:getHeight());

    self.buttonSortPing:setX(self.buttonSortPlayer:getX() + self.buttonSortPlayer:getWidth());
    self.buttonSortPing:setWidth(PING_WIDTH);
    self.buttonSortPing:setY(self.buttonSortName:getY());
    self.buttonSortPing:setHeight(self.buttonSortName:getHeight());

    -- draw the border around our buttons
    --self:drawRectBorder(self.buttonSortName:getX(), self.buttonSortName:getY(), self.buttonSortName:getWidth(), self.buttonSortName:getHeight(), 0.5, self.internetList.borderColor.r, self.internetList.borderColor.g, self.internetList.borderColor.b);
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
        if self.modal then
            self.modal:destroy()
            self.modal = nil
        end
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
            self.modal = ISModalDialog:new(self.x+(self.width-250)/2,self.y+(self.height-150)/2, 250, 150,  getText("UI_servers_remove_server"), true, self, MultiplayerUI.onDeleteServer, nil, self.selectedInternetServer);
            self.modal:initialise()
            self.modal:addToUIManager()
            self.screenShading:setVisible(true)
            self.screenShading:bringToTop()
            self.modal:bringToTop()
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
        self.screenShading:bringToTop()
        self.modal.connectAfter = true;
        self.modal:bringToTop()
    elseif server then
        if self:checkServerIsPwdProtected(server, true, false) then
            return;
        end
        -- add the server to our favourite
        --addServerToAccountList(server)
        --self:refreshList()
        --local item = self:getServerFeatured(server)
        --self:onSelectAccount(item)
        -- create the account
        self.modal = ISMPEditAccount:new(self, server, nil);
        self.modal:initialise()
        self.modal:addToUIManager()
        self.modal.ui = self;
        self.screenShading:setVisible(true)
        self.screenShading:bringToTop()
        self.modal.connectAfter = true;
        self.modal:bringToTop()
    end
end

-- when we click connect, if a server require a password and we didn't saved it, open the UI to enter it
function MultiplayerUI:checkServerIsPwdProtected(server, connectAfter, addToFavAfter)
    local favServer = self:getServerFeatured(server);

    if favServer then
        favServer = favServer.server;
    end

    --if (favServer and not favServer:isPasswordProtected()) and not self.selectedInternetServer:isPasswordProtected() then
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
    --print('OnSteamServerResponded ' .. tostring(serverIndex))
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
        --steamRequestServerRules(server:getIp(), server:getPort())
    end
end

function MultiplayerUI.OnSteamServerResponded2(host, port, server2)
    --print('OnSteamServerResponded2 ' .. host .. ' ' .. tostring(port))
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
    --print('OnSteamRulesRefreshComplete ' .. host .. ' ' .. tostring(port))
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
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
    --modded server icon
    o.ui_mods = getTexture("media/ui/MP/mp_ui_mods.png");

    --whitelist icon
    o.ui_whitelist = getTexture("media/ui/MP/mp_ui_whitelist.png");

    --locked icon
    o.ui_passwordOn = getTexture("media/ui/MP/mp_ui_passwordOn.png");
    o.ui_passwordOff = getTexture("media/ui/MP/mp_ui_passwordOff.png");

    --empty icon
    o.ui_emptyServer = getTexture("media/ui/MP/mp_ui_emptyServer.png");

    --full icon
    o.ui_fullServer = getTexture("media/ui/MP/mp_ui_fullServer.png");

    --all versions icon
    o.ui_allVersions = getTexture("media/ui/MP/mp_ui_allVersions.png");

    o.ui_ping = getTexture("media/ui/MP/mp_ui_ping.png");
    o.ui_playerCount = getTexture("media/ui/MP/mp_ui_playerCount.png");

    o.ui_filters_1 = o.ui_mods
    o.ui_filters_2 = o.ui_whitelist
    o.ui_filters_3 = o.ui_passwordOn
    o.ui_filters_4 = o.ui_emptyServer
    o.ui_filters_5 = o.ui_fullServer
    o.ui_filters_6 = o.ui_allVersions


	o.ui_details_icon = getTexture("media/ui/zomboidDefaultMPIcon.png");
    o.ui_icon_bg = getTexture("media/ui/MP/mp_ui_servericonbg.png");

	
	o.ui_circle = getTexture("media/ui/MP/mp_ui_circle.png");
	o.default_banner = getTexture("media/ui/MP/mp_ui_default_banner.png");
	o.default_bottom_background = getTexture("media/ui/MP/mp_ui_bottom_background.png");

	o.ui_players = getTexture("media/ui/MP/mp_ui_players.png");
	o.ui_online = getTexture("media/ui/MP/mp_ui_online.png");
	o.ui_offline = getTexture("media/ui/MP/mp_ui_offline.png");
	o.ui_subitem_first = getTexture("media/ui/MP/mp_ui_subitem_first.png");
	o.ui_subitem_other = getTexture("media/ui/MP/mp_ui_subitem_other.png");
	o.ui_add_icon = getTexture("media/ui/MP/mp_ui_add_icon.png");
    o.ui_open = getTexture("media/ui/MP/mp_ui_open.png");
    o.ui_closed = getTexture("media/ui/MP/mp_ui_closed.png");

	o.serverInfoBluePanelColor = {r=0.05, g=0.15, b=0.25, a=1};
	o.serverInfoBlueTextColor = {r=0.45, g=0.57, b=0.64, a=1};
    o.serverInfoGrayTextColor = {r=0.8, g=0.8, b=0.8, a=1};
    o.serverListSelected = {r=0.61, g=0.23, b=0.11, a=0.5};
    o.serverListItem = {r=0.30, g=0.30, b=0.30, a=0.5};
    o.progressBarColor = {r=0.0, g=0.8, b=0.0, a=1};
    o.rightPanelMargin = UI_BORDER_SPACING;
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
