require "TimedActions/ISBaseTimedAction"

ISLightActions = ISBaseTimedAction:derive("ISLightActions");
ISLightActions.perkLevel = 5; --Electrical perkLevel needed for modifying lamps

function ISLightActions:isValid()
    if isClient() then return true end
    if self.character and self.lightswitch and self.mode then
        if self["isValid"..self.mode] then
            return self["isValid"..self.mode](self);
        end
    end
end

function ISLightActions:perform()
    if self.character and self.lightswitch and self.mode then
        if self["perform"..self.mode] then
            self["perform"..self.mode](self);
        end
    end

    ISBaseTimedAction.perform(self)
end

function ISLightActions:complete()
    if self.character and self.lightswitch and self.mode then
        if self["complete"..self.mode] then
            self["complete"..self.mode](self);
        end
    end

    buildUtil.setHaveConstruction(self.square, true);
    return true;
end

function ISLightActions:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    if self.mode=="AddLightBulb" or self.mode=="RemoveLightBulb" then
        return 120;
    elseif self.mode=="AddBattery" or self.mode=="RemoveBattery" then
        return 60;
    end
    return 300
end

-- AddLightBulb
function ISLightActions:isValidAddLightBulb()
    return self.item and self.lightswitch:getCanBeModified() and self.lightswitch:hasLightBulb()==false;
end

function ISLightActions:completeAddLightBulb()
    if self:isValidAddLightBulb() then
        self.lightswitch:addLightBulb(self.character, self.item);
    end
end

-- RemoveLightBulb
function ISLightActions:isValidRemoveLightBulb()
    return self.lightswitch:getCanBeModified() and self.lightswitch:hasLightBulb();
end

function ISLightActions:completeRemoveLightBulb()
    if self:isValidRemoveLightBulb() then
        self.lightswitch:removeLightBulb(self.character);
    end
end

-- ModifyLamp
function ISLightActions:isValidModifyLamp()
    return self.item and self.lightswitch:getCanBeModified() and self.lightswitch:getUseBattery()==false and self.character:getPerkLevel(Perks.Electricity) >= ISLightActions.perkLevel;
end

function ISLightActions:completeModifyLamp()
    if self:isValidModifyLamp() and self.character:getInventory():contains(self.item) and self.item:getFullType()=="Base.ElectronicsScrap" then
        self.character:removeFromHands(self.item)
        self.character:getInventory():Remove(self.item);
        sendRemoveItemFromContainer(self.character:getInventory(), self.item);

        self.lightswitch:setUseBattery(true);
    end
end

-- AddBattery
function ISLightActions:isValidAddBattery()
    return self.item and self.lightswitch:getCanBeModified() and self.lightswitch:getUseBattery() and self.lightswitch:getHasBattery()==false;
end

function ISLightActions:completeAddBattery()
    if self:isValidAddBattery() then
        self.lightswitch:addBattery(self.character, self.item);
    end
end

-- RemoveLightBulb
function ISLightActions:isValidRemoveBattery()
    return self.lightswitch:getCanBeModified() and self.lightswitch:getUseBattery() and self.lightswitch:getHasBattery();
end

function ISLightActions:completeRemoveBattery()
    if self:isValidRemoveBattery() then
        self.lightswitch:removeBattery(self.character);
    end
end

function ISLightActions:new(mode, character, lightswitch, item)
    local o = ISBaseTimedAction.new(self, character);
    o.mode              = mode;
    o.lightswitch       = lightswitch;
    o.item              = item;
    o.maxTime           = o:getDuration()
    o.ignoreHandsWounds = true;

    return o;
end
