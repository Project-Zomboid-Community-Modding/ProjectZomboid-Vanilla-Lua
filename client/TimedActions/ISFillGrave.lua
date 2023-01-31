--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFillGrave = ISBaseTimedAction:derive("ISFillGrave")

function ISFillGrave:isValid()
	return true
end

function ISFillGrave:waitToStart()
	self.character:faceThisObject(self.graves)
	return self.character:shouldBeTurning()
end

function ISFillGrave:update()
	self.character:faceThisObject(self.graves)

    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
end

function ISFillGrave:start()
	self:setActionAnim(ISFarmingMenu.getShovelAnim(self.shovel));
	self:setOverrideHandModels(self.shovel, nil);
	self.sound = self.character:playSound("Shoveling")
end

function ISFillGrave:stop()
	self.character:stopOrTriggerSound(self.sound)
    ISBaseTimedAction.stop(self)
end

function ISFillGrave:perform()
	self.character:stopOrTriggerSound(self.sound)
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

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
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
			grave:transmitUpdatedSpriteToServer()
		end
	end
end

function ISFillGrave:new(character, graves, time, shovel)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = getSpecificPlayer(character)
	o.graves = graves
	o.shovel = shovel
	o.stopOnWalk = true
	o.stopOnRun = true
	o.maxTime = time
	if o.character:isTimedActionInstant() then o.maxTime = 1; end
    o.caloriesModifier = 5;
	return o
end
