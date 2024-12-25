--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRepairClothing = ISBaseTimedAction:derive("ISRepairClothing");

function ISRepairClothing:isValid()
    if isClient() then
		if self.started then
			return true
		else
			return self.character:getInventory():containsID(self.clothing:getID()) and
					self.character:getInventory():containsID(self.fabric:getID()) and
					self.character:getInventory():containsID(self.needle:getID()) and
					self.character:getInventory():containsID(self.thread:getID()) and
					(self.clothing:getPatchType(self.part) == nil)
		end
    else
        return self.character:getInventory():contains(self.clothing) and
            self.character:getInventory():contains(self.fabric) and
            self.character:getInventory():contains(self.needle) and
            self.character:getInventory():contains(self.thread) and
            (self.clothing:getPatchType(self.part) == nil)
    end
end

function ISRepairClothing:update()
	local hole = self.clothing:getVisual():getHole(self.part)
	local jobType = hole and getText("ContextMenu_PatchHole") or getText("ContextMenu_AddPadding")
	ISGarmentUI.setBodyPartActionForPlayer(self.character, self.part, self, jobType, { })
    local skill = self.character:getPerkLevel(Perks.Tailoring)
    local strain = (1 - (skill * 0.05))/10 * getGameTime():getMultiplier()
    self.character:addNeckMuscleStrain(strain)
end

function ISRepairClothing:start()
    if isClient() and self.clothing and self.fabric and self.needle and self.thread then
        self.clothing = self.character:getInventory():getItemById(self.clothing:getID())
        self.fabric = self.character:getInventory():getItemById(self.fabric:getID())
        self.needle = self.character:getInventory():getItemById(self.needle:getID())
        self.thread = self.character:getInventory():getItemById(self.thread:getID())
		self.started = true;
    end
	self:setActionAnim("SewingCloth");
	self.sound = self.character:playSound("Sewing")
end

function ISRepairClothing:stop()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
	self.started = false;
	ISGarmentUI.setBodyPartActionForPlayer(self.character, self.part, nil, nil, nil)
    ISBaseTimedAction.stop(self);
end

function ISRepairClothing:perform()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
	self.character:resetModel();
	self.started = false;
	ISGarmentUI.setBodyPartActionForPlayer(self.character, self.part, nil, nil, nil)
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISRepairClothing:complete()

	self.clothing:addPatch(self.character, self.part, self.fabric);

	self.character:getInventory():Remove(self.fabric);
	sendRemoveItemFromContainer(self.character:getInventory(), self.fabric);

	self.thread:UseAndSync();

	-- removed random exp because people don't understand how it averages out over time and think it's a bug or bad
	addXp(self.character, Perks.Tailoring, ZombRand(4));
-- 	addXp(self.character, Perks.Tailoring, ZombRand(1, 7));

	syncVisuals(self.character);

	return true;
end

function ISRepairClothing:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 150 - (self.character:getPerkLevel(Perks.Tailoring) * 6);
end

function ISRepairClothing:new(character, clothing, part, fabric, thread, needle)
	local o = ISBaseTimedAction.new(self, character)
	o.character = character;
    o.clothing = clothing;
	o.part = part;
	o.fabric = fabric;
	o.thread = thread;
	o.needle = needle;
	o.maxTime = o:getDuration();
	o.started = false;
	return o;
end
