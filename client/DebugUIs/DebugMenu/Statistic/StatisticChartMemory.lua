--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: Yuri				           **
--***********************************************************


require "DebugUIs/DebugMenu/Statistic/StatisticChart"

local UI_BORDER_SPACING = 10

StatisticChartMemory = StatisticChart:derive("StatisticChartMemory");
StatisticChartMemory.instance = nil;
StatisticChartMemory.shiftDown = 0;
StatisticChartMemory.eventsAdded = false;

function StatisticChartMemory.doInstance()
    if StatisticChartMemory.instance==nil then
        StatisticChartMemory.instance = StatisticChartMemory:new (100, 100, 900, 400, getPlayer());
        StatisticChartMemory.instance:initialise();
        StatisticChartMemory.instance:instantiate();
    end
    StatisticChartMemory.instance:addToUIManager();
    StatisticChartMemory.instance:setVisible(false);
    return StatisticChartMemory.instance;
end

function StatisticChartMemory.OnOpenPanel()
    if StatisticChartMemory.instance==nil then
        StatisticChartMemory.instance = StatisticChartMemory:new (100, 100, 900, 400, getPlayer());
        StatisticChartMemory.instance:initialise();
        StatisticChartMemory.instance:instantiate();
    end

    StatisticChartMemory.instance:addToUIManager();
    StatisticChartMemory.instance:setVisible(true);
	StatisticChartMemory.instance.title = "Statistic Chart Memory"
    return StatisticChartMemory.instance;
end

StatisticChartMemory.OnServerStatisticReceived = function()
	if StatisticChartMemory.instance~=nil then
        StatisticChartMemory.instance:updateValues()
    end
end

Events.OnServerStatisticReceived.Add(StatisticChartMemory.OnServerStatisticReceived);

function StatisticChartMemory:createChildren()
    StatisticChart.createChildren(self);

	local labelWidth = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_GameStats_Used")..": ")
	local x = self.historyM1:getX()
	local y = self.historyM1:getY()+self.historyM1:getHeight()
    y = self:addLabelValue(x, y, labelWidth, "value","used",getText("IGUI_GameStats_Used")..":",0);
    self:setHeight(y+UI_BORDER_SPACING)
end

function StatisticChartMemory:initVariables()
	StatisticChart.initVariables(self);
	self:addVarInfo("used",getText("IGUI_GameStats_Used"),-1,10000000000,"usedMemory");
end

function StatisticChartMemory:updateValues()
	StatisticChart.updateValues(self);
	local minmax1 = self.historyM1:calcMinMax(1);
	self.historyM1:applyMinMax(minmax1, 1);
end