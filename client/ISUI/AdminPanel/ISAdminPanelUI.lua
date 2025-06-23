--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 21/09/16
-- Time: 10:19
-- To change this template use File | Settings | File Templates.
--

--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "ISUI/ISPanel"

ISAdminPanelUI = ISPanel:derive("ISAdminPanelUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISAdminPanelUI:initialise()
    ISPanel.initialise(self);
    self:create();
end


function ISAdminPanelUI:setVisible(visible)
    --    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
end

function ISAdminPanelUI:render()
    self:drawText(getText("IGUI_AdminPanel_AdminPanel"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_AdminPanel")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
end

function ISAdminPanelUI:create()
    local btnWid = 200;
    local x = UI_BORDER_SPACING+1;
    local y = FONT_HGT_MEDIUM + UI_BORDER_SPACING*2 + 1;

    -- the position of all the buttons will be sorted later

    self.checkStatsBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_CheckYourStats"), self, ISAdminPanelUI.onOptionMouseDown);
    self.checkStatsBtn.internal = "CHECKSTATS";
    self.checkStatsBtn:initialise();
    self.checkStatsBtn:instantiate();
    self.checkStatsBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.checkStatsBtn);

    self.adminPowerBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_AdminPower"), self, ISAdminPanelUI.onOptionMouseDown);
    self.adminPowerBtn.internal = "ADMINPOWER";
    self.adminPowerBtn:initialise();
    self.adminPowerBtn:instantiate();
    self.adminPowerBtn.borderColor = self.buttonBorderColor;
    self.adminPowerBtn.tooltip = getText("IGUI_AdminPanel_TooltipEditAdminPower");
    self:addChild(self.adminPowerBtn);

    self.itemListBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_ItemList"), self, ISAdminPanelUI.onOptionMouseDown);
    self.itemListBtn.internal = "ITEMLIST";
    self.itemListBtn:initialise();
    self.itemListBtn:instantiate();
    self.itemListBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.itemListBtn);

    self.seeOptionsBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_SeeServerOptions"), self, ISAdminPanelUI.onOptionMouseDown);
    self.seeOptionsBtn.internal = "SEEOPTIONS";
    self.seeOptionsBtn:initialise();
    self.seeOptionsBtn:instantiate();
    self.seeOptionsBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.seeOptionsBtn);

    self.nonpvpzoneBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_NonPvpZone"), self, ISAdminPanelUI.onOptionMouseDown);
    self.nonpvpzoneBtn.internal = "NONPVPZONE";
    self.nonpvpzoneBtn:initialise();
    self.nonpvpzoneBtn:instantiate();
    self.nonpvpzoneBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.nonpvpzoneBtn);

    self.seeFactionBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_SeeFaction") .. " (" .. Faction.getFactions():size() ..")", self, ISAdminPanelUI.onOptionMouseDown);
    self.seeFactionBtn.internal = "SEEFACTIONS";
    self.seeFactionBtn:initialise();
    self.seeFactionBtn:instantiate();
    self.seeFactionBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.seeFactionBtn);

    self.seeRolesBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_SeeRoles"), self, ISAdminPanelUI.onOptionMouseDown);
    self.seeRolesBtn.internal = "SEEROLES";
    self.seeRolesBtn:initialise();
    self.seeRolesBtn:instantiate();
    self.seeRolesBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.seeRolesBtn);

    self.seeUsersBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_SeeUsers"), self, ISAdminPanelUI.onOptionMouseDown);
    self.seeUsersBtn.internal = "SEEUSERS";
    self.seeUsersBtn:initialise();
    self.seeUsersBtn:instantiate();
    self.seeUsersBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.seeUsersBtn);

    self.seeSafehousesBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_SeeSafehouses") .. " (".. SafeHouse.getSafehouseList():size() .. ")", self, ISAdminPanelUI.onOptionMouseDown);
    self.seeSafehousesBtn.internal = "SEESAFEHOUSES";
    self.seeSafehousesBtn:initialise();
    self.seeSafehousesBtn:instantiate();
    self.seeSafehousesBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.seeSafehousesBtn);

    self.safezoneBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_Safezone"), self, ISAdminPanelUI.onOptionMouseDown);
    self.safezoneBtn.internal = "SAFEZONE";
    self.safezoneBtn:initialise();
    self.safezoneBtn:instantiate();
    self.safezoneBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.safezoneBtn);

    self.seeTicketsBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_SeeTickets"), self, ISAdminPanelUI.onOptionMouseDown);
    self.seeTicketsBtn.internal = "SEETICKETS";
    self.seeTicketsBtn:initialise();
    self.seeTicketsBtn:instantiate();
    self.seeTicketsBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.seeTicketsBtn);

    self.miniScoreboardBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_MiniScoreboard"), self, ISAdminPanelUI.onOptionMouseDown);
    self.miniScoreboardBtn.internal = "MINISCOREBOARD";
    self.miniScoreboardBtn:initialise();
    self.miniScoreboardBtn:instantiate();
    self.miniScoreboardBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.miniScoreboardBtn);
    self.miniScoreboardBtn.tooltip = getText("IGUI_AdminPanel_TooltipMiniScoreboard");

    self.packetCountsBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_PacketCounts"), self, ISAdminPanelUI.onOptionMouseDown)
    self.packetCountsBtn.internal = "PACKETCOUNTS"
    self.packetCountsBtn:initialise()
    self.packetCountsBtn:instantiate()
    self.packetCountsBtn.borderColor = self.buttonBorderColor
    self:addChild(self.packetCountsBtn)
    self.packetCountsBtn.tooltip = getText("IGUI_AdminPanel_TooltipPacketCounts")

    self.sandboxOptionsBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_SandboxOptions"), self, ISAdminPanelUI.onOptionMouseDown)
    self.sandboxOptionsBtn.internal = "SANDBOX"
    self.sandboxOptionsBtn:initialise()
    self.sandboxOptionsBtn:instantiate()
    self.sandboxOptionsBtn.borderColor = self.buttonBorderColor
    self:addChild(self.sandboxOptionsBtn)
    self.sandboxOptionsBtn.tooltip = getTextOrNull("IGUI_AdminPanel_TooltipSandboxOptions")

    self.climateOptionsBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_Adm_Weather_ClimateControl"), self, ISAdminPanelUI.onOptionMouseDown)
    self.climateOptionsBtn.internal = "CLIMATE"
    self.climateOptionsBtn:initialise()
    self.climateOptionsBtn:instantiate()
    self.climateOptionsBtn.borderColor = self.buttonBorderColor
    self:addChild(self.climateOptionsBtn)
    self.climateOptionsBtn.tooltip = getTextOrNull("IGUI_AdminPanel_TooltipClimateOptions")

    self.showStatisticsBtn = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_ShowStatistics"), self, ISAdminPanelUI.onOptionMouseDown)
    self.showStatisticsBtn.internal = "STATISTICS"
    self.showStatisticsBtn:initialise()
    self.showStatisticsBtn:instantiate()
    self.showStatisticsBtn.borderColor = self.buttonBorderColor
    self:addChild(self.showStatisticsBtn)
    self.showStatisticsBtn.tooltip = getTextOrNull("IGUI_AdminPanel_TooltipShowStatistics")

    self.pvpLogTool = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_PVPLogTool"), self, ISAdminPanelUI.onOptionMouseDown)
    self.pvpLogTool.internal = "PVPLOGTOOL"
    self.pvpLogTool:initialise()
    self.pvpLogTool:instantiate()
    self.pvpLogTool.borderColor = self.buttonBorderColor
    self:addChild(self.pvpLogTool)
    self.pvpLogTool.tooltip = getTextOrNull("IGUI_AdminPanel_PVPLogTool")

    self.zoneEditor = ISButton:new(x, y, btnWid, BUTTON_HGT, getText("IGUI_AdminPanel_ZoneEditor"), self, ISAdminPanelUI.onOptionMouseDown)
    self.zoneEditor.internal = "ZONE_EDITOR"
    self.zoneEditor:initialise()
    self.zoneEditor:instantiate()
    self.zoneEditor.borderColor = self.buttonBorderColor
    self:addChild(self.zoneEditor)
    self.zoneEditor.tooltip = getTextOrNull("IGUI_AdminPanel_ZoneEditor")

    local width = 0
    local bottom = 0
    local buttonValue = 0 --this is used to distribute the buttons evenly left and right to make two evenly sized columns
    local columnCount = 2 --number of columns the box should have
    local buttons = {}

    for _,child in pairs(self:getChildren()) do
        width = math.max(width, child:getWidth())
        table.insert(buttons, child) --insert into table for sorting alphabetically
    end

    --for some reason, sorting A-Z makes the options appear Z-A, so i reversed the sorting.
    table.sort(buttons, function(a, b) return string.sort(b.title, a.title) end)

    --fix the positions of all the buttons and sizes
    for _,child in ipairs(buttons) do
        child:setWidth(width)
        child:setX(x+math.fmod(buttonValue, columnCount)*(width+UI_BORDER_SPACING))
        child:setY(y+math.floor(buttonValue/columnCount)*(BUTTON_HGT + UI_BORDER_SPACING))
        bottom = math.max(bottom, child:getBottom())
        buttonValue = buttonValue + 1;
    end

    self:setWidth(x*2 + width*columnCount + UI_BORDER_SPACING*(columnCount-1))
    
    self.cancel = ISButton:new((self:getWidth() - btnWid) / 2, bottom + UI_BORDER_SPACING, btnWid, BUTTON_HGT, getText("UI_btn_close"), self, ISAdminPanelUI.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel.borderColor = self.buttonBorderColor;
    self:addChild(self.cancel);

    self:setHeight(self.cancel:getBottom() + UI_BORDER_SPACING+1)

    self:updateButtons();
end

function ISAdminPanelUI:updateButtons()
    local enabled = false;

    self.checkStatsBtn.enable = getPlayer():getRole():hasCapability(Capability.CanSeePlayersStats);
    enabled = enabled or self.checkStatsBtn.enable
    self.adminPowerBtn.enable = getPlayer():getRole():hasAdminPower();
    enabled = enabled or self.adminPowerBtn.enable
    self.itemListBtn.enable = getPlayer():getRole():hasCapability(Capability.AddItem);
    enabled = enabled or self.itemListBtn.enable
    self.seeOptionsBtn.enable = getPlayer():getRole():hasCapability(Capability.SeePublicServerOptions);
    enabled = enabled or self.seeOptionsBtn.enable
    self.nonpvpzoneBtn.enable = getPlayer():getRole():hasCapability(Capability.CanSetupNonPVPZone);
    enabled = enabled or self.nonpvpzoneBtn.enable
    self.seeFactionBtn.enable = getPlayer():getRole():hasCapability(Capability.FactionCheat);
    enabled = enabled or self.seeFactionBtn.enable
    self.seeRolesBtn.enable = getPlayer():getRole():hasCapability(Capability.RolesRead);
    enabled = enabled or self.seeRolesBtn.enable
    self.seeUsersBtn.enable = getPlayer():getRole():hasCapability(Capability.SeeNetworkUsers);
    enabled = enabled or self.seeUsersBtn.enable
    self.seeSafehousesBtn.enable = getPlayer():getRole():hasCapability(Capability.CanSetupSafehouses);
    enabled = enabled or self.seeSafehousesBtn.enable
    self.safezoneBtn.enable = getPlayer():getRole():hasCapability(Capability.CanSetupSafehouses);
    enabled = enabled or self.safezoneBtn.enable
    self.seeTicketsBtn.enable = getPlayer():getRole():hasCapability(Capability.AnswerTickets);
    enabled = enabled or self.seeTicketsBtn.enable
    self.miniScoreboardBtn.enable = getPlayer():getRole():hasCapability(Capability.GetSteamScoreboard);
    enabled = enabled or self.miniScoreboardBtn.enable
    self.packetCountsBtn.enable = getPlayer():getRole():hasCapability(Capability.GetStatistic);
    enabled = enabled or self.packetCountsBtn.enable
    self.sandboxOptionsBtn.enable = getPlayer():getRole():hasCapability(Capability.SandboxOptions);
    enabled = enabled or self.sandboxOptionsBtn.enable
    self.climateOptionsBtn.enable = getPlayer():getRole():hasCapability(Capability.ClimateManager);
    enabled = enabled or self.climateOptionsBtn.enable
    self.showStatisticsBtn.enable = getPlayer():getRole():hasCapability(Capability.GetStatistic);
    enabled = enabled or self.showStatisticsBtn.enable
    self.pvpLogTool.enable = getPlayer():getRole():hasCapability(Capability.PVPLogTool);
    enabled = enabled or self.pvpLogTool.enable
    self.zoneEditor.enable = getPlayer():getRole():hasCapability(Capability.CanSetupSafehouses) or getPlayer():getRole():hasCapability(Capability.CanSetupNonPVPZone);
    enabled = enabled or self.zoneEditor.enable

    if not enabled then
        self:close()
    end
end

function ISAdminPanelUI:onOptionMouseDown(button, x, y)
    if button.internal == "ADMINPOWER" then
        if ISAdminPowerUI.instance then
            ISAdminPowerUI.instance:close()
        end
        local modal = ISAdminPowerUI:new(50, 200, 480, 350, getPlayer())
        modal:initialise();
        modal:addToUIManager();
    end
    if button.internal == "ITEMLIST" then
        if ISItemsListViewer.instance then
            ISItemsListViewer.instance:close()
        end
        local modal = ISItemsListViewer:new(50, 200, 1050+(getCore():getOptionFontSizeReal()*50), 650+(getCore():getOptionFontSizeReal()*50), getPlayer())
        modal:initialise();
        modal:addToUIManager();
    end
    if button.internal == "BUILDCHEAT" then
        ISBuildMenu.cheat = not ISBuildMenu.cheat;
        if ISBuildMenu.cheat then
            self.buildCheatBtn.title = getText("IGUI_AdminPanel_DisableBuildCheat");
        else
            self.buildCheatBtn.title = getText("IGUI_AdminPanel_EnableBuildCheat");
        end
    end
    if button.internal == "CHECKSTATS" then
        if ISPlayerStatsUI.instance then
            ISPlayerStatsUI.instance:close()
        end
        local ui = ISPlayerStatsUI:new(50,50,800+(getCore():getOptionFontSizeReal()*50),800, getPlayer(), getPlayer())
        ui:initialise();
        ui:addToUIManager();
        ui:setVisible(true);
    end
    if button.internal == "SEEOPTIONS" then
        if ISServerOptions.instance then
            ISServerOptions.instance:close()
        end
        local ui = ISServerOptions:new(50,50,900,800, getPlayer())
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "SEEFACTIONS" then
        if ISFactionsList.instance then
            ISFactionsList.instance:close()
        end
        local ui = ISFactionsList:new(50,50,600,600, getPlayer());
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "SEEROLES" then
        requestRoles()
        if ISRolesList.instance then
            ISRolesList.instance:closeModal()
        end
        local ui = ISRolesList:new(50,50,600,800, getPlayer());
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "SEEUSERS" then
        requestUsers()
        if ISUsersList.instance then
            ISUsersList.instance:closeModal()
        end
        local ui = ISUsersList:new(50,50,800,600, getPlayer());
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "SEESAFEHOUSES" then
        if ISSafehousesList.instance then
            ISSafehousesList.instance:close()
        end
        local ui = ISSafehousesList:new(50,50,600,600, getPlayer());
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "NONPVPZONE" then
        if ISPvpZonePanel.instance then
            ISPvpZonePanel.instance:close()
        end
        local ui = ISPvpZonePanel:new(50,50,600,600, getPlayer());
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "SAFEZONE" then
        if ISAddSafeZoneUI.instance then
            ISAddSafeZoneUI.instance:close();
        end
        local ui = ISAddSafeZoneUI:new(getCore():getScreenWidth() / 2 - 210, getCore():getScreenHeight() / 2 - 200, 300+(getCore():getOptionFontSizeReal()*50), 400, getPlayer());
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "SEETICKETS" then
        if ISAdminTicketsUI.instance then
            ISAdminTicketsUI.instance:close()
        end
        local ui = ISAdminTicketsUI:new(50,50,900,600, getPlayer());
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "MINISCOREBOARD" then
        if ISMiniScoreboardUI.instance then
            ISMiniScoreboardUI.instance:close()
        end
        local ui = ISMiniScoreboardUI:new(50,50,300,300, getPlayer());
        ui:initialise();
        ui:addToUIManager();
    end
    if button.internal == "PACKETCOUNTS" then
        if ISPacketCounts.instance then
            ISPacketCounts.instance:closeSelf()
        end
        local ui = ISPacketCounts:new(50, 50, 570, 630, getPlayer())
        ui:initialise()
        ui:addToUIManager()
    end
    if button.internal == "SANDBOX" then
        if ISServerSandboxOptionsUI.instance then
            ISServerSandboxOptionsUI.instance:close()
        end
        local ui = ISServerSandboxOptionsUI:new(150, 150,800, 600)
        ui:initialise()
        ui:addToUIManager()
    end
    if button.internal == "CLIMATE" then
        --local ui = ISAdminWeather:new(150, 150,800, 600, getPlayer())
        --ui:initialise()
        --ui:addToUIManager()
        local ui = ISAdminWeather.OnOpenPanel();
        ui:onMadeActive();
    end
    if button.internal == "STATISTICS" then
        if ISStatisticsUI.instance then
            ISStatisticsUI.instance:close()
        end
        local ui = ISStatisticsUI:new(50, 50, getPlayer())
        ui:initialise()
        ui:addToUIManager()
    end
    if button.internal == "PVPLOGTOOL" then
        if ISPVPLogToolUI.instance then
            ISPVPLogToolUI.instance:close()
        end
        local ui = ISPVPLogToolUI:new(50, 50, 500, 700)
        ui:initialise()
        ui:addToUIManager()
    end
    if button.internal == "ZONE_EDITOR" then
        ISMultiplayerZoneEditor.ToggleEditor()
    end
    if button.internal == "CANCEL" then
        self:close()
    end
    self:updateButtons();
end

function ISAdminPanelUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ISAdminPanelUI.instance = nil
end

function ISAdminPanelUI:new(x, y, width, height)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    ISAdminPanelUI.instance = o
    return o;
end

function ISAdminPanelUI.OnSafehousesChanged()
    if ISAdminPanelUI.instance then
        local button = ISAdminPanelUI.instance.seeSafehousesBtn
        button:setTitle( getText("IGUI_AdminPanel_SeeSafehouses") .. " (".. SafeHouse.getSafehouseList():size() .. ")" )
    end
end

Events.OnSafehousesChanged.Add(ISAdminPanelUI.OnSafehousesChanged)

function ISAdminPanelUI.OnRolesReceived()
    if ISAdminPanelUI.instance then
        ISAdminPanelUI.instance:updateButtons();
    end
    if ISRolesList.instance then
        ISRolesList.instance:populateList()
    end
end

Events.OnRolesReceived.Add(ISAdminPanelUI.OnRolesReceived)

function ISAdminPanelUI.OnNetworkUsersReceived()
    if ISUsersList.instance then
        ISUsersList.instance:populateList()
    end
end

Events.OnNetworkUsersReceived.Add(ISAdminPanelUI.OnNetworkUsersReceived)
