require "ISBaseObject"

local COLOR_DEFAULT = { r = 1, g = 1, b = 1, a = 1 }

ISBrush = ISBaseObject:derive("ISBrush")

function ISBrush:new(type )
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.type = type
    o.color = COLOR_DEFAULT
    return o
end

ISBrush.Solid = ISBrush:new("Solid")
