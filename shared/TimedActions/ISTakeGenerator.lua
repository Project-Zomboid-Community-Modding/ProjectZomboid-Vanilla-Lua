--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeGenerator = ISBaseTimedAction:derive("ISTakeGenerator");

function ISTakeGenerator:isValid()
    if not self.character:getSquare():canReachTo(self.generator:getSquare()) then return false end
	return self.generator:getObjectIndex() ~= -1 and
		not self.generator:isConnected()
end

function ISTakeGenerator:waitToStart()
	self.character:faceThisObject(self.generator)
	return self.character:shouldBeTurning()
end

function ISTakeGenerator:update()
	self.character:faceThisObject(self.generator)

    self.character:setMetabolicTarget(Metabolics.HeavyWork);
end

function ISTakeGenerator:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self.character:reportEvent("EventLootItem")
end

function ISTakeGenerator:stop()
    ISBaseTimedAction.stop(self);
end

function ISTakeGenerator:perform()


    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISTakeGenerator:complete()
	forceDropHeavyItems(self.character)
	local itemType = "Base.Generator"
	local mData = self.generator:getModData()
	if mData.generatorFullType then itemType = mData.generatorFullType end
	local item = instanceItem(itemType)
	self.character:getInventory():AddItem(item);
	item:setCondition(self.generator:getCondition());
	self.character:setPrimaryHandItem(item);
	self.character:setSecondaryHandItem(item);
	if self.generator:getFuel() > 0 then
		item:getModData()["fuel"] = self.generator:getFuel();
	end
	sendAddItemToContainer(self.character:getInventory(), item);
	sendEquip(self.character)
	self.character:getInventory():setDrawDirty(true);
	self.generator:remove();
	return true
end

function ISTakeGenerator:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function ISTakeGenerator:new(character, generator)
	local o = ISBaseTimedAction.new(self, character)
	o.generator = generator;
	o.maxTime = o:getDuration();
	return o;
end
