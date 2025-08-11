---
--- Created by zacco.
--- DateTime: 25/07/2025 11:02 am
---

require "TimedActions/ISBaseTimedAction"

ISDropCorpseIntoContainer = ISBaseTimedAction:derive("ISDropCorpseIntoContainer");

function ISDropCorpseIntoContainer:isValid()
    if not self.character:isDraggingCorpse() then
        return false
    end

    if getGameSpeed() > 1 then
        return false
    end

    return true
end

function ISDropCorpseIntoContainer:start()
    local player = self.character
    player:throwGrappledIntoInventory(self.targetContainer)
end

function ISDropCorpseIntoContainer:new(character, targetContainer)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.maxTime = -1;
    o.targetContainer = targetContainer;

    return o
end