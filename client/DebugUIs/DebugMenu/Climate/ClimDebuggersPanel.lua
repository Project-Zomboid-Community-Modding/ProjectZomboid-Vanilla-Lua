--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase";

ClimDebuggersPanel = ISDebugSubPanelBase:derive("ClimDebuggersPanel");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

function ClimDebuggersPanel:initialise()
    ISPanel.initialise(self);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_Forecaster"), ForecasterDebug.OnOpenPanel);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_WeatherFX"), WeatherFXDebug.OnOpenPanel);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_PlayerTemp"), PlayerClimateDebug.OnOpenPanel);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_Thermoregulator"), ThermoDebug.OnOpenPanel);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_DailyVal"), DailyValuesDebug.OnOpenPanel);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_ClimatePlot"), ClimateDebug.OnOpenPanel);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_WeatherPlot"), WeatherPeriodDebug.OnOpenPanel);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_Thunderbug"), ThunderDebug.OnOpenPanel);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_WindTickDebug"), WindDebug.OnOpenPanel, UI_BORDER_SPACING*2);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_SimTest_Current"), ClimDebuggersPanel.OnSimulationButton, UI_BORDER_SPACING*2);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_SimTest_Drier"), ClimDebuggersPanel.OnSimulationButtonOverride, 0, 1);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_SimTest_Dry"), ClimDebuggersPanel.OnSimulationButtonOverride, 0, 2);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_SimTest_Normal"), ClimDebuggersPanel.OnSimulationButtonOverride, 0, 3);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_SimTest_Wet"), ClimDebuggersPanel.OnSimulationButtonOverride, 0, 4);
    self:addButtonInfo(getText("IGUI_ClimDebuggers_SimTest_Wetter"), ClimDebuggersPanel.OnSimulationButtonOverride, 0, 5);
end

function ClimDebuggersPanel:addButtonInfo(_title, _func, _marginBot, _arg)
    self.buttons = self.buttons or {};

    table.insert(self.buttons, { title = _title, func = _func, arg = _arg, marginBot = (_marginBot or 0) })
end

function ClimDebuggersPanel:createChildren()
    ISPanel.createChildren(self);

    local v, obj;

    local needsScrollBar = 1
    if self.height > BUTTON_HGT*15 + UI_BORDER_SPACING*19 + 2 then
        needsScrollBar = 0
    end

    local x,y,w = UI_BORDER_SPACING+1,1,self.width-UI_BORDER_SPACING*2 - SCROLL_BAR_WIDTH*needsScrollBar - 1;

    self:initHorzBars(x,w);

    local h = BUTTON_HGT;
    --y, obj = ISDebugUtils.addButton(self,"TriggerStorm",x+100,rowY+10,w-200,20,getText("IGUI_climate_TriggerStorm"), ISAdmPanelWeather.onClick);
    if self.buttons then
        for k,v in ipairs(self.buttons)  do
            y, obj = ISDebugUtils.addButton(self,v,x,y+UI_BORDER_SPACING,w,h,v.title,ClimDebuggersPanel.onClick);
            if k == 10 then --just under "onSimulationButton"
                y, obj = ISDebugUtils.addLabel(self,"freeze_note",x+(w/2),y,getText("IGUI_ClimDebuggers_FreezeNote"), UIFont.Small);
                obj.center = true;
            end
            if v.marginBot and v.marginBot>0 then
                y = y+v.marginBot;
            end
            end
    end

    self:setScrollHeight(y+UI_BORDER_SPACING+1);
end



function ClimDebuggersPanel:prerender()
    ISDebugSubPanelBase.prerender(self);
end

function ClimDebuggersPanel:onClick(_button)
    if _button.customData.func then
        if _button.customData.arg then
            _button.customData.func(_button.customData.arg);
        else
            _button.customData.func();
        end
    end
end

function ClimDebuggersPanel:onSliderChange(_newval, _slider)
end

function ClimDebuggersPanel:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
end

function ClimDebuggersPanel:onTickedValue(_index, _selected, _arg1, _arg2, _tickbox)
end

function ClimDebuggersPanel:update()
    ISPanel.update(self);
end

function ClimDebuggersPanel.OnSimulationButton()
    getClimateManager():execute_Simulation();
end

function ClimDebuggersPanel.OnSimulationButtonOverride(_rainModOverride)
    getClimateManager():execute_Simulation(_rainModOverride);
end

function ClimDebuggersPanel:new(x, y, width, height, doStencil)
    local o = {};
    o = ISDebugSubPanelBase:new(x, y, width, height, doStencil);
    setmetatable(o, self);
    self.__index = self;
    return o;
end

