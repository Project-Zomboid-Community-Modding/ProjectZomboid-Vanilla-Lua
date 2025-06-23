--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISSeedActionNew = ISBaseTimedAction:derive("ISSeedActionNew");

function ISSeedActionNew:isValid()

    if not self.seed or not self.character:getInventory():contains(self.seed) then
        return false
    end

    if not self.seed:getID() or not self.character:getInventory():containsID(self.seed:getID()) then
        print("ERROR: Seed does not have an ID!")
        return false
    end

	self.plant:updateFromIsoObject()
	return self.plant:getIsoObject() ~= nil
end

function ISSeedActionNew:waitToStart()
	self.character:faceThisObject(self.plant:getObject())
	return  self.character:isTurning() or self.character:shouldBeTurning()
end

function ISSeedActionNew:update()
	self.character:faceThisObject(self.plant:getObject())
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISSeedActionNew:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	
	-- used to send loot position
	self.character:reportEvent("EventLootItem");

	self.sound = self.character:playSound("SowSeeds");
end

function ISSeedActionNew:stop()
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end
    ISBaseTimedAction.stop(self);
end

function ISSeedActionNew:perform()
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISSeedActionNew:complete()
    local skill = self.character:getPerkLevel(Perks.Farming)
    self.character:addBackMuscleStrain(1 - (skill * 0.05))
	self.character:getInventory():Remove(self.seed);
	sendRemoveItemFromContainer(self.character:getInventory(), self.seed);

	local plant = SFarmingSystem.instance:getLuaObjectAt(self.plant.x, self.plant.y, self.plant.z);
	if plant and plant.state == "plow" then
		plant:seed(self.typeOfSeed, self.character:getPerkLevel(Perks.Farming));
		if isClient() then
			plant.owner = self.character:getOnlineID()
		else
			plant.owner = self.character:getPlayerNum()
		end
	end

	return true;
end

function ISSeedActionNew:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 40;
end

function ISSeedActionNew:new(character, seed, typeOfSeed, plant)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.seed = seed;
	o.typeOfSeed = typeOfSeed;
    o.plant = plant;
	o.maxTime = o:getDuration();
	return o;
end
