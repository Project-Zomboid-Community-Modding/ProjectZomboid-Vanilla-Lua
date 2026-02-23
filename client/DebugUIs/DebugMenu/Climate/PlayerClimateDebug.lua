require "ISUI/ISCollapsableWindow"

PlayerClimateDebug = ISCollapsableWindow:derive("PlayerClimateDebug");
PlayerClimateDebug.instance = nil;
PlayerClimateDebug.shiftDown = 0;
PlayerClimateDebug.eventsAdded = false;
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10

function PlayerClimateDebug.OnOpenPanel()
    PlayerClimateDebug.fx = getCell():getWeatherFX();
    PlayerClimateDebug.cm = getClimateManager();

    if PlayerClimateDebug.instance==nil then
        PlayerClimateDebug.instance = PlayerClimateDebug:new (100, 100, 400+(getCore():getOptionFontSizeReal()*50), 600, getPlayer());
        PlayerClimateDebug.instance:initialise();
        PlayerClimateDebug.instance:instantiate();
    end

    PlayerClimateDebug.instance:addToUIManager();
    PlayerClimateDebug.instance:setVisible(true);

    if not PlayerClimateDebug.eventsAdded then
        Events.OnClimateTickDebug.Add(PlayerClimateDebug.onClimateTickDebug);
        PlayerClimateDebug.eventsAdded = true;
    end

    return PlayerClimateDebug.instance;
end

function PlayerClimateDebug:initialise()
    ISCollapsableWindow.initialise(self);
end

function PlayerClimateDebug:createChildren()
    ISCollapsableWindow.createChildren(self);
    self.panel = ISPanel:new(0, self:titleBarHeight(), self.width, self.height-self:titleBarHeight()-self:resizeWidgetHeight())
    self.panel.prerender = function(self)
        self:setStencilRect(0, 0, self:getWidth(), self:getHeight())
        ISPanel.prerender(self)
    end
    self.panel.render = function(self)
        ISPanel.render(self)
        self:clearStencilRect()
    end
    self.panel.onMouseWheel = function(self, del)
        if self:getScrollHeight() > 0 then
            self:setYScroll(self:getYScroll() - (del * 40))
            return true
        end
        return false
    end
    self.panel:initialise()
    self.panel:instantiate()
    self.panel:noBackground()
    self.panel:setScrollChildren(true)
    self:addChild(self.panel)
    self:initVariables();

    local y, lbl = 0, nil;

    self.labels = {};
    self.tempColor = {r=1.0,g=1.0,b=1.0,a=1.0};
    self.colWhite = {r=1,g=1,b=1,a=1};
    self.clrRed = {r=1,g=0,b=0,a=1};
    self.clrOrangeRed = {r=1.000,g=0.271,b=0,a=1};
    self.clrGold = {r=1.000,g=0.843,b=0,a=1};
    self.clrGreenYellow = {r=0.678,g=1,b=0.184,a=1};
    self.clrGreen = {r=0.000,g=0.502,b=0,a=1};

    for k,v in ipairs(self.vars) do
        if v.isValue then
            y, lbl = self:addLabelValue(y,"value",v.variable,v.title,v.defaultVal,v.color,v.postfix);
        else
            y = y+10;
            y, lbl = self:addLabel(y,v.variable,v.title,"");
        end
    end
    self.panel:addScrollBars();
    self.panel:setScrollHeight(y+10);
end

