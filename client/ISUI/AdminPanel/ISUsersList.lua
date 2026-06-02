ISUsersList = ISPanel:derive("ISUsersList");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local GHC = getCore():getGoodHighlitedColor()
local BHC = getCore():getBadHighlitedColor()
local SORT_BY_NAME = "name"
local SORT_BY_ROLE = "role"
local SORT_BY_LAST_CONNECTION = "lastconnection"
local SORT_BY_WARNINGS = "warnings"

function ISUsersList:initialise()
    ISPanel.initialise(self);
    self:calculateColumnPositions()

    local btnWidth = UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_UserList_Add"))
    self.add = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("IGUI_UserList_Add"), self, ISUsersList.onClick);
    self.add.internal = "ADD";
    self.add.anchorTop = false
    self.add.anchorBottom = true
    self.add:initialise();
    self.add:instantiate();
    self.add.borderColor = {r=1, g=1, b=1, a=0.1};
    self.add.enable = false;
    if ISUsersList.instance.player:getRole():hasCapability(Capability.ModifyNetworkUsers) then
        self.add.enable = true;
    end
    self:addChild(self.add);

    local buttonTitle = "";
    if (getSteamModeActive()) then
        buttonTitle = getText("IGUI_UserList_BannedSteamIDs")
    else
        buttonTitle = getText("IGUI_UserList_BannedIPs")
    end
    btnWidth = UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(UIFont.Small, buttonTitle)
    self.bannedIPs = ISButton:new(self.add:getRight() + UI_BORDER_SPACING, self.add:getY(), btnWidth, BUTTON_HGT, buttonTitle, self, ISUsersList.onClick);
    self.bannedIPs.internal = "BANNEDLIST";
    self.bannedIPs.anchorTop = false
    self.bannedIPs.anchorBottom = true
    self.bannedIPs:initialise();
    self.bannedIPs:instantiate();
    self.bannedIPs.borderColor = {r=1, g=1, b=1, a=0.1};
    self.bannedIPs.enable = false;
    if ISUsersList.instance.player:getRole():hasCapability(Capability.BanUnbanUser) then
        self.bannedIPs.enable = true;
    end
    self:addChild(self.bannedIPs);

    self.refresh = ISButton:new(self.bannedIPs:getRight() + UI_BORDER_SPACING, self.add:getY(), btnWidth, BUTTON_HGT, getText("IGUI_UserList_BannedIPs_Refresh"), self, self.refresh)
    self.refresh.anchorTop = false
    self.refresh.anchorBottom = true
    self.refresh:initialise()
    self.refresh:instantiate()
    self.refresh.borderColor = { r=1, g=1, b=1, a=0.1 }
    self:addChild(self.refresh)

    local showOnlineOnlyTickBox = ISTickBox:new(self.refresh:getRight() + UI_BORDER_SPACING, self.add:getY(), BUTTON_HGT + getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_UsersList_ShowOnlineOnlyFilter")), BUTTON_HGT, "showOnlineOnly", self, self.toggleShowOnlineOnly)
    showOnlineOnlyTickBox.anchorTop = false
    showOnlineOnlyTickBox.anchorBottom = true
    showOnlineOnlyTickBox:initialise()
    showOnlineOnlyTickBox:addOption(getText("IGUI_UsersList_ShowOnlineOnlyFilter"))
    showOnlineOnlyTickBox:setSelected(1, self.showOnlineOnly)
    showOnlineOnlyTickBox.choicesColor = { r=1, g=1, b=1, a=1 }
    self:addChild(showOnlineOnlyTickBox)

    btnWidth = UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_RolesList_Close"))
    self.close = ISButton:new(self.width - btnWidth - UI_BORDER_SPACING - 1, self.add:getY(), btnWidth, BUTTON_HGT, getText("IGUI_RolesList_Close"), self, ISUsersList.onClick);
    self.close.internal = "CLOSE";
    self.close.anchorTop = false
    self.close.anchorBottom = true
    self.close:initialise();
    self.close:instantiate();
    self.close.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.close);

    local searchWidth = 200
    self.searchEntry = ISTextEntryBox:new("", self.close:getX() - searchWidth - UI_BORDER_SPACING, self.add:getY(), searchWidth , BUTTON_HGT)
    self.searchEntry.font = UIFont.Small
    self.searchEntry:setTooltip(getText("IGUI_UsersList_FilterTooltip"))
    self.searchEntry.onTextChange = function() self:doSearch() end
    self.searchEntry.setText = function(_self, str)
        if not str then
            str = "";
        end
        _self.javaObject:SetText(str);
        _self.title = str;

        if OnScreenKeyboard.IsVisible() then
            _self:onTextChange()
        end
    end
    self.searchEntry.prerender = self.searchPrerender
    self.searchEntry:initialise()
    self.searchEntry:instantiate()
    self:addChild(self.searchEntry)

    local titleFilterWid = getTextManager():MeasureStringX(UIFont.Large, getText("IGUI_UsersList_Filter"))
    local titleFilter = ISLabel:new(self.searchEntry:getX() - titleFilterWid, self.add:getY(), BUTTON_HGT, getText("IGUI_UsersList_Filter"), 1, 1, 1, 1, UIFont.Small, true)
    titleFilter:initialise()
    titleFilter:instantiate()
    self:addChild(titleFilter)

    self.sortByNameButton = self:createColumnHeader(getText("IGUI_UsersList_NameColumn"), SORT_BY_NAME, UI_BORDER_SPACING + 1, self.roleColumnX - UI_BORDER_SPACING - 1, BUTTON_HGT)
    self:addChild(self.sortByNameButton)
    self.sortByRoleButton = self:createColumnHeader(getText("IGUI_UsersList_RoleColumn"), SORT_BY_ROLE, self.roleColumnX, self.lastConnectionColumnX - self.roleColumnX, BUTTON_HGT)
    self:addChild(self.sortByRoleButton)
    self.sortByLastConnectionButton = self:createColumnHeader(getText("IGUI_UsersList_LastConnectionColumn"), SORT_BY_LAST_CONNECTION, self.lastConnectionColumnX, self.warningsColumnX - self.lastConnectionColumnX, BUTTON_HGT)
    self:addChild(self.sortByLastConnectionButton)
    self.sortByWarningsButton = self:createColumnHeader(getText("IGUI_UsersList_WarningsColumn"), SORT_BY_WARNINGS, self.warningsColumnX, self:getWidth() - UI_BORDER_SPACING - 1 - self.warningsColumnX, BUTTON_HGT)
    self:addChild(self.sortByWarningsButton)

    self.datas = ISScrollingListBox:new(UI_BORDER_SPACING+1, FONT_HGT_MEDIUM+(UI_BORDER_SPACING+1)*2 + BUTTON_HGT, self.width - (UI_BORDER_SPACING+1)*2, self:getHeight() - BUTTON_HGT*2 - (UI_BORDER_SPACING + 1)*4 - FONT_HGT_MEDIUM);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = BUTTON_HGT*3
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.onmousedown = self.onSelectUSer
    self.datas.onRightMouseUp = ISUsersList.onRightMouse;
    self.datas.drawBorder = true;
    self:addChild(self.datas);

    self:populateList();
