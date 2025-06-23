require "TimedActions/ISBaseTimedAction"

ISUpgradeWeapon = ISBaseTimedAction:derive("ISUpgradeWeapon");

local function predicateNotBroken(item)
    return not item:isBroken()
end

function ISUpgradeWeapon:isValid()
    if not self.part:canAttach(self.character, self.weapon) then return false end
    -- if not self.character:getInventory():containsTagEval("Screwdriver", predicateNotBroken) then return false end
    if self.weapon:getWeaponPart(self.part:getPartType()) then return false end
    if isClient() and self.part and self.weapon then
        return self.character:getInventory():containsID(self.part:getID()) and self.character:getInventory():containsID(self.weapon:getID());
    else
        return self.character:getInventory():contains(self.part);
    end
end

function ISUpgradeWeapon:update()
    self.weapon:setJobDelta(self:getJobDelta());
    self.part:setJobDelta(self:getJobDelta());

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISUpgradeWeapon:start()
    if isClient() then
        if self.part then
            self.part = self.character:getInventory():getItemById(self.part:getID())
        end
        if self.weapon then
            self.weapon = self.character:getInventory():getItemById(self.weapon:getID())
        end
    end
    self.weapon:setJobType(getText("ContextMenu_Add_Weapon_Upgrade"));
    self.weapon:setJobDelta(0.0);
    self.part:setJobType(getText("ContextMenu_Add_Weapon_Upgrade"));
    self.part:setJobDelta(0.0);
end

function ISUpgradeWeapon:stop()
    ISBaseTimedAction.stop(self);
    self.weapon:setJobDelta(0.0);
    self.part:setJobDelta(0.0);
end

function ISUpgradeWeapon:perform()
    self.weapon:setJobDelta(0.0);
    self.part:setJobDelta(0.0);
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISUpgradeWeapon:complete()
    self.weapon:attachWeaponPart(self.character, self.part)
    syncHandWeaponFields(self.character, self.weapon)
    self.character:getInventory():Remove(self.part);
    sendRemoveItemFromContainer(self.character:getInventory(), self.part);
    self.character:setSecondaryHandItem(nil);
    return true
end

function ISUpgradeWeapon:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 50
end

function ISUpgradeWeapon:new(character, weapon, part)
    local o = ISBaseTimedAction.new(self, character)
    o.weapon = weapon;
    o.part = part;
    o.maxTime = o:getDuration();
    return o;
end
