--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISBuryCorpse = ISBaseTimedAction:derive("ISBuryCorpse");

function ISBuryCorpse:isValidStart()
	return not ISEmptyGraves.isGraveFullOfCorpses(self.grave);
end

function ISBuryCorpse:isValid()
	return true;
end

function ISBuryCorpse:waitToStart()
	self.character:faceThisObject(self.grave)
	return self.character:shouldBeTurning()
end

function ISBuryCorpse:update()
	self.character:faceThisObject(self.grave)

    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
end

function ISBuryCorpse:start()
	--self:setActionAnim(CharacterActionAnims.Dig)
end

function ISBuryCorpse:stop()
    ISBaseTimedAction.stop(self);
end

function ISBuryCorpse:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISBuryCorpse:complete()
	if ISEmptyGraves.isGraveFullOfCorpses(self.grave) then
		return false;
	end

	if self.primaryHandItem and self.primaryHandItem:hasTag("AnimalCorpse") then
		return GraveHelper.onBuryAnimalCorpse(self.grave, self.character, self.primaryHandItem);
	end

	local playerID
	if isMultiplayer() then
		playerID = self.character:getOnlineID();
	else
		playerID = self.character:getPlayerNum();
	end

	local targetBody
	for i = self.bodySquare:getStaticMovingObjects():size()-1, 0, -1 do
		if instanceof(self.bodySquare:getStaticMovingObjects():get(i), "IsoDeadBody") then
			local body = self.bodySquare:getStaticMovingObjects():get(i)
			if body:getModData()["lastPlayerGrabbed"] ~= nil and
					body:getModData()["lastPlayerGrabbed"] == playerID then
				targetBody = body;
			end
		end
	end

	if targetBody == nil then return false end

	local sq = targetBody:getSquare()
	local z = sq:getZ()
	if z ~= 0 then return false end
	GraveHelper.updateGrave(self.grave);

	sq:removeCorpse(targetBody, false);

	return true;
end

function ISBuryCorpse:getDuration()
	return 300;
end

function ISBuryCorpse:new(character, grave, primaryHandItem, bodySquare)
	local o = ISBaseTimedAction.new(self, character)
	o.grave = grave;
	o.maxTime = o:getDuration();
    o.primaryHandItem = primaryHandItem;
	o.bodySquare = bodySquare;
	return o;
end
