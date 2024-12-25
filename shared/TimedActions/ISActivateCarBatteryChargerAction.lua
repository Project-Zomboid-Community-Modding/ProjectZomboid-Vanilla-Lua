--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISActivateCarBatteryChargerAction = ISBaseTimedAction:derive("ISActivateCarBatteryChargerAction")

function ISActivateCarBatteryChargerAction:isValid()
	return self.charger:getObjectIndex() ~= -1 and
		self.charger:isActivated() ~= self.activate
end

function ISActivateCarBatteryChargerAction:waitToStart()
	self.character:faceThisObject(self.charger)
	return self.character:shouldBeTurning()
end

function ISActivateCarBatteryChargerAction:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISActivateCarBatteryChargerAction:update()
	self.character:faceThisObject(self.charger)
end

function ISActivateCarBatteryChargerAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISActivateCarBatteryChargerAction:perform()
	self.charger:getSquare():playSound("LightSwitch")

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISActivateCarBatteryChargerAction:complete()
	if not self.charger then return end
	self.charger:setActivated(self.activate)
	self.charger:sync()

	return true;
end

function ISActivateCarBatteryChargerAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISActivateCarBatteryChargerAction:new(character, charger, activate)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = o:getDuration()
	o.charger = charger
	o.activate = activate
	return o
end
