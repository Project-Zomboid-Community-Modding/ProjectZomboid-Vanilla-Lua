--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"
require "ISUI/ISLayoutManager"

ISExtendedPlacementAction = ISBaseTimedAction:derive("ISExtendedPlacementAction")

function ISExtendedPlacementAction:isValid()
	return self.item:isExistInTheWorld()
end

function ISExtendedPlacementAction:waitToStart()
	self.character:faceThisObject(self.item)
	return self.character:shouldBeTurning()
end

function ISExtendedPlacementAction:perform()

	local ui = ISExtendedPlacementUI:new(nil, nil, self.playerNum, self.item)
	ui:initialise()
	ui:addToUIManager()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISExtendedPlacementAction:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = 1
	o.playerNum = character:getPlayerNum()
	o.item = item
	return o
end
