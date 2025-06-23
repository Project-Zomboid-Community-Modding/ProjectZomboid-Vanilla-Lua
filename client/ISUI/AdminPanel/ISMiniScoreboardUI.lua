--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISMiniScoreboardUI = ISPanel:derive("ISMiniScoreboardUI");
ISMiniScoreboardUI.messages = {};

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISMiniScoreboardUI:initialise
--**
--************************************************************************--

function ISMiniScoreboardUI:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    self.no = ISButton:new(self.width - UI_BORDER_SPACING - btnWid - 1, self.height- UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("UI_btn_close"), self, ISMiniScoreboardUI.onClick);
    self.no.internal = "CLOSE";
    self.no.anchorTop = false
    self.no.anchorBottom = true
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=0.4, g=0.4, b=0.4, a=0.9};
    self:addChild(self.no);

    local y = UI_BORDER_SPACING*2+1 + FONT_HGT_SMALL
    self.playerList = ISScrollingListBox:new(UI_BORDER_SPACING+1, y, self.width - (UI_BORDER_SPACING+1)*2, self.no.y - y - UI_BORDER_SPACING - 1);
    self.playerList:initialise();
    self.playerList:instantiate();
    self.playerList.itemheight = BUTTON_HGT;
    self.playerList.selected = 0;
    self.playerList.joypadParent = self;
    self.playerList.font = UIFont.NewSmall;
    self.playerList.doDrawItem = self.drawPlayers;
    self.playerList.drawBorder = true;
    self.playerList.onRightMouseUp = ISMiniScoreboardUI.onRightMousePlayerList;
    self:addChild(self.playerList);

    scoreboardUpdate()
end

function ISMiniScoreboardUI:onRightMousePlayerList(x, y)
    local row = self:rowAt(x, y)
    if row < 1 or row > #self.items then return end
    self.selected = row
    local scoreboard = self.parent
    scoreboard:doPlayerListContextMenu(self.items[row].item, self:getX() + x, self:getY() + y)
end

function ISMiniScoreboardUI:doPlayerListContextMenu(player, x,y)
    local playerNum = self.admin:getPlayerNum()
    local context = ISContextMenu.get(playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY());
    if self.admin:getRole():hasCapability(Capability.TeleportToPlayer) then
        context:addOption(getText("UI_Scoreboard_Teleport"), self, ISMiniScoreboardUI.onCommand, player, "TELEPORT");
    end
    if self.admin:getRole():hasCapability(Capability.TeleportPlayerToAnotherPlayer) then
        context:addOption(getText("UI_Scoreboard_TeleportToYou"), self, ISMiniScoreboardUI.onCommand, player, "TELEPORTTOYOU");
    end
    if self.admin:getRole():hasCapability(Capability.ToggleInvisibleEveryone) then
        context:addOption(getText("UI_Scoreboard_Invisible"), self, ISMiniScoreboardUI.onCommand, player, "INVISIBLE");
    end
    if self.admin:getRole():hasCapability(Capability.ToggleGodModEveryone) then
        context:addOption(getText("UI_Scoreboard_GodMod"), self, ISMiniScoreboardUI.onCommand, player, "GODMOD");
    end
    if self.admin:getRole():hasCapability(Capability.CanSeePlayersStats) then
        context:addOption("Check Stats", self, ISMiniScoreboardUI.onCommand, player, "STATS");
    end
end

function ISMiniScoreboardUI:onCommand(player, command)
    if command == "TELEPORT" then
        SendCommandToServer("/teleport \"" .. player.displayName .. "\"");
    elseif command == "TELEPORTTOYOU" then
        SendCommandToServer("/teleportplayer \"" .. player.displayName .. "\" \"" .. self.admin:getDisplayName() .. "\"");
    elseif command == "INVISIBLE" then
        SendCommandToServer("/invisibleplayer \"" .. player.displayName .. "\"");
    elseif command == "GODMOD" or command == "GODMODE" then
        SendCommandToServer("/godmodplayer \"" .. player.displayName .. "\"");
    elseif command == "STATS" then
        local playerObj = getPlayerFromUsername(player.username)
        if not playerObj then return end -- player hasn't been encountered yet
        local ui = ISPlayerStatsUI:new(50,50,800,800, playerObj, self.admin)
        ui:initialise();
        ui:addToUIManager();
        ui:setVisible(true);
    end
end

function ISMiniScoreboardUI:populateList()
    self.playerList:clear();
    if not self.scoreboard then return end
    for i=1,self.scoreboard.usernames:size() do
        local username = self.scoreboard.usernames:get(i-1)
        local displayName = self.scoreboard.displayNames:get(i-1)
        if username ~= self.admin:getUsername() then
            local item = {}
            local name = displayName
            item.username = username
            item.displayName = displayName
--            if username ~= displayName then
--                name = displayName .. " (" .. username .. ")";
--            end
            local item0 = self.playerList:addItem(name, item);
            if username ~= displayName then
                item0.tooltip = username
            end
        end
    end
end

function ISMiniScoreboardUI:drawPlayers(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    self:drawText(item.text, 10, y + 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ISMiniScoreboardUI:prerender()
    local z = 10;
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_MiniScoreboard"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_AdminPanel_MiniScoreboard")) / 2), z, 1,1,1,1, UIFont.Small);
end

function ISMiniScoreboardUI:onClick(button)
    if button.internal == "CLOSE" then
        self:close()
    end
end

function ISMiniScoreboardUI:close()
    self:setVisible(false)
    self:removeFromUIManager()
    ISMiniScoreboardUI.instance = nil
end

--************************************************************************--
--** ISMiniScoreboardUI:new
--**
--************************************************************************--
function ISMiniScoreboardUI:new(x, y, width, height, admin)
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
    o.admin = admin;
    o.moveWithMouse = true;
    o.scoreboard = nil
    ISMiniScoreboardUI.instance = o;
    return o;
end

function ISMiniScoreboardUI.onScoreboardUpdate(usernames, displayNames, steamIDs)
    if ISMiniScoreboardUI.instance then
        ISMiniScoreboardUI.instance.scoreboard = {}
        ISMiniScoreboardUI.instance.scoreboard.usernames = usernames
        ISMiniScoreboardUI.instance.scoreboard.displayNames = displayNames
        ISMiniScoreboardUI.instance.scoreboard.steamIDs = steamIDs
        ISMiniScoreboardUI.instance:populateList();
    end
end

ISMiniScoreboardUI.OnMiniScoreboardUpdate = function()
    if ISMiniScoreboardUI.instance then
        scoreboardUpdate()
    end
end

Events.OnScoreboardUpdate.Add(ISMiniScoreboardUI.onScoreboardUpdate)
Events.OnMiniScoreboardUpdate.Add(ISMiniScoreboardUI.OnMiniScoreboardUpdate)
