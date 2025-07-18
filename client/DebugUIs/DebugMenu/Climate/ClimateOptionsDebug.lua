--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase";

ClimateOptionsDebug = ISDebugSubPanelBase:derive("ClimateOptionsDebug");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

function ClimateOptionsDebug:initialise()
    ISPanel.initialise(self);
end

function ClimateOptionsDebug:createChildren()
    ISPanel.createChildren(self);

    local clim = getClimateManager();
    self.clim = clim;
    self.allOptions = {};
    self.floats = {};
    self.colors = {};
    self.bools = {};

    local v, obj;
    local vName;

    local x,y,w = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1,self.width-UI_BORDER_SPACING*2 - SCROLL_BAR_WIDTH - 1;

    self:initHorzBars(x,w);
    local barMod = UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addLabel(self,"float_title",x+(w/2),y,getText("IGUI_ClimateOptions_Floats_Title"), UIFont.Medium);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    --print("w = "..tostring(w))
    for i=0,clim:getFloatMax()-1 do
        v = clim:getClimateFloat(i);
        vName = v:getName()
        y, obj = self:addFloatOption(getText("IGUI_ClimateOptions_"..vName),v,x,y,w)
        --print(v:getName());
        y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    end

    y, obj = ISDebugUtils.addLabel(self,"color_title",x+(w/2),y,getText("IGUI_ClimateOptions_Colors_Title"), UIFont.Medium);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+UI_BORDER_SPACING)+UI_BORDER_SPACING;

    for i=0,clim:getColorMax()-1 do
        v = clim:getClimateColor(i);
        vName = v:getName()
        y, obj = self:addColorOption(getText("IGUI_ClimateOptions_"..vName),v,x,y,w)
        --print(v:getName());
        y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    end

    y, obj = ISDebugUtils.addLabel(self,"bool_title",x+(w/2),y,getText("IGUI_ClimateOptions_Booleans_Title"), UIFont.Medium);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+UI_BORDER_SPACING)+UI_BORDER_SPACING;

    for i=0,clim:getBoolMax()-1 do
        v = clim:getClimateBool(i);
        vName = v:getName()
        y, obj = self:addBoolOption(getText("IGUI_ClimateOptions_"..vName),v,x,y,w)
        --print(v:getName());
        y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    end

    --print("VAL = "..tostring(ClimateManager.FLOAT_PRECIPITATION_INTENSITY));
    --self:addButton("test1",20,20,100,20,"test1");
    --y, obj = self:addButton("test2",20,800,100,20,"test2");

    self:setScrollHeight(y+1);
end

function ClimateOptionsDebug:addBoolOption(_id,_bool,_x,_y,_w)
    local tickOptions = {};
    table.insert(tickOptions, { text = _id, ticked = false });

    local y, obj = ISDebugUtils.addTickBox(self,_id,_x,_y,(_w-300)-30,BUTTON_HGT,_id,tickOptions,ClimateOptionsDebug.onTicked);

    tickOptions = {};
    table.insert(tickOptions, { text = getText("IGUI_DebugMenu_Enabled"), ticked = false });
    local y2,obj2 = ISDebugUtils.addTickBox(self,_id,_x+(_w-300),_y,300,BUTTON_HGT,_id,tickOptions,ClimateOptionsDebug.onTickedValue);

    self.bools[_id] = { option = _bool, tickbox = obj, tickboxValue = obj2 };
    self.allOptions[_id] = self.bools[_id];
    return y;
end

function ClimateOptionsDebug:addFloatOption(_id,_float,_x,_y,_w)
    local tickOptions = {};
    table.insert(tickOptions, { text = _id, ticked = false });

    local y, obj = ISDebugUtils.addTickBox(self,_id,_x,_y,(_w-300)-30,BUTTON_HGT,_id,tickOptions,ClimateOptionsDebug.onTicked);
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.valueLabel = obj2;
    obj3:setValues(_float:getMin(), _float:getMax(), 0.01, 0.01);
    obj3:setCurrentValue(0);

    self.floats[_id] = { option = _float, tickbox = obj, label = obj2, slider = obj3 };
    self.allOptions[_id] = self.floats[_id];

    return y>y3 and y or y3;
