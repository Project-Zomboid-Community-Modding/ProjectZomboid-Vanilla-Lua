--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGetCompost = ISBaseTimedAction:derive("ISGetCompost");

local COMPOST_PER_BAG = 10
local SCRIPT_ITEM = ScriptManager.instance:FindItem("Base.CompostBag")
local USES_PER_BAG = 1.0 / SCRIPT_ITEM:getUseDelta()
local COMPOST_PER_USE = COMPOST_PER_BAG / USES_PER_BAG

function ISGetCompost:isValid()
    if isClient() and self.item then
        return (self.compost:getCompost() >= COMPOST_PER_USE) and
            self.character:getInventory():containsID(self.item:getID());
    else
        return (self.compost:getCompost() >= COMPOST_PER_USE) and
            self.character:getInventory():contains(self.item);
    end
end

function ISGetCompost:update()
    self.character:faceThisObject(self.compost)
    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISGetCompost:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Mid")
end

function ISGetCompost:stop()
    ISBaseTimedAction.stop(self);
end

function ISGetCompost:perform()

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISGetCompost:complete()
    local amount = self.compost:getCompost()
    local uses = math.floor(amount / COMPOST_PER_USE)
    if self.item:getType() == "CompostBag" then
        uses = math.min(uses, USES_PER_BAG - self.item:getCurrentUses())
        self.item:setUsedDelta(self.item:getCurrentUsesFloat() + self.item:getUseDelta() * uses)
        syncItemFields(self.character, self.item)
    else
        self.character:removeFromHands(self.item);
        self.character:getInventory():Remove(self.item);
        sendRemoveItemFromContainer(self.character:getInventory(), self.item);
        local compostBag = instanceItem("Base.CompostBag")
        self.character:getInventory():AddItem(compostBag);
        uses = math.min(uses, USES_PER_BAG)
        compostBag:setUsedDelta(compostBag:getUseDelta() * uses);
        sendAddItemToContainer(self.character:getInventory(), compostBag);
        self.character:setPrimaryHandItem(compostBag);
    end
    self.compost:setCompost(self.compost:getCompost() - uses * COMPOST_PER_USE);
    self.compost:sync()
    self.compost:updateSprite();
    if isClient() then
        self.compost:syncCompost();
    end

    return true;
end

function ISGetCompost:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 100
end

function ISGetCompost:new(character, compost, item)
    local o = ISBaseTimedAction.new(self, character)
    o.compost = compost;
    o.item = item;
    o.maxTime = o:getDuration();
    return o;
end    
