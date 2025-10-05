--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/InventoryWindow/ISInventoryWindowControlHandler"

ISInventoryWindowControlHandler_TransferAll = ISInventoryWindowControlHandler:derive("ISInventoryWindowControlHandler_TransferAll")
local Handler = ISInventoryWindowControlHandler_TransferAll

function Handler:shouldBeVisible()
    if getCore():getGameMode() == "Tutorial" then return false end
    return not self.container:isEmpty()
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("IGUI_invpage_Transfer_all"))
    return self.control
end

function Handler:perform()
    if isGamePaused() then return end
	ISInventoryPage.transferAll(self.inventoryWindow)
end

function Handler:new()
    local o = ISInventoryWindowControlHandler.new(self)
    return o
end
