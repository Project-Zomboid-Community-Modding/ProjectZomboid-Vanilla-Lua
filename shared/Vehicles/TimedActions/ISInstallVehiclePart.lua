--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISInstallVehiclePart = ISBaseTimedAction:derive("ISInstallVehiclePart")

function ISInstallVehiclePart:isValid()
	if self.character:isMechanicsCheat() then return true; end
	if isClient() and self.item then
	    return self.vehicle:canInstallPart(self.character, self.part) and self.character:getInventory():containsID(self.item:getID());
	else
	    return self.vehicle:canInstallPart(self.character, self.part) and self.character:getInventory():contains(self.item);
	end
			
--			and
--			self.vehicle:isInArea(self.part:getArea(), self.character)
end

function ISInstallVehiclePart:waitToStart()
	if self.character:isMechanicsCheat() then return false; end
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISInstallVehiclePart:update()
	self.character:faceThisObject(self.vehicle)
	self.item:setJobDelta(self:getJobDelta())

    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISInstallVehiclePart:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self.item:setJobType(getText("IGUI_Install"))

	if self.part:getWheelIndex() ~= -1 or self.part:getId():contains("Brake") then
		self:setActionAnim("VehicleWorkOnTire")
	else
		self:setActionAnim("VehicleWorkOnMid")
	end
--	self:setOverrideHandModels(nil, nil)
end

function ISInstallVehiclePart:stop()
	self.item:setJobDelta(0)
	ISBaseTimedAction.stop(self)
end

function ISInstallVehiclePart:perform()
    local pdata = getPlayerData(self.character:getPlayerNum());
    if pdata ~= nil then
       	pdata.playerInventory:refreshBackpacks();
        pdata.lootInventory:refreshBackpacks();
    end

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISInstallVehiclePart:complete()
	self.item:setJobDelta(0)
--	self.character:addMechanicsItem(self.item:getID() .. self.vehicle:getMechanicalID() .. "1", getGameTime():getCalender():getTimeInMillis());

	self.character:removeFromHands(self.item)
	self.character:getInventory():DoRemoveItem(self.item)
	sendRemoveItemFromContainer(self.character:getInventory(),self.item)

	local perksTable = VehicleUtils.getPerksTableForChr(self.part:getTable("install").skills, self.character)
   	if self.vehicle then
    	if not self.part then
    		print('no such part ',self.part)
    		return
    	end
    		local keyvalues = self.part:getTable("install");
    		local perks = keyvalues.skills;
    		local success, failure = VehicleUtils.calculateInstallationSuccess(perks, self.character, perksTable);
    		if not instanceof(self.item, "InventoryItem") then
    			print('item is nil')
    			return
    		end
    		if instanceof(self.item, "Radio") and self.item:getDeviceData() ~= nil then
    			local presets = self.item:getDeviceData():getDevicePresets()
    			self.part:getDeviceData():cloneDevicePresets(presets)
    		end
    		if ZombRand(100) < success then
    			self.part:setInventoryItem(self.item, self.character:getPerkLevel(Perks.Mechanics))
    			local tbl = self.part:getTable("install")
    			if tbl and tbl.complete then
    				VehicleUtils.callLua(tbl.complete, self.vehicle, self.part)
    			end
    			self.vehicle:transmitPartItem(self.part)
    			self.character:sendObjectChange('mechanicActionDone', { success = true})
    			self.character:addMechanicsItem(self.item:getID() .. self.vehicle:getMechanicalID() .. "1", self.part, getGameTime():getCalender():getTimeInMillis());
    		elseif ZombRand(100) < failure then
    			self.item:setCondition(self.item:getCondition() - ZombRand(5,10));
    			self.character:getInventory():AddItem(self.item);
    			sendAddItemToContainer(self.character:getInventory(), self.item);
    			playServerSound("PZ_MetalSnap", self.character:getCurrentSquare());
    			self.character:sendObjectChange('mechanicActionDone', { success = false})
    			addXp(self.character, Perks.Mechanics, 1);
    		else
    			self.character:getInventory():AddItem(self.item);
    			sendAddItemToContainer(self.character:getInventory(), self.item);
    			self.character:sendObjectChange('mechanicActionDone', { success = false})
    			addXp(self.character, Perks.Mechanics, 1);
    		end
    	else
    		print('no such vehicle id=',self.vehicle)
    	end

	return true
end

function ISInstallVehiclePart:getDuration()
    if self.character:isMechanicsCheat() or self.character:isTimedActionInstant() then
        return 1
    end
	return self.maxTime;
end

function ISInstallVehiclePart:new(character, part, item, maxTime)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.item = item
	o.maxTime = maxTime;
	o.jobType = getText("Tooltip_Vehicle_Installing", item:getDisplayName());
	return o
end

