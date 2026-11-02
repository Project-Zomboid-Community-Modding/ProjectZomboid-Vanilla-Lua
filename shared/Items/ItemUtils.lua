
ItemUtils = {};

ItemUtils.getContainers = function(character)
    if not character then return end

    local containerList = ArrayList.new();
    containerList:add(character:getInventory());
    containers = character:getInventory():getItemsFromCategory("Container");
    for j = 0, containers:size() - 1 do
        containerList:add(containers:get(j):getInventory());
    end;
    return containerList;
end

ItemUtils.checkWeapon = function(chr)
    local weapon = chr:getPrimaryHandItem()
    if weapon ~= nil and weapon:getCondition() > 0 then
        return
    end
    chr:removeFromHands(weapon)
    weapon = chr:getInventory():getBestWeapon(chr:getDescriptor())
    if weapon ~= nil and weapon ~= chr:getPrimaryHandItem() and weapon:getCondition() > 0 then
        chr:setPrimaryHandItem(weapon)
        if weapon:isTwoHandWeapon() and not chr:getSecondaryHandItem() then
            chr:setSecondaryHandItem(weapon)
        end
    end
    if isServer() then
        sendServerCommand(chr, 'ui', 'dirtyUI', { })
    else
        ISInventoryPage.dirtyUI()
    end
end
