--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase";

NewFogDebug = ISDebugSubPanelBase:derive("NewFogDebug");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

function NewFogDebug:initialise()
    ISPanel.initialise(self);
end

function NewFogDebug:createChildren()
    ISPanel.createChildren(self);

    local clim = getClimateManager();
    self.clim = clim;
    self.newFogID = 5;

    self.allOptions = {};
    self.floats = {};
    self.colors = {};
    self.bools = {};
    self.floatOptions = {};

    local v, obj;

    local x,y,w = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1,self.width-UI_BORDER_SPACING*2 - SCROLL_BAR_WIDTH - 1;

    self:initHorzBars(x,w);
    local barMod = UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addLabel(self,"float_title",x+(w/2),y,getText("IGUI_NewFog_Title"), UIFont.Medium);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    --print("w = "..tostring(w))
    v = clim:getClimateFloat(self.newFogID);
    y, obj = self:addFloatOptionAuto(getText("IGUI_ClimateOptions_FOG_INTENSITY"),v,x,y,w)
    --print(v:getName());
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addBoolOption(getText("IGUI_NewFog_RenderOnlyOneRow"),x,y,w);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addBoolOption(getText("IGUI_NewFog_RenderDebugColors"),x,y,w);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addBoolOption(getText("IGUI_NewFog_RenderCurrentLayerOnly"),x,y,w);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_ColorR"),x,y,w, 0,1, 0.05);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    y, obj = self:addFloatOption(getText("IGUI_NewFog_ColorG"),x,y,w, 0,1, 0.05);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    y, obj = self:addFloatOption(getText("IGUI_NewFog_ColorB"),x,y,w, 0,1, 0.05);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addBoolOption(getText("IGUI_NewFog_HighQuality"),x,y,w);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addBoolOption(getText("IGUI_NewFog_EnableLockedEditing"),x,y,w);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = ISDebugUtils.addLabel(self,"float_title2",x+(w/2),y,getText("IGUI_NewFog_LockedParamsTitle"), UIFont.Medium);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_BaseAlpha"),x,y,w, 0,1, 0.01);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_RenderXRow"),x,y,w, 1,10, 1);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_RenderXRowFromCenter"),x,y,w, 0,20, 1);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_SecondLayerAlpha"),x,y,w, 0,1, 0.05);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_TopAlphaHeight"),x,y,w, 0.0,1.0, 0.01);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_BottomAlphaHeight"),x,y,w, 0.0,1.0, 0.01);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    --y, obj = self:addFloatOption("Octaves",x,y,w, 1,6, 1);
    --y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_CircleAlpha"),x,y,w, 0,1, 0.01);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_CircleRadius"),x,y,w, 0,4, 0.01);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = ISDebugUtils.addLabel(self,"float_title3",x+(w/2),y,getText("IGUI_NewFog_OtherTitle"), UIFont.Medium);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    y, obj = self:addFloatOption(getText("IGUI_NewFog_MinX"),x,y,w, -20,20, 1);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    y, obj = self:addFloatOption(getText("IGUI_NewFog_MaxX"),x,y,w, -20,20, 1);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    y, obj = self:addFloatOption(getText("IGUI_NewFog_MaxY"),x,y,w, -20,20, 1);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    y, obj = self:addBoolOption(getText("IGUI_NewFog_RenderEndOnly"),x,y,w);
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    self:setScrollHeight(y+1);
end

function NewFogDebug:addFloatOption(_id,_x,_y,_w,_min,_max,_stepsize)
    local y,obj = ISDebugUtils.addLabel(self,_id,_x,_y,_id, UIFont.Small, true);
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,NewFogDebug.onSliderChange);
    obj3.valueLabel = obj2;
    obj3:setValues(_min or 0, _max or 1, _stepsize or 0.01, _stepsize or 0.01);
    obj3:setCurrentValue(0);

    self.floatOptions[_id] = { title = obj, label = obj2, slider = obj3 };
    self.allOptions[_id] = self.floats[_id];

    return y2>y3 and y2 or y3;
end

