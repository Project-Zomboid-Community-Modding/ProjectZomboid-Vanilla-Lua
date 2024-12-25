--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: yuri				   **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugPanelBase";

UnitTestsDebug = ISDebugPanelBase:derive("UnitTestsDebug");
UnitTestsDebug.instance = nil;

function UnitTestsDebug.OnOpenPanel()
    return ISDebugPanelBase.OnOpenPanel(UnitTestsDebug, 100, 100, 800+(getCore():getOptionFontSizeReal()*100), 600, getText("IGUI_DebugMenu_Dev_UnitTests"));
end

function UnitTestsDebug:new(x, y, width, height, title)
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    local o = ISDebugPanelBase:new(x, y, width, height, title);
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function UnitTestsDebug:initialise()
    ISPanel.initialise(self);
    self:registerPanel(getText("IGUI_UnitTests_TimedActions"),UnitTestsTimedActionsPanel);
end

