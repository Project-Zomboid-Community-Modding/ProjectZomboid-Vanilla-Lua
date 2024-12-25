require "TimedActions/ISBaseTimedAction"
require "Moveables/ISMoveableTools"
require "Moveables/ISMoveableSpriteProps"

ISPickupBrokenGlass = ISBaseTimedAction:derive("ISPickupBrokenGlass")

function ISPickupBrokenGlass:isValid()
	return true
end

function ISPickupBrokenGlass:waitToStart()
	self.character:faceThisObject(self.glass)
	return self.character:shouldBeTurning()
end

function ISPickupBrokenGlass:update()
	self.character:faceThisObject(self.glass)
end

function ISPickupBrokenGlass:start()
    self.glass:getSquare():playSound("RemoveBrokenGlass");
    addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 1)
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
	self:setOverrideHandModels(nil, nil)
	self.character:reportEvent("EventLootItem");
end

function ISPickupBrokenGlass:stop()
	ISBaseTimedAction.stop(self)
end

function ISPickupBrokenGlass:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISPickupBrokenGlass:complete()
    -- add random damage to hands if no gloves (done in pickUpMoveable)
    if ISMoveableTools.isObjectMoveable(self.glass) then
        local moveable = ISMoveableTools.isObjectMoveable(self.glass)
        moveable:pickUpMoveable( self.character, self.square, self.glass, true )
    end
    return true
end

function ISPickupBrokenGlass:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 100
end

function ISPickupBrokenGlass:new(character, glass)
    local o = ISBaseTimedAction.new(self, character);
	o.glass = glass
    o.square = glass:getSquare()
    o.caloriesModifier = 8;
    o.maxTime = o:getDuration();
    return o
end
