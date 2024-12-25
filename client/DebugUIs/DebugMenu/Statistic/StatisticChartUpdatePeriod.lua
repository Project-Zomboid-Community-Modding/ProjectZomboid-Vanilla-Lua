--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: Yuri				           **
--***********************************************************


require "DebugUIs/DebugMenu/Statistic/StatisticChart"

local UI_BORDER_SPACING = 10

StatisticChartUpdatePeriod = StatisticChart:derive("StatisticChartUpdatePeriod");
StatisticChartUpdatePeriod.instance = nil;
StatisticChartUpdatePeriod.shiftDown = 0;
StatisticChartUpdatePeriod.eventsAdded = false;

function StatisticChartUpdatePeriod.doInstance()
    if StatisticChartUpdatePeriod.instance==nil then
        StatisticChartUpdatePeriod.instance = StatisticChartUpdatePeriod:new (100, 100, 900, 400, getPlayer());
        StatisticChartUpdatePeriod.instance:initialise();
        StatisticChartUpdatePeriod.instance:instantiate();
    end
    StatisticChartUpdatePeriod.instance:addToUIManager();
    StatisticChartUpdatePeriod.instance:setVisible(false);
    return StatisticChartUpdatePeriod.instance;
end

function StatisticChartUpdatePeriod.OnOpenPanel()
    if StatisticChartUpdatePeriod.instance==nil then
        StatisticChartUpdatePeriod.instance = StatisticChartUpdatePeriod:new (100, 100, 900, 400, getPlayer());
        StatisticChartUpdatePeriod.instance:initialise();
        StatisticChartUpdatePeriod.instance:instantiate();
    end

    StatisticChartUpdatePeriod.instance:addToUIManager();
    StatisticChartUpdatePeriod.instance:setVisible(true);
	StatisticChartUpdatePeriod.instance.title = getText("IGUI_StatisticChart_UpdatePeriod")
    return StatisticChartUpdatePeriod.instance;
end

StatisticChartUpdatePeriod.OnServerStatisticReceived = function()
	if StatisticChartUpdatePeriod.instance~=nil then
        StatisticChartUpdatePeriod.instance:updateValues()
    end
end

Events.OnServerStatisticReceived.Add(StatisticChartUpdatePeriod.OnServerStatisticReceived);

function StatisticChartUpdatePeriod:createChildren()
    StatisticChart.createChildren(self);

    local labelWidth = math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Min")..": "),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Max")..": "),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Average")..": ")
    )
	x = self.historyM1:getX()
	y = self.historyM1:getY()+self.historyM1:getHeight()
    y = self:addLabelValue(x, y, labelWidth, "value","Min",getText("IGUI_DebugMenu_Min")..":",0);
	y = self:addLabelValue(x, y, labelWidth, "value","Max",getText("IGUI_DebugMenu_Max")..":",0);
	y = self:addLabelValue(x, y, labelWidth, "value","Avg",getText("IGUI_DebugMenu_Average")..":",0);
    self:setHeight(y+UI_BORDER_SPACING)
end

function StatisticChartUpdatePeriod:updateValues()
	StatisticChart.updateValues(self);
	local minmax1 = self.historyM1:calcMinMax(1);
	local minmax1 = self.historyM1:calcMinMax(2, minmax1);
	local minmax1 = self.historyM1:calcMinMax(3, minmax1);
	self.historyM1:applyMinMax(minmax1, 1);
	self.historyM1:applyMinMax(minmax1, 2);
	self.historyM1:applyMinMax(minmax1, 3);
end

function StatisticChartUpdatePeriod:initVariables()
	StatisticChart.initVariables(self);
	
	self:addVarInfo("Min",getText("IGUI_DebugMenu_Min"),-1,1000,"minUpdatePeriod");
	self:addVarInfo("Max",getText("IGUI_DebugMenu_Max"),-1,1000,"maxUpdatePeriod");
	self:addVarInfo("Avg",getText("IGUI_DebugMenu_Average"),-1,1000,"avgUpdatePeriod");
end