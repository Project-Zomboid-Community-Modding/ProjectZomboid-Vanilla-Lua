--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCheckAnimalInsideTrailer = ISBaseTimedAction:derive("ISCheckAnimalInsideTrailer");

function ISCheckAnimalInsideTrailer:isValid()
	return true
end

function ISCheckAnimalInsideTrailer:waitToStart()
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISCheckAnimalInsideTrailer:update()
	self.character:faceThisObject(self.vehicle)
end

function ISCheckAnimalInsideTrailer:start()

end

function ISCheckAnimalInsideTrailer:stop()
    ISBaseTimedAction.stop(self);
end

function ISCheckAnimalInsideTrailer:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);

	local ui = ISVehicleAnimalUI:new(self.vehicle, self.character)
	ui:initialise()
	ui:instantiate()
	ui:addToUIManager();
end

function ISCheckAnimalInsideTrailer:new(character, vehicle)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = vehicle;
	o.maxTime = 1;
	return o;
end