end

function ISUsersList:calculateColumnPositions()
    local testWarningsNumber = 1000
    local testSuspicionPointsString = getText("IGUI_UsersList_SuspicionPoints", testWarningsNumber)
    local testDetailsLastConnectString = tostring(os.date("%Y-%m-%d %H:%m:%S"))
    local testAuthTypeString = getText("IGUI_UsersList_DetailsAuthType", "google_auth")

    self.warningsColumnX = self:getWidth() - UI_BORDER_SPACING - 1 - getTextManager():MeasureStringX(UIFont.Small, testSuspicionPointsString)
    self.lastConnectionColumnX = self.warningsColumnX - UI_BORDER_SPACING*3 - getTextManager():MeasureStringX(UIFont.Small, testDetailsLastConnectString)
    self.roleColumnX = self.lastConnectionColumnX - UI_BORDER_SPACING*3 - getTextManager():MeasureStringX(UIFont.Small, testAuthTypeString)
end

function ISUsersList:createColumnHeader(name, sortType, x, width)
    local headerButton = ISButton:new(x, FONT_HGT_MEDIUM+(UI_BORDER_SPACING+1)*2, width, BUTTON_HGT, name, self, ISUsersList.onClickSort)
    headerButton.internal = sortType
    headerButton:initialise()
    headerButton.backgroundColor = { r=1, g=1, b=1, a=0.3 }
    headerButton.iconRightWidth = 10
    headerButton.iconRightHeight = 10
    headerButton.iconRightColor = { r=1, g=1, b=1, a=0.5 }
    headerButton.titleLeft = true
    return headerButton
