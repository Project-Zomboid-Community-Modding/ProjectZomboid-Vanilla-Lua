-- LootLog by Blair/Algol with some feedback from Fenris_Wolf
-- LootLog is activated, all loot that is spawned as normal container loot will be logged to the console.
-- this does not include the items that are spawned for randomized stories, they are spawned by a completely different system.

local insert, concat, format, print = table.insert, table.concat, string.format, print

local function  LootLog(roomName, containerType, itemContainer)
	if not ISLootLog then return end
	if not ISLootLog.cheat then return end
    local list = {}
    local items = itemContainer:getItems()
    if items:size() > 0 then
        for i=0,items:size()-1 do
            insert(list, items:get(i):getFullType())
        end
    end

    local parent, square = itemContainer:getParent(), nil
    if parent then square = parent:getSquare() end
	if containerType == nil then containerType = "nil" end
	if roomName == nil then roomName = "nil" end
    local msg = format("spawned in container type %s in room type %s", containerType, roomName)
    if square then 
        msg = format("%s at x:%s, y:%s, z:%s", msg, square:getX(), square:getY(), square:getX())
    end
    if #list > 0 then
        print(format("Loot %s and consists of:", msg))
        print(concat(list, ", ") .. ".")
    else
        print(format("No loot %s.", msg))
    end
end

Events.OnFillContainer.Add ( LootLog )