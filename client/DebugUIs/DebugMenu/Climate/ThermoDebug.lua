--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ThermoDebug = {};

ThermoDebug = ISCollapsableWindow:derive("ThermoDebug");
ThermoDebug.instance = nil;
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10

function ThermoDebug.OnOpenPanel()
    if ThermoDebug.instance==nil then
        ThermoDebug.instance = ThermoDebug:new (100, 100, 400, 600, getPlayer());
        ThermoDebug.instance:initialise();
        ThermoDebug.instance:instantiate();
    end

    ThermoDebug.instance:addToUIManager();
    ThermoDebug.instance:setVisible(true);

    return ThermoDebug.instance;
end

function ThermoDebug:close()
    ISCollapsableWindow.close(self);
    self:removeFromUIManager();
    ThermoDebug.instance = nil;
end

function ThermoDebug:initialise()
    ISCollapsableWindow.initialise(self);
end

function ThermoDebug:createChildren()
    ISCollapsableWindow.createChildren(self);

    local th = self:titleBarHeight();

    th = th + UI_BORDER_SPACING+1;

    local y,btn = ISDebugUtils.addButton(self, {}, UI_BORDER_SPACING+1, th, self.width-(UI_BORDER_SPACING+1)*2, BUTTON_HGT, getText("IGUI_ThermoDebug_ReadValues"), ThermoDebug.onButton);

    y = y + UI_BORDER_SPACING;

    --avoid using setY, as that breaks the window dragging

    self.richtext = ISRichTextPanel:new(0, y, self.width, self.height - th - UI_BORDER_SPACING*2 - 2 - BUTTON_HGT);
    --height minus height of title bar, button, bottom bar, and 5px gaps above and below the button^
    self.richtext:initialise();

    self:addChild(self.richtext);

    self.richtext.background = false;
    self.richtext.autosetheight = false;
    self.richtext.clip = true
    self.richtext:addScrollBars();

    self.richtext.text = "";
    self.richtext:paginate();
end

function ThermoDebug:onButton(_btn)
    self:readThermos();
end

function ThermoDebug:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
    self.richtext:setWidth(self.width);
    self.richtext:setHeight(self.height - th - UI_BORDER_SPACING*2 - 2 - BUTTON_HGT);
end

function ThermoDebug:update()
    ISCollapsableWindow.update(self);
end

function ThermoDebug:prerender()
    self:stayOnSplitScreen();
    ISCollapsableWindow.prerender(self);
end

function ThermoDebug:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end

function ThermoDebug:readThermos()
    self.tmpTxt = "";
    local thermos = self.player:getBodyDamage():getThermoregulator();

    for i=0,thermos:getNodeSize()-1 do
        local n = thermos:getNode(i);

        self:addTitle(n:getName());
        self:addLine(getText("IGUI_ThermoDebug_UpStream"), n:hasUpstream());
        self:addLine(getText("IGUI_ThermoDebug_DownStream"), n:hasDownstream());
        self:addLine(getText("IGUI_ThermoDebug_DistCore"), n:getDistToCore());
        self:addLine(getText("IGUI_ThermoDebug_SkinSurface"), n:getSkinSurface());
        self:addLine(getText("IGUI_ThermoDebug_IsCore"), n:isCore());
        self:addLine(getText("IGUI_ThermoDebug_Insulation"), n:getInsulation());
        self:addLine(getText("IGUI_ThermoDebug_WindResist"), n:getWindresist());
        self:addLine(getText("IGUI_ThermoDebug_Celcius"), n:getCelcius());
        self:addLine(getText("IGUI_ThermoDebug_SkinCelcius"), n:getSkinCelcius());
        self:addLine(getText("IGUI_ThermoDebug_HeatDelta"), n:getHeatDelta());
        self:addLine(getText("IGUI_ThermoDebug_Primary"), n:getPrimaryDelta());
        self:addLine(getText("IGUI_ThermoDebug_Secondary"), n:getSecondaryDelta());
        self:addLine(getText("IGUI_ThermoDebug_ClothingWetness"), n:getClothingWetness());
        self:addLine(getText("IGUI_ThermoDebug_BodyWetness"), n:getBodyWetness());
        self:addLine(getText("IGUI_ThermoDebug_BodyResponse"), n:getBodyResponse());
        self:addLine(getText("IGUI_ThermoDebug_UIskinCelius"), n:getSkinCelciusUI());
        self:addLine(getText("IGUI_ThermoDebug_UIHeatDelta"), n:getHeatDeltaUI());
        self:addLine(getText("IGUI_ThermoDebug_UIPrimary"), n:getPrimaryDeltaUI());
        self:addLine(getText("IGUI_ThermoDebug_UISecondary"), n:getSecondaryDeltaUI());
        self:addLine(getText("IGUI_ThermoDebug_UIInsulation"), n:getInsulationUI());
        self:addLine(getText("IGUI_ThermoDebug_UIWindResist"), n:getWindresistUI());
        self:addLine(getText("IGUI_ThermoDebug_UIClothingWetness"), n:getClothingWetnessUI());
        self:addLine(getText("IGUI_ThermoDebug_UIBodyWetness"), n:getBodyWetnessUI());
        self:addLine(getText("IGUI_ThermoDebug_UIBodyResponse"), n:getBodyResponseUI());
    end

    self.richtext.text = self.tmpTxt;
    self.richtext:paginate();
end

function ThermoDebug:render()
    ISCollapsableWindow.render(self);

    self.richtext:clearStencilRect();
end

function ThermoDebug:addTitle(_title)
    self.tmpTxt = self.tmpTxt .. " <H2> <ORANGE> "..tostring(_title).." <LINE> ";
end

function ThermoDebug:addLine(_prefix, _line)
    --if _prefix:len()<40 then
    --_prefix = _prefix .. string.rep(" ",40-_prefix:len());
    --end
    self.tmpTxt = self.tmpTxt .. " <TEXT> "..tostring(_prefix)..": "..tostring(_line).." <LINE> ";
end

function ThermoDebug:addLineEnd()
    --if _prefix:len()<40 then
    --_prefix = _prefix .. string.rep(" ",40-_prefix:len());
    --end
    self.tmpTxt = self.tmpTxt .." <LINE> ";
end

function ThermoDebug:new (x, y, width, height, player)
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
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.pin = true;
    o.isCollapsed = false;
    o.collapseCounter = 0;
    o.title = getText("IGUI_ClimDebuggers_Thermoregulator");
    --o.viewList = {}
    o.resizable = true;
    o.drawFrame = true;

    o.currentTile = nil;
    o.richtext = nil;
    o.overrideBPrompt = true;
    o.subFocus = nil;
    o.hotKeyPanels = {};
    o.isJoypadWindow = false;
    return o
end
