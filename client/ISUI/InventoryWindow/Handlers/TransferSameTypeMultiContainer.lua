require "ISUI/InventoryWindow/ISInventoryWindowControlHandler"

ISInventoryWindowControlHandler_TransferSameTypeMultiContainer = ISInventoryWindowControlHandler:derive("ISInventoryWindowControlHandler_TransferSameTypeMultiContainer")
local Handler = ISInventoryWindowControlHandler_TransferSameTypeMultiContainer

function Handler:shouldBeVisible()
    if getCore():isTutorial() then return false end
    return true -- can always transfer to the floor
end

function Handler:getControl()
    self.control = self:getImageButtonControl("media/ui/inventoryPanes/TransferSameTypeMultiContainer.png")
    self.control:setTooltip(getText("IGUI_invpage_TransferSameTypeMultiContainer_tt"))
    self.control:setOnMouseOverFunction(self.onMouseOverButton)
    self.control:setOnMouseOutFunction(self.onMouseOutButton)
    return self.control
end

function Handler:perform()
    if isGamePaused() then return end
    local itemsToTransferList,itemsToTransferMap = self:getItemsToTransfer()
    if #itemsToTransferList == 0 then return end
    local lootWindow = getPlayerLoot(self.playerNum)
    local itemMapSelf = self:getItemsTable(self.container)
    for _,button in ipairs(lootWindow.backpacks) do
        local lootContainer = button.inventory
        local itemsToTransferList1 = self:consumeItems(lootContainer, itemMapSelf)
        if #itemsToTransferList1 > 0 then
            self.inventoryWindow.inventoryPane:transferItemsByWeight(itemsToTransferList1, lootContainer)
        end
    end
end

function Handler:consumeItems(lootContainer, allItemsMap)
    local itemMapLoot = self:getItemsTable(lootContainer)
    local itemsToTransferList = {}
    for type,items in pairs(itemMapLoot) do
        if allItemsMap[type] then
            for _,item in ipairs(allItemsMap[type]) do
                if not item:isFavorite() and not item:isEquipped() then
                    table.insert(itemsToTransferList, item)
                end
            end
        end
    end
    local lootWindow = getPlayerLoot(self.playerNum)
    lootWindow.inventoryPane:sortItemsByTypeAndWeight(itemsToTransferList)
    local totalWeight = 0.0
    local itemsToTransferList1 = {}
    for _,item in ipairs(itemsToTransferList) do
        local weight = item:getUnequippedWeight()
        if lootContainer:hasRoomFor(self.playerObj, totalWeight + weight) then
            table.insert(itemsToTransferList1, item)
            local sourceItemList = allItemsMap[item:getFullType()]
            local index = luautils.indexOf(sourceItemList, item)
            table.remove(sourceItemList, index)
            totalWeight = totalWeight + weight
        else
            break
        end
    end
    return itemsToTransferList1
end

function Handler:getItemsTable(container)
    local result = {}
    local items = container:getItems()
    for i=1,items:size() do
        local item = items:get(i-1)
        local type = item:getFullType()
        result[type] = result[type] or {}
        table.insert(result[type], item)
        if item:getClothingItemExtra() ~= nil then
            local typeList = item:getClothingItemExtra()
            for j=1,typeList:size() do
                type = moduleDotType(item:getModule(), item:getClothingItemExtra():get(j-1))
                result[type] = result[type] or {}
                table.insert(result[type], item)
            end
        end
    end
    return result
end

function Handler:getItemsToTransfer()
    local lootWindow = getPlayerLoot(self.playerNum)
    local itemMapSelf = self:getItemsTable(self.container)
    local itemsToTransferList = {}
    local itemsToTransferMap = {}
    for _,button in ipairs(lootWindow.backpacks) do
        local lootContainer = button.inventory
        local itemMapLoot = self:getItemsTable(lootContainer)
        for type,items in pairs(itemMapLoot) do
            if itemMapSelf[type] then
                for _,item in ipairs(itemMapSelf[type]) do
                    if not item:isFavorite() and not item:isEquipped() then
                        table.insert(itemsToTransferList, item)
                        itemsToTransferMap[item] = true
                    end
                end
                itemMapSelf[type] = nil
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
