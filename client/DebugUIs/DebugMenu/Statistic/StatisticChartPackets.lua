--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: Yuri				           **
--***********************************************************


require "DebugUIs/DebugMenu/Statistic/StatisticChart"

local UI_BORDER_SPACING = 10
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

StatisticChartPackets = StatisticChart:derive("StatisticChartPackets");
StatisticChartPackets.instance = nil;
StatisticChartPackets.shiftDown = 0;
StatisticChartPackets.eventsAdded = false;

function StatisticChartPackets.doInstance()
    if StatisticChartPackets.instance==nil then
        StatisticChartPackets.instance = StatisticChartPackets:new (100, 100, 800+(getCore():getOptionFontSizeReal()*150), 400, getPlayer());
        StatisticChartPackets.instance:initialise();
        StatisticChartPackets.instance:instantiate();
    end
    StatisticChartPackets.instance:addToUIManager();
    StatisticChartPackets.instance:setVisible(false);
    return StatisticChartPackets.instance;
end

function StatisticChartPackets.OnOpenPanel()
    if StatisticChartPackets.instance==nil then
        StatisticChartPackets.instance = StatisticChartPackets:new (100, 100, 800+(getCore():getOptionFontSizeReal()*150), 400, getPlayer());
        StatisticChartPackets.instance:initialise();
        StatisticChartPackets.instance:instantiate();
    end
    StatisticChartPackets.instance:addToUIManager();
    StatisticChartPackets.instance:setVisible(true);
	StatisticChartPackets.instance.title = "Statistic Chart Packets"
    return StatisticChartPackets.instance;
end

StatisticChartPackets.OnServerStatisticReceived = function()
	if StatisticChartPackets.instance~=nil then
        StatisticChartPackets.instance:updateValues()
    end
end

Events.OnServerStatisticReceived.Add(StatisticChartPackets.OnServerStatisticReceived);

function StatisticChartPackets:createChildren()
    StatisticChart.createChildren(self);

	local labelWidth = math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_PacketsInCount")..": "),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_PacketsInBytes")..": "),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_PacketsInBPS")..": "),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_PacketsOutCount")..": "),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_PacketsOutBytes")..": "),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_PacketsOutBPS")..": "),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_MaxPacketsCount")..":  "),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_MaxPacketsBytes")..":  "),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StatisticChart_MaxPacketsBPS")..":  ")
	)
	local x = self.historyM1:getX()
	local y = self.historyM1:getY()+self.historyM1:getHeight()
    y = self:addLabelValue(x, y, labelWidth, "value","countIncomePackets",getText("IGUI_StatisticChart_PacketsInCount")..": ",0);
	y = self:addLabelValue(x, y, labelWidth, "value","countIncomeBytes",getText("IGUI_StatisticChart_PacketsInBytes")..": ",0);
	y = self:addLabelValue(x, y, labelWidth, "value","maxIncomeBytesPerSecound",getText("IGUI_StatisticChart_PacketsInBPS")..": ",0);
	y = self:addLabelValue(x, y, labelWidth, "value","countOutcomePackets",getText("IGUI_StatisticChart_PacketsOutCount")..": ",0);
	y = self:addLabelValue(x, y, labelWidth, "value","countOutcomeBytes",getText("IGUI_StatisticChart_PacketsOutBytes")..": ",0);
	y = self:addLabelValue(x, y, labelWidth, "value","maxOutcomeBytesPerSecound",getText("IGUI_StatisticChart_PacketsOutBPS")..": ",0);
	self:setHeight(y+UI_BORDER_SPACING)
	x = x+labelWidth+getTextManager():MeasureStringX(UIFont.Small, "0000000   ");
	y = self.historyM1:getY()+self.historyM1:getHeight()+(FONT_HGT_SMALL*3);
	y = self:addLabelValue(x, y, labelWidth, "value","maxForCountPackets",getText("IGUI_StatisticChart_MaxPacketsCount")..": ",0);
	y = self:addLabelValue(x, y, labelWidth, "value","maxForCountBytes",getText("IGUI_StatisticChart_MaxPacketsBytes")..": ",0);
	y = self:addLabelValue(x, y, labelWidth, "value","maxFormaxBPS",getText("IGUI_StatisticChart_MaxPacketsBPS")..": ",0);
end

function StatisticChartPackets:initVariables()
	StatisticChart.initVariables(self);
	self:addVarInfo("countIncomePackets",getText("IGUI_StatisticChart_PacketsInCount"),-1,10000000000,"countIncomePackets");
	self:addVarInfo("countIncomeBytes",getText("IGUI_StatisticChart_PacketsInBytes"),-1,10000000000,"countIncomeBytes");
	self:addVarInfo("maxIncomeBytesPerSecound",getText("IGUI_StatisticChart_PacketsInBPS"),-1,10000000000,"maxIncomeBytesPerSecound");
	self:addVarInfo("countOutcomePackets",getText("IGUI_StatisticChart_PacketsOutCount"),-1,10000000000,"countOutcomePackets");
	self:addVarInfo("countOutcomeBytes",getText("IGUI_StatisticChart_PacketsOutBytes"),-1,10000000000,"countOutcomeBytes");
	self:addVarInfo("maxOutcomeBytesPerSecound",getText("IGUI_StatisticChart_PacketsOutBPS"),-1,10000000000,"maxOutcomeBytesPerSecound");
end

function StatisticChartPackets:updateValues()
	StatisticChart.updateValues(self);
	local minmax1 = self.historyM1:calcMinMax(1);
	local minmax2 = self.historyM1:calcMinMax(2);
	local minmax3 = self.historyM1:calcMinMax(3);
	local minmax1 = self.historyM1:calcMinMax(4, minmax1);
	local minmax2 = self.historyM1:calcMinMax(5, minmax2);
	local minmax3 = self.historyM1:calcMinMax(6, minmax3);
	self.historyM1:applyMinMax(minmax1, 1);
	self.historyM1:applyMinMax(minmax2, 2);
	self.historyM1:applyMinMax(minmax3, 3);
	self.historyM1:applyMinMax(minmax1, 4);
	self.historyM1:applyMinMax(minmax2, 5);
	self.historyM1:applyMinMax(minmax3, 6);
	
	self:getValueLabel("maxForCountPackets").name = tostring(minmax1.max);
	self:getValueLabel("maxForCountBytes").name = tostring(minmax2.max);
	self:getValueLabel("maxFormaxBPS").name = tostring(minmax3.max);
end