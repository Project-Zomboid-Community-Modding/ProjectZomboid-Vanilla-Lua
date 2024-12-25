--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase";

local ID_START_CHOPPER = 1;
local ID_END_CHOPPER = 2;
local ID_STOP_WEATHER = 3;

ISGameDebugPanel = ISDebugSubPanelBase:derive("ISGameDebugPanel");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISGameDebugPanel:initialise()
    ISPanel.initialise(self);
    self:addButtonInfo(getText("IGUI_GameDebugPanel_ChoppahAdd"), ID_START_CHOPPER);
    self:addButtonInfo(getText("IGUI_GameDebugPanel_ChoppaRemove"), ID_END_CHOPPER);
    self:addButtonInfo(getText("IGUI_GameDebugPanel_StopWeather"), ID_STOP_WEATHER);
end

function ISGameDebugPanel:addButtonInfo(_title, _command, _marginBot)
    self.buttons = self.buttons or {};

    table.insert(self.buttons, { title = _title, command = _command, marginBot = (_marginBot or 0) });
end

function ISGameDebugPanel:createChildren()
    ISPanel.createChildren(self);

    local v, obj;

    local x,y,w = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1,self.width-UI_BORDER_SPACING*2 - 1;

    self:initHorzBars(x,w);

    self.sliderOptions = {};
    local barMod = UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addLabel(self,"game_title",x+(w/2), y, getText("IGUI_GameDebugPanel_Title"), UIFont.Medium);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    local gt = getGameTime();
    self:addSliderOption(gt,getText("IGUI_GameDebugPanel_GameSpeed"), 0, 1000, 0.1, "getTrueMultiplier", "setMultiplier");

    local y2, label, value, slider;
    for k,v in ipairs(self.sliderOptions) do
        y2,label = ISDebugUtils.addLabel(self,v,x,y,v.title or v.var, UIFont.Small);

        y2,value = ISDebugUtils.addLabel(self,v,x+(w-300)-20,y,"0", UIFont.Small, false);
        y,slider = ISDebugUtils.addSlider(self,v,x+(w-300),y,300, BUTTON_HGT, ISGameDebugPanel.onSliderChange);
        slider.valueLabel = value;

        v.label = label;
        v.labelValue = value;
        v.slider = slider;
        --slider:setCurrentValue(v.java[v.get](v.java[v.get]));
        slider:setValues(v.min, v.max, v.step, v.step*10, true);
        local val = v.java[v.get](v.java) + v.applyMod;
        --print(v.var.." = "..tostring(val))
        slider:setCurrentValue(val);

        y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    end

    --y, obj = ISDebugUtils.addButton(self,"TriggerStorm",x+100,rowY+10,w-200,20,getText("IGUI_climate_TriggerStorm"), ISAdmPanelWeather.onClick);
    if self.buttons then
        for k,v in ipairs(self.buttons)  do
            y, obj = ISDebugUtils.addButton(self,v,x,y,w,BUTTON_HGT,v.title,ISGameDebugPanel.onClick);
            y = y+UI_BORDER_SPACING
        end
    end

    y = ISDebugUtils.addHorzBar(self,y)+barMod+1;

    self.boolOptions = {};

    self:addBoolOption(getText("IGUI_GameDebugPanel_DisableRadioTV"), "disable_broadcasting");
    -- the following disables a media line being registered as having been listened to by player, allowing multiple replays for testing.
    self:addBoolOption(getText("IGUI_GameDebugPanel_DisableMediaLine"), "disable_media_line_registering");

    local tickbox;
    for k,v in ipairs(self.boolOptions) do
        y2,label = ISDebugUtils.addLabel(self,v,x,y,v.title, UIFont.Small);

        local tickOptions = {};
        table.insert(tickOptions, { text = getText("IGUI_DebugMenu_Enabled"), ticked = false });
        y,tickbox = ISDebugUtils.addTickBox(self,v,x+(w-300),y,300,BUTTON_HGT,v.title,tickOptions,ISGameDebugPanel.onTicked);

        v.label = label;
        v.tickbox = tickbox;

        y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    end


    self:setScrollHeight(y+1);
end

function ISGameDebugPanel:onClick(_button)
    if _button.customData and _button.customData.command then
        local c = _button.customData.command
        if c==ID_START_CHOPPER then
            testHelicopter();
        elseif c==ID_END_CHOPPER then
            endHelicopter();
        elseif c==ID_STOP_WEATHER then
            if isClient() then
                getClimateManager():transmitStopWeather();
            else
                getClimateManager():stopWeatherAndThunder()
            end
        end
    end
end

function ISGameDebugPanel:addSliderOption(_java, _var, _min, _max, _step, _get, _set)
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

function ISGameDebugPanel:addBoolOption(_title, _tag)
    local bool = {
        title = _title,
        tag = _tag
    };
    table.insert(self.boolOptions,bool);
    return bool;
end

function ISGameDebugPanel:prerender()
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
        if v.tag=="disable_broadcasting" then
            v.tickbox.selected[1] = getZomboidRadio():getDisableBroadcasting();
        elseif v.tag=="disable_media_line_registering" then
            v.tickbox.selected[1] = getZomboidRadio():getDisableMediaLineLearning();
        end
        --val = v.lua.cheat;
        --v.tickbox.selected[1] = val;
    end
end

function ISGameDebugPanel:onSliderChange(_newval, _slider)
    local v = _slider.customData;

    if v.var=="GameSpeed" then
        if _newval<1 then
            _newval = 1;
        end
    end
    v.java[v.set](v.java,_newval-v.applyMod);
end

function ISGameDebugPanel:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
    local v = _tickbox.customData;
    if v.tag=="disable_broadcasting" then
        getZomboidRadio():setDisableBroadcasting(_tickbox.selected[1]);
    elseif v.tag=="disable_media_line_registering" then
        getZomboidRadio():setDisableMediaLineLearning(_tickbox.selected[1]);
    end
end

function ISGameDebugPanel:onTickedValue(_index, _selected, _arg1, _arg2, _tickbox)
end

function ISGameDebugPanel:update()
    ISPanel.update(self);
end

function ISGameDebugPanel:new(x, y, width, height, doStencil)
    local o = {};
    o = ISDebugSubPanelBase:new(x, y, width, height, doStencil);
    setmetatable(o, self);
    self.__index = self;
    return o;
end


