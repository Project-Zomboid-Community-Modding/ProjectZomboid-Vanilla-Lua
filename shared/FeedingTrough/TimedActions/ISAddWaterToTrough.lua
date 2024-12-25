--***********************************************************
--**                   THE INDIE STONE                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddWaterToTrough = ISBaseTimedAction:derive("ISAddWaterToTrough")

function ISAddWaterToTrough:isValid()
    return self.objectTo:getObjectIndex() ~= -1
end

function ISAddWaterToTrough:waitToStart()
	self.character:faceThisObject(self.objectTo)
	return self.character:shouldBeTurning()
end

function ISAddWaterToTrough:updateAddingWater()
    local luaObject = SFeedingTroughSystem.instance:getLuaObjectAt(self.objectTo:getX(), self.objectTo:getY(), self.objectTo:getZ())
    if self.objectTo:getWater() < self.objectTo:getMaxWater() then
		if self.itemFrom:getFluidContainer():getPrimaryFluidAmount() >= 0 then
			local toremove = 1;
			if self.itemFrom:getFluidContainer():getPrimaryFluidAmount() < 1 then
				toremove = self.itemFrom:getFluidContainer():getPrimaryFluidAmount();
			end
			self.itemFrom:getFluidContainer():removeFluid(toremove, false);

			if luaObject then
				luaObject:addWater(toremove)
			end
		end

		if self.itemFrom:getFluidContainer():getPrimaryFluidAmount() < 1 then
			if not isServer() then
				self:stop()
			else
				self.netAction:forceComplete()
			end
			self:relaunch();
		end
    else
        if not isServer() then
            self:forceStop()
        else
            self.netAction:forceComplete()
        end
    end
end

-- relaunch the action with a new water item
function ISAddWaterToTrough:relaunch()
	if self.all then
		if self.objectTo:getWater() < self.objectTo:getMaxWater() then
			local waterItems = self.character:getInventory():getAllWaterFluidSources(true);
			if not waterItems:isEmpty() then
				local waterItem = waterItems:get(0);
				ISWorldObjectContextMenu.transferIfNeeded(self.character, waterItem)
				ISWorldObjectContextMenu.equip(self.character, self.character:getPrimaryHandItem(), waterItem, true, false)
				ISTimedActionQueue.add(ISAddWaterToTrough:new(self.character, self.objectTo, waterItem, true))
			end
		end
	end
end

function ISAddWaterToTrough:update()
	self.character:faceThisObject(self.objectTo)
	self.itemFrom:setJobDelta(self:getJobDelta())
    self.character:setMetabolicTarget(Metabolics.LightDomestic)
    if not isClient() then
		self.timer = self.timer + getGameTime():getMultiplier();
		if math.floor(self.timer / self.timePerUse) > self.lastTimer then
			self.lastTimer = math.floor(self.timer / self.timePerUse);
			self:updateAddingWater();
		end
    end
    ISInventoryPage.renderDirty = true;
end

function ISAddWaterToTrough:animEvent(event, parameter)
	if isServer() then
		if event == 'AddWaterUpdate' then
			self.netAction:getProgress()
			self:updateAddingWater()
		end
	end
end

function ISAddWaterToTrough:serverStart()
	emulateAnimEvent(self.netAction, self.timePerUse * 20, "AddWaterUpdate", nil)
end

function ISAddWaterToTrough:start()
    if isClient() and self.itemFrom then
        self.itemFrom = self.character:getInventory():getItemById(self.itemFrom:getID())
    end
	self.itemFrom:setJobType(getText("IGUI_JobType_PourOut"))
	self.itemFrom:setJobDelta(0.0)

	self:setAnimVariable("PourType", self.itemFrom:getPourType());
	self:setActionAnim("Pour");
 	if not self.itemFrom:getEatType() then
		self:setOverrideHandModels(self.itemFrom:getStaticModel(), nil)
 	else
 		self:setOverrideHandModels(nil, self.itemFrom:getStaticModel())
 	end
	self.sound = self.character:playSound("AnimalFeederAddWater")
end

function ISAddWaterToTrough:stop()
	self:stopSound()
	self.itemFrom:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISAddWaterToTrough:perform()
	self:stopSound()
	if self.itemFrom then -- could be removed if we finished the action
		self.itemFrom:setJobDelta(0.0)
	end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISAddWaterToTrough:complete()
    return true
end

function ISAddWaterToTrough:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound)
	end
end

function ISAddWaterToTrough:getDuration()
    --if self.character:isTimedActionInstant() then
    --    return 1
    --end
	if isServer() then
		return -1
	end
	local amount = self.itemFrom:getFluidContainer():getPrimaryFluidAmount();
	local maxTime = (amount+1) * self.timePerUse;
	if amount + self.objectTo:getWater() > self.objectTo:getMaxWater() then
		maxTime = (self.objectTo:getMaxWater() - self.objectTo:getWater()) * self.timePerUse;
	end
    return maxTime + 1;
end

function ISAddWaterToTrough:new(character, objectTo, itemFrom, all)
	local o = ISBaseTimedAction.new(self, character)
	o.objectTo = objectTo
	o.itemFrom = itemFrom
	o.stopOnWalk = true
	o.stopOnRun = true
	o.timePerUse = 10;
	o.maxTime = o:getDuration();
	o.timer = 0;
	o.lastTimer = 0;
	o.all = all;
	return o
end    	
