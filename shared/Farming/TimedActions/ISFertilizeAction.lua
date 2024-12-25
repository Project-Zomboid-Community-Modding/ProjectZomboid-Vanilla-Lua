--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFertilizeAction = ISBaseTimedAction:derive("ISFertilizeAction");

function ISFertilizeAction:isValid()
	self.plant:updateFromIsoObject()
	return self.plant:getIsoObject() ~= nil
end

function ISFertilizeAction:waitToStart()
	self.character:faceThisObject(self.plant:getObject())
	return  self.character:isTurning() or self.character:shouldBeTurning()
end

function ISFertilizeAction:update()
	self.item:setJobDelta(self:getJobDelta());
	self.character:faceThisObject(self.plant:getObject())
    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISFertilizeAction:start()
	self.item:setJobType(getText("ContextMenu_Fertilize"));
	self.item:setJobDelta(0.0);
-- 	self:setActionAnim("Loot")
-- 	self.character:SetVariable("LootPosition", "Low")
	local pourType = "Bucket"
	if self.item:getPourType() then pourType = self.item:getPourType() end
    self:setActionAnim(CharacterActionAnims.Pour);
    self:setAnimVariable("PourType", pourType);
    self:setOverrideHandModels(self.item, nil);
	
	-- used to send loot position
-- 	self.character:reportEvent("EventLootItem");

	self.sound = self.character:playSound("DropSoilFromSandBag");
end

function ISFertilizeAction:stop()
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISFertilizeAction:perform()
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end
	self.item:getContainer():setDrawDirty(true);
	self.item:setJobDelta(0.0);

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISFertilizeAction:complete()
	local plant = SFarmingSystem.instance:getLuaObjectAt(self.plant.x, self.plant.y, self.plant.z);
	if plant then
		local args = { compost = self.item:hasTag("Compost"), skill = self.character:getPerkLevel(Perks.Farming) }
		plant:fertilize(args);
	end

	-- MP shouldn't do this directly
	self.item:UseAndSync()

	local itemToRemove = self.character:getInventory():Find("FertilizerEmpty");

	if itemToRemove ~= nil then
		self.character:getInventory():Remove(itemToRemove)
		sendRemoveItemFromContainer(self.character:getInventory(), itemToRemove);
	end

	return true;
end

function ISFertilizeAction:getDuration()
	return self.maxTime;
end

function ISFertilizeAction:new(character, item, plant, maxTime)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.item = item;
    o.plant = plant;
	o.maxTime = maxTime;

	return o
end
