--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ISXuiBuilder = {};
ISXuiBuilder.constructors = {};

local NO_CHILD_TABLE = true;

local math_max = math.max;
local math_min = math.min;

-- tries to find a function in _G such as MyWindowPanel.onclick
-- can also find a function in provided _parent, find string must start with "parent." in that case
local function findFunction(_s, _parent)
    if string.find(_s, ".") then
        local func = nil;

        local split = luautils.split(_s, ".")

        if split[1]=="parent" and not _parent then
            return nil;
        end
        local container = split[1]=="parent" and _parent or _G;
        for i=_parent and 2 or 1,#split do
            local v = split[i];
            if not v then return nil; end
            if i==#split then
                if container[v] and type(container[v])=="function" then
                    func = container[v];
                end
            end
            if container[v] and type(container[v])=="table" then
                container = container[v];
            else
                break;
            end
        end
        return func;
    end
end

local function hasFunction(_o, _funcName)
    return _o and _o[_funcName] and type(_o[_funcName])=="function";
end

local vectorFunctions = {
    "getX", "getY", "getWidth", "getHeight",
    "setX", "setY", "setWidth", "setHeight"
}

local function hasVectorFunctions(_o)
    if _o then
        for _, name in ipairs(vectorFunctions) do
            if not hasFunction(_o, name) then
                return false;
            end
        end
    end
    return true;
end

local function applySpacing(_spacing, _origX, _origY, _origW, _origH)
    local rectX = _origX;
    local rectY = _origY;
    local rectW = _origW;
    local rectH = _origH;
    local multi;

    if _spacing:isValueSet() then
        if _spacing:getTop()>0 then
            multi = _spacing:isTopPercent() and rectH or 1.0;
            rectY = rectY + (multi * _spacing:getTop());
            rectH = rectH - (multi * _spacing:getTop());
        end
        if _spacing:getBottom()>0 then
            multi = _spacing:isBottomPercent() and rectH or 1.0;
            rectH = rectH - (multi * _spacing:getBottom());
        end

        if _spacing:getLeft()>0 then
            multi = _spacing:isLeftPercent() and rectW or 1.0;
            rectX = rectX + (multi * _spacing:getLeft());
            rectW = rectW - (multi * _spacing:getLeft());
        end
        if _spacing:getRight()>0 then
            multi = _spacing:isRightPercent() and rectW or 1.0;
            rectW = rectW - (multi * _spacing:getRight());
        end

        rectX = math_min(rectX, _origX+_origW);
        rectY = math_min(rectY, _origY+_origH);
        rectH = math_max(rectH, 0);
        rectW = math_max(rectW, 0);
    end
    return rectX, rectY, rectW, rectH;
end

local function applySizing(_o, _parent)
    if _o.__xui and _o.__xui.script then
        local parent = _parent or _o.parent;
        local align = _o.__xui.script:getPosAlign():value();
        local vector = _o.__xui.script:getVector();
        local padding = _o.__xui.script:getPadding();
        local margin = _o.__xui.script:getMargin();

        local hasPercent = vector:isxPercent() or vector:isyPercent() or vector:iswPercent() or vector:ishPercent();
        if hasPercent and (not parent) then
            print("Cannot apply vector with percentage align, no parent for object");
            return;
        elseif not hasVectorFunctions(parent) then
            print("Cannot apply vector, parent object does not have vector functions");
            return;
        end
        if not hasVectorFunctions(_o) then
            print("Cannot apply vector, object does not have vector functions");
            return;
        end

        local rect = parent and parent.__xui and parent.__xui.rectangle;
        if _o.__xui and _o.__xui.cell then
            rect = _o.__xui.cell;
        end
        if not rect then
            print("Cannot apply sizing, object does not have rectangle");
            return;
        end

        local rectX, rectY, rectW, rectH = applySpacing(padding, rect.x, rect.y, rect.w, rect.h);

        local w = vector:iswPercent() and rectW*vector:getW() or vector:getW();
        local h = vector:ishPercent() and rectH*vector:getH() or vector:getH();
        local x = vector:isxPercent() and rectW*vector:getX() or vector:getX();
        local y = vector:isyPercent() and rectH*vector:getY() or vector:getY();

        x = rectX + x;
        y = rectY + y;


        x = x-(w*align:getXmod());
        y = y-(h*align:getYmod());


        _o:setX(x);
        _o:setY(y);
        _o:setWidth(w);
        _o:setHeight(h);

        rectX, rectY, rectW, rectH = applySpacing(margin, 0, 0, w, h);

        _o.__xui.rectangle = _o.__xui.rectangle or {};
        _o.__xui.rectangle.x = rectX;
        _o.__xui.rectangle.y = rectY;
        _o.__xui.rectangle.w = rectW;
        _o.__xui.rectangle.h = rectH;

        -- self padding needs to be applied on pos and width etc

        -- self margin needs to be applied on the rectangle.
    else
        print("Cannot apply vector, no __xui table.")
    end
