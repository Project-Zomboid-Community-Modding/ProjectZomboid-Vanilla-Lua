--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFillGrave = ISBaseTimedAction:derive("ISFillGrave")

function ISFillGrave:isValid()
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return true;
    end
end

function ISFillGrave:waitToStart()
	self.character:faceThisObject(self.graves)
	return self.character:isTurning() or self.character:shouldBeTurning()
end

function ISFillGrave:update()
	self.character:faceThisObject(self.graves)
    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
    local skill = self.character:getPerkLevel(Perks.Strength)
    local strain = (1 - (skill * 0.05))/10 * getGameTime():getMultiplier()
    if self.item then
		self.item:setJobDelta(self:getJobDelta());
        self.character:addCombatMuscleStrain(self.item, 1, strain)
    end
end

function ISFillGrave:start()

    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	if self.item then
        self.item:setJobType(getText("ContextMenu_Dig"));
        self.item:setJobDelta(0.0);
	end
	self:setActionAnim(BuildingHelper.getShovelAnim(self.item));
	self:setOverrideHandModels(self.item, nil);
	self.sound = self.character:playSound("Shoveling");
end

function ISFillGrave:stop()
	self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self)
	if self.item then
        self.item:setJobDelta(0.0);
    end
end

function ISFillGrave:perform()
    if self.item then
        self.item:getContainer():setDrawDirty(true);
        self.item:setJobDelta(0.0);
    end
	self.character:stopOrTriggerSound(self.sound)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISFillGrave:complete()
	local sq1 = self.graves:getSquare()
	local sq2 = nil
	if self.graves:getNorth() then
		if self.graves:getModData()["spriteType"] == "sprite1" then
			sq2 = getCell():getGridSquare(sq1:getX(), sq1:getY() - 1, sq1:getZ())
		elseif self.graves:getModData()["spriteType"] == "sprite2" then
			sq2 = getCell():getGridSquare(sq1:getX(), sq1:getY() + 1, sq1:getZ())
		end
	else
		if self.graves:getModData()["spriteType"] == "sprite1" then
			sq2 = getCell():getGridSquare(sq1:getX() - 1, sq1:getY(), sq1:getZ())
		elseif self.graves:getModData()["spriteType"] == "sprite2" then
			sq2 = getCell():getGridSquare(sq1:getX() + 1, sq1:getY(), sq1:getZ())
		end
	end

	self:changeSprite(sq1)
	self:changeSprite(sq2)

	return true;
end

function ISFillGrave:changeSprite(square)
	for i=0,square:getSpecialObjects():size()-1 do
		local grave = square:getSpecialObjects():get(i)
		if grave:getName() == "EmptyGraves" then
			grave:getModData()["filled"] = true
			grave:transmitModData()
			local split = luautils.split(grave:getSprite():getName(), "_")
			local spriteName = "location_community_cemetary_01_" .. (split[5] + 8)
			grave:setSpriteFromName(spriteName)
			grave:transmitUpdatedSpriteToClients()
		end
	end
end

function ISFillGrave:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 150;
end

function ISFillGrave:new(character, graves, shovel)
	local o = ISBaseTimedAction.new(self, character)
	o.character = character
	o.graves = graves
	o.item = shovel
	o.maxTime = o:getDuration();

    o.caloriesModifier = 5;

	return o;
end
