--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_PropaneBarbecueAddTank = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_PropaneBarbecueAddTank")
local Handler = ISLootWindowObjectControlHandler_PropaneBarbecueAddTank

function Handler:shouldBeVisible()
    return self.object:isPropaneBBQ() and (not self.object:hasPropaneTank()) and (ISBBQMenu.FindPropaneTank(self.playerObj, self.object) ~= nil)
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_Insert_Propane_Tank"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("ContextMenu_Insert_Propane_Tank"))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
	if isGamePaused() then
		return
	end
    local tank = ISBBQMenu.FindPropaneTank(self.playerObj, self.object)
	if not tank then return end
	ISBBQMenu.onInsertPropaneTank(nil, self.playerNum, self.object, tank)
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
