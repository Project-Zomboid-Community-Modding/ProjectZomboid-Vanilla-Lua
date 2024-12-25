--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemovePatch = ISBaseTimedAction:derive("ISRemovePatch");

function ISRemovePatch:isValid()
    if isClient() and self.clothing and self.needle then
	    return self.character:getInventory():containsID(self.clothing:getID()) and self.character:getInventory():containsID(self.needle:getID()) and self.clothing:getPatchType(self.part) ~= nil
	else
	    return self.character:getInventory():contains(self.clothing) and self.character:getInventory():contains(self.needle) and self.clothing:getPatchType(self.part) ~= nil
	end
end

function ISRemovePatch:update()
	local jobType = getText("ContextMenu_RemovePatch")
	ISGarmentUI.setBodyPartActionForPlayer(self.character, self.part, self, jobType, { })
end

function ISRemovePatch:start()
    if isClient() and self.clothing and self.needle then
        self.clothing = self.character:getInventory():getItemById(self.clothing:getID())
        self.needle = self.character:getInventory():getItemById(self.needle:getID())
    end
	self:setActionAnim("SewingCloth");
	self.sound = self.character:playSound("Sewing")
end

function ISRemovePatch:stop()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
	ISGarmentUI.setBodyPartActionForPlayer(self.character, self.part, nil, nil, nil)
    ISBaseTimedAction.stop(self);
end

function ISRemovePatch:complete()

	self.clothing:removePatch(self.part);

	-- chance to get the patch back
	if ZombRand(100) < ISRemovePatch.chanceToGetPatchBack(self.character) then
		local patch = self.clothing:getPatchType(self.part);
		local fabricType = ClothingPatchFabricType.fromIndex(patch:getFabricType());
		local item = instanceItem(ClothingRecipesDefinitions["FabricType"][fabricType:getType()].material);
		self.character:getInventory():addItem(item);
		sendAddItemToContainer(self.character:getInventory(), item);
		-- doubled because the xp gains from ripping clothing was nerfed
		addXp(self.character, Perks.Tailoring, 6);
	end

	-- doubled because the xp gains from ripping clothing was nerfed
	-- removed random exp because people don't understand how it averages out over time and think it's a bug or bad
	addXp(self.character, Perks.Tailoring, ZombRand(2));
-- 	addXp(self.character, Perks.Tailoring, ZombRand(1, 3));
	syncVisuals(self.character);
	return true;
end

function ISRemovePatch:perform()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
	ISGarmentUI.setBodyPartActionForPlayer(self.character, self.part, nil, nil, nil)
    self.clothing:removePatch(self.part);
	self.character:resetModel();
	triggerEvent("OnClothingUpdated", self.character)

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

ISRemovePatch.chanceToGetPatchBack = function(character)
	local baseChance = 10;
	baseChance = baseChance + (character:getPerkLevel(Perks.Tailoring) * 5);
	return baseChance;
end

function ISRemovePatch:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 150 - (self.character:getPerkLevel(Perks.Tailoring) * 6);
end

function ISRemovePatch:new(character, clothing, part, needle)
	local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.clothing = clothing;
	o.part = part;
	o.needle = needle;
	o.maxTime = o:getDuration();

	return o;
end
