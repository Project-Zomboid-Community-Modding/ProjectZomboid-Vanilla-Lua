--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGarlicCataplasm = ISBaseTimedAction:derive("ISGarlicCataplasm");

function ISGarlicCataplasm:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISGarlicCataplasm:waitToStart()
    if self.character == self.otherPlayer then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISGarlicCataplasm:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    self.item:setJobDelta(self:getJobDelta());
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, getText("IGUI_JobType_ApplyCataplasm"), { garlic = true })
end

function ISGarlicCataplasm:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end

    self.item:setJobType(getText("IGUI_JobType_ApplyCataplasm"));
    self.item:setJobDelta(0.0);
    if self.character == self.otherPlayer then
        self:setActionAnim(CharacterActionAnims.Bandage);
        self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(self.bodyPart));
        self.character:reportEvent("EventBandage");
    else
        self:setActionAnim("Loot")
        self.character:SetVariable("LootPosition", "Mid")
        self.character:reportEvent("EventLootItem");
    end
    self:setOverrideHandModels(nil, nil);
end

function ISGarlicCataplasm:stop()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
    self.item:setJobDelta(0.0);
end

function ISGarlicCataplasm:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
    self.item:setJobDelta(0.0);
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
end

function ISGarlicCataplasm:complete()
    if self.character:HasTrait("Hemophobic") and self.bodyPart:getBleedingTime() > 0 then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50);
        --Stat_Panic
        syncPlayerStats(self.character, 0x00000100);
    end

    local cataplasmPower = ZombRandFloat((self.doctorLevel + 1) * 0.5, (self.doctorLevel + 1) * 1.0) + 10;
    self.bodyPart:setGarlicFactor(cataplasmPower);
    self.character:getInventory():Remove(self.item);
    if isServer() then
        sendRemoveItemFromContainer(self.character:getInventory(), self.item);
    end
    -- This number is syncParam, flags are:
    -- BD_garlicFactor
    syncBodyPart(self.bodyPart, 0x0000002000000000);

    return true;
end

function ISGarlicCataplasm:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    return 120 - (self.doctorLevel * 4);
end

function ISGarlicCataplasm:new(character, otherPlayer, item, bodyPart)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = character:getPerkLevel(Perks.Doctor);
	o.item = item;
	o.bodyPart = bodyPart;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.maxTime = o:getDuration();

    if isMultiplayer() and character:getRole():hasCapability(Capability.CanMedicalCheat) then
        o.doctorLevel = 10;
    end
	return o;
end
