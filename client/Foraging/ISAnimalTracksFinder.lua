ISAnimalTracksFinder = {};
ISAnimalTracksFinder.tracks = {};
ISAnimalTracksFinder.tick = 0;

ISAnimalTracksFinder.getAnimalTracks = function (chr, track)
    if not track then
        return
    end
    if track:isItem() then
        local item = track:getItem()
        ISAnimalTracksFinder:addItemIcon(item, chr);
    else
        local isoTracks = track:getAllIsoTracks();
        for i=0,isoTracks:size()-1 do
            local isoTrack = isoTracks:get(i);
            if isoTrack and not ISAnimalTracksFinder.tracks[isoTrack] then
                table.insert(ISAnimalTracksFinder.tracks, isoTrack);
            end
        end
    end
end

-- get every near tracks depending on our tracking level and check if we can find them
-- if we find them, we add it to the world (tracks can be either an inventoryItem or a tile)
function ISAnimalTracksFinder:update(chr)
    self:updateTracks(chr);
    if ISAnimalTracksFinder.tick > 0 then
        ISAnimalTracksFinder.tick = ISAnimalTracksFinder.tick - getGameTime():getMultiplier();
        return;
    end
    -- we do this every X ticks to avoid too much call
    ISAnimalTracksFinder.tick = 20;
    local tracks = getAndFindNearestTracks(chr);
    if not isClient() then
        for i=0,tracks:size()-1 do
            ISAnimalTracksFinder.getAnimalTracks(chr, tracks:get(i))
        end
    end
end

function ISAnimalTracksFinder:canFindTrack(track, chr)
    return track:canFindTrack(chr);
end

-- make the tile tracks glow so it's either to find them
function ISAnimalTracksFinder:updateTracks(chr)
    for i,v in ipairs(ISAnimalTracksFinder.tracks) do
        v:glow(chr);
    end
end

-- when we're done checking for tracks we stop the glow
function ISAnimalTracksFinder:clearTracks(chr)
--    print("clear ctracks")
    for i,v in ipairs(ISAnimalTracksFinder.tracks) do
        v:stopGlow(chr);
    end
    ISAnimalTracksFinder.tracks = {};
end

ISAnimalTracksFinder.isTrack = function(worldObject)
    return worldObject:getItem():getAnimalTracks() ~= nil;
end

-- when we add a track as an inventoryItem (things that can be picked up like dung for ex.) we add a ISBaseIcon to it, so it's like when you find a foraged item
function ISAnimalTracksFinder:addItemIcon(track, chr)
    if not track then
        return;
    end
    local icon = {
        id          = track,
        x           = track:getWorldItem():getSquare():getX() + 0.5,
        y           = track:getWorldItem():getSquare():getY() + 0.5,
        z		    = track:getWorldItem():getSquare():getZ(),
        itemObj     = track,
        itemType    = track:getFullType(),
        isBonusIcon = false,
    };

    local manager = ISSearchManager.getManager(chr);

    local icon = ISWorldItemIconTrack:new(manager, icon, chr);
end

Events.OnAnimalTracks.Add(ISAnimalTracksFinder.getAnimalTracks);
