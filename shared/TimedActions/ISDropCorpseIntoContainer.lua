---
--- Created by zacco.
--- DateTime: 25/07/2025 11:02 am
---

require "TimedActions/ISBaseTimedAction"

ISDropCorpseIntoContainer = ISBaseTimedAction:derive("ISDropCorpseIntoContainer");

ISDropCorpseIntoContainer.bodyCache = {}

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
    self.action:setAllowedWhileDraggingCorpses(true)
end

function ISDropCorpseIntoContainer:complete()
    if isServer() then
        local id = self.character:getOnlineID()
        local data = ISDropCorpseIntoContainer.bodyCache[id] or {}
        data[self.grappledChar] = self.targetContainer
        ISDropCorpseIntoContainer.bodyCache[id] = data
    end
    return true;
end

function ISDropCorpseIntoContainer:getDuration()
    return 5
end

function ISDropCorpseIntoContainer:perform()
    self.character:throwGrappledIntoInventory(self.targetContainer)
    ISBaseTimedAction.perform(self)
end

function ISDropCorpseIntoContainer:new(character, targetContainer)
    local o = ISBaseTimedAction.new(self, character)
    o.character = character;
    o.maxTime = o:getDuration();
    o.targetContainer = targetContainer;
    o.grappledChar = character:getGrapplingTarget()
    o.allowedWhileDraggingCorpses = true

    return o
end
