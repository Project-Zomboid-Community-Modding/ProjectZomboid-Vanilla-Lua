--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPlasterAction = ISBaseTimedAction:derive("ISPlasterAction");

function ISPlasterAction:isValid()
	return ISBuildMenu.cheat or self.character:getInventory():contains("BucketPlasterFull");
end

function ISPlasterAction:update()
    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISPlasterAction:start()
	self.sound = self.character:playSound("Plastering")
end

function ISPlasterAction:stop()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
    ISBaseTimedAction.stop(self);
end

function ISPlasterAction:perform()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPlasterAction:complete()
	if self.thumpable then
		local modData = self.thumpable:getModData();
		local north = "";
		if self.thumpable:getNorth() then
			north = "North";
		end
		local sprite = Painting[modData["wallType"]]["plasterTile" .. north];

		self.thumpable:setSprite(sprite)
		self.thumpable:setPaintable(true)
		self.thumpable:transmitUpdatedSpriteToClients()
		self.thumpable:sendObjectChange("paintable")

		if not self.character:isBuildCheat() then
			self.plasterBucket:Use();
		end

		return true
	end
	return false
end

function ISPlasterAction:getDuration()
	if self.character:isTimedActionInstant() or self.character:isBuildCheat() then
		return 1;
	end
	return 100
end

function ISPlasterAction:new(character, thumpable, plasterBucket)
	local o = ISBaseTimedAction.new(self, character)
	o.thumpable = thumpable;
	o.plasterBucket = plasterBucket;
	o.maxTime = o:getDuration();
    o.caloriesModifier = 8;
	return o;
end
