--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_MannequinWearAll = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_MannequinWearAll")
local Handler = ISLootWindowObjectControlHandler_MannequinWearAll

function Handler:shouldBeVisible()
    if not instanceof(self.object, "IsoMannequin") then return false end
    return self.object:getWornItems():size()>0 and self.playerObj:getWornItems():size()>0
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_WearAll"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("ContextMenu_WearAll"))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
	if isGamePaused() then return end
	local mannequin = self.object
	if not mannequin then return end
	local playerObj = self.playerObj
	if playerObj:getVehicle() then return end
	if luautils.walkAdj(playerObj, mannequin:getSquare()) then
        for i=1,mannequin:getWornItems():size() do
            local item = mannequin:getWornItems():get(i-1):getItem()
            if item and item:getDisplayName() ~= null then
                ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
                ISTimedActionQueue.add(ISWearClothing:new(playerObj, item, 50))
            end
        end
	end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
