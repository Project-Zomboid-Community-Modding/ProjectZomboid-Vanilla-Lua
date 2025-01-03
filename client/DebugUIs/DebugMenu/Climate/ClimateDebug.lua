--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************


require "ISUI/ISCollapsableWindow"

ClimateDebug = ISCollapsableWindow:derive("ClimateDebug");
ClimateDebug.instance = nil;
ClimateDebug.shiftDown = 0;
ClimateDebug.eventsAdded = false;
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ClimateDebug.OnOpenPanel()
    if ClimateDebug.instance==nil then
        ClimateDebug.instance = ClimateDebug:new (100, 100, 900, 300, getPlayer());
        ClimateDebug.instance:initialise();
        ClimateDebug.instance:instantiate();
    end

    ClimateDebug.instance:addToUIManager();
    ClimateDebug.instance:setVisible(true);

    if not ClimateDebug.eventsAdded then
        Events.OnClimateTickDebug.Add(ClimateDebug.OnClimateTickDebug);
        ClimateDebug.eventsAdded = true;
    end

    return ClimateDebug.instance;
end

function ClimateDebug:initialise()
    ISCollapsableWindow.initialise(self);
end


function ClimateDebug:createChildren()
    ISCollapsableWindow.createChildren(self);

    self:initVariables();
    local th = self:titleBarHeight();

    local y = th;
    local originalx = UI_BORDER_SPACING+1+getTextManager():MeasureStringX(UIFont.Small, "-1.0"); --largest piece of text on the left side of the window
    local x = originalx;

    self.buttonM1 = ISButton:new(x+UI_BORDER_SPACING, y+UI_BORDER_SPACING, 30, BUTTON_HGT,getText("IGUI_ClimatePlotter_Minute"),self, ClimateDebug.onButton);
    self.buttonM1:initialise();
    self.buttonM1:enableAcceptColor()
    self:addChild(self.buttonM1);
    x = x+UI_BORDER_SPACING+self.buttonM1.width

    self.buttonH1 = ISButton:new(x+UI_BORDER_SPACING, self.buttonM1.y, 30, self.buttonM1.height,getText("IGUI_ClimatePlotter_Hour"),self, ClimateDebug.onButton);
    self.buttonH1:initialise();
    self.buttonH1:enableCancelColor()
    self:addChild(self.buttonH1);
    x = x+UI_BORDER_SPACING+self.buttonH1.width

    self.buttonD1 = ISButton:new(x+UI_BORDER_SPACING, self.buttonM1.y, 30, self.buttonM1.height,getText("IGUI_ClimatePlotter_Day"),self, ClimateDebug.onButton);
    self.buttonD1:initialise();
    self.buttonD1:enableCancelColor()
    self:addChild(self.buttonD1);
    x = originalx;

    y = self.buttonM1:getY() + self.buttonM1:getHeight();

    self.historyM1 = ValuePlotter:new(x+UI_BORDER_SPACING,y+UI_BORDER_SPACING,600,BUTTON_HGT+(BUTTON_HGT+UI_BORDER_SPACING)*12,600);
    self.historyM1:initialise();
    self.historyM1:instantiate();
    --self.historyM1:defineVariable("temperature", {r=0, g=0, b=1.0, a=1.0}, -50, 50);
    self:addChild(self.historyM1);
    self.historyM1:setVisible(true);

    self.historyH1 = ValuePlotter:new(self.historyM1.x,self.historyM1.y,self.historyM1.width,self.historyM1.height,600);
    self.historyH1:initialise();
    self.historyH1:instantiate();
    --self.historyH1:defineVariable("temperature", {r=0, g=0, b=1.0, a=1.0}, -50, 50)
    self:addChild(self.historyH1);
    self.historyH1:setVisible(false);

    self.historyD1 = ValuePlotter:new(self.historyM1.x,self.historyM1.y,self.historyM1.width,self.historyM1.height,600);
    self.historyD1:initialise();
    self.historyD1:instantiate();
    --self.historyD1:defineVariable("temperature", {r=0, g=0, b=1.0, a=1.0}, -50, 50)
    self:addChild(self.historyD1);
    self.historyD1:setVisible(false);

    self.charts = {};
    table.insert(self.charts, self.historyM1);
    table.insert(self.charts, self.historyH1);
    table.insert(self.charts, self.historyD1);
    local vinfo;
    for i=1, #self.charts do
        for j=1, #self.varInfo do
            vinfo = self.varInfo[j];
            self.charts[i]:defineVariable(vinfo.desc, vinfo.col, vinfo.min, vinfo.max);
        end

        --self.charts[i]:setHorzLine(0.10,{r=0.1, g=0.1, b=0.1, a=1});
        self.charts[i]:setHorzLine(0.125,{r=0.05, g=0.05, b=0.05, a=1});
        self.charts[i]:setHorzLine(0.25,{r=0.1, g=0.1, b=0.1, a=1});
        --self.charts[i]:setHorzLine(0.30,{r=0.1, g=0.1, b=0.1, a=1});
        self.charts[i]:setHorzLine(0.375,{r=0.05, g=0.05, b=0.05, a=1});
        self.charts[i]:setHorzLine(0.50,{r=0.1, g=0.1, b=0.1, a=1});
        --self.charts[i]:setHorzLine(0.60,{r=0.1, g=0.1, b=0.1, a=1});
        self.charts[i]:setHorzLine(0.625,{r=0.05, g=0.05, b=0.05, a=1});
        self.charts[i]:setHorzLine(0.75,{r=0.1, g=0.1, b=0.1, a=1});
        --self.charts[i]:setHorzLine(0.80,{r=0.1, g=0.1, b=0.1, a=1});
        self.charts[i]:setHorzLine(0.875,{r=0.05, g=0.05, b=0.05, a=1});
    end

    y = self.historyM1:getY() + self.historyM1:getHeight();

    local tY = self.historyM1:getY();
    local tH = self.historyM1:getHeight();
    local tX = self.historyM1:getX();
    local tW = self.historyM1:getWidth();

    self.chartLabelsLeft = {};
    self.chartLabelsLeftTxt = {"1.0","0.5","0.0","-0.5","-1.0"};
    self.chartLabelsRight = {};
    self.chartLabelsRightTxt = {"50 C","25 C","0 C","-25 C","-50 C"};
    for i=1,5 do
        local id = i-1;
        local lbl = ISLabel:new(tX-UI_BORDER_SPACING, tY+((tH-FONT_HGT_SMALL)/4)*id, FONT_HGT_SMALL, self.chartLabelsLeftTxt[i], 1, 1, 1, 1.0, UIFont.Small, false);
        lbl:initialise();
        lbl:instantiate();
        self:addChild(lbl);
        table.insert(self.chartLabelsLeft,lbl);

        local lbl2 = ISLabel:new(tX+tW+UI_BORDER_SPACING, tY+((tH-FONT_HGT_SMALL)/4)*id, FONT_HGT_SMALL, self.chartLabelsRightTxt[i], 1, 1, 1, 1.0, UIFont.Small, true);
        lbl2:initialise();
        lbl2:instantiate();
        self:addChild(lbl2);
        table.insert(self.chartLabelsRight,lbl2);
    end

    y=y+UI_BORDER_SPACING;
    local cacheY, cacheX = y, x;
    local toggleButtonWidth = UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_ClimatePlotter_Toggle"))

    y = th; --self.historyM1:getY()-2;
    x = self.historyM1:getX() + self.historyM1:getWidth() + getTextManager():MeasureStringX(UIFont.Small, "-50 C") + UI_BORDER_SPACING;
    local widest = 0;
    local vars = self.historyM1:getVars();
    for i=1,#vars do
        local btn = ISButton:new(x+UI_BORDER_SPACING, y+UI_BORDER_SPACING, toggleButtonWidth, BUTTON_HGT,getText("IGUI_ClimatePlotter_Toggle"),self, ClimateDebug.onButtonToggle);
        btn:initialise();
        btn:enableCancelColor()
        btn.toggleVarID = i;
        btn.toggleVarName = vars[i].name;
        btn.toggleVal = vars[i].enabled;
        self:addChild(btn);

        local pnl = ISPanel:new(x+UI_BORDER_SPACING*2+btn.width,y+UI_BORDER_SPACING,20,BUTTON_HGT);
        pnl:initialise();
        pnl.backgroundColor = vars[i].color;
        self:addChild(pnl);

        local lbl = ISLabel:new(x+UI_BORDER_SPACING*3+pnl.width+btn.width, y+UI_BORDER_SPACING, BUTTON_HGT, vars[i].name, 1, 1, 1, 1.0, UIFont.Small, true);
        lbl:initialise();
        lbl:instantiate();
        self:addChild(lbl);
        widest = math.max(widest, x+UI_BORDER_SPACING*4+pnl.width+btn.width+getTextManager():MeasureStringX(UIFont.Small, vars[i].name)+1)

        y = btn:getY() + btn:getHeight();
    end
    x = widest;

    y = y+UI_BORDER_SPACING-1;
    cacheY = cacheY+UI_BORDER_SPACING-1;
    self:setWidth(x>cacheX and x or cacheX);
    self:setHeight(y>cacheY and y or cacheY);

