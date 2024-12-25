StoryTables = StoryTables or {}

StoryTables.addItemToClutterTable = function(arrayList, item)
    arrayList:add(item)
    if  type(item) ~= "string" then
        print("item is not a string: " .. tostring(item))
    elseif not  ScriptManager.instance:FindItem(item) then
        print("item script does not exists: " .. tostring(item))
    elseif getSandboxOptions():getOptionByName("RemoveStoryLoot"):getValue() == true and ItemPickerJava.getLootModifier(item) == 0 then
        print("item is blacklisted: " .. tostring(item))
    else
        arrayList:add(item)
    end
end

StoryTables.addClutterTableToArray = function(arrayList, table)
    if not table then
        print("Missing table for addClutterTableToArray")
        return
    end
    if not arrayList then
        print("Missing arrayList for addClutterTableToArray")
        return
    end
    for i = 1, #table + 1 do
        if (table[i] ~= nil) then
            local item = table[i]
            if item then StoryTables.addItemToClutterTable(arrayList, item) end
        end
    end
end

StoryTables.initClutterArray = function(arrayList, table)
    if not table then
        print("Missing table for initClutterArray")
        return
    end
    if not arrayList then
        print("Missing arrayList for initClutterArray")
        return
    end
    arrayList:clear()
    StoryTables.addClutterTableToArray(arrayList, table)
end