--***********************************************************
--**                    THE INDIE STONE                    **
--** this is just needed because of a walkto prior to that **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenAnimalInfo = ISBaseTimedAction:derive("ISOpenAnimalInfo");

function ISOpenAnimalInfo:isValid()
	if self.animal:getHutch() then
		return self.character:getSquare():DistTo(self.animal:getHutch():getSquare()) < 3
	end
	return self.animal:getVehicle() ~= nil or self.character:getSquare():DistTo(self.animal:getSquare()) < 3;
end

function ISOpenAnimalInfo:waitToStart()
	if self.animal:getHutch() then return false end
	self.character:faceThisObject(self.animal)
	return self.character:shouldBeTurning()
end

function ISOpenAnimalInfo:update()
	if self.animal:getHutch() then return end
	self.character:faceThisObject(self.animal)
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
	local ui = ISAnimalUI:new(getPlayerScreenLeft(self.playerNum)+100, getPlayerScreenTop(self.playerNum)+100, 650, 500, self.animal, self.player)
	ui:initialise();
	ui:addToUIManager();
	ui.prevFocus = self.prevFocus
	if getJoypadData(self.playerNum) then
		if self.prevFocus ~= nil and self.prevFocus.Type == "ISVehicleAnimalUI" then
			self.prevFocus:setVisible(false)
		end
		setJoypadFocus(self.playerNum, ui)
	end
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

function ISOpenAnimalInfo:new(character, animal, prevFocus)
	local o = ISBaseTimedAction.new(self, character)
	o.animal = animal;
	o.player = character;
	o.playerNum = character:getPlayerNum();
	o.maxTime = o:getDuration()
	o.useProgressBar = false;
	o.prevFocus = prevFocus;
	return o;
end
