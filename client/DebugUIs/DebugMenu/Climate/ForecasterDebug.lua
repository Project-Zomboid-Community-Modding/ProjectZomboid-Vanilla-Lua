--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ForecasterDebug = ISPanel:derive("ForecasterDebug");
ForecasterDebug.instance = nil;
local FONT_HGT_MED = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

local stages = {
    [0] = "STAGE_START",
    [1] = "STAGE_SHOWERS",
    [2] = "STAGE_HEAVY_PRECIP",
    [3] = "STAGE_STORM",
    [4] = "STAGE_CLEARING",
    [5] = "STAGE_MODERATE",
    [6] = "STAGE_DRIZZLE",
    [7] = "STAGE_BLIZZARD",
    [8] = "STAGE_TROPICAL_STORM",
    [9] = "STAGE_INTERMEZZO",
    [10] = "STAGE_MODDED",
    [11] = "STAGE_KATEBOB_STORM",
}

local function roundstring(_val)
    return tostring(ISDebugUtils.roundNum(_val,2));
end

function ForecasterDebug.OnOpenPanel()
    if ForecasterDebug.instance==nil then
        ForecasterDebug.instance = ForecasterDebug:new (100, 100, 640+(getCore():getOptionFontSizeReal()*60), 600+(getCore():getOptionFontSizeReal()*50), "Climate forecaster debugger");
        ForecasterDebug.instance:initialise();
        ForecasterDebug.instance:instantiate();
    end

    ForecasterDebug.instance:addToUIManager();
    ForecasterDebug.instance:setVisible(true);

    return ForecasterDebug.instance;
end

function ForecasterDebug:initialise()
    ISPanel.initialise(self);

    self.clim = getClimateManager();
    self.forecaster = self.clim:getClimateForecaster();
    self.firstForecast = false;
end

function ForecasterDebug:createChildren()
    ISPanel.createChildren(self);

    local titleWidth = getTextManager():MeasureStringX(UIFont.Medium, "Climate forecaster debugger")
    ISDebugUtils.addLabel(self, {}, (self.width - titleWidth)/2, UI_BORDER_SPACING+1, getText("IGUI_Forecaster_Title"), UIFont.Medium, true)

    self.daysList = ISScrollingListBox:new(UI_BORDER_SPACING+1, FONT_HGT_MED+UI_BORDER_SPACING*2+1, (self.width-UI_BORDER_SPACING*3-2)/2, self.height-FONT_HGT_MED-BUTTON_HGT-UI_BORDER_SPACING*4-2);
    self.daysList:initialise();
    self.daysList:instantiate();
    self.daysList.itemheight = BUTTON_HGT;
    self.daysList.selected = 0;
    self.daysList.joypadParent = self;
    self.daysList.font = UIFont.NewSmall;
    self.daysList.doDrawItem = self.drawDayList;
    self.daysList.drawBorder = true;
    self.daysList.onmousedown = ForecasterDebug.OnDaysListMouseDown;
    self.daysList.target = self;
    self:addChild(self.daysList);

    self.infoList = ISScrollingListBox:new(self.daysList:getRight()+UI_BORDER_SPACING, self.daysList.y, (self.width-UI_BORDER_SPACING*3-2)/2, self.daysList.height);
    self.infoList:initialise();
    self.infoList:instantiate();
    self.infoList.itemheight = BUTTON_HGT;
    self.infoList.selected = 0;
    self.infoList.joypadParent = self;
    self.infoList.font = UIFont.NewSmall;
    self.infoList.doDrawItem = self.drawInfoList;
    self.infoList.drawBorder = true;
    self:addChild(self.infoList);

    local btnWidth = UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CraftUI_Close"))
    local y, obj = ISDebugUtils.addButton(self,"close",self.width-btnWidth-UI_BORDER_SPACING-1,self.height-BUTTON_HGT-UI_BORDER_SPACING-1,btnWidth,BUTTON_HGT,getText("IGUI_CraftUI_Close"),ForecasterDebug.onClickClose);
    obj:enableCancelColor()

    self:populateList();
end

function ForecasterDebug:onClickClose()
    self:close();
end

function ForecasterDebug:OnDaysListMouseDown(item)
    self:populateInfoList(item);
end

