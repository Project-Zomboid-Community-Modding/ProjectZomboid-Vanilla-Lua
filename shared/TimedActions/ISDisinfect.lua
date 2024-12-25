--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDisinfect = ISBaseTimedAction:derive("ISDisinfect");

function ISDisinfect:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
	if isClient() and self.alcohol then
	    return self.character:getInventory():containsID(self.alcohol:getID())
	else
	    return self.character:getInventory():contains(self.alcohol)
	end
end

function ISDisinfect:waitToStart()
    if self.character == self.otherPlayer then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISDisinfect:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    local jobType = getText("ContextMenu_Disinfect")
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, jobType, { disinfect = true })

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISDisinfect:start()
    if isClient() and self.alcohol then
        self.alcohol = self.character:getInventory():getItemById(self.alcohol:getID())
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
    if self.alcohol ~= nil and self.alcohol:getFullType() == "Base.AlcoholWipes" then
        self.sound = self.character:playSound("FirstAidApplyAlcoholWipes")
    else
        self.sound = self.character:playSound("FirstAidApplyAlcohol")
    end
end

function ISDisinfect:stop()
    self:stopSound()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
end

function ISDisinfect:perform()
    self:stopSound()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISDisinfect:complete()
    self.bodyPart:setAlcoholLevel(self.bodyPart:getAlcoholLevel() + self.alcohol:getAlcoholPower());
    local addPain = (self.alcohol:getAlcoholPower() * 13) - (self.doctorLevel / 2)
    if not (isMultiplayer() and self.doctor:getRole():haveCapability(Capability.CanMedicalCheat)) then
        self.bodyPart:setAdditionalPain(self.bodyPart:getAdditionalPain() + addPain);
    end
    if self.alcohol:hasComponent(ComponentType.FluidContainer) and self.alcohol:getFluidContainer():getAmount() > 0.15 then
		self.alcohol:getFluidContainer():adjustAmount(self.alcohol:getFluidContainer():getAmount() - 0.15);
    elseif instanceof(self.alcohol, "DrainableComboItem") then
        self.alcohol:UseAndSync();
    end

    -- This number is syncParam, flags are:
    -- BD_alcoholLevel + BD_additionalPain + BD_IsInfected + BD_WoundInfectionLevel
    syncBodyPart(self.bodyPart, 0x00608200);

    return true;
end

function ISDisinfect:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    return 120 - (self.doctorLevel * 4);
end

function ISDisinfect:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISDisinfect:new(character, otherPlayer, alcohol, bodyPart)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.doctor = character;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = character:getPerkLevel(Perks.Doctor);
	o.alcohol = alcohol;
	o.bodyPart = bodyPart;
	o.stopOnWalk = bodyPart:getIndex() > BodyPartType.ToIndex(BodyPartType.Groin);
	o.stopOnRun = true;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.maxTime = o:getDuration();

	return o;
end