end

function ClimateOptionsDebug:addColorOption(_id,_color,_x,_y,_w)
    local tickOptions = {};
    table.insert(tickOptions, { text = _id, ticked = false });

    local t = { option = _color };
    local y, obj = ISDebugUtils.addTickBox(self,_id,_x,_y,(_w/2)-30,BUTTON_HGT,_id,tickOptions,ClimateOptionsDebug.onTicked);
    t.tickbox = obj;

    ------------------------------------------------------------------------------

    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.pretext = getText("IGUI_ClimateOptions_ExR");
    obj3.valueLabel = obj2;
    obj3:setValues(0, 1, 0.01, 0.01);
    obj3:setCurrentValue(0);
    t.labelR = obj2;
    t.sliderR = obj3;

    _y = math.max(y2,y3)+UI_BORDER_SPACING;
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.pretext = getText("IGUI_ClimateOptions_ExG");
    obj3.valueLabel = obj2;
    obj3:setValues(0, 1, 0.01, 0.01);
    obj3:setCurrentValue(0);
    t.labelG = obj2;
    t.sliderG = obj3;

    _y = math.max(y2,y3)+UI_BORDER_SPACING;
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.pretext = getText("IGUI_ClimateOptions_ExB");
    obj3.valueLabel = obj2;
    obj3:setValues(0, 1, 0.01, 0.01);
    obj3:setCurrentValue(0);
    t.labelB = obj2;
    t.sliderB = obj3;

    _y = math.max(y2,y3)+UI_BORDER_SPACING;
    local colorbox = ISPanel:new(_x+(_w-300),_y,300,BUTTON_HGT);
    colorbox:initialise();
    colorbox.backgroundColor = {r=0.0,g=0.0,b=0.0,a=1.0};
    self:addChild(colorbox);

    y3 = colorbox:getY() + colorbox:getHeight();

    t.colorbox = colorbox;

    _y = y3+UI_BORDER_SPACING;
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.pretext = getText("IGUI_ClimateOptions_ExA");
    obj3.valueLabel = obj2;
    obj3:setValues(0, 1, 0.01, 0.01);
    obj3:setCurrentValue(0);
    t.labelA = obj2;
    t.sliderA = obj3;

    _y = math.max(y2,y3)+UI_BORDER_SPACING;
    local colorbox = ISPanel:new(_x+(_w-300),_y,300,BUTTON_HGT);
    colorbox:initialise();
    colorbox.backgroundColor = {r=0.0,g=0.0,b=0.0,a=1.0};
    self:addChild(colorbox);

    y3 = colorbox:getY() + colorbox:getHeight();

    t.colorboxAlpha = colorbox;

    ------------------------------------------------------------------------------

    _y = y3+UI_BORDER_SPACING;
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.pretext = getText("IGUI_ClimateOptions_InR");
    obj3.valueLabel = obj2;
    obj3:setValues(0, 1, 0.01, 0.01);
    obj3:setCurrentValue(0);
    t.labelR_int = obj2;
    t.sliderR_int = obj3;

    _y = math.max(y2,y3)+UI_BORDER_SPACING;
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.pretext = getText("IGUI_ClimateOptions_InG");
    obj3.valueLabel = obj2;
    obj3:setValues(0, 1, 0.01, 0.01);
    obj3:setCurrentValue(0);
    t.labelG_int = obj2;
    t.sliderG_int = obj3;

    _y = math.max(y2,y3)+UI_BORDER_SPACING;
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.pretext = getText("IGUI_ClimateOptions_InB");
    obj3.valueLabel = obj2;
    obj3:setValues(0, 1, 0.01, 0.01);
    obj3:setCurrentValue(0);
    t.labelB_int = obj2;
    t.sliderB_int = obj3;

    _y = math.max(y2,y3)+UI_BORDER_SPACING;
    local colorbox = ISPanel:new(_x+(_w-300),_y,300,BUTTON_HGT);
    colorbox:initialise();
    colorbox.backgroundColor = {r=0.0,g=0.0,b=0.0,a=1.0};
    self:addChild(colorbox);

    y3 = colorbox:getY() + colorbox:getHeight();

    t.colorbox_int = colorbox;

    _y = y3+UI_BORDER_SPACING;
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,ClimateOptionsDebug.onSliderChange);
    obj3.pretext = getText("IGUI_ClimateOptions_InA");
    obj3.valueLabel = obj2;
    obj3:setValues(0, 1, 0.01, 0.01);
    obj3:setCurrentValue(0);
    t.labelA_int = obj2;
    t.sliderA_int = obj3;

    _y = math.max(y2,y3)+UI_BORDER_SPACING;
    local colorbox = ISPanel:new(_x+(_w-300),_y,300,BUTTON_HGT);
    colorbox:initialise();
    colorbox.backgroundColor = {r=0.0,g=0.0,b=0.0,a=1.0};
    self:addChild(colorbox);

    y3 = colorbox:getY() + colorbox:getHeight();

    t.colorboxAlpha_int = colorbox;

    ------------------------------------------------------------------------------

    self.colors[_id] = t;
    self.allOptions[_id] = self.colors[_id];

    return y>y3 and y or y3;
