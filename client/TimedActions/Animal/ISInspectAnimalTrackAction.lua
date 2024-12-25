--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 22/06/2023
-- Time: 09:18
-- To change this template use File | Settings | File Templates.
--

--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISInspectAnimalTrackAction = ISBaseTimedAction:derive("ISInspectAnimalTrackAction");

function ISInspectAnimalTrackAction:isValid()
    if instanceof(self.track, "IsoAnimalTrack") then -- a track can be an isoanimaltrack or an inventoryitem
        return self.character:getSquare():DistTo(self.track:getSquare()) < 3;
    elseif self.track:getWorldItem() and self.track:getWorldItem():getSquare() then
        return self.character:getSquare():DistTo(self.track:getWorldItem():getSquare()) < 3;
    else
        return true;
    end
end

function ISInspectAnimalTrackAction:waitToStart()
    if instanceof(self.track, "IsoAnimalTrack") then
        self.character:facePosition(self.track:getSquare():getX(), self.track:getSquare():getY())
    elseif self.track:getWorldItem() and self.track:getWorldItem():getSquare() then
        self.character:facePosition(self.track:getWorldItem():getSquare():getX(), self.track:getWorldItem():getSquare():getY())
    end
    return self.character:shouldBeTurning()
end

function ISInspectAnimalTrackAction:update()
    if instanceof(self.track, "IsoAnimalTrack") then
        self.character:facePosition(self.track:getSquare():getX(), self.track:getSquare():getY())
    elseif self.track:getWorldItem() and self.track:getWorldItem():getSquare() then
        self.character:facePosition(self.track:getWorldItem():getSquare():getX(), self.track:getWorldItem():getSquare():getY())
    end
end

function ISInspectAnimalTrackAction:start()
    self:setActionAnim("Loot")
    self.character:reportEvent("EventLootItem")
end

function ISInspectAnimalTrackAction:stop()
--    self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISInspectAnimalTrackAction:perform()
    ISBaseTimedAction.perform(self);

    local ui = ISAnimalTracksUI:new(100, 100, 300, 200, self.track, self.character)
    ui:initialise();
    ui:addToUIManager();
end

function ISInspectAnimalTrackAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 100 - (self.character:getPerkLevel(Perks.Tracking) * 1.5)
end

function ISInspectAnimalTrackAction:new(character, track)
    local o = ISBaseTimedAction.new(self, character)
    o.track = track;
    o.maxTime = o:getDuration()
    return o;
end