end

--[[
    These functions get set on tables created by Xui
--]]
ISXuiFunctions = {};

--***************
-- XuiKey
--***************
-- tries to get a child with xuiKey in children only, returns first found
function ISXuiFunctions.xuiGet(_self, _xuiKey)
    if _self and _self.__xui and _self.__xui.children and _xuiKey then
        for _,v in ipairs(_self.__xui.children) do
            if v.xuiKey==_xuiKey and v.element.__xui.key==_xuiKey then
                return v.element;
            end
        end
    end
    return nil;
end

-- tries to find a child with xuiKey in children and hierarchy, returns first found
function ISXuiFunctions.xuiFind(_self, _xuiKey)
    if not _self.xuiGet then
        return nil;
    end
    local element = _self:xuiGet(_xuiKey);
    if element then
        return element;
    elseif _self.__xui and _self.__xui.children then
        for _,v in ipairs(_self.__xui.children) do
            if v.element.xuiFind then
                element = v.element:xuiFind(_xuiKey);
                if element then
                    return element;
                end
            end
        end
    end
    return nil;
end

-- similar to Get, but collects all elements with xuiKey and returns table
function ISXuiFunctions.xuiGetAll(_self, _xuiKey, _list)
    local list = _list or {};
    if _self and _self.__xui and _self.__xui.children and _xuiKey then
        for _,v in ipairs(_self.__xui.children) do
            if v.xuiKey==_xuiKey and v.element.__xui.key==_xuiKey then
                table.insert(list, v.element);
            end
        end
    end
    return list;
end

-- similar to Find, but collects all elements with xuiKey and returns table
function ISXuiFunctions.xuiFindAll(_self, _xuiKey, _list)
    local list = _list or {};
    if not _self.xuiGetAll then
        return list;
    end
    list = _self:xuiGetAll(_xuiKey, list);
    local element;
    if _self.__xui and _self.__xui.children then
        for _,v in ipairs(_self.__xui.children) do
            if v.element.xuiFindAll then
                v.element:xuiFindAll(_xuiKey, list);
                --[[
                element = v.element:xuiFindAll(_xuiKey);
                if element then
                    table.insert(list, element);
                end
                --]]
            end
        end
    end
    return list;
end

--***************
-- LuaClass
--***************
-- tries to get a child with luaClass in children only, returns first found
function ISXuiFunctions.xuiGetClass(_self, _luaClass)
    if _self and _self.__xui and _self.__xui.children and _luaClass then
        for _,v in ipairs(_self.__xui.children) do
            if v.element.__xui and v.element.__xui.script and v.element.__xui.script:getXuiLuaClass() then
                if v.element.__xui.script:getXuiLuaClass()==_luaClass then
                    return v.element;
                end
            end
        end
    end
    return nil;
end

-- tries to find a child with luaClass in children and hierarchy, returns first found
function ISXuiFunctions.xuiFindClass(_self, _luaClass)
    if not _self.xuiGetClass then
        return nil;
    end
    local element = _self:xuiGetClass(_luaClass);
    if element then
        return element;
    elseif _self.__xui and _self.__xui.children then
        for _,v in ipairs(_self.__xui.children) do
            if v.element.xuiFindClass then
                element = v.element:xuiFindClass(_luaClass);
                if element then
                    return element;
                end
            end
        end
    end
    return nil;
end

-- similar to GetClass, but collects all elements with luaClass and returns table
function ISXuiFunctions.xuiGetClassAll(_self, _luaClass, _list)
    local list = _list or {};
    if _self and _self.__xui and _self.__xui.children and _luaClass then
        for _,v in ipairs(_self.__xui.children) do
            if v.element.__xui and v.element.__xui.script and v.element.__xui.script:getXuiLuaClass() then
                if v.element.__xui.script:getXuiLuaClass()==_luaClass then
                    table.insert(list, v.element);
                end
            end
        end
    end
    return list;
end

