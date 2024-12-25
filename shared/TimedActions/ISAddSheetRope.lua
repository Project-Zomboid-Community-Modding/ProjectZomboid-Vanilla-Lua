require "TimedActions/ISBaseTimedAction"

ISAddSheetRope = ISBaseTimedAction:derive("ISAddSheetRope");

function ISAddSheetRope:isValid()
    local inv = self.character:getInventory()
    local numRequired = self.window:countAddSheetRope()
    return self.window:canAddSheetRope() and (inv:getNumberOfItem("SheetRope") >= numRequired or inv:getNumberOfItem("Rope") >= numRequired)
end

function ISAddSheetRope:waitToStart()
    self.character:faceThisObject(self.window)
    return self.character:shouldBeTurning()
end

function ISAddSheetRope:update()
    self.character:faceThisObject(self.window)
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISAddSheetRope:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function ISAddSheetRope:stop()
    ISBaseTimedAction.stop(self);
end

function ISAddSheetRope:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISAddSheetRope:complete()
    local numRequired
    numRequired = self.window:countAddSheetRope()
    local inv = self.character:getInventory()
    local numSheetRope = inv:getNumberOfItem("Base.SheetRope")
    local numRope = inv:getNumberOfItem("Base.Rope")
    local itemType
    if self.sheetRope then
        itemType = (numSheetRope >= numRequired) and "SheetRope" or "Rope"
    else
        itemType = (numRope >= numRequired) and "Rope" or "SheetRope"
    end

    -- Code from the function Commands.object.addSheetRope
    local o = self.window
    if instanceof(o, 'IsoWindow') or instanceof(o, 'IsoThumpable') or instanceof(o, 'IsoWindowFrame') then
        o:addSheetRope(self.character, itemType or "SheetRope")
    elseif instanceof(o, 'IsoObject') then
        if o:getSquare():getProperties():Is(IsoFlagType.HoppableN) or o:getSquare():getProperties():Is(IsoFlagType.HoppableW) then
            o:addSheetRope(self.character, itemType or "SheetRope")
        end
    else
        log(DebugType.Action, 'Error: not a window, window-frame, or thumpable'.. tostring(o))
    end

    buildUtil.setHaveConstruction(o:getSquare(), true);

    return true;
end

function ISAddSheetRope:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 20
end

function ISAddSheetRope:new(character, window, sheetRope)
    local o = ISBaseTimedAction.new(self, character)
    o.maxTime = o:getDuration();
    o.window = window;
    o.sheetRope = sheetRope;
    return o;
end
