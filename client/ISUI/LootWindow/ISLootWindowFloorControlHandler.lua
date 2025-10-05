--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISBaseObject"
require "ISUI/ISButton"

ISLootWindowFloorControlHandler = ISBaseObject:derive("ISLootWindowFloorControlHandler")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function ISLootWindowFloorControlHandler:shouldBeVisible()
    return false
end

function ISLootWindowFloorControlHandler:getControl()
    -- Default control is a button.  Could be a combobox, slider, etc.
    return self:getButtonControl("Button")
end

function ISLootWindowFloorControlHandler:getButtonControl(title)
    if not self.control then
        self.control = ISButton:new(0, 0, 200, 2 + FONT_HGT_SMALL + 2, "", self,
            function(_self, _button) _self:perform() end)
        self.control.borderColor = {r=0.4, g=0.4, b=0.4, a=1} -- same as ISInventoryPage
    end
    self.control:setTitle(title)
    self.control:setWidthToTitle()
    return self.control
end

function ISLootWindowFloorControlHandler:handleJoypadContextMenu(context)
end

function ISLootWindowFloorControlHandler:addJoypadContextMenuOption(context, text)
    local option = context:addOption(text, self, self.perform)
    return option
end

function ISLootWindowFloorControlHandler:perform()
end

function ISLootWindowFloorControlHandler:new()
    local o = ISBaseObject.new(self)
    return o
end