-- similar to FindClass, but collects all elements with luaClass and returns table
function ISXuiFunctions.xuiFindClassAll(_self, _luaClass, _list)
    local list = _list or {};
    if not _self.xuiGetClassAll then
        return list;
    end
    list = _self:xuiGetClassAll(_luaClass, list);
    local element;
    if _self.__xui and _self.__xui.children then
        for _,v in ipairs(_self.__xui.children) do
            if v.element.xuiFindClassAll then
                v.element:xuiFindClassAll(_luaClass, list);
                --[[
                element = v.element:xuiFindClassAll(_luaClass);
                if element then
                    table.insert(list, element);
                end
                --]]
            end
        end
    end
    return list;
end

--***************
-- UUID
--***************

-- gets the uuid of xui script
function ISXuiFunctions.xuiGetUUID(_self)
    if _self and _self.__xui and _self.__xui.script then
        return _self.__xui.script:getXuiUUID();
    end
end

-- collects all elements with script uuid in the hierarchy
function ISXuiFunctions.xuiFindAllUUID(_self, _uuid, _list)
    local list = _list or {};
    if (not _uuid) or (not _self.xuiGetUUID) then return list; end

    local uuid = _self:xuiGetUUID();
    if uuid and uuid==_uuid then
        table.insert(list, _self);
    end
    if _self.__xui and _self.__xui.children then
        for _,v in ipairs(_self.__xui.children) do
            if v.element.xuiFindAllUUID then
                list = v.element:xuiFindAllUUID(_uuid, list);
            end
        end
    end
    return list;
end

function ISXuiBuilder.RegisterXuiFunctions(_o, _force)
    for key,func in pairs(ISXuiFunctions) do
        if (not _o[key]) or _force then
            _o[key] = func;
        end
    end
end

local function buildInternal(_xuiScript, _parent, _buildInfo, _noChildren, ...)
    local element, hasInitialized = nil, false;
    local class = _xuiScript:getXuiLuaClass();

    local p = {...}

    if class and ISXuiBuilder.constructors[class] then
        element, hasInitialized = ISXuiBuilder.constructors[class](_xuiScript, _parent, _buildInfo, ...);
    elseif class and _G[class] and _G[class].new and type(_G[class].new)=="function" then
        element = _G[class]:new(p[1] or 0, p[2] or 0, p[3] or 0, p[4] or 0, p[5] or nil, p[6] or nil, p[7] or nil, p[8] or nil, p[9] or nil, p[10] or nil, p[11] or nil, p[12] or nil);
        if p[13]~=nil then
            print("Constructor param overload");
        end
    else
        print("Cannot build class: "..tostring(class));
    end

    if element then
        --print("Building "..tostring(class))
        if not hasInitialized then
            ISXuiBuilder.initialiseObject(_xuiScript, element, _parent);
        end

        -- add xui functions
        ISXuiBuilder.RegisterXuiFunctions(element, true);

        local resizeOld = element.onResize;
        local function onResize(_self, _width, _height)
            applySizing(_self);
            if resizeOld then
                resizeOld(_self, _width, _height);
            end
            --applySizing(_self);
        end
        element.onResize = onResize;

        if (not _noChildren) and _xuiScript:getChildren():size()>0 then
            for i=0,_xuiScript:getChildren():size()-1 do
                local xuiScript = _xuiScript:getChildren():get(i);

                if xuiScript:getScriptType()==XuiScriptType.Reference then
                    if xuiScript:getDynamic():value() then
                        if _buildInfo and _buildInfo.references then
                            local layoutName = _buildInfo.references[xuiScript:getLayout():value()];
                            xuiScript = XuiManager.GetLayout(layoutName);
                            if not xuiScript then
                                print("ISXuiBuilder -> Warning could not find dynamic layout: "..tostring(layoutName)..", reference: "..tostring(xuiScript:getLayout():value()));
                            end
                        else
                            print("ISXuiBuilder -> Warning dynamic reference but no reference table supplied.");
                        end
                    else
                        xuiScript = xuiScript:getReferenceLayout();
                    end
                end

                if xuiScript then
                    local child = buildInternal(xuiScript, element, _buildInfo, nil);
                    if child then
                        element:addChild(child);
                        table.insert(element.__xui.children, {
                            xuiKey = xuiScript:getXuiKey(),
                            element = child,
                        })
                    end
                else
                    print("ISXuiBuilder -> XuiScript is nil.");
                end
            end
        end

        return element;
    end
end