function NewFogDebug:addBoolOption(_id,_x,_y,_w)
    local y,obj = ISDebugUtils.addLabel(self,_id,_x,_y,_id, UIFont.Small, true);

    local tickOptions = {};
    table.insert(tickOptions, { text = getText("IGUI_DebugMenu_Enabled"), ticked = false });
    local y2,obj2 = ISDebugUtils.addTickBox(self,_id,_x+(_w-300),_y,BUTTON_HGT,BUTTON_HGT,_id,tickOptions,NewFogDebug.onTickedValue);
    --obj2.changeOptionMethod = ClimateOptionsDebug.onTickedValue;

    self.bools[_id] = { title = obj, tickboxValue = obj2 };
    self.allOptions[_id] = self.bools[_id];
    return y>y2 and y or y2;
end

function NewFogDebug:addFloatOptionAuto(_id,_float,_x,_y,_w)
    local tickOptions = {};
    table.insert(tickOptions, { text = _id, ticked = false });

    local y, obj = ISDebugUtils.addTickBox(self,_id,_x,_y,BUTTON_HGT,BUTTON_HGT,_id,tickOptions,NewFogDebug.onTicked);
    local y2,obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,NewFogDebug.onSliderChange);
    obj3.valueLabel = obj2;
    obj3:setValues(_float:getMin(), _float:getMax(), 0.01, 0.01);
    obj3:setCurrentValue(0);

    self.floats[_id] = { option = _float, tickbox = obj, label = obj2, slider = obj3 };
    self.allOptions[_id] = self.floats[_id];

    return y>y3 and y or y3;
end

function NewFogDebug:prerender()
    ISDebugSubPanelBase.prerender(self);

    for k,o in pairs(self.floats) do
        o.tickbox.selected[1] = o.option:isEnableAdmin();
        o.slider:setCurrentValue(o.option:getAdminValue());
    end
    for k,o in pairs(self.floatOptions) do
        if k==getText("IGUI_NewFog_BaseAlpha") then
            o.slider:setCurrentValue(ImprovedFog.getBaseAlpha());
        elseif k==getText("IGUI_NewFog_RenderXRow") then
            o.slider:setCurrentValue(ImprovedFog.getRenderEveryXRow());
        elseif k==getText("IGUI_NewFog_RenderXRowFromCenter") then
            o.slider:setCurrentValue(ImprovedFog.getRenderXRowsFromCenter());
        elseif k==getText("IGUI_NewFog_SecondLayerAlpha") then
            o.slider:setCurrentValue(ImprovedFog.getSecondLayerAlpha());
        elseif k==getText("IGUI_NewFog_TopAlphaHeight") then
            o.slider:setCurrentValue(ImprovedFog.getTopAlphaHeight());
        elseif k==getText("IGUI_NewFog_BottomAlphaHeight") then
            o.slider:setCurrentValue(ImprovedFog.getBottomAlphaHeight());
        elseif k=="Octaves" then
            o.slider:setCurrentValue(ImprovedFog.getOctaves());
        elseif k==getText("IGUI_NewFog_CircleAlpha") then
            o.slider:setCurrentValue(ImprovedFog.getAlphaCircleAlpha());
        elseif k==getText("IGUI_NewFog_CircleRadius") then
            o.slider:setCurrentValue(ImprovedFog.getAlphaCircleRad());
        elseif k==getText("IGUI_NewFog_ColorR") then
            o.slider:setCurrentValue(ImprovedFog.getColorR());
        elseif k==getText("IGUI_NewFog_ColorG") then
            o.slider:setCurrentValue(ImprovedFog.getColorG());
        elseif k==getText("IGUI_NewFog_ColorB") then
            o.slider:setCurrentValue(ImprovedFog.getColorB());
        elseif k==getText("IGUI_NewFog_MinX") then
            o.slider:setCurrentValue(ImprovedFog.getMinXOffset());
        elseif k==getText("IGUI_NewFog_MaxX") then
            o.slider:setCurrentValue(ImprovedFog.getMaxXOffset());
        elseif k==getText("IGUI_NewFog_MaxY") then
            o.slider:setCurrentValue(ImprovedFog.getMaxYOffset());
        end
    end
    for k,o in pairs(self.bools) do
        if k==getText("IGUI_NewFog_RenderOnlyOneRow") then
            o.tickboxValue.selected[1] = ImprovedFog.isRenderOnlyOneRow();
        elseif k==getText("IGUI_NewFog_RenderDebugColors") then
            o.tickboxValue.selected[1] = ImprovedFog.isDrawDebugColors();
        elseif k==getText("IGUI_NewFog_RenderCurrentLayerOnly") then
            o.tickboxValue.selected[1] = ImprovedFog.isRenderCurrentLayerOnly();
        elseif k==getText("IGUI_NewFog_EnableLockedEditing") then
            o.tickboxValue.selected[1] = ImprovedFog.isEnableEditing();
        elseif k==getText("IGUI_NewFog_HighQuality") then
            o.tickboxValue.selected[1] = ImprovedFog.isHighQuality();
        elseif k==getText("IGUI_NewFog_RenderEndOnly") then
            o.tickboxValue.selected[1] = ImprovedFog.isRenderEndOnly();
        end
    end