function ForecasterDebug:populateList()
    local forecasts = self.forecaster:getForecasts();

    if self.firstForecast and self.firstForecast==forecasts:get(0) then
        return;
    end

    self.daysList:clear();

    for i=0, forecasts:size()-1 do
        local forecast = forecasts:get(i);

        local prefix = forecast:getIndexOffset()==0 and getText("IGUI_Forecaster_Today") or ("["..getText("IGUI_Forecaster_Offset").." "..tostring(forecast:getIndexOffset()).."]");
        local name = prefix .. " :: " .. forecast:getName()

        self.daysList:addItem(name, forecast);
    end

    self.firstForecast=forecasts:get(0);

    self:populateInfoList(self.firstForecast);
end

function ForecasterDebug:drawDayList(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if item.item:getIndexOffset()<0 then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 0.80, 0.80, 0.80);
    end

    if item.item:isWeatherStarts() or item.item:getWeatherOverlap()~=nil then
        -- this day has weather, color it differently
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.45, 0.45, 0.85);
    end

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    --local prefix = item.item:getIndexOffset()==0 and "TODAY" or tostring(item.item:getIndexOffset());
    --self:drawText( prefix .. " :: " .. item.item:getName(), 10, y + 2, 1, 1, 1, a, self.font);
    if item.item:isHasFog() then
        self:drawText( item.text .. " (F)", 10, y + 2, 0.8, 1, 0.75, a, self.font);
    else
        self:drawText( item.text, 10, y + 2, 1, 1, 1, a, self.font);
    end

    return y + self.itemheight;
end

function ForecasterDebug:formatVal(_value, _func, _func2)
    return _func2 and (_func2(_func(_value))) or (_func(_value));
end

function ForecasterDebug:printForecastValue(_name, _value, _func, _func2)
    local formatFunc = _func or roundstring;
    self.infoList:addItem("--- ".._name.." ---", nil);
    --self.infoList:addItem("Min: "..self:formatVal(_value:getTotalMin(), formatFunc, _func2), nil);
    --self.infoList:addItem("Max: "..self:formatVal(_value:getTotalMax(), formatFunc, _func2), nil);
    self.infoList:addItem("  "..getText("IGUI_Forecaster_MinMax")..": "..self:formatVal(_value:getTotalMin(), formatFunc, _func2).." / "..self:formatVal(_value:getTotalMax(), formatFunc, _func2), nil);
    self.infoList:addItem("  "..getText("IGUI_Forecaster_Mean")..": "..self:formatVal(_value:getTotalMean(), formatFunc, _func2), nil);
    self.infoList:addItem("  "..getText("IGUI_Forecaster_DayMinMax")..": "..self:formatVal(_value:getDayMin(), formatFunc, _func2).." / "..self:formatVal(_value:getDayMax(), formatFunc, _func2), nil);
    self.infoList:addItem("  "..getText("IGUI_Forecaster_DayMean")..": "..self:formatVal(_value:getDayMean(), formatFunc, _func2), nil);
    self.infoList:addItem("  "..getText("IGUI_Forecaster_NightMinMax")..": "..self:formatVal(_value:getNightMin(), formatFunc, _func2).." / "..self:formatVal(_value:getNightMax(), formatFunc, _func2), nil);
    self.infoList:addItem("  "..getText("IGUI_Forecaster_NightMean")..": "..self:formatVal(_value:getNightMean(), formatFunc, _func2), nil);
end