function ISXuiBuilder.initialiseObject(_xuiScript, _o, _parent)
    _o.x = _o.x or 0;
    _o.y = _o.y or 0;
    _o.width = _o.width or 0;
    _o.height = _o.height or 0;
    ISXuiBuilder.autoApplyTableKeys(_xuiScript, _o, _parent);
    _o:initialise();
    _o:instantiate();

    -- add special table to object.
    ISXuiBuilder.applyXuiTable(_xuiScript, _o, _parent);

    ISXuiBuilder.applySizing(_xuiScript, _o, _parent);
end

-- ###############################################
-- # Main build options:                         #
-- ###############################################

-- only _xuiScript is required.
function ISXuiBuilder.build(_xuiScript, _parent, _buildInfo)
    local element = buildInternal(_xuiScript, _parent, _buildInfo, nil);
    if _parent then
        ISXuiBuilder.applyXuiTable(nil, _parent);
        --_parent.__xui.children[_xuiScript:getXuiKey()] = element;
        table.insert(_parent.__xui.children, {
            xuiKey = _xuiScript:getXuiKey(),
            element = element,
        })

        ISXuiBuilder.RegisterXuiFunctions(_parent, false)
    end
    return element;
end

-- only _xuiScript is required.
function ISXuiBuilder.buildSingle(_xuiScript, _parent, _buildInfo, ...)
    local element = buildInternal(_xuiScript, _parent, _buildInfo, true, ...);
    if _parent then
        ISXuiBuilder.applyXuiTable(nil, _parent);
        --_parent.__xui.children[_xuiScript:getXuiKey()] = element;
        table.insert(_parent.__xui.children, {
            xuiKey = _xuiScript:getXuiKey(),
            element = element,
        })

        ISXuiBuilder.RegisterXuiFunctions(_parent, false)
    end
    return element;
end

-- ###############################################
-- # END                                         #
-- ###############################################

function ISXuiBuilder.applySpacing(_spacing, _origX, _origY, _origW, _origH)
    return applySpacing(_spacing, _origX, _origY, _origW, _origH)
end

function ISXuiBuilder.applyXuiTable(_xuiScript, _o, _parent, _noChildTable)
    _o.__xui = _o.__xui or {};
    if not _noChildTable then
        _o.__xui.children = _o.__xui.children or {};
    end
    if _parent then
        _o.__xui.parent = _parent;
    end
    if _xuiScript then
        _o.__xui.key = _xuiScript:getXuiKey();
        _o.__xui.script = _xuiScript;
    end
end

function ISXuiBuilder.ensureXuiTable(_o)
    _o.__xui = _o.__xui or {};
end

function ISXuiBuilder.applySizing(_xuiScript, _o, _parent)
    ISXuiBuilder.ensureXuiTable(_o);
    applySizing(_o, _parent);
end

function ISXuiBuilder.setDrawRectangle(_o, _x, _y, _width, _height)
    ISXuiBuilder.ensureXuiTable(_o);
    _o.__xui.rectangle = _o.__xui.rectangle or {};
    _o.__xui.rectangle.x = _x;
    _o.__xui.rectangle.y = _y;
    _o.__xui.rectangle.w = _width;
    _o.__xui.rectangle.h = _height;
end

-- This rectangle is set to children of cells by XuiTableLayout
function ISXuiBuilder.setCellRectangle(_o, _x, _y, _width, _height)
    ISXuiBuilder.ensureXuiTable(_o);
    _o.__xui.cell = _o.__xui.cell or {};
    _o.__xui.cell.x = _x;
    _o.__xui.cell.y = _y;
    _o.__xui.cell.w = _width;
    _o.__xui.cell.h = _height;
end

