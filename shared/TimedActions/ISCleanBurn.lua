--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCleanBurn = ISBaseTimedAction:derive("ISCleanBurn");

function ISCleanBurn:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
	return true
end

function ISCleanBurn:waitToStart()
    if self.character == self.otherPlayer then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISCleanBurn:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    local jobType = getText("ContextMenu_Clean_Burn")
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, jobType, { cleanBurn = true })
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISCleanBurn:start()
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
    self.sound = self.character:playSound("FirstAidCleanBurn")
end

function ISCleanBurn:stop()
    self:stopSound()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
end

function ISCleanBurn:perform()
    self:stopSound()
    if self.item then
        self.item:setJobDelta(0.0);
    end
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISCleanBurn:complete()
    if self.character:HasTrait("Hemophobic") then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50);
        --Stat_Panic
        syncPlayerStats(self.character, 0x00000100);
    end

    addXp(self.character, Perks.Doctor, 10);

    local addPain = (60 - (self.doctorLevel * 1))
    self.bodyPart:setAdditionalPain(self.bodyPart:getAdditionalPain() + addPain);
    self.bodyPart:setNeedBurnWash(false);
    self.bandage:UseAndSync();

    -- this number is syncPart param, flags are:
    -- BD_additionalPain + BD_needBurnWash + BD_lastTimeBurnWash + BD_burnTime
    syncBodyPart(self.bodyPart, 0x380400000);

    return true;
end

function ISCleanBurn:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    return 250 - (self.doctorLevel * 6);
end

function ISCleanBurn:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISCleanBurn:new(character, otherPlayer, bandage, bodyPart)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = character:getPerkLevel(Perks.Doctor);
	o.bodyPart = bodyPart;
    o.bandage = bandage;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.maxTime = o:getDuration();
    if isMultiplayer() and character:getRole():haveCapability(Capability.CanMedicalCheat) then
        o.doctorLevel = 10;
    end
	return o;
end
