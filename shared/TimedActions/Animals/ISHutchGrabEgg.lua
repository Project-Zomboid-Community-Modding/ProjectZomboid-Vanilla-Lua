--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISHutchGrabEgg = ISBaseTimedAction:derive("ISHutchGrabEgg");

function ISHutchGrabEgg:isValid()
    return self.nestbox ~= nil and self.nestbox:getEggsNb() > 0 and self.hutch ~= nil;
end

function ISHutchGrabEgg:waitToStart()
    self.character:faceThisObject(self.tree)
    return self.character:shouldBeTurning()
end

function ISHutchGrabEgg:update()
    self.character:faceThisObject(self.hutch)

    if not isClient() then
        self.timer = self.timer + getGameTime():getMultiplier();
        if math.floor(self.timer / self.timePerEgg) > self.lastTimer then
            self.lastTimer = math.floor(self.timer / self.timePerEgg);
            local egg = self.nestbox:removeEgg(0)
            addXp(self.character, Perks.Husbandry, 1);
            self.character:getInventory():AddItem(egg)
        end
    end
end

function ISHutchGrabEgg:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Low")
    self.character:reportEvent("EventLootItem")
end

function ISHutchGrabEgg:stop()
    ISBaseTimedAction.stop(self);
end

function ISHutchGrabEgg:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISHutchGrabEgg:serverStart()
    local period = self.timePerEgg * 20
    emulateAnimEvent(self.netAction, period, "update", nil)
end

function ISHutchGrabEgg:animEvent(event, parameter)
    if isServer() then
        if event == "update" then
            local egg = self.nestbox:removeEgg(0)
            self.hutch:sync()
            addXp(self.character, Perks.Husbandry, 1);
            self.character:getInventory():AddItem(egg)
            sendAddItemToContainer(self.character:getInventory(), egg)
        end
    end
end

function ISHutchGrabEgg:complete()
    return true
end

function ISHutchGrabEgg:getDuration()
    if self.character:isTimedActionInstant() then
        self.timePerEgg = 1;
    elseif isServer() then
        return -1;
    end
    return (self.nestbox:getEggsNb() * self.timePerEgg) + 5
end

function ISHutchGrabEgg:new(character, nestbox, hutch)
    local o = ISBaseTimedAction.new(self, character);
    if isServer() then
        o.nestbox = hutch:getNestBox(nestbox)
    else
        o.nestbox = nestbox;
    end
    o.hutch = hutch;
    o.timer = 0;
    o.lastTimer = 0;
    o.timePerEgg = 40;
    o.maxTime = o:getDuration()
    return o;
end