function ISXuiBuilder.autoApplyTableKeys(_xuiScript, _o, _parent, _ignoreKeys, _autoApplyOverride)
    local vars = _xuiScript:getVars();
    for i=0, vars:size()-1 do
        local var = vars:get(i);

        if var:getLuaTableKey() then
            --print("Applying key = "..tostring(var:getLuaTableKey()))
            local proceed = (not _ignoreKeys) or (not _ignoreKeys[var:getLuaTableKey()]);
            if proceed then
                local autoApplyMode = _autoApplyOverride or var:getAutoApplyMode();

                if var:getAutoApplyMode()==XuiAutoApply.Forbidden then
                    autoApplyMode = XuiAutoApply.Forbidden;
                end

                if autoApplyMode==XuiAutoApply.No or autoApplyMode==XuiAutoApply.Forbidden then
                    proceed = false;
                elseif autoApplyMode == XuiAutoApply.IfSet then
                    proceed = var:isValueSet();
                elseif autoApplyMode == XuiAutoApply.IfSetAndKeyExists then
                    proceed = var:isValueSet() and _o[var:getLuaTableKey()]~=nil;
                else
                    proceed = true;
                end
            end
            if proceed then
                if var:getType()==XuiVarType.Color then
                    if var:value() then
                        _o[var:getLuaTableKey()] = ISXuiBuilder.colorTable(var);
                    end
                elseif var:getType()==XuiVarType.Texture then
                    _o[var:getLuaTableKey()] = var:getTexture();
                elseif var:getType()==XuiVarType.StringList then
                    local list = {};
                    if var:value() and var:value():size()>0 then
                        for i=0,var:value():size()-1 do
                            table.insert(list, var:value():get(i));
                        end
                    end
                    _o[var:getLuaTableKey()] = list;
                elseif var:getType()==XuiVarType.Function then
                    print("XuiBuilder, Function type currently not implemented");
                elseif var:getType()==XuiVarType.Vector then
                    --Vectors are not automatically applied, except the default vector which is handled in 'ISXuiBuilder.applySizing'
                else
                    _o[var:getLuaTableKey()] = var:value();
                end
            end
        end
    end
end

function ISXuiBuilder.colorTable(_xuiColor)
    return {
        r = _xuiColor:getR(),
        g = _xuiColor:getG(),
        b = _xuiColor:getB(),
        a = _xuiColor:getA(),
    }
end

function ISXuiBuilder.colorTableFromColor(_color)
    return {
        r = _color:getRedFloat(),
        g = _color:getGreenFloat(),
        b = _color:getBlueFloat(),
        a = _color:getAlphaFloat(),
    }
end

function ISXuiBuilder.texture(_texName)
    if not _texName then
        return nil;
    end
    return getTexture(_texName);
end

--************************************************************************--
--** Custom Constructors
--** By default ISBuilder tries to automatically create the UIElement class and initialise it.
--** However some elements may throw errors when constructing with nil values for certain constructor parameters.
--** Creating a constructor here allows working around that problem and can be used to do other custom initialization for elements.
--************************************************************************--

--[[
    Example Constructor Handler
    Note that original constructor params such as function callbacks, clicktarget etc can be appended in the function params.
    However note that they will only be passed to these functions by Xui when building a single ui element.
    When building a ui hierarchy these params can not be passed and thus are not guaranteed.
--]]
function ISXuiBuilder.constructors.ISMyUIClassExample(_xuiScript, _parent, _buildInfo, x, y, width, height, clicktarget, onclick, onmousedown)
    --optionally override some constructor params
    local vector = _xuiScript:getVector();
    local o = ISMyUIClassExample:new(vector:getX(), vector:getY(), vector:getW(), vector:getH(), clicktarget, onclick, onmousedown);
    --[[
    Some custom handling here.
    It is also possible to do the initialization here (for example when AutoTableKey causes problems with the element).
    In that case return true as last parameter to let the builder know initialization is done:
    return o, true;
    --]]
    return o, false;
end

function ISXuiBuilder.constructors.ISXuiTableLayout(_xuiScript, _parent, _buildInfo, x, y, width, height, columns, rows)
    local colCount = _xuiScript:getColumnCount();
    local rowCount = _xuiScript:getRowCount();
    local o = ISXuiTableLayout:new(0, 0, 0, 0, colCount, rowCount);

    for i=0,colCount-1 do
        local colScript = _xuiScript:getColumn(i);
        local col = o:column(i);
        if colScript and col then
            ISXuiBuilder.autoApplyTableKeys(colScript, col);
            --ISXuiBuilder.applyXuiTable(colScript, col);
            col.configWidth = colScript:getVector():getW();
            col.isPercent = colScript:getVector():iswPercent();
        end
    end

    for i=0,rowCount-1 do
        local rowScript = _xuiScript:getRow(i);
        local row = o:row(i);
        if rowScript and row then
            ISXuiBuilder.autoApplyTableKeys(rowScript, row);
            --ISXuiBuilder.applyXuiTable(rowScript, row);
            row.configHeight = rowScript:getVector():getH();
            row.isPercent = rowScript:getVector():ishPercent();
        end
    end

    ISXuiBuilder.initialiseObject(_xuiScript, o, _parent);
    --[[
    ISXuiBuilder.autoApplyTableKeys(_xuiScript, o, _parent);
    o:initialise();
    o:instantiate();
    -- add special table to object.
    ISXuiBuilder.applyXuiTable(_xuiScript, o, _parent);

    ISXuiBuilder.applySizing(_xuiScript, o, _parent);
    --]]

    for y=0,rowCount-1 do
        for x=0,colCount-1 do
            local cellScript = _xuiScript:getCell(x, y);
            local cell = o:ensureCell(x, y);
            if cellScript and cell then
                ISXuiBuilder.autoApplyTableKeys(cellScript, cell);
                ISXuiBuilder.applyXuiTable(cellScript, cell, nil, NO_CHILD_TABLE);
                for i=0,cellScript:getChildren():size()-1 do
                    local child = ISXuiBuilder.build(cellScript:getChildren():get(i), o, _buildInfo);
                    if child then
                        cell:addChild(child);
                    end
                end
            end
        end
    end
    return o, true;
