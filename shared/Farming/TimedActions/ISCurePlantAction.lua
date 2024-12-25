--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCurePlantAction = ISBaseTimedAction:derive("ISCurePlantAction");

function ISCurePlantAction:isValid()

    if not self.character:getInventory():containsID(self.item:getID()) then
        return false
    end

    if not self.character:getInventory():contains(self.item) then
        return false
    end

	self.plant:updateFromIsoObject()
	return self.plant:getIsoObject() ~= nil
end

function ISCurePlantAction:waitToStart()
	self.character:faceThisObject(self.plant:getObject())
	return  self.character:isTurning() or self.character:shouldBeTurning()
end

function ISCurePlantAction:update()
	self.item:setJobDelta(self:getJobDelta());
	self.character:faceThisObject(self.plant:getObject())
end

function ISCurePlantAction:start()
	self.item:setJobType(getText("ContextMenu_Treat_Problem"));
	self.item:setJobDelta(0.0);
	self:setActionAnim(CharacterActionAnims.Pour)
    self:setAnimVariable("PourType", self.item:getPourType());
	self:setOverrideHandModels(self.item, nil)
    if self.item:getType() == "SlugRepellent" then self.sound = self.character:playSound("WaterCrops")
	else self.sound = self.character:playSound("WaterCrops") end
end

function ISCurePlantAction:stop()
    self.item:setJobDelta(0.0);
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end
    ISBaseTimedAction.stop(self);
end

function ISCurePlantAction:perform()
    self.item:setJobDelta(0.0);
	if self.sound and self.sound ~= 0 then
		self.character:getEmitter():stopOrTriggerSound(self.sound)
	end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISCurePlantAction:complete()
	local plant = SFarmingSystem.instance:getLuaObjectAt(self.plant.x, self.plant.y, self.plant.z);

	if plant then
		if self.cure == "Aphids" then
			plant:cureAphids(nil, self.uses, self.character:getPerkLevel(Perks.Farming));
		elseif self.cure == "Slugs" then
			plant:cureSlugs(nil, self.uses, self.character:getPerkLevel(Perks.Farming));
		elseif self.cure == "Flies" then
			plant:cureFlies(nil, self.uses, self.character:getPerkLevel(Perks.Farming));
		elseif self.cure == "Mildew" then
			plant:cureMildew(nil, self.uses, self.character:getPerkLevel(Perks.Farming));
		end
	end

	-- Hack until server manages player inventory
	for i=1,self.uses do
		if self.item then
			self.item:UseAndSync()
		else
			return true;
		end
	end

	return true;
end

function ISCurePlantAction:getDuration()
	return self.maxTime;
end

function ISCurePlantAction:new(character, item, uses, plant, maxTime, cure)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character;
	o.item = item;
	o.uses = uses;
	o.maxTime = maxTime;
	o.cure = cure
	if character:isTimedActionInstant() then
		o.maxTime = 1;
	end
    o.plant = plant;
	return o;
end
