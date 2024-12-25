--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveBullet = ISBaseTimedAction:derive("ISRemoveBullet");

function ISRemoveBullet:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
	return true
end

function ISRemoveBullet:waitToStart()
    if self.character == self.otherPlayer then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISRemoveBullet:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    local jobType = getText("ContextMenu_Remove_Bullet")
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, jobType, { removeBullet = true })

    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISRemoveBullet:start()
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
    self.sound = self.character:playSound("FirstAidRemoveFromWound")
end

function ISRemoveBullet:stop()
    self:stopSound()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
end

function ISRemoveBullet:perform()
    self:stopSound()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);

    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
end

function ISRemoveBullet:complete()
    if self.character:HasTrait("Hemophobic") then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50);
        --Stat_Panic
        syncPlayerStats(self.character, 0x00000100);
    end

    addXp(self.character, Perks.Doctor, 20);

    local addPain = (80 - (self.doctorLevel * 1))
    self.bodyPart:setAdditionalPain(self.bodyPart:getAdditionalPain() + addPain);
    self.bodyPart:setHaveBullet(false, self.doctorLevel);

    -- This number is syncParam, flags are:
    -- BD_additionalPain + BD_bleedingTime + BD_bleeding + BD_haveBullet + BD_deepWounded + BD_deepWoundTime
    syncBodyPart(self.bodyPart, 0x40460108);

    return true;
end

function ISRemoveBullet:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    return 250 - (self.doctorLevel * 6);
end

function ISRemoveBullet:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound);
    end
end

function ISRemoveBullet:new(character, otherPlayer, bodyPart)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.doctor = character;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = character:getPerkLevel(Perks.Doctor);
	o.bodyPart = bodyPart;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.maxTime = o:getDuration();
    if isMultiplayer() and character:getRole():haveCapability(Capability.CanMedicalCheat) then
        o.doctorLevel = 10;
    end
    return o;
end
