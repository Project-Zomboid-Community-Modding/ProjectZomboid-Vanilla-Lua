--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCutHair = ISBaseTimedAction:derive("ISCutHair");

function ISCutHair:isValid()
	return true;
end

function ISCutHair:update()
	if self.item then
		self.item:setJobDelta(self:getJobDelta());
	end
end

function ISCutHair:start()
	if self.item then
		self.item:setJobType(getText("ContextMenu_CutHair"));
		self.item:setJobDelta(0.0);
	end
	self.sound = self.character:playSound("HairCutScissors")
--	self:setActionAnim(CharacterActionAnims.Shave)
--	self:setOverrideHandModels("DisposableRazor", nil)
end

function ISCutHair:stop()
	self:stopSound()
	if self.item then
		self.item:setJobDelta(0.0);
	end
    ISBaseTimedAction.stop(self);
end

function ISCutHair:perform()
	self:stopSound()
	if self.item then
		self.item:setJobDelta(0.0);
	end

	triggerEvent("OnClothingUpdated", self.character)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISCutHair:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISCutHair:complete()
	local newHairStyle = getHairStylesInstance():FindMaleStyle(self.hairStyle)
	if self.character:isFemale() then
		newHairStyle = getHairStylesInstance():FindFemaleStyle(self.hairStyle)
	end

	if newHairStyle:getName():contains("Bald") then
		self.character:getHumanVisual():setHairColor(self.character:getHumanVisual():getNaturalHairColor())
	end

	-- if we're attaching our hair we need to set the non attached model, or if we untie, we reset our model
	if newHairStyle:isAttachedHair() and not self.character:getHumanVisual():getNonAttachedHair() then
		self.character:getHumanVisual():setNonAttachedHair(self.character:getHumanVisual():getHairModel());
	end
	if self.character:getHumanVisual():getNonAttachedHair() and not newHairStyle:isAttachedHair() then
		self.character:getHumanVisual():setNonAttachedHair(nil);
	end
	self.character:getHumanVisual():setHairModel(self.hairStyle);
	self.character:resetModel();
	self.character:resetHairGrowingTime();

	-- reduce hairgel for mohawk
	if (newHairStyle:getName():contains("Mohawk") or newHairStyle:getName():contains("Spike") or newHairStyle:getName():contains("GreasedBack")) and newHairStyle:getName() ~= "MohawkFlat" then
		local hairgel = self.character:getInventory():getItemFromType("Hairgel", true, true) or self.character:getInventory():getItemFromType("Hairspray2", true, true) or self.character:getInventory():getFirstTagRecurse("DoHairdo");
		if hairgel then
			hairgel:UseAndSync();
		end
	end
	-- reduce hairspray for buffant
	if newHairStyle:getName():contains("Buffont") then
		local hairspray = self.character:getInventory():getItemFromType("Hairspray2", true, true)
		if hairspray then
			hairspray:UseAndSync();
		end
	end
	-- reduce hairgel for greased
	if newHairStyle:getName():contains("Greased") then
		local hairgel = self.character:getInventory():getItemFromType("Hairgel", true, true) or self.character:getInventory():getFirstTagRecurse("SlickHair")
		if hairgel then
			hairgel:UseAndSync();
		end
	end
	sendHumanVisual(self.character)
	return true
end

function ISCutHair:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end

	return self.maxTime
end

function ISCutHair:new(character, hairStyle, item, maxTime)
	local o = ISBaseTimedAction.new(self, character)
	o.hairStyle = hairStyle or "";
	o.item = item;
	o.maxTime = maxTime;
	return o;
end
