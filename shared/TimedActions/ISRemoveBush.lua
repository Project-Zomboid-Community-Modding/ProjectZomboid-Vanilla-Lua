--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRemoveBush = ISBaseTimedAction:derive("ISRemoveBush")

function ISRemoveBush:isValid()
	if self.wallVine and not self:getWallVineObject(self.square) then
		return false
	end
	if not self.wallVine and not self:getBushObject(self.square) then
		return false
	end
	return (self.weapon and self.weapon:getCondition() > 0) or not self.weapon;
end

function ISRemoveBush:waitToStart()
	if self.wallVine then
		local object = self:getWallVineObject(self.square)
		if object then
			self.character:faceThisObject(object)
		end
	else
		self.character:faceLocation(self.square:getX(), self.square:getY())
	end
	return self.character:shouldBeTurning()
end

function ISRemoveBush:update()
	if self.wallVine then
		local object = self:getWallVineObject(self.square)
		if object then self.character:faceThisObject(object) end
	else
		self.character:faceLocation(self.square:getX(), self.square:getY())
	end

	self.spriteFrame = self.character:getSpriteDef():getFrame()
--	self:setJobDelta(1 - self.tree:getHealth() / self.tree:getMaxHealth())

    self.character:setMetabolicTarget(Metabolics.DiggingSpade);
end

function ISRemoveBush:start()
    self.weapon = self.character:getPrimaryHandItem()
	addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 10)
	if self.weapon then
		if self.weapon:getScriptItem():containsWeaponCategory("Axe") then
			self:setActionAnim("RemoveBushAxe")
		elseif self.weapon:getScriptItem():containsWeaponCategory("LongBlade") then
			self:setActionAnim("RemoveBushLongBlade")
		elseif self.weapon:getScriptItem():containsWeaponCategory("SmallBlade") then
			self:setActionAnim("RemoveBushKnife")
		else
			self:setActionAnim("RemoveBush")
		end
	else
		self:setActionAnim("RemoveBush")
	end
end

function ISRemoveBush:stop()
    ISBaseTimedAction.stop(self)
end

function ISRemoveBush:serverStart()
	emulateAnimEvent(self.netAction, 1500, "Chop", nil)
end

function ISRemoveBush:animEvent(event, parameter)
	if event == 'Chop' then
		self.square:playSound("ChopTree");
		addSound(self.character, self.character:getX(), self.character:getY(), self.character:getZ(), 20, 1)
		if isServer() then
		    if self.weapon then

			local modifier = 1
			if ("lumberjack" == self.character:getDescriptor():getProfession()) then modifier = 0.5 end
            self.character:addCombatMuscleStrain(self.weapon, 1, modifier)

            end
			self:useEndurance()
            if self.weapon and self.weapon:damageCheck(0,4,false) then
                ISWorldObjectContextMenu.checkWeapon(self.character)
            end
-- 			if self.weapon and ZombRand(self.weapon:getConditionLowerChance() * 4) == 0 then
-- 				self.weapon:setCondition(self.weapon:getCondition() - 1)
-- 				ISWorldObjectContextMenu.checkWeapon(self.character)
-- 			end
		end
	end
end

function ISRemoveBush:getBushObject(square)
	if not square then return nil end
	for i=1,square:getObjects():size() do
		local o = square:getObjects():get(i-1)
		if o:getSprite() and o:getSprite():getProperties() and o:getSprite():getProperties():Is(IsoFlagType.canBeCut) then
			return o
		end
	end
	return nil
end

function ISRemoveBush:getWallVineObject(square)
	if not square then return nil end
	for i=0,square:getObjects():size()-1 do
		local object = square:getObjects():get(i);
		local attached = object:getAttachedAnimSprite()
		if attached then
			for n=1,attached:size() do
				local sprite = attached:get(n-1)
--					if sprite and sprite:getParentSprite() and sprite:getParentSprite():getProperties():Is(IsoFlagType.canBeCut) then
				if sprite and sprite:getParentSprite() and sprite:getParentSprite():getName() and luautils.stringStarts(sprite:getParentSprite():getName(), "f_wallvines_") then
					return object, n-1
				end
			end
		end
	end
	return nil
end

function ISRemoveBush:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISRemoveBush:complete()
    if (not self.weapon) and (not self.wallVine) then
        local skill = self.character:getPerkLevel(Perks.Farming)
        self.character:addBackMuscleStrain(1 - (skill * 0.05))
    end
	local sq = self.square

	if sq then
		if self.wallVine then
			local object,index = self:getWallVineObject(sq)
			if object and index then
				object:RemoveAttachedAnim(index)
				object:transmitUpdatedSpriteToClients()
				sq:removeErosionObject("WallVines")
			end
			-- and the top one, if any
			local topSq = getCell():getGridSquare(sq:getX(), sq:getY(), sq:getZ() + 1)
			local object,index = self:getWallVineObject(topSq)
			if object and index then
				object:RemoveAttachedAnim(index)
				object:transmitUpdatedSpriteToClients()
				topSq:removeErosionObject("WallVines")
			end
		else
			for i=0,sq:getObjects():size()-1 do
				local object = sq:getObjects():get(i);
				if object:getProperties():Is(IsoFlagType.canBeCut) then
					sq:transmitRemoveItemFromSquare(object)
					if ZombRand(2) == 0 then
						sq:AddWorldInventoryItem("Base.TreeBranch2", 0, 0, 0);
					end
					if ZombRand(1) == 0 then
						sq:AddWorldInventoryItem("Base.Twigs", 0, 0, 0);
					end
					i = i - 1; -- FIXME: illegal in Lua
				end
			end
		end
	end

	return true;
end

function ISRemoveBush:useEndurance()
	if self.weapon and self.weapon:isUseEndurance() then
		local use = self.weapon:getWeight() * self.weapon:getFatigueMod(self.character) * self.character:getFatigueMod() * self.weapon:getEnduranceMod() * 0.1
		local useChargeDelta = 1.0
		use = use * useChargeDelta * 0.041
		if self.weapon:isTwoHandWeapon() and self.character:getSecondaryHandItem() ~= self.weapon then
			use = use + self.weapon:getWeight() / 1.5 / 10 / 20
		end
		self.character:getStats():setEndurance(self.character:getStats():getEndurance() - use)

		--Stat_Endurance
		syncPlayerStats(self.character, 0x00000002);
	end
end

function ISRemoveBush:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end

	return 100;
end

function ISRemoveBush:new(character, square, wallVine)
	local o = ISBaseTimedAction.new(self, character);
	o.character = character
	o.square = square
	o.maxTime = o:getDuration();
	o.spriteFrame = 0
	o.wallVine = wallVine
	return o
end