end


function ClimateOptionsDebug:prerender()
    ISDebugSubPanelBase.prerender(self);

    for k,o in pairs(self.floats) do
        o.tickbox.selected[1] = o.option:isEnableAdmin();
        o.slider:setCurrentValue(o.option:getAdminValue());
    end

    for k,o in pairs(self.colors) do
        o.tickbox.selected[1] = o.option:isEnableAdmin();
        if o.tickbox.selected[1] then
            local c = o.option:getAdminValue():getExterior();
            o.sliderR:setCurrentValue(c:getRedFloat());
            o.sliderG:setCurrentValue(c:getGreenFloat());
            o.sliderB:setCurrentValue(c:getBlueFloat());
            o.sliderA:setCurrentValue(c:getAlphaFloat());
            o.colorbox.backgroundColor.r = c:getRedFloat();
            o.colorbox.backgroundColor.g = c:getGreenFloat();
            o.colorbox.backgroundColor.b = c:getBlueFloat();
            o.colorboxAlpha.backgroundColor.r = c:getAlphaFloat();
            o.colorboxAlpha.backgroundColor.g = c:getAlphaFloat();
            o.colorboxAlpha.backgroundColor.b = c:getAlphaFloat();

            c = o.option:getAdminValue():getInterior();
            o.sliderR_int:setCurrentValue(c:getRedFloat());
            o.sliderG_int:setCurrentValue(c:getGreenFloat());
            o.sliderB_int:setCurrentValue(c:getBlueFloat());
            o.sliderA_int:setCurrentValue(c:getAlphaFloat());
            o.colorbox_int.backgroundColor.r = c:getRedFloat();
            o.colorbox_int.backgroundColor.g = c:getGreenFloat();
            o.colorbox_int.backgroundColor.b = c:getBlueFloat();
            o.colorboxAlpha_int.backgroundColor.r = c:getAlphaFloat();
            o.colorboxAlpha_int.backgroundColor.g = c:getAlphaFloat();
            o.colorboxAlpha_int.backgroundColor.b = c:getAlphaFloat();
        else
            local c = o.option:getFinalValue():getExterior();
            o.sliderR:setCurrentValue(c:getRedFloat());
            o.sliderG:setCurrentValue(c:getGreenFloat());
            o.sliderB:setCurrentValue(c:getBlueFloat());
            o.sliderA:setCurrentValue(c:getAlphaFloat());
            o.colorbox.backgroundColor.r = c:getRedFloat();
            o.colorbox.backgroundColor.g = c:getGreenFloat();
            o.colorbox.backgroundColor.b = c:getBlueFloat();
            o.colorboxAlpha.backgroundColor.r = c:getAlphaFloat();
            o.colorboxAlpha.backgroundColor.g = c:getAlphaFloat();
            o.colorboxAlpha.backgroundColor.b = c:getAlphaFloat();

            c = o.option:getFinalValue():getInterior();
            o.sliderR_int:setCurrentValue(c:getRedFloat());
            o.sliderG_int:setCurrentValue(c:getGreenFloat());
            o.sliderB_int:setCurrentValue(c:getBlueFloat());
            o.sliderA_int:setCurrentValue(c:getAlphaFloat());
            o.colorbox_int.backgroundColor.r = c:getRedFloat();
            o.colorbox_int.backgroundColor.g = c:getGreenFloat();
            o.colorbox_int.backgroundColor.b = c:getBlueFloat();
            o.colorboxAlpha_int.backgroundColor.r = c:getAlphaFloat();
            o.colorboxAlpha_int.backgroundColor.g = c:getAlphaFloat();
            o.colorboxAlpha_int.backgroundColor.b = c:getAlphaFloat();
        end
    end

    for k,o in pairs(self.bools) do
        o.tickbox.selected[1] = o.option:isEnableAdmin();
        o.tickboxValue.selected[1] = o.option:getAdminValue();
    end
