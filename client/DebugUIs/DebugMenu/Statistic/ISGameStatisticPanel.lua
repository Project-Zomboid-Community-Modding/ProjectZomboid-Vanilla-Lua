--***********************************************************
--**                    THE INDIE STONE                    **
--**                      Author: yuri                     **
--***********************************************************

require "ISUI/ISPanel"

ISGameStatisticPanel = ISPanel:derive("ISGameStatisticPanel");
ISGameStatisticPanel.instance = nil;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local function roundstring(_val)
    return tostring(ISDebugUtils.roundNum(_val,2));
end

function ISGameStatisticPanel.OnOpenPanel()
    if ISGameStatisticPanel.instance==nil then
        ISGameStatisticPanel.instance = ISGameStatisticPanel:new (100, 100, 642+(getCore():getOptionFontSizeReal()*150), 800, "Statistic");
        ISGameStatisticPanel.instance:initialise();
        ISGameStatisticPanel.instance:instantiate();
    end

    ISGameStatisticPanel.instance:addToUIManager();
    ISGameStatisticPanel.instance:setVisible(true);

    return ISGameStatisticPanel.instance;
end

function ISGameStatisticPanel:initialise()
    ISPanel.initialise(self);

    self.flareCount = false;
    self.colExt = { r=1, g=1, b=1 };
    self.colInt = { r=1, g=1, b=1 };
    self.flareID = -1;
end

