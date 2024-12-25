--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: Yuri				           **
--***********************************************************


require "DebugUIs/DebugMenu/Statistic/StatisticChart"

local UI_BORDER_SPACING = 10

StatisticChartDiskOperations = StatisticChart:derive("StatisticChartDiskOperations");
StatisticChartDiskOperations.instance = nil;
StatisticChartDiskOperations.shiftDown = 0;
StatisticChartDiskOperations.eventsAdded = false;

function StatisticChartDiskOperations.doInstance()
    if StatisticChartDiskOperations.instance==nil then
        StatisticChartDiskOperations.instance = StatisticChartDiskOperations:new (100, 100, 900, 400, getPlayer());
        StatisticChartDiskOperations.instance:initialise();
        StatisticChartDiskOperations.instance:instantiate();
    end
    StatisticChartDiskOperations.instance:addToUIManager();
    StatisticChartDiskOperations.instance:setVisible(false);
    return StatisticChartDiskOperations.instance;
end

function StatisticChartDiskOperations.OnOpenPanel()
    if StatisticChartDiskOperations.instance==nil then
        StatisticChartDiskOperations.instance = StatisticChartDiskOperations:new (100, 100, 900, 400, getPlayer());
        StatisticChartDiskOperations.instance:initialise();
        StatisticChartDiskOperations.instance:instantiate();
    end
    StatisticChartDiskOperations.instance:addToUIManager();
    StatisticChartDiskOperations.instance:setVisible(true);
	StatisticChartDiskOperations.instance.title = getText("IGUI_StatisticChart_DiskOperations")
    return StatisticChartDiskOperations.instance;
end

StatisticChartDiskOperations.OnServerStatisticReceived = function()
	if StatisticChartDiskOperations.instance~=nil then
        StatisticChartDiskOperations.instance:updateValues()
    end
end

Events.OnServerStatisticReceived.Add(StatisticChartDiskOperations.OnServerStatisticReceived);

function StatisticChartDiskOperations:createChildren()
    StatisticChart.createChildren(self);

    local labelWidth = math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Load")..": "),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Save")..": ")
    )
	x = self.historyM1:getX()
	y = self.historyM1:getY()+self.historyM1:getHeight()
    y = self:addLabelValue(x, y, labelWidth, "value","load",getText("IGUI_DebugMenu_Load")..":",0);
	y = self:addLabelValue(x, y, labelWidth, "value","save",getText("IGUI_DebugMenu_Save")..":",0);
    self:setHeight(y+UI_BORDER_SPACING)
end

function StatisticChartDiskOperations:initVariables()
	StatisticChart.initVariables(self);
	
	self:addVarInfo("load",getText("IGUI_DebugMenu_Load"),-1,100,"loadCellFromDisk");
	self:addVarInfo("save",getText("IGUI_DebugMenu_Save"),-1,100,"saveCellToDisk");
end

function StatisticChartDiskOperations:updateValues()
	StatisticChart.updateValues(self);
	local minmax1 = self.historyM1:calcMinMax(1);
	local minmax2 = self.historyM1:calcMinMax(2);
	self.historyM1:applyMinMax(minmax1, 1);
	self.historyM1:applyMinMax(minmax2, 2);
end