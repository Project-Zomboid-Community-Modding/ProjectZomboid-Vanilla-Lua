--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
local WARNED_STYLES = {};

local _print = print;
local function print(_s)
    --_print("ISXuiSkin -> "..tostring(_s));
    if getDebug() then
        _print("ISXuiSkin -> "..tostring(_s));
    end
end

ISXuiSkinFunctions = {};

-- triggers a recalculate layout event down the hierarchy.
-- this function gets added to all ui elements build with XuiSkin, except if the element already implements the function (they 'override' this default implementation).
-- some element in the hierarchy (usually root window/panel) must implement an 'override' that handles the recalculate
-- _preferredWidth, _preferredHeight etc are optional
function ISXuiSkinFunctions.xuiRecalculateLayout(_self, _preferredWidth, _preferredHeight, _force, _anchorRight)
    if _self:getParent() then
        if _self:getParent().xuiRecalculateLayout then
            --_print("ISXuiSkinFunctions.xuiRecalculateLayout -> Calling parent: "..tostring(_self:getParent().Type))
            _self:getParent():xuiRecalculateLayout(_preferredWidth, _preferredHeight, _force, _anchorRight);
        else
            _print("XuiSkin -> couldnt trigger xuiRecalculateLayout for parent.")
        end
    else
        --_print("XuiSkin -> no parent.")
    end
end

function ISXuiSkinFunctions.xuiRootElement(_self)
    if _self:getParent() then
        if _self:getParent().xuiRootElement then
            return _self:getParent():xuiRootElement();
        else
            _print("XuiSkin -> couldnt trigger xuiRootElement for parent.")
        end
    else
        return _self;
    end
end

ISXuiSkin = {};
ISXuiSkin.constructors = {};

function ISXuiSkin.build(_skin, _styleName, _luaClass, ...)
    if (not _luaClass) or (not _luaClass.Type) or type(_luaClass.Type)~="string" then
        print("ISXuiSkin -> _luaClass is nil or not class object, aborting...");
        return;
    end

    local bApplyXui = true;

    if _styleName~=nil and type(_styleName)~="string" then
        print("ISXuiSkin -> ERROR: supplied style is not 'string' or 'nil', styleName = "..tostring(_styleName));
        _styleName = nil;
    end

    local p = {...}

    local xuiStyleScript;
    local skin = _skin or XuiManager.GetDefaultSkin();

    if skin and bApplyXui then
        if instanceof(skin, "XuiSkin") then
            if _styleName then
                xuiStyleScript = skin:get(_luaClass.Type, _styleName);
            else
                xuiStyleScript = skin:getDefault(_luaClass.Type);
            end
        else
            print("ISXuiSkin -> ERROR: skin is not instance of XuiSkin, skin = "..tostring(skin));
        end

        if not xuiStyleScript then
            local s = _styleName or "(default style)";
            if getDebug() and not WARNED_STYLES[s] then
                print("ISXuiSkin -> could not find style for '"..tostring(_luaClass.Type).."', style = '"..tostring(s).."'...");
                WARNED_STYLES[s] = true;
            end
            bApplyXui = false;
        end
    else
        print("ISXuiSkin -> skin is nil...");
        bApplyXui = false;
    end

    local luaObject, hasAppliedTableKeys = nil, false;

    if bApplyXui and ISXuiSkin.constructors[_luaClass.Type] then
        luaObject, hasAppliedTableKeys = ISXuiSkin.constructors[_luaClass.Type](xuiStyleScript, ...);
    elseif _luaClass.new and type(_luaClass.new)=="function" then
        luaObject = _luaClass:new(p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11], p[12]);
        if p[13]~=nil then
            print("ISXuiSkin -> Constructor param overload");
        end
    else
        print("ISXuiSkin -> Cannot build class: "..tostring(_luaClass.Type));
    end

    if luaObject then
        if bApplyXui and not hasAppliedTableKeys then
            ISXuiSkin.autoApplyTableKeys(xuiStyleScript, luaObject, XuiAutoApply.IfSet);
        end

        luaObject.xuiSkin = skin;
        luaObject.xuiStyleScript = xuiStyleScript;
        luaObject.xuiStyleName = _styleName;

        -- add XuiSkin functions
        ISXuiSkin.RegisterXuiSkinFunctions(luaObject, false);
        --[[if not luaObject.xuiRecalculateLayout then
            luaObject.xuiRecalculateLayout = xuiRecalculateLayout;
        end--]]
    end

    return luaObject;
