--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISCleanBandage = ISBaseTimedAction:derive("ISCleanBandage")

function ISCleanBandage:isValid()
	if self.item:getContainer() ~= self.character:getInventory() then return false end
	return self.waterObject:hasWater()
end

function ISCleanBandage:waitToStart()
	self.character:faceThisObject(self.waterObject)
	return self.character:shouldBeTurning()
end

function ISCleanBandage:update()
	self.item:setJobDelta(self:getJobDelta())
	self.character:faceThisObject(self.waterObject)
end

function ISCleanBandage:start()
	self.item:setJobType(self.recipe:getName())
	self:setActionAnim("Craft")
	self.sound = self.character:playSound("FirstAidCleanRag")
end

function ISCleanBandage:stop()
	self:stopSound()
	self.item:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISCleanBandage:perform()
	self:stopSound()
	self.item:setJobDelta(0.0)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISCleanBandage:complete()
	local primary = self.character:isPrimaryHandItem(self.item)
	local secondary = self.character:isSecondaryHandItem(self.item)
	self.character:getInventory():Remove(self.item)
	local item = self.character:getInventory():AddItem(self.result)
	sendReplaceItemInContainer(self.character:getInventory(), self.item, item)
	if primary then
		self.character:setPrimaryHandItem(item)
	end
	if secondary then
		self.character:setSecondaryHandItem(item)
	end
	sendEquip(self.character)

	if instanceof(self.waterObject, "IsoWorldInventoryObject") then
		self.waterObject:useWater(1)
	else
		if self.waterObject:useWater(1) > 0 then
			self.waterObject:transmitModData()
		end
	end

	return true;
end

function ISCleanBandage:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return self.recipe:getTimeToMake()
end

function ISCleanBandage:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISCleanBandage:new(character, item, waterObject, recipe)
	local o = ISBaseTimedAction.new(self, character)
	if o.character:isTimedActionInstant() then o.maxTime = 1; end
	o.item = item
	o.result = recipe:getResult():getType()
	o.waterObject = waterObject
	o.recipe = recipe
	o.maxTime = o:getDuration()
	return o
end    	
