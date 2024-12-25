--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveLightSourceFuelAction = ISBaseTimedAction:derive("ISRemoveLightSourceFuelAction");

function ISRemoveLightSourceFuelAction:isValid()
	return self.lightSource:haveFuel()
end

function ISRemoveLightSourceFuelAction:start()
end

function ISRemoveLightSourceFuelAction:update()
end

function ISRemoveLightSourceFuelAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISRemoveLightSourceFuelAction:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end


function ISRemoveLightSourceFuelAction:complete()
	if self.lightSource and self.lightSource:haveFuel() then
		local fuel = self.lightSource:removeCurrentFuel(nil)
		if fuel then
			self.lightSource:sendObjectChange('lightSource')
			self.character:getInventory():AddItem(fuel);
			sendAddItemToContainer(self.character:getInventory(), fuel);
		end
		return true
	end
	return false
end

function ISRemoveLightSourceFuelAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISRemoveLightSourceFuelAction:new(character, lightSource)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.lightSource = lightSource
	return o
end
