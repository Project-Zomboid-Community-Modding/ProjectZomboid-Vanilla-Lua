require "DebugUIs/DebugMenu/Base/ISDebugPanelBase";

ISGeneralDebug = ISDebugPanelBase:derive("ISGeneralDebug");
ISGeneralDebug.instance = nil;

function ISGeneralDebug.OnOpenPanel()
    return ISDebugPanelBase.OnOpenPanel(ISGeneralDebug, 100, 100, 800+(getCore():getOptionFontSizeReal()*100), 600, getText("IGUI_GeneralDebug_Title"));
end

function ISGeneralDebug:new(x, y, width, height, title)
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    local o = ISDebugPanelBase:new(x, y, width, height, title);
    setmetatable(o, self);
    self.__index = self;
    return o;
end

function ISGeneralDebug:initialise()
    ISPanel.initialise(self);
    self:registerPanel(getText("IGUI_GeneralDebug_Game"),ISGameDebugPanel, true);
    self:registerPanel(getText("IGUI_GeneralDebug_Body"),ISStatsAndBody);
    --self:registerPanel("General Cheats",ISGeneralCheats);
    self:registerPanel(getText("IGUI_GeneralDebug_Blood"), ISDebugBlood);
    self:registerPanel(getText("IGUI_GeneralDebug_Search"), ISSearchMode);
end

