--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveCarBatteryFromChargerAction = ISBaseTimedAction:derive("ISRemoveCarBatteryFromChargerAction")

function ISRemoveCarBatteryFromChargerAction:isValid()
	return self.charger:getObjectIndex() ~= -1 and
		self.charger:getBattery() ~= nil
end

function ISRemoveCarBatteryFromChargerAction:waitToStart()
	self.character:faceThisObject(self.charger)
	return self.character:shouldBeTurning()
end

function ISRemoveCarBatteryFromChargerAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISRemoveCarBatteryFromChargerAction:update()
	self.character:faceThisObject(self.charger)
end

function ISRemoveCarBatteryFromChargerAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISRemoveCarBatteryFromChargerAction:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISRemoveCarBatteryFromChargerAction:complete()
	if not self.charger then return end
	local battery = self.charger:getBattery()
	if battery then
		self.charger:setBattery(nil)
		self.charger:sync()
		self.character:getInventory():AddItem(battery);
		sendAddItemToContainer(self.character:getInventory(), battery);
	else
		noise('car-battery charger does not have a battery')
	end

	return true
end

function ISRemoveCarBatteryFromChargerAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function ISRemoveCarBatteryFromChargerAction:new(character, charger)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.charger = charger
	return o
end
