--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_PropaneBarbecueRemoveTank = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_PropaneBarbecueRemoveTank")
local Handler = ISLootWindowObjectControlHandler_PropaneBarbecueRemoveTank

function Handler:shouldBeVisible()
    return self.object:isPropaneBBQ() and self.object:hasPropaneTank()
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_Remove_Propane_Tank"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("ContextMenu_Remove_Propane_Tank"))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
	if isGamePaused() then
		return
	end
	ISBBQMenu.onRemovePropaneTank(nil, self.playerNum, self.object, nil)
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
