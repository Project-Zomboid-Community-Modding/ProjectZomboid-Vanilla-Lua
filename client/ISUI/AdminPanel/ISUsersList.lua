---
--- Created by Iurii.
--- DateTime: 3/6/2024 3:46 AM
---

ISUsersList = ISPanel:derive("ISUsersList");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6


--************************************************************************--
--** ISUsersList:initialise
--**
--************************************************************************--

function ISUsersList:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    self.add = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_UserList_Add"), self, ISUsersList.onClick);
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
    self.bannedIPs = ISButton:new((UI_BORDER_SPACING+1)*2+ btnWid, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, buttonTitle, self, ISUsersList.onClick);
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

    local searchHeight = FONT_HGT_SMALL + 4 * 2
    local titleFilterWid = getTextManager():MeasureStringX(UIFont.Large, getText("IGUI_UsersList_Filter"))
    local titleFilter = ISLabel:new(self:getWidth()-UI_BORDER_SPACING*2-250-titleFilterWid, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, searchHeight, getText("IGUI_UsersList_Filter"), 1, 1, 1, 1, UIFont.Small, true)
    titleFilter:initialise()
    titleFilter:instantiate()
    self:addChild(titleFilter)

    self.searchEntry = ISTextEntryBox:new("", self:getWidth()-UI_BORDER_SPACING*3-250, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, 150 , searchHeight)
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

    self.close = ISButton:new(self.width - btnWid - (UI_BORDER_SPACING+1)*2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RolesList_Close"), self, ISUsersList.onClick);
    self.close.internal = "CLOSE";
    self.close.anchorTop = false
    self.close.anchorBottom = true
    self.close:initialise();
    self.close:instantiate();
    self.close.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.close);

    local listY = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM+1
    self.datas = ISScrollingListBox:new(UI_BORDER_SPACING+1, FONT_HGT_MEDIUM+(UI_BORDER_SPACING+1)*2, self.width - (UI_BORDER_SPACING+1)*2, self:getHeight() - BUTTON_HGT - (UI_BORDER_SPACING + 1)*4 - FONT_HGT_MEDIUM);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = 3 * FONT_HGT_SMALL + 8
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

function ISUsersList:populateList()
    self.datas:clear();
    local users = getUsers();
    local searchWord = self.searchEntry:getInternalText();
    for i=0,users:size()-1 do
        local user = users:get(i);
        if searchWord == ''
            or (not (searchWord == '') and (
                string.find(user:getUsername(), searchWord) ~= nil)) then
            self.datas:addItem(user:getUsername(), user);
        end
    end
end

