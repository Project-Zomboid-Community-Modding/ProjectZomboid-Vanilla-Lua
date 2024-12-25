--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISInsertLightSourceFuelAction = ISBaseTimedAction:derive("ISInsertLightSourceFuelAction");

function ISInsertLightSourceFuelAction:isValidStart()
	return self.fuel:getCurrentUsesFloat() > 0
end

function ISInsertLightSourceFuelAction:isValid()
    if isClient() and self.fuel then
	    return self.character:getInventory():containsID(self.fuel:getID())
	else
	    return self.character:getInventory():contains(self.fuel)
	end
end

function ISInsertLightSourceFuelAction:start()
    if isClient() and self.fuel then
        self.fuel = self.character:getInventory():getItemById(self.fuel:getID())
    end
	self.fuel:setJobType("Insert")
	self.fuel:setJobDelta(0.0)
end

function ISInsertLightSourceFuelAction:update()
	self.fuel:setJobDelta(self:getJobDelta())
end

function ISInsertLightSourceFuelAction:stop()
	self.fuel:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISInsertLightSourceFuelAction:perform()
	self.fuel:setJobDelta(0.0)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISInsertLightSourceFuelAction:complete()
	if self.lightSource then
		-- when player inventory is synced properly, we will simply send
		-- the index/id of the item to use instead of creating a new item.
		local fuel = instanceItem(self.fuel:getFullType())
		fuel:setUsedDelta(self.fuel:getCurrentUsesFloat())
		local previous = self.lightSource:insertNewFuel(fuel, nil)
		self.lightSource:sendObjectChange('lightSource')
		self.character:getInventory():Remove(self.fuel)
		sendRemoveItemFromContainer(self.character:getInventory(), self.fuel);
		if previous then
			self.character:getInventory():AddItem(previous);
			sendAddItemToContainer(self.character:getInventory(), previous);
		end
		return true
	else
		noise('no thumpable light found!')
	end
	return false
end

function ISInsertLightSourceFuelAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISInsertLightSourceFuelAction:new(character, lightSource, fuel)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.lightSource = lightSource
	o.fuel = fuel
	return o
end
