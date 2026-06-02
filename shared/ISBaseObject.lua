ISBaseObject = {};

ISBaseObject.Type = "ISBaseObject";

function ISBaseObject:initialise()

end

function ISBaseObject:derive(type)
    local o = {}
    setmetatable(o, self)
    self.__index = self
	o.Type = type
	o.SuperType = self
    return o
end

function ISBaseObject:new()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.SuperType = nil
	return o
end

function ISBaseObject:instanceof(object, type)
    if (object == nil) then
        return false
    end

    if (isTable(object) == false) then
        -- Not an object
        return false
    end

    if (object.Type == nil) then
        DebugType.LuaObject:printStackTrace(LogSeverity.Warning, 4, "No Type found: " .. tostring(object))
        return false
    end

    type = type or self.Type

    if (type ~= ISBaseObject.Type and ISBaseObject:instanceof(object, ISBaseObject.Type) == false) then
        DebugType.LuaObject:printStackTrace(LogSeverity.Warning, 4, "Not an ISBaseObject: " .. tostring(object))
        return false;
    end

    if (object.Type == type) then
        return true
    end

    if (object.SuperType == object.Type) then
        DebugType.LuaObject:printStackTrace(LogSeverity.Error, 4, "Cyclic type info. SuperType == Type: " .. tostring(object.Type) .. " " .. tostring(object))
        return false;
    end

    return object.SuperType ~= nil and ISBaseObject:instanceof(object.SuperType, type)
end

function ISBaseObject:addEventListener(_event, _callback, _target)
	if not self.__eventListeners then
		self.__eventListeners = {};
	end
	if not self.__eventListeners[_event] then
		self.__eventListeners[_event] = {};
	end
	self.__eventListeners[_event][_callback] = _target or false;
end

function ISBaseObject:removeEventListener(_event, _callback)
	if not self.__eventListeners then
		return;
	end
	if not self.__eventListeners[_event] then
		return;
	end
	self.__eventListeners[_event][_callback] = nil;
end

function ISBaseObject:triggerEvent(_event, ...)
	if self.__eventListeners and self.__eventListeners[_event] then
		local p = {...};
        if p[13]~=nil then
            print("ISBaseObject.triggerEvent -> param overload");
        end
		for callback,target in pairs(self.__eventListeners[_event]) do
			if target then
				callback(target, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11], p[12]);
			else
				callback(p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10], p[11], p[12]);
			end
		end
	end
end

function ISBaseObject:clearEventListeners()
	self.__eventListeners = nil;
end
