--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeCarBatteryChargerAction = ISBaseTimedAction:derive("ISTakeCarBatteryChargerAction")

function ISTakeCarBatteryChargerAction:isValid()
	return self.charger:getObjectIndex() ~= -1 and self.charger:getBattery() == nil
end

function ISTakeCarBatteryChargerAction:waitToStart()
	self.character:faceThisObject(self.charger)
	return self.character:shouldBeTurning()
end

function ISTakeCarBatteryChargerAction:update()
	self.character:faceThisObject(self.charger)
end

function ISTakeCarBatteryChargerAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISTakeCarBatteryChargerAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISTakeCarBatteryChargerAction:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISTakeCarBatteryChargerAction:complete()
	if not self.charger then return end
	if self.charger:getBattery() then
		noise('cannot remove car-battery charger connected to a battery')
		return
	end
	local item = self.charger:getItem()
	if item then
		self.character:getInventory():AddItem(item);
		sendAddItemToContainer(self.character:getInventory(), item);
	end
	self.charger:getSquare():transmitRemoveItemFromSquare(self.charger)
	return true
end

function ISTakeCarBatteryChargerAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 50
end

function ISTakeCarBatteryChargerAction:new(character, charger)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.charger = charger
	return o
end	