end

function ClimateOptionsDebug:onSliderChange(_newval, _slider)
    local s = self.floats[_slider.customData];
    if s then
        if s.slider.pretext then
            s.label:setName(s.slider.pretext..ISDebugUtils.printval(_newval,3));
        else
            s.label:setName(ISDebugUtils.printval(_newval,3));
        end
        s.option:setAdminValue(s.slider:getCurrentValue());
    end
    s = self.colors[_slider.customData];
    if s then
        s.option:setAdminValue(s.sliderR:getCurrentValue(),s.sliderG:getCurrentValue(),s.sliderB:getCurrentValue(),s.sliderA:getCurrentValue(),
            s.sliderR_int:getCurrentValue(),s.sliderG_int:getCurrentValue(),s.sliderB_int:getCurrentValue(),s.sliderA_int:getCurrentValue());
        s.labelR:setName(s.sliderR.pretext..ISDebugUtils.printval(s.sliderR:getCurrentValue(),3));
        s.labelG:setName(s.sliderG.pretext..ISDebugUtils.printval(s.sliderG:getCurrentValue(),3));
        s.labelB:setName(s.sliderB.pretext..ISDebugUtils.printval(s.sliderB:getCurrentValue(),3));
        s.labelA:setName(s.sliderA.pretext..ISDebugUtils.printval(s.sliderA:getCurrentValue(),3));

        s.labelR_int:setName(s.sliderR_int.pretext..ISDebugUtils.printval(s.sliderR_int:getCurrentValue(),3));
        s.labelG_int:setName(s.sliderG_int.pretext..ISDebugUtils.printval(s.sliderG_int:getCurrentValue(),3));
        s.labelB_int:setName(s.sliderB_int.pretext..ISDebugUtils.printval(s.sliderB_int:getCurrentValue(),3));
        s.labelA_int:setName(s.sliderA_int.pretext..ISDebugUtils.printval(s.sliderA_int:getCurrentValue(),3));
    end
end

function ClimateOptionsDebug:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
    local s = self.allOptions[_tickbox.customData];

    if s.option:isEnableAdmin() then
        s.option:setEnableAdmin(false);
    else
        s.option:setEnableAdmin(true);
    end
end

function ClimateOptionsDebug:onTickedValue(_index, _selected, _arg1, _arg2, _tickbox)
    local s = self.allOptions[_tickbox.customData];

    s.option:setAdminValue(not s.option:getAdminValue());
end

function ClimateOptionsDebug:update()
    ISPanel.update(self);
end

function ClimateOptionsDebug:new(x, y, width, height, doStencil)
    local o = {};
    o = ISDebugSubPanelBase:new(x, y, width, height, doStencil);
    setmetatable(o, self);
    self.__index = self;
    return o;
end

