require "TimedActions/ISBaseTimedAction"

ISRemoveBrokenGlass = ISBaseTimedAction:derive("ISRemoveBrokenGlass")

function ISRemoveBrokenGlass:isValid()
	return self.window:getObjectIndex() ~= -1 and self.window:isSmashed() and not self.window:isGlassRemoved()
end

function ISRemoveBrokenGlass:waitToStart()
	self.character:faceThisObject(self.window)
	return self.character:shouldBeTurning()
end

function ISRemoveBrokenGlass:update()
	self.character:faceThisObject(self.window)

    self.character:setMetabolicTarget(Metabolics.LightWork);
end

function ISRemoveBrokenGlass:start()
--	getSoundManager():PlayWorldSound("RemoveBrokenGlass", false, self.window:getSquare(), 1, 20, 1, false)
    self.window:getSquare():playSound("RemoveBrokenGlass");
    addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 6, 1)
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Mid")
	self:setOverrideHandModels(nil, nil)
	self.character:reportEvent("EventLootItem");
end

function ISRemoveBrokenGlass:stop()
	ISBaseTimedAction.stop(self)
end

function ISRemoveBrokenGlass:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISRemoveBrokenGlass:complete()
	self.window:removeBrokenGlass()
	if isServer() then
		self.window:sync()
	end
	return true;
end

function ISRemoveBrokenGlass:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 100
end

function ISRemoveBrokenGlass:new(character, window)
	local o = ISBaseTimedAction.new(self, character);
	o.window = window
	o.maxTime = o:getDuration()
    o.caloriesModifier = 8;
    return o
end
