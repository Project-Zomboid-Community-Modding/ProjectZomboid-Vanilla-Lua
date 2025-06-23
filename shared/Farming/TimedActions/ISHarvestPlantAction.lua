--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISHarvestPlantAction = ISBaseTimedAction:derive("ISHarvestPlantAction");

function ISHarvestPlantAction:isValid()
	self.plant:updateFromIsoObject()
	return self.plant:getObject() and self.plant:canHarvest()
end

function ISHarvestPlantAction:waitToStart()
	self.character:faceThisObject(self.plant:getObject())
	return  self.character:isTurning() or self.character:shouldBeTurning()
end

function ISHarvestPlantAction:update()
	self.character:faceThisObject(self.plant:getObject())
    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISHarvestPlantAction:start()
    local prop = farming_vegetableconf.props[self.plant.typeOfSeed]
    local lootPosition = "Low"
    if prop.harvestPosition then lootPosition = prop.harvestPosition end
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", lootPosition)
	
	self.character:reportEvent("EventLootItem");

	self.sound = self.character:playSound("HarvestCrops");
end

function ISHarvestPlantAction:stop()
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end
	ISBaseTimedAction.stop(self);
end

function ISHarvestPlantAction:perform()



	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISHarvestPlantAction:complete()
    local prop = farming_vegetableconf.props[self.plant.typeOfSeed]
    local lootPosition = "Low"
    if prop.harvestPosition then lootPosition = prop.harvestPosition end
    if lootPosition == "Low" then
        local skill = self.character:getPerkLevel(Perks.Farming)
        self.character:addBackMuscleStrain(1 - (skill * 0.05))
    end
	local plant = SFarmingSystem.instance:getLuaObjectAt(self.plant.x, self.plant.y, self.plant.z);

	local isPlayerOwn = false
	if isClient() then
		isPlayerOwn = self.character:getOnlineID() == plant.owner
	else
		isPlayerOwn = self.character:getPlayerNum() == plant.owner
	end

	if plant then
		-- we successfull harvest our plant, we may gain xp !
		if isPlayerOwn then
			SFarmingSystem.instance:gainXp(self.character, plant)
		end
		SFarmingSystem.instance:harvest(plant, self.character)
	end

	return true;
end

function ISHarvestPlantAction:getDuration()
	return self.maxTime;
end

function ISHarvestPlantAction:new(character, plant, maxTime)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
    o.plant = plant;
	o.maxTime = maxTime;
    o.caloriesModifier = 4;
	if character:isTimedActionInstant() then
		o.maxTime = 1;
	end
	return o;
end