end

--[[
--        self.charts[i]:defineVariable("daylight", {r=1.0, g=1.0, b=0.9, a=1.0}, -1, 1); --white
        self.charts[i]:defineVariable("night", {r=0.4, g=0.4, b=0.4, a=1.0}, -1, 1); --grey
        self.charts[i]:defineVariable("precipitation", {r=0, g=0, b=1.0, a=1.0}, -1, 1); --blue
        self.charts[i]:defineVariable("fog", {r=0.5, g=0.5, b=1.0, a=1.0}, -1, 1); --lightpurple
        self.charts[i]:defineVariable("airmassDaily", {r=1.0, g=0.5, b=0.5, a=1.0}, -1, 1); --beige
        self.charts[i]:defineVariable("airmass", {r=1.0, g=0.5, b=1.0, a=1.0}, -1, 1); --pink
        self.charts[i]:defineVariable("windAngle", {r=1.0, g=0.5, b=0, a=1.0}, -1, 1); --orange
        self.charts[i]:defineVariable("windPower", {r=0.5, g=1.0, b=0, a=1.0}, -1, 1); --lime
        self.charts[i]:defineVariable("wind", {r=1.0, g=1.0, b=0, a=1.0}, -1, 1); --yellow
        self.charts[i]:defineVariable("meanTemperature", {r=0, g=1.0, b=0, a=1.0}, -50, 50); --green
        self.charts[i]:defineVariable("baseTemperature", {r=0, g=0.5, b=0, a=1.0}, -50, 50); --darkgreen
        self.charts[i]:defineVariable("temperatureMod", {r=0, g=0.5, b=0.5, a=1.0}, -10, 10); --teal
        self.charts[i]:defineVariable("temperature", {r=1.0, g=0, b=0, a=1.0}, -50, 50); --red
--]]

