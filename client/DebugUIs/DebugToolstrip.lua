require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

DebugToolstrip = ISPanel:derive("DebugToolstrip");

function DebugToolstrip:onMapClick()
    self.mapWindow = StreamMapWindow:new(150, 150, 700+200, 700);
    self.mapWindow:initialise();
    self.mapWindow:addToUIManager();
end

function DebugToolstrip:onOptionsClick()
    self.settingsWindow = DebugOptionsWindow:new(self.debugOptions:getX(), self.debugOptions:getBottom(), 300, 400)
    self.settingsWindow:initialise()
    self.settingsWindow:addToUIManager()
end

function DebugToolstrip:onDebugLog()
    self.debugLogWindow = DebugLogSettings:new(self.debugLog:getX(), self.debugLog:getBottom(), 300, 400)
    self.debugLogWindow:initialise()
    self.debugLogWindow:setVisible(true)
    self.debugLogWindow:addToUIManager()
end

function DebugToolstrip:onToggleBreak(index, selected)
    UIManager.setShowLuaDebuggerOnError(selected)
end

function DebugToolstrip:onShowErrors()
    if self.errorsWindow == nil then
        self.errorsWindow = DebugErrorsWindow:new(100, 100, 600, 400)
        self.errorsWindow:initialise()
        self.errorsWindow:instantiate()
    end
    self.errorsWindow:setVisible(true)
    self.errorsWindow:addToUIManager()
end

function DebugToolstrip:onButtonStepInto()
    doLuaDebuggerAction("StepInto")
end

function DebugToolstrip:onButtonStepOver()
    doLuaDebuggerAction("StepOver")
end

function DebugToolstrip:onButtonResume()
    doLuaDebuggerAction("Resume")
end

function DebugToolstrip:onComboFont()
    local value = self.comboFont:getOptionData(self.comboFont.selected)
    getCore():setOptionCodeFontSize(value)
end

function DebugToolstrip:prerender()
    if self.width ~= getCore():getScreenWidth() then
        self:setWidth(getCore():getScreenWidth())
    end
    ISPanel.prerender(self)
    self.showDebuggerOnError:setSelected(1, UIManager.isShowLuaDebuggerOnError())
end

function DebugToolstrip:createChildren()
    local x = 24;
    self.mapView = ISButton:new(x, 12, 48, BUTTON_HGT, "Map", self, DebugToolstrip.onMapClick);
    self.mapView:initialise();
    self:addChild(self.mapView);

    self.debugOptions = ISButton:new(self.mapView:getRight() + 24, UI_BORDER_SPACING, 48, BUTTON_HGT, "Options", self, DebugToolstrip.onOptionsClick)
    self.debugOptions:initialise()
    self:addChild(self.debugOptions)

    self.debugLog = ISButton:new(self.debugOptions:getRight() + 24, UI_BORDER_SPACING, 48, BUTTON_HGT, "DebugLog", self, DebugToolstrip.onDebugLog)
    self.debugLog:initialise()
    self:addChild(self.debugLog)

    self.errors = ISButton:new(self.debugLog:getRight() + 24, UI_BORDER_SPACING, 48, BUTTON_HGT, "Errors", self, DebugToolstrip.onShowErrors)
    self.errors:initialise()
    self:addChild(self.errors)

    local tickBox = ISTickBox:new(self.errors:getRight() + 24, UI_BORDER_SPACING, 150, BUTTON_HGT, "", self, DebugToolstrip.onToggleBreak)
    self:addChild(tickBox)
    tickBox:addOption("Break On Error", nil)
    tickBox:setWidthToFit()
    self.showDebuggerOnError = tickBox

    self.buttonStepInto = ISButton:new(tickBox:getRight() + 24, UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "", self, DebugToolstrip.onButtonStepInto)
    self.buttonStepInto:setImage(getTexture("media/ui/debug/DebuggerStepInto.png"))
    self.buttonStepInto:forceImageSize(BUTTON_HGT, BUTTON_HGT)
    self:addChild(self.buttonStepInto)

    self.buttonStepOver = ISButton:new(self.buttonStepInto:getRight() + 20, UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "", self, DebugToolstrip.onButtonStepOver)
    self.buttonStepOver:setImage(getTexture("media/ui/debug/DebuggerStepOver.png"))
    self.buttonStepOver:forceImageSize(BUTTON_HGT, BUTTON_HGT)
    self:addChild(self.buttonStepOver)

    self.buttonResume = ISButton:new(self.buttonStepOver:getRight() + 20, UI_BORDER_SPACING, BUTTON_HGT, BUTTON_HGT, "", self, DebugToolstrip.onButtonResume)
    self.buttonResume:setImage(getTexture("media/ui/debug/DebuggerResume.png"))
    self.buttonResume:forceImageSize(BUTTON_HGT, BUTTON_HGT)
    self:addChild(self.buttonResume)

    local comboHgt = BUTTON_HGT
	self.comboFont = ISComboBox:new(self.width - 24 - 100, (self.height - comboHgt) / 2, 100, BUTTON_HGT, self, DebugToolstrip.onComboFont)
	self.comboFont.anchorLeft = false
	self.comboFont.anchorRight = true
	self.comboFont.font = UIFont.Small
	self.comboFont:initialise()
	self.comboFont:instantiate()
	self:addChild(self.comboFont)

	self.comboFont:addOptionWithData("Small", "Small")
	self.comboFont:addOptionWithData("Medium", "Medium")
	self.comboFont:addOptionWithData("Large", "Large")
	self.comboFont:setWidthToOptions()
	self.comboFont:setX(self.width - 24 - self.comboFont.width)
	self.comboFont:selectData(getCore():getOptionCodeFontSize())
end

function DebugToolstrip:new (x, y, width, height)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.backgroundColor = {r=0.2, g=0.3, b=0.4, a=0.3};
    o.borderColor = {r=1, g=1, b=1, a=0.7};

    return o
end

getTexture("media/ui/debug/DebuggerStepInto.png")
getTexture("media/ui/debug/DebuggerStepOver.png")
getTexture("media/ui/debug/DebuggerResume.png")
