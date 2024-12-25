--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISBuryCorpse = ISBaseTimedAction:derive("ISBuryCorpse");

function ISBuryCorpse:isValidStart()
	return not ISEmptyGraves.isGraveFullOfCorpses(self.graves) and (self.character:getInventory():contains("CorpseMale") or self.character:getInventory():contains("CorpseFemale"))
end

function ISBuryCorpse:isValid()
	local playerInv = self.character:getInventory()
	return playerInv:containsType("CorpseMale") or playerInv:containsType("CorpseFemale")
end

function ISBuryCorpse:waitToStart()
	self.character:faceThisObject(self.graves)
	return self.character:shouldBeTurning()
end

function ISBuryCorpse:update()
	self.character:faceThisObject(self.graves)

    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
end

function ISBuryCorpse:start()
	self:setActionAnim(CharacterActionAnims.Dig)
end

function ISBuryCorpse:stop()
    ISBaseTimedAction.stop(self);
end

function ISBuryCorpse:perform()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISBuryCorpse:complete()
	local playerInv = self.character:getInventory()
	if playerInv:containsType("CorpseMale") then
		local item = playerInv:RemoveOneOf("CorpseMale", false)
		sendRemoveItemFromContainer(playerInv, item);
	elseif playerInv:containsType("CorpseFemale") then
		local item = playerInv:RemoveOneOf("CorpseFemale", false)
		sendRemoveItemFromContainer(playerInv, item);
	end

	self.character:setPrimaryHandItem(nil)
	self.character:setSecondaryHandItem(nil)

	self.graves:getModData()["corpses"] = self.graves:getModData()["corpses"] + 1;
	self.graves:transmitModData()

	local sq1 = self.graves:getSquare();
	local sq2 = nil;
	if self.graves:getNorth() then
		if self.graves:getModData()["spriteType"] == "sprite1" then
			sq2 = getCell():getGridSquare(sq1:getX(), sq1:getY() - 1, sq1:getZ());
		elseif self.graves:getModData()["spriteType"] == "sprite2" then
			sq2 = getCell():getGridSquare(sq1:getX(), sq1:getY() + 1, sq1:getZ());
		end
	else
		if self.graves:getModData()["spriteType"] == "sprite1" then
			sq2 = getCell():getGridSquare(sq1:getX() - 1, sq1:getY(), sq1:getZ());
		elseif self.graves:getModData()["spriteType"] == "sprite2" then
			sq2 = getCell():getGridSquare(sq1:getX() + 1, sq1:getY(), sq1:getZ());
		end
	end

	self:increaseCorpse(sq2);

	return true;
end

function ISBuryCorpse:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 80
end

function ISBuryCorpse:increaseCorpse(square)
	for i=0,square:getSpecialObjects():size()-1 do
		local grave = square:getSpecialObjects():get(i);
		if grave:getName() == "EmptyGraves" then
			grave:getModData()["corpses"] = grave:getModData()["corpses"] + 1;
			grave:transmitModData()
		end
	end
end

function ISBuryCorpse:new(character, graves, shovel)
	local o = ISBaseTimedAction.new(self, character)
	o.graves = graves;
	o.maxTime = o:getDuration();
    o.caloriesModifier = 5;
    o.shovel = shovel
	return o;
end