function ClimateDebug:initVariables()
    self.varInfo = {};
    self.colTable = {};
    self:addColor(1.0,1.0,0.9);
    self:addColor(0.4,0.4,0.4);
    local cc = {1.0,0.5,0.0};
    for ri=1,#cc do
        for gi=1,#cc do
            for bi=1,#cc do
                if (not (ri==1 and gi==1 and bi==1)) and (not (ri==3 and gi==3 and bi==3)) then
                    self:addColor(cc[ri],cc[gi],cc[bi]);
                end
            end
        end
    end

    --self:addVarInfo("","",-1,1,"");
    self:addVarInfo("daylight",getText("IGUI_ClimateOptions_DAYLIGHT_STRENGTH"),-1,1,"getDayLightStrength");
    self:addVarInfo("night",getText("IGUI_ClimateOptions_NIGHT_STRENGTH"),-1,1,"getNightStrength");
    self:addVarInfo("precipitation",getText("IGUI_ClimateOptions_PRECIPITATION_INTENSITY"),-1,1,"getPrecipitationIntensity");
    self:addVarInfo("fog",getText("IGUI_ClimateOptions_FOG_INTENSITY"),-1,1,"getFogIntensity");
    self:addVarInfo("airmassDaily",getText("IGUI_ClimatePlotter_airmassDaily"),-1,1,"getAirMassDaily");
    self:addVarInfo("airmass",getText("IGUI_ClimatePlotter_airmass"),-1,1,"getAirMass");
    self:addVarInfo("frontstr",getText("IGUI_ClimatePlotter_frontstr"),-1,1,"getFrontStrength");
    self:addVarInfo("windAngle",getText("IGUI_ClimateOptions_WIND_ANGLE_INTENSITY"),-1,1,"getWindAngleIntensity");
    self:addVarInfo("windPower",getText("IGUI_ClimatePlotter_windPower"),-1,1,"getWindPower");
    self:addVarInfo("wind",getText("IGUI_ClimateOptions_WIND_INTENSITY"),-1,1,"getWindIntensity");
    self:addVarInfo("meanTemperature",getText("IGUI_ClimatePlotter_meanTemperature"),-50,50,function(_mgr) return _mgr:getSeason():getDayMeanTemperature() end);
    self:addVarInfo("airmassTemperature",getText("IGUI_ClimatePlotter_airmassTemperature"),-1,1,"getAirMassTemperature");
    --self:addVarInfo("baseTemperature","baseTemperature",-50,50,"getBaseTemperature");
    --self:addVarInfo("temperatureMod","temperatureMod",-10,10,"getTemperatureMod");
    self:addVarInfo("temperature",getText("IGUI_ClimateOptions_TEMPERATURE"),-50,50,"getTemperature");
    self:addVarInfo("snowstrength",getText("IGUI_ClimatePlotter_snowstrength"),-10,10,"getSnowStrength");
    --self:addVarInfo("","",-1,1,"");
