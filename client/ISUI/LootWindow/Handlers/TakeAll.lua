--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_TakeAll = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_TakeAll")
local Handler = ISLootWindowObjectControlHandler_TakeAll

function Handler:shouldBeVisible()
    return not self.container:isEmptyOrUnwanted(self.playerObj)
--     return not self.container:isEmpty()
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("IGUI_invpage_Loot_all"))
    return self.control
end

function Handler:perform()
    if isGamePaused() then return end
	ISInventoryPage.lootAll(self.lootWindow)
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    return o
end
