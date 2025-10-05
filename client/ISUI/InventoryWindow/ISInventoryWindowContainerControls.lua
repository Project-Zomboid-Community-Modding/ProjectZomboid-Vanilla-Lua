--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISPanelJoypad"

require "ISUI/InventoryWindow/Handlers/TransferAll"
require "ISUI/InventoryWindow/Handlers/TransferSameType"

ISInventoryWindowContainerControls = ISPanelJoypad:derive("ISInventoryWindowContainerControls")

ISInventoryWindowContainerControls_HandlerList = ISInventoryWindowContainerControls_HandlerList or {}
ISInventoryWindowContainerControls_HandlerSet = ISInventoryWindowContainerControls_HandlerSet or {}

function ISInventoryWindowContainerControls.AddHandler(handlerClass)
    if ISInventoryWindowContainerControls_HandlerSet[handlerClass.Type] == handlerClass then return end
    ISInventoryWindowContainerControls_HandlerSet[handlerClass] = handlerClass
    local index = -1
    for index1,handlerClass1 in ipairs(ISInventoryWindowContainerControls_HandlerList) do
        if handlerClass.Type == handlerClass1.Type then
            index = index1
            break
        end
    end
    if index == -1 then
        table.insert(ISInventoryWindowContainerControls_HandlerList, handlerClass)
    else
        ISInventoryWindowContainerControls_HandlerList[index] = handlerClass
    end
end

-- These could go into the individual handler files, but the order would depend on file name.
ISInventoryWindowContainerControls.AddHandler(ISInventoryWindowControlHandler_TransferAll)
ISInventoryWindowContainerControls.AddHandler(ISInventoryWindowControlHandler_TransferSameType)

-----

function ISInventoryWindowContainerControls:createChildren()
end

function ISInventoryWindowContainerControls:checkHandler(handlerClass, container)
    local handler = self.handlers[handlerClass]
    if handler == nil then
        handler = handlerClass:new()
        self.handlers[handlerClass] = handler
    end
    handler.inventoryWindow = self.inventoryWindow
    handler.playerNum = self.inventoryWindow.player
    handler.playerObj = getSpecificPlayer(handler.playerNum)
    handler.container = container
    return handler
end

function ISInventoryWindowContainerControls:arrange()
    local playerObj = getSpecificPlayer(self.inventoryWindow.player)
    local container = self:getDisplayedContainer()
    local lootWindow = getPlayerLoot(self.inventoryWindow.player)
    if not lootWindow or not lootWindow.inventoryPane.inventory then
        container = nil -- can be nil during ui creation
    end
    for _,control in ipairs(self.controls) do
        control:setVisible(false)
        self:removeChild(control)
    end
    table.wipe(self.controls)
    if container ~= nil then -- it's temporarily nil before the first update
        local x,y = 1,1
        local rowHgt = 0
        for _,handlerClass in ipairs(ISInventoryWindowContainerControls_HandlerList) do
            local handler = self:checkHandler(handlerClass, container)
            if handler:shouldBeVisible() then
                local control = handler:getControl()
                if (x > 0) and (x + control:getWidth() > self.width) then
                    x = 1
                    y = y + rowHgt + 1
                    rowHgt = 0
                end
                control:setX(x)
                control:setY(y)
                control:setVisible(true)
                self:addChild(control)
                table.insert(self.controls, control)
                x = control:getRight() + 10
                rowHgt = math.max(rowHgt, control:getHeight())
            end
        end
        self:setHeight(y + rowHgt + 1)
    end
    if #self.controls > 0 then
        self:setX(0)
        self:setY(self.inventoryWindow.resizeWidget.y - self.height)
        self:setWidth(self.inventoryWindow:getWidth())
        self:setVisible(true)
        self:fixMouseOverButton()
    else
        self:setVisible(false)
        self:setHeight(0)
    end
end

function ISInventoryWindowContainerControls:getDisplayedContainer()
    local container = self.inventoryWindow.inventoryPane.inventory
    for _,cb in ipairs(self.inventoryWindow.backpacks) do
        if cb.inventory == container then
            return container
        end
    end
    return nil
end

function ISInventoryWindowContainerControls:handleJoypadContextMenu(context)
    local playerObj = getSpecificPlayer(self.inventoryWindow.player)
    local container = self:getDisplayedContainer()
    for _,handlerClass in ipairs(ISInventoryWindowContainerControls_HandlerList) do
        local handler = self:checkHandler(handlerClass, object, container)
        if handler:shouldBeVisible() then
            handler:handleJoypadContextMenu(context)
        end
    end
end

function ISInventoryWindowContainerControls:fixMouseOverButton()
    for _,control in ipairs(self.controls) do
        if control:isMouseOver() then
            control:onMouseMove(0, 0)
        end
    end
end

function ISInventoryWindowContainerControls:new(inventoryWindow)
    local o = ISPanelJoypad.new(self, 0, 0, 200, 20)
    o:noBackground()
    o.inventoryWindow = inventoryWindow
    o.handlers = {}
    o.controls = {}
    return o
end
