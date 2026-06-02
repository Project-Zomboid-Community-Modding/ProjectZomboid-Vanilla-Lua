require "ISBaseObject"
require "ISUI/Style/ISBrush"

local FONT_DEFAULT = UIFont.Medium
local FONT_DEFAULT_HEIGHT = getTextManager():getFontHeight(FONT_DEFAULT)
local BRUSH_DEFAULT = ISBrush.Solid

ISStyle = ISBaseObject:derive("ISStyle")
ISStyle.fonts = {}
ISStyle.brushes = {}

function ISStyle:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function ISStyle:getFont(key)
    local fontEntry = self.fonts[key]
    if (fontEntry == nil) then
        return FONT_DEFAULT
    end

    return fontEntry.font
end

function ISStyle:getFontHeight(key)
    local fontEntry = self.fonts[key]
    if (fontEntry == nil) then
        return FONT_DEFAULT_HEIGHT
    end

    return fontEntry.height
end

function ISStyle:setFont(key, font)
    local fontEntry = {
        key = key,
        font = font,
        height = getTextManager():getFontHeight(font)
    }
    self.fonts[key] = fontEntry
end

function ISStyle:getBrush(key)
    return self.brushes[key] or BRUSH_DEFAULT
end

function ISStyle.getDefault()
    return ISStyle.default
end

function ISStyle.setDefault(style)
    ISStyle.default = style
end

ISStyle.default = ISStyle:new()