end

function ISUsersList:populateList()
    self.datas:clear();
    local users = getUsers();
    local searchWord = self.searchEntry:getInternalText();
    for i=0,users:size()-1 do
        local user = users:get(i);
        local isSearchPassed = searchWord == '' or (not (searchWord == '') and (string.find(user:getUsername(), searchWord) ~= nil))
        local isOnlineFilterPassed = not self.showOnlineOnly or user:isOnline()
        if isSearchPassed and isOnlineFilterPassed then
            self.datas:addItem(user:getUsername(), user);
        end
    end
    self.datas:sort(self.comparator)
end

function ISUsersList:refresh()
    requestUsers()
    self:populateList()
end

function ISUsersList.comparator(user1, user2)
    if ISUsersList.instance == nil then
        return
    end
    if (not ISUsersList.instance.showOnlineOnly) and (user1.item:isOnline() ~= user2.item:isOnline()) then
        if user1.item:isOnline() then
            return not ISUsersList.instance.sortDown
        else
            return ISUsersList.instance.sortDown
        end
    end

    local result = 0
    if ISUsersList.instance.sortType == SORT_BY_NAME then
        if ISUsersList.instance.sortDown then
            return user1.item:getUsername():upper() >= user2.item:getUsername():upper()
        else
            return user1.item:getUsername():upper() < user2.item:getUsername():upper()
        end;
    elseif ISUsersList.instance.sortType == SORT_BY_ROLE then
        result = user1.item:getRole():getPosition() - user2.item:getRole():getPosition()
    elseif ISUsersList.instance.sortType == SORT_BY_LAST_CONNECTION then
        if ISUsersList.instance.sortDown then
            return user1.item:getLastConnection() >= user2.item:getLastConnection()
        else
            return user1.item:getLastConnection() < user2.item:getLastConnection()
        end;
    elseif ISUsersList.instance.sortType == SORT_BY_WARNINGS then
        local warningPointsValue = 1
        local suspicionPointsValue = 2
        local kicksValue = 3
        result = (user1.item:getWarningPoints() - user2.item:getWarningPoints()) * warningPointsValue +
            (user1.item:getSuspicionPoints() - user2.item:getSuspicionPoints()) * suspicionPointsValue +
            (user1.item:getKicks() - user2.item:getKicks()) * kicksValue
    end

    if ISUsersList.instance.sortDown then
        return result >= 0
    else
        return result < 0
    end;
end

