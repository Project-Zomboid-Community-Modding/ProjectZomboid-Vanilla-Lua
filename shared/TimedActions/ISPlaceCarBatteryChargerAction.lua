--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPlaceCarBatteryChargerAction = ISBaseTimedAction:derive("ISPlaceCarBatteryChargerAction")

function ISPlaceCarBatteryChargerAction:isValid()
    if isClient() and self.charger then
	    return self.character:getInventory():containsID(self.charger:getID())
	else
	    return self.character:getInventory():contains(self.charger)
	end
end

function ISPlaceCarBatteryChargerAction:waitToStart()
	local sq = self.character:getSquare()
	self.character:faceLocation(sq:getX(), sq:getY())
	return self.character:shouldBeTurning()
end

function ISPlaceCarBatteryChargerAction:start()
    if isClient() and self.charger then
        self.charger = self.character:getInventory():getItemById(self.charger:getID())
    end
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISPlaceCarBatteryChargerAction:update()
	local sq = self.character:getSquare()
	self.character:faceLocation(sq:getX(), sq:getY())
end

function ISPlaceCarBatteryChargerAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISPlaceCarBatteryChargerAction:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISPlaceCarBatteryChargerAction:complete()
	local square = self.character:getSquare()
	self.character:getInventory():Remove(self.charger)
	sendRemoveItemFromContainer(self.character:getInventory(), self.charger);
	local charger = IsoCarBatteryCharger.new(self.charger, getCell(), square)
	square:AddSpecialObject(charger)
	charger:transmitCompleteItemToClients()
	return true
end

function ISPlaceCarBatteryChargerAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function ISPlaceCarBatteryChargerAction:new(character, charger)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.charger = charger
	return o
end
