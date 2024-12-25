--***********************************************************
--**                    Erasmus Crowley                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDumpContentsAction = ISBaseTimedAction:derive("ISDumpContentsAction");

function ISDumpContentsAction:isValid()
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISDumpContentsAction:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

    if self.item ~= nil then
	    self.item:setJobType(getText("IGUI_JobType_PourOut"));
	    self.item:setJobDelta(0.0);
	
		self:setActionAnim(CharacterActionAnims.Pour);
		self:setAnimVariable("PourType", self.item:getPourType());
		self:setOverrideHandModels(self.item, nil);
	
		self.character:reportEvent("EventTakeWater");

		self.sound = self.character:playSound(self.item:getPourLiquidOnGroundSound())
    end
end

function ISDumpContentsAction:update()
	if self.item ~= nil then
        self.item:setJobDelta(self:getJobDelta());
    end
end

function ISDumpContentsAction:stop()
	self:stopSound()
    if self.item ~= nil then
        self.item:setJobDelta(0.0);
     end
    ISBaseTimedAction.stop(self);
end

function ISDumpContentsAction:perform()
	self:stopSound()
	if self.item ~= nil then
		self.item:getContainer():setDrawDirty(true);
		self.item:setJobDelta(0.0);
	end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDumpContentsAction:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

	-- RemouladeFull -> RemouladeHalf -> RemouladeEmpty
function ISDumpContentsAction:finalItem(itemType)
	local item = ScriptManager.instance:FindItem(itemType)
	if item == nil then return nil end
	if item:getReplaceOnUse() then
		itemType = moduleDotType(item:getModuleName(), item:getReplaceOnUse())
		return self:finalItem(itemType)
	end
	if (item:getType() == Type.Drainable) and item:getReplaceOnDeplete() then
		itemType = moduleDotType(item:getModuleName(), item:getReplaceOnDeplete())
		return self:finalItem(itemType)
	end
	return nil
end

function ISDumpContentsAction:complete()
	if self.item ~= nil then
		local itemType = self:finalItem(self.item:getFullType())
		if itemType then
			if self.item:getReplaceOnUse() then
				self.item:setReplaceOnUse(itemType)
			elseif instanceof(self.item, "DrainableComboItem") and self.item:getReplaceOnDeplete() then
				self.item:setReplaceOnDeplete(itemType)
				self.item:setUseDelta(1)
			end
		end
		self.item:UseAndSync();
	end

	return true;
end

function ISDumpContentsAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 100
end

function ISDumpContentsAction:new (character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.stopOnWalk = false;
	o.stopOnRun = false;
	o.maxTime = o:getDuration();
	return o
end
