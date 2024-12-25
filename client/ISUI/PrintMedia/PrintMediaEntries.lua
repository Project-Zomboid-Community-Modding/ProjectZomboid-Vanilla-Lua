require "Util/LuaList"

PrintMediaEntries = {}
PrintMediaEntries.useJoypad = false;
PrintMediaEntries.list = LuaList:new();

PrintMediaEntries.addPrintMediaEntry = function(index, type)
    local entry = {
        title = getText("Print_Media_"..index.."_title"),
        info = getText("Print_Media_"..index.."_info"),
        index = index,
        type = type or nil,
    };
    PrintMediaEntries.list:add(entry);
end

PrintMediaEntries.getEntry = function(num)
    return PrintMediaEntries.list:get(num);
end

PrintMediaEntries.getEntryCount = function()
    return PrintMediaEntries.list:size();
end

for i = 1, #PrintMediaDefinitions.Newspapers do
    local paper = PrintMediaDefinitions.Newspapers[i]

    for j = 1, #PrintMediaDefinitions.NewspaperDetails[paper].issues do
        PrintMediaEntries.addPrintMediaEntry(paper .. "_" .. PrintMediaDefinitions.NewspaperDetails[paper].issues[j], "Base.Newspaper_Recent");
    end

end

for i = 1, #PrintMediaDefinitions.Brochures do
    PrintMediaEntries.addPrintMediaEntry(PrintMediaDefinitions.Brochures[i], "Base.Brochure")
end

for i = 1, #PrintMediaDefinitions.Fliers do
    PrintMediaEntries.addPrintMediaEntry(PrintMediaDefinitions.Fliers[i], "Base.Flier")
end