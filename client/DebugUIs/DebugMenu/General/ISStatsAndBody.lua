--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase";

ISStatsAndBody = ISDebugSubPanelBase:derive("ISStatsAndBody");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

function ISStatsAndBody:initialise()
    ISPanel.initialise(self);
end

function ISStatsAndBody:createChildren()
    ISPanel.createChildren(self);

    local x,y,w = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1,self.width-UI_BORDER_SPACING*2 - SCROLL_BAR_WIDTH - 1;

    self:initHorzBars(x,w);

    local obj;
    y, obj = ISDebugUtils.addLabel(self,"float_title",x+(w/2),y,getText("IGUI_StatsAndBody_Title"), UIFont.Medium);
    obj.center = true;
    y, obj = ISDebugUtils.addLabel(self,"float_title",x+(w/2),y,getText("IGUI_StatsAndBody_MoraleInfo"), UIFont.Small);
    obj.center = true;
    y, obj = ISDebugUtils.addLabel(self,"float_title",x+(w/2),y,getText("IGUI_StatsAndBody_PainInfo"), UIFont.Small);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+UI_BORDER_SPACING)+UI_BORDER_SPACING+1;

    local player = getPlayer();
    local stats = player:getStats();
    local body = player:getBodyDamage();
    local nutrition = player:getNutrition()
    self.sliderOptions = {};
    self.boolOptions = {};

    local op = self:addSliderOption(stats,"Hunger", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Hunger");
    op = self:addSliderOption(body,"HealthFromFoodTimer", 0, 10000);
    op.title = getText("IGUI_StatsAndBody_HealthFromFoodTimer");
    op = self:addSliderOption(stats,"Thirst", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Thirst");
    op = self:addSliderOption(stats,"Fatigue", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Fatigue");
    op = self:addSliderOption(stats,"Endurance", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Endurance");
    op = self:addSliderOption(stats,"Fitness", 0, 2); -- -1 to 1, use applymod due to slider
    op.applyMod = 1;
    op.title = getText("IGUI_StatsAndBody_Fitness");
    op = self:addSliderOption(stats,"Drunkenness", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_Drunkenness");
    op = self:addSliderOption(stats,"Anger", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Anger");
    op = self:addSliderOption(stats,"Fear", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Fear");
    op = self:addSliderOption(stats,"Pain", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_Pain");
    op = self:addSliderOption(stats,"Panic", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_Panic");
    op = self:addSliderOption(stats,"Morale", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Morale");
    op = self:addSliderOption(stats,"Stress", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Stress");
    op = self:addSliderOption(stats,"StressFromCigarettes", 0, stats:getMaxStressFromCigarettes());
    op.title = getText("IGUI_StatsAndBody_StressFromCigarettes");
    op = self:addSliderOption(player,"TimeSinceLastSmoke", 0, 10);
    op.title = getText("IGUI_StatsAndBody_TimeSinceLastSmoke");
    op = self:addSliderOption(body,"BoredomLevel", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_BoredomLevel");
    op = self:addSliderOption(stats,"Idleness", 0, 1, 0.001);
    op.title = getText("IGUI_StatsAndBody_Idleness");
    op = self:addSliderOption(body,"UnhappynessLevel", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_UnhappynessLevel");
    op = self:addSliderOption(stats,"Sanity", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Sanity");
    op = self:addSliderOption(body,"DiscomfortLevel", 0, 100);
    op.title = getText("IGUI_StatsAndBody_DiscomfortLevel");
    op = self:addSliderOption(body,"Wetness", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_Wetness");
    op = self:addSliderOption(body,"Temperature", 20, 40, 0.1);
    op.title = getText("IGUI_StatsAndBody_Temperature");
    op = self:addSliderOption(body,"ColdDamageStage", 0, 1);
    op.title = getText("IGUI_StatsAndBody_ColdDamageStage");
    op = self:addSliderOption(body,"OverallBodyHealth", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_OverallBodyHealth");
    op = self:addSliderOption(body,"ColdStrength", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_ColdStrength");
    op = self:addSliderOption(stats,"Sickness", 0, 1);
    op.title = getText("IGUI_StatsAndBody_Sickness");
    op = self:addSliderOption(body,"InfectionLevel", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_InfectionLevel");
    op = self:addSliderOption(body,"FakeInfectionLevel", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_FakeInfectionLevel");
    op = self:addSliderOption(body,"FoodSicknessLevel", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_FoodSicknessLevel");
	op = self:addSliderOption(nutrition,"Carbohydrates", -500, 1000, 1);
    op.title = getText("Fluid_Prop_Carbohydrates");
	op = self:addSliderOption(nutrition,"Lipids", -500, 1000, 1);
    op.title = getText("Fluid_Prop_Lipids");
	op = self:addSliderOption(nutrition,"Proteins", -500, 1000, 1);
    op.title = getText("Fluid_Prop_Proteins");
    op = self:addSliderOption(nutrition,"Calories", -2200, 3700, 1);
    op.title = getText("IGUI_StatsAndBody_Calories");
    op = self:addSliderOption(nutrition, "Weight", 30, 130, 1);
    op.title = getText("IGUI_StatsAndBody_Weight");
    op = self:addSliderOption(body, "PoisonLevel", 0, 1000, 1);
    op.title = getText("IGUI_StatsAndBody_Poison");
    self:addBoolOption(body,getText("IGUI_StatsAndBody_IsInfected"), "IsInfected", "setInfected");
    self:addBoolOption(body,getText("IGUI_StatsAndBody_IsFakeInfected"), "IsFakeInfected", "setIsFakeInfected");
    self:addBoolOption(body,getText("IGUI_StatsAndBody_IsOnFire"), "IsOnFire", "setIsOnFire");
    self:addBoolOption(player,getText("IGUI_StatsAndBody_Ghost"), "isGhostMode", "setGhostMode");
    self:addBoolOption(player,getText("IGUI_StatsAndBody_GodMod"), "isGodMod", "setGodMod");
    self:addBoolOption(player,getText("IGUI_StatsAndBody_Invisible"), "isInvisible", "setInvisible");
    --self:addBoolOption(body,"HasACold", "isHasACold", "setHasACold");

    local barMod = UI_BORDER_SPACING;
    local y2, label, value, slider;
    for k,v in ipairs(self.sliderOptions) do
        y2,label = ISDebugUtils.addLabel(self,v,x,y,v.title or v.var, UIFont.Small);

        y2,value = ISDebugUtils.addLabel(self,v,x+(w-300)-20,y,"0", UIFont.Small, false);
        y,slider = ISDebugUtils.addSlider(self,v,x+(w-300),y,300, BUTTON_HGT, ISStatsAndBody.onSliderChange);
        slider.valueLabel = value;

        v.label = label;
        v.labelValue = value;
        v.slider = slider;
        --slider:setCurrentValue(v.java[v.get](v.java[v.get]));
        slider:setValues(v.min, v.max, v.step, v.step, true);
        local val = v.java[v.get](v.java) + v.applyMod;
        --print(v.var.." = "..tostring(val))
        slider:setCurrentValue(val);

        y = ISDebugUtils.addHorzBar(self,math.max(y,y2)+barMod)+barMod+1;
    end

    local tickbox;
    for k,v in ipairs(self.boolOptions) do
        y2,label = ISDebugUtils.addLabel(self,v,x,y,v.var, UIFont.Small);

        local tickOptions = {};
        table.insert(tickOptions, { text = getText("IGUI_DebugMenu_Enabled"), ticked = false });
        y,tickbox = ISDebugUtils.addTickBox(self,v,x+(w-300),y,300,BUTTON_HGT,v.var,tickOptions,ISStatsAndBody.onTicked);

        v.label = label;
        v.tickbox = tickbox;

        y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    end

    self:setScrollHeight(y+1);
end

function ISStatsAndBody:addSliderOption(_java, _var, _min, _max, _step, _get, _set)
    local option = {
        java = _java,
        var = _var,
        min = _min,
        max = _max,
        step = _step or 0.01,
        get = _get or "get".._var,
        set = _set or "set".._var,
        applyMod = 0,
    };
    table.insert(self.sliderOptions,option);
    return option;
end

function ISStatsAndBody:addBoolOption(_java, _var, _get, _set)
    local bool = {
        java = _java,
        var = _var,
        get = _get,
        set = _set,
    };
    table.insert(self.boolOptions,bool);
    return bool;
end

function ISStatsAndBody:prerender()
    ISDebugSubPanelBase.prerender(self);

    local val;
    for k,v in ipairs(self.sliderOptions) do
        val = v.java[v.get](v.java);
        v.slider.currentValue = val + v.applyMod;

        if v.slider.pretext then
            v.labelValue:setName(v.slider.pretext..ISDebugUtils.printval(val,3));
        else
            v.labelValue:setName(ISDebugUtils.printval(val,3));
        end
    end

    for k,v in ipairs(self.boolOptions) do
        val = v.java[v.get](v.java);
        v.tickbox.selected[1] = val;
    end
end

function ISStatsAndBody:onSliderChange(_newval, _slider)
    local v = _slider.customData;

    if v.var=="Fitness" then
        local playerXP = getPlayer():getXp();
        local newLevel = (_newval / 2) * 10;
        local currentLevel = getPlayer():getPerkLevel(Perks.Fitness);
        -- stops resetting of the fitness xp to 0 for the current level during panel creation
        if currentLevel ~= newLevel then
            playerXP:setXPToLevel(Perks.Fitness, newLevel);
            getPlayer():setPerkLevelDebug(Perks.Fitness, newLevel);
            return;
        end;
    elseif v.var=="OverallBodyHealth" then
        local b = getPlayer():getBodyDamage();
        if _newval<b:getOverallBodyHealth() then
            b:ReduceGeneralHealth(b:getOverallBodyHealth()-_newval);
        elseif _newval>b:getOverallBodyHealth() then
            b:AddGeneralHealth(_newval-b:getOverallBodyHealth());
        end
        return;
    elseif v.var=="ColdStrength" then
        local b = getPlayer():getBodyDamage();
        if _newval>0 then
            b:setHasACold(true);
        else
            b:setHasACold(false);
        end
    end
    v.java[v.set](v.java,_newval-v.applyMod);
end

function ISStatsAndBody:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
    local v = _tickbox.customData;
    v.java[v.set](v.java, not v.java[v.get](v.java));
end

function ISStatsAndBody:update()
    ISPanel.update(self);
end

function ISStatsAndBody:new(x, y, width, height, doStencil)
    local o = {};
    o = ISDebugSubPanelBase:new(x, y, width, height, doStencil);
    setmetatable(o, self);
    self.__index = self;
    return o;
end

