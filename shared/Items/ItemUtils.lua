
ItemUtils = {};

print("ItemUtils")

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