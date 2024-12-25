--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISGetOnBedAction = ISBaseTimedAction:derive("ISGetOnBedAction")

function ISGetOnBedAction:isValid()
	return self.bed:getObjectIndex() ~= -1
end

function ISGetOnBedAction:waitToStart()
	self.character:setSitOnFurnitureObject(self.bed)
	self:setBeforeSitDirection()
	return self.character:shouldBeTurning()
end

function ISGetOnBedAction:update()
	if self.character:getVariableBoolean("OnBedStarted") then
		self:forceComplete()
	end
end

function ISGetOnBedAction:start()
	self.character:reportEvent("EventGetOnBed")
	self:setWhileSittingDirection()
	self.character:setVariable("ExerciseStarted", false)
	self.character:setVariable("ExerciseEnded", true)
end

function ISGetOnBedAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISGetOnBedAction:perform()
	ISBaseTimedAction.perform(self)
end

function ISGetOnBedAction:setBeforeSitDirection()
	local facing = SeatingManager.getInstance():getFacingDirection(self.bed)
	local x = self.bed:getX()
	local y = self.bed:getY()
	local cx = self.character:getX()
	local cy = self.character:getY()
	if facing == "N" then
		if cy < y - 1.0 then
			-- Foot
			x = x + 0.5
			y = y - 2.0 -- TEMP: anim should start facing bed, turn 180 before ending in sitting position
			self.character:setVariable("OnBedDirection", "Foot")
		elseif cx < x + 0.25 then
			if cy > y then
				-- W head
				x = x + 2.0
				y = y + 0.5
				self.character:setVariable("OnBedDirection", "HeadLeft")
			else
				-- W foot
				x = x + 2.0
				y = y - 0.5
				self.character:setVariable("OnBedDirection", "FootLeft")
			end
		else
			if cy > y then
				-- E head
				x = x - 2.0
				y = y + 0.5
				self.character:setVariable("OnBedDirection", "HeadRight")
			else
				-- E foot
				x = x - 2.0
				y = y - 0.5
				self.character:setVariable("OnBedDirection", "FootRight")
			end
		end
	elseif facing == "S" then
		if cy > y + 2.0 then
			-- Foot
			x = x + 0.5
			y = y + 3.0 -- TEMP: anim should start facing bed, turn 180 before ending in sitting position
			self.character:setVariable("OnBedDirection", "Foot")
		elseif cx < x + 0.25 then
			if cy < y + 1.0 then
				-- W head
				x = x + 2.0
				y = y + 0.5
				self.character:setVariable("OnBedDirection", "HeadRight")
			else
				-- W foot
				x = x + 2.0
				y = y + 1.5
				self.character:setVariable("OnBedDirection", "FootRight")
			end
		else
			if cy < y + 1.0 then
				-- E head
				x = x - 2.0
				y = y + 0.5
				self.character:setVariable("OnBedDirection", "HeadLeft")
			else
				-- E foot
				x = x - 2.0
				y = y + 1.5
				self.character:setVariable("OnBedDirection", "FootLeft")
			end
		end
	elseif facing == "W" then
		if cx < x - 1 then
			-- Foot
			x = x - 2.0 -- TEMP: anim should start facing bed, turn 180 before ending in sitting position
			y = y + 0.5
			self.character:setVariable("OnBedDirection", "Foot")
		elseif cy < y + 0.25 then
			if cx > x then
				-- N head
				x = x + 0.5
				y = y + 2.0
				self.character:setVariable("OnBedDirection", "HeadRight")
			else
				-- N foot
				x = x - 0.5
				y = y + 2.0
				self.character:setVariable("OnBedDirection", "FootRight")
			end
		else
			if cx > x then
				-- S head
				x = x + 0.5
				y = y - 2.0
				self.character:setVariable("OnBedDirection", "HeadLeft")
			else
				-- S foot
				x = x - 0.5
				y = y - 2.0
				self.character:setVariable("OnBedDirection", "FootLeft")
			end
		end
	elseif facing == "E" then
		if cx > x + 2 then
			-- Foot
			x = x + 3.0 -- TEMP: anim should start facing bed, turn 180 before ending in sitting position
			y = y + 0.5
			self.character:setVariable("OnBedDirection", "Foot")
		elseif cy < y + 0.25 then
			if cx < x + 1.0 then
				-- N head
				x = x + 0.5
				y = y + 2.0
				self.character:setVariable("OnBedDirection", "HeadLeft")
			else
				-- N foot
				x = x + 1.5
				y = y + 2.0
				self.character:setVariable("OnBedDirection", "FootLeft")
			end
		else
			if cx < x + 1.0 then
				-- S head
				x = x + 0.5
				y = y - 2.0
				self.character:setVariable("OnBedDirection", "HeadRight")
			else
				-- S foot
				x = x + 1.5
				y = y - 2.0
				self.character:setVariable("OnBedDirection", "FootRight")
			end
		end
	end
	self.character:faceLocationF(x, y)
end

function ISGetOnBedAction:setWhileSittingDirection()
	local facing = SeatingManager.getInstance():getFacingDirection(self.bed)
	local x = self.bed:getX()
	local y = self.bed:getY()
	local cx = self.character:getX()
	local cy = self.character:getY()
	if facing == "N" then
		x = cx
		y = cy - 2.0
	elseif facing == "S" then
		x = cx
		y = cy + 2.0
	elseif facing == "W" then
		x = cx - 2.0
		y = cy
	elseif facing == "E" then
		x = cx + 2.0
		y = cy
	end
	self.character:faceLocationF(x, y)
end

function ISGetOnBedAction:new(character, bed)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnWalk = true
	o.stopOnRun = true
	o.forceProgressBar = true
	o.bed = bed
	o.maxTime = -1
	return o
end	
