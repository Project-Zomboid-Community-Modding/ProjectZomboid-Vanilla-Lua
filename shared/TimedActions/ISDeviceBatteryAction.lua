require "TimedActions/ISBaseTimedAction"

ISDeviceBatteryAction = ISBaseTimedAction:derive("ISDeviceBatteryAction")

function ISDeviceBatteryAction:isValid()
    return self.deviceData:getIsBatteryPowered() and self.deviceData:getHasBattery() == self.isRemove;
end

function ISDeviceBatteryAction:complete()
    self:invoke();
    return true;
end

function ISDeviceBatteryAction:invoke()
    if (not self:isValid()) then
        return;
    end
    if (self.isRemove) then
        if (self.character:getInventory()) then
            self.deviceData:getBattery(self.character:getInventory());
        end;
    else
        if (self.secondaryItem) then
            self.deviceData:addBattery(self.secondaryItem);
        end;
    end
end

function ISDeviceBatteryAction:getDuration()
	return 30;
end

function ISDeviceBatteryAction:getDeviceDataParameter(character, device, deviceType)
    if character and device and deviceType then
        if deviceType == "InventoryItem" then
            return device:getID();
        else
            return device:getSquare();
        end
    end
    return nil;
end

function ISDeviceBatteryAction:getDeviceDataFromParameter(character, parameter)
    if parameter == nil then
        return nil;
    end
    if instanceof(parameter, "IsoGridSquare") then
        return parameter:getDeviceData();
    elseif character:getInventory() and character:getInventory():getItemWithID(parameter) then
        return character:getInventory():getItemWithID(parameter):getDeviceData();
    end
    return nil;
end

function ISDeviceBatteryAction:new(character, isRemove, secondaryItem, parameter)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnWalk = false;
    o.stopOnRun = true;
    o.ignoreHandsWounds = true;
	o.maxTime = o:getDuration();
	o.isRemove = isRemove;
    o.secondaryItem = secondaryItem;
    o.parameter = parameter;
    o.deviceData = ISDeviceBatteryAction:getDeviceDataFromParameter(character, o.parameter);
	return o
end