function ISGameStatisticPanel:createChildren()
    ISPanel.createChildren(self);

    _, obj = ISDebugUtils.addLabel(self, {}, self.width/2, UI_BORDER_SPACING+1, getText("IGUI_GameStats_Title"), UIFont.Medium, true); obj.center = true;
	local columnWidth = (self.width-UI_BORDER_SPACING*4-2)/3;
	
	local x = UI_BORDER_SPACING+1;
    local x1, x2, x3 = x, x+columnWidth+UI_BORDER_SPACING, x+(columnWidth+UI_BORDER_SPACING)*2;
	local xw2 = 40;
    local y, obj = FONT_HGT_MEDIUM + UI_BORDER_SPACING*2 + 1, false;

	------- TOGGLE BUTTON -------
	y, self.buttonToggleMonitor = ISDebugUtils.addButton(self,"toggle_statistic",x ,y ,self.width-x*2, BUTTON_HGT, getText("IGUI_GameStats_ToggleStatsMonitor"), ISGameStatisticPanel.onClick);
	self.buttonToggleMonitor:enableCancelColor()
	y = y+UI_BORDER_SPACING
	local top = y

	------- COLUMN 1 -------

	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_Period")..":", UIFont.Small, true);
	y, self.periodValue = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true);
    y = y+UI_BORDER_SPACING; x = x1;

    _, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_LastReport")..":", UIFont.Small, true);
	y, self.lastReport = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true);
	y = y+UI_BORDER_SPACING; x = x1;

    y, obj = ISDebugUtils.addLabel(self, {}, x+columnWidth/2, y, getText("IGUI_GameStats_UpdatePeriod"), UIFont.Small, true); obj.center = true;
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_DebugMenu_Min")..":", UIFont.Small, true);
	_, self.minUpdatePeriod = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true);
	_, obj = ISDebugUtils.addLabel(self, {}, self.minUpdatePeriod:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_DebugMenu_Max")..":", UIFont.Small, true);
	_, self.maxUpdatePeriod = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true);
	_, obj = ISDebugUtils.addLabel(self, {}, self.maxUpdatePeriod:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_DebugMenu_Average")..":", UIFont.Small, true);
	y, self.avgUpdatePeriod = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true);
	y = y+UI_BORDER_SPACING; x = x1;
	y, self.buttonChartUpdatePeriod = ISDebugUtils.addButton(self, "CHART_UPDATE_PERIOD",x, y, columnWidth, BUTTON_HGT, getText("IGUI_Chart"),ISGameStatisticPanel.onClick);
	y = y+UI_BORDER_SPACING*2; x = x1;

    y, obj = ISDebugUtils.addLabel(self, {}, x+columnWidth/2, y, getText("IGUI_GameStats_ServerCellOps"), UIFont.Small, true); obj.center = true;
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_DebugMenu_Load")..":", UIFont.Small, true); x = x + xw2;
	_, self.loadCellFromDisk = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	_, obj = ISDebugUtils.addLabel(self, {}, self.loadCellFromDisk:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_DebugMenu_Save")..":", UIFont.Small, true); x = x + xw2;
	y, self.saveCellToDisk = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	y = y+UI_BORDER_SPACING; x = x1;
	y, self.buttonChartDiskOperations = ISDebugUtils.addButton(self, "CHART_DISK_OPERATIONS",x, y, columnWidth, BUTTON_HGT, getText("IGUI_Chart"),ISGameStatisticPanel.onClick);
	y = y+UI_BORDER_SPACING*2; x = x1;

    y, obj = ISDebugUtils.addLabel(self, {}, x+columnWidth/2, y, getText("IGUI_GameStats_Memory"), UIFont.Small, true); obj.center = true;
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_Used")..":", UIFont.Small, true); x = x + xw2;
	_, self.usedMemory = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	_, obj = ISDebugUtils.addLabel(self, {}, self.usedMemory:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_GameStats_Free")..":", UIFont.Small, true); x = x + xw2;
	y, self.freeMemory = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	y = y+UI_BORDER_SPACING; x = x1;
	y, self.buttonChartMemory = ISDebugUtils.addButton(self, "CHART_MEMORY",x, y, columnWidth, BUTTON_HGT, getText("IGUI_Chart"),ISGameStatisticPanel.onClick);
	y = y+UI_BORDER_SPACING*2; x = x1;

	y, obj = ISDebugUtils.addLabel(self, {}, x+columnWidth/2, y, getText("IGUI_GameStats_Connections"), UIFont.Small); obj.center = true;
    y = y+3;

    y, self.connections = ISDebugUtils.addComboBox(self,"combo_floats", x, y, columnWidth, UIFont.Small, ISGameStatisticPanel.onCombo);
	self.connections:setHeight(BUTTON_HGT)
    self.connections:addOption(getText("IGUI_None"));
    self.connections.selected = 1;
	y = y + BUTTON_HGT-FONT_HGT_SMALL;
    
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_IP")..":", UIFont.Small, true); x = x + xw2*2;
	y, self.connection_ip = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_Access")..":", UIFont.Small, true); x = x + xw2*2;
	y, self.connection_access = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_Username")..":", UIFont.Small, true); x = x + xw2*2;
	y, self.connection_username = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_Ping")..":", UIFont.Small, true); x = x + xw2*2;
	_, self.connection_ping = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_DebugMenu_Average")..":", UIFont.Small, true); x = x + xw2;
	y, self.connection_ping_avg = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_PlayerCount")..":", UIFont.Small, true); x = x + xw2*2;
	_, self.connection_players_count = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	_, obj = ISDebugUtils.addLabel(self, {}, self.connection_players_count:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_DebugMenu_Average")..":", UIFont.Small, true); x = x + xw2;
	y, self.connection_players_desync_avg = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_DebugMenu_Max")..":", UIFont.Small, true); x = x + xw2*2;
	_, self.connection_players_desync_max = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	_, obj = ISDebugUtils.addLabel(self, {}, self.connection_players_desync_max:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_GameStats_Teleport")..":", UIFont.Small, true); x = x + xw2;
	y, self.connection_players_desync_teleport = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;

	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_ZombieCount")..":", UIFont.Small, true); x = x + xw2*2;
	_, self.connection_zombies_count = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	_, obj = ISDebugUtils.addLabel(self, {}, self.connection_zombies_count:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_DebugMenu_Average")..":", UIFont.Small, true); x = x + xw2;
	y, self.connection_zombies_desync_avg = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_DebugMenu_Max")..":", UIFont.Small, true); x = x + xw2*2;
	_, self.connection_zombies_desync_max = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	_, obj = ISDebugUtils.addLabel(self, {}, self.connection_zombies_desync_max:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_GameStats_Teleport")..":", UIFont.Small, true); x = x + xw2;
	y, self.connection_zombies_desync_teleport = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	
	y = y+UI_BORDER_SPACING; x = x1;
	_, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_GameStats_FPS")..":", UIFont.Small, true); x = x + xw2*2;
	_, self.connection_fps = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	_, obj = ISDebugUtils.addLabel(self, {}, self.connection_fps:getRight() + UI_BORDER_SPACING*2, y, getText("IGUI_DebugMenu_Average")..":", UIFont.Small, true); x = x + xw2;
	y, self.connection_fpsAvg = ISDebugUtils.addLabel(self, {}, obj:getRight() + UI_BORDER_SPACING, y, "___", UIFont.Small, true); x = x + xw2;
	
	y = y+UI_BORDER_SPACING; x = x1;
	self.histogramm_y = y;
	self.histogramm_w = columnWidth;
	self.histogramm_h = 64;
	y = y+self.histogramm_h+UI_BORDER_SPACING;
	
	y = y+UI_BORDER_SPACING; x = x1;
    y, obj = ISDebugUtils.addLabel(self, {}, x + columnWidth/2, y, getText("IGUI_GameStats_Players"), UIFont.Small, true); obj.center = true;
	y = y+UI_BORDER_SPACING; x = x1;
	self.connection_players = ISScrollingListBox:new(x, y, columnWidth, BUTTON_HGT*6);
    self.connection_players:initialise();
    self.connection_players:instantiate();
    self.connection_players.itemheight = BUTTON_HGT;
    self.connection_players.selected = 0;
    self.connection_players.joypadParent = self;
    self.connection_players.font = UIFont.NewSmall;
    self.connection_players.doDrawItem = self.drawUsersList;
    self.connection_players.drawBorder = true;
    self.connection_players.target = self;
    self:addChild(self.connection_players);
	y = self.connection_players:getBottom()+UI_BORDER_SPACING+1
	self:setHeight(y)
	
	------- COLUMN 2 ---------
	y = top; x = x2;
    y, obj = ISDebugUtils.addLabel(self, {}, x + columnWidth/2, y, getText("IGUI_GameStats_PacketsIn"), UIFont.Small, true); obj.center = true;
	y = y+UI_BORDER_SPACING; x = x2;
	self.incomePackets = ISScrollingListBox:new(x, y, columnWidth, self.height - y - BUTTON_HGT - UI_BORDER_SPACING*2 - 1);
    self.incomePackets:initialise();
    self.incomePackets:instantiate();
    self.incomePackets.itemheight = BUTTON_HGT;
    self.incomePackets.selected = 0;
    self.incomePackets.joypadParent = self;
    self.incomePackets.font = UIFont.NewSmall;
    self.incomePackets.doDrawItem = self.drawIncomePacketsList;
    self.incomePackets.drawBorder = true;
    self.incomePackets.target = self;
    self:addChild(self.incomePackets);
	
	------- COLUMN 3 ---------
	y = top; x = x3;
    y, obj = ISDebugUtils.addLabel(self, {}, x + columnWidth/2, y, getText("IGUI_GameStats_PacketsOut"), UIFont.Small, true); obj.center = true;
	y = y+UI_BORDER_SPACING; x = x3;
	self.outcomePackets = ISScrollingListBox:new(x, y, columnWidth, self.incomePackets.height);
    self.outcomePackets:initialise();
    self.outcomePackets:instantiate();
    self.outcomePackets.itemheight = BUTTON_HGT;
    self.outcomePackets.selected = 0;
    self.outcomePackets.joypadParent = self;
    self.outcomePackets.font = UIFont.NewSmall;
    self.outcomePackets.doDrawItem = self.drawOutcomePacketsList;
    self.outcomePackets.drawBorder = true;
    self.outcomePackets.target = self;
    self:addChild(self.outcomePackets);

	------- BOTTOM ---------
	_, self.buttonChartPackets = ISDebugUtils.addButton(self, "CHART_PACKETS", x2, self.outcomePackets:getBottom() + UI_BORDER_SPACING, columnWidth, BUTTON_HGT, getText("IGUI_Chart_Packets"),ISGameStatisticPanel.onClick);
    local y, obj = ISDebugUtils.addButton(self,"close", x3, self.outcomePackets:getBottom() + UI_BORDER_SPACING, columnWidth, BUTTON_HGT,getText("IGUI_CraftUI_Close"),ISGameStatisticPanel.onClickClose);
	obj:enableCancelColor()

    self:populateConnectionsList();
	
	self.init = true
	
	StatisticChartUpdatePeriod.doInstance();
	StatisticChartDiskOperations.doInstance();
	StatisticChartMemory.doInstance();
	StatisticChartPackets.doInstance();
end

function ISGameStatisticPanel:onCombo(_combo)
    
end

function ISGameStatisticPanel:onClick(_button)
    if self.buttonToggleMonitor==_button then
		local enable = getServerStatisticEnable();
        if enable then
			setServerStatisticEnable(false);
            self.buttonToggleMonitor:enableCancelColor()
        else
			setServerStatisticEnable(true);
            self.buttonToggleMonitor:enableAcceptColor()
        end
		return;
	end
	if self.buttonChartUpdatePeriod==_button then
		StatisticChartUpdatePeriod.OnOpenPanel()
		return;
	end
	if self.buttonChartDiskOperations == _button then
		StatisticChartDiskOperations.OnOpenPanel()
		return;
	end
	if self.buttonChartMemory==_button then
		StatisticChartMemory.OnOpenPanel()
		return;
	end
	if self.buttonChartPackets==_button then
		StatisticChartPackets.OnOpenPanel()
		return;
	end
	
end

function ISGameStatisticPanel:onClickClose()
    self:close();
end

function ISGameStatisticPanel:OnFlaresListMouseDown(item)
    --self:populateInfoList(item);
    self.flareID = item:getId();
end

function ISGameStatisticPanel:populateConnectionsList()
	self.data = getServerStatistic();
	if self.data ~= nil then
		local sel = self.connections.options[self.connections.selected];
		self.connections:clear();
		self.connections:addOption(getText("IGUI_None"));
		local newindex = 1;
		for k, v in pairs(self.data.connections) do
			local name = v.username;
			self.connections:addOption(name);
			if sel and sel==name then
				newindex = k+2;
			end
		end
		self.connections.selected = newindex;
	end
end

function ISGameStatisticPanel:populateUsersList(connect)
	if connect ~= nil then
		self.connection_players:clear();
		for k, v in pairs(connect) do
			self.connection_players:addItem(v.username, v);
		end
	end
end

function ISGameStatisticPanel:populatePacketsList()
	self.data = getServerStatistic();
	if self.data ~= nil then
		self.incomePackets:clear();
		for k, v in pairs(self.data.incomePacketsTable) do
			self.incomePackets:addItem(v.name, v);
		end
		table.sort(self.incomePackets.items, function(a, b) return a.item.time>b.item.time end)
		self.outcomePackets:clear();
		for k, v in pairs(self.data.outcomePacketsTable) do
			self.outcomePackets:addItem(v.name, v);
		end
		table.sort(self.outcomePackets.items, function(a, b) return a.item.time>b.item.time end)
	end
end

function ISGameStatisticPanel:drawUsersList(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth()-10, self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawText( item.text, 10, y + 2, 1, 1, 1, a, self.font);
	self:drawText( tostring(item.item.x)..", "..tostring(item.item.y)..", "..tostring(item.item.z), 10, y + 17, 1, 1, 1, a, self.font);
    return y + self.itemheight;
end


function ISGameStatisticPanel:drawOutcomePacketsList(y, item, alt)
	local a = 0.9;

	self:drawRectBorder(0, (y), self:getWidth()-14, FONT_HGT_SMALL * 2 + 4 - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

	self.data = getServerStatistic();
	if self.data ~= nil then
		self:drawRect( 10, (y+19), 90.0 * math.min(1.0, item.item.count / self.data.countOutcomePackets) , 12 , a, 0.6, 0.2, 0.2);
		self:drawRect( 90, (y+19), 90.0 * math.min(1.0, item.item.bytes / self.data.countOutcomeBytes) , 12 , a, 0.2, 0.6, 0.2);
		if item.item.time < 1000 then
			self:drawRect( 170, (y+19), 60, 12 , a, 0.2, 0.6, 0.2);
		elseif item.item.time < 10000 then
			self:drawRect( 170, (y+19), 60, 12 , a, 0.6, 0.6, 0.2);
		else
			self:drawRect( 170, (y+19), 60, 12 , a, 0.6, 0.2, 0.2);
		end
	end

	self:drawText( item.text, 10, y + 2, 1, 1, 1, a, self.font);
	self:drawText( "count: "..tostring(item.item.count), 10, y + 17, 1, 1, 1, a, self.font);
	self:drawText( "bytes: "..tostring(item.item.bytes), 90, y + 17, 1, 1, 1, a, self.font);
	self:drawText( " time: "..tostring(item.item.time), 170, y + 17, 1, 1, 1, a, self.font);

	return y + FONT_HGT_SMALL * 2 + 4
end

function ISGameStatisticPanel:drawIncomePacketsList(y, item, alt)
	local a = 0.9;

	self:drawRectBorder(0, (y), self:getWidth()-14, FONT_HGT_SMALL * 2 + 4 - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

	self.data = getServerStatistic();
	if self.data ~= nil then
		self:drawRect( 10, (y+19), 50.0 * math.min(1.0, item.item.count / self.data.countIncomePackets) , 12 , a, 0.6, 0.2, 0.2);
		self:drawRect( 90, (y+19), 50.0 * math.min(1.0, item.item.bytes / self.data.countIncomeBytes) , 12 , a, 0.2, 0.6, 0.2);
		if item.item.time < 1000 then
			self:drawRect( 170, (y+19), 60, 12 , a, 0.2, 0.6, 0.2);
		elseif item.item.time < 10000 then
			self:drawRect( 170, (y+19), 60, 12 , a, 0.6, 0.6, 0.2);
		else
			self:drawRect( 170, (y+19), 60, 12 , a, 0.6, 0.2, 0.2);
		end
	end

	self:drawText( item.text, 10, y + 2, 1, 1, 1, a, self.font);
	self:drawText( "count: "..tostring(item.item.count), 10, y + 17, 1, 1, 1, a, self.font);
	self:drawText( "bytes: "..tostring(item.item.bytes), 90, y + 17, 1, 1, 1, a, self.font);
	self:drawText( " time: "..tostring(item.item.time), 170, y + 17, 1, 1, 1, a, self.font);

	return y + FONT_HGT_SMALL * 2 + 4
end

function ISGameStatisticPanel:prerender()
    ISPanel.prerender(self);
	
	self.data = getServerStatistic();
	if self.data ~= nil and self.lastReport ~= nil then
		local indicatorWidth = ((self.width)/3) - 40;
		if (self.data.period >= 1) then
			local period = math.min(1.0, (getTimeInMillis() - self.data.lastReportTime) / (self.data.period * 1000.0));
			self:drawRect( 20, self.lastReport.y + 20, indicatorWidth * period, 6, 1.0, 0.2, 0.6, 0.2);
			self:drawRect( 20 + (indicatorWidth * period), self.lastReport.y + 20, indicatorWidth * (1.0 - period), 6, 1.0, 0.6, 0.2, 0.2);
		else 
			self:drawRect( 20, self.lastReport.y + 20, indicatorWidth, 6, 1.0, 0.2, 0.2, 0.2);
		end
		--self.histogramm_y = y;
		--self.histogramm_w = 30;
		--self.histogramm_h = 30;
		self:drawRect( 20, self.histogramm_y, self.histogramm_w, self.histogramm_h, 1.0, 0.2, 0.2, 0.2);
		local sel = self.connections.options[self.connections.selected];
		for k, v in pairs(self.data.connections) do
			if sel and sel==v.username then
				local d = self.histogramm_w/(v.FPSMax - v.FPSMin);
				local d1 = (v.FPSAvg - v.FPSMin) * d / 16;
				local d2 = (v.FPSMax - v.FPSAvg) * d / 16;
				local kh = self.histogramm_h / v.FPSHistogramMax
				local xcl = 20
				local ycl = self.histogramm_y + self.histogramm_h
				
				local mouseSelect = self:getMouseX() - 20
				local mouseSelectId = 0
				local mouseSelectMin = 0
				local mouseSelectMax = 0
				if mouseSelect > d1 * 16 then
					mouseSelectId = math.min(31, math.max(0, math.floor(((mouseSelect - (d1 * 16)) / d2) + 16)))
					mouseSelectMin = math.floor(v.FPSAvg + (mouseSelectId-16)*d2/d)
					mouseSelectMax = math.floor(v.FPSAvg + (mouseSelectId-15)*d2/d)
				else
					mouseSelectId = math.min(31, math.max(0, math.floor(mouseSelect / d1)))
					mouseSelectMin = math.floor(v.FPSMin + mouseSelectId*d1/d)
					mouseSelectMax = math.floor(v.FPSMin + (mouseSelectId+1)*d1/d)
				end
				
				self:drawRect( xcl, ycl - v.FPSHistogram[0] * kh, d1, v.FPSHistogram[0] * kh, 1.0, 1.0, 0.3, 0.3);
				xcl = xcl + d1
				for i=1,15 do 
					if i == mouseSelectId then
						self:drawRect( xcl-1, ycl - v.FPSHistogram[i] * kh, d1+1, v.FPSHistogram[i] * kh, 1.0, 1.0 - (i/32.0)*0.7, 0.3 + (i/32.0)*0.7, 0.9);
					else 
						self:drawRect( xcl-1, ycl - v.FPSHistogram[i] * kh, d1+1, v.FPSHistogram[i] * kh, 1.0, 1.0 - (i/32.0)*0.7, 0.3 + (i/32.0)*0.7, 0.2);
					end
					xcl = xcl + d1
				end
				for i=16,31 do 
					if i == mouseSelectId then
						self:drawRect( xcl-1, ycl - v.FPSHistogram[i] * kh, d2+1, v.FPSHistogram[i] * kh, 1.0, 1.0 - (i/32.0)*0.7, 0.3 + (i/32.0)*0.7, 0.9);
					else
						self:drawRect( xcl-1, ycl - v.FPSHistogram[i] * kh, d2+1, v.FPSHistogram[i] * kh, 1.0, 1.0 - (i/32.0)*0.7, 0.3 + (i/32.0)*0.7, 0.2);
					end
					xcl = xcl + d2
				end
				
				self:drawText( "FPS:"..tostring(mouseSelectMin).."-"..tostring(mouseSelectMax).." Reports:"..tostring(v.FPSHistogram[mouseSelectId]), 20 + 1, self.histogramm_y + 1, 1, 1, 1, 1, self.font);
				--self:drawText( "Min:"..tostring(v.FPSMin), 20 + 1, self.histogramm_y + 17, 1, 1, 1, 1, self.font);
				--self:drawText( getText("IGUI_DebugMenu_Max")..":"..tostring(v.FPSMax), 20 + self.histogramm_w - 20, self.histogramm_y + 17, 1, 1, 1, 1, self.font);
				break;
			end
		end

	end
end

function ISGameStatisticPanel:updateValues()
	if not self.init then
		return
	end
	local enable = getServerStatisticEnable();
	if enable then
		self.data = getServerStatistic();
		if self.data ~= nil then
			self.periodValue:setName(tostring(self.data.period));
			self.lastReport:setName(tostring(self.data.lastReport));
			self.minUpdatePeriod:setName(tostring(self.data.minUpdatePeriod));
			self.maxUpdatePeriod:setName(tostring(self.data.maxUpdatePeriod));
			self.avgUpdatePeriod:setName(tostring(self.data.avgUpdatePeriod));
			self.loadCellFromDisk:setName(tostring(self.data.loadCellFromDisk));
			self.saveCellToDisk:setName(tostring(self.data.saveCellToDisk));
			self.usedMemory:setName(tostring(self.data.usedMemory));
			self.freeMemory:setName(tostring(self.data.freeMemory));
			self:populateConnectionsList();
			local sel = self.connections.options[self.connections.selected];
			for k, v in pairs(self.data.connections) do
				if sel and sel==v.username then
					self.connection_ip:setName(tostring(v.ip));
					self.connection_access:setName(tostring(v.accessLevel));
					self.connection_username:setName(tostring(v.username));
					self.connection_ping:setName(string.format("%.2f", v.diff * 0.5));
					self.connection_ping_avg:setName(string.format("%.2f", v.pingAVG));
					self.connection_players_count:setName(string.format("%.2f", v.remotePlayersCount));
					self.connection_players_desync_avg:setName(string.format("%.2f", v.remotePlayersDesyncAVG));
					self.connection_players_desync_max:setName(string.format("%.2f", v.remotePlayersDesyncMax));
					self.connection_players_desync_teleport:setName(string.format("%.2f", v.remotePlayersTeleports));
					self.connection_zombies_count:setName(string.format("%.2f", v.zombiesCount));
					self.connection_zombies_desync_avg:setName(string.format("%.2f", v.zombiesDesyncAVG));
					self.connection_zombies_desync_max:setName(string.format("%.2f", v.zombiesDesyncMax));
					self.connection_zombies_desync_teleport:setName(string.format("%.2f", v.zombiesTeleports));
					self.connection_fps:setName(string.format("%.2f", v.FPS));
					self.connection_fpsAvg:setName(string.format("%.2f", v.FPSAvg));
					self:populateUsersList(v.users)
					break;
				end
			end
			self:populatePacketsList();
		end
	end
	
end

ISGameStatisticPanel.OnServerStatisticReceived = function()
	if ISGameStatisticPanel.instance==nil then
        ISGameStatisticPanel.instance = ISGameStatisticPanel:new (100, 100, 800, 800, "Statistic");
        ISGameStatisticPanel.instance:initialise();
        ISGameStatisticPanel.instance:instantiate();
    end
	ISGameStatisticPanel.instance:updateValues()
end

Events.OnServerStatisticReceived.Add(ISGameStatisticPanel.OnServerStatisticReceived);

function ISGameStatisticPanel:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ISGameStatisticPanel.instance = nil
end

function ISGameStatisticPanel:new(x, y, width, height, title)
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
    o.panelTitle = title;
    ISDebugMenu.RegisterClass(self);
    return o;
end


