require "TimedActions/ISBaseTimedAction"

ISKillAnimalInInventory = ISBaseTimedAction:derive("ISKillAnimalInInventory");

function ISKillAnimalInInventory:isValid()
	return self:canKillAnimal();
end

function ISKillAnimalInInventory:waitToStart()
	return false
end

function ISKillAnimalInInventory:update()
end

function ISKillAnimalInInventory:start()
    self:setActionAnim("Loot")
    self.animalItem:setJobType(getText("ContextMenu_KillAnimal"))
    self.animalItem:getAnimal():playBreedSound("pain")
end

function ISKillAnimalInInventory:stop()
    ISBaseTimedAction.stop(self);
end

function ISKillAnimalInInventory:canKillAnimal()
	if not self.character or not self.animalItem or not self.character:getInventory():contains(self.animalItem) then
		return false;
	end

	return true;
end

function ISKillAnimalInInventory:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);

    if isClient() then
        local animal = self.animalItem and self.animalItem:getAnimal()
        if animal then
            animal:playBreedSound("death")
        end
    end
end

function ISKillAnimalInInventory:complete()
    if isServer() then
        if not self:canKillAnimal() then
            return false;
        end
        PVPLogTool.logKill(self.character, self.animal)
    end
    self:kill();

	return true
end

function ISKillAnimalInInventory:kill()
    local animal = self.animalItem:getAnimal()
    animal:playBreedSound("death")
	animal:setHealth(0);
    animal:doDeathSplatterAndSounds(nil, self.character, true);
    local wasCorpseAlready = true
    local addToSquareAndWorld = false
    local isoDeadBody = IsoDeadBody.new(animal, wasCorpseAlready, addToSquareAndWorld)
    local corpseItem = isoDeadBody:getItem()
    self.character:getInventory():Remove(self.animalItem)
    sendRemoveItemFromContainer(self.character:getInventory(), self.animalItem)
    self.animalItem = nil
    self.character:getInventory():AddItem(corpseItem)
    sendAddItemToContainer(self.character:getInventory(), corpseItem)
end

function ISKillAnimalInInventory:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 80
end

function ISKillAnimalInInventory:new(character, animalItem)
	local o = ISBaseTimedAction.new(self, character)
	o.animalItem = animalItem;
	o.maxTime = o:getDuration()
	return o;
end
