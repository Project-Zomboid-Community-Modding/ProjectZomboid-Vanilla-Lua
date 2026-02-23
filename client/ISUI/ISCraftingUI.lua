ISCraftingUI = {}

function ISCraftingUI.ReturnItemsToOriginalContainer(playerObj, items)
    for _,item in ipairs(items) do
        ISCraftingUI.ReturnItemToContainer(playerObj, item, item:getContainer())
    end
end

function ISCraftingUI.ReturnItemToOriginalContainer(playerObj, item)
    ISCraftingUI.ReturnItemToContainer(playerObj, item, item:getContainer())
end

function ISCraftingUI.ReturnItemToContainer(playerObj, item, cont)
    -- as per Binky's input, disorganized characters don't automatically put stuff back
    if playerObj:hasTrait(CharacterTrait.DISORGANIZED) or not item then return end
    if not instanceof(item, "InventoryItem") then return end

    if cont ~= playerObj:getInventory() then
        local action = ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, playerObj:getInventory(), cont, nil)
        action:setAllowMissingItems(true)
        ISTimedActionQueue.add(action)
    end
end