function ISUsersList:drawDatas(y, item, alt)
    local a = 0.9;
    local yOffset = y+(BUTTON_HGT-FONT_HGT_SMALL)/2

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    local color = item.item:getRole():getColor()

    self:drawText(item.item:getUsername(), UI_BORDER_SPACING+1, yOffset, color:getR(), color:getG(), color:getB(), a, UIFont.Medium);
    if item.item:isOnline() then
        self:drawText("Online", UI_BORDER_SPACING+1, yOffset + FONT_HGT_MEDIUM, GHC:getR(), GHC:getG(), GHC:getB(), a, UIFont.Medium);
    else
        self:drawText("Offline", UI_BORDER_SPACING+1, yOffset + FONT_HGT_MEDIUM, 0.5, 0.5, 0.5, a, UIFont.Medium);
    end

    local warningPointsValue = item.item:getWarningPoints()
    local suspicionPointsValue = item.item:getSuspicionPoints()
    local kicksValue = item.item:getKicks()

    local warningPointsString = getText("IGUI_UsersList_WarningPoints", warningPointsValue)
    local suspicionPointsString = getText("IGUI_UsersList_SuspicionPoints", suspicionPointsValue)
    local kicksString = getText("IGUI_UsersList_Kicks", kicksValue)

    local progress = math.min(warningPointsValue/10.0, 1.0)
    local r = BHC:getR()*progress + GHC:getR()*(1-progress)
    local g = BHC:getG()*progress + GHC:getG()*(1-progress)
    local b = BHC:getB()*progress + GHC:getB()*(1-progress)
    self:drawText(warningPointsString, self.parent.warningsColumnX, yOffset, r, g, b, 1, UIFont.Small)

    progress = math.min(suspicionPointsValue/10.0, 1.0)
    r = BHC:getR()*progress + GHC:getR()*(1-progress)
    g = BHC:getG()*progress + GHC:getG()*(1-progress)
    b = BHC:getB()*progress + GHC:getB()*(1-progress)
    self:drawText(suspicionPointsString, self.parent.warningsColumnX, yOffset+BUTTON_HGT, r, g, b, 1, UIFont.Small)

    progress = math.min(kicksValue, 1.0)
    r = BHC:getR()*progress + GHC:getR()*(1-progress)
    g = BHC:getG()*progress + GHC:getG()*(1-progress)
    b = BHC:getB()*progress + GHC:getB()*(1-progress)
    self:drawText(kicksString, self.parent.warningsColumnX, yOffset+BUTTON_HGT*2, r, g, b, 1, UIFont.Small)

    local detailsRoleString = getText("IGUI_UsersList_DetailsRole", item.item:getRole():getName())
    local detailsAuthString = getText("IGUI_UsersList_DetailsAuthType", item.item:getAuthTypeName())
    local detailsNoWhitelistString = getText("IGUI_UsersList_DetailsNoWhitelist")

    self:drawText(detailsRoleString, self.parent.roleColumnX, yOffset, 1, 1, 1, a, self.font)
    if item.item:isInWhitelist() then
        self:drawText(detailsAuthString, self.parent.roleColumnX, yOffset+BUTTON_HGT, 1, 1, 1, a, self.font)
        self:drawText(item.item:getLastConnection(), self.parent.lastConnectionColumnX, yOffset, 1, 1, 1, a, self.font)
    else
        self:drawText(detailsNoWhitelistString, self.parent.roleColumnX, yOffset+BUTTON_HGT, 1, 1, 1, a, self.font)
        self:drawText("-", self.parent.lastConnectionColumnX, yOffset, 1, 1, 1, a, self.font)
    end

    return y + self.itemheight;
end

function ISUsersList:onSelectUser(_item)
    ISUsersList.instance.delete.enable = true;
    ISUsersList.instance.edit.enable = true;
    ISUsersList.instance.selectedItem = _item;
end

function ISUsersList:doSearch()
    self:populateList();
end

function ISUsersList:toggleShowOnlineOnly()
    self.showOnlineOnly = not self.showOnlineOnly
    self:populateList()
end

function ISUsersList:onClickSort(button)
    if self.sortType == button.internal then
        self.sortDown = not self.sortDown
    else
        self.sortDown = true
    end
    self.sortType = button.internal
    self:populateList()
end

