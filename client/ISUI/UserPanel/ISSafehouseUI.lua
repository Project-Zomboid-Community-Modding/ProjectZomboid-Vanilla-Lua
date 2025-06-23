--***********************************************************
--**              	  ROBERT JOHNSON                       **
--**            UI display with a question or text         **
--**          can display a yes/no button or ok btn        **
--***********************************************************

ISSafehouseUI = ISPanel:derive("ISSafehouseUI");
ISSafehouseUI.messages = {};
ISSafehouseUI.inviteDialogs = {}

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISSafehouseUI:initialise
--**
--************************************************************************--

function ISSafehouseUI:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    self.no = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING-1, 0, btnWid, BUTTON_HGT, getText("UI_Ok"), self, ISSafehouseUI.onClick);
    self.no.internal = "OK";
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.no);

    local nameLbl = ISLabel:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, BUTTON_HGT, getText("IGUI_SafehouseUI_Title"), 1, 1, 1, 1, UIFont.Small, true)
    nameLbl:initialise()
    nameLbl:instantiate()
    self:addChild(nameLbl)

    self.title = ISLabel:new(nameLbl:getRight() + UI_BORDER_SPACING, nameLbl.y, BUTTON_HGT, self.safehouse:getTitle(), 0.6, 0.6, 0.8, 1.0, UIFont.Small, true)
    self.title:initialise()
    self.title:instantiate()
    self:addChild(self.title)

    self.changeTitle = ISButton:new(UI_BORDER_SPACING+1, nameLbl.y, 70, BUTTON_HGT, getText("IGUI_PlayerStats_Change"), self, ISSafehouseUI.onClick);
    self.changeTitle.internal = "CHANGETITLE";
    self.changeTitle:initialise();
    self.changeTitle:instantiate();
    self.changeTitle.borderColor = self.buttonBorderColor;
    self:addChild(self.changeTitle);

    local ownerLbl = ISLabel:new(UI_BORDER_SPACING+1, nameLbl:getBottom() + UI_BORDER_SPACING, FONT_HGT_SMALL, getText("IGUI_SafehouseUI_Owner"), 1, 1, 1, 1, UIFont.Small, true)
    ownerLbl:initialise()
    ownerLbl:instantiate()
    self:addChild(ownerLbl)

    self.owner = ISLabel:new(ownerLbl:getRight() + UI_BORDER_SPACING, ownerLbl.y, FONT_HGT_SMALL, "", 0.6, 0.6, 0.8, 1.0, UIFont.Small, true)
    self.owner:initialise()
    self.owner:instantiate()
    self:addChild(self.owner)

    local posLbl = ISLabel:new(UI_BORDER_SPACING+1, ownerLbl:getBottom() + UI_BORDER_SPACING, FONT_HGT_SMALL, getText("IGUI_SafehouseUI_Pos"), 1, 1, 1, 1, UIFont.Small, true)
    posLbl:initialise()
    posLbl:instantiate()
    self:addChild(posLbl)

    self.pos = ISLabel:new(posLbl:getRight() + UI_BORDER_SPACING, posLbl.y, FONT_HGT_SMALL, getText("IGUI_SafehouseUI_Pos2", self.safehouse:getX(), self.safehouse:getY()), 0.6, 0.6, 0.8, 1.0, UIFont.Small, true)
    self.pos:initialise()
    self.pos:instantiate()
    self:addChild(self.pos)

    local dateCreatedLbl = ISLabel:new(self:getWidth()/2+UI_BORDER_SPACING+1, nameLbl:getBottom() + UI_BORDER_SPACING, FONT_HGT_SMALL, getText("IGUI_SafehouseUI_DateCreated"), 1, 1, 1, 1, UIFont.Small, true)
    dateCreatedLbl:initialise()
    dateCreatedLbl:instantiate()
    self:addChild(dateCreatedLbl)

    self.dateCreated = ISLabel:new(dateCreatedLbl:getRight() + UI_BORDER_SPACING, dateCreatedLbl.y, FONT_HGT_SMALL, self.safehouse:getDatetimeCreatedStr(), 0.6, 0.6, 0.8, 1.0, UIFont.Small, true)
    self.dateCreated:initialise()
    self.dateCreated:instantiate()
    self:addChild(self.dateCreated)

    local locationLbl = ISLabel:new(self:getWidth()/2+UI_BORDER_SPACING+1, dateCreatedLbl:getBottom() + UI_BORDER_SPACING, FONT_HGT_SMALL, getText("IGUI_SafehouseUI_Location"), 1, 1, 1, 1, UIFont.Small, true)
    locationLbl:initialise()
    locationLbl:instantiate()
    self:addChild(locationLbl)

    self.location = ISLabel:new(locationLbl:getRight() + UI_BORDER_SPACING, locationLbl.y, FONT_HGT_SMALL, self.safehouse:getLocation(), 0.6, 0.6, 0.8, 1.0, UIFont.Small, true)
    self.location:initialise()
    self.location:instantiate()
    self:addChild(self.location)

    local pointsLabel = ISLabel:new(UI_BORDER_SPACING+1, posLbl:getBottom() + UI_BORDER_SPACING, FONT_HGT_SMALL, getText("IGUI_SafehouseUI_HitPoints"), 1, 1, 1, 1, UIFont.Small, true)
    pointsLabel:initialise()
    pointsLabel:instantiate()
    self:addChild(pointsLabel)

    self.points = ISLabel:new(pointsLabel:getRight() + UI_BORDER_SPACING, pointsLabel.y, FONT_HGT_SMALL, tostring(self.safehouse:getHitPoints()), 0.6, 0.6, 0.8, 1.0, UIFont.Small, true)
    self.points:initialise()
    self.points:instantiate()
    self:addChild(self.points)

    self.releaseSafehouse = ISButton:new(UI_BORDER_SPACING+1, 0, 70, BUTTON_HGT, getText("IGUI_SafehouseUI_Release"), self, ISSafehouseUI.onClick);
    self.releaseSafehouse.internal = "RELEASE";
    self.releaseSafehouse:initialise();
    self.releaseSafehouse:instantiate();
    self.releaseSafehouse.borderColor = self.buttonBorderColor;
    self:addChild(self.releaseSafehouse);
    self.releaseSafehouse.parent = self;
    self.releaseSafehouse:setVisible(false);

    self.changeOwnership = ISButton:new(0, ownerLbl.y, 70, BUTTON_HGT, getText("IGUI_SafehouseUI_ChangeOwnership"), self, ISSafehouseUI.onClick);
    self.changeOwnership.internal = "CHANGEOWNERSHIP";
    self.changeOwnership:initialise();
    self.changeOwnership:instantiate();
    self.changeOwnership.borderColor = self.buttonBorderColor;
    self:addChild(self.changeOwnership);
    self.changeOwnership.parent = self;
    self.changeOwnership:setVisible(false);

    local playersLbl = ISLabel:new(UI_BORDER_SPACING+1, pointsLabel:getBottom() + UI_BORDER_SPACING, BUTTON_HGT, getText("IGUI_SafehouseUI_Players"), 1, 1, 1, 1, UIFont.Small, true)
    playersLbl:initialise()
    playersLbl:instantiate()
    self:addChild(playersLbl)

    self.refreshPlayerList = ISButton:new(playersLbl:getRight() + UI_BORDER_SPACING, playersLbl.y, 70, BUTTON_HGT, getText("UI_servers_refresh"), self, ISSafehouseUI.onClick);
    self.refreshPlayerList.internal = "REFRESHLIST";
    self.refreshPlayerList:initialise();
    self.refreshPlayerList:instantiate();
    self.refreshPlayerList.borderColor = self.buttonBorderColor;
    self:addChild(self.refreshPlayerList);

    self.playerList = ISScrollingListBox:new(UI_BORDER_SPACING+1, playersLbl:getBottom()+UI_BORDER_SPACING, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT * 8);
    self.playerList:initialise();
    self.playerList:instantiate();
    self.playerList.itemheight = BUTTON_HGT;
    self.playerList.selected = 0;
    self.playerList.joypadParent = self;
    self.playerList.font = UIFont.NewSmall;
    self.playerList.doDrawItem = self.drawPlayers;
    self.playerList.drawBorder = true;
    self:addChild(self.playerList);

    self.removePlayer = ISButton:new(0, self.playerList.y + self.playerList.height + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("ContextMenu_Remove"), self, ISSafehouseUI.onClick);
    self.removePlayer.internal = "REMOVEPLAYER";
    self.removePlayer:initialise();
    self.removePlayer:instantiate();
    self.removePlayer.borderColor = self.buttonBorderColor;
    self.removePlayer:setWidthToTitle(70)
    self.removePlayer:setX(self.playerList:getRight() - self.removePlayer.width)
    self:addChild(self.removePlayer);
    self.removePlayer.enable = false;
    self.removePlayer:setVisible(self:isOwner() or self:hasPrivilegedAccessLevel());

    self.quitSafehouse = ISButton:new(0, self.playerList.y + self.playerList.height + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("IGUI_SafehouseUI_QuitSafehouse"), self, ISSafehouseUI.onClick);
    self.quitSafehouse.internal = "QUITSAFE";
    self.quitSafehouse:initialise();
    self.quitSafehouse:instantiate();
    self.quitSafehouse.borderColor = self.buttonBorderColor;
    self.quitSafehouse:setWidthToTitle(70)
    self.quitSafehouse:setX(self.playerList:getRight() - self.quitSafehouse.width)
    if self:hasPrivilegedAccessLevel() then
        self.quitSafehouse:setY(self.removePlayer.y + BUTTON_HGT + 5)
    end
    self:addChild(self.quitSafehouse);
    self.quitSafehouse:setVisible(not self:isOwner() and self.safehouse:getPlayers():contains(self.player:getUsername()));

    self.addPlayer = ISButton:new(self.playerList.x, self.playerList.y + self.playerList.height + UI_BORDER_SPACING, 70, BUTTON_HGT, getText("IGUI_SafehouseUI_AddPlayer"), self, ISSafehouseUI.onClick);
    self.addPlayer.internal = "ADDPLAYER";
    self.addPlayer:initialise();
    self.addPlayer:instantiate();
    self.addPlayer.borderColor = self.buttonBorderColor;
    self:addChild(self.addPlayer);

    self.respawn = ISTickBox:new(UI_BORDER_SPACING+1, self.addPlayer:getBottom() + UI_BORDER_SPACING, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_SafehouseUI_Respawn")) + 20, 18, "", self, ISSafehouseUI.onClickRespawn);
    self.respawn:initialise();
    self.respawn:instantiate();
    self.respawn.selected[1] = self.safehouse:isRespawnInSafehouse(self.player:getUsername());
    self.respawn:addOption(getText("IGUI_SafehouseUI_Respawn"));
    self:addChild(self.respawn);
    self.respawn.safehouseUI = self;
    if not getServerOptions():getBoolean("SafehouseAllowRespawn") then
        self.respawn.enable = false;
    end

    self.no:setY(self.respawn:getBottom() + UI_BORDER_SPACING)
    self.releaseSafehouse:setY(self.respawn:getBottom() + UI_BORDER_SPACING)
    self:setHeight(self.no:getBottom() + UI_BORDER_SPACING+1)

    self:populateList();

end

function ISSafehouseUI:onClickRespawn(clickedOption, enabled)
    sendSafehouseChangeRespawn(self.safehouse, self.player:getUsername(), enabled)
end

function ISSafehouseUI:populateList()
    local selected = self.playerList.selected;
    self.playerList:clear();
    for i=0,self.safehouse:getPlayers():size()-1 do
--        if self.safehouse:getPlayers():get(i) ~= self.player:getUsername() then
            local newPlayer = {};
            newPlayer.name = self.safehouse:getPlayers():get(i);
            if newPlayer.name ~= self.safehouse:getOwner() then
                self.playerList:addItem(newPlayer.name, newPlayer);
            end;
--        end
    end;
    self.playerList.selected = math.min(selected, #self.playerList.items);
end

function ISSafehouseUI:drawPlayers(y, item, alt)
    local a = 0.9;

--    self.parent.removePlayer.enable = false;
--    self.parent.selectedPlayer = nil;
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

--    self:drawRect(100, y-1, 1, self.itemheight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
--    self:drawRect(170, y-1, 1, self.itemheight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);
--    self:drawRect(240, y-1, 1, self.itemheight,1,self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
--        if self.parent.isOwner then
--            self.parent.removePlayer.enable = true;
--        end
--        self.parent.selectedPlayer = item.item.name;
    end

    self:drawText(item.item.name, 10, y + 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ISSafehouseUI:render()
    self:updateButtons();

    self.removePlayer.enable = false;
    if self.playerList.selected > 0 then
        self.removePlayer.enable = self:isOwner() or self:hasPrivilegedAccessLevel();
        self.selectedPlayer = self.playerList.items[self.playerList.selected].item.name;
        if self.selectedPlayer == self.player:getUsername() or self.selectedPlayer == self.safehouse:getOwner() then
            self.removePlayer.enable = false;
        end
    else
        self.selectedPlayer = nil;
    end

    self:updatePlayerList();
end

function ISSafehouseUI:prerender()
    ISSafehouseUI.instance = self  -- to support reloading in lua debugger
    
    local z = 20;
    local splitPoint = 100;
    local x = 10;
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
--    self:drawText(self.safehouse:getTitle(), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, self.safehouse:getTitle()) / 2), z, 1,1,1,1, UIFont.Medium);
    self.title:setName(self.safehouse:getTitle())
    self.changeTitle:setX(self.title:getRight() + UI_BORDER_SPACING)
    z = z + 30;
--    self:drawText(getText("IGUI_SafehouseUI_Owner"), x, z, 1,1,1,1, UIFont.Small);
--    self:drawText(self.safehouse:getOwner(), splitPoint, z, 1,1,1,1, UIFont.Small);
    self.owner:setName(self.safehouse:getOwner())
    if self:isOwner() or self:hasPrivilegedAccessLevel() then
        self.releaseSafehouse:setVisible(true);
        self.changeOwnership:setVisible(true);
        self.changeOwnership:setX(self.owner:getRight() + UI_BORDER_SPACING);
    end
    if self:hasPrivilegedAccessLevel() then
        self.quitSafehouse:setY(self.removePlayer.y + FONT_HGT_SMALL + UI_BORDER_SPACING)
    else
        self.quitSafehouse:setY(self.playerList.y + self.playerList.height + UI_BORDER_SPACING)
    end
--    self:drawText(getText("IGUI_SafehouseUI_Players"), x, self.playerList.y - FONT_HGT_SMALL, 1,1,1,1, UIFont.Small);
end

function ISSafehouseUI:updatePlayerList()
    self.updateTick = self.updateTick + 1;
    if self.updateTick >= self.updateTickMax then
        self:populateList();
        self.updateTick = 0;
    end;
end

function ISSafehouseUI:updateButtons()
    local isOwner = self:isOwner();
    local hasPrivilegedAccessLevel = self:hasPrivilegedAccessLevel();
    self.releaseSafehouse:setVisible(isOwner or hasPrivilegedAccessLevel);
    self.changeOwnership:setVisible(isOwner or hasPrivilegedAccessLevel);
    self.removePlayer.enable = isOwner or hasPrivilegedAccessLevel;
    self.addPlayer.enable = isOwner or hasPrivilegedAccessLevel;
    self.changeTitle.enable = isOwner or hasPrivilegedAccessLevel;
    self.quitSafehouse:setVisible(not isOwner and self.safehouse:getPlayers():contains(self.player:getUsername()));
end

function ISSafehouseUI:onClick(button)
    if button.internal == "OK" then
        self:close();
    end
    if button.internal == "RELEASE" then
        local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_SafehouseUI_ReleaseConfirm", self.selectedPlayer), true, nil, ISSafehouseUI.onReleaseSafehouse);
        modal:initialise()
        modal:addToUIManager()
        modal.ui = self;
        modal.moveWithMouse = true;
    end
    if button.internal == "REMOVEPLAYER" then
        local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_SafehouseUI_RemoveConfirm", self.selectedPlayer), true, nil, ISSafehouseUI.onRemovePlayerFromSafehouse);
        modal:initialise()
        modal:addToUIManager()
        modal.ui = self;
        modal.moveWithMouse = true;
    end
    if button.internal == "ADDPLAYER" then
        local safehouseUI = ISSafehouseAddPlayerUI:new(getCore():getScreenWidth() / 2 - 200,getCore():getScreenHeight() / 2 - 175, 400, 350, self.safehouse, self.player);
        safehouseUI:initialise()
        safehouseUI:addToUIManager()
        safehouseUI.safehouseUI = self;
        self.addPlayerUI = safehouseUI;
    end
    if button.internal == "CHANGETITLE" then
        local modal = ISTextBox:new(self.x + 200, 200, 280, 180, getText("IGUI_SafehouseUI_ChangeTitle"), self.safehouse:getTitle(), nil, ISSafehouseUI.onChangeTitle);
        modal.safehouse = self.safehouse;
        modal:initialise();
        modal:addToUIManager();
    end
    if button.internal == "CHANGEOWNERSHIP" then
        local safehouseUI = ISSafehouseAddPlayerUI:new(getCore():getScreenWidth() / 2 - 200,getCore():getScreenHeight() / 2 - 175, 400, 350, self.safehouse, self.player);
        safehouseUI.changeOwnership = true;
        safehouseUI:initialise()
        safehouseUI:addToUIManager()
        safehouseUI.safehouseUI = self;
    end
    if button.internal == "QUITSAFE" then
        local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_SafehouseUI_QuitSafeConfirm", self.selectedPlayer), true, nil, ISSafehouseUI.onQuitSafehouse);
        modal:initialise()
        modal:addToUIManager()
        modal.ui = self;
        modal.moveWithMouse = true;
    end
    if button.internal == "REFRESHLIST" then
        self:populateList();
    end;
end

function ISSafehouseUI:close()
    self:setVisible(false)
    self:removeFromUIManager()
    ISSafehouseUI.instance = nil
end

function ISSafehouseUI:onChangeTitle(button)
    if button.internal == "OK" then
        sendSafehouseChangeTitle(button.parent.safehouse, button.parent.entry:getText())
    end
end

function ISSafehouseUI:onQuitSafehouse(button)
    if button.internal == "YES" then
        sendSafehouseChangeMember(button.parent.ui.safehouse, button.parent.ui.player:getUsername())
    end
    button.parent.ui:close();
end

function ISSafehouseUI:onRemovePlayerFromSafehouse(button, player)
    if button.internal == "YES" then
        sendSafehouseChangeMember(button.parent.ui.safehouse, button.parent.ui.selectedPlayer)
        button.parent.ui:populateList();
    end
end

function ISSafehouseUI:onReleaseSafehouse(button, player)
    if button.internal == "YES" then
        if button.parent.ui:isOwner() or button.parent.ui:hasPrivilegedAccessLevel() then
            sendSafehouseRelease(button.parent.ui.safehouse)
        end;
    end;
    button.parent.ui:close();
end

--************************************************************************--
--** ISSafehouseUI:new
--**
--************************************************************************--
function ISSafehouseUI:new(x, y, width, height, safehouse, player)
    local o = {}
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    if y == 0 then
        o.y = o:getMouseY() - (height / 2)
        o:setY(o.y)
    end
    if x == 0 then
        o.x = o:getMouseX() - (width / 2)
        o:setX(o.x)
    end
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.player = player;
    o.safehouse = safehouse;
    o.moveWithMouse = true;
    ISSafehouseUI.instance = o;
    o.updateTick = 0;
    o.updateTickMax = 120;
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    return o;
end

function ISSafehouseUI:isOwner()
    return self.safehouse:isOwner(self.player)
end

function ISSafehouseUI:hasPrivilegedAccessLevel()
    return self.player:getRole():hasCapability(Capability.CanSetupSafehouses);
end

function ISSafehouseUI.OnSafehousesChanged()
    if ISSafehouseUI.instance then
        local safehouse = ISSafehouseUI.instance.safehouse
        if not SafeHouse.getSafehouseList():contains(safehouse) then
            ISSafehouseUI.instance:close()
        else
            ISSafehouseUI.instance:populateList();
        end
    end
end

ISSafehouseUI.ReceiveSafehouseInvite = function(safehouse, host)
    if ISSafehouseUI.inviteDialogs[host] then
        if ISSafehouseUI.inviteDialogs[host]:isReallyVisible() then return end
        ISSafehouseUI.inviteDialogs[host] = nil
    end

    if not SafeHouse.hasSafehouse(getPlayer()) then
        local modal = ISModalDialog:new(getCore():getScreenWidth() / 2 - 175,getCore():getScreenHeight() / 2 - 75, 350, 150, getText("IGUI_SafehouseUI_Invitation", host), true, nil, ISSafehouseUI.onAnswerSafehouseInvite);
        modal:initialise()
        modal:addToUIManager()
        modal.safehouse = safehouse;
        modal.host = host;
        modal.moveWithMouse = true;
        ISSafehouseUI.inviteDialogs[host] = modal
    end
end

function ISSafehouseUI:onAnswerSafehouseInvite(button)
    ISSafehouseUI.inviteDialogs[button.parent.host] = nil
    if button.internal == "YES" then
        acceptSafehouseInvite(button.parent.safehouse, button.parent.host, getPlayer(), true)
    end
    if button.internal == "NO" then
        acceptSafehouseInvite(button.parent.safehouse, button.parent.host, getPlayer(), false)
    end
end

ISSafehouseUI.AcceptedSafehouseInvite = function(safehouseName, host)
    if ISSafehouseUI.instance and ISSafehouseUI.instance:isVisible() and safehouseName == ISSafehouseUI.instance.safehouse:getTitle() then
        if ISSafehouseUI.instance.addPlayerUI and ISSafehouseUI.instance.addPlayerUI:isVisible() then
            ISSafehouseUI.instance.addPlayerUI:populateList();
        end
        ISSafehouseUI.instance:populateList();
    end
end

Events.OnSafehousesChanged.Add(ISSafehouseUI.OnSafehousesChanged)
Events.ReceiveSafehouseInvite.Add(ISSafehouseUI.ReceiveSafehouseInvite);
Events.AcceptedSafehouseInvite.Add(ISSafehouseUI.AcceptedSafehouseInvite);