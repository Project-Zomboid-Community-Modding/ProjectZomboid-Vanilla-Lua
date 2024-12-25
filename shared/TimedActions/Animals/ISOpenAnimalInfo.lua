--***********************************************************
--**                    THE INDIE STONE                    **
--** this is just needed because of a walkto prior to that **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenAnimalInfo = ISBaseTimedAction:derive("ISOpenAnimalInfo");

function ISOpenAnimalInfo:isValid()
	return self.animal:getVehicle() ~= nil or self.character:getSquare():DistTo(self.animal:getSquare()) < 3;
end

function ISOpenAnimalInfo:waitToStart()
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISOpenAnimalInfo:update()
	self.character:faceThisObject(self.animal)
	--self.animal:faceThisObject(self.character);
end

function ISOpenAnimalInfo:start()

end

function ISOpenAnimalInfo:forceStop()
	self.action:forceStop();
end

function ISOpenAnimalInfo:stop()
    ISBaseTimedAction.stop(self);
end

function ISOpenAnimalInfo:perform()

    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISOpenAnimalInfo:complete()
	local ui = ISAnimalUI:new(100, 100, 650, 500, self.animal, self.player)
	ui:initialise();
	ui:addToUIManager();
	return true
end

function ISOpenAnimalInfo:getDuration()
	--if self.character:isTimedActionInstant() then
	--	return 1
	--end
	return 1
end

function ISOpenAnimalInfo:serverStart()
end

function ISOpenAnimalInfo:animEvent(event, parameter)
end

function ISOpenAnimalInfo:new(character, animal)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.player = character;
	o.maxTime = o:getDuration()
	o.useProgressBar = false;
	return o;
end
