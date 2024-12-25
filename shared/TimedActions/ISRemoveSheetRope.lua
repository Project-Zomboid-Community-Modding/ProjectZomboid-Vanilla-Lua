require "TimedActions/ISBaseTimedAction"

ISRemoveSheetRope = ISBaseTimedAction:derive("ISRemoveSheetRope");

function ISRemoveSheetRope:isValid()
    return self.window and self.window:haveSheetRope()
end

function ISRemoveSheetRope:waitToStart()
    self.character:faceThisObject(self.window)
    return self.character:shouldBeTurning()
end

function ISRemoveSheetRope:update()
    self.character:faceThisObject(self.window)

    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISRemoveSheetRope:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Mid")
end

function ISRemoveSheetRope:stop()
    ISBaseTimedAction.stop(self);
end

function ISRemoveSheetRope:perform()

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISRemoveSheetRope:complete()
    local o = self.window
    if instanceof(o, 'IsoWindow') or instanceof(o, 'IsoThumpable') or instanceof(o, 'IsoWindowFrame') then
        o:removeSheetRope(self.character)
    elseif instanceof(o, 'IsoObject') then
        if o:getSquare():getProperties():Is(IsoFlagType.HoppableN) or o:getSquare():getProperties():Is(IsoFlagType.HoppableW) then
            o:removeSheetRope(self.character)
        end
    else
    end

    return true;
end

function ISRemoveSheetRope:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 20
end

function ISRemoveSheetRope:new(character, window)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration();
    o.window = window;
    return o;
end
