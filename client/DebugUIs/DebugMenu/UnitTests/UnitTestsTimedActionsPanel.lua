--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: yuri				   **
--***********************************************************
require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase";

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

UnitTestsTimedActionsPanelTestResults = {}
UnitTestsTimedActionsPanelLastStarted = nil
UnitTestsTimedActionsPanelStartedTime = 0.0

UnitTestsTimedActionsPanel = ISDebugSubPanelBase:derive("UnitTestsTimedActionsPanel");

function UnitTestsTimedActionsPanel:initialise()
    ISPanel.initialise(self);
end

function UnitTestsTimedActionsPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y,w = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1,self.width-UI_BORDER_SPACING*3-13;
    local y2, label, runButton, resultLabel;

    local obj
    y2,obj = ISDebugUtils.addButton(self, { id = "runAll" }, x, y, (w-UI_BORDER_SPACING)/2, BUTTON_HGT, getText("IGUI_UnitTests_RunAllTests"), UnitTestsTimedActionsPanel.onRunAllButtonClick);
    y,obj = ISDebugUtils.addButton(self, { id = "stop" }, obj:getRight()+UI_BORDER_SPACING, y, (w+UI_BORDER_SPACING)/2, BUTTON_HGT, getText("IGUI_UnitTests_Stop"), UnitTestsTimedActionsPanel.onStopButtonClick)
    y = y + UI_BORDER_SPACING;
    
    self.tests = TimedActionTests.getTests()

    local nameWidth = 0
    for name,func in pairs(self.tests) do
        nameWidth = math.max(nameWidth, UI_BORDER_SPACING+getTextManager():MeasureStringX(UIFont.Small, name))
    end

    for name,func in pairs(self.tests) do

        y2,label = ISDebugUtils.addLabel(self,name,x,y,name, UIFont.Small);

        y2,runButton = ISDebugUtils.addButton(self, { id = "run", name=name }, x+nameWidth, y, (UI_BORDER_SPACING*2)+getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_UnitTests_Run")), BUTTON_HGT, getText("IGUI_UnitTests_Run"), UnitTestsTimedActionsPanel.onRunOneButtonClick);

        y,resultLabel = ISDebugUtils.addLabel(self,{ id = "result", name=name },runButton:getRight()+UI_BORDER_SPACING, y+3,getText("IGUI_UnitTests_Untested"), UIFont.Small);
        resultLabel.r = 0.4
        resultLabel.g = 0.4
        resultLabel.b = 0.4

        UnitTestsTimedActionsPanelTestResults[name] = {}
        UnitTestsTimedActionsPanelTestResults[name].label = label
        UnitTestsTimedActionsPanelTestResults[name].runButton = runButton
        UnitTestsTimedActionsPanelTestResults[name].resultLabel = resultLabel
        y = y2 +UI_BORDER_SPACING;
    end

    self:setScrollHeight(y+UI_BORDER_SPACING+1);
end

function UnitTestsTimedActionsPanel:onRunAllButtonClick(_button)
    TimedActionTests.runAll()
end

function UnitTestsTimedActionsPanel:onStopButtonClick(_button)
    TimedActionTests.stop()
end

function UnitTestsTimedActionsPanel:onRunOneButtonClick(_button)
    if _button.customData then
        TimedActionTests.runOne(_button.customData.name)
        return;
    end
end

function UnitTestsTimedActionsPanel:prerender()
    ISDebugSubPanelBase.prerender(self);
end

function UnitTestsTimedActionsPanel:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
    local v = _tickbox.customData;
    v.lua.cheat = not v.lua.cheat;
end

function UnitTestsTimedActionsPanel:update()
    ISPanel.update(self);
end

function UnitTestsTimedActionsPanel:new(x, y, width, height, doStencil)
    local o = {};
    o = ISDebugSubPanelBase:new(x, y, width, height, doStencil);
    setmetatable(o, self);
    self.__index = self;
    return o;
end

UnitTestsTimedActionsPanel.onStartTest = function(name)
    UnitTestsTimedActionsPanel.onSuccess()

    UnitTestsTimedActionsPanelTestResults[name].resultLabel.name = "Started"
    UnitTestsTimedActionsPanelTestResults[name].resultLabel.r = 1.0
    UnitTestsTimedActionsPanelTestResults[name].resultLabel.g = 1.0
    UnitTestsTimedActionsPanelTestResults[name].resultLabel.b = 0.2
    UnitTestsTimedActionsPanelStartedTime = getTimeInMillis()
    UnitTestsTimedActionsPanelLastStarted = name
end

UnitTestsTimedActionsPanel.onFail = function()
    if UnitTestsTimedActionsPanelLastStarted ~= nil then
        local time = getTimeInMillis() - UnitTestsTimedActionsPanelStartedTime
        UnitTestsTimedActionsPanelTestResults[UnitTestsTimedActionsPanelLastStarted].resultLabel.name = getText("IGUI_UnitTests_Fail").." ("..tostring(time/1000.0).."s)"
        UnitTestsTimedActionsPanelTestResults[UnitTestsTimedActionsPanelLastStarted].resultLabel.r = getCore():getBadHighlitedColor():getR()
        UnitTestsTimedActionsPanelTestResults[UnitTestsTimedActionsPanelLastStarted].resultLabel.g = getCore():getBadHighlitedColor():getG()
        UnitTestsTimedActionsPanelTestResults[UnitTestsTimedActionsPanelLastStarted].resultLabel.b = getCore():getBadHighlitedColor():getB()
        UnitTestsTimedActionsPanelLastStarted = nil
    end
end

UnitTestsTimedActionsPanel.onSuccess = function()
    if UnitTestsTimedActionsPanelLastStarted ~= nil then
        local time = getTimeInMillis() - UnitTestsTimedActionsPanelStartedTime
        UnitTestsTimedActionsPanelTestResults[UnitTestsTimedActionsPanelLastStarted].resultLabel.name = getText("IGUI_UnitTests_Success").." ("..tostring(time/1000.0).."s)"
        UnitTestsTimedActionsPanelTestResults[UnitTestsTimedActionsPanelLastStarted].resultLabel.r = getCore():getGoodHighlitedColor():getR()
        UnitTestsTimedActionsPanelTestResults[UnitTestsTimedActionsPanelLastStarted].resultLabel.g = getCore():getGoodHighlitedColor():getG()
        UnitTestsTimedActionsPanelTestResults[UnitTestsTimedActionsPanelLastStarted].resultLabel.b = getCore():getGoodHighlitedColor():getB()
        UnitTestsTimedActionsPanelLastStarted = nil
    end
end

DoLuaError = function (f, line)
    UnitTestsTimedActionsPanel.onFail()
end
