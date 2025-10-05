--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_PropaneBarbecueToggle = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_PropaneBarbecueToggle")
local Handler = ISLootWindowObjectControlHandler_PropaneBarbecueToggle

function Handler:shouldBeVisible()
    return self.object:isPropaneBBQ() and self.object:hasFuel()
end

function Handler:getControl()
    local xln = nil
    if self.object:isLit() then
        xln = "ContextMenu_Turn_Off"
    else
        xln = "ContextMenu_Turn_On"
    end
    self.control = self:getButtonControl(getText(xln))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local xln = nil
    if self.object:isLit() then
        xln = "ContextMenu_Turn_Off"
    else
        xln = "ContextMenu_Turn_On"
    end
    local option = self:addJoypadContextMenuOption(context, getText(xln))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
	if isGamePaused() then
		return
	end
	ISBBQMenu.onToggle(nil, self.playerNum, self.object, nil)
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
