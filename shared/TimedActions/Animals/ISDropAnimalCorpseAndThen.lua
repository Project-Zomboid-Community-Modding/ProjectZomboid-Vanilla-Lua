require "TimedActions/ISBaseTimedAction"

ISDropAnimalCorpseAndThen = ISBaseTimedAction:derive("ISDropAnimalCorpseAndThen")

function ISDropAnimalCorpseAndThen:isValid()
    if not self.character:getCurrentSquare() then
        return false
    end
    if isClient() then
        return self.character:getInventory():containsID(self.item:getID())
    end
    return self.character:getInventory():contains(self.item)
end

function ISDropAnimalCorpseAndThen:waitToStart()
    return false
end

function ISDropAnimalCorpseAndThen:update()
    self.item:setJobDelta(self:getJobDelta())
end

function ISDropAnimalCorpseAndThen:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
    self.item:setJobType(getText("IGUI_JobType_Dropping"))
    self.item:setJobDelta(0.0)
    local sound = self.item:getDropSound()
    if sound ~= nil and not self.character:getEmitter():isPlaying(sound) then
        self.sound = self.character:playSound(sound)
    end
end

function ISDropAnimalCorpseAndThen:stop()
    self.item:setJobDelta(0.0)
    self:stopSound()
    ISBaseTimedAction.stop(self)
end

function ISDropAnimalCorpseAndThen:perform()
    self:stopSound()
    if self.item:getContainer() then
        self.item:getContainer():setDrawDirty(true)
    end
    self.item:setJobDelta(0.0);
    ISInventoryPage.renderDirty = true
    if not isClient() and self.andThen then
    end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISDropAnimalCorpseAndThen:complete()
    self.character:getInventory():Remove(self.item)
    sendRemoveItemFromContainer(self.character:getInventory(), self.item)
    local corpse = self.character:getCurrentSquare():tryAddCorpseToWorld(self.item, 0.5, 0.5)
    if corpse and self.andThen then
        if isServer() then
            local args = { corpse=corpse, onlineID=self.character:getOnlineID() }
            sendServerCommand(self.character, "animalCorpse", self.andThen, args)
        elseif not isClient() then
            if self.andThen == "butcher" then
                if luautils.walkAdj(self.character, corpse:getSquare()) then
                    ISTimedActionQueue.add(ISButcherAnimal:new(self.character, corpse))
                end
            end
            if self.andThen == "getBones" then
                if luautils.walkAdj(self.character, corpse:getSquare()) then
                    ISTimedActionQueue.add(ISGetAnimalBones:new(self.character, corpse))
                end
            end
        end
    end
    return true
end

function ISDropAnimalCorpseAndThen:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 10
end

function ISDropAnimalCorpseAndThen:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:getEmitter():stopOrTriggerSound(self.sound)
    end
end

function ISDropAnimalCorpseAndThen:new(character, item, andThen)
    local o = ISBaseTimedAction.new(self, character)
    o.item = item
    o.maxTime = o:getDuration()
    o.andThen = andThen
    return o
end
