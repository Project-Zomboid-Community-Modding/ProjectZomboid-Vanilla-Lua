--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISHutchCleanNest = ISBaseTimedAction:derive("ISHutchCleanNest");

function ISHutchCleanNest:isValid()
    return self.hutch ~= nil and self.hutch:getNestBoxDirt() > 0;
end

function ISHutchCleanNest:waitToStart()
    self.character:faceThisObject(self.tree)
    return self.character:shouldBeTurning()
end

function ISHutchCleanNest:update()
    self.character:faceThisObject(self.hutch)
    if not isClient() then
        self.timer = self.timer + getGameTime():getMultiplier();
        if math.floor(self.timer / self.timePerDirt) > self.lastTimer then
            self.lastTimer = math.floor(self.timer / self.timePerDirt);
            self.hutch:setNestBoxDirt(self.hutch:getNestBoxDirt() - 1)
        end
    end
end

function ISHutchCleanNest:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Low")
    self.character:reportEvent("EventLootItem")
end

function ISHutchCleanNest:stop()
    ISBaseTimedAction.stop(self);
end

function ISHutchCleanNest:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISHutchCleanNest:serverStart()
    local period = self.timePerDirt * 20
    emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISHutchCleanNest:animEvent(event, parameter)
    if isServer() then
        if event == "update" then
            print("ISHutchCleanNest:animEvent "..tostring(self.hutch:getNestBoxDirt()))
            self.hutch:setNestBoxDirt(self.hutch:getNestBoxDirt() - 1)
            self.hutch:sync()
        end
    end
end

function ISHutchCleanNest:complete()
    self.hutch:setNestBoxDirt(0)
    self.hutch:sync()
    return true
end

function ISHutchCleanNest:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return (self.hutch:getNestBoxDirt() * self.timePerDirt) + 5
end

function ISHutchCleanNest:new(character, hutch, bleach)
    local o = ISBaseTimedAction.new(self, character);
    o.hutch = hutch;
    o.bleach = bleach;
    o.timer = 0;
    o.lastTimer = 0;
    o.timePerDirt = 10;
    o.maxTime = o:getDuration()
    return o;
end
