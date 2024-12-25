--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISSplint = ISBaseTimedAction:derive("ISSplint");

function ISSplint:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
    if self.rippedSheet and self.plank then
        if isClient() and self.rippedSheet and self.plank then
            return self.character:getInventory():containsID(self.rippedSheet:getID()) and self.character:getInventory():containsID(self.plank:getID())
        else
            return self.character:getInventory():contains(self.rippedSheet) and self.character:getInventory():contains(self.plank)
        end
    else
        return true
    end
end

function ISSplint:waitToStart()
    if self.character == self.otherPlayer then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISSplint:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    if self.rippedSheet and self.plank then
        self.rippedSheet:setJobDelta(self:getJobDelta());
        self.plank:setJobDelta(self:getJobDelta());
    end
    local jobType = self.doIt and getText("ContextMenu_Splint") or getText("ContextMenu_Remove_Splint")
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, jobType, { splint = true })

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISSplint:start()
    if isClient() and self.rippedSheet and self.plank then
        self.rippedSheet = self.character:getInventory():getItemById(self.rippedSheet:getID())
        self.plank = self.character:getInventory():getItemById(self.plank:getID())
    end
    if self.rippedSheet and self.plank then
        self.rippedSheet:setJobType(self.doIt and getText("ContextMenu_Splint") or getText("ContextMenu_Remove_Splint"));
        self.rippedSheet:setJobDelta(0.0);
        self.plank:setJobType(self.doIt and getText("ContextMenu_Splint") or getText("ContextMenu_Remove_Splint"));
        self.plank:setJobDelta(0.0);
    end
    if self.character == self.otherPlayer then
        self:setActionAnim(CharacterActionAnims.Bandage);
        self:setAnimVariable("BandageType", ISHealthPanel.getBandageType(self.bodyPart));
        self.character:reportEvent("EventBandage");
    else
        self:setActionAnim("Loot")
        self.character:SetVariable("LootPosition", "Mid");
        self.character:reportEvent("EventLootItem");
    end
    self:setOverrideHandModels(nil, nil);
    self.sound = self.character:playSound("FirstAidApplySplint")
end

function ISSplint:stop()
    self:stopSound()
    if self.rippedSheet and self.plank then
        self.rippedSheet:setJobDelta(0.0);
        self.plank:setJobDelta(0.0);
    end
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
end

function ISSplint:perform()
    self:stopSound()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
    if self.rippedSheet and self.plank then
        self.rippedSheet:setJobDelta(0.0);
        self.plank:setJobDelta(0.0);
    end
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
end

function ISSplint:complete()
    -- random a bandage life depending on the doctor skill
    if self.doIt then
        local splintFactor = (self.doctorLevel + 1) / 2;
        if self.bodyPart:isGetSplintXp() then
            addXp(self.character, Perks.Doctor, 15);
        end
        self.bodyPart:setSplint(true, splintFactor);
        if self.rippedSheet then
            self.character:getInventory():Remove(self.rippedSheet);
            if isServer() then
                sendRemoveItemFromContainer(self.character:getInventory(), self.rippedSheet);
            end
        end
        self.character:getInventory():Remove(self.plank);
        if isServer() then
            sendRemoveItemFromContainer(self.character:getInventory(), self.plank);
        end
        self.bodyPart:setSplintItem(self.plank:getModule() .. "." .. self.plank:getType());
    else
        if self.bodyPart:getSplintItem() then
            if self.bodyPart:getSplintItem() ~= "Base.Splint" then
                local item = instanceItem("Base.RippedSheets")
                self.character:getInventory():AddItem(item);
                if isServer() then
                    sendAddItemToContainer(self.character:getInventory(), item);
                end
            end
            local item = self.character:getInventory():AddItem(self.bodyPart:getSplintItem());
            if isServer() then
                sendAddItemToContainer(self.character:getInventory(), item);
            end
        end
        self.bodyPart:setSplint(false, 0);
    end

    -- This number is syncParam, flags are:
    -- BD_splint + BD_splintFactor + BD_splintItem
    syncBodyPart(self.bodyPart, 0x430000000);

    return true;
end

function ISSplint:getDuration()
    return self.maxTime;
end

function ISSplint:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISSplint:new(character, otherPlayer, rippedSheet, plank, bodyPart, doIt)
    local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = character:getPerkLevel(Perks.Doctor);
	o.rippedSheet = rippedSheet;
    o.plank = plank;
    o.doIt = doIt;
    o.doctor = character;
	o.bodyPart = bodyPart;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.maxTime = 140 - (o.doctorLevel * 4);
    if character:isTimedActionInstant() then
        o.maxTime = 1;
    end
    if isMultiplayer() and character:getRole():haveCapability(Capability.CanMedicalCheat) then
        o.doctorLevel = 10;
    end
	return o;
end
