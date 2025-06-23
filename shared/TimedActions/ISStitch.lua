--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISStitch = ISBaseTimedAction:derive("ISStitch");

function ISStitch:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
    if self.item then
        if isClient() then
            return self.character:getInventory():containsID(self.item:getID())
        else
            return self.character:getInventory():contains(self.item)
        end
    else
        if not self.bodyPart:stitched() then return false end
        return true
    end
end

function ISStitch:waitToStart()
    if self.character == self.otherPlayer then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISStitch:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    if self.item then
        self.item:setJobDelta(self:getJobDelta());
    end
    local jobType = self.doIt and getText("ContextMenu_Stitch") or getText("ContextMenu_Remove_Stitch")
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, jobType, { stitch = true })

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISStitch:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
    if self.item then
        self.item:setJobType(self.doIt and getText("ContextMenu_Stitch") or getText("ContextMenu_Remove_Stitch"));
        self.item:setJobDelta(0.0);
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
    self.sound = self.character:playSound("FirstAidApplyStitch")
end

function ISStitch:stop()
    self:stopSound()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
    if self.item then
        self.item:setJobDelta(0.0);
    end
end

function ISStitch:perform()
    self:stopSound()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
    if self.item then
        self.item:setJobDelta(0.0);
    end

    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
end


function ISStitch:complete()
    local basePain = 20;
    if self.doIt then
        if self.character:getInventory():contains("SutureNeedleHolder") or self.item:getType() == "SutureNeedle" then
            basePain = 10;
        end
    else
        basePain = 5;
    end

    if self.character:HasTrait("Hemophobic") then
        self.character:getStats():setPanic(self.character:getStats():getPanic() + 50);
        --Stat_Panic
        syncPlayerStats(self.character, 0x00000100);
    end

    if self.item ~= nil then
        self.item:UseAndSync();
    end

    if self.bodyPart:isGetStitchXp() then
        addXp(self.character, Perks.Doctor, 15);
    end

    self.bodyPart:setStitched(self.doIt);

    local endPain = (basePain - (self.doctorLevel * 1));
    if endPain < 0 then
        endPain = 0;
    end
    if not (isMultiplayer() and self.doctor:getRole():hasCapability(Capability.CanMedicalCheat)) then
        self.bodyPart:setAdditionalPain(self.bodyPart:getAdditionalPain() + endPain);
    end
    -- boost the stitch depending on the doctor's level
    if self.doIt then
        self.bodyPart:setStitchTime(((1 + self.doctorLevel) / 2) * ZombRandFloat(2.0, 5.0));
    end

    -- chance of wound infection
    if ZombRand(5 + self.doctorLevel * 2.5) == 0 then
        self.bodyPart:setInfectedWound(true);
    end

    -- this number is syncPart param, flags are:
    -- BD_additionalPain + BD_stitched + BD_infectedWound + BD_stitchTime +
    -- BD_bleeding + BD_bleedingTime + BD_deepWounded + BD_deepWoundTime
    syncBodyPart(self.bodyPart, 0x00570188);

	return true;
end

function ISStitch:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISStitch:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    local baseTime = 200;
    -- a suture needle or a suture needle holder make it faster and less painy
    if self.character:getInventory():contains("SutureNeedleHolder") or (self.item and self.item:getType() == "SutureNeedle") then
        baseTime = 150;
    end

    return baseTime - (self.doctorLevel * 4);
end

function ISStitch:new(character, otherPlayer, item, bodyPart, doIt)
	local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = character:getPerkLevel(Perks.Doctor);
    o.item = item;
    o.doIt = doIt;
	o.bodyPart = bodyPart;
    o.doctor = character;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.maxTime = o:getDuration();

    if isMultiplayer() and character:getRole():hasCapability(Capability.CanMedicalCheat) then
        o.doctorLevel = 10;
    end
	return o;
end