function ISUsersList:prerender()
    self.sortByNameButton.iconRight = nil
    self.sortByRoleButton.iconRight = nil
    self.sortByLastConnectionButton.iconRight = nil
    self.sortByWarningsButton.iconRight = nil
    local icon = self.arrowUp
    if self.sortDown then
        icon = self.arrowDown
    end
    if self.sortType == SORT_BY_NAME then
        self.sortByNameButton.iconRight = icon
    elseif self.sortType == SORT_BY_ROLE then
        self.sortByRoleButton.iconRight = icon
    elseif self.sortType == SORT_BY_LAST_CONNECTION then
        self.sortByLastConnectionButton.iconRight = icon
    elseif self.sortType == SORT_BY_WARNINGS then
        self.sortByWarningsButton.iconRight = icon
    end

    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    self:drawText(getText("IGUI_AdminPanel_SeeUsers"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_SeeUsers")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium)
end

function ISUsersList:onClick(button)
    if button.internal == "ADD" then
        local modal = ISTextBox:new(0, 0, 280, 180, getText("IGUI_UserList_Add"), "", nil, ISUsersList.onAddUserClick);
        modal:initialise();
        modal:addToUIManager();
        return;
    end
    if button.internal == "BANNEDLIST" then
        if (getSteamModeActive()) then
            if ISBannedSteamIDViewer.instance then
                ISBannedSteamIDViewer.instance:close()
            end
            local modal = ISBannedSteamIDViewer:new(50, 200, 1200, 650)
            modal:initialise();
            modal:addToUIManager();
        else
            if ISBannedIPViewer.instance then
                ISBannedIPViewer.instance:close()
            end
            local modal = ISBannedIPViewer:new(50, 200, 1200, 650)
            modal:initialise();
            modal:addToUIManager();
        end
    end
    if button.internal == "DELETE" then
        local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - 130, (getCore():getScreenHeight() / 2) - 60, 260, 120, getText("IGUI_UsersList_DeleteUser"), true, ISUsersList.instance, ISUsersList.onDeleteModalClick);
        modal:initialise();
        modal:addToUIManager();
        return;
    end
    if button.internal == "CLOSE" then
        ISUsersList.instance:closeModal()
        return;
    end
end

function ISUsersList:onClickOption(item, action)
    if action == "Teleport" then
        teleportUserAction(action, item:getUsername(), "");
        return;
    end
    if action == "TeleportToHim" then
        teleportToHimUserAction(action, item:getUsername(), "");
        return
    end
    if action == "Kick" or action == "Ban" or action == "UnBan" or action == "BanIP" or action == "UnBanIP" or action == "BanSteamID" or action == "UnBanSteamID" then
        if (action == "BanSteamID" or action == "UnBanSteamID") then
            banUnbanUserAction(action, item:getSteamid(), "");
        else
            banUnbanUserAction(action, item:getUsername(), "");
        end
        return;
    end
    if action == "ResetTOTPSecret" or action == "ResetPassword" then
        networkUserAction(action, item:getUsername(), "");
        return;
    end
    if action == "AddWarningPoints" then
            local modal = ISTextBox:new(0, 0, 280, 180, getText("IGUI_UserList_AddWarningPoint"), "", nil, ISUsersList.onAddWarningPointsClick, nil, item:getUsername());
            modal:initialise();
            modal:addToUIManager();
            return;
        end
    if action == "SeeUserLog" then
        requestUserlog(item:getUsername());
        local modal = ISPlayerStatsUserlogUI:new(self.x + 200, self.y + 200, 600+(getCore():getOptionFontSizeReal()*100), 550, nil, ISPlayerStatsUI.onUserlogOption, item:getUsername(), {});
        modal:initialise();
        modal:addToUIManager();
    end
    if action == "SeeSuspicionActivity" then
        requestUserlog(item:getUsername());
        local modal = ISPlayerStatsSuspicionActivityUI:new(self.x + 200, self.y + 200, 600+(getCore():getOptionFontSizeReal()*100), 550, nil, ISPlayerStatsUI.onUserlogOption, item:getUsername(), {});
        modal:initialise();
        modal:addToUIManager();
    end
    if action == "ManageInventory" then
        local p = getPlayerFromUsername(item:getUsername())
        local pid = -1
        if p then
            pid = p:getOnlineID()
        end
        local modal = ISPlayerStatsManageInvUI:new(self.x + 100, self.y + 100, 900, 650, pid, item:getUsername());
        modal:initialise();
        modal:addToUIManager();
    end
    if action == "AddWarningPoint" then
        local modal = ISPlayerStatsWarningPointUI:new(self.x + 200, self.y + 200, 350, 250, item:getUsername(), ISUsersList.onAddWarningPoint);
        modal:initialise();
        modal:addToUIManager();
    end
    if action == "Delete" then
            local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - 130, (getCore():getScreenHeight() / 2) - 60, 260, 120, getText("IGUI_RolesList_DeleteRole"), true, ISUsersList.instance, ISUsersList.onDeleteModalClick);
            modal:initialise();
            modal:addToUIManager();
            return;
        end
    if action == "SetPassword" then
        local modal = ISTextBox:new(0, 0, 280, 180, getText("IGUI_UserList_SetPassword"), "", nil, ISUsersList.onSetPasswordClick, nil, item:getUsername());
        modal:initialise();
        modal:addToUIManager();
        return;
    end
end

function ISUsersList.onAddWarningPoint(username, button, reason, amount)
    addWarningPoint(username, reason, tonumber(amount));
end

function ISUsersList:onSetRoleClickOption(item, role)
    networkUserAction("SetRole", item:getUsername(), role);
end

function ISUsersList:onDeleteModalClick(button)
    if ISUsersList.instance.joyfocus then
        ISUsersList.instance.joyfocus.focus = ISUsersList.instance.listbox
    end
    if button.internal == "YES" then
        networkUserAction("Delete", ISUsersList.instance.datas.items[ISUsersList.instance.datas.selected].item:getUsername(), "");
    end
