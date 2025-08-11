--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISKillAnimalInInventory = ISBaseTimedAction:derive("ISKillAnimalInInventory");

function ISKillAnimalInInventory:isValid()
	return true
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
	if not self.character then
		print("!canKillAnimal: self.character is null");
		return false;
	end

	if not self.animalItem then
		print("!canKillAnimal: self.animalItem is null");
		return false;
	end

	if not self.character:getInventory():contains(self.animalItem) then
		print("!canKillAnimal: self.animalItem not in inventory");
		return false;
	end

	return true;
end

function ISKillAnimalInInventory:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
	local isSinglePlayerMode = (not isClient() and not isServer());

	if isSinglePlayerMode then
		self:kill();
	end
end

function ISKillAnimalInInventory:complete()
	if isServer() and not self:canKillAnimal() then
		return false;
	end

--    local animal = self.animalItem:getAnimal()
--	sendServerCommand('animal', 'kill', { id = animal:getOnlineID() });

	return true
end

function ISKillAnimalInInventory:kill()
    local animal = self.animalItem:getAnimal()
    animal:playBreedSound("death")
	animal:setHealth(0);
    local wasCorpseAlready = true
    local addToSquareAndWorld = false
    local isoDeadBody = IsoDeadBody.new(animal, wasCorpseAlready, addToSquareAndWorld)
    local corpseItem = isoDeadBody:getItem()
    self.character:getInventory():Remove(self.animalItem)
    self.animalItem = nil
    self.character:getInventory():AddItem(corpseItem)
end

function ISKillAnimalInInventory:getDuration()
	--if self.character:isTimedActionInstant() then
	--	return 1
	--end
	return 80
end

function ISKillAnimalInInventory:new(character, animalItem)
	local o = ISBaseTimedAction.new(self, character)
	o.animalItem = animalItem;
	o.maxTime = o:getDuration()
	return o;
end
