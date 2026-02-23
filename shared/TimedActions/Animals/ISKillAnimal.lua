require "TimedActions/ISBaseTimedAction"

ISKillAnimal = ISBaseTimedAction:derive("ISKillAnimal");

function ISKillAnimal:isValid()
	return self:canKillAnimal();
end

function ISKillAnimal:waitToStart()
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISKillAnimal:update()
	self.character:faceThisObject(self.animal)
end

function ISKillAnimal:start()
	if self.animal and instanceof(self.animal, "IsoAnimal") and self.animal:isExistInTheWorld() then
		self.animal:getBehavior():setBlockMovement(true);
	end
end

function ISKillAnimal:stop()
    ISBaseTimedAction.stop(self);

	if self.animal and instanceof(self.animal, "IsoAnimal") and self.animal:isExistInTheWorld() then
		self.animal:getBehavior():setBlockMovement(false);
	end
end

function ISKillAnimal:canKillAnimal()
	if not self.character or not self.animal or self.character:DistToSquared(self.animal:getX(), self.animal:getY()) > 2 * 2 then
		return false;
	end

	return true;
end

function ISKillAnimal:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISKillAnimal:complete()
    if isServer() then
        if not self:canKillAnimal() then
            return false;
        end
        PVPLogTool.logKill(self.character, self.animal)
    end
	self:kill();

	return true
end

function ISKillAnimal:kill()
	self.animal:setHealth(0);
	self.animal:killed(self.character);
end

function ISKillAnimal:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 80
end

function ISKillAnimal:new(character, animal)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.character = character;
	o.maxTime = o:getDuration()
	return o;
end
