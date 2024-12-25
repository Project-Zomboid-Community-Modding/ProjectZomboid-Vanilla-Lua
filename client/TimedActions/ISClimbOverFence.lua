--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISClimbOverFence = ISBaseTimedAction:derive("ISClimbOverFence")

function ISClimbOverFence:isValid()
	return self.item:getObjectIndex() ~= -1
end

function ISClimbOverFence:waitToStart()
	local dir = self:getFacingDirection()
	self.character:faceDirection(dir)
	return self.character:shouldBeTurning()
end

function ISClimbOverFence:start()
end

function ISClimbOverFence:update()
    self.character:setMetabolicTarget(Metabolics.JumpFence);
end

function ISClimbOverFence:stop()
	ISBaseTimedAction.stop(self)
end

function ISClimbOverFence:perform()
	local dir = self:getFacingDirection()
	self.character:climbOverFence(dir)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISClimbOverFence:getDeltaModifiers(deltas)
	if not self:isStarted() then
		deltas:setMaxTurnDelta(2)
	end
end

function ISClimbOverFence:getFacingDirection()
	local square = self.item:getSquare()
	local north = square:Is(IsoFlagType.HoppableN)
	if north then
		if self.character:getY() < square:getY() then
			return IsoDirections.S
		end
		return IsoDirections.N
	end
	if self.character:getX() < square:getX() then
		return IsoDirections.E
	end
	return IsoDirections.W
end

function ISClimbOverFence:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item
	o.maxTime = 0
	o.stopOnWalk = false;
	o.stopOnRun = false;
	o.stopOnAim = false;
	return o
end	