end

function ISUsersList:onSetPasswordClick(button, username)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            networkUserAction("SetPassword", username, button.parent.entry:getInternalText());
        end
    end
end

function ISUsersList:onAddUserClick(button)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            networkUserAction("Add", button.parent.entry:getInternalText(), "");
        end
    end
end

function ISUsersList:onRightMouse(x, y)
    ISUsersList.instance.datas:onMouseDown(x, y)
    ISUsersList.instance:doContextMenu(ISUsersList.instance.datas.items[ISUsersList.instance.datas.selected].item, x, y)
end

function ISUsersList:doContextMenu(item, x, y)
    local playerNum = self.player:getPlayerNum()
    local context = ISContextMenu.get(playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY());
    local roles = getRoles()
    if self.player:getRole():hasCapability(Capability.ChangeAccessLevel) and self.player:getRole():getPosition() >= item:getRole():getPosition() then
        local setRoleOption = context:addOption('Set Role', worldobjects, nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(setRoleOption, subMenu);
        for i=0,roles:size()-1 do
            local role = roles:get(i);
            if self.player:getRole():getPosition() >= role:getPosition() then
                subMenu:addOption(getText("IGUI_UserList_SetRole", role:getName()), ISUsersList.instance, ISUsersList.onSetRoleClickOption, item, role:getName());
            end
        end
    end
    if item:isOnline() then
        if self.player:getRole():hasCapability(Capability.TeleportPlayerToAnotherPlayer) then
            context:addOption(getText("IGUI_UserList_Teleport"), ISUsersList.instance, ISUsersList.onClickOption, item, "Teleport");
        end
        if self.player:getRole():hasCapability(Capability.TeleportToPlayer) then
            context:addOption(getText("IGUI_UserList_TeleportToHim"), ISUsersList.instance, ISUsersList.onClickOption, item, "TeleportToHim");
        end
        if self.player:getRole():hasCapability(Capability.KickUser) then
            local kickButton = context:addOption(getText("IGUI_UserList_Kick"), ISUsersList.instance, ISUsersList.onClickOption, item, "Kick");
            if item:getUsername() == self.player:getUsername() then
                kickButton.notAvailable = true;
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                tooltip.description = getText("IGUI_UserList_KickHimself");
                kickButton.toolTip = tooltip;
            end
            if item:getRole():hasCapability(Capability.CantBeKicked) then
                kickButton.notAvailable = true;
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                tooltip.description = getText("IGUI_UserList_CantBeKicked");
                kickButton.toolTip = tooltip;
            end
        end
    end
    if self.player:getRole():hasCapability(Capability.BanUnbanUser) then
        local banButton;
        if item:getRole():getName() == 'banned' then
            banButton = context:addOption(getText("IGUI_UserList_UnBan"), ISUsersList.instance, ISUsersList.onClickOption, item, "UnBan");
        else
            banButton = context:addOption(getText("IGUI_UserList_Ban"), ISUsersList.instance, ISUsersList.onClickOption, item, "Ban");
            if item:getRole():hasCapability(Capability.CantBeBannedByUser) then
                banButton.notAvailable = true;
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                tooltip.description = getText("IGUI_UserList_CantBeBanned");
                banButton.toolTip = tooltip;
            end
            if item:getUsername() == self.player:getUsername() then
                banButton.notAvailable = true;
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                tooltip.description = getText("IGUI_UserList_BanHimself");
                banButton.toolTip = tooltip;
            end
        end
        local steamMode = getSteamModeActive();
        if steamMode then
            local banSteamIdButton;
            if item:getSteamIdBanned() ~= nil and item:getSteamIdBanned() ~= '' then
                banSteamIdButton = context:addOption(getText("IGUI_UserList_UnBanBySteamID"), ISUsersList.instance, ISUsersList.onClickOption, item, "UnBanSteamID");
            else
                banSteamIdButton = context:addOption(getText("IGUI_UserList_BanBySteamID"), ISUsersList.instance, ISUsersList.onClickOption, item, "BanSteamID");
                if item:getRole():hasCapability(Capability.CantBeBannedByUser) then
                    banSteamIdButton.notAvailable = true;
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_UserList_CantBeBanned");
                    banSteamIdButton.toolTip = tooltip;
                end
                if not item:isOnline() or item:getRole():getName() == 'banned' then
                    banSteamIdButton.notAvailable = true;
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_UserList_BanSteamIdNotOnline");
                    banSteamIdButton.toolTip = tooltip;
                end
                if item:getUsername() == self.player:getUsername() then
                    banSteamIdButton.notAvailable = true;
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_UserList_BanHimself");
                    banSteamIdButton.toolTip = tooltip;
                end
            end
        end
        local hasIpBan = item:getIpBanned() ~= nil and item:getIpBanned() ~= '';
        local showBanIp = (not steamMode) or hasIpBan or item:isConnectedDirectly();
        if showBanIp then
            local banIpButton;
            if hasIpBan then
                banIpButton = context:addOption(getText("IGUI_UserList_UnBanIP"), ISUsersList.instance, ISUsersList.onClickOption, item, "UnBanIP");
            else
                banIpButton = context:addOption(getText("IGUI_UserList_BanIP"), ISUsersList.instance, ISUsersList.onClickOption, item, "BanIP");
                if item:getRole():hasCapability(Capability.CantBeBannedByUser) then
                    banIpButton.notAvailable = true;
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_UserList_CantBeBanned");
                    banIpButton.toolTip = tooltip;
                end
                if not item:isOnline() or item:getRole():getName() == 'banned' then
                    banIpButton.notAvailable = true;
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_UserList_BanIPNotOnline");
                    banIpButton.toolTip = tooltip;
                end
                if item:getUsername() == self.player:getUsername() then
                    banIpButton.notAvailable = true;
                    local tooltip = ISWorldObjectContextMenu.addToolTip();
                    tooltip.description = getText("IGUI_UserList_BanHimself");
                    banIpButton.toolTip = tooltip;
                end
            end
        end
    end
    if self.player:getRole():hasCapability(Capability.AddUserlog) then
        context:addOption(getText("IGUI_UserList_AddWarningPoint"), ISUsersList.instance, ISUsersList.onClickOption, item, "AddWarningPoint");
    end
    if self.player:getRole():hasCapability(Capability.ReadUserLog) then
        context:addOption(getText("IGUI_UserList_SeeUserLog"), ISUsersList.instance, ISUsersList.onClickOption, item, "SeeUserLog");
        if item:isOnline() then
            context:addOption(getText("IGUI_UserList_SeeSuspicionActivity"), ISUsersList.instance, ISUsersList.onClickOption, item, "SeeSuspicionActivity");
        end
    end
    if self.player:getRole():hasCapability(Capability.InspectPlayerInventory) then
        if item:isOnline() then
            context:addOption(getText("IGUI_PlayerStats_ManageInventory", item:getUsername()), ISUsersList.instance, ISUsersList.onClickOption, item, "ManageInventory");
        else
            context:addOption(getText("IGUI_PlayerStats_SeeInventory", item:getUsername()), ISUsersList.instance, ISUsersList.onClickOption, item, "ManageInventory");
        end

    end
    if self.player:getRole():hasCapability(Capability.ModifyNetworkUsers) and self.player:getRole():getPosition() >= item:getRole():getPosition() then
        context:addOption(getText("IGUI_UserList_Delete"), ISUsersList.instance, ISUsersList.onClickOption, item, "Delete");
        context:addOption(getText("IGUI_UserList_ResetTOTPSecret"), ISUsersList.instance, ISUsersList.onClickOption, item, "ResetTOTPSecret");
        context:addOption(getText("IGUI_UserList_ResetPassword"), ISUsersList.instance, ISUsersList.onClickOption, item, "ResetPassword");
        context:addOption(getText("IGUI_UserList_SetPassword"), ISUsersList.instance, ISUsersList.onClickOption, item, "SetPassword");
    end
end

function ISUsersList:closeModal()
    self:setVisible(false);
    self:removeFromUIManager();
    ISUsersList.instance = nil
end

function ISUsersList:new(x, y, width, height, player)
    local o = {}
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.player = player;
    o.moveWithMouse = true;
    o.showOnlineOnly = false
    o.arrowUp = getTexture("media/ui/ArrowUp.png")
    o.arrowDown = getTexture("media/ui/ArrowDown.png")
    o.sortDown = false
    o.sortType = SORT_BY_NAME
    ISUsersList.instance = o;
    return o;
end
