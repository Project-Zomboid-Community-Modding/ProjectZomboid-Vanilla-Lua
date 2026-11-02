require "TimedActions/ISBaseTimedAction"

ISClimbLadderAction = ISBaseTimedAction:derive("ISClimbLadderAction");

function ISClimbLadderAction:isValid()
    if self.down then
        return self.ladder == self.character:getClimbLadderDown(self.character:getCurrentSquare())
    else
        return self.ladder == self.character:getClimbLadder(self.character:getCurrentSquare())
    end
end

function ISClimbLadderAction:update()
    self.character:setMetabolicTarget(Metabolics.ClimbRope);
end

function ISClimbLadderAction:start()
end

function ISClimbLadderAction:stop()
	ISBaseTimedAction.stop(self);
end

function ISClimbLadderAction:perform()
	if self.down then
		self.character:climbDown()
	else
		self.character:climb()
	end
	ISBaseTimedAction.perform(self);
end

function ISClimbLadderAction:new(character, down, ladder)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = 0
	o.down = down
	o.ladder = ladder
	return o
end