end

function ClimateDebug:addColor(_r,_g,_b)
    table.insert(self.colTable,{r=_r,g=_g,b=_b,a=1.0})
end

function ClimateDebug:addVarInfo(_name,_desc,_min,_max,_func)
    table.insert(self.varInfo,{
        name = _name,
        desc = _desc,
        min = _min,
        max = _max,
        func = _func,
        col = {1,1,1,1};
    });
    self.varInfo[#self.varInfo].col = self.colTable[#self.varInfo];
end

function ClimateDebug:updateValues(_mgr)
    local dataset = {};
    local vinfo;
    for i=1,#self.varInfo do
        vinfo = self.varInfo[i];

        if type(vinfo.func)=="function" then
            table.insert(dataset,vinfo.func(_mgr));
        elseif type(vinfo.func)=="string" and _mgr[vinfo.func] then
            table.insert(dataset,_mgr[vinfo.func](_mgr));
        else
            print("function: "..tostring(vinfo.func).." cannot be found in climatemanager");
        end
    end
    --[[
    table.insert(dataset,_mgr:getDayLightStrength());
    table.insert(dataset,_mgr:getNightStrength());
    table.insert(dataset,_mgr:getPrecipitationIntensity());
    table.insert(dataset,_mgr:getFogIntensity());
    table.insert(dataset,_mgr:getAirMassDaily());
    table.insert(dataset,_mgr:getAirMass());
    table.insert(dataset,_mgr:getWindAngleIntensity());
    table.insert(dataset,_mgr:getWindPower());
    table.insert(dataset,_mgr:getWindIntensity());
    table.insert(dataset,_mgr:getSeason():getDayMeanTemperature());
    table.insert(dataset,_mgr:getBaseTemperature());
    table.insert(dataset,_mgr:getTemperatureMod());
    table.insert(dataset,_mgr:getTemperature());
    --]]

    local plotVertBarM1 = false;
    local plotVertBarH1 = false;
    local plotVertBarD1 = false;
    local dayInfo = _mgr:getCurrentDay();
    if dayInfo:getHour()~= self.hourStamp then
        self.hourStamp = dayInfo:getHour();
        plotVertBarM1 = {r=0.2, g=0.2, b=0.2, a=1};

        local datasetH1 = {};
        for i=1,#dataset do
            table.insert(datasetH1,dataset[i]);
        end
        if dayInfo:getDay()~=self.dayStamp then
            self.dayStamp = dayInfo:getDay();
            plotVertBarH1 = {r=0.2, g=0.2, b=0.2, a=1};
            plotVertBarM1 = {r=0.6, g=0.6, b=0.6, a=1};

            if dayInfo:getMonth()~=self.monthStamp then
                self.monthStamp = dayInfo:getMonth();
                plotVertBarD1 = {r=0.2, g=0.2, b=0.2, a=1};
                plotVertBarH1 = {r=0.6, g=0.6, b=0.6, a=1};

                if dayInfo:getYear()~=self.yearStamp then
                    self.yearStamp = dayInfo:getYear();
                    plotVertBarD1 = {r=0.6, g=1, b=0.6, a=1};
                    plotVertBarH1 = {r=0.6, g=1, b=0.6, a=1};
                end
            end

            --todo daygraph should plot averages
            --could grab the last 24 H1 to calc average, max is 24 or #H1
            local his = self.historyH1:getDataSet();
            local varCnt = self.historyH1:getVarCount();
            local vars = self.historyH1:getVars();
            local max = #his>=24 and 24 or #his;
            if max>0 then
                local daySet = {};
                for i=1,varCnt do
                    table.insert(daySet,0);
                end
                for i=1,max do
                    for j=1,varCnt do
                        daySet[j] = daySet[j] + his[i][j];
                    end
                end
                for i=1,varCnt do
                    daySet[i] = daySet[i] / max;
                    if vars[i].offset>0 then
                        daySet[i] = daySet[i]-vars[i].offset;
                    end
                end
                self.historyD1:addPlotPoint(daySet, plotVertBarD1);
            end
        end
        self.historyH1:addPlotPoint(datasetH1, plotVertBarH1);
    end
    self.historyM1:addPlotPoint(dataset, plotVertBarM1);
end

function ClimateDebug.OnClimateTickDebug(mgr)
    if ClimateDebug.instance then
        ClimateDebug.instance:updateValues(mgr);
    end
end

function ClimateDebug:onButton(_btn)
    if _btn.title==getText("IGUI_ClimatePlotter_Minute") then
        self.historyM1:setVisible(true);
        self.buttonM1:enableAcceptColor();
        self.historyH1:setVisible(false);
        self.buttonH1:enableCancelColor()
        self.historyD1:setVisible(false);
        self.buttonD1:enableCancelColor()
    end
    if _btn.title==getText("IGUI_ClimatePlotter_Hour") then
        self.historyM1:setVisible(false);
        self.buttonM1:enableCancelColor()
        self.historyH1:setVisible(true);
        self.buttonH1:enableAcceptColor();
        self.historyD1:setVisible(false);
        self.buttonD1:enableCancelColor()
    end
    if _btn.title==getText("IGUI_ClimatePlotter_Day") then
        self.historyM1:setVisible(false);
        self.buttonM1:enableCancelColor()
        self.historyH1:setVisible(false);
        self.buttonH1:enableCancelColor()
        self.historyD1:setVisible(true);
        self.buttonD1:enableAcceptColor();
    end
end

function ClimateDebug:onButtonToggle(_btn)
    if _btn.toggleVarName then
        _btn.toggleVal = not _btn.toggleVal;
        self.historyM1:setVariableEnabled(_btn.toggleVarName,_btn.toggleVal);
        self.historyH1:setVariableEnabled(_btn.toggleVarName,_btn.toggleVal);
        self.historyD1:setVariableEnabled(_btn.toggleVarName,_btn.toggleVal);
        if _btn.toggleVal then
            _btn:enableAcceptColor();
        else
            _btn:enableCancelColor()
        end
    end
end


function ClimateDebug:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
    --self.richtext:setWidth(self.width);
    --self.richtext:setHeight(self.height-(th+10));
end

function ClimateDebug:update()
    ISCollapsableWindow.update(self);

    if ClimateDebug.shiftDown>0 then
        ClimateDebug.shiftDown = ClimateDebug.shiftDown-1;
    end
end

function ClimateDebug:prerender()
    self:stayOnSplitScreen();
    ISCollapsableWindow.prerender(self);
end

function ClimateDebug:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end


function ClimateDebug:render()
    ISCollapsableWindow.render(self);

    if ClimateDebug.shiftDown>0 then
        ClimateDebug.shiftDown = ClimateDebug.shiftDown-1;
    end

    --self.richtext:clearStencilRect();

    --[[
    local w,h = self:getWidth(), self:getHeight();

    local c = self.greyCol;
    local sx,sy = (w/2)-300, (h/2)-100;

    local interval = h/self.gridVertSpacing;
    for i = 1, self.gridVertSpacing-1 do
        self:drawRect(1, i*interval, w-2, 1, c.a, c.r, c.g, c.b);
    end
    interval = w/self.gridHorzSpacing;
    for i = 1, self.gridHorzSpacing-1 do
        self:drawRect(i*interval, 1, 1, h-2, c.a, c.r, c.g, c.b);
    end
    --]]
end


function ClimateDebug:close()
    ISCollapsableWindow.close(self);
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, nil)
    end
    ClimateDebug.instance = nil;
    self:removeFromUIManager();
    self:clear();
