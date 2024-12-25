--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISUninstallVehiclePart = ISBaseTimedAction:derive("ISUninstallVehiclePart")

function ISUninstallVehiclePart:isValid()
	if self.character:isMechanicsCheat() then return true; end
	return self.part:getInventoryItem() and self.vehicle:canUninstallPart(self.character, self.part)
end

function ISUninstallVehiclePart:waitToStart()
	if self.character:isMechanicsCheat() then return false; end
	self.character:faceThisObject(self.vehicle)
	return self.character:shouldBeTurning()
end

function ISUninstallVehiclePart:update()
	self.character:faceThisObject(self.vehicle)
    self.character:setMetabolicTarget(Metabolics.MediumWork);
end

function ISUninstallVehiclePart:start()
	if self.part:getWheelIndex() ~= -1 or self.part:getId():contains("Brake") then
		self:setActionAnim("VehicleWorkOnTire")
	else
		self:setActionAnim("VehicleWorkOnMid")
	end
--	self:setOverrideHandModels(nil, nil)
end

function ISUninstallVehiclePart:stop()
    ISBaseTimedAction.stop(self)
end

function ISUninstallVehiclePart:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISUninstallVehiclePart:complete()
	local perksTable = VehicleUtils.getPerksTableForChr(self.part:getTable("install").skills, self.character)
    if self.vehicle then
    	if not self.part then
    		print('no such part '..tostring(self.part))
    		return false
    	end
    	local keyvalues = self.part:getTable("install");
    	local perks = keyvalues.skills;
    	local success, failure = VehicleUtils.calculateInstallationSuccess(perks, self.character, perksTable);
    	local item = self.part:getInventoryItem()
    	if not item then
    		print('part already uninstalled ', self.part)
    		return false
    	end
    	if instanceof(item, "Radio") and item:getDeviceData() ~= nil then
    		local presets = self.part:getDeviceData():getDevicePresets()
    		item:getDeviceData():cloneDevicePresets(presets)
    	end
    	if ZombRand(100) < success then
    		self.part:setInventoryItem(nil)
    		item:setItemCapacity(self.part:getContainerContentAmount());
    		local tbl = self.part:getTable("uninstall")
    		if tbl and tbl.complete then
        		VehicleUtils.callLua(tbl.complete, self.vehicle, self.part, item)
    		end
    		self.vehicle:transmitPartItem(self.part)
    		-- this is so player don't go over inventory capacity when removing parts
    		if self.character:getInventory():hasRoomFor(self.character, item) then
    			self.character:getInventory():AddItem(item);
    			sendAddItemToContainer(self.character:getInventory(), item);
    		else
    			local square = self.character:getCurrentSquare()
    			local dropX,dropY,dropZ = ISTransferAction.GetDropItemOffset(self.character, square, item)
    			self.character:getCurrentSquare():AddWorldInventoryItem(item, dropX, dropY, dropZ);
   				ISInventoryPage.renderDirty = true
   			end
   			self.character:sendObjectChange('mechanicActionDone', { success = true})
   			self.character:addMechanicsItem(item:getID() .. self.vehicle:getMechanicalID() .. "0", self.part, getGameTime():getCalender():getTimeInMillis());
   		elseif ZombRand(failure) < 100 then
   			self.part:setCondition(self.part:getCondition() - ZombRand(5,10));
   			self.vehicle:transmitPartCondition(self.part)
   			playServerSound("PZ_MetalSnap", self.character:getCurrentSquare());
   			self.character:sendObjectChange('mechanicActionDone', { success = false})
   			addXp(self.character, Perks.Mechanics, 1);
   		end
   	else
   		print('no such vehicle id=', self.vehicle)
   	end

	return true
end

function ISUninstallVehiclePart:getDuration()
    if self.character:isMechanicsCheat() or self.character:isTimedActionInstant() then
        return 1
    end
	return self.workTime - (self.character:getPerkLevel(Perks.Mechanics) * (self.workTime/15));
end

function ISUninstallVehiclePart:new(character, part, workTime)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.workTime = workTime
	o.maxTime = o:getDuration();
	o.jobType = getText("Tooltip_Vehicle_Uninstalling", part:getInventoryItem():getDisplayName());
	return o
end