function ISUsersList:drawDatas(y, item, alt)
    local a = 0.9;

    --    self.parent.selectedFaction = nil;
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    local color = item.item:getRole():getColor()

    self:drawText(item.item:getUsername(), 12, y + 4, color:getR(), color:getG(), color:getB(), a, UIFont.Medium);
    if item.item:isOnline() then
        self:drawText("Online", 12, y + 4 + FONT_HGT_MEDIUM, 0.1, 1.0, 0.1, a, UIFont.Medium);
    else
        self:drawText("Offline", 12, y + 4 + FONT_HGT_MEDIUM, 0.5, 0.5, 0.5, a, UIFont.Medium);
    end

    if item.item:getWarningPoints() == 0 then
        self:drawText(getText("IGUI_UsersList_WarningPoints", item.item:getWarningPoints()), self:getWidth()- 170, y + 4, 0.3, 1.0, 0.3, a, UIFont.Small);
    elseif item.item:getWarningPoints() < 10 then
        self:drawText(getText("IGUI_UsersList_WarningPoints", item.item:getWarningPoints()), self:getWidth()- 170, y + 4, 1.0, 1.0, 0.3, a, UIFont.Small);
    else
        self:drawText(getText("IGUI_UsersList_WarningPoints", item.item:getWarningPoints()), self:getWidth()- 170, y + 4, 1.0, 0.3, 0.3, a, UIFont.Small);
    end
    if item.item:getSuspicionPoints() == 0 then
        self:drawText(getText("IGUI_UsersList_SuspicionPoints", item.item:getSuspicionPoints()), self:getWidth()- 170, y + 2 + FONT_HGT_SMALL, 0.3, 1.0, 0.3, a, UIFont.Small);
    elseif item.item:getSuspicionPoints() < 10 then
        self:drawText(getText("IGUI_UsersList_SuspicionPoints", item.item:getSuspicionPoints()), self:getWidth()- 170, y + 2 + FONT_HGT_SMALL, 1.0, 1.0, 0.3, a, UIFont.Small);
    else
        self:drawText(getText("IGUI_UsersList_SuspicionPoints", item.item:getSuspicionPoints()), self:getWidth()- 170, y + 2 + FONT_HGT_SMALL, 1.0, 0.3, 0.3, a, UIFont.Small);
    end
    if item.item:getKicks() == 0 then
        self:drawText(getText("IGUI_UsersList_Kicks", item.item:getKicks()), self:getWidth()- 170, y + 1 + 2 * FONT_HGT_SMALL, 0.3, 1.0, 0.3, a, UIFont.Small);
    else
        self:drawText(getText("IGUI_UsersList_Kicks", item.item:getKicks()), self:getWidth()- 170, y + 1 + 2 * FONT_HGT_SMALL, 1.0, 0.3, 0.3, a, UIFont.Small);
    end

    if item.item:isInWhitelist() then
        self:drawText(getText("IGUI_UsersList_DetailsRole", item.item:getRole():getName()), self:getWidth() - 480, y + 4, 1, 1, 1, a, self.font);
        self:drawText(getText("IGUI_UsersList_DetailsLastConnection", item.item:getLastConnection()), self:getWidth() - 480, y + 2 + FONT_HGT_SMALL, 1, 1, 1, a, self.font);
        self:drawText(getText("IGUI_UsersList_DetailsAuthType", item.item:getAuthTypeName()), self:getWidth() - 480, y + 1 + 2 * FONT_HGT_SMALL, 1, 1, 1, a, self.font);
    else
        self:drawText(getText("IGUI_UsersList_DetailsRole", item.item:getRole():getName()), self:getWidth() - 480, y + 4, 1, 1, 1, a, self.font);
        self:drawText(getText("IGUI_UsersList_DetailsNoWhitelist"), self:getWidth() - 480, y + 2 + FONT_HGT_SMALL, 1, 1, 1, a, self.font);
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

function ISUsersList:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_SeeUsers"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_SeeUsers")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
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
        local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - 130, (getCore():getScreenHeight() / 2) - 60, 260, 120, getText("IGUI_RolesList_DeleteRole"), true, ISUsersList.instance, ISUsersList.onDeleteModalClick);
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
        --table.insert(ISPlayerStatsUI.instance.windows, modal);
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
        --table.insert(ISPlayerStatsUI.instance.windows, modal);
    end
    if action == "AddWarningPoint" then
        local modal = ISPlayerStatsWarningPointUI:new(self.x + 200, self.y + 200, 350, 250, item:getUsername(), ISUsersList.onAddWarningPoint);
        modal:initialise();
        modal:addToUIManager();
        --table.insert(ISPlayerStatsUI.instance.windows, modal);
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
    --ISPlayerStatsUI.instance.warningPoint = ISPlayerStatsUI.instance.warningPoint + tonumber(amount);
    --requestUserlog(username);
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
    if self.player:getRole():hasCapability(Capability.ChangeAccessLevel) then
        local setRoleOption = context:addOption('Set Role', worldobjects, nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(setRoleOption, subMenu);
        for i=0,roles:size()-1 do
            local role = roles:get(i);
            subMenu:addOption(getText("IGUI_UserList_SetRole", role:getName()), ISUsersList.instance, ISUsersList.onSetRoleClickOption, item, role:getName());
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
        if getSteamModeActive() then
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
        else
            local banIpButton;
            if item:getIpBanned() ~= nil and item:getIpBanned() ~= '' then
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
    if self.player:getRole():hasCapability(Capability.ModifyNetworkUsers) then
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

--************************************************************************--
--** ISFactionsList:new
--**
--************************************************************************--
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
    ISUsersList.instance = o;
    return o;
end