end

function ISXuiSkin.RegisterXuiSkinFunctions(_o, _force)
    for key,func in pairs(ISXuiSkinFunctions) do
        if (not _o[key]) or _force then
            _o[key] = func;
        end
    end
end

function ISXuiSkin.autoApplyTableKeys(_xuiScript, _o, _autoApplyOverride)
    ISXuiBuilder.autoApplyTableKeys(_xuiScript, _o, nil, nil, _autoApplyOverride or XuiAutoApply.IfSet);
end

--************************************************************************--
--** Custom Constructors
--************************************************************************--

function ISXuiSkin.constructors.ISWindow(_xuiScript, _title, _x, _y, _width, _height)
    local o = ISWindow:new(_title, _x, _y, _width, _height);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    --[[
    if _title then
        o.title = _title;
    end
    --]]
    return o, true;
end

function ISXuiSkin.constructors.ISCollapsableWindow(_xuiScript, _x, _y, _width, _height)
    local o = ISCollapsableWindow:new(_x, _y, _width, _height);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    o.titleFontHgt = getTextManager():getFontHeight(o.titleFont)
    return o, true;
end

function ISXuiSkin.constructors.ISButton(_xuiScript, _x, _y, _width, _height, _title, _clicktarget, _onclick, _onmousedown, _allowMouseUpProcessing)
    local o = ISButton:new(_x, _y, _width, _height, _title, _clicktarget, _onclick, _onmousedown, _allowMouseUpProcessing);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    o.originalWidth = o.width;
    o.originalHeight = o.height;
    --[[
    if _title then
        o.title = _title;
    end
    --]]
    return o, true;
end

function ISXuiSkin.constructors.ISImage(_xuiScript, _x, _y, _width, _height, _texture, _r, _g, _b)
    local o = ISImage:new(_x, _y, _width, _height, _texture);
	if _r and _g and _b then
		o:setColor(_r,_g,_b)
	end
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    --[[
    if _texture then
        o.texture = _texture;
    end
    --]]
    return o, true;
end

function ISXuiSkin.constructors.ISLabel(_xuiScript, _x, _y, _height, _name, _r, _g, _b, _a, _font, _bLeft)
    local o = ISLabel:new(_x, _y, _height, _name, _r, _g, _b, _a, _font, _bLeft);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    --[[
    if _name then
        o.name = _name;
    end
    if _font then
        o.font = _font;
    end
    if _r then o.r = _r; end
    if _g then o.g = _g; end
    if _b then o.b = _b; end
    if _a then o.a = _a; end
    --]]
    o.font = o.font or UIFont.Small;
	o.width = getTextManager():MeasureStringX(o.font, o.name)
	if (o.left ~= true) then
		o.x = o.x - o.width
	end
    if o.height <= 0 then
        o.height = o:getFontHeight();
    end
    return o, true;
end

function ISXuiSkin.constructors.ISProgressBar(_xuiScript, _x, _y, _width, _height, _text, _font)
    local o = ISProgressBar:new(_x, _y, _width, _height, _text, _font);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    --[[
    if _text then
        o.text = _text;
    end
    if _font then
        o.font = _font;
    end
    --]]
    o:setText(o.text);
    return o, true;
end

function ISXuiSkin.constructors.ISRichTextPanel(_xuiScript, _x, _y, _width, _height)
    local o = ISRichTextPanel:new(_x, _y, _width, _height);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    o:setText(o.text);
    return o, true;
end

function ISXuiSkin.constructors.ISScrollingListBox(_xuiScript, _x, _y, _width, _height)
    local o = ISScrollingListBox:new(_x, _y, _width, _height);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
	o.fontHgt = getTextManager():getFontFromEnum(o.font):getLineHeight();
    --itemheight correction if font was set from skin/style
	o.itemheight = o.fontHgt + o.itemPadY * 2;
    --if however itemheight was explicitly set in the style, override it
    local itemHeightVar = _xuiScript:getVar("itemheight");
    if itemHeightVar and itemHeightVar:isValueSet() then
        o.itemheight = itemHeightVar:value();
    end
    return o, true;
