--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCheckFishingNetAction = ISBaseTimedAction:derive("ISCheckFishingNetAction");

function ISCheckFishingNetAction:isValid()
	return self.trap ~= nil and self.trap:getSquare() ~= nil and math.abs(math.floor(((getGameTime():getCalender():getTimeInMillis() - self.trap:getSquare():getModData()["fishingNetTS"]) / 60000) / 60) - self.hours) < 2;
end

function ISCheckFishingNetAction:update()
    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISCheckFishingNetAction:start()
    self.character:getSquare():playSound("CheckFishingNet");
    addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 1)
    self.character:playSound("CheckFishingNet");
end

function ISCheckFishingNetAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISCheckFishingNetAction:perform()
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISCheckFishingNetAction:complete()
	fishingNet.checkTrap(self.character, self.trap, self.hours);

	addXp(self.character, Perks.Fishing, 1)

	return true;
end

function ISCheckFishingNetAction:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	if self.hours > 11 then
		return 150;
	else
		return self.hours * 13
	end
end

function ISCheckFishingNetAction:new(character, trap, hours)
	local o = ISBaseTimedAction.new(self, character);
	o.trap = trap;
    o.hours = hours;
	o.maxTime = o:getDuration()
	return o;
end