function ForecasterDebug:populateInfoList(_forecast)
    self.infoList:clear();

    self.infoList:addItem(_forecast:getName(), nil);
    self.infoList:addItem(getText("IGUI_Forecaster_Dawn")..": "..roundstring(_forecast:getDawn()), nil);
    self.infoList:addItem(getText("IGUI_Forecaster_Dusk")..": "..roundstring(_forecast:getDusk()), nil);
    self.infoList:addItem(getText("IGUI_Forecaster_DaylightHours")..": "..roundstring(_forecast:getDayLightHours()), nil);
    self:printForecastValue(getText("IGUI_ClimateOptions_TEMPERATURE"), _forecast:getTemperature());
    self:printForecastValue(getText("IGUI_ClimateOptions_HUMIDITY"), _forecast:getHumidity());
    self:printForecastValue(getText("IGUI_Forecaster_WindDirection"), _forecast:getWindDirection(), ClimateManager.getWindAngleString);
    self:printForecastValue(getText("IGUI_Forecaster_WindSpeed"), _forecast:getWindPower(), ClimateManager.ToKph, roundstring);
    self:printForecastValue(getText("IGUI_Forecaster_Cloudiness"), _forecast:getCloudiness());

    self.infoList:addItem("-----------------------------", nil);
    self.infoList:addItem(getText("IGUI_Forecaster_HasFog")..": "..tostring(_forecast:isHasFog()), nil);
    self.infoList:addItem(getText("IGUI_Forecaster_FogStrength")..": "..roundstring(_forecast:getFogStrength()), nil);
    self.infoList:addItem(getText("IGUI_Forecaster_FogDuration")..": "..roundstring(_forecast:getFogDuration()), nil);
    self.infoList:addItem(getText("IGUI_Forecaster_AirfrontType")..": "..tostring(_forecast:getAirFrontString()), nil);
    --self.infoList:addItem("Weather wind: "..roundstring(_forecast:getWeatherWind()), nil);
    local weatherOverlaps = _forecast:getWeatherOverlap()~=nil and true or false;

    if _forecast:isWeatherStarts() or weatherOverlaps then
        self.infoList:addItem(getText("IGUI_Forecaster_SnowChance")..": "..tostring(_forecast:isChanceOnSnow()), nil);
        self.infoList:addItem(getText("IGUI_Forecaster_HeavyRain")..": "..tostring(_forecast:isHasHeavyRain()), nil);
        self.infoList:addItem(getText("IGUI_Forecaster_Storm")..": "..tostring(_forecast:isHasStorm()), nil);
        self.infoList:addItem(getText("IGUI_Forecaster_TropicalStorm")..": "..tostring(_forecast:isHasTropicalStorm()), nil);
        self.infoList:addItem(getText("IGUI_Forecaster_Blizzard")..": "..tostring(_forecast:isHasBlizzard()), nil);

        self.infoList:addItem("--- "..getText("IGUI_Forecaster_TodaysWeather").." ---", nil);
        local s = _forecast:getWeatherStages();
        for i=0, s:size()-1 do
            local index = s:get(i);
            local name = stages[index] or "UNKNOWN";
            self.infoList:addItem(getText("IGUI_Forecaster_Stage", tostring(i))..": "..tostring(name), nil);
        end
    end

    if _forecast:isWeatherStarts() then
        self.infoList:addItem(getText("IGUI_Forecaster_WeatherStarts")..": "..tostring(_forecast:isWeatherStarts()), nil);
        self:populateWeatherInfoList(_forecast);
    end

    if weatherOverlaps then
        self.infoList:addItem(getText("IGUI_Forecaster_WeatherOverlap"), nil);
        self:populateWeatherInfoList(_forecast:getWeatherOverlap(), true);
    end
end

function ForecasterDebug:populateWeatherInfoList(_forecast, _isOverlap)
    if _isOverlap then
        self.infoList:addItem(getText("IGUI_Forecaster_WeatherStartDate")..": ".._forecast:getName(), nil);
    end
    self.infoList:addItem(getText("IGUI_Forecaster_WeatherStartTime")..": "..roundstring(_forecast:getWeatherStartTime()), nil);

    local period = _forecast:getWeatherPeriod();

    self.infoList:addItem(getText("IGUI_Forecaster_Duration")..": "..roundstring(period:getDuration()), nil);
    self.infoList:addItem(getText("IGUI_Forecaster_Strength")..": "..roundstring(period:getTotalStrength()), nil);
    self.infoList:addItem(getText("IGUI_Forecaster_FrontType")..": "..tostring(period:getFrontType()==-1 and getText("IGUI_Forecaster_FrontType_Cold") or getText("IGUI_Forecaster_FrontType_Warm")), nil);

    self.infoList:addItem("--- "..getText("IGUI_Forecaster_FullPattern").." ----", nil);
    local s = period:getWeatherStages();
    for i=0, s:size()-1 do
        local index = s:get(i):getStageID();
        local name = stages[index] or "UNKNOWN";
        self.infoList:addItem(getText("IGUI_Forecaster_Stage", tostring(i))..": "..tostring(name), nil);
    end

end

function ForecasterDebug:drawInfoList(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    self:drawText( item.text, 10, y + 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ForecasterDebug:prerender()
    ISPanel.prerender(self);
    self:populateList();
end

function ForecasterDebug:update()
    ISPanel.update(self);
end

function ForecasterDebug:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ForecasterDebug.instance = nil
end

function ForecasterDebug:new(x, y, width, height, title)
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


