require "TimedActions/ISBaseTimedAction"

ISWringClothing = ISBaseTimedAction:derive("ISWringClothing")

function ISWringClothing:isValid()
    return self.item:getWetness() > 10
end

function ISWringClothing:update()
    self.item:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
end

function ISWringClothing:start()
    self:setActionAnim("Loot")
    self:setAnimVariable("LootPosition", "")
    self:setOverrideHandModels(nil, nil)
    self.sound = self.character:playSound("WashClothing")
    self.character:reportEvent("EventWashClothing")
end

function ISWringClothing:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound)
    end
end

function ISWringClothing:stop()
    self:stopSound()
    self.item:setJobDelta(0.0)
    ISBaseTimedAction.stop(self)
end

function ISWringClothing:perform()
    self:stopSound()
    self.item:setJobDelta(0.0)
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISWringClothing:complete()
    if instanceof(self.item, "Clothing") then
        if self.item:getBodyLocation() == "Shoes" then
            self.item:setWetness(math.min(self.item:getWetness(), 60))
        else
            self.item:setWetness(math.min(self.item:getWetness(), 10))
        end
    end
    syncItemFields(self.character, self.item)
    return true
end


function ISWringClothing:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return math.ceil(self.item:getWetness() * 5)
end

function ISWringClothing:new(character, item)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.maxTime = math.ceil(item:getWetness() * 5)
    o.forceProgressBar = true
    return o
end
