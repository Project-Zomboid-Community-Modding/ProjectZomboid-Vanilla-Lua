--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/InventoryWindow/ISInventoryWindowControlHandler"

ISInventoryWindowControlHandler_TransferSameType = ISInventoryWindowControlHandler:derive("ISInventoryWindowControlHandler_TransferSameType")
local Handler = ISInventoryWindowControlHandler_TransferSameType

function Handler:shouldBeVisible()
    if getCore():getGameMode() == "Tutorial" then return false end
    local lootWindow = getPlayerLoot(self.playerNum)
    local lootContainer = lootWindow.inventoryPane.inventory
    if lootContainer:isEmpty() then return false end
    return not self.container:isEmpty()
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("IGUI_invpage_Transfer_SameType"))
    self.control:setOnMouseOverFunction(self.onMouseOverButton)
    self.control:setOnMouseOutFunction(self.onMouseOutButton)
    return self.control
end

function Handler:perform()
    if isGamePaused() then return end
    local itemsToTransfer = self:getItemsToTransfer()
    if #itemsToTransfer == 0 then return end
    local lootWindow = getPlayerLoot(self.playerNum)
    local lootContainer = lootWindow.inventoryPane.inventory
    self.inventoryWindow.inventoryPane:transferItemsByWeight(itemsToTransfer, lootContainer)
end

function Handler:getItemsTable(container)
    local result = {}
    local items = container:getItems()
    for i=1,items:size() do
        local item = items:get(i-1)
        local type = item:getFullType()
        result[type] = result[type] or {}
        table.insert(result[type], item)
    end
    return result
end

function Handler:getItemsToTransfer()
    local lootWindow = getPlayerLoot(self.playerNum)
    local lootContainer = lootWindow.inventoryPane.inventory
    local itemMapSelf = self:getItemsTable(self.container)
    local itemMapLoot = self:getItemsTable(lootContainer)
    local itemsToTransferList = {}
    local itemsToTransferMap = {}
    for type,items in pairs(itemMapLoot) do
        if itemMapSelf[type] then
            for _,item in ipairs(itemMapSelf[type]) do
                if not item:isFavorite() and not item:isEquipped() then
                    table.insert(itemsToTransferList, item)
                    itemsToTransferMap[item] = true
                end
            end
        end
    end
    return itemsToTransferList, itemsToTransferMap
end

function Handler:onMouseOverButton(button, x, y)
    if not self.isMouseOver or self:wasInventoryUpdated() or self:wasLootUpdated() then
        self.isMouseOver = true
        local itemsToTransferList, itemsToTransferMap = self:getItemsToTransfer()
        self.itemsToTransferMap = itemsToTransferMap
    end
    self.inventoryWindow.inventoryPane:setItemsToHighlight(self.control, self.itemsToTransferMap)
end

function Handler:onMouseOutButton(button, dx, dy)
    if self.isMouseOver then
        self.inventoryWindow.inventoryPane:setItemsToHighlight(self.control, nil)
        self.isMouseOver = false
    end
end

function Handler:wasInventoryUpdated()
    if self.inventoryWindow.inventoryPane.refreshContainerCount ~= self.inventoryContainerCount then
        self.inventoryContainerCount = self.inventoryWindow.inventoryPane.refreshContainerCount or 0
        return true
    end
    return false
end

function Handler:wasLootUpdated()
    local lootWindow = getPlayerLoot(self.playerNum)
    if lootWindow.inventoryPane.refreshContainerCount ~= self.lootContainerCount then
        self.lootContainerCount = lootWindow.inventoryPane.refreshContainerCount or 0
        return true
    end
    return false
end

function Handler:new()
    local o = ISInventoryWindowControlHandler.new(self)
    return o
end
