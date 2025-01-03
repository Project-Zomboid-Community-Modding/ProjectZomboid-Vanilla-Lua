--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRadioAction = ISBaseTimedAction:derive("ISRadioAction")

function ISRadioAction:isValid()
    if self.character and self.device and self.deviceData and self.mode then
        if self["isValid"..self.mode] then
            return self["isValid"..self.mode](self);
        end
    end
end

function ISRadioAction:start()
    if self.character and self.device and self.deviceData and self.mode then
        if self["start"..self.mode] then
            self["start"..self.mode](self);
        end
    end
end

function ISRadioAction:update()
    if self.character and self.deviceData and self.deviceData:isIsoDevice() then
        self.character:faceThisObject(self.deviceData:getParent())
    end
end

function ISRadioAction:perform()
    if self.character and self.device and self.deviceData and self.mode then
        if self["perform"..self.mode] then
            self["perform"..self.mode](self);
        end
    end

    ISBaseTimedAction.perform(self)
end

-- ToggleOnOff
function ISRadioAction:isValidToggleOnOff()
    return self.deviceData:getIsBatteryPowered() and self.deviceData:getPower()>0 or self.deviceData:canBePoweredHere();
end

function ISRadioAction:performToggleOnOff()
    if self:isValidToggleOnOff() then
        if self.deviceData:getIsTelevision() then
            self.deviceData:playSoundSend(self.deviceData:getIsTurnedOn() and "TelevisionOff" or "TelevisionOn", false)
        elseif self.deviceData:isVehicleDevice() then
            self.deviceData:playSoundSend("VehicleRadioButton", false)
        else
            self.deviceData:playSoundSend("RadioButton", false)
        end
        self.deviceData:setIsTurnedOn( not self.deviceData:getIsTurnedOn() );
    end
end

-- RemoveBattery
function ISRadioAction:isValidRemoveBattery()
    return self.deviceData:getIsBatteryPowered() and self.deviceData:getHasBattery();
end

function ISRadioAction:performRemoveBattery()
    if self:isValidRemoveBattery() and self.character:getInventory() then
        self.deviceData:getBattery(self.character:getInventory());
    end
end

-- AddBattery
function ISRadioAction:isValidAddBattery()
    return self.deviceData:getIsBatteryPowered() and self.deviceData:getHasBattery() == false;
end

function ISRadioAction:performAddBattery()
    if self:isValidAddBattery() and self.secondaryItem then
        self.deviceData:addBattery(self.secondaryItem);
    end
end

-- SetChannel
function ISRadioAction:isValidSetChannel()
    if (not self.secondaryItem) and type(self.secondaryItem)~="number" then return false; end
    return self.deviceData:getIsTurnedOn() and self.deviceData:getPower()>0;
end

function ISRadioAction:startSetChannel()
    if self.character ~= nil then
        local sound = "TuneIn"
        if self.deviceData:getIsTelevision() then sound = "TelevisionZap" end
        if self.deviceData:isVehicleDevice() then sound = "VehicleRadioTuneIn" end
        self.deviceData:stopOrTriggerSoundByName(sound)
        self.deviceData:playSoundSend(sound, false)
    end
end

function ISRadioAction:performSetChannel()
    local sound = "TuneIn"
    -- "TuneIn" and "VehicleRadioTuneIn" continue long past the end of the audio.
    local sound = "TuneIn"
    if self.deviceData:getIsTelevision() then sound = "TelevisionZap" end
    if self.deviceData:isVehicleDevice() then sound = "VehicleRadioTuneIn" end
    self.deviceData:stopOrTriggerSoundByName(sound)
    if self:isValidSetChannel() then
        self.deviceData:setChannel(self.secondaryItem);
    end
end

-- MuteVolume
function ISRadioAction:isValidMuteVolume()
    return self.deviceData:getIsTurnedOn() and self.deviceData:getPower()>0 and self.deviceData:getDeviceVolume()>0;
end