end

function ClimateDebug:clear()
    self.currentTile = nil;
end



function ClimateDebug:new (x, y, width, height, player)
    local o = {}
    --o.data = {}
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.greyCol = { r=0.4,g=0.4,b=0.4,a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.pin = true;
    o.isCollapsed = false;
    o.collapseCounter = 0;
    o.title = getText("IGUI_ClimDebuggers_ClimatePlot");
    --o.viewList = {}
    o.resizable = true;
    o.drawFrame = true;

    o.currentTile = nil;
    o.richtext = nil;
    o.overrideBPrompt = true;
    o.subFocus = nil;
    o.hotKeyPanels = {};
    o.isJoypadWindow = false;

    o.hourStamp = -1;
    o.dayStamp = -1;
    o.monthStamp = -1;
    o.year = -1;
    ISDebugMenu.RegisterClass(self);
    return o
end

--[[
if enabled then
    Events.OnCustomUIKey.Add(ClimateDebug.OnKeyDown);
    Events.OnKeyKeepPressed.Add(ClimateDebug.OnKeepKeyDown);
    Events.OnClimateTickDebug.Add(ClimateDebug.OnClimateTickDebug);
    --Events.OnObjectLeftMouseButtonUp.Add(ClimateDebug.onMouseButtonUp);
end--]]