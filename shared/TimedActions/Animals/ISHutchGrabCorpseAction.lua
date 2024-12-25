require "TimedActions/ISBaseTimedAction"

ISHutchGrabCorpseAction = ISBaseTimedAction:derive("ISHutchGrabCorpseAction");

function ISHutchGrabCorpseAction:isValid()
    return self.hutch:getDeadBody(self.index) ~= nil
end

function ISHutchGrabCorpseAction:waitToStart()
    self.character:faceThisObject(self.hutch)
    return self.character:shouldBeTurning()
end

function ISHutchGrabCorpseAction:update()
    self.corpse:setJobDelta(self:getJobDelta());
    self.character:faceThisObject(self.hutch);
end

function ISHutchGrabCorpseAction:start()
    self.corpse:setJobType(getText("ContextMenu_Grab"));
    self.corpse:setJobDelta(0.0);
    self:setActionAnim("Loot");
    self.character:SetVariable("LootPosition", "Low");
    self.character:reportEvent("EventLootItem");
end

function ISHutchGrabCorpseAction:stop()
    ISBaseTimedAction.stop(self);
    self.corpse:setJobDelta(0.0);
end

function ISHutchGrabCorpseAction:perform()
    forceDropHeavyItems(self.character)
    self.corpse:setJobDelta(0.0);
    self.character:getInventory():setDrawDirty(true);

    local pdata = getPlayerData(self.character:getPlayerNum());
    if pdata ~= nil then
        pdata.playerInventory:refreshBackpacks();
        pdata.lootInventory:refreshBackpacks();
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISHutchGrabCorpseAction:complete()
    local corpse = self.hutch:getDeadBody(self.index):getItem();
    if corpse == nil then
        return false;
    end
    self.character:getInventory():AddItem(corpse);
    sendAddItemToContainer(self.character:getInventory(), corpse);
    self.character:setPrimaryHandItem(corpse);
    self.character:setSecondaryHandItem(corpse);
    if isServer() then
        sendEquip(self.character)
    end


    self.hutch:removeAnimal(self.animal);
    --sendHutchGrabCorpseAction(self.animal, self.character, self.hutch, corpse);
    self.hutch:sync()

    return true
end

function ISHutchGrabCorpseAction:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 100
end

function ISHutchGrabCorpseAction:new (character, index, hutch)
    local o = ISBaseTimedAction.new(self, character)
    o.corpse = hutch:getDeadBody(index):getItem();
    o.animal = hutch:getAnimal(index);
    o.index = index;
    o.hutch = hutch;
    o.forceProgressBar = true;
    o.ignoreHandsWounds = true;
    o.maxTime = o:getDuration()
    return o
end
