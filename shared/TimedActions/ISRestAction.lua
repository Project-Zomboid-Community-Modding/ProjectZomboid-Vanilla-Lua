--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRestAction = ISBaseTimedAction:derive("ISRestAction");

function ISRestAction:isValid()
	return true; -- self.character:getStats():getEndurance() < 1;
end

function ISRestAction:waitToStart()
	if self.bed and (self.bed:getObjectIndex() ~= -1) then
		self.bed:setSatChair(true)
		self.character:setSitOnFurnitureObject(self.bed)
		local sitDir,sideStr = self:calculateSitOnFurnitureDirection(self.character, self.bed)
		self.character:setSitOnFurnitureDirection(sitDir)
		self.sideStr = sideStr
	end
	self:setBeforeSitDirection()
	-----
	-- FIXME: Wait for any blending/deferred movement/rotation to end
	if self.character:shouldBeTurning() then
		self.delayStart = 0.2
	else
		if self.delayStart == nil then
			self.delayStart = 0.2
		end
		self.delayStart = self.delayStart - getGameTime():getRealworldSecondsSinceLastUpdate()
		if self.delayStart > 0 then
			return true
		end
	end
	-----
	return self.character:shouldBeTurning()
end

function ISRestAction:update()
	if self.character then
--		self.character:updateEnduranceWhileSitting();
		if self.useAnimations then
			-- RJ: Removed this as being an action, this way we can still passively regain endurance and read at the same time
			if not self.character:isSittingOnFurniture() or self.character:getVariableBoolean("SitOnFurnitureStarted") then
				if isServer() then
					self.netAction:forceComplete();
				else
					self:forceComplete()
				end
			end
		else
			if not isServer() then
				self.action:setTime(100) -- endurance = 1.0
				self:setCurrentTime(self.character:getStats():getEndurance() * 100)
			end

			if self.character:getStats():getEndurance() >= 1.0 then
				if isServer() then
					self.netAction:forceComplete();
				else
					self:forceComplete()
				end
			end
		end
	end
end

function ISRestAction:start()
	if self:furnitureHasSittingData(self.bed) and self.useAnimations then
		self.character:reportEvent("EventSitOnFurniture")
		self:setWhileSittingDirection()
	end
	self.character:setVariable("ExerciseStarted", false);
	self.character:setVariable("ExerciseEnded", true);
	self.character:setIsResting(true)
	self.character:setBed(self.bed)
end

function ISRestAction:stop()
	ISBaseTimedAction.stop(self);
	self.character:setIsResting(false)
	self.character:setBed(nil)
end

function ISRestAction:animEvent(event, parameter)
	if isServer() then
		if event == "update" then
			self:update();
		end
	end
end

function ISRestAction:serverStart()
	emulateAnimEvent(self.netAction, 100, "update", nil)
end

function ISRestAction:serverStop()
	self:resetResting();
end

function ISRestAction:perform()
	ISBaseTimedAction.perform(self);
end

function ISRestAction:complete()
	self:resetResting();
	return true
end

function ISRestAction:resetResting()
	self.character:setIsResting(false)
	self.character:setBed(nil)
	if isServer() then
		sendServerCommand(self.character, 'character', 'rested', { })
	end
end

function ISRestAction:getDuration()
if true then return 10000 end
	if self.character:isTimedActionInstant() then
		return 1
	end
	return (1 - self.character:getStats():getEndurance()) * 16000
end

function ISRestAction:furnitureHasSittingData(bed)
    return SeatingManager.getInstance():getTilePositionCount(bed) > 0
end

function ISRestAction:setBeforeSitDirection()
	if not self:furnitureHasSittingData(self.bed) or not self.useAnimations then
		self.character:faceThisObject(self.bed)
		return
	end
	if self.character and self.bed then
		local facing = self.character:getSitOnFurnitureDirection() or IsoDirections.S -- SeatingManager.getInstance():getFacingDirection(self.bed)
		facing = facing:name()
		local dir = IsoDirections.S
		if facing == "N" then
			if self.sideStr == "Left" then
				-- W
				dir = IsoDirections.E
				self.character:setVariable("SitOnFurnitureDirection", "Left");
			elseif self.sideStr == "Right" then
				-- E
				dir = IsoDirections.W
				self.character:setVariable("SitOnFurnitureDirection", "Right");
			else
				-- N
				dir = IsoDirections.N
				self.character:setVariable("SitOnFurnitureDirection", "Front");
			end
		elseif facing == "S" then
			if self.sideStr == "Right" then
				-- W
				dir = IsoDirections.E
				self.character:setVariable("SitOnFurnitureDirection", "Right");
			elseif self.sideStr == "Left" then
				-- E
				dir = IsoDirections.W
				self.character:setVariable("SitOnFurnitureDirection", "Left");
			else
				-- S
				dir = IsoDirections.S
				self.character:setVariable("SitOnFurnitureDirection", "Front");
			end
		elseif facing == "W" then
			if self.sideStr == "Right" then
				-- N
				dir = IsoDirections.S
				self.character:setVariable("SitOnFurnitureDirection", "Right");
			elseif self.sideStr == "Left" then
				-- S
				dir = IsoDirections.N
				self.character:setVariable("SitOnFurnitureDirection", "Left");
			else
				-- W
				dir = IsoDirections.W
				self.character:setVariable("SitOnFurnitureDirection", "Front");
			end
		elseif facing == "E" then
			if self.sideStr == "Left" then
				-- N
				dir = IsoDirections.S
				self.character:setVariable("SitOnFurnitureDirection", "Left");
			elseif self.sideStr == "Right" then
				-- S
				dir = IsoDirections.N
				self.character:setVariable("SitOnFurnitureDirection", "Right");
			else
				-- E
				dir = IsoDirections.E
				self.character:setVariable("SitOnFurnitureDirection", "Front");
			end
		end
		self.character:faceDirection(dir)
	end
end

function ISRestAction:calculateSitOnFurnitureDirection(character, bed)
	local worldPos = Vector3f.new()
	local distMin = 10
	local direction = IsoDirections.S
	local sideStr = nil
	for _,dir in ipairs({ "N", "S", "W", "E" }) do
		for _,side in ipairs({ "Front", "Left", "Right" }) do
			local valid = SeatingManager.getInstance():getAdjacentPosition(character, bed, dir, side, "sitonfurniture", "SitOnFurniture"..side, worldPos)
			if valid then
				local dist = IsoUtils.DistanceToSquared(character:getX(), character:getY(), worldPos:x(), worldPos:y())
				if dist < distMin then
					distMin = dist
					direction = IsoDirections.fromString(dir)
					sideStr = side
				end
			end
		end
	end
	return direction,sideStr
end

function ISRestAction:setWhileSittingDirection()
	if self.character then
		local direction = self.character:getSitOnFurnitureDirection() or IsoDirections.S -- SeatingManager.getInstance():getFacingDirection(self.bed)
		self.character:faceDirection(direction)
	end
end

function ISRestAction:new(character, bed, useAnimations)
	local o = ISBaseTimedAction.new(self, character)
	o.forceProgressBar = true;
	o.bed = bed
	o.mul = 2;
	o.maxTime = -1; -- o:getDuration();
    o.caloriesModifier = 0.5;
    o.useAnimations = useAnimations
	return o;
end
