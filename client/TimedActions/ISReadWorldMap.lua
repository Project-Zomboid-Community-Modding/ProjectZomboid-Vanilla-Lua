--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISReadWorldMap = ISBaseTimedAction:derive("ISReadWorldMap");

function ISReadWorldMap:isValid()
	return ISWorldMap.IsAllowed()
end

function ISReadWorldMap:update()
end

function ISReadWorldMap:start()
	self:setAnimVariable("ReadType", "newspaper")
	self:setActionAnim(CharacterActionAnims.Read)
    self:setOverrideHandModelsString(nil, "MapInHand");
--	self.character:reportEvent("EventRead")
	self.character:playSoundLocal("MapOpen")
end

function ISReadWorldMap:stop()
	ISBaseTimedAction.stop(self)
end

function ISReadWorldMap:perform()
	ISWorldMap.ShowWorldMap(self.playerNum, self.centerX, self.centerY, self.zoom)

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISReadWorldMap:new(character, centerX, centerY, zoom)
	local o = ISBaseTimedAction.new(self, character)
	o.maxTime = 50
	if character:isTimedActionInstant() then
		o.maxTime = 1
	end
	o.playerNum = character:getPlayerNum()
	o.centerX = centerX
	o.centerY = centerY
	o.zoom = zoom
	return o
end

