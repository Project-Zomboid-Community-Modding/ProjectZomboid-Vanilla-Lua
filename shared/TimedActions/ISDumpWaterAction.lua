--***********************************************************
--**                    Erasmus Crowley                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDumpWaterAction = ISBaseTimedAction:derive("ISDumpWaterAction");

function ISDumpWaterAction:isValid()
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISDumpWaterAction:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

    if self.item ~= nil then
	    self.item:setJobType(getText("IGUI_JobType_PourOut"));
	    self.item:setJobDelta(0.0);
		if instanceof(self.item, "DrainableComboItem") then
			self.startUsedDelta = self.item:getCurrentUsesFloat();
		elseif self.item:getFluidContainer() then
			self.startUsedDelta = self.item:getFluidContainer():getAmount();
		end
	
		self:setActionAnim(CharacterActionAnims.Pour);
		self:setAnimVariable("PourType", self.item:getPourType());
		self:setOverrideHandModels(self.item, nil);
	
		self.character:reportEvent("EventTakeWater");

		self.sound = self.character:playSound(self.item:getPourLiquidOnGroundSound())
    end
end

function ISDumpWaterAction:updateDumpingWater()
    local progress
    if not isServer() then
        progress = self:getJobDelta()
    else
        progress = self.netAction:getProgress()
    end
    if instanceof(self.item, "DrainableComboItem") then
        self.item:setUsedDelta(self.startUsedDelta * (1 - progress));
    elseif self.item:getFluidContainer() then
        self.item:getFluidContainer():removeFluid(self.startUsedDelta / self.maxTime);
    end
end

function ISDumpWaterAction:update()
	if self.item ~= nil then
        self.item:setJobDelta(self:getJobDelta());
        if not isClient() then
            self:updateDumpingWater();
        end
    end
end

function ISDumpWaterAction:animEvent(event, parameter)
	if isServer() then
		if event == 'DumpingWaterUpdate' then
			self:updateDumpingWater()
			sendItemStats(self.item)
		end
	end
end

function ISDumpWaterAction:serverStart()
	emulateAnimEvent(self.netAction, 100, "DumpingWaterUpdate", nil)
	if self.item then
	    if instanceof(self.item, "DrainableComboItem") then
            self.startUsedDelta = self.item:getCurrentUsesFloat();
        elseif self.item:getFluidContainer() then
            self.startUsedDelta = self.item:getFluidContainer():getAmount();
        end
	end
end

function ISDumpWaterAction:stop()
	self:stopSound()
    if self.item ~= nil then
        self.item:setJobDelta(0.0);
     end
    ISBaseTimedAction.stop(self);
end

function ISDumpWaterAction:perform()
	self:stopSound()
	if self.item ~= nil then
        self.item:setJobDelta(0.0);
     end
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDumpWaterAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISDumpWaterAction:complete()
	if self.item ~= nil then
		self.item:getContainer():setDrawDirty(true);
		self.item:setJobDelta(0.0);
		if instanceof(self.item, "DrainableComboItem") then
			self.item:setUsedDelta(0.0);
			self.item:Use(false, false, true);
		elseif self.item:getFluidContainer() then
			self.item:getFluidContainer():Empty();
		end
	end

	return true
end

function ISDumpWaterAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	local maxTime = 10;
	if instanceof(self.item, "DrainableComboItem") then
		maxTime = self.item:getCurrentUses() * 10;
	elseif self.item:getFluidContainer() then
		maxTime = self.item:getFluidContainer():getAmount();
	end
	if maxTime > 150 then
		maxTime = 150;
	end
	if maxTime < 30 then
		maxTime = 30;
	end

	return maxTime
end

function ISDumpWaterAction:new (character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.character = character;
	o.item = item;
	o.stopOnWalk = false;
	o.stopOnRun = false;
	o.maxTime = o:getDuration();
	return o
end
