--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_VehicleCloseTrunk = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_VehicleCloseTrunk")
local Handler = ISLootWindowObjectControlHandler_VehicleCloseTrunk

function Handler:shouldBeVisible()
    if getCore():getGameMode() == "Tutorial" then return false end
    if not instanceof(self.object, "BaseVehicle") then return false end
    local doorPart = self.object:getUseablePart(self.playerObj)
    if doorPart and doorPart:getDoor() and doorPart:getInventoryItem() then
        return doorPart:getId() == "TrunkDoor" or doorPart:getId() == "DoorRear"
    end
    return false
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("IGUI_CloseTrunk"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("IGUI_CloseTrunk"))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
    if isGamePaused() then return end
    local doorPart = self.object:getUseablePart(self.playerObj)
	ISTimedActionQueue.add(ISCloseVehicleDoor:new(self.playerObj, self.object, doorPart))
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
