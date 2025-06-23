--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveGlass = ISBaseTimedAction:derive("ISRemoveGlass");

function ISRemoveGlass:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
	return true
end

function ISRemoveGlass:waitToStart()
    if self.character == self.otherPlayer then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISRemoveGlass:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    local jobType = getText("ContextMenu_Remove_Glass")
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, jobType, { removeGlass = true })

    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISRemoveGlass:start()
    if self.character == self.otherPlayer then
        self:setActionAnim(CharacterActionAnims.Bandage);
        self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(self.bodyPart));
    else
        self:setActionAnim("Loot")
        self.character:SetVariable("LootPosition", "Mid")
    end
    self:setOverrideHandModels(nil, nil);
    self.sound = self.character:playSound("FirstAidRemoveFromWound")
end

function ISRemoveGlass:stop()
    self:stopSound()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
end

function ISRemoveGlass:perform()
    self:stopSound()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);

    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
end

function ISRemoveGlass:complete()
    if self.character:HasTrait("Hemophobic") then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50);
        --Stat_Panic
        syncPlayerStats(self.character, 0x00000100);
    end

    addXp(self.character, Perks.Doctor, 15);

    local addPain = (30 - (self.doctorLevel * 1))
    if not (isMultiplayer() and self.doctor:getRole():hasCapability(Capability.CanMedicalCheat)) then
        self.bodyPart:setAdditionalPain(self.bodyPart:getAdditionalPain() + addPain);
    end

    if self.handPain then
        self.bodyPart:setAdditionalPain(self.bodyPart:getAdditionalPain() + 30);
    end
    self.bodyPart:setHaveGlass(false);

    -- This number is syncParam, flags are:
    -- BD_additionalPain + BD_haveGlass
    syncBodyPart(self.bodyPart, 0x00480000);

    return true;
end

function ISRemoveGlass:getDuration()
    if (isMultiplayer() and self.character:getRole():hasCapability(Capability.CanMedicalCheat)) or self.character:isTimedActionInstant() then
        return 1;
    end

    if self.handPain then
        return 300 - (self.doctorLevel * 4)
    else
        return 150 - (self.doctorLevel * 4);
    end
end

function ISRemoveGlass:stopSound()
    if self.sound and self.character:getEmitter():isPlaying(self.sound) then
        self.character:stopOrTriggerSound(self.sound);
    end
end

function ISRemoveGlass:new(character, otherPlayer, bodyPart, handPain)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = character:getPerkLevel(Perks.Doctor);
	o.bodyPart = bodyPart;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.doctor = character;
    o.handPain = handPain;

    if isMultiplayer() and character:getRole():hasCapability(Capability.CanMedicalCheat) then
        o.doctorLevel = 10;
    end

    o.maxTime = o:getDuration();

    return o;
end