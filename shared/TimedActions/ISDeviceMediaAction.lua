require "TimedActions/ISBaseTimedAction"

ISDeviceMediaAction = ISBaseTimedAction:derive("ISDeviceMediaAction")

function ISDeviceMediaAction:isValid()
    if (self.isRemove) then
        return self.deviceData:hasMedia();
    else
        return (not self.deviceData:hasMedia()) and self.deviceData:getMediaType() == self.secondaryItem:getMediaType();
    end
end

function ISDeviceMediaAction:complete()
    self:invoke();
    return true;
end

function ISDeviceMediaAction:invoke()
    if (not self:isValid()) then
        return;
    end

    if (self.isRemove) then
        if (self.character:getInventory()) then
            self.deviceData:removeMediaItem(self.character:getInventory());
        end;
    else
        if (self.secondaryItem) then
            self.deviceData:addMediaItem(self.secondaryItem);
        end;
    end
end

function ISDeviceMediaAction:getDuration()
	return 30;
end

function ISDeviceMediaAction:new(character, isRemove, secondaryItem, parameter)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnWalk        = false;
    o.stopOnRun         = true;
    o.ignoreHandsWounds = true;
	o.maxTime = o:getDuration();
	o.isRemove = isRemove;
    o.secondaryItem = secondaryItem;
    o.parameter = parameter;
    o.deviceData = ISDeviceBatteryAction:getDeviceDataFromParameter(character, o.parameter);
	return o
end
