--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "DebugUIs/DebugMenu/Base/ISDebugPanelBase";

ClimateControlDebug = ISDebugPanelBase:derive("ClimateControlDebug");
ClimateControlDebug.instance = nil;


function ClimateControlDebug.OnOpenPanel()
    return ISDebugPanelBase.OnOpenPanel(ClimateControlDebug, 100, 100, 800+(getCore():getOptionFontSizeReal()*100), 600, getText("IGUI_ClimateControl_Title"));
end

function ClimateControlDebug:new(x, y, width, height, title)
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    local o = ISDebugPanelBase:new(x, y, width, height, title);
    setmetatable(o, self);
    self.__index = self;
    ISDebugMenu.RegisterClass(self);
    return o;
end

function ClimateControlDebug:initialise()
    ISPanel.initialise(self);
    self:registerPanel(getText("IGUI_ClimateControl_Climate"),ClimateOptionsDebug);
    self:registerPanel(getText("IGUI_ClimateControl_NewFog"), NewFogDebug);
    self:registerPanel(getText("IGUI_ClimateControl_Colors"),ClimateColorsDebug);
    self:registerPanel(getText("IGUI_ClimateControl_Weather"),ISAdmPanelWeather);
    self:registerPanel(getText("IGUI_ClimateControl_Puddles"), PuddlesControl);
    self:registerPanel(getText("IGUI_ClimateControl_Other"),ClimDebuggersPanel);
end