function PlayerClimateDebug:initVariables()
    local thermos = self.player:getBodyDamage():getThermoregulator();
    local body = self.player:getBodyDamage();
    local nutrition = self.player:getNutrition();
    local climate = getClimateManager();

    self.vars = {};
    self:registerVariable("title_main",getText("IGUI_PlayerClimate_MainTitle"),false);
    self:registerVariable("getMetabolicTarget", getText("IGUI_PlayerClimate_MetabolicTarget") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getMetabolicRate", getText("IGUI_PlayerClimate_BaseMetabolic") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getMetabolicRateReal", getText("IGUI_PlayerClimate_RealMetabolic") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getDbg_totalHeatRaw", getText("IGUI_PlayerClimate_BodyHeatIORaw") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getDbg_totalHeat", getText("IGUI_PlayerClimate_BodyHeatIO") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getBodyHeatDelta", getText("IGUI_PlayerClimate_BodyHeatDelta") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getSetPoint", getText("IGUI_PlayerClimate_CoreSetpoint") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getCoreHeatDelta", getText("IGUI_PlayerClimate_CoreHeatDelta") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getCoreRateOfChange", getText("IGUI_PlayerClimate_CoreROC") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getCoreCelcius", getText("IGUI_PlayerClimate_CoreC") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getDbg_primTotal", getText("IGUI_PlayerClimate_PrimTotal") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getDbg_secTotal", getText("IGUI_PlayerClimate_SecTotal") ..":", true, thermos, 0, nil, nil);

    self:registerVariable("title_resources",getText("IGUI_PlayerClimate_BodyResourcesTitle"),false);
    self:registerVariable("getEnergy", getText("IGUI_PlayerClimate_Energy") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getEnergyMultiplier", getText("IGUI_PlayerClimate_EnergyDrainMulti") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getBodyFluids", getText("IGUI_PlayerClimate_Fluids") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getFluidsMultiplier", getText("IGUI_PlayerClimate_FluidDrainMulti") ..":", true, thermos, 0, nil, nil);

    self:registerVariable("title_other",getText("IGUI_PlayerClimate_OtherTitle"),false);
    self:registerVariable("getCatchAColdDelta", getText("IGUI_PlayerClimate_CatchColdDelta") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getTimedActionTimeModifier", getText("IGUI_PlayerClimate_TimedActionMod") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getThermalDamage", getText("IGUI_PlayerClimate_ThermalDamage") ..":", true, thermos, 0, nil, nil);

    self:registerVariable("title_climate",getText("IGUI_PlayerClimate_ClimateTitle"),false);
    self:registerVariable("getTemperatureAir", getText("IGUI_PlayerClimate_BaseAirTemp") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getTemperatureAirAndWind", getText("IGUI_PlayerClimate_AirWindTemp") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getHumidity", getText("IGUI_ClimateOptions_HUMIDITY") ..":", true, climate, 0, nil, nil);

    self:registerVariable("title_modifiers",getText("IGUI_PlayerClimate_MultiplierTitle"),false);
    self:registerVariable("getSimulationMultiplier", getText("IGUI_PlayerClimate_SimulationMulti") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getDefaultMultiplier", getText("IGUI_PlayerClimate_Default") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getMetabolicRateIncMultiplier", getText("IGUI_PlayerClimate_MetabolicInc") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getMetabolicRateDecMultiplier", getText("IGUI_PlayerClimate_MetabolicDec") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getBodyHeatMultiplier", getText("IGUI_PlayerClimate_BodyHeat") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getCoreHeatExpandMultiplier", getText("IGUI_PlayerClimate_CoreHeatExpand") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getCoreHeatContractMultiplier", getText("IGUI_PlayerClimate_CoreHeatContract") ..":", true, thermos, 0, nil, nil);
    self:registerVariable("getSkinCelciusMultiplier", getText("IGUI_PlayerClimate_SkinC") ..":", true, thermos, 0, nil, nil);

    self:registerVariable("title_stats",getText("IGUI_PlayerClimate_StatsTitle"),false);

    self:registerVariable("title_body",getText("IGUI_PlayerClimate_BodyTitle"),false);
    self:registerVariable("getColdStrength", getText("IGUI_StatsAndBody_ColdStrength") ..":", true, body, 0, nil, nil);
    self:registerVariable("getCatchACold", getText("IGUI_PlayerClimate_CatchCold") ..":", true, body, 0, nil, nil);

    self:registerVariable("title_nutrition",getText("IGUI_PlayerClimate_NutritionTitle"),false);
    self:registerVariable("getWeight", getText("IGUI_PlayerClimate_Weight") ..":", true, nutrition, 0, nil, nil);
end

function PlayerClimateDebug:registerVariable(_variable,_title,_isValue, _javaInstance, _defaultVal,_color,_postfix)
    table.insert(self.vars, {
        variable = _variable,
        title = _title,
        isValue = _isValue,
        defaultVal = _defaultVal,
        color = _color,
        postfix = _postfix,
        javaInstance = _javaInstance,
    });
end

function PlayerClimateDebug:addLabel(_curY, _labelID, _title)
    if not self.labels[_labelID] then
        local label = {};
        label.titleLabel = ISLabel:new(self.width/2-(getTextManager():MeasureStringX(UIFont.Small, _title)/2), _curY, FONT_HGT_SMALL, _title, 1, 1, 1, 1.0, UIFont.Small, true);
        label.titleLabel:initialise();
        label.titleLabel:instantiate();
        self.panel:addChild(label.titleLabel);

        self.labels[_labelID] = label;

        _curY = label.titleLabel:getY() + label.titleLabel:getHeight();
    else
        print("Cannot add label: "..tostring(_labelID));
    end
    return _curY;
end

function PlayerClimateDebug:addLabelValue(_curY, _type, _labelID, _title, _defaultVal, _col, _extension)
    local outLabel = nil;
    if not _col then
        _col = { r=1,g=1,b=1,a=1};
    end
    if not self.labels[_labelID] then
        local label = {};
        label.titleLabel = ISLabel:new(UI_BORDER_SPACING+1, _curY, FONT_HGT_SMALL, _title, 1, 1, 1, 1.0, UIFont.Small, true);
        label.titleLabel:initialise();
        label.titleLabel:instantiate();
        self.panel:addChild(label.titleLabel);

        if not _col then
            _col = self.colWhite;
        else
            label.hasCustCol = true;
        end

        if _type=="value" then
            label.valueLabel = ISLabel:new(self.width-(self.width/3), _curY, FONT_HGT_SMALL, tostring(_defaultVal), _col.r, _col.g, _col.b, 1.0, UIFont.Small, true);
            label.valueLabel:initialise();
            label.valueLabel:instantiate();
            self.panel:addChild(label.valueLabel);
        elseif _type=="color" then
            label.valueLabel = ISPanel:new(self.width-(self.width/2), _curY+4, (self.width/3)-4, 10);
            label.valueLabel:initialise();
            label.valueLabel.backgroundColor = _defaultVal or {r=1.0,g=1.0,b=1.0,a=1.0};
            self.panel:addChild(label.valueLabel);
        end

        if _extension then
            label.extLabel = ISLabel:new(self.width-(self.width/3), _curY, FONT_HGT_SMALL, tostring(_extension), 1, 1, 1, 1.0, UIFont.Small, true);
            label.extLabel:initialise();
            label.extLabel:instantiate();
            self.panel:addChild(label.extLabel);
        end

        self.labels[_labelID] = label;
        outLabel = label;

        _curY = label.titleLabel:getY() + label.titleLabel:getHeight();
    else
        print("Cannot add label: "..tostring(_labelID));
    end
    return _curY, outLabel;
end

function PlayerClimateDebug:getTitleLabel(_labelID)
    if self.labels[_labelID] then
        return self.labels[_labelID].titleLabel;
    end
end

function PlayerClimateDebug:getValueLabel(_labelID)
    if self.labels[_labelID] then
        return self.labels[_labelID].valueLabel;
    end
end

function PlayerClimateDebug:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
    self.panel:setWidth(self.width);
    self.panel:setHeight(self.height-(th+10))
end

local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function PlayerClimateDebug:update()
    ISCollapsableWindow.update(self);

    for k,v in ipairs(self.vars) do
        if v.isValue then
            local l = self:getValueLabel(v.variable);
            local value = v.javaInstance[v.variable](v.javaInstance);
            l:setName( ""..tostring(round(value,6)) );
        end
    end
end

function PlayerClimateDebug:updateOLD()
    ISCollapsableWindow.update(self);

    if PlayerClimateDebug.shiftDown>0 then
        PlayerClimateDebug.shiftDown = PlayerClimateDebug.shiftDown-1;
    end

    if not vars.isInside then
        self:getValueLabel("isInside").name = "false";
    end

    local c = self.colWhite;
    local doCol = false;
    local val = 1;
    for k,v in pairs(vars) do
        doCol = false;
        if type(v)=="number" then
            local l = self:getValueLabel(k);
            if l then
                if l.colByValue then
                    doCol = true;
                    if v<=0 then
                        c = self.colRed;
                    else
                        c = self.colBlue;
                    end
                elseif l.colUnitInv or l.colUnit or l.colUnit2 or k=="clothingFinal" then
                    doCol = true;
                    val = v;
                    if l.colUnitInv then
                        val = 1-v;
                    end
                    if l.colUnit2 then
                        val = v/2;
                    end
                    if val>0.8 then
                        c = self.clrGreen;
                    elseif val>0.6 then
                        c = self.clrGreenYellow;
                    elseif val>0.4 then
                        c = self.clrGold;
                    elseif val>0.2 then
                        c = self.clrOrangeRed;
                    else
                        c = self.clrRed;
                    end
                elseif l.colUnitMinPlus then
                    doCol = true;
                    val = v;
                    if val>0.6 then
                        c = self.clrGreen;
                    elseif val>0.2 then
                        c = self.clrGreenYellow;
                    elseif val>-0.2 then
                        c = self.clrGold;
                    elseif val>-0.6 then
                        c = self.clrOrangeRed;
                    else
                        c = self.clrRed;
                    end
                elseif k=="playerTemp" then
                    doCol = true;
                    local hypo = getPlayer():getMoodles():getMoodleLevel(MoodleType.HYPOTHERMIA);
                    local hyper = getPlayer():getMoodles():getMoodleLevel(MoodleType.HYPERTHERMIA);
                    if hypo==1 or hyper==1 then
                        c = self.clrGreenYellow;
                    elseif hypo==2 or hyper==2 then
                        c = self.clrGold;
                    elseif hypo==3 or hyper==3 then
                        c = self.clrOrangeRed;
                    elseif hypo==4 or hyper==4 then
                        c = self.clrRed;
                    else
                        c = self.clrGreen;
                    end
                    self:getValueLabel("hypoState").name = tostring(hypo);
                    self:getValueLabel("hyperState").name = tostring(hyper);
                end
                if doCol then
                    l.r = c.r;
                    l.b = c.b;
                    l.g = c.g;
                end
                l.name = ""..tostring(round(v,3));
            end
        elseif type(v)=="boolean" then
            self:getValueLabel(k).name = v==true and "true" or "false";
        else
            self:getValueLabel(k).name = ""..tostring(v);
        end
    end
end

function PlayerClimateDebug:prerender()
    self:stayOnSplitScreen();
    ISCollapsableWindow.prerender(self);
end

function PlayerClimateDebug:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end

function PlayerClimateDebug:render()
    ISCollapsableWindow.render(self);
end

function PlayerClimateDebug:close()
    ISCollapsableWindow.close(self);
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, nil)
    end
    self:removeFromUIManager();
    self:clear();
end

function PlayerClimateDebug:clear()
    self.currentTile = nil;

    if isDebugEnabled() then
        PlayerClimateDebug.instance = nil;
    end
end

function PlayerClimateDebug:new (x, y, width, height, player)
    local o = {}
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
    o.title = getText("IGUI_ClimDebuggers_PlayerTemp");
    o.resizable = true;
    o.drawFrame = true;

    o.currentTile = nil;
    o.richtext = nil;
    o.overrideBPrompt = true;
    o.subFocus = nil;
    o.hotKeyPanels = {};
    o.isJoypadWindow = false;
    ISDebugMenu.RegisterClass(self);
    return o
end