end

function NewFogDebug:onSliderChange(_newval, _slider)
    local s = self.floatOptions[_slider.customData];
    if s then
        if s.slider.pretext then
            s.label:setName(s.slider.pretext..ISDebugUtils.printval(_newval,3));
        else
            s.label:setName(ISDebugUtils.printval(_newval,3));
        end
        if _slider.customData==getText("IGUI_NewFog_BaseAlpha") then
            ImprovedFog.setBaseAlpha(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_RenderXRow") then
            ImprovedFog.setRenderEveryXRow(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_RenderXRowFromCenter") then
            ImprovedFog.setRenderXRowsFromCenter(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_SecondLayerAlpha") then
            ImprovedFog.setSecondLayerAlpha(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_TopAlphaHeight") then
            ImprovedFog.setTopAlphaHeight(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_BottomAlphaHeight") then
            ImprovedFog.setBottomAlphaHeight(s.slider:getCurrentValue());
        elseif _slider.customData=="Octaves" then
            ImprovedFog.setOctaves(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_CircleAlpha") then
            ImprovedFog.setAlphaCircleAlpha(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_CircleRadius") then
            ImprovedFog.setAlphaCircleRad(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_ColorR") then
            ImprovedFog.setColorR(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_ColorG") then
            ImprovedFog.setColorG(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_ColorB") then
            ImprovedFog.setColorB(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_MinX") then
            ImprovedFog.setMinXOffset(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_MaxX") then
            ImprovedFog.setMaxXOffset(s.slider:getCurrentValue());
        elseif _slider.customData==getText("IGUI_NewFog_MaxY") then
            ImprovedFog.setMaxYOffset(s.slider:getCurrentValue());
        end
        return;
    end
    local s = self.floats[_slider.customData];
    if s then
        if s.slider.pretext then
            s.label:setName(s.slider.pretext..ISDebugUtils.printval(_newval,3));
        else
            s.label:setName(ISDebugUtils.printval(_newval,3));
        end
        s.option:setAdminValue(s.slider:getCurrentValue());
        return;
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
        return;
    end
end

function NewFogDebug:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
    local s = self.allOptions[_tickbox.customData];

    if s.option:isEnableAdmin() then
        s.option:setEnableAdmin(false);
    else
        s.option:setEnableAdmin(true);
    end
end

function NewFogDebug:onTickedValue(_index, _selected, _arg1, _arg2, _tickbox)
    local s = self.allOptions[_tickbox.customData];

    if s then
        if _tickbox.customData==getText("IGUI_NewFog_RenderOnlyOneRow") then
            ImprovedFog.setRenderOnlyOneRow(not ImprovedFog.isRenderOnlyOneRow());
        elseif _tickbox.customData==getText("IGUI_NewFog_RenderDebugColors") then
            ImprovedFog.setDrawDebugColors(not ImprovedFog.isDrawDebugColors());
        elseif _tickbox.customData==getText("IGUI_NewFog_RenderCurrentLayerOnly") then
            ImprovedFog.setRenderCurrentLayerOnly(not ImprovedFog.isRenderCurrentLayerOnly());
        elseif _tickbox.customData==getText("IGUI_NewFog_EnableLockedEditing") then
            ImprovedFog.setEnableEditing(not ImprovedFog.isEnableEditing());
        elseif _tickbox.customData==getText("IGUI_NewFog_HighQuality") then
            ImprovedFog.setHighQuality(not ImprovedFog.isHighQuality());
        elseif _tickbox.customData==getText("IGUI_NewFog_RenderEndOnly") then
            ImprovedFog.setRenderEndOnly(not ImprovedFog.isRenderEndOnly());
        end
    end
end

function NewFogDebug:update()
    ISPanel.update(self);
end

function NewFogDebug:new(x, y, width, height, doStencil)
    local o = {};
    o = ISDebugSubPanelBase:new(x, y, width, height, doStencil);
    setmetatable(o, self);
    self.__index = self;
    return o;
end
