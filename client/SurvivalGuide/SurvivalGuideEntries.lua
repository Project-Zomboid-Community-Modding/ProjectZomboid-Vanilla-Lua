require "Util/LuaList"

SurvivalGuideEntries = {}
SurvivalGuideEntries.useJoypad = false;
SurvivalGuideEntries.list = LuaList:new();
SurvivalGuideEntries.joypad = LuaList:new();

SurvivalGuideEntries.addSurvivalGuideEntry = function(index)
    local entry = {
        title = getText("SurvivalGuide_entrie"..index.."title"),
        text = getText("SurvivalGuide_entrie"..index.."txt"),
        moreInfo = getText("SurvivalGuide_entrie"..index.."moreinfo")
    };
    SurvivalGuideEntries.list:add(entry);

    entry = {
        title = getText("SurvivalGuide_Joypad_entrie"..index.."title"),
        text = getText("SurvivalGuide_Joypad_entrie"..index.."txt"),
        moreInfo = getText("SurvivalGuide_Joypad_entrie"..index.."moreinfo")
    };
    SurvivalGuideEntries.joypad:add(entry);
end

SurvivalGuideEntries.getEntry = function(num)
    if SurvivalGuideEntries.useJoypad then
        return SurvivalGuideEntries.joypad:get(num);
    end
    return SurvivalGuideEntries.list:get(num);
end

SurvivalGuideEntries.getEntryCount = function()
    return SurvivalGuideEntries.list:size();
end

for i = 1, 14 do --add new entries by changing this number
    SurvivalGuideEntries.addSurvivalGuideEntry(i);
end


-- We don't it once it's boot 'cause we need some translation
SurvivalGuideEntries.addEntry11 = function()
--    SurvivalGuideEntries.addSurvivalGuideEntry(getText("SurvivalGuide_entrie11title"),
--        getText("SurvivalGuide_entrie11txt", getKeyName(getCore():getKey("Crouch")),getKeyName(getCore():getKey("Sprint")),getKeyName(getCore():getKey("Run"))),
--        getText("SurvivalGuide_entrie11moreinfo", getKeyName(getCore():getKey("Sprint")), getKeyName(getCore():getKey("Toggle Clothing Protection Panel"))));
end
