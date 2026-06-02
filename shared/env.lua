function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- iterator that can operate on both java ArrayList or lua indexed table
function xpairs(_t)
    if instanceof(_t, "ArrayList") then
        -- if arraylist return custom iterator
        local i = -1;
        local size = _t:size();
        return function()
            i = i + 1;
            if i==size then
                return nil;
            end
            return i,_t:get(i);
        end
    else
        -- else return the default ipairs
        return ipairs(_t);
    end
end

-- from ISChat originally
function logTo01(value)
    if value < 0.0 or value > 1.0 then
        error("only [0,1] accepted!");
    end
    if value > 0.0 then
        return math.log10(value * 100) - 1;
    end
    return 0.0;
end

-- from several files originally
function round2(num, idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

-- from ServerConnectPopup originally
function strsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; local i=1;
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

-- tries to find a function in _G such as MyWindowPanel.onclick
-- can also find a function in provided _parent, find string must start with "parent." in that case
function findFunction(_s, _parent)
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

function namedColorToTable(_name)
    local c = Colors.GetColorByName(_name);
    if c then
        return colorToTable(c);
    end
    DebugType.Lua:warn("env.lua-> namedColorToTable color not found: " .. tostring(_name));
    return {
        r=1,
        g=1,
        b=1,
        a=1,
    };
end

function colorToTable(_c)
    return {
        r=_c:getRedFloat(),
        g=_c:getGreenFloat(),
        b=_c:getBlueFloat(),
        a=_c:getAlphaFloat(),
    };
end

function safeColorToTable(_c)
    if not _c then
        return {
            r=1,
            g=1,
            b=1,
            a=1,
        };
    end
    return colorToTable(_c);
end

-- generic handler for UIElement.onMouseWheel
function onMouseWheelScrollHandler(_self, _del)
    if _self:getScrollHeight() > 0 then
        _self:setYScroll(_self:getYScroll() - (_del * 40))
        return true
    end
    return false
end

-- Source: https://www.tutorialspoint.com/lua/lua_data_types.htm
function isTable(object)
    return type(object) == "table"
end

-- Source: https://www.tutorialspoint.com/lua/lua_data_types.htm
function isFunction(object)
    return type(object) == "function"
end

-- Source: https://www.tutorialspoint.com/lua/lua_data_types.htm
function isNil(object)
    return type(object) == "nil"
end

-- Source: https://www.tutorialspoint.com/lua/lua_data_types.htm
function isBoolean(object)
    return type(object) == "boolean"
end

-- Source: https://www.tutorialspoint.com/lua/lua_data_types.htm
function isNumber(object)
    return type(object) == "number"
end

function isString(object)
    return type(object) == "string"
end

function math.sign(x)
   return x > 0 and 1 or (x < 0 and -1 or 0)
end

function math.length2sq(x, y)
    return x * x + y * y
end

function math.length2(x, y)
    local lengthSq = math.length2sq(x, y)
    return math.sqrt(lengthSq)
end

function math.rangesOverlap(a1, a2, b1, b2)
    local minA = math.min(a1, a2)
    local maxA = math.max(a1, a2)
    local minB = math.min(b1, b2)
    local maxB = math.max(b1, b2)

    return math.isBetweenInclusive(minB, minA, maxA)
        or math.isBetweenInclusive(maxB, minA, maxA)
        or math.isBetweenInclusive(minA, minB, maxB)
        or math.isBetweenInclusive(maxA, minB, maxB)
end

function math.isBetweenInclusive(val, min, max)
    return min <= val and max >= val
end

function math.clamp(val, min, max)
    return math.min(max, math.max(min, val))
end
