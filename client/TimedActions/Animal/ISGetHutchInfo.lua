--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGetHutchInfo = ISBaseTimedAction:derive("ISGetHutchInfo");

function ISGetHutchInfo:isValid()
	return true;
end

function ISGetHutchInfo:update()
	self.character:setIsAiming(false);
	self.character:faceThisObject(self.hutch)
end

function ISGetHutchInfo:start()
end

function ISGetHutchInfo:stop()
    ISBaseTimedAction.stop(self);
end

function ISGetHutchInfo:perform()
	local ui = ISHutchUI.ShowWindow(self.character, self.hutch);
	if ui and self.animal and (self.animal:getHutch() == self.hutch) then
		if self.animal:getNestBoxIndex() == -1 then
			ui:showRoosts()
		else
			ui:showNestBoxes()
		end
	end
	if getJoypadData(self.playerNum) then
		setJoypadFocus(self.playerNum, ui)
	end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISGetHutchInfo:new(character, hutch, animal)
	local o = ISBaseTimedAction.new(self, character)
	o.playerNum = character:getPlayerNum()
	o.hutch = hutch;
	o.animal = animal;
	o.maxTime = 1
	o.stopOnAim = false;
	return o;
end
