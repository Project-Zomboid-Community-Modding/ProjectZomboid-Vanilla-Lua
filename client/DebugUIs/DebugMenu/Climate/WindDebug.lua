--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************


require "ISUI/ISCollapsableWindow"

WindDebug = ISCollapsableWindow:derive("WindDebug");
WindDebug.instance = nil;
WindDebug.shiftDown = 0;
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function WindDebug.OnOpenPanel()
    if WindDebug.instance==nil then
        WindDebug.instance = WindDebug:new (100, 100, 900, 100, getPlayer());
        WindDebug.instance:initialise();
        WindDebug.instance:instantiate();
    end

    WindDebug.instance:addToUIManager();
    WindDebug.instance:setVisible(true);

    return WindDebug.instance;
end

function WindDebug:initialise()
    ISCollapsableWindow.initialise(self);
end


function WindDebug:createChildren()
    ISCollapsableWindow.createChildren(self);

    self:initVariables();
    local th = self:titleBarHeight();

    local y = th;
    local x = UI_BORDER_SPACING+1+getTextManager():MeasureStringX(UIFont.Small, "-1.0");

    self.historyM1 = ValuePlotter:new(x+UI_BORDER_SPACING,y+UI_BORDER_SPACING,600,FONT_HGT_SMALL*5+UI_BORDER_SPACING*4,600);
    self.historyM1:initialise();
    self.historyM1:instantiate();
    --self.historyM1:defineVariable("temperature", {r=0, g=0, b=1.0, a=1.0}, -50, 50);
    self:addChild(self.historyM1);
    self.historyM1:setVisible(true);


    self.charts = {};
    table.insert(self.charts, self.historyM1);
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
        local btn = ISButton:new(x+UI_BORDER_SPACING, y+UI_BORDER_SPACING, toggleButtonWidth, BUTTON_HGT,getText("IGUI_ClimatePlotter_Toggle"),self, WindDebug.onButtonToggle);
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

function WindDebug:initVariables()
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
    self:addVarInfo("windNoiseBase",getText("IGUI_WindTick_WindNoiseBase"),-1,1,"getDayLightStrength");
    self:addVarInfo("windNoiseFinal",getText("IGUI_WindTick_WindNoiseFinal"),-1,1,"getDayLightStrength");
    self:addVarInfo("windTickFinal",getText("IGUI_WindTick_WindTickFinal"),-1,1,"getDayLightStrength");
end

function WindDebug:addColor(_r,_g,_b)
    table.insert(self.colTable,{r=_r,g=_g,b=_b,a=1.0})
end

function WindDebug:addVarInfo(_name,_desc,_min,_max,_func)
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


function WindDebug:onButton(_btn)
    if _btn.title=="M1" then
        self.historyM1:setVisible(true);
        self.buttonM1:enableAcceptColor()
        self.historyH1:setVisible(false);
        self.buttonH1:enableCancelColor()
        self.historyD1:setVisible(false);
        self.buttonD1:enableCancelColor()
    end
end

function WindDebug:onButtonToggle(_btn)
    if _btn.toggleVarName then
        _btn.toggleVal = not _btn.toggleVal;
        self.historyM1:setVariableEnabled(_btn.toggleVarName,_btn.toggleVal);
        if _btn.toggleVal then
            _btn:enableAcceptColor()
        else
            _btn:enableCancelColor()
        end
    end
end


function WindDebug:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
    --self.richtext:setWidth(self.width);
    --self.richtext:setHeight(self.height-(th+10));
end

local ctr = 0;
function WindDebug:update()
    ISCollapsableWindow.update(self);

    if WindDebug.shiftDown>0 then
        WindDebug.shiftDown = WindDebug.shiftDown-1;
    end

    ctr = ctr+1;
    if ctr>15 then
        ctr = 0;
        local dataset = {
            ClimateManager.getWindNoiseBase(),
            ClimateManager.getWindNoiseFinal(),
            ClimateManager.getWindTickFinal()
        };
        self.historyM1:addPlotPoint(dataset, false);
    end
end

function WindDebug:prerender()
    self:stayOnSplitScreen();
    ISCollapsableWindow.prerender(self);
end

function WindDebug:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end


function WindDebug:render()
    ISCollapsableWindow.render(self);

    if WindDebug.shiftDown>0 then
        WindDebug.shiftDown = WindDebug.shiftDown-1;
    end
end


function WindDebug:close()
    ISCollapsableWindow.close(self);
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, nil)
    end
    WindDebug.instance = nil;
    self:removeFromUIManager();
    self:clear();
end

function WindDebug:clear()
    self.currentTile = nil;
end



function WindDebug:new (x, y, width, height, player)
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
    o.title = getText("IGUI_ClimDebuggers_WindTickDebug");
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
    Events.OnCustomUIKey.Add(WindDebug.OnKeyDown);
    Events.OnKeyKeepPressed.Add(WindDebug.OnKeepKeyDown);
    Events.OnClimateTickDebug.Add(WindDebug.OnClimateTickDebug);
    --Events.OnObjectLeftMouseButtonUp.Add(WindDebug.onMouseButtonUp);
end--]]