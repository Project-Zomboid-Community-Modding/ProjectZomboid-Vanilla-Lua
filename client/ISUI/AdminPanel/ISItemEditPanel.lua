--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    This panel now handles the item Stats & Attributes.
    Non-Attribute stats can be added to:
    - ISItemEditPanel:initElements
    Simply registering the value type there is enough for most stats.
    Some may need some additional care such a 'onSave' override method or such, see Weight for example.
    Once registered the panel should automate the rest.

    Attributes require no registering, are handled automatically on:
    - ISItemEditPanel:initAttributes
--]]

require "ISUI/ISPanel"

ISItemEditPanel = ISPanel:derive("ISItemEditPanel");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local TYPE_NUMBER = 1;
local TYPE_STRING = 2;
local TYPE_COLOR = 3;
local TYPE_BOOLEAN = 4;

function ISItemEditPanel:initElements()
    local elem = self:registerString("IGUI_ItemEditor_ItemType","getFullType", false, false)
    elem = self:registerString("IGUI_ItemEditor_FileName","getFileName", false, false)
--     elem = self:registerString("IGUI_ItemEditor_FilePath","getFileAbsPath", "", true, false)
    elem = self:registerString("IGUI_Name","getName", "setName", true)
    elem = self:registerNumber("Tooltip_item_Weight", "getActualWeight", "setActualWeight", 0, false, 3)
    elem.funcOnSave = ISItemEditPanel.onSaveWeight;
    elem = self:registerNumber("IGUI_invpanel_Condition", "getCondition", "setCondition", 0)
    elem.funcMax = "getConditionMax"
    elem.funcOnSave = ISItemEditPanel.onSaveCondition;
    elem = self:registerColor("IGUI_Color", "getColor", "setColor")
    elem.funcValidate = ISItemEditPanel.validateColor;
    elem.funcOnSave = ISItemEditPanel.onSaveColor;
    --isWeapon
    elem = self:registerNumber("IGUI_ItemEditor_MinDmg", "getMinDamage", "setMinDamage", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateWeapon;
    elem = self:registerNumber("IGUI_ItemEditor_MaxDmg", "getMaxDamage", "setMaxDamage", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateWeapon;
    elem = self:registerNumber("IGUI_ItemEditor_MinAngle", "getMinAngle", "setMinAngle", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateWeapon;
    elem = self:registerNumber("IGUI_ItemEditor_MinRange", "getMinRange", "setMinRange", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateMinRange;
    elem = self:registerNumber("IGUI_ItemEditor_MinRange", "getMinRangeRanged", "setMinRangeRanged", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateMinRangeRanged;
    elem = self:registerNumber("IGUI_ItemEditor_MaxRange", "getMaxRange", "setMaxRange", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateWeapon;
    elem = self:registerNumber("IGUI_ItemEditor_AimingTime", "getAimingTime", "setAimingTime", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateWeapon;
    elem.funcEditable = "isRanged";
    elem = self:registerNumber("IGUI_ItemEditor_RecoilDelay", "getRecoilDelay", "setRecoilDelay", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateWeapon;
    elem.funcEditable = "isRanged";
    elem = self:registerNumber("IGUI_ItemEditor_ReloadTime", "getReloadTime", "setReloadTime", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateWeapon;
    elem.funcEditable = "isRanged";
    elem = self:registerNumber("IGUI_ItemEditor_ClipSize", "getClipSize", "setClipSize", 1)
    elem.funcValidate = ISItemEditPanel.validateWeapon;
    elem.funcEditable = "isRanged";
    --isFood
    elem = self:registerNumber("IGUI_ItemEditor_Age", "getAge", "setAge", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("Tooltip_food_Hunger", "getBaseHunger", "setBaseHunger", 0, false, 3)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem.funcOnSave = ISItemEditPanel.onSaveHunger;
    elem = self:registerNumber("Tooltip_food_Unhappiness", "getUnhappyChange", "setUnhappyChange", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("Tooltip_food_Boredom", "getBoredomChange", "setBoredomChange", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("IGUI_ItemEditor_PoisonPower", "getPoisonPower", "setPoisonPower", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("IGUI_ItemEditor_OffAge", "getOffAge", "setOffAge", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("IGUI_ItemEditor_OffAgeMax", "getOffAgeMax", "setOffAgeMax", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("Tooltip_food_Calories", "getCalories", "setCalories", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("Tooltip_food_Prots", "getProteins", "setProteins", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("Tooltip_food_Fat", "getLipids", "setLipids", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    elem = self:registerNumber("Tooltip_food_Carbs", "getCarbohydrates", "setCarbohydrates", 0)
    elem.funcValidate = ISItemEditPanel.validateFood;
    --drainable
    elem = self:registerNumber("IGUI_ItemEditor_UsedDelta", "getCurrentUsesFloat", "setUsedDelta", 0, 1, 3)
    elem.funcValidate = ISItemEditPanel.validateDrainable;
    --elem = self:registerNumber()
end

function ISItemEditPanel:initAttributes()
    if self.item:getAttributes() then
        local cont = self.item:getAttributes();
        for i=0,cont:size()-1 do
            local key = cont:getKey(i);
            local attribute = cont:getAttribute(i);
            if AttributeValueType.IsNumeric(key:getValueType()) then
                --print("number")
                self:registerAttributeNumber(key, attribute);
            elseif key:getValueType()==AttributeValueType.String then
                --print("string")
                self:registerAttributeString(key, attribute);
            elseif key:getValueType()==AttributeValueType.Boolean then
                --print("bool")
                self:registerAttributeBool(key, attribute);
            end
        end
    end
end

function ISItemEditPanel:registerAttributeBool(_attributeType, _attribute)
    --print("attributebool")
    local elem = self:registerBoolean(_attributeType:getTranslateKey(), false, false, false);
    elem.editable = true;
--     elem.editable = not _attribute:getIsReadOnly();
    elem.isAttribute = true;
    elem.attributeType = _attributeType;
    elem.attribute = _attribute;
    return elem;
end

function ISItemEditPanel:registerBoolean(_text, _funcGet, _funcSet, _canEdit)
    local elem = {
        type = TYPE_BOOLEAN,
        text = _text,
        funcGet = _funcGet,
        funcSet = _funcSet,
        funcOnSave = false,
        funcValidate = false,
        editable = _canEdit,
    };
    table.insert(self.elems, elem);
    return elem;
end

function ISItemEditPanel:registerAttributeNumber(_attributeType, _attribute)
    --print("attributenumber")
    local elem = self:registerNumber(_attributeType:getTranslateKey(), false, false, false, false)
    elem.editable = not _attribute:getIsReadOnly();
    if _attribute:hasBounds() then
        elem.min = _attribute:getMin();
        elem.max = _attribute:getMax();
    end
    elem.isAttribute = true;
    elem.attributeType = _attributeType;
    elem.attribute = _attribute;
end

function ISItemEditPanel:registerNumber(_text, _funcGet, _funcSet, _min, _max, _round)
    local elem = {
        type = TYPE_NUMBER,
        text = _text,               -- translation tag
        funcGet = _funcGet,         -- <string>  item function get
        funcSet = _funcSet,         -- <string>  item function set
        funcOnSave = false,         -- <func> function on save
        funcValidate = false,       -- <func> validate (check if isWeapon etc)
        funcEditable = false,       -- <string>  item function test editable
        funcMin = false,            -- <string>  item function min
        funcMax = false,            -- <string>  item function max
        editable = true,            -- can edit this box (gets overridden by funcValidate)
        min = _min,                 -- min (gets overridden by funcMin)
        max = _max,                 -- max (gets overridden by funcMax)
        round = _round,             -- round decimals to
        boxWidth = 50,              -- entry box width
    };
    table.insert(self.elems, elem);
    return elem;
end

function ISItemEditPanel:registerAttributeString(_attributeType, _attribute)
    --print("attributestring")
    local elem = self:registerString(_attributeType:getTranslateKey(), false, false, not _attribute:getIsReadOnly())
    elem.isAttribute = true;
    elem.attributeType = _attributeType;
    elem.attribute = _attribute;
end

function ISItemEditPanel:registerString(_text, _funcGet, _funcSet, _canEdit)
    local elem = {
        type = TYPE_STRING,
        text = _text,
        funcGet = _funcGet,
        funcSet = _funcSet,
        funcOnSave = false,
        funcValidate = false,
        editable = _canEdit,
        boxWidth = 150,
    };
    table.insert(self.elems, elem);
    return elem;
end

function ISItemEditPanel:registerColor(_text, _funcGet, _funcSet)
    local elem = {
        type = TYPE_COLOR,
        text = _text,
        funcGet = _funcGet,
        funcSet = _funcSet,
        funcOnSave = false,
        funcValidate = false,
        editable = true,
    };
    table.insert(self.elems, elem);
    return elem;
end

-- FUNCTIONS -

function ISItemEditPanel:onSaveHunger()
    self.item:setHungChange(self.item:getBaseHunger());
end

function ISItemEditPanel:onSaveWeight()
    self.item:setCustomWeight(true);
end

function ISItemEditPanel:onSaveCondition()
    if instanceof(self.item, "Clothing") then
        if (self.item:getCondition() == self.item:getConditionMax() and getPlayer():getRole():hasCapability(Capability.EditItem)) then
            self.item:fullyRestore();
        end
    end
    self.item:syncItemFields();
end

function ISItemEditPanel:onSaveColor()
    self.item:getVisual():setTint(ImmutableColor.new(self.item:getColor()));
    if self.admin:isEquipped(self.item) then
        self.admin:resetModelNextFrame();
    end
    self.item:setCustomColor(true);
end

function ISItemEditPanel:validateColor()
    return self.item:allowRandomTint();
end

function ISItemEditPanel:validateMinRangeRanged()
    return self.isWeapon and self.item:isRanged();
end

function ISItemEditPanel:validateMinRange()
    return self.isWeapon and (not self.item:isRanged());
end

function ISItemEditPanel:validateWeapon()
    return self.isWeapon;
end

function ISItemEditPanel:validateFood()
    return self.isFood;
end

function ISItemEditPanel:validateDrainable()
    return self.isDrainable;
end

-- INIT --
function ISItemEditPanel:initialise()
    ISPanel.initialise(self);
end

function ISItemEditPanel:getTextWidth(_s, _f)
    return getTextManager():MeasureStringX(_f or UIFont.Small, _s)
end

function ISItemEditPanel:getTextHeight(_s, _f)
    return getTextManager():MeasureStringY(_f or UIFont.Small, _s)
end

function ISItemEditPanel:createChildren()
    ISPanel.createChildren(self);

    local y = UI_BORDER_SPACING+1;

    self:initElements();

    -- TODO: doesn't work in that it currently blows up when trying to edit items with item components
    -- so it has been commented out until it that can be fixed
--     self:initAttributes();

    self.usedElems = {};

    local maxTextWidth = 0;
    local maxControlWidth = 0;
    for k,elem in ipairs(self.elems) do
        local valid = true
        if elem.funcValidate then
            valid = elem.funcValidate(self);
        end

        if valid then
            table.insert(self.usedElems, elem);
            if elem.isAttribute then
                elem.text = elem.attributeType:getTooltipName();
            else
                elem.text = getText(elem.text) .. ":";
            end
            elem.textWidth = self:getTextWidth(elem.text);
            maxTextWidth = math.max(maxTextWidth, elem.textWidth);
            if elem.isAttribute then
                elem.label = ISLabel:new (0, y, BUTTON_HGT, elem.text, 0.8, 0.8, 0.5, 1.0, UIFont.Small, true);
            else
                elem.label = ISLabel:new (0, y, BUTTON_HGT, elem.text, 0.8, 0.8, 0.8, 1.0, UIFont.Small, true);
            end
            --elem.label = ISLabel:new (0, y, BUTTON_HGT, elem.text, 0.8, 0.8, 0.8, 1.0, UIFont.Small, true);
            elem.label:initialise();
            elem.label:instantiate();
            self:addChild(elem.label);

            if elem.type==TYPE_STRING then
                if elem.isAttribute then
                    elem.originalValue = tostring(elem.attribute:getValueString());
                else
                    elem.originalValue = self.item[elem.funcGet](self.item);
                end
                if elem.editable then
                    elem.control = ISTextEntryBox:new(elem.originalValue, UI_BORDER_SPACING+1, y, elem.boxWidth, BUTTON_HGT);
                    elem.control:initialise();
                    elem.control:instantiate();
                    elem.control:setEditable(elem.editable);
                    maxControlWidth = math.max(maxControlWidth, elem.boxWidth);
                else
                    elem.control = ISLabel:new (0, y, BUTTON_HGT, elem.originalValue, 0.8, 0.8, 0.8, 1.0, UIFont.Small, true);
                    elem.control:initialise();
                    elem.control:instantiate();
                    maxControlWidth = math.max(maxControlWidth, math.min(250, self:getTextWidth(elem.originalValue)));
                end
                self:addChild(elem.control);
            elseif elem.type==TYPE_NUMBER then
                if elem.isAttribute then
                    elem.originalValue = elem.attribute:getValueFloat();
                else
                    elem.originalValue = self.item[elem.funcGet](self.item);
                end
                local val = elem.originalValue;
                if elem.round then
                    val = luautils.round(val,elem.round);
                end
                elem.control = ISTextEntryBox:new(tostring(val), UI_BORDER_SPACING+1, y, elem.boxWidth, BUTTON_HGT);
                elem.control:initialise();
                elem.control:instantiate();
                elem.control.min = elem.min or 0;
                if elem.funcMin then
                    elem.control.min = self.item[elem.funcMin](self.item);
                end
                if elem.funcMax then
                    elem.control.max = self.item[elem.funcMax](self.item);
                elseif elem.max then
                    elem.control.max = elem.max;
                end
                elem.control:setOnlyNumbers(true);
                if elem.funcEditable then
                    elem.editable = self.item[elem.funcEditable](self.item);
                    elem.control:setEditable(elem.editable);
                else
                    elem.control:setEditable(elem.editable);
                end
                maxControlWidth = math.max(maxControlWidth, elem.boxWidth);
                self:addChild(elem.control);
            elseif elem.type==TYPE_COLOR then
                local c = self.item[elem.funcGet](self.item);
                elem.control = ISButton:new(UI_BORDER_SPACING+1, y, 18, BUTTON_HGT, "", self, ISItemEditPanel.onColor);
                elem.control.elem = elem;
                elem.originalValue = {
                    r = c:getRedFloat(),
                    b = c:getBlueFloat(),
                    g = c:getGreenFloat(),
                    a = c:getAlphaFloat(),
                }
                elem.control:initialise();
                elem.control.backgroundColor = {r = elem.originalValue.r, g = elem.originalValue.g, b = elem.originalValue.b, a = 1};

                local colInfo = ColorInfo.new();
                colInfo:set(elem.originalValue.r, elem.originalValue.g, elem.originalValue.b, 1.0);
                elem.origColInfo = colInfo;
                elem.colorPicker = ISColorPickerHSB:new(0, 0, elem.origColInfo)
                elem.colorPicker:initialise()
				elem.colorPicker.keepOnScreen = true
                elem.colorPicker.pickedTarget = self;
                elem.colorPicker.resetFocusTo = self;
				
                maxControlWidth = math.max(maxControlWidth, 30);
                self:addChild(elem.control);
            elseif elem.type==TYPE_BOOLEAN then
                if elem.isAttribute then
                    elem.originalValue = elem.attribute:getValue();
                else
                    elem.originalValue = self.item[elem.funcGet](self.item);
                end
                local tickOptions = {};
                table.insert(tickOptions, { text = "", ticked = elem.originalValue });
                local yy,obj = ISDebugUtils.addTickBox(self, {}, UI_BORDER_SPACING+1, y, 30, ISDebugUtils.FONT_HGT_SMALL, "", tickOptions, nil);
                elem.control = obj;
                elem.control.enable = elem.editable;
            end
        end
    end

    local maxW = maxControlWidth + maxTextWidth + (UI_BORDER_SPACING*3) + UI_BORDER_SPACING; -- +10 for scroll
    local controlX = maxTextWidth + (UI_BORDER_SPACING*2);
    self:setWidth(maxW);
    for k,elem in ipairs(self.usedElems) do
        elem.label:setX(UI_BORDER_SPACING);
        elem.label:setY(y);
        elem.control:setX(controlX);
        elem.control:setY(y);
        y = y+BUTTON_HGT+UI_BORDER_SPACING;
    end

    self:setScrollHeight(y+1);
end

function ISItemEditPanel:render()
    ISPanel.render(self);
    if self.doStencilRender then
        self:clearStencilRect();
    end
    self:drawRectBorderStatic( 0, 0,math.floor(self:getWidth()),math.floor(self:getHeight()), 1.0, 0.5, 0.5, 0.5);
end

function ISItemEditPanel:prerender()
    if self.doStencilRender then
        self:setStencilRect(1,1,self:getWidth()-2,self:getHeight()-2);
    end
    ISPanel.prerender(self);
end

function ISItemEditPanel:create()
end

function ISItemEditPanel:saveAll()
    for k,elem in ipairs(self.usedElems) do
        if elem.editable then
            if elem.isAttribute or (elem.funcSet and self.item[elem.funcSet]) then
                if elem.type==TYPE_STRING then
                    local val = string.trim(elem.control:getInternalText());
                    if val~=elem.originalValue then
                        if elem.isAttribute then
                            elem.attribute:setValue(val);
                        else
                            self.item[elem.funcSet](self.item, val);
                        end
                    end
                elseif elem.type==TYPE_NUMBER then
                    local val = tonumber(string.trim(elem.control:getInternalText()));
                    if val~=elem.originalValue then
                        if elem.isAttribute then
                            elem.attribute:setValueFloat(val);
                        else
                            self.item[elem.funcSet](self.item, val);
                        end
                    end
                elseif elem.type==TYPE_COLOR then
                    if elem.originalValue.r ~= elem.control.backgroundColor.r or elem.originalValue.g ~= elem.control.backgroundColor.g or elem.originalValue.b ~= elem.control.backgroundColor.b then
                        local color = Color.new(elem.control.backgroundColor.r, elem.control.backgroundColor.g, elem.control.backgroundColor.b,1);
                        self.item[elem.funcSet](self.item, color);
                    end
                elseif elem.type==TYPE_BOOLEAN then
                    local val = elem.control.selected[1];
                    if val~=elem.originalValue then
                        if elem.isAttribute then
                            elem.attribute:setValue(val);
                        else
                            self.item[elem.funcSet](self.item, val);
                        end
                    end
                end

                if elem.funcOnSave then
                    elem.funcOnSave(self)
                end
            else
                print("ISItemEditPanel -> editable value has no valid set function [value: "..tostring(elem.text).."]")
                print("Function = "..tostring(elem.funcSet));
            end
        end
    end
end

function ISItemEditPanel:onColor(button)
    button.elem.colorPicker:setX(button:getAbsoluteX());
    button.elem.colorPicker:setY(button:getAbsoluteY() + button:getHeight());
    button.elem.colorPicker.pickedFunc = function(_self, color, mouseUp)
        button.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
    end;
    button.elem.colorPicker:setInitialColor(button.elem.origColInfo);
    button.elem.colorPicker:addToUIManager()
end

function ISItemEditPanel:new(x, y, width, height, admin, item)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.x = x;
    o.y = y;
    o.width = width;
    o.height = height;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.moveWithMouse = true;
    o.admin = admin;
    o.item = item;
    o.isWeapon = instanceof(item, "HandWeapon");
    o.isFood = instanceof(item, "Food");
    o.isDrainable = instanceof(item, "DrainableComboItem");

    o.elems = {};

    return o;
end