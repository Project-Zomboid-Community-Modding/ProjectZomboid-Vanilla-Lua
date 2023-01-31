--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ThermoDebug = {};

ThermoDebug = ISCollapsableWindow:derive("ThermoDebug");
ThermoDebug.instance = nil;

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

    th = th+ 5;

    local y,btn = ISDebugUtils.addButton(self, {}, 5, th, self.width-10, 20, "read values", ThermoDebug.onButton);

    y = y+5;

    self.setY = y;

    self.richtext = ISRichTextPanel:new(0, 0+y, self.width, self.height-(y+10));
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
    self.richtext:setHeight(self.height-(self.setY+10));
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
        self:addLine("upStream", n:hasUpstream());
        self:addLine("downStream", n:hasDownstream());
        self:addLine("distCore", n:getDistToCore());
        self:addLine("skinSurfsace", n:getSkinSurface());
        self:addLine("isCore", n:isCore());
        self:addLine("insulation", n:getInsulation());
        self:addLine("windResist", n:getWindresist());
        self:addLine("celcius", n:getCelcius());
        self:addLine("skinCelcius", n:getSkinCelcius());
        self:addLine("heatDelta", n:getHeatDelta());
        self:addLine("PRIMARY", n:getPrimaryDelta());
        self:addLine("SECONDARY", n:getSecondaryDelta());
        self:addLine("clothingWetness", n:getClothingWetness());
        self:addLine("bodyWetness", n:getBodyWetness());
        self:addLine("bodyResponse", n:getBodyResponse());
        self:addLine("UI skinCelius", n:getSkinCelciusUI());
        self:addLine("UI heatDelta", n:getHeatDeltaUI());
        self:addLine("UI primary", n:getPrimaryDeltaUI());
        self:addLine("UI secondary", n:getSecondaryDeltaUI());
        self:addLine("UI insulation", n:getInsulationUI());
        self:addLine("UI windresist", n:getWindresistUI());
        self:addLine("UI clothingWetness", n:getClothingWetnessUI());
        self:addLine("UI bodyWetness", n:getBodyWetnessUI());
        self:addLine("UI bodyResponse", n:getBodyResponseUI());
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
    o.title = "Thermoregulator debug";
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