end

--[[
function ISXuiBuilder.ISButton(_xuiScript, _parent, x, y, width, height, title, clicktarget, onclick, onmousedown, allowMouseUpProcessing)
    local vector = _xuiScript:getVector();
    local o = ISButton:new(vector:getX(), vector:getY(), vector:getW(), vector:getH(), _xuiScript:getTitle(), clicktarget, onclick, onmousedown, allowMouseUpProcessing);
    return o, false;
end
--]]

--[[
    ISColorPicker
--]]
function ISXuiBuilder.constructors.ISColorPicker(_xuiScript, _parent, _buildInfo, _x, _y, _HSBFactor)
    local vector = _xuiScript:getVector();
    local hsb = nil;
    if _xuiScript:getHsbFactor():value() then
        hsb = {
            h = _xuiScript:getHsbFactor():getR(),
            s = _xuiScript:getHsbFactor():getG(),
            b = _xuiScript:getHsbFactor():getB(),
        }
    end
    hsb = hsb or _HSBFactor;
    local o = ISColorPicker:new(vector:getX(), vector:getY(), hsb);
    return o, false;
end

function ISXuiBuilder.constructors.ISImage(_xuiScript, _parent, _buildInfo, _x, _y, _width, _height, _texture)
    local vector = _xuiScript:getVector();
    local o = ISImage:new(vector:getX(), vector:getY(), vector:getW(), vector:getH(), false);
    o.textureOverride = false;
    o.tooltip = false;
    return o, false;
end

function ISXuiBuilder.constructors.ISLabel(_xuiScript, _parent, _buildInfo, _x, _y, _height, _name, _r, _g, _b, _a, _font, _bLeft)
    local vector = _xuiScript:getVector();
    local name = _xuiScript:getName():value() or "";
    local font = _xuiScript:getFont():value() or UIFont.Small;
    local bleft = _xuiScript:getTextAlign():value()==TextAlign.Left;
    local c = _xuiScript:getTextColor():value();
    local r,g,b,a=1,1,1,1;
    if c then
        r = c:getRedFloat();
        g = c:getGreenFloat();
        b = c:getBlueFloat();
        a = c:getAlphaFloat();
    end
    local o = ISLabel:new(vector:getX(), vector:getY(), vector:getH(), name, r, g, b, a, font, bleft);
    if _xuiScript:getTextAlign():value()==TextAlign.Center then
        o.center = true;
    end
    return o, false;
end

--[[
function ISXuiBuilder.ISImage(_xuiScript, _parent, x, y, width, height, texture)
    local vector = _xuiScript:getVector();
    local o = ISImage:new(vector:getX(), vector:getY(), ISXuiBuilder.texture(_xuiScript:getTexture()));
    o.textureOverride = ISXuiBuilder.texture(_xuiScript:getTextureOverride());
    return o, false;
end

function ISXuiBuilder.ISTickBox(_xuiScript, _parent, x, y, width, height, name, changeOptionTarget, changeOptionMethod, changeOptionArg1, changeOptionArg2)
    local vector = _xuiScript:getVector();
    local o = ISImage:new(vector:getX(), vector:getY(), _xuiScript:getName());
    if _xuiScript:getTextureTick() then
        o.tickTexture = ISXuiBuilder.texture(_xuiScript:getTextureTick());
    end
    o.name = _xuiScript:getName();
    if _xuiScript:getColorChoices() then
        o.choicesColor = ISXuiBuilder.colorTable(_xuiScript:getColorChoices());
    end
    return o, false;
end
--]]


