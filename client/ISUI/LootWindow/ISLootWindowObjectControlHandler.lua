--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISBaseObject"
require "ISUI/ISButton"

ISLootWindowObjectControlHandler = ISBaseObject:derive("ISLootWindowObjectControlHandler")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function ISLootWindowObjectControlHandler:shouldBeVisible()
    return false
end

function ISLootWindowObjectControlHandler:getControl()
    -- Default control is a button.  Could be a combobox, slider, etc.
    return self:getButtonControl("Button")
end

function ISLootWindowObjectControlHandler:getButtonControl(title)
    if not self.control then
        self.control = ISButton:new(0, 0, 200, 2 + FONT_HGT_SMALL + 2, "", self,
            function(_self, _button) _self:perform() end)
        self.control.borderColor = {r=0.4, g=0.4, b=0.4, a=1} -- same as ISInventoryPage
        if self.altColor then -- the button applies to the object, not to the container contents
            local GHC = getCore():getGoodHighlitedColor()
            local r, g, b = GHC:getR() / 2, GHC:getG() / 2, GHC:getB() / 2
            self.control:setBackgroundRGBA(r, g, b, 0.25)
            self.control:setBackgroundColorMouseOverRGBA(r, g, b, 0.50)
            self.control:setBorderRGBA(r, g, b, 1)
        end
    end
    self.control:setTitle(title)
    self.control:setWidthToTitle()
    return self.control
end

function ISLootWindowObjectControlHandler:handleJoypadContextMenu(context)
end

function ISLootWindowObjectControlHandler:addJoypadContextMenuOption(context, text)
    local option = context:addOption(text, self, self.perform)
    return option
end

function ISLootWindowObjectControlHandler:perform()
end

function ISLootWindowObjectControlHandler:new()
    local o = ISBaseObject.new(self)
    o.altColor = false
    return o
end
