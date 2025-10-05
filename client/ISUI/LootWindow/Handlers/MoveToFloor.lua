--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_MoveToFloor = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_MoveToFloor")
local Handler = ISLootWindowObjectControlHandler_MoveToFloor

function Handler:shouldBeVisible()
    return not self.container:isEmpty()
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_MoveToFloor"))
    return self.control
end

function Handler:perform()
    if isGamePaused() then return end
    local items = {}
    local itemArrayList = self.container:getItems()
    for i=1,itemArrayList:size() do
        table.insert(items, itemArrayList:get(i-1))
    end
    -- TODO: sort by lowest to highest weight
	ISInventoryPaneContextMenu.onMoveItemsTo(items, ISInventoryPage.floorContainer[self.playerNum+1], self.playerNum)
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    return o
end
