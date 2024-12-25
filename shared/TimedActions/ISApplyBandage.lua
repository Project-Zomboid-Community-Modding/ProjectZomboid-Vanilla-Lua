--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISApplyBandage = ISBaseTimedAction:derive("ISApplyBandage");

function ISApplyBandage:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
    if self.item then
        if isClient() and self.item then
            return self.character:getInventory():containsID(self.item:getID())
        else
            return self.character:getInventory():contains(self.item)
        end
    else
        if not self.bodyPart:bandaged() then return false end
        return true
    end
end

function ISApplyBandage:waitToStart()
    if self.character == self.otherPlayer or self.character:isSeatedInVehicle() then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISApplyBandage:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    if self.item then
        self.item:setJobDelta(self:getJobDelta());
    end
    local jobType = self.doIt and getText("ContextMenu_Bandage") or getText("ContextMenu_Remove_Bandage")
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, jobType, { bandage = true })
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISApplyBandage:start()

    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end

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
    if self.item then
        self.item:setJobType(getText("ContextMenu_Apply_Bandage"));
        self.item:setJobDelta(0.0);
    end
    self.sound = self.character:playSound("FirstAidApplyBandage")
    if self.doIt or self.bodyPart:HasInjury() then
        self.sound2 = self.character:playerVoiceSound("ApplyBandage")
    end
end

function ISApplyBandage:stop()
    self:stopSound()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
    if self.item then
        self.item:setJobDelta(0.0);
    end
end

function ISApplyBandage:perform()
    self:stopSound()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
    if self.item then
        self.item:setJobDelta(0.0);
    end

    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
end

function ISApplyBandage:complete()
    if self.character:HasTrait("Hemophobic") and self.bodyPart:getBleedingTime() > 0 then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50);
        --Stat_Panic
        syncPlayerStats(self.character, 0x00000100);
    end
    -- random a bandage life depending on the doctor skill
    if self.doIt then
        local bandageLife = ZombRandFloat((self.doctorLevel + 1) * 0.5, (self.doctorLevel + 1) * 1.0) + self.item:getBandagePower();
        if string.match(self.item:getType(), "Dirty") then
            bandageLife = 0;
        end
        if self.bodyPart:isGetBandageXp() and bandageLife > 0 then
            addXp(self.character, Perks.Doctor, 5);
        end
        self.otherPlayer:getBodyDamage():SetBandaged(self.bodyPart:getIndex(), true, bandageLife, self.item:isAlcoholic(), self.item:getModule() .. "." .. self.item:getType());
        self.character:getInventory():Remove(self.item);
        if isServer() then
            sendRemoveItemFromContainer(self.character:getInventory(), self.item);
        end

        if self.item:isInfected() then
            self.bodyPart:SetInfected(true);
        end
    else
        if self.bodyPart:getBandageType() then
            local bandage = instanceItem(self.bodyPart:getBandageType())
            self.character:getInventory():AddItem(bandage);

            if isServer() then
                sendAddItemToContainer(self.character:getInventory(), bandage);
            end

            if self.bodyPart:getBandageLife() <= 0 then
                bandage:UseAndSync();
            end
        end
        self.otherPlayer:getBodyDamage():SetBandaged(self.bodyPart:getIndex(), false, 0, false, nil);
    end

    -- This number is syncParam, flags are:
    -- BD_Bandaged + BD_bleeding + BD_IsInfected + BD_bitten + BD_cut + BD_alcoholicBandage + BD_stitched + BD_deepWounded
    -- BD_bandageType + BD_getBandageXp + BD_bandageLife + corresponding _Time flags
    syncBodyPart(self.bodyPart, 0xc001966b8e);

    return true;
end

function ISApplyBandage:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    return 120 - (self.doctorLevel * 4);
end

function ISApplyBandage:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
    if self.sound2 and self.character:getEmitter():isPlaying(self.sound2) then
        self.character:stopOrTriggerSound(self.sound2);
    end
end

function ISApplyBandage:new(character, otherPlayer, item, bodyPart, doIt)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = character:getPerkLevel(Perks.Doctor);
	o.item = item;
    o.doIt = doIt;
	o.bodyPart = bodyPart;
	o.stopOnWalk = bodyPart:getIndex() > BodyPartType.ToIndex(BodyPartType.Groin);
	o.stopOnRun = true;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.maxTime = o:getDuration();
    if character:isTimedActionInstant() then
        o.doctorLevel = 10;
    end
	return o;
end
