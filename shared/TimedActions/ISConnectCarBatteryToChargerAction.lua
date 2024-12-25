--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISConnectCarBatteryToChargerAction = ISBaseTimedAction:derive("ISConnectCarBatteryToChargerAction")

function ISConnectCarBatteryToChargerAction:isValid()
    if isClient() and self.battery then
        return self.charger:getObjectIndex() ~= -1 and
            self.character:getInventory():containsID(self.battery:getID())
    else
        return self.charger:getObjectIndex() ~= -1 and
            self.character:getInventory():contains(self.battery)
    end
end

function ISConnectCarBatteryToChargerAction:waitToStart()
	self.character:faceThisObject(self.charger)
	return self.character:shouldBeTurning()
end

function ISConnectCarBatteryToChargerAction:start()
    if isClient() and self.battery then
        self.battery = self.character:getInventory():getItemById(self.battery:getID())
    end
	self.battery:setJobType(getText("ContextMenu_AddBattery"))
	self.battery:setJobDelta(0.0)
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISConnectCarBatteryToChargerAction:update()
	self.character:faceThisObject(self.charger)
	self.battery:setJobDelta(self:getJobDelta())
end

function ISConnectCarBatteryToChargerAction:stop()
	self.battery:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISConnectCarBatteryToChargerAction:perform()
	self.battery:setJobDelta(0.0)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISConnectCarBatteryToChargerAction:complete()
	if not self.charger then return end
	local battery = self.charger:getBattery()
	if battery then
		print('car-battery charger already has a battery')
	else
		self.character:getInventory():Remove(self.battery)
		sendRemoveItemFromContainer(self.character:getInventory(), self.battery);
		self.charger:setBattery(self.battery)
		self.charger:sync()
	end

	return true
end

function ISConnectCarBatteryToChargerAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function ISConnectCarBatteryToChargerAction:new(character, charger, battery)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.charger = charger
	o.battery = battery
	return o
end
