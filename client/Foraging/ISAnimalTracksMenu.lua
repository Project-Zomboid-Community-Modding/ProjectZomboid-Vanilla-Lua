--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 30/05/2023
-- Time: 08:58
-- To change this template use File | Settings | File Templates.
--


--/ CONTEXT MENU WHEN YOU RIGHT CLICK ON A FOUND TRACK FROM FORAGING --/
ISAnimalTracksMenu = {};

ISAnimalTracksMenu.doContextMenu = function(context, trackItem, chr)
    context:addOption(getText("ContextMenu_InspectTrack"), trackItem, ISAnimalTracksMenu.inspect, chr);
    context:addOption(getText("ContextMenu_Grab"), trackItem, ISAnimalTracksMenu.onGrab, chr);
end

ISAnimalTracksMenu.inspect = function(track, chr)
    if luautils.walkAdj(chr, track:getWorldItem():getSquare()) then
        ISTimedActionQueue.add(ISInspectAnimalTrackAction:new(chr, track));
    end
end

ISAnimalTracksMenu.handleIsoTracks = function(context, track, chr)
    context:addOption(getText("ContextMenu_InspectTrack"), track, ISAnimalTracksMenu.inspectIsoTrack, chr);

end

ISAnimalTracksMenu.inspectIsoTrack = function(track, chr)
    if luautils.walkAdj(chr, track:getSquare()) then
        ISTimedActionQueue.add(ISInspectAnimalTrackAction:new(chr, track));
    end
end

ISAnimalTracksMenu.onGrab = function(track, chr)

end