end

function ISXuiSkin.constructors.ISTabPanel(_xuiScript, _x, _y, _width, _height)
    local o = ISTabPanel:new(_x, _y, _width, _height);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    o.tabHeight = getTextManager():getFontHeight(o.font or UIFont.Small) + 6;
    local tabHeightVar = _xuiScript:getVar("tabHeight");
    if tabHeightVar and tabHeightVar:isValueSet() then
        o.tabHeight = tabHeightVar:value();
    end
    return o, true;
end

function ISXuiSkin.constructors.ISTextEntryBox(_xuiScript, _title, _x, _y, _width, _height)
    local o = ISTextEntryBox:new(_title, _x, _y, _width, _height);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    --[[
    if _title then
        o.title = _title;
    end
    --]]
    o.currentText = o.title;
    return o, true;
end

function ISXuiSkin.constructors.ISTickBox(_xuiScript, _x, _y, _width, _height, _name, _changeOptionTarget, _changeOptionMethod, _changeOptionArg1, _changeOptionArg2)
    local o = ISTickBox:new(_x, _y, _width, _height, _name, _changeOptionTarget, _changeOptionMethod, _changeOptionArg1, _changeOptionArg2);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    --[[
    if _name then
        o.title = _name;
    end
    --]]
    o.fontHgt = getTextManager():getFontHeight(o.font);
    o.itemHgt = math.max(o.boxSize, o.fontHgt) + o.itemGap;
    local itemHgtVar = _xuiScript:getVar("itemHgt");
    if itemHgtVar and itemHgtVar:isValueSet() then
        o.itemHgt = itemHgtVar:value();
    end
    return o, true;
end

function ISXuiSkin.constructors.ISToolTip(_xuiScript)
    local o = ISToolTip:new();
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    return o, true;
end

function ISXuiSkin.constructors.ISToolTipInv(_xuiScript, _item)
    local o = ISToolTipInv:new(_item);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    return o, true;
end

function ISXuiSkin.constructors.ISColorPicker(_xuiScript, _x, _y, _HSBFactor)
    local hsb = nil;
    local hsbVar = _xuiScript:getVar("hsbFactor");
    if hsbVar and hsbVar:isValueSet() then
        hsb = {
            h = hsbVar:getR(),
            s = hsbVar:getG(),
            b = hsbVar:getB(),
        }
    end
    hsb = _HSBFactor or hsb;
    local o = ISColorPicker:new(_x, _y, hsb);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    return o, true;
end

function ISXuiSkin.constructors.ISSliderPanel(_xuiScript, _x, _y, _width, _height, _target, _onValueChange, _customPaginate)
    local o = ISSliderPanel:new(_x, _y, _width, _height, _target, _onValueChange, _customPaginate);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    return o, true;
end

function ISXuiSkin.constructors.ISFluidBar(_xuiScript, _x, _y, _width, _height, _player, _resource)
    local o = ISFluidBar:new(_x, _y, _width, _height, _player, _resource);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    return o, true;
end

function ISXuiSkin.constructors.ISLedLight(_xuiScript, _x, _y, _width, _height)
    local o = ISLedLight:new(_x, _y, _width, _height);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    o.oldState = o.ledIsOn;
    return o, true;
end

function ISXuiSkin.constructors.ISLcdBar(_xuiScript, _x, _y, _charWidth)
    local o = ISLcdBar:new(_x, _y, _charWidth);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);
    return o, true;
end

function ISXuiSkin.constructors.ISItemSlot(_xuiScript, _x, _y, _width, _height, _resource, _target, _onItemDropped, _onItemRemove, _onVerifyItem, _onBoxClicked)
    local o = ISItemSlot:new(_x, _y, _width, _height, _resource, _target, _onItemDropped, _onItemRemove, _onVerifyItem, _onBoxClicked);
    ISXuiSkin.autoApplyTableKeys(_xuiScript, o);

    if o.resource and o.resource:getChannel()~=ResourceChannel.NO_CHANNEL then
        o.borderColor = colorToTable(o.resource:getChannel():getColor());
    end
    return o, true;
end