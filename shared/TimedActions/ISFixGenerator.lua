--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFixGenerator = ISBaseTimedAction:derive("ISFixGenerator");

function ISFixGenerator:isValid()
	return self.generator:getObjectIndex() ~= -1 and
		not self.generator:isActivated() and
		self.generator:getCondition() < 100 and
		self.character:getInventory():containsTypeRecurse("ElectronicsScrap")
end

function ISFixGenerator:waitToStart()
	self.character:faceThisObject(self.generator)
	return self.character:shouldBeTurning()
end

function ISFixGenerator:update()
	self.character:faceThisObject(self.generator)

    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISFixGenerator:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
	self.sound = self.character:playSound("GeneratorRepair")
end

function ISFixGenerator:stop()
	self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self);
end

function ISFixGenerator:continueFixing()
	if self.generator:getCondition() < 100 then
		scrapItem = self.character:getInventory():getFirstTypeRecurse("ElectronicsScrap")
		if scrapItem then
			local previousAction = self
			if scrapItem:getContainer() ~= self.character:getInventory() then
				local action = ISInventoryTransferAction:new(self.character, scrapItem, scrapItem:getContainer(), self.character:getInventory(), nil)
				ISTimedActionQueue.addAfter(self, action)
				previousAction = action
			end
			ISTimedActionQueue.addAfter(previousAction, ISFixGenerator:new(self.character, self.generator));
		end
	end
end

function ISFixGenerator:perform()
	self.character:stopOrTriggerSound(self.sound)

	if isClient() then
		self:continueFixing()
	end

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISFixGenerator:complete()
	local scrapItem = self.character:getInventory():getFirstTypeRecurse("ElectronicsScrap");

	if not scrapItem then return false; end;
	self.character:removeFromHands(scrapItem);
	self.character:getInventory():Remove(scrapItem);
	sendRemoveItemFromContainer(self.character:getInventory(), scrapItem);

	self.generator:setCondition(self.generator:getCondition() + 4 + (1*(self.character:getPerkLevel(Perks.Electricity))/2))
	addXp(self.character, Perks.Electricity, 5)

	if not isClient() and not isServer() then
		self:continueFixing()
	end

	return true
end

function ISFixGenerator:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 150 - (self.character:getPerkLevel(Perks.Electricity) * 3)
end

function ISFixGenerator:new(character, generator)
	local o = ISBaseTimedAction.new(self, character);
	o.generator = generator;
	o.maxTime = o:getDuration()
    o.caloriesModifier = 4;
	return o;
end
