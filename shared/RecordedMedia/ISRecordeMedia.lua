--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
 NOTE: A temporary solution, when devices update comes things *may* change drastically.
--]]

RecMedia = RecMedia or {};

ISRecordedMedia = {};

-- gets passed instance of RecordedMedia (java) as parameter
ISRecordedMedia.init = function(_rc)
    local sorted = {}
    for k,v in pairs(RecMedia) do
        table.insert(sorted, { id = k, data = v })
    end
    table.sort(sorted, function(a, b) return not string.sort(a.id, b.id) end)
    for _,sv in ipairs(sorted) do
        local k = sv.id
        local v = sv.data
        -- register(String category, String id, String itemDisplayName, int spawning[0-2]) returns MediaData
        local data = _rc:register(v.category, k, v.itemDisplayName, v.spawning and v.spawning or 0);

        -- set optional properties:
        data:setTitle(v.title);
        data:setSubtitle(v.subtitle);
        data:setAuthor(v.author);
        data:setExtra(v.extra);

        -- add lines:
        for i,j in ipairs(v.lines) do
            data:addLine(j.text, j.r, j.g, j.b, j.codes);
        end
    end
end

Events.OnInitRecordedMedia.Add(ISRecordedMedia.init);
