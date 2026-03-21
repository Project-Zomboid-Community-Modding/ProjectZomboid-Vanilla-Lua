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
    local body = player:getBodyDamage();
    local nutrition = player:getNutrition()
    self.sliderOptions = {};
    self.boolOptions = {};

    local op = self:addSliderOptionEnum(CharacterStat.HUNGER);
    op.title = getText("IGUI_StatsAndBody_Hunger");
    op = self:addSliderOption(body,"HealthFromFoodTimer", 0, 10000);
    op.title = getText("IGUI_StatsAndBody_HealthFromFoodTimer");
    op = self:addSliderOptionEnum(CharacterStat.THIRST);
    op.title = getText("IGUI_StatsAndBody_Thirst");
    op = self:addSliderOptionEnum(CharacterStat.FATIGUE);
    op.title = getText("IGUI_StatsAndBody_Fatigue");
    op = self:addSliderOptionEnum(CharacterStat.ENDURANCE);
    op.title = getText("IGUI_StatsAndBody_Endurance");
    op = self:addSliderOptionEnum(CharacterStat.FITNESS, 0.01);
    op.min = -1
    op.max = 1
    op.title = getText("IGUI_StatsAndBody_Fitness");
    op = self:addSliderOptionEnum(CharacterStat.INTOXICATION, 1);
    op.title = getText("IGUI_StatsAndBody_Intoxication");
    op = self:addSliderOptionEnum(CharacterStat.ANGER);
    op.title = getText("IGUI_StatsAndBody_Anger");
    op = self:addSliderOptionEnum(CharacterStat.PAIN, 1);
    op.title = getText("IGUI_StatsAndBody_Pain");
    op = self:addSliderOptionEnum(CharacterStat.PANIC, 1);
    op.title = getText("IGUI_StatsAndBody_Panic");
    op = self:addSliderOptionEnum(CharacterStat.MORALE);
    op.title = getText("IGUI_StatsAndBody_Morale");
    op = self:addSliderOptionEnum(CharacterStat.STRESS);
    op.title = getText("IGUI_StatsAndBody_Stress");
    op = self:addSliderOptionEnum(CharacterStat.NICOTINE_WITHDRAWAL);
    op.title = getText("IGUI_StatsAndBody_NicotineWithdrawal");
    op = self:addSliderOption(player,"TimeSinceLastSmoke", 0, 10);
    op.title = getText("IGUI_StatsAndBody_TimeSinceLastSmoke");
    op = self:addSliderOptionEnum(CharacterStat.BOREDOM, 1);
    op.title = getText("IGUI_StatsAndBody_Boredom");
    op = self:addSliderOptionEnum(CharacterStat.IDLENESS, 0.001);
    op.title = getText("IGUI_StatsAndBody_Idleness");
    op = self:addSliderOptionEnum(CharacterStat.UNHAPPINESS, 1);
    op.title = getText("IGUI_StatsAndBody_Unhappiness");
    op = self:addSliderOptionEnum(CharacterStat.SANITY);
    op.title = getText("IGUI_StatsAndBody_Sanity");
    op = self:addSliderOptionEnum(CharacterStat.DISCOMFORT, 1);
    op.title = getText("IGUI_StatsAndBody_Discomfort");
    op = self:addSliderOptionEnum(CharacterStat.WETNESS, 1);
    op.title = getText("IGUI_StatsAndBody_Wetness");
    op = self:addSliderOptionEnum(CharacterStat.TEMPERATURE, 0.1);
    op.title = getText("IGUI_StatsAndBody_Temperature");
    op = self:addSliderOption(body,"ColdDamageStage", 0, 1);
    op.title = getText("IGUI_StatsAndBody_ColdDamageStage");
    op = self:addSliderOption(body,"OverallBodyHealth", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_OverallBodyHealth");
    op = self:addSliderOption(body,"ColdStrength", 0, 100, 1);
    op.title = getText("IGUI_StatsAndBody_ColdStrength");
    op = self:addSliderOptionEnum(CharacterStat.SICKNESS);
    op.title = getText("IGUI_StatsAndBody_Sickness");
    op = self:addSliderOptionEnum(CharacterStat.ZOMBIE_INFECTION, 1);
    op.title = getText("IGUI_StatsAndBody_ZombieInfection");
    op = self:addSliderOptionEnum(CharacterStat.ZOMBIE_FEVER, 1);
    op.title = getText("IGUI_StatsAndBody_ZombieFever");
    op = self:addSliderOptionEnum(CharacterStat.FOOD_SICKNESS, 1);
    op.title = getText("IGUI_StatsAndBody_FoodSickness");
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
    op = self:addSliderOptionEnum(CharacterStat.POISON, 1);
    op.title = getText("IGUI_StatsAndBody_Poison");
    self:addBoolOption(body,getText("IGUI_StatsAndBody_IsInfected"), "IsInfected", "setInfected");
    self:addBoolOption(body,getText("IGUI_StatsAndBody_IsFakeInfected"), "IsFakeInfected", "setIsFakeInfected");
    self:addBoolOption(body,getText("IGUI_StatsAndBody_IsOnFire"), "IsOnFire", "setIsOnFire");
    self:addBoolOption(player,getText("IGUI_StatsAndBody_Ghost"), "isGhostMode", "setGhostMode");
    self:addBoolOption(player,getText("IGUI_StatsAndBody_GodMod"), "isGodMod", "setGodMod");
    self:addBoolOption(player,getText("IGUI_StatsAndBody_Invisible"), "isInvisible", "setInvisible");

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
        slider:setValues(v.min, v.max, v.step, v.step, true);
        local val;
        if v.enum then
            val = getPlayer():getStats():get(v.enum)
        else
            val = v.java[v.get](v.java) + v.applyMod;
        end
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

function ISStatsAndBody:addSliderOptionEnum(_enum, _step)
    local option = {
        enum = _enum,
        var = _enum:getId(),
        min = _enum:getMinimumValue(),
        max = _enum:getMaximumValue(),
        step = _step or 0.01,
        applyMod = 0,
    };
    table.insert(self.sliderOptions,option);
    return option;
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
        if v.enum then
            val = getPlayer():getStats():get(v.enum);
        else
            val = v.java[v.get](v.java);
        end
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

function ISStatsAndBody:onSliderChange(_newVal, _slider)
    local v = _slider.customData;

    if v.var=="Fitness" then
        local player = getPlayer()
        local newFitness = math.max(-1, math.min(1, _newVal))
        player:getStats():set(CharacterStat.FITNESS, newFitness)
        local newLevel = math.floor((newFitness + 1) * 5 + 0.5)
        if player:getPerkLevel(Perks.Fitness) ~= newLevel then
            local currentXP = player:getXp():getXP(Perks.Fitness)
            local newLevelXP = round(Perks.Fitness:getXpForLevel(newLevel), 2)
            local amount = 0
            player:setPerkLevelDebug(Perks.Fitness, newLevel)
            player:getXp():setXPToLevel(Perks.Fitness, newLevel)
            if (currentXP < newLevelXP) then
                amount = player:getXp():getXP(Perks.Fitness)
            else
                amount = player:getXp():getXP(Perks.Fitness) - currentXP + 1
            end
            SendCommandToServer("/addxp \""..player:getUsername().."\" "..v.var.."="..tostring(amount).." -false")
        end
        return;
    elseif v.var=="OverallBodyHealth" then
        local b = getPlayer():getBodyDamage();
        if _newVal <b:getOverallBodyHealth() then
            b:ReduceGeneralHealth(b:getOverallBodyHealth()- _newVal);
        elseif _newVal >b:getOverallBodyHealth() then
            b:AddGeneralHealth(_newVal -b:getOverallBodyHealth());
        end
        return;
    elseif v.var=="ColdStrength" then
        local b = getPlayer():getBodyDamage();
        if _newVal >0 then
            b:setHasACold(true);
        else
            b:setHasACold(false);
        end
    end
    if v.enum then
        getPlayer():getStats():set(v.enum, _newVal -v.applyMod)
        if isClient() then
            sendPlayerStat(getPlayer(), v.enum)
        end
    else
        v.java[v.set](v.java,_newVal-v.applyMod);
        if v.java == getPlayer():getNutrition() then
            if isClient() then
                sendPlayerNutrition(getPlayer())
            end
        end
    end
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