function ISRadioAction:performMuteVolume()
    if self:isValidMuteVolume() then
        if self.character then
            self.character:playSound("TelevisionMute")
        end
        self.deviceData:setDeviceVolume(0);
    end
end

-- UnMuteVolume
function ISRadioAction:isValidUnMuteVolume()
    if (not self.secondaryItem) or type(self.secondaryItem)~="number" then return false; end
    return self.deviceData:getIsTurnedOn() and self.deviceData:getPower()>0 and self.deviceData:getDeviceVolume()<=0;
end

function ISRadioAction:performUnMuteVolume()
    if self:isValidUnMuteVolume() then
        if self.character then
            self.character:playSound("TelevisionUnMute")
        end
        self.deviceData:setDeviceVolume(self.secondaryItem);
    end
end

-- SetVolume
function ISRadioAction:isValidSetVolume()
    if (not self.secondaryItem) and type(self.secondaryItem)~="number" then return false; end
    return self.deviceData:getIsTurnedOn() and self.deviceData:getPower()>0;
end

function ISRadioAction:performSetVolume()
    if self:isValidSetVolume() then
        self.deviceData:setDeviceVolume(self.secondaryItem);
    end
end

-- MuteMicrophone
function ISRadioAction:isValidMuteMicrophone()
    if (not self.secondaryItem) and type(self.secondaryItem)~="boolean" then return false; end
    return self.deviceData:getIsTurnedOn() and self.deviceData:getPower()>0;
end

function ISRadioAction:performMuteMicrophone()
    if self:isValidMuteMicrophone() then
        self.deviceData:setMicIsMuted(self.secondaryItem);
    end
end

-- RemoveHeadphones
function ISRadioAction:isValidRemoveHeadphones()
    return self.deviceData:getHeadphoneType() >= 0;
end

function ISRadioAction:performRemoveHeadphones()
    if self:isValidRemoveHeadphones() and self.character:getInventory() then
        self.deviceData:getHeadphones(self.character:getInventory());
    end
end

-- AddHeadphones
function ISRadioAction:isValidAddHeadphones()
    return self.deviceData:getHeadphoneType() < 0;
end

function ISRadioAction:performAddHeadphones()
    if self:isValidAddHeadphones() and self.secondaryItem then
        self.deviceData:addHeadphones(self.secondaryItem);
    end
end

-- TogglePlayMedia
function ISRadioAction:isValidTogglePlayMedia()
    return self.deviceData:getIsTurnedOn() and self.deviceData:hasMedia();
end

function ISRadioAction:performTogglePlayMedia()
    if self:isValidTogglePlayMedia() then
        if self.deviceData:isPlayingMedia() then
            self.deviceData:StopPlayMedia();
        else
            self.deviceData:StartPlayMedia();
        end
    end
end

-- AddMedia
function ISRadioAction:isValidAddMedia()
    return (not self.deviceData:hasMedia()) and self.deviceData:getMediaType() == self.secondaryItem:getMediaType();
end

function ISRadioAction:performAddMedia()
    if self:isValidAddMedia() and self.secondaryItem then
        self.deviceData:addMediaItem(self.secondaryItem);
    end
end

-- RemoveMedia
function ISRadioAction:isValidRemoveMedia()
    return self.deviceData:hasMedia();
end

function ISRadioAction:performRemoveMedia()
    if self:isValidRemoveMedia() and self.character:getInventory() then
        self.deviceData:removeMediaItem(self.character:getInventory());
    end
end

function ISRadioAction:new(mode, character, device, secondaryItem)
    local o             = {};
    setmetatable(o, self);
    self.__index        = self;
    o.mode              = mode;
    o.character         = character;
    o.device            = device;
    o.deviceData        = device and device:getDeviceData();
    o.secondaryItem     = secondaryItem;

    o.stopOnWalk        = false;
    o.stopOnRun         = true;
    o.maxTime           = 30;
    o.ignoreHandsWounds = true;

    return o;
end
