--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISHutchGrabAnimal = ISBaseTimedAction:derive("ISHutchGrabAnimal");

function ISHutchGrabAnimal:isValid()
    return self.hutch ~= nil;
end

function ISHutchGrabAnimal:waitToStart()
    self.character:faceThisObject(self.tree)
    return self.character:shouldBeTurning()
end

function ISHutchGrabAnimal:update()
    self.character:faceThisObject(self.hutch)
end

function ISHutchGrabAnimal:start()
    self:setActionAnim("Loot")
    self.character:SetVariable("LootPosition", "Low")
    self.character:reportEvent("EventLootItem")
end

function ISHutchGrabAnimal:stop()
    ISBaseTimedAction.stop(self);
end

function ISHutchGrabAnimal:perform()
    local animal = self.hutch:getAnimal(self.index)
    if animal then
        animal:playBreedSound("pick_up")
    end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);

end

function ISHutchGrabAnimal:complete()
    local animal = self.hutch:getAnimal(self.index);
    if animal == nil then
        return false;
    end
    local invItem = instanceItem("Base.Animal");
    invItem:setAnimal(animal);
    self.hutch:removeAnimal(animal)
    self.character:getInventory():AddItem(invItem);
    sendAddItemToContainer(self.character:getInventory(), invItem);

    forceDropHeavyItems(self.character)

    self.character:setPrimaryHandItem(nil);
    self.character:setSecondaryHandItem(nil);

    self.character:setPrimaryHandItem(invItem);
    self.character:setSecondaryHandItem(invItem);

    --sendHutchGrabAnimal(self.animal, self.character, self.hutch, invItem)
    self.hutch:sync()
    return true
end

function ISHutchGrabAnimal:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 150
end

function ISHutchGrabAnimal:new(character, index, hutch)
    local o = ISBaseTimedAction.new(self, character)
    o.hutch = hutch;
    o.index = index;
    o.maxTime = o:getDuration()
    return o;
end
