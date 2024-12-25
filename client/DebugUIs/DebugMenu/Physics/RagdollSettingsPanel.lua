require "DebugUIs/DebugMenu/Base/ISDebugSubPanelBase";

RagdollSettingsPanel = ISDebugSubPanelBase:derive("RagdollSettingsPanel");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local SCROLL_BAR_WIDTH = 13

function RagdollSettingsPanel:initialise()
    ISPanel.initialise(self);
end

function RagdollSettingsPanel:createChildren()
    ISPanel.createChildren(self);

    local ragdollSettingsManager = getRagdollSettingsManager();
    self.allOptions = {};
    self.floats = {};
    self.bools = {};

    local obj;
    local x,y,w = UI_BORDER_SPACING+1,UI_BORDER_SPACING+1,self.width-UI_BORDER_SPACING*2 - SCROLL_BAR_WIDTH - 1;

    self:initHorzBars(x,w);
    local barMod = UI_BORDER_SPACING;

    local btnWidth = UI_BORDER_SPACING*2+ getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_BulletTracerEffect_Reset"))
    y, obj = ISDebugUtils.addButton(self,"float_title",x+w-btnWidth,y,btnWidth,BUTTON_HGT,getText("IGUI_BulletTracerEffect_Reset"), RagdollSettingsPanel.onClick);
    obj.center = true;

    y, obj = ISDebugUtils.addLabel(self,"float_title",x+(w/2),y,getText("IGUI_RagdollDebug_RagdollFriction"), UIFont.Medium);
    obj.center = true;
    y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;

    local nameID;
    local ragdollSetting;

    local count = 0;
    for i=0,ragdollSettingsManager:getSettingsCount()-1 do
        ragdollSetting = ragdollSettingsManager:getSetting(count);
        count = count + 1;

        print(ragdollSetting:getName());

        y, obj = self:addFloatOption(ragdollSetting:getName(),ragdollSetting,x,y,w)

        y = ISDebugUtils.addHorzBar(self,y+barMod)+barMod+1;
    end

    self:setScrollHeight(y+1);
end

function RagdollSettingsPanel:onClick(_button)
    local ragdollSettingsManager = getRagdollSettingsManager();
    ragdollSettingsManager:resetToDefaults();
end

function RagdollSettingsPanel:addBoolOption(_id,_bool,_x,_y,_w)
    local tickOptions = {};
    table.insert(tickOptions, { text = _id, ticked = false });

    local y, obj = ISDebugUtils.addTickBox(self,_id,_x,_y,(_w-300)-30,BUTTON_HGT,_id,tickOptions,RagdollSettingsPanel.onTicked);

    tickOptions = {};
    table.insert(tickOptions, { text = getText("IGUI_DebugMenu_Enabled"), ticked = false });
    local y2,obj2 = ISDebugUtils.addTickBox(self,_id,_x+(_w-300),_y,300,BUTTON_HGT,_id,tickOptions,RagdollSettingsPanel.onTickedValue);

    self.bools[_id] = { option = _bool, tickbox = obj, tickboxValue = obj2 };
    self.allOptions[_id] = self.bools[_id];
    return y;
end

function RagdollSettingsPanel:addFloatOption(_id,_float,_x,_y,_w)
    local tickOptions = {};
    table.insert(tickOptions, { text = _id, ticked = false });

    local y, obj = ISDebugUtils.addTickBox(self,_id,_x,_y,(_w-300)-30,BUTTON_HGT,_id,tickOptions,RagdollSettingsPanel.onTicked);
    local y2, obj2 = ISDebugUtils.addLabel(self,_id,_x+(_w-300)-20,_y,"0", UIFont.Small, false);
    local y3, obj3 = ISDebugUtils.addSlider(self,_id,_x+(_w-300),_y,300, BUTTON_HGT,RagdollSettingsPanel.onSliderChange);
    obj3.valueLabel = obj2;
    obj3:setValues(_float:getMin(), _float:getMax(), 0.1, 0.1);
    obj3:setCurrentValue(0);

    self.floats[_id] = { option = _float, tickbox = obj, label = obj2, slider = obj3 };
    self.allOptions[_id] = self.floats[_id];

    return y>y3 and y or y3;
end

function RagdollSettingsPanel:prerender()
    ISDebugSubPanelBase.prerender(self);

    for k,o in pairs(self.floats) do
        o.tickbox.selected[1] = o.option:isEnableAdmin();
        o.slider:setCurrentValue(o.option:getAdminValue());
    end

    for k,o in pairs(self.bools) do
        o.tickbox.selected[1] = o.option:isEnableAdmin();
        o.tickboxValue.selected[1] = o.option:getAdminValue();
    end
end

function RagdollSettingsPanel:onSliderChange(_newval, _slider)
    local s = self.floats[_slider.customData];
    if s then
        if s.slider.pretext then
            s.label:setName(s.slider.pretext..ISDebugUtils.printval(_newval,3));
        else
            s.label:setName(ISDebugUtils.printval(_newval,3));
        end
        s.option:setAdminValue(s.slider:getCurrentValue());
    end
end

function RagdollSettingsPanel:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
    local s = self.allOptions[_tickbox.customData];
    if s.option:isEnableAdmin() then
        s.option:setEnableAdmin(false);
    else
        s.option:setEnableAdmin(true);
    end
end

function RagdollSettingsPanel:onTickedValue(_index, _selected, _arg1, _arg2, _tickbox)
    local s = self.allOptions[_tickbox.customData];
    s.option:setAdminValue(not s.option:getAdminValue());
end

function RagdollSettingsPanel:update()
    ISPanel.update(self);
end

function RagdollSettingsPanel:new(x, y, width, height, doStencil)
    local o = {};
    o = ISDebugSubPanelBase:new(x, y, width, height, doStencil);
    setmetatable(o, self);
    self.__index = self;
    return o;
end

